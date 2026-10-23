Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C593606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=orQorwGg;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UANe1u3N
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKI1A-0001iR-5p; Fri, 23 Oct 2026 12:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI0v-0001b6-OZ
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:21:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI0n-0002yf-LB
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:21:05 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE67UM3019010
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:20:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YXpYGsQko7oiiDUGSY97O1bimieZO6QhavLk+dcE/0o=; b=orQorwGg/wQU18hF
 iQgBDS8CF7S5eqeaeU5gY6kKHcYhS1D1GK/33Wi5CB439gCPnuXGKaMkwhoN4J5R
 bO+T6qE56vU8w/sUQ757KLfIFghyoGkxRwzBLLpPQ2nekcrjdxptPgeb430uyzBt
 9IZteo2Y5mFDVGWnkmmp9Y76vZ/8b6YXGCmOga3ljzpiq/F7+VCQLcFdXVArauCC
 edmuE6p+3mKBTcziiqsCUCq/EFSHFYt6CwPkiLznuV5uJipl/wcRVQP90w9S63Fu
 6rb6pRZ8cecWzBeVctwCRZqjMFiTEhIbLGl+JQLIHEpkJByQb5/shcUWtKvB7RzB
 1wQFXA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsykby5u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:20:49 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f5844cb60so194182385a.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772449; x=1793377249; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YXpYGsQko7oiiDUGSY97O1bimieZO6QhavLk+dcE/0o=;
 b=UANe1u3NUIZLmRB4E9kX0k2Fx0YutNSroi1mh9j9cpOEsMEONMnvo5TipWqL1fZ+/w
 LNhkNkmhk2DMklnybNhcvoBfy0ptusBkfhjT4Dl2JWrDsWsY6ijkcxfptWA9+0cyBDAX
 u+wRAWK0ZdeNDtYgfnMmQWfkro8N6sGIU0FQMg3PzjF1jHMYz45zX/lEhC1qMw8m8jxj
 8C1PdAUbOF7oocZN/yDukJ+BawIAIeYz0+AJ0eJHoyskfSvRYjdLLRPAy7POHoOOUm2i
 D/ZcN6R0wSGDMWwRsZGI4d9/VoAEZ+TvWhM3ErHIs+5262BrN9GCysxgHHPD/y8dA+MU
 Iy9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772449; x=1793377249;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YXpYGsQko7oiiDUGSY97O1bimieZO6QhavLk+dcE/0o=;
 b=QtSkZWasO03D43BkMSCFJsyBDmgtQpWUTj78ie3oBY/yrBIgmJ696VY7uoOPQCD8aT
 cRmRaa/WHcDwp0HfzxXRSh04q2mX1hcU1nZJRS1XXH/fFKz02UyuKRmeHexge+87WBjh
 Fcu1kCPd2izeB5O0rxXfDl/IRna2+MBQzZQW1NN5PBroS8n2kM3ctwavtVSlWcXe5f/x
 4knMduXt3gwrejXILObr0AO0YBAciBxSjYpeiykNOq0aamEkmf6AxK0jpAHV2mEEiqFE
 S4ojKwqpveInN+ATUsqnbZyTpp1BDSsqiGL275p8rkqJ4rbalMnOKhtoCs1/hfErUVoh
 n0LA==
X-Gm-Message-State: AFq9FYIbEd6E09HVn9A2/6O9iv5IwT9zi21P8iP9Roy7OC8eLhItgY7m
 sMl1EOaPUv7K2xv2ypt7v48xKfnWpssM9d+eH2oyRnNNOs6dovpO8Pmq++hnLSUEgfQtFzJlF42
 PRavGrpLGBzdDdcsHj67yLY8Ana7ddmHS5i1yHfVHNRtNSWiSpwhLuEKIRrDn1hSfRrhz
X-Gm-Gg: AYBFou0d8H4SMsWX94u0Ru/ahMbuOf+5NtNUfeSHWVi8J4kO1QkQKsMQ8LUsJvc71gn
 NH4oRFYLzvNAp8vE5le7rGLMbokom8JvqWS7s3DH+PBRQNXiQSi7sVFYfvSS8sNMNOqHBUW8HMY
 4OlY9t1OELzaugjrHILHzaVDW+Rf/eS5rWmJOJMnz13waZhnM6XBNYnmRVr9Iv4naeeNtX9TCKa
 Ms65NWM+0UtTD8bF5EupT+aNnGWx2f4r0YC9rlNNYsj8/RdDcY+qUpYFjACzX7zF7Ax2ts0m94j
 mBimV+N1l1WU7T4ccwJzUMPiMgXL80kzhyTTxEhclhjIlAU4UbT40Rnl46lvN928Xzxn58ujpx9
 1BU91bxQjrTRWEbHCFD9ifA+4v+Is7f4e9kKLx4ys
X-Received: by 2002:a05:620a:2b4d:b0:93e:e111:2778 with SMTP id
 af79cd13be357-93f626db3bdmr983590285a.14.1792772448407; 
 Fri, 23 Oct 2026 09:20:48 -0700 (PDT)
X-Received: by 2002:a05:620a:2b4d:b0:93e:e111:2778 with SMTP id
 af79cd13be357-93f626db3bdmr983583885a.14.1792772447470; 
 Fri, 23 Oct 2026 09:20:47 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d421f65sm750389f8f.48.2026.10.23.09.20.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:20:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 60/83] target/alpha: define and call helpers using HELPER macro
Date: Fri, 23 Oct 2026 18:13:08 +0200
Message-ID: <20261023161332.60153-61-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX+w55b7vnd1s0
 XSfaXik3xXMFdEnUirUE6xwJ9CDG1/HhtJJGQniO80yBc/WJRBl2f1+gO2iekzaO7e6/L10+fWY
 hE7E4HqAXF61KOuFYwgNLjGXoS2jNzcP4KrdFJhSwNQxB/QsVMSygJRaPUCkVNlwpejaKAjAmZa
 PjRGOba72uQhh05t9eYvRaijGoBA1E77KU34nlI+T1CgXKeUWFFmasG79z4z60yCTFCuW5qHAb9
 IMS+5AkOQRvIDNkB8Yo94pVsXVQCfx1MGtOqDXJa+SVUMKSA+DcGO5RbLYZDHWCZndSDsVgQO8S
 HizHVN9T6pJAgEn2lzHkLJIhMJqK+Syy6N2GFUS9O+MKSMWOftkePNYV0NIWzBEXuvg9UFmK+OP
 oF2ZGQzZredAspQNozWmoDpPN9pF5Wg+mr4R37ra1327eOywAsXkyfcJDC3Wr99xc+grOHbkwfu
 Rm92WRU0P1LEn8M+ZEg==
X-Proofpoint-ORIG-GUID: nHmkquvO6y5IjTUrEreU6aSVYY9FkV9S
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX9iq4vl/dga8z
 fVLMjf0DV1Ioa6KNDk2P0zpp9s/aDZ3Mrk2vanmMkkiTE/Lcz29m2VtamhtzypVnrk7minFhZT/
 N5tNECf66l+eOyPEd1FXin1dZUfs2cw=
X-Proofpoint-GUID: nHmkquvO6y5IjTUrEreU6aSVYY9FkV9S
X-Authority-Analysis: v=2.4 cv=GLKdgeNK c=1 sm=1 tr=0 ts=6adb8961 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=d489uCCT4T9dLKBjaQgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
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
Message-ID: <20261019212046.149572-2-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/alpha/clk_helper.c |  2 +-
 target/alpha/fpu_helper.c | 60 +++++++++++++++++++--------------------
 target/alpha/helper.c     |  6 ++--
 target/alpha/int_helper.c | 38 ++++++++++++-------------
 target/alpha/sys_helper.c | 12 ++++----
 target/alpha/vax_helper.c | 42 +++++++++++++--------------
 6 files changed, 80 insertions(+), 80 deletions(-)

diff --git a/target/alpha/clk_helper.c b/target/alpha/clk_helper.c
index 26ffc231cda..36674221a66 100644
--- a/target/alpha/clk_helper.c
+++ b/target/alpha/clk_helper.c
@@ -11,7 +11,7 @@
 #include "exec/helper-proto.h"
 #include "cpu.h"
 
-uint64_t helper_load_pcc(CPUAlphaState *env)
+uint64_t HELPER(load_pcc)(CPUAlphaState *env)
 {
 #ifndef CONFIG_USER_ONLY
     /*
diff --git a/target/alpha/fpu_helper.c b/target/alpha/fpu_helper.c
index e91e907c215..cc095ac156d 100644
--- a/target/alpha/fpu_helper.c
+++ b/target/alpha/fpu_helper.c
@@ -25,12 +25,12 @@
 #define FP_STATUS (env->fp_status)
 
 
-void helper_setroundmode(CPUAlphaState *env, uint32_t val)
+void HELPER(setroundmode)(CPUAlphaState *env, uint32_t val)
 {
     set_float_rounding_mode(val, &FP_STATUS);
 }
 
-void helper_setflushzero(CPUAlphaState *env, uint32_t val)
+void HELPER(setflushzero)(CPUAlphaState *env, uint32_t val)
 {
     set_flush_to_zero(val, &FP_STATUS);
 }
@@ -91,7 +91,7 @@ static void fp_exc_raise1(CPUAlphaState *env, uintptr_t retaddr,
 /* Raise exceptions for ieee fp insns without software completion.
    In that case there are no exceptions that don't trap; the mask
    doesn't apply.  */
-void helper_fp_exc_raise(CPUAlphaState *env, uint32_t ignore, uint32_t regno)
+void HELPER(fp_exc_raise)(CPUAlphaState *env, uint32_t ignore, uint32_t regno)
 {
     uint32_t exc = env->error_code;
     if (exc) {
@@ -104,7 +104,7 @@ void helper_fp_exc_raise(CPUAlphaState *env, uint32_t ignore, uint32_t regno)
 }
 
 /* Raise exceptions for ieee fp insns with software completion.  */
-void helper_fp_exc_raise_s(CPUAlphaState *env, uint32_t ignore, uint32_t regno)
+void HELPER(fp_exc_raise_s)(CPUAlphaState *env, uint32_t ignore, uint32_t regno)
 {
     uint32_t exc = env->error_code;
     if (exc) {
@@ -135,7 +135,7 @@ void helper_fp_exc_raise_s(CPUAlphaState *env, uint32_t ignore, uint32_t regno)
 
 /* Input handing without software completion.  Trap for all
    non-finite numbers.  */
-void helper_ieee_input(CPUAlphaState *env, uint64_t val)
+void HELPER(ieee_input)(CPUAlphaState *env, uint64_t val)
 {
     uint32_t exp = (uint32_t)(val >> 52) & 0x7ff;
     uint64_t frac = val & 0xfffffffffffffull;
@@ -153,7 +153,7 @@ void helper_ieee_input(CPUAlphaState *env, uint64_t val)
 }
 
 /* Similar, but does not trap for infinities.  Used for comparisons.  */
-void helper_ieee_input_cmp(CPUAlphaState *env, uint64_t val)
+void HELPER(ieee_input_cmp)(CPUAlphaState *env, uint64_t val)
 {
     uint32_t exp = (uint32_t)(val >> 52) & 0x7ff;
     uint64_t frac = val & 0xfffffffffffffull;
@@ -176,7 +176,7 @@ void helper_ieee_input_cmp(CPUAlphaState *env, uint64_t val)
    then the code downstream of that will need to cope with denorms sans
    flush_input_to_zero.  Most of it should work sanely, but there's
    nothing to compare with.  */
-void helper_ieee_input_s(CPUAlphaState *env, uint64_t val)
+void HELPER(ieee_input_s)(CPUAlphaState *env, uint64_t val)
 {
     if (unlikely(2 * val - 1 < 0x1fffffffffffffull)
         && !get_flush_inputs_to_zero(&env->fp_status)) {
@@ -230,17 +230,17 @@ static inline float32 s_to_float32(uint64_t a)
     return r.f;
 }
 
-uint32_t helper_s_to_memory(uint64_t a)
+uint32_t HELPER(s_to_memory)(uint64_t a)
 {
     return s_to_float32_int(a);
 }
 
-uint64_t helper_memory_to_s(uint32_t a)
+uint64_t HELPER(memory_to_s)(uint32_t a)
 {
     return float32_to_s_int(a);
 }
 
-uint64_t helper_adds(CPUAlphaState *env, uint64_t a, uint64_t b)
+uint64_t HELPER(adds)(CPUAlphaState *env, uint64_t a, uint64_t b)
 {
     float32 fa, fb, fr;
 
@@ -252,7 +252,7 @@ uint64_t helper_adds(CPUAlphaState *env, uint64_t a, uint64_t b)
     return float32_to_s(fr);
 }
 
-uint64_t helper_subs(CPUAlphaState *env, uint64_t a, uint64_t b)
+uint64_t HELPER(subs)(CPUAlphaState *env, uint64_t a, uint64_t b)
 {
     float32 fa, fb, fr;
 
@@ -264,7 +264,7 @@ uint64_t helper_subs(CPUAlphaState *env, uint64_t a, uint64_t b)
     return float32_to_s(fr);
 }
 
-uint64_t helper_muls(CPUAlphaState *env, uint64_t a, uint64_t b)
+uint64_t HELPER(muls)(CPUAlphaState *env, uint64_t a, uint64_t b)
 {
     float32 fa, fb, fr;
 
@@ -276,7 +276,7 @@ uint64_t helper_muls(CPUAlphaState *env, uint64_t a, uint64_t b)
     return float32_to_s(fr);
 }
 
-uint64_t helper_alpha_divs(CPUAlphaState *env, uint64_t a, uint64_t b)
+uint64_t HELPER(alpha_divs)(CPUAlphaState *env, uint64_t a, uint64_t b)
 {
     float32 fa, fb, fr;
 
@@ -288,7 +288,7 @@ uint64_t helper_alpha_divs(CPUAlphaState *env, uint64_t a, uint64_t b)
     return float32_to_s(fr);
 }
 
-uint64_t helper_sqrts(CPUAlphaState *env, uint64_t a)
+uint64_t HELPER(sqrts)(CPUAlphaState *env, uint64_t a)
 {
     float32 fa, fr;
 
@@ -317,7 +317,7 @@ static inline uint64_t float64_to_t(float64 fa)
     return r.ll;
 }
 
-uint64_t helper_addt(CPUAlphaState *env, uint64_t a, uint64_t b)
+uint64_t HELPER(addt)(CPUAlphaState *env, uint64_t a, uint64_t b)
 {
     float64 fa, fb, fr;
 
@@ -329,7 +329,7 @@ uint64_t helper_addt(CPUAlphaState *env, uint64_t a, uint64_t b)
     return float64_to_t(fr);
 }
 
-uint64_t helper_subt(CPUAlphaState *env, uint64_t a, uint64_t b)
+uint64_t HELPER(subt)(CPUAlphaState *env, uint64_t a, uint64_t b)
 {
     float64 fa, fb, fr;
 
@@ -341,7 +341,7 @@ uint64_t helper_subt(CPUAlphaState *env, uint64_t a, uint64_t b)
     return float64_to_t(fr);
 }
 
-uint64_t helper_mult(CPUAlphaState *env, uint64_t a, uint64_t b)
+uint64_t HELPER(mult)(CPUAlphaState *env, uint64_t a, uint64_t b)
 {
     float64 fa, fb, fr;
 
@@ -353,7 +353,7 @@ uint64_t helper_mult(CPUAlphaState *env, uint64_t a, uint64_t b)
     return float64_to_t(fr);
 }
 
-uint64_t helper_divt(CPUAlphaState *env, uint64_t a, uint64_t b)
+uint64_t HELPER(divt)(CPUAlphaState *env, uint64_t a, uint64_t b)
 {
     float64 fa, fb, fr;
 
@@ -365,7 +365,7 @@ uint64_t helper_divt(CPUAlphaState *env, uint64_t a, uint64_t b)
     return float64_to_t(fr);
 }
 
-uint64_t helper_sqrtt(CPUAlphaState *env, uint64_t a)
+uint64_t HELPER(sqrtt)(CPUAlphaState *env, uint64_t a)
 {
     float64 fa, fr;
 
@@ -377,7 +377,7 @@ uint64_t helper_sqrtt(CPUAlphaState *env, uint64_t a)
 }
 
 /* Comparisons */
-uint64_t helper_cmptun(CPUAlphaState *env, uint64_t a, uint64_t b)
+uint64_t HELPER(cmptun)(CPUAlphaState *env, uint64_t a, uint64_t b)
 {
     float64 fa, fb;
     uint64_t ret = 0;
@@ -393,7 +393,7 @@ uint64_t helper_cmptun(CPUAlphaState *env, uint64_t a, uint64_t b)
     return ret;
 }
 
-uint64_t helper_cmpteq(CPUAlphaState *env, uint64_t a, uint64_t b)
+uint64_t HELPER(cmpteq)(CPUAlphaState *env, uint64_t a, uint64_t b)
 {
     float64 fa, fb;
     uint64_t ret = 0;
@@ -409,7 +409,7 @@ uint64_t helper_cmpteq(CPUAlphaState *env, uint64_t a, uint64_t b)
     return ret;
 }
 
-uint64_t helper_cmptle(CPUAlphaState *env, uint64_t a, uint64_t b)
+uint64_t HELPER(cmptle)(CPUAlphaState *env, uint64_t a, uint64_t b)
 {
     float64 fa, fb;
     uint64_t ret = 0;
@@ -425,7 +425,7 @@ uint64_t helper_cmptle(CPUAlphaState *env, uint64_t a, uint64_t b)
     return ret;
 }
 
-uint64_t helper_cmptlt(CPUAlphaState *env, uint64_t a, uint64_t b)
+uint64_t HELPER(cmptlt)(CPUAlphaState *env, uint64_t a, uint64_t b)
 {
     float64 fa, fb;
     uint64_t ret = 0;
@@ -442,7 +442,7 @@ uint64_t helper_cmptlt(CPUAlphaState *env, uint64_t a, uint64_t b)
 }
 
 /* Floating point format conversion */
-uint64_t helper_cvtts(CPUAlphaState *env, uint64_t a)
+uint64_t HELPER(cvtts)(CPUAlphaState *env, uint64_t a)
 {
     float64 fa;
     float32 fr;
@@ -454,7 +454,7 @@ uint64_t helper_cvtts(CPUAlphaState *env, uint64_t a)
     return float32_to_s(fr);
 }
 
-uint64_t helper_cvtst(CPUAlphaState *env, uint64_t a)
+uint64_t HELPER(cvtst)(CPUAlphaState *env, uint64_t a)
 {
     float32 fa;
     float64 fr;
@@ -466,7 +466,7 @@ uint64_t helper_cvtst(CPUAlphaState *env, uint64_t a)
     return float64_to_t(fr);
 }
 
-uint64_t helper_cvtqs(CPUAlphaState *env, uint64_t a)
+uint64_t HELPER(cvtqs)(CPUAlphaState *env, uint64_t a)
 {
     float32 fr = int64_to_float32(a, &FP_STATUS);
     env->error_code = soft_to_fpcr_exc(env, false);
@@ -511,24 +511,24 @@ static uint64_t do_cvttq(CPUAlphaState *env, uint64_t a, int roundmode)
     return ret;
 }
 
-uint64_t helper_cvttq(CPUAlphaState *env, uint64_t a)
+uint64_t HELPER(cvttq)(CPUAlphaState *env, uint64_t a)
 {
     return do_cvttq(env, a, get_float_rounding_mode(&FP_STATUS));
 }
 
-uint64_t helper_cvttq_c(CPUAlphaState *env, uint64_t a)
+uint64_t HELPER(cvttq_c)(CPUAlphaState *env, uint64_t a)
 {
     return do_cvttq(env, a, float_round_to_zero);
 }
 
-uint64_t helper_cvtqt(CPUAlphaState *env, uint64_t a)
+uint64_t HELPER(cvtqt)(CPUAlphaState *env, uint64_t a)
 {
     float64 fr = int64_to_float64(a, &FP_STATUS);
     env->error_code = soft_to_fpcr_exc(env, false);
     return float64_to_t(fr);
 }
 
-uint64_t helper_cvtql(CPUAlphaState *env, uint64_t val)
+uint64_t HELPER(cvtql)(CPUAlphaState *env, uint64_t val)
 {
     uint32_t exc = 0;
     if (val != (int32_t)val) {
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index d59ecc0d4a9..55c7782b4d2 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -111,12 +111,12 @@ void cpu_alpha_store_fpcr(CPUAlphaState *env, uint64_t val)
     env->fpcr_flush_to_zero = t;
 }
 
-uint64_t helper_load_fpcr(CPUAlphaState *env)
+uint64_t HELPER(load_fpcr)(CPUAlphaState *env)
 {
     return cpu_alpha_load_fpcr(env);
 }
 
-void helper_store_fpcr(CPUAlphaState *env, uint64_t val)
+void HELPER(store_fpcr)(CPUAlphaState *env, uint64_t val)
 {
     cpu_alpha_store_fpcr(env, val);
 }
@@ -531,7 +531,7 @@ void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 
 /* This should only be called from translate, via gen_excp.
    We expect that ENV->PC has already been updated.  */
-G_NORETURN void helper_excp(CPUAlphaState *env, int excp, int error)
+G_NORETURN void HELPER(excp)(CPUAlphaState *env, int excp, int error)
 {
     CPUState *cs = env_cpu(env);
 
diff --git a/target/alpha/int_helper.c b/target/alpha/int_helper.c
index 6bfe63500e0..11b0af82bc1 100644
--- a/target/alpha/int_helper.c
+++ b/target/alpha/int_helper.c
@@ -23,7 +23,7 @@
 #include "qemu/host-utils.h"
 
 
-uint64_t helper_zapnot(uint64_t val, uint64_t mskb)
+uint64_t HELPER(zapnot)(uint64_t val, uint64_t mskb)
 {
     uint64_t mask;
 
@@ -39,12 +39,12 @@ uint64_t helper_zapnot(uint64_t val, uint64_t mskb)
     return val & mask;
 }
 
-uint64_t helper_zap(uint64_t val, uint64_t mask)
+uint64_t HELPER(zap)(uint64_t val, uint64_t mask)
 {
-    return helper_zapnot(val, ~mask);
+    return HELPER(zapnot)(val, ~mask);
 }
 
-uint64_t helper_cmpbe0(uint64_t a)
+uint64_t HELPER(cmpbe0)(uint64_t a)
 {
     uint64_t m = 0x7f7f7f7f7f7f7f7fULL;
     uint64_t c = ~(((a & m) + m) | a | m);
@@ -58,7 +58,7 @@ uint64_t helper_cmpbe0(uint64_t a)
     return c >> 56;
 }
 
-uint64_t helper_cmpbge(uint64_t a, uint64_t b)
+uint64_t HELPER(cmpbge)(uint64_t a, uint64_t b)
 {
     uint64_t mask = 0x00ff00ff00ff00ffULL;
     uint64_t test = 0x0100010001000100ULL;
@@ -87,7 +87,7 @@ uint64_t helper_cmpbge(uint64_t a, uint64_t b)
     return cl >> 50;
 }
 
-uint64_t helper_minub8(uint64_t op1, uint64_t op2)
+uint64_t HELPER(minub8)(uint64_t op1, uint64_t op2)
 {
     uint64_t res = 0;
     uint8_t opa, opb, opr;
@@ -102,7 +102,7 @@ uint64_t helper_minub8(uint64_t op1, uint64_t op2)
     return res;
 }
 
-uint64_t helper_minsb8(uint64_t op1, uint64_t op2)
+uint64_t HELPER(minsb8)(uint64_t op1, uint64_t op2)
 {
     uint64_t res = 0;
     int8_t opa, opb;
@@ -118,7 +118,7 @@ uint64_t helper_minsb8(uint64_t op1, uint64_t op2)
     return res;
 }
 
-uint64_t helper_minuw4(uint64_t op1, uint64_t op2)
+uint64_t HELPER(minuw4)(uint64_t op1, uint64_t op2)
 {
     uint64_t res = 0;
     uint16_t opa, opb, opr;
@@ -133,7 +133,7 @@ uint64_t helper_minuw4(uint64_t op1, uint64_t op2)
     return res;
 }
 
-uint64_t helper_minsw4(uint64_t op1, uint64_t op2)
+uint64_t HELPER(minsw4)(uint64_t op1, uint64_t op2)
 {
     uint64_t res = 0;
     int16_t opa, opb;
@@ -149,7 +149,7 @@ uint64_t helper_minsw4(uint64_t op1, uint64_t op2)
     return res;
 }
 
-uint64_t helper_maxub8(uint64_t op1, uint64_t op2)
+uint64_t HELPER(maxub8)(uint64_t op1, uint64_t op2)
 {
     uint64_t res = 0;
     uint8_t opa, opb, opr;
@@ -164,7 +164,7 @@ uint64_t helper_maxub8(uint64_t op1, uint64_t op2)
     return res;
 }
 
-uint64_t helper_maxsb8(uint64_t op1, uint64_t op2)
+uint64_t HELPER(maxsb8)(uint64_t op1, uint64_t op2)
 {
     uint64_t res = 0;
     int8_t opa, opb;
@@ -180,7 +180,7 @@ uint64_t helper_maxsb8(uint64_t op1, uint64_t op2)
     return res;
 }
 
-uint64_t helper_maxuw4(uint64_t op1, uint64_t op2)
+uint64_t HELPER(maxuw4)(uint64_t op1, uint64_t op2)
 {
     uint64_t res = 0;
     uint16_t opa, opb, opr;
@@ -195,7 +195,7 @@ uint64_t helper_maxuw4(uint64_t op1, uint64_t op2)
     return res;
 }
 
-uint64_t helper_maxsw4(uint64_t op1, uint64_t op2)
+uint64_t HELPER(maxsw4)(uint64_t op1, uint64_t op2)
 {
     uint64_t res = 0;
     int16_t opa, opb;
@@ -211,7 +211,7 @@ uint64_t helper_maxsw4(uint64_t op1, uint64_t op2)
     return res;
 }
 
-uint64_t helper_perr(uint64_t op1, uint64_t op2)
+uint64_t HELPER(perr)(uint64_t op1, uint64_t op2)
 {
     uint64_t res = 0;
     uint8_t opa, opb, opr;
@@ -230,12 +230,12 @@ uint64_t helper_perr(uint64_t op1, uint64_t op2)
     return res;
 }
 
-uint64_t helper_pklb(uint64_t op1)
+uint64_t HELPER(pklb)(uint64_t op1)
 {
     return (op1 & 0xff) | ((op1 >> 24) & 0xff00);
 }
 
-uint64_t helper_pkwb(uint64_t op1)
+uint64_t HELPER(pkwb)(uint64_t op1)
 {
     return ((op1 & 0xff)
             | ((op1 >> 8) & 0xff00)
@@ -243,12 +243,12 @@ uint64_t helper_pkwb(uint64_t op1)
             | ((op1 >> 24) & 0xff000000));
 }
 
-uint64_t helper_unpkbl(uint64_t op1)
+uint64_t HELPER(unpkbl)(uint64_t op1)
 {
     return (op1 & 0xff) | ((op1 & 0xff00) << 24);
 }
 
-uint64_t helper_unpkbw(uint64_t op1)
+uint64_t HELPER(unpkbw)(uint64_t op1)
 {
     return ((op1 & 0xff)
             | ((op1 & 0xff00) << 8)
@@ -256,7 +256,7 @@ uint64_t helper_unpkbw(uint64_t op1)
             | ((op1 & 0xff000000) << 24));
 }
 
-void helper_check_overflow(CPUAlphaState *env, uint64_t op1, uint64_t op2)
+void HELPER(check_overflow)(CPUAlphaState *env, uint64_t op1, uint64_t op2)
 {
     if (unlikely(op1 != op2)) {
         arith_excp(env, GETPC(), EXC_M_IOV, 0);
diff --git a/target/alpha/sys_helper.c b/target/alpha/sys_helper.c
index 0e0a619975b..95613e97f2b 100644
--- a/target/alpha/sys_helper.c
+++ b/target/alpha/sys_helper.c
@@ -27,17 +27,17 @@
 
 
 /* PALcode support special instructions */
-void helper_tbia(CPUAlphaState *env)
+void HELPER(tbia)(CPUAlphaState *env)
 {
     tlb_flush(env_cpu(env));
 }
 
-void helper_tbis(CPUAlphaState *env, uint64_t p)
+void HELPER(tbis)(CPUAlphaState *env, uint64_t p)
 {
     tlb_flush_page(env_cpu(env), p);
 }
 
-void helper_halt(uint64_t restart)
+void HELPER(halt)(uint64_t restart)
 {
     if (restart) {
         qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
@@ -46,17 +46,17 @@ void helper_halt(uint64_t restart)
     }
 }
 
-uint64_t helper_get_vmtime(void)
+uint64_t HELPER(get_vmtime)(void)
 {
     return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
 }
 
-uint64_t helper_get_walltime(void)
+uint64_t HELPER(get_walltime)(void)
 {
     return qemu_clock_get_ns(rtc_clock);
 }
 
-void helper_set_alarm(CPUAlphaState *env, uint64_t expire)
+void HELPER(set_alarm)(CPUAlphaState *env, uint64_t expire)
 {
     AlphaCPU *cpu = env_archcpu(env);
 
diff --git a/target/alpha/vax_helper.c b/target/alpha/vax_helper.c
index c1d201e7b4d..01c12538494 100644
--- a/target/alpha/vax_helper.c
+++ b/target/alpha/vax_helper.c
@@ -82,7 +82,7 @@ static float32 f_to_float32(CPUAlphaState *env, uintptr_t retaddr, uint64_t a)
     return r.f;
 }
 
-uint32_t helper_f_to_memory(uint64_t a)
+uint32_t HELPER(f_to_memory)(uint64_t a)
 {
     uint32_t r;
     r =  (a & 0x00001fffe0000000ull) >> 13;
@@ -91,7 +91,7 @@ uint32_t helper_f_to_memory(uint64_t a)
     return r;
 }
 
-uint64_t helper_memory_to_f(uint32_t a)
+uint64_t HELPER(memory_to_f)(uint32_t a)
 {
     uint64_t r;
     r =  ((uint64_t)(a & 0x0000c000)) << 48;
@@ -106,7 +106,7 @@ uint64_t helper_memory_to_f(uint32_t a)
 /* ??? Emulating VAX arithmetic with IEEE arithmetic is wrong.  We should
    either implement VAX arithmetic properly or just signal invalid opcode.  */
 
-uint64_t helper_addf(CPUAlphaState *env, uint64_t a, uint64_t b)
+uint64_t HELPER(addf)(CPUAlphaState *env, uint64_t a, uint64_t b)
 {
     float32 fa, fb, fr;
 
@@ -116,7 +116,7 @@ uint64_t helper_addf(CPUAlphaState *env, uint64_t a, uint64_t b)
     return float32_to_f(fr);
 }
 
-uint64_t helper_subf(CPUAlphaState *env, uint64_t a, uint64_t b)
+uint64_t HELPER(subf)(CPUAlphaState *env, uint64_t a, uint64_t b)
 {
     float32 fa, fb, fr;
 
@@ -126,7 +126,7 @@ uint64_t helper_subf(CPUAlphaState *env, uint64_t a, uint64_t b)
     return float32_to_f(fr);
 }
 
-uint64_t helper_mulf(CPUAlphaState *env, uint64_t a, uint64_t b)
+uint64_t HELPER(mulf)(CPUAlphaState *env, uint64_t a, uint64_t b)
 {
     float32 fa, fb, fr;
 
@@ -136,7 +136,7 @@ uint64_t helper_mulf(CPUAlphaState *env, uint64_t a, uint64_t b)
     return float32_to_f(fr);
 }
 
-uint64_t helper_divf(CPUAlphaState *env, uint64_t a, uint64_t b)
+uint64_t HELPER(divf)(CPUAlphaState *env, uint64_t a, uint64_t b)
 {
     float32 fa, fb, fr;
 
@@ -146,7 +146,7 @@ uint64_t helper_divf(CPUAlphaState *env, uint64_t a, uint64_t b)
     return float32_to_f(fr);
 }
 
-uint64_t helper_sqrtf(CPUAlphaState *env, uint64_t t)
+uint64_t HELPER(sqrtf)(CPUAlphaState *env, uint64_t t)
 {
     float32 ft, fr;
 
@@ -213,7 +213,7 @@ static float64 g_to_float64(CPUAlphaState *env, uintptr_t retaddr, uint64_t a)
     return r.d;
 }
 
-uint64_t helper_g_to_memory(uint64_t a)
+uint64_t HELPER(g_to_memory)(uint64_t a)
 {
     uint64_t r;
     r =  (a & 0x000000000000ffffull) << 48;
@@ -223,7 +223,7 @@ uint64_t helper_g_to_memory(uint64_t a)
     return r;
 }
 
-uint64_t helper_memory_to_g(uint64_t a)
+uint64_t HELPER(memory_to_g)(uint64_t a)
 {
     uint64_t r;
     r =  (a & 0x000000000000ffffull) << 48;
@@ -233,7 +233,7 @@ uint64_t helper_memory_to_g(uint64_t a)
     return r;
 }
 
-uint64_t helper_addg(CPUAlphaState *env, uint64_t a, uint64_t b)
+uint64_t HELPER(addg)(CPUAlphaState *env, uint64_t a, uint64_t b)
 {
     float64 fa, fb, fr;
 
@@ -243,7 +243,7 @@ uint64_t helper_addg(CPUAlphaState *env, uint64_t a, uint64_t b)
     return float64_to_g(fr);
 }
 
-uint64_t helper_subg(CPUAlphaState *env, uint64_t a, uint64_t b)
+uint64_t HELPER(subg)(CPUAlphaState *env, uint64_t a, uint64_t b)
 {
     float64 fa, fb, fr;
 
@@ -253,7 +253,7 @@ uint64_t helper_subg(CPUAlphaState *env, uint64_t a, uint64_t b)
     return float64_to_g(fr);
 }
 
-uint64_t helper_mulg(CPUAlphaState *env, uint64_t a, uint64_t b)
+uint64_t HELPER(mulg)(CPUAlphaState *env, uint64_t a, uint64_t b)
 {
     float64 fa, fb, fr;
 
@@ -263,7 +263,7 @@ uint64_t helper_mulg(CPUAlphaState *env, uint64_t a, uint64_t b)
     return float64_to_g(fr);
 }
 
-uint64_t helper_divg(CPUAlphaState *env, uint64_t a, uint64_t b)
+uint64_t HELPER(divg)(CPUAlphaState *env, uint64_t a, uint64_t b)
 {
     float64 fa, fb, fr;
 
@@ -273,7 +273,7 @@ uint64_t helper_divg(CPUAlphaState *env, uint64_t a, uint64_t b)
     return float64_to_g(fr);
 }
 
-uint64_t helper_sqrtg(CPUAlphaState *env, uint64_t a)
+uint64_t HELPER(sqrtg)(CPUAlphaState *env, uint64_t a)
 {
     float64 fa, fr;
 
@@ -282,7 +282,7 @@ uint64_t helper_sqrtg(CPUAlphaState *env, uint64_t a)
     return float64_to_g(fr);
 }
 
-uint64_t helper_cmpgeq(CPUAlphaState *env, uint64_t a, uint64_t b)
+uint64_t HELPER(cmpgeq)(CPUAlphaState *env, uint64_t a, uint64_t b)
 {
     float64 fa, fb;
 
@@ -296,7 +296,7 @@ uint64_t helper_cmpgeq(CPUAlphaState *env, uint64_t a, uint64_t b)
     }
 }
 
-uint64_t helper_cmpgle(CPUAlphaState *env, uint64_t a, uint64_t b)
+uint64_t HELPER(cmpgle)(CPUAlphaState *env, uint64_t a, uint64_t b)
 {
     float64 fa, fb;
 
@@ -310,7 +310,7 @@ uint64_t helper_cmpgle(CPUAlphaState *env, uint64_t a, uint64_t b)
     }
 }
 
-uint64_t helper_cmpglt(CPUAlphaState *env, uint64_t a, uint64_t b)
+uint64_t HELPER(cmpglt)(CPUAlphaState *env, uint64_t a, uint64_t b)
 {
     float64 fa, fb;
 
@@ -324,13 +324,13 @@ uint64_t helper_cmpglt(CPUAlphaState *env, uint64_t a, uint64_t b)
     }
 }
 
-uint64_t helper_cvtqf(CPUAlphaState *env, uint64_t a)
+uint64_t HELPER(cvtqf)(CPUAlphaState *env, uint64_t a)
 {
     float32 fr = int64_to_float32(a, &FP_STATUS);
     return float32_to_f(fr);
 }
 
-uint64_t helper_cvtgf(CPUAlphaState *env, uint64_t a)
+uint64_t HELPER(cvtgf)(CPUAlphaState *env, uint64_t a)
 {
     float64 fa;
     float32 fr;
@@ -340,13 +340,13 @@ uint64_t helper_cvtgf(CPUAlphaState *env, uint64_t a)
     return float32_to_f(fr);
 }
 
-uint64_t helper_cvtgq(CPUAlphaState *env, uint64_t a)
+uint64_t HELPER(cvtgq)(CPUAlphaState *env, uint64_t a)
 {
     float64 fa = g_to_float64(env, GETPC(), a);
     return float64_to_int64_round_to_zero(fa, &FP_STATUS);
 }
 
-uint64_t helper_cvtqg(CPUAlphaState *env, uint64_t a)
+uint64_t HELPER(cvtqg)(CPUAlphaState *env, uint64_t a)
 {
     float64 fr;
     fr = int64_to_float64(a, &FP_STATUS);
-- 
2.55.0


