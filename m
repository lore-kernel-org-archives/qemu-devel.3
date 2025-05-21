Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8D3C54ED1
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 22:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHs4b-0006C7-Aj; Wed, 21 May 2025 18:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs4W-00069l-EX
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:38:00 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs4Q-0005Yu-4m
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:38:00 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-af51596da56so5561033a12.0
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 15:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747867070; x=1748471870; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HPVF35l9UHbNMEec1/7K6eJuGQybRaf36tQqQS1N9wo=;
 b=P0SxX6z0VkwNGuG783h9C0UPpbXP3T5Wb7CSW7WQkoNb6tGlUULVYtTp4yDlBUsmjI
 0ChN0+G0P7onKUhYxLwqRRO1ARUIob+NmGkkU5dRUFAgbIEETaTgCJnti1aDNH128s2g
 Nn1b1M9RTTfor+wzSZ6t0/oY/OwuGNJKxK11ce9nL6QEa6mLVhPTplGByEn7BqxbJ7/7
 ikEJQ5/IJGOWJlosV8tm+WaVuJV+UM3bTGGkoVIrsr6bYa/O5l6XRiXDA81MzvsmSlZA
 OnOt9EN4ZDlgRrlFWoXd2sTYvk8v/zdT3ub0mEmFZwzY1wjBh25tlmopnxnVbfFAlM/Q
 ULcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747867070; x=1748471870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HPVF35l9UHbNMEec1/7K6eJuGQybRaf36tQqQS1N9wo=;
 b=YXJC+I7/8zQfXWR1Ek7u++9cc/nrUQTw00iN7TkFvs4U9Qrc1Y099PNSPWNDeaubiL
 /xuu5fyAH+MLkzICHRlJSXuJWoP4FF2F3r17DKsohySCr1ClYRsSBt1OzgS6w8Ga3R2j
 JjulYeKnCj2wxV8Cvd+DHOgB9aj7tplUL9dXPsS/lbOABvOmjB6f391+QRXTMTmFKYwC
 LDOzlQxSrd9DGwXkkrqFiEg0JYzCeIRDhZxjAXZyzUW7WNlIO876IbAVqIna95LaLD9T
 /s2nxb+kmm/ySB3gtpF8U1FbGH9y2YTAsJTrr3s2DNXONVbp1o1glAgi8iRoe5y87WDv
 FNOQ==
X-Gm-Message-State: AOJu0YyGMU+P5KehSM33OH5Uvxm551hoRRgWM+5zcrjSmqCIzpYwu0xl
 QO607gJLcdMCT0iHh/FdgrJ7j7DV99afKXEMmQmpWOPYh90lOWNymEp7+Um4TTZaprcuMboBixz
 y0wqN
X-Gm-Gg: ASbGncuWNjbcWBZQnf/tll9YCy5S+0RSZVsZyPdJil9NKNEv9TEbk6pUiEQmRInknFZ
 r5J0EtrS40G6ss9sUWMvie6F32VFWsKf/zuFIzKbSaH5x+/MmdDNvvg+yYjMHgfBaJRIJAP4G5G
 xwMLP0w531CggE0DApBamh94rHKdHxk1HhFFL1MMOmKnLE/bdUv5zuJUHM5juIh6vEzk+sEqFmC
 M8832RyEJI4opSBIQuWylg2Grw1kZCmra6qrCys8bxGV2LqYZnwxP7b9cqkjY3dR8DBL5Zbe8mf
 Svenh85mT61RW7QKQ/Fgq73W1NfeRkz0vQEzEfIMf/FBuNvZ0Zj51/YSmlOsVw==
X-Google-Smtp-Source: AGHT+IFVQqJvgb2FsEaH69S/1zlF+Kp4srjSFF66l7n2XiyoNw5xDWdovpcFvWqwwmUSjQGEVS1Riw==
X-Received: by 2002:a17:903:1a27:b0:21f:4649:fd49 with SMTP id
 d9443c01a7336-231d45acaa2mr314751775ad.49.1747867069580; 
 Wed, 21 May 2025 15:37:49 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4e97dcesm97711105ad.121.2025.05.21.15.37.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 15:37:49 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, pbonzini@redhat.com, peter.maydell@linaro.org,
 armbru@redhat.com, michael.roth@amd.com, philmd@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com, thuth@redhat.com
Subject: [PATCH v3 05/14] qapi: make SGX commands unconditionally available
Date: Wed, 21 May 2025 15:37:31 -0700
Message-ID: <20250521223740.249720-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250521223740.249720-1-pierrick.bouvier@linaro.org>
References: <20250521223740.249720-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x530.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

This removes the TARGET_I386 condition from the SGX confidential
virtualization commands, moving them to the recently introduced
misc-i386.json QAPI file, given they are inherantly i386 specific
commands.

Observe a pre-existing bug that the "SGXEPCSection" struct lacked
a TARGET_I386 condition, despite its only usage being behind a
TARGET_I386 condition.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 qapi/misc-i386.json      | 77 +++++++++++++++++++++++++++++++++++++++
 qapi/misc-target.json    | 79 ----------------------------------------
 hw/i386/sgx-stub.c       |  2 +-
 hw/i386/sgx.c            |  2 +-
 stubs/monitor-i386-sgx.c | 17 +++++++++
 stubs/meson.build        |  1 +
 6 files changed, 97 insertions(+), 81 deletions(-)
 create mode 100644 stubs/monitor-i386-sgx.c

diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
index de0e4ab67ff..92751d5e180 100644
--- a/qapi/misc-i386.json
+++ b/qapi/misc-i386.json
@@ -293,3 +293,80 @@
 { 'command': 'query-sev-attestation-report',
   'data': { 'mnonce': 'str' },
   'returns': 'SevAttestationReport' }
+
+##
+# @SgxEpcSection:
+#
+# Information about intel SGX EPC section
+#
+# @node: the numa node
+#
+# @size: the size of EPC section
+#
+# Since: 7.0
+##
+{ 'struct': 'SgxEpcSection',
+  'data': { 'node': 'int',
+            'size': 'uint64'}}
+
+##
+# @SgxInfo:
+#
+# Information about intel Safe Guard eXtension (SGX) support
+#
+# @sgx: true if SGX is supported
+#
+# @sgx1: true if SGX1 is supported
+#
+# @sgx2: true if SGX2 is supported
+#
+# @flc: true if FLC is supported
+#
+# @sections: The EPC sections information (Since: 7.0)
+#
+# Since: 6.2
+##
+{ 'struct': 'SgxInfo',
+  'data': { 'sgx': 'bool',
+            'sgx1': 'bool',
+            'sgx2': 'bool',
+            'flc': 'bool',
+            'sections': ['SgxEpcSection']} }
+
+##
+# @query-sgx:
+#
+# Returns information about configured SGX capabilities of guest
+#
+# Returns: @SgxInfo
+#
+# Since: 6.2
+#
+# .. qmp-example::
+#
+#     -> { "execute": "query-sgx" }
+#     <- { "return": { "sgx": true, "sgx1" : true, "sgx2" : true,
+#                      "flc": true,
+#                      "sections": [{"node": 0, "size": 67108864},
+#                      {"node": 1, "size": 29360128}]} }
+##
+{ 'command': 'query-sgx', 'returns': 'SgxInfo' }
+
+##
+# @query-sgx-capabilities:
+#
+# Returns information about SGX capabilities of host
+#
+# Returns: @SgxInfo
+#
+# Since: 6.2
+#
+# .. qmp-example::
+#
+#     -> { "execute": "query-sgx-capabilities" }
+#     <- { "return": { "sgx": true, "sgx1" : true, "sgx2" : true,
+#                      "flc": true,
+#                      "section" : [{"node": 0, "size": 67108864},
+#                      {"node": 1, "size": 29360128}]} }
+##
+{ 'command': 'query-sgx-capabilities', 'returns': 'SgxInfo' }
diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index cc472ce91cb..d62db37d7cf 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -2,85 +2,6 @@
 # vim: filetype=python
 #
 
-##
-# @SgxEpcSection:
-#
-# Information about intel SGX EPC section
-#
-# @node: the numa node
-#
-# @size: the size of EPC section
-#
-# Since: 7.0
-##
-{ 'struct': 'SgxEpcSection',
-  'data': { 'node': 'int',
-            'size': 'uint64'}}
-
-##
-# @SgxInfo:
-#
-# Information about intel Safe Guard eXtension (SGX) support
-#
-# @sgx: true if SGX is supported
-#
-# @sgx1: true if SGX1 is supported
-#
-# @sgx2: true if SGX2 is supported
-#
-# @flc: true if FLC is supported
-#
-# @sections: The EPC sections information (Since: 7.0)
-#
-# Since: 6.2
-##
-{ 'struct': 'SgxInfo',
-  'data': { 'sgx': 'bool',
-            'sgx1': 'bool',
-            'sgx2': 'bool',
-            'flc': 'bool',
-            'sections': ['SgxEpcSection']},
-   'if': 'TARGET_I386' }
-
-##
-# @query-sgx:
-#
-# Returns information about configured SGX capabilities of guest
-#
-# Returns: @SgxInfo
-#
-# Since: 6.2
-#
-# .. qmp-example::
-#
-#     -> { "execute": "query-sgx" }
-#     <- { "return": { "sgx": true, "sgx1" : true, "sgx2" : true,
-#                      "flc": true,
-#                      "sections": [{"node": 0, "size": 67108864},
-#                      {"node": 1, "size": 29360128}]} }
-##
-{ 'command': 'query-sgx', 'returns': 'SgxInfo', 'if': 'TARGET_I386' }
-
-##
-# @query-sgx-capabilities:
-#
-# Returns information about SGX capabilities of host
-#
-# Returns: @SgxInfo
-#
-# Since: 6.2
-#
-# .. qmp-example::
-#
-#     -> { "execute": "query-sgx-capabilities" }
-#     <- { "return": { "sgx": true, "sgx1" : true, "sgx2" : true,
-#                      "flc": true,
-#                      "section" : [{"node": 0, "size": 67108864},
-#                      {"node": 1, "size": 29360128}]} }
-##
-{ 'command': 'query-sgx-capabilities', 'returns': 'SgxInfo', 'if': 'TARGET_I386' }
-
-
 ##
 # @EvtchnPortType:
 #
diff --git a/hw/i386/sgx-stub.c b/hw/i386/sgx-stub.c
index ccb21a975d7..d295e54d239 100644
--- a/hw/i386/sgx-stub.c
+++ b/hw/i386/sgx-stub.c
@@ -3,8 +3,8 @@
 #include "monitor/hmp-target.h"
 #include "hw/i386/pc.h"
 #include "hw/i386/sgx-epc.h"
+#include "qapi/qapi-commands-misc-i386.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc-target.h"
 
 void sgx_epc_build_srat(GArray *table_data)
 {
diff --git a/hw/i386/sgx.c b/hw/i386/sgx.c
index c80203b438e..e2801546ad6 100644
--- a/hw/i386/sgx.c
+++ b/hw/i386/sgx.c
@@ -19,7 +19,7 @@
 #include "monitor/hmp-target.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "qapi/qapi-commands-misc-target.h"
+#include "qapi/qapi-commands-misc-i386.h"
 #include "system/address-spaces.h"
 #include "system/hw_accel.h"
 #include "system/reset.h"
diff --git a/stubs/monitor-i386-sgx.c b/stubs/monitor-i386-sgx.c
new file mode 100644
index 00000000000..00e081d52dd
--- /dev/null
+++ b/stubs/monitor-i386-sgx.c
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-misc-i386.h"
+
+SgxInfo *qmp_query_sgx(Error **errp)
+{
+    error_setg(errp, "SGX support is not compiled in");
+    return NULL;
+}
+
+SgxInfo *qmp_query_sgx_capabilities(Error **errp)
+{
+    error_setg(errp, "SGX support is not compiled in");
+    return NULL;
+}
diff --git a/stubs/meson.build b/stubs/meson.build
index 07e9d3799a5..f2eb4880181 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -80,6 +80,7 @@ if have_system
   stub_ss.add(files('monitor-arm-gic.c'))
   stub_ss.add(files('monitor-i386-rtc.c'))
   stub_ss.add(files('monitor-i386-sev.c'))
+  stub_ss.add(files('monitor-i386-sgx.c'))
 endif
 
 if have_system or have_user
-- 
2.47.2


