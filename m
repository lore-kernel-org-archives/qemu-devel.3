Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF56C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 19:45:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhEFF-0005q0-AM; Mon, 04 Mar 2024 14:45:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rhEEq-0005dI-MJ
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 14:44:42 -0500
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rhEEp-0006z9-2Z
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 14:44:40 -0500
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-db4364ecd6aso5048718276.2
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 11:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709581476; x=1710186276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TKU7EMmrCEGIbEXLnUmzxmQlpe4p33ksgB+5YiuAYXs=;
 b=ApR0SxyZ0y2x1m+wVRGfSeaCxU2+FrFRRXht3z2fEsAbauv5juhk0ly4XIPvFjHYT6
 NgJPcbiwEnYPrpAZiSpz11fpbj+6nxInqXzjh4Qcq15qhactaA+/oENfVzitSGUZ9XFI
 VE93BTDDDLSyEB1LZW9UoNHun4JXEaoNAd5peBs5RhTO3Kb1WOsa0ZQhrAKxj25APGs7
 ZIh1ps5odkXwXPdnYF3bsg77hv4+3iMVIKZLr95m+szK8P3W2Ptzg16Uf5LRnLzv4cTz
 y6Mo/fQs+wKelU5tzL6GaOFDIY1EzCp3TnpwK3xOy6DkWcMfzS8IlrZRU5Bxt94iSg3Q
 xGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709581476; x=1710186276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TKU7EMmrCEGIbEXLnUmzxmQlpe4p33ksgB+5YiuAYXs=;
 b=JS69OqcJC6bN25s+krw2ODMlgxh5fJR4tdbOrtHpsU+MvmKzsjGQT7iWgHO92oGLuy
 8xqhDWOjUaK3UU8KlHG4IETiK8DvPjt5Rkf4NNV8kAJc/Ni/IA6phBdVGVzrAu5lkNaz
 +0AL0EqErEA2ynwJe31n/8PpAV10OGMtFAsjNAKs61N5pwmMthmZaTYPcrv1F+0whlLM
 rc87ZAICRrdt8OLHkLkGqe73ymc59GHNJ2hjWCTe8/wP1PSxTh8zAQhSJ6iLua3q0/mQ
 QZ9j3O1/mwAzC7WCIipxaLAOCjYaD2yN82dyT0VAjHzKo6/J1xvWRCU+MlP+uZSqCRd4
 2+tg==
X-Gm-Message-State: AOJu0Yy2y6214AiK4MxPWQpD16ifDBQXMfNyvsfnF4NP/AfFD4GR/NIo
 SLM/M8XmBppDzSoTJ7tf4Lw4W62cWsz5hS5FGvfFpFRR5rc2f7yBxiesTBxl
X-Google-Smtp-Source: AGHT+IGJaenBrz1oSac79n8j93VzbYMt0qiN1tC/RpBnCVT3yoX1a0NYTi0pRDY7jv1mKlEMaKgrEw==
X-Received: by 2002:a25:2690:0:b0:dc6:ff12:13d7 with SMTP id
 m138-20020a252690000000b00dc6ff1213d7mr5343408ybm.60.1709581476386; 
 Mon, 04 Mar 2024 11:44:36 -0800 (PST)
Received: from localhost.localdomain ([50.205.20.42])
 by smtp.gmail.com with ESMTPSA id
 h1-20020a255f41000000b00dc62edd58dasm2282646ybm.40.2024.03.04.11.44.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 11:44:36 -0800 (PST)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 nifan.cxl@gmail.com, jim.harris@samsung.com, Jorgen.Hansen@wdc.com,
 wj28.lee@gmail.com, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v5 13/13] qapi/cxl.json: Add QMP interfaces to print out
 accepted and pending DC extents
Date: Mon,  4 Mar 2024 11:34:08 -0800
Message-ID: <20240304194331.1586191-14-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304194331.1586191-1-nifan.cxl@gmail.com>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=nifan.cxl@gmail.com; helo=mail-yb1-xb36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Fan Ni <fan.ni@samsung.com>

With the change, we add the following two QMP interfaces to print out
extents information in the device,
1. cxl-display-accepted-dc-extents: print out the accepted DC extents in
   the device;
2. cxl-display-pending-to-add-dc-extents: print out the pending-to-add
   DC extents in the device;
The output is appended to a file passed to the command and by default
it is /tmp/dc-extent.txt.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/mem/cxl_type3.c       | 80 ++++++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3_stubs.c | 12 ++++++
 qapi/cxl.json            | 32 ++++++++++++++++
 3 files changed, 124 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 5bd64e604e..6a08e7ae40 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -2089,6 +2089,86 @@ void qmp_cxl_release_dynamic_capacity(const char *path, uint8_t region_id,
                                      region_id, records, errp);
 }
 
+static void cxl_dcd_display_extent_list(const CXLType3Dev *dcd, const char *f,
+                                        bool accepted_list, Error **errp)
+{
+    const CXLDCExtentList *list;
+    CXLDCExtent *ent;
+    FILE *fp = NULL;
+    int i = 0;
+
+    if (!dcd->dc.num_regions) {
+        error_setg(errp, "No dynamic capacity support from the device");
+        return;
+    }
+
+    if (!f) {
+        fp = fopen("/tmp/dc-extent.txt", "a+");
+    } else {
+        fp = fopen(f, "a+");
+    }
+
+    if (!fp) {
+        error_setg(errp, "Open log file failed");
+        return;
+    }
+    if (accepted_list) {
+        list = &dcd->dc.extents;
+        fprintf(fp, "Print accepted extent info:\n");
+    } else {
+        list = &dcd->dc.extents_pending_to_add;
+        fprintf(fp, "Print pending-to-add extent info:\n");
+    }
+
+    QTAILQ_FOREACH(ent, list, node) {
+        fprintf(fp, "%d: [0x%lx - 0x%lx]\n", i++, ent->start_dpa,
+                               ent->start_dpa + ent->len);
+    }
+    fprintf(fp, "In total, %d extents printed!\n", i);
+    fclose(fp);
+}
+
+void qmp_cxl_display_accepted_dc_extents(const char *path, const char *f,
+                                         Error **errp)
+{
+    Object *obj;
+    CXLType3Dev *dcd;
+
+    obj = object_resolve_path(path, NULL);
+    if (!obj) {
+        error_setg(errp, "Unable to resolve path");
+        return;
+    }
+    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
+        error_setg(errp, "Path not point to a valid CXL type3 device");
+        return;
+    }
+
+    dcd = CXL_TYPE3(obj);
+    cxl_dcd_display_extent_list(dcd, f, true, errp);
+}
+
+void qmp_cxl_display_pending_to_add_dc_extents(const char *path, const char *f,
+                                               Error **errp)
+{
+    Object *obj;
+    CXLType3Dev *dcd;
+
+    obj = object_resolve_path(path, NULL);
+    if (!obj) {
+        error_setg(errp, "Unable to resolve path");
+        return;
+    }
+    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
+        error_setg(errp, "Path not point to a valid CXL type3 device");
+        return;
+    }
+
+
+    dcd = CXL_TYPE3(obj);
+    cxl_dcd_display_extent_list(dcd, f, false, errp);
+}
+
 static void ct3_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index d913b11b4d..d896758301 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -81,3 +81,15 @@ void qmp_cxl_release_dynamic_capacity(const char *path, uint8_t region_id,
 {
     error_setg(errp, "CXL Type 3 support is not compiled in");
 }
+
+void qmp_cxl_display_accepted_dc_extents(const char *path, const char *f,
+                                         Error **errp)
+{
+    error_setg(errp, "CXL Type 3 support is not compiled in");
+}
+
+void qmp_cxl_display_pending_to_add_dc_extents(const char *path, const char *f,
+                                               Error **errp)
+{
+    error_setg(errp, "CXL Type 3 support is not compiled in");
+}
diff --git a/qapi/cxl.json b/qapi/cxl.json
index 2645004666..6f10300ec6 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -420,3 +420,35 @@
             'extents': [ 'CXLDCExtentRecord' ]
            }
 }
+
+##
+# @cxl-display-accepted-dc-extents:
+#
+# Command to print out all the accepted DC extents in the device
+#
+# @path: CXL DCD canonical QOM path
+# @output: path of output file to dump the results to
+#
+# Since : 9.0
+##
+{ 'command': 'cxl-display-accepted-dc-extents',
+  'data': { 'path': 'str',
+            'output': 'str'
+           }
+}
+
+##
+# @cxl-display-pending-to-add-dc-extents:
+#
+# Command to print out all the pending-to-add DC extents in the device
+#
+# @path: CXL DCD canonical QOM path
+# @output: path of output file to dump the results to
+#
+# Since : 9.0
+##
+{ 'command': 'cxl-display-pending-to-add-dc-extents',
+  'data': { 'path': 'str',
+            'output': 'str'
+           }
+}
-- 
2.43.0


