Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51142CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhbt-00014z-Ef; Fri, 16 Oct 2026 09:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHfEx-0006hc-Ej; Fri, 16 Oct 2026 06:32:43 -0400
Received: from out203-205-221-231.mail.qq.com ([203.205.221.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHfEt-0004q9-GA; Fri, 16 Oct 2026 06:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1792146753; bh=+pvtlscJyweE+6uH1ANFrshUnjzzvMWtiPvGlUo8ChY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=EmvebSVGQL0FcKgU2h46R7CG4k9SFVjntKDOyzyNTepMttTSKgryb7Ra01iPfT7E7
 3pmhXz2vqDAIAztvYjnQqKQY0LaTkA+/hGXMhBWSFq/KXYgN+i4GF+rOp8fPsEJyja
 GVeIilJiBHQRdejxbJ7CXoozcmqn+soLDh30xGok=
Received: from r00799764-ThinkCentre-M920t-N000.. ([139.159.170.67])
 by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
 id 81E21EB9; Fri, 16 Oct 2026 18:32:30 +0800
X-QQ-mid: xmsmtpt1792146750tu45fhs72
Message-ID: <tencent_E9186FE529AD6EC21F51EF364CEA6426EF05@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9XzRRe3Ik1rmuLLx10trhHlRxVD6VbSkk1/DA4tWrBQi6MmdofJH
 cDWp7bPRKYw1NepyHDMqmwZLY9siGz1Gcd2TrDGP8bhGtifFBVSBnthRSP8MF1J3MsmdfHgm7S+B
 D9uVaZkSxjKnvkaqUappiahyIevU2aDWu5aqNmCnrNr3Gi0yXwgQxA0xhpeElP/P4l9DkZQGt/tD
 xK+5farQzA7wtdy45rw4bZwb3uOmjAfkhbd7zncHKf4VqwpqV4Lh/FB11E0O8BSSW0ANUYpZgA7K
 NmUwc72A7IE4JRmnrcofuvzzsNSaT3JBsQZSFIwnN4czOAgALWF/TLAQY5nFVT6rL6CYiLJ+a/dT
 y05doqr5sRl3HdBvvxotXRZmlszYR7dlYAn0vOr9UAM/tXzdGd0FX5eAyY/TmRknSjQ9uXLGudnw
 XWseTWF40LxGaXzxPHGW3irgZ/16UEub61vY5KkvCE4WPM6X7lc1yjtecBzwqyBFq2clPuO3bHqz
 6IRdN5NPt3WhRIsQ3P3Qlcco3KGiOci7ZF428ykcr9IZziMUxABJEv2K/TlkZ4m7u1hqwwVe0TNU
 zcgLPZqlCaHHxjX35iFX6H912LxYjok5dMKDUARh5wXCLJMqUztxDjRQ73BPyX2VW76tshwCW122
 bjKoTk4hsxrGXCFzeQgS8QmkOGdWHJJ6a02Pr4DKEtycG+kT1WM2faFT5rR2ZTlMrqEy7phfJCj1
 1DG1a+4b266kVk10YYjCZgmo4O9+ZyxeizbCI5CECd2rgOPmMvoqtaP4wqnEh49jdd3edc4aUPDE
 jbieKHc1HMKlmJ5Zj1Hn+qZkPdeL5hkCTn51Tr4NDRWsxj/EFRSHlZG7uf3qK6V2ILU3OJ6qnOmH
 LHIk1SB4hEK2VhtJELc0oX5lh3imMdVpWfmFempu4CDaIYq1asCG6EaA2KwmkKo6UOVXCj9LS85X
 /tBmAwH56pd4cvlK8BlrFRfYleoC5c3d4BCs6RHJgSpS/ChbNCCV40HgN7SyjTTCn0qqRmoM7OKB
 K52XZth35YHmnptvZMCrj9qAQ6lqwROPg1YHfedRJYH1imk585x8vpv1DeIkuJUDbf13o98QBxT+
 LN7Ip3tj+DfOrsaiKXR6DYNlIgqg==
X-QQ-XMRINFO: OW8WShJdN8S2Y5iKw6Z8myepVl+s6/kk+g==
From: Jinjie Ruan <2118537295@qq.com>
To: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: ruanjinjie@huawei.com
Subject: [PATCH 36/37] qapi: Add MPAM cache introspection schema and stub
Date: Fri, 16 Oct 2026 18:10:56 +0800
X-OQ-MSGID: <20261016101058.1900808-22-2118537295@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016101058.1900808-1-2118537295@qq.com>
References: <20261016101058.1900808-1-2118537295@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.205.221.231; envelope-from=2118537295@qq.com;
 helo=out203-205-221-231.mail.qq.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 16 Oct 2026 09:02:47 -0400
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Add the query-mpam-cache QMP command schema: the MpamBm bitmap
type, the per-RIS MpamRegs state and the MpamCacheInfo summary of
a cache MSC, plus an optional cache level filter.  The command is
stubbed to return NULL so the generated marshal links; the real
implementation walks the device tree in the next patch.

Based on an RFC series by Jonathan Cameron, adapted to the current
qapi documentation rules.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 hw/arm/meson.build       |   1 +
 hw/arm/mpam-qapi-stubs.c |  14 +++++
 qapi/meson.build         |   1 +
 qapi/mpam.json           | 120 +++++++++++++++++++++++++++++++++++++++
 qapi/qapi-schema.json    |   1 +
 5 files changed, 137 insertions(+)
 create mode 100644 hw/arm/mpam-qapi-stubs.c
 create mode 100644 qapi/mpam.json

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 42ca75b..adf9146 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -107,6 +107,7 @@ arm_common_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_peripherals.c'))
 arm_common_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2838_peripherals.c'))
 arm_common_ss.add(when: 'CONFIG_STRONGARM', if_true: files('strongarm.c'))
 arm_common_ss.add(when: 'CONFIG_MPAM', if_true: files('mpam.c'))
+arm_common_ss.add(files('mpam-qapi-stubs.c'))
 arm_common_ss.add(when: 'CONFIG_SX1', if_true: files('omap_sx1.c'))
 arm_common_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
 arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
diff --git a/hw/arm/mpam-qapi-stubs.c b/hw/arm/mpam-qapi-stubs.c
new file mode 100644
index 0000000..77735ed
--- /dev/null
+++ b/hw/arm/mpam-qapi-stubs.c
@@ -0,0 +1,14 @@
+/*
+ * QEMU MPAM QMP command stubs
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-mpam.h"
+
+MpamCacheInfoList *qmp_query_mpam_cache(bool has_level, int64_t level,
+                                        Error **errp)
+{
+    return NULL;
+}
diff --git a/qapi/meson.build b/qapi/meson.build
index a46269b..c6663e5 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -42,6 +42,7 @@ qapi_all_modules = [
   'machine-s390x',
   'migration',
   'misc',
+  'mpam',
   'net',
   'pragma',
   'qom',
diff --git a/qapi/mpam.json b/qapi/mpam.json
new file mode 100644
index 0000000..ff476a1
--- /dev/null
+++ b/qapi/mpam.json
@@ -0,0 +1,120 @@
+# -*- Mode: Python -*-
+# vim: filetype=python
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+##
+# = ARM MPAM State Introspection
+##
+
+##
+# @MpamBm:
+#
+# A bitmap control value, as used by MPAM cache-portion (CPBM) and
+# memory-bandwidth-portion (MBW_PBM) controls.  The value is
+# carried as an array of 32-bit words, least significant first.
+#
+# @words: The bitmap, one element per 32-bits of the control
+#
+# Since: 10.1
+##
+{ 'struct': 'MpamBm',
+  'data' : { 'words' : [ 'int' ]
+           }
+}
+
+##
+# @MpamRegs:
+#
+# Per RIS register state of an emulated MPAM Memory System Component.
+#
+# @idr: MPAMF_IDR, the MPAM features identification register
+#
+# @iidr: MPAMF_IIDR, the MPAM implementer identification register
+#
+# @aidr: MPAMF_AIDR, the MPAM architecture identification register
+#
+# @cpor-idr: MPAMF_CPOR_IDR, cache-portion feature register
+#
+# @ccap-idr: MPAMF_CCAP_IDR, cache-capacity feature register
+#
+# @mbw-idr: MPAMF_MBW_IDR, memory-bandwidth feature register
+#
+# @pri-idr: MPAMF_PRI_IDR, priority feature register
+#
+# @partid-nrw-idr: MPAMF_PARTID_NRW_IDR, PARTID narrowing register
+#
+# @msmon-idr: MPAMF_MSMON_IDR, monitor feature register
+#
+# @csumon-idr: MPAMF_CSUMON_IDR, cache-usage monitor register
+#
+# @mbwumon-idr: MPAMF_MBWUMON_IDR, memory-bandwidth monitor register
+#
+# @ecr: MPAMF_ECR, the error control register
+#
+# @esr: MPAMF_ESR, the error status register
+#
+# @cfg-part-sel: MPAMCFG_PART_SEL, the partition-selection register
+#
+# @cfg-cpbm: The configured cache-portion bitmaps, one per
+#     internal PARTID
+#
+# Since: 10.1
+##
+{ 'struct' : 'MpamRegs',
+  'data' : { 'idr' : 'int',
+             'iidr' : 'int',
+             'aidr' : 'int',
+             'cpor-idr': 'int',
+             'ccap-idr': 'int',
+             'mbw-idr': 'int',
+             'pri-idr': 'int',
+             'partid-nrw-idr': 'int',
+             'msmon-idr': 'int',
+             'csumon-idr': 'int',
+             'mbwumon-idr': 'int',
+             'ecr': 'int',
+             'esr': 'int',
+             'cfg-part-sel': 'int',
+             'cfg-cpbm': ['MpamBm']#lazy
+          }
+}
+
+##
+# @MpamCacheInfo:
+#
+# Information about an MPAM cache Memory System Component.
+#
+# @cpu: First CPU of the set associated with the cache
+#
+# @level: Level of cache
+#
+# @type: Type of cache
+#
+# @regs: The per RIS register state
+#
+# Since: 10.1
+##
+{ 'struct': 'MpamCacheInfo',
+  'data' : { 'cpu' : 'int',
+             'level' : 'int',
+             'type' : 'int',
+             'regs' : ['MpamRegs']
+           }
+}
+
+##
+# @query-mpam-cache:
+#
+# Get a list of MpamCacheInfo for all Cache related MSC
+#
+# @level: Provide a cache level to filter against
+#
+# Returns: a list of @MpamCacheInfo describing all
+#   the MPAM cache MSC instances
+#
+# Since: 10.1
+##
+{ 'command': 'query-mpam-cache',
+  'data': { '*level': 'int' },
+  'returns' : ['MpamCacheInfo'],
+  'allow-preconfig': true }
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index b93dd68..cef175d 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -64,6 +64,7 @@
 { 'include': 'replay.json' }
 { 'include': 'yank.json' }
 { 'include': 'misc.json' }
+{ 'include': 'mpam.json' }
 { 'include': 'misc-arm.json' }
 { 'include': 'misc-i386.json' }
 { 'include': 'audio.json' }
-- 
2.43.0


