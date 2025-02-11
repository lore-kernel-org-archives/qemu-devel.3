Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42FC8C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:35:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht7b-0003BP-LT; Tue, 11 Feb 2025 11:28:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht6O-0007AU-LN
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:27:13 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht6I-0003hh-KW
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:27:09 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso39890945e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291224; x=1739896024; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=G2A5EbMbQV8gzuPjhCpb9Fz8igGlo7PY3unGUhiHP+o=;
 b=Kx9gOcpiV9IExyd9eLP1Pg/so1OJFhcoDuWzAtzSM6r29g/WZQAPpwAn46fgtOeTUw
 bnAVtmjY7KTfeLr4bCqX0fnlSvAzd/3I69tXXsm9cELie3seEhFrJnU45rxl2hczpA0T
 aqHnmIG+OsTfYs9vU4EtpZOsfP73z1ly3KC8NjcwtQ1YFkZfQP+iJsag9IUJEplhPAQf
 0yhaYszN4ISUCVxuhn/DLRUjumPVpRsDQu9DKzQ2A7MxmEMMwiYAw4oco9m9Eo+Kf7sC
 gHKa0RwrgbRtoSMd6+9J1oUseBKyzD4A1+UbxFDZJ4ems24nnSsAKxCd14V2EdXml97D
 zchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291224; x=1739896024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G2A5EbMbQV8gzuPjhCpb9Fz8igGlo7PY3unGUhiHP+o=;
 b=RMU7AzfQiCrN+DQ8/H7ACoS8MUigc3cLjZWM97fexNDMSXY39SZeVHLv9/D+P2t5bq
 ZKzvIpv19wbNVtmv0u/Z1SbNHwrJUFJV7m4FKkPLpU8HOSmk3US9pwSn2BYBW1C891T1
 iUuEtqJseg47hHe9Cj9vWPiAtlJHJz0GXFNi/PgJvGjkfnxJwTexNWQ/eNvGpQ6y27kO
 vfidwkfDa+t1AL9dfpVU3L5Sc7depVBZnB93ugb6vfnklzDhqc5f1XR6RMI/RfIYH7wf
 7qwpHs41REK+VfI+BrJ3Axl3EMAZcw4ns6rxZyADEAQK1ThZCELob6DgLfI2/4VpKMHS
 3wVw==
X-Gm-Message-State: AOJu0Yxuz37VFks1SD4ylxJ32sW1lcLzKCHZr7sLZtSeidV3wdSKl2G/
 iRuoD0+tOu/LAu65eSoB3rY8TVNkqWk3aA8dyl/MtAIhnGRETX9kFxU/zblrI0fIOsHcrCZYsIl
 1
X-Gm-Gg: ASbGncuJoxW4wA9T/48XHibOCzBniNda55COkC4IMaAtCtILpcpAp1tN7WUCt2e8wrX
 c5UnQPdwT0My46yRWKyJmdyPilLdyi/t4wQFYXnBCq7EX6qAQhXh/HIO+RlstaG6HjE94VPHJ/J
 K1oN4AIqkifgkMwD3ZAs/gD0IiK/0np955V7boFRaqZQDp2gjUlg1oFsI7K9SiNiW9tQktg33Ur
 WIDRl3bjpVWnXWAlH55/Pgs0kUZaD3IicD04Oy2KkWB1rY/FV4n+WePAQ0cIr5KaBQEYwgZrOly
 ePJKO6JJmAKIZgTUQ1a+
X-Google-Smtp-Source: AGHT+IFNuc0/rJb3+EnpR/BHXG9+5agY5K0uKjyGM9C2gAZUZ7iXp05zGoBSmk5EbtXTkiOQTou4OQ==
X-Received: by 2002:a05:600c:458e:b0:434:9f81:76d5 with SMTP id
 5b1f17b1804b1-439249abc43mr145197425e9.22.1739291224192; 
 Tue, 11 Feb 2025 08:27:04 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.27.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:27:03 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 66/68] target/arm: Simplify DO_VFP_cmp in vfp_helper.c
Date: Tue, 11 Feb 2025 16:25:52 +0000
Message-Id: <20250211162554.4135349-67-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

Pass ARMFPStatusFlavour index instead of fp_status[FOO].

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250129013857.135256-17-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/vfp_helper.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 4d1b697a665..5d424477a2d 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -489,16 +489,16 @@ static void softfloat_to_vfp_compare(CPUARMState *env, FloatRelation cmp)
 void VFP_HELPER(cmp, P)(ARGTYPE a, ARGTYPE b, CPUARMState *env)  \
 { \
     softfloat_to_vfp_compare(env, \
-        FLOATTYPE ## _compare_quiet(a, b, &env->vfp.FPST)); \
+        FLOATTYPE ## _compare_quiet(a, b, &env->vfp.fp_status[FPST])); \
 } \
 void VFP_HELPER(cmpe, P)(ARGTYPE a, ARGTYPE b, CPUARMState *env) \
 { \
     softfloat_to_vfp_compare(env, \
-        FLOATTYPE ## _compare(a, b, &env->vfp.FPST)); \
+        FLOATTYPE ## _compare(a, b, &env->vfp.fp_status[FPST])); \
 }
-DO_VFP_cmp(h, float16, dh_ctype_f16, fp_status[FPST_A32_F16])
-DO_VFP_cmp(s, float32, float32, fp_status[FPST_A32])
-DO_VFP_cmp(d, float64, float64, fp_status[FPST_A32])
+DO_VFP_cmp(h, float16, dh_ctype_f16, FPST_A32_F16)
+DO_VFP_cmp(s, float32, float32, FPST_A32)
+DO_VFP_cmp(d, float64, float64, FPST_A32)
 #undef DO_VFP_cmp
 
 /* Integer to float and float to integer conversions */
-- 
2.34.1


