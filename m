Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E09C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3xQJ-0003yM-76; Tue, 08 Sep 2026 11:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3xQH-0003wl-OS
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:07:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3xQG-0007jf-8o
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:07:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788880063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t0aO7FqfJSAdz1YQ8MVxqiTp3fdIPsWeQDE0DGs8ifM=;
 b=i/odnhsZhAuXrTAfVVeOhKqcAkYkP34IDBE9NhRbMThYVzylsn71qH9BP/zmpdEkSucOnV
 IHc2UTl5x4AdJFMHcgHR3I+Kzk922imnca9Tim/GuT8VAM+wV0ecTppy0UpbrEXzKg+GsI
 2QnXrQSkL0XmqWjGXJJZnuFq2k2IQm0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-a3tJTV51O2uA02FDbFKJ9w-1; Tue,
 08 Sep 2026 11:07:42 -0400
X-MC-Unique: a3tJTV51O2uA02FDbFKJ9w-1
X-Mimecast-MFC-AGG-ID: a3tJTV51O2uA02FDbFKJ9w_1788880061
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66EA4195DE7D; Tue,  8 Sep 2026 15:07:41 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 51FAE1956044; Tue,  8 Sep 2026 15:07:39 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 08 Sep 2026 19:06:55 +0400
Subject: [GIT PULL 12/15] hw/acpi: fix "node" properties typename
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-qom-qapi-pr-v1-12-a4d75a2573cc@redhat.com>
References: <20260908-qom-qapi-pr-v1-0-a4d75a2573cc@redhat.com>
In-Reply-To: <20260908-qom-qapi-pr-v1-0-a4d75a2573cc@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1725;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=rI6+Ht1+ovIHApi7V2V/PxX0Go4UHFVSP/2DooxLlRM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqoCSP81rRDgWwzG+txYvtORmtjxOa1dto4kOVk
 wBHrKYlsVaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqAkjwAKCRDa6OEJdZac
 5fqREACW0flT4l+s6FG4MENJYo0wz2assTJ9AFDNMzS6LoEHf4tinlAgbXR4HYSmUmeoRdj+r9O
 2rr7k9x6SHGUxhfNQJxLhxjSE2AycUyu39wu4g25WjNLi6OtrfaDDwnTY4PwXSgA+l1XQa1cVbq
 0GeriSWjsS4D3z6GOfVMVRWGbmwi1bwpGWrrLUHRJ6OeVg25t8pFIXsh2bdQnnInKiNU8FoMIOA
 iWet1dYHdFhYYCYy3AEoGGySNFlg/7eEx9Zl+GynnFvXHSfb4GeONN0jEQbd49paORRPpBSX2I2
 ddvXcLJWXli3SFeqhhHmYkAFrRaqA2NDUobBTJZy/UiiVml1TaTew+JRAjTzD2JDU1SselGkqfu
 Fc44ihDxunMH9QHMD0YRUBnwcfljdm46hRo+HBiP3OfGgkA3qllYhz8kEBgQ1pNrxDEBThsVCfp
 WZ27zrKxbpCqQS3ncJdSUyj1AiFL71Zy4fLJvDmXw84kt7FLsyPmYWCt2dqwrmum3BIXMDi7OvH
 N+fCTjjOca08uArFZ/fLurva/Itfr4feMz6OhdYj6i/zQ4I8JnRO4cfO4oE+EmiYa/pPGWmhMz/
 klXI4x7uH3gpdA24ehSMdbNAAz5B+rIzMSXUE/NgOBXGnJCZiZ8jTbTDMBIZcTtecZ/hXpZeTXZ
 mCWevWmFGbJcvaQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The setter uses visit_type_uint32, not visit_type_int.

Fixes: f74e78220dbf ("acpi/pci: Move Generic Initiator object handling into acpi/pci.*")
Fixes: a82fe8291643 ("hw/acpi: Generic Port Affinity Structure support")
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/acpi/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
index 8c7ed104796d..c82924be8620 100644
--- a/hw/acpi/pci.c
+++ b/hw/acpi/pci.c
@@ -139,7 +139,7 @@ static void acpi_generic_initiator_class_init(ObjectClass *oc, const void *data)
         acpi_generic_initiator_set_pci_device);
     object_class_property_set_description(oc, "pci-dev",
         "PCI device to associate with the node");
-    object_class_property_add(oc, "node", "int", NULL,
+    object_class_property_add(oc, "node", "uint32", NULL,
         acpi_generic_initiator_set_node, NULL, NULL);
     object_class_property_set_description(oc, "node",
         "NUMA node associated with the PCI device");
@@ -253,7 +253,7 @@ static void acpi_generic_port_class_init(ObjectClass *oc, const void *data)
         acpi_generic_port_set_pci_bus);
     object_class_property_set_description(oc, "pci-bus",
        "PCI Bus of the host bridge associated with this GP affinity structure");
-    object_class_property_add(oc, "node", "int", NULL,
+    object_class_property_add(oc, "node", "uint32", NULL,
         acpi_generic_port_set_node, NULL, NULL);
     object_class_property_set_description(oc, "node",
        "The NUMA node like ID to index HMAT/SLIT NUMA properties involving GP");

-- 
2.55.0.543.g5ebe2ebe4ea8


