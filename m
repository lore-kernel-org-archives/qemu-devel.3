Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61743CF5386
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 13:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3bFk-0007NF-Lf; Wed, 23 Oct 2024 09:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3bFa-0007Cc-5S
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 09:18:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3bFX-0002EF-SI
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 09:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729689487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZOrPBPZ2cEU3IJjuze0yE0HxYzK5ZQRQxdoBIuqI4Wk=;
 b=Bp/soMaPjOriyAr22LDDDKqU5YO9YLJaEkntKsgoBFfEffIQDB3fdlIFtDA+aJ1O/a7VJ+
 jxOl6Wj4s82l19n3LHHNLIJYGL3fl8UxYfnONvSn0F+38SsXSvZYz2+KXgwmsdO4eaS6kS
 wYeePmh4cmwQIFiq6K/aPSiFL3pm1+0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-kf-Ce2NbMraSxvZVsGB6xw-1; Wed,
 23 Oct 2024 09:18:05 -0400
X-MC-Unique: kf-Ce2NbMraSxvZVsGB6xw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5BF711937227; Wed, 23 Oct 2024 13:18:00 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.43])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7B09C1954B10; Wed, 23 Oct 2024 13:17:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jared Rossi <jrossi@linux.ibm.com>
Subject: [PULL 18/23] docs/system: Update documentation for s390x IPL
Date: Wed, 23 Oct 2024 15:17:05 +0200
Message-ID: <20241023131710.906748-19-thuth@redhat.com>
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

Update docs to show that s390x PC BIOS can support more than one boot device.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20241020012953.1380075-19-jrossi@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/system/bootindex.rst         | 7 ++++---
 docs/system/s390x/bootdevices.rst | 9 ++++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/docs/system/bootindex.rst b/docs/system/bootindex.rst
index 8b057f812f..988f7b3beb 100644
--- a/docs/system/bootindex.rst
+++ b/docs/system/bootindex.rst
@@ -49,10 +49,11 @@ Limitations
 -----------
 
 Some firmware has limitations on which devices can be considered for
-booting.  For instance, the PC BIOS boot specification allows only one
-disk to be bootable.  If boot from disk fails for some reason, the BIOS
+booting.  For instance, the x86 PC BIOS boot specification allows only one
+disk to be bootable.  If boot from disk fails for some reason, the x86 BIOS
 won't retry booting from other disk.  It can still try to boot from
-floppy or net, though.
+floppy or net, though. In the case of s390x BIOS, the BIOS will try up to
+8 total devices, any number of which may be disks.
 
 Sometimes, firmware cannot map the device path QEMU wants firmware to
 boot from to a boot method.  It doesn't happen for devices the firmware
diff --git a/docs/system/s390x/bootdevices.rst b/docs/system/s390x/bootdevices.rst
index c97efb8fc0..1a1a764c1c 100644
--- a/docs/system/s390x/bootdevices.rst
+++ b/docs/system/s390x/bootdevices.rst
@@ -6,9 +6,7 @@ Booting with bootindex parameter
 
 For classical mainframe guests (i.e. LPAR or z/VM installations), you always
 have to explicitly specify the disk where you want to boot from (or "IPL" from,
-in s390x-speak -- IPL means "Initial Program Load"). In particular, there can
-also be only one boot device according to the architecture specification, thus
-specifying multiple boot devices is not possible (yet).
+in s390x-speak -- IPL means "Initial Program Load").
 
 So for booting an s390x guest in QEMU, you should always mark the
 device where you want to boot from with the ``bootindex`` property, for
@@ -17,6 +15,11 @@ example::
  qemu-system-s390x -drive if=none,id=dr1,file=guest.qcow2 \
                    -device virtio-blk,drive=dr1,bootindex=1
 
+Multiple devices may have a bootindex. The lowest bootindex is assigned to the
+device to IPL first.  If the IPL fails for the first, the device with the second
+lowest bootindex will be tried and so on until IPL is successful or there are no
+remaining boot devices to try.
+
 For booting from a CD-ROM ISO image (which needs to include El-Torito boot
 information in order to be bootable), it is recommended to specify a ``scsi-cd``
 device, for example like this::
-- 
2.47.0


