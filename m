Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4054CC28B30
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 13:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt4uI-0005CH-Cc; Fri, 14 Mar 2025 09:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt4uB-00058U-NS
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:16:52 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt4u9-00015N-Mr
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:16:51 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cf628cb14so20110265e9.1
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 06:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741958208; x=1742563008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UHA95dpymGqv9/OSGqYWddDTp72SBRI3UEcR8U6Ysio=;
 b=mkp7yCX2o5NM3C/iM0Z1Ds0Pu0fsQgfYxUvx7GtlL3pcn7+GljkJVo8C+DCkFc6lP4
 g6S+Ralx0paF8ZYcdX1KIzLTzQS78pE3xKmjVhnvSj/S2kfxjE1JZN9aR5wbJ5ZVoHcY
 U13B70J58cvD9BvCPLXH1feNcWrrdQNLr67gFqniVocrlA3eGKHo63GH1BaepSQV0Vjo
 maVvBsoloqUesQtgJyQJGqUWB1fGO4PLfBbtDamfmnAOLJFgCTmFz2YCjCz8I5V+/5WE
 pk0aL1u9OMTxQ2RMKXhi37SdC9YBS7uIeIrdZUoto7Imp7gy2l54cQVzuqegJkcrUUNv
 uPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741958208; x=1742563008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UHA95dpymGqv9/OSGqYWddDTp72SBRI3UEcR8U6Ysio=;
 b=ojqGHZgp3Df8Lf07zuJhQ0zuzG62CoTdE+uK8FhGUUCVzwp8nzA7fpyIz58TgbMP3G
 r3Oe/nTuvuPzGGXmMjKnvBGjoRLyoPp+/9OOse72E2BN0DNUBziKY2S6t/s+QPS97k9k
 0T3mIBjVeEDkU3Pcl7kqPPYDumUM/mwNkzvJx35dFERU8rAdIa4qFrLD110HSjc4Gk/B
 Tr9+ZZCETUYSbS5OJ3kUryZgkp3NF+N6A/57vgPazt1rF2sn8axRHvUaHRM2Oeh8+jpc
 8jBHlS5Q7TTBlhqoXwoDuIEOWnatgaY0ni9WbWmvK2YaXILMIjSyEPBw23n1vzySsuks
 bG4A==
X-Gm-Message-State: AOJu0YwH0CIu5enn3UwbF6EPl7ZXn2YJrwsbknNHhGMfmrqep9qbx00y
 Y80hoQPMZtn3+/1eiMPeYtO/a43KhDpxzGndt8oFI7tqQVIriDl6CBc6cGPxVyNGcKjvB0WTcGw
 x
X-Gm-Gg: ASbGncu6GLYB9JJRDOUksyNIE7lSQiOg0WOhc+V19ctzmq9ngSIJ06PCHNdMgtu4aI9
 uEXmlHVc1rTH7vcGBGjIdWFMwOA+GiOwlzYvOyoXJ1nWHPqb0GhZfCGbcDi7lhmRhwZNXNxA4QI
 rskjjpQTsWFh/LkJ0fksoh4C3tC5uMJTLEzPZ33i+ToPrrNTsA4j2Xp3TJbHv1oEDCeCxa8bs8l
 DnP9wL4dMBsn2gi/3YjTsxoEaz+uC2kbbFiYhx2SIjOSU816gVWKesrk1JwJROVzwsqmx88txpz
 ZcS4t6HubodItfi46gGxIQ9nEDrBUrsMaLzn+hzj5UcVgVhZ3C4=
X-Google-Smtp-Source: AGHT+IFp21aCGEDMzcZNgMKWtPY8jGffIj7BvPsq338BLgYlnCyyAQxIIMw/6mg9HALrCzDPAAMAUw==
X-Received: by 2002:adf:a387:0:b0:38f:3224:65e5 with SMTP id
 ffacd0b85a97d-3971c3ad3cbmr2630987f8f.12.1741958207778; 
 Fri, 14 Mar 2025 06:16:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7eb93csm5437923f8f.86.2025.03.14.06.16.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 06:16:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/17] target/arm: HCR_EL2.RW should be RAO/WI if EL1 doesn't
 support AArch32
Date: Fri, 14 Mar 2025 13:16:28 +0000
Message-ID: <20250314131637.371866-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314131637.371866-1-peter.maydell@linaro.org>
References: <20250314131637.371866-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

When EL1 doesn't support AArch32, the HCR_EL2.RW bit is supposed to
be RAO/WI. Enforce the RAO/WI behaviour.

Note that we handle "reset value should honour RES1 bits" in the same
way that SCR_EL3 does, via a reset function.

We do already have some CPU types which don't implement AArch32
above EL0, so this is technically a bug; it doesn't seem worth
backporting to stable because no sensible guest code will be
deliberately attempting to set the RW bit to a value corresponding
to an unimplemented execution state and then checking that we
did the right thing.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3df7d5347cb..bb445e30cd1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5326,6 +5326,11 @@ static void do_hcr_write(CPUARMState *env, uint64_t value, uint64_t valid_mask)
     /* Clear RES0 bits.  */
     value &= valid_mask;
 
+    /* RW is RAO/WI if EL1 is AArch64 only */
+    if (!cpu_isar_feature(aa64_aa32_el1, cpu)) {
+        value |= HCR_RW;
+    }
+
     /*
      * These bits change the MMU setup:
      * HCR_VM enables stage 2 translation
@@ -5383,6 +5388,12 @@ static void hcr_writelow(CPUARMState *env, const ARMCPRegInfo *ri,
     do_hcr_write(env, value, MAKE_64BIT_MASK(32, 32));
 }
 
+static void hcr_reset(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    /* hcr_write will set the RES1 bits on an AArch64-only CPU */
+    hcr_write(env, ri, 0);
+}
+
 /*
  * Return the effective value of HCR_EL2, at the given security state.
  * Bits that are not included here:
@@ -5618,6 +5629,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
       .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 0,
       .access = PL2_RW, .fieldoffset = offsetof(CPUARMState, cp15.hcr_el2),
       .nv2_redirect_offset = 0x78,
+      .resetfn = hcr_reset,
       .writefn = hcr_write, .raw_writefn = raw_write },
     { .name = "HCR", .state = ARM_CP_STATE_AA32,
       .type = ARM_CP_ALIAS | ARM_CP_IO,
-- 
2.43.0


