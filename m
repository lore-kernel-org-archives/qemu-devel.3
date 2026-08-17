Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B76A8C5DF7A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvv0i-0003nE-Ea; Mon, 17 Aug 2026 06:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wvv0T-0003Ie-9F
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 06:55:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wvv0P-00069S-BQ
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 06:55:52 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67H9dqrL1771645
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 10:55:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=kuq6dyKmFOs
 XnzCMTB2OBBBgFZOt/NOp0TsaA/J3L6k=; b=BJqFYxOjHtl6tBrs8SNiom4Ap2G
 wvDul45Zw18wh8KM96I4qvSDVCGrUlHNG+DH5TWnUUjeUFXbU7lNJJl2basw8N8Q
 PPOPIfQh91EsFoPhZUdriVJtPZYo1eOgeZgQ4GoU9CPDcUnxvUiz639m2Xc2P8Mu
 6xVFci+FMKcUgMHGCaXXp9J6vdMkiSJJq4KOrq0r/gEUht4tDvOPTuujxFdjXlwk
 3KM6GaS/Iiv7Cl6uxNGdkkCi548kmVhNdI6hyXY0F0ACwSd/EJtpy8rZRvqblUhL
 OqcfHXA7oxpElGUyMV44KxBUGszDw52McmS/webTa3PspMDy+Zf2TzPTONQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3xyk8guj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 10:55:47 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cbef10aac86so530524a12.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 03:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786964146; x=1787568946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kuq6dyKmFOsXnzCMTB2OBBBgFZOt/NOp0TsaA/J3L6k=;
 b=iNjVIJPU3V1rcyao4MswbMGOnI5H+hM0hx9HVoD2uekik0SteJzCOhUpuf/3PWsD4D
 3bJODmkIdIBhyMG7M2uSzIK12n70wcnj56ianlhpqFSiUWaaCtUeMfZcKgnLp8Uv3TLu
 69nFTob1cYuzoLbJDYvWmgKXno3ovXmy5Rkh5vOT5mAXcXgtjulKFwJIUzO1syysIBNY
 H55Cc+ZRjgtuWOP0ZMj8F5SRheMcQDaymkTwGABMYMN0hWVfDE4jSLwR7OiCBc0s+sj7
 /6pPhtR47BM/ghuvGLvumYSJoiiYWh0BMgYvNzTGDKoA+S8lPujCjJwNmyUqg/egLq6c
 82Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786964146; x=1787568946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kuq6dyKmFOsXnzCMTB2OBBBgFZOt/NOp0TsaA/J3L6k=;
 b=b6LvlPTuy8FgBzH1HFlRnGmOKzcE/nsPKlTFgwhLgSeQbkZYd98JLeVI+LvcykYcVc
 GE4moOc37Gpz+mLLoqAmFMEKsaLxxMLZZX301B6x6tHm2SFHKrj5Y8a0nKELXia65g1a
 51y4eDqoGOHqkPHUA2TemW9iGENryIpuuTCf9or7myF77QkQ7X5gAhpaOXKE9DA9slaj
 mQv/s63YhSV0BMacjqOjUrO4y4uYbgQwxC3xfNGdVcFrqbC2DqvmsSLtl3qf9uk5RAbR
 fnFs4KK1kuMxOn4Zmxz1k85lk6nHnjnuS4ZF2Twn4YI9z41s8ObrfIPMr+bydju/83t6
 0ojg==
X-Gm-Message-State: AOJu0Yzv2F+p7P4TS0L28xvjlQrfBiFbPnuPTKQO4NbgVHBA/7s3rckQ
 1ucUGgYOg4/8CabzbtttL2fEdBzOUEaFmdm8SNV8NslInW1NnIu6INzVuB06Uhi5nnOJiwmAnTf
 s+Qfxbr3Dbqf6x+M6PYr+tFQwtD5XfxPh0yTEBXD3BYgkH0UOhZpZTv2n8NPPSHkl6RpC
X-Gm-Gg: AR+sD10P/LhVKIJSK62P/MfJAFCMTPPN31b3Dpvx501sdzWhD1bi8WLjqoJ+WAHISn6
 FK6UuqZi3RMUm5frfd8rLXx0KuGtR0z7JgIcCRNKalUdIpK717NMppHpR2ORHn3Zq0kGOg83VpA
 Xa6nWmIRZwvtOyvXjJWe8owRju0+GBD2hQ6LqqRp/k/+A9wU7VNRlQ3ye45XlZUdwCqIFibhFYy
 g07GV52tkNq9XHe8u8zumrXP6QEJELIRb2u0/fs+ug0ME8Gdg4gG3Ehi+Daoaq5g9YNcvi+aNs6
 4bP4TpIxjcmz4fUF/RHICQA0C9Do+Q1SK8bXg9as0QbWuy+p3muZNSXFNYnq4Kpt4GU89+HpArN
 orgayXMUDdneCQUpV3jJ55UfKBH9WPekXPUskx5I51DYD7WmRT7IC+beiw7qpzFnRlf3W4IOtGC
 q6D8YNxHnmRlzCua1tTAPkbxSRMz0NFo8=
X-Received: by 2002:a17:903:1b46:b0:2d3:aecd:51f7 with SMTP id
 d9443c01a7336-2d3b0ce9999mr199821945ad.1.1786964146214; 
 Mon, 17 Aug 2026 03:55:46 -0700 (PDT)
X-Received: by 2002:a17:903:1b46:b0:2d3:aecd:51f7 with SMTP id
 d9443c01a7336-2d3b0ce9999mr199821505ad.1.1786964145661; 
 Mon, 17 Aug 2026 03:55:45 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c389363sm5431136eec.23.2026.08.17.03.55.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 03:55:45 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v9 04/10] hw/riscv/virt: add opt-in RPMI base support
Date: Mon, 17 Aug 2026 16:24:58 +0530
Message-ID: <20260817105505.2607506-5-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817105505.2607506-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20260817105505.2607506-1-subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4hKC6U2pPmp5MLcuraIITarRqqKyUSAr
X-Proofpoint-ORIG-GUID: 4hKC6U2pPmp5MLcuraIITarRqqKyUSAr
X-Authority-Analysis: v=2.4 cv=dLaWXuZb c=1 sm=1 tr=0 ts=6a82e8b3 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=HJcZEfycbju_5WdDyrcA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA4MSBTYWx0ZWRfX3/2WNxULteLK
 X2VdBvUNYeTFOUaG9GfUTTmFZ179atH3YkJZBtXElyQfV9HPditTMmAXXf2z8qZFjPAFXA2Odvk
 Fxzuk0ZKDu62jQHVpWjDlKj+ewK/ZF89LGX0yLMS7aXfAN9NcSZGhbrKKJ/dggDQcB0fq3DO5qm
 AMjZAyJnPQpPpC7+ty+yvxdMZnGtmXIyRHKke8IJp0YAo8nWzBhGEDFqd0mn5T56bLwEcYyLJQO
 h0JW0GvO2gHnWRakB99b2YCfiDBUmKkV1TcZPfqg0r6Yk1toG4FC68kxYcXLEFPZpl1ovSrgvoi
 9ZA5LFMoGkWgEvBJRjtZIHy68eDP8pDWc6XWKSdhN44LF+4KrvTb4LyuQJ0RsjcXBzKgkl/V9qR
 zQSr9I04Dxaks6u/AwzXQ+C7VUxNqDQ45Ek7udp0TFim7nFK6/waILLfJ+US4T9jlkysqqRLXvT
 a0mU9oO0Vd7+ebu6YJg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA4MSBTYWx0ZWRfX3xw/cPP0+Kwn
 k//WtGWGPUvkCh+7crB1kb22jE7Pb8Zm7TQwMZQ4wFnQcaVjipcx2gtXYgND3dnQHRrwAbY5ou2
 sFzQSOOtlOQk4DFfbWEBP653EuUZ4As=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170081
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
index 6a19fe443c..fb761f94b3 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -173,4 +173,4 @@ system_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))
 system_ss.add(when: 'CONFIG_AXIADO_CLK', if_true: files('axiado_clk.c'))
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
index de37c08cae..40a37abb27 100644
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
index 17e23265f8..87601f8523 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -4,7 +4,9 @@ riscv_ss.add(files('boot.c'))
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
index 51bac47a91..fa0e0db0c3 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -44,6 +44,8 @@
 #include "hw/intc/riscv_aplic.h"
 #include "hw/intc/sifive_plic.h"
 #include "hw/misc/sifive_test.h"
+#include "hw/misc/riscv_rpmi.h"
+#include "hw/riscv/rpmi-fdt.h"
 #include "hw/core/platform-bus.h"
 #include "chardev/char.h"
 #include "system/device_tree.h"
@@ -98,6 +100,8 @@ static const MemMapEntry virt_memmap[] = {
     [VIRT_UART0] =        { 0x10000000,         0x100 },
     [VIRT_VIRTIO] =       { 0x10001000,        0x1000 },
     [VIRT_FW_CFG] =       { 0x10100000,          0x18 },
+    [VIRT_RPMI_SHMEM] =   { 0x10200000,       0x20000 },
+    [VIRT_RPMI_DOORBELL] = { 0x10230000,        0x1000 },
     [VIRT_FLASH] =        { 0x20000000,     0x4000000 },
     [VIRT_IMSIC_M] =      { 0x24000000, VIRT_IMSIC_MAX_SIZE },
     [VIRT_IMSIC_S] =      { 0x28000000, VIRT_IMSIC_MAX_SIZE },
@@ -975,6 +979,40 @@ static void create_fdt_iommu(RISCVVirtState *s, uint16_t bdf)
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
@@ -994,6 +1032,10 @@ static void finalize_fdt(RISCVVirtState *s)
     create_fdt_pcie(s, irq_pcie_phandle, msi_pcie_phandle,
                     iommu_sys_phandle);
 
+    if (s->have_rpmi) {
+        create_fdt_rpmi(s, &phandle, msi_pcie_phandle);
+    }
+
     create_fdt_reset(s, &phandle);
 
     create_fdt_uart(s, irq_mmio_phandle);
@@ -1321,6 +1363,18 @@ static void virt_machine_init(MachineState *machine)
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
@@ -1471,6 +1525,25 @@ static void virt_machine_init(MachineState *machine)
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
@@ -1555,6 +1628,7 @@ static void virt_machine_instance_init(Object *obj)
 
     s->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
     s->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
+    s->have_rpmi = false;
     s->acpi = ON_OFF_AUTO_AUTO;
     s->iommu_sys = ON_OFF_AUTO_AUTO;
     s->num_sources = VIRT_IRQCHIP_NUM_SOURCES;
@@ -1630,6 +1704,21 @@ static void virt_set_aclint(Object *obj, bool value, Error **errp)
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
@@ -1751,6 +1840,13 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
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
index 36a2def410..35edd20ecd 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -55,6 +55,7 @@ struct RISCVVirtState {
 
     int fdt_size;
     bool have_aclint;
+    bool have_rpmi;
     RISCVVirtAIAType aia_type;
     int aia_guests;
     char *oem_id;
@@ -80,6 +81,8 @@ enum {
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


