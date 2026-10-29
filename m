Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17812606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 20:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=ofwM1lAF;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=gsajHAS7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMX1C-0008Eb-NI; Thu, 29 Oct 2026 16:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xMX11-0008BA-NO
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 16:46:27 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xMX0y-0007TA-JC
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 16:46:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=Pd01HOf
 WYL1sOloSDaR2h9TTs/3WipsKPPE7v7ZBa27htZGzSptwyluGWcpen4YwdXgO7Zfkok5c4
 l2lGezwSCDrM/xQqolspQPsmNIkDsltyALSu/SkJ2tfCeHPsPOihXwT8Mptpoko83IbC2J
 fIjt2eSJwpI3XoxOJyIKtGHT+JVty7g2UEVsGmh0+O+k2Rn9fc+2va+9xRF4thYq6GC+hx
 pU0XItDaFwayxxgM+a+rHG7pnYvqKtjEpne3ul1T+ebdGPzirG5zUYodXM9NjVL+oaawKx
 v9d8kaAhW1BIaWKUOAWfmVY9y650Z21n6KTezY8z7Y71Acva8HaJLww==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=b
 yOlCTQ4zW8ANLAUCo85KEYRXKPToSm/P/L0TBkI+y8=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=xr8V3QZyneaEtxe8JWrY35LPc5PRKFtADs1g15+wFN9eGuUWdV0DOGAbHcTV9WZ0BEEg
 vh2aIzEV0Z4rc0i3CjmGXs6JhleSNADx+Zstu03n2rXQ/AxnPW5SeOhX1XqHVznHX0QcEK
 2SwrgpvNrZf6hPt9ddt/Tn1FlMcCnH8wbK31War8TftuFJGtAkrmBZpyg0+3NsZaDAM+Za
 t1sNPqxJK5VlQt2lXS6D4kdqKlireb3mhfIAGHetPyptKz091aDyF7a22i2hLoNndvvANq
 mNmFNdD+3bn1gex9AGY3vt0EiQ3AsbR71hdfeDqR6AR8BwW8+9pEGfeIsMhCq6Tw==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=ofwM1lAF; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=gsajHAS7;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=byOlCTQ4
 zW8ANLAUCo85KEYRXKPToSm/P/L0TBkI+y8=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=ofwM1lAFdxiem5OM2ltvLQAAwLfMAjHbjCq
 a5JU41MZ7SsaM0eG1Fq2jnXDttQrt5KOJAZ7NFRsettRjVB4YxA+bMud2QNnvs5itm3Htm
 9fqeL4wWLP4S6djQ0AYd1fkWMEoNEMxtxvml53hRUGujI1zSOqWswKm5+HWZSh2794NeQl
 +KT1QVuJmodU/dEqW1BJLnpUp7TJNPyZt3ysQLTsgHpDIFcVyz50I7Glk5vH6E30foaFMl
 y9lQ8Vs2Xnf90ANAFtXTL6rI8uaC4CC1gBOK963SaExYaikoCouVmX5+3TtWysnHMRLE4c
 zA5T84JwrnLYH9BPnQ37AInh5sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=byOlCTQ4zW8ANLAUCo85KEYRXKPToSm/P/L0TBkI+y8=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=gsajHAS7OX8y+hu6R+
 QgsMDjXaAF3hU4rw7J5plblUCW81AuYzmJSMqtFkmTsmyqoKDu6KI0CZy1yFsTNch1AA==
Received: by mx1.catap.net (OpenSMTPD) id 590ddccc;
 Thu, 29 Oct 2026 21:46:17 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 73346aa4;
 Thu, 29 Oct 2026 21:46:13 +0100 (CET)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v5 13/26] hw/mips: add Octeon CIU3 interrupt routing
Date: Thu, 29 Oct 2026 21:43:58 +0100
Message-ID: <20261029204609.38989-14-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029204609.38989-1-kirill@korins.ky>
References: <20261029204609.38989-1-kirill@korins.ky>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.55.82.72; envelope-from=kirill@korins.ky;
 helo=mx1.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Model CIU3 interrupt sources, ISC and IDT registers, destination
selection and CP0 interrupt delivery. Route UART and mailbox sources
through CIU3 while keeping the legacy CIU register block separate.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
---
 hw/mips/octeon.c          | 483 ++++++++++++++++++++++++++++++++++++++
 hw/mips/octeon_internal.h |  15 ++
 2 files changed, 498 insertions(+)

diff --git a/hw/mips/octeon.c b/hw/mips/octeon.c
index eeca7ca67e..567be0905a 100644
--- a/hw/mips/octeon.c
+++ b/hw/mips/octeon.c
@@ -11,6 +11,7 @@
 #include "qemu/datadir.h"
 #include "qapi/error.h"
 #include "hw/core/clock.h"
+#include "hw/core/irq.h"
 #include "hw/core/boards.h"
 #include "hw/core/qdev-clock.h"
 #include "hw/core/qdev-properties.h"
@@ -74,6 +75,28 @@ OBJECT_DECLARE_SIMPLE_TYPE(OcteonIntcState, OCTEON_INTC)
 #define OCTEON_CIU3_PP_RST_PENDING  0x110
 #define OCTEON_CIU3_NMI             0x160
 #define OCTEON_CIU3_FUSE            0x1a0
+#define OCTEON_CIU3_IDT_CTL(idt)    ((idt) * 8 + 0x110000U)
+#define OCTEON_CIU3_IDT_PP(idt)     ((idt) * 32 + 0x120000U)
+#define OCTEON_CIU3_IDT_IO(idt)     ((idt) * 8 + 0x130000U)
+#define OCTEON_CIU3_DEST_PP_INT(cpu) ((cpu) * 8 + 0x200000U)
+#define OCTEON_CIU3_DEST_PP_INT_INTSN_SHIFT 32
+#define OCTEON_CIU3_DEST_PP_INT_INTR 0x0000000000000001ULL
+#define OCTEON_CIU3_IDT_CTL_IP_NUM  0x7
+#define OCTEON_CIU3_CP0_IRQ_BASE    2
+#define OCTEON_CIU3_ISC_CTL_BASE    0x80000000U
+#define OCTEON_CIU3_ISC_W1C_BASE    0x90000000U
+#define OCTEON_CIU3_ISC_W1S_BASE    0xa0000000U
+#define OCTEON_CIU3_ISC_CTL_IDT     0x0000000000ff0000ULL
+#define OCTEON_CIU3_ISC_CTL_IDT_SHIFT 16
+#define OCTEON_CIU3_ISC_CTL_IMP     0x0000000000008000ULL
+#define OCTEON_CIU3_ISC_CTL_EN      0x0000000000000002ULL
+#define OCTEON_CIU3_ISC_CTL_RAW     0x0000000000000001ULL
+#define OCTEON_CIU3_SRC_LEVEL       0x00000001U
+#define OCTEON_CIU3_SRC_RAW         0x00000002U
+#define OCTEON_CIU3_NINTSN          (1U << 20)
+#define OCTEON_CIU3_ISC_SIZE        (OCTEON_CIU3_NINTSN * 8)
+#define OCTEON_CIU3_MBOX_INTSN(cpu) ((cpu) + 0x4000U)
+#define OCTEON_CIU3_UART0_INTSN     0x8000
 
 /*
  * QEMU-only backing for per-core CVMSEG. Keep it outside guest DRAM;
@@ -126,6 +149,13 @@ struct OcteonIntcState {
     OcteonPeripheralState parent_obj;
     MemoryRegion ciu3;
     uint64_t ciu3_pp_rst;
+    uint32_t ciu3_src_state[OCTEON_CIU3_SRC_COUNT];
+    uint64_t ciu3_src_ctl[OCTEON_CIU3_SRC_COUNT];
+    uint64_t ciu3_idt_ctl[OCTEON_CIU3_IDT_COUNT];
+    uint64_t ciu3_idt_pp[OCTEON_CIU3_IDT_COUNT];
+    uint64_t ciu3_idt_io[OCTEON_CIU3_IDT_COUNT];
+    uint16_t ciu3_src_cursor[OCTEON_MAX_CPUS][OCTEON_CIU3_CP0_IRQ_COUNT];
+    uint8_t ciu3_irq_line[OCTEON_MAX_CPUS][OCTEON_CIU3_CP0_IRQ_COUNT];
 };
 
 uint64_t octeon_read64(uint64_t value, hwaddr addr, unsigned size)
@@ -189,6 +219,286 @@ static void octeon_validate_clocks(OcteonMachineState *oms)
     }
 }
 
+static bool octeon_ciu3_source_from_intsn(uint32_t intsn,
+                                          unsigned int *source)
+{
+    if (intsn == OCTEON_CIU3_UART0_INTSN) {
+        *source = OCTEON_CIU3_SRC_UART0;
+        return true;
+    }
+    if (intsn >= OCTEON_CIU3_MBOX_INTSN(0) &&
+        intsn < OCTEON_CIU3_MBOX_INTSN(OCTEON_MAX_CPUS)) {
+        *source = OCTEON_CIU3_SRC_MBOX0 +
+                  intsn - OCTEON_CIU3_MBOX_INTSN(0);
+        return true;
+    }
+
+    return false;
+}
+
+static uint32_t octeon_ciu3_source_intsn(unsigned int source)
+{
+    switch (source) {
+    case OCTEON_CIU3_SRC_UART0:
+        return OCTEON_CIU3_UART0_INTSN;
+    }
+
+    if (source >= OCTEON_CIU3_SRC_MBOX0 &&
+        source < OCTEON_CIU3_SRC_COUNT) {
+        return OCTEON_CIU3_MBOX_INTSN(source - OCTEON_CIU3_SRC_MBOX0);
+    }
+
+    g_assert_not_reached();
+}
+
+static bool octeon_ciu3_source_is_level(unsigned int source)
+{
+    switch (source) {
+    case OCTEON_CIU3_SRC_UART0:
+        return true;
+    }
+
+    return false;
+}
+
+static bool octeon_ciu3_set_level(OcteonState *s, unsigned int source,
+                                  int level)
+{
+    uint32_t old;
+    uint32_t new;
+    uint32_t cmp = qatomic_read(&s->intc->ciu3_src_state[source]);
+
+    do {
+        old = cmp;
+        if (level) {
+            new = old | OCTEON_CIU3_SRC_LEVEL | OCTEON_CIU3_SRC_RAW;
+        } else {
+            new = old & ~(OCTEON_CIU3_SRC_LEVEL | OCTEON_CIU3_SRC_RAW);
+        }
+        if (new == old) {
+            return false;
+        }
+        cmp = qatomic_cmpxchg(&s->intc->ciu3_src_state[source], old, new);
+    } while (old != cmp);
+
+    return true;
+}
+
+static void octeon_ciu3_clear_raw(OcteonState *s, unsigned int source)
+{
+    uint32_t old;
+    uint32_t new;
+    uint32_t cmp = qatomic_read(&s->intc->ciu3_src_state[source]);
+
+    do {
+        old = cmp;
+        if (octeon_ciu3_source_is_level(source) &&
+            (old & OCTEON_CIU3_SRC_LEVEL)) {
+            new = old | OCTEON_CIU3_SRC_RAW;
+        } else {
+            new = old & ~OCTEON_CIU3_SRC_RAW;
+        }
+        if (new == old) {
+            return;
+        }
+        cmp = qatomic_cmpxchg(&s->intc->ciu3_src_state[source], old, new);
+    } while (old != cmp);
+}
+
+static bool octeon_ciu3_isc_decode(hwaddr reg, uint32_t base,
+                                   uint32_t *intsn)
+{
+    if (reg < base || reg >= base + OCTEON_CIU3_ISC_SIZE) {
+        return false;
+    }
+
+    *intsn = (reg - base) >> 3;
+    return true;
+}
+
+static uint64_t octeon_ciu3_isc_read(OcteonState *s, uint32_t intsn)
+{
+    unsigned int src;
+    uint64_t value;
+
+    if (!octeon_ciu3_source_from_intsn(intsn, &src)) {
+        return 0;
+    }
+
+    value = qatomic_read(&s->intc->ciu3_src_ctl[src]) | OCTEON_CIU3_ISC_CTL_IMP;
+    if (qatomic_read(&s->intc->ciu3_src_state[src]) & OCTEON_CIU3_SRC_RAW) {
+        value |= OCTEON_CIU3_ISC_CTL_RAW;
+    }
+    return value;
+}
+
+static bool octeon_ciu3_source_pending(OcteonState *s, unsigned int cpu_index,
+                                       unsigned int irq, unsigned int src)
+{
+    uint64_t ctl = qatomic_read(&s->intc->ciu3_src_ctl[src]);
+    unsigned int idt;
+    unsigned int output;
+
+    if (!(qatomic_read(&s->intc->ciu3_src_state[src]) & OCTEON_CIU3_SRC_RAW) ||
+        !(ctl & OCTEON_CIU3_ISC_CTL_EN)) {
+        return false;
+    }
+
+    idt = (ctl & OCTEON_CIU3_ISC_CTL_IDT) >>
+          OCTEON_CIU3_ISC_CTL_IDT_SHIFT;
+    if (idt >= OCTEON_CIU3_IDT_COUNT) {
+        return false;
+    }
+
+    output = qatomic_read(&s->intc->ciu3_idt_ctl[idt]) &
+             OCTEON_CIU3_IDT_CTL_IP_NUM;
+    if (output >= OCTEON_CIU3_CP0_IRQ_COUNT ||
+        irq != OCTEON_CIU3_CP0_IRQ_BASE + output) {
+        return false;
+    }
+
+    return qatomic_read(&s->intc->ciu3_idt_pp[idt]) & (1ULL << cpu_index);
+}
+
+static bool octeon_ciu3_pending_intsn(OcteonState *s, unsigned int cpu_index,
+                                      unsigned int irq, uint32_t *intsn)
+{
+    unsigned int src;
+
+    for (src = 0; src < OCTEON_CIU3_SRC_COUNT; src++) {
+        if (octeon_ciu3_source_pending(s, cpu_index, irq, src)) {
+            *intsn = octeon_ciu3_source_intsn(src);
+            return true;
+        }
+    }
+
+    return false;
+}
+
+static bool octeon_ciu3_pending_intsn_from(OcteonState *s,
+                                           unsigned int cpu_index,
+                                           unsigned int irq,
+                                           unsigned int first_src,
+                                           uint32_t *intsn,
+                                           unsigned int *source)
+{
+    unsigned int i;
+    unsigned int src;
+
+    for (i = 0; i < OCTEON_CIU3_SRC_COUNT; i++) {
+        src = (first_src + i) % OCTEON_CIU3_SRC_COUNT;
+        if (octeon_ciu3_source_pending(s, cpu_index, irq, src)) {
+            *intsn = octeon_ciu3_source_intsn(src);
+            *source = src;
+            return true;
+        }
+    }
+
+    return false;
+}
+
+static bool octeon_ciu3_pending_dest_intsn(OcteonState *s,
+                                           unsigned int cpu_index,
+                                           uint32_t *intsn)
+{
+    unsigned int irq;
+    unsigned int irq_index;
+    unsigned int src;
+
+    for (irq = OCTEON_CIU3_CP0_IRQ_BASE;
+         irq < OCTEON_CIU3_CP0_IRQ_BASE + OCTEON_CIU3_CP0_IRQ_COUNT;
+         irq++) {
+        irq_index = irq - OCTEON_CIU3_CP0_IRQ_BASE;
+        if (octeon_ciu3_pending_intsn_from(s, cpu_index, irq,
+                qatomic_read(&s->intc->ciu3_src_cursor[cpu_index][irq_index]),
+                intsn, &src)) {
+            qatomic_set(&s->intc->ciu3_src_cursor[cpu_index][irq_index],
+                        (src + 1) % OCTEON_CIU3_SRC_COUNT);
+            return true;
+        }
+    }
+
+    return false;
+}
+
+static void octeon_ciu3_set_cpu_irq(OcteonState *s, unsigned int cpu_index,
+                                    unsigned int irq, bool level)
+{
+    CPUMIPSState *env = &s->cpu[cpu_index].cpu->env;
+    unsigned int irq_index = irq - OCTEON_CIU3_CP0_IRQ_BASE;
+    uint8_t new_level = level;
+    uint8_t old_level;
+
+    old_level = qatomic_xchg(&s->intc->ciu3_irq_line[cpu_index][irq_index],
+                             new_level);
+    if (old_level == new_level) {
+        return;
+    }
+
+    qemu_set_irq(env->irq[irq], level);
+}
+
+static void octeon_intc_update_cpu(OcteonState *s, unsigned int cpu_index)
+{
+    uint32_t intsn;
+    unsigned int irq;
+    bool level;
+
+    if (cpu_index >= s->cpu_count || !s->cpu[cpu_index].cpu) {
+        return;
+    }
+
+    if (qatomic_read(&s->intc->ciu3_pp_rst) & (1ULL << cpu_index)) {
+        for (irq = OCTEON_CIU3_CP0_IRQ_BASE;
+             irq < OCTEON_CIU3_CP0_IRQ_BASE + OCTEON_CIU3_CP0_IRQ_COUNT;
+             irq++) {
+            octeon_ciu3_set_cpu_irq(s, cpu_index, irq, false);
+        }
+        return;
+    }
+
+    for (irq = OCTEON_CIU3_CP0_IRQ_BASE;
+         irq < OCTEON_CIU3_CP0_IRQ_BASE + OCTEON_CIU3_CP0_IRQ_COUNT;
+         irq++) {
+        level = false;
+        if (octeon_ciu3_pending_intsn(s, cpu_index, irq, &intsn)) {
+            level = true;
+        }
+
+        octeon_ciu3_set_cpu_irq(s, cpu_index, irq, level);
+    }
+}
+
+static void octeon_intc_request_cpu_update(OcteonState *s,
+                                           unsigned int cpu_index)
+{
+    if (cpu_index >= s->cpu_count || !s->cpu[cpu_index].cpu) {
+        return;
+    }
+
+    octeon_intc_update_cpu(s, cpu_index);
+}
+
+static void octeon_intc_update_cpu_mask(OcteonState *s, uint64_t cpu_mask)
+{
+    unsigned int cpu;
+
+    for (cpu = 0; cpu < s->cpu_count; cpu++) {
+        if (cpu_mask & (1ULL << cpu)) {
+            octeon_intc_request_cpu_update(s, cpu);
+        }
+    }
+}
+
+static void octeon_intc_update_all_cpus(OcteonState *s)
+{
+    unsigned int cpu;
+
+    for (cpu = 0; cpu < s->cpu_count; cpu++) {
+        octeon_intc_request_cpu_update(s, cpu);
+    }
+}
+
 static uint64_t octeon_present_cpu_mask(OcteonState *s)
 {
     return (1ULL << s->cpu_count) - 1;
@@ -199,6 +509,24 @@ static uint64_t octeon_secondary_cpu_mask(OcteonState *s)
     return octeon_present_cpu_mask(s) & ~1ULL;
 }
 
+static uint64_t octeon_ciu3_ctl_cpu_mask(OcteonState *s, uint64_t ctl)
+{
+    unsigned int idt = (ctl & OCTEON_CIU3_ISC_CTL_IDT) >>
+                       OCTEON_CIU3_ISC_CTL_IDT_SHIFT;
+
+    if (idt >= OCTEON_CIU3_IDT_COUNT) {
+        return 0;
+    }
+
+    return qatomic_read(&s->intc->ciu3_idt_pp[idt]);
+}
+
+static uint64_t octeon_ciu3_source_cpu_mask(OcteonState *s, unsigned int src)
+{
+    return octeon_ciu3_ctl_cpu_mask(
+        s, qatomic_read(&s->intc->ciu3_src_ctl[src]));
+}
+
 static void octeon_cpu_park_now(MIPSCPU *cpu)
 {
     CPUMIPSState *env = &cpu->env;
@@ -268,6 +596,9 @@ static uint64_t octeon_ciu3_read(void *opaque, hwaddr addr, unsigned size)
     OcteonState *s = opaque;
     hwaddr reg = addr & ~7ULL;
     uint64_t value;
+    uint32_t intsn;
+    unsigned int cpu;
+    unsigned int idt;
 
     if (reg == OCTEON_CIU3_PP_RST) {
         return octeon_read64(qatomic_read(&s->intc->ciu3_pp_rst), addr, size);
@@ -286,6 +617,51 @@ static uint64_t octeon_ciu3_read(void *opaque, hwaddr addr, unsigned size)
         return octeon_read64(value, addr, size);
     }
 
+    if (reg >= OCTEON_CIU3_IDT_CTL(0) &&
+        reg < OCTEON_CIU3_IDT_CTL(OCTEON_CIU3_IDT_COUNT)) {
+        idt = (reg - OCTEON_CIU3_IDT_CTL(0)) >> 3;
+        return octeon_read64(qatomic_read(&s->intc->ciu3_idt_ctl[idt]),
+                             addr, size);
+    }
+
+    if (reg >= OCTEON_CIU3_IDT_PP(0) &&
+        reg < OCTEON_CIU3_IDT_PP(OCTEON_CIU3_IDT_COUNT)) {
+        idt = (reg - OCTEON_CIU3_IDT_PP(0)) >> 5;
+        return octeon_read64(qatomic_read(&s->intc->ciu3_idt_pp[idt]),
+                             addr, size);
+    }
+
+    if (reg >= OCTEON_CIU3_IDT_IO(0) &&
+        reg < OCTEON_CIU3_IDT_IO(OCTEON_CIU3_IDT_COUNT)) {
+        idt = (reg - OCTEON_CIU3_IDT_IO(0)) >> 3;
+        return octeon_read64(qatomic_read(&s->intc->ciu3_idt_io[idt]),
+                             addr, size);
+    }
+
+    if (reg >= OCTEON_CIU3_DEST_PP_INT(0) &&
+        reg < OCTEON_CIU3_DEST_PP_INT(OCTEON_MAX_CPUS)) {
+        cpu = (reg - OCTEON_CIU3_DEST_PP_INT(0)) >> 3;
+        value = 0;
+        if (cpu < s->cpu_count) {
+            if (!(qatomic_read(&s->intc->ciu3_pp_rst) & (1ULL << cpu)) &&
+                octeon_ciu3_pending_dest_intsn(s, cpu, &intsn)) {
+                value = OCTEON_CIU3_DEST_PP_INT_INTR |
+                        ((uint64_t)intsn <<
+                         OCTEON_CIU3_DEST_PP_INT_INTSN_SHIFT);
+            }
+        }
+        return octeon_read64(value, addr, size);
+    }
+
+    if (octeon_ciu3_isc_decode(reg, OCTEON_CIU3_ISC_CTL_BASE, &intsn)) {
+        return octeon_read64(octeon_ciu3_isc_read(s, intsn), addr, size);
+    }
+
+    if (octeon_ciu3_isc_decode(reg, OCTEON_CIU3_ISC_W1C_BASE, &intsn) ||
+        octeon_ciu3_isc_decode(reg, OCTEON_CIU3_ISC_W1S_BASE, &intsn)) {
+        return octeon_read64(octeon_ciu3_isc_read(s, intsn), addr, size);
+    }
+
     return 0;
 }
 
@@ -295,7 +671,10 @@ static void octeon_ciu3_write(void *opaque, hwaddr addr,
     OcteonState *s = opaque;
     hwaddr reg = addr & ~7ULL;
     uint64_t old;
+    uint32_t intsn;
     unsigned int cpu;
+    unsigned int idt;
+    unsigned int src;
 
     if (reg == OCTEON_CIU3_PP_RST) {
         value = octeon_atomic_write64(&s->intc->ciu3_pp_rst, addr, value, size,
@@ -314,13 +693,89 @@ static void octeon_ciu3_write(void *opaque, hwaddr addr,
                 octeon_ciu3_start_cpu(s, cpu);
             }
         }
+        octeon_intc_update_all_cpus(s);
         return;
     }
 
     if (reg == OCTEON_CIU3_NMI) {
         octeon_ciu3_nmi(s, octeon_write64(0, addr, value, size));
+        octeon_intc_update_all_cpus(s);
+        return;
+    }
+
+    if (reg >= OCTEON_CIU3_IDT_CTL(0) &&
+        reg < OCTEON_CIU3_IDT_CTL(OCTEON_CIU3_IDT_COUNT)) {
+        idt = (reg - OCTEON_CIU3_IDT_CTL(0)) >> 3;
+        octeon_atomic_write64(&s->intc->ciu3_idt_ctl[idt], addr, value, size,
+                              UINT64_MAX, 0, NULL);
+        octeon_intc_update_cpu_mask(
+            s, qatomic_read(&s->intc->ciu3_idt_pp[idt]));
+        return;
+    }
+
+    if (reg >= OCTEON_CIU3_IDT_PP(0) &&
+        reg < OCTEON_CIU3_IDT_PP(OCTEON_CIU3_IDT_COUNT)) {
+        idt = (reg - OCTEON_CIU3_IDT_PP(0)) >> 5;
+        value = octeon_atomic_write64(&s->intc->ciu3_idt_pp[idt], addr, value,
+                                      size, UINT64_MAX, 0, &old);
+        octeon_intc_update_cpu_mask(s, old | value);
+        return;
+    }
+
+    if (reg >= OCTEON_CIU3_IDT_IO(0) &&
+        reg < OCTEON_CIU3_IDT_IO(OCTEON_CIU3_IDT_COUNT)) {
+        idt = (reg - OCTEON_CIU3_IDT_IO(0)) >> 3;
+        octeon_atomic_write64(&s->intc->ciu3_idt_io[idt], addr, value, size,
+                              UINT64_MAX, 0, NULL);
+        octeon_intc_update_cpu_mask(
+            s, qatomic_read(&s->intc->ciu3_idt_pp[idt]));
+        return;
+    }
+
+    if (octeon_ciu3_isc_decode(reg, OCTEON_CIU3_ISC_CTL_BASE, &intsn)) {
+        if (octeon_ciu3_source_from_intsn(intsn, &src)) {
+            value = octeon_atomic_write64(&s->intc->ciu3_src_ctl[src], addr,
+                                          value, size,
+                                          ~OCTEON_CIU3_ISC_CTL_RAW,
+                                          0, &old);
+            octeon_intc_update_cpu_mask(s,
+                                        octeon_ciu3_ctl_cpu_mask(s, old) |
+                                        octeon_ciu3_ctl_cpu_mask(s, value));
+        }
+        return;
+    }
+
+    if (octeon_ciu3_isc_decode(reg, OCTEON_CIU3_ISC_W1C_BASE, &intsn)) {
+        if (octeon_ciu3_source_from_intsn(intsn, &src)) {
+            old = qatomic_read(&s->intc->ciu3_src_ctl[src]);
+            if (value & OCTEON_CIU3_ISC_CTL_EN) {
+                qatomic_and(&s->intc->ciu3_src_ctl[src],
+                            ~OCTEON_CIU3_ISC_CTL_EN);
+            }
+            if (value & OCTEON_CIU3_ISC_CTL_RAW) {
+                octeon_ciu3_clear_raw(s, src);
+            }
+            octeon_intc_update_cpu_mask(s,
+                                        octeon_ciu3_ctl_cpu_mask(s, old) |
+                                        octeon_ciu3_source_cpu_mask(s, src));
+        }
         return;
     }
+
+    if (octeon_ciu3_isc_decode(reg, OCTEON_CIU3_ISC_W1S_BASE, &intsn)) {
+        if (octeon_ciu3_source_from_intsn(intsn, &src)) {
+            old = qatomic_read(&s->intc->ciu3_src_ctl[src]);
+            if (value & OCTEON_CIU3_ISC_CTL_EN) {
+                qatomic_or(&s->intc->ciu3_src_ctl[src], OCTEON_CIU3_ISC_CTL_EN);
+            }
+            if (value & OCTEON_CIU3_ISC_CTL_RAW) {
+                qatomic_or(&s->intc->ciu3_src_state[src], OCTEON_CIU3_SRC_RAW);
+            }
+            octeon_intc_update_cpu_mask(s,
+                                        octeon_ciu3_ctl_cpu_mask(s, old) |
+                                        octeon_ciu3_source_cpu_mask(s, src));
+        }
+    }
 }
 
 static const MemoryRegionOps octeon_ciu3_ops = {
@@ -333,6 +788,26 @@ static const MemoryRegionOps octeon_ciu3_ops = {
     },
 };
 
+void octeon_irq_set(void *opaque, int irq, int level)
+{
+    OcteonState *s = opaque;
+    unsigned int src;
+
+    switch (irq) {
+    case OCTEON_IRQ_UART:
+        src = OCTEON_CIU3_SRC_UART0;
+        if (!octeon_ciu3_set_level(s, src, level)) {
+            return;
+        }
+        break;
+    default:
+        return;
+    }
+
+    octeon_intc_update_cpu_mask(s, octeon_ciu3_source_cpu_mask(s, src));
+}
+
+
 static void octeon_cpu_after_reset(OcteonCPUState *cs)
 {
     CPUMIPSState *env = &cs->cpu->env;
@@ -568,6 +1043,14 @@ static void octeon_intc_reset_hold(Object *obj, ResetType type)
     }
 
     qatomic_set(&intc->ciu3_pp_rst, octeon_secondary_cpu_mask(s));
+    memset(intc->ciu3_src_state, 0, sizeof(intc->ciu3_src_state));
+    memset(intc->ciu3_src_ctl, 0, sizeof(intc->ciu3_src_ctl));
+    memset(intc->ciu3_idt_ctl, 0, sizeof(intc->ciu3_idt_ctl));
+    memset(intc->ciu3_idt_pp, 0, sizeof(intc->ciu3_idt_pp));
+    memset(intc->ciu3_idt_io, 0, sizeof(intc->ciu3_idt_io));
+    memset(intc->ciu3_src_cursor, 0, sizeof(intc->ciu3_src_cursor));
+    memset(intc->ciu3_irq_line, 0, sizeof(intc->ciu3_irq_line));
+    octeon_intc_update_all_cpus(s);
 }
 
 static void octeon_peripheral_class_init(ObjectClass *klass,
diff --git a/hw/mips/octeon_internal.h b/hw/mips/octeon_internal.h
index 884eed8994..fef88419b5 100644
--- a/hw/mips/octeon_internal.h
+++ b/hw/mips/octeon_internal.h
@@ -14,6 +14,20 @@
 #include "target/mips/cpu.h"
 
 #define OCTEON_MAX_CPUS             16
+#define OCTEON_CIU3_CP0_IRQ_COUNT   4
+#define OCTEON_CIU3_IDT_COUNT       (OCTEON_MAX_CPUS * 4)
+
+typedef enum OcteonIRQ {
+    OCTEON_IRQ_UART,
+    OCTEON_IRQ_COUNT,
+} OcteonIRQ;
+
+typedef enum OcteonCiu3Source {
+    OCTEON_CIU3_SRC_UART0,
+    OCTEON_CIU3_SRC_MBOX0,
+    OCTEON_CIU3_SRC_COUNT = OCTEON_CIU3_SRC_MBOX0 + OCTEON_MAX_CPUS,
+} OcteonCiu3Source;
+
 typedef struct OcteonState OcteonState;
 typedef struct OcteonRstState OcteonRstState;
 typedef struct OcteonIntcState OcteonIntcState;
@@ -48,5 +62,6 @@ struct OcteonState {
 uint64_t octeon_read64(uint64_t value, hwaddr addr, unsigned size);
 uint64_t octeon_write64(uint64_t old, hwaddr addr,
                         uint64_t value, unsigned size);
+void octeon_irq_set(void *opaque, int irq, int level);
 
 #endif
-- 
2.56.0


