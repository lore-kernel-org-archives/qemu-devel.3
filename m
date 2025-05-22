Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98DCDC54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 10:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI3HC-0000eB-Qp; Thu, 22 May 2025 06:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uI3H8-0000aS-R1
 for qemu-devel@nongnu.org; Thu, 22 May 2025 06:35:46 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uI3H2-0007Dc-Ie
 for qemu-devel@nongnu.org; Thu, 22 May 2025 06:35:46 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-23274dbcbc2so28788565ad.1
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 03:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1747910138; x=1748514938;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+/YDTvjOrO7IViJpwqQz7zuEkqIdZ05kpcKcNyN8J4M=;
 b=Oh9kbh2ssSvOkPww/UKxcXeCTUjeiTO/RurAedsDgnOzisWKi0HSzQiwlilay+tvz2
 3kVGxJ4iRmQs33a+GKCpVbu5dkINAXFaLXNhYTaiM2Yg6+1JkdASmVwlhTs/YlqqshsG
 16Zj6WJUzOcWUaewTmBcT5/Q+rHBvdra5U9r6sZNb2JaqstMXKxLrePN0YY3mQ7uP9W1
 L6qC93TT4OlFms7SahP65ZqkdBDo07OsBSLAwxWs7h/bj/0KVulLqOquOyNmYsi/POtn
 IabSHBP7BAw2qq+oUAZJ648CWLwGj8e9nQcuNeS80bqNrTFH70WyhyOa8GE5Id7wcXaM
 CbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747910138; x=1748514938;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+/YDTvjOrO7IViJpwqQz7zuEkqIdZ05kpcKcNyN8J4M=;
 b=QDSsb7PIXoNjC9uALKyuFDHQM8Hi6nkXteK0zcj+TB6lbyLh3BGajehHaOAgNR+piQ
 o4FlsL2OKPfOlK/JxvSNOxeXh9xSNvpU8Tf8GZ4jf8NZ5YZ8aAy3e9FSuxJjiwHBQrah
 KN6kGBiOBP6w7P0cCnobl2mOvxeNx7IIKvmmI4umdSjw4hvjv6WRe6FvAUzspoFOLrOe
 R4DEzsqa7kF6ng/v6MASWmvQwEpdjC+B6yt5Pg+w5ksQdd903vkBxSzc40cTd0HB/oB+
 W2eObW5ExDTrpbGo79+C0Dn8qy2Vw+bdz6tnl3icS+OXVd/02yNAw3OBZfxVQQvVJu4t
 Mzgw==
X-Gm-Message-State: AOJu0Yyg43s7R+JLMZctVrMAvgODEs3EpEtESy+YznW+UNpq73u9QkoR
 vR1yoNKcs9KwZBUzOfh0xEatrFMTeZTVRgeB+9faDE7t1iV7F0nYpo5ufjAcIQ315RE=
X-Gm-Gg: ASbGncsTc7SYNuSsLlIqKyBDc/AEDnDA9DtAkRHnDekDUyCm8xmLOZSOClE9XJcoBRW
 1Mf6XvO8txSBcQ8iLIzMR387Mc+re7pqBmYda3OwNXARQyLddpHyejbEqX/nPP58zjU7jsp57GI
 vcfK8MD9R1G6pOXe6MQPigVB46v87cwpjrvXwUFwz3tXldq6XIVbwhEbNbPWpbGwPctWqbfuy47
 g/Qpsmy9Za65SlRsRVqb9LWM6kJHw9EY0MVUX8qy4wKm5YmwbQJTpupAV6tO6rWi++e4e0MsO3e
 2PKvzPdOB4yEfpa5YE17mEMHxDraXbABIwFdnSjryE+cavbMG5dP1WtTcmuVHA==
X-Google-Smtp-Source: AGHT+IHPFoFO3WKSRS7xIIAWlCB5S5nbksA/ArsxSJDa7Gg8WdftYamfFsrAIi6ZHaCv3EColsvO8g==
X-Received: by 2002:a17:902:dac5:b0:22e:4509:cb89 with SMTP id
 d9443c01a7336-231de21d4d5mr323170165ad.0.1747910137815; 
 Thu, 22 May 2025 03:35:37 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4ade028sm106776165ad.82.2025.05.22.03.35.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 May 2025 03:35:37 -0700 (PDT)
Message-ID: <3d16d571-0f71-49e0-b2d2-b1a144e92e26@daynix.com>
Date: Thu, 22 May 2025 19:35:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/20] tests/Makefile: include test-plugins in per-arch
 build deps
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20250521164250.135776-1-alex.bennee@linaro.org>
 <20250521164250.135776-6-alex.bennee@linaro.org>
 <15677d5c-cd86-4d75-a21e-0c011800cd55@daynix.com>
 <87tt5d6ina.fsf@draig.linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87tt5d6ina.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2025/05/22 19:31, Alex Bennée wrote:
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> On 2025/05/22 1:42, Alex Bennée wrote:
>>> The user can run a subset of the tcg tests directly, e.g.:
>>>     make run-tcg-tests-hexagon-linux-user
>>> but in this case we fail if there has not been a full build to
>>> ensure
>>> all the test-plugins are there. Fix the dependency to ensure we always
>>> will build them before running tests.
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> ---
>>>    tests/Makefile.include | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>>> index 23fb722d42..7f7f62cbf6 100644
>>> --- a/tests/Makefile.include
>>> +++ b/tests/Makefile.include
>>> @@ -46,7 +46,7 @@ $(foreach TARGET,$(TCG_TESTS_TARGETS), \
>>>            $(eval $(BUILD_DIR)/tests/tcg/config-$(TARGET).mak: config-host.mak))
>>>      .PHONY: $(TCG_TESTS_TARGETS:%=build-tcg-tests-%)
>>> -$(TCG_TESTS_TARGETS:%=build-tcg-tests-%): build-tcg-tests-%: $(BUILD_DIR)/tests/tcg/config-%.mak
>>> +$(TCG_TESTS_TARGETS:%=build-tcg-tests-%): build-tcg-tests-%: $(BUILD_DIR)/tests/tcg/config-%.mak test-plugins
>>
>> I don't think this is going to work.
>>
>> test-plugins will invoke run-ninja, which is defined as follows:
>>
>> run-ninja: config-host.mak
>> ifneq ($(filter $(ninja-targets), $(ninja-cmd-goals)),)
>> 	+$(if $(MAKE.nq),@:,$(quiet-@)$(NINJA) $(NINJAFLAGS) \
>> 	   $(sort $(filter $(ninja-targets), $(ninja-cmd-goals))) | cat)
>>
>> $(ninja-cmd-goals) should contain test-plugins, but it doesn't if I
>> understand it correctly.
> 
> It certainly does:
> 
> ➜  rm -rf tests/tcg/plugins/
> 🕙11:31:03 alex@draig:qemu.git/builds/all  on  HEAD (61e51c3) (REBASING 5/26) [$?]
> ➜  make test-plugins
> /home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/meson introspect --targets --tests --benchmarks | /home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/python3 -B scripts/mtest2make.py > Makefile.mtest
> [1/14] Compiling C object tests/tcg/plugins/libbb.so.p/bb.c.o
> [2/14] Linking target tests/tcg/plugins/libbb.so
> [3/14] Compiling C object tests/tcg/plugins/libempty.so.p/empty.c.o
> [4/14] Linking target tests/tcg/plugins/libempty.so
> [5/14] Compiling C object tests/tcg/plugins/libinline.so.p/inline.c.o
> [6/14] Linking target tests/tcg/plugins/libinline.so
> [7/14] Compiling C object tests/tcg/plugins/libinsn.so.p/insn.c.o
> [8/14] Linking target tests/tcg/plugins/libinsn.so
> [9/14] Compiling C object tests/tcg/plugins/libmem.so.p/mem.c.o
> [10/14] Linking target tests/tcg/plugins/libmem.so
> [11/14] Compiling C object tests/tcg/plugins/libreset.so.p/reset.c.o
> [12/14] Linking target tests/tcg/plugins/libreset.so
> [13/14] Compiling C object tests/tcg/plugins/libsyscall.so.p/syscall.c.o
> [14/14] Linking target tests/tcg/plugins/libsyscall.so
> 

ninja-cmd-goals is defined as follows:

ninja-cmd-goals = $(or $(MAKECMDGOALS), all)
ninja-cmd-goals += $(foreach g, $(MAKECMDGOALS), $(.ninja-goals.$g))

If you run "make test-plugins", $(ninja-cmd-goals) will contain 
"test-plugins" because $(MAKECMDGOALS) will be "test-plugins". It won't 
if you run "make run-tcg-tests-hexagon-linux-user".

Regards,
Akihiko Odaki

