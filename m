Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860A4C531CC
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn3Ud-0004vK-0n; Thu, 23 Jul 2026 20:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3Ua-0004un-T9
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3UZ-00069V-6L
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:20 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NLeCfO1069118
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=5pBaPu7GH/c
 cfTb/BourXTXIUNG4IPwTEvBUsgP7cLU=; b=iGi6MOuad4MbomijYM2xCH8UiCU
 z1dFMN2S1cLvluyi2S9jk2lRSIybqLblbk5ugNKOTehPwOTtuz0ozxrhthnzEWva
 91bEsF8vM9t6JvOiM5w20latQEzlgxBhI2AY+Qm6b5zZJB4IGKA5x4h2n1aL1A7D
 cDcbae5aoj5SV4MpAhihoUwIjnVqbmBLEqZA1etX3T1jbZxoUqkIaYMxCVaZS8T6
 L0qEUtVhQXzOtRENA8Q5wDzXAkmYyIjURpb3RW0bdTjxRmSyLnQCzSDmS5QGmS/1
 GGYBF4uzcx2C8QObPruUqQ0fv4R1nlQiUtDXECzRCTZyB6gWLpsYLtXb2Kg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkg523f37-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:18 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-ca8aee88725so2184375a12.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 17:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784851817; x=1785456617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5pBaPu7GH/ccfTb/BourXTXIUNG4IPwTEvBUsgP7cLU=;
 b=ZOlRRUgcJk71Yb0AKG3N2VcgvKP17WYkZfeQWo/jzVqLoG+y4KCj9BmD+BIIcSr6ar
 zyoXEyAl17eWoFkH+W7T+j9+3ZzWr2TGGaRJJAr1SuyIxDLRQ9NjX2dQlpHxXr44719F
 XfNHFpTa0zixYEW5myMROkYwe4hWVhrN3+jFgoATSarpE0cIjQauCTBVQ3WW/3T8rl6V
 Phl6VWlWK5nYwvkIKS50b/3eX/3VS17alCc2Hc8hjPIN9+Ft363D3vqDaqWr3XKzzaz9
 OOsoplp5sMnvXb7akAxx/v46JzZXi6IbjbdaJMmUqsvpa7WnZ/8BX3Rf44i6oUJdEjWk
 aV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784851817; x=1785456617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5pBaPu7GH/ccfTb/BourXTXIUNG4IPwTEvBUsgP7cLU=;
 b=Nftg4FHAG3Jb0AMgg3/FALqn1XVJatWWNai7AIFzrw76zk3baQNHq5C3jmb7QpAcjq
 YZJGFExSfLkZDRKLa28oMul5IarT5UmN0nbEsszksYGZE4Vt1x4QbT9R+ZGXSI3OCHRR
 AQz4TbdIxpym3W889ya7tFzi8D1TaRKQnFbtMJh8IBK3FMJcAjtzToA9TqKfoU6gU/kD
 EioXryuU0ymxOFGy+rUCjZEewHvFuCu9p1MP7ylK0dLMmWXSpD3mTfMvOtr5rvTx75Lk
 NP+sZxIWyEUqGb+bmx9xO314C2QdS/K6Eyod053pB/yyXoZn2IoF7BOY2dUtuTZ8yD29
 voUQ==
X-Gm-Message-State: AOJu0Yx2HDgqq9CN5U8j7oR4KtknYmeMLENXp0Za1PzSrcaQUluQrENP
 Ebo4LEyJSvRJW8hzNlRpxEp/NT+eNZMAXDG3FcN0HO0XHhhqIigpxzitkTtBznQ0lXA1CKJoAgi
 E4HMH+nNRnB+Xkq5H9lxDZdpCBj2Ad0TAVP7e6VTAMeLguuKDy/XVWugYyypZ80mbPA==
X-Gm-Gg: AR+sD130DiW6gyMjmj4gM6HAUd1XD80ivlOyJ9LO77HQ7H/JI9MT44Cy2Wz+A1B5xdo
 ZoHRTw48eVvxbdf/pZgVGoq5QW84QTqkIBUbPn1Vv4IyxW4zUgh6eQv6uu8vSTZAk/vHI4HBJZO
 hxSPtY1aIqG6BxWnKZ0K5NerUIPPyaV8hZNTKV02kaZK8esRr2D95J8C31poy6eBdjItJ4TL2Nk
 6ouOXpuRQeUy7dCu2g6e4ttrQUPjaAxqP57jVTQFU6/TS2L2yZLKUteC/Evk7H2DHuuORXKtaBI
 x2VvJMSKfYRmSTYRtHAgim1XKaPLmOIShUQUqyvRzLQ4aX4AvrBLVi1GPcS1a567H4UIMlDfF/9
 mDAFxxysdpaQI000rLZVqjT2JAMTWWoP3Mu863Xn/2O3LysdGWk6Qbzn37oUEG90gMQ46aIY=
X-Received: by 2002:a05:6a20:2d0b:b0:3c1:a0c:ab85 with SMTP id
 adf61e73a8af0-3c44b2c29admr6137845637.76.1784851817241; 
 Thu, 23 Jul 2026 17:10:17 -0700 (PDT)
X-Received: by 2002:a05:6a20:2d0b:b0:3c1:a0c:ab85 with SMTP id
 adf61e73a8af0-3c44b2c29admr6137818637.76.1784851816844; 
 Thu, 23 Jul 2026 17:10:16 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1bc886sm24359478eec.26.2026.07.23.17.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 17:10:16 -0700 (PDT)
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
Subject: [PATCH 15/27] target-info: remove target_machine_typename
Date: Fri, 24 Jul 2026 00:09:35 +0000
Message-ID: <20260724000948.234657-16-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DtZmPm/+ c=1 sm=1 tr=0 ts=6a62ad6a cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=Pt2zigQk823_XuNZ9XIA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfXzSgjotdsWtda
 IpxsNfA1cXyu6635A+PWMl3uircTie/voGfqVSgMObK+OSSn2F8NQNlDY21KklSG541vseNXo6h
 urhVQEP1tMrQJJWDeJqwS4/zepPzMpM=
X-Proofpoint-GUID: UhJwkYilmpi1L-HYiQIZeMvJuQ4a-6dq
X-Proofpoint-ORIG-GUID: UhJwkYilmpi1L-HYiQIZeMvJuQ4a-6dq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfX+FqX0CFaMxvl
 JpZjus8gtPE9EZlVVcKNLtKqH/+zNY7urHI7dbLEec61ZENfayHeDW4AlpjlcTzAq75T0W4uHQi
 dUM1sAGcOsyXhjmNLMNyicvpIGXCLKH2NNRgchVbvd0x89YVfAzHX0jAU2XDOOZ6vE2cyBUJvyC
 wYe3wZCmwTimCnna1sJZo4Cq/dvHRKUJwiEnsHEW4F0lSVBnFp+LKqbQ7/ItMAnKANYWvm3tT7y
 gKJfMKC2zYfJ5tczzP8ChKTsIIuLDus/aHkvldIpBKMo4I4FFEkr6DdunZAB2WkADkqo+GbbtiB
 EWFyopk6NgQTp0VLRW2pUPyDlHJayE3SP0ilqAEQ0Zs6B3kXKLLG5wPiyI38pk2PczXLUCRE+7p
 5svrCjfdBc28sum4KqDWeNYBU4/kGkTcDzyVqjnypliIoExz96LsSsuehsNfD5nI0H/+cPCcOhr
 gpgZowBQmWkke0L33xQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 configs/targets/aarch64-softmmu.c | 1 -
 configs/targets/arm-softmmu.c     | 1 -
 configs/targets/riscv32-softmmu.c | 1 -
 configs/targets/riscv64-softmmu.c | 1 -
 include/qemu/target-info-impl.h   | 2 --
 include/qemu/target-info.h        | 8 --------
 target-info-stub.c                | 1 -
 target-info.c                     | 5 -----
 8 files changed, 20 deletions(-)

diff --git a/configs/targets/aarch64-softmmu.c b/configs/targets/aarch64-softmmu.c
index 0d8519c3267..381a9f686a5 100644
--- a/configs/targets/aarch64-softmmu.c
+++ b/configs/targets/aarch64-softmmu.c
@@ -21,7 +21,6 @@ static const TargetInfo target_info_aarch64_system = {
     .target_arch = SYS_EMU_TARGET_AARCH64,
     .long_bits = 64,
     .cpu_type = TYPE_ARM_CPU,
-    .machine_typename = TYPE_TARGET_AARCH64_MACHINE,
     .endianness = ENDIAN_MODE_LITTLE,
     .page_bits_vary = true,
     .page_bits_init = TARGET_PAGE_BITS_LEGACY,
diff --git a/configs/targets/arm-softmmu.c b/configs/targets/arm-softmmu.c
index 9ea63d8662e..4f946708864 100644
--- a/configs/targets/arm-softmmu.c
+++ b/configs/targets/arm-softmmu.c
@@ -21,7 +21,6 @@ static const TargetInfo target_info_arm_system = {
     .target_arch = SYS_EMU_TARGET_ARM,
     .long_bits = 32,
     .cpu_type = TYPE_ARM_CPU,
-    .machine_typename = TYPE_TARGET_ARM_MACHINE,
     .endianness = ENDIAN_MODE_LITTLE,
     .page_bits_vary = true,
     .page_bits_init = TARGET_PAGE_BITS_LEGACY,
diff --git a/configs/targets/riscv32-softmmu.c b/configs/targets/riscv32-softmmu.c
index 208d5792fb4..48d55bfc354 100644
--- a/configs/targets/riscv32-softmmu.c
+++ b/configs/targets/riscv32-softmmu.c
@@ -21,7 +21,6 @@ static const TargetInfo target_info_riscv32_system = {
     .target_arch = SYS_EMU_TARGET_RISCV32,
     .long_bits = 32,
     .cpu_type = TYPE_RISCV_CPU,
-    .machine_typename = TYPE_TARGET_RISCV32_MACHINE,
     .endianness = ENDIAN_MODE_LITTLE,
     .page_bits_init = TARGET_PAGE_BITS,
 
diff --git a/configs/targets/riscv64-softmmu.c b/configs/targets/riscv64-softmmu.c
index 1e0896d8db7..01013bb5b7c 100644
--- a/configs/targets/riscv64-softmmu.c
+++ b/configs/targets/riscv64-softmmu.c
@@ -21,7 +21,6 @@ static const TargetInfo target_info_riscv64_system = {
     .target_arch = SYS_EMU_TARGET_RISCV64,
     .long_bits = 64,
     .cpu_type = TYPE_RISCV_CPU,
-    .machine_typename = TYPE_TARGET_RISCV64_MACHINE,
     .endianness = ENDIAN_MODE_LITTLE,
     .page_bits_init = TARGET_PAGE_BITS,
 
diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
index d9c4f0a5da0..de329ec2b86 100644
--- a/include/qemu/target-info-impl.h
+++ b/include/qemu/target-info-impl.h
@@ -21,8 +21,6 @@ typedef struct TargetInfo {
     unsigned long_bits;
     /* runtime equivalent of CPU_RESOLVING_TYPE definition */
     const char *cpu_type;
-    /* QOM typename machines for this binary must implement */
-    const char *machine_typename;
     /* related to TARGET_BIG_ENDIAN definition */
     EndianMode endianness;
     /*
diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 96d85aecdeb..46d0efd6498 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -23,14 +23,6 @@ const char *target_name(void);
  */
 unsigned target_long_bits(void);
 
-/**
- * target_machine_typename:
- *
- * Returns: Name of the QOM interface implemented by machines
- *          usable on this target binary.
- */
-const char *target_machine_typename(void);
-
 /**
  * target_cpu_type:
  *
diff --git a/target-info-stub.c b/target-info-stub.c
index ca5bdfc5a91..71a6064548f 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -33,7 +33,6 @@ static const TargetInfo target_info_stub = {
     .target_arch = glue(SYS_EMU_TARGET_, TARGET_ARCH),
     .long_bits = TARGET_LONG_BITS,
     .cpu_type = CPU_RESOLVING_TYPE,
-    .machine_typename = TYPE_MACHINE,
     .endianness = TARGET_BIG_ENDIAN ? ENDIAN_MODE_BIG : ENDIAN_MODE_LITTLE,
 #ifdef TARGET_PAGE_BITS_VARY
     .page_bits_vary = true,
diff --git a/target-info.c b/target-info.c
index 067feff98cb..ce7f9797dce 100644
--- a/target-info.c
+++ b/target-info.c
@@ -32,11 +32,6 @@ const char *target_cpu_type(void)
     return target_info()->cpu_type;
 }
 
-const char *target_machine_typename(void)
-{
-    return target_info()->machine_typename;
-}
-
 EndianMode target_endian_mode(void)
 {
     return target_info()->endianness;
-- 
2.43.0


