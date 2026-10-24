Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0554C606A31D
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 17:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=k3jo0+ka;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=acnBFwOP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKfgB-00040I-Rn; Sat, 24 Oct 2026 13:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKfg4-0003yo-Ja
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:37:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKfg2-0008HW-BK
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:37:08 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OExo2o1907240
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:37:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /nVC7LhIMNAHL67W//clxJJkgyyHz+phG1sVN8NOk/A=; b=k3jo0+kaccBBU4Oe
 w3bczpTlvTiRUf9nB/nqY8HGtxC8d7X96NwVXO/CkkfPZVjaC18/exOKXUIntzp3
 ydGkuGsQcX7cDr0gifFAZniLAr6dw5cGfHLFJhdOWpVdfoKWcLe2fk2DkKkKhMfk
 5nT7IuSIkQeXhrZO2NPxAATAin/q/oZl880qTzHw43jgd/TUysiwetLKoz5lYtW5
 RdqXDeWS+TBCAdc7D/5Wgd4MIPx/rNHWrT8It+INhmiy92mjtSh1rvoFSN30rgac
 0A8rujg3plPzQHVq7G0MvM+nf4XDKuP4jzL8AZsLijJLHswKbAEXEtNN6IANzwMx
 WQEOGg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgmw3hekg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:37:04 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3aca98f01c1so1754882a91.2
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 10:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792863424; x=1793468224; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/nVC7LhIMNAHL67W//clxJJkgyyHz+phG1sVN8NOk/A=;
 b=acnBFwOPI/nrk3xH2s+8otIOVZkZoZdkuy/43VZk0ODGyzUY0o1rIy6xHKzY3DKOYD
 4e1urPJO4UsilXH/3V2VSohRWih2FZSmkDMI5jP1KLfZI2wMiWeN+XIp5fUtttnHJHeB
 55/KMS5HcIZvPpB98k5123dhpFQ6G88O2QPZIdTQB++qGs7vry2nEBBOp6UsTJ0K+YM8
 MXlG4OUHPeYxNIsjG+8Z4QXAeX9TI37g0fiO6jU9Pj7H1EiTFuu8JfNvIoxNQY9h7BDH
 sY6sIbqATkhqO3CRdtJTVBAnJN+BU5ZpqgU1cNftQ2UOKxdOeVuxfU05hd848p5Cw0kN
 bqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792863424; x=1793468224;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/nVC7LhIMNAHL67W//clxJJkgyyHz+phG1sVN8NOk/A=;
 b=oja4N1c30b6YLxvr0Mcr6dPWszifUhQtsHHV3DK+mO26AF7mIjh+wnjJNbH2GQxbhV
 tNufGU7AhsG4sLrNMpldIMwP+j+c0HG046JQ2gPcfGg4L6dhAc/EGny1CLtwpG7XPd/w
 ozHNSNgRhpgsFpdziz43gGtd5Le0bSU657kE1J+/Nd7sJyz/boqUxpbZk1j5jz1i4heU
 PkO7b5KdECoY6QDviP3w5V/mQISLoqFIj0HUlP79VmqyaYdSDJLDdLmgJh2C0vKfIEOn
 FfMod+eHMAvqXcAXkjBrnxz9+xPw7h/o6FTFf3l6VFSb9iSKrsNFIKWKHTQK0dZgvBHF
 3vMw==
X-Gm-Message-State: AFq9FYIc6sOb+JZxL9MBLgAj9wH5PFBhQQQ3Sk4Ps2voqdGxuUKZSHhw
 GelpYkXtZHSvxC0Vyo1hL7GCXyUH0Wj2Pbu6DYDQUVLvk5lY4uuwaf4EW+3I5J8F0Dfp2f0Bk8/
 ienGYAsauWRCSSEOTl2bXxGqvCinh7SXJNLS2OCHhagBg98ST1gIuYshIY0zmxkvUtQ==
X-Gm-Gg: AYBFou1MFVqWfVbBkfGw5gYm17d/tjM1jvhSW9TaTxOiLWZXkoVNs9bT+0VNJREwbtI
 PsZ+wPJ13lsmiZqRKqATMClYKpHDyNmLpmDesJNxQc5832h+76XTHT/3J12rXk6Cqn3NWXu5k2r
 uSLXgenmZZy8Gv/LDAqCYHiDMHtlxQbRtcPeWx9oE0e/G/tta0Ef1Yp38y/uRoVvqMmR94Xxss5
 3IC3Fmj0BcKgc4Bz7yrqlvqVqlmF10msb05e8FK86BLhGxPzFgeseIAPHEDO8sNp0jcrgPtAwD6
 Df0jrlQatvB8LhpzTn6bOU70KpaS4yFAxDrPcIjToDUgNPfX2uxeFlZ9EdavwPgAvLkA9MO3KoF
 Xn1YqpSKcAj2zZ2O++JZWhpFVbfN8pR72qptj42jD4gURUt2TiA4QcxQ06Z4rpHA=
X-Received: by 2002:a17:90b:1f8f:b0:3ac:4e18:237c with SMTP id
 98e67ed59e1d1-3ade9528cdfmr2204366a91.0.1792863423703; 
 Sat, 24 Oct 2026 10:37:03 -0700 (PDT)
X-Received: by 2002:a17:90b:1f8f:b0:3ac:4e18:237c with SMTP id
 98e67ed59e1d1-3ade9528cdfmr2204353a91.0.1792863423192; 
 Sat, 24 Oct 2026 10:37:03 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebbb1a13sm3324093a91.2.2026.10.24.10.37.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 10:37:02 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 07/20] target/hppa: remove explicit target specific prefix
Date: Sat, 24 Oct 2026 17:36:36 +0000
Message-ID: <20261024173649.7405-8-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: EpfyqgKlkWy6uRJlbL72UShRyb1E95RY
X-Proofpoint-ORIG-GUID: EpfyqgKlkWy6uRJlbL72UShRyb1E95RY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfXxebuKBdNy5dn
 rM34MySm1z3P6Mni4tp2wiL5Ca9LsIoGIL1RoJWMyqSN7+wF2n//sx0MkO/QNrhS2H0JG22xbX0
 X0ke65MRC7she2CbtRXTM5kFFnlbx/I=
X-Authority-Analysis: v=2.4 cv=HqHjiETS c=1 sm=1 tr=0 ts=6adcecc0 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=xJBkFjxltbiK57tzlAwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfX7C3Gcss4yPma
 3EPpt5o3bwMGRpOX7ZMIqVgsN5P9RN2GCcRKdj/eSOp71jj6Xz33Qx6+JZyD8W2bWtq6j4Rfy6V
 zzNdTlBsdNiL/D6xwQqzdRNCHVoellPINtFe5o4Ts28Cl1MBs3hThi5iU8CtL0qe4UrIuz4CZQT
 RDu3JT7Mk8q9GPLIoZmMkYVHPdAZGJ0pH6Z8sp75n8rvr4grpTbLYCm9SHB0VKlDr2PAvWk/L5D
 GdavOGyzJh+t66QcvWFTJnPG6btCHZIvPgPJfFYd6MquvjK0hKnfwJlx9OiWbVcYJPdahSbUtZr
 BXdgP2Pu30spqMsj0EPni8C2zTP9DSTb7tzeTtOywdy9VzvSMmFxVWhtkT3Hq8FqIQuuisylcSM
 PneIi1nvnUo5gckRCfSIJw31yAdDHPKKER384446KUQEvASIVmPKPxU7VttBV6Rr88fGvNAF0lu
 zKI5At5lOq4Xq8sln1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240070
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

Now that we have a generic mechanism to prefix all helpers, we can undo the
recent changes that fixed conflicts between targets in multi-target set.

This reverts commit cd095f35b148f3fa0b2000a36af0c9efe2299806
"target/hppa: prefix helpers conflicting with other arch"

Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Acked-by: Yonggang Luo <luoyonggang@gmail.com>
Link: https://lore.kernel.org/qemu-devel/20261024163249.77855-8-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/hppa/helper.h     | 6 +++---
 target/hppa/op_helper.c  | 4 ++--
 target/hppa/sys_helper.c | 8 ++++----
 target/hppa/translate.c  | 6 +++---
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 8d7fa1ae348..8369855d78e 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -1,4 +1,4 @@
-DEF_HELPER_2(hppa_excp, noreturn, env, int)
+DEF_HELPER_2(excp, noreturn, env, int)
 
 DEF_HELPER_FLAGS_3(stby_b, TCG_CALL_NO_WG, void, env, tl, tl)
 DEF_HELPER_FLAGS_3(stby_b_parallel, TCG_CALL_NO_WG, void, env, tl, tl)
@@ -82,8 +82,8 @@ DEF_HELPER_FLAGS_4(fmpynfadd_d, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
 DEF_HELPER_FLAGS_0(read_interval_timer, TCG_CALL_NO_RWG, tl)
 
 #ifndef CONFIG_USER_ONLY
-DEF_HELPER_1(hppa_halt, noreturn, env)
-DEF_HELPER_1(hppa_reset, noreturn, env)
+DEF_HELPER_1(halt, noreturn, env)
+DEF_HELPER_1(reset, noreturn, env)
 DEF_HELPER_1(rfi, void, env)
 DEF_HELPER_1(rfi_r, void, env)
 DEF_HELPER_FLAGS_2(b_gate_priv, TCG_CALL_NO_WG, i64, env, i64)
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index ea0680aa9eb..ec7f2a48e4d 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -30,7 +30,7 @@
 #include "user/page-protection.h"
 #endif
 
-G_NORETURN void HELPER(hppa_excp)(CPUHPPAState *env, int excp)
+G_NORETURN void HELPER(excp)(CPUHPPAState *env, int excp)
 {
     CPUState *cs = env_cpu(env);
 
@@ -341,7 +341,7 @@ target_ulong HELPER(probe)(CPUHPPAState *env, target_ulong addr,
         if (excp == EXCP_DTLB_MISS) {
             excp = EXCP_NA_DTLB_MISS;
         }
-        HELPER(hppa_excp)(env, excp);
+        HELPER(excp)(env, excp);
     }
     return (want & prot) != 0;
 #endif
diff --git a/target/hppa/sys_helper.c b/target/hppa/sys_helper.c
index ccfc2b48816..4a8bbf32591 100644
--- a/target/hppa/sys_helper.c
+++ b/target/hppa/sys_helper.c
@@ -48,16 +48,16 @@ void HELPER(write_interval_timer)(CPUHPPAState *env, target_ulong val)
     timer_mod(cpu->alarm_timer, timeout);
 }
 
-void HELPER(hppa_halt)(CPUHPPAState *env)
+void HELPER(halt)(CPUHPPAState *env)
 {
     qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
-    HELPER(hppa_excp)(env, EXCP_HLT);
+    HELPER(excp)(env, EXCP_HLT);
 }
 
-void HELPER(hppa_reset)(CPUHPPAState *env)
+void HELPER(reset)(CPUHPPAState *env)
 {
     qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
-    HELPER(hppa_excp)(env, EXCP_HLT);
+    HELPER(excp)(env, EXCP_HLT);
 }
 
 target_ulong HELPER(swap_system_mask)(CPUHPPAState *env, target_ulong nsm)
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index befdb58e9a6..41300c0dd73 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -726,7 +726,7 @@ static void install_link(DisasContext *ctx, unsigned link, bool with_sr0)
 
 static void gen_excp_1(int exception)
 {
-    gen_helper_hppa_excp(tcg_env, tcg_constant_i32(exception));
+    gen_helper_excp(tcg_env, tcg_constant_i32(exception));
 }
 
 static void gen_excp(DisasContext *ctx, int exception)
@@ -2450,7 +2450,7 @@ static bool trans_halt(DisasContext *ctx, arg_halt *a)
 #ifndef CONFIG_USER_ONLY
     set_psw_xb(ctx, 0);
     nullify_over(ctx);
-    gen_helper_hppa_halt(tcg_env);
+    gen_helper_halt(tcg_env);
     ctx->base.is_jmp = DISAS_NORETURN;
     return nullify_end(ctx);
 #endif
@@ -2462,7 +2462,7 @@ static bool trans_reset(DisasContext *ctx, arg_reset *a)
 #ifndef CONFIG_USER_ONLY
     set_psw_xb(ctx, 0);
     nullify_over(ctx);
-    gen_helper_hppa_reset(tcg_env);
+    gen_helper_reset(tcg_env);
     ctx->base.is_jmp = DISAS_NORETURN;
     return nullify_end(ctx);
 #endif
-- 
2.43.0


