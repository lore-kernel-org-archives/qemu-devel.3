Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE57F417E0
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbuz-00019R-LU; Mon, 09 Mar 2026 10:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuq-0000yK-PM
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:49:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbun-0005IV-Kr
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:49:04 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629EIp9k890725
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2026 14:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ArhYHHcsZcPCVZg0VjfHvMn74eMQNgWxMzUjhWzmqZQ=; b=XSkkTlLEo/JWocrw
 +yvMp+fP1WS/u6NjvZbfA+pPr8Ur7DN0979N5KGMZQ3nscOSjvAqxPe4FA0KBweP
 8DSCvFs4rrIUPb54yACdso/mntt+wpT78HsdWZEaaiQ5WKPbGYiUkTha5mtbJv6j
 TI9Rhmx5tTcHX+EoVnkwVU4graEbxhCvLVVKmYEBpUmf0rt5qQ1KeyzmiLGoWiD8
 cnX3ht5oNJMjq0g30k6JrQsdllrXrPc2f1Pbw05S9et0WVgnl2dleESPXkMzPS6i
 70MTzSYFAz1iVFz6mpEcVIcoF9Y6sI5bVm8w9lzZsc47L7qaTVLno8FTHgPX90cF
 lm/iuw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csyv183va-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:49:00 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2be232ef3d3so70733465eec.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773067739; x=1773672539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ArhYHHcsZcPCVZg0VjfHvMn74eMQNgWxMzUjhWzmqZQ=;
 b=Fo7W6V/DNHvIGGu97J+Nz9douwdu3JCE42suMGGQVBYb6vb+63SyKJuIuhbgtMh8DG
 fyGdbN40hoJPZUAjUSh1bJcaJ7EG3Q40fOP94PmRVLe2X9yLc4zBgETX3OtazocnhfSw
 Oy/b0CCoAr73VHPbUhGHl3Xl8KWuu4cf66w14ipxr2Eoa8rr00STNFQ/us5TAiCW5Zzp
 U/WL/M6lCPZbNkZT079BCkuWY1BQPT7yd/hV0U0QUTVZPMY0nICNnIgVhKRkDDP+4J6g
 kGhrE3B+W6p85bfMqtLjMxC/CXNIB6wXVdWRsKQsoaZrTpXvpSQ/NPP5/iayCyKlPu5c
 gzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067739; x=1773672539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ArhYHHcsZcPCVZg0VjfHvMn74eMQNgWxMzUjhWzmqZQ=;
 b=iBqECkuH7jFtHkr56E+pWdcIVzswLwGEhZDlddAJ+O3IcAVL5DpDJgAQZYQpIBKjlX
 tuBwwD6iC2hFoH/TyUedEqJfayLt0jzfGe8Pc6ykn+KhEWbhCFkUP1DViZjXh7vIFUuy
 Rsl6uqErAnP83bEA80LAP+oP34twI+XM07zMfbm/hdeo5j51DUJ4qZx0kPQseK8dAqjo
 zsn3JTAuWCO0QGWw/+oHl2gtax4IDRxd255y3GKb5mbGuM/nqzwtacZoVSZn48YJ0y+X
 t4+Y2ts0VF4Hq+E/0lOrQJ0ypFCjkbZ+EjxoTjO+XqAOLQUpvBEOSQrcQTCYh88nz/8E
 MQ5w==
X-Gm-Message-State: AOJu0YxPHpniPg6Tu7w6raHVHogRjCw4y4ic4sXcEy2kADNIgCCd1uyQ
 vOP6pEByrKJ7zlxZ+xtnNj1Px/yz7ReOZ2nUc/gDsSV3TP2jpEruN/e8wnYad6+y2DITUULnnKh
 pE1clACLR52ChWAObnEDr8/zqe0yUu6KEn8Bk8DbVns8V9qt+mdAjshBdEfd6laJMNQ==
X-Gm-Gg: ATEYQzxiMDoqCtdz1fTlwxNp/2K5rchdGc4e4Cde0NFgCrjTCrHlzsS5UT/btVk9ap5
 iyCTmQUesPJ+nucIAqn3ARcR0fMdEEG9gfqCMU9BfK8OahyLrKG7Po9YA2pEM8opfTjtp1EqMaB
 AIg9MtydBc834ydokanxWT0rvSiEXWgEsoPG5SGMOSvSF4ksMUyuIdxNEax6coV3+iFoJ71AlAG
 hJJKRy2+r2taeTCK9zVJYdOjdlmTvZnOuFZw47JvI82r4juigIqgJAVnF3h8FGBD7c16eviVfvm
 eMTGPeK3FXodA88q3s0pskYi5SXmb/VRG/OwBRxNMqQmSODupA385QywVlCgOin5hqgNHP6gmUh
 i0QUutC42sdmpg1tCCMZGIUFyqyEM/gOSN38A/23eZl1CDF3PZgnpoQtHxQX2OasqEDDGtw==
X-Received: by 2002:a05:7301:1008:b0:2ba:7b0b:e205 with SMTP id
 5a478bee46e88-2be4e03b3d5mr4350200eec.20.1773067739300; 
 Mon, 09 Mar 2026 07:48:59 -0700 (PDT)
X-Received: by 2002:a05:7301:1008:b0:2ba:7b0b:e205 with SMTP id
 5a478bee46e88-2be4e03b3d5mr4350173eec.20.1773067738649; 
 Mon, 09 Mar 2026 07:48:58 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f82b78esm9322776eec.12.2026.03.09.07.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 07:48:58 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>,
 Sid Manning <sidneym@quicinc.com>
Subject: [PATCH v4 29/35] target/hexagon: Add sreg_{read,write} helpers
Date: Mon,  9 Mar 2026 07:48:16 -0700
Message-Id: <20260309144822.877695-30-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
References: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: JbNVWE9tsHp1Qiqs3psNWuxmzxE8BAQ2
X-Proofpoint-ORIG-GUID: JbNVWE9tsHp1Qiqs3psNWuxmzxE8BAQ2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzMyBTYWx0ZWRfX5Bu6B/Dy6LH9
 MIto8zPFsKiAE58K+kIfZh/lhFOrK2RNve0ykekJW534cSE4EK5SgmfTj/G9YyZRKh4CK+mQxHJ
 Dmywctzj1g8HWKSgNe3Pka0iBz3Dx6D1uBAZo+JX29lXDK4yPNNY+Z0v5TMvS25DLR2sCtmr7Ys
 qW79n473gzAKUoCV2I0ijCF/EwoKw55jpC11+uVcBlK7BkRxjzqVReeurcsBkxOhIWqU96/jNGI
 qJIKZCu09YV25XmR/V7y50DxbcuMh2a8mhwqHE6JwnJY4Df/oB9QjOdDBHZpofI1kH6IKyRJDHl
 qDO7PAlizIk8LCSqMsHjBz60j9AVyYFqillNVKgPH5CUUvtUOk4y1AykeCM4JO4mKKUJNmz/M2a
 lerw8IlP4KFPnoqZeZpayumZO/qvQNijQf+31wM78v/fTXggdUTksny6ipaL5HaLgLJkHOva4BW
 jeF1emG45vVXsaSAVbw==
X-Authority-Analysis: v=2.4 cv=Cuays34D c=1 sm=1 tr=0 ts=69aedddc cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=awtrkfjtPIBuNREMqawA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090133
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Co-authored-by: Sid Manning <sidneym@quicinc.com>
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/cpu.c        |  1 -
 target/hexagon/cpu_helper.c | 60 +++++++++++++++++++++++++++++++++++++
 target/hexagon/op_helper.c  | 30 +++++++++++++++++--
 3 files changed, 87 insertions(+), 4 deletions(-)
 create mode 100644 target/hexagon/cpu_helper.c

diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 38d605b06ba..dc3bd82bc05 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -339,7 +339,6 @@ static void hexagon_cpu_realize(DeviceState *dev, Error **errp)
 
     qemu_init_vcpu(cs);
     cpu_reset(cs);
-
     mcc->parent_realize(dev, errp);
 }
 
diff --git a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c
new file mode 100644
index 00000000000..b8e0625e3f8
--- /dev/null
+++ b/target/hexagon/cpu_helper.c
@@ -0,0 +1,60 @@
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "cpu_helper.h"
+#include "system/cpus.h"
+#include "hw/core/boards.h"
+#include "hw/hexagon/hexagon.h"
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
+uint32_t hexagon_get_pmu_counter(CPUHexagonState *cur_env, int index)
+{
+    g_assert_not_reached();
+}
+
+uint64_t hexagon_get_sys_pcycle_count(CPUHexagonState *env)
+{
+    g_assert_not_reached();
+}
+
+uint32_t hexagon_get_sys_pcycle_count_high(CPUHexagonState *env)
+{
+    g_assert_not_reached();
+}
+
+uint32_t hexagon_get_sys_pcycle_count_low(CPUHexagonState *env)
+{
+    g_assert_not_reached();
+}
+
+void hexagon_set_sys_pcycle_count_high(CPUHexagonState *env,
+        uint32_t cycles_hi)
+{
+    g_assert_not_reached();
+}
+
+void hexagon_set_sys_pcycle_count_low(CPUHexagonState *env,
+        uint32_t cycles_lo)
+{
+    g_assert_not_reached();
+}
+
+void hexagon_set_sys_pcycle_count(CPUHexagonState *env, uint64_t cycles)
+{
+    g_assert_not_reached();
+}
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index cb60d3a2f9e..2e6924f0d2c 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -1449,17 +1449,41 @@ void HELPER(setimask)(CPUHexagonState *env, uint32_t tid, uint32_t imask)
 
 void HELPER(sreg_write_masked)(CPUHexagonState *env, uint32_t reg, uint32_t val)
 {
-    g_assert_not_reached();
+    BQL_LOCK_GUARD();
+    if (reg < HEX_SREG_GLB_START) {
+        env->t_sreg[reg] = val;
+    } else {
+        HexagonCPU *cpu = env_archcpu(env);
+        if (cpu->globalregs) {
+            hexagon_globalreg_write_masked(cpu->globalregs, reg, val);
+        }
+    }
+}
+
+static inline QEMU_ALWAYS_INLINE uint32_t sreg_read(CPUHexagonState *env,
+                                                    uint32_t reg)
+{
+    g_assert(bql_locked());
+    if (reg < HEX_SREG_GLB_START) {
+        return env->t_sreg[reg];
+    }
+    HexagonCPU *cpu = env_archcpu(env);
+    return cpu->globalregs ?
+        hexagon_globalreg_read(cpu->globalregs, reg, env->threadId) : 0;
 }
 
 uint32_t HELPER(sreg_read)(CPUHexagonState *env, uint32_t reg)
 {
-    g_assert_not_reached();
+    BQL_LOCK_GUARD();
+    return sreg_read(env, reg);
 }
 
 uint64_t HELPER(sreg_read_pair)(CPUHexagonState *env, uint32_t reg)
 {
-    g_assert_not_reached();
+    BQL_LOCK_GUARD();
+
+    return deposit64((uint64_t) sreg_read(env, reg), 32, 32,
+        sreg_read(env, reg + 1));
 }
 
 uint32_t HELPER(greg_read)(CPUHexagonState *env, uint32_t reg)
-- 
2.34.1


