Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B852F54AC5
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 15:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w53Pt-0000rb-PX; Tue, 24 Mar 2026 11:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w53Pi-0000j1-Bf
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:11:27 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w53Pg-0005DX-J5
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:11:26 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43b44c0bcdbso5918511f8f.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 08:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774365083; x=1774969883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Rgr2enp+qbVDThQZJFr+FEHlpspYgEBOwZezu1EGo0U=;
 b=gZXOJeGv4vl1fRQXZGy5xkzurHdhWXE5ANYrM7ryIXDlMK43C4zCfkL5dICEIfanNH
 76XH2muODCDcHoy08CwCMkw9Ll020HWSwY8LLhh9dYcrc8rLm6S2o483AhOz40Iik6cV
 FsywMRpbTNt3l3pG8XEG35ugZFyT6Y4b1TOuhOvaciMSbHD4k3yiUSE+fFb4HygyD4Jk
 p0QznlpW2t9MBIW8negcC8sQoeN7KCpZKT56hWVVYSY4VnUUHgFMOrrv+FdUJ4uXL0st
 igPojhgD1vIIxsVa8SnHZh9u+vHQg7eFzBqB9IeXREs1fbLohU8dHbQGkWG6XMapgWUE
 JKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774365083; x=1774969883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Rgr2enp+qbVDThQZJFr+FEHlpspYgEBOwZezu1EGo0U=;
 b=GsHwqsk0ACgrhl6XY5EK/MFdQJS0abBOefKDEzL2XA4zjdan7hhSCGpYZ3iCqr84w4
 SKlg+J0O3mkTwkecdC3tMWhfIF6ymfSAJNr4aapDyDCSUbhg7qSDuTe4QXNdueDOJEGQ
 UnZjBkDmkPn77s+gFaGNu3gPTQkWn+iJAV7qSUzf4mucBJUKO8Ort/fUuJTEIcOYoUfs
 YKTlpCLFX7sAyokIdln1HkrrNbgsrj3xFpSg6iaCnnSZBP5gOXtLCuWx20XKMxqH6deq
 WRAQC6bOEhfWgpgo0VYOpCvCC1CcYoX8rCyS+XD17YVlgCJRFSruoXUgI5/jOndkQELE
 1RFA==
X-Gm-Message-State: AOJu0YyHuXes04gtikpKJdmtVRdze5uwyp/pLos9yPWQo4OPBgvIKaqd
 SnDeSFyDXzX8LvMUNsf8UY0lH8tk3bX+f+uHc1+Xw5GZJFkNC02xYjOodXJXZLh2xQoib4v/e5N
 eUzhcAjE=
X-Gm-Gg: ATEYQzxZ6GZ2csB8YU3jAYGlHG9yJtHiwGhp+DjOcvwcSl8ceasqiD0cSg6mCg6SCAF
 BPG7o7VcmPd3y+itdL4X2u+e8l8U/5NSyiUbMQc/FpZqp3h21a7ZDMtpRswXGJ8OphjDtaNaz92
 SlsWz23JURUNky0Z54elE/V/4Ssi7IA6lj++gQJCl69K+DpOw+D8tlPTMgey9FPWuoW9TO0wXvV
 evjjM9Y0ehJ8eq6Qg5JJWZUruOgiZbZhaUKEeuh5LVxjyUTwWhnS/4K8alS2AWN1Q+WRifnto57
 tq8/x4srND5HoeGvGXWHptSoj2oUPVDZPnCx6cdCSF/YNaE0NNQbmMbCyAFwDdvil9Hu2x7jMe8
 kK7nmakwfCYqFND3O4/KrCh+IrSvBb3xr0A+sVUJ+Q0bUbTYluKnfMOBPseGKc/p19ELBUlXZdi
 gcqCZJnUx+s5z3z/azmv0jJolGa4Daf1Rmcy+mODS/PUhYslXXqKEhAL3Oaoz0+1lDY8/Kg+L4O
 ejakRzhtRmrYRORKY03YpSr0zULayA=
X-Received: by 2002:a05:6000:2502:b0:439:d755:a895 with SMTP id
 ffacd0b85a97d-43b6426d7b8mr24914965f8f.42.1774365082829; 
 Tue, 24 Mar 2026 08:11:22 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64717e97sm40781916f8f.35.2026.03.24.08.11.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 08:11:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/11] qdev: Add a SsidSizeMode property type
Date: Tue, 24 Mar 2026 15:11:07 +0000
Message-ID: <20260324151111.237411-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324151111.237411-1-peter.maydell@linaro.org>
References: <20260324151111.237411-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

From: Nathan Chen <nathanc@nvidia.com>

Introduce a new enum type property allowing to set a Substream ID size
for HW-accelerated smmuv3. Values are auto and 0..20. The auto value
allows SSID size property to be derived from host IOMMU capabilities.
A value of 0 disables SubstreamID, while non-zero values specify the
SSID size in bits.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Shameer Kolothum <skolothumtho@nvidia.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
Message-id: 20260323182454.1416110-5-nathanc@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/core/qdev-properties-system.c         | 14 ++++++++++++++
 include/hw/core/qdev-properties-system.h |  3 +++
 qapi/misc-arm.json                       | 16 ++++++++++++++++
 qapi/pragma.json                         |  1 +
 4 files changed, 34 insertions(+)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index a402321f42..4aca1d4326 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -18,6 +18,7 @@
 #include "qapi/qapi-types-block.h"
 #include "qapi/qapi-types-machine.h"
 #include "qapi/qapi-types-migration.h"
+#include "qapi/qapi-types-misc-arm.h"
 #include "qapi/qapi-visit-virtio.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/ctype.h"
@@ -723,6 +724,19 @@ const PropertyInfo qdev_prop_zero_page_detection = {
     .set_default_value = qdev_propinfo_set_default_value_enum,
 };
 
+/* --- SsidSizeMode --- */
+
+QEMU_BUILD_BUG_ON(sizeof(SsidSizeMode) != sizeof(int));
+
+const PropertyInfo qdev_prop_ssidsize_mode = {
+    .type = "SsidSizeMode",
+    .description = "ssidsize mode: auto, 0-20",
+    .enum_table = &SsidSizeMode_lookup,
+    .get = qdev_propinfo_get_enum,
+    .set = qdev_propinfo_set_enum,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
+};
+
 /* --- Reserved Region --- */
 
 /*
diff --git a/include/hw/core/qdev-properties-system.h b/include/hw/core/qdev-properties-system.h
index ec21732ce5..4708885164 100644
--- a/include/hw/core/qdev-properties-system.h
+++ b/include/hw/core/qdev-properties-system.h
@@ -14,6 +14,7 @@ extern const PropertyInfo qdev_prop_multifd_compression;
 extern const PropertyInfo qdev_prop_mig_mode;
 extern const PropertyInfo qdev_prop_granule_mode;
 extern const PropertyInfo qdev_prop_zero_page_detection;
+extern const PropertyInfo qdev_prop_ssidsize_mode;
 extern const PropertyInfo qdev_prop_losttickpolicy;
 extern const PropertyInfo qdev_prop_blockdev_on_error;
 extern const PropertyInfo qdev_prop_bios_chs_trans;
@@ -61,6 +62,8 @@ extern const PropertyInfo qdev_prop_virtio_gpu_output_list;
 #define DEFINE_PROP_ZERO_PAGE_DETECTION(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_zero_page_detection, \
                        ZeroPageDetection)
+#define DEFINE_PROP_SSIDSIZE_MODE(_n, _s, _f, _d) \
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_ssidsize_mode, SsidSizeMode)
 #define DEFINE_PROP_LOSTTICKPOLICY(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_losttickpolicy, \
                         LostTickPolicy)
diff --git a/qapi/misc-arm.json b/qapi/misc-arm.json
index f921d740f1..416b4240e2 100644
--- a/qapi/misc-arm.json
+++ b/qapi/misc-arm.json
@@ -45,3 +45,19 @@
 #                     { "version": 3, "emulated": false, "kernel": true } ] }
 ##
 { 'command': 'query-gic-capabilities', 'returns': ['GICCapability'] }
+
+##
+# @SsidSizeMode:
+#
+# SMMUv3 SubstreamID size configuration mode.
+#
+# @auto: derive from host IOMMU capabilities
+#
+# Values 0-20: SSIDSIZE value in bits.  0 disables SubstreamID.
+#
+# Since: 11.0
+##
+{ 'enum': 'SsidSizeMode',
+  'data': [ 'auto', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
+            '10', '11', '12', '13', '14', '15', '16', '17', '18',
+            '19', '20' ] } # order matters, see ssidsize_mode_to_value()
diff --git a/qapi/pragma.json b/qapi/pragma.json
index 193bc39059..24aebbe8f5 100644
--- a/qapi/pragma.json
+++ b/qapi/pragma.json
@@ -68,6 +68,7 @@
         'S390CpuEntitlement',
         'S390CpuPolarization',
         'S390CpuState',
+        'SsidSizeMode',
         'String',
         'StringWrapper',
         'SysEmuTarget',
-- 
2.43.0


