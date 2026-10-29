Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE59606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TwyrZUlq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FrHfWNZY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTrb-00063v-Op; Thu, 29 Oct 2026 13:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTrQ-0005sS-Ex
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:24:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTrL-00015v-F9
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:24:18 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDLHS227483
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:24:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wq4UDPElkhv66gvhjjo3lOsigCeqfLf03NAkS0SAWmM=; b=TwyrZUlqwxgJ8TUC
 j2rltg5gqTdWj1zO5RGHfLojuwkWVcr9vo4jpKMGivDIrPgUz5ctFkmpTXpXHW6M
 yfmfQ+9/OMOpDCK/iNScQgCRFsSF+7ja9VzBUWbaTUqEkwY/1tuNwqR8zTCQC4xV
 NLh2MybWRzw/0/Cl922oZ0Pe7i3dgNYFgzdFJ0XIzxCaidrfxteBrquLWh945hIY
 /3x0L3nGgcn46YZZZiRsc52lfAcsVeT+1Agzea/muTBHuEKIOwP6MUTOyD7DecTr
 rcSxmLrubnp0xySMqvVv6jmTWU8mTzIxe/ShanRPunMRhXG/aqwPVbeDxqBCaPgP
 KeB77Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm42fj9gy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:24:14 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cb6391e89so452810485a.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793294654; x=1793899454; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wq4UDPElkhv66gvhjjo3lOsigCeqfLf03NAkS0SAWmM=;
 b=FrHfWNZYQ3FSJQ+aXG3/OXf0oO8eseDWUsyXKgDkoywRVhzDkzgP3rThBOz1IbYJ/W
 7Ggg9q4pUE9FwjJ8HmsvnmFyMH2lNnDCBUrFOlpeDCw6OIlvvsOufw3thK+Q3ZFyBodH
 vMxClCqBjW++qg1hPz1kd59Atd3XC7x5JXylJmvDPAK5Y5vSHQ23CdhVlJQF4WCKNZRZ
 yENURFwN5NDbe5vZiz+5AW9g0UBzBfUV79U9eMn696voqiovMghSlLPv+NlsPu56Bijl
 jmb87mLEkVZkQtMbqgQm6pw/Lt9r1hmkSod7TKttlz6iLH5BqhvUHnYqmKliHBe0VyZl
 jNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294654; x=1793899454;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wq4UDPElkhv66gvhjjo3lOsigCeqfLf03NAkS0SAWmM=;
 b=vwGE16drVLA9iG+NgywtLBZniujVKtD/4FpJos00otwoLnUO82uj9Ou7T+2kov/1mx
 /THxsBrWAui6pSgJ5vrFmn5IkGe81Vzk4UHHA/GOXeBm/FJL60R+j/mNr9R8ezVtNTlM
 Q42ZBe2gDZmaV3zQJ3mqMl7q6cslYA6PdcjpzCnv6uKk4Upef2gKf7e6OKjt0hTom/MA
 7mKM6oDzS453jCNxutcOCZyPAzn9nPMheBGt/+ckUFwlYOqc+CX8+imd6K6agvaim9az
 s3t/hBE6HzRMMnUKF/iz494AqdfP2tUOjn+jw79hUGYhxhCes3p3JTy7y6Y43nkxmmsx
 Afnw==
X-Gm-Message-State: AFq9FYKebQiEh6RuLgqvZa9kVJyZjP+1TGVxR1b/nWvxFkeNOmGlftV3
 uVVRoxaXFaI1gnrE9y44BIT6sCJUr+FEgYSgCGPEYZmykwUPLXKhO0YY77fLRJ4VvYdJ7mKVK4K
 JwFdRCCUrQZ+HD18AzH9kYxnjLfQeVN7f8g/kfhzJWSZD33Greuihf0sbJGexQIpsn/Hl
X-Gm-Gg: AYBFou3TeC2HwKcghnadEg97/+rWK/ElZbfGHSZe0Ook0xRfRp+AxrXEn6M2w4L40wA
 FWszjkBbQDOJxOsRzV0/5xK0aV0hCOrZUsHIz5w20q3X1+D8ne2Lc8jflt5uLzE8MiVtqT70+E1
 2nyqvbmMaarn26OVXkT5mqOrNVxz8zUKB5afTqJWrGUzUzqDyH75U6KsljCzhaSZ6NBtRfPIXvg
 LgwEVZGIH35ndjumS6CRX3aE2EMVUIIDnLk6x5TdmgvJY2AVxN+23wy6yEF9u92i0aqzumXErFt
 jIWe6eeSXyTyg8nBFxdD8G880BufreYxiOmsYixcFeXvI7KwxExUTxcZouuNIIpNxjNr4X3ukLk
 Pq04k47W3moa5WS6njt+O/9vrB182m52tc1QDjyrH2HvTP5zdtsGLtYqJwwoVWheC6KSWdct2LQ
 qx+Jdl73Sx0EHeuL6nmzs3nAYffjNwzA==
X-Received: by 2002:a05:620a:4686:b0:93e:90e0:d2e3 with SMTP id
 af79cd13be357-94408c949ccmr936750385a.39.1793294653736; 
 Thu, 29 Oct 2026 10:24:13 -0700 (PDT)
X-Received: by 2002:a05:620a:4686:b0:93e:90e0:d2e3 with SMTP id
 af79cd13be357-94408c949ccmr936745385a.39.1793294652965; 
 Thu, 29 Oct 2026 10:24:12 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80285b88sm77924415e9.14.2026.10.29.10.24.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:24:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 07/31] tests/tcg/mips: Group DSP pack tests
Date: Thu, 29 Oct 2026 18:22:51 +0100
Message-ID: <20261029172319.25766-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029172319.25766-1-philmd@oss.qualcomm.com>
References: <20261029172319.25766-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX2JJZysyRpsYT
 njILcxIN4e/P1xR1GhzMplbd2insSQC1FA53qNmRceo21reUXKqSXlexWIYGwOwExYbap4lJ9Ci
 ITlXR8aw4TfexYkWFOC6FP59B8/NoqMfHta7Tsq+c5bphC0V8mNLeU4sGR0lYeBmuDksn43F/BS
 HBxaltk0HfQ8A32ptg2h0/c+i8vL9hnKhcOBtrFNkq7eiBCi/CX/JJKtex22L8rjlee2H8ZDhqf
 aG55yaGUoFKaiowzo1aIoKGmtf9q2Wb53+J9OmDgDn0B4gNTh+IHirM7WXcW1Xhyo7AcwymQkUB
 7k/EpZIBqp9zscrbFAscDzD5NGuwDn0eSfB8w69R203iYSUNRUXdXg47UkQrtGZ9N09VI3//2rV
 CQ0ZDbLJk1PF5pjA6tDUp529gpDy7Q==
X-Proofpoint-GUID: z0HIp3ZM1ywbq1lRlVJjwi0zR7bs_bnu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfXy2GookCd6CYV
 +SACND9KNG448Ft2fOmB/i1Zrtx4NjUGz4+0HJrfRa4kqNlmGIrJJo2O1ljrW6SBG3hir0/JTob
 NlW9Z/g/e0aQudg23YB6QgBP/KWna9E=
X-Authority-Analysis: v=2.4 cv=UN9Ijyfy c=1 sm=1 tr=0 ts=6ae3813e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=0H6t-_0pH3jiKDw0XewA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: z0HIp3ZM1ywbq1lRlVJjwi0zR7bs_bnu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610190000 definitions=main-2610290068
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
---
 tests/tcg/mipsel/test_dsp_pack.c              | 152 ++++++++++++++++++
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
 29 files changed, 153 insertions(+), 54 deletions(-)
 create mode 100644 tests/tcg/mipsel/test_dsp_pack.c

diff --git a/tests/tcg/mipsel/test_dsp_pack.c b/tests/tcg/mipsel/test_dsp_pack.c
new file mode 100644
index 000000000000..1c04d420ac22
--- /dev/null
+++ b/tests/tcg/mipsel/test_dsp_pack.c
@@ -0,0 +1,152 @@
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
+    int ret = 0;
+
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
+    DSP_TAP_PLAN();
+
+    return ret;
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


