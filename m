Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E107C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:46:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGGm-000811-9K; Fri, 24 Jan 2025 04:46:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFq-00077U-Tt
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFp-0003ub-8S
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=byv7yqpioTnmhdGEjf7rdV0DYWcU89djOSCRL0A/xmg=;
 b=FcqrFQtBqMy9Mrbty5KFQeS8hT1ZooDw3l/6mIrFBdtH1L7QQSeFSdrCwVdRAwDxcX58iF
 MnnkomxevpNXFHf5/6k2PyP2t82xBLx44l0LtHr7MkIPZfx49jwMjjz8qXlbGUiWOD7cUQ
 +5yHm0Y/KSSZ2g6YQylUDJoZMfRBP6M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-shqhB78XNDGRulA6wtJzjQ-1; Fri, 24 Jan 2025 04:45:29 -0500
X-MC-Unique: shqhB78XNDGRulA6wtJzjQ-1
X-Mimecast-MFC-AGG-ID: shqhB78XNDGRulA6wtJzjQ
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38bf4913669so1009980f8f.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:45:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711928; x=1738316728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=byv7yqpioTnmhdGEjf7rdV0DYWcU89djOSCRL0A/xmg=;
 b=G0fKARIazDxLmaNUjFC2Bo2hV/Xw2UyPgtOw0w6fi9/OUUfka37hJAqU/2fv3AZJVn
 lTye/L9eprtLTna73mfSgkSoaIbkmOtXE3bjbV/78kscpxGjNaNZIkaS+BYNEaRjROTC
 TI8b7BGHhDOzfQV6FPECzal6ppUPTBwJ8EykqDb987mVFO2e5f4IB14eNl8QTTAKfVm+
 5fnO5EQm2hTbgXPPUAEixMXfW8ncGkALLu2RkM2Qk5V0DgOTKvq25ksGNP2pCKFlZUT/
 YwwXSmfgsrP7bYNUT9RZKKwbRWmj1qtkXjvnphQwtWvskjJUVqYVeiwTVUM3KjUW5tG3
 sKzw==
X-Gm-Message-State: AOJu0YwwpeqL7TQnGdC6FYYBh74BGf38unfg4g4we6279Yy5XvwF8Rws
 5f7wMbCiBkgtTQm41gMo8dgCp2Uc6IDUsbGPxNuWjuPyHuicPxoBN1Qop60+PXq1TNfegiBWIKL
 OyGLhXAp1BTe7Ys2sR0Lcg+aLgyugyEOtKaY0QnJmOAeotYNRp4HRvZQZCcVAe82OAzV/hDQJA5
 oIxEhzI8wPTFS5tXbvLlSbGdjaBFk7bBg8Mki8tOA=
X-Gm-Gg: ASbGnct/tx+uaCBw/gIOpCOdGC+P/k2eBFXTBkvltUQOP6pfcjCCsbOsa3Jr8usVUEG
 p4RXVOadi2nPh4NwkMvWWL3f+xm9CDASRZ7Cq+cT6TTjoPauki4b6Z59MlGZJmxlptvwYsKm1jX
 OSKc/nqJ9N+C0qJz93jQBvfBVqB9TgAh+p684xYdfjP0fMTu+iH1rM4euGu8TxTLIwiGR1Cz5wf
 goZE5HjbPlUMJX1Lqng5WCsKQAULN7LiTvi5Z4vR7c1XCMMhQH8vMBhAwNkEUMe2QWyqMM4AA==
X-Received: by 2002:a5d:4007:0:b0:38a:888c:7dec with SMTP id
 ffacd0b85a97d-38bf5675e61mr24559857f8f.28.1737711927975; 
 Fri, 24 Jan 2025 01:45:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF36MJ7Wpp4C/FN9fV3gHTkz7acfg7AbPrgVBQAHzyYek9PxgiL8sTcBAlcoWis9fG+Kci8kA==
X-Received: by 2002:a5d:4007:0:b0:38a:888c:7dec with SMTP id
 ffacd0b85a97d-38bf5675e61mr24559825f8f.28.1737711927542; 
 Fri, 24 Jan 2025 01:45:27 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1144f6sm2187016f8f.0.2025.01.24.01.45.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:45:26 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 22/48] rust/pl011: Avoid bindings::*
Date: Fri, 24 Jan 2025 10:44:16 +0100
Message-ID: <20250124094442.13207-23-pbonzini@redhat.com>
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

From: Zhao Liu <zhao1.liu@intel.com>

List all the necessary bindings to better identify gaps in rust/qapi.
And include the bindings wrapped by rust/qapi instead mapping the raw
bindings directly.

Inspired-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250121140457.84631-3-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index a0e0fbdd9dd..4f1080ff19f 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -9,12 +9,19 @@
 };
 
 use qemu_api::{
-    bindings::{self, *},
+    bindings::{
+        error_fatal, hwaddr, memory_region_init_io, qdev_init_clock_in, qdev_new,
+        qdev_prop_set_chr, qemu_chr_fe_ioctl, qemu_chr_fe_set_handlers, qemu_chr_fe_write_all,
+        qemu_irq, sysbus_connect_irq, sysbus_mmio_map, sysbus_realize_and_unref, CharBackend,
+        Chardev, Clock, ClockEvent, MemoryRegion, QEMUChrEvent, CHR_IOCTL_SERIAL_SET_BREAK,
+    },
     c_str,
     irq::InterruptSource,
     prelude::*,
-    qdev::DeviceImpl,
+    qdev::{DeviceImpl, DeviceState, Property},
     qom::{ClassInitImpl, ObjectImpl, ParentField},
+    sysbus::{SysBusDevice, SysBusDeviceClass},
+    vmstate::VMStateDescription,
 };
 
 use crate::{
@@ -494,7 +501,7 @@ pub fn can_receive(&self) -> bool {
     }
 
     pub fn event(&mut self, event: QEMUChrEvent) {
-        if event == bindings::QEMUChrEvent::CHR_EVENT_BREAK && !self.loopback_enabled() {
+        if event == QEMUChrEvent::CHR_EVENT_BREAK && !self.loopback_enabled() {
             self.put_fifo(registers::Data::BREAK.into());
         }
     }
-- 
2.48.1


