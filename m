Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D3FC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 16:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scS7B-0004VE-3p; Fri, 09 Aug 2024 12:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1scS6p-0004JE-9L
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 12:04:56 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1scS6e-0005wM-HQ
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 12:04:51 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42803bbf842so21454455e9.1
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 09:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723219477; x=1723824277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ICJBhRzXeSHxiQ/p/CxRsyTFTBxBWWvxj76zvD9iTsA=;
 b=b5Abe9i1vt616+EgPJfr4bTfwx8KG3TRTHTadQp6ljSdXsis+pPhd1Fe6kJ/sEzQIP
 QUT0EXsvuh99U7+S/kQT6gBdsXrRIc37jKRMQPlqToBB+hmQLRcvb5eH1RLbkdYqD7TO
 0861UWTULG64oy8KBGI1jHByUqmi3J0Ku+iAphQuUrU3ZOctcbWhiATw0jtQqWvc7AXE
 5RgYiikbnc+oKG3lMaF8FxvuyMXbhx8iOnWfhloaCxRdq3qcMB+Dht6jS6IVOmwDAE85
 lu1if1B8vB6JzKr3uz8Ym45QZGL7p0nVgiWTpT6ZzLtvzYA7G6lwJ0RfN24GYuPrZdgf
 htwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723219477; x=1723824277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ICJBhRzXeSHxiQ/p/CxRsyTFTBxBWWvxj76zvD9iTsA=;
 b=L9fjRV+suR/Qab7mWf87Ym+HE1pX+xBxwbI7E3Mym93POo/wdh1WrSJ1+EWkxgHfbp
 TyFeIkpUX6HwsfxTlfH2jM4A9ejFu2sfYaEcF7gq9AISbmFRanAMxbgfGBdsAgDLpOgM
 SfBxoT8234VM2pezFyyGKF7jvKF23SLQ816o1pPqyFdHxP7/h0n/gPWpdxrP+wtoFSAy
 is1xf4SUYipmxhdAYqLNYQFH9zALgr5zwmHbUCbf31Ik8nezY0X5r7j/EB3xH2CGreLo
 MRvqu2FMRDeNr2za/e0gz++Rn+LEiydw44NCY13z+d9RCOYiWWQWZg9DS7D4b9hILp1+
 nZLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYVDoRoHfG9qvIGhgQsQfYzKm1Wk/fR1tUL1QZpu3NqBEXzxIp685b00pvrx4Os3WV4IWYdKkkRmRfiTopwwJQvZf8Lrs=
X-Gm-Message-State: AOJu0Yy8miNa4pKxzzViGsCU5tY3TFKlQipEeB1MkCZgIZ8p48JLQLat
 d25AiQ5Wtd5W1w7OkMyvzYepxE8hKc/b7h9tQXhfBiUIl5Agz44MOKYiu63yFGQ=
X-Google-Smtp-Source: AGHT+IGH/XkF6c7YliELRAZ3C+w64+vKTfsT7ki7NvPurtzZwDlBBQtzSBblkJnK83C7QQy3uV09AQ==
X-Received: by 2002:a05:6000:b89:b0:368:3b5c:7a5d with SMTP id
 ffacd0b85a97d-36d5e1c7656mr2289108f8f.20.1723219477084; 
 Fri, 09 Aug 2024 09:04:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429059714d5sm135171295e9.13.2024.08.09.09.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 09:04:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 1/2] target/arm: Update translation regime comment for new
 features
Date: Fri,  9 Aug 2024 17:04:29 +0100
Message-Id: <20240809160430.1144805-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809160430.1144805-1-peter.maydell@linaro.org>
References: <20240809160430.1144805-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

We have a long comment describing the Arm architectural translation
regimes and how we map them to QEMU MMU indexes.  This comment has
got a bit out of date:

 * FEAT_SEL2 allows Secure EL2 and corresponding new regimes
 * FEAT_RME introduces Realm state and its translation regimes
 * We now model the Cortex-R52 so that is no longer a hypothetical
 * We separated Secure Stage 2 and NonSecure Stage 2 MMU indexes
 * We have an MMU index per physical address spacea

Add the missing pieces so that the list of architectural translation
regimes matches the Arm ARM, and the list and count of QEMU MMU
indexes in the comment matches the enum.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a12859fc533..216774f5d3a 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2772,8 +2772,14 @@ bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync);
  *  + NonSecure EL1 & 0 stage 2
  *  + NonSecure EL2
  *  + NonSecure EL2 & 0   (ARMv8.1-VHE)
- *  + Secure EL1 & 0
- *  + Secure EL3
+ *  + Secure EL1 & 0 stage 1
+ *  + Secure EL1 & 0 stage 2 (FEAT_SEL2)
+ *  + Secure EL2 (FEAT_SEL2)
+ *  + Secure EL2 & 0 (FEAT_SEL2)
+ *  + Realm EL1 & 0 stage 1 (FEAT_RME)
+ *  + Realm EL1 & 0 stage 2 (FEAT_RME)
+ *  + Realm EL2 (FEAT_RME)
+ *  + EL3
  * If EL3 is 32-bit:
  *  + NonSecure PL1 & 0 stage 1
  *  + NonSecure PL1 & 0 stage 2
@@ -2805,10 +2811,12 @@ bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync);
  *     table over and over.
  *  6. we need separate EL1/EL2 mmu_idx for handling the Privileged Access
  *     Never (PAN) bit within PSTATE.
- *  7. we fold together the secure and non-secure regimes for A-profile,
+ *  7. we fold together most secure and non-secure regimes for A-profile,
  *     because there are no banked system registers for aarch64, so the
  *     process of switching between secure and non-secure is
  *     already heavyweight.
+ *  8. we cannot fold together Stage 2 Secure and Stage 2 NonSecure,
+ *     because both are in use simultaneously for Secure EL2.
  *
  * This gives us the following list of cases:
  *
@@ -2820,14 +2828,15 @@ bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync);
  * EL2 EL2&0 +PAN
  * EL2 (aka NS PL2)
  * EL3 (aka S PL1)
- * Physical (NS & S)
- * Stage2 (NS & S)
+ * Stage2 Secure
+ * Stage2 NonSecure
+ * plus one TLB per Physical address space: S, NS, Realm, Root
  *
- * for a total of 12 different mmu_idx.
+ * for a total of 14 different mmu_idx.
  *
  * R profile CPUs have an MPU, but can use the same set of MMU indexes
  * as A profile. They only need to distinguish EL0 and EL1 (and
- * EL2 if we ever model a Cortex-R52).
+ * EL2 for cores like the Cortex-R52).
  *
  * M profile CPUs are rather different as they do not have a true MMU.
  * They have the following different MMU indexes:
-- 
2.34.1


