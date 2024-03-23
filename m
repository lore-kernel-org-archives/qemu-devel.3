Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FBFC54E58
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Mar 2024 17:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ro5C3-0002k6-FY; Sat, 23 Mar 2024 13:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ro5C2-0002jj-9m
 for qemu-devel@nongnu.org; Sat, 23 Mar 2024 13:30:06 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ro5C0-0005wl-4e
 for qemu-devel@nongnu.org; Sat, 23 Mar 2024 13:30:05 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1e0000cdf99so23295295ad.0
 for <qemu-devel@nongnu.org>; Sat, 23 Mar 2024 10:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711215003; x=1711819803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S0QfsALuaN0+wWbot0bFHlDdwooZi0EKVcDM5oK6qSA=;
 b=ya7exnbKQSbmOU2Up43gR7iH6jvNIB6sMR/OlwQHuaMpj0vGdDOO3ROeg4VYflclTG
 zGpK7ihdCEVCUm5PCHYa4tyDxNPcE5CaCeXoO3Fy7xD+3yHb9Kgm4EWj/TGAuUtWg/7M
 CA6EooZR3d6LAZnowT4jxQDEfjzLju6zbTe33skMXa/tOgXX3YklBjCn7jPejTAoP6Yd
 7T/Zr0nF7k8Rr8uu7d/obk2K5Tl+CHvNFMrEi6OeCv/yPHjZjYgma6Y1E7VdHQQwABw9
 tn5ACtVP+gBT8eWuJgZsjE9+QOGFTil7No/ZbdjkDUiW1CJDvogpdb8/a5jG2huzDsHv
 bXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711215003; x=1711819803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S0QfsALuaN0+wWbot0bFHlDdwooZi0EKVcDM5oK6qSA=;
 b=WRZ/PE3i7a11YUqJSkz+CPO/WUbZEsEKEpK+fftt8uU2Uxk09nCLSu2BxDdV59uKWy
 GuJ/Kh6QEZjPEIKO//G6tqZSKeMiKYKEyPGyCzsJniuHvYrPEdpvZro0+EbtLBiQy4gm
 5DWmP0oWiOWSui7iOiesA3GB7VvYFt+o2Fqyfa+08zYctDgv0AAKBOfvGcyxnRFHSS+A
 UvrOtE45bSjmH6AS26hhvl5RKTNYxdeliePCz0JRKNVo4f2jSZNa8P+2mcYT+NzIeF6l
 lEDmtl8KQi/OohyS6QSLm2XwHTCMGiGHmhmbWPafCa94opqITzOiEY4oc2htshGA6qxR
 Fk5w==
X-Gm-Message-State: AOJu0YyinrSTgz91fj2bqutwNFE6euzBLkMuT331PpvXCjwICZKm4dW6
 6l1RFIjeE6hXLBhoorsiudYMq3vuWKJQu4CPico3NtL3gT2tK0Dm/UV7s6unKe+EU9Nxw/HRqJL
 u
X-Google-Smtp-Source: AGHT+IHywGztXRFljRFfY5CVp2Oeev1pcDtzO+dvVHYbkxJ5XYgHsWj5bqAt6m2dRc6YbViRPAe9VA==
X-Received: by 2002:a17:902:e887:b0:1e0:aa4d:747f with SMTP id
 w7-20020a170902e88700b001e0aa4d747fmr1583147plg.6.1711215002766; 
 Sat, 23 Mar 2024 10:30:02 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a170902d2cf00b001dcfaab3457sm1811758plc.104.2024.03.23.10.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Mar 2024 10:30:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: svens@stackframe.org,
	deller@gmx.de
Subject: [PATCH v2 3/7] target/hppa: Handle unit conditions for wide mode
Date: Sat, 23 Mar 2024 07:29:50 -1000
Message-Id: <20240323172954.1041480-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240323172954.1041480-1-richard.henderson@linaro.org>
References: <20240323172954.1041480-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

From: Sven Schnelle <svens@stackframe.org>

Wide mode provides two more conditions, add them.

Fixes: 59963d8fdf42 ("target/hppa: Pass d to do_unit_cond")
Signed-off-by: Sven Schnelle <svens@stackframe.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240321184228.611897-1-svens@stackframe.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index f875d76a23..2cb91956da 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -967,11 +967,22 @@ static DisasCond do_unit_cond(unsigned cf, bool d, TCGv_i64 res,
 
     switch (cf >> 1) {
     case 0: /* never / TR */
-    case 1: /* undefined */
-    case 5: /* undefined */
         cond = cond_make_f();
         break;
 
+    case 1: /* SBW / NBW */
+        if (d) {
+            tmp = tcg_temp_new_i64();
+            tcg_gen_subi_i64(tmp, res, d_repl * 0x00000001u);
+            tcg_gen_andc_i64(tmp, tmp, res);
+            tcg_gen_andi_i64(tmp, tmp, d_repl * 0x80000000u);
+            cond = cond_make_0(TCG_COND_NE, tmp);
+        } else {
+            /* undefined */
+            cond = cond_make_f();
+        }
+        break;
+
     case 2: /* SBZ / NBZ */
         /* See hasless(v,1) from
          * https://graphics.stanford.edu/~seander/bithacks.html#ZeroInWord
@@ -996,6 +1007,16 @@ static DisasCond do_unit_cond(unsigned cf, bool d, TCGv_i64 res,
         cond = cond_make_0(TCG_COND_NE, cb);
         break;
 
+    case 5: /* SWC / NWC */
+        if (d) {
+            tcg_gen_andi_i64(cb, cb, d_repl * 0x80000000u);
+            cond = cond_make_0(TCG_COND_NE, cb);
+        } else {
+            /* undefined */
+            cond = cond_make_f();
+        }
+        break;
+
     case 6: /* SBC / NBC */
         tcg_gen_andi_i64(cb, cb, d_repl * 0x80808080u);
         cond = cond_make_0(TCG_COND_NE, cb);
-- 
2.34.1


