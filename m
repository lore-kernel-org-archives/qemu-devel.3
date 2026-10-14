Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80609CC6B2D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 21:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH6Am-0001QL-1h; Wed, 14 Oct 2026 17:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH6Ak-0001Ps-1V
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:06:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH6Ai-0000j0-Cl
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:06:01 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbJ9o152440
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 21:05:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Nv3XfEFJcttYC4utp7vlvi3J7AQy6n8AuIwqY6aE8XQ=; b=JsQp7yBVoY0laRLw
 qRDHEUSq2VHAKXkCWRrpta1L06BWLGeWAztaeYMH4jp14kI3pNEfMI519r7DvqP6
 7t+okFwR+Ke/GIDJA9OBgya+XN2FZrY0slyeTAz3GjrPwSSrgR1Riw5Q9tlXoZTd
 3GuJlv/t8s1mluoFDD2wSM6hi5Qwq4fvMC8hQjhn09D5pEzRSddhR87WDOD0h/Bd
 0IoXuWH0PJxQ8TxSCGMAjUk2f6NI72ZHcIF9PVyVrDSTTX2kXfqElJzj9AGjwP44
 IzFSRM4jfmI1f+eiyS9wYIIlY4/JG65iaw432K1oBt5DLZ747pYty2Kn55FuUBM4
 3I84Tg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha7aejnag-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 21:05:59 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3510d0baf63so4454809eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 14:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792011958; x=1792616758; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Nv3XfEFJcttYC4utp7vlvi3J7AQy6n8AuIwqY6aE8XQ=;
 b=aeYlIyju8+ErOckyDyWZ0B2F5v5kXeM6mDs+drn2zaqzkaxrQoAFGOXLpPOsdu8ipA
 ST7hAzmjh5VYH7Qzsalgnm8Md6ov0nPSiaxUqS4xjOvJETI/2u1FRnOT1zBneTHvkkjl
 a1JFslXqOY/G/9SrCL00+HAaqF0NCEYfj2K9fOcoWWExjphCbYnUk1Lwub6sWSvqnyHt
 MAcfYoMvFzx7yG2g20Ovxi5o8zeEt/xXaB3WogKSvwTWa5spixGasLQGNLTFR1O2aavK
 7as9iAZGNtiM6Fam6AMZfI5Xber3TTw/i7pKLfGcF+7PvtVnfXJB8AdOzMkypf0/zNVH
 CTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792011958; x=1792616758;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Nv3XfEFJcttYC4utp7vlvi3J7AQy6n8AuIwqY6aE8XQ=;
 b=wF0OXUSKR5B/Wq09c1pXY3rbE8bYrTvLzhtZPVcZgoQUx5ODm+rFosHcIMwL8cpXl2
 J5eCZKcc33llcOIZF8a1l4NC0175lXfJxaaC793psTpq2+L9X2OIlHw/JMm3CuJaU2ih
 3z7vyHX2ldwuRXIVgFDf6ZdezLUNg6vBva6JNv/XVXDe6GbrJ+MTpkaopbOmtsLl0Czf
 Xg6bn7TAN0W5y/mAFYjJ3l+Sbm464NvHFfHf5pcC2K8WXi1AorLfmXQkz7EyIUK3IPoz
 IE9dJNtgclicuiUy6JO87E+HWXkIa+aQmOl7PJKW0B6VnaD5+J4a+AV0UgEk0UQ8hr2x
 /dew==
X-Gm-Message-State: AFq9FYLCQ5EnTrPeSAO1/Sl9Ad+xZWYe5VJfZ10OrOJ9R0l4n5IfEcz2
 eUQPaT3yCB6FobjDt8nq3JoYAnCfteJ25vhVN2XVeRy9uXoGH/wU0fbj6UjwDLD0JMsjSofbd5+
 QhLv7ettRdwXf4FoNwoCBvGFMIXpeeK9BS5+aXS9qM71n7eXTQx4eWmULCjIPwBPdtQ==
X-Gm-Gg: AYBFou2vxU5CzIRxjEHkb1A8DMdofvAdKyQ1c9Jy8q0aeB0qry9Ngh4KQUHVc9f0xNB
 TfKhe/H66B3HJJt80muCdOXyTW5PqGkKrMn4HejEQ5LquEVPMubyyFmE86ZnalUenJuMOu9zi73
 Sb4Lxx2gBBTaaWnlZAIlpBHkDohxQXnXyuZvHgsl/JFsiAEzcPpyoi5H2QHizGrtbs4grahpC7T
 P4oDuk9kqim7q8fzrx5i1AqluPHxPtPHXyEixWc1GubEs4XKqQPTx59Z1d5hVrMhH2cy01drdf5
 5ryG8ZIAMRsseCxHT3gHSzSwucf0AyNNccxp4J8NlG9f7etZJJXRHaf10d5PrNRQJevwS10uIyK
 QapnaHVdbiPJIxLSIuYVzRrzwi535uvC/0qw1QHp2RY9IWt7Lz9Q7u2D7juOR
X-Received: by 2002:a05:693c:2289:b0:34b:5ab2:e200 with SMTP id
 5a478bee46e88-3537e0788bemr31488422eec.14.1792011958103; 
 Wed, 14 Oct 2026 14:05:58 -0700 (PDT)
X-Received: by 2002:a05:693c:2289:b0:34b:5ab2:e200 with SMTP id
 5a478bee46e88-3537e0788bemr31488382eec.14.1792011957402; 
 Wed, 14 Oct 2026 14:05:57 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-358ee8a3387sm46562092eec.15.2026.10.14.14.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 14:05:56 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 11/12] semihosting: remove common_* functions
Date: Wed, 14 Oct 2026 21:05:25 +0000
Message-ID: <20261014210526.104215-12-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: r7KJwOMUajX0bIOQ9KGV6b9VRlXKHo_Q
X-Proofpoint-GUID: r7KJwOMUajX0bIOQ9KGV6b9VRlXKHo_Q
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA4NCBTYWx0ZWRfXzFJe6oUanGCM
 A5uSzA0NgDG9mRAvENe0Vqa2FOMjWUcbtbkXckrQ1dlhb1Kho+T5FSdN9OBHOIuj6j/vjHCFBp3
 CHZ/X0/rywL61+k31K0phGFZ9d/lr0c=
X-Authority-Analysis: v=2.4 cv=NctzRGD4 c=1 sm=1 tr=0 ts=6acfeeb7 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=yJoL9fLtwINObxsTzCAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA4NCBTYWx0ZWRfXyfj6sGm6h+ZA
 17ESNhptluxeGan4ykux2VEjCOTdrBNea3gjz0rXvHUwPiIxShK1+0WwcWrJF+sGAHSGUmIKNdU
 63ndMRY7zpWH07Mx1hXnLaDZ6zw7Q6yWbtDUKkaH3uyAcWxI/mJfV8jr3iHsEzgIR28jy0beN+x
 yJ9OTOvvqz5SHlZ1znrJIXcujUISYbwM4O2VxS0Ut7gGt/PnTlEkRr/3YmGRMK6PsGD2lokBJ8L
 dEybHtC/WD43WGfrrbGeA4HsDNTodron8ObgVfSoGBoiZmExHZHyYiiR2O0n/QtegMEEvn67Xxf
 oR1kF8yKFq9UsiHdyFhXZt13yHHkBnCNrwcsexigFkYF4z0HwLgs3k3IhcRZUDvor4mfcOCiR1u
 2YcWFW2xKovNA1vRlHStl85knZL5lfqtuvjrIAx3jnBc7HR1jXuC06V5mqJj/xPyyVOSVeYSgUu
 gZK0E3gY22Whpe+jnkA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140084
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


