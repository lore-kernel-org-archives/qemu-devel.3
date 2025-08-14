Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70783CA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXe1-0003Qn-3f; Thu, 14 Aug 2025 09:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXcp-0002Ec-Ng
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:04:13 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXch-00058B-UU
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:04:11 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-76e2ea79219so1116859b3a.2
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 06:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176634; x=1755781434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QDW+HxP2J6pK8IxGshUeq+u65rBy5XdnKzmGA8gxmkE=;
 b=cgrCWCRGZdA4UnKTje3Q2RycP6YYUwCEVMsCzjwTSx9WJqgE2Zk6O27le0sg3DqJp3
 iqR7JImTxbKgEcfVDqk8tTVW7udRzDz1JNCoh8D8Hqx9UoysU37I7vzIdseuCx0RBXTe
 JMNWTVTVbta76HY6xTi/fT8mx0kJIJYQfb275Py4h82OTO0uPjpUuxWNshwhWVev/tqq
 b+HUC+Ce0B92QirjUGGDFWdpqDXu4vKGTDMyLymjcruHJ6nlbxD5ocM4xUAoSi2Wu4vO
 BPWAUFPDiu7hQdoYrN58CTIwp+zGrZHp4DO73oNHGzysU+pzVGjwpgfCuulr+2Ejmtud
 EVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176634; x=1755781434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QDW+HxP2J6pK8IxGshUeq+u65rBy5XdnKzmGA8gxmkE=;
 b=fwIYADjwHg3d4D2u8Mx2pPkV7Vh00Hg8gvgguDBFxrCTkOxHBLaJacpP+lT+fbpIRG
 x0iVOq18pJI4pKqPsdLbsJ7HuO1NbUlKteLEuy5PVKAFXeL2T+ifacE5UzySSls9YUPp
 i4naBLQJ+/YOyUZ/Q7w16Xoo5NyMaOdvLqaV+x2rzBs2S9+/qAoEGN3tvwoTBkj0Wohy
 Gqqg67Pur5TFxgiyniIKEN+M6pxei0Vz4eHA7q2HXHobzI1ztiPIOonQMqDG5gpJCOx0
 WWalLNg8BuC1u58G8gAOEX3angFvGa5Y148ryuLecuYhtfdCjdqUbT5EvteZ7wscJBCg
 6PVQ==
X-Gm-Message-State: AOJu0YyuLSYrtMm2nkZu5NoHZtQ7rGgywZfusnKa6vdveVxCNKdF0aWW
 TJ6K2q7IJvA/UZ7D3Y5CNTDQiG5MRzl9N5UrK8q3TLnGN8pknTg0gJx4+yaTIDca8We8jm/BIXw
 ZJ3Ih2vs=
X-Gm-Gg: ASbGnct2mhJkme0btjbnxKpYCtA0lrN3qgb6iHaYpRK9Pc17v3umf9lXHZ4rsgGmfU4
 oRafCHhNnuRD0LOgzpGl80JIYEFzD4s3Fw6K3L5oPLgS/OEtgN37m/q2kxHW6dhOLXOXSCD634w
 BCRVqkZ5wLVAWEH6ZQzEj62iEX+DwT0NdGw9BlzcE6fr+qfnxSw9My6ZduQesIWbwPgKfo4CSKt
 w/tGIbE/zNJ2c8GveCZIbTVE/jryo4xI15up+rWffFUe7AY0VJZ9m6e+6Wvnl4urOvZ2SQ7N0Th
 MOr54EwJMW1V0bujIqq5bnQEXAfxrUI6QfN2ZtyGcwTISPX8OupeTW2nVkCGm1IXLxsZCY5HFLB
 g1PsJpPM4t3kv7rfEgNON2DcYl7gydMPPgoLGWJqhe6d4JkY=
X-Google-Smtp-Source: AGHT+IGEamxMvrYocxet/aTZQP6ijcQhpmNxzVnDf0Zka+EgWDe933VyF8cqARSCNxWakiORI9P4Ig==
X-Received: by 2002:a05:6a00:1883:b0:76b:ef8f:c277 with SMTP id
 d2e1a72fcca58-76e2fd0f872mr4760406b3a.11.1755176634307; 
 Thu, 14 Aug 2025 06:03:54 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce6f6fesm34480631b3a.26.2025.08.14.06.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 06:03:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 51/85] target/arm: Add syndrome data for EC_GCS
Date: Thu, 14 Aug 2025 22:57:18 +1000
Message-ID: <20250814125752.164107-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/syndrome.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index c48d3b8587..bff61f052c 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -63,6 +63,7 @@ enum arm_exception_class {
     EC_MOP                    = 0x27,
     EC_AA32_FPTRAP            = 0x28,
     EC_AA64_FPTRAP            = 0x2c,
+    EC_GCS                    = 0x2d,
     EC_SERROR                 = 0x2f,
     EC_BREAKPOINT             = 0x30,
     EC_BREAKPOINT_SAME_EL     = 0x31,
@@ -83,6 +84,23 @@ typedef enum {
     SME_ET_InaccessibleZT0,
 } SMEExceptionType;
 
+typedef enum {
+    GCS_ET_DataCheck,
+    GCS_ET_EXLOCK,
+    GCS_ET_GCSSTR_GCSSTTR,
+} GCSExceptionType;
+
+typedef enum {
+    GCS_IT_RET_nPauth = 0,
+    GCS_IT_GCSPOPM = 1,
+    GCS_IT_RET_PauthA = 2,
+    GCS_IT_RET_PauthB = 3,
+    GCS_IT_GCSSS1 = 4,
+    GCS_IT_GCSSS2 = 5,
+    GCS_IT_GCSPOPCX = 8,
+    GCS_IT_GCSPOPX = 9,
+} GCSInstructionType;
+
 #define ARM_EL_EC_LENGTH 6
 #define ARM_EL_EC_SHIFT 26
 #define ARM_EL_IL_SHIFT 25
@@ -351,6 +369,23 @@ static inline uint32_t syn_pcalignment(void)
     return (EC_PCALIGNMENT << ARM_EL_EC_SHIFT) | ARM_EL_IL;
 }
 
+static inline uint32_t syn_gcs_data_check(GCSInstructionType it, int rn)
+{
+    return ((EC_GCS << ARM_EL_EC_SHIFT) | ARM_EL_IL |
+            (GCS_ET_DataCheck << 20) | (rn << 5) | it);
+}
+
+static inline uint32_t syn_gcs_exlock(void)
+{
+    return (EC_GCS << ARM_EL_EC_SHIFT) | ARM_EL_IL | (GCS_ET_EXLOCK << 20);
+}
+
+static inline uint32_t syn_gcs_gcsstr(int ra, int rn)
+{
+    return ((EC_GCS << ARM_EL_EC_SHIFT) | ARM_EL_IL |
+            (GCS_ET_GCSSTR_GCSSTTR << 20) | (ra << 10) | (rn << 5));
+}
+
 static inline uint32_t syn_serror(uint32_t extra)
 {
     return (EC_SERROR << ARM_EL_EC_SHIFT) | ARM_EL_IL | extra;
-- 
2.43.0


