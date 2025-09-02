Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5ACECA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI0P-0007E4-V8; Mon, 01 Sep 2025 23:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI0B-0006wK-KT
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:48:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI09-0004Va-8u
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:48:11 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822Rocf015191
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:47:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IdziyhW8bvH1MYLMe4rnaSvqOmugalOcZvKkqKiOXow=; b=mqvcJjR/eBqIXgXh
 r6F+6wQTq27q9V1ZM+0yD/qj65Ju1VjgMiIxt8Q4cQwdZ+Hkax847PXGynx4JX4l
 RNW2KEiuaA2jI77XTxY6n8sdCpAPM20d6CgMb1HVsL6wOfTJ1uNkI4mgIG22ucmp
 rphpY3O37cUMcTJ3TJ2x7shoZmw/SisDuQ1FSwVcO31Y3H3jlwPkMWN2d9PWCCBs
 +w9DNN+xCIbkjqqQIeEj6OwGAwGkMqN5i8fOrmoJUjp3z8T9wdYBMPe3YnTbCOKe
 dGmugkjgERMr++SUAgEZGC/KsbRf9frk35puS3q5U/USMGX35WCFD4vV9P536JSo
 Twofww==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urvyxdf8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:47:55 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b4cf03610fdso5202944a12.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784874; x=1757389674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IdziyhW8bvH1MYLMe4rnaSvqOmugalOcZvKkqKiOXow=;
 b=h8amrZMC5mDEMYZ0EWsvlYYdsK6FIiFgaG2vjwZtWlPtrakBfsF6UPW5lDnkr0AlOu
 N+xIDtpI5n1zQt+6ip1wiWAz0+i1ngoBmhcUA9u1a4zxyi/tPbPFBTrYtKnka38H8Rd2
 gQnr1C7/DyJEjbpwWEcNbWg27+5HeYq4LVGH/f3jSulaMYxa1y3rhpQ62fMcxgW4g7bV
 dtAD5X2ui5MkGiQDwZnA9npKGkq+0KzqdukGdJ6WKWx1JCfNMUGGe46zw/6TOn7LaikY
 XXkDwGKMyPWzhiwIeeElsfxT4do9ts72SFqGtV7+LNdNLk/TvVRi32r/I1VzamEZ/LCo
 GxZA==
X-Gm-Message-State: AOJu0YxVUuACeJ2nicx3+CwF8gOfj8sSBSfD7QGsjUI+5qTXCvUFWq1r
 Gs98dq61rp9jmsHcTvXvGPJx5SdIXHe2Djc9hjDAlRxeutdTQi8Ct2T2J1sLPlrhmLcE1aYx2f9
 oYnNA+av2NbZFlkJ0vF9tqAh8Kx+JaCXJi3NjwYXqFhwCnN7kYlDrmCfcP7G5LN3tK2LX
X-Gm-Gg: ASbGncuQnFN2rN1IKFDGm1CNiWvs+tWhau0nIRdvDqFxN+gzyIaH7dSF/3K0MhjWDGX
 UmELt7Tfwt3uWF2hb+BCU/sYOUsuvyRaRCSmWtv03S/PHScSscdbKQGkOjKywFxAvRZ7vPWDcYG
 NhYCeRsbrSmtLgYhCLINyY5FMu9SRmk1fvslw1V2rnMSCiKpNHuX2nFh2HVPR1FKffjSmjt/MyH
 ss/Hom9u4JQLY+G+0zImEOHQ1TwuxKGjk0K36t7CrxUkv5aX7Kh2a6q8B+8Nv21wOjMFWx/zBER
 DlFEUiCN0l1kqgpchXJyBeDXCkFzWRRD3p9MFT1RU5TneMAhjaaXbpwu/ScjEj6qU6PjmKl0+u4
 iX14xj8JiVSX0
X-Received: by 2002:a05:6a20:430f:b0:243:c171:479c with SMTP id
 adf61e73a8af0-243d6f41061mr14742809637.45.1756784873432; 
 Mon, 01 Sep 2025 20:47:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGXjkMCMPsSxiS8nHZai1h79bXHWaZgZPK0F7o48NFgPii741z1PsWNMmXC3+GEkP1cxzBVA==
X-Received: by 2002:a05:6a20:430f:b0:243:c171:479c with SMTP id
 adf61e73a8af0-243d6f41061mr14742762637.45.1756784872819; 
 Mon, 01 Sep 2025 20:47:52 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006e2c6sm10633584a12.2.2025.09.01.20.47.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:47:52 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 26/40] target/hexagon: Add sysemu TCG overrides
Date: Mon,  1 Sep 2025 20:47:01 -0700
Message-Id: <20250902034715.1947718-27-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
References: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: iHxtzovktYknfKLv8rf0p_bOA0e9QxdV
X-Proofpoint-ORIG-GUID: iHxtzovktYknfKLv8rf0p_bOA0e9QxdV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfXwgKoCz6VDP97
 xY+RGdsBkZu0Zce7bdVpLpQoKvWv2bxrNZSrObLB2WkwAcROMb/6ol7Y6RCbpUaaTNkQICwMhUY
 kwKIqT6tnGNWSTfcERVni45SvuXqG8FDCk0Uir66Hk54nHZ1R8CXmpV5zBl2eP5EOCPp1V1rIed
 1FyDF4a2H7oClM5Ysn6EJ67pkBm6uHWRKirmTokDs59yTBZx1/yj/So5Duu8csj+pFgcr2eimcT
 RLVGJ0lYA8opyXKTRsv9vkyXEXRhHbKJGgWlWdGCstzckpkVdzJ6kAMmyJLfvlkBy23xZaM/mip
 9OvSeNHWk9Yk1D7ZEs9o4Qn3pwBAbCcsqUh4YgpaC/PQjTtSlGTeMaac+UPd0+EqwuhzygBdW9o
 NjHK4wWy
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68b668eb cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=HqZiMnzhU5f-EeqCw14A:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Brian Cain <bcain@quicinc.com>

Define TCG overrides for setprio(), crswap(,sgp{0,1,1:0}).

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/cpu_helper.h  | 32 ++++++++++++++++++++++++++++
 target/hexagon/gen_tcg_sys.h | 41 ++++++++++++++++++++++++++++++++++++
 target/hexagon/helper.h      |  1 +
 target/hexagon/cpu_helper.c  | 38 +++++++++++++++++++++++++++++++++
 target/hexagon/genptr.c      |  4 ++++
 target/hexagon/op_helper.c   |  7 ++++++
 target/hexagon/hex_common.py |  2 ++
 target/hexagon/meson.build   | 14 ++++++------
 8 files changed, 133 insertions(+), 6 deletions(-)
 create mode 100644 target/hexagon/cpu_helper.h
 create mode 100644 target/hexagon/gen_tcg_sys.h
 create mode 100644 target/hexagon/cpu_helper.c

diff --git a/target/hexagon/cpu_helper.h b/target/hexagon/cpu_helper.h
new file mode 100644
index 0000000000..194bcbf451
--- /dev/null
+++ b/target/hexagon/cpu_helper.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright(c) 2019-2025 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HEXAGON_CPU_HELPER_H
+#define HEXAGON_CPU_HELPER_H
+
+static inline void arch_set_thread_reg(CPUHexagonState *env, uint32_t reg,
+                                       uint32_t val)
+{
+    g_assert(reg < TOTAL_PER_THREAD_REGS);
+    g_assert_not_reached();
+}
+
+static inline uint32_t arch_get_thread_reg(CPUHexagonState *env, uint32_t reg)
+{
+    g_assert(reg < TOTAL_PER_THREAD_REGS);
+    g_assert_not_reached();
+}
+
+static inline void arch_set_system_reg(CPUHexagonState *env, uint32_t reg,
+                                       uint32_t val)
+{
+    g_assert_not_reached();
+}
+
+uint32_t arch_get_system_reg(CPUHexagonState *env, uint32_t reg);
+
+#endif
+
diff --git a/target/hexagon/gen_tcg_sys.h b/target/hexagon/gen_tcg_sys.h
new file mode 100644
index 0000000000..362703ab45
--- /dev/null
+++ b/target/hexagon/gen_tcg_sys.h
@@ -0,0 +1,41 @@
+/*
+ * Copyright(c) 2022-2025 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HEXAGON_GEN_TCG_SYS_H
+#define HEXAGON_GEN_TCG_SYS_H
+
+#define fGEN_TCG_Y2_setprio(SHORTCODE) \
+    gen_helper_setprio(tcg_env, PtV, RsV)
+
+#define fGEN_TCG_Y2_crswap0(SHORTCODE) \
+    do { \
+        TCGv tmp = tcg_temp_new(); \
+        tcg_gen_mov_tl(tmp, RxV); \
+        tcg_gen_mov_tl(RxV, hex_t_sreg[HEX_SREG_SGP0]); \
+        tcg_gen_mov_tl(ctx->t_sreg_new_value[HEX_SREG_SGP0], tmp); \
+    } while (0)
+
+#define fGEN_TCG_Y4_crswap1(SHORTCODE) \
+    do { \
+        TCGv tmp = tcg_temp_new(); \
+        tcg_gen_mov_tl(tmp, RxV); \
+        tcg_gen_mov_tl(RxV, hex_t_sreg[HEX_SREG_SGP1]); \
+        tcg_gen_mov_tl(ctx->t_sreg_new_value[HEX_SREG_SGP1], tmp); \
+    } while (0)
+
+#define fGEN_TCG_Y4_crswap10(SHORTCODE) \
+    do { \
+        g_assert_not_reached(); \
+        TCGv_i64 tmp = tcg_temp_new_i64(); \
+        tcg_gen_mov_i64(tmp, RxxV); \
+        tcg_gen_concat_i32_i64(RxxV, \
+                               hex_t_sreg[HEX_SREG_SGP0], \
+                               hex_t_sreg[HEX_SREG_SGP1]); \
+        tcg_gen_extrl_i64_i32(ctx->t_sreg_new_value[HEX_SREG_SGP0], tmp); \
+        tcg_gen_extrh_i64_i32(ctx->t_sreg_new_value[HEX_SREG_SGP1], tmp); \
+    } while (0)
+
+#endif
diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
index fddbd99a19..146f4f02e4 100644
--- a/target/hexagon/helper.h
+++ b/target/hexagon/helper.h
@@ -115,4 +115,5 @@ DEF_HELPER_2(greg_read, i32, env, i32)
 DEF_HELPER_2(greg_read_pair, i64, env, i32)
 DEF_HELPER_3(sreg_write, void, env, i32, i32)
 DEF_HELPER_3(sreg_write_pair, void, env, i32, i64)
+DEF_HELPER_3(setprio, void, env, i32, i32)
 #endif
diff --git a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c
new file mode 100644
index 0000000000..01fdd6b28d
--- /dev/null
+++ b/target/hexagon/cpu_helper.c
@@ -0,0 +1,38 @@
+/*
+ * Copyright(c) 2019-2025 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "cpu_helper.h"
+#include "system/cpus.h"
+#ifdef CONFIG_USER_ONLY
+#include "qemu.h"
+#include "exec/helper-proto.h"
+#else
+#include "hw/boards.h"
+#include "hw/hexagon/hexagon.h"
+#endif
+#include "exec/cpu-interrupt.h"
+#include "exec/target_page.h"
+#include "accel/tcg/cpu-ldst.h"
+#include "exec/cputlb.h"
+#include "qemu/log.h"
+#include "tcg/tcg-op.h"
+#include "internal.h"
+#include "macros.h"
+#include "sys_macros.h"
+#include "arch.h"
+
+
+#ifndef CONFIG_USER_ONLY
+
+uint32_t arch_get_system_reg(CPUHexagonState *env, uint32_t reg)
+{
+    g_assert_not_reached();
+}
+
+
+#endif
diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
index a474787816..0648daefb6 100644
--- a/target/hexagon/genptr.c
+++ b/target/hexagon/genptr.c
@@ -31,6 +31,10 @@
 #undef QEMU_GENERATE
 #include "gen_tcg.h"
 #include "gen_tcg_hvx.h"
+#ifndef CONFIG_USER_ONLY
+#include "gen_tcg_sys.h"
+#endif
+
 #include "genptr.h"
 
 TCGv gen_read_reg(TCGv result, int num)
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index cbbf3048a0..cfd34d8712 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -31,6 +31,7 @@
 #include "mmvec/mmvec.h"
 #include "mmvec/macros.h"
 #include "op_helper.h"
+#include "cpu_helper.h"
 #include "translate.h"
 
 #define SF_BIAS        127
@@ -1366,6 +1367,12 @@ uint64_t HELPER(greg_read_pair)(CPUHexagonState *env, uint32_t reg)
 {
     g_assert_not_reached();
 }
+
+void HELPER(setprio)(CPUHexagonState *env, uint32_t thread, uint32_t prio)
+{
+    g_assert_not_reached();
+}
+
 #endif
 
 
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index 24139cbe67..009b71f8e6 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -1361,6 +1361,7 @@ def parse_common_args(desc):
     parser.add_argument("semantics", help="semantics file")
     parser.add_argument("overrides", help="overrides file")
     parser.add_argument("overrides_vec", help="vector overrides file")
+    parser.add_argument("overrides_sys", help="system overrides file")
     parser.add_argument("out", help="output file")
     parser.add_argument("--idef-parser",
                         help="file of instructions translated by idef-parser")
@@ -1368,6 +1369,7 @@ def parse_common_args(desc):
     read_semantics_file(args.semantics)
     read_overrides_file(args.overrides)
     read_overrides_file(args.overrides_vec)
+    read_overrides_file(args.overrides_sys)
     if args.idef_parser:
         read_idef_parser_enabled_file(args.idef_parser)
     calculate_attribs()
diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
index bb4ebaae81..3ec53010fa 100644
--- a/target/hexagon/meson.build
+++ b/target/hexagon/meson.build
@@ -20,6 +20,7 @@ hexagon_ss = ss.source_set()
 hex_common_py = 'hex_common.py'
 gen_tcg_h = meson.current_source_dir() / 'gen_tcg.h'
 gen_tcg_hvx_h = meson.current_source_dir() / 'gen_tcg_hvx.h'
+gen_tcg_sys_h = meson.current_source_dir() / 'gen_tcg_sys.h'
 idef_parser_dir = meson.current_source_dir() / 'idef-parser'
 
 #
@@ -249,6 +250,7 @@ hexagon_ss.add(files(
     'cpu.c',
     'translate.c',
     'op_helper.c',
+    'cpu_helper.c',
     'gdbstub.c',
     'genptr.c',
     'reg_fields.c',
@@ -346,12 +348,12 @@ if idef_parser_enabled and 'hexagon-linux-user' in target_dirs
     # Setup input and dependencies for the next step, this depends on whether or
     # not idef-parser is enabled
     helper_dep = [semantics_generated, idef_generated_tcg_c, idef_generated_tcg]
-    helper_in = [semantics_generated, gen_tcg_h, gen_tcg_hvx_h, '--idef-parser', idef_generated_list]
+    helper_in = [semantics_generated, gen_tcg_h, gen_tcg_hvx_h, gen_tcg_sys_h, '--idef-parser', idef_generated_list]
 else
     # Setup input and dependencies for the next step, this depends on whether or
     # not idef-parser is enabled
     helper_dep = [semantics_generated]
-    helper_in = [semantics_generated, gen_tcg_h, gen_tcg_hvx_h]
+    helper_in = [semantics_generated, gen_tcg_h, gen_tcg_hvx_h, gen_tcg_sys_h]
 endif
 
 #
@@ -365,7 +367,7 @@ helper_protos_generated = custom_target(
     'helper_protos_generated.h.inc',
     output: 'helper_protos_generated.h.inc',
     depends: helper_dep,
-    depend_files: [hex_common_py, gen_tcg_h, gen_tcg_hvx_h],
+    depend_files: [hex_common_py, gen_tcg_h, gen_tcg_hvx_h, gen_tcg_sys_h],
     command: [python, files('gen_helper_protos.py'), helper_in, '@OUTPUT@'],
 )
 hexagon_ss.add(helper_protos_generated)
@@ -374,7 +376,7 @@ helper_funcs_generated = custom_target(
     'helper_funcs_generated.c.inc',
     output: 'helper_funcs_generated.c.inc',
     depends: helper_dep,
-    depend_files: [hex_common_py, gen_tcg_h, gen_tcg_hvx_h],
+    depend_files: [hex_common_py, gen_tcg_h, gen_tcg_hvx_h, gen_tcg_sys_h],
     command: [python, files('gen_helper_funcs.py'), helper_in, '@OUTPUT@'],
 )
 hexagon_ss.add(helper_funcs_generated)
@@ -383,7 +385,7 @@ tcg_funcs_generated = custom_target(
     'tcg_funcs_generated.c.inc',
     output: 'tcg_funcs_generated.c.inc',
     depends: helper_dep,
-    depend_files: [hex_common_py, gen_tcg_h, gen_tcg_hvx_h],
+    depend_files: [hex_common_py, gen_tcg_h, gen_tcg_hvx_h, gen_tcg_sys_h],
     command: [python, files('gen_tcg_funcs.py'), helper_in, '@OUTPUT@'],
 )
 hexagon_ss.add(tcg_funcs_generated)
@@ -392,7 +394,7 @@ analyze_funcs_generated = custom_target(
     'analyze_funcs_generated.c.inc',
     output: 'analyze_funcs_generated.c.inc',
     depends: helper_dep,
-    depend_files: [hex_common_py, gen_tcg_h, gen_tcg_hvx_h],
+    depend_files: [hex_common_py, gen_tcg_h, gen_tcg_hvx_h, gen_tcg_sys_h],
     command: [python, files('gen_analyze_funcs.py'), helper_in, '@OUTPUT@'],
 )
 hexagon_ss.add(analyze_funcs_generated)
-- 
2.34.1


