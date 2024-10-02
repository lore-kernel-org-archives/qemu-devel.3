Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA52CF319C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 08:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svubK-0006VO-Uv; Wed, 02 Oct 2024 04:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svubH-0006V6-25
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 04:20:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svubD-0003tK-28
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 04:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727857241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=uzq0xaHCbayvywe0geNc+y3rk+GhSgdQeXCpbQLaOzA=;
 b=ZP4KR+JzrCn83gtQA0Dd4bHwpf7K5TrTHIHOrSq6AvKDJFAmbvfEy5a3t7APDYx2frDkE3
 NTqGWxGcUjRz2E46FRIjJHlrr30EtgTyvtUxTdSPOSE6ZDliKMrWUcZjJqfDNlQO0Qc9Ut
 7uO3XJSkRCxojlhHDM9ipxef96LK6CE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-HL8iMLV1NyeXvuofyzD90w-1; Wed,
 02 Oct 2024 04:20:40 -0400
X-MC-Unique: HL8iMLV1NyeXvuofyzD90w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28880195609F; Wed,  2 Oct 2024 08:20:39 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.239])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 43DF119560A3; Wed,  2 Oct 2024 08:20:34 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Cc: devel@lists.libvirt.org, integration@gluster.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3] docs: Mark "gluster" support in QEMU as deprecated
Date: Wed,  2 Oct 2024 10:20:33 +0200
Message-ID: <20241002082033.129022-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v3: Some rewordings according to Markus' and Daniel's suggestions

 docs/about/deprecated.rst | 9 +++++++++
 qapi/block-core.json      | 8 +++++++-
 block/gluster.c           | 2 ++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index c0aa52def5..c41e55f710 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -414,6 +414,15 @@ Specifying the iSCSI password in plain text on the command line using the
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
index c3b0a2376b..8181abef54 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3192,12 +3192,18 @@
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


