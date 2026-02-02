Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282C5E7DF0F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 17:51:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmy4x-0006Yt-D8; Mon, 02 Feb 2026 12:51:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vmy4v-0006Ye-3I
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 12:51:13 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vmy4t-0007kU-AQ
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 12:51:12 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-82307c6902eso2416419b3a.3
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 09:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770054670; x=1770659470; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=KO/rnuJ24aB3f6jvq/AZtR0U+LPwI9pkjxsjSloE+G8=;
 b=eu8tuWMj02g025YlHYb9CumAZlKNjwD2fI16nXS87+Z1iQOFV88IG61qcYXn43Gi51
 Y5NsgC3WwFOPP8y12mqskso9+dWllo4QtjDSb2Hd8DKi9Wt0DGIa05XbJMeYE0N5+RNP
 LZFJbCe2Cv4x1gt9TcWVKcCZsUXvXc4VbtEW6bCn272b8ZBa3Rza2w+Eoqe0YhHhSeMD
 7LEasm2v3Zxz6B30janbei5kdjS4/th5WV+2O3VezRVVBNT835OB0ORgp2Ird9zxHkR+
 AhhNN6bh5wcg+3LwmjY1KsjRNrUEyIKI/s63hrzjUUQMADretwv5Ae9EJZNJJszL7fr0
 4hJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770054670; x=1770659470;
 h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KO/rnuJ24aB3f6jvq/AZtR0U+LPwI9pkjxsjSloE+G8=;
 b=VLHcKviNDlCvZiGMTgvSNNBBN8giakoGpAzB3xusJ4HL4CsMLrAMMkKnMpy9R+Da2J
 ksWzjoqnhm9JIBBW5rrRvYYOIPJsJsNsBaLdovFTW4hJRX4QijsdXT2Pw8WyCVqw0yDm
 yikTuXFAR4LBJYnM6u0NoqCbzJ0MRhyYXki8xamIDkMQhtNNxHWAfOLbG+m49EoxT1xM
 Im6aS6dVAFcVAtjU0sKL72VUewRFzn5JUFMJ8rKeNq9mctkhTBapR9Fl97KnieZvirWI
 UJsZ8oFvUNKY+VYcA+D3kNSaywj4N5v/GAR5JDWzJA/WVzb22KgPZw23yukJ98rwrdLO
 dQiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6NhFt+imFlbtGpJ+zN2VHeLSvTT9e1n4NdHLZ37S3fS3uGUXClyHVdXqr617BQQVGMJpR//ZvP9NJ@nongnu.org
X-Gm-Message-State: AOJu0Yykhawofye74HKTAN0ltgWWPgNpL38kUX3aJISWt35QdTKgMI8G
 xBKIPBF1edTi0Eh+EgPZDIBtlKDpQ5YzHMjrlhiEqjOHhnIbapqpsYDPPJSu/FLRbX0=
X-Gm-Gg: AZuq6aJdgsGy9BWRPXYhuLh065qqJGOVSZTEK8RkNIqQgRcET/SRk6mLk5kao1lMXgC
 u6Zy86Lb6RVx9rvi/i3X6743g8B/1gds+b/9wpYCTatjqs3lUCLPMWhJzWtIxkauGdKuF7gRvj9
 6fM15zOah0gbagHa3y3OHA3ZsGMQVAw/YHqlniyPPUudaflFMIB/oYrPJQVcqjVJT6+mCFq92zP
 5hZpHAlPqK67EukEs/ZcpYS2oZB2v87AFeWrJaVWhLdDIObGH3veHKwDX+RROQUToVIZkJ6W2Yj
 NpcL046Jhfbh/6KuNNiXMSEcVzpHmDkd1Zd/yYuvS5yPn2DB1FNd4jyKVSKr8S508n5+grcB2R+
 UVLf7F4hx37wzxoS2I7fLU/bzR13kl0BHfP59WvmUqowUZeJB2VxBfY+Rg6vwHXhPJoCiJ1yh3o
 XMgZVysbY17QE3z+Vxgv3UgApiYzGqYQ7eUEcdkAQnyhInUdDrgHbotpGI
X-Received: by 2002:a05:6a00:ad1:b0:81b:ab6f:2974 with SMTP id
 d2e1a72fcca58-823ab65ee90mr10397643b3a.9.1770054669490; 
 Mon, 02 Feb 2026 09:51:09 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379c5293dsm15986056b3a.61.2026.02.02.09.51.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 09:51:08 -0800 (PST)
Message-ID: <7c37f58b-243a-4915-ad6e-e4b6b12a64a0@linaro.org>
Date: Mon, 2 Feb 2026 09:51:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/21] Plugins patches for 2026-01-29
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
 <2d69de6e-da9f-4f90-b805-9553bb72c78d@linaro.org>
 <7ac8fe1f-8098-4417-a97b-1a82c0fd23ca@linaro.org>
 <CAFEAcA_zghZeA0PzivCY9vCcFk6rVLwvP3in35rA=bF8yrdeyQ@mail.gmail.com>
 <878qdbtam7.fsf@redhat.com>
 <23be2c83-01ea-495d-b14e-496bd3e0a687@nutanix.com>
 <bd097ad0-d18e-42fc-9746-db4d448b71fa@linaro.org>
 <aYDgONbUOWdUi7SO@redhat.com>
 <416762ea-471d-4e7d-8e02-d350c01dc8fd@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <416762ea-471d-4e7d-8e02-d350c01dc8fd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

On 2/2/26 9:45 AM, Pierrick Bouvier wrote:
> On 2/2/26 9:34 AM, Daniel P. Berrangé wrote:
>> On Mon, Feb 02, 2026 at 09:30:31AM -0800, Pierrick Bouvier wrote:
>>> On 2/2/26 8:55 AM, Mark Cave-Ayland wrote:
>>>> On 02/02/2026 15:42, Cornelia Huck wrote:
>>>>
>>>>> On Mon, Feb 02 2026, Peter Maydell <peter.maydell@linaro.org> wrote:
>>>>>
>>>>>> On Mon, 2 Feb 2026 at 04:04, Richard Henderson
>>>>>> <richard.henderson@linaro.org> wrote:
>>>>>>>
>>>>>>> On 1/30/26 04:41, Pierrick Bouvier wrote:
>>>>>>>> On 1/29/26 9:37 AM, Pierrick Bouvier wrote:
>>>>>>>>>            contrib/plugins: add empty cpp plugin
>>>>>>
>>>>>> Hi; this fails to build for me on Linux (Ubuntu 24.04) with clang:
>>>>>>
>>>>>> In file included from ../../contrib/plugins/cpp.cpp:33:
>>>>>> /usr/bin/../lib/gcc/x86_64-linux-gnu/14/../../../../include/c++/14/coroutine:38:3:
>>>>>> error: "the <coroutine> header requires -fcoroutines"
>>>>>>        38 | # error "the <coroutine> header requires -fcoroutines"
>>>>>>           |   ^
>>>>>> 1 error generated.
>>>>>
>>>>> Fails for me as well on Fedora 42 (x86_64) with gcc:
>>>>>
>>>>> In file included from ../qemu/contrib/plugins/cpp.cpp:33:
>>>>> /usr/include/c++/15/coroutine:43:3: error: #error "the <coroutine> header requires -fcoroutines"
>>>>>        43 | # error "the <coroutine> header requires -fcoroutines"
>>>>>           |   ^~~~~
>>>>>
>>>>> (It works for me on an aarch64 RHEL 9 system.)
>>>>
>>>> Is this with a clean build? I had exactly the same error message
>>>> earlier, but I was able to fix it by destroying my build/ directory,
>>>> then re-running configure followed again by make.
>>>>
>>>
>>> Thanks for the reports everyone.
>>>
>>> I tried it on ubuntu LTS and didn't encounter this problem.
>>> What is happening is that meson unfortunately caches default_options set,
>>> including the C++ standard version in our case.
>>> Thus, you indeed need to clean and rebuild once.
>>>
>>> The solution for this would be to not use default_options and add the flag
>>> to qemu_cflags instead. It's the same limitation if we change the default
>>> warning level, or any other option set with default_options.
>>
>> If that's correct as the root cause, then it feels like this is a meson bug
>> that ought to be reported upstream. Any meson.build default_options changes
>> that affect the compiler behaviour should invalidate cache in the same way
>> as when we modify qemu_cflags.
>>
> 
> I totally agree with you Daniel, and I've been bitten by that in my
> previous company when updating cpp standard we used. As you can see, it
> slipped out of my mind for current series...
> 
> I never understood why it had this counter intuitive behaviour, and
> didn't bother to report to be honest, I simply switched to manual flags
> instead at the time.
> Meson devs usually have a strong opinion of how things should be, so I
> don't expect this to be something that fell through the cracks but a
> deliberate design choice.
> 
> EDIT: after typing the answer above, did a quick search, and indeed,
> it's how it's supposed to be. So be it.
> https://github.com/mesonbuild/meson/issues/13556
> 
>> With regards,
>> Daniel
> 
> Regards,
> Pierrick

Paolo, since it seems complicated to change this in meson, should we at 
least remove C and C++ standard from default_options, and rely on manual 
flags instead?

Probably, same goes for rust standard when we'll have to update it to 2024.

I'll let you (or anyone else on the thread more legitimate than me) 
judge what's the best approach on this, and I can help to implement it 
if needed.

Regards,
Pierrick

