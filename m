Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6EACCD18D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 15:38:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8KbK-0003K0-81; Mon, 13 Oct 2025 11:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1v8KbI-0003Jn-Jz
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 11:36:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1v8KbE-0006Hp-W0
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 11:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760369788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=G5z/+K1680xwDSI45Zwv/YiCoBVFhfH+8iRu3YIHNWM=;
 b=c/BU5mUbz1E3ak5aC/SMGoBwQ+hvWUDwLAhQQIGA0qn/mdqwa4g2JAhrIgCyu2Hh99ZAza
 vDQWZbaEDUPIBjY45bqdRlmPLrfSrKCmfW5HqNX7f4ouV45AbcNXoS0yFB2UnFvh06QibE
 zK0sOHVvT5xwdBEAqN437TAwvFOJPj4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-_eGuntTyPgOHDwEhzzBYWA-1; Mon,
 13 Oct 2025 11:36:25 -0400
X-MC-Unique: _eGuntTyPgOHDwEhzzBYWA-1
X-Mimecast-MFC-AGG-ID: _eGuntTyPgOHDwEhzzBYWA_1760369784
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EAA421800578; Mon, 13 Oct 2025 15:36:23 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.89.76])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C56D93000384; Mon, 13 Oct 2025 15:36:22 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: clg@redhat.com
Cc: Alex Williamson <alex.williamson@redhat.com>, alex@shazbot.org,
 qemu-devel@nongnu.org, tomitamoeko@gmail.com
Subject: [PATCH] MAINTAINERS: Update Alex Williamson's email address
Date: Mon, 13 Oct 2025 09:35:35 -0600
Message-ID: <20251013153543.3091169-1-alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Switch to a personal email account as I'll be leaving Red Hat soon.

Signed-off-by: Alex Williamson <alex@shazbot.org>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 .mailmap    | 1 +
 MAINTAINERS | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index e7271852dc6a..f556ae968239 100644
--- a/.mailmap
+++ b/.mailmap
@@ -74,6 +74,7 @@ Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <aleksandar.markovic@imgte
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <amarkovic@wavecomp.com>
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com> <arikalo@wavecomp.com>
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com> <aleksandar.rikalo@rt-rk.com>
+Alex Williamson <alex@shazbot.org> <alex.williamson@redhat.com>
 Alexander Graf <agraf@csgraf.de> <agraf@suse.de>
 Ani Sinha <anisinha@redhat.com> <ani@anisinha.ca>
 Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori <aliguori@us.ibm.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 84cfd85e1fa1..1f1cd4856802 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2286,7 +2286,7 @@ S: Maintained
 F: hw/usb/dev-serial.c
 
 VFIO
-M: Alex Williamson <alex.williamson@redhat.com>
+M: Alex Williamson <alex@shazbot.org>
 M: Cédric Le Goater <clg@redhat.com>
 S: Supported
 F: hw/vfio/*
@@ -2298,7 +2298,7 @@ F: migration/vfio-stub.c
 F: tests/functional/aarch64/test_device_passthrough.py
 
 vfio-igd
-M: Alex Williamson <alex.williamson@redhat.com>
+M: Alex Williamson <alex@shazbot.org>
 M: Cédric Le Goater <clg@redhat.com>
 M: Tomita Moeko <tomitamoeko@gmail.com>
 S: Supported
-- 
2.51.0


