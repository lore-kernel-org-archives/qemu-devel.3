Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B7AC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 18:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2CE0-00018i-1C; Thu, 03 Sep 2026 14:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x2CDz-00018Z-1t
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:31:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x2CDv-0001c0-Bg
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:31:46 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G3cXE820113
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 18:31:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=i/8SRDIYabT
 8jxNGCTZuWeqqh6zYOWJd2k67Ce19eSo=; b=F7A+Q97ccYKSBW+9ji/J9YDph9l
 fBcEFNrJa8m7fXzz47U3n75hxzpvFgZ2NN7u8yOq2RMIA3iKnRRTHT15yfEBNi0K
 5/fhDX6lmS2xxw7oJftAjiyfl41GhTBCCh+hqFp0o9LN08C30S5voJblnCLKkHtU
 pjOVXGrfR+CRhC0pVLzjDjVg/yat4ksJFihfqNeMXBlYgT8+4PtXpnxOkeN7ICcN
 ZxM0czM1n0JSkFn6WUHxFw8yJUflBrS050bwW3mac3QReEqOOxgLbhluWczBoTXr
 S5IUUUzi41dhP/AR+eFDGFKTlj716gRDJVspJP8UrQuiL7QquJmvAVLQSoA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf82k9yq9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 18:31:41 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52fb2a46cb5so6955501cf.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 11:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788460301; x=1789065101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i/8SRDIYabT8jxNGCTZuWeqqh6zYOWJd2k67Ce19eSo=;
 b=kBa0mwROQUs8AzmXWLnPgljUJmk4bfJ0G1tMmmTAYnYXUqXncQqVmoI7epsGYbvRlq
 1L1e+vxYAppvlXpdOYGjXb8x07eXo1BGPAagB+t6kkKOmAb3FxuEwaMc12JOG5sbd87Q
 1hRATTU/FXq6yA2nsKadHvVua0SMp82J4KWwS0IFeL6yNhlpcN8QXJuHt0Utr1zh9/WY
 KRmgGCaN3dZu6BdIhy1JzSeLn5Pn7feCGYQMOW9R7VRH7UbxUVByMsm/Dya1xxXhJBkW
 4D8q7wi2+TBJAGfj5zlP7xJOx4y6y61n6AuyLKSaefG0Mdgc5jEunzVYh6bKr9mPphbv
 Lvyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788460301; x=1789065101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=i/8SRDIYabT8jxNGCTZuWeqqh6zYOWJd2k67Ce19eSo=;
 b=JPY1jHQ764SY8Wecs9dTG0Li1+bHYao8ab7JHx1yTXygxEGaHWPW8s5pfv+3dQ5+n5
 mEIwi4k4nYWXq/UUU1OCiegK/WS4bXIuwPtM0fBpz7UE/Erote6nzDiPKbREQQZpfZk3
 tLCkNa5FOagTPVOa+8xgSliu1TVQYmowV8+CMqLodDd/coC81U9WC/Fo6koCJLIejDel
 txHri3EKBAgzyDjta9j3WGGQ76PLg83IT3lnRRyqrsiHZe2T9iFcFiU5MSi033KOps9I
 l1t8qNXk9dkYZHWECm1vIFoZJnaiYu7JwoDoe1awJwwSDB1CMBlyEky2jfPh/SOLCFRK
 Za5A==
X-Gm-Message-State: AFuF++nZtKd39tAdrngJvQYZ4+Kz44lNjsWs/b+DbgYc2cOBqekIY6Ib
 nzcXbhrgBOo0c4hCA/xxolzX+ZfQo1EZtjWC5vaoGJjksPrgI8/QueTTIp4vCzxsBgzjAQsxPcK
 AlGbpscBEbPmsiguTsYNH6jjfUgHgM9gC0TjU0u4xZKOSql1qjXggt7bSfKnZLhi2Wg==
X-Gm-Gg: AYBFou357OkgkjNheA+Cn/MDlRPae59VBu2hsZqhGxtkuVlzaJPEBbfv5arQsGIjeIw
 3KcaIC1qinxoBGn1liypJpI7TENIEtjN2DbZ5hMHF8k83Gug33TVDqwjKq4ls0dxecyXbP4ZH8O
 jQ4DcQIaSuG5zVLVJPpXAtFFkNuUoLWxHq6g1H0hGMgAjV7YMN4kBQSUSUIE8xDW1D9qbhgQEJo
 Vl69WmUCBznpKW+4Bc4uvs8Jo+elJ2B8rfYfVUxxipXKSy9Me40UkIO5qnHzLSthJE/m1EPS1hB
 abHR8zogsa5JDMUL4ZiyWWCXL6NsFstPaABTK1cwLNUzIVkX8nG2hTuOYUXc91peZq1lYUo0vX4
 m8/v2JDQEipTFs/iVo9lxLvOlSGffWlZdkdLV
X-Received: by 2002:a05:6214:3303:b0:90c:87e7:e2b6 with SMTP id
 6a1803df08f44-9103ef75449mr14536406d6.5.1788460300587; 
 Thu, 03 Sep 2026 11:31:40 -0700 (PDT)
X-Received: by 2002:a05:6214:3303:b0:90c:87e7:e2b6 with SMTP id
 6a1803df08f44-9103ef75449mr14535196d6.5.1788460299608; 
 Thu, 03 Sep 2026 11:31:39 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.18.66.131])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91040693aaasm603596d6.34.2026.09.03.11.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 11:31:39 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 andrew.jones@oss.qualcomm.com, leif.lindholm@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Nutty Liu <nutty.liu@hotmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v9 3/5] hw/riscv: server platform reference machine
Date: Thu,  3 Sep 2026 15:31:23 -0300
Message-ID: <20260903183125.682865-4-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903183125.682865-1-daniel.barboza@oss.qualcomm.com>
References: <20260903183125.682865-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xzFt8AG7gsmmKbrlFbGPYgowozxmifml
X-Proofpoint-ORIG-GUID: xzFt8AG7gsmmKbrlFbGPYgowozxmifml
X-Authority-Analysis: v=2.4 cv=OuJ/DS/t c=1 sm=1 tr=0 ts=6a99bd0e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=CQQxcbsX5Byh3TlVSSGwig==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=NEAV23lmAAAA:8
 a=NLiCwHATAAAA:8 a=EUspDBNiAAAA:8 a=69EAbJreAAAA:8 a=C_ql9cbwDrEbyVCwxTEA:9
 a=2KoRbIiLB8rUyhBb:21 a=dawVfQjAaf238kedN5IG:22 a=F9tHCgz3TLBaZgltkx5D:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE2MiBTYWx0ZWRfXzKFJ8k6rlqt5
 dQO1Jec53BUS8P68FSUGkPDCGh9syr9A0lKR474RbNGENsGaIUTY5QMWoy3vvwJkTOwhIjdBHYe
 67N0xiMnp4YDARHxgcpOmHOQ1zblXGwcjkPdyAAAqqA2mFDi/vco7n41WnDgKiLWMUlckOP8rAT
 YxHJI6P7Rqw8ZJIQssFK+4fOg24Tbb4aIPYY1WxKt2augl735+BQA7TVluSgVbJ7QdoWg6CHIH3
 9qLaR8Xi2/TZUOOffGsVjcHJ2JMct0WmbU5a6N12q2lyCnkuxtonyymFapoUg3u/17VB2ttKoMH
 6QLlaancHkxskumLg0SdoMIm37R0kxUh4p4KELZ8n5ELnQMWGWV9Zl7qMAsHlrZOWkhS7DSdXSw
 eYZ9CLdyapLtrw56T9To/Pjo+PLXAdiEqMWIrOPlSPgnASt92KMavNMRUTbgPLZ4upfy81knj5Z
 w6B5N1Vtccnduddck4Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE2MiBTYWx0ZWRfX97/tZDhol7bQ
 JbFGLt4fhI8B1fKkx9FmT52ehZDp8bxJVwAncW7N4SE3adAffDJvsltNMvyDt9ZINt/bXm45Pdr
 RgBT+bZEzprgB08PQCtgz2k9Zkt1WlY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030162
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

The RISC-V Server Platform specification [1] defines a standardized set
of hardware and software capabilities, that portable system software,
such as OS and hypervisors can rely on being present in a RISC-V server
platform.

The main features included in this emulation are:

- Based on riscv virt machine type;
- A new memory map as close as virt machine as possible;
- An always present IOMMU platform device (riscv-iommu-sys) that uses
  IRQs 36 to 39, one IRQ for queue, similar to the 'virt' board;
- AIA;
- PCIe AHCI;
- PCIe NIC;
- No virtio device;
- No fw_cfg device;
- No ACPI table provided;
- Only minimal device tree nodes;
- a platform bus for TPM support.

A note about TPM support:  TPM devices in QEMU comes usually in two
flavors - emulated or passthrough.  A passthrough device requires a host
TPM device that the QEMU process can borrow and it's usually coupled
with KVM acceleration.

To use the TPM emulator we'll need help from an external TPM emulator
called swtpm.  More info can be found in [2].  For our purposes this is
a process that, if running Ubuntu, can be installed via 'swtpm' package.
We'll go back to it shortly.

For now, adding support for the emulated TPM device 'tpm-tis' (other TPM
flavors might work as well, 'tpm-tis' is the one tested with this work)
requires a platform bus.  Adding a platform bus will open the door for
more devices to be added in the board.  This is ok - a reference board
isn't a restricted board and users are free to add devices at their
leisure.

Here's how to use tpm-tis with the riscv-server-ref board:

- in a separated shell/term run 'swtpm' (--log is optional):

$ mkdir /tmp/mytpm1
$ swtpm socket --tpmstate dir=/tmp/mytpm1 \
	--ctrl type=unixio,path=/tmp/mytpm1/swtpm-sock \
	--tpm2 \
	--log level=20

Then start QEMU with:

$ qemu-system-riscv64 -M riscv-server-ref (...) \
	-chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
	-tpmdev emulator,id=tpm0,chardev=chrtpm\
	-device tpm-tis-device,tpmdev=tpm0

[1] https://github.com/riscv-non-isa/riscv-server-platform
[2] https://qemu-project.gitlab.io/qemu/specs/tpm.html

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
---
 configs/devices/riscv64-softmmu/default.mak |   1 +
 hw/riscv/Kconfig                            |  16 +
 hw/riscv/meson.build                        |   1 +
 hw/riscv/server_platform_ref.c              | 771 ++++++++++++++++++++
 4 files changed, 789 insertions(+)
 create mode 100644 hw/riscv/server_platform_ref.c

diff --git a/configs/devices/riscv64-softmmu/default.mak b/configs/devices/riscv64-softmmu/default.mak
index a8e4d0ab33..ae3f62e2d4 100644
--- a/configs/devices/riscv64-softmmu/default.mak
+++ b/configs/devices/riscv64-softmmu/default.mak
@@ -9,6 +9,7 @@
 # CONFIG_SIFIVE_E=n
 # CONFIG_SIFIVE_U=n
 # CONFIG_RISCV_VIRT=n
+# CONFIG_RISCV_SERVER_PLATFORM_REF=n
 # CONFIG_MICROCHIP_PFSOC=n
 # CONFIG_SHAKTI_C=n
 # CONFIG_XIANGSHAN_KUNMINGHU=n
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index d06ac26648..da59eb2155 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -69,6 +69,22 @@ config RISCV_VIRT
     select ACPI
     select ACPI_PCI
 
+config RISCV_SERVER_PLATFORM_REF
+    bool
+    default y
+    depends on RISCV64
+    imply TPM_TIS_SYSBUS
+    select RISCV_NUMA
+    select GOLDFISH_RTC
+    select PCI
+    select PCI_EXPRESS_GENERIC_BRIDGE
+    select PFLASH_CFI01
+    select SERIAL
+    select RISCV_ACLINT
+    select RISCV_APLIC
+    select RISCV_IMSIC
+    select RISCV_IOMMU
+
 config SHAKTI_C
     bool
     default y
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 7aa3c1578d..cc5a019f7c 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -7,6 +7,7 @@ riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
 riscv_ss.add(files('riscv_hart.c'))
 riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
+riscv_ss.add(when: 'CONFIG_RISCV_SERVER_PLATFORM_REF', if_true: files('server_platform_ref.c'))
 riscv_ss.add(when: 'CONFIG_SHAKTI_C', if_true: files('shakti_c.c'))
 riscv_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('sifive_e.c'))
 riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_ref.c
new file mode 100644
index 0000000000..e6b83baa8d
--- /dev/null
+++ b/hw/riscv/server_platform_ref.c
@@ -0,0 +1,771 @@
+/*
+ * QEMU RISC-V Server Platform Reference Board (riscv-server-ref)
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qemu/error-report.h"
+#include "qemu/guest-random.h"
+#include "qapi/error.h"
+#include "qapi/qapi-visit-common.h"
+#include "hw/core/boards.h"
+#include "hw/core/platform-bus.h"
+#include "hw/core/loader.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/char/serial.h"
+#include "hw/block/flash.h"
+#include "hw/ide/pci.h"
+#include "hw/ide/ahci-pci.h"
+#include "hw/pci/pci.h"
+#include "hw/pci-host/gpex.h"
+#include "hw/core/sysbus-fdt.h"
+#include "hw/riscv/riscv_hart.h"
+#include "hw/riscv/boot.h"
+#include "hw/riscv/device-common.h"
+#include "hw/riscv/fdt-common.h"
+#include "hw/riscv/machines-qom.h"
+#include "hw/riscv/numa.h"
+#include "hw/riscv/iommu.h"
+#include "hw/riscv/riscv-iommu.h"
+#include "hw/riscv/riscv-iommu-bits.h"
+#include "hw/intc/riscv_aclint.h"
+#include "hw/intc/riscv_aplic.h"
+#include "hw/intc/riscv_imsic.h"
+#include "chardev/char.h"
+#include "hw/char/serial-mm.h"
+#include "system/device_tree.h"
+#include "system/runstate.h"
+#include "system/system.h"
+#include "system/kvm.h"
+#include "system/tcg.h"
+#include "kvm/kvm_riscv.h"
+#include "system/tpm.h"
+#include "system/qtest.h"
+#include "target/riscv/cpu.h"
+#include "net/net.h"
+
+#include "aia.h"
+
+#define RVSERVER_CPUS_MAX_BITS             9
+#define RVSERVER_CPUS_MAX                  (1 << RVSERVER_CPUS_MAX_BITS)
+#define RVSERVER_SOCKETS_MAX_BITS          2
+#define RVSERVER_SOCKETS_MAX               (1 << RVSERVER_SOCKETS_MAX_BITS)
+
+#define RVSERVER_IRQCHIP_NUM_MSIS 255
+#define RVSERVER_IRQCHIP_NUM_SOURCES 96
+#define RVSERVER_IRQCHIP_NUM_PRIO_BITS 3
+#define RVSERVER_IRQCHIP_MAX_GUESTS_BITS 3
+#define RVSERVER_IRQCHIP_MAX_GUESTS \
+    ((1U << RVSERVER_IRQCHIP_MAX_GUESTS_BITS) - 1U)
+
+#define NUM_SATA_PORTS  6
+
+#define SYSCON_RESET     0x1
+#define SYSCON_POWEROFF  0x2
+
+#define RVSERVER_PLATFORM_BUS_NUM_IRQS 8
+
+#define TYPE_RISCV_SERVER_REF_MACHINE MACHINE_TYPE_NAME("riscv-server-ref")
+OBJECT_DECLARE_SIMPLE_TYPE(RISCVServerRefMachineState, RISCV_SERVER_REF_MACHINE)
+
+struct RISCVServerRefMachineState {
+    /*< private >*/
+    MachineState parent;
+
+    /*< public >*/
+    Notifier machine_done;
+    RISCVHartArrayState soc[RVSERVER_SOCKETS_MAX];
+    DeviceState *irqchip[RVSERVER_SOCKETS_MAX];
+    PFlashCFI01 *flash[2];
+
+    int fdt_size;
+    int aia_guests;
+    const MemMapEntry *memmap;
+
+    DeviceState *platform_bus_dev;
+};
+
+enum {
+    RVSERVER_DEBUG,
+    RVSERVER_MROM,
+    RVSERVER_RESET_SYSCON,
+    RVSERVER_RTC,
+    RVSERVER_IOMMU_SYS,
+    RVSERVER_ACLINT,
+    RVSERVER_APLIC_M,
+    RVSERVER_APLIC_S,
+    RVSERVER_UART0,
+    RVSERVER_IMSIC_M,
+    RVSERVER_IMSIC_S,
+    RVSERVER_FLASH,
+    RVSERVER_DRAM,
+    RVSERVER_PCIE_MMIO,
+    RVSERVER_PCIE_PIO,
+    RVSERVER_PLATFORM_BUS,
+    RVSERVER_PCIE_ECAM,
+    RVSERVER_PCIE_MMIO_HIGH
+};
+
+enum {
+    RVSERVER_UART0_IRQ = 10,
+    RVSERVER_RTC_IRQ = 11,
+    RVSERVER_PCIE_IRQ = 32, /* 32 to 35 */
+    IOMMU_SYS_IRQ = 36, /* 36 to 39 */
+    RVSERVER_PLATFORM_BUS_IRQ = 40, /* 40 to 48 */
+};
+
+/*
+ * The server soc reference machine physical address space used by some of the
+ * devices namely ACLINT, APLIC and IMSIC depend on number of Sockets, number
+ * of CPUs, and number of IMSIC guest files.
+ *
+ * Various limits defined by RVSERVER_SOCKETS_MAX_BITS, RVSERVER_CPUS_MAX_BITS,
+ * and RVSERVER_IRQCHIP_MAX_GUESTS_BITS are tuned for maximum utilization of
+ * server reference machine physical address space.
+ */
+
+#define RVSERVER_IMSIC_GROUP_MAX_SIZE      (1U << IMSIC_MMIO_GROUP_MIN_SHIFT)
+#if RVSERVER_IMSIC_GROUP_MAX_SIZE < \
+    IMSIC_GROUP_SIZE(RVSERVER_CPUS_MAX_BITS, RVSERVER_IRQCHIP_MAX_GUESTS_BITS)
+#error "Can't accomodate single IMSIC group in address space"
+#endif
+
+#define RVSERVER_IMSIC_MAX_SIZE            (RVSERVER_SOCKETS_MAX * \
+                                        RVSERVER_IMSIC_GROUP_MAX_SIZE)
+#if 0x4000000 < RVSERVER_IMSIC_MAX_SIZE
+#error "Can't accomodate all IMSIC groups in address space"
+#endif
+
+static const MemMapEntry rvserver_ref_memmap[] = {
+    [RVSERVER_DEBUG] =          {        0x0,         0x100 },
+    [RVSERVER_MROM] =           {     0x1000,        0xf000 },
+    [RVSERVER_RESET_SYSCON] =   {   0x100000,        0x1000 },
+    [RVSERVER_RTC] =            {   0x101000,        0x1000 },
+    [RVSERVER_IOMMU_SYS] =      {   0x102000,        0x1000 },
+    [RVSERVER_ACLINT] =         {  0x2000000,       0x10000 },
+    [RVSERVER_PCIE_PIO] =       {  0x3000000,       0x10000 },
+    [RVSERVER_PLATFORM_BUS] =   {  0x4000000,     0x2000000 },
+    [RVSERVER_APLIC_M] =        {  0xc000000, APLIC_SIZE(RVSERVER_CPUS_MAX) },
+    [RVSERVER_APLIC_S] =        {  0xd000000, APLIC_SIZE(RVSERVER_CPUS_MAX) },
+    [RVSERVER_UART0] =          { 0x10000000,         0x100 },
+    [RVSERVER_FLASH] =          { 0x20000000,     0x4000000 },
+    [RVSERVER_IMSIC_M] =        { 0x24000000, RVSERVER_IMSIC_MAX_SIZE },
+    [RVSERVER_IMSIC_S] =        { 0x28000000, RVSERVER_IMSIC_MAX_SIZE },
+    [RVSERVER_PCIE_ECAM] =      { 0x30000000,    0x10000000 },
+    [RVSERVER_PCIE_MMIO] =      { 0x40000000,    0x40000000 },
+    [RVSERVER_DRAM] =           { 0x80000000, 0xff80000000ull },
+    [RVSERVER_PCIE_MMIO_HIGH] = { 0x10000000000ull, 0x10000000000ull },
+};
+
+#define RVSERVER_FLASH_SECTOR_SIZE (256 * KiB)
+
+static void rvserver_flash_maps(RISCVServerRefMachineState *s,
+                                MemoryRegion *sysmem)
+{
+    hwaddr flashsize = rvserver_ref_memmap[RVSERVER_FLASH].size / 2;
+    hwaddr flashbase = rvserver_ref_memmap[RVSERVER_FLASH].base;
+
+    riscv_init_flash_map(s->flash[0], flashbase, flashsize,
+                         sysmem, RVSERVER_FLASH_SECTOR_SIZE);
+    riscv_init_flash_map(s->flash[1], flashbase + flashsize, flashsize,
+                         sysmem, RVSERVER_FLASH_SECTOR_SIZE);
+}
+
+static void create_fdt_pmu(RISCVServerRefMachineState *s)
+{
+    g_autofree char *pmu_name = g_strdup_printf("/pmu");
+    MachineState *ms = MACHINE(s);
+    RISCVCPU *hart = &s->soc[0].harts[0];
+
+    qemu_fdt_add_subnode(ms->fdt, pmu_name);
+    qemu_fdt_setprop_string(ms->fdt, pmu_name, "compatible", "riscv,pmu");
+    riscv_pmu_generate_fdt_node(ms->fdt, hart->pmu_avail_ctrs, pmu_name);
+}
+
+static void create_fdt_sockets(RISCVServerRefMachineState *s,
+                               const MemMapEntry *memmap,
+                               uint32_t *phandle,
+                               uint32_t *irq_mmio_phandle,
+                               uint32_t *irq_pcie_phandle,
+                               uint32_t *msi_pcie_phandle)
+{
+    int socket, phandle_pos;
+    MachineState *ms = MACHINE(s);
+    uint32_t msi_m_phandle = 0, msi_s_phandle = 0;
+    uint32_t xplic_phandles[MAX_NODES];
+    g_autofree uint32_t *intc_phandles = NULL;
+    int socket_count = riscv_socket_count(ms);
+    bool numa_enabled = riscv_numa_enabled(ms);
+    bool is_32_bit = riscv_is_32bit(&s->soc[0]);
+    IMSICFdtProps imsic_fdt_props;
+    APLICFdtProps aplic_fdt_props;
+    ACLINTFdtProps aclint_props;
+
+    riscv_fdt_create_cpu_socket_subnode(ms->fdt,
+        kvm_enabled() ? kvm_riscv_get_timebase_frequency(&s->soc->harts[0])
+                        : RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ);
+
+    intc_phandles = g_new0(uint32_t, ms->smp.cpus);
+
+    aclint_props.clint = &memmap[RVSERVER_ACLINT];
+    aclint_props.aia_type = AIA_TYPE_APLIC_IMSIC;
+    aclint_props.numa_enabled = numa_enabled;
+
+    phandle_pos = ms->smp.cpus;
+    for (socket = (socket_count - 1); socket >= 0; socket--) {
+        hwaddr memaddr = s->memmap[RVSERVER_DRAM].base +
+                         riscv_socket_mem_offset(ms, socket);
+        uint64_t memsize = riscv_socket_mem_size(ms, socket);
+
+        phandle_pos -= s->soc[socket].num_harts;
+
+        riscv_create_fdt_socket_cpus(ms->fdt, (&s->soc[socket])->harts, socket,
+                                     s->soc[socket].num_harts,
+                                     s->soc[socket].hartid_base,
+                                     phandle, &intc_phandles[phandle_pos],
+                                     numa_enabled, is_32_bit);
+
+        riscv_create_fdt_socket_memory(ms->fdt, memaddr, memsize,
+                                       socket, riscv_numa_enabled(ms));
+
+        aclint_props.socket = socket;
+        aclint_props.num_harts = s->soc[socket].num_harts;
+        riscv_create_fdt_socket_aclint(ms->fdt, &aclint_props,
+                                       &intc_phandles[phandle_pos]);
+    }
+
+    imsic_fdt_props.soc = &s->soc;
+    imsic_fdt_props.socket_count = socket_count;
+    imsic_fdt_props.smp_cpus = ms->smp.cpus;
+    imsic_fdt_props.imsic_m_base = memmap[RVSERVER_IMSIC_M].base;
+    imsic_fdt_props.imsic_s_base = memmap[RVSERVER_IMSIC_S].base;
+    imsic_fdt_props.imsic_group_max_size = RVSERVER_IMSIC_GROUP_MAX_SIZE;
+    imsic_fdt_props.irqchip_num_msis = RVSERVER_IRQCHIP_NUM_MSIS;
+    imsic_fdt_props.aia_guests = s->aia_guests;
+
+    riscv_create_fdt_imsic(ms->fdt, &imsic_fdt_props, phandle, intc_phandles,
+                           &msi_m_phandle, &msi_s_phandle);
+    *msi_pcie_phandle = msi_s_phandle;
+
+    aplic_fdt_props.aplic_m = !kvm_enabled()
+                              ? &memmap[RVSERVER_APLIC_M] : NULL;
+    aplic_fdt_props.aplic_s = &memmap[RVSERVER_APLIC_S];
+    aplic_fdt_props.platform_bus = &memmap[RVSERVER_PLATFORM_BUS];
+    aplic_fdt_props.platform_bus_irq = RVSERVER_PLATFORM_BUS_IRQ;
+    aplic_fdt_props.num_harts = ms->smp.cpus;
+    aplic_fdt_props.numa_enabled = numa_enabled;
+    aplic_fdt_props.irqchip_num_sources = RVSERVER_IRQCHIP_NUM_SOURCES;
+    aplic_fdt_props.aia_type = AIA_TYPE_APLIC_IMSIC;
+
+    phandle_pos = ms->smp.cpus;
+    for (socket = (socket_count - 1); socket >= 0; socket--) {
+        phandle_pos -= s->soc[socket].num_harts;
+
+        aplic_fdt_props.socket = socket;
+        aplic_fdt_props.num_harts = s->soc[socket].num_harts;
+        riscv_create_fdt_socket_aplic(ms->fdt, &aplic_fdt_props,
+                                      msi_m_phandle, msi_s_phandle, phandle,
+                                      &intc_phandles[phandle_pos],
+                                      xplic_phandles);
+    }
+
+    for (socket = 0; socket < socket_count; socket++) {
+        if (socket == 0) {
+            *irq_mmio_phandle = xplic_phandles[socket];
+            *irq_pcie_phandle = xplic_phandles[socket];
+        }
+        if (socket == 1) {
+            *irq_pcie_phandle = xplic_phandles[socket];
+        }
+    }
+
+    riscv_socket_fdt_write_distance_matrix(ms);
+}
+
+static void finalize_fdt(RISCVServerRefMachineState *s)
+{
+    uint32_t phandle = 1, irq_mmio_phandle = 1, msi_pcie_phandle = 1;
+    uint32_t irq_pcie_phandle = 1, iommu_sys_phandle;
+    g_autofree char *name = NULL;
+    MachineState *ms = MACHINE(s);
+
+    create_fdt_sockets(s, rvserver_ref_memmap, &phandle, &irq_mmio_phandle,
+                       &irq_pcie_phandle, &msi_pcie_phandle);
+
+    iommu_sys_phandle = riscv_create_fdt_riscv_iommu_sys(ms->fdt,
+                                         s->memmap[RVSERVER_IOMMU_SYS].base,
+                                         s->memmap[RVSERVER_IOMMU_SYS].size,
+                                         &phandle, irq_mmio_phandle,
+                                         msi_pcie_phandle, IOMMU_SYS_IRQ);
+
+    riscv_create_fdt_pcie(ms->fdt, AIA_TYPE_APLIC_IMSIC, true,
+                          &s->memmap[RVSERVER_PCIE_ECAM],
+                          &s->memmap[RVSERVER_PCIE_PIO],
+                          &s->memmap[RVSERVER_PCIE_MMIO],
+                          &s->memmap[RVSERVER_PCIE_MMIO_HIGH],
+                          irq_pcie_phandle, msi_pcie_phandle,
+                          iommu_sys_phandle, RVSERVER_PCIE_IRQ);
+
+    riscv_create_fdt_syscon(ms->fdt, &phandle,
+                            rvserver_ref_memmap[RVSERVER_RESET_SYSCON].base,
+                            rvserver_ref_memmap[RVSERVER_RESET_SYSCON].size,
+                            SYSCON_RESET, SYSCON_POWEROFF, false);
+
+    riscv_create_fdt_uart(ms->fdt, &rvserver_ref_memmap[RVSERVER_UART0],
+                          RVSERVER_UART0_IRQ, AIA_TYPE_APLIC_IMSIC,
+                          irq_mmio_phandle);
+    name = riscv_fdt_get_uart_nodename(rvserver_ref_memmap[RVSERVER_UART0].base);
+    qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", name);
+    qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", name);
+
+    riscv_create_fdt_rtc(ms->fdt, &rvserver_ref_memmap[RVSERVER_RTC],
+                         RVSERVER_RTC_IRQ, AIA_TYPE_APLIC_IMSIC,
+                         irq_mmio_phandle);
+}
+
+static void create_fdt(RISCVServerRefMachineState *s,
+                       const MemMapEntry *memmap)
+{
+    MachineState *ms = MACHINE(s);
+    uint8_t rng_seed[32];
+    g_autofree char *name = NULL;
+
+    ms->fdt = riscv_create_board_device_tree(MACHINE_GET_CLASS(s)->desc,
+                                             "qemu,riscv-server-ref",
+                                             &s->fdt_size);
+
+    /*
+     * This versioning scheme is for informing platform fw only. It is neither:
+     * - A QEMU versioned machine type; a given version of QEMU will emulate
+     *   a given version of the platform.
+     * - A reflection of level of server platform support provided.
+     *
+     * machine-version-major: updated when changes breaking fw compatibility
+     *                        are introduced.
+     * machine-version-minor: updated when features are added that don't break
+     *                        fw compatibility.
+     *
+     * It's the same as the scheme in arm sbsa-ref.
+     */
+    qemu_fdt_setprop_cell(ms->fdt, "/", "machine-version-major", 0);
+    qemu_fdt_setprop_cell(ms->fdt, "/", "machine-version-minor", 0);
+
+    /*
+     * The "/soc/pci@..." node is needed for PCIE hotplugs
+     * that might happen before finalize_fdt().
+     */
+    name = g_strdup_printf("/soc/pci@%"HWADDR_PRIx,
+                           s->memmap[RVSERVER_PCIE_ECAM].base);
+    qemu_fdt_add_subnode(ms->fdt, name);
+
+    qemu_fdt_add_subnode(ms->fdt, "/chosen");
+    qemu_fdt_add_subnode(ms->fdt, "/aliases");
+
+    /* Pass seed to RNG */
+    qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));
+    qemu_fdt_setprop(ms->fdt, "/chosen", "rng-seed",
+                     rng_seed, sizeof(rng_seed));
+
+    riscv_create_fdt_flash(ms->fdt, rvserver_ref_memmap[RVSERVER_FLASH].base,
+                           rvserver_ref_memmap[RVSERVER_FLASH].size / 2);
+    create_fdt_pmu(s);
+
+}
+
+static void rvserver_init_pci_devices(RISCVServerRefMachineState *s,
+                                      DeviceState *gpex_host)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(s);
+    PCIHostState *pci = PCI_HOST_BRIDGE(gpex_host);
+    PCIDevice *pdev_ahci;
+    AHCIPCIState *ich9;
+    DriveInfo *hd[NUM_SATA_PORTS];
+
+    pci_init_nic_devices(pci->bus, mc->default_nic);
+
+    /* IDE disk setup.  */
+    pdev_ahci = pci_create_simple(pci->bus, -1, TYPE_ICH9_AHCI);
+    ich9 = ICH9_AHCI(pdev_ahci);
+    g_assert(ARRAY_SIZE(hd) == ich9->ahci.ports);
+    ide_drive_get(hd, ich9->ahci.ports);
+    ahci_ide_create_devs(&ich9->ahci, hd);
+}
+
+static uint64_t rvserver_reset_syscon_read(void *opaque, hwaddr addr,
+                                           unsigned size)
+{
+    return 0;
+}
+
+static void rvserver_reset_syscon_write(void *opaque, hwaddr addr,
+                                        uint64_t val64, unsigned int size)
+{
+    switch (val64) {
+    case SYSCON_POWEROFF:
+        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+        return;
+    case SYSCON_RESET:
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+        return;
+    default:
+        break;
+    }
+}
+
+static const MemoryRegionOps rvserver_reset_syscon_ops = {
+    .read = rvserver_reset_syscon_read,
+    .write = rvserver_reset_syscon_write,
+    .endianness = DEVICE_LITTLE_ENDIAN
+};
+
+static void rvserver_ref_machine_done(Notifier *notifier, void *data)
+{
+    RISCVServerRefMachineState *s = container_of(
+        notifier, RISCVServerRefMachineState, machine_done);
+    const MemMapEntry *memmap = rvserver_ref_memmap;
+    MachineState *machine = MACHINE(s);
+    hwaddr start_addr = memmap[RVSERVER_DRAM].base;
+    target_ulong firmware_end_addr, kernel_start_addr;
+    const char *firmware_name = riscv_default_firmware_name(&s->soc[0]);
+    uint64_t fdt_load_addr;
+    uint64_t kernel_entry = 0;
+    BlockBackend *pflash_blk0;
+    RISCVBootInfo boot_info;
+
+    /*
+     * An user provided dtb must include everything, including
+     * dynamic sysbus devices. Our FDT needs to be finalized.
+     */
+    if (machine->dtb == NULL) {
+        finalize_fdt(s);
+    }
+
+    riscv_boot_info_init(&boot_info, &s->soc[0]);
+
+    firmware_end_addr = riscv_find_and_load_firmware(machine, &boot_info,
+                                                    firmware_name,
+                                                     &start_addr, NULL);
+
+    pflash_blk0 = pflash_cfi01_get_blk(s->flash[0]);
+    if (pflash_blk0) {
+        if (machine->firmware && !strcmp(machine->firmware, "none")) {
+            /*
+             * Pflash was supplied but bios is none and not KVM guest,
+             * let's overwrite the address we jump to after reset to
+             * the base of the flash.
+             */
+            start_addr = rvserver_ref_memmap[RVSERVER_FLASH].base;
+        } else {
+            /*
+             * Pflash was supplied but either KVM guest or bios is not none.
+             * In this case, base of the flash would contain S-mode payload.
+             */
+            riscv_setup_firmware_boot(machine);
+            kernel_entry = rvserver_ref_memmap[RVSERVER_FLASH].base;
+        }
+    }
+
+    if (machine->kernel_filename && !kernel_entry) {
+        kernel_start_addr = riscv_calc_kernel_start_addr(&boot_info,
+                                                         firmware_end_addr);
+        riscv_load_kernel(machine, &boot_info, kernel_start_addr, true, NULL);
+        kernel_entry = boot_info.image_low_addr;
+    }
+
+    fdt_load_addr = riscv_compute_fdt_addr(memmap[RVSERVER_DRAM].base,
+                                           memmap[RVSERVER_DRAM].size,
+                                           machine, &boot_info);
+
+    riscv_load_fdt(fdt_load_addr, machine->fdt);
+
+    /* load the reset vector */
+    riscv_setup_rom_reset_vec(machine, &s->soc[0], start_addr,
+                              rvserver_ref_memmap[RVSERVER_MROM].base,
+                              rvserver_ref_memmap[RVSERVER_MROM].size,
+                              kernel_entry,
+                              fdt_load_addr);
+
+}
+
+static bool rvserver_aclint_allowed(void)
+{
+    return tcg_enabled() || qtest_enabled();
+}
+
+static void rvserver_ref_machine_init(MachineState *machine)
+{
+    const MemMapEntry *memmap = rvserver_ref_memmap;
+    RISCVServerRefMachineState *s = RISCV_SERVER_REF_MACHINE(machine);
+    MemoryRegion *system_memory = get_system_memory();
+    MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
+    MemoryRegion *reset_syscon_io = g_new(MemoryRegion, 1);
+    DeviceState *mmio_irqchip, *pcie_irqchip, *gpex_host;
+    int i, base_hartid, hart_count;
+    int socket_count = riscv_socket_count(machine);
+    int imsic_bits = imsic_num_bits(s->aia_guests + 1);
+
+    /* Check socket count limit */
+    if (RVSERVER_SOCKETS_MAX < socket_count) {
+        error_report("number of sockets/nodes should be less than %d",
+            RVSERVER_SOCKETS_MAX);
+        exit(1);
+    }
+
+    if (!rvserver_aclint_allowed()) {
+        error_report("'aclint' is only available with TCG acceleration");
+        exit(1);
+    }
+
+    s->memmap = rvserver_ref_memmap;
+
+    /* Initialize sockets */
+    mmio_irqchip = pcie_irqchip = NULL;
+    for (i = 0; i < socket_count; i++) {
+        g_autofree char *soc_name = g_strdup_printf("soc%d", i);
+
+        if (!riscv_socket_check_hartids(machine, i)) {
+            error_report("discontinuous hartids in socket%d", i);
+            exit(1);
+        }
+
+        base_hartid = riscv_socket_first_hartid(machine, i);
+        if (base_hartid < 0) {
+            error_report("can't find hartid base for socket%d", i);
+            exit(1);
+        }
+
+        hart_count = riscv_socket_hart_count(machine, i);
+        if (hart_count < 0) {
+            error_report("can't find hart count for socket%d", i);
+            exit(1);
+        }
+
+        object_initialize_child(OBJECT(machine), soc_name, &s->soc[i],
+                                TYPE_RISCV_HART_ARRAY);
+        object_property_set_str(OBJECT(&s->soc[i]), "cpu-type",
+                                machine->cpu_type, &error_abort);
+        object_property_set_int(OBJECT(&s->soc[i]), "hartid-base",
+                                base_hartid, &error_abort);
+        object_property_set_int(OBJECT(&s->soc[i]), "num-harts",
+                                hart_count, &error_abort);
+        sysbus_realize(SYS_BUS_DEVICE(&s->soc[i]), &error_fatal);
+
+        /* Per-socket ACLINT MTIMER */
+        riscv_aclint_mtimer_create(memmap[RVSERVER_ACLINT].base +
+                i * RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
+            RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
+            base_hartid, hart_count,
+            RISCV_ACLINT_DEFAULT_MTIMECMP,
+            RISCV_ACLINT_DEFAULT_MTIME,
+            RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, true);
+
+        /* Per-socket interrupt controller */
+        s->irqchip[i] = riscv_create_aia(true, s->aia_guests,
+                                         IMSIC_HART_SIZE(0),
+                                         IMSIC_HART_SIZE(imsic_bits),
+                                         RVSERVER_IRQCHIP_NUM_SOURCES,
+                                         &s->memmap[RVSERVER_APLIC_M],
+                                         &s->memmap[RVSERVER_APLIC_S],
+                                         &s->memmap[RVSERVER_IMSIC_M],
+                                         &s->memmap[RVSERVER_IMSIC_S],
+                                         i, base_hartid, hart_count,
+                                         RVSERVER_IRQCHIP_NUM_MSIS,
+                                         RVSERVER_IRQCHIP_NUM_PRIO_BITS);
+
+        /* Try to use different IRQCHIP instance based device type */
+        if (i == 0) {
+            mmio_irqchip = s->irqchip[i];
+            pcie_irqchip = s->irqchip[i];
+        }
+        if (i == 1) {
+            pcie_irqchip = s->irqchip[i];
+        }
+    }
+
+    /* register system main memory (actual RAM) */
+    memory_region_add_subregion(system_memory, memmap[RVSERVER_DRAM].base,
+        machine->ram);
+
+    /* boot rom */
+    memory_region_init_rom(mask_rom, NULL, "riscv_rvserver_ref_board.mrom",
+                           memmap[RVSERVER_MROM].size, &error_fatal);
+    memory_region_add_subregion(system_memory, memmap[RVSERVER_MROM].base,
+                                mask_rom);
+
+    memory_region_init_io(reset_syscon_io, NULL, &rvserver_reset_syscon_ops,
+                          NULL, "reset_syscon_io",
+                          memmap[RVSERVER_RESET_SYSCON].size);
+    memory_region_add_subregion(system_memory,
+                                memmap[RVSERVER_RESET_SYSCON].base,
+                                reset_syscon_io);
+
+    gpex_host = riscv_gpex_pcie_init(system_memory, pcie_irqchip,
+                                     &rvserver_ref_memmap[RVSERVER_PCIE_ECAM],
+                                     &rvserver_ref_memmap[RVSERVER_PCIE_MMIO],
+                                     &rvserver_ref_memmap[RVSERVER_PCIE_MMIO_HIGH],
+                                     &rvserver_ref_memmap[RVSERVER_PCIE_PIO],
+                                     RVSERVER_PCIE_IRQ);
+
+    /* Init nic devices and ICH9 AHCI */
+    rvserver_init_pci_devices(s, gpex_host);
+
+    s->platform_bus_dev = riscv_create_platform_bus(mmio_irqchip,
+                                                    &s->memmap[RVSERVER_PLATFORM_BUS],
+                                                    RVSERVER_PLATFORM_BUS_IRQ,
+                                                    RVSERVER_PLATFORM_BUS_NUM_IRQS);
+
+    serial_mm_init(system_memory, memmap[RVSERVER_UART0].base,
+        0, qdev_get_gpio_in(mmio_irqchip, RVSERVER_UART0_IRQ), 399193,
+        serial_hd(0), DEVICE_LITTLE_ENDIAN);
+
+    sysbus_create_simple("goldfish_rtc", memmap[RVSERVER_RTC].base,
+        qdev_get_gpio_in(mmio_irqchip, RVSERVER_RTC_IRQ));
+
+    for (i = 0; i < ARRAY_SIZE(s->flash); i++) {
+        /* Map legacy -drive if=pflash to machine properties */
+        pflash_cfi01_legacy_drive(s->flash[i],
+                                  drive_get(IF_PFLASH, 0, i));
+    }
+    rvserver_flash_maps(s, system_memory);
+
+    /* load/create device tree */
+    if (machine->dtb) {
+        machine->fdt = load_device_tree(machine->dtb, &s->fdt_size);
+        if (!machine->fdt) {
+            error_report("load_device_tree() failed");
+            exit(1);
+        }
+    } else {
+        create_fdt(s, memmap);
+    }
+
+    riscv_create_iommu_sys(mmio_irqchip, s->memmap[RVSERVER_IOMMU_SYS].base,
+                           IOMMU_SYS_IRQ, false);
+
+    s->machine_done.notify = rvserver_ref_machine_done;
+    qemu_add_machine_init_done_notifier(&s->machine_done);
+}
+
+static void rvserver_ref_machine_instance_init(Object *obj)
+{
+    RISCVServerRefMachineState *s = RISCV_SERVER_REF_MACHINE(obj);
+
+    s->flash[0] = riscv_flash_create(OBJECT(s), "riscv-server-ref.flash0",
+                                        "pflash0", RVSERVER_FLASH_SECTOR_SIZE);
+    s->flash[1] = riscv_flash_create(OBJECT(s), "riscv-server-ref.flash1",
+                                        "pflash1", RVSERVER_FLASH_SECTOR_SIZE);
+}
+
+static char *rvserver_ref_get_aia_guests(Object *obj, Error **errp)
+{
+    RISCVServerRefMachineState *s = RISCV_SERVER_REF_MACHINE(obj);
+    char val[32];
+
+    sprintf(val, "%d", s->aia_guests);
+    return g_strdup(val);
+}
+
+static void rvserver_ref_set_aia_guests(Object *obj, const char *val,
+                                        Error **errp)
+{
+    RISCVServerRefMachineState *s = RISCV_SERVER_REF_MACHINE(obj);
+
+    s->aia_guests = atoi(val);
+    if (s->aia_guests < 0 || s->aia_guests > RVSERVER_IRQCHIP_MAX_GUESTS) {
+        error_setg(errp, "Invalid number of AIA IMSIC guests");
+        error_append_hint(errp, "Valid values be between 0 and %d.\n",
+                          RVSERVER_IRQCHIP_MAX_GUESTS);
+    }
+}
+
+static HotplugHandler *rvserver_machine_get_hotplug_handler(MachineState *ms,
+                                                            DeviceState *dev)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+
+    if (device_is_dynamic_sysbus(mc, dev)) {
+        return HOTPLUG_HANDLER(ms);
+    }
+
+    return NULL;
+}
+
+static void rvserver_machine_device_plug_cb(HotplugHandler *hotplug_dev,
+                                            DeviceState *dev, Error **errp)
+{
+    RISCVServerRefMachineState *s = RISCV_SERVER_REF_MACHINE(hotplug_dev);
+
+    if (s->platform_bus_dev) {
+        MachineClass *mc = MACHINE_GET_CLASS(s);
+
+        if (device_is_dynamic_sysbus(mc, dev)) {
+            platform_bus_link_device(PLATFORM_BUS_DEVICE(s->platform_bus_dev),
+                                     SYS_BUS_DEVICE(dev));
+        }
+    }
+}
+
+static void rvserver_ref_machine_class_init(ObjectClass *oc, const void *data)
+{
+    char str[128];
+    MachineClass *mc = MACHINE_CLASS(oc);
+    HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
+    static const char * const valid_cpu_types[] = {
+        TYPE_RISCV_CPU_RVSERVER_REF,
+    };
+
+    /* Note: this is used as /model in the FDT.  */
+    mc->desc = "RISC-V Server Platform Reference Board v1.0";
+    mc->init = rvserver_ref_machine_init;
+    mc->max_cpus = RVSERVER_CPUS_MAX;
+    mc->default_cpu_type = TYPE_RISCV_CPU_RVSERVER_REF;
+    mc->valid_cpu_types = valid_cpu_types;
+    mc->pci_allow_0_address = true;
+    mc->default_nic = "e1000e";
+    mc->possible_cpu_arch_ids = riscv_numa_possible_cpu_arch_ids;
+    mc->cpu_index_to_instance_props = riscv_numa_cpu_index_to_props;
+    mc->get_default_cpu_node_id = riscv_numa_get_default_cpu_node_id;
+    mc->numa_mem_supported = true;
+    /* platform instead of architectural choice */
+    mc->cpu_cluster_has_numa_boundary = true;
+    mc->default_ram_id = "riscv_rvserver_ref_board.ram";
+
+    object_class_property_add_str(oc, "aia-guests",
+                                  rvserver_ref_get_aia_guests,
+                                  rvserver_ref_set_aia_guests);
+    sprintf(str, "Set number of guest MMIO pages for AIA IMSIC. Valid value "
+                 "should be between 0 and %d.", RVSERVER_IRQCHIP_MAX_GUESTS);
+    object_class_property_set_description(oc, "aia-guests", str);
+
+    assert(!mc->get_hotplug_handler);
+    mc->get_hotplug_handler = rvserver_machine_get_hotplug_handler;
+    hc->plug = rvserver_machine_device_plug_cb;
+#ifdef CONFIG_TPM
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
+#endif
+}
+
+static const TypeInfo rvserver_ref_typeinfo = {
+    .name       = TYPE_RISCV_SERVER_REF_MACHINE,
+    .parent     = TYPE_MACHINE,
+    .class_init = rvserver_ref_machine_class_init,
+    .instance_init = rvserver_ref_machine_instance_init,
+    .instance_size = sizeof(RISCVServerRefMachineState),
+    .interfaces = (const InterfaceInfo[]) {
+         { TYPE_HOTPLUG_HANDLER },
+         { TYPE_TARGET_RISCV64_MACHINE },
+         { }
+    },
+};
+
+static void rvserver_ref_init_register_types(void)
+{
+    type_register_static(&rvserver_ref_typeinfo);
+}
+
+type_init(rvserver_ref_init_register_types)
-- 
2.43.0


