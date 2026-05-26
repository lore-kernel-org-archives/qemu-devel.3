Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB47CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 20:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRyRQ-0007PA-Jx; Tue, 26 May 2026 16:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRyRO-0007Os-Op
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:31:54 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRyRM-000435-Gu
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:31:54 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4893940bb5eso59551885e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 13:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779827510; x=1780432310; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ALEWKGxJQ3cfiOCVndO4EJvXZtvPUHWQt8k+mSJtbW4=;
 b=s1jq08dT1NWGwWl82o9Qis9B89MwgdlJYsQQgLkknV+8q787fs6tpuuApLNC997rFG
 +ze5BbgCX/N+Vyr6pFbrFClUxNg96nku7n4zj5oIEiLtVPromsRo8YUyL0Bsf1py9ZNH
 Yez4uD8sKp83RuCTXt3CSVQ0p42MLixLRJtjzV+Bf62hzRi+7PKuMz91nLT0LxuuaeQU
 Q0t61EI5jjgxHHicuL/Wx7BWXqlImMQ2DMJsIeDaaKP7DgE7MDnrELaAHyfQvJYjFI5j
 V3e5sQwAVWwXaZT6pl2pCyi1syzsIkdroSlCGqSmjCm08Vmpd/PPbPgm+0znmEm395OV
 aiqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779827510; x=1780432310;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ALEWKGxJQ3cfiOCVndO4EJvXZtvPUHWQt8k+mSJtbW4=;
 b=GrOS3fFWyxrf7Lbaf7Q1z23wGsM2iVqHLz/CY2ulM7yrVg+CmxlU8CzOyxyfr/wbUA
 6eYCGMUNxdR7baydgLosL2OOR0F+VuKGWj4Nvjk7IRvN/Ykzuf79Wpz7Pow6CPOsH8mB
 OLipperZML4tV/j3e711UoO8TxlNXUWImmOucS1vaTsPzel05dPBsK8fSI6vwPFKeoKl
 VxhlmjRarkthQO6JHnLph/EMYdJOgwJ+a3oD18lixPK5d8LEzcGzhQO5wXpz6AMkMeoh
 EZJBPSb6Vc+IgJ+85y9mZ4tRnTZpJfupZeQiUnw46eCsiDKVpguvXQlHQLyoFW0sPZXT
 11cQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+d+2OlZXIUReBK6jb12nYJ/gSBEDWDGp94KeHllwWm2BlplLMJnXl0iR6YpfxqhNUyK2+bKn0lWOuE@nongnu.org
X-Gm-Message-State: AOJu0YzztNbj5vM8Xv9pJneITh7AdhLAxyrgOFWEJXT7vM6qmEgvCnhg
 v9KTYJVE963sYY9QdplFJZ0WV48eNI1157fb/Z832+SSI9nnctr/oZXGYxAFlHaCUfA=
X-Gm-Gg: Acq92OENJWmvMJina3P1StjbJwaAXpUyAh9QfNM/Rm0812R8LXgrK/t/jtTj/LMNXwx
 7roE9gNjULw5Z14VRU1wmz1lw/Ft6lkemsQxwsGTL+b/Bn/xF/1GmU6XypPQ+VzHq5TiDcPHfEz
 Ozj6TduFBttgj+C5ZJ6GfytVvV1JbEEYlnC7hESHjP05TAJrDZ4fbkgyh9S4km4rzm71K2I/zmu
 joaKpkkn1WopFyJ2udkA7gs7ZYa/rEoCzdfhdPBDoLeMXrFsH3QtmAy5pVd173aTWolyWdtNu0x
 r9MwcTqyhGwI0YIRZRZJvbDXVgYGXCzJPBZ+II3/LdUyj2Oc6LnAcALtJxsq4HdtSsGWeZihQGe
 4190zgTslnZUUjJcHtWSv/KHTMhIlPkhKxuKGFEc2y0bW9hFv61OsSwlFTWLs/8VI0/lGVKfx6u
 ldjSAUcVouExoW3OfABdsieYEnbcScfVd0mTXDu8iU+VC9KGTRga0o7cgYhSS4SiGpXb7arlBy3
 Q6/
X-Received: by 2002:a05:600c:4e4b:b0:490:688b:f9f8 with SMTP id
 5b1f17b1804b1-490688bfa29mr137309985e9.27.1779827510211; 
 Tue, 26 May 2026 13:31:50 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490809a0e7csm1259945e9.22.2026.05.26.13.31.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 13:31:49 -0700 (PDT)
Message-ID: <73cca94a-09ad-478e-a5c0-575bba94651c@linaro.org>
Date: Tue, 26 May 2026 22:31:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question about recent iotest changes, 'make check' and 'ninja
 test'
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <0c7e5dec-44fc-4c1b-b0ce-cb9fdd6d0a5c@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
In-Reply-To: <0c7e5dec-44fc-4c1b-b0ce-cb9fdd6d0a5c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 26/5/26 22:14, Daniel Henrique Barboza wrote:
> Hi,
> 
> I happen to use 'ninja -C build test to do a (usually) quick sanity test
> on patches and changes and whatnot.  An usual run of this target tests
> around 327 individual tests with the RISC-V stuff I usually build.
> 
> After pulling today's master 'ninja -C build test' is now running a 
> whooping
> 1366 tests.  Here's an example:
> 
> 
> $ ninja -C build -j 9 test
> ninja: Entering directory `build'
> mkvenv: checking for pygdbmi>=0.11.0.0
> mkvenv: installing pygdbmi==0.11.0.0
> [2/3] Running all tests
> [1-12/1366] (....)
>   (....)
> [250-260/1366] 🌕 block-qcow2-optional+block-slow - qemu:io-qcow2-014
> [250-261/1366] 🌖 block-qcow2-optional+block-slow - qemu:io-qcow2-014
> [252-262/1366] 🌒 block-qcow2-optional+block-slow - qemu:io-qcow2-026
> (...)
> 
> I noticed a lot of these "optional+block-slow" tests being ran now, 
> something that
> wasn't happening before.
> 
> If I use 'make check' I have the results I was having with 'ninja -C 
> build test'
> before the recent changes.
> 
> I tried to bisect and got to this commit:
> 
> commit daf0d008822be3cb14cdb533f7237c3c789bc373 (HEAD)
> Author: Daniel P. Berrangé <berrange@redhat.com>
> Date:   Mon Jan 12 13:01:49 2026 +0000
> 
>      iotests: remove redundant meson suite for iotests

Cc'ing developers involved in this commit and Alex.

> 
>  From what I can tell this commit triggered (unintended?) stuff that was 
> already in the
> code.  In other words I am not sure if this commit is actually the 
> culprit, so I am
> reluctant to even call this a bug.
> 
> My question is: should I be using 'ninja test'?  It seems to me that the 
> common practice
> is to use 'make check' and maybe I've been using an "unsupported" 
> testing scheme.

This is what was explained to me on #irc when I complained about a
similar issue, however I still use ninja first because it is much faster
than having make parsing Makefiles not triggering any rule before
calling ninja. When this (rarely) fails I go back to 'make'.

Some developers like Pierrick better understand ninja and use it
directly.

> 
> 
> Cheers,
> Daniel
> 
> 
> 


