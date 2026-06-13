Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E19CD98C5
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 11:46:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYMo4-0003Wl-7F; Sat, 13 Jun 2026 07:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wYMo2-0003Wd-Ju
 for qemu-devel@nongnu.org; Sat, 13 Jun 2026 07:45:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wYMo0-0003UX-Oi
 for qemu-devel@nongnu.org; Sat, 13 Jun 2026 07:45:42 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65DAtkHU2259284
 for <qemu-devel@nongnu.org>; Sat, 13 Jun 2026 11:45:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fqUottWGCE2ZFZFTuQwX+2h0MPGIGIxcg+nXbLcV568=; b=RhaBVnfbA9AtNzH3
 tq6xbWKlUwnzCAqrHefBJ7bAe5ClRhPTU8hiVBooEnDAlpvVrakhRkEccXVOSWid
 F12IdbUC8iceyV6LWv4B4osJH6mHFMfu4FUNgq9qv7inu5hG9MTl/+qKqQVT1Aot
 8FWRVXHvhw/N69Gn8Cy1TjsgKJd7+6/EXHGVoG4aWA8mjl7odD7S5UvT3EQvttk+
 DgDlnd4et6E+f55vkBkg5KI8D9BL3Qu5OCruVQE4Rh6lN1I7KsKPqCkyoRHKzmeU
 jDaIgylU4Gptt4pjpuuRo2aAodqzewCk9WA586/c3StMEcstWEJ1Hngp80Okz82T
 x6ooaQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4erye10w3x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 13 Jun 2026 11:45:37 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-915b6b63056so378354485a.1
 for <qemu-devel@nongnu.org>; Sat, 13 Jun 2026 04:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781351137; x=1781955937; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fqUottWGCE2ZFZFTuQwX+2h0MPGIGIxcg+nXbLcV568=;
 b=X6Wx9M1tvB/3jixo/Zy4Rdfh9NJPVYKb4ia87WVWY7JhcK64F0Kkkh+3cdz2QnxZI5
 fQKFOHTky2miJT8T2ExD+cUFKRj5CSsh66NjZ/EYGSwe/VWm4YcOecttOpFi6ApHeUZM
 qrar8IJ1F3wDy1d1qZD+N/cSoNUo+Pxh7HYYiU3hZ4nSAgPPho07pOHFCSGIRAhNDvGd
 gd7L/DZWuM2CIbwmY+y7CqSMDlHlQHmzr45OnezSXRrhtPnOYGctXQM3y/VlLN/KIf9P
 DsF2ASRd5K1S2kOPVJwag11y4+TWovTnEstKbKhGBtd/NsnoFNtHoqSdgTX7HfKp3oAi
 pdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781351137; x=1781955937;
 h=content-transfer-encoding:in-reply-to:cc:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fqUottWGCE2ZFZFTuQwX+2h0MPGIGIxcg+nXbLcV568=;
 b=QJNHgYIhqmn5XFQJbLo9HGsJCgZjQ0qAK/+NNhtu44wj5y4+wurtsZH7dNkaPEgf7H
 WnVeLrOfptdcaH4yaPdS6YFbgCgefXBMHPYB7/V+OlvW0z16fD4THxgHSsWaZH+ztYlD
 eDo8z+esRGnflyc8CmnsFSfEm4D69go7ZgclzejrGNLlpZlkrPlmtCPDsLg/JAfA1vmR
 hKnjiKyCn5umtHa67GWbcziAx09/s36dicnVfefQRvuF9iIZMpWAJm522Y46tbI74/FU
 Hd2Y66gwMAbqayQiCev0NiI8Ig5/R2P7ySqrjw1gva7soFt6QeK4d5L+7bPnGzlu5DtL
 +NVg==
X-Gm-Message-State: AOJu0YwZuFYfebe84ClXT0EoFcdEJAflUZ25BB6wjEgsUdolyVFx0lo9
 wlwL0n9Seb9iq2bOfDSCBjRABUecj0KRc3c2MIzCvrhqX9Vd/7xMUCsvBX9pWopWPlWSQa+lvY1
 Smkok03mfrSG9/94iUNUcfvRIKrEYq0F3ycHS49cEP2X/ayTA69LYG6EflA==
X-Gm-Gg: Acq92OE0K/G4gn8/T0z00xpgq9GwWBYNz7XlGQHGfNWDX00lvST2XFUx0Yq8CQPA7hO
 RW0akJRHbT07Sj5Gy91wOt7rrkCNAMa8RutaOO/7H8tRay/PqZWjCHWS8CqlWWaPEh+PaoHArBj
 G4WdSysFkR8F8b0fbvRsL6u6fTrO2d7UTxwZ83MCftOg/6HxhIUen1OsgTSXXlxHqMxWOzfsBg6
 AaD9tZU351+k7NPIhW6dWCcJXDph1zpJ0nYz/y2M5e1Nw1qU8nUJrXDKuUCMm5XEsD+CFn3KCTA
 svoUKgpyMBSVFm1yJnR0Fa+U8WwbnNNeZc9tFUbmwZo/dYJr013K6Xw/Ct0NX5Rpc34HttyFEuj
 JCUZ+pLx7hAdckAVEsbkKu14PJTZtQJL+2NHHkwATUd0ApcNvuu93h5knbxsikIq3F7Uh/hzw
X-Received: by 2002:a05:620a:46a8:b0:915:b852:4354 with SMTP id
 af79cd13be357-9161baa28d8mr1003177785a.9.1781351136881; 
 Sat, 13 Jun 2026 04:45:36 -0700 (PDT)
X-Received: by 2002:a05:620a:46a8:b0:915:b852:4354 with SMTP id
 af79cd13be357-9161baa28d8mr1003175185a.9.1781351136454; 
 Sat, 13 Jun 2026 04:45:36 -0700 (PDT)
Received: from [192.168.69.214] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea95b274sm154260355e9.1.2026.06.13.04.45.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 13 Jun 2026 04:45:35 -0700 (PDT)
Message-ID: <a35bb538-541d-487c-b28f-39e265ac80a0@oss.qualcomm.com>
Date: Sat, 13 Jun 2026 13:45:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 15/28] hw/intc: arm_gicv3_hvf: save/restore Apple GIC state
To: Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20260501101505.3485916-1-peter.maydell@linaro.org>
 <20260501101505.3485916-16-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
In-Reply-To: <20260501101505.3485916-16-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 3gR--qPshFg5F3j5dKjr0YMbGY4Qe9pZ
X-Authority-Analysis: v=2.4 cv=MNlQXsZl c=1 sm=1 tr=0 ts=6a2d42e1 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=Ja-kICpsZsNZc9eEzF4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEzMDExOSBTYWx0ZWRfXwMkh7wl9Fg9n
 0+3AOTNDunt3uA4nYCmuupAOcYhdJN81v0mq/3CSAWSBp+kD/7VdwKqMRpONJNQyPWCibl8Ie5k
 H6bJJ/jrQFpR/KAh8okHTyQHK5ovBXI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEzMDExOSBTYWx0ZWRfX69BTB+890Lyu
 3Qr8dyMHptEaU3Y4Z4WGtSO2JkcKpeuWhmhRKVV7OvCuzsrvO7a7YcIVn3ecN/HdqR6ID65oLsu
 lGdNZG5FyaOTrkCjsckk6DCeVFpHLbdXoUwKSWR3VAImpC2OnAUc8v9zSfHPb5rVnV5UoqfK10D
 85A2uIPGGRhbXsDC2gCLVd8iQcbCyzS+/xY8Pq1kzLU458B0lpLJabKwV3JBlAPjCzVwZVUAYw8
 GB9SoSy4Y5MNnIInVZMnnbLw1WfauL5Kst3mt+6AwwYoA1d3d1G7htKQuKX4tiH/YIQMRubr5ta
 Spp9bYzY+5/rYMqMHo4L7kwXoZVDGt39dJv3TdxsqS/rJFQxPtFuFVbs6SyN90BZWo6/xiiiPe5
 8kL3i3umFhn3c9NA9YMqly6S6yW+8DGUShbnlhmkn0IMLfM8jiVJBhNPTn60Fw2fD8nNfFSsMrr
 eQo30ud9e6C/DWpog1Q==
X-Proofpoint-ORIG-GUID: 3gR--qPshFg5F3j5dKjr0YMbGY4Qe9pZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-13_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0
 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606130119
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

Hi Mohamed,

On 1/5/26 12:14, Peter Maydell wrote:
> From: Mohamed Mediouni <mohamed@unpredictable.fr>
> 
> On HVF, some of the GIC state is in an opaque Apple-provided structure.
> 
> Save/restore that state to be able to save/restore VMs that use the hardware GIC.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Message-id: 20260429190532.26538-3-mohamed@unpredictable.fr
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/intc/arm_gicv3_common.c         |  1 +
>   hw/intc/arm_gicv3_hvf.c            | 94 ++++++++++++++++++++++++++++--
>   hw/intc/arm_gicv3_hvf_stub.c       | 25 ++++++++
>   hw/intc/meson.build                |  1 +
>   include/hw/intc/arm_gicv3_common.h |  3 +
>   5 files changed, 120 insertions(+), 4 deletions(-)
>   create mode 100644 hw/intc/arm_gicv3_hvf_stub.c


> diff --git a/hw/intc/arm_gicv3_hvf.c b/hw/intc/arm_gicv3_hvf.c
> index 22f19d274d..ae881092ea 100644
> --- a/hw/intc/arm_gicv3_hvf.c
> +++ b/hw/intc/arm_gicv3_hvf.c
> @@ -13,6 +13,7 @@
>   #include "qemu/error-report.h"
>   #include "qemu/module.h"
>   #include "system/runstate.h"
> +#include "migration/vmstate.h"
>   #include "system/hvf.h"
>   #include "system/hvf_int.h"
>   #include "hvf_arm.h"
> @@ -37,8 +38,13 @@ struct HVFARMGICv3Class {
>   
>   typedef struct HVFARMGICv3Class HVFARMGICv3Class;
>   
> -/* This is reusing the GICv3State typedef from ARM_GICV3_ITS_COMMON */
> -DECLARE_OBJ_CHECKERS(GICv3State, HVFARMGICv3Class,
> +typedef struct HVFGICv3State {
> +    GICv3State parent_obj;
> +    uint32_t size;
> +    void *state;
> +} HVFGICv3State;
> +
> +DECLARE_OBJ_CHECKERS(HVFGICv3State, HVFARMGICv3Class,
>                        HVF_GICV3, TYPE_HVF_GICV3);
>   
>   /*
> @@ -668,7 +674,7 @@ static const ARMCPRegInfo gicv3_cpuif_reginfo[] = {
>   static void hvf_gicv3_realize(DeviceState *dev, Error **errp)
>   {
>       ERRP_GUARD();
> -    GICv3State *s = HVF_GICV3(dev);
> +    GICv3State *s = (GICv3State *)HVF_GICV3(dev);
>       HVFARMGICv3Class *kgc = HVF_GICV3_GET_CLASS(s);
>       int i;
>   
> @@ -715,6 +721,86 @@ static void hvf_gicv3_realize(DeviceState *dev, Error **errp)
>       }
>   }
>   
> +/*
> + * HVF doesn't have a way to save the RDIST pending tables
> + * to guest memory, only to an opaque data structure.
> + */
> +static bool gicv3_is_hvf(void *opaque)
> +{
> +    return hvf_enabled() && hvf_irqchip_in_kernel();
> +}
Unfortunately this commit (48396ad6ce9) breaks bisection:

../../hw/intc/arm_gicv3_hvf.c:730:29: error: call to undeclared function 
'hvf_irqchip_in_kernel'; ISO C99 and later do not support implicit 
function declarations [-Wimplicit-function-declaration]
   730 |     return hvf_enabled() && hvf_irqchip_in_kernel();
       |                             ^
1 error generated.

The method is declared / defined in the following commit (2a3c965516f).

Please be careful to avoid that in future to avoid manual operations.

Regards,

Phil.

