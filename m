Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14B7C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 10:29:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgLb6-0005rv-CP; Fri, 07 Feb 2025 05:28:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgLb0-0005qv-3d
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 05:28:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgLav-00081J-MZ
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 05:28:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738924101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/m4Y6I3ut+KzJXLcmeRloD8TLoCZv0Lw4/PntSUSggo=;
 b=KCOa4vA4DGd3HEKTaWkNOqXEfT225SuPPy7oH+y6FY7j4OiLgV+i/xlmLoHiRiCRl66R7n
 BslQOMbm8FGFxwAVnCGMNeldvRtfizidbhyCFT/TOfC3mLODm+N7itvy7h7X04UR4KMeeN
 KbM5FTKiANEJdsXvdA/zn0bI9Mm95hU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-pOwLQB6VPkm9i9aXgJQvtw-1; Fri, 07 Feb 2025 05:28:19 -0500
X-MC-Unique: pOwLQB6VPkm9i9aXgJQvtw-1
X-Mimecast-MFC-AGG-ID: pOwLQB6VPkm9i9aXgJQvtw
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ab39f65dc10so226556966b.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 02:28:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738924097; x=1739528897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/m4Y6I3ut+KzJXLcmeRloD8TLoCZv0Lw4/PntSUSggo=;
 b=QzhPQlHy6tgMix3LPecIVkVUpEoy4QQlr0SyjLweCG1hJjB5NSf3hX8OunkEtN8/dz
 /4k48BGGEoZPCfmpz4AO09PsTW6v7QFfeyTboXkyRsPvkWfJaitydIAUcfnCuFIks6jk
 vXCK0nLrOmRQHUng9x6xlEpsng8BaZBSDFXpXSVtlHyRyHa1bV0tnFXV8jABIt4G6wK+
 xGQGD3dwwQgY3eyixWRB2vol2r5zdJFJV9YrmLb+tq+iWeAf5NEQn1MtOfO6tVvUHt4s
 dJdDMJbjpeqZbCgHWt0hlgoMqpo6VcewJRF3mhVeeeKqX/DlLHypKZo+mNs6anSX+3Da
 CXog==
X-Gm-Message-State: AOJu0Yx1lyWtKn8WErhGkKat7X/d/o3VFai8Faz79590kobYRGuxzIk7
 Px4ceYm9ziQ71vFXyrvPH+YNFtgHUgLOm+SyOp0gZ+7BdZ1U9s5U2TIuW1KwIv0ueQGnNZflJvg
 0Wr7kz86/UIfbtbc4FmzXrskXe+2z7LvRUvlfDSMWIzizvyPUArJ/u7NLW4fpsVDnz/SWgyKrhK
 Z7I7aYCIudBB8iz78ISVt52YzfiFqyoG7aQjvpvTA=
X-Gm-Gg: ASbGncsGG20+N5xoaGcMop0g0/Rq7vua8tIm6rxOMX13nDsCONY4r3PW0loESIocFwg
 SEAkFB+pFgTcU4KPBb2GBcd/jZY9P25SdnStL6TNO+JNeLvnpJ2hTTKDDTCEmSdSlVRfCjqXB98
 tCZ5f0huDCn72SB68V3hEHOg7+X658UbtVvydF1yZINYl1ogladYNrEV3k2BKkVzvwcjyWloUhb
 zXLBoPjirPwpz3HZHz3ThsjmqgCpEpjU29bEMUy8TSpmKE8ggPx4TrarMjjv0AtzJMEzkPHsC5K
 s6+g4Q==
X-Received: by 2002:a17:907:7f08:b0:ab6:9d92:6d6 with SMTP id
 a640c23a62f3a-ab789bca602mr216736266b.26.1738924096409; 
 Fri, 07 Feb 2025 02:28:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6k10OXFnGC/rsLYMFM986SCafWEkk+6Sm76IiRlBJSOuUtcZbJQicu+v9WPmy2I3fC3rjxA==
X-Received: by 2002:a17:907:7f08:b0:ab6:9d92:6d6 with SMTP id
 a640c23a62f3a-ab789bca602mr216730766b.26.1738924095365; 
 Fri, 07 Feb 2025 02:28:15 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab7732e702fsm241623966b.107.2025.02.07.02.28.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 02:28:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/7] rust: add docs
Date: Fri,  7 Feb 2025 11:27:57 +0100
Message-ID: <20250207102802.2445596-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207102802.2445596-1-pbonzini@redhat.com>
References: <20250207102802.2445596-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/index-process.rst |   1 +
 docs/devel/rust.rst          | 425 +++++++++++++++++++++++++++++++++++
 tests/lcitool/libvirt-ci     |   2 +-
 3 files changed, 427 insertions(+), 1 deletion(-)
 create mode 100644 docs/devel/rust.rst

diff --git a/docs/devel/index-process.rst b/docs/devel/index-process.rst
index 362f97ee300..cb7c6640fd2 100644
--- a/docs/devel/index-process.rst
+++ b/docs/devel/index-process.rst
@@ -17,3 +17,4 @@ Notes about how to interact with the community and how and where to submit patch
    stable-process
    submitting-a-pull-request
    secure-coding-practices
+   rust
diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
new file mode 100644
index 00000000000..7d67ac591f9
--- /dev/null
+++ b/docs/devel/rust.rst
@@ -0,0 +1,425 @@
+.. |msrv| replace:: 1.63.0
+
+Rust in QEMU
+============
+
+Rust in QEMU is a project to enable using the Rust programming language
+to add new functionality to QEMU.
+
+Right now, the focus is on making it possible to write devices that inherit
+from ``SysBusDevice`` in `*safe*`__ Rust.  Later, it may become possible
+to write other kinds of devices (e.g. PCI devices that can do DMA),
+complete boards, or backends (e.g. block device formats).
+
+__ https://doc.rust-lang.org/nomicon/meet-safe-and-unsafe.html
+
+Building the Rust in QEMU code
+------------------------------
+
+The Rust in QEMU code is included in the emulators via Meson.  Meson
+invokes rustc directly, building static libraries that are then linked
+together with the C code.  This is completely automatic when you run
+``make`` or ``ninja``.
+
+However, QEMU's build system also tries to be easy to use for people who
+are accustomed to the more "normal" Cargo-based development workflow.
+In particular:
+
+* the set of warnings and lints that are used to build QEMU always
+  comes from the ``rust/Cargo.toml`` workspace file
+
+* it is also possible to use ``cargo`` for common Rust-specific coding
+  tasks, in particular to invoke ``clippy``, ``rustfmt`` and ``rustdoc``.
+
+To this end, QEMU includes a ``build.rs`` build script that picks up
+generated sources from QEMU's build directory and puts it in Cargo's
+output directory (typically ``rust/target/``).  A vanilla invocation
+of Cargo will complain that it cannot find the generated sources,
+which can be fixed in different ways:
+
+* by using special shorthand targets in the QEMU build directory::
+
+    make clippy
+    make rustfmt
+    make rustdoc
+
+* by invoking ``cargo`` through the Meson `development environment`__
+  feature::
+
+    pyvenv/bin/meson devenv -w ../rust cargo clippy --tests
+    pyvenv/bin/meson devenv -w ../rust cargo fmt
+
+  If you are going to use ``cargo`` repeatedly, ``pyvenv/bin/meson devenv``
+  will enter a shell where commands like ``cargo clippy`` just work.
+
+__ https://mesonbuild.com/Commands.html#devenv
+
+* by pointing the ``MESON_BUILD_ROOT`` to the top of your QEMU build
+  tree.  This third method is useful if you are using ``rust-analyzer``;
+  you can set the environment variable through the
+  ``rust-analyzer.cargo.extraEnv`` setting.
+
+As shown above, you can use the ``--tests`` option as usual to operate on test
+code.  Note however that you cannot *build* or run tests via ``cargo``, because
+they need support C code from QEMU that Cargo does not know about.  Tests can
+be run via ``meson test`` or ``make``::
+
+   make check-rust
+
+Building Rust code with ``--enable-modules`` is not supported yet.
+
+Supported tools
+'''''''''''''''
+
+QEMU supports rustc version 1.63.0 and newer.  Notably, the following features
+are missing:
+
+* ``core::ffi`` (1.64.0).  Use ``std::os::raw`` and ``std::ffi`` instead.
+
+* ``cast_mut()``/``cast_const()`` (1.65.0).  Use ``as`` instead.
+
+* "let ... else" (1.65.0).  Use ``if let`` instead.  This is currently patched
+  in QEMU's vendored copy of the bilge crate.
+
+* Generic Associated Types (1.65.0)
+
+* ``CStr::from_bytes_with_nul()`` as a ``const`` function (1.72.0).
+
+* "Return position ``impl Trait`` in Traits" (1.75.0, blocker for including
+  the pinned-init create).
+
+* ``MaybeUninit::zeroed()`` as a ``const`` function (1.75.0).  QEMU's
+  ``Zeroable`` trait can be implemented without ``MaybeUninit::zeroed()``,
+  so this would be just a cleanup.
+
+* ``c"" literals`` (stable in 1.77.0).  QEMU provides a ``c_str!()`` macro
+  to define ``CStr`` constants easily
+
+* ``offset_of!`` (stable in 1.77.0).  QEMU uses ``offset_of!()`` heavily; it
+  provides a replacement in the ``qemu_api`` crate, but it does not support
+  lifetime parameters and therefore ``&'a Something`` fields in the struct
+  may have to be replaced by ``NonNull<Something>``.  *Nested* ``offset_of!``
+  was only stabilized in Rust 1.82.0, but it is not used.
+
+* inline const expression (stable in 1.79.0), currently worked around with
+  associated constants in the ``FnCall`` trait.
+
+* associated constants have to be explicitly marked ``'static`` (`changed in
+  1.81.0`__)
+
+* ``&raw`` (stable in 1.82.0).  Use ``addr_of!`` and ``addr_of_mut!`` instead,
+  though hopefully the need for raw pointers will go down over time.
+
+* ``new_uninit`` (stable in 1.82.0).  This is used internally by the ``pinned_init``
+  crate, which is planned for inclusion in QEMU, but it can be easily patched
+  out.
+
+* referencing statics in constants (stable in 1.83.0).  For now use a const
+  function; this is an important limitation for QEMU's migration stream
+  architecture (VMState).  Right now, VMState lacks type safety because
+  it is hard to place the ``VMStateField`` definitions in traits.
+
+* associated const equality would be nice to have for some users of
+  ``callbacks::FnCall``, but is still experimental.  ``ASSERT_IS_SOME``
+  replaces it.
+
+__ https://github.com/rust-lang/rust/pull/125258
+
+It is expected that QEMU will advance its minimum supported version of
+rustc to 1.77.0 as soon as possible; as of January 2025, blockers
+for that right now are Debian bookworm and 32-bit MIPS processors.
+This unfortunately means that references to statics in constants will
+remain an issue.
+
+QEMU also supports version 0.60.x of bindgen, which is missing option
+``--generate-cstr``.  This option requires version 0.66.x and will
+be adopted as soon as supporting these older versions is not necessary
+anymore.
+
+Writing Rust code in QEMU
+-------------------------
+
+Right now QEMU includes three crates:
+
+* ``qemu_api`` for bindings to C code and useful functionality
+
+* ``qemu_api_macros`` defines several procedural macros that are useful when
+  writing C code
+
+* ``pl011`` (under ``rust/hw/char/pl011``) is the sample device that is being
+  used to further develop ``qemu_api`` and ``qemu_api_macros``.  It is a functional
+  replacement for the ``hw/char/pl011.c`` file.
+
+This section explains how to work with them.
+
+Status
+''''''
+
+Modules of ``qemu_api`` can be defined as:
+
+- *complete*: ready for use in new devices; if applicable, the API supports the
+  full functionality available in C
+
+- *stable*: ready for production use, the API is safe and should not undergo
+  major changes
+
+- *proof of concept*: the API is subject to change but allows working with safe
+  Rust
+
+- *initial*: the API is in its initial stages; it requires large amount of
+  unsafe code; it might have soundness or type-safety issues
+
+The status of the modules are
+
+================ ======================
+module           status
+================ ======================
+``assertions``   stable
+``bitops``       complete
+``callbacks``    complete
+``cell``         stable
+``c_str``        complete
+``irq``          complete
+``module``       complete
+``offset_of``    stable
+``qdev``         stable
+``qom``          stable
+``sysbus``       stable
+``vmstate``      proof of concept
+``zeroable``     stable
+================ ======================
+
+Common pitfalls
+'''''''''''''''
+
+Rust has very strict rules with respect to how you get an exclusive (``&mut``)
+reference; failure to respect those rules is a source of undefined behavior.
+In particular, even if a value is loaded from a raw mutable pointer (``*mut``),
+it *cannot* be casted to ``&mut`` unless the value was stored to the ``*mut``
+from a mutable reference.  Furthermore, it is undefined behavior if any
+shared reference was created between the store to the ``*mut`` and the load::
+
+    let mut p: u32 = 42;
+    let p_mut = &mut p;                              // 1
+    let p_raw = p_mut as *mut u32;                   // 2
+
+    // p_raw keeps the mutable reference "alive"
+
+    let p_shared = &p;                               // 3
+    println!("access from &u32: {}", *p_shared);
+
+    // Bring back the mutable reference, its lifetime overlaps
+    // with that of a shared reference.
+    let p_mut = unsafe { &mut *p_raw };              // 4
+    println!("access from &mut 32: {}", *p_mut);
+
+    println!("access from &u32: {}", *p_shared);     // 5
+
+These rules can be tested with `MIRI`__, for example.
+
+__ https://github.com/rust-lang/miri
+
+Almost all Rust code in QEMU will involve QOM objects, and pointers to these
+objects are *shared*, for example because they are part of the QOM composition
+tree.  This creates exactly the above scenario:
+
+1. a QOM object is created
+
+2. a ``*mut`` is created, for example as the opaque value for a ``MemoryRegion``
+
+3. the QOM object is placed in the composition tree
+
+4. a memory access dereferences the opaque value to a ``&mut``
+
+5. but the shared reference is still present in the composition tree
+
+Because of this, QOM objects should almost always use ``&self`` instead
+of ``&mut self``; access to internal fields must use *interior mutability*
+to go from a shared reference to a ``&mut``.
+
+Whenever C code provides you with an opaque ``void *``, avoid converting it
+to a Rust mutable reference, and use a shared reference instead.  Rust code
+will then have to use QEMU's ``BqlRefCell`` and ``BqlCell`` type, which
+enforce that locking rules for the "Big QEMU Lock" are respected.  These cell
+types are also known to the ``vmstate`` crate, which is able to "look inside"
+them when building an in-memory representation of a ``struct``s layout.
+Note that the same is not true of a ``RefCell`` or ``Mutex``.
+
+In the future, similar cell types might also be provided for ``AioContext``-based
+locking as well.
+
+Writing bindings to C code
+''''''''''''''''''''''''''
+
+Here are some things to keep in mind when working on the ``qemu_api`` crate.
+
+**Look at existing code**
+  Very often, similar idioms in C code correspond to similar tricks in
+  Rust bindings.  If the C code uses ``offsetof``, look at qdev properties
+  or ``vmstate``.  If the C code has a complex const struct, look at
+  ``MemoryRegion``.  Reuse existing patterns for handling lifetimes;
+  for example use ``&T`` for QOM objects that do not need a reference
+  count (including those that can be embedded in other objects) and
+  ``Owned<T>`` for those that need it.
+
+**Use the type system**
+  Bindings often will need access information that is specific to a type
+  (either a builtin one or a user-defined one) in order to pass it to C
+  functions.  Put them in a trait and access it through generic parameters.
+  The ``vmstate`` module has examples of how to retrieve type information
+  for the fields of a Rust ``struct``.
+
+**Prefer unsafe traits to unsafe functions**
+  Unsafe traits are much easier to prove correct than unsafe functions.
+  They are an excellent place to store metadata that can later be accessed
+  by generic functions.  C code usually places metadata in global variables;
+  in Rust, they can be stored in traits and then turned into ``static``
+  variables.  Often, unsafe traits can be generated by procedural macros.
+
+**Document limitations due to old Rust versions**
+  If you need to settle for an inferior solution because of the currently
+  supported set of Rust versions, document it in the source and in this
+  file.  This ensures that it can be fixed when the minimum supported
+  version is bumped.
+
+**Keep locking in mind**.
+  When marking a type ``Sync``, be careful of whether it needs the big
+  QEMU lock.  Use ``BqlCell`` and ``BqlRefCell`` for interior data,
+  or assert ``bql_locked()``.
+
+**Don't be afraid of complexity, but document and isolate it**
+  It's okay to be tricky; device code is written more often than bindings
+  code and it's important that it is idiomatic.  However, you should strive
+  to isolate any tricks in a place (for example a ``struct``, a trait
+  or a macro) where it can be documented and tested.  If needed, include
+  toy versions of the code in the documentation.
+
+Writing procedural macros
+'''''''''''''''''''''''''
+
+By conventions, procedural macros are split in two functions, one
+returning ``Result<proc_macro2::TokenStream, MacroError>` with the body of
+the procedural macro, and the second returning ``proc_macro::TokenStream``
+which is the actual procedural macro.  The former's name is the same as
+the latter with the ``_or_error`` suffix.  The code for the latter is more
+or less fixed; it follows the following template, which is fixed apart
+from the type after ``as`` in the invocation of ``parse_macro_input!``::
+
+    #[proc_macro_derive(Object)]
+    pub fn derive_object(input: TokenStream) -> TokenStream {
+        let input = parse_macro_input!(input as DeriveInput);
+        let expanded = derive_object_or_error(input).unwrap_or_else(Into::into);
+
+        TokenStream::from(expanded)
+    }
+
+The ``qemu_api_macros`` crate has utility functions to examine a
+``DeriveInput`` and perform common checks (e.g. looking for a struct
+with named fields).  These functions return ``Result<..., MacroError>``
+and can be used easily in the procedural macro function::
+
+    fn derive_object_or_error(input: DeriveInput) ->
+        Result<proc_macro2::TokenStream, MacroError>
+    {
+        is_c_repr(&input, "#[derive(Object)]")?;
+
+        let name = &input.ident;
+        let parent = &get_fields(&input, "#[derive(Object)]")?[0].ident;
+        ...
+    }
+
+Use procedural macros with care.  They are mostly useful for two purposes:
+
+* Performing consistency checks; for example ``#[derive(Object)]`` checks
+  that the structure has ``#[repr[C])`` and that the type of the first field
+  is consistent with the ``ObjectType`` declaration.
+
+* Extracting information from Rust source code into traits, typically based
+  on types and attributes.  For example, ``#[derive(TryInto)]`` builds an
+  implementation of ``TryFrom``, and it uses the ``#[repr(...)]`` attribute
+  as the ``TryFrom`` source and error types.
+
+Procedural macros can be hard to debug and test; if the code generation
+exceeds a few lines of code, it may be worthwhile to delegate work to
+"regular" declarative (``macro_rules!``) macros and write unit tests for
+those instead.
+
+
+Coding style
+''''''''''''
+
+Code should pass clippy and be formatted with rustfmt.
+
+Right now, only the nightly version of ``rustfmt`` is supported.  This
+might change in the future.  While CI checks for correct formatting via
+``cargo fmt --check``, maintainers can fix this for you when applying patches.
+
+It is expected that ``qemu_api`` provides full ``rustdoc`` documentation for
+bindings that are in their final shape or close.
+
+Adding dependencies
+-------------------
+
+Generally, the set of dependent crates is kept small.  Think twice before
+adding a new external crate, especially if it comes with a large set of
+dependencies itself.  Sometimes QEMU only needs a small subset of the
+functionality; see for example QEMU's ``assertions`` or ``c_str`` modules.
+
+On top of this recommendation, adding external crates to QEMU is a
+slightly complicated process, mostly due to the need to teach Meson how
+to build them.  While Meson has initial support for parsing ``Cargo.lock``
+files, it is still highly experimental and is therefore not used.
+
+First of all, the crate must be added to the relevant ``Cargo.toml`` files.
+External crates must be added as subprojects for Meson to learn how to
+build them, as well as to the relevant ``Cargo.toml`` files.  Because the
+``rust/`` directory forms a Cargo `workspace`__, there is a single
+``rust/Cargo.lock`` file for the whole build.
+
+__ https://doc.rust-lang.org/cargo/reference/workspaces.html#virtual-workspace
+
+Choose a version of the crate that works with QEMU's minimum supported
+Rust version (|msrv|).
+
+Second, a new ``wrap`` file must be added to teach Meson how to download the
+crate.  The wrap file must be named ``NAME-SEMVER-rs.wrap``, where ``NAME``
+is the name of the crate and ``SEMVER`` is the version up to and including the
+first non-zero number.  For example, a crate with version ``0.2.3`` will use
+``0.2`` for its ``SEMVER``, while a crate with version ``1.0.84`` will use ``1``.
+
+Third, the Meson rules to build the crate must be added at
+``subprojects/NAME-SEMVER-rs/meson.build``.  Generally this includes:
+
+* ``subproject`` and ``dependency`` lines for all dependent crates
+
+* a ``static_library`` or ``rust.proc_macro`` line to perform the actual build
+
+* ``declare_dependency`` and a ``meson.override_dependency`` lines to expose
+  the result to QEMU and to other subprojects
+
+Remember to add ``native: true`` to ``dependency``, ``static_library`` and
+``meson.override_dependency`` for dependencies of procedural macros.
+If a crate is needed in both procedural macros and QEMU binaries, everything
+apart from ``subproject`` must be duplicated to build both native and
+non-native versions of the crate.
+
+It's important to specify the right compiler options.  These include:
+
+* the language edition (which can be found in the ``Cargo.toml`` file)
+
+* the ``--cfg`` (which have to be "reverse engineered" from the ``build.rs``
+  file of the crate).
+
+* usually, a ``--cap-lints allow`` argument to hide warnings from rustc
+  or clippy.
+
+After every change to the ``meson.build`` file you have to update the patched
+version with ``meson subprojects update --reset ``NAME-SEMVER-rs``.  This might
+be automated in the future.
+
+Also, after every change to the ``meson.build`` file it is strongly suggested to
+do a dummy change to the ``.wrap`` file (for example adding a comment like
+``# version 2``), which will help Meson notice that the subproject is out of date.
+
+As a last step, add the new subproject to ``scripts/archive-source.sh``,
+``scripts/make-release`` and ``subprojects/.gitignore``.
diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
index b6a65806bc9..9ad3f70bde9 160000
--- a/tests/lcitool/libvirt-ci
+++ b/tests/lcitool/libvirt-ci
@@ -1 +1 @@
-Subproject commit b6a65806bc9b2b56985f5e97c936b77c7e7a99fc
+Subproject commit 9ad3f70bde9865d5ad18f36d256d472e72b5cbf3
-- 
2.48.1


