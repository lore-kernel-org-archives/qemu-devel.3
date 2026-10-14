Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91B2CC6B2D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 18:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH3g3-0003wX-2N; Wed, 14 Oct 2026 14:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH3fw-0003vs-Dj
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 14:26:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH3ft-0001zq-3U
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 14:26:03 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbJ7C3642838
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 18:26:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=/op7pBAyIwQ
 /DASVR4kWCEzcNlkj4eVJT/HoPo51TRg=; b=D/vnZ6Sw5wfUFRoIUeIBF58r6vb
 GPt02rZm1e+YaERNEXJngvmgIaH8SK1ZcbfqLD05iR/arKuSLtrbf+ulG15t3CXH
 wZymh6o8/kOR4rOD2bwdeXYMjPvZ8ak/LUMpKlb4SlNfd103PSBQiBiD4UaWJXRX
 sEAJffO1UwEZnIXzpdHiBEkvE/MegiUxv3kv1mKExMli2NlFfwuJT6udaU8WwGB1
 ofU4oD/vZ81APCyYxTL7Tkd/mIb4xinCfw9f+KD3FoYR7tuD4gdcUd2S8FFe3IIl
 kqO0A3iHgRh4arUx2acM42zOc5MHkxz0mg/9+wbzzLxsbD9Z/fl+/DmgsAQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha470ay9v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 18:25:59 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1383723dfddso2345270c88.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 11:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792002359; x=1792607159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/op7pBAyIwQ/DASVR4kWCEzcNlkj4eVJT/HoPo51TRg=;
 b=f1ofyx2I21NPAcMSjTTl5Bnldj0rlRd2mfob4fVc5slfmeDiAQ7HhIM3V5OQ4Iv0hV
 0yZn2c77qO5auSPjU0hF/dijIzS+QyXM/H2mSbbRJhg69MJ0lqb+6+0fG00Jg2zQW/iZ
 4y1BLf7NadD4okozhOrMUigRbcCymlsIrR4IziZaG+Pll6cYAtwZEXP4FaVWERhPCRWN
 8rhCn1zVzdjajJaeP0OgnP1DcI6Gy4H3pooJfN6/JOMrtuniD/5Bgf5aazIIqXTxC+wK
 Z7gL0VTSZ7rSBpJSbtYaMBwxNi11zhUStmOf0fFSFSuoYKLvpm5uat8xmJ5K/XRRVaii
 lzlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792002359; x=1792607159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/op7pBAyIwQ/DASVR4kWCEzcNlkj4eVJT/HoPo51TRg=;
 b=epLb9SXILtACxu0FFleUBY9+LWeDm4JclcH6bXq4I9meAp5Tyn6ws+GHkSajxBAN09
 uTEaRF+Nf5SDErEkHYLiUA4uwS5Gmirbj1ZYAbxzZHg5y+B8Y36AhuDhG5tYTloF5VXP
 NygrvdGeJYTWUEcxsrbmkRoQAjYGDnhhDZkwyEmvHm7AVQ+fEb5ZT+oTWmFRg87a95yy
 fZHU+MUi40IgpCbdrm0Cms8Wave/P7qGulDDVK99TOaibcDSEAeyJ8hzm/FXBXg4mrOO
 YZZIqughEk1FRoASNLBef8B4fhDNS08n1xNpsHD/h8PUhOSkQZFr680DUodbQWggyIfQ
 zKFw==
X-Gm-Message-State: AFq9FYIw6M8Mx2RJy7jTDsMR80FvCY5+KBwvXz6D2QIAAi45QNULTdV0
 G8b++taUDbIz0tbogMTfVvR/ph+86KvoZ/Bpk+AAfqveqUT8MF2OTuktzHu7g/5FXQEa7YAi+ny
 cZsrLKcaZha4lGc7Ws1HUxt/8KTs9LYw9nwOWwj3D6EsHGr9fuKi473kJ6ZpUFA3/kg==
X-Gm-Gg: AYBFou1vnMA0t/a+tqEbt8tYZT84zSSlxKlOOIA9+2o5TuRTW2a/K2HYEkVbY9wxwE8
 Sjij5ywSFwmXkNWnZUxrY+7VIv9QI0TJPpFu6duxFHxIeqHrDXphLKoPRHI2aKsTuDZbMK2uJ8+
 kIH9V7PLJqhn39dNWL5e3+Y2xPlrMRe+8UmkLFVg0L7VULmjZClIswl11ISW45+jmWeayDYCBhg
 kl9h62ImfGknAYY+Mqi6MeJCWC43wD9cQhtcizIAfPtGmOOGh1Qc+B4nSV2dEMfxttiGL4NTzxG
 G7c7ahajazAlIVb4xdAUx4aFVFxa9Q/2vnXQv+6n2XshpD3bgQTZ2/GMa1vZtYR/HJJkhXnJn1c
 ZzdD2jn/UvK1OhGZVk1EyTH+cpar/y9C9eYuMz/C6oucV0dbpE48zxgrV/p61
X-Received: by 2002:a05:7022:1582:b0:143:298e:913d with SMTP id
 a92af1059eb24-16a63b2edc7mr32441467c88.47.1792002358562; 
 Wed, 14 Oct 2026 11:25:58 -0700 (PDT)
X-Received: by 2002:a05:7022:1582:b0:143:298e:913d with SMTP id
 a92af1059eb24-16a63b2edc7mr32441374c88.47.1792002357632; 
 Wed, 14 Oct 2026 11:25:57 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a442956asm62348223c88.16.2026.10.14.11.25.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 11:25:56 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 05/11] semihosting: declare semihosting cpu ops
Date: Wed, 14 Oct 2026 18:25:37 +0000
Message-ID: <20261014182543.135965-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014182543.135965-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014182543.135965-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3MyBTYWx0ZWRfX1UsoFgiNQo40
 NmvGZ4V6Q5a1NrAQgB0h4p604842zY7nEP72+Z4hYC6WhUub6C5yf2c6lqXE93oWWEBwzEIB01S
 EWHb8etCBJzlG5NOTK/W/YVMhhAmjd+6EnKQjoYfOwl1hJ0bUA+1etVbr1S5JR/6A2LA4j3qkIX
 kz3UydWFtrgt5y7bjqfhOJI3YZR3lJtmTS5Y1uXXjDadoI8lSKM3Qx1Zwy2hyGmuMPH7GcxjUtJ
 Q3EiHp2rTPCMvCtpoUiUZ/iqVcDpmobih5Nm++uwhTAOtW2/f4b+LIg7kci9QJOqVCX6QBoGD3B
 frxrk3wqitIDwihfKIPtrufCvW5kl/ZdjKG8jbkL0cvy2IHRQnRKA0t6OKzDXnDBKiwNECZ504Q
 ZxkRFnlRNjQrR9IP2C8IaKjnuGBmr1qICXQlPf+DjZkyfZhkV3hV6v1UdRsy1t5aDmEqh6/oa4i
 iQV110f5rADY2FEu93A==
X-Proofpoint-GUID: hes_vIbQpokm0Hgjye2cc7hKtMTyTHQF
X-Authority-Analysis: v=2.4 cv=P6avFSAu c=1 sm=1 tr=0 ts=6acfc937 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=hb2kNex5ifQYlHlUoE8A:9 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: hes_vIbQpokm0Hgjye2cc7hKtMTyTHQF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3MyBTYWx0ZWRfXxoUTExRS9HIX
 VmRfilwyOE1MGGcCaCDJGoq00mVbbs3g6LFUsbLWvRA/9mYpKQCp8jDDFAbbQepkHugjD6OjdAF
 /aB+NU7FvlW/7hfVWdL2vJyhx56qxoY=
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

This allows a specific target to declare its implementation of
semihosting.

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/hw/core/cpu.h             |  6 ++++++
 include/semihosting/common-semi.h | 17 +++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 76801444a16..456154df6f6 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -98,6 +98,9 @@ struct AccelCPUClass;
 /* see sysemu-cpu-ops.h */
 struct SysemuCPUOps;
 
+/* see semihosting/common-semi.h */
+struct SemihostingCPUOps;
+
 /**
  * CPUClass:
  * @class_by_name: Callback to map -cpu command line model name to an
@@ -186,6 +189,9 @@ struct CPUClass {
 #ifdef CONFIG_TCG
     /* when TCG is not available, this pointer is NULL */
     const TCGCPUOps *tcg_ops;
+
+    /* when target does not implement semihosting, this pointer is NULL */
+    const struct SemihostingCPUOps *semi_ops;
 #endif
 
     /*
diff --git a/include/semihosting/common-semi.h b/include/semihosting/common-semi.h
index 1e7699d7bbd..618f60f76e7 100644
--- a/include/semihosting/common-semi.h
+++ b/include/semihosting/common-semi.h
@@ -34,6 +34,23 @@
 #ifndef COMMON_SEMI_H
 #define COMMON_SEMI_H
 
+typedef struct SemihostingCPUOps {
+    /* Return argument @argno */
+    uint64_t (*arg)(CPUState *cs, int argno);
+    /* Set return value for semihosting call */
+    void (*set_ret)(CPUState *cs, uint64_t ret);
+    /* Set an error for a semihosting call */
+    void (*set_err)(CPUState *cs, int err);
+    /* True if the guest is using the 64-bit semihosting ABI */
+    bool (*is_64bit)(CPUState *cs);
+    /* True if SYS_EXIT takes an extended parameter block */
+    bool (*sys_exit_is_extended)(CPUState *cs);
+    /* Return lowest address until which stack can grow */
+    uint64_t (*stack_bottom)(CPUState *cs);
+    /* True if SYS_SYNCCACHE is implemented */
+    bool (*has_synccache)(CPUState *cs);
+} SemihostingCPUOps;
+
 void common_semi_cb(CPUState *cs, uint64_t ret, int err);
 void do_common_semihosting(CPUState *cs);
 uint64_t common_semi_arg(CPUState *cs, int argno);
-- 
2.43.0


