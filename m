Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE21DCF9C6F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 13:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st5Y5-0001dH-DH; Tue, 24 Sep 2024 09:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1st5Y0-0001DW-S3
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 09:25:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1st5Xx-0003BV-L1
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 09:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727184340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tDlvfDagIaXSDsYK/qgzWsHRmHlwzg3b5GL7oMhZQso=;
 b=R2nAV3+9iJlkyiZ4R4W+De/GGigNsDg+t8SIDP2l6Y2KVAueXLl5BoeDUZUjHd/SBw/VIG
 bJ0VunLONbEKfgkv2cR+BA+Zba29fxpf3KJHf+7mC0AD8owgCjnHLvIsuXNlZw2kIqAS+i
 T9Fdx6qoxPXwncgLITfKj6scUrHNzDU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-xoyxbJwcOHCTdTQzMj7_Qw-1; Tue,
 24 Sep 2024 09:25:36 -0400
X-MC-Unique: xoyxbJwcOHCTdTQzMj7_Qw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 88FD118EF6FE; Tue, 24 Sep 2024 13:25:35 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.123])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 06CD4190AB1C; Tue, 24 Sep 2024 13:24:52 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org,
	integration@gluster.org
Subject: [PATCH] docs: Mark "gluster" support in QEMU as deprecated
Date: Tue, 24 Sep 2024 15:24:51 +0200
Message-ID: <20240924132451.47121-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.09,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/about/deprecated.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index ed31d4b0b2..b231aa3948 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -395,6 +395,15 @@ Specifying the iSCSI password in plain text on the command line using the
 used instead, to refer to a ``--object secret...`` instance that provides
 a password via a file, or encrypted.
 
+``gluster`` backend (since 9.2)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+According to https://marc.info/?l=fedora-devel-list&m=171934833215726
+the GlusterFS development effectively ended. Unless the development
+gains momentum again, the QEMU project might remove the gluster backend
+in a future release.
+
+
 Character device options
 ''''''''''''''''''''''''
 
-- 
2.46.0


