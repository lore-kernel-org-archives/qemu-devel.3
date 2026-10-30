Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7042460A2620
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XW8kRxI3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ua0czcp3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqtY-00035w-Om; Fri, 30 Oct 2026 14:00:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqrE-0000AZ-NG
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:57:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqrC-0008KA-JR
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:57:40 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UHu2xT839421
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Bxsu9u4oVKDtEZe4QmXdSZ1Vhttc+BXVOJdADv7LnSc=; b=XW8kRxI35J+bmfMY
 3iXgdkKk5lqsLmPQmrtcH/FR3rQcGk2qoI3NJ//EDkhMbwH4fuj9CLX42v8CmP5g
 /FyzoJnpsiauYB/llMe1YvvwcC4ENoz7faeP+uUSgKieJTQkI3CVfud88jr49I6S
 uhNpnmf0w8J3td8wF6sja7ObDGgaYj3RdCZQVV85WCPuuPqWpqVGJX6RP49PS/5C
 4BbDAbAzMz1IEI7n5kR/EWU1G3wxY6NRf3uQ6KvQ9cirPDudSO4Awfz/8UUefL2o
 INyej1tHBhNvVJHLPr6xBPI4xyyrTEl7Qck2uq4ebG3eypO6t7Fmgb8Z8oePjSIh
 UqsfrA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme754acb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:57:34 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-944101e6367so196324485a.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793383048; x=1793987848; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Bxsu9u4oVKDtEZe4QmXdSZ1Vhttc+BXVOJdADv7LnSc=;
 b=Ua0czcp3hBpkdKq90Q6dtnXWCiDZYeMoSu3ZVYR+AfHvAD3pPwWltUgkPnCdt7oi20
 6RxVzObrZhx4gblW5vbdk/p7lXTlgtUbcl0x28xITdDOVwIECcqQrsGvt5KjPmyL/xeZ
 EQJT9g9Jg8vYJtrYkRpGy/YENJmz6YD0UeCs9lEWPuCJEdi7zhKFo31t5WYB/SxekeS9
 FVfjNxFsxvTcr1t00hC/Cy8NVbbuYoI+s/LkWmvKDu5mpt21YpdyKsoWf1rto8kqgbyX
 F3Bv/pb98msh2EwvcbRISCXKo8JsVVj2rhRw10jSv+6ZkzSX3RhKQCjj6KDfWZ+RSbhw
 EdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793383048; x=1793987848;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Bxsu9u4oVKDtEZe4QmXdSZ1Vhttc+BXVOJdADv7LnSc=;
 b=jivcaSUQK3wpaBGNg6bhbLX8igAKTjeNTk3IpUZzFQkKYrSAEBjJlHJsXoA5NKx6hG
 ORZaKQCYGxL0Kf0MpMT7L9Qi/k1uGMOEBKjgFj+qalwuepZQ17/dhmzjGrcxkCVfx+NW
 LSs10FYJjI4lezBK5CVYTyeDzFqk4BSZUv3DjDAGrcTp3NlTyEGV0LrnZ7ojxNubuaDo
 6TSQH20bDMbxhxkUEDalxZV0UKp0zHLhGPFAeSdNNvvQIfrtbaXBYIQPfQzmkBqXE1uB
 4fiZXSA+U13KZqlqXJcZSxYR/iOibtd9K3iyw09FUeMK3HGLf12uV9GSXx8k4yzyOIXb
 d0Fg==
X-Gm-Message-State: AFq9FYLgVGITdiOyKNdEe8skZLTPfwvIObqlQErR41yvni/CuYLEBluh
 6b/y/YqRn93nYOoxN1TE7n5yWj3a/KLxnUFuBh0fh1OnvqZV8KoTGix3dfy2W2Aoi9IcLfpWxL5
 CBbvRSiTPGSKY5Io7FkQ+S0bR4pCGgCqWZreVIs5TmRMNWD83v0PtwGpm80eRNCfXIxSj
X-Gm-Gg: AYBFou1X0CwXCU9aXNVwFxOti9gsx/CrQEGrjAounI80H226zyzzAO6/1ufzscRMn+b
 WlyrXWaOoo1i7O8XboKxerHjyVGv/sX0v+07V6aRBfIqYMCrBHGIUvnW/RqIO/oBKnSDrgOM4Zc
 vcg+id7T0X2e+a3WSf6wGUz7641ujZG6gPMZQiD2Gkms/8XQ2jt+HMwQ7k3AftkQtKJYMfM7QhQ
 /Dfp8YIDV/i6m7MicnGA9gvlfAexGw9y4Z3SMUDPSSc4icHCYpLgE7/ngcBblLnmQFUX+xnWeju
 F5/3GMnBbWd/b7Rf6J9LmMpRj+QwjwpPulmHM+5m5AwIkVj/QSq4kjldklEGTXSvynqOHKPgb+J
 C8B9ThYsKM0VV0vKOPsd8K7GTN7tCwlC7UomR+wFVPRX9KgOnZM6AQa7lrpPwGpCv4UYrABszkE
 NUCvWCfufwDAFNvzv4DwEkgDVgm9UaMw==
X-Received: by 2002:a05:620a:4722:b0:93f:4a02:ed99 with SMTP id
 af79cd13be357-94413386199mr1027784785a.20.1793383047705; 
 Fri, 30 Oct 2026 10:57:27 -0700 (PDT)
X-Received: by 2002:a05:620a:4722:b0:93f:4a02:ed99 with SMTP id
 af79cd13be357-94413386199mr1027781885a.20.1793383047195; 
 Fri, 30 Oct 2026 10:57:27 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b725a2sm4260369f8f.13.2026.10.30.10.57.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 10:57:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4 25/32] tests/tcg/mips: Group MSA int-max-min tests
Date: Fri, 30 Oct 2026 18:53:47 +0100
Message-ID: <20261030175357.99684-26-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030175357.99684-1-philmd@oss.qualcomm.com>
References: <20261030175357.99684-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rC3iZcqIAQc1-An3relEQD8Uenzaqfyz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX32HLHz2Y6eZO
 hYOOi0WsXsUbMRvAlcUXDVpAI51ltuhwnPKbSfG+cuKEzczQ/74VI+aEVqPOjTUxixN8A97wvl3
 103Czk0GimJZBQAj2KGuCG4O1KZQHMdN97+GyKdyCmvXEYa9yU/O7qptbRHaOONeO1SYpEVPobO
 By/F3B7xd5xWriZ70xvJFsbgp7BkKNCy5n0etQjBthK3kragXkrDXQXR9vlSeRI2HJWxUGcVFgr
 VkRJtOFIhZ5joNFdupnahL8KTIg20eqNLOfwMk//PTTOPe+gEqPMVy9p8Q7/kNNvFh1peltB7SP
 CD9KpL65iC71ljR50o84vFDcW2kyu0gPuqQmpB8qqPiROBH1winJ7oUMKkwIOhL8FEhnKAFZPZz
 2QziolxKHUzwSDi2HXFVi3wRcMWRHWGhbskC7q6SsbeMyTCjQCMBCYavicJ3VTK+fbL/UuE3NNy
 ElyVqd1aAio6uHZ2tPA==
X-Proofpoint-ORIG-GUID: rC3iZcqIAQc1-An3relEQD8Uenzaqfyz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfXw/naGmCDBzzF
 2vlMvABxVagtBEcRo02a2E1poAZEMdJ7RXN4IjsQqpToiLQd2KMa5eli5KFW5n6HvpDt1CC6GUm
 3lWHfe2ifUKKsk26FELJmc9uaVzIdJQ=
X-Authority-Analysis: v=2.4 cv=KdtHIgYD c=1 sm=1 tr=0 ts=6ae4da8e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=31ySfBESk6nFzokIpWYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300071
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Build the 24 per-opcode int-max-min tests as a single executable,
test_msa_int_max_min.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_int_max_min.c | 171 ++++++++++++++++++++++++++
 tests/tcg/mips/meson.build            |  25 +---
 2 files changed, 172 insertions(+), 24 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_int_max_min.c

diff --git a/tests/tcg/mips/test_msa_int_max_min.c b/tests/tcg/mips/test_msa_int_max_min.c
new file mode 100644
index 000000000000..83eac723dd78
--- /dev/null
+++ b/tests/tcg/mips/test_msa_int_max_min.c
@@ -0,0 +1,171 @@
+/*
+ * MIPS MSA tests: Int Min / Max instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "../include/tap.h"
+
+#define main test_msa_max_a_b
+#include "user/ase/msa/int-max-min/test_msa_max_a_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_a_d
+#include "user/ase/msa/int-max-min/test_msa_max_a_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_a_h
+#include "user/ase/msa/int-max-min/test_msa_max_a_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_a_w
+#include "user/ase/msa/int-max-min/test_msa_max_a_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_s_b
+#include "user/ase/msa/int-max-min/test_msa_max_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_s_d
+#include "user/ase/msa/int-max-min/test_msa_max_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_s_h
+#include "user/ase/msa/int-max-min/test_msa_max_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_s_w
+#include "user/ase/msa/int-max-min/test_msa_max_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_u_b
+#include "user/ase/msa/int-max-min/test_msa_max_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_u_d
+#include "user/ase/msa/int-max-min/test_msa_max_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_u_h
+#include "user/ase/msa/int-max-min/test_msa_max_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_max_u_w
+#include "user/ase/msa/int-max-min/test_msa_max_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_a_b
+#include "user/ase/msa/int-max-min/test_msa_min_a_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_a_d
+#include "user/ase/msa/int-max-min/test_msa_min_a_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_a_h
+#include "user/ase/msa/int-max-min/test_msa_min_a_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_a_w
+#include "user/ase/msa/int-max-min/test_msa_min_a_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_s_b
+#include "user/ase/msa/int-max-min/test_msa_min_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_s_d
+#include "user/ase/msa/int-max-min/test_msa_min_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_s_h
+#include "user/ase/msa/int-max-min/test_msa_min_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_s_w
+#include "user/ase/msa/int-max-min/test_msa_min_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_u_b
+#include "user/ase/msa/int-max-min/test_msa_min_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_u_d
+#include "user/ase/msa/int-max-min/test_msa_min_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_u_h
+#include "user/ase/msa/int-max-min/test_msa_min_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_min_u_w
+#include "user/ase/msa/int-max-min/test_msa_min_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} msa_tests[] = {
+    { "max.a.b", test_msa_max_a_b },
+    { "max.a.d", test_msa_max_a_d },
+    { "max.a.h", test_msa_max_a_h },
+    { "max.a.w", test_msa_max_a_w },
+    { "max.s.b", test_msa_max_s_b },
+    { "max.s.d", test_msa_max_s_d },
+    { "max.s.h", test_msa_max_s_h },
+    { "max.s.w", test_msa_max_s_w },
+    { "max.u.b", test_msa_max_u_b },
+    { "max.u.d", test_msa_max_u_d },
+    { "max.u.h", test_msa_max_u_h },
+    { "max.u.w", test_msa_max_u_w },
+    { "min.a.b", test_msa_min_a_b },
+    { "min.a.d", test_msa_min_a_d },
+    { "min.a.h", test_msa_min_a_h },
+    { "min.a.w", test_msa_min_a_w },
+    { "min.s.b", test_msa_min_s_b },
+    { "min.s.d", test_msa_min_s_d },
+    { "min.s.h", test_msa_min_s_h },
+    { "min.s.w", test_msa_min_s_w },
+    { "min.u.b", test_msa_min_u_b },
+    { "min.u.d", test_msa_min_u_d },
+    { "min.u.h", test_msa_min_u_h },
+    { "min.u.w", test_msa_min_u_w },
+};
+
+int main(void)
+{
+    unsigned i;
+
+    TAP_START();
+    for (i = 0; i < sizeof(msa_tests) / sizeof(msa_tests[0]); i++) {
+        tap_report(!msa_tests[i].fn(), "MSA %s %s",
+                   "Int Max Min", msa_tests[i].name);
+    }
+
+    return tap_done();
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index 2d2dc60789b9..c10d4e7342f4 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -12,6 +12,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_int_compare.c',
   '../mips/test_msa_int_div_mod.c',
   '../mips/test_msa_int_dot_product.c',
+  '../mips/test_msa_int_max_min.c',
 ]
 
 tests += tcg_tests['multiarch-linux-user']['tests']
@@ -136,28 +137,4 @@ tests_mips_msa = [
   '../mips/user/ase/msa/logic/test_msa_and_v.c',
   '../mips/user/ase/msa/logic/test_msa_xor_v.c',
   '../mips/user/ase/msa/move/test_msa_move_v.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_u_h.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_a_b.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_s_b.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_a_w.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_s_w.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_s_h.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_u_h.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_a_b.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_a_d.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_u_d.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_u_d.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_u_b.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_s_d.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_a_d.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_a_h.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_a_w.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_s_d.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_u_b.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_s_w.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_a_h.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_s_h.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_s_b.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_min_u_w.c',
-  '../mips/user/ase/msa/int-max-min/test_msa_max_u_w.c',
 ]
-- 
2.55.0


