Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E7E606A691
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Nov 2026 12:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IYpiu+0U;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UHwQsPCO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUkQF-0001GS-PZ; Sat, 21 Nov 2026 07:42:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xUkQE-0001GA-LZ
 for qemu-devel@nongnu.org; Sat, 21 Nov 2026 07:42:26 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xUkQC-0001Tx-DD
 for qemu-devel@nongnu.org; Sat, 21 Nov 2026 07:42:26 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ALCGKR12767324
 for <qemu-devel@nongnu.org>; Sat, 21 Nov 2026 12:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=3BOBJs/frEGXWVsUhbzSLt1pfLPbuoCUT3s
 BRrGSMec=; b=IYpiu+0U/nvdaKWOvNWsD74v1s2n5GDwjxUUANBU5OWG4nemDnt
 SiGPxL4WzDSfLg/caB9ADOiNwGlGM0hx9MqkRJYVKR21TF2u4L0idmT/rrCSeR+8
 xODni0Mh7Z8fjVvcUbjJpOo1+WbEAfsfZXWurT7FVDeUx3cNNsIzC/fira5gb068
 zwpwcdeqSVAz9SmPLCgBQxM2lZL1f6BC0jvDGuNvyf0wi64CYff1WLLvvPpiSyKf
 AvCqNIo/K0lokEeNpVEYQShPrxX4v6cAfmN5wQip4ce+gEsjY/92aB3xkRX8cLZD
 vbzEBkSUrTtiMtzlXVpQ+07EBx/h+A0p62A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j30nnsfgp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 21 Nov 2026 12:42:22 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5363763b556so37432871cf.3
 for <qemu-devel@nongnu.org>; Sat, 21 Nov 2026 04:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795264941; x=1795869741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3BOBJs/frEGXWVsUhbzSLt1pfLPbuoCUT3sBRrGSMec=;
 b=UHwQsPCOErInik3ucabRYOTRGLAnJZenzG6yMheJLrmICWy9uJoOtj4r7SJko5WjZx
 aoSgqQxZ4khDj66KUS2PoMQ5+h/IM6zF023dqXvQ8wjFVfiw54Ou5qSXI041t7IV1Q74
 URp3LcLXa8d3FQVnEpikYviqrEvraEsyY9+vqBbD20sTMvETLgh1RUAn6iYWicYvD/B8
 Kdb4hZceCfoTwraZPyfo9h6JCmGrJUYujB4FD426xYCYZxODLyWBFHXiyC1cJl/J6oJe
 lmB6AZzgttcvPsVTVEeTr1GmcG6WivNGalHKAuBZ7nUBSNw/+bX8yCewmoG/OkDCJAh2
 5b7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795264941; x=1795869741;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3BOBJs/frEGXWVsUhbzSLt1pfLPbuoCUT3sBRrGSMec=;
 b=C9OEOcIQd9v7iBcgd0WduQzLs3ApesQOFzkfay7vPWlPSYVR4Juv9sUeknd8H2NNFc
 KPiMqvb8JDeF8hObAU7Kj/QNdZrLPGjUB7iCsO+sqkFh2dTUoncRnlLnuNKgfevF5tEh
 KmiJT0AZc9mn9cgl0wXY1xO9gLesfxHU8yeGn4h9NY7J16d5kqCIvtZC3yvzczS2hFZm
 +ghdtT0SOAq9sAs/4jZnChWKhi6cw1aj/SHFFfedtzq0QO5I2yx8JM5YqqiHzKyeO3XW
 u61Fmowbz6KuKXZqusluGJS2MANSLHZAjaTJwD3eVnKLxZKjeuWfJxwp2T+NX5E25m+W
 ajXg==
X-Gm-Message-State: APuU4Z8Pi5ImygwXmwByJw2h9kmW7PHyQGHUXJDDNoRLSkjHEk0DK2Dg
 96p0yVeX3r5gz7CFSUaNliw2SirT8TM+5GqoWwcqt06F/ccGsz8vsSi49/wyuSiwo0vNTC+E8cs
 oNys+WIQHK4aeuvPmjM9xOhXtgvXVoIemzzH4dgPnXTRVUj/CULC0ugLGaCIIzgi45w==
X-Gm-Gg: AZFdTZenGcEIjeLXeY1oDDtWY2X5X3leLJpdjlXj4m8nTAEGajSUKmO1uIBojH3HW3+
 SDdQ4dquZ8bH5ywTU8py1C3qcIebIHrXX21KMDy4CFn7rr6eSN43G00tAbu7QtmuS9B+B4HnsWZ
 swAWd2FYQ3FOOIiPdSxgKc/7l9oA0kLZjv3hQvBF+9nh4vHNy3MdXMIV4tQ9ZBZlBikFeKxOSpC
 Cobl1K8HZMFH9nec4pD5Sg07e4A6YFj04DifTrnw3b2Ry7vmuPNc6WegJC4eniS4qjjhL6bL8Bs
 Y53MoXkrz1mFX565KSVSoDhKM+CaHgk/8FjC3NwyAWjnburIyMX+sxCgbguDQ0Ff3NAZBcxb/We
 Q/NYlcO1eHshNZxvBZ4l+txvJic7jACrvWXgjC7b1bJMTCsN4BrNVMw6hMiFJ4U3+BjLOPQRBPI
 bG2hWNYQKKig==
X-Received: by 2002:ac8:5d09:0:b0:55d:3682:d234 with SMTP id
 d75a77b69052e-55d76a81033mr92806741cf.47.1795264940843; 
 Sat, 21 Nov 2026 04:42:20 -0800 (PST)
X-Received: by 2002:ac8:5d09:0:b0:55d:3682:d234 with SMTP id
 d75a77b69052e-55d76a81033mr92806431cf.47.1795264940284; 
 Sat, 21 Nov 2026 04:42:20 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134bf848dsm52499216d6.44.2026.11.21.04.42.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 04:42:19 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v2] target/riscv: fix hideleg write masks [GL4814]
Date: Sat, 21 Nov 2026 09:42:15 -0300
Message-ID: <20261121124215.1294032-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIxMDA1MCBTYWx0ZWRfX7Qh8AtxvOJlV
 NyzR99Kb8xqO/dE1gQFGQIJ+LSQ8clpFxyh3/Zg2dGHjhEmTXXlpQwv6MT+rmp6cteVOqaQmQQ4
 3lGaEYePXIcaq1+8Xz8Nx+eHcm64n9NVvVzKEBMbRWh8AQd3WRDQ61HMaHSZtcHtv9owI90NFQt
 jcyafL1gUwoa2TFkmhG5z7oLO2eQbOmRbNOM4GwxWO9znPpM2OOiWEAr6fdHHrOUC37+Jov23Kw
 lhNaqK3LO98Mm8pgOf2NAhQSV0Qo4Q4oj3JrCcpFrGEgCU+ePwX4f/GipwMSmiYwUDhZ5WfxJlQ
 PYl/dvxxL3IPk+KstqyUJVD/2HKQkUjlLGTaLge3mzJQEZKNF4l4tvBVUPk0DnX2faohxYCEaEy
 EvjMpHIQaWd4Qj1UKevy9yQqqp+JvjfoYRSaSkqAbXaWiKC2VrDxThsa0KIvTuuMeStCyhIlCKj
 gtZU2hPYSm5nhCmXL7g==
X-Proofpoint-ORIG-GUID: 2wY2aV7s0PW5tsiqdjyWTP5BBRhXdhuf
X-Authority-Analysis: v=2.4 cv=LITz05W9 c=1 sm=1 tr=0 ts=6b0191ae cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=p0WdMEafAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=-qIh_jz3752EjCO2w1YA:9
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIxMDA1MCBTYWx0ZWRfX5dJtcfNzeY9K
 DGjIRy0mKLTE/LG9v/8RrxIJA4uGA3XcDVdJxUtGv2iqFmee/85Rcq6S2OqDvJlgETVcjwWU+JM
 xgZD6rLBaibTJJM56Ofbl3v37b1+1oU=
X-Proofpoint-GUID: 2wY2aV7s0PW5tsiqdjyWTP5BBRhXdhuf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-21_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611210050
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

Changes in v2:
- add a comment explaining why we're checking ext_smaia check along with
  RVH (Sashiko).
- v1 link: https://lore.kernel.org/qemu-devel/20261116205134.846876-1-daniel.barboza@oss.qualcomm.com/


 target/riscv/tcg/csr.c               | 27 ++++++++++++
 tests/tcg/riscv64/system/meson.build |  8 ++++
 tests/tcg/riscv64/test-hideleg.S     | 64 ++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-hideleg.S

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index af444e3e6f..5d3363cf4a 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -4997,6 +4997,33 @@ static RISCVException rmw_hideleg64(CPURISCVState *env, int csrno,
 {
     uint64_t mask = wr_mask & vs_delegable_ints;
 
+    /*
+     * The spec mentions only "when H is implemented", but since we're
+     * reading a CSR that exists only with ext_smaia is enabled (mvien),
+     * we're also checking for smaia.
+     */
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


