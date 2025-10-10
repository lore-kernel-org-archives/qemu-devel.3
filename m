Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C57CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:21:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Cpx-0006q1-4z; Fri, 10 Oct 2025 09:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cps-0006cX-OL
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:05 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CpB-0003wL-As
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:02 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3ece1102998so1237658f8f.2
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101572; x=1760706372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=F8deSxcO+Ly74Rq205FouZcpmRk2eTbvPunc2KKPDxI=;
 b=mFVjeOUPIbZodv8UGrZDfCwRF2Jv/DVX6EEQH8RncvQkLtUP9IGxDs6i3rAogecuZV
 7JEmdXXVKHcjlmNBiMFl7YJu87RSM+VJ862ejkenhN10V1E52HebITOGTMKqskf9j2zj
 MVnjl2M51NzjP0PJO/09cKqZZXAe+o1iwYoErlEd5BjboZCHjcDB9KqRgDMbtF/fEl2l
 hHIBAZIzv8csA1Di9tEosjmedhklVfZHKgFn/2icWilmNmjj9nvxm6Ok1CEDHe3Tw408
 pP9jFL8CAt2dWXcSxqJYNy5IGUDue1x7TX765/QsgURSVXPwMuOHo6q5eUJ/inoQWa/y
 SuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101572; x=1760706372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F8deSxcO+Ly74Rq205FouZcpmRk2eTbvPunc2KKPDxI=;
 b=v3Tzyu3hCOHSeKwoHrXNo3/fRLKRr+A++YOtDiNUANKo81t0UDrv6+wbi796enGCTZ
 UhYBfQkfpBTGDWFt3fzBUp0SP5hX7B1LnYbX6vN7/YlS6R4HTBh5xC0Mw+GZMnHqAYnN
 CC+YghF5Aou2kzRQ4oRdlmtKfpvJ8fMomdG2o22tFGw6jaPjtIH9MU8cZ78R4CDXvnOS
 sK9Y/y1K8cEKZlSx9o4dEOSNw33LchD0Wr/IqeUTcJ2bU0nbmMz28JiyzXmzgV9q7KfQ
 CBcn8iH317y1Ulj+zf1yL9MOA6teJWGiG2rWd+sispeubI6wMNhjlOdtMH28D6WF2ull
 fTIQ==
X-Gm-Message-State: AOJu0Yz5hS4wl35WO1wyiFVoYWeb5gQTAPWlajdyMeRbxF7tdn7ly3WA
 s/MlF8t2d6Z/QklFP8HeyO1SVYXmOYM4dY0KijwF1te80dF67hqgaVxv7JcQ9lPsa4zFK4DT8d6
 luW5m
X-Gm-Gg: ASbGncvjlphiCm08BALkAndPLytIvAfAj6ScdyPA+PPBFKPhjbEHxKU8KBQUD52f5ST
 7nXFrXf7sFwArodyBThH+4thfbE3URVKXlWkOQCkcjO4u4+9mV1GJSueVbhcRKNIF3bdOkdpsfs
 KskJua7esw0XegtwywKeBKLaB3P+vNEkZlPMwv5hsWyPmUZdRoAWv6GXMNvQuCje1LffYgUn2jf
 4g1asiFvBPttpfmioZaHowYRAyvhakfPGmy4j9w8LhmUBCy/6GZsVpgUhieJemU6jQyeaDZ1+X1
 SdVAOaTiayLzmptjlFq/gRy0FIW3r2QHXMh6vFDrb+SzPFumjbVBZHkqm7P+ghdtiZZ6Rr//T50
 gEmtZv6EKb7wBwd3NhuAmaAkDxBjI9l7bFNz9eqZ/B+EWskcTKjj6EJnyaklreQ==
X-Google-Smtp-Source: AGHT+IGVbc2ubU52zcSKaoqja05rMaGDvjSKi9BexLuJ86VitMosBSwRjEngYxw0RUlWTA/EGtecpA==
X-Received: by 2002:a5d:5d03:0:b0:425:8539:ed8e with SMTP id
 ffacd0b85a97d-42667177e89mr6918645f8f.23.1760101571878; 
 Fri, 10 Oct 2025 06:06:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/76] target/arm: Add syndrome data for EC_GCS
Date: Fri, 10 Oct 2025 14:04:48 +0100
Message-ID: <20251010130527.3921602-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-38-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/syndrome.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index c48d3b85871..bff61f052cc 100644
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


