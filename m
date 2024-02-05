Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF391C48292
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 16:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX2FY-0003qt-OU; Mon, 05 Feb 2024 11:55:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1rX2FW-0003qP-2J
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 11:55:14 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1rX2FM-0000WN-7d
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 11:55:11 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-55a8fd60af0so6167048a12.1
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 08:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707152102; x=1707756902;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WLzi1hLFj9Oj83pbHMUpxHfzT5tkFuOtYwzSLXsw2fQ=;
 b=qg0pc7eJ68Nl/APtPX67gcb6TMh8wkNe/nmemFA7PSNJ0AUK8f99ZZ8vTmJi1O85XM
 c74YU5RFr7Q8+/4dr/eh4cEbJeD/TMYPBJlanjK9gys6AyjM6KGkKzEyW5SQ3NPpF0FI
 qW+bLmtqyoZsgLFr2UXhmHd2472UlT4Iu+KBDFf2gUTlIr9xwXc11brqk2CS5jTzVCt6
 Dey3DLp0SI7Qh6gO00yJnwb0D9HnUnhzIpn/lyXXoX7o/YeiMPWSzRKNvLM0DmKaaLJv
 wL2UlQmVFxrkIZELpGhVFSaaEW4DIbnEVEV+p+BKDsBnSjZKPtb6jCCK9BOzJE5M62aR
 AbYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707152102; x=1707756902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WLzi1hLFj9Oj83pbHMUpxHfzT5tkFuOtYwzSLXsw2fQ=;
 b=mSYFPfosK4yKopseYmFzf2gI6p3/XVsc+XSqJUJ5q2qmooAIikXCYSQ+Y+p3Dcp3V6
 HtVnMdoyNWoQGKoABlCOIWEZ94o0x1isXaxsAvG5xjrVrGI1kOEL1oLTNC9iill0l+Wl
 j0RjOtu1PiBbpbCER0sytZVvwUMwVVZU5O0+UAqEGPXoC1fEORHUbHlvfDRX/1kwky9M
 UEICG+2Q5J5vsQzGRkXspjK65+gKj2P0n89l9jkemecsP5WRdHbUMJkRVwFfcTREqosw
 lGCclCGS1octeJ3/RQqPX/obtIAl5E4ukYLkDP1AKMG+cMznvlsgX70W9lULHKZybmjR
 RsEg==
X-Gm-Message-State: AOJu0YxTeMvH9jtdN8MFw/s0l025Ej862pPH5yvfNwdllbembQrMFnX4
 49ievXdTvM85hHh25yN/FMdonN7mJ07Hy/VQT02Lt5hzZ3O/4LHq90HPxs7eEEvXcmoQlNgMutI
 I
X-Google-Smtp-Source: AGHT+IGELN2bBQEhF2hCATJDdU6Cxry7cm+G10DzU6mE13A/3fMfKYUlMnUjeZ60Aq+RiA/0ziE27Q==
X-Received: by 2002:a17:906:5ac6:b0:a38:6d3:ac54 with SMTP id
 x6-20020a1709065ac600b00a3806d3ac54mr14108ejs.23.1707152102381; 
 Mon, 05 Feb 2024 08:55:02 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVUVqgYc2HYb7MeS1MdXkf3USvSIpewUPxRGeW7yNx5mk98OGDT6U3M8v2BhnhayBaARb5pEY1u0TV38bSQtIap6M6cZZM6haAyAEYd1ogG6PtssvFG2Ciy3l4slnccd5widEpB86d5tObNlZbPPi/o2x6lP4D7cqmJmRvkAMjfc5Asu8T/Y+8a2/SJ0y6snxT8KX6+E47Zv8aDwtgxJBHUwLirzr3jLRcXZCr6pg3dwHMqcX3MxJnb6bw=
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a170906074e00b00a370a76d3a0sm20580ejb.123.2024.02.05.08.55.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 08:55:01 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org, berrange@redhat.com
Cc: yuri.benditovich@daynix.com,
	yan@daynix.com,
	akihiko.odaki@daynix.com
Subject: [PATCH v9 4/5] qmp: Added new command to retrieve eBPF blob.
Date: Mon,  5 Feb 2024 18:54:34 +0200
Message-ID: <20240205165437.1965981-5-andrew@daynix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205165437.1965981-1-andrew@daynix.com>
References: <20240205165437.1965981-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::533;
 envelope-from=andrew@daynix.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Now, the binary objects may be retrieved by id.
It would require for future qmp commands that may require specific
eBPF blob.

Added command "request-ebpf". This command returns
eBPF program encoded base64. The program taken from the
skeleton and essentially is an ELF object that can be
loaded in the future with libbpf.

The reason to use the command to provide the eBPF object
instead of a separate artifact was to avoid issues related
to finding the eBPF itself. eBPF object is an ELF binary
that contains the eBPF program and eBPF map description(BTF).
Overall, eBPF object should contain the program and enough
metadata to create/load eBPF with libbpf. As the eBPF
maps/program should correspond to QEMU, the eBPF can't
be used from different QEMU build.

The first solution was a helper that comes with QEMU
and loads appropriate eBPF objects. And the issue is
to find a proper helper if the system has several
different QEMUs installed and/or built from the source,
which helpers may not be compatible.

Another issue is QEMU updating while there is a running
QEMU instance. With an updated helper, it may not be
possible to hotplug virtio-net device to the already
running QEMU. Overall, requesting the eBPF object from
QEMU itself solves possible failures with acceptable effort.

Links:
[PATCH 3/5] qmp: Added the helper stamp check.
https://lore.kernel.org/all/20230219162100.174318-4-andrew@daynix.com/

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 ebpf/ebpf.c           | 69 +++++++++++++++++++++++++++++++++++++++++++
 ebpf/ebpf.h           | 29 ++++++++++++++++++
 ebpf/ebpf_rss.c       |  6 ++++
 ebpf/meson.build      |  2 +-
 qapi/ebpf.json        | 66 +++++++++++++++++++++++++++++++++++++++++
 qapi/meson.build      |  1 +
 qapi/qapi-schema.json |  1 +
 7 files changed, 173 insertions(+), 1 deletion(-)
 create mode 100644 ebpf/ebpf.c
 create mode 100644 ebpf/ebpf.h
 create mode 100644 qapi/ebpf.json

diff --git a/ebpf/ebpf.c b/ebpf/ebpf.c
new file mode 100644
index 0000000000..2d73beb479
--- /dev/null
+++ b/ebpf/ebpf.c
@@ -0,0 +1,69 @@
+/*
+ * QEMU eBPF binary declaration routine.
+ *
+ * Developed by Daynix Computing LTD (http://www.daynix.com)
+ *
+ * Authors:
+ *  Andrew Melnychenko <andrew@daynix.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/queue.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-ebpf.h"
+#include "ebpf/ebpf.h"
+
+typedef struct ElfBinaryDataEntry {
+    int id;
+    const void *data;
+    size_t datalen;
+
+    QSLIST_ENTRY(ElfBinaryDataEntry) node;
+} ElfBinaryDataEntry;
+
+static QSLIST_HEAD(, ElfBinaryDataEntry) ebpf_elf_obj_list =
+                                            QSLIST_HEAD_INITIALIZER();
+
+void ebpf_register_binary_data(int id, const void *data, size_t datalen)
+{
+    struct ElfBinaryDataEntry *dataentry = NULL;
+
+    dataentry = g_new0(struct ElfBinaryDataEntry, 1);
+    dataentry->data = data;
+    dataentry->datalen = datalen;
+    dataentry->id = id;
+
+    QSLIST_INSERT_HEAD(&ebpf_elf_obj_list, dataentry, node);
+}
+
+const void *ebpf_find_binary_by_id(int id, size_t *sz, Error **errp)
+{
+    struct ElfBinaryDataEntry *it = NULL;
+    QSLIST_FOREACH(it, &ebpf_elf_obj_list, node) {
+        if (id == it->id) {
+            *sz = it->datalen;
+            return it->data;
+        }
+    }
+
+    error_setg(errp, "can't find eBPF object with id: %d", id);
+
+    return NULL;
+}
+
+EbpfObject *qmp_request_ebpf(EbpfProgramID id, Error **errp)
+{
+    EbpfObject *ret = NULL;
+    size_t size = 0;
+    const void *data = ebpf_find_binary_by_id(id, &size, errp);
+    if (!data) {
+        return NULL;
+    }
+
+    ret = g_new0(EbpfObject, 1);
+    ret->object = g_base64_encode(data, size);
+
+    return ret;
+}
diff --git a/ebpf/ebpf.h b/ebpf/ebpf.h
new file mode 100644
index 0000000000..378d4e9c70
--- /dev/null
+++ b/ebpf/ebpf.h
@@ -0,0 +1,29 @@
+/*
+ * QEMU eBPF binary declaration routine.
+ *
+ * Developed by Daynix Computing LTD (http://www.daynix.com)
+ *
+ * Authors:
+ *  Andrew Melnychenko <andrew@daynix.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef EBPF_H
+#define EBPF_H
+
+
+void ebpf_register_binary_data(int id, const void *data,
+                               size_t datalen);
+const void *ebpf_find_binary_by_id(int id, size_t *sz,
+                                   struct Error **errp);
+
+#define ebpf_binary_init(id, fn)                                           \
+static void __attribute__((constructor)) ebpf_binary_init_ ## fn(void)     \
+{                                                                          \
+    size_t datalen = 0;                                                    \
+    const void *data = fn(&datalen);                                       \
+    ebpf_register_binary_data(id, data, datalen);                          \
+}
+
+#endif /* EBPF_H */
diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
index 150aa40813..c8a68da2c5 100644
--- a/ebpf/ebpf_rss.c
+++ b/ebpf/ebpf_rss.c
@@ -13,6 +13,8 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qapi/qapi-types-misc.h"
+#include "qapi/qapi-commands-ebpf.h"
 
 #include <bpf/libbpf.h>
 #include <bpf/bpf.h>
@@ -21,6 +23,8 @@
 
 #include "ebpf/ebpf_rss.h"
 #include "ebpf/rss.bpf.skeleton.h"
+#include "ebpf/ebpf.h"
+
 #include "trace.h"
 
 void ebpf_rss_init(struct EBPFRSSContext *ctx)
@@ -261,3 +265,5 @@ void ebpf_rss_unload(struct EBPFRSSContext *ctx)
     ctx->map_toeplitz_key = -1;
     ctx->map_indirections_table = -1;
 }
+
+ebpf_binary_init(EBPF_PROGRAMID_RSS, rss_bpf__elf_bytes)
diff --git a/ebpf/meson.build b/ebpf/meson.build
index 2f627d6c7d..c5bf9295a2 100644
--- a/ebpf/meson.build
+++ b/ebpf/meson.build
@@ -1 +1 @@
-system_ss.add(when: libbpf, if_true: files('ebpf_rss.c'), if_false: files('ebpf_rss-stub.c'))
+common_ss.add(when: libbpf, if_true: files('ebpf.c', 'ebpf_rss.c'), if_false: files('ebpf_rss-stub.c'))
diff --git a/qapi/ebpf.json b/qapi/ebpf.json
new file mode 100644
index 0000000000..f413d00154
--- /dev/null
+++ b/qapi/ebpf.json
@@ -0,0 +1,66 @@
+# -*- Mode: Python -*-
+# vim: filetype=python
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or later.
+# See the COPYING file in the top-level directory.
+
+##
+# = eBPF Objects
+#
+# eBPF object is an ELF binary that contains the eBPF
+# program and eBPF map description(BTF). Overall, eBPF
+# object should contain the program and enough metadata
+# to create/load eBPF with libbpf. As the eBPF maps/program
+# should correspond to QEMU, the eBPF can't be used from
+# different QEMU build.
+#
+# Currently, there is a possible eBPF for receive-side scaling (RSS).
+#
+##
+
+##
+# @EbpfObject:
+#
+# An eBPF ELF object.
+#
+# @object: the eBPF object encoded in base64
+#
+# Since: 9.0
+##
+{ 'struct': 'EbpfObject',
+  'data': {'object': 'str'},
+  'if': 'CONFIG_EBPF' }
+
+##
+# @EbpfProgramID:
+#
+# The eBPF programs that can be gotten with request-ebpf.
+#
+# @rss: Receive side scaling, technology that allows steering traffic
+#     between queues by calculation hash.  Users may set up
+#     indirection table and hash/packet types configurations.  Used
+#     with virtio-net.
+#
+# Since: 9.0
+##
+{ 'enum': 'EbpfProgramID',
+  'if': 'CONFIG_EBPF',
+  'data': [ { 'name': 'rss' } ] }
+
+##
+# @request-ebpf:
+#
+# Retrieve an eBPF object that can be loaded with libbpf.  Management
+# applications (g.e. libvirt) may load it and pass file descriptors to
+# QEMU, so they can run running QEMU without BPF capabilities.
+#
+# @id: The ID of the program to return.
+#
+# Returns: eBPF object encoded in base64.
+#
+# Since: 9.0
+##
+{ 'command': 'request-ebpf',
+  'data': { 'id': 'EbpfProgramID' },
+  'returns': 'EbpfObject',
+  'if': 'CONFIG_EBPF' }
diff --git a/qapi/meson.build b/qapi/meson.build
index f81a37565c..375d564277 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -33,6 +33,7 @@ qapi_all_modules = [
   'crypto',
   'cxl',
   'dump',
+  'ebpf',
   'error',
   'introspect',
   'job',
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index c01ec335e6..8304d45625 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -53,6 +53,7 @@
 { 'include': 'char.json' }
 { 'include': 'dump.json' }
 { 'include': 'net.json' }
+{ 'include': 'ebpf.json' }
 { 'include': 'rdma.json' }
 { 'include': 'rocker.json' }
 { 'include': 'tpm.json' }
-- 
2.43.0


