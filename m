Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D38CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:54:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI30-0008Et-81; Mon, 01 Sep 2025 23:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI2Q-0006fx-07
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:50:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI2M-0004wN-4m
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:50:29 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822SAKQ022312
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:50:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qApLnIlZX754sYloYJaLRUaEQvkkNUznqKtwxMhDgpU=; b=OspjrS5tIpHeL6vv
 NPFbu/2pfDxbvdvEtP2ArjCGngHxmvAxeFwrWkDT3X4oGdIVf5WOvggPbUo47jDm
 HotLuoS2Ru4AZdrU/vc5ZJxnX2XIdb+fBIHV+vAzmlYHgAqCZ2B3VngiPIOAdeQy
 T1COeupnMiImLU3LG0xwnhUy81nBGWHz3h6l4pt8tB3R7yC81idufCPxpGZYaTzB
 qE+FvRBeHwkYiR1BBZwW61xydTNUMbBatZfxR3Vs+ehmORrfnhTRD4Q0RjMwnDYv
 7VU01spfE8IttHdwLZ5syw4bo0WFvVEmcrLhaRVjdMgsmO8+duv9oL5WvMgnFb7f
 UUwlpg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnp6hwj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:50:14 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-329dfdc23d2so401143a91.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756785006; x=1757389806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qApLnIlZX754sYloYJaLRUaEQvkkNUznqKtwxMhDgpU=;
 b=KQFGR4yD52H99locwvQ1yK6KfnddY8isMVdubaNLjol6+T4/FRO9BNPoRyau1eQvJO
 Fp2y2Ihisqz4oZ9wa4kPdBGVmr9uTuzoBc5cOob0XfrKL5fuj8gyn4i92/YKJ/ec8U2F
 R564SvGynQu/8eLvQ7jlnMhw9huKb/okXHXPfZR9u+YG78MqslDkr0AJF/1ejBQ51K9o
 griqKVC/IMo39lbBzYipg19pwscoXpzFOtLPHwlztjCCd0XTxW9XTfWZtJPUZHzZ1/O6
 p0ojWJUuw9wxp3ptivbBeHBxOXtK2AIP7RMHAcaHWNzXNvDJC2G7Pl2sxdGWNtW29I7y
 9cUQ==
X-Gm-Message-State: AOJu0Yy8Ly1o7KMkZjlRj9vPXz6j05M4Cska0NAPDPEKZ7zUGQHiZjV5
 384trlDhPfSsT32qzvF/Cf5EWFXHYjNRWJGhCXVK/zzmYCSr46fU7/OTClGinqworM3nN43xbry
 c/vlr2S5mSetUI5qAxu7lnUBhNnKtGT6XLagILtY+nisILuX+EFoOmtaMgCf8jxF55lhf
X-Gm-Gg: ASbGncurJs8eD1+Uf9J7ekZbmBk0lOrCIn/Kyia8ds3RA8tiDIvLM9TD/L5dZMlTC8c
 jG/zFAXswFJei0FMhp/Ug/T7CkZBhU0Lg1YhL30qN9SdDSdX6NUDuyA1DjV+r6MuHzi1thwe90z
 wllbRKIgaVTIbOGjEbgZ1CvDAVS7aw0syihz/UKRLWo8Cd6ENN0jMOnptZXwTgLYtiwLWPxrawI
 lmwPClRUhMf0MmXXH0In09Fdl5FLoQ2nnfPTBJu+mo4Q4txbiRI86clnBWnoaM3Xshax60n5w6x
 HsiIzEHEjpbS7LaFy9bN4lvI0p0qWP094QcoltFDBqxySpPgkEaJo5xXB6dDF87tGWESEEmnelR
 CJ24QY8KWn2EO
X-Received: by 2002:a17:90b:3e4f:b0:327:e74e:f757 with SMTP id
 98e67ed59e1d1-328156cc70amr11979539a91.30.1756785006086; 
 Mon, 01 Sep 2025 20:50:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsz6Joem38x7JSVb3OEWI38A4ZoqiQ36s7UvbvWgIhvb5BhPPaduvesJiWX5ziCklrGoUErg==
X-Received: by 2002:a17:90b:3e4f:b0:327:e74e:f757 with SMTP id
 98e67ed59e1d1-328156cc70amr11979494a91.30.1756785005394; 
 Mon, 01 Sep 2025 20:50:05 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327c5fc5055sm14117932a91.14.2025.09.01.20.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:50:05 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Markus Armbruster <armbru@redhat.com>,
 Mike Lambert <mlambert@quicinc.com>, Sid Manning <sidneym@quicinc.com>
Subject: [PATCH v2 03/11] hw/hexagon: Add machine configs for sysemu
Date: Mon,  1 Sep 2025 20:49:43 -0700
Message-Id: <20250902034951.1948194-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034951.1948194-1-brian.cain@oss.qualcomm.com>
References: <20250902034951.1948194-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: sUAbk3t_pRI94N0R5h3V9sBYZxSDPNTt
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b66976 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=20KFwNOVAAAA:8
 a=EUspDBNiAAAA:8 a=2NUsffphLIBclc6jjpsA:9 a=hiJlUhq8NronkB9Q:21
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: sUAbk3t_pRI94N0R5h3V9sBYZxSDPNTt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX8v/XCEoB+MFf
 DU8q+RkuATkojDUJzwlPtjP4LV2wByXhM3b5fCoMXl9NWG79k2+zB2t1d6hUw0xrFdjh8Y+1K2Q
 uNEvuPr3NAeu2nqWtN4srXQtDE5QPDcKsjqvDplmiR29Nc16AeOkAGo05NUBUSN2FOhiIXpuHBn
 I6SODxMUIHuXD3A9sbDyUK6mixM5xwfeeKkTsMcWTOff8UDuM8dHqIC/9xrjNvKlTINNAqX3wHU
 n6CznfZsOOeRfSsWckNEN+kdN0eWYH18XVGiafAROf8nCcWhuycwEfnYVe5rzBXak4ezcB4Q0nZ
 F59ORfgNWw149cDzsNJQK5L0DfCVUSzZZ5Lhp4FNMw2Grw0Vrl9P7rSFsC/cDL8czQVtekOAtql
 6Qwmnnpu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Brian Cain <bcain@quicinc.com>

Some header includes are modified here: these are uniquely required for
basic system emulation functionality and had not been required for linux-user.

Acked-by: Markus Armbruster <armbru@redhat.com>
Co-authored-by: Mike Lambert <mlambert@quicinc.com>
Co-authored-by: Sid Manning <sidneym@quicinc.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 MAINTAINERS                            |   2 +
 qapi/machine.json                      |   4 +-
 include/hw/hexagon/hexagon.h           | 150 ++++++++++++++++++++
 target/hexagon/cpu.h                   |   1 +
 hw/hexagon/machine_cfg_v66g_1024.h.inc |  63 +++++++++
 hw/hexagon/hexagon_dsp.c               | 183 +++++++++++++++++++++++++
 system/qdev-monitor.c                  |   2 +-
 target/hexagon/cpu.c                   |   1 +
 target/hexagon/op_helper.c             |   2 +-
 target/hexagon/translate.c             |   1 +
 hw/Kconfig                             |   1 +
 hw/hexagon/Kconfig                     |   5 +
 hw/hexagon/meson.build                 |   5 +
 hw/meson.build                         |   1 +
 14 files changed, 418 insertions(+), 3 deletions(-)
 create mode 100644 include/hw/hexagon/hexagon.h
 create mode 100644 hw/hexagon/machine_cfg_v66g_1024.h.inc
 create mode 100644 hw/hexagon/hexagon_dsp.c
 create mode 100644 hw/hexagon/Kconfig
 create mode 100644 hw/hexagon/meson.build

diff --git a/MAINTAINERS b/MAINTAINERS
index bf7695658a..efc237b27b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -229,6 +229,8 @@ Hexagon TCG CPUs
 M: Brian Cain <brian.cain@oss.qualcomm.com>
 S: Supported
 F: target/hexagon/
+F: hw/hexagon/
+F: include/hw/hexagon/
 X: target/hexagon/idef-parser/
 X: target/hexagon/gen_idef_parser_funcs.py
 F: linux-user/hexagon/
diff --git a/qapi/machine.json b/qapi/machine.json
index 038eab281c..67f1929a98 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -26,6 +26,8 @@
 #
 # @avr: since 5.1
 #
+# @hexagon: since 10.2
+#
 # @loongarch64: since 7.1
 #
 # .. note:: The resulting QMP strings can be appended to the
@@ -35,7 +37,7 @@
 # Since: 3.0
 ##
 { 'enum' : 'SysEmuTarget',
-  'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'hppa', 'i386',
+  'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'hexagon', 'hppa', 'i386',
              'loongarch64', 'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
              'mips64el', 'mipsel', 'or1k', 'ppc',
              'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
diff --git a/include/hw/hexagon/hexagon.h b/include/hw/hexagon/hexagon.h
new file mode 100644
index 0000000000..eb0c20276f
--- /dev/null
+++ b/include/hw/hexagon/hexagon.h
@@ -0,0 +1,150 @@
+/*
+ * Hexagon Baseboard System emulation.
+ *
+ * Copyright (c) 2020-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+
+#ifndef HW_HEXAGON_H
+#define HW_HEXAGON_H
+
+#include "system/memory.h"
+
+struct hexagon_board_boot_info {
+    uint64_t ram_size;
+    const char *kernel_filename;
+    uint32_t kernel_elf_flags;
+};
+
+typedef enum {
+    unknown_rev = 0,
+    v66_rev = 0xa666,
+    v67_rev = 0x2667,
+    v68_rev = 0x8d68,
+    v69_rev = 0x8c69,
+    v71_rev = 0x8c71,
+    v73_rev = 0x8c73,
+    v73m_rev = 0xcc73,
+} Rev_t;
+#define HEXAGON_LATEST_REV v73
+#define HEXAGON_LATEST_REV_UPPER V73
+
+/*
+ * Config table address bases represent bits [35:16].
+ */
+#define HEXAGON_CFG_ADDR_BASE(addr) (((addr) >> 16) & 0x0fffff)
+
+#define HEXAGON_CFGSPACE_ENTRIES (128)
+
+typedef  union {
+  struct {
+    /* Base address of L2TCM space */
+    uint32_t l2tcm_base;
+    uint32_t reserved0;
+    /* Base address of subsystem space */
+    uint32_t subsystem_base;
+    /* Base address of ETM space */
+    uint32_t etm_base;
+    /* Base address of L2 configuration space */
+    uint32_t l2cfg_base;
+    uint32_t reserved1;
+    /* Base address of L1S */
+    uint32_t l1s0_base;
+    /* Base address of AXI2 */
+    uint32_t axi2_lowaddr;
+    /* Base address of streamer base */
+    uint32_t streamer_base;
+    uint32_t reserved2;
+    /* Base address of fast L2VIC */
+    uint32_t fastl2vic_base;
+    /* Number of entries in JTLB */
+    uint32_t jtlb_size_entries;
+    /* Coprocessor type */
+    uint32_t coproc_present;
+    /* Number of extension execution contexts available */
+    uint32_t ext_contexts;
+    /* Base address of Hexagon Vector Tightly Coupled Memory (VTCM) */
+    uint32_t vtcm_base;
+    /* Size of VTCM (in KB) */
+    uint32_t vtcm_size_kb;
+    /* L2 tag size */
+    uint32_t l2tag_size;
+    /* Amount of physical L2 memory in released version */
+    uint32_t l2ecomem_size;
+    /* Hardware threads available on the core */
+    uint32_t thread_enable_mask;
+    /* Base address of the ECC registers */
+    uint32_t eccreg_base;
+    /* L2 line size */
+    uint32_t l2line_size;
+    /* Small Core processor (also implies audio extension) */
+    uint32_t tiny_core;
+    /* Size of L2TCM */
+    uint32_t l2itcm_size;
+    /* Base address of L2-ITCM */
+    uint32_t l2itcm_base;
+    uint32_t reserved3;
+    /* DTM is present */
+    uint32_t dtm_present;
+    /* Version of the DMA */
+    uint32_t dma_version;
+    /* Native HVX vector length in log of bytes */
+    uint32_t hvx_vec_log_length;
+    /* Core ID of the multi-core */
+    uint32_t core_id;
+    /* Number of multi-core cores */
+    uint32_t core_count;
+    uint32_t coproc2_reg0;
+    uint32_t coproc2_reg1;
+    /* Supported HVX vector length */
+    uint32_t v2x_mode;
+    uint32_t coproc2_reg2;
+    uint32_t coproc2_reg3;
+    uint32_t coproc2_reg4;
+    uint32_t coproc2_reg5;
+    uint32_t coproc2_reg6;
+    uint32_t coproc2_reg7;
+    /* Voltage droop mitigation technique parameter */
+    uint32_t acd_preset;
+    /* Voltage droop mitigation technique parameter */
+    uint32_t mnd_preset;
+    /* L1 data cache size (in KB) */
+    uint32_t l1d_size_kb;
+    /* L1 instruction cache size in (KB) */
+    uint32_t l1i_size_kb;
+    /* L1 data cache write policy: see HexagonL1WritePolicy */
+    uint32_t l1d_write_policy;
+    /* VTCM bank width  */
+    uint32_t vtcm_bank_width;
+    uint32_t reserved4;
+    uint32_t reserved5;
+    uint32_t reserved6;
+    uint32_t coproc2_cvt_mpy_size;
+    uint32_t consistency_domain;
+    uint32_t capacity_domain;
+    uint32_t axi3_lowaddr;
+    uint32_t coproc2_int8_subcolumns;
+    uint32_t corecfg_present;
+    uint32_t coproc2_fp16_acc_exp;
+    uint32_t AXIM2_secondary_base;
+  };
+  uint32_t raw[HEXAGON_CFGSPACE_ENTRIES];
+} hexagon_config_table;
+
+typedef struct {
+    /* Base address of config table */
+    uint32_t cfgbase;
+    /* Size of L2 TCM */
+    uint32_t l2tcm_size;
+    /* Base address of L2VIC */
+    uint32_t l2vic_base;
+    /* Size of L2VIC region */
+    uint32_t l2vic_size;
+    /* QTimer csr base */
+    uint32_t csr_base;
+    uint32_t qtmr_region;
+    hexagon_config_table cfgtable;
+} hexagon_machine_config;
+
+#endif
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 89c634a09c..86fbe30dbb 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -196,6 +196,7 @@ struct ArchCPU {
 #ifndef CONFIG_USER_ONLY
     uint32_t num_tlbs;
     uint32_t l2vic_base_addr;
+    uint32_t hvx_contexts;
     uint32_t boot_addr;
     struct HexagonGlobalRegState *globalregs;
 #endif
diff --git a/hw/hexagon/machine_cfg_v66g_1024.h.inc b/hw/hexagon/machine_cfg_v66g_1024.h.inc
new file mode 100644
index 0000000000..8f2a593bb8
--- /dev/null
+++ b/hw/hexagon/machine_cfg_v66g_1024.h.inc
@@ -0,0 +1,63 @@
+
+static hexagon_machine_config v66g_1024 = {
+    .cfgbase =        0xd8180000,
+    .l2tcm_size =     0x00000000,
+    .l2vic_base =     0xfc910000,
+    .l2vic_size =     0x00001000,
+    .csr_base =       0xfc900000,
+    .qtmr_region =    0xfc921000,
+    .cfgtable = {
+        .l2tcm_base = 0x0000d800,
+        .reserved0 = 0x0000d400,
+        .subsystem_base = 0x0000fc90,
+        .etm_base = 0x0000d805,
+        .l2cfg_base = 0x0000d81a,
+        .reserved1 = 0x00000000,
+        .l1s0_base = 0x0000d820,
+        .axi2_lowaddr = 0x00003000,
+        .streamer_base = 0x00000000,
+        .reserved2 = 0x0000d819,
+        .fastl2vic_base = 0x0000d81e,
+        .jtlb_size_entries = 0x00000080,
+        .coproc_present = 0x00000001,
+        .ext_contexts = 0x00000004,
+        .vtcm_base = 0x0000d820,
+        .vtcm_size_kb = 0x00000100,
+        .l2tag_size = 0x00000400,
+        .l2ecomem_size = 0x00000400,
+        .thread_enable_mask = 0x0000000f,
+        .eccreg_base = 0x0000d81f,
+        .l2line_size = 0x00000080,
+        .tiny_core = 0x00000000,
+        .l2itcm_size = 0x00000000,
+        .l2itcm_base = 0x0000d820,
+        .reserved3 = 0x00000000,
+        .dtm_present = 0x00000000,
+        .dma_version = 0x00000000,
+        .hvx_vec_log_length = 0x00000080,
+        .core_id = 0x00000000,
+        .core_count = 0x00000000,
+        .coproc2_reg0 = 0x00000000,
+        .coproc2_reg1 = 0x00000000,
+        .v2x_mode = 0x00000000,
+        .coproc2_reg2 = 0x00000000,
+        .coproc2_reg3 = 0x00000000,
+        .coproc2_reg4 = 0x00000000,
+        .coproc2_reg5 = 0x00000000,
+        .coproc2_reg6 = 0x00000000,
+        .coproc2_reg7 = 0x00000000,
+        .acd_preset = 0x00000000,
+        .mnd_preset = 0x00000000,
+        .l1d_size_kb = 0x00000000,
+        .l1i_size_kb = 0x00000000,
+        .l1d_write_policy = 0x00000000,
+        .vtcm_bank_width = 0x00000000,
+        .reserved3 = 0x00000000,
+        .reserved4 = 0x00000000,
+        .reserved5 = 0x00000000,
+        .coproc2_cvt_mpy_size = 0x00000000,
+        .consistency_domain = 0x00000000,
+        .capacity_domain = 0x00000000,
+        .axi3_lowaddr = 0x00000000,
+    },
+};
diff --git a/hw/hexagon/hexagon_dsp.c b/hw/hexagon/hexagon_dsp.c
new file mode 100644
index 0000000000..d491a21a76
--- /dev/null
+++ b/hw/hexagon/hexagon_dsp.c
@@ -0,0 +1,183 @@
+/*
+ * Hexagon DSP Subsystem emulation.  This represents a generic DSP
+ * subsystem with few peripherals, like the Compute DSP.
+ *
+ * Copyright (c) 2020-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "system/address-spaces.h"
+#include "hw/hw.h"
+#include "hw/boards.h"
+#include "hw/qdev-properties.h"
+#include "hw/hexagon/hexagon.h"
+#include "hw/hexagon/hexagon_globalreg.h"
+#include "hw/loader.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/log.h"
+#include "elf.h"
+#include "cpu.h"
+#include "include/migration/cpu.h"
+#include "include/system/system.h"
+#include "target/hexagon/internal.h"
+#include "system/reset.h"
+
+#include "machine_cfg_v66g_1024.h.inc"
+
+static void hex_symbol_callback(const char *st_name, int st_info,
+                                uint64_t st_value, uint64_t st_size)
+{
+}
+
+/* Board init.  */
+static struct hexagon_board_boot_info hexagon_binfo;
+
+static void hexagon_load_kernel(HexagonCPU *cpu)
+{
+    uint64_t pentry;
+    long kernel_size;
+
+    kernel_size = load_elf_ram_sym(hexagon_binfo.kernel_filename, NULL, NULL,
+                      NULL, &pentry, NULL, NULL,
+                      &hexagon_binfo.kernel_elf_flags, 0, EM_HEXAGON, 0, 0,
+                      &address_space_memory, false, hex_symbol_callback);
+
+    if (kernel_size <= 0) {
+        error_report("no kernel file '%s'",
+            hexagon_binfo.kernel_filename);
+        exit(1);
+    }
+
+    qdev_prop_set_uint32(DEVICE(cpu), "exec-start-addr", pentry);
+}
+
+static void hexagon_init_bootstrap(MachineState *machine, HexagonCPU *cpu)
+{
+    if (machine->kernel_filename) {
+        hexagon_load_kernel(cpu);
+    }
+}
+
+static void do_cpu_reset(void *opaque)
+{
+    HexagonCPU *cpu = opaque;
+    CPUState *cs = CPU(cpu);
+    cpu_reset(cs);
+}
+
+static void hexagon_common_init(MachineState *machine, Rev_t rev,
+                                hexagon_machine_config *m_cfg)
+{
+    memset(&hexagon_binfo, 0, sizeof(hexagon_binfo));
+    if (machine->kernel_filename) {
+        hexagon_binfo.ram_size = machine->ram_size;
+        hexagon_binfo.kernel_filename = machine->kernel_filename;
+    }
+
+    machine->enable_graphics = 0;
+
+    MemoryRegion *address_space = get_system_memory();
+
+    MemoryRegion *sram = g_new(MemoryRegion, 1);
+    memory_region_init_ram(sram, NULL, "ddr.ram",
+        machine->ram_size, &error_fatal);
+    memory_region_add_subregion(address_space, 0x0, sram);
+
+    Error **errp = NULL;
+
+    DeviceState *glob_regs_dev = qdev_new(TYPE_HEXAGON_GLOBALREG);
+    qdev_prop_set_uint64(glob_regs_dev, "config-table-addr", m_cfg->cfgbase);
+    qdev_prop_set_uint32(glob_regs_dev, "qtimer-base-addr", m_cfg->qtmr_region);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(glob_regs_dev), errp);
+
+    for (int i = 0; i < machine->smp.cpus; i++) {
+        HexagonCPU *cpu = HEXAGON_CPU(object_new(machine->cpu_type));
+        qemu_register_reset(do_cpu_reset, cpu);
+
+        /*
+         * CPU #0 is the only CPU running at boot, others must be
+         * explicitly enabled via start instruction.
+         */
+        qdev_prop_set_bit(DEVICE(cpu), "start-powered-off", (i != 0));
+        qdev_prop_set_uint32(DEVICE(cpu), "l2vic-base-addr", m_cfg->l2vic_base);
+        qdev_prop_set_uint32(DEVICE(cpu), "config-table-addr", m_cfg->cfgbase);
+        qdev_prop_set_uint32(DEVICE(cpu), "hvx-contexts",
+                             m_cfg->cfgtable.ext_contexts);
+        qdev_prop_set_uint32(DEVICE(cpu), "jtlb-entries",
+                             m_cfg->cfgtable.jtlb_size_entries);
+
+
+        if (i == 0) {
+            hexagon_init_bootstrap(machine, cpu);
+            if (!qdev_realize_and_unref(DEVICE(cpu), NULL, errp)) {
+                return;
+            }
+            DeviceState *l2vic_dev;
+            l2vic_dev = sysbus_create_varargs("l2vic", m_cfg->l2vic_base,
+                    /* IRQ#, Evnt#,CauseCode */
+                    qdev_get_gpio_in(DEVICE(cpu), 0),
+                    qdev_get_gpio_in(DEVICE(cpu), 1),
+                    qdev_get_gpio_in(DEVICE(cpu), 2),
+                    qdev_get_gpio_in(DEVICE(cpu), 3),
+                    qdev_get_gpio_in(DEVICE(cpu), 4),
+                    qdev_get_gpio_in(DEVICE(cpu), 5),
+                    qdev_get_gpio_in(DEVICE(cpu), 6),
+                    qdev_get_gpio_in(DEVICE(cpu), 7),
+                    NULL);
+            sysbus_mmio_map(SYS_BUS_DEVICE(l2vic_dev), 1,
+                m_cfg->cfgtable.fastl2vic_base << 16);
+        } else if (!qdev_realize_and_unref(DEVICE(cpu), NULL, errp)) {
+            return;
+        }
+
+    }
+}
+
+static void init_mc(MachineClass *mc)
+{
+    mc->block_default_type = IF_SD;
+    mc->default_ram_size = 4 * GiB;
+    mc->no_parallel = 1;
+    mc->no_floppy = 1;
+    mc->no_cdrom = 1;
+    mc->no_serial = 1;
+    mc->is_default = false;
+    mc->max_cpus = 8;
+}
+
+/* ----------------------------------------------------------------- */
+/* Core-specific configuration settings are defined below this line. */
+/* Config table values defined in machine_configs.h.inc              */
+/* ----------------------------------------------------------------- */
+
+static void v66g_1024_config_init(MachineState *machine)
+{
+    hexagon_common_init(machine, v66_rev, &v66g_1024);
+}
+
+static void v66g_1024_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "Hexagon V66G_1024";
+    mc->init = v66g_1024_config_init;
+    init_mc(mc);
+    mc->is_default = true;
+    mc->default_cpu_type = TYPE_HEXAGON_CPU_V66;
+    mc->default_cpus = 4;
+}
+
+static const TypeInfo hexagon_machine_types[] = {
+    {
+        .name = MACHINE_TYPE_NAME("V66G_1024"),
+        .parent = TYPE_MACHINE,
+        .class_init = v66g_1024_init,
+    },
+};
+
+DEFINE_TYPES(hexagon_machine_types)
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 2ac92d0a07..4acc2d3280 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -69,7 +69,7 @@ typedef struct QDevAlias
                               QEMU_ARCH_SPARC | \
                               QEMU_ARCH_XTENSA)
 #define QEMU_ARCH_VIRTIO_CCW (QEMU_ARCH_S390X)
-#define QEMU_ARCH_VIRTIO_MMIO (QEMU_ARCH_M68K)
+#define QEMU_ARCH_VIRTIO_MMIO (QEMU_ARCH_M68K | QEMU_ARCH_HEXAGON)
 
 /* Please keep this table sorted by typename. */
 static const QDevAlias qdev_alias_table[] = {
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 256fdc177e..ba78a04bdc 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -69,6 +69,7 @@ static const Property hexagon_cpu_properties[] = {
     DEFINE_PROP_UINT32("jtlb-entries", HexagonCPU, num_tlbs, MAX_TLB_ENTRIES),
     DEFINE_PROP_UINT32("l2vic-base-addr", HexagonCPU, l2vic_base_addr,
         0xffffffffULL),
+    DEFINE_PROP_UINT32("hvx-contexts", HexagonCPU, hvx_contexts, 0),
     DEFINE_PROP_UINT32("exec-start-addr", HexagonCPU, boot_addr, 0xffffffffULL),
     DEFINE_PROP_LINK("global-regs", HexagonCPU, globalregs,
                      TYPE_HEXAGON_GLOBALREG, HexagonGlobalRegState *),
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 1bc32769c6..fa893e480b 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -20,9 +20,9 @@
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/probe.h"
 #include "qemu/main-loop.h"
+#include "cpu.h"
 #include "exec/helper-proto.h"
 #include "fpu/softfloat.h"
-#include "cpu.h"
 #include "exec/cpu-interrupt.h"
 #include "internal.h"
 #include "macros.h"
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 38c2037c47..3e70fa29bc 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -32,6 +32,7 @@
 #include "translate.h"
 #include "genptr.h"
 #include "printinsn.h"
+#include "exec/target_page.h"
 
 #define HELPER_H "helper.h"
 #include "exec/helper-info.c.inc"
diff --git a/hw/Kconfig b/hw/Kconfig
index 9e6c789ae7..1c3684055a 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -52,6 +52,7 @@ source arm/Kconfig
 source cpu/Kconfig
 source alpha/Kconfig
 source avr/Kconfig
+source hexagon/Kconfig
 source hppa/Kconfig
 source i386/Kconfig
 source loongarch/Kconfig
diff --git a/hw/hexagon/Kconfig b/hw/hexagon/Kconfig
new file mode 100644
index 0000000000..7b9577f68f
--- /dev/null
+++ b/hw/hexagon/Kconfig
@@ -0,0 +1,5 @@
+config HEX_DSP
+    bool
+    default y
+    depends on HEXAGON && TCG
+    imply PTIMER
diff --git a/hw/hexagon/meson.build b/hw/hexagon/meson.build
new file mode 100644
index 0000000000..11e71a67d5
--- /dev/null
+++ b/hw/hexagon/meson.build
@@ -0,0 +1,5 @@
+hexagon_ss = ss.source_set()
+hexagon_ss.add(when: 'CONFIG_HEX_DSP', if_true: files('hexagon_dsp.c', 'hexagon_globalreg.c'))
+
+hw_arch += {'hexagon': hexagon_ss}
+
diff --git a/hw/meson.build b/hw/meson.build
index 791ce21ab4..7530742e69 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -50,6 +50,7 @@ subdir('fsi')
 subdir('alpha')
 subdir('arm')
 subdir('avr')
+subdir('hexagon')
 subdir('hppa')
 subdir('i386')
 subdir('loongarch')
-- 
2.34.1


