Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15EFDFB44C1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 06:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGANE-0003Oh-Hz; Fri, 24 Apr 2026 02:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wGAMZ-0003Ed-G9
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 02:50:09 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wGAMV-0005sR-JO
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 02:50:07 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43fe62837baso4498037f8f.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 23:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777013401; x=1777618201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=8Xx2MHrodYUIs6FXh8hsn4cMwayOJwM3LW4g1hrHAtE=;
 b=yYCDNt9UFUH04hp2cWDRNIv5H9qk9mueJ6QnriNApDtQra1xK28AQhs5eBykp18YIJ
 aqQxtMcZL1ct8ivFGYB8b1qylPBg/i51gA/Ku1/HDYKHOGl8nmAgNa73LtMgR2Qzhq2l
 X0MYCCWlxCJck05LxWMsx1rxCm4Q8Uw6vALquLnCquYP+iwUnTBrGy4DMkvZyJTtQHaS
 JmIEy7C9n2LlSfwtIFKDFYIu4NWi3pW20m8LZdwBZfzUQM2+F6LOqCH98IUyEWlf7GsU
 6qsjyvp99q36lENFqe1T2cbn0Pq57bY+z0QJmDS8oSE8ur6/jw56VWP4dIBMFrygEH0N
 cXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777013401; x=1777618201;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8Xx2MHrodYUIs6FXh8hsn4cMwayOJwM3LW4g1hrHAtE=;
 b=Gy9sisHjQO41NLbDkZdPbZhQMTX7boJbTP+SmyAnR2u7aMx35V3LpBDPjyy7clGz+n
 RAoGYn05aGRtbNrx1aq8OUROVH6iEaa5obRQUu/jyN7g3S+AfFzymy5u+aA76ayeE9Sy
 qCK6yGjFyvOGBqXkxMpR/XZNhoUldXzkIEX1O+iyeaPd+jDN/ttjCx2eh4kUpAhz8mJ1
 7DCwfq9KvAGiVS5e/as8Br2pjwa72miyBP+xqz2IwVyaTQ+vqhtQkEn2KkOpRgvpOar8
 MfxUqJJw5ENEEDGBvObScEL7Vw2Dk1G7u8fHvNR0shinijjSJO+5osFF0CSbPYBk78ew
 /WTA==
X-Gm-Message-State: AOJu0YyP4UvEOlNJfNaHbAekJAJeEy98+um4FvnkqRYMwez0y7zFq8oD
 4bW1r5EoCgFv3ijUi6JXrWx5OOyvO6dfJ38BF3LhdmhZqM1WAoCTtp613u8x42wk0vhWL3kxj+U
 9qxWdiXA=
X-Gm-Gg: AeBDieuQVMvlWViYxhYQArnX0JwFwzaGFa8Jb/hrW640z9e6+j9XHghnkk2abxV2bZZ
 P4lPAJr6M0yH4dcH8RMveG5tzUWZlFTNo1+On4brX6YulfULgU+DTzreLLf2Ai2lYItDuAPAWzj
 8W8/lYgzGPrrZMlLDwaLmeu/LogOZ12WbT5bUsS/6iaw5wfxnJvdNUavYhpkICv5+WJvxQtCc6/
 hRDJcbxbaLZ2uBdQgXTBwDoVnXLjtLG28sLJ7Z+2kqltxVbSymhGIs6QhvCuPoBZvPet4H53t59
 rGxVkjk5B1zCjALCteVW5em5fGSEWZUnxwQlfPuc4QMlZIznYBHLmsmB54+ZyOBMFDl19Bfghyy
 oGSFZKjgAHgsCZFKQLz4duTn4wKnDWTE6R/eCsFuEcz0i0d7OF9NN3kgFkiipeOOfaKfxY5oPNK
 GtP2VX46eGVK5+q8Di6dLtiFi6YMCnEEHdEvcJMuQfpile8/ocZ2hCtIHcQPCuWh6YSpY6I495K
 fpTmu/g54HfMVH0Mpq1TnvTZMxW1opL/8CzDAbDQh8gz2TCnxmXywBZNi1Uxg==
X-Received: by 2002:a05:6000:26c6:b0:43c:f66e:f31 with SMTP id
 ffacd0b85a97d-43fe3df24f7mr45106984f8f.27.1777013401026; 
 Thu, 23 Apr 2026 23:50:01 -0700 (PDT)
Received: from meli-email.org (athedsl-338307.home.otenet.gr. [85.72.177.33])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4daf2sm56408165f8f.33.2026.04.23.23.49.59
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Apr 2026 23:50:00 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:38:54 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: Re: [PATCH v20 01/15] hw/intc: Add hvf vGIC interrupt controller
 support
User-Agent: meli/0.8.13
References: <20260316130642.13246-1-mohamed@unpredictable.fr>
 <20260316130642.13246-2-mohamed@unpredictable.fr>
In-Reply-To: <20260316130642.13246-2-mohamed@unpredictable.fr>
Message-ID: <tdzkba.5057eg6jyy9z@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x436.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 16 Mar 2026 15:06, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>This opens up the door to nested virtualisation support.
>
>Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>---


Not familiar with nested virt, but I took a look through the code and 
overall LGTM, left a few comments inline.

Feel free to add my r-b regardless of whether you address them since 
they are nitpicking:

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>


> hw/intc/arm_gicv3_hvf.c            | 741 +++++++++++++++++++++++++++++
> hw/intc/meson.build                |   1 +
> include/hw/intc/arm_gicv3_common.h |   1 +
> 3 files changed, 743 insertions(+)
> create mode 100644 hw/intc/arm_gicv3_hvf.c
>
>diff --git a/hw/intc/arm_gicv3_hvf.c b/hw/intc/arm_gicv3_hvf.c
>new file mode 100644
>index 0000000000..55171a796b
>--- /dev/null
>+++ b/hw/intc/arm_gicv3_hvf.c
>@@ -0,0 +1,741 @@
>+/* SPDX-License-Identifier: GPL-2.0-or-later */
>+/*
>+ * ARM Generic Interrupt Controller using HVF platform support
>+ *
>+ * Copyright (c) 2025 Mohamed Mediouni
>+ * Based on vGICv3 KVM code by Pavel Fedin
>+ *
>+ */
>+
>+#include "qemu/osdep.h"
>+#include "qapi/error.h"
>+#include "hw/intc/arm_gicv3_common.h"
>+#include "qemu/error-report.h"
>+#include "qemu/module.h"
>+#include "system/runstate.h"
>+#include "system/hvf.h"
>+#include "system/hvf_int.h"
>+#include "hvf_arm.h"
>+#include "gicv3_internal.h"
>+#include "vgic_common.h"
>+#include "qom/object.h"
>+#include "target/arm/cpregs.h"
>+#include <Hypervisor/Hypervisor.h>
>+
>+/* For the GIC, override the check outright, as availability is checked elsewhere. */
>+#pragma clang diagnostic push
>+#pragma clang diagnostic ignored "-Wunguarded-availability"

Question: is this necessary/the only way or just a quick workaround?

>+
>+struct HVFARMGICv3Class {
>+    ARMGICv3CommonClass parent_class;
>+    DeviceRealize parent_realize;
>+    ResettablePhases parent_phases;
>+};
>+
>+typedef struct HVFARMGICv3Class HVFARMGICv3Class;
>+
>+/* This is reusing the GICv3State typedef from ARM_GICV3_ITS_COMMON */
>+DECLARE_OBJ_CHECKERS(GICv3State, HVFARMGICv3Class,
>+                     HVF_GICV3, TYPE_HVF_GICV3);
>+
>+/*
>+ * Loop through each distributor IRQ related register; since bits
>+ * corresponding to SPIs and PPIs are RAZ/WI when affinity routing
>+ * is enabled, we skip those.
>+ */
>+#define for_each_dist_irq_reg(_irq, _max, _field_width) \
>+    for (_irq = GIC_INTERNAL; _irq < _max; _irq += (32 / _field_width))

Nit: _max and _field_width should be enclosed in parentheses since this 
is a macro

>+
>+/*
>+ * Wrap calls to the vGIC APIs to assert_hvf_ok()
>+ * as a macro to keep the code clean.
>+ */

Suggestion, not a request: I like seeing the assert inline when reading 
code instead of indirection :)

>+#define hv_gic_get_distributor_reg(offset, reg) \
>+    assert_hvf_ok(hv_gic_get_distributor_reg(offset, reg))
>+
>+#define hv_gic_set_distributor_reg(offset, reg) \
>+    assert_hvf_ok(hv_gic_set_distributor_reg(offset, reg))
>+
>+#define hv_gic_get_redistributor_reg(vcpu, reg, value) \
>+    assert_hvf_ok(hv_gic_get_redistributor_reg(vcpu, reg, value))
>+
>+#define hv_gic_set_redistributor_reg(vcpu, reg, value) \
>+    assert_hvf_ok(hv_gic_set_redistributor_reg(vcpu, reg, value))
>+
>+#define hv_gic_get_icc_reg(vcpu, reg, value) \
>+    assert_hvf_ok(hv_gic_get_icc_reg(vcpu, reg, value))
>+
>+#define hv_gic_set_icc_reg(vcpu, reg, value) \
>+    assert_hvf_ok(hv_gic_set_icc_reg(vcpu, reg, value))
>+
>+#define hv_gic_get_ich_reg(vcpu, reg, value) \
>+    assert_hvf_ok(hv_gic_get_ich_reg(vcpu, reg, value))
>+
>+#define hv_gic_set_ich_reg(vcpu, reg, value) \
>+    assert_hvf_ok(hv_gic_set_ich_reg(vcpu, reg, value))
>+
>+static void hvf_dist_get_priority(GICv3State *s, hv_gic_distributor_reg_t offset
>+    , uint8_t *bmp)

Not sure if it's email formatting or code formatting, but that starting 
comma seems out of place (ditto in the next function)

>+{
>+    uint64_t reg;
>+    uint32_t *field;
>+    int irq;
>+    field = (uint32_t *)(bmp);
>+
>+    for_each_dist_irq_reg(irq, s->num_irq, 8) {
>+        hv_gic_get_distributor_reg(offset, &reg);
>+        *field = reg;
>+        offset += 4;
>+        field++;
>+    }
>+}
>+
>+static void hvf_dist_put_priority(GICv3State *s, hv_gic_distributor_reg_t offset
>+    , uint8_t *bmp)
>+{
>+    uint32_t reg, *field;
>+    int irq;
>+    field = (uint32_t *)(bmp);
>+
>+    for_each_dist_irq_reg(irq, s->num_irq, 8) {
>+        reg = *field;
>+        hv_gic_set_distributor_reg(offset, reg);
>+        offset += 4;
>+        field++;
>+    }
>+}
>+
>+static void hvf_dist_get_edge_trigger(GICv3State *s, hv_gic_distributor_reg_t offset,
>+                                      uint32_t *bmp)
>+{
>+    uint64_t reg;
>+    int irq;
>+
>+    for_each_dist_irq_reg(irq, s->num_irq, 2) {
>+        hv_gic_get_distributor_reg(offset, &reg);
>+        reg = half_unshuffle32(reg >> 1);
>+        if (irq % 32 != 0) {
>+            reg = (reg << 16);
>+        }
>+        *gic_bmp_ptr32(bmp, irq) |= reg;
>+        offset += 4;
>+    }
>+}
>+
>+static void hvf_dist_put_edge_trigger(GICv3State *s, hv_gic_distributor_reg_t offset,
>+                                      uint32_t *bmp)
>+{
>+    uint32_t reg;
>+    int irq;
>+
>+    for_each_dist_irq_reg(irq, s->num_irq, 2) {
>+        reg = *gic_bmp_ptr32(bmp, irq);
>+        if (irq % 32 != 0) {
>+            reg = (reg & 0xffff0000) >> 16;
>+        } else {
>+            reg = reg & 0xffff;
>+        }
>+        reg = half_shuffle32(reg) << 1;
>+        hv_gic_set_distributor_reg(offset, reg);
>+        offset += 4;
>+    }
>+}
>+
>+/* Read a bitmap register group from the kernel VGIC. */
>+static void hvf_dist_getbmp(GICv3State *s, hv_gic_distributor_reg_t offset, uint32_t *bmp)
>+{
>+    uint64_t reg;
>+    int irq;
>+
>+    for_each_dist_irq_reg(irq, s->num_irq, 1) {
>+

Stray line

>+        hv_gic_get_distributor_reg(offset, &reg);
>+        *gic_bmp_ptr32(bmp, irq) = reg;
>+        offset += 4;
>+    }
>+}
>+
>+static void hvf_dist_putbmp(GICv3State *s, hv_gic_distributor_reg_t offset,
>+                            hv_gic_distributor_reg_t clroffset, uint32_t *bmp)
>+{
>+    uint32_t reg;
>+    int irq;
>+
>+    for_each_dist_irq_reg(irq, s->num_irq, 1) {
>+        /*
>+         * If this bitmap is a set/clear register pair, first write to the
>+         * clear-reg to clear all bits before using the set-reg to write
>+         * the 1 bits.
>+         */
>+        if (clroffset != 0) {
>+            reg = 0;
>+            hv_gic_set_distributor_reg(clroffset, reg);
>+            clroffset += 4;
>+        }
>+        reg = *gic_bmp_ptr32(bmp, irq);
>+        hv_gic_set_distributor_reg(offset, reg);
>+        offset += 4;
>+    }
>+}
>+
>+static void hvf_gicv3_check(GICv3State *s)
>+{
>+    uint64_t reg;
>+    uint32_t num_irq;
>+
>+    /* Sanity checking s->num_irq */
>+    hv_gic_get_distributor_reg(HV_GIC_DISTRIBUTOR_REG_GICD_TYPER, &reg);
>+    num_irq = ((reg & 0x1f) + 1) * 32;
>+
>+    if (num_irq < s->num_irq) {
>+        error_report("Model requests %u IRQs, but HVF supports max %u",
>+                     s->num_irq, num_irq);
>+        abort();
>+    }
>+}
>+
>+static void hvf_gicv3_put_cpu_el2(CPUState *cpu_state, run_on_cpu_data arg)
>+{
>+    int num_pri_bits;
>+
>+    /* Redistributor state */
>+    GICv3CPUState *c = arg.host_ptr;
>+    hv_vcpu_t vcpu = c->cpu->accel->fd;
>+
>+    hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_VMCR_EL2, c->ich_vmcr_el2);
>+    hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_HCR_EL2, c->ich_hcr_el2);
>+
>+    for (int i = 0; i < GICV3_LR_MAX; i++) {
>+        hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_LR0_EL2, c->ich_lr_el2[i]);
>+    }
>+
>+    num_pri_bits = c->vpribits;
>+
>+    switch (num_pri_bits) {
>+    case 7:
>+      hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_AP0R0_EL2 + 3,
>+                         c->ich_apr[GICV3_G0][3]);
>+      hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_AP0R0_EL2 + 2,
>+                         c->ich_apr[GICV3_G0][2]);
>+      /* fall through */
>+    case 6:
>+      hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_AP0R0_EL2 + 1,
>+                         c->ich_apr[GICV3_G0][1]);
>+      /* fall through */
>+    default:
>+      hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_AP0R0_EL2,
>+                         c->ich_apr[GICV3_G0][0]);
>+    }
>+
>+    switch (num_pri_bits) {
>+    case 7:
>+      hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_AP1R0_EL2 + 3,
>+                         c->ich_apr[GICV3_G1NS][3]);
>+      hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_AP1R0_EL2 + 2,
>+                         c->ich_apr[GICV3_G1NS][2]);
>+      /* fall through */
>+    case 6:
>+      hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_AP1R0_EL2 + 1,
>+                         c->ich_apr[GICV3_G1NS][1]);
>+      /* fall through */
>+    default:
>+      hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_AP1R0_EL2,
>+                         c->ich_apr[GICV3_G1NS][0]);
>+    }
>+}
>+
>+static void hvf_gicv3_put_cpu(CPUState *cpu_state, run_on_cpu_data arg)
>+{
>+    uint32_t reg;
>+    uint64_t reg64;
>+    int i, num_pri_bits;
>+
>+    /* Redistributor state */
>+    GICv3CPUState *c = arg.host_ptr;
>+    hv_vcpu_t vcpu = c->cpu->accel->fd;
>+
>+    reg = c->gicr_waker;
>+    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_IGROUPR0, reg);
>+
>+    reg = c->gicr_igroupr0;
>+    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_IGROUPR0, reg);
>+
>+    reg = ~0;
>+    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ICENABLER0, reg);
>+    reg = c->gicr_ienabler0;
>+    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ISENABLER0, reg);
>+
>+    /* Restore config before pending so we treat level/edge correctly */
>+    reg = half_shuffle32(c->edge_trigger >> 16) << 1;
>+    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ICFGR1, reg);
>+
>+    reg = ~0;
>+    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ICPENDR0, reg);
>+    reg = c->gicr_ipendr0;
>+    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ISPENDR0, reg);
>+
>+    reg = ~0;
>+    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ICACTIVER0, reg);
>+    reg = c->gicr_iactiver0;
>+    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ISACTIVER0, reg);
>+
>+    for (i = 0; i < GIC_INTERNAL; i += 4) {
>+        reg = c->gicr_ipriorityr[i] |
>+            (c->gicr_ipriorityr[i + 1] << 8) |
>+            (c->gicr_ipriorityr[i + 2] << 16) |
>+            (c->gicr_ipriorityr[i + 3] << 24);
>+        hv_gic_set_redistributor_reg(vcpu,
>+            HV_GIC_REDISTRIBUTOR_REG_GICR_IPRIORITYR0 + i, reg);
>+    }
>+
>+    /* CPU interface state */
>+    hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_SRE_EL1, c->icc_sre_el1);
>+
>+    hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_CTLR_EL1,
>+                    c->icc_ctlr_el1[GICV3_NS]);
>+    hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_IGRPEN0_EL1,
>+                    c->icc_igrpen[GICV3_G0]);
>+    hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_IGRPEN1_EL1,
>+                    c->icc_igrpen[GICV3_G1NS]);
>+    hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_PMR_EL1, c->icc_pmr_el1);
>+    hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_BPR0_EL1, c->icc_bpr[GICV3_G0]);
>+    hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_BPR1_EL1, c->icc_bpr[GICV3_G1NS]);
>+
>+    num_pri_bits = ((c->icc_ctlr_el1[GICV3_NS] &
>+                    ICC_CTLR_EL1_PRIBITS_MASK) >>
>+                    ICC_CTLR_EL1_PRIBITS_SHIFT) + 1;
>+
>+    switch (num_pri_bits) {
>+    case 7:
>+           reg64 = c->icc_apr[GICV3_G0][3];
>+        hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_AP0R0_EL1 + 3, reg64);
>+        reg64 = c->icc_apr[GICV3_G0][2];
>+        hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_AP0R0_EL1 + 2, reg64);
>+        /* fall through */
>+    case 6:
>+        reg64 = c->icc_apr[GICV3_G0][1];
>+        hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_AP0R0_EL1 + 1, reg64);
>+        /* fall through */
>+    default:
>+        reg64 = c->icc_apr[GICV3_G0][0];
>+        hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_AP0R0_EL1, reg64);
>+    }
>+
>+    switch (num_pri_bits) {
>+    case 7:
>+        reg64 = c->icc_apr[GICV3_G1NS][3];
>+        hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_AP1R0_EL1 + 3, reg64);
>+        reg64 = c->icc_apr[GICV3_G1NS][2];
>+        hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_AP1R0_EL1 + 2, reg64);
>+        /* fall through */
>+    case 6:
>+        reg64 = c->icc_apr[GICV3_G1NS][1];
>+        hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_AP1R0_EL1 + 1, reg64);
>+        /* fall through */
>+    default:
>+        reg64 = c->icc_apr[GICV3_G1NS][0];
>+        hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_AP1R0_EL1, reg64);
>+    }
>+
>+    /* Registers beyond this point are with nested virt only */
>+    if (c->gic->maint_irq) {
>+        hvf_gicv3_put_cpu_el2(cpu_state, arg);
>+    }
>+}
>+
>+static void hvf_gicv3_put(GICv3State *s)
>+{
>+    uint32_t reg;
>+    int ncpu, i;
>+
>+    hvf_gicv3_check(s);
>+
>+    reg = s->gicd_ctlr;
>+    hv_gic_set_distributor_reg(HV_GIC_DISTRIBUTOR_REG_GICD_CTLR, reg);
>+
>+    /* per-CPU state */
>+
>+    for (ncpu = 0; ncpu < s->num_cpu; ncpu++) {
>+        run_on_cpu_data data;
>+        data.host_ptr = &s->cpu[ncpu];
>+        run_on_cpu(s->cpu[ncpu].cpu, hvf_gicv3_put_cpu, data);
>+    }
>+
>+    /* s->enable bitmap -> GICD_ISENABLERn */
>+    hvf_dist_putbmp(s, HV_GIC_DISTRIBUTOR_REG_GICD_ISENABLER0
>+        , HV_GIC_DISTRIBUTOR_REG_GICD_ICENABLER0, s->enabled);

stray comma again

>+
>+    /* s->group bitmap -> GICD_IGROUPRn */
>+    hvf_dist_putbmp(s, HV_GIC_DISTRIBUTOR_REG_GICD_IGROUPR0
>+        , 0, s->group);
>+
>+    /* Restore targets before pending to ensure the pending state is set on
>+     * the appropriate CPU interfaces in the kernel
>+     */
>+
>+    /* s->gicd_irouter[irq] -> GICD_IROUTERn */
>+    for (i = GIC_INTERNAL; i < s->num_irq; i++) {
>+        uint32_t offset = HV_GIC_DISTRIBUTOR_REG_GICD_IROUTER32 + (8 * i)
>+            - (8 * GIC_INTERNAL);
>+        hv_gic_set_distributor_reg(offset, s->gicd_irouter[i]);
>+    }
>+
>+    /*
>+     * s->trigger bitmap -> GICD_ICFGRn
>+     * (restore configuration registers before pending IRQs so we treat
>+     * level/edge correctly)
>+     */
>+    hvf_dist_put_edge_trigger(s, HV_GIC_DISTRIBUTOR_REG_GICD_ICFGR0, s->edge_trigger);
>+
>+    /* s->pending bitmap -> GICD_ISPENDRn */
>+    hvf_dist_putbmp(s, HV_GIC_DISTRIBUTOR_REG_GICD_ISPENDR0,
>+        HV_GIC_DISTRIBUTOR_REG_GICD_ICPENDR0, s->pending);
>+
>+    /* s->active bitmap -> GICD_ISACTIVERn */
>+    hvf_dist_putbmp(s, HV_GIC_DISTRIBUTOR_REG_GICD_ISACTIVER0,
>+        HV_GIC_DISTRIBUTOR_REG_GICD_ICACTIVER0, s->active);
>+
>+    /* s->gicd_ipriority[] -> GICD_IPRIORITYRn */
>+    hvf_dist_put_priority(s, HV_GIC_DISTRIBUTOR_REG_GICD_IPRIORITYR0, s->gicd_ipriority);
>+}
>+
>+static void hvf_gicv3_get_cpu_el2(CPUState *cpu_state, run_on_cpu_data arg)
>+{
>+    int num_pri_bits;
>+
>+    /* Redistributor state */
>+    GICv3CPUState *c = arg.host_ptr;
>+    hv_vcpu_t vcpu = c->cpu->accel->fd;
>+
>+    hv_gic_get_ich_reg(vcpu, HV_GIC_ICH_REG_VMCR_EL2, &c->ich_vmcr_el2);
>+    hv_gic_get_ich_reg(vcpu, HV_GIC_ICH_REG_HCR_EL2, &c->ich_hcr_el2);
>+
>+    for (int i = 0; i < GICV3_LR_MAX; i++) {
>+        hv_gic_get_ich_reg(vcpu, HV_GIC_ICH_REG_LR0_EL2, &c->ich_lr_el2[i]);
>+    }
>+
>+    num_pri_bits = c->vpribits;
>+
>+    switch (num_pri_bits) {
>+    case 7:
>+      hv_gic_get_ich_reg(vcpu, HV_GIC_ICH_REG_AP0R0_EL2 + 3,
>+                         &c->ich_apr[GICV3_G0][3]);
>+      hv_gic_get_ich_reg(vcpu, HV_GIC_ICH_REG_AP0R0_EL2 + 2,
>+                         &c->ich_apr[GICV3_G0][2]);
>+      /* fall through */
>+    case 6:
>+      hv_gic_get_ich_reg(vcpu, HV_GIC_ICH_REG_AP0R0_EL2 + 1,
>+                         &c->ich_apr[GICV3_G0][1]);
>+      /* fall through */
>+    default:
>+      hv_gic_get_ich_reg(vcpu, HV_GIC_ICH_REG_AP0R0_EL2,
>+                         &c->ich_apr[GICV3_G0][0]);
>+    }
>+
>+    switch (num_pri_bits) {
>+    case 7:
>+      hv_gic_get_ich_reg(vcpu, HV_GIC_ICH_REG_AP1R0_EL2 + 3,
>+                         &c->ich_apr[GICV3_G1NS][3]);
>+      hv_gic_get_ich_reg(vcpu, HV_GIC_ICH_REG_AP1R0_EL2 + 2,
>+                         &c->ich_apr[GICV3_G1NS][2]);
>+      /* fall through */
>+    case 6:
>+      hv_gic_get_ich_reg(vcpu, HV_GIC_ICH_REG_AP1R0_EL2 + 1,
>+                         &c->ich_apr[GICV3_G1NS][1]);
>+      /* fall through */
>+    default:
>+      hv_gic_get_ich_reg(vcpu, HV_GIC_ICH_REG_AP1R0_EL2,
>+                         &c->ich_apr[GICV3_G1NS][0]);
>+    }
>+}
>+
>+static void hvf_gicv3_get_cpu(CPUState *cpu_state, run_on_cpu_data arg)
>+{
>+    uint64_t reg;
>+    int i, num_pri_bits;
>+
>+    /* Redistributor state */
>+    GICv3CPUState *c = arg.host_ptr;
>+    hv_vcpu_t vcpu = c->cpu->accel->fd;
>+
>+    hv_gic_get_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_IGROUPR0,
>+                                 &reg);
>+    c->gicr_igroupr0 = reg;
>+    hv_gic_get_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ISENABLER0,
>+                                 &reg);
>+    c->gicr_ienabler0 = reg;
>+    hv_gic_get_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ICFGR1,
>+                                 &reg);
>+    c->edge_trigger = half_unshuffle32(reg >> 1) << 16;
>+    hv_gic_get_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ISPENDR0,
>+                                 &reg);
>+    c->gicr_ipendr0 = reg;
>+    hv_gic_get_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ISACTIVER0,
>+                                 &reg);
>+    c->gicr_iactiver0 = reg;
>+
>+    for (i = 0; i < GIC_INTERNAL; i += 4) {
>+        hv_gic_get_redistributor_reg(
>+          vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_IPRIORITYR0 + i, &reg);
>+        c->gicr_ipriorityr[i] = extract32(reg, 0, 8);
>+        c->gicr_ipriorityr[i + 1] = extract32(reg, 8, 8);
>+        c->gicr_ipriorityr[i + 2] = extract32(reg, 16, 8);
>+        c->gicr_ipriorityr[i + 3] = extract32(reg, 24, 8);
>+    }
>+
>+    /* CPU interface */
>+    hv_gic_get_icc_reg(vcpu, HV_GIC_ICC_REG_SRE_EL1, &c->icc_sre_el1);
>+
>+    hv_gic_get_icc_reg(vcpu, HV_GIC_ICC_REG_CTLR_EL1,
>+                       &c->icc_ctlr_el1[GICV3_NS]);
>+    hv_gic_get_icc_reg(vcpu, HV_GIC_ICC_REG_IGRPEN0_EL1,
>+                       &c->icc_igrpen[GICV3_G0]);
>+    hv_gic_get_icc_reg(vcpu, HV_GIC_ICC_REG_IGRPEN1_EL1,
>+                       &c->icc_igrpen[GICV3_G1NS]);
>+    hv_gic_get_icc_reg(vcpu, HV_GIC_ICC_REG_PMR_EL1, &c->icc_pmr_el1);
>+    hv_gic_get_icc_reg(vcpu, HV_GIC_ICC_REG_BPR0_EL1, &c->icc_bpr[GICV3_G0]);
>+    hv_gic_get_icc_reg(vcpu, HV_GIC_ICC_REG_BPR1_EL1, &c->icc_bpr[GICV3_G1NS]);
>+    num_pri_bits = ((c->icc_ctlr_el1[GICV3_NS] & ICC_CTLR_EL1_PRIBITS_MASK) >>
>+                    ICC_CTLR_EL1_PRIBITS_SHIFT) +
>+                   1;
>+
>+    switch (num_pri_bits) {
>+    case 7:
>+      hv_gic_get_icc_reg(vcpu, HV_GIC_ICC_REG_AP0R0_EL1 + 3,
>+                         &c->icc_apr[GICV3_G0][3]);
>+      hv_gic_get_icc_reg(vcpu, HV_GIC_ICC_REG_AP0R0_EL1 + 2,
>+                         &c->icc_apr[GICV3_G0][2]);
>+      /* fall through */
>+    case 6:
>+      hv_gic_get_icc_reg(vcpu, HV_GIC_ICC_REG_AP0R0_EL1 + 1,
>+                         &c->icc_apr[GICV3_G0][1]);
>+      /* fall through */
>+    default:
>+      hv_gic_get_icc_reg(vcpu, HV_GIC_ICC_REG_AP0R0_EL1,
>+                         &c->icc_apr[GICV3_G0][0]);
>+    }
>+
>+    switch (num_pri_bits) {
>+    case 7:
>+      hv_gic_get_icc_reg(vcpu, HV_GIC_ICC_REG_AP1R0_EL1 + 3,
>+                         &c->icc_apr[GICV3_G1NS][3]);
>+      hv_gic_get_icc_reg(vcpu, HV_GIC_ICC_REG_AP1R0_EL1 + 2,
>+                         &c->icc_apr[GICV3_G1NS][2]);
>+      /* fall through */
>+    case 6:
>+      hv_gic_get_icc_reg(vcpu, HV_GIC_ICC_REG_AP1R0_EL1 + 1,
>+                         &c->icc_apr[GICV3_G1NS][1]);
>+      /* fall through */
>+    default:
>+      hv_gic_get_icc_reg(vcpu, HV_GIC_ICC_REG_AP1R0_EL1,
>+                         &c->icc_apr[GICV3_G1NS][0]);
>+    }
>+
>+    /* Registers beyond this point are with nested virt only */
>+    if (c->gic->maint_irq) {
>+        hvf_gicv3_get_cpu_el2(cpu_state, arg);
>+    }
>+}
>+
>+static void hvf_gicv3_get(GICv3State *s)
>+{
>+    uint64_t reg;
>+    int ncpu, i;
>+
>+    hvf_gicv3_check(s);
>+
>+    hv_gic_get_distributor_reg(HV_GIC_DISTRIBUTOR_REG_GICD_CTLR, &reg);
>+    s->gicd_ctlr = reg;
>+
>+    /* Redistributor state (one per CPU) */
>+
>+    for (ncpu = 0; ncpu < s->num_cpu; ncpu++) {
>+        run_on_cpu_data data;
>+        data.host_ptr = &s->cpu[ncpu];
>+        run_on_cpu(s->cpu[ncpu].cpu, hvf_gicv3_get_cpu, data);
>+    }
>+
>+    /* GICD_IGROUPRn -> s->group bitmap */
>+    hvf_dist_getbmp(s, HV_GIC_DISTRIBUTOR_REG_GICD_IGROUPR0, s->group);
>+
>+    /* GICD_ISENABLERn -> s->enabled bitmap */
>+    hvf_dist_getbmp(s, HV_GIC_DISTRIBUTOR_REG_GICD_ISENABLER0, s->enabled);
>+
>+    /* GICD_ISPENDRn -> s->pending bitmap */
>+    hvf_dist_getbmp(s, HV_GIC_DISTRIBUTOR_REG_GICD_ISPENDR0, s->pending);
>+
>+    /* GICD_ISACTIVERn -> s->active bitmap */
>+    hvf_dist_getbmp(s, HV_GIC_DISTRIBUTOR_REG_GICD_ISACTIVER0, s->active);
>+
>+    /* GICD_ICFGRn -> s->trigger bitmap */
>+    hvf_dist_get_edge_trigger(s, HV_GIC_DISTRIBUTOR_REG_GICD_ICFGR0
>+        , s->edge_trigger);
>+
>+    /* GICD_IPRIORITYRn -> s->gicd_ipriority[] */
>+    hvf_dist_get_priority(s, HV_GIC_DISTRIBUTOR_REG_GICD_IPRIORITYR0
>+        , s->gicd_ipriority);
>+
>+    /* GICD_IROUTERn -> s->gicd_irouter[irq] */
>+    for (i = GIC_INTERNAL; i < s->num_irq; i++) {
>+        uint32_t offset = HV_GIC_DISTRIBUTOR_REG_GICD_IROUTER32
>+            + (8 * i) - (8 * GIC_INTERNAL);
>+        hv_gic_get_distributor_reg(offset, &s->gicd_irouter[i]);
>+    }
>+}
>+
>+static void hvf_gicv3_set_irq(void *opaque, int irq, int level)
>+{
>+    GICv3State *s = opaque;
>+    if (irq > s->num_irq) {
>+        return;
>+    }
>+    hv_gic_set_spi(GIC_INTERNAL + irq, !!level);
>+}
>+
>+static void hvf_gicv3_icc_reset(CPUARMState *env, const ARMCPRegInfo *ri)
>+{
>+    GICv3CPUState *c;
>+
>+    c = env->gicv3state;
>+    c->icc_pmr_el1 = 0;
>+    /*
>+     * Architecturally the reset value of the ICC_BPR registers
>+     * is UNKNOWN. We set them all to 0 here; when the kernel
>+     * uses these values to program the ICH_VMCR_EL2 fields that
>+     * determine the guest-visible ICC_BPR register values, the
>+     * hardware's "writing a value less than the minimum sets
>+     * the field to the minimum value" behaviour will result in
>+     * them effectively resetting to the correct minimum value
>+     * for the host GIC.
>+     */
>+    c->icc_bpr[GICV3_G0] = 0;
>+    c->icc_bpr[GICV3_G1] = 0;
>+    c->icc_bpr[GICV3_G1NS] = 0;
>+
>+    c->icc_sre_el1 = 0x7;
>+    memset(c->icc_apr, 0, sizeof(c->icc_apr));
>+    memset(c->icc_igrpen, 0, sizeof(c->icc_igrpen));
>+}
>+
>+static void hvf_gicv3_reset_hold(Object *obj, ResetType type)
>+{
>+    GICv3State *s = ARM_GICV3_COMMON(obj);
>+    HVFARMGICv3Class *kgc = HVF_GICV3_GET_CLASS(s);
>+
>+    if (kgc->parent_phases.hold) {
>+        kgc->parent_phases.hold(obj, type);
>+    }
>+
>+    hvf_gicv3_put(s);
>+}
>+
>+
>+/*
>+ * CPU interface registers of GIC needs to be reset on CPU reset.
>+ * For the calling arm_gicv3_icc_reset() on CPU reset, we register
>+ * below ARMCPRegInfo. As we reset the whole cpu interface under single
>+ * register reset, we define only one register of CPU interface instead
>+ * of defining all the registers.
>+ */
>+static const ARMCPRegInfo gicv3_cpuif_reginfo[] = {
>+    { .name = "ICC_CTLR_EL1", .state = ARM_CP_STATE_BOTH,
>+      .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 12, .opc2 = 4,
>+      /*
>+       * If ARM_CP_NOP is used, resetfn is not called,
>+       * So ARM_CP_NO_RAW is appropriate type.
>+       */
>+      .type = ARM_CP_NO_RAW,
>+      .access = PL1_RW,
>+      .readfn = arm_cp_read_zero,
>+      .writefn = arm_cp_write_ignore,
>+      /*
>+       * We hang the whole cpu interface reset routine off here
>+       * rather than parcelling it out into one little function
>+       * per register
>+       */
>+      .resetfn = hvf_gicv3_icc_reset,
>+    },
>+};
>+
>+static void hvf_gicv3_realize(DeviceState *dev, Error **errp)
>+{
>+    ERRP_GUARD();
>+    GICv3State *s = HVF_GICV3(dev);
>+    HVFARMGICv3Class *kgc = HVF_GICV3_GET_CLASS(s);
>+    int i;
>+
>+    kgc->parent_realize(dev, errp);
>+    if (*errp) {
>+        return;
>+    }
>+
>+    if (s->revision != 3) {
>+        error_setg(errp, "unsupported GIC revision %d for platform GIC",
>+                   s->revision);
>+    }
>+
>+    if (s->security_extn) {
>+        error_setg(errp, "the platform vGICv3 does not implement the "
>+                   "security extensions");
>+        return;
>+    }
>+
>+    if (s->nmi_support) {
>+        error_setg(errp, "NMI is not supported with the platform GIC");
>+        return;
>+    }
>+
>+    if (s->nb_redist_regions > 1) {
>+        error_setg(errp, "Multiple VGICv3 redistributor regions are not "
>+                   "supported by HVF");
>+        error_append_hint(errp, "A maximum of %d VCPUs can be used",
>+                          s->redist_region_count[0]);
>+        return;
>+    }
>+
>+    gicv3_init_irqs_and_mmio(s, hvf_gicv3_set_irq, NULL);
>+
>+    for (i = 0; i < s->num_cpu; i++) {
>+        ARMCPU *cpu = ARM_CPU(qemu_get_cpu(i));
>+
>+        define_arm_cp_regs(cpu, gicv3_cpuif_reginfo);
>+    }
>+
>+    if (s->maint_irq && s->maint_irq != HV_GIC_INT_MAINTENANCE) {
>+        error_setg(errp, "vGIC maintenance IRQ mismatch with the hardcoded one in HVF.");
>+        return;
>+    }
>+}
>+
>+static void hvf_gicv3_class_init(ObjectClass *klass, const void *data)
>+{
>+    DeviceClass *dc = DEVICE_CLASS(klass);
>+    ResettableClass *rc = RESETTABLE_CLASS(klass);
>+    ARMGICv3CommonClass *agcc = ARM_GICV3_COMMON_CLASS(klass);
>+    HVFARMGICv3Class *kgc = HVF_GICV3_CLASS(klass);
>+
>+    agcc->pre_save = hvf_gicv3_get;
>+    agcc->post_load = hvf_gicv3_put;
>+
>+    device_class_set_parent_realize(dc, hvf_gicv3_realize,
>+                                    &kgc->parent_realize);
>+    resettable_class_set_parent_phases(rc, NULL, hvf_gicv3_reset_hold, NULL,
>+                                       &kgc->parent_phases);
>+}
>+
>+static const TypeInfo hvf_arm_gicv3_info = {
>+    .name = TYPE_HVF_GICV3,
>+    .parent = TYPE_ARM_GICV3_COMMON,
>+    .instance_size = sizeof(GICv3State),
>+    .class_init = hvf_gicv3_class_init,
>+    .class_size = sizeof(HVFARMGICv3Class),
>+};
>+
>+static void hvf_gicv3_register_types(void)
>+{
>+    type_register_static(&hvf_arm_gicv3_info);
>+}
>+
>+type_init(hvf_gicv3_register_types)
>+
>+#pragma clang diagnostic pop
>diff --git a/hw/intc/meson.build b/hw/intc/meson.build
>index 96742df090..b7baf8a0f6 100644
>--- a/hw/intc/meson.build
>+++ b/hw/intc/meson.build
>@@ -42,6 +42,7 @@ arm_common_ss.add(when: 'CONFIG_ARM_GIC', if_true: files('arm_gicv3_cpuif_common
> arm_common_ss.add(when: 'CONFIG_ARM_GICV3', if_true: files('arm_gicv3_cpuif.c'))
> specific_ss.add(when: 'CONFIG_ARM_GIC_KVM', if_true: files('arm_gic_kvm.c'))
> specific_ss.add(when: ['CONFIG_WHPX', 'TARGET_AARCH64'], if_true: files('arm_gicv3_whpx.c'))
>+specific_ss.add(when: ['CONFIG_HVF', 'CONFIG_ARM_GICV3'], if_true: files('arm_gicv3_hvf.c'))
> specific_ss.add(when: ['CONFIG_ARM_GIC_KVM', 'TARGET_AARCH64'], if_true: files('arm_gicv3_kvm.c', 'arm_gicv3_its_kvm.c'))
> arm_common_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_nvic.c'))
> specific_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_irqmp.c'))
>diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
>index c55cf18120..9adcab0a0c 100644
>--- a/include/hw/intc/arm_gicv3_common.h
>+++ b/include/hw/intc/arm_gicv3_common.h
>@@ -315,6 +315,7 @@ DECLARE_OBJ_CHECKERS(GICv3State, ARMGICv3CommonClass,
> 
> /* Types for GICv3 kernel-irqchip */
> #define TYPE_WHPX_GICV3 "whpx-arm-gicv3"
>+#define TYPE_HVF_GICV3 "hvf-arm-gicv3"
> 
> struct ARMGICv3CommonClass {
>     /*< private >*/
>-- 
>2.50.1 (Apple Git-155)
>
>

