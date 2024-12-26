Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25526E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 21:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQvHT-0003vP-2U; Thu, 26 Dec 2024 16:20:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvHN-0003u8-Uz
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:20:26 -0500
Received: from fhigh-a4-smtp.messagingengine.com ([103.168.172.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvHL-0003Dx-28
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:20:24 -0500
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 9CECB114019B;
 Thu, 26 Dec 2024 16:20:22 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Thu, 26 Dec 2024 16:20:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735248022;
 x=1735334422; bh=lXdZQEAXwbRwZFnYdC1yZgfXrxQqV2X0q133oN/IeL4=; b=
 rile1toW8B+rFzrQNKqzvFwPJrwZ0NcRb3wd1n1lHNA7hnrpCYejo7t8fmwmvRGX
 Cn5n9Wn0CyY8AomJIA6P7bzFXyJUMQQpJ4GgUc35Eo+ljktYuPwGbvUMPG6X8q7u
 AEWcWDpr8alyTrvt0sj8i60kO7C6KgDST171MqnKd47wbOWhuhlzu0usY9J0TzjK
 8yIzIkpw7eonTcoT8CqZHpvyb0VkhTQfTffXNlMOWU/M9gSTY/LLugSjlnuJLxCf
 lU5koU03LIThqzCzFdZnB2lDtrAxauz0Lo66Xj1cqBZFBL6BnXdyLxlR+Y39N7Gq
 WGT62OoM3Nwe67e8mal5gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735248022; x=
 1735334422; bh=lXdZQEAXwbRwZFnYdC1yZgfXrxQqV2X0q133oN/IeL4=; b=v
 CSm+Bmc2ANy0hd3ADP1YNTc8vFDXfUq3YU2KPal2k/I7tQgX195s3e8A8WbrWYRT
 kXVO24I2FfVor3O9ZXFdlLc2L2m/k4cadc4uoil/urIkdbn9HkJlzJMcEYwcLNNK
 ul+jJbWqTvCYRhuuwCgmb0qsnNHuSe30klobegSr2CdKUG37SaotGg/Amx6gCecd
 zGFPZFXxYFYujug39SHBio3O6UN2qP9CXwSn4wUu5O1tYyfCotxR0oZlrGSqVfuM
 zV+dcFx4l+L0wIWNGznenorzYDeph5yjzVeMInoEm7wtfrOinUZQ2zEF31u8hdbp
 D+6rpFaVo3NFJHX4JtoUA==
X-ME-Sender: <xms:lshtZ18UwnA3hXys0eY2VMnXK8izypV1V8r9J4vHjspCnIaAOzr5zQ>
 <xme:lshtZ5sietJlQfpLzBbMXLIMNQ2nts3ZcZxu1zSQNvxgls64Ih3q0K9e1xBGPUwbz
 hmMu4VXBOhU0j7CstE>
X-ME-Received: <xmr:lshtZzBWXKE8TP12XMRFONYhuU8geCsLndg8w2j5biwPmrR2HTEnsIhB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddukedgudegjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
 jeenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflh
 ihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleff
 keegudeghfdtuddugefhueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedvne
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
X-ME-Proxy: <xmx:lshtZ5c-4wKferKq5pqZUxwIGE9Qb1t18t6D81Pqvs7R4-6NSO_GPw>
 <xmx:lshtZ6MUdUZ3qRnQnQFEk90v3-BkWqW7TtBtWi6IvFRXDAf-VeUNyw>
 <xmx:lshtZ7nXjhHP0qNCI6zOZ2_NvF8_bIkEqhrWN_ryphMX-3xz5q2iXg>
 <xmx:lshtZ0uhy44AcsRMC9kSro3FG6T6BF4DmionqpEsVvdCYqEDlEIsow>
 <xmx:lshtZ2mKnrUC0O3jTxS2W-b0JDVFunfXezLYTQmKoZputqwSzfWTAb-X>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 16:20:20 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 26 Dec 2024 21:19:50 +0000
Subject: [PATCH v2 19/23] target/loongarch: Introduce max32 CPU type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241226-la32-fixes1-v2-19-0414594f8cb5@flygoat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4409;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=vEacUjKkUMYiOaoh7JhdLKxOhu9cYeGzxhK2xx4ZzFk=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvTcE9nfGti89juZpZXkZv2uS1j3UPzY97Qg/UVLLnSt3
 92a+GxLRykLgxgXg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAExksxYjw6eMKj3P6NYPjx6w
 th7RuiW/jF3WveYuw8TfMX7nyy9kXmBk+J2tElosYvi0bZ6ozYO95nfsg4TKvUUma8d8/n3drvA
 pLwA=
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

Introduce max32 CPU type as it's necessary to demonstrate all
features we have in LA32.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/loongarch/cpu.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 720f5b97698abe454c79c2f8fb2a36d0113c5c24..afc6ff30b34af86c611c5866c9c79b3924c69ed7 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -404,6 +404,97 @@ static void loongarch_la132_initfn(Object *obj)
     env->cpucfg[1] = data;
 }
 
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
 #ifdef TARGET_LOONGARCH64
 static void loongarch_la464_initfn(Object *obj)
 {
@@ -923,6 +1014,7 @@ static const TypeInfo loongarch_cpu_type_infos[] = {
     },
 #endif
     DEFINE_LOONGARCH_CPU_TYPE(32, "la132", loongarch_la132_initfn),
+    DEFINE_LOONGARCH_CPU_TYPE(32, "max32", loongarch_max32_initfn),
 #ifdef TARGET_LOONGARCH64
     DEFINE_LOONGARCH_CPU_TYPE(64, "la464", loongarch_la464_initfn),
     DEFINE_LOONGARCH_CPU_TYPE(64, "max", loongarch_max_initfn),

-- 
2.43.0


