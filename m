Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C0EE92FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 18:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaIIy-0004p5-CD; Mon, 29 Dec 2025 13:49:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vaIHR-0003ir-VI
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:47:53 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vaIHO-0008Go-VO
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:47:45 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BTAaeTY3707398
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 18:47:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=jB7s287ImVQ
 mlj6vQ16omhmtdA6siCilAT9/Kg/k5fQ=; b=VLtH81F7BmBUEb0lXrP0bnHkXw9
 aYAfI+O/tUt4kTeltNqS9n99qkFrsysj5ETqyKTL073kQHpvsVQLixmWk9Tgalog
 YixPmSD69Fkml0OFRjDaIoiLeYZpihOl5+HrkcLJZsn6jHaIGpfx6GjCZvd3YboH
 JGVfpNt6L7k8j16XNbgMXTaHop9WGibdwODEf02QpmmE5w600ZcXLrtZ6xP6dmhC
 AVoc/OzuzdccRBCHG1cFK50NoYFP6CumzVxi5ex2RMykeNhl1Fxbhp2Vg3oXk9GQ
 juvUXpJVqrn2jcLn9uCGuaFeNtVg+2/Fkp6179FpG7aYFQwmt5lK5ubTv0w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba6sg552v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 18:47:42 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-29f13989cd3so282592805ad.1
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 10:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767034061; x=1767638861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jB7s287ImVQmlj6vQ16omhmtdA6siCilAT9/Kg/k5fQ=;
 b=RDK+df537Dgc6XVOm91UydirSyKAEVhoPM9jgo1vnwqdoD/uei2oU239qPs46ny1Zc
 pUFVy6xPXycOV3NfjGuV8ejnp9BfavHfj54SEORHxcUmih9phm8Jd7pCSz6XpC1uwfq4
 BKkETvUlYDtcBqhMiboFzM2rwbB60sEjGn5X5pQMmXrpVhloWaP0HT+6Pbg6GLczVXrx
 tN5hZ6BoeXI5SiqWH3GDYZWsW2lLbPMOINsYtPeAvdDrygUlgW8vTvT7Ng2YKIu3K4u8
 21wbQVUSi2OjkZmTO6VBfAIBqSnAYv0jvNHcW4cKxwG7zikFnIYbqDUq7bNKXBG1+4im
 KwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767034061; x=1767638861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jB7s287ImVQmlj6vQ16omhmtdA6siCilAT9/Kg/k5fQ=;
 b=f6h4eWYH/j0fbbwQcZVXmqcGWqoAsaFux8cocVtpc6ZKBXossEusKcKI690xhrrMq9
 JbX+8ueGACbL8oBfaphTqU6/d3m7rTiOPZm5EAganif/RUvUHGiBPm5FOMANFPEhDjxj
 6QATeLhlfTyQ98Qk/KSY/vA87sGgUF/y6s31roJRhsF3GxAEoeamUFGzoFoaQ9bArhPN
 watG3BwKuqjjBm83HafH/G2ubHQFEJT9YeW3v1+1/Wod0IbUef0/Lr+M7wwN0CWqEbxb
 jciFWoiMFo+l1SoKDN5CwKpua7gDjL+8NEeQWBV9lHUIC2U3JzMLETHaGlRy+WFmwHh6
 M+3A==
X-Gm-Message-State: AOJu0YzQIrWiUftVZX7lfQ/YJkSruvRT1/BJ96iJPo41ePcNPiRNGKcC
 gZg69JAsMryYspnTha5ofUUDCd6ZUQOhP54Ita8F0bgLV7LjqhOVDydBqCvYchlgbX1ZZ53YcWE
 u8jgwLhYXbC6vKaI+EBYeBcW0FDjjrhiDLzsZpwtp28bSEJHno+RHbGluWsoEv2GvEg==
X-Gm-Gg: AY/fxX5f8SNox/cu0VPf2t3ZJYcxChRMHswPRAPyAiBerTZvtj9V6/Ioh7DARkO++u7
 xINAj/4BfHWQZZjEXaW0D5k9plrmfL6X9GXWbTlZBbmncobCbxSe7HP3oH/aKau+TKXFRjoGfT/
 aiyIMwfr4r8H5brhp3FzKL8CHe62hb+tcx6dHr4tJifdlwC3tVQMAkDFD3A1e/VySHjImnqZ7GE
 1QDntss/f9aHAmJCiDT0+Qkffm+LPfvOEWcMrqX4KNSPSubh7IsQs3466wk4NKXp4BCAvhsGuP4
 27BLp4ycmkpnmukFUsMaA/4xduvh1vRSq0DPhv4zoeninhvXBSPQJfeBLfmWdZvnZQz7J2qnT6b
 NUEDNh30voD169iyMPCx4KasQgAeOs9sGodZXx3l0AzzMzTE=
X-Received: by 2002:a17:903:1a2b:b0:295:592f:94a3 with SMTP id
 d9443c01a7336-2a2f2936a66mr293042965ad.48.1767034060851; 
 Mon, 29 Dec 2025 10:47:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGG4PGjIDKZvISzv0K0Km/vcEOLU4R/VajQi0ba4hrtm6yR57YMPgHkWNtUaJOnw6VP5s4nag==
X-Received: by 2002:a17:903:1a2b:b0:295:592f:94a3 with SMTP id
 d9443c01a7336-2a2f2936a66mr293042755ad.48.1767034060332; 
 Mon, 29 Dec 2025 10:47:40 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.101.184.177])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c82aa8sm282198705ad.31.2025.12.29.10.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 10:47:40 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v3 09/17] test/qtest: add riscv-trace-test.c
Date: Mon, 29 Dec 2025 15:46:48 -0300
Message-ID: <20251229184656.2224369-10-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251229184656.2224369-1-daniel.barboza@oss.qualcomm.com>
References: <20251229184656.2224369-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: XO6ygFyfLIIlN4QADxui6Zj7x2rGT9m6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDE3MiBTYWx0ZWRfX+YA4WliISv2d
 i3HDO4mL0qjsjiyYHSDNINim5O3a4eENJiQqJG4n73+EoPe3FsSC15PNR1bePaMiUCMQKHxXYPZ
 S5cBqAHOqfgpge0ZMwad5VQwUJ9l1SYiuWCL7ikiJ/sKl4nAbUSKK5ocF+idut5MwkLNuymFN+Y
 FVY2JD8XiPBpkzAAKwux/pn8zfe5B0GW/r3dOjE/+fOwSmrqXzBfULuJRcEnFPFwbSeO7PHEU+6
 q2jS8lNwouU+3hEYWixfbb6++8s/sRlHQd3zdjEYHu2NyaTe6n7fzyrXvuragjV1PO+ndkIEkpr
 a0BV2s/l/TDxU5QvQOtVJWtVVBz2Y/f9i7hWgKIqKYjdX9aDsEiNPBLwx+oXmJN5DUQNRIHnjOf
 vpXW27gAFaeBRdgAzlcHirCgbTcaDxf8ZRPLBycQU2q0ro7x+molzQ+9/GIRWeKPVVwCf4zxmTh
 OM6MY8JulCOolD6IfPw==
X-Proofpoint-ORIG-GUID: XO6ygFyfLIIlN4QADxui6Zj7x2rGT9m6
X-Authority-Analysis: v=2.4 cv=Y+L1cxeN c=1 sm=1 tr=0 ts=6952ccce cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=cW5wcbexNO3A0Ml9TiDm9w==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=cHopOgYuk8M715C2ZhYA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_06,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512290172
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 30e89a6c5a..fe49b1eda2 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1711,7 +1711,7 @@ static void virt_machine_init(MachineState *machine)
                                 hart_count, &error_abort);
         sysbus_realize(SYS_BUS_DEVICE(&s->soc[i]), &error_fatal);
 
-        if (tcg_enabled()) {
+        if (tcg_enabled()  || qtest_enabled()) {
             virt_init_socket_trace_hw(s, i);
         }
 
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 669d07c06b..07663c4836 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -281,7 +281,7 @@ qtests_s390x = \
 qtests_riscv32 = \
   (config_all_devices.has_key('CONFIG_SIFIVE_E_AON') ? ['sifive-e-aon-watchdog-test'] : [])
 
-qtests_riscv64 = ['riscv-csr-test'] + \
+qtests_riscv64 = ['riscv-csr-test', 'riscv-trace-test'] + \
   (unpack_edk2_blobs ? ['bios-tables-test'] : [])
 
 qos_test_ss = ss.source_set()
diff --git a/tests/qtest/riscv-trace-test.c b/tests/qtest/riscv-trace-test.c
new file mode 100644
index 0000000000..fe1cc85358
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
+#include "hw/registerfields.h"
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
2.51.1


