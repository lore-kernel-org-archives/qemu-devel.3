Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA39CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 09:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGvMX-0003GK-VW; Wed, 14 Oct 2026 05:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvMV-0003BM-IU
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:33:27 -0400
Received: from mail-dl1-x122b.google.com ([2607:f8b0:4864:20::122b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvMQ-0000RU-AA
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:33:25 -0400
Received: by mail-dl1-x122b.google.com with SMTP id
 a92af1059eb24-15ea896ddc8so1077400c88.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 02:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791970396; x=1792575196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FN3gIzsYRNrNvWZkeZdG5EI9zoCxoH3d85aktlF3UZU=;
 b=LGW2H6wCLJluVnQ83p2mOuz363WXE19aAjcB/XAVrGSr6hiW5YwEh+74dTvE37IqwM
 4Ww9Z6+wyeEs3u/kvRqgt/vn5FTrMRWza8+/ghhugFqbzi3+izg9B6Y6b6iV/cmBFWQw
 hTFoMTVJvXKrtNGZ4NamgH3Kem2ovwBUqD5TVGh/yS5y7uNuilb0shF4e29ZKyhF7n3V
 /LUeNOkNGN5QcaRI8Fq+MoLWQaR3poHlDbFGOe4OQyAO52d6CJnyUld05vD2ADBQjEUX
 3sCwyVPm0IDOHsZPKakSEAlTCckjiGhYvex5pnAu9LgAypYuEgPJvr8myf7Ctlsi2dNW
 dThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791970396; x=1792575196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FN3gIzsYRNrNvWZkeZdG5EI9zoCxoH3d85aktlF3UZU=;
 b=kyItq9yNdaIVsPZwnJ2n8t0ItdmkFN0b+srcqZ9aWY0S99NxVbG16rJ+OkJVvSnC8y
 e2kPdm0f68QeX11SRrteOTUkN7mRbaNZLB1aGCcbhCs+2+nCLNe3M82sR9ElFpXj4VGR
 wRLUV8C/PVRPQa/zHpzJrv6uXk1BwNc+pfn2cn4+oUnXTJReK95j3QCevnZeud5yUMxX
 LeARBJjESlgTDXFIppikg6XYwax4SAOFDzFMnAdIPgZBm/LSfFz4c72/axWQREJdjfyb
 JbrWNeRGytzK7QReV/v0UB4HNhgFNaTXOic9CEmh5bBV5W9cGWasG1OPkDAPLyHjMAeh
 tylQ==
X-Gm-Message-State: AFq9FYKA3iRRgy6kznSmeNYPAJsuqG+iEKEa5UeKnfCVzx1RQUdCUAjN
 1gcZmJ/QWD/DICag1C35N0NjJwpoRoNuWO5jibvJ6kHvS9iZQSDJD1CuYsPhw15vBVY=
X-Gm-Gg: AYBFou30AUEk80qtZ0V2Qt0vXkq+6hH4s32VZc9kFcaV4jgLB1ij2Xef3HmO7erfrA9
 LMagLtJ9hpmoONNlAI0GjG4p5qIyJKf1avR0+Lr63G4DOjdxa46UlUqCRo8TchVTGcR9Jgxk3js
 WZ5O9v8zZ8wJ8SYp1u8nKt3Sp7+Tzgqlrz4oPttXjxp2DQqP2jM5V+vWYYvZRrvbYQEMILLotWy
 qhh7qJqsesYiv1sBMSVcITh/zv82EF7as1qmrwYIbAivIl/eiAzZQCTGpocUhEs2P2LBtIC3Qrx
 HBfNu6BkyRYlm3QfAxbBVxVI902Le/2ZcoXxhPCJjN+A75E7b5ZUTQECbTDRw4aGnNgMATrnvin
 1MThFUcvsgsafF3LogJkbsLEF6acv2qJchPRFWHmFGJh1mjlLexwWRH97DTrWJqDIXTuR2IQlla
 z75LMPfTEXCSxFy+NtzlTth+gyu8uRtNXGl4G3AZTVmnKNVExG9U1FSHptxdWkMWyocTQxb//qF
 myTB2q/pqf+RAuDWw==
X-Received: by 2002:a05:701b:230c:b0:13b:3132:6e99 with SMTP id
 a92af1059eb24-16a5f7c7c58mr20811375c88.20.1791970396320; 
 Wed, 14 Oct 2026 02:33:16 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1698de65af7sm48769303c88.0.2026.10.14.02.33.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 02:33:14 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-s390x@nongnu.org, Song Gao <17746591750@163.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Farman <farman@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Weiwei Li <liwei1518@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@kernel.org>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fam Zheng <fam@euphon.net>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-arm@nongnu.org,
 Chao Liu <chao.liu@processmission.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 07/34] target-info: prepare the QOM target list before
 module_call_init(MODULE_INIT_QOM)
Date: Wed, 14 Oct 2026 17:31:17 +0800
Message-ID: <20261014093152.834-8-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261014093152.834-1-luoyonggang@gmail.com>
References: <20261014093152.834-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122b;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x122b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We can not retrieve target list when do call to module_call_init(MODULE_INIT_QOM)
But in future, we need iterate target list inside type_init referenced functions for
generate all QOM variants depends on target list(without select the target).
So we have to prepare the QOM target list before module_call_init(MODULE_INIT_QOM)

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/target-info-qom.h |  4 ++++
 system/vl.c                    |  2 +-
 target-info-qom.c              | 26 +++++++++++++++++++++++++-
 tests/qtest/fuzz/fuzz.c        |  2 +-
 tests/unit/test-multi-target.c | 20 +++++++++++++-------
 5 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-info-qom.h
index ba2e4370afb..031d9ce32a5 100644
--- a/include/qemu/target-info-qom.h
+++ b/include/qemu/target-info-qom.h
@@ -25,6 +25,10 @@ typedef struct TargetInfoQomClass {
 
 OBJECT_DECLARE_TYPE(TargetInfoQom, TargetInfoQomClass, TARGET_INFO)
 
+/* Initialize before MODULE_INIT_QOM; cache is owned by this module. */
+void target_info_qom_init(void);
+GSList *target_info_qom_get_targets(void);
+
 void target_info_qom_set_target(void);
 void target_info_qom_set_target_info(const TargetInfo *ti);
 
diff --git a/system/vl.c b/system/vl.c
index fbe580746d3..a7684abdd3a 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2914,7 +2914,7 @@ void qemu_init(int argc, char **argv)
 
     os_setup_limits();
 
-    module_call_init(MODULE_INIT_TARGET_INFO);
+    target_info_qom_init();
     target_info_qom_set_target();
 
     module_init_info(qemu_modinfo);
diff --git a/target-info-qom.c b/target-info-qom.c
index aeeedb7e818..8d3f2b7280b 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "qom/object.h"
 #include "qemu/target-info-def.h"
 #include "qemu/target-info-init.h"
@@ -34,6 +35,29 @@ static const TypeInfo target_info_parent_type = {
 DEFINE_TARGET_INFO_TYPE(target_info_parent_type)
 
 static const TargetInfo *target_info_ptr;
+static GSList *target_info_classes;
+static bool target_info_initialized;
+
+void target_info_qom_init(void)
+{
+    if (target_info_initialized) {
+        return;
+    }
+
+    module_call_init(MODULE_INIT_TARGET_INFO);
+    /*
+     * Avoid enumerating target-info classes during QOM registration,
+     * which can leave unrelated types incomplete.
+     */
+    target_info_classes = object_class_get_list(TYPE_TARGET_INFO, false);
+    target_info_initialized = true;
+}
+
+GSList *target_info_qom_get_targets(void)
+{
+    assert(target_info_initialized);
+    return target_info_classes;
+}
 
 const TargetInfo *target_info(void)
 {
@@ -42,7 +66,7 @@ const TargetInfo *target_info(void)
 
 void target_info_qom_set_target(void)
 {
-    g_autoptr(GSList) targets = object_class_get_list(TYPE_TARGET_INFO, false);
+    GSList *targets = target_info_qom_get_targets();
 
     size_t num_found = g_slist_length(targets);
     if (num_found != 1) {
diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
index a3a131c80f8..570fc0b45b2 100644
--- a/tests/qtest/fuzz/fuzz.c
+++ b/tests/qtest/fuzz/fuzz.c
@@ -173,7 +173,7 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
 
     /* Initialize qgraph and modules */
     qos_graph_init();
-    module_call_init(MODULE_INIT_TARGET_INFO);
+    target_info_qom_init();
     target_info_qom_set_target();
     module_call_init(MODULE_INIT_FUZZ_TARGET);
     module_call_init(MODULE_INIT_QOM);
diff --git a/tests/unit/test-multi-target.c b/tests/unit/test-multi-target.c
index 89b55bb1632..a91fe8e6d07 100644
--- a/tests/unit/test-multi-target.c
+++ b/tests/unit/test-multi-target.c
@@ -30,23 +30,29 @@
 /* stub for system/main.c */
 int (*qemu_main)(void);
 
+static GSList *targets;
+
 static void test_qom_types_are_unique(void)
 {
-    module_call_init(MODULE_INIT_TARGET_INFO);
-    g_autoptr(GSList) targets = object_class_get_list(TYPE_TARGET_INFO, false);
     g_assert(targets);
-    const TargetInfo *first_ti = TARGET_INFO_CLASS(targets->data)->target_info;
-    target_info_qom_set_target_info(first_ti);
-
-    /* register all types */
-    module_call_init(MODULE_INIT_QOM);
     /* trigger type_initialize for all types */
     object_class_get_list("", false);
+
+    g_assert_true(targets == target_info_qom_get_targets());
 }
 
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
+    target_info_qom_init();
+    targets = target_info_qom_get_targets();
+
+    const TargetInfo *first_ti = TARGET_INFO_CLASS(targets->data)->target_info;
+    target_info_qom_set_target_info(first_ti);
+
+    /* register all types */
+    module_call_init(MODULE_INIT_QOM);
+
     g_test_add_func("/multi-targets/qom-types-are-unique",
                    test_qom_types_are_unique);
     return g_test_run();
-- 
2.55.0.windows.3


