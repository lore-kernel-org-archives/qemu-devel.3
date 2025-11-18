Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42436CEE351
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 20:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLS7U-0001K5-E2; Tue, 18 Nov 2025 15:16:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vLS7S-0001Es-9y
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 15:16:06 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vLS7N-0000T1-Qh
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 15:16:06 -0500
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7c704bf2d9eso2659940a34.0
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 12:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1763496960; x=1764101760; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2eNVuyENc+noQdzzieQR9zdjw5WgRieBXmzrL2XC+8o=;
 b=OaKYG7e6hjKNL7TQm6LKXqLhCNXeyvwZYkNYH9+YJ1/HDs5jC4Jc1Wy3URFXpbBjno
 zUI8YBeJiKDiiXrkORaFCFstzabNCljVJxEp8LPtpzqTguJ1ji+JKxpBokuZK+0sFRPc
 TiIqiUwbcIZMqMYmEepZxOsOV1XQ7hI026yQoyw+BOXUdvmgBSOuvhuWApg72lHwpAiH
 wdfipVprJuA+cZOLqfHUmFQAlEiWyyJedbbTyjBSQ8kX78wJ/DpabkF8MgwO+Q8RH3OM
 o6OwmyjuG0VkHy3rYH3D0vkxwDeC41f/zPdPXmDDFSsNDvPWLi5QOVy1xJX2/zWa7H/V
 cFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763496960; x=1764101760;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2eNVuyENc+noQdzzieQR9zdjw5WgRieBXmzrL2XC+8o=;
 b=I9JO8BxJDoUsbXREeBB10ZZZ9sw3yVHe1U0vjzsBlpfFsyv/yZV3LnLN/q3O6C37cg
 JBpj5GluBIVluFZaqpun/MvFRhcYER/1iO8SzT4guw5AiT0t9eYRIUTT7cd2lgINV9JU
 ONxTBBVVaUxecoLxgidbLBaqamzXbQEFrrAfcbVZmMykY+ljffrCTCuZJl0yxbhiJrKv
 vrm+8r2wzqrHqC6YrnFGp8aAOdkNvYJ/V/E87gPTfoD+sw/eLhje9tmeo5ytoh6hgoPo
 vEnkEEN5RywEWnaY0dNN9xI0oiWZ6u6D8TE4q1cZMMT3JB/zZjhIiVRjlTM2HwFMcq4N
 V7dg==
X-Gm-Message-State: AOJu0YydapZuDMQq8O6b78KW2m7NmtxIqPazimHOByAJLZFIltnQvxSL
 cJk7ovia4Tmb7VHYq1bKr+5eJGPxkWHTM/WxGdgDOtOSibRH8YgbEwx11cCfXKQjp5I=
X-Gm-Gg: ASbGnct1d0e5XUybgBTv4UqHGag5gFuUQclS8vt7SBYVU09ipqg1jexnO8DvP4hvrST
 t8XMNspGOj+DImjBiditj3UqbkgXPO0ebw7WV+pxXEXQXUHX06tcZg/e8/kNbC2TcOpPMTt00JT
 VlgKQlrDIaMWZxOmPanxuthWeQ1HNte56BgvjQA3kmDOIHIMvWL0E1nQ6Dd1o8Xqqnsz/s7c7sT
 Ly+Ulit6kH3VmCLep7hZIUiu3X0Nfa931c02x6DUSz8V2B1CQphEan3VvAtUJQxiwwsMxLFuvWO
 43uQ5TEK9TBn6A6CvbSYBvWokQpS/26t8zgRgW5BXgLPJJpbndto1IUyKw4MRtaSAfoMfcP4svx
 r237Bkl0ub0NnnLtKV5IWdlSOG0K6WFkZVUerr0sUd35LeP/BfAsy0CZsSI/I0ZGpP8JZmCyCaj
 PLEw+kMw5Qmkj67M0VP51CSRXbx1E=
X-Google-Smtp-Source: AGHT+IHIj5USQ6OqyYKD28IPJra6pnh7oU0fsxgobwd1dEzWgZp5fzng6/vjMhfhAGPWF7lRGjkWYQ==
X-Received: by 2002:a05:6808:1a1c:b0:450:4a53:54d4 with SMTP id
 5614622812f47-4509740562bmr7899438b6e.25.1763496960367; 
 Tue, 18 Nov 2025 12:16:00 -0800 (PST)
Received: from [192.168.68.110] ([177.188.133.235])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4508a6b7c4bsm5596377b6e.17.2025.11.18.12.15.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 12:15:59 -0800 (PST)
Message-ID: <265ca0e7-b331-4158-8e11-8f31921cfcc0@ventanamicro.com>
Date: Tue, 18 Nov 2025 17:15:54 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] hw/riscv: experimental server platform reference
 machine
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Fei Wu <wu.fei9@sanechips.com.cn>
References: <20251111182944.2895892-1-dbarboza@ventanamicro.com>
 <20251111182944.2895892-4-dbarboza@ventanamicro.com>
 <20251111-a6e8ae9a0d6809ba0e62ba2e@orel>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20251111-a6e8ae9a0d6809ba0e62ba2e@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 11/11/25 8:36 PM, Andrew Jones wrote:
> On Tue, Nov 11, 2025 at 03:29:42PM -0300, Daniel Henrique Barboza wrote:
>> From: Fei Wu <wu.fei9@sanechips.com.cn>
> ...
>> +static char *rvsp_ref_get_aia_guests(Object *obj, Error **errp)
>> +{
>> +    RVSPMachineState *s = RVSP_REF_MACHINE(obj);
>> +    char val[32];
>> +
>> +    sprintf(val, "%d", s->aia_guests);
>> +    return g_strdup(val);
>> +}
>> +
>> +static void rvsp_ref_set_aia_guests(Object *obj, const char *val, Error **errp)
>> +{
>> +    RVSPMachineState *s = RVSP_REF_MACHINE(obj);
>> +
>> +    s->aia_guests = atoi(val);
>> +    if (s->aia_guests < 0 || s->aia_guests > RVSP_IRQCHIP_MAX_GUESTS) {
> 
> The minimum is 5 for the server platform, so we should enforce that. Also
> I suggest we bump RVSP_IRQCHIP_MAX_GUESTS since it's only 7 right now.
> 
>> +        error_setg(errp, "Invalid number of AIA IMSIC guests");
>> +        error_append_hint(errp, "Valid values be between 0 and %d.\n",
>> +                          RVSP_IRQCHIP_MAX_GUESTS);
>> +    }
>> +}
>> +
>> +static void rvsp_ref_machine_class_init(ObjectClass *oc, const void *data)
>> +{
>> +    char str[128];
>> +    MachineClass *mc = MACHINE_CLASS(oc);
>> +    static const char * const valid_cpu_types[] = {
>> +        TYPE_RISCV_CPU_RVSP_REF,
>> +    };
>> +
>> +    mc->desc = "RISC-V Server SoC Reference board (EXPERIMENTAL)";
> 
> We could (and probably should) version this machine type from the get go.
> If we do that, then we could simply give it a version 0.9, which would
> match the current spec. When the spec is ratified and this model is
> complete, then it can be bumped to 1.0. Going that route would allow us
> to avoid the EXPERIMENTAL "flag".

There has been some discussions offline on this and I'll bring them here.

A minor point: it was suggested to rename the board to 'rvserver' instead
of 'rvsp-ref'. I like this idea mostly because I keep misspelling rvsp-ref
as rsvp-ref.

As for the "version this machine type": in this case is different with what we do
with other QEMU machines. They have a new version for every QEMU release, e.g.
ARM's newest virt board is virt-10.2, in the next QEMU release it will be virt-11.0
and so on. We wouldn't do the same thing here - 'versioning' in this case is name
the board in a way that makes reference to the spec it implements. So this current
emulation would be named 'rvsp-ref-0.9', with an alias 'rvsp-ref' pointing to it.

Changing the emulation to comply with spec version 1.0 will create a rvsp-ref-1.0
board while keeping rvsp-ref-0.9 as is. Usually QEMU does that by using compat flags
that changes the behavior of the board, and we'll probably go this route.

One thing worth considering is that we can't just version stamp the board, we need to
do the same with the CPU. So we would have a rvsp-ref-cpu-0.9, rvsp-ref-cpu-1.0 and
an alias to point to the newest available emulation.

Also note that we're not 0.9 compliant either since we're missing sdext. So unless
we're willing to name this current board as rvsp-ref-0.9-beta or something like that,
maybe it's a good idea to postpone this work until we have 'sdext' implemented.


Thoughts always welcome. Thanks,

Daniel
   





> 
>> +    mc->init = rvsp_ref_machine_init;
>> +    mc->max_cpus = RVSP_CPUS_MAX;
>> +    mc->default_cpu_type = TYPE_RISCV_CPU_RVSP_REF;
>> +    mc->valid_cpu_types = valid_cpu_types;
>> +    mc->pci_allow_0_address = true;
>> +    mc->default_nic = "e1000e";
>> +    mc->possible_cpu_arch_ids = riscv_numa_possible_cpu_arch_ids;
>> +    mc->cpu_index_to_instance_props = riscv_numa_cpu_index_to_props;
>> +    mc->get_default_cpu_node_id = riscv_numa_get_default_cpu_node_id;
>> +    mc->numa_mem_supported = true;
>> +    /* platform instead of architectural choice */
>> +    mc->cpu_cluster_has_numa_boundary = true;
>> +    mc->default_ram_id = "riscv_rvsp_ref_board.ram";
>> +
>> +    object_class_property_add_str(oc, "aia-guests",
>> +                                  rvsp_ref_get_aia_guests,
>> +                                  rvsp_ref_set_aia_guests);
>> +    sprintf(str, "Set number of guest MMIO pages for AIA IMSIC. Valid value "
>> +                 "should be between 0 and %d.", RVSP_IRQCHIP_MAX_GUESTS);
> 
> Same comment about the guest file range as above (we shouldn't suggest
> anything less than 5).
> 
>> +    object_class_property_set_description(oc, "aia-guests", str);
>> +}
>> +
>> +static const TypeInfo rvsp_ref_typeinfo = {
>> +    .name       = TYPE_RVSP_REF_MACHINE,
>> +    .parent     = TYPE_MACHINE,
>> +    .class_init = rvsp_ref_machine_class_init,
>> +    .instance_init = rvsp_ref_machine_instance_init,
>> +    .instance_size = sizeof(RVSPMachineState),
>> +};
>> +
>> +static void rvsp_ref_init_register_types(void)
>> +{
>> +    type_register_static(&rvsp_ref_typeinfo);
>> +}
>> +
>> +type_init(rvsp_ref_init_register_types)
>> -- 
>> 2.51.1
>>
>>
> 
> Thanks,
> drew


