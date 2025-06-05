Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF8AC5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 10:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN7eP-0008HX-VO; Thu, 05 Jun 2025 06:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uN7dv-0007R8-4A
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:16:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uN7dt-0001Jy-Cp
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749118572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ElGaxLGiSIb6e5dqiWIlm8oesZYBfD74a0jBFqGIj5Q=;
 b=C77U02S3NJIie0LxA+PaIF2nFaAyP6FaHx3yYKEKhBg8vDP4QE5fTt2UCjknmfa2Qdhhmt
 Nr4KjX2jqaK+Bl5dpxpyASVWDd+zxz57aAcjvKgj0ZNxk5CBZGnkHCZG8F+Df9csTXbQ81
 kJHbQVJKM6Wmd4dbvX4lBGeNFQyxM1M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-hLJWwzgHMdamYYUew9mbUg-1; Thu, 05 Jun 2025 06:16:11 -0400
X-MC-Unique: hLJWwzgHMdamYYUew9mbUg-1
X-Mimecast-MFC-AGG-ID: hLJWwzgHMdamYYUew9mbUg_1749118571
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-451deff247cso8827775e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 03:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749118569; x=1749723369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ElGaxLGiSIb6e5dqiWIlm8oesZYBfD74a0jBFqGIj5Q=;
 b=qTkLAHO9hy8nOuiTpbBo+MqgN9n8Vctz/fK8//5axwRsPmP16j/yq8XQ7++6ATW99j
 En60/byvTOKZWszppNTWnMh3RXMfJJRmh4lVh+orIFENasP9htJgI30t0rhk4TadFNfU
 xdC/dhUdGhzdQUHWnwKNLH/nf4xmmPL/IhXvyCG3qkabT7IVVLsPS0/CgGDbi6usn9go
 FZX1PZCOGJ468rlzc561KK9BLnkHAZscrftqlTuQZQByrTChDL0vh0FOqeaONqZqZpM6
 tSvkXoqKlGGfvyNb3+0O8YJgK4KaBQtMD5cnsKyt345bQbW1qTvLoxMYsF8GLFUHvYJE
 ROOQ==
X-Gm-Message-State: AOJu0YyUSlX789iZggYieqhXHpvvJLJqf65g87Dyg6A74DvvGbo2Jeuw
 5R83tUH59weUpBiU6waEcX2vh0le+tTg7Se+aoek2YzciOPUv6ss7XWuhz2oBKel9RtruD68FVR
 zWAihD6zHyse0wMU+0XGAYInye/5dIMb9opm3FpVXDAsRJqWp5S2aFL8z0ue9WRCX1MX6lyg/lj
 MHvSn9rizZudDqv2NbNxtfGupmLF5WCudz8nMMZMWE
X-Gm-Gg: ASbGncsx8OUQhXazy++scV+x7LaNzHyweA0O83+Cwgoqm1jnZafygEbJ93i4T2TiGL8
 WaWB1zZcmooNSJXnugkhYd2T3beakHkz3YAukeSYZk8fDaXhOFHvLoiTfbd/5461STxRZhdw22g
 oovzUvuvFw8ObIPRMQf2PQJP01VtYA+RzCYVXFBVdBvOiesby5p07Sx30AuKPpWx9hL627s3i72
 kmD0X+oYCaoX0HN9m3DAMfX7rVG6XX8hlnv1heg6B79cOK1Ht4ePfi7Q/HXP6zxUVPOucEHKE/X
 imQEJqxU4hJqtQ==
X-Received: by 2002:a05:6000:18a5:b0:3a4:c71a:8119 with SMTP id
 ffacd0b85a97d-3a526e177e2mr2653822f8f.25.1749118569541; 
 Thu, 05 Jun 2025 03:16:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFexuyaMbmm442Va0w1BVBm9wRa4lrks6P9WJvlUyrZBJQKvIBXc7IZmgqSmfuQ4DHPDyU76w==
X-Received: by 2002:a05:6000:18a5:b0:3a4:c71a:8119 with SMTP id
 ffacd0b85a97d-3a526e177e2mr2653783f8f.25.1749118569080; 
 Thu, 05 Jun 2025 03:16:09 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a525da8e66sm2431935f8f.38.2025.06.05.03.16.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 03:16:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	zhao1.liu@intel.com,
	qemu-rust@nongnu.org
Subject: [PATCH 09/14] rust/hpet: change type of num_timers to usize
Date: Thu,  5 Jun 2025 12:15:38 +0200
Message-ID: <20250605101544.368953-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605101544.368953-1-pbonzini@redhat.com>
References: <20250605101544.368953-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

Remove the need to convert after every read of the BqlCell.  Because the
vmstate uses a u8 as the size of the VARRAY, this requires switching
the VARRAY to use num_timers_save; which in turn requires ensuring that
the num_timers_save is always there.  For simplicity do this by
removing support for version 1, which QEMU has not been producing for
~15 years.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/device.rs | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 68c82b09b60..a957de1e767 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -12,7 +12,7 @@
 use qemu_api::{
     bindings::{
         address_space_memory, address_space_stl_le, qdev_prop_bit, qdev_prop_bool,
-        qdev_prop_uint32, qdev_prop_uint8,
+        qdev_prop_uint32, qdev_prop_usize,
     },
     cell::{BqlCell, BqlRefCell},
     irq::InterruptSource,
@@ -36,9 +36,9 @@
 const HPET_REG_SPACE_LEN: u64 = 0x400; // 1024 bytes
 
 /// Minimum recommended hardware implementation.
-const HPET_MIN_TIMERS: u8 = 3;
+const HPET_MIN_TIMERS: usize = 3;
 /// Maximum timers in each timer block.
-const HPET_MAX_TIMERS: u8 = 32;
+const HPET_MAX_TIMERS: usize = 32;
 
 /// Flags that HPETState.flags supports.
 const HPET_FLAG_MSI_SUPPORT_SHIFT: usize = 0;
@@ -561,8 +561,8 @@ pub struct HPETState {
 
     /// HPET timer array managed by this timer block.
     #[doc(alias = "timer")]
-    timers: [BqlRefCell<HPETTimer>; HPET_MAX_TIMERS as usize],
-    num_timers: BqlCell<u8>,
+    timers: [BqlRefCell<HPETTimer>; HPET_MAX_TIMERS],
+    num_timers: BqlCell<usize>,
     num_timers_save: BqlCell<u8>,
 
     /// Instance id (HPET timer block ID).
@@ -572,7 +572,7 @@ pub struct HPETState {
 impl HPETState {
     // Get num_timers with `usize` type, which is useful to play with array index.
     fn get_num_timers(&self) -> usize {
-        self.num_timers.get().into()
+        self.num_timers.get()
     }
 
     const fn has_msi_flag(&self) -> bool {
@@ -854,7 +854,7 @@ fn pre_save(&self) -> i32 {
          * also added to the migration stream.  Check that it matches the value
          * that was configured.
          */
-        self.num_timers_save.set(self.num_timers.get());
+        self.num_timers_save.set(self.num_timers.get() as u8);
         0
     }
 
@@ -884,7 +884,7 @@ fn is_offset_needed(&self) -> bool {
     }
 
     fn validate_num_timers(&self, _version_id: u8) -> bool {
-        self.num_timers.get() == self.num_timers_save.get()
+        self.num_timers.get() == self.num_timers_save.get().into()
     }
 }
 
@@ -911,7 +911,7 @@ impl ObjectImpl for HPETState {
         c"timers",
         HPETState,
         num_timers,
-        unsafe { &qdev_prop_uint8 },
+        unsafe { &qdev_prop_usize },
         u8,
         default = HPET_MIN_TIMERS
     ),
@@ -1016,16 +1016,16 @@ impl ObjectImpl for HPETState {
 static VMSTATE_HPET: VMStateDescription = VMStateDescription {
     name: c"hpet".as_ptr(),
     version_id: 2,
-    minimum_version_id: 1,
+    minimum_version_id: 2,
     pre_save: Some(hpet_pre_save),
     post_load: Some(hpet_post_load),
     fields: vmstate_fields! {
         vmstate_of!(HPETState, config),
         vmstate_of!(HPETState, int_status),
         vmstate_of!(HPETState, counter),
-        vmstate_of!(HPETState, num_timers_save).with_version_id(2),
+        vmstate_of!(HPETState, num_timers_save),
         vmstate_validate!(HPETState, VALIDATE_TIMERS_NAME, HPETState::validate_num_timers),
-        vmstate_struct!(HPETState, timers[0 .. num_timers], &VMSTATE_HPET_TIMER, BqlRefCell<HPETTimer>, HPETState::validate_num_timers).with_version_id(0),
+        vmstate_struct!(HPETState, timers[0 .. num_timers_save], &VMSTATE_HPET_TIMER, BqlRefCell<HPETTimer>, HPETState::validate_num_timers).with_version_id(0),
     },
     subsections: vmstate_subsections! {
         VMSTATE_HPET_RTC_IRQ_LEVEL,
-- 
2.49.0


