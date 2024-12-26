Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011DBE7718E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 21:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQvGy-0003fa-9s; Thu, 26 Dec 2024 16:20:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvGw-0003fM-OS
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:19:58 -0500
Received: from fhigh-a4-smtp.messagingengine.com ([103.168.172.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvGu-0002xO-K4
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:19:58 -0500
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfhigh.phl.internal (Postfix) with ESMTP id D3A641140172;
 Thu, 26 Dec 2024 16:19:55 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Thu, 26 Dec 2024 16:19:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735247995;
 x=1735334395; bh=1dyXMSuDYiyHHVXUJfqzXihl7agJ2Ol0SZf8+RalGTY=; b=
 W85UVr426EG/zOEyzxJJAeDm6Pn1jKcdAgQHqQQ1WrQf7OGYoKH65Y/gcqM34HP8
 wUwAE7kDeMl/UpWtLvmgk5wigCtUdLqN8nPu7ofRIRIuOTVWLHwiKqO4cauzZfOe
 /b3ckUDjdPDkVFSVzg/5gYjuB1kYayIFltebONwCk2P7gNc01CecbHW2fQ53c8H8
 UvNGwOIPMeGvSrgA7g8EY2JHWs0fC1g6rPlA0qMQxnrS0KXmO/tG5C1A2h6mp6pM
 ZNMhfLGqcqyEhb9p490oAuM2pCK8zBG9SfBDlZvSSGj8UJQofNRd4k1RXVG1C+Mz
 PnJu54WeupdDi1zz6qxK+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735247995; x=
 1735334395; bh=1dyXMSuDYiyHHVXUJfqzXihl7agJ2Ol0SZf8+RalGTY=; b=M
 afi1+G6L6fI5HQFvLNQ2j8UDAxJBKk4/a+7JE7EFphqf5mGdyY9/T3JXlol/d2Rq
 WUF0DKV4MRbnxXvRLDiRTayXWn0ri/vfz1N2UNFVLH710T94FFRG+uPejh3Ksp8s
 TIuWG5XwPr0i85RrhMCGoUDoTsYwRMuW8Mnf/UXKsXtGZWV2ZcBot0WjsaCpxyIp
 5YnXlK9h7g6E/fwgdmexM6xbZYf5dmxiyF5IlZHnsvioqbLlrxGrC8TzriauDf/J
 agHyXTg94j1rdHX3u2FGPKALUb1Aycn2rAws2vz9E2jlKT/TWS6jtSYrc0pLPeUn
 CmkrbyPC8wGVXKePbahrw==
X-ME-Sender: <xms:e8htZ4EAVDawLRe6sFozzvthGr7FhywuaEh6dndrCDehLHjiRRae2w>
 <xme:e8htZxU5Gjczcn_gmUJmodfqax8BLsTJy76ZwG85Md8UUMBNOJyVxkMOsbADQdSot
 vuhGFZYpBUJtQu1A3Y>
X-ME-Received: <xmr:e8htZyKEL9LoeGU1hb1Ah2cRBBo_YIICKreO2uvNF9ztITApNKE-KQwT>
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
X-ME-Proxy: <xmx:e8htZ6E6Lb8Lpq_hngT2SRBWPxmBjnyDFpnX6rx2tGzAxfepn0o59A>
 <xmx:e8htZ-Vgnu-1KfX2bgD4VCTIukaOxsi6pauZworH4Ey5-GYM5ZZjXA>
 <xmx:e8htZ9Obf7uS_MZV0CJ9dC3q1UZSW2prFij1MzdbMHTvUwHaa0oN-A>
 <xmx:e8htZ118do7n0xvSg8EuB0aDJaZKfNaybatq0nA3ar_5gHYgQ0vlsQ>
 <xmx:e8htZ_tN3vmvDBXeq8Bis7yoX7H1Xc8iUtvZsrx2fpaEhsW-mODsce35>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 16:19:53 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 26 Dec 2024 21:19:37 +0000
Subject: [PATCH v2 06/23] target/loongarch: Store some uint64_t values as
 target_ulong
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241226-la32-fixes1-v2-6-0414594f8cb5@flygoat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=16603;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=sbJnd056LAZaUCNScVsknOWxhwATEI+sdXtyYdtfH7k=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvTcE9mquiFS/rMl7ET5fwofnLDzjaLwJA/3ifMdrlZor
 k1Y9WJjRykLgxgXg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAEzEbiojwxTjfa3zjb82dF49
 J1Vf/lNHcmP584tVjfMzzb58k+ZM7WH4Z1ww3ayn+l2OmmfaRgf1zduPqq3Wm+C+1fLi7LrHF5b
 s5QUA
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

Store internal registers including GPRs, CSRs, and LBT scratchs
as target_ulong, as per architecture specification.

The only exception here is tlb_misc, as it's only used by QEMU
internally and need keep to be 64bit to store all required fields.

There is no migration ABI change, as target_ulong is uint64_t on
existing loongarch64 builds anyway.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/loongarch/cpu.c     |  34 ++++++------
 target/loongarch/cpu.h     | 132 ++++++++++++++++++++++-----------------------
 target/loongarch/machine.c | 120 ++++++++++++++++++++---------------------
 3 files changed, 143 insertions(+), 143 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index f5bc8720d1fc1b28950ee02de5ae6cce86fc6a96..82412f8867a50a6cd25cff511def0f24d2b10b49 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -748,7 +748,7 @@ static void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     CPULoongArchState *env = cpu_env(cs);
     int i;
 
-    qemu_fprintf(f, " PC=%016" PRIx64 " ", env->pc);
+    qemu_fprintf(f, " PC=" TARGET_FMT_lx " ", env->pc);
     qemu_fprintf(f, " FCSR0 0x%08x\n", env->fcsr0);
 
     /* gpr */
@@ -756,28 +756,28 @@ static void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         if ((i & 3) == 0) {
             qemu_fprintf(f, " GPR%02d:", i);
         }
-        qemu_fprintf(f, " %s %016" PRIx64, regnames[i], env->gpr[i]);
+        qemu_fprintf(f, " %s " TARGET_FMT_lx, regnames[i], env->gpr[i]);
         if ((i & 3) == 3) {
             qemu_fprintf(f, "\n");
         }
     }
 
-    qemu_fprintf(f, "CRMD=%016" PRIx64 "\n", env->CSR_CRMD);
-    qemu_fprintf(f, "PRMD=%016" PRIx64 "\n", env->CSR_PRMD);
-    qemu_fprintf(f, "EUEN=%016" PRIx64 "\n", env->CSR_EUEN);
-    qemu_fprintf(f, "ESTAT=%016" PRIx64 "\n", env->CSR_ESTAT);
-    qemu_fprintf(f, "ERA=%016" PRIx64 "\n", env->CSR_ERA);
-    qemu_fprintf(f, "BADV=%016" PRIx64 "\n", env->CSR_BADV);
-    qemu_fprintf(f, "BADI=%016" PRIx64 "\n", env->CSR_BADI);
-    qemu_fprintf(f, "EENTRY=%016" PRIx64 "\n", env->CSR_EENTRY);
-    qemu_fprintf(f, "PRCFG1=%016" PRIx64 ", PRCFG2=%016" PRIx64 ","
-                 " PRCFG3=%016" PRIx64 "\n",
+    qemu_fprintf(f, "CRMD=" TARGET_FMT_lx "\n", env->CSR_CRMD);
+    qemu_fprintf(f, "PRMD=" TARGET_FMT_lx "\n", env->CSR_PRMD);
+    qemu_fprintf(f, "EUEN=" TARGET_FMT_lx "\n", env->CSR_EUEN);
+    qemu_fprintf(f, "ESTAT=" TARGET_FMT_lx "\n", env->CSR_ESTAT);
+    qemu_fprintf(f, "ERA=" TARGET_FMT_lx "\n", env->CSR_ERA);
+    qemu_fprintf(f, "BADV=" TARGET_FMT_lx "\n", env->CSR_BADV);
+    qemu_fprintf(f, "BADI=" TARGET_FMT_lx "\n", env->CSR_BADI);
+    qemu_fprintf(f, "EENTRY=" TARGET_FMT_lx "\n", env->CSR_EENTRY);
+    qemu_fprintf(f, "PRCFG1=" TARGET_FMT_lx ", PRCFG2=" TARGET_FMT_lx ","
+                 " PRCFG3=" TARGET_FMT_lx "\n",
                  env->CSR_PRCFG1, env->CSR_PRCFG2, env->CSR_PRCFG3);
-    qemu_fprintf(f, "TLBRENTRY=%016" PRIx64 "\n", env->CSR_TLBRENTRY);
-    qemu_fprintf(f, "TLBRBADV=%016" PRIx64 "\n", env->CSR_TLBRBADV);
-    qemu_fprintf(f, "TLBRERA=%016" PRIx64 "\n", env->CSR_TLBRERA);
-    qemu_fprintf(f, "TCFG=%016" PRIx64 "\n", env->CSR_TCFG);
-    qemu_fprintf(f, "TVAL=%016" PRIx64 "\n", env->CSR_TVAL);
+    qemu_fprintf(f, "TLBRENTRY=" TARGET_FMT_lx "\n", env->CSR_TLBRENTRY);
+    qemu_fprintf(f, "TLBRBADV=" TARGET_FMT_lx "\n", env->CSR_TLBRBADV);
+    qemu_fprintf(f, "TLBRERA=" TARGET_FMT_lx "\n", env->CSR_TLBRERA);
+    qemu_fprintf(f, "TCFG=" TARGET_FMT_lx "\n", env->CSR_TCFG);
+    qemu_fprintf(f, "TVAL=" TARGET_FMT_lx "\n", env->CSR_TVAL);
 
     /* fpr */
     if (flags & CPU_DUMP_FPU) {
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 86c86c6c958db1a215a3e76a27f379bd4a095fb6..4f542a3376831141d012f177dc46a0e928afc85c 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -276,8 +276,8 @@ union fpr_t {
 struct LoongArchTLB {
     uint64_t tlb_misc;
     /* Fields corresponding to CSR_TLBELO0/1 */
-    uint64_t tlb_entry0;
-    uint64_t tlb_entry1;
+    target_ulong tlb_entry0;
+    target_ulong tlb_entry1;
 };
 typedef struct LoongArchTLB LoongArchTLB;
 #endif
@@ -289,18 +289,18 @@ enum loongarch_features {
 
 typedef struct  LoongArchBT {
     /* scratch registers */
-    uint64_t scr0;
-    uint64_t scr1;
-    uint64_t scr2;
-    uint64_t scr3;
+    target_ulong scr0;
+    target_ulong scr1;
+    target_ulong scr2;
+    target_ulong scr3;
     /* loongarch eflags */
     uint32_t eflags;
     uint32_t ftop;
 } lbt_t;
 
 typedef struct CPUArchState {
-    uint64_t gpr[32];
-    uint64_t pc;
+    target_ulong gpr[32];
+    target_ulong pc;
 
     fpr_t fpr[32];
     bool cf[8];
@@ -310,69 +310,69 @@ typedef struct CPUArchState {
     uint32_t cpucfg[21];
 
     /* LoongArch CSRs */
-    uint64_t CSR_CRMD;
-    uint64_t CSR_PRMD;
-    uint64_t CSR_EUEN;
-    uint64_t CSR_MISC;
-    uint64_t CSR_ECFG;
-    uint64_t CSR_ESTAT;
-    uint64_t CSR_ERA;
-    uint64_t CSR_BADV;
-    uint64_t CSR_BADI;
-    uint64_t CSR_EENTRY;
-    uint64_t CSR_TLBIDX;
-    uint64_t CSR_TLBEHI;
-    uint64_t CSR_TLBELO0;
-    uint64_t CSR_TLBELO1;
-    uint64_t CSR_ASID;
-    uint64_t CSR_PGDL;
-    uint64_t CSR_PGDH;
-    uint64_t CSR_PGD;
-    uint64_t CSR_PWCL;
-    uint64_t CSR_PWCH;
-    uint64_t CSR_STLBPS;
-    uint64_t CSR_RVACFG;
-    uint64_t CSR_CPUID;
-    uint64_t CSR_PRCFG1;
-    uint64_t CSR_PRCFG2;
-    uint64_t CSR_PRCFG3;
-    uint64_t CSR_SAVE[16];
-    uint64_t CSR_TID;
-    uint64_t CSR_TCFG;
-    uint64_t CSR_TVAL;
-    uint64_t CSR_CNTC;
-    uint64_t CSR_TICLR;
-    uint64_t CSR_LLBCTL;
-    uint64_t CSR_IMPCTL1;
-    uint64_t CSR_IMPCTL2;
-    uint64_t CSR_TLBRENTRY;
-    uint64_t CSR_TLBRBADV;
-    uint64_t CSR_TLBRERA;
-    uint64_t CSR_TLBRSAVE;
-    uint64_t CSR_TLBRELO0;
-    uint64_t CSR_TLBRELO1;
-    uint64_t CSR_TLBREHI;
-    uint64_t CSR_TLBRPRMD;
-    uint64_t CSR_MERRCTL;
-    uint64_t CSR_MERRINFO1;
-    uint64_t CSR_MERRINFO2;
-    uint64_t CSR_MERRENTRY;
-    uint64_t CSR_MERRERA;
-    uint64_t CSR_MERRSAVE;
-    uint64_t CSR_CTAG;
-    uint64_t CSR_DMW[4];
-    uint64_t CSR_DBG;
-    uint64_t CSR_DERA;
-    uint64_t CSR_DSAVE;
+    target_ulong CSR_CRMD;
+    target_ulong CSR_PRMD;
+    target_ulong CSR_EUEN;
+    target_ulong CSR_MISC;
+    target_ulong CSR_ECFG;
+    target_ulong CSR_ESTAT;
+    target_ulong CSR_ERA;
+    target_ulong CSR_BADV;
+    target_ulong CSR_BADI;
+    target_ulong CSR_EENTRY;
+    target_ulong CSR_TLBIDX;
+    target_ulong CSR_TLBEHI;
+    target_ulong CSR_TLBELO0;
+    target_ulong CSR_TLBELO1;
+    target_ulong CSR_ASID;
+    target_ulong CSR_PGDL;
+    target_ulong CSR_PGDH;
+    target_ulong CSR_PGD;
+    target_ulong CSR_PWCL;
+    target_ulong CSR_PWCH;
+    target_ulong CSR_STLBPS;
+    target_ulong CSR_RVACFG;
+    target_ulong CSR_CPUID;
+    target_ulong CSR_PRCFG1;
+    target_ulong CSR_PRCFG2;
+    target_ulong CSR_PRCFG3;
+    target_ulong CSR_SAVE[16];
+    target_ulong CSR_TID;
+    target_ulong CSR_TCFG;
+    target_ulong CSR_TVAL;
+    target_ulong CSR_CNTC;
+    target_ulong CSR_TICLR;
+    target_ulong CSR_LLBCTL;
+    target_ulong CSR_IMPCTL1;
+    target_ulong CSR_IMPCTL2;
+    target_ulong CSR_TLBRENTRY;
+    target_ulong CSR_TLBRBADV;
+    target_ulong CSR_TLBRERA;
+    target_ulong CSR_TLBRSAVE;
+    target_ulong CSR_TLBRELO0;
+    target_ulong CSR_TLBRELO1;
+    target_ulong CSR_TLBREHI;
+    target_ulong CSR_TLBRPRMD;
+    target_ulong CSR_MERRCTL;
+    target_ulong CSR_MERRINFO1;
+    target_ulong CSR_MERRINFO2;
+    target_ulong CSR_MERRENTRY;
+    target_ulong CSR_MERRERA;
+    target_ulong CSR_MERRSAVE;
+    target_ulong CSR_CTAG;
+    target_ulong CSR_DMW[4];
+    target_ulong CSR_DBG;
+    target_ulong CSR_DERA;
+    target_ulong CSR_DSAVE;
     struct {
-        uint64_t guest_addr;
+        target_ulong guest_addr;
     } stealtime;
 
 #ifdef CONFIG_TCG
     float_status fp_status;
     uint32_t fcsr0_mask;
-    uint64_t lladdr; /* LL virtual address compared against SC */
-    uint64_t llval;
+    target_ulong lladdr; /* LL virtual address compared against SC */
+    target_ulong llval;
 #endif
 #ifndef CONFIG_USER_ONLY
 #ifdef CONFIG_TCG
@@ -381,7 +381,7 @@ typedef struct CPUArchState {
 
     AddressSpace *address_space_iocsr;
     bool load_elf;
-    uint64_t elf_address;
+    target_ulong elf_address;
     uint32_t mp_state;
     /* Store ipistate to access from this struct */
     DeviceState *ipistate;
diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
index 4e70f5c8798bdc826df809c98e8adb4ebf879c39..ba6e4f9df259c9a25962a4cfa180280f56ba6077 100644
--- a/target/loongarch/machine.c
+++ b/target/loongarch/machine.c
@@ -123,10 +123,10 @@ static const VMStateDescription vmstate_lbt = {
     .minimum_version_id = 0,
     .needed = lbt_needed,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT64(env.lbt.scr0,   LoongArchCPU),
-        VMSTATE_UINT64(env.lbt.scr1,   LoongArchCPU),
-        VMSTATE_UINT64(env.lbt.scr2,   LoongArchCPU),
-        VMSTATE_UINT64(env.lbt.scr3,   LoongArchCPU),
+        VMSTATE_UINTTL(env.lbt.scr0,   LoongArchCPU),
+        VMSTATE_UINTTL(env.lbt.scr1,   LoongArchCPU),
+        VMSTATE_UINTTL(env.lbt.scr2,   LoongArchCPU),
+        VMSTATE_UINTTL(env.lbt.scr3,   LoongArchCPU),
         VMSTATE_UINT32(env.lbt.eflags, LoongArchCPU),
         VMSTATE_UINT32(env.lbt.ftop,   LoongArchCPU),
         VMSTATE_END_OF_LIST()
@@ -146,8 +146,8 @@ static const VMStateDescription vmstate_tlb_entry = {
     .minimum_version_id = 0,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT64(tlb_misc, LoongArchTLB),
-        VMSTATE_UINT64(tlb_entry0, LoongArchTLB),
-        VMSTATE_UINT64(tlb_entry1, LoongArchTLB),
+        VMSTATE_UINTTL(tlb_entry0, LoongArchTLB),
+        VMSTATE_UINTTL(tlb_entry1, LoongArchTLB),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -175,65 +175,65 @@ const VMStateDescription vmstate_loongarch_cpu = {
         VMSTATE_UINTTL(env.pc, LoongArchCPU),
 
         /* Remaining CSRs */
-        VMSTATE_UINT64(env.CSR_CRMD, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PRMD, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_EUEN, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_MISC, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_ECFG, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_ESTAT, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_ERA, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_BADV, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_BADI, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_EENTRY, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBIDX, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBEHI, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBELO0, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBELO1, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_ASID, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PGDL, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PGDH, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PGD, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PWCL, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PWCH, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_STLBPS, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_RVACFG, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PRCFG1, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PRCFG2, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PRCFG3, LoongArchCPU),
-        VMSTATE_UINT64_ARRAY(env.CSR_SAVE, LoongArchCPU, 16),
-        VMSTATE_UINT64(env.CSR_TID, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TCFG, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TVAL, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_CNTC, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TICLR, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_LLBCTL, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_IMPCTL1, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_IMPCTL2, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBRENTRY, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBRBADV, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBRERA, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBRSAVE, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBRELO0, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBRELO1, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBREHI, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBRPRMD, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_MERRCTL, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_MERRINFO1, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_MERRINFO2, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_MERRENTRY, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_MERRERA, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_MERRSAVE, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_CTAG, LoongArchCPU),
-        VMSTATE_UINT64_ARRAY(env.CSR_DMW, LoongArchCPU, 4),
+        VMSTATE_UINTTL(env.CSR_CRMD, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_PRMD, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_EUEN, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_MISC, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_ECFG, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_ESTAT, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_ERA, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_BADV, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_BADI, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_EENTRY, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_TLBIDX, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_TLBEHI, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_TLBELO0, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_TLBELO1, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_ASID, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_PGDL, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_PGDH, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_PGD, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_PWCL, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_PWCH, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_STLBPS, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_RVACFG, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_PRCFG1, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_PRCFG2, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_PRCFG3, LoongArchCPU),
+        VMSTATE_UINTTL_ARRAY(env.CSR_SAVE, LoongArchCPU, 16),
+        VMSTATE_UINTTL(env.CSR_TID, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_TCFG, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_TVAL, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_CNTC, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_TICLR, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_LLBCTL, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_IMPCTL1, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_IMPCTL2, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_TLBRENTRY, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_TLBRBADV, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_TLBRERA, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_TLBRSAVE, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_TLBRELO0, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_TLBRELO1, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_TLBREHI, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_TLBRPRMD, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_MERRCTL, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_MERRINFO1, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_MERRINFO2, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_MERRENTRY, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_MERRERA, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_MERRSAVE, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_CTAG, LoongArchCPU),
+        VMSTATE_UINTTL_ARRAY(env.CSR_DMW, LoongArchCPU, 4),
 
         /* Debug CSRs */
-        VMSTATE_UINT64(env.CSR_DBG, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_DERA, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_DSAVE, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_DBG, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_DERA, LoongArchCPU),
+        VMSTATE_UINTTL(env.CSR_DSAVE, LoongArchCPU),
 
         VMSTATE_UINT64(kvm_state_counter, LoongArchCPU),
         /* PV steal time */
-        VMSTATE_UINT64(env.stealtime.guest_addr, LoongArchCPU),
+        VMSTATE_UINTTL(env.stealtime.guest_addr, LoongArchCPU),
 
         VMSTATE_END_OF_LIST()
     },

-- 
2.43.0


