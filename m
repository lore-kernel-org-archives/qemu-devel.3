Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C43C282C6
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 13:41:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpSVj-0004QC-4X; Tue, 04 Mar 2025 08:40:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpSVh-0004Pu-OP
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 08:40:37 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpSVf-00081m-Qd
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 08:40:37 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38f406e9f80so4285858f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 05:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741095633; x=1741700433; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QGchmqL4n/S/QlDxZVLt4HKZDyZRQQB0LLInV3y28Js=;
 b=cTkcUJalYKx1CT5L+LB/TgLq1XFIOAbM3EXlE1RynkYyuJ4rUTpzldqE9Q8bM9N82V
 pA/tvL6mcrvJAzvH80MxDoWoXsYRdreF92EG9ZToUJ6NAfTWegNKjX1ZMEZR7PTpt17z
 iroQSvMGtN/VsWio6cV+J2rHidhXnkGec1uylGQvdoEQ/aW4MnDxLgsYo7E1oHZjppC2
 eSWe1uq8AtfSC+Mjad0IWihQn3l/f3ZjtE0a6X0oTja7vLXXKq1Aw352hrMVCX5JyerN
 IjwdMH+wN+t9OXwSN3E0A9GZeDRUMvu3hG+T5CCmasIkF3afbNab8m/yPDB1T1QIdZ9X
 ipPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741095633; x=1741700433;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QGchmqL4n/S/QlDxZVLt4HKZDyZRQQB0LLInV3y28Js=;
 b=CGSlKI3qiyfG462YQIFNBGFauJjrKnYkxoRuNRhCERSFuuTWYizgBPMvhKqgq2+ZXK
 EWRgMuNRaR4pFa7JqaTf6agF0EUm8/ltiOvdoAv9j1HjdXq4E7PnPiA7zzesDt+7WCx0
 GfUPzrUqC1PMdPzzPoCdC3uXbzMG+uTmYmoErC2JrRfkS0g4h4vR30AG1yzdTHaN1Ksc
 kmfsxu8r0y7FT4V4TUFaNubEogNLKJt7G3YYmuSgOQF9tJ9jEW8+Egs7UQPACj2WRGkv
 3hO9G2k5B8Rbmuj3/Sqo0u48g0395NB3IRNDS7jmEepvWLMZY10Yk/hX0GfKpFYi3r6K
 jMRw==
X-Gm-Message-State: AOJu0YxC0lZ+03RCzObtQLRg8OEbKbC3TmL4mhdJOQj9mj2mrEC3ZROj
 wesoJSDpgMYOPZ7VHZoC0l45UTu92AUNi3ggEptseem5M5rNmqGNJaS4116qoLY=
X-Gm-Gg: ASbGncuPBnxpjJ2PHKNnjv6LFJnw/SdT0uQTdWcExyDzWz7M60Z9ncvkDhB7rzXOu2G
 +ry9oTYdm/m+ki7Y6kfirXApg6G408LKpIew/OAV2HdzemBX2XaPfHRwJWthAqBRBbLH3oRfQDW
 fgbMZNl0rjrDGUYimjjwtHcF33v/0H4QwBZ/PDHbQlURHiz1wGbkvc/pm9uAH+xqhrHXIJmH24g
 iisDTkikK16W4iGQdYRxSxJiUnqkYAdkX/qkIPemYm58PdcetAhUiBd1+EupOeRgVxmyFWeUfB6
 J2/tGrkLBWFzjnh++l0/r3QJ+tKzgkW4o+6BWRXJL45fkpDFJX0ouSJ8fmiHlyn2EORJfcb9Som
 FwbcvdfZvV/5M
X-Google-Smtp-Source: AGHT+IHZRwiymTzIB7PeQTb4/biqdXWzHzUZVTYbFxBDjBO5rL3y1RP/7HfQs3x3etbb0LEexwazQg==
X-Received: by 2002:a05:6000:2cd:b0:390:ed0a:cbf7 with SMTP id
 ffacd0b85a97d-390ed0acc5cmr13383140f8f.46.1741095632781; 
 Tue, 04 Mar 2025 05:40:32 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47b7d12sm18077695f8f.58.2025.03.04.05.40.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 05:40:32 -0800 (PST)
Message-ID: <902997f5-a2c8-4585-a834-5cde5aee98a1@linaro.org>
Date: Tue, 4 Mar 2025 14:40:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] meson.build: add -gsplit-dwarf to default cflags
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250303221703.1291078-1-alex.bennee@linaro.org>
 <Z8bTy54Jgaddg6V3@redhat.com> <87tt8958tj.fsf@draig.linaro.org>
 <Z8bt7ajRVwdabG7p@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z8bt7ajRVwdabG7p@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 4/3/25 13:11, Daniel P. Berrangé wrote:
> On Tue, Mar 04, 2025 at 11:33:44AM +0000, Alex Bennée wrote:
>> Daniel P. Berrangé <berrange@redhat.com> writes:
>>
>>> On Mon, Mar 03, 2025 at 10:17:03PM +0000, Alex Bennée wrote:
>>>> This option is supported by both gcc (since 4.7) and clang (since
>>>> 7.0). Not only does this make the linkers job easier by reducing the
>>>> amount of ELF it needs to parse it also reduces the total build size
>>>> quite considerably. In my case a default build went from 5.8G to 3.9G.
>>>
>>> I've not come across this option before, but the docs say
>>>
>>>    ‘-gsplit-dwarf’
>>>       If DWARF debugging information is enabled, separate as much
>>>       debugging information as possible into a separate output file with
>>>       the extension ‘.dwo’.  This option allows the build system to avoid
>>>       linking files with debug information.  To be useful, this option
>>>       requires a debugger capable of reading ‘.dwo’ files.
>>>
>>> In Fedora and RHEL we build QEMU will full debug enabled, and then a feature
>>> of the distro RPM build config will post-process all ELF files to extract
>>> the debug info into files that we store under /usr/lib/debug. eg for
>>> /usr/bin/qemu-system-x86_64, we get a separate
>>> /usr/lib/debug/bin/qemu-system-x86_64-9.1.3-1.fc41.x86_64.debug, and
>>> tools like GDB, etc know to look for these separate files.
>>
>> A modern gdb can certainly handle fetching the debug out of the .dwo
>> files when debugging.
> 
> See this response from one of the upstream GCC maintainers pretty much
> recommending against (on by default) use of -gsplit-dwarf:
> 
>    https://lists.fedoraproject.org/archives/list/devel@lists.fedoraproject.org/thread/RXA55BTO62NWWHCTUFYGEVHJKZPL5EKE/

Jakub said:

  "it can be useful for fast modify/rebuild/test cycles during
   development, but is something that is really undesirable for
   the distro builds."

Do distro use --enable-debug by default? Otherwise it might be
useful to add it for developers.


