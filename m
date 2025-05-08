Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51353C3ABC6
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 20:49:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD8An-0004rn-41; Thu, 08 May 2025 16:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uD8Am-0004rc-4C
 for qemu-devel@nongnu.org; Thu, 08 May 2025 16:48:52 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uD8Ak-0008Lt-78
 for qemu-devel@nongnu.org; Thu, 08 May 2025 16:48:51 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22fcf9cf3c2so299575ad.0
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 13:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746737328; x=1747342128; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9ihZ4k/jzXw01h9vYRsxIcHSwC+dxhE7XPc8ad9f3+E=;
 b=x2Y0XQFHIOcnH3E4YQj12LY45D/hVH2iUZRAPM4K4n6BWF/Rb3p7f2PO+ngLqwrCH3
 oadPYQ5Drffx5t1zZ6igqriDJDconzJNVc1Cy5Yv/Fl9NLatjPSfjQV0tYZvTTRT3nee
 XLk12KsekQ6SzP5b+jPg/1mr1hIbefxqZs4pw6MhdSqya/C2N6JKbqT1Wg4hoOBURBTE
 P9UljtzyVA94C9mfg+jirydQd60JzmwXSSKZqL2eXU450e35bI2MTs4oJ86ENNJMq+ct
 5PLQ8u9NS9Lpe4qqtKwQio/jvTJqOudLogrrH6I2Fa4xLd9CdxSOXHBxMRbZ80LcMNxn
 rIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746737328; x=1747342128;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9ihZ4k/jzXw01h9vYRsxIcHSwC+dxhE7XPc8ad9f3+E=;
 b=NwGaR32x9ijhJyVofFOKrXdxJLrghEX+1FBxgIBIYnbhG9KFhXqVnJs0Nfh4n89wK/
 MrYzADpFzNyIbAqawczf6oVohbtv8zc72I+URfmgx+QgkL6hH4w/AvfJfO6VDC6VY/Uu
 QVqBEFTac64554ig/Rb8ygCtmm406HeU+VXhix7ByE8b50rAoEEWBPTqgCW5djzmspOU
 PThBi5Nq3jLaa4/3PfwMAKfMREGMAdvsegMhQTblI6Qqt/01GjLic8/WD/qthk56YBvg
 8zmzjif1yY/rzapWuAPTZ6P33PFAbBQYpqLPLcZCudUccKMKR9PcOybirp31eKwLXCJC
 2VjQ==
X-Gm-Message-State: AOJu0Yyinjn1tZJjjiQ4Av3yaF+FeCsj/lxzttVUbiXOQ45ddMcDkBxS
 aEnMQ0tM/Bvcjzw52C88qECNaOjmfHeoOImwTR0uHXlRpGOuzAxiX1cP8+yjE1E=
X-Gm-Gg: ASbGncuj+dZU8kiVLHAXyHxKAIiftN8+qFbZjBU4ellgnE44FFWgAxMlu09nRa4hWHh
 yIB2Zs86Ypjb0e+30Xia7LEcieujOyD3GquIQKAKHzCv81aaOp04d0QuDUGC3KA/TPofykxoQj3
 X7QNCaL/4koBK/knSU29jSBVhRvNzW23EayJTXrqyCXK5KeywbshqYSI9UcZT9Prc+jrvdImJkS
 PmwQ8yHSK8kdvPhSyxNfR4InFb8bLocNethSbbkGoVMsGw0CVdB3/mqx3ds/HsiRbQVdoi1R7eg
 93kreQ7mXUc+ztaRliDVC/bcFKmNi+IyCMqjC30MWh0M1TaLzV6fFrNHobL6L+xY
X-Google-Smtp-Source: AGHT+IFXi+1Ua0le6T4XxvHi5uxi5FpZh3EnXZuoUETV/22VrayBpkbZZz4YhXRyNdeuTnMKxia33g==
X-Received: by 2002:a17:902:e545:b0:22e:53a2:554e with SMTP id
 d9443c01a7336-22fc8b3e317mr13816425ad.10.1746737328046; 
 Thu, 08 May 2025 13:48:48 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc7546a09sm4071985ad.9.2025.05.08.13.48.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 13:48:47 -0700 (PDT)
Message-ID: <c5c482b2-35a2-451d-a1b0-25f850167bc2@linaro.org>
Date: Thu, 8 May 2025 13:48:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] qapi: transform target specific 'if' in runtime
 checks
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, stefanha@redhat.com,
 peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>,
 richard.henderson@linaro.org, pbonzini@redhat.com, jsnow@redhat.com,
 philmd@linaro.org, thuth@redhat.com, Michael Roth <michael.roth@amd.com>
References: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
 <20250507231442.879619-10-pierrick.bouvier@linaro.org>
 <aBzCXNTebh8B5sQ_@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <aBzCXNTebh8B5sQ_@redhat.com>
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

On 5/8/25 7:40 AM, Daniel P. Berrangé wrote:
> On Wed, May 07, 2025 at 04:14:39PM -0700, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   qapi/machine-target.json | 84 ++++++++++++++++++++++++----------------
>>   qapi/misc-target.json    | 48 ++++++++++++-----------
>>   scripts/qapi/expr.py     |  9 +++--
>>   3 files changed, 81 insertions(+), 60 deletions(-)
>>
>> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
>> index 541f93eeb78..6174b7291ca 100644
>> --- a/qapi/machine-target.json
>> +++ b/qapi/machine-target.json
>> @@ -96,7 +96,7 @@
>>   ##
>>   { 'struct': 'CpuModelBaselineInfo',
>>     'data': { 'model': 'CpuModelInfo' },
>> -  'if': 'TARGET_S390X' }
>> +  'runtime_if': 'target_s390x()' }
> 
> The existing 'if' conditions are already slightly uncomfortable
> for QAPI when considering alternate code generators, because the
> definition of what  "CONFIG_xxx" or "TARGET_xxx" condition means,
> is essentially known only to our build system. While we expose
> the conditions in the docs, the meaning of those conditions is
> totally opaque to anyone reading the docs. Essentially our QAPI
> schema ceased to be self-documenting/self-describing when we
> introduced the 'if' conditions :-(
> 
> 
> In retrospect, IMHO, for 'if' conditions we probably should have
> created some kind of built-in QAPI concept of feature flag constants
> with well defined & documented meaning.
> 
> eg hypothetically
> 
>    ##
>    # @target-s390x
>    #
>    # Whether this is an s390x emulator target
>    { 'constant': 'target-s390x' }
> 
>    ##
>    # @accel-kvm
>    #
>    # Whether the KVM accelerator is built
>    { 'constant': 'accel-kvm' }
> 
> Then our 'if' conditions would have only been permitted to
> reference defined 'constant'.
> 
>    { 'struct': 'CpuModelCompareInfo',
>      'data': { 'result': 'CpuModelCompareResult',
>                'responsible-properties': ['str'] },
>      'if': 'target-s390x' }
> 
> The build system would need generate an input document for the
> QAPI visitor that defines whether each constant is set to true
> or false, based on suitable CONFIG/TARGET conditions from meson.
> 
> With this QAPI schemas would have remained fully self-contained.
>
> Anyway, this is a long way of saying that having 'runtime_if'
> conditions directly referencing the names of internal C
> functions makes me even more uncomfortable than I already am
> with the 'if' conditions.
>

I understand the concern.
However, one argument may be that QAPI json, as perfect as we could 
expect they are, are simply known and used inside QEMU right now, which 
is written in C at the moment.
Even if that assumption should change, I'm pretty sure we can create 
functions named in the same way in C, python, Go, Rust or any other 
languages we would like to generate code for.
It's not like if we started using complex expressions that only works in 
nightly version of Rust.

> The meaning of the QAPI schema now varies based on both the build
> system, and an arbitrary amount of C, and is thus (conceptually)
> even more opaque, even if you could infer some meaning from the
> 'target_s390x()' function name you've used. I think this is a very
> undesirable characteristic for what is our public API definition.
>

Correct if I'm wrong, but it was said in previous threads that those 
json are simply used and consumed by QEMU itself, and not by any 
external projects.
I would be prudent to call this a public API definition, when it's just 
a DSL for an ad-hoc code generator internal to QEMU.

> With regards,
> Daniel

Overall, and I would like to state it again, I'm really open to any 
solution to get rid of TARGET_* compile time defines in QAPI json.
And I appreciate the solution you posted as well.

For now, it's blocking the single binary work, because any file pulling 
QAPI definitions is tainted with TARGET_* defines, so we are blocked 
waiting for them to be removed upstream, before being able to post a 
series touching those files.

I hope we can get a clear answer from QAPI maintainers, so you or I can 
take ownership of this and finish the work. From the previous thread, I 
thought (and I may be wrong) that Markus was more enclined to the 
current solution, but it was not entirely clear for me to be honest.
Let's hope that having both approaches implemented will give a good 
insight of where things should go.

Thanks,
Pierrick

