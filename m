Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A495CA5FAD
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 02:03:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBjdw-0007X9-CC; Tue, 29 Sep 2026 22:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBjdv-0007Wh-4t
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:01:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBjdt-00036R-FC
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:01:58 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68U1ARtj1264088
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:01:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=syoN4pRiFmK
 mwYYR45OVx/x9XDLt91cQs17WYsWJhOU=; b=eYoq611ypHE01AhErCxJ9w0y/IO
 BCchmaJJZCagjxHJGIbWB6gbAYUntjnBLDV4Xqdm0CrzOoXNCDvPPzXwlsC0m8b+
 8hfvmxEHh+/XlpP95E1G2CcWpvpXgAUf43UhzSnG0F0cM+GlrMjgiWUA4ozs3V6x
 mpIdCYjD2Z+DaiPhSbgMGnOe/wET3HRkoufNWCSRav8QFiIGIh07hZAUT+Afvq6n
 dZeOFuKMMMst+XCaypIylIEgefGNUAgyfMJoQ5lRsSVrp4S5/5s7hZjJReMaUhyK
 u/tX+ySweTeioSWZvU7uZhH6nVi59kKwp6am/Tuz5p1VbSIXd+QnSqt3WCA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0rheg54k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:01:56 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-147be78cd56so1532129c88.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 19:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790733715; x=1791338515; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=syoN4pRiFmKmwYYR45OVx/x9XDLt91cQs17WYsWJhOU=;
 b=Fa2aIjfQ4ttWyUeZMV0EzxCuIvNRAc9hYRMmM6uXkknJztailL99R2o0OxOcF7jwNF
 Wjxq2iN3AWXPKqgfqTcyAP9i1SrFQLZ61eW1GNoI7qc37k4ls6TK+xrjOJ/HfzEMGTK4
 xSq1y7ZVpqS+hz6X/KTzVjQ99j/rHMYvmCoBhXAWQ7LeaDfmMSOV7mVIhxScJjIl6o7E
 Hnm7V94dF++uo1Aienv4ZFjmYPMyi+GsQhWA/sCPRofggD+LNV/6ZoNImwkKPGAhCPGm
 tfjYMl00NyZHvh8ocEuaM7b5qRVRoL4m+eqXLMaTYK7Y7ixuMIMz9MXmGzbqOS4QTA65
 t+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790733715; x=1791338515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=syoN4pRiFmKmwYYR45OVx/x9XDLt91cQs17WYsWJhOU=;
 b=LcTDVc5UX9pHjQB1Bl7iUXTZ4iSNiQIWWagTpNCVQjPZ25MCrAhdogbjN/07ZmNm+r
 rsksvxZbFDe4YC6Pr6uZ8nu0wTnnK7kaswnQ/kjGynWHUULQfxcfFIekUddgM9rY1xmj
 c9imM8HbA5NpDrr2KnoD34yftBXxvWJuCQAGcDpvRbRzb0lQspkMYLgNVpE8gMO0ahhK
 fk7gDZXg0OByeancZgdT8WKRDCGhwKXL2W8Ow6cD80Hby2nNZPsLrEuPviJYMqXeb4Id
 AvGUpDpMybdpbzTXu6nIm68MpBobtTeiws+kR+a2SmPFYo2WVCj3qKPi4ISfds4tzc4+
 oZLQ==
X-Gm-Message-State: AFuF++lzp1btqVpo9OCDRlRVPSqGS5FBo8+qZ73+OqR6A0no/7YO1FdR
 vrO/LK6LSqitw1CjOZog/Ffq0efKX44zMserpHwto2Ip5beeyGqzDNiGwjmHpi3RLqafcgQcqTX
 WZsiLv7pELJBJRpBpKtHK9+7rjv/jFdQZ83AawbDFgdi5aP9f0RpmmEph1T46EfOx8Q==
X-Gm-Gg: AYBFou1N65/QjauTqv8f7vH3VBzYST0tgnEaHFDhtC/GV7XemJHyu8dxjTMs+kWVwG8
 bASUj35EJbtfjJ3NXziCdFK7un6ZPXaGg9vMYbWoHauMQ064fywgciudEeBgpUy24f+wZeEn1Ng
 J9tyRq0b8RK8cOgY8E2JLNociRPvazx9YxDXu7N27Cez7TrHo94rUs0kcZGZF5RsIUALbch8d5y
 M/EtU71DNszAoK6EoFdz9YoXdxd6U2g+rP2D5CKFSMpLzKtQg27n6R3UsrXMD9hcbcrdORQy1Rj
 iLltmTlbgW2LBww2UCgFDnHpos+p79XP/eCBEdLi3zLE36Lv9cO6ZZe78yl6J9117INgOjMd4eC
 T+/Ku2D5a/4CeL3D6eLo/9sbdbGmOJvBm66jo+sH5AAIl7VcJFD2x+1ukP14/
X-Received: by 2002:a05:701a:c909:b0:143:5266:48ee with SMTP id
 a92af1059eb24-14c9fbccb91mr1152025c88.42.1790733715407; 
 Tue, 29 Sep 2026 19:01:55 -0700 (PDT)
X-Received: by 2002:a05:701a:c909:b0:143:5266:48ee with SMTP id
 a92af1059eb24-14c9fbccb91mr1152005c88.42.1790733714679; 
 Tue, 29 Sep 2026 19:01:54 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388cc02esm3174803eec.21.2026.09.29.19.01.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 19:01:52 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 12/21] target/hppa: prefix helpers conflicting with other
 arch
Date: Wed, 30 Sep 2026 02:00:59 +0000
Message-ID: <20260930020108.217892-13-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: YjvMBb715s2V3hMAMIS2J4m1KdJLgSl_
X-Proofpoint-ORIG-GUID: YjvMBb715s2V3hMAMIS2J4m1KdJLgSl_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfX0ogL5+g8GYTJ
 BewNcUlteanq6uB4I4G/KDnk8yNgw8V/Fk18CYa9pcPuefth97qGYQyI9AWUIa2fSxUdSNf3zV7
 25iYzMvaqHZPgAPbMvdqYROUP8N7wilsP9sRuDHXjqCOMwArB25Z3p90htn60kx9fVyLl7J8xa7
 yLRQjveWHd2vjCn3H1QrA7c1PGuN8n1LYo3FF+EpbI+Q9YqYPquA6iYmJF2gkSP7wvaJ77MfHns
 WlNtQKrb6n/YS58IhVhlJIFBgyo51/tbHwTTSO7jCufHWUs57+KvbAH4piTNoS8izcwtYhd4GDS
 ICMJlF+erAOHhkIpT5hPu+emeSwx3pQ3nuMvkOJXsHU5goS2NOqLMWx3IYvZ+XzTXM0umEmiuAI
 Jk/chRBf4ryCQk/cWzDZd4h/afrNmBxE+Fpa/rN052pkvt9bOyBII1yrmpo0UXyMXhg/K8LP+al
 ggTtrAFRGB0zkDx0l5g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfX0TRc4OKvlqiP
 mepQRO6Vu+tS6dM97xtsDB5asYSSkd6z9gt128XeMuYeC8BGBBUiDZppkjvLphilY1V6Tzf676+
 0Dws9aN/mZ9wXQ83xhylqSxvCVSXi48=
X-Authority-Analysis: v=2.4 cv=Tu1zFzXh c=1 sm=1 tr=0 ts=6abc6d94 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=O6_tSJhFkAU4UwOEi8cA:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300007
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/hppa/helper.h     | 6 +++---
 target/hppa/op_helper.c  | 4 ++--
 target/hppa/sys_helper.c | 8 ++++----
 target/hppa/translate.c  | 6 +++---
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 8369855d78e..8d7fa1ae348 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -1,4 +1,4 @@
-DEF_HELPER_2(excp, noreturn, env, int)
+DEF_HELPER_2(hppa_excp, noreturn, env, int)
 
 DEF_HELPER_FLAGS_3(stby_b, TCG_CALL_NO_WG, void, env, tl, tl)
 DEF_HELPER_FLAGS_3(stby_b_parallel, TCG_CALL_NO_WG, void, env, tl, tl)
@@ -82,8 +82,8 @@ DEF_HELPER_FLAGS_4(fmpynfadd_d, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
 DEF_HELPER_FLAGS_0(read_interval_timer, TCG_CALL_NO_RWG, tl)
 
 #ifndef CONFIG_USER_ONLY
-DEF_HELPER_1(halt, noreturn, env)
-DEF_HELPER_1(reset, noreturn, env)
+DEF_HELPER_1(hppa_halt, noreturn, env)
+DEF_HELPER_1(hppa_reset, noreturn, env)
 DEF_HELPER_1(rfi, void, env)
 DEF_HELPER_1(rfi_r, void, env)
 DEF_HELPER_FLAGS_2(b_gate_priv, TCG_CALL_NO_WG, i64, env, i64)
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 76a8d8a0d34..3542c275663 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -30,7 +30,7 @@
 #include "user/page-protection.h"
 #endif
 
-G_NORETURN void HELPER(excp)(CPUHPPAState *env, int excp)
+G_NORETURN void HELPER(hppa_excp)(CPUHPPAState *env, int excp)
 {
     CPUState *cs = env_cpu(env);
 
@@ -341,7 +341,7 @@ target_ulong HELPER(probe)(CPUHPPAState *env, target_ulong addr,
         if (excp == EXCP_DTLB_MISS) {
             excp = EXCP_NA_DTLB_MISS;
         }
-        helper_excp(env, excp);
+        helper_hppa_excp(env, excp);
     }
     return (want & prot) != 0;
 #endif
diff --git a/target/hppa/sys_helper.c b/target/hppa/sys_helper.c
index 88109f0181a..f7fd80b5830 100644
--- a/target/hppa/sys_helper.c
+++ b/target/hppa/sys_helper.c
@@ -48,16 +48,16 @@ void HELPER(write_interval_timer)(CPUHPPAState *env, target_ulong val)
     timer_mod(cpu->alarm_timer, timeout);
 }
 
-void HELPER(halt)(CPUHPPAState *env)
+void HELPER(hppa_halt)(CPUHPPAState *env)
 {
     qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
-    helper_excp(env, EXCP_HLT);
+    helper_hppa_excp(env, EXCP_HLT);
 }
 
-void HELPER(reset)(CPUHPPAState *env)
+void HELPER(hppa_reset)(CPUHPPAState *env)
 {
     qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
-    helper_excp(env, EXCP_HLT);
+    helper_hppa_excp(env, EXCP_HLT);
 }
 
 target_ulong HELPER(swap_system_mask)(CPUHPPAState *env, target_ulong nsm)
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 41300c0dd73..befdb58e9a6 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -726,7 +726,7 @@ static void install_link(DisasContext *ctx, unsigned link, bool with_sr0)
 
 static void gen_excp_1(int exception)
 {
-    gen_helper_excp(tcg_env, tcg_constant_i32(exception));
+    gen_helper_hppa_excp(tcg_env, tcg_constant_i32(exception));
 }
 
 static void gen_excp(DisasContext *ctx, int exception)
@@ -2450,7 +2450,7 @@ static bool trans_halt(DisasContext *ctx, arg_halt *a)
 #ifndef CONFIG_USER_ONLY
     set_psw_xb(ctx, 0);
     nullify_over(ctx);
-    gen_helper_halt(tcg_env);
+    gen_helper_hppa_halt(tcg_env);
     ctx->base.is_jmp = DISAS_NORETURN;
     return nullify_end(ctx);
 #endif
@@ -2462,7 +2462,7 @@ static bool trans_reset(DisasContext *ctx, arg_reset *a)
 #ifndef CONFIG_USER_ONLY
     set_psw_xb(ctx, 0);
     nullify_over(ctx);
-    gen_helper_reset(tcg_env);
+    gen_helper_hppa_reset(tcg_env);
     ctx->base.is_jmp = DISAS_NORETURN;
     return nullify_end(ctx);
 #endif
-- 
2.43.0


