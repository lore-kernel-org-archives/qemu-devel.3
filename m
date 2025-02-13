Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D18C021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 16:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tibfB-00010t-7z; Thu, 13 Feb 2025 11:02:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibep-0000uk-KP
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:01:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tiben-0005Yd-8k
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:01:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739462500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tt5qLjgDkzgeWvrd3siaS5OYB5bi/JKRwTeutA8JPDs=;
 b=HxoSqHhgGPA0tdtCLxjRsrPZC/EGgDbY+P/7GuofRNl+/mX+nMSVkdYhjRZRpv832pagF9
 fZ3KdmWhFN5K9owD3mRfHebiqCVYvNwZGy05Dpl5CFuBBoV7Gb/j28EnFtxDr+gQo5/coI
 +Vk05zBOdvLuztX75C95/2qHKiD6ieo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-MyoQmwq9N9GYK3iHDwzLxA-1; Thu, 13 Feb 2025 11:01:39 -0500
X-MC-Unique: MyoQmwq9N9GYK3iHDwzLxA-1
X-Mimecast-MFC-AGG-ID: MyoQmwq9N9GYK3iHDwzLxA
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4395586f952so5401285e9.2
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 08:01:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739462497; x=1740067297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tt5qLjgDkzgeWvrd3siaS5OYB5bi/JKRwTeutA8JPDs=;
 b=jRXaKmRFncAmmEnB7nGa1PMRYevkcuRnYPk/sH9ub8O0RBCtiSndS/DBVk2yJbVf0f
 nnLAAo8F4m9e8YYZnYXqzeWu8WN+xIcCnsOqrwwpHDn2RGEcwykjlKM7fB9GfHGmLwva
 WIPbifMYu+wf/VbnK1n4xjkDnK1ylZaYstcNfvVceVshkcytEV4ePNM3MM24OSnxIjcP
 y/Gx7m9omwYwSIFMhxguHs4YoRwH/yNRZajgy/y8TzIDrslAZTz3NQrFvvLFgfIK7nsT
 mmXFOOplDa4RMfHdFsAn5DYoDVSWC/83Zz1pdErw6wKr6sWHpB/x0KJsnk6SLI8Bxt3v
 IleA==
X-Gm-Message-State: AOJu0Yx77PK23PQT7B2YQrJ7rgZgvcV4M3CJUvAox6o1Nw+LHn2XX8Cu
 O4iIe5YakWm6CFoerBoysIbPbtWXnzJekRYmxWAqVXooBxLfborwDLFJB5ok4zmIQwInM+O/IWM
 g2WYIDUnQNa99uB/FLQYYtClwh1nyaUTJvBNOPzkqZCG1gz/RUiJ2fgt1QFhxthk38mF0b+LYOu
 cWr4yjKdAHKICIrEZSk0SgqLtByBmJWg6aHlBY7Ys=
X-Gm-Gg: ASbGnctq4T3a48PFD6VHxzUP9vhlipE0ZfeACbO3qH5CaXSjWn8uIILbGeejbns4Zv3
 rIUzPY5QoBzwH0GGL+p2GxOcahPslGLKyB6w3WIZ/RrhUX5hRaKAJ1ypBs8XTcI4TB56457i3TL
 mxuDn4m++pliLCwwyBnQ8g+AERFTazM+QNz6rLABP2+fUmG7MWcTJWgY5kiJoa+0ZQhbaNsRfUH
 n9rcdbclOtUrcxFPxUIj6YXPKDkG8T661Lr0AgQ6oinN4IT7woYyzCHZs2boIlsPq0cXMR90IXO
 ceoN8kBviMqpzE5SLy+9jvK0KJsA8xcCbpCQnXH1+8OOdQ==
X-Received: by 2002:a05:600c:4fc6:b0:434:a734:d268 with SMTP id
 5b1f17b1804b1-43960185baemr53667795e9.14.1739462497285; 
 Thu, 13 Feb 2025 08:01:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwKGPXT5gHUdEmjdR6lkKJRyUOwEe0aqs6m32ToYFsCbVjYOVebAqe87dOi3od8vOfT+b3pg==
X-Received: by 2002:a05:600c:4fc6:b0:434:a734:d268 with SMTP id
 5b1f17b1804b1-43960185baemr53665375e9.14.1739462495153; 
 Thu, 13 Feb 2025 08:01:35 -0800 (PST)
Received: from [192.168.126.123] (93-38-211-213.ip72.fastwebnet.it.
 [93.38.211.213]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a04f217sm51970905e9.1.2025.02.13.08.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 08:01:33 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 14/27] i386/fw_cfg: move hpet_cfg definition to hpet.c
Date: Thu, 13 Feb 2025 17:00:41 +0100
Message-ID: <20250213160054.3937012-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213160054.3937012-1-pbonzini@redhat.com>
References: <20250213160054.3937012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
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

HPET device needs to access and update hpet_cfg variable, but now it is
defined in hw/i386/fw_cfg.c and Rust code can't access it.

Move hpet_cfg definition to hpet.c (and rename it to hpet_fw_cfg). This
allows Rust HPET device implements its own global hpet_fw_cfg variable,
and will further reduce the use of unsafe C code access and calls in the
Rust HPET implementation.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250210030051.2562726-2-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/timer/hpet.h |  2 +-
 hw/i386/fw_cfg.c        |  6 ++++--
 hw/timer/hpet.c         | 16 +++++++++-------
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/include/hw/timer/hpet.h b/include/hw/timer/hpet.h
index 71e8c62453d..c2656f7f0be 100644
--- a/include/hw/timer/hpet.h
+++ b/include/hw/timer/hpet.h
@@ -73,7 +73,7 @@ struct hpet_fw_config
     struct hpet_fw_entry hpet[8];
 } QEMU_PACKED;
 
-extern struct hpet_fw_config hpet_cfg;
+extern struct hpet_fw_config hpet_fw_cfg;
 
 #define TYPE_HPET "hpet"
 
diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index 91bf1df0f2e..d08aefa0291 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -26,7 +26,9 @@
 #include CONFIG_DEVICES
 #include "target/i386/cpu.h"
 
-struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
+#if !defined(CONFIG_HPET) && !defined(CONFIG_X_HPET_RUST)
+struct hpet_fw_config hpet_fw_cfg = {.count = UINT8_MAX};
+#endif
 
 const char *fw_cfg_arch_key_name(uint16_t key)
 {
@@ -149,7 +151,7 @@ FWCfgState *fw_cfg_arch_create(MachineState *ms,
 #endif
     fw_cfg_add_i32(fw_cfg, FW_CFG_IRQ0_OVERRIDE, 1);
 
-    fw_cfg_add_bytes(fw_cfg, FW_CFG_HPET, &hpet_cfg, sizeof(hpet_cfg));
+    fw_cfg_add_bytes(fw_cfg, FW_CFG_HPET, &hpet_fw_cfg, sizeof(hpet_fw_cfg));
     /* allocate memory for the NUMA channel: one (64bit) word for the number
      * of nodes, one word for each VCPU->node and one word for each node to
      * hold the amount of memory.
diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 1c8c6c69ef5..dcff18a9871 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -40,6 +40,8 @@
 #include "qom/object.h"
 #include "trace.h"
 
+struct hpet_fw_config hpet_fw_cfg = {.count = UINT8_MAX};
+
 #define HPET_MSI_SUPPORT        0
 
 OBJECT_DECLARE_SIMPLE_TYPE(HPETState, HPET)
@@ -278,7 +280,7 @@ static int hpet_post_load(void *opaque, int version_id)
     /* Push number of timers into capability returned via HPET_ID */
     s->capability &= ~HPET_ID_NUM_TIM_MASK;
     s->capability |= (s->num_timers - 1) << HPET_ID_NUM_TIM_SHIFT;
-    hpet_cfg.hpet[s->hpet_id].event_timer_block_id = (uint32_t)s->capability;
+    hpet_fw_cfg.hpet[s->hpet_id].event_timer_block_id = (uint32_t)s->capability;
 
     /* Derive HPET_MSI_SUPPORT from the capability of the first timer. */
     s->flags &= ~(1 << HPET_MSI_SUPPORT);
@@ -665,8 +667,8 @@ static void hpet_reset(DeviceState *d)
     s->hpet_counter = 0ULL;
     s->hpet_offset = 0ULL;
     s->config = 0ULL;
-    hpet_cfg.hpet[s->hpet_id].event_timer_block_id = (uint32_t)s->capability;
-    hpet_cfg.hpet[s->hpet_id].address = sbd->mmio[0].addr;
+    hpet_fw_cfg.hpet[s->hpet_id].event_timer_block_id = (uint32_t)s->capability;
+    hpet_fw_cfg.hpet[s->hpet_id].address = sbd->mmio[0].addr;
 
     /* to document that the RTC lowers its output on reset as well */
     s->rtc_irq_level = 0;
@@ -708,17 +710,17 @@ static void hpet_realize(DeviceState *dev, Error **errp)
     if (!s->intcap) {
         warn_report("Hpet's intcap not initialized");
     }
-    if (hpet_cfg.count == UINT8_MAX) {
+    if (hpet_fw_cfg.count == UINT8_MAX) {
         /* first instance */
-        hpet_cfg.count = 0;
+        hpet_fw_cfg.count = 0;
     }
 
-    if (hpet_cfg.count == 8) {
+    if (hpet_fw_cfg.count == 8) {
         error_setg(errp, "Only 8 instances of HPET is allowed");
         return;
     }
 
-    s->hpet_id = hpet_cfg.count++;
+    s->hpet_id = hpet_fw_cfg.count++;
 
     for (i = 0; i < HPET_NUM_IRQ_ROUTES; i++) {
         sysbus_init_irq(sbd, &s->irqs[i]);
-- 
2.48.1


