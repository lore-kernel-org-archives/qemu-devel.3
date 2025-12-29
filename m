Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C27FE92FC4
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 18:48:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaIHp-0003jc-2y; Mon, 29 Dec 2025 13:48:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vaIH9-0003eW-84
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:47:30 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vaIH5-0008Ci-Og
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:47:26 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BT9jZbi4132692
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 18:47:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=u360LagNFk7
 FUB5x9rrpwVC1ofS1vEeWw6IFHLbKpj4=; b=cOtCGejUlf+43Vfdm53k9wz5PLm
 nyReUguHZNf8GYcXVmHsdY0IC6xOObfQoxpXoVd7YBYuyajLysuuVLWwu7Bbdhoa
 HSQbMphZXgjYg+Rx5Fwi7SF6KvzSeYz8QcprY8Sea6VlFStE5KShJDybOzYfGH/9
 LwY+xBwoJJsu9fHkeR7q0LXi5QIGAcRUAYDZ+CQU8jUERHyoErpD6YRlbEZmJiHo
 +6hbGJ8v3DHGBgrz07ilF4ViALa4bbGIytpchDa4h8/QBY1g9foYqMzbqTxiZFIC
 RgB6Tmt69Be3mJ6uRZ/lUI9fFk/oKIM09Krop+4KGRiOo1i4Z/3UnMvxAIQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba71ww4np-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 18:47:22 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2a090819ed1so77252925ad.2
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 10:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767034041; x=1767638841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u360LagNFk7FUB5x9rrpwVC1ofS1vEeWw6IFHLbKpj4=;
 b=bs3VSPG1ytROI3OS3VrmsjEzH/sIMFqDj9BKZUeoxN92+sagVI8Z0SUajw6MEX3Mgj
 YwolvIz7DXVuebA/fhu87m+buQ51uXKd59kM6R7MzoE/D6AqT/O0OSMjoA07lu2TeXNS
 oY2V5Yv9I/1Kam2IiotvkXnHLEYMX32sdGYtyAKc6s2Blcwtm8+FwQBu1gvr473vvOBO
 YpZauaYs+/U66KYoY9oDBFU1t2Ppt4GGcD+57BQT4hlJSD4f3SxCnpbxaVZDIVKi4vSJ
 gxP3pJcJt9e74n4lsZAAI09lc6MTp8cKPC3aFgdOjVMwGXgDgy4SIjo71XC/dV9/BQIJ
 c9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767034041; x=1767638841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u360LagNFk7FUB5x9rrpwVC1ofS1vEeWw6IFHLbKpj4=;
 b=EBDVqIsN0SyVulAnLXwsX6dPaZWDKLve9FoDZ0jylDllzafvUPBsdwk4GU6zpLmdyW
 kHTMRcZL+7XXGoQa/HvYJqN3qYnQOUEZOdFTD7brsSfHcgRYp3lpwXwy4y4vG6Q3PF2b
 LOw/j6fnTFtw0QAKZQKZ0jqKSqFboBywRrpgBKAQjOkGdd0p9rggcq/qB5m7j/T820Ty
 Adi/3S6H+FxrLDefnC35aoP1FTtxi2iNH4ZXJSGgDDhJ71xZU+zVOnrsLXAvIZc9edsw
 YWBgH+cSvZ+RjAz0PJDGVRfUjrjze2lK1Mdt0+Mu9jQweCwKjHB7dobtLVo0+GR4kdSN
 9Qyw==
X-Gm-Message-State: AOJu0YylAMU/7i4Bn8EoAzpB3Xp/fRwQ73SzXTKu6RTg+wj6Cy06bkby
 vhXm1UjYmO79+VkQebxk/yTpkG/CZz/uR1mA1Ql2MUSnGeki+sWQJrMwYyuApICei7Lw3i+dbXH
 po5XPhbOPwYhRmGJPfjRC+GrTACIHuvqPecer5HW+CO3QXNBhmT4UKIyb0m/TO4il8w==
X-Gm-Gg: AY/fxX5jNZ+DrPyi6RUP73RoZ0KqK3FRQOjcMA1MjthM7pKqRoUGdEr0GaaCNzar18E
 gepN7fJlaudM0R8UOvbVEnifX+i3i3ryE885vND3nvy1Z6szG5EbzVBa6VDZhbPt9ZDmOeXXdkA
 lx93+fLfhCVxO0ebnsW//BQQ8PlUUyfnwUC9VMBbmI9Ercp/F71JArSCpU5rx8NQHBETZQTeMox
 LI61moIjohPtybHyTOTiydRhMkP/2KQtoqGAfo2FnWTTTv4uaIZNHCPWDBSDlQpBLpyFsUny/EO
 f5Id050ZR4zMLzcMymhODVvo+PO3UJ6xErjwbG/VsZw30NySuBzfZfCGHSo8IO2JhES7CqauOWX
 bhPyjQtrUNfb75nmj+YosuYdugHgZUToB7hK2DvaJBz9UgyA=
X-Received: by 2002:a17:902:ea10:b0:295:5da6:6011 with SMTP id
 d9443c01a7336-2a2f2202e57mr308426065ad.11.1767034041312; 
 Mon, 29 Dec 2025 10:47:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsanv2ROBUGYDhEbQ+YR7+LDguWU+4ipw3ZypT0cYNSLiuvyGxi1FVASQ0kRHY5+HBZNyUBA==
X-Received: by 2002:a17:902:ea10:b0:295:5da6:6011 with SMTP id
 d9443c01a7336-2a2f2202e57mr308425795ad.11.1767034040689; 
 Mon, 29 Dec 2025 10:47:20 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.101.184.177])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c82aa8sm282198705ad.31.2025.12.29.10.47.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 10:47:20 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v3 02/17] hw/riscv: Trace RAM Sink initial impl
Date: Mon, 29 Dec 2025 15:46:41 -0300
Message-ID: <20251229184656.2224369-3-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251229184656.2224369-1-daniel.barboza@oss.qualcomm.com>
References: <20251229184656.2224369-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDE3MiBTYWx0ZWRfX1mbKN/mpm+v7
 q2DHJ6AfKNDkxTyu9bcp4NnsrQgnLHDnoFrBXbtwM/QVXnfCt7g68OBYPwhXvWNP+JiNHsgw5HA
 lU1g/fBVjGM/Y+lcyp64EVIJRU35gTQX81tPdumxFeDgQ7YzLbfUYYMyuX9kPOdjgprUl8rDIne
 JG0RIsAb5WuXQG1cDQwfVBy+AJXJe5ISBxJLOPkOcXR4tqhI/CnwWBdoN1Vj1IbLRsjr8oD2B0E
 lXjSYbJ3/aQavo9rqht67Y/a9nK/qdI8kq9ANdRtXxO09WCbkzVRfHG1x+lX3ndIXMfEi3x9HRR
 KFte7dt5juXjEPnW8Qr9cpicCPJMFIBD+cRADad8pJeSPcE2RbX4xtKbiJHNAp9kZ7SfyZ1FsSN
 +8/Tvs6d4XkYkovchqFqxhBI4xLHA0AxsHjubmpujyH50l0c9IOvLQnLpejHLhgmwWjDtOvPa1G
 8wleukqrnC6IMkuZ8ZQ==
X-Proofpoint-ORIG-GUID: _wpOjFn02xmiBYwxuD4PbJOLj-tbtAvo
X-Proofpoint-GUID: _wpOjFn02xmiBYwxuD4PbJOLj-tbtAvo
X-Authority-Analysis: v=2.4 cv=CK4nnBrD c=1 sm=1 tr=0 ts=6952ccba cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=cW5wcbexNO3A0Ml9TiDm9w==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=aqjgF2fw9fj3PC3FA9IA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_06,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
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

Following the effort to implement the basic support for Efficient Trace
(e-trace) in QEMU we'll add a Trace RAM Sink implementation.

Similar to the Trace Encoder, this is inspired in both the Efficient
Trace for RISC-V [1] and  RISC-V Trace Control Interface Specification
[2] specs. It implements a minimal set of features to get started - only
SMEM will be supported for now.

We'll implement the RAM sink logic in the next patches, although most of
the work will be done by the trace encoder.

[1] https://github.com/riscv-non-isa/riscv-trace-spec/releases/download/v2.0-20250616/riscv-trace-spec-asciidoc.pdf
[2] https://github.com/riscv-non-isa/tg-nexus-trace/releases/download/1.0_Ratified/RISC-V-Trace-Control-Interface.pdf

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/meson.build      |   2 +-
 hw/riscv/trace-events     |   4 +
 hw/riscv/trace-ram-sink.c | 263 ++++++++++++++++++++++++++++++++++++++
 hw/riscv/trace-ram-sink.h |  83 ++++++++++++
 4 files changed, 351 insertions(+), 1 deletion(-)
 create mode 100644 hw/riscv/trace-ram-sink.c
 create mode 100644 hw/riscv/trace-ram-sink.h

diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index b4a9988a62..2aadbe1e50 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -14,6 +14,6 @@ riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
 	'riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c', 'riscv-iommu-hpm.c'))
 riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-generic.c'))
 riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangshan_kmh.c'))
-riscv_ss.add(when: 'CONFIG_RISCV_TRACE', if_true: files('trace-encoder.c'))
+riscv_ss.add(when: 'CONFIG_RISCV_TRACE', if_true: files('trace-encoder.c', 'trace-ram-sink.c'))
 
 hw_arch += {'riscv': riscv_ss}
diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
index 0cbf6ffcb6..14e333fd9e 100644
--- a/hw/riscv/trace-events
+++ b/hw/riscv/trace-events
@@ -28,3 +28,7 @@ riscv_iommu_hpm_evt_write(uint32_t ctr_idx, uint32_t ovf, uint64_t val) "ctr_idx
 # trace-encoder.c
 trencoder_read_error(uint64_t addr) "addr 0x%" PRIx64
 trencoder_write_error(uint64_t addr, uint64_t value) "addr 0x%" PRIx64 " value 0x%" PRIx64
+
+# trace-ram-sink.c
+tr_ramsink_read_error(uint64_t addr) "addr 0x%" PRIx64
+tr_ramsink_write_error(uint64_t addr, uint64_t value) "addr 0x%" PRIx64 " value 0x%" PRIx64
diff --git a/hw/riscv/trace-ram-sink.c b/hw/riscv/trace-ram-sink.c
new file mode 100644
index 0000000000..c273335fec
--- /dev/null
+++ b/hw/riscv/trace-ram-sink.c
@@ -0,0 +1,263 @@
+/*
+ * Emulation of a RISC-V Trace RAM Sink
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "trace-ram-sink.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
+#include "qemu/bitops.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "trace.h"
+#include "system/device_tree.h"
+#include "hw/sysbus.h"
+#include "hw/register.h"
+
+#define R_TR_RAM_CONTROL_RSVP_BITS (MAKE_64BIT_MASK(32, 32) | \
+                                    R_TR_RAM_CONTROL_RSVP1_MASK | \
+                                    R_TR_RAM_CONTROL_RSVP2_MASK | \
+                                    R_TR_RAM_CONTROL_RSVP3_MASK | \
+                                    R_TR_RAM_CONTROL_RSVP4_MASK)
+
+/* trRamEmpty is the only RO field and reset value */
+#define R_TR_RAM_CONTROL_RESET R_TR_RAM_CONTROL_EMPTY_MASK
+#define R_TR_RAM_CONTROL_RO_BITS R_TR_RAM_CONTROL_EMPTY_MASK
+
+#define R_TR_RAM_IMPL_RSVP_BITS (MAKE_64BIT_MASK(32, 32) | \
+                                 R_TR_RAM_IMPL_RSVP1_MASK)
+
+#define R_TR_RAM_IMPL_RO_BITS (R_TR_RAM_IMPL_VER_MAJOR_MASK | \
+                               R_TR_RAM_IMPL_VER_MINOR_MASK | \
+                               R_TR_RAM_IMPL_COMP_TYPE_MASK | \
+                               R_TR_RAM_IMPL_HAS_SRAM_MASK | \
+                               R_TR_RAM_IMPL_HAS_SMEM_MASK)
+
+#define R_TR_RAM_IMPL_RESET (BIT(0) | 0x9 << 8)
+
+static RegisterAccessInfo tr_ramsink_regs_info[] = {
+    {   .name = "TR_RAM_CONTROL", .addr = A_TR_RAM_CONTROL,
+        .rsvd = R_TR_RAM_CONTROL_RSVP_BITS,
+        .reset = R_TR_RAM_CONTROL_RESET,
+        .ro = R_TR_RAM_CONTROL_RO_BITS,
+    },
+    {   .name = "TR_RAM_IMPL", .addr = A_TR_RAM_IMPL,
+        .rsvd = R_TR_RAM_IMPL_RSVP_BITS,
+        .reset = R_TR_RAM_IMPL_RESET,
+        .ro = R_TR_RAM_IMPL_RO_BITS,
+    },
+    {   .name = "TR_RAM_START_LOW", .addr = A_TR_RAM_START_LOW,
+    },
+    {   .name = "TR_RAM_START_HIGH", .addr = A_TR_RAM_START_HIGH,
+    },
+    {   .name = "TR_RAM_LIMIT_LOW", .addr = A_TR_RAM_LIMIT_LOW,
+    },
+    {   .name = "TR_RAM_LIMIT_HIGH", .addr = A_TR_RAM_LIMIT_HIGH,
+    },
+    {   .name = "TR_RAM_WP_LOW", .addr = A_TR_RAM_WP_LOW,
+    },
+    {   .name = "TR_RAM_WP_HIGH", .addr = A_TR_RAM_WP_HIGH,
+    },
+};
+
+static uint64_t tr_ramsink_regread(void *opaque, hwaddr addr, unsigned size)
+{
+    TraceRamSink *tram = TRACE_RAM_SINK(opaque);
+    RegisterInfo *r = &tram->regs_info[addr / 4];
+
+    if (!r->data) {
+        trace_tr_ramsink_read_error(addr);
+        return 0;
+    }
+
+    return register_read(r, ~0, NULL, false);
+}
+
+static void tr_ramsink_regwrite(void *opaque, hwaddr addr,
+                            uint64_t value, unsigned size)
+{
+    TraceRamSink *tram = TRACE_RAM_SINK(opaque);
+    RegisterInfo *r = &tram->regs_info[addr / 4];
+
+    if (!r->data) {
+        trace_tr_ramsink_write_error(addr, value);
+        return;
+    }
+
+    register_write(r, value, ~0, NULL, false);
+}
+
+static const MemoryRegionOps tr_ramsink_regops = {
+    .read = tr_ramsink_regread,
+    .write = tr_ramsink_regwrite,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static uint64_t tr_ramsink_msgread(void *opaque, hwaddr addr, unsigned size)
+{
+    TraceRamSink *tram = TRACE_RAM_SINK(opaque);
+
+    switch (size) {
+    case 1:
+        return tram->msgs[addr];
+    case 2:
+        return (uint16_t)tram->msgs[addr];
+    case 4:
+        return (uint32_t)tram->msgs[addr];
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tr_ramsink_msgwrite(void *opaque, hwaddr addr,
+                                uint64_t value, unsigned size)
+{
+    TraceRamSink *tram = TRACE_RAM_SINK(opaque);
+
+    switch (size) {
+    case 1:
+        tram->msgs[addr] = value;
+        break;
+    case 2:
+        tram->msgs[addr] = extract16(value, 0, 8);
+        tram->msgs[addr + 1] = extract16(value, 8, 8);
+        break;
+    case 4:
+        tram->msgs[addr] = extract32(value, 0, 8);
+        tram->msgs[addr + 1] = extract32(value, 8, 8);
+        tram->msgs[addr + 2] = extract32(value, 16, 8);
+        tram->msgs[addr + 3] = extract32(value, 24, 8);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static const MemoryRegionOps tr_ramsink_smemops = {
+    .read = tr_ramsink_msgread,
+    .write = tr_ramsink_msgwrite,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+static void tr_ramsink_setup_regs(TraceRamSink *tram)
+{
+    hwaddr ramlimit = tram->smemaddr + tram->smemsize;
+
+    ARRAY_FIELD_DP32(tram->regs, TR_RAM_START_LOW, ADDR,
+                     extract64(tram->smemaddr, 2, 30));
+    ARRAY_FIELD_DP32(tram->regs, TR_RAM_START_HIGH, ADDR,
+                     extract64(tram->smemaddr, 32, 32));
+
+    ARRAY_FIELD_DP32(tram->regs, TR_RAM_WP_LOW, ADDR,
+                     extract64(tram->smemaddr, 2, 30));
+    ARRAY_FIELD_DP32(tram->regs, TR_RAM_WP_HIGH, ADDR,
+                     extract64(tram->smemaddr, 32, 32));
+
+    ARRAY_FIELD_DP32(tram->regs, TR_RAM_LIMIT_LOW, ADDR,
+                     extract64(ramlimit, 2, 30));
+    ARRAY_FIELD_DP32(tram->regs, TR_RAM_LIMIT_HIGH, ADDR,
+                     extract64(ramlimit, 32, 32));
+}
+
+static void tr_ramsink_reset(DeviceState *dev)
+{
+    TraceRamSink *tram = TRACE_RAM_SINK(dev);
+
+    for (int i = 0; i < ARRAY_SIZE(tram->regs_info); i++) {
+        register_reset(&tram->regs_info[i]);
+    }
+
+    tr_ramsink_setup_regs(tram);
+}
+
+static void tr_ramsink_realize(DeviceState *dev, Error **errp)
+{
+    TraceRamSink *tram = TRACE_RAM_SINK(dev);
+
+    memory_region_init_io(&tram->reg_mem, OBJECT(dev),
+                          &tr_ramsink_regops, tram,
+                          "trace-ram-sink-regs",
+                          tram->reg_mem_size);
+    sysbus_init_mmio(SYS_BUS_DEVICE(tram), &tram->reg_mem);
+    sysbus_mmio_map(SYS_BUS_DEVICE(tram), 0, tram->baseaddr);
+
+    g_assert(tram->smemsize > 0);
+    tram->msgs = g_malloc0(tram->smemsize);
+
+    memory_region_init_io(&tram->smem, OBJECT(dev),
+                          &tr_ramsink_smemops, tram,
+                          "trace-ram-sink-smem",
+                          tram->smemsize);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &tram->smem);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, tram->smemaddr);
+
+    /* RegisterInfo init taken from hw/dma/xlnx-zdma.c */
+    for (int i = 0; i < ARRAY_SIZE(tr_ramsink_regs_info); i++) {
+        uint32_t reg_idx = tr_ramsink_regs_info[i].addr / 4;
+        RegisterInfo *r = &tram->regs_info[reg_idx];
+
+        *r = (RegisterInfo) {
+            .data = (uint8_t *)&tram->regs[reg_idx],
+            .data_size = sizeof(uint32_t),
+            .access = &tr_ramsink_regs_info[i],
+            .opaque = tram,
+        };
+    }
+}
+
+static const Property tr_ramsink_props[] = {
+    DEFINE_PROP_UINT64("baseaddr", TraceRamSink, baseaddr, 0),
+    DEFINE_PROP_UINT64("smemaddr", TraceRamSink, smemaddr, 0),
+    DEFINE_PROP_UINT32("smemsize", TraceRamSink, smemsize, 0),
+    DEFINE_PROP_UINT32("reg-mem-size", TraceRamSink,
+                       reg_mem_size, TR_DEV_REGMAP_SIZE),
+};
+
+static const VMStateDescription vmstate_tr_ramsink = {
+    .name = TYPE_TRACE_RAM_SINK,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, TraceRamSink, TRACE_R_MAX),
+        VMSTATE_END_OF_LIST(),
+    }
+};
+
+static void tr_ramsink_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, tr_ramsink_reset);
+    device_class_set_props(dc, tr_ramsink_props);
+    dc->realize = tr_ramsink_realize;
+    dc->vmsd = &vmstate_tr_ramsink;
+}
+
+static const TypeInfo tr_ramsink_info = {
+    .name          = TYPE_TRACE_RAM_SINK,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(TraceRamSink),
+    .class_init    = tr_ramsink_class_init,
+};
+
+static void tr_ramsink_register_types(void)
+{
+    type_register_static(&tr_ramsink_info);
+}
+
+type_init(tr_ramsink_register_types)
diff --git a/hw/riscv/trace-ram-sink.h b/hw/riscv/trace-ram-sink.h
new file mode 100644
index 0000000000..0a7225642c
--- /dev/null
+++ b/hw/riscv/trace-ram-sink.h
@@ -0,0 +1,83 @@
+/*
+ * Emulation of a RISC-V Trace RAM Sink
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef RISCV_TRACE_RAM_SINK_H
+#define RISCV_TRACE_RAM_SINK_H
+
+#include "hw/register.h"
+#include "hw/sysbus.h"
+#include "system/dma.h"
+#include "qom/object.h"
+
+#define TRACE_R_MAX (0xFFF / 4)
+#define TR_DEV_REGMAP_SIZE 0x1000
+
+/*
+ * The Trace Encoder will read/write those regs so put their
+ * declaration in this header.
+ */
+REG32(TR_RAM_CONTROL, 0x0)
+    FIELD(TR_RAM_CONTROL, ACTIVE, 0, 1)
+    FIELD(TR_RAM_CONTROL, ENABLE, 1, 1)
+    FIELD(TR_RAM_CONTROL, EMPTY, 3, 1)
+    FIELD(TR_RAM_CONTROL, MODE, 4, 1)
+    FIELD(TR_RAM_CONTROL, STOP_ON_WRAP, 8, 1)
+    FIELD(TR_RAM_CONTROL, MEM_FORMAT, 9, 2)
+    /* reserved bits */
+    FIELD(TR_RAM_CONTROL, RSVP1, 2, 1)
+    FIELD(TR_RAM_CONTROL, RSVP2, 5, 3)
+    FIELD(TR_RAM_CONTROL, RSVP3, 11, 1)
+    FIELD(TR_RAM_CONTROL, RSVP4, 15, 17)
+
+REG32(TR_RAM_IMPL, 0x4)
+    FIELD(TR_RAM_IMPL, VER_MAJOR, 0, 4)
+    FIELD(TR_RAM_IMPL, VER_MINOR, 4, 4)
+    FIELD(TR_RAM_IMPL, COMP_TYPE, 8, 4)
+    FIELD(TR_RAM_IMPL, HAS_SRAM, 12, 1)
+    FIELD(TR_RAM_IMPL, HAS_SMEM, 13, 1)
+    /* reserved bits */
+    FIELD(TR_RAM_IMPL, RSVP1, 14, 18)
+
+REG32(TR_RAM_START_LOW, 0x010)
+    FIELD(TR_RAM_START_LOW, ADDR, 2, 30)
+REG32(TR_RAM_START_HIGH, 0x014)
+    FIELD(TR_RAM_START_HIGH, ADDR, 0, 32)
+
+REG32(TR_RAM_LIMIT_LOW, 0x018)
+    FIELD(TR_RAM_LIMIT_LOW, ADDR, 2, 30)
+REG32(TR_RAM_LIMIT_HIGH, 0x01C)
+    FIELD(TR_RAM_LIMIT_HIGH, ADDR, 0, 32)
+
+REG32(TR_RAM_WP_LOW, 0x020)
+    FIELD(TR_RAM_WP_LOW, WRAP, 0, 1)
+    FIELD(TR_RAM_WP_LOW, ADDR, 2, 30)
+REG32(TR_RAM_WP_HIGH, 0x024)
+    FIELD(TR_RAM_WP_HIGH, ADDR, 0, 32)
+
+struct TraceRamSink {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    MemoryRegion reg_mem;
+    uint32_t reg_mem_size;
+
+    hwaddr baseaddr;
+    uint32_t regs[TRACE_R_MAX];
+    RegisterInfo regs_info[TRACE_R_MAX];
+
+    hwaddr smemaddr;
+    MemoryRegion smem;
+    uint32_t smemsize;
+    uint8_t *msgs;
+};
+
+#define TYPE_TRACE_RAM_SINK "trace-ram-sink"
+
+OBJECT_DECLARE_SIMPLE_TYPE(TraceRamSink, TRACE_RAM_SINK)
+
+#endif
-- 
2.51.1


