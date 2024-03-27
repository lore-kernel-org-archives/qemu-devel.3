Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E7EC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 15:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpVNb-0003bR-6T; Wed, 27 Mar 2024 11:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rpVNX-0003b0-Li
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 11:39:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rpVNV-0000nH-MK
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 11:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711553988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BBAasgwby3nhSMNRtJarAKThk3fu2tqFH1Faqc1cxZk=;
 b=KxrAAXInKjFHtk/gtxCU4KvwU2vUrM87BISzPdrTR0tHDGKAEB4dRvtqftuX+wOPSNtlZa
 v7f+ZNTp9qi7eU4SyV2bupfBc7xHTSnjluKY4bixTfJMfWf9wHzc7xHl5BbNPBX7RX9+3n
 lNYK4zEPa8Jf4TkYCseIuclYKZ0LN+Y=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-2Zw0HFrNObGdfCNcjxjcmg-1; Wed, 27 Mar 2024 11:39:45 -0400
X-MC-Unique: 2Zw0HFrNObGdfCNcjxjcmg-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-78a7495b2faso22792185a.1
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 08:39:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711553985; x=1712158785;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BBAasgwby3nhSMNRtJarAKThk3fu2tqFH1Faqc1cxZk=;
 b=unEzvirtF8DoIW/dJ222al2vVvPrjoUTx+7JE/X99A7uMJ/9cUMVquH5XKov52q1Cb
 a+UO+6WiLd6pl2jDhB+wgKWPNFEPnMjjERnW3TbD/GybWsFpIB1RAMTwFvjvVSzeE2K4
 YLI1YJJe3zSiVN9oVCwT+dFmbWqZuYqGcSOYeFdPsKqVjxrsmlxS2CHVx4O//11hyMDp
 RSTBW7h/Y4V6HYvDFV159kCe06IrZ5mcvj6y65UbX5mkw5GLYCw7rrGcS0sWlSEkOhjy
 No8KdAEC/EWxS3Q2dnOY4fPjeO8EMJ6HTdaM8yQSc6DFe1lvNmmAv9ppBtFRFCYeQ1Iq
 jPYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVgIFEg1qzZ+M3AXMAOIVu0pKciEQXfOQHQPXpRC87+USRlIoHkGaxEXX0ncXceOsXzbcYqMse2/N3tF+/nR0QZgrLSoQ=
X-Gm-Message-State: AOJu0YyfUWbUrD8Ia+dtHobjEFmTFEBDJXmCOGQj7IqH3RPy6Cd4aUCQ
 XUg5jlxsOHzFgTxkNZ7CfMCZQ67T5AG2z+xohvyOnFY5uA8ln+JEe3oH8rjC93uIRAEqaiFdXcz
 ovruTqmQxnqpzmE3EkZvXfJSmemGITSSFnSmdYvcykwJAHN91OKwb
X-Received: by 2002:a05:620a:4fc:b0:788:254b:de89 with SMTP id
 b28-20020a05620a04fc00b00788254bde89mr1688327qkh.17.1711553985190; 
 Wed, 27 Mar 2024 08:39:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUvy5v6zw7/+2XQKQBQqO5Fd9H86BMAfbQ0gh9Kcdg2DCwGpW7F/pBuW7qPCH0H8rYZ4Sktw==
X-Received: by 2002:a05:620a:4fc:b0:788:254b:de89 with SMTP id
 b28-20020a05620a04fc00b00788254bde89mr1688300qkh.17.1711553984893; 
 Wed, 27 Mar 2024 08:39:44 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-177-37.web.vodafone.de.
 [109.43.177.37]) by smtp.gmail.com with ESMTPSA id
 k11-20020a05620a0b8b00b0078a69ec3790sm1066594qkh.117.2024.03.27.08.39.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Mar 2024 08:39:44 -0700 (PDT)
Message-ID: <49052bf6-658f-4bec-a9da-794670da3706@redhat.com>
Date: Wed, 27 Mar 2024 16:39:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1] target/nios2: Remove machines and system emulation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
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
 <14787bbb-e6cc-45bd-bb5d-1fb3fee5a60f@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <14787bbb-e6cc-45bd-bb5d-1fb3fee5a60f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 27/03/2024 15.15, Philippe Mathieu-Daudé wrote:
> On 27/3/24 14:19, Thomas Huth wrote:
>> On 27/03/2024 13.45, Philippe Mathieu-Daudé wrote:
>>> On 27/3/24 13:35, Philippe Mathieu-Daudé wrote:
>>>> Remove the Nios II machines and the system emulation code
>>>> (deprecated since v8.2 in commit 9997771bc1 "target/nios2:
>>>> Deprecate the Nios II architecture").
>>
>> Please remind me, why didn't we deprecate the linux-user emulation, too?
> 
> Hmm I think we actually did (overall target), since there is
> an issue with signals.

The placement in the deprecated.rst file seems a bit unfortunate in that 
case, since the subchapter is called "System emulator CPUs" ?

Anyway, I just saw your v2, so let's continue discussion there...

>>>> diff --git a/hw/nios2/Kconfig b/hw/nios2/Kconfig
>>>> deleted file mode 100644
>>>> index 4748ae27b6..0000000000
>>>> --- a/hw/nios2/Kconfig
>>>> +++ /dev/null
>>>> @@ -1,13 +0,0 @@
>>>> -config NIOS2_10M50
>>>> -    bool
>>>> -    select NIOS2
>>>> -    select SERIAL
>>>> -    select ALTERA_TIMER
>>>
>>> I forgot to mention I deliberately chose to keep the Altera
>>> timer model in the tree, since it looks like a re-usable
>>> IP component.
>>
>> But if it is not used anymore by any machine, this will happily bitrot, 
>> won't it? I think I'd rather remove it, too ... maybe in a separate patch, 
>> so that in case somebody later needs it again, it can be restored by 
>> simply reverting the patch again.
> 
> It is related to dynamic machines, how do we decide what components
> to remove once there? I suppose we'd need to deprecate every single
> component, like ALTERA_TIMER. But we are not yet generating dynamic
> machines, so for now we can consider ALTERA_TIMER part of Nios II
> sysemu removal. I like your idea of removing it as a separate patch.

Even if we switch to dynamic machines one day, the devices still need to be 
somehow used and tested in the CI, e.g. by scripts that assemble a machine 
dynamically. If there's a device that is never used at all, we can also 
simply remove it until someone needs it again, I think.

  Thomas



