Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F090AC02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 13:37:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcPIM-0001gi-Lm; Mon, 27 Jan 2025 08:36:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcPIH-0001ak-M7
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 08:36:52 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcPID-0005Js-GO
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 08:36:48 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43622267b2eso46095065e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 05:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737985004; x=1738589804; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lmhndRbiFmLY7vWlgF4admIjyzMz9l/QR71GMSqUQL4=;
 b=x6u2Tf/8Tr90BmE6mvTAR8IIOf6nilpFniTcHqAG9CDDEIbq9l9B+/2wS8iaLdMfgv
 2a4dmrHtnBrSX531sQVHP0KCuvxMq5s2ytqZfb2P5HEoMvk8wBMzsq+nak9+oQPvpa32
 BGe1Uq5ag83YadyQ7uykB70AHz66nkNDAa1YfeIYqCI8oztj6rC0FkP0keG7cFfF6yRk
 jjBcPR4MMypmBoAMRNzq8g8nGmGTdX46HI8+kwbiofDMRuRBthamHgUxBv8kagDJ11AK
 7sVrqV4U5hDBD4OnSjPuOSvZdsQvvxckmxuUAtUvETrKlazL4lkD0h3Ge8sPFJhM49EL
 eGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737985004; x=1738589804;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lmhndRbiFmLY7vWlgF4admIjyzMz9l/QR71GMSqUQL4=;
 b=U6J5DXBwSUCkgPidmTI6xGCQ1igEbtmox6vAxTAiHAj7GP+PKP//Rm4ezH8YxPne0a
 uqZ3X2sekFRf7eUQVwADUg2JjHYN/cmVbuPv/LBgBNg5Hh0wckBydAEfswz3jChrKBfw
 lf4A8IQFL2D8zo8QJyqX0AZo8XfqOjhGvIxQBlN2jb7Ru68qJDJNO2OPcm79V8YXm57z
 BeZirr+Yfrb1i86yRwsUl/7XXtGVmR9ZEBK7ab8MyQytXSO79AE2T/XTL67AlstjOmxm
 Bzd839HHOtAfEjzlldu73rpNiDMGmayaH6OfrQ0BgomSZmBcmyeeXUgsT/hhLCrxG3wC
 hBeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3dzjpQVQCuJ887h5QQFpDO2HXpy7ist9oMKc1eyT8ZkbocA087Xas35AW1hcALU6wUb+v3Egy9yeT@nongnu.org
X-Gm-Message-State: AOJu0Yx5ieW5eEyORJdianpwCNXfDG7E0QC8F1oBv/zzVkrc3+BWfc90
 mQeWbFxyPCskzB/4O0eQfRjt7DkQaEBWtsvI1+wHHo9Ur4ybUSACwO3D60ku/UY=
X-Gm-Gg: ASbGncvW2DFwZJ9hLEhWKLt0hTUnPHE9vCeeezWBP0VeFdL9k8WDlgNZs5Bcyijm/bH
 p0FH3fmKeanHc7H8dOTXbn59mNhBEYIuQU1waN9ftmvf1ifBy5mMhxEN/tf1D4l/jCBFXNmhLDS
 TIqdjN8UWuDk41cVtfnnAj7dz7hWTdvav+vs+K5liUTt8bTC4K/xno7Ku2QsZ9UvE95nyFpYqrU
 zXPoFO9UIkuvhPU/8bDlQUPZaGDss7leZ9B+7v6sYIGOBEHoR1O/di2ez1xkKS6Hz2nw9R7YAtH
 txLsk4kN3hYaPC0gLgI1LwiITFbNNGdkVpE8+QNbNqiEsH+P4R5hVU4TUVU=
X-Google-Smtp-Source: AGHT+IHdanRz8M/umc7ZmAoamoBm7S6GyR92uK1RbXY2mjrjov6Gyhnq0bxGUj0a4P/DNz+0m00iWw==
X-Received: by 2002:a05:600c:4e52:b0:436:e751:e445 with SMTP id
 5b1f17b1804b1-438a079c1e7mr359023025e9.5.1737985003702; 
 Mon, 27 Jan 2025 05:36:43 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa599sm138332295e9.7.2025.01.27.05.36.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2025 05:36:43 -0800 (PST)
Message-ID: <429584de-a873-47e4-98cb-683c6d4f68bc@linaro.org>
Date: Mon, 27 Jan 2025 14:36:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg: drop qemu_cpu_is_self() in
 tlb_flush_by_mmuidx[_async_work]
To: Igor Mammedov <imammedo@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, pbonzini@redhat.com
References: <20250123094511.156324-1-imammedo@redhat.com>
 <87frl9ls4g.fsf@draig.linaro.org>
 <20250123122343.6af8a6e1@imammedo.users.ipa.redhat.com>
 <87y0z1k9yg.fsf@draig.linaro.org>
 <20250123143846.586282b2@imammedo.users.ipa.redhat.com>
 <f3567791-13f0-4696-81fe-19f4111705e7@linaro.org>
 <20250127143314.2eea59ff@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250127143314.2eea59ff@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

(also Cc'ing Harsh for commit 18530e7c57de)

On 27/1/25 14:33, Igor Mammedov wrote:
> On Mon, 27 Jan 2025 14:24:56 +0100
> Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> 
>> +Peter
>>
>> On 23/1/25 14:38, Igor Mammedov wrote:
>>> On Thu, 23 Jan 2025 12:09:59 +0000
>>> Alex Bennée <alex.bennee@linaro.org> wrote:
>>>    
>>>> Igor Mammedov <imammedo@redhat.com> writes:
>>>>   
>>>>> On Thu, 23 Jan 2025 10:52:15 +0000
>>>>> Alex Bennée <alex.bennee@linaro.org> wrote:
>>>>>      
>>>>>> Igor Mammedov <imammedo@redhat.com> writes:
>>>>>>       
>>>>>>> QEMU will crash with following debug enabled
>>>>>>>     # define DEBUG_TLB_GATE 1
>>>>>>>     # define DEBUG_TLB_LOG_GATE 1
>>>>>>> due to [1] introduced assert and as it happenstlb_flush_by_mmuidx[_async_work]
>>>>>>> functions are called not only from vcpu thread but also from reset handler
>>>>>>> that is called from main thread at cpu realize time when vcpu is already
>>>>>>> created
>>>>>>>     x86_cpu_new -> ... ->
>>>>>>>         x86_cpu_realizefn -> cpu_reset -> ... ->
>>>>>>>             tcg_cpu_reset_hold
>>>>>>>
>>>>>>> drop assert to fix crash.
>>>>>>
>>>>>> Hmm the assert is there for a good reason because we do not want to be
>>>>>> flushing another CPUs state. However the assert itself:
>>>>>>
>>>>>>     g_assert(!(cpu)->created || qemu_cpu_is_self(cpu));
>>>>>>
>>>>>> was trying to account for pre-initialised vCPUs. What has changed?
>>>>>>
>>>>>> cpu_thread_signal_created(cpu) is called just before we start running
>>>>>> the main loop in mttcg_cpu_thread_fn. So any other thread messing with
>>>>>> the CPUs TLB can potentially mess things up.
>>>>>
>>>>> it reproduces on current master, so yes it likely has changed over time.
>>>>> I've just stumbled on it when attempting to get rid of cpu->created
>>>>> usage.
>>>>
>>>> Why the drive to get rid of cpu->created?
>>>
>>> During review of Philippe's cpu cleanups,
>>> I've noticed that  cpu->created is mostly used for signaling
>>> main loop thread we've started vcpu thread with a couple of
>>> odd cases in tcg and kvm.
>>>     - 1st silently bit-rotted being behind ifdefs
>>>     - 2nd is work around CPU being prematurely visible to others
>>
>> 2nd is:
>>
>> commit 56adee407fc564da19e49cfe18e20e3da92320be
>> Author: Peter Xu <peterx@redhat.com>
>> Date:   Fri Feb 17 00:18:32 2023 +0800
>>
>>       kvm: dirty-ring: Fix race with vcpu creation
>>
>>       It's possible that we want to reap a dirty ring on a vcpu that is
>> during
>>       creation, because the vcpu is put onto list (CPU_FOREACH visible)
>> before
>>       initialization of the structures.  In this case:
>>
>>       qemu_init_vcpu
>>           x86_cpu_realizefn
>>               cpu_exec_realizefn
>>                   cpu_list_add      <---- can be probed by CPU_FOREACH
>>               qemu_init_vcpu
>>                   cpus_accel->create_vcpu_thread(cpu);
>>                       kvm_init_vcpu
>>                           map kvm_dirty_gfns  <--- kvm_dirty_gfns valid
>>
>>       Don't try to reap dirty ring on vcpus during creation or it'll crash.
>>
>> Looking at cpu_list_add() in cpu_exec_realizefn():
>>
>> hw/core/cpu-common.c-190-    /* Wait until cpu initialization complete
>> before exposing cpu. */
>> hw/core/cpu-common.c:191:    cpu_list_add(cpu);
>>
>> IMO the problem is with cpu_list_add(), we shouldn't expose the vCPU
>> until it is realized.
> 
> that was my reasoning as well
> 
>>
>> cpu_list_add() seems to be doing 2 things, auto-assign CPU index if
>> UNASSIGNED_CPU_INDEX, then insert to global cpus_queue.
>>
>> IIRC cpu_list_add() is called early because various cpu init code
>> expects cpu->index to be assigned.
>>
>> Maybe we could extract the 'safely assign an unique cpu index' part
>> (guarding by qemu_cpu_list_lock), having cpu_list_add() just add to
>> the global queue. I'll give it a try...
> 
> ok,
> lets see if we can postpone cpu_list_add() till the end of realize time.
> 
>>
>>>    
>>>> I guess we could assert:
>>>>
>>>>     g_assert(!current_cpu || qemu_cpu_is_self(cpu);
>>>>
>>>> as current_cpu should only be set as we go into the main thread. However
>>>> there is a sketchy setting of current_cpu in cpu_exec() that I'm not
>>>> sure should be there. Also do_run_on_cpu() messes with current_cpu in a
>>>> way I don't fully understand either.
>>>
>>> I'd rather not rely on that, even if it works it would be subject to
>>> to the same kind of breakage.
>>>
>>> How about instead of workaround check we would have 2 variants
>>> of tlb_flush_by_mmuidx[_async_work], one that have self check
>>> and other for usage externally (i.e. from reset handler).
>>> That won't have to rely on sketchy globals (which becomes more
>>> sketchy in context of Philippes's multi accel work),
>>> and it would clearly document what can be used externally.
>>>    
>>>>   
>>>>>
>>>>>      
>>>>>>> 1)
>>>>>>> Fixes: f0aff0f124028 ("cputlb: add assert_cpu_is_self checks")
>>>>>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>>>>>> ---
>>>>>>>    accel/tcg/cputlb.c | 4 ----
>>>>>>>    1 file changed, 4 deletions(-)
>>>>>>>
>>>>>>> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
>>>>>>> index b26c0e088f..2da803103c 100644
>>>>>>> --- a/accel/tcg/cputlb.c
>>>>>>> +++ b/accel/tcg/cputlb.c
>>>>>>> @@ -381,8 +381,6 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
>>>>>>>        uint16_t all_dirty, work, to_clean;
>>>>>>>        int64_t now = get_clock_realtime();
>>>>>>>    
>>>>>>> -    assert_cpu_is_self(cpu);
>>>>>>> -
>>>>>>>        tlb_debug("mmu_idx:0x%04" PRIx16 "\n", asked);
>>>>>>>    
>>>>>>>        qemu_spin_lock(&cpu->neg.tlb.c.lock);
>>>>>>> @@ -419,8 +417,6 @@ void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
>>>>>>>    {
>>>>>>>        tlb_debug("mmu_idx: 0x%" PRIx16 "\n", idxmap);
>>>>>>>    
>>>>>>> -    assert_cpu_is_self(cpu);
>>>>>>> -
>>>>>>>        tlb_flush_by_mmuidx_async_work(cpu, RUN_ON_CPU_HOST_INT(idxmap));
>>>>>>>    }
>>>>>>       
>>>>   
>>>
>>>    
>>
> 


