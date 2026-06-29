Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F449C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:06:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAgJ-0007Mr-Bk; Mon, 29 Jun 2026 08:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfi-0006w6-3e
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:07 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfc-0007Py-Ic
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:03 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-47362928f65so860022f8f.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734458; x=1783339258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7nxrNrYCopcurGkkgdYz5xeXgIeGKYV3dyMssD6Ea1k=;
 b=JyCMYcKQItAzcpdILpTTgPqDdmaIigsugmU5NULG4u121w2vzpxtDBrdNX8To8/Zh3
 Ap11zMKY3Y/Icxpi0Scr1IHRvVAvLAfaXueBCqmXaRkC0kDdZwD4NaDYBlaH2HtBQ+ZO
 qf3TVPY0ZmVCB0wSsln1KIhxT6fv9rq6G5vMXGBZsHBzu6B/6rV2HhlDEoxSVUuxLgPB
 TMpu73nzrH4AO2avWvkgbqJubxd7u399p2Soy2sOpX7CsYw92H28o3H52Y8oDEBCb6Hm
 CJUIg9KZ1IbsFbuT1JfySmEKSDnClEg586PKfccjSA0EWwyljls9oDNh2R1lGIZrOcS1
 VIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734458; x=1783339258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7nxrNrYCopcurGkkgdYz5xeXgIeGKYV3dyMssD6Ea1k=;
 b=Xd8BbCpDVDhHDbXtEQnFeEidPPV3MJbHsOsMklNFAJCUA/hAYKvoOZs/SDpd5KzXP8
 N8Y84qLF97L3QGENa2UsXttZkS8DuolJERI7mwVLvf4GGAzWkSfj0hdlOb6dsR/RvFfA
 ywoO0BG5nDh1ArX5vFpTs1km7LAIGpCJjOl/kEQy9hMQNaXWYLYEp82fsYZgLAO7hx+p
 /J3snM+iNFFWdck9rajC2HQeMddxt5dp8/DfoF/Ol3f324ZRR9FDyyZLRlbNm20ytNc9
 4WHSQihmsnZg6f8t6PZ2216pbu3q1UcZhMAlpkwpFYLjCP4XgeoRDtA11i30c/0ltxuc
 ccmg==
X-Gm-Message-State: AOJu0YzSKzKWppXtX85J9M2eB9bqIFvh6YzxyCKWsnpZB0XZMUxE2yG8
 atrYYMXv3EoqZqhtVJn7wceHFCgwfzBWAQVKWnGU06AeFgKE5qI9Bs70q9qEaRDJiQwbPDYokUs
 HWrcY
X-Gm-Gg: AfdE7cmGLx3avMkPOb1aTyqsWbzJCwSXP7fczUKhv37wVGFOCMLEbBQiAqGQDGaL8iT
 JWphO6M6hcrBnVLWGMqVB8mHBxw8o2ggmPupwbkPveZUuKuT3oqogFygQVoLTLZwrEhM3EvAqkj
 RkCU6p7ShPvPUlmVj2DitlHUDxaS+hwhBeliwF7Ym17rdGw+4QdY31KP4nHBgvL+8GEBMwssyUe
 Rq7R1/ymAho+tocMw3oV44gbtjiWvVX4RoN9msRNLETCqe6Im596DfkQlOvzUm2cYb9DZOHi0z+
 a8y3NAalcp7+AD16WQaOr+B7yQ1X9kVst0p8cshg1BLbldK2WSv0isiZ2D/kxOQ0GzjCjxdhZrL
 jiBGlid7dJmkxUKYWi0UQwMRzsCvezm9GPVf4k4+YvbEPQRUNeg5drrhhQ3e96oexnghKIXWHhI
 UcuGGstybh8nbsmenKjC8iF2BxCWlZH6m5+4NTsKGck2QSRtjUqGFqSdfOAbMMcPASkO+CST3Px
 crvLdOg5955FXI/XI6dWo8xDXdowj1g
X-Received: by 2002:a05:6000:2487:b0:474:6301:3e3d with SMTP id
 ffacd0b85a97d-474ff09be36mr258798f8f.11.1782734458213; 
 Mon, 29 Jun 2026 05:00:58 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.00.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:00:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/54] target/arm: GICv5 cpuif: Remove ICC_HAPR_EL1
Date: Mon, 29 Jun 2026 13:00:01 +0100
Message-ID: <20260629120032.1645265-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

The ICC_HAPR_EL1 register reported the current running priority of
the CPU. However this can be easily calculated by reading the
APR register, so it has been removed in the newly released A.a
version of the GICv5 spec (IHI 111701).

Remove QEMU's implementation of this register. (This is OK for
us to do without warning because our GICv5 support is listed
as "experimental"; we anticipated that this kind of spec change
might happen.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260615105029.2898872-5-peter.maydell@linaro.org
---
 target/arm/tcg/gicv5-cpuif.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 1aa4bde799..a868adca66 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -511,15 +511,6 @@ static void gic_icc_apr_el1_reset(CPUARMState *env, const ARMCPRegInfo *ri)
     }
 }
 
-static uint64_t gic_icc_hapr_el1_read(CPUARMState *env, const ARMCPRegInfo *ri)
-{
-    /*
-     * ICC_HAPR_EL1 reports the current running priority, which can be
-     * calculated from the APR register.
-     */
-    return gic_running_prio(env, gicv5_current_phys_domain(env));
-}
-
 /* ICC_CR0_EL1 is also banked */
 static uint64_t gic_icc_cr0_el1_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
@@ -928,11 +919,6 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .writefn = gic_icc_pcr_el1_write,
         .resetfn = gic_icc_pcr_el1_reset,
     },
-    {   .name = "ICC_HAPR_EL1", .state = ARM_CP_STATE_AA64,
-        .opc0 = 3, .opc1 = 1, .crn = 12, .crm = 0, .opc2 = 3,
-        .access = PL1_R, .type = ARM_CP_IO | ARM_CP_NO_RAW,
-        .readfn = gic_icc_hapr_el1_read, .raw_writefn = arm_cp_write_ignore,
-    },
 };
 
 void define_gicv5_cpuif_regs(ARMCPU *cpu)
-- 
2.43.0


