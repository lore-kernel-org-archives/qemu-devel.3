Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF70C54E41
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 05:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgHjP-0002OZ-UE; Sat, 02 Mar 2024 00:16:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjO-0002O8-GG
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:18 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjM-0007UX-QT
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:18 -0500
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3bd4e6a7cb0so1853687b6e.3
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 21:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709356575; x=1709961375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0lmJvt9dO3jDpvQGB6rhOn+2wNUhURlD+0eWhHde1MI=;
 b=Qd1+YYvIFc2yee9eyIRwezPM5W3NGl+H/ZEUtGaaomLEv2nHr196d2XeLeV4FW5fyq
 DTgSszD+1OmdgxdkljRWuAyVvm/FkTurJOIQgq2+DC04arEUaZtpkxjZD1zrem3oMW5m
 +eoLqjh/9phbUV/3lq4MTKkBIyuw8dCRAEEzX/Eo4ET1vqIVueFwVs+V2OMeEFvqMst3
 9kBxvk95iWZOaKUpteRoLVTnzLbbt1RF7X4ysuipLb/0gqhYAJ6K9qR9T4VOE3zOOGKE
 Xzabm/EFFp6bSjjFwWt9ZXeYVShkM69jQJJ6VgIaGMbl6ai/94EiYL3XpUjlalq8f5gI
 SkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709356575; x=1709961375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0lmJvt9dO3jDpvQGB6rhOn+2wNUhURlD+0eWhHde1MI=;
 b=qKLVXydmDWih6xYf6+xENQ/CQC0yi26PBSA4y/rS+DPTg7wIFYXOu6kbS3cLKpYwLM
 qL0lGv+cUvNkNio86BI3F9HfXpOzF4kceuAyj982lHyZf/HpBwcbH7BZX9nHzTJVH5QJ
 4NIPftYZ7xaRWoftNwxaJTl1ulfvRkLIbAoXosI+jheGeC+vzdaid/IDKsP2RkZQ4l4q
 CPJ5EgMb1kCRgJC4QgIPmn9Oc9757XPyjbVxinXtjbCcC1VlL2jEmfkmv6iitGMQQ09Q
 87ZmFbTYQEIHoNBzPMeuKmI7RzJKMTUP3xaUSfIfdxCUFqCfGX5ZaA38sRBkUpp5qih7
 dDuQ==
X-Gm-Message-State: AOJu0YxZT3U1kuNlTYOuStpgF2QRN+/jCQoa5+41+5Re1RulBRyvPpe/
 UDD8zGZ2VNBb++yzURYKpVnMx7AlYLP0c1ye5mu0C/9TAhH5z50YTpxCbRIgJIkQrlqlh8bXWT1
 s
X-Google-Smtp-Source: AGHT+IE9SUmQh53oqw0BGKqQ1lNk7en2709QPlDAIXFqJFLWbKGJ8RCL+5Z7HmIlpvJi5kk8X1F4+w==
X-Received: by 2002:a05:6808:1302:b0:3c1:b01e:2983 with SMTP id
 y2-20020a056808130200b003c1b01e2983mr4389674oiv.46.1709356575346; 
 Fri, 01 Mar 2024 21:16:15 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a17090a458800b0029af67d4fd0sm4034901pjg.44.2024.03.01.21.16.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 21:16:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 06/41] target/sparc: Fix FPMERGE
Date: Fri,  1 Mar 2024 19:15:26 -1000
Message-Id: <20240302051601.53649-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302051601.53649-1-richard.henderson@linaro.org>
References: <20240302051601.53649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This instruction has f32 inputs, which changes the decode
of the register numbers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/helper.h     |  2 +-
 target/sparc/translate.c  |  2 +-
 target/sparc/vis_helper.c | 27 ++++++++++++++-------------
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 39ea8f9baf..f0576fb748 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -91,7 +91,7 @@ DEF_HELPER_FLAGS_2(fstox, TCG_CALL_NO_WG, s64, env, f32)
 DEF_HELPER_FLAGS_2(fdtox, TCG_CALL_NO_WG, s64, env, f64)
 DEF_HELPER_FLAGS_2(fqtox, TCG_CALL_NO_WG, s64, env, i128)
 
-DEF_HELPER_FLAGS_2(fpmerge, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_2(fpmerge, TCG_CALL_NO_RWG_SE, i64, i32, i32)
 DEF_HELPER_FLAGS_2(fmul8x16, TCG_CALL_NO_RWG_SE, i64, i32, i64)
 DEF_HELPER_FLAGS_2(fmul8x16a, TCG_CALL_NO_RWG_SE, i64, i32, s32)
 DEF_HELPER_FLAGS_2(fmul8sux16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index edb97bc64e..6a6c259b06 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4612,6 +4612,7 @@ TRANS(FMUL8x16AU, VIS1, do_dff, a, gen_op_fmul8x16au)
 TRANS(FMUL8x16AL, VIS1, do_dff, a, gen_op_fmul8x16al)
 TRANS(FMULD8SUx16, VIS1, do_dff, a, gen_op_fmuld8sux16)
 TRANS(FMULD8ULx16, VIS1, do_dff, a, gen_op_fmuld8ulx16)
+TRANS(FPMERGE, VIS1, do_dff, a, gen_helper_fpmerge)
 
 static bool do_dfd(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i64, TCGv_i32, TCGv_i64))
@@ -4652,7 +4653,6 @@ static bool do_ddd(DisasContext *dc, arg_r_r_r *a,
 
 TRANS(FMUL8SUx16, VIS1, do_ddd, a, gen_helper_fmul8sux16)
 TRANS(FMUL8ULx16, VIS1, do_ddd, a, gen_helper_fmul8ulx16)
-TRANS(FPMERGE, VIS1, do_ddd, a, gen_helper_fpmerge)
 
 TRANS(FPADD16, VIS1, do_ddd, a, tcg_gen_vec_add16_i64)
 TRANS(FPADD32, VIS1, do_ddd, a, tcg_gen_vec_add32_i64)
diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index eb1c4e47e9..89eea05ddb 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -74,22 +74,23 @@ typedef union {
     float32 f;
 } VIS32;
 
-uint64_t helper_fpmerge(uint64_t src1, uint64_t src2)
+uint64_t helper_fpmerge(uint32_t src1, uint32_t src2)
 {
-    VIS64 s, d;
+    VIS32 s1, s2;
+    VIS64 d;
 
-    s.ll = src1;
-    d.ll = src2;
+    s1.l = src1;
+    s2.l = src2;
+    d.ll = 0;
 
-    /* Reverse calculation order to handle overlap */
-    d.VIS_B64(7) = s.VIS_B64(3);
-    d.VIS_B64(6) = d.VIS_B64(3);
-    d.VIS_B64(5) = s.VIS_B64(2);
-    d.VIS_B64(4) = d.VIS_B64(2);
-    d.VIS_B64(3) = s.VIS_B64(1);
-    d.VIS_B64(2) = d.VIS_B64(1);
-    d.VIS_B64(1) = s.VIS_B64(0);
-    /* d.VIS_B64(0) = d.VIS_B64(0); */
+    d.VIS_B64(7) = s1.VIS_B32(3);
+    d.VIS_B64(6) = s2.VIS_B32(3);
+    d.VIS_B64(5) = s1.VIS_B32(2);
+    d.VIS_B64(4) = s2.VIS_B32(2);
+    d.VIS_B64(3) = s1.VIS_B32(1);
+    d.VIS_B64(2) = s2.VIS_B32(1);
+    d.VIS_B64(1) = s1.VIS_B32(0);
+    d.VIS_B64(0) = s2.VIS_B32(0);
 
     return d.ll;
 }
-- 
2.34.1


