Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46CCFD149C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 16:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Mn5-000305-BI; Fri, 25 Oct 2024 12:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Mmy-0002ln-Ic
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:03:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Mmv-0004sq-9d
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729872224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2wB6JRp5b76OAUvoiYkeVBQK6MMDnpjCaH4KljLaOxY=;
 b=WoZv2A0dNQrAj28jVKA7wdUtQHVUaxPCSGVAByGz8ao5rDhnAYfUlDoIF6B1PvsduTPz3y
 3I63R3ThEwZHIYQ/8dxMN/i/StJIQ4u9ptbtStLr/zCKinOSwJhtKFxAaTXqm46fDh8hpl
 hH9OJtauCezemmxGMqDhI3/iSb4/1sM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-eKNnQe29MVO3kyTPqm8Z7Q-1; Fri, 25 Oct 2024 12:03:43 -0400
X-MC-Unique: eKNnQe29MVO3kyTPqm8Z7Q-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5c94862c3adso1546656a12.3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 09:03:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729872220; x=1730477020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2wB6JRp5b76OAUvoiYkeVBQK6MMDnpjCaH4KljLaOxY=;
 b=rhekqGN5I6zl+o89bgdkMhaL0S8IuHp2+5isz0o7Q/4qK//bO4pmczolqmvHhs2O9Y
 jrZXMu8KKMAhg2NY3jmu2bTP5cwNiYSM7l/TPxEpR+xhNcIid/Fj7yVgl/K7VzjhDOwK
 9gAM0N2GrBwCYmonxdggU+hTYpwYtj3UT2otm+bksuZ6rUR3Qog8B+ElXLdC1JijXPsp
 RI81BZV71mw1slTkAxuqJIf3nQVnPwBt0YbL2bUOCQvQqr6XJSXrjoHQAFeMnEk0K0Ng
 P/oe8UJmu0aJslUIRDQggeef9m/yJBNCRhDASqnb6Fr/1jyTtExxR4nxrETtIt9E5mRL
 /Qew==
X-Gm-Message-State: AOJu0YzqtB5BjWOX+Pnu2krFJYaocX+5pkZTv48PMXPBXIqMX8gNFb8b
 WlVQHBzZqT3kPjcaF60M+MU0Snhsy1NhawLLX65wSMSxDU9iu0JG8OMgSM/nSGlj3NjgCJJkwNJ
 dTiXRf5dB7acaZAfdfhez7IZS4QuAVdLa2XwE4ZfOYMoZdsQNfPncJ4G6yt5PkyLpZio5MjtJLb
 6nLuVbCNsdsIDS6WKPXxeK/fAL5jFR+kWhiPD6B2s=
X-Received: by 2002:a05:6402:84a:b0:5c9:3ff:2734 with SMTP id
 4fb4d7f45d1cf-5cb8ac86aa0mr7150387a12.12.1729872220178; 
 Fri, 25 Oct 2024 09:03:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGn8jOUSXxfcx9veK5F38rxLJDSO0g3t7TLjKEjwQ1Cc75UQgwroyeIj9UnQYnzFQ1bH6e91Q==
X-Received: by 2002:a05:6402:84a:b0:5c9:3ff:2734 with SMTP id
 4fb4d7f45d1cf-5cb8ac86aa0mr7150354a12.12.1729872219623; 
 Fri, 25 Oct 2024 09:03:39 -0700 (PDT)
Received: from [192.168.10.47] ([151.81.112.43])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cbb625810bsm753117a12.14.2024.10.25.09.03.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 09:03:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, zhao1.liu@intel.com,
 junjie.mao@hotmail.com, berrange@redhat.com
Subject: [PATCH 12/23] rust: silence unknown warnings for the sake of old
 compilers
Date: Fri, 25 Oct 2024 18:01:57 +0200
Message-ID: <20241025160209.194307-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025160209.194307-1-pbonzini@redhat.com>
References: <20241025160209.194307-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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
index e819148f36c..69b8367eb3c 100644
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
index 19ba5b9c818..aba65ff833a 100644
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
2.47.0


