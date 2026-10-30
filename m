Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FE7606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RfIu878V;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Bp8//idh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMoB4-0004iM-OV; Fri, 30 Oct 2026 11:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMoB0-0004Om-6J
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:05:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMoAx-0007XG-RD
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:05:53 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERJiY4103327
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:05:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +nJ/ws5iV8Ga8bFgf7MgwTH3F19Tbwf4zQnp6oX1Dwg=; b=RfIu878VjQ2AjZCv
 xAkJ1y91Y3O5SACIE5+Y4usWAJYlNs0FLiZApsSG4+0ox3CA/zdf9+qT8cMzGloE
 SK3v99LMwdNvtd20hfHcdUpagy/aKRRMk5ZXObvi8iBAzpestyiltnJR5RQVrWKu
 YLp98xWzuOvQMu8uRQ/L3hcfq8am7ZUKGC3tvLbuIc4cRjVgTqBDjex0M8NKWfbv
 6F/nmDYZ95xkLGpVV4yOeJZVaON7SDbdcH5+IWbRP47EFZCAoH6Z37pX5oKxzkcp
 KB7s6TGm8SpAe/Ho5T/pwhbdtXarporDecldiCkVius2AuR+4VQBvyYx5FngejG/
 LTP+FA==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qkn7a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:05:50 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-99077a0be0bso172506241.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793372750; x=1793977550; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+nJ/ws5iV8Ga8bFgf7MgwTH3F19Tbwf4zQnp6oX1Dwg=;
 b=Bp8//idhaw9p3SGh3LzaVqR/ofI05vL621A8GHP7UzRJZREofrCK1FEXDcI+dXAgZb
 RsaiZvTj87XOlo7uyUtrJw2fuUUZ9dx+fU74PnJ4AZlH9Asc7IYshrV9lvFvkBpiM78A
 2v/TF4Cbi415G94ejHq4jjs2zh+hZ/pFsXFWr7ozHT2ZdTD7Rv32EdJh/Nun2hKrcEzg
 npWDv+LBaeNbUxbGQ+NUjoYsiC+wfUvlyvqCA49HbU30TFi+VQHWITr+2Z6NsOkGHc2v
 UYGcWEsfx+VRGwQm1QLeO7cOPaSTBRfFu2sAWwKhYJdllsKS0YquG1aqaqJN8aGKX6bd
 E5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793372750; x=1793977550;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+nJ/ws5iV8Ga8bFgf7MgwTH3F19Tbwf4zQnp6oX1Dwg=;
 b=WFCtPBxKZtGt660aDQjYr3ELMu8emExQYqNfXacsWCkIYEzvQilJ2jC5DiuY0YRoVG
 fiMsNDUDSVmeF970LIc2TYMFE+D7C01zgMStO4BtkqZXxe0Fg5SbkjIiO2hrqz75JkgJ
 KJvrU0JeexBkh2JWv7I+bse3q1j1C3Aw3ge918uaRNR+aSNbVc0eEoEr25CJhtd7k1cJ
 dRrn1uzd8Qsl//iSOZ07RwMAOFzMDOC5huhPJscjqeqyuAYoeb+b1Lmg3e480h7qeGx8
 0ZygZ/emWWHI/jGvlp6sLO0wPYAp4ZaAOQuoatAiYsemvSoit2Uq+rgAJP9C3BHQWCaE
 OLRw==
X-Gm-Message-State: AFq9FYL3BTs+O8RgoAB4SlsWo70GQHN5frmneLR/U332lgCL5Qhrvir3
 LUJFCacHw0fi/U+k2ZVNcKhLtnQZ+6Xe5xsGAbCQaLaA0LJXioPw4M3ry9OnLlhHx7X/HT8BXD4
 D54qV5q1v/eqmn5oUcNsS58K3UimTSBTs6qxQoaR5lbMwjls87mRb4aq65nzop98D/79o
X-Gm-Gg: AYBFou3tUZP6iUw7ZjlIMOZZV47tJ3LdchUC2dQf31VmZ2Igq5dDrhMyy0hPrY0B7DZ
 pZTVgEl9zZEoSvnmI59qkhE1Mn5hAAamtVk4h+2fvRiHS2n4WUJrJOPaEY/BBC1+3E1cD/gmFnk
 RslZv23lMzTzXQf20RxxcHmjALQguqC1UVZ1awJjNrlvT05xP30VzqzckMuKcRBjQKXJ+/9kXtG
 LC8U2HYoV7n1p6D3M9UhdWH5Pdl/GXfOrnKaL8cPMYwJ7yLmyIiIjc2mUYTBI7ZdAvmdBFhZyqE
 /jbS/FhHtm0MgWNg2KvMwbQIsatc9qX05wBiJx62/qRzW3o3aKVhzyiOcVWo6NX8vOVZA0KbdR2
 UfZo8PZQcbLzA3x6+as7iwQj5cGOLTsgrsLeCudRHYN3d0TGPtNnFkrYXfhgSoNEYwc0earDhnj
 k/YHm1wNfh2ypIOqNxSnZEtQhBLRcrNA==
X-Received: by 2002:a05:6122:1d8b:b0:5ea:bda1:76a0 with SMTP id
 71dfb90a1353d-5ec68718048mr1375671e0c.7.1793372749635; 
 Fri, 30 Oct 2026 08:05:49 -0700 (PDT)
X-Received: by 2002:a05:6122:1d8b:b0:5ea:bda1:76a0 with SMTP id
 71dfb90a1353d-5ec68718048mr1375519e0c.7.1793372748378; 
 Fri, 30 Oct 2026 08:05:48 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d425sm3883161f8f.1.2026.10.30.08.05.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 08:05:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 26/31] tests/tcg/mips: Group MSA int-subtract tests
Date: Fri, 30 Oct 2026 16:01:56 +0100
Message-ID: <20261030150202.61556-27-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030150202.61556-1-philmd@oss.qualcomm.com>
References: <20261030150202.61556-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2MCBTYWx0ZWRfX5jxrhCRQlVhH
 4TguQCA7P+gfwJtWLlRThcIIOoikQ1+Rvl8AUPbd/yakEf+gmvaW0plMRqqYdjUCxni84afP363
 3WmcDWeIW5nuAJZQDQfhz/Lw/SuTJFz7Q6gNIqIy/3ACm80QrRQmg9NFOt3hwuo6XKea5cEcB03
 sISXwhgYGkWG0LKyGvmpb9eYYKBNydezncZMPTU6McxuoUsblHFaSPX1nUQd4134yLdPo7tJCMY
 A4tjlJY+d5zikrp6s1o0MEoxrySgcYBuO0skjh8ORqUL6wDT1fKeNPQ5KlqQoixlWinVbuPzWBE
 fnfZd5eY2BXKgoJUmUOtz49fjHn7BkYNg9k0uV4p32I2wXjw+ibPw7iJwQ1VQs2Pp5jwgRrTR9g
 ZXUDwZvV7ZHIyKMoW5sLSScX9EKLTDCvS2WVXGU+ST44+OEasSqZQOEAbXSpiamXEngSsjFGfoa
 3TcOkq86bkGmCP3CseQ==
X-Proofpoint-ORIG-GUID: xtPsXrbdFpdERnoIbr2vb6YPRQzeAJGU
X-Authority-Analysis: v=2.4 cv=IeoSymqa c=1 sm=1 tr=0 ts=6ae4b24e cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=TrVlaqBlz6Hw94NMQc4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2MCBTYWx0ZWRfX7a3ETwAEiwYZ
 RHjV3em5vmc/6x/6SxFCJCZi+3RoXC/qAFXeIIrO0+wBj7VyWIwQTjvYjdeGaB1Zlfk51pSzrvY
 3+zvyw2pRY88TbRMORy3PmgLFfR4bMU=
X-Proofpoint-GUID: xtPsXrbdFpdERnoIbr2vb6YPRQzeAJGU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300060
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


