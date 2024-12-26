Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EDC9E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 21:21:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQvGp-0003dc-DK; Thu, 26 Dec 2024 16:19:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvGn-0003ck-0B
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:19:49 -0500
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvGl-0002vv-HU
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:19:48 -0500
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id B907213801C7;
 Thu, 26 Dec 2024 16:19:45 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Thu, 26 Dec 2024 16:19:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735247985;
 x=1735334385; bh=J5Os7FcfxuL0lY+KefWBE+pEYPFluDZ4pINxkioG6GM=; b=
 dQCa1fS/mmuwJjQslVjZj3ymp10szoAZi278yjEsjYn3h2n0MJO4M+T9pDitiyc4
 UXV7Mbrw30TqT5yQXn0/wO8b77HiGYbg1f2xzInm5flXe90VP8eMLLcQfWG2kEpR
 AKUCKrPGFUQ3cN18CbBHnTRd8FFL266QQ+N+4Vy8cczCWuq8VnLKhWjpG8zmdcT9
 6QJILRAIuLYpprnuk2W+ekQs/pOmWJraF1J7Z1rw2BNITydZPJy+7pcE0Bzh1dKa
 2VtjNQy1nBjVB4mfhEWIWoB4litTAuvvRyYiYECRVjnz7nqS5Wum3fM6hh3y8PL6
 8szWP0D1FpFpFh1D7/lyZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735247985; x=
 1735334385; bh=J5Os7FcfxuL0lY+KefWBE+pEYPFluDZ4pINxkioG6GM=; b=a
 0y6bbBZPX+peVBnlRzoYZ5d+z3yN3A4lO019lICeNdW5BZXYEA+AEF/t5u+VZpyA
 vu9zRsDPd6y0gsiIMQ41RXE4cDe4DOekFdckmP0kzuDelxDIUDq3NsmdIrFeqQO0
 dJghXIr1f4VKZ/SbppTALj7IsybCycDi8sfIXQuZ1J2jug+j66JgLEIZfrmXA+if
 +rs3xGKriNwmouJcvr6nN032KA6bHW9teT84sJLWKeMJODB3bNASyjHsXVAiDm0D
 PaEd6XVfplydyDh/JpkdoKwJHzx34A7Z2Y7SsqRTZbjSaLynUqm1gBdyLGQ+Gi81
 ZaU3ShJbC5JJeAIBNyzmw==
X-ME-Sender: <xms:cchtZ_mh1gUb_MFnt2mkdQlTVyY_YedkD53f6LWeIsDj7a4em95wQw>
 <xme:cchtZy3JatnISzqoUFOpaU_gBVdycq8p1D31lHCxtp1JBhvgxjeoD9L8o2LpbLqXR
 SkKh3C7Cs__1bSeXnI>
X-ME-Received: <xmr:cchtZ1puEvbH7I6NlkLPKL4zCa_f24RuQi_wfq1xPLfyzHFFLfUlNJAL>
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
X-ME-Proxy: <xmx:cchtZ3lE2WBzcl9rFKcGtN-R9352EGs2M3h-pqnQYw0Ry6jYVclExQ>
 <xmx:cchtZ92h1rl08N-qQoPIqTJYlS6UI1LKBFaPx732saOjoRcVIp7MRg>
 <xmx:cchtZ2sVclRu2W0XuD1SaNwYpckuukxtjz1-gZeY35GS_3OjF_ffHA>
 <xmx:cchtZxXSEm907GSouqgXWJ2DeOTKLmMaRqP0J8gFnUt8s3XZ7Hc4Ig>
 <xmx:cchtZ7OBmxEKRQdf4jp7YqNpsjNTMvxLnUChuMiOAd2zqi58YngFip0k>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 16:19:43 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 26 Dec 2024 21:19:32 +0000
Subject: [PATCH v2 01/23] target/loongarch: Enable rotr.w/rotri.w for
 LoongArch32
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241226-la32-fixes1-v2-1-0414594f8cb5@flygoat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2013;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=BoEFL5mTmPnLaZ8ShfI5yw4/wyM2it5eCmOUPeHemfM=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvTcE9lulrLmE1bNce6cUu5StcvfXzb92MdUBpM9+7Y2x
 km8fJvTUcrCIMbFICumyBIioNS3ofHigusPsv7AzGFlAhnCwMUpABNJ28XIsMvoxuRbM7f8rgub
 1f1ZNXGySYw20yXnWU1/axWsp/F+vMvwm/0r5yFDvypFH5f3G3cZ+AVlr9p9iytSe9nMzkOCuw4
 dZwAA
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

As per "LoongArch Reference Manual Volume 1: Basic Architecture" v1.1.0,
"2.2 Table 2. Application-level basic integer instructions in LA32",
rotr.w and rotri.w is a part of LA32 basic integer instructions.

Note that those instructions are indeed not in LA32R subset, however QEMU
is not performing any check against LA32R so far.

Make it available to ALL.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/loongarch/tcg/insn_trans/trans_shift.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_shift.c.inc b/target/loongarch/tcg/insn_trans/trans_shift.c.inc
index 377307785aab4837bc181f1691632e7970a9889d..136c4c845527f0e63902a8306dcaf136dd4dd3fc 100644
--- a/target/loongarch/tcg/insn_trans/trans_shift.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_shift.c.inc
@@ -78,7 +78,7 @@ TRANS(sra_w, ALL, gen_rrr, EXT_SIGN, EXT_NONE, EXT_SIGN, gen_sra_w)
 TRANS(sll_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_sll_d)
 TRANS(srl_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_srl_d)
 TRANS(sra_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_sra_d)
-TRANS(rotr_w, 64, gen_rrr, EXT_ZERO, EXT_NONE, EXT_SIGN, gen_rotr_w)
+TRANS(rotr_w, ALL, gen_rrr, EXT_ZERO, EXT_NONE, EXT_SIGN, gen_rotr_w)
 TRANS(rotr_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_rotr_d)
 TRANS(slli_w, ALL, gen_rri_c, EXT_NONE, EXT_SIGN, tcg_gen_shli_tl)
 TRANS(slli_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_shli_tl)
@@ -86,5 +86,5 @@ TRANS(srli_w, ALL, gen_rri_c, EXT_ZERO, EXT_SIGN, tcg_gen_shri_tl)
 TRANS(srli_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_shri_tl)
 TRANS(srai_w, ALL, gen_rri_c, EXT_NONE, EXT_NONE, gen_sari_w)
 TRANS(srai_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_sari_tl)
-TRANS(rotri_w, 64, gen_rri_v, EXT_NONE, EXT_NONE, gen_rotr_w)
+TRANS(rotri_w, ALL, gen_rri_v, EXT_NONE, EXT_NONE, gen_rotr_w)
 TRANS(rotri_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_rotri_tl)

-- 
2.43.0


