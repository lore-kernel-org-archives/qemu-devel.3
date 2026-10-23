Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4229E606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NsmTLVHX;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RWJJ7WlB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKI2O-0005Yo-0y; Fri, 23 Oct 2026 12:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI2H-0005PN-5Q
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:22:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI2E-00036S-MB
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:22:28 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NG41jf3812454
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fIuremeUkYXSNJeuyHlL2dWnhrkQ1Ph8wvOr/DzvASo=; b=NsmTLVHXRHWSGUXN
 mdy0lMbP+Q69NEi3JVPhnJo3gvCb6xdrVSp/NLqwrbmCXyvxLW5CfOLZYMyS+Z9S
 B+oXtzGWhRK50A79gmJTKVCzy0nj3y1XFBiJRI6/ot59Ekt7grvq31rpBE1QSn9n
 OX+8DxYTO4nTCCSgq+Kx0krMRLvfnLNSKa9Eva9WiyC3aGBwl0gew6XPDL6JRanY
 Jn4luxfBRHIGyOaRb0eAvD55DLn27BEtEYzSUFtpzUv6UW+RhQfE296I6SEIhsJp
 MbGFUM7Q5kxNFzDSCxJ7AHhyGPpfD+s3I2EEUxeqcz5kkF5tv3dCilC4cqmzyb/3
 be0soA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgas882f3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:22:25 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f1f2fafeaso140452385a.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772545; x=1793377345; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fIuremeUkYXSNJeuyHlL2dWnhrkQ1Ph8wvOr/DzvASo=;
 b=RWJJ7WlBxk75h1S3EIl6YWOYehYIllwp8Kz13pfBgTtRJjYlZM0OBOwzWN+hlstEIK
 YBMYJQxPxckv5F/p0tIQ4EGkCRtFCtZrKkeLL3gMvM4OxDbOSH1fgxpCDBNwvOXqIui6
 KCE36lTshHF8ZtTqVkMA9kiOHaKyT+zZ0V7cE6xSSwqrNpd95Gn3ntVpHLo7LyvJrDre
 rW0XXp9TC8C5arvqHX/Vt6uGsq1Xdb+uQSjrHXRuAvNQBBthBxkS517fMMT8EE6YxLWB
 +WTZCDpww/m956YLGBjJlCIGmorS2EaC7cBp1l7JczelhYHFMoRxHdOAKapeJxNH8M5t
 pIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772545; x=1793377345;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fIuremeUkYXSNJeuyHlL2dWnhrkQ1Ph8wvOr/DzvASo=;
 b=elJ7PTvRoqV1t/W7lP+ZM4h69IJUGZ97F+XSCQQPHQQ2mziVDD4inEfMn7LM/zNavg
 ANLWn4EAFHCn06yLujo9TAHxLMawFd49pOjDLu5OLzXfnFBv+ofAfLGcXUxsrRXPrKEZ
 /gQ0F22BTM81aMJcrRjZ5WL9X6kCBBLBq+RmBqhSWide3N2SDjhvYZuqkmUN1xoNJ056
 C8OPOQXNG59lw1Ln1vcT2G8Y2DxeKxY2UPzwdua7sh4yXHQ3dBJNIn5mfM18RMz9KJqI
 FD9UoUO+9B/B0mU8MY08suIdYZzIn48H0MO85ktpDcAT+i1XdflAUELw8l+wke6GrR48
 YA8Q==
X-Gm-Message-State: AFq9FYKTxw4RYp0PD460CwXlo9tcCy5CQ6WpQyOo2XGd+pmQCqRMJ6lq
 PXGO7MVCam1neZuMbBnSVIf4Pu5jaej+T3fusQcl9fBArklklqP8DV6b0BLKIG/kvJveT5GaTnW
 k9I/3enDz9GA/N0xy/buSjZnVolIuUsJVP4wVtKMB8zN8WGYa4NBV9Qeoi0v/Aw+VLj0y
X-Gm-Gg: AYBFou1eVZqGz8rGJkwS1JQ19lwG61XXPmfQGrKl5tVY66WQF7+DXQOM0Zjj3+ndhQb
 IqRJy+szsI5kpOcEtag4a13w1lK7njWfxd/MBCxDud15JTZUYSePmLqAE+RwwXIXVjuBagSLgOL
 q38HjREcWxpYbNFhu6byldggWMrSEUIFiKvnFT7RTkl7WWm+rSwSXnW+OhUVZ9HOMzZSbnRRsNA
 KDl49cGBRasrni7z3EUP54JwH8d76W+oLA7QSj2uH5U7mIIT6mKcOisB1q5Xjt2FmhGby21oNbB
 7ZCqDT/bwTbVsTcIoM0Cbnnw9kTCGUVWVHg3R8kJ+YgZFWjpDGtLLCd/qbNyhYD4a7UaoHG45Fs
 Q1RvGNoitbgfhVNNXS0L6rhy5fW04I6C2FJekmldF
X-Received: by 2002:a05:620a:2906:b0:93e:e2a4:b0fe with SMTP id
 af79cd13be357-93f6f9e7e3emr483107785a.66.1792772544677; 
 Fri, 23 Oct 2026 09:22:24 -0700 (PDT)
X-Received: by 2002:a05:620a:2906:b0:93e:e2a4:b0fe with SMTP id
 af79cd13be357-93f6f9e7e3emr483102585a.66.1792772543996; 
 Fri, 23 Oct 2026 09:22:23 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d4076b8sm903992f8f.32.2026.10.23.09.22.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:22:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 73/83] target/sh4: define and call helpers using HELPER macro
Date: Fri, 23 Oct 2026 18:13:21 +0200
Message-ID: <20261023161332.60153-74-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX2RR+RuDne1gb
 59VxWoSTenjO7VJCQ6shTjFEDN3K9mJ680Kub2Q5Qwjzv6A8dw3mnr1J6Sa1kwwvteYGBSEuHvb
 CFVfDZUTsCoKcN8i8rBV598d95a5YZ0=
X-Authority-Analysis: v=2.4 cv=OPqyTiaB c=1 sm=1 tr=0 ts=6adb89c1 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=s8CIgTy_PDT41ihXdFQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX0fyvP9t83rV7
 x+24HIvPFuEebDwwFvjXSTFkUzBkWXxA/9Epz7RC1HPqrVP4gO2GLT6QQp7wjcSFW9CjuuVMCYA
 ZyMP9o2bVzHu4ccxwOX41EqMRlemD/8Z7Z/Q5JpgAt2jGXh4nsaRX8g3QuxLPTkoVKNUfPe1Omx
 Yz+QqaHbhY5ZryTA6zePIOhlFY1e7e8I3drqbnq5T5rNE4HWJR97K1m7gLtYJm5R3Zp0i2eh7zw
 iZy0oOZp/c9380onAMHcbJEhZfdKZfElTULxf1i8DAoxVQw0XSpdFz/GcKPdbJPWqQB43Wh2UrK
 CehdJhR5GWlPK5bEqi6oPpPAJC6c1D2m02FCugTpHqRG2E/PFiBDmNt7WrJdzQczCXxB+1cRnfT
 NZhaL7nOYZBrVivEK3RXqT0Gs2CSkzlgHQnZCAhiTUp19VgRD55jDaWCOcbQCa3U8ccjDg0EcpH
 l6/8ok7WbbhlYwNwNuQ==
X-Proofpoint-GUID: DzCmInMNK9vPXatlG3qW2wdBaeRcb5l4
X-Proofpoint-ORIG-GUID: DzCmInMNK9vPXatlG3qW2wdBaeRcb5l4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230064
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

In a upcoming commit, we'll prefix all helpers and helper_info with target
prefix, to disambiguate symbols between targets. As a first step, we need to
make sure all usages are using the existing HELPER macro.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-ID: <20261019212046.149572-16-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/sh4/op_helper.c | 76 +++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index 8beac9ca034..6dbdf59385c 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -46,7 +46,7 @@ void superh_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
 
 #endif
 
-void helper_ldtlb(CPUSH4State *env)
+void HELPER(ldtlb)(CPUSH4State *env)
 {
 #ifdef CONFIG_USER_ONLY
     cpu_abort(env_cpu(env), "Unhandled ldtlb");
@@ -65,27 +65,27 @@ void raise_exception(CPUSH4State *env, int index,
     cpu_loop_exit_restore(cs, retaddr);
 }
 
-void helper_raise_illegal_instruction(CPUSH4State *env)
+void HELPER(raise_illegal_instruction)(CPUSH4State *env)
 {
     raise_exception(env, SH4_EXCP_ILLEGAL_INSTRUCTION, 0);
 }
 
-void helper_raise_slot_illegal_instruction(CPUSH4State *env)
+void HELPER(raise_slot_illegal_instruction)(CPUSH4State *env)
 {
     raise_exception(env, SH4_EXCP_SLOT_ILLEGAL_INSTRUCTION, 0);
 }
 
-void helper_raise_fpu_disable(CPUSH4State *env)
+void HELPER(raise_fpu_disable)(CPUSH4State *env)
 {
     raise_exception(env, SH4_EXCP_FPU_DISABLE, 0);
 }
 
-void helper_raise_slot_fpu_disable(CPUSH4State *env)
+void HELPER(raise_slot_fpu_disable)(CPUSH4State *env)
 {
     raise_exception(env, SH4_EXCP_SLOT_FPU_DISABLE, 0);
 }
 
-void helper_sleep(CPUSH4State *env)
+void HELPER(sleep)(CPUSH4State *env)
 {
     CPUState *cs = env_cpu(env);
 
@@ -94,19 +94,19 @@ void helper_sleep(CPUSH4State *env)
     raise_exception(env, EXCP_HLT, 0);
 }
 
-void helper_trapa(CPUSH4State *env, uint32_t tra)
+void HELPER(trapa)(CPUSH4State *env, uint32_t tra)
 {
     env->tra = tra << 2;
     raise_exception(env, SH4_EXCP_TRAPA, 0);
 }
 
-void helper_exclusive(CPUSH4State *env)
+void HELPER(exclusive)(CPUSH4State *env)
 {
     /* We do not want cpu_restore_state to run.  */
     cpu_loop_exit_atomic(env_cpu(env), 0);
 }
 
-void helper_movcal(CPUSH4State *env, uint32_t address, uint32_t value)
+void HELPER(movcal)(CPUSH4State *env, uint32_t address, uint32_t value)
 {
     if (cpu_sh4_is_cached (env, address))
     {
@@ -121,7 +121,7 @@ void helper_movcal(CPUSH4State *env, uint32_t address, uint32_t value)
     }
 }
 
-void helper_discard_movcal_backup(CPUSH4State *env)
+void HELPER(discard_movcal_backup)(CPUSH4State *env)
 {
     memory_content *current = env->movcal_backup;
 
@@ -135,7 +135,7 @@ void helper_discard_movcal_backup(CPUSH4State *env)
     }
 }
 
-void helper_ocbi(CPUSH4State *env, uint32_t address)
+void HELPER(ocbi)(CPUSH4State *env, uint32_t address)
 {
     unsigned mmu_idx = cpu_mmu_index(env_cpu(env), false);
     MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_UNALN, mmu_idx);
@@ -161,7 +161,7 @@ void helper_ocbi(CPUSH4State *env, uint32_t address)
     }
 }
 
-void helper_macl(CPUSH4State *env, int32_t arg0, int32_t arg1)
+void HELPER(macl)(CPUSH4State *env, int32_t arg0, int32_t arg1)
 {
     const int64_t min = -(1ll << 47);
     const int64_t max = (1ll << 47) - 1;
@@ -180,7 +180,7 @@ void helper_macl(CPUSH4State *env, int32_t arg0, int32_t arg1)
     env->mac = res;
 }
 
-void helper_macw(CPUSH4State *env, int32_t arg0, int32_t arg1)
+void HELPER(macw)(CPUSH4State *env, int32_t arg0, int32_t arg1)
 {
     /* Inputs are already sign-extended from 16 bits. */
     int32_t mul = arg0 * arg1;
@@ -216,7 +216,7 @@ void cpu_load_fpscr(CPUSH4State *env, uint32_t val)
     set_flush_to_zero((val & FPSCR_DN) != 0, &env->fp_status);
 }
 
-void helper_ld_fpscr(CPUSH4State *env, uint32_t val)
+void HELPER(ld_fpscr)(CPUSH4State *env, uint32_t val)
 {
     cpu_load_fpscr(env, val);
 }
@@ -260,7 +260,7 @@ static void update_fpscr(CPUSH4State *env, uintptr_t retaddr)
     }
 }
 
-float32 helper_fadd_FT(CPUSH4State *env, float32 t0, float32 t1)
+float32 HELPER(fadd_FT)(CPUSH4State *env, float32 t0, float32 t1)
 {
     set_float_exception_flags(0, &env->fp_status);
     t0 = float32_add(t0, t1, &env->fp_status);
@@ -268,7 +268,7 @@ float32 helper_fadd_FT(CPUSH4State *env, float32 t0, float32 t1)
     return t0;
 }
 
-float64 helper_fadd_DT(CPUSH4State *env, float64 t0, float64 t1)
+float64 HELPER(fadd_DT)(CPUSH4State *env, float64 t0, float64 t1)
 {
     set_float_exception_flags(0, &env->fp_status);
     t0 = float64_add(t0, t1, &env->fp_status);
@@ -276,7 +276,7 @@ float64 helper_fadd_DT(CPUSH4State *env, float64 t0, float64 t1)
     return t0;
 }
 
-uint32_t helper_fcmp_eq_FT(CPUSH4State *env, float32 t0, float32 t1)
+uint32_t HELPER(fcmp_eq_FT)(CPUSH4State *env, float32 t0, float32 t1)
 {
     int relation;
 
@@ -286,7 +286,7 @@ uint32_t helper_fcmp_eq_FT(CPUSH4State *env, float32 t0, float32 t1)
     return relation == float_relation_equal;
 }
 
-uint32_t helper_fcmp_eq_DT(CPUSH4State *env, float64 t0, float64 t1)
+uint32_t HELPER(fcmp_eq_DT)(CPUSH4State *env, float64 t0, float64 t1)
 {
     int relation;
 
@@ -296,7 +296,7 @@ uint32_t helper_fcmp_eq_DT(CPUSH4State *env, float64 t0, float64 t1)
     return relation == float_relation_equal;
 }
 
-uint32_t helper_fcmp_gt_FT(CPUSH4State *env, float32 t0, float32 t1)
+uint32_t HELPER(fcmp_gt_FT)(CPUSH4State *env, float32 t0, float32 t1)
 {
     int relation;
 
@@ -306,7 +306,7 @@ uint32_t helper_fcmp_gt_FT(CPUSH4State *env, float32 t0, float32 t1)
     return relation == float_relation_greater;
 }
 
-uint32_t helper_fcmp_gt_DT(CPUSH4State *env, float64 t0, float64 t1)
+uint32_t HELPER(fcmp_gt_DT)(CPUSH4State *env, float64 t0, float64 t1)
 {
     int relation;
 
@@ -316,7 +316,7 @@ uint32_t helper_fcmp_gt_DT(CPUSH4State *env, float64 t0, float64 t1)
     return relation == float_relation_greater;
 }
 
-float64 helper_fcnvsd_FT_DT(CPUSH4State *env, float32 t0)
+float64 HELPER(fcnvsd_FT_DT)(CPUSH4State *env, float32 t0)
 {
     float64 ret;
     set_float_exception_flags(0, &env->fp_status);
@@ -325,7 +325,7 @@ float64 helper_fcnvsd_FT_DT(CPUSH4State *env, float32 t0)
     return ret;
 }
 
-float32 helper_fcnvds_DT_FT(CPUSH4State *env, float64 t0)
+float32 HELPER(fcnvds_DT_FT)(CPUSH4State *env, float64 t0)
 {
     float32 ret;
     set_float_exception_flags(0, &env->fp_status);
@@ -334,7 +334,7 @@ float32 helper_fcnvds_DT_FT(CPUSH4State *env, float64 t0)
     return ret;
 }
 
-float32 helper_fdiv_FT(CPUSH4State *env, float32 t0, float32 t1)
+float32 HELPER(fdiv_FT)(CPUSH4State *env, float32 t0, float32 t1)
 {
     set_float_exception_flags(0, &env->fp_status);
     t0 = float32_div(t0, t1, &env->fp_status);
@@ -342,7 +342,7 @@ float32 helper_fdiv_FT(CPUSH4State *env, float32 t0, float32 t1)
     return t0;
 }
 
-float64 helper_fdiv_DT(CPUSH4State *env, float64 t0, float64 t1)
+float64 HELPER(fdiv_DT)(CPUSH4State *env, float64 t0, float64 t1)
 {
     set_float_exception_flags(0, &env->fp_status);
     t0 = float64_div(t0, t1, &env->fp_status);
@@ -350,7 +350,7 @@ float64 helper_fdiv_DT(CPUSH4State *env, float64 t0, float64 t1)
     return t0;
 }
 
-float32 helper_float_FT(CPUSH4State *env, uint32_t t0)
+float32 HELPER(float_FT)(CPUSH4State *env, uint32_t t0)
 {
     float32 ret;
     set_float_exception_flags(0, &env->fp_status);
@@ -359,7 +359,7 @@ float32 helper_float_FT(CPUSH4State *env, uint32_t t0)
     return ret;
 }
 
-float64 helper_float_DT(CPUSH4State *env, uint32_t t0)
+float64 HELPER(float_DT)(CPUSH4State *env, uint32_t t0)
 {
     float64 ret;
     set_float_exception_flags(0, &env->fp_status);
@@ -368,7 +368,7 @@ float64 helper_float_DT(CPUSH4State *env, uint32_t t0)
     return ret;
 }
 
-float32 helper_fmac_FT(CPUSH4State *env, float32 t0, float32 t1, float32 t2)
+float32 HELPER(fmac_FT)(CPUSH4State *env, float32 t0, float32 t1, float32 t2)
 {
     set_float_exception_flags(0, &env->fp_status);
     t0 = float32_muladd(t0, t1, t2, 0, &env->fp_status);
@@ -376,7 +376,7 @@ float32 helper_fmac_FT(CPUSH4State *env, float32 t0, float32 t1, float32 t2)
     return t0;
 }
 
-float32 helper_fmul_FT(CPUSH4State *env, float32 t0, float32 t1)
+float32 HELPER(fmul_FT)(CPUSH4State *env, float32 t0, float32 t1)
 {
     set_float_exception_flags(0, &env->fp_status);
     t0 = float32_mul(t0, t1, &env->fp_status);
@@ -384,7 +384,7 @@ float32 helper_fmul_FT(CPUSH4State *env, float32 t0, float32 t1)
     return t0;
 }
 
-float64 helper_fmul_DT(CPUSH4State *env, float64 t0, float64 t1)
+float64 HELPER(fmul_DT)(CPUSH4State *env, float64 t0, float64 t1)
 {
     set_float_exception_flags(0, &env->fp_status);
     t0 = float64_mul(t0, t1, &env->fp_status);
@@ -392,7 +392,7 @@ float64 helper_fmul_DT(CPUSH4State *env, float64 t0, float64 t1)
     return t0;
 }
 
-float32 helper_fsqrt_FT(CPUSH4State *env, float32 t0)
+float32 HELPER(fsqrt_FT)(CPUSH4State *env, float32 t0)
 {
     set_float_exception_flags(0, &env->fp_status);
     t0 = float32_sqrt(t0, &env->fp_status);
@@ -400,7 +400,7 @@ float32 helper_fsqrt_FT(CPUSH4State *env, float32 t0)
     return t0;
 }
 
-float64 helper_fsqrt_DT(CPUSH4State *env, float64 t0)
+float64 HELPER(fsqrt_DT)(CPUSH4State *env, float64 t0)
 {
     set_float_exception_flags(0, &env->fp_status);
     t0 = float64_sqrt(t0, &env->fp_status);
@@ -408,7 +408,7 @@ float64 helper_fsqrt_DT(CPUSH4State *env, float64 t0)
     return t0;
 }
 
-float32 helper_fsrra_FT(CPUSH4State *env, float32 t0)
+float32 HELPER(fsrra_FT)(CPUSH4State *env, float32 t0)
 {
     set_float_exception_flags(0, &env->fp_status);
     /* "Approximate" 1/sqrt(x) via actual computation.  */
@@ -426,7 +426,7 @@ float32 helper_fsrra_FT(CPUSH4State *env, float32 t0)
     return t0;
 }
 
-float32 helper_fsub_FT(CPUSH4State *env, float32 t0, float32 t1)
+float32 HELPER(fsub_FT)(CPUSH4State *env, float32 t0, float32 t1)
 {
     set_float_exception_flags(0, &env->fp_status);
     t0 = float32_sub(t0, t1, &env->fp_status);
@@ -434,7 +434,7 @@ float32 helper_fsub_FT(CPUSH4State *env, float32 t0, float32 t1)
     return t0;
 }
 
-float64 helper_fsub_DT(CPUSH4State *env, float64 t0, float64 t1)
+float64 HELPER(fsub_DT)(CPUSH4State *env, float64 t0, float64 t1)
 {
     set_float_exception_flags(0, &env->fp_status);
     t0 = float64_sub(t0, t1, &env->fp_status);
@@ -442,7 +442,7 @@ float64 helper_fsub_DT(CPUSH4State *env, float64 t0, float64 t1)
     return t0;
 }
 
-uint32_t helper_ftrc_FT(CPUSH4State *env, float32 t0)
+uint32_t HELPER(ftrc_FT)(CPUSH4State *env, float32 t0)
 {
     uint32_t ret;
     set_float_exception_flags(0, &env->fp_status);
@@ -451,7 +451,7 @@ uint32_t helper_ftrc_FT(CPUSH4State *env, float32 t0)
     return ret;
 }
 
-uint32_t helper_ftrc_DT(CPUSH4State *env, float64 t0)
+uint32_t HELPER(ftrc_DT)(CPUSH4State *env, float64 t0)
 {
     uint32_t ret;
     set_float_exception_flags(0, &env->fp_status);
@@ -460,7 +460,7 @@ uint32_t helper_ftrc_DT(CPUSH4State *env, float64 t0)
     return ret;
 }
 
-void helper_fipr(CPUSH4State *env, uint32_t m, uint32_t n)
+void HELPER(fipr)(CPUSH4State *env, uint32_t m, uint32_t n)
 {
     int bank, i;
     float32 r, p;
@@ -480,7 +480,7 @@ void helper_fipr(CPUSH4State *env, uint32_t m, uint32_t n)
     env->fregs[bank + n + 3] = r;
 }
 
-void helper_ftrv(CPUSH4State *env, uint32_t n)
+void HELPER(ftrv)(CPUSH4State *env, uint32_t n)
 {
     int bank_matrix, bank_vector;
     int i, j;
-- 
2.55.0


