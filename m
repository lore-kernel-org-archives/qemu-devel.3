Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CEA0C61DC6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 12:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzYsR-00082d-7M; Thu, 27 Aug 2026 08:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzYsN-00082E-Af
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 08:06:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzYsK-0007TQ-C5
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 08:06:34 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67R9HHv23090962
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 12:06:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 l6nnc7ildW1fe5c7oPeXKhiHAnaX87v1oHvuzA/4VwQ=; b=QGxTaA1DTvvp8Lja
 dR34Av98WwDNCpm1dfQlxN049Y0P5KTFgwExDezi87Wf5/tpVr+HkPcKXDvWUZUt
 A8BepvNAjEoSAA2qZ2WeEodLkCCYqJrRabmMhQRL04vhx4AS/ygAs7jevSnqITp8
 RH5UrzTpN2cFy2Oxj6uY5dPeXArp4wjVc3puJsnjmbIAUDW6aD0k5VjzNUVN4qpl
 hMMLJZgRvMvQpOVU2lPdPTj8f+KLnOFUauN71UU9em1t0+oPTK+9MvMKW0oyyZFq
 ZlFn70PK7HNNU7G3DGHJqEizOczwawDRgSDWdZ8zmWYV1RfyKA4E5QTiToje/3bW
 q8F4VA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga4fwkprj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 12:06:30 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52ee59064d2so12069261cf.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 05:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787832390; x=1788437190; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=l6nnc7ildW1fe5c7oPeXKhiHAnaX87v1oHvuzA/4VwQ=;
 b=cc1VRirpD8We8jUGiobXgB17NxIeqpSmJBXDVAUdCnNMTfDL24o6HIV3L/gsNps51q
 Xv7i0FGgOkRDiFUxZ8m7qs5aY2gSwrhH4Mz1xqbHeN9wZdXQgLxCeH4nsVqugMaj/v79
 J7CTsFznz5l8mbWxByGUP+ju0h3vuhG9hWPyObi7R0IA6v//NGfZb8yCrXy7gJRK3P0M
 oE+Lbg2wlC0zecbwUdLI5Hy0HI4rgB6CK1gGLRubTxDjKUDVALvHtDMHRdb2UAHb9BUw
 jNSBduyhtAYH08H0l0ojkzQZmu2KOyS3Z4tXiI+Kq9su1ACUpciHH9dWo2Im7doK5H8k
 3jRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787832390; x=1788437190;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l6nnc7ildW1fe5c7oPeXKhiHAnaX87v1oHvuzA/4VwQ=;
 b=Uu+aNxvc9ZV71mhSMk+vySWXRRzFpBCkXrxKvqSDTgLVvb4n4y24hhWDKfbwuWlzXC
 dftemAQo0LFh45ATkxxmNCJxjyIKHA/cVE9HQXBTj6nXZQnoIubb+Db0xAZvLHFHrkaN
 esX6prEsnbX0qGMDEyqC4nlC4VUCJDYtW09qQk0X5vgGix+FEketp+Y6sm6TAmqnH39h
 g5C2qn1Hn+QGOTxcB9S+fgFtm9cl6C3w9quXTjpMs+cKDa5WNtr9aR3fDtFVY3lUrQMj
 PDwLdBYKbKm3+pi+s6PTgXTxsmDhZilwNh07nUJ0vaL16TdawGtnAaXT9mcrkc0B5aC+
 LZUg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoqxSK7mBwbZ5iU8LDPp08t6d5Wm8dGCIS+a0USTNkEEFK1mfHRzbiXUjQuy+MqgsCssOvVJmy0VXWt@nongnu.org
X-Gm-Message-State: AFuF++nUmxJNETHd74P7xWnmWPbJkWLamHOE1MwbNwD/qM3gJB169ccN
 0Xuc+NSS3T10qPZCus223F+Yy4lcVjkp+yp+sNbVM1hWW85fveZskXfaGXyhl3RUy1TGff0qS7O
 ub2HijsxWCQ33uIvaaHBR10ZNv3rNvcRNuplncGW09Pr30YXUhB0V34eWuw==
X-Gm-Gg: AR+sD12E0qey/NvS3j6TWEkeYsWeLYfS3QxdqCA7Tv7iZvkSpuvgU2rksrRi9SYNZOt
 zEnEbpJaxHOhlg7af/+jFtslhWh6aBoQN6HhFaWqmp9TrVW9PAUNQ6LH06cOst5WfYc0IPlc5VW
 Mj5T6o4Qi7Rl3r30uvj6/tjNVo7XRzX36f/B/WBopLw2qkPbATRtcIJTl4lyuMG135uKLHvfq88
 9WTZ0EHxf83Wg+sEN2kNsh84plLp8cZV7EO6qver19UmsvC5oY9HgIiK8nzDkaaiDz2sOeLInRp
 F+ZDSQeqYQkV/jxWwgwt6uK9q6a0WquLyoCzkSvyQv9OblPO4x7BEDE7uU+sUIxH8zoOXXz6VD+
 rYrg5bs7sMkAE7OU/1saHilYimuOrLvrfSBWL
X-Received: by 2002:ac8:5fcd:0:b0:52d:6f91:86e with SMTP id
 d75a77b69052e-52fa1d142e0mr59714201cf.15.1787832389558; 
 Thu, 27 Aug 2026 05:06:29 -0700 (PDT)
X-Received: by 2002:ac8:5fcd:0:b0:52d:6f91:86e with SMTP id
 d75a77b69052e-52fa1d142e0mr59713591cf.15.1787832389076; 
 Thu, 27 Aug 2026 05:06:29 -0700 (PDT)
Received: from [192.168.68.100] ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52e4256f391sm35952061cf.2.2026.08.27.05.06.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 05:06:28 -0700 (PDT)
Message-ID: <efcc7009-b135-41dd-b21b-019d66023952@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 09:06:24 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/16] hw/riscv/atlantis: Decouple RAM size from
 MachineState
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
 <20260826221154.54577-1-joel@jms.id.au>
 <20260826221154.54577-4-joel@jms.id.au>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260826221154.54577-4-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: LEKFME_X2Jq6bHkbRggCTh-txMTmFwJ0
X-Authority-Analysis: v=2.4 cv=OtZ/DS/t c=1 sm=1 tr=0 ts=6a902846 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=SMI_Uc_H_maClvsOtpYA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: LEKFME_X2Jq6bHkbRggCTh-txMTmFwJ0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEwMSBTYWx0ZWRfX0pO86IjTu/dC
 gnpi9vdR9SsLfFMC1Fi3PenzEI858p9PpqHlS9D9RAJrMrUX09XElydAfz4tW6F9VP+SNY461+5
 9n7+fcnrrwkgSY28Txw/wugE3eOGuvvzwz2ip9TyyUob5NcUjBFv3nayXPYTLxinIsJ/b3Uo3Of
 ifELg7io/ndI2x6WbgnvLQV52ZNA7Lknc2ngfWjea8IaQ0rA0s+9YeIySMt7A2W+/K4OpvlM5t6
 iT1pzTjYRFucV8WH+GWiWoWIT0zI6z/i5+Y/UyqXcYlaz0NgUzdXbUmGe0aMVvV511sfDvq6RZI
 Lyy706FNgddUBzFISnP4mbBi6yejFBFaEMP/6FPG+ELADShGk9hi8u+R73GXXe7NS1+i3PotNio
 6hk+k2TqThtu8qSZ2bJtiDZKmXx0SR/AMF9sTJH/tcV59NKj39N+QapW1fPaUJyDlKRvhWlKqrH
 njlPrfSKDW/GDuJwTiQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEwMSBTYWx0ZWRfX+Yj5QeJFhNTn
 XO2+hAc10Y+R6bhJRN05nJt+g4L5fmjayYxgBQu8qkgTrQ98qzuotF8gG8qmBv0eNQbA6IWRSNo
 KROoGfPs3YZOOhuad7iWZNwenPH5ee0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270101
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



On 8/26/2026 7:11 PM, Joel Stanley wrote:
> Keep a reference to the machine's RAM MemoryRegion in TTAtlantisState,
> and get the MemoryRegion's size where the configured RAM size is
> required.
> 
> This allows reading the RAM size without needing a pointer to
> MachineState, decoupling the memory layout setup from the machine.

What you're doing here is basically replacing MACHINE(s)->ram_size to
memory_region_size(machine->ram).

This is fine, in particular during init time.  Just be aware that those
2 values are not always the same when we consider stuff like memory
hotplug/unplug (ms->ram_size is defined during init, memory_region_size(machine->ram)
will differ).

I don't think we have adequate support for hotplug/unplug in general in RISC-V
yet so this might be a non-issue.  Worth keeping it in mind though.


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>






> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>   include/hw/riscv/tt_atlantis.h |  1 +
>   hw/riscv/tt_atlantis.c         | 20 ++++++++++++--------
>   2 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
> index a29c67c1cfcf..2ec283d0fd7b 100644
> --- a/include/hw/riscv/tt_atlantis.h
> +++ b/include/hw/riscv/tt_atlantis.h
> @@ -30,6 +30,7 @@ struct TTAtlantisState {
>       const MemMapEntry *memmap;
>   
>       MemoryRegion *memory;
> +    MemoryRegion *dram;
>       RISCVHartArrayState cpus;
>       DeviceState *irqchip;
>       DesignWareI2CState i2c[TT_ATL_NUM_I2C];
> diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
> index 1c75fb5d8d57..7a9f5872c7c0 100644
> --- a/hw/riscv/tt_atlantis.c
> +++ b/hw/riscv/tt_atlantis.c
> @@ -82,12 +82,13 @@ static uint32_t next_phandle(void)
>   
>   static void create_fdt_memory(void *fdt, TTAtlantisState *s)
>   {
> -    hwaddr size_lo = MACHINE(s)->ram_size;
> +    hwaddr ram_size = memory_region_size(s->dram);
> +    hwaddr size_lo = ram_size;
>       hwaddr size_hi = 0;
>   
>       if (size_lo > s->memmap[TT_ATL_DDR_LO].size) {
>           size_lo = s->memmap[TT_ATL_DDR_LO].size;
> -        size_hi = MACHINE(s)->ram_size - size_lo;
> +        size_hi = ram_size - size_lo;
>       }
>   
>       create_fdt_socket_memory(fdt, s->memmap[TT_ATL_DDR_LO].base, size_lo,
> @@ -485,11 +486,14 @@ static void tt_atlantis_machine_init(MachineState *machine)
>       MemoryRegion *ram_hi = g_new(MemoryRegion, 1);
>       MemoryRegion *ram_lo = g_new(MemoryRegion, 1);
>       MemoryRegion *bootrom = g_new(MemoryRegion, 1);
> -    ram_addr_t lo_ram_size;
> +    ram_addr_t lo_ram_size, ram_size;
>       int hart_count = machine->smp.cpus;
>   
>       s->memory = get_system_memory();
>   
> +    s->dram = machine->ram;
> +    ram_size = memory_region_size(s->dram);
> +
>       s->memmap = tt_atlantis_memmap;
>   
>       object_initialize_child(OBJECT(machine), "soc", &s->cpus,
> @@ -532,20 +536,20 @@ static void tt_atlantis_machine_init(MachineState *machine)
>        * The high address is where RAM lives. It is always present and may be
>        * up to 64GB. The low address is an alias of the first 2GB of that RAM.
>        */
> -    if (machine->ram_size > s->memmap[TT_ATL_DDR_HI].size) {
> +    if (ram_size > s->memmap[TT_ATL_DDR_HI].size) {
>           char *sz = size_to_str(s->memmap[TT_ATL_DDR_HI].size);
>           error_report("RAM size is too large, maximum is %s", sz);
>           g_free(sz);
>           exit(EXIT_FAILURE);
>       }
>   
> -    memory_region_init_alias(ram_hi, OBJECT(machine), "ram.high", machine->ram,
> -                             0, machine->ram_size);
> +    memory_region_init_alias(ram_hi, OBJECT(machine), "ram.high", s->dram,
> +                             0, ram_size);
>       memory_region_add_subregion(s->memory,
>                                   s->memmap[TT_ATL_DDR_HI].base, ram_hi);
>   
> -    lo_ram_size = MIN(machine->ram_size, s->memmap[TT_ATL_DDR_LO].size);
> -    memory_region_init_alias(ram_lo, OBJECT(machine), "ram.low", machine->ram,
> +    lo_ram_size = MIN(ram_size, s->memmap[TT_ATL_DDR_LO].size);
> +    memory_region_init_alias(ram_lo, OBJECT(machine), "ram.low", s->dram,
>                                0, lo_ram_size);
>       memory_region_add_subregion(s->memory,
>                                   s->memmap[TT_ATL_DDR_LO].base, ram_lo);


