Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCA4C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Xg2-00083U-O1; Mon, 07 Sep 2026 07:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1x3Xg0-00080A-NM
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 07:38:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1x3Xfw-0001jZ-IR
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 07:38:16 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687AnMMd3777241
 for <qemu-devel@nongnu.org>; Mon, 7 Sep 2026 11:38:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=bK2Bi1T8fbP
 peePoq9EgpY53Rpm2m0RKlNUMJXuHLC4=; b=EWQW5qWCkm821KGuHfVNujTj50+
 PXmnb2Ep/2XUUidoV9lA76Lip1X6TVUw1xUHVwToiTYFdDicQwluPOMM3k0lwCEE
 EQQgZBmWKgnNcerlRelSODfwmjCGKJy7iiC8aJTzWfNRFWZwoBxjefHs0idi0qmJ
 GR3MYY7M4cDhUqFY6e8ZPuByEjSBA5+ct9HHuhp0gsm6bCtRjejheOYcsAWcQr9L
 KTj18AZV6MI+Pd31UJZ7QQHBKJAnjFr/xT8G5Uu76GrzCuYUqnVJwh2vcCHwhK5r
 Vl9b18UgYrMjtGmjQvaTtQzQ9R9zmSsW24/04rZCO3ATXAJ2POVcdTr15zA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghsfygvvd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 11:38:11 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-399271df9d8so812602a91.2
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 04:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788781090; x=1789385890; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bK2Bi1T8fbPpeePoq9EgpY53Rpm2m0RKlNUMJXuHLC4=;
 b=apyOaRZV+QzcIvLoaedNjEDv50annnbPL/9q93pzOwRsBmvIna/GbyIu78SDuW2kCW
 RcskGTBHEOd7xJkFZyJ9KJE3s2y2tzds0jbTjdbUSv342HvNnM9F9m/Qv/UiSNOxg7gk
 EsU75v0LbVGpwt9cyysClt0eSWCw7GTEajUKi2sUrBVoPXOIRUJXNtV6NLTCpsuHgrE/
 WSZ67x27AHAVfeCGp/+xzLk8MEaKwiZEE3NAc3BsKjrAsooBdJGHO1TtpA1lFhfWzym+
 W2YrkEQHlcpOtX0pUZYUVyvTG4CWahxw2xCXX4Lhxm55v2V2r6GeuzJkBvsCwIl+aCIe
 KTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788781090; x=1789385890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bK2Bi1T8fbPpeePoq9EgpY53Rpm2m0RKlNUMJXuHLC4=;
 b=UQw/WyEsQz1y8HMnOhirsMEEPmngdMG8gIT1NP4VIuGcfEiewVTN+LxxdAeVZ8C+nh
 +CWYBMNxmOXWCPY/q4fwf4ajQAaG4L67cHtKEo8yFgVM7mhWotZ4xQUnNJTmCJ7gl4cf
 +te0FefoXIjBQLtGOFFaLW8ZIR6YcdN8x77xowTlk5adMpLHLfEo9AjU8qT81Qxvp5iq
 J38f+pVIm/1TJIGEQcq+VkZ+KJh/fnEHAlwbgrTkfwVkwHp+SbiGOUSvulc3PKW4IQFD
 CBhY1iKLEtBjskgPV/QstC95AaoJfF6kr0S+uzOf9px08R2JTrS9IIzI/knn3YWm7ago
 DS9Q==
X-Gm-Message-State: AFuF++nykmdkbDMHvyxMxrWiKd40MK9yU/wSjRVdLnwgAGJcNklb9s3A
 F0y8pgmq9fUg9rT3kaKGqVlJQbrUc/RX88cs/TGgtQsTZROiOZr8SjvyF4crDFpjpf6k/ZhK/l6
 n5hODCXRABB6CKrLty5F+rV6a8T3yOYJiRf4/JDt7l6zi88ciOoq1igkh11N5RcutGg==
X-Gm-Gg: AYBFou1ALh5jbcINaoWSvvxXqQ8u7d0JfsemhCwND3KWDF1w6IQPoCKJxetsLNSNEoQ
 4ErmlLutjSOb+4vgCB4al5SpYTbA2VyEcQa/CmY/LgpCol3b1NFS6VpPk7UoO/8mPrbt0U0Buac
 LvBdfR9O7UK5EySDRa1NqGxt3ztJ3MYjFJiCeqqneC+LirT5nUxglDmcMATXz4o02xIvrn78/zc
 G2W8Xh+46WTg+L7LSsA2mnoHNJrpXVkD6VBucLlUYisE/aTaMoQ/tiSDhgFqXcTs23lleBINm6q
 xt6EzCjU2heCuZVwG+j8eO/1tdIreO6UucB2TofwRMLDrixW7ogi8IaGTP4u139sGan4+IfUIQp
 9LNoPX/b6nbIPeO/36Y34+kUMqlhJL4xIX2gr5y6d4wUyp++1SiQ7sdI2CJpCJyqkGFDaCrqFhr
 uzW6U/n1HK4Q+r78iLIXew7dV+qwEwH4g=
X-Received: by 2002:a17:90b:2786:b0:395:4df3:8800 with SMTP id
 98e67ed59e1d1-39b3d3eb82fmr14689596a91.0.1788781089772; 
 Mon, 07 Sep 2026 04:38:09 -0700 (PDT)
X-Received: by 2002:a17:90b:2786:b0:395:4df3:8800 with SMTP id
 98e67ed59e1d1-39b3d3eb82fmr14689537a91.0.1788781089026; 
 Mon, 07 Sep 2026 04:38:09 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33517b57ac8sm17169507eec.28.2026.09.07.04.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 04:38:08 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH v1 2/2] tests/qtest: split RISC-V RPMI tests by machine
Date: Mon,  7 Sep 2026 17:07:15 +0530
Message-ID: <20260907113715.1219775-3-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907113715.1219775-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20260907113715.1219775-1-subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 4T-87PaD1OYzK_M36vD6-yjm8_wgpvmy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEyOCBTYWx0ZWRfX9wdzEWDe02Er
 TDwuDSeMMMImrMkWrRuSwPNsiNqs/ZO3ZdwvELuAqoHd4JQZR11J3zTLskMWPOADEkkCyH3D9zH
 /QH4QUPew/TdjB32tJrL/nGHPIJA+32MPcnk6yXGi4XBHSiXmSDfopsiChb1+qyO5r9+cwPv6jn
 1hEIU759Cf/IWi8xz+A5AXtYO7YlYW6wYqXLLxC49ToqH3tQES41pX/AuCJsLK1/zE8Bd9d+KNT
 kfYs2sT/j78LUqxOm033/DqDi3T4MSN7Z9pAT/PMK7gKWn3QVl9TBtDQXH05YDztI7m4SWXkXwB
 SEZU70fOQktKSOEXaAUSJJuZpm14iZ5uDYb/t0kRxfgR3P+xee450pv08bNH+1dq0mJsx82ITSN
 BJZQpWzmrhZYuuvvpnXemn1dP8ZnQXgkbnFOzq647kBWp7HekvuqlX88dgCJp8IacvW6fhjf2No
 Z2kRl0fq80G6diEgxjg==
X-Proofpoint-GUID: 4T-87PaD1OYzK_M36vD6-yjm8_wgpvmy
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEyOCBTYWx0ZWRfXz4mC0SACbu0s
 q+emsi8G4QXCp2JOD94ei3f75EKwQGxiG7EwJyvFDUyUyi6FcErUndebFxvkLlsipdxA586vvRM
 ih0/yvpKtJU9YL8L/zLWvLCzVXTtuno=
X-Authority-Analysis: v=2.4 cv=AduB2XXG c=1 sm=1 tr=0 ts=6a9ea223 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=01Cn3ppf6CKYpVBXuLwA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070128
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Keep the reusable RPMI protocol tests in riscv-rpmi-test.c and expose
them through a common registration helper. The machine-specific test
files now only describe board policy and select the common coverage they
can run.

Move virt-only policy checks into riscv-rpmi-virt-test.c, including the
rpmi=on/off coverage and the virt max-hart rejection case. The virt test
binary continues to register the full RPMI protocol coverage.

Add a riscv-server-ref test binary that rejects the virt-only rpmi
property and then registers the meaningful shared protocol subset for the
board: Base, System Reset, reset cleanup, negative doorbell/queue
handling, migration blocking, HSM, and System Suspend. Server-ref
intentionally skips only the virt-specific optional-machine-property
cases and the extra virt-only topology/reset stress cases.

Keeping the common protocol body shared avoids duplicating the virt test
implementation as more RISC-V machines add RPMI coverage. Update
MAINTAINERS so the split RPMI qtest files continue to reach the RISC-V
maintainers.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
---
 MAINTAINERS                              |   2 +-
 tests/qtest/meson.build                  |   4 +-
 tests/qtest/riscv-rpmi-server-ref-test.c |  36 ++
 tests/qtest/riscv-rpmi-test.c            | 476 ++++++++++++-----------
 tests/qtest/riscv-rpmi-test.h            | 131 +++++++
 tests/qtest/riscv-rpmi-virt-test.c       |  45 +++
 6 files changed, 469 insertions(+), 225 deletions(-)
 create mode 100644 tests/qtest/riscv-rpmi-server-ref-test.c
 create mode 100644 tests/qtest/riscv-rpmi-test.h
 create mode 100644 tests/qtest/riscv-rpmi-virt-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d2577f66b6..d85385213f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -374,7 +374,7 @@ F: hw/riscv/
 F: hw/intc/riscv*
 F: hw/misc/riscv_rpmi*
 F: include/hw/misc/riscv_rpmi.h
-F: tests/qtest/riscv-rpmi-test.c
+F: tests/qtest/riscv-rpmi*
 F: include/hw/char/riscv_htif.h
 F: include/hw/riscv/
 F: common-user/host/riscv*
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 96f9ba9d4b..5b1cb4b9a3 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -297,7 +297,7 @@ qtests_riscv32 = \
 qtests_riscv64 = ['riscv-csr-test'] + \
   (unpack_edk2_blobs ? ['bios-tables-test'] : []) + \
   (config_all_devices.has_key('CONFIG_RISCV_RPMI') ?
-   ['riscv-rpmi-test'] : []) + \
+   ['riscv-rpmi-virt-test', 'riscv-rpmi-server-ref-test'] : []) + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
    ['iommu-riscv-test'] : []) + \
@@ -412,6 +412,8 @@ qtests = {
   'ivshmem-test': [rt, '../../contrib/ivshmem-server/ivshmem-server.c'],
   'migration-test': test_migration_files + migration_tls_files + migration_colo_files,
   'pxe-test': files('boot-sector.c'),
+  'riscv-rpmi-server-ref-test': files('riscv-rpmi-test.c'),
+  'riscv-rpmi-virt-test': files('riscv-rpmi-test.c'),
   'pnv-xive2-test': files('pnv-xive2-common.c', 'pnv-xive2-flush-sync.c',
                           'pnv-xive2-nvpg_bar.c'),
   'qos-test': [chardev, io, qos_test_ss.apply({}).sources()],
diff --git a/tests/qtest/riscv-rpmi-server-ref-test.c b/tests/qtest/riscv-rpmi-server-ref-test.c
new file mode 100644
index 0000000000..bed6f586bc
--- /dev/null
+++ b/tests/qtest/riscv-rpmi-server-ref-test.c
@@ -0,0 +1,36 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * QTests for riscv-server-ref RPMI support.
+ *
+ * Copyright (c) 2026 Qualcomm Technologies, Inc.
+ * Author:
+ *  Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
+ */
+
+#include "qemu/osdep.h"
+#include "riscv-rpmi-test.h"
+
+static void test_rpmi_rvserver_ref_rejects_rpmi_property(void)
+{
+    rpmi_expect_qemu_failure(
+        "-machine riscv-server-ref,rpmi=off -display none -S",
+        "Property 'riscv-server-ref-machine.rpmi' not found");
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    if (!qtest_has_machine("riscv-server-ref")) {
+        return g_test_run();
+    }
+
+    qtest_add_func("/riscv/rpmi/rvserver-ref/machine/rejects-rpmi-property",
+                   test_rpmi_rvserver_ref_rejects_rpmi_property);
+    rpmi_register_common_tests("/riscv/rpmi/rvserver-ref",
+                               &rvserver_ref_rpmi_machine,
+                               RPMI_QTEST_SERVER_REF);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/riscv-rpmi-test.c b/tests/qtest/riscv-rpmi-test.c
index fa23ab73db..e0557ccffa 100644
--- a/tests/qtest/riscv-rpmi-test.c
+++ b/tests/qtest/riscv-rpmi-test.c
@@ -1,7 +1,7 @@
 /*
  * SPDX-License-Identifier: GPL-2.0-or-later
  *
- * QTests for RISC-V RPMI devices.
+ * Common helpers for RISC-V RPMI qtests.
  *
  * Copyright (c) 2026 Qualcomm Technologies, Inc.
  * Author:
@@ -9,71 +9,49 @@
  */
 
 #include "qemu/osdep.h"
-#include <glib/gstdio.h>
-#include "libqtest.h"
+#include "riscv-rpmi-test.h"
 #include "qobject/qdict.h"
 
-#define RPMI_SHMEM_BASE 0x10200000ULL
-#define RPMI_DOORBELL_BASE 0x10230000ULL
-#define RPMI_SLOT_SIZE 64
-
-#define RPMI_A2P_HEAD RPMI_SHMEM_BASE
-#define RPMI_A2P_TAIL (RPMI_SHMEM_BASE + RPMI_SLOT_SIZE)
-#define RPMI_A2P_SLOT0 (RPMI_SHMEM_BASE + 2 * RPMI_SLOT_SIZE)
-
-#define RPMI_SRVGRP_BASE 0x0001
-#define RPMI_SRVGRP_SYSTEM_RESET 0x0003
-#define RPMI_SRVGRP_SYSTEM_SUSPEND 0x0004
-#define RPMI_SRVGRP_HSM 0x0005
-#define RPMI_BASE_SRV_GET_PLATFORM_INFO 0x05
-#define RPMI_BASE_SRV_PROBE_SERVICE_GROUP 0x06
-#define RPMI_SYSRST_SRV_GET_ATTRIBUTES 0x02
-#define RPMI_SYSRST_SRV_SYSTEM_RESET 0x03
-#define RPMI_HSM_SRV_GET_HART_STATUS 0x02
-#define RPMI_HSM_SRV_GET_HART_LIST 0x03
-#define RPMI_HSM_SRV_GET_SUSPEND_TYPES 0x04
-#define RPMI_HSM_SRV_GET_SUSPEND_INFO 0x05
-#define RPMI_HSM_SRV_HART_START 0x06
-#define RPMI_HSM_SRV_HART_STOP 0x07
-#define RPMI_HSM_SRV_HART_SUSPEND 0x08
-#define RPMI_SYSSUSP_SRV_GET_ATTRIBUTES 0x02
-#define RPMI_SYSSUSP_SRV_SYSTEM_SUSPEND 0x03
-#define RPMI_MSG_NORMAL_REQUEST 0x00
-#define RPMI_MSG_POSTED_REQUEST 0x01
-#define RPMI_MSG_ACKNOWLEDGEMENT 0x02
-#define RPMI_SYSRST_TYPE_SHUTDOWN 0x00
-#define RPMI_SYSRST_TYPE_COLD_REBOOT 0x01
-#define RPMI_SYSRST_TYPE_INVALID 0x03
-#define RPMI_SYSRST_ATTRS_FLAGS_RESETTYPE 1
-#define RPMI_TOKEN 0x55aa
-#define RPMI_ERR_NOTSUPP 0xfffffffeU
-#define RPMI_ERR_INVALID_PARAM 0xfffffffdU
-#define RPMI_ERR_INVALID_ADDR 0xfffffffbU
-#define RPMI_ERR_DENIED 0xfffffffcU
-#define RPMI_HSM_HART_STATE_STARTED 0x00
-#define RPMI_HSM_HART_STATE_STOPPED 0x01
-#define RPMI_HSM_HART_STATE_SUSPENDED 0x04
-#define RPMI_HSM_TEST_START_ADDR 0x80000000ULL
-#define RPMI_HSM_TEST_RESUME_ADDR 0x80001000ULL
-
-#define RPMI_P2A_ACK_BASE (RPMI_SHMEM_BASE + 16 * RPMI_SLOT_SIZE)
-#define RPMI_P2A_ACK_HEAD RPMI_P2A_ACK_BASE
-#define RPMI_P2A_ACK_TAIL (RPMI_P2A_ACK_BASE + RPMI_SLOT_SIZE)
-#define RPMI_P2A_ACK_SLOT0 (RPMI_P2A_ACK_BASE + 2 * RPMI_SLOT_SIZE)
-
+const RiscvRpmiQTestMachine virt_rpmi_machine = {
+    .machine_opts = "virt,rpmi=on",
+    .service_group_extra_args = ",aia=aplic-imsic",
+    .shmem_base = RPMI_SHMEM_BASE,
+    .doorbell_base = RPMI_DOORBELL_BASE,
+    .platform_info = "QEMU RISC-V virt RPMI",
+};
+
+const RiscvRpmiQTestMachine rvserver_ref_rpmi_machine = {
+    .machine_opts = "riscv-server-ref",
+    .service_group_extra_args = "",
+    .shmem_base = RVSERVER_RPMI_SHMEM_BASE,
+    .doorbell_base = RVSERVER_RPMI_DOORBELL_BASE,
+    .platform_info = "QEMU RISC-V server-ref RPMI",
+};
+
+uint64_t rpmi_shmem_base = RPMI_SHMEM_BASE;
+uint64_t rpmi_doorbell_base = RPMI_DOORBELL_BASE;
 static uint64_t rpmi_response_base;
 
+QTestState *rpmi_qtest_init(const RiscvRpmiQTestMachine *machine,
+                            const char *extra_args)
+{
+    rpmi_shmem_base = machine->shmem_base;
+    rpmi_doorbell_base = machine->doorbell_base;
+
+    return qtest_initf("-machine %s%s", machine->machine_opts, extra_args);
+}
+
 static uint64_t rpmi_queue_slot(uint64_t queue_base, uint32_t index)
 {
     return queue_base + (index + 2) * RPMI_SLOT_SIZE;
 }
 
-static void rpmi_send_request(QTestState *qts, uint16_t service_group,
-                              uint8_t service_id, uint8_t request_type,
-                              const uint32_t *data, size_t data_words)
+void rpmi_send_request(QTestState *qts, uint16_t service_group,
+                       uint8_t service_id, uint8_t request_type,
+                       const uint32_t *data, size_t data_words)
 {
     uint32_t tail = qtest_readl(qts, RPMI_A2P_TAIL);
-    uint64_t slot = rpmi_queue_slot(RPMI_SHMEM_BASE, tail);
+    uint64_t slot = rpmi_queue_slot(rpmi_shmem_base, tail);
     size_t i;
 
     qtest_writew(qts, slot, service_group);
@@ -90,21 +68,21 @@ static void rpmi_send_request(QTestState *qts, uint16_t service_group,
         "RPMI_A2P_REQ shmem=0x%016" PRIx64 " doorbell=0x%016" PRIx64
         " group=0x%04x service=0x%02x type=0x%02x data_len=%zu"
         " token=0x%04x a2p_tail=%u slot=0x%016" PRIx64,
-        (uint64_t)RPMI_SHMEM_BASE, (uint64_t)RPMI_DOORBELL_BASE,
+        (uint64_t)rpmi_shmem_base, (uint64_t)rpmi_doorbell_base,
         service_group, service_id, request_type, data_words * sizeof(*data),
         RPMI_TOKEN, tail, slot);
 
     qtest_writel(qts, RPMI_A2P_TAIL, (tail + 1) % 16);
-    qtest_writel(qts, RPMI_DOORBELL_BASE, 1);
+    qtest_writel(qts, rpmi_doorbell_base, 1);
 }
 
-static uint32_t rpmi_response_word(QTestState *qts, unsigned int word)
+uint32_t rpmi_response_word(QTestState *qts, unsigned int word)
 {
     return qtest_readl(qts, rpmi_response_base + 8 + word * sizeof(uint32_t));
 }
 
-static void rpmi_expect_ack(QTestState *qts, uint16_t service_group,
-                            uint8_t service_id, uint16_t data_len)
+void rpmi_expect_ack(QTestState *qts, uint16_t service_group,
+                     uint8_t service_id, uint16_t data_len)
 {
     uint32_t head = qtest_readl(qts, RPMI_P2A_ACK_HEAD);
     uint32_t tail = qtest_readl(qts, RPMI_P2A_ACK_TAIL);
@@ -124,23 +102,23 @@ static void rpmi_expect_ack(QTestState *qts, uint16_t service_group,
         " group=0x%04x service=0x%02x type=0x%02x data_len=%u"
         " token=0x%04x p2a_head=%u slot=0x%016" PRIx64
         " status=0x%08x",
-        (uint64_t)RPMI_SHMEM_BASE, service_group, service_id,
+        (uint64_t)rpmi_shmem_base, service_group, service_id,
         RPMI_MSG_ACKNOWLEDGEMENT, data_len, RPMI_TOKEN, head,
         rpmi_response_base,
         data_len >= sizeof(uint32_t) ? rpmi_response_word(qts, 0) : 0);
     qtest_writel(qts, RPMI_P2A_ACK_HEAD, (head + 1) % 16);
 }
 
-static void rpmi_send_sysreset(QTestState *qts, uint32_t reset_type,
-                               uint8_t request_type)
+void rpmi_send_sysreset(QTestState *qts, uint32_t reset_type,
+                        uint8_t request_type)
 {
     rpmi_send_request(qts, RPMI_SRVGRP_SYSTEM_RESET,
                       RPMI_SYSRST_SRV_SYSTEM_RESET, request_type,
                       &reset_type, 1);
 }
 
-static void rpmi_expect_qemu_failure(const char *extra_args,
-                                     const char *stderr_needle)
+void rpmi_expect_qemu_failure(const char *extra_args,
+                              const char *stderr_needle)
 {
     g_autoptr(GError) error = NULL;
     g_auto(GStrv) split_args = NULL;
@@ -169,47 +147,37 @@ static void rpmi_expect_qemu_failure(const char *extra_args,
     g_assert_nonnull(strstr(stderr_data, stderr_needle));
 }
 
-static void test_rpmi_machine_realize_off(void)
-{
-    QTestState *qts;
-
-    qts = qtest_init("-machine virt,rpmi=off");
-    qtest_quit(qts);
-}
-
-static void test_rpmi_machine_rejects_too_many_harts(void)
-{
-    rpmi_expect_qemu_failure(
-        "-machine virt,rpmi=on -smp 513 -display none -S",
-        "max CPUs supported by machine 'virt' is 512");
-}
-
-static void test_rpmi_base_platform_info(void)
+void rpmi_check_platform_info(QTestState *qts, const char *expected)
 {
-    static const char expected[] = "QEMU RISC-V virt RPMI";
-    QTestState *qts;
+    size_t expected_len = strlen(expected) + 1;
     size_t i;
 
-    qts = qtest_init("-machine virt,rpmi=on");
     rpmi_send_request(qts, RPMI_SRVGRP_BASE,
                       RPMI_BASE_SRV_GET_PLATFORM_INFO,
                       RPMI_MSG_NORMAL_REQUEST, NULL, 0);
 
     rpmi_expect_ack(qts, RPMI_SRVGRP_BASE,
                     RPMI_BASE_SRV_GET_PLATFORM_INFO,
-                    2 * sizeof(uint32_t) + sizeof(expected));
+                    2 * sizeof(uint32_t) + expected_len);
     g_assert_cmphex(rpmi_response_word(qts, 0), ==, 0);
-    g_assert_cmphex(rpmi_response_word(qts, 1), ==, sizeof(expected));
-    for (i = 0; i < sizeof(expected); i++) {
+    g_assert_cmphex(rpmi_response_word(qts, 1), ==, expected_len);
+    for (i = 0; i < expected_len; i++) {
         g_assert_cmphex(qtest_readb(qts, RPMI_P2A_ACK_SLOT0 + 16 + i), ==,
                         expected[i]);
     }
+}
+
+void rpmi_test_platform_info(const RiscvRpmiQTestMachine *machine)
+{
+    QTestState *qts;
+
+    qts = rpmi_qtest_init(machine, "");
+    rpmi_check_platform_info(qts, machine->platform_info);
 
     qtest_quit(qts);
 }
 
-static void rpmi_probe_group(QTestState *qts, uint32_t service_group,
-                             bool present)
+void rpmi_probe_group(QTestState *qts, uint32_t service_group, bool present)
 {
     rpmi_send_request(qts, RPMI_SRVGRP_BASE,
                       RPMI_BASE_SRV_PROBE_SERVICE_GROUP,
@@ -226,11 +194,8 @@ static void rpmi_probe_group(QTestState *qts, uint32_t service_group,
     }
 }
 
-static void test_rpmi_base_probe_service_groups(void)
+void rpmi_check_service_groups(QTestState *qts)
 {
-    QTestState *qts;
-
-    qts = qtest_init("-machine virt,rpmi=on,aia=aplic-imsic");
     rpmi_probe_group(qts, RPMI_SRVGRP_BASE, true);
     qtest_system_reset(qts);
     rpmi_probe_group(qts, RPMI_SRVGRP_SYSTEM_RESET, true);
@@ -238,16 +203,102 @@ static void test_rpmi_base_probe_service_groups(void)
     rpmi_probe_group(qts, RPMI_SRVGRP_HSM, true);
     qtest_system_reset(qts);
     rpmi_probe_group(qts, RPMI_SRVGRP_SYSTEM_SUSPEND, true);
+}
+
+void rpmi_test_service_groups(const RiscvRpmiQTestMachine *machine,
+                              const char *extra_args)
+{
+    QTestState *qts;
+
+    qts = rpmi_qtest_init(machine, extra_args);
+    rpmi_check_service_groups(qts);
 
     qtest_quit(qts);
 }
 
-static void test_rpmi_sysreset_attrs(void)
+void rpmi_check_hsm_hart_list(QTestState *qts, uint32_t hart_count)
+{
+    uint32_t start_index = 0;
+
+    rpmi_send_request(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_GET_HART_LIST,
+                      RPMI_MSG_NORMAL_REQUEST, &start_index, 1);
+
+    rpmi_expect_ack(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_GET_HART_LIST,
+                    (3 + hart_count) * sizeof(uint32_t));
+    g_assert_cmphex(rpmi_response_word(qts, 0), ==, 0);
+    g_assert_cmphex(rpmi_response_word(qts, 1), ==, 0);
+    g_assert_cmphex(rpmi_response_word(qts, 2), ==, hart_count);
+    for (uint32_t i = 0; i < hart_count; i++) {
+        g_assert_cmphex(rpmi_response_word(qts, i + 3), ==, i);
+    }
+}
+
+void rpmi_test_hsm_hart_list(const RiscvRpmiQTestMachine *machine,
+                             const char *extra_args)
 {
     QTestState *qts;
+
+    qts = rpmi_qtest_init(machine, extra_args);
+    rpmi_check_hsm_hart_list(qts, 4);
+
+    qtest_quit(qts);
+}
+
+void rpmi_expect_hsm_status(QTestState *qts, uint32_t hart_id,
+                            uint32_t expected_state)
+{
+    rpmi_send_request(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_GET_HART_STATUS,
+                      RPMI_MSG_NORMAL_REQUEST, &hart_id, 1);
+    rpmi_expect_ack(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_GET_HART_STATUS,
+                    2 * sizeof(uint32_t));
+    g_assert_cmphex(rpmi_response_word(qts, 0), ==, 0);
+    g_assert_cmphex(rpmi_response_word(qts, 1), ==, expected_state);
+}
+
+uint64_t rpmi_hart_pc(QTestState *qts, uint32_t cpu_index)
+{
+    g_autofree char *registers = qtest_hmp(qts, "info registers %u",
+                                           cpu_index);
+    const char *pc_line;
+    uint64_t pc;
+
+    pc_line = strstr(registers, "\n pc");
+    g_assert_nonnull(pc_line);
+    g_assert_cmpint(sscanf(pc_line, "\n pc %" SCNx64, &pc), ==, 1);
+
+    return pc;
+}
+
+static void rpmi_add_common_test(const char *prefix, const char *name,
+                                 const RiscvRpmiQTestMachine *machine,
+                                 void (*fn)(const void *))
+{
+    g_autofree char *path = g_strdup_printf("%s/%s", prefix, name);
+
+    qtest_add_data_func(path, machine, fn);
+}
+
+static void test_rpmi_common_base_platform_info(const void *opaque)
+{
+    const RiscvRpmiQTestMachine *machine = opaque;
+
+    rpmi_test_platform_info(machine);
+}
+
+static void test_rpmi_common_base_probe_service_groups(const void *opaque)
+{
+    const RiscvRpmiQTestMachine *machine = opaque;
+
+    rpmi_test_service_groups(machine, machine->service_group_extra_args);
+}
+
+static void test_rpmi_common_sysreset_attrs(const void *opaque)
+{
+    const RiscvRpmiQTestMachine *machine = opaque;
+    QTestState *qts;
     uint32_t reset_type = RPMI_SYSRST_TYPE_SHUTDOWN;
 
-    qts = qtest_init("-machine virt,rpmi=on");
+    qts = rpmi_qtest_init(machine, "");
     rpmi_send_request(qts, RPMI_SRVGRP_SYSTEM_RESET,
                       RPMI_SYSRST_SRV_GET_ATTRIBUTES,
                       RPMI_MSG_NORMAL_REQUEST, &reset_type, 1);
@@ -281,33 +332,36 @@ static void test_rpmi_sysreset_attrs(void)
     qtest_quit(qts);
 }
 
-static void test_rpmi_sysreset_shutdown(void)
+static void test_rpmi_common_sysreset_shutdown(const void *opaque)
 {
+    const RiscvRpmiQTestMachine *machine = opaque;
     QTestState *qts;
 
-    qts = qtest_init("-machine virt,rpmi=on");
+    qts = rpmi_qtest_init(machine, "");
     rpmi_send_sysreset(qts, RPMI_SYSRST_TYPE_SHUTDOWN,
                        RPMI_MSG_POSTED_REQUEST);
     qtest_qmp_eventwait(qts, "SHUTDOWN");
     qtest_quit(qts);
 }
 
-static void test_rpmi_sysreset_cold_reboot(void)
+static void test_rpmi_common_sysreset_cold_reboot(const void *opaque)
 {
+    const RiscvRpmiQTestMachine *machine = opaque;
     QTestState *qts;
 
-    qts = qtest_init("-machine virt,rpmi=on -no-reboot");
+    qts = rpmi_qtest_init(machine, " -no-reboot");
     rpmi_send_sysreset(qts, RPMI_SYSRST_TYPE_COLD_REBOOT,
                        RPMI_MSG_POSTED_REQUEST);
     qtest_qmp_eventwait(qts, "SHUTDOWN");
     qtest_quit(qts);
 }
 
-static void test_rpmi_sysreset_invalid_type(void)
+static void test_rpmi_common_sysreset_invalid_type(const void *opaque)
 {
+    const RiscvRpmiQTestMachine *machine = opaque;
     QTestState *qts;
 
-    qts = qtest_init("-machine virt,rpmi=on");
+    qts = rpmi_qtest_init(machine, "");
     rpmi_send_sysreset(qts, RPMI_SYSRST_TYPE_INVALID,
                        RPMI_MSG_NORMAL_REQUEST);
 
@@ -319,12 +373,13 @@ static void test_rpmi_sysreset_invalid_type(void)
     qtest_quit(qts);
 }
 
-static void test_rpmi_repeated_reset_after_traffic(void)
+static void test_rpmi_common_repeated_reset_after_traffic(const void *opaque)
 {
+    const RiscvRpmiQTestMachine *machine = opaque;
     QTestState *qts;
     uint32_t reset_type = RPMI_SYSRST_TYPE_SHUTDOWN;
 
-    qts = qtest_init("-machine virt,rpmi=on,aia=aplic-imsic");
+    qts = rpmi_qtest_init(machine, machine->service_group_extra_args);
     for (uint32_t i = 0; i < 5; i++) {
         rpmi_send_request(qts, RPMI_SRVGRP_SYSTEM_RESET,
                           RPMI_SYSRST_SRV_GET_ATTRIBUTES,
@@ -339,11 +394,12 @@ static void test_rpmi_repeated_reset_after_traffic(void)
     qtest_quit(qts);
 }
 
-static void test_rpmi_reset_clears_transport(void)
+static void test_rpmi_common_reset_clears_transport(const void *opaque)
 {
+    const RiscvRpmiQTestMachine *machine = opaque;
     QTestState *qts;
 
-    qts = qtest_init("-machine virt,rpmi=on");
+    qts = rpmi_qtest_init(machine, "");
     rpmi_send_sysreset(qts, RPMI_SYSRST_TYPE_INVALID,
                        RPMI_MSG_NORMAL_REQUEST);
     rpmi_expect_ack(qts, RPMI_SRVGRP_SYSTEM_RESET,
@@ -353,43 +409,46 @@ static void test_rpmi_reset_clears_transport(void)
 
     g_assert_cmphex(qtest_readl(qts, RPMI_A2P_TAIL), ==, 0);
     g_assert_cmphex(qtest_readl(qts, RPMI_P2A_ACK_TAIL), ==, 0);
-    g_assert_cmphex(qtest_readl(qts, RPMI_DOORBELL_BASE), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, rpmi_doorbell_base), ==, 0);
 
     qtest_quit(qts);
 }
 
-static void test_rpmi_doorbell_invalid_access(void)
+static void test_rpmi_common_doorbell_invalid_access(const void *opaque)
 {
+    const RiscvRpmiQTestMachine *machine = opaque;
     QTestState *qts;
 
-    qts = qtest_init("-machine virt,rpmi=on");
-    qtest_writeb(qts, RPMI_DOORBELL_BASE, 1);
-    qtest_writel(qts, RPMI_DOORBELL_BASE + 4, 1);
-    g_assert_cmphex(qtest_readl(qts, RPMI_DOORBELL_BASE), ==, 0);
+    qts = rpmi_qtest_init(machine, "");
+    qtest_writeb(qts, rpmi_doorbell_base, 1);
+    qtest_writel(qts, rpmi_doorbell_base + 4, 1);
+    g_assert_cmphex(qtest_readl(qts, rpmi_doorbell_base), ==, 0);
 
     qtest_quit(qts);
 }
 
-static void test_rpmi_queue_bounds(void)
+static void test_rpmi_common_queue_bounds(const void *opaque)
 {
+    const RiscvRpmiQTestMachine *machine = opaque;
     QTestState *qts;
 
-    qts = qtest_init("-machine virt,rpmi=on");
+    qts = rpmi_qtest_init(machine, "");
     qtest_writel(qts, RPMI_A2P_TAIL, 0x1000);
-    qtest_writel(qts, RPMI_DOORBELL_BASE, 1);
+    qtest_writel(qts, rpmi_doorbell_base, 1);
     g_assert_cmphex(qtest_readl(qts, RPMI_A2P_HEAD), ==, 0);
     g_assert_cmphex(qtest_readl(qts, RPMI_P2A_ACK_TAIL), ==, 0);
 
     qtest_quit(qts);
 }
 
-static void test_rpmi_migration_blocked(void)
+static void test_rpmi_common_migration_blocked(const void *opaque)
 {
+    const RiscvRpmiQTestMachine *machine = opaque;
     QTestState *qts;
     QDict *error;
     const char *desc;
 
-    qts = qtest_init("-machine virt,rpmi=on -S");
+    qts = rpmi_qtest_init(machine, " -S");
     error = qtest_qmp_assert_failure_ref(qts,
         "{ 'execute': 'migrate',"
         "  'arguments': { 'uri': 'exec:cat > /dev/null' } }");
@@ -403,57 +462,32 @@ static void test_rpmi_migration_blocked(void)
     qtest_quit(qts);
 }
 
-static void test_rpmi_hsm_hart_list(void)
+static void test_rpmi_common_hsm_hart_list(const void *opaque)
 {
-    QTestState *qts;
-    uint32_t start_index = 0;
-
-    qts = qtest_init("-machine virt,rpmi=on -smp 4");
-    rpmi_send_request(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_GET_HART_LIST,
-                      RPMI_MSG_NORMAL_REQUEST, &start_index, 1);
-
-    rpmi_expect_ack(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_GET_HART_LIST,
-                    7 * sizeof(uint32_t));
-    g_assert_cmphex(rpmi_response_word(qts, 0), ==, 0);
-    g_assert_cmphex(rpmi_response_word(qts, 1), ==, 0);
-    g_assert_cmphex(rpmi_response_word(qts, 2), ==, 4);
-    g_assert_cmphex(rpmi_response_word(qts, 3), ==, 0);
-    g_assert_cmphex(rpmi_response_word(qts, 4), ==, 1);
-    g_assert_cmphex(rpmi_response_word(qts, 5), ==, 2);
-    g_assert_cmphex(rpmi_response_word(qts, 6), ==, 3);
+    const RiscvRpmiQTestMachine *machine = opaque;
 
-    qtest_quit(qts);
+    rpmi_test_hsm_hart_list(machine, " -smp 4");
 }
 
-static void test_rpmi_hsm_multi_socket_hart_list(void)
+static void test_rpmi_common_hsm_multi_socket_hart_list(const void *opaque)
 {
+    const RiscvRpmiQTestMachine *machine = opaque;
     QTestState *qts;
-    uint32_t start_index = 0;
 
-    qts = qtest_init("-machine virt,rpmi=on "
-                     "-smp 4,sockets=2,cores=2,threads=1");
-    rpmi_send_request(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_GET_HART_LIST,
-                      RPMI_MSG_NORMAL_REQUEST, &start_index, 1);
-
-    rpmi_expect_ack(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_GET_HART_LIST,
-                    7 * sizeof(uint32_t));
-    g_assert_cmphex(rpmi_response_word(qts, 0), ==, 0);
-    g_assert_cmphex(rpmi_response_word(qts, 1), ==, 0);
-    g_assert_cmphex(rpmi_response_word(qts, 2), ==, 4);
-    g_assert_cmphex(rpmi_response_word(qts, 3), ==, 0);
-    g_assert_cmphex(rpmi_response_word(qts, 4), ==, 1);
-    g_assert_cmphex(rpmi_response_word(qts, 5), ==, 2);
-    g_assert_cmphex(rpmi_response_word(qts, 6), ==, 3);
+    qts = rpmi_qtest_init(machine,
+                          " -smp 4,sockets=2,cores=2,threads=1");
+    rpmi_check_hsm_hart_list(qts, 4);
 
     qtest_quit(qts);
 }
 
-static void test_rpmi_hsm_hart_status(void)
+static void test_rpmi_common_hsm_hart_status(const void *opaque)
 {
+    const RiscvRpmiQTestMachine *machine = opaque;
     QTestState *qts;
     uint32_t hart_id = 3;
 
-    qts = qtest_init("-machine virt,rpmi=on -smp 4");
+    qts = rpmi_qtest_init(machine, " -smp 4");
     rpmi_send_request(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_GET_HART_STATUS,
                       RPMI_MSG_NORMAL_REQUEST, &hart_id, 1);
 
@@ -466,33 +500,9 @@ static void test_rpmi_hsm_hart_status(void)
     qtest_quit(qts);
 }
 
-static void rpmi_expect_hsm_status(QTestState *qts, uint32_t hart_id,
-                                   uint32_t expected_state)
-{
-    rpmi_send_request(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_GET_HART_STATUS,
-                      RPMI_MSG_NORMAL_REQUEST, &hart_id, 1);
-    rpmi_expect_ack(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_GET_HART_STATUS,
-                    2 * sizeof(uint32_t));
-    g_assert_cmphex(rpmi_response_word(qts, 0), ==, 0);
-    g_assert_cmphex(rpmi_response_word(qts, 1), ==, expected_state);
-}
-
-static uint64_t rpmi_hart_pc(QTestState *qts, uint32_t cpu_index)
-{
-    g_autofree char *registers = qtest_hmp(qts, "info registers %u",
-                                           cpu_index);
-    const char *pc_line;
-    uint64_t pc;
-
-    pc_line = strstr(registers, "\n pc");
-    g_assert_nonnull(pc_line);
-    g_assert_cmpint(sscanf(pc_line, "\n pc %" SCNx64, &pc), ==, 1);
-
-    return pc;
-}
-
-static void test_rpmi_hsm_hart_control(void)
+static void test_rpmi_common_hsm_hart_control(const void *opaque)
 {
+    const RiscvRpmiQTestMachine *machine = opaque;
     QTestState *qts;
     uint32_t hart_id = 1;
     uint32_t stop_request[] = { hart_id };
@@ -501,7 +511,7 @@ static void test_rpmi_hsm_hart_control(void)
     uint32_t start_index = 0;
     uint32_t suspend_type = 0;
 
-    qts = qtest_init("-machine virt,rpmi=on -smp 2");
+    qts = rpmi_qtest_init(machine, " -smp 2");
     rpmi_send_request(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_GET_SUSPEND_TYPES,
                       RPMI_MSG_NORMAL_REQUEST, &start_index, 1);
     rpmi_expect_ack(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_GET_SUSPEND_TYPES,
@@ -547,13 +557,14 @@ static void test_rpmi_hsm_hart_control(void)
     qtest_quit(qts);
 }
 
-static void test_rpmi_syssusp_attrs_and_suspend(void)
+static void test_rpmi_common_syssusp_attrs_and_suspend(const void *opaque)
 {
+    const RiscvRpmiQTestMachine *machine = opaque;
     QTestState *qts;
     uint32_t suspend_type = 0;
     uint32_t suspend_request[] = { 0, 0, 0x80000000, 0 };
 
-    qts = qtest_init("-machine virt,rpmi=on -smp 1");
+    qts = rpmi_qtest_init(machine, " -smp 1");
     rpmi_send_request(qts, RPMI_SRVGRP_SYSTEM_SUSPEND,
                       RPMI_SYSSUSP_SRV_GET_ATTRIBUTES,
                       RPMI_MSG_NORMAL_REQUEST, &suspend_type, 1);
@@ -578,48 +589,67 @@ static void test_rpmi_syssusp_attrs_and_suspend(void)
     qtest_quit(qts);
 }
 
-int main(int argc, char **argv)
-{
-    g_test_init(&argc, &argv, NULL);
-
-    if (qtest_has_machine("virt")) {
-        qtest_add_func("/riscv/rpmi/machine/realize-off",
-                       test_rpmi_machine_realize_off);
-        qtest_add_func("/riscv/rpmi/machine/rejects-too-many-harts",
-                       test_rpmi_machine_rejects_too_many_harts);
-        qtest_add_func("/riscv/rpmi/base/platform-info",
-                       test_rpmi_base_platform_info);
-        qtest_add_func("/riscv/rpmi/base/probe-service-groups",
-                       test_rpmi_base_probe_service_groups);
-        qtest_add_func("/riscv/rpmi/sysreset/attrs",
-                       test_rpmi_sysreset_attrs);
-        qtest_add_func("/riscv/rpmi/sysreset/shutdown",
-                       test_rpmi_sysreset_shutdown);
-        qtest_add_func("/riscv/rpmi/sysreset/cold-reboot",
-                       test_rpmi_sysreset_cold_reboot);
-        qtest_add_func("/riscv/rpmi/sysreset/invalid-type",
-                       test_rpmi_sysreset_invalid_type);
-        qtest_add_func("/riscv/rpmi/reset/clears-transport",
-                       test_rpmi_reset_clears_transport);
-        qtest_add_func("/riscv/rpmi/negative/doorbell-invalid-access",
-                       test_rpmi_doorbell_invalid_access);
-        qtest_add_func("/riscv/rpmi/negative/queue-bounds",
-                       test_rpmi_queue_bounds);
-        qtest_add_func("/riscv/rpmi/reset/repeated-after-traffic",
-                       test_rpmi_repeated_reset_after_traffic);
-        qtest_add_func("/riscv/rpmi/migration/blocked",
-                       test_rpmi_migration_blocked);
-        qtest_add_func("/riscv/rpmi/hsm/hart-list",
-                       test_rpmi_hsm_hart_list);
-        qtest_add_func("/riscv/rpmi/hsm/multi-socket-hart-list",
-                       test_rpmi_hsm_multi_socket_hart_list);
-        qtest_add_func("/riscv/rpmi/hsm/hart-status",
-                       test_rpmi_hsm_hart_status);
-        qtest_add_func("/riscv/rpmi/hsm/hart-control",
-                       test_rpmi_hsm_hart_control);
-        qtest_add_func("/riscv/rpmi/syssusp/attrs-and-suspend",
-                       test_rpmi_syssusp_attrs_and_suspend);
+void rpmi_register_common_tests(const char *prefix,
+                                const RiscvRpmiQTestMachine *machine,
+                                unsigned int coverage)
+{
+    if (coverage & RPMI_QTEST_BASE) {
+        rpmi_add_common_test(prefix, "base/platform-info", machine,
+                             test_rpmi_common_base_platform_info);
+        rpmi_add_common_test(prefix, "base/probe-service-groups", machine,
+                             test_rpmi_common_base_probe_service_groups);
     }
 
-    return g_test_run();
+    if (coverage & RPMI_QTEST_SYSRESET) {
+        rpmi_add_common_test(prefix, "sysreset/attrs", machine,
+                             test_rpmi_common_sysreset_attrs);
+        rpmi_add_common_test(prefix, "sysreset/shutdown", machine,
+                             test_rpmi_common_sysreset_shutdown);
+        rpmi_add_common_test(prefix, "sysreset/cold-reboot", machine,
+                             test_rpmi_common_sysreset_cold_reboot);
+        rpmi_add_common_test(prefix, "sysreset/invalid-type", machine,
+                             test_rpmi_common_sysreset_invalid_type);
+    }
+
+    if (coverage & RPMI_QTEST_RESET) {
+        rpmi_add_common_test(prefix, "reset/clears-transport", machine,
+                             test_rpmi_common_reset_clears_transport);
+    }
+
+    if (coverage & RPMI_QTEST_NEGATIVE) {
+        rpmi_add_common_test(prefix, "negative/doorbell-invalid-access",
+                             machine,
+                             test_rpmi_common_doorbell_invalid_access);
+        rpmi_add_common_test(prefix, "negative/queue-bounds", machine,
+                             test_rpmi_common_queue_bounds);
+    }
+
+    if (coverage & RPMI_QTEST_REPEATED_RESET) {
+        rpmi_add_common_test(prefix, "reset/repeated-after-traffic", machine,
+                             test_rpmi_common_repeated_reset_after_traffic);
+    }
+
+    if (coverage & RPMI_QTEST_MIGRATION) {
+        rpmi_add_common_test(prefix, "migration/blocked", machine,
+                             test_rpmi_common_migration_blocked);
+    }
+
+    if (coverage & RPMI_QTEST_HSM) {
+        rpmi_add_common_test(prefix, "hsm/hart-list", machine,
+                             test_rpmi_common_hsm_hart_list);
+        rpmi_add_common_test(prefix, "hsm/hart-status", machine,
+                             test_rpmi_common_hsm_hart_status);
+        rpmi_add_common_test(prefix, "hsm/hart-control", machine,
+                             test_rpmi_common_hsm_hart_control);
+    }
+
+    if (coverage & RPMI_QTEST_HSM_MULTI_SOCKET) {
+        rpmi_add_common_test(prefix, "hsm/multi-socket-hart-list", machine,
+                             test_rpmi_common_hsm_multi_socket_hart_list);
+    }
+
+    if (coverage & RPMI_QTEST_SYSSUSP) {
+        rpmi_add_common_test(prefix, "syssusp/attrs-and-suspend", machine,
+                             test_rpmi_common_syssusp_attrs_and_suspend);
+    }
 }
diff --git a/tests/qtest/riscv-rpmi-test.h b/tests/qtest/riscv-rpmi-test.h
new file mode 100644
index 0000000000..2fce0bb293
--- /dev/null
+++ b/tests/qtest/riscv-rpmi-test.h
@@ -0,0 +1,131 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Common helpers for RISC-V RPMI qtests.
+ *
+ * Copyright (c) 2026 Qualcomm Technologies, Inc.
+ * Author:
+ *  Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
+ */
+
+#ifndef QTEST_RISCV_RPMI_TEST_H
+#define QTEST_RISCV_RPMI_TEST_H
+
+#include "libqtest.h"
+
+#define RPMI_SHMEM_BASE 0x10200000ULL
+#define RPMI_DOORBELL_BASE 0x10230000ULL
+#define RVSERVER_RPMI_SHMEM_BASE 0x110000ULL
+#define RVSERVER_RPMI_DOORBELL_BASE 0x140000ULL
+#define RPMI_SLOT_SIZE 64
+
+#define RPMI_A2P_HEAD rpmi_shmem_base
+#define RPMI_A2P_TAIL (rpmi_shmem_base + RPMI_SLOT_SIZE)
+#define RPMI_A2P_SLOT0 (rpmi_shmem_base + 2 * RPMI_SLOT_SIZE)
+
+#define RPMI_SRVGRP_BASE 0x0001
+#define RPMI_SRVGRP_SYSTEM_RESET 0x0003
+#define RPMI_SRVGRP_SYSTEM_SUSPEND 0x0004
+#define RPMI_SRVGRP_HSM 0x0005
+#define RPMI_BASE_SRV_GET_PLATFORM_INFO 0x05
+#define RPMI_BASE_SRV_PROBE_SERVICE_GROUP 0x06
+#define RPMI_SYSRST_SRV_GET_ATTRIBUTES 0x02
+#define RPMI_SYSRST_SRV_SYSTEM_RESET 0x03
+#define RPMI_HSM_SRV_GET_HART_STATUS 0x02
+#define RPMI_HSM_SRV_GET_HART_LIST 0x03
+#define RPMI_HSM_SRV_GET_SUSPEND_TYPES 0x04
+#define RPMI_HSM_SRV_GET_SUSPEND_INFO 0x05
+#define RPMI_HSM_SRV_HART_START 0x06
+#define RPMI_HSM_SRV_HART_STOP 0x07
+#define RPMI_HSM_SRV_HART_SUSPEND 0x08
+#define RPMI_SYSSUSP_SRV_GET_ATTRIBUTES 0x02
+#define RPMI_SYSSUSP_SRV_SYSTEM_SUSPEND 0x03
+#define RPMI_MSG_NORMAL_REQUEST 0x00
+#define RPMI_MSG_POSTED_REQUEST 0x01
+#define RPMI_MSG_ACKNOWLEDGEMENT 0x02
+#define RPMI_SYSRST_TYPE_SHUTDOWN 0x00
+#define RPMI_SYSRST_TYPE_COLD_REBOOT 0x01
+#define RPMI_SYSRST_TYPE_INVALID 0x03
+#define RPMI_SYSRST_ATTRS_FLAGS_RESETTYPE 1
+#define RPMI_TOKEN 0x55aa
+#define RPMI_ERR_NOTSUPP 0xfffffffeU
+#define RPMI_ERR_INVALID_PARAM 0xfffffffdU
+#define RPMI_ERR_INVALID_ADDR 0xfffffffbU
+#define RPMI_ERR_DENIED 0xfffffffcU
+#define RPMI_HSM_HART_STATE_STARTED 0x00
+#define RPMI_HSM_HART_STATE_STOPPED 0x01
+#define RPMI_HSM_HART_STATE_SUSPENDED 0x04
+#define RPMI_HSM_TEST_START_ADDR 0x80000000ULL
+#define RPMI_HSM_TEST_RESUME_ADDR 0x80001000ULL
+
+#define RPMI_P2A_ACK_BASE (rpmi_shmem_base + 16 * RPMI_SLOT_SIZE)
+#define RPMI_P2A_ACK_HEAD RPMI_P2A_ACK_BASE
+#define RPMI_P2A_ACK_TAIL (RPMI_P2A_ACK_BASE + RPMI_SLOT_SIZE)
+#define RPMI_P2A_ACK_SLOT0 (RPMI_P2A_ACK_BASE + 2 * RPMI_SLOT_SIZE)
+
+typedef struct RiscvRpmiQTestMachine {
+    const char *machine_opts;
+    const char *service_group_extra_args;
+    uint64_t shmem_base;
+    uint64_t doorbell_base;
+    const char *platform_info;
+} RiscvRpmiQTestMachine;
+
+typedef enum RiscvRpmiQTestCoverage {
+    RPMI_QTEST_BASE = 1 << 0,
+    RPMI_QTEST_SYSRESET = 1 << 1,
+    RPMI_QTEST_RESET = 1 << 2,
+    RPMI_QTEST_NEGATIVE = 1 << 3,
+    RPMI_QTEST_MIGRATION = 1 << 4,
+    RPMI_QTEST_HSM = 1 << 5,
+    RPMI_QTEST_HSM_MULTI_SOCKET = 1 << 6,
+    RPMI_QTEST_SYSSUSP = 1 << 7,
+    RPMI_QTEST_REPEATED_RESET = 1 << 8,
+} RiscvRpmiQTestCoverage;
+
+#define RPMI_QTEST_ALL \
+    (RPMI_QTEST_BASE | RPMI_QTEST_SYSRESET | RPMI_QTEST_RESET | \
+     RPMI_QTEST_NEGATIVE | RPMI_QTEST_MIGRATION | RPMI_QTEST_HSM | \
+     RPMI_QTEST_HSM_MULTI_SOCKET | RPMI_QTEST_SYSSUSP | \
+     RPMI_QTEST_REPEATED_RESET)
+
+#define RPMI_QTEST_SERVER_REF \
+    (RPMI_QTEST_BASE | RPMI_QTEST_SYSRESET | RPMI_QTEST_RESET | \
+     RPMI_QTEST_NEGATIVE | RPMI_QTEST_MIGRATION | RPMI_QTEST_HSM | \
+     RPMI_QTEST_SYSSUSP)
+
+extern const RiscvRpmiQTestMachine virt_rpmi_machine;
+extern const RiscvRpmiQTestMachine rvserver_ref_rpmi_machine;
+
+extern uint64_t rpmi_shmem_base;
+extern uint64_t rpmi_doorbell_base;
+
+QTestState *rpmi_qtest_init(const RiscvRpmiQTestMachine *machine,
+                            const char *extra_args);
+void rpmi_send_request(QTestState *qts, uint16_t service_group,
+                       uint8_t service_id, uint8_t request_type,
+                       const uint32_t *data, size_t data_words);
+uint32_t rpmi_response_word(QTestState *qts, unsigned int word);
+void rpmi_expect_ack(QTestState *qts, uint16_t service_group,
+                     uint8_t service_id, uint16_t data_len);
+void rpmi_send_sysreset(QTestState *qts, uint32_t reset_type,
+                        uint8_t request_type);
+void rpmi_expect_qemu_failure(const char *extra_args,
+                              const char *stderr_needle);
+void rpmi_check_platform_info(QTestState *qts, const char *expected);
+void rpmi_test_platform_info(const RiscvRpmiQTestMachine *machine);
+void rpmi_probe_group(QTestState *qts, uint32_t service_group, bool present);
+void rpmi_check_service_groups(QTestState *qts);
+void rpmi_test_service_groups(const RiscvRpmiQTestMachine *machine,
+                              const char *extra_args);
+void rpmi_check_hsm_hart_list(QTestState *qts, uint32_t hart_count);
+void rpmi_test_hsm_hart_list(const RiscvRpmiQTestMachine *machine,
+                             const char *extra_args);
+void rpmi_expect_hsm_status(QTestState *qts, uint32_t hart_id,
+                            uint32_t expected_state);
+uint64_t rpmi_hart_pc(QTestState *qts, uint32_t cpu_index);
+void rpmi_register_common_tests(const char *prefix,
+                                const RiscvRpmiQTestMachine *machine,
+                                unsigned int coverage);
+
+#endif
diff --git a/tests/qtest/riscv-rpmi-virt-test.c b/tests/qtest/riscv-rpmi-virt-test.c
new file mode 100644
index 0000000000..3aa73d3286
--- /dev/null
+++ b/tests/qtest/riscv-rpmi-virt-test.c
@@ -0,0 +1,45 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * QTests for virt machine RPMI support.
+ *
+ * Copyright (c) 2026 Qualcomm Technologies, Inc.
+ * Author:
+ *  Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
+ */
+
+#include "qemu/osdep.h"
+#include "riscv-rpmi-test.h"
+
+static void test_rpmi_machine_realize_off(void)
+{
+    QTestState *qts;
+
+    qts = qtest_init("-machine virt,rpmi=off");
+    qtest_quit(qts);
+}
+
+static void test_rpmi_machine_rejects_too_many_harts(void)
+{
+    rpmi_expect_qemu_failure(
+        "-machine virt,rpmi=on -smp 513 -display none -S",
+        "max CPUs supported by machine 'virt' is 512");
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    if (!qtest_has_machine("virt")) {
+        return g_test_run();
+    }
+
+    qtest_add_func("/riscv/rpmi/virt/machine/realize-off",
+                   test_rpmi_machine_realize_off);
+    qtest_add_func("/riscv/rpmi/virt/machine/rejects-too-many-harts",
+                   test_rpmi_machine_rejects_too_many_harts);
+    rpmi_register_common_tests("/riscv/rpmi/virt", &virt_rpmi_machine,
+                               RPMI_QTEST_ALL);
+
+    return g_test_run();
+}
-- 
2.43.0


