Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F88C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 08:26:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKZaA-00008b-AO; Fri, 21 Jun 2024 04:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sKZa8-00008B-MQ
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:25:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sKZa6-0003et-W6
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718958314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=By/4Fe0QePRBexbpUYVqyIgMpSgH1ly61fGWG9VRDIs=;
 b=LkQxYleDxnIAMLHuAiP+z6RG6QcBMMjt6u549yTOwXxqWvchIkTXkqoTp4AiDYCuwIho0R
 dW2ClcDMGNPX71/qhQekHPHD9TtaNmXFSXjXiZtQ/Ro7Jo80aA/p4BFif/+hLdvUnujS5o
 sGoXKZqaWl6qRg2ToA4ado7azeKZYb8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-489-rbqr-Kh-Ow-JW01ECuMuEQ-1; Fri,
 21 Jun 2024 04:25:04 -0400
X-MC-Unique: rbqr-Kh-Ow-JW01ECuMuEQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 53F4919560BB; Fri, 21 Jun 2024 08:25:03 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.213])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CB9ED1956087; Fri, 21 Jun 2024 08:24:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jared Rossi <jrossi@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 "Collin L . Walling" <walling@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 "Jason J . Herne" <jjherne@linux.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: [PATCH 7/7] docs/system/s390x/bootdevices: Update the documentation
 about network booting
Date: Fri, 21 Jun 2024 10:24:22 +0200
Message-ID: <20240621082422.136217-8-thuth@redhat.com>
In-Reply-To: <20240621082422.136217-1-thuth@redhat.com>
References: <20240621082422.136217-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Remove the information about the separate s390-netboot.img from
the documentation.

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
2.45.2


