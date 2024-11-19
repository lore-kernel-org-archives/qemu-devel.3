Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282BBD6C29E
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 21:26:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDVio-0005u6-10; Tue, 19 Nov 2024 16:25:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tDVij-0005r8-CX
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 16:25:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tDVih-0006U9-6e
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 16:25:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732051509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nWJgXK22QFfPAT9nvth4vKwj1JgJzCmTeODQYnqWMhQ=;
 b=PcqiOC4Q8hnySi4SscPEGxnl9QqfW3ILeffzg8lCElsD+sgpSbdBn+ZCQv+g2FnAB6aCWq
 b1wT//2bXcqsKKLJzYrgHzOb85Q24TJf9pf0DuXyAKhbVSkXWYu7FK+9pccxY5cEvfRccG
 hNbLqyIOqDlIPex1Z3hWCULI9l+OGCo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-SbuWeLSjOLGY3O7e9Oe_Rg-1; Tue,
 19 Nov 2024 16:25:05 -0500
X-MC-Unique: SbuWeLSjOLGY3O7e9Oe_Rg-1
X-Mimecast-MFC-AGG-ID: SbuWeLSjOLGY3O7e9Oe_Rg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D78319541BE; Tue, 19 Nov 2024 21:25:03 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.59])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 23F3B19560A3; Tue, 19 Nov 2024 21:25:00 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jan Luebbe <jlu@pengutronix.de>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: [PULL 1/1] docs: aspeed: Reorganize the "Boot options" section
Date: Tue, 19 Nov 2024 22:24:56 +0100
Message-ID: <20241119212456.873660-2-clg@redhat.com>
In-Reply-To: <20241119212456.873660-1-clg@redhat.com>
References: <20241119212456.873660-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add subsubsections for possible boot methods and introduce a new
section on eMMC boot support for the ast2600-evb and rainier-emmc
machines, boot partitions assumptions and limitations.

Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Jan Luebbe <jlu@pengutronix.de>
Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/system/arm/aspeed.rst | 99 +++++++++++++++++++++++++++++++++-----
 1 file changed, 86 insertions(+), 13 deletions(-)

diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
index 63910d382feb..2e9ba12f7ae8 100644
--- a/docs/system/arm/aspeed.rst
+++ b/docs/system/arm/aspeed.rst
@@ -105,6 +105,9 @@ or directly from the ASPEED Forked OpenBMC GitHub release repository :
 
    https://github.com/AspeedTech-BMC/openbmc/releases
 
+Booting from a kernel image
+^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
 To boot a kernel directly from a Linux build tree:
 
 .. code-block:: bash
@@ -114,16 +117,10 @@ To boot a kernel directly from a Linux build tree:
         -dtb arch/arm/boot/dts/aspeed-ast2600-evb.dtb \
         -initrd rootfs.cpio
 
-To boot the machine from the flash image, use an MTD drive :
-
-.. code-block:: bash
-
-  $ qemu-system-arm -M romulus-bmc -nic user \
-	-drive file=obmc-phosphor-image-romulus.static.mtd,format=raw,if=mtd -nographic
+Booting from a flash image
+^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-Options specific to Aspeed machines are :
-
- * ``boot-emmc`` to set or unset boot from eMMC (AST2600).
+The machine options specific to Aspeed to boot from a flash image are :
 
  * ``execute-in-place`` which emulates the boot from the CE0 flash
    device by using the FMC controller to load the instructions, and
@@ -134,10 +131,12 @@ Options specific to Aspeed machines are :
 
  * ``spi-model`` to change the default SPI Flash model.
 
- * ``bmc-console`` to change the default console device. Most of the
-   machines use the ``UART5`` device for a boot console, which is
-   mapped on ``/dev/ttyS4`` under Linux, but it is not always the
-   case.
+To boot the machine from the flash image, use an MTD drive :
+
+.. code-block:: bash
+
+  $ qemu-system-arm -M romulus-bmc -nic user \
+	-drive file=obmc-phosphor-image-romulus.static.mtd,format=raw,if=mtd -nographic
 
 To use other flash models, for instance a different FMC chip and a
 bigger (64M) SPI for the ``ast2500-evb`` machine, run :
@@ -169,6 +168,78 @@ In that case, the machine boots fetching instructions from the FMC0
 device. It is slower to start but closer to what HW does. Using the
 machine option ``execute-in-place`` has a similar effect.
 
+Booting from an eMMC image
+^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The machine options specific to Aspeed machines to boot from an eMMC
+image are :
+
+ * ``boot-emmc`` to set or unset boot from eMMC (AST2600).
+
+Only the ``ast2600-evb`` and ``rainier-emmc`` machines have support to
+boot from an eMMC device. In this case, the machine assumes that the
+eMMC image includes special boot partitions. Such an image can be
+built this way :
+
+.. code-block:: bash
+
+   $ dd if=/dev/zero of=mmc-bootarea.img count=2 bs=1M
+   $ dd if=u-boot-spl.bin of=mmc-bootarea.img conv=notrunc
+   $ dd if=u-boot.bin of=mmc-bootarea.img conv=notrunc count=64 bs=1K
+   $ cat mmc-bootarea.img obmc-phosphor-image.wic > mmc.img
+   $ truncate --size 16GB mmc.img
+
+Boot the machine ``rainier-emmc`` with :
+
+.. code-block:: bash
+
+   $ qemu-system-arm -M rainier-bmc \
+         -drive file=mmc.img,format=raw,if=sd,index=2 \
+         -nographic
+
+The ``boot-emmc`` option can be set or unset, to change the default
+boot mode of machine: SPI or eMMC. This can be useful to boot the
+``ast2600-evb`` machine from an eMMC device (default being SPI) or to
+boot the ``rainier-bmc`` machine from a flash device (default being
+eMMC).
+
+As an example, here is how to to boot the ``rainier-bmc`` machine from
+the flash device with ``boot-emmc=false`` and let the machine use an
+eMMC image :
+
+.. code-block:: bash
+
+   $ qemu-system-arm -M rainier-bmc,boot-emmc=false \
+        -drive file=flash.img,format=raw,if=mtd \
+        -drive file=mmc.img,format=raw,if=sd,index=2 \
+        -nographic
+
+It should be noted that in this case the eMMC device must not have
+boot partitions, otherwise the contents will not be accessible to the
+machine.  This limitation is due to the use of the ``-drive``
+interface.
+
+Ideally, one should be able to define the eMMC device and the
+associated backend directly on the command line, such as :
+
+.. code-block:: bash
+
+   -blockdev node-name=emmc0,driver=file,filename=mmc.img \
+   -device emmc,bus=sdhci-bus.2,drive=emmc0,boot-partition-size=1048576,boot-config=8
+
+This is not yet supported (as of QEMU-10.0). Work is needed to
+refactor the sdhci bus model.
+
+Other booting options
+^^^^^^^^^^^^^^^^^^^^^
+
+Other machine options specific to Aspeed machines are :
+
+ * ``bmc-console`` to change the default console device. Most of the
+   machines use the ``UART5`` device for a boot console, which is
+   mapped on ``/dev/ttyS4`` under Linux, but it is not always the
+   case.
+
 To change the boot console and use device ``UART3`` (``/dev/ttyS2``
 under Linux), use :
 
@@ -176,6 +247,8 @@ under Linux), use :
 
   -M ast2500-evb,bmc-console=uart3
 
+Booting the ast2700-evb machine
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 Boot the AST2700 machine from the flash image, use an MTD drive :
 
-- 
2.47.0


