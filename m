Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79409D185C9
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 10:51:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdnbj-0008CH-M7; Thu, 08 Jan 2026 05:51:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdnbh-00086S-Ja
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 05:51:09 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdnbd-0006WI-FF
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 05:51:09 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47d3ffb0f44so19939945e9.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 02:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767869463; x=1768474263; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jJYpZTjN46IXwYFKsEQwIU9MOp8rKRWXF6Y3OsnB/Cg=;
 b=eHTT50JOUOTXVRUas13OUaJCRDx10t+R5L7iVepEahb8je8vjyta3kN2uoboJuepJ/
 H1BPw3Rq4+5Sr98iHBLjLnTfCNCGayXQnORd9zhnIFW2kTVXw7hlayQqOSyPZSLHvEtO
 cxiukLSu5ER+F7g+y/GOK+FSwsDMqwJIHxKoT1+yshB6SKWY9M12fs7cDfn9juSELmSO
 2oTH2j8bHBYzruGnxzfBl0Fd7M7T/L9273Fpyz6/MCjyI27s4sNpm044f2M62fBEfz3f
 zdV98whyUoG5L5MRkoY0VQiAzb/XFW3grBEYYH3YNKTqBcDiotKMgffmnXhWrd5nEiE+
 +2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767869463; x=1768474263;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jJYpZTjN46IXwYFKsEQwIU9MOp8rKRWXF6Y3OsnB/Cg=;
 b=VNdUBWkFyW3KiphZ8Z/dRgBIJwQQ4sjbH2ec+1HRg56MoVHvq1iVsqDUwyMu0V1R3V
 y1x7mIfW6wZgYDCgHjLPF2j+VzVODdbk9A7aAjvseURcukRFsb2C0kHRiMmwSB/7L7Xd
 K/jYGH/KyvlEC+bQRqhiRXfFByX4R2evrc4zrY6hP28LhX3dam4VeUiJRxVq+Z3+FZDF
 6hmkc2x67AOQbA6J2IKm0B40ZGyrrdnaJzbiTz1dlkPjU31VdwdPzmLjBjQsO3A3OqUa
 EBGXpkZ/XDFzGg2W0FtT+eBhgQ6NkRv0n5KysuszePjbHaNttRUreTsrBl3jUgTU8xy2
 7XUw==
X-Gm-Message-State: AOJu0YyV2uJrC7M+kLEGQx+nDt7HnKUL5QHzvhxifZNeYpbBhzyj/kj7
 a7iyCQhdOC19iSDyLsOeCqI0ZHWXILfOZKOaWb8bxKI0taCoOR7njS2gAaGioN3rgrA=
X-Gm-Gg: AY/fxX6QoHZNwAIJnalwSieP6OuSIQmip0BhAl8MNKuDlfwX/IJ1IL8EIehUga7bZEF
 XqIo8ww+Apz5q61FXPf9vSBtHZft06aMXgHUnN7EZ+mBqs0K2ywnhvjK7LvjJgFkRne3YLuZnWZ
 0TotzZxiJ2+7CAB01IOmi87znVL6Y4yA3YNToqf86izXGgUq8En4Qj9icosfoB4iikeFuAmD3mU
 ciExEa1qq7ZPFCwRy6vzg6BXodQ055fHj06lCOLPnzr/X2cX48DNCHpAinwU5WJcc/DTiREKZ5g
 4myE8p3mNo+QRDSw0klj7CzOsEbVV7dwEH+WsvJMmiatokZJLJdaV3UPunvvrPgs2elyR6fpn0y
 q200NyxTKeu5ByuP51VTRabVzkApV2NDRddrGvJTabhKRSVRCPVXOocrOUjYwslTQVuqEaR9TFx
 2iOVIp6/6KEYYn85803UXEQ7E=
X-Google-Smtp-Source: AGHT+IGUhetKIxm1U4fCxCYAF21vGDgW+W/CzSWvtlX8bPUFNY9kYYTiQQsDejlg3htmoC9LIFwWvQ==
X-Received: by 2002:a05:600c:4709:b0:479:1348:c614 with SMTP id
 5b1f17b1804b1-47d84b41b2dmr67578215e9.26.1767869463476; 
 Thu, 08 Jan 2026 02:51:03 -0800 (PST)
Received: from [192.168.69.213] ([88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f70bc4fsm141916465e9.15.2026.01.08.02.51.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 02:51:03 -0800 (PST)
Message-ID: <0438ddd7-6061-4b7b-a995-0ec32f250f95@linaro.org>
Date: Thu, 8 Jan 2026 11:51:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dump/win_dump: Use stubs on non-Windows hosts like
 POSIX
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260107180519.50820-1-philmd@linaro.org>
 <20260107180519.50820-3-philmd@linaro.org> <aV902eZnijhEnONE@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aV902eZnijhEnONE@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 8/1/26 10:11, Daniel P. Berrangé wrote:
> On Wed, Jan 07, 2026 at 07:05:19PM +0100, Philippe Mathieu-Daudé wrote:
>> Rather than compiling the same content for all targets (unused
>> most of the time, i.e. qemu-system-avr ...), build it once per
>> POSIX hosts. Check Windows host (less likely) before x86 host.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   dump/win_dump-stubs.c | 21 +++++++++++++++++++++
>>   dump/win_dump.c       | 12 ++++++++----
>>   dump/meson.build      |  6 +++++-
>>   3 files changed, 34 insertions(+), 5 deletions(-)
>>   create mode 100644 dump/win_dump-stubs.c
> 
> snip
> 
>> diff --git a/dump/meson.build b/dump/meson.build
>> index 4277ce9328a..0aaf3f65d9c 100644
>> --- a/dump/meson.build
>> +++ b/dump/meson.build
>> @@ -1,2 +1,6 @@
>>   system_ss.add([files('dump.c', 'dump-hmp-cmds.c'), snappy, lzo])
>> -specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: files('win_dump.c'))
>> +if host_os == 'windows'
>> +  system_ss.add(files('win_dump.c'))
>> +else
>> +  system_ss.add(files('win_dump-stubs.c'))
>> +endif
> 
> This is very wrong.
> 
> The win_dump.c  file has no association with Windows hosts. It is about
> creating crash dumps of Windows *guests* in the Windows dump format. The
> current conditional which builds it on TARGET_X86_64 is correct.

Great to know this is a *guest* feature and not a *host* one.

Something else is currently wrong, because this file is built with
qemu-system-avr on macOS.

Anyway, I'll revisit, thanks.

