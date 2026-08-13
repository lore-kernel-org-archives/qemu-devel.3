Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B340C5AC67
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 05:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuNwz-0005Iv-Mo; Thu, 13 Aug 2026 01:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1wuNwx-0005Ig-0S
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 01:25:55 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1wuNwr-0002f4-MV
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 01:25:54 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-47f633e6058so245699f8f.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 22:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786598748; x=1787203548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Mep07tKqoqwgU5lD8yQfxlDktyagy5MDV/3WvRhBBnI=;
 b=bDobnLPAeEkoQP78KcWa2aERSHk6c7D1w/wfUgiD+o6OiclSWoDH8rAZJdX4J4tDuX
 0f6qEHV7vb/1ZCASlurNDjFny9dI5Pu7yP9fi8R4j/bUyT0PKGKLwmc+BzPr+xyW01Cv
 5QkhsYs71hMdLfwXgxdhsPF2lzEHusij30KpEuyGropGhIqwrEDHUmMg5sdacqGosw75
 cdlzlu1SkeLRmbdYbOh4epJ6PNlouXQjTWskzo6J7mLlmGwTE/weEhy5LI0NTUDMk/dN
 cTuijreiPzKmCrDyAqdVi74S2uck6qgeKZQTt0LMkpdnlLvbx4RdZZ0HJj/uFhgZQ5RE
 G+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786598748; x=1787203548;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Mep07tKqoqwgU5lD8yQfxlDktyagy5MDV/3WvRhBBnI=;
 b=FFOPqgm2ruW+pOP2wkcSng0VX6atBeuFga+WhLOF7lphYuw/mCFiYJUmK/zZmQj2SJ
 iIZCBFQWP4ylbLv/Xp1biRaU8/s11dvkNHRFKaF22x+hwJsR/VmOp12WBuPndY6bjAW7
 aLCbTed6pL38SByGmB2Uu77+//0Wk+LVHYA6y6VBr+6WZIueX5ZNURNfyUfIL8zd1QsC
 hxYvIyy+/NVDNHKVbD+2E1Mw0xfPH/dQFcE6AaR+YLDo5jsX3+3x1Ej7AgJc/Y7IM7lp
 t1Og/B0xaYnXh2czgJ8kJunQ/60hZZaCzGrYKmL5nyaGb+fVOfaYn7ELzeY4fWGMsE65
 wo1A==
X-Gm-Message-State: AOJu0Yxz57OJS8pEoQPfvv/fuoWc5Ok3fIci9Rd+lCEMhxuTNSoZMn2c
 ousJyt1qOcYOwjoirZ8UwdGZf5fD8nVCt0m31kmJucuUyZsONvWsJ5uRzfdTu+ucLyw=
X-Gm-Gg: AR+sD122fWTE1/9XYM/svyMhO1RJJA/x6MoUsIY6/oS8ikeegMOJi/xzxze7ydSDrLx
 ENfvR+UFuXk2eaFecMXHB6CCquCUT+x8d/c++hRJ4lPMzTFSlWHG7nTBif5L7Na4eqibj0WQwGp
 CrwnEmfrk/N+srRbbBbitKGV/pSGQq8dQCzX3hUhtPBmn+s0ia4EPgxRLW0uBuvXK7C/Gso1eth
 sFQhHVaiyVCP1xWrmoe7GPIeCpIm3lV4bw3qxlZS8wnssuoFsU8k9TxjYIimjfFfp6zqQWLuiXp
 eMvkPFcSNjHAvYrHUhZWFfIElMebGajR+TCsm2oytzuURzNmHz5NpSiTTlz0DcsQbOq+l+C4S5e
 KS/+kQH8DdFjRNk/9bEtT9ycvES9au8zOSFltMSVJ+oMAEb0YbGoJDQxe05WBSDhgLAau9EBUxr
 +l2R8i+ocE+hODxn8ozkPvKgqrhF3LzFXD/SWS4O378OZwZLoPsb1emE04qCaPsOmtKDK8rEPhC
 qxhkpYl9Ce+zqGxhWNHT6mFD8FwnvRua9Uxy6vq7UqhI5txZW57/8NzW8sp3xmMMpgz2JyB815k
 fO44mke1DOLyiFMnlAX0ickU450=
X-Received: by 2002:a05:6000:184f:b0:481:512b:f0e7 with SMTP id
 ffacd0b85a97d-4815a01aaedmr3970025f8f.17.1786598747398; 
 Wed, 12 Aug 2026 22:25:47 -0700 (PDT)
Received: from simon-macbookpro.tugraz.local (tug-swl-c122.tugraz.at.
 [129.27.234.122]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815a5af45fsm3283059f8f.18.2026.08.12.22.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 22:25:46 -0700 (PDT)
From: Simon Scherer <scherer.simon89@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org,
 Simon Scherer <scherer.simon89@gmail.com>
Subject: [PATCH v2] target/i386: Set aliased x87 exponent bits to all 1s for
 MMX register writes
Date: Thu, 13 Aug 2026 07:25:32 +0200
Message-ID: <20260813052532.22833-1-scherer.simon89@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=scherer.simon89@gmail.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Per the Intel SDM (Vol 3, 15.2), writing an MMX register also sets bits
64-79 of the aliased x87 register to all 1s. gen_writeback() never
does this for X86_OP_MMX destinations, so those bits keep whatever
the x87 side left there (e.g. 0 after finit/fldz). A later x87
instruction such as fucomi/fucomip can then read a stale finite
value where real hardware guarantees a NaN encoding, changing
comparison results and flags.

Set the high 16 bits to 0xffff when writing back to a MMX register (not
memory).

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4105
Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: use offsetof(CPUX86State, fpregs[op->n].d.high) directly instead of
    reusing MMX_OFFSET() + offsetof(floatx80, high), per Richard's review.

 target/i386/tcg/emit.c.inc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 473f415766..2c36e41303 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -352,6 +352,10 @@ static void gen_writeback(DisasContext *s, X86DecodedInsn *decode, int opn, TCGv
         }
         break;
     case X86_OP_MMX:
+        if (!op->has_ea) {
+            tcg_gen_st16_i32(tcg_constant_i32(0xffff), tcg_env,
+                             offsetof(CPUX86State, fpregs[op->n].d.high));
+        }
         break;
     case X86_OP_SSE:
         if (!op->has_ea && (s->prefix & PREFIX_VEX) && op->ot <= MO_128) {
-- 
2.53.0


