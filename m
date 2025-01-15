Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A68FC02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 10:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY0Ki-0001qZ-QI; Wed, 15 Jan 2025 05:09:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tY0Kf-0001qF-L0
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 05:09:05 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tY0Kd-0001QK-4y
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 05:09:05 -0500
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-uNy4ZmYaOoWhL1yEtOHTAQ-1; Wed,
 15 Jan 2025 05:08:55 -0500
X-MC-Unique: uNy4ZmYaOoWhL1yEtOHTAQ-1
X-Mimecast-MFC-AGG-ID: uNy4ZmYaOoWhL1yEtOHTAQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 91626195608B; Wed, 15 Jan 2025 10:08:53 +0000 (UTC)
Received: from bahia.redhat.com (unknown [10.39.192.142])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A899B19560AA; Wed, 15 Jan 2025 10:08:51 +0000 (UTC)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>
Subject: [PATCH] MAINTAINERS: Mark me as reviewer only for 9pfs
Date: Wed, 15 Jan 2025 11:08:49 +0100
Message-ID: <20250115100849.259612-1-groug@kaod.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: softfail client-ip=207.211.30.44; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-44.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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

I still review 9pfs changes from time to time but I'm definitely
not able to do actual maintainer work. Drop my tree on the way
as I'll obviously not use it anymore, and it has been left
untouched since May 2020.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8b9d9a7cacbb..adc93ac0f4b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2248,8 +2248,8 @@ F: include/system/balloon.h
 F: tests/qtest/virtio-balloon-test.c
 
 virtio-9p
-M: Greg Kurz <groug@kaod.org>
 M: Christian Schoenebeck <qemu_oss@crudebyte.com>
+R: Greg Kurz <groug@kaod.org>
 S: Maintained
 W: https://wiki.qemu.org/Documentation/9p
 F: hw/9pfs/
@@ -2257,7 +2257,6 @@ X: hw/9pfs/xen-9p*
 F: fsdev/
 F: tests/qtest/virtio-9p-test.c
 F: tests/qtest/libqos/virtio-9p*
-T: git https://gitlab.com/gkurz/qemu.git 9p-next
 T: git https://github.com/cschoenebeck/qemu.git 9p.next
 
 virtio-blk
-- 
2.47.1


