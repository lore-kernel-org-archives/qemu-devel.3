Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C06E9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1XX-000660-Qo; Thu, 19 Feb 2026 05:45:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1vt1XD-000657-PO
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:45:27 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1vt1XC-0007kF-14
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:45:27 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-65c4152313fso831247a12.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771497924; x=1772102724; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QeTdzGAJRlToFPZ2jrpBRauFpaCxe61uQC+bv+dMi6E=;
 b=lA16FusbBWb2KHwwv5H+Wwx7CzaVXOVV0pJPs/wt+v4Ww4YVu+MAM7xGtfoSxLQ9DF
 vx8MXRyCLQfU8TlupoS8r0HtkQOcOPoL6tRFH5JSQ0vJ7yt/WVcn3Pp5sHs9xyhCqdDq
 6q2aTqlQPf68kHSuVfq28nxaqpsNTbYqpH9yG2hQLQ1X9wlHBOK7Da3Kmfz4eSnnGYJY
 qpmExAFK2pa7KuHXSpgqPixeajYGFk1gdYRBHRqO5aktP06CCsXYSCS3KCky3uG5+vvd
 C2igGkgciL31iu8xDet7Ns12UvsfRhm9n6pEoAX+m4ODLsioE7z1EIIlL2Ai6/dPM4iZ
 jwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771497924; x=1772102724;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QeTdzGAJRlToFPZ2jrpBRauFpaCxe61uQC+bv+dMi6E=;
 b=bwchD5S22himdE2GjHsrI0ADHTMMriRZvuNriknBueOPsSATvsNCqrtiAaz6Bmqqqx
 Gc07tmEh4J9vvxKU4+E+NnIrymk7zzUYr9AxZobH2Op92fSsplMrX0NZjxefSZ9/QXpl
 FoP5quAgqcMgeufmDY8grRaTcF5vmVmgaaxNpfZCpl/mzGIHwQbF39tfZbZvQGABdFkH
 hyPQBs7PkSDU0c4OhNX6YqkFNPoQ4BBQNzil7W/ohWYs97+tv8eY3aoD3UkxMF+zed2L
 yEgetSPx0kCJBge6I1nauVVW9ntQXlqTrFgb2Yu6FMz9EzdTMiJ2TyM6k8JKtipMC2jr
 KBFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIfV5nOHUBkdgWeVkUDqaiaXRMTDyk2xqUMpDmu4eq3WmccejzNU8q2ukLMFp2Z9jKWNG2u7QFdcSM@nongnu.org
X-Gm-Message-State: AOJu0YzpYhzMv7n1n/mBtEtSYnTIroJklGtWcmn7/UflH6WHDyDzz1m+
 wGO+F/gjExzrIHOduPL+/yzGdyija0G2KCLC3cEo6tymE4Am90C+iUb1
X-Gm-Gg: AZuq6aK2FZFPINlIgKMpcr7jqLK5e8cgLTl6mLFoS+VgGyaW3kTzb1cTwAzXNFGlRRc
 hQQgMeFSwxCDnXDm6M2vmzbsum7Hb9PKZXz1T/ZSXiWufhhbIHM1KPx11ifvKqlJkaP1DHI9sFT
 O1hjjqCjm6ddj/I3wJgz5eDUTLfLjI6qYKowAa2pttsT4nAds8S4hfyRwQfwQGI/jf8OcX7tIpj
 m3p9K3WXFS+var0ToMY8TakB8MQjLu/7WdEgkjSFm5CJz+TY32imjNFa+tI/zy4qx43an4Y37Gx
 FYTKB+dBEoI6MkVXbK9p7KD0enO2W5sMJY6HBSK5iuOsZbtO8AQkSdxLSHBM88r/nHepVcl7Ohd
 FzE/AJSLtM2C5mqcm3rmr61+OAObZ2HhBN+2k9zkLwtjaaKa+j0ZFWWlsNZ7VjDVfEeJD4vpHxk
 UzJsB0rOoRl0EZ9FUgJmUZxkePAaw7
X-Received: by 2002:a17:907:3e20:b0:b8f:abff:9ce7 with SMTP id
 a640c23a62f3a-b904dc6918bmr158508666b.32.1771497924100; 
 Thu, 19 Feb 2026 02:45:24 -0800 (PST)
Received: from [10.24.66.212] ([15.248.2.24]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8fc735d69esm551810766b.6.2026.02.19.02.45.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 02:45:23 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <bb43a79b-9ca9-49c4-ae88-f71991c97a58@xen.org>
Date: Thu, 19 Feb 2026 10:45:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 27/34] kvm/xen-emu: re-initialize capabilities during
 confidential guest reset
To: Ani Sinha <anisinha@redhat.com>, Paul Durrant <xadimgnik@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, kvm@vger.kernel.org,
 qemu-devel <qemu-devel@nongnu.org>
References: <20260218114233.266178-1-anisinha@redhat.com>
 <20260218114233.266178-28-anisinha@redhat.com>
 <3b4b7b7b-7fcd-46ce-bdcb-cd1a30cf5276@xen.org>
 <793B549F-F866-4BF5-ABAF-A0537BA8713B@redhat.com>
Content-Language: en-US
In-Reply-To: <793B549F-F866-4BF5-ABAF-A0537BA8713B@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=xadimgnik@gmail.com; helo=mail-ed1-x535.google.com
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

On 19/02/2026 10:31, Ani Sinha wrote:
> 
> 
>> On 19 Feb 2026, at 3:09 PM, Paul Durrant <xadimgnik@gmail.com> wrote:
>>
>> On 18/02/2026 11:42, Ani Sinha wrote:
>>> On confidential guests KVM virtual machine file descriptor changes as a
>>> part of the guest reset process. Xen capabilities needs to be re-initialized in
>>> KVM against the new file descriptor.
>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>> ---
>>>   target/i386/kvm/xen-emu.c | 50 +++++++++++++++++++++++++++++++++++++--
>>>   1 file changed, 48 insertions(+), 2 deletions(-)
>>> diff --git a/target/i386/kvm/xen-emu.c b/target/i386/kvm/xen-emu.c
>>> index 52de019834..69527145eb 100644
>>> --- a/target/i386/kvm/xen-emu.c
>>> +++ b/target/i386/kvm/xen-emu.c
>>> @@ -44,9 +44,12 @@
>>>     #include "xen-compat.h"
>>>   +NotifierWithReturn xen_vmfd_change_notifier;
>>> +static bool hyperv_enabled;
>>>   static void xen_vcpu_singleshot_timer_event(void *opaque);
>>>   static void xen_vcpu_periodic_timer_event(void *opaque);
>>>   static int vcpuop_stop_singleshot_timer(CPUState *cs);
>>> +static int do_initialize_xen_caps(KVMState *s, uint32_t hypercall_msr);
>>>     #ifdef TARGET_X86_64
>>>   #define hypercall_compat32(longmode) (!(longmode))
>>> @@ -54,6 +57,30 @@ static int vcpuop_stop_singleshot_timer(CPUState *cs);
>>>   #define hypercall_compat32(longmode) (false)
>>>   #endif
>>>   +static int xen_handle_vmfd_change(NotifierWithReturn *n,
>>> +                                  void *data, Error** errp)
>>> +{
>>> +    int ret;
>>> +
>>> +    /* we are not interested in pre vmfd change notification */
>>> +    if (((VmfdChangeNotifier *)data)->pre) {
>>> +        return 0;
>>> +    }
>>> +
>>> +    ret = do_initialize_xen_caps(kvm_state, XEN_HYPERCALL_MSR);
>>> +    if (ret < 0) {
>>> +        return ret;
>>> +    }
>>> +
>>> +    if (hyperv_enabled) {
>>> +        ret = do_initialize_xen_caps(kvm_state, XEN_HYPERCALL_MSR_HYPERV);
>>> +        if (ret < 0) {
>>> +            return ret;
>>> +        }
>>> +    }
>>> +    return 0;
>>
>> This seems odd. Why use the hyperv_enabled boolean, rather than simply the msr value, since when hyperv_enabled is set you will be calling do_initialize_xen_caps() twice.
> 
> I am not sure of enabling capabilities for Xen. I assumed we need to call kvm_xen_init() twice, once normally with XEN_HYPERCALL_MSR and if hyper is enabled, again with XEN_HYPERCALL_MSR_HYPERV. Is that not the case? Is it one or the other but not both? It seems kvm_arch_init() calls kvm_xen_init() once with XEN_HYPERCALL_MSR and another time vcpu_arch_init() calls it again if hyperv is enabled with XEN_HYPERCALL_MSR_HYPERV .

Yes, it has to be assumed that XEN_HYPERCALL_MSR is correct until 
Hyper-V supported is enabled, which comes later, at which point the MSR 
is changed. So you only need save the latest MSR value and use that in 
xen_handle_vmfd_change().

> 
>>
>>> +}
>>> +
>>>   static bool kvm_gva_to_gpa(CPUState *cs, uint64_t gva, uint64_t *gpa,
>>>                              size_t *len, bool is_write)
>>>   {
>>> @@ -111,15 +138,16 @@ static inline int kvm_copy_to_gva(CPUState *cs, uint64_t gva, void *buf,
>>>       return kvm_gva_rw(cs, gva, buf, sz, true);
>>>   }
>>>   -int kvm_xen_init(KVMState *s, uint32_t hypercall_msr)
>>> +static int do_initialize_xen_caps(KVMState *s, uint32_t hypercall_msr)
>>>   {
>>> +    int xen_caps, ret;
>>>       const int required_caps = KVM_XEN_HVM_CONFIG_HYPERCALL_MSR |
>>>           KVM_XEN_HVM_CONFIG_INTERCEPT_HCALL | KVM_XEN_HVM_CONFIG_SHARED_INFO;
>>> +
>>
>> Gratuitous whitespace change.
>>
>>>       struct kvm_xen_hvm_config cfg = {
>>>           .msr = hypercall_msr,
>>>           .flags = KVM_XEN_HVM_CONFIG_INTERCEPT_HCALL,
>>>       };
>>> -    int xen_caps, ret;
>>>         xen_caps = kvm_check_extension(s, KVM_CAP_XEN_HVM);
>>>       if (required_caps & ~xen_caps) {
>>> @@ -143,6 +171,21 @@ int kvm_xen_init(KVMState *s, uint32_t hypercall_msr)
>>>                        strerror(-ret));
>>>           return ret;
>>>       }
>>> +    return xen_caps;
>>> +}
>>> +
>>> +int kvm_xen_init(KVMState *s, uint32_t hypercall_msr)
>>> +{
>>> +    int xen_caps;
>>> +
>>> +    xen_caps = do_initialize_xen_caps(s, hypercall_msr);
>>> +    if (xen_caps < 0) {
>>> +        return xen_caps;
>>> +    }
>>> +
>>
>> Clearly here the code would be simpler here if you just saved the value of hypercall_msr which you have used in the call above.
>>
>>> +    if (!hyperv_enabled && (hypercall_msr == XEN_HYPERCALL_MSR_HYPERV)) {
>>> +        hyperv_enabled = true;
>>> +    }
>>>         /* If called a second time, don't repeat the rest of the setup. */
>>>       if (s->xen_caps) {
>>> @@ -185,6 +228,9 @@ int kvm_xen_init(KVMState *s, uint32_t hypercall_msr)
>>>       xen_primary_console_reset();
>>>       xen_xenstore_reset();
>>>   +    xen_vmfd_change_notifier.notify = xen_handle_vmfd_change;
>>> +    kvm_vmfd_add_change_notifier(&xen_vmfd_change_notifier);
>>> +
>>>       return 0;
>>>   }
> 
> 


