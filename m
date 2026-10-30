Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C91606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mquF3fB1;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VpAvxeHB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqoq-0005jC-Qp; Fri, 30 Oct 2026 13:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqo9-0005Vj-6h
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:54:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqo5-0007oa-FF
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:54:27 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERKvB2495308
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OA+hj8FOtL9V8x3Yl7yoEXZsgekfgXDFiSfCKsX9tBU=; b=mquF3fB1oniaEYCk
 SnI5T1lj6lZLHMaMq373PYQcYdxrL5bWd8SZZzfvr5wUQ7fnm07u3KaCE/aOBF3q
 xtnVpsD8XzIfFJ+J07UnyUrNszGbPXJMbqoLWVXHuzkm9LtLzaQULbETey2Wok6d
 BWxswvaHl/OlYNhk2A4IC0h32v6wul6Ix/f18Teqr8Zje0VLp28DpOVQdOuF/Fdd
 Dq6lX4J+zQI9un1Uf/EncWmaQ7byf+9wLJeVH2u92DyVq9x4LtrI3jSlL79VO+sl
 dbt3sMnq6Rc20QMGOXx7jKWalUvFLzlgM8ayv9RFez8CafLC8nN8HB/wiU/uTq7F
 nBYhPQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6p4btj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:54:24 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7bf5c02f7a3so224181137.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793382864; x=1793987664; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OA+hj8FOtL9V8x3Yl7yoEXZsgekfgXDFiSfCKsX9tBU=;
 b=VpAvxeHBjmp0Sr6gjqxcwzH4zpnkXc+JH6WPffRMwmeuWiIxmRWanOU5WzZaUKkHq5
 O3CAOzMv4Ouz0G1myUedR8D/r3Yo47ohCeR55b+uS0jZixx7i1kAhlcOYZyQwY4bHrpq
 UR6Dq7Y3s3RWo4Wi2D6mhFZe4R2DUIQJcLkR6dgVtr1m0XQ4f1oKHyTD357BtmMLNjva
 0VEYqvOhYl4iqhf5XNM8Qwo8NHkR1+Vy/oFeGr2kAtmJz4r01wiGNQvqtga60vdKuClb
 VbdH3X09TC2x0T48D7ASHLN0Rt2lj73HrvmH3RYd73uwNdsdQ7DhJ+r+OJ0QcIVegMWW
 XsGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793382864; x=1793987664;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OA+hj8FOtL9V8x3Yl7yoEXZsgekfgXDFiSfCKsX9tBU=;
 b=b5gAKPAJLh6yLgkgOrzxg6qdDC9gN4v+6JFdc27Wd9ml8AnawjsbcIdOYk/nCSvz8A
 1n69ac3VarKuRB5vJjrtsrGIj55u35IxWUm1vMRFKcAsHd5eX4DPmCm5oURiK8rdE19g
 LhwwSItBKIeLGLZt4cWSts0UWf1sca36+XPTktZl74NML3/NM7JAGNmMDxIumhwEty00
 PlwnTAlHwqDifdS0EwUvWsZVGb8KnZTkn88kAxOqVIy+EKa/3civvpnafpPOaw4z1ATu
 EybGkPdnzvBqH43OjEBTnYYGIOPFVfLyTx+sVD8S4GA6XheqOmsS7XChz//8PY2yXf8P
 SLFg==
X-Gm-Message-State: AFq9FYIBZyZI+1lB3JtsX1llYDoeEWrsW1sVQVBrzroA7jBRDiAjt8mN
 +1qEFwh5EemUF7lqv/CtaEdoNq4WF4Em2M+KV2mx6uptekYerd5d3A/qf+KVWT+U9ixTN2WWyZb
 MOnqbcqOvwTUCLqYM6a9VZ8gV5WMiYgp+vNxHY0ZXV7nJW+PZXQRUMJ9FGyZctN+021da
X-Gm-Gg: AYBFou2gMv39x03ES4SArqRhFF2h6rkBnuEig3EeW3iPlG2bmqyay+QWVecz1FD/PsP
 4somIlrioVQa2M13hfcJPZx6c98x2hp6F1zJYade1SMFuvL8oM8IDm/sOdwmVjemENG0QEn5kPz
 5IL7fkvbls0Lc4B4fIgmHIAHpb//T+MhTTvIgEBA7YLl4e4Rj8e3KBrV4rswQGUwORvZ/6CQNo6
 KXVLaH5QkVKK17nSiPIT9AkD79GUNmmZhjx9/X+izApXU7Zf7JBX6xK4Bj2GJGsAK+efpq/Rm0f
 1xrntSlEv0PpNXlQByH4AYeH3Vv+rwiDXgAlzwBKl1rf97rezbnATrKedfIZe8GDVYrIZFvjk+A
 KlwnWNCWCZJRAXtEhZznBPLii8PLjNJpRhxpNVwicMQkpg1BaNwG2sta3aEGGWXIGxtKV8lebT5
 N1DANg9iYU/tJgSL/s7khF2AWQZ80lAA==
X-Received: by 2002:a05:6102:509e:b0:7a7:366c:92b1 with SMTP id
 ada2fe7eead31-7d072605b45mr1413277137.23.1793382863421; 
 Fri, 30 Oct 2026 10:54:23 -0700 (PDT)
X-Received: by 2002:a05:6102:509e:b0:7a7:366c:92b1 with SMTP id
 ada2fe7eead31-7d072605b45mr1413260137.23.1793382862731; 
 Fri, 30 Oct 2026 10:54:22 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b80ecbsm4545852f8f.35.2026.10.30.10.54.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 10:54:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4 03/32] tests/tcg/mips: Group DSP arith tests
Date: Fri, 30 Oct 2026 18:53:25 +0100
Message-ID: <20261030175357.99684-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030175357.99684-1-philmd@oss.qualcomm.com>
References: <20261030175357.99684-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfXyXFMMrQSKyXg
 tE1Hcpzn1GYaoByNtfL2y5jEcmysGUoje6D+T9BO667ru1Xk4eNo7JRz1Iim7DRv4hfyHzeztuG
 ZsxqPoAmj7LjPo97bANk2gm5KgwnWT4bIFduu8po1uzgwpCxIkqSaVTprSMr17Exs33BHf/hAoQ
 kkepb4E8rx5YaooBrg72keyT/UmtHzVhaFjB6Rz6RIKAAyuARCOPzHeAxlBp2aW+4ceHGDEamOC
 47aBP8GcSouevZqadFAZvSWnsL5NaWTNS91BoiPV43tnxbiN+YJnsLDdXzi59WCnDcGfRacad/U
 t86qggwyqXPQsMm53XyBB0sTShHMpoymQmWZRqSMCWe02vqjg5sUYaBXC1bcMLIDQ9nFJeHuxad
 l+cYhD8sAjESybeIPMqB4R3R5x47UD20XOPQYDxAPAkLv6PpVaB4/zFmU0V9QH/zxMlmbGzQYQA
 nVCBHPYGmTf4oSv8uOQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX+8XufHp3AJq6
 b+Kc57jdlUKJQpCpkx57DB4SjjWi20SXV0GTtmg5Jo+NUS/VsRdECGkWTvlk+Dd9Mb4p6vLZls7
 Gy5X21xxM/FtzbQDuCrQVU7Aov4kC6M=
X-Proofpoint-ORIG-GUID: gGxQNMgSEnqlr6LoJstwFScQ41ldbpFD
X-Proofpoint-GUID: gGxQNMgSEnqlr6LoJstwFScQ41ldbpFD
X-Authority-Analysis: v=2.4 cv=TL3Q2Fla c=1 sm=1 tr=0 ts=6ae4d9d0 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=QcVZmDX5zYVA5dVMsrUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300071
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Build the 33 per-opcode arith tests as a single executable,
test_dsp_arith.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mipsel/test_dsp_arith.c         | 179 ++++++++++++++++++++++
 tests/tcg/mipsel/test_dsp_r1_absq_s_ph.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_absq_s_w.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_addq_ph.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_addq_s_ph.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_addq_s_w.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_addsc.c      |   1 -
 tests/tcg/mipsel/test_dsp_r1_addu_qb.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_addu_s_qb.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_addwc.c      |   1 -
 tests/tcg/mipsel/test_dsp_r1_modsub.c     |   1 -
 tests/tcg/mipsel/test_dsp_r1_raddu_w_qb.c |   1 -
 tests/tcg/mipsel/test_dsp_r1_subq_ph.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_subq_s_ph.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_subq_s_w.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_subu_qb.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_subu_s_qb.c  |   1 -
 tests/tcg/mipsel/test_dsp_r2_absq_s_qb.c  |   1 -
 tests/tcg/mipsel/test_dsp_r2_addqh_ph.c   |   1 -
 tests/tcg/mipsel/test_dsp_r2_addqh_r_ph.c |   1 -
 tests/tcg/mipsel/test_dsp_r2_addqh_r_w.c  |   1 -
 tests/tcg/mipsel/test_dsp_r2_addqh_w.c    |   1 -
 tests/tcg/mipsel/test_dsp_r2_addu_ph.c    |   1 -
 tests/tcg/mipsel/test_dsp_r2_addu_s_ph.c  |   1 -
 tests/tcg/mipsel/test_dsp_r2_adduh_qb.c   |   1 -
 tests/tcg/mipsel/test_dsp_r2_adduh_r_qb.c |   1 -
 tests/tcg/mipsel/test_dsp_r2_subqh_ph.c   |   1 -
 tests/tcg/mipsel/test_dsp_r2_subqh_r_ph.c |   1 -
 tests/tcg/mipsel/test_dsp_r2_subqh_r_w.c  |   1 -
 tests/tcg/mipsel/test_dsp_r2_subqh_w.c    |   1 -
 tests/tcg/mipsel/test_dsp_r2_subu_ph.c    |   1 -
 tests/tcg/mipsel/test_dsp_r2_subu_s_ph.c  |   1 -
 tests/tcg/mipsel/test_dsp_r2_subuh_qb.c   |   1 -
 tests/tcg/mipsel/test_dsp_r2_subuh_r_qb.c |   1 -
 tests/tcg/mipsel/meson.build              |  34 +---
 35 files changed, 180 insertions(+), 66 deletions(-)
 create mode 100644 tests/tcg/mipsel/test_dsp_arith.c

diff --git a/tests/tcg/mipsel/test_dsp_arith.c b/tests/tcg/mipsel/test_dsp_arith.c
new file mode 100644
index 000000000000..77f7f0600367
--- /dev/null
+++ b/tests/tcg/mipsel/test_dsp_arith.c
@@ -0,0 +1,179 @@
+/*
+ * MIPS DSP ASE tests: Add, Subtract and Absolute value instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "test_dsp_runner.h"
+
+#define main test_dsp_r1_absq_s_ph
+#include "test_dsp_r1_absq_s_ph.c"
+#undef main
+
+#define main test_dsp_r1_absq_s_w
+#include "test_dsp_r1_absq_s_w.c"
+#undef main
+
+#define main test_dsp_r1_addq_ph
+#include "test_dsp_r1_addq_ph.c"
+#undef main
+
+#define main test_dsp_r1_addq_s_ph
+#include "test_dsp_r1_addq_s_ph.c"
+#undef main
+
+#define main test_dsp_r1_addq_s_w
+#include "test_dsp_r1_addq_s_w.c"
+#undef main
+
+#define main test_dsp_r1_addsc
+#include "test_dsp_r1_addsc.c"
+#undef main
+
+#define main test_dsp_r1_addu_qb
+#include "test_dsp_r1_addu_qb.c"
+#undef main
+
+#define main test_dsp_r1_addu_s_qb
+#include "test_dsp_r1_addu_s_qb.c"
+#undef main
+
+#define main test_dsp_r1_addwc
+#include "test_dsp_r1_addwc.c"
+#undef main
+
+#define main test_dsp_r1_modsub
+#include "test_dsp_r1_modsub.c"
+#undef main
+
+#define main test_dsp_r1_raddu_w_qb
+#include "test_dsp_r1_raddu_w_qb.c"
+#undef main
+
+#define main test_dsp_r1_subq_ph
+#include "test_dsp_r1_subq_ph.c"
+#undef main
+
+#define main test_dsp_r1_subq_s_ph
+#include "test_dsp_r1_subq_s_ph.c"
+#undef main
+
+#define main test_dsp_r1_subq_s_w
+#include "test_dsp_r1_subq_s_w.c"
+#undef main
+
+#define main test_dsp_r1_subu_qb
+#include "test_dsp_r1_subu_qb.c"
+#undef main
+
+#define main test_dsp_r1_subu_s_qb
+#include "test_dsp_r1_subu_s_qb.c"
+#undef main
+
+#define main test_dsp_r2_absq_s_qb
+#include "test_dsp_r2_absq_s_qb.c"
+#undef main
+
+#define main test_dsp_r2_addqh_ph
+#include "test_dsp_r2_addqh_ph.c"
+#undef main
+
+#define main test_dsp_r2_addqh_r_ph
+#include "test_dsp_r2_addqh_r_ph.c"
+#undef main
+
+#define main test_dsp_r2_addqh_r_w
+#include "test_dsp_r2_addqh_r_w.c"
+#undef main
+
+#define main test_dsp_r2_addqh_w
+#include "test_dsp_r2_addqh_w.c"
+#undef main
+
+#define main test_dsp_r2_addu_ph
+#include "test_dsp_r2_addu_ph.c"
+#undef main
+
+#define main test_dsp_r2_addu_s_ph
+#include "test_dsp_r2_addu_s_ph.c"
+#undef main
+
+#define main test_dsp_r2_adduh_qb
+#include "test_dsp_r2_adduh_qb.c"
+#undef main
+
+#define main test_dsp_r2_adduh_r_qb
+#include "test_dsp_r2_adduh_r_qb.c"
+#undef main
+
+#define main test_dsp_r2_subqh_ph
+#include "test_dsp_r2_subqh_ph.c"
+#undef main
+
+#define main test_dsp_r2_subqh_r_ph
+#include "test_dsp_r2_subqh_r_ph.c"
+#undef main
+
+#define main test_dsp_r2_subqh_r_w
+#include "test_dsp_r2_subqh_r_w.c"
+#undef main
+
+#define main test_dsp_r2_subqh_w
+#include "test_dsp_r2_subqh_w.c"
+#undef main
+
+#define main test_dsp_r2_subu_ph
+#include "test_dsp_r2_subu_ph.c"
+#undef main
+
+#define main test_dsp_r2_subu_s_ph
+#include "test_dsp_r2_subu_s_ph.c"
+#undef main
+
+#define main test_dsp_r2_subuh_qb
+#include "test_dsp_r2_subuh_qb.c"
+#undef main
+
+#define main test_dsp_r2_subuh_r_qb
+#include "test_dsp_r2_subuh_r_qb.c"
+#undef main
+
+int main(void)
+{
+    TAP_START();
+    RUN_TEST(test_dsp_r1_absq_s_ph);
+    RUN_TEST(test_dsp_r1_absq_s_w);
+    RUN_TEST(test_dsp_r1_addq_ph);
+    RUN_TEST(test_dsp_r1_addq_s_ph);
+    RUN_TEST(test_dsp_r1_addq_s_w);
+    RUN_TEST(test_dsp_r1_addsc);
+    RUN_TEST(test_dsp_r1_addu_qb);
+    RUN_TEST(test_dsp_r1_addu_s_qb);
+    RUN_TEST(test_dsp_r1_addwc);
+    RUN_TEST(test_dsp_r1_modsub);
+    RUN_TEST(test_dsp_r1_raddu_w_qb);
+    RUN_TEST(test_dsp_r1_subq_ph);
+    RUN_TEST(test_dsp_r1_subq_s_ph);
+    RUN_TEST(test_dsp_r1_subq_s_w);
+    RUN_TEST(test_dsp_r1_subu_qb);
+    RUN_TEST(test_dsp_r1_subu_s_qb);
+    RUN_TEST(test_dsp_r2_absq_s_qb);
+    RUN_TEST(test_dsp_r2_addqh_ph);
+    RUN_TEST(test_dsp_r2_addqh_r_ph);
+    RUN_TEST(test_dsp_r2_addqh_r_w);
+    RUN_TEST(test_dsp_r2_addqh_w);
+    RUN_TEST(test_dsp_r2_addu_ph);
+    RUN_TEST(test_dsp_r2_addu_s_ph);
+    RUN_TEST(test_dsp_r2_adduh_qb);
+    RUN_TEST(test_dsp_r2_adduh_r_qb);
+    RUN_TEST(test_dsp_r2_subqh_ph);
+    RUN_TEST(test_dsp_r2_subqh_r_ph);
+    RUN_TEST(test_dsp_r2_subqh_r_w);
+    RUN_TEST(test_dsp_r2_subqh_w);
+    RUN_TEST(test_dsp_r2_subu_ph);
+    RUN_TEST(test_dsp_r2_subu_s_ph);
+    RUN_TEST(test_dsp_r2_subuh_qb);
+    RUN_TEST(test_dsp_r2_subuh_r_qb);
+
+    return tap_done();
+}
diff --git a/tests/tcg/mipsel/test_dsp_r1_absq_s_ph.c b/tests/tcg/mipsel/test_dsp_r1_absq_s_ph.c
index aa8411202e20..ba32ddeeb498 100644
--- a/tests/tcg/mipsel/test_dsp_r1_absq_s_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_absq_s_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 
 int main()
diff --git a/tests/tcg/mipsel/test_dsp_r1_absq_s_w.c b/tests/tcg/mipsel/test_dsp_r1_absq_s_w.c
index 3f52a48039cd..699f1adf967e 100644
--- a/tests/tcg/mipsel/test_dsp_r1_absq_s_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_absq_s_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_addq_ph.c b/tests/tcg/mipsel/test_dsp_r1_addq_ph.c
index 96a549637b41..4bb955a9565d 100644
--- a/tests/tcg/mipsel/test_dsp_r1_addq_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_addq_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_addq_s_ph.c b/tests/tcg/mipsel/test_dsp_r1_addq_s_ph.c
index 5f865f6cffd5..47b1c19e77d9 100644
--- a/tests/tcg/mipsel/test_dsp_r1_addq_s_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_addq_s_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_addq_s_w.c b/tests/tcg/mipsel/test_dsp_r1_addq_s_w.c
index 1e13acf68fb9..bb3cbf836aa3 100644
--- a/tests/tcg/mipsel/test_dsp_r1_addq_s_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_addq_s_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 
 int main()
diff --git a/tests/tcg/mipsel/test_dsp_r1_addsc.c b/tests/tcg/mipsel/test_dsp_r1_addsc.c
index ace749f667c4..f348a081e76e 100644
--- a/tests/tcg/mipsel/test_dsp_r1_addsc.c
+++ b/tests/tcg/mipsel/test_dsp_r1_addsc.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_addu_qb.c b/tests/tcg/mipsel/test_dsp_r1_addu_qb.c
index 23ba2e90d1c9..b9c1cca392c6 100644
--- a/tests/tcg/mipsel/test_dsp_r1_addu_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_addu_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_addu_s_qb.c b/tests/tcg/mipsel/test_dsp_r1_addu_s_qb.c
index fe7fd3e6aa2d..4c2fcb9aedc9 100644
--- a/tests/tcg/mipsel/test_dsp_r1_addu_s_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_addu_s_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_addwc.c b/tests/tcg/mipsel/test_dsp_r1_addwc.c
index 8a8d81fab4ca..71f9cf49c9e7 100644
--- a/tests/tcg/mipsel/test_dsp_r1_addwc.c
+++ b/tests/tcg/mipsel/test_dsp_r1_addwc.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_modsub.c b/tests/tcg/mipsel/test_dsp_r1_modsub.c
index c294eebb519d..05278a2323cc 100644
--- a/tests/tcg/mipsel/test_dsp_r1_modsub.c
+++ b/tests/tcg/mipsel/test_dsp_r1_modsub.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_raddu_w_qb.c b/tests/tcg/mipsel/test_dsp_r1_raddu_w_qb.c
index 77a983c0d20f..d131bd6ca7f3 100644
--- a/tests/tcg/mipsel/test_dsp_r1_raddu_w_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_raddu_w_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_subq_ph.c b/tests/tcg/mipsel/test_dsp_r1_subq_ph.c
index fdd7b38b647e..19cc84d9fd17 100644
--- a/tests/tcg/mipsel/test_dsp_r1_subq_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_subq_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_subq_s_ph.c b/tests/tcg/mipsel/test_dsp_r1_subq_s_ph.c
index 64c89ebd5114..08742e926dea 100644
--- a/tests/tcg/mipsel/test_dsp_r1_subq_s_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_subq_s_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_subq_s_w.c b/tests/tcg/mipsel/test_dsp_r1_subq_s_w.c
index 9d456a90f417..9844b250d9d2 100644
--- a/tests/tcg/mipsel/test_dsp_r1_subq_s_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_subq_s_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_subu_qb.c b/tests/tcg/mipsel/test_dsp_r1_subu_qb.c
index 420909615526..2ec61e819f02 100644
--- a/tests/tcg/mipsel/test_dsp_r1_subu_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_subu_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_subu_s_qb.c b/tests/tcg/mipsel/test_dsp_r1_subu_s_qb.c
index 3d650533d171..2ce247cd7a86 100644
--- a/tests/tcg/mipsel/test_dsp_r1_subu_s_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_subu_s_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_absq_s_qb.c b/tests/tcg/mipsel/test_dsp_r2_absq_s_qb.c
index af4683f30475..9944cc18f075 100644
--- a/tests/tcg/mipsel/test_dsp_r2_absq_s_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r2_absq_s_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_addqh_ph.c b/tests/tcg/mipsel/test_dsp_r2_addqh_ph.c
index 921f0eaf33c7..82827f33f6e4 100644
--- a/tests/tcg/mipsel/test_dsp_r2_addqh_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_addqh_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_addqh_r_ph.c b/tests/tcg/mipsel/test_dsp_r2_addqh_r_ph.c
index 213ba3725006..064e2bbda707 100644
--- a/tests/tcg/mipsel/test_dsp_r2_addqh_r_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_addqh_r_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_addqh_r_w.c b/tests/tcg/mipsel/test_dsp_r2_addqh_r_w.c
index 75a75c50f32d..867fe0bc7f05 100644
--- a/tests/tcg/mipsel/test_dsp_r2_addqh_r_w.c
+++ b/tests/tcg/mipsel/test_dsp_r2_addqh_r_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_addqh_w.c b/tests/tcg/mipsel/test_dsp_r2_addqh_w.c
index de6926ebbb72..2539e4c178ec 100644
--- a/tests/tcg/mipsel/test_dsp_r2_addqh_w.c
+++ b/tests/tcg/mipsel/test_dsp_r2_addqh_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_addu_ph.c b/tests/tcg/mipsel/test_dsp_r2_addu_ph.c
index 1d7a25a2a773..a547341c8b58 100644
--- a/tests/tcg/mipsel/test_dsp_r2_addu_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_addu_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_addu_s_ph.c b/tests/tcg/mipsel/test_dsp_r2_addu_s_ph.c
index 979651bfc9ac..d47faece052e 100644
--- a/tests/tcg/mipsel/test_dsp_r2_addu_s_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_addu_s_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_adduh_qb.c b/tests/tcg/mipsel/test_dsp_r2_adduh_qb.c
index a1f5d631b52e..108a348456eb 100644
--- a/tests/tcg/mipsel/test_dsp_r2_adduh_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r2_adduh_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_adduh_r_qb.c b/tests/tcg/mipsel/test_dsp_r2_adduh_r_qb.c
index 81e98c190d2b..892513a4af7c 100644
--- a/tests/tcg/mipsel/test_dsp_r2_adduh_r_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r2_adduh_r_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_subqh_ph.c b/tests/tcg/mipsel/test_dsp_r2_subqh_ph.c
index dbc096734ceb..64c754777838 100644
--- a/tests/tcg/mipsel/test_dsp_r2_subqh_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_subqh_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_subqh_r_ph.c b/tests/tcg/mipsel/test_dsp_r2_subqh_r_ph.c
index 24ef0f1aeb91..717c3931e4df 100644
--- a/tests/tcg/mipsel/test_dsp_r2_subqh_r_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_subqh_r_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_subqh_r_w.c b/tests/tcg/mipsel/test_dsp_r2_subqh_r_w.c
index d460f8630fae..3d20a87b5a94 100644
--- a/tests/tcg/mipsel/test_dsp_r2_subqh_r_w.c
+++ b/tests/tcg/mipsel/test_dsp_r2_subqh_r_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_subqh_w.c b/tests/tcg/mipsel/test_dsp_r2_subqh_w.c
index 42be3deb80a3..9d41911233c2 100644
--- a/tests/tcg/mipsel/test_dsp_r2_subqh_w.c
+++ b/tests/tcg/mipsel/test_dsp_r2_subqh_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_subu_ph.c b/tests/tcg/mipsel/test_dsp_r2_subu_ph.c
index 0d39a017c79d..702eb141d833 100644
--- a/tests/tcg/mipsel/test_dsp_r2_subu_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_subu_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_subu_s_ph.c b/tests/tcg/mipsel/test_dsp_r2_subu_s_ph.c
index 8e4da4f3e544..86afcdc0d660 100644
--- a/tests/tcg/mipsel/test_dsp_r2_subu_s_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_subu_s_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_subuh_qb.c b/tests/tcg/mipsel/test_dsp_r2_subuh_qb.c
index 92cfc764b8c9..ae9ea3f72a36 100644
--- a/tests/tcg/mipsel/test_dsp_r2_subuh_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r2_subuh_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_subuh_r_qb.c b/tests/tcg/mipsel/test_dsp_r2_subuh_r_qb.c
index dac81d47db60..fc90b9cce0e8 100644
--- a/tests/tcg/mipsel/test_dsp_r2_subuh_r_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r2_subuh_r_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index 77f210a47a70..e7e576ad6c19 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -5,15 +5,7 @@ tests += tcg_tests['multiarch-linux-user']['tests']
 
 tests_dsp = [
   'test_dsp_acc.c',
-  'test_dsp_r1_absq_s_ph.c',
-  'test_dsp_r1_absq_s_w.c',
-  'test_dsp_r1_addq_ph.c',
-  'test_dsp_r1_addq_s_ph.c',
-  'test_dsp_r1_addq_s_w.c',
-  'test_dsp_r1_addsc.c',
-  'test_dsp_r1_addu_qb.c',
-  'test_dsp_r1_addu_s_qb.c',
-  'test_dsp_r1_addwc.c',
+  'test_dsp_arith.c',
   'test_dsp_r1_bitrev.c',
   'test_dsp_r1_bposge32.c',
   'test_dsp_r1_cmp_eq_ph.c',
@@ -43,7 +35,6 @@ tests_dsp = [
   'test_dsp_r1_maq_s_w_phr.c',
   'test_dsp_r1_maq_sa_w_phl.c',
   'test_dsp_r1_maq_sa_w_phr.c',
-  'test_dsp_r1_modsub.c',
   'test_dsp_r1_msub.c',
   'test_dsp_r1_msubu.c',
   'test_dsp_r1_muleq_s_w_phl.c',
@@ -70,7 +61,6 @@ tests_dsp = [
   'test_dsp_r1_precrq_qb_ph.c',
   'test_dsp_r1_precrq_rs_ph_w.c',
   'test_dsp_r1_precrqu_s_qb_ph.c',
-  'test_dsp_r1_raddu_w_qb.c',
   'test_dsp_r1_rddsp.c',
   'test_dsp_r1_repl_ph.c',
   'test_dsp_r1_repl_qb.c',
@@ -92,21 +82,7 @@ tests_dsp = [
   'test_dsp_r1_shrav_r_w.c',
   'test_dsp_r1_shrl_qb.c',
   'test_dsp_r1_shrlv_qb.c',
-  'test_dsp_r1_subq_ph.c',
-  'test_dsp_r1_subq_s_ph.c',
-  'test_dsp_r1_subq_s_w.c',
-  'test_dsp_r1_subu_qb.c',
-  'test_dsp_r1_subu_s_qb.c',
   'test_dsp_r1_wrdsp.c',
-  'test_dsp_r2_absq_s_qb.c',
-  'test_dsp_r2_addqh_ph.c',
-  'test_dsp_r2_addqh_r_ph.c',
-  'test_dsp_r2_addqh_r_w.c',
-  'test_dsp_r2_addqh_w.c',
-  'test_dsp_r2_addu_ph.c',
-  'test_dsp_r2_addu_s_ph.c',
-  'test_dsp_r2_adduh_qb.c',
-  'test_dsp_r2_adduh_r_qb.c',
   'test_dsp_r2_append.c',
   'test_dsp_r2_balign.c',
   'test_dsp_r2_cmpgdu_eq_qb.c',
@@ -137,14 +113,6 @@ tests_dsp = [
   'test_dsp_r2_shrav_r_qb.c',
   'test_dsp_r2_shrl_ph.c',
   'test_dsp_r2_shrlv_ph.c',
-  'test_dsp_r2_subqh_ph.c',
-  'test_dsp_r2_subqh_r_ph.c',
-  'test_dsp_r2_subqh_r_w.c',
-  'test_dsp_r2_subqh_w.c',
-  'test_dsp_r2_subu_ph.c',
-  'test_dsp_r2_subu_s_ph.c',
-  'test_dsp_r2_subuh_qb.c',
-  'test_dsp_r2_subuh_r_qb.c',
 ]
 
 foreach src: tests_dsp
-- 
2.55.0


