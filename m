Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B64CA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 09:38:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBqlY-0003ls-PU; Wed, 30 Sep 2026 05:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBqlU-0003la-SA
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 05:38:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBqlR-0007q0-Mh
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 05:38:16 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68U7dNpa3082220
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:38:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MG1+ap51Hadk7I+Uv0C2eMus9GRYVfRqpCwD58oOeKE=; b=Alv8nj6KkUsDQetv
 Mo3QBIotl99I4cnzG9JvP6BAqEjG9TXii5HThldgy/CL6R2qbvAnJVsgyB4OObJY
 2OkjIyqk1QNEQC6iOMlKUHLWhLD3juhDKd4bOL8Nzi0rZXpUoSs0y2uyPVyZ9Eag
 u2kBzPW72qXGwqRlW6ykzHbBbYjcvpabE5XHFlyaXiaxC12/AchUwnI/s1O/gCx8
 hUpnSN9YiJqMaCIu8o3bcJT6w7wtCyuG+KlRy59C9Kc/PL0eg8Rt3qZ7QODejMnm
 aA+xydBvAEswlTfGFZOmgNQ6V1gVAdKYRK0/ZIhpk9332pqp2ve42ExSsfcyepNN
 Vg1iYA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0w140ux1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:38:10 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-939c30aa9a0so539355385a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790761090; x=1791365890; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MG1+ap51Hadk7I+Uv0C2eMus9GRYVfRqpCwD58oOeKE=;
 b=Ve10hs32bD1YWqD8FJxbMO1Km+bBRuz6uwQxpevcPEzxcIYeLu9wvngySMRwhwrE6Q
 Fl1+ZXAjanGLZ0yBeBdelNUtHy+nr2ySPaEWNBbsd0B1y3DD3jhdrm6iGQ757p+QtzWU
 WPfkPDHRbuBxBC5TiL3U4Lq3AZlR6hphq7iuIAnOw86hYqu5qmdrlybUIENvfZLs22Rw
 Kj0fvtzIOvjw9LhOs2M22RW1JKPpbz++ILZ63gkGaiCOytz6SMYcGuucY8HNrsLMrv+a
 kJ0riUD1vRbJTXqRegJ4o6NeAFZzqhFommAHWKCTHP7wKyf/CO6cSJmY61cXS03b45+w
 lfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790761090; x=1791365890;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MG1+ap51Hadk7I+Uv0C2eMus9GRYVfRqpCwD58oOeKE=;
 b=nCxjYIPRhpebX0yNoa3qfwcY6pHQR3NSWq+p/YZjr6G+KdJmNnQAFMWJxyVGU7i66f
 3cRgbT6VqZal5beYJPcUEh4UjuYhJqV5LkKmPaiA2BBRJcscbsxac2fg70NvQy70NlFo
 y6rMQHJwyjbDVbIziJGscz4FaFy8Vweg4bV7KAy4VlmDf5tJvC+/FXVN0GSjxmXafVKU
 66UeiFGQFMSVUpZeaGEgFsqaM4juadPwgyFrQUFFY9BQ1DKfSi/hYTw/JGBXOAY5ppVR
 pQIRdZ/bqxedj1D5fKWwxPnOtMgKDEIjnFg24G6otTc/DF8cGXkmBXq8dTL5ZUpDgJI/
 hjDg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw44hZkzrPiZflBUiG1QlVrjsfNkxJd5gNy7AaDs/dpTk7NzZ/IUEQkda1z14PqyYwlb6ZljnHoLnUL@nongnu.org
X-Gm-Message-State: AFuF++lRKiDmHeeN9BU9LR5nQBkDNHhK5yl6Rq5RHLXpKKHZmj93fFys
 ZR8qoBl1oZKpYMiyH2xAWj3mWaa3jd9YtEd1fsWScsOOYU9fTFWnv9ayFeWs8Y9Vy7sA2ruLFPV
 xod/TyPvr+3o2CFQUR1oTNvQB3Bo8AVjG9LXAa8ufPcKe4ok1b0UIUzsilw==
X-Gm-Gg: AYBFou2MX+nR14nazRrUaq0DVz9EnyXcZWtZAUuhGkNd1bzJH6CPd1jIusUlNRr7UDu
 yifmxchjXoxSbXz4MMBcNNT9MHrou41Zvrxf2mbCwi0fYfkcagkcbmt77+QC9hVM6VckuHjy4fL
 GD55ZhOO9XvDcCCDYv6SqyVoLlkyjDj3G+aWz1htwHw4aiYRFM/PfGbMNMcmxGo87L+4vxtjvcP
 MJMSNSRTsnDf68NMRJ63MJNF63rLETDk/MBN08WuYWOUoM6yAg72nTKc7N2bsSylfVLi+29GMZ3
 V5Vl8E259QaIzbdB2y9o6HPl+VesdsaENKCYEuXHqJxPorNgVzGMDScB7Ey/YAuVmtmZXstEba+
 NuZxda5vDpJf/gd2yLVTu1ec61IFAX7Xl9+SG5KY=
X-Received: by 2002:a05:620a:3720:b0:939:6de7:8765 with SMTP id
 af79cd13be357-93ca9744337mr129134985a.44.1790761089509; 
 Wed, 30 Sep 2026 02:38:09 -0700 (PDT)
X-Received: by 2002:a05:620a:3720:b0:939:6de7:8765 with SMTP id
 af79cd13be357-93ca9744337mr129130985a.44.1790761088919; 
 Wed, 30 Sep 2026 02:38:08 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b02a0d237sm1917410f8f.37.2026.09.30.02.38.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 02:38:08 -0700 (PDT)
Message-ID: <64d47ae0-98ab-4570-8711-e2f2f2601b2a@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 11:38:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/24] hw/riscv: pfsoc: Couple L2CC to L2-LIM
Content-Language: en-US
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>, Conor Dooley
 <conor@kernel.org>, Daniel Henrique Barboza
 <daniel.barboza@oss.qualcomm.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
References: <20260904155758.3833179-1-bin.meng@processmission.com>
 <20260904155758.3833179-6-bin.meng@processmission.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260904155758.3833179-6-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAzOCBTYWx0ZWRfX7KCdjF/ba102
 nYf+GthfR+Wk3kQmCdGcr6p78BdJk0tuoOAqb6edaIiTouKPW95zWsDLezjfcVMeoVGtio9VO29
 dCyWh58SZc8k+NmTcJnqYAR52tc2DH8=
X-Proofpoint-GUID: wg7fPuEHxFgDayyDgui03_z1l3KcQC5k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAzOCBTYWx0ZWRfX24Lxg1epD36s
 HhDxHhjQ7fZ3aLiARZkLoiXlEnTDsqALN/lfdCwma8VlDTuyRM9u/iotAyoA9v+ufwPDWTMOrcF
 XnU/0UeZRao/N9oyib1Ot2fDGvyDbvrfK3qI5tu5tGB1vQBbEtvKsRIRz4irgfjeuv0rz+/2/0+
 yTJcwaDM2V7TlCtLe9HoYo03c0F6B1zwLkMbWBUn3JFBn5nqinsTbPSxu3TbRsVpjVYJN1amzSF
 9osh/LfCC5tSlu4LMr3943p63qbPCR1Lmx2MSW/4tE7kTG4Lj0/482IM+TejNvJ/3ensTratk6K
 glM/BJYL21IXEkptOlqN0pLPXryjrGMCnMKj5OvrUVH3TK40xa/AjcGDV/kswXWAAuaFlj7GbEu
 ymkvqdnXohFFXwk4iZYXCD6hySHAa20cmkIwJkCm3Ki/zRn/QqO3VBu5mz9ajWv0IN5RJRSQ620
 c4vGP+0jUbPAtRG5a9A==
X-Authority-Analysis: v=2.4 cv=J8Q/fwnS c=1 sm=1 tr=0 ts=6abcd882 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=FRSEYCzRAAAA:8 a=Ryv9mEuIm_fnp62sHiwA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-ORIG-GUID: wg7fPuEHxFgDayyDgui03_z1l3KcQC5k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0
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

Hi,

On 4/9/26 17:57, Bin Meng wrote:
> Instantiate the L2CC in the PolarFire SoC machine and connect its
> WayEnable register to the L2-LIM MemoryRegion. Back the complete 2 MiB
> aperture and shrink it by 128 KiB for each cache way enabled.
> 
> Keep L2 Zero at its fixed aperture because it represents a cache
> allocation window rather than the remaining L2-LIM capacity.
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> Reviewed-by: Chao Liu <chao.liu@processmission.com>
> ---
> 
> (no changes since v1)
> 
>   include/hw/misc/mchp_pfsoc_l2cc.h  |  1 +
>   include/hw/riscv/microchip_pfsoc.h |  2 ++
>   hw/misc/mchp_pfsoc_l2cc.c          | 51 ++++++++++++++++++++++++++++++
>   hw/riscv/microchip_pfsoc.c         | 23 +++++++-------
>   hw/riscv/Kconfig                   |  1 +
>   5 files changed, 67 insertions(+), 11 deletions(-)
> 
> diff --git a/include/hw/misc/mchp_pfsoc_l2cc.h b/include/hw/misc/mchp_pfsoc_l2cc.h
> index 1b5b3888d5..3a175a6340 100644
> --- a/include/hw/misc/mchp_pfsoc_l2cc.h
> +++ b/include/hw/misc/mchp_pfsoc_l2cc.h
> @@ -22,6 +22,7 @@ typedef struct MchpPfSoCL2ccState {
>       SysBusDevice parent;
>       uint64_t regs[MCHP_PFSOC_L2CC_REG_NUM];
>       RegisterInfo regs_info[MCHP_PFSOC_L2CC_REG_NUM];
> +    MemoryRegion *l2lim;
>   } MchpPfSoCL2ccState;
>   
>   #define TYPE_MCHP_PFSOC_L2CC "mchp.pfsoc.l2cc"
> diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
> index 612fd2b69c..0aeccedf77 100644
> --- a/include/hw/riscv/microchip_pfsoc.h
> +++ b/include/hw/riscv/microchip_pfsoc.h
> @@ -27,6 +27,7 @@
>   #include "hw/cpu/cluster.h"
>   #include "hw/dma/sifive_pdma.h"
>   #include "hw/misc/mchp_pfsoc_dmc.h"
> +#include "hw/misc/mchp_pfsoc_l2cc.h"
>   #include "hw/misc/mchp_pfsoc_ioscb.h"
>   #include "hw/misc/mchp_pfsoc_sysreg.h"
>   #include "hw/net/cadence_gem.h"
> @@ -43,6 +44,7 @@ typedef struct MicrochipPFSoCState {
>       RISCVHartArrayState e_cpus;
>       RISCVHartArrayState u_cpus;
>       DeviceState *plic;
> +    MchpPfSoCL2ccState l2cc;
>       MchpPfSoCDdrSgmiiPhyState ddr_sgmii_phy;
>       MchpPfSoCDdrCfgState ddr_cfg;
>       MchpPfSoCIoscbState ioscb;
> diff --git a/hw/misc/mchp_pfsoc_l2cc.c b/hw/misc/mchp_pfsoc_l2cc.c
> index 979d904676..4b87c963fc 100644
> --- a/hw/misc/mchp_pfsoc_l2cc.c
> +++ b/hw/misc/mchp_pfsoc_l2cc.c
> @@ -11,6 +11,9 @@
>   
>   #include "qemu/osdep.h"
>   #include "qemu/log.h"
> +#include "qemu/units.h"
> +#include "qapi/error.h"
> +#include "hw/core/qdev-properties.h"
>   #include "hw/core/register.h"
>   #include "hw/core/registerfields.h"
>   #include "hw/misc/mchp_pfsoc_l2cc.h"
> @@ -39,6 +42,25 @@ REG64(L2_WAY_MASK_HART4_DCACHE, 0x868)
>   REG64(L2_WAY_MASK_HART4_ICACHE, 0x870)
>   
>   #define L2_CONFIG_RESET         0x06091004
> +#define L2_LIM_WAY_COUNT        15
> +#define L2_WAY_SIZE             (128 * KiB)
> +
> +static void mchp_pfsoc_l2cc_update_l2lim(MchpPfSoCL2ccState *s,
> +                                         uint64_t way_enable)
> +{
> +    uint64_t l2lim_size;
> +
> +    if (way_enable >= L2_LIM_WAY_COUNT) {
> +        l2lim_size = 0;
> +    } else {
> +        l2lim_size = (L2_LIM_WAY_COUNT - way_enable) * L2_WAY_SIZE;
> +    }
> +
> +    memory_region_transaction_begin();
> +    memory_region_set_size(s->l2lim, l2lim_size);
> +    memory_region_set_enabled(s->l2lim, l2lim_size != 0);
> +    memory_region_transaction_commit();
> +}
>   
>   static uint64_t mchp_pfsoc_l2cc_way_enable_pre_write(RegisterInfo *reg,
>                                                        uint64_t value)
> @@ -48,6 +70,14 @@ static uint64_t mchp_pfsoc_l2cc_way_enable_pre_write(RegisterInfo *reg,
>       return MAX(current, value);
>   }
>   
> +static void mchp_pfsoc_l2cc_way_enable_post_write(RegisterInfo *reg,
> +                                                  uint64_t value)
> +{
> +    MchpPfSoCL2ccState *s = MCHP_PFSOC_L2CC(reg->opaque);
> +
> +    mchp_pfsoc_l2cc_update_l2lim(s, value);
> +}
> +
>   #define WAY_MASK_REGISTER(_name)                \
>       {                                           \
>           .name = "WAY_MASK_" #_name,             \
> @@ -66,6 +96,7 @@ static const RegisterAccessInfo mchp_pfsoc_l2cc_regs_info[] = {
>           .addr = A_L2_WAY_ENABLE,
>           .rsvd = ~R_L2_WAY_ENABLE_VALUE_MASK,
>           .pre_write = mchp_pfsoc_l2cc_way_enable_pre_write,
> +        .post_write = mchp_pfsoc_l2cc_way_enable_post_write,
>       },
>       WAY_MASK_REGISTER(DMA),
>       WAY_MASK_REGISTER(AXI4_PORT_0),
> @@ -157,11 +188,31 @@ static void mchp_pfsoc_l2cc_init(Object *obj)
>       sysbus_init_mmio(SYS_BUS_DEVICE(obj), &reg_array->mem);
>   }
>   
> +static void mchp_pfsoc_l2cc_realize(DeviceState *dev, Error **errp)
> +{
> +    MchpPfSoCL2ccState *s = MCHP_PFSOC_L2CC(dev);
> +
> +    if (!s->l2lim) {
> +        error_setg(errp, TYPE_MCHP_PFSOC_L2CC ": 'l2-lim' link not set");
> +        return;
> +    }
> +
> +    mchp_pfsoc_l2cc_update_l2lim(s, s->regs[R_L2_WAY_ENABLE]);
> +}
> +
> +static const Property mchp_pfsoc_l2cc_properties[] = {
> +    DEFINE_PROP_LINK("l2-lim", MchpPfSoCL2ccState, l2lim,
> +                     TYPE_MEMORY_REGION, MemoryRegion *),
> +};
> +
>   static void mchp_pfsoc_l2cc_class_init(ObjectClass *klass, const void *data)
>   {
> +    DeviceClass *dc = DEVICE_CLASS(klass);
>       ResettableClass *rc = RESETTABLE_CLASS(klass);
>   
>       rc->phases.hold = mchp_pfsoc_l2cc_reset_hold;
> +    device_class_set_props(dc, mchp_pfsoc_l2cc_properties);
> +    dc->realize = mchp_pfsoc_l2cc_realize;
>   }
>   
>   static const TypeInfo mchp_pfsoc_l2cc_info = {
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index 8106dbb3ad..114567867b 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -174,6 +174,9 @@ static void microchip_pfsoc_soc_instance_init(Object *obj)
>       object_initialize_child(obj, "dma-controller", &s->dma,
>                               TYPE_SIFIVE_PDMA);
>   
> +    object_initialize_child(obj, "l2-cache-controller", &s->l2cc,
> +                            TYPE_MCHP_PFSOC_L2CC);

Is this the same model used by hw/riscv/sifive_u.c?

>       object_initialize_child(obj, "sysreg", &s->sysreg,
>                               TYPE_MCHP_PFSOC_SYSREG);
>   
> @@ -260,18 +263,9 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
>           RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
>           iks->clint_timebase_freq, false);
>   
> -    /* L2 cache controller */
> -    create_unimplemented_device("microchip.pfsoc.l2cc",
> -        memmap[MICROCHIP_PFSOC_L2CC].base, memmap[MICROCHIP_PFSOC_L2CC].size);
> -
>       /*
> -     * Add L2-LIM at reset size.
> -     * This should be reduced in size as the L2 Cache Controller WayEnable
> -     * register is incremented. Unfortunately I don't see a nice (or any) way
> -     * to handle reducing or blocking out the L2 LIM while still allowing it
> -     * be re returned to all enabled after a reset. For the time being, just
> -     * leave it enabled all the time. This won't break anything, but will be
> -     * too generous to misbehaving guests.
> +     * Back the complete L2-LIM aperture. The L2 cache controller resizes
> +     * this MemoryRegion to 128 KiB for every way assigned to L2-LIM.
>        */
>       memory_region_init_ram(l2lim_mem, NULL, "microchip.pfsoc.l2lim",
>                              memmap[MICROCHIP_PFSOC_L2LIM].size, &error_fatal);
> @@ -279,6 +273,13 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
>                                   memmap[MICROCHIP_PFSOC_L2LIM].base,
>                                   l2lim_mem);
>   
> +    /* L2 cache controller */
> +    object_property_set_link(OBJECT(&s->l2cc), "l2-lim",
> +                             OBJECT(l2lim_mem), &error_abort);

Modelling question (I have no clue with this particular SoC): does
'l2-lim' belong to the SoC layer, consumed by the L2CC or is it
internal to the L2CC and exposed to the SoC?

> +    sysbus_realize(SYS_BUS_DEVICE(&s->l2cc), errp);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->l2cc), 0,
> +                    memmap[MICROCHIP_PFSOC_L2CC].base);
> +
>       /*
>        * HSS decompresses into the L2 zero-device window and executes there.
>        * Model it as RAM because QEMU does not model the backing L2 cache.
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index d06ac26648..85b535c7cb 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -18,6 +18,7 @@ config MICROCHIP_PFSOC
>       select DEVICE_TREE
>       select MCHP_PFSOC_DMC
>       select MCHP_PFSOC_IOSCB
> +    select MCHP_PFSOC_L2CC
>       select MCHP_PFSOC_MMUART
>       select MCHP_PFSOC_SYSREG
>       select RISCV_ACLINT


