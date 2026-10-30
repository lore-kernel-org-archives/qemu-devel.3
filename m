Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9A3606A321
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LqteJMc9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NuhLuJ/T
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMo7i-00079a-HH; Fri, 30 Oct 2026 11:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMo7h-00079N-2c
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:02:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMo7e-00076u-D3
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:02:28 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UER8Nw3552208
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:02:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FjEO4La4/4Chfq4BT+QGh+fqYIFXDpX7p3xI4AN3B/0=; b=LqteJMc9lsAZHwTw
 UOsSZ56OwBRKSTGIXO6dtASEI0FcImfYZI23vW3dw11riUMqXtFYLgsQCdz4YIGL
 UwQh4HxpcWC0aRx+Mvh6GG/4QwOjR3dlbSx5bL3vJ7Qhue3gRqEJHA/rSF6Y1L/5
 WCY2sllKn06SB0uI4Y+K+VAUM2TXaV5F/tQg2K1yCi3gWouKEmL4IGLMZodDGt3x
 VFop1fmH4e6vfjlJtfP1kMM5DrPULJQIjh3JMW2qRNv6tWAZAXvBSw/Z/vnb0CyS
 VAfC7IN3mOrOYZ94FaYO1TXvmumcqIjrrxfUIozjFeC5UrJWIVo3C30MbzieUlAy
 1gdDOw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qkjyx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:02:24 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-980b637ed69so111476241.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793372544; x=1793977344; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FjEO4La4/4Chfq4BT+QGh+fqYIFXDpX7p3xI4AN3B/0=;
 b=NuhLuJ/TjE7+nQWrb6MiZz87mqmwwMN82h+7RAE9HTxgYuKQI/sHE24eG7JQ0/3Jnv
 XccYOiqGn738jDJhwuAKhIZW/MDfcFJZDAGa/Zxpr2Ww029CVOqa+fzW8o6n4LoUyGvp
 iG9ndFeBB6mGC8Y6I+HLnnCts4S8aB54COcwqA7Ia+a05bJX/t/DF1ciaTcSNSuGe0WS
 Ui+TUNul5/eoD9PUtUChpODi5TUqFgWu5gs+/LY7Eh4vcrjW3c7G0STQ+SzSpdQZDRGl
 VBqwdKRI0u75MdYY0aGEV1moXSr7b24O5LIkJhq5KlaiLGdvejpA6KhdrQGaSmuhnvT3
 Ngwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793372544; x=1793977344;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FjEO4La4/4Chfq4BT+QGh+fqYIFXDpX7p3xI4AN3B/0=;
 b=JiNBSU/WBjL4IkRu/W0HnRaxjZnppN5+k4w+xUvPe5m9hep4hvdwt6ZhNyCJpdcWkB
 imbIpytk5b7os+6BSmyW8i62F2BHRVyi19zPFDyzBE/cm5BhTHuLXaTChhQZPumlER8W
 7svPOjIsQRv7mg/yC3sEjlYPOGD2rmwoTsgfXfmFNvm8FJ4vLW3/GqdyErYtK101lFy4
 QhZbKmOk6Ubd5u8xE5NgFanamNi3wmK1h8hlXbpeY/CYdABBDD10RAL0cYQ8qkOZXGUa
 jiF4IOnRP1jjo2vyBkvXc1A+chKJAQNizPZvlum6KZIjEjGhSzfWyDOJA/DW7BsPDffH
 2a2g==
X-Gm-Message-State: AFq9FYKSJlbCskN/E9CampX/o1Dk36IWG9j2KqJ0B/utHfpwbmec3mA3
 8MapnznFKk9TuXJW8L2xeAr35lkHigLYJJ6VZFicmCtqzYffic50SRygW3x/M1DyBbaOGpdPgVk
 UOlYEOfJJC7dVA2fNWwFNqyk52Nh46Mr4il04aUBJ3ipHUREpRLQuciT0xh/PtgFqaecS
X-Gm-Gg: AYBFou25Qa1G9nvkmqhy92b8WwNYAux2nfnTP+gTbOWEa3DxYxtocyWjjDqZxS72tM9
 AZWWjZr+6jFou2maEb95pig52yAniSRew2swn/aBTCIaCYwgery3qL3Qgci+caBDy4+bfrEUSJr
 JkXa8Ef9n6Ma4WTCJDLILjKA3D2M2LIfki2Q+JTV0g3e1IgglPFF9iJ4TChaVaOiVZf5cxY362E
 qiaz8+NZp+D8D2hil/J32jpcKh9WHavFKaBFQPlmZPQuEt8mEODGxha58PQrq30eI5QEIsqqp/z
 AONUVTP/NB5D8mgbee/6HpxcIvF5dwSQZeSLuoACBjtzPTKyMXLx9jHYvFvhXBq5sh3eN0kz6Fa
 v2Q3sdkbHSLKLKccXk/VGjWDymf7NlohH/991mHwIfTuuo2bhJd0MoF2e+Y0GV8nk81pmNymvlU
 KYsl1Gg9FgRWsNYxNdxhguQpS/N1qRig==
X-Received: by 2002:a05:6102:a4d:b0:7ce:6288:eb0a with SMTP id
 ada2fe7eead31-7d0725b617bmr1207813137.18.1793372543361; 
 Fri, 30 Oct 2026 08:02:23 -0700 (PDT)
X-Received: by 2002:a05:6102:a4d:b0:7ce:6288:eb0a with SMTP id
 ada2fe7eead31-7d0725b617bmr1207664137.18.1793372542131; 
 Fri, 30 Oct 2026 08:02:22 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa813d2640sm140420025e9.6.2026.10.30.08.02.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 08:02:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 02/31] tests/tcg/mips: Group DSP arith tests
Date: Fri, 30 Oct 2026 16:01:32 +0100
Message-ID: <20261030150202.61556-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030150202.61556-1-philmd@oss.qualcomm.com>
References: <20261030150202.61556-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wkKYFRb73aZFI_V1Q4-EPht3SPeQWF5L
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfX+Iq3+utDebZ0
 QZvEE4xX7xbE9iIk7sOUfFD1kIwc9/dkHmV68kuseYtk+pU04z8AgeL+cPRHrV4dvUEyaZb3211
 C8LDdmhCjITCU03syYF4aqYmp3fRnu8=
X-Authority-Analysis: v=2.4 cv=DfSCOftW c=1 sm=1 tr=0 ts=6ae4b180 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=QcVZmDX5zYVA5dVMsrUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: wkKYFRb73aZFI_V1Q4-EPht3SPeQWF5L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfX1qO/p2QnBZTL
 bUaXQCxH6bwbkR/WM/x4VUB4+sjhr1iEzeRho8My5VdRGRYEuZtN7+qj0VN/OLHJdAJ1g27D3MQ
 lmuvZ57KuanANpr2LWmTLC9K+ZvTKOoSZEy+bWyjYlBFkC6oi3SzQjIkOqXwS+qMlJ5FZ9YuDsR
 DucubDdDcEINQnTPJsY6MDoI464fEZBRPXswbiDxsCB7YIFytNyo9E3zF1TcGGqxOymykmvD6YP
 4OryjPRcEdSudfHiOB1Rrzha8HIRXX/0QjePAQl9TSq20o/diIzP/BO0JiOcIIjTnvc63FExj8X
 nDZZM74fE/mWjsHpi6Yh4D7zR0f7HWvG3m4ZEwiGX7BzOhbEQIlaXxG2+TV+0C+ENiBJFLCnQra
 r1g8JUSJ0qobHlJLOy7E65bOwCWeIP4qkQka9N4U+04JFRrj579p6WWhfpqMCIU+HBsSxUO1Gem
 ShufZYbSfvHgfvql7SA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300059
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
 tests/tcg/mipsel/test_dsp_arith.c         | 178 ++++++++++++++++++++++
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
 tests/tcg/mipsel/meson.build              |  34 +----
 35 files changed, 179 insertions(+), 66 deletions(-)
 create mode 100644 tests/tcg/mipsel/test_dsp_arith.c

diff --git a/tests/tcg/mipsel/test_dsp_arith.c b/tests/tcg/mipsel/test_dsp_arith.c
new file mode 100644
index 000000000000..df5b5eaedc31
--- /dev/null
+++ b/tests/tcg/mipsel/test_dsp_arith.c
@@ -0,0 +1,178 @@
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


