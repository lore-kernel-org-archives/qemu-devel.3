Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C45FC021A4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 00:42:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmj0n-0005Cc-JM; Mon, 24 Feb 2025 19:41:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tmizt-0004bN-AM
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 19:40:29 -0500
Received: from fout-b6-smtp.messagingengine.com ([202.12.124.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tmizr-0003T0-En
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 19:40:28 -0500
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 6D6FD114016C;
 Mon, 24 Feb 2025 19:40:26 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Mon, 24 Feb 2025 19:40:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1740444026;
 x=1740530426; bh=To9ljGdoXUmo7Z5V/SBdfQXvdYuRRAbw4vPpVlePzWo=; b=
 H967xv3eIHT2bpUgbIyPol1ZjblufCemkqf20y321hiyBIvkLczAQu1YRXn2yk6n
 7kUMjAjjT1mxofm4q0WPa35oGgqXoTsn6lIzbsgj79i5/DjdXahCm/jnhjaFsvL0
 vmOa6O4KPxKED9yoNG6QV8cEaVLw+hH/3vpV0F/7iy0F2zZxT7q5BTlH2r11pseP
 LoJe/gM+aO71jLG5wn2TrgN5KyxywQij4HMMl73NvAR6gYL7JI2ghhwjHTNrMGKC
 wVjYMCzyi7TiS3uWUoORPa1zzBFsuxslGsnL+uwtGX1m9s6zxaK4LjkwRg0Mg97Z
 TuapqnAwXBtxLU+w9N1SYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740444026; x=
 1740530426; bh=To9ljGdoXUmo7Z5V/SBdfQXvdYuRRAbw4vPpVlePzWo=; b=a
 5mRfdXGohV7axCEIAPu5MPmx1YzUIGSkbZ0a5dwoaCYMVMwQ1DeztgM4FTIT8sYi
 Wn/pqyZeooib+vUadPOoh8tsGvX6gMyjWy79kfkeDT9tlGzcBZRMc6Wmo6SuYQW1
 7GET2MwuZQjlQKIGvdaOVY/XobP54jGBf8/rRjpph146NEJ3I/B/s5d+e6yjcov1
 jJ4hBSw80eyeNuKhl+AYeM66ThAHtmD3J3O4KVuyLjGfTe+UtT+nagCD+2crx+Dh
 SFpfaOqsvHqvWl71H4UI2o/Hp+sMDBBZpWMlE/0Ku5XuL6yHmCe1sW6NUhyoXijT
 3l/ozPpsOg2eHpUjsm6NA==
X-ME-Sender: <xms:ehG9Z-oP-pnOD0ZLwaz0v6SIyup3weGyF0ad9zRxmq_INbNKgFDJSA>
 <xme:ehG9Z8oecxna-pWX8n2rV3PU9Oi_OCJJhSN1ZBMdDW4g53FNNdBl83FOdvFAMA9Ex
 bjftFC8eUaOgkcNYBE>
X-ME-Received: <xmr:ehG9ZzPwRck5eV0K64curILJE2L6JBpkHE7Do0_RN15L98wwCNPQ1bY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdektddviecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredt
 jeenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflh
 ihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeevveetheeggfegjeekjedttdet
 ueeludehveejgfejtedvhfdugeetgfelhfevkeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorght
 rdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtth
 hopehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhrtghpthhtohepghgr
 ohhsohhngheslhhoohhnghhsohhnrdgtnhdprhgtphhtthhopehphhhilhhmugeslhhinh
 grrhhordhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhr
 gh
X-ME-Proxy: <xmx:ehG9Z96DfHax6YsBt8rxkfnrDj2T0AHQ79SCwImmDFtcAN2ycPsVAA>
 <xmx:ehG9Z95daaKLJOU59SJcI1A_hfHer7oS4VBVXeBmp4kO7x8ePxAJtA>
 <xmx:ehG9Z9gHwV7qzM5lxo2q-nhgyxuEveLQ7bIPBkWi4EgE7nDDoizCLw>
 <xmx:ehG9Z374-cLKI0abBBuNBWJdqbzc9O5quzfvGNaFJnk8yuoqWyLzyQ>
 <xmx:ehG9Zw3ZtuTKFAHvIavugj0hFQOTeb_dUpJUyXH8eRK41jHrM29wwbIf>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 19:40:25 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 25 Feb 2025 00:40:21 +0000
Subject: [PATCH v2 8/9] target/loongarch: Fix load type for gen_ll
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250225-la32-fixes1-v2-8-8ec68ada3dd5@flygoat.com>
References: <20250225-la32-fixes1-v2-0-8ec68ada3dd5@flygoat.com>
In-Reply-To: <20250225-la32-fixes1-v2-0-8ec68ada3dd5@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
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

gen_ll should use tcg_gen_qemu_ld_tl to load t1, as t1 is
in TCGv which means it should be a tl type value.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/loongarch/tcg/insn_trans/trans_atomic.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
index 8584441b543712af8a56aa234c90fd6370c8df01..138bcb3e9999b2c186057c658a019136311f1b82 100644
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

-- 
2.43.0


