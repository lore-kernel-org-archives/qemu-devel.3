Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 567ABC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 08:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz8sO-0006ms-Cn; Wed, 26 Aug 2026 04:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wz8sN-0006mR-5V
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:20:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wz8sL-0006hu-LG
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:20:50 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q6RlQU683504
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 08:20:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SMm49n7lMlJCLijzQbo4X+czm78mPK0STpAMVPWsgaA=; b=VCsB+cRW01SDtiaA
 QTsM2Q56BL8TAvbqEz75mXf6mKTIEsEnjMKVsRIURU8UZZRf1Jo1PbZOd2krcrrW
 j5XBSRHkGz2w+WXwW4p37C9dx3jzGyVyCAjZ37sBLLhCEOLBxdro8nSEIeBq/+mn
 uop9PD1U5eObmIejKYYDvOzFBYY5+Z51fWUTg1RXXlLXswtJt2T0G4df89YBluKC
 LVWQXOU4IazzN9jdawaOLJcD4Ua3VcXo45luM2q8LcuMWi8IdHhtVpXTM5LloHEo
 YUdidZM4wkOqy8U22XPqdM9ilDMaLLK3hgAwMFEHAINRcRR15qlOaJNA/kjpy6eh
 rKOevw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9fgxjwst-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 08:20:48 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c07f25de2so5329521cf.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 01:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787732447; x=1788337247; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SMm49n7lMlJCLijzQbo4X+czm78mPK0STpAMVPWsgaA=;
 b=Ruffc+24vVyxWf3RZ0J54WhWislAK703G3OOCqUyXFhHGIfaitaQjlvIXEzV/jKUuF
 s/kkqJJmgFVD990Xs3Wm7xedUf3i3mzD/4yO5r05GkkqJ38W/QkeXGYbxKnf0fCAt9Ac
 wiGY/DLbyjDTUjjsHHileoOM5qME/NrvI81k/TyXq8AB057GQpmbI1Wr2HvYtD88Iugo
 +GxgLtW+PJ6wJmbyQ1mcunHx+P8oZsT1nYp3S5Y4rzSnkntDdH3RyLMahXB7WqTlSzkb
 6k7TA8HJZZewQLIpTF+Wfd38oN7XSTV/7keRs7wcc3zyRB/4U26UNzTvOwPnnPP/qgW8
 N1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787732447; x=1788337247;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SMm49n7lMlJCLijzQbo4X+czm78mPK0STpAMVPWsgaA=;
 b=rAyf5mZGXtf627jy6/SmbMxfoCUm1NZCilyPPUWFUdUZTehTawHwb6t6/CVpBw3xnP
 QM1yBG660p/wOhgkt+IhTqizHGVan1ugOUCOxQcROpf90hf1pLz+3rzXJRxX6aJ4SWUI
 NTTYDt7V+o4gPLeH1j2ZJN2QYkw0CcMl34QEsQvSckWMBW+PQ7E7S+br0ws5xQAm4iVC
 /JvD4sjhBltvyMQ5qW0A4uCeO/C+uXWL9O3rzLoyC9Gsv7FkXKijxvsFeVm63KyiNTDc
 pUyt7eoeTnG5ji7lxyjxwjbURivHv49Xb/IHD45GWCi4jW473vr4k5Po3rKZgNv3pEpY
 /4SQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrwkvLKv7ua/rhnrGVggkXpNj8Tkh5X0nuK3a/9BHAv/V++n+4rONa6A9seggixK027VeKA/f7Ls/Hv@nongnu.org
X-Gm-Message-State: AFuF++kP872oIidbvIWD19+H8ZMRKZJ2a+uODKS5n8Sii2IyeNA/Yw27
 2xOcpR3ZOjOefw6u1NXoKaTVFRqL5aKhZMfsieTX/p4twejDPaepvFuWz6okWWXIslQJI8Fo5Qx
 Xg3E0RElkg3CgyAZb2wdQJWp59AozNmFkqCvTUpL3gnFCcW/rb4HR9axDMA==
X-Gm-Gg: AR+sD13nZWbaDJK9OuaZNBaYJieD5OOwRlEog7lb/3v5GWVUj0Agy3p9UDqX9R+Y4cm
 0lqbqpdlqL+Vhk7SkI22rYNg3fFI0amC/Dq/qJccp0AzKkujWCCtYCUkM1bA8Q0zUPhlQQwYvdp
 omiIo4oi6gRw7eBKGCyEQxBJ1Fl7b6YEuZUfAeeENKTGWcGlhgth71GLxQj5Gn0GX2hlXTLgkba
 ZibamTU/rC1BM2u224uH8Vm6Du1SE6uwoGTr9oVQeG4ZcyQSgolH75hB3erFO585iBA4d5i5ODh
 2YKy3QR7M5QI5IuWUPAdPnzAeJaD7/dbfL59FKDMhVXCsQf9BvhhdkV0Zh7qE5q/Il3/9q8CzHa
 uQ6nMjO1S37vysrD9ArrVKBKKCJ02jgW2dnVkGQ==
X-Received: by 2002:a05:622a:164d:b0:52e:3a32:e73d with SMTP id
 d75a77b69052e-52e42344b22mr41651531cf.21.1787732447260; 
 Wed, 26 Aug 2026 01:20:47 -0700 (PDT)
X-Received: by 2002:a05:622a:164d:b0:52e:3a32:e73d with SMTP id
 d75a77b69052e-52e42344b22mr41649501cf.21.1787732442054; 
 Wed, 26 Aug 2026 01:20:42 -0700 (PDT)
Received: from [10.254.188.74] (14.89.66.37.rev.sfr.net. [37.66.89.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e27a9945sm1887212f8f.9.2026.08.26.01.20.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 01:20:41 -0700 (PDT)
Message-ID: <de9dd447-80f2-45a8-b166-beccdd950287@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 10:20:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] hw/arm: Add Axiado Ax3005 EVB
Content-Language: en-US
To: Kuan-Jui Chiu <kchiu@axiado.com>, 163wangjack@gmail.com,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-arm@nongnu.org
References: <20260826074635.2850931-1-kchiu@axiado.com>
 <20260826074635.2850931-9-kchiu@axiado.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260826074635.2850931-9-kchiu@axiado.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=MqZiLWae c=1 sm=1 tr=0 ts=6a8ea1e0 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=JQZmDyB7+sUo+n2VpL1TLQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=440cDlBIAAAA:8 a=-GMYWo8RcLAl5XYbW6cA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=d9D1X1bx8dWolqnE4HNT:22
X-Proofpoint-ORIG-GUID: HqObseFPGgQj7PUDQf_P3AqRbsBZkUpw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA2OCBTYWx0ZWRfX+kw463WcJkyN
 DxvEcDI54lWDTlcKZznDKM74ABX6v8etnza5wUINCR1lK4ghhoCyTJYMPiiXcv6Bq55Q5feqRXa
 sepULyInqJKvHkPsC4iUmyJ7BKPoz8V7ieGYNSpHbIZd7ihR8ImcKczA+auiYy1616uER3pOzwy
 iFlaHL5K3pycpPxwmt2BZNlGC6vwBXjvE0AR20Y9/LjF6EA89xCtHMtesVv2satQNDHu5G/jrdf
 LG5nOu7kFnlRdOQMq+M5DE8w2Y8NLNgUyXHXFVC4vsVU5r9eqBA7zFSKwTHAQUwoYWQ00ItFctT
 1TRLzE1fQoPlE/Ol8VRmC46CYLogZnN2+24URGWIcCVn1dKHd6B9mVGrS6+doj4gQLEQlc0xNgK
 /pLW1ZNawThx/VHgHhxXrUEgEIuZJJEH8vZtlL1aBu6hb0Ttv6CkVOnAk5ex4liryMVQS9ZR4AK
 BGhPIEdiFvTZhVScQFQ==
X-Proofpoint-GUID: HqObseFPGgQj7PUDQf_P3AqRbsBZkUpw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA2OCBTYWx0ZWRfXw4i9nlvaBsBt
 9fltOf1d7+Cr8gHWKY2eFhLwxWDKb9webIP1HYAZeYsANA9MYOqePbNnCmraWh2Z71zgWkmeqNI
 MNYWcdCakAtOIt8EDDmayeRuhwClyXg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260068
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

On 26/8/26 09:46, Kuan-Jui Chiu wrote:
> Add EVK ax3005-evb built with AX3005 SoC
> 
> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
> ---
>   hw/arm/ax3005-evk.c            | 64 ++++++++++++++++++++++++++++++++++
>   hw/arm/meson.build             |  3 +-
>   include/hw/arm/axiado-boards.h | 10 ++++++
>   3 files changed, 76 insertions(+), 1 deletion(-)
>   create mode 100644 hw/arm/ax3005-evk.c

Missing some description in docs/system/arm/.

> diff --git a/include/hw/arm/axiado-boards.h b/include/hw/arm/axiado-boards.h
> index 4a632661e1..7a610ecfda 100644
> --- a/include/hw/arm/axiado-boards.h
> +++ b/include/hw/arm/axiado-boards.h
> @@ -11,6 +11,7 @@
>   
>   #include "hw/core/boards.h"
>   #include "hw/arm/ax3000-soc.h"
> +#include "hw/arm/ax3005-soc.h"
>   
>   #define TYPE_AX3000_MACHINE       MACHINE_TYPE_NAME("ax3000")
>   OBJECT_DECLARE_TYPE(Ax3000MachineState, Ax3000MachineClass, AX3000_MACHINE)
> @@ -25,4 +26,13 @@ typedef struct Ax3000MachineClass {
>       MachineClass parent;
>   
>   } Ax3000MachineClass;
> +
> +#define TYPE_AX3005_MACHINE       MACHINE_TYPE_NAME("ax3005-evb")
> +OBJECT_DECLARE_SIMPLE_TYPE(Ax3005MachineState, AX3005_MACHINE)
> +
> +struct Ax3005MachineState {
> +    MachineState parent;
> +
> +    Ax3005SoCState *soc;

When a component is not optional, our style is to allocate it in
place (IOW this shouldn't be a pointer here but the plain struct).

> +};
>   #endif


