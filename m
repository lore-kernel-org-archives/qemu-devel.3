Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA629C021A4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 00:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmj0R-0004dt-7E; Mon, 24 Feb 2025 19:41:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tmizo-0004Xi-Nx
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 19:40:24 -0500
Received: from fhigh-b6-smtp.messagingengine.com ([202.12.124.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tmizm-0003S0-Vl
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 19:40:24 -0500
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 0198925400EE;
 Mon, 24 Feb 2025 19:40:20 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Mon, 24 Feb 2025 19:40:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1740444020;
 x=1740530420; bh=S4LKGFTypIdV3P5Y7CtYczPKE/btLEKjM8yejT9DHdU=; b=
 KJjpzDB2TT3ATuyaKfndMhqPdSZzYvy780W/+Ykje6PiDxWE8NSPh+zWJuHvYDT7
 5R37/s5LhP6MCz1s1um2CocyJJZ0+YEeqrmYYJNCT/zSFWpb0j9Bn5nliOtcWIBP
 olyseqIzlz9EliGdxEYyradkZuhvONpnpQI4zKel/QKAAvRUr41Fd+kG7OpNqE5T
 NWhVbaQa95Th5lq+2nIPP+WHQVNskBSmt6/B9XUUp6A9VW+XcuQKFy2XDvlKYLNw
 gIr6+WacaWDPC15YWW/Tyq73cNZed5IbmUaFHpiOGnCdCP3MAL0J6/Ew0lDVtGbU
 OxnvsGGUZHsnM411FknDjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740444020; x=
 1740530420; bh=S4LKGFTypIdV3P5Y7CtYczPKE/btLEKjM8yejT9DHdU=; b=W
 bsdpPqJqSMLmQ+VkUc8ftYxCg/o6jFDOC3utYQvVRKZvOhe0nDZOd1T3M8lnSg0X
 1PEgVOMJtut1IANh/S9AdOyLCcjszS7MpbNARZn6K8Zk8vsNqErebnApOTgdxKNC
 elKDbvVkXoy9keNmVj+BDJwUguTaaX0YAUfYqVuosl3dMIiC7/9hrBMfnkjlFpXg
 GmM9h1dE4IBf86n5aiWxHb+vk5YO9xIA/XPpZ8qM4KoU9HwQprAH3tub7CvlCY7R
 i0Rz63xiDSmBhg7IODwDo7g8rVHoZg18KOj2iAht/UlQEEL8B3I1xpWWghhxdxk5
 8ZbYXm7IV6dpx00KhWETg==
X-ME-Sender: <xms:dBG9Z9z77MP9K1SxE9tJzwiPdsM3E5rtJ73DcMsdTp_lh6e4-dETWg>
 <xme:dBG9Z9QA9ZSNtyB1Hh7-JTF2I3E0l0bVEBSl28flDJcKlfGwgKebGnSqFKL6Fxyjv
 2To4HXFf7yMAFSBSDs>
X-ME-Received: <xmr:dBG9Z3Uq4B0wo3STO3dXMXkoQsItUN7fyyyAnabiVJE-X9vSjhi3aA8>
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
X-ME-Proxy: <xmx:dBG9Z_idVv3B7i9s29nISZuF9Q_D5lRB8U6FAT1BHQ_qrKqP6zSdcA>
 <xmx:dBG9Z_DWsZxGTUBlcQfeS7h2Pzl-bKW_OSgK-aw4XV_MNwfgUoCn4w>
 <xmx:dBG9Z4LA-kT-h1RNcBj_-JhiU2VXpdPVWGn0HtHECIFfQjhUbmbAyg>
 <xmx:dBG9Z-BULk7YNP6amw8QDT8bFz1ySluu8HiEYn1f3r8SUon5QYgz8A>
 <xmx:dBG9Z2P0VRg22xhmkNc5Qhsnzo6TsVrUg-pneEDqmxKwZbxnugi7EfqQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 19:40:20 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 25 Feb 2025 00:40:16 +0000
Subject: [PATCH v2 3/9] target/loongarch: Fix PGD CSR for LoongArch32
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-la32-fixes1-v2-3-8ec68ada3dd5@flygoat.com>
References: <20250225-la32-fixes1-v2-0-8ec68ada3dd5@flygoat.com>
In-Reply-To: <20250225-la32-fixes1-v2-0-8ec68ada3dd5@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=202.12.124.157;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh-b6-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

As per manual, the source of PGD CSR is relevant to highest bit of
BADV. In LoongArch32, all CSRs are 32 bits only, thus we should check
bit 31 of BADV to determine PGDH/PGDL for LoongArch32.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/loongarch/tcg/csr_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
index 15f94caefabc7722263fa46e948e21de37b4203c..821aa6af46ea2129d771fdc937eca72317cefc1e 100644
--- a/target/loongarch/tcg/csr_helper.c
+++ b/target/loongarch/tcg/csr_helper.c
@@ -26,7 +26,7 @@ target_ulong helper_csrrd_pgd(CPULoongArchState *env)
         v = env->CSR_BADV;
     }
 
-    if ((v >> 63) & 0x1) {
+    if (extract64(v, is_la64(env) ? 63 : 31, 1)) {
         v = env->CSR_PGDH;
     } else {
         v = env->CSR_PGDL;

-- 
2.43.0


