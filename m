Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC00C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 09:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu4qb-0008Sd-MG; Wed, 12 Aug 2026 05:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu4qa-0008SR-9I
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 05:02:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu4qY-0000eV-Ke
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 05:02:04 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67C91eT43689789
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 09:02:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BgSKYIJUMoNxYwsl8WEYRW2gbRH6qsht4xM/JR0yOHs=; b=pCnEK1RAiR7mpuL8
 t7vFNk+K2T/Y0Hj+IDY8NPiE1z2JtXX4w5xDvOhguKgxKtphsougjR8Hm6vPVaxM
 B8IeQj3A/t0lv0FRbbIXjZZRkLCyye/iQigEBhQr1SR5psIvxfyNAC2vgoekKFf0
 xGITKEB6RLN/OYLiswZhNYDc8zHvWbPbGjh9PWgeReHWO+wAmgJuU4MRfxjkT6+0
 UErr2B5+I57QXSARfPx6dNFn/ClXd0q8T+L7esU5ckXctsI31pwiM3U0pkItCidd
 1YYTC3UGiRrlQXFife3EuRqbAwR0px/krFlUuGN3tXpIYayOttDDrMePrHkDpCxT
 ijRo0w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0nucg02r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 09:02:00 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52827090cc5so8852681cf.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 02:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786525320; x=1787130120; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BgSKYIJUMoNxYwsl8WEYRW2gbRH6qsht4xM/JR0yOHs=;
 b=FbFdDX2KtS1zP4m2YCAVnMspFQ+3YYOGQfwJ06+mD4teLPlph3fUfBXxihrJzy5xJQ
 i/APMpOd8srdjww4wyRLJ3BX2nn6apXHbTeSbc6nwlQjyZ8oR/i5qFTHeCDxNqB0mHEV
 b6lEuo7fNtvr0mmGXwGvW9nWJVDd9sSDyw9Sr4mWhkxRZkmi3dRgYiw7WgfafC/bicGv
 n8IRhHHjupt+nHWD6yBhJpFaKeZLFG2cG2nOWdGNI+n/5Emjp2BzjcY3lRoClD81EyQu
 W32P8dMSjeldEhUbPHNTNN8FVpqxcpwcxxaNEbfeoW7bMAbJ1zXN+Usr1zy5BQfhnkoA
 OkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786525320; x=1787130120;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BgSKYIJUMoNxYwsl8WEYRW2gbRH6qsht4xM/JR0yOHs=;
 b=WMJPKLAy+IpGjs0vcGdl8XEj3YY6uAPglj9jJAzvAqDMhN7OV9fWR4VA/tviii2Cez
 tPYJSQl2UWc64jBu0zZ4SqvAuu4nmurpZcBP0j6hoQgSCUvfc7H0+gc/yK2Y0BAXMaJm
 2wp6pXD/swgPQa5syzHjPavGcES5vRcZYlToyBono+NKqxdkhIdqaz9Y4tZD9TWa2P8n
 APqR8xWOjYUFl2W7q3oyZUYzfLYGPCs7dv4zqTEwy/Cfq8R3worYy9C9mvbjvLYUheAG
 QGp8PfhaiHcQKDnKx3AAf1pKo8JKw20h7NwOFLsEeSAqe7zavO8qmRjaOcJjBVZkut/5
 DLPw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoXCST4kDPmw+Dz1G08+kOFwLXnyj1zD5igXwHZlrPOnf/oDZdCed7CcC96QX8yoiIPnQwaxmvIYW/x@nongnu.org
X-Gm-Message-State: AOJu0YyTM2EaHMIhwyBpbcS9J5FP5Av7RqXk86m3gwCQs0zadXkrqnj+
 NCzEKrfDE0hgrVI/9rBnUAGa8msF2fzzKgeAYHd3tDsSmYDBsuMfom0imJ0N/ussyaPf7IkllS2
 GfdhAi5j+zpC7swY1KX3VP9F6pEDCKMusIYtehAAIOZ+jYo/8sW00qQUXHQ==
X-Gm-Gg: AR+sD11QGIQaj0YKuYafsyBFR9eMHzQ6pcOYikly78RzKnX75E82N6on2gPAMei2IPg
 JGLsRdYZXoDTW3XSwkPHbOTG3rmpCOk8drUrJYdO8pqaZ/1jpnqfLTpSvPaeUt5l0pmnMEy8w4/
 O1Bxo6xeKxjeQQdNrcwaS4orfDOIJLZTSkyVQ/0Zg/z49EcznB0uWTD0SqQ40OH0XgRYLuFRGjA
 hehOLAygqyRgtm5bIxFv/DY2xblR01F4jYiPADQ4BtL1S5k2SKjcQkK9yNdOoHArshoXqxRFrT5
 M/dEKjq/WFcFXKfl8CAWsUe+sIPUBNoN93veIDrpLbXcLzaM0cLW309/xSVHa0vA68cr3sJBj+K
 jMtEkBaF89QkUL8TTUzH/XPtH/V0oLWygv2s=
X-Received: by 2002:a05:622a:4816:b0:517:146d:2cb5 with SMTP id
 d75a77b69052e-52d603623c4mr57236101cf.20.1786525319860; 
 Wed, 12 Aug 2026 02:01:59 -0700 (PDT)
X-Received: by 2002:a05:622a:4816:b0:517:146d:2cb5 with SMTP id
 d75a77b69052e-52d603623c4mr57235621cf.20.1786525319469; 
 Wed, 12 Aug 2026 02:01:59 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997aaa4d2fsm58129535e9.1.2026.08.12.02.01.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 02:01:58 -0700 (PDT)
Message-ID: <62d1d21e-d9c4-4be8-8ceb-36a544770768@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 11:01:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v5 37/77] hw/hexagon: Declare hexagon TLB device interface
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org,
 stefanha@redhat.com, peter.maydell@linaro.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
 <20260629131232.2487780-38-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260629131232.2487780-38-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: A6l-GuVFCWzyOEtT_ETc6az18swqSpdZ
X-Proofpoint-ORIG-GUID: A6l-GuVFCWzyOEtT_ETc6az18swqSpdZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA3MiBTYWx0ZWRfX0V3tI4nNpMja
 2b+5x2lF6qluqrxWRxcnMOWX9/ne9ZmpksW2aBhlnWF8hrcl6a6T0xSbQZSx8R71dkkbMEwnQJi
 BVnAQ3x7ia05o5humQZPW4yMwJM/YZQmYSt3iiBovzMYW1Ipknhv+HB8Bp0YK0IeBZj38ZeNneU
 4VJmQjL81klMrO0hOR61/HWz/FTCT7ZHD6Rp3FMV7C2Z2ohXPork2FXVAQahn9llGWzQwk763/6
 co1IArdAH4M++1fbqxtKFUJW/uxKuZWtyZV6hk7N+aqhzd/DOaywJPxF8TjTDE48ht8bslpclNS
 RD5imZvE/wMUz9YKND0+5SLvFBxruhYppq4qFB127ItPQ52dVtJg4JutuFaVT5X61tWCLqyKLWQ
 QvOM7pK7CTiGbiHgEjTenz5sd+FlxNjcZhmIknAKc+s17yOpqYy83c8UkWCnaNSXoDG6xobZF9B
 7ojB3zt2kYL2hO7Stew==
X-Authority-Analysis: v=2.4 cv=VcjH+lp9 c=1 sm=1 tr=0 ts=6a7c3688 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=p82-Y-F8LwLdMHY-Bd0A:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA3MiBTYWx0ZWRfX+Aai3RWeuuI0
 XbGpxu/Hz6u3b3uuMPgmpz1Rsor382zXiPYMXhY6nNGTQfRCxgu/6YDy3AbEZ5qmvqYmicKX2lh
 iNV3l6PX+/FdtOccwZfXWifaLZK8CZ4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120072
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

Hi Brian,

On 29/6/26 15:11, Brian Cain wrote:
> Add the hexagon TLB device interface header.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   include/hw/hexagon/hexagon_tlb.h | 46 ++++++++++++++++++++++++++++++++
>   1 file changed, 46 insertions(+)
>   create mode 100644 include/hw/hexagon/hexagon_tlb.h
> 
> diff --git a/include/hw/hexagon/hexagon_tlb.h b/include/hw/hexagon/hexagon_tlb.h
> new file mode 100644
> index 00000000000..90d9ed84043
> --- /dev/null
> +++ b/include/hw/hexagon/hexagon_tlb.h
> @@ -0,0 +1,46 @@
> +/*
> + * Hexagon TLB QOM Device
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_HEXAGON_TLB_H
> +#define HW_HEXAGON_TLB_H
> +
> +#include "hw/core/sysbus.h"
> +#include "qom/object.h"
> +#include "exec/hwaddr.h"
> +#include "exec/mmu-access-type.h"
> +#include "monitor/monitor.h"

FYI "monitor/monitor.h" is not necessary: Monitor type is forward
declared in "qemu/typedefs.h" which all source files include via
"qemu/osdep.h".

$ git grep -w Monitor include/qemu/typedefs.h
include/qemu/typedefs.h:74:typedef struct Monitor Monitor;

I'll post a patch to remove it, because it is pulling in a lot
of unnecessary declarations.

> +#define TYPE_HEXAGON_TLB "hexagon-tlb"
> +OBJECT_DECLARE_SIMPLE_TYPE(HexagonTLBState, HEXAGON_TLB)
> +
> +struct HexagonTLBState {
> +    SysBusDevice parent_obj;
> +
> +    uint32_t num_entries;
> +    uint64_t *entries;
> +};
> +
> +uint64_t hexagon_tlb_read(HexagonTLBState *tlb, uint32_t index);
> +void hexagon_tlb_write(HexagonTLBState *tlb, uint32_t index, uint64_t value);
> +
> +bool hexagon_tlb_find_match(HexagonTLBState *tlb, uint32_t asid,
> +                            uint32_t VA, MMUAccessType access_type,
> +                            hwaddr *PA, int *prot, uint64_t *size,
> +                            int32_t *excp, int *cause_code, int mmu_idx);
> +
> +uint32_t hexagon_tlb_lookup(HexagonTLBState *tlb, uint32_t asid,
> +                            uint32_t VA, int *cause_code);
> +
> +int hexagon_tlb_check_overlap(HexagonTLBState *tlb, uint64_t entry,
> +                              uint64_t index);
> +
> +void hexagon_tlb_dump(Monitor *mon, HexagonTLBState *tlb);
> +
> +bool hexagon_tlb_dump_entry(Monitor *mon, uint64_t entry);
> +
> +uint32_t hexagon_tlb_get_num_entries(HexagonTLBState *tlb);
> +
> +#endif /* HW_HEXAGON_TLB_H */


