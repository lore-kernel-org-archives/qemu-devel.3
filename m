Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C95EEE6400B
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 19:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tECkx-0006Oo-BY; Thu, 21 Nov 2024 14:22:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tECkv-0006NI-1x
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:22:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tECkt-0002XI-Gq
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:22:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732216938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9vhWk96oVKVLtN21I7pTVsck1ZbkLXW6bkcDAjMNBC0=;
 b=QRYbE35zzNcYIRSfSJnvCbvDN5CPxrRmsE08ud4T838sQYkuiZrDfKv+EPMKM8wK1gkhbr
 gZUZs+U7G+YZt6rnisInun8F3BH65viWnWE82c3crDhM+F2VG1tskAujXZv1fNjSKPhS5C
 J8wB185H2kCKZ5t4zXlaHawveoYj5So=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-FyAXN09TM9SWyACrcugbJQ-1; Thu, 21 Nov 2024 14:22:15 -0500
X-MC-Unique: FyAXN09TM9SWyACrcugbJQ-1
X-Mimecast-MFC-AGG-ID: FyAXN09TM9SWyACrcugbJQ
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-83ab4cadf05so130035339f.1
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 11:22:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732216935; x=1732821735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9vhWk96oVKVLtN21I7pTVsck1ZbkLXW6bkcDAjMNBC0=;
 b=K86e9sSovi8tUrWOoj2u7mzGkhHyeuKRhOOnRoShv8lqOlRSDxY3+iuYEpART8HJsJ
 /pXkXhgMqtT+pEZ0EUDJzVh8L2HfiEvhL0lgInIHPmpSn0eMccButFPPmz+oRa67WmY2
 uIB/0kY0/wdwN0On7+wWHAeCGGQH2OBmGViem+XxQ6m2RVJuU8Z8eMGZMwRkMIicmNza
 6oNa2DidCp0fevOTa+TGd6vYqtE1xzz3WsBcdey4SzFWwUk9jUNw4CeKhM8ilsoO0NWj
 IOrynPXN3yWDlO1rs7yQSBhqHKaJyutN2JwrD2hqL6IoMHf1iyc7MDokQm/IAGRDnbpO
 SEZw==
X-Gm-Message-State: AOJu0YyZd4rKovsTfXM5dE+CFLB2dTGTprc0L7qGMyfQ72J+KjuDBId0
 Q+LuXclzaau9rUI4hwVv3r2o0bnWeLBkxQKgl91aWzCZ0kKq6WTnLxw5FH11AhmW/ZmcZ+g2DqM
 yivTwI6GbWQ3lhvF2ApdBKngezL4lVgvueNo6uJTRQeRpTmTZ5lQqp3RAdzPecsW7vCcCXmvQNP
 NSoFzuJ3qeW15K2NzEUwPaEu5xJeBBCKs8Xw==
X-Gm-Gg: ASbGnctr6JluL71VOUBnBCYgfG7mrQniBfptHHtD7q2JULOva63xOQ/PlAeqlXutaKv
 7uais8ruaj+7um+dDEwuen99e56cH6NlqS7N9OJiZa4x1YHSXSZ6SMBH8L1OIhTzMTv6r6JpUIr
 DPqGu80nPt1ok9yzazJ26vIx0BQ+OwIml+kwNsC9w5msseiSXocyIzGpk+dd+iEvFpN1YZtprEm
 pcIS1sqYMsx4b8GWQMbhm3PAtLb6fx8FAtYYfgulRDRutwKVDy9sh8yWFmfe25myJzz8MrXe2pH
 F/QkbZAoHu6IGHnNS39mVgDtzw==
X-Received: by 2002:a05:6e02:b43:b0:3a7:9347:544c with SMTP id
 e9e14a558f8ab-3a79acf1328mr3232015ab.5.1732216934890; 
 Thu, 21 Nov 2024 11:22:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZ35yTgMJ2Y/HqLTkFsuIdcK9Sy9folVM7pfXDE+0nCsBsv2BPf84/5/OfDOW35cS9Kbd6Pg==
X-Received: by 2002:a05:6e02:b43:b0:3a7:9347:544c with SMTP id
 e9e14a558f8ab-3a79acf1328mr3231755ab.5.1732216934567; 
 Thu, 21 Nov 2024 11:22:14 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e1cfe345f0sm102939173.45.2024.11.21.11.22.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 11:22:14 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Subject: [PATCH v2 06/13] hw/ppc: Explicitly create the drc container
Date: Thu, 21 Nov 2024 14:21:55 -0500
Message-ID: <20241121192202.4155849-7-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241121192202.4155849-1-peterx@redhat.com>
References: <20241121192202.4155849-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 hw/ppc/spapr_drc.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 1484e3209d..7868048bb9 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -27,7 +27,7 @@
 #include "sysemu/reset.h"
 #include "trace.h"
 
-#define DRC_CONTAINER_PATH "/dr-connector"
+#define DRC_CONTAINER_PATH "dr-connector"
 #define DRC_INDEX_TYPE_SHIFT 28
 #define DRC_INDEX_ID_MASK ((1ULL << DRC_INDEX_TYPE_SHIFT) - 1)
 
@@ -514,6 +514,16 @@ static const VMStateDescription vmstate_spapr_drc = {
     }
 };
 
+static void drc_container_create(void)
+{
+    object_property_add_new_container(object_get_root(), DRC_CONTAINER_PATH);
+}
+
+static Object *drc_container_get(void)
+{
+    return object_resolve_path_component(object_get_root(), DRC_CONTAINER_PATH);
+}
+
 static void drc_realize(DeviceState *d, Error **errp)
 {
     SpaprDrc *drc = SPAPR_DR_CONNECTOR(d);
@@ -529,7 +539,7 @@ static void drc_realize(DeviceState *d, Error **errp)
      * inaccessible by the guest, since lookups rely on this path
      * existing in the composition tree
      */
-    root_container = container_get(object_get_root(), DRC_CONTAINER_PATH);
+    root_container = drc_container_get();
     child_name = object_get_canonical_path_component(OBJECT(drc));
     trace_spapr_drc_realize_child(spapr_drc_index(drc), child_name);
     object_property_add_alias(root_container, link_name,
@@ -543,12 +553,10 @@ static void drc_unrealize(DeviceState *d)
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
@@ -585,6 +593,8 @@ static void spapr_dr_connector_class_init(ObjectClass *k, void *data)
 {
     DeviceClass *dk = DEVICE_CLASS(k);
 
+    drc_container_create();
+
     dk->realize = drc_realize;
     dk->unrealize = drc_unrealize;
     /*
@@ -796,9 +806,8 @@ static const TypeInfo spapr_drc_pmem_info = {
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
@@ -860,7 +869,7 @@ int spapr_dt_drc(void *fdt, int offset, Object *owner, uint32_t drc_type_mask)
     /* aliases for all DRConnector objects will be rooted in QOM
      * composition tree at DRC_CONTAINER_PATH
      */
-    root_container = container_get(object_get_root(), DRC_CONTAINER_PATH);
+    root_container = drc_container_get();
 
     object_property_iter_init(&iter, root_container);
     while ((prop = object_property_iter_next(&iter))) {
@@ -953,7 +962,7 @@ void spapr_drc_reset_all(SpaprMachineState *spapr)
     ObjectProperty *prop;
     ObjectPropertyIterator iter;
 
-    drc_container = container_get(object_get_root(), DRC_CONTAINER_PATH);
+    drc_container = drc_container_get();
 restart:
     object_property_iter_init(&iter, drc_container);
     while ((prop = object_property_iter_next(&iter))) {
-- 
2.45.0


