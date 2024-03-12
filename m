Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D261CC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5tv-0002Ab-0r; Tue, 12 Mar 2024 13:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rk5tr-000271-A4; Tue, 12 Mar 2024 13:26:51 -0400
Received: from wfout4-smtp.messagingengine.com ([64.147.123.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rk5tp-0005Pb-4E; Tue, 12 Mar 2024 13:26:51 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfout.west.internal (Postfix) with ESMTP id 29A2F1C000ED;
 Tue, 12 Mar 2024 13:26:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Tue, 12 Mar 2024 13:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1710264405; x=
 1710350805; bh=CL070b4BGR4o23FsAxR9eeclFDLoEOJMatO1Gas4ulo=; b=L
 p1BqOSizknAziegUa+5tjhfAnwHwfvTcGnGrrTUpm0V7XFr2lWAY+vZAdTfE7uy6
 k4OgdbAMwPsdOFjNpiw89//1+QUETtifHVE6Q1c9JWTumcBTF8en8fmrZCtSAWaB
 W2cEwtpyQNuhy9r4zRBpd8Sc5J7kTDR17Vgq1YL7fTtdslLGsD0rtLwvrBCouvL0
 jx6CV6+2FvQNj8lvl3u64mBt2xA1KG+EjptHQECQK42n9oVa+oWt61/92U5PxuGT
 bnhAqw5xZCC7kKC66s0cI9WIJJQqEKep59t02YOkLLYyRTYz7O7ELsXb5udcHkyz
 Yz5Gw9HidqwzeLUs/Jklg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710264405; x=
 1710350805; bh=CL070b4BGR4o23FsAxR9eeclFDLoEOJMatO1Gas4ulo=; b=T
 Sryep9qtWI13PJQXgIMMdk7xzFUUOBHtvg2MEM6PItGpuVuClRXccd5YUMRCFV7x
 ycA8W4ntpDCU+BtLD7PdnNiNntp0cOCnfAlcmlQAaK++014xuK0xug3J0STF69hK
 58+kidJu6XTEce16PdPONCDB3zPxagdyLvMI7xxKQOS4aO/buIxh+oNSgWEkw58j
 QWFae9aXN+l3wQihZY5AbaqYHGR0tbXVxXDtAWI66hM2ewLMr23gMdLGoPbH+ixS
 CPzVQCY6zipGdsP4nrdK/lK/j1yzYUw5V4QCcs05oJC0brgLLWTQFPB0bQF1J8wx
 AkApJO2WlxBQI8zvl0xHA==
X-ME-Sender: <xms:VZDwZYJu6ChYE6GaDhKyS-fUX3ItN0LDLPoCoAPd_aTlATSUK6hOJg>
 <xme:VZDwZYL1DSIhhwBtfvNYNgTySZAkTH3yPuI8JkFwni8S9Tt2fqEkiE2jEslUB3Tbi
 ZjvBvqUM2Mqwelcqa0>
X-ME-Received: <xmr:VZDwZYusvBF0OgK081MtyAsm1kXr-Yd5VNZ-CL8BKnjc_-j5zEyLYJC8aUrnWMEtVoNeItF1Hg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeefgddutddtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepteeffeffieelheeuvedtieejfeduleejheeigfegtdefhedtuedvgfffgeej
 jeeknecuffhomhgrihhnpehnghhuihgurdgurghtrgenucevlhhushhtvghrufhiiigvpe
 dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:VZDwZVbFYe8-rW4WPBxrVjjF0cWWE2gPbbYsZHTX079M_q403bM29Q>
 <xmx:VZDwZfYNeH-sh9ApnkqRSpswU0iGwFp_0iyHiIOeupVAwkYuOn77EA>
 <xmx:VZDwZRCSV9YR1GcKBff7xPAwScI6aEQi5FZbw0TJvpckZpthabfmoQ>
 <xmx:VZDwZVYi4enUWOuSSCFisPRLM3Q5lm_yYACvH4_R-vBMzQf1QXF7oA>
 <xmx:VZDwZVwFWforWB81B-D4jeLbnznzd1Bl0e1ZraXpY5moeuAXsVLrdsd-YQo>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Mar 2024 13:26:43 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, qemu-block@nongnu.org,
 Yanan Wang <wangyanan55@huawei.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jesper Devantier <foss@defmacro.it>,
 Roque Arcudia Hernandez <roqueh@google.com>,
 Nabih Estefan <nabihestefan@google.com>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL v2 4/6] hw/nvme: Add NVMe NGUID property
Date: Tue, 12 Mar 2024 18:26:27 +0100
Message-ID: <20240312172622.58652-12-its@irrelevant.dk>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240312172622.58652-8-its@irrelevant.dk>
References: <20240312172622.58652-8-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11228; i=k.jensen@samsung.com;
 h=from:subject; bh=if9pvYLcwRx1YNXtDGaMFbOULNcR5Y8rsNcfNn8aV94=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGXwkD8P5IoqhCHIv52aJdfZsMKfcA7xShrcc
 Q3tAN/V597n5okBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJl8JA/AAoJEE3hrzFt
 Tw3peXgH+gITvjbZVMN8rO4ifPGoPKDz2oL2OGYSYweb0EXqeGvDdHF2ltcf09WYTbNUsvT2RYo
 NEXI3MgV5wP0c7fEg8ZyA6gFZsduvcne7kZ447Sn3E8p/Fc00mDWbtMIPguXjgH3QS9Qc7ILko/
 IACxuUYwxW1132g1TZ7VN4ixYgGo+WKMvVJfv6DeU/hz9iOJdVcdlUmtA8+7EFUsdiEGQ49KrVJ
 YXOJn6yeBYW3mdtcNi2N8RFnrJqIb3t/G2uLQ65sDIs/ic2N+SQNd47R4aT2fSteAB2m4vj+l7p
 a0DPeuFkPBfPHSAZ6lFAN4iUkZ/o9VAk3416EmV0Wm45Rjk5oRyhCq50
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.147; envelope-from=its@irrelevant.dk;
 helo=wfout4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 docs/system/devices/nvme.rst |   7 ++
 hw/nvme/ctrl.c               |  12 +++
 hw/nvme/meson.build          |   2 +-
 hw/nvme/nguid.c              | 187 +++++++++++++++++++++++++++++++++++
 hw/nvme/ns.c                 |   2 +
 hw/nvme/nvme.h               |  26 +++--
 6 files changed, 229 insertions(+), 7 deletions(-)
 create mode 100644 hw/nvme/nguid.c

diff --git a/docs/system/devices/nvme.rst b/docs/system/devices/nvme.rst
index 4ea957baed10..d2b1ca96455f 100644
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
index abc0387f2ca8..6c5a2b875da8 100644
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
index 1a6a2ca2f307..7d5caa53c280 100644
--- a/hw/nvme/meson.build
+++ b/hw/nvme/meson.build
@@ -1 +1 @@
-system_ss.add(when: 'CONFIG_NVME_PCI', if_true: files('ctrl.c', 'dif.c', 'ns.c', 'subsys.c'))
+system_ss.add(when: 'CONFIG_NVME_PCI', if_true: files('ctrl.c', 'dif.c', 'ns.c', 'subsys.c', 'nguid.c'))
\ No newline at end of file
diff --git a/hw/nvme/nguid.c b/hw/nvme/nguid.c
new file mode 100644
index 000000000000..829832bd9f41
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
index 0eabcf5cf500..ea8db175dbd1 100644
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
index 5f2ae7b28b9c..392c02942682 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -171,13 +171,27 @@ static const uint8_t nvme_fdp_evf_shifts[FDP_EVT_MAX] = {
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
+    bool      detached;
+    bool      shared;
+    uint32_t  nsid;
+    QemuUUID  uuid;
+    NvmeNGUID nguid;
+    uint64_t  eui64;
+    bool      eui64_default;
 
     uint16_t ms;
     uint8_t  mset;
-- 
2.44.0


