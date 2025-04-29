Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C211C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 19:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9qbT-0000Ux-Bi; Tue, 29 Apr 2025 15:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9qbL-0000TZ-4H
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 15:26:44 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9qbA-00079u-Dw
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 15:26:41 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2241053582dso97178875ad.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 12:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745954788; x=1746559588; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/O19AlcHMZzbYK2Ik+ngm9BgChd/KFoIBFIV788FIVo=;
 b=Qa7LbWuYa9EF7+HSYe5aGHW4Jgi+jLMH15KJMtkN+2L6e/RW32UvZuPbn83CoY2QiI
 g5pSRj8l68g4N6aSHvGvFL21Qv/uw0oOqtAxsXvIhd1QD2D3pB2xtvxwJ4vcKbz6PnSU
 K4DFso1Y2g8mmDF+kax3Spgm6Eot9q5zcpVT4BUyVEebVsqZtCWNYT3USH2PuVMpzSN7
 soKvTYpebd2i9HtLEQiXlfozlFG9j2KjRpgd0kPDmsGTKpzosNm8/EKL+xMax2EY9zCF
 3GlF6e4I/Quk0cva2YzGNoVvAX9veHsn7RWo9leYOOuboAobNJj78nSB2QqQRrjHvx1w
 sGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745954788; x=1746559588;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/O19AlcHMZzbYK2Ik+ngm9BgChd/KFoIBFIV788FIVo=;
 b=FJvlh2jqOskj5uyqJkb+GyjJYPvzdw/OLrJ3Fth6WQWhFCyEx+zgPp3eFe7k2ab/zd
 UvXLGKVsGsdU3bjX3N61M7K5y6vyN4DKR50bpwYO8Pn2r/hiNj9Zuyzf4blUxCFTXLdP
 4aSkWDRGDwsTsRUE597R66TsSXqgmUsvFFpq9p5S1GbzGxes6N0dBwEehBAl0LL7lJek
 YQ36vCENJyxcWLdO3ONvWNyYzNP0qJergQI6D2c2ec3F9AZuPsR07XE9sOOueJVX3PZz
 vCZdM9YPaNJBCI7kqxBbgsTQcg583QR3HEhW5PBOAvzt0/qpgAiVLC50ky7FjssiHc9l
 fFVg==
X-Gm-Message-State: AOJu0YxrIYgSDdHqZYfwfjshvhZDjcid+JXWWvPazQB7nCraQykixFik
 WTdPcbNthQQ7McZj5GrnDv8EPhCEkkw2ngnskF8m52wSgCPn7hmwY12taCeoLU0=
X-Gm-Gg: ASbGnctlCu+1wihwxMdcZnuW3itVfqBnaVLSTrlj/jljbhFczo/lGJvIxOCbmVGwd7F
 y7VH7xjpV/SZAoEkNu1j0g4zMfIHEs2sXvbxr6fP0ROPCSPh93xY1EfI36PIq9xv/vFTKc3Mgzr
 2rQAo3fHdiizLgd9jhHyR2nSn8QtjVRpx8Za7n+vOYAYVsPW0rhjZMEJCYYlWBsNa0HxPWWaMM3
 U6ZR/9jbRr6EtLNqRmbCtv0CXaiztJQTBGh1sDSJ4vWtyBH5R3BZKp2/QoGyPQ5yCw+AXqaBvqi
 oul2Xb2NAaH1hKt4S3SmQ2XH+BYFJxYXHPlERlpnPqR5cQFyW7hMpw==
X-Google-Smtp-Source: AGHT+IHu3xJnLNV3KYj80N5textWM82c0J/s3c6aNeJ/Ds2BhR0aW/yro0V7hZwPi48wucY78JBP/w==
X-Received: by 2002:a17:903:120e:b0:21f:f3d:d533 with SMTP id
 d9443c01a7336-22df34a9e6amr8148945ad.2.1745954787976; 
 Tue, 29 Apr 2025 12:26:27 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db52218b5sm106744155ad.256.2025.04.29.12.26.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 12:26:27 -0700 (PDT)
Message-ID: <5169459d-4109-4213-9017-9f46a72b7a08@linaro.org>
Date: Tue, 29 Apr 2025 12:26:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, stefanha@redhat.com, 
 Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com,
 peter.maydell@linaro.org, thuth@redhat.com, jsnow@redhat.com,
 philmd@linaro.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 devel@lists.libvirt.org, Victor Toso <victortoso@redhat.com>
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
 <87a584b69n.fsf@pond.sub.org>
 <5b21965d-2428-454c-9dd7-266987495abd@linaro.org>
 <87a583789z.fsf@pond.sub.org>
 <25bb4527-f145-4d9c-8f91-a962bfa14a6f@linaro.org>
 <8734drpg4j.fsf@pond.sub.org> <aBCPrqggooxF6Z1w@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <aBCPrqggooxF6Z1w@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

On 4/29/25 1:37 AM, Daniel P. Berrangé wrote:
> On Tue, Apr 29, 2025 at 09:43:24AM +0200, Markus Armbruster wrote:
>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>>
>>> After looking at the introspection code, I don't see any major blocker.
>>> We need to keep some of existing "if", as they are based on config-host,
>>> and should apply.
>>> We can introduce a new "available_if" (or any other name), which
>>> generates a runtime check when building the schema, or when serializing
>>> a struct.
>>>
>>> This way, by modifying the .json with:
>>> - if: 'TARGET_I386'
>>> + available_if: 'target_i386()'
>>>
>>> This way, we keep the possibility to have ifdef, and we can expose at
>>> runtime based on available_if. So we can keep the exact same schema we
>>> have today per target.
>>
>> The name is ugly.  Naming is hard.  No need to worry about it right now.
>>
>> Semantics of having both 'if' and 'available_if'?  To work out an
>> answer, let's consider how to convert conditionals:
>>
>> * 'if': STRING
>>
>>    If STRING is a target-specific macro, replace by 'available_if': PRED,
>>    where PRED is the equivalent run-time predicate.
>>
>>    Else, no change.
>>
>> * 'if': { 'all': [COND, ...] }
>>
>>    If COND contains only target-specific macros, replace by
>>    'available_if': { 'all': [PRED, ...] }, where the PRED are the
>>    equivalent run-time predicates.
>>
>>    If COND contains no target-specific macros, no change.
>>
>>    What if it contains both?
>>
>>    - If each COND contains either only target-specific macros, or no
>>      target-specific macros, we could split the target-specific ones off
>>      into an additional 'available_if'.  This requires defining the
>>      semantics of having both 'if' and 'available_if' as "both conditions
>>      must be satisfied".
>>
>>    - What if this isn't the case?
>>
>> * 'if' { 'any': [COND, ...] }
>>
>>    Similar, but to be able to split the COND we need "either condition
>>    must be satisfied."
>>
>> Even if we can make this work somehow, it would likely be a royal mess
>> to explain in qapi-code-gen.rst.
>>
>> We currently don't have "mixed" conditionals.  So we could sidestep the
>> problem: you can have either 'if' or 'available_if', but not both.
>> Feels like a cop out to me.
>>
>> What if we move the "is dynamic" bit from the root of the conditional to
>> its leaves?  So far, the leaves are macro names.  What if we
>> additionally permit a function name?
>>
>> Function name, not C expression, to not complicate generating code in
>> languages other than C too much.
>>
>> Ignore the question of syntax for now, i.e. how to decide whether a leaf
>> is a macro or a function name.
> 
> I wonder if any of this is worth the pain in practice.....
> 
> 
> Looking at the QAPI schema, we apply TARGET_xxxx conditions either to
> commands, or to structs/enums that are used in args/return of commands.
> We don't conditionalize individual fields, etc.
>

CpuModelExpansionInfo.data.deprecated_props is a conditional field, and 
seems to be the only example.

Anyway, in terms of code generated, it's not a very big difference 
between conditioning a complete struct or one of its field.

> I tried to query our schema with 'jq' (incidentally rather tedious
> because of our JSON-but-not-JSON language[1]). If I select only
> commands we get:
> 
> query-cpu-definitions          => currently many arches
> query-cpu-model-expansion      => currently many arches
> query-cpu-model-baseline       => currently s390x only
> query-cpu-model-comparison     => currently s390x only
> query-s390x-cpu-polarization   => inherently s390x only
> query-gic-capabilities         => inherently arm only
> query-sev                      => inherently x86 only
> query-sev-attestation-report   => inherently x86 only
> query-sev-capabilities         => inherently x86 only
> query-sev-launch-measure       => inherently x86 only
> query-sgx                      => inherently x86 only
> query-sgx-capabilities         => inherently x86 only
> rtc-reset-reinjection          => inherently x86 only
> set-cpu-topology               => inherently s390x only
> sev-inject-launch-secret       => inherently x86 only
> xen-event-inject               => currently x86 only
> xen-event-list                 => currently x86 only
> 
> The two Xen commands are currently limited to x86, but if we ever extended
> Xen to arm, possibly they would make sense. IOW, conceptually a target
> conditional might be useful in future.
> 
> The CPU model commands are the ones where having the target conditions
> visible in schema appears to add value, in that they'll allow a mgmt
> app to detect when we extend any of them to cover new architectures.
> 
> 
> Libvirt (and other mgmt apps) want to query the schema to see if commands
> exist in the QEMU they're using, before trying to invoke them. To some
> degree this is just a "nice to have" that improves error reporting/detection.
> 
> 
> For the commands that are inherently arch specific, the mgmt app should
> conceptually already know what architectures these commands apply to.
> These target conditionals provide little (no) value when probing commands
> in the schema.
> 
> IOW, if we (for example) have a single binary for x86 and s390, it should
> be harmless if we report that 'query-sev' exists regardless of arch, as
> the mgmt app should none the less already know to only use it with x86.
> 
> I don't know if libvirt correctly filters based on architecture in the
> case of SEV/SGX/GIC/RTC when probing & using these features, but if it
> does not, then I'd consider that a pre-existing bug that should be fixed.
> 
> Libvirt doesn't use the Xen commands.
> 
> For query-cpu-model-comparison/baseline, libvirt already filters its
> usage of these based on s390 arch, so even if x86 reported them I
> believe it won't break libvirt today. If these commands are extended
> to other archs in future, libvirt might want a way to detect this.
> On the flipside it might not be the end of the world if we just expose
> them on all arches and simply have them return an error at runtime
> where non-applicable.
> 
> 
> IOW, while the target conditions could theoretically provide value at
> some point in future, it does not look like they do anything /today/
> for libvirt.
> 
> Given that I wonder if we shouldn't just ignore the problem, and
> blindly remove all TARGET_nnn conditions from QAPI schema today. Let
> our future selves worry about it should this prove insufficient later.
>

If all the QAPI devs and maintainers are happy with it, I'm fine with it 
also. That said, CONFIG_KVM will still be an issue as well, because it's 
a target specific define, so please make sure it can be removed safely also.

I can offer to make a prototype adding runtime checks to preserve the 
same schema, list of commands registered, and identical marshaling 
functions. If you decide to just drop all those conditional, it's even 
better, and faster, I'm good with it. My only goal is to compile QAPI 
generated code only once, no more, no less.

> 
> With regards,
> Daniel
> 
> [1] To use QAPI JSON with 'jq' you must convert ' to " and
>      strip comments. eg
>      
>        cat *.json | sed -e "s/'/\"/g" -e 's/#.*//' | jq ...expression...


