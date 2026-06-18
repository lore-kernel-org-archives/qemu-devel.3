Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35B4CD98F7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:29:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBrO-0007uj-AV; Thu, 18 Jun 2026 08:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBrM-0007uL-Ne
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:28:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBrL-0007VH-4P
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:28:40 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IArkNG2611807
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 T+hQfWMaE4Fxk19oZDF8GhfYZCcd5CNajzpgcma8zaw=; b=PkJ+d0dnuDxN0Oh9
 9K9Ry5ic9iLMoRV4lSFohFuary1fb2aWZ2ySNsqLwn1OdTwpVbZSUcgfJSa9nIkB
 IJw3VWdejPT6rSv/J1KBKDBililn/2Y1JUHtMJQi8husAQjZuWpFxl1WPAMyvl4t
 5QpvZFb+P0Jyk/7pfwjE747kVtb+Ob19Wsfi4Jz/YEVHKYQlw2e84OMkq3H/Ew9u
 p4LVleO6uDtdqS27M2BFx1nVYqCQeok9Qze3cUNzhyNc1YkH22xIhYsbO9z9NOlJ
 dYCwohxqwG7Qm2RD6A1Ymqc1ZyuwujUTPoz3HalPqJxEVMl/WmGrG6YOF/9O37Vo
 Kf7ygQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euw9vmubu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:28:36 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8ce9e6cf3aeso21842446d6.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781785716; x=1782390516; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T+hQfWMaE4Fxk19oZDF8GhfYZCcd5CNajzpgcma8zaw=;
 b=TTDG4hvM0Pk7VWYzhvau0lXS6GL3HgNPJbULNsiO5yju6bW/xxCrUv74zJjHW91J0o
 5fOVwwV3AVUAsssHYhRpxnfwfc4RqylLPgVH2UqR3aoH95JrtzjXrgHHQ8A1HYJOPHv9
 GCMb8/Vw1Pda5N3YlPRBeZH5K4+TwyEyvNa9KayHJygOlZhyLFVOrfBbNiQ1hhXVM2yA
 W75bQzwRb5qpRH37cc5XURhdc/vV9zwsxFwLByvm5iE6AbwzR8Z5ESzayz3C5dqvhL2r
 kCu6xBe4lvuoxEfikPSi2teR+R9531cpktWWpj+QtS32MUzT+OJ/3SoA9OO8WiNbe5lQ
 8/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785716; x=1782390516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=T+hQfWMaE4Fxk19oZDF8GhfYZCcd5CNajzpgcma8zaw=;
 b=NQSnk9m9K6wm8TPiSmbWg6aWJC4lN83WgOVdpvBQ4A0zLmy28ht3qh4JaK8bmpjD87
 EAuSHzo4MjqKR48xxyXTDatZOtHb8GhNuyiSDh7yio4C5VLtuKk4eDD3CHiXHjFaqTkS
 b6hqERWumkyis47GeVLSZjFTzUtU80xt5jm5QIKz2n82vC6Xm45o5owFdsqErmtD2uC4
 QdZwRvhjBO8+gz8wYqgcCFbFZbf/nHSIUWOfdFPaxusztNI8EwRKefbpxktp6YxDU/wq
 Hup0e1LcV1njT0IxbbVdZrHQFuWwgwdX+4uhiCWY61EeprZbi4zdMr3eRxptW/N+k1xm
 PHxw==
X-Gm-Message-State: AOJu0YzRjL1lWeD9FvXGDoR1TxQef7TvrPzpNYfDtw4Eajw755bmI19A
 HVxtMdMb/EYJWC1dTGmz2QAfGgOCNsW+owDmIcAfcGJUEdTfkDW3/hCt7E4GEohoja5Skb/JxOZ
 xUZhblQBWkP4E9IuG1vUXuGifTRbZ2Q4UaE+/aqktLEG7KKyfLsWh1CpWIOchGAkOqQ==
X-Gm-Gg: AfdE7cmDIYVrATtyYt7wozjRzYwVwNZ/ajgn86oov0ZCkO6SnHPNPQ5EVy0FNTSh3H1
 85dCT5Gcqy7AHuGGUNIJuteWw/vLsz1U3I8YECmXqgHwkkWEpwRtk3Hu3PskopqhuJdygWl511+
 MiQdrB+wl9V8LVfsrEdd4qvfrMtp7Lkuw8EyK1Vxy+oZBka1gsveysGNZC8yxPJuq9CmsYkT4P3
 906gicmE/B6ACsWhKT0hUxcwzK4q2OxUiw7MX2UMjBWTXQ3LWWTifcTCUSfpXoGevk+FEtKUzLg
 bYyZ4PuE1o/eLpyAXeqNWCMZrRg+abrnu4YiF5/vRbkBwHLDfrf4qhjkIsNJiEkLBmNM0HaJx6J
 rq9K/o3k3kX8M+7+Jh8UGYsSSRne4wBBvicIHvV1s4uKBGzSx26eLryn1C5V01qqUgFfJ
X-Received: by 2002:a05:620a:170e:b0:915:9125:e652 with SMTP id
 af79cd13be357-91f28f632a5mr504593785a.48.1781785715837; 
 Thu, 18 Jun 2026 05:28:35 -0700 (PDT)
X-Received: by 2002:a05:620a:170e:b0:915:9125:e652 with SMTP id
 af79cd13be357-91f28f632a5mr504589885a.48.1781785715377; 
 Thu, 18 Jun 2026 05:28:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2e592csm65802475f8f.36.2026.06.18.05.28.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:28:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/48] system/cpu: Reset vCPU %exception_index before resuming
 it
Date: Thu, 18 Jun 2026 14:27:38 +0200
Message-ID: <20260618122825.90331-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FLm5jfjMjlJKvdK5UG85D2LOzRCZBLTf
X-Proofpoint-GUID: FLm5jfjMjlJKvdK5UG85D2LOzRCZBLTf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfXw/MhZrrqzvJl
 EaOfbW34jA9dmqgkz8LWq+hgbpspADZWs/jT5SKEU91AlNPsUy+lMrNuG/z6vBPP8GPwpB3zrKC
 YbBw5pkT7PHiDyx6B+UGpFaF1iHEQYeUSyIpX/l2zlRSvh4TjMWP6PpvNGIh4wTChhnNNnDI8iI
 lpnqBgKL5skYM7yXfJmMYFr5J4ue3/zg51ZNHbvG2RXPQ8SDMW89V1vcjlgqbe/PbwSWOjOn1um
 mx6IzKgJhgbe3P9G7O3STRK2hMaXgvEMhyNmET8BSEtd67dXiAgEGTPQy231R63KJZtgB+vsxmM
 WTqNTeT6f0WEImpKBN9pJUmNdtP+pTV3rA6nGipGvPtVn4Rfwob8+V2uxnJBpM1TtGuG4UGWLjj
 p6RMZtg3VgUj69JwBx5Yp1Fo6YP7qraOYvOiu88UUz73v3GnMUPxcK/Focpav6l02+JNUHbKtte
 Ck8YChBUPluVWot4hWQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX00wzN0AqgySK
 aBAXvtwPrCCII94D9rUFSWk0+qfkm6AwVKlry+WgiHoxSf4ir0e7jzhxqRsSfHN1LuNmrr8RUBy
 0LxW6iOEI+iLmmH5oH2UdJ+dIVqQK9A=
X-Authority-Analysis: v=2.4 cv=YJKvDxGx c=1 sm=1 tr=0 ts=6a33e474 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=_dWe14mudiqGaa_fN08A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=cvBusfyB2V15izCimMoJ:22
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260423170229.64655-8-philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 system/cpus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/system/cpus.c b/system/cpus.c
index bded87feb1c..b4c7f94332d 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -621,6 +621,7 @@ void cpu_pause(CPUState *cpu)
 
 void cpu_resume(CPUState *cpu)
 {
+    cpu->exception_index = -1;
     cpu->stop = false;
     cpu->stopped = false;
     qemu_cpu_kick(cpu);
-- 
2.53.0


