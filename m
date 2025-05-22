Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93647C54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 19:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIBF0-0000wZ-7P; Thu, 22 May 2025 15:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uIBEr-0000vI-Qp
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:05:59 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uIBEp-0006Sl-LZ
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:05:57 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-30e8feb1886so6850841a91.0
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 12:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747940754; x=1748545554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HPVF35l9UHbNMEec1/7K6eJuGQybRaf36tQqQS1N9wo=;
 b=sh298Yw+BFjpBYRUOmlbLgWld6PVF6Da1OR/86CjaTmq7WfBRAEgR67XwZLHx9N1Vi
 Csdv8UEIdWcv1MdCDnqYOEajfpsqbLH7XOp45/T3kN1ncRZ89CPir4f7lNaqpVnx+mAR
 9HbY1bePy0RIL9h0Yj6ZGM+oFVDStJNUDtsT8ggbNzdhKsZdbFJJ6EumTNjRR+9IYT7/
 X3BAHmwnC64IXzEYFLuWqGtWx/f9lvygS55kdn3U1SOCgVQJ2/f/yCp0Ih+9aRVGGxlS
 PHVVWCcxIDVnBtmQBe1EgMnTzu8D7bxMhxgfFRUtkJ9IdzJdUvALh0w2EzViFgickOMs
 EIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747940754; x=1748545554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HPVF35l9UHbNMEec1/7K6eJuGQybRaf36tQqQS1N9wo=;
 b=xBC1+7aQjBJMyI6Ch26jdwBOj5DaZt4X9pqy3psagxSsbJ/pGCW3mqrtYjDMx5jKp0
 id/8hoSJfMhaCDy6m9gUlBA6rNjell5pfAxaPSjBEAI57wlIB4Kr4AOiZmuOEitqdh/U
 oCa/tTy+woedNb9tyecQwedgBUdOS9u+Oi61klABfsx8ZIlu5rJWBT/r9BRsDDxshy9N
 py3TlTCPBFJWPTqDzXH6VrM4kGGcDIKaXSozfcmPElGi7QZbfxF74WzLQoxYV3NaBQgq
 9/D12FVHQV6EDbr+4gR2AGwtuXgHMWL5ov7VinshcfBisiW9vWx6GVBUQ4hMnRMNvYmD
 IBCQ==
X-Gm-Message-State: AOJu0YzRWQ2sblnsj2aYbuVFzVcbf2K+bmb9hreXAMpjFcLxmF+nKoVE
 NJeToLG0ZKEyq5fekDYWh/QSqy39NW9ziiMJVCqQ1saHlI50gbYH2k2BSTsHyD4Y7Lg6L1L5Rth
 py2t1
X-Gm-Gg: ASbGncuI1FwlGpDduNTuJAsfYy3mD4b8MKBtxVvqbSQ5Hi83HgLLAOtZPfkuswA2o3D
 nXcBRu2M3O/MrnDaHJ3ELNJ+btDAoeolQ3p63Y9/R/8pyodYtZkrQbNfqCNqr+LHipeM4QCPy9Q
 vgFvviF0TC5TlAF3hTjo2kY+kKyQ8GQQLpZSzcgyWnhv/KWcipy1amHbPPRk2rmYO0y6nD4Z3/O
 29p/30ep+Mjifei/Vd6XaqFiqwQjrQYpvfCvbhGBm21Kxo4JrLOV7XZEQsSXjhRaE0Q8TxJKQzr
 WhYYWI7avHPwCYMa0rqIxOPBRwv3K+tACHyl4EIPl09Tlwe48Dk=
X-Google-Smtp-Source: AGHT+IFzuObatCQ7AWeHlLcwaqSClgW0UR31OMlecU4w0CHy92LwWF1bx/7te69fI47VJHe09dPNAg==
X-Received: by 2002:a17:90b:1e01:b0:30c:540b:99e with SMTP id
 98e67ed59e1d1-310e96cbff2mr454734a91.13.1747940754108; 
 Thu, 22 May 2025 12:05:54 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b26eb082c66sm11625565a12.60.2025.05.22.12.05.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 12:05:53 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, thuth@redhat.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, armbru@redhat.com,
 pierrick.bouvier@linaro.org, peter.maydell@linaro.org, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH v4 05/15] qapi: make SGX commands unconditionally available
Date: Thu, 22 May 2025 12:05:32 -0700
Message-ID: <20250522190542.588267-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
References: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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


