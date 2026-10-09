Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83869CA6019
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 10:06:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF7Uo-0006dv-7P; Fri, 09 Oct 2026 06:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xF7Um-0006dP-2B
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 06:06:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xF7Uk-00067O-C0
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 06:06:31 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6998KQBo231252
 for <qemu-devel@nongnu.org>; Fri, 9 Oct 2026 10:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wrGJ1tz99glRMGLlA+pIsq6jL+AR2U2cvomp4/+gJ3M=; b=SEBlKD+6zw9fj7eW
 G04m4N0xSC+1uwMdTYcJXJ0rC8ZFTzzRsOzjNgMbYjP+52sXpweEcWlsX/Pig49w
 mp/QK2ncBZPpjwAVRpmJIR1tu4VPW7+0P3Kp2jSXTSmBcYgJ4FvDAiyyTkSc7vrq
 n9Q8/2+L8MLCn9GqCeoNSlpODY86+ZC9BNqQARK9+gUx66HsHEL9HQS4Cr2DCnQK
 9P/O5oYwOxXQVH76/jur+r1Vj99Qz/z67zRxBSid2nZRjASyZRgf6XKPc+2NRpTI
 9Tw7zqtTdk6O+GkopW3OXjLac42hN/4BTVzG0tAVKl3i6sn0UIg3iI5OO2BAWew/
 auYjtg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxu3153-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 10:06:28 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93ce7a85f04so1264259585a.0
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 03:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791540387; x=1792145187; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wrGJ1tz99glRMGLlA+pIsq6jL+AR2U2cvomp4/+gJ3M=;
 b=UFEqpcbBB9hmHq/P732vhlAb+9LFOnFhh2cogqxOfAqDorN5/0IdhqsaZI9UV0sdrF
 yWdP1g2rmg6lXJSWXmtJkbYh0OFx8ocKJMj9W7Ln4HZ/EV34HtgNjMF1RXUuUClrFsLA
 Mc4Dcd3v8qXApuWZ05WQ6ejHRADTAkamWrZ0608H3ZqRChE0Atx/dLrDF2GZT9pMGVmH
 NTkLejr1Rerb78bYeolWcgIQiznYZdJ0qBB5NTweVTYpmGPcp6pTQ1g3miH+dRd95RJ2
 biPHct5jX2OKduJv9OImVQyNOpW5q4bUXdh5Dqp1gSZTBFe+oepY/fhAOtNsFuFSLl4K
 8egw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791540387; x=1792145187;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wrGJ1tz99glRMGLlA+pIsq6jL+AR2U2cvomp4/+gJ3M=;
 b=EhgZ+tOJ8niYImyxH4rqpnq80d5uPtbzA2n63rwCPAOvbRZeN4ZQt+KwiLnFVrG6L3
 UE6bikJe/n7dI7lfwsgHCtccn2oXEEZxOJZLhpbDSamEkIVjoLM9Uy/+kRsDFDF+b+cT
 4uVBeB3FoOyh/OF7FhnRw34PR3wAswOxK/c1BB0oLIaC4QeJI9MfVSgrZMV0kEjBqmvk
 MK4Q0+KwpN+xSAV1pfHuMIfMTygW/ds7uwH3CphFcVJYiTK3zPCmysYL0pzckkKZzC57
 F1GFoJSggcozXCsdKgQ0CmNuvCXwJXn0X9RY1WQlBDzZZ0qY8aE5JR6XEMjoPj0jL7KW
 nVjQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxaMPMBPWUEutIX24MvfdC4HoWtKXzLTegRXKcoPAFxFah3lkMqG0kYCg8IxXJEivHhzxq9BnBrsMhI@nongnu.org
X-Gm-Message-State: AFuF++lCZOIbYaB/C9ZG3ghzKgiKOqyqsFf8x+keMXnuPIH2FK7rTgG6
 xUgtOr8gy7Pl7PWCfZ+Snn0Vhn7XZl17YhoAOTUoW7hJzWikncY33RXHielIcxY3S//jOMbBkv7
 xoSk8TyUN1Wnvjs2Zs+ls9y1c45RFIXOHcKf/Z75TegZdwQjzm2l695Yzjw==
X-Gm-Gg: AYBFou167Ychmr29Naw0Wyr6A/RtuUQmZ1C4tu1AjTEFDYl65Lir0Xo2CnuIrgWLnZY
 QgE6kguJ2tYafmfKG8L/BTc9TjEYaCZ76EyMxpFBXejIikQEEjPn7BSu6r8zHN+zGdNvAB07nSP
 oofcXUmsI1KDcofYJEaAPxVLgEueN2Mo1LGSYW84BIznXhiGbSTp20uXos+ALybgtxGA4kxp6U6
 Z7wzE7FSEwfHOghJ2+h7jYRDT69Y6UHy70lbgOzgZuxM3Y2sWq6eYtMBotReSCThhkVsaXP+zmF
 KG5K2Ff3A+E450x+1baI0UG5eytkyv5fHv54gG0Ka62uSdCVvm687QAcrkphNK8bvZSH8Z2AIDb
 IwW2T6JviJ3H8DQpJZ33VGHcALEFbojsvHw==
X-Received: by 2002:a05:620a:3705:b0:93c:c27f:961b with SMTP id
 af79cd13be357-93ebd20b8fbmr177230785a.44.1791540387327; 
 Fri, 09 Oct 2026 03:06:27 -0700 (PDT)
X-Received: by 2002:a05:620a:3705:b0:93c:c27f:961b with SMTP id
 af79cd13be357-93ebd20b8fbmr177226785a.44.1791540386742; 
 Fri, 09 Oct 2026 03:06:26 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm69202575e9.6.2026.10.09.03.06.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2026 03:06:26 -0700 (PDT)
Message-ID: <7930cf1a-84ae-4428-8be3-c389aa29b237@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 12:06:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc/arm_gicv5: Make IRS_IDR0 reads return actual
 value, not 0
Content-Language: en-US
To: Jim MacArthur <jim.macarthur@linaro.org>, qemu-devel@nongnu.org
References: <20261008092327.4036856-1-peter.maydell@linaro.org>
 <5d81e092-86f2-4459-a34b-460d69009568@oss.qualcomm.com>
 <asi4iR9eMPPgQIkS@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <asi4iR9eMPPgQIkS@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0MCBTYWx0ZWRfX9ZxQ8S+KeAlV
 quPvsi+ehHj2k6XtnxMlqrVujYMcfl8617vwXkp9hKMPFH014VLiQen0sCegvtQmHLUdpJi2NR5
 qdiAOLtU0T0DZwbaZgaBucDo3QPzLLRRIHOHgqQw4Ra0tLhPju7l+oHctTS8Ztliv54uvkCkWo/
 evsPVi6b5u3CXPUGwibwBUCGF3yUQ9ixPL2RmZpWAlU3wnMFBWvhJS4+H/85CZdB7qK8N4r1dd3
 X62G9QN3wn6mv93qkdlXhTnhJrGk7nrf7KlH7IqDt+TRL+CA3UVQu3uyi1hwMiuWFE/VMajiJ8c
 MNmR2ZTssQB7mgwqbzJ8MngcA1hjAeAqEb1gzqvzBaDJcflqemHTmrB+niOuil9h4LA/FAjQ6Ji
 JGZ78t1YHUmN0ruGcjbd1BpxkQaKQGGBFyupcoXp5+blAn0YCLGzVj+sW91+QK225azC6a67G2t
 SXJyWYMO2x9MY/Xgj8Q==
X-Authority-Analysis: v=2.4 cv=QbjzLcbv c=1 sm=1 tr=0 ts=6ac8bca4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=Itz2RPL9QOgoXa8gin0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: uy3wCvJF0NrVpTm_9owmgLmbrFBvlVYL
X-Proofpoint-ORIG-GUID: uy3wCvJF0NrVpTm_9owmgLmbrFBvlVYL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0MCBTYWx0ZWRfX7wvLOmcXQsU9
 9LrSECbeMo+rpfQf6toIhe29fNOYWDPnAdEPUTy2zQYE4avOsGql0Bu4mecdxWs/QMlAEoBNmJ2
 FrebemI5xRl8LoO7Av98TRTp0JhYrZc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 bulkscore=0 phishscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090040
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 9/10/26 11:48, Jim MacArthur wrote:
> On Thu, Oct 08, 2026 at 11:36:59AM +0200, Philippe Mathieu-Daudé wrote:
>> On 8/10/26 11:23, Peter Maydell wrote:
>>> IN the code for handling reads of IRS_IDR0, we carefully construct
>>> the correct value starting with cs->irs_idr0 and adjusting it.
>>> However, we never actually write the final value into *data, so
>>> the guest will always see zero.
>>>
>>> We didn't notice this before, because Linux happens to not care
>>> about this register value except to check for the presence of
>>> virtualization.
>>>
>>> Cc: qemu-stable@nongnu.org
>>> Fixes: 405ad2e76f13254 ("hw/intc/arm_gicv5: Implement IRS ID regs")
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>>    hw/intc/arm_gicv5.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
>>> index 08878193dfc..ebfb0878af3 100644
>>> --- a/hw/intc/arm_gicv5.c
>>> +++ b/hw/intc/arm_gicv5.c
>>> @@ -1433,6 +1433,7 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
>>>                /* ...which means VIRT_ONE_N is also RES0 */
>>>                v &= ~R_IRS_IDR0_VIRT_ONE_N_MASK;
>>>            }
>>
>> Looking at the code path it is obvious, I wonder why compilers or
>> coverity didn't warned 'v' is set but not used...
> 
> AFAICT, 'param @= RHS' counts as a use with -Wunused-but-set-variable in GCC up to version 15; GCC 16.1 adds an exception for this and should warn.

Oh, thanks for the info!


