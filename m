Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22E6D4661C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 19:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgTEH-0007Oc-KR; Thu, 15 Jan 2026 14:42:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgTEB-0007HW-6v
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 14:41:55 -0500
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgTE9-00070V-BJ
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 14:41:54 -0500
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-8c2c36c10dbso152309285a.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 11:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768506112; x=1769110912; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XStVtb63ZUi/yHG1V8OVVG3pE4n+ztizFlEvQhgiFbM=;
 b=qmpQf68hUQhjnmG5THlahtUo+QO7ahX/jYf5HUvy8dWwuAK8fk1dzqDI2J1b1BgVTh
 EU9OZ3ty738pmpX5AHGbPakQ9WFspdKA83tgCuoEDL1FegdOkU9+yFV7LeQEfUp6ekpB
 o8EBu8lQNDhpfP+ZIurI1TqbfWkTPRv6rp78XhraEqSFMnT5KPDsjDIBG/QvPPb2dc9d
 V7589OE0Vv7yXKEcYZ4v1iLyE3PORxhFKohNJhaU0hr8sIj8CTzhBJhek7bgMK2/b5tV
 QTlahSf2KUTL957hF2zcrngbws2SOGr9VTXl/4GQ/gdybakd8Uq5hs5dsIY1Ok2aB8RC
 tt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768506112; x=1769110912;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XStVtb63ZUi/yHG1V8OVVG3pE4n+ztizFlEvQhgiFbM=;
 b=kgwRiDGI0wniGTMiOvUjDygGDjJPucGBCDxhxVKbbJveSbqMyS63TAcVR8QTCQM1Si
 gXh0zCskvS2mHmTSoxYGogVx33nxAV1uXCRwEHnV8zfFtqNBl3dDQ76PLr4k7owApRG3
 MFjRvjclhpm+QucPpAllkxBx8YKPFDdOV+IZ1oNaupdqD3EaznpvYa25ITuAI7myaLoG
 GO5mMq8D6WWFIuQaZZjKvWMBpNcpfWsB/uMa27TYPN6OdgYK+BYT82yABbFS4f0OPqF5
 FXcNUdZH501g47ZJjJOQQv4zYVcHVVAZyIxgx84ii6G8mgEL/Q1j526PzjCOZHCvzRA2
 fnqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXE2XQU/D4UPNFNIUzVCIVgWkTlPPtDH+bNnOi6bZm6jeP10bvMVZpZxAjZaBD6uqsGlwInbr6s4LqO@nongnu.org
X-Gm-Message-State: AOJu0YxsDuGm7YxQA39fN8rofkFKaWL4MeZv1Zt1D2OZ6u68gjH5Z2A7
 GXVB9raLbMH2lJa3gKpTgp93tmmrdDb89DWKARjkBHWMmCRWefLl10lDtw7HqvEj1fk=
X-Gm-Gg: AY/fxX4nioNlx/C9/6SnPOPWFktoY/xZiYyqVSnZxWDONfAF4/o1aHETzBO4Jt9HVCj
 xA2a9ukJgfU1yVm23RUOAMTDIJ6qqgpu+0M50N/6xQGfb/+Gco9TrFUidksJgvyDGJ1FPfLbREA
 uIfheY0RXU36yoguMrjuvhRyciyGWouqUpBFffZuL1DK5IVpPX1zM8lIoiAZFfnWr8C3Nj4nek1
 lEFZMcjNYA6+3cEtVkjDBMe1NYkK+huNjj6bk5q/Wt1rspwJ/hJP0ZTzgRrfsfFVSoFl+N+hQcU
 gRSAkAKLoKQAIVA8GuKiztx/XLLM7vHCDxUdj5e+IEibkhYFgacvp8WEZsJsdb4D1/rwfrM41yD
 m7j0qECnAIjQVzfIP8jxzqlQIy3D++wBtRP7RS8QWZolSZ7LGwJ8SGBEBimtT3QC7dhnC23CklB
 n80Bos7pl6SLX5T27zWO3tLyYk2KL42raYw8uoc8jbAhdm9s+A+M4Kcw==
X-Received: by 2002:a05:620a:19a9:b0:8c5:384e:dcd9 with SMTP id
 af79cd13be357-8c6a66da411mr84746885a.2.1768506111901; 
 Thu, 15 Jan 2026 11:41:51 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8942e6ad75asm3176586d6.31.2026.01.15.11.41.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 11:41:50 -0800 (PST)
Message-ID: <2837af07-c175-4eff-90e6-760446492c34@linaro.org>
Date: Thu, 15 Jan 2026 20:41:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 13/31] accel/nvmm: Replace @dirty field by generic
 CPUState::vcpu_dirty field
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: Reinoud Zandijk <reinoud@NetBSD.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ryo ONODERA <ryoon@netbsd.org>
References: <20250704101433.8813-1-philmd@linaro.org>
 <20250704101433.8813-14-philmd@linaro.org>
 <44ccfba7-21a3-4c24-aa6a-4b2bdb989792@redhat.com>
 <dd7fbe03-1458-4c44-b8db-a9d5e9ae33f1@linaro.org>
 <87v7h44pal.fsf@pond.sub.org> <aWdfqvJhtDt14lTJ@redhat.com>
 <ea1e0e45-f864-4a43-a40e-48fd82c26c56@redhat.com>
 <87a4yg4gmo.fsf@pond.sub.org> <aWd9wP9-9rx0ELhY@gorilla.13thmonkey.org>
 <5279bbb4-a4b8-4c71-8275-92643b8796d7@redhat.com>
 <aWjBiwjKpfmnaBSe@gorilla.13thmonkey.org> <87a4yfxgm9.fsf@pond.sub.org>
 <87sec6hlmj.fsf@draig.linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87sec6hlmj.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72a;
 envelope-from=philmd@linaro.org; helo=mail-qk1-x72a.google.com
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

On 15/1/26 17:43, Alex Bennée wrote:
> Markus Armbruster <armbru@redhat.com> writes:
> 
>> Reinoud Zandijk <reinoud@NetBSD.org> writes:
>>
>>> On Wed, Jan 14, 2026 at 01:17:20PM +0100, Paolo Bonzini wrote:
>>>> On 1/14/26 12:28, Reinoud Zandijk wrote:
>>
>> [...]
>>
>>>> We're not asking you to keep CI up-to-date (which Thomas is doing now,
>>>> despite having no specific need that I know of to support NetBSD), just to
>>>> *report* failure to build from source and tell us "hey, that's how we fixed
>>>> it".  Otherwise we have the false impression that no one even cares about
>>>> new QEMU on NetBSD.
>>>
>>> As pkgsrc normally tracks releases and has a directory with local patches on
>>> top of that, build errors only show up when we bump the version. Version 10.2
>>> is now in pkgsrc though I am running 10.1.3 so there is surely interest in
>>> keeping it running. I could try to commit some more trivial patches in the
>>> repo here to reduce the diffs some more.
>>
>> Fixing the build long after it broke is less than ideal.  What would it
>> take to get NetBSD covered in CI?
> 
> We have the ability to run tests via the vm-build:
> 
>    make vm-build-netbsd
> 
> however to take full advantage that needs a runner with a reasonable
> amount of memory and access to KVM so it can run reasonably fast. Does
> anyone want to host a dedicated x86_64 custom runner?

Pierrick had a clever & simpler way to get that:
https://lore.kernel.org/qemu-devel/ae956364-78e6-4067-b0eb-94213891a112@linaro.org/


