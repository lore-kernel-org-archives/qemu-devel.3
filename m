Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3750CE7718F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 21:20:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQvH4-0003jy-Ka; Thu, 26 Dec 2024 16:20:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvH2-0003hT-7H
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:20:04 -0500
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvH0-0002yf-F7
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:20:03 -0500
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfout.phl.internal (Postfix) with ESMTP id ECC3C13801DB;
 Thu, 26 Dec 2024 16:20:01 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Thu, 26 Dec 2024 16:20:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735248001;
 x=1735334401; bh=tFAQFqUAgdmLwYisLRxlA7J5J4yli3bv87ehvWOUb1w=; b=
 B8cTW58a+fjxw0gqGq9Si5stlNLwn2sWZh0IW29m9fHfjm0YkSIxQY+YotqO1/u0
 wSrNsda5/ZfwEgllTzvTjI4szxFCxGZTkjE44FAnefGbEj6/20YdTMsQAWejMEHB
 18AW0lPPR+UC/O4jztWXYXb7Qqvxu/ggj7Duiryl0B2LMQ/CKN9y5FnX2mUWFS8p
 vlCmYeDJUogupWbzHdroEmiy9RTdNwFu5E/EVDx9htJ2U2fngJBt9zeIF6hQa15l
 lb0c1TlgJnrP3Lzy/LMuoBFccQBHr4qKufb/GZJQ5D0e+FO/ajzl8YazpFynFF5P
 XF9XNiiOgAMi/KPAo8h1RA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735248001; x=
 1735334401; bh=tFAQFqUAgdmLwYisLRxlA7J5J4yli3bv87ehvWOUb1w=; b=h
 MZ4Jhs2S2aya/GSIJ/k4juwlwMTAxDZ0USwnXY4eWZO5OnAGMM2vsggMSlMKyISK
 Uar3ecj21q8gn0ySqe/qIJor+QhjOkegWfEeBQbATEwJBMlPzHfa4FDBOHDvP8G6
 B45v0B2ZXk8kil5/NtTq/YslQi7vd26XHlDyRxTDkyqiDI2QkC0BNkhBrClwplR+
 mT3GWwlVBdv1Xt1F8DKVIeYL3fm/KRlCiAztT0Nxh7kq2uXfwy6befIClpYquHdp
 t29aCl9uyI4F7ZOHCqcAYLvx2QOBLSiR7kVXwfFab+s4pYECgdNk2DL2Nat3zdML
 0hF0G5JD7RD4dUi+aarRg==
X-ME-Sender: <xms:gchtZ8R635g1BjDVcl8Omn41B053bOJRyDb3aEnBI8TnfpiAe0rOqg>
 <xme:gchtZ5x5GUxXej-Cm2z6Vl7uBwOCLaoc08T6fSZ20XBON35oI21xFF81NvKmsSr5-
 UzyUVFZmz0bSmJWE9k>
X-ME-Received: <xmr:gchtZ51HS6UN-SgKRXf1w5apFyL9cjOx4oKTkHOdmwRDU1IYLwZ32NNO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddukedgudegkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
 jeenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflh
 ihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleff
 keegudeghfdtuddugefhueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpeefne
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
X-ME-Proxy: <xmx:gchtZwD4A3M83RjWaKGY9PKLl1f8PpqPGW-fD6LgCVUqFdy1ar1_OA>
 <xmx:gchtZ1hcxGWf_d7IEyHhVudnXAvcfAQ72dRIgtzYySPc_DLnB5Q7Kg>
 <xmx:gchtZ8r9mLECy539gDpqM9bSkFQy8LE2qgiXxdM2pFOex-O_CM1dyA>
 <xmx:gchtZ4gc_aYV_rSGYocXzmnVD-GP1b1pMPxE2U7rD7ioPub7ZdDLuw>
 <xmx:gchtZ-ZOyfS0PTjentuDdnyHTfCoCxFIGWWbWc2hqON6_X7tUdhNQJ6n>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 16:20:00 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 26 Dec 2024 21:19:40 +0000
Subject: [PATCH v2 09/23] target/loongarch: Use target_ulong for CSR
 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241226-la32-fixes1-v2-9-0414594f8cb5@flygoat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2351;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=ju3phB5IO4pZPav9xNWdsU/6oIb8bjN5TIBoSv4Nlw4=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvTcE9lqfo31/FpavgumqHTwdnyK1prnnTX76f/oLOUN2
 7oaz6Z0lLIwiHExyIopsoQIKPVtaLy44PqDrD8wc1iZQIYwcHEKwE0+xchw7+Ysq63peg+frxQu
 2pP86nfRsVzBNo/KxIcs2m8TbrBsZvjNMlF/9QWG2AXt8uEhmpu7Fqr/eKZ+uTrlzvu5Wye9k+H
 nAAA=
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


