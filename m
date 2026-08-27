Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C2CC61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzXje-0001Id-Cr; Thu, 27 Aug 2026 06:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzXjd-0001IE-9S
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 06:53:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzXja-0001oM-OJ
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 06:53:29 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67R9GrTa3108325
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 10:53:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /+pBUL78aL6jR5JQt1qGGicqOnD9HNZjaq0DKQ87DGw=; b=Nmixq/C3xun3eGXG
 CGVG1tlmGBh07KYH+F9goeeBwj/PwpYxW/zjfYILVzj0xHGeZFYW4CbCeaoyfPTp
 +4pgum4mju6bS07aTZRrOOjXoby6v6j4DdvDiinNGKAdOm32e1ncxGhji5LPlhH3
 EmrY8TrEKA5FaFmfuCq3OtHhz7bsNi2DRdkyMG3SOkil7arkHf/qkfszVa7k3s29
 EXw5oHhlL9SLA8WH7gCg4HLuBcUvs+oCOoJdweOT/cFrgQUAZcHM2wLRpnGB9sOr
 vY2AgRqG7qvIYz59mbN2dqibnfxXG9jbmvh/e6rRVN3/Ob+JcN+58fZuzcl6Phtk
 +oyYtA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga6ettuqg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 10:53:24 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-936aa3d9dfbso84172585a.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 03:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787828004; x=1788432804; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/+pBUL78aL6jR5JQt1qGGicqOnD9HNZjaq0DKQ87DGw=;
 b=PQW0yMaP/n3R0PTysjGBQpsZE/qVOVi9ON28zSIcx1I2pMZI0GVmASr/opL6kee6P7
 KFlTYBJyrm8glBvl2AEXd6owJ7FmkBL/jFJVCRcYHNolTsXfY+Qy8sctU1wp3aktJdsD
 UNevC1XGTz7rUSyq/v+4g7ClncbSy1V64uTPrMvdZb8hZm9qtW2hExGROUQNbK4LyJgn
 +EiOJK+DeQtYr+wt+vJAuCIBniU0uNu96zcxdkq/uyng+jeKtO1K+bs7HlzVxsqI+1oz
 rdHSywtRSi8tq5WqOALBA6AbwoKWWTHS88Q5t+0vjXLBd5eMQULX03dNqrUYrR65ajvs
 CSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787828004; x=1788432804;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/+pBUL78aL6jR5JQt1qGGicqOnD9HNZjaq0DKQ87DGw=;
 b=PSdH2miZWodrggoyP00q5cSWBz+jlN8HWlqHZYfHAXiX4coxyzprtgLyl26dLq+qKY
 njykeosh1w+NSTrPlvLI3iTBSklTJl6BxaQAcfCVml82ppDk5xV/oSt/KxLidwljusxx
 8dX79dmfjxjiK3YfT3LXJRilwxV1Ug89dw1wpe1qewBMMMOPEihqGC/nV405JiDrEKKY
 rRb2NwNW5lGIugAtnS5V22CeSTJvt2ZDu9xvBZ6oEm0bq4A5UlLeW8Zq3DLygcGQOHDd
 do2vHBuLDIDMtWePLgkghIRGpYmN9+rIpc+g1SevbgTNyzxhgG+iMg9P6Q6T+dOWKBXE
 IpGQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpJ3VBYE4LMW0lEbMdQ/afLTuui/+LwvAR4RpBTvPgr11v8W0GmzqtawY4cQb9iVyvk+z6aJLhPnlrH@nongnu.org
X-Gm-Message-State: AFuF++n+nzBbFq6xO8pqVS1IKXLvXli2D1oBApLnwL9GDVF8IV2yoCX2
 xyAD2dmTK2F/8BdNpV+VOhl9JPas88LBIC0+KP5XJirE36DXTXOfCm0d0NnaiB4OUhPBbs18Uad
 sAja4O1aXlv6upCMwoUKjW4mM5OwpeFapam/AC2qnFM3+atfa09UUSvnpUQ==
X-Gm-Gg: AR+sD10hE8pJG0gQtaBcjjHub9DDGa4K7N7BkCAOXD33GUtAEopkw2ka4jColBZY6KR
 X0DJnmKQ8DdTbsGpm8VmakDPG1q+0/dBi+Ae6cJtyjQekJbhbdWdeA7u5ZKu+fxvrEzVv/mym7+
 8w4VVlzjfjm8gOrnbaYGSxGDetEd19M46Rq6ngW365e/WWeKNqsNjIqaBOpD1foSECVoStkj23F
 9MEVi9bYsnSzKab+5u0vyEvZUQNCWhVrXZZuc/0tu2CNAbvPIWhNF8PNdFE3YdoM8KnY6W9eb90
 5EUB7oBJFLHyrL1xyYp15u+ZB49un1c5vksKOQ/HlTyisB/xBz69CQv+dqM5DJyYj3+X30lM7NU
 8mx1imzOgTI0NnpSyAzPK59Hu+T6ail0LKbbf
X-Received: by 2002:a05:620a:618f:b0:923:7821:dc0d with SMTP id
 af79cd13be357-93780446b68mr1490489785a.33.1787828003913; 
 Thu, 27 Aug 2026 03:53:23 -0700 (PDT)
X-Received: by 2002:a05:620a:618f:b0:923:7821:dc0d with SMTP id
 af79cd13be357-93780446b68mr1490485285a.33.1787828003435; 
 Thu, 27 Aug 2026 03:53:23 -0700 (PDT)
Received: from [192.168.68.100] ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9377e30a2e9sm414898785a.2.2026.08.27.03.53.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 03:53:22 -0700 (PDT)
Message-ID: <4b5ac2bd-b7f3-4992-a85f-609183e06125@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 07:53:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/16] hw/riscv/aia: Take a MemoryRegion for the created
 devices
To: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260826220528.54516-1-joel@jms.id.au>
 <20260826220528.54516-2-joel@jms.id.au>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260826220528.54516-2-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=NrThtcdJ c=1 sm=1 tr=0 ts=6a901724 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=yi6NrY4SRzBuVuqO5NkA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: k-Ved7b37yXr3htPJLtQ5Y3jzzzYAzmP
X-Proofpoint-GUID: k-Ved7b37yXr3htPJLtQ5Y3jzzzYAzmP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA5MCBTYWx0ZWRfX8PRCgonVG7BO
 Sq2JCxU5E4X38u4HJiblyzdzbU68+m6vXyGk3exa1Yy0nVigh76ft9TIdefLyFxy4ohJ2GiKeqz
 TpjKKwmNBBb6x7Q0EtysYTirvjLubHTflUEuLLeeSPtolFKC7mPGyMyHI2/ZDuWfHFkx5DusT+o
 DarIo48S/cwnIcrYMWRS7x3jovdaKpV8Yj/GLJGF0gzPB1ZQrAJmMjAeEJ5xk5Jfh/XWz4MCift
 p1M2RLu8crSJncO3V2IjOxbDa+BndTv7YgQig9DWk+BrHFl06vmNXWEE49eSOnviP6GnSTQB8EA
 dHWFuKcGoUPEr/5qudFsatH8p6DloQWlXDtNWU+9i2AyVXejkJSyPLbyP0JTsDTIJL7rg6iP7Bn
 92evH9K6xfGSZTGzPindAVtIFnBFQAI4Dj2G/l1VHvViyhJ1/jkif/erZscH5qtYIklAA+OYJ27
 LYhdlsI2H3whzTrLHJA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA5MCBTYWx0ZWRfX8Oru+XuJJT/L
 I7ObFKIm1+43ZKsCCTeI6gkYg+RCZ6PqiBNxAXAozIlwGGIHcBbRFq/587WYEAYPn24/GnURiUK
 2IK7NhYwHUWQ6w7Mk9Nnqkaw9eb4KwY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270090
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 8/26/2026 7:05 PM, Joel Stanley wrote:
> Add a MemoryRegion parameter to riscv_create_aia(), to be passed on to
> the IMSIC and APLIC helpers so a SoC can have the controllers mapped
> into its own memory container. Both callers pass system_memory, so there
> is no change in behaviour.
> 
> As the controllers don't yet take a MemoryRegion the parameter is not
> yet passed on. Changing riscv_create_aia first avoids churn in the
> intermediate commits.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/riscv/aia.h         | 2 +-
>   hw/riscv/aia.c         | 2 +-
>   hw/riscv/tt_atlantis.c | 3 ++-
>   hw/riscv/virt.c        | 3 ++-
>   4 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/riscv/aia.h b/hw/riscv/aia.h
> index 3b6d7f962506..82ab601bf188 100644
> --- a/hw/riscv/aia.h
> +++ b/hw/riscv/aia.h
> @@ -13,7 +13,7 @@
>   
>   uint32_t imsic_num_bits(uint32_t count);
>   
> -DeviceState *riscv_create_aia(bool msimode, int aia_guests,
> +DeviceState *riscv_create_aia(MemoryRegion *mr, bool msimode, int aia_guests,
>                                uint32_t m_imsic_stride,
>                                uint32_t s_imsic_stride,
>                                uint16_t num_sources,
> diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
> index c1a5982856c5..651552c8f970 100644
> --- a/hw/riscv/aia.c
> +++ b/hw/riscv/aia.c
> @@ -24,7 +24,7 @@ uint32_t imsic_num_bits(uint32_t count)
>       return ret;
>   }
>   
> -DeviceState *riscv_create_aia(bool msimode, int aia_guests,
> +DeviceState *riscv_create_aia(MemoryRegion *mr, bool msimode, int aia_guests,
>                                uint32_t m_imsic_stride,
>                                uint32_t s_imsic_stride,
>                                uint16_t num_sources,
> diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
> index babce2b680f2..d69851df0a01 100644
> --- a/hw/riscv/tt_atlantis.c
> +++ b/hw/riscv/tt_atlantis.c
> @@ -496,7 +496,8 @@ static void tt_atlantis_machine_init(MachineState *machine)
>                               &error_abort);
>       sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
>   
> -    s->irqchip = riscv_create_aia(true, TT_IMSIC_GUESTS,
> +    s->irqchip = riscv_create_aia(system_memory,
> +                                  true, TT_IMSIC_GUESTS,
>                                     TT_IMSIC_STRIDE,
>                                     TT_IMSIC_STRIDE,
>                                     TT_IRQCHIP_NUM_SOURCES,
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 329ccdb5a7b6..22a607ed10bf 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1411,8 +1411,9 @@ static void virt_machine_init(MachineState *machine)
>               s->irqchip[i] = virt_create_plic(s->memmap, i,
>                                                base_hartid, hart_count);
>           } else {
> +            bool msimode = s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC;
>               int imsic_bits = imsic_num_bits(s->aia_guests + 1);
> -            s->irqchip[i] = riscv_create_aia(s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC,
> +            s->irqchip[i] = riscv_create_aia(system_memory, msimode,
>                                                s->aia_guests,
>                                                IMSIC_HART_SIZE(0),
>                                                IMSIC_HART_SIZE(imsic_bits),


