Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03472606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LVSUA2WQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HUHACvQv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIun9-0001bI-KO; Mon, 19 Oct 2026 17:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIun7-0001aZ-AO
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIun4-0005fg-8e
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:09 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJKKRV4190411
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=1jwq+whi5e9
 OAXirMqts4Aq+ZRiE3+qiIxNuwH6prbg=; b=LVSUA2WQPEtbP/jtZIEBLqd6phK
 cd16+aDdOjZWAO793Z0VZ8BE9eztnQ8Jc48V9fOgsfQUg6uJUmZq46krO9cepbDJ
 qOD1RtCHBC0lZyvFas/oOpzIYxse6kk7qvsEp74rlP6qEzcXOHleDqeITIU1RmnP
 VwIdTru+4DXRZbKCy4zmyPlqXCv9XNlI0ubJk1NywysukStY9Fcd0TJFtNT8egPp
 WrlwBwcdhsRcJGl66pVxRZjtUPoSPH9b4GKqtnhpS5Z554dUPEVCDq+42jYeBrfD
 gviSIb0A41chmKNkTZv1yCLS+HrSKxSmS8/4pSrWOpkh41Wrwnau6zyCDVw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf48k91h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:04 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3a46f0f158dso97618a91.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792444863; x=1793049663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1jwq+whi5e9OAXirMqts4Aq+ZRiE3+qiIxNuwH6prbg=;
 b=HUHACvQvbWMTJRaEwUQqlks+oxHSuPUqiiCLRWKyIa650TOpodnftcS2NOHXkP4YEx
 SlTDO56/bYAJA+kP5RnuVM8QvpMSOTmBCYaQUGIPmfsXS0dfF42U1z6PFU2kovPKuks9
 R4Oc2wYEbtKoMBGbWnoZS0cV5IN7uYXHgUBtYrHlzFcHs2y4PisDQZiNPRabfDshN6A9
 L9gqmddyB4JjM1ZZ8j9V36NiZpAettkNnPWXn5/hsBlPq11Xcvvyfb2PPJilk2Ru/j8H
 fflQH+LNRE2PVTWHwszGVcVF9jeQGx2HxXhKqcXzZkKK5L89a29iqVzgqKOTL7LyByuo
 BMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792444863; x=1793049663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1jwq+whi5e9OAXirMqts4Aq+ZRiE3+qiIxNuwH6prbg=;
 b=XOQ7hbKlhDWSoO54DwZzZau89QA0ruO+M850RYlrZxpyZ/qh6nw39npKv6gny7S09S
 VFh0/HYDsI8zMy/+L1vOOfXSanYPXdPrfWQeFRANcMcKobo2CgfuHXtDYzAyTq8UeqRe
 QN41pUAzcBA+LZ1f9uznR5six4d862n2IFRBeY4lIqx5ZGBmtM+BG9N+pAuvIn9xmTAr
 5PJmIxBr3KcEwt8Eu+jMO19ABQFS+G8KD2TaQQ5mNfdDS4gU/Kw6bvA+9cj5ejngZYQi
 28HVBNe7b1lrQCcrc65o9fTlYzEDhgB0i59xGqSjoTtXp31FEnoXgXA8QMvTlJwYS7oj
 vluQ==
X-Gm-Message-State: AFq9FYKQHtI7ZgKJNBLcM38BwdjX5VN2dahAqd1LeW+7knLUISUCzatB
 PSNT0Gj1pdBEx42o+e0ah0IIv2R+56M3tqLIHePevuqIVnNrUo0SC4uRd3Ap/jZjgKOCZzjUxyB
 vdszO7r3h2R/TMHeW51odit4AcPCmcptcYmQEsCdUWwz1D1YUufs5BEG265JRLqyfRA==
X-Gm-Gg: AYBFou3rWRhxhFd4wKPqnivo7hEQSnl6LfmllQ5PiIH/sRMlezC+0pdyJNww0fiEGJa
 NwK1Y+A/ymJl4YxiaAqxUovrFyamGphJ6lo/4fZJEF5nGJMCydK8VIiUqJ/SJUWRbZItsWAVhDu
 ydoTdoiYA6aR/02dCqa0mAjdBJ6vsXNZeG9sHurONndzcZnrJQtvP7ZTVjEqzOyFnegsnwGEaQo
 qUqQh6nMPmRH2Y+U8AxzHP55z8OoXXmATO067dtVOdr6C8mO49E9dxwnND05cRn5UffkNixXJit
 Wf7qXukKGco1GUxnA5srMi6h4IkNeoaG211O0rDhxxz5dsm/KNMSjHB0m4lSZrMCcrvGb1YEL6F
 hw4KVYMT8Dg0SQGx56mMFo2c1SYWE1Z6tcgPyGTQ9iQpFcinqjL5YFW5hg1VNAgU=
X-Received: by 2002:a17:90a:c17:b0:3a0:e568:ed63 with SMTP id
 98e67ed59e1d1-3ad64b90b59mr120667a91.8.1792444862986; 
 Mon, 19 Oct 2026 14:21:02 -0700 (PDT)
X-Received: by 2002:a17:90a:c17:b0:3a0:e568:ed63 with SMTP id
 98e67ed59e1d1-3ad64b90b59mr120653a91.8.1792444862277; 
 Mon, 19 Oct 2026 14:21:02 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60ec4457sm863243a91.6.2026.10.19.14.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:21:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 01/26] target/alpha: define and call helpers using HELPER macro
Date: Mon, 19 Oct 2026 21:20:20 +0000
Message-ID: <20261019212046.149572-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX+L7zhM5wGKDR
 ONEHX6U1Uzlm20LIbPbVXfO9Oqv5h2DMOUffkzttLb5fRPpKzB97pQXbLsrhIHqWbQNhOSd21wb
 rLgrNfkWfFUrWuiA8RinoU/oiKLbTtmmNcWHreVLuvILhaIVpK6nFYI1kHMwhwBbOM/EF2tEofe
 oHKbQP3MeFBvWAIUMQuJm9vXtJCIcihytcE0gAM6wxik00kMmYtWkSvKlYjGp7LOF5RTmHfkZcH
 HQdEH/EzsBt+H0pURSnA6NpLLJonBxpQ8p/UrrSzCaCJ7yYD5w3VT31DWOH1KTpZSzilDSmkyuF
 JxkP0ZUmBzlTbiB4DukyYj3yzoUvh/kP71J3/c8KSoU9P5e7evsFcfAzAmw8pvrVVFRd/Qi9sHN
 SHIDj9e2TYSE4gu/h8rvamoYwSAsORiMobHJjQg3wG238v4VBxA2yKzC+oar1RCoRorHk7WYeIW
 4Nu1CWlgRLE02kaDNww==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX4ej2mjhBDLNk
 UoxJCW6hLtE9KCUJ9Uy+xV7RDEV+lZmnNSuwht0j2f3JVSRuDjf8o3Snz8m9nDOmtRm2WSkhpq1
 PMw8sXkTih6Fwczy6f0B8Q8UQhrDHZM=
X-Proofpoint-ORIG-GUID: LXkSB1dyJmEZwt9aCWwncyNRazKanN_3
X-Authority-Analysis: v=2.4 cv=Qr/LTlyd c=1 sm=1 tr=0 ts=6ad689c0 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=OayeTtTT_1BB-LWajB0A:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: LXkSB1dyJmEZwt9aCWwncyNRazKanN_3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
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
index 529eadca9f2..61166396f6e 100644
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
@@ -71,7 +71,7 @@ static void fp_exc_raise1(CPUAlphaState *env, uintptr_t retaddr,
 /* Raise exceptions for ieee fp insns without software completion.
    In that case there are no exceptions that don't trap; the mask
    doesn't apply.  */
-void helper_fp_exc_raise(CPUAlphaState *env, uint32_t ignore, uint32_t regno)
+void HELPER(fp_exc_raise)(CPUAlphaState *env, uint32_t ignore, uint32_t regno)
 {
     uint32_t exc = env->error_code;
     if (exc) {
@@ -84,7 +84,7 @@ void helper_fp_exc_raise(CPUAlphaState *env, uint32_t ignore, uint32_t regno)
 }
 
 /* Raise exceptions for ieee fp insns with software completion.  */
-void helper_fp_exc_raise_s(CPUAlphaState *env, uint32_t ignore, uint32_t regno)
+void HELPER(fp_exc_raise_s)(CPUAlphaState *env, uint32_t ignore, uint32_t regno)
 {
     uint32_t exc = env->error_code & ~ignore;
     if (exc) {
@@ -107,7 +107,7 @@ void helper_fp_exc_raise_s(CPUAlphaState *env, uint32_t ignore, uint32_t regno)
 
 /* Input handing without software completion.  Trap for all
    non-finite numbers.  */
-void helper_ieee_input(CPUAlphaState *env, uint64_t val)
+void HELPER(ieee_input)(CPUAlphaState *env, uint64_t val)
 {
     uint32_t exp = (uint32_t)(val >> 52) & 0x7ff;
     uint64_t frac = val & 0xfffffffffffffull;
@@ -125,7 +125,7 @@ void helper_ieee_input(CPUAlphaState *env, uint64_t val)
 }
 
 /* Similar, but does not trap for infinities.  Used for comparisons.  */
-void helper_ieee_input_cmp(CPUAlphaState *env, uint64_t val)
+void HELPER(ieee_input_cmp)(CPUAlphaState *env, uint64_t val)
 {
     uint32_t exp = (uint32_t)(val >> 52) & 0x7ff;
     uint64_t frac = val & 0xfffffffffffffull;
@@ -148,7 +148,7 @@ void helper_ieee_input_cmp(CPUAlphaState *env, uint64_t val)
    then the code downstream of that will need to cope with denorms sans
    flush_input_to_zero.  Most of it should work sanely, but there's
    nothing to compare with.  */
-void helper_ieee_input_s(CPUAlphaState *env, uint64_t val)
+void HELPER(ieee_input_s)(CPUAlphaState *env, uint64_t val)
 {
     if (unlikely(2 * val - 1 < 0x1fffffffffffffull)
         && !get_flush_inputs_to_zero(&env->fp_status)) {
@@ -202,17 +202,17 @@ static inline float32 s_to_float32(uint64_t a)
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
 
@@ -224,7 +224,7 @@ uint64_t helper_adds(CPUAlphaState *env, uint64_t a, uint64_t b)
     return float32_to_s(fr);
 }
 
-uint64_t helper_subs(CPUAlphaState *env, uint64_t a, uint64_t b)
+uint64_t HELPER(subs)(CPUAlphaState *env, uint64_t a, uint64_t b)
 {
     float32 fa, fb, fr;
 
@@ -236,7 +236,7 @@ uint64_t helper_subs(CPUAlphaState *env, uint64_t a, uint64_t b)
     return float32_to_s(fr);
 }
 
-uint64_t helper_muls(CPUAlphaState *env, uint64_t a, uint64_t b)
+uint64_t HELPER(muls)(CPUAlphaState *env, uint64_t a, uint64_t b)
 {
     float32 fa, fb, fr;
 
@@ -248,7 +248,7 @@ uint64_t helper_muls(CPUAlphaState *env, uint64_t a, uint64_t b)
     return float32_to_s(fr);
 }
 
-uint64_t helper_alpha_divs(CPUAlphaState *env, uint64_t a, uint64_t b)
+uint64_t HELPER(alpha_divs)(CPUAlphaState *env, uint64_t a, uint64_t b)
 {
     float32 fa, fb, fr;
 
@@ -260,7 +260,7 @@ uint64_t helper_alpha_divs(CPUAlphaState *env, uint64_t a, uint64_t b)
     return float32_to_s(fr);
 }
 
-uint64_t helper_sqrts(CPUAlphaState *env, uint64_t a)
+uint64_t HELPER(sqrts)(CPUAlphaState *env, uint64_t a)
 {
     float32 fa, fr;
 
@@ -289,7 +289,7 @@ static inline uint64_t float64_to_t(float64 fa)
     return r.ll;
 }
 
-uint64_t helper_addt(CPUAlphaState *env, uint64_t a, uint64_t b)
+uint64_t HELPER(addt)(CPUAlphaState *env, uint64_t a, uint64_t b)
 {
     float64 fa, fb, fr;
 
@@ -301,7 +301,7 @@ uint64_t helper_addt(CPUAlphaState *env, uint64_t a, uint64_t b)
     return float64_to_t(fr);
 }
 
-uint64_t helper_subt(CPUAlphaState *env, uint64_t a, uint64_t b)
+uint64_t HELPER(subt)(CPUAlphaState *env, uint64_t a, uint64_t b)
 {
     float64 fa, fb, fr;
 
@@ -313,7 +313,7 @@ uint64_t helper_subt(CPUAlphaState *env, uint64_t a, uint64_t b)
     return float64_to_t(fr);
 }
 
-uint64_t helper_mult(CPUAlphaState *env, uint64_t a, uint64_t b)
+uint64_t HELPER(mult)(CPUAlphaState *env, uint64_t a, uint64_t b)
 {
     float64 fa, fb, fr;
 
@@ -325,7 +325,7 @@ uint64_t helper_mult(CPUAlphaState *env, uint64_t a, uint64_t b)
     return float64_to_t(fr);
 }
 
-uint64_t helper_divt(CPUAlphaState *env, uint64_t a, uint64_t b)
+uint64_t HELPER(divt)(CPUAlphaState *env, uint64_t a, uint64_t b)
 {
     float64 fa, fb, fr;
 
@@ -337,7 +337,7 @@ uint64_t helper_divt(CPUAlphaState *env, uint64_t a, uint64_t b)
     return float64_to_t(fr);
 }
 
-uint64_t helper_sqrtt(CPUAlphaState *env, uint64_t a)
+uint64_t HELPER(sqrtt)(CPUAlphaState *env, uint64_t a)
 {
     float64 fa, fr;
 
@@ -349,7 +349,7 @@ uint64_t helper_sqrtt(CPUAlphaState *env, uint64_t a)
 }
 
 /* Comparisons */
-uint64_t helper_cmptun(CPUAlphaState *env, uint64_t a, uint64_t b)
+uint64_t HELPER(cmptun)(CPUAlphaState *env, uint64_t a, uint64_t b)
 {
     float64 fa, fb;
     uint64_t ret = 0;
@@ -365,7 +365,7 @@ uint64_t helper_cmptun(CPUAlphaState *env, uint64_t a, uint64_t b)
     return ret;
 }
 
-uint64_t helper_cmpteq(CPUAlphaState *env, uint64_t a, uint64_t b)
+uint64_t HELPER(cmpteq)(CPUAlphaState *env, uint64_t a, uint64_t b)
 {
     float64 fa, fb;
     uint64_t ret = 0;
@@ -381,7 +381,7 @@ uint64_t helper_cmpteq(CPUAlphaState *env, uint64_t a, uint64_t b)
     return ret;
 }
 
-uint64_t helper_cmptle(CPUAlphaState *env, uint64_t a, uint64_t b)
+uint64_t HELPER(cmptle)(CPUAlphaState *env, uint64_t a, uint64_t b)
 {
     float64 fa, fb;
     uint64_t ret = 0;
@@ -397,7 +397,7 @@ uint64_t helper_cmptle(CPUAlphaState *env, uint64_t a, uint64_t b)
     return ret;
 }
 
-uint64_t helper_cmptlt(CPUAlphaState *env, uint64_t a, uint64_t b)
+uint64_t HELPER(cmptlt)(CPUAlphaState *env, uint64_t a, uint64_t b)
 {
     float64 fa, fb;
     uint64_t ret = 0;
@@ -414,7 +414,7 @@ uint64_t helper_cmptlt(CPUAlphaState *env, uint64_t a, uint64_t b)
 }
 
 /* Floating point format conversion */
-uint64_t helper_cvtts(CPUAlphaState *env, uint64_t a)
+uint64_t HELPER(cvtts)(CPUAlphaState *env, uint64_t a)
 {
     float64 fa;
     float32 fr;
@@ -426,7 +426,7 @@ uint64_t helper_cvtts(CPUAlphaState *env, uint64_t a)
     return float32_to_s(fr);
 }
 
-uint64_t helper_cvtst(CPUAlphaState *env, uint64_t a)
+uint64_t HELPER(cvtst)(CPUAlphaState *env, uint64_t a)
 {
     float32 fa;
     float64 fr;
@@ -438,7 +438,7 @@ uint64_t helper_cvtst(CPUAlphaState *env, uint64_t a)
     return float64_to_t(fr);
 }
 
-uint64_t helper_cvtqs(CPUAlphaState *env, uint64_t a)
+uint64_t HELPER(cvtqs)(CPUAlphaState *env, uint64_t a)
 {
     float32 fr = int64_to_float32(a, &FP_STATUS);
     env->error_code = soft_to_fpcr_exc(env);
@@ -483,24 +483,24 @@ static uint64_t do_cvttq(CPUAlphaState *env, uint64_t a, int roundmode)
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
     env->error_code = soft_to_fpcr_exc(env);
     return float64_to_t(fr);
 }
 
-uint64_t helper_cvtql(CPUAlphaState *env, uint64_t val)
+uint64_t HELPER(cvtql)(CPUAlphaState *env, uint64_t val)
 {
     uint32_t exc = 0;
     if (val != (int32_t)val) {
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index c3614ecafda..c8fc46d666f 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -91,12 +91,12 @@ void cpu_alpha_store_fpcr(CPUAlphaState *env, uint64_t val)
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
@@ -535,7 +535,7 @@ void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 
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
2.43.0


