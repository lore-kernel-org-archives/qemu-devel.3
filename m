Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB2EDC5B559
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 09:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNTlM-0002Pn-S1; Fri, 06 Jun 2025 05:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uNTlL-0002PI-DY
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 05:53:23 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uNTlG-0004u3-HE
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 05:53:23 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7426c44e014so1764680b3a.3
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 02:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1749203596; x=1749808396;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zyGGDdqKLGQ5Qjzh9tHsAmQaWbcXMWVth0sP35Y6J7U=;
 b=ZieLl2NnqXmVVsU9xdh2K+3i3F3+fMFjNmJ5RUYtRpBjfutdzN1WnkBM2vRazeNd4h
 BcHCyN0jLGiV4XYloHWRcDUS64tuDrhfnsN1donPZGiRsbN2iHV0bIlr1kkS70+uiJge
 PbDYb13PzCP9rgror1hqIRrNrKGTnLOqKwnR6exHGCvbDGBMJNRyULHt3CwSqAg/l054
 UkmxxD9fsma81F8Fve1PBWX4oPO/zQ99LZH6Gc+ETg3Z5tGIQ7l09INGixgy0wJ9nuVi
 dsZ2eji/TNdrStxBhGvZ2phjTk3reNZqZTGke5LYH3cmuO7kkPH49SKmAr42aCOuANDL
 +D7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749203596; x=1749808396;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zyGGDdqKLGQ5Qjzh9tHsAmQaWbcXMWVth0sP35Y6J7U=;
 b=Z26zVg714dZ5Cn4atGm5B55wMOK2B/3WtUapkm7ztpSFPElP22znR3KWuLnfnaDjiz
 KvzyyBZTSBUqx6V/RTT2u5uCSxY/2MTRYNwZ1rsCpve0XFq313I+GviqWkHcgKJnWyT5
 ICUDZvbQNrWUseH9PWvMAHxOBfAzXFxRW739Eo7V82GzpVPmfrGT7KJqLLYv8HsI0tJ1
 kY4aY4/sovs3P/02SWyICjTA+ne78VFEebM/C2pov4+Qt6eyg4m0m2kAmZtWwd6SXlvG
 tCScXm6a/UdVKxCWT/Q2Uef6KIEanPqs2mr3R6Boeh52YNRGSikjyXmiv9xyy3wFOCjg
 BYHA==
X-Gm-Message-State: AOJu0Yzsvvy92AXCEjZNeYtxSrhSeHR//WfAlmwDOV2R2YZH+uTETMNK
 rj5nsIIlLGMTpBSBTZsGcVuDiuLn+Ajmkc8YejM0eLy0cc0Pgn6AZjTviHibbxhI6jw=
X-Gm-Gg: ASbGnctPvAz6Ethq1VgAqVkEfzeYE0vFSoPAMOG5ljXdjd9xBsRshVHsk3zlh4GWVzs
 pq9ESrnS702JaxHZM5AH9fm+J7dNMu66XbOj5hiMZ5tK6f3QlxkC1WM/+xSWCZWmqWxcChSIbWU
 0lqFG9JTzUhNFT45Egbi840k1Iuc2L77EP3qdByoKoldS8lByxVe6MZPMqCNg3YhyYIKLciufMQ
 x44D14Co6qsbidZ3GkiAy4TjRkviktuivRvMwNPK1IiuFatoNPWYGtRG8tcSEn6wBe6Px8ra+BM
 v6cl/f/cPJSYR+R8FFDbqW8YcFIXhzHWYLZYO/dDyHN/af6HaQ7KucmRtvKMKRh42SSSmvwfOTs
 =
X-Google-Smtp-Source: AGHT+IFsX2go6gkm4lPQgiZ5tXWGlQ94n5acYh72a0S9gWitYRJWlx9gQFkid5lkcAnZmv21gyXPGg==
X-Received: by 2002:aa7:888a:0:b0:746:2ae9:fc42 with SMTP id
 d2e1a72fcca58-74827f1260bmr4563595b3a.19.1749203596160; 
 Fri, 06 Jun 2025 02:53:16 -0700 (PDT)
Received: from [157.82.203.223] ([157.82.203.223])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7482af7b4b9sm937013b3a.71.2025.06.06.02.53.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Jun 2025 02:53:15 -0700 (PDT)
Message-ID: <a9574643-ec5b-4c8c-aff5-3660c6c701fb@daynix.com>
Date: Fri, 6 Jun 2025 18:53:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/17] tests/tcg: make aarch64 boot.S handle different
 starting modes
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20250603110204.838117-1-alex.bennee@linaro.org>
 <20250603110204.838117-4-alex.bennee@linaro.org>
 <e037e38c-dd8d-4f65-b2d5-2629be5f6740@daynix.com>
 <874iwu372j.fsf@draig.linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <874iwu372j.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42e.google.com
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

On 2025/06/05 17:51, Alex Bennée wrote:
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> On 2025/06/03 20:01, Alex Bennée wrote:
>>> Currently the boot.S code assumes everything starts at EL1. This will
>>> break things like the memory test which will barf on unaligned memory
>>> access when run at a higher level.
>>> Adapt the boot code to do some basic verification of the starting
>>> mode
>>> and the minimal configuration to move to the lower exception levels.
>>> With this we can run the memory test with:
>>>     -M virt,secure=on
>>>     -M virt,secure=on,virtualization=on
>>>     -M virt,virtualisation=on
>>> If a test needs to be at a particular EL it can use the semihosting
>>> command line to indicate the level we should execute in.
>>> Cc: Julian Armistead <julian.armistead@linaro.org>
>>> Cc: Jim MacArthur <jim.macarthur@linaro.org>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> ---
>>> v4
>>>     - drop post eret nops
>>>     - proper error string for EL0 error case
>>>     - clamp any invalid target EL value to 1
>>> v3
>>>     - create system stack so we _exit cleanly
>>>     - normalise EL string before compares
>>>     - catch when we start in a lower EL than we asked for
>>>     - default to EL1 when arg unclear
>>> v2
>>>     - allow tests to control the final EL we end up at
>>>     - use tabs consistently
>>>     - validate command line arg is between 1 and 3
>>> ---
>>>    tests/tcg/aarch64/Makefile.softmmu-target |   3 +-
>>>    tests/tcg/aarch64/system/boot.S           | 172 +++++++++++++++++++++-
>>>    2 files changed, 169 insertions(+), 6 deletions(-)
>>> diff --git a/tests/tcg/aarch64/Makefile.softmmu-target
>>> b/tests/tcg/aarch64/Makefile.softmmu-target
>>> index 9c52475b7a..f7a7d2b800 100644
>>> --- a/tests/tcg/aarch64/Makefile.softmmu-target
>>> +++ b/tests/tcg/aarch64/Makefile.softmmu-target
>>> @@ -68,7 +68,8 @@ run-plugin-semiconsole-with-%: semiconsole
>>>      # vtimer test needs EL2
>>>    QEMU_EL2_MACHINE=-machine virt,virtualization=on,gic-version=2 -cpu cortex-a57 -smp 4
>>> -run-vtimer: QEMU_OPTS=$(QEMU_EL2_MACHINE) $(QEMU_BASE_ARGS) -kernel
>>> +QEMU_EL2_BASE_ARGS=-semihosting-config enable=on,target=native,chardev=output,arg="2"
>>> +run-vtimer: QEMU_OPTS=$(QEMU_EL2_MACHINE) $(QEMU_EL2_BASE_ARGS) -kernel
>>>      # Simple Record/Replay Test
>>>    .PHONY: memory-record
>>> diff --git a/tests/tcg/aarch64/system/boot.S b/tests/tcg/aarch64/system/boot.S
>>> index a5df9c173d..8bfa4e4efc 100644
>>> --- a/tests/tcg/aarch64/system/boot.S
>>> +++ b/tests/tcg/aarch64/system/boot.S
>>> @@ -16,6 +16,7 @@
>>>    #define semihosting_call hlt 0xf000
>>>    #define SYS_WRITEC	0x03	/* character to debug channel */
>>>    #define SYS_WRITE0	0x04	/* string to debug channel */
>>> +#define SYS_GET_CMDLINE 0x15	/* get command line */
>>>    #define SYS_EXIT	0x18
>>>      	.align	12
>>> @@ -70,21 +71,172 @@ lower_a32_sync:
>>>    lower_a32_irq:
>>>    lower_a32_fiq:
>>>    lower_a32_serror:
>>> +	adr	x1, .unexp_excp
>>> +exit_msg:
>>>    	mov	x0, SYS_WRITE0
>>> -	adr	x1, .error
>>>    	semihosting_call
>>>    	mov	x0, 1 /* EXIT_FAILURE */
>>>    	bl 	_exit
>>>    	/* never returns */
>>>      	.section .rodata
>>> -.error:
>>> -	.string "Terminated by exception.\n"
>>> +.unexp_excp:
>>> +	.string "Unexpected exception.\n"
>>> +.high_el_msg:
>>> +	.string "Started in lower EL than requested.\n"
>>> +.unexp_el0:
>>> +	.string "Started in invalid EL.\n"
>>> +
>>> +	.align 8
>>> +.get_cmd:
>>
>> Please do not send a new version without addressing all comments for
>> the previous versions or at least noting there are unaddressed
>> comments:
>> https://lore.kernel.org/qemu-devel/7a76e746-9022-48cf-8216-775071e6d631@daynix.com
>>
>> Following the best practices in docs/devel/submitting-a-patch.rst will
>> ensure a smoother patch review. It is fine for me if you submit a new
>> version noting unaddressed comments, but some may disagree.
> 
> There is no style guide for assembler. I have made the strings
> consistently use the . prefix.
> 

Global symbols share the symbol space with C so the naming convention of 
C can be applied to assembly too.

I also pointed out it ".error" was prefixed with a dot probably due to a 
failed attempt to make it local. There is no point of following a mistake.

I don't see a reason to differentiate the string labels from the others 
either.

Regards,
Akihiko Odaki

