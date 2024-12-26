Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E7CAE77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 21:22:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQvGu-0003ez-7I; Thu, 26 Dec 2024 16:19:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvGr-0003eR-W6
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:19:54 -0500
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvGq-0002wu-AQ
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:19:53 -0500
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id BFC6513801DC;
 Thu, 26 Dec 2024 16:19:51 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Thu, 26 Dec 2024 16:19:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735247991;
 x=1735334391; bh=Q1Tr4VLCU/aCVt0TUBVkqUl7v2+5x9K5iupl27zw8OA=; b=
 VN+5o7XhclFJsvjNxxT/vzZtonp9rOFx1Mqth6dzQg0LqFfSCEmnv0V1VvWpl+AX
 6Gut7K4Ls4z61K4C47UKf40YxEzRafpudGg4fjDrfigHTEhi3BMgqlfP5WIcfZPs
 suYLQcBKYzd2SkSIppmOOngBBfcNsoy8ph3LOSJn+eYRInmr98LVvM6b8SR/nVLb
 j/ejPXH3nUj+UcqVP1IFTsO32xSOLlBnRdKpLUcfs+5CJ/bQMQcrlo77FD8O7+fK
 vPhXgtfqJ6btcyIuf59iL3AI+PZSLASa8z7Q0zuJRETlYsO1jRfLnt1phEK6QcIu
 59Y4++A9cSSA2XlL25GeRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735247991; x=
 1735334391; bh=Q1Tr4VLCU/aCVt0TUBVkqUl7v2+5x9K5iupl27zw8OA=; b=R
 G5O2kob2sWTJl2jivootEgbekdqEbOvwHo+DQO3Cqz7oq3h8l/9N4fawQAreSka4
 Ukqewz6ibw1M+Xm+wOJ9TnHQxUpaDSGOkkwRV1kKW8p8oHZBJZpSQFRtYX0U37O0
 sqoEZDBIwQSKLry6auO3oJtaSkDb2dg5bENH2SK60qgUvVlqyZcWMqRRw73Z/gqK
 MmmHxVsmoa4uPNRVzY6Zm02wiwQkxApE2m2j5yhk8pbWW3k7/p9SHwZExKyjzbHI
 v0BsJWyXEK1pUuSInY4+JkNC4GUthG37wRVDd4bVAO0bblHl0O0Ldykzxg4v7YhL
 ocwCs+fFCC3RvkRxC+l+Q==
X-ME-Sender: <xms:d8htZ5dME4nBizza4hvkr-ohn_ONxqkMU4t6J61IMCyIr2VEJJruvg>
 <xme:d8htZ3NiMYmgb-ee5xowDkiDkJnsHl5dxEP8xrFvIA1kWWoC1uFjDbZ8O5f5Io2iJ
 lTAsUVfk2Om25_K8MA>
X-ME-Received: <xmr:d8htZyiV3jsRo9HMmbrEyIBOY35LmloXHuO6iLpydIR56qK2RrSXMLTl>
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
X-ME-Proxy: <xmx:d8htZy_eiu1MJmIs_UouSNfxDGCDqsSTbufnlkbmI1m0nlb0qdufNQ>
 <xmx:d8htZ1uYVrkjiS8PXOB7TQxNkTXsPqaEKJLhX6t4nDJK-yvrtvzGwQ>
 <xmx:d8htZxE9i5VnOx1dTArfTQWvE-PMNK__nrs8166y7bEcfEbi8p2LBg>
 <xmx:d8htZ8PXb0EaV8YI1ExM6OqHUyZY692Fn-biozQHiv_xB_xMJ_7yRw>
 <xmx:d8htZ-FOHQgLkyLVEL-OEH6m-zZjJjyR2kmHXmziuYX554C53IVVaoey>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 16:19:49 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 26 Dec 2024 21:19:35 +0000
Subject: [PATCH v2 04/23] target/loongarch: Perform sign extension for
 IOCSR reads
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241226-la32-fixes1-v2-4-0414594f8cb5@flygoat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1853;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=JNBgIaVRNq8CD21Ic9ZZf6Czo7m4QZkHaZRXP0viouw=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvTcE9nlOXK/vaKu3LPkfOvAbG/yVrT01rYXQh6HjnwLa
 1+nVlXfUcrCIMbFICumyBIioNS3ofHigusPsv7AzGFlAhnCwMUpABMJzmP4K8d9jz9k5tbMj+LG
 pV0z319lXLN40YHLM12PFmz7FH9rSyMjw8cQ8Q/vG1ZsS2eubvGxz9AyTstzfbnb+0HOT46kGx7
 beAA=
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

As per LoongArch Reference Manual - Volume 1: Basic Architecture,
4.2.2. IOCSR Access Instructions:

The reading value is described as "writes it to the general register rd
after symbolic expansion." which means it should be sign extended.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/loongarch/tcg/iocsr_helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/loongarch/tcg/iocsr_helper.c b/target/loongarch/tcg/iocsr_helper.c
index b6916f53d20ca133f0000e773685cb94240bafe2..db30de2523fff01bcc8923eb12c7fca7bedca7bf 100644
--- a/target/loongarch/tcg/iocsr_helper.c
+++ b/target/loongarch/tcg/iocsr_helper.c
@@ -17,20 +17,20 @@
 
 uint64_t helper_iocsrrd_b(CPULoongArchState *env, target_ulong r_addr)
 {
-    return address_space_ldub(env->address_space_iocsr, r_addr,
-                              GET_MEMTXATTRS(env), NULL);
+    return (int8_t)address_space_ldub(env->address_space_iocsr, r_addr,
+                                      GET_MEMTXATTRS(env), NULL);
 }
 
 uint64_t helper_iocsrrd_h(CPULoongArchState *env, target_ulong r_addr)
 {
-    return address_space_lduw(env->address_space_iocsr, r_addr,
-                              GET_MEMTXATTRS(env), NULL);
+    return (int16_t)address_space_lduw(env->address_space_iocsr, r_addr,
+                                       GET_MEMTXATTRS(env), NULL);
 }
 
 uint64_t helper_iocsrrd_w(CPULoongArchState *env, target_ulong r_addr)
 {
-    return address_space_ldl(env->address_space_iocsr, r_addr,
-                             GET_MEMTXATTRS(env), NULL);
+    return (int32_t)address_space_ldl(env->address_space_iocsr, r_addr,
+                                      GET_MEMTXATTRS(env), NULL);
 }
 
 uint64_t helper_iocsrrd_d(CPULoongArchState *env, target_ulong r_addr)

-- 
2.43.0


