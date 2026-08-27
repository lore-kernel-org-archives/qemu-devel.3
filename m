Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05557C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzXl0-0002fF-6A; Thu, 27 Aug 2026 06:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzXky-0002e1-PG
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 06:54:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzXkw-00025s-8s
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 06:54:52 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67R9GrsM3108324
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 10:54:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 n7nMwqYqAbOcN0Qe8bkTipieqosicnMHF6/fyM9JpUY=; b=htjpgkZ4fSgGHH6P
 uujl+3yhJEYoiTa7GHTexwNna6hAungqhLz9CxyH6Xy2QNamH64MuRF4DYUVyfi+
 dRWq+9s/rCbp8/pDrJ0FOiQpsaZwAsoRjPdUGloCGJcB4iQr1rO9KUrGGRVlmk4K
 nvUuMJBOaXz+e/zxWgMocqAuGiIwYdJd8DAZmMDs+IlWhYqxCS9dVtpzgrTCiFO1
 Wf1cOahPtBj6FWBUmOrbphPq9+6WgezC8ZlH3uDK4OS+0MsxHE4pKYivDaJpIc3h
 VHv9p3u4TeJYOUnpL8qfXmd6XZ1Zmtipd4wKsQYO1XPY2nyLnJlYJJFK3IwIHK89
 td18Zw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga6ettuut-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 10:54:48 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52dd69b00cfso7193641cf.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 03:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787828088; x=1788432888; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=n7nMwqYqAbOcN0Qe8bkTipieqosicnMHF6/fyM9JpUY=;
 b=GhsDergP1ZdXVyPMziIIKZEC9ksCjqPwersLpiZ6cbwSy8Lb7nuo5U9jJxYElZhISu
 EtljNyWk846HiSXZVYq4fEgcTR9i8gaAHUC0l3ghrXZrJS0d74+i+7muHJEzgtfV2Wcz
 spJTs8Vc6ZVHv7VDzTLnVu8MRIBvgqoQLFX1jBj4bmlfxWVG8+t+GGS+mOqjkZTmg8aM
 XxLzFFB/JO9FMidAlavJIxkeL6StiHd4UvSYy4L/BxrKxJ8QeKuAAypZFfGBuEb/d7Y5
 b/PP5xQT6xZRDBgLrB7K7Ila/Y3tYIBnGCfDp8mHsEkfz7PfdKnyHaQzpgqBZdxrDqAW
 mSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787828088; x=1788432888;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n7nMwqYqAbOcN0Qe8bkTipieqosicnMHF6/fyM9JpUY=;
 b=Sg1VOLqcWbREzU1YcsLbxbKllT/WQdgMGEpQ3U1UwYadJxQ15OhKqt85rKZ4QyUv8t
 Pe7+8Bf07pgtCH0TgTzrVCh8CNFLGqIDFHJZKkqlhwb1NDRXmSD/Xof5UpplSSMjMDSF
 hwiaL+Y3KnK3WzhaYPSpQ9q1oZtNfZ/D1HnyQsWCjo/D9gf9va1C1UTuL2h6HJHvV3/z
 VYZA6duf8+mM+GAGetQJtRvJZBiOwpBDTlV6cukKbzdPmT1VzpXE8XPVwkmGquphOEjb
 q6GHbhcc1I0so7jpTYtSESwjkk8s8wel7VYuEzLlsE8D+SS1kWZMlPwUfaNkYL6gAp30
 AOGQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpv36shTVrgc6rrup4W36BmkZCdSQayyECtJEtpyXgx9o8K7EpEbagP7FU51qGiJdtFhPkKUyTlIymw@nongnu.org
X-Gm-Message-State: AFuF++no/p4/0qEUk174Kgkf28nRtbwfvLF9AmzmJqloMDLZ/QoJszaE
 AdaDHfWEK3mMdlcmfKqi2mEQVLvHCu+EFww5ypolXTZlkX+41LZRc1A1Z/9gAbnohDAjML6RNvO
 til2brgyYB/TRIgl4SPSRBUx6Z7vXIrFRqTqlekOwgiOwK/IFDzdzlQipEQ==
X-Gm-Gg: AR+sD10NmyJIKZxw5ED7T2GHbTJnRsUjQxmpH8KFkaA66VHi6aoIz80b6isIysKQwm/
 tiFdXyN4o4ylVqMlQU0uAzyXe8quUUE5N2py/en6nmIPFQKiqUe+8h3vJA3PNAQsbD5BosrnO1w
 ZwH6/vhPZzF+kFj61MYJpXVkWcH0GMo4zCUxzAzwh9cS0wuNubrKvI4XNA+kv00OAFxbGFoEDIM
 t2OtiLwW2O7c5l2d1yhSeXSmqP1NUlPDzyA60Aurp/Rzibfft0GFb2epB9+yWPf7mnRYvmc6kgQ
 XR5SwjPrXp4CFL5tNFIDGM6X3oAQVTpl4JgSr1rGg9ODdoeS0KgLV+uRdeRHN3str4cHG1DAsqn
 567Xy49QCponna6QIj2go3TNfziUpQyYg7E0h
X-Received: by 2002:a05:622a:1825:b0:51c:b98a:2448 with SMTP id
 d75a77b69052e-52e42231cd0mr114854551cf.9.1787828087870; 
 Thu, 27 Aug 2026 03:54:47 -0700 (PDT)
X-Received: by 2002:a05:622a:1825:b0:51c:b98a:2448 with SMTP id
 d75a77b69052e-52e42231cd0mr114854241cf.9.1787828087381; 
 Thu, 27 Aug 2026 03:54:47 -0700 (PDT)
Received: from [192.168.68.100] ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52e425704a4sm34908461cf.6.2026.08.27.03.54.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 03:54:46 -0700 (PDT)
Message-ID: <0444abde-9654-443b-b05c-8d845e6d17dc@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 07:54:42 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/16] hw/intc/riscv_aclint: Take a MemoryRegion for the
 created devices
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
 <20260826220528.54516-3-joel@jms.id.au>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260826220528.54516-3-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=NrThtcdJ c=1 sm=1 tr=0 ts=6a901778 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=v0_EEl552tA-dc87-qsA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: XGWUJsGyKGC9t27L0RuK4q1w73CexHgv
X-Proofpoint-GUID: XGWUJsGyKGC9t27L0RuK4q1w73CexHgv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA5MCBTYWx0ZWRfX+2afCteFfw0r
 s2Nvm4kJnwwT0mOkzLD0b7FeRQx1z4hwDg1UPQ3NjXLCdBTe7KMY9aaBX+l0QdHp3H+IQgj1BsO
 h/cEZ99lDl6n+9kKpBopx78uzFTnWxQweR3IHytLy7UKAMdj5RD6W9OuiCJfm902uyhQ/lZIKf9
 sICxgAShoeH3zsdXWWwjC6sd4I5B58RkqJVdi2LegAXsa+vKj9rOCm3wVvzD2OKNR/CrlX05+DU
 s4XUpOkjlUSVXINHJRGotQIhuvVV1WYkaEcvfPlV5OKChl1lq5r+SrXZKY/U560rUHKm/dmtT7Y
 YunoRoL30a08wEKEYI798V6vH1cp28eLBAVTVeFFNtIR1Qse8FRCAbsvQ3P3v/eAZdf4ZjuKIa6
 YQdZiGaZ9O5GFGxYWvlTxWaKlI5A8JpAyslUpfDvc9xkmcXTpeNNH7DWCOvn4lp9SPb7tYKYVgo
 vxnBS1rJ9A2iyP20JgA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA5MCBTYWx0ZWRfX5FfTDZ5nFIte
 tvApeKm86SRNFI1yLXPiDGBx0wjbfu95nfBiWKEEdil6eZ1SQIW8v1KtgEQHpM+1OGyLJ85Dz99
 oZGKfgEQAL2AgwC9UvDmRmRwVWuISqk=
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
> The riscv_aclint_mtimer_create() and riscv_aclint_swi_create() helpers
> map the device they create into system_memory, which prevents their use
> by SoCs that map devices into a memory container of their own.
> 
> Add a MemoryRegion parameter and map the device into it instead of
> calling sysbus_mmio_map(). All callers pass system_memory, so there is
> no change in behaviour.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   include/hw/intc/riscv_aclint.h |  7 ++++---
>   hw/intc/riscv_aclint.c         | 12 ++++++++----
>   hw/riscv/cps.c                 |  6 ++++--
>   hw/riscv/k230.c                |  6 ++++--
>   hw/riscv/microchip_pfsoc.c     |  5 +++--
>   hw/riscv/shakti_c.c            |  7 ++++---
>   hw/riscv/sifive_e.c            |  4 ++--
>   hw/riscv/sifive_u.c            |  7 ++++---
>   hw/riscv/spike.c               |  4 ++--
>   hw/riscv/tt_atlantis.c         |  3 ++-
>   hw/riscv/virt.c                | 17 +++++++++++------
>   hw/riscv/xiangshan_kmh.c       |  6 ++++--
>   12 files changed, 52 insertions(+), 32 deletions(-)
> 
> diff --git a/include/hw/intc/riscv_aclint.h b/include/hw/intc/riscv_aclint.h
> index 0e0b98acb08a..a8c5d4eb5895 100644
> --- a/include/hw/intc/riscv_aclint.h
> +++ b/include/hw/intc/riscv_aclint.h
> @@ -46,7 +46,8 @@ typedef struct RISCVAclintMTimerState {
>       qemu_irq *timer_irqs;
>   } RISCVAclintMTimerState;
>   
> -DeviceState *riscv_aclint_mtimer_create(hwaddr addr, hwaddr size,
> +DeviceState *riscv_aclint_mtimer_create(MemoryRegion *mr,
> +    hwaddr addr, hwaddr size,
>       uint32_t hartid_base, uint32_t num_harts,
>       uint32_t timecmp_base, uint32_t time_base, uint32_t timebase_freq,
>       bool provide_rdtime);
> @@ -68,8 +69,8 @@ typedef struct RISCVAclintSwiState {
>       qemu_irq *soft_irqs;
>   } RISCVAclintSwiState;
>   
> -DeviceState *riscv_aclint_swi_create(hwaddr addr, uint32_t hartid_base,
> -    uint32_t num_harts, bool sswi);
> +DeviceState *riscv_aclint_swi_create(MemoryRegion *mr,
> +    hwaddr addr, uint32_t hartid_base, uint32_t num_harts, bool sswi);
>   
>   enum {
>       RISCV_ACLINT_DEFAULT_MTIMECMP      = 0x0,
> diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
> index 361a8d1bcb45..972c6c99b044 100644
> --- a/hw/intc/riscv_aclint.c
> +++ b/hw/intc/riscv_aclint.c
> @@ -371,7 +371,8 @@ static const TypeInfo riscv_aclint_mtimer_info = {
>   /*
>    * Create ACLINT MTIMER device.
>    */
> -DeviceState *riscv_aclint_mtimer_create(hwaddr addr, hwaddr size,
> +DeviceState *riscv_aclint_mtimer_create(MemoryRegion *mr,
> +    hwaddr addr, hwaddr size,
>       uint32_t hartid_base, uint32_t num_harts,
>       uint32_t timecmp_base, uint32_t time_base, uint32_t timebase_freq,
>       bool provide_rdtime)
> @@ -392,7 +393,8 @@ DeviceState *riscv_aclint_mtimer_create(hwaddr addr, hwaddr size,
>       qdev_prop_set_uint32(dev, "aperture-size", size);
>       qdev_prop_set_uint32(dev, "timebase-freq", timebase_freq);
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> -    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
> +    memory_region_add_subregion(mr, addr,
> +        sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
>   
>       for (i = 0; i < num_harts; i++) {
>           CPUState *cpu = cpu_by_arch_id(hartid_base + i);
> @@ -556,7 +558,8 @@ static const TypeInfo riscv_aclint_swi_info = {
>   /*
>    * Create ACLINT [M|S]SWI device.
>    */
> -DeviceState *riscv_aclint_swi_create(hwaddr addr, uint32_t hartid_base,
> +DeviceState *riscv_aclint_swi_create(MemoryRegion *mr,
> +    hwaddr addr, uint32_t hartid_base,
>       uint32_t num_harts, bool sswi)
>   {
>       int i;
> @@ -569,7 +572,8 @@ DeviceState *riscv_aclint_swi_create(hwaddr addr, uint32_t hartid_base,
>       qdev_prop_set_uint32(dev, "num-harts", num_harts);
>       qdev_prop_set_uint32(dev, "sswi", sswi ? true : false);
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> -    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
> +    memory_region_add_subregion(mr, addr,
> +        sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
>   
>       for (i = 0; i < num_harts; i++) {
>           CPUState *cpu = cpu_by_arch_id(hartid_base + i);
> diff --git a/hw/riscv/cps.c b/hw/riscv/cps.c
> index 86172be5b3ca..5cfb54aa27d2 100644
> --- a/hw/riscv/cps.c
> +++ b/hw/riscv/cps.c
> @@ -151,9 +151,11 @@ static void riscv_cps_realize(DeviceState *dev, Error **errp)
>                              false, false, s->aplic);
>           /* PLIC changes msi_nonbroken to ture. We revert the change. */
>           msi_nonbroken = false;
> -        riscv_aclint_swi_create(cm_base + AIA_CLINT_OFFSET,
> +        riscv_aclint_swi_create(get_system_memory(),
> +                                cm_base + AIA_CLINT_OFFSET,
>                                   hartid_base, MAX_HARTS, false);
> -        riscv_aclint_mtimer_create(cm_base + AIA_CLINT_OFFSET +
> +        riscv_aclint_mtimer_create(get_system_memory(),
> +                                   cm_base + AIA_CLINT_OFFSET +
>                                      RISCV_ACLINT_SWI_SIZE,
>                                      RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
>                                      hartid_base,
> diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
> index 558f30b97e9d..1ef4260c5391 100644
> --- a/hw/riscv/k230.c
> +++ b/hw/riscv/k230.c
> @@ -196,9 +196,11 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
>       s->c908_plic = k230_create_plic(C908_CPU_HARTID, c908_cpus);
>   
>       /* CLINT */
> -    riscv_aclint_swi_create(memmap[K230_DEV_CLINT].base,
> +    riscv_aclint_swi_create(sys_mem,
> +                            memmap[K230_DEV_CLINT].base,
>                               C908_CPU_HARTID, c908_cpus, false);
> -    riscv_aclint_mtimer_create(memmap[K230_DEV_CLINT].base + 0x4000,
> +    riscv_aclint_mtimer_create(sys_mem,
> +                               memmap[K230_DEV_CLINT].base + 0x4000,
>                                  RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
>                                  C908_CPU_HARTID, c908_cpus,
>                                  RISCV_ACLINT_DEFAULT_MTIMECMP,
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index 4017129c8304..a6026776d4de 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -250,9 +250,10 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
>           memmap[MICROCHIP_PFSOC_BUSERR_UNIT4].size);
>   
>       /* CLINT */
> -    riscv_aclint_swi_create(memmap[MICROCHIP_PFSOC_CLINT].base,
> +    riscv_aclint_swi_create(system_memory,
> +        memmap[MICROCHIP_PFSOC_CLINT].base,
>           0, ms->smp.cpus, false);
> -    riscv_aclint_mtimer_create(
> +    riscv_aclint_mtimer_create(system_memory,
>           memmap[MICROCHIP_PFSOC_CLINT].base + RISCV_ACLINT_SWI_SIZE,
>           RISCV_ACLINT_DEFAULT_MTIMER_SIZE, 0, ms->smp.cpus,
>           RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
> diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
> index 835b1f879b7f..86ff8f8fcaab 100644
> --- a/hw/riscv/shakti_c.c
> +++ b/hw/riscv/shakti_c.c
> @@ -127,10 +127,11 @@ static void shakti_c_soc_state_realize(DeviceState *dev, Error **errp)
>           SHAKTI_C_PLIC_CONTEXT_STRIDE,
>           shakti_c_memmap[SHAKTI_C_PLIC].size);
>   
> -    riscv_aclint_swi_create(shakti_c_memmap[SHAKTI_C_CLINT].base,
> +    riscv_aclint_swi_create(system_memory,
> +        shakti_c_memmap[SHAKTI_C_CLINT].base,
>           0, 1, false);
> -    riscv_aclint_mtimer_create(shakti_c_memmap[SHAKTI_C_CLINT].base +
> -            RISCV_ACLINT_SWI_SIZE,
> +    riscv_aclint_mtimer_create(system_memory,
> +        shakti_c_memmap[SHAKTI_C_CLINT].base + RISCV_ACLINT_SWI_SIZE,
>           RISCV_ACLINT_DEFAULT_MTIMER_SIZE, 0, 1,
>           RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
>           RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, false);
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index 71925583bd97..0ea444f43bc5 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -225,9 +225,9 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
>           SIFIVE_E_PLIC_CONTEXT_BASE,
>           SIFIVE_E_PLIC_CONTEXT_STRIDE,
>           memmap[SIFIVE_E_DEV_PLIC].size);
> -    riscv_aclint_swi_create(memmap[SIFIVE_E_DEV_CLINT].base,
> +    riscv_aclint_swi_create(sys_mem, memmap[SIFIVE_E_DEV_CLINT].base,
>           0, ms->smp.cpus, false);
> -    riscv_aclint_mtimer_create(memmap[SIFIVE_E_DEV_CLINT].base +
> +    riscv_aclint_mtimer_create(sys_mem, memmap[SIFIVE_E_DEV_CLINT].base +
>               RISCV_ACLINT_SWI_SIZE,
>           RISCV_ACLINT_DEFAULT_MTIMER_SIZE, 0, ms->smp.cpus,
>           RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 57a57c96e16b..58b4744318f8 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -788,10 +788,11 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
>           serial_hd(0), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_UART0_IRQ));
>       sifive_uart_create(system_memory, memmap[SIFIVE_U_DEV_UART1].base,
>           serial_hd(1), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_UART1_IRQ));
> -    riscv_aclint_swi_create(memmap[SIFIVE_U_DEV_CLINT].base, 0,
> +    riscv_aclint_swi_create(system_memory,
> +        memmap[SIFIVE_U_DEV_CLINT].base, 0,
>           ms->smp.cpus, false);
> -    riscv_aclint_mtimer_create(memmap[SIFIVE_U_DEV_CLINT].base +
> -            RISCV_ACLINT_SWI_SIZE,
> +    riscv_aclint_mtimer_create(system_memory,
> +        memmap[SIFIVE_U_DEV_CLINT].base + RISCV_ACLINT_SWI_SIZE,
>           RISCV_ACLINT_DEFAULT_MTIMER_SIZE, 0, ms->smp.cpus,
>           RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
>           CLINT_TIMEBASE_FREQ, false);
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index 630b65f56977..a227e0eca147 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -163,10 +163,10 @@ static void spike_board_init(MachineState *machine)
>           sysbus_realize(SYS_BUS_DEVICE(&s->soc[i]), &error_fatal);
>   
>           /* Core Local Interruptor (timer and IPI) for each socket */
> -        riscv_aclint_swi_create(
> +        riscv_aclint_swi_create(system_memory,
>               memmap[SPIKE_CLINT].base + i * memmap[SPIKE_CLINT].size,
>               base_hartid, hart_count, false);
> -        riscv_aclint_mtimer_create(
> +        riscv_aclint_mtimer_create(system_memory,
>               memmap[SPIKE_CLINT].base + i * memmap[SPIKE_CLINT].size +
>                   RISCV_ACLINT_SWI_SIZE,
>               RISCV_ACLINT_DEFAULT_MTIMER_SIZE, base_hartid, hart_count,
> diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
> index d69851df0a01..3f183db5c302 100644
> --- a/hw/riscv/tt_atlantis.c
> +++ b/hw/riscv/tt_atlantis.c
> @@ -509,7 +509,8 @@ static void tt_atlantis_machine_init(MachineState *machine)
>                                     TT_IRQCHIP_NUM_MSIS,
>                                     TT_IRQCHIP_NUM_PRIO_BITS);
>   
> -    riscv_aclint_mtimer_create(s->memmap[TT_ATL_ACLINT].base,
> +    riscv_aclint_mtimer_create(system_memory,
> +            s->memmap[TT_ATL_ACLINT].base,
>               TT_ACLINT_MTIME_SIZE,
>               0, hart_count,
>               TT_ACLINT_MTIMECMP,
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 22a607ed10bf..6e4b39315aaa 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1370,7 +1370,8 @@ static void virt_machine_init(MachineState *machine)
>           if (virt_aclint_allowed() && s->have_aclint) {
>               if (s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC) {
>                   /* Per-socket ACLINT MTIMER */
> -                riscv_aclint_mtimer_create(s->memmap[VIRT_CLINT].base +
> +                riscv_aclint_mtimer_create(system_memory,
> +                        s->memmap[VIRT_CLINT].base +
>                               i * RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
>                           RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
>                           base_hartid, hart_count,
> @@ -1379,10 +1380,12 @@ static void virt_machine_init(MachineState *machine)
>                           RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, true);
>               } else {
>                   /* Per-socket ACLINT MSWI, MTIMER, and SSWI */
> -                riscv_aclint_swi_create(s->memmap[VIRT_CLINT].base +
> +                riscv_aclint_swi_create(system_memory,
> +                        s->memmap[VIRT_CLINT].base +
>                               i * s->memmap[VIRT_CLINT].size,
>                           base_hartid, hart_count, false);
> -                riscv_aclint_mtimer_create(s->memmap[VIRT_CLINT].base +
> +                riscv_aclint_mtimer_create(system_memory,
> +                        s->memmap[VIRT_CLINT].base +
>                               i * s->memmap[VIRT_CLINT].size +
>                               RISCV_ACLINT_SWI_SIZE,
>                           RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
> @@ -1390,16 +1393,18 @@ static void virt_machine_init(MachineState *machine)
>                           RISCV_ACLINT_DEFAULT_MTIMECMP,
>                           RISCV_ACLINT_DEFAULT_MTIME,
>                           RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, true);
> -                riscv_aclint_swi_create(s->memmap[VIRT_ACLINT_SSWI].base +
> +                riscv_aclint_swi_create(system_memory,
> +                        s->memmap[VIRT_ACLINT_SSWI].base +
>                               i * s->memmap[VIRT_ACLINT_SSWI].size,
>                           base_hartid, hart_count, true);
>               }
>           } else if (tcg_enabled()) {
>               /* Per-socket SiFive CLINT */
> -            riscv_aclint_swi_create(
> +            riscv_aclint_swi_create(system_memory,
>                       s->memmap[VIRT_CLINT].base + i * s->memmap[VIRT_CLINT].size,
>                       base_hartid, hart_count, false);
> -            riscv_aclint_mtimer_create(s->memmap[VIRT_CLINT].base +
> +            riscv_aclint_mtimer_create(system_memory,
> +                    s->memmap[VIRT_CLINT].base +
>                       i * s->memmap[VIRT_CLINT].size + RISCV_ACLINT_SWI_SIZE,
>                       RISCV_ACLINT_DEFAULT_MTIMER_SIZE, base_hartid, hart_count,
>                       RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
> diff --git a/hw/riscv/xiangshan_kmh.c b/hw/riscv/xiangshan_kmh.c
> index 384624d69ad5..94f9d02a00b9 100644
> --- a/hw/riscv/xiangshan_kmh.c
> +++ b/hw/riscv/xiangshan_kmh.c
> @@ -116,9 +116,11 @@ static void xiangshan_kmh_soc_realize(DeviceState *dev, Error **errp)
>                      115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
>   
>       /* CLINT */
> -    riscv_aclint_swi_create(memmap[XIANGSHAN_KMH_CLINT].base,
> +    riscv_aclint_swi_create(system_memory,
> +                            memmap[XIANGSHAN_KMH_CLINT].base,
>                               0, num_harts, false);
> -    riscv_aclint_mtimer_create(memmap[XIANGSHAN_KMH_CLINT].base +
> +    riscv_aclint_mtimer_create(system_memory,
> +                               memmap[XIANGSHAN_KMH_CLINT].base +
>                                  RISCV_ACLINT_SWI_SIZE,
>                                  RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
>                                  0, num_harts, RISCV_ACLINT_DEFAULT_MTIMECMP,


