Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 726ACF47CBA
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 19:46:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyEeN-0005fI-9L; Thu, 05 Mar 2026 14:46:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyEdy-0005el-V3
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 14:46:00 -0500
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyEdx-0002Td-BO
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 14:45:58 -0500
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-89a15b9a556so36555126d6.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 11:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772739956; x=1773344756; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZPYfM+RJEqlCiXN3G5xHjI6cwz0fe/txt7bp8NG6Otg=;
 b=fbGYoLfMdhDWwuwurt5U4bnjm/iF/mT4DPSVZMFzyJmAzHNTl33ycWnhhFpET+Iy9n
 BvWygRyvHEGThVjVIWlvLyblUD/Z3TSf1+1KM6GvqOaed2bM04yB+G624QdfM0HOLmG+
 Rfc0QpLFqqLBci0a1UV2obV9fLR8c1NQSNxl4VE5ZEPcHJWXD8ifIsfhgnpZtBo+/X+/
 AFiyuMdecMMgcZ96Cb8IrVCPrYVhmy7uc437AW0LGUIaQm4GWIv1MM8hK2A9JzaRJxIy
 lTwW7YK1I9QbG5bXYbnut6LQWkT2nz4me4yTKn/Tlq/GBPz2wSpIeXD59mWNY/Cn+KLx
 OsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772739956; x=1773344756;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZPYfM+RJEqlCiXN3G5xHjI6cwz0fe/txt7bp8NG6Otg=;
 b=KQytSMYuy3V2F0XAsH5go/xb+zGQxfpORDowq0D4BTWiul/JxCpCYslgFSyuUBSdIX
 PdKRuaonsf4w3etpImIufVXR9ZsMc8A3t1Ng3pMGSeVn/0NgSvjNx7yuj2kEyMiOdd/z
 8eMXyRVLsKP2gsSso8LRl3kVNS4wzEu3geZHc1t8vW9FgU9RIF720ChkRZPqSQEvDFnu
 wDH0ToRxQh0sFOLxok6B5N0zP2JuzXdnWaHrn5oblwxqmXJdEpAHbVgQnMN1mEw80E/j
 sMkisPZoXN5C1X+Sc4KswvrSwuBVv2yUVPdNMXhI1DLC+rOwh/lHzVe3U6Zni30pY7Ri
 uIWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEvhdw+OhvW7Y9lPZAP8x9B6vmJmNDaHT30SY61dw0jL6nDY9dsxUIRs+mkznj3VhuQdZXXrkzTEeG@nongnu.org
X-Gm-Message-State: AOJu0YwFP1HWEZ+jjjO1W96oez3ewE8TaL29FDew7okb9WflG7ofkFOr
 Ul6hWGPv8/X9dUXoh8EvP6DxcKvXeuEHlLuWqWQIqvlamapIqhWLe59k8FKh5TjHfR8=
X-Gm-Gg: ATEYQzxfAamEZAY23CgDSp1kI+qt8I54D45dMXgLv4Md4LGOSFWFXHl09giDM8Hx1sM
 FB8P5kGFifpcP47WGXdmD0lqAIsVNyxikYejum97DRqJv/pNnJ03NNDXg4bj1qSuNKh0Ylh4R93
 xDKAAsEkqxxvmMpliIgdURbJqbfgRSGG3vIOtdB8KFjTQZjlZnQZN5IGrCplueGczohVUAp12Bd
 hSUFGpaq1PH41V67ExiBajMJszVD7APgqvs8SMZsf7Q6jjCAL4r5T2OIsfDxcf8/3QisfjFUkEl
 dPkfv2M+dPaLP8RxX5h8K94EPVzylTLoV4iRBWnoPhQn3wvK0trIV6PWFmaMVW09EL3oovUd1qT
 KITtWT8QhRT0pKvEoqZA04lCGEQ4GMhCZgvzUJ1EbQ/5xARHXoexcNRpFPSeA0VotSJueK1UP7i
 OPOUD/bwxSNwRGzEu96akYLCdSzHemzwwuRRTUx+TrsT3O7kiCe7mi1huwskPEbT4bUl63
X-Received: by 2002:ad4:5de3:0:b0:89a:64d:4b10 with SMTP id
 6a1803df08f44-89a19ab6640mr102079006d6.26.1772739955723; 
 Thu, 05 Mar 2026 11:45:55 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a20471119sm44609236d6.40.2026.03.05.11.45.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2026 11:45:55 -0800 (PST)
Message-ID: <ee0b3240-4939-4a6f-a6e7-5f2032bfc2ec@linaro.org>
Date: Thu, 5 Mar 2026 11:45:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: duplicating CPUs with memcpy() in cpu_copy() vs memory-allocated
 things in CPUArchState structs
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Laurent Vivier <Laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
References: <CAFEAcA9QAyZjjj4kXeC+wM4gg_C+U6Z7McYGrB9u=C1PbiaWZw@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <CAFEAcA9QAyZjjj4kXeC+wM4gg_C+U6Z7McYGrB9u=C1PbiaWZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f33;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qv1-xf33.google.com
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

On 3/5/26 9:47 AM, Peter Maydell wrote:
> In the user-only emulators we need to be able to create a new CPU
> object for a newly created thread that has the same state as the
> one in the parent thread. We currently do that in cpu_copy()
> in linux-user/main.c, which does:
> 
>      CPUState *cpu = env_cpu(env);
>      CPUState *new_cpu = cpu_create(cpu_type);
>      CPUArchState *new_env = cpu_env(new_cpu);
> 
>      /* Reset non arch specific state */
>      cpu_reset(new_cpu);
> 
>      memcpy(new_env, env, sizeof(CPUArchState));
> 
> plus some special casing for things in the CPUState (cflags,
> and breakpoints), and an ifdef for x86.
> 
> This makes several assumptions:
> 
> (1) nothing in a target's CPU struct is runtime state that needs
> to be copied across from the old thread's CPU
> (2) everything in a target's CPU env struct can be handled by
> a shallow memcpy() from the old to the new
> 
> Unfortunately (2) isn't true. The example I ran into was
> MIPS, which allocates a data structure pointed to by env->mvp.
> Copying the pointer from the old CPU means we leak the structure
> the new CPU allocated on creation. (We don't actually try to free
> this at the moment, but if we did try to free it we'd do a double
> free because both CPUs would be pointing to the same thing.)
> It seems likely that there are others too.
> 
> (1) seems on somewhat shaky ground too, especially as we don't
> document it.
> 
> There are a couple of ways I can see that we could try to fix this:
> 
> (A) We could insist that every target's CPUFooState (env struct)
> must be shallow-copiable, and anything that isn't (pointers, etc)
> needs to be moved out to its FOOCPU (QOM CPU object struct).
> Then we could let targets implement any per-target copying specifics
> in some function in linux-user/$ARCH/ that we call from cpu_copy()
> after doing the memcpy(). This would be painful if there are any
> targets that have something non shallow-copiable that they want
> access to directly from generated code, which has the env pointer
> but not the CPU object struct.
>
> (B) We could standardize the "end_reset_fields" convention that
> some targets have in their env struct, where an empty struct
> marks the end of the point in the struct where fields can be
> reset by zeroing them. If they can be reset by zeroing they can
> also be safely shallow copied with memcpy(). We could then let the
> target handle anything else via some target hook as above.
> This would require a lot of targets having this field marker added,
> which could be a pain if they don't have their structs ordered in
> a convenient way for this.
>
> (C) We could say that trying to write generic code that can
> copy a target-specific structure is a fool's errand, and require
> the targets to implement it entirely themselves (only copying the
> stuff in the common CPU base class in common code). If a plain
> memcpy() works for them then their implementation can be simple.
>

This sounds good, as it's the only approach we can really enforce, by 
adding a mandatory clone_cpu operation per target. This sounds better 
than a "partial" clone operation mentioned above.

To ensure it keeps working, we could add a static_assert on cpu size 
with a fixed constant directly in clone. This makes sure that when 
people add fields they have to update this clone_cpu op accordingly 
also, by changing the size and optionally deep copy the new field.

> Any preferences ?
> 
> thanks
> -- PMM


