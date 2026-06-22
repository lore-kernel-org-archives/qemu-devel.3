Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A1DCDB466
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 19:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbkO0-0000ty-G2; Mon, 22 Jun 2026 15:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbkNx-0000rS-Us
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:32:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbkNw-0001tT-Fk
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:32:45 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MFXVOH1647515
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:32:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ZW1AS6UbO/D
 iXQEGb3FbTJGYHWMXWvoOX//tpmsFM7E=; b=Fhs1cV4OiLUUWTnEYWo9pSoq9C4
 xz8rj/nxlCjiCraRCMgH1iWT4lRPvmtkXKEIv2QJ4nDBnTyBHobOO5b7lP56DKcW
 mI8FQsbTqRDzo0pG3DS8ZjgzRVljRgNPQ0tMArgLHSdYm3wCEFcw3em7eLLOuHCC
 6s+is6wDRna7MnTnTRhLP5+uiDTp45C/FtUYE8z6i1A55hl4Vb5yosHYOimid5o7
 kXrkZwCcrpyrgsWF20O4kn167RvBhv+E6PDCZLvEr8jRuYo2dW14AyjZAYSVtMSH
 Iv1e5z+nMSsdmPO8WKGzbaRSoYyofPnU1+Io2N0HD8+Jcga3pE4dAbYtnMA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey37h9ybr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:32:43 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-91574ad681eso734869985a.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 12:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782156763; x=1782761563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZW1AS6UbO/DiXQEGb3FbTJGYHWMXWvoOX//tpmsFM7E=;
 b=bm1Q7MnLh3RtjbJnZjA7gLA2LoKV1W/DBuDSXZFmZA7hVFw9E5KiQYm1vytWphKOF4
 FC3ljlLfgUluzE1Tr305RRXMrPnHv5JcyKaL4G7cHAOm9zr+UiW3LlgbP4OJmAxQ/NyA
 amTKzciRy7WHxBjiwHafvOmHWQVsKCgwVQAGJ1KrTkdEQhPPIsIMf2ClM8tdT5Ksz74x
 SussbQGwGmbEkyONdqjdstagFDzepOG7CAGDpX+N2uWI/imBbg70IpEyiRLeRCJU7697
 yADgcBHkNp4HkWKGELLblWwWIrC76l2Ih8hVUaI5ApEikO4V7fGpNxxnF5pBNpTN+QdS
 V2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782156763; x=1782761563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZW1AS6UbO/DiXQEGb3FbTJGYHWMXWvoOX//tpmsFM7E=;
 b=k0w22emxrjMr9zunYVqrgZBUpeuc6V1mD6894DnWAQrAPFOVxWMdnIg44oAxfV52vD
 sWBc8tdZ1viZnw46LvTQOlAcyXfEwBuvyb4Jl+jomMCkQqlxPs4vMBrOSh+AzN/Lzr8G
 nKlEfjweykOxmaoWmBjIhoFZYvN6tudgPSXAJHjg4nrCWllaWAiubN+Z/0QWlBzMBC2h
 IB6NmYKYO2rWaO7PIuMr0PSB4T1qbMDEAjzQmKQqWi6og0Mc82oT1A4OmcrZij80Vpuk
 Q6/TJifOPmnZ21srMfJLX5tYrwbpNGaYUWChHVVwWMfZigffIp3xvWwm2kzdCFfQtkET
 Oopw==
X-Gm-Message-State: AOJu0YwpPkDs8cSozYUNJjQtjUBGjrgiSOqRvpWQhcc7mVIPYsvhMzsT
 fgVUhOvmFHRP9rnlnn8nXzLzu1xCiRFKt99O7XQ9puNCCZcLAkPjhndcMt+Oj23NDblWSJvBWJZ
 +pH8UP71+bhY4m67YMw9TJ+ZWOoJL7B2L+0d2nXr3QXzzeDL8eAgnL4E11LBR5+rjCg==
X-Gm-Gg: AfdE7cnUTL1azkOKCBqXLMakiV0qJvIZ40VW6bISSM63KvsjJ6qKRztDPIoANowdERP
 Rm31/odfeeg7V2frqWY8rEr9DHJtSP4PTAxjRUGbxBmZTznv+VF8C/zcVCFOLwpkKUHYdExKE3h
 e/eHs8k2K/+hCvCH9+2uOjjKcRNYo1v+ugF6sR2uFLPwZfK1IHZUblZ5qOYBpzQjMqSsHSZVD+V
 b2gn57lz/lB2D7HzMc50ZUWakQtx6zw/Yo2O1UFAzTUw8OlFXby9jtoIndgw1pMLzJDcrIAyEEX
 C4FafcpGE6y1vBKXlXNr2xDtqnnYS0Y2ZKLXeiSQx9BVcdbngXzIzY8KNKkBw2tp7nONj+4dq84
 7vmz15/kSSdHUqs+o1fuqrdcbPrpWE5agrjE+zyQ7OfCO/w==
X-Received: by 2002:a05:620a:40cc:b0:91d:6ac3:567c with SMTP id
 af79cd13be357-9209119c552mr2633428985a.31.1782156763010; 
 Mon, 22 Jun 2026 12:32:43 -0700 (PDT)
X-Received: by 2002:a05:620a:40cc:b0:91d:6ac3:567c with SMTP id
 af79cd13be357-9209119c552mr2633424085a.31.1782156762587; 
 Mon, 22 Jun 2026 12:32:42 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-926004ab49csm61489585a.34.2026.06.22.12.32.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 12:32:41 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 philmd@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 18/24] hw/riscv/riscv_hart.c isolate tcg only bits
Date: Mon, 22 Jun 2026 16:31:34 -0300
Message-ID: <20260622193141.1449724-19-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: KWGLiXM4gMNFISlt9eaPFD7jmnVriGYQ
X-Authority-Analysis: v=2.4 cv=ecANubEH c=1 sm=1 tr=0 ts=6a398ddb cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=0nQI16K_ZF54athspwIA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE4OSBTYWx0ZWRfXz1wdzadumlxm
 jzNNKmrb1UfWZzgdBtyChmr7ObOXGfc55xFoLBYUs91Xjthn/C515OkzSOQq7+cYyUELmc10+/u
 uLD1DLJ117hMI9G3phJj+61tTEHKWwQ=
X-Proofpoint-GUID: KWGLiXM4gMNFISlt9eaPFD7jmnVriGYQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE4OSBTYWx0ZWRfX06Z9BWRvao1U
 sLp1exUB1hmz4P5tqoCzaXKC3saanvg8EV8nK7NkaL/wzvkZPiDrNlsaM6ex7+wkFQIjHkrXGMS
 Pgvgghaxh8mQph8OP2Fhjmntm4LCd+e7jaHUCiQkz5NsDhLbzUG9dthD255Wpbd7i4QsJ2eP68c
 GjD5qPhrJfHIHWlhEjHLLT/+5O9J/ZvPEcAiQ2Ybgxs+fmuf+mNwR0K60IRZwO/H3CPRL8QTi4W
 aeWFv83SC0CwA2kenc7cTWCmipMUYUWmZ3jamkf96mn5y65NwJqO9FyW96iaRtD0mHdGXYaLDYX
 u1qgoPlQFRybeoq0U6jgsaVem7xh37lqEvShRIfpWvy/Nh9jFnPwthPzg/hwfSh5lLZKYPnfhRy
 hlbGVZjICqW1ptq3XanQP6nG/1vkhg6Y4ZTaxVVZzKE21Ggk45Bs1UaYu8nvckB0Nua0xduaPUN
 lb8Zl4FqDlELtqxZozw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220189
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

riscv_cpu_register_csr_qtest_callback(), vcsr_call() and
csr_qtest_callback() are all TCG only and are not available in
--disable-tcg builds.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/riscv_hart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index d1c7188369..28925aee59 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -61,7 +61,7 @@ static void riscv_harts_cpu_reset(void *opaque)
     cpu_reset(CPU(cpu));
 }
 
-#ifndef CONFIG_USER_ONLY
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
 static void csr_call(char *cmd, uint64_t cpu_num, int csrno, uint64_t *val)
 {
     RISCVCPU *cpu = RISCV_CPU(cpu_by_arch_id(cpu_num));
@@ -151,7 +151,7 @@ static void riscv_harts_realize(DeviceState *dev, Error **errp)
 
     s->harts = g_new0(RISCVCPU, s->num_harts);
 
-#ifndef CONFIG_USER_ONLY
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     riscv_cpu_register_csr_qtest_callback();
 #endif
 
-- 
2.43.0


