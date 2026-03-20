Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483491098797
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 15:34:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3brA-0002IR-QL; Fri, 20 Mar 2026 11:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <califano.tommaso@gmail.com>)
 id 1w3br8-0002ID-Tg
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 11:33:46 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <califano.tommaso@gmail.com>)
 id 1w3br7-0001JM-6G
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 11:33:46 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-486fe655187so11976195e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 08:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774020823; x=1774625623; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r7q5uU/FGHIAi3WQ08qV264szit3ZXeqzJkWmXhZxZI=;
 b=MzH2hEDxGNbn53VvoAiSKaqLe20/DMkhOkjlgQ9V1dgJ/E5RuykxJNCTbtm66qY5XS
 /ScvI5n0WATftrfnW0oCmdngM24M4myrI2BeTZhPZMFcmQGTTDOMGgnnPTcqSNaH08ZV
 exMfEjlqZeXXukk6qyAXfA/fp5+OOeYH36Y+4dxj+P6mNz1hf4N36d0zFNXVjc1kUXMP
 /2IMXx2PhZiGKm/UNdKZwf2hc8efX8d3x9LtpKsT+JSPYwHQ9rySI5PkWwAMwVzzsHGE
 cRjKdp/Fg2At+WiEjr1NS66SrooQFKPNMI5v3ZCv1gptziRh6aXrh1/Kzmn8LdgBO4T2
 PYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774020823; x=1774625623;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r7q5uU/FGHIAi3WQ08qV264szit3ZXeqzJkWmXhZxZI=;
 b=bNN2KWP6DWTn7G/n91dzJp/YAMsNXTftZUMKRs2jTtkGe6tfjRPRHkIcRNHYTyGGeF
 l8B2pyTaIp70ocUzXww908MY4ycuAU5L6afUbJYWgK9vbpyudJOfGM8mPCEwxt5HS3jZ
 LHyi5J4puBhPozvnc5fRGhgwXDgXZEc/1z/f7XNjlpUAy/7TSFqFidoNrbC5Pv/n4nxp
 4gAHmucjfRDqJ8fR8MmVtOFwX//Yee9zCsvWY0G+2TcMn57/edQhpE1Die3whcgwGMKZ
 SbqeMc2w4Ebi1+pkco9607URsR6/87ocPaWwLOK6ncrfM8O5cy6UiIGMwcmFYSWZrQtk
 1KOw==
X-Gm-Message-State: AOJu0Yw0FKA55MLtNV8E9ouzioZHbnJ5fowPf+E5wB48mS78yUdqvwsu
 PENAhcmlVMucLWfe6H2qT3cLXifC5j3hM5XnDWv1bIpl1Y0k1kEYwFVX
X-Gm-Gg: ATEYQzy0kCgJIZNl+xgJkJlU+7W2KfYzGfMiFNIQJlfTx/zmUjO5uRE+V9S1iUVnRhG
 O2pyOngy1+XyMpzPGq++WEH92pZL5tsjbeOYxWz8COy98BoCnDrksWSCz027ZyxXfplW7wZ1tfK
 PfKozrDHi2vdwPffh3DfESFB1UYGs6sI1OYMPr6CYDnna7B4yPDiwXiRI8/uViWmXnDhHLoWajo
 RFMF7HY1hvjulFyFkDL7Xo/yrp55+s1fg36zKPNdBiz8WPycoVQdJkOf0igM6qo7QxfS1EiBB88
 wNVzmkw+dA+CsnS93oMpmnQ6SL4r12mfvFCoiLPlNlNW4KnbXI3Fp6KELT09Ev/5kmhoyQvNfST
 jXesUId+DmjpaBbzX+GWyE9UOzVPIYpuPo4FfzGdXg1dYFVEAa0dR0aVKnZkoTC96hZrHMQNozI
 pExZU6aA+GeczSU+nZrS1aT02z3yqTnw7HaK0o7copTJLZDli6MfU7myQu
X-Received: by 2002:a05:600c:35c1:b0:485:3b50:fe54 with SMTP id
 5b1f17b1804b1-486fedb2545mr60168225e9.11.1774020822818; 
 Fri, 20 Mar 2026 08:33:42 -0700 (PDT)
Received: from [192.168.10.55] (77-32-38-61.dyn.eolo.it. [77.32.38.61])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b6470393fsm7801957f8f.17.2026.03.20.08.33.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2026 08:33:42 -0700 (PDT)
Message-ID: <462f2df0-06ca-4ca0-90cc-aa14ac2d0f83@gmail.com>
Date: Fri, 20 Mar 2026 16:34:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] i386/sev: Add sev-emulated QOM object with TCG support
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Eric Blake <eblake@redhat.com>,
 Oliver Steffen <osteffen@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Giuseppe Lettieri <giuseppe.lettieri@unipi.it>,
 Paolo Bonzini <pbonzini@redhat.com>, Luigi Leonardi <leonardi@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260317113840.33017-1-califano.tommaso@gmail.com>
 <20260317113840.33017-2-califano.tommaso@gmail.com>
 <87tsucvw3k.fsf@pond.sub.org>
 <1694998d-ea3d-4707-bf95-726ba9aee6c4@gmail.com>
 <878qbm4kw9.fsf@pond.sub.org>
Content-Language: en-US, it
From: Tommaso Califano <califano.tommaso@gmail.com>
In-Reply-To: <878qbm4kw9.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=califano.tommaso@gmail.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



Il 20/03/26 15:48, Markus Armbruster ha scritto:
> Tommaso Califano <califano.tommaso@gmail.com> writes:
> 
>> Il 19/03/26 13:31, Markus Armbruster ha scritto:
>>> Tommaso Califano <califano.tommaso@gmail.com> writes:
>>>
>>>> QEMU's AMD SEV support requires KVM on costly AMD EPYC processors,
>>>> limiting development and testing to users with specialized server
>>>> hardware. This makes it hard to validate SEV guest behavior, like
>>>> OVMF boots or SEV-aware software, on common dev machines.
>>>> A solution to this is the emulation of SEV from the guest's
>>>> perspective using TCG.
>>>>
>>>> This change begins this process with the exposure of the SEV CPUID leaf.
>>>> In target/i386/cpu.c:cpu_x86_cpuid() case 0x8000001F:
>>>>
>>>> case 0x8000001F:
>>>>     *eax = *ebx = *ecx = *edx = 0;
>>>>     if (sev_enabled()) {
>>>>         *eax = 0x2;
>>>>         *eax |= sev_es_enabled() ? 0x8 : 0;
>>>>         *eax |= sev_snp_enabled() ? 0x10 : 0;
>>>>         *ebx = sev_get_cbit_position() & 0x3f; /* EBX[5:0] */
>>>>         *ebx |= (sev_get_reduced_phys_bits() & 0x3f) << 6; /* EBX[11:6] */
>>>>     }
>>>>     break;
>>>>
>>>> sev_enabled() verifies if the QOM object is TYPE_SEV_GUEST;
>>>> TYPE_SEV_EMULATED is derived from TYPE_SEV_GUEST with SevEmulatedState
>>>> to satisfy this check with minimal changes. In particular this allows
>>>> to bypass all the sev_enabled() checks for future features.
>>>>
>>>> Since KVM hardware isn't available, override the QOM's kvm_init() and add
>>>> a conditional confidential_guest_kvm_init() call during machine_init() to
>>>> set up emulated confidential support using the ConfidentialGuestSupport
>>>> structure.
>>>>
>>>> With this change it is possible to run a VM with the SEV CPUID active
>>>> adding:
>>>>
>>>>     -accel tcg \
>>>>     -object sev-emulated,id=sev0,cbitpos=47,reduced-phys-bits=1 \
>>>>     -machine memory-encryption=sev0
>>>>
>>>> To the QEMU start arguments.
>>>>
>>>> Signed-off-by: Tommaso Califano <califano.tommaso@gmail.com>
>>>
>>> [...]
>>>
>>>> diff --git a/qapi/qom.json b/qapi/qom.json
>>>> index c653248f85..35cda819ec 100644
>>>> --- a/qapi/qom.json
>>>> +++ b/qapi/qom.json
> 
> [...]
> 
>>>> @@ -1241,6 +1254,7 @@
>>>>      { 'name': 'secret_keyring',
>>>>        'if': 'CONFIG_SECRET_KEYRING' },
>>>>      'sev-guest',
>>>> +    'sev-emulated',
>>>>      'sev-snp-guest',
>>>>      'thread-context',
>>>>      's390-pv-guest',
>>>
>>> Please insert before sev-guest to keep things more or less sorted.
>>>
>>
>> I'll do it, but I don't understand the convention. I'd organized them
>> by object derivation hierarchy, so what is the expected sorting order?
> 
> It looks alphabetical modulo lazy mistakes to me.
> 
> [...]
> 

Thanks for the clarification.

Best regards,
Tommaso Califano

