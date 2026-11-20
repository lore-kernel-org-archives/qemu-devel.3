Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B5660A2605
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 17:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GbFnm2s4;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WFSOM11Z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUSC7-0004P7-Be; Fri, 20 Nov 2026 12:14:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUSAw-00034E-B4
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:13:30 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUSAu-0003sD-8V
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:13:26 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKEfGI42039946
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 17:13:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uB5/bMacb5OjTMQkWD+5M2U9BZH4TIH3WwZFjcJ3OIk=; b=GbFnm2s4Fc4Dl/N+
 PJt9+7UNypXkwOFu9kdeQPdt3awX5vJ20OoAAEgj07+IT06NM9MKDf7TaW/FnunD
 mVi1G7bDUH0U/LyqYMKKPvKVb3JejqV74kx2PtQOf1M3+BTrjkps6f0dndDuBGxO
 94hS1uec16NbMoW0fSZxFwPNT0QLHspNTn5/JDAlH4d8Wyt0SyTclWuQ02GfhNfP
 +FuT4794xw0gKo7auxezaVc9koxt+lJEMiELT62gsd3LX0A9zsGvNNvyCEnIkoW4
 jQn0sXIndE3TmI2h0WeEnahaMbBIezYeoqtoxzOMoWf2bH9p25EHwyPauFGSSGEI
 f/IlVA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2fjttxw3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 17:13:22 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93909014c85so234415885a.0
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 09:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795194802; x=1795799602; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uB5/bMacb5OjTMQkWD+5M2U9BZH4TIH3WwZFjcJ3OIk=;
 b=WFSOM11ZSXDsPABVFjv1wDp0qSr8r1JdR/S/A3vj38pPI4SAaSn9SUAIzvYZS8xyz/
 9cR6li0Cyfk5uHd+7qJyhWGsNmOxiVzqi+hxIFZ8oU6F5jBMmgJXHIAOcm8GGnQR3CX6
 AzZ7Xj6vAeEsjMeLtmdkW7w1XUCt7s9xAuUWroG8rjWtx0MXXSzx41idYd4z/lc02y6f
 zrTqZNYUyH3/r/vvR3lYOcbidKO8peOs3C/sfcgH9U9yHTJY/9+ST74xEKUGQL7eJHYR
 zd3qI3TLjzlkZzFoNbMZg2V9vMGB8mikSJXLkj8exLg3EWvhrnBJ1hM5snUnANwRngvb
 N5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795194802; x=1795799602;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uB5/bMacb5OjTMQkWD+5M2U9BZH4TIH3WwZFjcJ3OIk=;
 b=DdxRhiZRm5umtxtTY7cA00U0EEjHdEOa9mZui8QHyAGDbWMO33W4tURVkPri9DY0xa
 2m13gaM8rYMLwxKlNzz945naZ4huuXpPPKgqKeeVe5r66TOo83CfTbNlViU0pXI+829l
 Phyuz7MyUL8Kx4eCjSaXspZ6k8ub0UiAP9gpZaEZwp9Wqgvqk4F8nmr2B62sjzcXffDk
 lKn4zmGe/nc4AkNP/XCNoGWqHWxyxl3vUOg7ul583Tqf2kAh98MKT/ZXpdOVJPBwcMIc
 nYOWW2p05f562gLhpKbumePAqpgnZg2g2hoLoT3DugPm2pXUV/tnC5d99RVECIBsj2pJ
 xK0A==
X-Gm-Message-State: APuU4Z96qVMeMRFEORQ9O5vI+fMsxlTOe17KagkUxybjk3VaUY28sPXb
 ngLmwY8jxGQGhUig4/EaHI/9UtCTdjOG4S+Hfj5qjJanfj5NqizKH6nSXsCYKUPM/P+mCtaLxdF
 i7BDyU7BXyWr9Oc7GwjrbnY7ocSBtpAy+arSSAf7e8//6fvjAGEum9H+3n5VqNlOaPQ==
X-Gm-Gg: AYBFou2fi7SI9gV+yv/LwjZ2QDyJeULsL6DOXOxPiQzmJhJ8P1+o0t3clSaIJxO3do2
 xsuSZtsYQozpFu/3HbWAKfYguZ5pJB0VJPOxtWV8Pst69Ck6GRw8LWXU9jQM4z3bgiGYrEH57zi
 E6GfRPRPcV3CepJMZR/0quOj1dfX4OqXpQIvKfAomMoIqE/0o3dUl3d0nopk3AR65UlgOfC6z6r
 sG8SFXMGW+GUpnlT84lH4yTgg7RHfssjteexJtHmmWjJuy3kDv1jwqKVcp5p4kaA5k7+bC7fXsJ
 ZBenMRc24NjD3sjGzvdf3EAUM0dDDCZoSjDEAW4dHL1v0BHvcYrU7eNuTH0m5UPHW1brag8h13b
 c6BTGBMoGyyaY5FcgJ2YuGmGdUke5aP7FfQJKryplthTp4WI38i3ITTMNJ9nwH5yBrDc1tmDwPX
 o4QDTW2VN1bg26lA==
X-Received: by 2002:a05:620a:28c8:b0:949:7acc:1695 with SMTP id
 af79cd13be357-949ba6c5900mr578759385a.0.1795194801463; 
 Fri, 20 Nov 2026 09:13:21 -0800 (PST)
X-Received: by 2002:a05:620a:28c8:b0:949:7acc:1695 with SMTP id
 af79cd13be357-949ba6c5900mr578750585a.0.1795194800636; 
 Fri, 20 Nov 2026 09:13:20 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a3a3dsm90318495e9.10.2026.11.20.09.13.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Nov 2026 09:13:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fam Zheng <fam@euphon.net>, Keith Monahan <keith@techtravels.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [RFC PATCH-for-11.2? v4 06/14] hw/scsi: Move shared LSI/NCR
 definitions to lsi_scsi.h
Date: Fri, 20 Nov 2026 18:12:26 +0100
Message-ID: <20261120171235.61325-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120171235.61325-1-philmd@oss.qualcomm.com>
References: <20261120171235.61325-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: uvNR_E4zKmdPkj3J9klCALazTwIA0y2l
X-Proofpoint-GUID: uvNR_E4zKmdPkj3J9klCALazTwIA0y2l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA2OCBTYWx0ZWRfXzRKJ9npTCETj
 ATs4tlzKjalft/wSkccqEXUZXwWAkD+JPSPl1k93WnqQEbCaBBQMx5S7oebozN51aijyfP0yC/t
 NpqrjiFtONOwe8qrWZRn32Y6HXq2hcCAaUJOF6lz5RuHLTWzOKT2Y93wMzjCWNEzNvlhqxx3aMj
 bOgKomgZlYx2kYU5NcKqe3XqFmYOtq79UYtTE0yO+jOg42b3As3PqjqliXu4lXn9e9e2bN4V81d
 zJP9VTIUCRM1acVnq2+18aIFRK2MBurlqMysG4AVJObshZqvmCcuC+3ScvUGA5OkiDgvWervZZo
 4cxaBawWSni8773IyFNNpx80AVixe5txbg0JVdy2rxZzi8sA7r0tPT9BHYDYJ9XyFS6tnzHMKQB
 baOYwIC2lg0tbg8w3+I4Cs489oejmvf1piiORZxmMH8B7kambH3szbLgA/hmYPNfuT+15KTWMTb
 A7ZhefRTWesVdO8Lsow==
X-Authority-Analysis: v=2.4 cv=XcccX455 c=1 sm=1 tr=0 ts=6b007fb2 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=zCys0jnkAAAA:8 a=EUspDBNiAAAA:8 a=vlC4I3SjAAAA:8 a=7q4XBQtiWicnC9o1hGEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=AAPjE2N9MkmuCaafd2wf:22 a=MGyrNx-tFZ9jfgWML-M_:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA2OCBTYWx0ZWRfX772Vdd0Yzpz/
 3tdmcF67xQCY3zsFOH2uVeaZdglvHYoi3KY+48pEAoInXLFYqwGC5/jVrVhipiyv9tZ0IrZhTkb
 fFBOAnasISp0MZpcPjmz6UTCeEiXVL0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200068
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Keith Monahan <keith@techtravels.org>

Move common defines and structures of the lsi53c895a driver to
lsi_scsi.h so that the 53c710 driver can share them.

Pure code movement, no functional change: nothing is renamed and the
lsi53c895a device is unchanged.

Licence: the moved code comes from lsi53c895a.c, which is licensed under
the LGPL (Copyright (c) 2006 CodeSourcery, written by Paul Brook), so
the new header keeps that licence (SPDX LGPL-2.1-or-later) rather than
the preferred GPL-2.0-or-later; it is not relicensed.

Suggested-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Keith Monahan <keith@techtravels.org>
Signed-off-by: Helge Deller <deller@gmx.de>
AI-used-for: Patch series decomposition (commit splitting and ordering)
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 MAINTAINERS          |   1 +
 hw/scsi/lsi_scsi.h   | 104 +++++++++++++++++++++++++++++++++++++++++++
 hw/scsi/lsi53c895a.c |  79 +-------------------------------
 3 files changed, 106 insertions(+), 78 deletions(-)
 create mode 100644 hw/scsi/lsi_scsi.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a9b4d34a0fc..752519a7f82f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2431,6 +2431,7 @@ R: Fam Zheng <fam@euphon.net>
 S: Supported
 F: include/hw/scsi/*
 F: hw/scsi/*
+F: hw/scsi/lsi_scsi.h
 F: tests/qtest/virtio-scsi-test.c
 F: tests/qtest/fuzz-virtio-scsi-test.c
 F: tests/qtest/am53c974-test.c
diff --git a/hw/scsi/lsi_scsi.h b/hw/scsi/lsi_scsi.h
new file mode 100644
index 000000000000..de0941dd23a7
--- /dev/null
+++ b/hw/scsi/lsi_scsi.h
@@ -0,0 +1,104 @@
+/*
+ * QEMU LSI53C895A SCSI Host Bus Adapter emulation
+ * Definitions shared with other NCR/LSI SCRIPTS based controllers
+ *
+ * Copyright (c) 2006 CodeSourcery.
+ * Written by Paul Brook
+ *
+ * This code is licensed under the LGPL.
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifndef HW_SCSI_LSI_SCSI_H
+#define HW_SCSI_LSI_SCSI_H
+
+#include "qemu/queue.h"
+#include "hw/scsi/scsi.h"
+
+#define LSI_SCNTL0_TRG    0x01
+#define LSI_SCNTL0_AAP    0x02
+#define LSI_SCNTL0_EPC    0x08
+#define LSI_SCNTL0_WATN   0x10
+#define LSI_SCNTL0_START  0x20
+
+#define LSI_SCNTL1_AESP   0x04
+#define LSI_SCNTL1_RST    0x08
+#define LSI_SCNTL1_CON    0x10
+#define LSI_SCNTL1_ADB    0x40
+#define LSI_SCNTL1_EXC    0x80
+
+#define LSI_ISTAT0_DIP    0x01
+#define LSI_ISTAT0_SIP    0x02
+#define LSI_ISTAT0_CON    0x08
+#define LSI_ISTAT0_SIGP   0x20
+#define LSI_ISTAT0_SRST   0x40
+#define LSI_ISTAT0_ABRT   0x80
+
+#define LSI_SOCL_ATN      0x08
+
+#define LSI_DSTAT_IID     0x01
+#define LSI_DSTAT_SIR     0x04
+#define LSI_DSTAT_SSI     0x08
+#define LSI_DSTAT_ABRT    0x10
+#define LSI_DSTAT_BF      0x20
+#define LSI_DSTAT_DFE     0x80
+
+#define LSI_DCNTL_COM     0x01
+#define LSI_DCNTL_STD     0x04
+#define LSI_DCNTL_SSM     0x10
+
+#define LSI_DMODE_MAN     0x01
+
+#define LSI_CTEST2_DACK   0x01
+#define LSI_CTEST2_SIGP   0x40
+
+#define LSI_SBCL_ATN         0x08
+#define LSI_SBCL_BSY         0x20
+#define LSI_SBCL_ACK         0x40
+#define LSI_SBCL_REQ         0x80
+
+#define PHASE_DO          0
+#define PHASE_DI          1
+#define PHASE_CMD         2
+#define PHASE_ST          3
+#define PHASE_MO          6
+#define PHASE_MI          7
+#define PHASE_MASK        7
+
+/* Maximum length of MSG IN data.  */
+#define LSI_MAX_MSGIN_LEN 8
+
+/* Flag set if this is a tagged command.  */
+#define LSI_TAG_VALID     (1 << 16)
+
+/* Maximum instructions to process. */
+#define LSI_MAX_INSN    500
+
+typedef struct lsi_request {
+    SCSIRequest *req;
+    uint32_t tag;
+    uint32_t dma_len;
+    uint8_t *dma_buf;
+    uint32_t pending;
+    int out;
+    bool orphan;
+    QTAILQ_ENTRY(lsi_request) next;
+} lsi_request;
+
+enum {
+    LSI_NOWAIT, /* SCRIPTS are running or stopped */
+    LSI_WAIT_RESELECT, /* Wait Reselect instruction has been issued */
+    LSI_DMA_SCRIPTS, /* processing DMA from lsi_execute_script */
+    LSI_DMA_IN_PROGRESS, /* DMA operation is in progress */
+    LSI_WAIT_SCRIPTS, /* SCRIPTS stopped because of instruction count limit */
+};
+
+enum {
+    LSI_MSG_ACTION_COMMAND = 0,
+    LSI_MSG_ACTION_DISCONNECT = 1,
+    LSI_MSG_ACTION_DOUT = 2,
+    LSI_MSG_ACTION_DIN = 3,
+};
+
+#endif
diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 1b7f02fc7c91..2a7c6e9c8dc9 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -18,6 +18,7 @@
 #include "hw/core/irq.h"
 #include "hw/pci/pci_device.h"
 #include "hw/scsi/scsi.h"
+#include "lsi_scsi.h"
 #include "migration/vmstate.h"
 #include "system/dma.h"
 #include "qemu/log.h"
@@ -42,20 +43,9 @@ static const char *names[] = {
 
 #define LSI_MAX_DEVS 7
 
-#define LSI_SCNTL0_TRG    0x01
-#define LSI_SCNTL0_AAP    0x02
-#define LSI_SCNTL0_EPC    0x08
-#define LSI_SCNTL0_WATN   0x10
-#define LSI_SCNTL0_START  0x20
-
 #define LSI_SCNTL1_SST    0x01
 #define LSI_SCNTL1_IARB   0x02
-#define LSI_SCNTL1_AESP   0x04
-#define LSI_SCNTL1_RST    0x08
-#define LSI_SCNTL1_CON    0x10
 #define LSI_SCNTL1_DHP    0x20
-#define LSI_SCNTL1_ADB    0x40
-#define LSI_SCNTL1_EXC    0x80
 
 #define LSI_SCNTL2_WSR    0x01
 #define LSI_SCNTL2_VUE0   0x02
@@ -66,14 +56,8 @@ static const char *names[] = {
 #define LSI_SCNTL2_CHM    0x40
 #define LSI_SCNTL2_SDU    0x80
 
-#define LSI_ISTAT0_DIP    0x01
-#define LSI_ISTAT0_SIP    0x02
 #define LSI_ISTAT0_INTF   0x04
-#define LSI_ISTAT0_CON    0x08
 #define LSI_ISTAT0_SEM    0x10
-#define LSI_ISTAT0_SIGP   0x20
-#define LSI_ISTAT0_SRST   0x40
-#define LSI_ISTAT0_ABRT   0x80
 
 #define LSI_ISTAT1_SI     0x01
 #define LSI_ISTAT1_SRUN   0x02
@@ -105,43 +89,30 @@ static const char *names[] = {
 #define LSI_SOCL_IO       0x01
 #define LSI_SOCL_CD       0x02
 #define LSI_SOCL_MSG      0x04
-#define LSI_SOCL_ATN      0x08
 #define LSI_SOCL_SEL      0x10
 #define LSI_SOCL_BSY      0x20
 #define LSI_SOCL_ACK      0x40
 #define LSI_SOCL_REQ      0x80
 
-#define LSI_DSTAT_IID     0x01
-#define LSI_DSTAT_SIR     0x04
-#define LSI_DSTAT_SSI     0x08
-#define LSI_DSTAT_ABRT    0x10
-#define LSI_DSTAT_BF      0x20
 #define LSI_DSTAT_MDPE    0x40
-#define LSI_DSTAT_DFE     0x80
 
-#define LSI_DCNTL_COM     0x01
 #define LSI_DCNTL_IRQD    0x02
-#define LSI_DCNTL_STD     0x04
 #define LSI_DCNTL_IRQM    0x08
-#define LSI_DCNTL_SSM     0x10
 #define LSI_DCNTL_PFEN    0x20
 #define LSI_DCNTL_PFF     0x40
 #define LSI_DCNTL_CLSE    0x80
 
-#define LSI_DMODE_MAN     0x01
 #define LSI_DMODE_BOF     0x02
 #define LSI_DMODE_ERMP    0x04
 #define LSI_DMODE_ERL     0x08
 #define LSI_DMODE_DIOM    0x10
 #define LSI_DMODE_SIOM    0x20
 
-#define LSI_CTEST2_DACK   0x01
 #define LSI_CTEST2_DREQ   0x02
 #define LSI_CTEST2_TEOP   0x04
 #define LSI_CTEST2_PCICIE 0x08
 #define LSI_CTEST2_CM     0x10
 #define LSI_CTEST2_CIO    0x20
-#define LSI_CTEST2_SIGP   0x40
 #define LSI_CTEST2_DDIR   0x80
 
 #define LSI_CTEST5_BL2    0x04
@@ -163,59 +134,11 @@ static const char *names[] = {
 #define LSI_CCNTL1_DDAC      0x08
 #define LSI_CCNTL1_ZMOD      0x80
 
-#define LSI_SBCL_ATN         0x08
-#define LSI_SBCL_BSY         0x20
-#define LSI_SBCL_ACK         0x40
-#define LSI_SBCL_REQ         0x80
-
 /* Enable Response to Reselection */
 #define LSI_SCID_RRE      0x60
 
 #define LSI_CCNTL1_40BIT (LSI_CCNTL1_EN64TIBMV|LSI_CCNTL1_64TIMOD)
 
-#define PHASE_DO          0
-#define PHASE_DI          1
-#define PHASE_CMD         2
-#define PHASE_ST          3
-#define PHASE_MO          6
-#define PHASE_MI          7
-#define PHASE_MASK        7
-
-/* Maximum length of MSG IN data.  */
-#define LSI_MAX_MSGIN_LEN 8
-
-/* Flag set if this is a tagged command.  */
-#define LSI_TAG_VALID     (1 << 16)
-
-/* Maximum instructions to process. */
-#define LSI_MAX_INSN    500
-
-typedef struct lsi_request {
-    SCSIRequest *req;
-    uint32_t tag;
-    uint32_t dma_len;
-    uint8_t *dma_buf;
-    uint32_t pending;
-    int out;
-    bool orphan;
-    QTAILQ_ENTRY(lsi_request) next;
-} lsi_request;
-
-enum {
-    LSI_NOWAIT, /* SCRIPTS are running or stopped */
-    LSI_WAIT_RESELECT, /* Wait Reselect instruction has been issued */
-    LSI_DMA_SCRIPTS, /* processing DMA from lsi_execute_script */
-    LSI_DMA_IN_PROGRESS, /* DMA operation is in progress */
-    LSI_WAIT_SCRIPTS, /* SCRIPTS stopped because of instruction count limit */
-};
-
-enum {
-    LSI_MSG_ACTION_COMMAND = 0,
-    LSI_MSG_ACTION_DISCONNECT = 1,
-    LSI_MSG_ACTION_DOUT = 2,
-    LSI_MSG_ACTION_DIN = 3,
-};
-
 struct LSIState {
     /*< private >*/
     PCIDevice parent_obj;
-- 
2.55.0


