Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1BD4C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 16:17:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFf9-0007lg-TK; Mon, 18 Mar 2024 12:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFf1-0007UL-Br
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:16:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFez-0004iq-Ac
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710778584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0UpINeiZr4GYa2v1+ory0bETtErkm76rqIiPEkMW7hk=;
 b=Mu/97P7ZkNy3/itLygBBAbAvF2euGCoKE70a7qLJqxr+Y++xVZhjg5QjjKXBaQnFgel1/j
 of/GAldTtKrke03kRqJR02iMbW/u8/J2W6JT4dp6p1L1C+5HiqgcEBmcvZXyESCSIRBOC/
 HrF6WG8pwqCsM1c4lP8gpmIPnIfL0+A=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-LNE2yJUqMIiPvbUcz4w4Xg-1; Mon, 18 Mar 2024 12:16:23 -0400
X-MC-Unique: LNE2yJUqMIiPvbUcz4w4Xg-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2d49815c625so21074351fa.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 09:16:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710778581; x=1711383381;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0UpINeiZr4GYa2v1+ory0bETtErkm76rqIiPEkMW7hk=;
 b=nY4CATEj/OL9xyA0Ae/V9x4Gqcy79PlApGLR7JyeBoR+Z9/OPGF2iDu/+CRpws/GUi
 7Wd/8ttGGpylu6dS7NC0O0DRXQq0B4DbPJ+8tnNZv/euwzPGiC/JFjVUtj/OYeGOEAJP
 5VSiUro/Osov1WPctOh6kRzMzwAr129OBWWnhmF+AdCsHrnQu+96P5sSi0GMM2alX4Pv
 TJDZpDo/82i8Tcl04k1BAdddWbV97w0tmjpnAdBlobjTvJfjY9aDAZRpMJDPn6z/Y+Nl
 cZfH8aIe9CWgfLU87niFLrtyp+13/AHB9tuhbSSluaCGUQPubljWEk9131Kai6mDK0zF
 utag==
X-Gm-Message-State: AOJu0YzqYdT4vxSri/eXUVu6MgAW68KUTMo/ejA8UPFg7U1cuDfe+NgN
 Ac62Zbx+mPVDfZlZss9+lTWKpyFKGOnpPmwxKKwdqbaOwW4+ORX72WsizA5gAhgrg2xNsQy+kru
 5a/65dzmdFmPuOBxlW8wPJy94nLWUSlACkRzAaSgDqkpERKVu19+W/ncbbiCI4DwTjTVbe8mI6Q
 TE6Ugxf6addtfd2JG6q3+JSPT61GdhyA==
X-Received: by 2002:a19:384e:0:b0:512:be8e:79da with SMTP id
 d14-20020a19384e000000b00512be8e79damr7842352lfj.8.1710778580681; 
 Mon, 18 Mar 2024 09:16:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFBfMgkYJtQeFmoNU2U2Z8GWGC3q6gqbOry3IEHf5vvAmfLAAuNS0A0lCV9O/6H2fOb3+7UQ==
X-Received: by 2002:a19:384e:0:b0:512:be8e:79da with SMTP id
 d14-20020a19384e000000b00512be8e79damr7842328lfj.8.1710778580073; 
 Mon, 18 Mar 2024 09:16:20 -0700 (PDT)
Received: from redhat.com ([2.52.5.113]) by smtp.gmail.com with ESMTPSA id
 l12-20020a05600c4f0c00b0041409d4841dsm7084394wmq.33.2024.03.18.09.16.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 09:16:19 -0700 (PDT)
Date: Mon, 18 Mar 2024 12:16:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 13/24] smbios: rename/expose structures/bitmaps used by both
 legacy and modern code
Message-ID: <d638a8659b7e957dede0cdc5afa569b733a10da5.1710778506.git.mst@redhat.com>
References: <cover.1710778506.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710778506.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
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

From: Igor Mammedov <imammedo@redhat.com>

As a preparation to move legacy handling into a separate file,
add prefix 'smbios_' to type0/type1/have_binfile_bitmap/have_fields_bitmap
and expose them in smbios.h so that they can be reused in
legacy and modern code.

Doing it as a separate patch to avoid rename cluttering follow-up
patch which will move legacy code into a separate file.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Message-Id: <20240314152302.2324164-11-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/firmware/smbios.h |  16 +++++
 hw/smbios/smbios.c           | 113 ++++++++++++++++-------------------
 2 files changed, 69 insertions(+), 60 deletions(-)

diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
index 0f0dca8f83..05707c6341 100644
--- a/include/hw/firmware/smbios.h
+++ b/include/hw/firmware/smbios.h
@@ -2,6 +2,7 @@
 #define QEMU_SMBIOS_H
 
 #include "qapi/qapi-types-machine.h"
+#include "qemu/bitmap.h"
 
 /*
  * SMBIOS Support
@@ -16,8 +17,23 @@
  *
  */
 
+typedef struct {
+    const char *vendor, *version, *date;
+    bool have_major_minor, uefi;
+    uint8_t major, minor;
+} smbios_type0_t;
+extern smbios_type0_t smbios_type0;
+
+typedef struct {
+    const char *manufacturer, *product, *version, *serial, *sku, *family;
+    /* uuid is in qemu_uuid */
+} smbios_type1_t;
+extern smbios_type1_t smbios_type1;
 
 #define SMBIOS_MAX_TYPE 127
+extern DECLARE_BITMAP(smbios_have_binfile_bitmap, SMBIOS_MAX_TYPE + 1);
+extern DECLARE_BITMAP(smbios_have_fields_bitmap, SMBIOS_MAX_TYPE + 1);
+
 #define offsetofend(TYPE, MEMBER) \
        (offsetof(TYPE, MEMBER) + sizeof_field(TYPE, MEMBER))
 
diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 090a6eb018..6c24fb75d3 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -78,19 +78,11 @@ static int smbios_type4_count = 0;
 static bool smbios_have_defaults;
 static uint32_t smbios_cpuid_version, smbios_cpuid_features;
 
-static DECLARE_BITMAP(have_binfile_bitmap, SMBIOS_MAX_TYPE+1);
-static DECLARE_BITMAP(have_fields_bitmap, SMBIOS_MAX_TYPE+1);
+DECLARE_BITMAP(smbios_have_binfile_bitmap, SMBIOS_MAX_TYPE + 1);
+DECLARE_BITMAP(smbios_have_fields_bitmap, SMBIOS_MAX_TYPE + 1);
 
-static struct {
-    const char *vendor, *version, *date;
-    bool have_major_minor, uefi;
-    uint8_t major, minor;
-} type0;
-
-static struct {
-    const char *manufacturer, *product, *version, *serial, *sku, *family;
-    /* uuid is in qemu_uuid */
-} type1;
+smbios_type0_t smbios_type0;
+smbios_type1_t smbios_type1;
 
 static struct {
     const char *manufacturer, *product, *version, *serial, *asset, *location;
@@ -599,36 +591,36 @@ static void smbios_maybe_add_str(int type, int offset, const char *data)
 static void smbios_build_type_0_fields(void)
 {
     smbios_maybe_add_str(0, offsetof(struct smbios_type_0, vendor_str),
-                         type0.vendor);
+                         smbios_type0.vendor);
     smbios_maybe_add_str(0, offsetof(struct smbios_type_0, bios_version_str),
-                         type0.version);
+                         smbios_type0.version);
     smbios_maybe_add_str(0, offsetof(struct smbios_type_0,
                                      bios_release_date_str),
-                         type0.date);
-    if (type0.have_major_minor) {
+                         smbios_type0.date);
+    if (smbios_type0.have_major_minor) {
         smbios_add_field(0, offsetof(struct smbios_type_0,
                                      system_bios_major_release),
-                         &type0.major, 1);
+                         &smbios_type0.major, 1);
         smbios_add_field(0, offsetof(struct smbios_type_0,
                                      system_bios_minor_release),
-                         &type0.minor, 1);
+                         &smbios_type0.minor, 1);
     }
 }
 
 static void smbios_build_type_1_fields(void)
 {
     smbios_maybe_add_str(1, offsetof(struct smbios_type_1, manufacturer_str),
-                         type1.manufacturer);
+                         smbios_type1.manufacturer);
     smbios_maybe_add_str(1, offsetof(struct smbios_type_1, product_name_str),
-                         type1.product);
+                         smbios_type1.product);
     smbios_maybe_add_str(1, offsetof(struct smbios_type_1, version_str),
-                         type1.version);
+                         smbios_type1.version);
     smbios_maybe_add_str(1, offsetof(struct smbios_type_1, serial_number_str),
-                         type1.serial);
+                         smbios_type1.serial);
     smbios_maybe_add_str(1, offsetof(struct smbios_type_1, sku_number_str),
-                         type1.sku);
+                         smbios_type1.sku);
     smbios_maybe_add_str(1, offsetof(struct smbios_type_1, family_str),
-                         type1.family);
+                         smbios_type1.family);
     if (qemu_uuid_set) {
         /* We don't encode the UUID in the "wire format" here because this
          * function is for legacy mode and needs to keep the guest ABI, and
@@ -646,14 +638,14 @@ uint8_t *smbios_get_table_legacy(size_t *length)
     size_t usr_offset;
 
     /* also complain if fields were given for types > 1 */
-    if (find_next_bit(have_fields_bitmap,
+    if (find_next_bit(smbios_have_fields_bitmap,
                       SMBIOS_MAX_TYPE + 1, 2) < SMBIOS_MAX_TYPE + 1) {
         error_report("can't process fields for smbios "
                      "types > 1 on machine versions < 2.1!");
         exit(1);
     }
 
-    if (test_bit(4, have_binfile_bitmap)) {
+    if (test_bit(4, smbios_have_binfile_bitmap)) {
         error_report("can't process table for smbios "
                      "type 4 on machine versions < 2.1!");
         exit(1);
@@ -694,10 +686,10 @@ uint8_t *smbios_get_table_legacy(size_t *length)
 
 bool smbios_skip_table(uint8_t type, bool required_table)
 {
-    if (test_bit(type, have_binfile_bitmap)) {
+    if (test_bit(type, smbios_have_binfile_bitmap)) {
         return true; /* user provided their own binary blob(s) */
     }
-    if (test_bit(type, have_fields_bitmap)) {
+    if (test_bit(type, smbios_have_fields_bitmap)) {
         return false; /* user provided fields via command line */
     }
     if (smbios_have_defaults && required_table) {
@@ -725,25 +717,25 @@ static void smbios_build_type_0_table(void)
 {
     SMBIOS_BUILD_TABLE_PRE(0, T0_BASE, false); /* optional, leave up to BIOS */
 
-    SMBIOS_TABLE_SET_STR(0, vendor_str, type0.vendor);
-    SMBIOS_TABLE_SET_STR(0, bios_version_str, type0.version);
+    SMBIOS_TABLE_SET_STR(0, vendor_str, smbios_type0.vendor);
+    SMBIOS_TABLE_SET_STR(0, bios_version_str, smbios_type0.version);
 
     t->bios_starting_address_segment = cpu_to_le16(0xE800); /* from SeaBIOS */
 
-    SMBIOS_TABLE_SET_STR(0, bios_release_date_str, type0.date);
+    SMBIOS_TABLE_SET_STR(0, bios_release_date_str, smbios_type0.date);
 
     t->bios_rom_size = 0; /* hardcoded in SeaBIOS with FIXME comment */
 
     t->bios_characteristics = cpu_to_le64(0x08); /* Not supported */
     t->bios_characteristics_extension_bytes[0] = 0;
     t->bios_characteristics_extension_bytes[1] = 0x14; /* TCD/SVVP | VM */
-    if (type0.uefi) {
+    if (smbios_type0.uefi) {
         t->bios_characteristics_extension_bytes[1] |= 0x08; /* |= UEFI */
     }
 
-    if (type0.have_major_minor) {
-        t->system_bios_major_release = type0.major;
-        t->system_bios_minor_release = type0.minor;
+    if (smbios_type0.have_major_minor) {
+        t->system_bios_major_release = smbios_type0.major;
+        t->system_bios_minor_release = smbios_type0.minor;
     } else {
         t->system_bios_major_release = 0;
         t->system_bios_minor_release = 0;
@@ -773,18 +765,18 @@ static void smbios_build_type_1_table(void)
 {
     SMBIOS_BUILD_TABLE_PRE(1, T1_BASE, true); /* required */
 
-    SMBIOS_TABLE_SET_STR(1, manufacturer_str, type1.manufacturer);
-    SMBIOS_TABLE_SET_STR(1, product_name_str, type1.product);
-    SMBIOS_TABLE_SET_STR(1, version_str, type1.version);
-    SMBIOS_TABLE_SET_STR(1, serial_number_str, type1.serial);
+    SMBIOS_TABLE_SET_STR(1, manufacturer_str, smbios_type1.manufacturer);
+    SMBIOS_TABLE_SET_STR(1, product_name_str, smbios_type1.product);
+    SMBIOS_TABLE_SET_STR(1, version_str, smbios_type1.version);
+    SMBIOS_TABLE_SET_STR(1, serial_number_str, smbios_type1.serial);
     if (qemu_uuid_set) {
         smbios_encode_uuid(&t->uuid, &qemu_uuid);
     } else {
         memset(&t->uuid, 0, 16);
     }
     t->wake_up_type = 0x06; /* power switch */
-    SMBIOS_TABLE_SET_STR(1, sku_number_str, type1.sku);
-    SMBIOS_TABLE_SET_STR(1, family_str, type1.family);
+    SMBIOS_TABLE_SET_STR(1, sku_number_str, smbios_type1.sku);
+    SMBIOS_TABLE_SET_STR(1, family_str, smbios_type1.family);
 
     SMBIOS_BUILD_TABLE_POST;
 }
@@ -1178,9 +1170,9 @@ void smbios_set_defaults(const char *manufacturer, const char *product,
     smbios_uuid_encoded = uuid_encoded;
     smbios_ep_type = ep_type;
 
-    SMBIOS_SET_DEFAULT(type1.manufacturer, manufacturer);
-    SMBIOS_SET_DEFAULT(type1.product, product);
-    SMBIOS_SET_DEFAULT(type1.version, version);
+    SMBIOS_SET_DEFAULT(smbios_type1.manufacturer, manufacturer);
+    SMBIOS_SET_DEFAULT(smbios_type1.product, product);
+    SMBIOS_SET_DEFAULT(smbios_type1.version, version);
     SMBIOS_SET_DEFAULT(type2.manufacturer, manufacturer);
     SMBIOS_SET_DEFAULT(type2.product, product);
     SMBIOS_SET_DEFAULT(type2.version, version);
@@ -1453,13 +1445,13 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
         }
 
         if (header->type <= SMBIOS_MAX_TYPE) {
-            if (test_bit(header->type, have_fields_bitmap)) {
+            if (test_bit(header->type, smbios_have_fields_bitmap)) {
                 error_setg(errp,
                            "can't load type %d struct, fields already specified!",
                            header->type);
                 return;
             }
-            set_bit(header->type, have_binfile_bitmap);
+            set_bit(header->type, smbios_have_binfile_bitmap);
         }
 
         if (header->type == 4) {
@@ -1490,41 +1482,42 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
             return;
         }
 
-        if (test_bit(type, have_binfile_bitmap)) {
+        if (test_bit(type, smbios_have_binfile_bitmap)) {
             error_setg(errp, "can't add fields, binary file already loaded!");
             return;
         }
-        set_bit(type, have_fields_bitmap);
+        set_bit(type, smbios_have_fields_bitmap);
 
         switch (type) {
         case 0:
             if (!qemu_opts_validate(opts, qemu_smbios_type0_opts, errp)) {
                 return;
             }
-            save_opt(&type0.vendor, opts, "vendor");
-            save_opt(&type0.version, opts, "version");
-            save_opt(&type0.date, opts, "date");
-            type0.uefi = qemu_opt_get_bool(opts, "uefi", false);
+            save_opt(&smbios_type0.vendor, opts, "vendor");
+            save_opt(&smbios_type0.version, opts, "version");
+            save_opt(&smbios_type0.date, opts, "date");
+            smbios_type0.uefi = qemu_opt_get_bool(opts, "uefi", false);
 
             val = qemu_opt_get(opts, "release");
             if (val) {
-                if (sscanf(val, "%hhu.%hhu", &type0.major, &type0.minor) != 2) {
+                if (sscanf(val, "%hhu.%hhu", &smbios_type0.major,
+                           &smbios_type0.minor) != 2) {
                     error_setg(errp, "Invalid release");
                     return;
                 }
-                type0.have_major_minor = true;
+                smbios_type0.have_major_minor = true;
             }
             return;
         case 1:
             if (!qemu_opts_validate(opts, qemu_smbios_type1_opts, errp)) {
                 return;
             }
-            save_opt(&type1.manufacturer, opts, "manufacturer");
-            save_opt(&type1.product, opts, "product");
-            save_opt(&type1.version, opts, "version");
-            save_opt(&type1.serial, opts, "serial");
-            save_opt(&type1.sku, opts, "sku");
-            save_opt(&type1.family, opts, "family");
+            save_opt(&smbios_type1.manufacturer, opts, "manufacturer");
+            save_opt(&smbios_type1.product, opts, "product");
+            save_opt(&smbios_type1.version, opts, "version");
+            save_opt(&smbios_type1.serial, opts, "serial");
+            save_opt(&smbios_type1.sku, opts, "sku");
+            save_opt(&smbios_type1.family, opts, "family");
 
             val = qemu_opt_get(opts, "uuid");
             if (val) {
-- 
MST


