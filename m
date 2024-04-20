Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25210C4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2024 05:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ry3cz-0005gp-Kw; Sat, 20 Apr 2024 01:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ry3cw-0005eV-0y
 for qemu-devel@nongnu.org; Sat, 20 Apr 2024 01:51:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ry3cu-0007vS-GA
 for qemu-devel@nongnu.org; Sat, 20 Apr 2024 01:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713592263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hiBBi/D8vIAXBkHtBhZYpSiL1hFS+yB7+IB8oel7o4M=;
 b=GFkh/f0nC8t5PyUT21ykQFN5+KSvKvK4X48OgQG9j13/4CTclZrJbimqE3JdtWYSs9Zl2H
 2iz5d3b2ZeZUhsXcnzYAiicN1fKqptYylKGZZjz4eqIoHWn8S8w2oFQWYf2V4dqMMb1qw7
 GLLv7/AH7xn+ds/XyGgUTE+D7eE+WEk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-quke_YltMr2tR0w6MvPWrQ-1; Sat, 20 Apr 2024 01:46:18 -0400
X-MC-Unique: quke_YltMr2tR0w6MvPWrQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0DF921044577;
 Sat, 20 Apr 2024 05:46:18 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F1DE2492BC7;
 Sat, 20 Apr 2024 05:46:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-trivial@nongnu.org
Subject: [PATCH 3/3] target/ppc/cpu_init: Remove "PowerPC" prefix from the CPU
 list
Date: Sat, 20 Apr 2024 07:46:06 +0200
Message-ID: <20240420054606.13353-4-thuth@redhat.com>
In-Reply-To: <20240420054606.13353-1-thuth@redhat.com>
References: <20240420054606.13353-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.313,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SUBJ_WIPE_DEBT=1.004 autolearn=unavailable autolearn_force=no
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

Printing a "PowerPC" in front of each CPU name is not helpful at all:
It is confusing for the users since they don't know whether they
have to specify these letters for the "-cpu" parameter, too, and
it also takes some precious space in the dense output of the CPU
entries. Let's simply remove this now and use two spaces at the
beginning of the lines for the indentation of the entries instead,
and add a "Available CPUs" in the very first line, like most other
target architectures are doing it for their CPU help output already.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/ppc/cpu_init.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 6241de62ce..8b932dccfb 100644
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
2.44.0


