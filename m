Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 459CDC531D0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn3UW-0004or-3o; Thu, 23 Jul 2026 20:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3UV-0004ng-6R
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3UT-00068L-HP
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:14 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NLeFmT1055181
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=hC9X6LEdYeT
 1U04knlEifVxQ5EUKOOckVxZwwM+qFnc=; b=fXNmbTE1kA6ouF1XO+O/PSuvlJs
 jrJKEnjJTh/2a1INUT+2v2KuYG3PFnjMlbDnl8ubLVSjCFuLQOyjTr9QpP1smSQh
 5On87lF33afVlEed/m99/BsLdshpP2cakkMecmohKxSx1zvMDw16fs4wzQ6IRhCG
 dFHDm1aWOZf8EoknKoYBZQPCFbylonrDaU6NXzhp9g3ZIwAsO2x0jX3sM865P/Iu
 5Wbhuq6LUOygviO1TWnWb3BiG6tye/IIzDcg8JzlMQShjOW8ix7kxmrtjaryb9q6
 E4K8RWIc37rMJpBJDEyRl7joPOLWcBU9bJ9MhG1lePGqFKB1rnc/dhsAPNg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fknbmj2fa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:12 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cfca8558d2so1528245ad.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 17:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784851812; x=1785456612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hC9X6LEdYeT1U04knlEifVxQ5EUKOOckVxZwwM+qFnc=;
 b=DJidu1D5hDZJLVWOPQ6TUYQ8cN9KKqr/ij2+nPl6O0HN9mlQgWZblVIG7cis2sANzW
 VAnZZ/xBv2yhWt+DPxjOkP7hWzt76bgMyWyWTZV9hcSyqS5Y5sYvCLA8aoNjfxQGpJzf
 k5BmriBE/Ky9aOJ+CPPsHFEgn4uT/AkHHzhdaqe2rGmdwm2vR827Snl1uo3h/MNEq7aX
 +U+Op5NtxNEqVsgW77d7EaL7czO05kFHtrFlXyOc3WW1JpY01DaQaUYwcYiSSGFkDY8j
 EzGIaFtOljVBapS/4W+TY1RQX1egtR92C5VbnyaF/zoXwlnEmSkpMDREoArFsRZwLE1n
 /EAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784851812; x=1785456612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hC9X6LEdYeT1U04knlEifVxQ5EUKOOckVxZwwM+qFnc=;
 b=AvXn5M8iOPjMlIe6/k8WtsRv2pYIEG15zXsQunZQ7Wkx8mTECzPW6k7QP0MfEbNcQB
 m3Fw8bBG6hg0cwhnKZnva36U5NWpwOn2olCd/qhn//aZoTRdPMS/bS6lmAJzHHgiirRb
 zpRsS7MY6dSMN8izv63B7mOHICF9Z9FaMgJP+27utTom6ZC1CGUrWKRTZlpN5UQVnLtR
 sozu0kyaeJaA8tA1x86nhG6sHnrJCu62l47YxHo6hXGeJxrRG1qq+XoMxY39sWZry9nj
 Iw5m63UEwxfPZzRiqR3ZXivm+FlwsOoSrfYfFD/ZavQSuxq0nDD5fxedxRkgXESX0j6N
 ydSQ==
X-Gm-Message-State: AOJu0YyGTn4i55oqw7tHw4OEexiiov6/1dsd1ZWiJs+7Tp9QcbHqnA2c
 M0xQsRAm6a7nSvVrCh96WGX3xYDB3bIq6yktFrdlNpkZ0eVGc10e5chrCK1Alp6Mzc2bzSZI39j
 QEZLmrepLuR7gy93yRDFre8QBJ1lRIDgQDOWJBRzwMp+QZPkU56uUibQ3Spk6SgQTzg==
X-Gm-Gg: AR+sD125gEeWkbesmAw/o9ugFwwdAfbb9vlIK3GLPMO2NR2JVC68zt8CBuuVADtXHvB
 H81FqXJumWUaHk7cRqcFCtiKSJsRq4FtiV/qtg2CXiGsRnEjjMD6PS/083c5r+7o17ilt9gJ0Pt
 ZpEv2FMyXBcl9i6yPlCIg0pQynDEft1AizaF1z9Aqow30CWd9qDa9g9E5yDOz1uPpvnfkTweEl2
 8deAeIuakg+HJhSpW0iU5PS+UFW6xDqSojYBY5+vQbHxw3uD/Flg6WIJAM+pCQQOLOYod3zdXcm
 6xrCEo+sQKiyc8GreR9IYwtMdzSspNLjhwOl/v4watMaR9gNv7Mq4cWR680ccJQZoKv+AYkeb47
 XNfoy57exLQKzHr8cCWz6MI7k8DbNFnupu9jKN9F5chMensPObM86s5BhDUYa/AsVFyxzb0c=
X-Received: by 2002:a17:902:eccd:b0:2bf:27b2:4b80 with SMTP id
 d9443c01a7336-2cfa6b7a7c2mr60113815ad.14.1784851811541; 
 Thu, 23 Jul 2026 17:10:11 -0700 (PDT)
X-Received: by 2002:a17:902:eccd:b0:2bf:27b2:4b80 with SMTP id
 d9443c01a7336-2cfa6b7a7c2mr60113525ad.14.1784851811119; 
 Thu, 23 Jul 2026 17:10:11 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1bc886sm24359478eec.26.2026.07.23.17.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 17:10:10 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 11/27] target-info: add target_config_nitro
Date: Fri, 24 Jul 2026 00:09:31 +0000
Message-ID: <20260724000948.234657-12-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=e742j6p/ c=1 sm=1 tr=0 ts=6a62ad64 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=-_pwVPHoE3ozf5BAGqcA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: KGAdQ4c8i1VcMWnTPp2-ZT7UUH9CEpZm
X-Proofpoint-GUID: KGAdQ4c8i1VcMWnTPp2-ZT7UUH9CEpZm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfXx3X1vfw79BIJ
 Dp8fjkedL6fPfkj10CWtq29/+Kz1tCdmxTers7vdY89ytJO5XjF1QZcNh7unYVg8SwNd8UKIjll
 IDxtcZVlKeTEe/OjIM0GJupuiVC8aaw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfXz6QjrhwA8PBK
 +4e5kztgkN3+WungwqGusIJqji7lKCx3f5ihWRCFnmJD6fgnGHpb0hxWh13K4EgpOy4O7WR0dH8
 U92ASpLdKiP7zka0gyXtEQVfc4Zy+sCThmymDvWKvPJbvYehuv1RluarkGZoMCeDAJzj+dFtjR5
 2/kifIISIe5ghkKnhfuG1kws+Y8XlYHyY5wiFIRZBjqRlYfD3abE6YT4t9g9KSGvcOWvL2uE7Xf
 jvm89XwzJaE2LKCPEVl/TmLx11irT/KfjMcyapsgMm575BFHMKCUC0d2dmpep4WjIURjkoYq7ZS
 NTYTpp67Wq55U09xQ6HDEQCgtDfILFxOGwhLtyTj+8PHgKATkPFGpm+GDhlzY+sZJP3KNBqxzjN
 NaayIVGPOu/SGUEIeXd8X7uA9v6bo04eeynpQbD/J5raBOxRZvugYZue3g2SCc53q9moqILjgGh
 H1UxzZLBwjPWBLiz1aA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230233
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

At this moment, we duplicate code between all configs/targets/*.c and
target-info-stub.c but we will clean up this before the end of this
series.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 configs/targets/aarch64-softmmu.c | 5 +++++
 configs/targets/arm-softmmu.c     | 5 +++++
 configs/targets/riscv32-softmmu.c | 5 +++++
 configs/targets/riscv64-softmmu.c | 5 +++++
 include/qemu/target-info-impl.h   | 2 ++
 include/qemu/target-info.h        | 7 +++++++
 target-info-stub.c                | 5 +++++
 target-info.c                     | 5 +++++
 8 files changed, 39 insertions(+)

diff --git a/configs/targets/aarch64-softmmu.c b/configs/targets/aarch64-softmmu.c
index 4cf13a187d9..0d8519c3267 100644
--- a/configs/targets/aarch64-softmmu.c
+++ b/configs/targets/aarch64-softmmu.c
@@ -32,6 +32,11 @@ static const TargetInfo target_info_aarch64_system = {
 # else
     .config_multiprocess = false,
 # endif
+# ifdef CONFIG_NITRO
+    .config_nitro = true,
+# else
+    .config_nitro = false,
+# endif
 # ifdef CONFIG_XEN
     .config_xen = true,
 # else
diff --git a/configs/targets/arm-softmmu.c b/configs/targets/arm-softmmu.c
index f9b8212fc3c..9ea63d8662e 100644
--- a/configs/targets/arm-softmmu.c
+++ b/configs/targets/arm-softmmu.c
@@ -32,6 +32,11 @@ static const TargetInfo target_info_arm_system = {
 # else
     .config_multiprocess = false,
 # endif
+# ifdef CONFIG_NITRO
+    .config_nitro = true,
+# else
+    .config_nitro = false,
+# endif
 # ifdef CONFIG_XEN
     .config_xen = true,
 # else
diff --git a/configs/targets/riscv32-softmmu.c b/configs/targets/riscv32-softmmu.c
index 4fe8b096ce0..208d5792fb4 100644
--- a/configs/targets/riscv32-softmmu.c
+++ b/configs/targets/riscv32-softmmu.c
@@ -31,6 +31,11 @@ static const TargetInfo target_info_riscv32_system = {
 # else
     .config_multiprocess = false,
 # endif
+# ifdef CONFIG_NITRO
+    .config_nitro = true,
+# else
+    .config_nitro = false,
+# endif
 # ifdef CONFIG_XEN
     .config_xen = true,
 # else
diff --git a/configs/targets/riscv64-softmmu.c b/configs/targets/riscv64-softmmu.c
index cfcdac89697..1e0896d8db7 100644
--- a/configs/targets/riscv64-softmmu.c
+++ b/configs/targets/riscv64-softmmu.c
@@ -31,6 +31,11 @@ static const TargetInfo target_info_riscv64_system = {
 # else
     .config_multiprocess = false,
 # endif
+# ifdef CONFIG_NITRO
+    .config_nitro = true,
+# else
+    .config_nitro = false,
+# endif
 # ifdef CONFIG_XEN
     .config_xen = true,
 # else
diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
index 98542bdaeeb..d9c4f0a5da0 100644
--- a/include/qemu/target-info-impl.h
+++ b/include/qemu/target-info-impl.h
@@ -35,6 +35,8 @@ typedef struct TargetInfo {
 
     /* CONFIG_MULTIPROCESS */
     bool config_multiprocess;
+    /* CONFIG_NITRO */
+    bool config_nitro;
     /* CONFIG_XEN */
     bool config_xen;
 } TargetInfo;
diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 0ecae9411c3..96d85aecdeb 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -127,6 +127,13 @@ bool target_riscv64(void);
  */
 bool target_config_multiprocess(void);
 
+/**
+ * target_config_nitro:
+ *
+ * Returns true if target defines CONFIG_NITRO.
+ */
+bool target_config_nitro(void);
+
 /**
  * target_config_xen:
  *
diff --git a/target-info-stub.c b/target-info-stub.c
index bafbeaa039f..ca5bdfc5a91 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -51,6 +51,11 @@ static const TargetInfo target_info_stub = {
 # else
     .config_multiprocess = false,
 # endif
+# ifdef CONFIG_NITRO
+    .config_nitro = true,
+# else
+    .config_nitro = false,
+# endif
 # ifdef CONFIG_XEN
     .config_xen = true,
 # else
diff --git a/target-info.c b/target-info.c
index a264c51ce83..067feff98cb 100644
--- a/target-info.c
+++ b/target-info.c
@@ -120,6 +120,11 @@ bool target_config_multiprocess(void)
     return target_info()->config_multiprocess;
 }
 
+bool target_config_nitro(void)
+{
+    return target_info()->config_nitro;
+}
+
 bool target_config_xen(void)
 {
     return target_info()->config_xen;
-- 
2.43.0


