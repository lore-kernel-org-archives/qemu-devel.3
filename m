Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B65D6C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 14:16:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpU4q-0002Ur-1D; Wed, 27 Mar 2024 10:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpU4Y-0002Ou-3O
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 10:16:10 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpU4T-0000AB-Ve
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 10:16:09 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-56c2c41cbdaso970020a12.2
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 07:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711548964; x=1712153764; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VEn6sJJuV1gys26+f1fgasgwmUZDKg+j2PYSB9FR37E=;
 b=MxhTzdgrVBrnBTkQfEfwzHP8/1jizjbZ/oqF2cOOXNfDzUbEo47G/Hs88/E8q+L4hm
 yhm+/4kLL6nbsNsNdENLF5nmFh8Xr5Lq82Q2mOpxO9WDbJoA4X36jN4/ZrA/wlssdia4
 B/90tfEWj8tXZZfxrkHtUwgpMmMB8Ei40otPtXZ60fFF+qBSD2pK4Zsb4NmTJZ3O4PkN
 Md/EIWYfPyqaLJm81Ow6/8WyOPdJb1fbUW1d98YZomT8EqXE+C6nRsEA8A+s6gj+eZaj
 iT89SLpJw8by48BteUfXbPM7GUGXmpaPqggTsb1Zy3p8SE8Bx+zLXpDzn38/XeLUi27W
 ivAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711548964; x=1712153764;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VEn6sJJuV1gys26+f1fgasgwmUZDKg+j2PYSB9FR37E=;
 b=mbl0xvIZake2xthqN3Mclh20887uZq8M90JuTOE6Um8fTS40I7NkCf/XulNMFrmaSa
 i0brmHQ9wChkHpCBl0DONC4tP0/L9+4bINUMv2Ioas8WC5FOAGWfT442yCsSqAjE2ijL
 3I1DTbBnHL/KEMo4Md7G4tge5Pog8jtaHwom1IkEK5eT9DcHk+n2HUrGoEaSUUm7jbI5
 r6LeiRCLvMLu6kBNCT5kSmjmBXZeyAOVly5P6a9FZqyMRlH2eXupnLfmaWB78kWlBCvn
 pdaSe4wyBKfQC6EXUhLcvZ4msjyTYI45F9a7VBuJLI88f3hLaYmsf+v9EbDv4rZH+uJq
 lE7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVilzwjb9kgsJyzYskbBhR5PQfMy3jh2OnmLNm6i1/5yr7cysxy5a6JJ2ZRvWgsht4SDgp+mJ9fYjnaWtXuVL/ujS2IMXw=
X-Gm-Message-State: AOJu0YzE9BgILepYDcC2hBsIT1VfE8X6KlymOwMWCA04Efb3LBBU9/6V
 FUa0ZxL8eB3g6/ObCQYVA7a7FtQ+/IceySbkLtS0zE7aLiitdjFuiN0M5UHYnuw=
X-Google-Smtp-Source: AGHT+IHhWSrSBDj8zcrgUXt8mm6Z63W3eSCS0czmv7/DkeDt2GIEQfmFYlx6sDSGdoXdXx1TRox8CQ==
X-Received: by 2002:a50:8d41:0:b0:568:1444:af5f with SMTP id
 t1-20020a508d41000000b005681444af5fmr2570060edt.4.1711548960858; 
 Wed, 27 Mar 2024 07:16:00 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.205.175])
 by smtp.gmail.com with ESMTPSA id
 h28-20020a056402095c00b0056b2c5c58d2sm5343828edz.21.2024.03.27.07.15.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Mar 2024 07:16:00 -0700 (PDT)
Message-ID: <14787bbb-e6cc-45bd-bb5d-1fb3fee5a60f@linaro.org>
Date: Wed, 27 Mar 2024 15:15:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1] target/nios2: Remove machines and system emulation
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Chris Wulff <crwulff@gmail.com>, devel@lists.libvirt.org,
 Marek Vasut <marex@denx.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Maydell
 <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
References: <20240327123554.3633-1-philmd@linaro.org>
 <7aad7197-21f3-4c0e-931c-2eb4febdf94a@linaro.org>
 <fb28d3b0-1ab9-4423-80ef-03a285cf02d7@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <fb28d3b0-1ab9-4423-80ef-03a285cf02d7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

On 27/3/24 14:19, Thomas Huth wrote:
> On 27/03/2024 13.45, Philippe Mathieu-Daudé wrote:
>> On 27/3/24 13:35, Philippe Mathieu-Daudé wrote:
>>> Remove the Nios II machines and the system emulation code
>>> (deprecated since v8.2 in commit 9997771bc1 "target/nios2:
>>> Deprecate the Nios II architecture").
> 
> Please remind me, why didn't we deprecate the linux-user emulation, too?

Hmm I think we actually did (overall target), since there is
an issue with signals.

>>> diff --git a/hw/nios2/Kconfig b/hw/nios2/Kconfig
>>> deleted file mode 100644
>>> index 4748ae27b6..0000000000
>>> --- a/hw/nios2/Kconfig
>>> +++ /dev/null
>>> @@ -1,13 +0,0 @@
>>> -config NIOS2_10M50
>>> -    bool
>>> -    select NIOS2
>>> -    select SERIAL
>>> -    select ALTERA_TIMER
>>
>> I forgot to mention I deliberately chose to keep the Altera
>> timer model in the tree, since it looks like a re-usable
>> IP component.
> 
> But if it is not used anymore by any machine, this will happily bitrot, 
> won't it? I think I'd rather remove it, too ... maybe in a separate 
> patch, so that in case somebody later needs it again, it can be restored 
> by simply reverting the patch again.

It is related to dynamic machines, how do we decide what components
to remove once there? I suppose we'd need to deprecate every single
component, like ALTERA_TIMER. But we are not yet generating dynamic
machines, so for now we can consider ALTERA_TIMER part of Nios II
sysemu removal. I like your idea of removing it as a separate patch.

