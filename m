Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E453C021A4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 00:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmizx-0004bZ-41; Mon, 24 Feb 2025 19:40:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tmizr-0004a1-TF
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 19:40:28 -0500
Received: from fout-b6-smtp.messagingengine.com ([202.12.124.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tmizq-0003Sl-8H
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 19:40:27 -0500
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 3FFFE114015F;
 Mon, 24 Feb 2025 19:40:25 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Mon, 24 Feb 2025 19:40:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1740444025;
 x=1740530425; bh=tFAQFqUAgdmLwYisLRxlA7J5J4yli3bv87ehvWOUb1w=; b=
 gR7Z0GJb3JtGvDAjVCRyGfNoi4L5aztnUUHlQQW2w+DENKx6Adro/qwiBrpYRr1S
 KMD2U+bIe6bdlxb+xSdcUWNcrUsRbmoR9YPEWUvEB7JHGmpQtftF3pWD6n9fwM11
 BXNAP/b9fyIM6KO622Fmhz/5jAeD4SC1LVsd3UU05kTv0cYUgjJcfejI8ooSsalq
 HhcKy1oxaUKI54A3Y0BKjZgpwso2W5yLyeen8CjX6prb9XEqOtW6yROVJsB+u3a7
 7/UXCDWa3+qdr5FQDurP9ECIE8v4hdsrYDBl4AISAbOrQ2n0w+MWq4IDFwirBmJM
 o9HYlcc2mnPcpTtTtjrh4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740444025; x=
 1740530425; bh=tFAQFqUAgdmLwYisLRxlA7J5J4yli3bv87ehvWOUb1w=; b=T
 9wEku/LcKEMIpBb9gJ9sjEaFcd1M/n8RcAjNj7BTfKV2zJq21E++uOEOSqah0h7A
 mSlkZiNzndJyRr6gsfD/mnfUdIju5jZVkA1lVIaf29/hNFc68I2gzZe4oBmPj7P3
 Vyy1RUCfrPcP0DKi1b+579iierFxoOHHD6aLOAiZGHaDwydT4i/Kh3Pud6Qlggqo
 jaVWQqeFA54/NvYyvHVerfkHCjtOMyvT0gIIX+I9oDIXt0W8ux9roIH7waEvbI/o
 Q3bH0tBvaF9BQaapv6LB10Vbiky6JMtsWe42KYvdaJIUn7duITTd/bHxUZx0CDrX
 te0+fleVDf7Zl1EotpKwA==
X-ME-Sender: <xms:eBG9Z8AkqLRWGOur2TJUQ7lAY6JEO1Eng24_fwaK1Ma4U_S2p6lXcQ>
 <xme:eBG9Z-hBkqUeloKZpHHeQGbztSO88KDgIBdjvuwEfw_OaG94_FNtklQctXRuJ3ekh
 CwUSQdmbZMe6zJnbfg>
X-ME-Received: <xmr:eBG9Z_nXvM_zQjkVaHqlf-XIAcjZBZiVSh8SDomsQzVMh_iGJoYGFYo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdektddviecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:eBG9ZywX4WmT35I2NgLA3c-Z-Js9oMfsvFdy2yDFrlfM1XQ5sxlwrg>
 <xmx:eRG9ZxQqfBB4IgWuRsgOMO4KrkRzs3opxZd6RKdEz8ni0Dz5ZdpGNA>
 <xmx:eRG9Z9Z-AjbW_uH4fAde1I3RL0XjsnidYGj1HwHuRSaEJCZ-Y38-fA>
 <xmx:eRG9Z6TW6TA73ngCR7oDRSxYw29rTZEOBnQYvh10hhlmIGr_ho05Sw>
 <xmx:eRG9Zzepr6dUlNyHax4W34E5B2Fu8K3Ym_iL89GaBkqOVsKKLOZhhdog>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 19:40:24 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 25 Feb 2025 00:40:20 +0000
Subject: [PATCH v2 7/9] target/loongarch: Use target_ulong for CSR helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-la32-fixes1-v2-7-8ec68ada3dd5@flygoat.com>
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

All CSRs are meant to be target_ulong wide in our setting.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/loongarch/helper.h        | 14 +++++++-------
 target/loongarch/tcg/op_helper.c |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index 409d93a5b0808f0e32b8c0e2e17cebac9feaf8ed..a608754b7f52689da9e9f4da1cef68d5af72f2ed 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -97,13 +97,13 @@ DEF_HELPER_1(rdtime_d, i64, env)
 
 #ifndef CONFIG_USER_ONLY
 /* CSRs helper */
-DEF_HELPER_1(csrrd_pgd, i64, env)
-DEF_HELPER_1(csrrd_cpuid, i64, env)
-DEF_HELPER_1(csrrd_tval, i64, env)
-DEF_HELPER_2(csrwr_estat, i64, env, tl)
-DEF_HELPER_2(csrwr_asid, i64, env, tl)
-DEF_HELPER_2(csrwr_tcfg, i64, env, tl)
-DEF_HELPER_2(csrwr_ticlr, i64, env, tl)
+DEF_HELPER_1(csrrd_pgd, tl, env)
+DEF_HELPER_1(csrrd_cpuid, tl, env)
+DEF_HELPER_1(csrrd_tval, tl, env)
+DEF_HELPER_2(csrwr_estat, tl, env, tl)
+DEF_HELPER_2(csrwr_asid, tl, env, tl)
+DEF_HELPER_2(csrwr_tcfg, tl, env, tl)
+DEF_HELPER_2(csrwr_ticlr, tl, env, tl)
 DEF_HELPER_2(iocsrrd_b, tl, env, tl)
 DEF_HELPER_2(iocsrrd_h, tl, env, tl)
 DEF_HELPER_2(iocsrrd_w, tl, env, tl)
diff --git a/target/loongarch/tcg/op_helper.c b/target/loongarch/tcg/op_helper.c
index b17208e5b962f2191b2afa60181bff311d618bba..c9d7e84e7ec9000bab655366bdf6ed8aaa4fd080 100644
--- a/target/loongarch/tcg/op_helper.c
+++ b/target/loongarch/tcg/op_helper.c
@@ -61,7 +61,7 @@ void helper_asrtgt_d(CPULoongArchState *env, target_ulong rj, target_ulong rk)
     }
 }
 
-target_ulong helper_crc32(target_ulong val, target_ulong m, uint64_t sz)
+target_ulong helper_crc32(target_ulong val, target_ulong m, target_ulong sz)
 {
     uint8_t buf[8];
     target_ulong mask = ((sz * 8) == 64) ? -1ULL : ((1ULL << (sz * 8)) - 1);
@@ -71,7 +71,7 @@ target_ulong helper_crc32(target_ulong val, target_ulong m, uint64_t sz)
     return (int32_t) (crc32(val ^ 0xffffffff, buf, sz) ^ 0xffffffff);
 }
 
-target_ulong helper_crc32c(target_ulong val, target_ulong m, uint64_t sz)
+target_ulong helper_crc32c(target_ulong val, target_ulong m, target_ulong sz)
 {
     uint8_t buf[8];
     target_ulong mask = ((sz * 8) == 64) ? -1ULL : ((1ULL << (sz * 8)) - 1);

-- 
2.43.0


