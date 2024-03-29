Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05825CD11DD
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 10:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq9Rq-0004Ps-4p; Fri, 29 Mar 2024 06:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rq9Ro-0004PN-Qp
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 06:26:56 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rq9Rm-00065p-Tb
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 06:26:56 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a4734ae95b3so244154766b.0
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 03:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711708013; x=1712312813; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SWvpAlam4luUqn3JoPHuKWjbc+IN3rUBDH0KIlC9Q1k=;
 b=CF9dHPCYqepVFgVhYE6OmS7RxtVdOqHj5gpPhK4m3D9/2dc8oMyC99wsi3zqcyxRYR
 DQmIW3hQo7gDH5v6YWC8W3SU/Je52frpI+pJ7hvz8Rq+/8hWAwfJeUt8OjikJgcFWqDf
 h7vo4YVoYlHO8N8O39wzJFjJuUMtI8mqUI/u74yC8WoMegsolTfVRtMH7BJvT069k8rJ
 8ODIy59HNJYNoryV07IL0CXylj69Ge5CR6MoVD64quTPmFlwEqY9zEHvrS99t/QVHcpc
 PKTr9kznyHsLyHhquKwuRr0qO7a3rc2Ey7x161VZ6XjDziK99YmiGNI4woLHf7YbYMxr
 ZgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711708013; x=1712312813;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SWvpAlam4luUqn3JoPHuKWjbc+IN3rUBDH0KIlC9Q1k=;
 b=hsng/v+xJFzxFSKFB38c7W9QMQ5j5/CwIN8hZ0PhX4Re5Dry7J76p6UjfvGi3J8y8r
 +s5ZJBrzFmy/EBFfhp2AELj90Z35RluplTUh9v+uZ3NGFNn/dw0GT5YGHA2l7zWGt+bn
 IchkOQRQHRftNr+xK+zFQl+Bund31Ts8aD86IC1JFMnj+pTUFu9VtV0xFngvnB9LyTG2
 qObRw/zMqlI1MnKASpGWhvLWZQu+uNf/QoyT6jQ3OhRXpT6EH+W0Ke3CeFHPCywjO6OL
 hlJBWPgkSLqlmyblIdphokeGGunyYG8AEhQHW3T4See9vAl9b+fjsc06GFJJQ+N7AwtV
 sb5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNEmuqnfYKODMW9EsgnEgG0ohlV0fjLpkapEOBFbji0lAcc/zFoEscAbFdrTwSuxehqFLgkDFb1h4Zq/6Du8XtS0xi4Rw=
X-Gm-Message-State: AOJu0YyR0uMbGe1sCzS1rl7AGrGlTHlxV4FPOBKgnC4Dfs+2njV0CQqL
 VT2PhWJLk5dTTA1Dz3N49OIK6L+nQlgQKWCoMQVuKtut+FOY6OHdxMDNlVqotkA=
X-Google-Smtp-Source: AGHT+IHwxRHyHTn6woayXuSj6kA7u7ML7M6gc04CgipjNklY10bb9/4z70j5IOaGyu8rQJjWtFy7tg==
X-Received: by 2002:a17:906:57c2:b0:a47:3b6a:a29b with SMTP id
 u2-20020a17090657c200b00a473b6aa29bmr1218984ejr.13.1711708012980; 
 Fri, 29 Mar 2024 03:26:52 -0700 (PDT)
Received: from [192.168.69.100] (uni14-h01-176-184-39-242.dsl.sta.abo.bbox.fr.
 [176.184.39.242]) by smtp.gmail.com with ESMTPSA id
 n12-20020a1709061d0c00b00a4da28f42f1sm1787129ejh.177.2024.03.29.03.26.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Mar 2024 03:26:52 -0700 (PDT)
Message-ID: <2b61ffd8-491b-4b45-891b-13d6d6494598@linaro.org>
Date: Fri, 29 Mar 2024 11:26:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 v2] hw/i386/pc: Deprecate 64-bit CPUs on ISA-only
 PC machine
To: Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, devel@lists.libvirt.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20240327165456.34716-1-philmd@linaro.org>
 <70006b4e-b2ae-4d74-be22-4dabf46e0217@ilande.co.uk>
 <179a8cbf-b645-4027-ad53-13c4beb4f099@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <179a8cbf-b645-4027-ad53-13c4beb4f099@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

On 28/3/24 16:39, Thomas Huth wrote:
> On 28/03/2024 16.12, Mark Cave-Ayland wrote:
>> On 27/03/2024 16:54, Philippe Mathieu-Daudé wrote:
>>
>>> Per Daniel suggestion [*]:
>>>
>>>   > isapc could arguably be restricted to just 32-bit CPU models,
>>>   > because we should not need it to support any feature that didn't
>>>   > exist prior to circa 1995. eg refuse to start with isapc, if 'lm'
>>>   > is present in the CPU model for example.
>>>
>>> Display a warning when such CPU is used:
>>>
>>>    $ qemu-system-x86_64 -monitor stdio -S -M isapc -cpu Westmere
>>>    qemu-system-x86_64: warning: Use of 64-bit CPU 'Westmere' is 
>>> deprecated on the ISA-only PC machine
>>>    QEMU 8.2.91 monitor - type 'help' for more information
>>>    (qemu) q
>>>
>>>    $ qemu-system-x86_64 -monitor stdio -S -M isapc -cpu athlon
>>>    QEMU 8.2.91 monitor - type 'help' for more information
>>>    (qemu) q
>>>
>>> [*] https://lore.kernel.org/qemu-devel/ZgQkS4RPmSt5Xa08@redhat.com/
>>>
>>> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   docs/about/deprecated.rst |  7 +++++++
>>>   include/hw/i386/pc.h      |  1 +
>>>   hw/i386/pc_piix.c         | 14 ++++++++++++++
>>>   3 files changed, 22 insertions(+)
>>>
>>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>>> index 7b548519b5..345c35507f 100644
>>> --- a/docs/about/deprecated.rst
>>> +++ b/docs/about/deprecated.rst
>>> @@ -208,6 +208,13 @@ is no longer packaged in any distro making it 
>>> harder to run the
>>>   ``check-tcg`` tests. Unless we can improve the testing situation there
>>>   is a chance the code will bitrot without anyone noticing.
>>> +64-bit (x86_64) CPUs on the ``isapc`` machine (since 9.0)
>>> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>>> +
>>> +The ``isapc`` machine aims to emulate old PC machine without PCI was
>>> +generalized, so hardware available around 1995, before 64-bit intel
>>> +CPUs were produced.
>>> +
>>>   System emulator machines
>>>   ------------------------
>>> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
>>> index 27a68071d7..2d202b9549 100644
>>> --- a/include/hw/i386/pc.h
>>> +++ b/include/hw/i386/pc.h
>>> @@ -96,6 +96,7 @@ struct PCMachineClass {
>>>       const char *default_south_bridge;
>>>       /* Compat options: */
>>> +    bool deprecate_64bit_cpu; /* Specific to the 'isapc' machine */
>>>       /* Default CPU model version.  See 
>>> x86_cpu_set_default_version(). */
>>>       int default_cpu_version;
>>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>>> index 18ba076609..2e5b2efc33 100644
>>> --- a/hw/i386/pc_piix.c
>>> +++ b/hw/i386/pc_piix.c
>>> @@ -182,7 +182,20 @@ static void pc_init1(MachineState *machine, 
>>> const char *pci_type)
>>>       }
>>>       pc_machine_init_sgx_epc(pcms);
>>> +
>>>       x86_cpus_init(x86ms, pcmc->default_cpu_version);
>>> +    if (pcmc->deprecate_64bit_cpu) {
>>> +        X86CPU *cpu = X86_CPU(first_cpu);
>>> +
>>> +        if (cpu->env.features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
>>> +            const char *cpu_type = 
>>> object_get_typename(OBJECT(first_cpu));
>>> +            int cpu_len = strlen(cpu_type) - 
>>> strlen(X86_CPU_TYPE_SUFFIX);
>>> +
>>> +            warn_report("Use of 64-bit CPU '%.*s' is deprecated"
>>> +                        " on the ISA-only PC machine",
>>> +                        cpu_len, cpu_type);
>>> +        }
>>> +    }
>>>       if (kvm_enabled()) {
>>>           kvmclock_create(pcmc->kvmclock_create_always);
>>> @@ -918,6 +931,7 @@ static void isapc_machine_options(MachineClass *m)
>>>       pcmc->gigabyte_align = false;
>>>       pcmc->smbios_legacy_mode = true;
>>>       pcmc->has_reserved_memory = false;
>>> +    pcmc->deprecate_64bit_cpu = true;
>>>       m->default_nic = "ne2k_isa";
>>>       m->default_cpu_type = X86_CPU_TYPE_NAME("486");
>>>       m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
>>
>> The logic around checking CPUID_EXT2_LM looks good to me. Slightly 
>> curious as to whether people feel updating PCMachineClass is 
>> necessary, or you can simply do qdev_get_machine() and use 
>> object_dynamic_cast() to see if the machine matches 
>> MACHINE_NAME("isapc") and warn that way?
> 
> Why don't you simply pass it as a parameter from pc_init_isa() instead? 
> Or do the whole check in pc_init_isa() instead?

Because the CPU isn't instantiated so we can't check the CPUID_EXT2_LM
feature :/


