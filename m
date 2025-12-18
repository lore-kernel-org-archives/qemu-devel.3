Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C742D6ACFF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 19:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWJyS-0002UQ-1u; Thu, 18 Dec 2025 14:47:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vWJyA-0002Se-4s
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 14:47:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vWJy8-0002Vq-OP
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 14:47:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766087243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=thRoCDw8tsPFN6mug6gm/kIMTrz8GedmH4Td0aHidx0=;
 b=YKvgdovb1ZaiEu27l8DnMT1zJ8lAHaf+v5bFSvWEW62VJ8HBemxkZ9RbeqXg9sPiKElSiH
 DiTYl+Hds0Q8ACAeJdvU9aAspY0Hckr9rWZg1rQt4tbWmlD7p7aqV4yZqminbq4h03uGxF
 0c2O8DSdEvv528T/yLEix8dMS6pinWQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-oaCqzkUcNrWfs_5qrUQVdQ-1; Thu,
 18 Dec 2025 14:47:18 -0500
X-MC-Unique: oaCqzkUcNrWfs_5qrUQVdQ-1
X-Mimecast-MFC-AGG-ID: oaCqzkUcNrWfs_5qrUQVdQ_1766087238
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B90F51800675; Thu, 18 Dec 2025 19:47:17 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.147])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0CE47194C65A; Thu, 18 Dec 2025 19:47:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org
Subject: [PATCH] MAINTAINERS: Add configs/targets/s390x-softmmu.mak to the
 S390 general section
Date: Thu, 18 Dec 2025 20:47:14 +0100
Message-ID: <20251218194714.174897-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Make sure that configs/targets/s390x-softmmu.mak is covered by
MAINTAINERS - the "S390 general architecture support" section seems
to be a good place for this.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 226bf64f68e..a991f1f97b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -105,6 +105,7 @@ S390 general architecture support
 M: Thomas Huth <thuth@redhat.com>
 S: Supported
 F: configs/devices/s390x-softmmu/default.mak
+F: configs/targets/s390x-softmmu.mak
 F: gdb-xml/s390*.xml
 F: hw/char/sclp*.[hc]
 F: hw/char/terminal3270.c
-- 
2.52.0


