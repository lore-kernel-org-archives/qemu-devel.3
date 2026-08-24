Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC51C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:56:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyV96-0005ct-74; Mon, 24 Aug 2026 09:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyV94-0005cc-SY
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:55:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyV92-0000Lc-Tt
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:55:26 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OCuwR63613498
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 13:55:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XUZAo6GcuLKPk2CoJqT164QTpYs/mih0dgLVX2ex7Ts=; b=OLASpdWA85RXKJ6/
 sc+4mcMWiiDI1fB7uS6kZLMGHQtKkyuQ6nKDS5/nfaEUuYtXFQLd5THJAZILTn6x
 JJEU3hFiHY1omhm9cWhYPrEl9RYMiwbfPb+zD9dKpRTUF9nWBaTI3LEn0EVaFy7S
 /5J5Wo1kPzquY8MyWy5mesB9AqTEGdyaDKnx/nMMwzUnrcGeQvqTVv5yVWkyJHxd
 OVHkxHnKx6X4M/EsufgcQwSmdSS3+68+gV6cWyGJ+CUAhAHSY9dDYwtXFx1OY2A9
 I91j16ogVHyIEQd4YQLAZAmOzrAypRQ4lJ1f3usUgsGgiOoVYyM+koQGXXHNkH+T
 CmQ7Lg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8jgk1dnm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 13:55:22 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52ce64c41efso71389661cf.3
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 06:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787579722; x=1788184522; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XUZAo6GcuLKPk2CoJqT164QTpYs/mih0dgLVX2ex7Ts=;
 b=Kc0A8+msIi/U0ZJUY++MljawlSWioJaAQqf6tFuW2qkolRLoWQkAbqmvucb+r2LTiU
 F0YRsFFFrO5o9enKQLixMrAGktZAILkM9B/GfAi9Gm/nTnEM4gFqvV4d6BrOd7i/SKTc
 qt/VBJncN2Z3FfCDeBYx9pvNMnF9Y/2EtPh8yJV7oRgtl1ghCYuZFutmN9yrsmhWaFbe
 tUnpyRIItuJACXvTrqMBEsJV4sPzGF9O3jlbEetsXkr7BZa64d84zSa4tIYs8a71efjV
 tutviTWS7zzdxjhkABWWig2xeQcvSbT8bn4S0LwW1Y/EjrknhQGZGDXaB77vhF+XAOis
 tDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787579722; x=1788184522;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XUZAo6GcuLKPk2CoJqT164QTpYs/mih0dgLVX2ex7Ts=;
 b=a73u64uCAf0TD/UMYmBvxFX2OTn0f9fDSRm8i3I7ZfrVHmGcnv9fu9mv6DAZUasLV6
 i73e9jnlt42F+C7cOm1/++immiaD0VuG0pF+O4qpEcBsZBrxi/nBYMK7zgk/EusyTfJj
 LXzzKnlbQNuhuwQB3XWgSBk026V3LodYHA1ACIlAjNcI39yzWTwqqIywIPDwEJ2/dG8X
 VetuuqE8Qp6D72d58SVypj15BpzDQhNlLgwQ+kN0kyLE8QNfWkT/DDxxt+DVcH18+dDu
 7dzpQ86Bm0MQr1J6pi3E1ZrXwUXoOiNMpF1WmYkZW5Y2R8KcF0hb+1NQ4b12af9XDDdq
 j+rQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp927jkwOkNdiguf+kWbgbN3FLxO9txSYiwdwM0IB3JZJ3c5NWdCjisbpxflhF9qMEWoNMTWnC5CaTM@nongnu.org
X-Gm-Message-State: AFuF++n2AjMY/p+e160Vy/RlqiRRA0eWnGqFbwviZNSLY31dUcjk2xEq
 MimfQJ8O462ZVzQvwgccV+1laPxhOTSj9Lhsp3A1lmN9yEb7S004V5M8fpP8tiyuHmB8qBOyUIn
 MK+d3M2ts+CuHiVl8XjkwRu0digyWS0dNP3MJ/g85ixfqVhMQSBztYAdKlw==
X-Gm-Gg: AR+sD12MHMZofpyR8gBLM86HymzSF4F9cW3lEjhglYAz+TOD6ql4MFvyQTF6DIfIXep
 7A/KZqhgmQoXlv4l+W98IrDTV/JQQVzJNQPGJchIOZbNGLsZzur9yffx0PXkyTHAr2K7xOYGv/F
 M8K5+NLQ1+VuhTYUDuqsLaRv4hvyxKP7ZXMPRWD3AVL8zX0T+Q346TXpTEBhfblUxMEEp9Me6SI
 w7itv9Jx7I+x63bxBM7FkpbixQ+KegLbRPjNnxeNg7r/xXoMIIrKohhbTdgKvvoXVFqXvNr8Sbp
 6etdVyBZzZCEDqfGEqio/3gG5QGbIgfvUnm7n2viNXzrf5AO6Dfkvi8CxUBx/H1rfTJuWsgPGAe
 KxSJIzhi11pf8tfu1uU2P+nUnlWhkgOS+MhmSXUCXXHSwcaLmCw==
X-Received: by 2002:a05:622a:1352:b0:52d:8679:ba94 with SMTP id
 d75a77b69052e-52e09aa1528mr176619151cf.0.1787579721730; 
 Mon, 24 Aug 2026 06:55:21 -0700 (PDT)
X-Received: by 2002:a05:622a:1352:b0:52d:8679:ba94 with SMTP id
 d75a77b69052e-52e09aa1528mr176618621cf.0.1787579721306; 
 Mon, 24 Aug 2026 06:55:21 -0700 (PDT)
Received: from [10.254.188.74] (102.19.205.77.rev.sfr.net. [77.205.19.102])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9c0acaesm8357253f8f.29.2026.08.24.06.55.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 06:55:20 -0700 (PDT)
Message-ID: <03dfa51a-64c2-4b79-b524-2bac3e53335c@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 15:55:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] hw/intc/arm_gicv5: Free memory in finalize
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260824102805.639072-1-peter.maydell@linaro.org>
 <20260824102805.639072-6-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260824102805.639072-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 3j0ui2uqHToUOEgD5k6xiy67rvpkBJ_S
X-Proofpoint-GUID: 3j0ui2uqHToUOEgD5k6xiy67rvpkBJ_S
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDExNiBTYWx0ZWRfX1gxbdgvKO8EY
 3JIAnCFj0vOgE8l/vSM49WU5sLg0OTsBR+NrfKkqowa9ww3o8Nw0vf3QQkJJAsHzH7/2HffvYgb
 82CTPeaBFj7ysfOql3KVHvRhwfkolXc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDExNiBTYWx0ZWRfX2PsKu0hRUV4x
 KVZyyupoOAG1iEExIN0pQc23NkL5+j3VA3UtXSACMyC/QkfqX6BGiNevjPHHFgv6gitcw7Jycw4
 snuIA/n+LuA5W2JnjpO3YdvFlsHdqoVicn4YK5tt/Y1BWwQ9/M3/PJORy9gVpJ15sIlbDUcWu6j
 EAFKhNlIcVX+Y6iBF5+As9YDd8ZZlGETELB7BshR1najVUBcnJzdDW3yufzKeCdQQZbh3rfRLJB
 x1MWFCG8zqXwLvOtHbTWwlbfcnD4I1FIhY0xya98bDuihIcfqisiwLuvDVYoM5BerdR8MINHu/3
 qgMorI1tzauA9Zf2zpefBaI54c9DCQQaZDCocQCYlqbfGR5dsPXnfPqGKfdPNSnSaq/PYRb9GXJ
 rlcltN1/EdsCkb4uOWg2Ob2IRYIfp7NhI68bDow7JHf2msCiRgzD4wP5AKRh5H/TcwTpNwQUAkG
 IyVGav1mxUdGM4QIvpQ==
X-Authority-Analysis: v=2.4 cv=KcvidwYD c=1 sm=1 tr=0 ts=6a8c4d4a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=3Njm2NGJn2tjTLCKQaqOdg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=9DJ1f-wVD1Wiv6ShGPwA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240116
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

Hi Peter,

On 24/8/26 12:28, Peter Maydell wrote:
> The GICv5 allocates memory and creates hashtables during realize and
> as part of its operation.  Free those resources in finalize.

Why not in unrealize() path?

> Since the GICv5 is created at QEMU startup and remains in existence
> for the lifetime of the process, this isn't an in-practice leak,
> only a theoretical one.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/intc/arm_gicv5.c        | 11 +++++++++++
>   hw/intc/arm_gicv5_common.c |  3 +++
>   2 files changed, 14 insertions(+)


