Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF534C52D73
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 08:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbyNL-0008Vv-M9; Thu, 08 Aug 2024 04:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1sbyNJ-0008Ui-3y
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 04:19:57 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1sbyNH-0003A2-BW
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 04:19:56 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1fee6435a34so6759075ad.0
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 01:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1723105193; x=1723709993; darn=nongnu.org;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s4IVICnKBDGToZiRNkgCrHpEgHxCfbvAO2rD8MJGZ60=;
 b=b6TiViIy2KNT1T6WR+rJhI3+JGFT/cDxmBlYgBeERt4oe76oTl51uKDt47eiAoA5vn
 cskcvEsUyIqE6Qh0hKfBZfWNb5qxSgUOcWZXFyVlww1ApRDSDaE70J1U286al95nqvSz
 Yywf0iYbLuyYb9VgRMKswjaqACgsf+Ga5wyP/fKu5ngnrRmdggKVrcJmUSIk2pYOlt93
 Curt6Q6dhkkJCnR8zmEL/UhKi03o7JoBwq2C0BBfAjLxBlh1AuWw8Dm8pdHuTnOO/t8Y
 97VWcUlWjo5P4ei2mzcMQiFhfMBiD/U9Wc5gbTvZpM7CR9auXBqZ2ZCYVGfzbAmaNNRW
 lX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723105193; x=1723709993;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s4IVICnKBDGToZiRNkgCrHpEgHxCfbvAO2rD8MJGZ60=;
 b=DjdZPD7f0FWbGdOc+JsxVjftk2wJ4YAEHpjjVlAIG7T4zG/sgqFgCp43+IJmDquCwi
 w9RKuqGe/Q6AZqrhKyVya418w0ZZ+EYFtWJAD4N9V8L1qncX50BQDyW4mLtUvdsyrx9M
 EZY2ZsshK6az+uTZNsALmMikW0D1Nv4IrbcR0BFrLdhzCaxql3g62p+OCIsPIObd6spN
 p0z1K1hyy/2EXG31VW+8w3XpV6h7vUNkykJcVCgXyr1VwiO2oLnBve/VaK16q7fLpTRF
 /lBPUdOVeCGZUwmKMN8RIMDDciykW5kjKbwSCn2KYpEhn20yoG5QzTLvQ38RN5F19Dxo
 cHIQ==
X-Gm-Message-State: AOJu0Yw5zj7b0B3Gn/O02aStdxQ+5KsgZ7g0oIFUxLtR6/xQxf2He4Xr
 NFzZaBc0ezjqwoBRhD4pK0BuIgEH6kYPKLbSQ96nq1o86u/rP4rLiZrk74BWSu+fFoBKEqQ0FE/
 EAAirogPPK0VbLur3a+zm1YYGUbnF3U8ABLrgcLUa7TgDEwtb+sVTMz9aNc4XOAty0oIngiVVYA
 OH4oTlqWoXn5RkCwiMAcOh1P0lbuMEJ9XLdEvBkapqpqp4
X-Google-Smtp-Source: AGHT+IGjTqID8R0BzWgp5kb/LmJIs986yOGx1DkSGBR+LogGpuwWuqk8MmnulaCOhc4ss0s//nul8Q==
X-Received: by 2002:a17:903:22c5:b0:1fb:67e0:2e0a with SMTP id
 d9443c01a7336-200952bf772mr13092795ad.48.1723105193066; 
 Thu, 08 Aug 2024 01:19:53 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2007728d837sm47281655ad.84.2024.08.08.01.19.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 01:19:52 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, frank.chang@sifive.com,
 jim.shu@sifive.com, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 1/1] hw/intc/riscv_aplic: Check and update pending when write
 sourcecfg
Date: Thu,  8 Aug 2024 16:19:47 +0800
Message-Id: <20240808081948.25837-1-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The section 4.5.2 of the RISC-V AIA specification says that any write
to a sourcecfg register of an APLIC might (or might not) cause the
corresponding interrupt-pending bit to be set to one if the rectified
input value is high (= 1) under the new source mode.

If an interrupt is asserted before the driver configs its interrupt
type to APLIC, it's pending bit will not be set except a relevant
write to a setip or setipnum register. When we write the interrupt
type to sourcecfg register, if the APLIC device doesn't check
rectified input value and update the pending bit, this interrupt
might never becomes pending.

For APLIC.m, we can manully set pending by setip or setipnum
registers in driver. But for APLIC.w, the pending status totally
depends on the rectified input value, we can't control the pending
status via mmio registers. In this case, hw should check and update
pending status for us when writing sourcecfg registers.

Update QEMU emulation to handle "pre-existing" interrupts.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 hw/intc/riscv_aplic.c | 49 +++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 32edd6d07bb3..2a9ac76ce92e 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -159,31 +159,41 @@ static bool is_kvm_aia(bool msimode)
     return kvm_irqchip_in_kernel() && msimode;
 }
 
+static bool riscv_aplic_irq_rectified_val(RISCVAPLICState *aplic,
+                                          uint32_t irq)
+{
+    uint32_t sourcecfg, sm, raw_input, irq_inverted;
+
+    if (!irq || aplic->num_irqs <= irq) {
+        return false;
+    }
+
+    sourcecfg = aplic->sourcecfg[irq];
+    if (sourcecfg & APLIC_SOURCECFG_D) {
+        return false;
+    }
+
+    sm = sourcecfg & APLIC_SOURCECFG_SM_MASK;
+    if (sm == APLIC_SOURCECFG_SM_INACTIVE) {
+        return false;
+    }
+
+    raw_input = (aplic->state[irq] & APLIC_ISTATE_INPUT) ? 1 : 0;
+    irq_inverted = (sm == APLIC_SOURCECFG_SM_LEVEL_LOW ||
+                    sm == APLIC_SOURCECFG_SM_EDGE_FALL) ? 1 : 0;
+    return !!(raw_input ^ irq_inverted);
+}
+
 static uint32_t riscv_aplic_read_input_word(RISCVAPLICState *aplic,
                                             uint32_t word)
 {
-    uint32_t i, irq, sourcecfg, sm, raw_input, irq_inverted, ret = 0;
+    uint32_t i, irq, rectified_val, ret = 0;
 
     for (i = 0; i < 32; i++) {
         irq = word * 32 + i;
-        if (!irq || aplic->num_irqs <= irq) {
-            continue;
-        }
-
-        sourcecfg = aplic->sourcecfg[irq];
-        if (sourcecfg & APLIC_SOURCECFG_D) {
-            continue;
-        }
-
-        sm = sourcecfg & APLIC_SOURCECFG_SM_MASK;
-        if (sm == APLIC_SOURCECFG_SM_INACTIVE) {
-            continue;
-        }
 
-        raw_input = (aplic->state[irq] & APLIC_ISTATE_INPUT) ? 1 : 0;
-        irq_inverted = (sm == APLIC_SOURCECFG_SM_LEVEL_LOW ||
-                        sm == APLIC_SOURCECFG_SM_EDGE_FALL) ? 1 : 0;
-        ret |= (raw_input ^ irq_inverted) << i;
+        rectified_val = riscv_aplic_irq_rectified_val(aplic, irq);
+        ret |= rectified_val << i;
     }
 
     return ret;
@@ -702,6 +712,9 @@ static void riscv_aplic_write(void *opaque, hwaddr addr, uint64_t value,
             (aplic->sourcecfg[irq] == 0)) {
             riscv_aplic_set_pending_raw(aplic, irq, false);
             riscv_aplic_set_enabled_raw(aplic, irq, false);
+        } else {
+            if (riscv_aplic_irq_rectified_val(aplic, irq))
+                riscv_aplic_set_pending_raw(aplic, irq, true);
         }
     } else if (aplic->mmode && aplic->msimode &&
                (addr == APLIC_MMSICFGADDR)) {
-- 
2.17.1


