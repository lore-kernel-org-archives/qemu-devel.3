Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284FEE77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 22:40:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO2aP-00041W-3N; Wed, 18 Dec 2024 17:32:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2ZP-0003GI-U8
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:31:08 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2ZO-0003GQ-5w
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:31:07 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-216281bc30fso2360125ad.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 14:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734561063; x=1735165863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4TYqdC2K3zGvnkeyV3z/811UC20D+6gf+j2aj8oIckc=;
 b=KOlYB2L2LSuFeO0vaNl36ENod4wb+6rWgJkOjlCH/EA1jc8EEnj9gQNKlilmQu8Ohv
 JcXcjP7u/kpMb+eH47WsZhUbmdnqbw/cSUSu2W1Sl8Q+jXtaSzAmFPjfAn+MxkZcDast
 lD+YfGnS8UhkbqJjm9PV8g09VGjKDSJNgyH9FvBi4I7ZOjqJuSSCCcu/RUGCkWbY+Gi0
 XQlwcr7k0bk6ZF0u3BXAVexxfPK/xeuNlWYjaIed273CpnasfaM8dIzLj1rAH++ptvq7
 BtuF7BRnrmGcfMQBjCetsAPQMnj8RaPqjrw0xrtGjz+RwM9Ym6uEnKbaMhw4hJFqjtuM
 TiYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734561063; x=1735165863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4TYqdC2K3zGvnkeyV3z/811UC20D+6gf+j2aj8oIckc=;
 b=nLw/w52doxBGl/WODRY3CdIRkCura1EWI7hfPF90dTBOntXqIbnZdD/QGzxkBRVi2v
 NWY4sWRm84jrIVHnYbUboQ3uFG0GoVl7ocxu4jyVVBtAgQDd9e3FTbGWjmDUdEmjune8
 yktYpePWwZXvafFigPEVRhkG580/qqpVj10Y4nUvtitfKnc9rhfyMMw0NnHUbYa6GSEC
 +szya6tRwz90NPrGp4gYK8WKd0O5LtrcpKP0OZhyS3qlqmHi4dGMj5CCX6f/X8ob0AId
 m4cGPJVv37XxNieRC9Byk+B+LKkd3E1qy6wfFGt9fIlmu3JJFLUv1dLIQhzB9zOrZQHm
 +ELw==
X-Gm-Message-State: AOJu0YxIcfu75hhfK3B1zHB4+UyT9MEov/HTAjbiZHAmdXn+0ZzItyHq
 qhgMSydgRns14Df5vi1p8+rNOBc4fHPTu8HKNyW8w9LwWa7SzTMiQUxyCbhc
X-Gm-Gg: ASbGnctX0ONHCTa+YpFqZhuW6R+lWfYltK64eAGG4Js9CwJZPMP9RREqOE3vjvItwGr
 UlzEIX/1psF/v0Obt2os9U7AsiwRBvOpAA1f4gbzPsQsJp4mqDQUwvqZngxUp9gtkc3zDxvshO6
 LpBSw9KnZ3DkOLAUk3cJ0PvOOiL4ShV+oD5M9eE/0LeDLz4fHtSkaeMh89x7fjYAgPM4DA56f32
 cTPbXCEfLoJTw3jPox6odE3G0L0H9+70TirU6s38Jo0sfbugSphjSn6l7vkADmcz3MEQMcknxWU
 PWaR6RoCQaYwSU6/ijKZoGqyMunk6wvdSJw34T6x+6YqImaOYoYGUVTJNvkRB3o=
X-Google-Smtp-Source: AGHT+IEmRkY/ZKJjCyChhN+7okAA9y6iAKnGwzxkGtI65VLuIdVoiH1sheT+4A/f3tzjaMrjKzTSQw==
X-Received: by 2002:a17:902:ce0b:b0:216:2474:3c9f with SMTP id
 d9443c01a7336-218d727da85mr72130575ad.52.1734561063222; 
 Wed, 18 Dec 2024 14:31:03 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9705d7sm375775ad.102.2024.12.18.14.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 14:31:02 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 16/39] hw/intc/riscv_aplic: add kvm_msicfgaddr for split mode
 aplic-imsic
Date: Thu, 19 Dec 2024 08:29:46 +1000
Message-ID: <20241218223010.1931245-17-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218223010.1931245-1-alistair.francis@wdc.com>
References: <20241218223010.1931245-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

The last step to enable KVM AIA aplic-imsic with irqchip in split mode
is to deal with how MSIs are going to be sent. In our current design we
don't allow an APLIC controller to send MSIs unless it's on m-mode. And
we also do not allow Supervisor MSI address configuration via the
'smsiaddrcfg' and 'smsiaddrcfgh' registers unless it's also a m-mode
APLIC controller.

Add a new RISCVACPLICState attribute called 'kvm_msicfgaddr'. This
attribute represents the base configuration address for MSIs, in our
case the base addr of the IMSIC controller. This attribute is being set
only when running irqchip_split() mode with aia=aplic-imsic.

During riscv_aplic_msi_send() we'll check if the attribute was set to
skip the check for a m-mode APLIC controller and to change the resulting
MSI addr by adding kvm_msicfgaddr right before address_space_stl_le().

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241119191706.718860-7-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/intc/riscv_aplic.h |  6 +++++
 hw/intc/riscv_aplic.c         | 42 +++++++++++++++++++++++++++--------
 hw/riscv/virt.c               |  6 ++++-
 3 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/include/hw/intc/riscv_aplic.h b/include/hw/intc/riscv_aplic.h
index 74ae5d87b5..489b9133c2 100644
--- a/include/hw/intc/riscv_aplic.h
+++ b/include/hw/intc/riscv_aplic.h
@@ -68,11 +68,17 @@ struct RISCVAPLICState {
     uint32_t num_irqs;
     bool msimode;
     bool mmode;
+
+    /* To support KVM aia=aplic-imsic with irqchip split mode */
+    bool kvm_splitmode;
+    uint32_t kvm_msicfgaddr;
+    uint32_t kvm_msicfgaddrH;
 };
 
 void riscv_aplic_add_child(DeviceState *parent, DeviceState *child);
 bool riscv_is_kvm_aia_aplic_imsic(bool msimode);
 bool riscv_use_emulated_aplic(bool msimode);
+void riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState *aplic, hwaddr addr);
 
 DeviceState *riscv_aplic_create(hwaddr addr, hwaddr size,
     uint32_t hartid_base, uint32_t num_harts, uint32_t num_sources,
diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index ba4e802888..1e4cdb500c 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -177,6 +177,16 @@ bool riscv_use_emulated_aplic(bool msimode)
 #endif
 }
 
+void riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState *aplic, hwaddr addr)
+{
+#ifdef CONFIG_KVM
+    if (riscv_use_emulated_aplic(aplic->msimode)) {
+        aplic->kvm_msicfgaddr = extract64(addr, 0, 32);
+        aplic->kvm_msicfgaddrH = extract64(addr, 32, 32);
+    }
+#endif
+}
+
 static bool riscv_aplic_irq_rectified_val(RISCVAPLICState *aplic,
                                           uint32_t irq)
 {
@@ -381,13 +391,16 @@ static void riscv_aplic_msi_send(RISCVAPLICState *aplic,
     uint32_t lhxs, lhxw, hhxs, hhxw, group_idx, msicfgaddr, msicfgaddrH;
 
     aplic_m = aplic;
-    while (aplic_m && !aplic_m->mmode) {
-        aplic_m = aplic_m->parent;
-    }
-    if (!aplic_m) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: m-level APLIC not found\n",
-                      __func__);
-        return;
+
+    if (!aplic->kvm_splitmode) {
+        while (aplic_m && !aplic_m->mmode) {
+            aplic_m = aplic_m->parent;
+        }
+        if (!aplic_m) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: m-level APLIC not found\n",
+                          __func__);
+            return;
+        }
     }
 
     if (aplic->mmode) {
@@ -419,6 +432,11 @@ static void riscv_aplic_msi_send(RISCVAPLICState *aplic,
     addr |= (uint64_t)(guest_idx & APLIC_xMSICFGADDR_PPN_HART(lhxs));
     addr <<= APLIC_xMSICFGADDR_PPN_SHIFT;
 
+    if (aplic->kvm_splitmode) {
+        addr |= aplic->kvm_msicfgaddr;
+        addr |= ((uint64_t)aplic->kvm_msicfgaddrH << 32);
+    }
+
     address_space_stl_le(&address_space_memory, addr,
                          eiid, MEMTXATTRS_UNSPECIFIED, &result);
     if (result != MEMTX_OK) {
@@ -892,6 +910,10 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
         memory_region_init_io(&aplic->mmio, OBJECT(dev), &riscv_aplic_ops,
                               aplic, TYPE_RISCV_APLIC, aplic->aperture_size);
         sysbus_init_mmio(SYS_BUS_DEVICE(dev), &aplic->mmio);
+
+        if (kvm_enabled()) {
+            aplic->kvm_splitmode = true;
+        }
     }
 
     /*
@@ -939,8 +961,8 @@ static const Property riscv_aplic_properties[] = {
 
 static const VMStateDescription vmstate_riscv_aplic = {
     .name = "riscv_aplic",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (const VMStateField[]) {
             VMSTATE_UINT32(domaincfg, RISCVAPLICState),
             VMSTATE_UINT32(mmsicfgaddr, RISCVAPLICState),
@@ -948,6 +970,8 @@ static const VMStateDescription vmstate_riscv_aplic = {
             VMSTATE_UINT32(smsicfgaddr, RISCVAPLICState),
             VMSTATE_UINT32(smsicfgaddrH, RISCVAPLICState),
             VMSTATE_UINT32(genmsi, RISCVAPLICState),
+            VMSTATE_UINT32(kvm_msicfgaddr, RISCVAPLICState),
+            VMSTATE_UINT32(kvm_msicfgaddrH, RISCVAPLICState),
             VMSTATE_VARRAY_UINT32(sourcecfg, RISCVAPLICState,
                                   num_irqs, 0,
                                   vmstate_info_uint32, uint32_t),
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 937dfd1ef2..43a1c86c33 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1300,7 +1300,7 @@ static DeviceState *virt_create_aia(RISCVVirtAIAType aia_type, int aia_guests,
                                     int base_hartid, int hart_count)
 {
     int i;
-    hwaddr addr;
+    hwaddr addr = 0;
     uint32_t guest_bits;
     DeviceState *aplic_s = NULL;
     DeviceState *aplic_m = NULL;
@@ -1350,6 +1350,10 @@ static DeviceState *virt_create_aia(RISCVVirtAIAType aia_type, int aia_guests,
                                  VIRT_IRQCHIP_NUM_PRIO_BITS,
                                  msimode, false, aplic_m);
 
+    if (kvm_enabled() && msimode) {
+        riscv_aplic_set_kvm_msicfgaddr(RISCV_APLIC(aplic_s), addr);
+    }
+
     return kvm_enabled() ? aplic_s : aplic_m;
 }
 
-- 
2.47.1


