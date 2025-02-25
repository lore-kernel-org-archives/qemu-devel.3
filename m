Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5B5C021A4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 00:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmizq-0004YQ-BS; Mon, 24 Feb 2025 19:40:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tmizn-0004Wa-2M
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 19:40:23 -0500
Received: from fout-b6-smtp.messagingengine.com ([202.12.124.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tmizk-0003Rw-Qq
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 19:40:22 -0500
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id E818C11400E8;
 Mon, 24 Feb 2025 19:40:19 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Mon, 24 Feb 2025 19:40:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1740444019;
 x=1740530419; bh=HzRGBpSsuGYsqp1nebQkdwxhC9+0p8sAf3ZNP4r9fJ8=; b=
 fHT9BiTvtY+ddxUhVLdt2FfgdYwpRkVOJRcguXH3htak8U2cqoqtQYh9TKv/6Az2
 D9bEWzs/krCsgkgCBsvN2ccBO7Y98Ckqz9nBiOzcDtjRWlGVXwm9ydJ2VRciJ7yw
 MV2NpaLtNxc3t+g7MyFrLj04eDEEJqhbDcbJw34RVOsuqlJ1prrvLE6Ax/SpIi/M
 YmCQw5gPl0siJBIQWExLepGbDgGAwsn55dOQTYp0fg4b+MNfe6IwofkFkkTeIdrJ
 3gUqEkKnF57pYId5pw9/FIeUUC5NepT8KmmZoE8evAlNQ14iguHkiwZ1tcemvqYj
 PbPs+ggSu/pRTtdG/unzEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740444019; x=
 1740530419; bh=HzRGBpSsuGYsqp1nebQkdwxhC9+0p8sAf3ZNP4r9fJ8=; b=i
 wQ3bQDVg9u6GywUzJk82+y/MU8Xye+xeraDPTRK3Q5Rap2vwDzBAFnNUzIzuOsls
 sR7LvMpRjzxbnPskzvUlG+a4NGzcdkEOt/f5N31BJ30OLQCRokS8T0Y0Lp4StC2x
 Pqo5uvFJ1KOr578lag0GUAVn0LbV0vVceZcV86InXeQZyqfCrx5Ui45TKBeIPz+y
 vuBU1LNnTtnpFFlmJsVs12bBy/I8TxL6UXmMIqGasYshIS4oxUH7gcnLIptJbLsA
 GIT5jX49NHei+zsKWQOiAaQqxYbjL9Q58UgbgTSi5eVi+2lKdlhSFXKFWc3rG5H4
 Rg9J2g3A8N9fyNPytfnlw==
X-ME-Sender: <xms:cxG9Z6mqB7nXzvF2y0vlxKHdSZWfjrmakBH7O_BFk6r7snv9Rvey1g>
 <xme:cxG9Zx2cWdWhX-lV9WJaAbGjHoCKoeNmi4Qk3h0X9wf7go1D6dxiBhRgAubXoJqn8
 iKlWVptCt4AqOJJ8wA>
X-ME-Received: <xmr:cxG9Z4rehWHF9y-7qCN9Nk6Bv9DdpErQgaFUlKCHazY1E0Q8xbLCHaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdektddvhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
 jeenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflh
 ihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleff
 keegudeghfdtuddugefhueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorght
 rdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtth
 hopehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhrtghpthhtohepghgr
 ohhsohhngheslhhoohhnghhsohhnrdgtnhdprhgtphhtthhopehqvghmuhdquggvvhgvlh
 esnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:cxG9Z-koC-TqLTh3Xtt0MycoNk95ujw7gBt4qAX9Q14C7SthCQ1LZw>
 <xmx:cxG9Z42FkSAH9TzqVgEyMpfjYLwcjL5LOHnvJkPxnENhBKzxQjYb2g>
 <xmx:cxG9Z1sn1YCF2GeL7cjvTB24YYgv6PnK6mLZSOyesGgZBuqHHuVMtQ>
 <xmx:cxG9Z0UVnwARW5wRxKpopiwz2MkzUs_pBPP1-7YqDKkvTAT351gVVw>
 <xmx:cxG9Z1z9uhmIhqcErUxAsxt8OZEl9JgYXrrRRIlm_1Gjtt3Rv0zUJ2cR>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 19:40:19 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 25 Feb 2025 00:40:15 +0000
Subject: [PATCH v2 2/9] target/loongarch: Fix address generation for gen_sc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-la32-fixes1-v2-2-8ec68ada3dd5@flygoat.com>
References: <20250225-la32-fixes1-v2-0-8ec68ada3dd5@flygoat.com>
In-Reply-To: <20250225-la32-fixes1-v2-0-8ec68ada3dd5@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=202.12.124.149;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout-b6-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

gen_sc should use make_address_i to obtain source address
to ensure that address is properly truncated.

Another temp value is created in middle to avoid data corruption
as make_address_i may return the same memory location as src1.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/loongarch/tcg/insn_trans/trans_atomic.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
index 974bc2a70feddbf021a07b19a0859781eb3a11c4..c35f6f3ce47877ab6ad84fa2cbc50b46c0b23ad1 100644
--- a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
@@ -22,13 +22,12 @@ static bool gen_sc(DisasContext *ctx, arg_rr_i *a, MemOp mop)
     TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv src2 = gpr_src(ctx, a->rd, EXT_NONE);
-    TCGv t0 = tcg_temp_new();
+    TCGv t0 = make_address_i(ctx, src1, a->imm);
     TCGv val = tcg_temp_new();
 
     TCGLabel *l1 = gen_new_label();
     TCGLabel *done = gen_new_label();
 
-    tcg_gen_addi_tl(t0, src1, a->imm);
     tcg_gen_brcond_tl(TCG_COND_EQ, t0, cpu_lladdr, l1);
     tcg_gen_movi_tl(dest, 0);
     tcg_gen_br(done);
@@ -36,6 +35,7 @@ static bool gen_sc(DisasContext *ctx, arg_rr_i *a, MemOp mop)
     gen_set_label(l1);
     tcg_gen_mov_tl(val, src2);
     /* generate cmpxchg */
+    t0 = tcg_temp_new();
     tcg_gen_atomic_cmpxchg_tl(t0, cpu_lladdr, cpu_llval,
                               val, ctx->mem_idx, mop);
     tcg_gen_setcond_tl(TCG_COND_EQ, dest, t0, cpu_llval);

-- 
2.43.0


