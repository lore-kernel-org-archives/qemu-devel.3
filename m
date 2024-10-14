Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5927DCF2597
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 10:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0If2-00041G-7E; Mon, 14 Oct 2024 06:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t0Ier-0003zg-J3
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 06:50:39 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t0Ien-0006U8-Be
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 06:50:37 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a99ebb390a5so311609166b.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 03:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728903031; x=1729507831; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8X9vuyXYR+y0kKvLJhNNDZ/SbTUMunEDKhXMJN3UXWA=;
 b=Qs0Dyp8Z9l/foVl0VWBLhsKlR4lBfLJAmmeHMoxilBs42/LjHGw/sEX6p//BmIasMS
 DnFDB0VKVl/DRHDDxI+0VwirI8G/Omru13j37xlF/pVhA8/yCzDHbhKGFjMKtEnZZk+j
 HSsGkCHjxIviQ0tbYIg0u4byHm++D4TnPwCXBN7Cx58t0kxGI2dCcUVxCEW7V/mD9svc
 HXpafqTXCaPMx1QaOseQaq+G5Wn3KjV6AXY/lTPvryLxf4+cqcx0tehozxwt5l/WTR2F
 0qL2Ia2UeXdAZZqlzlzER8dBqQjndDmENQId8eWgEdqrmngN0HxGNdKMnEvdoeI301Dr
 Cwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728903031; x=1729507831;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8X9vuyXYR+y0kKvLJhNNDZ/SbTUMunEDKhXMJN3UXWA=;
 b=T/zAt2IGB+5ENhozdhehrvmQ/tkkKERJ5GoVCp1+bxUdWXuURzmuGJNqb1aBgJlNgQ
 ZVdilGV9EwebNeoqVwzziAK0/glfcmzYuSpbSz7+cMwcNbzhtHQEK/A8YW3Ms5Zh2ALO
 wKd0ge87++DFBmFCpV4G27NymFTAhsYIogARB3wEyMmSa+rU4pzI+bV926Xk3MO2nbTR
 lMgRQxdaT65baA6tJFboXl8Rb0Rnh11OsqL/BvWd7/ueJ9e7CshiArZPHXUibRa9MBYs
 J0pyHDDryU1gvEr7kRpOBKL0tdq1fQjPRFmClHvz5CWDKGIMKA2Edcn42a0qgCoYkf1f
 vALw==
X-Gm-Message-State: AOJu0Yw4Rd95dcqZ0VgnQ+OAzNfsNdSHA8Lso0B5TXoKzSk0lFfoESLt
 5jKI6iAAUd0dJPL8dFLnjfADU/93TKzdKXcsAUblh0u6qxYfWgHxfaQyQBpubQ0=
X-Google-Smtp-Source: AGHT+IHlZvR3dhS8CEOFdhvx33yu9qL4e9Ogjcqp2WRevmPYMw2pYetmQW9tpUfDQZd96+hOdlsL+Q==
X-Received: by 2002:a17:907:7e8d:b0:a99:a18d:9793 with SMTP id
 a640c23a62f3a-a99b8775270mr888572666b.7.1728903031198; 
 Mon, 14 Oct 2024 03:50:31 -0700 (PDT)
Received: from [127.0.1.1] (adsl-161.109.242.225.tellas.gr. [109.242.225.161])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a0b25226esm165504466b.59.2024.10.14.03.50.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 03:50:30 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 14 Oct 2024 13:48:55 +0300
Subject: [RFC PATCH 1/4] arm: Add FEAT_XS's TLBI NXS variants
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-arm-feat-xs-v1-1-42bb714d6b11@linaro.org>
References: <20241014-arm-feat-xs-v1-0-42bb714d6b11@linaro.org>
In-Reply-To: <20241014-arm-feat-xs-v1-0-42bb714d6b11@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.15-dev-12fc5
X-Developer-Signature: v=1; a=openpgp-sha256; l=30178;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=RH4gUuM4XiAkN2cmpjZ12TmceirbRYYoaEbxapzFk1I=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm5EUGQwK2FiWExYMng4b2l3K01DUkE5OU5Wa09jClc1cDBHNnhoUXo5Q085YnFt
 a2VKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnd6M2RBQUt
 DUkIzS2Nkd2YzNEowQUFyRC85UkdiMVMvaExOV2hGY3djZjQzdkg5S3I1T3p4UEQvYTE1NVp2dA
 p6ZmNNblNEeFIreThQclRZalFzSnpTRWpBbUVUOEx5QTJnT2tzNjZxZENLamdEelBJMUROaEh3a
 mxXZlJXaVRrCmNJN0tVeDJ6MVI1cGtWT3ZvVUVLU1lhUVllcDh4NFNuenpLT2dTMldWREloR3lr
 ZU0vbmRlVTNxOUVqY2k5RmwKRGtPenVlM05UMGloUkl3YWY5aExiS0x1dUZyQ2lYTlo2elB2YmN
 Qd3BNV29vNlA1anQrRU0zamtQd2F1bjVNSApXeGV5QkFCSTh2Q01OUVNKSXZ6djVFVm9LZ3NzV1
 pEZHJZb241endSZDFva0JuOW1lTnNGTXplN2ZCZzhvS0hsCnpBa2tNNEFRNW95WXlXTEY4Sjh2W
 GlBYkpGVVpZaEl5d29tL0FZTm54WERGT1B5WUpMcDQxTVNGbU8xZ2hBR0IKZkhFU3ZPQVdUcnR5
 dnpsNXJrSEREV2l1SWNIbVBrajRxcEJ6V05waGFQc2lHeStrb0QrMVVqRGlCOVA2dlBtQgpjQXA
 1eTJWZUFFZlBKUEllWFh1RDFVZUNOc3ZPclRWbEdPRHFKN1VSa0F3eHVjV1hGWWcxcVdWME9HZm
 MxQU5sCkRUeitmYUlpeVk2L3dXbHI0TXVVcU5vWHNFbXBrOGNmUXZKM0g0cVphYzNnZy91aGNsT
 HNmVG93VVlSczNXSTUKQ1hwU3B0aCs5RjBlSlR6VnU0SGFWZUMwOGtydExXYnJtd0JTejNCakNs
 YnlmNmQ2Yyt1eWN0dVNRSmphWVVmbAphSnJvUDRCN1hzamQ5WGVFYWtlTTMzNGVxcUNZRzIzUDR
 seDZ4b3BseVVxeXVUQmdaVHEzdm50RHF1eEg1TDZTCk9TYTJjUT09Cj12YVhVCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x630.google.com
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

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 target/arm/cpu-features.h |   5 +
 target/arm/helper.c       | 366 +++++++++++++++++++++++++++-------------------
 2 files changed, 218 insertions(+), 153 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 04ce2818263e2c3b99c59940001b65302e1d26d2..b4dcd429c3540e18c44d3c30f82f030be45719f2 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -970,6 +970,11 @@ static inline bool isar_feature_aa64_sme_fa64(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64smfr0, ID_AA64SMFR0, FA64);
 }
 
+static inline bool isar_feature_aa64_xs(const ARMISARegisters *id)
+{
+    return FIELD_SEX64(id->id_aa64isar1, ID_AA64ISAR1, XS) >= 0;
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3f77b40734f2db831254a0e4eb205751aec0d1e5..3104a2d1dab6e58bf454c75afd478ec6d5fe521f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5671,98 +5671,111 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .fgt = FGT_DCCISW,
       .access = PL1_W, .accessfn = access_tsw, .type = ARM_CP_NOP },
     /* TLBI operations */
-    { .name = "TLBI_VMALLE1IS", .state = ARM_CP_STATE_AA64,
+#define TLBI(name, opc0, opc1, crn, crm, opc2, access, accessfn, type, fgt, \
+             writefn)                                                       \
+{ name, .state = ARM_CP_STATE_AA64, opc0, opc1, crn, crm, opc2, access,     \
+  accessfn, type, fgt, writefn },                                           \
+{ name"NXS", .state = ARM_CP_STATE_AA64, opc0, opc1, crn + 1, crm, opc2,    \
+   access, accessfn, type, fgt, writefn }
+ TLBI(.name = "TLBI_VMALLE1IS",
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 0,
       .access = PL1_W, .accessfn = access_ttlbis, .type = ARM_CP_NO_RAW,
       .fgt = FGT_TLBIVMALLE1IS,
-      .writefn = tlbi_aa64_vmalle1is_write },
-    { .name = "TLBI_VAE1IS", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_vmalle1is_write),
+ TLBI(.name = "TLBI_VAE1IS",
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 1,
       .access = PL1_W, .accessfn = access_ttlbis, .type = ARM_CP_NO_RAW,
       .fgt = FGT_TLBIVAE1IS,
-      .writefn = tlbi_aa64_vae1is_write },
-    { .name = "TLBI_ASIDE1IS", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_vae1is_write),
+ TLBI(.name = "TLBI_ASIDE1IS",
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 2,
       .access = PL1_W, .accessfn = access_ttlbis, .type = ARM_CP_NO_RAW,
       .fgt = FGT_TLBIASIDE1IS,
-      .writefn = tlbi_aa64_vmalle1is_write },
-    { .name = "TLBI_VAAE1IS", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_vmalle1is_write),
+ TLBI(.name = "TLBI_VAAE1IS",
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 3,
       .access = PL1_W, .accessfn = access_ttlbis, .type = ARM_CP_NO_RAW,
       .fgt = FGT_TLBIVAAE1IS,
-      .writefn = tlbi_aa64_vae1is_write },
-    { .name = "TLBI_VALE1IS", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_vae1is_write),
+ TLBI(.name = "TLBI_VALE1IS",
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 5,
       .access = PL1_W, .accessfn = access_ttlbis, .type = ARM_CP_NO_RAW,
       .fgt = FGT_TLBIVALE1IS,
-      .writefn = tlbi_aa64_vae1is_write },
-    { .name = "TLBI_VAALE1IS", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_vae1is_write),
+ TLBI(.name = "TLBI_VAALE1IS",
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 7,
       .access = PL1_W, .accessfn = access_ttlbis, .type = ARM_CP_NO_RAW,
       .fgt = FGT_TLBIVAALE1IS,
-      .writefn = tlbi_aa64_vae1is_write },
-    { .name = "TLBI_VMALLE1", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_vae1is_write),
+ TLBI(.name = "TLBI_VMALLE1",
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 0,
       .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
       .fgt = FGT_TLBIVMALLE1,
-      .writefn = tlbi_aa64_vmalle1_write },
-    { .name = "TLBI_VAE1", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_vmalle1_write),
+ TLBI(.name = "TLBI_VAE1",
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 1,
       .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
       .fgt = FGT_TLBIVAE1,
-      .writefn = tlbi_aa64_vae1_write },
-    { .name = "TLBI_ASIDE1", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_vae1_write),
+ TLBI(.name = "TLBI_ASIDE1",
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 2,
       .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
       .fgt = FGT_TLBIASIDE1,
-      .writefn = tlbi_aa64_vmalle1_write },
-    { .name = "TLBI_VAAE1", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_vmalle1_write),
+ TLBI(.name = "TLBI_VAAE1",
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 3,
       .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
       .fgt = FGT_TLBIVAAE1,
-      .writefn = tlbi_aa64_vae1_write },
-    { .name = "TLBI_VALE1", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_vae1_write),
+ TLBI(.name = "TLBI_VALE1",
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 5,
       .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
       .fgt = FGT_TLBIVALE1,
-      .writefn = tlbi_aa64_vae1_write },
-    { .name = "TLBI_VAALE1", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_vae1_write),
+ TLBI(.name = "TLBI_VAALE1",
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 7,
       .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
       .fgt = FGT_TLBIVAALE1,
-      .writefn = tlbi_aa64_vae1_write },
-    { .name = "TLBI_IPAS2E1IS", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_vae1_write),
+#undef TLBI
+#define TLBI(name, opc0, opc1, crn, crm, opc2, access, type, writefn)   \
+{ name, .state = ARM_CP_STATE_AA64, opc0, opc1, crn, crm, opc2, access, \
+  type, writefn },                                           \
+{ name"NXS", .state = ARM_CP_STATE_AA64, opc0, opc1, crn + 1, crm, opc2,\
+   access, type, writefn }
+ TLBI(.name = "TLBI_IPAS2E1IS",
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 0, .opc2 = 1,
       .access = PL2_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_ipas2e1is_write },
-    { .name = "TLBI_IPAS2LE1IS", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_ipas2e1is_write),
+ TLBI(.name = "TLBI_IPAS2LE1IS",
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 0, .opc2 = 5,
       .access = PL2_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_ipas2e1is_write },
-    { .name = "TLBI_ALLE1IS", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_ipas2e1is_write),
+ TLBI(.name = "TLBI_ALLE1IS",
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 4,
       .access = PL2_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_alle1is_write },
-    { .name = "TLBI_VMALLS12E1IS", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_alle1is_write),
+ TLBI(.name = "TLBI_VMALLS12E1IS",
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 6,
       .access = PL2_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_alle1is_write },
-    { .name = "TLBI_IPAS2E1", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_alle1is_write),
+ TLBI(.name = "TLBI_IPAS2E1",
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 1,
       .access = PL2_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_ipas2e1_write },
-    { .name = "TLBI_IPAS2LE1", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_ipas2e1_write),
+ TLBI(.name = "TLBI_IPAS2LE1",
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 5,
       .access = PL2_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_ipas2e1_write },
-    { .name = "TLBI_ALLE1", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_ipas2e1_write),
+ TLBI(.name = "TLBI_ALLE1",
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 4,
       .access = PL2_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_alle1_write },
-    { .name = "TLBI_VMALLS12E1", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_alle1_write),
+ TLBI(.name = "TLBI_VMALLS12E1",
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 6,
       .access = PL2_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_alle1is_write },
+      .writefn = tlbi_aa64_alle1is_write),
+#undef TLBI
 #ifndef CONFIG_USER_ONLY
     /* 64 bit address translation operations */
     { .name = "AT_S1E1R", .state = ARM_CP_STATE_AA64,
@@ -5819,41 +5832,49 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .writefn = par_write },
 #endif
     /* TLB invalidate last level of translation table walk */
-    { .name = "TLBIMVALIS", .cp = 15, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 5,
+#define TLBI(name, cp, opc1, crn, crm, opc2, type, access, accessfn, writefn)\
+{ name, cp, opc1, crn, crm, opc2, type, access, accessfn, writefn },         \
+{ name"NXS", cp, opc1, crn + 1, crm, opc2, type, access, accessfn, writefn }
+ TLBI(.name = "TLBIMVALIS", .cp = 15, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 5,
       .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlbis,
-      .writefn = tlbimva_is_write },
-    { .name = "TLBIMVAALIS", .cp = 15, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 7,
+      .writefn = tlbimva_is_write),
+ TLBI(.name = "TLBIMVAALIS", .cp = 15, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 7,
       .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlbis,
-      .writefn = tlbimvaa_is_write },
-    { .name = "TLBIMVAL", .cp = 15, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 5,
+      .writefn = tlbimvaa_is_write),
+ TLBI(.name = "TLBIMVAL", .cp = 15, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 5,
       .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
-      .writefn = tlbimva_write },
-    { .name = "TLBIMVAAL", .cp = 15, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 7,
+      .writefn = tlbimva_write),
+ TLBI(.name = "TLBIMVAAL", .cp = 15, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 7,
       .type = ARM_CP_NO_RAW, .access = PL1_W, .accessfn = access_ttlb,
-      .writefn = tlbimvaa_write },
-    { .name = "TLBIMVALH", .cp = 15, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 5,
+      .writefn = tlbimvaa_write),
+#undef TLBI
+#define TLBI(name, cp, opc1, crn, crm, opc2, type, access, writefn)\
+{ name, cp, opc1, crn, crm, opc2, type, access, writefn },         \
+{ name"NXS", cp, opc1, crn + 1, crm, opc2, type, access, writefn }
+ TLBI(.name = "TLBIMVALH", .cp = 15, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 5,
       .type = ARM_CP_NO_RAW, .access = PL2_W,
-      .writefn = tlbimva_hyp_write },
-    { .name = "TLBIMVALHIS",
+      .writefn = tlbimva_hyp_write),
+ TLBI(.name = "TLBIMVALHIS",
       .cp = 15, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 5,
       .type = ARM_CP_NO_RAW, .access = PL2_W,
-      .writefn = tlbimva_hyp_is_write },
-    { .name = "TLBIIPAS2",
+      .writefn = tlbimva_hyp_is_write),
+ TLBI(.name = "TLBIIPAS2",
       .cp = 15, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 1,
       .type = ARM_CP_NO_RAW, .access = PL2_W,
-      .writefn = tlbiipas2_hyp_write },
-    { .name = "TLBIIPAS2IS",
+      .writefn = tlbiipas2_hyp_write),
+ TLBI(.name = "TLBIIPAS2IS",
       .cp = 15, .opc1 = 4, .crn = 8, .crm = 0, .opc2 = 1,
       .type = ARM_CP_NO_RAW, .access = PL2_W,
-      .writefn = tlbiipas2is_hyp_write },
-    { .name = "TLBIIPAS2L",
+      .writefn = tlbiipas2is_hyp_write),
+ TLBI(.name = "TLBIIPAS2L",
       .cp = 15, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 5,
       .type = ARM_CP_NO_RAW, .access = PL2_W,
-      .writefn = tlbiipas2_hyp_write },
-    { .name = "TLBIIPAS2LIS",
+      .writefn = tlbiipas2_hyp_write),
+ TLBI(.name = "TLBIIPAS2LIS",
       .cp = 15, .opc1 = 4, .crn = 8, .crm = 0, .opc2 = 5,
       .type = ARM_CP_NO_RAW, .access = PL2_W,
-      .writefn = tlbiipas2is_hyp_write },
+      .writefn = tlbiipas2is_hyp_write),
+#undef TLBI
     /* 32 bit cache operations */
     { .name = "ICIALLUIS", .cp = 15, .opc1 = 0, .crn = 7, .crm = 1, .opc2 = 0,
       .type = ARM_CP_NOP, .access = PL1_W, .accessfn = access_ticab },
@@ -7829,207 +7850,245 @@ static const ARMCPRegInfo pauth_reginfo[] = {
 };
 
 static const ARMCPRegInfo tlbirange_reginfo[] = {
-    { .name = "TLBI_RVAE1IS", .state = ARM_CP_STATE_AA64,
+#define TLBI(name, opc0, opc1, crn, crm, opc2, access, accessfn, type, fgt, \
+             writefn)                                                       \
+{ name, .state = ARM_CP_STATE_AA64, opc0, opc1, crn, crm, opc2, access,     \
+  accessfn, type, fgt, writefn },                                           \
+{ name"NXS", .state = ARM_CP_STATE_AA64, opc0, opc1, crn + 1, crm, opc2,    \
+   access, accessfn, type, fgt, writefn }
+ TLBI(.name = "TLBI_RVAE1IS",
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 2, .opc2 = 1,
       .access = PL1_W, .accessfn = access_ttlbis, .type = ARM_CP_NO_RAW,
       .fgt = FGT_TLBIRVAE1IS,
-      .writefn = tlbi_aa64_rvae1is_write },
-    { .name = "TLBI_RVAAE1IS", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_rvae1is_write),
+ TLBI(.name = "TLBI_RVAAE1IS",
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 2, .opc2 = 3,
       .access = PL1_W, .accessfn = access_ttlbis, .type = ARM_CP_NO_RAW,
       .fgt = FGT_TLBIRVAAE1IS,
-      .writefn = tlbi_aa64_rvae1is_write },
-   { .name = "TLBI_RVALE1IS", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_rvae1is_write),
+   TLBI(.name = "TLBI_RVALE1IS",
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 2, .opc2 = 5,
       .access = PL1_W, .accessfn = access_ttlbis, .type = ARM_CP_NO_RAW,
       .fgt = FGT_TLBIRVALE1IS,
-      .writefn = tlbi_aa64_rvae1is_write },
-    { .name = "TLBI_RVAALE1IS", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_rvae1is_write),
+ TLBI(.name = "TLBI_RVAALE1IS",
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 2, .opc2 = 7,
       .access = PL1_W, .accessfn = access_ttlbis, .type = ARM_CP_NO_RAW,
       .fgt = FGT_TLBIRVAALE1IS,
-      .writefn = tlbi_aa64_rvae1is_write },
-    { .name = "TLBI_RVAE1OS", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_rvae1is_write),
+ TLBI(.name = "TLBI_RVAE1OS",
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 5, .opc2 = 1,
       .access = PL1_W, .accessfn = access_ttlbos, .type = ARM_CP_NO_RAW,
       .fgt = FGT_TLBIRVAE1OS,
-      .writefn = tlbi_aa64_rvae1is_write },
-    { .name = "TLBI_RVAAE1OS", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_rvae1is_write),
+ TLBI(.name = "TLBI_RVAAE1OS",
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 5, .opc2 = 3,
       .access = PL1_W, .accessfn = access_ttlbos, .type = ARM_CP_NO_RAW,
       .fgt = FGT_TLBIRVAAE1OS,
-      .writefn = tlbi_aa64_rvae1is_write },
-   { .name = "TLBI_RVALE1OS", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_rvae1is_write),
+ TLBI(.name = "TLBI_RVALE1OS",
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 5, .opc2 = 5,
       .access = PL1_W, .accessfn = access_ttlbos, .type = ARM_CP_NO_RAW,
       .fgt = FGT_TLBIRVALE1OS,
-      .writefn = tlbi_aa64_rvae1is_write },
-    { .name = "TLBI_RVAALE1OS", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_rvae1is_write),
+ TLBI(.name = "TLBI_RVAALE1OS",
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 5, .opc2 = 7,
       .access = PL1_W, .accessfn = access_ttlbos, .type = ARM_CP_NO_RAW,
       .fgt = FGT_TLBIRVAALE1OS,
-      .writefn = tlbi_aa64_rvae1is_write },
-    { .name = "TLBI_RVAE1", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_rvae1is_write),
+ TLBI(.name = "TLBI_RVAE1",
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 6, .opc2 = 1,
       .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
       .fgt = FGT_TLBIRVAE1,
-      .writefn = tlbi_aa64_rvae1_write },
-    { .name = "TLBI_RVAAE1", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_rvae1_write),
+ TLBI(.name = "TLBI_RVAAE1",
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 6, .opc2 = 3,
       .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
       .fgt = FGT_TLBIRVAAE1,
-      .writefn = tlbi_aa64_rvae1_write },
-   { .name = "TLBI_RVALE1", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_rvae1_write),
+   TLBI(.name = "TLBI_RVALE1",
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 6, .opc2 = 5,
       .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
       .fgt = FGT_TLBIRVALE1,
-      .writefn = tlbi_aa64_rvae1_write },
-    { .name = "TLBI_RVAALE1", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_rvae1_write),
+ TLBI(.name = "TLBI_RVAALE1",
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 6, .opc2 = 7,
       .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
       .fgt = FGT_TLBIRVAALE1,
-      .writefn = tlbi_aa64_rvae1_write },
-    { .name = "TLBI_RIPAS2E1IS", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_rvae1_write),
+#undef TLBI
+#define TLBI(name, opc0, opc1, crn, crm, opc2, access, type, writefn)    \
+{ name, .state = ARM_CP_STATE_AA64, opc0, opc1, crn, crm, opc2, access,  \
+  type, writefn },                                                       \
+{ name"NXS", .state = ARM_CP_STATE_AA64, opc0, opc1, crn + 1, crm, opc2, \
+  access, type, writefn }
+ TLBI(.name = "TLBI_RIPAS2E1IS",
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 0, .opc2 = 2,
       .access = PL2_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_ripas2e1is_write },
-    { .name = "TLBI_RIPAS2LE1IS", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_ripas2e1is_write),
+ TLBI(.name = "TLBI_RIPAS2LE1IS",
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 0, .opc2 = 6,
       .access = PL2_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_ripas2e1is_write },
-    { .name = "TLBI_RVAE2IS", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_ripas2e1is_write),
+ TLBI(.name = "TLBI_RVAE2IS",
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 2, .opc2 = 1,
       .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
-      .writefn = tlbi_aa64_rvae2is_write },
-   { .name = "TLBI_RVALE2IS", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_rvae2is_write),
+   TLBI(.name = "TLBI_RVALE2IS",
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 2, .opc2 = 5,
       .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
-      .writefn = tlbi_aa64_rvae2is_write },
-    { .name = "TLBI_RIPAS2E1", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_rvae2is_write),
+ TLBI(.name = "TLBI_RIPAS2E1",
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 2,
       .access = PL2_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_ripas2e1_write },
-    { .name = "TLBI_RIPAS2LE1", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_ripas2e1_write),
+ TLBI(.name = "TLBI_RIPAS2LE1",
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 6,
       .access = PL2_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_ripas2e1_write },
-   { .name = "TLBI_RVAE2OS", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_ripas2e1_write),
+   TLBI(.name = "TLBI_RVAE2OS",
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 5, .opc2 = 1,
       .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
-      .writefn = tlbi_aa64_rvae2is_write },
-   { .name = "TLBI_RVALE2OS", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_rvae2is_write),
+   TLBI(.name = "TLBI_RVALE2OS",
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 5, .opc2 = 5,
       .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
-      .writefn = tlbi_aa64_rvae2is_write },
-    { .name = "TLBI_RVAE2", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_rvae2is_write),
+ TLBI(.name = "TLBI_RVAE2",
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 6, .opc2 = 1,
       .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
-      .writefn = tlbi_aa64_rvae2_write },
-   { .name = "TLBI_RVALE2", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_rvae2_write),
+   TLBI(.name = "TLBI_RVALE2",
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 6, .opc2 = 5,
       .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
-      .writefn = tlbi_aa64_rvae2_write },
-   { .name = "TLBI_RVAE3IS", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_rvae2_write),
+   TLBI(.name = "TLBI_RVAE3IS",
       .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 2, .opc2 = 1,
       .access = PL3_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_rvae3is_write },
-   { .name = "TLBI_RVALE3IS", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_rvae3is_write),
+   TLBI(.name = "TLBI_RVALE3IS",
       .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 2, .opc2 = 5,
       .access = PL3_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_rvae3is_write },
-   { .name = "TLBI_RVAE3OS", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_rvae3is_write),
+   TLBI(.name = "TLBI_RVAE3OS",
       .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 5, .opc2 = 1,
       .access = PL3_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_rvae3is_write },
-   { .name = "TLBI_RVALE3OS", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_rvae3is_write),
+   TLBI(.name = "TLBI_RVALE3OS",
       .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 5, .opc2 = 5,
       .access = PL3_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_rvae3is_write },
-   { .name = "TLBI_RVAE3", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_rvae3is_write),
+   TLBI(.name = "TLBI_RVAE3",
       .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 6, .opc2 = 1,
       .access = PL3_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_rvae3_write },
-   { .name = "TLBI_RVALE3", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_rvae3_write),
+   TLBI(.name = "TLBI_RVALE3",
       .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 6, .opc2 = 5,
       .access = PL3_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_rvae3_write },
+      .writefn = tlbi_aa64_rvae3_write),
+#undef TLBI
 };
 
 static const ARMCPRegInfo tlbios_reginfo[] = {
-    { .name = "TLBI_VMALLE1OS", .state = ARM_CP_STATE_AA64,
+#define TLBI(name, opc0, opc1, crn, crm, opc2, access, accessfn, type, fgt, \
+             writefn)                                                       \
+{ name, .state = ARM_CP_STATE_AA64, opc0, opc1, crn, crm, opc2, access,     \
+  accessfn, type, fgt, writefn },                                           \
+{ name"NXS", .state = ARM_CP_STATE_AA64, opc0, opc1, crn + 1, crm, opc2,    \
+   access, accessfn, type, fgt, writefn }
+ TLBI(.name = "TLBI_VMALLE1OS",
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 1, .opc2 = 0,
       .access = PL1_W, .accessfn = access_ttlbos, .type = ARM_CP_NO_RAW,
       .fgt = FGT_TLBIVMALLE1OS,
-      .writefn = tlbi_aa64_vmalle1is_write },
-    { .name = "TLBI_VAE1OS", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_vmalle1is_write),
+ TLBI(.name = "TLBI_VAE1OS",
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 1, .opc2 = 1,
       .fgt = FGT_TLBIVAE1OS,
       .access = PL1_W, .accessfn = access_ttlbos, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_vae1is_write },
-    { .name = "TLBI_ASIDE1OS", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_vae1is_write),
+ TLBI(.name = "TLBI_ASIDE1OS",
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 1, .opc2 = 2,
       .access = PL1_W, .accessfn = access_ttlbos, .type = ARM_CP_NO_RAW,
       .fgt = FGT_TLBIASIDE1OS,
-      .writefn = tlbi_aa64_vmalle1is_write },
-    { .name = "TLBI_VAAE1OS", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_vmalle1is_write),
+ TLBI(.name = "TLBI_VAAE1OS",
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 1, .opc2 = 3,
       .access = PL1_W, .accessfn = access_ttlbos, .type = ARM_CP_NO_RAW,
       .fgt = FGT_TLBIVAAE1OS,
-      .writefn = tlbi_aa64_vae1is_write },
-    { .name = "TLBI_VALE1OS", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_vae1is_write),
+ TLBI(.name = "TLBI_VALE1OS",
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 1, .opc2 = 5,
       .access = PL1_W, .accessfn = access_ttlbos, .type = ARM_CP_NO_RAW,
       .fgt = FGT_TLBIVALE1OS,
-      .writefn = tlbi_aa64_vae1is_write },
-    { .name = "TLBI_VAALE1OS", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_vae1is_write),
+ TLBI(.name = "TLBI_VAALE1OS",
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 1, .opc2 = 7,
       .access = PL1_W, .accessfn = access_ttlbos, .type = ARM_CP_NO_RAW,
       .fgt = FGT_TLBIVAALE1OS,
-      .writefn = tlbi_aa64_vae1is_write },
-    { .name = "TLBI_ALLE2OS", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_vae1is_write),
+#undef TLBI
+#define TLBI(name, opc0, opc1, crn, crm, opc2, access, type, writefn)       \
+{ name, .state = ARM_CP_STATE_AA64, opc0, opc1, crn, crm, opc2, access,     \
+  type, writefn },                                                          \
+{ name"NXS", .state = ARM_CP_STATE_AA64, opc0, opc1, crn + 1, crm, opc2,    \
+   access, type, writefn }
+ TLBI(.name = "TLBI_ALLE2OS",
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 1, .opc2 = 0,
       .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
-      .writefn = tlbi_aa64_alle2is_write },
-    { .name = "TLBI_VAE2OS", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_alle2is_write),
+ TLBI(.name = "TLBI_VAE2OS",
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 1, .opc2 = 1,
       .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
-      .writefn = tlbi_aa64_vae2is_write },
-   { .name = "TLBI_ALLE1OS", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_vae2is_write),
+   TLBI(.name = "TLBI_ALLE1OS",
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 1, .opc2 = 4,
       .access = PL2_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_alle1is_write },
-    { .name = "TLBI_VALE2OS", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_alle1is_write),
+ TLBI(.name = "TLBI_VALE2OS",
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 1, .opc2 = 5,
       .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
-      .writefn = tlbi_aa64_vae2is_write },
-    { .name = "TLBI_VMALLS12E1OS", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_vae2is_write),
+ TLBI(.name = "TLBI_VMALLS12E1OS",
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 1, .opc2 = 6,
       .access = PL2_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_alle1is_write },
-    { .name = "TLBI_IPAS2E1OS", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_alle1is_write),
+#undef TLBI
+#define TLBI(name, opc0, opc1, crn, crm, opc2, access, type)            \
+{ name, .state = ARM_CP_STATE_AA64, opc0, opc1, crn, crm, opc2, access, \
+  type },                                                               \
+{ name"NXS", .state = ARM_CP_STATE_AA64, opc0, opc1, crn + 1, crm, opc2,\
+   access, type }
+ TLBI(.name = "TLBI_IPAS2E1OS",
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 0,
-      .access = PL2_W, .type = ARM_CP_NOP },
-    { .name = "TLBI_RIPAS2E1OS", .state = ARM_CP_STATE_AA64,
+      .access = PL2_W, .type = ARM_CP_NOP),
+ TLBI(.name = "TLBI_RIPAS2E1OS",
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 3,
-      .access = PL2_W, .type = ARM_CP_NOP },
-    { .name = "TLBI_IPAS2LE1OS", .state = ARM_CP_STATE_AA64,
+      .access = PL2_W, .type = ARM_CP_NOP),
+ TLBI(.name = "TLBI_IPAS2LE1OS",
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 4,
-      .access = PL2_W, .type = ARM_CP_NOP },
-    { .name = "TLBI_RIPAS2LE1OS", .state = ARM_CP_STATE_AA64,
+      .access = PL2_W, .type = ARM_CP_NOP),
+ TLBI(.name = "TLBI_RIPAS2LE1OS",
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 7,
-      .access = PL2_W, .type = ARM_CP_NOP },
-    { .name = "TLBI_ALLE3OS", .state = ARM_CP_STATE_AA64,
+      .access = PL2_W, .type = ARM_CP_NOP),
+#undef TLBI
+#define TLBI(name, opc0, opc1, crn, crm, opc2, access, type, writefn)       \
+{ name, .state = ARM_CP_STATE_AA64, opc0, opc1, crn, crm, opc2, access,     \
+  type, writefn },                                                          \
+{ name"NXS", .state = ARM_CP_STATE_AA64, opc0, opc1, crn + 1, crm, opc2,    \
+   access, type, writefn }
+ TLBI(.name = "TLBI_ALLE3OS",
       .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 1, .opc2 = 0,
       .access = PL3_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_alle3is_write },
-    { .name = "TLBI_VAE3OS", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_alle3is_write),
+ TLBI(.name = "TLBI_VAE3OS",
       .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 1, .opc2 = 1,
       .access = PL3_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_vae3is_write },
-    { .name = "TLBI_VALE3OS", .state = ARM_CP_STATE_AA64,
+      .writefn = tlbi_aa64_vae3is_write),
+ TLBI(.name = "TLBI_VALE3OS",
       .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 1, .opc2 = 5,
       .access = PL3_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_vae3is_write },
+      .writefn = tlbi_aa64_vae3is_write),
+#undef TLBI
 };
 
 static uint64_t rndr_readfn(CPUARMState *env, const ARMCPRegInfo *ri)
@@ -9201,7 +9260,8 @@ void register_cp_regs_for_features(ARMCPU *cpu)
                                R_ID_AA64ISAR1_SB_MASK |
                                R_ID_AA64ISAR1_BF16_MASK |
                                R_ID_AA64ISAR1_DGH_MASK |
-                               R_ID_AA64ISAR1_I8MM_MASK },
+                               R_ID_AA64ISAR1_I8MM_MASK |
+                               R_ID_AA64ISAR1_XS_MASK },
             { .name = "ID_AA64ISAR2_EL1",
               .exported_bits = R_ID_AA64ISAR2_WFXT_MASK |
                                R_ID_AA64ISAR2_RPRES_MASK |

-- 
2.45.2


