Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30FAFE7718E
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 23:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPVYy-0000L7-Eo; Sun, 22 Dec 2024 18:40:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tPVYr-0000Jw-7B
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 18:40:37 -0500
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tPVYm-0006BS-7J
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 18:40:36 -0500
Received: from phl-compute-02.internal (phl-compute-02.phl.internal
 [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id ACA7F13801AD;
 Sun, 22 Dec 2024 18:40:31 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Sun, 22 Dec 2024 18:40:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1734910831;
 x=1734997231; bh=7cTwzH7RtaLWxerE/3oHVhOon4cSx5BIeYCAgA/5kJk=; b=
 lCjypm0UvXvpS7HYklL1J/MtXxkvvclFBwFNrSZ8hsR2YA+RPJZVOBHAEMJaXmwy
 ou3i/I6bzZQ9RcrmaYJBjTBVXSawZ+KkxztZVSPu3iQRVcuLTtK6RpQ3nDWCOhtk
 856VRSpgR+KCIzHPcqIUwkU4sUFP7jO6yP4rdD4QlE4lA6tBgz8trBlc67SzvL9o
 /7cYM77q7Bv6e1lZYmLxxC7mcDVc/XVMVNJUUOD3/8Uddbpr3FGmRYXRVYEfPso0
 z2NAAoqYVBL38qzxZtw6vaAPpNhtHvEoc9FJShRN5Fvr5RgP6/w2ZyM5nKFAz6lT
 YPP510AFcZ3BMdfRPWc3WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1734910831; x=
 1734997231; bh=7cTwzH7RtaLWxerE/3oHVhOon4cSx5BIeYCAgA/5kJk=; b=v
 R8ed9WDV8BJqD74DR+7F4hqkgoDmZFHsj+bIK/vZ9wFbssloRD+xLh9LpL7Yqpgj
 gmUjI9ZhTMH8vBWK6OdwPWa8h39fAfLtxQlTL890BMuhFrbNB9TPRkABUgba0seS
 eKRsf1Xcq7XLkNVLUeSpbCmfcPr1rg/XhJc/1cWMFkqBt/Qk0oYjnkJg7+HLk9o/
 SYO22b7240lzj+LCgoTBqRQ7/BICOtQ0bITq5LHWBaLYtDGmBbiMmm1xeD97emyU
 FKVwBLi9Y9JxiBqG9uja3E1fqhLS0Grf6jzi8Ri/WXiUZUnNjKNoCKcIeDE7PRBg
 3REIJRsG/7meDDp+cjz0w==
X-ME-Sender: <xms:b6NoZ-GthdAKssmPddUhRiLqA_-A-Facpqw8QcUPTFrVYFXkvvANKA>
 <xme:b6NoZ_VKhZSt611DeKq1RXA_fme8ohTwt6B2getD_YLKrWeySA76gX9C3-twFAiJ_
 xVCF3hXkTIS2Kp6_9A>
X-ME-Received: <xmr:b6NoZ4JgVYU9cayYVBm4cUtUEIYFtwWewOEsrsgovaKytw7jdW-_7DE1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtledguddvucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:b6NoZ4FPynICg4IlyHGA9U2oItGy1vhMdPAXJzzvEPkV80SpHN7aXg>
 <xmx:b6NoZ0WEwQgwvSCpNLgz-gb25Ticl7YN4iI3QtW2mh2efLy5rgn7Sw>
 <xmx:b6NoZ7Prvd0XLDTu4JI1byDA9oNRsJMozsOSgnmUQv6tCSRkkqKntw>
 <xmx:b6NoZ72-QQGetI3F3yiNLUlOgAFyZZrrFNw1jUY0lXhYFX08P86hvQ>
 <xmx:b6NoZ7T0Zq7xPirlVkR7PNEloPX4LVytzVKaky6OyB8EJPYQS9BxRK5h>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Dec 2024 18:40:30 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Sun, 22 Dec 2024 23:40:27 +0000
Subject: [PATCH 3/3] target/loongarch: Fix PGD CSR for LoongArch32
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241222-la32-fixes1-v1-3-8c62b7e594db@flygoat.com>
References: <20241222-la32-fixes1-v1-0-8c62b7e594db@flygoat.com>
In-Reply-To: <20241222-la32-fixes1-v1-0-8c62b7e594db@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=891;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=HMr2rCyjGnWHqISfDv+dvbEaVA1bYvHdaH0R/IQObZI=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvSMxVnTV7WuX3a2ev0C24dKP7W6HU+um8Z7amoPz4OYA
 00M2/6t6yhlYRDjYpAVU2QJEVDq29B4ccH1B1l/YOawMoEMYeDiFICJ7GdlZHh+5X6W+rutJq+2
 ZTzy/xVbl2m2UXbC9z0/vsjKzQ5lMbJj+J/eKCf0y/6tyJtzEarcPKadG1eFRMxzMUvb4LxRe/X
 6dC4A
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=103.168.172.150;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout-a7-smtp.messagingengine.com
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

As per manual, the source of PGD CSR is relevant to highest bit of
BADV. In LoongArch32, all CSRs are 32 bits only, thus we should check
bit 31 of BADV to determine PGDH/PGDL for LoongArch32.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/loongarch/tcg/csr_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
index 15f94caefabc7722263fa46e948e21de37b4203c..ca8100eedfb37fd3b45b3de0c0fc0fad599c4685 100644
--- a/target/loongarch/tcg/csr_helper.c
+++ b/target/loongarch/tcg/csr_helper.c
@@ -26,7 +26,7 @@ target_ulong helper_csrrd_pgd(CPULoongArchState *env)
         v = env->CSR_BADV;
     }
 
-    if ((v >> 63) & 0x1) {
+    if (v >> (is_la64(env) ? 63 : 31) & 0x1) {
         v = env->CSR_PGDH;
     } else {
         v = env->CSR_PGDL;

-- 
2.43.0


