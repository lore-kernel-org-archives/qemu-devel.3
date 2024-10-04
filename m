Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737A9CFA763
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 10:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swfpu-00039e-BL; Fri, 04 Oct 2024 06:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1swfpq-00038x-4K
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 06:46:58 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1swfpo-0002FO-Kv
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 06:46:57 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20b86298710so16555425ad.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 03:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1728038814; x=1728643614; darn=nongnu.org;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2EYWkqMp5+ScbByXROSgqeJzT9vZRrCTIkgx3WQ4s7I=;
 b=Kn7S2itoO4TZCSmiwwEnu3/ZAyt5rcK6ztN17a62Gm2mamktIKJv4/VySob50hyWLl
 vlVmCHKt87HqxlzuJg5WpSOEQxdziq9B/VjsygGi1uo8r4mgy+btOw+hOhUVGBjzL259
 dOthXPvkEhMHzGoZ2eaipJcoTRDQacBQIF19b+adR14wj8CLiK+Cs6BrrCYtqimgO/aY
 9/clPVgkkSv3IiAprf3qU0ESN+Uj9Xba4PVRpcmZG+z5IYX4GDUIj7LUpRpGeg0vQ1+B
 gJQfE/rWBMho10ZIXtKxc64lAR1Go4Sb0SZf3rqKN3v7XBfBFOITt7yomH97G+UkAVBh
 8yFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728038814; x=1728643614;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2EYWkqMp5+ScbByXROSgqeJzT9vZRrCTIkgx3WQ4s7I=;
 b=UCUtAkrkG+P8F7/CLk0fr8+EfERNtNiN6MHxAg64sPgD/zvEgCiAlUsEeDAK6uehAY
 u8j/ap5QU/wmop8ZYnEMYYYJ6xKxRInu926WtPEjBwLCYF/aXHUnwkrYAXE03a+zJZbk
 RS99rmANr+LZD65jNS0tKfnQc+qKL116YmD8P1AqySC2rC9RWFeajSYm6Yqer+STjnK4
 468kQq9Aw+pSiAtxTsLRKwUlM8mXchNGa4lCm6pdv6eUaljmiBvumIHWAH420gGQLcZR
 wv7U2wulPq9HmozquY5cX80PAfKWRf1qDYtPnaNCIMgvN9ZvQK8FZ0DVbVwJfHtIvIUS
 i7DQ==
X-Gm-Message-State: AOJu0Yz0dThauj3CysnXzWbyj1k5/4QeZ2mWYhkmrF5750szpAf1VTfO
 2Mxp6jsxm2Nj/TDdzumkC0Xm7IkqTuOBYfc2jiXOfZo8i/nYSOpwT3rTTq0ot1WQYZ65T6tj46E
 LuU2gr6Cy976uIQRNOEOZZRoW2doakHMzg7yzFDUQ7RrnB6y+NWfNz4Qg8or1GhZ/WKVSNOaPek
 kTjus5WE7gXZEs2SCR5lpyRaENvHgW5j5ysp2tI5INRQAH
X-Google-Smtp-Source: AGHT+IHiGCpczB7u4Rup2ki8NEO5XPj2bTXGcZcNkQU/pwnjlebkNLhpjDxRDM+Q5KEI+cHtY84Hww==
X-Received: by 2002:a17:903:4404:b0:20b:6125:69be with SMTP id
 d9443c01a7336-20bff177771mr32401745ad.49.1728038814245; 
 Fri, 04 Oct 2024 03:46:54 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20beead24e7sm21986685ad.10.2024.10.04.03.46.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 03:46:53 -0700 (PDT)
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
Subject: [PATCH v2 1/1] hw/intc/riscv_aplic: Check and update pending when
 write sourcecfg
Date: Fri,  4 Oct 2024 18:46:47 +0800
Message-Id: <20241004104649.13129-1-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Acked-by: Alistair Francis <alistair.francis@wdc.com>

---
v2:
- fix checkpatch warning
---
 hw/intc/riscv_aplic.c | 51 ++++++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 32edd6d07bb3..4a262c82f078 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -159,31 +159,42 @@ static bool is_kvm_aia(bool msimode)
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
+
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
 
-        sourcecfg = aplic->sourcecfg[irq];
-        if (sourcecfg & APLIC_SOURCECFG_D) {
-            continue;
-        }
-
-        sm = sourcecfg & APLIC_SOURCECFG_SM_MASK;
-        if (sm == APLIC_SOURCECFG_SM_INACTIVE) {
-            continue;
-        }
-
-        raw_input = (aplic->state[irq] & APLIC_ISTATE_INPUT) ? 1 : 0;
-        irq_inverted = (sm == APLIC_SOURCECFG_SM_LEVEL_LOW ||
-                        sm == APLIC_SOURCECFG_SM_EDGE_FALL) ? 1 : 0;
-        ret |= (raw_input ^ irq_inverted) << i;
+        rectified_val = riscv_aplic_irq_rectified_val(aplic, irq);
+        ret |= rectified_val << i;
     }
 
     return ret;
@@ -702,6 +713,10 @@ static void riscv_aplic_write(void *opaque, hwaddr addr, uint64_t value,
             (aplic->sourcecfg[irq] == 0)) {
             riscv_aplic_set_pending_raw(aplic, irq, false);
             riscv_aplic_set_enabled_raw(aplic, irq, false);
+        } else {
+            if (riscv_aplic_irq_rectified_val(aplic, irq)) {
+                riscv_aplic_set_pending_raw(aplic, irq, true);
+            }
         }
     } else if (aplic->mmode && aplic->msimode &&
                (addr == APLIC_MMSICFGADDR)) {
-- 
2.17.1


