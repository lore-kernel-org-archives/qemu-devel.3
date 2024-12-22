Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359D7E7718D
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 23:41:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPVYr-0000Ju-PV; Sun, 22 Dec 2024 18:40:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tPVYn-0000JP-CE
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 18:40:33 -0500
Received: from fhigh-a2-smtp.messagingengine.com ([103.168.172.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tPVYl-0006BO-8a
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 18:40:33 -0500
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 696A31140170;
 Sun, 22 Dec 2024 18:40:30 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Sun, 22 Dec 2024 18:40:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1734910830;
 x=1734997230; bh=wnJHyNacr/JaVXjVhPEC6VlvfjB69COxs2lNV3a+Y3k=; b=
 cmyyQBoPaBOaAE7F8Mrnc7bN3sG6knj2xlako8RXF1epu+QJ3/RRQzGfkrXTE0CX
 973U+gAR6bBCKCNgp8T9g/wp0Gzj8HLl6B6Jfa0W295/jOWEAgoCZgeyQhlj4Udx
 DrtmLSphMRSkCZjiH/ITxF2iFZ/DUz4GcYOPGwiIlHlstuPrswx0C6wSPXcpRO1S
 EWMft7w29+t+oWfeefJ9MKLfQqzTeO2W5NFkzGLRGUuiPcvxDSx36jgCm2XLIaSh
 EM8ocbclp3yfk0KT5YAZuW06kFVii0kfawWL4+9Fj64s80sXRkGTuaEcLqE9nPMD
 na+eTPXJAwe7CpwMR0udxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1734910830; x=
 1734997230; bh=wnJHyNacr/JaVXjVhPEC6VlvfjB69COxs2lNV3a+Y3k=; b=D
 yXwi2wSuY/sZqJB4pNpabfmPluZMstuIyNe9GSmgPri0/G8zM7PJcfs8wInUsQOc
 7uNTgesye+lwbDWw3KQekf6JlMqeGCV1wP4KoYUKG7aigq8m/YNuWoFfwueK1A88
 6AtXlABW/lE1dmNhjqrK9r/pS4vZ4MAYYYjMGru+1x750nWghh49Uqmeud695/Pr
 cGtpC11Rq114HNkr4u0UG3jetEJUi2Kk67KJwsot48TizTj7ulooo7JZk8aXAi1n
 C+AngW10lUVp2rhK3YpZk9TGCI2z07h4OfosH81FJC3AjaxJ5BKHaa9Aw0mXSnAj
 AoJEnyLdExnPrh/2vS10w==
X-ME-Sender: <xms:bqNoZw2GK30kkf22x8JWote_ZPGfUO0VseP-ZJneWI7lLTp92qYIew>
 <xme:bqNoZ7Hd6Yfgyxuzx_Sh3iELnKWA7VJz3P4jHd23yXV5KVXw9l8lk4D0znDx8164z
 pbbD0US0nwTmQ_kGMI>
X-ME-Received: <xmr:bqNoZ47CTNDcNStPa7CeZbAzOJEUXe-kWhvF5Rs8HP-62ODAh9Cqkp-c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtledgudefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
 necuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhi
 hgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffek
 gedugefhtdduudeghfeuveegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdr
 tghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
 epqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehjihgrgihu
 nhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhrtghpthhtohepghgrohhsohhngheslh
 hoohhnghhsohhnrdgtnh
X-ME-Proxy: <xmx:bqNoZ53WRWuT5TR4v3IqLxxx_au5DpQ9-9TZGExmVMDXbgakUcknkA>
 <xmx:bqNoZzEzjaaQgs4ZwS3CMk8KoJv7IPsKr1EUM-lX5tgmPsyAfRICFg>
 <xmx:bqNoZy9uL_aJfirppVTEbMNn2KYWrNTSh4omcRM_OCB6T9eSyD2lKQ>
 <xmx:bqNoZ4m1ITf4Kl8CJZlU3aXtf-09ux71Ch2UrsXs5gTgsKEAlOoZ9g>
 <xmx:bqNoZ7DK_zQOVNuS2_Bn4mkkaPYgtjSnFnjln4h-_RJaXea7Et7up8Oy>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Dec 2024 18:40:29 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Sun, 22 Dec 2024 23:40:26 +0000
Subject: [PATCH 2/3] target/loongarch: Fix LLSC for LoongArch32
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241222-la32-fixes1-v1-2-8c62b7e594db@flygoat.com>
References: <20241222-la32-fixes1-v1-0-8c62b7e594db@flygoat.com>
In-Reply-To: <20241222-la32-fixes1-v1-0-8c62b7e594db@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1603;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=OtFGtow9PzLmAd3ZSoPdl+J0IhcJdBLYWcZAIb5YQIg=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvSMxVmtnO0uK/p9vliz3Wk9tHdTZlKK6Z9t2xayyyYUb
 eHquMzcUcrCIMbFICumyBIioNS3ofHigusPsv7AzGFlAhnCwMUpABPZJMLwT+HYwvCutzNq9nk/
 8/5etGu9tsNbze89T+dNzDB3yKx8sJfhn6pIcIW/RfA9Xg3LzDzGwIyLxqI/I09s+LtXjuPS2tO
 9vAA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=103.168.172.153;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh-a2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

gen_ll should use tcg_gen_qemu_ld_tl to load t1, as t1 is
in TCGv which means it should be a tl type value.

gen_sc should use make_address_i to obtain source address
to ensure that address is properly truncated.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/loongarch/tcg/insn_trans/trans_atomic.c.inc | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
index 974bc2a70feddbf021a07b19a0859781eb3a11c4..4607f19b003ae70e5ca1e5b56b174bd7696d54cd 100644
--- a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
@@ -9,7 +9,7 @@ static bool gen_ll(DisasContext *ctx, arg_rr_i *a, MemOp mop)
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv t0 = make_address_i(ctx, src1, a->imm);
 
-    tcg_gen_qemu_ld_i64(t1, t0, ctx->mem_idx, mop);
+    tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, mop);
     tcg_gen_st_tl(t0, tcg_env, offsetof(CPULoongArchState, lladdr));
     tcg_gen_st_tl(t1, tcg_env, offsetof(CPULoongArchState, llval));
     gen_set_gpr(a->rd, t1, EXT_NONE);
@@ -28,7 +28,8 @@ static bool gen_sc(DisasContext *ctx, arg_rr_i *a, MemOp mop)
     TCGLabel *l1 = gen_new_label();
     TCGLabel *done = gen_new_label();
 
-    tcg_gen_addi_tl(t0, src1, a->imm);
+    tcg_gen_mov_tl(t0, src1);
+    t0 = make_address_i(ctx, t0, a->imm);
     tcg_gen_brcond_tl(TCG_COND_EQ, t0, cpu_lladdr, l1);
     tcg_gen_movi_tl(dest, 0);
     tcg_gen_br(done);

-- 
2.43.0


