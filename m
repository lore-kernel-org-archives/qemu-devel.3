Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E908C606A325
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 09:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=e36N8xfE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HjvPPV+h
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNRuu-0001GB-EM; Sun, 01 Nov 2026 04:31:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xNRuj-0001Bl-66
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 04:31:46 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xNRug-0005ci-VL
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 04:31:44 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A18KJNN3977810
 for <qemu-devel@nongnu.org>; Sun, 1 Nov 2026 09:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 k+OI2r0QnlmiqpCj7p8JkPjMy+HTw2hRCcXztFIShNo=; b=e36N8xfE/GHBMTnb
 pfoPJgOlrUWiCI3WfPYF26KVW+aHCKldcK56dU1guZdGNZaH4F+bM4mYSciD2UVi
 JNWaKV3VARNG6GNn2XxWhEtx2sgXl1HUd6c0peKFMtEKtVTBuEVJRoNDkFxhtaBz
 WLC+pBUob3/n4SGis/vhqulfUjPEMFXa2M/Q5JjYPgS6ydPFxEBhh0PXpdWqXBBI
 fN093vVjAQlV5yyFxdOoG/sSok5Ec5HACBy6JaCBhiNn9l2YShvh6XEwWYYsCQM0
 +ERZfHbCmyhFNPKAk0g+2C4KhGR8kB3AVdBfK0viIr2yErVCm6+h9qDN2ukbnr/P
 1Y0Lbw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn93ejxcw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2026 09:31:39 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cb71b1443so429321385a.2
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2026 01:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793525498; x=1794130298; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=k+OI2r0QnlmiqpCj7p8JkPjMy+HTw2hRCcXztFIShNo=;
 b=HjvPPV+hFsVn2bhIhMxDZ41dR6aeVAx3WOwoNUDHbNxT05wo0g40aKs5N/2RmjRnKc
 aNHm3hHbYFsm/BzKCnqBRhRUrStiHaBBLZIKRwNi73fBROrTMft5ZGSL12fvG7FcCo8K
 aDkMQHOPnaG6OPPsnMnbdTDdIpFk2GPmlvA8LpjWgjOmW1xFVqewFjW73rFfEH7tVrPE
 YlkwxVqMkIPbiAgzhSzp/7sBGSlWvgw0c5GRgUafqciwhwcvLH8al/ifrjyqT6S6OGmB
 n38bQQHucE/qaw9k7OuYr6F59ijacJh49GVo8RVCD3vwuGqMbbfwo86Px3QU8mJwbHNi
 Mpnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793525498; x=1794130298;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k+OI2r0QnlmiqpCj7p8JkPjMy+HTw2hRCcXztFIShNo=;
 b=pcTYauytfcPPW0+5KZj5Xq3CZuSWso0VW2PerjGtH2WKQWUdybgfYoK5knqASGq213
 9aNFcG9IHNzhnvD+gyG6GPPyrpkdwg1ELdRtMMBMo7ZwMC0nlGgGLk9mO4qMseMj/5s0
 QLn59qLCPojS1kOf7JnrIvHbHcHcj4RDvBqHcjmmGh4eMaPptBSvGe+mWyq6VKa1+RFE
 TRgABTwCtp0W46Hr2fvxD5zyRJU5K6BixoGMvi3h7Xh+XudDE9JYIpjELuCmmBN8DrjV
 Jg+jJ8jlTlza4+opKtEIkWsrIgvvyTVg4biOHmg9VjBHJUN408Nc3eX5IfUnJc7SCDvN
 VyNQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxdiEwjglkdt9vDpfLvahqkcashRoLDd6KxOjFsKMu6YdBIfT6BECXt90l8fY9JCGSYorwbWtv8tfd3@nongnu.org
X-Gm-Message-State: AFq9FYKu1LHgl8t4918NO/qMFXERloDeEEtKUF1b35B1Vyz4jrMc0n2p
 mfO77I8HH6iGyLpOkIGLDmQrQShN2ZGv2g4gO9p3ikeLhb8et8vyMhVZ8WgDU3V7iP6zIM8q3S3
 8i+P4SAHI6wSDVox8egfyVxA3GIH2Oc2YrnhHL0v41esR7jBWq3kQxJyIrw==
X-Gm-Gg: AYBFou3DJVQKDGr9F6a68thNPNHzQM2b00OzcLW7Cap9h6uPLJ3U8cLm9LZPXNFpbc0
 bqmjIxyXrTbcML7+I4SVel/Xnd2VJCYt9q4xyCPlL+kDxFRgyITE1K4QAUqlIFEEbMkXdcA+fp3
 NP7Pr59FTEB5/XPs2SBFDSVtw9WTjxU0pBX6nBTBmJuEQnwWRErtrn14YOf+FLz0Sc2n4xJfO5N
 NoVmSblKg9ULa9bCA4i3YUkzRP+4XnpUPOFFLE5V7Fx8j0WPbw3o9Iah7fR4Q4/JHnVgM7CvD+y
 XoPT+HbHlDfrReEH1jaRkAiLWue8QowEO3vjKZag0s9iCOdesOOSqXDDHSCYvtG1sSP0PrevPkf
 SpKtmlvxGGhNaHO9hIW7Yf6SZbIY0iz2RlvSGKlpObRa+gFWIQ/RJNmHd6ubhcJuCuY3tTgBBWd
 OyhWHItfn7
X-Received: by 2002:a05:620a:2610:b0:93f:19c2:da4 with SMTP id
 af79cd13be357-9442184e69dmr971639985a.70.1793525498314; 
 Sun, 01 Nov 2026 01:31:38 -0800 (PST)
X-Received: by 2002:a05:620a:2610:b0:93f:19c2:da4 with SMTP id
 af79cd13be357-9442184e69dmr971637785a.70.1793525497660; 
 Sun, 01 Nov 2026 01:31:37 -0800 (PST)
Received: from [192.168.68.102] ([152.234.122.251])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-944252e516dsm563502985a.4.2026.11.01.01.31.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2026 01:31:37 -0800 (PST)
Message-ID: <7abfa611-06ec-439d-b127-bdb62ff025d5@oss.qualcomm.com>
Date: Sun, 1 Nov 2026 06:31:33 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/27] hw/riscv: pfsoc: Map the SiFive L2CC memory
 windows
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>, Conor Dooley <conor@kernel.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
References: <20261014012323.322790-1-bin.meng@processmission.com>
 <20261014012323.322790-6-bin.meng@processmission.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261014012323.322790-6-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDAzNyBTYWx0ZWRfX9n/WZIxj1wyB
 fEdNo7b98Hr4FAq1Dh3Ikxb5at7va3/mCt3r30YSiCnSLNJAqmUkrK5y8+HPMiPe9/PCBCdOtPl
 1ydyyUXRtMYFr5+MkIkdczzd7Zav0PPvdq9cwovLvnlF0WvED0c6e05oNkcc5BBI4UWuVOHcugb
 ChH8AtiqAOP/8EkD8+8Umeirr5prjPaXZy++5ij1IUitXGSgJrFVl6QT3+89v35rWmBZMDdKtGT
 ysQWfBxZX3n3zwa23uLvPvhG6oiSI/Ev7ngFMcudRWYxkm/Ssn7J1GWf3qjMx3cmwvREj4WlzuI
 qZZP94NqkUi9bWQ2jjQ4VIrHLEUg4NmlCjbCzWBM9L997Mw+IF7M4LcLPOavKC/k7xe3v1R8W7x
 9cr8JLQunSAtgskGNzskg6L5C3CP3HqV7OQ9M0Gdorwi+1dDm+5NcVAdi8gOHwxM9KCFVDTyika
 b9Ux6b7C1G6CcSkG7sA==
X-Authority-Analysis: v=2.4 cv=FciiV5+6 c=1 sm=1 tr=0 ts=6ae706fb cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=QOY8BskYDu05dfarAz2gNQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=FRSEYCzRAAAA:8 a=XYAwZIGsAAAA:8 a=EUspDBNiAAAA:8 a=q3K8DOYYDC0vxjoJZ6QA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=H4N_Y-AU75W7NKDNhZlT:22
 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-ORIG-GUID: ttILGXeORTnp9xTWmGudBZ4qqi2ChddT
X-Proofpoint-GUID: ttILGXeORTnp9xTWmGudBZ4qqi2ChddT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDAzNyBTYWx0ZWRfX4Pe691D+om5W
 nlWaZhtDplVzTn7pqSB+U3HcTT5ArAKHdUI0Wpdx9mU1AEnGlZRMIKyizLTPqwXbGOVCakhBtQg
 NoMVpoauskyEL/4x9nFPTE2QoPQZnSM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010037
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 10/13/2026 10:22 PM, Bin Meng wrote:
> L2-LIM consists of cache SRAM ways controlled by L2CC WayEnable, and
> L2 Zero is the controller's scratchpad allocation interface. Creating
> their RAM stand-ins in the SoC and passing a LIM link splits ownership
> of the register state and the memory views it controls.
> 
> Instantiate the shared SiFive L2CC with 15 masters and the existing
> 2 MiB modeled Zero aperture. Let the controller own the backing and
> both windows, and map its register, LIM, and Zero regions from the SoC.
> Remove the external RAM allocations and the l2-lim link.
> 
> The device restores the visible LIM range after reset or migration.
> L2 Zero keeps its fixed aperture as a RAM approximation of scratchpad
> access rather than tracking the remaining LIM capacity.
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> Tested-by: Conor Dooley <conor.dooley@microchip.com>
> 
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

> 
> (no changes since v3)
> 
> Changes in v3:
> - Configure and instantiate the shared SiFive L2CC
> - Map the register, LIM, and Zero windows exposed by the controller
> - Remove the external RAM allocations and l2-lim link
> - Keep the PolarFire master count and modeled Zero aperture unchanged
> 
>   include/hw/riscv/microchip_pfsoc.h |  2 ++
>   hw/riscv/microchip_pfsoc.c         | 45 ++++++++++--------------------
>   hw/riscv/Kconfig                   |  1 +
>   3 files changed, 17 insertions(+), 31 deletions(-)
> 
> diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
> index 612fd2b69c..18f5003850 100644
> --- a/include/hw/riscv/microchip_pfsoc.h
> +++ b/include/hw/riscv/microchip_pfsoc.h
> @@ -27,6 +27,7 @@
>   #include "hw/cpu/cluster.h"
>   #include "hw/dma/sifive_pdma.h"
>   #include "hw/misc/mchp_pfsoc_dmc.h"
> +#include "hw/misc/sifive_l2cc.h"
>   #include "hw/misc/mchp_pfsoc_ioscb.h"
>   #include "hw/misc/mchp_pfsoc_sysreg.h"
>   #include "hw/net/cadence_gem.h"
> @@ -43,6 +44,7 @@ typedef struct MicrochipPFSoCState {
>       RISCVHartArrayState e_cpus;
>       RISCVHartArrayState u_cpus;
>       DeviceState *plic;
> +    SiFiveL2CCState l2cc;
>       MchpPfSoCDdrSgmiiPhyState ddr_sgmii_phy;
>       MchpPfSoCDdrCfgState ddr_cfg;
>       MchpPfSoCIoscbState ioscb;
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index 8106dbb3ad..d0d8c8f84c 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -174,6 +174,12 @@ static void microchip_pfsoc_soc_instance_init(Object *obj)
>       object_initialize_child(obj, "dma-controller", &s->dma,
>                               TYPE_SIFIVE_PDMA);
>   
> +    object_initialize_child(obj, "l2-cache-controller", &s->l2cc,
> +                            TYPE_SIFIVE_L2CC);
> +    qdev_prop_set_uint32(DEVICE(&s->l2cc), "num-masters", 15);
> +    qdev_prop_set_uint64(DEVICE(&s->l2cc), "zero-size",
> +                         microchip_pfsoc_memmap[MICROCHIP_PFSOC_L2ZERO].size);
> +
>       object_initialize_child(obj, "sysreg", &s->sysreg,
>                               TYPE_MCHP_PFSOC_SYSREG);
>   
> @@ -200,8 +206,6 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
>       MemoryRegion *system_memory = get_system_memory();
>       MemoryRegion *rsvd0_mem = g_new(MemoryRegion, 1);
>       MemoryRegion *e51_dtim_mem = g_new(MemoryRegion, 1);
> -    MemoryRegion *l2lim_mem = g_new(MemoryRegion, 1);
> -    MemoryRegion *l2zero_mem = g_new(MemoryRegion, 1);
>       MemoryRegion *envm_data = g_new(MemoryRegion, 1);
>       MemoryRegion *qspi_xip_mem = g_new(MemoryRegion, 1);
>       char *plic_hart_config;
> @@ -260,35 +264,14 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
>           RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
>           iks->clint_timebase_freq, false);
>   
> -    /* L2 cache controller */
> -    create_unimplemented_device("microchip.pfsoc.l2cc",
> -        memmap[MICROCHIP_PFSOC_L2CC].base, memmap[MICROCHIP_PFSOC_L2CC].size);
> -
> -    /*
> -     * Add L2-LIM at reset size.
> -     * This should be reduced in size as the L2 Cache Controller WayEnable
> -     * register is incremented. Unfortunately I don't see a nice (or any) way
> -     * to handle reducing or blocking out the L2 LIM while still allowing it
> -     * be re returned to all enabled after a reset. For the time being, just
> -     * leave it enabled all the time. This won't break anything, but will be
> -     * too generous to misbehaving guests.
> -     */
> -    memory_region_init_ram(l2lim_mem, NULL, "microchip.pfsoc.l2lim",
> -                           memmap[MICROCHIP_PFSOC_L2LIM].size, &error_fatal);
> -    memory_region_add_subregion(system_memory,
> -                                memmap[MICROCHIP_PFSOC_L2LIM].base,
> -                                l2lim_mem);
> -
> -    /*
> -     * HSS decompresses into the L2 zero-device window and executes there.
> -     * Model it as RAM because QEMU does not model the backing L2 cache.
> -     */
> -    memory_region_init_ram(l2zero_mem, NULL, "microchip.pfsoc.l2zero",
> -                           memmap[MICROCHIP_PFSOC_L2ZERO].size,
> -                           &error_fatal);
> -    memory_region_add_subregion(system_memory,
> -                                memmap[MICROCHIP_PFSOC_L2ZERO].base,
> -                                l2zero_mem);
> +    /* The L2CC owns the SRAM backing and both software-visible windows */
> +    sysbus_realize(SYS_BUS_DEVICE(&s->l2cc), errp);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->l2cc), SIFIVE_L2CC_MMIO_REGS,
> +                    memmap[MICROCHIP_PFSOC_L2CC].base);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->l2cc), SIFIVE_L2CC_MMIO_LIM,
> +                    memmap[MICROCHIP_PFSOC_L2LIM].base);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->l2cc), SIFIVE_L2CC_MMIO_ZERO,
> +                    memmap[MICROCHIP_PFSOC_L2ZERO].base);
>   
>       /* create PLIC hart topology configuration string */
>       plic_hart_config = riscv_plic_hart_config_string(ms->smp.cpus);
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index d06ac26648..46a499f70f 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -21,6 +21,7 @@ config MICROCHIP_PFSOC
>       select MCHP_PFSOC_MMUART
>       select MCHP_PFSOC_SYSREG
>       select RISCV_ACLINT
> +    select SIFIVE_L2CC
>       select SIFIVE_PDMA
>       select SIFIVE_PLIC
>       select UNIMP


