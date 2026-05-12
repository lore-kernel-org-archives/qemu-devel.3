Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6FFECD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuj8-0005M2-GR; Tue, 12 May 2026 17:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuim-0004fn-12; Tue, 12 May 2026 17:32:58 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuij-0002hv-Vm; Tue, 12 May 2026 17:32:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619500; bh=c0sUG123j8SktnUoky/z9a2M0oaRE/G9DflycOe1HTQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=g221C0abSsnKJgOShht0bTyZ+FXBONl0Y0gkmW0rrMR8wC4ZADEpIIYeiv76T87Fo
 uOIPvyeD6kqg1lby1ASdMhc9pH6FqN+E/2pFrlDRXmFSk8znQn4uNtjXVeshWSZeF8
 /wFpv+XWBO/061vF9f8tWcmX6zN2rNXDWpnj/ezj97OuGMfEvJ/G553bcC98rdIpZJ
 E/nXr5r1o4epud7owQ3rDA+5nAsLOA/rR94LFFi9w5zYxxv6evjYif6Ikc1dU3eRdl
 BtZ6q2br162I0RlOv21fsxMenTyyBVlQS/JutmKOiayJq0DOCHbAguDqQAAq0LGL2E
 lzXKtV1wGSBNA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2D07C1AA3FA;
 Tue, 12 May 2026 23:58:20 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 378603ABD52;
 Tue, 12 May 2026 23:58:24 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.1 47/58] migration: Use QAPI_CLONE_MEMBERS in
 migrate_params_test_apply
Date: Tue, 12 May 2026 23:58:08 +0300
Message-ID: <20260512205820.361821-47-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
References: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

Use QAPI_CLONE_MEMBERS instead of making an assignment. The QAPI
method makes the handling of the TLS strings more intuitive because it
clones them as well.

This also fixes a segfault when a NULL TLS option is accessed as part
of a validation check for another option (e.g. in the zero-copy +
multifd compression case). Details follow:

Currently, after copying s->parameters to the temporary
MigrationParameters object before migrate_params_check(), the
references in temporary object to the TLS options are dropped, either
because:

a) the user set a new option, in which case that's fine as
   s->parameters still holds the reference to the old memory or,

b) the user did not set a new option, in which case keeping the
   references in the temporary object would later cause them to be
   freed along with it, leading to double-free when s->parameters is
   also freed later on.

In this second case, it was overlooked that the TLS options can be
accessed already during migrate_params_check() as part of validation
of another option. Those pointers should not have been cleared.

Using QAPI_CLONE_MEMBERS fixes the issue because the temporary object
is not stealing a reference from s->parameters anymore.

Cc: qemu-stable <qemu-stable@nongnu.org>
Fixes: aed97f0563 ("migration: Normalize tls arguments")
Reported-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Link: https://lore.kernel.org/r/a65a1049-9f19-460a-8e27-a62bb30d2727@maciej.szmigiero.name
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Tested-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Link: https://lore.kernel.org/r/20260414223718.23965-1-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
(cherry picked from commit f77a7cec9f64ed94062f7b9eb661bd07d60e859a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/migration/options.c b/migration/options.c
index 7556fbc06b..68441f0276 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1279,9 +1279,9 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
 static void migrate_params_test_apply(MigrationParameters *params,
                                       MigrationParameters *dest)
 {
-    *dest = migrate_get_current()->parameters;
+    MigrationState *s = migrate_get_current();
 
-    /* TODO use QAPI_CLONE() instead of duplicating it inline */
+    QAPI_CLONE_MEMBERS(MigrationParameters, dest, &s->parameters);
 
     if (params->has_throttle_trigger_threshold) {
         dest->throttle_trigger_threshold = params->throttle_trigger_threshold;
@@ -1300,24 +1300,18 @@ static void migrate_params_test_apply(MigrationParameters *params,
     }
 
     if (params->tls_creds) {
+        qapi_free_StrOrNull(dest->tls_creds);
         dest->tls_creds = QAPI_CLONE(StrOrNull, params->tls_creds);
-    } else {
-        /* clear the reference, it's owned by s->parameters */
-        dest->tls_creds = NULL;
     }
 
     if (params->tls_hostname) {
+        qapi_free_StrOrNull(dest->tls_hostname);
         dest->tls_hostname = QAPI_CLONE(StrOrNull, params->tls_hostname);
-    } else {
-        /* clear the reference, it's owned by s->parameters */
-        dest->tls_hostname = NULL;
     }
 
     if (params->tls_authz) {
+        qapi_free_StrOrNull(dest->tls_authz);
         dest->tls_authz = QAPI_CLONE(StrOrNull, params->tls_authz);
-    } else {
-        /* clear the reference, it's owned by s->parameters */
-        dest->tls_authz = NULL;
     }
 
     if (params->has_max_bandwidth) {
@@ -1374,8 +1368,9 @@ static void migrate_params_test_apply(MigrationParameters *params,
     }
 
     if (params->has_block_bitmap_mapping) {
-        dest->has_block_bitmap_mapping = true;
-        dest->block_bitmap_mapping = params->block_bitmap_mapping;
+        qapi_free_BitmapMigrationNodeAliasList(dest->block_bitmap_mapping);
+        dest->block_bitmap_mapping = QAPI_CLONE(BitmapMigrationNodeAliasList,
+                                                params->block_bitmap_mapping);
     }
 
     if (params->has_x_vcpu_dirty_limit_period) {
@@ -1399,7 +1394,8 @@ static void migrate_params_test_apply(MigrationParameters *params,
     }
 
     if (params->has_cpr_exec_command) {
-        dest->cpr_exec_command = params->cpr_exec_command;
+        qapi_free_strList(dest->cpr_exec_command);
+        dest->cpr_exec_command = QAPI_CLONE(strList, params->cpr_exec_command);
     }
 }
 
@@ -1555,4 +1551,6 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
     }
 
     migrate_tls_opts_free(&tmp);
+    qapi_free_BitmapMigrationNodeAliasList(tmp.block_bitmap_mapping);
+    qapi_free_strList(tmp.cpr_exec_command);
 }
-- 
2.47.3


