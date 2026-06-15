Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B30FCD98DE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 11:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ5th-0007tf-7c; Mon, 15 Jun 2026 07:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZ5tf-0007oW-K5
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 07:54:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZ5td-0007K2-Tm
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 07:54:31 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FAoWgk3986660
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 11:54:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VQvB5kFtqmEaOkyki9927Tea8lRdNOqyDVILnkA59XY=; b=B133J0VOf2R4Dr09
 GmZBsXjAjHPv/HMUz6S62yGR9L+2JgQD0C8ghwsqHljb48nrWpQnp8D6/+R/+jcq
 DHRH7XxB/6mTlHQ6wfsf1UsvasJysPvURqmqQd1iL7pe3QMTXCLr0ZgFg12yExzt
 b92uoH+ydHUZPTp1Xk3BIFoZWmqGcrKvwWVCxjmoH8PvSMw96Ip1phc1+j+40G4P
 NANpOHl0gBiYHe874nu5uxRCyIlSBIuTa+R4cuUvTFlU7Rhm5eBmfDcANpoOIl8d
 Lj0HwXTgynrnK3Jio3m0gXT2KgPPa09W1ZAd6sWEmUvxJmtrBN7seMe1vfWbOlwl
 bH3Ajg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etew0ggfy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 11:54:27 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-915b3587972so302302185a.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 04:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781524467; x=1782129267; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VQvB5kFtqmEaOkyki9927Tea8lRdNOqyDVILnkA59XY=;
 b=W26WVLnp6W4N7iHsD4kkmZf6cAKG/K+YKs++Jgj4joWvt6hCbBsA42o7u6zdY3v6Cd
 dPJrFB0iV+9R2a2B7hPT4HJ0CvJtzW5zktB7cjIHIInembgt5Vk7gSwgnIfudC6HzkXc
 U2NGreQ52cuzDsBc7BFWhz/LKLxrDcW4r1jd3nK225V3JTGEQmYQfyJSBV48MfQoX90/
 ujOM3+Jg9Qsj3E6Zk6ocX2pGdIwbH4dNnde/jOq0xDIAkjj4Ct0bMOGLdeG5Il6lLosn
 wifckP0ce68iGX43vkEpnj30FIkL1e2w2FJEKTkPp5tJYV11UQrMU+rNaZE7HVBmtwWM
 3eTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781524467; x=1782129267;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VQvB5kFtqmEaOkyki9927Tea8lRdNOqyDVILnkA59XY=;
 b=Sxq0wTcAA15uklBVJ69YsFNwh1p0d7Km8XXV3ZrwyCwPRnDD66QZQJesr2SkpzI46K
 6l2OcZ2K5kBTe9cm+UeNT2t8mD7W2DuCOHHDOZEx9/qJV1LSk7kMIZVtdVVtNCiXNpcZ
 kjuYKP19qHeJi0pglI6TkFXVoWfPVoo1PlxlXn8ITzFKf/vRWdcKgD4J8/dhEx8wJbBC
 4IkzLmfr4Q6crfkU3Rss7VSZ4ULFa+fiayZJqOvmcQIu6xh8X9ATM8J7ORwSEznWUF3h
 1W0oT5avFlqa8pPThmGbfjuu+hiBm5hafO7As0+3h6Z5dWxXzY3hVtA9+FKa2jyBl/XL
 3DWQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Vn/NHrY6wj7UQ+Dfg43q1bel9QAEiZ7uviQ2rMFJZcDmYDi4Vtc527eAb0ESh7pI1fr3ET4xPIG/E@nongnu.org
X-Gm-Message-State: AOJu0Yw8WMCMOYkvDMGfULnEndoNtIDZ14m3IhDey8KgIV3EXT6ZQjUu
 u7478/fe/6nhCxdH9NMpttEyLbcVqBB+wYcKCG1BaxtOqJJMfvSFqGAJ3WEGiYnecM495oLazWi
 jtPtCHTKhwLkenJRUOkttfU6dLJbl/+tdRVP9IrI8Oio/XWiom44jgNYN9g==
X-Gm-Gg: Acq92OFtgBh3kL8KjKPM/2/kR1ZMcBw9LWLGzPFFibQREdl0HwYWmw6pghKCiGX4q8c
 rKtU/hQqxw2h1AQ6unAzK9iChqxdYVBTDFZloRLPjXhgYqgFy7jjfRo6PA335DdRfxflmZhgm6h
 4rAUCOi2DkBdWpvwV940V4qRK9rPDXgin6k+daOcYArXwQxzno5Ltya4HIVAQ+fRMvGYyWmHfDG
 n5fIr518Toic+gUpu54R4Dt6ij9yD3D0Hezf+CAYJUraG8o5aytbcsJNgr5TwWojXdNlYFPHH2u
 DKlmcFv7fg5/3WtjPpBUL+Mj745J0Jdq6Z8iFtgY7ha/CN0vbTsokkX4elli4/5tgudJBzMQTLf
 b0O5GX1bq4Egm4Eud9oOkt7YpmFypGjWstHmZibTOPqCz6nvKQQMxQPxh3O/Djl10WHRfogCK
X-Received: by 2002:a05:620a:3198:b0:90e:2f56:2f0b with SMTP id
 af79cd13be357-9161bac7a1bmr2262417785a.7.1781524466753; 
 Mon, 15 Jun 2026 04:54:26 -0700 (PDT)
X-Received: by 2002:a05:620a:3198:b0:90e:2f56:2f0b with SMTP id
 af79cd13be357-9161bac7a1bmr2262413685a.7.1781524466299; 
 Mon, 15 Jun 2026 04:54:26 -0700 (PDT)
Received: from [192.168.69.214] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfdb44209f0sm459053666b.6.2026.06.15.04.54.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 04:54:25 -0700 (PDT)
Message-ID: <53d0e9d2-71ab-461e-9936-86a3f6202dde@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 13:54:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] hw/intc/gicv5: Define and use GICV5_PENDING_IRQ_NONE
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260615105029.2898872-1-peter.maydell@linaro.org>
 <20260615105029.2898872-6-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260615105029.2898872-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEyNiBTYWx0ZWRfXxWc5ZiLfuRkM
 reF1z3sidpMS5JKtgSVRGO2Gm+Zq/gDUhj8YjtwqAXXTHmok8Awrmn1N0m4Ws0NO0n9T5XpW+/j
 F5ltyhbnlvaU0T34HEaEnJrj6tAuXjw=
X-Authority-Analysis: v=2.4 cv=QLlYgALL c=1 sm=1 tr=0 ts=6a2fe7f3 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEyNiBTYWx0ZWRfX2BOMC+PwGSO5
 p1Yl/2ZigeBmR+gYmoIRHoRa98VVdE9mol72pDFBhHKi9WNeacxMF/LaNHuwISGKMIWsIy31uhs
 ESZrqF6fYafQGd1OpINJ+qnLvpsdhvOerUjXbEkrhaL1eh9bxe9QRc3w9RFjBKcFpu4ClaO49ey
 oj7fhUECwBknfNbshbQQ0FGbKvnq+xpZj84VvHK2kb8p9cRpwY0TJWMdJeRcFkpIw7MLyixKzit
 EMKzCny6Vc04jijY+AorQGnGRfj/n2iyXLKuMvpSYLjg+3NVUcICop+Ul0XUKT5z2BiiTBt0Odb
 a/eGI0hybXWF7gWgMw8ofswKb4pf0zkrUp49LD8nYuA+uWslnA79enH/evV93cvU8lhOFmSTYQs
 PezZphPd43GLZr+wZLd5AqpBSuwAyM5bm7x5ROEU68JsPF5tKd6dSPvYYMOyM0SerRYserKsKxo
 yrNyDNBSuTKqtpXSGSA==
X-Proofpoint-GUID: MlfHzl7b4rPkvfiJUA8hBj0wQeLgum9Z
X-Proofpoint-ORIG-GUID: MlfHzl7b4rPkvfiJUA8hBj0wQeLgum9Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150126
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

On 15/6/26 12:50, Peter Maydell wrote:
> The GICv5PendingIrq struct representation of "there is no pending
> interrupt" sets the prio field to PRIO_IDLE, and generally to avoid
> confusion we also set the intid to 0.  We want to return this value
> or initialize some variable to it in several places in the GICv5
> implementation, and the support for the virtual interrupt domain
> introduces more.
> 
> Define a convenience macro for this special-case struct value, and
> use it instead of opencoding either the structure initializer or
> explicit assignment to the two fields.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/intc/arm_gicv5.c               | 6 ++----
>   include/hw/intc/arm_gicv5_types.h | 4 ++++
>   target/arm/tcg/gicv5-cpuif.c      | 7 +++----
>   3 files changed, 9 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

