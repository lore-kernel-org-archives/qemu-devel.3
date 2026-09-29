Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FCFCA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUfg-00007q-Mx; Tue, 29 Sep 2026 06:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUfG-0007bF-6g
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:22 -0400
Received: from mail-wr2-x0e.google.com ([2a00:1450:4864:30::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUfE-0008FC-GV
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:21 -0400
Received: by mail-wr2-x0e.google.com with SMTP id
 ffacd0b85a97d-48884b0219bso1913939f8f.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 03:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790676139; x=1791280939; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tp6ApZKRaanh1GJe001NfVLaY9f/D/op+AumiPZOh+E=;
 b=QiYBP4kvmem3tL7V8lUzYmmcA23ZY61IyxM3zMC87kIyuVSd6qFuspKeCFw4LVOHmA
 B9xkVLJVoGXvRKjSMSvyiO0263CKynvd/26chxKHJaxCBnqDP08+o6GWsIhcBMMXgebe
 wKoltJbjdRe82QFJT6/LS1UkjdtyfNw49dFC856pqzVonIRVlJKD5h3v4OaN9q8jWbOw
 ZENiUf6pAJR0jXySKgyS9Y5zQccOcn3/1lLqh8tvdAd+kjBGsk77Ds/dMRYEF9EqLx8m
 xNmmYDTbYWkO+xPs2w4PjPOpjdaTyaAG+ddEcOip78ArH4yjWn3cIqwza8qWg35xO5ts
 KbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790676139; x=1791280939;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tp6ApZKRaanh1GJe001NfVLaY9f/D/op+AumiPZOh+E=;
 b=qA7fArWNAELDbCCcvg3Ge/gs8v59s7SiwQqn8jGIiSjOTOFecv4AlEBjwdcIPllf8f
 WqZqfzd+RUbJOZcKACtl4t/TH+t6P1HUcOPMEj1G09lNbLo9LshCR/3g/FHeclCqoth1
 giE85qxhAHY7jGJADEH3CQ5XIY6+c2ivneo3l81pHG38av/CB/oCll07dTVclL9bdeSK
 ogNMCMFWq/ZZlohCHupzX3bNOXFG77nMx68CwPmDqO/hzccsIt1Ol8vf9I5ongbPrgo2
 l36kX+Admfw0AZePpMpYjBAXs7bbIwY5znWNLbUlMT+TJg1hExdbmCXDdNrwj3VMgawk
 x7hg==
X-Gm-Message-State: AFq9FYKuXyNrYNrrim+JVf/GwizQD1/H959s6lqvKA9XbYunUMxWNzry
 miMafxJWbE78LOS+vsz0taafP/FtD/XQfK0jqny4mt/DRUnI9lZkbGkCsUs2jLdcjp1rPg9a7En
 HIxFE
X-Gm-Gg: AYBFou2ZqV3NfM52msSqOqfXqLCLH3COMrA5PEi8rYgDCHdIraLOeU5Wec5pG/eN3hV
 6Ra82QlsVig3DP2kxGg1dMv/Av4IBoSX/4L+z7DocVy9eJfC6kQfe6cgp2pAdwz+1y+Oh5VfS1O
 TuwNEH5YKkorcVm4DRFYa03kK5+YTrz1G7fceipoIKmIK2k1FmWIr8wOX57w8Wbr4Yr/hu5FWkw
 MlTi9bSc/Cq+U3ICXv9vhctKw39RvJMjZusokAlbwDixSvER7EMKiiIBKCOVVAoGtBFFVfn65pL
 FKcJA5C/gKU4uMqOdQD1CjaWsRKztmOsU8agv9E86F9kOhJu7ViUozR7egko/FYy7GHu34SjBG7
 mgcGSjhg5PZCgUrVbLJsIyGgKQwya9MSwdOSf5YfYiVzzh+c7wUNo5OGhYsx58pLmqEQcaDzUBg
 dy9qXwDCjEqscwS5HV76J4gHRxyXxpEyk63jDFkqmeD5+k69r587GNOI8xloGbgmezAygzqmrez
 s7lMQ84NC0awHybaeWGVhZEvd5N/FvgVGcDBZsAjrwJ3ui49Glq4QCnYZm3Fv4F0FU7V0VU1zVO
 XjM=
X-Received: by 2002:a05:6000:4a04:b0:487:aa6:c90d with SMTP id
 ffacd0b85a97d-4887d9fa6e6mr21541734f8f.1.1790676138966; 
 Tue, 29 Sep 2026 03:02:18 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af4f88b37sm3091412f8f.5.2026.09.29.03.02.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 03:02:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/37] target/arm: Drop U from most PSTATE bits
Date: Tue, 29 Sep 2026 11:01:23 +0100
Message-ID: <20260929100133.2598676-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929100133.2598676-1-peter.maydell@linaro.org>
References: <20260929100133.2598676-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

PSTATE is already 64-bit, but many bits are defined
such that ~PSTATE_FOO accidentally clears the high bits.

Except for PSTATE_N, we can just drop the qualifier.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260925215004.456336-8-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 4785c9c57af..141cfdf6a88 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1582,26 +1582,26 @@ void pmu_init(ARMCPU *cpu);
  * Only these are valid when in AArch64 mode; in
  * AArch32 mode SPSRs are basically CPSR-format.
  */
-#define PSTATE_SP (1U)
-#define PSTATE_M (0xFU)
-#define PSTATE_nRW (1U << 4)
-#define PSTATE_F (1U << 6)
-#define PSTATE_I (1U << 7)
-#define PSTATE_A (1U << 8)
-#define PSTATE_D (1U << 9)
-#define PSTATE_BTYPE (3U << 10)
-#define PSTATE_SSBS (1U << 12)
-#define PSTATE_ALLINT (1U << 13)
-#define PSTATE_IL (1U << 20)
-#define PSTATE_SS (1U << 21)
-#define PSTATE_PAN (1U << 22)
-#define PSTATE_UAO (1U << 23)
-#define PSTATE_DIT (1U << 24)
-#define PSTATE_TCO (1U << 25)
-#define PSTATE_V (1U << 28)
-#define PSTATE_C (1U << 29)
-#define PSTATE_Z (1U << 30)
-#define PSTATE_N (1U << 31)
+#define PSTATE_SP (1)
+#define PSTATE_M (0xF)
+#define PSTATE_nRW (1 << 4)
+#define PSTATE_F (1 << 6)
+#define PSTATE_I (1 << 7)
+#define PSTATE_A (1 << 8)
+#define PSTATE_D (1 << 9)
+#define PSTATE_BTYPE (3 << 10)
+#define PSTATE_SSBS (1 << 12)
+#define PSTATE_ALLINT (1 << 13)
+#define PSTATE_IL (1 << 20)
+#define PSTATE_SS (1 << 21)
+#define PSTATE_PAN (1 << 22)
+#define PSTATE_UAO (1 << 23)
+#define PSTATE_DIT (1 << 24)
+#define PSTATE_TCO (1 << 25)
+#define PSTATE_V (1 << 28)
+#define PSTATE_C (1 << 29)
+#define PSTATE_Z (1 << 30)
+#define PSTATE_N (1ULL << 31)
 #define PSTATE_EXLOCK (1ULL << 34)
 #define PSTATE_NZCV (PSTATE_N | PSTATE_Z | PSTATE_C | PSTATE_V)
 #define PSTATE_DAIF (PSTATE_D | PSTATE_A | PSTATE_I | PSTATE_F)
-- 
2.43.0


