Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25BD6CA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 18:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDnqX-0007a1-4N; Mon, 05 Oct 2026 14:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqJ-0007PM-Ov
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqH-0005iI-Kw
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:19 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HLk7l3044082
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 18:55:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LN+R6qmkI4PitlWRiMuSW+1+WCz+gKEqP4cGAp93U3o=; b=bqpozPWMmzeA+s9z
 gtRqqsc8Nr0fhvS3kqT5z89aiDr63yY5G2HZEHXOeylDxLkPtt9DzblYFP6dwaE1
 mmGM+s2URsHBMtRxBwfe65numn+Z+CKRhe3JyUFDma8F3ykx7NcYORSbIsaso23C
 faMCESWQy4h6fag3lalJ9/5c/D/G7oFQyz0NCVP/O+HM+OWaT5ZFKvmPPK94xRkk
 CuZis98LYhrAbSyWoLqmb20fqCWFR+wchEWjF+iO//cAAwowmnEnBxkhzhF/jVWL
 I1jFQSIKqjujrcHVVupXOQ687KCNP9g1DEqIbeBPRYIHdI2SPZ2PyYehAEZBlyAX
 ks/CgQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h49tvsxb6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 18:55:16 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1438fef603cso4712873c88.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 11:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791226515; x=1791831315; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LN+R6qmkI4PitlWRiMuSW+1+WCz+gKEqP4cGAp93U3o=;
 b=hokjX3LEsB6mzr5OxSm8An3WzZ7NMf9jhUzUsUIkNE8rTWfyAaBTWuxuTvdDpc5IyH
 YJcR5M9URqypGU9WJvHVncWMrFQ3/N6139p8LV27EIw8giaHZuxqvhqBV3BV+FYloSUk
 tAuiM2dl6wrTH5UH7YYtxtgAmoXbEN/8P0sgEju0hxPkqjJwMLezjODeUefXKmVbHRfy
 qSMpF1DKrETS5Eein1j5LcUvDbO8Ha1lT2lS8XLqFcm28trEyi1V0dp/aWgQ8a7vaNi6
 RN8nYQ/qidEYvDo5D/KAm2WHQ3Mqws0bz7JRLsQYxM/hpKcbFdF1xrL0jFE6Iw5c7236
 qQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791226515; x=1791831315;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LN+R6qmkI4PitlWRiMuSW+1+WCz+gKEqP4cGAp93U3o=;
 b=09IWSSNkCRTZfLhwTcXabp/0Lvm4MVl7ZRNcHqQpdaoG5vFMDRq+9tmiPtvbuwyDZl
 UJvcqsbhdMwWqszKSZugTeSuw4EMw/DwaiCKqh+WaFijyK0jeDbcpHmCxzvERgU2n0hn
 a0QWwcgD/dF89RwMk8a2ZSEWru4tg4bjIdte1T4WDZ3fvtHs8m5WhfGH9iIc2nnElZwF
 eSwYNBD87oj7qEI4j4LswpJFfbpsypcnWSzYCmDjg5ZSpWj/xM6gAOoX4qMu9S0DQ6et
 ez1MMsylAAP9KAYyLjt41zm+Io1kbKvSHpPuijKTrV3UngZVGIeQnNbJjh+cgn3Mfz26
 PWyQ==
X-Gm-Message-State: AFuF++muz4pkziZSowxtLqr37BqWcN+MjBHdAQLHuimoVN7KzqhHuq0u
 DRNghEBHX6K3Ihxn5gB9p0YPfVhrH36Z7NRqwX4NizKnwurdJHqnbCr8e6e/HuMELKXXRlbpgIe
 bOxMqeKJbvfhQUEyE+qrLSviBJ4uRTEmS9Zj80ImcqTWB9zlaC9SxplNlZMvSAxJtyg==
X-Gm-Gg: AYBFou1/X6EKooDEP7JpoZHBvxHdz7OwCpzDAkhXdIRVvBOcmiss+7D9Fc8bhOug59Z
 07RkHDP0vCx5KE/esfQPIS9A1KEzxSz4sGYW5AHxbLsowDsMdSwZLdz8Nl7IypGknHQV5R6z9ng
 Ti7eqJVQXzNW5RJMaz3ItYuNViHW6tIOfEYMk0R4YsDndgye1CbHlh5HSkHLiLJiipewr7qybi2
 rQ70THtKHdEpLNFq0JwGsU4a/PqU0MIeC6oSQIA8aDmjGXmMBhLtvKcQBtD4Mtu3UPwBo4BnNzh
 OZYpjLvaLVpxCcdWPectF/6pMu2NtvYqAUSJA5ytdn+SLyggxefFC8+9OyyZg0gd4ZpDLr5mHkZ
 OBH7DwzMGqRgxXkBY+4wtxLVsv8yRz9lohpRK08SZEMWQYgeshPk51AnLBEMb
X-Received: by 2002:a05:7022:220e:b0:149:50cb:216f with SMTP id
 a92af1059eb24-14f5cdca28amr21105071c88.33.1791226515418; 
 Mon, 05 Oct 2026 11:55:15 -0700 (PDT)
X-Received: by 2002:a05:7022:220e:b0:149:50cb:216f with SMTP id
 a92af1059eb24-14f5cdca28amr21105034c88.33.1791226514870; 
 Mon, 05 Oct 2026 11:55:14 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-15d7234c2a2sm602092c88.0.2026.10.05.11.55.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 11:55:14 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 04/22] target/microblaze: prefix helper conflicting with other
 arch
Date: Mon,  5 Oct 2026 11:54:40 -0700
Message-ID: <20261005185458.405929-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aN9lOr9m c=1 sm=1 tr=0 ts=6ac3f294 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=WCYGlPGn4HfFrzm5WJIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: OsCZdIlF2uNYF5qu46gyN90dTAIyen-1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfX326OpCH95TQJ
 qH5ofTfwyIp3UDqNFf79pCab4keHHcPWWXg/vaj403QlpE90EOqTX1sHfSOkPH7PyQJg0EYNjJh
 2WPV9LYEVylJjglKc3zYx7abZUCyxpE1LvMlTFwk3WhxVWI5mb/kz0wx2I7JsRNMa3PgKIJeF5R
 ctIziGC0aaleuAflttdRPexFyac/9xEMe/oGRmUFWsOVpn7vXRc4/ebKSS8T6+rFSXDcBWSbEtC
 24XCCM/7Sk66J8uAlPapwkWXYRz+yQbZXBqXNqhRHZplHHVbgdLpkDAdRd+gZYIwue44G/ES+5w
 erOo/UWwnPa8PH/ejbCXqkH9qSrEoIIJYAGfMZWhlCaWnL6gOrSCPn4Y71nsFJ9XFzM15rEDjHc
 aeccW2J3f09UHRsTbIZae66C2IFwXF0b5DbHkFsxDZt46YJ7JoLFvGS4LxcuTMh/vBpFOrvt+VY
 orTfK0IUK5UQYWlqVDA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfX/6u7208JIfoL
 fcwLfFah2+MdMXZSmFTPUSf5wvFbBblJyarrf1iDKw4NLVi+V4E240cAnEmxTdk/nCYp4qdzWF3
 N7fl+0lOzSg8yX8s0skeJDy2Ha6an5U=
X-Proofpoint-ORIG-GUID: OsCZdIlF2uNYF5qu46gyN90dTAIyen-1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050074
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260930020108.217892-5-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/microblaze/helper.h    | 10 +++++-----
 target/microblaze/op_helper.c | 10 +++++-----
 target/microblaze/translate.c | 10 +++++-----
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
index 1429c1727ef..63a94ac4bbc 100644
--- a/target/microblaze/helper.h
+++ b/target/microblaze/helper.h
@@ -1,15 +1,15 @@
-DEF_HELPER_FLAGS_2(raise_exception, TCG_CALL_NO_WG, noreturn, env, i32)
+DEF_HELPER_FLAGS_2(microblaze_raise_exception, TCG_CALL_NO_WG, noreturn, env, i32)
 
 DEF_HELPER_FLAGS_3(divs, TCG_CALL_NO_WG, i32, env, i32, i32)
 DEF_HELPER_FLAGS_3(divu, TCG_CALL_NO_WG, i32, env, i32, i32)
 
-DEF_HELPER_FLAGS_3(fadd, TCG_CALL_NO_WG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(microblaze_fadd, TCG_CALL_NO_WG, i32, env, i32, i32)
 DEF_HELPER_FLAGS_3(frsub, TCG_CALL_NO_WG, i32, env, i32, i32)
-DEF_HELPER_FLAGS_3(fmul, TCG_CALL_NO_WG, i32, env, i32, i32)
-DEF_HELPER_FLAGS_3(fdiv, TCG_CALL_NO_WG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(microblaze_fmul, TCG_CALL_NO_WG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(microblaze_fdiv, TCG_CALL_NO_WG, i32, env, i32, i32)
 DEF_HELPER_FLAGS_2(flt, TCG_CALL_NO_WG, i32, env, i32)
 DEF_HELPER_FLAGS_2(fint, TCG_CALL_NO_WG, i32, env, i32)
-DEF_HELPER_FLAGS_2(fsqrt, TCG_CALL_NO_WG, i32, env, i32)
+DEF_HELPER_FLAGS_2(microblaze_fsqrt, TCG_CALL_NO_WG, i32, env, i32)
 
 DEF_HELPER_FLAGS_3(fcmp_un, TCG_CALL_NO_WG, i32, env, i32, i32)
 DEF_HELPER_FLAGS_3(fcmp_lt, TCG_CALL_NO_WG, i32, env, i32, i32)
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 3da0c68da39..c169312e954 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -62,7 +62,7 @@ uint32_t helper_get(uint32_t id, uint32_t ctrl)
     return 0xdead0000 | id;
 }
 
-void helper_raise_exception(CPUMBState *env, uint32_t index)
+void helper_microblaze_raise_exception(CPUMBState *env, uint32_t index)
 {
     CPUState *cs = env_cpu(env);
 
@@ -154,7 +154,7 @@ static void update_fpu_flags(CPUMBState *env, int flags, uintptr_t ra)
     }
 }
 
-uint32_t helper_fadd(CPUMBState *env, uint32_t a, uint32_t b)
+uint32_t helper_microblaze_fadd(CPUMBState *env, uint32_t a, uint32_t b)
 {
     CPU_FloatU fd, fa, fb;
     int flags;
@@ -183,7 +183,7 @@ uint32_t helper_frsub(CPUMBState *env, uint32_t a, uint32_t b)
     return fd.l;
 }
 
-uint32_t helper_fmul(CPUMBState *env, uint32_t a, uint32_t b)
+uint32_t helper_microblaze_fmul(CPUMBState *env, uint32_t a, uint32_t b)
 {
     CPU_FloatU fd, fa, fb;
     int flags;
@@ -198,7 +198,7 @@ uint32_t helper_fmul(CPUMBState *env, uint32_t a, uint32_t b)
     return fd.l;
 }
 
-uint32_t helper_fdiv(CPUMBState *env, uint32_t a, uint32_t b)
+uint32_t helper_microblaze_fdiv(CPUMBState *env, uint32_t a, uint32_t b)
 {
     CPU_FloatU fd, fa, fb;
     int flags;
@@ -352,7 +352,7 @@ uint32_t helper_fint(CPUMBState *env, uint32_t a)
     return r;
 }
 
-uint32_t helper_fsqrt(CPUMBState *env, uint32_t a)
+uint32_t helper_microblaze_fsqrt(CPUMBState *env, uint32_t a)
 {
     CPU_FloatU fd, fa;
     int flags;
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 8b219afb5dd..16794059a22 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -100,7 +100,7 @@ static void t_sync_flags(DisasContext *dc)
 
 static void gen_raise_exception(DisasContext *dc, uint32_t index)
 {
-    gen_helper_raise_exception(tcg_env, tcg_constant_i32(index));
+    gen_helper_microblaze_raise_exception(tcg_env, tcg_constant_i32(index));
     dc->base.is_jmp = DISAS_NORETURN;
 }
 
@@ -421,10 +421,10 @@ static void gen_cmpu(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
 DO_TYPEA(cmp, false, gen_cmp)
 DO_TYPEA(cmpu, false, gen_cmpu)
 
-ENV_WRAPPER3(gen_fadd, gen_helper_fadd)
+ENV_WRAPPER3(gen_fadd, gen_helper_microblaze_fadd)
 ENV_WRAPPER3(gen_frsub, gen_helper_frsub)
-ENV_WRAPPER3(gen_fmul, gen_helper_fmul)
-ENV_WRAPPER3(gen_fdiv, gen_helper_fdiv)
+ENV_WRAPPER3(gen_fmul, gen_helper_microblaze_fmul)
+ENV_WRAPPER3(gen_fdiv, gen_helper_microblaze_fdiv)
 ENV_WRAPPER3(gen_fcmp_un, gen_helper_fcmp_un)
 ENV_WRAPPER3(gen_fcmp_lt, gen_helper_fcmp_lt)
 ENV_WRAPPER3(gen_fcmp_eq, gen_helper_fcmp_eq)
@@ -447,7 +447,7 @@ DO_TYPEA_CFG(fcmp_ge, use_fpu, true, gen_fcmp_ge)
 
 ENV_WRAPPER2(gen_flt, gen_helper_flt)
 ENV_WRAPPER2(gen_fint, gen_helper_fint)
-ENV_WRAPPER2(gen_fsqrt, gen_helper_fsqrt)
+ENV_WRAPPER2(gen_fsqrt, gen_helper_microblaze_fsqrt)
 
 DO_TYPEA0_CFG(flt, use_fpu >= 2, true, gen_flt)
 DO_TYPEA0_CFG(fint, use_fpu >= 2, true, gen_fint)
-- 
2.47.3


