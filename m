Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD50CA6017
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 07:10:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFRDY-0001eJ-Sd; Sat, 10 Oct 2026 03:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xFRDT-0001bi-L9
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 03:10:00 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xFRDS-0001BD-0p
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 03:09:59 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48b001cd92bso255475f8f.2
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2026 00:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791616196; x=1792220996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YvCmWBNKpCw559LBK1/4u4TqFg6AtOQbb6mofL8w7lc=;
 b=GaAAqXI9g7qxHr81qOEM4cY0gbLgnpljpyLZ/eHctrzPR6r9mWjp3WiGL9SHB9R05N
 NV/HsqAGHuBiuqovNjzs+gwnGwpTrI+/N0a809FrwENvZ7GgktL68HEfhZFkNaZxlOtF
 Fo4qURLq4/HRlZLkLMs3+LtE4IDp2Ow902ni3lMCTRbnaLJVuVqIPBEEu7Pqg0GBFCjP
 EGXw4CJC/J6ayvqeUAsVu/YVy7QEAB+I4lnGAtY8dw2wsloJI1uwN7npZ17MFBebbMLf
 aBK5cpgkPnOfFzOZ+0eiM5UAEg+CfLhd8P+rNoPPctEBm4JO4eYHWIF62fDXu3Xx3y6l
 9Whg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791616196; x=1792220996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YvCmWBNKpCw559LBK1/4u4TqFg6AtOQbb6mofL8w7lc=;
 b=0f4/qQT/2Z7kOPjCTWWG7JzikE3LBsfK54/HJw3/B+EH8VCvegO4Ntf/Yt0Z96ovwY
 ya+ZtQGR/ghvrgQ13C2TqKtg9xrE98aF52ZuNzqtkfh/gxvNkdJMmg68j5uortC84HU5
 QrjyA/ZK+c7+4SkKGJyWmNngtsLmjpKrzW44Jrf/Uc9jA/TGMTSarAbQmG7giUb8ztpN
 2AEpbVrvK9NQZyicgQc4GHarFPThY99oFuSp1Wo5WIXCl30AU0d1GiJbfp8ZVC4rlP8I
 lmKoLpGtstf/dlrVXUs5D71OFJezoa66IJW1Vmf28RVOCi66aFqsW+eyNePXkmW6qk28
 oW/Q==
X-Gm-Message-State: AFq9FYIy/HN4SbuDwTprXF/oMYtcx1v+Qrz7CaNibn7jhpNIXzUHgUSJ
 HNqicntmuow60AuXOBUSLPr9CG/csHL6frut98zkvq/54k4zbLOpNilIOMeHLEDON10lVQ1ns/d
 ybDUj8Kw=
X-Gm-Gg: AYBFou0V9vSxGD02HwM93LN6lm6V8ddrwOOvKQO/FJkAkmAO8va2rAhFgJ8DrlaQl97
 ELQpRTVcoTFOkaYh5qZXP5AvPeoK9BdHciFq5eAn2ooqh3O+vDvj9Yd0rK5rWKshaB9q8LOEg76
 ZSMPzwiaMvhiFCLCQpv2Buf55sQNucPcIalfdeFr5o6UMbIWIXunP0MHZrcf8BQbIQZDrIZZQiB
 TFwfdEgB3je0pNsxEQJ/qXMzH65Pap3E2wa/wHnWAwVNGbmMrutV1+1PIC5mC4/hjteUGiBNacw
 RLmAGykmp7+9CXN5aB+hoCQlve0j2kmtPqssNz5V/tbJHhZH/hndW4FmnrEgRgyMbwjCZUeQ7si
 nNnPcalQ9DqlC984e50vovpGHDodVaYKphsrzRpHVsEyKTOpT5MsumAQ8jt7wtsLoHYHRlEe5R/
 ztBSuMrdXzPIsEXM2VG8v2WiPnrwRUlCca0BQ85sQV1I330zb0c72NiqCO/3PnzHL++vGnIIb/P
 dsa/9xY8LQ=
X-Received: by 2002:a05:6000:25c1:b0:48b:9d2:1a6a with SMTP id
 ffacd0b85a97d-48dba78a613mr7180094f8f.1.1791616196304; 
 Sat, 10 Oct 2026 00:09:56 -0700 (PDT)
Received: from stoup.local ([2a00:1e:e082:2901:a2d3:66fa:95e6:7d81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9abda3csm7662252f8f.36.2026.10.10.00.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 00:09:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v4 2/6] target/arm: Enable writes to SCR_EL3.TID{3,5}
Date: Sat, 10 Oct 2026 09:09:48 +0200
Message-ID: <20261010070952.323466-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261010070952.323466-1-richard.henderson@linaro.org>
References: <20261010070952.323466-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x436.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h | 5 +++++
 target/arm/cpu.h          | 2 ++
 target/arm/helper.c       | 3 +++
 3 files changed, 10 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 2fc1bf02cbe..96ec12f64f4 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1408,6 +1408,11 @@ static inline bool isar_feature_aa64_idst(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64MMFR2, IDS) != 0;
 }
 
+static inline bool isar_feature_aa64_idte3(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR2, IDS) >= 2;
+}
+
 static inline bool isar_feature_aa64_half_evt(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64MMFR2, EVT) >= 1;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 06ebed4a8fd..a0355ba9e1a 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1811,6 +1811,8 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define SCR_EASE              (1ULL << 19)
 #define SCR_NMEA              (1ULL << 20)
 #define SCR_FIEN              (1ULL << 21)
+#define SCR_TID3              (1ULL << 22)
+#define SCR_TID5              (1ULL << 23)
 #define SCR_ENSCXT            (1ULL << 25)
 #define SCR_ATA               (1ULL << 26)
 #define SCR_FGTEN             (1ULL << 27)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index ff0b766b73d..187d0e9213d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -960,6 +960,9 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         if (cpu_isar_feature(aa64_rng_trap, cpu)) {
             valid_mask |= SCR_TRNDR;
         }
+        if (cpu_isar_feature(aa64_idte3, cpu)) {
+            valid_mask |= SCR_TID5 | SCR_TID3;
+        }
     } else {
         valid_mask &= ~(SCR_RW | SCR_ST);
         if (cpu_isar_feature(aa32_ras, cpu)) {
-- 
2.53.0


