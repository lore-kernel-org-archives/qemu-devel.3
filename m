Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23436E77180
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2024 22:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKQ5C-00079D-MF; Sun, 08 Dec 2024 17:48:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tKQ5B-00078w-2L
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 17:48:57 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tKQ59-0006Dh-Hh
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 17:48:56 -0500
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-71de7b9d572so473517a34.2
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2024 14:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733698134; x=1734302934; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GP9lF16T6qLE7Iw1bLwN66Qqfacm79ugW11up6kxmVc=;
 b=tVS/FfvGQjUkjBRTYHMkwYUbxPT8DuPBA0FgHN3e1nvrJHrU+3j1aZrphpyud9no2c
 EGpE4OeNDcQUrq9KUl8kHvMHK0frdBZ9s0JbCdXX9/05GP1h+L7ITYws4wz1OB2FMsgD
 eKm4fS5N/4r0mmwbxyuXTnOgioaSKuxqJFv2Joy/IWovs+nZaz28kF2ZotpDrwxNG+GT
 8nsJlmzWr7enUo5ysxuZHs1Gwz2BcVNF3cnEYLnhkdILjYcgOe731U28R9KM1lcigG+4
 voNK6K4OlKwPY0IXm4jCFD0rcQb4xnd7fn2nGFxjVGO/fJ6TcIVffPYdtpkw5k6xb1Wl
 ujgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733698134; x=1734302934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GP9lF16T6qLE7Iw1bLwN66Qqfacm79ugW11up6kxmVc=;
 b=CODZApR6Rzfsgg0X7J9HYznrOVmWiA2XlXFc5PPFQvVST1J5MPp8YkqElLYzBn0TyF
 G5hNtxRFbFUb5LUOp/CfAdfT8rMcvR/jWVWU5F3L5f3o3aNUzO/wbeNIEJD+nT82Q1pr
 uix3HUeHi0KKszSExTB8oXSRoGbvWdkJg1jTWCIkdbxQ22LFANvXaLFEBkd/GWnvAP5n
 iP0GVAbH6XhDe3VRrpXpJz3qqzsKYncbeyjpEPUpFTVqODD5083tONGwpfX3SNsC1zjl
 WGvOSo1tZTLnZScV9a402u4OlUKM1Jt5qvjPqrzUyrQ16o9BrXCdoH5oNW/w8Cr+WDMO
 9CqQ==
X-Gm-Message-State: AOJu0YxV8D/QZkBOGke3oT7zTz+nT9iKHSp1GET2mLDeIwbOtV1eP+07
 j/I7dZgFRcFPoYZZr2BocaoDSC4ntthexog1Z/IRzHWYUEF3Gh70CnEldxmO9KG9GBBnqCkkrtR
 eKyt/Bw==
X-Gm-Gg: ASbGncuXsGTzFlbgBd5sKsI2EucH4vosz/6xViRsmYt4h0FW1xCebvUOreA1ROEO+hP
 wAk/p++EDDsWehGD0zlSk3fLdBpHjBTyOfM0J8gHQbOXx2sj7NiIdl1rTwwswbiHTa5ivvAjTCE
 69uM9M1cLWDsBW+4LMIqb/66LTdKTIqqVNHMa8TnFVamPETHNlgdBL3HVLgTlJeS7Cl3Fdo90T8
 H+R/uIraEUZhkTDJ9KrOveT7p+CNRIhq31J79ZtMRVrRB1YloKXrvacxKQA6j54i0BCROldnVX7
 fCVG4Krx+bOUM4VCyBPIhu4qXBCKqVzxJnBb
X-Google-Smtp-Source: AGHT+IEHVkZs8CSfFz/UgXuD+3VaVsyd/YQ2hi1tlnAvLsWo/23dzWzsIfh6wPljH3PBxMfrK7dAhA==
X-Received: by 2002:a05:6830:6207:b0:71d:4264:cce2 with SMTP id
 46e09a7af769-71dcf4d9648mr6401382a34.9.1733698134483; 
 Sun, 08 Dec 2024 14:48:54 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dc497ee8fsm1925198a34.39.2024.12.08.14.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 14:48:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: bcain@oss.qualcomm.com, peter.maydell@linaro.org,
 mark.cave-ayland@ilande.co.uk
Subject: [PATCH 06/17] softfloat: Add float_muladd_suppress_add_product_zero
Date: Sun,  8 Dec 2024 16:48:33 -0600
Message-ID: <20241208224844.570491-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241208224844.570491-1-richard.henderson@linaro.org>
References: <20241208224844.570491-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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

Certain Hexagon instructions suppress changes to the result
when the product of fma() is a true zero.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat.h   | 5 +++++
 fpu/softfloat-parts.c.inc | 4 +++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index aa69aecfb0..09a40b4310 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -120,11 +120,16 @@ bfloat16 bfloat16_squash_input_denormal(bfloat16 a, float_status *status);
 | Using these differs from negating an input or output before calling
 | the muladd function in that this means that a NaN doesn't have its
 | sign bit inverted before it is propagated.
+|
+| With float_muladd_suppress_add_product_zero, if A or B is zero
+| such that the product is a true zero, then return C without addition.
+| This preserves the sign of C when C is +/- 0.  Used for Hexagon.
 *----------------------------------------------------------------------------*/
 enum {
     float_muladd_negate_c = 1,
     float_muladd_negate_product = 2,
     float_muladd_negate_result = 4,
+    float_muladd_suppress_add_product_zero = 8,
 };
 
 /*----------------------------------------------------------------------------
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 2b6adeef4c..015b272e30 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -529,7 +529,9 @@ static FloatPartsN *partsN(muladd_scalbn)(FloatPartsN *a, FloatPartsN *b,
             goto return_normal;
         }
         if (c->cls == float_class_zero) {
-            if (a->sign != c->sign) {
+            if (flags & float_muladd_suppress_add_product_zero) {
+                a->sign = c->sign;
+            } else if (a->sign != c->sign) {
                 goto return_sub_zero;
             }
             goto return_zero;
-- 
2.43.0


