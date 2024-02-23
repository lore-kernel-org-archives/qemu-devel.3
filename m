Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A97AC54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 12:47:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdUwl-0005e5-Ft; Fri, 23 Feb 2024 07:46:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rdUuZ-0000Zg-Sz
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 07:44:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rdUuW-0003t8-8E
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 07:44:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708692255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nmdruoOJ3jUMHKvsYKs+fkt0NIhjHctBauqY59pHvn0=;
 b=XqA6kKvOkejYO7Hlsc3Lcc9o3+BHMJdZQe+7TcXT4rkwj7DaVvTDnU+d6SSZqKvJGrSh4h
 SwVqNA90uNMq0eXQyQR1Z+XuXOULn2S/lrw24XY2gl5S2iw7Z9EooObVTpWPpEx4Tlscg1
 /fO+A5IQIq8JpMzX19/HUfwxdX9mJ3Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-j730JWsfP024p31zW5VvBw-1; Fri, 23 Feb 2024 07:44:13 -0500
X-MC-Unique: j730JWsfP024p31zW5VvBw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33d29de76abso364989f8f.3
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 04:44:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708692249; x=1709297049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nmdruoOJ3jUMHKvsYKs+fkt0NIhjHctBauqY59pHvn0=;
 b=LBXHTc2lficUFRItxAfLMiQlln57cwUkZgW1xQ+0MNQ/wTIyB0c1NmKGZTBZ2JrEZ3
 rIZ6cMAu9eXJ4KInNb0076vqVAPl3jQocPTjpjciIKZpTeGS8KxcVwPumeF7/u0zriMd
 NF1Otz3slIn8qrxpl/bBo7BQRiJcSpUYXBE4XfiUdsHg3TfupVNPZ/NWxcDsI5DpgVhJ
 C0Z8C3jVjfgZ+CFRSGyc8nmVR3NuaxH9dY59NIxVlbmLr4pB6psOiCE2faKVPTfu2vD7
 w8ZH5HiC15+rm3B6l5lnxrHVXnF6ep/Uw4ccWyjLtiTMW6F6MvZfImjgPwaKzNrzyoxV
 LP2Q==
X-Gm-Message-State: AOJu0YyQ2gMFR7mrxMgN5PkqX3dwa+w+MSsIwRGPEadCLVAkNcZO/acV
 OgF802ct6triR/LXXQhmoi8WXirQj7od1H9FR83nbTAvWHI58JjcV1PCmNZDQJGVakTrp/5b5o4
 92F0qqBFuvYrlZnH/gsLJDP+hDLGVgtEw3gEwQsb4ngEnPfqCt1J55F/WSiHwrjGB9ZCn6Lb+XF
 3WVwnj7+viEsG/GcBChrXo5uEVrrNFxHvuz6gr
X-Received: by 2002:adf:e789:0:b0:33d:3566:b5bf with SMTP id
 n9-20020adfe789000000b0033d3566b5bfmr1544993wrm.14.1708692249505; 
 Fri, 23 Feb 2024 04:44:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiqCArlJLvxhdQSUt8htugF3kvNrFnTJKBD7V2o8ZTh0EgcyIuQEaYZDinViuc8Txv0ns4mg==
X-Received: by 2002:adf:e789:0:b0:33d:3566:b5bf with SMTP id
 n9-20020adfe789000000b0033d3566b5bfmr1544975wrm.14.1708692249107; 
 Fri, 23 Feb 2024 04:44:09 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 cl1-20020a5d5f01000000b0033cdf1f15e8sm2994931wrb.16.2024.02.23.04.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 04:44:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	balaton@eik.bme.hu
Subject: [PATCH 01/10] acpi,
 qom: move object_resolve_type_unambiguous to core QOM
Date: Fri, 23 Feb 2024 13:43:57 +0100
Message-ID: <20240223124406.234509-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240223124406.234509-1-pbonzini@redhat.com>
References: <20240223124406.234509-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
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

object_resolve_type_unambiguous provides a useful functionality, that
is currently emulated for example by usb_bus_find().  Move it to core
code and add error reporting for increased generality.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qom/object.h | 13 +++++++++++++
 hw/i386/acpi-build.c | 19 ++++---------------
 qom/object.c         | 16 ++++++++++++++++
 3 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index afccd24ca7a..e9ed9550f05 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1550,6 +1550,19 @@ Object *object_resolve_path(const char *path, bool *ambiguous);
 Object *object_resolve_path_type(const char *path, const char *typename,
                                  bool *ambiguous);
 
+/**
+ * object_resolve_type_unambiguous:
+ * @typename: the type to look for
+ * @errp: pointer to error object
+ *
+ * Return the only object in the QOM tree of type @typename.
+ * If no match or more than one match is found, an error is
+ * returned.
+ *
+ * Returns: The matched object or NULL on path lookup failure.
+ */
+Object *object_resolve_type_unambiguous(const char *typename, Error **errp);
+
 /**
  * object_resolve_path_at:
  * @parent: the object in which to resolve the path
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index d3ce96dd9f9..4b47dbfd71c 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -192,21 +192,10 @@ static void init_common_fadt_data(MachineState *ms, Object *o,
     *data = fadt;
 }
 
-static Object *object_resolve_type_unambiguous(const char *typename)
-{
-    bool ambig;
-    Object *o = object_resolve_path_type("", typename, &ambig);
-
-    if (ambig || !o) {
-        return NULL;
-    }
-    return o;
-}
-
 static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
 {
-    Object *piix = object_resolve_type_unambiguous(TYPE_PIIX4_PM);
-    Object *lpc = object_resolve_type_unambiguous(TYPE_ICH9_LPC_DEVICE);
+    Object *piix = object_resolve_type_unambiguous(TYPE_PIIX4_PM, NULL);
+    Object *lpc = object_resolve_type_unambiguous(TYPE_ICH9_LPC_DEVICE, NULL);
     Object *obj = piix ? piix : lpc;
     QObject *o;
     pm->cpu_hp_io_base = 0;
@@ -1428,8 +1417,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
            AcpiPmInfo *pm, AcpiMiscInfo *misc,
            Range *pci_hole, Range *pci_hole64, MachineState *machine)
 {
-    Object *i440fx = object_resolve_type_unambiguous(TYPE_I440FX_PCI_HOST_BRIDGE);
-    Object *q35 = object_resolve_type_unambiguous(TYPE_Q35_HOST_DEVICE);
+    Object *i440fx = object_resolve_type_unambiguous(TYPE_I440FX_PCI_HOST_BRIDGE, NULL);
+    Object *q35 = object_resolve_type_unambiguous(TYPE_Q35_HOST_DEVICE, NULL);
     CrsRangeEntry *entry;
     Aml *dsdt, *sb_scope, *scope, *dev, *method, *field, *pkg, *crs;
     CrsRangeSet crs_range_set;
diff --git a/qom/object.c b/qom/object.c
index 2c4c64d2b63..d4a001cf411 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2229,6 +2229,22 @@ Object *object_resolve_path_at(Object *parent, const char *path)
     return object_resolve_abs_path(parent, parts, TYPE_OBJECT);
 }
 
+Object *object_resolve_type_unambiguous(const char *typename, Error **errp)
+{
+    bool ambig;
+    Object *o = object_resolve_path_type("", typename, &ambig);
+
+    if (ambig) {
+        error_setg(errp, "More than one object of type %s", typename);
+        return NULL;
+    }
+    if (!o) {
+        error_setg(errp, "No object found of type %s", typename);
+        return NULL;
+    }
+    return o;
+}
+
 typedef struct StringProperty
 {
     char *(*get)(Object *, Error **);
-- 
2.43.0


