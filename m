Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4696FC02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 09:28:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYidE-0002XL-9s; Fri, 17 Jan 2025 04:27:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYidC-0002Wb-C9
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:27:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYid9-0003Ow-Ld
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:27:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737106027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LHIx6YD9KYcmWShWQUyELs6YliSZmQn+Rg6KU2NYAh4=;
 b=QPToVZb3ADcInUZOFQrc2AHxCzslEHIOEI4l9kaq1FueMA2NR/HIUJJUlWshVxrQ/MwNPl
 q1LWts8mYqq8+aOxLL4kK4TanNHhZtdFcDFfvMVqSrJA3i6J84meDx+S4YdtwlK+hvogb1
 WjwiHSwI0CuLKhI2WRai6+37GVQJY3s=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-uwfYejEsOH62yIio6_A-DQ-1; Fri, 17 Jan 2025 04:27:05 -0500
X-MC-Unique: uwfYejEsOH62yIio6_A-DQ-1
X-Mimecast-MFC-AGG-ID: uwfYejEsOH62yIio6_A-DQ
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-aa6732a1af5so180997966b.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 01:27:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737106024; x=1737710824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LHIx6YD9KYcmWShWQUyELs6YliSZmQn+Rg6KU2NYAh4=;
 b=omst0zTzz+RupVOig8Mpk7/D1beFS9sFpv56kaGvdE4KNkdVV/3zilQm2i/sJZVeAq
 Np7CegtGfiYruLSxgxitZ0o5fHsRHEOfsjckf4lBYZhY7J7fEiZKoPBB0dHDO5fBeSVc
 /9rNyXoJVavbDhpuDW4wTUUtORf6vh1/s7MnGMInvrZrPwp798W5/GV0XpujH3CpQfkr
 W8BF5Y7x7x1sDOqncqx4uS9q7hVzr6NNxEGXtIK5y+1AAMcZLql6h7/habUOcluIP++u
 QW2zkms421UOSWzsqxG+Rpb3PpfO3bH/UTQHeoM9bV1c5arv7ET7TlXDmNav54EsSFVV
 vzxA==
X-Gm-Message-State: AOJu0YwbS1JUW0fGpsZsAZc5wVYTIpPp86llghetgty3qCbiAisGV8qp
 PDpOE2q1EEOHs9DpK2apt9V4aUTqhjZOaZaZpGCMmfY3IIGgnof24glWYh1CW4gVBkRML4E3E4Y
 G15MuBZOfrpT0Aai0s/kMhl/DfaDgUfPh4oCDwEoonIdWhxTDMM5usmwN3DufUxJovgQpruHNiG
 6L7E6GWnuVD/r8V/29WbL+Z+Hl7GXz0JPc8GOlHS4=
X-Gm-Gg: ASbGncuW1G7IeRegP8fGXspe/DvWBOfnHy6Q+jawifB/j6C0OhrWYwqQNNIWNd8DeSn
 5ZeP2TKlTXWrposQnslL3VXNNsLstZS1TSgZU/YXv/cKNE3Z39SQtGY4aAcsJgH5PDXUmFcNMi3
 wOUbDNCP665jRIztfbMKxo/375K4AV38hAToI3gcxHq7jFyxJMTzNDEp6ZOuftnzi/5QvvtmP8j
 7SVlzZKRbnwABCedm7ZUzkq1YLWBarP2DJNJ2eqIFYHT8tGBFBKZf4P6Ajd
X-Received: by 2002:a17:906:cec6:b0:ab3:85eb:377b with SMTP id
 a640c23a62f3a-ab38b4c6c1emr183550566b.53.1737106023649; 
 Fri, 17 Jan 2025 01:27:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHM0mJvtY8pA+DH5mVS/e7Ey0Sz1Ooyy8eupg8JIcJnYdQkWvqa0bYjt8ezufRBrw2WpLuJxw==
X-Received: by 2002:a17:906:cec6:b0:ab3:85eb:377b with SMTP id
 a640c23a62f3a-ab38b4c6c1emr183548266b.53.1737106023163; 
 Fri, 17 Jan 2025 01:27:03 -0800 (PST)
Received: from [192.168.10.3] ([176.206.124.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384c74cd8sm139482366b.3.2025.01.17.01.27.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 01:27:02 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 02/10] rust: pl011: hide unnecessarily "pub" items from
 outside pl011::device
Date: Fri, 17 Jan 2025 10:26:49 +0100
Message-ID: <20250117092657.1051233-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117092657.1051233-1-pbonzini@redhat.com>
References: <20250117092657.1051233-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The only public interfaces for pl011 are TYPE_PL011 and pl011_create.
Remove pub from everything else.

Note: the "allow(dead_code)" is removed later.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs       |  2 +-
 rust/hw/char/pl011/src/device_class.rs |  2 +-
 rust/hw/char/pl011/src/lib.rs          | 13 ++++++++-----
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 11a87664c7a..e85e46ba0bb 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -565,7 +565,7 @@ pub fn post_load(&mut self, _version_id: u32) -> Result<(), ()> {
 }
 
 /// Which bits in the interrupt status matter for each outbound IRQ line ?
-pub const IRQMASK: [u32; 6] = [
+const IRQMASK: [u32; 6] = [
     /* combined IRQ */
     Interrupt::E
         | Interrupt::MS
diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/src/device_class.rs
index b052d98803f..2fd805fd12d 100644
--- a/rust/hw/char/pl011/src/device_class.rs
+++ b/rust/hw/char/pl011/src/device_class.rs
@@ -21,7 +21,7 @@ extern "C" fn pl011_clock_needed(opaque: *mut c_void) -> bool {
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
2.47.1


