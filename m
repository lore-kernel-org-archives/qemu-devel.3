Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 134D8CD98E3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 15:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZVoW-0001Nm-UQ; Tue, 16 Jun 2026 11:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZVoT-0001LD-4A
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:34:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZVoR-0004v3-EL
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:34:52 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GDxWd61934623
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 15:34:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LeNV1xXFFaZiL+0/3j//h+tIzT2zzLnWROSmDnlwF3w=; b=QtsLKwvUcby0YbZY
 xwVZQIQXHbXx6irjzjKQE7rHH2OSgIIxSuespTapWIeIiToG4jlAkRm73gKaGmAA
 s4YFpupgvPFtP5/RZLdAPvp/lnMEMTdjbFGZga1Vwe3oFVfMcf3NwHABPnIGRyjG
 iEEWOxzDybzsQb9jlAVMEgYzUkzlLoIPqdmU/GL/HPRnqfQn3TVAw1hYE722r3Zm
 b38qnHOEgmPH7Fq7NsrHYZ9lPUM82qj/DhjJ1GjXLSjZ0cNHlDsuslQLB1Xeqy5v
 6Hm1bb4JNHrArjtek1xZehOTFNJTdXysocD73IXbY7nYcrHC+VREKhcUENKyyccJ
 B9nghA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu3ct1sd0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 15:34:49 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-963b11561bbso1894520241.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 08:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781624089; x=1782228889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LeNV1xXFFaZiL+0/3j//h+tIzT2zzLnWROSmDnlwF3w=;
 b=TlWAQmP5CRTn4zPPD99gPw3w2dCasJdRnShlo9VxDJuCLU0MtoLfmU1FkpkT3R4NeD
 snXRZjXIFnAea0Hy1nZJv3Bb5yDzKFDnMQW53KQAEZ6weWuqXwLsUT7UD52el39IUMho
 4JhkuJlfbgphLexS1uHJenznCxeKEvUm8Bax499lyLnQaAcw5eMbYR5RxDt8O7rX32MP
 aUIxuGwH/72gpBkQC3Ncci6kMEtG69gu29E7jafAg/3B9txYeOUffsHCl/zKyFBC4otK
 wDAQqwWxafj19B+1kem6q15+3FlD/ismnaDjLpAdtpfw2zzj/HbpPncy/DbWAJVz0sas
 NSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781624089; x=1782228889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LeNV1xXFFaZiL+0/3j//h+tIzT2zzLnWROSmDnlwF3w=;
 b=C/oWvhWz3j0m/bVvWSe+PnfI3ImsZ7n234sUf+y5KOop6zs9kzx5JsBBjq5Y2Qs0I8
 st1wzCnLlrJy+iBBdDb/CDVESAUadkqRgqUUPFS9DdhmIqRbqze20g8baSo+I+amt0b1
 cyn3MiHctyEX9OcpXaXYzEmSgXJ3s9N3jrrvjPUZDmz/CwF9so2AVQwjwkKy9e+Q3ZTa
 pachO/cIWKkjzbT5fCC0UYGFGWKcfpoEMvcT5onr2SfiF+fpptWSuEcWu2KaF2H7HMj+
 7Mi+80ItKAFmQVkVrn/HuodE2c8fMdIJh3HYkpiScDAdtWBfOXQ6MefW/cFZDrQLmEV3
 RSeQ==
X-Gm-Message-State: AOJu0YwQgFXE49rC+50+wtjGIx4hj2SwY4lXP37EPaZsqtOyRRN218+B
 TDjBZKFzorwP8e3NffROCJ3MO68MQ2lTS0xw+6YdiSzQlX9SZYlX35e/kkIeeFJ2kjKFLc/7XF3
 o6FUaEPc5qP3sqRDT2jgDIG6ZIwuO1sSVvsSS/MpTUVjk6SekAH+4ESVDrAjANzr7zA==
X-Gm-Gg: Acq92OGFZ4616xEUfIBoMQsrcacWeE3i5e2n5VaJX8JA6CiSy+ebFDDxYY3YBCHHGY7
 RqgJxjH0w2A9EZaYmBmhX/z63jKuGf2v2FP6I4jF17B7WWEFEHBTVblSqkIcApJTCbztRig0H4w
 PN6lLzjQc8rtPUz7R2F92Vls5Oz4viql1IaEF8MTNYHSakTYO24dmXV7E8RMlVOygyf1gq77XSD
 gB6iCv4lgdr1Q1PVrgMIj2vLlHxyZ3U8TF1SWBBcFBBYp2AviCP4wDLRomo15AyDfLEMcpIns2h
 hyoSbh6oTBhYuMnl7SEQxcG/uDCby6cuIJHs3qV3VKyuUswunyqN09ZWLOC8b5x7aUnb1c54xq2
 IslBJ8q7Isukq8vrr06PbGwjn9s7QMKMzlUlPYxdGUyuD7hvvi4YfqxLkW/1NAkd1k6vfew3oLU
 hUPco=
X-Received: by 2002:a05:6102:915:b0:639:43f5:1fdc with SMTP id
 ada2fe7eead31-722da9a9bdemr2026553137.26.1781624088724; 
 Tue, 16 Jun 2026 08:34:48 -0700 (PDT)
X-Received: by 2002:a05:6102:915:b0:639:43f5:1fdc with SMTP id
 ada2fe7eead31-722da9a9bdemr2026491137.26.1781624088277; 
 Tue, 16 Jun 2026 08:34:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2ce361sm43497826f8f.31.2026.06.16.08.34.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jun 2026 08:34:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-arm@nongnu.org
Subject: [PATCH 2/5] target/arm/ptw: Restrict PMSAv8 code to TCG
Date: Tue, 16 Jun 2026 17:34:28 +0200
Message-ID: <20260616153432.92939-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616153432.92939-1-philmd@oss.qualcomm.com>
References: <20260616153432.92939-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SoCgLvO0 c=1 sm=1 tr=0 ts=6a316d19 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=wSUaFbrerrTpWb88fUQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: vANujoUmE9QKeb5ShfK3M-_9CKlCbXKY
X-Proofpoint-ORIG-GUID: vANujoUmE9QKeb5ShfK3M-_9CKlCbXKY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE1OSBTYWx0ZWRfX4kVB3BMIpGFG
 LmzXnHz8YKRhL9uz81TumULIVgnsArM2amx63nf7b8K6pVBMNNg/s2fAMWBkt688+Slb9g5or9z
 KrgUOk1EQiBzwOr4pREy55dZ5iW61Kv6Wu+HJ+liSouvR83Vjn0s24Hf0eTIpur9eIU25oPSbxr
 6H9riWboOAaaq4mxZUCapi311LrV4hcuMsN+bEOkdNVWmK9kIaOZq6Ggd0nTXoyZqmy5PpVIPCt
 /iidfEboSVbWMJF53I/e1AW14mUMmLMkq6/mnMRLVPzcXod5IBOnNtSk4yaUsno4de36ERqvb4o
 TbgllM1slynCA1cNeq0M6KkvJ+uYw3SfASb3w0vJVoLVmwW+4DUKVaq3eu3SivOYfdnhB9oq3C2
 X2l4cKoPrIbPOhpzmkQ86XC1Yy1WPDtT11NMUkU4i87RqIdFklFlIv92oYGOdW6N9eTwSRrFM5S
 mzpYWxfa2gnGX9hMo4A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE1OSBTYWx0ZWRfXxnhLFQtj0MLP
 SHZgxzzFbBu6i/0RIlJ8Cq6BK6GXnnt3JyMv8SZI2dz8MT5ol1wmDhL1Eral2w8wDEyF91lS0Cz
 oQ4IdgTGLrn3VyEPtb5DKVEW7Ts2Fmw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160159
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Armv8-M Protected Memory System Architecture can only be emulated,
therefore restrict it to TCG to avoid compiling it on hardware
accelerators.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/arm/ptw.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 8b54018c988..1470de30108 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -13,11 +13,13 @@
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "exec/tlb-flags.h"
+#ifdef CONFIG_TCG
 #include "accel/tcg/probe.h"
+#include "target/arm/tcg/idau.h"
+#endif
 #include "cpu.h"
 #include "internals.h"
 #include "cpu-features.h"
-#include "target/arm/tcg/idau.h"
 
 typedef struct S1Translate {
     /*
@@ -2818,6 +2820,8 @@ static bool get_phys_addr_pmsav7(CPUARMState *env,
     return (ptw->in_prot_check & ~result->f.prot) == 0;
 }
 
+#ifdef CONFIG_TCG
+
 static uint32_t *regime_rbar(CPUARMState *env, ARMMMUIdx mmu_idx,
                              uint32_t secure)
 {
@@ -3247,6 +3251,20 @@ static bool get_phys_addr_pmsav8(CPUARMState *env,
     return ret;
 }
 
+#else /* !CONFIG_TCG */
+
+static bool get_phys_addr_pmsav8(CPUARMState *env,
+                                 S1Translate *ptw,
+                                 uint32_t address,
+                                 MMUAccessType access_type,
+                                 GetPhysAddrResult *result,
+                                 ARMMMUFaultInfo *fi)
+{
+    g_assert_not_reached();
+}
+
+#endif /* !CONFIG_TCG */
+
 /*
  * Translate from the 4-bit stage 2 representation of
  * memory attributes (without cache-allocation hints) to
-- 
2.53.0


