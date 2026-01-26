Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165CAD1950F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 17:47:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkQco-0001PO-GY; Mon, 26 Jan 2026 12:43:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQch-0001K3-TG
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:36 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQcf-0008UH-5m
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:34 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47edd6111b4so55278895e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 09:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769449408; x=1770054208; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MEJ+cQW0XDvgt8fKdFK82Ac1+oKK3ySwvUaxyxGmSvw=;
 b=Cwl5DC09tNLdo2NzTslCeubd4bfJzL0utdd0OfGSmUkc2jo0JCsrsOyKrB6k/zeyFd
 WcfleRhMlt2MBJvgTY3cytEnSc2SSYVC5RcgFUkE3T8TKpvdzryPG5/ceug/zT8crWEg
 1rXbWRwzqEZEzqCV4smcsWXfs1yFa+vmEnbr2n+Bj6sIsTdwT4FxzIWHCnV3sBH8LyZX
 lXNqEc82bEezfO4FSxGQ4XyzqbIHY0kLut3FJlOLKJarSvJvTqjRqjBH8p9ZKHG7Ww9d
 EKBdCAtjALiOPj1lEVQsVV/c5MSRcjowUjWHvEUufWukHlsZUfNIjk9snB35zLMTtMB3
 vjlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769449408; x=1770054208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MEJ+cQW0XDvgt8fKdFK82Ac1+oKK3ySwvUaxyxGmSvw=;
 b=hlqAgTIznClaH3EyrluOetJrzPhqjQ/FCwdIEMOUaBrerFbwlB0fgT7VbWNMd8+bN1
 1uqdpvxuBiRrA5/t3HtE47c6MxAcW6bPsq2VQsb69k3X0ESN5LRK+ToBe8sFbjIQs85A
 4uc0NLgSzTf5IxA2Gisu26mmN5vK/05XamTe+3IDUd9OY53kM/jJuDTL4DFaoTFp7Ne/
 hXbUuyVkerltS/wFrDCTl2+ssKzDey4l1QA8/rnf/HDGnwIliC0DiIi4P2QqEzH60LF6
 c0L/FE0gQd/C6wLI3HNNXvUyr4o/FKjql235uWWrxfIaLSlrWnebN0tv0NAw0n84KMKq
 MX/w==
X-Gm-Message-State: AOJu0YzR7SPkizwawc6IULxwT4KXMXZgDOBshScGOcmPvIeSFLaqAJAQ
 TTHUTCUzC9dalaDivM44SQB/PMUhuzb9tqMutftavbuDXPfkhSyuZXSjJ4xJaxI8
X-Gm-Gg: AZuq6aKpElCUInQ9R1BMnVWS/g5MnCFPbMXjq42APNj71qs2cT98QneOmxNHtH+zJ96
 aeb4I1EWrq6kScSAcFOAipXmdqPIUBOWT/UalGrGSzu7KWvS4uhKaIVad/S7/kg2dwyVz+t0iQl
 3pHA3vEIMJt8gOUULXT1+rmV2euCn2A825gfPS7wGyXLqns+XA9Mfwp06PDMA7DvCOIA/WIOXLN
 FAR1pcvw3214n2zAaYhJ1kH2Sdh5i+XBCDEB+38eL14cQBCF7v1bB4PT3y7UEGwe7kiuUJzl4N4
 RgvoVoK2unrqlUz2VKQFbhImZ6YJwIkc4SKTi00kDD19fyaob2gAixK4KrLg7d9tiiYWt6TdOOY
 LyGbRVAc7vmZrJpnJUrvISiWnAX6gUHUZI1Iqa0QN3dcJ2tgDkiyPw9wcZKY3bvUdO/Cr9/ja05
 f8RBLsQhXhXtqyznci3iOVyLBk6d3+8k39OX2Zg7WVToMyyPBPWbMz/A==
X-Received: by 2002:a05:600c:444c:b0:46e:35a0:3587 with SMTP id
 5b1f17b1804b1-4805cf6762bmr88468335e9.27.1769449408239; 
 Mon, 26 Jan 2026 09:43:28 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-71-105.adsl.net.t-com.hr.
 [93.143.71.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71730sm34199603f8f.26.2026.01.26.09.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 09:43:27 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com
Subject: [PATCH 04/27] hw/core: introduce generic FDT device model registry
Date: Mon, 26 Jan 2026 18:42:50 +0100
Message-ID: <20260126174313.1418150-5-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
References: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Introduce infrastructure to instantiate device models
directly from the device tree.

This includes the registry of known device models with
associated init functions and key API methods to
operate it.

The MIT license of fdt_generic.c preserved as in original
file from https://github.com/Xilinx/qemu.git repo.

The license for fdt_generic.h derived from matching
fdt_generic.c file.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/fdt_generic.c         | 139 ++++++++++++++++++++++++++++++++++
 include/hw/core/fdt_generic.h |  78 +++++++++++++++++++
 2 files changed, 217 insertions(+)
 create mode 100644 hw/core/fdt_generic.c
 create mode 100644 include/hw/core/fdt_generic.h

diff --git a/hw/core/fdt_generic.c b/hw/core/fdt_generic.c
new file mode 100644
index 0000000000..d3ab8f9132
--- /dev/null
+++ b/hw/core/fdt_generic.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Tables of FDT device models and their init functions. Keyed by compatibility
+ * strings, device instance names.
+ *
+ * Copyright (c) 2010 PetaLogix Qld Pty Ltd.
+ * Copyright (c) 2010 Peter A. G. Crosthwaite <peter.crosthwaite@petalogix.com>.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/fdt_generic.h"
+#include "hw/core/qdev-properties.h"
+#include "qemu/log.h"
+
+#ifndef FDT_GENERIC_ERR_DEBUG
+#define FDT_GENERIC_ERR_DEBUG 0
+#endif
+#define DB_PRINT(lvl, ...) do { \
+    if (FDT_GENERIC_ERR_DEBUG > (lvl)) { \
+        qemu_log_mask(LOG_FDT, ": %s: ", __func__); \
+        qemu_log_mask(LOG_FDT, ## __VA_ARGS__); \
+    } \
+} while (0)
+
+#define FDT_GENERIC_MAX_PATTERN_LEN 1024
+
+typedef struct TableListNode {
+    struct TableListNode *next;
+    char key[FDT_GENERIC_MAX_PATTERN_LEN];
+    FDTInitFn fdt_init;
+    void *opaque;
+} TableListNode;
+
+/* add a node to the table specified by *head_p */
+
+static void add_to_table(
+        FDTInitFn fdt_init,
+        const char *key,
+        void *opaque,
+        TableListNode **head_p)
+{
+    TableListNode *nn = malloc(sizeof(*nn));
+    nn->next = *head_p;
+    strcpy(nn->key, key);
+    nn->fdt_init = fdt_init;
+    nn->opaque = opaque;
+    *head_p = nn;
+}
+
+/* FIXME: add return codes that differentiate between not found and error */
+
+/*
+ * search a table for a key string and call the fdt init function if found.
+ * Returns 0 if a match is found, 1 otherwise
+ */
+
+static int fdt_init_search_table(
+        char *node_path,
+        FDTMachineInfo *fdti,
+        const char *key, /* string to match */
+        TableListNode **head) /* head of the list to search */
+{
+    TableListNode *iter;
+
+    for (iter = *head; iter != NULL; iter = iter->next) {
+        if (!strcmp(key, iter->key)) {
+            if (iter->fdt_init) {
+                return iter->fdt_init(node_path, fdti, iter->opaque);
+            }
+            return 0;
+        }
+    }
+
+    return 1;
+}
+
+TableListNode *compat_list_head;
+
+void add_to_compat_table(FDTInitFn fdt_init, const char *compat, void *opaque)
+{
+    add_to_table(fdt_init, compat, opaque, &compat_list_head);
+}
+
+int fdt_init_compat(char *node_path, FDTMachineInfo *fdti, const char *compat)
+{
+    return fdt_init_search_table(node_path, fdti, compat, &compat_list_head);
+}
+
+TableListNode *inst_bind_list_head;
+
+void add_to_inst_bind_table(FDTInitFn fdt_init, const char *name, void *opaque)
+{
+    add_to_table(fdt_init, name, opaque, &inst_bind_list_head);
+}
+
+int fdt_init_inst_bind(char *node_path, FDTMachineInfo *fdti,
+        const char *name)
+{
+    return fdt_init_search_table(node_path, fdti, name, &inst_bind_list_head);
+}
+
+static void dump_table(TableListNode *head)
+{
+    TableListNode *iter;
+
+    for (iter = head; iter != NULL; iter = iter->next) {
+        printf("key : %s, opaque data %p\n", head->key, head->opaque);
+    }
+}
+
+void dump_compat_table(void)
+{
+    printf("FDT COMPATIBILITY TABLE:\n");
+    dump_table(compat_list_head);
+}
+
+void dump_inst_bind_table(void)
+{
+    printf("FDT INSTANCE BINDING TABLE:\n");
+    dump_table(inst_bind_list_head);
+}
diff --git a/include/hw/core/fdt_generic.h b/include/hw/core/fdt_generic.h
new file mode 100644
index 0000000000..614a234868
--- /dev/null
+++ b/include/hw/core/fdt_generic.h
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Tables of FDT device models and their init functions. Keyed by compatibility
+ * strings, device instance names.
+ */
+
+#ifndef FDT_GENERIC_H
+#define FDT_GENERIC_H
+
+#include "qemu/help-texts.h"
+#include "system/device_tree.h"
+
+typedef struct FDTMachineInfo FDTMachineInfo;
+
+typedef int (*FDTInitFn)(char *, FDTMachineInfo *, void *);
+
+/* associate a FDTInitFn with a FDT compatibility */
+
+void add_to_compat_table(FDTInitFn, const char *, void *);
+
+/*
+ * try and find a device model for a particular compatibility. If found,
+ * the FDTInitFn associated with the compat will be called and 0 will
+ * be returned. Returns non-zero on not found or error
+ */
+
+int fdt_init_compat(char *, FDTMachineInfo *, const char *);
+
+/* same as above, but associates with a FDT node name (rather than compat) */
+
+void add_to_inst_bind_table(FDTInitFn, const char *, void *);
+int fdt_init_inst_bind(char *, FDTMachineInfo *, const char *);
+
+void dump_compat_table(void);
+void dump_inst_bind_table(void);
+
+/*
+ * Called from FDTInitFn's to inform the framework that a dependency is
+ * unresolved and the calling context needs to wait for another device to
+ * instantiate first. The calling thread will suspend until a change in state
+ * in the argument fdt machine is detected.
+ */
+
+void fdt_init_yield(FDTMachineInfo *);
+
+/* set, check and get per device opaques. Keyed by fdt node_paths */
+
+void fdt_init_set_opaque(FDTMachineInfo *fdti, char *node_path, void *opaque);
+int fdt_init_has_opaque(FDTMachineInfo *fdti, char *node_path);
+void *fdt_init_get_opaque(FDTMachineInfo *fdti, char *node_path);
+
+/* statically register a FDTInitFn as being associate with a compatibility */
+
+#define fdt_register_compatibility_opaque(function, compat, n, opaque) \
+static void __attribute__((constructor)) \
+function ## n ## _register_imp(void) { \
+    add_to_compat_table(function, compat, opaque); \
+}
+
+#define fdt_register_compatibility_n(function, compat, n) \
+fdt_register_compatibility_opaque(function, compat, n, NULL)
+
+#define fdt_register_compatibility(function, compat) \
+fdt_register_compatibility_n(function, compat, 0)
+
+#define fdt_register_instance_opaque(function, inst, n, opaque) \
+static void __attribute__((constructor)) \
+function ## n ## _register_imp(void) { \
+    add_to_inst_bind_table(function, inst, opaque); \
+}
+
+#define fdt_register_instance_n(function, inst, n) \
+fdt_register_instance_opaque(function, inst, n, NULL)
+
+#define fdt_register_instance(function, inst) \
+fdt_register_instance_n(function, inst, 0)
+
+#endif /* FDT_GENERIC_H */
-- 
2.43.0


