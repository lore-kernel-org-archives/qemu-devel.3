Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441D9606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nk1n99uB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aQFGsXui
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMo8W-0008Ik-LY; Fri, 30 Oct 2026 11:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMo8R-00087n-9W
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:03:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMo8O-0007A2-Hg
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:03:14 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UER3xN3515272
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:03:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 T7lYUjirXa/qDfP8rUjmpxO8QVkCJ//Ah25A5XocXvk=; b=nk1n99uBlMAhd7sy
 /VYtEYcz3Qr8xxw9XIet416epwNZ/DC0olbJQkwXYB+6LnMfJ9wmbdMJEbITpu96
 2LAzHwxboHzWSIbeS0IT4jkN4cfWtjpttKLQnGiZvEj+pW7Clg8LUL+1hhbx9UfR
 HL4CXsNZkrrjVnLvkMUXLnSlyMHWGffLp+b7+IvtuTtICiYti8Ro7ko1EJI5tuuo
 ec5GTtjv7YwKOzW4hYcp1j6aZN5poGPOO/fbrjmc/Q3fMNFrUAfflUbWgpEeJaGW
 ++97p20B2wWb3J4sOwZenA+APbXb/bDiIBj1d7v5wWdB5l4GRAjLUZH13/eJypw+
 2F8z3Q==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qkp6v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:03:11 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-990aa76e3daso236158241.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793372590; x=1793977390; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T7lYUjirXa/qDfP8rUjmpxO8QVkCJ//Ah25A5XocXvk=;
 b=aQFGsXuiYmcgVXeK5Ps6Gf82wfktpdX1S5wLn1tNY8SLZ2mOGCf6FgakgKLJTac2qI
 Tv9yizWOHbEG6Uei9LcthArTdffy6jFpe10GM4GRzjKzvUWS7Zlt2b1L/yOOV4Im4z0g
 O3ekkBouk2idrl/dB2e/wY5KNYb6xSuhdib/efZH9sCWPB/dLCcHe0C5XeC2th7a+Clf
 FyQQ5IDjQ2SCH7k9kEoCYsiYEPNkFaQrNwDLW7n7qtMyf5jVjc6ktdx1QLy7c6dfPhda
 B16SyD80uGJCTrK9Ce4TJMv03ZzuW1LPox9LLOhOxYI5i4aHR++Zk3wqzm1Mq7sI77Lm
 2/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793372590; x=1793977390;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T7lYUjirXa/qDfP8rUjmpxO8QVkCJ//Ah25A5XocXvk=;
 b=az+5MmXLIlyxeK6VFVi1lTJc0Df6f4npwRt3JO2z5noqDQyN2/H+f0bychd1BxYhZJ
 t2Gk72+BRy4g1NaWHajq5X16s6oGBYfcjdU6ysHKIBu+4cB4C9x8nG7fLLb3EULAszsu
 oorAn579818viyh6SWNoO9Qu8XwConyrfJh6hWa6PNygJuT1YEKDjdoiptLRZfwoOA9J
 zrrP4+tp+jTLKeLKXn9JCrwhEG733h0iRai5NA3ivbH1v6Z4H53WU0GnPlSIo6br1XN1
 OQ/goNSZAOYRYGErveJwzXV48JZNjy25rGNeocVimM4A/UNeQUpyIc5QMqPIbNIj8XXN
 tM8Q==
X-Gm-Message-State: AFq9FYI8CfVryc8ojyvwyt13UDaYCNtYJQWE29UceGlTxFOP1RRsvxqD
 6B0Z1kg+ucfBMZThGZJS2o9CzVjK/f8ELnSnIvUWa7Ne8lD/Ku1z06mywX6DFs7/a7znPHPc8VV
 +vW51sW0d/e3Yqrpz/QCFF98RZka/+D+9Rv8HjreqUdQRL6ZFHpkIp30FfCNfRTpm9t2/
X-Gm-Gg: AYBFou1GL/H2qlh8MAteiPnAe5wfNS1F6oGA09GIv6gWM6utzRUC+pEzSXtKV5D2eyl
 G6OpTYzLg/gIfdoY7WUPSstPXuG8MYX17lXE4jWL7QV/4PUZPiWknRmaX+ppJ40YH38eLgHfTNj
 xMRpA6PJYrg0btisLB2CGw/gh6OJLLbHbaiUVZxBIQdji+tejfinD9S2YdkF1BE/aEKt+r9TGS3
 XnV9jcgMnSltWHrw31iyBBj3G5wdyDY/o6jvB2L7plMVriyHjfhI4bPuB1QE2XO/qJddXtvz0qB
 wnFmB2UNXpk50G8AUDCfFrFToh/vdRaLRUEYBkPW38l7s7O3X0Qmy29tLoLmO9CSUcGYdwm/mCP
 xNcAA/PEaUVY9/S3k78ICJ89kxNhAIzWyjvn/S8F775lMDFgaMJO7tLKQsx6guObT8Rr52e7WnI
 53QuRkUUkwyGyGYnVs+j2dLGWFUUmM/Q==
X-Received: by 2002:a05:6102:f11:b0:7cc:1192:563c with SMTP id
 ada2fe7eead31-7d072ca43e3mr1219429137.25.1793372589660; 
 Fri, 30 Oct 2026 08:03:09 -0700 (PDT)
X-Received: by 2002:a05:6102:f11:b0:7cc:1192:563c with SMTP id
 ada2fe7eead31-7d072ca43e3mr1219341137.25.1793372588637; 
 Fri, 30 Oct 2026 08:03:08 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abeb77c132sm47179395e9.1.2026.10.30.08.03.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 08:03:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 07/31] tests/tcg/mips: Group DSP pack tests
Date: Fri, 30 Oct 2026 16:01:37 +0100
Message-ID: <20261030150202.61556-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030150202.61556-1-philmd@oss.qualcomm.com>
References: <20261030150202.61556-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: GT_KdvLMVgg9F-R4HabAFSTVYs_BkpbT
X-Authority-Analysis: v=2.4 cv=KLzPn1Fo c=1 sm=1 tr=0 ts=6ae4b1af cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=wx96bOdwd-L99dZWacAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfXyenJ1bbdXok6
 /Sg4V2NUByixvTJoFlMTKiaSnx5fnkV8Uyi4B2chGJShIEkgXgwKpG9KdyS6JMkIyeMVRH7phJU
 cPCKUi5H3oxF2v0zJSXaaC7ROaq8P4T2CI2wQsVimQEdoV1vxlLusq2kiLr0gv4vDPz/ELoGpJ1
 gqeIapI1qtEpgflfZg4nBFG1oYXOCu0D0szu8VUNFjRnjv9qRXRGxKyoEkQu/pSy3IQjNM55PXm
 Au0cLrFkx2UmnWGQFJs6aqG05rltqHBqeekNk7Llw0hj+Vd+T+A9N7coNj3rvlpZvdKtxTaB5Qa
 RBxTi6B5TTzOvelkdXjdyQxJUtxqfgWtzUF0BBeufCg1N5wqttZQ5b88Lhupuyl+Mct1Qrl0jik
 Qk7AL8bozl8JmAgnuJRAMCqaqLi50vbdfnYBbYF2tfwEP6aYlhuXXd27XUY6pLvdprjJ9l5oJTe
 keevR1blcJrqe2N0qyQ==
X-Proofpoint-ORIG-GUID: GT_KdvLMVgg9F-R4HabAFSTVYs_BkpbT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfXwNW8fivHi+km
 v5610psbnI+5AVuIXCfspfNl/k6gQCwMZ97andsrfSCCRulPBmiU4hF24thR0529LCb2k2Rv1w3
 1hxlM5XdaBB3/GSiptD55LZSX4JQssc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300059
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

Build the 27 per-opcode pack tests as a single executable,
test_dsp_pack.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mipsel/test_dsp_pack.c              | 148 ++++++++++++++++++
 tests/tcg/mipsel/test_dsp_r1_bitrev.c         |   1 -
 tests/tcg/mipsel/test_dsp_r1_insv.c           |   1 -
 tests/tcg/mipsel/test_dsp_r1_packrl_ph.c      |   1 -
 tests/tcg/mipsel/test_dsp_r1_preceq_w_phl.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_preceq_w_phr.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbl.c |   1 -
 .../tcg/mipsel/test_dsp_r1_precequ_ph_qbla.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbr.c |   1 -
 .../tcg/mipsel/test_dsp_r1_precequ_ph_qbra.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbl.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbla.c |   1 -
 tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbr.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbra.c |   1 -
 tests/tcg/mipsel/test_dsp_r1_precrq_ph_w.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_precrq_qb_ph.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_precrq_rs_ph_w.c |   1 -
 .../tcg/mipsel/test_dsp_r1_precrqu_s_qb_ph.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_repl_ph.c        |   1 -
 tests/tcg/mipsel/test_dsp_r1_repl_qb.c        |   1 -
 tests/tcg/mipsel/test_dsp_r1_replv_ph.c       |   1 -
 tests/tcg/mipsel/test_dsp_r1_replv_qb.c       |   1 -
 tests/tcg/mipsel/test_dsp_r2_append.c         |   1 -
 tests/tcg/mipsel/test_dsp_r2_balign.c         |   1 -
 tests/tcg/mipsel/test_dsp_r2_precr_qb_ph.c    |   1 -
 tests/tcg/mipsel/test_dsp_r2_precr_sra_ph_w.c |   1 -
 .../tcg/mipsel/test_dsp_r2_precr_sra_r_ph_w.c |   1 -
 tests/tcg/mipsel/test_dsp_r2_prepend.c        |   1 -
 tests/tcg/mipsel/meson.build                  |  28 +---
 29 files changed, 149 insertions(+), 54 deletions(-)
 create mode 100644 tests/tcg/mipsel/test_dsp_pack.c

diff --git a/tests/tcg/mipsel/test_dsp_pack.c b/tests/tcg/mipsel/test_dsp_pack.c
new file mode 100644
index 000000000000..7ae3b41ff55e
--- /dev/null
+++ b/tests/tcg/mipsel/test_dsp_pack.c
@@ -0,0 +1,148 @@
+/*
+ * MIPS DSP ASE tests: Precision, Pack, Replicate and bit Insert instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "test_dsp_runner.h"
+
+#define main test_dsp_r1_bitrev
+#include "test_dsp_r1_bitrev.c"
+#undef main
+
+#define main test_dsp_r1_insv
+#include "test_dsp_r1_insv.c"
+#undef main
+
+#define main test_dsp_r1_packrl_ph
+#include "test_dsp_r1_packrl_ph.c"
+#undef main
+
+#define main test_dsp_r1_preceq_w_phl
+#include "test_dsp_r1_preceq_w_phl.c"
+#undef main
+
+#define main test_dsp_r1_preceq_w_phr
+#include "test_dsp_r1_preceq_w_phr.c"
+#undef main
+
+#define main test_dsp_r1_precequ_ph_qbl
+#include "test_dsp_r1_precequ_ph_qbl.c"
+#undef main
+
+#define main test_dsp_r1_precequ_ph_qbla
+#include "test_dsp_r1_precequ_ph_qbla.c"
+#undef main
+
+#define main test_dsp_r1_precequ_ph_qbr
+#include "test_dsp_r1_precequ_ph_qbr.c"
+#undef main
+
+#define main test_dsp_r1_precequ_ph_qbra
+#include "test_dsp_r1_precequ_ph_qbra.c"
+#undef main
+
+#define main test_dsp_r1_preceu_ph_qbl
+#include "test_dsp_r1_preceu_ph_qbl.c"
+#undef main
+
+#define main test_dsp_r1_preceu_ph_qbla
+#include "test_dsp_r1_preceu_ph_qbla.c"
+#undef main
+
+#define main test_dsp_r1_preceu_ph_qbr
+#include "test_dsp_r1_preceu_ph_qbr.c"
+#undef main
+
+#define main test_dsp_r1_preceu_ph_qbra
+#include "test_dsp_r1_preceu_ph_qbra.c"
+#undef main
+
+#define main test_dsp_r1_precrq_ph_w
+#include "test_dsp_r1_precrq_ph_w.c"
+#undef main
+
+#define main test_dsp_r1_precrq_qb_ph
+#include "test_dsp_r1_precrq_qb_ph.c"
+#undef main
+
+#define main test_dsp_r1_precrq_rs_ph_w
+#include "test_dsp_r1_precrq_rs_ph_w.c"
+#undef main
+
+#define main test_dsp_r1_precrqu_s_qb_ph
+#include "test_dsp_r1_precrqu_s_qb_ph.c"
+#undef main
+
+#define main test_dsp_r1_repl_ph
+#include "test_dsp_r1_repl_ph.c"
+#undef main
+
+#define main test_dsp_r1_repl_qb
+#include "test_dsp_r1_repl_qb.c"
+#undef main
+
+#define main test_dsp_r1_replv_ph
+#include "test_dsp_r1_replv_ph.c"
+#undef main
+
+#define main test_dsp_r1_replv_qb
+#include "test_dsp_r1_replv_qb.c"
+#undef main
+
+#define main test_dsp_r2_append
+#include "test_dsp_r2_append.c"
+#undef main
+
+#define main test_dsp_r2_balign
+#include "test_dsp_r2_balign.c"
+#undef main
+
+#define main test_dsp_r2_precr_qb_ph
+#include "test_dsp_r2_precr_qb_ph.c"
+#undef main
+
+#define main test_dsp_r2_precr_sra_ph_w
+#include "test_dsp_r2_precr_sra_ph_w.c"
+#undef main
+
+#define main test_dsp_r2_precr_sra_r_ph_w
+#include "test_dsp_r2_precr_sra_r_ph_w.c"
+#undef main
+
+#define main test_dsp_r2_prepend
+#include "test_dsp_r2_prepend.c"
+#undef main
+
+int main(void)
+{
+    RUN_TEST(test_dsp_r1_bitrev);
+    RUN_TEST(test_dsp_r1_insv);
+    RUN_TEST(test_dsp_r1_packrl_ph);
+    RUN_TEST(test_dsp_r1_preceq_w_phl);
+    RUN_TEST(test_dsp_r1_preceq_w_phr);
+    RUN_TEST(test_dsp_r1_precequ_ph_qbl);
+    RUN_TEST(test_dsp_r1_precequ_ph_qbla);
+    RUN_TEST(test_dsp_r1_precequ_ph_qbr);
+    RUN_TEST(test_dsp_r1_precequ_ph_qbra);
+    RUN_TEST(test_dsp_r1_preceu_ph_qbl);
+    RUN_TEST(test_dsp_r1_preceu_ph_qbla);
+    RUN_TEST(test_dsp_r1_preceu_ph_qbr);
+    RUN_TEST(test_dsp_r1_preceu_ph_qbra);
+    RUN_TEST(test_dsp_r1_precrq_ph_w);
+    RUN_TEST(test_dsp_r1_precrq_qb_ph);
+    RUN_TEST(test_dsp_r1_precrq_rs_ph_w);
+    RUN_TEST(test_dsp_r1_precrqu_s_qb_ph);
+    RUN_TEST(test_dsp_r1_repl_ph);
+    RUN_TEST(test_dsp_r1_repl_qb);
+    RUN_TEST(test_dsp_r1_replv_ph);
+    RUN_TEST(test_dsp_r1_replv_qb);
+    RUN_TEST(test_dsp_r2_append);
+    RUN_TEST(test_dsp_r2_balign);
+    RUN_TEST(test_dsp_r2_precr_qb_ph);
+    RUN_TEST(test_dsp_r2_precr_sra_ph_w);
+    RUN_TEST(test_dsp_r2_precr_sra_r_ph_w);
+    RUN_TEST(test_dsp_r2_prepend);
+
+    return tap_done();
+}
diff --git a/tests/tcg/mipsel/test_dsp_r1_bitrev.c b/tests/tcg/mipsel/test_dsp_r1_bitrev.c
index 04d8a3844eb8..08b49aff8353 100644
--- a/tests/tcg/mipsel/test_dsp_r1_bitrev.c
+++ b/tests/tcg/mipsel/test_dsp_r1_bitrev.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_insv.c b/tests/tcg/mipsel/test_dsp_r1_insv.c
index 9d674697ccaa..58e1404b36ec 100644
--- a/tests/tcg/mipsel/test_dsp_r1_insv.c
+++ b/tests/tcg/mipsel/test_dsp_r1_insv.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_packrl_ph.c b/tests/tcg/mipsel/test_dsp_r1_packrl_ph.c
index 1f8e69992503..32fdb27fa5cd 100644
--- a/tests/tcg/mipsel/test_dsp_r1_packrl_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_packrl_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_preceq_w_phl.c b/tests/tcg/mipsel/test_dsp_r1_preceq_w_phl.c
index bf70bf7d3aec..2d03bb8615e9 100644
--- a/tests/tcg/mipsel/test_dsp_r1_preceq_w_phl.c
+++ b/tests/tcg/mipsel/test_dsp_r1_preceq_w_phl.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_preceq_w_phr.c b/tests/tcg/mipsel/test_dsp_r1_preceq_w_phr.c
index 3f885ef584e6..75a68d75e079 100644
--- a/tests/tcg/mipsel/test_dsp_r1_preceq_w_phr.c
+++ b/tests/tcg/mipsel/test_dsp_r1_preceq_w_phr.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbl.c b/tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbl.c
index 63b7a9568345..644799d16671 100644
--- a/tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbl.c
+++ b/tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbl.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbla.c b/tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbla.c
index 31627f0bd606..8825e696f39e 100644
--- a/tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbla.c
+++ b/tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbla.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbr.c b/tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbr.c
index b6f72d3cbfde..fda12bb5e591 100644
--- a/tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbr.c
+++ b/tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbr.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbra.c b/tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbra.c
index 4764fd031d8a..98cef45cc865 100644
--- a/tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbra.c
+++ b/tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbra.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbl.c b/tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbl.c
index fa95c26cc48f..f5a2b9ec9a6f 100644
--- a/tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbl.c
+++ b/tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbl.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbla.c b/tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbla.c
index 021f21a74440..9eb9800b2323 100644
--- a/tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbla.c
+++ b/tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbla.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbr.c b/tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbr.c
index 03df18c72ca5..81d470de2347 100644
--- a/tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbr.c
+++ b/tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbr.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbra.c b/tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbra.c
index 634327618cce..1698ff2c837a 100644
--- a/tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbra.c
+++ b/tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbra.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_precrq_ph_w.c b/tests/tcg/mipsel/test_dsp_r1_precrq_ph_w.c
index 25d45f1a9aa8..1f04c644c44a 100644
--- a/tests/tcg/mipsel/test_dsp_r1_precrq_ph_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_precrq_ph_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_precrq_qb_ph.c b/tests/tcg/mipsel/test_dsp_r1_precrq_qb_ph.c
index fe23acce8c47..e5512cd82106 100644
--- a/tests/tcg/mipsel/test_dsp_r1_precrq_qb_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_precrq_qb_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_precrq_rs_ph_w.c b/tests/tcg/mipsel/test_dsp_r1_precrq_rs_ph_w.c
index da6845bf2423..807f33c7ad73 100644
--- a/tests/tcg/mipsel/test_dsp_r1_precrq_rs_ph_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_precrq_rs_ph_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_precrqu_s_qb_ph.c b/tests/tcg/mipsel/test_dsp_r1_precrqu_s_qb_ph.c
index 7481d5af3a5b..a24b066056d5 100644
--- a/tests/tcg/mipsel/test_dsp_r1_precrqu_s_qb_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_precrqu_s_qb_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_repl_ph.c b/tests/tcg/mipsel/test_dsp_r1_repl_ph.c
index 21074953bdde..13375231b54b 100644
--- a/tests/tcg/mipsel/test_dsp_r1_repl_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_repl_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_repl_qb.c b/tests/tcg/mipsel/test_dsp_r1_repl_qb.c
index 6631393ea131..2e65fb715485 100644
--- a/tests/tcg/mipsel/test_dsp_r1_repl_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_repl_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_replv_ph.c b/tests/tcg/mipsel/test_dsp_r1_replv_ph.c
index 07fb15f1f795..64a5c1b334f5 100644
--- a/tests/tcg/mipsel/test_dsp_r1_replv_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_replv_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_replv_qb.c b/tests/tcg/mipsel/test_dsp_r1_replv_qb.c
index dd1271fedff0..5aecf82f50a5 100644
--- a/tests/tcg/mipsel/test_dsp_r1_replv_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_replv_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_append.c b/tests/tcg/mipsel/test_dsp_r2_append.c
index 9a91e1650dbd..62cf0e76a196 100644
--- a/tests/tcg/mipsel/test_dsp_r2_append.c
+++ b/tests/tcg/mipsel/test_dsp_r2_append.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_balign.c b/tests/tcg/mipsel/test_dsp_r2_balign.c
index 537cf0451cc8..62cc0359e21b 100644
--- a/tests/tcg/mipsel/test_dsp_r2_balign.c
+++ b/tests/tcg/mipsel/test_dsp_r2_balign.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_precr_qb_ph.c b/tests/tcg/mipsel/test_dsp_r2_precr_qb_ph.c
index 3a2b3fde0573..dce58816c815 100644
--- a/tests/tcg/mipsel/test_dsp_r2_precr_qb_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_precr_qb_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_precr_sra_ph_w.c b/tests/tcg/mipsel/test_dsp_r2_precr_sra_ph_w.c
index 5c9baab03d00..9e65e7d2575b 100644
--- a/tests/tcg/mipsel/test_dsp_r2_precr_sra_ph_w.c
+++ b/tests/tcg/mipsel/test_dsp_r2_precr_sra_ph_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_precr_sra_r_ph_w.c b/tests/tcg/mipsel/test_dsp_r2_precr_sra_r_ph_w.c
index 6474a108c057..bb7bb97a231f 100644
--- a/tests/tcg/mipsel/test_dsp_r2_precr_sra_r_ph_w.c
+++ b/tests/tcg/mipsel/test_dsp_r2_precr_sra_r_ph_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_prepend.c b/tests/tcg/mipsel/test_dsp_r2_prepend.c
index f6bcd47b2da9..a77efa4d6208 100644
--- a/tests/tcg/mipsel/test_dsp_r2_prepend.c
+++ b/tests/tcg/mipsel/test_dsp_r2_prepend.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index 4991c14b7bf8..247db7d10d79 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -10,27 +10,7 @@ tests_dsp = [
   'test_dsp_ctrl.c',
   'test_dsp_dot.c',
   'test_dsp_mul.c',
-  'test_dsp_r1_bitrev.c',
-  'test_dsp_r1_insv.c',
-  'test_dsp_r1_packrl_ph.c',
-  'test_dsp_r1_preceq_w_phl.c',
-  'test_dsp_r1_preceq_w_phr.c',
-  'test_dsp_r1_precequ_ph_qbl.c',
-  'test_dsp_r1_precequ_ph_qbla.c',
-  'test_dsp_r1_precequ_ph_qbr.c',
-  'test_dsp_r1_precequ_ph_qbra.c',
-  'test_dsp_r1_preceu_ph_qbl.c',
-  'test_dsp_r1_preceu_ph_qbla.c',
-  'test_dsp_r1_preceu_ph_qbr.c',
-  'test_dsp_r1_preceu_ph_qbra.c',
-  'test_dsp_r1_precrq_ph_w.c',
-  'test_dsp_r1_precrq_qb_ph.c',
-  'test_dsp_r1_precrq_rs_ph_w.c',
-  'test_dsp_r1_precrqu_s_qb_ph.c',
-  'test_dsp_r1_repl_ph.c',
-  'test_dsp_r1_repl_qb.c',
-  'test_dsp_r1_replv_ph.c',
-  'test_dsp_r1_replv_qb.c',
+  'test_dsp_pack.c',
   'test_dsp_r1_shll_ph.c',
   'test_dsp_r1_shll_qb.c',
   'test_dsp_r1_shll_s_ph.c',
@@ -47,12 +27,6 @@ tests_dsp = [
   'test_dsp_r1_shrav_r_w.c',
   'test_dsp_r1_shrl_qb.c',
   'test_dsp_r1_shrlv_qb.c',
-  'test_dsp_r2_append.c',
-  'test_dsp_r2_balign.c',
-  'test_dsp_r2_precr_qb_ph.c',
-  'test_dsp_r2_precr_sra_ph_w.c',
-  'test_dsp_r2_precr_sra_r_ph_w.c',
-  'test_dsp_r2_prepend.c',
   'test_dsp_r2_shra_qb.c',
   'test_dsp_r2_shra_r_qb.c',
   'test_dsp_r2_shrav_qb.c',
-- 
2.55.0


