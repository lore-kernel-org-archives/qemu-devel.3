Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320EEFD377B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 17:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvIit-0003Ao-Tu; Wed, 25 Feb 2026 12:30:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvIip-00039N-IH
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 12:30:54 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvIin-00016J-Bq
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 12:30:51 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3562e858da5so2968339a91.2
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 09:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772040648; x=1772645448; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7WTTrqR/+qQjjg/g1i/QyNwvpIlTUZJnWq8Xc5vG2iw=;
 b=CBS1KRaSejkgTlxgoOqIfgbPSabmoIcJSRRRyi0yIeU0RcXndXN99JSas5Hj0NLvLW
 doxr2r4c7G9KtPSx/+r4xa88B0CSAV6JJOCQibHh8/gu08FBRCEj/MFIoDEePFolmDyJ
 EqlGrDvmelYQtBvhbxBni3/irCRFQYPnDbf4zyaIZFhCFISQc9U55gZZJ+o7fUK7bNrb
 TYBHMjCiJ16gM6HvLRWHxKh1dazWF7Rlueo3nPe8lWHVImsyX1JTR3mB6g8HdxBYNKt8
 EKWCidCq1gMvDbo74DhUmtfX8P2iLLndOYXGRgKHOtfCmVjgYWKWKinNCk581x+7bqrG
 uXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772040648; x=1772645448;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7WTTrqR/+qQjjg/g1i/QyNwvpIlTUZJnWq8Xc5vG2iw=;
 b=toJlBrDqztl7EcODZ4dQytANcgXZNjCpTtCm9zd5sDI/N2CV9Rg34mxmNvCymcQSLW
 RZJVG3UcZlLeE0d52xInMTtkDIKRxbf7V12p7pype8owdXT1dS5DrPsmb7RnTw01sOyX
 1mrMDC9ORCNjHhoBkMzRqChln8KaboXnbJkZeFy6JDlpSc4Tc/v+vP9aPM+2oeZm7pE+
 5KxBn44j7GZjERYiVNAeRFDlNg79XJ/DaUo8vHQGyMxzrEX3WFPVOKKEpG3DcknLbLSu
 dtsp1eu/UU7V8lvKgHRbMbi5JU5OlGHTUCHKapgsETz28hIu6DMHPlVGkuNC4tUqcYsO
 KqKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXa7aHvqHqNaR7/Z/KQoqrR2c36WRWLvsFpqdtoffnfyBlCh/TyhQEDrIk54t68OK7JVCRR9iWqf+qJ@nongnu.org
X-Gm-Message-State: AOJu0YxYkgc4cD2jWKF/dPVG5P4yxIhYPF15fEemW7idt/2opHWP1poI
 ZXCvjrSvpgt5+wYWQKem3OH9M5WSDKib2NOWj8eZtFDPfWdMN9L3wUt3zhc6qAQU2w4=
X-Gm-Gg: ATEYQzyj3rQDwy06HnCQA//Pr8Iv41WxQU9+iyTzLumDwjM/QuLotSJNMY51qflC9xV
 nLXqmzSsnhREXg3ZcFg1eB71YrNeEahyS63E5tUs7G8CaNj1Y4CRA74M6G7bvu8njoZVb0EzUM0
 q5fv8HIobq8IqG1PuzKAimYYugcfQv2eK+3Vi+yRev/kMPqnIeyko43pmcjz1FwaZidg+c7qwxs
 k3ng7M2p6/hvUIgCE/34U71I/QRLg0zCIwXfPDFNS5erpBPePVnChkalEFvtynlk+gGEXkCVn/N
 OflDW7yMaANmrlInHsVG0cCCe5RQRe0xg0nRCZFGuqTKfiCWR11lWeNR4pdBbxlTbNAGZUNcQsP
 cQvXP2o5EOAnRNiX+k5mliDs3ZS3H08EAOqogHxQgvMLRSBIBkcfbT1swrt7asu1gSLZaAlxm8R
 VZt+fliXLjnS+dQjTNkHHrQuFe93AoJ3lkfDO/E+yVspCoSyvet7IPja+ek8BgLhkvIWMn
X-Received: by 2002:a17:90b:5288:b0:356:9405:759d with SMTP id
 98e67ed59e1d1-35928a5faadmr879545a91.9.1772040647380; 
 Wed, 25 Feb 2026 09:30:47 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-359029dc146sm3336784a91.14.2026.02.25.09.30.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 09:30:46 -0800 (PST)
Message-ID: <e317d484-eee2-489e-8c9c-d30f7800cef9@linaro.org>
Date: Wed, 25 Feb 2026 09:30:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] tests/tcg: add test for qemu_plugin_set_pc API
Content-Language: en-US
To: Florian Hofhammer <florian.hofhammer@epfl.ch>, alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, laurent@vivier.eu, imp@bsdimp.com,
 berrange@redhat.com, qemu-devel@nongnu.org
References: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
 <2ccc79ee-48ab-4097-a9cc-4d2b79ab9a8a@epfl.ch>
 <383fc3ee-20ed-45e7-bcbb-1c188256bfad@epfl.ch>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <383fc3ee-20ed-45e7-bcbb-1c188256bfad@epfl.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102d.google.com
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

On 2/25/26 8:21 AM, Florian Hofhammer wrote:
> On 24/02/2026 16:52, Florian Hofhammer wrote:
>> The test executes a non-existent syscall, which the syscall plugin
>> intercepts and redirects to a clean exit.
>> Due to architecture-specific quirks, the architecture-specific Makefiles
>> require setting specific compiler and linker flags in some cases.
>>
>> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
>> ---
>>   tests/tcg/arm/Makefile.target                 |  6 +++++
>>   tests/tcg/hexagon/Makefile.target             |  7 +++++
>>   tests/tcg/mips/Makefile.target                |  6 ++++-
>>   tests/tcg/mips64/Makefile.target              | 15 +++++++++++
>>   tests/tcg/mips64el/Makefile.target            | 15 +++++++++++
>>   tests/tcg/mipsel/Makefile.target              | 15 +++++++++++
>>   tests/tcg/multiarch/Makefile.target           | 22 ++++++++++++++--
>>   .../{ => plugin}/check-plugin-output.sh       |  0
>>   .../{ => plugin}/test-plugin-mem-access.c     |  0
>>   .../plugin/test-plugin-skip-syscalls.c        | 26 +++++++++++++++++++
>>   tests/tcg/plugins/syscall.c                   |  6 +++++
>>   tests/tcg/sparc64/Makefile.target             | 16 ++++++++++++
>>   12 files changed, 131 insertions(+), 3 deletions(-)
>>   create mode 100644 tests/tcg/mips64/Makefile.target
>>   create mode 100644 tests/tcg/mips64el/Makefile.target
>>   create mode 100644 tests/tcg/mipsel/Makefile.target
>>   rename tests/tcg/multiarch/{ => plugin}/check-plugin-output.sh (100%)
>>   rename tests/tcg/multiarch/{ => plugin}/test-plugin-mem-access.c (100%)
>>   create mode 100644 tests/tcg/multiarch/plugin/test-plugin-skip-syscalls.c
>>   create mode 100644 tests/tcg/sparc64/Makefile.target
>>
>> diff --git a/tests/tcg/multiarch/plugin/test-plugin-skip-syscalls.c b/tests/tcg/multiarch/plugin/test-plugin-skip-syscalls.c
>> new file mode 100644
>> index 0000000000..1f5cbc3851
>> --- /dev/null
>> +++ b/tests/tcg/multiarch/plugin/test-plugin-skip-syscalls.c
>> @@ -0,0 +1,26 @@
>> +/*
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + *
>> + * This test attempts to execute an invalid syscall. The syscall test plugin
>> + * should intercept this.
>> + */
>> +#include <stdint.h>
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <unistd.h>
>> +
>> +void exit_success(void) __attribute__((section(".redirect"), noinline,
>> +                                       noreturn, used));
>> +
>> +void exit_success(void) {
>> +    _exit(EXIT_SUCCESS);
>> +}
>> +
>> +int main(int argc, char *argv[]) {
>> +    long ret = syscall(0xc0deUL);
>> +    if (ret != 0L) {
>> +        perror("");
>> +    }
>> +    /* We should never get here */
>> +    return EXIT_FAILURE;
>> +}
> 
> I'm running into an issue for all four variants of MIPS if I don't
> hardcode the section but pass the function address as a syscall argument
> and then use that as jump target in the plugin: according to the ABI,
> the t9 register has to contain the address of the function being called.
> The function prologue then calculates the gp register value (global
> pointer / context pointer) based on t9, and derives the new values of t9
> for any callees from gp again. As I'm currently just updating the pc
> with the new API function, t9 is out of sync with the code after control
> flow redirection and the binary crashes.
>> I think it is fair to expect a user of the API to be aware of such
> pitfalls (or we can document it), but I'd of course still like to make
> the tests pass. The simplest solution (theoretically) is to also set the
> t9 register in the plugin callback before calling qemu_plugin_set_pc.
> However, the MIPS targets do not actually expose any registers to
> plugins, i.e., qemu_plugin_get_registers returns an empty GArray.
>

A lot of things can go wrong when jumping to a different context than 
the current one, that's why setjmp/longjmp exist. You can always add a 
comment for this "This function only changes pc and does not guarantee 
other registers representing context will have a proper value when 
updating it".

A reason why I pushed for using value labels, was to stay in the same 
context, and avoid the kind of issues you ran into.

> Given this behavior, I see two solutions:
> 1) skipping the test on MIPS, or
> 2) making the test code a bit more contrived to use labels within the
>     same function while preventing the compiler from optimizing the
>     labels away (which it does even with -O0). I've got a prototype for
>     this, but the test code looks a bit contrived then:
> 
>     int main(int argc, char *argv[]) {
>         int retvals[] = {EXIT_SUCCESS, EXIT_FAILURE};
>         int retval_idx = 1;
> 
>         long ret = syscall(0xc0deUL, &&good);
>         if (ret < 0) {
>             perror("");
>             goto bad;
>         } else if (ret == 0xdeadbeefUL) {
>             /*
>              * Should never arrive here but we need this nevertheless to prevent
>              * the compiler from optimizing away the label. Otherwise, the compiler
>              * silently rewrites the label value used in the syscall to another
>              * address (typically pointing to right after the function prologue).
>              */
>             printf("Check what's wrong, we should never arrive here!");
>             assert(((uintptr_t)&&good == (uintptr_t)ret));
>             /* We should absolutely never arrive here, the assert should trigger */
>             goto good;
>         }
> 
>     bad:
>         retval_idx = 1;
>         goto exit;
>     good:
>         retval_idx = 0;
>     exit:
>         return retvals[retval_idx];
>     }
> 
> Maybe I'm just missing something obvious, I'd be happy to get some
> feedback on this. Thanks in advance!
> 

Can you post the exact code you had where labels are optimized away?
On which arch was it?
I tried something similar but didn't see the second one disappear.

I wonder if it's related to compiler detecting g_assert_not_reached() is 
a "noreturn" function, thus it doesn't expect to go past it, and 
eliminates dead code. You can try with assert(0) or moving 
g_assert_not_reached() to another function "crash()" instead, that is 
not marked as noreturn.

> Best regards,
> Florian

Regards,
Pierrick

