Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 711D0EEF319
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 08:30:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy467-0007Xs-5j; Thu, 05 Mar 2026 03:30:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vy464-0007Xg-3K
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 03:30:16 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vy461-0003AI-RP
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 03:30:15 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c7393c6832bso55374a12.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 00:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772699412; x=1773304212; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=q7Y+HpRF1zESP8aCPpJN1M1fn/ZgQNeMAKcfNzw8Hu0=;
 b=sWlNhqJlrlbXZqswWHAZ20ogHxdIXCEm6ctfOUL14CNu8WvR49oDfQ6xPL8H1L8Yek
 ijKX4Y56uWg7Ld4zM9msxi5MkwMI4Rk0Ng2SWG+dkWKtHXgrou05vHrbCtW4jI1XEWV/
 CZr/6anZOBZ4CCPFre88hkW/GJkYsKwA1KJSDbw6dScEJyDGrR8+vMIaMUMsPF+JICMy
 kRB7mKfz46nPEy0YZavYtvCQJSOGt3zqHJ+ZA06p9cyl5Yksdk1ruU5Nl5q2GaKTDERb
 5KRf+1K1SczcUqSTvgLcxLYH49dhFamGOK5Ql+rDY647V0xY3ZaktrPPa8b/+LJIorqE
 N3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772699412; x=1773304212;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q7Y+HpRF1zESP8aCPpJN1M1fn/ZgQNeMAKcfNzw8Hu0=;
 b=HwgFUEqmgk8fO4paugqKjHS/FZmuUjJDYYN2Oid0MUstmXirEz6uIsGRzR+izCcmKy
 ivzXzBvuP4mL7eekJOMFiuix0lNnyonDlJLAP3r8WwZ41AX9WVF9rChyTrzD2pjeVvEx
 EuAvfQ3j2v1sHJZZreCCC3QSmTK2Htcuz0/VgNw96UzSepFc79sU5R1rr9k+9ohG07u0
 oYuOWylDt5CB6RVf3w/6Xiy0iqEpszjovwSQS9WXzygOKSGmR1Zd0EKPJYxiEGBXDZu2
 vNKRsAIfaN6sYkAagXR5FnXd1/sRsbJG2Of5R8Zpw1bc9WBpkjJNyhreRaoFunXxuuWQ
 Zu6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9UIBzOKIPpwsEcEgiHEcKVEuiOPqgNsenlxdQ7hn9n4DG+7Jxi7Yu9Qwz7Cq3/ncLqc2zWXE556ej@nongnu.org
X-Gm-Message-State: AOJu0YzBaqewI1lRZG+93bbCmOKdXpwMlwI1o6MjDBHvEPwV3Ag6v1gc
 /WPTnmEMFdIvBeC/O8mnu7RU8UM2djL6f9knaB6GSosMUhuab4HorxU56aOSLtbynGP0/5KxVj2
 O/usG
X-Gm-Gg: ATEYQzwu57y5QNG0F7IEw4oO0CprqNIoyUsZ+DDNuWiJMarG63D5/aDMyizjGH96NCu
 CADbZfGagO27hwePcxao4Kf4LmVKF8b8HJDA2mJKFNYpEwhMB18qvyWRnX03ifaqxArYEatQ7Un
 AbGv0gOtLnT19IFuYShhyMmCdObXgZpRvUBRo+imgx0g23v54yqm82KcIj6vHAXfMcGMlHfHuKe
 1NDbmKxwYpZ8WBMDQNFK/4REIuU2zCX20Zld8t6glGLKkfQVxvXZtsg7WLutkikQ7Zk8goIt9XM
 n8TGsqtDiBWHzksShB1BfYu7ckuoWRzTF26JTcbfpEb59GMey10il5cbz3DQ0CrXw6CPuHu02ek
 k1W+galF8ffwCEJeoO68mS6Pgi/OpJfCPFlmsjpx7ZEA8Kt64GhewdpxwpxUrFjI2MegUkAB4rH
 p5aRlCFM0adLKGJmgmMeYHUO+LezJDA5BkC3oZjOMxZei8/jWpvCzgGk6yFEVW2LwvWVxIIoDTz
 sLg73k=
X-Received: by 2002:a17:902:f687:b0:2aa:e387:b83b with SMTP id
 d9443c01a7336-2ae6ab18e8amr49487875ad.43.1772699411963; 
 Thu, 05 Mar 2026 00:30:11 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae3d1956absm142265735ad.14.2026.03.05.00.30.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2026 00:30:11 -0800 (PST)
Message-ID: <fd16c256-45f9-454e-bb02-bd4fa4139d1a@linaro.org>
Date: Thu, 5 Mar 2026 00:30:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/7] Enable PC diversion via the plugin API
To: Florian Hofhammer <florian.hofhammer@epfl.ch>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, berrange@redhat.com,
 richard.henderson@linaro.org, imp@bsdimp.com
References: <20260303-setpc-v5-v6-0-15c77cfe184e@epfl.ch>
 <acd9b835-ae52-42aa-87f8-9fedccd79d04@linaro.org>
 <a9b4cb93-24e7-41fb-bb72-bacd48216c1c@epfl.ch>
 <dcafbd00-66a5-4e69-81ba-567c141a26a6@linaro.org>
 <cf6dd907-0818-45c2-b5ff-f8b60e106e86@epfl.ch>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <cf6dd907-0818-45c2-b5ff-f8b60e106e86@epfl.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x535.google.com
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

On 3/4/26 11:14 PM, Florian Hofhammer wrote:
> On 04/03/2026 18:39, Pierrick Bouvier wrote:
>> On 3/4/26 2:36 AM, Florian Hofhammer wrote:
>>> On 03/03/2026 20:20, Pierrick Bouvier wrote:
>>>> On 3/3/26 5:07 AM, Florian Hofhammer wrote:
>>>>> Hi,
>>>>>
>>>>> This patch series builds on top of the discussion from the thread at
>>>>> https://lore.kernel.org/qemu-devel/e9bcd7c7-2d67-469e-b2f3-d1a68e456b2b@epfl.ch/
>>>>> and adds a plugin API function to set the program counter of the guest,
>>>>> as just writing to it via qemu_plugin_write_register() has no direct
>>>>> effect.
>>>>>
>>>>> This version v6 of the patch series addresses the requested changes from
>>>>> the previous v4 submission and an incorrect commit message from v5
>>>>> (details below).
>>>>> Note: checkpatch.pl still reports a warning about line length violations
>>>>> in patch nr. 6/7 but I did not fix this, as the line was already > 80
>>>>> characters long previously, the change added only a single character,
>>>>> and I think the readability of the code is better as it is now. Please
>>>>> let me know if you disagree and would like me to fix this!
>>>>>
>>>>> Best regards,
>>>>> Florian
>>>>>
>>>>> Changes:
>>>>> v6:
>>>>> - update commit message for patch 4/7
>>>>> v5:
>>>>> - make QEMU abort via asserts instead of just returning an error from
>>>>>      the plugin API if preconditions are violated
>>>>> - extend tests for qemu_plugin_set_pc() to different contexts
>>>>> - fix issues highlighted by checkpatch.pl
>>>>> v4:
>>>>> - switch strcmp out in favor of g_strcmp0
>>>>> - split the patch introducing the qemu_plugin_set_pc() API into three
>>>>>      patches, two for preparing the plugin infrastructure and the syscall
>>>>>      handling code and a third introducing the actual plugin API
>>>>> v3:
>>>>> - make PC registers read-only across architectures
>>>>> - add tests for read-only registers
>>>>> - adjust test structure for qemu_plugin_set_pc() by moving
>>>>>       architecture-specific tests into corresponding directories
>>>>> v2:
>>>>> - add setjmp() in syscall handling path to allow PC redirection from
>>>>>       syscall callbacks (via longjmp(), the cpu_loop()'s setjmp() for
>>>>>       exiting a TB would not be live anymore in syscall handlers)
>>>>> - add flags to ensure the qemu_plugin_set_pc() API is only called from
>>>>>       contexts where the CPU is live
>>>>> - add test for qemu_plugin_set_pc() API
>>>>> v1:
>>>>> - initial version
>>>>>
>>>>> ---
>>>>> Florian Hofhammer (7):
>>>>>          plugins: add flag to specify whether PC is rw
>>>>>          linux-user: make syscall emulation interruptible
>>>>>          plugins: add PC diversion API function
>>>>>          tests/tcg: add tests for qemu_plugin_set_pc API
>>>>>          plugins: add read-only property for registers
>>>>>          plugins: prohibit writing to read-only registers
>>>>>          tests/tcg/plugins: test register accesses
>>>>>
>>>>>     MAINTAINERS                                        |   1 +
>>>>>     include/plugins/qemu-plugin.h                      |  19 +++
>>>>>     linux-user/aarch64/cpu_loop.c                      |   2 +-
>>>>>     linux-user/alpha/cpu_loop.c                        |   2 +-
>>>>>     linux-user/arm/cpu_loop.c                          |   2 +-
>>>>>     linux-user/hexagon/cpu_loop.c                      |   2 +-
>>>>>     linux-user/hppa/cpu_loop.c                         |   1 +
>>>>>     linux-user/i386/cpu_loop.c                         |   8 +-
>>>>>     linux-user/include/special-errno.h                 |   8 ++
>>>>>     linux-user/loongarch64/cpu_loop.c                  |   5 +-
>>>>>     linux-user/m68k/cpu_loop.c                         |   2 +-
>>>>>     linux-user/microblaze/cpu_loop.c                   |   2 +-
>>>>>     linux-user/mips/cpu_loop.c                         |   9 +-
>>>>>     linux-user/or1k/cpu_loop.c                         |   2 +-
>>>>>     linux-user/ppc/cpu_loop.c                          |  10 +-
>>>>>     linux-user/riscv/cpu_loop.c                        |   2 +-
>>>>>     linux-user/s390x/cpu_loop.c                        |   2 +-
>>>>>     linux-user/sh4/cpu_loop.c                          |   2 +-
>>>>>     linux-user/sparc/cpu_loop.c                        |   4 +-
>>>>>     linux-user/syscall.c                               |  16 +++
>>>>>     linux-user/xtensa/cpu_loop.c                       |   1 +
>>>>>     plugins/api.c                                      |  42 ++++++-
>>>>>     plugins/core.c                                     |  29 +++--
>>>>>     tests/tcg/arm/Makefile.target                      |   6 +
>>>>>     tests/tcg/multiarch/Makefile.target                |  17 ++-
>>>>>     .../multiarch/{ => plugin}/check-plugin-output.sh  |   0
>>>>>     .../{ => plugin}/test-plugin-mem-access.c          |   0
>>>>>     tests/tcg/multiarch/plugin/test-plugin-set-pc.c    | 140 +++++++++++++++++++++
>>>>>     tests/tcg/plugins/meson.build                      |   2 +
>>>>>     tests/tcg/plugins/registers.c                      |  79 ++++++++++++
>>>>>     tests/tcg/plugins/setpc.c                          | 120 ++++++++++++++++++
>>>>>     31 files changed, 495 insertions(+), 42 deletions(-)
>>>>> ---
>>>>> base-commit: 3fb456e9a0e9eef6a71d9b49bfff596a0f0046e9
>>>>> change-id: 20260303-setpc-v5-c1df30bad07f
>>>>
>>>> Hi Florian,
>>>>
>>>> it seems like there is a small issue building documentation with this series, which should be trivial to fix.
>>>> https://github.com/p-b-o/qemu-ci/actions/runs/22632339221
>>>
>>> Sorry, I didn't catch this one before. I didn't have sphinx installed
>>> locally and built without the docs.
>>>
>>
>> No worries, it's hard to guess all the things that you *might* miss, and it's a common mistake even for regular contributors, including myself.
>>
>>> It seems as if the issue is coming from the declaration of the new API
>>> as "QEMU_PLUGIN_API G_NORETURN void ..." and sphinx is tripping over the
>>> "G_NORETURN" macro. To fix this, I could either change the sphinx config
>>> to accept the macro, or remove the attribute from the declaration. I'd
>>> personally prefer the former but I'd be happy to get your opinion on
>>> this.
>>>
>>
>> Simply move the attribute after prototype, it's the same semantic.
>>
>> diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
>> index 791d223df40..0825bc9279d 100644
>> --- a/include/plugins/qemu-plugin.h
>> +++ b/include/plugins/qemu-plugin.h
>> @@ -1055,8 +1055,7 @@ bool qemu_plugin_write_register(struct qemu_plugin_register *handle,
>>    * resumes execution at that address. This function does not return.
>>    */
>>   QEMU_PLUGIN_API
>> -G_NORETURN
>> -void qemu_plugin_set_pc(uint64_t vaddr);
>> +void qemu_plugin_set_pc(uint64_t vaddr) G_NORETURN;
> 
> Unfortunately, this only works if there's no C++ compiler present.
> Otherwise, glib's G_NORETURN is defined as [[noreturn]] (it checks
> whether the compiler supports C++11's [[noreturn]] and prioritizes this
> attribute style), which cannot be placed after the function prototype.
>

Oh right, I didn't try a full build before proposing this, sorry.
In this case, let's just use the original compiler attribute which will 
make everyone happy.

--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -1055,7 +1055,7 @@ bool qemu_plugin_write_register(struct 
qemu_plugin_register *handle,
   * resumes execution at that address. This function does not return.
   */
  QEMU_PLUGIN_API
-G_NORETURN
+__attribute__((__noreturn__))
  void qemu_plugin_set_pc(uint64_t vaddr);

Regards,
Pierrick

