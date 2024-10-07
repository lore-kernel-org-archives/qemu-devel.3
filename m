Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379CACFB43F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 11:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxmGH-0006ke-6x; Mon, 07 Oct 2024 07:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sxmG8-0006jT-Ak
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:50:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sxmG6-00056q-KR
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728301838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dP6uGr+fy58ZGPXR38kWez6WFlz7rDCeh/E4BG4jKUQ=;
 b=iz5EYsu5SoeHOjnBL2OqFNMdou/Qmx4ILkTep8ex0tdJujzvjpXggOQpOAwUZwVIUqhosj
 y7cg6HhY2JHmdumVUfQQ3m7gBnbOr1ckwK4T+taRHlGCPXgs/bK2O2GseWLv8998vj7XUD
 o2FAOFPSmIMeQn3j3FBrvNRfqPvA0pM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-vL9GJXmVMQOors-vZdY4fg-1; Mon,
 07 Oct 2024 07:50:35 -0400
X-MC-Unique: vL9GJXmVMQOors-vZdY4fg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F22CF1955EA8; Mon,  7 Oct 2024 11:50:33 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.46])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3D7AF19560AE; Mon,  7 Oct 2024 11:50:31 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Niels de Vos <ndevos@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 01/12] docs: Mark "gluster" support in QEMU as deprecated
Date: Mon,  7 Oct 2024 13:50:16 +0200
Message-ID: <20241007115027.243425-2-thuth@redhat.com>
In-Reply-To: <20241007115027.243425-1-thuth@redhat.com>
References: <20241007115027.243425-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

According to https://marc.info/?l=fedora-devel-list&m=171934833215726
the GlusterFS development effectively ended. Thus mark it as deprecated
in QEMU, so we can remove it in a future release if the project does
not gain momentum again.

Acked-by: Niels de Vos <ndevos@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20241002082033.129022-1-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/about/deprecated.rst | 9 +++++++++
 qapi/block-core.json      | 8 +++++++-
 block/gluster.c           | 2 ++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 48b230b0a0..c02bbb66f7 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -377,6 +377,15 @@ Specifying the iSCSI password in plain text on the command line using the
 used instead, to refer to a ``--object secret...`` instance that provides
 a password via a file, or encrypted.
 
+``gluster`` backend (since 9.2)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+According to https://marc.info/?l=fedora-devel-list&m=171934833215726
+the GlusterFS development effectively ended. Unless the development
+gains momentum again, the QEMU project will remove the gluster backend
+in a future release.
+
+
 Character device options
 ''''''''''''''''''''''''
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 5c2b3ac0d4..2feae8e697 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3190,12 +3190,18 @@
 #
 # @snapshot-access: Since 7.0
 #
+# Features:
+#
+# @deprecated: Member @gluster is deprecated because GlusterFS
+#     development ceased.
+#
 # Since: 2.9
 ##
 { 'enum': 'BlockdevDriver',
   'data': [ 'blkdebug', 'blklogwrites', 'blkreplay', 'blkverify', 'bochs',
             'cloop', 'compress', 'copy-before-write', 'copy-on-read', 'dmg',
-            'file', 'snapshot-access', 'ftp', 'ftps', 'gluster',
+            'file', 'snapshot-access', 'ftp', 'ftps',
+            {'name': 'gluster', 'features': [ 'deprecated' ] },
             {'name': 'host_cdrom', 'if': 'HAVE_HOST_BLOCK_DEVICE' },
             {'name': 'host_device', 'if': 'HAVE_HOST_BLOCK_DEVICE' },
             'http', 'https',
diff --git a/block/gluster.c b/block/gluster.c
index f8b415f381..f03d05251e 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -809,6 +809,8 @@ static int qemu_gluster_open(BlockDriverState *bs,  QDict *options,
         goto out;
     }
 
+    warn_report_once("'gluster' is deprecated");
+
     filename = qemu_opt_get(opts, GLUSTER_OPT_FILENAME);
 
     s->debug = qemu_opt_get_number(opts, GLUSTER_OPT_DEBUG,
-- 
2.46.1


