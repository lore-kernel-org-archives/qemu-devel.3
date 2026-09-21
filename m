Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32664C982E6
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 14:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8ebZ-0003RX-AN; Mon, 21 Sep 2026 10:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8ebW-0003RA-UY
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 10:02:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8ebV-0005qU-85
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 10:02:46 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LDomTI1982648
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:02:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ix7K2oYcuCwTnGzcVZvyWXmiar7ajsrDLl7Zea3zfOU=; b=gbs4DyNAWWk3nQWt
 PBmL5kiB8Vhb3XbzFUJffbf6D9NK9eBeIW+WZ3k01GsRbSaEIAZQIkKu2i4hcHay
 MIqEEIIwMqQImIcrq8tCJwupdmd2X5wOM0UrP7HLvOH9TDWu2nANo/ecqHGV4DXi
 ZlBYReRdXCMdr1lb4DBFONDOf6Cw7amXs9idFXzP6ua+dhTsYQOm/px3tVnkoQmU
 UoA/TFUG+9W2hioa6QfFVcG84ZHUv5aJVTqt0gQBvbEdSjLlowrebGPtsJjHWAIW
 c7yjVF4FTw+saZaYrwq/L4Y6tVuTYxFjN92+897n/0yCFotQ8zHUOCMRmcCMOs0U
 Dom4nQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtysw1m9d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:02:21 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-78580a6b2fbso812365137.3
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 07:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789999341; x=1790604141; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ix7K2oYcuCwTnGzcVZvyWXmiar7ajsrDLl7Zea3zfOU=;
 b=T8fo6D9IkPv9MRuKmtfrgmxKqzvgo+WanWETANQS3PgERYVF4CAGtpWxzDDuWUoEpz
 mr0bM+eaSn+uvwm88KhaXsjuLqNx7TkCcCjllbQWXG6ub+Uf4SBPXmcNXPCw/hNEMi7h
 aK8NthVt44Lc3JZ55u8k4jy2Ionug68idD00ZchoUCNWTbg7qFuvUcbx3rodprZq4P8p
 I1Djcxt200fF5b316sNwkT0UIY11BiVXlGayFzN00Dbj1u8yLnCFTMv86axoCNDdqSCv
 CE/B9fznZGTPiXNBl93D3eoEaipxzYU/J/veN00Yx7dBnmR8ZtZYHBGIW6wZmgorNtYo
 57zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789999341; x=1790604141;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ix7K2oYcuCwTnGzcVZvyWXmiar7ajsrDLl7Zea3zfOU=;
 b=sK38xCX/68MtA9GX1oJzxkp6Jn6xNONRPZZL5BRqnKwRARvAhShrJasKNWTn1HL0R2
 SRgo2GZNReDqVsAn76WVwdsBx6yP9DycPHT9/hoezVYwhPoZ/ytiPq7JeV5UBIfsqczV
 edetd+2zeM5G0fdTdR14ch2c3ch5X/aF8ChMhVmftcq0EXIKOQ3zPlQYVtfTu3wTKolw
 r+59Vp23YNmDJWU9zb63Kws4T372eTqsjgvVuYQQo+hQYhgdEqbnsJWJWtLXL9xxrBDM
 j0O3Rm1xOGM7wZF22B/k1jPrEwrCa1051/nMQhtMDjTWLnvVE8g7ajoaIFUewwCK5S9v
 ylUA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzlz458XC9OGbk5vRimGatM6XLcfBUEYNgfelSc+lj58eKq8D0NVe3CRuZeqDA4xZUX79kCs8/Lbby2@nongnu.org
X-Gm-Message-State: AFuF++n6pfvpDhf+udeJyiuVPBhD6NSyi520jUMteb220JahSrNGwiwp
 WhIyjHtSN0p3eMCUzkU7S4C7dVHLYJwn3FLs/FffmPgCrdB5KkKojhPHH8d3vEhql8XSs15fJ9B
 Hns2Zb+0ZGJqR2iOUTFRkhbxhugK0pRYzfktBjM91qAdcYYLtty58+FlKBA==
X-Gm-Gg: AYBFou11i5Ug/ND6dynftLPQsFpz3jH/ft2muyj6tLiiMKLQEs+3bFIoNm5ixT4QCqB
 ISFHNgAAcM/N9c6vn+k6QuICwsPhSD9B74EmZlnTLtpgkXFoAYsB8SkC+Y2XWlAGmSVL87CCteY
 od9uoRpOq11sL/U02FePgcluxOtlwDS48B4srliOPHpCNNwEjO064eBz+8+NeL+oLe5msMlwWaA
 dtOHYTdeUyx7ZsNCO1YVqzcGCYQZukdO4w+dHx4WP0gQ90Wm/gnXJnWC9ypfAwpSk3c4XQOZFac
 MWkuvpZwF8hIPPX3QQSn49UtQAlNjLicJBF6/zWOCaR5iYxt3vVqRHYeaiHL9JPryjsAXhFtWOT
 tUgtHc/MICHGmsongoWgk
X-Received: by 2002:a05:6102:3592:b0:7a1:f980:e938 with SMTP id
 ada2fe7eead31-7a55d284613mr4403691137.20.1789999340877; 
 Mon, 21 Sep 2026 07:02:20 -0700 (PDT)
X-Received: by 2002:a05:6102:3592:b0:7a1:f980:e938 with SMTP id
 ada2fe7eead31-7a55d284613mr4403635137.20.1789999340397; 
 Mon, 21 Sep 2026 07:02:20 -0700 (PDT)
Received: from [192.168.0.4] ([79.127.134.47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fd2bfe3dasm111677845e9.13.2026.09.21.07.02.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 07:02:19 -0700 (PDT)
Message-ID: <3539b4ac-aeda-4c90-935a-1c5e105713e7@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 16:02:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/11] target/riscv: Replace TARGET_LONG_BITS in header
 exposed to common code
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com
References: <20260918-hw-riscv-cpu-int-v5-0-f98c5a244636@rev.ng>
 <20260918-hw-riscv-cpu-int-v5-3-f98c5a244636@rev.ng>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260918-hw-riscv-cpu-int-v5-3-f98c5a244636@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIwNCBTYWx0ZWRfX/3ycXs19ps+w
 9muhzUWlUtHCc1zlVqbRujj+ohG4YFfRaoi2ufIE1LM7OQfe6FcWpxH2Ifhaykhtg0Dtyo6oWFd
 kFL6nyq5XWhwQ6H3HRx49qhzyXJICJ6jeQ398T0LJph5a+x9IxjgnpYiYAlun5/I7FgXbcfCwYb
 LVOKPsQxKFjlQ+B4uL2+nola3RUh7QOSYuOXHX0PyvYQOz9IMaSHDblTE+1cCli/UoGdoseLmOV
 5/a+S9aL2hZeLYSxKWg5ukfcLTPPoWGsQ3ML4BeijgXE03rBuLvJDJf7DAfFmT2R7W6OyS9JU93
 6Kn6QQy+kiqDLsQLfDX1qO7XXfkSFsVj21FyzxlyW5KjSWMc3OxST3WPCRD4Irj7JDcIATfFOcM
 1nPb4VhgYlTLVrOGhVYRamJ5Imfai8UPoWMHBIR3wzaZO/ek03hnbhOVRY4/aqLIKN/4QdQtCFv
 +X3epRL9iMTij7sSYjA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIwNCBTYWx0ZWRfX/Kc6Q1FBVHXG
 9LqCM/PWd4V2ya2O/ttWmhmHNXkWctaVLRT8AwDoZFW71dFAyU+UtOQ8WkPzx8YY4H1qNJw/IcN
 ivEMiPy2ILXPzLsHmHn8LNU0OBhk5RM=
X-Proofpoint-ORIG-GUID: U_jpyAyGflqJrrbgUzxCd1Anx-hGnugg
X-Proofpoint-GUID: U_jpyAyGflqJrrbgUzxCd1Anx-hGnugg
X-Authority-Analysis: v=2.4 cv=W7etxhWk c=1 sm=1 tr=0 ts=6ab138ed cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=btlkdZlGvBFwkIDmIYSHuA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=843igqfyccz9HQN-R7AA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210204
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Hi Anton,

On 2026-09-18 0:04, Anton Johansson wrote:
> IRQ_LOCAL_GUEST_MAX depends on TARGET_LONG_BITS and is used in
> hw/intc/riscv_imsic.c.  The macro is replaced by a field in RISCVCPUDef
> initialized in riscv_cpu_class_base_init().
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h      |  5 ++++-
>   target/riscv/cpu_bits.h |  2 --
>   hw/intc/riscv_imsic.c   |  4 +++-
>   target/riscv/cpu.c      | 16 ++++++++++++++--
>   4 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index e2e0547eef..a820ec2f6e 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -589,8 +589,11 @@ typedef struct RISCVCPUDef {
>       int32_t vext_spec;
>       RISCVCPUConfig cfg;
>       bool bare;
> -#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
> +#if !defined(CONFIG_USER_ONLY)
> +#if defined(CONFIG_TCG)
>       const RISCVCSR *custom_csrs;
> +#endif
> +    uint8_t irq_local_guest_max;

If it is variable, we shouldn't have it in the def. IMO we
simply want a helper on the CPU class:

   uint8_t riscv_imsic_irq_local_guest_max(RISCVCPUClass *rcc);

WDYT?

>   #endif
>       /* This is just a setter for env->num_triggers.  */
>       uint32_t num_triggers;
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index c01050ce2b..9c499e33f2 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -811,8 +811,6 @@ typedef enum RISCVException {
>   #define IRQ_S_GEXT                         12
>   #define IRQ_PMU_OVF                        13
>   #define IRQ_LOCAL_MAX                      64
> -/* -1 is due to bit zero of hgeip and hgeie being ROZ. */
> -#define IRQ_LOCAL_GUEST_MAX                (TARGET_LONG_BITS - 1)
>   
>   /* RNMI causes */
>   #define RNMI_MAX                           16
> diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
> index cb9ce9612c..bf0434e96f 100644
> --- a/hw/intc/riscv_imsic.c
> +++ b/hw/intc/riscv_imsic.c
> @@ -501,13 +501,15 @@ DeviceState *riscv_imsic_create(MemoryRegion *container, hwaddr addr,
>   {
>       DeviceState *dev = qdev_new(TYPE_RISCV_IMSIC);
>       CPUState *cpu = cpu_by_arch_id(hartid);
> +    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(RISCV_CPU(cpu));
>       uint32_t i;
>   
>       assert(!(addr & (IMSIC_MMIO_PAGE_SZ - 1)));
>       if (mmode) {
>           assert(num_pages == 1);
>       } else {
> -        assert(num_pages >= 1 && num_pages <= (IRQ_LOCAL_GUEST_MAX + 1));
> +        assert(num_pages >= 1 &&
> +               num_pages <= (mcc->def->irq_local_guest_max + 1));
>       }
>       assert(IMSIC_MIN_ID <= num_ids);
>       assert(num_ids <= IMSIC_MAX_ID);
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 5fff9d745e..4f58e91b62 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1416,6 +1416,7 @@ void riscv_add_satp_mode_properties(Object *obj)
>   
>   static void riscv_cpu_set_irq(void *opaque, int irq, int level)
>   {
> +    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(opaque);
>       RISCVCPU *cpu = RISCV_CPU(opaque);
>       CPURISCVState *env = &cpu->env;
>   
> @@ -1454,7 +1455,7 @@ static void riscv_cpu_set_irq(void *opaque, int irq, int level)
>           default:
>               g_assert_not_reached();
>           }
> -    } else if (irq < (IRQ_LOCAL_MAX + IRQ_LOCAL_GUEST_MAX)) {
> +    } else if (irq < (IRQ_LOCAL_MAX + mcc->def->irq_local_guest_max)) {
>           /* Require H-extension for handling guest local interrupts */
>           if (!riscv_has_ext(env, RVH)) {
>               g_assert_not_reached();
> @@ -1501,7 +1502,7 @@ static void riscv_cpu_init(Object *obj)
>   
>   #ifndef CONFIG_USER_ONLY
>       qdev_init_gpio_in(DEVICE(obj), riscv_cpu_set_irq,
> -                      IRQ_LOCAL_MAX + IRQ_LOCAL_GUEST_MAX);
> +                      IRQ_LOCAL_MAX + mcc->def->irq_local_guest_max);
>       if (mcc->def->num_triggers) {
>           env->num_triggers = mcc->def->num_triggers;
>       }
> @@ -3092,6 +3093,17 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
>           mcc->def = g_new0(RISCVCPUDef, 1);
>       }
>   
> +#ifndef CONFIG_USER_ONLY
> +    /*
> +     * RISCVCPUDef::irq_local_guest_max is initialized to
> +     * `target_long_bits()-1` due to bit zero of hgeip and hgeie
> +     * being ROZ.
> +     *
> +     * This value does not vary between CPU types.
> +     */
> +    mcc->def->irq_local_guest_max = target_long_bits() - 1;
> +#endif
> +
>       if (data) {
>           const RISCVCPUDef *def = data;
>           mcc->def->bare |= def->bare;
> 


