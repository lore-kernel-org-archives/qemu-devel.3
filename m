Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 271BFCD4851
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPRz-0006Pw-KY; Sat, 16 May 2026 20:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPRt-0006Ax-RP
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:33:44 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPRs-0006mo-BZ
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:33:41 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-369002b26f4so448563a91.3
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778978019; x=1779582819; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nTIDtuillPXckV86mcaM2Utf4vRJVw8yqCVUR2w2Jkg=;
 b=sH/neINZE9bYGzCcPFMSt6uKEvC6UmUCyQss22gvWWRFYeiPnYjLpbLB0gsYAxPj+u
 kyKtwcUEMW4qiP3ejP9ufF9nuPLYBjnWoIqdxTi5zNQlSh9WbrI6NKuGaLHOIeS0nAWC
 EoBtZi8bnHQrgvhRKklQhldGGeEgPhjqtHpwTw5Da5Gq15A2t4yZcRBFKrRndUAvoK4B
 G90hUj99IEZ3rkwgOovC3D+mPgkFjZfrDf8X5oVY0vlRMKQLU+ygFqqvvuYsz+njLIEp
 Y7cyIhHE6Q8wtZfPvszWObFwLym5A2O5B2JMS2XgsquAlM8d7RKZthi/eCKbnKYZSu3/
 SNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778978019; x=1779582819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nTIDtuillPXckV86mcaM2Utf4vRJVw8yqCVUR2w2Jkg=;
 b=Ar42TFc7dEudWQQfuATtsOxWRyDw85CRiIHaI3/EVXjX+HOQwNB6gU+6Pb7LedzPz+
 QTrf95mrxHnOcouj4OrKbiarE9DvNj17k7p2q28Q1jelr671j3VPMhZmcNf78uBY4vCa
 B5BKuJfaOu7VOz752+Z5UYnUQMHNMgokbCX/Gx47LSPlo3Z5C66xOyRP3wxQQhKqsSdQ
 13dIi5EXSypXrS8vouxOZ+syGgFQt4eQbByPCUZBERbXjOWOU+QTKTOh4FRRe6yALoR6
 /eesnFkhIFE6rFqbKusnsG2pPIZJeChzVg3X3eTTZEbUIQBip9en5OAyJp+o7Jxml30O
 0B2w==
X-Gm-Message-State: AOJu0YzxqIu897Qv4cb5WQf6uKs5A0a7Vn+jNB1ccvizVSphYPa2OaLH
 x01/JtMhpYGwshnARmELJnB59uBgVoAj3/soRGAKDI/BwcNp8AO7SSZH4LaSbbGNhNw0Uw71Zl8
 H1FT1
X-Gm-Gg: Acq92OHggwdQtk1qWXzmo0D48p3BnV2HRJNNxOZgwgL4U4gp+ovHua4IgaEjZV63uLQ
 ySqFMD3IuwUlBjZ4s4Xl2mBkdw4SjyH/U+nyP+yvW7YuF+57PPPWYMutBDMMDYc9SSGfEnIt5mO
 tDXADEbwcfc8WGhXxGVvDwO/MkA3518BbZMh21bP0TLbYZfiHs888sY5YWraqX3w+QmGBSa62pk
 vgjrDiJPry9JZK5pQ+YE4nlw7fHX897z7APA4spG84uEyRy/uiUVgcY0eppLHZKvEL49QgQJYBn
 p+uYSwEQFlMaaI2CEx+EDugcgpMlXYkLVlKd7LSI+wkxL4MRDYuaiDTYNkzE9V8YcwGya1rUa9e
 NcQ4X8mRKT4l/38ifHBTs7ObEdvk8yaoiyly6keC0HXpK9azOd6ygJidguCcHQ9/PCKL8BPu5yo
 Fw29E8hXwPQuY4sx8gBUPQzDAeT+HG
X-Received: by 2002:a17:90b:48c4:b0:35f:d56d:1c45 with SMTP id
 98e67ed59e1d1-369519cc92amr9537792a91.12.1778978018631; 
 Sat, 16 May 2026 17:33:38 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82da93df0dsm3010559a12.19.2026.05.16.17.33.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:33:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 40/63] target/arm: Enable FEAT_FP8 for -cpu max
Date: Sat, 16 May 2026 17:29:39 -0700
Message-ID: <20260517003002.321430-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpu64.c        | 6 ++++++
 docs/system/arm/emulation.rst | 1 +
 2 files changed, 7 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index bc866c5a67..8d0c057902 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1391,6 +1391,12 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64SMFR0, FA64, 1);     /* FEAT_SME_FA64 */
     SET_IDREG(isar, ID_AA64SMFR0, t);
 
+    t = GET_IDREG(isar, ID_AA64FPFR0);
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8CVT, 1);    /* FEAT_FP8 */
+    SET_IDREG(isar, ID_AA64FPFR0, t);
+
     /* Replicate the same data to the 32-bit id registers.  */
     aa32_max_features(cpu);
 
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index cf8771d541..b6f0ca9351 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -74,6 +74,7 @@ the following architecture extensions:
 - FEAT_FHM (Floating-point half-precision multiplication instructions)
 - FEAT_FP (Floating Point extensions)
 - FEAT_FP16 (Half-precision floating-point data processing)
+- FEAT_FP8 (FP8 convert instructions)
 - FEAT_FPAC (Faulting on AUT* instructions)
 - FEAT_FPACCOMBINE (Faulting on combined pointer authentication instructions)
 - FEAT_FPACC_SPEC (Speculative behavior of combined pointer authentication instructions)
-- 
2.43.0


