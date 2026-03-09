Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B1DF417F1
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbv3-0001Tj-MI; Mon, 09 Mar 2026 10:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuu-00012N-Oo
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:49:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbus-0005HY-VS
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:49:08 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629EAWOe1249054
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2026 14:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +echXoguDZ5l6GnICeYq4LZ7Ft5EyaL/c1TckYMUo1Y=; b=EFsKbW/yM/SUaQ84
 +bM2fnb3iWoXhGWrVa1MdJZKFpnZ/QXVd5V5wyjm2lhUX1EQBaHWZsnjIkLMIkcu
 ULc7o98HUDEeVRgdBJp9+3ckhk0oa+plSKBm21tvuB46Q1IlrqkiVOSp8Ea6L+f0
 97RtvQKxErtRIkPx2/jTb8+2wZmU8wifdfN4tF8QGwYZhjgmeeVN6QeQC8BYKdCg
 Jrim5fmrGL0WwFBiK5LzY0KT3EDGThgrTC9qp/pb53S6tSdbbZAJDwacgcV+3Co4
 JlEGq4/EmG1SR5upErlKk0Ix5miadHEJ4CXsBqsh3w3kBSanSvtnBlWOonadndF8
 O8ldhw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csyr403ta-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:48:55 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2bda35eab74so4833805eec.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773067734; x=1773672534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+echXoguDZ5l6GnICeYq4LZ7Ft5EyaL/c1TckYMUo1Y=;
 b=d/QOAynEmQajNY5f/ry1Wj/pP2/9oK2SH0tzP2cfBg1Aj7uAg0afyTzOxgq5XN0Vn3
 MyTFWxhQE8K3ZNVsHofbz67/FtsOkIE/YJAFqq8BdzzqbidmOuzwaY4LDSU21nvofXpv
 b3ZffRwkhCLzw6C/RT2KCMv90uFUwmm9eXkQVmG70SdQ1SlKSyt9LxgFg9ae2WSTF0Su
 RMLU8DWDdMxIo9ABOwaPPZHopHQOGqSXm7bQh/Ci7s4gaQVN2UQCyjLQ3Wr+YIIzGLaB
 z4yZXLyOybkGSP/Tne/DbZCptgE82BhFz6gSrymGaF/l0yc+Weo1TLoJzOQ/OQfLo/gS
 6Sdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067734; x=1773672534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+echXoguDZ5l6GnICeYq4LZ7Ft5EyaL/c1TckYMUo1Y=;
 b=nTZRKwbqzUFMssAhVQQvSaRFojGuEyirS0LVUvs1AfXMUl0JOAxWuxzQhmP8/YHfvp
 wOVqBUM8TJpzvvY1+qldUjSby2oN/mHeI5P3EgdLmWHIo0nKCisZVBMttUdHlYBcy9Cb
 nTGpSlQh0MZonypn9WD6vTPqQ8UpqqpaoF4TI/fVuA7FshjagqBiGI/KG2d3CPixJrzC
 Dsd2fY9YAyXe1z7xRWF5SnsZmXLQ+HvO/vh8u6NM04cCNmskhEKLke9wL6KKmusSHMd3
 yYR+mtCQ8Ybju6lfFQ6k6D3vFHb9xaKQW5IFT55Y/4W3Xm+/Eioj3Zlt4kS8Jp7Zmjd6
 iTnA==
X-Gm-Message-State: AOJu0YylVx5YQVbNKfHbHU8dh6hrLoZAQ+C3Rdw+3hMTf7l3Wx4IXGer
 T78jVlG2PtwKkLi99/++VO1RAFX2N4AYdj2VD/P+5yNAHhVWafWjpp6QqzOFLlsuvpE8PFdYqXa
 2MDEKWKvWJmbcW7t9Ky3xlMYWKlddxbhvmRa+X5Yogwi/0RfddiEkczKnKLe7yfMvEg==
X-Gm-Gg: ATEYQzylyY/3EhG9kVLVtL/jz5/pUV9TU/clYtDONRT1MYHvLfwh5JU9A7fRs5gIh2P
 vUvvxahreMifFQ84oJXRvMmm8jbuAXfj/2B4e5ksRTpyOuIgltwt3UruHO4bJ4S1DPqEqcKaFhr
 n7gaKZM7wPeq1NvATWw2TOrcYUhYvBFLPQX4mZR6Q6eLDYh3VCwwVFj/esIIuD2uBpfG9liFtS0
 I+PZmEqAOiBpCMdDN4NZU6O5Qjx/AIYWlfR19gVJZU3y7ayXWY3Pz8jBscgHC+ytD8dHjC6iTI8
 9RsRWu1ja8jgHatZTymY146vE7e9i9MzatRYHQUf0KB6o6kbc5sxC9gqzP2GBG4vwYs78BTVkG2
 0fLmwfLvQpxzBkXVqoINhNh8c5bmnetveLZaBH0Z4KthPJaXf4GG8+q8wiLP9hMzvCBBbQw==
X-Received: by 2002:a05:693c:2c09:b0:2ba:974c:4954 with SMTP id
 5a478bee46e88-2be4e694e01mr4337773eec.11.1773067734407; 
 Mon, 09 Mar 2026 07:48:54 -0700 (PDT)
X-Received: by 2002:a05:693c:2c09:b0:2ba:974c:4954 with SMTP id
 5a478bee46e88-2be4e694e01mr4337750eec.11.1773067733888; 
 Mon, 09 Mar 2026 07:48:53 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f82b78esm9322776eec.12.2026.03.09.07.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 07:48:53 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 24/35] target/hexagon: Add sysemu TCG overrides
Date: Mon,  9 Mar 2026 07:48:11 -0700
Message-Id: <20260309144822.877695-25-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
References: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzMyBTYWx0ZWRfX5L92VE7lSu9F
 fe8bO5RCeEGbdgtg/eExPRU/vIEvccIgAAOVYXzgIpD64mmR5tHD2Fe3WSn7HVj969xMVATmuGK
 JRInRpFHEPUs8DCHlE00E58tmoDIx19xtdXkZzvMHqufwBgIf5l78gKvEwbCxGF9RKasfLgY5Mx
 K/pSUdTapbSarAKZbU78V/OZFbI/eW6ZwIcaeAbQOql8qraOQOGpVOLcT/GVs2Gj/6SrSE/Juq/
 cPp0NxNsfwSz6wG7XddO5gXYjcpxsDEOn8uStkDBSFmBCImHDHpfnXeOyEfW9Xq2PtrYj2e/Z/T
 zgjd9lit3nA41k1tIN1Xhm+9zZTYIBt9bYsXisVsig3I7Y+6VtOLyspPc7CycnUt2ut6veX1A63
 nnVybin2QMbVm8zhnm86EIIlrdcV30tQHyTSXAc7bgMckJtUuKQFdSAaDzXi/7fFeNp2QO9JCiG
 Zt/p2cA1UZWo93sYdRQ==
X-Proofpoint-GUID: 98SAxnx9BiqC6hw-M-Pc4_SaE6zQiAgc
X-Proofpoint-ORIG-GUID: 98SAxnx9BiqC6hw-M-Pc4_SaE6zQiAgc
X-Authority-Analysis: v=2.4 cv=KNRXzVFo c=1 sm=1 tr=0 ts=69aeddd7 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=c-qlsedbFlXwKLHGPykA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090133
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Brian Cain <bcain@quicinc.com>

Define TCG overrides for setprio(), crswap(,sgp{0,1,1:0}).

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/cpu_helper.h  | 18 ++++++++++++++++
 target/hexagon/gen_tcg_sys.h | 40 ++++++++++++++++++++++++++++++++++++
 target/hexagon/helper.h      |  1 +
 target/hexagon/genptr.c      |  4 ++++
 target/hexagon/op_helper.c   | 10 ++++++++-
 target/hexagon/hex_common.py |  2 ++
 target/hexagon/meson.build   | 13 ++++++------
 7 files changed, 81 insertions(+), 7 deletions(-)
 create mode 100644 target/hexagon/cpu_helper.h
 create mode 100644 target/hexagon/gen_tcg_sys.h

diff --git a/target/hexagon/cpu_helper.h b/target/hexagon/cpu_helper.h
new file mode 100644
index 00000000000..1486a03c64a
--- /dev/null
+++ b/target/hexagon/cpu_helper.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HEXAGON_CPU_HELPER_H
+#define HEXAGON_CPU_HELPER_H
+
+uint32_t hexagon_get_pmu_counter(CPUHexagonState *cur_env, int index);
+uint64_t hexagon_get_sys_pcycle_count(CPUHexagonState *env);
+uint32_t hexagon_get_sys_pcycle_count_low(CPUHexagonState *env);
+uint32_t hexagon_get_sys_pcycle_count_high(CPUHexagonState *env);
+void hexagon_set_sys_pcycle_count(CPUHexagonState *env, uint64_t);
+void hexagon_set_sys_pcycle_count_low(CPUHexagonState *env, uint32_t);
+void hexagon_set_sys_pcycle_count_high(CPUHexagonState *env, uint32_t);
+
+#endif
diff --git a/target/hexagon/gen_tcg_sys.h b/target/hexagon/gen_tcg_sys.h
new file mode 100644
index 00000000000..2410ac82c96
--- /dev/null
+++ b/target/hexagon/gen_tcg_sys.h
@@ -0,0 +1,40 @@
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
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
index 28b9b59e0f2..5405342f798 100644
--- a/target/hexagon/helper.h
+++ b/target/hexagon/helper.h
@@ -114,4 +114,5 @@ DEF_HELPER_2(sreg_read_pair, i64, env, i32)
 DEF_HELPER_2(greg_read, i32, env, i32)
 DEF_HELPER_2(greg_read_pair, i64, env, i32)
 DEF_HELPER_3(sreg_write_masked, void, env, i32, i32)
+DEF_HELPER_3(setprio, void, env, i32, i32)
 #endif
diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
index 2310b9aec3a..bac63a42def 100644
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
index eaefddef15c..22dbe8c85ec 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -19,9 +19,10 @@
 #include "qemu/log.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/probe.h"
+#include "qemu/main-loop.h"
+#include "cpu.h"
 #include "exec/helper-proto.h"
 #include "fpu/softfloat.h"
-#include "cpu.h"
 #include "internal.h"
 #include "macros.h"
 #include "sys_macros.h"
@@ -31,6 +32,7 @@
 #include "mmvec/mmvec.h"
 #include "mmvec/macros.h"
 #include "op_helper.h"
+#include "cpu_helper.h"
 #include "translate.h"
 
 #define SF_BIAS        127
@@ -1409,6 +1411,12 @@ uint64_t HELPER(greg_read_pair)(CPUHexagonState *env, uint32_t reg)
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
index b9a5b9e2a29..d7496bf6b2e 100755
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
index d169cf71b2f..528beca3cd0 100644
--- a/target/hexagon/meson.build
+++ b/target/hexagon/meson.build
@@ -20,6 +20,7 @@ hexagon_ss = ss.source_set()
 hex_common_py = 'hex_common.py'
 gen_tcg_h = meson.current_source_dir() / 'gen_tcg.h'
 gen_tcg_hvx_h = meson.current_source_dir() / 'gen_tcg_hvx.h'
+gen_tcg_sys_h = meson.current_source_dir() / 'gen_tcg_sys.h'
 idef_parser_dir = meson.current_source_dir() / 'idef-parser'
 
 #
@@ -337,12 +338,12 @@ if idef_parser_enabled and 'hexagon-linux-user' in target_dirs
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
@@ -356,7 +357,7 @@ helper_protos_generated = custom_target(
     'helper_protos_generated.h.inc',
     output: 'helper_protos_generated.h.inc',
     depends: helper_dep,
-    depend_files: [hex_common_py, gen_tcg_h, gen_tcg_hvx_h],
+    depend_files: [hex_common_py, gen_tcg_h, gen_tcg_hvx_h, gen_tcg_sys_h],
     command: [python, files('gen_helper_protos.py'), helper_in, '@OUTPUT@'],
 )
 hexagon_ss.add(helper_protos_generated)
@@ -365,7 +366,7 @@ helper_funcs_generated = custom_target(
     'helper_funcs_generated.c.inc',
     output: 'helper_funcs_generated.c.inc',
     depends: helper_dep,
-    depend_files: [hex_common_py, gen_tcg_h, gen_tcg_hvx_h],
+    depend_files: [hex_common_py, gen_tcg_h, gen_tcg_hvx_h, gen_tcg_sys_h],
     command: [python, files('gen_helper_funcs.py'), helper_in, '@OUTPUT@'],
 )
 hexagon_ss.add(helper_funcs_generated)
@@ -374,7 +375,7 @@ tcg_funcs_generated = custom_target(
     'tcg_funcs_generated.c.inc',
     output: 'tcg_funcs_generated.c.inc',
     depends: helper_dep,
-    depend_files: [hex_common_py, gen_tcg_h, gen_tcg_hvx_h],
+    depend_files: [hex_common_py, gen_tcg_h, gen_tcg_hvx_h, gen_tcg_sys_h],
     command: [python, files('gen_tcg_funcs.py'), helper_in, '@OUTPUT@'],
 )
 hexagon_ss.add(tcg_funcs_generated)
@@ -383,7 +384,7 @@ analyze_funcs_generated = custom_target(
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


