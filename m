Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE65CD3F081
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 15:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl7lt-0000rI-VP; Wed, 28 Jan 2026 10:47:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vl7ls-0000l7-1C
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 10:47:56 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vl7ln-0003ut-0M
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 10:47:55 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-8230d228372so3326284b3a.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 07:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769615264; x=1770220064; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y5HIVG56hPf4UJpvnRh172kVvsxsgH6nS/kkZ/0ZIBE=;
 b=rEQEwYUNQ0DOmmi8MCQ41dMshsvDNvhMn3qMDM9j2nJtg5DrV85BqL+DIMad5c4O63
 kOI7CNRuq6pP1kBQfaaiPU5c5eZjk5nYhl1bbTXWaRKQF2sgplU9IBvbeoARLtS48ZWQ
 6R0uoXNjknE3qCg+jC3hh6qSheAcAOD0tTcQZZO2H663psxR62pk1S2OsjoHDIGCYWwL
 SBXElZ0DWDIYcEMoqQ4ziEnjXjb1ejWOQ8EQvZ4scLjezgmJH4cBZ8vORC5GAnyx2xHj
 9szI5Qc9ZVf2PD5SmDoO2vvO+mJmGlKp+BiB63kthtryMEmZyvq63ADr12uvnQPlNcOX
 oyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769615264; x=1770220064;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y5HIVG56hPf4UJpvnRh172kVvsxsgH6nS/kkZ/0ZIBE=;
 b=vdKE7TrS3/GNZ/q55dCWrTkNYO2X4YtSeaI7AGPpTOS7sLrgP8K9JBpyClQvBGVhds
 8MIvRZgrsXY8LUaKF89xhigDb7JWjDu6ooyKElAOsGjAu+KQa2/fGc0uP5n1W4FllgJL
 1ebgVaIxF4YNmJX0c5f1w8rXRBG33xykfXBM8ZKNquukXbdykhCj5z5XYWFnokYDOzjk
 5h+BIkzuDM2U2IQuQAZJ9n/d2eJq6rJPvSkPCj9r2cagLIXs7FhC3++lzs7NpHbGe6oE
 qEuhoOKLJZN07llDkXCVsxzmwgsjxymfGVUJt5c0q4TnDJ7fi7HfMqFJ7G2Yx7wT747r
 y4Ww==
X-Gm-Message-State: AOJu0YyFJv8sB5ix8AQRcW4CtBDDKeiKsAgkTys4ZeUVyzIZqgx++YNq
 1PTVp2unT40872FPKLNagdk9nDIzI8CTRqi6d7maMP3BCXNZ2c5U7l5Wv0sqS0DnCxc=
X-Gm-Gg: AZuq6aK5CcVM1y1ib6PpVe9zOfcu0dQrr+rUrNlMrvXZ4ryYIODmEZGYK1DuAdXlVBV
 VleIVUKPPf1ruW9hLnSWytgmxAPqL/glEO/Cm15VZqpgTYILnsWGi5WBiT7Gj+uc/3XiLLH7kQt
 RsuBN/lRIGdqQAX7/AWlEFBkjYTi6n8TSsdlwlmX6yPXdxddtNuGuNCJt9v7s4wwc4NiXUCKYyn
 0KAD0HsWAol6qrbIbpwyS9oHd+wpXXxNC3I/7yxbsSq9HAWWMJO+FnnrGoBkWV0nKcRqjidCvRM
 c5rxwmRErRKYjcsVEZbzMgaXcqBQqVwk3ddTvVwuEwiCw+xR43O1hGe/8CNRFwQr8vYWvrdWmJo
 UZe/+iIthWNsagJaGNJQUcVccnXGPbXBkj6Q0HlUSVb4Eo2g/6aGaKvDSYOldWYRCzWcUIo9gU1
 EiN7Nwv0U31W0nWio1UgsklCYLOtqbEqv6GnwxdkoCheeZgNhtmB3Bt6j5nYFvkMvwRhE=
X-Received: by 2002:a05:6a00:13a7:b0:81f:9907:e503 with SMTP id
 d2e1a72fcca58-8236917bdfbmr5659404b3a.16.1769615263850; 
 Wed, 28 Jan 2026 07:47:43 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379c22672sm2890170b3a.51.2026.01.28.07.47.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jan 2026 07:47:43 -0800 (PST)
Message-ID: <cd43d8bb-3567-4907-ad44-bf435dc967f0@linaro.org>
Date: Wed, 28 Jan 2026 07:47:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/11] plugins: use complete filename for defining
 plugins sources
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20260124182921.531562-1-pierrick.bouvier@linaro.org>
 <20260124182921.531562-4-pierrick.bouvier@linaro.org>
 <87cy2uat5e.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <87cy2uat5e.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

On 1/28/26 3:11 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   contrib/plugins/meson.build   | 10 +++++-----
>>   tests/tcg/plugins/meson.build |  7 +++++--
>>   2 files changed, 10 insertions(+), 7 deletions(-)
>>
>> diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
>> index 6915ffa5fbc..3d2d7862e0c 100644
>> --- a/contrib/plugins/meson.build
>> +++ b/contrib/plugins/meson.build
>> @@ -1,15 +1,15 @@
>> -contrib_plugins = ['bbv', 'cache', 'cflow', 'drcov', 'execlog', 'hotblocks',
>> -                   'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigger',
>> -                   'traps', 'uftrace']
>> +contrib_plugins = ['bbv.c', 'cache.c', 'cflow.c', 'drcov.c', 'execlog.c',
>> +                   'hotblocks.c', 'hotpages.c', 'howvec.c', 'hwprofile.c',
>> +                   'ips.c', 'stoptrigger.c', 'traps.c', 'uftrace.c']
> 
> Argh this keeps conflicting with other changes. Maybe we should make
> this a dumb list:
> 
>    contrib_plugins = [ ]
>    contrib_plugins += 'bbv.c'
>    contrib_plugins += 'cache.c'
> 
> etc?
>

Ok.

>>   if host_os != 'windows'
>>     # lockstep uses socket.h
>> -  contrib_plugins += 'lockstep'
>> +  contrib_plugins += 'lockstep.c'
>>   endif
>>   
>>   t = []
>>   if get_option('plugins')
>>     foreach i : contrib_plugins
>> -    t += shared_module(i, files(i + '.c'),
>> +    t += shared_module(fs.stem(i), files(i),
>>                          dependencies: plugins_deps)
>>     endforeach
>>   endif
>> diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
>> index d7823704616..303f97f9679 100644
>> --- a/tests/tcg/plugins/meson.build
>> +++ b/tests/tcg/plugins/meson.build
>> @@ -1,7 +1,10 @@
>> +test_plugins = ['bb.c', 'discons.c', 'empty.c', 'inline.c', 'insn.c', 'mem.c',
>> +                'reset.c', 'syscall.c', 'patch.c']
>> +
>>   t = []
>>   if get_option('plugins')
>> -  foreach i : ['bb', 'discons', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall', 'patch']
>> -    t += shared_module(i, files(i + '.c'),
>> +  foreach i : test_plugins
>> +    t += shared_module(fs.stem(i), files(i),
>>                          dependencies: plugins_deps)
>>     endforeach
>>   endif
> 


