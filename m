Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E197C0218F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 08:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfEJ1-0005vr-0L; Tue, 04 Feb 2025 03:29:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tfEIy-0005vO-Vu
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 03:29:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tfEIu-0004CM-4G
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 03:29:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738657746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NxFbljAnD8ACeP4UU2WucMsgbHtZdQv4FwkJvefvq18=;
 b=YHOGvJK8gunAWIhr6Q41jc4EFkWE+KYEAIMZ6x7OKeKzszuNy+JnEfKmprWnPuLfmgXv5z
 snfu+8eMeAPN5evRuk0yEaWMQcjp930f6i7toZNb0+lwe6fp1rMtM+VPZSWSO/fbTDAL/G
 qdCa4I7/SeB/Vi0i36PJb1IDvPf+IiU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-fvnS70J1OoymIcoSBskAAQ-1; Tue,
 04 Feb 2025 03:29:05 -0500
X-MC-Unique: fvnS70J1OoymIcoSBskAAQ-1
X-Mimecast-MFC-AGG-ID: fvnS70J1OoymIcoSBskAAQ
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D022B1955DDE; Tue,  4 Feb 2025 08:29:03 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.15])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 721A21800365; Tue,  4 Feb 2025 08:29:01 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH] MAINTAINER: Add a maintainer for CPR
Date: Tue,  4 Feb 2025 09:28:59 +0100
Message-ID: <20250204082859.846886-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The CPR feature was added in QEMU 9.0 and it lacks a maintainer.
Propose the main contributor to become one.

Cc: Steve Sistare <steven.sistare@oracle.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index db8c41fbe0f9..efb9da02f142 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2943,6 +2943,15 @@ F: include/qemu/co-shared-resource.h
 T: git https://gitlab.com/jsnow/qemu.git jobs
 T: git https://gitlab.com/vsementsov/qemu.git block
 
+CheckPoint and Restart (CPR)
+M: Steve Sistare <steven.sistare@oracle.com>
+S: Supported
+F: hw/vfio/cpr*
+F: include/migration/cpr.h
+F: migration/cpr*
+F: tests/qtest/migration/cpr*
+F: docs/devel/migration/CPR.rst
+
 Compute Express Link
 M: Jonathan Cameron <jonathan.cameron@huawei.com>
 R: Fan Ni <fan.ni@samsung.com>
-- 
2.48.1


