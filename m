Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60AF7C2A09B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 13:37:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsKkO-0004sE-69; Fri, 07 Aug 2026 09:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsKkM-0004rZ-4Z
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 09:36:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsKkG-0001pD-Jf
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 09:36:25 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 677CfkeF1035572
 for <qemu-devel@nongnu.org>; Fri, 7 Aug 2026 13:36:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X+JqRjRoEpCdVulu/Xyl74sNOdu3OtwZ4MZiUpvat/s=; b=IuIh8mmx5+yNcjiD
 YwYO0Ly5SBnCRIS5Gjo1o2Y52lKkttRZ3BUV3S9xhx91c/pBIm7sH593HXah3CI0
 JXrWQ9nLJjwfeZwSF3wV+WS8YOLvyDq5QRyWLWjMWrBd9psttwCfnKt3GcOA1gA2
 v37YCds5CGJ0lzP+WubE1HgGgp7oC3eUB5nwxqOBNCamnMucdFN+GF7ixDgt7/vo
 qIWWAvA4Vo0XubmRUqMjUbGvV3KR0BA9NdbDk7A/CvJsUPjFRe2ssehiyiG8vizj
 FX5cV/Ib1R6oNsqlNeUhA8GMfv+pkBVl8jZT8qw9RUgSFwujwyoOpiN17MeQ2erf
 jTGbeg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwege0gq8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 13:36:17 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c01ff996dso38545781cf.2
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 06:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786109777; x=1786714577; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=X+JqRjRoEpCdVulu/Xyl74sNOdu3OtwZ4MZiUpvat/s=;
 b=Z/uFKf4L+8VQLZiadkPh2q1PwFNjn9Hqf/OHM6LXeR3+RixL7zI9brT7LWkNMkYGBj
 CF+W7k3Bj2T6Su7V15wRDjUFA3XpC2P+rk80GNCtHcKiihWox1gmUUeHXmuJGUCWeiox
 weuVYKvSazjbfK5v1Yc9nBiEZ66W16w2m0u40ZHm074Fj3LcFx4eNqYwGRmgIX8JFrg7
 1YuN2D9gz6ECv3i2l+oSnQa5uBwk58J3YA+lCTWsgjKfZGk7eUNW5G1zyVE6a1sbjy/m
 8kWwQ9U0Ix4C6/DxamHlowehgJ6RuxUySZoRvWh5bKrk/EoMvoJ92RDvnnl2IiZhTCdi
 zE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786109777; x=1786714577;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X+JqRjRoEpCdVulu/Xyl74sNOdu3OtwZ4MZiUpvat/s=;
 b=lyuZfnf7zvjiTypeLr94xtEJkYTPfXAPsPnFO7eUCCRrS/FQ8SvJx7GC2IN1R3SCti
 4mIVvg1kWc491sz4Y/4Ql4x1CtuLDCqA6I4GZp8/JhjuVJUIhEB5s9lVX3UxzFqiUMV8
 07E+OEeW6uUQXRpuUqNSkvHcMjCRILAMoOshREKUFVyPAH8Sf3vNNx7nxhEnKPo1evt8
 PaSVj4D7/9PdkhhNSTjsctxQBxcR9Qxjwk3jiZzXQVJcVSRXjq1Xz8F4PzL4NNUat/AK
 BLvlUXn1R/wKYiRLpY25gm/xsFCJlLZeOKBDqhlZyKnPgXfSkrOA+XTt0opDxNUFXKMq
 Mn9g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq8Du2n8ppknOBIFhNBVKKXNUZVbDLJtIj+Tl7qM0x58PteL/DmbImyULqNndU+DmWwONPtJ66QQLjt@nongnu.org
X-Gm-Message-State: AOJu0Yx8aGBsbNEnC/tJutmCGuTENWJV4WNVE+dzDyoCvOXi1H/95qnh
 HpzGZSjjh1Kl/HndXbj26acLCC2ksTSx2R/zhitWLVM23pc2Bw1Rq+Bo9paGMfjiIJjp6f8kX98
 Xmc0jmei1U3+OXwvRDeYuRRWiQC/Z2RXZSiqn4MVlYFD3ZzuoN/toAoIyxw==
X-Gm-Gg: AR+sD100zDl/HDc1VlKhhUCdi8puPPg3sQQMqk6UiJNu5yUw0S3brTWqEnfk0q25fy/
 wPL5F3zuH7MOdFbWUpRwDs0z7idGzb+7uQk+Mf9Rnpmb1yqvoGsQCxK/Opp640WlLUNPI8vNhhZ
 b8lDR1cn6pcW0bxHZRhu1TXDyHXkA84G3dAexXJuD8B4QCMAp6RDriuJAOX0276ZooiEGWBtsfj
 IhI5Wf/i1zmXx8PU9WW2sZy3v6hO7cQ1wePFU8pJ0cYGQ9+v3AU7W1mplovU9YqTfutwrM5gu9p
 5qM84ZpOfloR9VNnE9YH9wO4LJmtdxOsfclBx00nlXT4LIZSG6A9vfZ9nIAKcLXbqBmV9vYVD6h
 xP++l9M+6DUwpaBjusslcI4S8Qv6YlXODuS8B
X-Received: by 2002:a05:622a:588d:b0:528:3882:386a with SMTP id
 d75a77b69052e-52d18e6e5b9mr36840011cf.11.1786109776636; 
 Fri, 07 Aug 2026 06:36:16 -0700 (PDT)
X-Received: by 2002:a05:622a:588d:b0:528:3882:386a with SMTP id
 d75a77b69052e-52d18e6e5b9mr36839221cf.11.1786109776141; 
 Fri, 07 Aug 2026 06:36:16 -0700 (PDT)
Received: from [192.168.68.104] ([187.11.154.152])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-908a918d7f1sm8922986d6.10.2026.08.07.06.36.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2026 06:36:15 -0700 (PDT)
Message-ID: <542bbd82-b2c9-4d6e-b4d4-e26ea360d2b3@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 10:36:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/riscv/tt-atlantis: Add PRCMs to tt-atlantis model
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
References: <20260729-atlantis_prcm-v1-0-502882933e51@oss.tenstorrent.com>
 <20260729-atlantis_prcm-v1-2-502882933e51@oss.tenstorrent.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260729-atlantis_prcm-v1-2-502882933e51@oss.tenstorrent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 4p0AbSjLTMpVGQ-S2mgb3Ddfalg9XfbT
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEwNiBTYWx0ZWRfX0dBxPvC53Q52
 rr7t0UWNDXZK+SimS5wNaoTUfmiww+7eW4R/e/tfoG83qN72lUlrcHnEC0dtAo6IA18EBRAhkH3
 MM3204kAKxCvmeLYfq5tA7fqbfQf0+U=
X-Proofpoint-GUID: 4p0AbSjLTMpVGQ-S2mgb3Ddfalg9XfbT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEwNiBTYWx0ZWRfX07htOPCDBNaQ
 viDXRxVLNpdPLMvWeZS3qPLNiCTNGnf8+ZHO8NeqCuqs9rqge0k3vHnVYoZkIknmnBXC4xSYNqJ
 nVKWuThdRAz+2PsH60OaHdt1bbuqis6/r8TdnvQsPCoEgadlaC8O8XlNBKwJnuF9vkXVBekcuhY
 GbUBziWPoB+st/KLtMDzuBW38VfrvU8TYrz3saCrEim4YEafkyGun/NK/raTMaUjH05YuRdNUtz
 hyfZkIDmElisJhP1MHc4hFW/+6lbgT5rphgypAnL03SZpc2askgZPBYwEDxHG1F32uReVbUJFUw
 3NCO6c7+GwGwkaPM4J1KkDMd+JwnCGn1z4pYZYrvbXwPIcJOoRjaptze4CjPw/ojVHOAr0EahHO
 hr7y2mzRGEFBk8SSWBQi6Qdp8Bb96b9Ao5x3AXM6S5S217ObZ8lJUN6qtJwJgfl4kQXnPmlLkGE
 5jN5qY0NpApL7d9etyg==
X-Authority-Analysis: v=2.4 cv=X71i7mTe c=1 sm=1 tr=0 ts=6a75df51 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=iMfxv9gflPUPBcmW7/Gq5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=t9496tuAAAAA:8 a=TZacIRybJP-EH6IWneoA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=4wQ91nGE5lQcD7eh5OX0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070106
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

Hello,

On 7/29/2026 12:21 PM, Anirudh Srinivasan wrote:
> Atlantis has 4 PRCMs that are visible from S mode by the Ascalon Core
> (RCPU, HSIO, PCIe and MM). This commit adds these 4 PRCM blocks to the
> tt-atlantis model, along with necessary device tree nodes for them.
> 
> Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> ---
>   docs/system/riscv/tt_atlantis.rst |  1 +
>   hw/riscv/tt_atlantis.c            | 92 +++++++++++++++++++++++++++++++++++++++
>   include/hw/riscv/tt_atlantis.h    | 19 ++++++++
>   3 files changed, 112 insertions(+)
> 
> diff --git a/docs/system/riscv/tt_atlantis.rst b/docs/system/riscv/tt_atlantis.rst
> index 1f2880d617..539c22354f 100644
> --- a/docs/system/riscv/tt_atlantis.rst
> +++ b/docs/system/riscv/tt_atlantis.rst
> @@ -14,6 +14,7 @@ tt-atlantis QEMU model features
>   * 8-core Ascalon-X CPU Cluster
>   * RISC-V compliant Advanced Interrupt Architecture
>   * 16550A compatible UART
> +* 4 PRCMs (Clock and Reset Controllers)
>   
>   Known limitations
>   -----------------
> diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
> index d808bcc11c..17cc5318b3 100644
> --- a/hw/riscv/tt_atlantis.c
> +++ b/hw/riscv/tt_atlantis.c
> @@ -26,6 +26,7 @@
>   #include "hw/char/serial-mm.h"
>   #include "hw/intc/riscv_aclint.h"
>   #include "hw/misc/unimp.h"
> +#include "hw/misc/tt_atlantis_prcm.h"
>   
>   #include "system/system.h"
>   #include "system/device_tree.h"
> @@ -59,6 +60,10 @@ static const MemMapEntry tt_atlantis_memmap[] = {
>       [TT_ATL_I2C3] =             { 0xd4070000,       0x10000 },
>       [TT_ATL_I2C4] =             { 0xd4080000,       0x10000 },
>       [TT_ATL_UART1] =            { 0xd4110000,       0x10000 },
> +    [TT_ATL_PRCM_RCPU] =        { 0xd0000000,       0x10000 },
> +    [TT_ATL_PRCM_PCIE] =        { 0xd8000000,         0x100 },
> +    [TT_ATL_PRCM_MM] =          { 0xdc000000,        0x1000 },
> +    [TT_ATL_PRCM_HSIO] =        { 0xe00c0000,         0x510 },
>       [TT_ATL_SAPLIC] =           { 0xe8000000,     0x4000000 },
>       [TT_ATL_DDR_HI] =          { 0x100000000,  0x1000000000 },
>   };
> @@ -328,11 +333,38 @@ static void create_fdt_i2c_device(TTAtlantisState *s, int bus,
>       qemu_fdt_setprop_cell(fdt, name, "reg", addr);
>   }
>   
> +static char *create_fdt_prcm(void *fdt, const MemMapEntry *mem,
> +                             const char *prcm_name, uint32_t prcm_phandle)
> +{
> +    hwaddr base = mem->base;
> +    hwaddr size = mem->size;
> +    char *name = g_strdup_printf("/soc/prcm_%s@%" PRIx64,
> +                                 prcm_name, mem->base);
> +    g_autofree char *compatible =
> +        g_strdup_printf("tenstorrent,atlantis-prcm-%s", prcm_name);
> +
> +    qemu_fdt_add_subnode(fdt, name);
> +    qemu_fdt_setprop_string(fdt, name, "compatible", compatible);
> +    qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2, base, 2, size);
> +    qemu_fdt_setprop_cell(fdt, name, "#address-cells", 1);
> +    qemu_fdt_setprop_cell(fdt, name, "#size-cells", 0);
> +    qemu_fdt_setprop_cell(fdt, name, "#clock-cells", 1);
> +    qemu_fdt_setprop_cell(fdt, name, "#reset-cells", 1);
> +    qemu_fdt_setprop_cell(fdt, name, "phandle", prcm_phandle);
> +
> +    return name;
> +}
> +
>   static void finalize_fdt(TTAtlantisState *s)
>   {
>       uint32_t aplic_s_phandle = next_phandle();
>       uint32_t imsic_s_phandle = next_phandle();
>       uint32_t periph_clk_phandle = next_phandle();
> +    uint32_t osc_24m_phandle = next_phandle();
> +    uint32_t prcm_rcpu_phandle = next_phandle();
> +    uint32_t prcm_hsio_phandle = next_phandle();
> +    uint32_t prcm_pcie_phandle = next_phandle();
> +    uint32_t prcm_mm_phandle = next_phandle();

Hmmm seems like you're not really using all of these ... 'osc_24m_phandle'
is indeed needed since you're giving it to create_fdt_clk() and using it
to set "clocks" for all create_fdt_prcm() FDTs.  'prcm_rcpu_phandle' is
also used in other FDTs so it's fine.

But the other 3 phandles aren't used by nothing else aside from supplying
a phandle to create_fdt_prcm().

I think we can make things a little easier by:

- remove the 'uint32_t prcm_phandle' argument from create_fdt_prcm().  When
   creating the phandle do instead:

 > +    qemu_fdt_setprop_cell(fdt, name, "phandle", next_phandle());


-  remove all phandles that you created just to comply with the old create_fdt_prcm().
    Keep osc_24m_phandle as is and just declare  prcm_rcpu_phandle:

 > +    uint32_t osc_24m_phandle = next_phandle();
 > +    uint32_t prcm_rcpu_phandle;


After creating the FDT of rcpu, retrieve the phandle used to create the
rcpu subnode:

 > +    g_autofree char *rcpu_name = create_fdt_prcm(fdt,
 > +        &s->memmap[TT_ATL_PRCM_RCPU], "rcpu");

        prcm_rcpu_phandle = qemu_fdt_get_phandle(fdt, rcpu_name);


And now you have access to the phandles you need for everything, without
bothering storing phandles you don't care about.



Thanks,
Daniel


>       void *fdt = MACHINE(s)->fdt;
>   
>       create_fdt_cpu(s, s->memmap, aplic_s_phandle, imsic_s_phandle);
> @@ -348,6 +380,33 @@ static void finalize_fdt(TTAtlantisState *s)
>                       aplic_s_phandle);
>   
>       create_fdt_clk(fdt, "periph-clk", 100000000, periph_clk_phandle);
> +    create_fdt_clk(fdt, "osc_24m", 24000000, osc_24m_phandle);
> +
> +    g_autofree char *rcpu_name = create_fdt_prcm(fdt,
> +        &s->memmap[TT_ATL_PRCM_RCPU], "rcpu", prcm_rcpu_phandle);
> +    qemu_fdt_setprop_cells(fdt, rcpu_name, "clocks", osc_24m_phandle);
> +    qemu_fdt_setprop_cells(fdt, rcpu_name, "assigned-clocks",
> +                           prcm_rcpu_phandle, TT_ATL_CLK_RCPU_ROOT,
> +                           prcm_rcpu_phandle, TT_ATL_CLK_NOCC_CLK);
> +    qemu_fdt_setprop_cells(fdt, rcpu_name, "assigned-clock-parents",
> +                           prcm_rcpu_phandle, TT_ATL_CLK_RCPU_PLL,
> +                           prcm_rcpu_phandle, TT_ATL_CLK_NOC_PLL);
> +
> +    g_autofree char *hsio_name = create_fdt_prcm(fdt,
> +        &s->memmap[TT_ATL_PRCM_HSIO], "hsio", prcm_hsio_phandle);
> +    qemu_fdt_setprop_cells(fdt, hsio_name, "clocks", osc_24m_phandle,
> +                           prcm_rcpu_phandle, TT_ATL_CLK_HSIO_PLL);
> +
> +    g_autofree char *pcie_name = create_fdt_prcm(fdt,
> +        &s->memmap[TT_ATL_PRCM_PCIE], "pcie", prcm_pcie_phandle);
> +    qemu_fdt_setprop_cells(fdt, pcie_name, "clocks", osc_24m_phandle,
> +                           prcm_rcpu_phandle, TT_ATL_CLK_PCIE_PLL);
> +
> +    g_autofree char *mm_name = create_fdt_prcm(fdt,
> +        &s->memmap[TT_ATL_PRCM_MM], "mm", prcm_mm_phandle);
> +    qemu_fdt_setprop_cells(fdt, mm_name, "clocks", osc_24m_phandle,
> +                           prcm_rcpu_phandle, TT_ATL_CLK_MM_PLL0,
> +                           prcm_rcpu_phandle, TT_ATL_CLK_MM_PLL1);
>   
>       for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
>           create_fdt_i2c(fdt,
> @@ -545,6 +604,39 @@ static void tt_atlantis_machine_init(MachineState *machine)
>       serial_mm_init(system_memory, s->memmap[TT_ATL_UART1].base, 2,
>                      qdev_get_gpio_in(s->irqchip, TT_ATL_UART1_IRQ),
>                      115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
> +
> +    /* Add rcpu prcm block */
> +    object_initialize_child(OBJECT(s), "prcm-rcpu", &s->prcm[0],
> +                            TYPE_TT_ATLANTIS_PRCM_RCPU);
> +    sysbus_realize(SYS_BUS_DEVICE(&s->prcm[0]), &error_fatal);
> +    memory_region_add_subregion(system_memory,
> +            s->memmap[TT_ATL_PRCM_RCPU].base,
> +            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->prcm[0]), 0));
> +
> +    /* Add hsio prcm block */
> +    object_initialize_child(OBJECT(s), "prcm-hsio", &s->prcm[1],
> +                            TYPE_TT_ATLANTIS_PRCM_HSIO);
> +    sysbus_realize(SYS_BUS_DEVICE(&s->prcm[1]), &error_fatal);
> +    memory_region_add_subregion(system_memory,
> +            s->memmap[TT_ATL_PRCM_HSIO].base,
> +            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->prcm[1]), 0));
> +
> +    /* Add pcie prcm block */
> +    object_initialize_child(OBJECT(s), "prcm-pcie", &s->prcm[2],
> +                            TYPE_TT_ATLANTIS_PRCM_PCIE);
> +    sysbus_realize(SYS_BUS_DEVICE(&s->prcm[2]), &error_fatal);
> +    memory_region_add_subregion(system_memory,
> +            s->memmap[TT_ATL_PRCM_PCIE].base,
> +            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->prcm[2]), 0));
> +
> +    /* Add mm prcm block */
> +    object_initialize_child(OBJECT(s), "prcm-mm", &s->prcm[3],
> +                            TYPE_TT_ATLANTIS_PRCM_MM);
> +    sysbus_realize(SYS_BUS_DEVICE(&s->prcm[3]), &error_fatal);
> +    memory_region_add_subregion(system_memory,
> +            s->memmap[TT_ATL_PRCM_MM].base,
> +            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->prcm[3]), 0));
> +
>       /*
>        * Atlantis contains a DesignWare uart while the QEMU machine
>        * uses the serial_mm model with the base ns16550 register set.
> diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
> index 7f7d4a5a59..20bcdfeb52 100644
> --- a/include/hw/riscv/tt_atlantis.h
> +++ b/include/hw/riscv/tt_atlantis.h
> @@ -13,12 +13,14 @@
>   #include "hw/core/sysbus.h"
>   #include "hw/i2c/designware_i2c.h"
>   #include "hw/intc/riscv_imsic.h"
> +#include "hw/misc/tt_atlantis_prcm.h"
>   #include "hw/riscv/riscv_hart.h"
>   
>   #define TYPE_TT_ATLANTIS_MACHINE MACHINE_TYPE_NAME("tt-atlantis")
>   OBJECT_DECLARE_SIMPLE_TYPE(TTAtlantisState, TT_ATLANTIS_MACHINE)
>   
>   #define TT_ATL_NUM_I2C 5
> +#define TT_ATL_NUM_PRCM 4
>   
>   struct TTAtlantisState {
>       /*< private >*/
> @@ -31,6 +33,7 @@ struct TTAtlantisState {
>       RISCVHartArrayState soc;
>       DeviceState *irqchip;
>       DesignWareI2CState i2c[TT_ATL_NUM_I2C];
> +    TTAtlantisPRCMState prcm[TT_ATL_NUM_PRCM];
>   
>       int fdt_size;
>   };
> @@ -59,6 +62,22 @@ enum {
>       TT_ATL_SAPLIC,
>       TT_ATL_SIMSIC,
>       TT_ATL_UART1,
> +    TT_ATL_PRCM_RCPU,
> +    TT_ATL_PRCM_HSIO,
> +    TT_ATL_PRCM_PCIE,
> +    TT_ATL_PRCM_MM,
> +};
> +
> +/* RCPU PRCM Clock IDs */
> +enum {
> +    TT_ATL_CLK_RCPU_PLL = 0,
> +    TT_ATL_CLK_RCPU_ROOT = 1,
> +    TT_ATL_CLK_NOC_PLL = 25,
> +    TT_ATL_CLK_NOCC_CLK = 26,
> +    TT_ATL_CLK_HSIO_PLL = 54,
> +    TT_ATL_CLK_PCIE_PLL = 55,
> +    TT_ATL_CLK_MM_PLL0 = 56,
> +    TT_ATL_CLK_MM_PLL1 = 57,
>   };
>   
>   #endif
> 


