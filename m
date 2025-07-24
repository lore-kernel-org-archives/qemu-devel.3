Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6611BC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 08:00:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueqrW-0005Y6-Nx; Thu, 24 Jul 2025 03:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ueqrT-0005VA-Jt
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 03:59:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ueqrR-0003QO-7K
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 03:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753343966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Jc3eUv0S51nFNAhCRzJDuBRpCH7xfRqG4XcHfhoHRSQ=;
 b=g6BkCCQzv1z9jAm299FjvEcubBD4PHpLaGWwzTczoCWnELpwGhpkJ2NKJ3Zqt1eSXh/sBF
 2jlSPz9rpt9/a75hR9Nm6P+eQLbkPcE81z3GXtGPNhV+dQqHzFNa2n24ygMrFAFuAvJp9V
 jRt756xnOsJmxwMVvUCdPMplm0+pcZM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-jSQ01bviNImQNJi5hTTBrQ-1; Thu,
 24 Jul 2025 03:59:24 -0400
X-MC-Unique: jSQ01bviNImQNJi5hTTBrQ-1
X-Mimecast-MFC-AGG-ID: jSQ01bviNImQNJi5hTTBrQ_1753343963
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8805118002A0; Thu, 24 Jul 2025 07:59:23 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B27B6180035E; Thu, 24 Jul 2025 07:59:20 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH] =?UTF-8?q?MAINTAINERS:=20Remove=20Fr=C3=A9d=C3=A9ric=20as?=
 =?UTF-8?q?=20reviewer?=
Date: Thu, 24 Jul 2025 09:59:16 +0200
Message-ID: <20250724075916.1593420-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.377,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Frédéric has moved to other tasks within IBM and no longer does QEMU
development.

Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f3f981f90deb..9481a21c8018 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1578,7 +1578,6 @@ F: tests/functional/test_ppc64_tuxrun.py
 
 PowerNV (Non-Virtualized)
 M: Nicholas Piggin <npiggin@gmail.com>
-R: Frédéric Barrat <fbarrat@linux.ibm.com>
 R: Aditya Gupta <adityag@linux.ibm.com>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
@@ -2780,7 +2779,6 @@ F: tests/qtest/fw_cfg-test.c
 T: git https://github.com/philmd/qemu.git fw_cfg-next
 
 XIVE
-R: Frédéric Barrat <fbarrat@linux.ibm.com>
 R: Gautam Menghani <gautam@linux.ibm.com>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
-- 
2.50.1


