Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF98C88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x62YT-0005tt-Db; Mon, 14 Sep 2026 05:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x62YR-0005tW-0j
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:00:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x62YO-0003DC-Qo
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789376444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=C/U5kWaSWBu/lz4gb7OE4mlsf2F1rBZISq9HNZUjyLU=;
 b=fRcxLpROZHuBxtX3B7Xg/Fl1SOyhjO2CT1upHt3EZ+/JIsotiLVBhsoDk4Wl23GEYxxrFc
 gs2FWaCZfBmeA8tygSWGGCg6LkkO0we0oTXaSKXOY1JQebiOj9upm20MiqW2B04jcHHon4
 gNBL1RH3+MBIrgqnGhEc1JkvQUMoCMU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-an-6r4r1MGW9x_1iGpZLsQ-1; Mon,
 14 Sep 2026 05:00:41 -0400
X-MC-Unique: an-6r4r1MGW9x_1iGpZLsQ-1
X-Mimecast-MFC-AGG-ID: an-6r4r1MGW9x_1iGpZLsQ_1789376440
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA7FD1805A11; Mon, 14 Sep 2026 09:00:39 +0000 (UTC)
Received: from thuth-p1g4.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A5CB4195604D; Mon, 14 Sep 2026 09:00:37 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>,
	qemu-block@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2] block: Print simple help text when calling "-blockdev help"
Date: Mon, 14 Sep 2026 11:00:36 +0200
Message-ID: <20260914090036.125300-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

Other command line options like "-chardev", "-netdev" or "-device"
already present the user with a list of available parameters, but
when running "-blockdev help", there is currently only an error
message. There is already the possibility to run "-drive format=help",
but it does not seem to be documented, so this is not very useful
for the average user. Thus let's improve this situation by providing
a proper list of available drivers when running QEMU with
"-blockdev help".

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Don't re-use the code from "-drive format=help" and print the
     help in a better readable way instead

 include/block/block-common.h |  1 +
 block.c                      | 15 +++++++++++++++
 system/vl.c                  |  7 +++++--
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/block/block-common.h b/include/block/block-common.h
index 895ea175413..c76a72c1220 100644
--- a/include/block/block-common.h
+++ b/include/block/block-common.h
@@ -583,5 +583,6 @@ char *path_combine(const char *base_path, const char *filename);
 char *bdrv_get_full_backing_filename_from_filename(const char *backed,
                                                    const char *backing,
                                                    Error **errp);
+void bdrv_show_help(void);
 
 #endif /* BLOCK_COMMON_H */
diff --git a/block.c b/block.c
index f0a6042e616..895d6db5acf 100644
--- a/block.c
+++ b/block.c
@@ -524,6 +524,21 @@ bool bdrv_uses_whitelist(void)
     return use_bdrv_whitelist;
 }
 
+static void bdrv_help_format_print(void *opaque, const char *name)
+{
+    if (bdrv_format_is_whitelisted(name, false)) {
+        printf("%s\n", name);
+    } else {
+        printf("%s (read-only)\n", name);
+    }
+}
+
+void bdrv_show_help(void)
+{
+      printf("Available blockdev drivers:\n");
+      bdrv_iterate_format(bdrv_help_format_print, NULL, true);
+}
+
 typedef struct CreateCo {
     BlockDriver *drv;
     char *filename;
diff --git a/system/vl.c b/system/vl.c
index 9bd7664b85c..dc93e8737cb 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2960,7 +2960,10 @@ void qemu_init(int argc, char **argv)
                           HD_OPTS);
                 break;
             case QEMU_OPTION_blockdev:
-                {
+                if (is_help_option(optarg)) {
+                    bdrv_show_help();
+                    exit(EXIT_SUCCESS);
+                } else {
                     Visitor *v;
                     BlockdevOptionsQueueEntry *bdo;
 
@@ -2973,8 +2976,8 @@ void qemu_init(int argc, char **argv)
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


