Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A375C19F53
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 06:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1KmC-0001x1-IW; Mon, 29 Apr 2024 02:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1s1Klp-0001qY-ID; Mon, 29 Apr 2024 02:45:52 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1s1Klm-0006X0-Kb; Mon, 29 Apr 2024 02:45:49 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 041F362CB2;
 Mon, 29 Apr 2024 09:45:40 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 0F4C4C33F5;
 Mon, 29 Apr 2024 09:45:37 +0300 (MSK)
Received: (nullmailer pid 238435 invoked by uid 1000);
 Mon, 29 Apr 2024 06:45:36 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 3/9] target/ppc/cpu_init: Remove "PowerPC" prefix from the CPU
 list
Date: Mon, 29 Apr 2024 09:45:30 +0300
Message-Id: <20240429064536.238392-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240429064536.238392-1-mjt@tls.msk.ru>
References: <20240429064536.238392-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SUBJ_WIPE_DEBT=1.004 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

Printing a "PowerPC" in front of each CPU name is not helpful at all:
It is confusing for the users since they don't know whether they
have to specify these letters for the "-cpu" parameter, too, and
it also takes some precious space in the dense output of the CPU
entries. Let's simply remove this now and use two spaces at the
beginning of the lines for the indentation of the entries instead,
and add a "Available CPUs" in the very first line, like most other
target architectures are doing it for their CPU help output already.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 target/ppc/cpu_init.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 6d82f24c87..c11a69fd90 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7063,7 +7063,7 @@ static void ppc_cpu_list_entry(gpointer data, gpointer user_data)
     }
 
     name = cpu_model_from_type(typename);
-    qemu_printf("PowerPC %-16s PVR %08x\n", name, pcc->pvr);
+    qemu_printf("  %-16s PVR %08x\n", name, pcc->pvr);
     for (i = 0; ppc_cpu_aliases[i].alias != NULL; i++) {
         PowerPCCPUAlias *alias = &ppc_cpu_aliases[i];
         ObjectClass *alias_oc = ppc_cpu_class_by_name(alias->model);
@@ -7076,10 +7076,10 @@ static void ppc_cpu_list_entry(gpointer data, gpointer user_data)
          * avoid printing the wrong alias here and use "preferred" instead
          */
         if (strcmp(alias->alias, family->desc) == 0) {
-            qemu_printf("PowerPC %-16s (alias for preferred %s CPU)\n",
+            qemu_printf("  %-16s (alias for preferred %s CPU)\n",
                         alias->alias, family->desc);
         } else {
-            qemu_printf("PowerPC %-16s (alias for %s)\n",
+            qemu_printf("  %-16s (alias for %s)\n",
                         alias->alias, name);
         }
     }
@@ -7090,6 +7090,7 @@ void ppc_cpu_list(void)
 {
     GSList *list;
 
+    qemu_printf("Available CPUs:\n");
     list = object_class_get_list(TYPE_POWERPC_CPU, false);
     list = g_slist_sort(list, ppc_cpu_list_compare);
     g_slist_foreach(list, ppc_cpu_list_entry, NULL);
@@ -7097,7 +7098,7 @@ void ppc_cpu_list(void)
 
 #ifdef CONFIG_KVM
     qemu_printf("\n");
-    qemu_printf("PowerPC %s\n", "host");
+    qemu_printf("  %s\n", "host");
 #endif
 }
 
-- 
2.39.2


