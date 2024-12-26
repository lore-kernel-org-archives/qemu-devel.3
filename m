Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3116E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 21:20:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQvHC-0003oE-Oz; Thu, 26 Dec 2024 16:20:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvH8-0003mp-7e
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:20:11 -0500
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvH6-0003BU-K7
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:20:09 -0500
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 2D14113801EB;
 Thu, 26 Dec 2024 16:20:08 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Thu, 26 Dec 2024 16:20:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735248008;
 x=1735334408; bh=6l3LIdh4Ax+Fdtk2OiropCXlcNte8uxjPLdCcQLxLQI=; b=
 Qdsf66LumW6+mbax+8swojAl+NT97JrY23ASPsohyhx5R/IYqOmKqRRxwG2oNecz
 tKpOT8lh0SVFiO7XXkYEWzUTmcZd9uslA0RXw61VFuz1aENKseId2YptZ2BtPm1x
 30xogz3W+rbZgzzQQUQ1yzmL8XcnCqLgCTDgj/SyAt3HmOXT1iNCmgGvnVEZqMek
 XpS5Xkmc0wCbu9ACO6wf31u9lW1QohlfcgO22XXoPCSOfhhZj0+S3wU+aP+DTmMa
 gdCXeqXnS05ytGcRhdUSSwwvbJvdREZFcU/qN5mrm9i8AO+z24yYQU1V3ovrAS8i
 kQRyWQECMhS2vtSOzcIEOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735248008; x=
 1735334408; bh=6l3LIdh4Ax+Fdtk2OiropCXlcNte8uxjPLdCcQLxLQI=; b=k
 ZcHDRIszTsOL6+cbFBmzzA6UQbE8pXN8228xmQ/ieOePA5O4HoXzPmyVojlEOKpH
 Kr53V9d7elP+jRJnFYR1QIh5bjjYKK4raD9gmCAE7ThK4wQgSRhgJ9238k2tVSqb
 ahk7qnInEkpGplcf+vs42I5t8DJRjzNzvxEqwpriQJIS1YiSQytbpAwvcW11I6vi
 8Z6zly8GKIG+2/TCHX5gr9EQkroUT8G3U3CzY/c0HFCN/UGtAF23FgEkaO8N/LWn
 fofKdKzxlQ9i9b8Lxn/fXLxjBJUwec0Pkjp7VyoToIgQFVnYhzdSb6BTjkHEGLsa
 zmp4ymc/CieXXyLEWYl5Q==
X-ME-Sender: <xms:h8htZ_wES33wKftx0DIDaBbqvr4gpfdBxzZFwzzc3SmUti4mg53dqQ>
 <xme:h8htZ3SjsSfJuKlat7dZa39ay16pkFAmQZ_3pyJL--sapq2J2Xv3et6Pdie7TJb8q
 5nrvf8AxL3tmGCo4yc>
X-ME-Received: <xmr:h8htZ5Uozb2y6e06xkPjT0UBBqQMaMhEAZh_lr3Si6wakn_pZ9M8D5mf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddukedgudegjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
 jeenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflh
 ihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleff
 keegudeghfdtuddugefhueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedtne
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
X-ME-Proxy: <xmx:h8htZ5iRDwdcZdHJQpJnl9QNYruNgBtpIaRAfJJXc8PfgGpNWBJMyA>
 <xmx:h8htZxBS00JOkTkAZJpAA744SBy-s0nPOmmUUjvq0CxwQUSjXZ5bFw>
 <xmx:h8htZyLtWleShvcmH4VSgRMQ-juaCs4ttnblLS0etx92kIlAwrHxow>
 <xmx:h8htZwAVuWzXfBFpYE6avat48DpEKeiTxUlT7NIacS9zOG7b3LXVWQ>
 <xmx:iMhtZ15V1Dc_PKZQYrYwc5UYg59Es0ZPhm4SFCWGhrDZBokyjk-zKEmi>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 16:20:06 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 26 Dec 2024 21:19:43 +0000
Subject: [PATCH v2 12/23] target/loongarch: Scrutinise TCG bitops
 translation for 32 bit build
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241226-la32-fixes1-v2-12-0414594f8cb5@flygoat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3897;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=LoLAL627BxLCze3ZeL8YpKlbo0GtOQXjE4HP5ezEovE=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvTcE9kTlkY0JblOmNmZ4FCS6shoK9Sx9AfjmcMmtQUWc
 zYvW2/VUcrCIMbFICumyBIioNS3ofHigusPsv7AzGFlAhnCwMUpABNx+crIcHS/wFn2hwV1xUvm
 79zx7svqoBvmrXM7k2tFrD6IZf/TusDw3+Vb5t70qlffrinUZTqs2ZR2e9u1jR3fpZ/f83HRFdU
 25QMA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=103.168.172.144;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout-a1-smtp.messagingengine.com
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

Use tl variant whenever possible.

Silent compiler warnings by performing casting for come consts.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/loongarch/tcg/insn_trans/trans_bit.c.inc | 34 ++++++++++++++-----------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_bit.c.inc b/target/loongarch/tcg/insn_trans/trans_bit.c.inc
index ee5fa003ce06a1910f826c3eb96d1d532c32e02c..a40346a670be31a123848e8ea5f7b94f8372976b 100644
--- a/target/loongarch/tcg/insn_trans/trans_bit.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_bit.c.inc
@@ -18,13 +18,17 @@ static bool gen_rr(DisasContext *ctx, arg_rr *a,
 
 static void gen_bytepick_w(TCGv dest, TCGv src1, TCGv src2, target_long sa)
 {
+#ifdef TARGET_LOONGARCH64
     tcg_gen_concat_tl_i64(dest, src1, src2);
     tcg_gen_sextract_i64(dest, dest, (32 - sa * 8), 32);
+#else
+    tcg_gen_extract2_tl(dest, src1, src2, (32 - sa * 8));
+#endif
 }
 
 static void gen_bytepick_d(TCGv dest, TCGv src1, TCGv src2, target_long sa)
 {
-    tcg_gen_extract2_i64(dest, src1, src2, (64 - sa * 8));
+    tcg_gen_extract2_tl(dest, src1, src2, (64 - sa * 8));
 }
 
 static bool gen_bstrins(DisasContext *ctx, arg_rr_ms_ls *a,
@@ -85,7 +89,7 @@ static void gen_cto_w(TCGv dest, TCGv src1)
 
 static void gen_clz_d(TCGv dest, TCGv src1)
 {
-    tcg_gen_clzi_i64(dest, src1, TARGET_LONG_BITS);
+    tcg_gen_clzi_tl(dest, src1, TARGET_LONG_BITS);
 }
 
 static void gen_clo_d(TCGv dest, TCGv src1)
@@ -107,8 +111,8 @@ static void gen_cto_d(TCGv dest, TCGv src1)
 
 static void gen_revb_2w(TCGv dest, TCGv src1)
 {
-    tcg_gen_bswap64_i64(dest, src1);
-    tcg_gen_rotri_i64(dest, dest, 32);
+    tcg_gen_bswap_tl(dest, src1);
+    tcg_gen_rotri_tl(dest, dest, 32);
 }
 
 static void gen_revb_2h(TCGv dest, TCGv src1)
@@ -126,7 +130,7 @@ static void gen_revb_2h(TCGv dest, TCGv src1)
 
 static void gen_revb_4h(TCGv dest, TCGv src1)
 {
-    TCGv mask = tcg_constant_tl(0x00FF00FF00FF00FFULL);
+    TCGv mask = tcg_constant_tl((target_ulong)0x00FF00FF00FF00FFULL);
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
 
@@ -139,22 +143,22 @@ static void gen_revb_4h(TCGv dest, TCGv src1)
 
 static void gen_revh_2w(TCGv dest, TCGv src1)
 {
-    TCGv_i64 t0 = tcg_temp_new_i64();
-    TCGv_i64 t1 = tcg_temp_new_i64();
-    TCGv_i64 mask = tcg_constant_i64(0x0000ffff0000ffffull);
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+    TCGv mask = tcg_constant_tl((target_ulong)0x0000ffff0000ffffull);
 
-    tcg_gen_shri_i64(t0, src1, 16);
-    tcg_gen_and_i64(t1, src1, mask);
-    tcg_gen_and_i64(t0, t0, mask);
-    tcg_gen_shli_i64(t1, t1, 16);
-    tcg_gen_or_i64(dest, t1, t0);
+    tcg_gen_shri_tl(t0, src1, 16);
+    tcg_gen_and_tl(t1, src1, mask);
+    tcg_gen_and_tl(t0, t0, mask);
+    tcg_gen_shli_tl(t1, t1, 16);
+    tcg_gen_or_tl(dest, t1, t0);
 }
 
 static void gen_revh_d(TCGv dest, TCGv src1)
 {
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
-    TCGv mask = tcg_constant_tl(0x0000FFFF0000FFFFULL);
+    TCGv mask = tcg_constant_tl((target_ulong)0x0000FFFF0000FFFFULL);
 
     tcg_gen_shri_tl(t1, src1, 16);
     tcg_gen_and_tl(t1, t1, mask);
@@ -191,7 +195,7 @@ TRANS(ctz_d, 64, gen_rr, EXT_NONE, EXT_NONE, gen_ctz_d)
 TRANS(revb_2h, ALL, gen_rr, EXT_NONE, EXT_SIGN, gen_revb_2h)
 TRANS(revb_4h, 64, gen_rr, EXT_NONE, EXT_NONE, gen_revb_4h)
 TRANS(revb_2w, 64, gen_rr, EXT_NONE, EXT_NONE, gen_revb_2w)
-TRANS(revb_d, 64, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_bswap64_i64)
+TRANS(revb_d, 64, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_bswap_tl)
 TRANS(revh_2w, 64, gen_rr, EXT_NONE, EXT_NONE, gen_revh_2w)
 TRANS(revh_d, 64, gen_rr, EXT_NONE, EXT_NONE, gen_revh_d)
 TRANS(bitrev_4b, ALL, gen_rr, EXT_ZERO, EXT_SIGN, gen_helper_bitswap)

-- 
2.43.0


