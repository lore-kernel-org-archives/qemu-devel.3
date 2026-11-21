Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2467E606A32C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Nov 2026 20:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FW6zivGt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUryS-0004SS-W1; Sat, 21 Nov 2026 15:46:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haseebashraf091@gmail.com>)
 id 1xUryQ-0004Rb-Tz
 for qemu-devel@nongnu.org; Sat, 21 Nov 2026 15:46:14 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haseebashraf091@gmail.com>)
 id 1xUryP-0005z8-3F
 for qemu-devel@nongnu.org; Sat, 21 Nov 2026 15:46:14 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so18092225e9.2
 for <qemu-devel@nongnu.org>; Sat, 21 Nov 2026 12:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795293971; x=1795898771; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6cw4bVM/elmiYBT/hpISiGamNAca35rw9WaolQpyJgc=;
 b=FW6zivGtYENpgMm2Irynn4BM+ylPkCGxwSwUb3nx7bXpH8R3QEEqE1gxDeVNMRZZ5h
 2yJWLpP175XBm8vcRXeiZEEC85HfmkC681dJZnWlQGxtWWG+5/cBU/NxG5GZt+1YNWe8
 1YP/FALcaIP0oSqe+5OU2SkABNMiSORHEUSZPsRfcSZcWaIPEN1BlWsJxF8TgPG1pxW9
 Fpn5ebG1/9GPe0e+GIbnW58EVNQGzQEcqpF0psEgEL/phmu6YMf1vm+c/lae3iywpf7G
 AGf29Ve8nfNYXILy5spBjAPeCMd86s7s85nFF+E9huqnMnOy7cin8bwV91/KX/KnaPH5
 VBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795293971; x=1795898771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6cw4bVM/elmiYBT/hpISiGamNAca35rw9WaolQpyJgc=;
 b=b3th0bEvoMhrSIQPP0Sjt+nED7MJZcKZXQykmvVAJ7Xzwmz8gQcc4LwWTr8NuJR9/E
 CqtqPB2dLzDtm6vrkkOKLVeS0dYTamIFFxz5mZ0toEN9ZmtL60V3hBte4vkcZLi86h/F
 ArDLMmcigFvBPPkVLsE8D8pP7+W73sE+Z/Frb8b6JNdio33zT9FyGA9R4M9hBKFpEbRX
 qGFDJ7r5Y/gPKLs0RRrjmdLC7Pfxl8/QUBz88E7olCn8jCSOZoilhHHmu8taLYksDTuf
 LLlxqNMX3dvNvRudpaY4bIkEkI+5dwqqoa4Odh67vQoG08prS+5FHKDykP+gm1DBiRWf
 IaKg==
X-Forwarded-Encrypted: i=1;
 AL+hErHrcy5WONm08/eE8NZnGsTvZ8O8IealNQr4Sx1QB6QZ7AF53/QeCLvDIfaZCI2cphXEkPsvcJ0AE+lI@nongnu.org
X-Gm-Message-State: APuU4Z8fhIhmejM1DrvcPQRHjUxl4VaFatMU7/X5XFlA274VkipRWb3z
 jyw0YCpvdREm9iqA8LmNRkyu3OuWvnI16sf3/6IrTUalgkd/6ja3WHNT
X-Gm-Gg: AZFdTZdm3t8iZlXtry8rzNzoFlwJHFDhrlEEcX9rr1r6JLsfdwwaaSTS8vKBtpKSLKb
 VmCkAz1wsL3sJQYCAWo6tyE7h3aW145ZSmQZbw60kbkoy28E28qk8klZWXGtrBRYQ7a2qVH3ela
 6E4sLsYHaGYcxN7C8psRwRMRudjFmDoCi6g8+Q2lKe3Iqgy7rr/hEjqvRW477denymvEsLeeECJ
 qEb2eOQsQSAs2oHL1FPYgA2aPSvlf5ZjgUl+aois5Ldy869p1wimlgWjZd82k77NqSb+xGjN4eQ
 LR9skGaYkCCg28SY5+93lkQ4DYjb9IFiWn6heddr/q0S/n0bblPGTyjuEwG4lV2Jmm6m0UpYh76
 NCmRctEn38kEdTI1BtYvmWyKZa7ZuN2lreDmdqvaDV7KjyqBodvYfOyX7z0YNWjDy6jCyttzkuP
 vdrV2JHYuo+N0jrveFEETi28C3XFuMKR6xLkZ5C7ZEBhNUIIJ2HUDtiPMZDmBnn5VxhabmLmjMF
 lKdPQ/O39XTs7lsMOwa5zCR/L67/CV7LZ1urxOdenl3BZtDSn1alNWTXinljmNSjsA8rLCMoLmF
 m+v41aByHmXgXFf1s5tSRTLda/Hhn4rY0UBtLV2rJ6PzQobnbBzhhka+H1o8m0i8UFByownsKdc
 2JsTKF6a/Iod6ZcdRbmMY3ms=
X-Received: by 2002:a05:600c:190d:b0:4ba:2bfc:c8b5 with SMTP id
 5b1f17b1804b1-4bb888267aemr149715085e9.10.1795293971472; 
 Sat, 21 Nov 2026 12:46:11 -0800 (PST)
Received: from PKL-HASEEBA-LT.. ([39.36.59.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b39b6sm180652385e9.12.2026.11.21.12.46.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 12:46:11 -0800 (PST)
From: Haseeb Ashraf <haseebashraf091@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Cc: Haseeb Ashraf <haseeb.ashraf@siemens.com>,
 Eric Auger <eric.auger@redhat.com>, Marc Zyngier <maz@kernel.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Subject: [RFC PATCH v2 1/3] target/arm/kvm: Add kvm_arm_el2_e2h0_supported()
Date: Sun, 22 Nov 2026 01:45:59 +0500
Message-ID: <20261121204601.741616-2-haseebashraf091@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121204601.741616-1-haseebashraf091@gmail.com>
References: <20261121095636.289814-1-haseebashraf091@gmail.com>
 <20261121204601.741616-1-haseebashraf091@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=haseebashraf091@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Haseeb Ashraf <haseeb.ashraf@siemens.com>

Add a helper reporting whether KVM can limit a nested guest to an
nVHE-only EL2 (HCR_EL2.E2H RES0) through the
KVM_ARM_VCPU_HAS_EL2_E2H0 vCPU feature.  KVM advertises this with
KVM_CAP_ARM_EL2_E2H0.

The next patch uses it to let the user select an nVHE-only EL2.

Signed-off-by: Haseeb Ashraf <haseeb.ashraf@siemens.com>
---
 target/arm/kvm-stub.c |  5 +++++
 target/arm/kvm.c      |  5 +++++
 target/arm/kvm_arm.h  | 13 +++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index c9387f5c8c..88e35909c4 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -42,6 +42,11 @@ bool kvm_arm_el2_supported(void)
     return false;
 }
 
+bool kvm_arm_el2_e2h0_supported(void)
+{
+    return false;
+}
+
 /*
  * These functions should never actually be called without KVM support.
  */
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 36a5faf537..8ef5597c68 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2178,6 +2178,11 @@ bool kvm_arm_el2_supported(void)
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_EL2);
 }
 
+bool kvm_arm_el2_e2h0_supported(void)
+{
+    return kvm_check_extension(kvm_state, KVM_CAP_ARM_EL2_E2H0);
+}
+
 bool kvm_arm_mte_supported(void)
 {
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_MTE);
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 2e7e02e4a4..0916a5fdb4 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -200,6 +200,14 @@ bool kvm_arm_mte_supported(void);
  * Returns true if KVM can enable EL2 and false otherwise.
  */
 bool kvm_arm_el2_supported(void);
+
+/**
+ * kvm_arm_el2_e2h0_supported:
+ *
+ * Returns true if KVM can limit EL2 to nVHE (HCR_EL2.E2H RES0) through
+ * KVM_ARM_VCPU_HAS_EL2_E2H0, and false otherwise.
+ */
+bool kvm_arm_el2_e2h0_supported(void);
 #else
 
 static inline bool kvm_arm_aarch32_supported(void)
@@ -216,6 +224,11 @@ static inline bool kvm_arm_el2_supported(void)
 {
     return false;
 }
+
+static inline bool kvm_arm_el2_e2h0_supported(void)
+{
+    return false;
+}
 #endif
 
 /**
-- 
2.34.1


