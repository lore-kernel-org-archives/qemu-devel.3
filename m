Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C76E9D831
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 04:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9bsd-0002xu-Cb; Mon, 06 Apr 2026 00:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9bsb-0002xj-R8
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 00:48:05 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9bsZ-0000Xc-Hf
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 00:48:05 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-82ce0a9b41aso1255892b3a.0
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 21:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775450881; x=1776055681; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OvwyQg64EefvUc3AU2ohy1XZ07nTTDKha/8JpySkndc=;
 b=JUgPlLVLG0rGtm051vjhE9SDQeKvSUKmhCMl1HVUFrX36rKNQ3Jfa999yA/ettv5lV
 w4klS4t1SIaJmb7r9Grlz71rBECDnfSh04+XkbC3vka4ySi1jJNlwhd1ScS8tvWLMo3q
 mNkWCz5xBDMNhyTyuDyWcoYJ98D9K7E36DLiUTmiCCAiUwawKXKT2bH3qDE+fp5pXkZS
 Qw48gPU48XwFADdhum00+ux8zx+FdU5L8UD/VQOph8tnqZx+ROM+bXAjkOSlXPzLUPr7
 PZi1B1sylEgZS0/yonc2SqVoeG9WktOqVJgv8wUlEvPdj4XgfBeLJoSYcmk6pdGySd8b
 QPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775450881; x=1776055681;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OvwyQg64EefvUc3AU2ohy1XZ07nTTDKha/8JpySkndc=;
 b=DCczRc20UJsCZtNCbvNmy18Q96XEZcZORlLL9EQXZz1m74JM/4foGfaqkKk0Hius3i
 Qm6BHjEIJxiD+AvgadmwD1T6xjEGjwdzAyS/C2+9yvccHzTbR88NlG1bviBGOO9L1u/d
 tzIl2jnUA9TeTUAw1jKmG3mR0t++ckQzzumJ99JcGfJiGLmp9LITgHtsel32MSNUYPGk
 Z5ezriXPZwIBC8N0d4JdtvdgpsT9z8uNpZwjxCM4JItYgNv9eOPVXsmQM0BbMTfuSgDf
 adScveUDuZSaeqCOEMH2MOV7BmwqJvu49o9DszvOpncaSP2l8v7Xa6In3Pwl1KsUn7Dy
 bjcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2gEOiewF46kvQZ3N9ZKCuG88mfxcjOnermQ5Gv7JK6wb1xN8UibapWw6SFytB5kA6qCubIVSGYuBj@nongnu.org
X-Gm-Message-State: AOJu0YxuMLC+2xzpQe5FZgkeC07bcxkks5E6wzxrwzzoJ3ACRjSIwrud
 oMgoE6EDkrVjZUBfjcTb3f46Uh9MGJ5AbCt7OOI+scVMTDh1RNk1VNhlJl05X5c5jdU=
X-Gm-Gg: AeBDiesZIfKaGm1Kq7w+DH5tWX3q8LZY87n6e4OJV6JsTwIKM0WqGLthb7HAJ7CftzU
 NwcR8DtLlGMl5bD87jv4wnBi2Nx9KncVd4DRw41YlxGDaZB8bfTOOsJu4TQ311pjRzDWbAg5GRW
 8fkkbhcCjqvsqb3LK9qlYkQ14ImHmpTkw51fGQgR68EHppQb7dNYQfjv6EcJfFKAjIqL9fbgZmd
 84QqUlxJhMZMFo2lkCDZPsTkwhO3BuZyettpD46QoY966hh3IKLQYHkRzqr2HRYcR4fDYkjKcbY
 2bprdt3rS7unFa77YoGbOUllpKXfmQiS0nKy5NgmI1jqE2+fhRvZeSu9R2/Ykn3FUV4IoEr6J/g
 3tGIptRk7w0p2euYSAfdZWyZfnFTArQweS7f092u2Whdl+nQc3+3YipQB05hFVyqqmgetJl9DqD
 3IZI4rdjdsFnnUuqfLV4vlH0XJW9BvazCHoyLuQlF1vzU6C6Ut1Eya1ZzJyxEKpPnsaGwPWlKcU
 ufhdbjf
X-Received: by 2002:a05:6a00:3021:b0:82a:7f1a:758c with SMTP id
 d2e1a72fcca58-82d0da45d1cmr9451644b3a.11.1775450880893; 
 Sun, 05 Apr 2026 21:48:00 -0700 (PDT)
Received: from [192.168.1.168] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b261b6sm14983278b3a.3.2026.04.05.21.47.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Apr 2026 21:48:00 -0700 (PDT)
Message-ID: <33ec528c-30e7-4d77-a9ef-c29c00aedc26@linaro.org>
Date: Sun, 5 Apr 2026 21:47:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.1 00/10] Deprecate the qemu-system-i386 binary
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20260402095132.29245-1-thuth@redhat.com>
 <CAFEAcA8EyCn83zEcysm=4Py-BsQKSBV0KcBUMjMm4Df-pF2BoA@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <CAFEAcA8EyCn83zEcysm=4Py-BsQKSBV0KcBUMjMm4Df-pF2BoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

Hi everyone,

On 4/2/26 4:20 AM, Peter Maydell wrote:
> On Thu, 2 Apr 2026 at 10:52, Thomas Huth <thuth@redhat.com> wrote:
>>
>> This is a follow-up to my 3-years old patch series here, now with the
>> universal binary initiative in mind:
>>
>>   https://lists.nongnu.org/archive/html/qemu-devel/2023-04/msg04541.html
>>
>> This patch series allows to run qemu-system-x86_64 in 32-bit-only mode
>> (by renaming or symlinking the binary to "qemu-system-i386" or something
>> similar with a "-i386" suffix). After doing this, qemu-system-x86_64
>> should be a full superset of qemu-system-i386 (apart from 32-bit KVM
>> support, which however is not required anymore now that we removed support
>> for 32-bit hosts). It is now possible to migrate a guest that has been
>> started with an old "qemu-system-i386" binary to a qemu-system-x86_64
>> binary that has been renamed with a "-i386" suffix.
>

Thanks for posting this Thomas.

> I think my reaction here is similar to what it has been when
> the similar idea has been raised for qemu-system-arm : we should
> have a coordinated plan that is considering all architectures,
> not just dropping a single binary for one architecture where
> it happens to be more straightforward.
>

There are two things to consider for this series, and we should clarify 
what it is trying to do.

The first one is the possibility to have a single-binary. The second one 
is to reduce the number of binaries qemu officially have. It does not 
impact the number of targets, since 32-bit ones will still be supported.

We are currently working on Arm architecture with the first goal in 
mind. It does not bring anything useful in terms of feature, since 
qemu-system-aarch64 can already run anything that qemu-system-arm runs. 
However, it gives us a place to experiment and see how target code can 
efficiently and correctly modified to support the single-binary effort. 
We know it's not yet the final word on this, because other architecture 
makes more usage of target_ulong and TCGv, and we'll need another solution.

Even if we create a plan to remove 32-bit targets when 64-bit ones 
support it, we will run into architectures that are an issue. Thus, I 
believe more strongly in refactoring the code, target after target. It 
will take time, but thanks to the single-binary approach, we can 
progress in iterations and in parallel, over years, and make sure there 
is no regression on files that have been ported.

Let's fast forward 5 years in the future and imagine that all QEMU 
targets are integrated in the single-binary. Once it is done, we know 
that all files in target/X/* will be compiled only once, and integrated 
selectively for 32-bit or 64-bit targets. The key to understand is that 
in this setup, choosing to keep the 32-bit does not change anything. 
Technically, it will just be a simple target-info file, representing 
this 32-bit target, and a symlink for representing the target binary. 
All the rest will already be common with 64-bit.

With this projection in mind, I wonder what is the concrete value to 
make any proper plan to deprecate 32-bit targets, since in the end, it 
won't matter if they are present or not.

What are your thoughts?
Which value would we get from deprecating 32-bit targets when possible?

Regards,
Pierrick

