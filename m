Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1F5C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 09:37:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi7fR-0006ls-OD; Fri, 10 Jul 2026 05:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wi7fN-0006lV-HZ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 05:37:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wi7fK-0000WX-Ny
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 05:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783676221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=T9x7WM7jseks0Do+4pzu63OUGjVuB25UfCB3SrCuZ8U=;
 b=Mbzn0s/386U9Pfg3YAO5Bnv7OweDZFaPamdc7DKoeOXgDAPwmd49xghQSQbuFn624d7lnZ
 NPMvB3hcD7H/UFujYgRJjqVqA93W+cGQdy/RytZOvm5aVcgqmdBpsiOE38R9OM0Qh18xaM
 sg/iULzo1XWFxoTZU2jCrxhlQsJlPB0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-TEBE3EJoOeCSgzC_GDKCBg-1; Fri,
 10 Jul 2026 05:37:00 -0400
X-MC-Unique: TEBE3EJoOeCSgzC_GDKCBg-1
X-Mimecast-MFC-AGG-ID: TEBE3EJoOeCSgzC_GDKCBg_1783676219
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D32D61956043; Fri, 10 Jul 2026 09:36:58 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.49.56])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C2F3C1800594; Fri, 10 Jul 2026 09:36:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>,
	qemu-block@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] block: Print simple help text when calling "-blockdev help"
Date: Fri, 10 Jul 2026 11:36:54 +0200
Message-ID: <20260710093654.466642-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

Other command line options like "-chardev", "-netdev" or "-device"
already present the user with a list of available parameters, but
when running "-blockdev help", there is currently only an error
message. There is already the possibility to run "-drive format=help",
but it does not seem to be documented, so this is not very useful
for the average user. Let's improve this situation by providing
the same list of available drivers when running QEMU with
"-blockdev help".

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/block/block-common.h |  1 +
 blockdev.c                   | 15 ++++++++++-----
 system/vl.c                  |  7 +++++--
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/include/block/block-common.h b/include/block/block-common.h
index 895ea175413..010c4425dcf 100644
--- a/include/block/block-common.h
+++ b/include/block/block-common.h
@@ -583,5 +583,6 @@ char *path_combine(const char *base_path, const char *filename);
 char *bdrv_get_full_backing_filename_from_filename(const char *backed,
                                                    const char *backing,
                                                    Error **errp);
+void blockdev_show_help(void);
 
 #endif /* BLOCK_COMMON_H */
diff --git a/blockdev.c b/blockdev.c
index 6e86c6262f9..3d179939205 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -475,6 +475,15 @@ static OnOffAuto account_get_opt(QemuOpts *opts, const char *name)
     return ON_OFF_AUTO_OFF;
 }
 
+void blockdev_show_help(void)
+{
+      qemu_printf("Supported formats:");
+      bdrv_iterate_format(bdrv_format_print, NULL, false);
+      qemu_printf("\nSupported formats (read-only):");
+      bdrv_iterate_format(bdrv_format_print, NULL, true);
+      qemu_printf("\n");
+}
+
 /* Takes the ownership of bs_opts */
 static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
                                    Error **errp)
@@ -541,11 +550,7 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
 
     if ((buf = qemu_opt_get(opts, "format")) != NULL) {
         if (is_help_option(buf)) {
-            qemu_printf("Supported formats:");
-            bdrv_iterate_format(bdrv_format_print, NULL, false);
-            qemu_printf("\nSupported formats (read-only):");
-            bdrv_iterate_format(bdrv_format_print, NULL, true);
-            qemu_printf("\n");
+            blockdev_show_help();
             goto early_err;
         }
 
diff --git a/system/vl.c b/system/vl.c
index 061cbdf860b..40c0593154a 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2961,7 +2961,10 @@ void qemu_init(int argc, char **argv)
                           HD_OPTS);
                 break;
             case QEMU_OPTION_blockdev:
-                {
+                if (is_help_option(optarg)) {
+                    blockdev_show_help();
+                    exit(EXIT_SUCCESS);
+                } else {
                     Visitor *v;
                     BlockdevOptionsQueueEntry *bdo;
 
@@ -2974,8 +2977,8 @@ void qemu_init(int argc, char **argv)
                     visit_free(v);
                     loc_save(&bdo->loc);
                     QSIMPLEQ_INSERT_TAIL(&bdo_queue, bdo, entry);
-                    break;
                 }
+                break;
             case QEMU_OPTION_drive:
                 if (!qemu_opts_parse_noisily(qemu_find_opts("drive"),
                                              optarg, false)) {
-- 
2.55.0


