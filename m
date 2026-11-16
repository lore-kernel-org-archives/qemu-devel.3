Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F23606FE9B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=t6ZgohL/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSufQ-0004IE-SE; Mon, 16 Nov 2026 06:14:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueE-0003ot-JP
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:19 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueB-00027n-Kj
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:18 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48e09aa5264so1530186f8f.2
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 03:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794827589; x=1795432389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nZ4tCCJcAOPP39YCI9vL7fD1+Nt2oG42ItWO83osFLo=;
 b=t6ZgohL/7Wj04leYUOMpBNfzU2cLrhX88418TAx7DNqNxFmkspFUxWbR39AohZ7u+c
 c6i6/CK/VthsRQaYPeAhtPUh6YKeqIx3ARAR8wpMnxTIKtAQS9svf7EdsEWYjun1C0Ax
 yBBDnL+mtKkl9dLNqHPTQ7IkSHd+28HK9RZTZ8rYgF9dCIq2JKROMeevpfPwHlybML+p
 Z9/YcqxWvcmpVI9ZPaLBOFtEsKONoVlZi51nS1ruTsKtvpryjL2lZtV2ibOsno+9KOFG
 vu5fBexGteQYu+LNgf9aHc66ybtjnEs7xoIx/0UinBbMML5l5l4oOqTRFITQ4Ortbs6R
 Srug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794827589; x=1795432389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nZ4tCCJcAOPP39YCI9vL7fD1+Nt2oG42ItWO83osFLo=;
 b=ecWeJNEpXKpWk+5hDVY2cS+hQ+EmJyETgEvsDnerJwQin2Z9bYIrBvwOfPf4ueNFHY
 04HOvQtu8otQkOu/MXOcRcjePrPNcnf5npPmkBTRPsZ2dEVbz1ltaCynX8lGMLf/HeDk
 iPQtoDGCCewIZE2NfeK7Nyy5HnnZ2FXho9moN+wVqYRYU0ttrWXRAalMPjo8nn8HpDDH
 wasu5H/6vj8TEXLS8I0RGbDwPOuVyP5XOmx+JsJRf/1RNKwehwESAqMYE2MuKQ1HhlaL
 i15lV8pcjORE5nE0zP2zyJq7we3uqwH0af0KF85YkIhGCgfPTnHvZq18uug7G43m2EIE
 hqew==
X-Gm-Message-State: APuU4Z9AQdh6RwszIPUmtyrFwSNlGz40/1cgz+o78RS2Q+gQfga+u6Hw
 DCz3kmaS/HUgpF5+JrawcEHEwEOf4XYRGNBusB7czpkfMG0w0wkCKnSiVJA4Ml9FYqErOL3FrjM
 gSncD4i4=
X-Gm-Gg: AZFdTZfkJsalrixREtuDXuyaObU8MoD3IFL2NUyl9gWaBtlIbJ7+jDKCLZ7i5JsPsFX
 vqBDkPbcclNJzaccB4dU7CYOUFuwE0rG8v0zEtRE7fo1OeYZcZovo4Zr755bS86ecIZfzbNMtuO
 nEsVoWc4Q8LZMThIHi1f8CksHwr0KDvoFHkfdkuxwVY7oUJucWxzbgzzj5HfN+hcGCTVeF4EDmL
 LX0vq3ZoF4cHHz5eJZZ6+UtC885CypXH3snK8QZ7CmOE36m2PF/u7pgE712i85aCvL+YWUAoA9C
 VF2kMJVYH4lQudkv1ixjMprZ3yHVczEqGNJ4sK9yZUUgkcRPAM2Cs8RSr6wEbYZa7HZWwpOKwM8
 1f+AiCKKOR34WCrIDvJL9w2iGVnTCGFDTzh9IHcHg+t+ropUfy86pl7d2POKV1+n/BV9yDlx+Rk
 6IPidHncKj/zgp6++JgAzV1BTzKLUUQLdHhpzFjjAftk4kHZpHvgut+jRXz65NLZvBPPVqYdhyS
 VGC3OapiKAwnK7ee7aMYQwMOu7lANk490qaZeTJrbaYcQccC/2Lpxq5Xie08ovcwsG5/tMhv0Hg
 6/qYyDbvHzKKEcXHVoSt1wQe071rn0iyFViGy8uSbM7tCCvdVqoXWgcjb+iUGJsMcwJ5umKqfEd
 pFfbJ5u6f6pconKN1wyGu/8Zx1fRWrf9rgA==
X-Received: by 2002:a05:6000:26c8:b0:491:8462:20cc with SMTP id
 ffacd0b85a97d-49c73ce5e65mr23453273f8f.37.1794827588680; 
 Mon, 16 Nov 2026 03:13:08 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c6d079a2asm19490469f8f.16.2026.11.16.03.13.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:13:07 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/33] hw/intc/arm_gicv5: Use cached IRS_IST_BASER.VALID state
Date: Mon, 16 Nov 2026 11:12:33 +0000
Message-ID: <20261116111303.1692832-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116111303.1692832-1-peter.maydell@linaro.org>
References: <20261116111303.1692832-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When the guest writes to IRS_IST_BASER we effectively cache the value
of the VALID bit in the GICv5ISTConfig valid field entry.  In a few
places we check whether the IST is valid by doing a bit extract on
the register value; switch those to look at cfg->structure instead.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
Message-id: 20261103172616.2400758-2-peter.maydell@linaro.org
---
 hw/intc/arm_gicv5.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 5d0a50ab6aa..d0a8574916b 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -1222,8 +1222,7 @@ static void irs_map_l2_istr_write(GICv5 *s, GICv5Domain domain, uint64_t value)
     uint64_t l1_iste;
     MemTxResult res;
 
-    if (!FIELD_EX64(cs->irs_ist_baser[domain], IRS_IST_BASER, VALID) ||
-        !cfg->structure) {
+    if (!cfg->valid || !cfg->structure) {
         /* WI if no IST set up or it is not 2-level */
         return;
     }
@@ -1293,7 +1292,7 @@ static void irs_ist_baser_write(GICv5 *s, GICv5Domain domain, uint64_t value)
 {
     GICv5Common *cs = ARM_GICV5_COMMON(s);
 
-    if (FIELD_EX64(cs->irs_ist_baser[domain], IRS_IST_BASER, VALID)) {
+    if (s->phys_lpi_config[domain].valid) {
         /* If VALID is set, ADDR is RO and we can only update VALID */
         bool valid = FIELD_EX64(value, IRS_IST_BASER, VALID);
         if (valid) {
@@ -1604,7 +1603,7 @@ static bool config_writel(GICv5 *s, GICv5Domain domain, hwaddr offset,
                             deposit64(cs->irs_ist_baser[domain], 32, 32, data));
         return true;
     case A_IRS_IST_CFGR:
-        if (FIELD_EX64(cs->irs_ist_baser[domain], IRS_IST_BASER, VALID)) {
+        if (s->phys_lpi_config[domain].valid) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "guest tried to write IRS_IST_CFGR for %s config frame "
                           "while IST_BASER.VALID set\n", domain_name[domain]);
-- 
2.43.0


