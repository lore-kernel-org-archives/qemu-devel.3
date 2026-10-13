Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD8BCC6B13
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY8B-0006Tq-VY; Tue, 13 Oct 2026 04:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY4c-0001n9-6D
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:41:28 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY4Z-0008Id-BS
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:41:25 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a19cba5c14so20027295e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880882; x=1792485682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/rH4fU/p7+EqPtCiTHc5w5GxOjkg2Vv400q3+sU1L1o=;
 b=l/eg47UIJScBomEF3y8j93j7ULzOCBsUfZJTjLhdiIIOfDNh2DgUiacZ98d7rERqbc
 LnF/6QLYSXTvSshgX9PzeBn+JmpAsGUk7z8V6vCerMSu7BUsiI67QP8xQ647bqY7H0hq
 5oesSbiSkTX9YzCwmVHMXpZSxr73OSlmIVB64fuCNwf7ERo62BYqAYCEk+xPK5qYmTWl
 YbuhgazTWXR2P8pyST7aWj9QdBmu49v3mJExMvqPkqGdkegiKFW6BTQ3b8i80QP0I03y
 Yk6lGV+zB1LhLViBJdzxG7Hu4BTdOESAKNIU/zyM0g23iV7gCUrDDxJr56GCB9XtCH1B
 5p6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880882; x=1792485682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/rH4fU/p7+EqPtCiTHc5w5GxOjkg2Vv400q3+sU1L1o=;
 b=JmF4kEEIOLuVB6V+vQvqJ8pAA3MzCN2BE7VoCc8SAjE+gJ2jkk61M0VkFPvFdG7bVc
 l7N9wwyCFtDYF9DGKs9CAB9oJKgu7rR52H15xbd0XfuWLzDpqYCjqlfR0ww4dDpIH9zM
 Vbf73/P9rGLQfSfhX8LYZbpzjLDyX9Vb/nv7aTqUbbp1r+leiHmdik6EFUZqNMbW0xMw
 p72B6Z5/zf5tbYVf+v33w/bNF34TKskazfvTKi7ZYGhEvNxgJ5ioVuiInugBPY9B/h4k
 mBWKOd5lg56An6suR02ix5lEa3sAVdluaigIjpVlzKG5T/8aS2ypfRYNdxTtFWEcMnBk
 5Sbg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx+G8Ce9KXSwGbMXC/7DNum1I2mA+spx+QJmyBC6YrwUmFfYW6xbQVU26WW///akkDhnNEWyWlrOqyK@nongnu.org
X-Gm-Message-State: AFq9FYK2qfsisPKaaU6fLQ5hUGXNo3DE1+hjNV5Wqp/qRxqZch1lPCwb
 OA7yRdRzbJ5RsB0jvZaWgkvZeZ/E8qtL4o6SEMFss5I7+pge77+wTKprumrAxXrqEcE=
X-Gm-Gg: AYBFou3SU4HEXm4Kj5O1kMkTvaPOyTDwUibJ0S+8Zc3Wq3T8jxApAQ1u8Av1Fr8/PX3
 f8qDvLC058eoD+OqiEOm5d1xJJvEKNWUgj9gKCTfrKyH2U9qLlXKcdpyx0b0VKZWP3lJ2fq4Px2
 pTibfIrtribouk+4pDEMJHJ5CyM5t8TreImcnMRNFWiWcDoDtbYExNBVzcSW6zNnPx7ASfYeZsK
 h4HmuyqwIXYoSu4ze2x9sgvP6Oj1z4Py2Hzvilfdk6OwZX1y2QicBpk7JEU4CRKRMizC/UMYxcA
 aTMkmqLBXnpshQ/0jg4a0HVqoU/3K/UwaCPGILDkWi3SOFC9e1dBsEppxQIABXjF4va6XAjzpfC
 nuzx8eMAacNnxUsLGrfnC45oRuydN5JovFg1X7mdBp2SDCKbJ+CTzOTynR5EFE4bOeey3O71B4z
 EL/j9zpIRgPVsHtCMfVQAeVWiblzqoJMSEEtTEJIjU91XXbi5VHkrOVm+xf8jKTZWMRrTu7fDz/
 Lopz8F+u7hgcaBoTDkCzh0IzEpcjbAgiMlmwxo2kUBH3LrZP499gHbe0BHahE2LrgU5wbwZaxSA
 h2OA
X-Received: by 2002:a05:600c:3494:b0:4a0:bc9:28c6 with SMTP id
 5b1f17b1804b1-4a18e4fb31emr225151755e9.34.1791880881754; 
 Tue, 13 Oct 2026 01:41:21 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.41.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:41:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 82/86] hw/intc/arm_gicv5: Handle vHPPIs when IRS_CR0.IRSEN is
 toggled
Date: Tue, 13 Oct 2026 09:39:29 +0100
Message-ID: <20261013083933.1024405-83-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

The IRS_CR0.IRSEN bit is somewhat misleadingly named: it is not so
much an "enable the IRS" bit, but instead an "enable having the IRS
forward HPPIs to the CPU" bit. If it's 0 then the IRS still does
all its usual activities, apart from telling the CPUs about
interrupt candidates.

This applies also to virtual interrupts. For physical interrupts,
we implemented this by not calculating the pending HPPI when IRSEN
is zero, but for virtual interrupts we can't do it that way, for
several reasons:
 * the vHPPI is visible to the guest via IRS_VPE_HPPIR
 * whether we should ring a doorbell interrupt depends on the
   vHPPI, and this still happens even when IRSEN is 0

So instead we need to check IRSEN in gicv5_get_hppi() and return
"no interrupt available" if it is 0. We also need to re-prod the
CPUs to ask the IRS about its HPPI candidates when IRSEN changes.

We could check IRSEN only inside the "is (virtual)" block of
gicv5_get_hppi(), but it's equivalent to do it unconditionally
(s->hppi[domain][cpuidx] will bo IRQ_NONE in that case), and
it's a bit clearer I think.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index a1fe6a8a822..4572e5a4017 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -340,6 +340,31 @@ static void irs_recall_hppis(GICv5 *s, GICv5Domain domain)
     }
 }
 
+static void irs_resend_vhppis(GICv5 *s, GICv5Domain domain)
+{
+    /*
+     * The IRS was enabled or disabled for this domain. In hardware
+     * this makes the IRS either forward or recall any pending vHPPI
+     * it had for a VPE resident on the CPU. For QEMU, we tell the CPU
+     * interface that it needs to ask the IRS about the status of
+     * virtual interrupts for any VPE that is currently resident
+     * (which will return either "none" or "here's the new one").
+     */
+    GICv5Common *cs = ARM_GICV5_COMMON(s);
+
+    if (!gicv5_domain_has_virt(cs, domain)) {
+        return;
+    }
+
+    for (int i = 0; i < cs->num_cpus; i++) {
+        VPE *vpe = s->res_vpe[i];
+
+        if (vpe && vpe->vmte->domain == domain) {
+            gicv5_forward_interrupt(cs->cpus[i], domain, true);
+        }
+    }
+}
+
 GICv5PendingIrq gicv5_get_hppi(GICv5Common *cs, GICv5Domain domain,
                                bool virtual, uint32_t cpuidx)
 {
@@ -347,6 +372,10 @@ GICv5PendingIrq gicv5_get_hppi(GICv5Common *cs, GICv5Domain domain,
 
     assert(cpuidx < cs->num_cpus);
 
+    if (!FIELD_EX32(cs->irs_cr0[domain], IRS_CR0, IRSEN)) {
+        return GICV5_PENDING_IRQ_NONE;
+    }
+
     if (virtual) {
         VPE *vpe = s->res_vpe[cpuidx];
 
@@ -2738,6 +2767,8 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
         } else {
             irs_recall_hppis(s, domain);
         }
+        /* IRSEN affects whether we should forward vHPPIs */
+        irs_resend_vhppis(s, domain);
         return true;
     case A_IRS_CR1:
         *data = cs->irs_cr1[domain];
-- 
2.43.0


