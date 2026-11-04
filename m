Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7B4606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 05:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UxHlvWw1;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TLkjdQBH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOTCQ-0004Ye-6W; Wed, 04 Nov 2026 00:06:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xOTCO-0004Vs-69
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 00:06:12 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xOTCL-0002Bh-4v
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 00:06:11 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A40RbOV3867680
 for <qemu-devel@nongnu.org>; Wed, 4 Nov 2026 05:06:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=KmOhbnslAFh
 Ra9K4Vc9LKcI8NgfxY4HbVrgEeVNErsc=; b=UxHlvWw1Z3KKdZcVmlAtvou6AjF
 laNfjSrNReU3eaz6BcCth/sZdifkROWH7JDHR1f+h+PkKgwK2uzJm8uMGj5jSI6u
 melNMxnuhISjMSzTBEAdzQFZOITJLFNxdsqTdOOV1KYbzG2jaAmaOHC4dhJs1Pfd
 dJ3eAP/BXMl6pqJ01p3BYVlwd3Nhd0D7UfNR1LzuClNc7vApiV9NuqVaKuRJT6F1
 yXZJAbMjg8QAvuPe/YiYyGSYl9jCq81Tk4uI4CWVoVa4re+n1+V0Qko41OY6+mh5
 dYzx4+LODAy/VA/LGBwJmpXfABcozrOCea6wS9J5IIlt0jdMFn5jP/G9eNQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqn8y203y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 05:06:07 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-14f0e9c6404so13034c88.3
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 21:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793768767; x=1794373567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KmOhbnslAFhRa9K4Vc9LKcI8NgfxY4HbVrgEeVNErsc=;
 b=TLkjdQBH9kgro6/3WS7lSxKVpkcONTKzWarpyrjGNhyXpMnnz4d1D2DwVJivj34UGL
 elwxzqg/3LooIA+vejXOh3l2f4AGsKTlWo4jcmHMtDTjqUWvmz/rvSd8HqUz3T4b1DxC
 RqM+S6I3wj7k1+vaaIRu1Ao3Y1qieJbV7cuc+1PPjR7NZ+YG6M+H633QzeuMNk6llowq
 u53eoOhYRe6isEstE3c/kzjLUjEbPXzkAIOeAWmWps2E+f2ne/WFVHSmnMfzWScO/d7W
 mpbCsuLl5+KS2XDrfAEdqKXt+4L2yg321TjxeIzkxfhsQLTHW5mf/xylPFRgM1O0O++j
 PSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793768767; x=1794373567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KmOhbnslAFhRa9K4Vc9LKcI8NgfxY4HbVrgEeVNErsc=;
 b=Knhssvkgmc/i2HxAMlT52i1JDADhmGhAP3flMpxplZkcXps1VThy9EL7DWiRYJ/BW1
 /QH5UC2Qkxl8vZgKVgmDCvcdUeS5BZO0A/HGuMPX8MOqtPZ8dimF2GTEed2ofFjVNJnY
 c1rgDCxvewRvCzF+vByz1cmd8WywHJSwh32DbW4SMd2OPV62czmkol6a7x/J8g3KJB1j
 1WKuG9cw7mkp/qYdX3j5oc1gRQx6FmuNzTIoiVV0/21fXvVwGjTsWet+olil1r/okYs9
 P6jeYBVki6o4dhSfi5uJxInE4s5nOruqAXckTNosdqOfIXDzxeq223o+h2XtY0iDgBDu
 pWBQ==
X-Gm-Message-State: APuU4Z/7FfadlgSCK4TDi2/3Qc45V20O1JShyL9ugYUJg2y0cnv19qDu
 UlAfq+cAOPcNA7Y19IypJsnV9ifnetrLagth9NtA4nSiwZjlONy24m3bKtSP1kTaN4tPgO7nqra
 w3cr0O2SzZ2SfFsZHJbV0luwGCF5IXCL9rK6/Pk3frMNrTeiy0PVhZB9cHIl2SPK9ng==
X-Gm-Gg: AYBFou3YvFD1JINXXLtwLARahvyuN/yP7vMhAPZ3ZYVRlVKQK9my9Z8Zjnx00pehvNs
 /uqQxJjXVd3femksSq7q7MOT8TB/NmPZFwmfetMEtQ5cYXlryWoyajlIEzlmisUGiTiExL8aYxR
 i7e7gk5YHYU+7BCRchWePeaUT7QQ78WtFmhcNC3PtjT1cOEG0N3OiiN/emJZ5Se+iS/QkMKKOaI
 OrHyd3e/NV3MlNNL8C1LA8zxT2PrvIiQat2K67arwT4bYxbU46eOl/48iYJMEr/y7pWCR4jsYso
 ghv9WSHJ5x0hS0gVOlmU5Hets4g0LtZ0Rz+tE3VnWpRCtZGhe4nnwekllFIZV8Rq+lSdCqgeryB
 P0NZ1g0TT/KWs8VqNlv7p2BWjno3ZQXs6tGzFabYCfE5TIxi8EzI/YrJ4o9BcQS+VuDHAfcg/JW
 l8JX73zXikTTEMt1nHYF9F9B43/bX77zu2xdvNwkxeD7nNlslMbXfaEFnud0z0jvqXPeQRnJ9d/
 IGBGdkf
X-Received: by 2002:a05:7300:d090:b0:36a:e7a:e89 with SMTP id
 5a478bee46e88-36a4239cc86mr33459667eec.2.1793768766477; 
 Tue, 03 Nov 2026 21:06:06 -0800 (PST)
X-Received: by 2002:a05:7300:d090:b0:36a:e7a:e89 with SMTP id
 5a478bee46e88-36a4239cc86mr33459615eec.2.1793768765484; 
 Tue, 03 Nov 2026 21:06:05 -0800 (PST)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca390df28sm3925036eec.18.2026.11.03.21.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 21:06:05 -0800 (PST)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH v14 02/10] hw/misc: add RISC-V RPMI transport and Base support
Date: Wed,  4 Nov 2026 10:33:15 +0530
Message-ID: <20261104050324.733555-3-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104050324.733555-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20261104050324.733555-1-subrahmanya.lingappa@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: IILV82vBIya0HXZo-qYIP7_wiPlolwqi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAyMCBTYWx0ZWRfX48Jsndkm6n/G
 GvKcEThCqk75g1HMJ3aWWmxtKtanUwt4Yk7j7SMnu3xfzzuaSWtVILTC1ZecADdnczDmDd/KQCK
 REVvx9YdaUlzQUTkmwgiqYOLcpCGbrlrc9KD6vCvWIqPZI30zZKFQPSwoiAqLi+YWrqe42F7G6d
 cY8Ck1xuq7h3VGJPnHaxqTbvBBx8y22amvDRnRCYgTovYEWKlsycC7/cYxteXihAqNFDGTSMotH
 mA8vGu6a9T76v6u+/4FJPwLs5QIcoHPxcTSceRZCJ6/gULMeNJmm3Lu95CKUoGelqqNiah5VR6k
 oxG5aIdylLQcWYKZpokGCNiZknYUgy2Oj0lcJ4sj8G52NtaN+0sjgdrao8W7+uhGTNrZNWoqmaL
 k4WUKOS7o47eQ7uOoFQYdtz+GUba84RRrf0sXeKRvTTFHhZB2y7BC7rjfpG1/y5Jmq20cTSqGx9
 s/pp04fSdyS/UQ7qCJw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAyMCBTYWx0ZWRfX2SA+VX8o5KDq
 +bJ5Zp+1T2g95MdlJqYxsKetF1aq678Y0ecW/NTpnd45R9CoFU8Km6QfwSfOfy1e0/1jBiv/rDo
 9nYrfmJ2zll3m8NWIjKOC7LY90nA+qo=
X-Proofpoint-ORIG-GUID: IILV82vBIya0HXZo-qYIP7_wiPlolwqi
X-Authority-Analysis: v=2.4 cv=NP5AaE6g c=1 sm=1 tr=0 ts=6aeabd3f cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=V1jnuoLLAAAA:20
 a=NEAV23lmAAAA:8 a=hwM_GrIuAAAA:20 a=EUspDBNiAAAA:8 a=bDgSmJffVkpEkReGgNYA:9
 a=Fk4IpSoW4aLDllm1B1p-:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

RPMI (RISC-V Platform Management Interface) is the RISC-V non-ISA
platform management specification. It defines a shared-memory transport,
message protocol, and service groups for platform management.

Add the QEMU transport backend and Base service plumbing for virt using
librpmi. Keep context lifecycle, service-group changes, and request
dispatch under the existing device paths' BQL ownership. Document that
the librpmi environment lock hooks are no-ops because QEMU provides
synchronization at the call sites that need it.

This implementation targets the RISC-V Platform Management Interface
(RPMI) Specification v1.0 Ratified:

https://github.com/riscv-non-isa/riscv-rpmi/releases/download/v1.0/riscv-rpmi.pdf

The librpmi backend is maintained at:

https://github.com/riscv-software-src/librpmi

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
---
 MAINTAINERS                   |   2 +
 hw/misc/Kconfig               |   4 +
 hw/misc/meson.build           |   4 +
 hw/misc/riscv_rpmi-stub.c     |  16 ++
 hw/misc/riscv_rpmi.c          | 514 ++++++++++++++++++++++++++++++++++
 hw/misc/riscv_rpmi_internal.h |  25 ++
 include/hw/misc/riscv_rpmi.h  |  92 ++++++
 7 files changed, 657 insertions(+)
 create mode 100644 hw/misc/riscv_rpmi-stub.c
 create mode 100644 hw/misc/riscv_rpmi.c
 create mode 100644 hw/misc/riscv_rpmi_internal.h
 create mode 100644 include/hw/misc/riscv_rpmi.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 55463103ff..7f7764b03b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -379,6 +379,8 @@ F: gdbstub/gdb-xml/riscv*.xml
 F: hw/char/riscv_htif.c
 F: hw/riscv/
 F: hw/intc/riscv*
+F: hw/misc/riscv_rpmi*
+F: include/hw/misc/riscv_rpmi.h
 F: include/hw/char/riscv_htif.h
 F: include/hw/riscv/
 F: common-user/host/riscv*
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 685b7ff1e7..cabdf3473c 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -303,3 +303,7 @@ source macio/Kconfig
 
 config QCOM_QDSP6SS_CLK
     bool
+
+config RISCV_RPMI
+    bool
+    depends on LIBRPMI
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index fc3800baec..b755796170 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -182,3 +182,7 @@ system_ss.add(when: 'CONFIG_AXIADO_CLK', if_true: files('axiado_clk.c'))
 
 # Qualcomm Hexagon DSP subsystems
 system_ss.add(when: 'CONFIG_QCOM_QDSP6SS_CLK', if_true: files('qcom-qdsp6ss-clk.c'))
+
+system_ss.add(when: 'CONFIG_RISCV_RPMI', if_true: [files(
+  'riscv_rpmi.c',
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
diff --git a/hw/misc/riscv_rpmi.c b/hw/misc/riscv_rpmi.c
new file mode 100644
index 0000000000..3a30d879aa
--- /dev/null
+++ b/hw/misc/riscv_rpmi.c
@@ -0,0 +1,514 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * RISC-V RPMI transport device.
+ *
+ * Copyright (c) 2026 Qualcomm Technologies, Inc.
+ * Author:
+ *  Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/misc/riscv_rpmi.h"
+#include "hw/misc/riscv_rpmi_internal.h"
+#include "migration/vmstate.h"
+#include "system/address-spaces.h"
+#include "system/memory.h"
+#include "system/runstate.h"
+#include "librpmi.h"
+#include "librpmi_env.h"
+
+/*
+ * These functions implement the platform hooks declared by librpmi_env.h.
+ * See https://github.com/riscv-software-src/librpmi/blob/main/include/
+ * librpmi_env.h for the external hook declarations and their contract.
+ */
+void *rpmi_env_zalloc(rpmi_size_t size)
+{
+    return g_malloc0(size);
+}
+
+void rpmi_env_free(void *ptr)
+{
+    g_free(ptr);
+}
+
+void rpmi_env_writel(rpmi_uint64_t addr, rpmi_uint32_t val)
+{
+    MemTxResult result;
+
+    address_space_stl_le(&address_space_memory, addr, val,
+                         MEMTXATTRS_UNSPECIFIED, &result);
+    if (result != MEMTX_OK) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: failed write at 0x%" PRIx64
+                      " (result 0x%x)\n",
+                      __func__, (uint64_t)addr, result);
+    }
+}
+
+static enum rpmi_error riscv_rpmi_memtx_result_to_error(MemTxResult result)
+{
+    return result == MEMTX_OK ? RPMI_SUCCESS : RPMI_ERR_IO;
+}
+
+static bool riscv_rpmi_addr_in_range(uint64_t addr, uint32_t len,
+                                     uint64_t base, uint64_t size)
+{
+    return len && size >= len && addr >= base && addr - base <= size - len;
+}
+
+static enum rpmi_error shmem_qemu_read(void *priv, rpmi_uint64_t addr,
+                                       void *buf, rpmi_uint32_t len)
+{
+    RiscvRpmiState *s = RISCV_RPMI(priv);
+
+    if (!s || !buf ||
+        !riscv_rpmi_addr_in_range(addr, len, s->shmem_base,
+                                  s->shmem_size)) {
+        return RPMI_ERR_BAD_RANGE;
+    }
+
+    return riscv_rpmi_memtx_result_to_error(
+        address_space_read(&address_space_memory, addr,
+                           MEMTXATTRS_UNSPECIFIED, buf, len));
+}
+
+static enum rpmi_error shmem_qemu_write(void *priv, rpmi_uint64_t addr,
+                                       const void *buf, rpmi_uint32_t len)
+{
+    RiscvRpmiState *s = RISCV_RPMI(priv);
+
+    if (!s || !buf ||
+        !riscv_rpmi_addr_in_range(addr, len, s->shmem_base,
+                                  s->shmem_size)) {
+        return RPMI_ERR_BAD_RANGE;
+    }
+
+    return riscv_rpmi_memtx_result_to_error(
+        address_space_write(&address_space_memory, addr,
+                            MEMTXATTRS_UNSPECIFIED, buf, len));
+}
+
+static enum rpmi_error shmem_qemu_fill(void *priv, rpmi_uint64_t addr,
+                                       char ch, rpmi_uint32_t len)
+{
+    RiscvRpmiState *s = RISCV_RPMI(priv);
+
+    if (!s ||
+        !riscv_rpmi_addr_in_range(addr, len, s->shmem_base,
+                                  s->shmem_size)) {
+        return RPMI_ERR_BAD_RANGE;
+    }
+
+    return riscv_rpmi_memtx_result_to_error(
+        address_space_set(&address_space_memory, addr, (uint8_t)ch, len,
+                          MEMTXATTRS_UNSPECIFIED));
+}
+
+const struct rpmi_shmem_platform_ops rpmi_shmem_qemu_ops = {
+    .read = shmem_qemu_read,
+    .write = shmem_qemu_write,
+    .fill = shmem_qemu_fill,
+};
+
+static uint64_t riscv_rpmi_read(void *opaque, hwaddr offset, unsigned int size)
+{
+    RiscvRpmiState *s = opaque;
+
+    if (offset != 0 || size != 4) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid read at 0x%" HWADDR_PRIx " size %u\n",
+                      __func__, offset, size);
+        return 0;
+    }
+
+    return s->doorbell;
+}
+
+static bool riscv_rpmi_transport_indices_valid(RiscvRpmiState *s);
+
+static void riscv_rpmi_write(void *opaque, hwaddr offset, uint64_t value,
+                             unsigned int size)
+{
+    RiscvRpmiState *s = opaque;
+
+    if (offset != 0 || size != 4) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid write at 0x%" HWADDR_PRIx " size %u\n",
+                      __func__, offset, size);
+        return;
+    }
+
+    s->doorbell = value;
+
+    if (value == 1) {
+        if (s->context && riscv_rpmi_transport_indices_valid(s)) {
+            riscv_rpmi_context_process_a2p_request(s);
+        }
+        s->doorbell = 0;
+    }
+}
+
+static const MemoryRegionOps riscv_rpmi_ops = {
+    .read = riscv_rpmi_read,
+    .write = riscv_rpmi_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static bool riscv_rpmi_queue_indices_valid(RiscvRpmiState *s,
+                                           uint64_t queue_base,
+                                           uint32_t queue_size)
+{
+    uint8_t *shmem = memory_region_get_ram_ptr(&s->shmem);
+    uint32_t data_slots = queue_size / RPMI_QUEUE_SLOT_SIZE - 2;
+    uint32_t head;
+    uint32_t tail;
+
+    head = ldl_le_p(shmem + queue_base);
+    tail = ldl_le_p(shmem + queue_base + RPMI_QUEUE_SLOT_SIZE);
+    if (head >= data_slots || tail >= data_slots) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid queue indices head %u tail %u slots %u\n",
+                      __func__, head, tail, data_slots);
+        return false;
+    }
+
+    return true;
+}
+
+static bool riscv_rpmi_transport_indices_valid(RiscvRpmiState *s)
+{
+    if (!s->has_shmem || !s->a2p_req_size) {
+        return false;
+    }
+
+    if (!riscv_rpmi_queue_indices_valid(s, 0, s->a2p_req_size)) {
+        return false;
+    }
+
+    return riscv_rpmi_queue_indices_valid(s, s->a2p_req_size,
+                                          s->a2p_req_size);
+}
+
+static void riscv_rpmi_configure_base(RiscvRpmiState *s,
+                                      const RiscvRpmiConfig *cfg)
+{
+    s->platform_info = g_strdup(cfg->platform_info);
+    s->services = cfg->services;
+    s->service_count = cfg->service_count;
+
+    s->hart_count = cfg->hart_count;
+    if (cfg->hart_ids) {
+        s->hart_ids = g_memdup2(cfg->hart_ids,
+                                cfg->hart_count * sizeof(*cfg->hart_ids));
+    }
+}
+
+static void riscv_rpmi_init(Object *obj)
+{
+    RiscvRpmiState *s = RISCV_RPMI(obj);
+
+    memory_region_init_io(&s->mmio, obj, &riscv_rpmi_ops, s,
+                          TYPE_RISCV_RPMI, RPMI_DBREG_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+}
+
+static void riscv_rpmi_reset_hold(Object *obj, ResetType type)
+{
+    RiscvRpmiState *s = RISCV_RPMI(obj);
+
+    s->doorbell = 0;
+
+    if (s->has_shmem) {
+        memset(memory_region_get_ram_ptr(&s->shmem), 0, s->shmem_size);
+        memory_region_set_dirty(&s->shmem, 0, s->shmem_size);
+    }
+}
+
+static void riscv_rpmi_cleanup(RiscvRpmiState *s)
+{
+    if (s->context) {
+        rpmi_context_destroy(s->context);
+        s->context = NULL;
+    }
+
+    if (s->transport) {
+        rpmi_transport_shmem_destroy(s->transport);
+        s->transport = NULL;
+    }
+
+    if (s->rpmi_shmem) {
+        rpmi_shmem_destroy(s->rpmi_shmem);
+        s->rpmi_shmem = NULL;
+    }
+
+    if (s->has_shmem) {
+        memory_region_del_subregion(get_system_memory(), &s->shmem);
+        s->has_shmem = false;
+    }
+}
+
+bool riscv_rpmi_service_enabled(RiscvRpmiState *s,
+                                enum rpmi_servicegroup_id service_group)
+{
+    uint32_t i;
+
+    for (i = 0; i < s->service_count; i++) {
+        if (s->services[i].service_group == service_group) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
+void riscv_rpmi_context_process_a2p_request(RiscvRpmiState *s)
+{
+    if (s->context) {
+        rpmi_context_process_a2p_request(s->context);
+    }
+}
+
+static bool riscv_rpmi_validate_config(RiscvRpmiState *s, Error **errp)
+{
+    uint64_t queue_bytes;
+
+    if (!s->shmem_size) {
+        error_setg(errp, "RPMI shared memory size must be non-zero");
+        return false;
+    }
+
+    if (s->shmem_base & (RPMI_QUEUE_SLOT_SIZE - 1)) {
+        error_setg(errp, "RPMI shared memory base must be %u-byte aligned",
+                   RPMI_QUEUE_SLOT_SIZE);
+        return false;
+    }
+
+    if (s->a2p_req_size < RPMI_DATA_SLOT_SIZE) {
+        error_setg(errp,
+                   "RPMI A2P request queue needs at least one data slot");
+        return false;
+    }
+
+    if (!s->hart_count || !s->hart_ids) {
+        error_setg(errp, "RPMI transport requires hart IDs");
+        return false;
+    }
+
+    for (uint32_t i = 0; i < s->hart_count; i++) {
+        for (uint32_t j = i + 1; j < s->hart_count; j++) {
+            if (s->hart_ids[i] == s->hart_ids[j]) {
+                error_setg(errp, "RPMI hart ID %u is duplicated",
+                           s->hart_ids[i]);
+                return false;
+            }
+        }
+    }
+
+    if (s->service_count && !s->services) {
+        error_setg(errp, "RPMI service count requires service descriptors");
+        return false;
+    }
+
+    if (s->a2p_req_size % RPMI_QUEUE_SLOT_SIZE) {
+        error_setg(errp,
+                   "RPMI A2P request queue size must be a multiple of %u",
+                   RPMI_QUEUE_SLOT_SIZE);
+        return false;
+    }
+
+    if (s->p2a_req_size &&
+        s->p2a_req_size < RPMI_DATA_SLOT_SIZE) {
+        error_setg(errp,
+                   "RPMI P2A request queue needs at least one data slot");
+        return false;
+    }
+
+    if (s->p2a_req_size % RPMI_QUEUE_SLOT_SIZE) {
+        error_setg(errp,
+                   "RPMI P2A request queue size must be a multiple of %u",
+                   RPMI_QUEUE_SLOT_SIZE);
+        return false;
+    }
+
+    queue_bytes = 2 * (uint64_t)s->a2p_req_size +
+                  2 * (uint64_t)s->p2a_req_size;
+    if (queue_bytes > s->shmem_size) {
+        error_setg(errp,
+                   "RPMI shared memory size 0x%" PRIx64
+                   " is too small for queues 0x%" PRIx64,
+                   s->shmem_size, queue_bytes);
+        return false;
+    }
+
+    return true;
+}
+
+static bool riscv_rpmi_add_service_group(RiscvRpmiState *s,
+                                         const RiscvRpmiServiceConfig *service,
+                                         Error **errp)
+{
+    error_setg(errp, "unsupported RPMI service group %u",
+               service->service_group);
+    return false;
+}
+
+static bool riscv_rpmi_init_services(RiscvRpmiState *s, Error **errp)
+{
+    uint32_t i;
+
+    for (i = 0; i < s->service_count; i++) {
+        if (!riscv_rpmi_add_service_group(s, &s->services[i], errp)) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
+static bool riscv_rpmi_init_context(RiscvRpmiState *s, Error **errp)
+{
+    const char *platform_info = s->platform_info ?: RPMI_PLAT_INFO;
+
+    s->rpmi_shmem = rpmi_shmem_create("rpmi-shmem", s->shmem_base,
+                                      s->shmem_size,
+                                      &rpmi_shmem_qemu_ops, s);
+    if (!s->rpmi_shmem) {
+        error_setg(errp, "failed to create RPMI shared memory backend");
+        return false;
+    }
+
+    s->transport = rpmi_transport_shmem_create("rpmi-shmem-transport",
+                                               RPMI_QUEUE_SLOT_SIZE,
+                                               s->a2p_req_size,
+                                               s->p2a_req_size,
+                                               s->rpmi_shmem);
+    if (!s->transport) {
+        error_setg(errp, "failed to create RPMI shared memory transport");
+        return false;
+    }
+
+    s->context = rpmi_context_create("rpmi-virt", s->transport,
+                                     RPMI_SRVGRP_ID_MAX_COUNT,
+                                     RPMI_PRIVILEGE_M_MODE,
+                                     strlen(platform_info) + 1,
+                                     platform_info);
+    if (!s->context) {
+        error_setg(errp, "failed to create RPMI context");
+        return false;
+    }
+
+    return riscv_rpmi_init_services(s, errp);
+}
+
+static void riscv_rpmi_realize(DeviceState *dev, Error **errp)
+{
+    RiscvRpmiState *s = RISCV_RPMI(dev);
+    g_autofree char *name = NULL;
+
+    if (!riscv_rpmi_validate_config(s, errp)) {
+        return;
+    }
+
+    name = g_strdup_printf("rpmi-shmem@%" PRIx64, s->shmem_base);
+    if (!memory_region_init_ram(&s->shmem, OBJECT(dev), name, s->shmem_size,
+                                errp)) {
+        return;
+    }
+
+    memory_region_add_subregion(get_system_memory(), s->shmem_base, &s->shmem);
+    s->has_shmem = true;
+
+    if (!riscv_rpmi_init_context(s, errp)) {
+        riscv_rpmi_cleanup(s);
+    }
+}
+
+static void riscv_rpmi_unrealize(DeviceState *dev)
+{
+    riscv_rpmi_cleanup(RISCV_RPMI(dev));
+}
+
+static const VMStateDescription riscv_rpmi_vmstate = {
+    .name = TYPE_RISCV_RPMI,
+    .unmigratable = 1,
+};
+
+static const Property riscv_rpmi_properties[] = {
+    DEFINE_PROP_UINT64("shmem-base", RiscvRpmiState, shmem_base, 0),
+    DEFINE_PROP_UINT64("shmem-size", RiscvRpmiState, shmem_size, 0),
+    DEFINE_PROP_UINT32("a2p-req-size", RiscvRpmiState, a2p_req_size, 0),
+    DEFINE_PROP_UINT32("p2a-req-size", RiscvRpmiState, p2a_req_size, 0),
+};
+
+static void riscv_rpmi_finalize(Object *obj)
+{
+    RiscvRpmiState *s = RISCV_RPMI(obj);
+
+    g_free(s->platform_info);
+    g_free(s->hart_ids);
+}
+
+static void riscv_rpmi_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->realize = riscv_rpmi_realize;
+    dc->unrealize = riscv_rpmi_unrealize;
+    dc->vmsd = &riscv_rpmi_vmstate;
+    rc->phases.hold = riscv_rpmi_reset_hold;
+    device_class_set_props(dc, riscv_rpmi_properties);
+}
+
+static const TypeInfo riscv_rpmi_info = {
+    .name          = TYPE_RISCV_RPMI,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RiscvRpmiState),
+    .instance_init = riscv_rpmi_init,
+    .instance_finalize = riscv_rpmi_finalize,
+    .class_init    = riscv_rpmi_class_init,
+};
+
+static void riscv_rpmi_register_types(void)
+{
+    type_register_static(&riscv_rpmi_info);
+}
+
+type_init(riscv_rpmi_register_types)
+
+DeviceState *riscv_rpmi_create(const RiscvRpmiConfig *cfg, Error **errp)
+{
+    DeviceState *dev;
+    RiscvRpmiState *s;
+
+    if (!cfg) {
+        error_setg(errp, "missing RPMI configuration");
+        return NULL;
+    }
+
+    dev = qdev_new(TYPE_RISCV_RPMI);
+    qdev_prop_set_uint64(dev, "shmem-base", cfg->shmem_base);
+    qdev_prop_set_uint64(dev, "shmem-size", cfg->shmem_size);
+    qdev_prop_set_uint32(dev, "a2p-req-size", cfg->a2p_req_size);
+    qdev_prop_set_uint32(dev, "p2a-req-size", cfg->p2a_req_size);
+
+    s = RISCV_RPMI(dev);
+    riscv_rpmi_configure_base(s, cfg);
+
+    if (!sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), errp)) {
+        return NULL;
+    }
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, cfg->doorbell_base);
+    return dev;
+}
diff --git a/hw/misc/riscv_rpmi_internal.h b/hw/misc/riscv_rpmi_internal.h
new file mode 100644
index 0000000000..95aa8dec14
--- /dev/null
+++ b/hw/misc/riscv_rpmi_internal.h
@@ -0,0 +1,25 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * RISC-V RPMI internal service helpers.
+ *
+ * Copyright (c) 2026 Qualcomm Technologies, Inc.
+ * Author:
+ *  Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
+ */
+
+#ifndef HW_MISC_RISCV_RPMI_INTERNAL_H
+#define HW_MISC_RISCV_RPMI_INTERNAL_H
+
+#include "qapi/error.h"
+#include "hw/misc/riscv_rpmi.h"
+#include "librpmi.h"
+
+#define RPMI_PLAT_INFO "QEMU RISC-V RPMI"
+
+extern const struct rpmi_shmem_platform_ops rpmi_shmem_qemu_ops;
+bool riscv_rpmi_service_enabled(RiscvRpmiState *s,
+                                enum rpmi_servicegroup_id service_group);
+void riscv_rpmi_context_process_a2p_request(RiscvRpmiState *s);
+
+#endif
diff --git a/include/hw/misc/riscv_rpmi.h b/include/hw/misc/riscv_rpmi.h
new file mode 100644
index 0000000000..c207501405
--- /dev/null
+++ b/include/hw/misc/riscv_rpmi.h
@@ -0,0 +1,92 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * RISC-V RPMI definitions shared by RPMI transport and FDT helpers.
+ *
+ * Copyright (c) 2026 Qualcomm Technologies, Inc.
+ * Author:
+ *  Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
+ */
+
+#ifndef HW_MISC_RISCV_RPMI_H
+#define HW_MISC_RISCV_RPMI_H
+
+#include "exec/hwaddr.h"
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#ifdef CONFIG_LIBRPMI
+#include "librpmi.h"
+#else
+enum rpmi_servicegroup_id {
+    RPMI_SRVGRP_SYSTEM_RESET = 0x0003,
+    RPMI_SRVGRP_SYSTEM_SUSPEND = 0x0004,
+    RPMI_SRVGRP_HSM = 0x0005,
+};
+#endif
+
+#define RPMI_QUEUE_SLOT_SIZE 64
+/* Minimum queue size: head, tail, and one data slot. */
+#define RPMI_DATA_SLOT_SIZE  (3 * RPMI_QUEUE_SLOT_SIZE)
+#define RPMI_DBREG_SIZE      0x1000
+
+#define RPMI_ALL_NUM_QUEUES 4
+#define RPMI_A2P_NUM_QUEUES 2
+#define RPMI_ALL_NUM_REGS   (RPMI_ALL_NUM_QUEUES + 1)
+#define RPMI_A2P_NUM_REGS   (RPMI_A2P_NUM_QUEUES + 1)
+
+#define TYPE_RISCV_RPMI "riscv-rpmi"
+OBJECT_DECLARE_SIMPLE_TYPE(RiscvRpmiState, RISCV_RPMI)
+
+struct rpmi_context;
+struct rpmi_service_group;
+struct rpmi_shmem;
+struct rpmi_transport;
+
+typedef struct RiscvRpmiServiceConfig {
+    const char *node_name;
+    const char *compatible;
+    enum rpmi_servicegroup_id service_group;
+    bool has_mpxy_channel;
+    uint32_t mpxy_channel;
+} RiscvRpmiServiceConfig;
+
+typedef struct RiscvRpmiConfig {
+    hwaddr doorbell_base;
+    hwaddr shmem_base;
+    hwaddr shmem_size;
+    uint32_t a2p_req_size;
+    uint32_t p2a_req_size;
+    const char *platform_info;
+
+    const uint32_t *hart_ids;
+    uint32_t hart_count;
+    const RiscvRpmiServiceConfig *services;
+    uint32_t service_count;
+} RiscvRpmiConfig;
+
+struct RiscvRpmiState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+    MemoryRegion shmem;
+    uint64_t shmem_base;
+    uint64_t shmem_size;
+    uint32_t a2p_req_size;
+    uint32_t p2a_req_size;
+    char *platform_info;
+
+    uint32_t *hart_ids;
+    uint32_t hart_count;
+    const RiscvRpmiServiceConfig *services;
+    uint32_t service_count;
+    uint32_t doorbell;
+    struct rpmi_shmem *rpmi_shmem;
+    struct rpmi_transport *transport;
+    struct rpmi_context *context;
+    bool has_shmem;
+};
+
+DeviceState *riscv_rpmi_create(const RiscvRpmiConfig *cfg, Error **errp);
+
+#endif

