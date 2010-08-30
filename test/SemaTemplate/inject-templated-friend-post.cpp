// RUN: %clang %s -S -emit-llvm -o - | grep -e "define linkonce_odr.*_ZlsR11std_ostreamRK8StreamerI3FooE"
// RUN: %clang -cc1 %s -DREDEFINE -verify
// PR8007: friend function not instantiated, reordered version.
// Corresponds to http://gcc.gnu.org/bugzilla/show_bug.cgi?id=38392
// XFAIL: *

struct std_ostream
{
  int dummy;
};

std_ostream cout;

template <typename STRUCT_TYPE>
struct Streamer;

typedef struct Foo {} Foo;

std_ostream& operator << (std_ostream&, const Streamer<Foo>&);
void test(const Streamer<Foo>& foo)
{
    cout << foo;
}

template <typename STRUCT_TYPE>
struct Streamer
{
    friend std_ostream& operator << (std_ostream& o, const Streamer& f) // expected-error{{redefinition of 'operator<<'}}
        {
            Streamer s(f);
            s(o);
            return o;
        }

    Streamer(const STRUCT_TYPE& s) : s(s) {}

    const STRUCT_TYPE& s;
    void operator () (std_ostream&) const;
};

template <>
void Streamer<Foo>::operator () (std_ostream& o) const // expected-note{{requested here}}
{
}

int main(void)
{
    Foo foo;
    test(foo);
}

#ifdef REDEFINE
std_ostream& operator << (std_ostream& o, const Streamer<Foo>&) // expected-note{{is here}}
{
  // Sema should flag this as a redefinition
  return o;
}
#endif