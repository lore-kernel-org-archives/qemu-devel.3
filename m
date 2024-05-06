Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC52C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 15:32:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s40Js-0007j6-UT; Mon, 06 May 2024 11:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1s40Jp-0007hF-1x
 for qemu-devel@nongnu.org; Mon, 06 May 2024 11:31:59 -0400
Received: from wfhigh1-smtp.messagingengine.com ([64.147.123.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1s40Jk-0003Jj-W0
 for qemu-devel@nongnu.org; Mon, 06 May 2024 11:31:55 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfhigh.west.internal (Postfix) with ESMTP id 0E4F21800143;
 Mon,  6 May 2024 11:31:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Mon, 06 May 2024 11:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715009509;
 x=1715095909; bh=2kuNcBBCNIBTaFBvxiXhPQn5uSFy+yrNa24i85xHEC8=; b=
 hFMJsVrDm6ThZcwKdF0fGyzgnmkpZSjN4PwsK1xfn14m6Zt9GPpvXs8+hoDiZTSz
 3EnLLd3GO6Cl27NbjS7y17wx0IMlu5p1HN6CaZzFSZWBw4aMuiJOLjhOKViNFSRO
 t4hH3y179ge74aLTQKevsbwBJ/uv/REcoZ596E9de30v2mHsM41MOvbZK8tx0CXA
 NSSVSs5QEhy/sCXsCbJYExCF4LTjsADAGk4OGLAlbf8Hf4WVmTCZ1xkOEPz4pdQn
 LYYnaf3WGB+sIcosJiUx4SUR8ZOEeGWZ1z0JILi2G6Td2lpIXhxf7k4l8Nl7hCi4
 938DptHH8FiK2C7fhk7x+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715009509; x=
 1715095909; bh=2kuNcBBCNIBTaFBvxiXhPQn5uSFy+yrNa24i85xHEC8=; b=K
 VWua7GEZG3f0rCctUinQBOhsg2mhh3bhN1av5uh/Y9zCjFTxMztsnc17iwRyAzWD
 0uzJs4S+49UiAUP3FS+jci7GCa8gdAZ4J2qq8B1ZBojE3JGiyw4ay43yz/U7gLIH
 mL1xcdbKj89UKa9AuU6XscWDfr2NLYAVXfuQROVuhU5hj7zFRrx6rF5vT0SvtRHb
 7n8HunH1DwUxhdnRZodlnIUqReASU4yGOUYcHAdwRLb7+AuGEo7cCDlUwBepxNRU
 egIleIZD1kdDNyCGix5M3Px3JxfnMS4K3u4m/CdG5pcY3CoSTqq23nHCtgEMl6Ug
 GZFNzU+DFT/RjYoU0svNA==
X-ME-Sender: <xms:5fc4ZtsfHGwi45qPW6wq2IGHmSREmap2PcMtfl6hsud6Bly4SHfh2w>
 <xme:5fc4ZmductxnWObj1IGIX_tCQMLeXbVk0oTvcvg5WX9jYW3vstI3KLoLx1en2Y_lM
 lYnpvhGm06K2qCheWk>
X-ME-Received: <xmr:5fc4ZgzkPbwnzNOfyvVHRD8NSY4nLKoeBxzwGhX8pYty0dnCMI8s9Bw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddviedgledtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:5fc4ZkNNMKmn8V0ZZvQft_5XKxQMN9s4ei7GwXMWdu46lvD30nrhgA>
 <xmx:5fc4Zt_bAv-U8uOiIKBic1-_s1Fa-lFokMwALKTujQliibvO6WiZOA>
 <xmx:5fc4ZkWUPLpEyfmkpd0RthqCOdXZkH_SUG9oXfl9vBmM1Vjvl3PKWw>
 <xmx:5fc4ZuewOrEwPEMgwvDEIQ2tptTpOvWKTP4L-N6pLlgOA2dwI3qagA>
 <xmx:5fc4ZoZdh9BiQfq3EuHGDQ_f4FHsjw3ssNgyOl2DcqGt5909r6fTmZIj>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 11:31:48 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Mon, 06 May 2024 16:31:35 +0100
Subject: [PATCH 1/5] target/mips: Make globalnumber a CPU property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-mips-smp-v1-1-3cc234786910@flygoat.com>
References: <20240506-mips-smp-v1-0-3cc234786910@flygoat.com>
In-Reply-To: <20240506-mips-smp-v1-0-3cc234786910@flygoat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3976;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=CJg+yb6JSEoXL9V2aoefjDejZ9YFbsgnL4KcYazjW70=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjSL74+bF+kt7ckz/LWGMWIl23a5xZLH/mrsP1Evvt1p1
 evutwpLOkpZGMQ4GGTFFFlCBJT6NjReXHD9QdYfmDmsTCBDGLg4BWAiyT2MDIfU1DY9vsxQo712
 rd+ZU7ndDiynp1uW3UoVl9F/4DzHQJGRYclvFsvlkxpmuN1rmJvknPZvusrq1O9etr+WR2atObs
 jiAsA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=64.147.123.152;
 envelope-from=jiaxun.yang@flygoat.com; helo=wfhigh1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

GlobalNumber marks topology information of a CPU instance.

Make it a CPU property to allow CPS to override topology information.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/mips/cpu.c            | 16 +++++++++++++++-
 target/mips/cpu.h            | 10 +++++++++-
 target/mips/sysemu/machine.c |  5 ++---
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index bbe01d07dd..762000d09b 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -296,7 +296,6 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
     env->CP0_Random = env->tlb->nb_tlb - 1;
     env->tlb->tlb_in_use = env->tlb->nb_tlb;
     env->CP0_Wired = 0;
-    env->CP0_GlobalNumber = (cs->cpu_index & 0xFF) << CP0GN_VPId;
     env->CP0_EBase = KSEG0_BASE | (cs->cpu_index & 0x3FF);
     if (env->CP0_Config3 & (1 << CP0C3_CMGCR)) {
         env->CP0_CMGCRBase = 0x1fbf8000 >> 4;
@@ -484,6 +483,12 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
 
     env->exception_base = (int32_t)0xBFC00000;
 
+#if !defined(CONFIG_USER_ONLY)
+    if (env->CP0_GlobalNumber == -1) {
+        env->CP0_GlobalNumber = (cs->cpu_index & 0xFF) << CP0GN_VPId;
+    }
+#endif
+
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     mmu_init(env, env->cpu_model);
 #endif
@@ -563,6 +568,13 @@ static const TCGCPUOps mips_tcg_ops = {
 };
 #endif /* CONFIG_TCG */
 
+static Property mips_cpu_properties[] = {
+#if !defined(CONFIG_USER_ONLY)
+    DEFINE_PROP_INT32("globalnumber", MIPSCPU, env.CP0_GlobalNumber, -1),
+#endif
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void mips_cpu_class_init(ObjectClass *c, void *data)
 {
     MIPSCPUClass *mcc = MIPS_CPU_CLASS(c);
@@ -592,6 +604,8 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
 #ifdef CONFIG_TCG
     cc->tcg_ops = &mips_tcg_ops;
 #endif /* CONFIG_TCG */
+
+    device_class_set_props(dc, mips_cpu_properties);
 }
 
 static const TypeInfo mips_cpu_type_info = {
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 3e906a175a..7499608678 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -612,8 +612,13 @@ typedef struct CPUArchState {
 # define CP0EnLo_RI 31
 # define CP0EnLo_XI 30
 #endif
-    int32_t CP0_GlobalNumber;
+    /* CP0_GlobalNumber is preserved across CPU reset. */
 #define CP0GN_VPId 0
+#define CP0GN_VPId_MASK (0xFFUL << CP0GN_VPId)
+#define CP0GN_CoreNum 8
+#define CP0GN_CoreNum_MASK (0xFUL << CP0GN_CoreNum)
+#define CP0GN_ClusterNum 16
+#define CP0GN_ClusterNum_MASK (0xFUL << CP0GN_ClusterNum)
 /*
  * CP0 Register 4
  */
@@ -1175,6 +1180,9 @@ typedef struct CPUArchState {
     struct {} end_reset_fields;
 
     /* Fields from here on are preserved across CPU reset. */
+#if !defined(CONFIG_USER_ONLY)
+    int32_t CP0_GlobalNumber;
+#endif
     CPUMIPSMVPContext *mvp;
 #if !defined(CONFIG_USER_ONLY)
     CPUMIPSTLBContext *tlb;
diff --git a/target/mips/sysemu/machine.c b/target/mips/sysemu/machine.c
index 213fd637fc..235d640862 100644
--- a/target/mips/sysemu/machine.c
+++ b/target/mips/sysemu/machine.c
@@ -218,8 +218,8 @@ static const VMStateDescription vmstate_tlb = {
 
 const VMStateDescription vmstate_mips_cpu = {
     .name = "cpu",
-    .version_id = 21,
-    .minimum_version_id = 21,
+    .version_id = 22,
+    .minimum_version_id = 22,
     .post_load = cpu_post_load,
     .fields = (const VMStateField[]) {
         /* Active TC */
@@ -257,7 +257,6 @@ const VMStateDescription vmstate_mips_cpu = {
         VMSTATE_INT32(env.CP0_VPEOpt, MIPSCPU),
         VMSTATE_UINT64(env.CP0_EntryLo0, MIPSCPU),
         VMSTATE_UINT64(env.CP0_EntryLo1, MIPSCPU),
-        VMSTATE_INT32(env.CP0_GlobalNumber, MIPSCPU),
         VMSTATE_UINTTL(env.CP0_Context, MIPSCPU),
         VMSTATE_INT32(env.CP0_MemoryMapID, MIPSCPU),
         VMSTATE_INT32(env.CP0_PageMask, MIPSCPU),

-- 
2.34.1


