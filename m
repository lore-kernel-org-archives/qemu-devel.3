Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C43DCE8D7A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 11:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srFDn-0005ZY-D3; Thu, 19 Sep 2024 07:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1srFDi-0005YI-Dv
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 07:21:10 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1srFDd-0003bZ-RN
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 07:21:10 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-208ccde82e6so6065725ad.0
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 04:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1726744862; x=1727349662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=w69oY+Uc9GUTghN+pPlLoPPcJ1xKPaNWEfTrgtQs7Fk=;
 b=lfmIGN74gCJE56glYo7DsfFM7qNi8bbQb4VKYFe4h1qnP7GjiOOaqtnc0kw3EC5pG9
 V30aNcp3X6GzQ9ciKTJri68QvEnTPDp4D61TealoTIIAZBnnuInKRSznfbOQNtaVRQaS
 VJn71UYd8qU+W/e6YX7cRFlTkNbWOLmDFGZWkUx1saiHOuCNKJVteHJROtWE6Q2SpdfD
 nbq7EGjztPFn/RM3UpKeDg23xTHJuOM5IMBbrecH5COGqguQWCGCxAkCXr/iOd5MFjvL
 cqJhhHaN42YgEpGEdDNQkR2d7FFRY5uBS/UOQ/7xBhYBT1aJxeqmqkX5uNJH348jPs5q
 fqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726744862; x=1727349662;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w69oY+Uc9GUTghN+pPlLoPPcJ1xKPaNWEfTrgtQs7Fk=;
 b=rCPMNU29ciGCoBfHBrlTdJUJG4FblNZGFcC07TvG8DhC/d4ldnPXKWI+41nc8v2Nno
 coAvPgDf6VS5bSxiehf8860YcuqjyyRa84laO0JOxQ0DCTum7f6v/AJq8LtasylQ+8ew
 LMiYlE1mVP4mbkMfPd0m12v7/7Ofn8Lf/851/lFvHi89rxVw/xCQ5+e1S6y7Urj2B4BI
 r/ZBC5y75L70f4B+D8RlW1u+acY/7kN56i1sm0i+IdjxUTcLVR+llYhvu5GDKsGAcOTy
 8ULeXd9N9TdlPmbCz2KZpy6AAFZUDCRQKhtGQWcjQxPORv+Yb5krbYesjLV+A2cUVvZG
 yTvw==
X-Gm-Message-State: AOJu0YwwJCAr5A7+IuM+oHQsAiMrgFpfW3YPtEZoayCQLWYQeoAHPe7I
 9sNASmxIfTtEKzVR9Y3sUj6EFwoOD45NrPQ0jyNXG2eJUHtwa+drCT0MMEi54wcUbw/qLypUGaF
 1
X-Google-Smtp-Source: AGHT+IGdel6nFwZ0o2aMFPLyVVcVn6lol681wYHOth03syMADpRYBjGtH7f8SKIVk3IOTzXOQryqRg==
X-Received: by 2002:a17:903:249:b0:206:8eec:c087 with SMTP id
 d9443c01a7336-2076e354d05mr345746185ad.16.1726744862281; 
 Thu, 19 Sep 2024 04:21:02 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com (201-68-240-33.dsl.telesp.net.br.
 [201.68.240.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2079472df88sm77954255ad.243.2024.09.19.04.20.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 04:21:01 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 eblake@redhat.com, armbru@redhat.com, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH] qapi, machine-qmp-cmds.c: query-accelerator support
Date: Thu, 19 Sep 2024 08:20:56 -0300
Message-ID: <20240919112056.620917-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a QMP command that shows all specific properties of the current
accelerator in use.

This can be used as a complement of other APIs like query-machines and
query-cpu-model-expansion, allowing management to get a more complete
picture of the running QEMU process.

This is the output with a x86_64 TCG guest:

$ ./build/qemu-system-x86_64 -S  -display none -accel tcg -qmp tcp:localhost:1234,server,wait=off

$ ./scripts/qmp/qmp-shell localhost:1234
Welcome to the QMP low-level shell!
Connected to QEMU 9.1.50

(QEMU) query-accelerator
{"return": {"name": "tcg", "props": {"one-insn-per-tb": false, "thread": "multi", "tb-size": 0, "split-wx": false, "type": "tcg-accel"}}}

And for a x86_64 KVM guest:

$ ./build/qemu-system-x86_64 -S  -display none -accel kvm -qmp tcp:localhost:1234,server,wait=off

$ ./scripts/qmp/qmp-shell localhost:1234
Welcome to the QMP low-level shell!
Connected to QEMU 9.1.50

(QEMU) query-accelerator
{"return": {"name": "KVM", "props": {"mem-container-smram[0]": "", "xen-gnttab-max-frames": 64, "device": "", "xen-version": 0, "mem-smram[0]": "", "notify-window": 0, "dirty-ring-size": 0, "kvm-shadow-mem": -1, "type": "kvm-accel", "notify-vmexit": "run", "xen-evtchn-max-pirq": 256}}}

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/core/machine-qmp-cmds.c | 34 ++++++++++++++++++++++++++++++++++
 qapi/machine.json          | 27 +++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 130217da8f..eac803bf36 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -15,6 +15,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-builtin-visit.h"
 #include "qapi/qapi-commands-machine.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qobject.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/type-helpers.h"
@@ -406,3 +407,36 @@ GuidInfo *qmp_query_vm_generation_id(Error **errp)
     info->guid = qemu_uuid_unparse_strdup(&vms->guid);
     return info;
 }
+
+AccelInfo *qmp_query_accelerator(Error **errp)
+{
+    AccelState *accel = current_accel();
+    AccelClass *acc = ACCEL_GET_CLASS(accel);
+    AccelInfo *info = g_new0(AccelInfo, 1);
+    QDict *qdict_out = qdict_new();
+    ObjectPropertyIterator iter;
+    ObjectProperty *prop;
+
+    info->name = g_strdup(acc->name);
+
+    object_property_iter_init(&iter, OBJECT(accel));
+    while ((prop = object_property_iter_next(&iter))) {
+        QObject *value;
+
+        if (!prop->get) {
+            continue;
+        }
+
+        value = object_property_get_qobject(OBJECT(accel), prop->name,
+                                                  &error_abort);
+        qdict_put_obj(qdict_out, prop->name, value);
+    }
+
+    if (!qdict_size(qdict_out)) {
+        qobject_unref(qdict_out);
+    } else {
+        info->props = QOBJECT(qdict_out);
+    }
+
+    return info;
+}
diff --git a/qapi/machine.json b/qapi/machine.json
index a6b8795b09..d0d527d1eb 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1898,3 +1898,30 @@
 { 'command': 'x-query-interrupt-controllers',
   'returns': 'HumanReadableText',
   'features': [ 'unstable' ]}
+
+##
+# @AccelInfo:
+#
+# Information about the current accelerator.
+#
+# @name: the name of the current accelerator being used
+#
+# @props: a dictionary of the accelerator properties
+#
+# Since: 9.2
+##
+{ 'struct': 'AccelInfo',
+  'data': { 'name': 'str',
+            '*props': 'any' } }
+
+##
+# @query-accelerator:
+#
+# Shows information about the accelerator in use.
+#
+# Returns: a CpuModelExpansionInfo describing the expanded CPU model
+#
+# Since: 9.2
+##
+{ 'command': 'query-accelerator',
+  'returns': 'AccelInfo' }
-- 
2.45.2


