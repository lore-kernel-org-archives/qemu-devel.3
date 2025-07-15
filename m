Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EA6C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 16:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubivg-0002fN-Tj; Tue, 15 Jul 2025 12:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubieg-0006do-HP
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 12:37:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubied-0003Wx-Rg
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 12:37:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752597439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4LYSA3StRAaAOjegddXO+y32/uop+q8AdhLwkM8tozI=;
 b=bZaCvelKFRPKAhxSN8MV+JbnxDrCoyVvsp99T0cdJaPnLJqt5HbkvhH/ZUEyBBiaHbc0ys
 aqI3BsJUCrnrlahxedhUH0ByZiBV0egt6lv+lVi0GoXR2a1688PyEZP3BLHKFfPY/GSbZU
 vjfSgk8OfKeqBJsY31xZtvPzat6mQW4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-s4rWgXwwP6SDirrrIgGz4Q-1; Tue,
 15 Jul 2025 12:37:16 -0400
X-MC-Unique: s4rWgXwwP6SDirrrIgGz4Q-1
X-Mimecast-MFC-AGG-ID: s4rWgXwwP6SDirrrIgGz4Q_1752597435
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F07B18001F7; Tue, 15 Jul 2025 16:37:15 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.160])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 888BF3000198; Tue, 15 Jul 2025 16:37:13 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 1/7] =?UTF-8?q?hw/vfio-user:=20add=20C=C3=A9dric=20Le=20Goa?=
 =?UTF-8?q?ter=20as=20a=20maintainer?=
Date: Tue, 15 Jul 2025 18:36:57 +0200
Message-ID: <20250715163703.243975-2-clg@redhat.com>
In-Reply-To: <20250715163703.243975-1-clg@redhat.com>
References: <20250715163703.243975-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: John Levon <john.levon@nutanix.com>

Signed-off-by: John Levon <john.levon@nutanix.com>
Acked-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20250715115954.515819-2-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e88ed2c0a974122fffce8ee636d4f48e2dacf7ba..30e9b71e6e23e93a53a0d3d175cafe8df0397561 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4287,6 +4287,7 @@ F: tests/functional/test_multiprocess.py
 VFIO-USER:
 M: John Levon <john.levon@nutanix.com>
 M: Thanos Makatos <thanos.makatos@nutanix.com>
+M: Cédric Le Goater <clg@redhat.com>
 S: Supported
 F: docs/interop/vfio-user.rst
 F: docs/system/devices/vfio-user.rst
-- 
2.50.1


