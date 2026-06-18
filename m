Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D262CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 15:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waEaf-0004BH-EX; Thu, 18 Jun 2026 11:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waEae-0004Au-2c
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 11:23:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waEac-0002nn-HL
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 11:23:35 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IFFuaK1914262
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 15:23:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AW1b6INDP6dauBkO7EH84AyBrMhm9Xp5ZuzuatRTFdg=; b=cN7PEtJPdjIqIE4T
 OiDNeUwCB98LEtCKnpuVeDfPIzAsjwEmi41lDiCsRcdOKGLJ57lMeMSQi89ikvg8
 79gpa3YU3dBHIUpngHeJqOhZ92Ofr0SSUoBObNRY6lObrXbyTYRwsRlBHpyh2lMN
 VBzjbBnPXXLwgrLIMUTNSPKfYbXh6BOLwKiRsMvE5Yjkprtt/SfST9b4Z2lp+Hcb
 qPozAeHZ2IuCWtZYZX31TvyuduRS1FBF4Luy7aOMyzYah0zgwVVfj9ohvJniIsCO
 hUGFPskE217c9QIaL6tOi3Pb9cNaqVtm1cGos6hxHSiLZJhTLARIvFGSSUsDe1Gv
 TSRWVw==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev1wc3sa9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 15:23:32 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5ab02fb3054so823912e0c.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 08:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781796212; x=1782401012; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AW1b6INDP6dauBkO7EH84AyBrMhm9Xp5ZuzuatRTFdg=;
 b=S8tyRE9FQ/ZvpoZVk6DGYVdYplnYD33sR7jE5Poia26h3nijYqDX+FCUQUwvCoSPYd
 EE7BuooJSSmlbGB/7Xu7AoTjo5GGZgCM72scSUKTV1s0L7jfPLBnAkzlvkr5TFZTwcLU
 LNSc5M244JlJ1PUuIgwTcLWFJT7nn0uPJB2yK/xIJDgf3BBAu6fWTBxPVdn760lSxhaJ
 AnECtmA+HTsj5QQU0Rlvrac9AAd3et2g8QQtFv/6SCJxvf9aebiw3NTbS6MJvGYOw+uN
 kOhrJJE3TuzuFYOJN8aKKk7h5ZTl7Zp1biFL+GxCMoRKds9UeF82aUd2cRXLkfgwhdh9
 74AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781796212; x=1782401012;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AW1b6INDP6dauBkO7EH84AyBrMhm9Xp5ZuzuatRTFdg=;
 b=UeuT9fy9Pnt56+KTcmc7i2ar773XUWpVOrZjIrZsXiv7JL4MpEyDhEjyQPBh8ACw1M
 d3TBGhKMqs4L2ZOZlQamP8TRUZjWJXFVIZqCBvbKMvzai12hUvZUC3DsuqjejSqjLf2l
 0FzWQrcije9+xU2cpr40I8aBr84K+ycSS7kXdqD4jmZjSjV6920LVaElrgxY6ziQYC7t
 siJvZSPNWzyK761y+16k/3FFnD3oxSN5pDEg2OdH2D6SX7AMkSTc+E9hlLzdLh6K2ira
 Uj68MQttZoott6LVywR/xT6fRAcKnZGL7OLm2We69KPLUCzbL7s0RY0Xlwz5iXlSd9dU
 85TQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9slotsQO7hHVTGhZjozTfVeyYryKxF+8dLFIvPFCnNieUc3mg41Kl3dxM/tfFK6XGX5PPkvH88LuP6@nongnu.org
X-Gm-Message-State: AOJu0YxL35bPDqo4LacPQYRvmEjDw/dovWH0s6vwIyN3YpOaiBURD6bj
 m42z2kEzdqHdCJ3VUUQxnBWI1vioqMH7vYug7eRrdb6rEplEz1uRZvNbBOklzn/YtG26mUVnBnh
 faG5wrM7OXAS4EAQIUKwia3Zcv0rmK3+BEQMeMR4cWsJ8hgxvfoB/xiADhg==
X-Gm-Gg: AfdE7ckjGSEoBqmbzK1fn3LrXTvagUJlisn9K1+8HylCutIGYvJyE880Rg+fZdFawFT
 EoSyNGQDjDiHKyISjHsF1f7WcIGnVZ+5QHA7EB6zOI5JteL/3E1SqRyx3DhLP+DQiqaSUf0519h
 swq8eRNv1DbrwKKcxrJr9LJhNfYGGEHZ5NSiK6Vn316LFFNZc4wLaLx5Up5BflxMs6i6gQYvKgk
 YtwsDVCTCf4+/5dB6omHm5h2dvQjNOX3QwCpo4kIy0iK/BeAF38Rd/ATenA5ndqAdcXOELizSBG
 tM3DAkPldzFOGy4BF7zrPQ3G5sYaP93HGbFlM6GK3gEZ8KnAUnBeu6df1X96/VfHlvoVN96v9Dm
 JZVRhFQNoYYhhNEU0cJOkeAcggKsPLJJViWHZMIfcyYUBQCAum+1nugk+NmQC3w==
X-Received: by 2002:a05:6102:4420:b0:6d3:aad5:6d16 with SMTP id
 ada2fe7eead31-72a03c923a8mr18359137.16.1781796212030; 
 Thu, 18 Jun 2026 08:23:32 -0700 (PDT)
X-Received: by 2002:a05:6102:4420:b0:6d3:aad5:6d16 with SMTP id
 ada2fe7eead31-72a03c923a8mr18322137.16.1781796211576; 
 Thu, 18 Jun 2026 08:23:31 -0700 (PDT)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49234daafc7sm139523115e9.10.2026.06.18.08.23.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 08:23:30 -0700 (PDT)
Message-ID: <9af9e1b9-7489-4ef8-9a33-1d5171a8e9a9@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 17:23:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/8] hw/misc: Add AX3000 clock control
Content-Language: en-US
To: Kuan-Jui Chiu <kchiu@axiado.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
References: <20260618101249.2926976-1-kchiu@axiado.com>
 <20260618101249.2926976-3-kchiu@axiado.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260618101249.2926976-3-kchiu@axiado.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TMt1jVla c=1 sm=1 tr=0 ts=6a340d74 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=440cDlBIAAAA:8 a=9hYmrlcNkm89KO6uUzoA:9 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22 a=d9D1X1bx8dWolqnE4HNT:22
X-Proofpoint-GUID: P24pi_aKGibhnl-2PcDXFScwPV76tHyv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE0MyBTYWx0ZWRfX4eb6tbkHTl0K
 zNngu+AJrLV/bV2ffapuXh+3EVSx00IBmFDjjnzL4hBvSk3fIVRzG4aR9n69xxyAUNCSPe0kSvr
 TyvJwl/PBy1hVkL7mBX9s8N4AwkkkF0=
X-Proofpoint-ORIG-GUID: P24pi_aKGibhnl-2PcDXFScwPV76tHyv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE0MyBTYWx0ZWRfX+uTvUVRTyH5M
 xe+B4RLdn1LVznu0Brb19bl9EeLhUl6cDN0NFXvtYab55f1Qx4jknC3pnCGluzqrTTa00FMrn3i
 IhUt9PuyzchyZdmzfmKMoLF94hqpb9S6duJ9gaAglChKXiE9oa7VBUzs/LsmEkXGFs4gZzRyfbM
 qj9w3DOPyl1GVsShDe73sIjFX/04An6wuaF1z0AwGT12GIPn6XQ1JiFaASHCOVSOeEeCrAWwp4F
 ld0KpzmEi3VTLl9LM1PNAO/vM0WVJSxZIlBaJ97s3xfgbGnM8GQPtWH/NCO4wsBjD8nZC7tv1es
 UKbpF4aOQBo79SeAyDDcN4uJu0sJj1pLLJuCnvnfdpZ8+UiMWalCCPywiWdYRELbgCx9LZnQd9P
 XzBN5ZbTSJ+VZw7n52ILUckwbQKZLw/g3Ag0BJUgtMscqwsXI9lpP9wlVBBRIxrtiT+gwfwSiJF
 5uo53SCM2dIi7kTguoQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180143
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

On 18/6/26 12:12, Kuan-Jui Chiu wrote:
> This patch adds a new model for Axiado AX3000 clock control which supports
> to read ID and status
> 
> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
> ---
>   hw/misc/Kconfig              |  3 ++
>   hw/misc/axiado_clk.c         | 73 ++++++++++++++++++++++++++++++++++++
>   hw/misc/meson.build          |  3 ++
>   include/hw/misc/axiado_clk.h | 26 +++++++++++++
>   4 files changed, 105 insertions(+)
>   create mode 100644 hw/misc/axiado_clk.c
>   create mode 100644 include/hw/misc/axiado_clk.h


> diff --git a/hw/misc/axiado_clk.c b/hw/misc/axiado_clk.c
> new file mode 100644
> index 00000000000..6967a5995c5
> --- /dev/null
> +++ b/hw/misc/axiado_clk.c
> @@ -0,0 +1,73 @@
> +/*
> + * Axiado Clock Control
> + *
> + * Author: Kuan-Jui Chiu <kchiu@axiado.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/misc/axiado_clk.h"
> +
> +#define CLKRST_CPU_PLL_POSTDIV_OFFSET   0x0C
> +#define CLKRST_CPU_PLL_STS_OFFSET       0x14
> +
> +static uint64_t pll_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    switch (offset) {
> +    case CLKRST_CPU_PLL_POSTDIV_OFFSET:
> +        return 0x20891b;
> +    case CLKRST_CPU_PLL_STS_OFFSET:
> +        return 0x01;
> +    default:
> +        return 0x00;
> +    }
> +}
> +
> +static void pll_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
> +{

Again, is this allowed? Could we log unexpected accesses?

> +}
> +
> +static const MemoryRegionOps pll_ops = {
> +    .read = pll_read,
> +    .write = pll_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .impl = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    }
> +};

