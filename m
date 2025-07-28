Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C982C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 19:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugT8k-0005q1-0s; Mon, 28 Jul 2025 15:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ugT8a-0005U3-Gf
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 15:03:52 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ugT8Y-0008JI-5C
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 15:03:52 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b39011e5f8eso4314994a12.0
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 12:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753729427; x=1754334227; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pBRyDUNgBOA4QTIn6mvgi9er0LF8P65ip+Wv6937VFE=;
 b=OgexqsyAFsMelcuP+Wc+EFtkFx2uVZMMa6ZU7LImujLbaSuO/2gaGToEMY/n/Phjjg
 HVK/BV3nkXbrcgpLINniB0RZWPWsUeWdQonNl+bHfURKN+xMWVqVI1f7KR0du4NAsh5o
 sSQyBur4EPklKpmghXvFyNxzFia/32QT0ReRgbUs3Z6ufuL4Pb6tYMmrFJDPr/Eo723F
 D6MHHy8j2WZiKRyGMHJJgYMX2gNLCOTw+TNNKBkee2/j9IISDkMhfqc+YldYlAbw9J8Z
 GIN3gkl8yyZ6JJPoDjBBtT11D012K2Lln/Salh5FfN/YHvj/fWcAgZAOO03ezqPShU1v
 d5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753729427; x=1754334227;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pBRyDUNgBOA4QTIn6mvgi9er0LF8P65ip+Wv6937VFE=;
 b=c5JgLsmIDoDc7fcmWPYReeNsrjbahsPvwRIpfEW23zIGkiKYntsuyRXEoNJj/MpN/I
 QaKOVsFToJIOTy8o86Gwcnmma/VT7c1iRScwu6gY3I0jnblTvkH0janVbf1HZHyqnCg2
 FD8oWD6cNF0jOJA5YcqzeS8qg8a4VO1vrukOFyoLgL9iCVXXK7F9ToopJgOQomfTj4F+
 MbTC3ivYmPQ0OuFyavm4G7HnHMlEU5dmM8PGofABBjGaMFTsvHnCESUdKIWr4i2/bWV/
 /n/YiHkk/g2W2cf2/exU2W40fdKkusJayDvTy58wMkXfdyJ1eNuDsYd4pFtDmnSILT2H
 hm5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQSz7yJ5QZFySwO76KUu9XziEKd9xbVVkKNIiK/FmnNsPdkFGxhb5Azjr3F4oYy9Q0ZU5UU0b85K9z@nongnu.org
X-Gm-Message-State: AOJu0YwsYJlNWgjcTvHGIR+9HQ2QknrlX8mkQ5dunXHsb9oNSQQMiNuJ
 go62m5DahiRo+M8zGaeuSAUlCGpdWrUKVdq2BQ8LUWitfVRjc8WVNTzfRrX1tdg+DV8=
X-Gm-Gg: ASbGnctt/anPA1Ls5rmgbRjypJaXO5N7fzvB/PPQ3r7GLzh0SzzWU4y2xH+sySw/S7B
 QodW0NynPunjJj+pmsWcUYMxvEAj+4Gr6cADvtF4/+z3i09KE4kR6ooJleFDUkJO/hxG7KzdKw2
 PU2dmHsPmN9IHdne6a2dKrhuFyBCgU0cls8gOEzvLH1oGeQG40BYxIJvDrS9ZvNkpFmViiaS099
 b5tn6Y6moqrWF4uP5Karb+wyimiN4obGIsPoYAYt+mA4X9zcCK3EwukZg0JRymmmFzk539FnfrA
 c26gAuY4qAeakkZbgFw/32v+WtQ8ZK1+2AeHiUNrbXfkA2VUhilPUIlScgGp0uyHqpefSi/NU3X
 HwvlXkB92h5GJobCCk5NNTYPXoRGW0h1GMZA=
X-Google-Smtp-Source: AGHT+IEsyjxu7uhmTRf4ORhIMXFW+Gbxnil0ALAvoUlKlxZFCXRT7xiHytYJY7CHUEAQz6d6poBg5w==
X-Received: by 2002:a17:90b:5103:b0:31f:253e:d34f with SMTP id
 98e67ed59e1d1-31f253ed3ecmr1378535a91.19.1753729427329; 
 Mon, 28 Jul 2025 12:03:47 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e6625068bsm10221540a91.5.2025.07.28.12.03.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 12:03:46 -0700 (PDT)
Message-ID: <eee5b640-6c65-4796-9b36-ca324f08c07c@linaro.org>
Date: Mon, 28 Jul 2025 12:03:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 11/14] tests/tcg: reduce the number of plugin tests
 combinations
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250727083254.3826585-1-alex.bennee@linaro.org>
 <20250727083254.3826585-12-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727083254.3826585-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52b.google.com
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

Hi Alex,

On 7/27/25 1:32 AM, Alex Bennée wrote:
> As our set of multiarch tests has grown the practice of running every
> plugin with every test is becoming unsustainable. If we switch to
> ensuring every test gets run with at least one plugin we can speed
> things up.
> 
> Some plugins do need to be run with specific tests (for example the
> memory instrumentation test). We can handle this by manually adding
> them to EXTRA_RUNS. We also need to wrap rules in a CONFIG_PLUGIN test
> so we don't enable the runs when plugins are not enabled.
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-ID: <20250725154517.3523095-12-alex.bennee@linaro.org>
> 
> diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
> index a12b15637ea..18afd5be194 100644
> --- a/tests/tcg/Makefile.target
> +++ b/tests/tcg/Makefile.target
> @@ -173,14 +173,25 @@ PLUGINS=$(filter-out $(DISABLE_PLUGINS), \
>   # We need to ensure expand the run-plugin-TEST-with-PLUGIN
>   # pre-requistes manually here as we can't use stems to handle it. We
>   # only expand MULTIARCH_TESTS which are common on most of our targets
> -# to avoid an exponential explosion as new tests are added. We also
> -# add some special helpers the run-plugin- rules can use below.
> +# and rotate the plugins so we don't grow too out of control as new
> +# tests are added. Plugins that need to run with a specific test
> +# should ensure they add their combination to EXTRA_RUNS.
>   
>   ifneq ($(MULTIARCH_TESTS),)
> -$(foreach p,$(PLUGINS), \
> -	$(foreach t,$(MULTIARCH_TESTS),\
> -		$(eval run-plugin-$(t)-with-$(p): $t $p) \
> -		$(eval RUN_TESTS+=run-plugin-$(t)-with-$(p))))
> +
> +NUM_PLUGINS := $(words $(PLUGINS))
> +NUM_TESTS := $(words $(MULTIARCH_TESTS))
> +
> +define mod_plus_one
> +  $(shell $(PYTHON) -c "print( ($(1) % $(2)) + 1 )")
> +endef
> +
> +$(foreach _idx, $(shell seq 1 $(NUM_TESTS)), \
> +	$(eval _test := $(word $(_idx), $(MULTIARCH_TESTS))) \
> +	$(eval _plugin := $(word $(call mod_plus_one, $(_idx), $(NUM_PLUGINS)), $(PLUGINS))) \
> +	$(eval run-plugin-$(_test)-with-$(_plugin): $(_test) $(_plugin)) \
> +	$(eval RUN_TESTS+=run-plugin-$(_test)-with-$(_plugin)))
> +
>   endif # MULTIARCH_TESTS
>   endif # CONFIG_PLUGIN
>   
> diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
> index bfdf7197a7b..38345ff8805 100644
> --- a/tests/tcg/multiarch/Makefile.target
> +++ b/tests/tcg/multiarch/Makefile.target
> @@ -189,6 +189,10 @@ run-plugin-semiconsole-with-%:
>   TESTS += semihosting semiconsole
>   endif
>   
> +test-plugin-mem-access: CFLAGS+=-pthread -O0
> +test-plugin-mem-access: LDFLAGS+=-pthread -O0
> +
> +ifeq ($(CONFIG_PLUGIN),y)
>   # Test plugin memory access instrumentation
>   run-plugin-test-plugin-mem-access-with-libmem.so: \
>   	PLUGIN_ARGS=$(COMMA)print-accesses=true
> @@ -197,8 +201,8 @@ run-plugin-test-plugin-mem-access-with-libmem.so: \
>   	$(SRC_PATH)/tests/tcg/multiarch/check-plugin-output.sh \
>   	$(QEMU) $<
>   
> -test-plugin-mem-access: CFLAGS+=-pthread -O0
> -test-plugin-mem-access: LDFLAGS+=-pthread -O0
> +EXTRA_RUNS += run-plugin-test-plugin-mem-access-with-libmem.so
> +endif
>   
>   # Update TESTS
>   TESTS += $(MULTIARCH_TESTS)
> diff --git a/tests/tcg/multiarch/system/Makefile.softmmu-target b/tests/tcg/multiarch/system/Makefile.softmmu-target
> index 5acf2700812..4171b4e6aa0 100644
> --- a/tests/tcg/multiarch/system/Makefile.softmmu-target
> +++ b/tests/tcg/multiarch/system/Makefile.softmmu-target
> @@ -71,8 +71,11 @@ endif
>   MULTIARCH_RUNS += run-gdbstub-memory run-gdbstub-interrupt \
>   	run-gdbstub-untimely-packet run-gdbstub-registers
>   
> +ifeq ($(CONFIG_PLUGIN),y)
>   # Test plugin memory access instrumentation
> -run-plugin-memory-with-libmem.so: 		\
> -	PLUGIN_ARGS=$(COMMA)region-summary=true
> -run-plugin-memory-with-libmem.so: 		\
> -	CHECK_PLUGIN_OUTPUT_COMMAND=$(MULTIARCH_SYSTEM_SRC)/validate-memory-counts.py $@.out
> +run-plugin-memory-with-libmem.so: memory libmem.so
> +run-plugin-memory-with-libmem.so: PLUGIN_ARGS=$(COMMA)region-summary=true
> +run-plugin-memory-with-libmem.so: CHECK_PLUGIN_OUTPUT_COMMAND=$(MULTIARCH_SYSTEM_SRC)/validate-memory-counts.py $@.out
> +
> +EXTRA_RUNS += run-plugin-memory-with-libmem.so
> +endif

I'm not sure how it's related, but check-tcg on aarch64 host now fails 
[1] since this series was merged, and I suspect it may be related to 
this patch. I didn't spend time to reproduce and investigate it.

[1] 
https://github.com/pbo-linaro/qemu-ci/actions/runs/16575679153/job/46879690693

