Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E65C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 12:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4K0t-00020z-Hg; Tue, 07 May 2024 08:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s4K0r-0001wV-EJ
 for qemu-devel@nongnu.org; Tue, 07 May 2024 08:33:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s4K0p-0002UF-FQ
 for qemu-devel@nongnu.org; Tue, 07 May 2024 08:33:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715085218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3KDgg8Tm2RoVfUEeXI9vsAszwp2V0JXK8sCDw5AO3ns=;
 b=K++0tgudzlMmYdzliA4dN2a0U+SG3ck4N8gJmedUMeruh3j5hVmOEjB9YKPx1tGRJXAMH+
 NiBgFTungcJ9d8DFTUHtcoadgobeW3dZk5nySTKL1UukkGvt4yI1UCP85l/yYLBRN1GNhi
 hrlXEGMwwypaH0Nwpdl7QD2lnTzgDY0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-5uAL17G9MKWmrTbMUAmB9Q-1; Tue, 07 May 2024 08:33:35 -0400
X-MC-Unique: 5uAL17G9MKWmrTbMUAmB9Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 122D0802E42;
 Tue,  7 May 2024 12:33:35 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 071F22022F10;
 Tue,  7 May 2024 12:33:33 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2] ppc: Deprecate 'ref405ep' machine and 405 CPUs
Date: Tue,  7 May 2024 14:33:32 +0200
Message-ID: <20240507123332.641708-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The 'ref405ep' machine and PPC 405 CPU have no known users, firmware
images are not available, OpenWRT dropped support in 2019, U-Boot in
2017, Linux also is dropping support in 2024. It is time to let go of
this ancient hardware and focus on newer CPUs and platforms.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 v2: fixed header line

 docs/about/deprecated.rst | 8 ++++++++
 hw/ppc/ppc405_boards.c    | 1 +
 2 files changed, 9 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 03f8b1b655e071432ecd9decf61e194821d06928..e22acb17f296362509a3e143ba61bafd210a6c91 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -258,6 +258,14 @@ dropping the ``cheetah`` OMAP1 board, because we don't have any
 test images for it and don't know of anybody who does; the ``sx1``
 and ``sx1-v1`` OMAP1 machines remain supported for now.
 
+PPC 405 ``ref405ep`` machine (since 9.1)
+''''''''''''''''''''''''''''''''''''''''
+
+The ``ref405ep`` machine and PPC 405 CPU have no known users, firmware
+images are not available, OpenWRT dropped support in 2019, U-Boot in
+2017, Linux also is dropping support in 2024. It is time to let go of
+this ancient hardware and focus on newer CPUs and platforms.
+
 Backend options
 ---------------
 
diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index 4092ebc1ab59de14b66ebad2be7eb019faf45db1..c44e7ed162fae5ec884ba4e458138f84430a8460 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -350,6 +350,7 @@ static void ppc405_machine_class_init(ObjectClass *oc, void *data)
     mc->init = ppc405_init;
     mc->default_ram_size = 128 * MiB;
     mc->default_ram_id = "ppc405.ram";
+    mc->deprecation_reason = "machine is old and unmaintained";
 }
 
 static const TypeInfo ppc405_machine_type = {
-- 
2.45.0


