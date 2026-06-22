Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99075CDB471
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 08:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbZh9-0002Qy-LA; Mon, 22 Jun 2026 04:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbZh8-0002Qc-5z
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 04:07:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbZh6-0007Di-HY
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 04:07:49 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65M59FBR2427859
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 08:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lhVb4kwmVsrElXKEMEdvEPXa+Y5NdJ3alJnpoqhQdtI=; b=YnH4VHUv++BXy93P
 2h2I20+lK5yGb0OKsFCp7E5urJsQiebV+lyXO33vsG6COkJrxWInZ6fdyZKAjdnX
 md95EQQqv2TvKaJ7PvdfL7zektaZWUAByv2poW1572SquSCvx4GpeRr7Jlv2Z6JS
 EFKn2AgVPP0J6efIp8Z5m4fqd8IjagcrWd6dA0dp5ot/HZw+Le8STXPo3OD4YPpC
 cdIM2KICEjTrCx1QOZa6YGT4v40t7RqJltQXXJiMTuwNA3XKFGBGFa2HBYFIH1ka
 qzRiC1GjK+rty2MhXx0VjC6GbEzjdyEWCk/ATj47ihzY4o+0p6QCtOqG9YijIUC9
 U2OXqg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewhtsdgd4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 08:07:46 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9157de5360fso1090412185a.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 01:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782115665; x=1782720465; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lhVb4kwmVsrElXKEMEdvEPXa+Y5NdJ3alJnpoqhQdtI=;
 b=J5amAUXUvLlItd/eYtkCI02+SNUgPbvhvkKIKh9W8aev6F1IiPO+EgW50TOi8umHSB
 YhN2vGvm+h0y0F0ED726CA+uWgmnD1DXKT9jZM5vBt5w4KJPGnGFiA2SJPuTcQcWXbFH
 Uk7gYdeHNZuIgkrm2v4zHMSpikaH2RSHiFmARuT+OjpslGEQRuGIZ2RDzpWL0VMO+n9e
 xvkkUbnIxRSD85VV1/fwCuX3/+27Zq0DCIOBQjOocsGVHyCpvCJ7VVntB2LcXVZIU1bQ
 iXC5K5a2fiHflYVFRzC5C+LDglMsUgYkleh1jxN7amAJV8tzO3WidmbSB3luprQIYf4X
 VKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782115665; x=1782720465;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lhVb4kwmVsrElXKEMEdvEPXa+Y5NdJ3alJnpoqhQdtI=;
 b=hVEodxyks6WwXEmpHgmsd97N23C9mpiFXmiXK2a5MBQZpera2amSxnC0PhjNhRARIn
 Dg2w+o/enMtEDuE1QepKnDCynYc18z6AWAP2D3v7IL2MatrRz8NpsLIbSCUG5fdAt56s
 8GrWxE/0UYQdOBOGPEQS6+o7j+/9CuoUSZ0pdTby1A1abJIxMqbVolbXdJd2suOszYzH
 L1n1KpTwbBRFgPZ3xXmM10RrqbBAOoTzj+lK7xYwOmmrXqbi25bozAMSIXAcFjwWa+t9
 FijOcS+EDohTXKYh9PIGqbq8MnEAmK+osZOIu1gzfVJJdTJANoaz2BD+x7h6oDUkidT5
 dV0A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8AdHZW6EOf1FFF9eKdUb0pARJcUxnmq4UH7YfJ3gXfq+EMeHOQ2JcPFiRpLEYHgdCyDRy2LIO2d0yF@nongnu.org
X-Gm-Message-State: AOJu0Yz//VvJXJXs59RlPeCii6heMHDGQMH97Nyoto2YqC215lu1L+lc
 lMmX/42cRgibNFoRqt8DosZolgMBKcDWCmXZpOilNpZ3h37mVAgRAf1SroThG2NvsqGWUQWWkU9
 0W9oi0j7cCKN9FYq2Np5ACJqh2mOHlEDECWcC0XIcrZ8rcTWPD4Y1cGBphA==
X-Gm-Gg: AfdE7cmj8yENnIXzB42a+9ZFz9nH6KNnDvAwclcOtN9oaDXKniUloq+D5KWueCGRbr7
 TVEl+WVFNyFPZJ802z+0G/cS93yVbbczlr5dRlrHSTYF/ypKMLR+VEUUd1C6X5G27JJ/TmUpIWO
 Gj8Dibr9tN2iyrHaSiNbmD7z0IqwKN6jLGUR01INe5fgdaz+hwxfx09baQsjSV0lY3zaS3W5A2p
 JK7jVxV8QvZRxVxxzuIIvGBjL28m9DaYrFPpeA/eHS1iYvzd91grbKHQClzVynyERM3KbnDvm3O
 WSY0OJ9Q4kbo2n3AO9NkHh6Du1uer+lxmHarFf/DCGsi2ZwrfEXn/7+8Z0jb8pM89x5tUoOqhxE
 kl5FbK3/c7OtWKLwf3eGZPpxgsQ++qIVDhXSFc2hTMwC0GtHiuFGw6G3xQ9twI0giWNI=
X-Received: by 2002:a05:620a:4611:b0:911:c5c0:d5f2 with SMTP id
 af79cd13be357-9208a3d6637mr1581857585a.1.1782115665574; 
 Mon, 22 Jun 2026 01:07:45 -0700 (PDT)
X-Received: by 2002:a05:620a:4611:b0:911:c5c0:d5f2 with SMTP id
 af79cd13be357-9208a3d6637mr1581856185a.1.1782115665017; 
 Mon, 22 Jun 2026 01:07:45 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49245711032sm250925005e9.0.2026.06.22.01.07.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2026 01:07:44 -0700 (PDT)
Message-ID: <62dc9509-3e02-4762-9de8-36499ca1e9b7@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 10:07:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] hw/m68k: add working floppy controller for q800
Content-Language: en-US
To: Matt Jacobson <mhjacobson@me.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
References: <20260617235032.21491-1-mhjacobson@me.com>
 <20260617235032.21491-5-mhjacobson@me.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260617235032.21491-5-mhjacobson@me.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: e9KhAlC1F282Xb_Cm9JlqQ7liaYOiP8q
X-Proofpoint-ORIG-GUID: e9KhAlC1F282Xb_Cm9JlqQ7liaYOiP8q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA3OCBTYWx0ZWRfX0ahvS6fK2Esu
 B2E3BJ0CoYnqT7q4Hr47XS1eOz4IkzGPou1eQq5zT92YSKyVdWGHYAxpN2pWSWJN+IhQIesoDKg
 t7P2zPBgU+5gYTDJ0Fr7/PZeAttGxIqm65NdUm0jCigR0xjtwVxEKQyRtLKg1ZuOqodCvY8uHze
 F6W7XPZddGpFmkdC+ew93cVVUgEtBMmw+ZoUGGTv6M8NLfWDTMrcRDHMeJQv6afv8HoTTKuHfMH
 xpRTM47srYlykHWRAuvnzB+wJ+eHEvZlxlcvUeAn7zWZIyKUAkZ4KifEGIZTUpFlWPOGE78uvLA
 GP7dTdIVz7fl7Ds7HvR81XKD1SOEyDfzCSE54Yb18l5e08tU3tUj0GOW5IajHo1zy+8Fhjl53iz
 /eEqrftyhqOQWDlk+uUkQXtxFSSFEuxQS57cupo2+rhnk7ugeqxUV265e3F7F8/DPxV2MaANI2P
 BxxjsXHyNfOfSodPkMw==
X-Authority-Analysis: v=2.4 cv=bcRbluPB c=1 sm=1 tr=0 ts=6a38ed52 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=HHGDD-5mAAAA:8 a=tnFgilVEM7Pj922rt7IA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA3OCBTYWx0ZWRfX4RSjpxhkUh+h
 yLSSFP+6+3B0SmZD1nPa2zQNgWxvDCjC1HLPMvLq7aHLpEaTww1hLElDFeY8bWhzbg2XbGMGRvQ
 TS8Y5DtoMBlMAxB9o5POMbgyCI+f0UU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220078
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

On 18/6/26 01:50, Matt Jacobson wrote:
> Switch the Quadra 800 machine to the working SWIM2 floppy controller.
> Hook up the HeadSel bit on the VIA to control the head selection (the
> IWM does not handle this part itself).
> 
> Signed-off-by: Matt Jacobson <mhjacobson@me.com>
> ---
>   hw/m68k/q800.c            |  5 +++--
>   hw/misc/mac_via.c         | 16 ++++++++++++++++
>   include/hw/m68k/q800.h    |  4 ++--
>   include/hw/misc/mac_via.h |  4 ++++
>   4 files changed, 25 insertions(+), 4 deletions(-)


> diff --git a/include/hw/misc/mac_via.h b/include/hw/misc/mac_via.h
> index 114f41db4c..a25f219a25 100644
> --- a/include/hw/misc/mac_via.h
> +++ b/include/hw/misc/mac_via.h
> @@ -35,6 +35,8 @@
>   #define TYPE_MOS6522_Q800_VIA1 "mos6522-q800-via1"
>   OBJECT_DECLARE_SIMPLE_TYPE(MOS6522Q800VIA1State, MOS6522_Q800_VIA1)
>   
> +struct SWIM2State;

Why not include "hw/block/swim2.h"?

>   struct MOS6522Q800VIA1State {
>       /*< private >*/
>       MOS6522State parent_obj;
> @@ -77,6 +79,8 @@ struct MOS6522Q800VIA1State {
>   
>       /* SETUPTIMEK hack */
>       int timer_hack_state;
> +
> +    struct SWIM2State *swim;

QEMU coding style is:

        SWIM2State *swim;

>   };
>   
>   


