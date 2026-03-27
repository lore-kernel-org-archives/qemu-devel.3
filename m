Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2994210ED65C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65Bu-0006Zr-Oo; Fri, 27 Mar 2026 07:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65Br-0006WC-Av
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:23 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65Bp-0007vL-FH
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:23 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-439b2965d4bso1506662f8f.2
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774610240; x=1775215040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x13cV/o1Pi9D6t5vPv/J+WSzawf4SKPSgV3PxkKGE6o=;
 b=lpaPJ2uriPePz4a2UUxBagKMf4pthf9QUjn3bnncugnhq/ToIfiKIEpWFio7Orwe/1
 DYYwUXchb4BHGhwWodMdlelGp0vhVzNK9rDOM5xQ5c95xZHtFXg/JcfgjLaVq+bS+woP
 5uCmAoBhUPMXAj79HJUSDgBKbEwwQ+rQlibYaXHiksD7rlGp2L960cMkIeeNsaQgpack
 YK/X/rLsEdecR0qaKWCWCfJuzu4k0gcsWrJevXa6D/x1Z2ncG3bE/GYgcGMd9sYP2+cI
 JW6oEcRaQZ2vIBmRlLRZgvA5ak0RhwbOt3ZA2GCQ64/ccyPfe/vf6fpg/O0ItL8nP2pn
 3p7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610240; x=1775215040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x13cV/o1Pi9D6t5vPv/J+WSzawf4SKPSgV3PxkKGE6o=;
 b=G1sQdBJSwJB0nAZgCCsIM0hp4L54wo5tmtbVzGF54/eAUlmpcjsgdC1LFUUW9enEPD
 72cqs8paBufXJORtqAi91CPFIHe4XOcu9ZSuIUTEXH35fyanSMHBiLnYFqTA8/UqRNSZ
 /KQvbuwP1DV6lltsGhT+K8nj/YqkO6tyaI+OvirJ2H6oRvfBOQ6Bxljcd9YmD0em9YiI
 A5xNoyAbi9LRfqoY5ZNMNZ6Fmst+nJMtgKIzFX5YbDXiJQyLJElTfSKUvzKuKjSeEBal
 mekSDc732sKn2jNuWN948t/l3xEOjNDlX5DSyumvC8KbK5wKoTF5p12c9YL8U0cMt6DV
 4d8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVC5LsmWDR/FE+g1aZtYNQOLYfPVJ0bVlYbCuYkfhY9VUwV0YJwCmx9JOsgtdBKlbd1PEOurJuTFV1K@nongnu.org
X-Gm-Message-State: AOJu0YwG49eymVRpqm4VMjpzDDk+TibML7JX5XuDGbWYCGw6jWfI7k53
 uG8sh1rWzfKXjDbg+PlzzHdCgt6hbwLFyCEgp6FiAVYeCJ7anj7SFxcoWYaebC2+oVs=
X-Gm-Gg: ATEYQzyXkvn8UwJ1i3bVv8bhVN+ZLLyZF+aI+nuZOwCG56OOQFymreJm8kR+chZnW7R
 hqUJPHHCuB+MmPqVAF7/meZpN/xeW0OtiFBTWhx0NqchGYX+Pgr8Q/v0fshO7uHPaANwxZaKjzk
 fdFHFWV+UqTWh63D/dr41wuQ1mI8LHjD87HjFMk8fK9P0NwcsNPt47Lw5tdAO7CjU2QmlDidhBE
 7hUx9ym9O83S0DP8luqTWdqx6ZLmBWArYoluqf9DApRndSIffbSPIouNsmtwG3Y1eu3oUYp4IVu
 /o8p4noU42bZzFEqxAo1wweNaHU9bgQuCh8tCWkRF+aVKg9ABILxuD5jUu3xq/b/iF1zbfGnv1f
 0wWDkPmJJ3uqDCEx9CgcIr+wk8M+LuoNjukQ+HEfX/bQfLXMn+Tyo9gXWuV5E+oi79AM/UGcSGx
 u4ngcxazFfsIGDpB4Y38Y0SARQ/J+/S24zuQEgf4dUlA95v6X16Jud6YiZegwD9h7/vm72JxEhr
 gSivNr5Mu61fG5QCYUGVNCW+tVamhE=
X-Received: by 2002:a05:6000:40cd:b0:436:3707:2bf0 with SMTP id
 ffacd0b85a97d-43b9ea465e0mr3100215f8f.35.1774610239830; 
 Fri, 27 Mar 2026 04:17:19 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm15484227f8f.18.2026.03.27.04.17.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:17:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 19/65] target/arm: GICv5 cpuif: Implement the GIC CDPRI
 instruction
Date: Fri, 27 Mar 2026 11:16:14 +0000
Message-ID: <20260327111700.795099-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327111700.795099-1-peter.maydell@linaro.org>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

Implement the CPU interface GIC CDPRI instruction, which is a wrapper
around the SetPriority operation.

As with the barrier insns, we omit for the moment details which are
needed when the GICv5 supports virtualization:

 * traps when legacy GICv3 emulation is enabled
 * fine-grained-trap handling (which is done via
   registers that are new in GICv5)
 * sending the command for the virtual interrupt domain
   when inside a guest

The CD instructions operate on the Current Physical Interrupt Domain,
which is the one associated with the current security state and
exception level.  The spec also has the concept of a Logical
Interrupt Domain, which is the one associated with the security state
defined by SCR_EL3.{NS,NSE}.  Mostly the logical interrupt domain is
used by the LD instructions, which are EL3-only; but we will also
want the concept later for handling some banked registers, so we
define functions for both.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 target/arm/tcg/gicv5-cpuif.c | 58 ++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 7392a98c49..0c2bba5ce9 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -10,6 +10,59 @@
 #include "cpu.h"
 #include "internals.h"
 #include "cpregs.h"
+#include "hw/intc/arm_gicv5_stream.h"
+
+FIELD(GIC_CDPRI, ID, 0, 24)
+FIELD(GIC_CDPRI, TYPE, 29, 3)
+FIELD(GIC_CDPRI, PRIORITY, 35, 5)
+
+static GICv5Common *gicv5_get_gic(CPUARMState *env)
+{
+    return env->gicv5state;
+}
+
+static GICv5Domain gicv5_logical_domain(CPUARMState *env)
+{
+    /*
+     * Return the Logical Interrupt Domain, which is the one associated
+     * with the security state selected by the SCR_EL3.{NS,NSE} bits
+     */
+    switch (arm_security_space_below_el3(env)) {
+    case ARMSS_Secure:
+        return GICV5_ID_S;
+    case ARMSS_NonSecure:
+        return GICV5_ID_NS;
+    case ARMSS_Realm:
+        return GICV5_ID_REALM;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static GICv5Domain gicv5_current_phys_domain(CPUARMState *env)
+{
+    /*
+     * Return the Current Physical Interrupt Domain as
+     * defined by R_ZFCXM.
+     */
+    if (arm_current_el(env) == 3) {
+        return GICV5_ID_EL3;
+    }
+    return gicv5_logical_domain(env);
+}
+
+static void gic_cdpri_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                            uint64_t value)
+{
+    GICv5Common *gic = gicv5_get_gic(env);
+    uint8_t priority = FIELD_EX64(value, GIC_CDPRI, PRIORITY);
+    GICv5IntType type = FIELD_EX64(value, GIC_CDPRI, TYPE);
+    uint32_t id = FIELD_EX64(value, GIC_CDPRI, ID);
+    bool virtual = false;
+    GICv5Domain domain = gicv5_current_phys_domain(env);
+
+    gicv5_set_priority(gic, id, priority, domain, type, virtual);
+}
 
 static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
     /*
@@ -33,6 +86,11 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .opc0 = 1, .opc1 = 0, .crn = 12, .crm = 0, .opc2 = 1,
         .access = PL1_W, .type = ARM_CP_NOP,
     },
+    {   .name = "GIC_CDPRI", .state = ARM_CP_STATE_AA64,
+        .opc0 = 1, .opc1 = 0, .crn = 12, .crm = 1, .opc2 = 2,
+        .access = PL1_W, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .writefn = gic_cdpri_write,
+    },
 };
 
 void define_gicv5_cpuif_regs(ARMCPU *cpu)
-- 
2.43.0


