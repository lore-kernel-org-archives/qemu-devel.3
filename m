Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F16C606A326
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EW3OPL25;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YFQQ7dQw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNnWz-0005a6-Kr; Mon, 02 Nov 2026 03:36:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xNnSu-0002oT-CA
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 03:32:38 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xNnSp-0004oF-49
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 03:32:25 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A24DHsa2433620
 for <qemu-devel@nongnu.org>; Mon, 2 Nov 2026 08:32:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Cxwm6Ecqik9
 o6SuCY9NmVjL+EPNRNsiAAv5UIqXeAkk=; b=EW3OPL25+jwT3e/wdjJdsJ8sSTi
 SyuuPjoAie4oWmLJWYXXdxkBOd5q024DfV/4bAE0DXibkH1v37SYFbsEzMUJZARU
 YrNYTThxtKksYpUXNQcvaCIss+fZDQdD0csSl7wIJYhJOcoCoME1RBfObssZCSDh
 RXbc4gQGpr04rbDvj8RvVGbuXJa/EMjmu8idQhAOkKK1Lc5l36GY0ohLKBj4Le57
 kJ9jxKWE8qk+aEXqUXLSB4sPbpzfY16Wr716Cbd+Cbkaz3vAWr+k5fOsElGRhel+
 r1whHunmB4ebSDQFAPlr5sHi39Zz4QBLg/8blkDccGw4c4aTEK+0HCK1Yow==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpka60v1x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 08:32:21 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-339628f2bbaso317428eec.1
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 00:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793608340; x=1794213140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Cxwm6Ecqik9o6SuCY9NmVjL+EPNRNsiAAv5UIqXeAkk=;
 b=YFQQ7dQwkmKQypDxAVAQkpUXpLeodTu51yPV7PKgcAwRADDIgcrr18VRHTFHnSEew7
 c1QVDfClVBo6YPjlnFDrVCUf3UVUyjZMJJ5/w+T3WtSDjdRvNlK2JgjPhgzE1DXA0ZlD
 Uo+RLpRDdz0iy4YA2J2yIOp+hSDrROx1JSms7Oae8Fh/C1IgHrdEFmynd/nA+gkzhmSq
 Ge+PSPadX6+23kAyr2U7IfFTFEDsWnjgpDAoNXPog7GPjw5wt9e6+W5REAJqTbWav25K
 kir0IYULXPRqf/V9B2X/1zHTtbg2lH6qmlIDj2qkvT8n7C9glsgzJe+EZBPNPl3rkIiv
 +1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793608340; x=1794213140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Cxwm6Ecqik9o6SuCY9NmVjL+EPNRNsiAAv5UIqXeAkk=;
 b=N6sSK9YO8++l7nNJHOOLqL61Nbc+fW4zNcjVsczzAqQbi+tHtdTfBBgaEOlQPzj24S
 YW1mS1a72Zf08qMBxcSp9ZSDGZOzI26TXenvxu7YZg0DKOHlzTRaORdPCYT3X9sOsyjP
 AupEe2wDmNArE+dY2aKn9pm0XT0GgnsvUJQJ5TqdNaVBQ7HR+K8Amf+6a62e45dMTuF4
 NyG8nYoH4YU71UjtJz78V4xmmGcEX6nsZoClyKJdq3IhUb24HbpA55E9UJU8gNiSS0Nc
 j9VGTUmiF7a5SRrCWN923Gtgej0beCXNaKj/ws3kZzbMHtM8f8jqF+oJOKvdSHk7yNWF
 H2ow==
X-Gm-Message-State: AFq9FYIBr2zSF5mD0fd+FrZpA6tkTDzcgw5OLaarCxzNcpMkjC8QDg1w
 Ta3D3/5uV/xzjaiQVoh/O9F84X+jUXXuVQh7QDZ337FRRXkuZFEB1lar0T0UZFQv+GdQi9v7l6L
 4T/+bb8tLyWt+7gJzcByVN9cjH3S3sIOoPhPgp5RD9i+I7ERhTIGcZUtSfrE4uxFUMA==
X-Gm-Gg: AYBFou0IsuQTyAq6UQvOp8+sG2x8eGm02RXs5QKwJ9wgEA0B7wqZ7qwnOvvRl8hRcxL
 IiD03QaFZI0qkQG5wEnxqrQkiJzlhm8yvh27/d0GrdGk85VR2sfE8pXUfuW1B6v/GmXIpdqB3Vk
 nZKJisXfIQFQezPv7SJc8TzEneM2lXi6o+DNR2t1I+7wLE674NjoQFNIFVqL5b6AUdo/nG0RjFL
 xRYmGknnkB+qBtaWmPKBR7h7VMT4/FAJ24OiXHjW8lW0xFhnrVzJGhnWbRAs4CHoNZDasA1I5xD
 aAxNfBf4AZIZ0YWuqJY9Qm7etUwcOgMw84hqjv2U1IxEWeI3hJkE/QgW1tzH8sceBJIODCMfMLR
 h8vWgsUCAv7D+/GK47GQ7nT4T/ymJexYh3bkEBhNiIFNUXEWoFG9+AIns4qpBIzeIrv2BtE//Ue
 bWhgWtrN2Uy0zc0uCjn85+31uJny7Q9AMUoX5Iihwt3iplMg6bbrgl2vQeJStB88jT75GkwVnWY
 dy+pdjj
X-Received: by 2002:a05:701b:2515:b0:17f:641e:7f6b with SMTP id
 a92af1059eb24-1ac5904ae73mr20881879c88.1.1793608340011; 
 Mon, 02 Nov 2026 00:32:20 -0800 (PST)
X-Received: by 2002:a05:701b:2515:b0:17f:641e:7f6b with SMTP id
 a92af1059eb24-1ac5904ae73mr20881823c88.1.1793608339358; 
 Mon, 02 Nov 2026 00:32:19 -0800 (PST)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b106edc7f8sm15083213c88.9.2026.11.02.00.32.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 00:32:19 -0800 (PST)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH v13 03/10] hw/riscv: add RPMI FDT helpers
Date: Mon,  2 Nov 2026 14:01:51 +0530
Message-ID: <20261102083159.3383468-4-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102083159.3383468-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20261102083159.3383468-1-subrahmanya.lingappa@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: e6XQ2_dK2VrKhlxjkLr9TFoVUJabmIe-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzMyBTYWx0ZWRfX7sUiAUh8dvgr
 F7szmjebbvR/5ppLibWDTPMJgW42Fj9iJYbtvzMlNGyjf6q/8jO4vb0MGWKj00CU13+QgGfGGLs
 owYSmlLB9jw50UFt4GzCiE5NXNdmNKk=
X-Authority-Analysis: v=2.4 cv=ZbyIpcVA c=1 sm=1 tr=0 ts=6ae84a95 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=WNJofZAcfibaGo0vQRIA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzMyBTYWx0ZWRfX5+fDnJLe9kzJ
 pphFg+NEubkXIrjKhIVXPv+O2Xr0hTqCGvclcC0HSMnNOJMWzXxO0hI30wXXsUU4+XFvL6biT/u
 6tBMygbuyyUwSqmxgF125CKfA7zbFElwN8Ylyk0ojG+B+rUNnFqx+RY/7Wn/1w3s+j/nMGjEtjr
 KZ20RorpRKEONgX/2bP3ZZOPlCyQEAabHbneV1pjRkl79tI8+l25/3WzixzwlVCWkLSmbi28urc
 K239K7V65qO6bfUWhSeJoN3DyF8HoGFkJWigmGfHHaxgxOxKQYLlMc587aGPUD1GxhPk21qv81m
 p45E4Zec36/nV+s7RR1p5T2EMpmXT18vlm8o+Fzcxtbm6xt+QPR7R1ijS3HxiDAvlBUZMzuAg38
 T8h65dJiUVJLOD94njWslzMmXbeky9HpaTIXoKIKptvDhQcfVI4d5gGXjLc0GJe43/sHM+OjU+D
 ttfSKl+x4uadH/AMtBQ==
X-Proofpoint-GUID: e6XQ2_dK2VrKhlxjkLr9TFoVUJabmIe-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020033
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add helper routines for describing RPMI shared-memory mailbox transports
and sibling service nodes in the RISC-V virt device tree.

The helpers keep RPMI node construction in one place so the virt machine
can add service groups without open-coding compatible strings, channel
IDs, interrupts, and shared-memory references at each call site.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/meson.build        |  3 ++
 hw/riscv/rpmi-fdt-stub.c    | 24 ++++++++++
 hw/riscv/rpmi-fdt.c         | 92 +++++++++++++++++++++++++++++++++++++
 include/hw/riscv/rpmi-fdt.h | 34 ++++++++++++++
 4 files changed, 153 insertions(+)
 create mode 100644 hw/riscv/rpmi-fdt-stub.c
 create mode 100644 hw/riscv/rpmi-fdt.c
 create mode 100644 include/hw/riscv/rpmi-fdt.h

diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 6bdabb9544..806ba41e42 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -5,6 +5,9 @@ riscv_ss.add(files('device-common.c'))
 riscv_ss.add(files('fdt-common.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
 riscv_ss.add(files('riscv_hart.c'))
+riscv_ss.add(when: 'CONFIG_RISCV_RPMI',
+             if_true: files('rpmi-fdt.c'),
+             if_false: files('rpmi-fdt-stub.c'))
 riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_SERVER_PLATFORM_REF', if_true: files('server_platform_ref.c'))
diff --git a/hw/riscv/rpmi-fdt-stub.c b/hw/riscv/rpmi-fdt-stub.c
new file mode 100644
index 0000000000..0de006bd47
--- /dev/null
+++ b/hw/riscv/rpmi-fdt-stub.c
@@ -0,0 +1,24 @@
+/*
+ * RISC-V RPMI device-tree helper stubs.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/riscv/rpmi-fdt.h"
+
+void riscv_rpmi_fdt_add_mbox(void *fdt G_GNUC_UNUSED,
+                             const RiscvRpmiFdtMboxConfig *cfg G_GNUC_UNUSED,
+                             uint32_t *phandle G_GNUC_UNUSED,
+                             uint32_t *mbox_handle G_GNUC_UNUSED)
+{
+    g_assert_not_reached();
+}
+
+void riscv_rpmi_fdt_add_service_node(void *fdt G_GNUC_UNUSED,
+                                     const RiscvRpmiServiceConfig *service
+                                     G_GNUC_UNUSED,
+                                     uint32_t mbox_handle G_GNUC_UNUSED)
+{
+    g_assert_not_reached();
+}
diff --git a/hw/riscv/rpmi-fdt.c b/hw/riscv/rpmi-fdt.c
new file mode 100644
index 0000000000..0ca1f69546
--- /dev/null
+++ b/hw/riscv/rpmi-fdt.c
@@ -0,0 +1,92 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * RISC-V RPMI device-tree helpers
+ *
+ * Copyright (c) 2026 Qualcomm Technologies, Inc.
+ * Author:
+ *  Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
+ */
+
+#include "qemu/osdep.h"
+#include "hw/riscv/rpmi-fdt.h"
+#include "hw/misc/riscv_rpmi.h"
+#include "system/device_tree.h"
+
+void riscv_rpmi_fdt_add_mbox(void *fdt,
+                             const RiscvRpmiFdtMboxConfig *cfg,
+                             uint32_t *phandle,
+                             uint32_t *mbox_handle)
+{
+    g_autofree char *name = NULL;
+    hwaddr a2p_req_base, p2a_ack_base, p2a_req_base, a2p_ack_base;
+    uint32_t handle;
+    static const char * const regnames_all[RPMI_ALL_NUM_REGS] = {
+        "a2p-req", "p2a-ack", "p2a-req", "a2p-ack", "a2p-doorbell"
+    };
+    static const char * const regnames_a2p[RPMI_A2P_NUM_REGS] = {
+        "a2p-req", "p2a-ack", "a2p-doorbell"
+    };
+
+    a2p_req_base = cfg->shmem_base;
+    p2a_ack_base = a2p_req_base + cfg->a2p_req_size;
+    p2a_req_base = p2a_ack_base + cfg->a2p_req_size;
+    a2p_ack_base = p2a_req_base + cfg->p2a_req_size;
+
+    handle = (*phandle)++;
+
+    if (mbox_handle) {
+        *mbox_handle = handle;
+    }
+    name = g_strdup_printf("/soc/mailbox@%" HWADDR_PRIx, cfg->shmem_base);
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "riscv,rpmi-shmem-mbox");
+    qemu_fdt_setprop_cell(fdt, name, "riscv,slot-size", RPMI_QUEUE_SLOT_SIZE);
+    qemu_fdt_setprop_cell(fdt, name, "#mbox-cells", 1);
+
+    if (cfg->p2a_req_size) {
+        qemu_fdt_setprop_string_array(fdt, name, "reg-names",
+                                      (char **)&regnames_all,
+                                      ARRAY_SIZE(regnames_all));
+        qemu_fdt_setprop_cells(fdt, name, "reg",
+            (uint32_t)(a2p_req_base >> 32), (uint32_t)a2p_req_base,
+            0x0, cfg->a2p_req_size,
+            (uint32_t)(p2a_ack_base >> 32), (uint32_t)p2a_ack_base,
+            0x0, cfg->a2p_req_size,
+            (uint32_t)(p2a_req_base >> 32), (uint32_t)p2a_req_base,
+            0x0, cfg->p2a_req_size,
+            (uint32_t)(a2p_ack_base >> 32), (uint32_t)a2p_ack_base,
+            0x0, cfg->p2a_req_size,
+            (uint32_t)(cfg->doorbell_base >> 32), (uint32_t)cfg->doorbell_base,
+            0x0, cfg->doorbell_size);
+    } else {
+        qemu_fdt_setprop_string_array(fdt, name, "reg-names",
+                                      (char **)&regnames_a2p,
+                                      ARRAY_SIZE(regnames_a2p));
+        qemu_fdt_setprop_cells(fdt, name, "reg",
+            (uint32_t)(a2p_req_base >> 32), (uint32_t)a2p_req_base,
+            0x0, cfg->a2p_req_size,
+            (uint32_t)(p2a_ack_base >> 32), (uint32_t)p2a_ack_base,
+            0x0, cfg->a2p_req_size,
+            (uint32_t)(cfg->doorbell_base >> 32), (uint32_t)cfg->doorbell_base,
+            0x0, cfg->doorbell_size);
+    }
+
+    qemu_fdt_setprop_cells(fdt, name, "phandle", handle);
+}
+
+void riscv_rpmi_fdt_add_service_node(void *fdt,
+                                     const RiscvRpmiServiceConfig *service,
+                                     uint32_t mbox_handle)
+{
+    g_autofree char *name = g_strdup_printf("/soc/%s", service->node_name);
+
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", service->compatible);
+    qemu_fdt_setprop_cells(fdt, name, "mboxes", mbox_handle,
+                           service->service_group);
+    if (service->has_mpxy_channel) {
+        qemu_fdt_setprop_cell(fdt, name, "riscv,sbi-mpxy-channel-id",
+                              service->mpxy_channel);
+    }
+}
diff --git a/include/hw/riscv/rpmi-fdt.h b/include/hw/riscv/rpmi-fdt.h
new file mode 100644
index 0000000000..e74115108e
--- /dev/null
+++ b/include/hw/riscv/rpmi-fdt.h
@@ -0,0 +1,34 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * RISC-V RPMI device-tree helpers
+ *
+ * Copyright (c) 2026 Qualcomm Technologies, Inc.
+ * Author:
+ *  Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
+ */
+
+#ifndef HW_RISCV_RPMI_FDT_H
+#define HW_RISCV_RPMI_FDT_H
+
+#include "exec/hwaddr.h"
+
+typedef struct RiscvRpmiServiceConfig RiscvRpmiServiceConfig;
+
+typedef struct RiscvRpmiFdtMboxConfig {
+    hwaddr shmem_base;
+    hwaddr doorbell_base;
+    uint32_t a2p_req_size;
+    uint32_t p2a_req_size;
+    uint32_t doorbell_size;
+} RiscvRpmiFdtMboxConfig;
+
+void riscv_rpmi_fdt_add_mbox(void *fdt,
+                             const RiscvRpmiFdtMboxConfig *cfg,
+                             uint32_t *phandle,
+                             uint32_t *mbox_handle);
+void riscv_rpmi_fdt_add_service_node(void *fdt,
+                                     const RiscvRpmiServiceConfig *service,
+                                     uint32_t mbox_handle);
+
+#endif
-- 
2.43.0


