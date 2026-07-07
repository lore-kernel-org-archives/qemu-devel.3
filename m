Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592C7C43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5eM-0003rK-Er; Tue, 07 Jul 2026 09:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5cg-00028F-MX
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:14:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5ce-0000Vj-GB
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:14:02 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C8bQh3783420
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 13:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RQh/W1tZuVZLWeiduVP+SBt30t3Myjf8tP8MaEC5ijY=; b=gB5hLw5KcWC4gSL7
 HcgDLrNPtTOuj4Xb8FOhRuSwyEs0p9M5ZPpMYI2TTkUg2COe2faGEpgFTpLx/CbX
 g8GmTt4v60tSDiE2yrH5Z4/6WBUNz3veEB2AE7dbGso57QqN45ZAKy3cW4KO6Sik
 o2ErywRUggYw9TkWRyb7o6pMBeyMo+Yu5EW1gUKHSOa67v6BljgAtxsrm5mjaAKN
 uyjQx7eHoNrGR5PZarXJ81NctBnvIy8VY64yQqfJXHTc2rGfBPGOzPANxK26pv79
 z1nHSmz41BZx2rrSvrBbpFJXvHpT3dLjHxJFDemI0HoVZkZlSkADESPmiLZ7vEqr
 negmUw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8w11sbnu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:13:58 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1d137a68so98704411cf.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783430038; x=1784034838; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RQh/W1tZuVZLWeiduVP+SBt30t3Myjf8tP8MaEC5ijY=;
 b=W/uNz3zqZXUsB5VqxuGCuYQh3ELMURLkVbvLA7KvA5c7Krg0tLlOGfNsOe3Wprrzu/
 e4bftwt1BY1+PHKak5n75k/1bZmiEt4Pw0dv96J9l89U1E9mHbjqpIVHvSQPBtihi7Cn
 SO953LwBqkfQR/SO1RGidexfxrKTWTuzifKo9doFWclgIP7XlnAHhvAbfRG6KzDbqajr
 PF3nM0/sIHwAwqmKfuzG0rVZ0FSIAfSpwu89Mc9ZDzoqZGFdCUez0nbBUgsj433yqMtL
 iPvlgjfNKAP+s4hd7EJfP+xoayxaIGlIESPCIbERhxVMkY5BDPlN4cj4OBYAddZc6KRo
 QsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783430038; x=1784034838;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RQh/W1tZuVZLWeiduVP+SBt30t3Myjf8tP8MaEC5ijY=;
 b=WVGEVPQ6xTApq9Xr4WlKAumj/vIZiF+6ifgPrrzcu0cbkfF/yJ2l3bTvmuET6yJjnM
 WqF1xCIZJy73eIfdJQazwAlhrZY1JhrT1BWKzslUbfHsaHmNznwDcseDCtHN0Rc9EEAo
 hEaKweNf+WAEEf2Tf+5o661orQqhzC8APyPqkSmKoBzbUch8yzmiOJvzsvt0x3KraX3A
 JH3FIB3E3Ryp01T/RsmcSNnti+SCl8VlSpGep/xmv6r0KV96PIVmfDtKhrdKHO7qoAZf
 KpDeH1fa5pLMgSD5pAJ0orU4ffi9VMTXMii18jyGy//+3toza9fyTG0G2/d0gLnG2a9G
 YeTg==
X-Gm-Message-State: AOJu0YzqgRN9L+4bvrGM2SSIwG/cceZSsqpVFMLXUFCltuMlUP9trvFg
 BuXuvFhHnDdY2EN8xt9MmGbDyLSdhj6SVLUek1R3kE4ZyZYpgs3J8wGxVq3aeIXDZ4QCRJQzxKq
 9pdRqFyBtiofOp68ecJmsJhBEWaBUxzx7qJj+aLVihb2bUJQBRsbJrjni1rsQswaLWg==
X-Gm-Gg: AfdE7cnkxb+aImeWdOMa+4iBGEt6A+qBhpTtLKXGC4cz46iZmO0EB8Dn7D3hlCUpJAw
 JlukTbX0P02ZLjNqCsanKM6nIFibOd7l2uRupIsMMMc07pmFqGQyPZSBb7SmJhqLrSzfqVqimUI
 3TF+mfZUoU97UQj0w+ydmKmcB7T4x8PBR9nnGpdtGizf5Fnj+SOVYsa1Qds7GjK1SUVgcL/+zGG
 gKR9xC0ec3DsinnM6+R6DXuPeBsC5v8RlO5BjtdJl4eJTVjazFbdK+PKbWkhNFysfaGkR9R1Lqr
 49AgY6LQeks5ITSdagnAqPRPMreF/WvUtFn36HAqVJN+s3yzXY8E2G0+kQns5ppIXTJal1U+9Vh
 vwmL76th2mgDrQ6Tod2GyZK7kjhtXcTYFK1gNxEkVRtY3UiDh50pC12K/naVKoAZfiZHe
X-Received: by 2002:ac8:7fce:0:b0:51a:896c:9abc with SMTP id
 d75a77b69052e-51c747d762dmr53201951cf.30.1783430037730; 
 Tue, 07 Jul 2026 06:13:57 -0700 (PDT)
X-Received: by 2002:ac8:7fce:0:b0:51a:896c:9abc with SMTP id
 d75a77b69052e-51c747d762dmr53201501cf.30.1783430037264; 
 Tue, 07 Jul 2026 06:13:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15ada023acsm135108166b.54.2026.07.07.06.13.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 06:13:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/32] hw/hyperv: Avoid crash if hyperv_find_cpu() passed
 invalid vp_index
Date: Tue,  7 Jul 2026 15:12:03 +0200
Message-ID: <20260707131223.51505-14-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707131223.51505-1-philmd@oss.qualcomm.com>
References: <20260707131223.51505-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DMe/JSNb c=1 sm=1 tr=0 ts=6a4cfb96 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=p0WdMEafAAAA:8 a=KKAkSRfTAAAA:8 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=EUspDBNiAAAA:8 a=HphOO7avrm-i6LmdoIMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: RsnIOA671stoUbaNQOg9aZVo-Vzy57iA
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX5L2RWmHY7vRb
 kd1VimxCBfoX5nmnC/1DW3sa4Qn1WRV1QmoJN3ZOWpxr3o5h3P+sROE11H5JUe4wD1gWlNWhmpT
 yW9CJGdADJFUhLYQIL++coxgPamv4ic=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX4ZwJ4UWcp+/N
 y6J7QFndADpRbTTCGs3rVdckov8QA3i8qfqVUy1Ved5ZTMlobsx93BYCESw6piefWuevT2Ci+Qn
 bvSlpbAgEUFGDY0a+6AQDQd1zhuni7zcwEA8OhNq++dJUQJKP6SAx6kd6CEZEPSnxHOiTRutEqp
 OjPJLCDWrhpT0qbF8YEzMkuAv5x+Jo31rYhHduFNa8mqRDawGqMOAbD3sGjIKYPWuk5n+ui5VsP
 SdkT0pft4ir3LqHGDE7iB/70AhE/vUVt/B1fzeY9gjAmKxzM+Pn6bhvA/0Nui9dShAO5GlRxFiZ
 TfevBcMWp1rIlSy8B/rDKxFgSVq708vl2oouw/nNZEZpe75mw+Abg3ke9Nt/iHzWVHcWQKqpuCn
 tme9mtHkM5VUYYfT/rrxY2ly3MjgikWDb5fKrGcdc51hVesJNJjGSg+IfLLhz00iU2USyyES0tf
 RD4dbTgxoBvF57AS7TQ==
X-Proofpoint-ORIG-GUID: RsnIOA671stoUbaNQOg9aZVo-Vzy57iA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070129
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

From: Peter Maydell <peter.maydell@linaro.org>

The hyperv_find_cpu() function finds a CPU from a CPU index; this is
basically a wrapper around qemu_get_cpu().  It is allowed to fail, in
which case it returns NULL, which its caller handles.  However, it
includes an assertion check which accidentally assumes the CPU
pointer is non-NULL.

We could assert only if cs != NULL, but the assertion here is not
doing anything interesting -- hyperv_vp_index() is a trivial wrapper
returning cs->cpu_index, so this is effectively asserting that
qemu_get_cpu() did what it claims to do, i.e.  returned us the CPU
matching the index we gave it.  qemu_get_cpu() is a simple "iterate
through list and find matching CPU" which is unlikely to be buggy,
and we don't feel the need to sanity-check it in any of our other
many uses of it.  Drop the assertion entirely.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3568
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260630084855.2319838-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/hyperv/hyperv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index 4d900327857..900ff80213d 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -237,9 +237,7 @@ struct HvSintRoute {
 
 static CPUState *hyperv_find_vcpu(uint32_t vp_index)
 {
-    CPUState *cs = qemu_get_cpu(vp_index);
-    assert(hyperv_vp_index(cs) == vp_index);
-    return cs;
+    return qemu_get_cpu(vp_index);
 }
 
 /*
-- 
2.53.0


