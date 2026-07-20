Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A95FC44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:00:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlliw-0001SB-Qn; Mon, 20 Jul 2026 06:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlliu-0001Q5-8T
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 06:59:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wllis-0002LC-9O
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 06:59:47 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KAvRmE2183568
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 10:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lgeLUIax3jItt7XfPslB5Mu6uF+d3Jh2bISzvadPGuY=; b=a8CTsQW+Kr190odb
 5IwbgQde8zBaM40YXzwXlxa5hD5c72dqNOtu6x6UGQH0LnfY5gw4w9QK1xsr3Nar
 Hub4YSLQNv03jYNZ2DfKTLRSjDyzJELQ9COdCz2kUOR4weXd3qVFrxrWOb3u5TG3
 ywoN1otsiIlrCKCwZ9k6l2xXDKFflXvW045bZlw/v+tBqyN563YTisZvLYFbZ2se
 ft5rg1W+LX7qRLUa9+a7Spq33/FCWJy7ef6Q13iUspgHwR4t73P5fuAITJ2MAwSY
 96+qnGueNv8JPGdSJ+fiq+X+bol3LFNyF45gohbxikHNW9ONehypm0Qy13Z67B1q
 gm/5oA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhggg8mk0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 10:59:44 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c0ab07320so138712691cf.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 03:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784545184; x=1785149984; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lgeLUIax3jItt7XfPslB5Mu6uF+d3Jh2bISzvadPGuY=;
 b=HO5FbTa8j6jj8x/70sgCTaMVTMcu9Dr4zIdShAicdY2MEP7u0x2GTx5WTbTB4UTgzF
 XNpmLSAY4hXNAgjYfhhr+ZpCObdrCBVlalafC3BgtZq2QwZY72PblsIrO+7DMrrZwVub
 I7SU/b2EIqafaKuSVUW9giWS3N2LG6KbeYxJ1RuhAfPMRH3Y3IAr253fmBUvoBCj5urJ
 nn6qPRRu1l41UGDfTYWThElYfa9qDi0c3RP9E5GcNFVg4v8NwXVg+otcVX62sfoSl0ZB
 T+WpW3wQFyIf47TT7RJkBTGjLOLpZeObXgUbGMVtuPHCWYDzFD1+2pgE4WvViC+kndpI
 WA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784545184; x=1785149984;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lgeLUIax3jItt7XfPslB5Mu6uF+d3Jh2bISzvadPGuY=;
 b=aXWZmtrwHK3Z8LjlPlpZ6Q+Yan1nh6SOy8h8whbdvk/WkEM/2vlFLLVkigsPJnlLoz
 OE9FzfwIS5eEgMbqFV+OGlaBW0KWDnoHoSrIHj4ORNk//Ih+sqziQNOz1nur2Imi/9oX
 JFsFyuxOvhZOknOoBBdS4+R966JGKuAhWi+Yhx6sB1Vv5WxwDp7NFWgROUhW1k0g/pF2
 Pet9XMmgF7rJHrx48GkYiniww3Q051IX4G7n8mORwCtaBL5zpOKJhVN38lVmTq2dBtBZ
 zdtImCuVpIUC6KS8SMYLe6Pr42Cl/IzIE4OefD2gyq2htqBboXHEZGKZ3RZV0RHHiX7y
 4xag==
X-Forwarded-Encrypted: i=1;
 AHgh+RrZad7ehAbdlqgV5pIhTFrhB0c7qyFBObR8l7uTh7LsorfG/oTqdfDWWA8QGgxppHQlPK4dmBtDKNyp@nongnu.org
X-Gm-Message-State: AOJu0YwVsivAFALwAbT29+EdmyFdnOzp8YyIy0ZzrjgKjHaeNfWdzQwq
 IMnBSoILRleJnxZDi/5zmvoyaMHwmI6MX2I+2m4PVacDB00Wegwb0kdbTwryQtIkrTWFAXTzJ0R
 Ls3CL7Ef7h1TaDiwYg244BP35gUT/3GIqZm9IgPms/QQ6b99+aTYvshbsRw==
X-Gm-Gg: AfdE7cnENBxe1IXr0ZV4qf4U+sTG+MW0GXjMgXN3/NT879c9SZGnekJ8SL5hHcj0TuW
 GK2Dao6nBvFgcI/FBbTgmzmeUJ8rjynqRPcLYndxze9jJbrptH9rUn0c/CstH/Ob37Xt9QzKAcs
 DxnsC7KQ721jCS7LxIPFWjAsUdyfOS8IRnW2OKlOH1saGhtounafp1uhxNJIYdh4g3c71muvpi4
 UCP30gh6pmj7LobV+dUB614qVfKE4tjconXZdiw5tVwqPyxZWL22H2AYJ/Lo+gXbCC/ed4Zsyfz
 zs/OY4XKCMw6O0eoIrxALacK7/TcuOtB6fm6ffv0w5AJnM2hHKLnece+vJd0x3LloO/K4TY5G6V
 ZYevRLrS/qCxiLu7u0rN9Sfbs365IRs0EF8NmTx+2PityMRvJ9z0=
X-Received: by 2002:a05:622a:1306:b0:51c:7d0:7ed7 with SMTP id
 d75a77b69052e-5213b72be5amr127853441cf.39.1784545184072; 
 Mon, 20 Jul 2026 03:59:44 -0700 (PDT)
X-Received: by 2002:a05:622a:1306:b0:51c:7d0:7ed7 with SMTP id
 d75a77b69052e-5213b72be5amr127853241cf.39.1784545183649; 
 Mon, 20 Jul 2026 03:59:43 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e49469sm30066877f8f.7.2026.07.20.03.59.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 03:59:42 -0700 (PDT)
Message-ID: <a3eea16c-9d47-400e-83ca-b59b02dca5b7@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 12:59:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/10] riscv: add RPMI system reset service
Content-Language: en-US
To: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20260714075659.2258023-1-subrahmanya.lingappa@oss.qualcomm.com>
 <20260714075659.2258023-6-subrahmanya.lingappa@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260714075659.2258023-6-subrahmanya.lingappa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: KDhKEq4kARZi3b8Bbn2r7iFooYR74b2m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEyMiBTYWx0ZWRfX4iXVoWafxqxq
 xNGh+RzGUOtbKDvicqS4WlF+IbI+Jc5Cg5O2jGYpBj/ElXDlzNP4RqdbFu3QA2+0iNjGxJ8nm9t
 Xk418koqk9MWp6cA3shaJq1ONwoiuVgnsOV9eTOeilrZpe/EoV46jwOqqHfV/hRUn4b6sTfOvSq
 eeQR4cBNOF/oCgA0IKCFCBDoIwfcdx53SEUDrIdkLnbC89H+vsmg34ir7Xah9GsvhTw12hPmQ6A
 F4hItm/Wm8kUoEplD3teJD0KEDkqUFfra8P66VU2tvIcakO54wWbF2EUH/8zXTNlCcPaHpWykG/
 WCsu+1zXIPOzCTRQCR9T2GgTackSkZlFqe0PhvA/Rgs1n/zDOEZCR0xz1LHr3REI/XnEvSpwAOG
 2+KJdV6OaY1ogYgZbioV9aMcrknFubtvOhEc0yKpEpUTbDKWH1OmDoGK98vR1x6M1/3DryD30AL
 9bNPplbH3eLSfOdNPuA==
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a5dffa0 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=wGTaG7l69bja599SoXAA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: KDhKEq4kARZi3b8Bbn2r7iFooYR74b2m
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEyMiBTYWx0ZWRfX/qKGf7geGk/k
 kQUxbY4XlDv8zMlI/9NQdZ/m9tWyycBYe6coDGL7PihFZAkohyMA+rGivu2wehAnzMbTEGe35Y1
 pHYGqqipqkER0G7Wy19SfIQwL6vxtbw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200122
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

On 14/7/26 09:56, Subrahmanya Lingappa wrote:
> Add a QEMU implementation of the RPMI System Reset service group.
> 
> The service advertises shutdown and cold reboot reset types, validates
> guest requests, and dispatches accepted requests through the machine
> reset and shutdown callbacks. This lets firmware use RPMI reset commands
> while keeping the board-specific reset policy in the RISC-V virt machine.
> 
> Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
> ---
>   hw/misc/meson.build           |   1 +
>   hw/misc/riscv_rpmi.c          |  38 ++++++-
>   hw/misc/riscv_rpmi_internal.h |   9 ++
>   hw/misc/riscv_rpmi_sysreset.c | 206 ++++++++++++++++++++++++++++++++++
>   hw/riscv/virt.c               |  40 +++++++
>   include/hw/misc/riscv_rpmi.h  |  13 ++-
>   include/hw/riscv/rpmi-fdt.h   |  11 ++
>   7 files changed, 313 insertions(+), 5 deletions(-)
>   create mode 100644 hw/misc/riscv_rpmi_sysreset.c


> diff --git a/include/hw/misc/riscv_rpmi.h b/include/hw/misc/riscv_rpmi.h
> index b5d8a32f9b..d11db87731 100644
> --- a/include/hw/misc/riscv_rpmi.h
> +++ b/include/hw/misc/riscv_rpmi.h


> +typedef struct RiscvRpmiMachineOps {
> +    void (*system_reset)(void *opaque);
> +    void (*system_shutdown)(void *opaque);

What is the plan for this @opaque argument?

> +} RiscvRpmiMachineOps;
>   typedef struct RiscvRpmiServiceConfig {
>       RiscvRpmiServiceKind kind;
>       const char *node_name;
> @@ -56,7 +62,8 @@ typedef struct RiscvRpmiConfig {
>       uint32_t a2p_req_size;
>       uint32_t p2a_req_size;
>       const char *platform_info;
> -
> +    const RiscvRpmiMachineOps *machine_ops;
> +    void *machine_opaque;
>       const uint32_t *hart_ids;
>       uint32_t hart_count;
>       const RiscvRpmiServiceConfig *services;
> @@ -73,7 +80,9 @@ struct RiscvRpmiState {
>       uint32_t a2p_req_size;
>       uint32_t p2a_req_size;
>       char *platform_info;
> -
> +    const RiscvRpmiMachineOps *machine_ops;
> +    void *machine_opaque;
> +    struct rpmi_service_group *sysreset_group;
>       uint32_t *hart_ids;
>       uint32_t hart_count;
>       const RiscvRpmiServiceConfig *services;


