Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D885AE7717F
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2024 22:50:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKQ5G-0007Ao-GH; Sun, 08 Dec 2024 17:49:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tKQ5E-00079k-9H
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 17:49:00 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tKQ5C-0006EW-Md
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 17:48:59 -0500
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3ea49150430so2052430b6e.1
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2024 14:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733698137; x=1734302937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9z7LwVl4Onw4FA8ZAnPozMScnx/mfNwPcZbWnSZkFg8=;
 b=SBrPCG5HeCesc+hNKFz74NLZm2XuvZe067b+EyXcIHs1JJJVsKxrIdJs/tdlzc+t0E
 tWGx84VcZsbgBpuMewDTB9zwiS1dvZ3fDIZxlnFWrsSbNXxCdtQhx5ePSlT3K6EETjey
 oGB1DWuHmdIcQR+Ljm/EPA/0VUdmbdgxQo+0HGNGofiGg//6h4rIBwbQ+so+7eFfH7KX
 RE8nmxglpdU/W31rEuRUvNpjcYTU+2j8j0gt7B1Nqtt19XNTQwL0yJFTqwMzo0oj54/i
 yd0HMIvLR7b+fwZlLFli3ez8rlFlNTIUiCp2g5Edzm1558s3GlFSGEmnHtMMUZVSnG72
 GSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733698137; x=1734302937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9z7LwVl4Onw4FA8ZAnPozMScnx/mfNwPcZbWnSZkFg8=;
 b=i3u+fOqIyvhRHw+M27b4JAPT//9KMNToGbNDzESMhcD6E81BcS5A7UWo0ehngeD54Z
 ocMMxgMTk3A2GY33KTIeXuG85g+/zflDOOUE5VXMZ6SCGQmRlBH+aNSY7hZfN6Kv4HCa
 TfmfsRoOUE2ZuSFayA6lKeADtRK6LnpWF3xx6WvPxBpXqW0GpsHAuNVgV6OTQFPCi3Pa
 UJT0SoXQv3IEMDAh+Ar8UbqKcOV1VxSBBsZ5VEx+BA5sbmXunsaICkSUCq7LutJT+ljU
 UHWC5XSiW6k/pVwF7QGq5G1Bvyf6IWSeiDC6HkcPccGvQnnF/vXoemBflzLYw9kqpafb
 4gSQ==
X-Gm-Message-State: AOJu0YyVhQDIQP4Uqha8Yh3KZPvolrSg0XSwrAjXhUdQ3qCFgrnETpvR
 o5lyA3RCP5h1Vf3h9F+u4GKSexSs4eE1ZIYKEiup63RfikPXq70RSM42syRmKUFlFdBNfQBaC3S
 czyOCNA==
X-Gm-Gg: ASbGncsAvUu7vcQHr9i2jQqPWVWttRL3O72Cji1Zv1L37aZ+XxT2NdFQS6cvkK8CVCH
 AqoYTZ2cplz8DaVxyZ5Fc3A6ClKjWfnOzlDEGJTQjcVAMw3ZMi2q5Z6Cfg4wBV56Jn2tKTr1FqQ
 VhdkHery6hDDIQkk+Fjx3FnAuIG1ZQhuq+KHh8VrH0Em/jv0uw1WBOtwU30F6FymMOHPXHDWOC9
 QHJwu4sYQdQMqaYzeZSmgvs54lIWLKTNrI6tvAJ2y9Soe2CCxuBdSnwPk9zcu/WY2U6+CH/Wdze
 nJ8Kq4DboZr+bfCxvZElP0DvRDViGRA5SpeV
X-Google-Smtp-Source: AGHT+IE2cTGNOpPGPhRoDi57fxWCGdjwwuyWqBIVAYRUxqrCyrMjRQXFY42m+YSWKOphxAFfXx8/9A==
X-Received: by 2002:a05:6808:251a:b0:3ea:4aad:a889 with SMTP id
 5614622812f47-3eb19dd0645mr9668297b6e.26.1733698137650; 
 Sun, 08 Dec 2024 14:48:57 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dc497ee8fsm1925198a34.39.2024.12.08.14.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 14:48:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: bcain@oss.qualcomm.com, peter.maydell@linaro.org,
 mark.cave-ayland@ilande.co.uk
Subject: [PATCH 09/17] target/hexagon: Use float32_muladd for helper_sffms
Date: Sun,  8 Dec 2024 16:48:36 -0600
Message-ID: <20241208224844.570491-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241208224844.570491-1-richard.henderson@linaro.org>
References: <20241208224844.570491-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
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

There are no special cases for this instruction.  Since hexagon
always uses default-nan mode, explicitly negating the first
input is unnecessary.  Use float_muladd_negate_product instead.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hexagon/op_helper.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 7d459cc6f3..aa5ab4a31f 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -1208,10 +1208,9 @@ float32 HELPER(sffma_sc)(CPUHexagonState *env, float32 RxV,
 float32 HELPER(sffms)(CPUHexagonState *env, float32 RxV,
                       float32 RsV, float32 RtV)
 {
-    float32 neg_RsV;
     arch_fpop_start(env);
-    neg_RsV = float32_set_sign(RsV, float32_is_neg(RsV) ? 0 : 1);
-    RxV = internal_fmafx(neg_RsV, RtV, RxV, 0, &env->fp_status);
+    RxV = float32_muladd(RsV, RtV, RxV, float_muladd_negate_product,
+                         &env->fp_status);
     arch_fpop_end(env);
     return RxV;
 }
-- 
2.43.0


