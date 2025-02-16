Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F746C021A6
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 00:02:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjS6A-0007cL-F4; Sat, 15 Feb 2025 19:01:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjS60-0007aa-BZ
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 19:01:16 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjS5y-0006FJ-JB
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 19:01:15 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-220f048c038so32686035ad.2
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 16:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739664073; x=1740268873; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CoSz+0yLhVK3dbyvfDxsdAZSwsgZvLHw47U3xK2XgEE=;
 b=jQvVwGeE9y3NIJIEAc2bw3U0alVGZYXpVRT7IgRcbuuRoJF0Eo72LYm4FKDUoRI1kn
 5oyP6CAVieukrL28vkFhXGyr+a8eUJtzuTpNzJWCLzI0JMA0nw7cxvVENffeTgfpyDlO
 pgl1B+hYPX2l7TXuVKU2Qhc1cKTxvS0E5HtvFgR6OrNamSqXY8rf9oWtfF4w17hJmZ/L
 nLXZFkwtw0D/Ps5b0JX0OA/NQnoolb7+EfDfmdHty3VLhyFGPiJrn15CGtHw9PfMllrm
 vda2VFMAW+Ae+WceVEMQ2tXzV8Z9+pFmgI4qaG/+KoaruI4GEaCAkMwZovHmP6+je45j
 kDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739664073; x=1740268873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CoSz+0yLhVK3dbyvfDxsdAZSwsgZvLHw47U3xK2XgEE=;
 b=q8/SQI6FunbCPRxSeWrAKI3JEHXMllhjBhjFDh47MGaT4Gy421K7vjLi3kNqMFKJqK
 Xt/2l+N1rcTH0QU+C0xwZIXZTZI1nniXjg2WXHQjsuMs4eOnAtPpN8hOg4uChY3tIUKI
 7jAcSy0Vvk5zTli9tkCmmAxrR/RMgI/s+wrHGa8DRqoFCXAd2upJkQ0bJq7CbhPIf0zp
 b/EgHUl4LUIiGOzw2sdQdll2CdJnqdlg6lSeJfaRhd9DiozzIGlvjXCywy81fdMzuapk
 A5u0erIhE47cDKOAi7584J7tp3N1vnUYeq9HeNdFgQvPH6XDgNMYEv5WyjHoo6u8eN7K
 bk7A==
X-Gm-Message-State: AOJu0Yy0wa/0V6h25ZkI/UUOAnwv+OtW+CIOLVllFVl+LGyrrCa8/kVm
 uvwjY3qC5P+fVbUdRR5Omeo5OXjqC31ef0l/DydR7y4hL1UhmgixcftQQHgHgLqKsB8oYoYBI8L
 i
X-Gm-Gg: ASbGnctWFnH4TlAttvkR5QcqOih1XtR34cTB9mlQ8rGjFafRzX3uCTwGyiq5/Q1BU34
 PAa08E/8kkx6TTU2PtM7HetN9mbVaCT8xxfNdk7nqpeDla1ttuqiCODa3I/HlrydIidqTYUN8Xi
 JAvGMJ0oXrHhJ397UhxnTgk439o8IZbBSri+plTwsL0cg263LDO29Y4A1eep+r40S0ohTCyqSBh
 nCUEiwEsrleKurIMIH6ZB9dCF5qu2onZEU+4n5u1vUpcvYNQHsXvxbWgyXdaQKm/0oeBh1J99g4
 yYzdkRaEYXG7uzx5+mEM8AY3PBkbG1ZFWstBYM+N5LPDgq8=
X-Google-Smtp-Source: AGHT+IFYLpm3/8IUL46HjbwYgw3XNTQyaj6Q5/uC4eQLl9wdTq8qI7G6PCpLRCj78eVoTAHR5gf0VA==
X-Received: by 2002:a17:902:ea04:b0:220:e023:8fa6 with SMTP id
 d9443c01a7336-221040c0c0emr65671705ad.50.1739664072967; 
 Sat, 15 Feb 2025 16:01:12 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366729sm48960315ad.79.2025.02.15.16.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 16:01:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/24] tcg: Drop support for two address registers in gen_ldst
Date: Sat, 15 Feb 2025 16:00:47 -0800
Message-ID: <20250216000109.2606518-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216000109.2606518-1-richard.henderson@linaro.org>
References: <20250216000109.2606518-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-ldst.c | 21 +++------------------
 tcg/tcg.c         |  4 +---
 2 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 77271e0193..7ba9a3ef7e 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -91,25 +91,10 @@ static MemOp tcg_canonicalize_memop(MemOp op, bool is64, bool st)
 static void gen_ldst(TCGOpcode opc, TCGType type, TCGTemp *vl, TCGTemp *vh,
                      TCGTemp *addr, MemOpIdx oi)
 {
-    if (TCG_TARGET_REG_BITS == 64 || tcg_ctx->addr_type == TCG_TYPE_I32) {
-        if (vh) {
-            tcg_gen_op4(opc, type, temp_arg(vl), temp_arg(vh),
-                        temp_arg(addr), oi);
-        } else {
-            tcg_gen_op3(opc, type, temp_arg(vl), temp_arg(addr), oi);
-        }
+    if (vh) {
+        tcg_gen_op4(opc, type, temp_arg(vl), temp_arg(vh), temp_arg(addr), oi);
     } else {
-        /* See TCGV_LOW/HIGH. */
-        TCGTemp *al = addr + HOST_BIG_ENDIAN;
-        TCGTemp *ah = addr + !HOST_BIG_ENDIAN;
-
-        if (vh) {
-            tcg_gen_op5(opc, type, temp_arg(vl), temp_arg(vh),
-                        temp_arg(al), temp_arg(ah), oi);
-        } else {
-            tcg_gen_op4(opc, type, temp_arg(vl),
-                        temp_arg(al), temp_arg(ah), oi);
-        }
+        tcg_gen_op3(opc, type, temp_arg(vl), temp_arg(addr), oi);
     }
 }
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 53de13df71..14c2d38160 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1690,9 +1690,7 @@ void tcg_func_start(TCGContext *s)
     s->emit_before_op = NULL;
     QSIMPLEQ_INIT(&s->labels);
 
-    tcg_debug_assert(s->addr_type == TCG_TYPE_I32 ||
-                     s->addr_type == TCG_TYPE_I64);
-
+    tcg_debug_assert(s->addr_type <= TCG_TYPE_REG);
     tcg_debug_assert(s->insn_start_words > 0);
 }
 
-- 
2.43.0


