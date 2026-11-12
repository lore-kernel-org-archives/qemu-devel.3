Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BF5606C2CC
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hWK5LIvG;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z2yj8byv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRXjP-00058y-0J; Thu, 12 Nov 2026 11:32:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xRXjM-00058P-EL
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 11:32:56 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xRXjK-0006be-EI
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 11:32:56 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACFZm5E011393
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 16:32:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=H4Euek3r+HH
 +bpy6DLXnzBRhAkSmOZROBUehtA5bbjY=; b=hWK5LIvGkAT41W2g8myQHUwlYLS
 mTfSvFjyFfXJ7pXipzpgVRJgNmMdBmYDJBsKmcf1OxrAlZJtdbXZwXizYbHxEmUC
 KD6G/quTii42LprnhePFhDN3a3aATjeZF+27+AAquVI3TaGIla2YlVpL8W/ahbJS
 PmQOO1Is3VrXjk7Frj+yXUjLWwnVLVLigT906JRSpPSFEs8jyN50mGWNGn+oM5IL
 blI1ve4+4qnx2AOmT2U6OG0arWsBBaI2AYSFkBnYm5EdVIv2qWZ0j13xwVy2nxC4
 XpH/z4DsP8fbNr/l4IJbfKPT31/Kdm1tLTVFZEt1HsGNRS4FC8XNwnw/GsQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwg1b89tw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 16:32:52 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7d27e34c97dso517851137.0
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 08:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794501171; x=1795105971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H4Euek3r+HH+bpy6DLXnzBRhAkSmOZROBUehtA5bbjY=;
 b=Z2yj8byvlbkj7U65MVjEq0F9xiJ5yRPuiSC97/29aNiOTdkV+lVav0Eu3rUVWTpVWh
 bgkcDcSfLYOGC+RbxsE1QWtvMgNPglWWMdGSM3R5vZkUfxoe4QYCJkO1A2GgjgnK11bh
 LDAkMfURQP2Xre+esltvXWIaARv3sNVeL7w8VrR2/uPz03dfVzF000/b/wQ6eDMEk0jN
 hMCBiuxkgekJDUhoJBUm9JxMj48voVMBaroUcA/y4rmMI5G0OE+1sUw1aiv5qJqMX41P
 DbD586MOpPaCTEJ44rBcgHrTJIgVHN4+xKJ6N7CMcSL0PZNoyMi2KEIH+dWJCmvTQcZV
 xqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794501171; x=1795105971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=H4Euek3r+HH+bpy6DLXnzBRhAkSmOZROBUehtA5bbjY=;
 b=tTyEvtu80Rr/v7cKLzukyKRWWbXApC6MsReL1FMM4L5NdTPOCvnjDEHBIpR3JRFned
 h7OzVvAOgSlT9V4MS54U5PtQ9vI2L/FqAd8djgf/frZLaTBT1kR91VHLhxlg3NOVvVi8
 8xObyYGG+72Z0a4q06mOWMoeAy793sjbV8fYlVMPAA6tvS1GQVMQQG3HgByvLU5j3fJe
 HTxll2ZeXEtv4tfMS8Onlkiaf1ZY3HcTZ8VqLx69kUUEYBN/A+bvhUD4pwn388fwvtCe
 BCu+Eg7YT1/iPGdtaFAaLM2Yl4EyQYWtyFOaQNYqxvtWTFA6T79uviX3LZLV+uQqLgZO
 is1A==
X-Gm-Message-State: APuU4Z+vbziMV2osIGArA51ztLR2II2UPH0kMF9rBAVlr/bxDK7Cm2F2
 m0FUBpeCuRpTtsrQSm8fDuEh+juaOjhLlPIwMGz5Jwczsm3LpoakTyFRO9Fv3NZdjeD+1IqOzc5
 NWeT/Lv8NWD1uGn5uIG+p9rViT6f2oGSjlDHtwdbALkcyO1IrbZr1mtY80ymQtVy48A==
X-Gm-Gg: AYBFou0jxwwBCPdGq4NtCemC/kcn5QQu7m0y3vO48O7gqtWBB6VxwdMG0+IdlpgDPZ+
 XEfWr4wpkDwHo9bzWdjpJzrrO8cNL8JN32EGZmZAtjTmWUgCZXsUwjxxMQjyVG5HVIALKcmEZa8
 NgdLlRwonDfHQByn50cDVtCINIKK3JdE8emmPPfj2CqnjOG+dngcJ7AfuVrj7PDM0ChRbPMKVYn
 cJ6hOFiD2F4cTH6QrlZ/NZAbASQ2uJqrfGLznuY9xYAhBKMQLcUEOQu+3K033G+f7fJq6nGStqV
 rkEd5lLMaLGCHctLBgswgsjY64SIoLfcRDWIUH7TZc09X2CzpF/MJJLeFPAtxfXIOZfKZxEaTdr
 E6BvwvQ+0A38JKB/+y9/F8vcS5m3OxIljbGbybHmbC8vIInNd1NX+Ba/+Ysnp9ED+FNqFYUHAis
 fHuDvmme5mj1rWSHR4fUe+Pn49a5KESbgtSoyvTZodZFLN
X-Received: by 2002:a05:6102:2d0a:b0:7d2:d65f:b479 with SMTP id
 ada2fe7eead31-7d5060d5bd9mr2034159137.28.1794501170996; 
 Thu, 12 Nov 2026 08:32:50 -0800 (PST)
X-Received: by 2002:a05:6102:2d0a:b0:7d2:d65f:b479 with SMTP id
 ada2fe7eead31-7d5060d5bd9mr2034093137.28.1794501170270; 
 Thu, 12 Nov 2026 08:32:50 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com (189-68-253-226.dsl.telesp.net.br.
 [189.68.253.226]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ef04b01c8sm74698256d6.10.2026.11.12.08.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 08:32:49 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 1/1] target/riscv: do not write SXL < UXL [GL4821]
Date: Thu, 12 Nov 2026 13:32:42 -0300
Message-ID: <20261112163242.509864-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112163242.509864-1-daniel.barboza@oss.qualcomm.com>
References: <20261112163242.509864-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=c6Q+0h9l c=1 sm=1 tr=0 ts=6af5ea34 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xcxBfRYLw5hNHjR815/AfA==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=l64ddKhEkLFiuVWVZmUA:9 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: z1fiFCyahz2SVfRgvxT297g5TCmvUC6B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA2NSBTYWx0ZWRfX8t70KU9cilIL
 BXc5qyF9RZMfPkXq9pJSq2c1+j+FLNHL8vA84YSqdRhePC43I6Lyatk2zcivdp/wyOmYukQVVgx
 16pPE3cuwksfcRB51Dx3lrBxCB0kfOyw7lRYJazr3YQRYO61xBwGMKJeE7xXcak58DHaYpQ85PT
 lSRqwL3mWrIGiPDw95CDoMRB1PtcIPscgyUME7lVsl4p5PHJgtq1p9RCaforwYTsXXSIHecVWl2
 tj5h7SSaH9Kw/whcChi8hHYgZUnQHNbjlq423U/n6QUbcvkMGm2D1alV5+kXvWlH51GY3Msm8Gm
 b6FhyT5KZZCMkKlFAFFCKSiNLrcv65FvsOqJPMPjtgZF3jVPXxTu0v2UvGcia2ZMDs+XLFV+jTV
 J3pFNWl5jkNqYtnfNxEDZuhSe9IqO+Ady97j+IdkhLJR9sMcqWbLAuBt9Gs5o85wyIN4ZqDChqd
 JxWsyKmU/CHglYjnzdw==
X-Proofpoint-ORIG-GUID: z1fiFCyahz2SVfRgvxT297g5TCmvUC6B
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA2NSBTYWx0ZWRfX+QuIjtg4V4Ay
 /r2KF3q/2ps+x6Z55TjCp5lAichjs+sCdGgurlbjV9CSDxTW88Rl2W9tcCnZstLnAdP2E3Fwtwy
 A2RmaWQ10ODnMopKiISDvfHCV69VoGU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120065
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

RISC-V priv spec says: "If S-mode is implemented, the set of legal
values that the uxl field may assume excludes those that would cause
UXLEN to be greater than SXLEN." At this moment there's no relation
between SXL and UXL writes, i.e.  we're happy to accept SXL < UXL.

We'll start by renaming riscv_write_uxl() to riscv_update_xl_field(),
making it closer to what the function actually does.  Then, in the same
function:

- 'xl' is renamed to 'mlx' since it stores riscv_cpu_mxl();
- 'uxl' is renamed to 'xl', indicating that the function is dealing with
   multiple XL files (SXL, UXL, VSSTATUS.UXL ...);
- add a new 'min_field_val' field.

With this improved helper what's left is to change SXL/UXL update order
in write_mstatus() and, when updating SXL, we'll use the written UXL
value as a minimal value for SXL.

This means that if we're in a SXL < UXL case, e.g. SXL = 1 and UXL = 2,
we'll write SXL = 2/UXL = 2.  Another possibility would be to decrement
UXL and write SXL = 1/UXL = 1, but the bug report in [1] mentions that
bumping SXL is the default behavior of other emulators.  For the sake of
compatibility we're doing the same.

[1] https://gitlab.com/qemu-project/qemu/-/work_items/4821

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4821
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/csr.c               | 40 +++++++++++++------
 tests/tcg/riscv64/system/meson.build |  7 ++++
 tests/tcg/riscv64/test-uxl-sxl.S     | 59 ++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+), 13 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-uxl-sxl.S

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 24eda54bac..c54fa026a2 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -2049,15 +2049,25 @@ static target_ulong legalize_mpp(CPURISCVState *env, target_ulong old_mpp,
     return val;
 }
 
-static uint64_t riscv_write_uxl(CPURISCVState *env, uint64_t val,
-                                uint64_t field)
+static uint64_t riscv_update_xl_field(CPURISCVState *env, uint64_t val,
+                                      uint64_t field, uint32_t min_field_val)
 {
-    RISCVMXL xl = riscv_cpu_mxl(env);
-    uint64_t uxl = get_field(val, field);
+    RISCVMXL mxl = riscv_cpu_mxl(env);
+    uint64_t xl = get_field(val, field);
+    bool field_updated = false;
+
+    if (xl < min_field_val) {
+        xl = min_field_val;
+        field_updated = true;
+    }
 
-    if (xl != MXL_RV128 && uxl == MXL_RV128) {
-        uxl = xl;
-        val = set_field(val, field, uxl);
+    if (mxl != MXL_RV128 && xl == MXL_RV128) {
+        xl = mxl;
+        field_updated = true;
+    }
+
+    if (field_updated) {
+        val = set_field(val, field, xl);
     }
 
     return val;
@@ -2118,14 +2128,18 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
         if (riscv_has_ext(env, RVH)) {
             mask |= MSTATUS_MPV | MSTATUS_GVA;
         }
-        if (riscv_has_ext(env, RVS) && (val & MSTATUS64_SXL) != 0) {
-            mask |= MSTATUS64_SXL;
-            val = riscv_write_uxl(env, val, MSTATUS64_SXL);
-        }
 
         if (riscv_has_ext(env, RVU) && (val & MSTATUS64_UXL) != 0) {
             mask |= MSTATUS64_UXL;
-            val = riscv_write_uxl(env, val, MSTATUS64_UXL);
+            val = riscv_update_xl_field(env, val, MSTATUS64_UXL, 0);
+        }
+
+        if (riscv_has_ext(env, RVS) && (val & MSTATUS64_SXL) != 0) {
+            uint32_t min_val = mask & MSTATUS64_UXL
+                               ? get_field(val, MSTATUS64_UXL) : 0;
+
+            mask |= MSTATUS64_SXL;
+            val = riscv_update_xl_field(env, val, MSTATUS64_SXL, min_val);
         }
     }
 
@@ -5474,7 +5488,7 @@ static RISCVException write_vsstatus(CPURISCVState *env, int csrno,
     if ((val & VSSTATUS64_UXL) == 0) {
         mask &= ~VSSTATUS64_UXL;
     } else {
-        val = riscv_write_uxl(env, val, VSSTATUS64_UXL);
+        val = riscv_update_xl_field(env, val, VSSTATUS64_UXL, 0);
     }
     if ((env->henvcfg & HENVCFG_DTE)) {
         if ((val & SSTATUS_SDT) != 0) {
diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index 3c8b018d9e..65bcc2bdbc 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -89,6 +89,13 @@ tests += {
   }
 }
 
+tests += {
+  'test-uxl-sxl.S': {
+    'cflags': cflags,
+    'qemu_args': ['-cpu', 'max', qemu_args],
+  }
+}
+
 if 'qemu-system-riscv64' in emulators
   tcg_tests += {
     'riscv64-softmmu': {
diff --git a/tests/tcg/riscv64/test-uxl-sxl.S b/tests/tcg/riscv64/test-uxl-sxl.S
new file mode 100644
index 0000000000..54dc0832b3
--- /dev/null
+++ b/tests/tcg/riscv64/test-uxl-sxl.S
@@ -0,0 +1,59 @@
+/*
+ * Test that UXL will never be read as greater than SXL.
+ *
+ * Based on Gitlab 4821 testcase, which is derived from riscv-arch-test.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+.option norvc
+	.text
+	.global _start
+
+_start:
+	lla	t0, trap
+	csrw	mtvec, t0
+
+	csrr	s0, mstatus
+	li	t0, 0xf
+	slli	t0, t0, 32
+	not	t0, t0
+	and	t1, s0, t0
+	li	t2, 0x6                // SXL = 01, UXL = 10
+	slli	t2, t2, 32
+	or	t1, t1, t2
+	csrw	mstatus, t1
+	csrr	s1, mstatus
+	csrw	mstatus, s0            // restore
+
+	srli	t1, s1, 34
+	andi	t1, t1, 3              // SXL
+	srli	t2, s1, 32
+	andi	t2, t2, 3              // UXL
+	sltu	a0, t1, t2             // fail if SXL < UXL
+	j	_exit
+
+trap:
+	# Any trap is a fail code 1
+	li	a0, 1
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
+	.balign	16
+semiargs:
+	.space	16
-- 
2.43.0


