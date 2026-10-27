Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB16606A322
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 05:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iRnicRK9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLZvR-0002VS-En; Tue, 27 Oct 2026 01:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLZvQ-0002VJ-4b
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 01:40:44 -0400
Received: from mail-dy1-x132e.google.com ([2607:f8b0:4864:20::132e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLZvO-0004Pv-5h
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 01:40:43 -0400
Received: by mail-dy1-x132e.google.com with SMTP id
 5a478bee46e88-36a18fc7a38so67009eec.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 22:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793079640; x=1793684440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a6SQL3xSNM0OLLQDcvQFD+UMKkLm4j6wag0wTOZg/+A=;
 b=iRnicRK9BiXuacX+NRhaxIIo6GhqP7VLRGYKCdB/BX8kT8aNbSBNCxJjtZrUX+8EKr
 mFE2i7wIOkpIqorrtp+B1wb14tpQ4ZUf7X3YRYGJMOcOkj/Wtz/9ojKiaPXDGsov4tQt
 nGbZ+soNFiaOE/RNiL7OULGgpSoYQxQdx5/pCVFWUO55zMhrvDquu8fk3ouwLXquh3G7
 bjMJiX2YTA5tQhXGCNXeonBYH0sWc0FBUUpUDn3b4DRiIvde/nYMhx19/XsOeW5XF/3f
 cWto2AdlXnYwacZJO9QSw9gTvVj5LNzrjQ8MtNO1TXvEiriZRMhvuxRxgVWwHll5L/u/
 An+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793079640; x=1793684440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=a6SQL3xSNM0OLLQDcvQFD+UMKkLm4j6wag0wTOZg/+A=;
 b=p5rxZbCQB47FGfn5SMwQzKE5rGFXbT7Sj0BhhvTVMTndan/UnqrgS/STUBhZyugcfH
 926ntQxyxtReI+FEYRfzcJZy1IRRI9L9Z4xjN2hVEDHBJNlmVlzCtl2K58sUqAsbeCR8
 936WN9ahEfTG7E8N3l633oAjEGj3rs4A5I49DV3wr81opfxFkBdPUdcX1BeDfzedkL6z
 6MN6TxipqjwdeIx+W4WcZyON6WfRofv+zWwotzyjx3H4rdyPcTMkrqVhPXSb/QpgOZwt
 SKFBQ0P6T4iteRjmzxIWb8VVSxi7kyloCCgoIfSVHcYYC4elil5m2pb/Fg8i9w7Srnxi
 7i+A==
X-Gm-Message-State: AFq9FYJH0yr/6mYyjENDfPY1Tu8EXXE7IBMz0JO16/CGb4ufgbgTEd5K
 vr9cPCfBrCfrHwuiQbh/Zm2n+dqGSB4b3NkJBLwATF3ZbCAjxq4HuS+ORSFhW2rr
X-Gm-Gg: AYBFou2WKRgpd26aQPNPiN+kMT6Os4LbunUSIY5hyxBrXJ4fjSuyMNZhN+dAi+NK2Ms
 JlJy8VjrHzFQUzygf1h9g1X99Go16ZFk3KJY1soV6qGEG4cmDO9emaAGqUpVgJqIo51AlrT3Hdt
 sLBhQUGVfjgv/b1bSmaqVNELVDQ1F2qaAzYvQ8IgN3onbnHlcoTEC/pkjSuamOe1vc8YmaQD008
 esungmtaPUB83gC6zsO4+ZUFsOIkmRvXInKZKIRiqiYHidqiAzZFF72i4hYD3jPAVLt/AFluUvn
 0Ji4XljhX6EMX0QnzRLYI7aDE9jyjyUyiAWd70wekV9XY7GO7m0BrerZn5tJblzGvVpy7wR8HXg
 UrcYsWUnUelnV2j2Wnqjq1v10ycR2+m0LKo8ZKW0EKVZZPJcNW+MK+DmWJhGga/9wpBRWLVfD2u
 psgKXToizB/57/UwPrXsETS9mkHuSA6h+l7USMsjC6cZs71C1WiHrQNNClPzW52Ct2l730yGk7f
 oaRoB8Sl5Q4xaonMqhE/ulgNy40/WscF1d4O3UFVGXAU2RaPn8vibOauGupKHQr/HYYBwfHtgs=
X-Received: by 2002:a05:693c:88ce:10b0:36a:e77:aa5b with SMTP id
 5a478bee46e88-36a0e77abcdmr2710724eec.4.1793079640450; 
 Mon, 26 Oct 2026 22:40:40 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-369e8ec9276sm51416372eec.25.2026.10.26.22.40.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 22:40:39 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Alexander Bulekov <alxndr@bu.edu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 1/2] target-info: cache the QOM target list before
 MODULE_INIT_QOM
Date: Tue, 27 Oct 2026 13:40:25 +0800
Message-ID: <20261027054026.2184-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261027054026.2184-1-luoyonggang@gmail.com>
References: <20261027054026.2184-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132e;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x132e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We can not retrieve target list when do call to MODULE_INIT_QOM
In latter commit, we need iterate target list inside type_init referenced functions for
generate all QOM variants depends on target list(without select the target).
So we have to prepare the QOM target list before MODULE_INIT_QOM

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
index 468a9fc247a..47d5f09d2d7 100644
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


