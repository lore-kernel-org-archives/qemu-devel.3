Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8CB606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HXT+6pqm;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J5YSBrb/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqpw-0006jD-TU; Fri, 30 Oct 2026 13:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqon-0005lp-DG
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:55:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqok-00080f-DJ
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:55:09 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERn8b1953698
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:55:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 x7FDklgo7cBmsbxVuU/0MnVEqX01qOy/B6aEnLw1L0g=; b=HXT+6pqmnHom70aQ
 uREJdFcOsRAVGmuXTjj1fSof+BeYNu+xR6VMWuS8D7tyQaSvQRIvhHv1L3Kuvn0D
 0BFp48aFykNwtSxzxVcFwKbyzj8T9FeyRAbWvUac2BSfeB6VLdjixDgNh5vWCDRQ
 p34/8dR8za3YfsLoZcWd9bybvGc1RPfeJgGdz7SM7DCL3AR1zF3y+Fc+JUD6uxZp
 aLX/jeAV4nWheeMYlHeWFKsX4nhkorVCTFCKzNO8dcWo1zM+x0KsG9Bytfp+K26b
 FcrvbHLVC87dhtCGRYemPPn0ICVGYDMyuNDcVRyiuCvqnyykRGItwm7ZGhhKoKJ7
 bNaq3w==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6pmb9v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:55:04 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7cc1bb97ff8so215530137.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793382903; x=1793987703; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=x7FDklgo7cBmsbxVuU/0MnVEqX01qOy/B6aEnLw1L0g=;
 b=J5YSBrb/m6LS3JU2zWU7yT5WcdT5HAsGboyo1k0EoWM+4QtWHUridCNUMryN+y72OJ
 OPN5fUf53iylx0FLqhuT9Xx595ApDbqWerejClwWCFIsuPQb7glOHX6YIq/SfX+7iP9Y
 ZfUn2igLblc6LhR8L5eaNoTrVCBaH5AyQXqK6A11CoiORPddYKQOTXdHWv37+n0ORxzy
 3QYUtYytfAs/xlI34fYJ0iM0J6YvNFmOE0X3xLba5TjcEHchRt0zODUjsS2ERI92khoT
 WXJIjXRBphrTsznJ38YNFO9juGoM1zKurJW2d2eKNfz7is5m2wvIjDpb5chT+GVukgKL
 YHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793382903; x=1793987703;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x7FDklgo7cBmsbxVuU/0MnVEqX01qOy/B6aEnLw1L0g=;
 b=QVFKh/T1FSVOT0naaSBTVP5ELFR2LIpQ0etkd4pj6zocwJImaQArr4xDHy56F7MLVY
 ts0znA3/dnrHrfygeA4H3Vn+SrfBOinNxnFCcuki8RJb4Cwv5ZlTphXjc7hp+696vmp9
 NA3NnRUul0mu2ZAplDNW3y+Bu+sw7KljCp5L+CsUJKnmJPFJ5xC5J9dbyNoeV7HkVSUI
 WvjX+gNHuGwOwoGAV/wYhDzWk30zBGjEDZjegjGHXEup3mAfGm+BmDbjdGDPT3UcVYyZ
 a6csmVIvgWuCeD09Y/kPNaoLPIa7nvH9UstJOyCDY/W2zCi1kQyYTlbiFzDylRKxllwq
 UHfw==
X-Gm-Message-State: AFq9FYIjnt99r1CUfgrg3P/T/aeRYPSxfbovXm03XaN+lcoU+QXZ2epx
 VumR4rzHuu/7yCbWxFd16w/GCvwLC5EUtIEtwtTPyY4DAxNUEKzcPac/u9IkDkWpv42sPBTIwMa
 LvDg8KShNuwctoQa3iT/2A3pl9PRjPxQk7D6gqrrY8o5L9Y2+EHPI8TbcNIWYJ2a2gQT4
X-Gm-Gg: AYBFou3WGSj5y0xWZGwtZjzLt6MICbaSBq+0MMTFWv1FGTjOyCLV6BK50tnjjjtDXnq
 fIaQwVI8lxXpos+attlpR3IklLwKlpKOB3bgfxSQO0b88bUn0Qo9zOi72TjQPiZ5XV3IhFUUCMT
 6eZ+d1wADtdWap7Ek13SmzPiOE/vY75LN3wVzTDeeJoGIktvRg3MOpfcLf1pbBakBy31727n5JZ
 +DP1jXHMmvXJPZc00pe4rEHvbuGWqvS4y7FMd6y4tt61z2AVHOmgRas4Am26x5ZLs919hXCpwkn
 D4wk14iMCYycxu/aGd0q9EUpCjkPvm/zB7pm5tErdiaU3QuQ4YrTlCeJedN8RzL1PjwOxEidD2O
 Agxd/IZnlDCLIIZprO034MuEsop8/UzrOZ1Zvwg5PJrNqGxoImBx3nLOvX8waXHFi4/AOMe17Ae
 f7BQWkQKis5SmL9Yzj2jWSluNOyhmtgg==
X-Received: by 2002:a05:6102:3e84:b0:7cc:26e4:1943 with SMTP id
 ada2fe7eead31-7d072ce1bd2mr1380117137.28.1793382903204; 
 Fri, 30 Oct 2026 10:55:03 -0700 (PDT)
X-Received: by 2002:a05:6102:3e84:b0:7cc:26e4:1943 with SMTP id
 ada2fe7eead31-7d072ce1bd2mr1380105137.28.1793382902605; 
 Fri, 30 Oct 2026 10:55:02 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b7815fsm4237019f8f.22.2026.10.30.10.54.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 10:55:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4 08/32] tests/tcg/mips: Group DSP pack tests
Date: Fri, 30 Oct 2026 18:53:30 +0100
Message-ID: <20261030175357.99684-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030175357.99684-1-philmd@oss.qualcomm.com>
References: <20261030175357.99684-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX/amWrBAQ//oL
 6T9JcMZOm0sm2u/GzsasQAfVpzaQpqJHwDfkPhndEKxSnLHsKVQKJTA3sBRaMF2D9LdFjhiXZgi
 lM3U1pid/Lz33BO/IqGURJ8+PQzGPIlS7iAkuTCiwBYQNCgcbvoj8gYaudajrDItR0187JacsZZ
 qRupELDeqFKoI4XaHO4Owd66qd3EG5cYdMkGsQMcoJSsB31z3OJ4w4XBgDL5BLO47pwC3yM3F9r
 YKnnXy4b84/ln1g+OllVAdo41RarWKkSY0OXLZGp5Ios5gYdbPTAFJZxXRJlT69L7+3YLUVIXEp
 l2vUdhPhJt4/b570K7bTAeyNzVSC92FiSQCOVuFqgZecRz3v6EpBHWkQ7BaeeFOxYjUjl86wWxX
 9qnxZVmn/LFiX0x7CZK5fxzlrDmNVMlGH94jGj4yNlRIhl9HP7+ZWHicXKR/Gs1dD2B91T1vj4X
 lN4BpFmfeCH/0hUFl8A==
X-Proofpoint-ORIG-GUID: oYd8xU22GcebP1RMevzyuf7NR7RyHyDm
X-Proofpoint-GUID: oYd8xU22GcebP1RMevzyuf7NR7RyHyDm
X-Authority-Analysis: v=2.4 cv=AJ83otAg c=1 sm=1 tr=0 ts=6ae4d9f8 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=wx96bOdwd-L99dZWacAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX6GV1mVtcYmVN
 3LbNJKWJNc534icGWzjnwQk+9jlLiRysjJnKIIYeo23rO2sRBMvvohr93rUFZnNVuyLyeNNmcOQ
 om9LBIHJuj45Ps4pDI6dRrU4ZBsbsdU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

Build the 27 per-opcode pack tests as a single executable,
test_dsp_pack.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mipsel/test_dsp_pack.c              | 149 ++++++++++++++++++
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
 29 files changed, 150 insertions(+), 54 deletions(-)
 create mode 100644 tests/tcg/mipsel/test_dsp_pack.c

diff --git a/tests/tcg/mipsel/test_dsp_pack.c b/tests/tcg/mipsel/test_dsp_pack.c
new file mode 100644
index 000000000000..915742aebdd0
--- /dev/null
+++ b/tests/tcg/mipsel/test_dsp_pack.c
@@ -0,0 +1,149 @@
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
+    TAP_START();
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


