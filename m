Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9245606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=MJKBJh2f
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM6aF-0006UZ-6k; Wed, 28 Oct 2026 12:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6aD-0006TM-0Y
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:33:01 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6aB-0007XI-Ed
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:33:00 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-70b875f6f13so907320eaf.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 09:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793205178; x=1793809978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sHlhV1ZqXIbzro91dvfRRIbXHqg/uhhPXyMLjbkNVnQ=;
 b=MJKBJh2fVx9duDcoXqVp0OXYTpBLPP4f5nMWb1vUxizKmGxH6r0XZ9fMdYb7h/A896
 mTmWQmY7x8SgEuEY5OLlmUTw6vdfNe+DDv9cHdr4CWdZ9mx2QpTpujcLVjtYiR9Si7aZ
 G075SUX1R5xDllQgWmzPDWQgAPPrvbQKkGoy98SjjUkRBh/4pFKOaGDtF/Acd3KV4ITY
 wcBIWuc2h4wlRUswv+H+/97g+QHttGzd9GcaU+slGdFtEezbRWYGon37bGhRJ6CsQSNs
 9ZVeUQQKmA72nCvYURYEifgvBNIqpNea5LRafLZmgzzWHshppDB6Rawiij5/ypAytnw0
 e2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793205178; x=1793809978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sHlhV1ZqXIbzro91dvfRRIbXHqg/uhhPXyMLjbkNVnQ=;
 b=xcul3BjzGMJcx2vUdQ/o4XGIJ79ZcGb8FA+kqgJUp1Jqn53GTCVp1U6kP2jgHhavwq
 wrqg4Tunvyu9u/V8zzRV/QXGbRIeAbw31eZ91rbUVO1X4rlmHXcJ07wBG2MwWYgCcA/6
 Y4jZTstbTMS39z2Z3SLb1hX7b+XeKSG78dUdZW2TPq3iFRf5lWcvygSOEUBnRWgK7tAg
 oa6tOn520sv6beCveoFWlLMdMFAiFN445g4Xamp75fVsh6tTOpahq+t/yu/VGHRZXZ8I
 EQieeuQq3ELv70f6jQMOiZ7wWyHYkdWcjTO86hGHM+lcCmcIXmV5zaxGJodqBQ5hZorY
 ulwQ==
X-Gm-Message-State: AFq9FYKJ3aosHUgWcOcybHX1NHnbn3KqFlunN2Ypn1uKyuA5B/kobOdS
 jBaR3FcXTZaj2e6Qx+MXt0DCs2uZ4G75YwAfD1c7BweVMFvjR9OvMOMqN4Iz+jpB/UasAVOPvYD
 LDSFS
X-Gm-Gg: AYBFou29wPwNC2Qx1zgfH344sgNk1OZnbBxsx0+AjYgCSqFzVlGv2iHFm3BqdsdYAzE
 bApnQnD2+WBEW2q3JR3n36ytTSDj9j2rs8W9TbaYsViIxWxtqjV4XT+0JOcCm1boKxezRTRkq2f
 HPyTrz24K1Y+x7nheOdGIp5qyXJ4mqqxBAQQVNCh8hsskVrXMZevV7VhQMmw1r4XHmHWiqnSVQJ
 pdvsO966FJeIT07cgJG6Dc/o/AbEpAkAwBRvk9KbnFlF5AXBTuaZvLnyt55XzeBAzjgJAP0HaAv
 bi+LypnpYcMbfBWRpBbNNoaKrLv+QVm+XSzdVgYQlZLgO0DxUu2kMtelURAPFndV4sEKJMgtzsa
 /bnWMCTh9esOrgk8pqq4h9rofHxn2dfA0sOWPmp3UYwIODRg8KKDu5MZABT0PsgNkcBJEDkhMHK
 aD56rQ6mR8JfVwRLVg4BJWtOd5FqpN1A+h9iUv5quy/ujiSgbYkQu/DOAkrnyecUulvDNzpqhb0
 AR2tgZg3mFDsQjHODSqpsXCcNdZZRquhX0FJpJvBtTJTJ86lF7j/P0JtqbXQXTzQ21n7etOesCR
 ImoD32YW70EWsjySRF4tiyg7IQNtjnKZr6Y=
X-Received: by 2002:a05:6820:1c9d:b0:708:c01c:13f3 with SMTP id
 006d021491bc7-713f1f521e5mr1545771eaf.63.1793205178169; 
 Wed, 28 Oct 2026 09:32:58 -0700 (PDT)
Received: from stoup ([2607:fb91:2c2e:8a8c:60fa:827:925e:3bb6])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85b1f4368f3sm2538965a34.7.2026.10.28.09.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:32:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PATCH v3 09/16] target/i386: Use tcg_gen_lea_tl in gen_lea_modrm_1
Date: Wed, 28 Oct 2026 11:32:38 -0500
Message-ID: <20261028163245.1031673-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028163245.1031673-1-richard.henderson@linaro.org>
References: <20261028163245.1031673-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc36.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/translate.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index dd417cb534..5199c330ac 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1698,31 +1698,32 @@ static TCGv gen_shiftd_rm_T1(DisasContext *s, MemOp ot,
 /* Compute the address, with a minimum number of TCG ops.  */
 static TCGv gen_lea_modrm_1(DisasContext *s, AddressParts a, bool is_vsib)
 {
-    TCGv ea = NULL;
+    TCGv ea = (a.base >= 0 ? cpu_regs[a.base] : NULL);
 
     if (a.index >= 0 && !is_vsib) {
+        TCGv index = cpu_regs[a.index];
+
+        if (ea) {
+            tcg_gen_lea_tl(s->A0, ea, index, a.scale, a.disp);
+            return s->A0;
+        }
         if (a.scale == 0) {
-            ea = cpu_regs[a.index];
+            ea = index;
         } else {
-            tcg_gen_shli_tl(s->A0, cpu_regs[a.index], a.scale);
+            tcg_gen_shli_tl(s->A0, index, a.scale);
             ea = s->A0;
         }
-        if (a.base >= 0) {
-            tcg_gen_add_tl(s->A0, ea, cpu_regs[a.base]);
-            ea = s->A0;
-        }
-    } else if (a.base >= 0) {
-        ea = cpu_regs[a.base];
-    }
-    if (!ea) {
+    } else if (!ea) {
         if (tb_cflags(s->base.tb) & CF_PCREL && a.base == -2) {
             /* With cpu_eip ~= pc_save, the expression is pc-relative. */
             tcg_gen_addi_tl(s->A0, cpu_eip, a.disp - s->pc_save);
         } else {
             tcg_gen_movi_tl(s->A0, a.disp);
         }
-        ea = s->A0;
-    } else if (a.disp != 0) {
+        return s->A0;
+    }
+
+    if (a.disp != 0) {
         tcg_gen_addi_tl(s->A0, ea, a.disp);
         ea = s->A0;
     }
-- 
2.53.0


