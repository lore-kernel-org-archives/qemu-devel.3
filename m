Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9F0C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 11:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjEQS-0007Yp-Ov; Mon, 13 Jul 2026 07:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjEQR-0007YH-Ip
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:02:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjEQQ-0005J7-4Q
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:02:15 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66D9eJ3a956861
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 11:02:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 drB+GG8NgNwugYA6Uxxh4gQQaa9y7YYwX/UZWEPF3tY=; b=o8r4aIoJmUbc+a1/
 f4OQMQFKWKaLDFtoaihHQcF7HqCisW1RMVuOe9FoCO2aFzHtIyh8eyfyxTVdmRQP
 ECjJIuBhEQCJEi+i1NLedYjqejf/UeTdR89lqd6indoTNDtaap7zmwzu8h7niFWf
 GY4WfELtibIINGsgTxpK1zxaoGqvvdxciKwF5aPCrtJ2bsQ2pQR58zRJjcidmFuZ
 pbmmux8JALzfCINgsndfRnhz+ec3hOFa84NggJCu49J3Ucu8vy1sdTH54/oCXmSW
 fhdf+8bwk3Co8cZXMS2Q8XKQl1ZzHETQbQngpD3LgqIqbkXz3NVSrj3ANP0oLhq3
 flUgqQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwk9r98w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 11:02:13 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5bfc75c9fbfso2000114e0c.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 04:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783940532; x=1784545332; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=drB+GG8NgNwugYA6Uxxh4gQQaa9y7YYwX/UZWEPF3tY=;
 b=Upn/THC9ndmkZX6Qw3M2QSwbVFCfl9k7uXVdgwWBCozrN1ye9RUAlM1vRNhRtTy/P9
 zt1Pwg7y/6g61R9mrOsxNzvou4Medupi/NlP6uz0qjFABxRFtgBzHSpkrEyRgfFEJICe
 FLJDLHvcOjhsLO8HuZWz+wn++o15gseYOf82TKIGQigFeU8bKOcdPykkif9DfDUgU0Y7
 M8fFvBIbmE4VLudZrj5ztF472DC5+O8Hyhp7ESaj7cdDl62PXJ47NOkwe3JOQm/v70W+
 d3cjzHYpUgTFEg3sI1Aj0nl5ku7tf7M3NZQ23ICGYIMKSVb5j6XABeEq3l6oT0FMVCLA
 4QdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783940532; x=1784545332;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=drB+GG8NgNwugYA6Uxxh4gQQaa9y7YYwX/UZWEPF3tY=;
 b=rBl1DHRYP7cYOnaFZrFH+fy/eqqRPpinjv6eSK4OxEdWrV2tAY4WXdEQY7CofiM0Vk
 Qtr9LUMJpg5L+vkF6DihucgsbzeNpSW3OoMwCT91l0k7MN15ullpodwPKvTT8uCi/AmD
 S9typHeQs32LSLHZJuczsYgfdFmQqsUNz2ZNrswA3Xr94KdR4Obatfr8stJbD1J+4r6i
 E/Sic94xN7GGQ2kxLPpi1fA4IHhy4a8rTXP3yBM6UUj/Nv+8ubi3L6OmmJ1kwHo16h/7
 ysbFpGjju3HPV33ggbysCOs6Q52WqzIM4ehZ/g5eQyv5A1wMrPUtIdRm3BRjzbmOVEeo
 eWZw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr9N4ADRoLml0JZOe7m3C5kmsvagbAudeny7s95QDHXgK3gy9VUY7ObPjXiGuaJ5uQsw62ap10RJNl5@nongnu.org
X-Gm-Message-State: AOJu0YzDejHkuGYkgLJMZgIQI4pF3S6xMwionvo5h9m/T0w+LUVjLsJL
 qCdnmgttV1386WdT1T62V2zimVlHIrzUQ5K4EZ7p8oNY4dM81++8ljc7t08Hqlv9uZYtxgM0Cmo
 fcObTwABLpwWS8v5Emdh1x/MUNDhdw8J6MRsaKy6ww54wO5vojZVyehfM3g==
X-Gm-Gg: AfdE7ckSJs23GWr8/CkExU0ptV5Q9lhXgroIhcKmSKUDk+rPpO1Zl46xFm1VFtiGOzd
 TT96pyDAN7X/xKgE+nfuU+74+mdNGxsvPqAceqeW7y1MB1VQCDwZEljWRqweE82oRHIuP7k4eJ1
 A0FAEi4gW0D6iPHMnRZsekknAl0IrsR935OyMK82ElW55j+HV13UWBHLUng8ifYoj1SSqHqa4Py
 4EsWxSKzTBdpNb5Vz4Z6Aw4UnrFJTPBItUzsKlpQAqfWq0A9r/8jvyruNYJwZZsEJq9zumHTN3B
 gJ9Dc09nR/iJ16RGLv89h3FKdjTnZyxgFGqdPhad3UaTqifhVIV5qn+rvuBpXVVs0WOth/7/zMv
 TaclNmwXVOEz4JNVbPewrVQG041sbOo4uO+5TcTjNTlEHABaodlVbLNQ+JuU1pg==
X-Received: by 2002:a05:6122:20a5:b0:5bf:5edc:9aa0 with SMTP id
 71dfb90a1353d-5bfbf185dfcmr5206762e0c.7.1783940531947; 
 Mon, 13 Jul 2026 04:02:11 -0700 (PDT)
X-Received: by 2002:a05:6122:20a5:b0:5bf:5edc:9aa0 with SMTP id
 71dfb90a1353d-5bfbf185dfcmr5206727e0c.7.1783940531333; 
 Mon, 13 Jul 2026 04:02:11 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039b0cesm87000517f8f.22.2026.07.13.04.02.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 04:02:10 -0700 (PDT)
Message-ID: <f2f9ab6d-7ab5-4bbc-bc35-a577af4e953a@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 13:02:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] hw/dma/soc_dma: Remove unused mem.base, paddr fields
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>
References: <20260710105907.2570621-1-peter.maydell@linaro.org>
 <20260710105907.2570621-8-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710105907.2570621-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDExNCBTYWx0ZWRfX51hoF6bkGI8Z
 PXaox8LD3UKQwfZn4EbStm4z+EdSaq/2PJQUv/OXY/f/2tzE9mDim9ktm+TyuF3nW45BwA6BDhT
 YJrH7s8Bh3hjjX+4b6WzpBJB4R48U5lbEMxr4m5zu6U4zuj22M/lwJbiwpHI/yKFMNfgkQJonq+
 2iFdINzoM9f/v75OMxUDH9tr7GUj4o5ih8LvelhU0/r9iCaqBOqgbklGXLjqHFK8iNCC4vzots7
 fxAomcwtefdzy9u+rUkDl4BUqoZkYhu+0dm+sULBHQb9djIizEXBQn+NM0aMFmhhQ/HlW9EMbdb
 Hh9zJE9lMocRVKm3Uga+e6Jkmp1v5A5kH1J8WA/VNrP0aTV+wuSknuUD/jGWbfSY2q+KcbGpxU/
 jvWtMgl8n7x+5EigUL9u1QBNo7jS8Ct1MFd7S7bgdlOeHwwibDzHergKkNWC0UbwUb13ngXNal+
 zKfuTwol5sIJM8VU1YQ==
X-Proofpoint-ORIG-GUID: QftwmgXCwypTjd3TKEWcTFJ_lTAvTY-f
X-Authority-Analysis: v=2.4 cv=UMHt2ify c=1 sm=1 tr=0 ts=6a54c5b5 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: QftwmgXCwypTjd3TKEWcTFJ_lTAvTY-f
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDExNCBTYWx0ZWRfX3zSRolV6ki6Z
 yGqLnd9y7mBeKRB+bqBFfAGamNUS0J2L/u0A6asa0P799lGr5ZLOvzP+LFY790O8xUvkeEqvaSo
 iCNUKXF3ssYnyXDuHFEY7ICTR4zRJMA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130114
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

On 10/7/26 12:59, Peter Maydell wrote:
> Now that transfer_mem2mem() uses physical_memory_map(), the
> soc_dma_ch_s::paddr field is unused; remove it, and the code that set
> it, and the memmap_entry_s::mem.base and the soc_dma_port_add_mem()
> phys_base argument that were passing around host pointers to use for
> setting paddr.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/omap1.c           | 6 ++----
>   hw/dma/soc_dma.c         | 9 +--------
>   include/hw/arm/soc_dma.h | 7 ++-----
>   3 files changed, 5 insertions(+), 17 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

