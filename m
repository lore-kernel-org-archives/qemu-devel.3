Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F37D1BDD2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80sF-0005OU-RC; Mon, 04 Nov 2024 12:28:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80sD-0005Nb-Om
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80sB-0000Lp-PZ
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730741295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eshy0bLvRcQ1KvRtKV33AyzKUgcVVdJsaiv+wKMFE00=;
 b=gE3W7j1zmVX5DYJcm7vevePybeeMAqGD3IVd9VEYgx91fjH1svY6mTVbo9BRWWkmHc3Qlm
 Y86+SROBAx/yRXEuYsGKwoTfLa0EmFeKrRFd8cShNwaiSyzL5w7z7Bkjtzr16H44bEEsdd
 8zG8RZLn/3GANvfYJ0/BNFk6Zx8/Et8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-qVeMWcAmMoiNXDX1mtf8qw-1; Mon, 04 Nov 2024 12:28:14 -0500
X-MC-Unique: qVeMWcAmMoiNXDX1mtf8qw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4315afcae6cso25372475e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:28:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741292; x=1731346092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eshy0bLvRcQ1KvRtKV33AyzKUgcVVdJsaiv+wKMFE00=;
 b=kBTRCbqGzvEVvQcnCJUVXgY5CAyOEA26xerm+LphDFvHycjzDRL1IrhH+tpCisBSxO
 Js2+ayQV//2VM+kNapaC3IiUj7+myQbHCO+SXJL4zKAEAL4ztb+Wsqa8Jo+2OX22zGr1
 72gJiiQrkdC+B8tbVNR8t5kyLJZHlkZOZIXghU9t6Pz4va+NroZ7Msqhv7xrtIBXTCCv
 pqYmOk8oUEXjny5R06CChA7j0sSBI0EnzUyyI25zNAiZjxIQBI4ySf6i0FOqVFpO7bPM
 I9GXt9ylXB1jdOkYCbzWHGVoBYaE1BrsYxGy+CVOtV4oFegF9XTUa5+egZMYdkYuqkh1
 ysEA==
X-Gm-Message-State: AOJu0YwuUBw+sq3MMVIV1u52D0405HTR8hhoBTz1Rnvv5IdoqKhnUufa
 zAsR+X+/h7Pv0VTQZDb6fSrq28gCXv0ULCENNSP8MD4XJf0gzDKT5xyOpaJUkFRG0a6s1MOoW5U
 I5xW7JgqFJK2c3IGYk2OoB41u3fDWPEwGi2KtR5eEGmxIfUS9PQrHdY6Owt3I79G2K43IAuORlY
 F7DsdhAgQRHPvup2iOZvEUSEP6SZSHPQhiWFo2DEI=
X-Received: by 2002:a05:600c:35c5:b0:431:9340:77e0 with SMTP id
 5b1f17b1804b1-4327dab3f6cmr135328865e9.9.1730741291970; 
 Mon, 04 Nov 2024 09:28:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXqUQwrfnl5jp6cwl5MdfqD1MjtfQacpApsIjZ8qKFN9r6cHcXj03LTq9Q19rl4wD3srIODQ==
X-Received: by 2002:a05:600c:35c5:b0:431:9340:77e0 with SMTP id
 5b1f17b1804b1-4327dab3f6cmr135328485e9.9.1730741291408; 
 Mon, 04 Nov 2024 09:28:11 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5e7c51sm158346805e9.25.2024.11.04.09.28.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:28:10 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 22/40] rust/pl011: add TYPE_PL011_LUMINARY device
Date: Mon,  4 Nov 2024 18:27:01 +0100
Message-ID: <20241104172721.180255-23-pbonzini@redhat.com>
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Add a device specialization for the Luminary UART device.

This commit adds a DeviceId enum that utilizes the Index trait to return
different bytes depending on what device id the UART has (Arm -default-
or Luminary)

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Tested-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20241024-rust-round-2-v1-6-051e7a25b978@linaro.org
---
 rust/hw/char/pl011/src/device.rs | 77 ++++++++++++++++++++++++++++++--
 rust/hw/char/pl011/src/lib.rs    |  1 +
 2 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index f91790ff185..051c59f39ae 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -18,8 +18,6 @@
     RegisterOffset,
 };
 
-static PL011_ID_ARM: [c_uchar; 8] = [0x11, 0x10, 0x14, 0x00, 0x0d, 0xf0, 0x05, 0xb1];
-
 /// Integer Baud Rate Divider, `UARTIBRD`
 const IBRD_MASK: u32 = 0x3f;
 
@@ -31,6 +29,29 @@
 /// QEMU sourced constant.
 pub const PL011_FIFO_DEPTH: usize = 16_usize;
 
+#[derive(Clone, Copy, Debug)]
+enum DeviceId {
+    #[allow(dead_code)]
+    Arm = 0,
+    Luminary,
+}
+
+impl std::ops::Index<hwaddr> for DeviceId {
+    type Output = c_uchar;
+
+    fn index(&self, idx: hwaddr) -> &Self::Output {
+        match self {
+            Self::Arm => &Self::PL011_ID_ARM[idx as usize],
+            Self::Luminary => &Self::PL011_ID_LUMINARY[idx as usize],
+        }
+    }
+}
+
+impl DeviceId {
+    const PL011_ID_ARM: [c_uchar; 8] = [0x11, 0x10, 0x14, 0x00, 0x0d, 0xf0, 0x05, 0xb1];
+    const PL011_ID_LUMINARY: [c_uchar; 8] = [0x11, 0x00, 0x18, 0x01, 0x0d, 0xf0, 0x05, 0xb1];
+}
+
 #[repr(C)]
 #[derive(Debug, qemu_api_macros::Object)]
 /// PL011 Device Model in QEMU
@@ -75,6 +96,8 @@ pub struct PL011State {
     pub clock: NonNull<Clock>,
     #[doc(alias = "migrate_clk")]
     pub migrate_clock: bool,
+    /// The byte string that identifies the device.
+    device_id: DeviceId,
 }
 
 impl ObjectImpl for PL011State {
@@ -162,7 +185,7 @@ pub fn read(
 
         std::ops::ControlFlow::Break(match RegisterOffset::try_from(offset) {
             Err(v) if (0x3f8..0x400).contains(&v) => {
-                u64::from(PL011_ID_ARM[((offset - 0xfe0) >> 2) as usize])
+                u64::from(self.device_id[(offset - 0xfe0) >> 2])
             }
             Err(_) => {
                 // qemu_log_mask(LOG_GUEST_ERROR, "pl011_read: Bad offset 0x%x\n", (int)offset);
@@ -619,3 +642,51 @@ pub fn post_load(&mut self, _version_id: u32) -> Result<(), ()> {
         state.as_mut().init();
     }
 }
+
+#[repr(C)]
+#[derive(Debug, qemu_api_macros::Object)]
+/// PL011 Luminary device model.
+pub struct PL011Luminary {
+    parent_obj: PL011State,
+}
+
+#[repr(C)]
+pub struct PL011LuminaryClass {
+    _inner: [u8; 0],
+}
+
+/// Initializes a pre-allocated, unitialized instance of `PL011Luminary`.
+///
+/// # Safety
+///
+/// We expect the FFI user of this function to pass a valid pointer, that has
+/// the same size as [`PL011Luminary`]. We also expect the device is
+/// readable/writeable from one thread at any time.
+pub unsafe extern "C" fn pl011_luminary_init(obj: *mut Object) {
+    unsafe {
+        debug_assert!(!obj.is_null());
+        let mut state = NonNull::new_unchecked(obj.cast::<PL011Luminary>());
+        let state = state.as_mut();
+        state.parent_obj.device_id = DeviceId::Luminary;
+    }
+}
+
+impl qemu_api::definitions::Class for PL011LuminaryClass {
+    const CLASS_INIT: Option<
+        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut core::ffi::c_void),
+    > = None;
+    const CLASS_BASE_INIT: Option<
+        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut core::ffi::c_void),
+    > = None;
+}
+
+impl ObjectImpl for PL011Luminary {
+    type Class = PL011LuminaryClass;
+    const TYPE_INFO: qemu_api::bindings::TypeInfo = qemu_api::type_info! { Self };
+    const TYPE_NAME: &'static CStr = crate::TYPE_PL011_LUMINARY;
+    const PARENT_TYPE_NAME: Option<&'static CStr> = Some(crate::TYPE_PL011);
+    const ABSTRACT: bool = false;
+    const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = Some(pl011_luminary_init);
+    const INSTANCE_POST_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
+    const INSTANCE_FINALIZE: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
+}
diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
index 73474a07e7c..fb33110d3d8 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -47,6 +47,7 @@
 pub mod memory_ops;
 
 pub const TYPE_PL011: &::core::ffi::CStr = c"pl011";
+pub const TYPE_PL011_LUMINARY: &::core::ffi::CStr = c"pl011_luminary";
 
 /// Offset of each register from the base memory address of the device.
 ///
-- 
2.47.0


