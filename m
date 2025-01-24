Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3373C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:49:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGHr-0003El-Mb; Fri, 24 Jan 2025 04:47:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGGN-0007op-SM
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:46:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGGL-0003yu-Rw
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:46:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XbTiAxgh79DT2i5TJ+IcQefSJjUXpkJJ3v15Ommm2hM=;
 b=IAOEHrMpk7xO3d3NkH0ka0yGr6TiBL3gVkbekiZheMShhMng6+Fg04zo80Z0BHUD7NgDdl
 qb5K2IkVQrPgrC9yJ6wnBpQyx9hQQn3N+luGLfD1ffSPNXt5dRlhriVZOtdWcJsWuX3ukL
 Msq6/TwqETyJFb1xB/wfBjP+V4RGdv0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-wWLBKtYFNjaoo4QwOGO7pQ-1; Fri, 24 Jan 2025 04:46:01 -0500
X-MC-Unique: wWLBKtYFNjaoo4QwOGO7pQ-1
X-Mimecast-MFC-AGG-ID: wWLBKtYFNjaoo4QwOGO7pQ
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4361c040ba8so10346295e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:46:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711959; x=1738316759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XbTiAxgh79DT2i5TJ+IcQefSJjUXpkJJ3v15Ommm2hM=;
 b=wKxqOLxYVy3lClIwaQhjJiNe6u6bUpeLid3vGQhbnvUDDvP71yClMzTRQWDH5Gw+S6
 ngW0hxiU9OFmGqPyKVSevQBxDUrIbtpiDxIWCMxgCZ+eZKLqLBDVhyW+r85rRfNk5Xke
 j4HJwYwNw3MaHX0Vv3qg4HvHybg8JFIY7I7FHEleBX7LPTvY7tBm+I7B30kLGikiekCk
 aMYiszlYkjBepKo6/INatn1pqT0+H3Vb1j4wPHq67NZ/cVsSo8DeRyVGpJ2FCd4fjBN3
 f9cXpO40AW6/W5GatiEI00drcn0sImkh20lQruYX1GNVRJ+8oSMOxhv+AGxv5+BsErE/
 k/UQ==
X-Gm-Message-State: AOJu0Yw0ZBhbgfz4Pj4xgKbcSTtp/KOOgcNBmWbGFvIhTeqo6xFTslZm
 QwQfkRY7ubKggL1DIko6oXJmOrFMw92SYEZSwJxbEkL0RarwpGw3J2Zj469C2FekULKEQT2/eVp
 2vW+4SOVimEPFbZmaOA7/xFe12h6FPd8z8gu7+xN2LP99d2cqpbx0su46NRPubc5eOVl+ITrag2
 mwISj0qLqEoyU7sOXb2ajUiSKGwMNtpUpvQQUkyw4=
X-Gm-Gg: ASbGnctrTyA3+oYLpUPzmPjZVtSgLuiImOcSXS2WknQYJo5vVzJz8GJepuj9h0oThbu
 1ZljbYLYG57xUYpX9aIuU3jWt//fAI1AjiDrLLE5Wkc/spMxaVDPaj/F+Xv8gApc0HH7vHWEyBK
 DuPUZ3+Wo4p24totqB4rhhMvul0BaSzdsFPSvsysFW0NfTwi041co67SP7xQ9Y2oOwpuO1TFgrX
 YwEogeUq4LMtvOipgx+7ME7R76sF6oIbucPN+bHWnrpi8j32W4rGHWHgDmUv2W2oK5bHQQWIQ==
X-Received: by 2002:a05:600c:348c:b0:434:f1d5:1453 with SMTP id
 5b1f17b1804b1-438912dbfedmr301689695e9.0.1737711958891; 
 Fri, 24 Jan 2025 01:45:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcKxLRNPH6+Vb+/kuM5n2ydl7ljcmwAtFnlrV/Mkt0GOVQfsfWpizmqsmwqwNmCiEoJg7jKQ==
X-Received: by 2002:a05:600c:348c:b0:434:f1d5:1453 with SMTP id
 5b1f17b1804b1-438912dbfedmr301689345e9.0.1737711958388; 
 Fri, 24 Jan 2025 01:45:58 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47f0fdsm20856125e9.5.2025.01.24.01.45.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:45:57 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 37/48] rust: pl011: hide unnecessarily "pub" items from outside
 pl011::device
Date: Fri, 24 Jan 2025 10:44:31 +0100
Message-ID: <20250124094442.13207-38-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124094442.13207-1-pbonzini@redhat.com>
References: <20250124094442.13207-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

The only public interfaces for pl011 are TYPE_PL011 and pl011_create.
Remove pub from everything else.

Note: the "allow(dead_code)" is removed later.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs       |  2 +-
 rust/hw/char/pl011/src/device_class.rs |  2 +-
 rust/hw/char/pl011/src/lib.rs          | 13 ++++++++-----
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index c0b53f2515c..c8496eeb1b6 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -573,7 +573,7 @@ pub fn post_load(&mut self, _version_id: u32) -> Result<(), ()> {
 }
 
 /// Which bits in the interrupt status matter for each outbound IRQ line ?
-pub const IRQMASK: [u32; 6] = [
+const IRQMASK: [u32; 6] = [
     /* combined IRQ */
     Interrupt::E
         | Interrupt::MS
diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/src/device_class.rs
index 6fa14ca0f9b..2336a768729 100644
--- a/rust/hw/char/pl011/src/device_class.rs
+++ b/rust/hw/char/pl011/src/device_class.rs
@@ -19,7 +19,7 @@ extern "C" fn pl011_clock_needed(opaque: *mut c_void) -> bool {
 }
 
 /// Migration subsection for [`PL011State`] clock.
-pub static VMSTATE_PL011_CLOCK: VMStateDescription = VMStateDescription {
+static VMSTATE_PL011_CLOCK: VMStateDescription = VMStateDescription {
     name: c_str!("pl011/clock").as_ptr(),
     version_id: 1,
     minimum_version_id: 1,
diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
index d10f0805aac..2baacba2306 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -27,9 +27,11 @@
 
 use qemu_api::c_str;
 
-pub mod device;
-pub mod device_class;
-pub mod memory_ops;
+mod device;
+mod device_class;
+mod memory_ops;
+
+pub use device::pl011_create;
 
 pub const TYPE_PL011: &::std::ffi::CStr = c_str!("pl011");
 pub const TYPE_PL011_LUMINARY: &::std::ffi::CStr = c_str!("pl011_luminary");
@@ -42,7 +44,7 @@
 #[allow(non_camel_case_types)]
 #[repr(u64)]
 #[derive(Debug, qemu_api_macros::TryInto)]
-pub enum RegisterOffset {
+enum RegisterOffset {
     /// Data Register
     ///
     /// A write to this register initiates the actual data transmission
@@ -98,7 +100,8 @@ pub enum RegisterOffset {
     //Reserved = 0x04C,
 }
 
-pub mod registers {
+#[allow(dead_code)]
+mod registers {
     //! Device registers exposed as typed structs which are backed by arbitrary
     //! integer bitmaps. [`Data`], [`Control`], [`LineControl`], etc.
     use bilge::prelude::*;
-- 
2.48.1


