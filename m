Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CF1C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24ws-000437-Bp; Thu, 03 Sep 2026 06:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24wq-0003w3-IJ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:45:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24wo-0007Qt-AS
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:45:36 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AH5lk935074
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:45:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 u2uPEjrhazV94I7bm/tFzqgbgp+DLQTVhbdTjxOavog=; b=SiFH0UzXMpPx0NDf
 c3rCPTkajj8MnPJ6/G0MCE8CmxUhBkOSWjK1K+DDGXvBGJrP2KdFDOoUHDhWKFL+
 5zrE/GePPMzqVDL+3iMEMRq1Wfc/vBVs4nzn8Q9ZkWCntlqd62JLoYeGN3A4uP8F
 qF3hg0UkKxh34zodHMweJaWBRmG1Yrsdwe19uA+Fa+I/OzEgjbLw/wtT0BcSn8Ex
 JApH/XG/9qTrQQ2gFspqlIzIENopZwmtq+1wGrrVqnZKaygQLl2qEg0yQdPRechK
 tRbU5voAoI0FmbxNoSXQMxfdFo1k36MG67noWnYs9O9umxK8RjnD3fJB2UBobJt5
 Ce6uwQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gerdnbvpx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:45:32 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93917f4ccb4so306989585a.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432332; x=1789037132; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u2uPEjrhazV94I7bm/tFzqgbgp+DLQTVhbdTjxOavog=;
 b=RCXJe3nnsekHknqFKuBZIXs5wBQSt//juNW+TWxcPnoHRJJ2gNoyj4jCgWBvkERrqe
 wdElgX60Nes/76lrVuMABk+zU+Rf110XbN75ap3zBI88fq5Waw25qb8yO++YEne/3qEo
 TqBcZFwu70tzKKKktxdJC/EL+S+rfcaCjUmvpceCSc48gCp567+LpdMDjPkZqPwDRuxW
 riDN09ud3LBcScRg50jpcmOAAnxfebJ0ajs6mA/uSH3Hn2mVzXySEIX8hEH/yATc12Ae
 FclhClXg978GsrH3E/fj4/iN7iHrNtquXcaILn+6tdS4OXdcWAgwYDf2rq0tPTyjghkr
 GWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432332; x=1789037132;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u2uPEjrhazV94I7bm/tFzqgbgp+DLQTVhbdTjxOavog=;
 b=GkagLrSEHN17Qtu38a5Ix5nn+KeuYKY34p8NyQAOlaV5j36UGlD+DiNG51Zx7fp7dT
 Q+g/70B3zMjGUtcPCropB0SjAlMg27ybQqfOhn5APzwfVfr5mrIeSYq52RObzI7xmvVi
 BcsFhQz13WS2DgxMGyGzXXFVNNgVNvtKiJeqYRcqc1zNI3GpXmdb5FTEb9HZuGqB5Acp
 zGZKG1Lc+3Bw5hzFyE86ui63/bZ5Gkb/gOTJiL0yGsvJwv8DpsiZrHOL8COrQS4pgUEB
 2mB4F2rnLnndDnwaDnxY5hfMvRB0IcbcM2hHj4j4Fo4FRLZg5/apCM37rsw0Kuq2v4EK
 ogow==
X-Gm-Message-State: AFuF++mX2b9Mt5JNFUBVtrpZaZHtdu/JK3f2exjkGZ5SeLD6Lmr+IKPn
 zymtf9qoEBo52YxloP3zKyO0nDTlyMCdCqthtD4O2Ccxv2Pk6yAnO8Um+Or0qZI2VmW4NweXc3u
 iXnv/UgNC9YZn/Rkx8pl7qOBzlTWt8csFHaiyzb7ggAx+4X/QEh0CsRrQ8U2AL7N33g==
X-Gm-Gg: AYBFou2+TCh4lWOx4STr+eNajw2LXlL5T2eNajMTBMRZrb3aal3mg5PJq5CvjU1kdAU
 eZ/YV2zqyGAmc9lPHikMuDTvKG3yDeCxnPcA+I8hRE1vbk3N8oVD9gZZu5xswUn6r/Q6WErjaBc
 IlxIHyu8NQSziAiHYN4p2R0IS2QOVekZUFbnQiipVf5jrffsCJ6IADaFSfXTSVen0ICCf0T1CZ2
 Omtrr1/AAGkziHItnK8pM0atxjZ2xIvPA0PyRom5V64Zzolc6Ruvn9xFNnaslif/UXK3LpjY9SM
 X1UZoUTIvvZqlHsdLUf2MhBwb4G2mc3xpgTSPNi6U8VSLGlP7WIUibcX5B9Hdr2eghmSNGcsZXX
 XDh9aF1NMeFNinx/LJA+6uDXQPrZ8aNXieUCiYUoV
X-Received: by 2002:a05:620a:70dc:b0:939:4890:98e1 with SMTP id
 af79cd13be357-93961022e70mr1091869385a.42.1788432331736; 
 Thu, 03 Sep 2026 03:45:31 -0700 (PDT)
X-Received: by 2002:a05:620a:70dc:b0:939:4890:98e1 with SMTP id
 af79cd13be357-93961022e70mr1091866085a.42.1788432331223; 
 Thu, 03 Sep 2026 03:45:31 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce5936a5esm51782465e9.3.2026.09.03.03.45.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:45:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 47/51] hw/riscv: remove machines-qom.h
Date: Thu,  3 Sep 2026 12:39:31 +0200
Message-ID: <20260903103936.62355-48-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YcmNIQRf c=1 sm=1 tr=0 ts=6a994fcc cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=KzGqfiNxp7Nhv_o5qEAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX1S0MCat88PCe
 wDT3qrOzOMA5kcTdytd53uDpEAuRaZe970Mr4TZtFnfA7XBGktsVLyFRs3zHYltWGWXEWRdTrcq
 Y7g3KdPcefC+uoAXyaU5tXq8IpcmQyw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfXxdcwK4BblxT4
 0WDzzhWhg+mz2Rc1iaxz672ZcIAWiGGZxrEC2Z4QlESIWousOb+zSLT1ssPh4JPAv+xH+TX257/
 qGPnIAs8ciYCxz4RviwP3zwKXu76a8mBPrYe6n7qTiIZRJMtYAHjSnk0ote4/KhrUWwJjTPbjqU
 mrpiGR6t+AoteXN5tVLSgpGBeU/jmqnYEr3mKJj1lQ7QZdCdKVYCZIhm9Z0u33Usm857G3t9Qtx
 dgmDgMFo+i+Bz/VxMY3VJYiRt+wv2I0xHrG/V6SnDPihUBqz/c3yONmDD2OIBKGTSIS2TBOnyfR
 nkTU89ngzC0lskt1mLWO5Pu1Wuo7RF1TWlCYN1AcP6GQdDaYhh5V2rXVV+lVv9y0QlwtAx4diu1
 FNxSuuEXtkEYV1If+0Y+TsCSZXs+nDXRi06WRFwGK6VeAU85PDHGfMmP3xQsO3N9p8/3FA9MwL6
 eHnB9lXZezfgeXdxvhg==
X-Proofpoint-GUID: USxi_l_dyfArS444lLUgmWJja_sS9WMO
X-Proofpoint-ORIG-GUID: USxi_l_dyfArS444lLUgmWJja_sS9WMO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030092
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260901202043.26532-15-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/riscv/machines-qom.h   | 14 --------------
 configs/targets/riscv32-softmmu.c |  1 -
 configs/targets/riscv64-softmmu.c |  1 -
 hw/core/null-machine.c            |  1 -
 hw/riscv/boston-aia.c             |  1 -
 hw/riscv/k230.c                   |  1 -
 hw/riscv/microblaze-v-generic.c   |  1 -
 hw/riscv/microchip_pfsoc.c        |  1 -
 hw/riscv/opentitan.c              |  1 -
 hw/riscv/shakti_c.c               |  1 -
 hw/riscv/sifive_e.c               |  1 -
 hw/riscv/sifive_u.c               |  1 -
 hw/riscv/spike.c                  |  1 -
 hw/riscv/tt_atlantis.c            |  1 -
 hw/riscv/virt.c                   |  1 -
 hw/riscv/xiangshan_kmh.c          |  1 -
 target-info-qom.c                 |  1 -
 target/riscv/machine.c            |  1 -
 18 files changed, 31 deletions(-)
 delete mode 100644 include/hw/riscv/machines-qom.h

diff --git a/include/hw/riscv/machines-qom.h b/include/hw/riscv/machines-qom.h
deleted file mode 100644
index 79d212eeb7d..00000000000
--- a/include/hw/riscv/machines-qom.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- * QOM type definitions for riscv32 / riscv64 machines
- *
- *  Copyright (c) rev.ng Labs Srl.
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#ifndef HW_RISCV_MACHINES_QOM_H
-#define HW_RISCV_MACHINES_QOM_H
-
-#include "hw/core/boards.h"
-
-#endif
diff --git a/configs/targets/riscv32-softmmu.c b/configs/targets/riscv32-softmmu.c
index c1d94679c7e..0829ab84de5 100644
--- a/configs/targets/riscv32-softmmu.c
+++ b/configs/targets/riscv32-softmmu.c
@@ -9,7 +9,6 @@
 #include "qemu/osdep.h"
 #include "qemu/target-info-impl.h"
 #include "qemu/target-info-init.h"
-#include "hw/riscv/machines-qom.h"
 #include "target/riscv/cpu-qom.h"
 #include "target/riscv/cpu-param.h"
 
diff --git a/configs/targets/riscv64-softmmu.c b/configs/targets/riscv64-softmmu.c
index f648a5c8944..553bd1f75fe 100644
--- a/configs/targets/riscv64-softmmu.c
+++ b/configs/targets/riscv64-softmmu.c
@@ -9,7 +9,6 @@
 #include "qemu/osdep.h"
 #include "qemu/target-info-impl.h"
 #include "qemu/target-info-init.h"
-#include "hw/riscv/machines-qom.h"
 #include "target/riscv/cpu-qom.h"
 #include "target/riscv/cpu-param.h"
 
diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index 2f008c4a702..60254913019 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -16,7 +16,6 @@
 #include "hw/core/boards.h"
 #include "system/address-spaces.h"
 #include "hw/core/cpu.h"
-#include "hw/riscv/machines-qom.h"
 
 static void machine_none_init(MachineState *mch)
 {
diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
index 30eff10bc5f..b90da096ea8 100644
--- a/hw/riscv/boston-aia.c
+++ b/hw/riscv/boston-aia.c
@@ -18,7 +18,6 @@
 #include "hw/ide/ahci-pci.h"
 #include "hw/core/loader.h"
 #include "hw/riscv/cps.h"
-#include "hw/riscv/machines-qom.h"
 #include "hw/pci-host/xilinx-pcie.h"
 #include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 72d50d369a9..34905bb1702 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -26,7 +26,6 @@
 #include "hw/core/sysbus.h"
 #include "hw/riscv/k230.h"
 #include "hw/riscv/boot.h"
-#include "hw/riscv/machines-qom.h"
 #include "hw/intc/riscv_aclint.h"
 #include "hw/intc/sifive_plic.h"
 #include "hw/char/serial-mm.h"
diff --git a/hw/riscv/microblaze-v-generic.c b/hw/riscv/microblaze-v-generic.c
index 503e8e08992..b0494b1ac50 100644
--- a/hw/riscv/microblaze-v-generic.c
+++ b/hw/riscv/microblaze-v-generic.c
@@ -25,7 +25,6 @@
 #include "system/address-spaces.h"
 #include "hw/char/xilinx_uartlite.h"
 #include "hw/misc/unimp.h"
-#include "hw/riscv/machines-qom.h"
 
 #define LMB_BRAM_SIZE (128 * KiB)
 #define MEMORY_BASEADDR 0x80000000
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 42d4fc39734..60bb96da016 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -49,7 +49,6 @@
 #include "hw/misc/unimp.h"
 #include "hw/riscv/boot.h"
 #include "hw/riscv/riscv_hart.h"
-#include "hw/riscv/machines-qom.h"
 #include "hw/riscv/microchip_pfsoc.h"
 #include "hw/intc/riscv_aclint.h"
 #include "hw/intc/sifive_plic.h"
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index c58d8993303..8cd660dd415 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -26,7 +26,6 @@
 #include "hw/core/boards.h"
 #include "hw/misc/unimp.h"
 #include "hw/riscv/boot.h"
-#include "hw/riscv/machines-qom.h"
 #include "qemu/units.h"
 #include "system/system.h"
 #include "system/address-spaces.h"
diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
index 9fd7856dc24..a205a213324 100644
--- a/hw/riscv/shakti_c.c
+++ b/hw/riscv/shakti_c.c
@@ -19,7 +19,6 @@
 #include "qemu/osdep.h"
 #include "hw/core/boards.h"
 #include "hw/riscv/shakti_c.h"
-#include "hw/riscv/machines-qom.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/intc/sifive_plic.h"
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index ede7cb52f00..1acfea49668 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -40,7 +40,6 @@
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/sifive_e.h"
 #include "hw/riscv/boot.h"
-#include "hw/riscv/machines-qom.h"
 #include "hw/char/sifive_uart.h"
 #include "hw/intc/riscv_aclint.h"
 #include "hw/intc/sifive_plic.h"
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 08687cfc363..997ee91aa0e 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -51,7 +51,6 @@
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/sifive_u.h"
 #include "hw/riscv/boot.h"
-#include "hw/riscv/machines-qom.h"
 #include "hw/riscv/fdt-common.h"
 #include "hw/char/sifive_uart.h"
 #include "hw/intc/riscv_aclint.h"
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 3786de4b0b7..e36fe996b09 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -34,7 +34,6 @@
 #include "hw/riscv/boot.h"
 #include "hw/riscv/fdt-common.h"
 #include "hw/riscv/numa.h"
-#include "hw/riscv/machines-qom.h"
 #include "hw/char/riscv_htif.h"
 #include "hw/intc/riscv_aclint.h"
 #include "chardev/char.h"
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 5e155726abf..7d02868b222 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -20,7 +20,6 @@
 
 #include "hw/riscv/boot.h"
 #include "hw/riscv/fdt-common.h"
-#include "hw/riscv/machines-qom.h"
 #include "hw/riscv/riscv_hart.h"
 
 #include "hw/char/serial-mm.h"
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d2ae321a376..dd396410178 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -36,7 +36,6 @@
 #include "hw/riscv/virt.h"
 #include "hw/riscv/boot.h"
 #include "hw/riscv/fdt-common.h"
-#include "hw/riscv/machines-qom.h"
 #include "hw/riscv/numa.h"
 #include "kvm/kvm_riscv.h"
 #include "hw/firmware/smbios.h"
diff --git a/hw/riscv/xiangshan_kmh.c b/hw/riscv/xiangshan_kmh.c
index e02624b62b4..247a0b5d1f2 100644
--- a/hw/riscv/xiangshan_kmh.c
+++ b/hw/riscv/xiangshan_kmh.c
@@ -41,7 +41,6 @@
 #include "hw/riscv/boot.h"
 #include "hw/riscv/xiangshan_kmh.h"
 #include "hw/riscv/riscv_hart.h"
-#include "hw/riscv/machines-qom.h"
 #include "system/system.h"
 
 static const MemMapEntry xiangshan_kmh_memmap[] = {
diff --git a/target-info-qom.c b/target-info-qom.c
index f98d3d7698e..6965e4d1169 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -12,7 +12,6 @@
 #include "qemu/target-info-impl.h"
 #include "qemu/target-info-init.h"
 #include "qemu/target-info-qom.h"
-#include "hw/riscv/machines-qom.h"
 
 static void target_info_qom_class_init(ObjectClass *oc, const void * data)
 {
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 22a918cec95..c3f5a255099 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -24,7 +24,6 @@
 #include "migration/cpu.h"
 #include "exec/icount.h"
 #include "target/riscv/tcg/debug.h"
-#include "hw/riscv/machines-qom.h"
 #ifdef CONFIG_KVM
 #include "kvm/kvm_riscv.h"
 #endif
-- 
2.53.0


