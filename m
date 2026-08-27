Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D926C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:56:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzXlr-0003TY-Dd; Thu, 27 Aug 2026 06:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzXlq-0003TH-BN
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 06:55:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzXlo-0002rn-Do
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 06:55:46 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67R9I4PK2462384
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 10:55:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KBJPDc/62a7jiY080oygW50ZOAl0PZ8y0OIixkS/R60=; b=PJXN9Xz55DzOop8N
 tVBNa0IzZn2J5WpMJvcGYTJ8Pp9fMRBKjMlDfpdYozDaQNcy3RA+E4m9WPAWjO6Y
 428IF89qO48Itq4LOMBC+iXuSjCSCkC4D6V+aNFDUG9IfdMTo6y5/uiq53fe2pMG
 6nv/kjd6k1HBONxtRy8s+7gYRvJoGeVL+dom4yHifhNAGsMugrvn4ORRCkvdfyWE
 JQRTNuq0mFrCOPyO8QaPnuX43Wfy+3IOU/HmqKLdBZbtzxNeYIsgzUMHg8Fu6XEf
 3rrYs2DbYLtIE31ZLaWStX1B/bz4kOx/qQuDhunqpsiXNTgcvSd2l4INAbRuoX1L
 hdLBNw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gaa3bj613-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 10:55:42 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-938153538caso258652085a.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 03:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787828142; x=1788432942; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KBJPDc/62a7jiY080oygW50ZOAl0PZ8y0OIixkS/R60=;
 b=iuL9m0sAJZGBaSnq9sdTOQEzLsCJndLaghl8/0Q/ZoIaIGAObInGRV2qz0jLjZmmMT
 Jc32Vy0zNaC7YDJBQgNt5YE8TEnhgFlOxOpR3xaGQ0wJUsPInMbJz3wviLjl+qFJjDNY
 qHHSh44zG6oJfknBWl3EE9JLYTIN2SyH9/9uWn3bHsnSmicFVu0FbxQ0gRnSXwgfvNG8
 ri0wqoqylA8slkldxaF/YaN2E44xdNZQe4lxYnljfryNsQgzGwgjJNSwF/MNI4Exz//o
 mOcRBdgkzChDncpb+S8+iYlgB0rHXlsD5ONr/iuKr57su7iT3swvDKvSVpWJ1xJixaHe
 Lv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787828142; x=1788432942;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KBJPDc/62a7jiY080oygW50ZOAl0PZ8y0OIixkS/R60=;
 b=aedG0fjoMNgXJRl3gZ4RDztRaMLgqIllqXVp2lrsgibKor3c2hB9RfDuxFYRp9fQyn
 iUo/m/qDO+NegM78AK/gwrWrZO1DuC7WrRCa22i06YR8E41/3GbPci5uDJ3O+QIknQXV
 uFEcOFBUX+wwXuPv400XWSsMlcjNgYZHbpcjr60Znwxb3FEqmRVt2bEH5udYmMP0xKLh
 J/HkN9iifp0cvsaoZ6veiIr3PGg0HfBOuYG1gaSmQRdGHkWdA09d9S8aIITdFBQtlb9s
 Fxhj8nwYi8yzTxUiiETamopKJkHwkj87c1ysgMTDJKD69Z8eImF6Rn2VZ9k2ha8yisFe
 o7GA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqP3qKs0vYNq+5RZ1xqcP6+omJ+V7RVgDRDcUthMfLonDpJ2IaKRd8Im3zcjuvcd9fNstjixKL7MgM1@nongnu.org
X-Gm-Message-State: AFuF++ml3hyBf6mcVZNVmOfh7CQcQSfbjpKksQu242IIqPgFdgn+dZKt
 8QnrpWTnfF/61TcV0qCj+V//t2aiQ2njitIzYhycelGf88gLiWjFRKVeCeKzB8sSNjxDCCzGiKv
 Y/WIHxP5kQhaRXQgxMk1nxlz5W0s6Gqk9H5zfaFDigOKklE4huPZDFIIscw==
X-Gm-Gg: AR+sD13nkZPwwc21MbW09oem134bzDn45F41YXIoIvTvx8vBlDuLcurEUT1/QYAl87O
 zkPpUJIJjJY0LawCw0hC/VEzRortRy1Hm+RGAA1xQDWTbEqhS6h7LEp3Rz8ayPu33XwnnA9WR7g
 TrleEh+HjbiSyg/uYhiThH8lQvPhFMbbL1iZrmFstuZ3da05iitdszd0356JvM/ujgTD/73jAQw
 zye45lhGAbSZjQ5nKanWPHbu9IlCVQY6PKziueZkb3RsWvuZbjmovyzLYWilgeMci2+q8IqB81E
 rjO9UsrDg8nMsi3t08PRYkiL+qGtol5+pkeZH90BjQDBsKuU9GwS6nScHQjnN2SMbhXXzChBnDB
 sRDvIV7q5o/J1ICxipOFiaSa3NjxKFu0O3Kby
X-Received: by 2002:a05:620a:4725:b0:934:81ae:6d1b with SMTP id
 af79cd13be357-93780490d62mr1280665085a.22.1787828142306; 
 Thu, 27 Aug 2026 03:55:42 -0700 (PDT)
X-Received: by 2002:a05:620a:4725:b0:934:81ae:6d1b with SMTP id
 af79cd13be357-93780490d62mr1280660285a.22.1787828141863; 
 Thu, 27 Aug 2026 03:55:41 -0700 (PDT)
Received: from [192.168.68.100] ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93785a15ef3sm326438285a.40.2026.08.27.03.55.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 03:55:41 -0700 (PDT)
Message-ID: <4e4a712a-51cd-4880-8895-b3f0f2883b0c@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 07:55:37 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/16] hw/intc/riscv_imsic: Take a MemoryRegion for the
 created device
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
 <20260826220528.54516-4-joel@jms.id.au>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260826220528.54516-4-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA5MCBTYWx0ZWRfXzB9/YSmSspeh
 rJ4MvckbkAsQFUQOyrPGDnAGuqD5BRGWFjIk51+kHRQPzeylNjHOMYl9rgAfDeiMWvXK8yT5qmW
 TqCKdK0pI0LjCkfAYufFbVD++Hr9hJRFR7ouCof/scqzx8bIRdx8K/jwDDHf4sWcSRrXHq8VXmR
 HCxtfoZvdp/8+ZZCE6l4THo4XW7naf3Rg+RYq4L8HqyPnyldosgqu0g0ysMe42VT+HHz9SBHN4/
 R2ud9+vCgXc7dYyVff5q5rhAtaxZvPJGkmUnFG3M635ZSeG+tBiaKxxrU05hS+MGK1Hj87iu6qU
 q4Fzaw0uZTJHobXGVg6+GXwMnhWWKsDzhJpAO42qx98MBh+/GeyXuihyjGfaoYxUozMIeFba/fS
 os6Yfc4uxVI/g1E7/1cAETG/nUTdThvgoBDMG/Q6+VIMrGINFxMs900qEEj97GnAqvQ1Pa47ymk
 IyeidOPTLtFapKVDrOA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA5MCBTYWx0ZWRfX0VlpO4FRHt9U
 FdSMZkObN1taWIazlEl0yPU7UmLQ7dOMd5pPHoOX5/ndWSAG9WZm5JBrCFPpenZ7aJMm+JOaypA
 fCG1WxerP3p7C7NWiFXCXm1hFPpQT4M=
X-Proofpoint-ORIG-GUID: xMURiP9BghDVL-Y8AOCTiRucGCKokiof
X-Proofpoint-GUID: xMURiP9BghDVL-Y8AOCTiRucGCKokiof
X-Authority-Analysis: v=2.4 cv=KbfidwYD c=1 sm=1 tr=0 ts=6a9017ae cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=2b0TUu-kZssljZTJo2oA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270090
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
> riscv_imsic_create() maps the device it creates into system_memory,
> which prevents its use by SoCs that map devices into their own memory
> container.
> 
> Add a MemoryRegion parameter and map the device into it instead of
> calling sysbus_mmio_map(). All callers pass system_memory, so there is
> no change in behaviour.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   include/hw/intc/riscv_imsic.h | 3 ++-
>   hw/intc/riscv_imsic.c         | 6 ++++--
>   hw/riscv/aia.c                | 6 ++++--
>   hw/riscv/xiangshan_kmh.c      | 5 +++--
>   4 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/include/hw/intc/riscv_imsic.h b/include/hw/intc/riscv_imsic.h
> index fae999731dff..8295b1f14452 100644
> --- a/include/hw/intc/riscv_imsic.h
> +++ b/include/hw/intc/riscv_imsic.h
> @@ -62,7 +62,8 @@ struct RISCVIMSICState {
>       uint32_t num_irqs;
>   };
>   
> -DeviceState *riscv_imsic_create(hwaddr addr, uint32_t hartid, bool mmode,
> +DeviceState *riscv_imsic_create(MemoryRegion *mr, hwaddr addr,
> +                                uint32_t hartid, bool mmode,
>                                   uint32_t num_pages, uint32_t num_ids);
>   
>   #endif
> diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
> index d6b46cdca220..26dd10a0462c 100644
> --- a/hw/intc/riscv_imsic.c
> +++ b/hw/intc/riscv_imsic.c
> @@ -495,7 +495,8 @@ type_init(riscv_imsic_register_types)
>   /*
>    * Create IMSIC device.
>    */
> -DeviceState *riscv_imsic_create(hwaddr addr, uint32_t hartid, bool mmode,
> +DeviceState *riscv_imsic_create(MemoryRegion *mr, hwaddr addr,
> +                                uint32_t hartid, bool mmode,
>                                   uint32_t num_pages, uint32_t num_ids)
>   {
>       DeviceState *dev = qdev_new(TYPE_RISCV_IMSIC);
> @@ -518,7 +519,8 @@ DeviceState *riscv_imsic_create(hwaddr addr, uint32_t hartid, bool mmode,
>       qdev_prop_set_uint32(dev, "num-irqs", num_ids + 1);
>   
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> -    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
> +    memory_region_add_subregion(mr, addr,
> +        sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
>   
>       if (!kvm_irqchip_in_kernel()) {
>           for (i = 0; i < num_pages; i++) {
> diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
> index 651552c8f970..49cb14349f00 100644
> --- a/hw/riscv/aia.c
> +++ b/hw/riscv/aia.c
> @@ -52,7 +52,8 @@ DeviceState *riscv_create_aia(MemoryRegion *mr, bool msimode, int aia_guests,
>               /* Per-socket M-level IMSICs */
>               addr = imsic_m->base + socket * (1U << IMSIC_MMIO_GROUP_MIN_SHIFT);
>               for (i = 0; i < hart_count; i++) {
> -                riscv_imsic_create(addr + i * m_imsic_stride,
> +                riscv_imsic_create(mr,
> +                                   addr + i * m_imsic_stride,
>                                      base_hartid + i, true, 1,
>                                      num_msis);
>               }
> @@ -61,7 +62,8 @@ DeviceState *riscv_create_aia(MemoryRegion *mr, bool msimode, int aia_guests,
>           /* Per-socket S-level IMSICs */
>           addr = imsic_s->base + socket * (1U << IMSIC_MMIO_GROUP_MIN_SHIFT);
>           for (i = 0; i < hart_count; i++) {
> -            riscv_imsic_create(addr + i * s_imsic_stride,
> +            riscv_imsic_create(mr,
> +                               addr + i * s_imsic_stride,
>                                  base_hartid + i, false, 1 + aia_guests,
>                                  num_msis);
>           }
> diff --git a/hw/riscv/xiangshan_kmh.c b/hw/riscv/xiangshan_kmh.c
> index 94f9d02a00b9..9eb608f8c578 100644
> --- a/hw/riscv/xiangshan_kmh.c
> +++ b/hw/riscv/xiangshan_kmh.c
> @@ -65,14 +65,15 @@ static DeviceState *xiangshan_kmh_create_aia(uint32_t num_harts)
>       /* M-level IMSICs */
>       addr = memmap[XIANGSHAN_KMH_IMSIC_M].base;
>       for (i = 0; i < num_harts; i++) {
> -        riscv_imsic_create(addr + i * IMSIC_HART_SIZE(0), i, true,
> +        riscv_imsic_create(get_system_memory(),
> +                           addr + i * IMSIC_HART_SIZE(0), i, true,
>                              1, XIANGSHAN_KMH_IMSIC_NUM_IDS);
>       }
>   
>       /* S-level IMSICs */
>       addr = memmap[XIANGSHAN_KMH_IMSIC_S].base;
>       for (i = 0; i < num_harts; i++) {
> -        riscv_imsic_create(addr +
> +        riscv_imsic_create(get_system_memory(), addr +
>                              i * IMSIC_HART_SIZE(XIANGSHAN_KMH_IMSIC_GUEST_BITS),
>                              i, false, 1 + XIANGSHAN_KMH_IMSIC_GUEST_BITS,
>                              XIANGSHAN_KMH_IMSIC_NUM_IDS);


