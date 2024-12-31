Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D78CE7718F
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 00:25:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSQ3L-0003Tv-DR; Mon, 30 Dec 2024 19:24:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tSQ3I-0003SZ-UL
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 19:24:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tSQ3H-00020J-AL
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 19:24:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735604642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gYsX+8dH7ajdw7h4Gl+C0v6pO/Y+Rzud1yNiyL/9IMY=;
 b=MJt0TOVfl0ua4IesjZ7n8DiWYhxARzYEg07lrQcv+5TgJDDctwz5mOoE3uWTva5SCvXXwh
 aIo+OcgGBMyiANdg+2X776OBcZsgw5F1TK7xnSuSRnzXwVYSb9TrLJGHwJsUMRKM3f+xmv
 GLYQwVod7qdR9+yg4GqHaH02bs3JAp0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-0RM7fkT7NgGNstrNmS5kQw-1; Mon, 30 Dec 2024 19:24:01 -0500
X-MC-Unique: 0RM7fkT7NgGNstrNmS5kQw-1
X-Mimecast-MFC-AGG-ID: 0RM7fkT7NgGNstrNmS5kQw
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4359206e1e4so75214355e9.2
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 16:24:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735604639; x=1736209439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gYsX+8dH7ajdw7h4Gl+C0v6pO/Y+Rzud1yNiyL/9IMY=;
 b=jEOSmZzBuco8/eoISqephBzAY8bj+DoZ13Ad4vdM4NMGJEFIQxig84eON7+sF3qRsh
 1S/+UAPsldEBLkKiOPzs5f37DY1zXw+sLhbx503BIlsEJZoS2uP12U4VNh6ZXqHtfeQY
 JPGZnBITO7AitBMiJV3gqbKsPG/1OS/bH9BUNL/cgVJPwfpVH7RlD4XOPee7M+UZLZhq
 qo3t/7w15RvTAGee4Ojw4SfTHD4n/WLtZO1pSNkR+WEo7jCFhoT/3p+QbX4f18aNsavr
 ngjQRKDdKjohbN+fJn81Wb7js4RTpaqoR/Visb46sVbgff23FLjpKhuqR4kMFnl9MSU8
 8ezQ==
X-Gm-Message-State: AOJu0YwWCeFH5Km2SXsopgeg2D2ow2sbfLziPpp1wwM47M9mXHd6EIfC
 uXGQWQgGtTw6M92AsNnxCENT9hbgqypQc0NTNQPKiuHm1eyA4lHqFh6lzlayExI+MAXcBG1xXFf
 IlQ7ZwY+IoHfGTs7NOGx6LsR10o3DdZa0vW21fqr74kH0/nSnxplpFjMZHVVl68mFT5fTXdYqjf
 DASDvb8la/oQEy6R1h5lr9MbTfByEY8QF2JMczh78=
X-Gm-Gg: ASbGncvD9DJDcyjLhWdsBOSnRC8A8oZ96yfYFLLg8iyYoiXnSaCSnhoJmPrP+cQbSgy
 BrKCUj9irpynok0s2kwTlDrspBNwvEefbnA0Yb9cJx3RCh0XN8SwsMfbfV021JKPK91DIq6EqPa
 JMFxVxivCJitIc2TPuMVkkm49uzZCwPhgBWyXxSuX0uAAsAi00XYxkijb1gGGmnNnoUBg798PMN
 Fw5UZ2jZTCjJGhZS6hyKS6aceJzyjktb/7TlaZ1t8lhfmNwXj87ChJXvbs=
X-Received: by 2002:a05:600c:1c25:b0:434:f4fa:83c4 with SMTP id
 5b1f17b1804b1-43668b5f691mr304872365e9.29.1735604639568; 
 Mon, 30 Dec 2024 16:23:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxDzgunRjQHOEt3yXGNGZrj8KS6374Y+Ckge8ZDZ8iuINYuYauFPTqu7gP3FeSa0KAhsjRLA==
X-Received: by 2002:a05:600c:1c25:b0:434:f4fa:83c4 with SMTP id
 5b1f17b1804b1-43668b5f691mr304872215e9.29.1735604639086; 
 Mon, 30 Dec 2024 16:23:59 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b3b271sm402833415e9.34.2024.12.30.16.23.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2024 16:23:57 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	zhao1.liu@intel.com,
	junjie.mao@hotmail.com
Subject: [RFC PATCH 8/9] rust: pl011: switch vmstate to new-style macros
Date: Tue, 31 Dec 2024 01:23:35 +0100
Message-ID: <20241231002336.25931-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241231002336.25931-1-pbonzini@redhat.com>
References: <20241231002336.25931-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.187,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs       |  3 ++-
 rust/hw/char/pl011/src/device_class.rs | 36 +++++++++++++-------------
 rust/hw/char/pl011/src/lib.rs          |  6 +++++
 3 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 994c2fc0593..11a87664c7a 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -10,7 +10,7 @@
 
 use qemu_api::{
     bindings::{self, *},
-    c_str,
+    c_str, impl_vmstate_forward,
     irq::InterruptSource,
     prelude::*,
     qdev::DeviceImpl,
@@ -54,6 +54,7 @@ impl DeviceId {
 #[repr(transparent)]
 #[derive(Debug, Default)]
 pub struct Fifo([registers::Data; PL011_FIFO_DEPTH as usize]);
+impl_vmstate_forward!(Fifo);
 
 impl Fifo {
     const fn len(&self) -> u32 {
diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/src/device_class.rs
index 7f3ca895071..e0d3532e956 100644
--- a/rust/hw/char/pl011/src/device_class.rs
+++ b/rust/hw/char/pl011/src/device_class.rs
@@ -6,11 +6,11 @@
 use std::os::raw::{c_int, c_void};
 
 use qemu_api::{
-    bindings::*, c_str, vmstate_clock, vmstate_fields, vmstate_subsections, vmstate_uint32,
-    vmstate_uint32_array, vmstate_unused, zeroable::Zeroable,
+    bindings::*, c_str, vmstate_clock, vmstate_fields, vmstate_of, vmstate_subsections,
+    vmstate_unused, zeroable::Zeroable,
 };
 
-use crate::device::{PL011State, PL011_FIFO_DEPTH};
+use crate::device::PL011State;
 
 extern "C" fn pl011_clock_needed(opaque: *mut c_void) -> bool {
     unsafe {
@@ -52,21 +52,21 @@ extern "C" fn pl011_post_load(opaque: *mut c_void, version_id: c_int) -> c_int {
     post_load: Some(pl011_post_load),
     fields: vmstate_fields! {
         vmstate_unused!(core::mem::size_of::<u32>()),
-        vmstate_uint32!(flags, PL011State),
-        vmstate_uint32!(line_control, PL011State),
-        vmstate_uint32!(receive_status_error_clear, PL011State),
-        vmstate_uint32!(control, PL011State),
-        vmstate_uint32!(dmacr, PL011State),
-        vmstate_uint32!(int_enabled, PL011State),
-        vmstate_uint32!(int_level, PL011State),
-        vmstate_uint32_array!(read_fifo, PL011State, PL011_FIFO_DEPTH),
-        vmstate_uint32!(ilpr, PL011State),
-        vmstate_uint32!(ibrd, PL011State),
-        vmstate_uint32!(fbrd, PL011State),
-        vmstate_uint32!(ifl, PL011State),
-        vmstate_uint32!(read_pos, PL011State),
-        vmstate_uint32!(read_count, PL011State),
-        vmstate_uint32!(read_trigger, PL011State),
+        vmstate_of!(PL011State, flags),
+        vmstate_of!(PL011State, line_control),
+        vmstate_of!(PL011State, receive_status_error_clear),
+        vmstate_of!(PL011State, control),
+        vmstate_of!(PL011State, dmacr),
+        vmstate_of!(PL011State, int_enabled),
+        vmstate_of!(PL011State, int_level),
+        vmstate_of!(PL011State, read_fifo),
+        vmstate_of!(PL011State, ilpr),
+        vmstate_of!(PL011State, ibrd),
+        vmstate_of!(PL011State, fbrd),
+        vmstate_of!(PL011State, ifl),
+        vmstate_of!(PL011State, read_pos),
+        vmstate_of!(PL011State, read_count),
+        vmstate_of!(PL011State, read_trigger),
     },
     subsections: vmstate_subsections! {
         VMSTATE_PL011_CLOCK
diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
index 0a89d393e0f..f30f9850ad4 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -106,6 +106,7 @@ pub mod registers {
     //! Device registers exposed as typed structs which are backed by arbitrary
     //! integer bitmaps. [`Data`], [`Control`], [`LineControl`], etc.
     use bilge::prelude::*;
+    use qemu_api::impl_vmstate_bitsized;
 
     /// Receive Status Register / Data Register common error bits
     ///
@@ -172,6 +173,7 @@ pub struct Data {
         pub errors: Errors,
         _reserved: u16,
     }
+    impl_vmstate_bitsized!(Data);
 
     impl Data {
         // bilge is not very const-friendly, unfortunately
@@ -208,6 +210,7 @@ pub struct ReceiveStatusErrorClear {
         pub errors: Errors,
         _reserved_unpredictable: u24,
     }
+    impl_vmstate_bitsized!(ReceiveStatusErrorClear);
 
     impl ReceiveStatusErrorClear {
         pub fn set_from_data(&mut self, data: Data) {
@@ -280,6 +283,7 @@ pub struct Flags {
         pub ring_indicator: bool,
         _reserved_zero_no_modify: u23,
     }
+    impl_vmstate_bitsized!(Flags);
 
     impl Flags {
         pub fn reset(&mut self) {
@@ -354,6 +358,7 @@ pub struct LineControl {
         /// 31:8 - Reserved, do not modify, read as zero.
         _reserved_zero_no_modify: u24,
     }
+    impl_vmstate_bitsized!(LineControl);
 
     impl LineControl {
         pub fn reset(&mut self) {
@@ -498,6 +503,7 @@ pub struct Control {
         /// 31:16 - Reserved, do not modify, read as zero.
         _reserved_zero_no_modify2: u16,
     }
+    impl_vmstate_bitsized!(Control);
 
     impl Control {
         pub fn reset(&mut self) {
-- 
2.47.1


