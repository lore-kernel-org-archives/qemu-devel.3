Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B06DC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 10:50:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2Dj-0003d0-V8; Wed, 17 Jul 2024 06:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sU2Di-0003Y2-MS
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:49:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sU2Dh-0001TM-7w
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721213352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I2wkE4iBb9LU1J3loPam8t3jeI3x5zXH3JdSNg06Kic=;
 b=gfF7QkVUJ3Y/6EQLRfnQ+Nx24OFi0qIQIXOvu7Q2tSoPxh/pF2Xcs5uRGfnCqnPVEwfQFd
 IjET7wCdii/cmkkqp9qjjBoZSmBI6isR8hTf1OJMxYkj0C/NRIYr4HiiSnsMCdn8e4zxZV
 OVgwUOeTOTVL1XGHHKpE+CgZSlJl0zU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-NOZamyxMPK2_sPUKOTJJkQ-1; Wed,
 17 Jul 2024 06:49:11 -0400
X-MC-Unique: NOZamyxMPK2_sPUKOTJJkQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 675AE19560BA; Wed, 17 Jul 2024 10:49:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 041B919560B2; Wed, 17 Jul 2024 10:49:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C074221E6693; Wed, 17 Jul 2024 12:49:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, "Michael S . Tsirkin" <mst@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PULL 02/14] qapi/pci: Clean up documentation around PciDeviceClass
Date: Wed, 17 Jul 2024 12:48:55 +0200
Message-ID: <20240717104907.2962784-3-armbru@redhat.com>
In-Reply-To: <20240717104907.2962784-1-armbru@redhat.com>
References: <20240717104907.2962784-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

PciDeviceInfo's doc comment has a note on PciDeviceClass member @desc.
Since the note applies always, not just within PciDeviceInfo, merge it
into PciDeviceClass's description of member @desc.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240711112228.2140606-2-armbru@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 qapi/pci.json | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/qapi/pci.json b/qapi/pci.json
index 8287d15dd0..97179920fb 100644
--- a/qapi/pci.json
+++ b/qapi/pci.json
@@ -93,7 +93,8 @@
 #
 # Information about the Class of a PCI device
 #
-# @desc: a string description of the device's class
+# @desc: a string description of the device's class (not stable, and
+#     should only be treated as informational)
 #
 # @class: the class code of the device
 #
@@ -146,9 +147,6 @@
 #
 # @regions: a list of the PCI I/O regions associated with the device
 #
-# .. note:: The contents of @class_info.desc are not stable and should
-#    only be treated as informational.
-#
 # Since: 0.14
 ##
 { 'struct': 'PciDeviceInfo',
-- 
2.45.0


