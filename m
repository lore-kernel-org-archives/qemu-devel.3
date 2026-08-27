Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF25C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 11:48:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzYaS-0002Py-79; Thu, 27 Aug 2026 07:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzYaQ-0002PO-9Q
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 07:48:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzYaN-0002l9-Hz
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 07:48:01 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67R9Gpkc470858
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 11:47:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HDk+XIK2HdVYOwQgV4MTKp+dfnJDvwIAvMZmzSlt9Ac=; b=LSIUFDJAiHEN6DQa
 nSUOQKg+OlC6/v02caRFb5V3RfmJuLydt8csbRudsMqxiPWVHPMBy43E+3mWe+S+
 MbtwBqfkpqlgUNU9r6YIu2Q02OKllRCtQHNcNed32dDNXLoM7mDh4uqik/b38Xig
 N8ogxjcoFdNwuq3OzMv2emfntSwif/v/lU5e1G7R7nvalxVv0HclhQriARrgaagY
 zT5mryyapfPXHiMbXwP2fWgLUyKVqvB3wVJIv5xPmiKl14X/O68DroO9Vl+him3Z
 5UuXG7xrp2S/cIUXs3Fl+FF9hncAt3+f9FbE8XJi38+fiUvx+u22vlZRKNzER/fS
 JPliuQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga8m5jjmr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 11:47:57 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-90cddf4f59eso2087856d6.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 04:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787831276; x=1788436076; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HDk+XIK2HdVYOwQgV4MTKp+dfnJDvwIAvMZmzSlt9Ac=;
 b=DoHFf6+7GQI/AE0Zd4kx+P85XGgd9FIETKJEwKCKc6yO2qEImJ8nvYR8pRza/aeQYr
 CE6bnbJz/DMqmCI4dpo0nP7oBm2mcnnhyXHPk27HFUOzFMhmR5DyMDOlXLcfkaDbwirA
 7fWxYqEPwaaMrUQClvdIeAIc/RQUv2sSTb2wwjT8jc/z7ZiSeG+xfdsYM6g8nk7hE/Mr
 udh13z4jALasTECFHgocskAW3Kv2sCHPMs+r7I5qbFSOtYFcAFQ6MuKz8nz3WbOS+fiz
 usgGEp0SDLZby92FADZxvhUfrRL6WQY5izVoiKin2JKrkxvPQUZQ+Lh7n/Z1RwlzzkJa
 yCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787831276; x=1788436076;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HDk+XIK2HdVYOwQgV4MTKp+dfnJDvwIAvMZmzSlt9Ac=;
 b=Ecm6MWQkC5QHdr4eTxdCpPl7nFaA0kxjZE6s/fj2apfWI2w78wIfFQyrthTBeuBg6y
 G2fSpUuPG9ztERJUv/V/E/dJ3MBb72k66Fp+tR2XdBpWVMuwMU3EfxcFFogom9ue7aGe
 buXE0SDHxs8lSHdD8CcXX2tIgYs6SMZXNXULkB6AoHtUJsm/f7G2zDgq4eAQcm7GZF0S
 pDxg9aqDcl1he98Jy44em3tGuihtUEQcKxpng+y3ZHzH6GokRUDKHeECe75YBNbO7+kY
 Dg6WvF+ZiGL1tx6fnHOTSCiXEg2ziz2KBalPuYd0lO2hqgHzQOI/UqqCowIHISM/XGth
 zSDA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrognZbcFjlDG/iozHwuFaRJt+xQCJniNhJZk8+KjkZFYstk2T+6Hg4DAzK52EfCEn9NSS/NXE/hnid@nongnu.org
X-Gm-Message-State: AFuF++kBDUAU0ICiEthn/2uFmcFSPjGqFhECqHh+Unrj8FLIK8QbKbuV
 mj34YyOUKNlYUq6oZwr7yH8dzOze+NB6y3vWM7jfOZQebqqAjSsmplNQincFhP9kyC/PPDtdfah
 ssu5MDIPInFBVV3Pf9HcqevrMVY2MFT8RXxHsisgEyDVZLqdtc1gnc0jWAA==
X-Gm-Gg: AR+sD10shNs0CXaBf78tUIkBPBf2QnpxsFV6cdpVwDOPlqclltyCaam6b3715UITeuJ
 6n7lxVX6XeZjdtg2g65itSfOseAQBXaMFPUtIGed/pnBOSPk9/sl6Ic3EwwXr+mjHDBgdhg5VPi
 hXJntfa5fCzwfOjdD4vNDilJV5FDPRZSRIFVbTIs0qZ3vEnfTFYzRfXjciR+llt3bh0VUwPyEbf
 6SMCD2Gfewo+PVXTyBCb2zg3CZyWiGzDkCYlZQmidxZDrH/U+mjIue0mxJAns5urqpJYKjCorbi
 CdRI32h/0mx+DygKheNtAGECuwpx+eLT7OIn1OiksUoXMAL6W9DQ90lBYa8ClEPRJ8Q10eXY3XE
 ZqswZIrxjvDaYlJt9jzJ4Qd2ejVkxUNjwpyEC
X-Received: by 2002:a05:6214:20aa:b0:907:52e3:1c63 with SMTP id
 6a1803df08f44-90cc78eb5e4mr147151536d6.20.1787831276292; 
 Thu, 27 Aug 2026 04:47:56 -0700 (PDT)
X-Received: by 2002:a05:6214:20aa:b0:907:52e3:1c63 with SMTP id
 6a1803df08f44-90cc78eb5e4mr147151056d6.20.1787831275828; 
 Thu, 27 Aug 2026 04:47:55 -0700 (PDT)
Received: from [192.168.68.100] ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90cd73fc984sm14752106d6.39.2026.08.27.04.47.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 04:47:55 -0700 (PDT)
Message-ID: <86984aeb-a2d7-4640-bbec-ed510174df34@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 08:47:51 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/16] hw/riscv/atlantis: Rework device tree creation
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
 <20260826221154.54577-2-joel@jms.id.au>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260826221154.54577-2-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: f-2CSHQyt34v_M7KtbJvt4JDfd2BIsbn
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA5OCBTYWx0ZWRfX1ZqeAxccHm1p
 0ecHI1Ffxn/wB6n5kzvJh+FkTZnjXyAn/mUd2FMZ8FYWCHJLq2/SDbB2aIBx/1cpoWHY43YbZz2
 X3GWHbjbJ1ycVXWmev8VhbI7woKtEDU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA5OCBTYWx0ZWRfX7jrR4NzOSGFp
 DiskrBAEdaIJeLXJ+x009kCzEFibF6IjqYcus+LeFiaLZiBtWrzycFzWOVF2YpukXeXGtkphloY
 JduwBy662ok19z++yaVKsUvI3R3Iy6fdGNGGonNvYgI88ZvBZRp9geEMGRFSrO4nXUClnIFY6QF
 CKCxwROt8WuldV31oGGuFqs6XNPDdB+mYALjzMYTpsAYGn3DBv2qiYyUz7r9fKiOFpP0IaCTdBq
 7apTaaNWgVzqGwk1Q6/nhWGcFuQQETKbSNSynuWP4Me7BT520C9FWAIwyZ7oajRl+jknj6c/RZs
 yKhRU9OgijHN1DXAO2BG+UuwnhUskGCAPR5XYJV5kd0SDuCLmHbq5FfZkSCg+UzVEeUBizw/UVr
 dh5LXiOthtZ1K5wxKEgH0SKuSS1eZLrol+8DwVSebMi267c+XUoPoUUTk/gVdOClTC1qBCchFvz
 aVgUiOJDrpj51vWx6Tg==
X-Proofpoint-GUID: f-2CSHQyt34v_M7KtbJvt4JDfd2BIsbn
X-Authority-Analysis: v=2.4 cv=SomgLvO0 c=1 sm=1 tr=0 ts=6a9023ed cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=XQfE3cC_Y_RKJagnLmUA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270098
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



On 8/26/2026 7:11 PM, Joel Stanley wrote:
> Remove the direct use of MachineState from the device tree creation to
> allow separation between the SoC (TTAtlantisState) and the QEMU
> MachineState.
> 
> Fix this for the device tree pointer by passing it directly to the
> functions that use it, instead of casting the TTAtlantisState to a
> MachineState.
> 
> MachineState::smp.cpus is replaced with TTAtlantisState::cpus.num_harts,
> as these are equivalent after tt_atlantis_machine_init.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/riscv/tt_atlantis.c | 51 +++++++++++++++++++-----------------------
>   1 file changed, 23 insertions(+), 28 deletions(-)
> 
> diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
> index 35b3be072a06..c471c7cebf12 100644
> --- a/hw/riscv/tt_atlantis.c
> +++ b/hw/riscv/tt_atlantis.c
> @@ -80,9 +80,8 @@ static uint32_t next_phandle(void)
>       return fdt_phandle++;
>   }
>   
> -static void create_fdt_memory(TTAtlantisState *s)
> +static void create_fdt_memory(void *fdt, TTAtlantisState *s)
>   {
> -    void *fdt = MACHINE(s)->fdt;
>       hwaddr size_lo = MACHINE(s)->ram_size;
>       hwaddr size_hi = 0;
>   
> @@ -104,9 +103,9 @@ static void create_fdt_memory(TTAtlantisState *s)
>       }
>   }
>   
> -static void create_fdt_aclint(TTAtlantisState *s, uint32_t *intc_phandles)
> +static void create_fdt_aclint(void *fdt, TTAtlantisState *s,
> +                              uint32_t *intc_phandles)
>   {
> -    void *fdt = MACHINE(s)->fdt;
>       g_autofree char *name = NULL;
>       g_autofree uint32_t *aclint_mtimer_cells = NULL;
>       uint32_t aclint_cells_size;
> @@ -206,10 +205,9 @@ static void create_fdt_one_aplic(void *fdt,
>       qemu_fdt_setprop_cell(fdt, name, "phandle", aplic_phandle);
>   }
>   
> -static void create_fdt_pmu(TTAtlantisState *s)
> +static void create_fdt_pmu(void *fdt, TTAtlantisState *s)
>   {
>       char pmu_name[] = "/pmu";
> -    void *fdt = MACHINE(s)->fdt;
>       RISCVCPU *hart = &s->cpus.harts[0];
>   
>       qemu_fdt_add_subnode(fdt, pmu_name);
> @@ -217,32 +215,29 @@ static void create_fdt_pmu(TTAtlantisState *s)
>       riscv_pmu_generate_fdt_node(fdt, hart->pmu_avail_ctrs, pmu_name);
>   }
>   
> -static void create_fdt_cpu(TTAtlantisState *s, const MemMapEntry *memmap,
> +static void create_fdt_cpu(void *fdt, TTAtlantisState *s,
>                              uint32_t aplic_s_phandle,
>                              uint32_t imsic_s_phandle)
>   {
> -    MachineState *ms = MACHINE(s);
> -    void *fdt = MACHINE(s)->fdt;
> -    g_autofree uint32_t *intc_phandles = g_new0(uint32_t, ms->smp.cpus);
> +    g_autofree uint32_t *intc_phandles = g_new0(uint32_t, s->cpus.num_harts);
> +    int num_harts = s->cpus.num_harts;
>   
>       fdt_create_cpu_socket_subnode(fdt, TT_ACLINT_TIMEBASE_FREQ);
>   
> -    create_fdt_socket_cpus(fdt, s->cpus.harts, 0, s->cpus.num_harts,
> +    create_fdt_socket_cpus(fdt, s->cpus.harts, 0, num_harts,
>                              s->cpus.hartid_base, &fdt_phandle, intc_phandles,
>                              false, false);
>   
> -    create_fdt_memory(s);
> -
> -    create_fdt_aclint(s, intc_phandles);
> +    create_fdt_aclint(fdt, s, intc_phandles);
>   
>       /* M-level IMSIC node */
>       uint32_t msi_m_phandle = next_phandle();
> -    create_fdt_one_imsic(fdt, &s->memmap[TT_ATL_MIMSIC], ms->smp.cpus,
> +    create_fdt_one_imsic(fdt, &s->memmap[TT_ATL_MIMSIC], num_harts,
>                            intc_phandles, msi_m_phandle,
>                            IRQ_M_EXT, TT_IMSIC_GUEST_BITS);
>   
>       /* S-level IMSIC node */
> -    create_fdt_one_imsic(fdt, &s->memmap[TT_ATL_SIMSIC], ms->smp.cpus,
> +    create_fdt_one_imsic(fdt, &s->memmap[TT_ATL_SIMSIC], num_harts,
>                            intc_phandles, imsic_s_phandle,
>                            IRQ_S_EXT, TT_IMSIC_GUEST_BITS);
>   
> @@ -252,13 +247,13 @@ static void create_fdt_cpu(TTAtlantisState *s, const MemMapEntry *memmap,
>       create_fdt_one_aplic(fdt, &s->memmap[TT_ATL_MAPLIC],
>                            msi_m_phandle, intc_phandles,
>                            aplic_m_phandle, aplic_s_phandle,
> -                         IRQ_M_EXT, s->cpus.num_harts);
> +                         IRQ_M_EXT, num_harts);
>   
>       /* S-level APLIC node */
>       create_fdt_one_aplic(fdt, &s->memmap[TT_ATL_SAPLIC],
>                            imsic_s_phandle, intc_phandles,
>                            aplic_s_phandle, 0,
> -                         IRQ_S_EXT, s->cpus.num_harts);
> +                         IRQ_S_EXT, num_harts);
>   }
>   
>   static void create_fdt_uart(void *fdt, const MemMapEntry *mem, int irq,
> @@ -317,10 +312,9 @@ static void create_fdt_i2c(void *fdt, const MemMapEntry *mem, uint32_t irq,
>       qemu_fdt_setprop_cell(fdt, name, "#size-cells", 0);
>   }
>   
> -static void create_fdt_i2c_device(TTAtlantisState *s, int bus,
> +static void create_fdt_i2c_device(void *fdt, TTAtlantisState *s, int bus,
>                                     const char *compat, int addr)
>   {
> -    void *fdt = MACHINE(s)->fdt;
>       hwaddr base = s->memmap[TT_ATL_I2C0 + bus].base;
>       g_autofree char *name = g_strdup_printf("/soc/i2c@%"HWADDR_PRIX"/sensor@%x",
>                                               base, addr);
> @@ -330,14 +324,15 @@ static void create_fdt_i2c_device(TTAtlantisState *s, int bus,
>       qemu_fdt_setprop_cell(fdt, name, "reg", addr);
>   }
>   
> -static void finalize_fdt(TTAtlantisState *s)
> +static void finalize_fdt(void *fdt, TTAtlantisState *s)
>   {
>       uint32_t aplic_s_phandle = next_phandle();
>       uint32_t imsic_s_phandle = next_phandle();
>       uint32_t periph_clk_phandle = next_phandle();
> -    void *fdt = MACHINE(s)->fdt;
>   
> -    create_fdt_cpu(s, s->memmap, aplic_s_phandle, imsic_s_phandle);
> +    create_fdt_cpu(fdt, s, aplic_s_phandle, imsic_s_phandle);
> +
> +    create_fdt_memory(fdt, s);
>   
>       /*
>        * We want to do this, but the Linux aplic driver was broken before v6.16
> @@ -359,8 +354,8 @@ static void finalize_fdt(TTAtlantisState *s)
>       }
>   
>       /* I2C peripherals: qemu specific */
> -    create_fdt_i2c_device(s, 0, "dallas,ds1338", 0x6f);
> -    create_fdt_i2c_device(s, 4, "ti,tmp105", 0x48);
> +    create_fdt_i2c_device(fdt, s, 0, "dallas,ds1338", 0x6f);
> +    create_fdt_i2c_device(fdt, s, 4, "ti,tmp105", 0x48);
>   }
>   
>   static void create_fdt(TTAtlantisState *s)
> @@ -377,7 +372,7 @@ static void create_fdt(TTAtlantisState *s)
>   
>       qemu_fdt_add_subnode(ms->fdt, "/aliases");
>   
> -    create_fdt_pmu(s);
> +    create_fdt_pmu(ms->fdt, s);
>   }
>   
>   static void load_fdt(TTAtlantisState *s)
> @@ -408,7 +403,7 @@ static void load_fdt(TTAtlantisState *s)
>           g_strfreev(node_path);
>       }
>   
> -    create_fdt_memory(s);
> +    create_fdt_memory(ms->fdt, s);
>   }
>   
>   static void mmio_map_unimplemented(MemoryRegion *memory, SysBusDevice *dev,
> @@ -439,7 +434,7 @@ static void tt_atlantis_machine_done(Notifier *notifier, void *data)
>        * dynamic sysbus devices. Our FDT needs to be finalized.
>        */
>       if (machine->dtb == NULL) {
> -        finalize_fdt(s);
> +        finalize_fdt(machine->fdt, s);
>       }
>   
>       mem_size = machine->ram_size;


