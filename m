Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42710607E05F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dqlF/SNg;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N8fpsvMd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRv2c-0003lX-MW; Fri, 13 Nov 2026 12:26:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xRv2V-0003gM-By
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 12:26:15 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xRv2T-0000Ne-Bv
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 12:26:15 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ADFR7Rp552097
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 17:26:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=xVkVvSsKHnaEAo+f3boj3mxYt/NF32KmTde
 V7RH7DsQ=; b=dqlF/SNgCY/yBDfiNpQRDtW2BpzlYNKjb36MIvJzmJYTn8SZO8l
 Ixrxa8rpa7XA9wWsnNN3ZJItvJDVYbJBZMAl9skkOKzQ/gtCnngSXsYUgbNRaiTj
 iRhgc1hM6v16+ffv+cRQBzGblkFcwPT0dZ1Jan1A+QO6LAiErMLXItKhelUyvVPz
 V7SyfEaF359UUWMrNeCSv4YP+2Og1A6iqrIN4fX7y+SbG6Of1T2Y1xTUNFKJVlyD
 vWQu+mhrl7/FqaKNhTpPisiSdPpwnVZwg+EaqWYQXLN+Fwo+1qwfxT5FVdM1wATV
 HatRQw0xyN3dEX+7t3KtivGdlKG2NvTy4gw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwkgwc1fb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 17:26:09 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9495a1f5e47so98158385a.1
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 09:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794590768; x=1795195568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xVkVvSsKHnaEAo+f3boj3mxYt/NF32KmTdeV7RH7DsQ=;
 b=N8fpsvMdpLy5O+AHBVutO3oVP6HVTYYNeri/IG9Xs4CkxWnKicdx+gBxrufSxlP/I3
 0DXehgAutZAefyeAP3BRvboZ+Qiy4zHL5Z0qh6PjI3gSUlLxgOj9WMHyw/hAaB8LV/Jw
 aiC4L+UQaazDgRKK10HethVAKKZPe4u0DWdnQgNTKQX35tEdM77uXcEIW2DeGCmWNcgq
 +Jc5ttBVODtS836aAO8Aqpku3GZhApf416UXKHniKXEfGYbtd0LyRkho+h838+h1AeQi
 Frf//JSVupj2xRpuXSvF29wjdhCFbOnx20vvmJJSWrYSl/qVmBaTvpNpMvA/qa+lmzHx
 NWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794590768; x=1795195568;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xVkVvSsKHnaEAo+f3boj3mxYt/NF32KmTdeV7RH7DsQ=;
 b=ms/RdaxJHyUy1xetWizgIVuCComF3Z2Bf48jRtw0u22v5Fs1qsVgp9xprQYx+b89Kk
 hxqtgmjaGTGsfrUc4kcK5jaKcF2o61tgb1cUjnUHauEjRHgdugWaLnwC4f3tyl/Vbs/M
 AiBGOFkAl38qqlw8ZYJPvNiQ/tWkeWRFu5/AkRZq2gytvRcRM3GKSWrV7DMT5wyeZQQg
 tf0KKpZWSfBOJUShxdxj9D12wFtpTrCvR+RDqNyF6e3wdgHoh0IkwUjy/GMWo672BFT7
 bniPF7ie982UKW/MZt49e4JzGu9bXUEuQSaso/la7QBsj72WPTneRPfhtRu+zwxWrCiQ
 VLVw==
X-Gm-Message-State: APuU4Z93e6ar3ss8AsmO1+vDodoIJtKejhBBfghhCgxUswSm0ccPJp+/
 03QgZlIGHa39CkyQanwkYZllx+LvvVbbt0QWB/lEOG1i9LkFxSMqgmGl5PFry15JeNARX2SqQpl
 sa0L/5l1oS3AhJ//4ji2ql+JiwuJaD/4BXauWq/JBbInzUYCq5UNnIOKiKv0FxbtTAg==
X-Gm-Gg: AYBFou3iO4sNTsffZBS9j8n68AgpoIca1WHUUzOZYCe0GJxM+GC9feMvt/CH9Q1wbwm
 QfBEK6GdxnuHKDaDFgqT1eApDOTdQROS2ZTV2H4VGMyh0qKUePScJQp8CLNhzlYY0YU3Vx0IPIN
 d0cbc49OUR0mI9zRQIvC15QKoF5/bxw9/dAHDGsu35h/PSXIoMaxMvdqqc2RUqs3hwxl/3Ex0qo
 iaAajewusqd8kEM+sRTIpKpSLKszkL8lygrnp/V9y5bl+qxcmyExg9Q49XqhlEXiNmcLW2yPo9S
 4LLimQgEtFKAQr4rnfDbjBMe+nkFHEXSDGwHHmyTG4JAIT2CdDZFTAPqxlaGoJJivcG5YuZVmUt
 A5GmpGjwsAHfDSB+DBXlXqj/9wVfzBZI8wYKYSKmZGPytc7QCL4iIe9RXFoDvFZU9zyO+gsh5Zk
 Hj6+PF1PT7PA==
X-Received: by 2002:a05:620a:2a14:b0:93b:e5e9:23d9 with SMTP id
 af79cd13be357-9494bbb679emr540220885a.23.1794590768273; 
 Fri, 13 Nov 2026 09:26:08 -0800 (PST)
X-Received: by 2002:a05:620a:2a14:b0:93b:e5e9:23d9 with SMTP id
 af79cd13be357-9494bbb679emr540214585a.23.1794590767738; 
 Fri, 13 Nov 2026 09:26:07 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.237.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9494c8683desm226349485a.28.2026.11.13.09.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 09:26:07 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH] target/riscv: allow zicbo insns to run without RVS [GL4596]
Date: Fri, 13 Nov 2026 14:26:03 -0300
Message-ID: <20261113172603.107571-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DNgacCNb c=1 sm=1 tr=0 ts=6af74831 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=iNxvZbmf7GYCzVQazAudjg==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=KKjn5n9Ayip0tkzwBa4A:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: swQzyRWK68Q8ywWdswDaOVJHIiCJMo97
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA2OSBTYWx0ZWRfX2U6OfX2vTS83
 cJUFQe7fnhp2N6b7/MfaU444zMY9ksbEOvnWSckIPMLI2A00FnRkaQBB2iliybbB64AkNoi/jpW
 NmgErBnrSxE0Gyk3izXr0EyXegDRBxCSzJ9YGM7yPL+ijbxf/VLyGl6GvYXQBcO/vX5IK7jLg40
 TicWJ6WcmThkpKht68lk7VgNEfsuFRZmU2NvGR9qgOQ57y0MgS2hwmgYQL+pAPlSrQzsAugjM+j
 bRmLLHLw5gD3tvEIba3H4B0wJmTBXbszWj8ptYDu2zYMH4830wBfMDCUTBN1rZ2V36gEcOk6lEJ
 QUl+avMDpMX1G7iqou8Bz5BF9FmshpjstcjwuPJfkDQGZNcvl1egBxDxwgHzHhyWt/paSQU3FDw
 nN97+Jrli9ugmmLUSgfMz6Q9gnZ5jv49qEjLsf9yYo2TXd10exE+JfgdEPcpdII/uzsX403AJRz
 Hsr6cnzOT82IK77HxXA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA2OSBTYWx0ZWRfX0PxxnkQ+Qq0M
 M/uain5XFmA1LmvUlsb1rTFgpqGXTKPjugEt2zFu0m6T1TrgoO09fsWYg6iSUEqd6Q/8JqvkJff
 47zU5Bems9CkCC+5/KzvOsUh5X80ls0=
X-Proofpoint-GUID: swQzyRWK68Q8ywWdswDaOVJHIiCJMo97
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130069
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

check_zicbo_envcfg() is validating access using S-mode constraints that
are only relevant if we have RVS enabled in the hart.  If we have a hart
that has M-mode and U-mode, but not S mode, zicbo insns will always
fault.

Execute the exclusive S-mode checks only if RVS is present.

Fixes: a939c500793a ("target/riscv: implement Zicboz extension")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4596
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/op_helper.c         |  5 +-
 tests/tcg/riscv64/system/meson.build |  7 ++
 tests/tcg/riscv64/test-zicbo-umode.S | 98 ++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/riscv64/test-zicbo-umode.S

diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
index f9c79fe6b9..b87e18a886 100644
--- a/target/riscv/tcg/op_helper.c
+++ b/target/riscv/tcg/op_helper.c
@@ -172,7 +172,10 @@ static void check_zicbo_envcfg(CPURISCVState *env, target_ulong envbits,
         riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, ra);
     }
 
-    if ((env->priv < PRV_S) && !get_field(env->senvcfg, envbits)) {
+    /* Skip S-mode exclusive checks if we don't have RVS.  */
+    if (riscv_has_ext(env, RVS)
+        && env->priv < PRV_S
+        && !get_field(env->senvcfg, envbits)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, ra);
     }
 #endif
diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index 3c8b018d9e..3d6ef0fc42 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -89,6 +89,13 @@ tests += {
   }
 }
 
+tests += {
+  'test-zicbo-umode.S': {
+   'cflags': cflags + ['-march=rv64gcv_zicbom_zicboz'],
+    'qemu_args': ['-cpu', 'rv64,s=off,h=off,zicbom=on,zicboz=on', qemu_args],
+  }
+}
+
 if 'qemu-system-riscv64' in emulators
   tcg_tests += {
     'riscv64-softmmu': {
diff --git a/tests/tcg/riscv64/test-zicbo-umode.S b/tests/tcg/riscv64/test-zicbo-umode.S
new file mode 100644
index 0000000000..4ce91baafc
--- /dev/null
+++ b/tests/tcg/riscv64/test-zicbo-umode.S
@@ -0,0 +1,98 @@
+/*
+ * Test if cbo instructions are executable without S mode
+ * available.  Code derived from the Gitlab 4596 testcase.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define CSR_MENVCFG 0x30a
+#define MENVCFG_CB  ((1 << 7) | (1 << 6) | (1 << 4))  // CBZE | CBCFE | CBIE=01
+
+.option norvc
+	.text
+	.global _start
+
+_start:
+	lla	t0, trap
+	csrw	mtvec, t0
+
+	/*
+	 * PMP entry 0: NAPOT over all of memory, RWX, so U-mode
+	 * can fetch and access data.
+	 */
+	li	t0, -1
+	csrw	pmpaddr0, t0
+	li	t0, 0x1f
+	csrw	pmpcfg0, t0
+
+	/*
+	 * Enable the CBO instructions for U-mode and report what
+	 * menvcfg reads back.
+	 */
+	li	t0, MENVCFG_CB
+	csrs	CSR_MENVCFG, t0
+	csrr	s1, CSR_MENVCFG
+
+	// mret to U-mode at user_code (MPP = 0)
+	li	t0, 3 << 11
+	csrc	mstatus, t0
+	la	t0, user_code
+	csrw	mepc, t0
+	la	s2, cbo_step
+	mret
+
+user_code:
+	la 	a0, buffer       // address of buffer
+	li	t1, 1
+	sw	t1, 0(s2)
+	cbo.zero	(a0)
+	li	t1, 2
+	sw	t1, 0(s2)
+	cbo.clean	(a0)
+	li	t1, 3
+	sw	t1, 0(s2)
+	cbo.flush	(a0)
+	li	t1, 4
+	sw	t1, 0(s2)
+	cbo.inval	(a0)
+	ecall
+
+trap:
+	csrr s3, mcause
+	li t0, 8                   // environment call from U-mode
+	bne s3, t0, _fail
+	li	a0, 0
+	j	_exit
+
+_fail:
+	li	a0, 1
+	j	_exit
+
+# Exit code in a0
+_exit:
+	lla	a1, semiargs
+	li	t0, 0x20026	# ADP_Stopped_ApplicationExit
+	sd	t0, 0(a1)
+	sd	a0, 8(a1)
+	li	a0, 0x20	# TARGET_SYS_EXIT_EXTENDED
+
+	# Semihosting call sequence
+	.balign	16
+	slli	zero, zero, 0x1f
+	ebreak
+	srai	zero, zero, 0x7
+	j	.
+
+	.data
+
+	.balign	64
+cbo_step:
+	.word 0
+buffer:
+	.fill 64, 1, 0xa5
+
+	.balign	16
+semiargs:
+	.space	16
+
-- 
2.43.0


