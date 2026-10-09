Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16C4CA9EC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 22:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFJSQ-0006Y6-A1; Fri, 09 Oct 2026 18:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFJSI-0006Wg-PX
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 18:52:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFJSH-0002dG-45
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 18:52:46 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699KhXpC2545302
 for <qemu-devel@nongnu.org>; Fri, 9 Oct 2026 22:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=GI/fMA8PweZ
 lBNgdNXWSotyuOyVOiYOPM9en1Alc/IA=; b=JCtXgBOJzblhfMLqJXIvq16mEJW
 9aJE69e3eOnxdHM60InmTXiR3Sw81yNZPSDaPZIbM8UOGID+1X3aLf6v1OmbsgUQ
 lK5OIuClHQCs/rA/5tW1J94sGoNo9Qnk2v6nj/7HVitRJbeML8Ku42Nskcjfr5uW
 tpbSinb/ElRJWN+bHGLp5+RqYnKa/krx8ODm+5JnWwhodVTlw6QeXnhUgnhsujiJ
 fLLHkbQ8eLrkVn9+y4BaNKiXVr6LstHuSL/8zR7vTSelybd9yIK488YbOhRgyW4z
 HzfwwOyx+NeYPNg5Fe23NtYhV4gulPrUoAvZhQcV32PlDgBTKqAucLtFLYg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t7rywy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 22:52:43 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-341eff9e381so422177eec.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 15:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791586363; x=1792191163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GI/fMA8PweZlBNgdNXWSotyuOyVOiYOPM9en1Alc/IA=;
 b=dUEIPl33Mq7YjdtRXQUZ6Cfc5bhjeR10ZiVz33xuMBippjEJ2z28/rCkogPva/PTRo
 9aD4MT5lP5Mee8cOEF6o8O+6zcbGDAe3/Q87nKrmB7+cMuYtsIDGoMEpRL4HMJLTVWKD
 OwMNPSkCsio8g0FU4dt+gHvW6xSy9ti51kVoZwRLBswM7Er0FUt8bZ+71poPlYsyxXAq
 vqlqn4Yn6gwn66R4suuETeVbHzMOp+6BVsfCKvsK7GU7Sq34cxHeGnp9I3QshyzkLo4o
 98UTCHYjA0+8bfavfLxyBawngkNku8kOxmpHz5AdfUcKoVO496NfF/TFGTljs5MJkbGa
 VV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791586363; x=1792191163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GI/fMA8PweZlBNgdNXWSotyuOyVOiYOPM9en1Alc/IA=;
 b=Wub2Za3chOGYcY63TnEWX1FX14CtZMMKCC9DROoOAsl7MxYaBq3g/bk/TGfK2T27RO
 P7I7DEBplMIqzTxL5o0fyZs1sB9Ie8CtuRLw2+LXMZQbWBNvt1jOVjh0ErZk1Nb6Xho0
 d6iBDCofOwIv63VOnHUfS+56LPDlLMIS1PQrpYJvQeiVGylY1Ig1tFnjEzF24z9AyGjM
 hGNSyAqJHVnC8cb5KZQTr2rFKsZWpyJu62wUWvJfX1sHvIUTZEGPjH6FAie+no/uUYVG
 WxNm8Acp0vEZ+IBbDTKsRXWNLKhb9OamcvUEgybl7b9/HyuKy9HZkhh6o7W2a2QDRlJm
 C1Lw==
X-Gm-Message-State: AFq9FYIxZhh9RcUdADgC4RQHY5evb270YHqfGZEOLONpWQkmC4DL/NqI
 q6q6E2a/gkzMOazrGp+ELKEWTzuXLtnVHFmiFtKYYx9PAIYrl+cSE7W2nbk1yVjPhfDo++dZr3z
 qeF5p6tM3zdEahw4RQTNofKlk4GAETAodit2QPZV7O8kPHZ8AMo80K8gctNduVhJqnA==
X-Gm-Gg: AYBFou1sYUCgDE9qwxFjewwJtDW5yFLDgSwualYZpkB31Jw8agO23tnNHNf5hmVtSk7
 lvGagP7d775hxcGtvYE4atGXq2damhYQmopG2VX8YUt1f752O56UvThmvDCYTx88470PoUJNd1j
 p9k913xZYpVx7cSVI5uJYNPzvPILltmJf3a0+TolSBMkLqM45EhAADptDxUSgFG0rMzBANpTSNR
 3pSEbsfaGlQHmlr7fXjQeE6B80fmH79AbFrHPsd33QFNrhlV6C3RN3+djQFFiN4rXXmt6aeGc12
 lpNd3yTUtRcA/Uv8m0kAIk+oEoo1aEvFpzzWj/g+T/WRTdv5Sfvqa9C+swdl4nfvCZWOdaLEM/2
 0C8gldmBFQG6kGGq+8dUFyjlwGo8xsxgvdAGdK2M2ywY4rKPWpqAoezvv1Fzd
X-Received: by 2002:a05:7022:f503:b0:151:70a0:6bfd with SMTP id
 a92af1059eb24-16a5f01db1amr4261433c88.24.1791586362566; 
 Fri, 09 Oct 2026 15:52:42 -0700 (PDT)
X-Received: by 2002:a05:7022:f503:b0:151:70a0:6bfd with SMTP id
 a92af1059eb24-16a5f01db1amr4261403c88.24.1791586361949; 
 Fri, 09 Oct 2026 15:52:41 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a5866477sm8443977c88.22.2026.10.09.15.52.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 15:52:39 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 07/11] target/hexagon: declare semihosting ops
Date: Fri,  9 Oct 2026 22:52:22 +0000
Message-ID: <20261009225226.10657-8-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009225226.10657-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261009225226.10657-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA5MSBTYWx0ZWRfX3yYzqLHlqU9n
 ydsdO40ZKCk9OgbJLn1e/nQndPcGSiuCZYHfqBm3ST+h0VCKSJ9mBn+ZsuOiEQwgXTJS7ezJcnu
 TnAjfUV5ivWyq4DeJp0gH29c19YJK74YPAo4btLXHRv9JMuf1L/sFhi/AubQg3t4aqUWpvwSSRd
 UXkFZje9B533R1y89ikolYzz/DZrkOdk5fr5MfwfyNGkmtmXvef4FLkMvrETWZ8jJdSeWbWu9KW
 PMHoUaNh9O37OjujG/Xd1FURVlZr9VjnbtgCQu5TLNaNOmLf9SxOn6PR+Z4nw6Ubbt5mvWmn5sH
 psLB+mf4FYiEjQ+TtImDnfx6ay2bCocfE5rQKJD9lunNaWjPVGK3LbQOYeGsB3OFNeaJxcfAZgK
 Fmj0lSdN+MGKgKn42E8PUjFzP0bHWJC3sBHXyH/VStTCkXwQyIbb0peveE2jIpbegV8DnFE0Cpl
 /xdW/qEBeslr0WJ7W7Q==
X-Proofpoint-ORIG-GUID: 5Tjw2zaZjWvoBCJ9Oh00CT18837oj0si
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA5MSBTYWx0ZWRfX54eWtBSPmcu2
 LERmeiSCqUmw/dl1217ifnN1Qz/1I4yKSmZddppxBwUa8H/JGM6QB7NW1Mh3/tNic3ewCCBjIIy
 aMbBBmhSKiofr0YKJPczqHBk9owk+yU=
X-Authority-Analysis: v=2.4 cv=PaFqFShd c=1 sm=1 tr=0 ts=6ac9703b cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=RKMH5O5a7-KqqQVN41YA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: 5Tjw2zaZjWvoBCJ9Oh00CT18837oj0si
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 phishscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090091
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

For now, we keep the global common_* symbols defined.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/hexagon/common-semi-target.c | 63 ++++++++++++++++++++++++-----
 target/hexagon/cpu.c                |  2 +
 target/hexagon/internal.h           |  2 +
 3 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/target/hexagon/common-semi-target.c b/target/hexagon/common-semi-target.c
index 210d33e54e2..b97ed6796f8 100644
--- a/target/hexagon/common-semi-target.c
+++ b/target/hexagon/common-semi-target.c
@@ -8,44 +8,89 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "cpu_helper.h"
 #include "semihosting/common-semi.h"
+#include "internal.h"
 
-uint64_t common_semi_arg(CPUState *cs, int argno)
+static uint64_t hexagon_semi_arg(CPUState *cs, int argno)
 {
     CPUHexagonState *env = cpu_env(cs);
     return env->gpr[HEX_REG_R00 + argno];
 }
 
-void common_semi_set_ret(CPUState *cs, uint64_t ret)
+static void hexagon_semi_set_ret(CPUState *cs, uint64_t ret)
 {
     CPUHexagonState *env = cpu_env(cs);
     env->gpr[HEX_REG_R00] = ret;
 }
 
-void common_semi_set_err(CPUState *cs, int err)
+static void hexagon_semi_set_err(CPUState *cs, int err)
 {
     CPUHexagonState *env = cpu_env(cs);
     env->gpr[HEX_REG_R01] = err;
 }
 
-bool common_semi_sys_exit_is_extended(CPUState *cs)
+static bool hexagon_semi_is_64bit(CPUState *cs)
 {
     return false;
 }
 
+static bool hexagon_semi_sys_exit_is_extended(CPUState *cs)
+{
+    return false;
+}
+
+static uint64_t hexagon_semi_stack_bottom(CPUState *cs)
+{
+    CPUHexagonState *env = cpu_env(cs);
+    return env->gpr[HEX_REG_SP];
+}
+
+static bool hexagon_semi_has_synccache(CPUState *cs)
+{
+    return false;
+}
+
+const SemihostingCPUOps hexagon_semihosting_ops = {
+    .arg = hexagon_semi_arg,
+    .set_ret = hexagon_semi_set_ret,
+    .set_err = hexagon_semi_set_err,
+    .is_64bit = hexagon_semi_is_64bit,
+    .sys_exit_is_extended = hexagon_semi_sys_exit_is_extended,
+    .stack_bottom = hexagon_semi_stack_bottom,
+    .has_synccache = hexagon_semi_has_synccache,
+};
+
+uint64_t common_semi_arg(CPUState *cs, int argno)
+{
+    return hexagon_semi_arg(cs, argno);
+}
+
+void common_semi_set_ret(CPUState *cs, uint64_t ret)
+{
+    hexagon_semi_set_ret(cs, ret);
+}
+
+void common_semi_set_err(CPUState *cs, int err)
+{
+    hexagon_semi_set_err(cs, err);
+}
+
 bool is_64bit_semihosting(CPUArchState *env)
 {
-    return false;
+    return hexagon_semi_is_64bit(env_cpu(env));
+}
+
+bool common_semi_sys_exit_is_extended(CPUState *cs)
+{
+    return hexagon_semi_sys_exit_is_extended(cs);
 }
 
 uint64_t common_semi_stack_bottom(CPUState *cs)
 {
-    CPUHexagonState *env = cpu_env(cs);
-    return env->gpr[HEX_REG_SP];
+    return hexagon_semi_stack_bottom(cs);
 }
 
 bool common_semi_has_synccache(CPUArchState *env)
 {
-    return false;
+    return hexagon_semi_has_synccache(env_cpu(env));
 }
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 1f7d8a8df70..24e39531b95 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -837,6 +837,8 @@ static void hexagon_cpu_class_init(ObjectClass *c, const void *data)
 #ifndef CONFIG_USER_ONLY
     cc->sysemu_ops = &hexagon_sysemu_ops;
     dc->vmsd = &vmstate_hexagon_cpu;
+    /* semihosting is only supported in system mode for Hexagon */
+    cc->semi_ops = &hexagon_semihosting_ops;
 #endif
 #ifdef CONFIG_TCG
     cc->tcg_ops = &hexagon_tcg_ops;
diff --git a/target/hexagon/internal.h b/target/hexagon/internal.h
index 05d1129916e..38eb84f319d 100644
--- a/target/hexagon/internal.h
+++ b/target/hexagon/internal.h
@@ -30,6 +30,8 @@ void hexagon_debug_qreg(CPUHexagonState *env, int regnum);
 void hexagon_debug(CPUHexagonState *env);
 void hexagon_dump(CPUHexagonState *env, FILE *f, int flags);
 
+extern const struct SemihostingCPUOps hexagon_semihosting_ops;
+
 extern const char * const hexagon_regnames[TOTAL_PER_THREAD_REGS];
 #ifndef CONFIG_USER_ONLY
 extern const char * const hexagon_sregnames[];
-- 
2.43.0


