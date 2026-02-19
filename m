Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37970E9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 11:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt2P2-0001JO-PH; Thu, 19 Feb 2026 06:41:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1vt2P0-0001J1-RN
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 06:41:02 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1vt2Oy-0001aN-Ug
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 06:41:02 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-483703e4b08so6691085e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 03:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771501259; x=1772106059; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Qi1xpuyJZOkDGlLVuM/nWid1PLrL4DAHlmIcNqS0vKg=;
 b=koaHaP8tUBRwIYEeCy3ClllngNJjNRfa5zEP12JJN3FfuGTqaYsvWCqGDYEuGpedYa
 MjB/McDBMcaIjMsuIBHLoCHujqq87IqcIkuUCaCLjJsrVEfupO6QBTobKrgg3gZUBoe+
 ETyxwBDNeuFwzSSTerMkYeiUQhsjoEibWffrqDliBu3S+2MgUNxyQW/1I836DQZL1tSg
 qOJ9pvnVMaba4otVkhOIcBsu/M3H4TOsh/iTAhW9IlQSdnUDoccjBzdu6ycP/XFfBKcz
 ZqxVTtTPtidzLeWYbICizbvKndIb62/r94DEjnt7NNx6QUNg+1iYy3WCLlH1i5Y6nl5C
 E75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771501259; x=1772106059;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qi1xpuyJZOkDGlLVuM/nWid1PLrL4DAHlmIcNqS0vKg=;
 b=DU722Fo1ggRIvX1UC7i1tTH5vZ7GMk0aSgRr/qIc4ucd8GTKqNs0VhZ0yx3EuIOnG5
 EfEA8x3Vq8hJN/M3MMujt/jfwVghWJM8ZyoRxRrKMyV4Xz2LV97PWCwGEs022CiBZ1f+
 0HvT3gt3dcx9vodBbeLbjebyCdCLWILuypruEF7FxCUUnb9QCT+YXfF6mWpVKG/TUqX5
 vjU+aIYwgJbUlU5s7bf04hWAywe7qf817ywNfYmZuM9mNwspkbZv3zAheDYoO/ldYLEL
 K0Nir3xQKLvNvw0ZzRZB8aW8el2sJTymAJCnGEIrIs+zsjHcDG+MmrvVYDdmLuG2+C35
 pxiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3Reao2L+43sBZAv5MGpw0p7GcHbb+8MA6X7DCO3nlExhm/VSAcMAOXbS9i6IEVxPPaV6nr3ZrikgB@nongnu.org
X-Gm-Message-State: AOJu0YwunmV2pJpKDZRFarA37XebQlvI06xeASCg7RQzMt6mfiPSMh+J
 ksSLNG4qsl8D9uuNsCgm/V2tGiOdKYTXoX+/8kYRgm2biuOuSs9tMK2J
X-Gm-Gg: AZuq6aKtYRJbL134m/yF2ZTtIERL8svKSI72Ym6uh74Sz0yFTQ8l87vhnfc7KyzC/PG
 4YxqSEjFbBg8vuddRCuBIBHh3vqZq5/7xnhPeVwUm/bBy+4+o3t3LrknvF6owYwTzn5XVvNA0Q1
 J8vmsRs6ai/kd/E8sgKec+cHlftxDD6lTHAXM+dYD6phVbuyZZFx4hVord3XZ1AJcTtPeXrJXLt
 iEkxWsQK1Mjs8UebZc3nHfvf6OTPBRC+l0TpB++Z87KiuHhzvC/KGmW2ZUOGxNdZFr3tqbra86Q
 3S2QwIwMh0xags9KGxJAbXv/RTIf0BKwJIJQTv1IMw/Hu7gJAJWNTbtKqnhfku3U2zJz4rycTZo
 GwcOpnLTqglz0OMTa16rvdlMEbZfKV4mJs328W6nlGDK5jaRbym+9abCP2cvLQQj346yITvISCR
 MnbuNDsFpng2RivJYkeKoxa8nQOH9Epg==
X-Received: by 2002:a05:600c:83c8:b0:483:6cf0:5d8b with SMTP id
 5b1f17b1804b1-483a00a5270mr22880675e9.9.1771501259040; 
 Thu, 19 Feb 2026 03:40:59 -0800 (PST)
Received: from [10.24.66.212] ([15.248.2.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4839ea454eesm15570375e9.11.2026.02.19.03.40.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 03:40:58 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <3fb296ed-15e3-4486-b7dd-a3f59fba165e@xen.org>
Date: Thu, 19 Feb 2026 11:40:57 +0000
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
 <bb43a79b-9ca9-49c4-ae88-f71991c97a58@xen.org>
 <CAK3XEhNHb6D=Moq=wcsFPDX2Dr_TBe7D9Z1EM4J5w3k+hobpuw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAK3XEhNHb6D=Moq=wcsFPDX2Dr_TBe7D9Z1EM4J5w3k+hobpuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x331.google.com
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

On 19/02/2026 11:19, Ani Sinha wrote:
> On Thu, Feb 19, 2026 at 4:15 PM Paul Durrant <xadimgnik@gmail.com> wrote:
>>
>> On 19/02/2026 10:31, Ani Sinha wrote:
>>>
>>>
>>>> On 19 Feb 2026, at 3:09 PM, Paul Durrant <xadimgnik@gmail.com> wrote:
>>>>
>>>> On 18/02/2026 11:42, Ani Sinha wrote:
>>>>> On confidential guests KVM virtual machine file descriptor changes as a
>>>>> part of the guest reset process. Xen capabilities needs to be re-initialized in
>>>>> KVM against the new file descriptor.
>>>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>>>> ---
>>>>>    target/i386/kvm/xen-emu.c | 50 +++++++++++++++++++++++++++++++++++++--
>>>>>    1 file changed, 48 insertions(+), 2 deletions(-)
>>>>> diff --git a/target/i386/kvm/xen-emu.c b/target/i386/kvm/xen-emu.c
>>>>> index 52de019834..69527145eb 100644
>>>>> --- a/target/i386/kvm/xen-emu.c
>>>>> +++ b/target/i386/kvm/xen-emu.c
>>>>> @@ -44,9 +44,12 @@
>>>>>      #include "xen-compat.h"
>>>>>    +NotifierWithReturn xen_vmfd_change_notifier;
>>>>> +static bool hyperv_enabled;
>>>>>    static void xen_vcpu_singleshot_timer_event(void *opaque);
>>>>>    static void xen_vcpu_periodic_timer_event(void *opaque);
>>>>>    static int vcpuop_stop_singleshot_timer(CPUState *cs);
>>>>> +static int do_initialize_xen_caps(KVMState *s, uint32_t hypercall_msr);
>>>>>      #ifdef TARGET_X86_64
>>>>>    #define hypercall_compat32(longmode) (!(longmode))
>>>>> @@ -54,6 +57,30 @@ static int vcpuop_stop_singleshot_timer(CPUState *cs);
>>>>>    #define hypercall_compat32(longmode) (false)
>>>>>    #endif
>>>>>    +static int xen_handle_vmfd_change(NotifierWithReturn *n,
>>>>> +                                  void *data, Error** errp)
>>>>> +{
>>>>> +    int ret;
>>>>> +
>>>>> +    /* we are not interested in pre vmfd change notification */
>>>>> +    if (((VmfdChangeNotifier *)data)->pre) {
>>>>> +        return 0;
>>>>> +    }
>>>>> +
>>>>> +    ret = do_initialize_xen_caps(kvm_state, XEN_HYPERCALL_MSR);
>>>>> +    if (ret < 0) {
>>>>> +        return ret;
>>>>> +    }
>>>>> +
>>>>> +    if (hyperv_enabled) {
>>>>> +        ret = do_initialize_xen_caps(kvm_state, XEN_HYPERCALL_MSR_HYPERV);
>>>>> +        if (ret < 0) {
>>>>> +            return ret;
>>>>> +        }
>>>>> +    }
>>>>> +    return 0;
>>>>
>>>> This seems odd. Why use the hyperv_enabled boolean, rather than simply the msr value, since when hyperv_enabled is set you will be calling do_initialize_xen_caps() twice.
>>>
>>> I am not sure of enabling capabilities for Xen. I assumed we need to call kvm_xen_init() twice, once normally with XEN_HYPERCALL_MSR and if hyper is enabled, again with XEN_HYPERCALL_MSR_HYPERV. Is that not the case? Is it one or the other but not both? It seems kvm_arch_init() calls kvm_xen_init() once with XEN_HYPERCALL_MSR and another time vcpu_arch_init() calls it again if hyperv is enabled with XEN_HYPERCALL_MSR_HYPERV .
>>
>> Yes, it has to be assumed that XEN_HYPERCALL_MSR is correct until
>> Hyper-V supported is enabled, which comes later, at which point the MSR
>> is changed. So you only need save the latest MSR value and use that in
>> xen_handle_vmfd_change().
> 
> ok hopefully this looks good
> https://gitlab.com/anisinha/qemu/-/commit/7f7ba25151b6a658c54f95a370f1970c01a6269a
> 
> sending this out to minimize churn and to make v6 as close to the
> merge worthy as possible.
> 

Yeah, that looks better. I don't think you need to move the `int 
xen_caps, ret;` line though so your patch can be even smaller AFAICS.


