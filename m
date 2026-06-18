Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 183F2CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:34:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBu4-0003tB-Tw; Thu, 18 Jun 2026 08:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBu3-0003sh-7u
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:31:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBu1-0000sH-Op
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:31:26 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IAs1M61030415
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NdsW1j1wKQLo32DitEH+xMO+jVfidrCgWPVRECyXD5Y=; b=COXDPk48r5N8YkPU
 XnnnqyvuEoJ07zj8iPZMdB8OFHp2F42mQFGhJpk5X1YNioqLciEWB0oMXvEzLvdw
 MD4OsgfMmZQyjv+V09ZVZX+6VsDomyz6mvQxHSFcfcE1ErfsvgGkM8vR/h5YSsa4
 wTyYPOvYsUycA9L2Pn4IULZC+VscKT+dEYNSCbvFxNPPQL1u4lhghmNfsNphaR8Y
 k5wNnFH1q/k//qMRJRpWXHcUnZRli9n/RnXepFjT68yMzwKCcI18dqI92eJ7aaAC
 ANnTrSoKJXm3k2aqF9e9MojpzKYEiIhXOlp3sF6Zewj07h2nz6wrJiiNoomEnFaV
 dkUk3w==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev0vm3cq2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:31:24 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-966cf5e2a48so217486241.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781785883; x=1782390683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NdsW1j1wKQLo32DitEH+xMO+jVfidrCgWPVRECyXD5Y=;
 b=BAoxENTsjBt/xKcWnNGXipduwGCBjXn2APMns/cQn5ch1/WvgGraeTpMnkI6ZnG59I
 jZM3tvqU0uMDvvrkdtL9H0qV4meUYqmlaWcNtOnzwVx6qxV0TqrjmksAjc1PY/WagxGx
 LZYfYLPquhUX0dR14Gs2J75xSS3ClGq6Jihg6HaJH+/7Foy11JKmxALqGAiY1tPy6d1G
 3nJ3GLWHNF3DkcDFXsKa9hGeDRWmg2tm+BbQ5QKoWCIlMpNIUNKZJhhGd5tq4RC8L/he
 bzlnXdd6YSNoFBs30D1JgGahqSIL6ipkuMTQu2UCGegID+D+b+FiYTzE+McXAs4Xhy6I
 gleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785883; x=1782390683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NdsW1j1wKQLo32DitEH+xMO+jVfidrCgWPVRECyXD5Y=;
 b=NjCAY2B0d1f/0aM6KMxJFB8NbIY3JGAg4QKwDbUi8ZYnlepmUqyffQC9Is2xiCXHOq
 nDUi/2Izh+RfxEQCakDJZXviaK+lSiazvdwtmHu/e6BdTLD8c1Tn15KD1fJ6enwaUlIo
 nVNl1AhUx3sfbZ5a74cRb6JSYnm3EKBrHfplcxqUdbGbAIv1CsYm+KENjMuBP1QMsPJ9
 Sb91mauh7QzYk7Qu2UDfdSUvpdSFQ1ytvwiiBQnNo+Xwf4t7gUmz59XuQe1bpPOWsxFc
 FeAVU5ozXZSghN4c6UdnjVDiv2s1SIQnZXzJZfGzutOoXb8Br/dB4QDm0txa0PHjZdtg
 gVsw==
X-Gm-Message-State: AOJu0YynjjC3bkGLiy6wbYQ6PwpbxZMoUq5An6u5gv3ygO85hjNkyRPP
 p/Fo5Kv3+0opdXIGQwNvdpQud2ENV2jouWeEfGyeQhvBjzfaqLJonynLo6A20MeF9DamquU1er3
 22lbgOm5zi0QDZfZA1TXAcaLQ+RGX3MV+TuM8yy5hTkOv9uP8zUyqSIp2+CoiTilhPg==
X-Gm-Gg: AfdE7cmzGee/9u3+XGWVNjrwTRvXQYjWtm7+QI+smsSlTX0j/K2X8GWZqrTXbAXjGPN
 3Vn2AcETYer4hLajUoi9c8WT+wMwRXjEpL7QdQAsOg4Fo30FNtgWJyfzymxNjc5dOywbVkoO2uq
 epYMMq1uoIRD09grUHXoP0gVo5YFvWe7x34RHrjFbdPeijRwx+1bZHFlMSUrevHRVMVruFtJuYD
 hAlJ95rMbqMmpsbLw+SFPUE4uuPWWdgf7Apsnm0hgpfo65Mkhvg7IyXF4Y4GoeNV0/E4qT1c3/S
 U4XRglIm9ZTVM99b1CDhGZ3H0feGcNqvcKD1IFhgfCVN8OxwGQXcUE2pyEyvFsATkPpSqDFCPgv
 f7j47RItxvQCUbGsx7Y2Y82jcCuil+DEZwQ1Bh1wDIwMdjahbRn6OZBbA7/oNb0rnB9eR
X-Received: by 2002:a05:6102:f9e:b0:6cb:d562:b96a with SMTP id
 ada2fe7eead31-727c67425cfmr1852397137.14.1781785883048; 
 Thu, 18 Jun 2026 05:31:23 -0700 (PDT)
X-Received: by 2002:a05:6102:f9e:b0:6cb:d562:b96a with SMTP id
 ada2fe7eead31-727c67425cfmr1852273137.14.1781785882493; 
 Thu, 18 Jun 2026 05:31:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa9f2c0sm292813445e9.15.2026.06.18.05.31.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:31:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 24/48] target/loongarch: Remove unused
 'accel/accel-cpu-target.h' header
Date: Thu, 18 Jun 2026 14:28:01 +0200
Message-ID: <20260618122825.90331-25-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX9zSG/i8Tr4/7
 mux62NSkDDLUz8vq48AE0+SdXOm/EnSG7PSGbfJLX8rd/JxSZEVCde7nLDe3+fvzwFbYaP/JRz7
 JzEYDdt6Q7aMpTSVwC1Idi6SZu3g5bxP0sYS/c7VuzZUNDG3Bc+daaSW7S+C6p33427vKj0dqdV
 vLd2cHtqj7flmHakPmrLL9TwpquL8GGD+3NygA1U6wNMeGJKoATeOTmMQ7kOK9ByKWKvAle7X9M
 a3OvuvhtogIZWuaNnxZ8+cnvYi+zoU4Tbe3O88tL5NdWUE2n30Cw3T2+qZwQTvM/+SoZ1vOlHr8
 jKh4q9cGKEUikD6hLXSpB0eep3mBkKG+A/EjgejzxhCRwAc1u1LheRpgMsQ1x7bTHBDQ9OLURlF
 r00U7KIzKGRa8Rd2dR5HirH9/FyQgcPVYctEdq0UqO0OaHP+CcXkMv96+IemerlzkLiIrJZF64a
 5LwuQpTTOmbE60heTXA==
X-Proofpoint-ORIG-GUID: 9v7xRidYaX0hhMbdXey_9kwvJ_wLzesQ
X-Authority-Analysis: v=2.4 cv=UrRT8ewB c=1 sm=1 tr=0 ts=6a33e51c cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=06LjFAFRqyXYCbbquwsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 9v7xRidYaX0hhMbdXey_9kwvJ_wLzesQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX7sYGYfhULPcZ
 QhqUAvp7i1A2D/pORBbC3Qy7FO/dl7OqLMiTi2QfCdOPk0dtboEB8xQ8vHAD4F4NK0i0ZpMhMjk
 Od9augeIzDcCrLHJazrO3Ulbr19zGoo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180116
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

"accel/accel-cpu-target.h" is to register accelerator target
specific hooks via TypeInfo::ACCEL_CPU_NAME(), which LoongArch
TCG frontend does not. Remove as unused header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-Id: <20260529194940.97143-2-philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/loongarch/tcg/tcg_cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index 66b3f458077..f556234d9d2 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -9,7 +9,6 @@
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "qemu/plugin.h"
-#include "accel/accel-cpu-target.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/cpu-ops.h"
 #include "exec/translation-block.h"
-- 
2.53.0


