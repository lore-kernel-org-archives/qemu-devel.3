Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536A1C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 15:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOIUm-0003M1-6a; Mon, 01 Jul 2024 10:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOIUj-0003HM-2I
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:59:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOIUg-0004vD-67
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719845941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Jg2YGBQJvxdBebsUu4RYgkViIJm4O2ffOHiDEzRB7LQ=;
 b=WEX+agjCsjJqQqatyBQZQafAKYD8fu3KDwBqFcN11PeJ57ywKunwQRjLUYxMH59U627WBz
 SBazmP3pR5VWRvooVBLbpJexhaD3aynM9J5FPEDhkG1XgfvJB4dRbDR7tEvvoYOFh/SOiF
 lQYr765YArpERoqS8tlu9so0GPIYfNc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-aOTOgO9fPzu8LEJEMMMLhA-1; Mon, 01 Jul 2024 10:58:59 -0400
X-MC-Unique: aOTOgO9fPzu8LEJEMMMLhA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3634a25a7beso1930762f8f.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 07:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719845937; x=1720450737;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jg2YGBQJvxdBebsUu4RYgkViIJm4O2ffOHiDEzRB7LQ=;
 b=IVUjMK7f0wFzKBrTx3MlE5gcsmN2GYjn3Z3TGHs+1QSR1Sh2IJQXLdDxAxVfAZUp/p
 1O5U0mfiypSEQV1mTpi1tnVmytLK7emW5Eq0baFZ8qF8ONL3wrrN7KvcI/3gC83sF9N3
 8TtlY82r1V8yy26cVTPub+lb+eoLATGyt/5tBWjkp03EAQhWNPqkF6NyH3kN6X5F7P2z
 rXu+8CghARFJ407hSy1EEfDlcQ0Bw9/oDbUMqNOQkT9V4c41wpzSTUJnje8vg9ddHYSD
 gs6Oj9g68yEL5rIqVOy1pgyPTkBYA+6RFZULx+0xkakFsk3868eH22FVQ7IYRA8byt2L
 +DUA==
X-Gm-Message-State: AOJu0YxhLU3byx7VtZR9CTyD83+i55lnq4Gj2TgxDaCMmaZpYuaJHavI
 IIP0bReAR01ppAgm19Oe76lljc1MZHr22YjLksMh50b2PSB4hY8+FnrT3JHQaj1LM3biKbbS0aT
 w3nMqu77hFc6zmSX5BqmO+4wzPNuFV2Qc3XG+OssR9MCfANGoaSHsuw+PUysec2X/VJ/8P0Xv+/
 B8AC1fVHfPtTbZCmLjGt9VHQv5zfmP+OFMMqXf
X-Received: by 2002:a05:6000:b44:b0:366:eb2f:4f81 with SMTP id
 ffacd0b85a97d-3677571e245mr3746471f8f.45.1719845936845; 
 Mon, 01 Jul 2024 07:58:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgVF3wnLEFFhkzfa2Sdf54LgWfM2nDGS9ef8sFs98GuMCEzizZ50UjjJcpMBsb5suYdwXNWQ==
X-Received: by 2002:a05:6000:b44:b0:366:eb2f:4f81 with SMTP id
 ffacd0b85a97d-3677571e245mr3746449f8f.45.1719845936292; 
 Mon, 01 Jul 2024 07:58:56 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a10302fsm10229054f8f.93.2024.07.01.07.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 07:58:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 00/14] rust: example of bindings code for Rust in QEMU
Date: Mon,  1 Jul 2024 16:58:32 +0200
Message-ID: <20240701145853.1394967-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi all,

this is an example of what some bindings code for QEMU would look like.
Note that some parts of this code are barely expected to compile, and
are probably full of bugs, but still should look like finished code
(in fact, because they compile, the type system parts should be okay;
though a conditional "should" is required).

This code is not integrated in the QEMU source tree, because again it
is just a example of what kind of Rust code would exist to handle the
C<->Rust FFI.  The translation of a handful of C structs and function
prototypes is done by hand rather than with bindgen, in particular.

The patches are organized as follows:

Patches 1-2 introduce the skeleton for the rest of the code and are
not particularly interesting, since that skeleton would be provided
by the patches that introduce Rust usage in QEMU.


Patches 3-4 define common code to handle conversion of data structures
between Rust and C.  I couldn't find an existing crate to do this,
though there are similar concepts in glib-rs.  The crate defines
variants of Clone, From and Into that convert a Rust struct to a
C pointer, for example:

   let s = "abc".clone_to_foreign();        // mallocs a NULL-terminated copy
   let p = s.as_ptr();
   drop(s);                                 // p is freed now

or the other way round:

   let s = String::cloned_from_foreign(p);  // p is a *const c_char

   let t: String = p.into_native();         // p is a *mut c_char and is free()d

The second patch defines what you need to convert strings from and to
C.  It's used by tests but also by a couple of QOM functions implemented
below; it lets you forget the differences between String, &str, CString,
&CStr and Cow<'_, str>.

This is the only complete part of the skeleton (in fact I wrote it
a couple years ago), and it comes with testcases that pass in both
"#[test]" and "doctest" (i.e. snippets integrated in the documentation
comments) styles.


Patch 5 (mostly complete except for &error_abort support and missing
tests) allows using the above functionality for the QEMU Error*.


Patches 6-8 provide an example of how to use QOM from Rust.  They
define all the functionality to:

- handle reference counting

- handle typesafe casting (i.e. code doesn't compile if an upcast
  is invalid, or if a downcast cannot possibly succeed).

- faking inheritance since Rust doesn't support it.

While I started with some implementation ideas in glib-rs, this has
evolved quite a bit and doesn't really look much like glib-rs anymore.
I provided a handful of functions to wrap C APIs.  For example:

   object_property_add_child(obj, "foo", object_new(TYPE_BLAH))

becomes

   obj.property_add_child("foo", Blah::new());

... except that the former leaks a reference and the latter does not
(gotcha :)).  The idea is that these functions would be written, in
general, as soon as Rust code uses them, but I included a few as an
example of using the various abstractions for typecasting, reference
counting, and converting from/to C data strcutures.

A large part of this code is of the "it compiles and it looks nice, it
must be perfect" kind.  Rust is _very_ picky on type safety, in case you
didn't know.  One day we're all going to be programming in Haskell,
without even noticing it.


Patches 9-10 deal with how to define new subclasses in Rust.  They are
a lot less polished and less ready.  There is probably a lot of polish
that could be applied to make the code look nicer, but I guess there is
always time to make the code look nicer until the details are sorted out.

The things that I considered here are:

- splitting configuration from runtime state.  Configuration is
  immutable throughout the lifetime of the object, and holds the
  value of user-configured properties.  State will typically be a
  Mutex<> or RefCell<> since the QOM bindings make wide use of interior
  mutability---almost all functions are declared as &self---following
  the lead of glib-rs.

- automatic generation of instance_init and instance_finalize.  For
  this I opted to introduce a new initialization step that is tailored to
  Rust, called instance_mem_init(), that is executed before the default
  value of properties is set.  This makes sure that user code only ever
  sees valid values for the whole struct, including after a downcast;
  it matters because some Rust types (notably references) cannot be
  initialized to a zero-bytes pattern.  The default implementation of
  instance_mem_init is simply a memset(), since the callback replaces the

    memset(obj, 0, type->instance_size);

  line in object_initialize_with_type().  I have prototyped this change
  in QEMU already.

- generation of C vtables from safe code that is written in Rust. I
  chose a trait that only contains associated constants as a way to
  access the vtables generically.  For example:

    impl ObjectImpl for TestDevice {
        const UNPARENT: Option<fn(&TestDevice)> = Some(TestDevice::unparent);
    }

    impl DeviceImpl for TestDevice {
        const REALIZE: Option<fn(&TestDevice) -> Result<()>> = Some(TestDevice::realize);
    }

  This works and it seems like a style that (in the future) we could apply
  macro or even procedural macro magic to.

- generation of qdev property tables.  While only boolean properties are
  implemented here, one idea that I experimented with, is that the
  default value of properties is derived from the ConstDefault trait.
  (ConstDefault is provided by the const_default external crate).  Again,
  this is material for future conversion to procedural macros.

I absolutely didn't look at vmstate, but it shouldn't be too different
from properties, at least for the common cases.


Patches 11-14 finally are an example of the changes that are needed
to respect a minimum supported Rust version consistent with what is in
Debian Bullseye.  It's not too bad, especially since the current version
of the QOM bindings does not require generic associated types anymore.


Why am I posting this?  Because this kind of glue code is the ultimate
source of technical debt.  It is the thing that we should be scared of
when introducing a new language in QEMU.  It makes it harder to change C
code, and it is hard to change once Rust code becomes more widespread.
If we think a C API is not fully baked, we probably shouldn't write
Rust code that uses it (including bindings code).  If we think a Rust
API is not fully baked, we probably shouldn't add too much Rust code
that uses it.

We should have an idea of what this glue code looks like, in order to make
an informed choice.  If we think we're not comfortable with reviewing it,
well, we should be ready to say so and stick with C until we are.

The alternative could be to use Rust without this kind of binding.  I
think it's a bad idea.  It removes many of the advantages of Rust 
(which are exemplified by the above object_property_add_child one-liner),
and it also introduces _new_ kinds of memory errors, since Rust has
its own undefined behavior conditions that are not there in C/C++.
For example:

    impl Struct {
        pub fn f(&self) {
            call_some_c_function(Self::g, self as *const Self as *mut _);
        }

        fn do_g(&mut self) {
            ...
        }

        extern "C" fn g(ptr: *mut Self) {
            unsafe { &mut *ptr }.do_g();
        }
    }

is invalid because a &mut reference (exclusive) is alive at the same time
as a & reference (shared).  It is left as an exercise to the reader to
figure out all the possible ways in which we can shoot our own feet,
considering the pervasive use of callbacks in QEMU.


With respect to callbacks, that's something that is missing in this
prototype.  Fortunately, that's also something that will be tackled very
soon if the PL011 example is merged, because memory regions and character
devices both introduce them.  Also, as I understand it, Rust code using
callbacks is not particularly nice anyway, though it is of course doable.
Instead, this exercise are about being able to write *nice* Rust code,
with all the advantages provided by the language, and the cost of
writing/maintaining the glue code that makes it possible.  I expect
that we'll use a technique similar to the extern_c crate (it's 20 lines of
code; https://docs.rs/crate/extern-c/) to convert something that implements
Fn(), including a member function, into an extern "C" function.


Anyhow: I think we can do it, otherwise I would not have written 2000 lines
of code (some of it two or three times).  But if people are now scared and
think we shouldn't, well, that's also a success of its own kind.

Paolo


Paolo Bonzini (14):
  add skeleton
  set expectations
  rust: define traits and pointer wrappers to convert from/to C
    representations
  rust: add tests for util::foreign
  rust: define wrappers for Error
  rust: define wrappers for basic QOM concepts
  rust: define wrappers for methods of the QOM Object class
  rust: define wrappers for methods of the QOM Device class
  rust: add idiomatic bindings to define Object subclasses
  rust: add idiomatic bindings to define Device subclasses
  rust: replace std::ffi::c_char with libc::c_char
  rust: replace c"" literals with cstr crate
  rust: introduce alternative to offset_of!
  rust: use version of toml_edit that does not require new Rust

-- 
2.45.2



