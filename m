Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFBE606A325
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FEz0pFzm;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EFGyHB6p
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKI1Y-0002Ra-2s; Fri, 23 Oct 2026 12:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI1R-0002Bk-Cj
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:21:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI1K-00032o-Cq
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:21:36 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE5s9L4072757
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:21:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8e4oPz4EfoU3x+glKCwLlowOkYZVL0c9YQwOk10UYaU=; b=FEz0pFzmwmQcgT8r
 SPnudPSBZA5V0LfWM7unJOl0U5pkUjHOyT9Vs8wQ2OpIZUV67u79mNOss1KcWs6C
 N6C1bVGrzqyAgIOG9RO5iVx3vSCxEc/gMSt6F4kblLpT+x21m8TR4VkbupMcY2QP
 6ZusZJDOyjsnaLTctnbRHKZfUzdrMzcQEDaD/mEnZ7s9zsPJTbKmX3HmaNI/BNr+
 7Csimx39yQ2Hihkdu42G9StwfXhFu2ooKX81lKDQQah693CtRzzoKE632at6oCKh
 5Oksb3l1vSfNMdpfCcyZ5jnMfM3XMhFDhPtLZVY7GYdpcxhTZUtcreq9m7pIJlUM
 BVOCNw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hg7bw0xm2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:21:27 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93e92aad34aso211959685a.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772486; x=1793377286; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8e4oPz4EfoU3x+glKCwLlowOkYZVL0c9YQwOk10UYaU=;
 b=EFGyHB6pPnLi9I9YF66ww1cEqic4Md1fYDx4Y1wWJxVcx4XUkUygkavl8dSysvjyGA
 SgkjDOxq7+1xr49eKrcwMRpVlDyhJFi86IHAl0bjWhKoAMsT8ZwXxnHE36uHQgSKTNHF
 k2xy1JcVzDFQrMRELvaELLlUjs0l/mK1xHtw96KV2CGAcmRZ6gbCNsAwzvQZzhLLm6zD
 Fosq4xGMo9onfEpWTo+6k5TNV+KNTf0PSLZojF9+6Gs+1WA0zVsSi/Q2X5wtGrYBWZRE
 r0/IQY0iADuVnKPK6K6LiVbwFNS7eBx3AKiBnsb5zEfE3QKxUznIvpveO/TLPsLQRHDc
 JhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772486; x=1793377286;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8e4oPz4EfoU3x+glKCwLlowOkYZVL0c9YQwOk10UYaU=;
 b=2q00RzNnCQkJfxQmmb9Y5WzFVi2Tdobqz+Z9XwliHGAh1hwgjPmI69XvLamJuX4Oz2
 LYeIsewyTJr38WWH9R6IahEbmHb2G5OP+sd+Djn4Ij/Btx1AdbYAkunAGVaf/0MLmJNw
 UAbK2knZ6cMebNbXW/u15cmodZpJ6n699wflOQ/hYuttdQonXrK+HPWhZrY9cwHskwpK
 wu+7YOhhS6YcjR3wWAl6E7oIdxs3MnQH+nkYdDt0QsLYsFIr1Yq5pr7+wJPB6J6w3zEt
 oheurSsKL87CFpd10+QGYWPLs60b0ztTc+eCiO7pebVj1wzh5W1LOdF/WP951n7ox2A5
 REAQ==
X-Gm-Message-State: AFq9FYLocY1PtQ5QConP6kSt4ayWWbjbhIiUZITM3G/Lt/q4pGD4ob+X
 mL1yjU47Y8RehUhWL2tkZQOJgnZ3LTwUyOH6X98Psabi2cWrh03dRLYIDXmBY5JjzTHkFBYDdHL
 j3EoAHTQagi1hyWxKULG5LPBumO7SEguGMw0S/vm9mtxAcqMMoFAkZE1AC+MYWAkbC+ux
X-Gm-Gg: AYBFou30QcgcR3K6p3y7Z76ktK9l/30bD6Ta8L6/Z7fQ/eheSLCmo1U50+qhpVLWkjV
 s2NX/GSqX8ajFqrz1S3YqjdHRzIrQuuoGSXL+9w8WlaNvOgpKq5wqC6FjAeiVCwHvd7nDCK/6l4
 M2uI6e1BcDYSwEefJPjn7gokqJwpDai64CuYyJuXT+HJg6SRMj/i/20q5BAnT8h/9FEh3koxLr3
 ExGfIsYG7J3JWw89eoiHWdxul0nURI6uZIfTaRwx4OqgxcAPaVttz4kY15hl2lM7HbO0gwv1Cqp
 yhYDBaNTjhvqI5jBz+PfmOqqRNMBKy+Wg1CpqHGSy3ruPa0NiFlCAFNzQt55jOhi0TN/P3VyKdy
 BxGhrjBQSrVOTJRJ8cKpgCpbtIHDA5P4kHSqmY/9Y
X-Received: by 2002:a05:620a:2b4e:b0:93f:228c:5301 with SMTP id
 af79cd13be357-93f6f85ede5mr487622585a.64.1792772485729; 
 Fri, 23 Oct 2026 09:21:25 -0700 (PDT)
X-Received: by 2002:a05:620a:2b4e:b0:93f:228c:5301 with SMTP id
 af79cd13be357-93f6f85ede5mr487613085a.64.1792772484630; 
 Fri, 23 Oct 2026 09:21:24 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d3ee6b2sm645344f8f.13.2026.10.23.09.21.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:21:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 65/83] target/loongarch: define and call helpers using HELPER
 macro
Date: Fri, 23 Oct 2026 18:13:13 +0200
Message-ID: <20261023161332.60153-66-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 63ydEZrSrRzcui9vcmAFkByYF2nQA6Vv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX7l5/7JJWl8Xq
 oN/KZir7ZqpAciqImsBwDoGfx6Va/oX74OEOPXd9/bclK0QIjoecHpvYr5c5AcbiCw8taeo11M0
 D/7++jxEiLDfQDBeS4WmiBvIY3F+nog=
X-Authority-Analysis: v=2.4 cv=QdTzLcbv c=1 sm=1 tr=0 ts=6adb8987 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=SQnn4VcWqfzk9PnhchsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: 63ydEZrSrRzcui9vcmAFkByYF2nQA6Vv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX1IiQ3DYCTIYJ
 EbJhwE3EO7NCYEZT3LAQ8wvcFRrVQ0+KTC1mckz040YZznO6o9b7StlwQH9byxz7qOctDryxcmP
 S/HC3Din5EWI+cT14absBmU5yeu+tBxNSMX3YS6bzJEdIHLnZMA3sobECUIDntBj00U/j50Zla0
 CZ2cEdiUerXI83gNQGp7nQvh2qfvYRHwxc3blw/d75Va0E7rhDW2UpLGt6OEq05ak+TrbKy0V+w
 LkCqsoBddCE4WGvaKCh0vz12JLkvfPbOF5x/Wt6IEONIelVKYuADtM+Fa4PG4AvwAZHb68RGzsV
 eNYfLeLEnC3EXD80bnKj1gqP1B3Mq/b/hUeIvKtx0XprwVOSuf9H0aZuLIvJWMcMl4A63kzze2R
 6DeWGJxZY3kVHTvEs+3+Ymb5jci9/GSyUMfToJD9RfzIxyDpmsB58o6LCpp0gEfc9IIUXn7etpi
 23UnzPLZSYHU05MQpJQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230064
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

In a upcoming commit, we'll prefix all helpers and helper_info with target
prefix, to disambiguate symbols between targets. As a first step, we need to
make sure all usages are using the existing HELPER macro.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-ID: <20261019212046.149572-7-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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
2.55.0


