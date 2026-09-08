Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCBCFC79F9E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3xQF-0003w0-13; Tue, 08 Sep 2026 11:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3xQD-0003vo-SP
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:07:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3xQC-0007j8-9P
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:07:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788880059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rYUW7mTarKGtGHB/ejRnCer72Bim5gXX0iKigt43Ozg=;
 b=avx2W58Gse7cb/Nu2j+sJB6txHDR4qGmyZHoe/5ktSBlpiLFOdyFgLnkcwYgNpCqhDmhSn
 ZgapVK7fzEpqN1d7ZXZ05cHTYzJ8n/jm9lCqt3Py6GA+bDM3PCSamGwFv8gapiCojOb333
 9VnSpUG6BSAq96eVrJem+4hMlcXfeyo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-FGeiCzUOOvGNZxYyU8cKcw-1; Tue,
 08 Sep 2026 11:07:35 -0400
X-MC-Unique: FGeiCzUOOvGNZxYyU8cKcw-1
X-Mimecast-MFC-AGG-ID: FGeiCzUOOvGNZxYyU8cKcw_1788880053
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9953B18529A7; Tue,  8 Sep 2026 15:07:33 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A449B1955F09; Tue,  8 Sep 2026 15:07:32 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 08 Sep 2026 19:06:53 +0400
Subject: [GIT PULL 10/15] ppc/pnv: fix phb-id and chip-id properties typename
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-qom-qapi-pr-v1-10-a4d75a2573cc@redhat.com>
References: <20260908-qom-qapi-pr-v1-0-a4d75a2573cc@redhat.com>
In-Reply-To: <20260908-qom-qapi-pr-v1-0-a4d75a2573cc@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Nicholas Piggin <npiggin@gmail.com>, 
 Aditya Gupta <adityag@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=4269;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=HSkTvfNSirJIc6SiW+8atmYUto98Bd95oCUMIIDC048=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqoCSPfjoZsp9pJg2OGDRDWdpwRdmhQa3MVeR69
 +pkwNkOHTmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqAkjwAKCRDa6OEJdZac
 5R5WD/4sofyc1fPCMZO80808gVYVvDiIH5dIumlYxHsEgfi1eVMpF08cW4iJ6A+2No0eQt6LUcf
 +TeBX8tB7vLzvGcd98Xt13e4ODfW5K4Paq/yKNBx62RW1k0b6queV2H5KqPIJMC8NV2+yCD8tvL
 D7LDb3W4ohhPJXrn4FhBdpdYvpxNVmz5dBdsZ0Ao++DdYN60+FmOy5Yksv89eJekwabDOZVGC5u
 zkaW/H/XCwU9eAC2rKdF44O1bqSl+RnevD6wjNVlkGDf8um/vsF2yc49A0up3Q7Dke17QqiYY6c
 1oRhPioat+2ikfeejdMadu4tHsPD3uCweIbE/qSkSFrkpdakMozEVlqYSQdQvH8WGNmE0Bmuglx
 kOuLAujptH65GFuXZvL84xNAYFXrcHxuncaDxzor5nhPkZHK5iwSwXTQqq+HkC4XyvTqRT8lNpP
 FUucwlDz7/b1jjlt//9o3qiWYoI6sZnU1SUyUv6unVT5M2Bc+HnGYFHYnO34e+EsHF7Q83VyK7X
 ZsJA77aY4Fe1P8e4HcB2n0IBm1dH2rNvbWZC5zQUCdRYhTy1Zp+bFZmDcwA5CLp9TCDOJhFbL4F
 94ZiAmt9zdIKeOeF3q/AVDWgWQwSQ7zwDir5xkaYteqMpSEHjgvwemoWVVCTu1nWj7lewxpOxvP
 YuXcciE3Ep+XL2A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The getter and setter use visit_type_size, not visit_type_int.
Since the underlying type is uint32, switch to that.

Fixes: 8ec1e4f1ef97 ("ppc/pnv: add phb-id/chip-id PnvPHB3RootBus properties")
Fixes: b7c1750dc440 ("ppc/pnv: add phb-id/chip-id PnvPHB4RootBus properties")
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/pci-host/pnv_phb3.c | 12 ++++++------
 hw/pci-host/pnv_phb4.c | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
index 4ffdb4ce31ae..db061c134e95 100644
--- a/hw/pci-host/pnv_phb3.c
+++ b/hw/pci-host/pnv_phb3.c
@@ -1130,7 +1130,7 @@ static void pnv_phb3_root_bus_get_prop(Object *obj, Visitor *v,
                                        void *opaque, Error **errp)
 {
     PnvPHB3RootBus *bus = PNV_PHB3_ROOT_BUS(obj);
-    uint64_t value = 0;
+    uint32_t value = 0;
 
     if (strcmp(name, "phb-id") == 0) {
         value = bus->phb_id;
@@ -1138,7 +1138,7 @@ static void pnv_phb3_root_bus_get_prop(Object *obj, Visitor *v,
         value = bus->chip_id;
     }
 
-    visit_type_size(v, name, &value, errp);
+    visit_type_uint32(v, name, &value, errp);
 }
 
 static void pnv_phb3_root_bus_set_prop(Object *obj, Visitor *v,
@@ -1147,9 +1147,9 @@ static void pnv_phb3_root_bus_set_prop(Object *obj, Visitor *v,
 
 {
     PnvPHB3RootBus *bus = PNV_PHB3_ROOT_BUS(obj);
-    uint64_t value;
+    uint32_t value;
 
-    if (!visit_type_size(v, name, &value, errp)) {
+    if (!visit_type_uint32(v, name, &value, errp)) {
         return;
     }
 
@@ -1164,12 +1164,12 @@ static void pnv_phb3_root_bus_class_init(ObjectClass *klass, const void *data)
 {
     BusClass *k = BUS_CLASS(klass);
 
-    object_class_property_add(klass, "phb-id", "int",
+    object_class_property_add(klass, "phb-id", "uint32",
                               pnv_phb3_root_bus_get_prop,
                               pnv_phb3_root_bus_set_prop,
                               NULL, NULL);
 
-    object_class_property_add(klass, "chip-id", "int",
+    object_class_property_add(klass, "chip-id", "uint32",
                               pnv_phb3_root_bus_get_prop,
                               pnv_phb3_root_bus_set_prop,
                               NULL, NULL);
diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 705a5bcf074f..9acaf4c0c2f5 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -1727,7 +1727,7 @@ static void pnv_phb4_root_bus_get_prop(Object *obj, Visitor *v,
                                        void *opaque, Error **errp)
 {
     PnvPHB4RootBus *bus = PNV_PHB4_ROOT_BUS(obj);
-    uint64_t value = 0;
+    uint32_t value = 0;
 
     if (strcmp(name, "phb-id") == 0) {
         value = bus->phb_id;
@@ -1735,7 +1735,7 @@ static void pnv_phb4_root_bus_get_prop(Object *obj, Visitor *v,
         value = bus->chip_id;
     }
 
-    visit_type_size(v, name, &value, errp);
+    visit_type_uint32(v, name, &value, errp);
 }
 
 static void pnv_phb4_root_bus_set_prop(Object *obj, Visitor *v,
@@ -1744,9 +1744,9 @@ static void pnv_phb4_root_bus_set_prop(Object *obj, Visitor *v,
 
 {
     PnvPHB4RootBus *bus = PNV_PHB4_ROOT_BUS(obj);
-    uint64_t value;
+    uint32_t value;
 
-    if (!visit_type_size(v, name, &value, errp)) {
+    if (!visit_type_uint32(v, name, &value, errp)) {
         return;
     }
 
@@ -1761,12 +1761,12 @@ static void pnv_phb4_root_bus_class_init(ObjectClass *klass, const void *data)
 {
     BusClass *k = BUS_CLASS(klass);
 
-    object_class_property_add(klass, "phb-id", "int",
+    object_class_property_add(klass, "phb-id", "uint32",
                               pnv_phb4_root_bus_get_prop,
                               pnv_phb4_root_bus_set_prop,
                               NULL, NULL);
 
-    object_class_property_add(klass, "chip-id", "int",
+    object_class_property_add(klass, "chip-id", "uint32",
                               pnv_phb4_root_bus_get_prop,
                               pnv_phb4_root_bus_set_prop,
                               NULL, NULL);

-- 
2.55.0.543.g5ebe2ebe4ea8


