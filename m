Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF4ECD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 21:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRzFJ-0002J2-IQ; Tue, 26 May 2026 17:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wRzFH-0002Ia-Pp
 for qemu-devel@nongnu.org; Tue, 26 May 2026 17:23:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wRzFF-0007if-PO
 for qemu-devel@nongnu.org; Tue, 26 May 2026 17:23:27 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64QH1DnF2995558
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 21:23:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AcA4ZGv+erGhBuzcp1LpiN++CoeFRvvBuWKBzDqFiTs=; b=NzMHOJvvu+A4b54z
 uqWw4JJ7q8wi+EBloDZIMn4VcUAgGwNNvRTLCl2Mz0/8ddExzBUEwVNqkbzTqV5d
 zTRzPf56bkaJimyQdcHhabNAtTNuJs2vWrivIk0Exj2zvgRX2emC8bYhd6ZTWswx
 8CsWIN25Yo4hbbCtntAox5Nb8wFQjfRAGzq/EtfcP/oQp7QVp+3WlFnHJXVb99/7
 XzXHq1Y6oarRM7hOveCjR2qYjKXka8+9JjsNOIFlCVombquOPgoQDB4jWE/5A+D1
 Me0nF+ouc53XDVnrvVXLPuDq1iibzJHZHhei3PlOBJRnbMXGKVgCt9Br+HtFFfmB
 GZ2kKw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edcnnssrv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 21:23:24 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-516d4a9e852so74334131cf.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 14:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779830603; x=1780435403; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AcA4ZGv+erGhBuzcp1LpiN++CoeFRvvBuWKBzDqFiTs=;
 b=TsI0JZGCrw4um86KBgZE5dLnACoN6k0LAuN+Ldg0uPFp68J4U8PR58lDRnbyhIMi0F
 GXZ18rxoSQXbZtuO/elnRIgGylp4hQqDz0kpPaFqMNDyLBOp/Cp7h7B3SoDyLGFFS8TW
 rjLZo8/fCeiDKE0OyguMQE7B/BB34rWHlpU9E3rW1rJ2VVjme+o0YNUVw3yxSc/89PkY
 8gXZSYsY/TLWADwH4Xkj0fkoGrThpGvT4FNtmhjBZJzYcGnssD5uvPRsDChTJqvEUztI
 mi1vaYmF68zPu1/VKTRdi3UGODkDNVxci5CecngzlVyDNJJaK6tl5UAc/Jdz4+qq6e58
 EtBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779830603; x=1780435403;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AcA4ZGv+erGhBuzcp1LpiN++CoeFRvvBuWKBzDqFiTs=;
 b=hWmX91zqpoCJgF1+BcnLmuldhbaXtrsBscCzPwQ7HZ+WoOqQX6DoK0ec7cP7ejwcwj
 0X2weeWplWO0b6xJYe8mbLboHqmULvtXaHj2QLeFbbuIeTl0Rl0XTt477jyruQZSaG+m
 /1QX7K7OWjCe2/86Cem2Hz8eRgTroRkBGJMXjzVjxHqFyiIB8BqccJx3WOM1xnxu4EnX
 CeZx8Z1xr0+jwXLmpVx7QmSYpt3rz2y+gPgnezU0wff2Sj7Y/J/jp4YBiCJTfsMKm8cf
 4v7LJXsGfjv+6qG6o0VwBARJbkKTO1amp1fms2/WtVKQsoyIBI4+hsACyzAr4ayilSuG
 06TA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9hsG84g0OHjZzERL7vwRfGIUBXCvu0rZJHqkCS+xNdJ/JdTONydAsVDxvz2vECQ5yX1Zd61tPqBZWa@nongnu.org
X-Gm-Message-State: AOJu0YxyWzZ9eLteFIMjwux1GvNHqMtLOpFYk+fDsvCub70jWXclm38J
 5rr3wNpslypBYQfHubDHHsRIwN4W3p6US73AEVyN8NrluErI2TjS0PTzB0o4mCGEcTPKi22COp7
 mFZM8dPV/WsD65N5fJHQlK0kfK3fRUp4WbD4ydLXaM/+p0dJotdYWwozBrQ==
X-Gm-Gg: Acq92OGvuXip2X2+qt0u5P4lun6nYccJ+GykRvjP8TKbFXR3tzYxvQKdUwWdrVPeHQu
 G4odK/7fzkjQ8oIWdvsOjPHNgIBCpxJdMMHUE20kZuABmywwKEraSVvFBcg7niFb/ugegWCOFSH
 qTAEEOz6lcFK/vp4REDFkexZDvD4xCNDIqJbuT8u3WeI9CWlPYutWpWAzqUKkXbTeuA2dsD/nZk
 yc439VImPgURCce8cT1z5/4xqKRxeldbfzR6R8nD71IduBCwHBTRg2arRTglqc5JXhk0xLs3OfE
 4EcbPpl3/LHP9tvVGcjehPERa1iiI26+dPybLGBcZobbiJ9csHMvXt6yGO6tGCYnRMwqECgLjEs
 bJdDHMU8ZXP3sBkR+466NV4wc7TSsRzIpqIwk9xgceXchJ2se02A2MH8zGzI=
X-Received: by 2002:ac8:5850:0:b0:50d:5a11:1b5 with SMTP id
 d75a77b69052e-516d445d3ddmr283365291cf.17.1779830603434; 
 Tue, 26 May 2026 14:23:23 -0700 (PDT)
X-Received: by 2002:ac8:5850:0:b0:50d:5a11:1b5 with SMTP id
 d75a77b69052e-516d445d3ddmr283364841cf.17.1779830602807; 
 Tue, 26 May 2026 14:23:22 -0700 (PDT)
Received: from [192.168.68.106] ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cc81316d44sm150716436d6.42.2026.05.26.14.23.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 14:23:21 -0700 (PDT)
Message-ID: <d2c4280c-f8e8-4012-8650-225b73cb8b0d@oss.qualcomm.com>
Date: Tue, 26 May 2026 18:23:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] hw/riscv/virt: Inline TYPE_RISCV_CPU_BASE definition
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260526095731.63525-1-philmd@linaro.org>
 <20260526095731.63525-5-philmd@linaro.org>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260526095731.63525-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gwg0_GrprsLtUf0NIxXwFs_k89sQ-4X1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDE4OSBTYWx0ZWRfXxd2XVyFAOcnE
 vTxHUD8/Co50wLkYkcmK2KS8ENhVWjxFW22Ile7pqjBKtKvSU0f8y6F9cpP2h/g1uHpirsj/THE
 Xr+mlw82xM8eZJyEmhp1hBuIYlxNJeSsllvKCrruetuCSOCSpLqb+N6i3r6wqCzrTMQi2AsXudz
 KRO9UpVLL6zCpFAX08II2CHXS+y+xJK90NiUq0AD0+YSRL32OovuR9PM3Ooj3VjjXkKNXCFQsA9
 W3OcgQPzKpCTIb3P3C+bLcZSvSvDmXZPS0gozXNoitv6asww9FLwBssYqsOcNeXVUZqzM61rRCY
 XXbjmUmeqgQIIPOzvlYXVi6ES25M1H0l0/CPLHz6kOjSUB11RRMOli1DuhBAie0Vknq5Bp97H7T
 2xt/ymsl5u/6dfJbDLqcOsWyp3sWb7E4b9p2RnOoa+QTfdWPGmH+nib8hPLs6GABvjEwGtXabZ+
 xlbcHmPxDERTAUy2wYg==
X-Authority-Analysis: v=2.4 cv=VPHtWdPX c=1 sm=1 tr=0 ts=6a160f4c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=acQYp9IdyblRgUTRBEkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: gwg0_GrprsLtUf0NIxXwFs_k89sQ-4X1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260189
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 5/26/2026 6:57 AM, Philippe Mathieu-Daudé wrote:
> TYPE_RISCV_CPU_BASE is only use by the 'virt' machine.
> Inline it, replacing a built time check by a runtime one.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/riscv/cpu.h | 6 ------
>   hw/riscv/virt.c    | 4 +++-
>   2 files changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 7d79c7a5a7e..0d2ecd9d6ba 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -39,12 +39,6 @@ typedef struct CPUArchState CPURISCVState;
>   
>   #define CPU_RESOLVING_TYPE TYPE_RISCV_CPU
>   
> -#if defined(TARGET_RISCV32)
> -# define TYPE_RISCV_CPU_BASE            TYPE_RISCV_CPU_BASE32
> -#elif defined(TARGET_RISCV64)
> -# define TYPE_RISCV_CPU_BASE            TYPE_RISCV_CPU_BASE64
> -#endif
> -
>   /*
>    * b0: Whether a instruction always raise a store AMO or not.
>    */
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 3d06c9c6104..8371b28c27a 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -22,6 +22,7 @@
>   #include "qemu/units.h"
>   #include "qemu/error-report.h"
>   #include "qemu/guest-random.h"
> +#include "qemu/target-info.h"
>   #include "qapi/error.h"
>   #include "hw/core/boards.h"
>   #include "hw/core/loader.h"
> @@ -1932,7 +1933,8 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
>       mc->desc = "RISC-V VirtIO board";
>       mc->init = virt_machine_init;
>       mc->max_cpus = VIRT_CPUS_MAX;
> -    mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
> +    mc->default_cpu_type = target_riscv64() ? TYPE_RISCV_CPU_BASE64
> +                                            : TYPE_RISCV_CPU_BASE32;


As I said in an earlier message today I would be soooooo down to make
rv32/rv64 aliases of max32/max :D

Maaaaybe setting MAX as the default CPU for 'virt' could be a good way
to put our feet in the water?  Change it, see the amount of nagging coming
our way, adjust if needed?

But that can wait.  For now:


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>



>       mc->block_default_type = IF_VIRTIO;
>       mc->no_cdrom = 1;
>       mc->pci_allow_0_address = true;


