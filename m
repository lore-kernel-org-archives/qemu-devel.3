Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD893606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TUL4+1Fx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IPgy6zqG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIunR-0001hP-LW; Mon, 19 Oct 2026 17:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIunL-0001g1-79
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIunG-0005hg-GB
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:22 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJKAKX2157940
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=jCARm0mkWgm
 nM+Xfip7Sv2saa/dwFKM86/UVDur0xNs=; b=TUL4+1FxSDn7abVPMWQbZwWsPmu
 k9O+mjlBZNIcgxhdKQgaj/QEerROQh5eWiSCQfXo7Xnyk8Z5uwlNl9ZBwLjDhV4J
 8TjhPIGn06eY0KfbgRo53p03ZqiXwrJ1pvNXbPKxznkptPW6qb9GCcyec/SuHYas
 9CQHBzVCN1L+n/4yW9qV2MvUs1dNodzpbvRu/iByuYMd34WduPkcSVwuCKPe1ony
 bijoKexwExDpvvL+A0Ln0pseNB3PDSsfutTfWlPIy3flXmvMZEP5VdxHGxuyvmJ3
 e1G0UETc24cAMZbwYI2ipqbN0yXLY0B0svohGdOTlfPs9LBlOpSv/FqAkyg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf65kahm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:16 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ac77c3ff6aso3442878a91.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792444876; x=1793049676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jCARm0mkWgmnM+Xfip7Sv2saa/dwFKM86/UVDur0xNs=;
 b=IPgy6zqGPH/A8v+xZpbQlUTDgJJfbjGrMJIYm5VDTeZrfR0Ew2OMZlN8C4SZgf0ds7
 H1jE9+fd/1m25N7iBhykWU/rhfskaFEX5HZlHSfo9TbpkcfOvcU8ycHNQcrLqePVIVuX
 oqc4aiM7HzXWZniYsItOzQ0zmKCyDPR5pZnxYb+EkLMkcHGksdqJfF3W28GNq/ofpcr1
 l4LODb13Iut0Ot3Vxk5Q7IcoQgSs1n0IKbGGM+KyWYrY+fsF0w6d7dF+i1bhK6t1vbsN
 jm0x+77zT68fb2VmiYU5j8mauWsS4qvmNSJZKZorOt4gzq7pAwYXh5XH2jThtIn7aI20
 wJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792444876; x=1793049676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jCARm0mkWgmnM+Xfip7Sv2saa/dwFKM86/UVDur0xNs=;
 b=MrNFHQmTuFP+DmEZxHxtv4e/xTC/O1yeMULkJh3abbtEOJefJQVR+dSSyJv2IIQtDd
 xLnWL2l0HsAre51dGz7KWR4vZAhgEVUz0bBEbJq1FgyNv6n0At55Vsdmrhh0XiUSMcN5
 33oQeRqteZqCNwkuLIg3snMw5yFsRl9GoOmfm826ctRyCeIlMGuZBlNUmOcok/zn5wWe
 8mC6VenbyxLFpUf47oYtTiAHxVRB2RT7BAdx2pxxl43xj6K/ERRkb/MXtSbbKuOcY29S
 Ulrb9/eDPiOnwNZ79PP3QPiNWaR5WiQkxvnPKI6BBN/Dl1LdpNa9Dhjt00RYhm+cfzPf
 d55g==
X-Gm-Message-State: AFq9FYLwTwYZpQIYQF+ZYsPwdMRaXeznJxxooujAwoON0x0UnnAICLW+
 RN8+166ukV+A3wrF23msyUEa9+i+WtR1j6Y7UYPt9im04k+aUxMLKNQ0k1Bf+XoAlSo0BtmsHy6
 xvmbLJTf+Sg4FUZs9mhmm5gGa34Nk3EovUGTXsQwyiLylnnMSmqe3uoTD+fZ0s/XfHw==
X-Gm-Gg: AYBFou0AwoQ/ukxKMqW0Yv6dzBYnm5WNf2PKErnSWfwjKzIbCy+pViNpMxWYusFEj/R
 t8zaGGWo4uvwckpgnoTYPmf1Zt95Z/GRpkWT4dilRMXlqHXSXeW5FL1CTSMXyi+C7XM1zLB4ro/
 I6HCtC/34r0qlkcNHuJn9DF4YJpvWY4C66EXlyl4zMy5oGB2EGNcUadNtt2R66ejnnBc6bhy8w4
 YdDxDa1niCS5ktozJGe0KeH2xccgH3i2QewSii7+sEVSuCVhWgcyBTnhHtNBvmNFpiWt4nkyqm3
 CyRwWSsljVRo3sSgxFzs66DWj9vRdHQVIcA0YQc6PyEVcTPWSZV43UOnY0477P/X93fIAfU5L6B
 FHnfXTd1j7XmGpx7VRddA89BhYteg00cRncGRNyNTluWwFDveotvhC4u5l5pOFmE=
X-Received: by 2002:a17:90b:2ccb:b0:3ab:884b:65a8 with SMTP id
 98e67ed59e1d1-3acef17932fmr7210941a91.26.1792444874474; 
 Mon, 19 Oct 2026 14:21:14 -0700 (PDT)
X-Received: by 2002:a17:90b:2ccb:b0:3ab:884b:65a8 with SMTP id
 98e67ed59e1d1-3acef17932fmr7210897a91.26.1792444872688; 
 Mon, 19 Oct 2026 14:21:12 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60ec4457sm863243a91.6.2026.10.19.14.21.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:21:11 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 11/26] target/ppc: define and call helpers using HELPER macro
Date: Mon, 19 Oct 2026 21:20:30 +0000
Message-ID: <20261019212046.149572-12-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX2bzNWS39lJ5Q
 Wm1P4sPG+8oTrQ48Zvod7wGi+VhP/scRe8odbNv4uZtHAKrxSmTqIVwnriA7ADpJ9BAKCx+0U7x
 E4tNflRQemKJIhyEcjda05tJzVCmd20=
X-Proofpoint-ORIG-GUID: kyT2YjdFdxC40vPKvh8uYlXlCwBgGjlx
X-Authority-Analysis: v=2.4 cv=Y5ptIReN c=1 sm=1 tr=0 ts=6ad689cd cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=o1BgDBNy9eMT-Y5ZzvsA:9 a=O8hF6Hzn-FEA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX8OunM9ctkuUb
 eRsOGhwY9tLdVqykIpT1d3XREwvrKxipUnF0vxND2t5/Zdkt/tPM8Akm1/TBApk77N2ZN98fdn1
 kuTVKXIXRvFPBeuuC8PRB2hNNBxlYPAWQVljDEybHuEfFVToaILt1w023a2ylAhSK7Xb/0ZhbPS
 vSMH0GP2urujJiTMZWNxsoeQyltt91fka4aP3FuT/y7S58sglbg/+JQfKYpxtYS6udqkgDRXjzf
 4FY+77GM5J3RVAQC5qg5gEjLwIRJMyC9OWWr00/bkbr0hrevAEFb5X9omFy00aye0C7nrdVoCWH
 Z+lwIIqmMKqEgDlJZAY2oi4ME6lfCAysV0hlsdP7jfJlPmgVJH7Tf8rYx5Vg/WX1FAH0yyA/IdP
 B+MV1O7Nid6td8Ph6gHw+AEU1qftUJeOzHALBD2IXrLZKscgeNQF1boVAGNa4AZEzAcAd5sp6WL
 VkN80KbwY8EHxkkwHKA==
X-Proofpoint-GUID: kyT2YjdFdxC40vPKvh8uYlXlCwBgGjlx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190085
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

In a upcoming commit, we'll prefix all helpers and helper_info with target
prefix, to disambiguate symbols between targets. As a first step, we need to
make sure all usages are using the existing HELPER macro.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/ppc/dfp_helper.c             |  52 ++--
 target/ppc/fpu_helper.c             | 396 ++++++++++++++--------------
 target/ppc/int_helper.c             | 292 ++++++++++----------
 target/ppc/internal.h               |   7 +-
 target/ppc/mem_helper.c             |  28 +-
 target/ppc/misc_helper.c            |  56 ++--
 target/ppc/mmu-hash64.c             |  18 +-
 target/ppc/mmu_helper.c             |  70 ++---
 target/ppc/power8-pmu.c             |  14 +-
 target/ppc/tcg-excp_helper.c        |  56 ++--
 target/ppc/timebase_helper.c        |  54 ++--
 target/ppc/translate/vsx-impl.c.inc |   2 +-
 12 files changed, 526 insertions(+), 519 deletions(-)

diff --git a/target/ppc/dfp_helper.c b/target/ppc/dfp_helper.c
index ecc3f793267..b529e1cb486 100644
--- a/target/ppc/dfp_helper.c
+++ b/target/ppc/dfp_helper.c
@@ -427,7 +427,7 @@ static inline int dfp_get_digit(decNumber *dn, int n)
 }
 
 #define DFP_HELPER_TAB(op, dnop, postprocs, size)                              \
-void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *a,               \
+void HELPER(op)(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *a,                \
                  ppc_fprp_t *b)                                                \
 {                                                                              \
     struct PPC_DFP dfp;                                                        \
@@ -493,7 +493,7 @@ DFP_HELPER_TAB(DDIV, decNumberDivide, DIV_PPs, 64)
 DFP_HELPER_TAB(DDIVQ, decNumberDivide, DIV_PPs, 128)
 
 #define DFP_HELPER_BF_AB(op, dnop, postprocs, size)                            \
-uint32_t helper_##op(CPUPPCState *env, ppc_fprp_t *a, ppc_fprp_t *b)           \
+uint32_t HELPER(op)(CPUPPCState *env, ppc_fprp_t *a, ppc_fprp_t *b)            \
 {                                                                              \
     struct PPC_DFP dfp;                                                        \
     dfp_prepare_decimal##size(&dfp, a, b, env);                                \
@@ -525,7 +525,7 @@ DFP_HELPER_BF_AB(DCMPO, decNumberCompare, CMPO_PPs, 64)
 DFP_HELPER_BF_AB(DCMPOQ, decNumberCompare, CMPO_PPs, 128)
 
 #define DFP_HELPER_TSTDC(op, size)                                       \
-uint32_t helper_##op(CPUPPCState *env, ppc_fprp_t *a, uint32_t dcm)      \
+uint32_t HELPER(op)(CPUPPCState *env, ppc_fprp_t *a, uint32_t dcm)       \
 {                                                                        \
     struct PPC_DFP dfp;                                                  \
     int match = 0;                                                       \
@@ -553,7 +553,7 @@ DFP_HELPER_TSTDC(DTSTDC, 64)
 DFP_HELPER_TSTDC(DTSTDCQ, 128)
 
 #define DFP_HELPER_TSTDG(op, size)                                       \
-uint32_t helper_##op(CPUPPCState *env, ppc_fprp_t *a, uint32_t dcm)      \
+uint32_t HELPER(op)(CPUPPCState *env, ppc_fprp_t *a, uint32_t dcm)       \
 {                                                                        \
     struct PPC_DFP dfp;                                                  \
     int minexp, maxexp, nzero_digits, nzero_idx, is_negative, is_zero,   \
@@ -608,7 +608,7 @@ DFP_HELPER_TSTDG(DTSTDG, 64)
 DFP_HELPER_TSTDG(DTSTDGQ, 128)
 
 #define DFP_HELPER_TSTEX(op, size)                                       \
-uint32_t helper_##op(CPUPPCState *env, ppc_fprp_t *a, ppc_fprp_t *b)     \
+uint32_t HELPER(op)(CPUPPCState *env, ppc_fprp_t *a, ppc_fprp_t *b)      \
 {                                                                        \
     struct PPC_DFP dfp;                                                  \
     int expa, expb, a_is_special, b_is_special;                          \
@@ -640,7 +640,7 @@ DFP_HELPER_TSTEX(DTSTEX, 64)
 DFP_HELPER_TSTEX(DTSTEXQ, 128)
 
 #define DFP_HELPER_TSTSF(op, size)                                       \
-uint32_t helper_##op(CPUPPCState *env, ppc_fprp_t *a, ppc_fprp_t *b)     \
+uint32_t HELPER(op)(CPUPPCState *env, ppc_fprp_t *a, ppc_fprp_t *b)      \
 {                                                                        \
     struct PPC_DFP dfp;                                                  \
     unsigned k;                                                          \
@@ -677,7 +677,7 @@ DFP_HELPER_TSTSF(DTSTSF, 64)
 DFP_HELPER_TSTSF(DTSTSFQ, 128)
 
 #define DFP_HELPER_TSTSFI(op, size)                                     \
-uint32_t helper_##op(CPUPPCState *env, uint32_t a, ppc_fprp_t *b)       \
+uint32_t HELPER(op)(CPUPPCState *env, uint32_t a, ppc_fprp_t *b)        \
 {                                                                       \
     struct PPC_DFP dfp;                                                 \
     unsigned uim;                                                       \
@@ -737,7 +737,7 @@ static void dfp_quantize(uint8_t rmc, struct PPC_DFP *dfp)
 }
 
 #define DFP_HELPER_QUAI(op, size)                                       \
-void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b,        \
+void HELPER(op)(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b,         \
                  uint32_t te, uint32_t rmc)                             \
 {                                                                       \
     struct PPC_DFP dfp;                                                 \
@@ -758,7 +758,7 @@ DFP_HELPER_QUAI(DQUAI, 64)
 DFP_HELPER_QUAI(DQUAIQ, 128)
 
 #define DFP_HELPER_QUA(op, size)                                        \
-void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *a,        \
+void HELPER(op)(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *a,         \
                  ppc_fprp_t *b, uint32_t rmc)                           \
 {                                                                       \
     struct PPC_DFP dfp;                                                 \
@@ -830,7 +830,7 @@ static void _dfp_reround(uint8_t rmc, int32_t ref_sig, int32_t xmax,
 }
 
 #define DFP_HELPER_RRND(op, size)                                       \
-void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *a,        \
+void HELPER(op)(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *a,         \
                  ppc_fprp_t *b, uint32_t rmc)                           \
 {                                                                       \
     struct PPC_DFP dfp;                                                 \
@@ -854,7 +854,7 @@ DFP_HELPER_RRND(DRRND, 64)
 DFP_HELPER_RRND(DRRNDQ, 128)
 
 #define DFP_HELPER_RINT(op, postprocs, size)                                   \
-void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b,               \
+void HELPER(op)(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b,                \
              uint32_t r, uint32_t rmc)                                         \
 {                                                                              \
     struct PPC_DFP dfp;                                                        \
@@ -888,7 +888,7 @@ static void RINTN_PPs(struct PPC_DFP *dfp)
 DFP_HELPER_RINT(DRINTN, RINTN_PPs, 64)
 DFP_HELPER_RINT(DRINTNQ, RINTN_PPs, 128)
 
-void helper_DCTDP(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b)
+void HELPER(DCTDP)(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b)
 {
     struct PPC_DFP dfp;
     ppc_vsr_t vb;
@@ -904,7 +904,7 @@ void helper_DCTDP(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b)
     dfp_set_FPRF_from_FRT(&dfp);
 }
 
-void helper_DCTQPQ(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b)
+void HELPER(DCTQPQ)(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b)
 {
     struct PPC_DFP dfp;
     ppc_vsr_t vb;
@@ -919,7 +919,7 @@ void helper_DCTQPQ(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b)
     set_dfp128(t, &dfp.vt);
 }
 
-void helper_DRSP(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b)
+void HELPER(DRSP)(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b)
 {
     struct PPC_DFP dfp;
     uint32_t t_short = 0;
@@ -937,7 +937,7 @@ void helper_DRSP(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b)
     set_dfp64(t, &vt);
 }
 
-void helper_DRDPQ(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b)
+void HELPER(DRDPQ)(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b)
 {
     struct PPC_DFP dfp;
     dfp_prepare_decimal128(&dfp, 0, b, env);
@@ -956,7 +956,7 @@ void helper_DRDPQ(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b)
 }
 
 #define DFP_HELPER_CFFIX(op, size)                                             \
-void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b)               \
+void HELPER(op)(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b)                \
 {                                                                              \
     struct PPC_DFP dfp;                                                        \
     ppc_vsr_t vb;                                                              \
@@ -978,7 +978,7 @@ static void CFFIX_PPs(struct PPC_DFP *dfp)
 DFP_HELPER_CFFIX(DCFFIX, 64)
 DFP_HELPER_CFFIX(DCFFIXQ, 128)
 
-void helper_DCFFIXQQ(CPUPPCState *env, ppc_fprp_t *t, ppc_avr_t *b)
+void HELPER(DCFFIXQQ)(CPUPPCState *env, ppc_fprp_t *t, ppc_avr_t *b)
 {
     struct PPC_DFP dfp;
 
@@ -991,7 +991,7 @@ void helper_DCFFIXQQ(CPUPPCState *env, ppc_fprp_t *t, ppc_avr_t *b)
 }
 
 #define DFP_HELPER_CTFIX(op, size)                                            \
-void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b)              \
+void HELPER(op)(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b)               \
 {                                                                             \
     struct PPC_DFP dfp;                                                       \
     dfp_prepare_decimal##size(&dfp, 0, b, env);                               \
@@ -1028,7 +1028,7 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b)              \
 DFP_HELPER_CTFIX(DCTFIX, 64)
 DFP_HELPER_CTFIX(DCTFIXQ, 128)
 
-void helper_DCTFIXQQ(CPUPPCState *env, ppc_avr_t *t, ppc_fprp_t *b)
+void HELPER(DCTFIXQQ)(CPUPPCState *env, ppc_avr_t *t, ppc_fprp_t *b)
 {
     struct PPC_DFP dfp;
     dfp_prepare_decimal128(&dfp, 0, b, env);
@@ -1103,7 +1103,7 @@ static inline void dfp_set_sign_128(ppc_vsr_t *t, uint8_t sgn)
 }
 
 #define DFP_HELPER_DEDPD(op, size)                                        \
-void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b,          \
+void HELPER(op)(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b,           \
                  uint32_t sp)                                             \
 {                                                                         \
     struct PPC_DFP dfp;                                                   \
@@ -1168,7 +1168,7 @@ static inline void dfp_invalid_op_vxcvi_128(struct PPC_DFP *dfp)
 }
 
 #define DFP_HELPER_ENBCD(op, size)                                           \
-void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b,             \
+void HELPER(op)(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b,              \
                  uint32_t s)                                                 \
 {                                                                            \
     struct PPC_DFP dfp;                                                      \
@@ -1228,7 +1228,7 @@ DFP_HELPER_ENBCD(DENBCD, 64)
 DFP_HELPER_ENBCD(DENBCDQ, 128)
 
 #define DFP_HELPER_XEX(op, size)                               \
-void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b) \
+void HELPER(op)(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b)  \
 {                                                              \
     struct PPC_DFP dfp;                                        \
     ppc_vsr_t vt;                                              \
@@ -1274,7 +1274,7 @@ static void dfp_set_raw_exp_128(ppc_vsr_t *t, uint64_t raw)
 }
 
 #define DFP_HELPER_IEX(op, size)                                          \
-void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *a,          \
+void HELPER(op)(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *a,           \
                  ppc_fprp_t *b)                                           \
 {                                                                         \
     struct PPC_DFP dfp;                                                   \
@@ -1368,7 +1368,7 @@ static void dfp_clear_lmd_from_g5msb(uint64_t *t)
 }
 
 #define DFP_HELPER_SHIFT(op, size, shift_left)                      \
-void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *a,    \
+void HELPER(op)(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *a,     \
                  uint32_t sh)                                       \
 {                                                                   \
     struct PPC_DFP dfp;                                             \
@@ -1417,7 +1417,7 @@ DFP_HELPER_SHIFT(DSCLIQ, 128, 1)
 DFP_HELPER_SHIFT(DSCRI, 64, 0)
 DFP_HELPER_SHIFT(DSCRIQ, 128, 0)
 
-target_ulong helper_CDTBCD(target_ulong s)
+target_ulong HELPER(CDTBCD)(target_ulong s)
 {
     uint64_t res = 0;
     uint32_t dec32, declets;
@@ -1443,7 +1443,7 @@ target_ulong helper_CDTBCD(target_ulong s)
     return res;
 }
 
-target_ulong helper_CBCDTD(target_ulong s)
+target_ulong HELPER(CBCDTD)(target_ulong s)
 {
     uint64_t res = 0;
     uint32_t dec32;
diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index c1bdde9e104..b2ca14a1584 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -60,7 +60,7 @@ static inline bool fp_exceptions_enabled(CPUPPCState *env)
  * This is the non-arithmatic conversion that happens e.g. on loads.
  * In the Power ISA pseudocode, this is called DOUBLE.
  */
-uint64_t helper_todouble(uint32_t arg)
+uint64_t HELPER(todouble)(uint32_t arg)
 {
     uint32_t abs_arg = arg & 0x7fffffff;
     uint64_t ret;
@@ -104,7 +104,7 @@ uint64_t helper_todouble(uint32_t arg)
  * This is the non-arithmatic conversion that happens e.g. on stores.
  * In the Power ISA pseudocode, this is called SINGLE.
  */
-uint32_t helper_tosingle(uint64_t arg)
+uint32_t HELPER(tosingle)(uint64_t arg)
 {
     int exp = extract64(arg, 52, 11);
     uint32_t ret;
@@ -141,7 +141,7 @@ static inline int ppc_float64_get_unbiased_exp(float64 f)
 }
 
 #define COMPUTE_FPRF(tp)                                          \
-void helper_compute_fprf_##tp(CPUPPCState *env, tp arg)           \
+void HELPER(compute_fprf_##tp)(CPUPPCState *env, tp arg)          \
 {                                                                 \
     bool neg = tp##_is_neg(arg);                                  \
     target_ulong fprf;                                            \
@@ -354,7 +354,7 @@ static inline void float_inexact_excp(CPUPPCState *env)
     }
 }
 
-void helper_fpscr_clrbit(CPUPPCState *env, uint32_t bit)
+void HELPER(fpscr_clrbit)(CPUPPCState *env, uint32_t bit)
 {
     uint32_t mask = 1u << bit;
     if (env->fpscr & mask) {
@@ -362,7 +362,7 @@ void helper_fpscr_clrbit(CPUPPCState *env, uint32_t bit)
     }
 }
 
-void helper_fpscr_setbit(CPUPPCState *env, uint32_t bit)
+void HELPER(fpscr_setbit)(CPUPPCState *env, uint32_t bit)
 {
     uint32_t mask = 1u << bit;
     if (!(env->fpscr & mask)) {
@@ -370,7 +370,7 @@ void helper_fpscr_setbit(CPUPPCState *env, uint32_t bit)
     }
 }
 
-void helper_store_fpscr(CPUPPCState *env, uint64_t val, uint32_t nibbles)
+void HELPER(store_fpscr)(CPUPPCState *env, uint64_t val, uint32_t nibbles)
 {
     target_ulong mask = 0;
     int i;
@@ -434,7 +434,7 @@ static void do_fpscr_check_status(CPUPPCState *env, uintptr_t raddr)
     }
 }
 
-void helper_fpscr_check_status(CPUPPCState *env)
+void HELPER(fpscr_check_status)(CPUPPCState *env)
 {
     do_fpscr_check_status(env, GETPC());
 }
@@ -468,12 +468,12 @@ static void do_float_check_status(CPUPPCState *env, bool change_fi,
     }
 }
 
-void helper_float_check_status(CPUPPCState *env)
+void HELPER(float_check_status)(CPUPPCState *env)
 {
     do_float_check_status(env, true, GETPC());
 }
 
-void helper_reset_fpstatus(CPUPPCState *env)
+void HELPER(reset_fpstatus)(CPUPPCState *env)
 {
     set_float_exception_flags(0, &env->fp_status);
 }
@@ -552,7 +552,7 @@ static uint64_t float_invalid_cvt(CPUPPCState *env, int flags,
 }
 
 #define FPU_FCTI(op, cvt, nanval)                                      \
-uint64_t helper_##op(CPUPPCState *env, float64 arg)                    \
+uint64_t HELPER(op)(CPUPPCState *env, float64 arg)                     \
 {                                                                      \
     uint64_t ret = float64_to_##cvt(arg, &env->fp_status);             \
     int flags = get_float_exception_flags(&env->fp_status);            \
@@ -572,7 +572,7 @@ FPU_FCTI(FCTIDU, uint64, 0x0000000000000000ULL)
 FPU_FCTI(FCTIDUZ, uint64_round_to_zero, 0x0000000000000000ULL)
 
 #define FPU_FCFI(op, cvtr, is_single)                      \
-uint64_t helper_##op(CPUPPCState *env, uint64_t arg)       \
+uint64_t HELPER(op)(CPUPPCState *env, uint64_t arg)        \
 {                                                          \
     CPU_DoubleU farg;                                      \
                                                            \
@@ -613,22 +613,22 @@ static uint64_t do_fri(CPUPPCState *env, uint64_t arg,
     return arg;
 }
 
-uint64_t helper_FRIN(CPUPPCState *env, uint64_t arg)
+uint64_t HELPER(FRIN)(CPUPPCState *env, uint64_t arg)
 {
     return do_fri(env, arg, float_round_ties_away);
 }
 
-uint64_t helper_FRIZ(CPUPPCState *env, uint64_t arg)
+uint64_t HELPER(FRIZ)(CPUPPCState *env, uint64_t arg)
 {
     return do_fri(env, arg, float_round_to_zero);
 }
 
-uint64_t helper_FRIP(CPUPPCState *env, uint64_t arg)
+uint64_t HELPER(FRIP)(CPUPPCState *env, uint64_t arg)
 {
     return do_fri(env, arg, float_round_up);
 }
 
-uint64_t helper_FRIM(CPUPPCState *env, uint64_t arg)
+uint64_t HELPER(FRIM)(CPUPPCState *env, uint64_t arg)
 {
     return do_fri(env, arg, float_round_down);
 }
@@ -668,10 +668,10 @@ static uint64_t do_fmadds(CPUPPCState *env, float64 a, float64 b,
 }
 
 #define FPU_FMADD(op, madd_flags)                                    \
-    uint64_t helper_##op(CPUPPCState *env, uint64_t arg1,            \
+    uint64_t HELPER(op)(CPUPPCState *env, uint64_t arg1,             \
                          uint64_t arg2, uint64_t arg3)               \
     { return do_fmadd(env, arg1, arg2, arg3, madd_flags, GETPC()); } \
-    uint64_t helper_##op##S(CPUPPCState *env, uint64_t arg1,         \
+    uint64_t HELPER(op##S)(CPUPPCState *env, uint64_t arg1,          \
                          uint64_t arg2, uint64_t arg3)               \
     { return do_fmadds(env, arg1, arg2, arg3, madd_flags, GETPC()); }
 
@@ -694,10 +694,10 @@ static uint64_t do_frsp(CPUPPCState *env, uint64_t arg, uintptr_t retaddr)
     if (unlikely(flags & float_flag_invalid_snan)) {
         float_invalid_op_vxsnan(env, retaddr);
     }
-    return helper_todouble(f32);
+    return HELPER(todouble)(f32);
 }
 
-uint64_t helper_FRSP(CPUPPCState *env, uint64_t arg)
+uint64_t HELPER(FRSP)(CPUPPCState *env, uint64_t arg)
 {
     return do_frsp(env, arg, GETPC());
 }
@@ -713,7 +713,7 @@ static void float_invalid_op_sqrt(CPUPPCState *env, int flags,
 }
 
 #define FPU_FSQRT(name, op)                                                   \
-float64 helper_##name(CPUPPCState *env, float64 arg)                          \
+float64 HELPER(name)(CPUPPCState *env, float64 arg)                           \
 {                                                                             \
     float64 ret = op(arg, &env->fp_status);                                   \
     int flags = get_float_exception_flags(&env->fp_status);                   \
@@ -729,7 +729,7 @@ FPU_FSQRT(FSQRT, float64_sqrt)
 FPU_FSQRT(FSQRTS, float64r32_sqrt)
 
 #define FPU_FRE(name, op)                                                     \
-float64 helper_##name(CPUPPCState *env, float64 arg)                          \
+float64 HELPER(name)(CPUPPCState *env, float64 arg)                           \
 {                                                                             \
     /* "Estimate" the reciprocal with actual division.  */                    \
     float64 ret = op(float64_one, arg, &env->fp_status);                      \
@@ -748,7 +748,7 @@ float64 helper_##name(CPUPPCState *env, float64 arg)                          \
 }
 
 #define FPU_FRSQRTE(name, op)                                                 \
-float64 helper_##name(CPUPPCState *env, float64 arg)                          \
+float64 HELPER(name)(CPUPPCState *env, float64 arg)                           \
 {                                                                             \
     /* "Estimate" the reciprocal with actual division.  */                    \
     float64 rets = float64_sqrt(arg, &env->fp_status);                        \
@@ -767,7 +767,7 @@ float64 helper_##name(CPUPPCState *env, float64 arg)                          \
 }
 
 #define FPU_HELPER(name, op, flags_handler)                                   \
-float64 helper_##name(CPUPPCState *env, float64 arg1, float64 arg2)           \
+float64 HELPER(name)(CPUPPCState *env, float64 arg1, float64 arg2)            \
 {                                                                             \
     float64 ret = op(arg1, arg2, &env->fp_status);                            \
     int flags = get_float_exception_flags(&env->fp_status);                   \
@@ -790,7 +790,7 @@ FPU_HELPER(FDIV, float64_div, div_flags_handler)
 FPU_HELPER(FDIVS, float64r32_div, div_flags_handler)
 
 /* fsel - fsel. */
-uint64_t helper_FSEL(uint64_t a, uint64_t b, uint64_t c)
+uint64_t HELPER(FSEL)(uint64_t a, uint64_t b, uint64_t c)
 {
     CPU_DoubleU fa;
 
@@ -804,7 +804,7 @@ uint64_t helper_FSEL(uint64_t a, uint64_t b, uint64_t c)
     }
 }
 
-uint32_t helper_FTDIV(uint64_t fra, uint64_t frb)
+uint32_t HELPER(FTDIV)(uint64_t fra, uint64_t frb)
 {
     int fe_flag = 0;
     int fg_flag = 0;
@@ -840,7 +840,7 @@ uint32_t helper_FTDIV(uint64_t fra, uint64_t frb)
     return 0x8 | (fg_flag ? 4 : 0) | (fe_flag ? 2 : 0);
 }
 
-uint32_t helper_FTSQRT(uint64_t frb)
+uint32_t HELPER(FTSQRT)(uint64_t frb)
 {
     int fe_flag = 0;
     int fg_flag = 0;
@@ -871,7 +871,7 @@ uint32_t helper_FTSQRT(uint64_t frb)
     return 0x8 | (fg_flag ? 4 : 0) | (fe_flag ? 2 : 0);
 }
 
-void helper_FCMPU(CPUPPCState *env, uint64_t arg1, uint64_t arg2,
+void HELPER(FCMPU)(CPUPPCState *env, uint64_t arg1, uint64_t arg2,
                   uint32_t crfD)
 {
     CPU_DoubleU farg1, farg2;
@@ -902,7 +902,7 @@ void helper_FCMPU(CPUPPCState *env, uint64_t arg1, uint64_t arg2,
     }
 }
 
-void helper_FCMPO(CPUPPCState *env, uint64_t arg1, uint64_t arg2,
+void HELPER(FCMPO)(CPUPPCState *env, uint64_t arg1, uint64_t arg2,
                   uint32_t crfD)
 {
     CPU_DoubleU farg1, farg2;
@@ -1063,7 +1063,7 @@ static inline uint32_t efsctuf(CPUPPCState *env, uint32_t val)
 }
 
 #define HELPER_SPE_SINGLE_CONV(name)                              \
-    uint32_t helper_e##name(CPUPPCState *env, uint32_t val)       \
+    uint32_t HELPER(e##name)(CPUPPCState *env, uint32_t val)      \
     {                                                             \
         return e##name(env, val);                                 \
     }
@@ -1089,7 +1089,7 @@ HELPER_SPE_SINGLE_CONV(fsctsf);
 HELPER_SPE_SINGLE_CONV(fsctuf);
 
 #define HELPER_SPE_VECTOR_CONV(name)                            \
-    uint64_t helper_ev##name(CPUPPCState *env, uint64_t val)    \
+    uint64_t HELPER(ev##name)(CPUPPCState *env, uint64_t val)   \
     {                                                           \
         return ((uint64_t)e##name(env, val >> 32) << 32) |      \
             (uint64_t)e##name(env, val);                        \
@@ -1157,7 +1157,7 @@ static inline uint32_t efsdiv(CPUPPCState *env, uint32_t op1, uint32_t op2)
 }
 
 #define HELPER_SPE_SINGLE_ARITH(name)                                   \
-    uint32_t helper_e##name(CPUPPCState *env, uint32_t op1, uint32_t op2) \
+    uint32_t HELPER(e##name)(CPUPPCState *env, uint32_t op1, uint32_t op2) \
     {                                                                   \
         return e##name(env, op1, op2);                                  \
     }
@@ -1171,7 +1171,7 @@ HELPER_SPE_SINGLE_ARITH(fsmul);
 HELPER_SPE_SINGLE_ARITH(fsdiv);
 
 #define HELPER_SPE_VECTOR_ARITH(name)                                   \
-    uint64_t helper_ev##name(CPUPPCState *env, uint64_t op1, uint64_t op2) \
+    uint64_t HELPER(ev##name)(CPUPPCState *env, uint64_t op1, uint64_t op2) \
     {                                                                   \
         return ((uint64_t)e##name(env, op1 >> 32, op2 >> 32) << 32) |   \
             (uint64_t)e##name(env, op1, op2);                           \
@@ -1232,7 +1232,7 @@ static inline uint32_t efststeq(CPUPPCState *env, uint32_t op1, uint32_t op2)
 }
 
 #define HELPER_SINGLE_SPE_CMP(name)                                     \
-    uint32_t helper_e##name(CPUPPCState *env, uint32_t op1, uint32_t op2) \
+    uint32_t HELPER(e##name)(CPUPPCState *env, uint32_t op1, uint32_t op2) \
     {                                                                   \
         return e##name(env, op1, op2);                                  \
     }
@@ -1255,7 +1255,7 @@ static inline uint32_t evcmp_merge(int t0, int t1)
 }
 
 #define HELPER_VECTOR_SPE_CMP(name)                                     \
-    uint32_t helper_ev##name(CPUPPCState *env, uint64_t op1, uint64_t op2) \
+    uint32_t HELPER(ev##name)(CPUPPCState *env, uint64_t op1, uint64_t op2) \
     {                                                                   \
         return evcmp_merge(e##name(env, op1 >> 32, op2 >> 32),          \
                            e##name(env, op1, op2));                     \
@@ -1274,7 +1274,7 @@ HELPER_VECTOR_SPE_CMP(fscmpgt);
 HELPER_VECTOR_SPE_CMP(fscmpeq);
 
 /* Double-precision floating-point conversion */
-uint64_t helper_efdcfsi(CPUPPCState *env, uint32_t val)
+uint64_t HELPER(efdcfsi)(CPUPPCState *env, uint32_t val)
 {
     CPU_DoubleU u;
 
@@ -1283,7 +1283,7 @@ uint64_t helper_efdcfsi(CPUPPCState *env, uint32_t val)
     return u.ll;
 }
 
-uint64_t helper_efdcfsid(CPUPPCState *env, uint64_t val)
+uint64_t HELPER(efdcfsid)(CPUPPCState *env, uint64_t val)
 {
     CPU_DoubleU u;
 
@@ -1292,7 +1292,7 @@ uint64_t helper_efdcfsid(CPUPPCState *env, uint64_t val)
     return u.ll;
 }
 
-uint64_t helper_efdcfui(CPUPPCState *env, uint32_t val)
+uint64_t HELPER(efdcfui)(CPUPPCState *env, uint32_t val)
 {
     CPU_DoubleU u;
 
@@ -1301,7 +1301,7 @@ uint64_t helper_efdcfui(CPUPPCState *env, uint32_t val)
     return u.ll;
 }
 
-uint64_t helper_efdcfuid(CPUPPCState *env, uint64_t val)
+uint64_t HELPER(efdcfuid)(CPUPPCState *env, uint64_t val)
 {
     CPU_DoubleU u;
 
@@ -1310,7 +1310,7 @@ uint64_t helper_efdcfuid(CPUPPCState *env, uint64_t val)
     return u.ll;
 }
 
-uint32_t helper_efdctsi(CPUPPCState *env, uint64_t val)
+uint32_t HELPER(efdctsi)(CPUPPCState *env, uint64_t val)
 {
     CPU_DoubleU u;
 
@@ -1323,7 +1323,7 @@ uint32_t helper_efdctsi(CPUPPCState *env, uint64_t val)
     return float64_to_int32(u.d, &env->vec_status);
 }
 
-uint32_t helper_efdctui(CPUPPCState *env, uint64_t val)
+uint32_t HELPER(efdctui)(CPUPPCState *env, uint64_t val)
 {
     CPU_DoubleU u;
 
@@ -1336,7 +1336,7 @@ uint32_t helper_efdctui(CPUPPCState *env, uint64_t val)
     return float64_to_uint32(u.d, &env->vec_status);
 }
 
-uint32_t helper_efdctsiz(CPUPPCState *env, uint64_t val)
+uint32_t HELPER(efdctsiz)(CPUPPCState *env, uint64_t val)
 {
     CPU_DoubleU u;
 
@@ -1349,7 +1349,7 @@ uint32_t helper_efdctsiz(CPUPPCState *env, uint64_t val)
     return float64_to_int32_round_to_zero(u.d, &env->vec_status);
 }
 
-uint64_t helper_efdctsidz(CPUPPCState *env, uint64_t val)
+uint64_t HELPER(efdctsidz)(CPUPPCState *env, uint64_t val)
 {
     CPU_DoubleU u;
 
@@ -1362,7 +1362,7 @@ uint64_t helper_efdctsidz(CPUPPCState *env, uint64_t val)
     return float64_to_int64_round_to_zero(u.d, &env->vec_status);
 }
 
-uint32_t helper_efdctuiz(CPUPPCState *env, uint64_t val)
+uint32_t HELPER(efdctuiz)(CPUPPCState *env, uint64_t val)
 {
     CPU_DoubleU u;
 
@@ -1375,7 +1375,7 @@ uint32_t helper_efdctuiz(CPUPPCState *env, uint64_t val)
     return float64_to_uint32_round_to_zero(u.d, &env->vec_status);
 }
 
-uint64_t helper_efdctuidz(CPUPPCState *env, uint64_t val)
+uint64_t HELPER(efdctuidz)(CPUPPCState *env, uint64_t val)
 {
     CPU_DoubleU u;
 
@@ -1388,7 +1388,7 @@ uint64_t helper_efdctuidz(CPUPPCState *env, uint64_t val)
     return float64_to_uint64_round_to_zero(u.d, &env->vec_status);
 }
 
-uint64_t helper_efdcfsf(CPUPPCState *env, uint32_t val)
+uint64_t HELPER(efdcfsf)(CPUPPCState *env, uint32_t val)
 {
     CPU_DoubleU u;
     float64 tmp;
@@ -1400,7 +1400,7 @@ uint64_t helper_efdcfsf(CPUPPCState *env, uint32_t val)
     return u.ll;
 }
 
-uint64_t helper_efdcfuf(CPUPPCState *env, uint32_t val)
+uint64_t HELPER(efdcfuf)(CPUPPCState *env, uint32_t val)
 {
     CPU_DoubleU u;
     float64 tmp;
@@ -1412,7 +1412,7 @@ uint64_t helper_efdcfuf(CPUPPCState *env, uint32_t val)
     return u.ll;
 }
 
-uint32_t helper_efdctsf(CPUPPCState *env, uint64_t val)
+uint32_t HELPER(efdctsf)(CPUPPCState *env, uint64_t val)
 {
     CPU_DoubleU u;
     float64 tmp;
@@ -1428,7 +1428,7 @@ uint32_t helper_efdctsf(CPUPPCState *env, uint64_t val)
     return float64_to_int32(u.d, &env->vec_status);
 }
 
-uint32_t helper_efdctuf(CPUPPCState *env, uint64_t val)
+uint32_t HELPER(efdctuf)(CPUPPCState *env, uint64_t val)
 {
     CPU_DoubleU u;
     float64 tmp;
@@ -1444,7 +1444,7 @@ uint32_t helper_efdctuf(CPUPPCState *env, uint64_t val)
     return float64_to_uint32(u.d, &env->vec_status);
 }
 
-uint32_t helper_efscfd(CPUPPCState *env, uint64_t val)
+uint32_t HELPER(efscfd)(CPUPPCState *env, uint64_t val)
 {
     CPU_DoubleU u1;
     CPU_FloatU u2;
@@ -1455,7 +1455,7 @@ uint32_t helper_efscfd(CPUPPCState *env, uint64_t val)
     return u2.l;
 }
 
-uint64_t helper_efdcfs(CPUPPCState *env, uint32_t val)
+uint64_t HELPER(efdcfs)(CPUPPCState *env, uint32_t val)
 {
     CPU_DoubleU u2;
     CPU_FloatU u1;
@@ -1467,7 +1467,7 @@ uint64_t helper_efdcfs(CPUPPCState *env, uint32_t val)
 }
 
 /* Double precision fixed-point arithmetic */
-uint64_t helper_efdadd(CPUPPCState *env, uint64_t op1, uint64_t op2)
+uint64_t HELPER(efdadd)(CPUPPCState *env, uint64_t op1, uint64_t op2)
 {
     CPU_DoubleU u1, u2;
 
@@ -1477,7 +1477,7 @@ uint64_t helper_efdadd(CPUPPCState *env, uint64_t op1, uint64_t op2)
     return u1.ll;
 }
 
-uint64_t helper_efdsub(CPUPPCState *env, uint64_t op1, uint64_t op2)
+uint64_t HELPER(efdsub)(CPUPPCState *env, uint64_t op1, uint64_t op2)
 {
     CPU_DoubleU u1, u2;
 
@@ -1487,7 +1487,7 @@ uint64_t helper_efdsub(CPUPPCState *env, uint64_t op1, uint64_t op2)
     return u1.ll;
 }
 
-uint64_t helper_efdmul(CPUPPCState *env, uint64_t op1, uint64_t op2)
+uint64_t HELPER(efdmul)(CPUPPCState *env, uint64_t op1, uint64_t op2)
 {
     CPU_DoubleU u1, u2;
 
@@ -1497,7 +1497,7 @@ uint64_t helper_efdmul(CPUPPCState *env, uint64_t op1, uint64_t op2)
     return u1.ll;
 }
 
-uint64_t helper_efddiv(CPUPPCState *env, uint64_t op1, uint64_t op2)
+uint64_t HELPER(efddiv)(CPUPPCState *env, uint64_t op1, uint64_t op2)
 {
     CPU_DoubleU u1, u2;
 
@@ -1508,7 +1508,7 @@ uint64_t helper_efddiv(CPUPPCState *env, uint64_t op1, uint64_t op2)
 }
 
 /* Double precision floating point helpers */
-uint32_t helper_efdtstlt(CPUPPCState *env, uint64_t op1, uint64_t op2)
+uint32_t HELPER(efdtstlt)(CPUPPCState *env, uint64_t op1, uint64_t op2)
 {
     CPU_DoubleU u1, u2;
 
@@ -1517,7 +1517,7 @@ uint32_t helper_efdtstlt(CPUPPCState *env, uint64_t op1, uint64_t op2)
     return float64_lt(u1.d, u2.d, &env->vec_status) ? 4 : 0;
 }
 
-uint32_t helper_efdtstgt(CPUPPCState *env, uint64_t op1, uint64_t op2)
+uint32_t HELPER(efdtstgt)(CPUPPCState *env, uint64_t op1, uint64_t op2)
 {
     CPU_DoubleU u1, u2;
 
@@ -1526,7 +1526,7 @@ uint32_t helper_efdtstgt(CPUPPCState *env, uint64_t op1, uint64_t op2)
     return float64_le(u1.d, u2.d, &env->vec_status) ? 0 : 4;
 }
 
-uint32_t helper_efdtsteq(CPUPPCState *env, uint64_t op1, uint64_t op2)
+uint32_t HELPER(efdtsteq)(CPUPPCState *env, uint64_t op1, uint64_t op2)
 {
     CPU_DoubleU u1, u2;
 
@@ -1535,22 +1535,22 @@ uint32_t helper_efdtsteq(CPUPPCState *env, uint64_t op1, uint64_t op2)
     return float64_eq_quiet(u1.d, u2.d, &env->vec_status) ? 4 : 0;
 }
 
-uint32_t helper_efdcmplt(CPUPPCState *env, uint64_t op1, uint64_t op2)
+uint32_t HELPER(efdcmplt)(CPUPPCState *env, uint64_t op1, uint64_t op2)
 {
     /* XXX: TODO: test special values (NaN, infinites, ...) */
-    return helper_efdtstlt(env, op1, op2);
+    return HELPER(efdtstlt)(env, op1, op2);
 }
 
-uint32_t helper_efdcmpgt(CPUPPCState *env, uint64_t op1, uint64_t op2)
+uint32_t HELPER(efdcmpgt)(CPUPPCState *env, uint64_t op1, uint64_t op2)
 {
     /* XXX: TODO: test special values (NaN, infinites, ...) */
-    return helper_efdtstgt(env, op1, op2);
+    return HELPER(efdtstgt)(env, op1, op2);
 }
 
-uint32_t helper_efdcmpeq(CPUPPCState *env, uint64_t op1, uint64_t op2)
+uint32_t HELPER(efdcmpeq)(CPUPPCState *env, uint64_t op1, uint64_t op2)
 {
     /* XXX: TODO: test special values (NaN, infinites, ...) */
-    return helper_efdtsteq(env, op1, op2);
+    return HELPER(efdtsteq)(env, op1, op2);
 }
 
 #define float64_to_float64(x, env) x
@@ -1566,13 +1566,13 @@ uint32_t helper_efdcmpeq(CPUPPCState *env, uint64_t op1, uint64_t op2)
  *   sfifprf - set FI and FPRF
  */
 #define VSX_ADD_SUB(name, op, nels, tp, fld, sfifprf, r2sp)                  \
-void helper_##name(CPUPPCState *env, ppc_vsr_t *xt,                          \
+void HELPER(name)(CPUPPCState *env, ppc_vsr_t *xt,                           \
                    ppc_vsr_t *xa, ppc_vsr_t *xb)                             \
 {                                                                            \
     ppc_vsr_t t = { };                                                       \
     int i;                                                                   \
                                                                              \
-    helper_reset_fpstatus(env);                                              \
+    HELPER(reset_fpstatus)(env);                                             \
                                                                              \
     for (i = 0; i < nels; i++) {                                             \
         float_status tstat = env->fp_status;                                 \
@@ -1590,7 +1590,7 @@ void helper_##name(CPUPPCState *env, ppc_vsr_t *xt,                          \
         }                                                                    \
                                                                              \
         if (sfifprf) {                                                       \
-            helper_compute_fprf_float64(env, t.fld);                         \
+            HELPER(compute_fprf_float64)(env, t.fld);                        \
         }                                                                    \
     }                                                                        \
     *xt = t;                                                                 \
@@ -1606,13 +1606,13 @@ VSX_ADD_SUB(XSSUBSP, sub, 1, float64, VsrD(0), 1, 1)
 VSX_ADD_SUB(XVSUBDP, sub, 2, float64, VsrD(i), 0, 0)
 VSX_ADD_SUB(XVSUBSP, sub, 4, float32, VsrW(i), 0, 0)
 
-void helper_xsaddqp(CPUPPCState *env, uint32_t opcode,
+void HELPER(xsaddqp)(CPUPPCState *env, uint32_t opcode,
                     ppc_vsr_t *xt, ppc_vsr_t *xa, ppc_vsr_t *xb)
 {
     ppc_vsr_t t = *xt;
     float_status tstat;
 
-    helper_reset_fpstatus(env);
+    HELPER(reset_fpstatus)(env);
 
     tstat = env->fp_status;
     if (unlikely(Rc(opcode) != 0)) {
@@ -1627,7 +1627,7 @@ void helper_xsaddqp(CPUPPCState *env, uint32_t opcode,
         float_invalid_op_addsub(env, tstat.float_exception_flags, 1, GETPC());
     }
 
-    helper_compute_fprf_float128(env, t.f128);
+    HELPER(compute_fprf_float128)(env, t.f128);
 
     *xt = t;
     do_float_check_status(env, true, GETPC());
@@ -1642,13 +1642,13 @@ void helper_xsaddqp(CPUPPCState *env, uint32_t opcode,
  *   sfifprf - set FI and FPRF
  */
 #define VSX_MUL(op, nels, tp, fld, sfifprf, r2sp)                            \
-void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,                            \
+void HELPER(op)(CPUPPCState *env, ppc_vsr_t *xt,                             \
                  ppc_vsr_t *xa, ppc_vsr_t *xb)                               \
 {                                                                            \
     ppc_vsr_t t = { };                                                       \
     int i;                                                                   \
                                                                              \
-    helper_reset_fpstatus(env);                                              \
+    HELPER(reset_fpstatus)(env);                                             \
                                                                              \
     for (i = 0; i < nels; i++) {                                             \
         float_status tstat = env->fp_status;                                 \
@@ -1666,7 +1666,7 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,                            \
         }                                                                    \
                                                                              \
         if (sfifprf) {                                                       \
-            helper_compute_fprf_float64(env, t.fld);                         \
+            HELPER(compute_fprf_float64)(env, t.fld);                        \
         }                                                                    \
     }                                                                        \
                                                                              \
@@ -1679,13 +1679,13 @@ VSX_MUL(XSMULSP, 1, float64, VsrD(0), 1, 1)
 VSX_MUL(XVMULDP, 2, float64, VsrD(i), 0, 0)
 VSX_MUL(XVMULSP, 4, float32, VsrW(i), 0, 0)
 
-void helper_xsmulqp(CPUPPCState *env, uint32_t opcode,
+void HELPER(xsmulqp)(CPUPPCState *env, uint32_t opcode,
                     ppc_vsr_t *xt, ppc_vsr_t *xa, ppc_vsr_t *xb)
 {
     ppc_vsr_t t = *xt;
     float_status tstat;
 
-    helper_reset_fpstatus(env);
+    HELPER(reset_fpstatus)(env);
     tstat = env->fp_status;
     if (unlikely(Rc(opcode) != 0)) {
         set_float_rounding_mode(float_round_to_odd, &tstat);
@@ -1698,7 +1698,7 @@ void helper_xsmulqp(CPUPPCState *env, uint32_t opcode,
     if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {
         float_invalid_op_mul(env, tstat.float_exception_flags, 1, GETPC());
     }
-    helper_compute_fprf_float128(env, t.f128);
+    HELPER(compute_fprf_float128)(env, t.f128);
 
     *xt = t;
     do_float_check_status(env, true, GETPC());
@@ -1713,13 +1713,13 @@ void helper_xsmulqp(CPUPPCState *env, uint32_t opcode,
  *   sfifprf - set FI and FPRF
  */
 #define VSX_DIV(op, nels, tp, fld, sfifprf, r2sp)                             \
-void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,                             \
+void HELPER(op)(CPUPPCState *env, ppc_vsr_t *xt,                              \
                  ppc_vsr_t *xa, ppc_vsr_t *xb)                                \
 {                                                                             \
     ppc_vsr_t t = { };                                                        \
     int i;                                                                    \
                                                                               \
-    helper_reset_fpstatus(env);                                               \
+    HELPER(reset_fpstatus)(env);                                              \
                                                                               \
     for (i = 0; i < nels; i++) {                                              \
         float_status tstat = env->fp_status;                                  \
@@ -1740,7 +1740,7 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,                             \
         }                                                                     \
                                                                               \
         if (sfifprf) {                                                        \
-            helper_compute_fprf_float64(env, t.fld);                          \
+            HELPER(compute_fprf_float64)(env, t.fld);                         \
         }                                                                     \
     }                                                                         \
                                                                               \
@@ -1753,13 +1753,13 @@ VSX_DIV(XSDIVSP, 1, float64, VsrD(0), 1, 1)
 VSX_DIV(XVDIVDP, 2, float64, VsrD(i), 0, 0)
 VSX_DIV(XVDIVSP, 4, float32, VsrW(i), 0, 0)
 
-void helper_xsdivqp(CPUPPCState *env, uint32_t opcode,
+void HELPER(xsdivqp)(CPUPPCState *env, uint32_t opcode,
                     ppc_vsr_t *xt, ppc_vsr_t *xa, ppc_vsr_t *xb)
 {
     ppc_vsr_t t = *xt;
     float_status tstat;
 
-    helper_reset_fpstatus(env);
+    HELPER(reset_fpstatus)(env);
     tstat = env->fp_status;
     if (unlikely(Rc(opcode) != 0)) {
         set_float_rounding_mode(float_round_to_odd, &tstat);
@@ -1776,7 +1776,7 @@ void helper_xsdivqp(CPUPPCState *env, uint32_t opcode,
         float_zero_divide_excp(env, GETPC());
     }
 
-    helper_compute_fprf_float128(env, t.f128);
+    HELPER(compute_fprf_float128)(env, t.f128);
     *xt = t;
     do_float_check_status(env, true, GETPC());
 }
@@ -1790,12 +1790,12 @@ void helper_xsdivqp(CPUPPCState *env, uint32_t opcode,
  *   sfifprf - set FI and FPRF
  */
 #define VSX_RE(op, nels, tp, fld, sfifprf, r2sp)                              \
-void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)              \
+void HELPER(op)(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)               \
 {                                                                             \
     ppc_vsr_t t = { };                                                        \
     int i;                                                                    \
                                                                               \
-    helper_reset_fpstatus(env);                                               \
+    HELPER(reset_fpstatus)(env);                                              \
                                                                               \
     for (i = 0; i < nels; i++) {                                              \
         if (unlikely(tp##_is_signaling_nan(xb->fld, &env->fp_status))) {      \
@@ -1808,7 +1808,7 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)              \
         }                                                                     \
                                                                               \
         if (sfifprf) {                                                        \
-            helper_compute_fprf_float64(env, t.fld);                          \
+            HELPER(compute_fprf_float64)(env, t.fld);                         \
         }                                                                     \
     }                                                                         \
                                                                               \
@@ -1830,12 +1830,12 @@ VSX_RE(xvresp, 4, float32, VsrW(i), 0, 0)
  *   sfifprf - set FI and FPRF
  */
 #define VSX_SQRT(op, nels, tp, fld, sfifprf, r2sp)                           \
-void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)             \
+void HELPER(op)(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)              \
 {                                                                            \
     ppc_vsr_t t = { };                                                       \
     int i;                                                                   \
                                                                              \
-    helper_reset_fpstatus(env);                                              \
+    HELPER(reset_fpstatus)(env);                                             \
                                                                              \
     for (i = 0; i < nels; i++) {                                             \
         float_status tstat = env->fp_status;                                 \
@@ -1853,7 +1853,7 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)             \
         }                                                                    \
                                                                              \
         if (sfifprf) {                                                       \
-            helper_compute_fprf_float64(env, t.fld);                         \
+            HELPER(compute_fprf_float64)(env, t.fld);                        \
         }                                                                    \
     }                                                                        \
                                                                              \
@@ -1875,12 +1875,12 @@ VSX_SQRT(xvsqrtsp, 4, float32, VsrW(i), 0, 0)
  *   sfifprf - set FI and FPRF
  */
 #define VSX_RSQRTE(op, nels, tp, fld, sfifprf, r2sp)                         \
-void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)             \
+void HELPER(op)(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)              \
 {                                                                            \
     ppc_vsr_t t = { };                                                       \
     int i;                                                                   \
                                                                              \
-    helper_reset_fpstatus(env);                                              \
+    HELPER(reset_fpstatus)(env);                                             \
                                                                              \
     for (i = 0; i < nels; i++) {                                             \
         float_status tstat = env->fp_status;                                 \
@@ -1897,7 +1897,7 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)             \
         }                                                                    \
                                                                              \
         if (sfifprf) {                                                       \
-            helper_compute_fprf_float64(env, t.fld);                         \
+            HELPER(compute_fprf_float64)(env, t.fld);                        \
         }                                                                    \
     }                                                                        \
                                                                              \
@@ -1921,7 +1921,7 @@ VSX_RSQRTE(xvrsqrtesp, 4, float32, VsrW(i), 0, 0)
  *   nbits - number of fraction bits
  */
 #define VSX_TDIV(op, nels, tp, fld, emin, emax, nbits)                  \
-void helper_##op(CPUPPCState *env, uint32_t opcode,                     \
+void HELPER(op)(CPUPPCState *env, uint32_t opcode,                      \
                  ppc_vsr_t *xa, ppc_vsr_t *xb)                          \
 {                                                                       \
     int i;                                                              \
@@ -1978,7 +1978,7 @@ VSX_TDIV(xvtdivsp, 4, float32, VsrW(i), -126, 127, 23)
  *   nbits - number of fraction bits
  */
 #define VSX_TSQRT(op, nels, tp, fld, emin, nbits)                       \
-void helper_##op(CPUPPCState *env, uint32_t opcode, ppc_vsr_t *xb)      \
+void HELPER(op)(CPUPPCState *env, uint32_t opcode, ppc_vsr_t *xb)       \
 {                                                                       \
     int i;                                                              \
     int fe_flag = 0;                                                    \
@@ -2031,13 +2031,13 @@ VSX_TSQRT(xvtsqrtsp, 4, float32, VsrW(i), -126, 23)
  *   sfifprf - set FI and FPRF
  */
 #define VSX_MADD(op, nels, tp, fld, maddflgs, sfifprf)                        \
-void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,                             \
+void HELPER(op)(CPUPPCState *env, ppc_vsr_t *xt,                              \
                  ppc_vsr_t *s1, ppc_vsr_t *s2, ppc_vsr_t *s3)                 \
 {                                                                             \
     ppc_vsr_t t = { };                                                        \
     int i;                                                                    \
                                                                               \
-    helper_reset_fpstatus(env);                                               \
+    HELPER(reset_fpstatus)(env);                                              \
                                                                               \
     for (i = 0; i < nels; i++) {                                              \
         float_status tstat = env->fp_status;                                  \
@@ -2051,7 +2051,7 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,                             \
         }                                                                     \
                                                                               \
         if (sfifprf) {                                                        \
-            helper_compute_fprf_float64(env, t.fld);                          \
+            HELPER(compute_fprf_float64)(env, t.fld);                         \
         }                                                                     \
     }                                                                         \
     *xt = t;                                                                  \
@@ -2085,12 +2085,12 @@ VSX_MADD(xvnmsubsp, 4, float32, VsrW(i), NMSUB_FLGS, 0)
  *   ro    - round to odd
  */
 #define VSX_MADDQ(op, maddflgs, ro)                                            \
-void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *s1, ppc_vsr_t *s2,\
+void HELPER(op)(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *s1, ppc_vsr_t *s2, \
                  ppc_vsr_t *s3)                                                \
 {                                                                              \
     ppc_vsr_t t = *xt;                                                         \
                                                                                \
-    helper_reset_fpstatus(env);                                                \
+    HELPER(reset_fpstatus)(env);                                               \
                                                                                \
     float_status tstat = env->fp_status;                                       \
     set_float_exception_flags(0, &tstat);                                      \
@@ -2105,7 +2105,7 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *s1, ppc_vsr_t *s2,\
                               false, GETPC());                                 \
     }                                                                          \
                                                                                \
-    helper_compute_fprf_float128(env, t.f128);                                 \
+    HELPER(compute_fprf_float128)(env, t.f128);                                \
     *xt = t;                                                                   \
     do_float_check_status(env, true, GETPC());                                 \
 }
@@ -2128,13 +2128,13 @@ VSX_MADDQ(XSNMSUBQPO, NMSUB_FLGS, 0)
  *   svxvc - set VXVC bit
  */
 #define VSX_SCALAR_CMP(op, tp, cmp, fld, svxvc)                               \
-        void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,                     \
+        void HELPER(op)(CPUPPCState *env, ppc_vsr_t *xt,                      \
                 ppc_vsr_t *xa, ppc_vsr_t *xb)                                 \
 {                                                                             \
     int flags;                                                                \
     bool r, vxvc;                                                             \
                                                                               \
-    helper_reset_fpstatus(env);                                               \
+    HELPER(reset_fpstatus)(env);                                              \
                                                                               \
     if (svxvc) {                                                              \
         r = tp##_##cmp(xb->fld, xa->fld, &env->fp_status);                    \
@@ -2166,7 +2166,7 @@ VSX_SCALAR_CMP(XSCMPEQQP, float128, eq, f128, 0)
 VSX_SCALAR_CMP(XSCMPGEQP, float128, le, f128, 1)
 VSX_SCALAR_CMP(XSCMPGTQP, float128, lt, f128, 1)
 
-void helper_xscmpexpdp(CPUPPCState *env, uint32_t opcode,
+void HELPER(xscmpexpdp)(CPUPPCState *env, uint32_t opcode,
                        ppc_vsr_t *xa, ppc_vsr_t *xb)
 {
     int64_t exp_a, exp_b;
@@ -2195,7 +2195,7 @@ void helper_xscmpexpdp(CPUPPCState *env, uint32_t opcode,
     do_float_check_status(env, false, GETPC());
 }
 
-void helper_xscmpexpqp(CPUPPCState *env, uint32_t opcode,
+void HELPER(xscmpexpqp)(CPUPPCState *env, uint32_t opcode,
                        ppc_vsr_t *xa, ppc_vsr_t *xb)
 {
     int64_t exp_a, exp_b;
@@ -2230,7 +2230,7 @@ static inline void do_scalar_cmp(CPUPPCState *env, ppc_vsr_t *xa, ppc_vsr_t *xb,
     uint32_t cc;
     bool vxsnan_flag = false, vxvc_flag = false;
 
-    helper_reset_fpstatus(env);
+    HELPER(reset_fpstatus)(env);
 
     switch (float64_compare(xa->VsrD(0), xb->VsrD(0), &env->fp_status)) {
     case float_relation_less:
@@ -2277,13 +2277,13 @@ static inline void do_scalar_cmp(CPUPPCState *env, ppc_vsr_t *xa, ppc_vsr_t *xb,
     do_float_check_status(env, false, GETPC());
 }
 
-void helper_xscmpodp(CPUPPCState *env, uint32_t opcode, ppc_vsr_t *xa,
+void HELPER(xscmpodp)(CPUPPCState *env, uint32_t opcode, ppc_vsr_t *xa,
                      ppc_vsr_t *xb)
 {
     do_scalar_cmp(env, xa, xb, BF(opcode), true);
 }
 
-void helper_xscmpudp(CPUPPCState *env, uint32_t opcode, ppc_vsr_t *xa,
+void HELPER(xscmpudp)(CPUPPCState *env, uint32_t opcode, ppc_vsr_t *xa,
                      ppc_vsr_t *xb)
 {
     do_scalar_cmp(env, xa, xb, BF(opcode), false);
@@ -2295,7 +2295,7 @@ static inline void do_scalar_cmpq(CPUPPCState *env, ppc_vsr_t *xa,
     uint32_t cc;
     bool vxsnan_flag = false, vxvc_flag = false;
 
-    helper_reset_fpstatus(env);
+    HELPER(reset_fpstatus)(env);
 
     switch (float128_compare(xa->f128, xb->f128, &env->fp_status)) {
     case float_relation_less:
@@ -2342,13 +2342,13 @@ static inline void do_scalar_cmpq(CPUPPCState *env, ppc_vsr_t *xa,
     do_float_check_status(env, false, GETPC());
 }
 
-void helper_xscmpoqp(CPUPPCState *env, uint32_t opcode, ppc_vsr_t *xa,
+void HELPER(xscmpoqp)(CPUPPCState *env, uint32_t opcode, ppc_vsr_t *xa,
                      ppc_vsr_t *xb)
 {
     do_scalar_cmpq(env, xa, xb, BF(opcode), true);
 }
 
-void helper_xscmpuqp(CPUPPCState *env, uint32_t opcode, ppc_vsr_t *xa,
+void HELPER(xscmpuqp)(CPUPPCState *env, uint32_t opcode, ppc_vsr_t *xa,
                      ppc_vsr_t *xb)
 {
     do_scalar_cmpq(env, xa, xb, BF(opcode), false);
@@ -2363,7 +2363,7 @@ void helper_xscmpuqp(CPUPPCState *env, uint32_t opcode, ppc_vsr_t *xa,
  *   fld   - vsr_t field (VsrD(*) or VsrW(*))
  */
 #define VSX_MAX_MIN(name, op, nels, tp, fld)                                  \
-void helper_##name(CPUPPCState *env, ppc_vsr_t *xt,                           \
+void HELPER(name)(CPUPPCState *env, ppc_vsr_t *xt,                            \
                    ppc_vsr_t *xa, ppc_vsr_t *xb)                              \
 {                                                                             \
     ppc_vsr_t t = { };                                                        \
@@ -2389,13 +2389,13 @@ VSX_MAX_MIN(XVMINDP, minnum, 2, float64, VsrD(i))
 VSX_MAX_MIN(XVMINSP, minnum, 4, float32, VsrW(i))
 
 #define VSX_MAX_MINC(name, max, tp, fld)                                      \
-void helper_##name(CPUPPCState *env,                                          \
+void HELPER(name)(CPUPPCState *env,                                           \
                    ppc_vsr_t *xt, ppc_vsr_t *xa, ppc_vsr_t *xb)               \
 {                                                                             \
     ppc_vsr_t t = { };                                                        \
     bool first;                                                               \
                                                                               \
-    helper_reset_fpstatus(env);                                               \
+    HELPER(reset_fpstatus)(env);                                              \
                                                                               \
     if (max) {                                                                \
         first = tp##_le_quiet(xb->fld, xa->fld, &env->fp_status);             \
@@ -2421,7 +2421,7 @@ VSX_MAX_MINC(XSMAXCQP, true, float128, f128);
 VSX_MAX_MINC(XSMINCQP, false, float128, f128);
 
 #define VSX_MAX_MINJ(name, max)                                               \
-void helper_##name(CPUPPCState *env,                                          \
+void HELPER(name)(CPUPPCState *env,                                           \
                    ppc_vsr_t *xt, ppc_vsr_t *xa, ppc_vsr_t *xb)               \
 {                                                                             \
     ppc_vsr_t t = { };                                                        \
@@ -2486,7 +2486,7 @@ VSX_MAX_MINJ(XSMINJDP, 0);
  *   exp   - expected result of comparison
  */
 #define VSX_CMP(op, nels, tp, fld, cmp, svxvc, exp)                       \
-uint32_t helper_##op(CPUPPCState *env, ppc_vsr_t *xt,                     \
+uint32_t HELPER(op)(CPUPPCState *env, ppc_vsr_t *xt,                      \
                      ppc_vsr_t *xa, ppc_vsr_t *xb)                        \
 {                                                                         \
     ppc_vsr_t t = *xt;                                                    \
@@ -2495,7 +2495,7 @@ uint32_t helper_##op(CPUPPCState *env, ppc_vsr_t *xt,                     \
     int all_true = 1;                                                     \
     int all_false = 1;                                                    \
                                                                           \
-    helper_reset_fpstatus(env);                                           \
+    HELPER(reset_fpstatus)(env);                                          \
                                                                           \
     for (i = 0; i < nels; i++) {                                          \
         if (unlikely(tp##_is_any_nan(xa->fld) ||                          \
@@ -2545,12 +2545,12 @@ VSX_CMP(XVCMPNESP, 4, float32, VsrW(i), eq, 0, 0)
  *   sfifprf - set FI and FPRF
  */
 #define VSX_CVT_FP_TO_FP(op, nels, stp, ttp, sfld, tfld, sfifprf)  \
-void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)   \
+void HELPER(op)(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)    \
 {                                                                  \
     ppc_vsr_t t = { };                                             \
     int i;                                                         \
                                                                    \
-    helper_reset_fpstatus(env);                                    \
+    HELPER(reset_fpstatus)(env);                                   \
                                                                    \
     for (i = 0; i < nels; i++) {                                   \
         t.tfld = stp##_to_##ttp(xb->sfld, &env->fp_status);        \
@@ -2560,7 +2560,7 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)   \
             t.tfld = ttp##_snan_to_qnan(t.tfld);                   \
         }                                                          \
         if (sfifprf) {                                             \
-            helper_compute_fprf_##ttp(env, t.tfld);                \
+            HELPER(compute_fprf_##ttp)(env, t.tfld);               \
         }                                                          \
     }                                                              \
                                                                    \
@@ -2572,12 +2572,12 @@ VSX_CVT_FP_TO_FP(xscvspdp, 1, float32, float64, VsrW(0), VsrD(0), 1)
 VSX_CVT_FP_TO_FP(xvcvspdp, 2, float32, float64, VsrW(2 * i), VsrD(i), 0)
 
 #define VSX_CVT_FP_TO_FP2(op, nels, stp, ttp, sfifprf)                \
-void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)      \
+void HELPER(op)(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)       \
 {                                                                     \
     ppc_vsr_t t = { };                                                \
     int i;                                                            \
                                                                       \
-    helper_reset_fpstatus(env);                                       \
+    HELPER(reset_fpstatus)(env);                                      \
                                                                       \
     for (i = 0; i < nels; i++) {                                      \
         t.VsrW(2 * i) = stp##_to_##ttp(xb->VsrD(i), &env->fp_status); \
@@ -2587,7 +2587,7 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)      \
             t.VsrW(2 * i) = ttp##_snan_to_qnan(t.VsrW(2 * i));        \
         }                                                             \
         if (sfifprf) {                                                \
-            helper_compute_fprf_##ttp(env, t.VsrW(2 * i));            \
+            HELPER(compute_fprf_##ttp)(env, t.VsrW(2 * i));           \
         }                                                             \
         t.VsrW(2 * i + 1) = t.VsrW(2 * i);                            \
     }                                                                 \
@@ -2610,13 +2610,13 @@ VSX_CVT_FP_TO_FP2(xscvdpsp, 1, float64, float32, 1)
  *   sfprf - set FPRF
  */
 #define VSX_CVT_FP_TO_FP_VECTOR(op, nels, stp, ttp, sfld, tfld, sfprf)  \
-void helper_##op(CPUPPCState *env, uint32_t opcode,                     \
+void HELPER(op)(CPUPPCState *env, uint32_t opcode,                      \
                  ppc_vsr_t *xt, ppc_vsr_t *xb)                          \
 {                                                                       \
     ppc_vsr_t t = *xt;                                                  \
     int i;                                                              \
                                                                         \
-    helper_reset_fpstatus(env);                                         \
+    HELPER(reset_fpstatus)(env);                                        \
                                                                         \
     for (i = 0; i < nels; i++) {                                        \
         t.tfld = stp##_to_##ttp(xb->sfld, &env->fp_status);             \
@@ -2626,7 +2626,7 @@ void helper_##op(CPUPPCState *env, uint32_t opcode,                     \
             t.tfld = ttp##_snan_to_qnan(t.tfld);                        \
         }                                                               \
         if (sfprf) {                                                    \
-            helper_compute_fprf_##ttp(env, t.tfld);                     \
+            HELPER(compute_fprf_##ttp)(env, t.tfld);                    \
         }                                                               \
     }                                                                   \
                                                                         \
@@ -2648,12 +2648,12 @@ VSX_CVT_FP_TO_FP_VECTOR(xscvdpqp, 1, float64, float128, VsrD(0), f128, 1)
  *   sfifprf - set FI and FPRF
  */
 #define VSX_CVT_FP_TO_FP_HP(op, nels, stp, ttp, sfld, tfld, sfifprf) \
-void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)   \
+void HELPER(op)(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)    \
 {                                                                  \
     ppc_vsr_t t = { };                                             \
     int i;                                                         \
                                                                    \
-    helper_reset_fpstatus(env);                                    \
+    HELPER(reset_fpstatus)(env);                                   \
                                                                    \
     for (i = 0; i < nels; i++) {                                   \
         t.tfld = stp##_to_##ttp(xb->sfld, 1, &env->fp_status);     \
@@ -2663,7 +2663,7 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)   \
             t.tfld = ttp##_snan_to_qnan(t.tfld);                   \
         }                                                          \
         if (sfifprf) {                                             \
-            helper_compute_fprf_##ttp(env, t.tfld);                \
+            HELPER(compute_fprf_##ttp)(env, t.tfld);               \
         }                                                          \
     }                                                              \
                                                                    \
@@ -2676,12 +2676,12 @@ VSX_CVT_FP_TO_FP_HP(xscvhpdp, 1, float16, float64, VsrH(3), VsrD(0), 1)
 VSX_CVT_FP_TO_FP_HP(xvcvsphp, 4, float32, float16, VsrW(i), VsrH(2 * i  + 1), 0)
 VSX_CVT_FP_TO_FP_HP(xvcvhpsp, 4, float16, float32, VsrH(2 * i + 1), VsrW(i), 0)
 
-void helper_XVCVSPBF16(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)
+void HELPER(XVCVSPBF16)(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)
 {
     ppc_vsr_t t = { };
     int i, status;
 
-    helper_reset_fpstatus(env);
+    HELPER(reset_fpstatus)(env);
 
     for (i = 0; i < 4; i++) {
         t.VsrH(2 * i + 1) = float32_to_bfloat16(xb->VsrW(i), &env->fp_status);
@@ -2696,13 +2696,13 @@ void helper_XVCVSPBF16(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)
     do_float_check_status(env, false, GETPC());
 }
 
-void helper_XSCVQPDP(CPUPPCState *env, uint32_t ro, ppc_vsr_t *xt,
+void HELPER(XSCVQPDP)(CPUPPCState *env, uint32_t ro, ppc_vsr_t *xt,
                      ppc_vsr_t *xb)
 {
     ppc_vsr_t t = { };
     float_status tstat;
 
-    helper_reset_fpstatus(env);
+    HELPER(reset_fpstatus)(env);
 
     tstat = env->fp_status;
     if (ro != 0) {
@@ -2715,17 +2715,17 @@ void helper_XSCVQPDP(CPUPPCState *env, uint32_t ro, ppc_vsr_t *xt,
         float_invalid_op_vxsnan(env, GETPC());
         t.VsrD(0) = float64_snan_to_qnan(t.VsrD(0));
     }
-    helper_compute_fprf_float64(env, t.VsrD(0));
+    HELPER(compute_fprf_float64)(env, t.VsrD(0));
 
     *xt = t;
     do_float_check_status(env, true, GETPC());
 }
 
-uint64_t helper_xscvdpspn(CPUPPCState *env, uint64_t xb)
+uint64_t HELPER(xscvdpspn)(CPUPPCState *env, uint64_t xb)
 {
     uint64_t result, sign, exp, frac;
 
-    helper_reset_fpstatus(env);
+    HELPER(reset_fpstatus)(env);
     float_status tstat = env->fp_status;
     set_float_exception_flags(0, &tstat);
 
@@ -2762,9 +2762,9 @@ uint64_t helper_xscvdpspn(CPUPPCState *env, uint64_t xb)
     return (result << 32) | result;
 }
 
-uint64_t helper_XSCVSPDPN(uint64_t xb)
+uint64_t HELPER(XSCVSPDPN)(uint64_t xb)
 {
-    return helper_todouble(xb >> 32);
+    return HELPER(todouble)(xb >> 32);
 }
 
 /*
@@ -2779,14 +2779,14 @@ uint64_t helper_XSCVSPDPN(uint64_t xb)
  *   rnan  - resulting NaN
  */
 #define VSX_CVT_FP_TO_INT(op, nels, stp, ttp, sfld, tfld, sfi, rnan)         \
-void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)             \
+void HELPER(op)(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)              \
 {                                                                            \
     int all_flags = 0;                                                       \
     ppc_vsr_t t = { };                                                       \
     int i, flags;                                                            \
                                                                              \
     for (i = 0; i < nels; i++) {                                             \
-        helper_reset_fpstatus(env);                                          \
+        HELPER(reset_fpstatus)(env);                                         \
         t.tfld = stp##_to_##ttp##_round_to_zero(xb->sfld, &env->fp_status);  \
         flags = env->fp_status.float_exception_flags;                        \
         all_flags |= flags;                                                  \
@@ -2816,12 +2816,12 @@ VSX_CVT_FP_TO_INT(xvcvspuxds, 2, float32, uint64, VsrW(2 * i), VsrD(i), \
 VSX_CVT_FP_TO_INT(xvcvspuxws, 4, float32, uint32, VsrW(i), VsrW(i), false, 0U)
 
 #define VSX_CVT_FP_TO_INT128(op, tp, rnan)                                     \
-void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)               \
+void HELPER(op)(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)                \
 {                                                                              \
     ppc_vsr_t t;                                                               \
     int flags;                                                                 \
                                                                                \
-    helper_reset_fpstatus(env);                                                \
+    HELPER(reset_fpstatus)(env);                                               \
     t.s128 = float128_to_##tp##_round_to_zero(xb->f128, &env->fp_status);      \
     flags = get_float_exception_flags(&env->fp_status);                        \
     if (unlikely(flags & float_flag_invalid)) {                                \
@@ -2846,14 +2846,14 @@ VSX_CVT_FP_TO_INT128(XSCVQPSQZ, int128, 0x8000000000000000ULL);
  *     is required by this version of the architecture.
  */
 #define VSX_CVT_FP_TO_INT2(op, nels, stp, ttp, sfi, rnan)                    \
-void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)             \
+void HELPER(op)(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)              \
 {                                                                            \
     int all_flags = 0;                                                       \
     ppc_vsr_t t = { };                                                       \
     int i, flags;                                                            \
                                                                              \
     for (i = 0; i < nels; i++) {                                             \
-        helper_reset_fpstatus(env);                                          \
+        HELPER(reset_fpstatus)(env);                                         \
         t.VsrW(2 * i) = stp##_to_##ttp##_round_to_zero(xb->VsrD(i),          \
                                                        &env->fp_status);     \
         flags = env->fp_status.float_exception_flags;                        \
@@ -2885,13 +2885,13 @@ VSX_CVT_FP_TO_INT2(xvcvdpuxws, 2, float64, uint32, false, 0U)
  *   rnan  - resulting NaN
  */
 #define VSX_CVT_FP_TO_INT_VECTOR(op, stp, ttp, sfld, tfld, rnan)             \
-void helper_##op(CPUPPCState *env, uint32_t opcode,                          \
+void HELPER(op)(CPUPPCState *env, uint32_t opcode,                           \
                  ppc_vsr_t *xt, ppc_vsr_t *xb)                               \
 {                                                                            \
     ppc_vsr_t t = { };                                                       \
     int flags;                                                               \
                                                                              \
-    helper_reset_fpstatus(env);                                              \
+    HELPER(reset_fpstatus)(env);                                             \
                                                                              \
     t.tfld = stp##_to_##ttp##_round_to_zero(xb->sfld, &env->fp_status);      \
     flags = get_float_exception_flags(&env->fp_status);                      \
@@ -2922,12 +2922,12 @@ VSX_CVT_FP_TO_INT_VECTOR(xscvqpuwz, float128, uint32, f128, VsrD(0), 0x0ULL)
  *   sfifprf - set FI and FPRF
  */
 #define VSX_CVT_INT_TO_FP(op, nels, stp, ttp, sfld, tfld, sfifprf, r2sp)\
-void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)        \
+void HELPER(op)(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)         \
 {                                                                       \
     ppc_vsr_t t = { };                                                  \
     int i;                                                              \
                                                                         \
-    helper_reset_fpstatus(env);                                         \
+    HELPER(reset_fpstatus)(env);                                        \
                                                                         \
     for (i = 0; i < nels; i++) {                                        \
         t.tfld = stp##_to_##ttp(xb->sfld, &env->fp_status);             \
@@ -2935,7 +2935,7 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)        \
             t.tfld = do_frsp(env, t.tfld, GETPC());                     \
         }                                                               \
         if (sfifprf) {                                                  \
-            helper_compute_fprf_float64(env, t.tfld);                   \
+            HELPER(compute_fprf_float64)(env, t.tfld);                  \
         }                                                               \
     }                                                                   \
                                                                         \
@@ -2955,7 +2955,7 @@ VSX_CVT_INT_TO_FP(xvcvsxwsp, 4, int32, float32, VsrW(i), VsrW(i), 0, 0)
 VSX_CVT_INT_TO_FP(xvcvuxwsp, 4, uint32, float32, VsrW(i), VsrW(i), 0, 0)
 
 #define VSX_CVT_INT_TO_FP2(op, stp, ttp)                                \
-void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)        \
+void HELPER(op)(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)         \
 {                                                                       \
     ppc_vsr_t t = { };                                                  \
     int i;                                                              \
@@ -2973,11 +2973,11 @@ VSX_CVT_INT_TO_FP2(xvcvsxdsp, int64, float32)
 VSX_CVT_INT_TO_FP2(xvcvuxdsp, uint64, float32)
 
 #define VSX_CVT_INT128_TO_FP(op, tp)                            \
-void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)\
+void HELPER(op)(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb) \
 {                                                               \
-    helper_reset_fpstatus(env);                                 \
+    HELPER(reset_fpstatus)(env);                                \
     xt->f128 = tp##_to_float128(xb->s128, &env->fp_status);     \
-    helper_compute_fprf_float128(env, xt->f128);                \
+    HELPER(compute_fprf_float128)(env, xt->f128);               \
     do_float_check_status(env, true, GETPC());                  \
 }
 
@@ -2993,14 +2993,14 @@ VSX_CVT_INT128_TO_FP(XSCVSQQP, int128);
  *   tfld  - target vsr_t field
  */
 #define VSX_CVT_INT_TO_FP_VECTOR(op, stp, ttp, sfld, tfld)              \
-void helper_##op(CPUPPCState *env, uint32_t opcode,                     \
+void HELPER(op)(CPUPPCState *env, uint32_t opcode,                      \
                  ppc_vsr_t *xt, ppc_vsr_t *xb)                          \
 {                                                                       \
     ppc_vsr_t t = *xt;                                                  \
                                                                         \
-    helper_reset_fpstatus(env);                                         \
+    HELPER(reset_fpstatus)(env);                                        \
     t.tfld = stp##_to_##ttp(xb->sfld, &env->fp_status);                 \
-    helper_compute_fprf_##ttp(env, t.tfld);                             \
+    HELPER(compute_fprf_##ttp)(env, t.tfld);                            \
                                                                         \
     *xt = t;                                                            \
     do_float_check_status(env, true, GETPC());                          \
@@ -3026,13 +3026,13 @@ VSX_CVT_INT_TO_FP_VECTOR(xscvudqp, uint64, float128, VsrD(0), f128)
  *   sfifprf - set FI and FPRF
  */
 #define VSX_ROUND(op, nels, tp, fld, rmode, sfifprf)                   \
-void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)       \
+void HELPER(op)(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)        \
 {                                                                      \
     ppc_vsr_t t = { };                                                 \
     int i;                                                             \
     FloatRoundMode curr_rounding_mode;                                 \
                                                                        \
-    helper_reset_fpstatus(env);                                        \
+    HELPER(reset_fpstatus)(env);                                       \
                                                                        \
     if (rmode != FLOAT_ROUND_CURRENT) {                                \
         curr_rounding_mode = get_float_rounding_mode(&env->fp_status); \
@@ -3048,7 +3048,7 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)       \
             t.fld = tp##_round_to_int(xb->fld, &env->fp_status);       \
         }                                                              \
         if (sfifprf) {                                                 \
-            helper_compute_fprf_float64(env, t.fld);                   \
+            HELPER(compute_fprf_float64)(env, t.fld);                  \
         }                                                              \
     }                                                                  \
                                                                        \
@@ -3084,18 +3084,18 @@ VSX_ROUND(xvrspim, 4, float32, VsrW(i), float_round_down, 0)
 VSX_ROUND(xvrspip, 4, float32, VsrW(i), float_round_up, 0)
 VSX_ROUND(xvrspiz, 4, float32, VsrW(i), float_round_to_zero, 0)
 
-uint64_t helper_xsrsp(CPUPPCState *env, uint64_t xb)
+uint64_t HELPER(xsrsp)(CPUPPCState *env, uint64_t xb)
 {
-    helper_reset_fpstatus(env);
+    HELPER(reset_fpstatus)(env);
 
     uint64_t xt = do_frsp(env, xb, GETPC());
 
-    helper_compute_fprf_float64(env, xt);
+    HELPER(compute_fprf_float64)(env, xt);
     do_float_check_status(env, true, GETPC());
     return xt;
 }
 
-void helper_XVXSIGSP(ppc_vsr_t *xt, ppc_vsr_t *xb)
+void HELPER(XVXSIGSP)(ppc_vsr_t *xt, ppc_vsr_t *xb)
 {
     ppc_vsr_t t = { };
     uint32_t exp, i, fraction;
@@ -3134,7 +3134,7 @@ VSX_TSTDC(float64)
 VSX_TSTDC(float128)
 #undef VSX_TSTDC
 
-void helper_XVTSTDCDP(ppc_vsr_t *t, ppc_vsr_t *b, uint64_t dcmx, uint32_t v)
+void HELPER(XVTSTDCDP)(ppc_vsr_t *t, ppc_vsr_t *b, uint64_t dcmx, uint32_t v)
 {
     int i;
     for (i = 0; i < 2; i++) {
@@ -3142,7 +3142,7 @@ void helper_XVTSTDCDP(ppc_vsr_t *t, ppc_vsr_t *b, uint64_t dcmx, uint32_t v)
     }
 }
 
-void helper_XVTSTDCSP(ppc_vsr_t *t, ppc_vsr_t *b, uint64_t dcmx, uint32_t v)
+void HELPER(XVTSTDCSP)(ppc_vsr_t *t, ppc_vsr_t *b, uint64_t dcmx, uint32_t v)
 {
     int i;
     for (i = 0; i < 4; i++) {
@@ -3152,7 +3152,7 @@ void helper_XVTSTDCSP(ppc_vsr_t *t, ppc_vsr_t *b, uint64_t dcmx, uint32_t v)
 
 static bool not_SP_value(float64 val)
 {
-    return val != helper_todouble(helper_tosingle(val));
+    return val != HELPER(todouble)(HELPER(tosingle)(val));
 }
 
 /*
@@ -3162,7 +3162,7 @@ static bool not_SP_value(float64 val)
  *   TP    - type (float64 or float128)
  */
 #define VSX_XS_TSTDC(NAME, FLD, TP)                                         \
-    void helper_##NAME(CPUPPCState *env, uint32_t bf,                       \
+    void HELPER(NAME)(CPUPPCState *env, uint32_t bf,                        \
                        uint32_t dcmx, ppc_vsr_t *b)                         \
     {                                                                       \
         uint32_t cc, match, sign = TP##_is_neg(b->FLD);                     \
@@ -3177,7 +3177,7 @@ VSX_XS_TSTDC(XSTSTDCDP, VsrD(0), float64)
 VSX_XS_TSTDC(XSTSTDCQP, f128, float128)
 #undef VSX_XS_TSTDC
 
-void helper_XSTSTDCSP(CPUPPCState *env, uint32_t bf,
+void HELPER(XSTSTDCSP)(CPUPPCState *env, uint32_t bf,
                       uint32_t dcmx, ppc_vsr_t *b)
 {
     uint32_t cc, match, sign = float64_is_neg(b->VsrD(0));
@@ -3190,7 +3190,7 @@ void helper_XSTSTDCSP(CPUPPCState *env, uint32_t bf,
     env->crf[bf] = cc;
 }
 
-void helper_xsrqpi(CPUPPCState *env, uint32_t opcode,
+void HELPER(xsrqpi)(CPUPPCState *env, uint32_t opcode,
                    ppc_vsr_t *xt, ppc_vsr_t *xb)
 {
     ppc_vsr_t t = { };
@@ -3200,7 +3200,7 @@ void helper_xsrqpi(CPUPPCState *env, uint32_t opcode,
     uint8_t rmode = 0;
     float_status tstat;
 
-    helper_reset_fpstatus(env);
+    HELPER(reset_fpstatus)(env);
 
     if (r == 0 && rmc == 0) {
         rmode = float_round_ties_away;
@@ -3239,12 +3239,12 @@ void helper_xsrqpi(CPUPPCState *env, uint32_t opcode,
         env->fp_status.float_exception_flags &= ~float_flag_inexact;
     }
 
-    helper_compute_fprf_float128(env, t.f128);
+    HELPER(compute_fprf_float128)(env, t.f128);
     do_float_check_status(env, true, GETPC());
     *xt = t;
 }
 
-void helper_xsrqpxp(CPUPPCState *env, uint32_t opcode,
+void HELPER(xsrqpxp)(CPUPPCState *env, uint32_t opcode,
                     ppc_vsr_t *xt, ppc_vsr_t *xb)
 {
     ppc_vsr_t t = { };
@@ -3254,7 +3254,7 @@ void helper_xsrqpxp(CPUPPCState *env, uint32_t opcode,
     floatx80 round_res;
     float_status tstat;
 
-    helper_reset_fpstatus(env);
+    HELPER(reset_fpstatus)(env);
 
     if (r == 0 && rmc == 0) {
         rmode = float_round_ties_away;
@@ -3291,18 +3291,18 @@ void helper_xsrqpxp(CPUPPCState *env, uint32_t opcode,
         t.f128 = float128_snan_to_qnan(t.f128);
     }
 
-    helper_compute_fprf_float128(env, t.f128);
+    HELPER(compute_fprf_float128)(env, t.f128);
     *xt = t;
     do_float_check_status(env, true, GETPC());
 }
 
-void helper_xssqrtqp(CPUPPCState *env, uint32_t opcode,
+void HELPER(xssqrtqp)(CPUPPCState *env, uint32_t opcode,
                      ppc_vsr_t *xt, ppc_vsr_t *xb)
 {
     ppc_vsr_t t = { };
     float_status tstat;
 
-    helper_reset_fpstatus(env);
+    HELPER(reset_fpstatus)(env);
 
     tstat = env->fp_status;
     if (unlikely(Rc(opcode) != 0)) {
@@ -3317,18 +3317,18 @@ void helper_xssqrtqp(CPUPPCState *env, uint32_t opcode,
         float_invalid_op_sqrt(env, tstat.float_exception_flags, 1, GETPC());
     }
 
-    helper_compute_fprf_float128(env, t.f128);
+    HELPER(compute_fprf_float128)(env, t.f128);
     *xt = t;
     do_float_check_status(env, true, GETPC());
 }
 
-void helper_xssubqp(CPUPPCState *env, uint32_t opcode,
+void HELPER(xssubqp)(CPUPPCState *env, uint32_t opcode,
                     ppc_vsr_t *xt, ppc_vsr_t *xa, ppc_vsr_t *xb)
 {
     ppc_vsr_t t = *xt;
     float_status tstat;
 
-    helper_reset_fpstatus(env);
+    HELPER(reset_fpstatus)(env);
 
     tstat = env->fp_status;
     if (unlikely(Rc(opcode) != 0)) {
@@ -3343,7 +3343,7 @@ void helper_xssubqp(CPUPPCState *env, uint32_t opcode,
         float_invalid_op_addsub(env, tstat.float_exception_flags, 1, GETPC());
     }
 
-    helper_compute_fprf_float128(env, t.f128);
+    HELPER(compute_fprf_float128)(env, t.f128);
     *xt = t;
     do_float_check_status(env, true, GETPC());
 }
@@ -3491,7 +3491,7 @@ static void vsxger(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
     float_status *excp_ptr = &env->fp_status;
     op_flags = (neg_acc ^ neg_mul) ? float_muladd_negate_c : 0;
     op_flags |= (neg_mul) ? float_muladd_negate_result : 0;
-    helper_reset_fpstatus(env);
+    HELPER(reset_fpstatus)(env);
     for (i = 0, xmsk_bit = 1 << 3; i < 4; i++, xmsk_bit >>= 1) {
         for (j = 0, ymsk_bit = 1 << 3; j < 4; j++, ymsk_bit >>= 1) {
             if ((xmsk_bit & xmsk) && (ymsk_bit & ymsk)) {
@@ -3509,77 +3509,77 @@ static void vsxger(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
 }
 
 QEMU_FLATTEN
-void helper_XVBF16GER2(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
+void HELPER(XVBF16GER2)(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
                        ppc_acc_t *at, uint32_t mask)
 {
     vsxger16(env, a, b, at, mask, false, false, false, extract_bf16);
 }
 
 QEMU_FLATTEN
-void helper_XVBF16GER2PP(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
+void HELPER(XVBF16GER2PP)(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
                          ppc_acc_t *at, uint32_t mask)
 {
     vsxger16(env, a, b, at, mask, true, false, false, extract_bf16);
 }
 
 QEMU_FLATTEN
-void helper_XVBF16GER2PN(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
+void HELPER(XVBF16GER2PN)(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
                          ppc_acc_t *at, uint32_t mask)
 {
     vsxger16(env, a, b, at, mask, true, false, true, extract_bf16);
 }
 
 QEMU_FLATTEN
-void helper_XVBF16GER2NP(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
+void HELPER(XVBF16GER2NP)(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
                          ppc_acc_t *at, uint32_t mask)
 {
     vsxger16(env, a, b, at, mask, true, true, false, extract_bf16);
 }
 
 QEMU_FLATTEN
-void helper_XVBF16GER2NN(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
+void HELPER(XVBF16GER2NN)(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
                          ppc_acc_t *at, uint32_t mask)
 {
     vsxger16(env, a, b, at, mask, true, true, true, extract_bf16);
 }
 
 QEMU_FLATTEN
-void helper_XVF16GER2(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
+void HELPER(XVF16GER2)(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
                      ppc_acc_t *at, uint32_t mask)
 {
     vsxger16(env, a, b, at, mask, false, false, false, extract_hf16);
 }
 
 QEMU_FLATTEN
-void helper_XVF16GER2PP(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
+void HELPER(XVF16GER2PP)(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
                         ppc_acc_t *at, uint32_t mask)
 {
     vsxger16(env, a, b, at, mask, true, false, false, extract_hf16);
 }
 
 QEMU_FLATTEN
-void helper_XVF16GER2PN(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
+void HELPER(XVF16GER2PN)(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
                         ppc_acc_t *at, uint32_t mask)
 {
     vsxger16(env, a, b, at, mask, true, false, true, extract_hf16);
 }
 
 QEMU_FLATTEN
-void helper_XVF16GER2NP(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
+void HELPER(XVF16GER2NP)(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
                         ppc_acc_t *at, uint32_t mask)
 {
     vsxger16(env, a, b, at, mask, true, true, false, extract_hf16);
 }
 
 QEMU_FLATTEN
-void helper_XVF16GER2NN(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
+void HELPER(XVF16GER2NN)(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
                         ppc_acc_t *at, uint32_t mask)
 {
     vsxger16(env, a, b, at, mask, true, true, true, extract_hf16);
 }
 
 QEMU_FLATTEN
-void helper_XVF32GER(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
+void HELPER(XVF32GER)(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
                      ppc_acc_t *at, uint32_t mask)
 {
     vsxger(env, a, b, at, mask, false, false, false, vsxger_mul32,
@@ -3587,7 +3587,7 @@ void helper_XVF32GER(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
 }
 
 QEMU_FLATTEN
-void helper_XVF32GERPP(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
+void HELPER(XVF32GERPP)(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
                        ppc_acc_t *at, uint32_t mask)
 {
     vsxger(env, a, b, at, mask, true, false, false, vsxger_mul32,
@@ -3595,7 +3595,7 @@ void helper_XVF32GERPP(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
 }
 
 QEMU_FLATTEN
-void helper_XVF32GERPN(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
+void HELPER(XVF32GERPN)(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
                        ppc_acc_t *at, uint32_t mask)
 {
     vsxger(env, a, b, at, mask, true, false, true, vsxger_mul32,
@@ -3603,7 +3603,7 @@ void helper_XVF32GERPN(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
 }
 
 QEMU_FLATTEN
-void helper_XVF32GERNP(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
+void HELPER(XVF32GERNP)(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
                        ppc_acc_t *at, uint32_t mask)
 {
     vsxger(env, a, b, at, mask, true, true, false, vsxger_mul32,
@@ -3611,7 +3611,7 @@ void helper_XVF32GERNP(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
 }
 
 QEMU_FLATTEN
-void helper_XVF32GERNN(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
+void HELPER(XVF32GERNN)(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
                        ppc_acc_t *at, uint32_t mask)
 {
     vsxger(env, a, b, at, mask, true, true, true, vsxger_mul32,
@@ -3619,7 +3619,7 @@ void helper_XVF32GERNN(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
 }
 
 QEMU_FLATTEN
-void helper_XVF64GER(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
+void HELPER(XVF64GER)(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
                      ppc_acc_t *at, uint32_t mask)
 {
     vsxger(env, a, b, at, mask, false, false, false, vsxger_mul64,
@@ -3627,7 +3627,7 @@ void helper_XVF64GER(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
 }
 
 QEMU_FLATTEN
-void helper_XVF64GERPP(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
+void HELPER(XVF64GERPP)(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
                        ppc_acc_t *at, uint32_t mask)
 {
     vsxger(env, a, b, at, mask, true, false, false, vsxger_mul64,
@@ -3635,7 +3635,7 @@ void helper_XVF64GERPP(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
 }
 
 QEMU_FLATTEN
-void helper_XVF64GERPN(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
+void HELPER(XVF64GERPN)(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
                        ppc_acc_t *at, uint32_t mask)
 {
     vsxger(env, a, b, at, mask, true, false, true, vsxger_mul64,
@@ -3643,7 +3643,7 @@ void helper_XVF64GERPN(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
 }
 
 QEMU_FLATTEN
-void helper_XVF64GERNP(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
+void HELPER(XVF64GERNP)(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
                        ppc_acc_t *at, uint32_t mask)
 {
     vsxger(env, a, b, at, mask, true, true, false, vsxger_mul64,
@@ -3651,7 +3651,7 @@ void helper_XVF64GERNP(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
 }
 
 QEMU_FLATTEN
-void helper_XVF64GERNN(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
+void HELPER(XVF64GERNN)(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
                        ppc_acc_t *at, uint32_t mask)
 {
     vsxger(env, a, b, at, mask, true, true, true, vsxger_mul64,
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 86346f5b9ae..7d01be9d5fb 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -44,7 +44,7 @@ static inline void helper_update_ov_legacy(CPUPPCState *env, int ov)
     }
 }
 
-target_ulong helper_DIVWEU(CPUPPCState *env, target_ulong ra, target_ulong rb,
+target_ulong HELPER(DIVWEU)(CPUPPCState *env, target_ulong ra, target_ulong rb,
                            uint32_t oe)
 {
     uint64_t rt = 0;
@@ -71,7 +71,7 @@ target_ulong helper_DIVWEU(CPUPPCState *env, target_ulong ra, target_ulong rb,
     return (target_ulong)rt;
 }
 
-target_ulong helper_DIVWE(CPUPPCState *env, target_ulong ra, target_ulong rb,
+target_ulong HELPER(DIVWE)(CPUPPCState *env, target_ulong ra, target_ulong rb,
                           uint32_t oe)
 {
     int64_t rt = 0;
@@ -101,7 +101,7 @@ target_ulong helper_DIVWE(CPUPPCState *env, target_ulong ra, target_ulong rb,
 
 #if defined(TARGET_PPC64)
 
-uint64_t helper_DIVDEU(CPUPPCState *env, uint64_t ra, uint64_t rb, uint32_t oe)
+uint64_t HELPER(DIVDEU)(CPUPPCState *env, uint64_t ra, uint64_t rb, uint32_t oe)
 {
     uint64_t rt = 0;
     int overflow = 0;
@@ -120,7 +120,8 @@ uint64_t helper_DIVDEU(CPUPPCState *env, uint64_t ra, uint64_t rb, uint32_t oe)
     return rt;
 }
 
-uint64_t helper_DIVDE(CPUPPCState *env, uint64_t rau, uint64_t rbu, uint32_t oe)
+uint64_t HELPER(DIVDE)(CPUPPCState *env, uint64_t rau, uint64_t rbu,
+                       uint32_t oe)
 {
     uint64_t rt = 0;
     int64_t ra = (int64_t)rau;
@@ -159,7 +160,7 @@ uint64_t helper_DIVDE(CPUPPCState *env, uint64_t rau, uint64_t rbu, uint32_t oe)
 /* When you XOR the pattern and there is a match, that byte will be zero */
 #define hasvalue(x, n)  (haszero((x) ^ pattern(n)))
 
-uint32_t helper_CMPEQB(target_ulong ra, target_ulong rb)
+uint32_t HELPER(CMPEQB)(target_ulong ra, target_ulong rb)
 {
     return hasvalue(rb, ra) ? CRF_GT : 0;
 }
@@ -171,7 +172,7 @@ uint32_t helper_CMPEQB(target_ulong ra, target_ulong rb)
 /*
  * Return a random number.
  */
-uint64_t helper_DARN32(void)
+uint64_t HELPER(DARN32)(void)
 {
     Error *err = NULL;
     uint32_t ret;
@@ -186,7 +187,7 @@ uint64_t helper_DARN32(void)
     return ret;
 }
 
-uint64_t helper_DARN64(void)
+uint64_t HELPER(DARN64)(void)
 {
     Error *err = NULL;
     uint64_t ret;
@@ -201,7 +202,7 @@ uint64_t helper_DARN64(void)
     return ret;
 }
 
-uint64_t helper_BPERMD(uint64_t rs, uint64_t rb)
+uint64_t HELPER(BPERMD)(uint64_t rs, uint64_t rb)
 {
     int i;
     uint64_t ra = 0;
@@ -219,7 +220,7 @@ uint64_t helper_BPERMD(uint64_t rs, uint64_t rb)
 
 #endif
 
-target_ulong helper_CMPB(target_ulong rs, target_ulong rb)
+target_ulong HELPER(CMPB)(target_ulong rs, target_ulong rb)
 {
     target_ulong mask = 0xff;
     target_ulong ra = 0;
@@ -235,7 +236,7 @@ target_ulong helper_CMPB(target_ulong rs, target_ulong rb)
 }
 
 /* shift right arithmetic helper */
-target_ulong helper_SRAW(CPUPPCState *env, target_ulong value,
+target_ulong HELPER(SRAW)(CPUPPCState *env, target_ulong value,
                          target_ulong shift)
 {
     int32_t ret;
@@ -261,7 +262,7 @@ target_ulong helper_SRAW(CPUPPCState *env, target_ulong value,
 }
 
 #if defined(TARGET_PPC64)
-target_ulong helper_SRAD(CPUPPCState *env, target_ulong value,
+target_ulong HELPER(SRAD)(CPUPPCState *env, target_ulong value,
                          target_ulong shift)
 {
     int64_t ret;
@@ -288,7 +289,7 @@ target_ulong helper_SRAD(CPUPPCState *env, target_ulong value,
 #endif
 
 #if defined(TARGET_PPC64)
-target_ulong helper_POPCNTB(target_ulong val)
+target_ulong HELPER(POPCNTB)(target_ulong val)
 {
     /* Note that we don't fold past bytes */
     val = (val & 0x5555555555555555ULL) + ((val >>  1) &
@@ -300,7 +301,7 @@ target_ulong helper_POPCNTB(target_ulong val)
     return val;
 }
 
-target_ulong helper_POPCNTW(target_ulong val)
+target_ulong HELPER(POPCNTW)(target_ulong val)
 {
     /* Note that we don't fold past words.  */
     val = (val & 0x5555555555555555ULL) + ((val >>  1) &
@@ -316,7 +317,7 @@ target_ulong helper_POPCNTW(target_ulong val)
     return val;
 }
 #else
-target_ulong helper_POPCNTB(target_ulong val)
+target_ulong HELPER(POPCNTB)(target_ulong val)
 {
     /* Note that we don't fold past bytes */
     val = (val & 0x55555555) + ((val >>  1) & 0x55555555);
@@ -326,7 +327,7 @@ target_ulong helper_POPCNTB(target_ulong val)
 }
 #endif
 
-uint64_t helper_CFUGED(uint64_t src, uint64_t mask)
+uint64_t HELPER(CFUGED)(uint64_t src, uint64_t mask)
 {
     /*
      * Instead of processing the mask bit-by-bit from the most significant to
@@ -388,7 +389,7 @@ uint64_t helper_CFUGED(uint64_t src, uint64_t mask)
     return left | (right >> n);
 }
 
-uint64_t helper_PDEPD(uint64_t src, uint64_t mask)
+uint64_t HELPER(PDEPD)(uint64_t src, uint64_t mask)
 {
     int i, o;
     uint64_t result = 0;
@@ -406,7 +407,7 @@ uint64_t helper_PDEPD(uint64_t src, uint64_t mask)
     return result;
 }
 
-uint64_t helper_PEXTD(uint64_t src, uint64_t mask)
+uint64_t HELPER(PEXTD)(uint64_t src, uint64_t mask)
 {
     int i, o;
     uint64_t result = 0;
@@ -477,12 +478,12 @@ SATCVT(sd, uw, int64_t, uint32_t, 0, UINT32_MAX)
 #undef SATCVT
 #undef SATCVTU
 
-void helper_mtvscr(CPUPPCState *env, uint32_t vscr)
+void HELPER(mtvscr)(CPUPPCState *env, uint32_t vscr)
 {
     ppc_store_vscr(env, vscr);
 }
 
-uint32_t helper_mfvscr(CPUPPCState *env)
+uint32_t HELPER(mfvscr)(CPUPPCState *env)
 {
     return ppc_get_vscr(env);
 }
@@ -494,7 +495,7 @@ static inline void set_vscr_sat(CPUPPCState *env)
 }
 
 /* vprtybq */
-void helper_VPRTYBQ(ppc_avr_t *r, ppc_avr_t *b, uint32_t v)
+void HELPER(VPRTYBQ)(ppc_avr_t *r, ppc_avr_t *b, uint32_t v)
 {
     uint64_t res = b->u64[0] ^ b->u64[1];
     res ^= res >> 32;
@@ -505,7 +506,7 @@ void helper_VPRTYBQ(ppc_avr_t *r, ppc_avr_t *b, uint32_t v)
 }
 
 #define VARITHFP(suffix, func)                                          \
-    void helper_v##suffix(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a, \
+    void HELPER(v##suffix)(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a, \
                           ppc_avr_t *b)                                 \
     {                                                                   \
         int i;                                                          \
@@ -521,7 +522,7 @@ VARITHFP(maxfp, float32_max)
 #undef VARITHFP
 
 #define VARITHFPFMA(suffix, type)                                       \
-    void helper_v##suffix(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a, \
+    void HELPER(v##suffix)(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a, \
                            ppc_avr_t *b, ppc_avr_t *c)                  \
     {                                                                   \
         int i;                                                          \
@@ -541,7 +542,7 @@ VARITHFPFMA(nmsubfp, float_muladd_negate_result | float_muladd_negate_c);
     }
 
 #define VARITHSAT_DO(name, op, optype, cvt, element)                    \
-    void helper_V##name(ppc_avr_t *r, ppc_avr_t *vscr_sat,              \
+    void HELPER(V##name)(ppc_avr_t *r, ppc_avr_t *vscr_sat,             \
                         ppc_avr_t *a, ppc_avr_t *b, uint32_t desc)      \
     {                                                                   \
         int sat = 0;                                                    \
@@ -572,7 +573,7 @@ VARITHSAT_UNSIGNED(W, u32, uint64_t, cvtsduw)
 #undef VARITHSAT_UNSIGNED
 
 #define VAVG(name, element, etype)                                          \
-    void helper_##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t v)\
+    void HELPER(name)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t v) \
     {                                                                       \
         int i;                                                              \
                                                                             \
@@ -591,7 +592,7 @@ VAVG(VAVGUW, u32, uint64_t)
 #undef VAVG
 
 #define VABSDU(name, element)                                           \
-void helper_##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t v)\
+void HELPER(name)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t v) \
 {                                                                       \
     int i;                                                              \
                                                                         \
@@ -613,7 +614,7 @@ VABSDU(VABSDUW, u32)
 #undef VABSDU
 
 #define VCF(suffix, cvt, element)                                       \
-    void helper_vcf##suffix(CPUPPCState *env, ppc_avr_t *r,             \
+    void HELPER(vcf##suffix)(CPUPPCState *env, ppc_avr_t *r,            \
                             ppc_avr_t *b, uint32_t uim)                 \
     {                                                                   \
         int i;                                                          \
@@ -628,7 +629,7 @@ VCF(sx, int32_to_float32, s32)
 #undef VCF
 
 #define VCMPNEZ(NAME, ELEM) \
-void helper_##NAME(ppc_vsr_t *t, ppc_vsr_t *a, ppc_vsr_t *b, uint32_t desc) \
+void HELPER(NAME)(ppc_vsr_t *t, ppc_vsr_t *a, ppc_vsr_t *b, uint32_t desc)  \
 {                                                                           \
     for (int i = 0; i < ARRAY_SIZE(t->ELEM); i++) {                         \
         t->ELEM[i] = ((a->ELEM[i] == 0) || (b->ELEM[i] == 0) ||             \
@@ -641,7 +642,7 @@ VCMPNEZ(VCMPNEZW, u32)
 #undef VCMPNEZ
 
 #define VCMPFP_DO(suffix, compare, order, record)                       \
-    void helper_vcmp##suffix(CPUPPCState *env, ppc_avr_t *r,            \
+    void HELPER(vcmp##suffix)(CPUPPCState *env, ppc_avr_t *r,           \
                              ppc_avr_t *a, ppc_avr_t *b)                \
     {                                                                   \
         uint32_t ones = (uint32_t)-1;                                   \
@@ -706,19 +707,19 @@ static inline void vcmpbfp_internal(CPUPPCState *env, ppc_avr_t *r,
     }
 }
 
-void helper_vcmpbfp(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
+void HELPER(vcmpbfp)(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
     vcmpbfp_internal(env, r, a, b, 0);
 }
 
-void helper_vcmpbfp_dot(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
+void HELPER(vcmpbfp_dot)(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
                         ppc_avr_t *b)
 {
     vcmpbfp_internal(env, r, a, b, 1);
 }
 
 #define VCT(suffix, satcvt, element)                                    \
-    void helper_vct##suffix(CPUPPCState *env, ppc_avr_t *r,             \
+    void HELPER(vct##suffix)(CPUPPCState *env, ppc_avr_t *r,            \
                             ppc_avr_t *b, uint32_t uim)                 \
     {                                                                   \
         int i;                                                          \
@@ -815,69 +816,69 @@ static void xviger(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b, ppc_acc_t  *at,
 }
 
 QEMU_FLATTEN
-void helper_XVI4GER8(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
+void HELPER(XVI4GER8)(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
                      ppc_acc_t *at, uint32_t mask)
 {
     xviger(env, a, b, at, mask, false, false, ger_rank8);
 }
 
 QEMU_FLATTEN
-void helper_XVI4GER8PP(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
+void HELPER(XVI4GER8PP)(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
                        ppc_acc_t *at, uint32_t mask)
 {
     xviger(env, a, b, at, mask, false, true, ger_rank8);
 }
 
 QEMU_FLATTEN
-void helper_XVI8GER4(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
+void HELPER(XVI8GER4)(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
                      ppc_acc_t *at, uint32_t mask)
 {
     xviger(env, a, b, at, mask, false, false, ger_rank4);
 }
 
 QEMU_FLATTEN
-void helper_XVI8GER4PP(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
+void HELPER(XVI8GER4PP)(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
                        ppc_acc_t *at, uint32_t mask)
 {
     xviger(env, a, b, at, mask, false, true, ger_rank4);
 }
 
 QEMU_FLATTEN
-void helper_XVI8GER4SPP(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
+void HELPER(XVI8GER4SPP)(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
                         ppc_acc_t *at, uint32_t mask)
 {
     xviger(env, a, b, at, mask, true, true, ger_rank4);
 }
 
 QEMU_FLATTEN
-void helper_XVI16GER2(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
+void HELPER(XVI16GER2)(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
                       ppc_acc_t *at, uint32_t mask)
 {
     xviger(env, a, b, at, mask, false, false, ger_rank2);
 }
 
 QEMU_FLATTEN
-void helper_XVI16GER2S(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
+void HELPER(XVI16GER2S)(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
                        ppc_acc_t *at, uint32_t mask)
 {
     xviger(env, a, b, at, mask, true, false, ger_rank2);
 }
 
 QEMU_FLATTEN
-void helper_XVI16GER2PP(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
+void HELPER(XVI16GER2PP)(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
                         ppc_acc_t *at, uint32_t mask)
 {
     xviger(env, a, b, at, mask, false, true, ger_rank2);
 }
 
 QEMU_FLATTEN
-void helper_XVI16GER2SPP(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
+void HELPER(XVI16GER2SPP)(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
                          ppc_acc_t *at, uint32_t mask)
 {
     xviger(env, a, b, at, mask, true, true, ger_rank2);
 }
 
-target_ulong helper_vclzlsbb(ppc_avr_t *r)
+target_ulong HELPER(vclzlsbb)(ppc_avr_t *r)
 {
     target_ulong count = 0;
     int i;
@@ -890,7 +891,7 @@ target_ulong helper_vclzlsbb(ppc_avr_t *r)
     return count;
 }
 
-target_ulong helper_vctzlsbb(ppc_avr_t *r)
+target_ulong HELPER(vctzlsbb)(ppc_avr_t *r)
 {
     target_ulong count = 0;
     int i;
@@ -903,7 +904,7 @@ target_ulong helper_vctzlsbb(ppc_avr_t *r)
     return count;
 }
 
-void helper_VMHADDSHS(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
+void HELPER(VMHADDSHS)(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
                       ppc_avr_t *b, ppc_avr_t *c)
 {
     int sat = 0;
@@ -921,7 +922,7 @@ void helper_VMHADDSHS(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
     }
 }
 
-void helper_VMHRADDSHS(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
+void HELPER(VMHRADDSHS)(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
                        ppc_avr_t *b, ppc_avr_t *c)
 {
     int sat = 0;
@@ -938,7 +939,7 @@ void helper_VMHRADDSHS(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
     }
 }
 
-void helper_VMLADDUHM(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c,
+void HELPER(VMLADDUHM)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c,
                       uint32_t v)
 {
     int i;
@@ -950,7 +951,7 @@ void helper_VMLADDUHM(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c,
 }
 
 #define VMRG_DO(name, element, access, ofs)                                  \
-    void helper_V##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)            \
+    void HELPER(V##name)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)           \
     {                                                                        \
         ppc_avr_t result;                                                    \
         int i, half = ARRAY_SIZE(r->element) / 2;                            \
@@ -971,7 +972,7 @@ VMRG(W, u32, VsrW)
 #undef VMRG_DO
 #undef VMRG
 
-void helper_VMSUMMBM(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
+void HELPER(VMSUMMBM)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
 {
     int32_t prod[16];
     int i;
@@ -986,7 +987,7 @@ void helper_VMSUMMBM(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
     }
 }
 
-void helper_VMSUMSHM(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
+void HELPER(VMSUMSHM)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
 {
     int32_t prod[8];
     int i;
@@ -1000,7 +1001,7 @@ void helper_VMSUMSHM(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
     }
 }
 
-void helper_VMSUMSHS(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
+void HELPER(VMSUMSHS)(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
                      ppc_avr_t *b, ppc_avr_t *c)
 {
     int32_t prod[8];
@@ -1022,7 +1023,7 @@ void helper_VMSUMSHS(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
     }
 }
 
-void helper_VMSUMUBM(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
+void HELPER(VMSUMUBM)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
 {
     uint16_t prod[16];
     int i;
@@ -1037,7 +1038,7 @@ void helper_VMSUMUBM(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
     }
 }
 
-void helper_VMSUMUHM(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
+void HELPER(VMSUMUHM)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
 {
     uint32_t prod[8];
     int i;
@@ -1051,7 +1052,7 @@ void helper_VMSUMUHM(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
     }
 }
 
-void helper_VMSUMUHS(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
+void HELPER(VMSUMUHS)(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
                      ppc_avr_t *b, ppc_avr_t *c)
 {
     uint32_t prod[8];
@@ -1074,7 +1075,7 @@ void helper_VMSUMUHS(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
 }
 
 #define VMUL_DO_EVN(name, mul_element, mul_access, prod_access, cast)   \
-    void helper_V##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)       \
+    void HELPER(V##name)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)      \
     {                                                                   \
         int i;                                                          \
                                                                         \
@@ -1085,7 +1086,7 @@ void helper_VMSUMUHS(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
     }
 
 #define VMUL_DO_ODD(name, mul_element, mul_access, prod_access, cast)   \
-    void helper_V##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)       \
+    void HELPER(V##name)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)      \
     {                                                                   \
         int i;                                                          \
                                                                         \
@@ -1108,7 +1109,7 @@ VMUL(UW, u32, VsrW, VsrD, uint64_t)
 #undef VMUL_DO_ODD
 #undef VMUL
 
-void helper_XXPERMX(ppc_vsr_t *t, ppc_vsr_t *s0, ppc_vsr_t *s1, ppc_vsr_t *pcv,
+void HELPER(XXPERMX)(ppc_vsr_t *t, ppc_vsr_t *s0, ppc_vsr_t *s1, ppc_vsr_t *pcv,
                     target_ulong uim)
 {
     int i, idx;
@@ -1128,7 +1129,7 @@ void helper_XXPERMX(ppc_vsr_t *t, ppc_vsr_t *s0, ppc_vsr_t *s1, ppc_vsr_t *pcv,
     *t = tmp;
 }
 
-void helper_VDIVSQ(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b)
+void HELPER(VDIVSQ)(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b)
 {
     Int128 neg1 = int128_makes64(-1);
     Int128 int128_min = int128_make128(0, INT64_MIN);
@@ -1140,7 +1141,7 @@ void helper_VDIVSQ(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b)
     }
 }
 
-void helper_VDIVUQ(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b)
+void HELPER(VDIVUQ)(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b)
 {
     if (int128_nz(b->s128)) {
         t->s128 = int128_divu(a->s128, b->s128);
@@ -1149,7 +1150,7 @@ void helper_VDIVUQ(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b)
     }
 }
 
-void helper_VDIVESD(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b)
+void HELPER(VDIVESD)(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b)
 {
     int i;
     int64_t high;
@@ -1166,7 +1167,7 @@ void helper_VDIVESD(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b)
     }
 }
 
-void helper_VDIVEUD(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b)
+void HELPER(VDIVEUD)(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b)
 {
     int i;
     uint64_t high, low;
@@ -1182,7 +1183,7 @@ void helper_VDIVEUD(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b)
     }
 }
 
-void helper_VDIVESQ(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b)
+void HELPER(VDIVESQ)(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b)
 {
     Int128 high, low;
     Int128 int128_min = int128_make128(0, INT64_MIN);
@@ -1199,7 +1200,7 @@ void helper_VDIVESQ(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b)
     }
 }
 
-void helper_VDIVEUQ(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b)
+void HELPER(VDIVEUQ)(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b)
 {
     Int128 high, low;
 
@@ -1213,7 +1214,7 @@ void helper_VDIVEUQ(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b)
     }
 }
 
-void helper_VMODSQ(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b)
+void HELPER(VMODSQ)(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b)
 {
     Int128 neg1 = int128_makes64(-1);
     Int128 int128_min = int128_make128(0, INT64_MIN);
@@ -1225,7 +1226,7 @@ void helper_VMODSQ(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b)
     }
 }
 
-void helper_VMODUQ(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b)
+void HELPER(VMODUQ)(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b)
 {
     if (likely(int128_nz(b->s128))) {
         t->s128 = int128_remu(a->s128, b->s128);
@@ -1234,7 +1235,7 @@ void helper_VMODUQ(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b)
     }
 }
 
-void helper_VPERM(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
+void HELPER(VPERM)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
 {
     ppc_avr_t result;
     int i;
@@ -1252,7 +1253,7 @@ void helper_VPERM(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
     *r = result;
 }
 
-void helper_VPERMR(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
+void HELPER(VPERMR)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
 {
     ppc_avr_t result;
     int i;
@@ -1271,7 +1272,7 @@ void helper_VPERMR(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
 }
 
 #define XXGENPCV_BE_EXP(NAME, SZ) \
-void glue(helper_, glue(NAME, _be_exp))(ppc_vsr_t *t, ppc_vsr_t *b) \
+void HELPER(glue(NAME, _be_exp))(ppc_vsr_t *t, ppc_vsr_t *b)        \
 {                                                                   \
     ppc_vsr_t tmp;                                                  \
                                                                     \
@@ -1294,7 +1295,7 @@ void glue(helper_, glue(NAME, _be_exp))(ppc_vsr_t *t, ppc_vsr_t *b) \
 }
 
 #define XXGENPCV_BE_COMP(NAME, SZ) \
-void glue(helper_, glue(NAME, _be_comp))(ppc_vsr_t *t, ppc_vsr_t *b)\
+void HELPER(glue(NAME, _be_comp))(ppc_vsr_t *t, ppc_vsr_t *b)       \
 {                                                                   \
     ppc_vsr_t tmp = { .u64 = { 0, 0 } };                            \
                                                                     \
@@ -1313,7 +1314,7 @@ void glue(helper_, glue(NAME, _be_comp))(ppc_vsr_t *t, ppc_vsr_t *b)\
 }
 
 #define XXGENPCV_LE_EXP(NAME, SZ) \
-void glue(helper_, glue(NAME, _le_exp))(ppc_vsr_t *t, ppc_vsr_t *b) \
+void HELPER(glue(NAME, _le_exp))(ppc_vsr_t *t, ppc_vsr_t *b)        \
 {                                                                   \
     ppc_vsr_t tmp;                                                  \
                                                                     \
@@ -1338,7 +1339,7 @@ void glue(helper_, glue(NAME, _le_exp))(ppc_vsr_t *t, ppc_vsr_t *b) \
 }
 
 #define XXGENPCV_LE_COMP(NAME, SZ) \
-void glue(helper_, glue(NAME, _le_comp))(ppc_vsr_t *t, ppc_vsr_t *b)\
+void HELPER(glue(NAME, _le_comp))(ppc_vsr_t *t, ppc_vsr_t *b)       \
 {                                                                   \
     ppc_vsr_t tmp = { .u64 = { 0, 0 } };                            \
                                                                     \
@@ -1387,7 +1388,7 @@ XXGENPCV(XXGENPCVDM, 8)
 #define EXTRACT_BIT(avr, i, index) \
         (extract64((avr)->VsrD(i), 63 - index, 1))
 
-void helper_vbpermd(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
+void HELPER(vbpermd)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
     int i, j;
     ppc_avr_t result = { .u64 = { 0, 0 } };
@@ -1402,7 +1403,7 @@ void helper_vbpermd(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
     *r = result;
 }
 
-void helper_vbpermq(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
+void HELPER(vbpermq)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
     int i;
     uint64_t perm = 0;
@@ -1429,7 +1430,7 @@ void helper_vbpermq(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
  * There is no carry across the two doublewords, so their order does
  * not matter.  Nor is there partial overlap between registers.
  */
-void helper_vpmsumb(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
+void HELPER(vpmsumb)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
     for (int i = 0; i < 2; ++i) {
         uint64_t aa = a->u64[i], bb = b->u64[i];
@@ -1437,7 +1438,7 @@ void helper_vpmsumb(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
     }
 }
 
-void helper_vpmsumh(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
+void HELPER(vpmsumh)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
     for (int i = 0; i < 2; ++i) {
         uint64_t aa = a->u64[i], bb = b->u64[i];
@@ -1445,7 +1446,7 @@ void helper_vpmsumh(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
     }
 }
 
-void helper_vpmsumw(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
+void HELPER(vpmsumw)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
     for (int i = 0; i < 2; ++i) {
         uint64_t aa = a->u64[i], bb = b->u64[i];
@@ -1453,7 +1454,7 @@ void helper_vpmsumw(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
     }
 }
 
-void helper_VPMSUMD(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
+void HELPER(VPMSUMD)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
     Int128 e = clmul_64(a->u64[0], b->u64[0]);
     Int128 o = clmul_64(a->u64[1], b->u64[1]);
@@ -1465,7 +1466,7 @@ void helper_VPMSUMD(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 #else
 #define PKBIG 0
 #endif
-void helper_VPKPX(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
+void HELPER(VPKPX)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
     int i, j;
     ppc_avr_t result;
@@ -1488,7 +1489,7 @@ void helper_VPKPX(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 }
 
 #define VPK(suffix, from, to, cvt, dosat)                               \
-    void helper_VPK##suffix(CPUPPCState *env, ppc_avr_t *r,             \
+    void HELPER(VPK##suffix)(CPUPPCState *env, ppc_avr_t *r,            \
                             ppc_avr_t *a, ppc_avr_t *b)                 \
     {                                                                   \
         int i;                                                          \
@@ -1523,7 +1524,7 @@ VPK(UDUM, u64, u32, I, 0)
 #undef VPK
 #undef PKBIG
 
-void helper_vrefp(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *b)
+void HELPER(vrefp)(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *b)
 {
     int i;
 
@@ -1533,7 +1534,7 @@ void helper_vrefp(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *b)
 }
 
 #define VRFI(suffix, rounding)                                  \
-    void helper_vrfi##suffix(CPUPPCState *env, ppc_avr_t *r,    \
+    void HELPER(vrfi##suffix)(CPUPPCState *env, ppc_avr_t *r,   \
                              ppc_avr_t *b)                      \
     {                                                           \
         int i;                                                  \
@@ -1550,7 +1551,7 @@ VRFI(p, float_round_up)
 VRFI(z, float_round_to_zero)
 #undef VRFI
 
-void helper_vrsqrtefp(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *b)
+void HELPER(vrsqrtefp)(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *b)
 {
     int i;
 
@@ -1562,7 +1563,7 @@ void helper_vrsqrtefp(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *b)
 }
 
 #define VRLMI(name, size, element, insert)                                  \
-void helper_##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t desc) \
+void HELPER(name)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t desc)  \
 {                                                                           \
     int i;                                                                  \
     for (i = 0; i < ARRAY_SIZE(r->element); i++) {                          \
@@ -1589,7 +1590,7 @@ VRLMI(VRLWMI, 32, u32, 1);
 VRLMI(VRLDNM, 64, u64, 0);
 VRLMI(VRLWNM, 32, u32, 0);
 
-void helper_vexptefp(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *b)
+void HELPER(vexptefp)(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *b)
 {
     int i;
 
@@ -1598,7 +1599,7 @@ void helper_vexptefp(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *b)
     }
 }
 
-void helper_vlogefp(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *b)
+void HELPER(vlogefp)(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *b)
 {
     int i;
 
@@ -1608,7 +1609,7 @@ void helper_vlogefp(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *b)
 }
 
 #define VEXTU_X_DO(name, size, left)                            \
-target_ulong glue(helper_, name)(target_ulong a, ppc_avr_t *b)  \
+target_ulong HELPER(name)(target_ulong a, ppc_avr_t *b)         \
 {                                                               \
     int index = (a & 0xf) * 8;                                  \
     if (left) {                                                 \
@@ -1625,7 +1626,7 @@ VEXTU_X_DO(vextuhrx, 16, 0)
 VEXTU_X_DO(vextuwrx, 32, 0)
 #undef VEXTU_X_DO
 
-void helper_vslv(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
+void HELPER(vslv)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
     int i;
     unsigned int shift, bytes, size;
@@ -1639,7 +1640,7 @@ void helper_vslv(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
     }
 }
 
-void helper_vsrv(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
+void HELPER(vsrv)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
     int i;
     unsigned int shift, bytes;
@@ -1657,7 +1658,7 @@ void helper_vsrv(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
     }
 }
 
-void helper_vsldoi(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t shift)
+void HELPER(vsldoi)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t shift)
 {
     int sh = shift & 0xf;
     int i;
@@ -1674,7 +1675,7 @@ void helper_vsldoi(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t shift)
     *r = result;
 }
 
-void helper_vslo(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
+void HELPER(vslo)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
     int sh = (b->VsrB(0xf) >> 3) & 0xf;
 
@@ -1694,7 +1695,7 @@ void helper_vslo(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 #endif
 
 #define VINSX(SUFFIX, TYPE) \
-void glue(glue(helper_VINS, SUFFIX), LX)(CPUPPCState *env, ppc_avr_t *t,       \
+void glue(glue(HELPER(VINS), SUFFIX), LX)(CPUPPCState *env, ppc_avr_t *t,      \
                                          uint64_t val, target_ulong index)     \
 {                                                                              \
     const int maxidx = ARRAY_SIZE(t->u8) - sizeof(TYPE);                       \
@@ -1718,7 +1719,7 @@ VINSX(D, uint64_t)
 #undef VINSX
 #if HOST_BIG_ENDIAN
 #define VEXTDVLX(NAME, SIZE) \
-void helper_##NAME(CPUPPCState *env, ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b, \
+void HELPER(NAME)(CPUPPCState *env, ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b,  \
                    target_ulong index)                                         \
 {                                                                              \
     const target_long idx = index;                                             \
@@ -1734,7 +1735,7 @@ void helper_##NAME(CPUPPCState *env, ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b, \
 }
 #else
 #define VEXTDVLX(NAME, SIZE) \
-void helper_##NAME(CPUPPCState *env, ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b, \
+void HELPER(NAME)(CPUPPCState *env, ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b,  \
                    target_ulong index)                                         \
 {                                                                              \
     const target_long idx = index;                                             \
@@ -1757,7 +1758,7 @@ VEXTDVLX(VEXTDDVLX, 8)
 #undef VEXTDVLX
 #if HOST_BIG_ENDIAN
 #define VEXTRACT(suffix, element)                                            \
-    void helper_vextract##suffix(ppc_avr_t *r, ppc_avr_t *b, uint32_t index) \
+    void HELPER(vextract##suffix)(ppc_avr_t *r, ppc_avr_t *b, uint32_t index) \
     {                                                                        \
         uint32_t es = sizeof(r->element[0]);                                 \
         memmove(&r->u8[8 - es], &b->u8[index], es);                          \
@@ -1766,7 +1767,7 @@ VEXTDVLX(VEXTDDVLX, 8)
     }
 #else
 #define VEXTRACT(suffix, element)                                            \
-    void helper_vextract##suffix(ppc_avr_t *r, ppc_avr_t *b, uint32_t index) \
+    void HELPER(vextract##suffix)(ppc_avr_t *r, ppc_avr_t *b, uint32_t index) \
     {                                                                        \
         uint32_t es = sizeof(r->element[0]);                                 \
         uint32_t s = (16 - index) - es;                                      \
@@ -1782,7 +1783,7 @@ VEXTRACT(d, u64)
 #undef VEXTRACT
 
 #define VSTRI(NAME, ELEM, NUM_ELEMS, LEFT) \
-uint32_t helper_##NAME(ppc_avr_t *t, ppc_avr_t *b) \
+uint32_t HELPER(NAME)(ppc_avr_t *t, ppc_avr_t *b)  \
 {                                                   \
     int i, idx, crf = 0;                            \
                                                     \
@@ -1809,7 +1810,7 @@ VSTRI(VSTRIHL, H, 8, true)
 VSTRI(VSTRIHR, H, 8, false)
 #undef VSTRI
 
-void helper_XXEXTRACTUW(ppc_vsr_t *xt, ppc_vsr_t *xb, uint32_t index)
+void HELPER(XXEXTRACTUW)(ppc_vsr_t *xt, ppc_vsr_t *xb, uint32_t index)
 {
     ppc_vsr_t t = { };
     size_t es = sizeof(uint32_t);
@@ -1824,7 +1825,7 @@ void helper_XXEXTRACTUW(ppc_vsr_t *xt, ppc_vsr_t *xb, uint32_t index)
     *xt = t;
 }
 
-void helper_XXINSERTW(ppc_vsr_t *xt, ppc_vsr_t *xb, uint32_t index)
+void HELPER(XXINSERTW)(ppc_vsr_t *xt, ppc_vsr_t *xb, uint32_t index)
 {
     ppc_vsr_t t = *xt;
     size_t es = sizeof(uint32_t);
@@ -1838,7 +1839,7 @@ void helper_XXINSERTW(ppc_vsr_t *xt, ppc_vsr_t *xb, uint32_t index)
     *xt = t;
 }
 
-void helper_XXEVAL(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c,
+void HELPER(XXEVAL)(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c,
                    uint32_t desc)
 {
     /*
@@ -1880,7 +1881,7 @@ void helper_XXEVAL(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c,
 }
 
 #define XXBLEND(name, sz) \
-void glue(helper_XXBLENDV, name)(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b,  \
+void glue(HELPER(XXBLENDV), name)(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b, \
                                  ppc_avr_t *c, uint32_t desc)               \
 {                                                                           \
     for (int i = 0; i < ARRAY_SIZE(t->glue(u, sz)); i++) {                  \
@@ -1894,7 +1895,7 @@ XXBLEND(W, 32)
 XXBLEND(D, 64)
 #undef XXBLEND
 
-void helper_vsro(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
+void HELPER(vsro)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
     int sh = (b->VsrB(0xf) >> 3) & 0xf;
 
@@ -1907,7 +1908,7 @@ void helper_vsro(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 #endif
 }
 
-void helper_vsumsws(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
+void HELPER(vsumsws)(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
     int64_t t;
     int i, upper;
@@ -1928,7 +1929,8 @@ void helper_vsumsws(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
     }
 }
 
-void helper_vsum2sws(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
+void HELPER(vsum2sws)(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
+                      ppc_avr_t *b)
 {
     int i, j, upper;
     ppc_avr_t result;
@@ -1951,7 +1953,8 @@ void helper_vsum2sws(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
     }
 }
 
-void helper_vsum4sbs(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
+void HELPER(vsum4sbs)(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
+                      ppc_avr_t *b)
 {
     int i, j;
     int sat = 0;
@@ -1970,7 +1973,8 @@ void helper_vsum4sbs(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
     }
 }
 
-void helper_vsum4shs(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
+void HELPER(vsum4shs)(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
+                      ppc_avr_t *b)
 {
     int sat = 0;
     int i;
@@ -1987,7 +1991,8 @@ void helper_vsum4shs(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
     }
 }
 
-void helper_vsum4ubs(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
+void HELPER(vsum4ubs)(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
+                      ppc_avr_t *b)
 {
     int i, j;
     int sat = 0;
@@ -2014,7 +2019,7 @@ void helper_vsum4ubs(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 #define UPKLO 1
 #endif
 #define VUPKPX(suffix, hi)                                              \
-    void helper_vupk##suffix(ppc_avr_t *r, ppc_avr_t *b)                \
+    void HELPER(vupk##suffix)(ppc_avr_t *r, ppc_avr_t *b)               \
     {                                                                   \
         int i;                                                          \
         ppc_avr_t result;                                               \
@@ -2035,7 +2040,7 @@ VUPKPX(hpx, UPKHI)
 #undef VUPKPX
 
 #define VUPK(suffix, unpacked, packee, hi)                              \
-    void helper_vupk##suffix(ppc_avr_t *r, ppc_avr_t *b)                \
+    void HELPER(vupk##suffix)(ppc_avr_t *r, ppc_avr_t *b)               \
     {                                                                   \
         int i;                                                          \
         ppc_avr_t result;                                               \
@@ -2063,7 +2068,7 @@ VUPK(lsw, s64, s32, UPKLO)
 #undef UPKLO
 
 #define VGENERIC_DO(name, element)                                      \
-    void helper_v##name(ppc_avr_t *r, ppc_avr_t *b)                     \
+    void HELPER(v##name)(ppc_avr_t *r, ppc_avr_t *b)                    \
     {                                                                   \
         int i;                                                          \
                                                                         \
@@ -2113,24 +2118,24 @@ VGENERIC_DO(popcntd, u64)
 
 #undef VGENERIC_DO
 
-void helper_VADDUQM(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
+void HELPER(VADDUQM)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
     r->s128 = int128_add(a->s128, b->s128);
 }
 
-void helper_VADDEUQM(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
+void HELPER(VADDEUQM)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
 {
     r->s128 = int128_add(int128_add(a->s128, b->s128),
                          int128_make64(int128_getlo(c->s128) & 1));
 }
 
-void helper_VADDCUQ(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
+void HELPER(VADDCUQ)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
     r->VsrD(1) = int128_ult(int128_not(a->s128), b->s128);
     r->VsrD(0) = 0;
 }
 
-void helper_VADDECUQ(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
+void HELPER(VADDECUQ)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
 {
     bool carry_out = int128_ult(int128_not(a->s128), b->s128),
          carry_in = int128_getlo(c->s128) & 1;
@@ -2144,18 +2149,18 @@ void helper_VADDECUQ(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
     r->VsrD(1) = carry_out;
 }
 
-void helper_VSUBUQM(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
+void HELPER(VSUBUQM)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
     r->s128 = int128_sub(a->s128, b->s128);
 }
 
-void helper_VSUBEUQM(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
+void HELPER(VSUBEUQM)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
 {
     r->s128 = int128_add(int128_add(a->s128, int128_not(b->s128)),
                          int128_make64(int128_getlo(c->s128) & 1));
 }
 
-void helper_VSUBCUQ(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
+void HELPER(VSUBCUQ)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
     Int128 tmp = int128_not(b->s128);
 
@@ -2164,7 +2169,7 @@ void helper_VSUBCUQ(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
     r->VsrD(0) = 0;
 }
 
-void helper_VSUBECUQ(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
+void HELPER(VSUBECUQ)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
 {
     Int128 tmp = int128_not(b->s128);
     bool carry_out = int128_ult(int128_not(a->s128), tmp),
@@ -2348,7 +2353,7 @@ static void bcd_sub_mag(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b, int *invalid,
     *overflow = carry;
 }
 
-uint32_t helper_BCDADD(ppc_avr_t *r,  ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
+uint32_t HELPER(BCDADD)(ppc_avr_t *r,  ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
 {
 
     int sgna = bcd_get_sgn(a);
@@ -2395,7 +2400,7 @@ uint32_t helper_BCDADD(ppc_avr_t *r,  ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
     return cr;
 }
 
-uint32_t helper_BCDSUB(ppc_avr_t *r,  ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
+uint32_t HELPER(BCDSUB)(ppc_avr_t *r,  ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
 {
     ppc_avr_t bcopy = *b;
     int sgnb = bcd_get_sgn(b);
@@ -2406,10 +2411,10 @@ uint32_t helper_BCDSUB(ppc_avr_t *r,  ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
     }
     /* else invalid ... defer to bcdadd code for proper handling */
 
-    return helper_BCDADD(r, a, &bcopy, ps);
+    return HELPER(BCDADD)(r, a, &bcopy, ps);
 }
 
-uint32_t helper_BCDCFN(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
+uint32_t HELPER(BCDCFN)(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
 {
     int i;
     int cr = 0;
@@ -2445,7 +2450,7 @@ uint32_t helper_BCDCFN(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
     return cr;
 }
 
-uint32_t helper_BCDCTN(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
+uint32_t HELPER(BCDCTN)(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
 {
     int i;
     int cr = 0;
@@ -2479,7 +2484,7 @@ uint32_t helper_BCDCTN(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
     return cr;
 }
 
-uint32_t helper_BCDCFZ(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
+uint32_t HELPER(BCDCFZ)(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
 {
     int i;
     int cr = 0;
@@ -2523,7 +2528,7 @@ uint32_t helper_BCDCFZ(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
     return cr;
 }
 
-uint32_t helper_BCDCTZ(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
+uint32_t HELPER(BCDCTZ)(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
 {
     int i;
     int cr = 0;
@@ -2582,7 +2587,7 @@ static inline int ucmp128(uint64_t alo, uint64_t ahi,
         (ahi > bhi ? 1 : -1);
 }
 
-uint32_t helper_BCDCFSQ(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
+uint32_t HELPER(BCDCFSQ)(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
 {
     int i;
     int cr;
@@ -2640,7 +2645,7 @@ uint32_t helper_BCDCFSQ(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
     return cr;
 }
 
-uint32_t helper_BCDCTSQ(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
+uint32_t HELPER(BCDCTSQ)(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
 {
     uint8_t i;
     int cr;
@@ -2680,7 +2685,7 @@ uint32_t helper_BCDCTSQ(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
     return cr;
 }
 
-uint32_t helper_BCDCPSGN(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
+uint32_t HELPER(BCDCPSGN)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
 {
     int i;
     int invalid = 0;
@@ -2703,7 +2708,7 @@ uint32_t helper_BCDCPSGN(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
     return bcd_cmp_zero(r);
 }
 
-uint32_t helper_BCDSETSGN(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
+uint32_t HELPER(BCDSETSGN)(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
 {
     int sgnb = bcd_get_sgn(b);
 
@@ -2717,7 +2722,7 @@ uint32_t helper_BCDSETSGN(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
     return bcd_cmp_zero(r);
 }
 
-uint32_t helper_BCDS(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
+uint32_t HELPER(BCDS)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
 {
     int cr;
     int i = a->VsrSB(7);
@@ -2753,7 +2758,7 @@ uint32_t helper_BCDS(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
     return cr;
 }
 
-uint32_t helper_BCDUS(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
+uint32_t HELPER(BCDUS)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
 {
     int cr;
     int i;
@@ -2790,7 +2795,7 @@ uint32_t helper_BCDUS(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
     return cr;
 }
 
-uint32_t helper_BCDSR(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
+uint32_t HELPER(BCDSR)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
 {
     int cr;
     int unused = 0;
@@ -2836,7 +2841,7 @@ uint32_t helper_BCDSR(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
     return cr;
 }
 
-uint32_t helper_BCDTRUNC(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
+uint32_t HELPER(BCDTRUNC)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
 {
     uint64_t mask;
     uint32_t ox_flag = 0;
@@ -2869,7 +2874,8 @@ uint32_t helper_BCDTRUNC(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
     return bcd_cmp_zero(&ret) | ox_flag;
 }
 
-uint32_t helper_BCDUTRUNC(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
+uint32_t HELPER(BCDUTRUNC)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b,
+                           uint32_t ps)
 {
     int i;
     uint64_t mask;
@@ -2916,7 +2922,7 @@ uint32_t helper_BCDUTRUNC(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
     return ox_flag | CRF_GT;
 }
 
-void helper_vsbox(ppc_avr_t *r, ppc_avr_t *a)
+void HELPER(vsbox)(ppc_avr_t *r, ppc_avr_t *a)
 {
     int i;
     VECTOR_FOR_INORDER_I(i, u8) {
@@ -2924,7 +2930,7 @@ void helper_vsbox(ppc_avr_t *r, ppc_avr_t *a)
     }
 }
 
-void helper_vcipher(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
+void HELPER(vcipher)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
     AESState *ad = (AESState *)r;
     AESState *st = (AESState *)a;
@@ -2933,12 +2939,12 @@ void helper_vcipher(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
     aesenc_SB_SR_MC_AK(ad, st, rk, true);
 }
 
-void helper_vcipherlast(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
+void HELPER(vcipherlast)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
     aesenc_SB_SR_AK((AESState *)r, (AESState *)a, (AESState *)b, true);
 }
 
-void helper_vncipher(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
+void HELPER(vncipher)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
     AESState *ad = (AESState *)r;
     AESState *st = (AESState *)a;
@@ -2947,12 +2953,12 @@ void helper_vncipher(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
     aesdec_ISB_ISR_AK_IMC(ad, st, rk, true);
 }
 
-void helper_vncipherlast(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
+void HELPER(vncipherlast)(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
     aesdec_ISB_ISR_AK((AESState *)r, (AESState *)a, (AESState *)b, true);
 }
 
-void helper_vshasigmaw(ppc_avr_t *r,  ppc_avr_t *a, uint32_t st_six)
+void HELPER(vshasigmaw)(ppc_avr_t *r,  ppc_avr_t *a, uint32_t st_six)
 {
     int st = (st_six & 0x10) != 0;
     int six = st_six & 0xF;
@@ -2983,7 +2989,7 @@ void helper_vshasigmaw(ppc_avr_t *r,  ppc_avr_t *a, uint32_t st_six)
     }
 }
 
-void helper_vshasigmad(ppc_avr_t *r,  ppc_avr_t *a, uint32_t st_six)
+void HELPER(vshasigmad)(ppc_avr_t *r,  ppc_avr_t *a, uint32_t st_six)
 {
     int st = (st_six & 0x10) != 0;
     int six = st_six & 0xF;
@@ -3014,7 +3020,7 @@ void helper_vshasigmad(ppc_avr_t *r,  ppc_avr_t *a, uint32_t st_six)
     }
 }
 
-void helper_vpermxor(ppc_avr_t *r,  ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
+void HELPER(vpermxor)(ppc_avr_t *r,  ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
 {
     ppc_avr_t result;
     int i;
@@ -3050,7 +3056,7 @@ static inline uint32_t word_reverse(uint32_t val)
 }
 
 #define MASKBITS 16 /* Random value - to be fixed (implementation dependent) */
-target_ulong helper_brinc(target_ulong arg1, target_ulong arg2)
+target_ulong HELPER(brinc)(target_ulong arg1, target_ulong arg2)
 {
     uint32_t a, b, d, mask;
 
@@ -3061,7 +3067,7 @@ target_ulong helper_brinc(target_ulong arg1, target_ulong arg2)
     return (arg1 & ~mask) | (d & b);
 }
 
-uint32_t helper_cntlsw32(uint32_t val)
+uint32_t HELPER(cntlsw32)(uint32_t val)
 {
     if (val & 0x80000000) {
         return clz32(~val);
@@ -3070,13 +3076,13 @@ uint32_t helper_cntlsw32(uint32_t val)
     }
 }
 
-uint32_t helper_cntlzw32(uint32_t val)
+uint32_t HELPER(cntlzw32)(uint32_t val)
 {
     return clz32(val);
 }
 
 /* 440 specific */
-target_ulong helper_dlmzb(CPUPPCState *env, target_ulong high,
+target_ulong HELPER(dlmzb)(CPUPPCState *env, target_ulong high,
                           target_ulong low, uint32_t update_Rc)
 {
     target_ulong mask;
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index a20a0f9f7e0..e9043daa2cf 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -22,6 +22,7 @@
 #include "exec/memop.h"
 #include "hw/core/registerfields.h"
 #include "exec/page-protection.h"
+#include "exec/helper-head.h.inc"
 
 static inline bool ppc_env_is_little_endian(const CPUPPCState *env)
 {
@@ -230,9 +231,9 @@ EXTRACT_HELPER(IMM8, 11, 8);
 EXTRACT_HELPER(DCMX, 16, 7);
 EXTRACT_HELPER_SPLIT_3(DCMX_XV, 5, 16, 0, 1, 2, 5, 1, 6, 6);
 
-void helper_compute_fprf_float16(CPUPPCState *env, float16 arg);
-void helper_compute_fprf_float32(CPUPPCState *env, float32 arg);
-void helper_compute_fprf_float128(CPUPPCState *env, float128 arg);
+void HELPER(compute_fprf_float16)(CPUPPCState *env, float16 arg);
+void HELPER(compute_fprf_float32)(CPUPPCState *env, float32 arg);
+void HELPER(compute_fprf_float128)(CPUPPCState *env, float128 arg);
 
 /* translate.c */
 
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index dc5eab8c76c..1f0613479d5 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -73,7 +73,7 @@ static void *probe_contiguous(CPUPPCState *env, target_ulong addr, uint32_t nb,
     return NULL;
 }
 
-void helper_LMW(CPUPPCState *env, target_ulong addr, uint32_t reg)
+void HELPER(LMW)(CPUPPCState *env, target_ulong addr, uint32_t reg)
 {
     uintptr_t raddr = GETPC();
     int mmu_idx = ppc_env_mmu_index(env, false);
@@ -98,7 +98,7 @@ void helper_LMW(CPUPPCState *env, target_ulong addr, uint32_t reg)
     }
 }
 
-void helper_STMW(CPUPPCState *env, target_ulong addr, uint32_t reg)
+void HELPER(STMW)(CPUPPCState *env, target_ulong addr, uint32_t reg)
 {
     uintptr_t raddr = GETPC();
     int mmu_idx = ppc_env_mmu_index(env, false);
@@ -190,7 +190,7 @@ static void do_lsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
     env->gpr[reg] = val;
 }
 
-void helper_LSW(CPUPPCState *env, target_ulong addr,
+void HELPER(LSW)(CPUPPCState *env, target_ulong addr,
                 uint32_t nb, uint32_t reg)
 {
     do_lsw(env, addr, nb, reg, GETPC());
@@ -202,7 +202,7 @@ void helper_LSW(CPUPPCState *env, target_ulong addr,
  * this is valid, but rA won't be loaded.  For now, I'll follow the
  * spec...
  */
-void helper_LSWX(CPUPPCState *env, target_ulong addr, uint32_t reg,
+void HELPER(LSWX)(CPUPPCState *env, target_ulong addr, uint32_t reg,
                  uint32_t ra, uint32_t rb)
 {
     if (likely(xer_bc != 0)) {
@@ -218,7 +218,7 @@ void helper_LSWX(CPUPPCState *env, target_ulong addr, uint32_t reg,
     }
 }
 
-void helper_STSW(CPUPPCState *env, target_ulong addr, uint32_t nb,
+void HELPER(STSW)(CPUPPCState *env, target_ulong addr, uint32_t nb,
                  uint32_t reg)
 {
     uintptr_t raddr = GETPC();
@@ -319,13 +319,13 @@ static void dcbz_common(CPUPPCState *env, target_ulong addr,
     clear_helper_retaddr();
 }
 
-void helper_dcbz(CPUPPCState *env, target_ulong addr, int mmu_idx)
+void HELPER(dcbz)(CPUPPCState *env, target_ulong addr, int mmu_idx)
 {
     dcbz_common(env, addr, mmu_idx, env->dcache_line_size, GETPC());
 }
 
 #ifdef TARGET_PPC64
-void helper_dcbzl(CPUPPCState *env, target_ulong addr)
+void HELPER(dcbzl)(CPUPPCState *env, target_ulong addr)
 {
     int dcbz_size = env->dcache_line_size;
 
@@ -341,7 +341,7 @@ void helper_dcbzl(CPUPPCState *env, target_ulong addr)
 }
 #endif
 
-void helper_ICBI(CPUPPCState *env, target_ulong addr)
+void HELPER(ICBI)(CPUPPCState *env, target_ulong addr)
 {
     unsigned mmu_idx = cpu_mmu_index(env_cpu(env), false);
     MemOpIdx oi = make_memop_idx(MO_UL | MO_UNALN, mmu_idx);
@@ -357,7 +357,7 @@ void helper_ICBI(CPUPPCState *env, target_ulong addr)
     cpu_ldl_mmu(env, addr, oi, GETPC());
 }
 
-void helper_ICBIEP(CPUPPCState *env, target_ulong addr)
+void HELPER(ICBIEP)(CPUPPCState *env, target_ulong addr)
 {
 #if !defined(CONFIG_USER_ONLY)
     MemOpIdx oi = make_memop_idx(MO_UL | MO_UNALN, PPC_TLB_EPID_LOAD);
@@ -385,7 +385,7 @@ void helper_ICBIEP(CPUPPCState *env, target_ulong addr)
  */
 
 #define LVE(name, access, swap, element)                        \
-    void helper_##name(CPUPPCState *env, ppc_avr_t *r,          \
+    void HELPER(name)(CPUPPCState *env, ppc_avr_t *r,           \
                        target_ulong addr)                       \
     {                                                           \
         size_t n_elems = ARRAY_SIZE(r->element);                \
@@ -411,7 +411,7 @@ LVE(LVEWX, cpu_ldl_be_data_ra, bswap32, u32)
 #undef LVE
 
 #define STVE(name, access, swap, element)                               \
-    void helper_##name(CPUPPCState *env, ppc_avr_t *r,                  \
+    void HELPER(name)(CPUPPCState *env, ppc_avr_t *r,                   \
                        target_ulong addr)                               \
     {                                                                   \
         size_t n_elems = ARRAY_SIZE(r->element);                        \
@@ -441,7 +441,7 @@ STVE(STVEWX, cpu_stl_be_data_ra, bswap32, u32)
 #define GET_NB(rb) ((rb >> 56) & 0xFF)
 
 #define VSX_LXVL(name, lj)                                              \
-void helper_##name(CPUPPCState *env, target_ulong addr,                 \
+void HELPER(name)(CPUPPCState *env, target_ulong addr,                  \
                    ppc_vsr_t *xt, target_ulong rb)                      \
 {                                                                       \
     ppc_vsr_t t;                                                        \
@@ -471,7 +471,7 @@ VSX_LXVL(LXVLL, 1)
 #undef VSX_LXVL
 
 #define VSX_STXVL(name, lj)                                       \
-void helper_##name(CPUPPCState *env, target_ulong addr,           \
+void HELPER(name)(CPUPPCState *env, target_ulong addr,            \
                    ppc_vsr_t *xt, target_ulong rb)                \
 {                                                                 \
     target_ulong nb = GET_NB(rb);                                 \
@@ -504,7 +504,7 @@ VSX_STXVL(STXVLL, 1)
 #undef HI_IDX
 #undef LO_IDX
 
-void helper_tbegin(CPUPPCState *env)
+void HELPER(tbegin)(CPUPPCState *env)
 {
     /*
      * As a degenerate implementation, always fail tbegin.  The reason
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index 0e625cbb704..59e6573c863 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -31,19 +31,19 @@
 
 /*****************************************************************************/
 /* SPR accesses */
-void helper_load_dump_spr(CPUPPCState *env, uint32_t sprn)
+void HELPER(load_dump_spr)(CPUPPCState *env, uint32_t sprn)
 {
     qemu_log("Read SPR %d %03x => " TARGET_FMT_lx "\n", sprn, sprn,
              env->spr[sprn]);
 }
 
-void helper_store_dump_spr(CPUPPCState *env, uint32_t sprn)
+void HELPER(store_dump_spr)(CPUPPCState *env, uint32_t sprn)
 {
     qemu_log("Write SPR %d %03x <= " TARGET_FMT_lx "\n", sprn, sprn,
              env->spr[sprn]);
 }
 
-void helper_spr_core_write_generic(CPUPPCState *env, uint32_t sprn,
+void HELPER(spr_core_write_generic)(CPUPPCState *env, uint32_t sprn,
                                    target_ulong val)
 {
     CPUState *cs = env_cpu(env);
@@ -60,7 +60,7 @@ void helper_spr_core_write_generic(CPUPPCState *env, uint32_t sprn,
     }
 }
 
-void helper_spr_write_CTRL(CPUPPCState *env, uint32_t sprn,
+void HELPER(spr_write_CTRL)(CPUPPCState *env, uint32_t sprn,
                            target_ulong val)
 {
     CPUState *cs = env_cpu(env);
@@ -123,7 +123,7 @@ void helper_hfscr_facility_check(CPUPPCState *env, uint32_t bit,
 #endif
 }
 
-void helper_fscr_facility_check(CPUPPCState *env, uint32_t bit,
+void HELPER(fscr_facility_check)(CPUPPCState *env, uint32_t bit,
                                 uint32_t sprn, uint32_t cause)
 {
 #ifdef TARGET_PPC64
@@ -135,7 +135,7 @@ void helper_fscr_facility_check(CPUPPCState *env, uint32_t bit,
 #endif
 }
 
-void helper_msr_facility_check(CPUPPCState *env, uint32_t bit,
+void HELPER(msr_facility_check)(CPUPPCState *env, uint32_t bit,
                                uint32_t sprn, uint32_t cause)
 {
 #ifdef TARGET_PPC64
@@ -160,7 +160,7 @@ static void helper_mmcr0_facility_check(CPUPPCState *env, uint32_t bit,
 }
 #endif
 
-void helper_store_sdr1(CPUPPCState *env, target_ulong val)
+void HELPER(store_sdr1)(CPUPPCState *env, target_ulong val)
 {
     if (env->spr[SPR_SDR1] != val) {
         ppc_store_sdr1(env, val);
@@ -169,7 +169,7 @@ void helper_store_sdr1(CPUPPCState *env, target_ulong val)
 }
 
 #if defined(TARGET_PPC64)
-void helper_store_ptcr(CPUPPCState *env, target_ulong val)
+void HELPER(store_ptcr)(CPUPPCState *env, target_ulong val)
 {
     if (env->spr[SPR_PTCR] != val) {
         CPUState *cs = env_cpu(env);
@@ -210,7 +210,7 @@ void helper_store_ptcr(CPUPPCState *env, target_ulong val)
     }
 }
 
-void helper_store_pcr(CPUPPCState *env, target_ulong value)
+void HELPER(store_pcr)(CPUPPCState *env, target_ulong value)
 {
     PowerPCCPU *cpu = env_archcpu(env);
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
@@ -218,27 +218,27 @@ void helper_store_pcr(CPUPPCState *env, target_ulong value)
     env->spr[SPR_PCR] = value & pcc->pcr_mask;
 }
 
-void helper_store_ciabr(CPUPPCState *env, target_ulong value)
+void HELPER(store_ciabr)(CPUPPCState *env, target_ulong value)
 {
     ppc_store_ciabr(env, value);
 }
 
-void helper_store_dawr0(CPUPPCState *env, target_ulong value)
+void HELPER(store_dawr0)(CPUPPCState *env, target_ulong value)
 {
     ppc_store_dawr0(env, value);
 }
 
-void helper_store_dawrx0(CPUPPCState *env, target_ulong value)
+void HELPER(store_dawrx0)(CPUPPCState *env, target_ulong value)
 {
     ppc_store_dawrx0(env, value);
 }
 
-void helper_store_dawr1(CPUPPCState *env, target_ulong value)
+void HELPER(store_dawr1)(CPUPPCState *env, target_ulong value)
 {
     ppc_store_dawr1(env, value);
 }
 
-void helper_store_dawrx1(CPUPPCState *env, target_ulong value)
+void HELPER(store_dawrx1)(CPUPPCState *env, target_ulong value)
 {
     ppc_store_dawrx1(env, value);
 }
@@ -247,7 +247,7 @@ void helper_store_dawrx1(CPUPPCState *env, target_ulong value)
  * DPDES register is shared. Each bit reflects the state of the
  * doorbell interrupt of a thread of the same core.
  */
-target_ulong helper_load_dpdes(CPUPPCState *env)
+target_ulong HELPER(load_dpdes)(CPUPPCState *env)
 {
     CPUState *cs = env_cpu(env);
     CPUState *ccs;
@@ -278,7 +278,7 @@ target_ulong helper_load_dpdes(CPUPPCState *env)
     return dpdes;
 }
 
-void helper_store_dpdes(CPUPPCState *env, target_ulong val)
+void HELPER(store_dpdes)(CPUPPCState *env, target_ulong val)
 {
     PowerPCCPU *cpu = env_archcpu(env);
     CPUState *cs = env_cpu(env);
@@ -311,7 +311,7 @@ void helper_store_dpdes(CPUPPCState *env, target_ulong val)
 #include "hw/ppc/pnv_core.h"
 
 /* Indirect SCOM (SPRC/SPRD) access to SCRATCH0-7 are implemented. */
-void helper_store_sprc(CPUPPCState *env, target_ulong val)
+void HELPER(store_sprc)(CPUPPCState *env, target_ulong val)
 {
     if (val & ~0x3f8ULL) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid SPRC register value "
@@ -321,7 +321,7 @@ void helper_store_sprc(CPUPPCState *env, target_ulong val)
     env->spr[SPR_POWER_SPRC] = val;
 }
 
-target_ulong helper_load_sprd(CPUPPCState *env)
+target_ulong HELPER(load_sprd)(CPUPPCState *env)
 {
     /*
      * SPRD is a HV-only register for Power CPUs, so this will only be
@@ -337,7 +337,7 @@ target_ulong helper_load_sprd(CPUPPCState *env)
     return 0;
 }
 
-void helper_store_sprd(CPUPPCState *env, target_ulong val)
+void HELPER(store_sprd)(CPUPPCState *env, target_ulong val)
 {
     PowerPCCPU *cpu = env_archcpu(env);
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
@@ -347,7 +347,7 @@ void helper_store_sprd(CPUPPCState *env, target_ulong val)
     }
 }
 
-target_ulong helper_load_pmsr(CPUPPCState *env)
+target_ulong HELPER(load_pmsr)(CPUPPCState *env)
 {
     target_ulong lowerps = extract64(env->spr[SPR_PMCR], PPC_BIT_NR(15), 8);
     target_ulong val = 0;
@@ -367,7 +367,7 @@ static void ppc_set_pmcr(PowerPCCPU *cpu, target_ulong val)
     cpu->env.spr[SPR_PMCR] = val;
 }
 
-void helper_store_pmcr(CPUPPCState *env, target_ulong val)
+void HELPER(store_pmcr)(CPUPPCState *env, target_ulong val)
 {
     PowerPCCPU *cpu = env_archcpu(env);
     CPUState *cs = env_cpu(env);
@@ -401,13 +401,13 @@ void helper_store_pmcr(CPUPPCState *env, target_ulong val)
 
 #endif /* defined(TARGET_PPC64) */
 
-void helper_store_pidr(CPUPPCState *env, target_ulong val)
+void HELPER(store_pidr)(CPUPPCState *env, target_ulong val)
 {
     env->spr[SPR_BOOKS_PID] = (uint32_t)val;
     tlb_flush(env_cpu(env));
 }
 
-void helper_store_lpidr(CPUPPCState *env, target_ulong val)
+void HELPER(store_lpidr)(CPUPPCState *env, target_ulong val)
 {
     env->spr[SPR_LPIDR] = (uint32_t)val;
 
@@ -420,7 +420,7 @@ void helper_store_lpidr(CPUPPCState *env, target_ulong val)
     tlb_flush(env_cpu(env));
 }
 
-void helper_store_40x_dbcr0(CPUPPCState *env, target_ulong val)
+void HELPER(store_40x_dbcr0)(CPUPPCState *env, target_ulong val)
 {
     /* Bits 26 & 27 affect single-stepping. */
     hreg_compute_hflags(env);
@@ -428,7 +428,7 @@ void helper_store_40x_dbcr0(CPUPPCState *env, target_ulong val)
     store_40x_dbcr0(env, val);
 }
 
-void helper_store_40x_sler(CPUPPCState *env, target_ulong val)
+void HELPER(store_40x_sler)(CPUPPCState *env, target_ulong val)
 {
     store_40x_sler(env, val);
 }
@@ -443,7 +443,7 @@ void helper_store_40x_sler(CPUPPCState *env, target_ulong val)
  * MacOS not hang. These registers exist on some 75x and 74xx
  * processors.
  */
-void helper_fixup_thrm(CPUPPCState *env)
+void HELPER(fixup_thrm)(CPUPPCState *env)
 {
     target_ulong v, t;
     int i;
@@ -481,7 +481,7 @@ void helper_fixup_thrm(CPUPPCState *env)
 
 #if !defined(CONFIG_USER_ONLY)
 #if defined(TARGET_PPC64)
-void helper_clrbhrb(CPUPPCState *env)
+void HELPER(clrbhrb)(CPUPPCState *env)
 {
     helper_hfscr_facility_check(env, HFSCR_BHRB, "clrbhrb", FSCR_IC_BHRB);
 
@@ -492,7 +492,7 @@ void helper_clrbhrb(CPUPPCState *env)
     }
 }
 
-uint64_t helper_mfbhrbe(CPUPPCState *env, uint32_t bhrbe)
+uint64_t HELPER(mfbhrbe)(CPUPPCState *env, uint32_t bhrbe)
 {
     unsigned int index;
 
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 2c33d98001d..e5238f0c245 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -104,7 +104,7 @@ void dump_slb(PowerPCCPU *cpu)
 }
 
 #ifdef CONFIG_TCG
-void helper_SLBIA(CPUPPCState *env, uint32_t ih)
+void HELPER(SLBIA)(CPUPPCState *env, uint32_t ih)
 {
     PowerPCCPU *cpu = env_archcpu(env);
     int starting_entry;
@@ -177,7 +177,7 @@ void helper_SLBIA(CPUPPCState *env, uint32_t ih)
 }
 
 #if defined(TARGET_PPC64)
-void helper_SLBIAG(CPUPPCState *env, target_ulong rs, uint32_t l)
+void HELPER(SLBIAG)(CPUPPCState *env, target_ulong rs, uint32_t l)
 {
     PowerPCCPU *cpu = env_archcpu(env);
     int n;
@@ -227,12 +227,12 @@ static void __helper_slbie(CPUPPCState *env, target_ulong addr,
     }
 }
 
-void helper_SLBIE(CPUPPCState *env, target_ulong addr)
+void HELPER(SLBIE)(CPUPPCState *env, target_ulong addr)
 {
     __helper_slbie(env, addr, false);
 }
 
-void helper_SLBIEG(CPUPPCState *env, target_ulong addr)
+void HELPER(SLBIEG)(CPUPPCState *env, target_ulong addr)
 {
     __helper_slbie(env, addr, true);
 }
@@ -339,7 +339,7 @@ static int ppc_find_slb_vsid(PowerPCCPU *cpu, target_ulong rb,
     return 0;
 }
 
-void helper_SLBMTE(CPUPPCState *env, target_ulong rb, target_ulong rs)
+void HELPER(SLBMTE)(CPUPPCState *env, target_ulong rb, target_ulong rs)
 {
     PowerPCCPU *cpu = env_archcpu(env);
 
@@ -349,7 +349,7 @@ void helper_SLBMTE(CPUPPCState *env, target_ulong rb, target_ulong rs)
     }
 }
 
-target_ulong helper_SLBMFEE(CPUPPCState *env, target_ulong rb)
+target_ulong HELPER(SLBMFEE)(CPUPPCState *env, target_ulong rb)
 {
     PowerPCCPU *cpu = env_archcpu(env);
     target_ulong rt = 0;
@@ -361,7 +361,7 @@ target_ulong helper_SLBMFEE(CPUPPCState *env, target_ulong rb)
     return rt;
 }
 
-target_ulong helper_SLBFEE(CPUPPCState *env, target_ulong rb)
+target_ulong HELPER(SLBFEE)(CPUPPCState *env, target_ulong rb)
 {
     PowerPCCPU *cpu = env_archcpu(env);
     target_ulong rt = 0;
@@ -373,7 +373,7 @@ target_ulong helper_SLBFEE(CPUPPCState *env, target_ulong rb)
     return rt;
 }
 
-target_ulong helper_SLBMFEV(CPUPPCState *env, target_ulong rb)
+target_ulong HELPER(SLBMFEV)(CPUPPCState *env, target_ulong rb)
 {
     PowerPCCPU *cpu = env_archcpu(env);
     target_ulong rt = 0;
@@ -1220,7 +1220,7 @@ void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu, target_ulong ptex,
 }
 
 #ifdef CONFIG_TCG
-void helper_store_lpcr(CPUPPCState *env, target_ulong val)
+void HELPER(store_lpcr)(CPUPPCState *env, target_ulong val)
 {
     PowerPCCPU *cpu = env_archcpu(env);
 
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index ac607054027..5a3e3a7beab 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -179,7 +179,7 @@ static inline void dump_store_bat(CPUPPCState *env, char ID, int ul, int nr,
                   value, env->nip);
 }
 
-void helper_store_ibatu(CPUPPCState *env, uint32_t nr, target_ulong value)
+void HELPER(store_ibatu)(CPUPPCState *env, uint32_t nr, target_ulong value)
 {
     target_ulong mask;
 
@@ -206,13 +206,13 @@ void helper_store_ibatu(CPUPPCState *env, uint32_t nr, target_ulong value)
     }
 }
 
-void helper_store_ibatl(CPUPPCState *env, uint32_t nr, target_ulong value)
+void HELPER(store_ibatl)(CPUPPCState *env, uint32_t nr, target_ulong value)
 {
     dump_store_bat(env, 'I', 1, nr, value);
     env->IBAT[1][nr] = value;
 }
 
-void helper_store_dbatu(CPUPPCState *env, uint32_t nr, target_ulong value)
+void HELPER(store_dbatu)(CPUPPCState *env, uint32_t nr, target_ulong value)
 {
     target_ulong mask;
 
@@ -239,7 +239,7 @@ void helper_store_dbatu(CPUPPCState *env, uint32_t nr, target_ulong value)
     }
 }
 
-void helper_store_dbatl(CPUPPCState *env, uint32_t nr, target_ulong value)
+void HELPER(store_dbatl)(CPUPPCState *env, uint32_t nr, target_ulong value)
 {
     dump_store_bat(env, 'D', 1, nr, value);
     env->DBAT[1][nr] = value;
@@ -328,7 +328,7 @@ void ppc_tlb_invalidate_one(CPUPPCState *env, target_ulong addr)
 /* Special registers manipulation */
 
 /* Segment registers load and store */
-target_ulong helper_load_sr(CPUPPCState *env, target_ulong sr_num)
+target_ulong HELPER(load_sr)(CPUPPCState *env, target_ulong sr_num)
 {
 #if defined(TARGET_PPC64)
     if (mmu_is_64bit(env->mmu_model)) {
@@ -339,7 +339,7 @@ target_ulong helper_load_sr(CPUPPCState *env, target_ulong sr_num)
     return env->sr[sr_num];
 }
 
-void helper_store_sr(CPUPPCState *env, target_ulong srnum, target_ulong value)
+void HELPER(store_sr)(CPUPPCState *env, target_ulong srnum, target_ulong value)
 {
     qemu_log_mask(CPU_LOG_MMU,
             "%s: reg=%d " TARGET_FMT_lx " " TARGET_FMT_lx "\n", __func__,
@@ -383,12 +383,12 @@ void helper_store_sr(CPUPPCState *env, target_ulong srnum, target_ulong value)
 }
 
 /* TLB management */
-void helper_tlbia(CPUPPCState *env)
+void HELPER(tlbia)(CPUPPCState *env)
 {
     ppc_tlb_invalidate_all(env);
 }
 
-void helper_tlbie(CPUPPCState *env, target_ulong addr)
+void HELPER(tlbie)(CPUPPCState *env, target_ulong addr)
 {
     ppc_tlb_invalidate_one(env, addr);
 }
@@ -418,7 +418,7 @@ void helper_tlbie(CPUPPCState *env, target_ulong addr)
 #define TLBIE_RB_IS_MASK    PPC_BITMASK(52, 53)
 #define TLBIE_RB_AP_MASK    PPC_BITMASK(56, 58)
 
-void helper_tlbie_isa300(CPUPPCState *env, target_ulong rb, target_ulong rs,
+void HELPER(tlbie_isa300)(CPUPPCState *env, target_ulong rb, target_ulong rs,
                          uint32_t flags)
 {
     unsigned ric = (flags & TLBIE_F_RIC_MASK) >> TLBIE_F_RIC_SHIFT;
@@ -547,7 +547,7 @@ invalid:
 
 #endif
 
-void helper_tlbiva(CPUPPCState *env, target_ulong addr)
+void HELPER(tlbiva)(CPUPPCState *env, target_ulong addr)
 {
     /* tlbiva instruction only exists on BookE */
     assert(env->mmu_model == POWERPC_MMU_BOOKE);
@@ -580,12 +580,12 @@ static void do_6xx_tlb(CPUPPCState *env, target_ulong new_EPN, int is_code)
                      way, is_code, CMP, RPN);
 }
 
-void helper_6xx_tlbd(CPUPPCState *env, target_ulong EPN)
+void HELPER(6xx_tlbd)(CPUPPCState *env, target_ulong EPN)
 {
     do_6xx_tlb(env, EPN, 0);
 }
 
-void helper_6xx_tlbi(CPUPPCState *env, target_ulong EPN)
+void HELPER(6xx_tlbi)(CPUPPCState *env, target_ulong EPN)
 {
     do_6xx_tlb(env, EPN, 1);
 }
@@ -674,7 +674,7 @@ static inline int booke_page_size_to_tlb(target_ulong page_size)
 #define PPC4XX_TLBLO_ATTR_MASK      0x000000FF
 #define PPC4XX_TLBLO_RPN_MASK       0xFFFFFC00
 
-void helper_store_40x_pid(CPUPPCState *env, target_ulong val)
+void HELPER(store_40x_pid)(CPUPPCState *env, target_ulong val)
 {
     if (env->spr[SPR_40x_PID] != val) {
         env->spr[SPR_40x_PID] = val;
@@ -682,7 +682,7 @@ void helper_store_40x_pid(CPUPPCState *env, target_ulong val)
     }
 }
 
-target_ulong helper_4xx_tlbre_hi(CPUPPCState *env, target_ulong entry)
+target_ulong HELPER(4xx_tlbre_hi)(CPUPPCState *env, target_ulong entry)
 {
     ppcemb_tlb_t *tlb;
     target_ulong ret;
@@ -699,11 +699,11 @@ target_ulong helper_4xx_tlbre_hi(CPUPPCState *env, target_ulong entry)
         size = PPC4XX_TLBHI_SIZE_DEFAULT;
     }
     ret |= size << PPC4XX_TLBHI_SIZE_SHIFT;
-    helper_store_40x_pid(env, tlb->PID);
+    HELPER(store_40x_pid)(env, tlb->PID);
     return ret;
 }
 
-target_ulong helper_4xx_tlbre_lo(CPUPPCState *env, target_ulong entry)
+target_ulong HELPER(4xx_tlbre_lo)(CPUPPCState *env, target_ulong entry)
 {
     ppcemb_tlb_t *tlb;
     target_ulong ret;
@@ -738,7 +738,7 @@ static void ppcemb_tlb_flush(CPUState *cs, ppcemb_tlb_t *tlb)
                               TARGET_LONG_BITS);
 }
 
-void helper_4xx_tlbwe_hi(CPUPPCState *env, target_ulong entry,
+void HELPER(4xx_tlbwe_hi)(CPUPPCState *env, target_ulong entry,
                          target_ulong val)
 {
     CPUState *cs = env_cpu(env);
@@ -790,7 +790,7 @@ void helper_4xx_tlbwe_hi(CPUPPCState *env, target_ulong entry,
                   tlb->prot & PAGE_VALID ? 'v' : '-', (int)tlb->PID);
 }
 
-void helper_4xx_tlbwe_lo(CPUPPCState *env, target_ulong entry,
+void HELPER(4xx_tlbwe_lo)(CPUPPCState *env, target_ulong entry,
                          target_ulong val)
 {
     CPUState *cs = env_cpu(env);
@@ -826,7 +826,7 @@ void helper_4xx_tlbwe_lo(CPUPPCState *env, target_ulong entry,
                   tlb->prot & PAGE_VALID ? 'v' : '-', (int)tlb->PID);
 }
 
-target_ulong helper_4xx_tlbsx(CPUPPCState *env, target_ulong address)
+target_ulong HELPER(4xx_tlbsx)(CPUPPCState *env, target_ulong address)
 {
     return ppcemb_tlb_search(env, address, env->spr[SPR_40x_PID]);
 }
@@ -851,7 +851,7 @@ static bool mmubooke_pid_match(CPUPPCState *env, ppcemb_tlb_t *tlb)
 }
 
 /* PowerPC 440 TLB management */
-void helper_440_tlbwe(CPUPPCState *env, uint32_t word, target_ulong entry,
+void HELPER(440_tlbwe)(CPUPPCState *env, uint32_t word, target_ulong entry,
                       target_ulong value)
 {
     ppcemb_tlb_t *tlb;
@@ -912,7 +912,7 @@ void helper_440_tlbwe(CPUPPCState *env, uint32_t word, target_ulong entry,
     }
 }
 
-target_ulong helper_440_tlbre(CPUPPCState *env, uint32_t word,
+target_ulong HELPER(440_tlbre)(CPUPPCState *env, uint32_t word,
                               target_ulong entry)
 {
     ppcemb_tlb_t *tlb;
@@ -968,7 +968,7 @@ target_ulong helper_440_tlbre(CPUPPCState *env, uint32_t word,
     return ret;
 }
 
-target_ulong helper_440_tlbsx(CPUPPCState *env, target_ulong address)
+target_ulong HELPER(440_tlbsx)(CPUPPCState *env, target_ulong address)
 {
     return ppcemb_tlb_search(env, address, env->spr[SPR_440_MMUCR] & 0xFF);
 }
@@ -992,19 +992,19 @@ static ppcmas_tlb_t *booke206_cur_tlb(CPUPPCState *env)
     return booke206_get_tlbm(env, tlb, ea, esel);
 }
 
-void helper_booke_setpid(CPUPPCState *env, uint32_t pidn, target_ulong pid)
+void HELPER(booke_setpid)(CPUPPCState *env, uint32_t pidn, target_ulong pid)
 {
     env->spr[pidn] = pid;
     /* changing PIDs mean we're in a different address space now */
     tlb_flush(env_cpu(env));
 }
 
-void helper_booke_set_eplc(CPUPPCState *env, target_ulong val)
+void HELPER(booke_set_eplc)(CPUPPCState *env, target_ulong val)
 {
     env->spr[SPR_BOOKE_EPLC] = val & EPID_MASK;
     tlb_flush_by_mmuidx(env_cpu(env), 1 << PPC_TLB_EPID_LOAD);
 }
-void helper_booke_set_epsc(CPUPPCState *env, target_ulong val)
+void HELPER(booke_set_epsc)(CPUPPCState *env, target_ulong val)
 {
     env->spr[SPR_BOOKE_EPSC] = val & EPID_MASK;
     tlb_flush_by_mmuidx(env_cpu(env), 1 << PPC_TLB_EPID_STORE);
@@ -1019,7 +1019,7 @@ static inline void flush_page(CPUPPCState *env, ppcmas_tlb_t *tlb)
     }
 }
 
-void helper_booke206_tlbwe(CPUPPCState *env)
+void HELPER(booke206_tlbwe)(CPUPPCState *env)
 {
     uint32_t tlbncfg, tlbn;
     ppcmas_tlb_t *tlb;
@@ -1147,7 +1147,7 @@ static inline void booke206_tlb_to_mas(CPUPPCState *env, ppcmas_tlb_t *tlb)
     env->spr[SPR_BOOKE_MAS7] = tlb->mas7_3 >> 32;
 }
 
-void helper_booke206_tlbre(CPUPPCState *env)
+void HELPER(booke206_tlbre)(CPUPPCState *env)
 {
     ppcmas_tlb_t *tlb = NULL;
 
@@ -1159,7 +1159,7 @@ void helper_booke206_tlbre(CPUPPCState *env)
     }
 }
 
-void helper_booke206_tlbsx(CPUPPCState *env, target_ulong address)
+void HELPER(booke206_tlbsx)(CPUPPCState *env, target_ulong address)
 {
     ppcmas_tlb_t *tlb = NULL;
     int i, j;
@@ -1233,7 +1233,7 @@ static inline void booke206_invalidate_ea_tlb(CPUPPCState *env, int tlbn,
     }
 }
 
-void helper_booke206_tlbivax(CPUPPCState *env, target_ulong address)
+void HELPER(booke206_tlbivax)(CPUPPCState *env, target_ulong address)
 {
     CPUState *cs;
 
@@ -1264,13 +1264,13 @@ void helper_booke206_tlbivax(CPUPPCState *env, target_ulong address)
     }
 }
 
-void helper_booke206_tlbilx0(CPUPPCState *env, target_ulong address)
+void HELPER(booke206_tlbilx0)(CPUPPCState *env, target_ulong address)
 {
     /* XXX missing LPID handling */
     booke206_flush_tlb(env, -1, 1);
 }
 
-void helper_booke206_tlbilx1(CPUPPCState *env, target_ulong address)
+void HELPER(booke206_tlbilx1)(CPUPPCState *env, target_ulong address)
 {
     int i, j;
     int tid = (env->spr[SPR_BOOKE_MAS6] & MAS6_SPID);
@@ -1291,7 +1291,7 @@ void helper_booke206_tlbilx1(CPUPPCState *env, target_ulong address)
     tlb_flush(env_cpu(env));
 }
 
-void helper_booke206_tlbilx3(CPUPPCState *env, target_ulong address)
+void HELPER(booke206_tlbilx3)(CPUPPCState *env, target_ulong address)
 {
     int i, j;
     ppcmas_tlb_t *tlb;
@@ -1331,7 +1331,7 @@ void helper_booke206_tlbilx3(CPUPPCState *env, target_ulong address)
     tlb_flush(env_cpu(env));
 }
 
-void helper_booke206_tlbflush(CPUPPCState *env, target_ulong type)
+void HELPER(booke206_tlbflush)(CPUPPCState *env, target_ulong type)
 {
     int flags = 0;
 
@@ -1347,12 +1347,12 @@ void helper_booke206_tlbflush(CPUPPCState *env, target_ulong type)
 }
 
 
-void helper_check_tlb_flush_local(CPUPPCState *env)
+void HELPER(check_tlb_flush_local)(CPUPPCState *env)
 {
     check_tlb_flush(env, false);
 }
 
-void helper_check_tlb_flush_global(CPUPPCState *env)
+void HELPER(check_tlb_flush_global)(CPUPPCState *env)
 {
     check_tlb_flush(env, true);
 }
diff --git a/target/ppc/power8-pmu.c b/target/ppc/power8-pmu.c
index 2a7a5b493af..772e257e87a 100644
--- a/target/ppc/power8-pmu.c
+++ b/target/ppc/power8-pmu.c
@@ -286,7 +286,7 @@ static void pmu_delete_timers(CPUPPCState *env)
     }
 }
 
-void helper_store_mmcr0(CPUPPCState *env, target_ulong value)
+void HELPER(store_mmcr0)(CPUPPCState *env, target_ulong value)
 {
     pmu_update_cycles(env);
 
@@ -298,7 +298,7 @@ void helper_store_mmcr0(CPUPPCState *env, target_ulong value)
     pmu_update_overflow_timers(env);
 }
 
-void helper_store_mmcr1(CPUPPCState *env, uint64_t value)
+void HELPER(store_mmcr1)(CPUPPCState *env, uint64_t value)
 {
     pmu_update_cycles(env);
 
@@ -307,21 +307,21 @@ void helper_store_mmcr1(CPUPPCState *env, uint64_t value)
     pmu_mmcr01a_updated(env);
 }
 
-void helper_store_mmcrA(CPUPPCState *env, uint64_t value)
+void HELPER(store_mmcrA)(CPUPPCState *env, uint64_t value)
 {
     env->spr[SPR_POWER_MMCRA] = value;
 
     pmu_mmcr01a_updated(env);
 }
 
-target_ulong helper_read_pmc(CPUPPCState *env, uint32_t sprn)
+target_ulong HELPER(read_pmc)(CPUPPCState *env, uint32_t sprn)
 {
     pmu_update_cycles(env);
 
     return env->spr[sprn];
 }
 
-void helper_store_pmc(CPUPPCState *env, uint32_t sprn, uint64_t value)
+void HELPER(store_pmc)(CPUPPCState *env, uint32_t sprn, uint64_t value)
 {
     pmu_update_cycles(env);
 
@@ -360,14 +360,14 @@ static void perfm_alert(PowerPCCPU *cpu)
     raise_ebb_perfm_exception(env);
 }
 
-void helper_handle_pmc5_overflow(CPUPPCState *env)
+void HELPER(handle_pmc5_overflow)(CPUPPCState *env)
 {
     env->spr[SPR_POWER_PMC5] = PMC_COUNTER_NEGATIVE_VAL;
     perfm_alert(env_archcpu(env));
 }
 
 /* This helper assumes that the PMC is running. */
-void helper_insns_inc(CPUPPCState *env, uint32_t num_insns)
+void HELPER(insns_inc)(CPUPPCState *env, uint32_t num_insns)
 {
     bool overflow_triggered;
 
diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index 93aedb0c8e2..6ff24e8b719 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -44,13 +44,13 @@ void raise_exception_err_ra(CPUPPCState *env, uint32_t exception,
     cpu_loop_exit_restore(cs, raddr);
 }
 
-void helper_raise_exception_err(CPUPPCState *env, uint32_t exception,
+void HELPER(raise_exception_err)(CPUPPCState *env, uint32_t exception,
                                 uint32_t error_code)
 {
     raise_exception_err_ra(env, exception, error_code, 0);
 }
 
-void helper_raise_exception(CPUPPCState *env, uint32_t exception)
+void HELPER(raise_exception)(CPUPPCState *env, uint32_t exception)
 {
     raise_exception_err_ra(env, exception, 0, 0);
 }
@@ -70,7 +70,7 @@ static G_NORETURN void raise_exception(CPUPPCState *env, uint32_t exception)
 
 #endif /* !CONFIG_USER_ONLY */
 
-void helper_TW(CPUPPCState *env, target_ulong arg1, target_ulong arg2,
+void HELPER(TW)(CPUPPCState *env, target_ulong arg1, target_ulong arg2,
                uint32_t flags)
 {
     if (!likely(!(((int32_t)arg1 < (int32_t)arg2 && (flags & 0x10)) ||
@@ -84,7 +84,7 @@ void helper_TW(CPUPPCState *env, target_ulong arg1, target_ulong arg2,
 }
 
 #ifdef TARGET_PPC64
-void helper_TD(CPUPPCState *env, target_ulong arg1, target_ulong arg2,
+void HELPER(TD)(CPUPPCState *env, target_ulong arg1, target_ulong arg2,
                uint32_t flags)
 {
     if (!likely(!(((int64_t)arg1 < (int64_t)arg2 && (flags & 0x10)) ||
@@ -181,7 +181,7 @@ static void do_hash(CPUPPCState *env, target_ulong ea, target_ulong ra,
 
 #ifdef TARGET_PPC64
 #define HELPER_HASH(op, key, store, dexcr_aspect)                             \
-void helper_##op(CPUPPCState *env, target_ulong ea, target_ulong ra,          \
+void HELPER(op)(CPUPPCState *env, target_ulong ea, target_ulong ra,           \
                  target_ulong rb)                                             \
 {                                                                             \
     if (env->msr & R_MSR_PR_MASK) {                                           \
@@ -201,7 +201,7 @@ void helper_##op(CPUPPCState *env, target_ulong ea, target_ulong ra,          \
 }
 #else
 #define HELPER_HASH(op, key, store, dexcr_aspect)                             \
-void helper_##op(CPUPPCState *env, target_ulong ea, target_ulong ra,          \
+void HELPER(op)(CPUPPCState *env, target_ulong ea, target_ulong ra,           \
                  target_ulong rb)                                             \
 {                                                                             \
     do_hash(env, ea, ra, rb, key, store);                                     \
@@ -439,7 +439,7 @@ uint32_t ppc_ldl_code(CPUArchState *env, target_ulong addr)
 }
 
 #if defined(TARGET_PPC64)
-void helper_attn(CPUPPCState *env)
+void HELPER(attn)(CPUPPCState *env)
 {
     /* POWER attn is unprivileged when enabled by HID, otherwise illegal */
     if ((*env->check_attn)(env)) {
@@ -450,7 +450,7 @@ void helper_attn(CPUPPCState *env)
     }
 }
 
-void helper_scv(CPUPPCState *env, uint32_t lev)
+void HELPER(scv)(CPUPPCState *env, uint32_t lev)
 {
     if (env->spr[SPR_FSCR] & (1ull << FSCR_SCV)) {
         raise_exception_err(env, POWERPC_EXCP_SYSCALL_VECTORED, lev);
@@ -459,7 +459,7 @@ void helper_scv(CPUPPCState *env, uint32_t lev)
     }
 }
 
-void helper_PMINSN(CPUPPCState *env, uint32_t insn)
+void HELPER(PMINSN)(CPUPPCState *env, uint32_t insn)
 {
     CPUState *cs = env_cpu(env);
 
@@ -479,7 +479,7 @@ void helper_PMINSN(CPUPPCState *env, uint32_t insn)
 }
 
 #endif /* TARGET_PPC64 */
-void helper_store_msr(CPUPPCState *env, target_ulong val)
+void HELPER(store_msr)(CPUPPCState *env, target_ulong val)
 {
     uint32_t excp = hreg_store_msr(env, val, 0);
 
@@ -489,7 +489,7 @@ void helper_store_msr(CPUPPCState *env, target_ulong val)
     }
 }
 
-void helper_ppc_maybe_interrupt(CPUPPCState *env)
+void HELPER(ppc_maybe_interrupt)(CPUPPCState *env)
 {
     ppc_maybe_interrupt(env);
 }
@@ -528,13 +528,13 @@ static void do_rfi(CPUPPCState *env, target_ulong nip, target_ulong msr)
     check_tlb_flush(env, false);
 }
 
-void helper_RFI(CPUPPCState *env)
+void HELPER(RFI)(CPUPPCState *env)
 {
     do_rfi(env, env->spr[SPR_SRR0], env->spr[SPR_SRR1] & 0xfffffffful);
 }
 
 #ifdef TARGET_PPC64
-void helper_RFID(CPUPPCState *env)
+void HELPER(RFID)(CPUPPCState *env)
 {
     /*
      * The architecture defines a number of rules for which bits can
@@ -545,17 +545,17 @@ void helper_RFID(CPUPPCState *env)
     do_rfi(env, env->spr[SPR_SRR0], env->spr[SPR_SRR1]);
 }
 
-void helper_RFSCV(CPUPPCState *env)
+void HELPER(RFSCV)(CPUPPCState *env)
 {
     do_rfi(env, env->lr, env->ctr);
 }
 
-void helper_HRFID(CPUPPCState *env)
+void HELPER(HRFID)(CPUPPCState *env)
 {
     do_rfi(env, env->spr[SPR_HSRR0], env->spr[SPR_HSRR1]);
 }
 
-void helper_rfebb(CPUPPCState *env, target_ulong s)
+void HELPER(rfebb)(CPUPPCState *env, target_ulong s)
 {
     target_ulong msr = env->msr;
 
@@ -601,7 +601,7 @@ static void do_ebb(CPUPPCState *env, int ebb_excp)
      * FSCR_EBB and FSCR_IC_EBB are the same bits used with
      * HFSCR.
      */
-    helper_fscr_facility_check(env, FSCR_EBB, 0, FSCR_IC_EBB);
+    HELPER(fscr_facility_check)(env, FSCR_EBB, 0, FSCR_IC_EBB);
     helper_hfscr_facility_check(env, FSCR_EBB, "EBB", FSCR_IC_EBB);
 
     if (ebb_excp == POWERPC_EXCP_PERFM_EBB) {
@@ -633,23 +633,23 @@ void raise_ebb_perfm_exception(CPUPPCState *env)
 
 /*****************************************************************************/
 /* Embedded PowerPC specific helpers */
-void helper_40x_rfci(CPUPPCState *env)
+void HELPER(40x_rfci)(CPUPPCState *env)
 {
     do_rfi(env, env->spr[SPR_40x_SRR2], env->spr[SPR_40x_SRR3]);
 }
 
-void helper_rfci(CPUPPCState *env)
+void HELPER(rfci)(CPUPPCState *env)
 {
     do_rfi(env, env->spr[SPR_BOOKE_CSRR0], env->spr[SPR_BOOKE_CSRR1]);
 }
 
-void helper_rfdi(CPUPPCState *env)
+void HELPER(rfdi)(CPUPPCState *env)
 {
     /* FIXME: choose CSRR1 or DSRR1 based on cpu type */
     do_rfi(env, env->spr[SPR_BOOKE_DSRR0], env->spr[SPR_BOOKE_DSRR1]);
 }
 
-void helper_rfmci(CPUPPCState *env)
+void HELPER(rfmci)(CPUPPCState *env)
 {
     /* FIXME: choose CSRR1 or MCSRR1 based on cpu type */
     do_rfi(env, env->spr[SPR_BOOKE_MCSRR0], env->spr[SPR_BOOKE_MCSRR1]);
@@ -679,7 +679,7 @@ static int dbell2irq(target_ulong rb)
     return irq;
 }
 
-void helper_msgclr(CPUPPCState *env, target_ulong rb)
+void HELPER(msgclr)(CPUPPCState *env, target_ulong rb)
 {
     int irq = dbell2irq(rb);
 
@@ -690,7 +690,7 @@ void helper_msgclr(CPUPPCState *env, target_ulong rb)
     ppc_set_irq(env_archcpu(env), irq, 0);
 }
 
-void helper_msgsnd(target_ulong rb)
+void HELPER(msgsnd)(target_ulong rb)
 {
     int irq = dbell2irq(rb);
     int pir = rb & DBELL_PIRTAG_MASK;
@@ -762,7 +762,7 @@ static void msgsnd_core_tir(CPUPPCState *env, uint32_t target_tir, int irq)
     }
 }
 
-void helper_book3s_msgclr(CPUPPCState *env, target_ulong rb)
+void HELPER(book3s_msgclr)(CPUPPCState *env, target_ulong rb)
 {
     if (!dbell_type_server(rb)) {
         return;
@@ -771,7 +771,7 @@ void helper_book3s_msgclr(CPUPPCState *env, target_ulong rb)
     ppc_set_irq(env_archcpu(env), PPC_INTERRUPT_HDOORBELL, 0);
 }
 
-void helper_book3s_msgsnd(CPUPPCState *env, target_ulong rb)
+void HELPER(book3s_msgsnd)(CPUPPCState *env, target_ulong rb)
 {
     int pir = rb & DBELL_PROCIDTAG_MASK;
     bool brdcast = false;
@@ -818,7 +818,7 @@ void helper_book3s_msgsnd(CPUPPCState *env, target_ulong rb)
 }
 
 #ifdef TARGET_PPC64
-void helper_book3s_msgclrp(CPUPPCState *env, target_ulong rb)
+void HELPER(book3s_msgclrp)(CPUPPCState *env, target_ulong rb)
 {
     helper_hfscr_facility_check(env, HFSCR_MSGP, "msgclrp", HFSCR_IC_MSGP);
 
@@ -833,7 +833,7 @@ void helper_book3s_msgclrp(CPUPPCState *env, target_ulong rb)
  * sends a message to another thread  on the same
  * multi-threaded processor
  */
-void helper_book3s_msgsndp(CPUPPCState *env, target_ulong rb)
+void HELPER(book3s_msgsndp)(CPUPPCState *env, target_ulong rb)
 {
     helper_hfscr_facility_check(env, HFSCR_MSGP, "msgsndp", HFSCR_IC_MSGP);
 
@@ -846,7 +846,7 @@ void helper_book3s_msgsndp(CPUPPCState *env, target_ulong rb)
 #endif /* TARGET_PPC64 */
 
 /* Single-step tracing */
-void helper_book3s_trace(CPUPPCState *env, target_ulong prev_ip)
+void HELPER(book3s_trace)(CPUPPCState *env, target_ulong prev_ip)
 {
     uint32_t error_code = 0;
     if (env->insns_flags2 & PPC2_ISA207) {
diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
index 7209b418fb6..f345be22caa 100644
--- a/target/ppc/timebase_helper.c
+++ b/target/ppc/timebase_helper.c
@@ -26,38 +26,38 @@
 /*****************************************************************************/
 /* SPR accesses */
 
-target_ulong helper_load_tbl(CPUPPCState *env)
+target_ulong HELPER(load_tbl)(CPUPPCState *env)
 {
     return (target_ulong)cpu_ppc_load_tbl(env);
 }
 
-target_ulong helper_load_tbu(CPUPPCState *env)
+target_ulong HELPER(load_tbu)(CPUPPCState *env)
 {
     return cpu_ppc_load_tbu(env);
 }
 
-target_ulong helper_load_atbl(CPUPPCState *env)
+target_ulong HELPER(load_atbl)(CPUPPCState *env)
 {
     return (target_ulong)cpu_ppc_load_atbl(env);
 }
 
-target_ulong helper_load_atbu(CPUPPCState *env)
+target_ulong HELPER(load_atbu)(CPUPPCState *env)
 {
     return cpu_ppc_load_atbu(env);
 }
 
-target_ulong helper_load_vtb(CPUPPCState *env)
+target_ulong HELPER(load_vtb)(CPUPPCState *env)
 {
     return cpu_ppc_load_vtb(env);
 }
 
 #if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
-target_ulong helper_load_purr(CPUPPCState *env)
+target_ulong HELPER(load_purr)(CPUPPCState *env)
 {
     return (target_ulong)cpu_ppc_load_purr(env);
 }
 
-void helper_store_purr(CPUPPCState *env, target_ulong val)
+void HELPER(store_purr)(CPUPPCState *env, target_ulong val)
 {
     CPUState *cs = env_cpu(env);
     CPUState *ccs;
@@ -75,7 +75,7 @@ void helper_store_purr(CPUPPCState *env, target_ulong val)
 #endif
 
 #if !defined(CONFIG_USER_ONLY)
-void helper_store_tbl(CPUPPCState *env, target_ulong val)
+void HELPER(store_tbl)(CPUPPCState *env, target_ulong val)
 {
     CPUState *cs = env_cpu(env);
     CPUState *ccs;
@@ -91,7 +91,7 @@ void helper_store_tbl(CPUPPCState *env, target_ulong val)
     }
 }
 
-void helper_store_tbu(CPUPPCState *env, target_ulong val)
+void HELPER(store_tbu)(CPUPPCState *env, target_ulong val)
 {
     CPUState *cs = env_cpu(env);
     CPUState *ccs;
@@ -107,32 +107,32 @@ void helper_store_tbu(CPUPPCState *env, target_ulong val)
     }
 }
 
-void helper_store_atbl(CPUPPCState *env, target_ulong val)
+void HELPER(store_atbl)(CPUPPCState *env, target_ulong val)
 {
     cpu_ppc_store_atbl(env, val);
 }
 
-void helper_store_atbu(CPUPPCState *env, target_ulong val)
+void HELPER(store_atbu)(CPUPPCState *env, target_ulong val)
 {
     cpu_ppc_store_atbu(env, val);
 }
 
-target_ulong helper_load_decr(CPUPPCState *env)
+target_ulong HELPER(load_decr)(CPUPPCState *env)
 {
     return cpu_ppc_load_decr(env);
 }
 
-void helper_store_decr(CPUPPCState *env, target_ulong val)
+void HELPER(store_decr)(CPUPPCState *env, target_ulong val)
 {
     cpu_ppc_store_decr(env, val);
 }
 
-target_ulong helper_load_hdecr(CPUPPCState *env)
+target_ulong HELPER(load_hdecr)(CPUPPCState *env)
 {
     return cpu_ppc_load_hdecr(env);
 }
 
-void helper_store_hdecr(CPUPPCState *env, target_ulong val)
+void HELPER(store_hdecr)(CPUPPCState *env, target_ulong val)
 {
     CPUState *cs = env_cpu(env);
     CPUState *ccs;
@@ -148,7 +148,7 @@ void helper_store_hdecr(CPUPPCState *env, target_ulong val)
     }
 }
 
-void helper_store_vtb(CPUPPCState *env, target_ulong val)
+void HELPER(store_vtb)(CPUPPCState *env, target_ulong val)
 {
     CPUState *cs = env_cpu(env);
     CPUState *ccs;
@@ -164,7 +164,7 @@ void helper_store_vtb(CPUPPCState *env, target_ulong val)
     }
 }
 
-void helper_store_tbu40(CPUPPCState *env, target_ulong val)
+void HELPER(store_tbu40)(CPUPPCState *env, target_ulong val)
 {
     CPUState *cs = env_cpu(env);
     CPUState *ccs;
@@ -180,32 +180,32 @@ void helper_store_tbu40(CPUPPCState *env, target_ulong val)
     }
 }
 
-target_ulong helper_load_40x_pit(CPUPPCState *env)
+target_ulong HELPER(load_40x_pit)(CPUPPCState *env)
 {
     return load_40x_pit(env);
 }
 
-void helper_store_40x_pit(CPUPPCState *env, target_ulong val)
+void HELPER(store_40x_pit)(CPUPPCState *env, target_ulong val)
 {
     store_40x_pit(env, val);
 }
 
-void helper_store_40x_tcr(CPUPPCState *env, target_ulong val)
+void HELPER(store_40x_tcr)(CPUPPCState *env, target_ulong val)
 {
     store_40x_tcr(env, val);
 }
 
-void helper_store_40x_tsr(CPUPPCState *env, target_ulong val)
+void HELPER(store_40x_tsr)(CPUPPCState *env, target_ulong val)
 {
     store_40x_tsr(env, val);
 }
 
-void helper_store_booke_tcr(CPUPPCState *env, target_ulong val)
+void HELPER(store_booke_tcr)(CPUPPCState *env, target_ulong val)
 {
     store_booke_tcr(env, val);
 }
 
-void helper_store_booke_tsr(CPUPPCState *env, target_ulong val)
+void HELPER(store_booke_tsr)(CPUPPCState *env, target_ulong val)
 {
     store_booke_tsr(env, val);
 }
@@ -369,14 +369,14 @@ static void tb_state_machine_step(CPUPPCState *env)
     write_tfmr(env, tfmr);
 }
 
-target_ulong helper_load_tfmr(CPUPPCState *env)
+target_ulong HELPER(load_tfmr)(CPUPPCState *env)
 {
     tb_state_machine_step(env);
 
     return env->spr[SPR_TFMR] | TFMR_TB_ECLIPZ;
 }
 
-void helper_store_tfmr(CPUPPCState *env, target_ulong val)
+void HELPER(store_tfmr)(CPUPPCState *env, target_ulong val)
 {
     PowerPCCPU *cpu = env_archcpu(env);
     PnvCoreTODState *tod_state = cpu_get_tbst(cpu);
@@ -464,7 +464,7 @@ out:
 /* Embedded PowerPC specific helpers */
 
 /* XXX: to be improved to check access rights when in user-mode */
-target_ulong helper_load_dcr(CPUPPCState *env, target_ulong dcrn)
+target_ulong HELPER(load_dcr)(CPUPPCState *env, target_ulong dcrn)
 {
     uint32_t val = 0;
 
@@ -490,7 +490,7 @@ target_ulong helper_load_dcr(CPUPPCState *env, target_ulong dcrn)
     return val;
 }
 
-void helper_store_dcr(CPUPPCState *env, target_ulong dcrn, target_ulong val)
+void HELPER(store_dcr)(CPUPPCState *env, target_ulong dcrn, target_ulong val)
 {
     if (unlikely(env->dcr_env == NULL)) {
         qemu_log_mask(LOG_GUEST_ERROR, "No DCR environment\n");
diff --git a/target/ppc/translate/vsx-impl.c.inc b/target/ppc/translate/vsx-impl.c.inc
index 78311dcba9d..95003be99b2 100644
--- a/target/ppc/translate/vsx-impl.c.inc
+++ b/target/ppc/translate/vsx-impl.c.inc
@@ -1679,7 +1679,7 @@ static bool trans_XXSPLTIDP(DisasContext *ctx, arg_8RR_D *a)
     REQUIRE_VSX(ctx);
 
     tcg_gen_gvec_dup_imm(MO_64, vsr_full_offset(a->xt), 16, 16,
-                         helper_todouble(a->si));
+                         HELPER(todouble)(a->si));
     return true;
 }
 
-- 
2.43.0


