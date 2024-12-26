Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE984E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 21:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQvH1-0003hL-OS; Thu, 26 Dec 2024 16:20:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvGz-0003gR-R7
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:20:01 -0500
Received: from fhigh-a4-smtp.messagingengine.com ([103.168.172.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvGy-0002xr-Bm
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:20:01 -0500
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfhigh.phl.internal (Postfix) with ESMTP id E467D114018A;
 Thu, 26 Dec 2024 16:19:59 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Thu, 26 Dec 2024 16:19:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735247999;
 x=1735334399; bh=xq7uqmFNSO+Bhhp9oqXUJHdfuDZb5OWrQSgSK4Sc8OI=; b=
 qzTI8IU46HlstiDRlHznpdb5PCTwl0vELPbToyx2Fx6O+2fAW3HtCQFEsNDjDZVJ
 rQuhO1SfR/0J6g/On1Hf+m7agC5tadkC/L840DBG107ojwTflSpc8lyT+3sxPU5J
 sHtxQPLiYUkOYpzX6t+B8+5LAhFHIwz2giH6osZgt10Lb++ueGUmeunxGgOAz5R7
 iVLntWo7CyeVHL2fm443/iTt+HL8HqWBYTENskLmLa/FiDprz4w6vut5a1aoIUXX
 M6FicNvQ8oGT8YGBCYPTNnRxadZx/aBkKmzvx+45RMfJrrC1ISwKczbz6JOVVSwS
 EdDKUib8Dq1QUs/KIefQJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735247999; x=
 1735334399; bh=xq7uqmFNSO+Bhhp9oqXUJHdfuDZb5OWrQSgSK4Sc8OI=; b=b
 aaAggyoQIzTIOScUHcQUFykoTXxIdi7OVjyStDfCaKCYhHna/Iw1xGDg4i6ItJ8d
 HT0gsqoIuIKUrtKYegkoGcsBDQUywxWth+g/AycrdqXuBLLAaFoAYXW3SD3D3GmO
 QyEbhYLPjzSVLUssjt3rE8sGM2zn7uySjOsJmesw8sBMDc4EK5eRB8CHbZvSqlkb
 we8U24Yu8awHbbgWrLezC+xOE6HW2WGc3siQwxElwfcpGxGBw7w/pK0z2jRuxPMp
 fLQUXup9R5BSDYJlzomhl57p9w8RERDyYbc6EsAW3oAbXBUtlzm2/shfUKx92O7z
 /BY7q+ZT9ag8O+Oavp+6g==
X-ME-Sender: <xms:f8htZ3p133Zr72d9rgRkpg16ucyfVMgDcKqlhVIsjIeqSZ_CrfMz3A>
 <xme:f8htZxq9HsF-rjbgw4-ZBOgTsMKGy2rhc2ldkMgaNKQORu5op-wPwX6ax69qnT6eo
 5FbFxj0RlB81Z4B1po>
X-ME-Received: <xmr:f8htZ0M4VK-XGZl2adD3tlUkmqzyQcaXI6QJKDlbfKKmR9foNKAVkRbZ>
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
X-ME-Proxy: <xmx:f8htZ66SD45DplDZnYSlP2R_G8aNgiYv767lvBR7vBg53q7pYMRZRA>
 <xmx:f8htZ26MFdP5KBWFbh52XeMwYLqTUMsEWuXYtoiAaege-ozq02q_zQ>
 <xmx:f8htZyg7ppY6wMlNxfT3RwkqpqcBin53gOi3T7rlg0YzfsE2WUuPuA>
 <xmx:f8htZ46xainoIOslPgpDqIOlb6_eIz-cyMn7RCAQGOaxpKKh_TsSwg>
 <xmx:f8htZ2wxfrTmL-l2olZHbRkAVn_iZyYaFP-u7qJY4OZ7KohS29oGUg_S>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 16:19:58 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 26 Dec 2024 21:19:39 +0000
Subject: [PATCH v2 08/23] target/loongarch: Fix some modifiers for log
 formatting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241226-la32-fixes1-v2-8-0414594f8cb5@flygoat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2683;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=K1JbyjmDeOq+zI7mf6qjyyMmhZTtw0g8gsLmCp1McfA=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvTcE9m9Xz/Wn374ZUnCq0e8895/KLFzYlkhUcFhbcUx0
 fj322mJHaUsDGJcDLJiiiwhAkp9GxovLrj+IOsPzBxWJpAhDFycAjCR4u8M/7PXMF/d8kBhwaz7
 34KfJhZE9c6V8lNMdmx7qRSvuC5LV4bhD6fI2ZoPyflph7R/l+2ezd5mXTH7Vrzvxp+1Yr8cz/K
 lMwMA
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

target_ulong -> TARGET_FMT_ld
vaddr -> VADDR_PRIx
uint32_t -> PRIx32

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/loongarch/tcg/insn_trans/trans_atomic.c.inc | 2 +-
 target/loongarch/tcg/tlb_helper.c                  | 2 +-
 target/loongarch/tcg/translate.c                   | 5 ++---
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
index c35f6f3ce47877ab6ad84fa2cbc50b46c0b23ad1..8584441b543712af8a56aa234c90fd6370c8df01 100644
--- a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
@@ -56,7 +56,7 @@ static bool gen_am(DisasContext *ctx, arg_rrr *a,
     if (a->rd != 0 && (a->rj == a->rd || a->rk == a->rd)) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Warning: source register overlaps destination register"
-                      "in atomic insn at pc=0x" TARGET_FMT_lx "\n",
+                      "in atomic insn at pc=0x%016"VADDR_PRIx"\n",
                       ctx->base.pc_next - 4);
         return false;
     }
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 97f38fc391338ba4b76115b142fa76d89e45cd62..a1426b46f36c99e300ab924cb487875ec21ab226 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -517,7 +517,7 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
 
     if (unlikely((level == 0) || (level > 4))) {
         qemu_log_mask(LOG_GUEST_ERROR,
-                      "Attepted LDDIR with level %"PRId64"\n", level);
+                      "Attepted LDDIR with level "TARGET_FMT_ld"\n", level);
         return base;
     }
 
diff --git a/target/loongarch/tcg/translate.c b/target/loongarch/tcg/translate.c
index 1fca4afc731c048816618d87610a0cc0fe7579b1..3939670e18d01bd9fc08861532166882fbd3f890 100644
--- a/target/loongarch/tcg/translate.c
+++ b/target/loongarch/tcg/translate.c
@@ -287,9 +287,8 @@ static void loongarch_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     ctx->opcode = translator_ldl(cpu_env(cs), &ctx->base, ctx->base.pc_next);
 
     if (!decode(ctx, ctx->opcode)) {
-        qemu_log_mask(LOG_UNIMP, "Error: unknown opcode. "
-                      TARGET_FMT_lx ": 0x%x\n",
-                      ctx->base.pc_next, ctx->opcode);
+        qemu_log_mask(LOG_UNIMP, "Error: unknown opcode. %016"VADDR_PRIx
+                      ": 0x%08"PRIx32"\n", ctx->base.pc_next, ctx->opcode);
         generate_exception(ctx, EXCCODE_INE);
     }
 

-- 
2.43.0


