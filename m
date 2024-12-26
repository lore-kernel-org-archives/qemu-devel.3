Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7AB3E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 21:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQvGv-0003fF-IA; Thu, 26 Dec 2024 16:19:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvGt-0003eg-Lh
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:19:55 -0500
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvGs-0002x5-77
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:19:55 -0500
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfout.phl.internal (Postfix) with ESMTP id BE74213801DF;
 Thu, 26 Dec 2024 16:19:53 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Thu, 26 Dec 2024 16:19:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735247993;
 x=1735334393; bh=KCkRYG/jH7j0XUGmJo5gVnglQvXIToUkt02zHQ4OVAo=; b=
 MHh62pem9YEL6q6lN2Td6Zl0Qoy72MkUG/V2A+UgPORkQJmenAMpkpNcAsqWRBVr
 TyKFoj96qJBjg9Pe5wNbRNNUI3rRd6DjpUiQfxDCD/YOTcwXP3MaW13nyhXmQD0m
 mDDMp90dJ9UVdkaQaj9ajg4rp88XsmNdK54IdmZG1FKkBGkK5Yqr8tpXsbqutmkD
 1pf9tDgJp/CVjXHLQlrBITgJZY9JDmf5OTyZEE+UM0dAQsBXnkez4wmv91AL9+mO
 rC+DTOS33PRHCGGDbF9TKVKBra/3Md12deBPOGcgKLPymlJ8nenKq2B97wOfDM/D
 fmB7za1RNH0ALg7too4vNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735247993; x=
 1735334393; bh=KCkRYG/jH7j0XUGmJo5gVnglQvXIToUkt02zHQ4OVAo=; b=W
 lGvWh1R7ymaRILyuJ70uUALbpQm5ewSle++6OaOrGzBLJki9PKCyl3oGJXd9Fmx8
 fUkOB/13I5ehq7SAhyCKfCBGrrK14f3Hty6th8ME0OLhhBi03kAdflKH0K/4MnL2
 eiy0Pu70oWWug/MgytB4ro7utFZamgET+ZEvgKIAQyJ437RxUSEqyH8KhN7dufhb
 zQWyR6A7i99KHwsNu2KFeKROLXorILwX6NLtez8IVuKsqL23OOmRBBI6EN0b1Lbi
 efq8l1d8J8MYdMDdVGY2jGvE7wcr3crUBCAp7IR+G/82/H+UYAGof3/usPNCQbh5
 Fw7CItUKUYxAJXRIcpqrg==
X-ME-Sender: <xms:echtZ2JW3ZKmnpnfv_wQsJYg2eQgQCyfWkiVulvAwnoYuxF5LyUScg>
 <xme:echtZ-LvJ0o8PrqqiOo3bNEpIzmX0xvefhXXnnVrcMQehDHnqk_PtP4PKO03Oye6p
 c1x_HNAk8KIOxBEgzY>
X-ME-Received: <xmr:echtZ2uHPozFydr2Xxb-UgFX4YaI8XWJOJ34mx2LRwww1vSyOV3NG7xF>
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
X-ME-Proxy: <xmx:echtZ7Y20cmBMp5YGTX7M7PEzD-cXozDfgWAwCfLCwaajQTNTGKdyg>
 <xmx:echtZ9aTR2VCRaD7bUA67wZFnVl0PadUcgnPjR3BfpuraiMWWIkksA>
 <xmx:echtZ3DSesxnTXaIE6ARDP6qsDbrh7TDYFn8XKciXe66q7SXpH0xqw>
 <xmx:echtZzbLOfuvYT70rtiz1iiGYHvKrdIbZF44e0UqDZZFr5HDDV3MUQ>
 <xmx:echtZxQFZzgcOvVRa0Jy-wFejrqR0k6Yl6V2qHnlFy_xbPZJnVlVkj00>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 16:19:51 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 26 Dec 2024 21:19:36 +0000
Subject: [PATCH v2 05/23] target/loongarch: Use target_ulong for iocsrrd
 helper results
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241226-la32-fixes1-v2-5-0414594f8cb5@flygoat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2778;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=eM8z4PNF4T/f/rnPHhyrp+3IIz7lkcNTnCate8LHDPM=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvTcE9muL7rCGnMvzejZZ6+i+j+SbWqYgnFL85ED/WeeJ
 LP65n7oKGVhEONikBVTZAkRUOrb0HhxwfUHWX9g5rAygQxh4OIUgIl83MnwP7HmY+WGvV01tdJ1
 Kw41uYWd/K/MZ9LvOG+d5YqFs7xNJzMy3HAS5LjwOleeyXrinB6DSb9LFCt/bYthWfIsUuF5otQ
 GdgA=
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

Those results are all targeting TCGv values, which means they should
be in target_ulong type.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/loongarch/helper.h           | 8 ++++----
 target/loongarch/tcg/iocsr_helper.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index b3b64a021536255a3f9decfc10ff61fe8380e2ae..409d93a5b0808f0e32b8c0e2e17cebac9feaf8ed 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -104,10 +104,10 @@ DEF_HELPER_2(csrwr_estat, i64, env, tl)
 DEF_HELPER_2(csrwr_asid, i64, env, tl)
 DEF_HELPER_2(csrwr_tcfg, i64, env, tl)
 DEF_HELPER_2(csrwr_ticlr, i64, env, tl)
-DEF_HELPER_2(iocsrrd_b, i64, env, tl)
-DEF_HELPER_2(iocsrrd_h, i64, env, tl)
-DEF_HELPER_2(iocsrrd_w, i64, env, tl)
-DEF_HELPER_2(iocsrrd_d, i64, env, tl)
+DEF_HELPER_2(iocsrrd_b, tl, env, tl)
+DEF_HELPER_2(iocsrrd_h, tl, env, tl)
+DEF_HELPER_2(iocsrrd_w, tl, env, tl)
+DEF_HELPER_2(iocsrrd_d, tl, env, tl)
 DEF_HELPER_3(iocsrwr_b, void, env, tl, tl)
 DEF_HELPER_3(iocsrwr_h, void, env, tl, tl)
 DEF_HELPER_3(iocsrwr_w, void, env, tl, tl)
diff --git a/target/loongarch/tcg/iocsr_helper.c b/target/loongarch/tcg/iocsr_helper.c
index db30de2523fff01bcc8923eb12c7fca7bedca7bf..23d819de0ef9790eb82741f1e8a0e20dc139bf4b 100644
--- a/target/loongarch/tcg/iocsr_helper.c
+++ b/target/loongarch/tcg/iocsr_helper.c
@@ -15,25 +15,25 @@
 #define GET_MEMTXATTRS(cas) \
         ((MemTxAttrs){.requester_id = env_cpu(cas)->cpu_index})
 
-uint64_t helper_iocsrrd_b(CPULoongArchState *env, target_ulong r_addr)
+target_ulong helper_iocsrrd_b(CPULoongArchState *env, target_ulong r_addr)
 {
     return (int8_t)address_space_ldub(env->address_space_iocsr, r_addr,
                                       GET_MEMTXATTRS(env), NULL);
 }
 
-uint64_t helper_iocsrrd_h(CPULoongArchState *env, target_ulong r_addr)
+target_ulong helper_iocsrrd_h(CPULoongArchState *env, target_ulong r_addr)
 {
     return (int16_t)address_space_lduw(env->address_space_iocsr, r_addr,
                                        GET_MEMTXATTRS(env), NULL);
 }
 
-uint64_t helper_iocsrrd_w(CPULoongArchState *env, target_ulong r_addr)
+target_ulong helper_iocsrrd_w(CPULoongArchState *env, target_ulong r_addr)
 {
     return (int32_t)address_space_ldl(env->address_space_iocsr, r_addr,
                                       GET_MEMTXATTRS(env), NULL);
 }
 
-uint64_t helper_iocsrrd_d(CPULoongArchState *env, target_ulong r_addr)
+target_ulong helper_iocsrrd_d(CPULoongArchState *env, target_ulong r_addr)
 {
     return address_space_ldq(env->address_space_iocsr, r_addr,
                              GET_MEMTXATTRS(env), NULL);

-- 
2.43.0


