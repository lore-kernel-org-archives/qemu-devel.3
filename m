Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E78FCA0FF0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4eF-0001nF-RX; Tue, 26 Aug 2025 21:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4dZ-0007Xm-9e
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:07:43 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4dU-0007am-MX
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:07:40 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-76e2e88c6a6so5566266b3a.1
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756256852; x=1756861652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Mzkv/ARe4RUNBXryPDykt2Z93CF8H2bNJcxJ8kAMtQ=;
 b=wcgH08xN590ORIPXjAm+2QekIgyVazzruA/S0GcTS3MKAvleAUtfkO7vxvtSV5VidE
 1LoYw16cSrRi9Nz4bcQJWasbLtkdtTzkgwJbrH7Se5M21fO5OrdYHh2cN3XudV823T8W
 nTc6rYfugcVRmMTrVcvaC92kM3yRgiuBQKj59CTWZlr699XQ53YLEd1iXpACvZLjNLdI
 5PVYKouXoQ41BpONSnLbzuLEqXS8PPIQPpm2uvJ2BlxBEdh7acn+4BPPqcnizZFJmfxf
 jgGxTLV8cSPF+/h/IcAR/rIoBpiuAX6b25r9gyNMsMwXdUdYw7g9ZKZbd+MvD/vBYrTO
 Dmpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756256852; x=1756861652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Mzkv/ARe4RUNBXryPDykt2Z93CF8H2bNJcxJ8kAMtQ=;
 b=bMIPcR99ZE0QSM3Qdgr3NrB02xnHWW+nviu9Fr9ZLQQRYE15O4eF+XCsfFPXYalqMI
 u72AoJ47u38TOgmT/XcHhBXeG5Rn9S8qpNEBq/DF02cWXDLuvWstEZZV7D1Finci2j4j
 CsImgsi32ryLsSsdkaPWa3LqehCgovvzsLyuL0fA4EHYhxv8idbXIeuBgeOlEKyZbawD
 ilLZO5pieN3MHBrnlD1XPH0ufvE4eOW+F83RP5srofMbSeH4Sf2Pmh4CltAEdFSNKsME
 WB24xVztabSpBAycAmSFCMSYcchrDl91OMwyN9dRidTz0HnbMIeAvxBde7dGXesAs+9c
 Hu9Q==
X-Gm-Message-State: AOJu0Yxb+ODR3Q/6lJUfjBItHmdBJf4N8XdLjLWUYnM7HgifSz63sfEm
 l2ZcaZO+nJqc4s/4gJKUqScmlxylFBQov6+HY4DOh4m88CYnFpwiUMOeWY19lkBPYw/8rnUWTYj
 gbQQIocI=
X-Gm-Gg: ASbGncu9+E9M8G5IxK1LghGyCtQa52EhYW3WwlPUewvuAmXVyCaAeGOHHcXBreKknw2
 FRjLNb0eh72onfgwhe3MD2Yf0jhoOF+NRpNADszkdPmSLLqwRAnDLP4/1bxuILZo0W9hIEysHSg
 ZVe3Gaj2GPKtnY6e4NCPQdHHMk0LdtQ6NeOUMSty2YmZNTu4/ZavvHhT3CwK4WEC414Xe7mdRJ5
 O5Kykxr0xmZg8CDdbc1UtV6Sopjv2f5GGLcx4R0O2/XGxVHe01uoJW0zK+qSPMQTJzXJjNz3yBg
 GCuk4zy4qeIdW1kh1Qvf+2zz4kgU7obFSQZl0FTl+8U+DGEpIwCSOd37dqHGkhYx0eQf8oQ5soW
 NvjV3J7ucF5bP9BQV79ccAJGNXQtt+tXm9JYT0V8NbeAXLZY=
X-Google-Smtp-Source: AGHT+IHt59RAtXAnspcHNiGx8izVzNNxGZgUUFbo+MoJyUZPmWVkJw4oHIg7gsdZoRXtz9ZAXQL4rQ==
X-Received: by 2002:a05:6a00:3d55:b0:771:ec42:1c09 with SMTP id
 d2e1a72fcca58-771ec421d77mr9538236b3a.27.1756256851690; 
 Tue, 26 Aug 2025 18:07:31 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7720274534esm1419241b3a.47.2025.08.26.18.07.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:07:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 27/61] target/arm: Remove name argument to alloc_cpreg
Date: Wed, 27 Aug 2025 11:04:18 +1000
Message-ID: <20250827010453.4059782-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

All callers now pass in->name, so take the value from there.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index d9ac6a20a7..3cd4546494 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7267,9 +7267,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
  * Copy a ARMCPRegInfo structure, allocating it along with the name
  * and an optional suffix to the name.
  */
-static ARMCPRegInfo *alloc_cpreg(const ARMCPRegInfo *in,
-                                 const char *name, const char *suffix)
+static ARMCPRegInfo *alloc_cpreg(const ARMCPRegInfo *in, const char *suffix)
 {
+    const char *name = in->name;
     size_t name_len = strlen(name);
     size_t suff_len = suffix ? strlen(suffix) : 0;
     ARMCPRegInfo *out = g_malloc(sizeof(*in) + name_len + suff_len + 1);
@@ -7409,7 +7409,7 @@ static void add_cpreg_to_hashtable_aa32(ARMCPU *cpu, ARMCPRegInfo *r,
                                cp, crm, opc1, opc2, key);
         break;
     case ARM_CP_SECSTATE_BOTH:
-        r_s = alloc_cpreg(r, r->name, "_S");
+        r_s = alloc_cpreg(r, "_S");
         add_cpreg_to_hashtable(cpu, r_s, ARM_CP_STATE_AA32, ARM_CP_SECSTATE_S,
                                cp, crm, opc1, opc2, key);
 
@@ -7439,7 +7439,7 @@ static void add_cpreg_to_hashtable_aa64(ARMCPU *cpu, ARMCPRegInfo *r,
          * and name that it is passed, so it's OK to use
          * a local struct here.
          */
-        ARMCPRegInfo *nxs_ri = alloc_cpreg(r, r->name, "NXS");
+        ARMCPRegInfo *nxs_ri = alloc_cpreg(r, "NXS");
         uint32_t nxs_key;
 
         assert(nxs_ri->crn < 0xf);
@@ -7662,7 +7662,7 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
     for (int crm = crmmin; crm <= crmmax; crm++) {
         for (int opc1 = opc1min; opc1 <= opc1max; opc1++) {
             for (int opc2 = opc2min; opc2 <= opc2max; opc2++) {
-                ARMCPRegInfo *r2 = alloc_cpreg(r, r->name, NULL);
+                ARMCPRegInfo *r2 = alloc_cpreg(r, NULL);
                 ARMCPRegInfo *r3;
 
                 switch (r->state) {
@@ -7673,7 +7673,7 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
                     add_cpreg_to_hashtable_aa64(cpu, r2, crm, opc1, opc2);
                     break;
                 case ARM_CP_STATE_BOTH:
-                    r3 = alloc_cpreg(r2, r2->name, NULL);
+                    r3 = alloc_cpreg(r2, NULL);
                     add_cpreg_to_hashtable_aa32(cpu, r2, cp, crm, opc1, opc2);
                     add_cpreg_to_hashtable_aa64(cpu, r3, crm, opc1, opc2);
                     break;
-- 
2.43.0


