Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC048606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YQOCpZno;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KbxG3tFX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIunF-0001dn-Fk; Mon, 19 Oct 2026 17:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIunC-0001cf-6p
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIun8-0005gU-Bv
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:13 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJK4Ec4106599
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=vgihWuSHxE6
 4MB2Yh+cCmIQVusMNm1rh12LOEVYWTi8=; b=YQOCpZno2S4cg8cOdn439TfWwpU
 0IcZDT4/bLB9xyreYFoYfKiR7PrFCGKqGWJSp0FoAkPoGI5jYYI5ka45dyp09BXw
 NHZ0tzFZV+MeklxjEz21ZP2P0q3z8raQbkQURqfrxnSnm0dWDFUPugXGHA0gBnZS
 06a2p5+0jJYaBKqsfWMzfBPWmvsFACld5pHGhE3y3u6fDdRqybQCsz/paN3gwOUT
 DJ41PUgtKtfCskr+ajJCoPvc7xh3mk6y0Af7gqms3P03+SbzAHm+BtV0Y972pmSy
 JkhJkOU0Kp3j4rrlpUUycGl3Ekayhe4U8nUZXQnoNw2pj2Qmv9rgPmeTv5g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr780ntn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:09 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3a46f0f158dso97674a91.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792444868; x=1793049668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vgihWuSHxE64MB2Yh+cCmIQVusMNm1rh12LOEVYWTi8=;
 b=KbxG3tFX82saSi6E/iNpa3dqvSQ4tq5rqncji8YLhmKI3oqiHmjgMNvX6ZjGKPTJJu
 8lXtdWXbCpcIu/KiEUR1muAya5PlYL0wFk+mSWbLkDzZ7vqDxUplL8v9GP3B7YmkybKT
 Ob7L1/S8JDZyOuHToJjUCpvjiFDvt0327hbAxt4PB7Wdq0QQI8dkOAwL9lqZI1dR0/xy
 /HMUen79BGvLZoplxAbo+Fgrteq4w0Z5o3y0nN5YIqsUfy1KE7iC4I+Iaky92Av7H6Ww
 2TUDmMunpZKn5Wb8QgzgxwpAX1YMRf9gHGWLFnVTKA0mAAViyp2RF0xVu9DCaQspskfY
 g6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792444868; x=1793049668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vgihWuSHxE64MB2Yh+cCmIQVusMNm1rh12LOEVYWTi8=;
 b=Oh6v6uh+t4hi1UL4mB6Brdv4DyFNYRree258qz+C7q3kxJJOrsn8DWNzw5bNwene5o
 VpXziNbBQHkfA/3ZHbsHs4noWsDUkRbiWde6sjr7xnLw+2XAAt/swdNtbYCgMJrCdxCF
 +c4h6SRIYRskk9TH70RHoG4GscGLL7o1L16/snJPTL0jpolE9z+Em6wK+sIF2InTfkJd
 WufMsYtEfqkY/ftMlYrgEvalQBWgEsRuwbGf+WPBUtY21oCd1AdYVkm67O+I6yVkPYg7
 3/ZC/f6Aa4cr32UrcUNawO3y2RcXWA5le1LAFTD1QkOFqxHi+1HhXY57AyTI/sb6uZQP
 96cw==
X-Gm-Message-State: AFq9FYIDzfCBg8iiWCXAYJa/lRVcjQp4vHq1fak5fANE3iaujfpeoYHo
 pzIiSmAyhVFooFp2jUDj/kutjx/bUl+CJHKq8HKuY7ED3RtZlp4xKc1wtDdppNL5kY8VQ65oOL6
 MjLcVdWPYob4VWU30X7vLOv1EghUXNBi4E/8GgX84gUon4gpz9JtkWoPwxzKr/gOyPg==
X-Gm-Gg: AYBFou1MBWnmk3hjkZJjuvvIymgI5W/CYdwUuY5F8Kjv4LINTDCamt5Bv5edvVEEXFu
 QkI5P9TRRqkp8Vk62P948HkIU+8JkHWVHaKyi99XH2tjO9MQbKE9+4iqdFzUijc/omr/DtTBtBp
 eUXIobnODXlDN2UjvKGo/R8A4OsUTDPuINBYdeGbspj36ZFcOQ2g+85YPSEebbswpQpZFgxf9ml
 lG2pV9bLzDJGrXoepOpy9/MUG3DDt6uPvEnjmCnbYtAfpuFuWKvelcnZAUXfpMrKfQJXlW/3Si4
 IiyZp2bUdgl6dg2P2268ngBmK29EZkWOG1BtEV0ubu/D57NkdJNmYkArffWz0eafJWTjnj/eRjQ
 6OfmsyCe/Bpn4acE3tPbdjZinhUJINadA7VMPQno5ybyvAANSKT5jTuWZsuG7rVU=
X-Received: by 2002:a17:90b:1dcb:b0:3a7:a3c8:8f4a with SMTP id
 98e67ed59e1d1-3ad64ba812bmr172421a91.18.1792444867932; 
 Mon, 19 Oct 2026 14:21:07 -0700 (PDT)
X-Received: by 2002:a17:90b:1dcb:b0:3a7:a3c8:8f4a with SMTP id
 98e67ed59e1d1-3ad64ba812bmr172410a91.18.1792444867133; 
 Mon, 19 Oct 2026 14:21:07 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60ec4457sm863243a91.6.2026.10.19.14.21.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:21:05 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 06/26] target/loongarch: define and call helpers using HELPER
 macro
Date: Mon, 19 Oct 2026 21:20:25 +0000
Message-ID: <20261019212046.149572-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfXx/6KQBQdfRJo
 m0NdD0x0qge5eKo1uysn0NCTJDA2Ffm1zMVWy6UzcIcOX+7HCVt3k8cKpisnQ90AB5MTwHGFY+p
 s1ugaEo+RzP5MxmUQfV1cCvTVCqABkh/ZbddR1S0gg2nkD90+oJ7Cv80AUsF+hR6hVIQO528oMS
 uWv9Ke0i8g212MGDyNHWi4xGNQ+P8BskWbh6KxAYZXvcGsEPkcWGZrIDYi9BdEct/LhdGy1qGph
 /g1b2LxZ4kCEgzsqyyWyaunk+9sSUZKdhZbaK5UiHnLirzfXImIvKDQZ8Uq6AuxycwZ3qBkJjvO
 CPKDOofNIv9Xq8rY61emTizauZNRRbIqx0YvpICaQ9PZ3NwLske35KuBjKVvtzf0RonAvktgIdi
 Wq71kx14UFI7tvlZjz79rDtKFUkWJn4lMdemf0C+DGVClB8Dq7TP1TTcGWLfI//HUI3ET61eVIf
 pDQUGTmYeoZNm7XY43A==
X-Proofpoint-GUID: 3p_lA29aAvwKojVcb89WiMfuBzCQFlu2
X-Authority-Analysis: v=2.4 cv=LKnz05W9 c=1 sm=1 tr=0 ts=6ad689c5 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=SQnn4VcWqfzk9PnhchsA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX9Mk/cMq8TcaL
 wDeURlgcShwzCrXztf8O2/3oJaEZF8/RO0QWWF0ufxsdcGNv082UWFhN+7V+1K8EO9ploj4Hkof
 jij6SeCrwrAAuJFL+WVoVnlS1HN6m+4=
X-Proofpoint-ORIG-GUID: 3p_lA29aAvwKojVcb89WiMfuBzCQFlu2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190085
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
 target/loongarch/tcg/csr_helper.c   |  22 ++---
 target/loongarch/tcg/fpu_helper.c   | 126 ++++++++++++++--------------
 target/loongarch/tcg/iocsr_helper.c |  16 ++--
 target/loongarch/tcg/op_helper.c    |  18 ++--
 target/loongarch/tcg/tlb_helper.c   |  26 +++---
 target/loongarch/tcg/vec_helper.c   |   4 +-
 6 files changed, 106 insertions(+), 106 deletions(-)

diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
index 1a6919417fc..7cba8035df4 100644
--- a/target/loongarch/tcg/csr_helper.c
+++ b/target/loongarch/tcg/csr_helper.c
@@ -18,7 +18,7 @@
 #include "cpu-csr.h"
 #include "cpu-mmu.h"
 
-target_ulong helper_csrwr_stlbps(CPULoongArchState *env, target_ulong val)
+target_ulong HELPER(csrwr_stlbps)(CPULoongArchState *env, target_ulong val)
 {
     CPUSysState *sys = env_sys(env);
     int64_t old_v = sys->CSR_STLBPS;
@@ -40,7 +40,7 @@ target_ulong helper_csrwr_stlbps(CPULoongArchState *env, target_ulong val)
     return old_v;
 }
 
-target_ulong helper_csrrd_pgd(CPULoongArchState *env)
+target_ulong HELPER(csrrd_pgd)(CPULoongArchState *env)
 {
     int64_t v;
     CPUSysState *sys = env_sys(env);
@@ -60,7 +60,7 @@ target_ulong helper_csrrd_pgd(CPULoongArchState *env)
     return v;
 }
 
-target_ulong helper_csrrd_cpuid(CPULoongArchState *env)
+target_ulong HELPER(csrrd_cpuid)(CPULoongArchState *env)
 {
     LoongArchCPU *lac = env_archcpu(env);
     CPUSysState *sys = env_sys(env);
@@ -70,12 +70,12 @@ target_ulong helper_csrrd_cpuid(CPULoongArchState *env)
     return sys->CSR_CPUID;
 }
 
-target_ulong helper_csrrd_tval(CPULoongArchState *env)
+target_ulong HELPER(csrrd_tval)(CPULoongArchState *env)
 {
     return cpu_loongarch_get_timer_ticks(env_timer(env));
 }
 
-target_ulong helper_csrrd_msgir(CPULoongArchState *env)
+target_ulong HELPER(csrrd_msgir)(CPULoongArchState *env)
 {
     int irq, new;
     CPUSysState *sys = env_sys(env);
@@ -97,7 +97,7 @@ target_ulong helper_csrrd_msgir(CPULoongArchState *env)
     return irq;
 }
 
-target_ulong helper_csrwr_estat(CPULoongArchState *env, target_ulong val)
+target_ulong HELPER(csrwr_estat)(CPULoongArchState *env, target_ulong val)
 {
     CPUSysState *sys = env_sys(env);
     int64_t old_v = sys->CSR_ESTAT;
@@ -118,7 +118,7 @@ target_ulong helper_csrwr_estat(CPULoongArchState *env, target_ulong val)
     return old_v;
 }
 
-target_ulong helper_csrwr_asid(CPULoongArchState *env, target_ulong val)
+target_ulong HELPER(csrwr_asid)(CPULoongArchState *env, target_ulong val)
 {
     CPUSysState *sys = env_sys(env);
     int64_t old_v = sys->CSR_ASID;
@@ -131,7 +131,7 @@ target_ulong helper_csrwr_asid(CPULoongArchState *env, target_ulong val)
     return old_v;
 }
 
-target_ulong helper_csrwr_tcfg(CPULoongArchState *env, target_ulong val)
+target_ulong HELPER(csrwr_tcfg)(CPULoongArchState *env, target_ulong val)
 {
     CPUTimerState *timer = env_timer(env);
     CPUSysState *sys = container_of(timer, CPUSysState, timer_state);
@@ -142,7 +142,7 @@ target_ulong helper_csrwr_tcfg(CPULoongArchState *env, target_ulong val)
     return old_v;
 }
 
-target_ulong helper_csrwr_ticlr(CPULoongArchState *env, target_ulong val)
+target_ulong HELPER(csrwr_ticlr)(CPULoongArchState *env, target_ulong val)
 {
     CPUTimerState *timer = env_timer(env);
     int64_t old_v = 0;
@@ -155,7 +155,7 @@ target_ulong helper_csrwr_ticlr(CPULoongArchState *env, target_ulong val)
     return old_v;
 }
 
-target_ulong helper_csrwr_pwcl(CPULoongArchState *env, target_ulong val)
+target_ulong HELPER(csrwr_pwcl)(CPULoongArchState *env, target_ulong val)
 {
     uint8_t shift, ptbase;
     CPUSysState *sys = env_sys(env);
@@ -180,7 +180,7 @@ target_ulong helper_csrwr_pwcl(CPULoongArchState *env, target_ulong val)
     return old_v;
 }
 
-target_ulong helper_csrwr_pwch(CPULoongArchState *env, target_ulong val)
+target_ulong HELPER(csrwr_pwch)(CPULoongArchState *env, target_ulong val)
 {
     uint8_t has_ptw;
     CPUSysState *sys = env_sys(env);
diff --git a/target/loongarch/tcg/fpu_helper.c b/target/loongarch/tcg/fpu_helper.c
index fc9c64c20a8..cf7c77b1b05 100644
--- a/target/loongarch/tcg/fpu_helper.c
+++ b/target/loongarch/tcg/fpu_helper.c
@@ -90,7 +90,7 @@ static void update_fcsr0(CPULoongArchState *env, uintptr_t pc)
     update_fcsr0_mask(env, pc, 0);
 }
 
-uint64_t helper_fadd_s(CPULoongArchState *env, uint64_t fj, uint64_t fk)
+uint64_t HELPER(fadd_s)(CPULoongArchState *env, uint64_t fj, uint64_t fk)
 {
     uint64_t fd;
 
@@ -99,7 +99,7 @@ uint64_t helper_fadd_s(CPULoongArchState *env, uint64_t fj, uint64_t fk)
     return fd;
 }
 
-uint64_t helper_fadd_d(CPULoongArchState *env, uint64_t fj, uint64_t fk)
+uint64_t HELPER(fadd_d)(CPULoongArchState *env, uint64_t fj, uint64_t fk)
 {
     uint64_t fd;
 
@@ -108,7 +108,7 @@ uint64_t helper_fadd_d(CPULoongArchState *env, uint64_t fj, uint64_t fk)
     return fd;
 }
 
-uint64_t helper_fsub_s(CPULoongArchState *env, uint64_t fj, uint64_t fk)
+uint64_t HELPER(fsub_s)(CPULoongArchState *env, uint64_t fj, uint64_t fk)
 {
     uint64_t fd;
 
@@ -117,7 +117,7 @@ uint64_t helper_fsub_s(CPULoongArchState *env, uint64_t fj, uint64_t fk)
     return fd;
 }
 
-uint64_t helper_fsub_d(CPULoongArchState *env, uint64_t fj, uint64_t fk)
+uint64_t HELPER(fsub_d)(CPULoongArchState *env, uint64_t fj, uint64_t fk)
 {
     uint64_t fd;
 
@@ -126,7 +126,7 @@ uint64_t helper_fsub_d(CPULoongArchState *env, uint64_t fj, uint64_t fk)
     return fd;
 }
 
-uint64_t helper_fmul_s(CPULoongArchState *env, uint64_t fj, uint64_t fk)
+uint64_t HELPER(fmul_s)(CPULoongArchState *env, uint64_t fj, uint64_t fk)
 {
     uint64_t fd;
 
@@ -135,7 +135,7 @@ uint64_t helper_fmul_s(CPULoongArchState *env, uint64_t fj, uint64_t fk)
     return fd;
 }
 
-uint64_t helper_fmul_d(CPULoongArchState *env, uint64_t fj, uint64_t fk)
+uint64_t HELPER(fmul_d)(CPULoongArchState *env, uint64_t fj, uint64_t fk)
 {
     uint64_t fd;
 
@@ -144,7 +144,7 @@ uint64_t helper_fmul_d(CPULoongArchState *env, uint64_t fj, uint64_t fk)
     return fd;
 }
 
-uint64_t helper_fdiv_s(CPULoongArchState *env, uint64_t fj, uint64_t fk)
+uint64_t HELPER(fdiv_s)(CPULoongArchState *env, uint64_t fj, uint64_t fk)
 {
     uint64_t fd;
 
@@ -153,7 +153,7 @@ uint64_t helper_fdiv_s(CPULoongArchState *env, uint64_t fj, uint64_t fk)
     return fd;
 }
 
-uint64_t helper_fdiv_d(CPULoongArchState *env, uint64_t fj, uint64_t fk)
+uint64_t HELPER(fdiv_d)(CPULoongArchState *env, uint64_t fj, uint64_t fk)
 {
     uint64_t fd;
 
@@ -162,7 +162,7 @@ uint64_t helper_fdiv_d(CPULoongArchState *env, uint64_t fj, uint64_t fk)
     return fd;
 }
 
-uint64_t helper_fmax_s(CPULoongArchState *env, uint64_t fj, uint64_t fk)
+uint64_t HELPER(fmax_s)(CPULoongArchState *env, uint64_t fj, uint64_t fk)
 {
     uint64_t fd;
 
@@ -171,7 +171,7 @@ uint64_t helper_fmax_s(CPULoongArchState *env, uint64_t fj, uint64_t fk)
     return fd;
 }
 
-uint64_t helper_fmax_d(CPULoongArchState *env, uint64_t fj, uint64_t fk)
+uint64_t HELPER(fmax_d)(CPULoongArchState *env, uint64_t fj, uint64_t fk)
 {
     uint64_t fd;
 
@@ -180,7 +180,7 @@ uint64_t helper_fmax_d(CPULoongArchState *env, uint64_t fj, uint64_t fk)
     return fd;
 }
 
-uint64_t helper_fmin_s(CPULoongArchState *env, uint64_t fj, uint64_t fk)
+uint64_t HELPER(fmin_s)(CPULoongArchState *env, uint64_t fj, uint64_t fk)
 {
     uint64_t fd;
 
@@ -189,7 +189,7 @@ uint64_t helper_fmin_s(CPULoongArchState *env, uint64_t fj, uint64_t fk)
     return fd;
 }
 
-uint64_t helper_fmin_d(CPULoongArchState *env, uint64_t fj, uint64_t fk)
+uint64_t HELPER(fmin_d)(CPULoongArchState *env, uint64_t fj, uint64_t fk)
 {
     uint64_t fd;
 
@@ -198,7 +198,7 @@ uint64_t helper_fmin_d(CPULoongArchState *env, uint64_t fj, uint64_t fk)
     return fd;
 }
 
-uint64_t helper_fmaxa_s(CPULoongArchState *env, uint64_t fj, uint64_t fk)
+uint64_t HELPER(fmaxa_s)(CPULoongArchState *env, uint64_t fj, uint64_t fk)
 {
     uint64_t fd;
 
@@ -208,7 +208,7 @@ uint64_t helper_fmaxa_s(CPULoongArchState *env, uint64_t fj, uint64_t fk)
     return fd;
 }
 
-uint64_t helper_fmaxa_d(CPULoongArchState *env, uint64_t fj, uint64_t fk)
+uint64_t HELPER(fmaxa_d)(CPULoongArchState *env, uint64_t fj, uint64_t fk)
 {
     uint64_t fd;
 
@@ -217,7 +217,7 @@ uint64_t helper_fmaxa_d(CPULoongArchState *env, uint64_t fj, uint64_t fk)
     return fd;
 }
 
-uint64_t helper_fmina_s(CPULoongArchState *env, uint64_t fj, uint64_t fk)
+uint64_t HELPER(fmina_s)(CPULoongArchState *env, uint64_t fj, uint64_t fk)
 {
     uint64_t fd;
 
@@ -227,7 +227,7 @@ uint64_t helper_fmina_s(CPULoongArchState *env, uint64_t fj, uint64_t fk)
     return fd;
 }
 
-uint64_t helper_fmina_d(CPULoongArchState *env, uint64_t fj, uint64_t fk)
+uint64_t HELPER(fmina_d)(CPULoongArchState *env, uint64_t fj, uint64_t fk)
 {
     uint64_t fd;
 
@@ -236,7 +236,7 @@ uint64_t helper_fmina_d(CPULoongArchState *env, uint64_t fj, uint64_t fk)
     return fd;
 }
 
-uint64_t helper_fscaleb_s(CPULoongArchState *env, uint64_t fj, uint64_t fk)
+uint64_t HELPER(fscaleb_s)(CPULoongArchState *env, uint64_t fj, uint64_t fk)
 {
     uint64_t fd;
     int32_t n = (int32_t)fk;
@@ -249,7 +249,7 @@ uint64_t helper_fscaleb_s(CPULoongArchState *env, uint64_t fj, uint64_t fk)
     return fd;
 }
 
-uint64_t helper_fscaleb_d(CPULoongArchState *env, uint64_t fj, uint64_t fk)
+uint64_t HELPER(fscaleb_d)(CPULoongArchState *env, uint64_t fj, uint64_t fk)
 {
     uint64_t fd;
     int64_t n = (int64_t)fk;
@@ -262,7 +262,7 @@ uint64_t helper_fscaleb_d(CPULoongArchState *env, uint64_t fj, uint64_t fk)
     return fd;
 }
 
-uint64_t helper_fsqrt_s(CPULoongArchState *env, uint64_t fj)
+uint64_t HELPER(fsqrt_s)(CPULoongArchState *env, uint64_t fj)
 {
     uint64_t fd;
 
@@ -271,7 +271,7 @@ uint64_t helper_fsqrt_s(CPULoongArchState *env, uint64_t fj)
     return fd;
 }
 
-uint64_t helper_fsqrt_d(CPULoongArchState *env, uint64_t fj)
+uint64_t HELPER(fsqrt_d)(CPULoongArchState *env, uint64_t fj)
 {
     uint64_t fd;
 
@@ -280,7 +280,7 @@ uint64_t helper_fsqrt_d(CPULoongArchState *env, uint64_t fj)
     return fd;
 }
 
-uint64_t helper_frecip_s(CPULoongArchState *env, uint64_t fj)
+uint64_t HELPER(frecip_s)(CPULoongArchState *env, uint64_t fj)
 {
     uint64_t fd;
 
@@ -289,7 +289,7 @@ uint64_t helper_frecip_s(CPULoongArchState *env, uint64_t fj)
     return fd;
 }
 
-uint64_t helper_frecip_d(CPULoongArchState *env, uint64_t fj)
+uint64_t HELPER(frecip_d)(CPULoongArchState *env, uint64_t fj)
 {
     uint64_t fd;
 
@@ -298,7 +298,7 @@ uint64_t helper_frecip_d(CPULoongArchState *env, uint64_t fj)
     return fd;
 }
 
-uint64_t helper_frsqrt_s(CPULoongArchState *env, uint64_t fj)
+uint64_t HELPER(frsqrt_s)(CPULoongArchState *env, uint64_t fj)
 {
     uint64_t fd;
     uint32_t fp;
@@ -309,7 +309,7 @@ uint64_t helper_frsqrt_s(CPULoongArchState *env, uint64_t fj)
     return fd;
 }
 
-uint64_t helper_frsqrt_d(CPULoongArchState *env, uint64_t fj)
+uint64_t HELPER(frsqrt_d)(CPULoongArchState *env, uint64_t fj)
 {
     uint64_t fp, fd;
 
@@ -319,7 +319,7 @@ uint64_t helper_frsqrt_d(CPULoongArchState *env, uint64_t fj)
     return fd;
 }
 
-uint64_t helper_flogb_s(CPULoongArchState *env, uint64_t fj)
+uint64_t HELPER(flogb_s)(CPULoongArchState *env, uint64_t fj)
 {
     uint64_t fd;
     uint32_t fp;
@@ -334,7 +334,7 @@ uint64_t helper_flogb_s(CPULoongArchState *env, uint64_t fj)
     return fd;
 }
 
-uint64_t helper_flogb_d(CPULoongArchState *env, uint64_t fj)
+uint64_t HELPER(flogb_d)(CPULoongArchState *env, uint64_t fj)
 {
     uint64_t fd;
     float_status *status = &env->fp_status;
@@ -348,7 +348,7 @@ uint64_t helper_flogb_d(CPULoongArchState *env, uint64_t fj)
     return fd;
 }
 
-uint64_t helper_fclass_s(CPULoongArchState *env, uint64_t fj)
+uint64_t HELPER(fclass_s)(CPULoongArchState *env, uint64_t fj)
 {
     float32 f = fj;
     bool sign = float32_is_neg(f);
@@ -366,7 +366,7 @@ uint64_t helper_fclass_s(CPULoongArchState *env, uint64_t fj)
     }
 }
 
-uint64_t helper_fclass_d(CPULoongArchState *env, uint64_t fj)
+uint64_t HELPER(fclass_d)(CPULoongArchState *env, uint64_t fj)
 {
     float64 f = fj;
     bool sign = float64_is_neg(f);
@@ -384,7 +384,7 @@ uint64_t helper_fclass_d(CPULoongArchState *env, uint64_t fj)
     }
 }
 
-uint64_t helper_fmuladd_s(CPULoongArchState *env, uint64_t fj,
+uint64_t HELPER(fmuladd_s)(CPULoongArchState *env, uint64_t fj,
                           uint64_t fk, uint64_t fa, uint32_t flag)
 {
     uint64_t fd;
@@ -395,7 +395,7 @@ uint64_t helper_fmuladd_s(CPULoongArchState *env, uint64_t fj,
     return fd;
 }
 
-uint64_t helper_fmuladd_d(CPULoongArchState *env, uint64_t fj,
+uint64_t HELPER(fmuladd_d)(CPULoongArchState *env, uint64_t fj,
                           uint64_t fk, uint64_t fa, uint32_t flag)
 {
     uint64_t fd;
@@ -432,7 +432,7 @@ static uint64_t fcmp_common(CPULoongArchState *env, FloatRelation cmp,
 }
 
 /* fcmp_cXXX_s */
-uint64_t helper_fcmp_c_s(CPULoongArchState *env, uint64_t fj,
+uint64_t HELPER(fcmp_c_s)(CPULoongArchState *env, uint64_t fj,
                          uint64_t fk, uint32_t flags)
 {
     FloatRelation cmp = float32_compare_quiet((uint32_t)fj,
@@ -441,7 +441,7 @@ uint64_t helper_fcmp_c_s(CPULoongArchState *env, uint64_t fj,
 }
 
 /* fcmp_sXXX_s */
-uint64_t helper_fcmp_s_s(CPULoongArchState *env, uint64_t fj,
+uint64_t HELPER(fcmp_s_s)(CPULoongArchState *env, uint64_t fj,
                          uint64_t fk, uint32_t flags)
 {
     FloatRelation cmp = float32_compare((uint32_t)fj,
@@ -450,7 +450,7 @@ uint64_t helper_fcmp_s_s(CPULoongArchState *env, uint64_t fj,
 }
 
 /* fcmp_cXXX_d */
-uint64_t helper_fcmp_c_d(CPULoongArchState *env, uint64_t fj,
+uint64_t HELPER(fcmp_c_d)(CPULoongArchState *env, uint64_t fj,
                          uint64_t fk, uint32_t flags)
 {
     FloatRelation cmp = float64_compare_quiet(fj, fk, &env->fp_status);
@@ -458,7 +458,7 @@ uint64_t helper_fcmp_c_d(CPULoongArchState *env, uint64_t fj,
 }
 
 /* fcmp_sXXX_d */
-uint64_t helper_fcmp_s_d(CPULoongArchState *env, uint64_t fj,
+uint64_t HELPER(fcmp_s_d)(CPULoongArchState *env, uint64_t fj,
                          uint64_t fk, uint32_t flags)
 {
     FloatRelation cmp = float64_compare(fj, fk, &env->fp_status);
@@ -466,7 +466,7 @@ uint64_t helper_fcmp_s_d(CPULoongArchState *env, uint64_t fj,
 }
 
 /* floating point conversion */
-uint64_t helper_fcvt_s_d(CPULoongArchState *env, uint64_t fj)
+uint64_t HELPER(fcvt_s_d)(CPULoongArchState *env, uint64_t fj)
 {
     uint64_t fd;
 
@@ -475,7 +475,7 @@ uint64_t helper_fcvt_s_d(CPULoongArchState *env, uint64_t fj)
     return fd;
 }
 
-uint64_t helper_fcvt_d_s(CPULoongArchState *env, uint64_t fj)
+uint64_t HELPER(fcvt_d_s)(CPULoongArchState *env, uint64_t fj)
 {
     uint64_t fd;
 
@@ -484,7 +484,7 @@ uint64_t helper_fcvt_d_s(CPULoongArchState *env, uint64_t fj)
     return fd;
 }
 
-uint64_t helper_ffint_s_w(CPULoongArchState *env, uint64_t fj)
+uint64_t HELPER(ffint_s_w)(CPULoongArchState *env, uint64_t fj)
 {
     uint64_t fd;
 
@@ -493,7 +493,7 @@ uint64_t helper_ffint_s_w(CPULoongArchState *env, uint64_t fj)
     return fd;
 }
 
-uint64_t helper_ffint_s_l(CPULoongArchState *env, uint64_t fj)
+uint64_t HELPER(ffint_s_l)(CPULoongArchState *env, uint64_t fj)
 {
     uint64_t fd;
 
@@ -502,7 +502,7 @@ uint64_t helper_ffint_s_l(CPULoongArchState *env, uint64_t fj)
     return fd;
 }
 
-uint64_t helper_ffint_d_w(CPULoongArchState *env, uint64_t fj)
+uint64_t HELPER(ffint_d_w)(CPULoongArchState *env, uint64_t fj)
 {
     uint64_t fd;
 
@@ -511,7 +511,7 @@ uint64_t helper_ffint_d_w(CPULoongArchState *env, uint64_t fj)
     return fd;
 }
 
-uint64_t helper_ffint_d_l(CPULoongArchState *env, uint64_t fj)
+uint64_t HELPER(ffint_d_l)(CPULoongArchState *env, uint64_t fj)
 {
     uint64_t fd;
 
@@ -520,7 +520,7 @@ uint64_t helper_ffint_d_l(CPULoongArchState *env, uint64_t fj)
     return fd;
 }
 
-uint64_t helper_frint_s(CPULoongArchState *env, uint64_t fj)
+uint64_t HELPER(frint_s)(CPULoongArchState *env, uint64_t fj)
 {
     uint64_t fd;
 
@@ -529,7 +529,7 @@ uint64_t helper_frint_s(CPULoongArchState *env, uint64_t fj)
     return fd;
 }
 
-uint64_t helper_frint_d(CPULoongArchState *env, uint64_t fj)
+uint64_t HELPER(frint_d)(CPULoongArchState *env, uint64_t fj)
 {
     uint64_t fd;
 
@@ -538,7 +538,7 @@ uint64_t helper_frint_d(CPULoongArchState *env, uint64_t fj)
     return fd;
 }
 
-uint64_t helper_ftintrm_l_d(CPULoongArchState *env, uint64_t fj)
+uint64_t HELPER(ftintrm_l_d)(CPULoongArchState *env, uint64_t fj)
 {
     uint64_t fd;
     FloatRoundMode old_mode = get_float_rounding_mode(&env->fp_status);
@@ -556,7 +556,7 @@ uint64_t helper_ftintrm_l_d(CPULoongArchState *env, uint64_t fj)
     return fd;
 }
 
-uint64_t helper_ftintrm_l_s(CPULoongArchState *env, uint64_t fj)
+uint64_t HELPER(ftintrm_l_s)(CPULoongArchState *env, uint64_t fj)
 {
     uint64_t fd;
     FloatRoundMode old_mode = get_float_rounding_mode(&env->fp_status);
@@ -574,7 +574,7 @@ uint64_t helper_ftintrm_l_s(CPULoongArchState *env, uint64_t fj)
     return fd;
 }
 
-uint64_t helper_ftintrm_w_d(CPULoongArchState *env, uint64_t fj)
+uint64_t HELPER(ftintrm_w_d)(CPULoongArchState *env, uint64_t fj)
 {
     uint64_t fd;
     FloatRoundMode old_mode = get_float_rounding_mode(&env->fp_status);
@@ -592,7 +592,7 @@ uint64_t helper_ftintrm_w_d(CPULoongArchState *env, uint64_t fj)
     return fd;
 }
 
-uint64_t helper_ftintrm_w_s(CPULoongArchState *env, uint64_t fj)
+uint64_t HELPER(ftintrm_w_s)(CPULoongArchState *env, uint64_t fj)
 {
     uint64_t fd;
     FloatRoundMode old_mode = get_float_rounding_mode(&env->fp_status);
@@ -610,7 +610,7 @@ uint64_t helper_ftintrm_w_s(CPULoongArchState *env, uint64_t fj)
     return fd;
 }
 
-uint64_t helper_ftintrp_l_d(CPULoongArchState *env, uint64_t fj)
+uint64_t HELPER(ftintrp_l_d)(CPULoongArchState *env, uint64_t fj)
 {
     uint64_t fd;
     FloatRoundMode old_mode = get_float_rounding_mode(&env->fp_status);
@@ -628,7 +628,7 @@ uint64_t helper_ftintrp_l_d(CPULoongArchState *env, uint64_t fj)
     return fd;
 }
 
-uint64_t helper_ftintrp_l_s(CPULoongArchState *env, uint64_t fj)
+uint64_t HELPER(ftintrp_l_s)(CPULoongArchState *env, uint64_t fj)
 {
     uint64_t fd;
     FloatRoundMode old_mode = get_float_rounding_mode(&env->fp_status);
@@ -646,7 +646,7 @@ uint64_t helper_ftintrp_l_s(CPULoongArchState *env, uint64_t fj)
     return fd;
 }
 
-uint64_t helper_ftintrp_w_d(CPULoongArchState *env, uint64_t fj)
+uint64_t HELPER(ftintrp_w_d)(CPULoongArchState *env, uint64_t fj)
 {
     uint64_t fd;
     FloatRoundMode old_mode = get_float_rounding_mode(&env->fp_status);
@@ -664,7 +664,7 @@ uint64_t helper_ftintrp_w_d(CPULoongArchState *env, uint64_t fj)
     return fd;
 }
 
-uint64_t helper_ftintrp_w_s(CPULoongArchState *env, uint64_t fj)
+uint64_t HELPER(ftintrp_w_s)(CPULoongArchState *env, uint64_t fj)
 {
     uint64_t fd;
     FloatRoundMode old_mode = get_float_rounding_mode(&env->fp_status);
@@ -682,7 +682,7 @@ uint64_t helper_ftintrp_w_s(CPULoongArchState *env, uint64_t fj)
     return fd;
 }
 
-uint64_t helper_ftintrz_l_d(CPULoongArchState *env, uint64_t fj)
+uint64_t HELPER(ftintrz_l_d)(CPULoongArchState *env, uint64_t fj)
 {
     uint64_t fd;
     FloatRoundMode old_mode = get_float_rounding_mode(&env->fp_status);
@@ -699,7 +699,7 @@ uint64_t helper_ftintrz_l_d(CPULoongArchState *env, uint64_t fj)
     return fd;
 }
 
-uint64_t helper_ftintrz_l_s(CPULoongArchState *env, uint64_t fj)
+uint64_t HELPER(ftintrz_l_s)(CPULoongArchState *env, uint64_t fj)
 {
     uint64_t fd;
     FloatRoundMode old_mode = get_float_rounding_mode(&env->fp_status);
@@ -716,7 +716,7 @@ uint64_t helper_ftintrz_l_s(CPULoongArchState *env, uint64_t fj)
     return fd;
 }
 
-uint64_t helper_ftintrz_w_d(CPULoongArchState *env, uint64_t fj)
+uint64_t HELPER(ftintrz_w_d)(CPULoongArchState *env, uint64_t fj)
 {
     uint64_t fd;
     FloatRoundMode old_mode = get_float_rounding_mode(&env->fp_status);
@@ -733,7 +733,7 @@ uint64_t helper_ftintrz_w_d(CPULoongArchState *env, uint64_t fj)
     return fd;
 }
 
-uint64_t helper_ftintrz_w_s(CPULoongArchState *env, uint64_t fj)
+uint64_t HELPER(ftintrz_w_s)(CPULoongArchState *env, uint64_t fj)
 {
     uint32_t fd;
     FloatRoundMode old_mode = get_float_rounding_mode(&env->fp_status);
@@ -750,7 +750,7 @@ uint64_t helper_ftintrz_w_s(CPULoongArchState *env, uint64_t fj)
     return (uint64_t)fd;
 }
 
-uint64_t helper_ftintrne_l_d(CPULoongArchState *env, uint64_t fj)
+uint64_t HELPER(ftintrne_l_d)(CPULoongArchState *env, uint64_t fj)
 {
     uint64_t fd;
     FloatRoundMode old_mode = get_float_rounding_mode(&env->fp_status);
@@ -768,7 +768,7 @@ uint64_t helper_ftintrne_l_d(CPULoongArchState *env, uint64_t fj)
     return fd;
 }
 
-uint64_t helper_ftintrne_l_s(CPULoongArchState *env, uint64_t fj)
+uint64_t HELPER(ftintrne_l_s)(CPULoongArchState *env, uint64_t fj)
 {
     uint64_t fd;
     FloatRoundMode old_mode = get_float_rounding_mode(&env->fp_status);
@@ -786,7 +786,7 @@ uint64_t helper_ftintrne_l_s(CPULoongArchState *env, uint64_t fj)
     return fd;
 }
 
-uint64_t helper_ftintrne_w_d(CPULoongArchState *env, uint64_t fj)
+uint64_t HELPER(ftintrne_w_d)(CPULoongArchState *env, uint64_t fj)
 {
     uint64_t fd;
     FloatRoundMode old_mode = get_float_rounding_mode(&env->fp_status);
@@ -804,7 +804,7 @@ uint64_t helper_ftintrne_w_d(CPULoongArchState *env, uint64_t fj)
     return fd;
 }
 
-uint64_t helper_ftintrne_w_s(CPULoongArchState *env, uint64_t fj)
+uint64_t HELPER(ftintrne_w_s)(CPULoongArchState *env, uint64_t fj)
 {
     uint32_t fd;
     FloatRoundMode old_mode = get_float_rounding_mode(&env->fp_status);
@@ -822,7 +822,7 @@ uint64_t helper_ftintrne_w_s(CPULoongArchState *env, uint64_t fj)
     return (uint64_t)fd;
 }
 
-uint64_t helper_ftint_l_d(CPULoongArchState *env, uint64_t fj)
+uint64_t HELPER(ftint_l_d)(CPULoongArchState *env, uint64_t fj)
 {
     uint64_t fd;
 
@@ -836,7 +836,7 @@ uint64_t helper_ftint_l_d(CPULoongArchState *env, uint64_t fj)
     return fd;
 }
 
-uint64_t helper_ftint_l_s(CPULoongArchState *env, uint64_t fj)
+uint64_t HELPER(ftint_l_s)(CPULoongArchState *env, uint64_t fj)
 {
     uint64_t fd;
 
@@ -850,7 +850,7 @@ uint64_t helper_ftint_l_s(CPULoongArchState *env, uint64_t fj)
     return fd;
 }
 
-uint64_t helper_ftint_w_s(CPULoongArchState *env, uint64_t fj)
+uint64_t HELPER(ftint_w_s)(CPULoongArchState *env, uint64_t fj)
 {
     uint64_t fd;
 
@@ -864,7 +864,7 @@ uint64_t helper_ftint_w_s(CPULoongArchState *env, uint64_t fj)
     return fd;
 }
 
-uint64_t helper_ftint_w_d(CPULoongArchState *env, uint64_t fj)
+uint64_t HELPER(ftint_w_d)(CPULoongArchState *env, uint64_t fj)
 {
     uint64_t fd;
 
@@ -878,7 +878,7 @@ uint64_t helper_ftint_w_d(CPULoongArchState *env, uint64_t fj)
     return fd;
 }
 
-void helper_set_rounding_mode(CPULoongArchState *env)
+void HELPER(set_rounding_mode)(CPULoongArchState *env)
 {
     set_float_rounding_mode(ieee_rm[(env->fcsr0 >> FCSR0_RM) & 0x3],
                             &env->fp_status);
diff --git a/target/loongarch/tcg/iocsr_helper.c b/target/loongarch/tcg/iocsr_helper.c
index b0f171608bc..be705cebbb1 100644
--- a/target/loongarch/tcg/iocsr_helper.c
+++ b/target/loongarch/tcg/iocsr_helper.c
@@ -14,52 +14,52 @@
 #define GET_MEMTXATTRS(cas) \
         ((MemTxAttrs){.requester_id = env_cpu(cas)->cpu_index})
 
-uint64_t helper_iocsrrd_b(CPULoongArchState *env, target_ulong r_addr)
+uint64_t HELPER(iocsrrd_b)(CPULoongArchState *env, target_ulong r_addr)
 {
     return address_space_ldub(env->address_space_iocsr, r_addr,
                               GET_MEMTXATTRS(env), NULL);
 }
 
-uint64_t helper_iocsrrd_h(CPULoongArchState *env, target_ulong r_addr)
+uint64_t HELPER(iocsrrd_h)(CPULoongArchState *env, target_ulong r_addr)
 {
     return address_space_lduw_le(env->address_space_iocsr, r_addr,
                                  GET_MEMTXATTRS(env), NULL);
 }
 
-uint64_t helper_iocsrrd_w(CPULoongArchState *env, target_ulong r_addr)
+uint64_t HELPER(iocsrrd_w)(CPULoongArchState *env, target_ulong r_addr)
 {
     return address_space_ldl_le(env->address_space_iocsr, r_addr,
                                 GET_MEMTXATTRS(env), NULL);
 }
 
-uint64_t helper_iocsrrd_d(CPULoongArchState *env, target_ulong r_addr)
+uint64_t HELPER(iocsrrd_d)(CPULoongArchState *env, target_ulong r_addr)
 {
     return address_space_ldq_le(env->address_space_iocsr, r_addr,
                                 GET_MEMTXATTRS(env), NULL);
 }
 
-void helper_iocsrwr_b(CPULoongArchState *env, target_ulong w_addr,
+void HELPER(iocsrwr_b)(CPULoongArchState *env, target_ulong w_addr,
                       target_ulong val)
 {
     address_space_stb(env->address_space_iocsr, w_addr,
                       val, GET_MEMTXATTRS(env), NULL);
 }
 
-void helper_iocsrwr_h(CPULoongArchState *env, target_ulong w_addr,
+void HELPER(iocsrwr_h)(CPULoongArchState *env, target_ulong w_addr,
                       target_ulong val)
 {
     address_space_stw_le(env->address_space_iocsr, w_addr,
                          val, GET_MEMTXATTRS(env), NULL);
 }
 
-void helper_iocsrwr_w(CPULoongArchState *env, target_ulong w_addr,
+void HELPER(iocsrwr_w)(CPULoongArchState *env, target_ulong w_addr,
                       target_ulong val)
 {
     address_space_stl_le(env->address_space_iocsr, w_addr,
                          val, GET_MEMTXATTRS(env), NULL);
 }
 
-void helper_iocsrwr_d(CPULoongArchState *env, target_ulong w_addr,
+void HELPER(iocsrwr_d)(CPULoongArchState *env, target_ulong w_addr,
                       target_ulong val)
 {
     address_space_stq_le(env->address_space_iocsr, w_addr,
diff --git a/target/loongarch/tcg/op_helper.c b/target/loongarch/tcg/op_helper.c
index f98fe4d4a16..44772d03a4b 100644
--- a/target/loongarch/tcg/op_helper.c
+++ b/target/loongarch/tcg/op_helper.c
@@ -17,13 +17,13 @@
 #include "cpu-csr.h"
 
 /* Exceptions helpers */
-void helper_raise_exception(CPULoongArchState *env, uint32_t exception)
+void HELPER(raise_exception)(CPULoongArchState *env, uint32_t exception)
 {
     do_raise_exception(env, exception, GETPC());
 }
 
 /* loongarch assert op */
-void helper_asrtle_d(CPULoongArchState *env, target_ulong rj, target_ulong rk)
+void HELPER(asrtle_d)(CPULoongArchState *env, target_ulong rj, target_ulong rk)
 {
     CPUSysState *sys = env_sys(env);
 
@@ -33,7 +33,7 @@ void helper_asrtle_d(CPULoongArchState *env, target_ulong rj, target_ulong rk)
     }
 }
 
-void helper_asrtgt_d(CPULoongArchState *env, target_ulong rj, target_ulong rk)
+void HELPER(asrtgt_d)(CPULoongArchState *env, target_ulong rj, target_ulong rk)
 {
     CPUSysState *sys = env_sys(env);
 
@@ -43,7 +43,7 @@ void helper_asrtgt_d(CPULoongArchState *env, target_ulong rj, target_ulong rk)
     }
 }
 
-target_ulong helper_crc32(target_ulong val, target_ulong m, uint64_t sz)
+target_ulong HELPER(crc32)(target_ulong val, target_ulong m, uint64_t sz)
 {
     uint8_t buf[8];
     target_ulong mask = ((sz * 8) == 64) ? -1ULL : ((1ULL << (sz * 8)) - 1);
@@ -53,7 +53,7 @@ target_ulong helper_crc32(target_ulong val, target_ulong m, uint64_t sz)
     return (int32_t) (crc32(val ^ 0xffffffff, buf, sz) ^ 0xffffffff);
 }
 
-target_ulong helper_crc32c(target_ulong val, target_ulong m, uint64_t sz)
+target_ulong HELPER(crc32c)(target_ulong val, target_ulong m, uint64_t sz)
 {
     uint8_t buf[8];
     target_ulong mask = ((sz * 8) == 64) ? -1ULL : ((1ULL << (sz * 8)) - 1);
@@ -62,12 +62,12 @@ target_ulong helper_crc32c(target_ulong val, target_ulong m, uint64_t sz)
     return (int32_t) (crc32c(val, buf, sz) ^ 0xffffffff);
 }
 
-target_ulong helper_cpucfg(CPULoongArchState *env, target_ulong rj)
+target_ulong HELPER(cpucfg)(CPULoongArchState *env, target_ulong rj)
 {
     return rj >= ARRAY_SIZE(env->cpucfg) ? 0 : env->cpucfg[rj];
 }
 
-uint64_t helper_rdtime_d(CPULoongArchState *env)
+uint64_t HELPER(rdtime_d)(CPULoongArchState *env)
 {
 #ifdef CONFIG_USER_ONLY
     return cpu_get_host_ticks();
@@ -86,7 +86,7 @@ uint64_t helper_rdtime_d(CPULoongArchState *env)
 }
 
 #ifndef CONFIG_USER_ONLY
-void helper_ertn(CPULoongArchState *env)
+void HELPER(ertn)(CPULoongArchState *env)
 {
     uint64_t csr_pplv, csr_pie;
     CPUSysState *sys = env_sys(env);
@@ -115,7 +115,7 @@ void helper_ertn(CPULoongArchState *env)
     env->lladdr = 1;
 }
 
-void helper_idle(CPULoongArchState *env)
+void HELPER(idle)(CPULoongArchState *env)
 {
     CPUState *cs = env_cpu(env);
 
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 40cc0764248..479c0b208d6 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -310,7 +310,7 @@ static bool loongarch_tlb_search(CPULoongArchState *env, vaddr vaddr,
     return false;
 }
 
-void helper_tlbsrch(CPULoongArchState *env)
+void HELPER(tlbsrch)(CPULoongArchState *env)
 {
     int index, match;
     CPUSysState *sys = env_sys(env);
@@ -330,7 +330,7 @@ void helper_tlbsrch(CPULoongArchState *env)
     sys->CSR_TLBIDX = FIELD_DP64(sys->CSR_TLBIDX, CSR_TLBIDX, NE, 1);
 }
 
-void helper_tlbrd(CPULoongArchState *env)
+void HELPER(tlbrd)(CPULoongArchState *env)
 {
     LoongArchTLB *tlb;
     int index;
@@ -389,7 +389,7 @@ static void update_tlb_index(CPULoongArchState *env, MMUContext *context,
     *old = new;
 }
 
-void helper_tlbwr(CPULoongArchState *env)
+void HELPER(tlbwr)(CPULoongArchState *env)
 {
     CPUSysState *sys = env_sys(env);
     int index = FIELD_EX64(sys->CSR_TLBIDX, CSR_TLBIDX, INDEX);
@@ -469,7 +469,7 @@ static int get_tlb_random_index(CPULoongArchState *env, vaddr addr,
     return index;
 }
 
-void helper_tlbfill(CPULoongArchState *env)
+void HELPER(tlbfill)(CPULoongArchState *env)
 {
     vaddr entryhi;
     int index, pagesize;
@@ -492,7 +492,7 @@ void helper_tlbfill(CPULoongArchState *env)
     fill_tlb_entry(env, env->tlb + index, &context);
 }
 
-void helper_tlbclr(CPULoongArchState *env)
+void HELPER(tlbclr)(CPULoongArchState *env)
 {
     LoongArchTLB *tlb;
     int i, index;
@@ -527,7 +527,7 @@ void helper_tlbclr(CPULoongArchState *env)
     tlb_flush(env_cpu(env));
 }
 
-void helper_tlbflush(CPULoongArchState *env)
+void HELPER(tlbflush)(CPULoongArchState *env)
 {
     int i, index;
     CPUSysState *sys = env_sys(env);
@@ -552,7 +552,7 @@ void helper_tlbflush(CPULoongArchState *env)
     tlb_flush(env_cpu(env));
 }
 
-void helper_invtlb_all(CPULoongArchState *env)
+void HELPER(invtlb_all)(CPULoongArchState *env)
 {
     for (int i = 0; i < LOONGARCH_TLB_MAX; i++) {
         env->tlb[i].tlb_misc = FIELD_DP64(env->tlb[i].tlb_misc,
@@ -561,7 +561,7 @@ void helper_invtlb_all(CPULoongArchState *env)
     tlb_flush(env_cpu(env));
 }
 
-void helper_invtlb_all_g(CPULoongArchState *env, uint32_t g)
+void HELPER(invtlb_all_g)(CPULoongArchState *env, uint32_t g)
 {
     for (int i = 0; i < LOONGARCH_TLB_MAX; i++) {
         LoongArchTLB *tlb = &env->tlb[i];
@@ -574,7 +574,7 @@ void helper_invtlb_all_g(CPULoongArchState *env, uint32_t g)
     tlb_flush(env_cpu(env));
 }
 
-void helper_invtlb_all_asid(CPULoongArchState *env, target_ulong info)
+void HELPER(invtlb_all_asid)(CPULoongArchState *env, target_ulong info)
 {
     uint16_t asid = info & R_CSR_ASID_ASID_MASK;
 
@@ -590,7 +590,7 @@ void helper_invtlb_all_asid(CPULoongArchState *env, target_ulong info)
     tlb_flush(env_cpu(env));
 }
 
-void helper_invtlb_page_asid(CPULoongArchState *env, target_ulong info,
+void HELPER(invtlb_page_asid)(CPULoongArchState *env, target_ulong info,
                              target_ulong addr)
 {
     int asid = info & 0x3ff;
@@ -604,7 +604,7 @@ void helper_invtlb_page_asid(CPULoongArchState *env, target_ulong info,
     }
 }
 
-void helper_invtlb_page_asid_or_g(CPULoongArchState *env,
+void HELPER(invtlb_page_asid_or_g)(CPULoongArchState *env,
                                   target_ulong info, target_ulong addr)
 {
     int asid = info & 0x3ff;
@@ -718,7 +718,7 @@ static inline uint64_t loongarch_sanitize_hw_pte(CPULoongArchState *env,
     return (pte & ~ppn_mask) | ((pte & ppn_mask) & palen_mask);
 }
 
-target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
+target_ulong HELPER(lddir)(CPULoongArchState *env, target_ulong base,
                           uint32_t level, uint32_t mem_idx)
 {
     CPUState *cs = env_cpu(env);
@@ -759,7 +759,7 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
     return val & palen_mask;
 }
 
-void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
+void HELPER(ldpte)(CPULoongArchState *env, target_ulong base, target_ulong odd,
                   uint32_t mem_idx)
 {
     CPUState *cs = env_cpu(env);
diff --git a/target/loongarch/tcg/vec_helper.c b/target/loongarch/tcg/vec_helper.c
index a270998e638..3ada636cd9f 100644
--- a/target/loongarch/tcg/vec_helper.c
+++ b/target/loongarch/tcg/vec_helper.c
@@ -2511,8 +2511,8 @@ void HELPER(NAME)(void *vd, void *vj,                    \
     }                                                    \
 }
 
-FCLASS(vfclass_s, 32, UW, helper_fclass_s)
-FCLASS(vfclass_d, 64, UD, helper_fclass_d)
+FCLASS(vfclass_s, 32, UW, HELPER(fclass_s))
+FCLASS(vfclass_d, 64, UD, HELPER(fclass_d))
 
 #define FSQRT(BIT, T)                                  \
 static T do_fsqrt_## BIT(CPULoongArchState *env, T fj) \
-- 
2.43.0


