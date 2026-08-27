Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B404FC61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 11:30:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzYIR-0007Ze-Rp; Thu, 27 Aug 2026 07:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzYIQ-0007ZI-Qi
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 07:29:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzYIO-0000V2-L8
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 07:29:26 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67R9HsnA3977959
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 11:29:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qcYoCs+KKKit7J0t52okbZmYmgrgsm0vYIFGzH/F4ro=; b=U0ddnhA+kCxJD4Km
 MedTQdzYAmBEi9p9/PcTNtgWcR12KOWCmZm8MHo9lk4k4vW5/lMhbrKlnlRDmnQf
 j3QqEaDxZyS9VwrTjg/DHBtckWVt3VODbLqm5e/f1jIhOUlPVCmsyloYZKzbrtLd
 ZV9i4/R4AyMSaPTFwPdjEOwiIvlXOAOxSjZsvC6rUIS6sASoJ9DuD9CgzbfANz5G
 mZ5Fkt9L+z9lNGZlXv9DUlbEa2f2kivFnibuZ45qxSTHQjDJ2M3wYwXfAqEUeexL
 9VI+LLi5SiBlIrGn1aPVWhrbjB3jmoUZDoQ7Ku6G2kRPk86HWMMiXg660+33ASwB
 utWTDg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga4egkh4r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 11:29:22 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93909014c85so43970785a.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 04:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787830162; x=1788434962; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qcYoCs+KKKit7J0t52okbZmYmgrgsm0vYIFGzH/F4ro=;
 b=a7cHXVVvIkegzAdlGpYyCgizU8K/r23fOAbZwCePGhIQFYH2iV9isb65hpzJkb4NAa
 ZxExgm1pALa6hlXZTyqYisdfXtWxGqpOoS0R2faJokK98f+vTkGt4ZsmnFVb5FZmUYd9
 SVovjyC1fKJko63j4/l9y05EewnbqsOhh4A7D90qir0zH44Xq5TnAWQvuyISDIlmOb+D
 719PlZrlKE38WwO3Tj+gA+TJUx1P70rn1Bm1EosdzJkaRFINf9/FkGkdWVSO1jF2RxBU
 ghsTrXjTAl2kX1VyzB7V9KrFQvOMXLp3j7csdQnhz30WloYSSfsrf1tBDoS/eFypW6lX
 Xe4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787830162; x=1788434962;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qcYoCs+KKKit7J0t52okbZmYmgrgsm0vYIFGzH/F4ro=;
 b=LJLsb9ZxDIjsfv1XjLHDW9R6UXhPBlid8TRBVAjtd9wzGjGzBp152tMx1NFE+xbquq
 C/Cpx1xbD164+MtQ99R4lQGdzSwuE0K3eileNCNGF8sSl2X1kTzl3H2rucnbZD3kXMSV
 TPC/+H6npKiFdoydh6T+FrAKgTZnZuCFWi3ufpFd522i8AhdAEMXDMHOngeeT7p65B1U
 cdMtrZLU12vrZwRFhVw/NDviIvEbH9ui/GZjZUCpJUupBXOEollwlpay676Uc2fna40i
 +Ioibr3R4Hv2tzTr9Iu3Gbh592wHeFbWK22jhsKuOgv4rpMc6smZQ0wnU0gB8Uorl2d/
 ihHg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoSUvZofSCPBWTTtIHFBZjConxHjg6c2bHi0gyMbz3cWuy4SgaKrKg4XG9e0KFVJEY1o7r2YawoB6w6@nongnu.org
X-Gm-Message-State: AFuF++mh1PqByypXLHh2IIoNcezf1NsHMdgYQvcAAhHrA+QrRDksfnea
 u4qL/h3BAyStcCADGwgAimQnUYbDymsQFwgzU+vcuJsXOXCcFL5j0ZbQxTTiqOj2XdVyt3s49CG
 e4Ghj/Wzlb1+vjvjYZ6nV5DSz3zBdIhJodJcpOhDnttE6XoTu0XfPDn5BbQ==
X-Gm-Gg: AR+sD13SABm/L9HbIImTxbtN2ioWCAhs9aC6WZxfK+zl9/isMWTvhzTkHfpzgUKAn+7
 fOKg5xUK+K1eY+U0Qg2mPsSPzReWgsrREQDH2y412XaDlqe2zMoHheJImK5uMutoBie6jj86R10
 /Q344C1Sp4EKW21R4xqPdsrBl6y8K1vXUZyqd/5K+aME5K6hPgIEWD/2A0Oq4FwZxkhv0Oji7vo
 SJtSoplCI680BwIju2zXCP+Ol7KBOTjDrhjR6+NnsY9VLcvnfjui4WsSok5B4VSDj6JQTorxMS9
 oO8X3XtS5fcU66FOR27Gub/imUzpqPe/zKLduENCbhcm+tFuV5+HVaLXKYxhLw2q/c5VQ3L8n/f
 2GFvJbLbZrYaVX1KKkF+6P24+49u7f9wGKl3U
X-Received: by 2002:a05:620a:370e:b0:938:fd23:1e29 with SMTP id
 af79cd13be357-938fd232669mr776721485a.4.1787830162206; 
 Thu, 27 Aug 2026 04:29:22 -0700 (PDT)
X-Received: by 2002:a05:620a:370e:b0:938:fd23:1e29 with SMTP id
 af79cd13be357-938fd232669mr776717085a.4.1787830161765; 
 Thu, 27 Aug 2026 04:29:21 -0700 (PDT)
Received: from [192.168.68.100] ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9377e616605sm429794385a.29.2026.08.27.04.29.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 04:29:21 -0700 (PDT)
Message-ID: <db0370ab-83d2-4c37-8530-76a317800c0b@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 08:29:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/16] hw/riscv/atlantis: Rename hart array 'soc' to 'cpus'
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
 <20260826220528.54516-10-joel@jms.id.au>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260826220528.54516-10-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: z1xbyFTj0VKOI3grY1z-NcTW3-Y3qmah
X-Proofpoint-ORIG-GUID: z1xbyFTj0VKOI3grY1z-NcTW3-Y3qmah
X-Authority-Analysis: v=2.4 cv=DsRmPm/+ c=1 sm=1 tr=0 ts=6a901f92 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=S04PF1N2CULH3AedksMA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA5NSBTYWx0ZWRfX+DseqglZVLS+
 nL5NtV/AAkPn7eBaY6Bg/jCsK8DshQVy87RxucwVr5DthqkLWy2r2hHNXkDoKsoIMElBlQtIJ+D
 X/4Cz00LVG/PU12S9txY33A7zP9Tcn1FI5dAR7L+CT6UeTvRPCA6zuWXreWbxnEaB4UcBKSXHJb
 AxR9C+ZL1CCESkCnNoc1ARVkCvCitst/7sux9maEEA8KJMdIfD+qITzMXwZ6Nlx1h2isAHARYkS
 vcOoM2wIG8Xx5XZgi5sj8gmHs7jICTqrF0QbMokhsn7OSjuQ/eBgnzs0ZswkJxqFwlTFn0hFWzP
 x3w0lwG89mRezP7vCCM1yzHtON1d3qIS4OGjDv+YTY6SS/tWBFzjOAgWezq4Ll+Q3buvR17lg9F
 hPNEDNz58DJX98vETs/t/x0yGx+3s5+nZLCztK74+KfRK8QuY6Ee3zpZNEjIVkjNHFM6wZblxKI
 r8YlDmBjv0cQ5dNF74g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA5NSBTYWx0ZWRfXxfcnGhTKRc2e
 1yqwzu3tVeuKU9fXi8j9eEDYCWUmzWbPuxrEfEf0rfuMtBA7umKcNXE3JLWRvWIO1WJPXsItIup
 OAJV3OZc8zoGfgVKwYZv9zip+FGhRuw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270095
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
> The RISCVHartArrayState member is named soc, but it's an array of cpus,
> not the entire SoC. Use cpus instead as an accurate description of the
> hart array.

For 'virt' and other boards that support more than one socket I always wanted
to rename "soc" to "sockets".  E.g. for virt we have (include/hw/riscv/virt.h):

RISCVHartArrayState soc[VIRT_SOCKETS_MAX];

I always wanted to rename it to:

RISCVHartArrayState sockets[VIRT_SOCKETS_MAX];

And throughout the code we would do "s->socket[i].num_harts" instead of
"s->soc[i].num_harts", which is more idiomatic IMO.

If you want to keep semantics with the other boards you could rename it to
"socket", a.k.a a single array of harts/cpus.  You would have this:

 > +    aclint_mtimer_cells = g_new0(uint32_t, s->socket.num_harts * 2);

This would also make it clearer that tt_atlantis has a single socket.

Note that all that I said above is stylistic/taste.  In the end "cpus" is
a closer equivalent than "soc", so feel free to go ahead:


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>   include/hw/riscv/tt_atlantis.h |  2 +-
>   hw/riscv/tt_atlantis.c         | 34 +++++++++++++++++-----------------
>   2 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
> index d0cca3b02424..642490d21743 100644
> --- a/include/hw/riscv/tt_atlantis.h
> +++ b/include/hw/riscv/tt_atlantis.h
> @@ -29,7 +29,7 @@ struct TTAtlantisState {
>       Notifier machine_done;
>       const MemMapEntry *memmap;
>   
> -    RISCVHartArrayState soc;
> +    RISCVHartArrayState cpus;
>       DeviceState *irqchip;
>       DesignWareI2CState i2c[TT_ATL_NUM_I2C];
>       UnimplementedDeviceState uart1;
> diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
> index 127c89be4f60..35b3be072a06 100644
> --- a/hw/riscv/tt_atlantis.c
> +++ b/hw/riscv/tt_atlantis.c
> @@ -112,13 +112,13 @@ static void create_fdt_aclint(TTAtlantisState *s, uint32_t *intc_phandles)
>       uint32_t aclint_cells_size;
>       hwaddr addr;
>   
> -    aclint_mtimer_cells = g_new0(uint32_t, s->soc.num_harts * 2);
> +    aclint_mtimer_cells = g_new0(uint32_t, s->cpus.num_harts * 2);
>   
> -    for (int cpu = 0; cpu < s->soc.num_harts; cpu++) {
> +    for (int cpu = 0; cpu < s->cpus.num_harts; cpu++) {
>           aclint_mtimer_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
>           aclint_mtimer_cells[cpu * 2 + 1] = cpu_to_be32(IRQ_M_TIMER);
>       }
> -    aclint_cells_size = s->soc.num_harts * sizeof(uint32_t) * 2;
> +    aclint_cells_size = s->cpus.num_harts * sizeof(uint32_t) * 2;
>   
>       addr = s->memmap[TT_ATL_ACLINT].base;
>   
> @@ -210,7 +210,7 @@ static void create_fdt_pmu(TTAtlantisState *s)
>   {
>       char pmu_name[] = "/pmu";
>       void *fdt = MACHINE(s)->fdt;
> -    RISCVCPU *hart = &s->soc.harts[0];
> +    RISCVCPU *hart = &s->cpus.harts[0];
>   
>       qemu_fdt_add_subnode(fdt, pmu_name);
>       qemu_fdt_setprop_string(fdt, pmu_name, "compatible", "riscv,pmu");
> @@ -227,8 +227,8 @@ static void create_fdt_cpu(TTAtlantisState *s, const MemMapEntry *memmap,
>   
>       fdt_create_cpu_socket_subnode(fdt, TT_ACLINT_TIMEBASE_FREQ);
>   
> -    create_fdt_socket_cpus(fdt, s->soc.harts, 0, s->soc.num_harts,
> -                           s->soc.hartid_base, &fdt_phandle, intc_phandles,
> +    create_fdt_socket_cpus(fdt, s->cpus.harts, 0, s->cpus.num_harts,
> +                           s->cpus.hartid_base, &fdt_phandle, intc_phandles,
>                              false, false);
>   
>       create_fdt_memory(s);
> @@ -252,13 +252,13 @@ static void create_fdt_cpu(TTAtlantisState *s, const MemMapEntry *memmap,
>       create_fdt_one_aplic(fdt, &s->memmap[TT_ATL_MAPLIC],
>                            msi_m_phandle, intc_phandles,
>                            aplic_m_phandle, aplic_s_phandle,
> -                         IRQ_M_EXT, s->soc.num_harts);
> +                         IRQ_M_EXT, s->cpus.num_harts);
>   
>       /* S-level APLIC node */
>       create_fdt_one_aplic(fdt, &s->memmap[TT_ATL_SAPLIC],
>                            imsic_s_phandle, intc_phandles,
>                            aplic_s_phandle, 0,
> -                         IRQ_S_EXT, s->soc.num_harts);
> +                         IRQ_S_EXT, s->cpus.num_harts);
>   }
>   
>   static void create_fdt_uart(void *fdt, const MemMapEntry *mem, int irq,
> @@ -429,7 +429,7 @@ static void tt_atlantis_machine_done(Notifier *notifier, void *data)
>       hwaddr start_addr = s->memmap[TT_ATL_DDR_LO].base;
>       hwaddr mem_size;
>       target_ulong firmware_end_addr, kernel_start_addr;
> -    const char *firmware_name = riscv_default_firmware_name(&s->soc);
> +    const char *firmware_name = riscv_default_firmware_name(&s->cpus);
>       uint64_t fdt_load_addr;
>       uint64_t kernel_entry;
>       RISCVBootInfo boot_info;
> @@ -446,7 +446,7 @@ static void tt_atlantis_machine_done(Notifier *notifier, void *data)
>       if (mem_size > s->memmap[TT_ATL_DDR_LO].size) {
>           mem_size = s->memmap[TT_ATL_DDR_LO].size;
>       }
> -    riscv_boot_info_init_discontig_mem(&boot_info, &s->soc,
> +    riscv_boot_info_init_discontig_mem(&boot_info, &s->cpus,
>                                          s->memmap[TT_ATL_DDR_LO].base,
>                                          mem_size);
>   
> @@ -476,7 +476,7 @@ static void tt_atlantis_machine_done(Notifier *notifier, void *data)
>       riscv_load_fdt(fdt_load_addr, machine->fdt);
>   
>       /* load the reset vector */
> -    riscv_setup_rom_reset_vec(machine, &s->soc, start_addr,
> +    riscv_setup_rom_reset_vec(machine, &s->cpus, start_addr,
>                                 s->memmap[TT_ATL_BOOTROM].base,
>                                 s->memmap[TT_ATL_BOOTROM].size,
>                                 kernel_entry,
> @@ -496,18 +496,18 @@ static void tt_atlantis_machine_init(MachineState *machine)
>   
>       s->memmap = tt_atlantis_memmap;
>   
> -    object_initialize_child(OBJECT(machine), "soc", &s->soc,
> +    object_initialize_child(OBJECT(machine), "soc", &s->cpus,
>                               TYPE_RISCV_HART_ARRAY);
> -    object_property_set_str(OBJECT(&s->soc), "cpu-type", machine->cpu_type,
> +    object_property_set_str(OBJECT(&s->cpus), "cpu-type", machine->cpu_type,
>                               &error_abort);
> -    object_property_set_int(OBJECT(&s->soc), "hartid-base", 0,
> +    object_property_set_int(OBJECT(&s->cpus), "hartid-base", 0,
>                               &error_abort);
> -    object_property_set_int(OBJECT(&s->soc), "num-harts", hart_count,
> +    object_property_set_int(OBJECT(&s->cpus), "num-harts", hart_count,
>                               &error_abort);
> -    object_property_set_int(OBJECT(&s->soc), "resetvec",
> +    object_property_set_int(OBJECT(&s->cpus), "resetvec",
>                               s->memmap[TT_ATL_BOOTROM].base,
>                               &error_abort);
> -    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
> +    sysbus_realize(SYS_BUS_DEVICE(&s->cpus), &error_fatal);
>   
>       s->irqchip = riscv_create_aia(system_memory,
>                                     true, TT_IMSIC_GUESTS,


