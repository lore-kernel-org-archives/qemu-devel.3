Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD47C54E90
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 15:19:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJD7J-0003w4-J9; Sun, 25 May 2025 11:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJD7F-0003vV-Ew
 for qemu-devel@nongnu.org; Sun, 25 May 2025 11:18:21 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJD7D-0006sQ-KY
 for qemu-devel@nongnu.org; Sun, 25 May 2025 11:18:21 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a361b8a66cso926761f8f.2
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 08:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748186297; x=1748791097; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AU1Q4g4d+sPgmefKQY1CITlBd+gjy/DQcmEiu6cXEX0=;
 b=gtr85izrepz/EMqNUQyEAMREHlbGYLAw8/oiGUZqspP/dWWmopqOU3c2yEOdurRNs4
 Vy1rSMGl1ZL0w6gVTFjEjAU3msP98B5SJwLqdkAtMqgCSZQgoZWpNVA8iOsk43RwGQpV
 xhcn4OX/wFqUQS6dR4ZDTlHUVzsazlJSCK+BtSgNZh1aIBSmpPNZg3zcfw0pGOpa8tW/
 FvNxhDNLk4s5j7MndpItKvxczl91WTW0avN0DWpbpj2t/jREqT/C4XM8UDXNlakd8ULV
 DAVzAuclo/enihYPFzRQMssnGjCJ1TQ6GftPc/YyK7CKixvnI0PBoGCZJae5thCtejH8
 RMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748186297; x=1748791097;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AU1Q4g4d+sPgmefKQY1CITlBd+gjy/DQcmEiu6cXEX0=;
 b=DT/R2tPYAn54hsbelHCPcNAaMCWMhHhYNwVu9EGGcClKnLYwTw0Y1SYoGTehktwkYb
 nXhzyfrGcQdYXKFjuYttn+a6eYX18t8YH9SOUtAWrEuRiBl0H+1wQabQFD5lbN4KBBJK
 hh3MF3hrOu/aThQr0sFqE8nn2RMB/K5pb4nCqMfTXD+vMf9FlmDAFAtNSLd/smMO5kzL
 btWhbV2nxjdaICARH36iBSL7dMnXrgQsLt83hFNkFsHIwY7qntXFEDl4sCnNtg8VmZFQ
 LhIpt9kA3gwH/oj1EwZl/7YHsikg8BAuSBpAXlZUxD4zaZBbJMQJrWqj6ZhVo6tV2Psv
 75Fg==
X-Gm-Message-State: AOJu0YyhBDNcjtNFJWUTgI7WM1IwCC4gM4P1GKr9nxJbVTlEmWvjX3ue
 YaivseQXrf0qkSR4UrDm7hE5JvHtufNyVgboVGoYB4PdFecvi0ZNO2wW248e/9Cpb6k=
X-Gm-Gg: ASbGncv8SR+6u0HwgFmyOrdinZThuCYSmMIKOgv2QKvxtX5YC2fFpiEIFdNq3eGCZ4s
 e2R8Y7WWWRwR0JzhKVfwwy+UKzCW7NHxWVtxhDa4mxjBAIquYTz/WbJ/+CfujUQ7YtpE3YiISvd
 FocMqV8zvGqneUwtP4xtNtBOuwrygkp55GETgVmTJMLqpGlngufUAJktprKHy/GK04Sbf4KmyYn
 AOTgpSoDTMPy2FWQl+17A9oXoLRi5GtiX9CGuVNVTUTROeO5mHXe3T/98cN3kHB3gwFEr9PhCtx
 OGSj54YekJwue0d9tLm+gLMumup+I8tZA65iOTAy+MtmlbC84vSS0Vo9MBeQqnACLBN7iSS25PO
 ZR3T4zBaeDCxXsAbufnuC+NanHXQ=
X-Google-Smtp-Source: AGHT+IHmcppg9n0GaY9pi7P2vIAqY5tP4DjM0K2YxvBfyRU1ZKtvNwwyeXx6ahuwsXnn2igEWFqOcQ==
X-Received: by 2002:a05:6000:178e:b0:3a1:f702:4589 with SMTP id
 ffacd0b85a97d-3a4cb4743d5mr5611949f8f.35.1748186297279; 
 Sun, 25 May 2025 08:18:17 -0700 (PDT)
Received: from [10.132.0.213] (17.red-95-127-33.staticip.rima-tde.net.
 [95.127.33.17]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4ccc2c88dsm5076314f8f.69.2025.05.25.08.18.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 May 2025 08:18:16 -0700 (PDT)
Message-ID: <0eb288d2-413a-4e4c-8bd1-fc3fad340b3c@linaro.org>
Date: Sun, 25 May 2025 17:18:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/20] tests/Makefile: include test-plugins in per-arch
 build deps
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20250521164250.135776-1-alex.bennee@linaro.org>
 <20250521164250.135776-6-alex.bennee@linaro.org>
 <15677d5c-cd86-4d75-a21e-0c011800cd55@daynix.com>
 <87tt5d6ina.fsf@draig.linaro.org>
 <3d16d571-0f71-49e0-b2d2-b1a144e92e26@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <3d16d571-0f71-49e0-b2d2-b1a144e92e26@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 22/5/25 11:35, Akihiko Odaki wrote:
> On 2025/05/22 19:31, Alex Bennée wrote:
>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>
>>> On 2025/05/22 1:42, Alex Bennée wrote:
>>>> The user can run a subset of the tcg tests directly, e.g.:
>>>>     make run-tcg-tests-hexagon-linux-user
>>>> but in this case we fail if there has not been a full build to
>>>> ensure
>>>> all the test-plugins are there. Fix the dependency to ensure we always
>>>> will build them before running tests.
>>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>>> ---
>>>>    tests/Makefile.include | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>>>> index 23fb722d42..7f7f62cbf6 100644
>>>> --- a/tests/Makefile.include
>>>> +++ b/tests/Makefile.include
>>>> @@ -46,7 +46,7 @@ $(foreach TARGET,$(TCG_TESTS_TARGETS), \
>>>>            $(eval $(BUILD_DIR)/tests/tcg/config-$(TARGET).mak: 
>>>> config-host.mak))
>>>>      .PHONY: $(TCG_TESTS_TARGETS:%=build-tcg-tests-%)
>>>> -$(TCG_TESTS_TARGETS:%=build-tcg-tests-%): build-tcg-tests-%: 
>>>> $(BUILD_DIR)/tests/tcg/config-%.mak
>>>> +$(TCG_TESTS_TARGETS:%=build-tcg-tests-%): build-tcg-tests-%: 
>>>> $(BUILD_DIR)/tests/tcg/config-%.mak test-plugins
>>>
>>> I don't think this is going to work.
>>>
>>> test-plugins will invoke run-ninja, which is defined as follows:
>>>
>>> run-ninja: config-host.mak
>>> ifneq ($(filter $(ninja-targets), $(ninja-cmd-goals)),)
>>>     +$(if $(MAKE.nq),@:,$(quiet-@)$(NINJA) $(NINJAFLAGS) \
>>>        $(sort $(filter $(ninja-targets), $(ninja-cmd-goals))) | cat)
>>>
>>> $(ninja-cmd-goals) should contain test-plugins, but it doesn't if I
>>> understand it correctly.
>>
>> It certainly does:
>>
>> ➜  rm -rf tests/tcg/plugins/
>> 🕙11:31:03 alex@draig:qemu.git/builds/all  on  HEAD (61e51c3) 
>> (REBASING 5/26) [$?]
>> ➜  make test-plugins
>> /home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/meson introspect -- 
>> targets --tests --benchmarks | /home/alex/lsrc/qemu.git/builds/all/ 
>> pyvenv/bin/python3 -B scripts/mtest2make.py > Makefile.mtest
>> [1/14] Compiling C object tests/tcg/plugins/libbb.so.p/bb.c.o
>> [2/14] Linking target tests/tcg/plugins/libbb.so
>> [3/14] Compiling C object tests/tcg/plugins/libempty.so.p/empty.c.o
>> [4/14] Linking target tests/tcg/plugins/libempty.so
>> [5/14] Compiling C object tests/tcg/plugins/libinline.so.p/inline.c.o
>> [6/14] Linking target tests/tcg/plugins/libinline.so
>> [7/14] Compiling C object tests/tcg/plugins/libinsn.so.p/insn.c.o
>> [8/14] Linking target tests/tcg/plugins/libinsn.so
>> [9/14] Compiling C object tests/tcg/plugins/libmem.so.p/mem.c.o
>> [10/14] Linking target tests/tcg/plugins/libmem.so
>> [11/14] Compiling C object tests/tcg/plugins/libreset.so.p/reset.c.o
>> [12/14] Linking target tests/tcg/plugins/libreset.so
>> [13/14] Compiling C object tests/tcg/plugins/libsyscall.so.p/syscall.c.o
>> [14/14] Linking target tests/tcg/plugins/libsyscall.so
>>
> 
> ninja-cmd-goals is defined as follows:
> 
> ninja-cmd-goals = $(or $(MAKECMDGOALS), all)
> ninja-cmd-goals += $(foreach g, $(MAKECMDGOALS), $(.ninja-goals.$g))
> 
> If you run "make test-plugins", $(ninja-cmd-goals) will contain "test- 
> plugins" because $(MAKECMDGOALS) will be "test-plugins". It won't if you 
> run "make run-tcg-tests-hexagon-linux-user".

It seems Akihiko is right, this patch doesn't fix my use case.


