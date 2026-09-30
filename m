Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4383CA5FBA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBriw-0001Wb-3e; Wed, 30 Sep 2026 06:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrif-0001HU-Ba
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBric-0006iL-D9
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6PwFAn0LDje9EpHfOpLdLVeudAHWd4E0rTntGuGP/hw=;
 b=DLekU7M42RVzDCgpDKIH07BhIvsunmaN5VkQ6xkuRj4gDutP06lilunG+cib6vFUn0Mvwn
 ybUpX0mdzgA2EbT6O/tVXtZ/ca0ZZnsFRyayGOJIZTbEFuI/ju1pGGeLga03bIzabcOm8E
 QD9wXb+sTGI2ndVy81gD1luIETKxWWQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-Xfu0ezbQM8-pJgO5LkEiyg-1; Wed,
 30 Sep 2026 06:39:20 -0400
X-MC-Unique: Xfu0ezbQM8-pJgO5LkEiyg-1
X-Mimecast-MFC-AGG-ID: Xfu0ezbQM8-pJgO5LkEiyg_1790764759
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C1701955DD2; Wed, 30 Sep 2026 10:39:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E7138768; Wed, 30 Sep 2026 10:39:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F1BB721E689D; Wed, 30 Sep 2026 12:39:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 025/105] qapi: convert trivial intro sections for pci.json
Date: Wed, 30 Sep 2026 12:37:50 +0200
Message-ID: <20260930103910.3934848-26-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260831201945.287730-26-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/pci.json | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/qapi/pci.json b/qapi/pci.json
index 694c741e42..a6a79f91af 100644
--- a/qapi/pci.json
+++ b/qapi/pci.json
@@ -13,8 +13,7 @@
 
 ##
 # @PciMemoryRange:
-#
-# A PCI device memory region
+#     A PCI device memory region
 #
 # @base: the starting address (guest physical)
 #
@@ -26,8 +25,7 @@
 
 ##
 # @PciMemoryRegion:
-#
-# Information about a PCI device I/O region.
+#     Information about a PCI device I/O region.
 #
 # @bar: the index of the Base Address Register for this region
 #
@@ -51,8 +49,7 @@
 
 ##
 # @PciBusInfo:
-#
-# Information about a bus of a PCI Bridge device
+#     Information about a bus of a PCI Bridge device
 #
 # @number: primary bus interface number.  This should be the number of
 #     the bus the device resides on.
@@ -80,8 +77,7 @@
 
 ##
 # @PciBridgeInfo:
-#
-# Information about a PCI Bridge device
+#     Information about a PCI Bridge device
 #
 # @bus: information about the bus the device resides on
 #
@@ -94,8 +90,7 @@
 
 ##
 # @PciDeviceClass:
-#
-# Information about the Class of a PCI device
+#     Information about the Class of a PCI device
 #
 # @desc: a string description of the device's class (not stable, and
 #     should only be treated as informational)
@@ -109,8 +104,7 @@
 
 ##
 # @PciDeviceId:
-#
-# Information about the Id of a PCI device
+#     Information about the Id of a PCI device
 #
 # @device: the PCI device id
 #
@@ -128,8 +122,7 @@
 
 ##
 # @PciDeviceInfo:
-#
-# Information about a PCI device
+#     Information about a PCI device
 #
 # @bus: the bus number of the device
 #
@@ -161,8 +154,7 @@
 
 ##
 # @PciInfo:
-#
-# Information about a PCI bus
+#     Information about a PCI bus
 #
 # @bus: the bus index
 #
@@ -174,8 +166,7 @@
 
 ##
 # @query-pci:
-#
-# Return information about the PCI bus topology of the guest.
+#     Return information about the PCI bus topology of the guest.
 #
 # Returns: a list of info for each PCI bus.  Each bus is
 #     represented by a json-object, which has a key with a json-array
-- 
2.55.0


