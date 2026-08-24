Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC27C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:43:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyUx3-0000a9-E3; Mon, 24 Aug 2026 09:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wyUx1-0000Yy-BD
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:42:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wyUwy-0004pY-RE
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:42:59 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OCusEA2583528
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 13:42:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fIUvQHKn5dD803IC0DXQ9TIMC+mBHa72mVMHV5/Z07k=; b=aGb/3niwsC8C5F3I
 SQo7LbnzBimoEhQgo2qEv3uG0pXf5jotq4vBLTbDyc3cgM4tByyvfpOsEH0NTVhw
 fN8JyqOKGy+XmDlkjLhV+l4iij3G9nzNCz6Bmh8qQlhyZz5fesRlvz1BtdnRae2E
 47yTqm3VkQcUjcEW3gmFL/33ip0Wx8sp1HVdBSxJYs3SVJkIh+kG49Bg+Q8SHU3i
 ELl3IsVyPFGfX7FsmvHRQ/sdJGo7Le3Yp2BfNcqFZtLNP2o7JsIa3SuU326DIrRf
 p4i1mb5p2keaMR7r+VxBIwbZPq2j44XSLeUiPWhgywGae67YpuL7wHoXN71980vX
 HbAuWQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8hbthmer-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 13:42:54 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1a9764f0so36903061cf.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 06:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787578974; x=1788183774; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fIUvQHKn5dD803IC0DXQ9TIMC+mBHa72mVMHV5/Z07k=;
 b=AfpW4MRsW9PqIj+DUgFyQ1yhIypqvJYyzi00r1bTEIJbgExVUmimmwrdvMJA6p7Hey
 OH0+XroVQz2eef6QAGpFScMJHQnC+LySa2/Ik9Hn5YYNd1SRf9wdX8kYOnVUBQvVOmxe
 K8c4LIEcC53deBIqIZScMnyZyqMmb7t+SUO7/3duyEiTQUMk88yu6VD8gN66h+hTZIWc
 +ag73IrXlpCdihDrX/nlKCZfT0uwDZ9RV/UmTYpNfP84XyrWjKJ8C9lS0Aa+8WiYsgcz
 icw1uQLeVZqhJdYfwmDsZlCtVfS7Ibljxj06LdFZUlG+9hB9Q57vwOqv0lHMPG0CZ5rv
 C0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787578974; x=1788183774;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fIUvQHKn5dD803IC0DXQ9TIMC+mBHa72mVMHV5/Z07k=;
 b=CZPcWSdzYzSdlWBwrwjgZVf04Fzi6TJNMvwsqk9xn7BO+LtkDMsqROUYMkBYDYSZ71
 XfllQtA3IRFutMDM1AZK0K7FhBIXfL8Tt6F0lJwqo3vKejrKL4wXjuX6AVLZJZ9R1yZa
 hUWOdA/9T/dR1nvxekjbJlhJ3jCc+KhsgjIclHErd4fmV555C7hvPYSiSrWOA7gd+kWq
 iQy7Ef3zxDDhlBjPkl3Ln+QOYvCfT1356HnJWJnR0lsyFO7X6IH5dDQmNO0RL3roR+Vy
 RjIE2KvCR7E1ny9qf7csjyBFkugdx8MRIS2GwFUdlMoH/QvD7wg8HoKYh2q6L1d2Muqg
 1EvA==
X-Gm-Message-State: AFuF++muWZ2Ubpo0PeZFiXOjXBMzISVlNAXcfGYd/M7W7YjHh3kPbGuw
 x2f/do6MlDgEBGASON7FCu/6gyRfV14wtVcMzVUeATmTmU7pRFfYuJI6MMNwFfdxjdE2XuE7lZm
 EEhc9AAg188xhM+lTay4W8Rol16H1RxCcHZfcuzIddHDCVBJLQEfzAipv8A==
X-Gm-Gg: AR+sD10GaBPxmPu7+8ZoFVgRAUywsG9MhVBjdRQP0ZzfINhKkt41PkckAbfETagCGfe
 umvI7WKqICl1WaJd3kz2rP5eyeqYNZNRrCBB6zGmK/I5w3Fj1y0zCnJWRWygEEQOQ0Rto281oKY
 iBzDuFNnq7h6RAn19wEs+GvoC0fgbOWxCXSSsxxu44RwJNHfrXrXqivrrLhG2q37KWWxd5RoWuL
 ymYa+/mxJA9QhnLoCEVi8GHwecW4l4Gn2Q/KuKJGfH0POmzIlnn2yXvkzjyzlpwUI1/73bCX6jC
 Eazx6zgOL58aA4J+x76tDv5IjrNMwUk5bZfBa0mDJ2VOy3PvjiEWytSEDGXZdHxqRjJ1N1Ba94e
 C/E1D7ufamQ0F7Ojf650N6Mac8AOZout8EFxx
X-Received: by 2002:a05:622a:4d49:b0:51c:1132:c80d with SMTP id
 d75a77b69052e-52df5a024c9mr291449941cf.28.1787578973774; 
 Mon, 24 Aug 2026 06:42:53 -0700 (PDT)
X-Received: by 2002:a05:622a:4d49:b0:51c:1132:c80d with SMTP id
 d75a77b69052e-52df5a024c9mr291449321cf.28.1787578973284; 
 Mon, 24 Aug 2026 06:42:53 -0700 (PDT)
Received: from [192.168.68.100] ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52e09aae6f4sm48160681cf.16.2026.08.24.06.42.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 06:42:52 -0700 (PDT)
Message-ID: <abd508c4-ddff-4cea-9e5b-a700d572badd@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 10:42:48 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] riscv/virt: Add optional UART1
To: Yanfeng Liu <yfliu2008@qq.com>, qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com,
 pierrick.bouvier@oss.qualcomm.com, sunilvl@ventanamicro.com,
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com
References: <tencent_4EEBFC805F3E59863BEDC38094EF5A109206@qq.com>
 <75d038af-a1a0-460c-9fea-7cca0423a54c@oss.qualcomm.com>
 <tencent_2F7940BF03327177E3876829A8B51724AF07@qq.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <tencent_2F7940BF03327177E3876829A8B51724AF07@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDExNSBTYWx0ZWRfX+JoLMqos0LXA
 ziKfHGRdK1wGnF2d4f4aL3SMsTc6uNy5rT5qmUxWiH3cQihAZYHNgKbDny2Don7K/AEDy55x+cx
 sUvASe4OATsrWsWP2WzHchCf2jkvD/C69kBT6GRb/4esJaqcT2ddNGt+PSCkynnihH3P4glCw6s
 KIqU1F3VmET5SoNwzsqrDbeP4VXxwBRRRg5UVzck16QbLr3qdL2ZGOl3RzeUKSsb5MJHCRQTvN8
 5wc596gveBi702HzjVjyc14InH5q4SECwXzv/c7gRX6JtAJnyMr1fbuGLW5N3i3ykpaOoP8Z67B
 JcY+YF433oleCDKB5t1lE6+sdKaflDQx/xjEN7rMZGsPwdB6hwfbFSOtgmvmQNezcvXGjR70zdb
 k7aD1HbAef3ZvwvjXePbnzXAi2pwfLiZPCjg3qxtTHnyInnMrMgQEKRXhLU/yC7Q3abIaxXkBDr
 5SCTtdVvmCUT17Ju51Q==
X-Authority-Analysis: v=2.4 cv=JL0LdcKb c=1 sm=1 tr=0 ts=6a8c4a5e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=dZbOZ2KzAAAA:8 a=Sv_bN-GAQshgOjlYIWUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDExNSBTYWx0ZWRfX51dv8kCU+mlw
 HVnOS9bTS01lx3kKkSkO+cUN9Ani+rK1f9VzJR0ZUbaepfKxMJ98acOx4Uc1AgcxV26Zj57Lub+
 LoGoAqdbmbANC7+foypZb82tNrV8xiw=
X-Proofpoint-GUID: R8DHxjAwyCC9LxKhqihIyu8zs14RRD26
X-Proofpoint-ORIG-GUID: R8DHxjAwyCC9LxKhqihIyu8zs14RRD26
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240115
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



On 8/24/2026 10:37 AM, Yanfeng Liu wrote:
> On Sun, 2026-08-23 at 18:55 -0300, Daniel Henrique Barboza wrote:
>>
>>
>> On 7/17/2026 11:16 PM, Yanfeng Liu wrote:
>>> This adds optional UART1 to RiscV virt board if required at
>>> runtime to simplify multicore development.
>>
>> Can you please elaborate on the use case?  We can add multiple serial
>> devices already.  E.g. this will add 4 serials:
>>
> I was playing Bao hypervisor and found that having a 2nd NMIO UART can
> ba handy.  Previoously when trying AMP I added 2nd MMIO UART to aid
> debugging.
> 
> Since this happened to me at least twice, I am wondering someone else
> might also need it. Besides many real devices have muitlple UARTs.

And that's fine.  In fact I think this patch is already queued for upstream
so we're going forward with the change.

I was just curious about the second UART mapping being added.  I assume that
this would be required for OpenSBI and etc to recognize both of them since
it'll read via DT.


Thanks,
Daniel



> 
>>
>>
>> $ ./build/qemu-system-riscv64 -M virt --nodefaults \
>>            -serial stdio \
>>            -serial tcp::4444,server,nowait \
>>            -serial pty  \
>>            -serial file:uart4.log \
>>            --nographic
>>
>>
>> The difference here is that the additional serials won't have memory
>> mappings
>> and fdt nodes.
>>
> 
> how these additional UARTs can be used by guests if they dont have
> MMIO?
> 
> 
> Regards,
> Yanfeng
> 
> 
>>
>> Thanks,
>> Daniel
>>
>>>
>>> Note that UART0 remains default serial_hd(0) and it is:
>>>
>>> - the lowest address UART
>>> - first serial in DTB
>>> - behind /aliases/serial0 in DTB
>>> - the /chosen/stdout-path in DTB
>>>
>>> Note that UART1 is placed at different page from UART0 to
>>> support page level isolation.
>>>
>>> Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
>>> ---
>>>    docs/system/riscv/virt.rst |  5 ++++-
>>>    hw/riscv/virt-acpi-build.c | 12 ++++++++----
>>>    hw/riscv/virt.c            | 40 ++++++++++++++++++++++++++++-----
>>> -----
>>>    include/hw/riscv/virt.h    |  3 +++
>>>    4 files changed, 45 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/docs/system/riscv/virt.rst
>>> b/docs/system/riscv/virt.rst
>>> index 60850970ce..45ac63ac77 100644
>>> --- a/docs/system/riscv/virt.rst
>>> +++ b/docs/system/riscv/virt.rst
>>> @@ -16,7 +16,7 @@ The ``virt`` machine supports the following
>>> devices:
>>>    * Core Local Interruptor (CLINT)
>>>    * Platform-Level Interrupt Controller (PLIC)
>>>    * CFI parallel NOR flash memory
>>> -* 1 NS16550 compatible UART
>>> +* Either 1 or 2 NS16550 compatible UARTs
>>>    * 1 Google Goldfish RTC
>>>    * 1 SiFive Test device
>>>    * 8 virtio-mmio transport devices
>>> @@ -27,6 +27,9 @@ The hypervisor extension has been enabled for the
>>> default CPU, so virtual
>>>    machines with hypervisor extension can simply be used without
>>> explicitly
>>>    declaring.
>>>    
>>> +The second UART only exists if a backend is configured explicitly
>>> (e.g.
>>> +with a second `-serial` command line option).
>>> +
>>>    Hardware configuration information
>>>    ----------------------------------
>>>    
>>> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-
>>> build.c
>>> index 413d47d70e..597751c84a 100644
>>> --- a/hw/riscv/virt-acpi-build.c
>>> +++ b/hw/riscv/virt-acpi-build.c
>>> @@ -169,11 +169,11 @@ static void acpi_dsdt_add_plic_aplic(Aml
>>> *scope, uint8_t socket_count,
>>>    
>>>    static void
>>>    acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
>>> -                    uint32_t uart_irq)
>>> +                    uint32_t uart_irq, int uartidx)
>>>    {
>>> -    Aml *dev = aml_device("COM0");
>>> +    Aml *dev = aml_device("COM%d", uartidx);
>>>        aml_append(dev, aml_name_decl("_HID",
>>> aml_string("RSCV0003")));
>>> -    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
>>> +    aml_append(dev, aml_name_decl("_UID", aml_int(uartidx)));
>>>    
>>>        Aml *crs = aml_resource_template();
>>>        aml_append(crs, aml_memory32_fixed(uart_memmap->base,
>>> @@ -479,7 +479,11 @@ static void build_dsdt(GArray *table_data,
>>>                                     memmap[VIRT_APLIC_S].size,
>>> "RSCV0002");
>>>        }
>>>    
>>> -    acpi_dsdt_add_uart(scope, &memmap[VIRT_UART0], UART0_IRQ);
>>> +    acpi_dsdt_add_uart(scope, &memmap[VIRT_UART0], UART0_IRQ, 0);
>>> +    if (s->uart1_present) {
>>> +        acpi_dsdt_add_uart(scope, &memmap[VIRT_UART1], UART1_IRQ,
>>> 1);
>>> +    }
>>> +
>>>        if (virt_is_iommu_sys_enabled(s)) {
>>>            acpi_dsdt_add_iommu_sys(scope, &memmap[VIRT_IOMMU_SYS],
>>> IOMMU_SYS_IRQ);
>>>        }
>>> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
>>> index 33775a61fd..4703ac58f8 100644
>>> --- a/hw/riscv/virt.c
>>> +++ b/hw/riscv/virt.c
>>> @@ -96,6 +96,8 @@ static const MemMapEntry virt_memmap[] = {
>>>        [VIRT_APLIC_S] =      {  0xd000000, APLIC_SIZE(VIRT_CPUS_MAX)
>>> },
>>>        [VIRT_UART0] =        { 0x10000000,         0x100 },
>>>        [VIRT_VIRTIO] =       { 0x10001000,        0x1000 },
>>> +    /* UART1 supports page isolation from UART0 */
>>> +    [VIRT_UART1] =        { 0x1000a000,         0x100 },
>>>        [VIRT_FW_CFG] =       { 0x10100000,          0x18 },
>>>        [VIRT_FLASH] =        { 0x20000000,     0x4000000 },
>>>        [VIRT_IMSIC_M] =      { 0x24000000, VIRT_IMSIC_MAX_SIZE },
>>> @@ -186,7 +188,8 @@ static void create_pcie_irq_map(RISCVVirtState
>>> *s, void *fdt, char *nodename,
>>>                              FDT_MAX_INT_MAP_WIDTH] = {};
>>>        uint32_t *irq_map = full_irq_map;
>>>    
>>> -    /* This code creates a standard swizzle of interrupts such
>>> that
>>> +    /*
>>> +     * This code creates a standard swizzle of interrupts such
>>> that
>>>         * each device's first interrupt is based on it's PCI_SLOT
>>> number.
>>>         * (See pci_swizzle_map_irq_fn())
>>>         *
>>> @@ -832,28 +835,38 @@ static void create_fdt_reset(RISCVVirtState
>>> *s, uint32_t *phandle)
>>>    }
>>>    
>>>    static void create_fdt_uart(RISCVVirtState *s,
>>> -                            uint32_t irq_mmio_phandle)
>>> +                            uint32_t irq_mmio_phandle, int memId,
>>> int irqNo)
>>>    {
>>>        g_autofree char *name = NULL;
>>>        MachineState *ms = MACHINE(s);
>>>    
>>>        name = g_strdup_printf("/soc/serial@%"HWADDR_PRIx,
>>> -                           s->memmap[VIRT_UART0].base);
>>> +                           s->memmap[memId].base);
>>>        qemu_fdt_add_subnode(ms->fdt, name);
>>>        qemu_fdt_setprop_string(ms->fdt, name, "compatible",
>>> "ns16550a");
>>>        qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
>>> -                                 2, s->memmap[VIRT_UART0].base,
>>> -                                 2, s->memmap[VIRT_UART0].size);
>>> +                                 2, s->memmap[memId].base,
>>> +                                 2, s->memmap[memId].size);
>>>        qemu_fdt_setprop_cell(ms->fdt, name, "clock-frequency",
>>> 3686400);
>>>        qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent",
>>> irq_mmio_phandle);
>>>        if (s->aia_type == VIRT_AIA_TYPE_NONE) {
>>> -        qemu_fdt_setprop_cell(ms->fdt, name, "interrupts",
>>> UART0_IRQ);
>>> +        qemu_fdt_setprop_cell(ms->fdt, name, "interrupts", irqNo);
>>>        } else {
>>> -        qemu_fdt_setprop_cells(ms->fdt, name, "interrupts",
>>> UART0_IRQ, 0x4);
>>> +        qemu_fdt_setprop_cells(ms->fdt, name, "interrupts", irqNo,
>>> 0x4);
>>> +    }
>>> +
>>> +    if (VIRT_UART0 == memId) {
>>> +        qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path",
>>> name);
>>> +        qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0",
>>> name);
>>>        }
>>> +}
>>>    
>>> -    qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path",
>>> name);
>>> -    qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", name);
>>> +static void create_fdt_uarts(RISCVVirtState *s, uint32_t
>>> irq_mmio_phandle)
>>> +{
>>> +    if (s->uart1_present) {
>>> +        create_fdt_uart(s, irq_mmio_phandle, VIRT_UART1,
>>> UART1_IRQ);
>>> +    }
>>> +    create_fdt_uart(s, irq_mmio_phandle, VIRT_UART0, UART0_IRQ);
>>>    }
>>>    
>>>    static void create_fdt_rtc(RISCVVirtState *s,
>>> @@ -1023,7 +1036,7 @@ static void finalize_fdt(RISCVVirtState *s)
>>>    
>>>        create_fdt_reset(s, &phandle);
>>>    
>>> -    create_fdt_uart(s, irq_mmio_phandle);
>>> +    create_fdt_uarts(s, irq_mmio_phandle);
>>>    
>>>        create_fdt_rtc(s, irq_mmio_phandle);
>>>    }
>>> @@ -1567,6 +1580,13 @@ static void virt_machine_init(MachineState
>>> *machine)
>>>            0, qdev_get_gpio_in(mmio_irqchip, UART0_IRQ), 399193,
>>>            serial_hd(0), DEVICE_LITTLE_ENDIAN);
>>>    
>>> +    if (serial_hd(1)) {
>>> +        serial_mm_init(system_memory, s->memmap[VIRT_UART1].base,
>>> +            0, qdev_get_gpio_in(mmio_irqchip, UART1_IRQ), 399193,
>>> +            serial_hd(1), DEVICE_LITTLE_ENDIAN);
>>> +        s->uart1_present = true;
>>> +    }
>>> +
>>>        sysbus_create_simple("goldfish_rtc", s-
>>>> memmap[VIRT_RTC].base,
>>>            qdev_get_gpio_in(mmio_irqchip, RTC_IRQ));
>>>    
>>> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
>>> index 18a2a323a3..7d57c8292e 100644
>>> --- a/include/hw/riscv/virt.h
>>> +++ b/include/hw/riscv/virt.h
>>> @@ -59,6 +59,7 @@ struct RISCVVirtState {
>>>        int aia_guests;
>>>        char *oem_id;
>>>        char *oem_table_id;
>>> +    bool uart1_present;
>>>        OnOffAuto acpi;
>>>        const MemMapEntry *memmap;
>>>        struct GPEXHost *gpex_host;
>>> @@ -78,6 +79,7 @@ enum {
>>>        VIRT_APLIC_S,
>>>        VIRT_UART0,
>>>        VIRT_VIRTIO,
>>> +    VIRT_UART1,
>>>        VIRT_FW_CFG,
>>>        VIRT_IMSIC_M,
>>>        VIRT_IMSIC_S,
>>> @@ -93,6 +95,7 @@ enum {
>>>    enum {
>>>        UART0_IRQ = 10,
>>>        RTC_IRQ = 11,
>>> +    UART1_IRQ = 12,
>>>        VIRTIO_IRQ = 1, /* 1 to 8 */
>>>        VIRTIO_COUNT = 8,
>>>        PCIE_IRQ = 0x20, /* 32 to 35 */
> 


