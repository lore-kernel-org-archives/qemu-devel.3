Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 198B4C5B543
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 14:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJYlJ-0002tU-RS; Mon, 26 May 2025 10:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJYlE-0002s5-RR
 for qemu-devel@nongnu.org; Mon, 26 May 2025 10:25:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJYlC-0007di-QI
 for qemu-devel@nongnu.org; Mon, 26 May 2025 10:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748269501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=utt74FEHUZ6lFbnGNCeLg5d8BeYlcHDkUK83oW1XuqU=;
 b=SLIk1DfPUP7i21HE949IRSkireccZlVBvq5OSQUYDfVNLp24ONw+zFkRGt98sKAZPv6Udk
 1NoEj8UnxTPezUwWoAVgiVasaPMZGZlsjJlN8ZCKz1hGk0S/Q5q6rXFhN0CcIKhjY1h0yJ
 0cdG/FvaWj/B7E9jbgSd5pcaB3WhttY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-HKYP0O2jMhWDo5ec2xj0jA-1; Mon, 26 May 2025 10:24:59 -0400
X-MC-Unique: HKYP0O2jMhWDo5ec2xj0jA-1
X-Mimecast-MFC-AGG-ID: HKYP0O2jMhWDo5ec2xj0jA_1748269499
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-39ee4b91d1cso1527558f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 07:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748269497; x=1748874297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=utt74FEHUZ6lFbnGNCeLg5d8BeYlcHDkUK83oW1XuqU=;
 b=SvM3DH3NwNoaagG6dJmoyIiorfRD5vxhiJoYsH4nUi5mr1sWN8K1bYti4iwUaMIS0W
 xPaO+rhIHH6Wg26wdudBE17IirtciYckhhDik54RuSczQE6Lite6dk9aRoHTss/RTt+z
 u9H9oYJivTBolzPD4NhNY2CpTu/fTpeytx6RdgHiLNGwLhSE4D74Xk1eSlzH4Q4R0etC
 m2JNYL/Fn/JZjCfJ5TkrZDIql5f3BL0lVFU+kJAPbSeLCx1Pij+sIPVQ8WaGT5uKZzse
 2qXdOiAb2SwgGFAB7o3ea7tz/8o4Uic3HVyb1HkiVDbfsvYz0qKfu5PpTRHsbD226DBp
 5O8w==
X-Gm-Message-State: AOJu0YwDpqxtW9XZcnHcqo9okZzKvs7VmjB29jk7vKyBijzLPto36ZGa
 e1gHmU+1sxOALNNA5YRgFcnahy4UMsASk/UCLNn+yt+8WGC+jYekkln15UJ8DTUxe/74rSL/4rX
 6t34+x/V0siuAGsOvViAznU8WHT4VhK5iXKtdG2nrWr1uBHMVbWmZHOuVKZ8D5MiCqP2f+T+fD8
 +oMBEYWKWABaDtjloqsXPHLm7P+rpDnF9b9gcREtWj
X-Gm-Gg: ASbGncsdYbNaZxUuePI3zsVy/3P9kyieEl2nyMJv/W6KHLSnynEmNtUNzbEpzMngn8q
 8cyr/8nBVMSEyh8kmeyB8z/+ujckenKv6Sgh853rVJ/fPFNR+0Y4mEIt5/L3eu3cMqoeltwrTjt
 NowXbMtY0oCDVlJPCoxSwe+VABnPZZB0KLu/5x8d22qvpLj6+VblCsz00k+ZuVOHTDvUBwvRjNV
 Da8ZtWeby41mkOsmIJjGRohQ6+OzIByY1iZWuCrIvXq8SLjoWGHNZ/IowOOD3A26gNPL2E7M/v3
 mxRRqUAeYWdm4g==
X-Received: by 2002:a5d:64c6:0:b0:3a1:f724:eb15 with SMTP id
 ffacd0b85a97d-3a4ca123bf1mr8629112f8f.2.1748269497091; 
 Mon, 26 May 2025 07:24:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpyKmq/vMA252LfD05Ppt1m+ZziqiFpHTleVgk+do5+ZJxWzz0YA1GzozXYYRsfq57BlsAug==
X-Received: by 2002:a5d:64c6:0:b0:3a1:f724:eb15 with SMTP id
 ffacd0b85a97d-3a4ca123bf1mr8629088f8f.2.1748269496702; 
 Mon, 26 May 2025 07:24:56 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca88957sm35291467f8f.75.2025.05.26.07.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 07:24:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	qemu-rust@nongnu.org
Subject: [PATCH 01/12] rust: make declaration of dependent crates more
 consistent
Date: Mon, 26 May 2025 16:24:44 +0200
Message-ID: <20250526142455.1061519-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250526142254.1061009-1-pbonzini@redhat.com>
References: <20250526142254.1061009-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Crates like "bilge" and "libc" can be shared by more than one directory,
so declare them directly in rust/meson.build.  While at it, make their
variable names end with "_rs" and always add a subproject() statement
(as that pinpoints the error better if the subproject is missing and
cannot be downloaded).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/meson.build   | 12 +++---------
 rust/meson.build                 | 16 ++++++++++++++++
 rust/qemu-api-macros/meson.build | 14 +++-----------
 rust/qemu-api/meson.build        |  4 +---
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.build
index 547cca5a96f..494b6c123cc 100644
--- a/rust/hw/char/pl011/meson.build
+++ b/rust/hw/char/pl011/meson.build
@@ -1,17 +1,11 @@
-subproject('bilge-0.2-rs', required: true)
-subproject('bilge-impl-0.2-rs', required: true)
-
-bilge_dep = dependency('bilge-0.2-rs')
-bilge_impl_dep = dependency('bilge-impl-0.2-rs')
-
 _libpl011_rs = static_library(
   'pl011',
   files('src/lib.rs'),
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   dependencies: [
-    bilge_dep,
-    bilge_impl_dep,
+    bilge_rs,
+    bilge_impl_rs,
     qemu_api,
     qemu_api_macros,
   ],
@@ -21,6 +15,6 @@ rust_devices_ss.add(when: 'CONFIG_X_PL011_RUST', if_true: [declare_dependency(
   link_whole: [_libpl011_rs],
   # Putting proc macro crates in `dependencies` is necessary for Meson to find
   # them when compiling the root per-target static rust lib.
-  dependencies: [bilge_impl_dep, qemu_api_macros],
+  dependencies: [bilge_impl_rs, qemu_api_macros],
   variables: {'crate': 'pl011'},
 )])
diff --git a/rust/meson.build b/rust/meson.build
index 91e52b8fb8e..1f0dcce7d04 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -1,3 +1,19 @@
+subproject('bilge-0.2-rs', required: true)
+subproject('bilge-impl-0.2-rs', required: true)
+subproject('libc-0.2-rs', required: true)
+
+bilge_rs = dependency('bilge-0.2-rs')
+bilge_impl_rs = dependency('bilge-impl-0.2-rs')
+libc_rs = dependency('libc-0.2-rs')
+
+subproject('proc-macro2-1-rs', required: true)
+subproject('quote-1-rs', required: true)
+subproject('syn-2-rs', required: true)
+
+quote_rs_native = dependency('quote-1-rs', native: true)
+syn_rs_native = dependency('syn-2-rs', native: true)
+proc_macro2_rs_native = dependency('proc-macro2-1-rs', native: true)
+
 subdir('qemu-api-macros')
 subdir('qemu-api')
 
diff --git a/rust/qemu-api-macros/meson.build b/rust/qemu-api-macros/meson.build
index 6f94a4bb3c2..8610ce1c844 100644
--- a/rust/qemu-api-macros/meson.build
+++ b/rust/qemu-api-macros/meson.build
@@ -1,11 +1,3 @@
-subproject('proc-macro2-1-rs', required: true)
-subproject('quote-1-rs', required: true)
-subproject('syn-2-rs', required: true)
-
-quote_dep = dependency('quote-1-rs', native: true)
-syn_dep = dependency('syn-2-rs', native: true)
-proc_macro2_dep = dependency('proc-macro2-1-rs', native: true)
-
 _qemu_api_macros_rs = rust.proc_macro(
   'qemu_api_macros',
   files('src/lib.rs'),
@@ -16,9 +8,9 @@ _qemu_api_macros_rs = rust.proc_macro(
     '--cfg', 'feature="proc-macro"',
   ],
   dependencies: [
-    proc_macro2_dep,
-    quote_dep,
-    syn_dep,
+    proc_macro2_rs_native,
+    quote_rs_native,
+    syn_rs_native,
   ],
 )
 
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 1696df705bf..1ea86b8bbf1 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -2,8 +2,6 @@ _qemu_api_cfg = run_command(rustc_args,
   '--config-headers', config_host_h, '--features', files('Cargo.toml'),
   capture: true, check: true).stdout().strip().splitlines()
 
-libc_dep = dependency('libc-0.2-rs')
-
 # _qemu_api_cfg += ['--cfg', 'feature="allocator"']
 if get_option('debug_mutex')
   _qemu_api_cfg += ['--cfg', 'feature="debug_cell"']
@@ -37,7 +35,7 @@ _qemu_api_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: _qemu_api_cfg,
-  dependencies: [libc_dep, qemu_api_macros],
+  dependencies: [libc_rs, qemu_api_macros],
 )
 
 rust.test('rust-qemu-api-tests', _qemu_api_rs,
-- 
2.49.0


