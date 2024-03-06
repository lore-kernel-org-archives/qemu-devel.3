Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918F7C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 18:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhw26-0002BH-7T; Wed, 06 Mar 2024 13:30:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rhw23-0002Am-Kv
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 13:30:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rhw1z-000434-Hs
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 13:30:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709749818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=k7KgayFbR+hNyRj6m2G0t2A8yhp89iJhEkkZnVmMqZg=;
 b=N7jrJbDGIs43I0GvSMLOCUYiL75hvGdlYOfbVi5DAXdM35UzHKNkSFfRbWyrC7fyutycZ7
 GfIJrjCH4hngBfwpJvMQO4KN84ohO8V4GWPwk8lpwLa0eg3T6E3h64AeTlXouGxusbwp7U
 M4okEE/WkC48YCVivjGnpQvrV3mwkRs=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-XsTfEfDjMmK3eqDZJBpA6w-1; Wed, 06 Mar 2024 13:30:16 -0500
X-MC-Unique: XsTfEfDjMmK3eqDZJBpA6w-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-51337da375dso4811369e87.3
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 10:30:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709749814; x=1710354614;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k7KgayFbR+hNyRj6m2G0t2A8yhp89iJhEkkZnVmMqZg=;
 b=wvXuMdvZGR3wmChoyW/ZWUiI7fqA6tq7Sv5oIyj+NM1fCp8E4kzsw2XL6FCxxctBdb
 RHXV9i5U5rWygC6/tw+nQnmx+sVupSd7A+yNcY71k7e5PtYtI3TC/XF2IzaS3xc6M4PZ
 Zrv7FlsIYayil5VrvD3UXYmrVOH501Z7yPR9hFqsFkJmdgW4l421AQHl+JPxSlq4N7ai
 Xvj7jKNXX+grBPXbOC1/XPHgJ29tTDdJPirDbXLp85CFTbHiwUWeAQTpU5wGb6ORPakm
 GnQ4dTw6nMXQ1XkLRiM2J+KwlShp2j88vFBTN21II0qu/6Gr5ltZLfEiXNNT6TB1LwaI
 QqeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuEbCNLSY+D9EuNsua69tTA4+0EWaxwczbuoBpZE35k67t5pyyUPH/foX42AdiXaHJS1jB6dVNXpNvtzvjVTKafzWaI98=
X-Gm-Message-State: AOJu0YyIFds61jLVv/+TP4yNfSGI3v4rFpVm6g6Iw4g45BWFx9cI17ue
 1QlFR1KVQlNOCF1Hlf7bS5UwGTjd3LcMAbjQXxWz9Ms6SeqhJY+In9zntTeivnJfXzuI92BXPGx
 b85/RUULspjaPWg2OTBjBLLVK6B5YRnVrxOXVN48CwzlLhvZ9LC3+
X-Received: by 2002:a05:6512:148:b0:513:26fd:5c13 with SMTP id
 m8-20020a056512014800b0051326fd5c13mr3863711lfo.52.1709749814719; 
 Wed, 06 Mar 2024 10:30:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnQWxdZjVtvijqTnq9PdLFe6OMtKx6FhU+4/c9ObET/W6uD/MiWEzV38Iq+/ZhCVVhBmHZwA==
X-Received: by 2002:a05:6512:148:b0:513:26fd:5c13 with SMTP id
 m8-20020a056512014800b0051326fd5c13mr3863688lfo.52.1709749814363; 
 Wed, 06 Mar 2024 10:30:14 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-151.web.vodafone.de.
 [109.43.178.151]) by smtp.gmail.com with ESMTPSA id
 gc9-20020a170906c8c900b00a4498726bb9sm6255742ejb.173.2024.03.06.10.30.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 10:30:14 -0800 (PST)
Message-ID: <c66d3c14-962d-439d-bc33-6d52d0f776be@redhat.com>
Date: Wed, 6 Mar 2024 19:30:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 17/18] target/i386: Remove
 X86CPU::kvm_no_smi_migration field
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Marcelo Tosatti <mtosatti@redhat.com>, devel@lists.libvirt.org,
 David Hildenbrand <david@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20240305134221.30924-1-philmd@linaro.org>
 <20240305134221.30924-18-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240305134221.30924-18-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 05/03/2024 14.42, Philippe Mathieu-Daudé wrote:
> X86CPU::kvm_no_smi_migration was only used by the
> pc-i440fx-2.3 machine, which got removed. Remove it
> and simplify kvm_put_vcpu_events().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/i386/cpu.h     | 3 ---
>   target/i386/cpu.c     | 2 --
>   target/i386/kvm/kvm.c | 6 ------
>   3 files changed, 11 deletions(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 952174bb6f..bdc640e844 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2018,9 +2018,6 @@ struct ArchCPU {
>       /* if set, limit maximum value for phys_bits when host_phys_bits is true */
>       uint8_t host_phys_bits_limit;
>   
> -    /* Stop SMI delivery for migration compatibility with old machines */
> -    bool kvm_no_smi_migration;
> -
>       /* Forcefully disable KVM PV features not exposed in guest CPUIDs */
>       bool kvm_pv_enforce_cpuid;
>   
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 2666ef3808..0e3ad8db2b 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -7905,8 +7905,6 @@ static Property x86_cpu_properties[] = {
>       DEFINE_PROP_BOOL("x-vendor-cpuid-only", X86CPU, vendor_cpuid_only, true),
>       DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
>       DEFINE_PROP_BOOL("l3-cache", X86CPU, enable_l3_cache, true),
> -    DEFINE_PROP_BOOL("kvm-no-smi-migration", X86CPU, kvm_no_smi_migration,
> -                     false),
>       DEFINE_PROP_BOOL("kvm-pv-enforce-cpuid", X86CPU, kvm_pv_enforce_cpuid,
>                        false),
>       DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU, vmware_cpuid_freq, true),
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 42970ab046..571cbbf1fc 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -4344,12 +4344,6 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
>               events.smi.pending = 0;
>               events.smi.latched_init = 0;
>           }
> -        /* Stop SMI delivery on old machine types to avoid a reboot
> -         * on an inward migration of an old VM.
> -         */
> -        if (!cpu->kvm_no_smi_migration) {
> -            events.flags |= KVM_VCPUEVENT_VALID_SMM;
> -        }

Shouldn't it be the other way round, i.e. that the flag is now always set?

pc_compat_2_3[] had:

     { TYPE_X86_CPU, "kvm-no-smi-migration", "on" },

... so I think kvm_no_smi_migration was set to true for the old machines?

  Thomas


