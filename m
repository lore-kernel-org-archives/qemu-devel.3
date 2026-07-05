Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED532C43602
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 22:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgUt5-0002vu-FB; Sun, 05 Jul 2026 18:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUt4-0002si-3g
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 18:00:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUt0-0000rn-RO
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 18:00:29 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665LxKMA2839029
 for <qemu-devel@nongnu.org>; Sun, 5 Jul 2026 22:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Yi0iSVj4LIkP2DPM2Oyar3HIg3gxuDuywavv3adUmn4=; b=ABirK62iQJ38rkaz
 KWH461iCYmKzvuFqOv8X9WnamiIYbQv4/sWCHK17gqIQ5AA4iyyv54hS6tjaMg06
 NJazBAUcCqCT6+nV+xfU5rQoSjLx5y4h2+IGEynpxKmxGMiQRB5nPxp99HpKzhsb
 DF9x25N5FagyqXmXDn0T8f3Xl6vmOYlay2RonfM2R4awQm58HKbGtUveQEfo/jNb
 zxy1Z42Lq3qaUIHCJltcTjHFyTJuYGlm2KK3XPeUtbDud7qLxDDrkgCHPnHxQQD5
 ukqidGTEYEPmj47UGNNr6OBIR01bfDlSCejNux8rmYbqw6IOMrol3VWFDcZOKcGu
 TMo9ug==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6qvgutuj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 22:00:15 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e6ed4fe99so408528485a.0
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 15:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783288814; x=1783893614; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yi0iSVj4LIkP2DPM2Oyar3HIg3gxuDuywavv3adUmn4=;
 b=Oxj7xsDI1KF7WA+p8/biqUJNtPWMg1RjOqPSG9YJwqkyfGMkVPKfW9YVfBdotL+Kq9
 9q8sFyP/LjQYMWZKoHTgj/Ih1LsYjb1VADJ/B0cQEmKmNUsp2dBd37vCA6IVQlY98jhL
 T1J3XA5IfDRXt6Dzw3PCnh6UBEEpc3XnnAx0WgRvbZjqfzWPpdq8Bq2zyUXEfG7qQz7z
 fJt42slMdnArdrym/FecwLJb8IxrEGzxYm2OJ6C/gUzCoTRGDUsMNBBvEyn7XW8PF8pE
 N9H1rGP9m9DxY5/YNvlR20X6lDpXOnEg76c9GFQh1xb8YBURkmPijfB91b0dzyAoQIzy
 bAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783288814; x=1783893614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Yi0iSVj4LIkP2DPM2Oyar3HIg3gxuDuywavv3adUmn4=;
 b=aFdO7859a0a6XDTXuxFFnzLveo7gRK4TOhzK8R+TfxM+dGwmuFVOtq62qtIfBXBm7l
 mPWlqrX//PjZEM8w8zqQG/lF1j1CMG9Ntbv9dTy/U471fjOkKMvWZ/XTXtFO6RRnXFHp
 A3E8SmokkhkSzM7WxyoWdaTNV954XflCVNtjiYG9zccgdgcmq9EFhZJcAhDnh7M1kd2G
 mweUXkPxchmMrMcRjkQi4qY1EgT6yY/KI6D5hat3R4sucywRLjDIBOJ/lYby5YsTKsc+
 IwymqtZXTbr9KD5FYH2RvvuRwLqD6qmQrIxvJHjI+I6UW5IN9JdEKK8PFpzEs2T3DGnX
 nmPg==
X-Gm-Message-State: AOJu0Yz+43VyP/GY71EwyIWUpHdFQPNYkAOX+gzAspl9TZQj89cEI4jj
 Pjhz4nLNoGFduR9a+8/oZouUfKIxUomrWiu1mRJp9iXk+Aggj1xQsUyDszSyLuIuE5diRXJZFNo
 tzJvHLxm8zUF9z26dxj6OmGtuhUc36/sKD5gjlojUu5/WQet+sd32vwS7KDgfWIWp/Q==
X-Gm-Gg: AfdE7ckkQIXlojE5AIRLtcb7jp+TO4ZhDQVwPHFEYB3mJEOYPE835+7Leu1If6bFGZ2
 m2mHox1QVWAdCRJ2F8ujHkF0nrvFpxXyBZkahi5yD/+VyuS82bQSCSlnElzF98IsXcJRdwKznNE
 hl2sjyrIccAeFqoFt3EG7nQpgaWsZ472No6v6+IJ5UY3ThdvajaCvbc4CQsCPfxeBc2xenRBu5z
 G8GP5qzyPOnS3PXvMbjF1WBRg49ZX1Tz1S5wLuPaitGg5wfqWFTaKdN6FwwfuYCyGnggXv97w/7
 8OK1eXdzST+i3EF1VtMrgxxGej9gzwtByxVxtHzAgftS58JJu2xswrmZkFcbF1Awjk9oWrrb9sK
 fya3EAdOwXk6iuvW5lXsA/moRVn3cgCeWWArg1nJsb3d7+fgV8EyJmw==
X-Received: by 2002:a05:620a:838d:b0:92a:e474:92eb with SMTP id
 af79cd13be357-92e9a475b7dmr1092064885a.55.1783288814132; 
 Sun, 05 Jul 2026 15:00:14 -0700 (PDT)
X-Received: by 2002:a05:620a:838d:b0:92a:e474:92eb with SMTP id
 af79cd13be357-92e9a475b7dmr1092056885a.55.1783288813481; 
 Sun, 05 Jul 2026 15:00:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ccd9d607sm294368145e9.2.2026.07.05.15.00.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Jul 2026 15:00:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, alex.bennee@linaro.org,
 qemu-s390x@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 21/32] accel: Remove unnecessary 'inline' qualifier in
 remove_all_breakpoints
Date: Sun,  5 Jul 2026 23:57:17 +0200
Message-ID: <20260705215729.62196-22-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705215729.62196-1-philmd@oss.qualcomm.com>
References: <20260705215729.62196-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VvoTxe2n c=1 sm=1 tr=0 ts=6a4ad3ef cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Ucb4Co1tYGy3ov5cU_AA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: uTAgYTDPEEwC_09QgqR8jR3PTEtOLsyV
X-Proofpoint-GUID: uTAgYTDPEEwC_09QgqR8jR3PTEtOLsyV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIzOCBTYWx0ZWRfX8kCeXA26K5BN
 hZZ7Ou0KTBGigtK1fomgO2owggs6l6bFJWfW3kx7IPszqAvG2oGIa+WZa9kxxx94e0r1GszstEt
 TOIdeQ/yD3FRfEJ0+aD9WVINj5wnq6U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIzOCBTYWx0ZWRfXy82UR+qjwsrn
 YREpbKekXExW2iSwVpiz7aGA2dh/7SaWkqzI9xMTK8vyBZAozlz0zHfc47+N9GBwQNmxkFDo/lF
 BmLqM3nFdKTxtfq4MKNkasax7fA+2AqLS7QXZkl3awflcUL+60yiV66Vzzftcl1kNDd3TDGCkiE
 XqSvisq+/+pFm4+Z3x73+XiUZ6DAMu1WADqfdeGUUQZwxAEnSSRWL8v2X7+3KzukvKNz1nR6sLc
 cZZSPOiTSoxu9xa2Ahr9XYiVSfoscrzdFw3QCrAMsOp6yjQOpvzn0rj9g1yT0eDQJz4nc/sS64p
 rUxXn7x8kkph/pufIdAEzVL/1mqH8uC7DoEciiVJD9WD9JyVmGklONzA+saAmffFBoFpsW8uD+c
 lLG2Jj7Bfel5ZWKP1+LUWD7gAcFasH6bWIENKgSAri688082t6hqmC325CCbPQzdp78Xym1uiD7
 wFBiqCflQugYQ1JOIFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050238
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-accel-ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 26d34c72d9a..c54acc770e3 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -188,7 +188,7 @@ static int tcg_remove_breakpoint(CPUState *cs, int type, vaddr addr, vaddr len)
     }
 }
 
-static inline void tcg_remove_all_breakpoints(CPUState *cpu)
+static void tcg_remove_all_breakpoints(CPUState *cpu)
 {
     cpu_breakpoint_remove_all(cpu, BP_GDB);
     cpu_watchpoint_remove_all(cpu, BP_GDB);
-- 
2.53.0


