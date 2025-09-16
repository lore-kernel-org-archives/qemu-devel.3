Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562C2CAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 14:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyWdB-0001sX-6h; Tue, 16 Sep 2025 10:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWan-0006BO-AO
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:37 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWaU-0008Kd-QH
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:31 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2445806e03cso61704735ad.1
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 07:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758032572; x=1758637372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j4ZSa8lN9EtAmbPaq+Y1Gn9/4VVymrm3E6UBOKY/KQw=;
 b=zmtHak7ZVnd9WepkYPXtH3gVcWy7i4NqseuMEetP8h/cJegDuseGYGjAXaGIsZvE8G
 DLwCUMVpLjjaerx5xKxQdY++YqeWvkht/MdxUpEnLijIfylliwcGcPyWXVJZevuQCkaM
 l/QESlC49q9gwP8fMnRzZSfbIJtTB6HmV/xQu0+9q5RBXkGnAEwaYGUN0jVQi90a/6kZ
 L4SLwMgSeG88f/E1DYcV4RrtOHo9KVXQoJQS4raVdQ2vX7+dKx5jkNTREl3Nz3dKZ4Ty
 HGHT/rk4NxZDXb5Krm3lWi7KYNM/An8bh6+kupM3X1ihwKTw6yhtFjoJArr83WXD9B/8
 629A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758032572; x=1758637372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j4ZSa8lN9EtAmbPaq+Y1Gn9/4VVymrm3E6UBOKY/KQw=;
 b=Ni5ji42a+XUmOf6OSmSusmI1kNlHiYO1Pmj64d/AF0EpSCdZpwtbAABuGcaHEKKeEq
 vym/2PZKG6xbdQSIZ7Y/L/BmU6KvzqxHP8GMwuML314N8prYd5MqhNa/iqilGegfBpPQ
 DbPvbBxzqV7hKZiZuT0un1b4OeltEq2HL5q7GEt/cX+Nnpp/Zlb2rL84rQ3U5CX2BcBV
 EQMnMeICainrSSEsKXJPqoQk8WhWtsBfgfEWFxfDYIdJf+RnrtyjuijvXP6ma65eLDV0
 GXL+5haVVmNGN5fhPzpk+nIeJifVQXNwEDc9Q1EHWRKfapuWa5WLhBFnP6Ax6sgwVMAd
 PPxw==
X-Gm-Message-State: AOJu0YySDNnLhmsPxuH7pJqp/QWUekhI/PtOpRZvv+rQonwfRV36Yq7X
 FGo476rDm2VzC/H5FTVxFn1AhvpWxF7IBOi/rlc3f12LTriGzfIw/3sUUg/qniDAVkl6AixVbF+
 6wZHR
X-Gm-Gg: ASbGncumKE+/V7mSDOGQT+1453vtvQvfpsEw/fTiDlZmBFLeDVdhA3rWa7UIuQOtChD
 PqCzZXHh8Ar5P8fKz04nIunEIH/sIVqeaKpe470dXXutgwdolOHY1Px/Nm04CJuLMUY8oRXASiY
 0FFaHXEWyN1HAomNEOHHGUmL8BtLi8jHxR5vnScYuR2sVWcEPV2V+e/Q/9hNe+dXUkC5/Tn8h+c
 JByFfkXv9zn0VkVH27O+g3Nv2K6G//y1NS5j1papEVF0IUJPwV5U0S4gm+rqen/yjj7F0g5vs6G
 uyQLALi+IxSeeT1LJNtlXA9Xjnhjpf+a/RiJ4eMRurQnJcUMC9Ef3/oIOS5PvMe1IWaMWEV8J28
 G8SouOw4RXXWLv3sYz1BrNyz8cgSE
X-Google-Smtp-Source: AGHT+IHZJn4+KP+mPBQ0Yw8XHb9RODBNWjD9hgnnpRjjVATbNrYu825GhBWH6q1IehLr7oY3aXaidA==
X-Received: by 2002:a17:902:cf12:b0:24c:da3b:7379 with SMTP id
 d9443c01a7336-25d248c9d8cmr208336755ad.16.1758032572585; 
 Tue, 16 Sep 2025 07:22:52 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2651d2df15esm73459905ad.45.2025.09.16.07.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 07:22:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 16/36] target/arm: Rename CP_REG_AA32_NS_{SHIFT,MASK}
Date: Tue, 16 Sep 2025 07:22:17 -0700
Message-ID: <20250916142238.664316-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916142238.664316-1-richard.henderson@linaro.org>
References: <20250916142238.664316-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Rename from CP_REG_NS_* to emphasize this is specific to AArch32.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 3dc4c9927b..7ebe404163 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -175,15 +175,15 @@ enum {
  * add a bit to distinguish between secure and non-secure cpregs in the
  * hashtable.
  */
-#define CP_REG_NS_SHIFT 29
-#define CP_REG_NS_MASK (1 << CP_REG_NS_SHIFT)
+#define CP_REG_AA32_NS_SHIFT     29
+#define CP_REG_AA32_NS_MASK      (1 << CP_REG_AA32_NS_SHIFT)
 
 /* Distinguish 32-bit and 64-bit views of AArch32 system registers. */
 #define CP_REG_AA32_64BIT_SHIFT  15
 #define CP_REG_AA32_64BIT_MASK   (1 << CP_REG_AA32_64BIT_SHIFT)
 
 #define ENCODE_CP_REG(cp, is64, ns, crn, crm, opc1, opc2)   \
-    (((ns) << CP_REG_NS_SHIFT) |                            \
+    (((ns) << CP_REG_AA32_NS_SHIFT) |                       \
      ((is64) << CP_REG_AA32_64BIT_SHIFT) |                  \
      ((cp) << 16) | ((crn) << 11) | ((crm) << 7) | ((opc1) << 3) | (opc2))
 
@@ -214,7 +214,7 @@ static inline uint32_t kvm_to_cpreg_id(uint64_t kvmid)
          * KVM is always non-secure so add the NS flag on AArch32 register
          * entries.
          */
-         cpregid |= 1 << CP_REG_NS_SHIFT;
+         cpregid |= CP_REG_AA32_NS_MASK;
     }
     return cpregid;
 }
-- 
2.43.0


