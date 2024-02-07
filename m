Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45701C48297
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 02:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXY3O-0003LN-BU; Tue, 06 Feb 2024 21:52:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXY3N-0003L1-8R
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 21:52:49 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXY3H-0000iG-JD
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 21:52:49 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d731314e67so1467025ad.1
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 18:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707274362; x=1707879162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EwSkPSHiupn05u+RAeWRJRNLnJ0SRDTtyOincwirVhY=;
 b=DetoBs8CegDJzKFU3S775vQUiF8ehTIKfeHtS8JBOdpGcRSyzvTsmeAZcH/s4t6yA5
 1U8RYkfjJnZov1+RW0DQKQ9OjW4fCaplcIMDxbxR0vBK7fyoyFNO0MBk3WSZt8zhkTvr
 fB6YowJfe80IMJ7qgh1KSILUdRPce3N3Hd8chB4WyoSP12lKMtrMVy+EPPyosrO6mES+
 eagMF0lnuRvPX+UjUkJ2PYnfIxEtXf3xB6hJbbageDTT6HEMN9G/NxOgL8avSMJJsZ+E
 ytsIv6iiCHKzDImFNQ92yWWA5doy8m0kwSmjJWcJaFxzRNX6U+h/UJeBd4V+MhCRJVd/
 eIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707274362; x=1707879162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EwSkPSHiupn05u+RAeWRJRNLnJ0SRDTtyOincwirVhY=;
 b=GIGtlzHbS6D5J44xc2cIwEQLVOVv/x/q+6DEQGhS7copbG57Q6FMHwHZneUa+CYkpT
 Oh4p9Zr973ipjfXxNSMaBE8FZKcOMKdxCBDdPJTkMrXB4bYAAunl4TN1oOvn6YdCXZOs
 22FkGnHzGarBv38abJg0yTsAoxloi2LmqtXbNsBO6XLUT4T4b3dYd3NIb60VBfAXPh1B
 xfIgCkJZgqcLF9pSWoiYUkqU3tsu+3MShTmtRNqrEguUqPN+xbdIfRjWPnCs2+kmNaSf
 2zf4gkia1z5YHKwUjs6Vp2mm7bl18bX7HZ5Vj/98MnH79gEuWFaOElihLLh3Zbf4S6KL
 qcQw==
X-Gm-Message-State: AOJu0Ywi31dftBZaeepsmAdeR+dwkt08Q66RRVTd9gxiB7PBzrQUCTe9
 SeRmCbaOEJg3eQUloOy1RIkzy1H6oW+585err6b3p1OUZYLRP+zexqOcoVqeO0vk7SyZYYkKyeE
 YTQ4=
X-Google-Smtp-Source: AGHT+IHiwJuWhkDHCHm6UDdWmrOa8/za0Hk4Ynw7ntX1eu1DWxai4qNS7A+XH0MUbuvtePoARr9Gfg==
X-Received: by 2002:a17:903:442:b0:1d9:624e:126d with SMTP id
 iw2-20020a170903044200b001d9624e126dmr3298272plb.62.1707274362305; 
 Tue, 06 Feb 2024 18:52:42 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVdM8CBAqet6sXU+v4XakJHPz2Xo7DnrAF6LFex+GVd1xuy/EAvBj995Jarghp1JVDN8kwpq1tBOyWW2x6v4oSzZ8JhR27Jx5AVbEFGZ/Zs/SFLoTWR44zvfkb+aaEL7fHCZkOIFPE8mQ0SatPHswFQgoj8JiRWQvUWIN4=
Received: from stoup.. (60-242-98-186.static.tpgi.com.au. [60.242.98.186])
 by smtp.gmail.com with ESMTPSA id
 kr8-20020a170903080800b001d8ef97de4asm255435plb.38.2024.02.06.18.52.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 18:52:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, gustavo.romero@linaro.org, qemu-stable@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 6/6] target/arm: Fix SVE/SME gross MTE suppression checks
Date: Wed,  7 Feb 2024 12:52:10 +1000
Message-Id: <20240207025210.8837-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240207025210.8837-1-richard.henderson@linaro.org>
References: <20240207025210.8837-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The TBI and TCMA bits are located within mtedesc, not desc.

Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sme_helper.c |  8 ++++----
 target/arm/tcg/sve_helper.c | 12 ++++++------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 1ee2690ceb..904bfdac43 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -573,8 +573,8 @@ void sme_ld1_mte(CPUARMState *env, void *za, uint64_t *vg,
     desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
 
     /* Perform gross MTE suppression early. */
-    if (!tbi_check(desc, bit55) ||
-        tcma_check(desc, bit55, allocation_tag_from_addr(addr))) {
+    if (!tbi_check(mtedesc, bit55) ||
+        tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
         mtedesc = 0;
     }
 
@@ -750,8 +750,8 @@ void sme_st1_mte(CPUARMState *env, void *za, uint64_t *vg, target_ulong addr,
     desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
 
     /* Perform gross MTE suppression early. */
-    if (!tbi_check(desc, bit55) ||
-        tcma_check(desc, bit55, allocation_tag_from_addr(addr))) {
+    if (!tbi_check(mtedesc, bit55) ||
+        tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
         mtedesc = 0;
     }
 
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index bce4295d28..6853f58c19 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -5800,8 +5800,8 @@ void sve_ldN_r_mte(CPUARMState *env, uint64_t *vg, target_ulong addr,
     desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
 
     /* Perform gross MTE suppression early. */
-    if (!tbi_check(desc, bit55) ||
-        tcma_check(desc, bit55, allocation_tag_from_addr(addr))) {
+    if (!tbi_check(mtedesc, bit55) ||
+        tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
         mtedesc = 0;
     }
 
@@ -6156,8 +6156,8 @@ void sve_ldnfff1_r_mte(CPUARMState *env, void *vg, target_ulong addr,
     desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
 
     /* Perform gross MTE suppression early. */
-    if (!tbi_check(desc, bit55) ||
-        tcma_check(desc, bit55, allocation_tag_from_addr(addr))) {
+    if (!tbi_check(mtedesc, bit55) ||
+        tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
         mtedesc = 0;
     }
 
@@ -6410,8 +6410,8 @@ void sve_stN_r_mte(CPUARMState *env, uint64_t *vg, target_ulong addr,
     desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
 
     /* Perform gross MTE suppression early. */
-    if (!tbi_check(desc, bit55) ||
-        tcma_check(desc, bit55, allocation_tag_from_addr(addr))) {
+    if (!tbi_check(mtedesc, bit55) ||
+        tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
         mtedesc = 0;
     }
 
-- 
2.34.1


