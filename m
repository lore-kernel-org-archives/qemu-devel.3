Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B7060A261F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Q3pmzxuT;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hB5ZWT6D
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqte-00039D-JI; Fri, 30 Oct 2026 14:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqrP-0000FJ-VN
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:57:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqrM-0008LP-GB
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:57:50 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UHu4SW839527
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +nJ/ws5iV8Ga8bFgf7MgwTH3F19Tbwf4zQnp6oX1Dwg=; b=Q3pmzxuTkgm7g6Nb
 AB4pLLGqwxU7eVfxmYD9A22hpLekenJsOQjbZR8Y4F3qk/rYn4cHI1MIOwZmtoid
 hLJnQWRhXa9x3tCg4W2uzl4wCcGyJAvf0g4fv7m6aEg0HY2RFsJ8FLOrGDbpib/c
 CJ+6RXdmPDrimLTrxqowAegmfpKxcv4fC6zqHl3tXxWZAOVgovLuGi/o+4MOwMeT
 dcWrctemdMnNmG4xO2vJnz80fGNcaeFAl/FrKwnNW4RVSVG7bZBskK3oewWv2v8O
 BUrhha10oFOByKFxm7EFA0iDZawhkKSGrvniJVSbqBa9mtTcb0CJK3x3GovWr/p6
 ORNtVg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme754ad8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:57:46 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93909014c85so204534285a.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793383066; x=1793987866; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+nJ/ws5iV8Ga8bFgf7MgwTH3F19Tbwf4zQnp6oX1Dwg=;
 b=hB5ZWT6DVkYBDhGTG+3Xw53NdCe7PpcMMSTv52NO1FoQA7gV3yNjtJocHVQTN0coGg
 Zbd/Skde12ojW0D2f4XY+7FiYn/E0qJiSWf/9C4mevrjF8t65R1u/w25ObogyHD2pI32
 xo9iwwWgfL4A/uxqopxQqtvVz4Xwg76AWQ3ep/UGc/WrjBY7iTMoBECilXTzEHqlkYZc
 iFH9ildQW/HGZCMyc/usf+4Xy6zTVsu/pulLtDC3L+KaIpbADatn0gM1kQ/xWSTFTCVm
 c+43b/5J6o++O1pRPWa/z9aTldvnkApFnmPWCDstYEvcwDC9ZBcn8f0I30KCQk0xOe5I
 JcUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793383066; x=1793987866;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+nJ/ws5iV8Ga8bFgf7MgwTH3F19Tbwf4zQnp6oX1Dwg=;
 b=eadouvWTBJqTRw9m78RNfi5wRYcRTNSQ26BShoNViR+YZD+nITOvpmWmxJWYZpl/WI
 1dtRe2/SLpoZ3xQvctRkZ9jTlpeQXlz4I2eSlZfuQMxz7kyfPrVd1IW3J5eARhRuleYE
 YBHDLWaHcMBxAWD87U1drwjWMV2tYfUbdfPnD6TStLSqAghGzd7pbPaqMdF5y/PFnCJO
 493xmN1HZAd+ppe0Ah8S+9PC+T2mA/BztG02eIX+FRXpiou80XePP6Lf9DVoxPYopRXU
 lIaWrYJOp15cptbMX0NfJCEnOgyLk6oiyTUVxjeIzC9Z6hHKKIHkFuuh7seLUl3M6/Fw
 5Lkg==
X-Gm-Message-State: AFq9FYKd9pio4QdAbr9MfvyZ2Mh8n/Vk8kL1Mn1DKMe2SYaQ/LfrqMNl
 0IcmpEAIOd9ljK+kjef0lAtoATa+GhRyiFgHZW1fwtYyjcu3J3Svz59g4h8FzzKwE8N3dDIse4g
 +dyAA145nU1C3EqrE3bflttmc1+1Ya4qnrdN1PGIURM5z+eN+pignmRTpgzUjlCMsr0mI
X-Gm-Gg: AYBFou0j4Nlh8dfkm4nCGX/KZPOioKfyiUwWBawALKPxhQITrlrK/aC2jjuuESW7sBb
 0rtVq0deLZzMYudE1bDQuGUOmeEG4uUE7NYn+sHzp9/nMLxlYUXWYKOoauOM5tXSA9IWQHHjbHB
 jsBh1XSQskcAh+xJJMrR50DOf8dN/iDCYYDDT68qqHZipRoUvRTE3FEm5M99+8WN5u34ygQ6GzJ
 5KQ1A38wpDxeqj5mhCha0vwxyb2Pu7KOsVlsiYIOrSNCMbJ3celMpTngc3BlOpFDhHwnewqLnQN
 gLaqUwJn7pOUqK+oQolhCXN/26Yr8KNJzhmoldBJ+4YiJjTYwRZ4XHOkoR56LFoxqIXu0f8ni8a
 o82Jj95PiG2VAnCTRL3H1TlGnoX3wutVvH7Nybh670ZHro1/jUgXeorVhAMcuSw8bOzDjWyPk5L
 Is0Trnfb4vA37X7+XRfCVAA65DsDJcIQ==
X-Received: by 2002:a05:620a:600e:b0:93e:c12c:f11e with SMTP id
 af79cd13be357-9442184f3demr511409685a.74.1793383065593; 
 Fri, 30 Oct 2026 10:57:45 -0700 (PDT)
X-Received: by 2002:a05:620a:600e:b0:93e:c12c:f11e with SMTP id
 af79cd13be357-9442184f3demr511406485a.74.1793383065151; 
 Fri, 30 Oct 2026 10:57:45 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abebe33e79sm56214865e9.2.2026.10.30.10.57.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 10:57:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4 27/32] tests/tcg/mips: Group MSA int-subtract tests
Date: Fri, 30 Oct 2026 18:53:49 +0100
Message-ID: <20261030175357.99684-28-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030175357.99684-1-philmd@oss.qualcomm.com>
References: <20261030175357.99684-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: jd8ZJ6DVSGOHp0oOOX5XlKjKtWGufB3A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX/qmuNI62MDH1
 Ih08kNGBMY18c09ZPyPE48GzrdAvacUDF871LVQDg57u5KjnK0xoARsQLKl+sNlWXgdSuXOYAIR
 hoBOzJtHyo68juWQkIYX8vXqRwCH3aY/oFClEM25ACygJHY11gLNStN0ujpUvlDDYHNeoGGJEmc
 xPiC+WfY36hfHMFE2OFyHmHnlBCfjJAtE8uCNbDwFzd4tVQyANqFRr/KOQoh2NPkCaXqzztM1fj
 O3ES3HeCnL6GbObaRhVKrQ0eRavDKTNlzQLSgjz7I8JDyLhmVsGhlrjdTfRSXiGry3OiHD4ik1N
 z5Nojj0zMUcdDqJz+anl8NrUbm4uWDCfR5Yvw3gbh9Gs0s5Xz46RK6F6bmq2zhKlfZyRAnQaUCC
 M2dn0JaJ27sN7AxXqrDbzBlHr7u3dOvybaZBsytMUnDM+3AV4UlCp4Bvl2CkMfhTYpkyHRMkmRe
 cEi4R7nkbPEvAYVFtQg==
X-Proofpoint-ORIG-GUID: jd8ZJ6DVSGOHp0oOOX5XlKjKtWGufB3A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX2cVDYKz6tvHY
 TO4Y0Hn5Q1VXPffCwvZizXsU3PIeBrTLeJmf0/OhXzW1aAxdI+vxM1kDYrhDZ5t0WxaIMxrFpaL
 qutaSOm7YNlnESOmwORS9nJKdlf0AJk=
X-Authority-Analysis: v=2.4 cv=KdtHIgYD c=1 sm=1 tr=0 ts=6ae4da9a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=TrVlaqBlz6Hw94NMQc4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
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

Build the 34 per-opcode int-subtract tests as a single executable,
test_msa_int_subtract.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_int_subtract.c | 231 +++++++++++++++++++++++++
 tests/tcg/mips/meson.build             |  35 +---
 2 files changed, 232 insertions(+), 34 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_int_subtract.c

diff --git a/tests/tcg/mips/test_msa_int_subtract.c b/tests/tcg/mips/test_msa_int_subtract.c
new file mode 100644
index 000000000000..84efc16ac463
--- /dev/null
+++ b/tests/tcg/mips/test_msa_int_subtract.c
@@ -0,0 +1,231 @@
+/*
+ * MIPS MSA tests: Int Subtract instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "../include/tap.h"
+
+#define main test_msa_asub_s_b
+#include "user/ase/msa/int-subtract/test_msa_asub_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_asub_s_d
+#include "user/ase/msa/int-subtract/test_msa_asub_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_asub_s_h
+#include "user/ase/msa/int-subtract/test_msa_asub_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_asub_s_w
+#include "user/ase/msa/int-subtract/test_msa_asub_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_asub_u_b
+#include "user/ase/msa/int-subtract/test_msa_asub_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_asub_u_d
+#include "user/ase/msa/int-subtract/test_msa_asub_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_asub_u_h
+#include "user/ase/msa/int-subtract/test_msa_asub_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_asub_u_w
+#include "user/ase/msa/int-subtract/test_msa_asub_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_hsub_s_d
+#include "user/ase/msa/int-subtract/test_msa_hsub_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_hsub_s_h
+#include "user/ase/msa/int-subtract/test_msa_hsub_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_hsub_s_w
+#include "user/ase/msa/int-subtract/test_msa_hsub_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_hsub_u_d
+#include "user/ase/msa/int-subtract/test_msa_hsub_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_hsub_u_h
+#include "user/ase/msa/int-subtract/test_msa_hsub_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_hsub_u_w
+#include "user/ase/msa/int-subtract/test_msa_hsub_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subs_s_b
+#include "user/ase/msa/int-subtract/test_msa_subs_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subs_s_d
+#include "user/ase/msa/int-subtract/test_msa_subs_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subs_s_h
+#include "user/ase/msa/int-subtract/test_msa_subs_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subs_s_w
+#include "user/ase/msa/int-subtract/test_msa_subs_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subs_u_b
+#include "user/ase/msa/int-subtract/test_msa_subs_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subs_u_d
+#include "user/ase/msa/int-subtract/test_msa_subs_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subs_u_h
+#include "user/ase/msa/int-subtract/test_msa_subs_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subs_u_w
+#include "user/ase/msa/int-subtract/test_msa_subs_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subsus_u_b
+#include "user/ase/msa/int-subtract/test_msa_subsus_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subsus_u_d
+#include "user/ase/msa/int-subtract/test_msa_subsus_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subsus_u_h
+#include "user/ase/msa/int-subtract/test_msa_subsus_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subsus_u_w
+#include "user/ase/msa/int-subtract/test_msa_subsus_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subsuu_s_b
+#include "user/ase/msa/int-subtract/test_msa_subsuu_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subsuu_s_d
+#include "user/ase/msa/int-subtract/test_msa_subsuu_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subsuu_s_h
+#include "user/ase/msa/int-subtract/test_msa_subsuu_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subsuu_s_w
+#include "user/ase/msa/int-subtract/test_msa_subsuu_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subv_b
+#include "user/ase/msa/int-subtract/test_msa_subv_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subv_d
+#include "user/ase/msa/int-subtract/test_msa_subv_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subv_h
+#include "user/ase/msa/int-subtract/test_msa_subv_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subv_w
+#include "user/ase/msa/int-subtract/test_msa_subv_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} msa_tests[] = {
+    { "asub.s.b", test_msa_asub_s_b },
+    { "asub.s.d", test_msa_asub_s_d },
+    { "asub.s.h", test_msa_asub_s_h },
+    { "asub.s.w", test_msa_asub_s_w },
+    { "asub.u.b", test_msa_asub_u_b },
+    { "asub.u.d", test_msa_asub_u_d },
+    { "asub.u.h", test_msa_asub_u_h },
+    { "asub.u.w", test_msa_asub_u_w },
+    { "hsub.s.d", test_msa_hsub_s_d },
+    { "hsub.s.h", test_msa_hsub_s_h },
+    { "hsub.s.w", test_msa_hsub_s_w },
+    { "hsub.u.d", test_msa_hsub_u_d },
+    { "hsub.u.h", test_msa_hsub_u_h },
+    { "hsub.u.w", test_msa_hsub_u_w },
+    { "subs.s.b", test_msa_subs_s_b },
+    { "subs.s.d", test_msa_subs_s_d },
+    { "subs.s.h", test_msa_subs_s_h },
+    { "subs.s.w", test_msa_subs_s_w },
+    { "subs.u.b", test_msa_subs_u_b },
+    { "subs.u.d", test_msa_subs_u_d },
+    { "subs.u.h", test_msa_subs_u_h },
+    { "subs.u.w", test_msa_subs_u_w },
+    { "subsus.u.b", test_msa_subsus_u_b },
+    { "subsus.u.d", test_msa_subsus_u_d },
+    { "subsus.u.h", test_msa_subsus_u_h },
+    { "subsus.u.w", test_msa_subsus_u_w },
+    { "subsuu.s.b", test_msa_subsuu_s_b },
+    { "subsuu.s.d", test_msa_subsuu_s_d },
+    { "subsuu.s.h", test_msa_subsuu_s_h },
+    { "subsuu.s.w", test_msa_subsuu_s_w },
+    { "subv.b", test_msa_subv_b },
+    { "subv.d", test_msa_subv_d },
+    { "subv.h", test_msa_subv_h },
+    { "subv.w", test_msa_subv_w },
+};
+
+int main(void)
+{
+    unsigned i;
+
+    TAP_START();
+    for (i = 0; i < sizeof(msa_tests) / sizeof(msa_tests[0]); i++) {
+        tap_report(!msa_tests[i].fn(), "MSA %s %s",
+                   "Int Subtract", msa_tests[i].name);
+    }
+
+    return tap_done();
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index 0f4d55a2f26b..516da867cadf 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -14,6 +14,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_int_dot_product.c',
   '../mips/test_msa_int_max_min.c',
   '../mips/test_msa_int_multiply.c',
+  '../mips/test_msa_int_subtract.c',
 ]
 
 tests += tcg_tests['multiarch-linux-user']['tests']
@@ -39,40 +40,6 @@ if 'qemu-mips' in emulators
 endif
 
 tests_mips_msa = [
-  '../mips/user/ase/msa/int-subtract/test_msa_asub_s_w.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_hsub_u_d.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_hsub_s_w.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_asub_u_d.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_asub_u_b.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_asub_u_w.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subsuu_s_d.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_asub_s_d.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subsus_u_w.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subsus_u_h.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subs_s_d.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subs_u_d.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_hsub_s_d.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_asub_s_h.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subv_d.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subs_s_b.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subs_u_w.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subv_w.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subsuu_s_h.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subv_h.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_hsub_s_h.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subv_b.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subsuu_s_b.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subs_u_b.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_hsub_u_h.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subs_s_h.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subs_u_h.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_hsub_u_w.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subsus_u_b.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subsuu_s_w.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subsus_u_d.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_asub_u_h.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_asub_s_b.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subs_s_w.c',
   '../mips/user/ase/msa/interleave/test_msa_ilvr_b.c',
   '../mips/user/ase/msa/interleave/test_msa_ilvr_d.c',
   '../mips/user/ase/msa/interleave/test_msa_ilvod_b.c',
-- 
2.55.0


