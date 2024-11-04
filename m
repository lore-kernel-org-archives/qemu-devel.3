Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF03D1BDD0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80sk-0007ld-0U; Mon, 04 Nov 2024 12:28:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80si-0007cA-2N
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80sg-0000RW-8Q
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730741325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w5RpplVRrrCi592oN/VMJy7hw/XAeFSdLKK/OTlMsMs=;
 b=bI/jhC6/uZf6Ey+0q1o8O9F90436oiz3v1w7+F+Gpa/xHWsnW3Hzulu2+bnrrH2ID6I6cU
 4mbmtERDylYyymvviWC87x88cpYS5F8l3/UN1BhIv8nFuGXz61D+tSdMK73+bPQeq1eaz8
 vUC5TgwpG8JKX8Fylhtjza4UQdeykHQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-Jme_JV-dMsGPHXW0Aj6Xfw-1; Mon, 04 Nov 2024 12:28:44 -0500
X-MC-Unique: Jme_JV-dMsGPHXW0Aj6Xfw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4315a0f25afso30788895e9.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:28:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741323; x=1731346123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w5RpplVRrrCi592oN/VMJy7hw/XAeFSdLKK/OTlMsMs=;
 b=rsW94U2rgNQitax0HQAgu73ng7hcUFTXg6I44shKh27whO/2j8G31JswjdmFGt+unv
 cv3XbdKR8pe9p031WsTDZpATP0kwmjuQ+OpK0ESgfa6X0exI+EnQfRI+2ch36dE/lz8L
 GT0JSVvW5BjWsD1uCWc+XXapGcFIHdrVbIYfJ9dOvkCy+0ADlq9v/H1GAqjDzEUwYDYc
 vbFDrlU68iqwI2hzMU/y6XCkMuRtb0NHEwDmy2SdxMmAj6Vck/8kkFpmwwjH9lvO28Qx
 mkv4OiMUJM+oUDuvunJx1eRApKtjf89JB6e9B1+DaWfLZGCnGIzbx4eiKmCvEZwviU+3
 rdpg==
X-Gm-Message-State: AOJu0YyjV02ITEfHR0DNS9uGTWr/BpScEKvITm2aj0klJAhYW/fLSNT8
 MvloT+oSLnX0uv+lRIiPnzMJj0tz4gksFcte/Uz9+p4vvqpcpjdgnXurf6A2Qj+HGhzKWnr8qFM
 0OP1VhL4GjOgBCAeYSi6aN7VtFJU56UdltJyGrzreiuhBzTmAPcf+KG/4+MW0n9Q6xvle03Y168
 HrKKxvCni4TxeDz9meN32DiLCqXI2wKHy0cLciPjs=
X-Received: by 2002:adf:e5c4:0:b0:37d:4846:42c3 with SMTP id
 ffacd0b85a97d-38061137468mr22348763f8f.22.1730741322864; 
 Mon, 04 Nov 2024 09:28:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHtAkNeyRIqh1r3lg6iKaaRe9U8hIRD60uYR/uFluQbUacO2B4LGcpJjRbpyEBmDRIsijv5Q==
X-Received: by 2002:adf:e5c4:0:b0:37d:4846:42c3 with SMTP id
 ffacd0b85a97d-38061137468mr22348733f8f.22.1730741322434; 
 Mon, 04 Nov 2024 09:28:42 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10d49c9sm13807647f8f.37.2024.11.04.09.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:28:40 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 36/40] rust: do not use --generate-cstr
Date: Mon,  4 Nov 2024 18:27:15 +0100
Message-ID: <20241104172721.180255-37-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104172721.180255-1-pbonzini@redhat.com>
References: <20241104172721.180255-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--generate-cstr is a good idea and generally the right thing to do,
but it is not available in Debian 12 and Ubuntu 22.04.  Work around
the absence.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                       |  4 +++-
 rust/hw/char/pl011/src/device.rs  |  1 +
 rust/qemu-api/src/device_class.rs | 10 ++++++++++
 rust/qemu-api/tests/tests.rs      |  4 ++--
 4 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index 95b612e0b77..07f7e5f8f64 100644
--- a/meson.build
+++ b/meson.build
@@ -3955,13 +3955,15 @@ common_all = static_library('common',
                             dependencies: common_ss.all_dependencies())
 
 if have_rust
+  # We would like to use --generate-cstr, but it is only available
+  # starting with bindgen 0.66.0.  The oldest supported versions
+  # are in Ubuntu 22.04 (0.59.1) and Debian 12 (0.60.1).
   bindgen_args = [
     '--disable-header-comment',
     '--raw-line', '// @generated',
     '--ctypes-prefix', 'std::os::raw',
     '--formatter', 'rustfmt',
     '--generate-block',
-    '--generate-cstr',
     '--impl-debug',
     '--merge-extern-blocks',
     '--no-doc-comments',
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index bca727e37f0..2a85960b81f 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -12,6 +12,7 @@
     bindings::{self, *},
     c_str,
     definitions::ObjectImpl,
+    device_class::TYPE_SYS_BUS_DEVICE,
 };
 
 use crate::{
diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_class.rs
index 56608c7f7fc..0ba798d3e3c 100644
--- a/rust/qemu-api/src/device_class.rs
+++ b/rust/qemu-api/src/device_class.rs
@@ -2,6 +2,10 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+use std::ffi::CStr;
+
+use crate::bindings;
+
 #[macro_export]
 macro_rules! device_class_init {
     ($func:ident, props => $props:ident, realize_fn => $realize_fn:expr, legacy_reset_fn => $legacy_reset_fn:expr, vmsd => $vmsd:ident$(,)*) => {
@@ -62,3 +66,9 @@ macro_rules! declare_properties {
         ];
     };
 }
+
+// workaround until we can use --generate-cstr in bindgen.
+pub const TYPE_DEVICE: &CStr =
+    unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_DEVICE) };
+pub const TYPE_SYS_BUS_DEVICE: &CStr =
+    unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_SYS_BUS_DEVICE) };
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 7442f695646..43a4827de12 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -8,7 +8,7 @@
     bindings::*,
     c_str, declare_properties, define_property,
     definitions::{Class, ObjectImpl},
-    device_class_init,
+    device_class, device_class_init,
     zeroable::Zeroable,
 };
 
@@ -57,7 +57,7 @@ impl ObjectImpl for DummyState {
         type Class = DummyClass;
         const TYPE_INFO: qemu_api::bindings::TypeInfo = qemu_api::type_info! { Self };
         const TYPE_NAME: &'static CStr = c_str!("dummy");
-        const PARENT_TYPE_NAME: Option<&'static CStr> = Some(TYPE_DEVICE);
+        const PARENT_TYPE_NAME: Option<&'static CStr> = Some(device_class::TYPE_DEVICE);
         const ABSTRACT: bool = false;
         const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
         const INSTANCE_POST_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
-- 
2.47.0


