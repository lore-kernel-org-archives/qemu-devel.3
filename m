Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0658CCA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI0W-0007LV-UD; Mon, 01 Sep 2025 23:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI0K-00077S-GB
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:48:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI0H-0004XB-EF
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:48:20 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822S2e6013176
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aSp83uHVSI0MnVI0UImBhnG9FGcruN7ODNKK+OFueJI=; b=jkdZoPTQlQH2zTSF
 3tPuvjTQuMXl5hlQvjVL3wpr00rHHosm8RI8O4fcnD2nZBZDdB9FIzRxFO2Ggrtf
 GAWVOLxBaDRIQMXUD/ACfx+KkxXuP4cEeIVi+Wx7U+HU0MMWDsdD+Zl0ZMYsoVKI
 /lRvtUixsEaj5Reg+EH7kJOrI7hHyjAuVQGtSAV73In6LoufKRYVFiwjJHA0gdT3
 oJdY4+PbGVUbuRRvstv73BoxqWEcCKHQ8plCPHw1apQjt9xDzwhnkJma7EFrfwb/
 0UekL0C+ApA5KANgYD3sKkYzRMZwmPOZssX/w0aakzMqxsBEKk+U3kImdpuBUWKc
 93DRJg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2fea22-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:48:06 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b4c949fc524so3228827a12.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784885; x=1757389685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aSp83uHVSI0MnVI0UImBhnG9FGcruN7ODNKK+OFueJI=;
 b=Am+CqPjuV5HiSw+d3squirTGGqU7i5LfyAnqNRnzpRxqgzuw754ZvSoXso89WuyaIZ
 RyrFRBz5u/scCnj+Rpu79eUIPe5uziGlyCVp5nRfXUOB048DJ4Ftxo1HwcoOnpCU2GVs
 C6+v2woEFgyNO8On4i4y7fKCTDgESypPvZvz1T0dqlCD672vBcMVIuH25Ahhx5ZyIf2P
 phGiqb0A+CIeYSy+ZiZg38bDdLugOpHA8C8ifP3p1CMOP3xlDMUiJL6fhKsCcirplKHx
 zImdcYTFhdZ+CPlS988XwQwQqcjQsMZHUZU6Lv1hjToG6lxf1dMEK7fErDG0U3wcnD1Z
 3nZA==
X-Gm-Message-State: AOJu0YyP+bgQjPwEgWVquPym0rWfdkxkD7gF+JaDaosJ2ZM9M2FCJXo1
 15fodsbvYqW0Ls4OBC0dTg8NKSGLqjfjPcUPewPhyi4k+E8/NX9E0SBg/7/VErkAOxQ86JL+qmQ
 ES8M36BExMjyqasdbdlnx3atPzfYwe7dx7X0bgOQVb6KBiQAJeAXTfsXTATd+nervL/wB
X-Gm-Gg: ASbGncumSQHcQVrbGgkDJZylwukXtgCB1SAO0OLgA9mtn1TKIdkvBzkoOLQzOL6e4Ar
 SSBCTogeUqdiRJh4G4chVrWRo8yWIyyLE6IzOF4Qu3SByOqewXqg8Shsl6YPmqm8woiYOnhpTtO
 snkEaPaSS1iQy55BCWz8WWLIbxEpqkM66KqAxLisl2wZwL+dP+W9E335N6jVGGDLqDgyoDZbXMz
 Dd6EeZQSMOFwrmsXSR8Z3mPIZhKySSxNdS+r/G/NnJjO4YJBcSkh/1sxlSUm+LmeSrWUFcUWtM8
 3+rF+B+T/DlCXJLQbNTZcTIEn++sFJ4N2IVSrSGDM4qv388UjmpGlTLzh/pfD23vxTSqFNYKOy8
 Qni8JC90C+kmd
X-Received: by 2002:a05:6a20:4321:b0:243:b5f3:fe5e with SMTP id
 adf61e73a8af0-243d6f7e8a1mr13305316637.53.1756784884665; 
 Mon, 01 Sep 2025 20:48:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcg+WRCbrU6hRHurIij4mcQzF7+bsECZE42duAOyPhkU1w964zLppGEDMfML/22y+ig6XNoA==
X-Received: by 2002:a05:6a20:4321:b0:243:b5f3:fe5e with SMTP id
 adf61e73a8af0-243d6f7e8a1mr13305275637.53.1756784884116; 
 Mon, 01 Sep 2025 20:48:04 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006e2c6sm10633584a12.2.2025.09.01.20.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:48:03 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Subject: [PATCH v2 36/40] target/hexagon: Add gdb support for sys regs
Date: Mon,  1 Sep 2025 20:47:11 -0700
Message-Id: <20250902034715.1947718-37-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
References: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfX0G3G0akykn6X
 HKh7nhb/uT20XijypZSGfu1bjT9gQCzGJKsdYMS1SIM7X4D/fXCPHWE3n9+5SCbVWDDLRHz7KPP
 6dr5RakE89x/Lv5tDWeyVtQpLxHeRrr0axGNf9+M2i1qMfGgSPalsyjNgXJ+1PZlricBqORrdM5
 oXJrXycKU2YMbV6xYdPRvAq78oDKXMYueXpTlft6hTFLoTIQpl6wmeF02j/ulYS50P0Rmvt+f5W
 +YfaiuVFLSrvHYaIaDfvn4m+Xwmg+jhee9vrHlNNUg3V+ghorjhNyPY5jQ32aBKnGG2D4m5RkD+
 hpumhZ1NbdhKEnjox/k5bXxqxpmZKCw8Xaw/7u0G3WacplMzw2VpGvh3k0PojCKwP0pcCxUceJ5
 v16eizlG
X-Proofpoint-ORIG-GUID: 0zR9gUf4cdstYTBSYSZg-F45EeDSQ7de
X-Proofpoint-GUID: 0zR9gUf4cdstYTBSYSZg-F45EeDSQ7de
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68b668f6 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=igv5VeXmG1bnzZ-LDdkA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Co-authored-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/cpu.h       |   6 ++
 target/hexagon/internal.h  |   4 ++
 target/hexagon/cpu.c       |  17 ++++++
 target/hexagon/gdbstub.c   |  45 ++++++++++++++
 target/hexagon/op_helper.c |  22 +++++++
 gdb-xml/hexagon-sys.xml    | 116 +++++++++++++++++++++++++++++++++++++
 6 files changed, 210 insertions(+)
 create mode 100644 gdb-xml/hexagon-sys.xml

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 6b49912c08..627748392f 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -196,6 +196,12 @@ G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
                                             uint32_t exception,
                                             uintptr_t pc);
 
+#ifndef CONFIG_USER_ONLY
+uint32_t hexagon_greg_read(CPUHexagonState *env, uint32_t reg);
+uint32_t hexagon_sreg_read(CPUHexagonState *env, uint32_t reg);
+void hexagon_gdb_sreg_write(CPUHexagonState *env, uint32_t reg, uint32_t val);
+#endif
+
 typedef HexagonCPU ArchCPU;
 
 void hexagon_translate_init(void);
diff --git a/target/hexagon/internal.h b/target/hexagon/internal.h
index 7cf7bcaa6c..c24c360921 100644
--- a/target/hexagon/internal.h
+++ b/target/hexagon/internal.h
@@ -22,6 +22,10 @@
 
 int hexagon_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int hexagon_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
+#ifndef CONFIG_USER_ONLY
+int hexagon_sys_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n);
+int hexagon_sys_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n);
+#endif
 int hexagon_hvx_gdb_read_register(CPUState *env, GByteArray *mem_buf, int n);
 int hexagon_hvx_gdb_write_register(CPUState *env, uint8_t *mem_buf, int n);
 
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 43fd13cd0d..2ee379121e 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -27,6 +27,10 @@
 #include "exec/gdbstub.h"
 #include "accel/tcg/cpu-ops.h"
 
+#ifndef CONFIG_USER_ONLY
+#include "sys_macros.h"
+#endif
+
 static void hexagon_v66_cpu_init(Object *obj) { }
 static void hexagon_v67_cpu_init(Object *obj) { }
 static void hexagon_v68_cpu_init(Object *obj) { }
@@ -338,6 +342,12 @@ static void hexagon_cpu_realize(DeviceState *dev, Error **errp)
                              hexagon_hvx_gdb_write_register,
                              gdb_find_static_feature("hexagon-hvx.xml"), 0);
 
+#ifndef CONFIG_USER_ONLY
+    gdb_register_coprocessor(cs, hexagon_sys_gdb_read_register,
+                             hexagon_sys_gdb_write_register,
+                             gdb_find_static_feature("hexagon-sys.xml"), 0);
+#endif
+
     qemu_init_vcpu(cs);
     cpu_reset(cs);
     mcc->parent_realize(dev, errp);
@@ -393,6 +403,13 @@ static void hexagon_cpu_class_init(ObjectClass *c, const void *data)
     cc->tcg_ops = &hexagon_tcg_ops;
 }
 
+#ifndef CONFIG_USER_ONLY
+uint32_t hexagon_greg_read(CPUHexagonState *env, uint32_t reg)
+{
+    g_assert_not_reached();
+}
+#endif
+
 #define DEFINE_CPU(type_name, initfn)      \
     {                                      \
         .name = type_name,                 \
diff --git a/target/hexagon/gdbstub.c b/target/hexagon/gdbstub.c
index 12d6b3bbcb..8476199b75 100644
--- a/target/hexagon/gdbstub.c
+++ b/target/hexagon/gdbstub.c
@@ -76,6 +76,51 @@ int hexagon_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     g_assert_not_reached();
 }
 
+#ifndef CONFIG_USER_ONLY
+int hexagon_sys_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
+{
+    CPUHexagonState *env = cpu_env(cs);
+
+    if (n < NUM_SREGS) {
+        return gdb_get_regl(mem_buf, hexagon_sreg_read(env, n));
+    }
+    n -= NUM_SREGS;
+
+    if (n < NUM_GREGS) {
+        return gdb_get_regl(mem_buf, hexagon_greg_read(env, n));
+    }
+    n -= NUM_GREGS;
+
+    n -= TOTAL_PER_THREAD_REGS;
+
+    if (n < NUM_PREGS) {
+        env->pred[n] = ldtul_p(mem_buf) & 0xff;
+        return sizeof(uint8_t);
+    }
+
+    n -= NUM_PREGS;
+
+    g_assert_not_reached();
+}
+
+int hexagon_sys_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
+{
+    CPUHexagonState *env = cpu_env(cs);
+
+    if (n < NUM_SREGS) {
+        hexagon_gdb_sreg_write(env, n, ldtul_p(mem_buf));
+        return sizeof(target_ulong);
+    }
+    n -= NUM_SREGS;
+
+    if (n < NUM_GREGS) {
+        return env->greg[n] = ldtul_p(mem_buf);
+    }
+    n -= NUM_GREGS;
+
+    g_assert_not_reached();
+}
+#endif
 static int gdb_get_vreg(CPUHexagonState *env, GByteArray *mem_buf, int n)
 {
     int total = 0;
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 7851f43475..a03fd078be 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -1494,6 +1494,23 @@ void HELPER(sreg_write)(CPUHexagonState *env, uint32_t reg, uint32_t val)
     sreg_write(env, reg, val);
 }
 
+void HELPER(sreg_write_masked)(CPUHexagonState *env, uint32_t reg, uint32_t val)
+{
+    BQL_LOCK_GUARD();
+    sreg_write_masked(env, reg, val);
+}
+
+void hexagon_gdb_sreg_write(CPUHexagonState *env, uint32_t reg, uint32_t val)
+{
+    BQL_LOCK_GUARD();
+    sreg_write(env, reg, val);
+    /*
+     * The above is needed to run special logic for regs like syscfg, but it
+     * won't set read-only bits. This will:
+     */
+    arch_set_system_reg(env, reg, val);
+}
+
 void HELPER(sreg_write_pair)(CPUHexagonState *env, uint32_t reg, uint64_t val)
 {
     BQL_LOCK_GUARD();
@@ -1546,6 +1563,11 @@ uint32_t HELPER(sreg_read)(CPUHexagonState *env, uint32_t reg)
     return sreg_read(env, reg);
 }
 
+uint32_t hexagon_sreg_read(CPUHexagonState *env, uint32_t reg)
+{
+    return sreg_read(env, reg);
+}
+
 uint64_t HELPER(sreg_read_pair)(CPUHexagonState *env, uint32_t reg)
 {
     BQL_LOCK_GUARD();
diff --git a/gdb-xml/hexagon-sys.xml b/gdb-xml/hexagon-sys.xml
new file mode 100644
index 0000000000..8a84be28ab
--- /dev/null
+++ b/gdb-xml/hexagon-sys.xml
@@ -0,0 +1,116 @@
+<?xml version="1.0"?>
+<!--
+  Copyright(c) 2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+
+  SPDX-License-Identifier: GPL-2.0-or-later
+
+  Note: this file is intended to be use with LLDB, so it contains fields
+  that may be unknown to GDB. For more information on such fields, please
+  see:
+  https://github.com/llvm/llvm-project/blob/287aa6c4536408413b860e61fca0318a27214cf3/lldb/docs/lldb-gdb-remote.txt#L738-L860
+  https://github.com/llvm/llvm-project/blob/287aa6c4536408413b860e61fca0318a27214cf3/lldb/source/Plugins/Process/gdb-remote/ProcessGDBRemote.cpp#L4275-L4335
+-->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.hexagon.sys">
+
+  <reg name="sgp0"       altname="s0"    bitsize="32" offset="4416" encoding="uint" format="hex" group="System Registers" dwarf_regnum="135" />
+  <reg name="sgp1"       altname="s1"    bitsize="32" offset="4420" encoding="uint" format="hex" group="System Registers" dwarf_regnum="136" />
+  <reg name="stid"       altname="s2"    bitsize="32" offset="4424" encoding="uint" format="hex" group="System Registers" dwarf_regnum="137" />
+  <reg name="elr"        altname="s3"    bitsize="32" offset="4428" encoding="uint" format="hex" group="System Registers" dwarf_regnum="138" />
+  <reg name="badva0"     altname="s4"    bitsize="32" offset="4432" encoding="uint" format="hex" group="System Registers" dwarf_regnum="139" />
+  <reg name="badva1"     altname="s5"    bitsize="32" offset="4436" encoding="uint" format="hex" group="System Registers" dwarf_regnum="140" />
+  <reg name="ssr"        altname="s6"    bitsize="32" offset="4440" encoding="uint" format="hex" group="System Registers" dwarf_regnum="141" />
+  <reg name="ccr"        altname="s7"    bitsize="32" offset="4444" encoding="uint" format="hex" group="System Registers" dwarf_regnum="142" />
+  <reg name="htid"       altname="s8"    bitsize="32" offset="4448" encoding="uint" format="hex" group="System Registers" dwarf_regnum="143" />
+  <reg name="badva"      altname="s9"    bitsize="32" offset="4452" encoding="uint" format="hex" group="System Registers" dwarf_regnum="144" />
+  <reg name="imask"      altname="s10"   bitsize="32" offset="4456" encoding="uint" format="hex" group="System Registers" dwarf_regnum="145" />
+  <reg name="gevb"       altname="s11"   bitsize="32" offset="4460" encoding="uint" format="hex" group="System Registers" dwarf_regnum="146" />
+  <reg name="vwctrl"     altname="s12"   bitsize="32" offset="4464" encoding="uint" format="hex" group="System Registers" dwarf_regnum="147" />
+  <reg name="s13"                        bitsize="32" offset="4468" encoding="uint" format="hex" group="System Registers" dwarf_regnum="148" />
+  <reg name="s14"                        bitsize="32" offset="4472" encoding="uint" format="hex" group="System Registers" dwarf_regnum="149" />
+  <reg name="s15"                        bitsize="32" offset="4476" encoding="uint" format="hex" group="System Registers" dwarf_regnum="150" />
+  <reg name="evb"        altname="s16"   bitsize="32" offset="4480" encoding="uint" format="hex" group="System Registers" dwarf_regnum="151" />
+  <reg name="modectl"    altname="s17"   bitsize="32" offset="4484" encoding="uint" format="hex" group="System Registers" dwarf_regnum="152" />
+  <reg name="syscfg"     altname="s18"   bitsize="32" offset="4488" encoding="uint" format="hex" group="System Registers" dwarf_regnum="153" />
+  <reg name="segment"    altname="s19"   bitsize="32" offset="4492" encoding="uint" format="hex" group="System Registers" dwarf_regnum="154" />
+  <reg name="ipendad"    altname="s20"   bitsize="32" offset="4496" encoding="uint" format="hex" group="System Registers" dwarf_regnum="155" />
+  <reg name="vid"        altname="s21"   bitsize="32" offset="4500" encoding="uint" format="hex" group="System Registers" dwarf_regnum="156" />
+  <reg name="vid1"       altname="s22"   bitsize="32" offset="4504" encoding="uint" format="hex" group="System Registers" dwarf_regnum="157" />
+  <reg name="bestwait"   altname="s23"   bitsize="32" offset="4508" encoding="uint" format="hex" group="System Registers" dwarf_regnum="158" />
+  <reg name="s24"                        bitsize="32" offset="4512" encoding="uint" format="hex" group="System Registers" dwarf_regnum="159" />
+  <reg name="schedcfg"   altname="s25"   bitsize="32" offset="4516" encoding="uint" format="hex" group="System Registers" dwarf_regnum="160" />
+  <reg name="s26"                        bitsize="32" offset="4520" encoding="uint" format="hex" group="System Registers" dwarf_regnum="161" />
+  <reg name="cfgbase"    altname="s27"   bitsize="32" offset="4524" encoding="uint" format="hex" group="System Registers" dwarf_regnum="162" />
+  <reg name="diag"       altname="s28"   bitsize="32" offset="4528" encoding="uint" format="hex" group="System Registers" dwarf_regnum="163" />
+  <reg name="rev"        altname="s29"   bitsize="32" offset="4532" encoding="uint" format="hex" group="System Registers" dwarf_regnum="164" />
+  <reg name="pcyclelo"   altname="s30"   bitsize="32" offset="4536" encoding="uint" format="hex" group="System Registers" dwarf_regnum="165" />
+  <reg name="pcyclehi"   altname="s31"   bitsize="32" offset="4540" encoding="uint" format="hex" group="System Registers" dwarf_regnum="166" />
+  <reg name="isdbst"     altname="s32"   bitsize="32" offset="4544" encoding="uint" format="hex" group="System Registers" dwarf_regnum="167" />
+  <reg name="isdbcfg0"   altname="s33"   bitsize="32" offset="4548" encoding="uint" format="hex" group="System Registers" dwarf_regnum="168" />
+  <reg name="isdbcfg1"   altname="s34"   bitsize="32" offset="4552" encoding="uint" format="hex" group="System Registers" dwarf_regnum="169" />
+  <reg name="livelock"   altname="s35"   bitsize="32" offset="4556" encoding="uint" format="hex" group="System Registers" dwarf_regnum="170" />
+  <reg name="brkptpc0"   altname="s36"   bitsize="32" offset="4560" encoding="uint" format="hex" group="System Registers" dwarf_regnum="171" />
+  <reg name="brkptcfg0"  altname="s37"   bitsize="32" offset="4564" encoding="uint" format="hex" group="System Registers" dwarf_regnum="172" />
+  <reg name="brkptpc1"   altname="s38"   bitsize="32" offset="4568" encoding="uint" format="hex" group="System Registers" dwarf_regnum="173" />
+  <reg name="brkptcfg1"  altname="s39"   bitsize="32" offset="4572" encoding="uint" format="hex" group="System Registers" dwarf_regnum="174" />
+  <reg name="isdbmbxin"  altname="s40"   bitsize="32" offset="4576" encoding="uint" format="hex" group="System Registers" dwarf_regnum="175" />
+  <reg name="isdbmbxout" altname="s41"   bitsize="32" offset="4580" encoding="uint" format="hex" group="System Registers" dwarf_regnum="176" />
+  <reg name="isdben"     altname="s42"   bitsize="32" offset="4584" encoding="uint" format="hex" group="System Registers" dwarf_regnum="177" />
+  <reg name="isdbgpr"    altname="s43"   bitsize="32" offset="4588" encoding="uint" format="hex" group="System Registers" dwarf_regnum="178" />
+  <reg name="pmucnt4"    altname="s44"   bitsize="32" offset="4592" encoding="uint" format="hex" group="System Registers" dwarf_regnum="179" />
+  <reg name="pmucnt5"    altname="s45"   bitsize="32" offset="4596" encoding="uint" format="hex" group="System Registers" dwarf_regnum="180" />
+  <reg name="pmucnt6"    altname="s46"   bitsize="32" offset="4600" encoding="uint" format="hex" group="System Registers" dwarf_regnum="181" />
+  <reg name="pmucnt7"    altname="s47"   bitsize="32" offset="4604" encoding="uint" format="hex" group="System Registers" dwarf_regnum="182" />
+  <reg name="pmucnt0"    altname="s48"   bitsize="32" offset="4608" encoding="uint" format="hex" group="System Registers" dwarf_regnum="183" />
+  <reg name="pmucnt1"    altname="s49"   bitsize="32" offset="4612" encoding="uint" format="hex" group="System Registers" dwarf_regnum="184" />
+  <reg name="pmucnt2"    altname="s50"   bitsize="32" offset="4616" encoding="uint" format="hex" group="System Registers" dwarf_regnum="185" />
+  <reg name="pmucnt3"    altname="s51"   bitsize="32" offset="4620" encoding="uint" format="hex" group="System Registers" dwarf_regnum="186" />
+  <reg name="pmuevtcfg"  altname="s52"   bitsize="32" offset="4624" encoding="uint" format="hex" group="System Registers" dwarf_regnum="187" />
+  <reg name="pmustid0"   altname="s53"   bitsize="32" offset="4628" encoding="uint" format="hex" group="System Registers" dwarf_regnum="188" />
+  <reg name="pmuevtcfg1" altname="s54"   bitsize="32" offset="4632" encoding="uint" format="hex" group="System Registers" dwarf_regnum="189" />
+  <reg name="pmustid1"   altname="s55"   bitsize="32" offset="4636" encoding="uint" format="hex" group="System Registers" dwarf_regnum="190" />
+  <reg name="timerlo"    altname="s56"   bitsize="32" offset="4640" encoding="uint" format="hex" group="System Registers" dwarf_regnum="191" />
+  <reg name="timerhi"    altname="s57"   bitsize="32" offset="4644" encoding="uint" format="hex" group="System Registers" dwarf_regnum="192" />
+  <reg name="pmucfg"     altname="s58"   bitsize="32" offset="4648" encoding="uint" format="hex" group="System Registers" dwarf_regnum="193" />
+  <reg name="rgdr2"      altname="s59"   bitsize="32" offset="4652" encoding="uint" format="hex" group="System Registers" dwarf_regnum="194" />
+  <reg name="rgdr"       altname="s60"   bitsize="32" offset="4656" encoding="uint" format="hex" group="System Registers" dwarf_regnum="195" />
+  <reg name="turkey"     altname="s61"   bitsize="32" offset="4660" encoding="uint" format="hex" group="System Registers" dwarf_regnum="196" />
+  <reg name="duck"       altname="s62"   bitsize="32" offset="4664" encoding="uint" format="hex" group="System Registers" dwarf_regnum="197" />
+  <reg name="chicken"    altname="s63"   bitsize="32" offset="4668" encoding="uint" format="hex" group="System Registers" dwarf_regnum="198" />
+  <reg name="commit1t"   altname="s64"   bitsize="32" offset="4672" encoding="uint" format="hex" group="System Registers" dwarf_regnum="231" />
+
+  <reg name="gelr"       altname="g0"    bitsize="32" offset="4756" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="199" />
+  <reg name="gsr"        altname="g1"    bitsize="32" offset="4760" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="200" />
+  <reg name="gosp"       altname="g2"    bitsize="32" offset="4764" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="201" />
+  <reg name="gbadva"     altname="g3"    bitsize="32" offset="4768" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="202" />
+  <reg name="gcommit1t"  altname="g4"    bitsize="32" offset="4772" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="203" />
+  <reg name="gcommit2t"  altname="g5"    bitsize="32" offset="4776" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="204" />
+  <reg name="gcommit3t"  altname="g6"    bitsize="32" offset="4780" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="205" />
+  <reg name="gcommit4t"  altname="g7"    bitsize="32" offset="4784" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="206" />
+  <reg name="gcommit5t"  altname="g8"    bitsize="32" offset="4788" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="207" />
+  <reg name="gcommit6t"  altname="g9"    bitsize="32" offset="4792" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="208" />
+  <reg name="gpcycle1t"  altname="g10"   bitsize="32" offset="4796" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="209" />
+  <reg name="gpcycle2t"  altname="g11"   bitsize="32" offset="4800" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="210" />
+  <reg name="gpcycle3t"  altname="g12"   bitsize="32" offset="4804" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="211" />
+  <reg name="gpcycle4t"  altname="g13"   bitsize="32" offset="4808" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="212" />
+  <reg name="gpcycle5t"  altname="g14"   bitsize="32" offset="4812" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="213" />
+  <reg name="gpcycle6t"  altname="g15"   bitsize="32" offset="4816" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="214" />
+  <reg name="gpmucnt4"   altname="g16"   bitsize="32" offset="4820" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="215" />
+  <reg name="gpmucnt5"   altname="g17"   bitsize="32" offset="4824" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="216" />
+  <reg name="gpmucnt6"   altname="g18"   bitsize="32" offset="4828" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="217" />
+  <reg name="gpmucnt7"   altname="g19"   bitsize="32" offset="4832" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="218" />
+  <reg name="gcommit7t"  altname="g20"   bitsize="32" offset="4836" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="219" />
+  <reg name="gcommit8t"  altname="g21"   bitsize="32" offset="4840" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="220" />
+  <reg name="gpcycle7t"  altname="g22"   bitsize="32" offset="4844" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="221" />
+  <reg name="gpcycle8t"  altname="g23"   bitsize="32" offset="4848" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="222" />
+  <reg name="gpcyclelo"  altname="g24"   bitsize="32" offset="4852" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="223" />
+  <reg name="gpcyclehi"  altname="g25"   bitsize="32" offset="4856" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="224" />
+  <reg name="gpmucnt0"   altname="g26"   bitsize="32" offset="4860" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="225" />
+  <reg name="gpmucnt1"   altname="g27"   bitsize="32" offset="4864" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="226" />
+  <reg name="gpmucnt2"   altname="g28"   bitsize="32" offset="4868" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="227" />
+  <reg name="gpmucnt3"   altname="g29"   bitsize="32" offset="4872" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="228" />
+  <reg name="g30"                        bitsize="32" offset="4876" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="229" />
+  <reg name="g31"                        bitsize="32" offset="4880" encoding="uint" format="hex" group="Guest Registers"  dwarf_regnum="230" />
+
+</feature>
-- 
2.34.1


