Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B83CFA44E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 16:40:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3eOE-0003Kt-65; Wed, 23 Oct 2024 12:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3eOB-0003Kh-0P
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 12:39:15 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3eO8-0008M2-DX
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 12:39:14 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-71e5a62031aso15272b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 09:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729701551; x=1730306351; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qVSz9wNSysxrD7d7eBiooDLhZIsVmuTftLpM/dBL4CE=;
 b=GguS3gezgNs+186tJ9pOlHf8UD0Q5vLFc2FGMIlxtOy2eb5sE7G4Zq0YwyUDbyGgzC
 c4OXtZOore1DSVszGe9Yhmy3nckxDuMfUNZLcip8sLtA/YHHn7BROQon95iU4hw6burx
 ujMa/6wLJ0gs68BtO366aHCFdaQYV3AzxbjQ08AAeMTx1Piphbkby+50KQED2pVtySVZ
 vKqxiKK5adII/LAAmXeYYyC4PfqpYrNfxI6xprm4SurJ2ujbTrHadNr7MSLV5Ksqwsdg
 kMqrTqJ4przzouccR1gaakeIAbYcOPZJVf9hgNv4c91YnemIPO6b54EINsOXKQv/bOf/
 nE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729701551; x=1730306351;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qVSz9wNSysxrD7d7eBiooDLhZIsVmuTftLpM/dBL4CE=;
 b=dfecLzD6Ld5F0+6IMcyGLUW+rXzZOEzb+UHQ1Bpr9pegxrQBCeuPlDKdjV8A0Bv4Q2
 RBHY8dOiVI4LfO0xirGk1MTdsJOJcGyq9Rxpw6M+Yo88+PZqOQSJwBJ4vb2AVvDSk8Tw
 K3ElL85F34rmkV+EzjB+nLeI3obnK0K/N4d76Mh5QQEkShwXmaVDdeVXbB2LJosWl5FC
 yrF4pidlp/rj5tpIWcQ1VnmnDhBicUAQeOJZ+9Agc6AC307orgMqvaGadwa9y9YX6Gju
 57gA8+OenktxMn+EVX4OVQbefsGfHVZlDYIqiN/yb1aLuAvds1ZT5FnCzr3mpornV01B
 EK1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7AJ1vXKF6s1uncfFe0uN2hV+VHlnfznwTmFGH/w2gwoG+mrjFVu6oHxJJE2OA8MIhe2AUGVt/9QX6@nongnu.org
X-Gm-Message-State: AOJu0Ywf6tDW9HsrnDX6IQa+EsI7tmw5fGDIEu//oa/vvPKsJ6WyUt0F
 TGdKvDk56DER9YQkPfV23XQrvMm0RUfsW5Lt++7BsB5WQwRxaZxSXJlecjGsOkGzwRo8HTbyg53
 v1qFvdQ==
X-Google-Smtp-Source: AGHT+IHGZdxj/Be+4mCUkUdv/FwyQEeqCpvBhXrUNYoINikB/rfxTvsQ+AFtGtRr8t4gua5OcZx+2A==
X-Received: by 2002:a05:6a00:a95:b0:718:ea3c:35c3 with SMTP id
 d2e1a72fcca58-72030c10961mr4633057b3a.15.1729701550751; 
 Wed, 23 Oct 2024 09:39:10 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec1407f4asm6486715b3a.207.2024.10.23.09.39.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2024 09:39:10 -0700 (PDT)
Message-ID: <31c78f6d-7154-41c5-be46-3ca4974fc6f4@linaro.org>
Date: Wed, 23 Oct 2024 09:39:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/7] tcg-plugins: add hooks for interrupts,
 exceptions and traps
Content-Language: en-US
To: Julian Ganz <nenut@skiff.uberspace.de>, Julian Ganz <neither@nut.email>,
 qemu-devel@nongnu.org
References: <20231021122502.26746-1-neither@nut.email>
 <cover.1729355735.git.neither@nut.email>
 <fad67d3f-5b8d-45f6-a1aa-666852a0dad4@linaro.org>
 <8929cd79ce653b55e7cb166300782cb13727da3b@skiff.uberspace.de>
 <f7e574bb-a780-4f5b-a511-ab9f0aa86f31@linaro.org>
 <ab29d100610abcc59ce2305a1ace1ac0b53340a3@skiff.uberspace.de>
 <2419ec6e-3d4e-4d6d-a738-7615c99ed60c@linaro.org>
 <0696c7fc52d1d58002f0a8be7e7502f57fd61d24@skiff.uberspace.de>
 <28f647ca-0b88-4a01-90d3-4cc4450e0d1d@linaro.org>
 <fd9c687a05ccdcdf5a589a15fcecb38074da7c1d@skiff.uberspace.de>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <fd9c687a05ccdcdf5a589a15fcecb38074da7c1d@skiff.uberspace.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

On 10/23/24 09:12, Julian Ganz wrote:
> Hi, Pierrick,
> 
> October 23, 2024 at 5:16 PM, "Pierrick Bouvier" wrote:
>>
>> Hi Julian,
>>
>> On 10/23/24 05:56, Julian Ganz wrote:
>>
>>>   October 22, 2024 at 11:15 PM, "Pierrick Bouvier" wrote:
>>>
>>>>
>>>> On 10/22/24 01:21, Julian Ganz wrote:
>>>>
>>>
>>>   Ok, I'll introduce an enum and combine the three callbacks in the next
>>>   iteration then.
>>>   typedef struct {
>>>   enum qemu_plugin_cf_event_type ev;
>>>   union {
>>>   data_for_interrupt interrupt;
>>>   data_for_trap trap;
>>>   data_for_semihosting semihosting;
>>>   } qemu_plugin_cf_event;
>>>   /* data_for_... could contain things like from/to addresses, interrupt id, ... */
>>>
>>>   I don't think this is a good idea.
>>>   Traps are just too diverse, imo there is too little overlap between
>>>   different architectures, with the sole exception maybe being the PC
>>>   prior to the trap. "Interrupt id" sounds like a reasonably common
>>>   concept, but then you would need to define a mapping for each and every
>>>   architecture. What integer type do you use? In RISC-V, for example,
>>>   exceptions and interrupt "ids" are differentiated via the most
>>>   significant bit. Dou keep that or do you zero it? And then there's
>>>   ring/privilage mode, cause (sometimes for each mode), ...
>>>
>>>>
>>>> I didn't want to open the per architecture pandora box :).
>>>>   I don't think the plugin API itself should deal with per architecture
>>>>   details like meaning of a given id. I was just thinking to push this "raw" information to the plugin, that may/may not use architecture specific knowledge to do its work. We already have plugins that have similar per architecture knowledge (contrib/plugins/howvec.c) and it's ok in some specific cases.
>>>>
>>>   But how would such an interface look? The last PC aside, what would you
>>>   include, and how? A GArray with named items that are itself just opaque
>>>   blobs?
>>>
>> I was not thinking about a new interface for this. Having the "raw" interrupt id is enough for a plugin to do useful things, by having knowledge of which architecture it's instrumenting.
> 
> But what is would the "raw" interrupt id even be for a given
> architecture? I don't think you can answer this question with "obviously
> this _one_ integer" for all of them.
>

Choosing interrupt id as an example of what we want to include was 
confusing, and brought more conversation than I expected.

I wanted to point that we may want different data per event, instead of 
talking specifically of interrupt or per architecture specific data.
To still answer you, I was thinking sharing interrupt number for x86_64, 
or interrupt id for aarch64. It's probably too naive, so let's drop this 
and move on :).

>>>
>>> And what would be the benefit compared to just querying the respective
>>>   target specific registers through qemu_plugin_read_register? Which btw.
>>>   is what we were going to do for our use-case. Even the example you
>>>   brought up (howvec) uses querying functions and doesn't expect to get
>>>   all the info via parameters.
>>>
>> You're right, but it's because it's querying instruction data.
>> I may be wrong on that, but at translation time, we may or may not be interested in accessing tb/insn data.
>>
>> However, for control flow analysis, beyond a simple counting plugin, we probably want to access further data almost everytime.
>>
>> I see it closer from syscall instrumentation, which pushes the syscall id, and all register values, instead of letting the user poke it. Makes more sense compared to that?
> 
> Yes, but then you are in "GArray of named, potentially complex value"
> terretory again. And the comparison with syscalls also falls apart when
> you consider that, for syscalls, they are well defined and enumerated
> identically for at least a variety of targets, while the same kind of
> "enumeration", if it even exists, is in completely different order for
> every architecture.
> 

We can restrict to having from/to PCs for now. Mentioning interrupt id 
as example was a mistake.

>>>
>>>>
>>>> But having something like from/to address seems useful to start. Even if we don't provide it for all events yet, it's ok.
>>>>
>>>   Yes, I certainly see the advantages of having either the last PC or the
>>>   would-be-next PC as they are sufficiently universal. You can usually
>>>   retrieve them from target-specific registers, but that may be more
>>>   complicated in practice. In the case of RISC-V for example, the value
>>>   of the EPC differs between interrupts and exceptions.
>>>
>> To the opposite of interrupt id, a PC is something universal by definition, and with a single meaning across architecture. However, accessing it by name varies per architecture, and even per sub events, as you are stating for RISC-V.
> 
> Yes. And for that very reason I would not pass "the EPC" to a callback
> but a clearly, target agnostic, defined value such as:
> 
> | The PC of the instruction that would have been executed next, were it
> | not for that event
> 
> or
> 
> | The PC of the instruction that was executed befroe the event occurred
> 
> And unlike interrupt ids, the plugin API already has a precedent for
> what type to use: uint64_t
>

Looks good. As said in previous message, we can drop the complex data 
type idea.

So we could have something like:

/* plugin side */
void on_cf_event(qemu_plugin_cf_event_type, uint64_t from, uint64_t to) {
    ...
}

/* API side */
void qemu_plugin_register_vcpu_syscall_cb(
qemu_plugin_id_t id, qemu_plugin_cf_event_type type, 
qemu_plugin_register_vcpu_cf_cb);

We thus would have a new callback type qemu_plugin_vcpu_cf_cb_t added.

For registering several events, we might define enum values for types 
indexed on every bit, so we can directly xor the enum to register 
several types. (same idea than existing qemu_plugin_mem_rw, but for more 
values, with a specific ALL value covering all possibilities).

Does that match what you were thinking?

> Regards,
> Julian

