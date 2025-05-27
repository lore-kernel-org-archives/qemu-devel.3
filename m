Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 794B3C54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 17:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJxix-0005gS-VA; Tue, 27 May 2025 13:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJxiu-0005eG-Ql
 for qemu-devel@nongnu.org; Tue, 27 May 2025 13:04:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJxip-0006gA-SB
 for qemu-devel@nongnu.org; Tue, 27 May 2025 13:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748365454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=whk0bx3S6iDRVW9awl3GtYiXbZ6tm1mvhJAdBgRVaBk=;
 b=EOzF6tU1Ysj5R6MuQCvszLgl57bqETjLi3F3Xh/knhEKJSQZbVoRRCXleOZAwe7OCE0y0A
 Sm+/MKZ1u0r43A/zdlywdqZr1FxBbNd0eIdc3AGzpBFcyDUJmrXAcM9jbkqiRJFEfjGXeA
 ktL/C2xMdbOGGyJyuRPMm2ItjlKnpgk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-CaRueN9hPHO2gUp7e6QFVQ-1; Tue, 27 May 2025 13:04:12 -0400
X-MC-Unique: CaRueN9hPHO2gUp7e6QFVQ-1
X-Mimecast-MFC-AGG-ID: CaRueN9hPHO2gUp7e6QFVQ_1748365452
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-acf16746a74so271739766b.0
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 10:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748365451; x=1748970251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=whk0bx3S6iDRVW9awl3GtYiXbZ6tm1mvhJAdBgRVaBk=;
 b=AVvMpvZnoGh6hoyzgzjzR7u2y5MUolBJZdlq6HN/zijeQKCSvsO6MHjpAJR1Q6o0tC
 Ycm4vZun6Ub5jX1WuYKLGxRFqj4PFFMqmpf9KlL/wi5Y8v75jwdJF2oE3p3NmDvoWnWz
 IRl0KjAYPJJwxczbzgrzw2LXo6hSSBtxd3/FsRqKht9rpHWVgM7ebD049lE30VqJ3onm
 k8zIYz4S257hyTQTezQlnEsIHjuSMzaVfdfiUvoc4y41tG5I7+VRjj+RvVQwmveAXYtt
 zywu29CuWsrdr1TKBg0pUlLx3n3wlOxUyzNSJAzeYzolUYyE/ABZmXdy7oW6yvjqz0dS
 C4aA==
X-Gm-Message-State: AOJu0Yyxg6YWb3rAx9DR1bOBykF2ycoHSFZL1uitvNthJptd82MgocHL
 5LcG9Bp0J/jqAfOh7WlfsXrOGfFUdAeQiGhEyWJnkf9DMQW0QkbK4yEhQ7aRqWTSGdAfn25UFxF
 KvHNvf2yUr8T1tn+UMNKusLfev5HmlHwHyDNH5DUS8htc0kPQyqodHz3vMS80SMaK7JHHi2Bvtz
 mz5OPTdQCRmgJ/o/5cvLNfjtw+IxmqfAcwiyZ1Ll+t
X-Gm-Gg: ASbGncv0ClBzxVPRXnlaycjuK7VzCoS6VxdTtLqqGcib5oe+Ay1AiLugYBBH0xYy68j
 s0C9BHWOn66aJ/Qq0VsIRKTmhDy9PGLUo9dHJXIKEP8QF4R/Aj3eFFM3/OO18Qal4HstVETkCut
 oxtkKTc0ZbPqf3UHvA4ryWlofFvitahxoHS0P1NKZeliBo+lMZdpFJYDazqOmeL2IQHa1KKJ/Fv
 RbKKoWzrToLCCfzsfVMh5+yeETjoU+jsrnLPZagPMvCBgY6YUIVO7y+8mclOiawC0ruRSVlMRBV
 JOcvOhxIBcRPWw==
X-Received: by 2002:a17:907:2cc4:b0:ad8:55d8:38bc with SMTP id
 a640c23a62f3a-ad85b1de6cbmr1289910566b.43.1748365450131; 
 Tue, 27 May 2025 10:04:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsNB5QXYe1gwRsd/Ukk5FK+oKo9Mz5rtW28Ni4fmUZWVVgGswW1pT3vFqZmUOqTGH6DTbXcg==
X-Received: by 2002:a17:907:2cc4:b0:ad8:55d8:38bc with SMTP id
 a640c23a62f3a-ad85b1de6cbmr1289903366b.43.1748365449548; 
 Tue, 27 May 2025 10:04:09 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d4c9e62sm1867452766b.155.2025.05.27.10.04.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 10:04:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 2/6] rust: use "objects" for Rust executables as well
Date: Tue, 27 May 2025 19:04:00 +0200
Message-ID: <20250527170404.1580482-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527170404.1580482-1-pbonzini@redhat.com>
References: <20250527170404.1580482-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

libqemuutil is not meant be linked as a whole; if modules are enabled, doing
so results in undefined symbols (corresponding to QMP commands) in
rust/qemu-api/rust-qemu-api-integration.

Support for "objects" in Rust executables is available in Meson 1.8.0; use it
to switching to the same dependencies that C targets use: link_with for
libqemuutil, and objects for everything else.

Reported-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst       |  2 --
 rust/meson.build          |  2 ++
 rust/qemu-api/meson.build | 24 +++---------------------
 3 files changed, 5 insertions(+), 23 deletions(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 171d908e0b0..11328c05b45 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -66,8 +66,6 @@ be run via ``meson test`` or ``make``::
 
    make check-rust
 
-Building Rust code with ``--enable-modules`` is not supported yet.
-
 Supported tools
 '''''''''''''''
 
diff --git a/rust/meson.build b/rust/meson.build
index 1f0dcce7d04..801f4374dfa 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -14,6 +14,8 @@ quote_rs_native = dependency('quote-1-rs', native: true)
 syn_rs_native = dependency('syn-2-rs', native: true)
 proc_macro2_rs_native = dependency('proc-macro2-1-rs', native: true)
 
+qemuutil_rs = qemuutil.partial_dependency(link_args: true, links: true)
+
 subdir('qemu-api-macros')
 subdir('qemu-api')
 
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 1ea86b8bbf1..c647493f712 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -41,26 +41,8 @@ _qemu_api_rs = static_library(
 rust.test('rust-qemu-api-tests', _qemu_api_rs,
           suite: ['unit', 'rust'])
 
-qemu_api = declare_dependency(link_with: _qemu_api_rs)
-
-# Rust executables do not support objects, so add an intermediate step.
-rust_qemu_api_objs = static_library(
-    'rust_qemu_api_objs',
-    objects: [libqom.extract_all_objects(recursive: false),
-              libhwcore.extract_all_objects(recursive: false),
-              libchardev.extract_all_objects(recursive: false),
-              libcrypto.extract_all_objects(recursive: false),
-              libauthz.extract_all_objects(recursive: false),
-              libio.extract_all_objects(recursive: false),
-              libmigration.extract_all_objects(recursive: false)])
-rust_qemu_api_deps = declare_dependency(
-    dependencies: [
-      qom_ss.dependencies(),
-      chardev_ss.dependencies(),
-      crypto_ss.dependencies(),
-      authz_ss.dependencies(),
-      io_ss.dependencies()],
-    link_whole: [rust_qemu_api_objs, libqemuutil])
+qemu_api = declare_dependency(link_with: [_qemu_api_rs],
+  dependencies: [qemuutil_rs, qemu_api_macros, qom, hwcore, chardev, migration])
 
 test('rust-qemu-api-integration',
     executable(
@@ -69,7 +51,7 @@ test('rust-qemu-api-integration',
         override_options: ['rust_std=2021', 'build.rust_std=2021'],
         rust_args: ['--test'],
         install: false,
-        dependencies: [qemu_api, qemu_api_macros, rust_qemu_api_deps]),
+        dependencies: qemu_api),
     args: [
         '--test', '--test-threads', '1',
         '--format', 'pretty',
-- 
2.49.0


