Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EA1606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 23:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GWOrofWG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VpmY5+/+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJfVv-0007YO-6Z; Wed, 21 Oct 2026 19:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJfVt-0007XM-DR
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 19:14:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJfVr-0004zv-F3
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 19:14:29 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LKeO2I1723153
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 23:14:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=bzFIQRElvAD
 RWus62g5u6DUWVHkFSdL6BCzGT/m056g=; b=GWOrofWG7YMpCWCR2o2Jqo91XmA
 7/t7C58Me36Wlqnra8Q7kG2LSk1c9DCiX+VJY0SE/uzTzsTN8eM5CbG2aN/azwST
 7iujPlI8V1i4AF5IIX1AK9oVDqxKj8BqriC7+/kA2vffSFZlx4taM7psD6OJtWt9
 Wysax4zStf73X5lfmE2hUrj4oE627W5nwliQdyezi1G9zTxcwkjnKy55L85Xe3uV
 T3tdz2BzUm3dzpE6NeQ2a1VmJ2fOU42reiDbe4PRw/JbXDZK0ERDBrjPlMQouoZ4
 27ajbqLv88LSUu4rY5D/I6tg6W5hfDnUOv18Xi1roQOOnFTanwu2OmHKY/Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hetj4b5cm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 23:14:26 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5338c215ed2so18893201cf.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 16:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792624465; x=1793229265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bzFIQRElvADRWus62g5u6DUWVHkFSdL6BCzGT/m056g=;
 b=VpmY5+/+z0LHzW1kAzRyCeuCAPrQXc4YYe3j02kpqI+3kiR5TaC7MvmTg0v4XVZB9N
 fQaqG+picmWPka7JHhduxPj7jix5I00t7wNP92TrIcEISuZBMR0n+YlVvy3X0nvzDd/h
 u0yOUwd4rq07NS6P3d6N5zNfhvL5NOIhavNAsrkSytQJnu36LJrhm9fBMHVjTHEUh9Bj
 nKdiMicXjRQuyOAnTywdOS6Gcj+SmsH+Hm2u8ezkRs9/FIhKuSZ/weRvblymkG5Ri6zR
 KEiSVieNCrIfOT7dPnscm6CSnzkGsOx/rrzD+GjoJwBuGxxBNl1UjFpI9GSyngd8wHU7
 n7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792624465; x=1793229265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bzFIQRElvADRWus62g5u6DUWVHkFSdL6BCzGT/m056g=;
 b=XtLNXH5AiDfzlq2yhgbfPTiwV3RcnKxi0OdfEtZ9gLpvTwABWpRF5zlH+VAbwj9fu/
 N2pASNOTdVkq4/rYsHxe+5Lna8Gvs8+GouoOFAo9+xDCfbVW0Adn+TmzhecQJH5OPhvh
 XbFdnGZxRrg2SmIdDK6aYtHd5EmK/uqNdENueDb8MjSkcXptWAUxR1+lIU5e6joPUkrM
 yD5Pv+wDKWFrzceExDaEz/W49NnPScGpqmfDLLp07aQ0SeXA4ob8H+TAkBsNfGHA8crp
 SXj1lgSI8A8IDg4mCxFKte/9EnW+ojtzrEWhEMSayEw+yvhskYnAgEZWN385j2cbGsdX
 Aksg==
X-Gm-Message-State: AFq9FYJ0HEWkNf0Xfe3+xcfIGOP78eLkEaeLW820xfb+Z88+kHEjlNMZ
 mPozx4kJnGWcYcry3gpC4/5B6YZ/uj5vwA2DVXmTZLpQo5Sl9rH3nkKAPMrojfgs6GdY275Eh5W
 ufKEYvzBInNlPdGSDclkKr9B9QqPAg4i5mNVAqkQ6Sxz+qU64quJY+aq/XOKf9olndw==
X-Gm-Gg: AYBFou26scgVEz7EJdI6/Ei4EOBoQnsh9N6PlObySiXMZjMzgQc+SrrQO4nzo1Z1XUP
 2n6HinghyS0BKES2rXfCRAFsAnVRP3RCe3V/vYf/7gNbMdZ2l88CSI83MtiYWQE1pFmdp6XNo+K
 +AWDE8j7DmIzWUw7WbMCEPtDOGDNT0RPMpzsiKUv7VccOlZJ+ntNQTdjcPGYSkCEiK6vEphWarJ
 4v2EU1Tkq8Jc3zw5NMagE8d7ZFKyb+19L9aMhqqjKvpBsFIu1vod5r27gGoMpT0MMbGDm+xQozk
 0EY9mso4fU6HKElN4TUaTBqfj6mZD+943cwXpJkIIrXmfINqfnkBqRuMUn7pBf4/F9H+bwAUIeM
 FNVYAPahHfVJQlM5kOCNzaUQCw8w901Afa8gK0MxaA/SDDXMefDaVyxzbWvqZzmZkSLELZZXw2g
 ==
X-Received: by 2002:ac8:5d45:0:b0:535:f20:c828 with SMTP id
 d75a77b69052e-5369b6176cdmr60746081cf.24.1792624465070; 
 Wed, 21 Oct 2026 16:14:25 -0700 (PDT)
X-Received: by 2002:ac8:5d45:0:b0:535:f20:c828 with SMTP id
 d75a77b69052e-5369b6176cdmr60745661cf.24.1792624464631; 
 Wed, 21 Oct 2026 16:14:24 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com
 (200-204-190-237.dsl.telesp.net.br. [200.204.190.237])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-536ab6cd0dcsm11995651cf.6.2026.10.21.16.14.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 16:14:24 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 antikostya2@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 09/18] test/qtest: add riscv-trace-test.c
Date: Wed, 21 Oct 2026 20:13:36 -0300
Message-ID: <20261021231346.2452179-10-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
References: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: k_zjlGvW7hw9ZImKbd4pzI-PARUCsDjg
X-Proofpoint-GUID: k_zjlGvW7hw9ZImKbd4pzI-PARUCsDjg
X-Authority-Analysis: v=2.4 cv=N768hG9B c=1 sm=1 tr=0 ts=6ad94752 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=QmVDPCq3bE4LYXGvZ20s0w==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=3p2-zMZ1ap-INAhg5P8A:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA5MiBTYWx0ZWRfX5B8Aby9j5Inn
 lndDQ9YXDTZUI2uthaxAZuQ9l0s9eD1rIGyFzwb/46hNT0EVXhBC4xn8BLeuTNTq5xGdLn4yZNl
 FyY0TaG3Cr8yx18QpOUHt1bfwiFv2dmqGsqU5rsugsolVIMr4Q4skeW/qgVaPBY79InmZFx2iZ0
 4lRiQT1oG6uz4lG6KSDGZJ4Y0kPj0A5BsEHqUDBDnV+7tAQHVEuWSCWBeNcZkmH94cbGnWC26J4
 EOp+m52Tg3ldVrHSzySaUALSgWXFYuzEwy6nDGAqZTdN9O+APRj8FsBwr0CKSq3+/PpGwNbKr7t
 +vwudB4l25aFGjVYFrkuKqsFwvpzFRfyFIc+985T71LOZ0jLOkOXlqe//hVrIKpJ1F6kCwjBzKw
 Z/OmbyucEBDX84TNdA5aq3ZKrYp7w3rIZjNUjGqOY0PMLTx5qSoRTtA7Zbp3EpMyzf3sXmXmhU1
 xWSZqj4dgdbheKi/w5Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA5MiBTYWx0ZWRfX0TJCp6V7hWzq
 vvgBoAHv75BslZemBQPw7diGTcjvMIEFRjZAwNfNg/lqRBSJcgkwcOgvk5i5cHTvznIslN/kJw3
 4X/IDStPqzu7wKqAWUWNpeZUUx8HmWU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210092
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a simple smoke test for the trace encoder/trace ram sink integration
with the RISC-V 'virt' machine.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/virt.c                |   2 +-
 tests/qtest/meson.build        |   2 +-
 tests/qtest/riscv-trace-test.c | 120 +++++++++++++++++++++++++++++++++
 3 files changed, 122 insertions(+), 2 deletions(-)
 create mode 100644 tests/qtest/riscv-trace-test.c

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 6bc8d384ec..60d1ab3a90 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -889,7 +889,7 @@ static void virt_machine_init(MachineState *machine)
                                 hart_count, &error_abort);
         sysbus_realize(SYS_BUS_DEVICE(&s->soc[i]), &error_fatal);
 
-        if (tcg_enabled()) {
+        if (tcg_enabled()  || qtest_enabled()) {
             virt_init_socket_trace_hw(s, i);
         }
 
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 019c63ca60..b1249eb733 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -311,7 +311,7 @@ qtests_s390x = \
 qtests_riscv32 = \
   (config_all_devices.has_key('CONFIG_SIFIVE_E_AON') ? ['sifive-e-aon-watchdog-test'] : [])
 
-qtests_riscv64 = ['riscv-csr-test'] + \
+qtests_riscv64 = ['riscv-csr-test', 'riscv-trace-test'] + \
   (unpack_edk2_blobs ? ['bios-tables-test'] : []) + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
diff --git a/tests/qtest/riscv-trace-test.c b/tests/qtest/riscv-trace-test.c
new file mode 100644
index 0000000000..8015a00b76
--- /dev/null
+++ b/tests/qtest/riscv-trace-test.c
@@ -0,0 +1,120 @@
+/*
+ * Testcase for RISC-V Trace framework
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "qemu/timer.h"
+#include "qemu/bitops.h"
+#include "libqtest.h"
+#include "hw/core/registerfields.h"
+
+/* taken from virt machine memmap */
+#define TE_BASE   0x3020000
+#define TRAM_BASE 0x6000000
+
+REG32(TR_TE_CONTROL, 0x0)
+    FIELD(TR_TE_CONTROL, ACTIVE, 0, 1)
+    FIELD(TR_TE_CONTROL, ENABLE, 1, 1)
+    FIELD(TR_TE_CONTROL, INST_TRACING, 2, 1)
+
+REG32(TR_RAM_START_LOW, 0x010)
+    FIELD(TR_RAM_START_LOW, ADDR, 0, 32)
+REG32(TR_RAM_START_HIGH, 0x014)
+    FIELD(TR_RAM_START_HIGH, ADDR, 0, 32)
+
+REG32(TR_RAM_LIMIT_LOW, 0x018)
+    FIELD(TR_RAM_LIMIT_LOW, ADDR, 0, 32)
+REG32(TR_RAM_LIMIT_HIGH, 0x01C)
+    FIELD(TR_RAM_LIMIT_HIGH, ADDR, 0, 32)
+
+REG32(TR_RAM_WP_LOW, 0x020)
+    FIELD(TR_RAM_WP_LOW, WRAP, 0, 1)
+    FIELD(TR_RAM_WP_LOW, ADDR, 0, 32)
+REG32(TR_RAM_WP_HIGH, 0x024)
+    FIELD(TR_RAM_WP_HIGH, ADDR, 0, 32)
+
+static uint32_t test_read_te_control(QTestState *qts)
+{
+    return qtest_readl(qts, TE_BASE + A_TR_TE_CONTROL);
+}
+
+static void test_write_te_control(QTestState *qts, uint32_t val)
+{
+    qtest_writel(qts, TE_BASE + A_TR_TE_CONTROL, val);
+}
+
+static uint64_t test_read_tram_ramstart(QTestState *qts)
+{
+    uint64_t reg = qtest_readl(qts, TRAM_BASE + A_TR_RAM_START_HIGH);
+
+    reg <<= 32;
+    reg += qtest_readl(qts, TRAM_BASE + A_TR_RAM_START_LOW);
+    return reg;
+}
+
+static uint64_t test_read_tram_writep(QTestState *qts)
+{
+    uint64_t reg = qtest_readl(qts, TRAM_BASE + A_TR_RAM_WP_HIGH);
+
+    reg <<= 32;
+    reg += qtest_readl(qts, TRAM_BASE + A_TR_RAM_WP_LOW);
+    return reg;
+}
+
+static void test_trace_simple(void)
+{
+    QTestState *qts = qtest_init("-machine virt -accel tcg");
+    double timeout_sec = 0.5;
+    uint64_t reg_tram_start, reg_tram_writep;
+    uint32_t reg;
+
+    reg = test_read_te_control(qts);
+    reg = FIELD_DP32(reg, TR_TE_CONTROL, ACTIVE, 1);
+    test_write_te_control(qts, reg);
+    reg = test_read_te_control(qts);
+    g_assert(1 == FIELD_EX32(reg, TR_TE_CONTROL, ACTIVE));
+
+    reg = FIELD_DP32(reg, TR_TE_CONTROL, ENABLE, 1);
+    test_write_te_control(qts, reg);
+    reg = test_read_te_control(qts);
+    g_assert(1 == FIELD_EX32(reg, TR_TE_CONTROL, ENABLE));
+
+    /*
+     * Verify if RAM Sink write pointer is equal to
+     * ramstart before start tracing.
+     */
+    reg_tram_start = test_read_tram_ramstart(qts);
+    g_assert(reg_tram_start > 0);
+    reg_tram_writep = test_read_tram_writep(qts);
+    g_assert(reg_tram_writep == reg_tram_start);
+
+    reg = FIELD_DP32(reg, TR_TE_CONTROL, INST_TRACING, 1);
+    test_write_te_control(qts, reg);
+    reg = test_read_te_control(qts);
+    g_assert(1 == FIELD_EX32(reg, TR_TE_CONTROL, INST_TRACING));
+
+    g_test_timer_start();
+    for (;;) {
+        reg_tram_writep = test_read_tram_writep(qts);
+        if (reg_tram_writep > reg_tram_start) {
+            break;
+        }
+
+        g_assert(g_test_timer_elapsed() <= timeout_sec);
+    }
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char *argv[])
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("/riscv-trace-test/test-trace-simple",
+                   test_trace_simple);
+    return g_test_run();
+}
-- 
2.43.0


