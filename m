Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16CB0C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 07:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjY2R-0003B3-Sw; Tue, 14 Jul 2026 03:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wjY2Q-00039T-K8
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 03:58:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wjY2N-0003fE-I2
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 03:58:46 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66E6SZxm3740809
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 07:58:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Y2wZLpH7OCx
 +XH5YAdgv1QNFcT7qOLu7oqzkvaJN6Uo=; b=QKhs2tW0cKuXdY8Wq1XXEJF4oYN
 q8kXdGU2sBckfvf2HALTMp6meQhA8tGgT2cU3lU/4EWPkj+L20PtlmloMJJYaCCF
 HoMb5H9mGtdDaSgsnGe7z8QBpWNNZJOH3Utzmw0aHy8z+xAmrWge6Pj3sgPzQtWM
 JGDwm7mQN1T9UDKkHG1TPJTOfnuO3hU95RauqFzszf4iVW9wUoaP1Vl6wi0wogya
 jX4BT5nX9XaH8BKYaEVB9q2MZKJX1uNTBXzc/cfwguYYNVOPB0XbOl5qnk4JwB7P
 z5c/2fub4wGpYDa4o41qkHHLaVYHyLPZXEtAebiCeNrFL5nqBMZgQUuvWSQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdde08xgc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 07:58:32 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-387087245e4so1333092a91.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 00:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784015911; x=1784620711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y2wZLpH7OCx+XH5YAdgv1QNFcT7qOLu7oqzkvaJN6Uo=;
 b=KBprey9M5Q18Errcbkq6vGXSpy5sXpQdvJUHl6Y5tP5ClMCc7EXmJOc32iaNMVsSnm
 c4ePusVpUUv+b6a9URS94m+MNtpjJwXAMHxMqvOyljzyTz2aNAQMGV5dBQHYk5GWuakt
 en1iJuppkstlFLCe1oAglEXU7GZ4HcUFy6sAjgpqgpdx0xEpAZLoCGTlxWIl8qKrGkaM
 1NE8FUXB6m0tU0GEd7CrNSjUTbsv08QC+WzKH3QQs1NFwLwHKJhkku/5ofaE5qBisHAe
 3ERI3TP11nO5Tv+RR5TWjMmB+4oVySuU0rcLysYJ4u7xJOlGCZV1cX1ueChKmQqsr3K6
 3YkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784015911; x=1784620711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y2wZLpH7OCx+XH5YAdgv1QNFcT7qOLu7oqzkvaJN6Uo=;
 b=nXqz1JOi/uplDG2Ckm4UbMz1NSMcwxa0Y1atixZ9IHDifpcvj+4meG4KCYkilm6c2k
 oAl5K6rqWyxQtb+PNusQKF6VY5mhDWS+tnosbEEPEYUXJYT5YedBjc+/pZvaxgURBFH5
 qsENR2KNeMan+Gvds23/ScRrVKxpj8hykAif3PE0e5nHz+FGXtzZ6eyWsEaVbU43LQ62
 OiawPLfqTILUk1vWUrS6KMgEoDNnDs5xCLKF0vpiq7aefNZJH3pZIw1ReH53yY5qrGaQ
 ib294sP2fXmaFKlrIHTihbWCc6ac3Y9nK40Lm4f6SsZ5NcH9OEfdRr6gXtHokkObBLKh
 KR+w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpPg0noPLyystfDrvxHrNFm2xWm/3/7HgQWfDUqgg8/Y0S8tS6MPPbVMkWpYhDKaxDVFJ7mh7UTr65J@nongnu.org
X-Gm-Message-State: AOJu0YwN9Ta1yl2CUeVtkSGHF3vqqUduFI4USybG8OLrqvdbHdRA4ZLB
 dMAXeEvvKPqFwa9u+qcJIskfRZmhYoAEGDdrFqDkDaBkndtZq/8q5IQeFJeW2uXs01ewCd/9aEm
 hHhYJj7N54tIeCdOaoocWViKgYWmQFi+1fd1ZnYhLvnoRZR2yEbsgFUOnVw==
X-Gm-Gg: AfdE7cmMTA9dGSXONT4ynyZ8JPFBO5I8i8WYgg8OxQZieHL8qxC8/E/x2pcj6nDPn0H
 XyVvjZ2qesp70fcOul6fptx0g/PWrBIvSk2PRepFAZd5lO0bFnXlslr6Ou9iakRl0Z8osGuU1c5
 pQpakQp/tWMwKkZOWN5DsVSrmoliHm5YFqkYgVUmI19kv97Dhr9s08hqV3DNaZAyBXBM9XNqjMI
 4d0SNQk+RLiJaD7ADcBFLehE/9yFYOo2JMw59Fhv+7DAha0MYLHNlGWcwZ1SXTCh8bhupiUz/cg
 MYVirlcd1EVQDi1EhNBP5am6CH64MDcda3Wg0FnnRp0lshHjkWBSwd3+iIGpvnHAyRuNe6LjtuD
 sQIkrK8h+emqygFqB1CPty0exEqTBuc0Lw58/vzDqK8/96pXGS1rW8MhuISIWs7/NCVCuxdMgRn
 lm8j2Hv54oKHIVf3MSL+pJogn01QLv8aj7M9CwYwAHfw==
X-Received: by 2002:a17:90b:57ef:b0:37f:f00b:bda6 with SMTP id
 98e67ed59e1d1-38dc732cf3fmr8746200a91.0.1784015911234; 
 Tue, 14 Jul 2026 00:58:31 -0700 (PDT)
X-Received: by 2002:a17:90b:57ef:b0:37f:f00b:bda6 with SMTP id
 98e67ed59e1d1-38dc732cf3fmr8746173a91.0.1784015910651; 
 Tue, 14 Jul 2026 00:58:30 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311950eb930sm55606355eec.8.2026.07.14.00.58.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 00:58:30 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-riscv@nongnu.org
Cc: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v3 09/10] tests/qtest: cover initial RISC-V RPMI services
Date: Tue, 14 Jul 2026 13:26:58 +0530
Message-ID: <20260714075659.2258023-10-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714075659.2258023-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20260714075659.2258023-1-subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA4MiBTYWx0ZWRfXzsg2nUkVMcWN
 fHu8Q5v9lqTqvcK6fmKUpPfIgTeVvvy8KeU1TCqhl/oP1JyV4apNHGE5drVsbaHcvFG8i5TqSLc
 dSQrZ1jcTzFLRK3SE0lDvMq4CjJk8T0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA4MiBTYWx0ZWRfX/BPpoc5IKvpN
 xjKm5YrOCJBbgSO7BNesUWPZle2WE8E04Xbk1awdgREdvrZY1SdLUECarSX1pkpmQVfw1wUfhnh
 zxD1EPHCgrPinqD/8Vzqadp9cfHr7HQDmV4sKY93Wexx2tYJEBC9A+FXOhnx1sSdAjiuj1isfp4
 FawvJLkDGB9LaxefciKtZGcShfeesB/igu5Sj30NCK5XZER5/MNY428ESHx0IL8J77QNc7KScaJ
 Pz6TL8Zq7n6FsYJoV2wkGcWFXtFI3BAyHlku5ETAAOPlGCK9xdPbg+DvEDprkOuoTvuN+t+q9nh
 zrPEhTc2RsMNc/Ju64U8qOj6/2Z3rzYQ4pCGxAeJW0ktaGz1+5lQ6I+RQovk2qZWQoAQofkNRzY
 UNDcUt62l/u1FMDGwgMNGK+VnwrRGRklbmIB8A8QEhvpwBZk5J1eM9VVlO0PMFYrZ1Zsa6Og3Qg
 UhdUa/apx6mlU9rQvUQ==
X-Proofpoint-ORIG-GUID: FdbarA0RM3lM6lc7OYdvrLG7qXkQrY66
X-Proofpoint-GUID: FdbarA0RM3lM6lc7OYdvrLG7qXkQrY66
X-Authority-Analysis: v=2.4 cv=F/FnsKhN c=1 sm=1 tr=0 ts=6a55ec28 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=cXInsyxJmRBO8JMYNpUA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140082
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add qtests for the RPMI transport plus Base, system reset, HSM, and
system suspend service groups.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
---
 MAINTAINERS                   |   1 +
 tests/qtest/meson.build       |   2 +
 tests/qtest/riscv-rpmi-test.c | 684 ++++++++++++++++++++++++++++++++++
 3 files changed, 687 insertions(+)
 create mode 100644 tests/qtest/riscv-rpmi-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e91a31757..6dd71c5a82 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -361,6 +361,7 @@ F: hw/riscv/
 F: hw/intc/riscv*
 F: hw/misc/riscv_rpmi*
 F: include/hw/misc/riscv_rpmi.h
+F: tests/qtest/riscv-rpmi-test.c
 F: include/hw/char/riscv_htif.h
 F: include/hw/riscv/
 F: common-user/host/riscv*
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 4897325d84..d54b79cbcf 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -290,6 +290,8 @@ qtests_riscv32 = \
 
 qtests_riscv64 = ['riscv-csr-test'] + \
   (unpack_edk2_blobs ? ['bios-tables-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_RISCV_RPMI') ?
+   ['riscv-rpmi-test'] : []) + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
    ['iommu-riscv-test'] : []) + \
diff --git a/tests/qtest/riscv-rpmi-test.c b/tests/qtest/riscv-rpmi-test.c
new file mode 100644
index 0000000000..ecd5b910c7
--- /dev/null
+++ b/tests/qtest/riscv-rpmi-test.c
@@ -0,0 +1,684 @@
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
+#include "libqtest.h"
+#include "qobject/qdict.h"
+
+#define RPMI_SHMEM_BASE 0x10200000ULL
+#define RPMI_DOORBELL_BASE 0x10230000ULL
+#define RPMI_IMSIC_S_BASE 0x28000000ULL
+#define RPMI_CPPC_FASTCHAN_BASE 0x10240000ULL
+#define RPMI_CPPC_FASTCHAN_SIZE 0x4000
+#define RPMI_CPPC_FASTCHAN_FEEDBACK_OFFSET 0x2000
+#define RPMI_SLOT_SIZE 64
+
+#define RPMI_A2P_HEAD RPMI_SHMEM_BASE
+#define RPMI_A2P_TAIL (RPMI_SHMEM_BASE + RPMI_SLOT_SIZE)
+#define RPMI_A2P_SLOT0 (RPMI_SHMEM_BASE + 2 * RPMI_SLOT_SIZE)
+
+#define RPMI_SRVGRP_BASE 0x0001
+#define RPMI_SRVGRP_SYSTEM_MSI 0x0002
+#define RPMI_SRVGRP_SYSTEM_RESET 0x0003
+#define RPMI_SRVGRP_SYSTEM_SUSPEND 0x0004
+#define RPMI_SRVGRP_HSM 0x0005
+#define RPMI_SRVGRP_CPPC 0x0006
+#define RPMI_SRVGRP_CLOCK 0x0008
+#define RPMI_SRVGRP_MANAGEMENT_MODE 0x000b
+#define RPMI_SRVGRP_LOGGING 0x000e
+#define RPMI_BASE_SRV_GET_PLATFORM_INFO 0x05
+#define RPMI_BASE_SRV_PROBE_SERVICE_GROUP 0x06
+#define RPMI_SYSMSI_SRV_GET_ATTRIBUTES 0x02
+#define RPMI_SYSMSI_SRV_GET_MSI_ATTRIBUTES 0x03
+#define RPMI_SYSMSI_SRV_SET_MSI_STATE 0x04
+#define RPMI_SYSMSI_SRV_GET_MSI_STATE 0x05
+#define RPMI_SYSMSI_SRV_SET_MSI_TARGET 0x06
+#define RPMI_SYSMSI_SRV_GET_MSI_TARGET 0x07
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
+#define RPMI_CPPC_SRV_PROBE_REG 0x02
+#define RPMI_CPPC_SRV_READ_REG 0x03
+#define RPMI_CPPC_SRV_WRITE_REG 0x04
+#define RPMI_CPPC_SRV_GET_FAST_CHANNEL_REGION 0x05
+#define RPMI_CPPC_SRV_GET_FAST_CHANNEL_OFFSET 0x06
+#define RPMI_CPPC_SRV_GET_HART_LIST 0x07
+#define RPMI_CPPC_NOMINAL_PERF 0x01
+#define RPMI_CPPC_DESIRED_PERF 0x05
+#define RPMI_CPPC_COUNTER_WRAPAROUND_TIME 0x0a
+#define RPMI_CPPC_REFERENCE_PERF_COUNTER 0x0b
+#define RPMI_CPPC_DELIVERED_PERF_COUNTER 0x0c
+#define RPMI_CPPC_REG_LEN_64 64
+#define RPMI_CLK_SRV_GET_NUM_CLOCKS 0x02
+#define RPMI_CLK_SRV_GET_ATTRIBUTES 0x03
+#define RPMI_CLK_SRV_GET_SUPPORTED_RATES 0x04
+#define RPMI_CLK_SRV_SET_CONFIG 0x05
+#define RPMI_CLK_SRV_GET_CONFIG 0x06
+#define RPMI_CLK_SRV_SET_RATE 0x07
+#define RPMI_CLK_SRV_GET_RATE 0x08
+#define RPMI_MM_SRV_GET_ATTRIBUTES 0x02
+#define RPMI_MM_SRV_COMMUNICATE 0x03
+#define RPMI_LOGGING_SRV_SET_CONFIG 0x02
+#define RPMI_MSG_NORMAL_REQUEST 0x00
+#define RPMI_MSG_POSTED_REQUEST 0x01
+#define RPMI_MSG_ACKNOWLEDGEMENT 0x02
+#define RPMI_SYSRST_TYPE_SHUTDOWN 0x00
+#define RPMI_SYSRST_TYPE_COLD_REBOOT 0x01
+#define RPMI_SYSRST_TYPE_INVALID 0x03
+#define RPMI_SYSRST_ATTRS_FLAGS_RESETTYPE 1
+#define RPMI_SYS_MSI_SHUTDOWN_INDEX 0
+#define RPMI_SYS_MSI_REBOOT_INDEX 1
+#define RPMI_SYS_MSI_SUSPEND_INDEX 2
+#define RPMI_SYS_NUM_MSI 4
+#define RPMI_SYSMSI_MSI_STATE_ENABLE 1
+#define RPMI_SYSMSI_MSI_STATE_PENDING 2
+#define RPMI_TOKEN 0x55aa
+#define RPMI_ERR_NOTSUPP 0xfffffffeU
+#define RPMI_ERR_INVALID_PARAM 0xfffffffdU
+#define RPMI_ERR_INVALID_ADDR 0xfffffffbU
+#define RPMI_ERR_DENIED 0xfffffffcU
+#define RPMI_HSM_HART_STATE_STARTED 0x00
+#define RPMI_HSM_HART_STATE_STOPPED 0x01
+#define RPMI_HSM_HART_STATE_SUSPENDED 0x04
+#define VIRT_RPMI_CPPC_NOMINAL_PERF 30
+#define VIRT_RPMI_CLOCK_COUNT 6
+#define VIRT_RPMI_MM_VERSION 0x10000
+#define VIRT_RPMI_SHMEM_SIZE 0x20000
+#define RPMI_MM_INPUT_OFFSET 0x3000
+#define RPMI_MM_OUTPUT_OFFSET 0x3800
+#define RPMI_MM_BUFFER_SIZE 0x400
+#define RPMI_MM_INPUT_BASE (RPMI_SHMEM_BASE + RPMI_MM_INPUT_OFFSET)
+#define RPMI_MM_OUTPUT_BASE (RPMI_SHMEM_BASE + RPMI_MM_OUTPUT_OFFSET)
+#define MM_EFI_COMM_HEADER_SIZE 24
+#define EFI_VAR_COMM_HEADER_SIZE 16
+#define EFI_VAR_ACCESS_NAME_OFFSET 36
+#define EFI_VAR_NEXT_NAME_OFFSET 24
+#define EFI_VAR_FN_GET_VARIABLE 1
+#define EFI_VAR_FN_GET_NEXT_VARIABLE_NAME 2
+#define EFI_VAR_FN_SET_VARIABLE 3
+#define EFI_SUCCESS 0ULL
+#define EFI_INVALID_PARAMETER 0x8000000000000002ULL
+#define EFI_BUFFER_TOO_SMALL 0x8000000000000005ULL
+#define EFI_NOT_FOUND 0x800000000000000eULL
+#define EFI_VARIABLE_NON_VOLATILE 0x00000001
+#define EFI_VARIABLE_BOOTSERVICE_ACCESS 0x00000002
+#define EFI_VARIABLE_RUNTIME_ACCESS 0x00000004
+
+#define RPMI_P2A_ACK_BASE (RPMI_SHMEM_BASE + 16 * RPMI_SLOT_SIZE)
+#define RPMI_P2A_ACK_HEAD RPMI_P2A_ACK_BASE
+#define RPMI_P2A_ACK_TAIL (RPMI_P2A_ACK_BASE + RPMI_SLOT_SIZE)
+#define RPMI_P2A_ACK_SLOT0 (RPMI_P2A_ACK_BASE + 2 * RPMI_SLOT_SIZE)
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
+    qtest_writel(qts, RPMI_A2P_TAIL, (tail + 1) % 16);
+    qtest_writel(qts, RPMI_DOORBELL_BASE, 1);
+}
+
+static uint32_t rpmi_response_word(QTestState *qts, unsigned int word)
+{
+    return qtest_readl(qts, rpmi_response_base + 8 + word * sizeof(uint32_t));
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
+    qtest_writel(qts, RPMI_P2A_ACK_HEAD, (head + 1) % 16);
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
+    g_assert_false(g_spawn_check_exit_status(wait_status, NULL));
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
+        g_assert_cmphex(qtest_readb(qts, RPMI_P2A_ACK_SLOT0 + 16 + i), ==,
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
+    qtest_system_reset(qts);
+    rpmi_probe_group(qts, RPMI_SRVGRP_CPPC, false);
+    qtest_system_reset(qts);
+    rpmi_probe_group(qts, RPMI_SRVGRP_SYSTEM_MSI, false);
+    qtest_system_reset(qts);
+    rpmi_probe_group(qts, RPMI_SRVGRP_CLOCK, false);
+    qtest_system_reset(qts);
+    rpmi_probe_group(qts, RPMI_SRVGRP_MANAGEMENT_MODE, false);
+    qtest_system_reset(qts);
+    rpmi_probe_group(qts, RPMI_SRVGRP_LOGGING, false);
+
+    qtest_quit(qts);
+}
+
+static void test_rpmi_sysreset_attrs(void)
+{
+    QTestState *qts;
+    uint32_t reset_type = RPMI_SYSRST_TYPE_SHUTDOWN;
+
+    qts = qtest_init("-machine virt,rpmi=on");
+    rpmi_send_request(qts, RPMI_SRVGRP_SYSTEM_RESET,
+                      RPMI_SYSRST_SRV_GET_ATTRIBUTES,
+                      RPMI_MSG_NORMAL_REQUEST, &reset_type, 1);
+    rpmi_expect_ack(qts, RPMI_SRVGRP_SYSTEM_RESET,
+                    RPMI_SYSRST_SRV_GET_ATTRIBUTES, 2 * sizeof(uint32_t));
+    g_assert_cmphex(rpmi_response_word(qts, 0), ==, 0);
+    g_assert_cmphex(rpmi_response_word(qts, 1), ==,
+                    RPMI_SYSRST_ATTRS_FLAGS_RESETTYPE);
+
+    qtest_system_reset(qts);
+    reset_type = RPMI_SYSRST_TYPE_COLD_REBOOT;
+    rpmi_send_request(qts, RPMI_SRVGRP_SYSTEM_RESET,
+                      RPMI_SYSRST_SRV_GET_ATTRIBUTES,
+                      RPMI_MSG_NORMAL_REQUEST, &reset_type, 1);
+    rpmi_expect_ack(qts, RPMI_SRVGRP_SYSTEM_RESET,
+                    RPMI_SYSRST_SRV_GET_ATTRIBUTES, 2 * sizeof(uint32_t));
+    g_assert_cmphex(rpmi_response_word(qts, 0), ==, 0);
+    g_assert_cmphex(rpmi_response_word(qts, 1), ==,
+                    RPMI_SYSRST_ATTRS_FLAGS_RESETTYPE);
+
+    qtest_system_reset(qts);
+    reset_type = RPMI_SYSRST_TYPE_INVALID;
+    rpmi_send_request(qts, RPMI_SRVGRP_SYSTEM_RESET,
+                      RPMI_SYSRST_SRV_GET_ATTRIBUTES,
+                      RPMI_MSG_NORMAL_REQUEST, &reset_type, 1);
+    rpmi_expect_ack(qts, RPMI_SRVGRP_SYSTEM_RESET,
+                    RPMI_SYSRST_SRV_GET_ATTRIBUTES, 2 * sizeof(uint32_t));
+    g_assert_cmphex(rpmi_response_word(qts, 0), ==, 0);
+    g_assert_cmphex(rpmi_response_word(qts, 1), ==, 0);
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
+    qtest_writel(qts, RPMI_A2P_TAIL, 0x1000);
+    qtest_writel(qts, RPMI_DOORBELL_BASE, 1);
+    g_assert_cmphex(qtest_readl(qts, RPMI_A2P_HEAD), ==, 0);
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
+static void test_rpmi_hsm_hart_list(void)
+{
+    QTestState *qts;
+    uint32_t start_index = 0;
+
+    qts = qtest_init("-machine virt,rpmi=on -smp 4");
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
+
+    qtest_quit(qts);
+}
+
+static void test_rpmi_hsm_multi_socket_hart_list(void)
+{
+    QTestState *qts;
+    uint32_t start_index = 0;
+
+    qts = qtest_init("-machine virt,rpmi=on "
+                     "-smp 4,sockets=2,cores=2,threads=1");
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
+    uint32_t start_request[] = { hart_id, 0x80000000, 0 };
+    uint32_t suspend_request[] = { hart_id, 0, 0x80001000, 0 };
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
+    rpmi_expect_hsm_status(qts, hart_id, RPMI_HSM_HART_STATE_STOPPED);
+
+    rpmi_send_request(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_HART_START,
+                      RPMI_MSG_NORMAL_REQUEST, start_request,
+                      ARRAY_SIZE(start_request));
+    rpmi_expect_ack(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_HART_START,
+                    sizeof(uint32_t));
+    g_assert_cmphex(rpmi_response_word(qts, 0), ==, 0);
+    rpmi_expect_hsm_status(qts, hart_id, RPMI_HSM_HART_STATE_STARTED);
+
+    rpmi_send_request(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_HART_SUSPEND,
+                      RPMI_MSG_NORMAL_REQUEST, suspend_request,
+                      ARRAY_SIZE(suspend_request));
+    rpmi_expect_ack(qts, RPMI_SRVGRP_HSM, RPMI_HSM_SRV_HART_SUSPEND,
+                    sizeof(uint32_t));
+    g_assert_cmphex(rpmi_response_word(qts, 0), ==, 0);
+    rpmi_expect_hsm_status(qts, hart_id, RPMI_HSM_HART_STATE_SUSPENDED);
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
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    if (qtest_has_machine("virt")) {
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
-- 
2.43.0


