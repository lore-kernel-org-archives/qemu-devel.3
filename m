Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0823DC3DA7A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 18:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH3g9-0003yn-I4; Wed, 14 Oct 2026 14:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH3g1-0003we-QX
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 14:26:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH3fz-00020u-SK
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 14:26:09 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbJ5A3642821
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 18:26:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=mNWnoA/NIHe
 q44KBvgvqp472AomHIDTpaHKq/Hd7irQ=; b=FBzZPfthCDfg1aQ4KbiQFXst7dl
 qojGms0hLZ7sHUZFj0Q6EwTP4rakA1c5sNs1N1Z3TVdRnJiTbt3TgfL9rns56f5l
 DtPipwJMF190/aENZoZ7KlF/WH89OmOkJ/WIIRgPtd93APTQX6BTI/SegUQ6cvTc
 LMjNonde25v0AaFc7Eh34O8dI2+1QpF3v7UQVcvosQYw5plsXnOVqDGoDsItHatR
 yq81BNFtMJ2WLOZCryey0+JVFApFogjf5l8zevHHLhOMFLqBmuhJJThag/VdIvbQ
 G/WlQQ3PKXARTR3yuWlAux2kRTT12YnUmXvVQ1rChAYcgQwhcXl6+ymznmQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha470ayad-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 18:26:06 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-14fed306427so3916756c88.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 11:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792002366; x=1792607166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mNWnoA/NIHeq44KBvgvqp472AomHIDTpaHKq/Hd7irQ=;
 b=R1cH1344m+pa4ufHNT8FlY4r5VfGXJhSWLSqbMBOkkWAxe7ss3taHicdZ3/WOQuXUH
 wf4HOOl8AKgUWNDEpt3Dd64eZUA1oDttCRXAHgOkhrJd2RDjtEoQYq7d9A/3tQuZXYWb
 LVNFmO55nvQXi//kOc0IfWg77Dd88q8XETbG3e0+y4Qf14HksQAhhlB4UzCwrDYh2mlX
 89hu8WUsBCZndvGjakM51qKxqvbPKKPr/GaU3Z+rzmhwSSLwaTHdFpKhAd7jLxFAAUg4
 iBuj4OBgR47EnzdOhmSStIKo27d8rmH5BSxx1ZhMUx+YNLLGNW1hGUTpu9qfgjUZc4sW
 9sUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792002366; x=1792607166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mNWnoA/NIHeq44KBvgvqp472AomHIDTpaHKq/Hd7irQ=;
 b=CwOLtbTtLmCAbFx5H08xaTKU+QzGo2lfMiMk/uuRXBjqIkHiSl7CyFRsoGQDPvT+mL
 8YARhY+F7YG1Q0O/mPNbi2LB0vudnzLuy0ky/EBHJJjoGqwNHD4r6GonjMZq6YtukqSF
 +iNCbs+7nbTWV37sLpiUsvP7Drfn8V4qTOJkD/f7eOAKr2qccVNuybh5djZGZBiDVQVY
 PgiTlUYfkIwToyttrqtLFyINtEiDHsxYOt+MUxvm03+yh6uWVreGxxYMohqTrhagfxCx
 Lx2JpDx2PgCKY5R8ffOIrW4hxfDpxLd75UfYbuOesLvYm24zSHRWkRAGrNPDJ21Bj6sv
 kHjQ==
X-Gm-Message-State: AFq9FYJTnETFLV8xCHSRSUwDkL8HTfjPMyWRq9eCnria9NuqmEgYiUJR
 /2LR+PLT24vg7GDkRfv82tgaOfStxWuh8vC6/vSXGtDjAs2u8huiOZUVo38Xe6Bq0tO9x6rpp+i
 rPOYS0QrXLKHd8kgyYfUEqmr8yzaFzGA5U/+IDjZeil556krFaM4cPcpSgqaCVKuCpA==
X-Gm-Gg: AYBFou1fysbImGf8poURPBehqMua05LryDpqoDZsoTGzAMNnNQnv4ykNoWZdVA9bEBb
 9M0/eDZKwc8osxq+9Z9en/XKdBA6sBPXDkq4bU3lYjKTdpQoGXfZyDQo/voX3sF/jU5FP66tkvq
 t4V8OJ77e4UdFryGN0X5pnsjDuym9pYv8puajUnDpCRFORb133tIM+dhwbSPEV2hjsjobWCrN4o
 g+tNy/+C2HuQVnXoG064ky68/dKy7VCfKMjtsrBPWIlt61DoCHJHRsXp/xaSCevY7pNcWL5pTGa
 +ZZdc2XJwr99QuqimFKwEYo7Xb0hgOoQK5Cx3NmaRIKrGV2gZHP7iC+WUgEJh7yEMP4kHOG+5tw
 80/5SQInhWzk13nVQNbMT+JhUabvYjJCj06VaVmVUKIcoOQ4aS8rR6TU8cScF
X-Received: by 2002:a05:7023:a4b:20b0:176:d885:4e94 with SMTP id
 a92af1059eb24-176d88550fdmr11453684c88.26.1792002365736; 
 Wed, 14 Oct 2026 11:26:05 -0700 (PDT)
X-Received: by 2002:a05:7023:a4b:20b0:176:d885:4e94 with SMTP id
 a92af1059eb24-176d88550fdmr11453656c88.26.1792002365216; 
 Wed, 14 Oct 2026 11:26:05 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a442956asm62348223c88.16.2026.10.14.11.26.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 11:26:04 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 10/11] semihosting: remove common_* functions
Date: Wed, 14 Oct 2026 18:25:42 +0000
Message-ID: <20261014182543.135965-11-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014182543.135965-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014182543.135965-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3MyBTYWx0ZWRfX0xp9eG4ChhEv
 xzaL1g7eCRJbcUUd2eF728h1JXxzsGikgGjuHSKHmbgv74YcKz/PR4Tu4daWN12NlSyWm+dsEWt
 CoAFLOGQZp+4io1KL/OkXIHZO/UwLriWhvVxaApq9aHOHDEXoKIHVh12P9fbyowMM0nvwE+jXum
 3CDbPhZbweKXvrxmBaZZgkRw+yGKtFfTW8vTbVZiQr77YhWvOAQ01EZPjgomBsaUeL7UVr8INjE
 3QHPqE2bI2Vw/BPmtsp1UmGXGJsynlpiiDk5nLIuvwGPlxc7ht2vICGFIf0RMoHOKgJ8d5cDbXS
 Ip2ThgbPOGUp/4Q4AiLTTCpFnOq2jMQDJdhsxhjBKivRRgtbct3YVGpKYbjz9YdmzTwYSBB5T/9
 13v/culmPfGV33SeBsOpRH844qMWxybXRdnRHL6YGDfT1h6NgEBQJ9ijV3Yb9A0nxqtjxHF2yJT
 C0OHjv4WfF5YRMDHQmg==
X-Proofpoint-GUID: og0Hi0KRn_BC03RnEbC-d0E5LJe-4JjL
X-Authority-Analysis: v=2.4 cv=P6avFSAu c=1 sm=1 tr=0 ts=6acfc93e cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=lHUEnDEh36thAgea6SoA:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: og0Hi0KRn_BC03RnEbC-d0E5LJe-4JjL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3MyBTYWx0ZWRfXwuxKaJAVhbQA
 kHaaX2tqDIh4GQZqbLqHAvMCaPC9J7XlFTn4heUxVsAOO5Uqom0BSYquPNaMmVx3DA4an/u4tP7
 4fJBmHjsyeoU1AkIbWdFnSCer/oRHx0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140073
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
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/semihosting/common-semi.h   |  7 ------
 target/arm/common-semi-target.c     | 35 -----------------------------
 target/hexagon/common-semi-target.c | 35 -----------------------------
 target/riscv/common-semi-target.c   | 35 -----------------------------
 4 files changed, 112 deletions(-)

diff --git a/include/semihosting/common-semi.h b/include/semihosting/common-semi.h
index 618f60f76e7..8875aec3c86 100644
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
index 5263c0435a8..aa5190ee16c 100644
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
index b97ed6796f8..0a33b872e3a 100644
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
index 7fa3bef6883..24c42254558 100644
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


