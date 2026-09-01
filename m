Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DBDDC61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 20:22:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Uyl-0002Ow-8h; Tue, 01 Sep 2026 16:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1Uyh-0002MO-6d
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 16:21:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1Uyf-0003XJ-Hm
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 16:21:06 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681IX5Hu3237581
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 20:21:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=RBnYWGfLDA1
 gt1J6Cw1Kcn5g3TexB8FZRZbiLEs+8Yo=; b=BOhP8sFvZUIq6srjIGcZS2+yc52
 S+ARl4VI6Z6RO0zAnDzW3Hqa4xdbCgYx0/AWtnscl3dnX1vXybFyiqX+GzSYbcO2
 ex0OnOE5UtXqdUXoSbPX99SvQ7ReRrFkSJc+ATD/rE7r/xYe9OJ1mF1396YHoRwS
 ttyimnJH/gxpQ7xjt445V6tnom5Spi1/5ErJWrdH30j8JquHfNsWyTPP0PjFBqL8
 JjibAdDFkQxXZnvkIX4+ZWOjojLas1/zQspRmvttufaz83cHKPe3aq2m9cFcS89r
 nkVf2VqCvAtDFtcNK8yrJkRBY2QNdsKaQXYliUbVpPKh8HYK38pXcWFnyYA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge435rc9v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 20:21:04 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cb835525b10so374629a12.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 13:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788294064; x=1788898864; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RBnYWGfLDA1gt1J6Cw1Kcn5g3TexB8FZRZbiLEs+8Yo=;
 b=NIhKfu7MiY9df1EWb/dYEkFbwdiot5y0UQqzeYgv3WUQ3e3rOOuSssKvbS9Jka+MiP
 gcFSt7PGHnSKrixOpvVzKIV92ClgGr8Nb4hPYUhuXHJmCBwkaQiQL1nm+ZdzzkYJCufa
 1Mv67/2vh1JmWZovL8lwaW2tDfxtQhr1ScyWJiYJSy0o6DjzdqQ2nY2AmiEbqotkqABZ
 jWzJ5Jx9iSR5/h4stCw2MFIrBlCfGGruy69b2CnuBNNDL9NUnc2xTw3bzTcJWJEboqom
 Lh6HKzR7NSLc3byEvruumDVMOuaDNhF19v3N3igfO5NZOCz6zhZza59Y45IGaY8X9jUi
 ullQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788294064; x=1788898864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RBnYWGfLDA1gt1J6Cw1Kcn5g3TexB8FZRZbiLEs+8Yo=;
 b=S8P0E3Vaz9URBn1dJYNAOGwjhMfa0pkSa+vv4d9UOpyzw9N5BA+4cquUyppiHVWEN1
 muFTvzwqyuhHQpBoR33N64RW0LMQNIrtYGC7+e8dhi/BFB9mMBMvTmGwkMauGhQIU598
 +LfJSwi7Qh+iWc/qFAiIdaAauavmgp6DmgoLYreAGQjmhzqP48HVRtgsP+F70T3nOhbO
 D+/reaAJoBFTkrqn127vAH2ZeaaFAvzLVje1LXMR8nM1VywwuazTethEDVHEWSWRO8TE
 XcvUxHxPcE8CarPrJr4uVFcYVNqmv9F1BdEwK1hCcwx1DlgjQBWQH1aCen8/6mcdnD5w
 C1Jw==
X-Gm-Message-State: AFuF++mM1zDR1iMj4PisHk9RrqivanDeHnZio8gAYsvHDvohvGaj1UEc
 SaB8NzjvxxiuDN1zzc2UfH1wkedi3pXrfyGxIRQzp/gnt3dBonyWuZRrhfA8908qoqFHXJ7oP7k
 XV/i4aSTPHpQaHjyoU4cAr4Uz1AbHzIJU2T2bFzCQzpnCzXrUuidz9lFsddhY0a3G9w==
X-Gm-Gg: AYBFou3lcHdw/vKOFoM/mrPiXHs0ybeDhLTQY+8ufLKIubQN6YVWTfkELlFy+tRLgfu
 o3FGJ66sdulOTKYjyzUAoJ2iyngU0VZqS7DTlhsSEQ9Mef1iQmrzuiumpRsK+ddIYOGa3jVzSbB
 c8C0aZ6bHTjZn8DccPtLOzgH0roXWNJBAUXOYig3t9Y1kbJbUTE1shrDkQtqKsthdHufj9aVk+r
 sjoLvOQ6WfPHPHh/LAphblSoh2Kzx6MlhVJ23q1ldA4LZAB7LwegPZ8lviUN8mvf57xirUlGlVu
 LbzlD9zsnZ8LA2F7hOZ/XWMcZBHzt5duNsJrP9hQz9jRcEh9nr1FY/U7gGD5G9PUeVXEkJr1kiE
 dSqgwPoDp+MyifnWkgL0fTXwZF/Np0l8Wxl/pF+qlqLu4c8D1HjztXLS3cq0=
X-Received: by 2002:a17:90b:5745:b0:38e:fea2:df53 with SMTP id
 98e67ed59e1d1-39ae8219104mr1086267a91.4.1788294063654; 
 Tue, 01 Sep 2026 13:21:03 -0700 (PDT)
X-Received: by 2002:a17:90b:5745:b0:38e:fea2:df53 with SMTP id
 98e67ed59e1d1-39ae8219104mr1086203a91.4.1788294063223; 
 Tue, 01 Sep 2026 13:21:03 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3990d7bb9d7sm7734802a91.15.2026.09.01.13.21.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:21:02 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 13/14] hw/riscv: remove DEFINE_MACHINE_{RISCV32,RISCV64}
Date: Tue,  1 Sep 2026 20:20:42 +0000
Message-ID: <20260901202043.26532-14-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE3OCBTYWx0ZWRfX/K8mu8aZepFU
 0PcVcnZfPjzcBQXYqIScuQa5mzuTIKqZ97XR+lD70ZSuJ6b2S7M7EFbZb6A5giVDwq+VaJa4+z3
 wjr2cs0lr60qyE9Xi1DxGt7lpsKn2HfTLBCzcmZtP5CO6Gof0yZDeMq6CFjBjMOkOIKX6snP3HA
 QswfAi5GAyES9MojwfYEuhg7cO6Uds0sjDN5WVEOzg0AnKIalnk7YJkGIdsh9IkhWlPPpyj5rMe
 MSXAo+f2oux3OSORff1H0u77m3ytBqqFsRRoMew4GJmm4lsR738EOcDHULP9KG/og8l3e5p9OgE
 dEzmvJ2IiIKUdMGWxD0G/NLjAzjJCBBnbY6ivK6bRKUfXMC4il/6wFCUYIRca88EhvWLAAaHF7h
 JgqfOlx1UibumlX6bkdjD3GUF5wJG6XT/Z8f3ytx7Pd7nIanZSMcQwzJftWKLQXWswVL6Efhq1z
 BGViNJCEYfE9aMa6JDw==
X-Proofpoint-GUID: Mi-OJe4ffb_E2yyXzM6KUbcoU_PMcA9v
X-Proofpoint-ORIG-GUID: Mi-OJe4ffb_E2yyXzM6KUbcoU_PMcA9v
X-Authority-Analysis: v=2.4 cv=JpnBas4C c=1 sm=1 tr=0 ts=6a9733b0 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=kt-N5C0VSMjj5JecdnAA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE3OCBTYWx0ZWRfXyCBWTCfPZf35
 dy0otTK+/vkaE6FRuwlSlnfnJNUVJF2mMoLqjImfDuAjEOTOwgFw+MwNNP6PxwnBT8LV7DVh5/t
 7sJMq8JBqEM37uNc+WIzoQq1XbsK5MA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010178
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
 hw/riscv/boston-aia.c           |  2 +-
 hw/riscv/microblaze-v-generic.c |  2 +-
 include/hw/riscv/machines-qom.h | 17 -----------------
 3 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
index 965d0f5699e..30eff10bc5f 100644
--- a/hw/riscv/boston-aia.c
+++ b/hw/riscv/boston-aia.c
@@ -474,4 +474,4 @@ static void boston_mach_class_init(MachineClass *mc)
     mc->default_cpu_type = TYPE_RISCV_CPU_MIPS_P8700;
 }
 
-DEFINE_MACHINE_RISCV64("boston-aia", boston_mach_class_init)
+DEFINE_MACHINE("boston-aia", boston_mach_class_init)
diff --git a/hw/riscv/microblaze-v-generic.c b/hw/riscv/microblaze-v-generic.c
index d33ac39a68c..503e8e08992 100644
--- a/hw/riscv/microblaze-v-generic.c
+++ b/hw/riscv/microblaze-v-generic.c
@@ -187,4 +187,4 @@ static void mb_v_generic_machine_init(MachineClass *mc)
     mc->default_cpus = 1;
 }
 
-DEFINE_MACHINE_RISCV32_64("amd-microblaze-v-generic", mb_v_generic_machine_init)
+DEFINE_MACHINE("amd-microblaze-v-generic", mb_v_generic_machine_init)
diff --git a/include/hw/riscv/machines-qom.h b/include/hw/riscv/machines-qom.h
index e5f45b32e69..79d212eeb7d 100644
--- a/include/hw/riscv/machines-qom.h
+++ b/include/hw/riscv/machines-qom.h
@@ -11,21 +11,4 @@
 
 #include "hw/core/boards.h"
 
-/*
- * Helper macros for defining machines available in qemu-system-riscv32,
- * qemu-system-riscv64, or both.
- */
-
-#define DEFINE_MACHINE_RISCV32(namestr, machine_initfn) \
-        DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
-                                            NULL)
-
-#define DEFINE_MACHINE_RISCV64(namestr, machine_initfn) \
-        DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
-                                            NULL)
-
-#define DEFINE_MACHINE_RISCV32_64(namestr, machine_initfn) \
-        DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
-                                            NULL)
-
 #endif
-- 
2.43.0


