Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F4CECC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 19:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHRBW-0008QD-Fc; Thu, 15 Oct 2026 15:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHRBT-0008OA-Ox
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:32:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHRBI-0000YK-Df
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:32:06 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FI3fLq3902221
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:31:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /s0H/a3tR6wkC0lBUHW00yGxI9xOVUyfOwGzdbm3XdY=; b=GNsmw815OO5pq7Ur
 AgDQmge5GgDKhQOV5Q5VZ+eM/iwKlhEtsTCLdFuYda6xFD5OXpiw+PR1g3XdEOcX
 swElGJ29SfdPFXNZucrN+Raj10wPDg7fNY9p9N45/KiO4A5Hir1Wxv1oUuMsogRW
 WGULumiiZtl2iCWTmzq+LA2H2dYciOhmfKlN33jEwbpdUF4XsR+Lidc7u4Kyx9+P
 jecSbsyWImoUIBDVsJ/wii0tncGEkob5M0y1+UHQrKEZOg7q9pj58zY+wqGXY/9v
 T2MfkDudVGzKb3eLYRmoOldtmxxPcmHcJ1gruM3fPBzUPtoBcEvY+OH1uNdCGP4W
 QFcYpw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb3ser9qp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:31:55 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35a04491c56so265716eec.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 12:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792092714; x=1792697514; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/s0H/a3tR6wkC0lBUHW00yGxI9xOVUyfOwGzdbm3XdY=;
 b=kf0vwEx2EcWSNSANzR8ClwsnBRAO8YOls/Gypmj5uCkJnAyCjOT+lvNGz1XgoSMLHY
 A+jDt2qgabL3Y5E95UC3luJGph7mP/6RpRoJImdZigaMihUTICk5UnFy+t3FvDljlRGr
 u0NYbY9W6jMeuPwZCQ1ATjOlM7XVb5D4nTcQNwH8M5NVXQDAJz9NnDxG8oIA6HArmdsw
 W0nxYidS7K8IFJ5BzjMXCwdloulsqq2b3DfFK8YYkeFo9OsnW86lK8Mt2ZB77D8otvFz
 E9Zp0fxHh5TF05s7mWuNAZISH+vQuFOpJEyMy9lFUg4bIXuJhFe0Ugj+Z+QXA5P1Rgdi
 2HQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792092714; x=1792697514;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/s0H/a3tR6wkC0lBUHW00yGxI9xOVUyfOwGzdbm3XdY=;
 b=xmD8LhtkklhVVXddPUG07OgKTg3IvlqLkuSWP3X4aDsZ9GJNWSh6NDh90SRkQ/pkO3
 Fa2GZSemzQFRFPeLNP3+evHcU5lvZ84MBHNR7sRHwnJG4bE9UgXnk0nQarEbuexVZP/c
 NS7l10vmGCjKCQxyP5/yTOc0VWUs7M/c2LPzWUNmpFKZ5fRtWI0M/zleT6srBFKXM3TT
 ZpKLxM8WGE4F8LJ8f/OtTr+YONB6mjjFodcvsHATv6IH8IoUXiDkdQYomyatKzjY2vRW
 NB7F/x/4hLTYrU4+D/zyfK8GWzef9wtOWF/KeOSJvJyzKnfeY01por4YWhsVLA1aBO3t
 Pj2Q==
X-Gm-Message-State: AFq9FYLs6idEqf/Wq8gGFBLJWHFivEhShSCdWs6K0eckMrF73K2G/VD1
 OR1Tzd/4MEF4+nOzbyaDRdz8dXSkf5l2m9HgR4mpTmrJMzdFJJPE0A99ZLMiJq/qQUrWINiFNvQ
 nqZCCQqdQud3qLr7r5lIT2PfFR+7XzI3RihiIZTeJF4jhAqEhwNTHrkaizOgpt10T3A==
X-Gm-Gg: AYBFou1NaXR9k5VDPft9f8bNmXjYgQSKeXTu2z5O6YWAfB+EAzJCtLJF7y4xcaG5VhD
 nuhrfqGVnCCm0VA5YEmH8aRbMT9wcJO4708LNgaMrDzZGxA/4fnuGAjorIf04BbFM/WiBfJQ8Po
 0bBCEyCIOE6DOY7XKyhSBeIyIfwf9vydchB6df74xztK98Z7toM6G+arv3Po0LaipBFOBnLv8yH
 ZxmeTCKgRq9MzDAGVo15+gWp/lCtmJt81s8mWO640tHc9JAe8M4wr1A8ZhnCWdbJIJz2DcBDHkm
 5+DmVs3h6FCEHpEMJGLEtt/EANKvk+eKjCnuL0XHzflhh2YM8JvqRL+urZi1hcH8A1ClZlzYB28
 lf7XxjmOdDgZWoNxg9zBO7oSsnsxTpIi+5wKKo4jPGunkJ2f7ECK05o5Jicji
X-Received: by 2002:a05:693c:808d:b0:343:5f5f:eef0 with SMTP id
 5a478bee46e88-3602f1757f4mr957604eec.21.1792092714285; 
 Thu, 15 Oct 2026 12:31:54 -0700 (PDT)
X-Received: by 2002:a05:693c:808d:b0:343:5f5f:eef0 with SMTP id
 5a478bee46e88-3602f1757f4mr957497eec.21.1792092712546; 
 Thu, 15 Oct 2026 12:31:52 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3608308a87csm81355eec.28.2026.10.15.12.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 12:31:51 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 11/20] semihosting: remove common_* functions
Date: Thu, 15 Oct 2026 19:31:03 +0000
Message-ID: <20261015193112.145326-12-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -Uyl2oL61bMO64YmnGYCXK798JoeBuX_
X-Proofpoint-GUID: -Uyl2oL61bMO64YmnGYCXK798JoeBuX_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA3NyBTYWx0ZWRfX38sbpKZoZ8nG
 6YjbuSGt3PwyQtfHPAP59pjKIcata/26FXSuADy+80fuyKYc+WghnL3OgnuC0e4YnbMQbNsXpMb
 lpKFu9hui8nQgNrwPkkilb98Oew9ViU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA3NyBTYWx0ZWRfX5LVsoueHptnS
 2RUGsnn9Tf6hu18/NqiuTTfdrel0Q8OYKybc+JB2f5wyBHV5JHe1S/3LKrGvp+xzRXDPhXtQafn
 K0sZUA1OaPdH9tnz/XdOwPA0Glk6/KxutBhEbo2BIb4rHTfxKovRr+Z+hR8pulg93+Ou5RHi56Y
 omM9OLuzaUG6XXNQGc3GFS1OOt8RMvEOSnFvYnwvs1WJutKdiYLk29t8+GiAWtDpAVotuqdavfu
 aO1U+LMOXojjDPzGREeIV/ps5yyq46kExeQSSwBPzAmi+jwzKNxtoxBjCpopT2Q4jMHOW5ZDvvZ
 eoQ40r3AWUo4a0uF4qaNC9B3k03ABtj1pSU2DK8eePaV7BBuJDeI9vnzpX2m4JV/ckzzwUXo1Oo
 F9HIcwZYUPJs/CnU1zwIIA3BuO01t40K/OEaZi9qgpUOp8e6F+8GB0QEZ9Z+GpNokBQHxFeBZ52
 weOeIjcBSXuZIGDssxg==
X-Authority-Analysis: v=2.4 cv=Se1i5fRu c=1 sm=1 tr=0 ts=6ad12a2b cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=L1yarDn3pjfbl8iwGdQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150077
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

Now that both targets and semihosting implementation both use the
semihosting ops interface, we can remove all common_* functions.
This allows us to link together the three targets concerned: arm,
hexagon and riscv.

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20261014210526.104215-12-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/semihosting/common-semi.h   |  7 ------
 target/arm/common-semi-target.c     | 35 -----------------------------
 target/hexagon/common-semi-target.c | 35 -----------------------------
 target/riscv/common-semi-target.c   | 35 -----------------------------
 4 files changed, 112 deletions(-)

diff --git a/include/semihosting/common-semi.h b/include/semihosting/common-semi.h
index f0f8185d8e6..085192e0c86 100644
--- a/include/semihosting/common-semi.h
+++ b/include/semihosting/common-semi.h
@@ -53,12 +53,5 @@ typedef struct SemihostingCPUOps {
 
 void common_semi_cb(CPUState *cs, uint64_t ret, int err);
 void do_common_semihosting(CPUState *cs);
-uint64_t common_semi_arg(CPUState *cs, int argno);
-void common_semi_set_ret(CPUState *cs, uint64_t ret);
-void common_semi_set_err(CPUState *cs, int err);
-bool is_64bit_semihosting(CPUArchState *env);
-bool common_semi_sys_exit_is_extended(CPUState *cs);
-uint64_t common_semi_stack_bottom(CPUState *cs);
-bool common_semi_has_synccache(CPUArchState *env);
 
 #endif /* COMMON_SEMI_H */
diff --git a/target/arm/common-semi-target.c b/target/arm/common-semi-target.c
index dc5f277a59e..ab37730f3ef 100644
--- a/target/arm/common-semi-target.c
+++ b/target/arm/common-semi-target.c
@@ -71,38 +71,3 @@ const SemihostingCPUOps arm_semihosting_ops = {
     .stack_bottom = arm_semi_stack_bottom,
     .has_synccache = arm_semi_has_synccache,
 };
-
-uint64_t common_semi_arg(CPUState *cs, int argno)
-{
-    return arm_semi_arg(cs, argno);
-}
-
-void common_semi_set_ret(CPUState *cs, uint64_t ret)
-{
-    arm_semi_set_ret(cs, ret);
-}
-
-void common_semi_set_err(CPUState *cs, int err)
-{
-    arm_semi_set_err(cs, err);
-}
-
-bool is_64bit_semihosting(CPUArchState *env)
-{
-    return arm_semi_is_64bit(env_cpu(env));
-}
-
-bool common_semi_sys_exit_is_extended(CPUState *cs)
-{
-    return arm_semi_sys_exit_is_extended(cs);
-}
-
-uint64_t common_semi_stack_bottom(CPUState *cs)
-{
-    return arm_semi_stack_bottom(cs);
-}
-
-bool common_semi_has_synccache(CPUArchState *env)
-{
-    return arm_semi_has_synccache(env_cpu(env));
-}
diff --git a/target/hexagon/common-semi-target.c b/target/hexagon/common-semi-target.c
index da92ff298a2..a4c346eff2f 100644
--- a/target/hexagon/common-semi-target.c
+++ b/target/hexagon/common-semi-target.c
@@ -59,38 +59,3 @@ const SemihostingCPUOps hexagon_semihosting_ops = {
     .stack_bottom = hexagon_semi_stack_bottom,
     .has_synccache = hexagon_semi_has_synccache,
 };
-
-uint64_t common_semi_arg(CPUState *cs, int argno)
-{
-    return hexagon_semi_arg(cs, argno);
-}
-
-void common_semi_set_ret(CPUState *cs, uint64_t ret)
-{
-    hexagon_semi_set_ret(cs, ret);
-}
-
-void common_semi_set_err(CPUState *cs, int err)
-{
-    hexagon_semi_set_err(cs, err);
-}
-
-bool is_64bit_semihosting(CPUArchState *env)
-{
-    return hexagon_semi_is_64bit(env_cpu(env));
-}
-
-bool common_semi_sys_exit_is_extended(CPUState *cs)
-{
-    return hexagon_semi_sys_exit_is_extended(cs);
-}
-
-uint64_t common_semi_stack_bottom(CPUState *cs)
-{
-    return hexagon_semi_stack_bottom(cs);
-}
-
-bool common_semi_has_synccache(CPUArchState *env)
-{
-    return hexagon_semi_has_synccache(env_cpu(env));
-}
diff --git a/target/riscv/common-semi-target.c b/target/riscv/common-semi-target.c
index f0f9e29dc4c..44f29a82982 100644
--- a/target/riscv/common-semi-target.c
+++ b/target/riscv/common-semi-target.c
@@ -62,38 +62,3 @@ const SemihostingCPUOps riscv_semihosting_ops = {
     .stack_bottom = riscv_semi_stack_bottom,
     .has_synccache = riscv_semi_has_synccache,
 };
-
-uint64_t common_semi_arg(CPUState *cs, int argno)
-{
-    return riscv_semi_arg(cs, argno);
-}
-
-void common_semi_set_ret(CPUState *cs, uint64_t ret)
-{
-    riscv_semi_set_ret(cs, ret);
-}
-
-void common_semi_set_err(CPUState *cs, int err)
-{
-    riscv_semi_set_err(cs, err);
-}
-
-bool is_64bit_semihosting(CPUArchState *env)
-{
-    return riscv_semi_is_64bit(env_cpu(env));
-}
-
-bool common_semi_sys_exit_is_extended(CPUState *cs)
-{
-    return riscv_semi_sys_exit_is_extended(cs);
-}
-
-uint64_t common_semi_stack_bottom(CPUState *cs)
-{
-    return riscv_semi_stack_bottom(cs);
-}
-
-bool common_semi_has_synccache(CPUArchState *env)
-{
-    return riscv_semi_has_synccache(env_cpu(env));
-}
-- 
2.43.0


