Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E69AC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 13:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taEZv-0000TZ-O8; Tue, 21 Jan 2025 08:46:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taEZe-0000RK-1d; Tue, 21 Jan 2025 08:45:46 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taEZb-0005tB-S1; Tue, 21 Jan 2025 08:45:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737467144; x=1769003144;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OsIWBqlrGVm71pj8dI8rY/GCT36H3RyHgbAeCp1q76o=;
 b=hD8g8EVbb0ZuGThAm0qkqF6NERKQNEtqcyiZ3x7Hf1ouSn8YSgZTnm9F
 Xgd/JZbgcCeTKXvO+vmejWi2zbhBxZgoPnvvHH6o3C4ZEbU7U08Vpt1NY
 Tw0VSiRKOwGprh15IdMIhG2igk55owwpXt8ZrbUMIzgakgcK5e1LG0dcc
 wlp3SpwJcyb9N9jNugQA75oSOpsTheCmrR15pnPzKytRx6DeIQgyyf+ER
 QOHEubkhv0y8QMUFLiU8e0bTCFiun/4IcZwXqwXOXbp4OfOPiNWXO4+1w
 twT587Sx677mKD13gXPd2Yq51Eenz3sGaYDagyZyi2z5aBFs8b+XDVjIz Q==;
X-CSE-ConnectionGUID: LMexH0opSHO0rJT8v/tC0A==
X-CSE-MsgGUID: TuBaYDdDQweKfMcxwkzagg==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="38123112"
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; d="scan'208";a="38123112"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 05:45:42 -0800
X-CSE-ConnectionGUID: i0quFSvGQGq7jtnfXHqbDw==
X-CSE-MsgGUID: ComJf3WDQkaqxVh6jfuklg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; d="scan'208";a="106822617"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 21 Jan 2025 05:45:40 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=83?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH RESEND 2/2] rust/pl011: Avoid bindings::*
Date: Tue, 21 Jan 2025 22:04:57 +0800
Message-Id: <20250121140457.84631-3-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250121140457.84631-1-zhao1.liu@intel.com>
References: <20250121140457.84631-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

List all the necessary bindings to better identify gaps in rust/qapi.
And include the bindings wrapped by rust/qapi instead mapping the raw
bindings directly.

Inspired-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/hw/char/pl011/src/device.rs | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index c64af2684b7d..c95ab49fd62e 100644
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
@@ -493,7 +500,7 @@ pub fn can_receive(&self) -> bool {
     }
 
     pub fn event(&mut self, event: QEMUChrEvent) {
-        if event == bindings::QEMUChrEvent::CHR_EVENT_BREAK && !self.loopback_enabled() {
+        if event == QEMUChrEvent::CHR_EVENT_BREAK && !self.loopback_enabled() {
             self.put_fifo(registers::Data::BREAK.into());
         }
     }
-- 
2.34.1


