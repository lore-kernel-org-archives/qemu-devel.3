Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C244E7718F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 21:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQvH7-0003mT-Jo; Thu, 26 Dec 2024 16:20:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvH6-0003l9-5A
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:20:08 -0500
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvH2-0003AU-Kh
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:20:07 -0500
Received: from phl-compute-08.internal (phl-compute-08.phl.internal
 [10.202.2.48])
 by mailfout.phl.internal (Postfix) with ESMTP id 266BE13801E2;
 Thu, 26 Dec 2024 16:20:04 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-08.internal (MEProxy); Thu, 26 Dec 2024 16:20:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735248004;
 x=1735334404; bh=NSZZ3jxcOftJDFqJOa6TOprhs/qkAO+ohEaeLDCpGNg=; b=
 oOiyDL0ewXGHZsQPpXoOV9VwcqsEpXMqqb74lQFRbEHVel4Fgu/QDP3YWxmRj/75
 b10oy4bfFQfF3TtbZ4naAZvLjYwKIDPiAd20dMc+s45Ypoy6gnTg6mWxUPZ5UiUI
 CdosOTnFaGzk8qjBebltfnwQh+D/Uf0JkqH1LMg8KS5bzoP723GvquP4BX6ENDeE
 fiIgGA3K+py+b5xtjYxyPAsaYd7C7eBw2+dHh8n+KhMAwrrN8F7Y8U0GbPMKWhIP
 9vw3vGcpRxx9Qmx4kTYYZGy3g4rPZ/KvTb6VRGQRZ5J+Uo3+LfBLM2mdBe8vRNnS
 Ben/LhG4G9Kgo5+xsd++9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735248004; x=
 1735334404; bh=NSZZ3jxcOftJDFqJOa6TOprhs/qkAO+ohEaeLDCpGNg=; b=E
 QVgmwQodku+fwPJrUJX1rW+d9SfUIyNM4LvEVc8EFyez2Vdttpw8RSBdisRg07VI
 eYIk3/xTGPH+6hM8hD6Ug25mNXCdRK3zBkCRxa1ALYz3R/xYzvWydyI2fd40qwdw
 ZMkgaj0TkLUNSEeCdHklOiyUjmdGNAKJya4DJkOKVm0PBjS14VyOIyz6sE+AM/iU
 2o/4iemaxSMp9bzpHOS+dags6Ozfiuu4pXQvCfZd0ccQyVh7efJlsISDuT7oftWX
 wb0/uNErAa26WbCO9HsPN769534FHxXQkuHzFuSfjkKyhKznRKXftXTdonElzawS
 REY4AOrSQWby7oi8cqyPQ==
X-ME-Sender: <xms:g8htZ5rgr2eiNPAXm-6_pNQr3SVAt0icy5OhLY7Cwzea39dYEWchRA>
 <xme:g8htZ7oZmwuWDVwpjW9EGoGmg7zbSJxE-J-dTXTIgy8n8M5mKlf2SaR8fQ9UzT8Bb
 oOGeYaS_1e7wP0nQFQ>
X-ME-Received: <xmr:g8htZ2No_0Tlk7WFMNNAyJj1gFOthPvFlBMY_VaiyhsSNkUz_7w_x7zO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddukedgudegkecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:g8htZ07QrzLh7d7HDqxxWnPSburbUu_6MbuJexbZYqD2_u74Ptjiyw>
 <xmx:g8htZ46JLXIFcOrmCMWPHf5ezwIskX8_rZvcW3ZQ6EOY3JIoVNSbqw>
 <xmx:g8htZ8jBx_q1Reeloetiu_T70XYs7REgcZ7qF5F9TQFVUFbxr-1AoA>
 <xmx:g8htZ67DJMZsAkTE8LyK0yci46wPBYBMSvJMptxCX_KEcG3A0NUpiQ>
 <xmx:hMhtZ4wLYSoKSKgMutE8x9wWAn8I28vfpWoaxlu4sWy9Y36Zm-63dpsC>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 16:20:02 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 26 Dec 2024 21:19:41 +0000
Subject: [PATCH v2 10/23] target/loongarch: Scrutinise TCG float
 translation for 32 bit build
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241226-la32-fixes1-v2-10-0414594f8cb5@flygoat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=20175;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=uF1DCcggUmda9FIY5oD1gPEWiTNTJF+Bx0t7eB0/zko=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvTcE9k8633U5x9ln54+LU75wo3Vjh8PsLbWi20V07jms
 2qaqeSJjlIWBjEuBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZhIyW5Ghm3tgmtNhY6/T7z7
 4lvgzGj/n+tCN56sdys8ff3el3mzXVcw/LPVTV4YELEg6JLeDONz/1r3TZateHNBpqohsT0j4De
 /CDsA
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

All float computations are kept to be 64 bit, fix types for various TCGv.

Performing TCGv type conversion as necessary when interaction with GPR
happens.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/loongarch/tcg/insn_trans/trans_farith.c.inc | 53 +++++++-------
 target/loongarch/tcg/insn_trans/trans_fcmp.c.inc   | 16 ++---
 .../loongarch/tcg/insn_trans/trans_fmemory.c.inc   | 34 ++++-----
 target/loongarch/tcg/insn_trans/trans_fmov.c.inc   | 83 ++++++++++++----------
 target/loongarch/tcg/translate.c                   |  6 +-
 5 files changed, 99 insertions(+), 93 deletions(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_farith.c.inc b/target/loongarch/tcg/insn_trans/trans_farith.c.inc
index f4a0dea72701a99954d8ff8fc9be2eb55e2f39a8..de8101334c67285dba801309bcd652f54326ad25 100644
--- a/target/loongarch/tcg/insn_trans/trans_farith.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_farith.c.inc
@@ -15,11 +15,11 @@
 #endif
 
 static bool gen_fff(DisasContext *ctx, arg_fff *a,
-                    void (*func)(TCGv, TCGv_env, TCGv, TCGv))
+                    void (*func)(TCGv_i64, TCGv_env, TCGv_i64, TCGv_i64))
 {
-    TCGv dest = get_fpr(ctx, a->fd);
-    TCGv src1 = get_fpr(ctx, a->fj);
-    TCGv src2 = get_fpr(ctx, a->fk);
+    TCGv_i64 dest = get_fpr(ctx, a->fd);
+    TCGv_i64 src1 = get_fpr(ctx, a->fj);
+    TCGv_i64 src2 = get_fpr(ctx, a->fk);
 
     CHECK_FPE;
 
@@ -30,10 +30,10 @@ static bool gen_fff(DisasContext *ctx, arg_fff *a,
 }
 
 static bool gen_ff(DisasContext *ctx, arg_ff *a,
-                   void (*func)(TCGv, TCGv_env, TCGv))
+                   void (*func)(TCGv_i64, TCGv_env, TCGv_i64))
 {
-    TCGv dest = get_fpr(ctx, a->fd);
-    TCGv src = get_fpr(ctx, a->fj);
+    TCGv_i64 dest = get_fpr(ctx, a->fd);
+    TCGv_i64 src = get_fpr(ctx, a->fj);
 
     CHECK_FPE;
 
@@ -44,14 +44,15 @@ static bool gen_ff(DisasContext *ctx, arg_ff *a,
 }
 
 static bool gen_muladd(DisasContext *ctx, arg_ffff *a,
-                       void (*func)(TCGv, TCGv_env, TCGv, TCGv, TCGv, TCGv_i32),
+                       void (*func)(TCGv_i64, TCGv_env, TCGv_i64,
+                                    TCGv_i64, TCGv_i64, TCGv_i32),
                        int flag)
 {
     TCGv_i32 tflag = tcg_constant_i32(flag);
-    TCGv dest = get_fpr(ctx, a->fd);
-    TCGv src1 = get_fpr(ctx, a->fj);
-    TCGv src2 = get_fpr(ctx, a->fk);
-    TCGv src3 = get_fpr(ctx, a->fa);
+    TCGv_i64 dest = get_fpr(ctx, a->fd);
+    TCGv_i64 src1 = get_fpr(ctx, a->fj);
+    TCGv_i64 src2 = get_fpr(ctx, a->fk);
+    TCGv_i64 src3 = get_fpr(ctx, a->fa);
 
     CHECK_FPE;
 
@@ -63,9 +64,9 @@ static bool gen_muladd(DisasContext *ctx, arg_ffff *a,
 
 static bool trans_fcopysign_s(DisasContext *ctx, arg_fcopysign_s *a)
 {
-    TCGv dest = get_fpr(ctx, a->fd);
-    TCGv src1 = get_fpr(ctx, a->fk);
-    TCGv src2 = get_fpr(ctx, a->fj);
+    TCGv_i64 dest = get_fpr(ctx, a->fd);
+    TCGv_i64 src1 = get_fpr(ctx, a->fk);
+    TCGv_i64 src2 = get_fpr(ctx, a->fj);
 
     if (!avail_FP_SP(ctx)) {
         return false;
@@ -81,9 +82,9 @@ static bool trans_fcopysign_s(DisasContext *ctx, arg_fcopysign_s *a)
 
 static bool trans_fcopysign_d(DisasContext *ctx, arg_fcopysign_d *a)
 {
-    TCGv dest = get_fpr(ctx, a->fd);
-    TCGv src1 = get_fpr(ctx, a->fk);
-    TCGv src2 = get_fpr(ctx, a->fj);
+    TCGv_i64 dest = get_fpr(ctx, a->fd);
+    TCGv_i64 src1 = get_fpr(ctx, a->fk);
+    TCGv_i64 src2 = get_fpr(ctx, a->fj);
 
     if (!avail_FP_DP(ctx)) {
         return false;
@@ -99,8 +100,8 @@ static bool trans_fcopysign_d(DisasContext *ctx, arg_fcopysign_d *a)
 
 static bool trans_fabs_s(DisasContext *ctx, arg_fabs_s *a)
 {
-    TCGv dest = get_fpr(ctx, a->fd);
-    TCGv src = get_fpr(ctx, a->fj);
+    TCGv_i64 dest = get_fpr(ctx, a->fd);
+    TCGv_i64 src = get_fpr(ctx, a->fj);
 
     if (!avail_FP_SP(ctx)) {
         return false;
@@ -117,8 +118,8 @@ static bool trans_fabs_s(DisasContext *ctx, arg_fabs_s *a)
 
 static bool trans_fabs_d(DisasContext *ctx, arg_fabs_d *a)
 {
-    TCGv dest = get_fpr(ctx, a->fd);
-    TCGv src = get_fpr(ctx, a->fj);
+    TCGv_i64 dest = get_fpr(ctx, a->fd);
+    TCGv_i64 src = get_fpr(ctx, a->fj);
 
     if (!avail_FP_DP(ctx)) {
         return false;
@@ -134,8 +135,8 @@ static bool trans_fabs_d(DisasContext *ctx, arg_fabs_d *a)
 
 static bool trans_fneg_s(DisasContext *ctx, arg_fneg_s *a)
 {
-    TCGv dest = get_fpr(ctx, a->fd);
-    TCGv src = get_fpr(ctx, a->fj);
+    TCGv_i64 dest = get_fpr(ctx, a->fd);
+    TCGv_i64 src = get_fpr(ctx, a->fj);
 
     if (!avail_FP_SP(ctx)) {
         return false;
@@ -152,8 +153,8 @@ static bool trans_fneg_s(DisasContext *ctx, arg_fneg_s *a)
 
 static bool trans_fneg_d(DisasContext *ctx, arg_fneg_d *a)
 {
-    TCGv dest = get_fpr(ctx, a->fd);
-    TCGv src = get_fpr(ctx, a->fj);
+    TCGv_i64 dest = get_fpr(ctx, a->fd);
+    TCGv_i64 src = get_fpr(ctx, a->fj);
 
     if (!avail_FP_DP(ctx)) {
         return false;
diff --git a/target/loongarch/tcg/insn_trans/trans_fcmp.c.inc b/target/loongarch/tcg/insn_trans/trans_fcmp.c.inc
index 3babf69e4ab556842be2a83a98215da607d9a044..f0cefc75070825469bac09c59d11637d35586602 100644
--- a/target/loongarch/tcg/insn_trans/trans_fcmp.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_fcmp.c.inc
@@ -25,9 +25,9 @@ static uint32_t get_fcmp_flags(int cond)
 
 static bool trans_fcmp_cond_s(DisasContext *ctx, arg_fcmp_cond_s *a)
 {
-    TCGv var, src1, src2;
+    TCGv_i64 var, src1, src2;
     uint32_t flags;
-    void (*fn)(TCGv, TCGv_env, TCGv, TCGv, TCGv_i32);
+    void (*fn)(TCGv_i64, TCGv_env, TCGv_i64, TCGv_i64, TCGv_i32);
 
     if (!avail_FP_SP(ctx)) {
         return false;
@@ -35,7 +35,7 @@ static bool trans_fcmp_cond_s(DisasContext *ctx, arg_fcmp_cond_s *a)
 
     CHECK_FPE;
 
-    var = tcg_temp_new();
+    var = tcg_temp_new_i64();
     src1 = get_fpr(ctx, a->fj);
     src2 = get_fpr(ctx, a->fk);
     fn = (a->fcond & 1 ? gen_helper_fcmp_s_s : gen_helper_fcmp_c_s);
@@ -43,15 +43,15 @@ static bool trans_fcmp_cond_s(DisasContext *ctx, arg_fcmp_cond_s *a)
 
     fn(var, tcg_env, src1, src2, tcg_constant_i32(flags));
 
-    tcg_gen_st8_tl(var, tcg_env, offsetof(CPULoongArchState, cf[a->cd]));
+    tcg_gen_st8_i64(var, tcg_env, offsetof(CPULoongArchState, cf[a->cd]));
     return true;
 }
 
 static bool trans_fcmp_cond_d(DisasContext *ctx, arg_fcmp_cond_d *a)
 {
-    TCGv var, src1, src2;
+    TCGv_i64 var, src1, src2;
     uint32_t flags;
-    void (*fn)(TCGv, TCGv_env, TCGv, TCGv, TCGv_i32);
+    void (*fn)(TCGv_i64, TCGv_env, TCGv_i64, TCGv_i64, TCGv_i32);
 
     if (!avail_FP_DP(ctx)) {
         return false;
@@ -59,7 +59,7 @@ static bool trans_fcmp_cond_d(DisasContext *ctx, arg_fcmp_cond_d *a)
 
     CHECK_FPE;
 
-    var = tcg_temp_new();
+    var = tcg_temp_new_i64();
     src1 = get_fpr(ctx, a->fj);
     src2 = get_fpr(ctx, a->fk);
     fn = (a->fcond & 1 ? gen_helper_fcmp_s_d : gen_helper_fcmp_c_d);
@@ -67,6 +67,6 @@ static bool trans_fcmp_cond_d(DisasContext *ctx, arg_fcmp_cond_d *a)
 
     fn(var, tcg_env, src1, src2, tcg_constant_i32(flags));
 
-    tcg_gen_st8_tl(var, tcg_env, offsetof(CPULoongArchState, cf[a->cd]));
+    tcg_gen_st8_i64(var, tcg_env, offsetof(CPULoongArchState, cf[a->cd]));
     return true;
 }
diff --git a/target/loongarch/tcg/insn_trans/trans_fmemory.c.inc b/target/loongarch/tcg/insn_trans/trans_fmemory.c.inc
index 13452bc7e56aef1ae7388d37bc45776cba536a75..79e2506157ab04e68cf8d7091038ecce75a4683a 100644
--- a/target/loongarch/tcg/insn_trans/trans_fmemory.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_fmemory.c.inc
@@ -3,7 +3,7 @@
  * Copyright (c) 2021 Loongson Technology Corporation Limited
  */
 
-static void maybe_nanbox_load(TCGv freg, MemOp mop)
+static void maybe_nanbox_load(TCGv_i64 freg, MemOp mop)
 {
     if ((mop & MO_SIZE) == MO_32) {
         gen_nanbox_s(freg, freg);
@@ -13,13 +13,13 @@ static void maybe_nanbox_load(TCGv freg, MemOp mop)
 static bool gen_fload_i(DisasContext *ctx, arg_fr_i *a, MemOp mop)
 {
     TCGv addr = gpr_src(ctx, a->rj, EXT_NONE);
-    TCGv dest = get_fpr(ctx, a->fd);
+    TCGv_i64 dest = get_fpr(ctx, a->fd);
 
     CHECK_FPE;
 
     addr = make_address_i(ctx, addr, a->imm);
 
-    tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
+    tcg_gen_qemu_ld_i64(dest, addr, ctx->mem_idx, mop);
     maybe_nanbox_load(dest, mop);
     set_fpr(a->fd, dest);
 
@@ -29,13 +29,13 @@ static bool gen_fload_i(DisasContext *ctx, arg_fr_i *a, MemOp mop)
 static bool gen_fstore_i(DisasContext *ctx, arg_fr_i *a, MemOp mop)
 {
     TCGv addr = gpr_src(ctx, a->rj, EXT_NONE);
-    TCGv src = get_fpr(ctx, a->fd);
+    TCGv_i64 src = get_fpr(ctx, a->fd);
 
     CHECK_FPE;
 
     addr = make_address_i(ctx, addr, a->imm);
 
-    tcg_gen_qemu_st_tl(src, addr, ctx->mem_idx, mop);
+    tcg_gen_qemu_st_i64(src, addr, ctx->mem_idx, mop);
 
     return true;
 }
@@ -44,13 +44,13 @@ static bool gen_floadx(DisasContext *ctx, arg_frr *a, MemOp mop)
 {
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
-    TCGv dest = get_fpr(ctx, a->fd);
+    TCGv_i64 dest = get_fpr(ctx, a->fd);
     TCGv addr;
 
     CHECK_FPE;
 
     addr = make_address_x(ctx, src1, src2);
-    tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
+    tcg_gen_qemu_ld_i64(dest, addr, ctx->mem_idx, mop);
     maybe_nanbox_load(dest, mop);
     set_fpr(a->fd, dest);
 
@@ -61,13 +61,13 @@ static bool gen_fstorex(DisasContext *ctx, arg_frr *a, MemOp mop)
 {
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
-    TCGv src3 = get_fpr(ctx, a->fd);
+    TCGv_i64 src3 = get_fpr(ctx, a->fd);
     TCGv addr;
 
     CHECK_FPE;
 
     addr = make_address_x(ctx, src1, src2);
-    tcg_gen_qemu_st_tl(src3, addr, ctx->mem_idx, mop);
+    tcg_gen_qemu_st_i64(src3, addr, ctx->mem_idx, mop);
 
     return true;
 }
@@ -76,14 +76,14 @@ static bool gen_fload_gt(DisasContext *ctx, arg_frr *a, MemOp mop)
 {
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
-    TCGv dest = get_fpr(ctx, a->fd);
+    TCGv_i64 dest = get_fpr(ctx, a->fd);
     TCGv addr;
 
     CHECK_FPE;
 
     gen_helper_asrtgt_d(tcg_env, src1, src2);
     addr = make_address_x(ctx, src1, src2);
-    tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
+    tcg_gen_qemu_ld_i64(dest, addr, ctx->mem_idx, mop);
     maybe_nanbox_load(dest, mop);
     set_fpr(a->fd, dest);
 
@@ -94,14 +94,14 @@ static bool gen_fstore_gt(DisasContext *ctx, arg_frr *a, MemOp mop)
 {
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
-    TCGv src3 = get_fpr(ctx, a->fd);
+    TCGv_i64 src3 = get_fpr(ctx, a->fd);
     TCGv addr;
 
     CHECK_FPE;
 
     gen_helper_asrtgt_d(tcg_env, src1, src2);
     addr = make_address_x(ctx, src1, src2);
-    tcg_gen_qemu_st_tl(src3, addr, ctx->mem_idx, mop);
+    tcg_gen_qemu_st_i64(src3, addr, ctx->mem_idx, mop);
 
     return true;
 }
@@ -110,14 +110,14 @@ static bool gen_fload_le(DisasContext *ctx, arg_frr *a, MemOp mop)
 {
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
-    TCGv dest = get_fpr(ctx, a->fd);
+    TCGv_i64 dest = get_fpr(ctx, a->fd);
     TCGv addr;
 
     CHECK_FPE;
 
     gen_helper_asrtle_d(tcg_env, src1, src2);
     addr = make_address_x(ctx, src1, src2);
-    tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
+    tcg_gen_qemu_ld_i64(dest, addr, ctx->mem_idx, mop);
     maybe_nanbox_load(dest, mop);
     set_fpr(a->fd, dest);
 
@@ -128,14 +128,14 @@ static bool gen_fstore_le(DisasContext *ctx, arg_frr *a, MemOp mop)
 {
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
-    TCGv src3 = get_fpr(ctx, a->fd);
+    TCGv_i64 src3 = get_fpr(ctx, a->fd);
     TCGv addr;
 
     CHECK_FPE;
 
     gen_helper_asrtle_d(tcg_env, src1, src2);
     addr = make_address_x(ctx, src1, src2);
-    tcg_gen_qemu_st_tl(src3, addr, ctx->mem_idx, mop);
+    tcg_gen_qemu_st_i64(src3, addr, ctx->mem_idx, mop);
 
     return true;
 }
diff --git a/target/loongarch/tcg/insn_trans/trans_fmov.c.inc b/target/loongarch/tcg/insn_trans/trans_fmov.c.inc
index 5cbd9d3f347128852ba1933a5961148464f1bbf5..58ce4d3c45d84a5de19358dd289b87aef2cb1078 100644
--- a/target/loongarch/tcg/insn_trans/trans_fmov.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_fmov.c.inc
@@ -9,11 +9,11 @@ static const uint32_t fcsr_mask[4] = {
 
 static bool trans_fsel(DisasContext *ctx, arg_fsel *a)
 {
-    TCGv zero = tcg_constant_tl(0);
-    TCGv dest = get_fpr(ctx, a->fd);
-    TCGv src1 = get_fpr(ctx, a->fj);
-    TCGv src2 = get_fpr(ctx, a->fk);
-    TCGv cond;
+    TCGv_i64 zero = tcg_constant_i64(0);
+    TCGv_i64 dest = get_fpr(ctx, a->fd);
+    TCGv_i64 src1 = get_fpr(ctx, a->fj);
+    TCGv_i64 src2 = get_fpr(ctx, a->fk);
+    TCGv_i64 cond;
 
     if (!avail_FP(ctx)) {
         return false;
@@ -21,19 +21,19 @@ static bool trans_fsel(DisasContext *ctx, arg_fsel *a)
 
     CHECK_FPE;
 
-    cond = tcg_temp_new();
-    tcg_gen_ld8u_tl(cond, tcg_env, offsetof(CPULoongArchState, cf[a->ca]));
-    tcg_gen_movcond_tl(TCG_COND_EQ, dest, cond, zero, src1, src2);
+    cond = tcg_temp_new_i64();
+    tcg_gen_ld8u_i64(cond, tcg_env, offsetof(CPULoongArchState, cf[a->ca]));
+    tcg_gen_movcond_i64(TCG_COND_EQ, dest, cond, zero, src1, src2);
     set_fpr(a->fd, dest);
 
     return true;
 }
 
 static bool gen_f2f(DisasContext *ctx, arg_ff *a,
-                    void (*func)(TCGv, TCGv), bool nanbox)
+                    void (*func)(TCGv_i64, TCGv_i64), bool nanbox)
 {
-    TCGv dest = get_fpr(ctx, a->fd);
-    TCGv src = get_fpr(ctx, a->fj);
+    TCGv_i64 dest = get_fpr(ctx, a->fd);
+    TCGv_i64 src = get_fpr(ctx, a->fj);
 
     CHECK_FPE;
 
@@ -47,17 +47,18 @@ static bool gen_f2f(DisasContext *ctx, arg_ff *a,
 }
 
 static bool gen_r2f(DisasContext *ctx, arg_fr *a,
-                    void (*func)(TCGv, TCGv))
+                    void (*func)(TCGv_i64, TCGv_i64))
 {
-    TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
-    TCGv dest = get_fpr(ctx, a->fd);
+    TCGv rj = gpr_src(ctx, a->rj, EXT_NONE);
+    TCGv_i64 dest = get_fpr(ctx, a->fd);
+    TCGv_i64 src = tcg_temp_new_i64();
 
     if (!avail_FP(ctx)) {
         return false;
     }
 
     CHECK_FPE;
-
+    tcg_gen_ext_tl_i64(src, rj);
     func(dest, src);
     set_fpr(a->fd, dest);
 
@@ -65,10 +66,11 @@ static bool gen_r2f(DisasContext *ctx, arg_fr *a,
 }
 
 static bool gen_f2r(DisasContext *ctx, arg_rf *a,
-                    void (*func)(TCGv, TCGv))
+                    void (*func)(TCGv_i64, TCGv_i64))
 {
-    TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
-    TCGv src = get_fpr(ctx, a->fj);
+    TCGv rd = gpr_dst(ctx, a->rd, EXT_NONE);
+    TCGv_i64 src = get_fpr(ctx, a->fj);
+    TCGv_i64 dest = tcg_temp_new_i64();
 
     if (!avail_FP(ctx)) {
         return false;
@@ -77,7 +79,8 @@ static bool gen_f2r(DisasContext *ctx, arg_rf *a,
     CHECK_FPE;
 
     func(dest, src);
-    gen_set_gpr(a->rd, dest, EXT_NONE);
+    tcg_gen_trunc_i64_tl(rd, dest);
+    gen_set_gpr(a->rd, rd, EXT_NONE);
 
     return true;
 }
@@ -94,13 +97,13 @@ static bool trans_movgr2fcsr(DisasContext *ctx, arg_movgr2fcsr *a)
     CHECK_FPE;
 
     if (mask == UINT32_MAX) {
-        tcg_gen_st32_i64(Rj, tcg_env, offsetof(CPULoongArchState, fcsr0));
+        tcg_gen_st32_tl(Rj, tcg_env, offsetof(CPULoongArchState, fcsr0));
     } else {
         TCGv_i32 fcsr0 = tcg_temp_new_i32();
         TCGv_i32 temp = tcg_temp_new_i32();
 
         tcg_gen_ld_i32(fcsr0, tcg_env, offsetof(CPULoongArchState, fcsr0));
-        tcg_gen_extrl_i64_i32(temp, Rj);
+        tcg_gen_trunc_tl_i32(temp, Rj);
         tcg_gen_andi_i32(temp, temp, mask);
         tcg_gen_andi_i32(fcsr0, fcsr0, ~mask);
         tcg_gen_or_i32(fcsr0, fcsr0, temp);
@@ -127,32 +130,34 @@ static bool trans_movfcsr2gr(DisasContext *ctx, arg_movfcsr2gr *a)
 
     CHECK_FPE;
 
-    tcg_gen_ld32u_i64(dest, tcg_env, offsetof(CPULoongArchState, fcsr0));
-    tcg_gen_andi_i64(dest, dest, fcsr_mask[a->fcsrs]);
+    tcg_gen_ld32u_tl(dest, tcg_env, offsetof(CPULoongArchState, fcsr0));
+    tcg_gen_andi_tl(dest, dest, fcsr_mask[a->fcsrs]);
     gen_set_gpr(a->rd, dest, EXT_NONE);
 
     return true;
 }
 
-static void gen_movgr2fr_w(TCGv dest, TCGv src)
+static void gen_movgr2fr_w(TCGv_i64 dest, TCGv_i64 src)
 {
+
     tcg_gen_deposit_i64(dest, dest, src, 0, 32);
 }
 
-static void gen_movgr2frh_w(TCGv dest, TCGv src)
+static void gen_movgr2frh_w(TCGv_i64 dest, TCGv_i64 src)
 {
     tcg_gen_deposit_i64(dest, dest, src, 32, 32);
 }
 
-static void gen_movfrh2gr_s(TCGv dest, TCGv src)
+static void gen_movfrh2gr_s(TCGv_i64 dest, TCGv_i64 src)
 {
-    tcg_gen_sextract_tl(dest, src, 32, 32);
+    tcg_gen_sextract_i64(dest, src, 32, 32);
+    tcg_gen_ext32s_i64(dest, dest);
 }
 
 static bool trans_movfr2cf(DisasContext *ctx, arg_movfr2cf *a)
 {
-    TCGv t0;
-    TCGv src = get_fpr(ctx, a->fj);
+    TCGv_i64 t0;
+    TCGv_i64 src = get_fpr(ctx, a->fj);
 
     if (!avail_FP(ctx)) {
         return false;
@@ -160,16 +165,16 @@ static bool trans_movfr2cf(DisasContext *ctx, arg_movfr2cf *a)
 
     CHECK_FPE;
 
-    t0 = tcg_temp_new();
-    tcg_gen_andi_tl(t0, src, 0x1);
-    tcg_gen_st8_tl(t0, tcg_env, offsetof(CPULoongArchState, cf[a->cd & 0x7]));
+    t0 = tcg_temp_new_i64();
+    tcg_gen_andi_i64(t0, src, 0x1);
+    tcg_gen_st8_i64(t0, tcg_env, offsetof(CPULoongArchState, cf[a->cd & 0x7]));
 
     return true;
 }
 
 static bool trans_movcf2fr(DisasContext *ctx, arg_movcf2fr *a)
 {
-    TCGv dest = get_fpr(ctx, a->fd);
+    TCGv_i64 dest = get_fpr(ctx, a->fd);
 
     if (!avail_FP(ctx)) {
         return false;
@@ -177,7 +182,7 @@ static bool trans_movcf2fr(DisasContext *ctx, arg_movcf2fr *a)
 
     CHECK_FPE;
 
-    tcg_gen_ld8u_tl(dest, tcg_env,
+    tcg_gen_ld8u_i64(dest, tcg_env,
                     offsetof(CPULoongArchState, cf[a->cj & 0x7]));
     set_fpr(a->fd, dest);
 
@@ -214,11 +219,11 @@ static bool trans_movcf2gr(DisasContext *ctx, arg_movcf2gr *a)
     return true;
 }
 
-TRANS(fmov_s, FP_SP, gen_f2f, tcg_gen_mov_tl, true)
-TRANS(fmov_d, FP_DP, gen_f2f, tcg_gen_mov_tl, false)
+TRANS(fmov_s, FP_SP, gen_f2f, tcg_gen_mov_i64, true)
+TRANS(fmov_d, FP_DP, gen_f2f, tcg_gen_mov_i64, false)
 TRANS(movgr2fr_w, FP_SP, gen_r2f, gen_movgr2fr_w)
-TRANS(movgr2fr_d, 64, gen_r2f, tcg_gen_mov_tl)
+TRANS(movgr2fr_d, 64, gen_r2f, tcg_gen_mov_i64)
 TRANS(movgr2frh_w, FP_DP, gen_r2f, gen_movgr2frh_w)
-TRANS(movfr2gr_s, FP_SP, gen_f2r, tcg_gen_ext32s_tl)
-TRANS(movfr2gr_d, 64, gen_f2r, tcg_gen_mov_tl)
+TRANS(movfr2gr_s, FP_SP, gen_f2r, tcg_gen_ext32s_i64)
+TRANS(movfr2gr_d, 64, gen_f2r, tcg_gen_mov_i64)
 TRANS(movfrh2gr_s, FP_DP, gen_f2r, gen_movfrh2gr_s)
diff --git a/target/loongarch/tcg/translate.c b/target/loongarch/tcg/translate.c
index 3939670e18d01bd9fc08861532166882fbd3f890..6494fac6aac04f495c18b4326bf271902d9df323 100644
--- a/target/loongarch/tcg/translate.c
+++ b/target/loongarch/tcg/translate.c
@@ -218,15 +218,15 @@ static void gen_set_gpr(int reg_num, TCGv t, DisasExtend dst_ext)
     }
 }
 
-static TCGv get_fpr(DisasContext *ctx, int reg_num)
+static TCGv_i64 get_fpr(DisasContext *ctx, int reg_num)
 {
-    TCGv t = tcg_temp_new();
+    TCGv_i64 t = tcg_temp_new_i64();
     tcg_gen_ld_i64(t, tcg_env,
                    offsetof(CPULoongArchState, fpr[reg_num].vreg.D(0)));
     return  t;
 }
 
-static void set_fpr(int reg_num, TCGv val)
+static void set_fpr(int reg_num, TCGv_i64 val)
 {
     tcg_gen_st_i64(val, tcg_env,
                    offsetof(CPULoongArchState, fpr[reg_num].vreg.D(0)));

-- 
2.43.0


