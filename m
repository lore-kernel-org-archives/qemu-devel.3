Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108D2E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 21:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQvGp-0003de-UV; Thu, 26 Dec 2024 16:19:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvGo-0003dI-6G
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:19:50 -0500
Received: from fhigh-a4-smtp.messagingengine.com ([103.168.172.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvGm-0002w8-AQ
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:19:49 -0500
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id AE62B1140114;
 Thu, 26 Dec 2024 16:19:47 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Thu, 26 Dec 2024 16:19:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735247987;
 x=1735334387; bh=HzRGBpSsuGYsqp1nebQkdwxhC9+0p8sAf3ZNP4r9fJ8=; b=
 HlSqOc/RYxOZROJoNPzXNZPzoGV3Rv3dMvP4Wm/Oq/qDDQoQEnMs/iEudIYq3JQW
 fkj0D1yn1sfwmJztwo8xPPzQGWgrv3qlb/ykP1tJa/yYCmsjUZjIS3tfcEYjwgs6
 9QOznPXQC5gaFxaB3GZf80wyRAVV1qQDhYITSRv3k05IFU/lRCMDyENyAH2RC344
 +nu6oy9Yb/S5UZLWt4qnr3+gCAQ4pYuW8EvFLV6+8qGvXeE3tUI/CgaTTHh2nuVR
 T5AbUdmeJw2SGu4PzNKSUDxZemZ4ZKPMaCErhQ62z1yv4c0sAEQKwHusP1M/K80Y
 07DdpsbLgtpAW6cl+BcHGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735247987; x=
 1735334387; bh=HzRGBpSsuGYsqp1nebQkdwxhC9+0p8sAf3ZNP4r9fJ8=; b=Z
 0HpOQO4e8Litvp47IYfxq5AIqMs9NC2gBAzKcEIzCN0ffNf87KWpbTnBt+JBHj45
 kbdbi81fX3Rf7R4YonIJfdSiWmXxz7qig5fr8azx8znq2i8brzzIHYXf7nremc+L
 7heF7N/uMXwUaGMduP0dshkAS7rHe9B3klkh1PyUTMW+1bayPWbCxlu55qaBg6cX
 e4ymMKYwOqyl2nuBr13JCKMFBls5lflVH4Yfiqez8O9nBYpRdotKt7S5IHwQ0IGt
 /4suikVVltoTgMyb1bYhnYOp7K5RIljeq96AlG81w/kk00yk49PnFObD8kQaFqrg
 54InmLhwyjihX/AtjYufg==
X-ME-Sender: <xms:c8htZ4WuqIFkzoYsBKJfXKUb-0sR0HObUq6XmR2Z1PAF-GzqsLmgKA>
 <xme:c8htZ8noL0I0AZX1GVdCtt09mjUwRhyCx5WjC5SdSQwgcemdfUdhwQ9YpTwvIsfA_
 4yMZeia5QdECQl09QA>
X-ME-Received: <xmr:c8htZ8YLNxgGwo_PQt-JwpsXf402vxUrQ_-RcKy7QQguSsN9uc4spzBG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddukedgudegjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
 jeenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflh
 ihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleff
 keegudeghfdtuddugefhueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedune
 curfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorght
 rdgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
 htohepmhgrohgsihgsoheslhhoohhnghhsohhnrdgtnhdprhgtphhtthhopehmrghrtggv
 lhdrrghpfhgvlhgsrghumhesghhmrghilhdrtghomhdprhgtphhtthhopehpsghonhiiih
 hnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepghgrohhsohhngheslhhoohhnghhs
 ohhnrdgtnhdprhgtphhtthhopegvsghlrghkvgesrhgvughhrghtrdgtohhmpdhrtghpth
 htohepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomhdprhgtphhtthhopehq
 vghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepfigrnhhghigrnh
 grnhehheeshhhurgifvghirdgtohhmpdhrtghpthhtohepiihhrghouddrlhhiuhesihhn
 thgvlhdrtghomh
X-ME-Proxy: <xmx:c8htZ3VTb5chYBNY_yvvVaTR_JAIqkOyxuwl2sLvBejI5r1ap9g3Tw>
 <xmx:c8htZylrgSGpG-Vk9mwyFlb9n0ILhzh9upeaYLtrNDaOXLH4DGH0BA>
 <xmx:c8htZ8cSFGMxUP6N4KTOOgodM0Ev1JKThTt5TRtF1mNBqtZ_hJNE5g>
 <xmx:c8htZ0FafIxOYNWTjKvv6foxSUneODTkraRJcwEDacuX7rW-Fn8BCQ>
 <xmx:c8htZ99sZ5Cu4f6u5g9QXAjWgkadwCn6s2SLDXzb9vcV7PKU0PusqE2K>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 16:19:45 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 26 Dec 2024 21:19:33 +0000
Subject: [PATCH v2 02/23] target/loongarch: Fix address generation for gen_sc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241226-la32-fixes1-v2-2-0414594f8cb5@flygoat.com>
References: <20241226-la32-fixes1-v2-0-0414594f8cb5@flygoat.com>
In-Reply-To: <20241226-la32-fixes1-v2-0-0414594f8cb5@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1715;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=JXml0K3ROVIscLytx9HCnpVchfiE4wBfBikTFNxlvXg=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvTcE9meQU9vBm/jmtv7TTSD14h5afh17dNHU1e23Yvjm
 7GHhSe6o5SFQYyLQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACYiIcDI8CU1xf/e5sk1J41n
 /n2WuvhhYVjpnNu7Y95wZlpnVfYnXmL4n5Facvrdtm1Rh/Vnlhs41UddsLska7le4cv7fTnfxTf
 18wMA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=103.168.172.155;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh-a4-smtp.messagingengine.com
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


