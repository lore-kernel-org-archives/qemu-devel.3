Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6588FC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 09:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpPfj-0002tr-Ny; Wed, 27 Mar 2024 05:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpPfU-0002jO-D0
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:34:02 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpPfS-0000fV-EX
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:34:00 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-341730bfc46so4649887f8f.3
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 02:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711532036; x=1712136836; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NJwhS6jGKEn/GCXsDKej/3MhG1neBdHS5aceARZ7xSk=;
 b=NKjnUwip0+lz5ocHok2QXIWM2VmSKk45LnwQRGilX9YyGQYCwDhisyAxHFxRzejKGK
 ccbG4zZAwvkqNUG8wFSBR6EVBaBle+BoNB85oPBg+z3S65QKwh0lWRXiPUfW8gzCP5YT
 DANPt12gjrojDau6dQU6QraeATIGbJ1FtuwdvzX0yYzE+TH9B/VzJKG4PWU3jasG62ja
 2WERhrypSIfJ3G5tNYKvBACLP1pslLbkG19JUIQHJYI6FDvTm4T4GFtUFodpIxhbDTqP
 aPwOJT4gz9MPKDH/mPjCuPOLDewhMlNMsxNo2PA1KYlLObgkEvX7KqhaH4v0gHTKeYJi
 RDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711532036; x=1712136836;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NJwhS6jGKEn/GCXsDKej/3MhG1neBdHS5aceARZ7xSk=;
 b=Pr4g1YsdRkaTACI/KMgmfLwzj2BmtkYQFw+27Tj6HzuyMLp+Y31ZPr7LQs0rtw3p87
 3Q58vzmRb0CAckwLUhcfR81FSqyHNgyDalcQ5iTcUAWxBOBQBLTlTyInPPfYk/L9rXv6
 269vgMoAojcybmWUxlEU7NNQz4VhTwwYyIDFtgbRpjreN7V0Y6/DMHyzHkOIqxZXh8fw
 XicIl5757rhBANtK7dhLDl+HHGdZEEKauCHzeNvcdHVW9ruD/EIzcMqvYr1P8xL0xiNX
 jWVdPze4uELt66ZJ710gmT7E9m67IFegjvH6vJuNU1NHaOlQ5/MsMvdbCj14iTGJyFzf
 OG9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUP+SZF2+QH7miqWI9883WXgt8cdw6ZYKnfbW6ZX+DkMYwTc9NeVH0nGn5p+qG30Dm5wqnvWG/ySAm7Vt7FxvQTA2myepE=
X-Gm-Message-State: AOJu0YyE3j9WQm/f/tzU7pxuAMtbkH0kebmNTd/nRocx71buURjALT4v
 E9E2YUSiI6g5VH5TWB2Q7kXWF+r5nxR59VvyWxrtOM7Gh3DsxhuC+Olebj996sY=
X-Google-Smtp-Source: AGHT+IEhqTZFkGrqwJ9Zl2njJHNGYCGSU3YWNDiNyGdhK9icUq5XRuYsRKy5ohDmFcimsxaVgQzScQ==
X-Received: by 2002:a05:6000:1808:b0:33e:c6c7:287e with SMTP id
 m8-20020a056000180800b0033ec6c7287emr3615873wrh.69.1711532035771; 
 Wed, 27 Mar 2024 02:33:55 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.205.175])
 by smtp.gmail.com with ESMTPSA id
 bs24-20020a056000071800b00341de001396sm1834750wrb.110.2024.03.27.02.33.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Mar 2024 02:33:55 -0700 (PDT)
Message-ID: <18039e1c-123c-45a9-bf84-17dac55d46a0@linaro.org>
Date: Wed, 27 Mar 2024 10:33:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 17/18] target/i386: Remove
 X86CPU::kvm_no_smi_migration field
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Marcelo Tosatti <mtosatti@redhat.com>, devel@lists.libvirt.org,
 David Hildenbrand <david@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20240305134221.30924-1-philmd@linaro.org>
 <20240305134221.30924-18-philmd@linaro.org>
 <c66d3c14-962d-439d-bc33-6d52d0f776be@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c66d3c14-962d-439d-bc33-6d52d0f776be@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 6/3/24 19:30, Thomas Huth wrote:
> On 05/03/2024 14.42, Philippe Mathieu-Daudé wrote:
>> X86CPU::kvm_no_smi_migration was only used by the
>> pc-i440fx-2.3 machine, which got removed. Remove it
>> and simplify kvm_put_vcpu_events().
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/i386/cpu.h     | 3 ---
>>   target/i386/cpu.c     | 2 --
>>   target/i386/kvm/kvm.c | 6 ------
>>   3 files changed, 11 deletions(-)


>> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
>> index 42970ab046..571cbbf1fc 100644
>> --- a/target/i386/kvm/kvm.c
>> +++ b/target/i386/kvm/kvm.c
>> @@ -4344,12 +4344,6 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int 
>> level)
>>               events.smi.pending = 0;
>>               events.smi.latched_init = 0;
>>           }
>> -        /* Stop SMI delivery on old machine types to avoid a reboot
>> -         * on an inward migration of an old VM.
>> -         */
>> -        if (!cpu->kvm_no_smi_migration) {
>> -            events.flags |= KVM_VCPUEVENT_VALID_SMM;
>> -        }
> 
> Shouldn't it be the other way round, i.e. that the flag is now always set?

Oops you are right, good catch!

> 
> pc_compat_2_3[] had:
> 
>      { TYPE_X86_CPU, "kvm-no-smi-migration", "on" },
> 
> ... so I think kvm_no_smi_migration was set to true for the old machines?
> 
>   Thomas
> 


