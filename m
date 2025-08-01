Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D141DC87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 00:56:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhe3I-0003ld-2F; Thu, 31 Jul 2025 20:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uhddh-0002bR-GX
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 20:28:49 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uhddf-0004rg-4T
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 20:28:49 -0400
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-23dc5bcf49eso22135415ad.2
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 17:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754008125; x=1754612925; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wsgDM/de5QE6L+C0NLWRJwbH7DV2RxVu5nBJZ5lwvAs=;
 b=OmTw4xjV5SqAL96TL3JDa4QbNRJfoSZKxI5hL6D+vXvCgVHZaHkE/c0DpkavKfqIun
 DZWcv87xqY8TvbUtj5H/DubzrndlgnPfDVqM7BKei2wQTLjTKPDflY7v+6ViPTFFKhzP
 M789bl/zgfEStw3tUDLYI1CQeoOekhPphzH/bzSnvv1/IZ070k80/GkwKBjnlKvEANMC
 XyAiyI8TGH3gy9l7ZN7iE1BnlZuiC/S2S/dm5eeXd7GN0zoi/BXpwFnfSF6xUcc29US6
 2fOT6aD9KKXqifdqnLJva6BeqqlaiSz4mj+FM/sWd3TdScu4Rk39uGcQN/uO4creya+w
 VyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754008125; x=1754612925;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wsgDM/de5QE6L+C0NLWRJwbH7DV2RxVu5nBJZ5lwvAs=;
 b=kstsUEJOobaFA14HYhJKg01AjUW1LwgIqWyXNqMF0iDRg+oL94eqjknyttVHOWRi9q
 zjccAcI0s91DKkw3Ij6smxhzsTAV7CprinTlH/HH0g2LmJUfQjLVJm+4f0MyrkXK9IRs
 aotwlf+OfmLV8GH62v04nDkP1lmQR8LjUUzrecYmhoP/0wgx3OnP2TvnS9UzpU1eqe77
 cnlshqa8aMFR6Lujb5nwu7ljLWTXv1UlDarlrAHaPRnqEWSSKO3fe+Tdjavtex7Yu/tB
 8D3jPndMkC3U+YQsxqgymWd5B/2DabNhyZW+1uUTK4t2sKF9D3IUJzBycfhAa7ZzbDA+
 97eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyIuExa9eu3ydGTZQ8HsieDUIr3qf7ZHqkmmLveRUnLCMr0+wZuOGlmCjr2NTv2IzCPCLZXkIYgMf6@nongnu.org
X-Gm-Message-State: AOJu0Yw8cye/K3YYWc+bWtrCHl83VJ9K49YXUM+7P0zMJ5C+0N/2moN5
 Hv7fQzCxme13gndXtvM6IlT4b2EUxCrMhvacwnK6uwUHHx7L3xoAoICvCtra6S4h9rI=
X-Gm-Gg: ASbGnctxjbfHQJGxDSzOn5PWpIZEnT6Ij7cm2vFJa8ISp8qUS/Vocp//2tql/JPZZSZ
 pxwXVMnHwLYVpHcS5E06G0vIvjWBu9QpqNDP9hLyVkiBduz4kftM/E5dMqb4dnBrUbFgcqmPlrs
 aSAjyu2Culx2G8X8YCW/R5AuH4SWUmaEakgpusYzqOWcvatzNY+NCOQCNKa9A3sGJcTnqvNAvYu
 JQ0/hZftvbLwuTJpsDfjrbF2IG1n2AbrryLIUl/PPtoDZcYpm1UjG/4Ai6ANu33egbf6NoHtcQ9
 LK0zqJcaNY1KxuK1rm2JBuDdPJiFM2xFxnGt13frsPsaKV8ztJliwQJVKI2KEOsqEpxoK9+jRjo
 jTCWwDwwN/kfALFHLpj/r4icZl0C1TcfpjD5NcTUvqKz3
X-Google-Smtp-Source: AGHT+IH+4g/ex+Z7AmPKdNXOP2Htrn9tBYThId1VLohgJtOpm+ZC3Lrr8zU8dKLNIhOWzPJgk8/OAw==
X-Received: by 2002:a17:903:2f4e:b0:240:5c38:7544 with SMTP id
 d9443c01a7336-24096b44421mr117381785ad.50.1754008125022; 
 Thu, 31 Jul 2025 17:28:45 -0700 (PDT)
Received: from [192.168.0.102] ([152.243.37.35])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8ac8ed4sm27876165ad.189.2025.07.31.17.28.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 17:28:44 -0700 (PDT)
Message-ID: <61eec45c-5e7a-4ecb-a6e1-c410b557aa7a@linaro.org>
Date: Thu, 31 Jul 2025 21:29:34 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 11/14] tests/tcg: reduce the number of plugin tests
 combinations
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, stefanha@redhat.com
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250727083254.3826585-1-alex.bennee@linaro.org>
 <20250727083254.3826585-12-alex.bennee@linaro.org>
 <eee5b640-6c65-4796-9b36-ca324f08c07c@linaro.org>
 <2635ef88-b662-41b9-b206-ca1923e87e91@linaro.org>
 <a21427c9-9b10-45fe-804f-9851f31fc69b@linaro.org>
 <62c027d0-4331-4554-a4ea-0e9a5044ea89@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <62c027d0-4331-4554-a4ea-0e9a5044ea89@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x642.google.com
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

Hi Stefan and Pierrick,

On 7/31/25 16:23, Pierrick Bouvier wrote:
> On 7/31/25 11:58 AM, Gustavo Romero wrote:
>> Hi,
>>
>> On 7/28/25 17:14, Gustavo Romero wrote:
>>> Hi,
>>>
>>> On 7/28/25 16:03, Pierrick Bouvier wrote:
>>>> Hi Alex,
>>>>
>>>> On 7/27/25 1:32 AM, Alex Bennée wrote:
>>>>> As our set of multiarch tests has grown the practice of running every
>>>>> plugin with every test is becoming unsustainable. If we switch to
>>>>> ensuring every test gets run with at least one plugin we can speed
>>>>> things up.
>>>>>
>>>>> Some plugins do need to be run with specific tests (for example the
>>>>> memory instrumentation test). We can handle this by manually adding
>>>>> them to EXTRA_RUNS. We also need to wrap rules in a CONFIG_PLUGIN test
>>>>> so we don't enable the runs when plugins are not enabled.
>>>>>
>>>>> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>>>> Message-ID: <20250725154517.3523095-12-alex.bennee@linaro.org>
>>>>>
>>>>> diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
>>>>> index a12b15637ea..18afd5be194 100644
>>>>> --- a/tests/tcg/Makefile.target
>>>>> +++ b/tests/tcg/Makefile.target
>>>>> @@ -173,14 +173,25 @@ PLUGINS=$(filter-out $(DISABLE_PLUGINS), \
>>>>>    # We need to ensure expand the run-plugin-TEST-with-PLUGIN
>>>>>    # pre-requistes manually here as we can't use stems to handle it. We
>>>>>    # only expand MULTIARCH_TESTS which are common on most of our targets
>>>>> -# to avoid an exponential explosion as new tests are added. We also
>>>>> -# add some special helpers the run-plugin- rules can use below.
>>>>> +# and rotate the plugins so we don't grow too out of control as new
>>>>> +# tests are added. Plugins that need to run with a specific test
>>>>> +# should ensure they add their combination to EXTRA_RUNS.
>>>>>    ifneq ($(MULTIARCH_TESTS),)
>>>>> -$(foreach p,$(PLUGINS), \
>>>>> -    $(foreach t,$(MULTIARCH_TESTS),\
>>>>> -        $(eval run-plugin-$(t)-with-$(p): $t $p) \
>>>>> -        $(eval RUN_TESTS+=run-plugin-$(t)-with-$(p))))
>>>>> +
>>>>> +NUM_PLUGINS := $(words $(PLUGINS))
>>>>> +NUM_TESTS := $(words $(MULTIARCH_TESTS))
>>>>> +
>>>>> +define mod_plus_one
>>>>> +  $(shell $(PYTHON) -c "print( ($(1) % $(2)) + 1 )")
>>>>> +endef
>>>>> +
>>>>> +$(foreach _idx, $(shell seq 1 $(NUM_TESTS)), \
>>>>> +    $(eval _test := $(word $(_idx), $(MULTIARCH_TESTS))) \
>>>>> +    $(eval _plugin := $(word $(call mod_plus_one, $(_idx), $(NUM_PLUGINS)), $(PLUGINS))) \
>>>>> +    $(eval run-plugin-$(_test)-with-$(_plugin): $(_test) $(_plugin)) \
>>>>> +    $(eval RUN_TESTS+=run-plugin-$(_test)-with-$(_plugin)))
>>>>> +
>>>>>    endif # MULTIARCH_TESTS
>>>>>    endif # CONFIG_PLUGIN
>>>>> diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
>>>>> index bfdf7197a7b..38345ff8805 100644
>>>>> --- a/tests/tcg/multiarch/Makefile.target
>>>>> +++ b/tests/tcg/multiarch/Makefile.target
>>>>> @@ -189,6 +189,10 @@ run-plugin-semiconsole-with-%:
>>>>>    TESTS += semihosting semiconsole
>>>>>    endif
>>>>> +test-plugin-mem-access: CFLAGS+=-pthread -O0
>>>>> +test-plugin-mem-access: LDFLAGS+=-pthread -O0
>>>>> +
>>>>> +ifeq ($(CONFIG_PLUGIN),y)
>>>>>    # Test plugin memory access instrumentation
>>>>>    run-plugin-test-plugin-mem-access-with-libmem.so: \
>>>>>        PLUGIN_ARGS=$(COMMA)print-accesses=true
>>>>> @@ -197,8 +201,8 @@ run-plugin-test-plugin-mem-access-with-libmem.so: \
>>>>>        $(SRC_PATH)/tests/tcg/multiarch/check-plugin-output.sh \
>>>>>        $(QEMU) $<
>>>>> -test-plugin-mem-access: CFLAGS+=-pthread -O0
>>>>> -test-plugin-mem-access: LDFLAGS+=-pthread -O0
>>>>> +EXTRA_RUNS += run-plugin-test-plugin-mem-access-with-libmem.so
>>>>> +endif
>>>>>    # Update TESTS
>>>>>    TESTS += $(MULTIARCH_TESTS)
>>>>> diff --git a/tests/tcg/multiarch/system/Makefile.softmmu-target b/tests/tcg/multiarch/system/Makefile.softmmu-target
>>>>> index 5acf2700812..4171b4e6aa0 100644
>>>>> --- a/tests/tcg/multiarch/system/Makefile.softmmu-target
>>>>> +++ b/tests/tcg/multiarch/system/Makefile.softmmu-target
>>>>> @@ -71,8 +71,11 @@ endif
>>>>>    MULTIARCH_RUNS += run-gdbstub-memory run-gdbstub-interrupt \
>>>>>        run-gdbstub-untimely-packet run-gdbstub-registers
>>>>> +ifeq ($(CONFIG_PLUGIN),y)
>>>>>    # Test plugin memory access instrumentation
>>>>> -run-plugin-memory-with-libmem.so:         \
>>>>> -    PLUGIN_ARGS=$(COMMA)region-summary=true
>>>>> -run-plugin-memory-with-libmem.so:         \
>>>>> -    CHECK_PLUGIN_OUTPUT_COMMAND=$(MULTIARCH_SYSTEM_SRC)/validate-memory-counts.py $@.out
>>>>> +run-plugin-memory-with-libmem.so: memory libmem.so
>>>>> +run-plugin-memory-with-libmem.so: PLUGIN_ARGS=$(COMMA)region-summary=true
>>>>> +run-plugin-memory-with-libmem.so: CHECK_PLUGIN_OUTPUT_COMMAND=$(MULTIARCH_SYSTEM_SRC)/validate-memory-counts.py $@.out
>>>>> +
>>>>> +EXTRA_RUNS += run-plugin-memory-with-libmem.so
>>>>> +endif
>>>>
>>>> I'm not sure how it's related, but check-tcg on aarch64 host now fails [1] since this series was merged, and I suspect it may be related to this patch. I didn't spend time to reproduce and investigate it.
>>>>
>>>> [1] https://github.com/pbo-linaro/qemu-ci/actions/runs/16575679153/job/46879690693
>>>
>>> I was not able to reproduce it locally on 22.04, but in the CI indeed the test command is missing the "test-plugin-mem-access" binary at the end, just before redirection to .so.out, it should be:
>>>
>>> [...] -D test-plugin-mem-access-with-libmem.so.pout test-plugin-mem-access >  run-plugin-test-plugin-mem-access-with-libmem.so.out
>>>
>>> not:
>>>
>>> [...] -D test-plugin-mem-access-with-libmem.so.pout  >  run-plugin-test-plugin-mem-access-with-libmem.so.out
>>
>> The problem is that the new rules generated by a shuffled combination of tests and plugin
>> (the one using eval) sometimes does not include the rule for the test+plugin combination
>> passed via EXTRA_RUNs.
>>
>> So EXTRA_RUNS tests like run-plugin-test-plugin-mem-access-with-libmem.so might end up
>> with a proper rule if the test test-plugin-mem-access is combined with other plugin
>> randomly, since now a plugin is picked up based on a tests index _idx modulo with the
>> number of plugins.
>>
>> A possible fix is to generate correctly the rules for the tests with plugins passed
>> via EXTRA_RUNS and ideally, following the patch's mood, remove the test from running
>> if any other plugin (no shuffle with any other plugin).
>>
>> Of course, as Pierrick said, this patch could be a premature optimization. So maybe
>> it doesn´t justify adding more complexity to our Makefile (Makefiles are hard to debug,
>> with 'eval' tricks, it's _reallly_ hard, so the more we avoid it the better).
>>
>> That said, if we want to keep this commit, I've kicked off a test to fix it here:
>>
>> https://gitlab.com/gusbromero/qemu/-/pipelines/1959953122
>>
>> and sent the fix to the ML too. HTH.
>>
> 
> Thanks for taking a look at this Gustavo.
> 
> In the pipeline you shared, the build-some-softmmu fails with:
> Makefile:210: *** multiple target patterns.  Stop.
> make: *** [/builds/gusbromero/qemu/tests/Makefile.include:50: build-tcg-tests-x86_64-softmmu] Error 2
> make: *** Waiting for unfinished jobs....
> 
> Is that a new bug related to current patch?

v2 was busted. Please consider this fix, which passed the test pipeline:

https://gitlab.com/gusbromero/qemu/-/pipelines/1960296034

https://mail.gnu.org/archive/html/qemu-devel/2025-07/msg06926.html


Cheers,
Gustavo

