Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA27C61DC6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 11:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzXzy-0000HC-TE; Thu, 27 Aug 2026 07:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzXzw-0000Fw-JG
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 07:10:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzXzu-0005OA-Bx
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 07:10:20 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67R9Gtap027288
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 11:10:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QKJpKMamDgnPbbj4cbspUVDYpZgutsi4Lligd+Aq2RQ=; b=Olr7DtsF+Nh9LeSo
 Aop1yAEex2VU9t4SBtCoesGsvCnGudxn8oBt0QGNjXmuycfesD66ZpAZh8pKgG2d
 k/dhCjEKuAVL2cFxalzwFNLWvleraj+PehOkusbZEaIYld6mzONh+NplxOvziTva
 IeBWsx1K8n4A2en5JGApH983StIOqKd/JXoMA0FgdDEA/G4lLfynqPYOfvZDEurs
 9fnRUR6jEd41iwT8Rx6WBkqQ0oymUX3XgQI/wN96t3A02ovXxP/Abpkt8AEP/ulc
 QdYxyDJhsJbVn7sxxg4Pd/49FrJQ1VEBBPWDSn3QP8nVxOOpIVDvv9/vHUMRHAo8
 cqbyUA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga0wbvc09-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 11:10:16 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-90c8da50f8dso36039556d6.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 04:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787829015; x=1788433815; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QKJpKMamDgnPbbj4cbspUVDYpZgutsi4Lligd+Aq2RQ=;
 b=FITn0n+eufqAkwr4Slk56aYZ0SRGfbGdLAjib+l8NFw1JZpaw+/3wmXxjRi9Ymg/n4
 cXW0wfPDxjomZv9g3M5jCtDisOK/cs+rpw2VljS03a7EayrnF0aHKR0zYutqNcEAtP8P
 v3z83katn3auoL8G0vXb8ykK83lY5ODOjRh4P4+p+AFS1n/Hs2upnALnuhYZLBvqN0py
 4u6W+XgtqQnw994uyovPsCJFFGhxnGIXlCoarmGCbewPKK3XtKXW7a3qm+4luQI7S11T
 X17oA03oK/NKJsSJ3xPt2aqhBttUN0iq/XwoVz3AfXSH4M8LP6gRnXnrUXPC3FbjzWFG
 BeMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787829015; x=1788433815;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QKJpKMamDgnPbbj4cbspUVDYpZgutsi4Lligd+Aq2RQ=;
 b=qeodt22t7Ww5zvPiR4gsslNCYxC697yc2B1jkP7kklDYDQdQBpfDNbNkS+LsG9PcWO
 WUN/iiPiLespTIZ5S6nzm/LZwtkYgMB4tO6MUxo0/k6AqSMflImXYAJZpNwlGPZYwt4i
 vbLCuDsV0PxQmXZnlSbBu0aYhN4RfxXE9Z7QASpG2iEYYVCgNQdC2x/tZMmqR6/iBMAc
 evJAmeYatiTIPlIrLsW18/JmoEnizCB3pDd4jMae4uP6OfeyhL55YUtqpgOBlfmwap2T
 ol7BVDKo+iXUivMqsfMYhLnFSNdYKVEHfd2jf6aCfAkPhcNw9llObYRBcyBpobUW9Srr
 eODA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoCWn58imQX2NSgexvyW0WNe/hkW3wVsJ6copBTlToG+MS7yjDAffCCI57mmtt8abn6ZAF6JNjtK2yN@nongnu.org
X-Gm-Message-State: AFuF++nSqbgvtvkMp2M4sb74iSO89WgAQg4lVx2xHUU+qpiW55X7B70T
 RxxrzPA/qvsgm1q4d/Tt0U0lxm3hTdLlVheaTquq+Mh+prCwinCOfozAZK2bNJeJ4NBKsE7pmLb
 G+eES1sThs5Mt1fuAsnTWJHi06LQ5FW/qdW1y9eDhnv/ciB/ooagdreb37g==
X-Gm-Gg: AR+sD12Rl4tbeZCCZobnv3bxMReBA8HX2bTLU618ufwusKoX8w2Yb1E3jXoT+j6aehJ
 3mizSuzz+EGB2h8OvWtbjbScJK4BazxF8iN+CZRGbkTW6YqDg9f5aguJD0LVe1G4J6xk6u6cjTr
 Hj6ZnoCeYSMVI4OWqep31m9kkynypXM4MbrN6lzItKsL9Xkp4qpCE2LBvRtGrpvqL6aNHUNilAa
 GBTEbdS0i5QTaGQCtj2ufUDR8wF32y0p9Uh2fhmdr41NzwIgt2CkhVc6d+tjwLg2Lq0YPX07d1z
 WRNVkiLVrnmEU8ppZfCChT1WszVC6S2R7pp+vjOXUegtpV+y3urpJoo3PODA6Nwk/GoSOCySIOa
 +CrqXygqHaRZ+j9CVTnMj+yfLx94pUJr+CLXI
X-Received: by 2002:a05:622a:1451:b0:52e:2d19:b27f with SMTP id
 d75a77b69052e-52e423463ecmr133648851cf.19.1787829015194; 
 Thu, 27 Aug 2026 04:10:15 -0700 (PDT)
X-Received: by 2002:a05:622a:1451:b0:52e:2d19:b27f with SMTP id
 d75a77b69052e-52e423463ecmr133644541cf.19.1787829012205; 
 Thu, 27 Aug 2026 04:10:12 -0700 (PDT)
Received: from [192.168.68.100] ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52e42766527sm34887091cf.27.2026.08.27.04.10.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 04:10:11 -0700 (PDT)
Message-ID: <26d23039-25df-4f20-88f9-75d7c85d1be1@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 08:10:07 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/16] hw/intc/sifive_plic: Take a MemoryRegion for the
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
 <20260826220528.54516-6-joel@jms.id.au>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260826220528.54516-6-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: vzCIzZl3e_4uKridJMy98gwUMl0jpfL3
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA5MiBTYWx0ZWRfXw+1tDhRVyGTm
 T8Qg7tAoof9LaFSuixWOxIabPJLO20/AUql6STUrckEthacIFnyyAbzhzh/0+mJwu0eTr4E3h+D
 09W1gzYT7qjb1GGvuUZ3a/GHj/iyWm8=
X-Proofpoint-GUID: vzCIzZl3e_4uKridJMy98gwUMl0jpfL3
X-Authority-Analysis: v=2.4 cv=SoCgLvO0 c=1 sm=1 tr=0 ts=6a901b18 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=WcYdPXTqmZdUZr-lOIQA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA5MiBTYWx0ZWRfXwNws5dOqqsBS
 fhqrs5Y8vc8yCfytLS4MMpWH2Bd/cdD5XZEy7FpukyYHlwRoz4YnPyLUQKj4siZAvzSrLyFNbjY
 JNx7CoiKVtlNciZRuxCHa4FiLAVC3Xj49UPslWEkR6+VT74idDkar6iPzxeHYUhxs3BW4wAhgzl
 VwxmrAfeUhH7o++bVYjpKeRawPul+xnuOAPg7Y8ZAvhFoJL4SLoaP6eaLhS7l4V9Or/etbSntsK
 muMzZ6eP1gC7GUJEGh/jbTBshfyVbI12X6xo6lpBjIH57qUttV9IvOvnQnRLBq0LP5PEN3yGpND
 vd7FBvoraRkF0KnrTnPApiR33UY67FN/Q0fXrgAxnk4h5S5yqSL6PB9kUNV7ko3Hq2tGEJPfWWT
 yLZbXYH4TVZOlk1OwL+/B9LNysZCSJqjqutM4zVPgbl3J00kb+wfb97v2cDT/nuxFTIgBgbA4TP
 o0c/SuVes76I3gRzh5w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270092
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
> sifive_plic_create() maps the device it creates into system_memory,
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

>   include/hw/intc/sifive_plic.h | 3 ++-
>   hw/intc/sifive_plic.c         | 6 ++++--
>   hw/riscv/k230.c               | 3 ++-
>   hw/riscv/microchip_pfsoc.c    | 3 ++-
>   hw/riscv/shakti_c.c           | 3 ++-
>   hw/riscv/sifive_e.c           | 2 +-
>   hw/riscv/sifive_u.c           | 3 ++-
>   hw/riscv/virt.c               | 1 +
>   8 files changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/include/hw/intc/sifive_plic.h b/include/hw/intc/sifive_plic.h
> index 32973dbf281e..13fe6b2909d2 100644
> --- a/include/hw/intc/sifive_plic.h
> +++ b/include/hw/intc/sifive_plic.h
> @@ -76,7 +76,8 @@ struct SiFivePLICState {
>       qemu_irq *s_external_irqs;
>   };
>   
> -DeviceState *sifive_plic_create(hwaddr addr, char *hart_config,
> +DeviceState *sifive_plic_create(MemoryRegion *mr, hwaddr addr,
> +    char *hart_config,
>       uint32_t num_harts,
>       uint32_t hartid_base, uint32_t num_sources,
>       uint32_t num_priorities, uint32_t priority_base,
> diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
> index 9c84ff06a9fd..b6472443276b 100644
> --- a/hw/intc/sifive_plic.c
> +++ b/hw/intc/sifive_plic.c
> @@ -473,7 +473,8 @@ type_init(sifive_plic_register_types)
>   /*
>    * Create PLIC device.
>    */
> -DeviceState *sifive_plic_create(hwaddr addr, char *hart_config,
> +DeviceState *sifive_plic_create(MemoryRegion *mr, hwaddr addr,
> +    char *hart_config,
>       uint32_t num_harts,
>       uint32_t hartid_base, uint32_t num_sources,
>       uint32_t num_priorities, uint32_t priority_base,
> @@ -499,7 +500,8 @@ DeviceState *sifive_plic_create(hwaddr addr, char *hart_config,
>       qdev_prop_set_uint32(dev, "context-stride", context_stride);
>       qdev_prop_set_uint32(dev, "aperture-size", aperture_size);
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> -    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
> +    memory_region_add_subregion(mr, addr,
> +        sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
>   
>       plic = SIFIVE_PLIC(dev);
>   
> diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
> index 1ef4260c5391..6b0f0453c80b 100644
> --- a/hw/riscv/k230.c
> +++ b/hw/riscv/k230.c
> @@ -134,7 +134,8 @@ static DeviceState *k230_create_plic(int base_hartid, int hartid_count)
>       plic_hart_config = riscv_plic_hart_config_string(hartid_count);
>   
>       /* Per-socket PLIC */
> -    return sifive_plic_create(memmap[K230_DEV_PLIC].base,
> +    return sifive_plic_create(get_system_memory(),
> +                              memmap[K230_DEV_PLIC].base,
>                                 plic_hart_config, hartid_count, base_hartid,
>                                 K230_PLIC_NUM_SOURCES,
>                                 K230_PLIC_NUM_PRIORITIES,
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index a6026776d4de..1f6d9f5ae1ed 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -282,7 +282,8 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
>       plic_hart_config = riscv_plic_hart_config_string(ms->smp.cpus);
>   
>       /* PLIC */
> -    s->plic = sifive_plic_create(memmap[MICROCHIP_PFSOC_PLIC].base,
> +    s->plic = sifive_plic_create(system_memory,
> +        memmap[MICROCHIP_PFSOC_PLIC].base,
>           plic_hart_config, ms->smp.cpus, 0,
>           MICROCHIP_PFSOC_PLIC_NUM_SOURCES,
>           MICROCHIP_PFSOC_PLIC_NUM_PRIORITIES,
> diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
> index 86ff8f8fcaab..62052bf7c61e 100644
> --- a/hw/riscv/shakti_c.c
> +++ b/hw/riscv/shakti_c.c
> @@ -115,7 +115,8 @@ static void shakti_c_soc_state_realize(DeviceState *dev, Error **errp)
>   
>       sysbus_realize(SYS_BUS_DEVICE(&sss->cpus), &error_abort);
>   
> -    sss->plic = sifive_plic_create(shakti_c_memmap[SHAKTI_C_PLIC].base,
> +    sss->plic = sifive_plic_create(system_memory,
> +        shakti_c_memmap[SHAKTI_C_PLIC].base,
>           (char *)SHAKTI_C_PLIC_HART_CONFIG, ms->smp.cpus, 0,
>           SHAKTI_C_PLIC_NUM_SOURCES,
>           SHAKTI_C_PLIC_NUM_PRIORITIES,
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index 0ea444f43bc5..81d7995ddcfb 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -214,7 +214,7 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
>           memmap[SIFIVE_E_DEV_MROM].base, &s->mask_rom);
>   
>       /* MMIO */
> -    s->plic = sifive_plic_create(memmap[SIFIVE_E_DEV_PLIC].base,
> +    s->plic = sifive_plic_create(sys_mem, memmap[SIFIVE_E_DEV_PLIC].base,
>           (char *)SIFIVE_E_PLIC_HART_CONFIG, ms->smp.cpus, 0,
>           SIFIVE_E_PLIC_NUM_SOURCES,
>           SIFIVE_E_PLIC_NUM_PRIORITIES,
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 58b4744318f8..1cc6be744f08 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -772,7 +772,8 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
>       plic_hart_config = riscv_plic_hart_config_string(ms->smp.cpus);
>   
>       /* MMIO */
> -    s->plic = sifive_plic_create(memmap[SIFIVE_U_DEV_PLIC].base,
> +    s->plic = sifive_plic_create(system_memory,
> +        memmap[SIFIVE_U_DEV_PLIC].base,
>           plic_hart_config, ms->smp.cpus, 0,
>           SIFIVE_U_PLIC_NUM_SOURCES,
>           SIFIVE_U_PLIC_NUM_PRIORITIES,
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 6e4b39315aaa..6d061a80ca9e 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1138,6 +1138,7 @@ static DeviceState *virt_create_plic(const MemMapEntry *memmap, int socket,
>   
>       /* Per-socket PLIC */
>       return sifive_plic_create(
> +             get_system_memory(),
>                memmap[VIRT_PLIC].base + socket * memmap[VIRT_PLIC].size,
>                plic_hart_config, hart_count, base_hartid,
>                VIRT_IRQCHIP_NUM_SOURCES,


