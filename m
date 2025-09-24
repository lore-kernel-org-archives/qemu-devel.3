Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF18CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:30:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Lp1-0005Hz-FM; Wed, 24 Sep 2025 05:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1Loy-0005GJ-CL
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:29:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1Lot-0004pd-2E
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758706187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DQUPVZSKZhpdKrFkjv8ftxjx2NnW+jSnVDAPdZWCuMI=;
 b=XLZ8uvtJTyjRAGxxrbZG1XSXCHgKK7YMY9tgodZA+buF8JP9OLhOEf91xQ+BikjasSrc8G
 QapPQscXw0SCIYXC5ZARamLP8AMvoK823DbNWt0iJBW0cxAeBbnE8wm5QT1PYe+jk/YVnT
 VNFeV1S8tPBvbHONJUKwraD+I9wnUNE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-ivMewdKTOiWlriHp0i0aiQ-1; Wed, 24 Sep 2025 05:29:46 -0400
X-MC-Unique: ivMewdKTOiWlriHp0i0aiQ-1
X-Mimecast-MFC-AGG-ID: ivMewdKTOiWlriHp0i0aiQ_1758706185
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b04a8ae1409so640533666b.2
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 02:29:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758706184; x=1759310984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DQUPVZSKZhpdKrFkjv8ftxjx2NnW+jSnVDAPdZWCuMI=;
 b=q/ZV5+KdOois4+1Wr3uywbqco6wrSwFT27KyTD1/F5zm2wJLzRzCDtmi+Z84Lul7X2
 ANTTKcvW+sWEKzLCVxjajqEU9LzGt4by30BPIhoiY2f9IDDsT1UEue/OqD+wiLGfLb5A
 xcgf0sqd0j8sJf4URCF889/vbmsdSw2F0duF0cSIgbIN78Io+05Pubq+osdBuptP2OYp
 5gWUAJKGdRH6PDutOwP/T8qetX8ddoeu6l8bwflGzBixMicmK3hj2wTqHgp/uhSGwocw
 QxpcNFVQFxOdq1hynHvlql4mKNzM3IoO1YeUYhry5ebrDQ4ETmuFqYHCGxW9XduaJj2o
 EPBg==
X-Gm-Message-State: AOJu0YzeeYZX0Qg+zSMv4/8L8OnlRPqSIdIthLGLgCo/DBT9sMZHnhMU
 IFcLeBETKP/G0j2qxkoiRdNnLebvg3eXk2j9qzou9vnNbo7X3qFVUMOIYjgdxG//8zYLHSKGtos
 7T+EkNRcqbDtZam/RWDA0LbdR7F86Zc1SfuiIfcixiNXlZpYb5gDPpJq5TnysJY2+rhhR1t+VIp
 x3pVaCq+4hmC3kFdKAA5kSJkwsSRQas1cNwS/pDwYm
X-Gm-Gg: ASbGncvBxq7r5IuaXXot15tlG3+epihM2fjJp0+FVTZEJpAsr7ehkYptVUNyOLCDKIc
 oGxfzYbNL4Jhm+x/KjjYTrFVWgMB5QH1MpobpY8MgzpFW9hkqZST74TZQVLUvMn9dszNHB3FlDH
 bOK6g7p5XjmBog2NGhH8p4kJtKbN2JJniGSz/Y6xPHeZajErz53kI8Z/4DS6RuWQWX+NPUPQGHm
 wfQaBbmKuEmCDcp3ce+kLKv+eQPU0w1iWg+1daiYFCiIe8osxbCAYy0rwkI3Ujgsni+NQjFE9n0
 DoJCV9U4R8G5UgU2j20u/ZN8EqbF/OV8tj5/lIce4CxuMeceMYufZtn/x1kxLGatqPuSPCj8k9E
 QRRQ1Xz0qgkTIxIJRPeOL20MQM4uzxYf0Ar8tA95pcF1+Lw==
X-Received: by 2002:a17:906:f042:b0:b29:d157:9a0f with SMTP id
 a640c23a62f3a-b302802deaamr572549366b.25.1758706184059; 
 Wed, 24 Sep 2025 02:29:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFjqcNYeRBMBFY7tRlEFITHRc3g1r3wmija6z20r8YuFPyxyD9EQMTiZ6yI2N44RtjZZYU/g==
X-Received: by 2002:a17:906:f042:b0:b29:d157:9a0f with SMTP id
 a640c23a62f3a-b302802deaamr572547166b.25.1758706183561; 
 Wed, 24 Sep 2025 02:29:43 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b1fd271f895sm1489702866b.97.2025.09.24.02.29.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 02:29:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 17/29] rust/hpet: Convert qdev properties to #property macro
Date: Wed, 24 Sep 2025 11:28:37 +0200
Message-ID: <20250924092850.42047-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924092850.42047-1-pbonzini@redhat.com>
References: <20250924092850.42047-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

Convert HPET's properties to #property macro:
 * num_timers: usize property.
 * flags: u32 bit property.
 * int_route_cap: u32 property.
 * hpet_offset_saved: bool property.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20250920160520.3699591-12-zhao1.liu@intel.com
---
 rust/hw/timer/hpet/src/device.rs | 55 ++++----------------------------
 1 file changed, 7 insertions(+), 48 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index fce75415579..86638c07666 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -13,9 +13,8 @@
 use bql::{BqlCell, BqlRefCell};
 use common::{bitops::IntegerExt, uninit_field_mut};
 use hwcore::{
-    bindings::{qdev_prop_bit, qdev_prop_bool, qdev_prop_uint32, qdev_prop_usize},
-    declare_properties, define_property, DeviceImpl, DeviceMethods, DeviceState, InterruptSource,
-    Property, ResetType, ResettablePhasesImpl, SysBusDevice, SysBusDeviceImpl, SysBusDeviceMethods,
+    DeviceImpl, DeviceMethods, DeviceState, InterruptSource, ResetType, ResettablePhasesImpl,
+    SysBusDevice, SysBusDeviceImpl, SysBusDeviceMethods,
 };
 use migration::{
     self, impl_vmstate_struct, vmstate_fields, vmstate_of, vmstate_subsections, vmstate_validate,
@@ -520,7 +519,7 @@ fn write(&mut self, reg: TimerRegister, value: u64, shift: u32, len: u32) {
 
 /// HPET Event Timer Block Abstraction
 #[repr(C)]
-#[derive(qom::Object)]
+#[derive(qom::Object, hwcore::Device)]
 pub struct HPETState {
     parent_obj: ParentField<SysBusDevice>,
     iomem: MemoryRegion,
@@ -540,10 +539,12 @@ pub struct HPETState {
     // Internal state
     /// Capabilities that QEMU HPET supports.
     /// bit 0: MSI (or FSB) support.
+    #[property(rename = "msi", bit = HPET_FLAG_MSI_SUPPORT_SHIFT as u8, default = false)]
     flags: u32,
 
     /// Offset of main counter relative to qemu clock.
     hpet_offset: BqlCell<u64>,
+    #[property(rename = "hpet-offset-saved", default = true)]
     hpet_offset_saved: bool,
 
     irqs: [InterruptSource; HPET_NUM_IRQ_ROUTES],
@@ -555,11 +556,13 @@ pub struct HPETState {
     /// the timers' interrupt can be routed, and is encoded in the
     /// bits 32:64 of timer N's config register:
     #[doc(alias = "intcap")]
+    #[property(rename = "hpet-intcap", default = 0)]
     int_route_cap: u32,
 
     /// HPET timer array managed by this timer block.
     #[doc(alias = "timer")]
     timers: [BqlRefCell<HPETTimer>; HPET_MAX_TIMERS],
+    #[property(rename = "timers", default = HPET_MIN_TIMERS)]
     num_timers: usize,
     num_timers_save: BqlCell<u8>,
 
@@ -901,44 +904,6 @@ impl ObjectImpl for HPETState {
     const CLASS_INIT: fn(&mut Self::Class) = Self::Class::class_init::<Self>;
 }
 
-// TODO: Make these properties user-configurable!
-declare_properties! {
-    HPET_PROPERTIES,
-    define_property!(
-        c"timers",
-        HPETState,
-        num_timers,
-        unsafe { &qdev_prop_usize },
-        usize,
-        default = HPET_MIN_TIMERS
-    ),
-    define_property!(
-        c"msi",
-        HPETState,
-        flags,
-        unsafe { &qdev_prop_bit },
-        u32,
-        bit = HPET_FLAG_MSI_SUPPORT_SHIFT as u8,
-        default = false,
-    ),
-    define_property!(
-        c"hpet-intcap",
-        HPETState,
-        int_route_cap,
-        unsafe { &qdev_prop_uint32 },
-        u32,
-        default = 0
-    ),
-    define_property!(
-        c"hpet-offset-saved",
-        HPETState,
-        hpet_offset_saved,
-        unsafe { &qdev_prop_bool },
-        bool,
-        default = true
-    ),
-}
-
 static VMSTATE_HPET_RTC_IRQ_LEVEL: VMStateDescription<HPETState> =
     VMStateDescriptionBuilder::<HPETState>::new()
         .name(c"hpet/rtc_irq_level")
@@ -1001,12 +966,6 @@ impl ObjectImpl for HPETState {
         ))
         .build();
 
-// SAFETY: HPET_PROPERTIES is a valid Property array constructed with the
-// hwcore::declare_properties macro.
-unsafe impl hwcore::DevicePropertiesImpl for HPETState {
-    const PROPERTIES: &'static [Property] = &HPET_PROPERTIES;
-}
-
 impl DeviceImpl for HPETState {
     const VMSTATE: Option<VMStateDescription<Self>> = Some(VMSTATE_HPET);
     const REALIZE: Option<fn(&Self) -> util::Result<()>> = Some(Self::realize);
-- 
2.51.0


