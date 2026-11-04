Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FF4606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 05:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VSaie74b;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=juhB06hZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOTDC-0005pJ-P8; Wed, 04 Nov 2026 00:07:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xOTD3-0005T6-NX
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 00:06:54 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xOTCv-0002Ey-PV
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 00:06:50 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A40RFQa1248584
 for <qemu-devel@nongnu.org>; Wed, 4 Nov 2026 05:06:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=EXE9Tm7D9EM
 HmyZuVKtxKJ9b4ApRm+QuTNL4BU9W/Nk=; b=VSaie74bflQrGp1uKzIFy/kWmdt
 s3f36mua8F3tIEzOzLuE0VKP4yKSsipSFDsPVcBSoq4xgkhxWVrQ7a0h5U91SQ2F
 /wn9LX6xo+MHEX2FnK+eYOBEzy6pvsNOMAuMe2OpymNY7IqESxu1DXhzULiwVfZx
 KUbMpqPx386eShg9/98xHRk/cnaegWjAZ/GpF3CwItJ8d3+/hh3XXA9Nd0f2cM33
 rXCUxfY5FicPCYbIsxRuoQ8c+CMbPfij1hmOsUpHg3r/9P3ry+IoptFa7PMJ41a0
 fLyaRvtmxsgzp1l1tu9HQ/xVFwjvbny9ej5l2qdUeRM4tmQq6KucuRHiTpA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqpuv9kxx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 05:06:34 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-313c7315becso40038eec.2
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 21:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793768794; x=1794373594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EXE9Tm7D9EMHmyZuVKtxKJ9b4ApRm+QuTNL4BU9W/Nk=;
 b=juhB06hZEgWT4N05wiZ+Da/STY/LRM208LAppY4ryMdGNAwZSI2CXA2fs1yMIhfsEj
 +rN2Cb9S/OpdK+T95vMlxCALr3oT9ZRAdkccj7RaW1KpR/NuaUQGzKDKSbNTZcYmLNa0
 ZgI9wzBwSD2ImoCbAhbBQ/pAfWgJkaFlX+gbc8b1NmPCPJ30lq6YHCwRNusr6kGUkaoS
 tFmgaMMZq4EM5aQ8CRFmkbj/AkbD4fo+u1MbMgSCGfcEdIm9pHwIgbM25nF+7+dOaH+O
 rLhrGqjFXTSkTULjOv3SMfUv/k9L7VvhLJZNf9VYrmcvRFskW0UfYkJu3cmeVNkaFjBP
 f9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793768794; x=1794373594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EXE9Tm7D9EMHmyZuVKtxKJ9b4ApRm+QuTNL4BU9W/Nk=;
 b=t6DfwD1hT6F3kPA/6HoIDSS9FZMAhFZ0N/reux+CAwizl0CuWlKx+uGAw0p13e5rkX
 xvoiaNKrJl5gUznaegFYdB8HlwHGSkvw9qt/yb6dSLdQxa5wpObM3N8wxIPvEijfNO+3
 gkGOG4smAByUFxjD5s/PU0bcVzWhOS6Fy7NDC+V2RIw4BssCptcuey1VSXnn0+V5mpih
 ONPQSopsjbfdknHr1cuuk2Eina2FDnrhtyVMyqbpG/uCYnlURVS7rCwat4gG4HIRzOJl
 apfxnTMxfg4gcm681RyEBwqDWGR2j5VUAFE+f0HNAvdBSvkXRijwEsES8rb2QYhJL9SL
 787Q==
X-Gm-Message-State: APuU4Z/7cbIaa7T1Uc8KiOK0F8Xgnwfriif+e4hVbMhdFZtg9fonz7s8
 hhKA39JxkpyjJUM1Js5aPd1jiIYy++CtPNX7X4eoKoWcE1WdgfyhwlzHQvSJgV08ifshStZdp3x
 gxy2wujTpkdRju4B1I9OxFNVNya7DpnH6UVS5CFhvxnA4n1zRNtgc4hsdIzsarNZLbA==
X-Gm-Gg: AYBFou0JF+vOAK3B1fqVriUp+7b4H0+1MUKCkyWPjDLZ1DYQWMwuyp5/MTuazQvuxWF
 D5XrkgjJFY2Dt8jYSqH3lyrZDdXumFWU5ylFZXWPI7IiaRMYfM/LJFZoFEe/tUdBetbuKphoGme
 HFPo9WDHZ98K6e4K3zHdVekjZJ1aRYzkDIUdEecK+HHEfCJgFk7nGY5HQviCitZlkOhQ9MZgfaQ
 OFR87++Ca8PvMR+N3anFGhU482RF574FvIxmebGbl4xeCRpPEw1NESPAJc441MKXZfu8LxuI16F
 H7onZLz/BOgEJ+0sFnbDtHT/r6OOjbLueQgEMG9/DWPba6kBqoKfR5E41JaZqtmWsZDNgrSAcss
 zleJhX9EAEnGb/fuwedkBHvJT6XbUQXHs+Z4jyS4RiS3dyxZ5tM0e+aVcC2UVggK9TbfX6ZxY63
 sqz2ch0j62ey8w5YwO/faDgJ5mUsK0krMQQmXtMErFtTs6j2+S1fPzxN1Luh5f6lwu7Vth1fDVn
 arDihRu
X-Received: by 2002:a05:7300:fb14:b0:351:7883:bf47 with SMTP id
 5a478bee46e88-36a41daec1emr31162541eec.0.1793768792814; 
 Tue, 03 Nov 2026 21:06:32 -0800 (PST)
X-Received: by 2002:a05:7300:fb14:b0:351:7883:bf47 with SMTP id
 5a478bee46e88-36a41daec1emr31162457eec.0.1793768791809; 
 Tue, 03 Nov 2026 21:06:31 -0800 (PST)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca390df28sm3925036eec.18.2026.11.03.21.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 21:06:31 -0800 (PST)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH v14 09/10] tests/qtest: cover initial RISC-V RPMI services
Date: Wed,  4 Nov 2026 10:33:22 +0530
Message-ID: <20261104050324.733555-10-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104050324.733555-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20261104050324.733555-1-subrahmanya.lingappa@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=O6SsLx9W c=1 sm=1 tr=0 ts=6aeabd5a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=tDkw8OHjEmLI60v_eaAA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: HxRMuNBasBicxGBi_nxvjic_BA8ALbmq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAyMCBTYWx0ZWRfX5JtW9ghEPdWK
 XMD9r7yUrVJla1yiF2FmWBmSrAbFguh4EKweuyjhDYFgJG0H15LnK/MZ5jo5XPYbyhLyichxzlT
 1/IygmyPNd1b3QXWZ86duTl02jsTiNk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAyMCBTYWx0ZWRfX5ulY2HK9+7Hc
 zYGnOdc2X31GLY3UBQX3rLSymci315wF3JYbwN/MwpXbai6XWEPScn3lPviteifJ1gERJrVx3oR
 DcET8Y0rdZQwUbwaj9PEPsf/Cqmb1nY2qb7BbAQRHsR/m6zfDZ74NO9XHlEUaH6cZJCttsFTdbJ
 HSUrQZNR+1O56W9FLuRqkd7SEbpVin5Dc2pqoZDjrSI1CHiPRWs0kcFRfH2MzabdN6pBnzWskdD
 wvVsOVqkFKqUsz9lWSiwyYil5CrZeYIW11OcUvP5NOvD5WuEWhmdnU0xldOkqfxzyyEYr2oBRxy
 BFFkvd0CjoVDtjUyUDdhbS6rIRCjONw8UdQy2XFEB4sKbJM6TsFMEAF3XKLDvFXRro1b4fOflKJ
 sOAX7XMpfdCbl5l84gHo4KVwrFks6pB84l8GNKO97C+Y9KiNKoskzdXhfSTirRR66382i04Yh57
 3F+VW5oQ39gxh5hWuGA==
X-Proofpoint-GUID: HxRMuNBasBicxGBi_nxvjic_BA8ALbmq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040020
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Add qtests for the RPMI transport plus Base, system reset, HSM, and
system suspend service groups.

The qtest accelerator does not execute a target hart to WFI, so check
that stop and suspend remain pending rather than treating the request as
immediately complete. Verify that HART_START is denied while stop is
pending and that machine reset returns pending HSM state to STARTED before
accepting fresh stop and suspend requests.

Check System Suspend resume-address rejection without a suspend event or
runstate change. Cover instruction alignment with and without compressed
instructions, MMIO and unmapped addresses, RAM-backed addresses, RV32 width
rejection for mapped RAM above 4 GiB, and recovery after rejection/reset.

Check the enlarged virt queue ranges in the DT and exercise
queue-boundary rejection and wraparound at the last data slot.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
---
 MAINTAINERS                   |   1 +
 tests/qtest/meson.build       |   3 +
 tests/qtest/riscv-rpmi-test.c | 759 ++++++++++++++++++++++++++++++++++
 3 files changed, 763 insertions(+)
 create mode 100644 tests/qtest/riscv-rpmi-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f7764b03b..5e56f4eec5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -381,6 +381,7 @@ F: hw/riscv/
 F: hw/intc/riscv*
 F: hw/misc/riscv_rpmi*
 F: include/hw/misc/riscv_rpmi.h
+F: tests/qtest/riscv-rpmi-test.c
 F: include/hw/char/riscv_htif.h
 F: include/hw/riscv/
 F: common-user/host/riscv*
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index ff4bf9528a..207766bcf6 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -317,6 +317,8 @@ qtests_riscv32 = \
 
 qtests_riscv64 = ['riscv-csr-test'] + \
   (unpack_edk2_blobs ? ['bios-tables-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_RISCV_RPMI') ?
+   ['riscv-rpmi-test'] : []) + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
    ['iommu-riscv-test'] : []) + \
@@ -442,6 +444,7 @@ qtests = {
   'pnv-xive2-test': files('pnv-xive2-common.c', 'pnv-xive2-flush-sync.c',
                           'pnv-xive2-nvpg_bar.c'),
   'qos-test': [chardev, io, qos_test_ss.apply({}).sources()],
+  'riscv-rpmi-test': [files('riscv-rpmi-test.c'), fdt],
   'tpm-crb-swtpm-test': [io, tpmemu_files],
   'tpm-crb-test': [io, tpmemu_files],
   'tpm-tis-swtpm-test': [io, tpmemu_files, 'tpm-tis-util.c'],
diff --git a/tests/qtest/riscv-rpmi-test.c b/tests/qtest/riscv-rpmi-test.c
new file mode 100644
index 0000000000..318c66b426
--- /dev/null
+++ b/tests/qtest/riscv-rpmi-test.c
@@ -0,0 +1,759 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * QTests for RISC-V RPMI devices.
+ *
+ * Copyright (c) 2026 Qualcomm Technologies, Inc.
+ * Author:
+ *  Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
+ */
+
+#include "qemu/osdep.h"
+#include <glib/gstdio.h>
+#include <libfdt.h>
+#include "libqtest.h"
+#include "qobject/qdict.h"
+
+#define RPMI_SHMEM_BASE 0x10200000ULL
+#define RPMI_DOORBELL_BASE 0x10230000ULL
+#define RPMI_SLOT_SIZE 64
+#define RPMI_QUEUE_SIZE 0x7800
+#define RPMI_QUEUE_DATA_SLOTS (RPMI_QUEUE_SIZE / RPMI_SLOT_SIZE - 2)
+
+#define RPMI_A2P_HEAD RPMI_SHMEM_BASE
+#define RPMI_A2P_TAIL (RPMI_SHMEM_BASE + RPMI_SLOT_SIZE)
+#define RPMI_A2P_SLOT0 (RPMI_SHMEM_BASE + 2 * RPMI_SLOT_SIZE)
+
+#define RPMI_SRVGRP_BASE 0x0001
+#define RPMI_SRVGRP_SYSTEM_RESET 0x0003
+#define RPMI_SRVGRP_SYSTEM_SUSPEND 0x0004
+#define RPMI_SRVGRP_HSM 0x0005
+#define RPMI_BASE_SRV_GET_PLATFORM_INFO 0x05
+#define RPMI_BASE_SRV_PROBE_SERVICE_GROUP 0x06
+#define RPMI_SYSRST_SRV_GET_ATTRIBUTES 0x02
+#define RPMI_SYSRST_SRV_SYSTEM_RESET 0x03
+#define RPMI_HSM_SRV_GET_HART_STATUS 0x02
+#define RPMI_HSM_SRV_GET_HART_LIST 0x03
+#define RPMI_HSM_SRV_GET_SUSPEND_TYPES 0x04
+#define RPMI_HSM_SRV_GET_SUSPEND_INFO 0x05
+#define RPMI_HSM_SRV_HART_START 0x06
+#define RPMI_HSM_SRV_HART_STOP 0x07
+#define RPMI_HSM_SRV_HART_SUSPEND 0x08
+#define RPMI_SYSSUSP_SRV_GET_ATTRIBUTES 0x02
+#define RPMI_SYSSUSP_SRV_SYSTEM_SUSPEND 0x03
+#define RPMI_MSG_NORMAL_REQUEST 0x00
+#define RPMI_MSG_POSTED_REQUEST 0x01
+#define RPMI_MSG_ACKNOWLEDGEMENT 0x02
+#define RPMI_SYSRST_TYPE_SHUTDOWN 0x00
+#define RPMI_SYSRST_TYPE_COLD_REBOOT 0x01
+#define RPMI_SYSRST_TYPE_INVALID 0x03
+#define RPMI_SYSRST_ATTRS_FLAGS_RESETTYPE 1
+#define RPMI_TOKEN 0x55aa
+#define RPMI_ERR_NOTSUPP 0xfffffffeU
+#define RPMI_ERR_INVALID_PARAM 0xfffffffdU
+#define RPMI_ERR_INVALID_ADDR 0xfffffffbU
+#define RPMI_ERR_DENIED 0xfffffffcU
+#define RPMI_HSM_HART_STATE_STARTED 0x00
+#define RPMI_HSM_HART_STATE_STOPPED 0x01
+#define RPMI_HSM_HART_STATE_STOP_PENDING 0x03
+#define RPMI_HSM_HART_STATE_SUSPENDED 0x04
+#define RPMI_HSM_HART_STATE_SUSPEND_PENDING 0x05
+#define RPMI_HSM_TEST_START_ADDR 0x80000000ULL
+#define RPMI_HSM_TEST_RESUME_ADDR 0x80001000ULL
+
+#define RPMI_P2A_ACK_BASE (RPMI_SHMEM_BASE + RPMI_QUEUE_SIZE)
+#define RPMI_P2A_ACK_HEAD RPMI_P2A_ACK_BASE
+#define RPMI_P2A_ACK_TAIL (RPMI_P2A_ACK_BASE + RPMI_SLOT_SIZE)
+
+static uint64_t rpmi_response_base;
+
+static uint64_t rpmi_queue_slot(uint64_t queue_base, uint32_t index)
+{
+    return queue_base + (index + 2) * RPMI_SLOT_SIZE;
+}
+
+static void rpmi_send_request(QTestState *qts, uint16_t service_group,
+                              uint8_t service_id, uint8_t request_type,
+                              const uint32_t *data, size_t data_words)
+{
+    uint32_t tail = qtest_readl(qts, RPMI_A2P_TAIL);
+    uint64_t slot = rpmi_queue_slot(RPMI_SHMEM_BASE, tail);
+    size_t i;
+
+    qtest_writew(qts, slot, service_group);
+    qtest_writeb(qts, slot + 2, service_id);
+    qtest_writeb(qts, slot + 3, request_type);
+    qtest_writew(qts, slot + 4, data_words * sizeof(*data));
+    qtest_writew(qts, slot + 6, RPMI_TOKEN);
+
+    for (i = 0; i < data_words; i++) {
+        qtest_writel(qts, slot + 8 + i * sizeof(*data), data[i]);
+    }
+
+    g_test_message(
+        "RPMI_A2P_REQ shmem=0x%016" PRIx64 " doorbell=0x%016" PRIx64
+        " group=0x%04x service=0x%02x type=0x%02x data_len=%zu"
+        " token=0x%04x a2p_tail=%u slot=0x%016" PRIx64,
+        (uint64_t)RPMI_SHMEM_BASE, (uint64_t)RPMI_DOORBELL_BASE,
+        service_group, service_id, request_type, data_words * sizeof(*data),
+        RPMI_TOKEN, tail, slot);
+
+    qtest_writel(qts, RPMI_A2P_TAIL, (tail + 1) % RPMI_QUEUE_DATA_SLOTS);
+    qtest_writel(qts, RPMI_DOORBELL_BASE, 1);
+}
+
+static uint32_t rpmi_response_word(QTestState *qts, unsigned int word)
+{
+    return qtest_readl(qts, rpmi_response_base + 8 + word * sizeof(uint32_t));
+}
+
+static void test_rpmi_virt_fdt_service_nodes(void)
+{
+    static const struct {
+        const char *name;
+        uint32_t service_group;
+    } services[] = {
+        { "sysreset", RPMI_SRVGRP_SYSTEM_RESET },
+        { "hsm", RPMI_SRVGRP_HSM },
+        { "suspend", RPMI_SRVGRP_SYSTEM_SUSPEND },
+    };
+    g_autofree char *dtb_path = NULL;
+    g_autofree char *dtb = NULL;
+    gsize dtb_size;
+    const fdt32_t *prop;
+    int mailbox_offset;
+    int phandle_len;
+    uint32_t mailbox_phandle;
+    QTestState *qts;
+
+    dtb_path = g_strdup_printf("%s/riscv-rpmi-fdt-%u.dtb",
+                               g_get_tmp_dir(), (unsigned)getpid());
+    qts = qtest_init("-machine virt,rpmi=on -display none -S");
+    qtest_qmp_assert_success(qts,
+                             "{ 'execute': 'dumpdtb', 'arguments': "
+                             "{ 'filename': %s } }", dtb_path);
+    qtest_quit(qts);
+
+    g_assert_true(g_file_get_contents(dtb_path, &dtb, &dtb_size, NULL));
+    g_assert_cmpint(fdt_check_header(dtb), ==, 0);
+
+    mailbox_offset = fdt_path_offset(dtb, "/soc/mailbox@10200000");
+    g_assert_cmpint(mailbox_offset, >=, 0);
+    prop = fdt_getprop(dtb, mailbox_offset, "reg", &phandle_len);
+    g_assert_nonnull(prop);
+    g_assert_cmpint(phandle_len, >=, 8 * sizeof(*prop));
+    for (unsigned int queue = 0; queue < 2; queue++) {
+        g_assert_cmphex(fdt32_to_cpu(prop[4 * queue + 1]), ==,
+                        RPMI_SHMEM_BASE + queue * RPMI_QUEUE_SIZE);
+        g_assert_cmphex(fdt32_to_cpu(prop[4 * queue + 3]), ==, RPMI_QUEUE_SIZE);
+    }
+    prop = fdt_getprop(dtb, mailbox_offset, "phandle", &phandle_len);
+    g_assert_nonnull(prop);
+    g_assert_cmpint(phandle_len, ==, sizeof(*prop));
+    mailbox_phandle = fdt32_to_cpu(*prop);
+
+    for (size_t i = 0; i < ARRAY_SIZE(services); i++) {
+        g_autofree char *service_path =
+            g_strdup_printf("/soc/%s", services[i].name);
+        int service_offset = fdt_path_offset(dtb, service_path);
+        int child_offset = fdt_subnode_offset(dtb, mailbox_offset,
+                                              services[i].name);
+        int mboxes_len;
+
+        g_assert_cmpint(service_offset, >=, 0);
+        g_assert_cmpint(child_offset, ==, -FDT_ERR_NOTFOUND);
+        prop = fdt_getprop(dtb, service_offset, "mboxes", &mboxes_len);
+        g_assert_nonnull(prop);
+        g_assert_cmpint(mboxes_len, ==, 2 * sizeof(*prop));
+        g_assert_cmphex(fdt32_to_cpu(prop[0]), ==, mailbox_phandle);
+        g_assert_cmphex(fdt32_to_cpu(prop[1]), ==,
+                        services[i].service_group);
+    }
+
+    g_assert_cmpint(g_remove(dtb_path), ==, 0);
+}
+
+static void rpmi_expect_ack(QTestState *qts, uint16_t service_group,
+                            uint8_t service_id, uint16_t data_len)
+{
+    uint32_t head = qtest_readl(qts, RPMI_P2A_ACK_HEAD);
+    uint32_t tail = qtest_readl(qts, RPMI_P2A_ACK_TAIL);
+
+    g_assert_cmphex(tail, !=, head);
+    rpmi_response_base = rpmi_queue_slot(RPMI_P2A_ACK_BASE, head);
+    g_assert_cmphex(qtest_readw(qts, rpmi_response_base), ==, service_group);
+    g_assert_cmphex(qtest_readb(qts, rpmi_response_base + 2), ==,
+                    service_id);
+    g_assert_cmphex(qtest_readb(qts, rpmi_response_base + 3), ==,
+                    RPMI_MSG_ACKNOWLEDGEMENT);
+    g_assert_cmphex(qtest_readw(qts, rpmi_response_base + 4), ==, data_len);
+    g_assert_cmphex(qtest_readw(qts, rpmi_response_base + 6), ==,
+                    RPMI_TOKEN);
+    g_test_message(
+        "RPMI_P2A_ACK shmem=0x%016" PRIx64
+        " group=0x%04x service=0x%02x type=0x%02x data_len=%u"
+        " token=0x%04x p2a_head=%u slot=0x%016" PRIx64
+        " status=0x%08x",
+        (uint64_t)RPMI_SHMEM_BASE, service_group, service_id,
+        RPMI_MSG_ACKNOWLEDGEMENT, data_len, RPMI_TOKEN, head,
+        rpmi_response_base,
+        data_len >= sizeof(uint32_t) ? rpmi_response_word(qts, 0) : 0);
+    qtest_writel(qts, RPMI_P2A_ACK_HEAD, (head + 1) % RPMI_QUEUE_DATA_SLOTS);
+}
+
+static void rpmi_send_sysreset(QTestState *qts, uint32_t reset_type,
+                               uint8_t request_type)
+{
+    rpmi_send_request(qts, RPMI_SRVGRP_SYSTEM_RESET,
+                      RPMI_SYSRST_SRV_SYSTEM_RESET, request_type,
+                      &reset_type, 1);
+}
+
+static void rpmi_expect_qemu_failure(const char *extra_args,
+                                     const char *stderr_needle)
+{
+    g_autoptr(GError) error = NULL;
+    g_auto(GStrv) split_args = NULL;
+    g_autoptr(GPtrArray) argv = g_ptr_array_new();
+    g_autofree char *stderr_data = NULL;
+    gint wait_status;
+    gboolean spawned;
+
+    g_assert_true(g_shell_parse_argv(extra_args, NULL, &split_args, &error));
+    g_assert_no_error(error);
+
+    g_ptr_array_add(argv, (gpointer)qtest_qemu_binary(NULL));
+    for (char **arg = split_args; *arg; arg++) {
+        g_ptr_array_add(argv, *arg);
+    }
+    g_ptr_array_add(argv, NULL);
+
+    spawned = g_spawn_sync(NULL, (char **)argv->pdata, NULL,
+                           G_SPAWN_STDOUT_TO_DEV_NULL,
+                           NULL, NULL, NULL, &stderr_data,
+                           &wait_status, &error);
+    g_assert_true(spawned);
+    g_assert_no_error(error);
+    g_assert_true(!WIFEXITED(wait_status) ||
+                  WEXITSTATUS(wait_status) != EXIT_SUCCESS);
+    g_assert_nonnull(stderr_data);
+    g_assert_nonnull(strstr(stderr_data, stderr_needle));
+}
+
+static void test_rpmi_machine_realize_off(void)
+{
+    QTestState *qts;
+
+    qts = qtest_init("-machine virt,rpmi=off");
+    qtest_quit(qts);
+}
+
+static void test_rpmi_machine_rejects_too_many_harts(void)
+{
+    rpmi_expect_qemu_failure(
+        "-machine virt,rpmi=on -smp 513 -display none -S",
+        "max CPUs supported by machine 'virt' is 512");
+}
+
+static void test_rpmi_base_platform_info(void)
+{
+    static const char expected[] = "QEMU RISC-V virt RPMI";
+    QTestState *qts;
+    size_t i;
+
+    qts = qtest_init("-machine virt,rpmi=on");
+    rpmi_send_request(qts, RPMI_SRVGRP_BASE,
+                      RPMI_BASE_SRV_GET_PLATFORM_INFO,
+                      RPMI_MSG_NORMAL_REQUEST, NULL, 0);
+
+    rpmi_expect_ack(qts, RPMI_SRVGRP_BASE,
+                    RPMI_BASE_SRV_GET_PLATFORM_INFO,
+                    2 * sizeof(uint32_t) + sizeof(expected));
+    g_assert_cmphex(rpmi_response_word(qts, 0), ==, 0);
+    g_assert_cmphex(rpmi_response_word(qts, 1), ==, sizeof(expected));
+    for (i = 0; i < sizeof(expected); i++) {
+        g_assert_cmphex(qtest_readb(qts, rpmi_response_base + 16 + i), ==,
+                        expected[i]);
+    }
+
+    qtest_quit(qts);
+}
+
+static void rpmi_probe_group(QTestState *qts, uint32_t service_group,
+                             bool present)
+{
+    rpmi_send_request(qts, RPMI_SRVGRP_BASE,
+                      RPMI_BASE_SRV_PROBE_SERVICE_GROUP,
+                      RPMI_MSG_NORMAL_REQUEST, &service_group, 1);
+
+    rpmi_expect_ack(qts, RPMI_SRVGRP_BASE,
+                    RPMI_BASE_SRV_PROBE_SERVICE_GROUP,
+                    2 * sizeof(uint32_t));
+    g_assert_cmphex(rpmi_response_word(qts, 0), ==, 0);
+    if (present) {
+        g_assert_cmphex(rpmi_response_word(qts, 1), !=, 0);
+    } else {
+        g_assert_cmphex(rpmi_response_word(qts, 1), ==, 0);
+    }
+}
+
+static void test_rpmi_base_probe_service_groups(void)
+{
+    QTestState *qts;
+
+    qts = qtest_init("-machine virt,rpmi=on,aia=aplic-imsic");
+    rpmi_probe_group(qts, RPMI_SRVGRP_BASE, true);
+    qtest_system_reset(qts);
+    rpmi_probe_group(qts, RPMI_SRVGRP_SYSTEM_RESET, true);
+    qtest_system_reset(qts);
+    rpmi_probe_group(qts, RPMI_SRVGRP_HSM, true);
+    qtest_system_reset(qts);
+    rpmi_probe_group(qts, RPMI_SRVGRP_SYSTEM_SUSPEND, true);
+
+    qtest_quit(qts);
+}
+
+static void test_rpmi_sysreset_attrs(void)
+{
+    static const struct {
+        uint32_t reset_type;
+        uint32_t expected_attrs;
+    } cases[] = {
+        { RPMI_SYSRST_TYPE_SHUTDOWN, RPMI_SYSRST_ATTRS_FLAGS_RESETTYPE },
+        { RPMI_SYSRST_TYPE_COLD_REBOOT, RPMI_SYSRST_ATTRS_FLAGS_RESETTYPE },
+        { RPMI_SYSRST_TYPE_INVALID, 0 },
+    };
+    QTestState *qts;
+
+    qts = qtest_init("-machine virt,rpmi=on");
+    for (size_t i = 0; i < ARRAY_SIZE(cases); i++) {
+        if (i) {
+            qtest_system_reset(qts);
+        }
+        rpmi_send_request(qts, RPMI_SRVGRP_SYSTEM_RESET,
+                          RPMI_SYSRST_SRV_GET_ATTRIBUTES,
+                          RPMI_MSG_NORMAL_REQUEST, &cases[i].reset_type, 1);
+        rpmi_expect_ack(qts, RPMI_SRVGRP_SYSTEM_RESET,
+                        RPMI_SYSRST_SRV_GET_ATTRIBUTES,
+                        2 * sizeof(uint32_t));
+        g_assert_cmphex(rpmi_response_word(qts, 0), ==, 0);
+        g_assert_cmphex(rpmi_response_word(qts, 1), ==,
+                        cases[i].expected_attrs);
+    }
+
+    qtest_quit(qts);
+}
+
+static void test_rpmi_sysreset_shutdown(void)
+{
+    QTestState *qts;
+
+    qts = qtest_init("-machine virt,rpmi=on");
+    rpmi_send_sysreset(qts, RPMI_SYSRST_TYPE_SHUTDOWN,
+                       RPMI_MSG_POSTED_REQUEST);
+    qtest_qmp_eventwait(qts, "SHUTDOWN");
+    qtest_quit(qts);
+}
+
+static void test_rpmi_sysreset_cold_reboot(void)
+{
+    QTestState *qts;
+
+    qts = qtest_init("-machine virt,rpmi=on -no-reboot");
+    rpmi_send_sysreset(qts, RPMI_SYSRST_TYPE_COLD_REBOOT,
+                       RPMI_MSG_POSTED_REQUEST);
+    qtest_qmp_eventwait(qts, "SHUTDOWN");
+    qtest_quit(qts);
+}
+
+static void test_rpmi_sysreset_invalid_type(void)
+{
+    QTestState *qts;
+
+    qts = qtest_init("-machine virt,rpmi=on");
+    rpmi_send_sysreset(qts, RPMI_SYSRST_TYPE_INVALID,
+                       RPMI_MSG_NORMAL_REQUEST);
+
+    rpmi_expect_ack(qts, RPMI_SRVGRP_SYSTEM_RESET,
+                    RPMI_SYSRST_SRV_SYSTEM_RESET, sizeof(uint32_t));
+    g_assert_cmphex(rpmi_response_word(qts, 0), ==,
+                    RPMI_ERR_INVALID_PARAM);
+
+    qtest_quit(qts);
+}
+
+static void test_rpmi_repeated_reset_after_traffic(void)
+{
+    QTestState *qts;
+    uint32_t reset_type = RPMI_SYSRST_TYPE_SHUTDOWN;
+
+    qts = qtest_init("-machine virt,rpmi=on,aia=aplic-imsic");
+    for (uint32_t i = 0; i < 5; i++) {
+        rpmi_send_request(qts, RPMI_SRVGRP_SYSTEM_RESET,
+                          RPMI_SYSRST_SRV_GET_ATTRIBUTES,
+                          RPMI_MSG_NORMAL_REQUEST,
+                          &reset_type, 1);
+        rpmi_expect_ack(qts, RPMI_SRVGRP_SYSTEM_RESET,
+                        RPMI_SYSRST_SRV_GET_ATTRIBUTES,
+                        2 * sizeof(uint32_t));
+        g_assert_cmphex(rpmi_response_word(qts, 0), ==, 0);
+        qtest_system_reset(qts);
+    }
+    qtest_quit(qts);
+}
+
+static void test_rpmi_reset_clears_transport(void)
+{
+    QTestState *qts;
+
+    qts = qtest_init("-machine virt,rpmi=on");
+    rpmi_send_sysreset(qts, RPMI_SYSRST_TYPE_INVALID,
+                       RPMI_MSG_NORMAL_REQUEST);
+    rpmi_expect_ack(qts, RPMI_SRVGRP_SYSTEM_RESET,
+                    RPMI_SYSRST_SRV_SYSTEM_RESET, sizeof(uint32_t));
+
+    qtest_system_reset(qts);
+
+    g_assert_cmphex(qtest_readl(qts, RPMI_A2P_TAIL), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, RPMI_P2A_ACK_TAIL), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, RPMI_DOORBELL_BASE), ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_rpmi_doorbell_invalid_access(void)
+{
+    QTestState *qts;
+
+    qts = qtest_init("-machine virt,rpmi=on");
+    qtest_writeb(qts, RPMI_DOORBELL_BASE, 1);
+    qtest_writel(qts, RPMI_DOORBELL_BASE + 4, 1);
+    g_assert_cmphex(qtest_readl(qts, RPMI_DOORBELL_BASE), ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_rpmi_queue_bounds(void)
+{
+    QTestState *qts;
+
+    qts = qtest_init("-machine virt,rpmi=on");
+    qtest_writel(qts, RPMI_A2P_TAIL, RPMI_QUEUE_DATA_SLOTS);
+    qtest_writel(qts, RPMI_DOORBELL_BASE, 1);
+    g_assert_cmphex(qtest_readl(qts, RPMI_A2P_HEAD), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, RPMI_P2A_ACK_TAIL), ==, 0);
+
+    qtest_system_reset(qts);
+    qtest_writel(qts, RPMI_A2P_HEAD, RPMI_QUEUE_DATA_SLOTS - 1);
+    qtest_writel(qts, RPMI_A2P_TAIL, RPMI_QUEUE_DATA_SLOTS - 1);
+    qtest_writel(qts, RPMI_P2A_ACK_HEAD, RPMI_QUEUE_DATA_SLOTS - 1);
+    qtest_writel(qts, RPMI_P2A_ACK_TAIL, RPMI_QUEUE_DATA_SLOTS - 1);
+    rpmi_probe_group(qts, RPMI_SRVGRP_BASE, true);
+    g_assert_cmphex(qtest_readl(qts, RPMI_A2P_HEAD), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, RPMI_A2P_TAIL), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, RPMI_P2A_ACK_HEAD), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, RPMI_P2A_ACK_TAIL), ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_rpmi_migration_blocked(void)
+{
+    QTestState *qts;
+    QDict *error;
+    const char *desc;
+
+    qts = qtest_init("-machine virt,rpmi=on -S");
+    error = qtest_qmp_assert_failure_ref(qts,
+        "{ 'execute': 'migrate',"
+        "  'arguments': { 'uri': 'exec:cat > /dev/null' } }");
+    desc = qdict_get_try_str(error, "desc");
+
+    g_assert_nonnull(desc);
+    g_assert_nonnull(strstr(desc, "non-migratable device"));
+    g_assert_nonnull(strstr(desc, "riscv-rpmi"));
+
+    qobject_unref(error);
+    qtest_quit(qts);
+}
+
+static void rpmi_expect_hsm_hart_list(QTestState *qts)
+{
+    uint32_t start_index = 0;
+
+    rpmi_send_request(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_GET_HART_LIST,
+                      RPMI_MSG_NORMAL_REQUEST, &start_index, 1);
+
+    rpmi_expect_ack(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_GET_HART_LIST,
+                    7 * sizeof(uint32_t));
+    g_assert_cmphex(rpmi_response_word(qts, 0), ==, 0);
+    g_assert_cmphex(rpmi_response_word(qts, 1), ==, 0);
+    g_assert_cmphex(rpmi_response_word(qts, 2), ==, 4);
+    g_assert_cmphex(rpmi_response_word(qts, 3), ==, 0);
+    g_assert_cmphex(rpmi_response_word(qts, 4), ==, 1);
+    g_assert_cmphex(rpmi_response_word(qts, 5), ==, 2);
+    g_assert_cmphex(rpmi_response_word(qts, 6), ==, 3);
+}
+
+static void test_rpmi_hsm_hart_list(void)
+{
+    QTestState *qts;
+
+    qts = qtest_init("-machine virt,rpmi=on -smp 4");
+    rpmi_expect_hsm_hart_list(qts);
+
+    qtest_quit(qts);
+}
+
+static void test_rpmi_hsm_multi_socket_hart_list(void)
+{
+    QTestState *qts;
+
+    qts = qtest_init("-machine virt,rpmi=on "
+                     "-smp 4,sockets=2,cores=2,threads=1");
+    rpmi_expect_hsm_hart_list(qts);
+
+    qtest_quit(qts);
+}
+
+static void test_rpmi_hsm_hart_status(void)
+{
+    QTestState *qts;
+    uint32_t hart_id = 3;
+
+    qts = qtest_init("-machine virt,rpmi=on -smp 4");
+    rpmi_send_request(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_GET_HART_STATUS,
+                      RPMI_MSG_NORMAL_REQUEST, &hart_id, 1);
+
+    rpmi_expect_ack(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_GET_HART_STATUS,
+                    2 * sizeof(uint32_t));
+    g_assert_cmphex(rpmi_response_word(qts, 0), ==, 0);
+    g_assert_cmphex(rpmi_response_word(qts, 1), ==,
+                    RPMI_HSM_HART_STATE_STARTED);
+
+    qtest_quit(qts);
+}
+
+static void rpmi_expect_hsm_status(QTestState *qts, uint32_t hart_id,
+                                   uint32_t expected_state)
+{
+    rpmi_send_request(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_GET_HART_STATUS,
+                      RPMI_MSG_NORMAL_REQUEST, &hart_id, 1);
+    rpmi_expect_ack(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_GET_HART_STATUS,
+                    2 * sizeof(uint32_t));
+    g_assert_cmphex(rpmi_response_word(qts, 0), ==, 0);
+    g_assert_cmphex(rpmi_response_word(qts, 1), ==, expected_state);
+}
+
+static void test_rpmi_hsm_hart_control(void)
+{
+    QTestState *qts;
+    uint32_t hart_id = 1;
+    uint32_t stop_request[] = { hart_id };
+    uint32_t start_request[] = { hart_id, RPMI_HSM_TEST_START_ADDR, 0 };
+    uint32_t suspend_request[] = { hart_id, 0, RPMI_HSM_TEST_RESUME_ADDR, 0 };
+    uint32_t start_index = 0;
+    uint32_t suspend_type = 0;
+
+    qts = qtest_init("-machine virt,rpmi=on -smp 2");
+    rpmi_send_request(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_GET_SUSPEND_TYPES,
+                      RPMI_MSG_NORMAL_REQUEST, &start_index, 1);
+    rpmi_expect_ack(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_GET_SUSPEND_TYPES,
+                    4 * sizeof(uint32_t));
+    g_assert_cmphex(rpmi_response_word(qts, 0), ==, 0);
+    g_assert_cmphex(rpmi_response_word(qts, 1), ==, 0);
+    g_assert_cmphex(rpmi_response_word(qts, 2), ==, 1);
+    g_assert_cmphex(rpmi_response_word(qts, 3), ==, 0);
+
+    qtest_system_reset(qts);
+    rpmi_send_request(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_GET_SUSPEND_INFO,
+                      RPMI_MSG_NORMAL_REQUEST, &suspend_type, 1);
+    rpmi_expect_ack(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_GET_SUSPEND_INFO,
+                    6 * sizeof(uint32_t));
+    g_assert_cmphex(rpmi_response_word(qts, 0), ==, 0);
+
+    qtest_system_reset(qts);
+    rpmi_send_request(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_HART_STOP,
+                      RPMI_MSG_NORMAL_REQUEST, stop_request,
+                      ARRAY_SIZE(stop_request));
+    rpmi_expect_ack(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_HART_STOP,
+                    sizeof(uint32_t));
+    g_assert_cmphex(rpmi_response_word(qts, 0), ==, 0);
+    /* The qtest accelerator never runs the target hart to its next WFI. */
+    rpmi_expect_hsm_status(qts, hart_id, RPMI_HSM_HART_STATE_STOP_PENDING);
+
+    rpmi_send_request(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_HART_START,
+                      RPMI_MSG_NORMAL_REQUEST, start_request,
+                      ARRAY_SIZE(start_request));
+    rpmi_expect_ack(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_HART_START,
+                    sizeof(uint32_t));
+    g_assert_cmphex(rpmi_response_word(qts, 0), ==, RPMI_ERR_DENIED);
+
+    qtest_system_reset(qts);
+    rpmi_expect_hsm_status(qts, hart_id, RPMI_HSM_HART_STATE_STARTED);
+    rpmi_send_request(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_HART_STOP,
+                      RPMI_MSG_NORMAL_REQUEST, stop_request,
+                      ARRAY_SIZE(stop_request));
+    rpmi_expect_ack(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_HART_STOP,
+                    sizeof(uint32_t));
+    g_assert_cmphex(rpmi_response_word(qts, 0), ==, 0);
+    rpmi_expect_hsm_status(qts, hart_id, RPMI_HSM_HART_STATE_STOP_PENDING);
+
+    qtest_quit(qts);
+
+    qts = qtest_init("-machine virt,rpmi=on -smp 2");
+    rpmi_send_request(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_HART_SUSPEND,
+                      RPMI_MSG_NORMAL_REQUEST, suspend_request,
+                      ARRAY_SIZE(suspend_request));
+    rpmi_expect_ack(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_HART_SUSPEND,
+                    sizeof(uint32_t));
+    g_assert_cmphex(rpmi_response_word(qts, 0), ==, 0);
+    /* The qtest accelerator does not execute the target hart to WFI. */
+    rpmi_expect_hsm_status(qts, hart_id,
+                           RPMI_HSM_HART_STATE_SUSPEND_PENDING);
+
+    qtest_system_reset(qts);
+    rpmi_expect_hsm_status(qts, hart_id, RPMI_HSM_HART_STATE_STARTED);
+    rpmi_send_request(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_HART_SUSPEND,
+                      RPMI_MSG_NORMAL_REQUEST, suspend_request,
+                      ARRAY_SIZE(suspend_request));
+    rpmi_expect_ack(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_HART_SUSPEND,
+                    sizeof(uint32_t));
+    g_assert_cmphex(rpmi_response_word(qts, 0), ==, 0);
+    rpmi_expect_hsm_status(qts, hart_id,
+                           RPMI_HSM_HART_STATE_SUSPEND_PENDING);
+
+    qtest_quit(qts);
+}
+
+static void test_rpmi_syssusp_attrs_and_suspend(void)
+{
+    QTestState *qts;
+    uint32_t suspend_type = 0;
+    uint32_t suspend_request[] = { 0, 0, 0x80000000, 0 };
+
+    qts = qtest_init("-machine virt,rpmi=on -smp 1");
+    rpmi_send_request(qts, RPMI_SRVGRP_SYSTEM_SUSPEND,
+                      RPMI_SYSSUSP_SRV_GET_ATTRIBUTES,
+                      RPMI_MSG_NORMAL_REQUEST, &suspend_type, 1);
+    rpmi_expect_ack(qts, RPMI_SRVGRP_SYSTEM_SUSPEND,
+                    RPMI_SYSSUSP_SRV_GET_ATTRIBUTES,
+                    2 * sizeof(uint32_t));
+    g_assert_cmphex(rpmi_response_word(qts, 0), ==, 0);
+    g_assert_cmphex(rpmi_response_word(qts, 1), ==, 3);
+
+    qtest_system_reset(qts);
+    rpmi_send_request(qts, RPMI_SRVGRP_SYSTEM_SUSPEND,
+                      RPMI_SYSSUSP_SRV_SYSTEM_SUSPEND,
+                      RPMI_MSG_NORMAL_REQUEST, suspend_request,
+                      ARRAY_SIZE(suspend_request));
+    rpmi_expect_ack(qts, RPMI_SRVGRP_SYSTEM_SUSPEND,
+                    RPMI_SYSSUSP_SRV_SYSTEM_SUSPEND, sizeof(uint32_t));
+    g_assert_cmphex(rpmi_response_word(qts, 0), ==, 0);
+    qtest_qmp_eventwait(qts, "SUSPEND");
+    qtest_qmp_assert_success(qts, "{ 'execute': 'system_wakeup' }");
+    qtest_qmp_eventwait(qts, "WAKEUP");
+
+    qtest_quit(qts);
+}
+
+static void rpmi_expect_syssusp_address(QTestState *qts, uint64_t address,
+                                      uint32_t status)
+{
+    uint32_t request[] = { 0, 0, address, address >> 32 };
+    QDict *response;
+
+    g_test_message("System Suspend resume address: 0x%016" PRIx64, address);
+    rpmi_send_request(qts, RPMI_SRVGRP_SYSTEM_SUSPEND,
+                      RPMI_SYSSUSP_SRV_SYSTEM_SUSPEND,
+                      RPMI_MSG_NORMAL_REQUEST, request, ARRAY_SIZE(request));
+    rpmi_expect_ack(qts, RPMI_SRVGRP_SYSTEM_SUSPEND,
+                    RPMI_SYSSUSP_SRV_SYSTEM_SUSPEND, sizeof(uint32_t));
+    g_assert_cmphex(rpmi_response_word(qts, 0), ==, status);
+    if (status == 0) {
+        qtest_qmp_eventwait(qts, "SUSPEND");
+        qtest_qmp_assert_success(qts, "{ 'execute': 'system_wakeup' }");
+        qtest_qmp_eventwait(qts, "WAKEUP");
+    } else {
+        /* query-status drains earlier events before checking for SUSPEND. */
+        response = qtest_qmp(qts, "{ 'execute': 'query-status' }");
+        g_assert_cmpstr(qdict_get_str(qdict_get_qdict(response, "return"),
+                                     "status"), ==, "running");
+        qobject_unref(response);
+        response = qtest_qmp_event_ref(qts, "SUSPEND");
+        g_assert_null(response);
+    }
+}
+
+static void test_rpmi_syssusp_resume_address(void)
+{
+    const uint64_t high_ram_addr = 0x100000000ULL;
+    QTestState *qts = qtest_init("-machine virt,rpmi=on -smp 1 -m 128M "
+                                 "-cpu sifive-u54");
+
+    rpmi_expect_syssusp_address(qts, 0x80000001, RPMI_ERR_INVALID_ADDR);
+    rpmi_expect_syssusp_address(qts, 0x10000000, RPMI_ERR_INVALID_ADDR);
+    rpmi_expect_syssusp_address(qts, 0x88000000, RPMI_ERR_INVALID_ADDR);
+    rpmi_expect_syssusp_address(qts, 0x80000002, 0);
+    qtest_system_reset(qts);
+    rpmi_expect_syssusp_address(qts, 0x80000000, 0);
+    qtest_quit(qts);
+
+    qts = qtest_init("-machine virt,rpmi=on -smp 1 -m 3G -cpu rv32i");
+    qtest_writeb(qts, high_ram_addr, 0x5a);
+    g_assert_cmphex(qtest_readb(qts, high_ram_addr), ==, 0x5a);
+    rpmi_expect_syssusp_address(qts, 0x80000002, RPMI_ERR_INVALID_ADDR);
+    rpmi_expect_syssusp_address(qts, high_ram_addr, RPMI_ERR_INVALID_ADDR);
+    rpmi_expect_syssusp_address(qts, 0x80000000, 0);
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    if (qtest_has_machine("virt")) {
+        qtest_add_func("/riscv/rpmi/syssusp/resume-address",
+                       test_rpmi_syssusp_resume_address);
+        qtest_add_func("/riscv/rpmi/fdt/service-nodes",
+                       test_rpmi_virt_fdt_service_nodes);
+        qtest_add_func("/riscv/rpmi/machine/realize-off",
+                       test_rpmi_machine_realize_off);
+        qtest_add_func("/riscv/rpmi/machine/rejects-too-many-harts",
+                       test_rpmi_machine_rejects_too_many_harts);
+        qtest_add_func("/riscv/rpmi/base/platform-info",
+                       test_rpmi_base_platform_info);
+        qtest_add_func("/riscv/rpmi/base/probe-service-groups",
+                       test_rpmi_base_probe_service_groups);
+        qtest_add_func("/riscv/rpmi/sysreset/attrs",
+                       test_rpmi_sysreset_attrs);
+        qtest_add_func("/riscv/rpmi/sysreset/shutdown",
+                       test_rpmi_sysreset_shutdown);
+        qtest_add_func("/riscv/rpmi/sysreset/cold-reboot",
+                       test_rpmi_sysreset_cold_reboot);
+        qtest_add_func("/riscv/rpmi/sysreset/invalid-type",
+                       test_rpmi_sysreset_invalid_type);
+        qtest_add_func("/riscv/rpmi/reset/clears-transport",
+                       test_rpmi_reset_clears_transport);
+        qtest_add_func("/riscv/rpmi/negative/doorbell-invalid-access",
+                       test_rpmi_doorbell_invalid_access);
+        qtest_add_func("/riscv/rpmi/negative/queue-bounds",
+                       test_rpmi_queue_bounds);
+        qtest_add_func("/riscv/rpmi/reset/repeated-after-traffic",
+                       test_rpmi_repeated_reset_after_traffic);
+        qtest_add_func("/riscv/rpmi/migration/blocked",
+                       test_rpmi_migration_blocked);
+        qtest_add_func("/riscv/rpmi/hsm/hart-list",
+                       test_rpmi_hsm_hart_list);
+        qtest_add_func("/riscv/rpmi/hsm/multi-socket-hart-list",
+                       test_rpmi_hsm_multi_socket_hart_list);
+        qtest_add_func("/riscv/rpmi/hsm/hart-status",
+                       test_rpmi_hsm_hart_status);
+        qtest_add_func("/riscv/rpmi/hsm/hart-control",
+                       test_rpmi_hsm_hart_control);
+        qtest_add_func("/riscv/rpmi/syssusp/attrs-and-suspend",
+                       test_rpmi_syssusp_attrs_and_suspend);
+    }
+
+    return g_test_run();
+}

