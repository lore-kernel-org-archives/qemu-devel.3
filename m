Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E13C83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 07:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueUHy-0001f9-PL; Wed, 23 Jul 2025 03:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathias.krause@opensrcsec.com>)
 id 1ueUHw-0001cU-U1
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 03:53:20 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathias.krause@opensrcsec.com>)
 id 1ueUHu-0002DW-6i
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 03:53:20 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a51481a598so3374541f8f.3
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 00:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=grsecurity.net; s=grsec; t=1753257196; x=1753861996; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=OQGNPo3garWVuNKEr+ggVdH6ASMCD6oiLY95lvU0A+A=;
 b=rO+amF0NTna9paq4DRBVKG7OhtceGY2l/cOP1pwEDcDjc0uLj3B5lCZ/lweGeQRBm4
 OR2AgGuUdGpUhGt+5NGgZpPysZLVOr3MlE8dOh8yotiLGin4zsmBEqB3I/nm3Z1js8cX
 B5TSmcIeg5Z9bXad9zis4C/9x9jp2j1+MBgMXxxMkGZd+u9b28CNphvrrhm0peIAXFP5
 8/1nUFtcRLLq83llrNpNl7H6tzhs1mceY+VqiAKfjwOgIxIUGFN/EeAdBl171Rosa2o/
 VEDkJOBCnXsDH+Q8zxH2IwW8DG18Rw5n4VFxag0ddMIQW7HAehbMHbzGnk9KMjd7jhms
 H/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753257196; x=1753861996;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OQGNPo3garWVuNKEr+ggVdH6ASMCD6oiLY95lvU0A+A=;
 b=ENZIESpJrkV5DRLOEM3U08bepsejy0rk5m6hzuCreB13pv+n3J8uInuYZ1ciLzbDEG
 PSdSaqg/j8EajEKGHVnvfE+l9T6aUaKn7LvF40IX2YVqT5pujTmAADYJyhAA8jKUFyn+
 t+l/VDIIuZXf2dKKVNBiNL+so6BRop/v2VuL/zAtx8C+LBD9Pi8Ml90vK1M1lVW5w0yw
 dMCLFo6+ozkX3GxoxNlzeQDOMOHkZv0IS23tVr8KGtrSH/rvyo6RkQq2UT3xTTxcsftf
 TlRQ8LOIUrGT6dmrHtq2wQeCGhoEJCHDfsU6mQLmS23IkOln+I2//W2Dg6zL42gl+8pP
 i+iA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUCxEuSPp4orXl2XxV9CxoEsMdOpO01QnC7Okz/AZu76gJNBU5mCyHfWYrl2dXdb6YPyhZ8NfVcQWI@nongnu.org
X-Gm-Message-State: AOJu0YwLsKPGCATqSAIv6qJDw/K1aFUS7i5QPXk31eSKLMnGyJNhkAso
 phaVrFiAJojsGvMxFP+lsuL3hRvNMSzirvuqGdx1pq67KaiQAfmE0G3nnKfPny2g9LU=
X-Gm-Gg: ASbGnct6ACkErLAUplgGyYrKxnuqhaUOryoY7wI+shtH/upLfUf4QwAH3+505zLFhxG
 vX5lW/eqwkCAeLinntiHaLxuhoo1ZePN73lQq+JzFAc3piBkFp360qqwUMynmb9+mS+oRy3iVCL
 RR+5YOkYp1vY2xx5P7sQdHlkeZAHd7YG9ytUg3KKZ0GrXZ/CWBJ9AN8ahTnL3J8W6Z7FMW6ADSA
 3SQyRKeZKMjXB1ensxJA0rf2vc4qKc3+5lwqq+WIGBEQoCSXsb4M4qhw2IxO7+Q8qJlUknLbTam
 Ikpr82Iu937u3fQyAH1PmF4XAoUGmLofhIe6JBnP7uXLMEFkNGnjhQDyvoP292K6jf7kdMiLAUo
 qsw1cdl8VZkLQ0pVdzGsrNUDKb7U6OkwU12HKhHUQUdUZgVY4VxWhYarR0lvFRaOBCFuy7GhysV
 RbfeeRGpE+pIGzc/nySeBbIawp3dAJAzHHLSnhHC0G97tGbnHpVmVFCJ4=
X-Google-Smtp-Source: AGHT+IGdsUA5nte+D7kzcKXAAC9l8ysAyULXCNLE6farWjJukhrbX4rJmM9XOlkhu5Hh5Tq40oM7QQ==
X-Received: by 2002:a05:6000:3108:b0:3b6:12d9:9f1b with SMTP id
 ffacd0b85a97d-3b768ea0771mr1377773f8f.22.1753257196162; 
 Wed, 23 Jul 2025 00:53:16 -0700 (PDT)
Received: from ?IPV6:2003:fa:af22:cf00:2208:a86d:dff:5ae9?
 (p200300faaf22cf002208a86d0dff5ae9.dip0.t-ipconnect.de.
 [2003:fa:af22:cf00:2208:a86d:dff:5ae9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca253f9sm15771747f8f.6.2025.07.23.00.53.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jul 2025 00:53:15 -0700 (PDT)
Message-ID: <ebbb7c3c-b8cb-49b6-a029-e291105300fd@grsecurity.net>
Date: Wed, 23 Jul 2025 09:53:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i386/kvm: Disable hypercall patching quirk by default
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 Oliver Upton <oliver.upton@linux.dev>,
 Sean Christopherson <seanjc@google.com>
References: <20250722204316.1186096-1-minipli@grsecurity.net>
 <206a04b9-91cb-41e4-b762-92201c659d78@intel.com>
Content-Language: en-US, de-DE
From: Mathias Krause <minipli@grsecurity.net>
Autocrypt: addr=minipli@grsecurity.net; keydata=
 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
 RzDVkdgPJkL/NFTKZHo5foFXNi89kA==
In-Reply-To: <206a04b9-91cb-41e4-b762-92201c659d78@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=mathias.krause@opensrcsec.com; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.158,
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

On 23.07.25 08:54, Xiaoyao Li wrote:
> On 7/23/2025 4:43 AM, Mathias Krause wrote:
>> KVM has a weird behaviour when a guest executes VMCALL on an AMD system
>> or VMMCALL on an Intel CPU. Both naturally generate an invalid opcode
>> exception (#UD) as they are just the wrong instruction for the CPU
>> given. But instead of forwarding the exception to the guest, KVM tries
>> to patch the guest instruction to match the host's actual hypercall
>> instruction. That is doomed to fail as read-only code is rather the
>> standard these days. But, instead of letting go the patching attempt and
>> falling back to #UD injection, KVM injects the page fault instead.
>>
>> That's wrong on multiple levels. Not only isn't that a valid exception
>> to be generated by these instructions, confusing attempts to handle
>> them. It also destroys guest state by doing so, namely the value of CR2.
>>
>> Sean attempted to fix that in KVM[1] but the patch was never applied.
>>
>> Later, Oliver added a quirk bit in [2] so the behaviour can, at least,
>> conceptually be disabled. Paolo even called out to add this very
>> functionality to disable the quirk in QEMU[3]. So lets just do it.
>>
>> A new property 'hypercall-patching=on|off' is added, for the very
>> unlikely case that there are setups that really need the patching.
>> However, these would be vulnerable to memory corruption attacks freely
>> overwriting code as they please. So, my guess is, there are exactly 0
>> systems out there requiring this quirk.
>>
>> [1] https://lore.kernel.org/kvm/20211210222903.3417968-1-
>> seanjc@google.com/
>> [2] https://lore.kernel.org/kvm/20220316005538.2282772-2-
>> oupton@google.com/
>> [3] https://lore.kernel.org/kvm/80e1f1d2-2d79-22b7-6665-
>> c00e4fe9cb9c@redhat.com/
>>
>> Cc: Oliver Upton <oliver.upton@linux.dev>
>> Cc: Sean Christopherson <seanjc@google.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Mathias Krause <minipli@grsecurity.net>
> 
> I would leave it to Paolo to decide whether a compat property is needed
> to disable the hypercall patching by default for newer machine, and keep
> the old machine with old behavior (hypercall patching is enabled) by
> default.

Bleh, I just noticed that there are KUT tests that actually rely on the
feature[1]. I'll fix these but, looks like, we need to default on for
the feature -- at least for existing machine definitions :(

Looks like I have to go the compat property route.

[1]
https://gitlab.com/kvm-unit-tests/kvm-unit-tests/-/blob/master/x86/vmexit.c?ref_type=heads#L36

> 
> The implementation itself looks good to me, exception one nit. And I
> tested that amd guest gets #UD on Intel host with this patch.
> 
> Tested-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

Thanks a lot!

> 
>> ---
>> v2:
>> - rename hypercall_patching_enabled to hypercall_patching (Xiaoyao Li)
>> - make use of error_setg*() (Xiaoyao Li)
>>
>>   include/system/kvm_int.h |  1 +
>>   qemu-options.hx          | 10 +++++++++
>>   target/i386/kvm/kvm.c    | 45 ++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 56 insertions(+)
>>
>> diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
>> index 756a3c0a250e..c909464c74a2 100644
>> --- a/include/system/kvm_int.h
>> +++ b/include/system/kvm_int.h
>> @@ -159,6 +159,7 @@ struct KVMState
>>       uint64_t kvm_eager_split_size;  /* Eager Page Splitting chunk
>> size */
>>       struct KVMDirtyRingReaper reaper;
>>       struct KVMMsrEnergy msr_energy;
>> +    bool hypercall_patching;
>>       NotifyVmexitOption notify_vmexit;
>>       uint32_t notify_window;
>>       uint32_t xen_version;
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 1f862b19a676..c2e232649c19 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -231,6 +231,7 @@ DEF("accel", HAS_ARG, QEMU_OPTION_accel,
>>       "                dirty-ring-size=n (KVM dirty ring GFN count,
>> default 0)\n"
>>       "                eager-split-size=n (KVM Eager Page Split chunk
>> size, default 0, disabled. ARM only)\n"
>>       "                notify-vmexit=run|internal-error|
>> disable,notify-window=n (enable notify VM exit and set notify window,
>> x86 only)\n"
>> +    "                hypercall-patching=on|off (enable KVM's VMCALL/
>> VMMCALL hypercall patching quirk, x86 only)\n"
>>       "                thread=single|multi (enable multi-threaded TCG)\n"
>>       "                device=path (KVM device path, default /dev/
>> kvm)\n", QEMU_ARCH_ALL)
>>   SRST
>> @@ -313,6 +314,15 @@ SRST
>>           open up for a specified of time (i.e. notify-window).
>>           Default: notify-vmexit=run,notify-window=0.
>>   +    ``hypercall-patching=on|off``
>> +        KVM tries to recover from the wrong hypercall instruction
>> being used by
>> +        a guest by attempting to rewrite it to the one supported
>> natively by
>> +        the host CPU (VMCALL on Intel, VMMCALL for AMD systems).
>> However, this
>> +        patching may fail if the guest memory is write protected,
>> leading to a
>> +        page fault getting propagated to the guest instead of an illegal
>> +        instruction exception. As this may confuse guests, it gets
>> disabled by
>> +        default (x86 only).
>> +
>>       ``device=path``
>>           Sets the path to the KVM device node. Defaults to ``/dev/
>> kvm``. This
>>           option can be used to pass the KVM device to use via a file
>> descriptor
>> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
>> index 56a6b9b6381a..55f744956970 100644
>> --- a/target/i386/kvm/kvm.c
>> +++ b/target/i386/kvm/kvm.c
>> @@ -3224,6 +3224,26 @@ static int kvm_vm_enable_energy_msrs(KVMState *s)
>>       return 0;
>>   }
>>   +static int kvm_vm_disable_hypercall_patching(KVMState *s, Error
>> **errp)
>> +{
>> +    int valid_quirks = kvm_vm_check_extension(s,
>> KVM_CAP_DISABLE_QUIRKS2);
>> +    int ret = -1;
>> +
>> +    if (valid_quirks & KVM_X86_QUIRK_FIX_HYPERCALL_INSN) {
>> +        ret = kvm_vm_enable_cap(s, KVM_CAP_DISABLE_QUIRKS2, 0,
>> +                                KVM_X86_QUIRK_FIX_HYPERCALL_INSN);
>> +        if (ret) {
>> +            error_setg_errno(errp, -ret, "kvm: failed to disable "
>> +                             "hypercall patching quirk: %s",
>> +                             strerror(-ret));
>> +        }
>> +    } else {
>> +        error_setg(errp, "kvm: disabling hypercall patching not
>> supported");
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>>   int kvm_arch_init(MachineState *ms, KVMState *s)
>>   {
>>       int ret;
>> @@ -3363,6 +3383,12 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>>           }
>>       }
>>   +    if (s->hypercall_patching == false) {
> 
> Nit: it can be
> 
>     if (!s->hypercall_patching )

That would be my regular style as well but I noticed, there was an
explicit test for 's->msr_energy.enable == true' just a few lines above
and thought QEMU style may differ. But sure, can change it like that.

> 
>> +        if (kvm_vm_disable_hypercall_patching(s, &local_err)) {
>> +            error_report_err(local_err);
>> +        }
>> +    }
>> +
>>       return 0;
>>   }
>>   @@ -6456,6 +6482,19 @@ void kvm_request_xsave_components(X86CPU
>> *cpu, uint64_t mask)
>>       }
>>   }
>>   +static bool kvm_arch_get_hypercall_patching(Object *obj, Error **errp)
>> +{
>> +    KVMState *s = KVM_STATE(obj);
>> +    return s->hypercall_patching;
>> +}
>> +
>> +static void kvm_arch_set_hypercall_patching(Object *obj, bool value,
>> +                                            Error **errp)
>> +{
>> +    KVMState *s = KVM_STATE(obj);
>> +    s->hypercall_patching = value;
>> +}
>> +
>>   static int kvm_arch_get_notify_vmexit(Object *obj, Error **errp)
>>   {
>>       KVMState *s = KVM_STATE(obj);
>> @@ -6589,6 +6628,12 @@ static void
>> kvm_arch_set_xen_evtchn_max_pirq(Object *obj, Visitor *v,
>>     void kvm_arch_accel_class_init(ObjectClass *oc)
>>   {
>> +    object_class_property_add_bool(oc, "hypercall-patching",
>> +                                   kvm_arch_get_hypercall_patching,
>> +                                   kvm_arch_set_hypercall_patching);
>> +    object_class_property_set_description(oc, "hypercall-patching",
>> +                                          "Enable hypercall patching
>> quirk");
>> +
>>       object_class_property_add_enum(oc, "notify-vmexit",
>> "NotifyVMexitOption",
>>                                      &NotifyVmexitOption_lookup,
>>                                      kvm_arch_get_notify_vmexit,
> 

Thanks,
Mathias

