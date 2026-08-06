Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9194EC5AC7C
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws2I1-0003q7-LP; Thu, 06 Aug 2026 13:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1ws2Hz-0003pM-S6
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 13:53:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1ws2Hy-0004fU-Cs
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 13:53:55 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 676HGuwE3771162
 for <qemu-devel@nongnu.org>; Thu, 6 Aug 2026 17:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yGHvoqTOhRDcnwOU8vntyewl53aBxmex3N/gGFjzrUk=; b=Wh6UqUp49fjF0QWA
 3XNj3X84OYn0pC+ApsMFTs2+7Hk7gc6/IOfVgrFvOl1ZfTCm0U2+F6XHb+ieBeFx
 D4DpCRmgSbyhv0P18EP2LFlKNISEX5Oru4sxwHVEHZ5hUDt6P/wKXvIs4Gxv+sbl
 Bej3ErtMkLg4lcLsWWSKXQkAJ4YjMN9wkrlexO3E6FoRp9witJxEDmz5qj/OtlLR
 aFfsBGWGqtl8ftxFD246F/65g5loEqiVzlCoGEuRPNQOy/Nl+Od7wuEkP75eSznU
 wfIb6bvTnpJfesyRlCST+r76iAWl9zX6a4PTcBYMccBdxe8QrcTGrJ8yWm8INBw+
 LiosEQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvsvd1wme-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 17:53:52 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51bec738909so24269271cf.1
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 10:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786038831; x=1786643631; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yGHvoqTOhRDcnwOU8vntyewl53aBxmex3N/gGFjzrUk=;
 b=g9OVbXKPJ/7ClySrdTcoDL0TiWFkJvuUNMsNnH+ev3YGhklr1SpxZJT3MmI3Gmu5lW
 kwxMDlZqE2E+LQhdy4CJr1ATR31Dyr9wXPAyFJpkoYzCycdMeWFBuPDXb3UCc4eXlzOy
 W3aX1c73/EUfVZ11VxHaixOf1QrPNK7BxfbB5g69NnuB/aJ5kmqUG4LMznHn2iNIQGV7
 RU0wZWW/6SYMZe2IIVA7gZeYdil79sZGWZr526E7jmYJpE5ZZJK+YONYjXDSxt9raIii
 R7EV40VyvCPE7VS4V6aJjkMOFUv3BPOdJTsSaPxhk3lBbwuC7C2aHm/w4jHR0DiH1CzD
 8BDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786038831; x=1786643631;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yGHvoqTOhRDcnwOU8vntyewl53aBxmex3N/gGFjzrUk=;
 b=gIjxjiQ0pghLqfMQMtTJtiiQ5LbNOStOcHvUaKE0Y5UQo0FRfJ9BRkW5h71Ej7F+Ec
 2vp/DuevTWirnGL4gVCU3V+Tr1UAgcKLcMZyoi6ea1Ec5Y9ys8L6Frl5H/qAbgy3gavN
 IUZlIIH5Wcwbp0DSC8VynbPtpS9QL1nXX8UZbgL/tpGPUu7/jrs9OFOlpyavGrAn8YB4
 47pqkePrQzskCRHns3+VDrKSaDJ/GSA77gRl6c09wRDjBhH1uN2lKQtYuDBhRWUKMpJp
 lHIi8G/yVQy6OGCU3LebdPMpgtxORJHWu+yT8ibOssVoGh6tunXpO6uoxodFy2PZBLVu
 IKgg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpa+3K78XDVc3S/Sa1W86zI3FiEnDllJ7Jn4yaGl3MRBCMivvU6soyxchIOvyUDmKi/XANGgNTgiBar@nongnu.org
X-Gm-Message-State: AOJu0YwOOxVy3xpySd/6Qm5cvs1iZ7RQUB4efj3o3+QQz5DlKSQeAtdk
 pko/PbevXPYHmiOYhKbXV7qku+d6cAje6d14uWKfeaY3RiV7fxhHIngjQ6h1fu+4BhyrTK48VPT
 AjYzWjzho5T42UW4GDvG9K4PYnrAfva6osSEOAwtp/F54YgIR7415Ksyg/Q==
X-Gm-Gg: AR+sD11luiSlwwS7QZY7/T55fyz3NLDpY4NZAdwx2LIIgL/nHu1jnNQ1gKxwAnOUDS9
 akGzi5EVH0QztVs73QCGb2p/c1UMikZlHd6l2Lt6Yt2HBOBEPphoQw2ZjD8ZHsdNjYbUlyi1ygp
 OrWwx7b+dTy6nPUaiXG76mcQHqKm+cYUsTIkJG14KhAR1HT4yQZtdcwrdGLMcni9bHGNGnLc4n8
 pEEZ6miTDG5yT/MtykN5mLR/75yhhUYfWC99b7ZX9OJ/h/08jl1Z9eJoz/z1gD8y6n5PCLw8rUM
 y+CDTvC3m9utKhkQHT1cchjXLGcpjkaJtmhNdazW95vtKdzDVKJRX4ihEp5PtYyQuPYchPw5RW5
 pt5m3pczr0N9QbrNqFIeNA7GB5fjqgR4qTJk=
X-Received: by 2002:a05:622a:2612:b0:529:e058:d185 with SMTP id
 d75a77b69052e-52ce6108b6fmr198501441cf.24.1786038831571; 
 Thu, 06 Aug 2026 10:53:51 -0700 (PDT)
X-Received: by 2002:a05:622a:2612:b0:529:e058:d185 with SMTP id
 d75a77b69052e-52ce6108b6fmr198501071cf.24.1786038831217; 
 Thu, 06 Aug 2026 10:53:51 -0700 (PDT)
Received: from [192.168.69.212] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ff7b18386sm8495449f8f.19.2026.08.06.10.53.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 10:53:50 -0700 (PDT)
Message-ID: <59969858-461b-48ab-ba80-c09a99cdace9@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 19:53:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] target/arm: Pass ARMCPU to aarch64_aa32_a57_init
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260806163939.328201-1-richard.henderson@linaro.org>
 <20260806163939.328201-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260806163939.328201-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE0MCBTYWx0ZWRfX1X2SYeXPkyGP
 5mUOYkJLcYEs3SLl5rz8WApxx6oWkrASi7KaPQtg885cEzCJUB9jeJTgBOLGdO3BaQjyEu8qN08
 BTOW6q5EiNnI65PQ4t+GpXAsecBagGQ=
X-Authority-Analysis: v=2.4 cv=WbY8rUhX c=1 sm=1 tr=0 ts=6a74ca30 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: WDonLe4Pl1vY-_UqjsNQwcDom2MG7Ghx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE0MCBTYWx0ZWRfX+fLrExCC87qx
 8gdoEp4YfgW6jzaWs/EWBQt/C67UxidbpXfE0Pxg78GM0rSn0dQMnJaFY/QMc8cu98Z/vOurYnl
 Hib0klwBY/tzAv6gUFnjBreYmvHykm6jXsJPai2+rWOkevEx2eP5jRcxwn3X6RnTIv5gGbzmOHB
 f1Je6KAKKPsZbn988LzAWDv3s/AlMeJwi3JXIl7UDAq0RXo9IsDxln/Q+eWWC33sLz1uY8Ue6UH
 8gkN1zJ3zEw3Gyu7WQV6srsY9JJw7RY3SVKsDey6624+S7SXP83sF4HolOe0LG3esnTxlbqcmea
 ubt80nbCAN/uT1LjXnJzYu5cvHrok94UIV/b5PfXXHugoTNNfoY9BgOO+uMKVJKTz1fEJ+a20up
 deVJ0/7TRF6c4mvtYLNiqy7OWXY4DQ/Eze+g1Td+dilVU6xQkm0LBLl+gqoVAPFJtLTZokWJyVP
 T0GqCnueokuIhq+akPQ==
X-Proofpoint-GUID: WDonLe4Pl1vY-_UqjsNQwcDom2MG7Ghx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060140
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

On 6/8/26 18:39, Richard Henderson wrote:
> There's no reason to pass Object when ARMCPU is more appropriate.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/internals.h | 2 +-
>   target/arm/cpu-max.c   | 5 ++---
>   target/arm/cpu64.c     | 2 +-
>   3 files changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

