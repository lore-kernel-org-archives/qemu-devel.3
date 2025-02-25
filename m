Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF98C021A4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 00:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmj0c-0004zZ-1B; Mon, 24 Feb 2025 19:41:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tmizu-0004bi-UZ
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 19:40:33 -0500
Received: from fhigh-b6-smtp.messagingengine.com ([202.12.124.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tmizs-0003TB-Jo
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 19:40:30 -0500
Received: from phl-compute-02.internal (phl-compute-02.phl.internal
 [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id C64B3254018F;
 Mon, 24 Feb 2025 19:40:27 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Mon, 24 Feb 2025 19:40:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1740444027;
 x=1740530427; bh=JkAukGpz/E9zLuH7gz/MK+Jk5KcVnEYytZeU+2jd21Q=; b=
 mXl+V6CcA4beFs68xBbWEcec0n74AvcPDGf1udXwCxfdULBf1f66ju0PyMThahgy
 QULFG6jL488AedBfpUdP+41VQYj3Sme7HADg81MDiSROsTtKjzXR7dZwj3JR076T
 MHa/k/vBemhStLcAhLVpBqUw41ZTL3sbWLgZ+hKXFWn58mmy25K3GNVGW934igVZ
 GjUXfEEYze4JI0iOPU9QQzlaDr7QHU7lD6ONmPcZQgk9NwbtPGYEBPabKnYEZceo
 7F2F98Hp5L8lQeM7tkhsTWah7/3my8yG8q8wmXu9HVnF6byzZM0mrq8SKqwIlPjz
 hLAHmWCDG5S2pAtoFkpw2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740444027; x=
 1740530427; bh=JkAukGpz/E9zLuH7gz/MK+Jk5KcVnEYytZeU+2jd21Q=; b=4
 MIIRcPsqYfcKjnYDuIK3hsc1Q0xmLbLeWLv/2c581OMUgwBK1+MUumvNE33bIt9f
 5BvsfQkoVa/lXcrFSlMH6UZnRmsUpVLfyvZ6qkVVwzfwYxuL6MveQS/FAyteQe9/
 65bGfWTbynJwdWIGtNldK1+9dG67FWREVGV4ZwRN/uulrBRLYJKlfAPjpdjNeoJc
 maA99cNm3F9IB9jaSH5GVHIUzL/MdQQKAXKmyHVLPo3WCuI95uBQ2+9TPb4dOd9e
 N5BhbZOxchutn6Ajik/nViw69Fz7YMdyjUFVFtKpTONNE/jL3JGFY2aC+eZdSQuw
 +ODoknQ9r3ZnPPNDrJZYQ==
X-ME-Sender: <xms:exG9ZyPyP5wpGbZ2tAx44ssRiWcllv9yOXF0y0xzVXkFd6w0-YLMqA>
 <xme:exG9Zw-n_9SVgH9CqujzPXy4FRh-4WrnSXzbnoqtGE_hi7pcViX-9Jt90qOG3YtOR
 HOf4rAj1JOkC1gsaJI>
X-ME-Received: <xmr:exG9Z5TzJVyGvkXmYfpbhNexohvZWMINAxRGPtOVFnXnkzZDb4Bl4ds>
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
X-ME-Proxy: <xmx:exG9ZysaU37eyxFa40lvBGcIRAR5gHtG8aaMklcjuvFsLgtrwnfYUw>
 <xmx:exG9Z6eKzBgq9G-Z87kPUOSRY8OfOX2k3KVNDD6k29IQIO-jwGd7tA>
 <xmx:exG9Z22vg3gYP8smusNP6E5E7lOOcvDVT9N-6gSMDs312xxMjhVjag>
 <xmx:exG9Z-8wx1CbzZBti5hLzb_gA867R3_yfImJv5IyDfl6bBNTuJYuAg>
 <xmx:exG9Z661V0blDTcdy7y2qAB_cJp6K-wCCXo1wSQmJ1ex9D4hYDqG9Gpp>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 19:40:26 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 25 Feb 2025 00:40:22 +0000
Subject: [PATCH v2 9/9] target/loongarch: Introduce max32 CPU type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-la32-fixes1-v2-9-8ec68ada3dd5@flygoat.com>
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

Introduce max32 CPU type as it's necessary to demonstrate all
features we have in LA32.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/loongarch/cpu.c | 152 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 122 insertions(+), 30 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index f5bc8720d1fc1b28950ee02de5ae6cce86fc6a96..43a18871ea88a92c72a3b3f1493d760df6f0df20 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -375,6 +375,126 @@ static int loongarch_cpu_mmu_index(CPUState *cs, bool ifetch)
     return MMU_DA_IDX;
 }
 
+static void loongarch_la132_initfn(Object *obj)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+    CPULoongArchState *env = &cpu->env;
+
+    int i;
+
+    for (i = 0; i < 21; i++) {
+        env->cpucfg[i] = 0x0;
+    }
+
+    cpu->dtb_compatible = "loongarch,Loongson-1C103";
+    env->cpucfg[0] = 0x148042;  /* PRID */
+
+    uint32_t data = 0;
+    data = FIELD_DP32(data, CPUCFG1, ARCH, 1); /* LA32 */
+    data = FIELD_DP32(data, CPUCFG1, PGMMU, 1);
+    data = FIELD_DP32(data, CPUCFG1, IOCSR, 1);
+    data = FIELD_DP32(data, CPUCFG1, PALEN, 0x1f); /* 32 bits */
+    data = FIELD_DP32(data, CPUCFG1, VALEN, 0x1f); /* 32 bits */
+    data = FIELD_DP32(data, CPUCFG1, UAL, 1);
+    data = FIELD_DP32(data, CPUCFG1, RI, 0);
+    data = FIELD_DP32(data, CPUCFG1, EP, 0);
+    data = FIELD_DP32(data, CPUCFG1, RPLV, 0);
+    data = FIELD_DP32(data, CPUCFG1, HP, 1);
+    data = FIELD_DP32(data, CPUCFG1, IOCSR_BRD, 1);
+    env->cpucfg[1] = data;
+}
+
+static void loongarch_max32_initfn(Object *obj)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+    CPULoongArchState *env = &cpu->env;
+    int i;
+
+    for (i = 0; i < 21; i++) {
+        env->cpucfg[i] = 0x0;
+    }
+
+    cpu->dtb_compatible = "loongarch,la32";
+    env->cpucfg[0] = 0x148042;  /* PRID */
+
+    uint32_t data = 0;
+    data = FIELD_DP32(data, CPUCFG1, ARCH, 1); /* LA32 */
+    data = FIELD_DP32(data, CPUCFG1, PGMMU, 1);
+    data = FIELD_DP32(data, CPUCFG1, IOCSR, 1);
+    data = FIELD_DP32(data, CPUCFG1, PALEN, 0x1f); /* 32 bits */
+    data = FIELD_DP32(data, CPUCFG1, VALEN, 0x1f); /* 32 bits */
+    data = FIELD_DP32(data, CPUCFG1, UAL, 1);
+    data = FIELD_DP32(data, CPUCFG1, HP, 1);
+    data = FIELD_DP32(data, CPUCFG1, IOCSR_BRD, 1);
+    env->cpucfg[1] = data;
+
+    data = 0;
+    data = FIELD_DP32(data, CPUCFG2, FP, 1);
+    data = FIELD_DP32(data, CPUCFG2, FP_SP, 1);
+    data = FIELD_DP32(data, CPUCFG2, FP_DP, 1);
+    data = FIELD_DP32(data, CPUCFG2, FP_VER, 1);
+    data = FIELD_DP32(data, CPUCFG2, LLFTP, 1);
+    data = FIELD_DP32(data, CPUCFG2, LLFTP_VER, 1);
+    env->cpucfg[2] = data;
+
+    data = 0;
+    data = FIELD_DP32(data, CPUCFG3, CCDMA, 1);
+    data = FIELD_DP32(data, CPUCFG3, ITLBHMC, 1);
+    data = FIELD_DP32(data, CPUCFG3, ICHMC, 1);
+    env->cpucfg[3] = data;
+
+    env->cpucfg[4] = 100 * 1000 * 1000; /* Crystal frequency */
+
+    data = 0;
+    data = FIELD_DP32(data, CPUCFG5, CC_MUL, 1);
+    data = FIELD_DP32(data, CPUCFG5, CC_DIV, 1);
+    env->cpucfg[5] = data;
+
+    data = 0;
+    data = FIELD_DP32(data, CPUCFG16, L1_IUPRE, 1);
+    data = FIELD_DP32(data, CPUCFG16, L1_DPRE, 1);
+    data = FIELD_DP32(data, CPUCFG16, L2_IUPRE, 1);
+    data = FIELD_DP32(data, CPUCFG16, L2_IUUNIFY, 1);
+    data = FIELD_DP32(data, CPUCFG16, L2_IUINCL, 1);
+    env->cpucfg[16] = data;
+
+    /* 16K L1I */
+    data = 0;
+    data = FIELD_DP32(data, CPUCFG17, L1IU_WAYS, 3);
+    data = FIELD_DP32(data, CPUCFG17, L1IU_SETS, 7);
+    data = FIELD_DP32(data, CPUCFG17, L1IU_SIZE, 5);
+    env->cpucfg[17] = data;
+
+    /* 16K L1D */
+    data = 0;
+    data = FIELD_DP32(data, CPUCFG18, L1D_WAYS, 3);
+    data = FIELD_DP32(data, CPUCFG18, L1D_SETS, 7);
+    data = FIELD_DP32(data, CPUCFG18, L1D_SIZE, 5);
+    env->cpucfg[18] = data;
+
+    data = 0;
+    /* 128K L2 */
+    data = FIELD_DP32(data, CPUCFG19, L2IU_WAYS, 7);
+    data = FIELD_DP32(data, CPUCFG19, L2IU_SETS, 9);
+    data = FIELD_DP32(data, CPUCFG19, L2IU_SIZE, 5);
+    env->cpucfg[19] = data;
+
+    env->CSR_ASID = FIELD_DP64(0, CSR_ASID, ASIDBITS, 0xa);
+
+    env->CSR_PRCFG1 = FIELD_DP64(env->CSR_PRCFG1, CSR_PRCFG1, SAVE_NUM, 8);
+    env->CSR_PRCFG1 = FIELD_DP64(env->CSR_PRCFG1, CSR_PRCFG1, TIMER_BITS, 31);
+    env->CSR_PRCFG1 = FIELD_DP64(env->CSR_PRCFG1, CSR_PRCFG1, VSMAX, 0);
+
+    env->CSR_PRCFG2 = 0x3ffff000;
+
+    env->CSR_PRCFG3 = FIELD_DP64(env->CSR_PRCFG3, CSR_PRCFG3, TLB_TYPE, 2);
+    env->CSR_PRCFG3 = FIELD_DP64(env->CSR_PRCFG3, CSR_PRCFG3, MTLB_ENTRY, 63);
+    env->CSR_PRCFG3 = FIELD_DP64(env->CSR_PRCFG3, CSR_PRCFG3, STLB_WAYS, 7);
+    env->CSR_PRCFG3 = FIELD_DP64(env->CSR_PRCFG3, CSR_PRCFG3, STLB_SETS, 8);
+
+    loongarch_cpu_post_init(obj);
+}
+
 static void loongarch_la464_initfn(Object *obj)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(obj);
@@ -473,35 +593,6 @@ static void loongarch_la464_initfn(Object *obj)
     loongarch_cpu_post_init(obj);
 }
 
-static void loongarch_la132_initfn(Object *obj)
-{
-    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
-    CPULoongArchState *env = &cpu->env;
-
-    int i;
-
-    for (i = 0; i < 21; i++) {
-        env->cpucfg[i] = 0x0;
-    }
-
-    cpu->dtb_compatible = "loongarch,Loongson-1C103";
-    env->cpucfg[0] = 0x148042;  /* PRID */
-
-    uint32_t data = 0;
-    data = FIELD_DP32(data, CPUCFG1, ARCH, 1); /* LA32 */
-    data = FIELD_DP32(data, CPUCFG1, PGMMU, 1);
-    data = FIELD_DP32(data, CPUCFG1, IOCSR, 1);
-    data = FIELD_DP32(data, CPUCFG1, PALEN, 0x1f); /* 32 bits */
-    data = FIELD_DP32(data, CPUCFG1, VALEN, 0x1f); /* 32 bits */
-    data = FIELD_DP32(data, CPUCFG1, UAL, 1);
-    data = FIELD_DP32(data, CPUCFG1, RI, 0);
-    data = FIELD_DP32(data, CPUCFG1, EP, 0);
-    data = FIELD_DP32(data, CPUCFG1, RPLV, 0);
-    data = FIELD_DP32(data, CPUCFG1, HP, 1);
-    data = FIELD_DP32(data, CPUCFG1, IOCSR_BRD, 1);
-    env->cpucfg[1] = data;
-}
-
 static void loongarch_max_initfn(Object *obj)
 {
     /* '-cpu max' for TCG: we use cpu la464. */
@@ -916,8 +1007,9 @@ static const TypeInfo loongarch_cpu_type_infos[] = {
         .abstract = true,
         .class_init = loongarch64_cpu_class_init,
     },
-    DEFINE_LOONGARCH_CPU_TYPE(64, "la464", loongarch_la464_initfn),
     DEFINE_LOONGARCH_CPU_TYPE(32, "la132", loongarch_la132_initfn),
+    DEFINE_LOONGARCH_CPU_TYPE(32, "max32", loongarch_max32_initfn),
+    DEFINE_LOONGARCH_CPU_TYPE(64, "la464", loongarch_la464_initfn),
     DEFINE_LOONGARCH_CPU_TYPE(64, "max", loongarch_max_initfn),
 };
 

-- 
2.43.0


