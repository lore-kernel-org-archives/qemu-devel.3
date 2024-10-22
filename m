Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0562D1CDCB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 10:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3BqU-0004sX-2N; Tue, 22 Oct 2024 06:10:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3BqM-0004sD-F4
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:10:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3BqJ-0004O1-GK
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729591822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FhAct4q18ImXFIsWNk2smwgX1VzeDjNJvhYscWcGBhY=;
 b=ehLKCrcbpel7YcafEFxnSPUOA+mezi2WVvU2zO3YTGbdQSEGbe+2VxZ3Ryw8aFo+9lmgyE
 Ae/NlA2Nl6fBS1JIwQqriYdmYDkIQNismsBEUv9mrMlvzi7M3KjwQslVlYncvhFJnhFt9f
 qQ8HR010vDP/KkJNRKAsbFqQ/GBZRPE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-HSM7FzGbMFWdl4WtJo0cuw-1; Tue, 22 Oct 2024 06:10:21 -0400
X-MC-Unique: HSM7FzGbMFWdl4WtJo0cuw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4315d98a873so36909055e9.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 03:10:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729591819; x=1730196619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FhAct4q18ImXFIsWNk2smwgX1VzeDjNJvhYscWcGBhY=;
 b=geNrDPU8nL25EgmZM/nS4JdfBg7Ea5Qho9oHU3n4Ld7h7TBLR8ouoE0HJ0zQqk8gO2
 /XxBq1jrxNGaB/pACLyqKs8SW35+1HyzW26jrl/cjPpK169EnJ4MKs5QcfV+moP61DcE
 00zGaKGGlrjZMnIy8m0TWqNhYJGXYTm0/QD1ypttuOPc7PknDeD9Xb7aDz8t/+vst/zM
 2gYhGA1trDbGqbi1O2vs8JfuFhL5lRc+NwGFWJVgCj0pjX9hM5s0cEjgi4fgSTuqPNBp
 o3wCTe8Ri6x1OvSmsVAz11rxf2lKIrV5Sv5br8GwZLH7AjDljb75eijrENh8BsArBYSD
 lhNQ==
X-Gm-Message-State: AOJu0Yyf3/unVNI/uH80Zi724cT9kVDJ2usBSVuPJx0frXOVChOzpch8
 u4oENVxeMHVwJWJvBbp+dwCSQDOfGw1ndJllMcWcuo2INwsfP+sPGzn1+x7K+/y+OeppFE9V716
 OWKPK1hfyh/AXVgvyRz0H/ofsbJxn9zFlUgU+HgQD/i5+lbez+i76N/01iE9Ns8obFShICMLwUY
 yfuBvYnu6mq+CHqXh28zIMpKBLGdnIy6GvbL5KSUE=
X-Received: by 2002:adf:cb09:0:b0:37c:d179:2f73 with SMTP id
 ffacd0b85a97d-37ef0b7c8a5mr1907599f8f.13.1729591819405; 
 Tue, 22 Oct 2024 03:10:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQHeGfJVT36YqLn+DMDNjjXcUGuP1hlqTqi7nBib4PHBCTALP7lJMDW5934aNhKUagchCtcg==
X-Received: by 2002:adf:cb09:0:b0:37c:d179:2f73 with SMTP id
 ffacd0b85a97d-37ef0b7c8a5mr1907579f8f.13.1729591818925; 
 Tue, 22 Oct 2024 03:10:18 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0a48882sm6257283f8f.30.2024.10.22.03.10.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 03:10:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kwolf@redhat.com, junjie.mao@hotmail.com,
 manos.pitsidianakis@linaro.org
Subject: [PATCH v2 05/14] rust: silence unknown warnings for the sake of old
 compilers
Date: Tue, 22 Oct 2024 12:09:46 +0200
Message-ID: <20241022100956.196657-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241022100956.196657-1-pbonzini@redhat.com>
References: <20241022100956.196657-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Occasionally, we may need to silence warnings and clippy lints that
were only introduced in newer Rust compiler versions.  However, this
would fail when compiling with an older rustc:

error: unknown lint: `non_local_definitions`
   --> rust/qemu-api/rust-qemu-api-tests.p/structured/offset_of.rs:79:17

So by default we need to block the unknown_lints warning.  To avoid
misspelled lints or other similar issues, re-enable it in the CI job
that uses nightly rust.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                   | 8 ++++++++
 .gitlab-ci.d/buildtest.yml    | 2 +-
 meson_options.txt             | 2 ++
 scripts/meson-buildoptions.sh | 4 ++++
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 94f30033f68..fe72f9951ca 100644
--- a/meson.build
+++ b/meson.build
@@ -3327,6 +3327,14 @@ if have_rust and have_system
   # Prohibit code that is forbidden in Rust 2024
   rustc_args +=3D ['-D', 'unsafe_op_in_unsafe_fn']
=20
+  # Occasionally, we may need to silence warnings and clippy lints that
+  # were only introduced in newer Rust compiler versions.  Do not croak
+  # in that case; a CI job with rust_strict_lints =3D=3D true ensures that
+  # we do not have misspelled allow() attributes.
+  if not get_option('strict_rust_lints')
+    rustc_args +=3D ['-A', 'unknown_lints']
+  endif
+
   # Apart from procedural macros, our Rust executables will often link
   # with C code, so include all the libraries that C code needs.  This
   # is safe; https://github.com/rust-lang/rust/pull/54675 says that
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 7705000e3cc..4c87f8788d5 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -128,7 +128,7 @@ build-system-fedora-rust-nightly:
     job: amd64-fedora-rust-nightly-container
   variables:
     IMAGE: fedora-rust-nightly
-    CONFIGURE_ARGS: --disable-docs --enable-rust
+    CONFIGURE_ARGS: --disable-docs --enable-rust --enable-strict-rust-lints
     TARGETS: aarch64-softmmu
     MAKE_CHECK_ARGS: check-build
   allow_failure: true
diff --git a/meson_options.txt b/meson_options.txt
index 0ee4d7bb86b..e46199a3232 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -376,3 +376,5 @@ option('x86_version', type : 'combo', choices : ['0', '=
1', '2', '3', '4'], value
=20
 option('rust', type: 'feature', value: 'disabled',
        description: 'Rust support')
+option('strict_rust_lints', type: 'boolean', value: false,
+       description: 'Enable stricter set of Rust warnings')
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 6d08605b771..e898b20307d 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -47,6 +47,8 @@ meson_options_help() {
   printf "%s\n" '                           getrandom()'
   printf "%s\n" '  --enable-safe-stack      SafeStack Stack Smash Protecti=
on (requires'
   printf "%s\n" '                           clang/llvm and coroutine backe=
nd ucontext)'
+  printf "%s\n" '  --enable-strict-rust-lints'
+  printf "%s\n" '                           Enable stricter set of Rust wa=
rnings'
   printf "%s\n" '  --enable-strip           Strip targets on install'
   printf "%s\n" '  --enable-tcg-interpreter TCG with bytecode interpreter =
(slow)'
   printf "%s\n" '  --enable-trace-backends=3DCHOICES'
@@ -490,6 +492,8 @@ _meson_option_parse() {
     --disable-spice-protocol) printf "%s" -Dspice_protocol=3Ddisabled ;;
     --enable-stack-protector) printf "%s" -Dstack_protector=3Denabled ;;
     --disable-stack-protector) printf "%s" -Dstack_protector=3Ddisabled ;;
+    --enable-strict-rust-lints) printf "%s" -Dstrict_rust_lints=3Dtrue ;;
+    --disable-strict-rust-lints) printf "%s" -Dstrict_rust_lints=3Dfalse ;;
     --enable-strip) printf "%s" -Dstrip=3Dtrue ;;
     --disable-strip) printf "%s" -Dstrip=3Dfalse ;;
     --sysconfdir=3D*) quote_sh "-Dsysconfdir=3D$2" ;;
--=20
2.46.2


