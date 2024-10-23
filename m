Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB6CCF5389
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 13:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3bFF-0006BJ-9l; Wed, 23 Oct 2024 09:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3bF1-00066n-6V
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 09:17:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3bEz-00029l-JO
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 09:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729689452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BKKZvQoxBTf2nP8eOaLQhf6dLkYbpE4nVdKlvjdImHU=;
 b=cDr8tB0WHyEsF3c0uYy+6OnVmo/8FYO8pSw+FtD0Cek/lN9NMbMsVr3jyAjGTKg0AzbzoM
 vFkn8BIVVlOZnebiYgfrohYecrMHHPqb/KPMCS4St/dgzoeJ7eXmINg/0zPCO8f9pW6t4N
 ul/tVuOgzRXLT+Mvsv6Hx2kdL8MK2mw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-_o9ZNhijOBSVUPxFb--b5A-1; Wed,
 23 Oct 2024 09:17:31 -0400
X-MC-Unique: _o9ZNhijOBSVUPxFb--b5A-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E5FFF1955F35; Wed, 23 Oct 2024 13:17:29 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.43])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E4CFF19560AE; Wed, 23 Oct 2024 13:17:27 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jared Rossi <jrossi@linux.ibm.com>
Subject: [PULL 06/23] docs/system/s390x/bootdevices: Update the documentation
 about network booting
Date: Wed, 23 Oct 2024 15:16:53 +0200
Message-ID: <20241023131710.906748-7-thuth@redhat.com>
In-Reply-To: <20241023131710.906748-1-thuth@redhat.com>
References: <20241023131710.906748-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

From: Jared Rossi <jrossi@linux.ibm.com>

Remove the information about the separate s390-netboot.img from
the documentation.

Co-authored by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
Message-ID: <20241020012953.1380075-7-jrossi@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/system/s390x/bootdevices.rst | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/docs/system/s390x/bootdevices.rst b/docs/system/s390x/bootdevices.rst
index 1a7a18b43b..c97efb8fc0 100644
--- a/docs/system/s390x/bootdevices.rst
+++ b/docs/system/s390x/bootdevices.rst
@@ -82,23 +82,17 @@ Note that ``0`` can be used to boot the default entry.
 Booting from a network device
 -----------------------------
 
-Beside the normal guest firmware (which is loaded from the file ``s390-ccw.img``
-in the data directory of QEMU, or via the ``-bios`` option), QEMU ships with
-a small TFTP network bootloader firmware for virtio-net-ccw devices, too. This
-firmware is loaded from a file called ``s390-netboot.img`` in the QEMU data
-directory. In case you want to load it from a different filename instead,
-you can specify it via the ``-global s390-ipl.netboot_fw=filename``
-command line option.
-
-The ``bootindex`` property is especially important for booting via the network.
-If you don't specify the ``bootindex`` property here, the network bootloader
-firmware code won't get loaded into the guest memory so that the network boot
-will fail. For a successful network boot, try something like this::
+The firmware that ships with QEMU includes a small TFTP network bootloader
+for virtio-net-ccw devices.  The ``bootindex`` property is especially
+important for booting via the network. If you don't specify the ``bootindex``
+property here, the network bootloader won't be taken into consideration and
+the network boot will fail. For a successful network boot, try something
+like this::
 
  qemu-system-s390x -netdev user,id=n1,tftp=...,bootfile=... \
                    -device virtio-net-ccw,netdev=n1,bootindex=1
 
-The network bootloader firmware also has basic support for pxelinux.cfg-style
+The network bootloader also has basic support for pxelinux.cfg-style
 configuration files. See the `PXELINUX Configuration page
 <https://wiki.syslinux.org/wiki/index.php?title=PXELINUX#Configuration>`__
 for details how to set up the configuration file on your TFTP server.
-- 
2.47.0


