Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F5EE7718E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 21:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQvHP-0003uK-VH; Thu, 26 Dec 2024 16:20:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvHL-0003qF-4L
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:20:23 -0500
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvHJ-0003DI-8f
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:20:22 -0500
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id B6BBD13801EF;
 Thu, 26 Dec 2024 16:20:20 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Thu, 26 Dec 2024 16:20:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735248020;
 x=1735334420; bh=/R+UYBT9JTRjyVyhZ6ww+fL1pd+McXtjlSxujDrHCn0=; b=
 mtES/GS9TPT9OYkHQxmKb72BiwaMCXCeAD0howm4+FCBeUWDpilrPn05ynOru5XD
 e52PacEH3EMt8wY1nPqnBI4zck+lXumBcB+WqxnONYTrqn9v4Cx3gGYCZeovuRo4
 RH6LWZjn+++F4it3uDSaLoZrBisy98NiuRDNIFqIlc/2jSlrQzRYuwo5izCSd8vm
 zT1DIamPlcQQ2ceSa7dehq7MRRVzqHC1IB5Yi+RAVBDqonRqQ9xkLvLT+jpaHheC
 f4pyiEtw8OQCLv0TShO8F9JnPhtcMmsCrF0XRHG+yJ3WEY0C9L/YYPe3IjcFTtTp
 0Ccj8wU5Gp+PSDQfWiU6LQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735248020; x=
 1735334420; bh=/R+UYBT9JTRjyVyhZ6ww+fL1pd+McXtjlSxujDrHCn0=; b=C
 KqYf0ADtSaTrepRqqGA17XAddVMh1vx4P49pHcl/OVjyNWSGPNhQVTDihCzT8to9
 jW2WQES5fkxWK1pj32bEOwS3sI65Zn/mGKO3u2XrryJb9gaLaRqxjyUlR4oSXiUs
 tVUqE3frPTL6nVHKoTglzU/sMF4+ngCglpXV0JFERkINs5mgJupnD3H3zb7C129e
 QvRn/RZYeu5NqjgwJfHsOdH+OSsSCqc0SQ85ilOocF0vYIs+kcQvCCDaIj8NBs5N
 y071LtcDwKpAPF2khUalb7khMPX+yXSnlsK6g3NLHC7brDziIjKaAy/kqo/00GMR
 tB0IFdR8joKH0cCdKwOFw==
X-ME-Sender: <xms:lMhtZ5aTD1k7I4qAGV3U50n3t-3RyWjTKAcGcmXM7mByMgxKHF-Kgg>
 <xme:lMhtZwa3eFRAH3DzcTdKoywGy056syIBOvTq_AL4UgnNnJx3flr3cPoai9tsdjvAe
 5ycVBLzT9rvCPVx4yY>
X-ME-Received: <xmr:lMhtZ7-pvVAroCc3YBC41bsFQed9UYc97fv623BBVTyuXT3V9mpamFPN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddukedgudegjecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:lMhtZ3pMOir2MU5kOetelFebaNQWT9fkK4SXNR68OwNYk7wj6ifMUg>
 <xmx:lMhtZ0rwQ-QmNo2D5GMkf9E46OYdG8gyABslEJOVXTYoAwIGnqyLyA>
 <xmx:lMhtZ9Rn7mtbCv9dqN95B1zjaDhXbFDDRrdaabonVYYMZ6QtJ9HYRw>
 <xmx:lMhtZ8o-2CfiqYMfiFrNZ2ysTLT1rnK8ekYJMG2LREagDPD51CqaoQ>
 <xmx:lMhtZ6iFmaiNYQ0vcKcqJPSXsOI4-GLnp57fJq19XOYzN_yVDUktsJQQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 16:20:18 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 26 Dec 2024 21:19:49 +0000
Subject: [PATCH v2 18/23] target/loongarch: ifdef out 64 bit CPUs on 32 bit
 builds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241226-la32-fixes1-v2-18-0414594f8cb5@flygoat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4395;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=r6c46xv1jpn2ABIYObG2TFnqZDRs36DnvEiW/1NNqFk=;
 b=kA0DAAoWQ3EMfdd3KcMByyZiAGdtyGui2w9Zo8WjPniWum+OYSzouy1DaLd69A/+fKAbLdFfH
 oh1BAAWCgAdFiEEVBAijrCB0aDX4Gr8Q3EMfdd3KcMFAmdtyGsACgkQQ3EMfdd3KcORzgD/Z4SP
 kvqFGu8V2EJvbx0uhO5o86psuGUezcy0GihF6qQA/Ag5JabV85dYbJItmmFXuCT5upFmSjNztia
 DpN+gjccH
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

They are not available on 32 bit builds.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/loongarch/cpu.c | 68 ++++++++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 30 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 82412f8867a50a6cd25cff511def0f24d2b10b49..720f5b97698abe454c79c2f8fb2a36d0113c5c24 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -375,6 +375,36 @@ static int loongarch_cpu_mmu_index(CPUState *cs, bool ifetch)
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
+#ifdef TARGET_LOONGARCH64
 static void loongarch_la464_initfn(Object *obj)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(obj);
@@ -473,40 +503,12 @@ static void loongarch_la464_initfn(Object *obj)
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
     loongarch_la464_initfn(obj);
 }
+#endif
 
 static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
 {
@@ -870,6 +872,7 @@ static void loongarch32_cpu_class_init(ObjectClass *c, void *data)
     cc->gdb_arch_name = loongarch32_gdb_arch_name;
 }
 
+#ifdef TARGET_LOONGARCH64
 static const gchar *loongarch64_gdb_arch_name(CPUState *cs)
 {
     return "loongarch64";
@@ -882,6 +885,7 @@ static void loongarch64_cpu_class_init(ObjectClass *c, void *data)
     cc->gdb_core_xml_file = "loongarch-base64.xml";
     cc->gdb_arch_name = loongarch64_gdb_arch_name;
 }
+#endif
 
 #define DEFINE_LOONGARCH_CPU_TYPE(size, model, initfn) \
     { \
@@ -909,6 +913,7 @@ static const TypeInfo loongarch_cpu_type_infos[] = {
         .abstract = true,
         .class_init = loongarch32_cpu_class_init,
     },
+#ifdef TARGET_LOONGARCH64
     {
         .name = TYPE_LOONGARCH64_CPU,
         .parent = TYPE_LOONGARCH_CPU,
@@ -916,9 +921,12 @@ static const TypeInfo loongarch_cpu_type_infos[] = {
         .abstract = true,
         .class_init = loongarch64_cpu_class_init,
     },
-    DEFINE_LOONGARCH_CPU_TYPE(64, "la464", loongarch_la464_initfn),
+#endif
     DEFINE_LOONGARCH_CPU_TYPE(32, "la132", loongarch_la132_initfn),
+#ifdef TARGET_LOONGARCH64
+    DEFINE_LOONGARCH_CPU_TYPE(64, "la464", loongarch_la464_initfn),
     DEFINE_LOONGARCH_CPU_TYPE(64, "max", loongarch_max_initfn),
+#endif
 };
 
 DEFINE_TYPES(loongarch_cpu_type_infos)

-- 
2.43.0


