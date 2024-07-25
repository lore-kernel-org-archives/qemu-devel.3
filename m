Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71738C52CD8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Lv-0008Qk-CC; Thu, 25 Jul 2024 19:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Lc-0006by-F2; Thu, 25 Jul 2024 19:58:16 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8La-0001WW-Q8; Thu, 25 Jul 2024 19:58:12 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2cb81c0ecb4so270693a91.0; 
 Thu, 25 Jul 2024 16:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951888; x=1722556688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5GNS2j3XNaM8oKCl7qkg2CEBwzqIzI4KrTHDi2GhMic=;
 b=gL3SlqL1qfI04uumF7yhueeIq0B3vDXNTCv57bDFaYQfwLRbHvcAUxbwMpHQ50ufqY
 B48dW9VL+e1ASFeaGSR2U+i+GRaYp6oR9bnrdxS7TP2qFWMwtUoaisvQs6sTGkCmPsyG
 qNdyPyQ+mcd6UjiVA4lJODAe6aQb18WFd391gJ+NLGLnX9kLHJw6UhqeqwfE2HflCaFX
 m+lZsMACSDfPzKXGofV5rGWfP56mqptKAxuIXHmpZrrvD/joiuM5EdDdbRGYU4WavGu/
 fIG29UjDiAEX/4Uz4M+1dkTMHt8emrl1T/agPJd0BvReG300/dHYugxP+DZEmgiphnrO
 5ZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951888; x=1722556688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5GNS2j3XNaM8oKCl7qkg2CEBwzqIzI4KrTHDi2GhMic=;
 b=VtSHpZbTPupjPU1gzh5kkwLWwOJPVmggvEXnQyj7MZBWgJ5ozMQu0/9Yn9mEUYdC3a
 6OBuECyVKJWC9jCxkvqFfFmVa8c5oxhmyypECH44lXjxr0rP4/VAYYwFpSz+swOCK2g0
 KwOVTnDIjsld3vkytGRaaMNzLpKlBeLMxhgW9XQbLqzlUKqasAviObKgjUL0AYSSOSvy
 qs8roUf9RDR30sVBD05/xdkTL8KKm0hhP2VuqoGnpZ4y5+LLVDpnu2wOp9vu0pefnOpU
 ZtZQQraXCR1KpFVnZlQcpS1l24yYnfGyp0hh5xK8pODpLspntneSoFRk7CLqgczd8KmX
 WmGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1avvxywHM8EshZKXAvimXbsBvxDw5XoCZPL9fu1Qm1t6Y+LfF/DbFvVYeonHE/v/unpr9+4TeiVAzfbpmRbClIdPG
X-Gm-Message-State: AOJu0Yw2iaSvT/LnOppRyDysEeuynKorZrJO6rQSVGWH//zi3DsdpUcv
 6wsODjCOlHMWlunDcEAAprEdEJHKBnAtmtVK3IFgZd5D9O3Bbyji4JQFbw==
X-Google-Smtp-Source: AGHT+IE8dqJq3Sa9Y3znaEZMEvobdnC1A+XcOG+fg4lXqqRGZxr8xZJwQ77Qi2lMRxXZMkY+Pic+vA==
X-Received: by 2002:a17:90b:1d12:b0:2c7:d24b:57f with SMTP id
 98e67ed59e1d1-2cdb9466810mr10535138a91.19.1721951888577; 
 Thu, 25 Jul 2024 16:58:08 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.58.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:58:08 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Chinmay Rath <rathc@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 62/96] target/ppc: Move get/set_avr64 functions to
 vmx-impl.c.inc.
Date: Fri, 26 Jul 2024 09:53:35 +1000
Message-ID: <20240725235410.451624-63-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Chinmay Rath <rathc@linux.ibm.com>

Those functions are used to ld/st data to and from Altivec registers,
in 64 bits chunks, and are only used in vmx-impl.c.inc file,
hence the clean-up movement.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/translate.c              | 10 ----------
 target/ppc/translate/vmx-impl.c.inc | 10 ++++++++++
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 46aabce82b..71513ba964 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -5558,16 +5558,6 @@ static inline void set_fpr(int regno, TCGv_i64 src)
     tcg_gen_st_i64(tcg_constant_i64(0), tcg_env, vsr64_offset(regno, false));
 }
 
-static inline void get_avr64(TCGv_i64 dst, int regno, bool high)
-{
-    tcg_gen_ld_i64(dst, tcg_env, avr64_offset(regno, high));
-}
-
-static inline void set_avr64(int regno, TCGv_i64 src, bool high)
-{
-    tcg_gen_st_i64(src, tcg_env, avr64_offset(regno, high));
-}
-
 /*
  * Helpers for decodetree used by !function for decoding arguments.
  */
diff --git a/target/ppc/translate/vmx-impl.c.inc b/target/ppc/translate/vmx-impl.c.inc
index 152bcde0e3..a182d2cf81 100644
--- a/target/ppc/translate/vmx-impl.c.inc
+++ b/target/ppc/translate/vmx-impl.c.inc
@@ -14,6 +14,16 @@ static inline TCGv_ptr gen_avr_ptr(int reg)
     return r;
 }
 
+static inline void get_avr64(TCGv_i64 dst, int regno, bool high)
+{
+    tcg_gen_ld_i64(dst, tcg_env, avr64_offset(regno, high));
+}
+
+static inline void set_avr64(int regno, TCGv_i64 src, bool high)
+{
+    tcg_gen_st_i64(src, tcg_env, avr64_offset(regno, high));
+}
+
 static bool trans_LVX(DisasContext *ctx, arg_X *a)
 {
     TCGv EA;
-- 
2.45.2


