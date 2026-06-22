Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA3BCD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 19:33:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbkNn-0000e8-21; Mon, 22 Jun 2026 15:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbkNl-0000d7-2D
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:32:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbkNj-0001qH-8p
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:32:32 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MFVlix1010023
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:32:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=0MXkkvCouPl
 0quvEFxVeopBQWkMIV20QUWyTYuKd1HE=; b=DMB8GBNTtRVClgNs6rVtUNhHzq9
 g9ZU+ygAX1i6xNWktr1hXjs+aGP/78z1/P2RwVZW5Dn1z+fdmAGiQGZEczMsSYU0
 gM+L7wdMzRKt/C2CHQ2PXlL+l0AQqTZsC8WndxKPVLEJ7yYU+vTeQDzIQXkwG06y
 AqZk9Y3HXfKHmiV6N1msQzbsXK6gPDBf03yEQRF582f+VAqRwsieXHONJ50V5heb
 +bsKpvyUrijAdI78n8X31mngXcYRgvs1uu0ChJjVyPkCm8NByqVRZXD3yreg0QAR
 /Y9wgTObGX2jUtX8fsAOqxg+Se1lELmDl01rZVC/YrB7ds16Bz+XNcpBHyg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey3a0sypu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:32:19 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-91576c147a4so1191908485a.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 12:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782156739; x=1782761539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0MXkkvCouPl0quvEFxVeopBQWkMIV20QUWyTYuKd1HE=;
 b=HNKCAHbErsl60hQv1NVzEy18yJlin9xHPIcfmx9lJoy8ODMXQ2W9DDw85p3QBApMDo
 fKT1XEujlrTPF97OHJOL3zFKd0MEv3ANiHY83vE0PEx8gHRgL0spUf1Kaopd9Hu22V3P
 7PZm9nmx9oRrLX1Ef/PVzDLTzV5Vomg6cHFAt9wWGXb26B9PigfivTeohccIh1AhEV4c
 Tk5vxQRZiPFEgljVWtdocRY7HN/KhQ1kOEkMeQpPRK+/oouIdbfMrfcAbdwPO3X3Oh5+
 9KbjDmZtvwVugZGyakDY8nA018X9/QJVB1MYAO/naFC5e+3rn72DfiW0KxvMqYujTfYW
 zLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782156739; x=1782761539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0MXkkvCouPl0quvEFxVeopBQWkMIV20QUWyTYuKd1HE=;
 b=cpCtb41sNDwalTfrMzXKD2uZrbq4UZh/9GHVZT2FITR2W20TJ61GWIw7fvS+imqPYf
 9KxH9lm+i+N7vtlDUrElB8QqO3Gd2V+EOJe6U1H0R1DoVUT2Ch5vr/8uCFXJXHqV93Rp
 jXX0t9tYLNknE3x2JonGJ7AKqgcWuLnx2Vl6DSOhfoOtWRQdIK3f1oVIDI3XftA8o1E0
 9cwjIr/2Ct6uynYJpU6yVKAl2upRq/at+d+5xxyrhCBSqA050KdldNLZG8x7/VX9HMUf
 nmRlfB9Lq2nwUSSqRBV0eNZ2EsY1zzhCOlrlcSqg3bQaOCrx8Wsaxb+YZUt8N/6DOpmF
 NOoA==
X-Gm-Message-State: AOJu0YxiFfIadRbUi6nLEjJn1ctx1Pc+J7nUXnjxuwTxkyzzFFC1WuED
 itg9/7ZbPwQ1QpjXvDDhyrmFcxvjGpKJVFj45RHiaxg+z2+/7Xy9JfJKpBtbtpgqtVk1kFnmia/
 VNIVNX50ZSa9T/D8MvkUqfab3/av8TQBhN7s1HsJ5lya6UGy5dB0SEEU4sT+aCksRAQ==
X-Gm-Gg: AfdE7cli9TNUuiP+eM+7CNijUlohcBs+eojLboF7ljVkEql7ta9zB27NoG/hL8bFfMW
 Nyc8ijN2qG63F50+E29ncKIoQJyVsiGXGbLsGDgLxB/WNS0UK4993LZ1eK0JGZkdMLoA0Dyyd+i
 IQ/P4pITe7xQOXqH7HAwMxdGJmy0+qXrq6/iL04MZ8NYMdfICNELdypSxRonGMkMI0GWqvKVM+E
 AezoLNIdzlStIUNp15YMEElxqN/jLAhLWlejwxyENI+in1fSmIHGmosinf9N9zK/CXQM98zXXsY
 /9YnOa1PP2B/dU0KVsRz1nlsCpa6YjRJoWz4glWc2PC43r01YN3Zqi/Mg73OksX8Zmke9Po7ASh
 ATK7KzVHWov8+Rkq5RuPO/r72jk9E+JxEpErsMkhQNVKA9A==
X-Received: by 2002:a05:620a:4890:b0:915:a3d2:288a with SMTP id
 af79cd13be357-92091f5337bmr2448993085a.40.1782156738410; 
 Mon, 22 Jun 2026 12:32:18 -0700 (PDT)
X-Received: by 2002:a05:620a:4890:b0:915:a3d2:288a with SMTP id
 af79cd13be357-92091f5337bmr2448985685a.40.1782156737838; 
 Mon, 22 Jun 2026 12:32:17 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-926004ab49csm61489585a.34.2026.06.22.12.32.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 12:32:17 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 philmd@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 09/24] target/riscv: move csr.h to tcg subdir
Date: Mon, 22 Jun 2026 16:31:25 -0300
Message-ID: <20260622193141.1449724-10-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE4OSBTYWx0ZWRfX3gerU4OtXNsx
 haF21qy2aLWwBhkPbzXKU6Wg4Ti6dZ24WcDONe8bmFta2acSZ0cMlc2hFZs9pvvNTZ6xyZBNdM9
 u26EbSbeBnv47CyTeYIdVVRJafzEztI=
X-Proofpoint-GUID: ECF-FPFdH9Zw1EtgVIUQxeqwEW205Ru6
X-Authority-Analysis: v=2.4 cv=UJ7t2ify c=1 sm=1 tr=0 ts=6a398dc3 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=82-PFmB8izlBMBISFaoA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE4OSBTYWx0ZWRfX/uIcfZHJ5uKj
 GIPqzfUzxPUhkhjdzOxhHgWL9TNEW5ok1Ny0lJN/9zuNX1TvkZ3qkQSEQ3vmJ59GFZkrgKx/ij+
 KO3L2Gzu5yOpbBRjs8axV+l72j4+l9eCo5pydyp+c1xlLCyhvETDNiLE3iCMcuGMRuN6ZKvFMKX
 IZ49N16wi8hDcT3C32xnQVUmtUCoz2lEji2KHNR4W1vgTQaeKzq3D3mmTqFlUNi37cO2dket4jM
 Ccr708ke2HVv9NWlc2mt3YNHKuS0Ddrgu0djMmp8lG/9ZWixrXvrHpwQhur3t5Ct1XSme1olYFt
 1mtVSXQkdoZUzD2hh81bwd0F5u8Zm9XZD8DQmRWhDM0tA63KjFCY22t+IsETwMvLijjB8VAfuSw
 /vz3KgOI4+aKNkOADCudmB/deTXTSike+IRvlJJ4XqB0I4NxwGrhps8qwM++JkG3sna1MGFNASy
 L9UktlO8Z1qr6vwAyHA==
X-Proofpoint-ORIG-GUID: ECF-FPFdH9Zw1EtgVIUQxeqwEW205Ru6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220189
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

After KVM is no longer reliant on csr.h move it to the TGC only land.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.c            | 2 +-
 target/riscv/gdbstub.c        | 2 +-
 target/riscv/monitor.c        | 2 +-
 target/riscv/riscv-qmp-cmds.c | 2 +-
 target/riscv/tcg/csr.c        | 2 +-
 target/riscv/{ => tcg}/csr.h  | 0
 target/riscv/tcg/mips_csr.c   | 2 +-
 target/riscv/tcg/op_helper.c  | 2 +-
 target/riscv/tcg/pmp.c        | 2 +-
 target/riscv/tcg/th_csr.c     | 2 +-
 10 files changed, 9 insertions(+), 9 deletions(-)
 rename target/riscv/{ => tcg}/csr.h (100%)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8fe524be21..503b96bf2e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -24,7 +24,7 @@
 #include "qemu/guest-random.h"
 #include "cpu.h"
 #include "cpu_vendorid.h"
-#include "target/riscv/csr.h"
+#include "target/riscv/tcg/csr.h"
 #include "internals.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index a2bbaf7f07..f0a5e0d86f 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -21,7 +21,7 @@
 #include "gdbstub/helpers.h"
 #include "cpu.h"
 #include "internals.h"
-#include "target/riscv/csr.h"
+#include "target/riscv/tcg/csr.h"
 
 struct TypeSize {
     const char *gdb_type;
diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
index 7aacd1d89c..f8042db9cd 100644
--- a/target/riscv/monitor.c
+++ b/target/riscv/monitor.c
@@ -22,7 +22,7 @@
 #include "qemu/ctype.h"
 #include "qemu/qemu-print.h"
 #include "cpu.h"
-#include "target/riscv/csr.h"
+#include "target/riscv/tcg/csr.h"
 #include "cpu_bits.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index b94e8391ed..2647deef91 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -35,7 +35,7 @@
 #include "system/tcg.h"
 #include "cpu-qom.h"
 #include "cpu.h"
-#include "target/riscv/csr.h"
+#include "target/riscv/tcg/csr.h"
 
 static void riscv_cpu_add_definition(gpointer data, gpointer user_data)
 {
diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index d447204721..572a39d660 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -21,7 +21,7 @@
 #include "qemu/log.h"
 #include "qemu/timer.h"
 #include "cpu.h"
-#include "target/riscv/csr.h"
+#include "target/riscv/tcg/csr.h"
 #include "tcg/tcg-cpu.h"
 #include "pmu.h"
 #include "time_helper.h"
diff --git a/target/riscv/csr.h b/target/riscv/tcg/csr.h
similarity index 100%
rename from target/riscv/csr.h
rename to target/riscv/tcg/csr.h
diff --git a/target/riscv/tcg/mips_csr.c b/target/riscv/tcg/mips_csr.c
index 609718f288..884030e91d 100644
--- a/target/riscv/tcg/mips_csr.c
+++ b/target/riscv/tcg/mips_csr.c
@@ -10,7 +10,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "cpu_vendorid.h"
-#include "target/riscv/csr.h"
+#include "target/riscv/tcg/csr.h"
 
 /* Static MIPS CSR state storage */
 static struct {
diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
index 775fd431d6..003f6ebb31 100644
--- a/target/riscv/tcg/op_helper.c
+++ b/target/riscv/tcg/op_helper.c
@@ -20,7 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "target/riscv/csr.h"
+#include "target/riscv/tcg/csr.h"
 #include "internals.h"
 #include "exec/cputlb.h"
 #include "accel/tcg/cpu-ldst.h"
diff --git a/target/riscv/tcg/pmp.c b/target/riscv/tcg/pmp.c
index d93563c36b..41b55519a8 100644
--- a/target/riscv/tcg/pmp.c
+++ b/target/riscv/tcg/pmp.c
@@ -23,7 +23,7 @@
 #include "qemu/log.h"
 #include "qapi/error.h"
 #include "cpu.h"
-#include "target/riscv/csr.h"
+#include "target/riscv/tcg/csr.h"
 #include "trace.h"
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
diff --git a/target/riscv/tcg/th_csr.c b/target/riscv/tcg/th_csr.c
index 431f4cc286..e6f642991c 100644
--- a/target/riscv/tcg/th_csr.c
+++ b/target/riscv/tcg/th_csr.c
@@ -22,7 +22,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "cpu_vendorid.h"
-#include "target/riscv/csr.h"
+#include "target/riscv/tcg/csr.h"
 
 /* Extended M-mode control registers of T-Head */
 #define CSR_TH_MXSTATUS        0x7c0
-- 
2.43.0


