Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BC2C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 19:11:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEZVr-0004eU-3f; Tue, 04 Jun 2024 15:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZVp-0004U6-MM
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:08:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZVn-0000yd-9S
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:08:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717528078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rl1nDigpJRwgGE3w/iYUa7vmMKH4nemfm7NPNL/7aBE=;
 b=UHqJL4RY6avWa7rRnEOMMzFzpbK6Q3eNPnW22DDk79fCgD+py6EXhbrj/jyE9yumJttu9t
 FIC4T8ogkDJrremBqo2aWIKgs9hvW9RNXwY/MmFJwXpQ15LQAib6JN2eyMIfO9rM5C4xLx
 7hOcEJCKD1sTBf4dDlGypCGV3pghFN0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-17VZsbEUMYO1oAQ7B5Pvkg-1; Tue, 04 Jun 2024 15:07:57 -0400
X-MC-Unique: 17VZsbEUMYO1oAQ7B5Pvkg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42133ebdf24so30286115e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 12:07:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717528075; x=1718132875;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rl1nDigpJRwgGE3w/iYUa7vmMKH4nemfm7NPNL/7aBE=;
 b=UWV4WuLz4I3ezLn3XEYf+I7m0fFzd1BKB8+Rib/+96Y5pt/2wyN2XvoO4GuPLf4lLd
 HkBOox0E7lFM+Oj3qPQ5S+4v6+wwcOlIrOrps3Q61LwTqIfnmHNQlhFU0g3KbdD0LMhk
 VLE6VFuWQnC1ekW1uC4lm/uDXuPe4NFM+taIpUToHnb9FY9lxcI+seIoWtp4g43NfCPj
 ml0hVbWYa57T/YYq/oaJExXuiArNIoI43r2/EjstENrv7aLH5ltcDDH69mkbH8UNu+D6
 Bd2MubjbXHT342/2yMMtrnI1Nza7C3mprsSc8l2fJvyRFI4X+JqyCgZSkKuNpDLJH0Il
 Y82w==
X-Gm-Message-State: AOJu0YxHD0apQ+Va6hDnAJY2XW4h20/Cx/d6okXAOh+f/Gab3cL946Q2
 aQDz5/wPFyZTRe952kdhEeXpFjamxMnohihMWcaIbUNWkwOrhJQvDddLpvG/VuJnCo6ylVd484+
 q++mttFNz9Q4bZi/4bCUoyXmybIYtGbB3PyqI1S30MLCE2FC5B+AJdBApcmZFsRSTprX2LvGeiN
 AWBXJGUoL9yrjXSr7Bi2yxKVBh5PSP7w==
X-Received: by 2002:a05:600c:2046:b0:421:5329:235 with SMTP id
 5b1f17b1804b1-421562ef808mr3990145e9.24.1717528075180; 
 Tue, 04 Jun 2024 12:07:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuCmM5mGleOgdSRGd5SU56p9w4IVBX6xPBJuDgSdN42IOxS7twoLXmUvSU2nj+Ti6ZdFHhxA==
X-Received: by 2002:a05:600c:2046:b0:421:5329:235 with SMTP id
 5b1f17b1804b1-421562ef808mr3989995e9.24.1717528074695; 
 Tue, 04 Jun 2024 12:07:54 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:552:cf5c:2b13:215c:b9df:f231])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4213837673csm119049435e9.31.2024.06.04.12.07.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 12:07:54 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:07:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 32/46] hw/acpi: Insert an acpi-generic-node base under
 acpi-generic-initiator
Message-ID: <e786b417b7bb2207ad1833d0d64abe57043de8f5.1717527933.git.mst@redhat.com>
References: <cover.1717527933.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717527933.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This will simplify reuse when adding acpi-generic-port.
Note that some error_printf() messages will now print acpi-generic-node
whereas others will move to type specific cases in next patch so
are left alone for now.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240524100507.32106-3-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/acpi_generic_initiator.h | 15 ++++-
 hw/acpi/acpi_generic_initiator.c         | 80 +++++++++++++++---------
 2 files changed, 63 insertions(+), 32 deletions(-)

diff --git a/include/hw/acpi/acpi_generic_initiator.h b/include/hw/acpi/acpi_generic_initiator.h
index a304bad73e..dd4be19c8f 100644
--- a/include/hw/acpi/acpi_generic_initiator.h
+++ b/include/hw/acpi/acpi_generic_initiator.h
@@ -8,15 +8,26 @@
 
 #include "qom/object_interfaces.h"
 
-#define TYPE_ACPI_GENERIC_INITIATOR "acpi-generic-initiator"
+/*
+ * Abstract type to be used as base for
+ * - acpi-generic-initiator
+ * - acpi-generic-port
+ */
+#define TYPE_ACPI_GENERIC_NODE "acpi-generic-node"
 
-typedef struct AcpiGenericInitiator {
+typedef struct AcpiGenericNode {
     /* private */
     Object parent;
 
     /* public */
     char *pci_dev;
     uint16_t node;
+} AcpiGenericNode;
+
+#define TYPE_ACPI_GENERIC_INITIATOR "acpi-generic-initiator"
+
+typedef struct AcpiGenericInitiator {
+    AcpiGenericNode parent;
 } AcpiGenericInitiator;
 
 /*
diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
index 18a939b0e5..c054e0e27d 100644
--- a/hw/acpi/acpi_generic_initiator.c
+++ b/hw/acpi/acpi_generic_initiator.c
@@ -10,45 +10,61 @@
 #include "hw/pci/pci_device.h"
 #include "qemu/error-report.h"
 
-typedef struct AcpiGenericInitiatorClass {
+typedef struct AcpiGenericNodeClass {
     ObjectClass parent_class;
+} AcpiGenericNodeClass;
+
+typedef struct AcpiGenericInitiatorClass {
+     AcpiGenericNodeClass parent_class;
 } AcpiGenericInitiatorClass;
 
+OBJECT_DEFINE_ABSTRACT_TYPE(AcpiGenericNode, acpi_generic_node,
+                            ACPI_GENERIC_NODE, OBJECT)
+
+OBJECT_DECLARE_SIMPLE_TYPE(AcpiGenericNode, ACPI_GENERIC_NODE)
+
 OBJECT_DEFINE_TYPE_WITH_INTERFACES(AcpiGenericInitiator, acpi_generic_initiator,
-                   ACPI_GENERIC_INITIATOR, OBJECT,
+                   ACPI_GENERIC_INITIATOR, ACPI_GENERIC_NODE,
                    { TYPE_USER_CREATABLE },
                    { NULL })
 
 OBJECT_DECLARE_SIMPLE_TYPE(AcpiGenericInitiator, ACPI_GENERIC_INITIATOR)
 
+static void acpi_generic_node_init(Object *obj)
+{
+    AcpiGenericNode *gn = ACPI_GENERIC_NODE(obj);
+
+    gn->node = MAX_NODES;
+    gn->pci_dev = NULL;
+}
+
 static void acpi_generic_initiator_init(Object *obj)
 {
-    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
+}
 
-    gi->node = MAX_NODES;
-    gi->pci_dev = NULL;
+static void acpi_generic_node_finalize(Object *obj)
+{
+    AcpiGenericNode *gn = ACPI_GENERIC_NODE(obj);
+
+    g_free(gn->pci_dev);
 }
 
 static void acpi_generic_initiator_finalize(Object *obj)
 {
-    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
-
-    g_free(gi->pci_dev);
 }
 
-static void acpi_generic_initiator_set_pci_device(Object *obj, const char *val,
-                                                  Error **errp)
+static void acpi_generic_node_set_pci_device(Object *obj, const char *val,
+                                             Error **errp)
 {
-    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
+    AcpiGenericNode *gn = ACPI_GENERIC_NODE(obj);
 
-    gi->pci_dev = g_strdup(val);
+    gn->pci_dev = g_strdup(val);
 }
-
-static void acpi_generic_initiator_set_node(Object *obj, Visitor *v,
-                                            const char *name, void *opaque,
-                                            Error **errp)
+static void acpi_generic_node_set_node(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
 {
-    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
+    AcpiGenericNode *gn = ACPI_GENERIC_NODE(obj);
     MachineState *ms = MACHINE(qdev_get_machine());
     uint32_t value;
 
@@ -58,20 +74,24 @@ static void acpi_generic_initiator_set_node(Object *obj, Visitor *v,
 
     if (value >= MAX_NODES) {
         error_printf("%s: Invalid NUMA node specified\n",
-                     TYPE_ACPI_GENERIC_INITIATOR);
+                     TYPE_ACPI_GENERIC_NODE);
         exit(1);
     }
 
-    gi->node = value;
-    ms->numa_state->nodes[gi->node].has_gi = true;
+    gn->node = value;
+    ms->numa_state->nodes[gn->node].has_gi = true;
+}
+
+static void acpi_generic_node_class_init(ObjectClass *oc, void *data)
+{
+    object_class_property_add_str(oc, "pci-dev", NULL,
+        acpi_generic_node_set_pci_device);
+    object_class_property_add(oc, "node", "int", NULL,
+        acpi_generic_node_set_node, NULL, NULL);
 }
 
 static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
 {
-    object_class_property_add_str(oc, "pci-dev", NULL,
-        acpi_generic_initiator_set_pci_device);
-    object_class_property_add(oc, "node", "int", NULL,
-        acpi_generic_initiator_set_node, NULL, NULL);
 }
 
 /*
@@ -104,9 +124,9 @@ build_srat_generic_pci_initiator_affinity(GArray *table_data, int node,
 static int build_all_acpi_generic_initiators(Object *obj, void *opaque)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
-    AcpiGenericInitiator *gi;
     GArray *table_data = opaque;
     PCIDeviceHandle dev_handle;
+    AcpiGenericNode *gn;
     PCIDevice *pci_dev;
     Object *o;
 
@@ -114,14 +134,14 @@ static int build_all_acpi_generic_initiators(Object *obj, void *opaque)
         return 0;
     }
 
-    gi = ACPI_GENERIC_INITIATOR(obj);
-    if (gi->node >= ms->numa_state->num_nodes) {
+    gn = ACPI_GENERIC_NODE(obj);
+    if (gn->node >= ms->numa_state->num_nodes) {
         error_printf("%s: Specified node %d is invalid.\n",
-                     TYPE_ACPI_GENERIC_INITIATOR, gi->node);
+                     TYPE_ACPI_GENERIC_INITIATOR, gn->node);
         exit(1);
     }
 
-    o = object_resolve_path_type(gi->pci_dev, TYPE_PCI_DEVICE, NULL);
+    o = object_resolve_path_type(gn->pci_dev, TYPE_PCI_DEVICE, NULL);
     if (!o) {
         error_printf("%s: Specified device must be a PCI device.\n",
                      TYPE_ACPI_GENERIC_INITIATOR);
@@ -135,7 +155,7 @@ static int build_all_acpi_generic_initiators(Object *obj, void *opaque)
                                    pci_dev->devfn);
 
     build_srat_generic_pci_initiator_affinity(table_data,
-                                              gi->node, &dev_handle);
+                                              gn->node, &dev_handle);
 
     return 0;
 }
-- 
MST


