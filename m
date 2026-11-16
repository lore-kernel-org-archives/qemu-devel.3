Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D2A606A322
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dpGb7X5z;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cgQ2gRJp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3g2-0000sM-H2; Mon, 16 Nov 2026 15:51:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xT3g1-0000qg-A1
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 15:51:45 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xT3fz-0000qN-DJ
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 15:51:45 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfTtS912880
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 20:51:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=28damP9njOHyhmd9moP/vUa5nLMGCbbvkax
 PHshSkCw=; b=dpGb7X5zh4MbKSg4ICC/6ZqdIOz41En1gmq/29RZhIDF6IbruL+
 M2LRcitE7J9pR2/AQyrfAd+E5mlcq6GnR0M9yNXTkKeQRY5qzLbChaluUmBFi2fc
 O4dLPCxnBR7tW/0hZrRO8KM2ym1WKAXN+SlfRznkuGCnbexB+dsYKqaatyyolbqZ
 p3+reyCLMIhgxTzaZNH5OXxw7mLW4dO6MdsRoRz1aSaVH61QJV+XEHn18Gc5rcoq
 vTGJsTMDWUS1AKkIu0H815BzekRYAsvJHe+cv5o9ZbcSPfpiLccIq8jkak/qewNU
 EmwhvcA4hPHpv4uwPCVEtaXJ0LN+VURGDKw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j034y1pcv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 20:51:41 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-55b9c13273dso65035201cf.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 12:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794862301; x=1795467101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=28damP9njOHyhmd9moP/vUa5nLMGCbbvkaxPHshSkCw=;
 b=cgQ2gRJp1IBZNx+58zUQywgZKZQfvmHpCpX62v/ypDRpX0YFDQ/Vck8DxlmXzt6ac+
 CwcE0LDgTZDfz8GT2CtUvs3njfO5Q+QxoM7+REIINkShT7Rb6IVSPHSfSqhI6IY3RYqt
 PgUjTj1QznS3HIWOIlcMR4DK0l0+cbzqBaHMFplA/rdKcavL/IFYxrPxo/fiGTb0rXVd
 ug6qbFD3KYAW2lzBWOIfVlvkXCuuOb+IOgs2f1P+e7kJWlmM/+f7ZgH9lRLklWrrN/Et
 Wv+pUSw8Bw+e2Sca4tBoY+tbbDGXz6UwrfKzR89oU6PBXjOMRf4eA7MDQ29fSvqHeO4j
 IM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794862301; x=1795467101;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=28damP9njOHyhmd9moP/vUa5nLMGCbbvkaxPHshSkCw=;
 b=my4YNmMGp+Bd1ik0UNLg4eFC/kGvehh9rfPI28JflnvqVtbTjULNut4TwUkz6lq7Ob
 MmUWRLVGQQhxEPN/FFiF1Pq4lCcAHFCvMuExvPlg31vSQsYV0nzCf+0yY22xtaZQMU4q
 UrXDh1bPDnfBNkYqfXRXVIANBw1fO60i8/tQuu5ta/OA/JGf+8uqpyNAssQtt4Xm6KqA
 kCr1ZbwUPhEKW4iYINMmQccDbO4S/rgKPgrs/VlPa6uPSf3Wcr57MKcFJKj6vTOKDMox
 So1kkV2NlFVBgRr7+zay2lYRChPjjJxrAKr50pQp9nqDmO5f0xFSd//GQ+N4UeSvS+eP
 23Qw==
X-Gm-Message-State: APuU4Z9bwx5KZertnzfAyf6cBT/BWy+GMw4FATwfjBTaTYCJ0dy5DjUZ
 LjTbmuv6b3ZJsHPlkYsUNWKvqhqGEUjivaLOZgRgyAoWXiEphBKFh9xh0ZjLI0kS8U64VOmeZdo
 VhZlxE1m99FF9B4Ox4CTXX0FW2gYiNOEs69xUgD33Xciy+Dd8haVqu5k8EVjG3YWktg==
X-Gm-Gg: AYBFou3Q0vtihFLHUJGUq+iDGpZVPPXuvi89x10eSO2bYpVBaVJet5IzguYLtMw083K
 re0tRRBst+1jIky7UDKy+EQIwj3YVkVAYE2Rae48Eo6RmlACejDLyqmfm6x+LwskffmCs1VUnFO
 5uRg66V2/UTWVUaQ33vXq7DMasfdX5aVnOAc39lNvJkvUQ7T0WedwHuiB+AIqT6/WoAbdMuyef8
 i8iNfqnTiAPz4AKrCrqmqSUiGX2XlRyf0XuYapAhoueNsNoU5DNFP/gcwWFCgJ7ffKQ4tPj8z5U
 5InJZdPlExLYhKB9YwD84SC0UoxsUdEfIkCFnPeurASw6xsweIfQkNowj2iEGHIHXZ+qk98st0E
 xsU6meRlXQrpFdzGSIDF538nsdG+zCdEYCMvEu4H4tTR8TcpFxgIjgaa8WGXPxZ2ys8yRDR6/rz
 mk6JzqInBmfOg=
X-Received: by 2002:a05:622a:a38d:b0:55b:d0f1:1dd3 with SMTP id
 d75a77b69052e-55bd0f12ac9mr130871941cf.76.1794862300783; 
 Mon, 16 Nov 2026 12:51:40 -0800 (PST)
X-Received: by 2002:a05:622a:a38d:b0:55b:d0f1:1dd3 with SMTP id
 d75a77b69052e-55bd0f12ac9mr130871561cf.76.1794862300130; 
 Mon, 16 Nov 2026 12:51:40 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.227.223])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91f23da64c1sm93153546d6.37.2026.11.16.12.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 12:51:39 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH] target/riscv: fix hideleg write masks [GL4814]
Date: Mon, 16 Nov 2026 17:51:34 -0300
Message-ID: <20261116205134.846876-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: y81AVNE78dTvbP9I_cJk9P7sAwxvePry
X-Authority-Analysis: v=2.4 cv=aNZlOr9m c=1 sm=1 tr=0 ts=6afb6cdd cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=WERq1Tg1Nl5IKGfG0e6imA==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=-qIh_jz3752EjCO2w1YA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: y81AVNE78dTvbP9I_cJk9P7sAwxvePry
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4MiBTYWx0ZWRfXzO4ftmH8+qx2
 8LAmf21JJ2Y4liUMFpcRH6zikObOvm4Ic3tolT0lQ5R8UYYTfMjhXRt6DdSD3Fmd/wnRq8cEi7I
 ZfZN7wujzByswLVW9PktFoq6R0taP+s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4MiBTYWx0ZWRfX2faxezeXeQSz
 4js+CSNfg69jzmsBFhtFNPH0bfEPpPlTr4ZEKb81FHsLNhJZZTvURLaB0bxat/n2ee44S3AyL1u
 nXyrdxYFompQYUptG9qiZXoxa3NQUonL36gJuBRY1e7ZEUVoOxyLDb+Xr1gkjViK0z1iw/+wfvC
 Fsx+ykKT5ssMXT5W8YE17JeKCysyUrr5kmEyqIVt0vdN5yxvRqDbePgXnuoFTeDcJFRc20kV6rc
 9aFEJHvfqCNsdbVczOcEDaxsYWTbGfENHNTRYH4JGQCpOzh7X3+l6lu20Jak7aluflcZjWrQnbg
 TcK5h2v5Ta9xXd5CzCB1ad7VHVyxVsaTnyi4K6N5YCFF1kF2k3tQ+39wjlCR4Xr0gfIJypro2EF
 oSIELsgcNthRw6WJTWM2TIaO7imqPqdfcGATc7py8qK6HZ0qrPbzNUJ2+df4JTVb3n2/kMbraKI
 4UAVDerb7gHz8ApeKwA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160082
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

We need to check hideleg writable bits with mideleg and mvien. Priv spec
says:

"For bits of mideleg that are zero, the corresponding bits in hideleg,
hip, and hie are read-only zeros."

For mvien, the AIA spec says:

"When the H extension is implemented, if a bit is zero in the same
position in both mideleg and mvien, then that bit is read-only zero in
hideleg".

Filter hideleg writable bits by using mideleg and, if the proper conditions
are met, mvien.

Fixes: d028ac7512f1 ("target/riscv: Implement AIA CSRs for 64 local interrupts on RV32")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4814
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/csr.c               | 22 ++++++++++
 tests/tcg/riscv64/system/meson.build |  8 ++++
 tests/tcg/riscv64/test-hideleg.S     | 64 ++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-hideleg.S

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index af444e3e6f..c130eb2c8a 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -4997,6 +4997,28 @@ static RISCVException rmw_hideleg64(CPURISCVState *env, int csrno,
 {
     uint64_t mask = wr_mask & vs_delegable_ints;
 
+    if (riscv_has_ext(env, RVH)
+        && riscv_cpu_cfg(env)->ext_smaia) {
+        /*
+         * The AIA spec states in section "Interrupt filtering and virtual
+         * interrupts for supervisor level":
+         *
+         * "When the H extension is implemented, if a bit is zero in the
+         * same position in both mideleg and mvien, then that bit is
+         * read-only zero in hideleg (...). But if a bit for one of
+         * interrupts 13-63 is a one in either mideleg or mvien, then the
+         * same bit in hideleg may be writable or may be read-only zero,
+         * depending on the implementation."
+         *
+         * We're making the simpler choice of making all bits read-only
+         * zero if the bit is zero on both mideleg and mvien, and writable
+         * otherwise.  We're not going to special case bits 63:13.
+         */
+        mask &= (env->mideleg | env->mvien);
+    } else {
+        mask &= env->mideleg;
+    }
+
     if (ret_val) {
         *ret_val = env->hideleg & vs_delegable_ints;
     }
diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index 3c8b018d9e..6c08806cc9 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -89,6 +89,14 @@ tests += {
   }
 }
 
+tests += {
+  'test-hideleg.S': {
+    'cflags': cflags,
+    'qemu_args': ['-machine', 'virt,aia=aplic-imsic,aia-guests=7',
+                  '-cpu', 'max', qemu_args],
+  }
+}
+
 if 'qemu-system-riscv64' in emulators
   tcg_tests += {
     'riscv64-softmmu': {
diff --git a/tests/tcg/riscv64/test-hideleg.S b/tests/tcg/riscv64/test-hideleg.S
new file mode 100644
index 0000000000..a07d48430f
--- /dev/null
+++ b/tests/tcg/riscv64/test-hideleg.S
@@ -0,0 +1,64 @@
+/*
+ * Test if bits 63:16 from hideleg becomes writable when
+ * they shouldn't.  Derived from Gitlab 4814.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define CSR_MVIEN 0x308
+#define CSR_HIDELEG 0x603
+
+.option norvc
+	.text
+	.global _start
+
+_start:
+	lla	t0, trap
+	csrw	mtvec, t0
+
+	/* Mask for 63:16.  */
+	li	t0, -1
+	slli	s0, t0, 16
+
+	/* mideleg = 0, mvien = 0: hideleg bits 63:16 should be zero.  */
+	li	t0, 0
+	csrw	mideleg, t0
+	csrw	CSR_MVIEN, t0
+	li	t1, -1
+	csrw	CSR_HIDELEG, t1
+
+	csrr	t1, CSR_HIDELEG
+	and	t1, t1, s0
+	bnez	t1, _fail
+
+	li	a0, 0
+	j	_exit
+
+_fail:
+	li	a0, 1
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
+.balign	16
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


