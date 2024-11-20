Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1513DD743E5
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 21:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDshW-0008Nl-2S; Wed, 20 Nov 2024 16:57:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDshS-0008HJ-Ca
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 16:57:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDshO-0006QR-BV
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 16:57:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732139841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PREdB4/GA5F1WtJr+XErnL2nDAuMQINonyrD4P78cKQ=;
 b=fRz22foUYRNvPhtGVdBujBU9ofMI2h1kRY10VEs5mrkXcJQqktRI7+9u8KDEXxb6mnBsuR
 W/x59P6vHMzZARFNM9EAYfFV3T/gTkGa77xF55xth1B8AZE9/+ElhVqgizajC2o9ylRWTo
 7/PogH+ztvcwYC+8FeAbZpMY5N/HyZY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-6EN9IQXcM6egjXUy8UK7Zw-1; Wed, 20 Nov 2024 16:57:20 -0500
X-MC-Unique: 6EN9IQXcM6egjXUy8UK7Zw-1
X-Mimecast-MFC-AGG-ID: 6EN9IQXcM6egjXUy8UK7Zw
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-460c73093edso3031941cf.2
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 13:57:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732139839; x=1732744639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PREdB4/GA5F1WtJr+XErnL2nDAuMQINonyrD4P78cKQ=;
 b=unysTrCwL5+Z3I69R9wP9PGUc8EnTb8irhn8Xbe0dfo13JJKfsIFDA2mZd5xcRP0nU
 I/zsPxKhF+XMS6y3PxvjmASqEBeShCjv9OCioFqdurBouuWjMR2RN227U26zBR6SIyFe
 iZaoq+CzUhf8sD6yonvuiRTNz2kfrRw60Ldd6367mgbjl8B/4vIHGjDG9sHVhxEWtiiL
 +C117OilCXbV2fXZFACu6oYILBaZfb8iTCDF+pu7KfHD5EYpzGhX5zMIYA+vKa7dCEw7
 s8Ps2ngaWjfQHMgcwRywFRJO2zWsZemi3ZZ69jW5eFkURktE8PZX1MU+P/7ab2XgYCB5
 0Rsw==
X-Gm-Message-State: AOJu0YyiMQfim8EzCJcGlVHH3Lp2gXEDmw7lYoEiquIKiPhggHV7d/mQ
 qqU6XpoUKnqkR/uFV5YNCgd0if9FzFHwnOt1Rv1JYZmMPL6DOFiBv/97iG1tWPK+IGNu/W9WKI0
 61qvKrqhRGV3KhPgktjYaM8H0z6ZvX3sVLe7RP7kfmoqsTG22s3Ed7tBmGhzY5fuiNaz/E0AZ3q
 kBxL7nJE0IX+1ayvPlhuswRB0xJbD6AoohAg==
X-Received: by 2002:a05:622a:1bac:b0:460:edba:3696 with SMTP id
 d75a77b69052e-464786ad4e0mr46595241cf.29.1732139839276; 
 Wed, 20 Nov 2024 13:57:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVGHBdtQ/JmTIKWWrebmM1RCJOykDeHiCaIMIIXn6l1dAkdlCCtyvFple3xNRztYKMrd4FaQ==
X-Received: by 2002:a05:622a:1bac:b0:460:edba:3696 with SMTP id
 d75a77b69052e-464786ad4e0mr46594901cf.29.1732139838917; 
 Wed, 20 Nov 2024 13:57:18 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-464680d6826sm14632881cf.15.2024.11.20.13.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 13:57:18 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Subject: [PATCH 06/12] hw/ppc: Explicitly create the drc container
Date: Wed, 20 Nov 2024 16:56:57 -0500
Message-ID: <20241120215703.3918445-7-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241120215703.3918445-1-peterx@redhat.com>
References: <20241120215703.3918445-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

QEMU will start to not rely on implicit creations of containers soon.  Make
PPC drc devices follow by explicitly create the container whenever a drc
device is realized, dropping container_get() calls.

No functional change intended.

Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-ppc@nongnu.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/ppc/spapr_drc.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 1484e3209d..3d6ef26b38 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -27,7 +27,7 @@
 #include "sysemu/reset.h"
 #include "trace.h"
 
-#define DRC_CONTAINER_PATH "/dr-connector"
+#define DRC_CONTAINER_PATH "dr-connector"
 #define DRC_INDEX_TYPE_SHIFT 28
 #define DRC_INDEX_ID_MASK ((1ULL << DRC_INDEX_TYPE_SHIFT) - 1)
 
@@ -514,6 +514,26 @@ static const VMStateDescription vmstate_spapr_drc = {
     }
 };
 
+static GOnce drc_container_created = G_ONCE_INIT;
+
+static gpointer drc_container_create(gpointer unused G_GNUC_UNUSED)
+{
+    container_create(object_get_root(), DRC_CONTAINER_PATH);
+    return NULL;
+}
+
+static Object *drc_container_get(void)
+{
+    return object_resolve_path_component(
+        object_get_root(), DRC_CONTAINER_PATH);
+}
+
+/* TODO: create the container in an ppc init function */
+static void drc_container_create_once(void)
+{
+    g_once(&drc_container_created, drc_container_create, NULL);
+}
+
 static void drc_realize(DeviceState *d, Error **errp)
 {
     SpaprDrc *drc = SPAPR_DR_CONNECTOR(d);
@@ -521,6 +541,9 @@ static void drc_realize(DeviceState *d, Error **errp)
     Object *root_container;
     const char *child_name;
 
+    /* Whenever a DRC device is realized, create the container */
+    drc_container_create_once();
+
     trace_spapr_drc_realize(spapr_drc_index(drc));
     /* NOTE: we do this as part of realize/unrealize due to the fact
      * that the guest will communicate with the DRC via RTAS calls
@@ -529,7 +552,7 @@ static void drc_realize(DeviceState *d, Error **errp)
      * inaccessible by the guest, since lookups rely on this path
      * existing in the composition tree
      */
-    root_container = container_get(object_get_root(), DRC_CONTAINER_PATH);
+    root_container = drc_container_get();
     child_name = object_get_canonical_path_component(OBJECT(drc));
     trace_spapr_drc_realize_child(spapr_drc_index(drc), child_name);
     object_property_add_alias(root_container, link_name,
@@ -543,12 +566,10 @@ static void drc_unrealize(DeviceState *d)
 {
     SpaprDrc *drc = SPAPR_DR_CONNECTOR(d);
     g_autofree gchar *name = g_strdup_printf("%x", spapr_drc_index(drc));
-    Object *root_container;
 
     trace_spapr_drc_unrealize(spapr_drc_index(drc));
     vmstate_unregister(VMSTATE_IF(drc), &vmstate_spapr_drc, drc);
-    root_container = container_get(object_get_root(), DRC_CONTAINER_PATH);
-    object_property_del(root_container, name);
+    object_property_del(drc_container_get(), name);
 }
 
 SpaprDrc *spapr_dr_connector_new(Object *owner, const char *type,
@@ -796,9 +817,8 @@ static const TypeInfo spapr_drc_pmem_info = {
 SpaprDrc *spapr_drc_by_index(uint32_t index)
 {
     Object *obj;
-    g_autofree gchar *name = g_strdup_printf("%s/%x", DRC_CONTAINER_PATH,
-                                             index);
-    obj = object_resolve_path(name, NULL);
+    g_autofree gchar *name = g_strdup_printf("%x", index);
+    obj = object_resolve_path_component(drc_container_get(), name);
 
     return !obj ? NULL : SPAPR_DR_CONNECTOR(obj);
 }
@@ -860,7 +880,7 @@ int spapr_dt_drc(void *fdt, int offset, Object *owner, uint32_t drc_type_mask)
     /* aliases for all DRConnector objects will be rooted in QOM
      * composition tree at DRC_CONTAINER_PATH
      */
-    root_container = container_get(object_get_root(), DRC_CONTAINER_PATH);
+    root_container = drc_container_get();
 
     object_property_iter_init(&iter, root_container);
     while ((prop = object_property_iter_next(&iter))) {
@@ -953,7 +973,7 @@ void spapr_drc_reset_all(SpaprMachineState *spapr)
     ObjectProperty *prop;
     ObjectPropertyIterator iter;
 
-    drc_container = container_get(object_get_root(), DRC_CONTAINER_PATH);
+    drc_container = drc_container_get();
 restart:
     object_property_iter_init(&iter, drc_container);
     while ((prop = object_property_iter_next(&iter))) {
-- 
2.45.0


