Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C78CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 12:20:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBXoQ-00015F-2p; Wed, 22 Oct 2025 08:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vBXoN-00014N-OR
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:19:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vBXoL-000742-Ol
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761135564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QWm9Ac1hZbOd1SmioRNmWIpwDBbhUPJYXdQRIX2CAds=;
 b=KwV2/CII6MeuEWPVl/Uf978PoNvGxUf6h6SPhn2mC/S3hdu9VTVlV9DHZaE3UOKgYYbhrw
 zmeyyBS2rARfcMBYUy/NBYdFQNYi7o81lc/N4cIqmsD36UIKnAy+bD3fxERGDfd2JTzQge
 UTY/z+bmXEE1r3EmPEAvH+GVkUhRaR0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-D94rtUsPOgilocRVeBATQQ-1; Wed,
 22 Oct 2025 08:19:17 -0400
X-MC-Unique: D94rtUsPOgilocRVeBATQQ-1
X-Mimecast-MFC-AGG-ID: D94rtUsPOgilocRVeBATQQ_1761135556
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 783CC195608E; Wed, 22 Oct 2025 12:19:16 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.12])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 30672180044F; Wed, 22 Oct 2025 12:19:13 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 10/12] MAINTAINERS: Update Alex Williamson's email address
Date: Wed, 22 Oct 2025 14:18:44 +0200
Message-ID: <20251022121846.874152-11-clg@redhat.com>
In-Reply-To: <20251022121846.874152-1-clg@redhat.com>
References: <20251022121846.874152-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

From: Alex Williamson <alex.williamson@redhat.com>

Switch to a personal email account as I'll be leaving Red Hat soon.

Signed-off-by: Alex Williamson <alex@shazbot.org>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251013153543.3091169-1-alex.williamson@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 MAINTAINERS | 4 ++--
 .mailmap    | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 667acd933c7fef6d44796ed97e7f0c0bdf8e96fc..7a0809d82a365dc812b94ce363a7f0bb0d57cafa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2285,7 +2285,7 @@ S: Maintained
 F: hw/usb/dev-serial.c
 
 VFIO
-M: Alex Williamson <alex.williamson@redhat.com>
+M: Alex Williamson <alex@shazbot.org>
 M: Cédric Le Goater <clg@redhat.com>
 S: Supported
 F: hw/vfio/*
@@ -2297,7 +2297,7 @@ F: migration/vfio-stub.c
 F: tests/functional/aarch64/test_device_passthrough.py
 
 vfio-igd
-M: Alex Williamson <alex.williamson@redhat.com>
+M: Alex Williamson <alex@shazbot.org>
 M: Cédric Le Goater <clg@redhat.com>
 M: Tomita Moeko <tomitamoeko@gmail.com>
 S: Supported
diff --git a/.mailmap b/.mailmap
index 15bec72470ead7cd953a15ef3a475ff93ae7b365..7f817d9f425c032be7988961faeb159ae6955b04 100644
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
-- 
2.51.0


