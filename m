Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C113ECD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBuQ-0004pe-Lw; Thu, 18 Jun 2026 08:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBuO-0004oD-4o
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:31:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBuM-0000uj-Hh
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:31:47 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IAs3s12612695
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:31:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /jfoVKGuOODJyy20PzW4CsV+7Ec7TEdfFD78Oy4EhyI=; b=JKvgZGZBDuHWMAEg
 mYlknS5L2gDn76xO7kCS2ZHAajwjjCYb0Uo5RVh8AeeEsvl8VFC/jK3Ve3vpy7Oo
 bODCUwBiI4liZZ9BUwRqheJwwVAsyVLGjRl3oNqDzIiuaQTjSDX48hcdrlT5YvxE
 3Y9FQoBtDOdYVUvMGp3fUnIXl76ahsYtg79AbNIe9FDqhwKBMqcacmqhK+Yhqnhz
 to6ulFeUMQBK7dzKa9oRZ4lPiMUHplOrHtt3/cLK/LCjJchaVcjmts8ULODdQap2
 9fJ5nx0nrj0ywWuwWnN/cn5eY/0bXMRBFiH5m0HcBOPDAN6psXtpuDWLGOs2rttN
 nE4oCA==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euw9vmupb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:31:45 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-486660d2abaso1316868b6e.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781785904; x=1782390704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/jfoVKGuOODJyy20PzW4CsV+7Ec7TEdfFD78Oy4EhyI=;
 b=YRvtZDAYF/3KXHUdbK9jP72rR/o2cGNd8x5lb9S7nWO0ZxnTLfoLlF5Irb4vU9soOE
 dEkT1XF3wJ9yat8tGwzXi2GrLEPV2N63yQBr2/DcDj+kW7VKva0qfc5rNxKIzTNSQzgL
 NWIAq9vswkVjmFTZULEGXjRhfbeMVeccnSvgxvILSNXAZef2oYPhrzjcBDcrQBNIj/N3
 QmxS8OknC30OreeuIeJvlIIng2qydf6Ra6iFg4+WkXcWyYVn3ES79X/OAU7W4nPYP1hp
 3sG2kkkvMnOQVxTMmwWE05+7xH1dQbt+D89ONWQtuxKKJIquchvpHkNxtP0Te2MGwUHP
 VUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785904; x=1782390704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/jfoVKGuOODJyy20PzW4CsV+7Ec7TEdfFD78Oy4EhyI=;
 b=Ogp9p+jGwuDtQq2vvlxbdg3OxcDq9aTYTE2eRZAu5wrwViZ8BPT1jCa6YJxWKxrPmc
 exTVox5Oak5HaN9mly32/LEryv+miBYbEIVFFu+U1RvCdhs2QBi7QB5WqfMRKGxTCtQV
 pMn9EY5vVBfsfGfoaxM02sURIC7QUv5COYM7s9+dTE4bpwNqT6wbHR2uLiRhYx6z18pW
 FrtZFfx9aBlTeg3WG21WmDk1mHw0hqcaVCnDo4p/cPz6iPWXc2iURyVGovvYh58p5ehS
 BpH0tmlAUEXIK9HIr4PWlZdVFhxbcBOVuioXp/gd883yuONsWWR4VMMlmzSMjJU11l7F
 0blg==
X-Gm-Message-State: AOJu0YxQciukO5SwJhX0iH72vdQTSulAqXttIrIl7EhOTKjr1s4NTzcM
 rS/PP0TIo8IAn6PyODyBYUUQ5z4uU4cAMHI43WMxvbRqn6RbpltT7j8LTDdJqvsEeTF68ZlyTDl
 gJ2+DeMgnBP9wIFjrUF6yeuJXy9QxpvqMjj4XWrAzV1TltE/cV7eDLefIyo4P26yhow==
X-Gm-Gg: Acq92OGb87gOyWA8chxmCo5/1/CMQ4B5G1WPZeqj0Uh1Nh8gyNmEzbD5/WgYF9nFrZf
 VsJNnfZGtHFej3WErZIPYPwzRA/OE0fUDrKLmud7SzKoU1X2Rt9OuIY2D0fmCPJ0AS8z43xKtPd
 pZid73SSGV3ydNLxmP4b9buuIZsoxzlN1xOkFZnlcwGHVUjZ3meZJ+s3jlXUuAy4MR5E1NDn+c5
 0KQwshfUXMmvRWtraUXsEEUfasFF6DsTLT/xeUz0aiANbUlvfVWT9dDCQBzmb5wjGItWzlGJ0+l
 RFtLiyzh2Odvple4+ok1QEocpWomD1caBTkVhD+QpXhGEfXXWfHfx+a26Oj2DXv7MyOq1kPwJvN
 UtE1Wwyi7PuYgOB8GLfzgC/9iBcjlzSRW9mKb/p0uG6h85kziQRPNIAqAlPZlzIQjaiir
X-Received: by 2002:a05:6808:f8f:b0:482:c2dd:d18f with SMTP id
 5614622812f47-48942a1c49fmr6703896b6e.40.1781785904362; 
 Thu, 18 Jun 2026 05:31:44 -0700 (PDT)
X-Received: by 2002:a05:6808:f8f:b0:482:c2dd:d18f with SMTP id
 5614622812f47-48942a1c49fmr6703878b6e.40.1781785903942; 
 Thu, 18 Jun 2026 05:31:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26392esm62814456f8f.3.2026.06.18.05.31.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:31:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 27/48] accel/hvf: Reduce hvf_kernel_irqchip_override scope
Date: Thu, 18 Jun 2026 14:28:04 +0200
Message-ID: <20260618122825.90331-28-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ITYPoaKpi_nRaxbQdHerIpBa8rtmTmjB
X-Proofpoint-GUID: ITYPoaKpi_nRaxbQdHerIpBa8rtmTmjB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX943cJNDQajZ7
 GH4pTHEEQptqD3ia3Z6jrey0AvH5Vwhj9D4QM+ILXteYkqLz1OfVukzlebJyKR+xITI1pb2Xx6h
 foeTxhQbHX3+dsiDJmMOayhBii7YvELQucZ2erLzyMMPDCBX5zITOtjrzCaTRE22ZCfY0Y91f93
 LmClFITBdG5OB8pwUD32MWe5kob8WxX2koxomqmZTqCAGFguwP7Uus2FT8GIiTkptPghDLdLode
 Ft0UxcQi2LvonMCyVgw2NbBl/Zt+S+s+TVS6n4z6wZJPxiXF3QKInSv2kawj5dx8EPOakmJOY/L
 tIyTmYDFBecvKJHgZVgo0iW2jIYtohS3BCD89g37tSfSVLjoxALplF46K5I7/inUpFX8Dnv9Ehl
 NmU0jPUCkbG6YmF7PbHHaGfElGvjIm6dZgQYnowwXwu5XPzklEWe/QeWDA/Mkdvk5C45mJ+m+md
 BnO+N9jdaFXQKiCHD+w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfXy6/xjiwxgGnm
 3al1Jppgvl0kLcPnN+WZXPHsBZmE2UwoqTO3lGaHslXSbRSM2/G2ZUf15pbhMeO6FedviLaVrdL
 msgdEDS6YEpe42SWDbjVysyNwitOzms=
X-Authority-Analysis: v=2.4 cv=YJKvDxGx c=1 sm=1 tr=0 ts=6a33e531 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=HF2_8o9_ebfNRxPoUvYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180116
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

hvf_kernel_irqchip_override is only used within the
accel/hvf/hvf-all.c file, no need to expose the symbol.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-Id: <20260613145356.88410-1-philmd@oss.qualcomm.com>
---
 include/system/hvf_int.h | 1 -
 accel/hvf/hvf-all.c      | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index d5eaf26dda8..58fb865ebae 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -113,5 +113,4 @@ bool hvf_arch_cpu_realize(CPUState *cpu, Error **errp);
 uint32_t hvf_arch_get_default_ipa_bit_size(void);
 uint32_t hvf_arch_get_max_ipa_bit_size(void);
 
-extern bool hvf_kernel_irqchip_override;
 #endif
diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 946dbca59d0..21b9b71a6df 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -25,7 +25,7 @@
 bool hvf_allowed;
 bool hvf_kernel_irqchip;
 bool hvf_nested_virt;
-bool hvf_kernel_irqchip_override;
+static bool hvf_kernel_irqchip_override;
 
 void hvf_nested_virt_enable(bool nested_virt)
 {
-- 
2.53.0


