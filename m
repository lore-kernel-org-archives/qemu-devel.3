Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D37606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 19:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WgGZ4s+5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dIIHvE5n
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKKoR-0006bG-GN; Fri, 23 Oct 2026 15:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xKKo8-0005l3-GP
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 15:20:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xKKo0-0002Gk-An
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 15:19:59 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NIZdVQ453873
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 19:19:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Nkc4BgJXGJOyfGtvbEuHkoJWL+fRtPRKPnhuZZGezxQ=; b=WgGZ4s+5ADSb2nGh
 vfLalSfhHw6p2lkSbITjBGlHRPbDWl4x5r0qYmJ6SDirPmgNMtLQzG2jnaRM9Obv
 aHZLan7OBEPfZSG0Cd2XIIKnTxYifq73VDcEnLfE1qjnfvgr8re7dvkywiu0jCbY
 2L1f/zwkfkWYIoVAyUxvYtenvrO1T//e9PNvdM47P+nqNPYiHbqr4Mj6rzzFhOpT
 +2RtNbSxhEhEjuQ3BK1AqlH9Va4MZqvJndMA3zmdCDW10ytl0wtO7I43w0AjQRrP
 32AiOtHuBjBKZtaF/72tHHEl3hvEwhu9K4uMrkulBGTgPCbfQLdAwhnqDtTh0uE7
 C+0YBQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgcr686ky-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 19:19:50 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f5844e383so222275185a.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 12:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792783189; x=1793387989; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Nkc4BgJXGJOyfGtvbEuHkoJWL+fRtPRKPnhuZZGezxQ=;
 b=dIIHvE5nk9srrHn6y/rXR9/H72xIiXDKYiEoh0whiT4+WXFmAi8fjXKw4lzaVuyMR6
 3hc+LGsHQQu03Rs4BGtDRRC9Tjsv8DK29qQwa4l1H6oRUDn5CKANm2rfZu1xB53ShBjX
 OUIvI27/cOhaU7PeIhchwtpxXRtV1aBfD86z7EHox+IeEMjuIb9MAjnS2hjEOnqhVpj/
 ttlN/grVKvKZhmrICnp7q/oPc8mWMUgKEcmmNEVaU8XsFxvAT6CgupEt0wm5YKTf66Yg
 ZZqoGIRfy3LQD37i+c7w0njDv7S9NMNA4Xb2IF3HV/dtqWhEEwDxRdJDaUa3P+pb48h9
 d2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792783189; x=1793387989;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Nkc4BgJXGJOyfGtvbEuHkoJWL+fRtPRKPnhuZZGezxQ=;
 b=idD0cqsSrufqNFcM0FRrMt7BdotZmfLxjBF3hznZlBq2tKf2jW/avQyV4FLzUqquek
 6detYBjU2dl4w6kARJViZ5sPXtxD1ljPYbImnZGNit4mrLoD9DA+LOd1oYbmBx+SJE5R
 5vLOT19b8cvDpzycsNogfkiwOVirNMzYN2T7pU3EvNStSZhlKvreNbPh7U9E1Fs6wTJw
 l+lJVvMz/dgaqIIaHSMMrHWSa4ljfSCEFCshvQe2cj39sb76Dcu8jez+BdFE1Nn2ydTF
 MsV/pOFq14kbAG2lS5CKRI0NmWuU7Fda4pLalg9hvAQbtEnX2DYDTMo8a/1SBdqlflfY
 tzlQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByHxCjl20wdWacT66TcBQCCETtTETMps3mxLFAI7QuytSyQoYR5XNr9Fn2YgVIqM+d/VRD29w+slHhG@nongnu.org
X-Gm-Message-State: AFq9FYKa8xiNGaJPUAWxWlPyBBATx5dYFqzg2UJeEihJ7tQyefV4Q1sW
 7h2JcP0rmwfSc3w6/hc6WuMQpgA6ZsTyktQzBe8YhfhszSA0k6dErgB0ZVCZvQgGMxD+L2q4va5
 9KW4v7DdMAIyt86LtEuG3sIqHJD+z3dvetsadEgzRUwGuXOAEDcbn7ak0pw==
X-Gm-Gg: AYBFou2HShEU3BJBbdNX1mQvgB79HbjuB2iDj96229QVLh3+C4sJ7ipI0wOpbk/bOxR
 VbcZ0YBCIhzo8+y8nRJQISF3ipcu5mOAMiN5CnV4NGHaCQ0Qsm5Z+cC7IjKFkImCTgNubTpsCsi
 vtdZjfqmbG1vRGF8k7cKXSYR1wxbnw+BU1HKwYxV6b8is1dSoCVlCjW2r+GAevXQLEAgBVFzacT
 XjqF3aqJmNKkis86uIrAbcQKuJNkNCONGnhaiRQYeJCTOrPmCbfeOlFY0x6ruLPTTTFE7YRfN7C
 ZipisT9AE4fHlwMzbZZjOhAEfKYhFEp1peBjIC5XiNEa2UKfYCWjJSgaahJHw2NlFmyXIVZ+HEb
 rX/vFnWUxmnTMerMaJx1+mikwa728tTBnDGGC
X-Received: by 2002:a05:620a:1710:b0:93e:942f:b8ae with SMTP id
 af79cd13be357-940ef915db6mr255285a.26.1792783189207; 
 Fri, 23 Oct 2026 12:19:49 -0700 (PDT)
X-Received: by 2002:a05:620a:1710:b0:93e:942f:b8ae with SMTP id
 af79cd13be357-940ef915db6mr251285a.26.1792783188705; 
 Fri, 23 Oct 2026 12:19:48 -0700 (PDT)
Received: from [192.168.68.104] ([152.234.125.162])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-94047b2d3b1sm92786585a.32.2026.10.23.12.19.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 12:19:47 -0700 (PDT)
Message-ID: <c51bba51-66e6-41ce-821b-550dc1663e7a@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 16:19:44 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] hw/intc/imsic: Add in-kernel imsic save and
 restore function
To: Wang Yechao <wang.yechao255@zte.com.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Xuemei Liu <liu.xuemei1@zte.com.cn>
References: <20261023021237.486091-1-wang.yechao255@zte.com.cn>
 <20261023021237.486091-4-wang.yechao255@zte.com.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261023021237.486091-4-wang.yechao255@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HMRWhYtv c=1 sm=1 tr=0 ts=6adbb356 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=AgQEunjic7gIBKSbIeB6Ag==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=1RTuLK3dAAAA:8 a=EUspDBNiAAAA:8 a=rh6cotYM480tH6FfD94A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA3NSBTYWx0ZWRfX+NScGEomFEeI
 zj4EGhfF9xdj1Mv4XSPjjiOiNmRaelKWGipPvWUZttkmk7ZracU1Hpu91sn8zfXqNVWDsz5xs3o
 kZPbZ2thCtvtxTZDmvZ75FgMbJL96EHam2zC4+YuAwLGldpBUT6lifFzQK0FpMsmqLTTQnaKKrj
 dSoKeP8SumKgGzJSYCeHHif97j9AAlj3V8bPKlANzGJpJ8iZUEmXZ2qdfSkAucosHsr5kWByOzm
 whX0xhq49Xi1dSigmIT81UXpDRS7LzTWf34/DQVTQQQMHi4zsmvMLYRydm/B37QKFTvrilbkF/U
 dhdVgmwfKkvMhh68CWipxi/+nAAzPXfQyh5A/BXxNNLHaOdV9GsgzVLzCvqO4vDxk/8KgM3v6eS
 S8yjwwMYM9m2gTtOw5V1qoUiryilWsFyKbW9D9lZuobpgQjTNbK9CyHkWEzHc5cePL1lXs0h2lw
 1MB83TGLQCRO1oGJVlA==
X-Proofpoint-ORIG-GUID: iC-4ghNuW8ucWIbk7ljisFulF0aRoQRf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA3NSBTYWx0ZWRfX3XOfCWzfwNFr
 hoRqeoTpHdjhj1l8Lv9ey0UslIIsgFotf2h5dQOqWKsGc6z/iVL7VyJRcF5WuQfFtu30fBP6pbX
 SZGicZHs+Dw5E09iIR3PJcdfEbgb89M=
X-Proofpoint-GUID: iC-4ghNuW8ucWIbk7ljisFulF0aRoQRf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230075
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/22/2026 11:12 PM, Wang Yechao wrote:
> From: Xuemei Liu <liu.xuemei1@zte.com.cn>
> 
> Add save and restore funtction if kvm_irqchip_in_kernel() return

typo: s/funtction/function

> true, it is to get and set IMSIC irqchip state from KVM kernel.
> 
> Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
> Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
> ---

I think we'll need a separated patch for the bitops.h/vmstate-types.c change.
That code isn't RISC-V specific and people might have different opinions
about it.

Feel free to add my ack in both patches:


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>



>   hw/intc/riscv_imsic.c         | 180 +++++++++++++++++++++++++++++++---
>   include/hw/intc/riscv_imsic.h |   3 +
>   include/qemu/bitops.h         |   1 +
>   migration/vmstate-types.c     |   1 -
>   4 files changed, 170 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
> index cb9ce9612c..43e4d11426 100644
> --- a/hw/intc/riscv_imsic.c
> +++ b/hw/intc/riscv_imsic.c
> @@ -34,6 +34,7 @@
>   #include "system/system.h"
>   #include "system/kvm.h"
>   #include "migration/vmstate.h"
> +#include "kvm/kvm_riscv.h"
>   
>   #define IMSIC_MMIO_PAGE_LE             0x00
>   #define IMSIC_MMIO_PAGE_BE             0x04
> @@ -408,11 +409,16 @@ static void riscv_imsic_realize(DeviceState *dev, Error **errp)
>           qdev_init_gpio_out(dev, imsic->external_irqs, imsic->num_pages);
>   
>           imsic->num_eistate = imsic->num_pages * imsic->num_irqs;
> -        imsic->eidelivery = g_new0(uint32_t, imsic->num_pages);
> -        imsic->eithreshold = g_new0(uint32_t, imsic->num_pages);
>           imsic->eistate = g_new0(uint32_t, imsic->num_eistate);
> +    } else {
> +        imsic->nr_eix = 2 * BITS_TO_U64S(imsic->num_irqs);
> +        imsic->eie = g_new0(uint32_t, imsic->nr_eix);
> +        imsic->eip = g_new0(uint32_t, imsic->nr_eix);
>       }
>   
> +    imsic->eidelivery = g_new0(uint32_t, imsic->num_pages);
> +    imsic->eithreshold = g_new0(uint32_t, imsic->num_pages);
> +
>       memory_region_init_io(&imsic->mmio, OBJECT(dev), &riscv_imsic_ops,
>                             imsic, TYPE_RISCV_IMSIC,
>                             IMSIC_MMIO_SIZE(imsic->num_pages));
> @@ -443,23 +449,17 @@ static const Property riscv_imsic_properties[] = {
>       DEFINE_PROP_UINT32("num-irqs", RISCVIMSICState, num_irqs, 0),
>   };
>   
> -static bool riscv_imsic_state_needed(void *opaque)
> +static bool riscv_emulated_imsic_state_needed(void *opaque)
>   {
>       return !kvm_irqchip_in_kernel();
>   }
>   
> -static const VMStateDescription vmstate_riscv_imsic = {
> -    .name = "riscv_imsic",
> -    .version_id = 2,
> -    .minimum_version_id = 2,
> -    .needed = riscv_imsic_state_needed,
> +static const VMStateDescription vmstate_emulated_imsic_state = {
> +    .name = "riscv_imsic/emulated_imsic_state",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = riscv_emulated_imsic_state_needed,
>       .fields = (const VMStateField[]) {
> -            VMSTATE_VARRAY_UINT32(eidelivery, RISCVIMSICState,
> -                                  num_pages, 0,
> -                                  vmstate_info_uint32, uint32_t),
> -            VMSTATE_VARRAY_UINT32(eithreshold, RISCVIMSICState,
> -                                  num_pages, 0,
> -                                  vmstate_info_uint32, uint32_t),
>               VMSTATE_VARRAY_UINT32(eistate, RISCVIMSICState,
>                                     num_eistate, 0,
>                                     vmstate_info_uint32, uint32_t),
> @@ -467,6 +467,158 @@ static const VMStateDescription vmstate_riscv_imsic = {
>           }
>   };
>   
> +#ifdef CONFIG_KVM
> +static bool kvm_riscv_imsic_state_needed(void *opaque)
> +{
> +    return kvm_irqchip_in_kernel();
> +}
> +
> +static int kvm_riscv_imsic_state_pre_save(void *opaque)
> +{
> +    RISCVIMSICState *imsic = opaque;
> +    RISCVCPU *rcpu = RISCV_CPU(cpu_by_arch_id(imsic->hartid));
> +    bool is_32bit = riscv_cpu_is_32bit(rcpu);
> +    uint32_t inc = 2;
> +    uint64_t attr;
> +
> +    if (is_32bit) {
> +        inc = 1;
> +    }
> +
> +    for (uint32_t i = 0; i < imsic->nr_eix; i += inc) {
> +        attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
> +                                              ISELECT_IMSIC_EIE0 + i);
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
> +                                 imsic->eie + i, false);
> +
> +        attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
> +                                              ISELECT_IMSIC_EIP0 + i);
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
> +                                     imsic->eip + i, false);
> +    }
> +
> +    return 0;
> +}
> +
> +static int kvm_riscv_imsic_state_post_load(void *opaque, int version_id)
> +{
> +    RISCVIMSICState *imsic = opaque;
> +    RISCVCPU *rcpu = RISCV_CPU(cpu_by_arch_id(imsic->hartid));
> +    bool is_32bit = riscv_cpu_is_32bit(rcpu);
> +    uint32_t inc = 2;
> +    uint64_t attr;
> +
> +    if (is_32bit) {
> +        inc = 1;
> +    }
> +
> +    for (uint32_t i = 0; i < imsic->nr_eix; i += inc) {
> +        attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
> +                                              ISELECT_IMSIC_EIE0 + i);
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
> +                                 imsic->eie + i, true);
> +
> +        attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
> +                                              ISELECT_IMSIC_EIP0 + i);
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
> +                                 imsic->eip + i, true);
> +    }
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_kvm_imsic_state = {
> +    .name = "riscv_imsic/kvm_imsic_state",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = kvm_riscv_imsic_state_needed,
> +    .pre_save = kvm_riscv_imsic_state_pre_save,
> +    .post_load = kvm_riscv_imsic_state_post_load,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_VARRAY_UINT32(eie, RISCVIMSICState,
> +                              nr_eix, 0,
> +                              vmstate_info_uint32, uint32_t),
> +        VMSTATE_VARRAY_UINT32(eip, RISCVIMSICState,
> +                              nr_eix, 0,
> +                              vmstate_info_uint32, uint32_t),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static int riscv_imsic_pre_save(void *opaque)
> +{
> +    RISCVIMSICState *imsic = opaque;
> +    uint64_t attr;
> +
> +    if (kvm_irqchip_in_kernel()) {
> +        attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
> +                                              ISELECT_IMSIC_EIDELIVERY);
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
> +                                 imsic->eidelivery, false);
> +
> +        attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
> +                                              ISELECT_IMSIC_EITHRESHOLD);
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
> +                                 imsic->eithreshold, false);
> +   }
> +
> +    return 0;
> +}
> +
> +static int riscv_imsic_post_load(void *opaque, int version_id)
> +{
> +    RISCVIMSICState *imsic = opaque;
> +    uint64_t attr;
> +
> +    if (kvm_irqchip_in_kernel()) {
> +        attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
> +                                              ISELECT_IMSIC_EIDELIVERY);
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
> +                                 imsic->eidelivery, true);
> +
> +        attr = KVM_DEV_RISCV_AIA_IMSIC_MKATTR(imsic->hartid,
> +                                              ISELECT_IMSIC_EITHRESHOLD);
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_IMSIC, attr,
> +                                 imsic->eithreshold, true);
> +   }
> +
> +    return 0;
> +}
> +#else
> +static int riscv_imsic_pre_save(void *opaque)
> +{
> +    return 0;
> +}
> +static int riscv_imsic_post_load(void *opaque, int version_id)
> +{
> +    return 0;
> +}
> +#endif
> +
> +static const VMStateDescription vmstate_riscv_imsic = {
> +    .name = "riscv_imsic",
> +    .version_id = 3,
> +    .minimum_version_id = 3,
> +    .pre_save = riscv_imsic_pre_save,
> +    .post_load = riscv_imsic_post_load,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_VARRAY_UINT32(eidelivery, RISCVIMSICState,
> +                              num_pages, 0,
> +                              vmstate_info_uint32, uint32_t),
> +        VMSTATE_VARRAY_UINT32(eithreshold, RISCVIMSICState,
> +                              num_pages, 0,
> +                              vmstate_info_uint32, uint32_t),
> +        VMSTATE_END_OF_LIST()
> +    },
> +    .subsections = (const VMStateDescription * const []) {
> +        &vmstate_emulated_imsic_state,
> +#ifdef CONFIG_KVM
> +        &vmstate_kvm_imsic_state,
> +#endif
> +        NULL
> +    }
> +};
> +
>   static void riscv_imsic_class_init(ObjectClass *klass, const void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> diff --git a/include/hw/intc/riscv_imsic.h b/include/hw/intc/riscv_imsic.h
> index 0a1df1c2f8..b61820fd29 100644
> --- a/include/hw/intc/riscv_imsic.h
> +++ b/include/hw/intc/riscv_imsic.h
> @@ -54,12 +54,15 @@ struct RISCVIMSICState {
>       uint32_t *eidelivery;
>       uint32_t *eithreshold;
>       uint32_t *eistate;
> +    uint32_t *eip;
> +    uint32_t *eie;
>   
>       /* config */
>       bool mmode;
>       uint32_t hartid;
>       uint32_t num_pages;
>       uint32_t num_irqs;
> +    uint32_t nr_eix;
>   };
>   
>   DeviceState *riscv_imsic_create(MemoryRegion *container, hwaddr addr,
> diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
> index f7363a5479..383648fe59 100644
> --- a/include/qemu/bitops.h
> +++ b/include/qemu/bitops.h
> @@ -20,6 +20,7 @@
>   #define BITS_PER_LONG           (sizeof (unsigned long) * BITS_PER_BYTE)
>   #define BITS_TO_LONGS(nr)       DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
>   #define BITS_TO_U32S(nr)        DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(uint32_t))
> +#define BITS_TO_U64S(nr)        DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(uint64_t))
>   
>   #define BIT(nr)                 (1UL << (nr))
>   #define BIT_ULL(nr)             (1ULL << (nr))
> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> index c2d4645f31..d0d3a0e384 100644
> --- a/migration/vmstate-types.c
> +++ b/migration/vmstate-types.c
> @@ -597,7 +597,6 @@ const VMStateInfo vmstate_info_tmp = {
>    * is an array of 'unsigned long', which may be either 32 or 64 bits.
>    */
>   /* This is the number of 64 bit words sent over the wire */
> -#define BITS_TO_U64S(nr) DIV_ROUND_UP(nr, 64)
>   static bool load_bitmap(QEMUFile *f, void *pv, size_t size,
>                           const VMStateField *field, Error **errp)
>   {


