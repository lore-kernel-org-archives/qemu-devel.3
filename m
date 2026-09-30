Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B12ACA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 09:39:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBqmO-00043M-1Q; Wed, 30 Sep 2026 05:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBqmH-00041x-AU
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 05:39:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBqmE-0007yB-H4
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 05:39:05 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68U7dRHu1556147
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:39:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 G9znUFWp4/ikGNQv5GE1Vek2AqjWXxe+faMMxz6W1Yk=; b=AWplIIMVSLfHKySo
 GyGHMkVa1KJ7msy74xQnFckNA747ANW070B1sLO1i9Av+2mQ79wXgQfXOSN27Sx/
 3ZTorBtfcnYLPOtzlT2Vx5now25RstYuAHBpXmZQGd+mC9xsRSPBLlJnK8cMe7XM
 1xPutsJ0+x1uQ/v8W6Zr6R9HWoLQBq86YjzkFIMp/EuknkJ74IpxNTokjUJezV2E
 /8uqiBl6JIg8U4ZehqBdkqPEXkAnadAaGWzRciRma6QQA3IbC8trKflMKQOfBfTw
 8QOMO5dPu8x4e9+n043A5q9uXrKzM/ThAFdX8ufvdptB/rjX1wQEuQiVEUvnInjn
 i1Fe7g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0x1c0jjb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:39:00 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93caa0ce0cdso26839885a.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790761139; x=1791365939; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=G9znUFWp4/ikGNQv5GE1Vek2AqjWXxe+faMMxz6W1Yk=;
 b=LMPyP8ku0nWO5inagdaDLpsI3udSwY3bHMqm6wHf+TqNhuksiZYWR1de41syGEKXp7
 Uhm0Yf6k8ty4mML1Ci4QYAAU7vuJVZ13AGNQXtQMs0bXxbR1NscashS9ZKVrDQ2I1jMT
 R2tvOiyyhEUTuBne+8062iaQyE/Pz85dfa7sVrBkLSZqA8N5OSFY4Ufh1RN0Yz6rS8ML
 yT6Z+rRCrYaXBeSO8VaTYd85sNuf2Sn6QDrjMD1ikF9qOyd9bQsQlFwVyp/q9sJB7DWJ
 uZC64rYJ+y31nNm5+VwBM3af2kcaj/zwU+SzAVDn9yLWBTN3r0y+ZhoFwLDPbve+3i6g
 TRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790761139; x=1791365939;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G9znUFWp4/ikGNQv5GE1Vek2AqjWXxe+faMMxz6W1Yk=;
 b=JgAZKSqzdTwRrE+/ow1EltUhXYBjL/utdASmrMTjR/vGM1axhCTvTKhsecG3W8yUCB
 iD1fdWSt9VcqRTwSwQrkZZa+qogOBDVhU6iJKqSh6jUDFV/FeBMG/Uwvjg4HC4xjcivI
 12oIJlVlSbJ+GWyYJxuRF1WqUyxw6DR51NHnR6hiSkC6061y34pqAR6koD+xuZ0BLx9h
 SDjg40UKq0GCo7BhQE4KlLCIKvnbAU1gUCse+YmVJHpXttF5smKnXWSWfp8FRZT6lO8v
 Lhe1SfaWk/Y1IiuL3VECsq53V+Jieck4RpeIJJffSFPl7/gc5UBDZ4W9wiS9WNEiNMh9
 RRBA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJgKCtXlSCxHk2LJ9CmwICpHa5joJ19ifd+TwLeHO611i0RoI94xQ9TcGDNqJaSMeVOY7RAyLbLqUU@nongnu.org
X-Gm-Message-State: AFuF++nhVCkl3z72LoG+35H/2E2sZBDkcMS287g2YzisRJXzQcR5G5ZS
 0wKlxbFJVGdfNayZzhNEv8Ye3zrbYny0RPOG/78dF7W2ftU5g7Zg6GFVlFDmBd37CN5hC5CoDV3
 wp4MseAXT4YL9yiR7GCOimnMskNaIgHlnpd/GAgyD6t1uQZcw5Fjt2Bc/tg==
X-Gm-Gg: AYBFou2B8CYfYDqsD0Tn8t2watOIpikfWrQHwSEpVHyR3eISAX+AxtUTeKZoNYOe8rz
 0rHQMdY2OUtw70I/4UYW6ULU+CRGcmezYqA120ObdXNhhlrb/HQEex6kt1+7x5ePKfg3BU4jS7J
 1sfPrNs5V5GX9wsvSPAm4I5X2BSYDVEThBKFVFizMi9BAQKuaEkVB7N3/W1NPXqmQCC3plRMsiF
 +4y+OXDIbo1T+h6VF+CRLjSCfXe4P8lWYXuKc7zA4AVus42v4FB5mNugaNsIjozsu46aqEA+pNc
 H2YGYFnEF1g9AtMB++NgGGOZe0xzEuJao4wh7rkiEK7APP4V7B6ojB9sEIP35eEK2Aed1lg4XjJ
 B4+RRVCynBkrHcthoqXYSttjHPD6/e+qk+Jgy0us=
X-Received: by 2002:a05:620a:1712:b0:939:7e19:ac3 with SMTP id
 af79cd13be357-93ca9752a1dmr105569185a.45.1790761139360; 
 Wed, 30 Sep 2026 02:38:59 -0700 (PDT)
X-Received: by 2002:a05:620a:1712:b0:939:7e19:ac3 with SMTP id
 af79cd13be357-93ca9752a1dmr105565885a.45.1790761138831; 
 Wed, 30 Sep 2026 02:38:58 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0174e165fsm46956785e9.6.2026.09.30.02.38.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 02:38:58 -0700 (PDT)
Message-ID: <7b5afdcd-92ad-4760-b46c-5964d5853037@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 11:38:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/24] hw/misc: pfsoc: Model L2 cache controller
 registers
Content-Language: en-US
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Conor Dooley <conor@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
References: <20260904155758.3833179-1-bin.meng@processmission.com>
 <20260904155758.3833179-5-bin.meng@processmission.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260904155758.3833179-5-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAzOCBTYWx0ZWRfX6DR82QOt1F33
 vFo6Ye2oPtZuy91urV1bMV4xKcLWUcx4woa1y8YxAyD/jjfHptijdFIn6yr8mJuvwVqU4AMBMep
 w6d6qERyS2hHSurQYYNNKFTKz5yVgKE=
X-Proofpoint-ORIG-GUID: s9lCiuM0AejEVbD6M1Zvn-fbom6QyLiX
X-Authority-Analysis: v=2.4 cv=VrC2kO2n c=1 sm=1 tr=0 ts=6abcd8b4 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=FRSEYCzRAAAA:8 a=JF9118EUAAAA:8 a=X2DtDrvf2-FZo3jniCcA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=H4N_Y-AU75W7NKDNhZlT:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-GUID: s9lCiuM0AejEVbD6M1Zvn-fbom6QyLiX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAzOCBTYWx0ZWRfXzNkeKc0iCRdS
 HmKIfN3R9rA5VV3zL0UuV6OK0zYpdDem88Zydcx+zBuKPeRmWwf9TVvonVMpgneUWU5WdPSIHkc
 cuzn97t4Ul4kbekPi2iTZhgrVVNSf7GBBbqX+ZUpQWF3nBoi1WfqYx7liBNya1F8jLcW7nQLxYZ
 UWZdeCoWR5CDI19fX43Rzw4JLYo34SJC0l2fxwWrOIhTU/bzoQANLot8E6gHHIJZvKWgmgDIEFi
 NODWwOig60Jr9Y8DI+Y98wD6ngT8+972GIxt8i3Di+/W1YSUhfNMaGMsHI7A3qqRoxWmY8nvnOe
 7e1xC8jwt4HXCgQZj+huXizVmjh0ZdiT67Y/Wz3G9LOofsjVjCH1JKa9D6LgseRfiuuN2MaoSNg
 sbQU9fBPQkeMt0y+xLiPt0B5l/EWNqpSQMBKl6UE4K/0a+9tyYFi+Irz7NBmCcczI7LrZOUFB27
 sMwEv0ntdPnIKialjzA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300038
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

On 4/9/26 17:57, Bin Meng wrote:
> Implement the Config, WayEnable, and per-master WayMask registers
> described by the PolarFire SoC MSS reference manual. Make WayEnable
> monotonic and report the remaining register space as unimplemented.
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> 
> ---
> 
> Changes in v2:
> - Use the Resettable API instead of a legacy reset handler
> 
>   MAINTAINERS                       |   2 +
>   include/hw/misc/mchp_pfsoc_l2cc.h |  30 +++++
>   hw/misc/mchp_pfsoc_l2cc.c         | 180 ++++++++++++++++++++++++++++++
>   hw/misc/Kconfig                   |   3 +
>   hw/misc/meson.build               |   1 +
>   5 files changed, 216 insertions(+)
>   create mode 100644 include/hw/misc/mchp_pfsoc_l2cc.h
>   create mode 100644 hw/misc/mchp_pfsoc_l2cc.c


> diff --git a/include/hw/misc/mchp_pfsoc_l2cc.h b/include/hw/misc/mchp_pfsoc_l2cc.h
> new file mode 100644
> index 0000000000..1b5b3888d5
> --- /dev/null
> +++ b/include/hw/misc/mchp_pfsoc_l2cc.h
> @@ -0,0 +1,30 @@
> +/*
> + * Microchip PolarFire SoC L2 cache controller
> + *
> + * Copyright (c) 2026 Process Mission
> + *
> + * Author:
> + *   Bin Meng <bin.meng@processmission.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef MCHP_PFSOC_L2CC_H
> +#define MCHP_PFSOC_L2CC_H
> +
> +#include "hw/core/register.h"
> +#include "hw/core/sysbus.h"
> +
> +#define MCHP_PFSOC_L2CC_REG_SIZE 0x1000
> +#define MCHP_PFSOC_L2CC_REG_NUM  (MCHP_PFSOC_L2CC_REG_SIZE / 8)
> +
> +typedef struct MchpPfSoCL2ccState {
> +    SysBusDevice parent;

Nitpicking, 'parent_obj'.

> +    uint64_t regs[MCHP_PFSOC_L2CC_REG_NUM];
> +    RegisterInfo regs_info[MCHP_PFSOC_L2CC_REG_NUM];
> +} MchpPfSoCL2ccState;

