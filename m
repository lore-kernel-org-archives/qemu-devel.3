Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 735C9C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 20:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjMwH-0005j2-7N; Mon, 13 Jul 2026 16:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wjMwF-0005ii-Ma
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 16:07:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wjMwD-0006RI-9G
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 16:07:39 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DJ9HaP2470645
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 20:07:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=0RwOwWJ+1m4
 ksLHHFGRQQ2RntwVgVi7n4jRHu12AORw=; b=ZoRP7bS6EQteEuSOAlkgXxXFdgq
 ejv/8um3tJCadxzRgwhqaImxTlLcJ0MGei3/Bs83v6BJPtAKd5CAotqrDoa8baUA
 AK/9yoeYYl+FLWuUU2ACfHdzciFPDP883RGaj7pRrfwrtZD/HE4ivh6ILtkFz29W
 mJiG55D+wS8G6NA0a5YDNbesbq2X6GgQtOe9fe4jcswOS1W7/6ETHrogvtRfcHEQ
 tcMv6ZnRN0J7TtCaClOhb7fEP1SPLChLF1+1eGRIjOnzPwPHic6zNQtdSrf61Nrn
 fPjTBxH1iyV9uw4pfM2M5tuJ5TUD7fqw92kEvmZxKFoHfTcn0EdBCyumIag==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44jrmen-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 20:07:36 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-380b630c505so4278957a91.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 13:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783973255; x=1784578055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0RwOwWJ+1m4ksLHHFGRQQ2RntwVgVi7n4jRHu12AORw=;
 b=bYkkd8TUVeOgNIW38F/HZyAEbROeZt7MSJNx5kiMXtob6PmJH1GTJUTkAf2r7Swjjq
 lDXW4+ma+FDkBFiY5l8Q3A1YdmYyld/k1Vd+3kUoT8kHDbHwel4b+aRrlvsDS7paR9or
 3cCEUnGXqyzllAhC9uWZap2UwN6iX1Smm78OiEgWfcMkVhYujCJIcLcPRbBBUrv3LnFB
 8ssCngK7Ua/x/VnpkubUiB/1hHfaIzWS/vb9wUMBiiCr2heB5iSnZv1BPBftQ/SpT6Jk
 RleyLzeRZvbCoNI0kO+6MRvJA4YcgaFAMMB5ga8YGqhxoKWLHpII3826AOdk0YFxKrYW
 f7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783973255; x=1784578055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0RwOwWJ+1m4ksLHHFGRQQ2RntwVgVi7n4jRHu12AORw=;
 b=MWsojBommnvYo3E6Wg0nuAflSDa7if+X9FPB7mqd0pz8WUUSwUdMNvF+qMu9xZP2FT
 UZxGINuZhl1DI0aZIWq6Q5yEoGDHJd/VXRW3IeS46cK8oIi7BPjB8oUm9uB56ideEk6s
 HqcAZ4kdY0i3kYYyhtrJGAKdAs47AQKk+7Z3rRD6lkZVNKTemBFlpHpYhmJltDHCv85h
 DdEQuNZHFT37QuRq3WfJeQ+LU61W1t5oWj1jIfp2wBYZKlT4Q2nMJTv8b+CNmnrx6TIU
 FLOAZoWxz1q2Ygfzn3e29PLIG9+0Ht6tjLWVrxF6Z6y2iQtGEp3Vn9pWAuUTGO/tkz3S
 QqOQ==
X-Gm-Message-State: AOJu0YzG9Jm1yppxEfPnaSSLy2w0hrUwyKbbBG8XR4ctDWrj7PCsUDc0
 Ow3TTXCYSCEKOpg8QGlUjUNyLyXRnNWEaJU10E1ad0HR7Wn94Dd/gcDbb56UoyeF3zxetaBmQOq
 /NeM+P8GSUCr6LWJhIkA9mIQKpxnC2WSQ99fzo59lQH352OoGhDc8MRPRhvjrFgbLYGCy
X-Gm-Gg: AfdE7clh5xfveZwTFto7dU8r1Ybn6JZ/yTKPJY6j1gUySOX9ysm9pk9dhHA3MBtKxZt
 e54QKcsCxDIhduNqF0XhBH5uNzbJ522EAqTErYXWJB7gn5iqdoQpHbuH+oreZHvcVaooTplpHDc
 bvD2M1WmrPXbVmaNhGSw+6RHgyrUnlPFMxz4jlzWICGNTw1N0lRCrtXh0+mVus44/tq4ybQ8+MF
 qCu8VMmo7LZD6YswRcwoty4hYnSsqd3SoRSTR1h+60QcO4lkPCo7EquLod2ZAfigmlTVKVdK32Y
 pzEnRJ8FMkYQIxgNcZbZptJiXvCmEDt33z9ncMgCnZ6tZMrBDYG6C+TmyG5nTQ/wALO9WWHCWOE
 3jDOnAiX+N51JmDAREHVgBT5/z633/K3QM4TycTDdkenyp5B7/+vvQm2fmsnx0xAqJIj05Iip1Q
 ==
X-Received: by 2002:a17:90b:2750:b0:37c:18e0:90dc with SMTP id
 98e67ed59e1d1-38dc75ebea3mr9970799a91.16.1783973255192; 
 Mon, 13 Jul 2026 13:07:35 -0700 (PDT)
X-Received: by 2002:a17:90b:2750:b0:37c:18e0:90dc with SMTP id
 98e67ed59e1d1-38dc75ebea3mr9970776a91.16.1783973254624; 
 Mon, 13 Jul 2026 13:07:34 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-313cb804197sm24106543eec.13.2026.07.13.13.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 13:07:34 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 07/14] target/hexagon: add semihosting support
Date: Mon, 13 Jul 2026 13:07:15 -0700
Message-Id: <e01b8e57d6b35eef078c0a9e2d663d3c36755b94.1783973054.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: lSqvMtweZ3ZrzzW7MIOiu6UfCOxUzsPm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIwOCBTYWx0ZWRfXw2A7IphmuyBd
 La7p3mplyho5LjGoOU9Gsyp6w4/y62cAozWiBmQR97u4hLtbi0iRlhG//zRkxP417ZX0qSkEFtm
 Lpfkz0cr2N8sMtwk4fL+D3l3qW5uJ+BI4MRBj36wACQgVbPGVMkJlpFEIZ4TQfS7desARQNbE4Y
 6otdzRQF2dE/Xx6uAkLAZVnUYm/2FPRQ3sHl4VrferbBZ566PGEp2aY+vd1N0Ze6WhbI16rjcmJ
 BQBG7MDI+JHinY2hKhXyZAYGF9Y0PFudDuyK1t2rKMXbh6Ej/Bn3zcfi7OuZahs/k2oRP9FCOkf
 w6vHQB77Uk9o8VzvC5SziOvGB5L4oSLX6oQqkmhSS97bGS/OODnaSopMbSoG0MvxWEelOEIDVO3
 iCvEhVAgYHQlpaYdHatL4Pv9PCDF2KwTw8sEuS3ELRGkklaAJRpikACidGTgGM4YE2CNcFZcugT
 rSY1hrLKkBPQJFRZNwQ==
X-Authority-Analysis: v=2.4 cv=XonK/1F9 c=1 sm=1 tr=0 ts=6a554588 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=QDQZMBKZCXjBuAy7nZgA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: lSqvMtweZ3ZrzzW7MIOiu6UfCOxUzsPm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIwOCBTYWx0ZWRfX0In3SD/eQhqG
 sTIhaFp4efPBi5LKmbxH78otOQjcX82a3KxKO14dLdAvDqq13ilGVcDxAqPKmDFNxaMBNGfxzKj
 8C47Gk/UdvWCTCcECL+Pxc9QDatpAMs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130208
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
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

From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>

Baremetal Hexagon programs use trap0 #0 to invoke
semihosting calls for I/O and process control.  Wire up the
arm-compatible semihosting framework for softmmu by enabling
CONFIG_ARM_COMPATIBLE_SEMIHOSTING and routing trap0 to the
semihosting handler.

Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 configs/targets/hexagon-softmmu.mak |   2 +
 hw/hexagon/hexagon_dsp.c            |   2 +
 target/hexagon/common-semi-target.c |  51 +++++++++
 target/hexagon/hexswi.c             | 164 +++++++++++++++++++++++++++-
 hw/hexagon/Kconfig                  |   1 +
 qemu-options.hx                     |   8 +-
 target/hexagon/meson.build          |   3 +
 7 files changed, 224 insertions(+), 7 deletions(-)
 create mode 100644 target/hexagon/common-semi-target.c

diff --git a/configs/targets/hexagon-softmmu.mak b/configs/targets/hexagon-softmmu.mak
index a77c100f0c5..6cbdc64be56 100644
--- a/configs/targets/hexagon-softmmu.mak
+++ b/configs/targets/hexagon-softmmu.mak
@@ -6,3 +6,5 @@ TARGET_LONG_BITS=32
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
 TARGET_NEED_FDT=y
+CONFIG_SEMIHOSTING=y
+CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
diff --git a/hw/hexagon/hexagon_dsp.c b/hw/hexagon/hexagon_dsp.c
index aa493993229..315733cded3 100644
--- a/hw/hexagon/hexagon_dsp.c
+++ b/hw/hexagon/hexagon_dsp.c
@@ -27,6 +27,7 @@
 #include "target/hexagon/internal.h"
 #include "system/physmem.h"
 #include "system/reset.h"
+#include "semihosting/semihost.h"
 
 #include "machine_cfg_v66g_1024.h.inc"
 
@@ -178,6 +179,7 @@ static void init_mc(MachineClass *mc)
     mc->no_serial = 1;
     mc->is_default = false;
     mc->max_cpus = 8;
+    qemu_semihosting_enable();
 }
 
 /* ----------------------------------------------------------------- */
diff --git a/target/hexagon/common-semi-target.c b/target/hexagon/common-semi-target.c
new file mode 100644
index 00000000000..9a7720514bb
--- /dev/null
+++ b/target/hexagon/common-semi-target.c
@@ -0,0 +1,51 @@
+/*
+ * Target-specific parts of semihosting/arm-compat-semi.c.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "cpu_helper.h"
+#include "semihosting/common-semi.h"
+
+uint64_t common_semi_arg(CPUState *cs, int argno)
+{
+    CPUHexagonState *env = cpu_env(cs);
+    return arch_get_thread_reg(env, HEX_REG_R00 + argno);
+}
+
+void common_semi_set_ret(CPUState *cs, uint64_t ret)
+{
+    CPUHexagonState *env = cpu_env(cs);
+    arch_set_thread_reg(env, HEX_REG_R00, ret);
+}
+
+void common_semi_set_err(CPUState *cs, int err)
+{
+    CPUHexagonState *env = cpu_env(cs);
+    arch_set_thread_reg(env, HEX_REG_R01, err);
+}
+
+bool common_semi_sys_exit_is_extended(CPUState *cs)
+{
+    return false;
+}
+
+bool is_64bit_semihosting(CPUArchState *env)
+{
+    return false;
+}
+
+uint64_t common_semi_stack_bottom(CPUState *cs)
+{
+    CPUHexagonState *env = cpu_env(cs);
+    return arch_get_thread_reg(env, HEX_REG_SP);
+}
+
+bool common_semi_has_synccache(CPUArchState *env)
+{
+    return false;
+}
diff --git a/target/hexagon/hexswi.c b/target/hexagon/hexswi.c
index 43c373ea2ee..ce9c85ad6aa 100644
--- a/target/hexagon/hexswi.c
+++ b/target/hexagon/hexswi.c
@@ -24,9 +24,168 @@
 #error "This file is only used in system emulation"
 #endif
 
+#include "semihosting/common-semi.h"
+#include "semihosting/console.h"
+#include "semihosting/syscalls.h"
+#include "semihosting/guestfd.h"
+#include "system/runstate.h"
+
+/* non-arm-compatible semihosting calls */
+#define HEXAGON_SPECIFIC_SWI_FLAGS \
+    DEF_SWI_FLAG(OPEN,             0x01) \
+    DEF_SWI_FLAG(ISTTY,            0x09) \
+    DEF_SWI_FLAG(HEAPINFO,         0x16) \
+    DEF_SWI_FLAG(EXCEPTION,        0x18) \
+    DEF_SWI_FLAG(SEEK,             0x0A) \
+    DEF_SWI_FLAG(READ_CYCLES,      0x40) \
+    DEF_SWI_FLAG(PROF_ON,          0x41) \
+    DEF_SWI_FLAG(PROF_OFF,         0x42) \
+    DEF_SWI_FLAG(WRITECREG,        0x43) \
+    DEF_SWI_FLAG(READ_TCYCLES,     0x44) \
+    DEF_SWI_FLAG(LOG_EVENT,        0x45) \
+    DEF_SWI_FLAG(REDRAW,           0x46) \
+    DEF_SWI_FLAG(READ_ICOUNT,      0x47) \
+    DEF_SWI_FLAG(PROF_STATSRESET,  0x48) \
+    DEF_SWI_FLAG(DUMP_PMU_STATS,   0x4a) \
+    DEF_SWI_FLAG(READ_PCYCLES,     0x52) \
+    DEF_SWI_FLAG(COREDUMP,         0xCD) \
+    DEF_SWI_FLAG(FTELL,            0x100) \
+    DEF_SWI_FLAG(FSTAT,            0x101) \
+    DEF_SWI_FLAG(STAT,             0x103) \
+    DEF_SWI_FLAG(GETCWD,           0x104) \
+    DEF_SWI_FLAG(ACCESS,           0x105) \
+    DEF_SWI_FLAG(OPENDIR,          0x180) \
+    DEF_SWI_FLAG(CLOSEDIR,         0x181) \
+    DEF_SWI_FLAG(READDIR,          0x182) \
+    DEF_SWI_FLAG(EXEC,             0x185) \
+    DEF_SWI_FLAG(FTRUNC,           0x186)
+
+/*
+ * We use the arm-compatible semihosting routines for these ones, but we do
+ * need some hexagon-specific preprocessing.
+ */
+#define HEX_SYS_WRITE       0x05
+#define HEX_SYS_READ        0x06
+#define HEX_SYS_READC       0x07
+
+#define DEF_SWI_FLAG(name, val) HEX_SYS_ ##name = val,
+enum hex_swi_flag {
+    HEXAGON_SPECIFIC_SWI_FLAGS
+};
+#undef DEF_SWI_FLAG
+
+#define DEF_SWI_FLAG(_, val) case val:
+static inline bool is_hexagon_specific_swi_flag(enum hex_swi_flag what_swi)
+{
+    switch (what_swi) {
+    HEXAGON_SPECIFIC_SWI_FLAGS
+        return true;
+    }
+    return false;
+}
+#undef DEF_SWI_FLAG
+
+static void init_semihosting_guestfds(void)
+{
+    static gsize initialized;
+
+    if (g_once_init_enter(&initialized)) {
+        if (qemu_semihosting_console_has_chardev()) {
+            alloc_guestfd();
+            console_guestfd(0);
+            alloc_guestfd();
+            console_guestfd(1);
+            alloc_guestfd();
+            console_guestfd(2);
+        } else {
+            alloc_guestfd();
+            associate_guestfd(0, 0);
+            alloc_guestfd();
+            associate_guestfd(1, 1);
+            alloc_guestfd();
+            associate_guestfd(2, 2);
+        }
+        g_once_init_leave(&initialized, 1);
+    }
+}
+
+static void do_preload(CPUHexagonState *env, target_ulong swi_info, bool load)
+{
+    uint32_t addr, count;
+    uintptr_t retaddr = 0;
+
+    hexagon_read_memory(env, swi_info + 4, 4, &addr, retaddr);
+    hexagon_read_memory(env, swi_info + 8, 4, &count, retaddr);
+    hexagon_touch_memory(env, addr, count, retaddr);
+}
+
+static void sim_handle_trap0(CPUHexagonState *env)
+{
+    target_ulong what_swi, swi_info;
+    G_GNUC_UNUSED uintptr_t retaddr = 0;
+    CPUState *cs = env_cpu(env);
+
+    g_assert(bql_locked());
+    init_semihosting_guestfds();
+
+    what_swi = arch_get_thread_reg(env, HEX_REG_R00);
+    swi_info = arch_get_thread_reg(env, HEX_REG_R01);
+
+    qemu_log_mask(CPU_LOG_INT,
+                  "sim_handle_trap0: swi=0x%" PRIx32
+                  " info=0x%" PRIx32 " PC=0x%" PRIx32
+                  " thread=%" PRId32 "\n",
+                  (uint32_t)what_swi, (uint32_t)swi_info,
+                  (uint32_t)arch_get_thread_reg(env, HEX_REG_PC),
+                  (uint32_t)env->threadId);
+
+    if (!is_hexagon_specific_swi_flag(what_swi)) {
+        if (what_swi == HEX_SYS_READ || what_swi == HEX_SYS_READC ||
+            what_swi == HEX_SYS_WRITE) {
+            /*
+             * Avoid page faults if the buffer is not in memory yet.
+             * NOTE: Counterintuitive, but a WRITE must be able to LOAD from
+             * the input address. The contents of that buffer will be
+             * directed to the SWI interface.
+             */
+            do_preload(env, swi_info, (what_swi == HEX_SYS_WRITE));
+        }
+        /*
+         * ARM-compat semihosting SWI numbers are all <= 0x31.
+         * If R0 holds a value outside that range (e.g. guest code
+         * executing trap0(#0) with an arbitrary R0), treat it as an
+         * unrecognized request rather than forwarding to
+         * do_common_semihosting() which would abort.
+         */
+        if (what_swi > 0x31) {
+            qemu_log_mask(LOG_UNIMP,
+                          "trap0(#0): unrecognized request in r0: "
+                          "0x" TARGET_FMT_lx "\n", what_swi);
+            return;
+        }
+        do_common_semihosting(cs);
+        return;
+    }
+
+    switch (what_swi) {
+
+    case HEX_SYS_EXCEPTION:
+        arch_set_system_reg(env, HEX_SREG_MODECTL, 0);
+        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+        break;
+
+    /* TODO: implement other hexagon-specific semihosting calls */
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "unknown swi request: 0x%" PRIx32 "\n",
+                      (uint32_t)what_swi);
+        common_semi_cb(cs, -1, ENOSYS);
+    }
+}
+
 static void set_addresses(CPUHexagonState *env, uint32_t pc_offset,
                           uint32_t exception_index)
-
 {
     HexagonCPU *cpu = env_archcpu(env);
     uint32_t evb = cpu->globalregs ?
@@ -95,8 +254,7 @@ void hexagon_cpu_do_interrupt(CPUState *cs)
     switch (cs->exception_index) {
     case HEX_EVENT_TRAP0:
         if (env->cause_code == 0) {
-            qemu_log_mask(LOG_UNIMP,
-                          "trap0 is unhandled, no semihosting available\n");
+            sim_handle_trap0(env);
         }
 
         hexagon_ssr_set_cause(env, env->cause_code);
diff --git a/hw/hexagon/Kconfig b/hw/hexagon/Kconfig
index 52065ab3b22..3a8ff17812b 100644
--- a/hw/hexagon/Kconfig
+++ b/hw/hexagon/Kconfig
@@ -2,6 +2,7 @@ config HEX_DSP
     bool
     default y
     depends on HEXAGON
+    select ARM_COMPATIBLE_SEMIHOSTING
 
 config HEX_VIRT
     bool
diff --git a/qemu-options.hx b/qemu-options.hx
index 34970fffc94..56f42b02c8a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -5507,7 +5507,7 @@ ERST
 DEF("semihosting", 0, QEMU_OPTION_semihosting,
     "-semihosting    semihosting mode\n",
     QEMU_ARCH_ARM | QEMU_ARCH_M68K | QEMU_ARCH_XTENSA |
-    QEMU_ARCH_MIPS | QEMU_ARCH_RISCV)
+    QEMU_ARCH_MIPS | QEMU_ARCH_RISCV | QEMU_ARCH_HEXAGON)
 SRST
 ``-semihosting``
     Enable :ref:`Semihosting` mode (ARM, M68K, Xtensa, MIPS, RISC-V only).
@@ -5523,11 +5523,11 @@ DEF("semihosting-config", HAS_ARG, QEMU_OPTION_semihosting_config,
     "-semihosting-config [enable=on|off][,target=native|gdb|auto][,chardev=id][,userspace=on|off][,arg=str[,...]]\n" \
     "                semihosting configuration\n",
 QEMU_ARCH_ARM | QEMU_ARCH_M68K | QEMU_ARCH_XTENSA |
-QEMU_ARCH_MIPS | QEMU_ARCH_RISCV)
+QEMU_ARCH_MIPS | QEMU_ARCH_RISCV | QEMU_ARCH_HEXAGON)
 SRST
 ``-semihosting-config [enable=on|off][,target=native|gdb|auto][,chardev=id][,userspace=on|off][,arg=str[,...]]``
-    Enable and configure :ref:`Semihosting` (ARM, M68K, Xtensa, MIPS, RISC-V
-    only).
+    Enable and configure :ref:`Semihosting` (ARM, M68K, Xtensa, MIPS, RISC-V,
+    Hexagon only).
 
     .. warning::
       Note that this allows guest direct access to the host filesystem, so
diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
index 59cb09c1070..69f01bd2f70 100644
--- a/target/hexagon/meson.build
+++ b/target/hexagon/meson.build
@@ -262,6 +262,9 @@ hexagon_softmmu_ss.add(files(
     'machine.c',
 ))
 
+hexagon_softmmu_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
+                       if_true: files('common-semi-target.c'))
+
 #
 # Step 4.5
 # We use flex/bison based idef-parser to generate TCG code for a lot
-- 
2.37.2


