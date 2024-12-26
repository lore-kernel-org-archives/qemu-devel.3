Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56735E7718F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 21:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQvH8-0003mj-Sk; Thu, 26 Dec 2024 16:20:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvH6-0003lQ-9u
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:20:08 -0500
Received: from fhigh-a4-smtp.messagingengine.com ([103.168.172.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvH4-0003B8-IZ
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:20:08 -0500
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 1DE1D1140190;
 Thu, 26 Dec 2024 16:20:06 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Thu, 26 Dec 2024 16:20:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735248006;
 x=1735334406; bh=eXHJ1U0y5JFh/QMeXDd3F6H0yuNld44iqz4yHUgHQtE=; b=
 O5nSkTDVhhCHrlCFCyChbsi9P5A9iu3HffocL0LxZhrOfjW1wq3P3l8l5O574Ed1
 gRngU6fMTq8PvNqnV4Bo1QuwLFct3YaTxn4dLuO374s2bILKVAaudUw6jffI/C+w
 IOixXL0DZBO6WucDhnC8m/GXCEmv459aUdPFTE9GnV3wEZl4l/nKM4q4sy3hpkoZ
 IbKl11YFY+1Wv0a8O7pnzhIlZhoc2Su1s/O7x2sOZXRowOZpc4kEqdG0O/ZPXpF3
 bPZtF1UUirYTQNuT2k4CibZkqxKQi1d5CUmMB3Xtit0aCodz/0Q3gIO7C/3XUjhx
 Q1P8gTYUjtw/xNnUSuFfGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735248006; x=
 1735334406; bh=eXHJ1U0y5JFh/QMeXDd3F6H0yuNld44iqz4yHUgHQtE=; b=U
 G1IGJp1NY1Jzh2H3qi2pxtAaTvCS7Lcdyo1v4984B9i4DiMFEYvkqhkRrhvO7OPi
 O8lLrGzOUMXPj4dWDOqAsUGu92/ujrVmF7JSr/mBdpbfP/lL7y3zEJUA0MnuWZ1k
 hxodHQFFXCQQUk4IUsgjSg5vM1uzK0c18Tfw2uQ0562ByCPyd6sZvADC941Znbxa
 Kz9tRV/eRAgf1RE9+GMHPSYzFciUHyNmPb9NIWD+TKlodIoGbyU2Mf6tSiN5ki+D
 XqtDFTvTl7ix3GYk//sgGpFKxXEj5dMyip9mhybghufDkmQ3CtmRX/RZlJpaleXD
 x5VmIltcvdDm3KHe54+FQ==
X-ME-Sender: <xms:hchtZyX4lA5ghwGOdRxqmwPb-GDpSZ0lE-9t6Vw4OCsxViZ0vZOyYQ>
 <xme:hchtZ-kBcSzoxL5GvKovgcAZozWJmDNv2_hC-ZHulOsx0V5oWQDyiM6vko0is88TX
 7hL0tBd2hMh8bZUFbE>
X-ME-Received: <xmr:hchtZ2Z-ATyTZeKDdwFQaaEioIGGxLYM9asmZmLY_iFXla5mguiWLz-y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddukedgudegkecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:hchtZ5XhHSOHjoWQl3t9o1AKO7VlB1aH8ZJTAoRrrD1kjw-rgh9RUQ>
 <xmx:hchtZ8muBDT6fXC8sJ-v9MbKhrnD5NHfqAlxSwIn1lpbYIz3X3STXA>
 <xmx:hchtZ-edOUv-9RNuqsSqhiFeYwKcDfJaYcy8Qi3R_NmaakUiudg4CQ>
 <xmx:hchtZ-FW9yDgliVQlv0pG5gqQeK6_MPEo23aqnnhSh1cx4p_rWWXiw>
 <xmx:hshtZ3_RGrKQCD72_zdRAeRvmk0pGtGQ_MIhUpg9YY8TN5QnwR48g5UW>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 16:20:04 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 26 Dec 2024 21:19:42 +0000
Subject: [PATCH v2 11/23] target/loongarch: Scrutinise TCG vector
 translation for 32 bit build
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241226-la32-fixes1-v2-11-0414594f8cb5@flygoat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7548;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=B9h13SA8JedUvZZiyRlBBN5M0kMQWk0GNpXduoTwOTc=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvTcE9lhJxmyRU5sL1Jb9Wxh0T+JzjVbu5o+yT0661cWH
 dyvW7++o5SFQYyLQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACayu4nhf5Q019n9EznL3NJC
 UoVFrrnvP9C4cvmdtxo+NjdT7vBdE2JkWLlyUgffmypxE+XNwjlh3qt/rz69YupzX8cpzw28s6I
 N2QE=
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

Fix types for various TCGv.

Performing TCGv type conversion as necessary when interaction with GPR
happens.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/loongarch/tcg/insn_trans/trans_vec.c.inc | 70 +++++++++++++------------
 1 file changed, 36 insertions(+), 34 deletions(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_vec.c.inc b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
index 92b1d22e28934b524a1f6ae6cb2bcbb189de27e3..e8015a332636d77ba72aeefde2e4135cdf2543a2 100644
--- a/target/loongarch/tcg/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
@@ -4761,7 +4761,8 @@ static bool trans_## NAME (DisasContext *ctx, arg_cv *a)                       \
                                                                                \
     tcg_gen_or_i64(t1, al, ah);                                                \
     tcg_gen_setcondi_i64(COND, t1, t1, 0);                                     \
-    tcg_gen_st8_tl(t1, tcg_env, offsetof(CPULoongArchState, cf[a->cd & 0x7])); \
+    tcg_gen_st8_i64(t1, tcg_env, offsetof(CPULoongArchState,                   \
+                                          cf[a->cd & 0x7]));                   \
                                                                                \
     return true;                                                               \
 }
@@ -4807,7 +4808,8 @@ static bool trans_## NAME(DisasContext *ctx, arg_cv * a)                       \
     tcg_gen_or_i64(t2, d[2], d[3]);                                            \
     tcg_gen_or_i64(t1, t2, t1);                                                \
     tcg_gen_setcondi_i64(COND, t1, t1, 0);                                     \
-    tcg_gen_st8_tl(t1, tcg_env, offsetof(CPULoongArchState, cf[a->cd & 0x7])); \
+    tcg_gen_st8_i64(t1, tcg_env, offsetof(CPULoongArchState,                   \
+                                          cf[a->cd & 0x7]));                   \
                                                                                \
     return true;                                                               \
 }
@@ -4850,12 +4852,12 @@ static bool gen_g2x(DisasContext *ctx, arg_vr_i *a, MemOp mop,
     return gen_g2v_vl(ctx, a, 32, mop, func);
 }
 
-TRANS(vinsgr2vr_b, LSX, gen_g2v, MO_8, tcg_gen_st8_i64)
-TRANS(vinsgr2vr_h, LSX, gen_g2v, MO_16, tcg_gen_st16_i64)
-TRANS(vinsgr2vr_w, LSX, gen_g2v, MO_32, tcg_gen_st32_i64)
-TRANS(vinsgr2vr_d, LSX, gen_g2v, MO_64, tcg_gen_st_i64)
-TRANS(xvinsgr2vr_w, LASX, gen_g2x, MO_32, tcg_gen_st32_i64)
-TRANS(xvinsgr2vr_d, LASX, gen_g2x, MO_64, tcg_gen_st_i64)
+TRANS(vinsgr2vr_b, LSX, gen_g2v, MO_8, tcg_gen_st8_tl)
+TRANS(vinsgr2vr_h, LSX, gen_g2v, MO_16, tcg_gen_st16_tl)
+TRANS(vinsgr2vr_w, LSX, gen_g2v, MO_32, tcg_gen_st32_tl)
+TRANS(vinsgr2vr_d, LSX, gen_g2v, MO_64, tcg_gen_st_tl)
+TRANS(xvinsgr2vr_w, LASX, gen_g2x, MO_32, tcg_gen_st32_tl)
+TRANS(xvinsgr2vr_d, LASX, gen_g2x, MO_64, tcg_gen_st_tl)
 
 static bool gen_v2g_vl(DisasContext *ctx, arg_rv_i *a, uint32_t oprsz, MemOp mop,
                        void (*func)(TCGv, TCGv_ptr, tcg_target_long))
@@ -4883,18 +4885,18 @@ static bool gen_x2g(DisasContext *ctx, arg_rv_i *a, MemOp mop,
     return gen_v2g_vl(ctx, a, 32, mop, func);
 }
 
-TRANS(vpickve2gr_b, LSX, gen_v2g, MO_8, tcg_gen_ld8s_i64)
-TRANS(vpickve2gr_h, LSX, gen_v2g, MO_16, tcg_gen_ld16s_i64)
-TRANS(vpickve2gr_w, LSX, gen_v2g, MO_32, tcg_gen_ld32s_i64)
-TRANS(vpickve2gr_d, LSX, gen_v2g, MO_64, tcg_gen_ld_i64)
-TRANS(vpickve2gr_bu, LSX, gen_v2g, MO_8, tcg_gen_ld8u_i64)
-TRANS(vpickve2gr_hu, LSX, gen_v2g, MO_16, tcg_gen_ld16u_i64)
-TRANS(vpickve2gr_wu, LSX, gen_v2g, MO_32, tcg_gen_ld32u_i64)
-TRANS(vpickve2gr_du, LSX, gen_v2g, MO_64, tcg_gen_ld_i64)
-TRANS(xvpickve2gr_w, LASX, gen_x2g, MO_32, tcg_gen_ld32s_i64)
-TRANS(xvpickve2gr_d, LASX, gen_x2g, MO_64, tcg_gen_ld_i64)
-TRANS(xvpickve2gr_wu, LASX, gen_x2g, MO_32, tcg_gen_ld32u_i64)
-TRANS(xvpickve2gr_du, LASX, gen_x2g, MO_64, tcg_gen_ld_i64)
+TRANS(vpickve2gr_b, LSX, gen_v2g, MO_8, tcg_gen_ld8s_tl)
+TRANS(vpickve2gr_h, LSX, gen_v2g, MO_16, tcg_gen_ld16s_tl)
+TRANS(vpickve2gr_w, LSX, gen_v2g, MO_32, tcg_gen_ld32s_tl)
+TRANS(vpickve2gr_d, LSX, gen_v2g, MO_64, tcg_gen_ld_tl)
+TRANS(vpickve2gr_bu, LSX, gen_v2g, MO_8, tcg_gen_ld8u_tl)
+TRANS(vpickve2gr_hu, LSX, gen_v2g, MO_16, tcg_gen_ld16u_tl)
+TRANS(vpickve2gr_wu, LSX, gen_v2g, MO_32, tcg_gen_ld32u_tl)
+TRANS(vpickve2gr_du, LSX, gen_v2g, MO_64, tcg_gen_ld_tl)
+TRANS(xvpickve2gr_w, LASX, gen_x2g, MO_32, tcg_gen_ld32s_tl)
+TRANS(xvpickve2gr_d, LASX, gen_x2g, MO_64, tcg_gen_ld_tl)
+TRANS(xvpickve2gr_wu, LASX, gen_x2g, MO_32, tcg_gen_ld32u_tl)
+TRANS(xvpickve2gr_du, LASX, gen_x2g, MO_64, tcg_gen_ld_tl)
 
 static bool gvec_dup_vl(DisasContext *ctx, arg_vr *a,
                         uint32_t oprsz, MemOp mop)
@@ -4905,8 +4907,8 @@ static bool gvec_dup_vl(DisasContext *ctx, arg_vr *a,
         return true;
     }
 
-    tcg_gen_gvec_dup_i64(mop, vec_full_offset(a->vd),
-                         oprsz, ctx->vl/8, src);
+    tcg_gen_gvec_dup_tl(mop, vec_full_offset(a->vd),
+                         oprsz, ctx->vl/TARGET_LONG_SIZE, src);
     return true;
 }
 
@@ -5007,8 +5009,8 @@ static bool gen_vreplve_vl(DisasContext *ctx, arg_vvr *a,
     if (!check_vec(ctx, oprsz)) {
         return true;
     }
-
-    tcg_gen_andi_i64(t0, gpr_src(ctx, a->rk, EXT_NONE), (LSX_LEN / bit) - 1);
+    tcg_gen_extu_tl_i64(t2, gpr_src(ctx, a->rk, EXT_NONE));
+    tcg_gen_andi_i64(t0, t2, (LSX_LEN / bit) - 1);
     tcg_gen_shli_i64(t0, t0, vece);
     if (HOST_BIG_ENDIAN) {
         tcg_gen_xori_i64(t0, t0, vece << ((LSX_LEN / bit) - 1));
@@ -5099,10 +5101,10 @@ static bool do_vbsll_v(DisasContext *ctx, arg_vv_i *a, uint32_t oprsz)
     }
 
     for (i = 0; i < oprsz / 16; i++) {
-        TCGv desthigh = tcg_temp_new_i64();
-        TCGv destlow = tcg_temp_new_i64();
-        TCGv high = tcg_temp_new_i64();
-        TCGv low = tcg_temp_new_i64();
+        TCGv_i64 desthigh = tcg_temp_new_i64();
+        TCGv_i64 destlow = tcg_temp_new_i64();
+        TCGv_i64 high = tcg_temp_new_i64();
+        TCGv_i64 low = tcg_temp_new_i64();
 
         get_vreg64(low, a->vj, 2 * i);
 
@@ -5131,10 +5133,10 @@ static bool do_vbsrl_v(DisasContext *ctx, arg_vv_i *a, uint32_t oprsz)
     }
 
     for (i = 0; i < oprsz / 16; i++) {
-        TCGv desthigh = tcg_temp_new_i64();
-        TCGv destlow = tcg_temp_new_i64();
-        TCGv high = tcg_temp_new_i64();
-        TCGv low = tcg_temp_new_i64();
+        TCGv_i64 desthigh = tcg_temp_new_i64();
+        TCGv_i64 destlow = tcg_temp_new_i64();
+        TCGv_i64 high = tcg_temp_new_i64();
+        TCGv_i64 low = tcg_temp_new_i64();
         get_vreg64(high, a->vj, 2 * i + 1);
 
         ofs = ((a->imm) & 0xf) * 8;
@@ -5459,7 +5461,7 @@ static void gen_xvld(DisasContext *ctx, int vreg, TCGv addr)
 {
     int i;
     TCGv temp = tcg_temp_new();
-    TCGv dest = tcg_temp_new();
+    TCGv_i64 dest = tcg_temp_new_i64();
 
     tcg_gen_qemu_ld_i64(dest, addr, ctx->mem_idx, MO_TEUQ);
     set_vreg64(dest, vreg, 0);
@@ -5475,7 +5477,7 @@ static void gen_xvst(DisasContext * ctx, int vreg, TCGv addr)
 {
     int i;
     TCGv temp = tcg_temp_new();
-    TCGv dest = tcg_temp_new();
+    TCGv_i64 dest = tcg_temp_new_i64();
 
     get_vreg64(dest, vreg, 0);
     tcg_gen_qemu_st_i64(dest, addr, ctx->mem_idx, MO_TEUQ);

-- 
2.43.0


