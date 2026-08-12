Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF17DC5B567
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu2zH-00085B-JA; Wed, 12 Aug 2026 03:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wu2zC-000828-OG
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 03:02:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wu2z2-00012J-Vj
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 03:02:43 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67C624ZZ2593403
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 07:02:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=HpDyyuk+VUI
 pYCLU7kiFruhWT4DAQd7e5RboipFOpIw=; b=C7IVswKjbrp3xjTlMw23rGmar8F
 ZH3v3lyFExuvArkhTxOK9Oknfkb5T1bWxrN1osCcL8fIt1Y1ykNqdZupUAiozoFe
 krNOGhXEpcwDAMzHTluNVU4XZM0jjD+tcRjI2aK6tTAKMsJraLbUXs2vWTS5X6AY
 hpxMqA2O1Oa+fgKSGXK5RFHcyVvtxHwoc0ujciSk+omh6veyD7g8A605Ao5BeWSn
 0BsBGRS2Zp07vNnaL7GeWsIGoEpYzQLe2vtiXOx3xZMGVLBcS69Rqcemrymm7VxU
 ouASztbCxy4oV5B3O5oXWvdWhV6QniEVP+4JHbJ+4aYMWAjuyfUSfl3zu7A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g08jrjjk1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 07:02:38 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d0e306c7d0so2132725ad.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 00:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786518158; x=1787122958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HpDyyuk+VUIpYCLU7kiFruhWT4DAQd7e5RboipFOpIw=;
 b=emTK+970BDNpgRCfOU1jQJ1bxpaQu0OzEVAGejic/+N4B3B7CoErDVd5QiPgQwCkGa
 Yhl1EZ+E0HIp4gaSyDPTBzRpXUo3DcxCQokTblJ1pNDfH9tgi3wOHPlbsjpdyPjdpeBU
 voDn9agSn2SakE6CPZ5Xw4plQKaFgJc2gsL6YJF5K8x0HSoV2MW4MFhQGlmvBkvcUPCh
 oTQQl9sTATRcR9RT2cvuwQRIvjd/LSwjBqGXEEvY8egY9GKj9JSmfJuthgr+gaUNrE/5
 pNKOX9ikYbeDCf1YVOKNH8M1GIBeOtqhIb/eEyAVvQ4YUolStYyPM3qCbQ1gwEM1MVHQ
 3KQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786518158; x=1787122958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HpDyyuk+VUIpYCLU7kiFruhWT4DAQd7e5RboipFOpIw=;
 b=FHfdFTQzcFjry9VaYMkKmX1bqzuZyLzNO3eQFun18FixL2ryQIQnGYN7g5haLhxqIb
 /Dz2/gZlqD44DbzhTHyt02bKc5tXZdVFGJnqp0DOmqy+axWg6b6jMsusTA82GYoDuP29
 ghF5KRFL1qRFn+peEYlexHm1Gpq9x7E4rzDWbDycGpVdqldQUY76jgEvS8WZbP8uTKzx
 I62bPzLC6hVBcFUOt6vCAXqeMudDgjQT4j2uhO6YVOEqx0n6JccXLCsNtADI2tFD9utv
 BOcGDWtBVC3LNaHpJR0EagZ3c8bv92zEzpQhLqNLA4shhA19D0BgEF0aHRq4dYtymDEp
 bRBg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq4zG4uaf5A8rZ4mJOxDMXYE4+UTUbJqJxSW3DUrpulaO5CeseazcGo6vGCe33gxr4PZLDYRSNpVMdk@nongnu.org
X-Gm-Message-State: AOJu0YyKIIHdfBSyDGQ5HPOCjhEN8Cy7/Pmo9dKexf69Nsdc1E4ITI+8
 L2tSrvXv+eB3B7X0Z7k6vmJyA3/kGL2T87LNtDPnwra8/uNWSb1qulJQFvEauutvCKl75K78441
 SfZFpIRfpRl05swNx5t7CHjfB7ftoYMu8PF+78p3tlZ9NPfv5YahKgcvPZw==
X-Gm-Gg: AR+sD11TNn1v/2redqQDkQKt+ZTIVupD058atfueCmCxfbiG0a4NPp6ONvawcTZ35tA
 7K/jr6s3ROgmXCq/U5jBN7Eyf4HS4ylZ0Y7TCSX9hBCtGb3pcYPkk5UE+x9S4a6s8fF5j3ZrCCs
 rzJ8PgjOKyCJfv+I+s19TEz93eE348RwPD5SJbbaMQQCt0MK9JwUtDWaulUdgpdTayWc1JAW5RX
 gKB0GhAcDm9sBLyR6K8D/wCZ+cGZygcQWM4zroVxOK9hWOmYOnzj1f41ZtgDssduOZQLSxAZKAv
 pyDEinyRxkfc+wWziY+NAisUDq65sV/3V8T3tnQYl9tzRuiAS6OLEjy/eon5/l6tPClUl0eWVkG
 knixlPhz2+SQ/ucJhARWaQM0YGXDBRs/cIluw8J1PBpjdXZvRC0mooIBUzlgdbMC2GyT3qTAPKd
 UYXeYy8OZiGYbXvHyhNPhpI7hsRVYxul0=
X-Received: by 2002:a17:902:ec90:b0:2cf:7dfa:7f56 with SMTP id
 d9443c01a7336-2d3455f42ebmr26203925ad.2.1786518157514; 
 Wed, 12 Aug 2026 00:02:37 -0700 (PDT)
X-Received: by 2002:a17:902:ec90:b0:2cf:7dfa:7f56 with SMTP id
 d9443c01a7336-2d3455f42ebmr26203555ad.2.1786518157056; 
 Wed, 12 Aug 2026 00:02:37 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31cf3c08163sm6796627eec.7.2026.08.12.00.02.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 00:02:36 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-riscv@nongnu.org
Cc: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v6 04/10] hw/riscv/virt: add opt-in RPMI base support
Date: Wed, 12 Aug 2026 12:31:26 +0530
Message-ID: <20260812070133.3059679-5-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812070133.3059679-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20260812070133.3059679-1-subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _Vdc25NBzYpHamrCDM3bKByZ2wvCLTgR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA1NCBTYWx0ZWRfX55bybpyb5jLs
 8U/xM7ac/EFlrNg9qf8AlSXVCDhR3hW2EdAfbEWZlfZt7ZQ5rsCmyhX7RIrtYJxlSkyX5pUCBmb
 QDUR+jPZpdMmuIJRvdzqXM0ziHjhjaE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA1NCBTYWx0ZWRfX0YydpNtI9JCX
 +6NDbF6lZF/wCL+jtitew9234g5oRI+gRw9jO9pJduvNUVGCc1uQU7NaJb6fN/lzPKqAniwYav6
 k16xoMkGU8GnL1LOUZ0BoNMz/L4kAmSJk4w1+1CwN3DbhVI2MHrjzk4XOUv1oSFIb9uJLyHK1EW
 u7VLEo4qKvHplRBx+aQVSPXSeJ4UVwj1mQcPys6AWfMwJv8hOYN8H88dBjGMNBI1abNqs7WlNzb
 hE7rWyQKUna+iz3je/kC1l7iiwjQznbTr5YxL3BlY9YVqtl1sf7d5d/AA9zB8r+5p/4mJwy7oXJ
 ld8//LjdOwU9NsjEoQ0E1rfLWhaTvASy93cL6b3NFpLde/a0YLPZloV7n8SKFHBRkqFTNtoE7qf
 fh8GuP/pon9KTE0pHKmUijwgKwLJyCiYiWVIBFbyiT4vY4mXxUgd18bJSsvAUu5pzwDJdyfinYT
 puzbv6oLhs42h/pn5Dw==
X-Authority-Analysis: v=2.4 cv=Z7Dc2nRA c=1 sm=1 tr=0 ts=6a7c1a8e cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=HJcZEfycbju_5WdDyrcA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: _Vdc25NBzYpHamrCDM3bKByZ2wvCLTgR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120054
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Add the virt machine rpmi=on/off option and wire the initial RPMI Base
transport into machine realization.

The option remains disabled by default and requires TCG plus librpmi.
Invalid accelerator/build combinations fail during machine
initialization. When enabled, virt allocates the RPMI shared-memory
transport, creates the RPMI device, configures Base service metadata,
and emits the corresponding device-tree nodes for firmware discovery.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
---
 hw/misc/meson.build       |  2 +-
 hw/misc/riscv_rpmi-stub.c | 16 +++++++
 hw/riscv/Kconfig          |  1 +
 hw/riscv/meson.build      |  4 +-
 hw/riscv/rpmi-fdt-stub.c  | 37 +++++++++++++++
 hw/riscv/virt.c           | 96 +++++++++++++++++++++++++++++++++++++++
 include/hw/riscv/virt.h   |  3 ++
 7 files changed, 157 insertions(+), 2 deletions(-)
 create mode 100644 hw/misc/riscv_rpmi-stub.c
 create mode 100644 hw/riscv/rpmi-fdt-stub.c

diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index e7c2ebe28f..92c9cd6064 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -170,4 +170,4 @@ system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
 system_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))
 system_ss.add(when: 'CONFIG_RISCV_RPMI', if_true: [files(
   'riscv_rpmi.c',
-), librpmi])
+), librpmi], if_false: files('riscv_rpmi-stub.c'))
diff --git a/hw/misc/riscv_rpmi-stub.c b/hw/misc/riscv_rpmi-stub.c
new file mode 100644
index 0000000000..dc32b43227
--- /dev/null
+++ b/hw/misc/riscv_rpmi-stub.c
@@ -0,0 +1,16 @@
+/*
+ * RISC-V RPMI stubs.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/misc/riscv_rpmi.h"
+
+DeviceState *riscv_rpmi_create(const RiscvRpmiConfig *cfg G_GNUC_UNUSED,
+                               Error **errp)
+{
+    error_setg(errp, "RISC-V RPMI support is not compiled in");
+    return NULL;
+}
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 54e41a6afc..4e25be113a 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -49,6 +49,7 @@ config RISCV_VIRT
     imply VIRTIO_VGA
     imply TEST_DEVICES
     imply TPM_TIS_SYSBUS
+    imply RISCV_RPMI
     select DEVICE_TREE
     select RISCV_NUMA
     select GOLDFISH_RTC
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index ae69426eb1..abc2200d22 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -3,7 +3,9 @@ riscv_ss.add(files('boot.c'))
 riscv_ss.add(files('fdt-common.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
 riscv_ss.add(files('riscv_hart.c'))
-riscv_ss.add(when: 'CONFIG_RISCV_RPMI', if_true: files('rpmi-fdt.c'))
+riscv_ss.add(when: 'CONFIG_RISCV_RPMI',
+             if_true: files('rpmi-fdt.c'),
+             if_false: files('rpmi-fdt-stub.c'))
 riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
 riscv_ss.add(when: 'CONFIG_SHAKTI_C', if_true: files('shakti_c.c'))
diff --git a/hw/riscv/rpmi-fdt-stub.c b/hw/riscv/rpmi-fdt-stub.c
new file mode 100644
index 0000000000..28e72adad5
--- /dev/null
+++ b/hw/riscv/rpmi-fdt-stub.c
@@ -0,0 +1,37 @@
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
+void riscv_rpmi_fdt_add_service(void *fdt G_GNUC_UNUSED,
+                                hwaddr shmem_base G_GNUC_UNUSED,
+                                const char *node_name G_GNUC_UNUSED,
+                                const char *compatible G_GNUC_UNUSED,
+                                uint32_t mbox_handle G_GNUC_UNUSED,
+                                uint32_t service_group G_GNUC_UNUSED,
+                                bool has_mpxy_channel G_GNUC_UNUSED,
+                                uint32_t mpxy_channel G_GNUC_UNUSED)
+{
+    g_assert_not_reached();
+}
+
+void riscv_rpmi_fdt_add_service_node(void *fdt G_GNUC_UNUSED,
+                                     hwaddr shmem_base G_GNUC_UNUSED,
+                                     const RiscvRpmiServiceConfig *service
+                                     G_GNUC_UNUSED,
+                                     uint32_t mbox_handle G_GNUC_UNUSED)
+{
+    g_assert_not_reached();
+}
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 33775a61fd..e52ccfae1f 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -45,6 +45,8 @@
 #include "hw/intc/riscv_aplic.h"
 #include "hw/intc/sifive_plic.h"
 #include "hw/misc/sifive_test.h"
+#include "hw/misc/riscv_rpmi.h"
+#include "hw/riscv/rpmi-fdt.h"
 #include "hw/core/platform-bus.h"
 #include "chardev/char.h"
 #include "system/device_tree.h"
@@ -97,6 +99,8 @@ static const MemMapEntry virt_memmap[] = {
     [VIRT_UART0] =        { 0x10000000,         0x100 },
     [VIRT_VIRTIO] =       { 0x10001000,        0x1000 },
     [VIRT_FW_CFG] =       { 0x10100000,          0x18 },
+    [VIRT_RPMI_SHMEM] =   { 0x10200000,       0x20000 },
+    [VIRT_RPMI_DOORBELL] = { 0x10230000,        0x1000 },
     [VIRT_FLASH] =        { 0x20000000,     0x4000000 },
     [VIRT_IMSIC_M] =      { 0x24000000, VIRT_IMSIC_MAX_SIZE },
     [VIRT_IMSIC_S] =      { 0x28000000, VIRT_IMSIC_MAX_SIZE },
@@ -1002,6 +1006,40 @@ static void create_fdt_iommu(RISCVVirtState *s, uint16_t bdf)
     s->pci_iommu_bdf = bdf;
 }
 
+
+static RiscvRpmiConfig virt_rpmi_config(RISCVVirtState *s,
+                                        const uint32_t *hart_ids,
+                                        uint32_t hart_count)
+{
+    return (RiscvRpmiConfig) {
+        .doorbell_base = s->memmap[VIRT_RPMI_DOORBELL].base,
+        .shmem_base = s->memmap[VIRT_RPMI_SHMEM].base,
+        .shmem_size = s->memmap[VIRT_RPMI_SHMEM].size,
+        .a2p_req_size = VIRT_RPMI_A2P_REQ_SIZE,
+        .p2a_req_size = VIRT_RPMI_P2A_REQ_SIZE,
+        .platform_info = "QEMU RISC-V virt RPMI",
+        .hart_ids = hart_ids,
+        .hart_count = hart_count,
+    };
+}
+
+static void create_fdt_rpmi(RISCVVirtState *s, uint32_t *phandle,
+                            uint32_t msi_phandle)
+{
+    RiscvRpmiConfig rpmi_cfg = virt_rpmi_config(s, NULL, 0);
+    uint32_t rpmi_mbox_handle;
+    RiscvRpmiFdtMboxConfig cfg = {
+        .shmem_base = rpmi_cfg.shmem_base,
+        .doorbell_base = rpmi_cfg.doorbell_base,
+        .a2p_req_size = rpmi_cfg.a2p_req_size,
+        .p2a_req_size = rpmi_cfg.p2a_req_size,
+        .doorbell_size = s->memmap[VIRT_RPMI_DOORBELL].size,
+    };
+
+    riscv_rpmi_fdt_add_mbox(MACHINE(s)->fdt, &cfg, phandle,
+                            &rpmi_mbox_handle);
+}
+
 static void finalize_fdt(RISCVVirtState *s)
 {
     uint32_t phandle = 1, irq_mmio_phandle = 1, msi_pcie_phandle = 1;
@@ -1021,6 +1059,10 @@ static void finalize_fdt(RISCVVirtState *s)
     create_fdt_pcie(s, irq_pcie_phandle, msi_pcie_phandle,
                     iommu_sys_phandle);
 
+    if (s->have_rpmi) {
+        create_fdt_rpmi(s, &phandle, msi_pcie_phandle);
+    }
+
     create_fdt_reset(s, &phandle);
 
     create_fdt_uart(s, irq_mmio_phandle);
@@ -1410,6 +1452,18 @@ static void virt_machine_init(MachineState *machine)
         exit(1);
     }
 
+
+    if (s->have_rpmi) {
+#ifndef CONFIG_LIBRPMI
+        error_report("RISC-V RPMI support is not compiled in");
+        exit(1);
+#else
+        if (kvm_enabled()) {
+            error_report("RISC-V RPMI support is not available with KVM");
+            exit(1);
+        }
+#endif
+    }
     /* Initialize sockets */
     mmio_irqchip = virtio_irqchip = pcie_irqchip = NULL;
     for (i = 0; i < socket_count; i++) {
@@ -1552,6 +1606,25 @@ static void virt_machine_init(MachineState *machine)
     /* SiFive Test MMIO device */
     sifive_test_create(s->memmap[VIRT_TEST].base);
 
+    if (s->have_rpmi) {
+        MachineClass *mc = MACHINE_GET_CLASS(machine);
+        const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(machine);
+        g_autofree uint32_t *rpmi_hart_ids =
+            g_new0(uint32_t, machine->smp.cpus);
+        RiscvRpmiConfig rpmi_cfg;
+        Error *local_err = NULL;
+
+        for (i = 0; i < machine->smp.cpus; i++) {
+            rpmi_hart_ids[i] = possible_cpus->cpus[i].arch_id;
+        }
+
+        rpmi_cfg = virt_rpmi_config(s, rpmi_hart_ids, machine->smp.cpus);
+        if (!riscv_rpmi_create(&rpmi_cfg, &local_err)) {
+            error_report_err(local_err);
+            exit(1);
+        }
+    }
+
     /* VirtIO MMIO devices */
     for (i = 0; i < VIRTIO_COUNT; i++) {
         sysbus_create_simple("virtio-mmio",
@@ -1636,6 +1709,7 @@ static void virt_machine_instance_init(Object *obj)
 
     s->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
     s->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
+    s->have_rpmi = false;
     s->acpi = ON_OFF_AUTO_AUTO;
     s->iommu_sys = ON_OFF_AUTO_AUTO;
 }
@@ -1710,6 +1784,21 @@ static void virt_set_aclint(Object *obj, bool value, Error **errp)
     s->have_aclint = value;
 }
 
+
+static bool virt_get_rpmi(Object *obj, Error **errp)
+{
+    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
+
+    return s->have_rpmi;
+}
+
+static void virt_set_rpmi(Object *obj, bool value, Error **errp)
+{
+    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
+
+    s->have_rpmi = value;
+}
+
 bool virt_is_iommu_sys_enabled(RISCVVirtState *s)
 {
     return s->iommu_sys == ON_OFF_AUTO_ON;
@@ -1831,6 +1920,13 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
                                           "enable/disable emulating "
                                           "ACLINT devices");
 
+
+    object_class_property_add_bool(oc, "rpmi", virt_get_rpmi,
+                                   virt_set_rpmi);
+    object_class_property_set_description(oc, "rpmi",
+                                          "Set on/off to enable/disable "
+                                          "RISC-V RPMI devices");
+
     object_class_property_add_str(oc, "aia", virt_get_aia,
                                   virt_set_aia);
     object_class_property_set_description(oc, "aia",
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 18a2a323a3..f7c48613bf 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -55,6 +55,7 @@ struct RISCVVirtState {
 
     int fdt_size;
     bool have_aclint;
+    bool have_rpmi;
     RISCVVirtAIAType aia_type;
     int aia_guests;
     char *oem_id;
@@ -79,6 +80,8 @@ enum {
     VIRT_UART0,
     VIRT_VIRTIO,
     VIRT_FW_CFG,
+    VIRT_RPMI_SHMEM,
+    VIRT_RPMI_DOORBELL,
     VIRT_IMSIC_M,
     VIRT_IMSIC_S,
     VIRT_FLASH,
-- 
2.43.0


