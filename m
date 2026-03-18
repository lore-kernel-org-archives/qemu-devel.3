Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7051F107BCF2
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 10:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2oD4-00031h-Q6; Wed, 18 Mar 2026 06:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2oD1-0002rM-9F
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:33:04 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2oCz-0002Wq-Nz
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:33:02 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so55828245e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 03:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773829980; x=1774434780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m/1EOyUUME4DZlQmM1UtNcy0WikBgHhHG/J2iZX+i+A=;
 b=wI0J9fkZmyFkbFC+ip5AYOoHqO0S4Aaw7GCh7WitJP3V/d+l/9cNyS3wswwwTUQ86p
 wLdhhAdGJBpyAW1MwVa1E+z4TzO8JmYp4mDN8iG8N0obZ0NvWkVWkRJ+j6up+4u1E2fd
 IsDo73fVK4bJ3cqCu2TwkzHoC6/awEMQKDCCFya9jDlgkoYS4BDwiCnloAVFYNbfQBAy
 TBOvpk6FncP9AXDahkBY4cseB3h76TIZpnXh55zUoOr9KNRsehx/QwofxH/cNSZsYIAW
 HxeddZNsBL4XPF4LEV7bYcj5/4GWWASuOKjdUf2LVflh76ZL3ydAN/RSLrPxT86PLxUt
 sahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773829980; x=1774434780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m/1EOyUUME4DZlQmM1UtNcy0WikBgHhHG/J2iZX+i+A=;
 b=BkU74ElqjOiVI1IKIsfftJNIt/GBazrNQRcltEBquiZFAR3z4qegJRH70m30gM2W3x
 qwwhJvMzKSbTTWHGUwfoz4TcRYC18gkd9sOvWmig5RLbMk1AB9xCiFH7hO4sMLBdUQ6k
 uXBYldVNcgH8gPjoHPzy96YPFY254tYc96WaJF/D3wNXOXKk0DpieNQdoiCkOuIWBeYm
 AWidO5uW/9svwrANSLPGTZzISl/4/rMIq95I2aGRsdE/RNp623kYKDoDinu0Bx5xu4bL
 NLJV/QSTwTXY00WxPioGLO+s4TBy8mjZ/cj1vNSkRZF67UMNCiQkm7AvZQwijW1jonmW
 shkQ==
X-Gm-Message-State: AOJu0YzW+dG5hLQt8oJOvvT1+/mG8bId7ZS3mkGJkS+m8AizcEk/w5Sg
 Dx4/V1XqcuBrSd7KC8IhSScedrtx7mPaQvT0EeQ4+kh/vQJOf8ktmz14/yF6wt/65vX8rBr3wCi
 mZf6E/k0=
X-Gm-Gg: ATEYQzwq+OtkHOTiLa16fvR4Xh2iaFazXAvX1ngXgl71cWV8u6LlSCwMM+9Sti/tdt6
 WnsiR+hLV7J3D6LU7Wpd0WJDF8fiXtQnhwdMtwrzgrPZBDg0Aiq1t22HrzqKlO16UuMB0Nudaxo
 nk35JYIYOWzw8jcd8FK0ihCnlaWXU/A6YAwlBOSLc3CHiUEfTz1tdEQKAg5EwvU4LWbCt4ae498
 4eQzfG/s8ONEMITAlFLyAGxTgZk/4GTrLETzVKSw20F5qTpXY5z9+6hjIiN2rvkn5kLcj1juX13
 U+BoOt3pw0VaXwBT2Ap857nsplUmrSVxbxRBNcE5OqxJj0r1D1yVwVaubLF5uOW7Pt4pCmfZe31
 2Nf/Q9WG9fRFSatQpd4Nueef2Lmt9cR/xRaw0SIaWDCsyWM+oBkrraxWTMFDRNywd1jNR5gCk0q
 QerNa8N6VAZJtg4GW0Fc5nQLruwfLISD9iWCef6I+bhofi25HZR70KIVP0X3aOQc+l2HuNAQpi
X-Received: by 2002:a05:600c:1551:b0:485:439b:683f with SMTP id
 5b1f17b1804b1-486f4441190mr47497685e9.20.1773829979792; 
 Wed, 18 Mar 2026 03:32:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f442d5c5sm52249305e9.10.2026.03.18.03.32.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Mar 2026 03:32:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Warner Losh <imp@bsdimp.com>, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>, 
 Vijai Kumar K <vijai@behindbytes.com>, Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH-for-11.1 13/16] target/riscv: Replace MO_TE by mo_endian
 (Zalasr extension)
Date: Wed, 18 Mar 2026 11:31:18 +0100
Message-ID: <20260318103122.97244-14-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318103122.97244-1-philmd@linaro.org>
References: <20260318103122.97244-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Replace compile-time MO_TE evaluation by runtime mo_endian()
one, which expand target endianness from DisasContext.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/insn_trans/trans_rvzalasr.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvzalasr.c.inc b/target/riscv/insn_trans/trans_rvzalasr.c.inc
index 2b1f73f650b..0f307affecf 100644
--- a/target/riscv/insn_trans/trans_rvzalasr.c.inc
+++ b/target/riscv/insn_trans/trans_rvzalasr.c.inc
@@ -29,7 +29,7 @@ static bool gen_load_acquire(DisasContext *ctx, arg_lb_aqrl *a, MemOp memop)
         return false;
     }
 
-    memop |= MO_ALIGN | MO_TE;
+    memop |= MO_ALIGN | mo_endian(ctx);
     memop |= (ctx->cfg_ptr->ext_zama16b) ? MO_ATOM_WITHIN16 : 0;
 
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, memop);
@@ -79,7 +79,7 @@ static bool gen_store_release(DisasContext *ctx, arg_sb_aqrl *a, MemOp memop)
         return false;
     }
 
-    memop |= MO_ALIGN | MO_TE;
+    memop |= MO_ALIGN | mo_endian(ctx);
     memop |= (ctx->cfg_ptr->ext_zama16b) ? MO_ATOM_WITHIN16 : 0;
 
     /* Add a memory barrier implied by RL (mandatory) and AQ (optional) */
-- 
2.53.0


