Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C606C982DE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 10:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8b9T-0004z7-7F; Mon, 21 Sep 2026 06:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8b9Q-0004y5-Rl
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 06:21:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8b9P-0002mS-8T
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 06:21:32 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68L79xsT607135
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 10:21:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 F8VypULQf6CoxAXJPWP5hZ20a7WWOtjY26BByq6lpi0=; b=M6zrsJwMQ3pCADhS
 FFs3WidpSWNXdSVlfatTRh2uPUYsh/PMmXzhzS619s8GpBK7vby1KTIFqZvt/JWt
 Wwj93sjEbcVP+7LUn44o0VvjFA9d/WyXozU0y2aktZ/HtohwZZOLjL8GK6Hdv3vL
 7RhRYOHM8f7yg5vMVn2VDjX8KpUxJPPz7Z1cgUaYcDFS/eaElwRlDwBynzXN86FA
 Q4ccDuCYfmK7Hi3rVcsRJMGwo6Kdd6bCXaDXMzW3eKPFP3g1BLz5vJkzlZmf5OuZ
 1h0KYi/1FWJTDQsOFKSnAwwU9VMI25EkUyL6HmVbqzDBSe1HtRxHTCvO1jkYMy7A
 sUfCmw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtu1eht0r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 10:21:29 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-939062ecda9so458053885a.1
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 03:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789986088; x=1790590888; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=F8VypULQf6CoxAXJPWP5hZ20a7WWOtjY26BByq6lpi0=;
 b=UTnr0M39TsVnsKFEHvIS/q17mIPxpJTBDtRtScTFY1ganf0U047Zen2p4o4Vi4Ihm4
 79NCM6WQFyVBx2Ti10gajAhxfRbAo3H/C/R6zelQlM5eUoRGfyd3ydczFdG/UABdmkwq
 1M/4GY6c4Fm4IVY8FcehyrXn+7A9ZDU2Q1+B/a3gYQ5Bew7l4z0X9+AFZTjWwH9IDp0e
 DwVFtXFCOGjBiuKlDWGtsdZR4mlTFkRmAFPJ5Acj8pNSfJSxqwQi1qXEv02qi/RBhHf4
 wPs1wWeczmiSKcRQ0dtP9mHuqzmbnQCTrYtdsxfC0qd4RPU8BrPa0UAuGRIHr+P0hev8
 rQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789986088; x=1790590888;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F8VypULQf6CoxAXJPWP5hZ20a7WWOtjY26BByq6lpi0=;
 b=UH42X5QGKrXuZ5okjVB/NGii9JWvye+MKi8ZG3LGtl178cCJnNosVxY085zK8p4THQ
 JQV8xoGzNllATs0F1WrVZL+HaqRA84NHEOvgjMWEIvnbo0mGp8q+jXDYjkMmxGHh2Lk6
 1uuvYUAvyERkuc9+xAIIOgRJqQnuxZqFRZB5ziK4on9tdiBZK0CHxn67oZhMbHDeSfx5
 ssAL4rUYf/C1jK0Akd7kzKOP1Kl13RblrI5R0mg6NwHlWRN02UjVh9Ssul/bQFg01188
 CmRqzQM7/MJhdYYuv52zjCxZ6Z7tCtxtzQQPdl/S+LXQ4glyvXMg7WwX/SLjWbelxqHB
 7SZA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwAqE13X4uFsHPOUQbwFyVZp4coyqgL82zvp8/y0M2k6eyNa2klD5RM06gnTbUSkU12Ow8nPgXq/W02@nongnu.org
X-Gm-Message-State: AFuF++kb7OApwkEnG93JqsVVRH6I+cbh3u1gWA1TJCzWIG7w2Jhrje+c
 QYNjWHXrehRYnKKPmzzppIdbTTMeP2f6HIyi1qZ8RaQ0pXvP15Ha+X7ZP/buFqAhtwZr7tubfgR
 mozvFUeN3BbqpaEItbaKhsHboD8lO12BHf3stzwSuwPBdHdnqiy0MGrOTNA==
X-Gm-Gg: AYBFou1vkkfFJruzlz2fjxM+P5FHMo3565eX3qQETkLz9DrdDpEEp+nCqgJbmt8s0OW
 8SY+v1u4kh6Rptnbms8/VuAxx6yox2ju9PQnYO73KZAa1aHxWy4KXc5hj6lC9fsrvyViaQjosXu
 Db+y9B8U+RIBlaHibW3jgm+BGHx6hTMDY6XccY0h+aE7s2sXga2DWMzinqGKDZanhq0BEOKIvAE
 skHWaM+blMPu1710QUPQ7QIRO9Cx/sUKT+VSqont5cGmbG10w5yMaKBE9j6FChASXNiTMZoCkIO
 AEft1mWiPWOrSUyx494TFtWAyFf/FNCOg80eCOgz+scE/hRZmxxzi2Kob2gKtZHiAbe3OCEgsF5
 zxe0jQ8YrZ7iuS7Ls2R5TEKDL5/0IwEW/Xg==
X-Received: by 2002:a05:620a:6481:b0:939:2d94:667c with SMTP id
 af79cd13be357-93bf55564c6mr1018619985a.21.1789986088349; 
 Mon, 21 Sep 2026 03:21:28 -0700 (PDT)
X-Received: by 2002:a05:620a:6481:b0:939:2d94:667c with SMTP id
 af79cd13be357-93bf55564c6mr1018616085a.21.1789986087953; 
 Mon, 21 Sep 2026 03:21:27 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fcd10d174sm229278455e9.11.2026.09.21.03.21.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 03:21:27 -0700 (PDT)
Message-ID: <8963eb68-7236-4874-a67b-f33b2cddfb41@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 12:21:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] accel: Change AccelOpsClass.update_guest_debug to
 void
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260917082618.1076988-1-richard.henderson@linaro.org>
 <20260917082618.1076988-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260917082618.1076988-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE0OSBTYWx0ZWRfX1t7lwFq75IcZ
 t/dg6MABAMJ5hCjWm0o540nN1z9nPP3srKiLWAJ2dZsoIuK+Zw8MysHVGq8zU3aI0BdliaVLP8+
 3pu1njZcDEFRYVlnHZPsC1lSqmi2CZw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE0OSBTYWx0ZWRfX4m91S4Wsr1Qh
 JaevxplM5H2o6erG8imyHVIwp4Kzt48w1TH9rDMUGc9aVDSzprnEFPXYpP0y+zJhVg7UM+IEhR5
 rT2vAB8J9YCJAmL2pPup7uEO6FsxTouAmq3mbSU+me1vD0E82vcOhToelh2BPFlhBdO3gQU5p+n
 hbdM6G0ml2vxLMVlBYGtMlZWXf4pOgEk63XD6mb4+vR9W+n+mK823CabnkJ6tGgg/gmeIDWUYnQ
 Rj9eRCAWiPEWHndcQ3YIC1LeB7+g5F8/UUHkklxLBD6hfy8cJit5Ai67LCsRJQ7Ra6jM6MMSbwY
 s1y4MidWAui7EBjD0ve6+MaUHN0p9OMfzDGTuw4A+Jn0QxaJDB0gBzpoP6Z+KQzT4jwVNg3schK
 JuJOnPDduZS/LDF0kGXpx/57kpnhiAfZZtgj13YwCFRbu+AgBpENsKFsKyXsTXXRIlgfvwJbgPd
 8RvDabhVd7C54OwYfEw==
X-Proofpoint-ORIG-GUID: tJZNwUmtPAieMtEIDLe-pkgMHueU2_V6
X-Proofpoint-GUID: tJZNwUmtPAieMtEIDLe-pkgMHueU2_V6
X-Authority-Analysis: v=2.4 cv=A6r5rKWG c=1 sm=1 tr=0 ts=6ab10529 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210149
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

On 17/9/26 10:26, Richard Henderson wrote:
> The return value is never used, so drop it.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/accel/accel-cpu-ops.h | 2 +-
>   include/system/hvf_int.h      | 2 +-
>   accel/hvf/hvf-accel-ops.c     | 3 +--
>   accel/kvm/kvm-accel-ops.c     | 4 ++--
>   4 files changed, 5 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

