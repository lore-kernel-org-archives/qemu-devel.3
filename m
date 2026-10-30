Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17DF60A2602
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iCGOSqiJ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=W1o6aAcx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqq2-0007GF-9s; Fri, 30 Oct 2026 13:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqoW-0005eh-Ob
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:54:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqoS-0007ra-TE
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:54:52 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UER70X2596688
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:54:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nx03ZgXsxMjkKRARk2M6M4nCvJAxxWZ8UsJ53jyDZN4=; b=iCGOSqiJqivpqvhF
 w2W5f1RzV5NESC9GRogxbEnASB36mQrxkhUTqge6m4a1JxypurGhVg+apgz4sOo1
 K+gvKAwwde6M63x/8drXfPF6hjqmManDGDtLxzrxsBfuuGGusBl25FqqWQ4ShxhP
 xjgYnHg+SUY67Wx/5Bk+yPd2/KaKvb6wsQde7y+4gbLVN6kG06DoKp0tVxw2BeAs
 be2wPOA0ta+l6NiTcW8zUfkcgrdYbOpqIphwCZnPe/t5k1rFrbTeLG+DR1FoqnGP
 B7lMjNFRAu6USOqIIXebd8yT4tzmV5Slgye5j1tYWaJkU95733RBGzKycxI5Hz8q
 n9AZCw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6pcb7m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:54:47 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7cb9d27ddcfso108340137.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793382886; x=1793987686; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nx03ZgXsxMjkKRARk2M6M4nCvJAxxWZ8UsJ53jyDZN4=;
 b=W1o6aAcxaPOtP8+3RfN/LKxiZqRw+k29jRsizmmkHdSdDTg4Lgst0ATjNMOBP3CfS2
 TkfdLblODiy8kagrn3AahPtU6w7o3wOzOjWXwu3Rdm7v05R/8heCubhPoooSZqHxw5hf
 2jX5RUzxxEs+5Bbz6+rscuIyKoCv3r/gmBfm5ej3fD5laBfEu6sJV+ATCtTtbDoT2HRC
 xU43blaxLDhU8iWJ62kW0cS1FIuPxa55/aPKmD51ECI8JQbh3H/b8/ksCFyDiUnU+W5V
 KOJFEb9Dj/DgOjl1F10Y1VbFrWc2crAxXTejrKpNbd3yu7uBuQDHZp1olhYp2LWshXjQ
 aLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793382886; x=1793987686;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nx03ZgXsxMjkKRARk2M6M4nCvJAxxWZ8UsJ53jyDZN4=;
 b=cqqIY5qO1P/r18aG1VqICTj0ngFI/sGnIiEaxyXmKITZI1DbR3DoXG1O8N/ZzaxEcm
 CN2UySYW4/FpH7ekfppkvhT6NpNS8zFvMU1hTpevVrDgjLv/bFEh/x9B6X3xRS3pMZLs
 g9bkZLhE6OCHpEj04M9wqqUlFqUZtUTH1sV/F7HwnkjDZlinjgDisrIbcIsN8IROM77M
 u7FltBt9X9/3PQE7KYSPiqVyDdcZHRCIDXISI/Jn7uQF1RY/SMnOJ6mJVJ5X7p9M09Ea
 E2ik+MuP0aAuJ2953r9D1yH3QfxQAJjqLq2OxZU5OnvkpHnETpy3MRj6DA5prWK9JyrU
 cvew==
X-Gm-Message-State: AFq9FYI7imFBPgRmaPYxCyIgV0ivVA0w3M57NUxBYABxs3RLd+WvsWkd
 b90PFvUp7kFE0XhFJ9W/8T//PY0sJmwdT84Phe6p8Az9jKTky15B3LUZ2d83M9sFYoQGlotlTye
 UPhf9w5sNFkaCTkUBp0D0d33JV8nWATLoUp3iEgURDtluYDHEhk6sOo6k/7ASXP8bNTsi
X-Gm-Gg: AYBFou0BdkBeWO4uykmQ/rVXUViisGlmU1HcJmP1Za3pgqhG8wpLYaYhAXK+bvY8Wj3
 mqJ37kwzheME4k2VWIzH5Cz2IK4RyF1d0xUR2r1y0q34ggvVUo3eksgF1syEkvVjTpZATkEmWYd
 /Napdy2AiP9Q0TlX34mN+FlPtVMBAO1xPhj/oOtyG13gWv4xpxlzAzDAxIWm90fZCU1s9DuzkHv
 fFuvO9u32DsZESo9TNWswcdtBU8BMQjk8qbW9JUH5D3hybwckKk5R6TrmHhU/wfqo9lZ80YD5Y2
 uWqvg3mJQqa/8cLPFqCL09hf6jk6bibQ2V0dUgJZWu1VnNYkDM2VQpqhlQ3mjavSz7OXwtcWkRw
 cDCZOTNo3dHQ/sfq7Al/UEHWakuUHRMbPa/fyy3AuHO7MR13QWgTadrED8T+k7QxZSn6jVgW0De
 Ym+XFOiKvcK9E3jK5jruutvdRfO7c7Ig==
X-Received: by 2002:a05:6102:14a3:b0:7be:37d8:1567 with SMTP id
 ada2fe7eead31-7d0725cefa6mr1552996137.10.1793382886320; 
 Fri, 30 Oct 2026 10:54:46 -0700 (PDT)
X-Received: by 2002:a05:6102:14a3:b0:7be:37d8:1567 with SMTP id
 ada2fe7eead31-7d0725cefa6mr1552981137.10.1793382885674; 
 Fri, 30 Oct 2026 10:54:45 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b8011csm5057798f8f.31.2026.10.30.10.54.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 10:54:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4 06/32] tests/tcg/mips: Group DSP dot tests
Date: Fri, 30 Oct 2026 18:53:28 +0100
Message-ID: <20261030175357.99684-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030175357.99684-1-philmd@oss.qualcomm.com>
References: <20261030175357.99684-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX4VIr24jSEhaQ
 CxL4hTs4gwSoIVtGGGk82BeZZg2XgrQUy91umtI3LzKsvch1reNoH2MbyVdsCELOdWQQTYgFvkI
 GBoPwcsNbajdi/ftoLOnwLuLQqCGqD1v92v983cHE1HKs/J7LGIbNwZvDr5OHxKD/Nfx9DqtT4G
 8vq4/4UFd+jYyZs9egys4g9bwpFZzKD2Bk5ciB/vCf1LMhWZhW5GxxQe0J9gyrLp+6DOLr5VsZI
 iDewyaww6Dz3MlCPvCvx51KOTIQ4I5enN12KnJewRJRAhT5ob5qVUkmPcpOcQ4q8MU8+1S6J4Pd
 WlBqf4p/NIcIU98qNOpe0LWgeZatGTWF2no1TRHfqaKBZ9/gUL2kDTQRvqXsuHeESZuJLRgzuU4
 uHu/YMBvhoW534aWxnt3bcwrC2RIIss7g5ZTa0lRyuRn6uKhWEfms/xr8o6NCevsndNBvFFqGkA
 iAjmeZHOsVcag3mKzGg==
X-Proofpoint-GUID: iahEuEiH_IpjoPruQQzdoIjuEryY6_P_
X-Authority-Analysis: v=2.4 cv=Lp4HWXdc c=1 sm=1 tr=0 ts=6ae4d9e7 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=Ss58A6hLZCuk7yZQP4AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-ORIG-GUID: iahEuEiH_IpjoPruQQzdoIjuEryY6_P_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX2Yx/47Otjsol
 ywteZy/W802BjzYVc5b0UOWedHq/Fb3TEzooMUN9EEVKrXRts2myIfKaXXvt4wAb4yi+Rr6bjRS
 z1G1RoCBMQmN9pOkaQXvrFLS8GGUcYA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300071
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Build the 28 per-opcode dot tests as a single executable,
test_dsp_dot.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mipsel/test_dsp_dot.c              | 154 +++++++++++++++++++
 tests/tcg/mipsel/test_dsp_r1_dpaq_s_w_ph.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_dpaq_sa_l_w.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_dpau_h_qbl.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_dpau_h_qbr.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_dpsq_s_w_ph.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_dpsq_sa_l_w.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbl.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbr.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_madd.c          |   1 -
 tests/tcg/mipsel/test_dsp_r1_maddu.c         |   1 -
 tests/tcg/mipsel/test_dsp_r1_maq_s_w_phl.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_maq_s_w_phr.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phl.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phr.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_msub.c          |   1 -
 tests/tcg/mipsel/test_dsp_r1_msubu.c         |   1 -
 tests/tcg/mipsel/test_dsp_r1_mult.c          |   1 -
 tests/tcg/mipsel/test_dsp_r1_multu.c         |   1 -
 tests/tcg/mipsel/test_dsp_r2_dpa_w_ph.c      |   1 -
 tests/tcg/mipsel/test_dsp_r2_dpaqx_s_w_ph.c  |   1 -
 tests/tcg/mipsel/test_dsp_r2_dpaqx_sa_w_ph.c |   1 -
 tests/tcg/mipsel/test_dsp_r2_dpax_w_ph.c     |   1 -
 tests/tcg/mipsel/test_dsp_r2_dps_w_ph.c      |   1 -
 tests/tcg/mipsel/test_dsp_r2_dpsqx_s_w_ph.c  |   1 -
 tests/tcg/mipsel/test_dsp_r2_dpsqx_sa_w_ph.c |   1 -
 tests/tcg/mipsel/test_dsp_r2_dpsx_w_ph.c     |   1 -
 tests/tcg/mipsel/test_dsp_r2_mulsa_w_ph.c    |   1 -
 tests/tcg/mipsel/test_dsp_r2_mulsaq_s_w_ph.c |   1 -
 tests/tcg/mipsel/meson.build                 |  29 +---
 30 files changed, 155 insertions(+), 56 deletions(-)
 create mode 100644 tests/tcg/mipsel/test_dsp_dot.c

diff --git a/tests/tcg/mipsel/test_dsp_dot.c b/tests/tcg/mipsel/test_dsp_dot.c
new file mode 100644
index 000000000000..2aeba5402ded
--- /dev/null
+++ b/tests/tcg/mipsel/test_dsp_dot.c
@@ -0,0 +1,154 @@
+/*
+ * MIPS DSP ASE tests: Dot Product and Multiply-Accumulate instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "test_dsp_runner.h"
+
+#define main test_dsp_r1_dpaq_s_w_ph
+#include "test_dsp_r1_dpaq_s_w_ph.c"
+#undef main
+
+#define main test_dsp_r1_dpaq_sa_l_w
+#include "test_dsp_r1_dpaq_sa_l_w.c"
+#undef main
+
+#define main test_dsp_r1_dpau_h_qbl
+#include "test_dsp_r1_dpau_h_qbl.c"
+#undef main
+
+#define main test_dsp_r1_dpau_h_qbr
+#include "test_dsp_r1_dpau_h_qbr.c"
+#undef main
+
+#define main test_dsp_r1_dpsq_s_w_ph
+#include "test_dsp_r1_dpsq_s_w_ph.c"
+#undef main
+
+#define main test_dsp_r1_dpsq_sa_l_w
+#include "test_dsp_r1_dpsq_sa_l_w.c"
+#undef main
+
+#define main test_dsp_r1_dpsu_h_qbl
+#include "test_dsp_r1_dpsu_h_qbl.c"
+#undef main
+
+#define main test_dsp_r1_dpsu_h_qbr
+#include "test_dsp_r1_dpsu_h_qbr.c"
+#undef main
+
+#define main test_dsp_r1_maq_s_w_phl
+#include "test_dsp_r1_maq_s_w_phl.c"
+#undef main
+
+#define main test_dsp_r1_maq_s_w_phr
+#include "test_dsp_r1_maq_s_w_phr.c"
+#undef main
+
+#define main test_dsp_r1_maq_sa_w_phl
+#include "test_dsp_r1_maq_sa_w_phl.c"
+#undef main
+
+#define main test_dsp_r1_maq_sa_w_phr
+#include "test_dsp_r1_maq_sa_w_phr.c"
+#undef main
+
+#define main test_dsp_r1_madd
+#include "test_dsp_r1_madd.c"
+#undef main
+
+#define main test_dsp_r1_maddu
+#include "test_dsp_r1_maddu.c"
+#undef main
+
+#define main test_dsp_r1_msub
+#include "test_dsp_r1_msub.c"
+#undef main
+
+#define main test_dsp_r1_msubu
+#include "test_dsp_r1_msubu.c"
+#undef main
+
+#define main test_dsp_r1_mult
+#include "test_dsp_r1_mult.c"
+#undef main
+
+#define main test_dsp_r1_multu
+#include "test_dsp_r1_multu.c"
+#undef main
+
+#define main test_dsp_r2_dpa_w_ph
+#include "test_dsp_r2_dpa_w_ph.c"
+#undef main
+
+#define main test_dsp_r2_dpaqx_s_w_ph
+#include "test_dsp_r2_dpaqx_s_w_ph.c"
+#undef main
+
+#define main test_dsp_r2_dpaqx_sa_w_ph
+#include "test_dsp_r2_dpaqx_sa_w_ph.c"
+#undef main
+
+#define main test_dsp_r2_dpax_w_ph
+#include "test_dsp_r2_dpax_w_ph.c"
+#undef main
+
+#define main test_dsp_r2_dps_w_ph
+#include "test_dsp_r2_dps_w_ph.c"
+#undef main
+
+#define main test_dsp_r2_dpsqx_s_w_ph
+#include "test_dsp_r2_dpsqx_s_w_ph.c"
+#undef main
+
+#define main test_dsp_r2_dpsqx_sa_w_ph
+#include "test_dsp_r2_dpsqx_sa_w_ph.c"
+#undef main
+
+#define main test_dsp_r2_dpsx_w_ph
+#include "test_dsp_r2_dpsx_w_ph.c"
+#undef main
+
+#define main test_dsp_r2_mulsa_w_ph
+#include "test_dsp_r2_mulsa_w_ph.c"
+#undef main
+
+#define main test_dsp_r2_mulsaq_s_w_ph
+#include "test_dsp_r2_mulsaq_s_w_ph.c"
+#undef main
+
+int main(void)
+{
+    TAP_START();
+    RUN_TEST(test_dsp_r1_dpaq_s_w_ph);
+    RUN_TEST(test_dsp_r1_dpaq_sa_l_w);
+    RUN_TEST(test_dsp_r1_dpau_h_qbl);
+    RUN_TEST(test_dsp_r1_dpau_h_qbr);
+    RUN_TEST(test_dsp_r1_dpsq_s_w_ph);
+    RUN_TEST(test_dsp_r1_dpsq_sa_l_w);
+    RUN_TEST(test_dsp_r1_dpsu_h_qbl);
+    RUN_TEST(test_dsp_r1_dpsu_h_qbr);
+    RUN_TEST(test_dsp_r1_maq_s_w_phl);
+    RUN_TEST(test_dsp_r1_maq_s_w_phr);
+    RUN_TEST(test_dsp_r1_maq_sa_w_phl);
+    RUN_TEST(test_dsp_r1_maq_sa_w_phr);
+    RUN_TEST(test_dsp_r1_madd);
+    RUN_TEST(test_dsp_r1_maddu);
+    RUN_TEST(test_dsp_r1_msub);
+    RUN_TEST(test_dsp_r1_msubu);
+    RUN_TEST(test_dsp_r1_mult);
+    RUN_TEST(test_dsp_r1_multu);
+    RUN_TEST(test_dsp_r2_dpa_w_ph);
+    RUN_TEST(test_dsp_r2_dpaqx_s_w_ph);
+    RUN_TEST(test_dsp_r2_dpaqx_sa_w_ph);
+    RUN_TEST(test_dsp_r2_dpax_w_ph);
+    RUN_TEST(test_dsp_r2_dps_w_ph);
+    RUN_TEST(test_dsp_r2_dpsqx_s_w_ph);
+    RUN_TEST(test_dsp_r2_dpsqx_sa_w_ph);
+    RUN_TEST(test_dsp_r2_dpsx_w_ph);
+    RUN_TEST(test_dsp_r2_mulsa_w_ph);
+    RUN_TEST(test_dsp_r2_mulsaq_s_w_ph);
+
+    return tap_done();
+}
diff --git a/tests/tcg/mipsel/test_dsp_r1_dpaq_s_w_ph.c b/tests/tcg/mipsel/test_dsp_r1_dpaq_s_w_ph.c
index a6425b6edc84..3818ba7c2a48 100644
--- a/tests/tcg/mipsel/test_dsp_r1_dpaq_s_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_dpaq_s_w_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_dpaq_sa_l_w.c b/tests/tcg/mipsel/test_dsp_r1_dpaq_sa_l_w.c
index cbf900713f33..56a3c2f6e1d1 100644
--- a/tests/tcg/mipsel/test_dsp_r1_dpaq_sa_l_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_dpaq_sa_l_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_dpau_h_qbl.c b/tests/tcg/mipsel/test_dsp_r1_dpau_h_qbl.c
index 6017b5e73ab2..b90a9e9e72cc 100644
--- a/tests/tcg/mipsel/test_dsp_r1_dpau_h_qbl.c
+++ b/tests/tcg/mipsel/test_dsp_r1_dpau_h_qbl.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_dpau_h_qbr.c b/tests/tcg/mipsel/test_dsp_r1_dpau_h_qbr.c
index e4abb2e2af03..7828182f3151 100644
--- a/tests/tcg/mipsel/test_dsp_r1_dpau_h_qbr.c
+++ b/tests/tcg/mipsel/test_dsp_r1_dpau_h_qbr.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_dpsq_s_w_ph.c b/tests/tcg/mipsel/test_dsp_r1_dpsq_s_w_ph.c
index 74058fe7ecd0..14698262d589 100644
--- a/tests/tcg/mipsel/test_dsp_r1_dpsq_s_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_dpsq_s_w_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_dpsq_sa_l_w.c b/tests/tcg/mipsel/test_dsp_r1_dpsq_sa_l_w.c
index eda3b14e2be2..900f3f90bcb8 100644
--- a/tests/tcg/mipsel/test_dsp_r1_dpsq_sa_l_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_dpsq_sa_l_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbl.c b/tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbl.c
index 94e2bf625499..6958bbeb753b 100644
--- a/tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbl.c
+++ b/tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbl.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbr.c b/tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbr.c
index a1e66356310d..f127d1662714 100644
--- a/tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbr.c
+++ b/tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbr.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_madd.c b/tests/tcg/mipsel/test_dsp_r1_madd.c
index af4bfcfe9df3..f724fd9a27c0 100644
--- a/tests/tcg/mipsel/test_dsp_r1_madd.c
+++ b/tests/tcg/mipsel/test_dsp_r1_madd.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_maddu.c b/tests/tcg/mipsel/test_dsp_r1_maddu.c
index af4bfcfe9df3..f724fd9a27c0 100644
--- a/tests/tcg/mipsel/test_dsp_r1_maddu.c
+++ b/tests/tcg/mipsel/test_dsp_r1_maddu.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_maq_s_w_phl.c b/tests/tcg/mipsel/test_dsp_r1_maq_s_w_phl.c
index 0f7c070155a8..aa29fd5e3821 100644
--- a/tests/tcg/mipsel/test_dsp_r1_maq_s_w_phl.c
+++ b/tests/tcg/mipsel/test_dsp_r1_maq_s_w_phl.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_maq_s_w_phr.c b/tests/tcg/mipsel/test_dsp_r1_maq_s_w_phr.c
index 942722a530c2..42833686936c 100644
--- a/tests/tcg/mipsel/test_dsp_r1_maq_s_w_phr.c
+++ b/tests/tcg/mipsel/test_dsp_r1_maq_s_w_phr.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phl.c b/tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phl.c
index d83dce6f3272..9dda4ebdbbe9 100644
--- a/tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phl.c
+++ b/tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phl.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phr.c b/tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phr.c
index d2331118abb8..1b34664280dc 100644
--- a/tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phr.c
+++ b/tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phr.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_msub.c b/tests/tcg/mipsel/test_dsp_r1_msub.c
index 5779e6f47ac7..74146284ffe2 100644
--- a/tests/tcg/mipsel/test_dsp_r1_msub.c
+++ b/tests/tcg/mipsel/test_dsp_r1_msub.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_msubu.c b/tests/tcg/mipsel/test_dsp_r1_msubu.c
index e0f9b5a77ae3..2eb728af64b4 100644
--- a/tests/tcg/mipsel/test_dsp_r1_msubu.c
+++ b/tests/tcg/mipsel/test_dsp_r1_msubu.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_mult.c b/tests/tcg/mipsel/test_dsp_r1_mult.c
index 15e6fde92c0e..c0509396de72 100644
--- a/tests/tcg/mipsel/test_dsp_r1_mult.c
+++ b/tests/tcg/mipsel/test_dsp_r1_mult.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_multu.c b/tests/tcg/mipsel/test_dsp_r1_multu.c
index 85d36c1b621a..1c8a7f1e01e7 100644
--- a/tests/tcg/mipsel/test_dsp_r1_multu.c
+++ b/tests/tcg/mipsel/test_dsp_r1_multu.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_dpa_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dpa_w_ph.c
index fae49f10eb95..68eae5a08346 100644
--- a/tests/tcg/mipsel/test_dsp_r2_dpa_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_dpa_w_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_dpaqx_s_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dpaqx_s_w_ph.c
index ce8783024685..06b1a0a0d7e8 100644
--- a/tests/tcg/mipsel/test_dsp_r2_dpaqx_s_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_dpaqx_s_w_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_dpaqx_sa_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dpaqx_sa_w_ph.c
index d551d64ae293..6dd106d74cae 100644
--- a/tests/tcg/mipsel/test_dsp_r2_dpaqx_sa_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_dpaqx_sa_w_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_dpax_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dpax_w_ph.c
index 514797cfd1b4..a812c8a7f854 100644
--- a/tests/tcg/mipsel/test_dsp_r2_dpax_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_dpax_w_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_dps_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dps_w_ph.c
index f51f9b9d13d7..a656d219d89f 100644
--- a/tests/tcg/mipsel/test_dsp_r2_dps_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_dps_w_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_dpsqx_s_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dpsqx_s_w_ph.c
index e40543fd8292..960f2bbbdf36 100644
--- a/tests/tcg/mipsel/test_dsp_r2_dpsqx_s_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_dpsqx_s_w_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_dpsqx_sa_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dpsqx_sa_w_ph.c
index 7da278eacc0e..68f20348c2c9 100644
--- a/tests/tcg/mipsel/test_dsp_r2_dpsqx_sa_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_dpsqx_sa_w_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_dpsx_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dpsx_w_ph.c
index bb49a4031d34..d85b504b402e 100644
--- a/tests/tcg/mipsel/test_dsp_r2_dpsx_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_dpsx_w_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_mulsa_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_mulsa_w_ph.c
index a6940939ca50..842233b2785b 100644
--- a/tests/tcg/mipsel/test_dsp_r2_mulsa_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_mulsa_w_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_mulsaq_s_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_mulsaq_s_w_ph.c
index 06c91a43e7ea..c0f8e51ad389 100644
--- a/tests/tcg/mipsel/test_dsp_r2_mulsaq_s_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_mulsaq_s_w_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index 1c2851f56369..c26f5fba06b7 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -8,31 +8,14 @@ tests_dsp = [
   'test_dsp_arith.c',
   'test_dsp_cmp.c',
   'test_dsp_ctrl.c',
+  'test_dsp_dot.c',
   'test_dsp_r1_bitrev.c',
-  'test_dsp_r1_dpaq_s_w_ph.c',
-  'test_dsp_r1_dpaq_sa_l_w.c',
-  'test_dsp_r1_dpau_h_qbl.c',
-  'test_dsp_r1_dpau_h_qbr.c',
-  'test_dsp_r1_dpsq_s_w_ph.c',
-  'test_dsp_r1_dpsq_sa_l_w.c',
-  'test_dsp_r1_dpsu_h_qbl.c',
-  'test_dsp_r1_dpsu_h_qbr.c',
   'test_dsp_r1_insv.c',
-  'test_dsp_r1_madd.c',
-  'test_dsp_r1_maddu.c',
-  'test_dsp_r1_maq_s_w_phl.c',
-  'test_dsp_r1_maq_s_w_phr.c',
-  'test_dsp_r1_maq_sa_w_phl.c',
-  'test_dsp_r1_maq_sa_w_phr.c',
-  'test_dsp_r1_msub.c',
-  'test_dsp_r1_msubu.c',
   'test_dsp_r1_muleq_s_w_phl.c',
   'test_dsp_r1_muleq_s_w_phr.c',
   'test_dsp_r1_muleu_s_ph_qbl.c',
   'test_dsp_r1_muleu_s_ph_qbr.c',
   'test_dsp_r1_mulq_rs_ph.c',
-  'test_dsp_r1_mult.c',
-  'test_dsp_r1_multu.c',
   'test_dsp_r1_packrl_ph.c',
   'test_dsp_r1_preceq_w_phl.c',
   'test_dsp_r1_preceq_w_phr.c',
@@ -70,21 +53,11 @@ tests_dsp = [
   'test_dsp_r1_shrlv_qb.c',
   'test_dsp_r2_append.c',
   'test_dsp_r2_balign.c',
-  'test_dsp_r2_dpa_w_ph.c',
-  'test_dsp_r2_dpaqx_s_w_ph.c',
-  'test_dsp_r2_dpaqx_sa_w_ph.c',
-  'test_dsp_r2_dpax_w_ph.c',
-  'test_dsp_r2_dps_w_ph.c',
-  'test_dsp_r2_dpsqx_s_w_ph.c',
-  'test_dsp_r2_dpsqx_sa_w_ph.c',
-  'test_dsp_r2_dpsx_w_ph.c',
   'test_dsp_r2_mul_ph.c',
   'test_dsp_r2_mul_s_ph.c',
   'test_dsp_r2_mulq_rs_w.c',
   'test_dsp_r2_mulq_s_ph.c',
   'test_dsp_r2_mulq_s_w.c',
-  'test_dsp_r2_mulsa_w_ph.c',
-  'test_dsp_r2_mulsaq_s_w_ph.c',
   'test_dsp_r2_precr_qb_ph.c',
   'test_dsp_r2_precr_sra_ph_w.c',
   'test_dsp_r2_precr_sra_r_ph_w.c',
-- 
2.55.0


