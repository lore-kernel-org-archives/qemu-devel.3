Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9925606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 05:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MCXTPE/A
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWS1n-0004F3-NI; Thu, 26 Nov 2026 00:28:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haseebashraf091@gmail.com>)
 id 1xWS1V-0004Ce-VN
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 00:27:58 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haseebashraf091@gmail.com>)
 id 1xWS1U-0001mG-BQ
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 00:27:57 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso51408645e9.0
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 21:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795670874; x=1796275674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6cw4bVM/elmiYBT/hpISiGamNAca35rw9WaolQpyJgc=;
 b=MCXTPE/A26kObri0Ka3Yi2TyLa6bKRcKtiLjj7udUwhSNE3t0Szgjw8LZrsQXLjboo
 X3f9mNJ4ps7HJrhIQJy256bSpfVroXEPTrLrlyoitVD7+as+61SrnLTMLse3W5m9DwiV
 woqQRlTGdCeV7jexyUbPi9ECh7G7JNRdcdJh4S/IA/dQ7YGelvzryrTI9PbxkEJoTnco
 4FYACrUd4rq+PkduZruOnMeKhvdMPdBS0OHgpm9VRtSrhQGlClbdsOlAGK9ZZb9z7IDy
 0bedAlP09RYandr1gvM1qCYgnp6oC5n68SGEkqtryJ+E2z19Mg3zn61ZbEc4KWsLSXUS
 iQiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795670874; x=1796275674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6cw4bVM/elmiYBT/hpISiGamNAca35rw9WaolQpyJgc=;
 b=dxqE32sMxQIkuyr0LZaWt22m3zdhnLTWl1lgVD1uy5/Et2J92WIqrd/t9h2blA+0zM
 oNkm8SiKNGA8m8WUvMCpPV5ZTG3cgztXwiPu5kArpEVOneTaJYBSEnnmIDjQHRgwZokO
 XKL7iHY80+3XkMzWFZpUjxy4EzYqVvKpYymTwI7mWVdkbyhsnFakaJVXcfpXb4C2F344
 QC75qo3AMUZSH2WUfPONYpjHWnlJQyNmzZXXDc5FMEmHwtLLATKtHhQa62TaCOVQoLsL
 IKka0FCs44MLCPB/TsP5UQYQEMhNlFxF+oiVvb1uG03vaUqFL7RlrUmOnU5ftH2zga3m
 I0kg==
X-Forwarded-Encrypted: i=1;
 AL+hErH7ogzJ6kQBcZxTrAzURKbMlQ/oGu5mdT3JeT6L7P1wYf3csfNjn4b8OEh7DunasjWGVuB1yYiIwfqg@nongnu.org
X-Gm-Message-State: APuU4Z/mCBNtQv/tCZFP6WGTEzf6iznxkQ3upA5tQvaSs3spjwy5UlPy
 ezYRUNKaRmWuHHi6SABbUUnDSLvIxh5ufbbabhqdcLtKEX4leEGFNe+a
X-Gm-Gg: AZFdTZfWhyX+i+BRwbCqTk7qbqW2gFVUJcQaRUL4Ce7LYxFY3lHNh6SD1ljI6cRjs/Y
 ni80YuHFZHyKnZG6FxLevfburDVvLebGZsz5k7GejjvIbUpvkdyP8FlTEbZqxZ66WGC0Q9HrsXR
 6ln+rQOPAFkSEaWZEIo1eBssaLqUlKGdMSBT1R6c3yd9QLBMmYmNVAAazCOw4I+jC3IrnR+r5Xt
 yMqN+BGLFB+1iKtNvcFqZoh3rkWLlPhLRDGC/DM4yI/wHYjIAPE10XliLarNXc+yeigOKJiyw4h
 A/azc5m9EdMn0x9PMY108fgkEUdXWes+1J6iMGlAxl2zL96+zbj6MdlN0U6BNkggLwbj27DUieg
 sYNmDNSmSu5s9wldGP4qvPuC2xlDNXFmiN07ySB9Cl4k0SZYx98JuipW8iFZjzBv+gZWiY5xUzf
 NNfpgW4Lq5gfHUE4sqB83TtU03Cg/+oU5oFsVhCGQLx2nMMt8mPg/Z6oSBuCRaZDRylk5wUBsmA
 ceDCRWfhgJzA0VmbQ5BTdiCxPGvN06fk8rpaaaHOM1F340qoJv+73WNTniEDQMnr0nOIFQHXB7k
 Ebgrk1CkfYJ2zCQXGmX99zp/r0mi/IWViJvnxBsO08xjePlx7UVi/2z9Hvb2ltDXdN5uOFM4eSh
 ghZc4wvcCXcNvfMrGB38mWpN5
X-Received: by 2002:a05:600c:820d:b0:4bb:6cef:d14b with SMTP id
 5b1f17b1804b1-4bb887c34f1mr406326865e9.2.1795670873743; 
 Wed, 25 Nov 2026 21:27:53 -0800 (PST)
Received: from PKL-HASEEBA-LT.. ([39.36.25.192])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm808310475e9.13.2026.11.25.21.27.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 21:27:53 -0800 (PST)
From: Haseeb Ashraf <haseebashraf091@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Cc: Haseeb Ashraf <haseeb.ashraf@siemens.com>,
 Eric Auger <eric.auger@redhat.com>,
 Khushit Shah <khushit.shah@nutanix.com>, Marc Zyngier <maz@kernel.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Subject: [RFC PATCH v3 1/3] target/arm/kvm: Add kvm_arm_el2_e2h0_supported()
Date: Thu, 26 Nov 2026 10:27:39 +0500
Message-ID: <20261126052741.90607-2-haseebashraf091@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126052741.90607-1-haseebashraf091@gmail.com>
References: <20261121204601.741616-1-haseebashraf091@gmail.com>
 <20261126052741.90607-1-haseebashraf091@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=haseebashraf091@gmail.com; helo=mail-wm1-x32c.google.com
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


