Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B408D606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b69ghht4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TimJgasb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNnYG-000745-Qi; Mon, 02 Nov 2026 03:38:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xNnTe-0002xe-Nh
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 03:33:14 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xNnTc-0004wS-27
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 03:33:14 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A26pgcx3121054
 for <qemu-devel@nongnu.org>; Mon, 2 Nov 2026 08:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=rzKzpRgHDzI
 YMhBpcUFMZ1PSgwYIZVd+lG1UGtfAzM0=; b=b69ghht42BH3eM+nUo3U8d+SMWC
 dUW2WyNTsSI2WxP9+34cdD7Do2ptCAO1V+iuWjiF4kJBMyd1SpTluLqTcGPgzCpK
 cE1Zuyd2NnrG56mQBFK+e4NexGQS46nCj+XSo8mMPXyebxg2mOfG5Ks7WGKS7Y/Z
 sjalW8UvEgyGusvLVIDpav9MmmlJ/WLt9UsVXPkGEgAF3kDJjhlLdTM0pNUwehX8
 NSk48cTzk011iLTJDC5nPcbZN7apeoGotTwew8EynM4mz1zWqFASzpNH5UaSvVKk
 lGNbaflfNLIjQWVORzNsOrTuDwD1B9U7VgMk4NfgyVM53UFe9OMWm13AMyw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpnmerc2p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 08:33:10 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36a0e07082dso334214eec.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 00:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793608390; x=1794213190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rzKzpRgHDzIYMhBpcUFMZ1PSgwYIZVd+lG1UGtfAzM0=;
 b=TimJgasbE3+WouUGDgb8yDawAnBcHxALYMXe6AzOo941rs7pVOS5Cf7R1XvbweZX5n
 Bt4ItmQa4xu2nb/yW57q8aJmPLi5ryE93X091ZoKhbwJvWljK+Gr7DkTbNlaXEAn/+kD
 INWSNuLAckfeZHRqU8xnhRT+0Ax+4KNnyLqJ3Bb+wfHvifWTM9+WxWSS3hZ3WGP1GzGj
 du7wA802HrWdKvolf5M+hgxacDlscJLXGW+aEnaKLTP6pAibw01xcNvwZilMqTCBfLOE
 WQJHm4dRsEhGqO2iwU2k0tKcJaK356ZcGlWOiXSnNa5pOQgYj0yMsWpnwz0p/dDSQYp8
 F+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793608390; x=1794213190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rzKzpRgHDzIYMhBpcUFMZ1PSgwYIZVd+lG1UGtfAzM0=;
 b=Ae2sIYckhEsEcbmTXsDVR84rs3a4sv0l0Vc1bwvtxMxfykYp8U82tpc1463/yH1YW9
 9idD/LZanY3P6sS4YSe50mVjcdheUP/er1NL40z0drvvO03E5yJhmzjnXWKZxNprTxzg
 GjDuu9NDj2Yb4DiPxlpbS+ZEbu6080C9EYL6t+N1ANYz2odGTWd3IUlcsCNRQXvvM8sT
 VpIaN4GGO1ZbQRTdBR8KXzn5ygI2lngc/nhTrqQu5l36G1IvKWw/HR85QZmqL1bZNwT4
 RKXb5cXPjGKM3lcLufKeiBB/9u84ekhWTVc6kjZWcexXuSAk+rAD6isALz5Kq9L5+R3o
 OAQw==
X-Gm-Message-State: APuU4Z/e7pp0j5DbelH1APUots9dC+0EmXxvHhU1dnTUXyPFkJggPTmD
 0jWkq9NjVt/tYNTxpFKyheZDxW1dU/8PIWwXepww3gyn0129DpMaljRNi2dNdRJKl9UnfowgFxD
 D+IUgwrt2Wyj1KUDDZ5RBHsX2OLl0XYZ4rxXP2kIrN3DtoOCjSayevo4KpWWNSD61pg==
X-Gm-Gg: AYBFou3cr1sxf/U2mazyijKx4vgFoQmWyvEBOTasw85XB7faTSgBza2mASxcEfaaCFD
 IdG41/LM14OsFC7TOFjuZlBTGDFcfOpBMb6bqECn19yKU7hSHC/4dx8bvE+MupLconQ2pHaBqRJ
 IbQ+sZ+L7Meo3y5xQ+bvrXdQDixZ0G7eAffzdd9lkOuIIrkmgLFQKIWzUImRz+IE923lxmI1hE2
 wg3O38e/G6KLgnXraArzbO6VnX/DxVU9zV96mm3vNiHsNRTbMtjIE6+VUg77M0q90cl+LLJC7bg
 t1ggOiUvHh1TfFlaW8Ju0TzxNulFibvBbyzet7yIVrXpmehCz3kzfLh6y4PfVWi6J/kg6YzfgAF
 yuSv2qXD46+fyicn2eWQgW/pKX6FonnnNEjq/W04pYfgQisdbblj6g6dfjfm3sUX+iMz6XrSvMM
 xyAGNhjR9oIjhU24AVHTSTZa7+5m1WobRgnU5TsuPYWcLC9uPJsZKw7gU12m0Bd81hVmCzTMAZo
 mrSUTxX
X-Received: by 2002:a05:7301:fa6:b0:369:f195:a5ff with SMTP id
 5a478bee46e88-36a4231f8e3mr23107863eec.1.1793608389724; 
 Mon, 02 Nov 2026 00:33:09 -0800 (PST)
X-Received: by 2002:a05:7301:fa6:b0:369:f195:a5ff with SMTP id
 5a478bee46e88-36a4231f8e3mr23107823eec.1.1793608389041; 
 Mon, 02 Nov 2026 00:33:09 -0800 (PST)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42a96172sm32074372eec.27.2026.11.02.00.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 00:33:08 -0800 (PST)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 1/2] hw/riscv: add RPMI support for server reference
 platform
Date: Mon,  2 Nov 2026 14:02:56 +0530
Message-ID: <20261102083257.3405653-2-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102083257.3405653-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20261102083257.3405653-1-subrahmanya.lingappa@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KZ1HIgYD c=1 sm=1 tr=0 ts=6ae84ac7 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=NEAV23lmAAAA:8
 a=NLiCwHATAAAA:8 a=V1jnuoLLAAAA:20 a=EUspDBNiAAAA:8 a=yZPtaupRBgCef42CRQIA:9
 a=bBxd6f-gb0O0v-kibOvt:22 a=F9tHCgz3TLBaZgltkx5D:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzMyBTYWx0ZWRfX8Ocp4KkOFTce
 Np5IQu/Vgdn6dYEckv5IBKOv4lhlUmWSZzjA9bKGLNytaUDQED5t9rl0nxZNp7XTunGrvKN0env
 NMUUvdveWHx9gtYxil+mI8VJgrlQYPIFjvlpiswrTRY/8kuucB6msBbvIcGy+JuPy2zJ7INkN2P
 ZxRtFF4govRrFVOxRohCHy1E43RBkf9X+a9RjPaaHeY0S1+zH56sf8pg+KqhOYioYcLpO/hdjWc
 idybnhcyB90JETJwn6C2jKmSCTYKufjZCS59eFbTBCRFbXTAylxzZO8w9p4Ye3gc+StXKEpJwjw
 74a2H6ZAZe0GjFwdr+jfbY09V04aDkvpPtVYEnn6P8lJC5w3JFyQaj/pzkkHBj5PTPyP97R5/oN
 bsUWLIdz1Zfvei7wpm0CByTYcS5owzFt+Mk13YhAX32iPBeMIX9C5z06l2KcsG51KxbGyJ1Gfzd
 I1He6sAbkBW1bGU9Sww==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzMyBTYWx0ZWRfX2jpJThAaTTu1
 4OsTLsGjz6jnEn/rDZVrw6SPrLtEn6WurWKwbDlza4dy3uV5HlQEkCEtFLwKuO27Y1J7V3Dix6I
 i5j35SsXqAH2qaL/RHFKV84LCsKqxX0=
X-Proofpoint-ORIG-GUID: u5D0dpOceEl2BfNyIeGhtPDhB0v7NgeB
X-Proofpoint-GUID: u5D0dpOceEl2BfNyIeGhtPDhB0v7NgeB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add opt-in RPMI platform management to the riscv-server-ref machine for
firmware clients that use the RPMI transport.

RPMI is disabled by default so the existing board remains migratable and
retains its legacy reset and poweroff device-tree nodes. The rpmi=on option
realizes the unmigratable RPMI device, advertises the Base, System Reset,
HSM, and System Suspend services, and omits those legacy nodes.

Explicit RPMI enablement rejects KVM and builds without librpmi. Document
the property, migration restriction, build requirements, and both
device-tree layouts.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
---
 docs/system/riscv/riscv-server-ref.rst |  43 +++++++
 hw/riscv/Kconfig                       |   1 +
 hw/riscv/server_platform_ref.c         | 149 ++++++++++++++++++++++++-
 meson.build                            |   4 +
 4 files changed, 195 insertions(+), 2 deletions(-)

diff --git a/docs/system/riscv/riscv-server-ref.rst b/docs/system/riscv/riscv-server-ref.rst
index da043ed096..32c3201404 100644
--- a/docs/system/riscv/riscv-server-ref.rst
+++ b/docs/system/riscv/riscv-server-ref.rst
@@ -28,6 +28,7 @@ The main features included in the riscv-server-ref board are:
 * No fw_cfg device
 * No ACPI table
 * Minimal device tree nodes
+* RISC-V RPMI platform management
 
 There are multiple ways of using this reference board.  The spec compliant way
 is using an EDK2 image and a TPM device.  The board was tested with the TPM
@@ -60,6 +61,48 @@ And then start QEMU with:
      -netdev user,id=net0 -device e1000e,netdev=net0 \
      -nographic
 
+RPMI support
+------------
+
+The ``riscv-server-ref`` machine exposes RISC-V RPMI platform management when
+the ``rpmi=on`` machine option is selected and QEMU is built with librpmi
+support.  RPMI is disabled by default.  ``rpmi=off`` preserves the legacy
+device tree and keeps the board migratable.  An RPMI-enabled machine contains
+an unmigratable RPMI device, so live migration is unavailable while
+``rpmi=on`` is selected.  RPMI is unavailable with KVM and requires a build
+with librpmi.
+
+The initial ``riscv-server-ref`` RPMI implementation exposes Base, System
+Reset, HSM, and System Suspend service groups.  System Reset handles guest
+shutdown and cold reboot requests through RPMI.
+HSM uses the machine hart IDs for hart discovery, status, start, stop, and
+suspend commands.  System Suspend uses QEMU's suspend and wakeup path.
+
+When ``rpmi=on`` is selected, the generated device tree advertises reset,
+shutdown, HSM, and suspend through RPMI service nodes and omits the legacy
+syscon reboot and poweroff nodes.  With the default ``rpmi=off`` setting, the
+generated device tree retains the legacy syscon reboot and poweroff nodes.
+RPMI is currently described through FDT only; this machine does not emit ACPI
+tables for the RPMI transport or service groups.
+
+RPMI support targets the RISC-V Platform Management Interface (RPMI)
+Specification v1.0 Ratified (`server-ref RPMI v1.0 specification`_).  The
+build dependency is provided by `server-ref librpmi`_.  After installing
+librpmi, configure QEMU with ``--enable-librpmi`` or ``-Dlibrpmi=enabled`` to
+make the build fail if librpmi is unavailable.
+
+.. code-block:: bash
+
+ qemu-system-riscv64 -M riscv-server-ref,rpmi=on \
+     -bios fw_dynamic.bin \
+     -kernel EDK2.fd \
+     -drive file=nvme_disk.ext2,format=raw,id=hd0,if=none \
+     -device ahci,id=ahci \
+     -device ide-hd,drive=hd0,bus=ahci.0 \
+     -nographic
+
 
 .. _spec: https://github.com/riscv-non-isa/riscv-server-platform
 .. _tpm: https://qemu-project.gitlab.io/qemu/specs/tpm.html
+.. _server-ref RPMI v1.0 specification: https://github.com/riscv-non-isa/riscv-rpmi/releases/download/v1.0/riscv-rpmi.pdf
+.. _server-ref librpmi: https://github.com/riscv-software-src/librpmi
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index dfdbc6dfe1..b5f0346962 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -86,6 +86,7 @@ config RISCV_SERVER_PLATFORM_REF
     select RISCV_IOMMU
     select RISCV_NUMA
     select SERIAL_MM
+    select RISCV_RPMI if LIBRPMI
 
 config SHAKTI_C
     bool
diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_ref.c
index d18550b48d..ea580e475f 100644
--- a/hw/riscv/server_platform_ref.c
+++ b/hw/riscv/server_platform_ref.c
@@ -29,18 +29,20 @@
 #include "hw/riscv/device-common.h"
 #include "hw/riscv/fdt-common.h"
 #include "hw/riscv/numa.h"
+#include "hw/riscv/rpmi-fdt.h"
 #include "hw/riscv/iommu.h"
 #include "hw/riscv/riscv-iommu.h"
 #include "hw/riscv/riscv-iommu-bits.h"
+#include "hw/misc/riscv_rpmi.h"
 #include "hw/intc/riscv_aclint.h"
 #include "hw/intc/riscv_aplic.h"
 #include "hw/intc/riscv_imsic.h"
 #include "chardev/char.h"
 #include "hw/char/serial-mm.h"
 #include "system/device_tree.h"
+#include "system/kvm.h"
 #include "system/runstate.h"
 #include "system/system.h"
-#include "system/kvm.h"
 #include "system/qtest.h"
 #include "system/tcg.h"
 #include "kvm/kvm_riscv.h"
@@ -68,6 +70,9 @@
 
 #define RVSERVER_PLATFORM_BUS_NUM_IRQS         8
 
+#define RVSERVER_RPMI_A2P_REQ_SIZE (16 * RPMI_QUEUE_SLOT_SIZE)
+#define RVSERVER_RPMI_P2A_REQ_SIZE 0
+
 #define TYPE_RISCV_SERVER_REF_MACHINE MACHINE_TYPE_NAME("riscv-server-ref")
 OBJECT_DECLARE_SIMPLE_TYPE(RISCVServerRefMachineState, RISCV_SERVER_REF_MACHINE)
 
@@ -83,6 +88,7 @@ struct RISCVServerRefMachineState {
 
     int fdt_size;
     int aia_guests;
+    bool have_rpmi;
     const MemMapEntry *memmap;
 
     DeviceState *platform_bus_dev;
@@ -93,6 +99,8 @@ enum {
     RVSERVER_RESET_SYSCON,
     RVSERVER_RTC,
     RVSERVER_IOMMU_SYS,
+    RVSERVER_RPMI_SHMEM,
+    RVSERVER_RPMI_DOORBELL,
     RVSERVER_ACLINT,
     RVSERVER_APLIC_M,
     RVSERVER_APLIC_S,
@@ -143,6 +151,8 @@ static const MemMapEntry rvserver_ref_memmap[] = {
     [RVSERVER_RESET_SYSCON] =   {   0x100000,        0x1000 },
     [RVSERVER_RTC] =            {   0x101000,        0x1000 },
     [RVSERVER_IOMMU_SYS] =      {   0x102000,        0x1000 },
+    [RVSERVER_RPMI_SHMEM] =     {   0x110000,       0x20000 },
+    [RVSERVER_RPMI_DOORBELL] =  {   0x140000,        0x1000 },
     [RVSERVER_ACLINT] =         {  0x2000000,       0x10000 },
     [RVSERVER_PCIE_PIO] =       {  0x3000000,       0x10000 },
     [RVSERVER_PLATFORM_BUS] =   {  0x4000000,     0x2000000 },
@@ -283,6 +293,81 @@ static void create_fdt_sockets(RISCVServerRefMachineState *s,
     riscv_socket_fdt_write_distance_matrix(ms);
 }
 
+#ifdef CONFIG_LIBRPMI
+static const RiscvRpmiServiceConfig rvserver_ref_rpmi_services[] = {
+    {
+        .node_name = "sysreset",
+        .compatible = "riscv,rpmi-system-reset",
+        .service_group = RPMI_SRVGRP_SYSTEM_RESET,
+    },
+    {
+        .node_name = "hsm",
+        .compatible = "riscv,rpmi-hsm",
+        .service_group = RPMI_SRVGRP_HSM,
+    },
+    {
+        .node_name = "suspend",
+        .compatible = "riscv,rpmi-system-suspend",
+        .service_group = RPMI_SRVGRP_SYSTEM_SUSPEND,
+    },
+};
+
+static void rvserver_ref_rpmi_system_reset(void)
+{
+    qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+}
+
+static void rvserver_ref_rpmi_system_shutdown(void)
+{
+    qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+}
+
+static const RiscvRpmiMachineOps rvserver_ref_rpmi_machine_ops = {
+    .system_reset = rvserver_ref_rpmi_system_reset,
+    .system_shutdown = rvserver_ref_rpmi_system_shutdown,
+};
+
+static RiscvRpmiConfig rvserver_ref_rpmi_config(
+    RISCVServerRefMachineState *s, const uint32_t *hart_ids,
+    uint32_t hart_count)
+{
+    return (RiscvRpmiConfig) {
+        .doorbell_base = s->memmap[RVSERVER_RPMI_DOORBELL].base,
+        .shmem_base = s->memmap[RVSERVER_RPMI_SHMEM].base,
+        .shmem_size = s->memmap[RVSERVER_RPMI_SHMEM].size,
+        .a2p_req_size = RVSERVER_RPMI_A2P_REQ_SIZE,
+        .p2a_req_size = RVSERVER_RPMI_P2A_REQ_SIZE,
+        .platform_info = "QEMU RISC-V server-ref RPMI",
+        .machine_ops = &rvserver_ref_rpmi_machine_ops,
+        .hart_ids = hart_ids,
+        .hart_count = hart_count,
+        .services = rvserver_ref_rpmi_services,
+        .service_count = ARRAY_SIZE(rvserver_ref_rpmi_services),
+    };
+}
+
+static void create_fdt_rpmi(RISCVServerRefMachineState *s, uint32_t *phandle)
+{
+    uint32_t rpmi_mbox_handle;
+    RiscvRpmiFdtMboxConfig cfg = {
+        .shmem_base = s->memmap[RVSERVER_RPMI_SHMEM].base,
+        .doorbell_base = s->memmap[RVSERVER_RPMI_DOORBELL].base,
+        .a2p_req_size = RVSERVER_RPMI_A2P_REQ_SIZE,
+        .p2a_req_size = RVSERVER_RPMI_P2A_REQ_SIZE,
+        .doorbell_size = s->memmap[RVSERVER_RPMI_DOORBELL].size,
+    };
+
+    riscv_rpmi_fdt_add_mbox(MACHINE(s)->fdt, &cfg, phandle,
+                            &rpmi_mbox_handle);
+
+    for (uint32_t i = 0; i < ARRAY_SIZE(rvserver_ref_rpmi_services); i++) {
+        riscv_rpmi_fdt_add_service_node(MACHINE(s)->fdt,
+                                        &rvserver_ref_rpmi_services[i],
+                                        rpmi_mbox_handle);
+    }
+}
+#endif
+
 static void finalize_fdt(RISCVServerRefMachineState *s)
 {
     uint32_t phandle = 1, irq_mmio_phandle = 1, msi_pcie_phandle = 1;
@@ -307,10 +392,16 @@ static void finalize_fdt(RISCVServerRefMachineState *s)
                           irq_pcie_phandle, msi_pcie_phandle,
                           iommu_sys_phandle, RVSERVER_PCIE_IRQ);
 
+#ifdef CONFIG_LIBRPMI
+    if (s->have_rpmi) {
+        create_fdt_rpmi(s, &phandle);
+    }
+#endif
     riscv_create_fdt_syscon(ms->fdt, &phandle,
                             rvserver_ref_memmap[RVSERVER_RESET_SYSCON].base,
                             rvserver_ref_memmap[RVSERVER_RESET_SYSCON].size,
-                            SYSCON_RESET, SYSCON_POWEROFF, false, true);
+                            SYSCON_RESET, SYSCON_POWEROFF, false,
+                            !s->have_rpmi);
 
     riscv_create_fdt_uart(ms->fdt, &rvserver_ref_memmap[RVSERVER_UART0],
                           RVSERVER_UART0_IRQ, AIA_TYPE_APLIC_IMSIC,
@@ -516,6 +607,17 @@ static void rvserver_ref_machine_init(MachineState *machine)
     }
 
     imsic_bits = imsic_num_bits(s->aia_guests + 1);
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
     mmio_irqchip = pcie_irqchip = NULL;
@@ -598,6 +700,28 @@ static void rvserver_ref_machine_init(MachineState *machine)
                                 memmap[RVSERVER_RESET_SYSCON].base,
                                 reset_syscon_io);
 
+#ifdef CONFIG_LIBRPMI
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
+        rpmi_cfg = rvserver_ref_rpmi_config(s, rpmi_hart_ids,
+                                            machine->smp.cpus);
+        if (!riscv_rpmi_create(&rpmi_cfg, &local_err)) {
+            error_report_err(local_err);
+            exit(1);
+        }
+    }
+#endif
+
     riscv_gpex_pcie_init(system_memory, pcie_irqchip,
                          &rvserver_ref_memmap[RVSERVER_PCIE_ECAM],
                          &rvserver_ref_memmap[RVSERVER_PCIE_MMIO],
@@ -652,6 +776,7 @@ static void rvserver_ref_machine_instance_init(Object *obj)
                                      "pflash1", RVSERVER_FLASH_SECTOR_SIZE);
 
     s->aia_guests = RVSERVER_IRQCHIP_DEFAULT_AIA_GUESTS;
+    s->have_rpmi = false;
 }
 
 static void rvserver_ref_machine_instance_finalize(Object *obj)
@@ -687,6 +812,20 @@ static void rvserver_ref_set_aia_guests(Object *obj, const char *val,
     }
 }
 
+static bool rvserver_ref_get_rpmi(Object *obj, Error **errp)
+{
+    RISCVServerRefMachineState *s = RISCV_SERVER_REF_MACHINE(obj);
+
+    return s->have_rpmi;
+}
+
+static void rvserver_ref_set_rpmi(Object *obj, bool value, Error **errp)
+{
+    RISCVServerRefMachineState *s = RISCV_SERVER_REF_MACHINE(obj);
+
+    s->have_rpmi = value;
+}
+
 static const HotplugHandler *
 rvserver_machine_get_hotplug_handler(MachineState *ms, DeviceState *dev)
 {
@@ -747,6 +886,12 @@ static void rvserver_ref_machine_class_init(ObjectClass *oc, const void *data)
                  "should be between 0 and %d.", RVSERVER_IRQCHIP_MAX_GUESTS);
     object_class_property_set_description(oc, "aia-guests", str);
 
+    object_class_property_add_bool(oc, "rpmi", rvserver_ref_get_rpmi,
+                                   rvserver_ref_set_rpmi);
+    object_class_property_set_description(
+        oc, "rpmi", "Set on/off to enable/disable RISC-V RPMI devices; "
+        "requires librpmi and is unavailable with KVM");
+
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = rvserver_machine_get_hotplug_handler;
     hc->plug = rvserver_machine_device_plug_cb;
diff --git a/meson.build b/meson.build
index 9c4d501687..5b8ea24714 100644
--- a/meson.build
+++ b/meson.build
@@ -3438,6 +3438,10 @@ foreach target : target_dirs
     foreach k, v: config_devices
       config_devices_data.set(k, 1)
     endforeach
+    if target == 'riscv64-softmmu' and get_option('default_devices') and \
+       not librpmi.found()
+      warning('riscv-server-ref machine will be built without RPMI support; install librpmi and configure with --enable-librpmi to enable RPMI')
+    endif
     config_devices_mak_list += config_devices_mak
     config_devices_h += {target: configure_file(output: target + '-config-devices.h',
                                                 configuration: config_devices_data)}

base-commit: a120de19146f9b06fa4cfd0395e742e4cf13e0cc
-- 
2.43.0


