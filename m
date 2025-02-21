Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCE1C021B6
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 17:05:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlWRX-0006oA-Lv; Fri, 21 Feb 2025 12:04:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tlWRP-0006gf-43
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 12:03:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tlWRN-0001OX-6E
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 12:03:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740157432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1nJY4+DKOnRdgOSJbixQgGwalcHO4gTnjYN+sbdUtTI=;
 b=RlNjmN6xySA3oVcoGWhUlY34d9rNJwWK5cccg1hOnU+FAaa862hkO+Q7PJya3uuw9M/sVN
 tnZrUWm2mWxDk0mk7+4yzrf5GKURmrV8c7BwdNJI4gFCyy746GEcn2AaiY7xWdfilDivvp
 f/LzX9ivGsxsrD1FoO3J9ovFBeQX9n4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-IUY3wfD4MUKy81kSyCNTZQ-1; Fri, 21 Feb 2025 12:03:50 -0500
X-MC-Unique: IUY3wfD4MUKy81kSyCNTZQ-1
X-Mimecast-MFC-AGG-ID: IUY3wfD4MUKy81kSyCNTZQ_1740157430
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38f3eb82fceso1122071f8f.0
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 09:03:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740157429; x=1740762229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1nJY4+DKOnRdgOSJbixQgGwalcHO4gTnjYN+sbdUtTI=;
 b=guAb+JSihzZsvCKv2/dK7xmFCCSBelZwjTHwU2XQg1kS3471puT3I0oTe5goXnEmCL
 mo2Keem2+D82BMOcfD36qxogoyT73QWCoM4/KGOpOsgaJwX/2A0BeSW/jaGgX9PiXKkG
 lMFwEyAepeQzONEJ1djT74YHsXpVXPavZxqoGPblCoFmTxnme1+7YfA0fqidWSSZPPLK
 uAmEemPeAYR0021HkvYCc0ovOdZzqI9dOFkAb3ROzQQrC45uT0cHsCZz5V06MUoDzKqE
 s/08U5oKyjAAcDNstUwdK1qFDfmpwZpSfrF8C4n28xPPqgmekcqEd66Uok7V741y4fcX
 YGwg==
X-Gm-Message-State: AOJu0Yz/lzoM92ZPvB04dI5PfwJXOoUYxLftkcXUpddPOfh+Dn0D4EC+
 PkBYNXwck4JWBTt5x9LaAzR3OXvaenICLOuIC3+cyxGO+D3x3rZrD0Jx52dJeu1DuyOlE7tcCHX
 nffeyv38g5BYcXWcF4kPme/hTY6ov7+Qu1z8MbG3KnAYGUdA994/0tEV2IV2yqjIDv8JTC+eLAO
 eMnLKUrFyTuI2n8QpUih7f8fuNEeF7OMnR1eZSskI=
X-Gm-Gg: ASbGncs+7ZbvDQCeBjbH0T+zR2HRosHm99m+pvdaTvgaoZzcroevdEk4b1MtZ/i/UBM
 mCVotZ5Qv5dAEoqFwFLhEMFwIBUmub76PKMdICE0vXhooFwQHLRaqTmq6Pn1FAaaohLeo+Vt35T
 nMZmq1HLRIg9jQiUUiOz50wOQMQfiXc/WibyhLLhUIKCIfWeOasDPDSPMNFg0jVV8rCsE8prfBM
 XvbnEaEfIPHk5DOHJYkTLLJ3MJDwVDVAqiWxhrRJQhGYwd/vIoZMBAGEzuMBPjwaKaalfQygFBz
 zzi/EH3v6KVLgm1lFIk=
X-Received: by 2002:a5d:4e87:0:b0:38d:a879:4778 with SMTP id
 ffacd0b85a97d-38f6f0529bbmr3684301f8f.33.1740157428526; 
 Fri, 21 Feb 2025 09:03:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHSCdTAjM6t/EsZj2CvLBtQmF/ZHcMG+AKfYF+Hr94UnN5YaIxc7Z5J3yJYVGY+iuVXnIRcg==
X-Received: by 2002:a5d:4e87:0:b0:38d:a879:4778 with SMTP id
 ffacd0b85a97d-38f6f0529bbmr3684039f8f.33.1740157426446; 
 Fri, 21 Feb 2025 09:03:46 -0800 (PST)
Received: from [192.168.10.48] ([151.95.61.185])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02f5b38sm22973835e9.24.2025.02.21.09.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 09:03:45 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 02/15] rust: add SysBusDeviceImpl
Date: Fri, 21 Feb 2025 18:03:29 +0100
Message-ID: <20250221170342.63591-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221170342.63591-1-pbonzini@redhat.com>
References: <20250221170342.63591-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
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

The only function, right now, is to ensure that anything with a
SysBusDeviceClass class is a SysBusDevice.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 5 ++++-
 rust/hw/timer/hpet/src/hpet.rs   | 4 +++-
 rust/qemu-api/src/sysbus.rs      | 8 +++++---
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index fe73771021e..7063b60c0cc 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -20,7 +20,7 @@
     prelude::*,
     qdev::{Clock, ClockEvent, DeviceImpl, DeviceState, Property, ResetType, ResettablePhasesImpl},
     qom::{ClassInitImpl, ObjectImpl, Owned, ParentField},
-    sysbus::{SysBusDevice, SysBusDeviceClass},
+    sysbus::{SysBusDevice, SysBusDeviceClass, SysBusDeviceImpl},
     vmstate::VMStateDescription,
 };
 
@@ -176,6 +176,8 @@ impl ResettablePhasesImpl for PL011State {
     const HOLD: Option<fn(&Self, ResetType)> = Some(Self::reset_hold);
 }
 
+impl SysBusDeviceImpl for PL011State {}
+
 impl PL011Registers {
     pub(self) fn read(&mut self, offset: RegisterOffset) -> (bool, u32) {
         use RegisterOffset::*;
@@ -746,3 +748,4 @@ impl ObjectImpl for PL011Luminary {
 
 impl DeviceImpl for PL011Luminary {}
 impl ResettablePhasesImpl for PL011Luminary {}
+impl SysBusDeviceImpl for PL011Luminary {}
diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index 75ff5b3e8d6..b4ffccf815f 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -23,7 +23,7 @@
     qdev::{DeviceImpl, DeviceMethods, DeviceState, Property, ResetType, ResettablePhasesImpl},
     qom::{ObjectImpl, ObjectType, ParentField},
     qom_isa,
-    sysbus::SysBusDevice,
+    sysbus::{SysBusDevice, SysBusDeviceImpl},
     timer::{Timer, CLOCK_VIRTUAL},
 };
 
@@ -887,3 +887,5 @@ fn properties() -> &'static [Property] {
 impl ResettablePhasesImpl for HPETState {
     const HOLD: Option<fn(&Self, ResetType)> = Some(Self::reset_hold);
 }
+
+impl SysBusDeviceImpl for HPETState {}
diff --git a/rust/qemu-api/src/sysbus.rs b/rust/qemu-api/src/sysbus.rs
index fa36e12178f..fee2e3d478f 100644
--- a/rust/qemu-api/src/sysbus.rs
+++ b/rust/qemu-api/src/sysbus.rs
@@ -14,7 +14,7 @@
     irq::{IRQState, InterruptSource},
     memory::MemoryRegion,
     prelude::*,
-    qdev::{DeviceClass, DeviceState},
+    qdev::{DeviceClass, DeviceImpl, DeviceState},
     qom::{ClassInitImpl, Owned},
 };
 
@@ -25,10 +25,12 @@ unsafe impl ObjectType for SysBusDevice {
 }
 qom_isa!(SysBusDevice: DeviceState, Object);
 
-// TODO: add SysBusDeviceImpl
+// TODO: add virtual methods
+pub trait SysBusDeviceImpl: DeviceImpl + IsA<SysBusDevice> {}
+
 impl<T> ClassInitImpl<SysBusDeviceClass> for T
 where
-    T: ClassInitImpl<DeviceClass>,
+    T: SysBusDeviceImpl + ClassInitImpl<DeviceClass>,
 {
     fn class_init(sdc: &mut SysBusDeviceClass) {
         <T as ClassInitImpl<DeviceClass>>::class_init(&mut sdc.parent_class);
-- 
2.48.1


