Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A25F4C54791
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 17:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdDDL-0006Bd-TJ; Thu, 22 Feb 2024 12:50:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3XInXZQwKCgMqdelkhvwhidqjrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--nabihestefan.bounces.google.com>)
 id 1rdDDK-0006BC-AE
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 12:50:30 -0500
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3XInXZQwKCgMqdelkhvwhidqjrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--nabihestefan.bounces.google.com>)
 id 1rdDDD-0007Sd-Fp
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 12:50:30 -0500
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-dc746178515so13504859276.2
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 09:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1708624220; x=1709229020; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=LueTBrn10xvm+lVAkcFB2OSZMmUZgwWRd9xnLt2YrxE=;
 b=hlOqx85eav1H4GmGLjjtkFHjUe6vU1ifYaRyogj238nZuJFQ05XldHh8z5H28L6njA
 5oZJP/MlgKc69yNpR26AU2n0eJ7euQZSMtn1eFBvH7vGDvWa2F0bl/VmAWwe3wj8b8Lq
 +IDQ8ZzgEzJDT97pB3GMW/ydmPHloVrjEx2S0NSrJCE4EVVbbYepEWNbsJqfQCwYwR/C
 0T1y+hdYPH4TIxhVs8G/0Ahcd+JJ5+D0cO5dnIMWXuJHk8mPT3YuFPX63QjRZInqRzuJ
 iUWw3su83UfY0mNu0/G3gFaBk1V21G1DpTJrNLGgHMFHZOVV4qBhikcwQe4cp56/WB90
 esFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708624220; x=1709229020;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LueTBrn10xvm+lVAkcFB2OSZMmUZgwWRd9xnLt2YrxE=;
 b=WPIqlGfWYXtMO/+ub8E8flwm3rBPIx9TuFQ6jwFRJJWp1Mmt2/r+9lN2aRIWxy9HYC
 von1PmgUdBNZ9jgBVFdrmiqym1+y69aeadj5YFlblYZA/O46g7wzvjJRePOWoa2amrZa
 W7LottaDzYFICqTnc4WxxyYMtrav7zZNu0It0QFbqIJrKZTFU+E2wwLpM4Ppf4Fx7HR2
 9gZoCW5KEf7+GuAu/jk8pzZlrW8EqecEQ3wuLx+BbujbD2g3QWSjUJdH3t8gMKq9VKUX
 S/lkKh0tF9fVt/65tQBF1M/i8oFjaUvdqBf5MBJfCkP7Dtkov+OrqEdYAvZS1WGQVETo
 gvgg==
X-Gm-Message-State: AOJu0YyI7gVu+b1fkAmzhREoVTZg/TJtlbInqSgUx0CLSPXF5zcvzyMY
 M8aedkxhgnuHg434yCPaYaCSAIE1yAAClUM7VM5d0f071HdOfQDFjO6loBPQ7avalQEH7nH0HqO
 KFK9+BqH+TICvXY3hKQcgldh1uw==
X-Google-Smtp-Source: AGHT+IH7NCpDZobl8RYC33d9pWQwcel6GxPqACLwtGB7Z4vYkNbhO94AHUkBVLcbTkb/Dx7wFtJlp52xFFaT/ndna+0=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a25:7c86:0:b0:dcd:ac69:eb1a with SMTP
 id x128-20020a257c86000000b00dcdac69eb1amr748933ybc.12.1708624220276; Thu, 22
 Feb 2024 09:50:20 -0800 (PST)
Date: Thu, 22 Feb 2024 17:50:16 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240222175017.2200940-1-nabihestefan@google.com>
Subject: [PATCH v2] hw/nvme/ns: Add NVMe NGUID property
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kbusch@kernel.org, 
 its@irrelevant.dk, roqueh@google.com, nabihestefan@google.com, 
 Klaus Jensen <k.jensen@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3XInXZQwKCgMqdelkhvwhidqjrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--nabihestefan.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

From: Roque Arcudia Hernandez <roqueh@google.com>

This patch adds a way to specify an NGUID for a given NVMe Namespace using a
string of hexadecimal digits with an optional '-' separator to group bytes. For
instance:

-device nvme-ns,nguid="e9accd3b83904e13167cf0593437f57d"

If provided, the NGUID will be part of the Namespace Identification Descriptor
list and the Identify Namespace data.

Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
Signed-off-by: Nabih Estefan <nabihestefan@google.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
---
 docs/system/devices/nvme.rst |   7 ++
 hw/nvme/ctrl.c               |  12 +++
 hw/nvme/meson.build          |   2 +-
 hw/nvme/nguid.c              | 187 +++++++++++++++++++++++++++++++++++
 hw/nvme/ns.c                 |   2 +
 hw/nvme/nvme.h               |  70 +++++++------
 6 files changed, 251 insertions(+), 29 deletions(-)
 create mode 100644 hw/nvme/nguid.c

diff --git a/docs/system/devices/nvme.rst b/docs/system/devices/nvme.rst
index 4ea957baed..d2b1ca9645 100644
--- a/docs/system/devices/nvme.rst
+++ b/docs/system/devices/nvme.rst
@@ -81,6 +81,13 @@ There are a number of parameters available:
   Set the UUID of the namespace. This will be reported as a "Namespace UUID"
   descriptor in the Namespace Identification Descriptor List.
 
+``nguid``
+  Set the NGUID of the namespace. This will be reported as a "Namespace Globally
+  Unique Identifier" descriptor in the Namespace Identification Descriptor List.
+  It is specified as a string of hexadecimal digits containing exactly 16 bytes
+  or "auto" for a random value. An optional '-' separator could be used to group
+  bytes. If not specified the NGUID will remain all zeros.
+
 ``eui64``
   Set the EUI-64 of the namespace. This will be reported as a "IEEE Extended
   Unique Identifier" descriptor in the Namespace Identification Descriptor List.
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index f026245d1e..a2dc990dc1 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -5640,6 +5640,10 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
         NvmeIdNsDescr hdr;
         uint8_t v[NVME_NIDL_UUID];
     } QEMU_PACKED uuid = {};
+    struct {
+        NvmeIdNsDescr hdr;
+        uint8_t v[NVME_NIDL_NGUID];
+    } QEMU_PACKED nguid = {};
     struct {
         NvmeIdNsDescr hdr;
         uint64_t v;
@@ -5668,6 +5672,14 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
         pos += sizeof(uuid);
     }
 
+    if (!nvme_nguid_is_null(&ns->params.nguid)) {
+        nguid.hdr.nidt = NVME_NIDT_NGUID;
+        nguid.hdr.nidl = NVME_NIDL_NGUID;
+        memcpy(nguid.v, ns->params.nguid.data, NVME_NIDL_NGUID);
+        memcpy(pos, &nguid, sizeof(nguid));
+        pos += sizeof(nguid);
+    }
+
     if (ns->params.eui64) {
         eui64.hdr.nidt = NVME_NIDT_EUI64;
         eui64.hdr.nidl = NVME_NIDL_EUI64;
diff --git a/hw/nvme/meson.build b/hw/nvme/meson.build
index 1a6a2ca2f3..7d5caa53c2 100644
--- a/hw/nvme/meson.build
+++ b/hw/nvme/meson.build
@@ -1 +1 @@
-system_ss.add(when: 'CONFIG_NVME_PCI', if_true: files('ctrl.c', 'dif.c', 'ns.c', 'subsys.c'))
+system_ss.add(when: 'CONFIG_NVME_PCI', if_true: files('ctrl.c', 'dif.c', 'ns.c', 'subsys.c', 'nguid.c'))
\ No newline at end of file
diff --git a/hw/nvme/nguid.c b/hw/nvme/nguid.c
new file mode 100644
index 0000000000..829832bd9f
--- /dev/null
+++ b/hw/nvme/nguid.c
@@ -0,0 +1,187 @@
+/*
+ *  QEMU NVMe NGUID functions
+ *
+ * Copyright 2024 Google LLC
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ * for more details.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/visitor.h"
+#include "qemu/ctype.h"
+#include "nvme.h"
+
+#define NGUID_SEPARATOR '-'
+
+#define NGUID_VALUE_AUTO "auto"
+
+#define NGUID_FMT              \
+    "%02hhx%02hhx%02hhx%02hhx" \
+    "%02hhx%02hhx%02hhx%02hhx" \
+    "%02hhx%02hhx%02hhx%02hhx" \
+    "%02hhx%02hhx%02hhx%02hhx"
+
+#define NGUID_STR_LEN (2 * NGUID_LEN + 1)
+
+bool nvme_nguid_is_null(const NvmeNGUID *nguid)
+{
+    static NvmeNGUID null_nguid;
+    return memcmp(nguid, &null_nguid, sizeof(NvmeNGUID)) == 0;
+}
+
+static void nvme_nguid_generate(NvmeNGUID *out)
+{
+    int i;
+    uint32_t x;
+
+    QEMU_BUILD_BUG_ON((NGUID_LEN % sizeof(x)) != 0);
+
+    for (i = 0; i < NGUID_LEN; i += sizeof(x)) {
+        x = g_random_int();
+        memcpy(&out->data[i], &x, sizeof(x));
+    }
+}
+
+/*
+ * The Linux Kernel typically prints the NGUID of an NVMe namespace using the
+ * same format as the UUID. For instance:
+ *
+ * $ cat /sys/class/block/nvme0n1/nguid
+ * e9accd3b-8390-4e13-167c-f0593437f57d
+ *
+ * When there is no UUID but there is NGUID the Kernel will print the NGUID as
+ * wwid and it won't use the UUID format:
+ *
+ * $ cat /sys/class/block/nvme0n1/wwid
+ * eui.e9accd3b83904e13167cf0593437f57d
+ *
+ * The NGUID has different fields compared to the UUID, so the grouping used in
+ * the UUID format has no relation with the 3 fields of the NGUID.
+ *
+ * This implementation won't expect a strict format as the UUID one and instead
+ * it will admit any string of hexadecimal digits. Byte groups could be created
+ * using the '-' separator. The number of bytes needs to be exactly 16 and the
+ * separator '-' has to be exactly in a byte boundary. The following are
+ * examples of accepted formats for the NGUID string:
+ *
+ * nguid="e9accd3b-8390-4e13-167c-f0593437f57d"
+ * nguid="e9accd3b83904e13167cf0593437f57d"
+ * nguid="FEDCBA9876543210-ABCDEF-0123456789"
+ */
+static bool nvme_nguid_is_valid(const char *str)
+{
+    int i;
+    int digit_count = 0;
+
+    for (i = 0; i < strlen(str); i++) {
+        const char c = str[i];
+        if (qemu_isxdigit(c)) {
+            digit_count++;
+            continue;
+        }
+        if (c == NGUID_SEPARATOR) {
+            /*
+             * We need to make sure the separator is in a byte boundary, the
+             * string does not start with the separator and they are not back to
+             * back "--".
+             */
+            if ((i > 0) && (str[i - 1] != NGUID_SEPARATOR) &&
+                (digit_count % 2) == 0) {
+                continue;
+            }
+        }
+        return false;
+    }
+    /*
+     * The string should have the correct byte length and not finish with the
+     * separator
+     */
+    return (digit_count == (2 * NGUID_LEN)) && (str[i - 1] != NGUID_SEPARATOR);
+}
+
+static int nvme_nguid_parse(const char *str, NvmeNGUID *nguid)
+{
+    uint8_t *id = &nguid->data[0];
+    int ret = 0;
+    int i;
+    const char *ptr = str;
+
+    if (!nvme_nguid_is_valid(str)) {
+        return -1;
+    }
+
+    for (i = 0; i < NGUID_LEN; i++) {
+        ret = sscanf(ptr, "%02hhx", &id[i]);
+        if (ret != 1) {
+            return -1;
+        }
+        ptr += 2;
+        if (*ptr == NGUID_SEPARATOR) {
+            ptr++;
+        }
+    }
+
+    return 0;
+}
+
+/*
+ * When converted back to string this implementation will use a raw hex number
+ * with no separators, for instance:
+ *
+ * "e9accd3b83904e13167cf0593437f57d"
+ */
+static void nvme_nguid_stringify(const NvmeNGUID *nguid, char *out)
+{
+    const uint8_t *id = &nguid->data[0];
+    snprintf(out, NGUID_STR_LEN, NGUID_FMT,
+             id[0], id[1], id[2], id[3], id[4], id[5], id[6], id[7],
+             id[8], id[9], id[10], id[11], id[12], id[13], id[14], id[15]);
+}
+
+static void get_nguid(Object *obj, Visitor *v, const char *name, void *opaque,
+                      Error **errp)
+{
+    Property *prop = opaque;
+    NvmeNGUID *nguid = object_field_prop_ptr(obj, prop);
+    char buffer[NGUID_STR_LEN];
+    char *p = buffer;
+
+    nvme_nguid_stringify(nguid, buffer);
+
+    visit_type_str(v, name, &p, errp);
+}
+
+static void set_nguid(Object *obj, Visitor *v, const char *name, void *opaque,
+                      Error **errp)
+{
+    Property *prop = opaque;
+    NvmeNGUID *nguid = object_field_prop_ptr(obj, prop);
+    char *str;
+
+    if (!visit_type_str(v, name, &str, errp)) {
+        return;
+    }
+
+    if (!strcmp(str, NGUID_VALUE_AUTO)) {
+        nvme_nguid_generate(nguid);
+    } else if (nvme_nguid_parse(str, nguid) < 0) {
+        error_set_from_qdev_prop_error(errp, EINVAL, obj, name, str);
+    }
+    g_free(str);
+}
+
+const PropertyInfo qdev_prop_nguid = {
+    .name  = "str",
+    .description =
+        "NGUID or \"" NGUID_VALUE_AUTO "\" for random value",
+    .get   = get_nguid,
+    .set   = set_nguid,
+};
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 0eabcf5cf5..ea8db175db 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -89,6 +89,7 @@ static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
     id_ns->mcl = cpu_to_le32(ns->params.mcl);
     id_ns->msrc = ns->params.msrc;
     id_ns->eui64 = cpu_to_be64(ns->params.eui64);
+    memcpy(&id_ns->nguid, &ns->params.nguid.data, sizeof(id_ns->nguid));
 
     ds = 31 - clz32(ns->blkconf.logical_block_size);
     ms = ns->params.ms;
@@ -797,6 +798,7 @@ static Property nvme_ns_props[] = {
     DEFINE_PROP_BOOL("shared", NvmeNamespace, params.shared, true),
     DEFINE_PROP_UINT32("nsid", NvmeNamespace, params.nsid, 0),
     DEFINE_PROP_UUID_NODEFAULT("uuid", NvmeNamespace, params.uuid),
+    DEFINE_PROP_NGUID_NODEFAULT("nguid", NvmeNamespace, params.nguid),
     DEFINE_PROP_UINT64("eui64", NvmeNamespace, params.eui64, 0),
     DEFINE_PROP_UINT16("ms", NvmeNamespace, params.ms, 0),
     DEFINE_PROP_UINT8("mset", NvmeNamespace, params.mset, 0),
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 5f2ae7b28b..b9baaf612d 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -171,35 +171,49 @@ static const uint8_t nvme_fdp_evf_shifts[FDP_EVT_MAX] = {
     [FDP_EVT_RUH_IMPLICIT_RU_CHANGE]    = 33,
 };
 
+#define NGUID_LEN 16
+
+typedef struct {
+    uint8_t data[NGUID_LEN];
+} NvmeNGUID;
+
+bool nvme_nguid_is_null(const NvmeNGUID *nguid);
+
+extern const PropertyInfo qdev_prop_nguid;
+
+#define DEFINE_PROP_NGUID_NODEFAULT(_name, _state, _field) \
+    DEFINE_PROP(_name, _state, _field, qdev_prop_nguid, NvmeNGUID)
+
 typedef struct NvmeNamespaceParams {
-    bool     detached;
-    bool     shared;
-    uint32_t nsid;
-    QemuUUID uuid;
-    uint64_t eui64;
-    bool     eui64_default;
-
-    uint16_t ms;
-    uint8_t  mset;
-    uint8_t  pi;
-    uint8_t  pil;
-    uint8_t  pif;
-
-    uint16_t mssrl;
-    uint32_t mcl;
-    uint8_t  msrc;
-
-    bool     zoned;
-    bool     cross_zone_read;
-    uint64_t zone_size_bs;
-    uint64_t zone_cap_bs;
-    uint32_t max_active_zones;
-    uint32_t max_open_zones;
-    uint32_t zd_extension_size;
-
-    uint32_t numzrwa;
-    uint64_t zrwas;
-    uint64_t zrwafg;
+    bool      detached;
+    bool      shared;
+    uint32_t  nsid;
+    QemuUUID  uuid;
+    NvmeNGUID nguid;
+    uint64_t  eui64;
+    bool      eui64_default;
+
+    uint16_t  ms;
+    uint8_t   mset;
+    uint8_t   pi;
+    uint8_t   pil;
+    uint8_t   pif;
+
+    uint16_t  mssrl;
+    uint32_t  mcl;
+    uint8_t   msrc;
+
+    bool      zoned;
+    bool      cross_zone_read;
+    uint64_t  zone_size_bs;
+    uint64_t  zone_cap_bs;
+    uint32_t  max_active_zones;
+    uint32_t  max_open_zones;
+    uint32_t  zd_extension_size;
+
+    uint32_t  numzrwa;
+    uint64_t  zrwas;
+    uint64_t  zrwafg;
 
     struct {
         char *ruhs;
-- 
2.44.0.rc0.258.g7320e95886-goog


