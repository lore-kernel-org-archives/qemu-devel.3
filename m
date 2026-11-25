Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316B2606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 13:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RwsIq0Vn;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bPQw+trR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWCwj-0003It-98; Wed, 25 Nov 2026 08:22:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xWCwG-0002my-0i
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 08:21:34 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xWCwE-0000iD-1A
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 08:21:31 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AP9mHdY3763959
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 13:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=LH5/T/WTO2y
 +K7VE019zRy+Z3vALoCprjTmvlwdA3No=; b=RwsIq0Vngbh8/uuOZ7siutWAmIZ
 KBFicPSnSGYqtKXcCbm7yoV+OeTYMPLDclA90iOROInJc9h5c4BleYd1Y/HTB55f
 quCiMVElkte2++xd3lq18nWxMgy7lTYh0yIoenXZ8Q7VeeqqDoiUONHS3+RPyj63
 irOjMSs/sVIvlI4njtzPT/m+IBOIGUH7SyLcIphJ7zmxhdUlOUt1sOYMKs6o2NSg
 tSWLGWwih0EQ77voqnJgLLNfu+9YCohX5SumrOQ3218nyF03DvzkIcygX/yVszHq
 9XwbiCwvskAObh4gZg33Yz4hxICaS4eX7JHDRlyMTxhkLGdJ4XdNghAfU4Q==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5vv2ry1y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 13:21:17 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7d2dffa1186so924038137.1
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 05:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795612877; x=1796217677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LH5/T/WTO2y+K7VE019zRy+Z3vALoCprjTmvlwdA3No=;
 b=bPQw+trRQg07tHiPCkQef+uFuP9EenXNlBhNOzlW/GHf/vM03CuLY3vMNWvG3bnGk6
 LeCNUj9/oHDMmFc+BSFe1UJjM2yVXHUYI3zowMESdOYqfle1msYmAquzBQ04jQND686x
 2NLbkF5E8gOnJZTNxtpu/qmOJUvbwVQCGjIf8tpIy1kGfB18hXf06IAHYOooxu+V10vX
 uca7tFFzLgK0qq/CvQXnBhxUSu+kG3Fdn0o7KUxRr0vzlcSJ+SidwR6V7dmXhAX0ys+K
 iShlfABwrDNS4Rf9qXpCMYlkWOrGqKFjZaKKupqfdeP7RJ5/s40VHvTSMMpKSHGIZEf9
 JApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795612877; x=1796217677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LH5/T/WTO2y+K7VE019zRy+Z3vALoCprjTmvlwdA3No=;
 b=Zpqf5qCb2HGzowr1dWJbLeUGZuUDsY4Z4lGLXr1XkDXE31LC9rHcHvcHG7pCGK+1eV
 1mzgmZSKxhArYeJDgge5ATOk5P615Raz8zIs3JHgAI8xWMbQOZndwfz+Wdlvic1+LpEt
 93eP7xI+Ak3z48X7pH/xBZsEiAuokJ70bReJTmSLRT9gjNeL6/JRll2r9gsQpsL7mzqP
 xEVTGoZuSA6UeKoIXFOUlMJttIEV/HOh/E3rJt+izrSAfesjtjnIMVjHfG+ma29oGBti
 P5oONFXQoiq5QDRFxKOUIAAeGn5awWRNqnfEcpgqR2rNLSlmHZWC4AVztulAOo3xQO1M
 Pv2w==
X-Gm-Message-State: APuU4Z+OQuYwaDVSsrC2xHq55zC5JGblHyRt6Wp9Dr2WlN0ZVdEcnSfl
 8OdP8KwOdUiEmcDVFI+Foun5sc/hJ9TGax/4gD7TxzHSUxxHskzUtR3f4MmxCgCHzoLHUS7p6X7
 N5sjr69MsO2USC5aEE9AgtBhX7j/K8Uu/ZgEpAlCdE8unSFXshEBHyA2pWNXyG/k3Ng==
X-Gm-Gg: AZFdTZdTvU8Ka+6ntVVcN9YQPLC6cIDvWDT6+zYVHdUmaccQy8bCxXmBupD/C8ijXxP
 kj+ZM35szhpnV+z3UV6eu43IQJniqUcarrRA1vO7bld/op4eYld3gXYRhDTW6bSzFtPrhfdZg1v
 fVElV8OuuvQju0d1W0GvR/URXRDfOwkzcf7336+aiW0LSJ82Q61C4CpHQiGkmaF39TVutVXxgNq
 hQbLjf/2cS9zE6dHQGc2bdZ+/mbIk7p/S/TR3Qr0QAegICfi2AfcQAs36GHkC/OnI4SGzu78fhu
 Ywma36Ulms0d0OGJmZb9We5Vwp2oKCmxgf7ME3t38zCnKr5/OskgkUg/msUx+TyNT1YQS1nvNSX
 EgUDjYE2SwS1zI/doORO9UBzo0tHuvFSUwxgWbM3HKJPj1/0COn/xWSDr+AbJ4lBK3kkDYyJauL
 2vTjwSHlla1w==
X-Received: by 2002:a05:6102:3712:b0:7cc:32ce:4c51 with SMTP id
 ada2fe7eead31-7d739696e39mr7717099137.8.1795612877171; 
 Wed, 25 Nov 2026 05:21:17 -0800 (PST)
X-Received: by 2002:a05:6102:3712:b0:7cc:32ce:4c51 with SMTP id
 ada2fe7eead31-7d739696e39mr7717046137.8.1795612876588; 
 Wed, 25 Nov 2026 05:21:16 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a08552sm160836946d6.34.2026.11.25.05.21.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 05:21:14 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 12/15] target/riscv: clear mstatus.MIE if mstatush.MDT is set
Date: Wed, 25 Nov 2026 10:20:11 -0300
Message-ID: <20261125132015.229955-13-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125132015.229955-1-daniel.barboza@oss.qualcomm.com>
References: <20261125132015.229955-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA1MyBTYWx0ZWRfX86U9sOU5PJZO
 2rH9R1PhX0njnIuaOQ40h/MjVmsenCdPYWwp0lPJ3PCU9yeXT/LIJwY0KkGlPq3GqkwPv1Nx3XV
 Ym+hn/s0+zvFR5WESnBqugAXjAKb198=
X-Proofpoint-GUID: 5Y-wl2jWP9lW28SYFHbZ_VaWORYzUhj3
X-Proofpoint-ORIG-GUID: 5Y-wl2jWP9lW28SYFHbZ_VaWORYzUhj3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA1MyBTYWx0ZWRfXz5LLvxDmkAJe
 X9UNzRU3kwbuVXE+EBIr28KqB4lugmTfKt77DGVythg0CDek3E5XCx0QUdMlckZvKLR8VdbAkg5
 bh4uwnA5ezcR4Uh3ZDWEVHsc9Q0ZWMx7NZqLcDPJV2YUhWY2jKkBXuL0uApROy7IIZBKNjOiZcH
 aY7vQGi6EO7pntk0pJ4trx3xmx4gUzzC9TxgQq+jLrgYuhLLbaAJk3fJogl7n2ZtSJ/OPIU7ZNt
 cr8PJSOMfZjgE1LebmW6SO0apOsQWIL+abliPCViQHpth43q2Brzt+F/UtMnWfFhjXf4yAiD+JT
 +cOHbhhy8zGOK6nt1oFShMmyb7haUo4LvR3WTDVJOSmYmhjmLDjZlOmLo+Hh4Jg5f4z34sXgiZ3
 njLNYHwOF5/JH+lhwPtrsMIacLhEQGtdt9TFrHp+kR+lFIdbYxFpuQNPw1nUxT5FXWjmbhPINyf
 K3mFgEiZEGhgIoQSfPA==
X-Authority-Analysis: v=2.4 cv=A/z5rKWG c=1 sm=1 tr=0 ts=6b06e0cd cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=iTC3F798xIRISN9uQnUA:9 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611250053
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

This is the same logic used by rv64 with the difference that, for rv32,
MDT is located in mstatush and MIE is still on mstatus:

- write_mstatush(): clear mstatus.MIE if mstatush.MDT is going to be
  set;
- write_mstatus(): for rv32, if mstatush.MDT is already set, clear
  mstatus.MIE from 'val'.

The logic for rv64 is unchanged.

Fixes: d2e92f1c6d44 ("target/riscv: Add Smdbltrp CSRs handling")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4827
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/csr.c                    | 22 ++++++++-
 tests/tcg/riscv32/system/meson.build      |  5 +++
 tests/tcg/riscv32/test-mstatush-mdt-mie.S | 55 +++++++++++++++++++++++
 3 files changed, 80 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/riscv32/test-mstatush-mdt-mie.S

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 9414f741d5..429d7093a9 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -2091,6 +2091,7 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
     uint64_t mstatus = env->mstatus;
     uint64_t mask = 0;
     RISCVMXL xl = riscv_cpu_mxl(env);
+    bool is_rv32 = xl == MXL_RV32;
 
     /*
      * MPP field have been made WARL since priv version 1.11. However,
@@ -2130,7 +2131,19 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
 
     if (riscv_cpu_cfg(env)->ext_smdbltrp) {
         mask |= MSTATUS_MDT;
-        if ((val & MSTATUS_MDT) != 0) {
+
+        /*
+         * For RV64, we'll have both MDT and MIE in the same
+         * register so the MDT state that matters is the one being
+         * written in 'val'.
+         *
+         * For RV32 MDT is located in mstatush, thus we'll have to
+         * check env->mstatus to see its current state.
+         *
+         * For both cases, if MDT = 1, MIE must be zero.
+         */
+        if ((!is_rv32 && (val & MSTATUS_MDT))
+            || (is_rv32 && (env->mstatus & MSTATUS_MDT))) {
             val &= ~MSTATUS_MIE;
         }
     }
@@ -2206,7 +2219,12 @@ static RISCVException write_mstatush(CPURISCVState *env, int csrno,
     if (riscv_cpu_cfg(env)->ext_smdbltrp) {
         mask |= MSTATUS_MDT;
         if ((valh & MSTATUS_MDT) != 0) {
-            mask |= MSTATUS_MIE;
+            /*
+             * Priv spec: When the MDT bit is set to 1 by an explicit
+             * CSR write, the MIE (Machine Interrupt Enable) bit is
+             * cleared to 0.
+             */
+            env->mstatus &= ~MSTATUS_MIE;
         }
     }
     env->mstatus = (env->mstatus & ~mask) | (valh & mask);
diff --git a/tests/tcg/riscv32/system/meson.build b/tests/tcg/riscv32/system/meson.build
index 3217c51951..79ad7b89ac 100644
--- a/tests/tcg/riscv32/system/meson.build
+++ b/tests/tcg/riscv32/system/meson.build
@@ -32,6 +32,11 @@ tests += {
     'cflags': cflags,
     'qemu_args': ['-cpu', 'max,smdbltrp=on', qemu_args],
   },
+
+  'test-mstatush-mdt-mie.S': {
+    'cflags': cflags,
+    'qemu_args': ['-cpu', 'max,smdbltrp=on', qemu_args],
+  },
 }
 
 if 'qemu-system-riscv32' in emulators
diff --git a/tests/tcg/riscv32/test-mstatush-mdt-mie.S b/tests/tcg/riscv32/test-mstatush-mdt-mie.S
new file mode 100644
index 0000000000..8763bc8768
--- /dev/null
+++ b/tests/tcg/riscv32/test-mstatush-mdt-mie.S
@@ -0,0 +1,55 @@
+/*
+ * Verify that when mstatush.MDT = 1 MIE is read only zero (Gitlab 4827).
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define MSTATUS_MIE 0x8
+#define MSTATUSH_MDT 0x400
+
+.option norvc
+	.text
+	.global _start
+
+_start:
+	lla	t0, trap
+	csrw	mtvec, t0
+
+	/* Write mstatush.MDT.  */
+	csrr	s0, mstatush
+	li	t0, MSTATUSH_MDT
+	or	t1, s0, t0
+	csrw	mstatush, t1
+
+	/* Check if mstatush.MDT is indeed written.  */
+	csrr	s0, mstatush
+	and	t1, s0, t0
+	bne	t0, t1, _fail
+
+	/* Read mstatus, set MIE, write it back.  */
+	csrr	t1, mstatus
+	ori     t1, t1, MSTATUS_MIE
+	csrw	mstatus, t1
+
+	/* Make sure that MIE is not set.  */
+	csrr	t1, mstatus
+	andi	t1, t1, MSTATUS_MIE
+	bnez	t1, _fail
+
+	j	_pass
+
+trap:
+	j	_fail
+
+_pass:
+	li	t0, 0x100000
+	li	t1, 0x5555	/* FINISHER_PASS */
+	sw	t1, 0(t0)
+	j	.
+
+_fail:
+	li	t0, 0x100000
+	li	t1, 0x13333	/* status = FINISHER_FAIL, code = 1 */
+	sw	t1, 0(t0)
+	j	.
-- 
2.43.0


