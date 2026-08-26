Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5483CC61DC2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 08:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz8jK-0000qG-ES; Wed, 26 Aug 2026 04:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wz8jJ-0000pB-A1
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:11:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wz8jH-0007bs-Nr
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:11:29 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q6Rlmt3689530
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 08:11:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xxo1fwcb+qkyCrnrmston4CFk/I1SyxJ8I2wPSzghlQ=; b=aLn5adhmvmcS9Psu
 dMsJk3YXVvxhPAWXEsYzyzh8j/qfIlHGNy4gB8zu/03rH9dsvgtH1DGkJyWTVr/V
 HN/XNgvgcA80qCki1m/Z7sgWZMtdXFAJWdA2z1BBcFFArHw4coCxhOaLdIn714qT
 JHi38bXAZuUXEJHzxcA7nrT/Xw3j/DewGk40E0itMAg5KYkD5SyLjqpNF2eA5JSB
 8ZcmnyoaGT7RPDEGqf6S1ehHl4IMZTda/YadpqL66VzLwSI0BVym99C/gpHt8Tz3
 HDDoHNPImzPPx5MQxACU6syl2Pab9AsPTvloZQqDrt1b9PxhAZDB64vl1MnaUrkK
 wxj2iQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9fjn2v54-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 08:11:25 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5174a236220so5812781cf.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 01:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787731885; x=1788336685; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xxo1fwcb+qkyCrnrmston4CFk/I1SyxJ8I2wPSzghlQ=;
 b=jE5dE3xJtpgDpk8bL24i1XV6jzgXWV6j9GTO1cnKAlHR0F8Yr+AWYbwp4gmqh7hxtm
 BJspOHlGCsoMFfgxci4KUNJpsYFB5JXJsUuAzX4YZeEquz2BZ1av9VU5FYvKpXfYYK1/
 EQzqNtBG1pHLRF8IFdBBOC4AHl/iW78PIkf2A69DpP5LQTX63QF+X9W3yCBeZp1G+PmO
 ox4QwzaSVFEG1IqJKhj1SemD/uzmlvpmLBdgS1GfIt1h7kqPmz0b6wScUpOHhjJbHJXH
 htvmxPuKLCuDfsQyGGwKjnTM9eUsyU+LhxNen8qF6DYOiZaa4GYeGn9gVnllTf7yaAY4
 L8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787731885; x=1788336685;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xxo1fwcb+qkyCrnrmston4CFk/I1SyxJ8I2wPSzghlQ=;
 b=eyqO9iQZEYJ98//ETqcG8A2i8fsVoOTqq2tfgJwgmPvDPnWR4IxmxhbxhOHbNIQ4y6
 isyHP5Pou7YXeU2WXWT5QpIpWDsqumsKxZVK5Rlx1OCouIw05sN5EzvN1bFVk9KUw5Vj
 5G8trcrkT6Ap+57XjsCXQvfj50SSjYfUaLwQNWrRON1ru+dhnskdssE9BR01b8/YL1cE
 mPETn8HDYlZYIYJsMcxxSJ79WHyzbXpoACVWBZM/yAfB+PHMMn27Tof+fDIiywdaiaxU
 A0/1JI+oyMKfIMuHFFOq7gCIWuFR1H3rBssaDsCcMPQjhDnPEBHl1f6/VpQhfpLL+SCK
 0ysA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqFBp7y4Sa4SlJC8uxTccILh/wLcgH3q16+eNrm4plXhIgpIeNwmbGCDShLSUwYBr4ea/bKc3hJBDcP@nongnu.org
X-Gm-Message-State: AFuF++k4+hnBku6hE6FFmonFOdU2ewU8GgjtHEDa+49IBHhskVBYVGxF
 HsuD81UI9CaCevFHHPL23kwoCHISAGRounLLI4IiULQ+Dq9lTRbATvk5J4R5tETczczgnby9L7z
 2gz/rsWymiVn3OgiRHUIIs18ngbeqaqXwrHOkEYKLgDZn4cxZGDL3PhaKWg==
X-Gm-Gg: AR+sD12g6KyGfC1CbUQeLaIv7ne0sxtW+9Z6QF3d9ZQnAMFha7lhDI9uuHe+TASWQhB
 4Fc0FAX6lOgFQo+3EhYKOdSeRWSiEr5DMhNnL6KOIr4qfCxM6WcqDEGgne6wMldo81RrYFb5lPS
 bN19EUh+2Z6w6EWyD6bB3jMnJLVJJT5UDUT/pwsHxmibkKKLDUVef/kVxpp0tQktDtwjbFazpIp
 g+eJodzoJMlhOKqdkV4BQHZ8B4I1hn2kd5vVc+RnIvfVdKREkkNuNb3GtujMqDKwnZc4PkDQ3kZ
 5cMOgNXenTf8AnJAfPhGLTRdQ5zPge0QJiDtXMLiW8ZnGHigJGOnT9kOELz9bGjt1QDz17YDEAR
 HgrmtQBp4ubwKb9Z6tZs1QdAp714QVW+cFHj7eh0=
X-Received: by 2002:ac8:7f8d:0:b0:519:f420:d780 with SMTP id
 d75a77b69052e-52e4234e850mr42998931cf.30.1787731885060; 
 Wed, 26 Aug 2026 01:11:25 -0700 (PDT)
X-Received: by 2002:ac8:7f8d:0:b0:519:f420:d780 with SMTP id
 d75a77b69052e-52e4234e850mr42994831cf.30.1787731879838; 
 Wed, 26 Aug 2026 01:11:19 -0700 (PDT)
Received: from [10.254.188.74] (14.89.66.37.rev.sfr.net. [37.66.89.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28f854dsm1887068f8f.36.2026.08.26.01.11.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 01:11:19 -0700 (PDT)
Message-ID: <5e22ac73-0650-493d-a099-c88cbb74b397@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 10:11:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/8] hw/char/cadence_uart: Reserve MMIO with dynamic
 size
Content-Language: en-US
To: Kuan-Jui Chiu <kchiu@axiado.com>, 163wangjack@gmail.com,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-arm@nongnu.org
References: <20260826074635.2850931-1-kchiu@axiado.com>
 <20260826074635.2850931-5-kchiu@axiado.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260826074635.2850931-5-kchiu@axiado.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: TD0G05sXsKYbqflVPdMlt4GY5GZoBY0i
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA2NiBTYWx0ZWRfX2BEJ0POhaKSO
 EH3TOKdRNSqqtOkKaN4wi+jmkfRoOdg3dJpnluGzWoBo60Y/zTPXs4b5L8IBa/Xbp14vaimJrN1
 dSThi7NlKAr6MdJCbIC0J+cYqUI5C/M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA2NiBTYWx0ZWRfX38574JLA0NDh
 PnL1J0l/xP1mJKZflNwE5eZNhjaPgilZ1wmEX7tDDPtxX1bta5DNnrH/QhcqIkvJJEJbCHO1rKA
 SmXZ3THxwq6cpv9Sze+9vzamglgRGUd+z60yndoNYJJQPaR1wSGAODp1ibp0GakFzvI25TuqQ/s
 KaeBod2L+P7ZgF/WrAHnPYVN2lhpODsj2OwBKQBJqTPkcWVKQfWScvAs2w12u2hgs7tY7gyrztP
 HnrJ5G2dsGG5D1LXItQdu8b97vsryHTr2PADWZ2JnuW6RQHygN74nF8rH0m5RWdYYmsxaQjxfiL
 tLeQ6Gse2Rgs7GK1PT/oGfuqdv0jOR39mknJJCto/qkGHdRzn3hqRIEt4USQY6M0CM53CpzjgnC
 xuJMWKkyj80V7QRBWQYHxQHB59l3LQSTNGcQuBZ1cnWmahVOgiKr7xoCqkFuEjJbT+pUf6vxjXn
 TD6c2CkPY+yuB1B+g5g==
X-Authority-Analysis: v=2.4 cv=ccziaHDM c=1 sm=1 tr=0 ts=6a8e9fad cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=JQZmDyB7+sUo+n2VpL1TLQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=440cDlBIAAAA:8 a=ouh_vfZ40caHO2bnYAEA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=d9D1X1bx8dWolqnE4HNT:22
X-Proofpoint-ORIG-GUID: TD0G05sXsKYbqflVPdMlt4GY5GZoBY0i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260066
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

Hi,

On 26/8/26 09:46, Kuan-Jui Chiu wrote:
> Candence UART model is reserving 4 KiB for registers statically
> For other SoC models, the MMIO size may be not 4 KiB which would have
> overlapping sysbus regions in QEMU
> 
> This patch adds a property which allows other models to revise the MMIO
> size and it is 4 KiB by default
> 
> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
> ---
>   hw/char/cadence_uart.c         | 8 ++++++--
>   include/hw/char/cadence_uart.h | 3 +++
>   2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
> index f57cad57a8..d83c71b877 100644
> --- a/hw/char/cadence_uart.c
> +++ b/hw/char/cadence_uart.c
> @@ -541,6 +541,10 @@ static void cadence_uart_realize(DeviceState *dev, Error **errp)
>   {
>       CadenceUARTState *s = CADENCE_UART(dev);
>   
> +    memory_region_init_io(&s->iomem, OBJECT(dev), &uart_ops, s, "uart",
> +                          s->mmio_size);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
> +
>       s->fifo_trigger_handle = timer_new_ns(QEMU_CLOCK_VIRTUAL,
>                                             fifo_trigger_update, s);
>   
> @@ -561,8 +565,6 @@ static void cadence_uart_init(Object *obj)
>       SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>       CadenceUARTState *s = CADENCE_UART(obj);
>   
> -    memory_region_init_io(&s->iomem, obj, &uart_ops, s, "uart", 0x1000);

Are we sure this size is even correct and not a copy/paste error?
We can clearly reduce it up to 0x80 (so far the last register
implemented is R_TTRIG at address 0x44).

> -    sysbus_init_mmio(sbd, &s->iomem);
>       sysbus_init_irq(sbd, &s->irq);
>   
>       s->refclk = qdev_init_clock_in(DEVICE(obj), "refclk",
> @@ -621,6 +623,8 @@ static const VMStateDescription vmstate_cadence_uart = {
>   
>   static const Property cadence_uart_properties[] = {
>       DEFINE_PROP_CHR("chardev", CadenceUARTState, chr),
> +    DEFINE_PROP_SIZE("mmio-size", CadenceUARTState, mmio_size,
> +                     CADENCE_UART_MMIO_SIZE),
>   };


