Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A166BC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 20:09:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2ck1-0002oN-QW; Thu, 02 May 2024 16:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1s2ck0-0002o5-8e
 for qemu-devel@nongnu.org; Thu, 02 May 2024 16:09:16 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1s2cjy-0000Ee-JG
 for qemu-devel@nongnu.org; Thu, 02 May 2024 16:09:15 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1e4bf0b3e06so83916955ad.1
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 13:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714680552; x=1715285352; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ctirnUZtwJNhEsaEPHZYXoCIMzmJS10JxknRdDITcSc=;
 b=tDCMd9uFm1egb7/2kBSa/JNt1f9z23LA9ut7ASU5wZ2aJp6oMSj7LzEq/Gz3cNwPCF
 CkORFRLTDmE88OtNHh3maW57regYSY5xOy5EeKK5JEKBcJATooNQK41LXDD9wx+g9JIq
 8nNaMTQ1TT0fxEZ1FbV/AzKeeSRijn8Cy2O84YEqIgPFfZPAp8H/bXfWV4JswaQFJaWy
 RbiWMmvbdlYhpgLLyclIa86mZGjTVBnQGhTTabVV7LirkucKPqeSWo4tNdprYCXkYctX
 QobfmtA4L6ee5yWqwnJ5HPUsSMNv3cEO5sXie3o+Pt87P4btFOGvpt05bnoNtS1i2kza
 MG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714680552; x=1715285352;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ctirnUZtwJNhEsaEPHZYXoCIMzmJS10JxknRdDITcSc=;
 b=ZhxdEWSwnTaXmAEoKVtZQYa4rOcTawoOZgpul7/pe3WgTsSFRwam9mZ5NvntWi8XVs
 LKzY8rPUmdCFcb2oSbGAqo3gvjs/mFXIa53E3xmNLNiiLudqrylcH/M7+dz1jKhNv+H4
 5oepuQRyC9cTYVu7pReXJxQ3eN2eET0Fhb/wfPBl1RnXLpuZ0eWz+2JJ0b9YfaXmjGE1
 z4+DFAD/HT+E0NfyifDXGL4qoQ3TbX8+FuKUs7v0XTZOFJJlDgQQIq8zVRJn4svOhn0h
 9TRJd1acOUmQQcg9fQLtvjFQ7lAQUB80cpt2N9tIJapI24cP4at2yvCygDtbQ1vdTMjd
 tIkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7+sWDS3E2zFHfU2Y6DNoTtjP1iWczk5moK2NcRcT6O/YcUZdSVfVLcbEQCBwXVF+iP91MkfuVSlTiOILLW3LUW9u/5iQ=
X-Gm-Message-State: AOJu0YyedUibFmSPZesdey3N/tiK1IMovZ1yZe55VarnLvAr47xg2fXm
 fDQj83UvtT1tt6wd9ufqTMj+i3uH8yIDLVJ5Ddj2Y9/4+EthBbAMTEQV3lgeZHq3aCyCaPxRX4W
 L
X-Google-Smtp-Source: AGHT+IHf+nYTb7Q8cwZFViha2AaBPWCnCPGdojUzg/Fs5s2/+svp04GG1S6E7yy1/uoEOHUU+W1bAA==
X-Received: by 2002:a17:903:249:b0:1eb:d70c:e69f with SMTP id
 j9-20020a170903024900b001ebd70ce69fmr747839plh.63.1714680551787; 
 Thu, 02 May 2024 13:09:11 -0700 (PDT)
Received: from [192.168.0.102] (201-1-51-131.dsl.telesp.net.br. [201.1.51.131])
 by smtp.gmail.com with ESMTPSA id
 s7-20020a170902ea0700b001ec6db9356bsm1732939plg.204.2024.05.02.13.09.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 13:09:10 -0700 (PDT)
Subject: Re: [PATCH v5 0/9] TCG plugins new inline operations
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240502180847.287673-1-pierrick.bouvier@linaro.org>
 <b78563fd-1c06-8ee1-5508-39b3e83249cf@linaro.org>
 <b083716a-dd1e-4edb-ba57-530c7661305f@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <b3474554-0333-27c2-df47-146e5ef317d9@linaro.org>
Date: Thu, 2 May 2024 17:09:07 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <b083716a-dd1e-4edb-ba57-530c7661305f@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.296,
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

On 5/2/24 4:45 PM, Pierrick Bouvier wrote:
> Hi Gustavo,
> 
> On 5/2/24 12:16, Gustavo Romero wrote:
>> Hi Pierrick,
>>
>> On 5/2/24 3:08 PM, Pierrick Bouvier wrote:
>>> This series implement two new operations for plugins:
>>> - Store inline allows to write a specific value to a scoreboard.
>>> - Conditional callback executes a callback only when a given condition is true.
>>>     The condition is evaluated inline.
>>>
>>> It's possible to mix various inline operations (add, store) with conditional
>>> callbacks, allowing efficient "trap" based counters.
>>>
>>> It builds on top of new scoreboard API, introduced in the previous series.
>>>
>>> NOTE: Two patches still need review
>>>
>>> v2
>>> -- 
>>>
>>> - fixed issue with udata not being passed to conditional callback
>>> - added specific test for this in tests/plugin/inline.c (udata was NULL before).
>>>
>>> v3
>>> -- 
>>>
>>> - rebased on top of "plugins: Rewrite plugin code generation":
>>>     20240316015720.3661236-1-richard.henderson@linaro.org
>>> - single pass code generation
>>> - small cleanups for code generation
>>>
>>> v4
>>> -- 
>>>
>>> - remove op field from qemu_plugin_inline_cb
>>> - use tcg_constant_i64 to load immediate value to store
>>>
>>> v5
>>> -- 
>>>
>>> - rebase on top of master now that Richard's series was merged
>>>
>>> Pierrick Bouvier (9):
>>>     plugins: prepare introduction of new inline ops
>>>     plugins: extract generate ptr for qemu_plugin_u64
>>>     plugins: add new inline op STORE_U64
>>>     tests/plugin/inline: add test for STORE_U64 inline op
>>>     plugins: conditional callbacks
>>>     tests/plugin/inline: add test for conditional callback
>>>     plugins: distinct types for callbacks
>>>     plugins: extract cpu_index generate
>>>     plugins: remove op from qemu_plugin_inline_cb
>>>
>>>    include/qemu/plugin.h        |  42 +++++++----
>>>    include/qemu/qemu-plugin.h   |  80 ++++++++++++++++++++-
>>>    plugins/plugin.h             |  12 +++-
>>>    accel/tcg/plugin-gen.c       | 136 +++++++++++++++++++++++++++--------
>>>    plugins/api.c                |  39 ++++++++++
>>>    plugins/core.c               | 109 ++++++++++++++++++++--------
>>>    tests/plugin/inline.c        | 130 +++++++++++++++++++++++++++++++--
>>>    plugins/qemu-plugins.symbols |   2 +
>>>    8 files changed, 466 insertions(+), 84 deletions(-)
>>
>> The description in the commit message of patches 1/9, 2/9, 6/9, 7/9, and 8/9 is missing.
>>
>> Is this intentional?
>>
> 
> Do you mean there is no multiline commit message for those changes?
> Indeed, for some of those patches, the change is a single line commit message.

I just see a commit title and the Signed-off-by. For example, in 8/9
I see the following on git log:

commit f518898aa09b42e317b887237bb75a432b477c6d
Author: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Date:   Thu May 2 11:08:46 2024 -0700

     plugins: extract cpu_index generate
     
     Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
     Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

It has only the title: "plugins: extract cpu_index generate"
and R-b and S-b, so no description about the changes.


Cheers,
Gustavo

