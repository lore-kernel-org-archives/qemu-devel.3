Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F6CC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 13:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rabuH-0005kH-Oj; Thu, 15 Feb 2024 08:36:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rabu8-0005dI-Cl
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 08:35:56 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rabu6-0006iM-Kv
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 08:35:56 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2d0c7e6b240so11687461fa.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 05:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708004152; x=1708608952; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=THar1eNJxVP6dCYcxR7y5F+0zub+2EayNmXxrr89b74=;
 b=JZIFoK15qWqqOVdpvPvPNCEdYieE4RWh6Q2UwwMn653T8lyUAp9pdoYBNyhoMlSJu/
 PZErXrQGM6HgBZU9+OUER+RXlIwB3I1VoeBX5XOfYatQWINQftgjaq1N62rX4Q/irq95
 VHJQH8ShKFB2Fl2MCiH+MqKDA1QNsgWlDqwwqT9tcUDS6VdS90K4iZgE5eqmEtQCHAfq
 Jy14BJslEkfWtKJ6zV8JcFeexmhlZd/fqq3oCvdwsh81wi9omk6srtXt9ztIGU4m1+ur
 JldP/5ZNhepFe1Vt1DNeHpAjrxvm8Xa8jEXAMPuQyYMfKBQxITAfjb3xbAbOpzjsKdAR
 54RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708004152; x=1708608952;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=THar1eNJxVP6dCYcxR7y5F+0zub+2EayNmXxrr89b74=;
 b=wPAgJ2kpDQ1knrCqRsCexdzfv6ESuEWnp3PJ3H7Sxd9EO9gcL9mUw2e2hlVAL9MoBe
 5CrjVEeNqbQOGVwVY6K2zGjf/pRv+N/HjBBw0NbVQO45+Ow88RhM+2xIeGZh6ZWv2B5W
 QP/3pEznx6tsgmH2WJLPxT2osZX7jdrtgXgc7ILpv7lYfik4NKhVfHKVVg6RWUTl1xxA
 OBcTu7HQJX1WIax0VQppa33JjAMjJRC+u+Xns2VNuwWfdArEUXa5dt8oMqdTm8f0EfAa
 DdvkT6Mam0XAAdfLjCZyJJP3nUaw1y1Xdc4ByFvE0u7Z+T4ubKXb5PlAoHHKKep72HHi
 PkZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7TumOHDfcxXMj3oaBTEbcS3ytCS6FhR0YdJFm4u3PVB2yfZERSDiUjw8L3O/TEq3BHiPmjKGlRyQ6PAdeO+g+S4ttfbk=
X-Gm-Message-State: AOJu0YxyMxr077L7hC3CFaBkZMm+iP87AnifX/oVf33+3PhdTfBUgXqg
 CtMXh6n/mMYzvd4RD6TyJ69vM3ZxX5D4gCy+HtBskdkbDKHKT/tZpselXzivR/o=
X-Google-Smtp-Source: AGHT+IEAbbwTL6sx5Hw+1v9mCTuS5YcRTgeDoJULKYbl9UQ+Kw2ojW5LGpEQKR4CTWe1A/124gJeKg==
X-Received: by 2002:a2e:8713:0:b0:2d0:a817:4525 with SMTP id
 m19-20020a2e8713000000b002d0a8174525mr1195429lji.42.1708004152475; 
 Thu, 15 Feb 2024 05:35:52 -0800 (PST)
Received: from [192.168.69.100] ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 n2-20020a05600c3b8200b00410c449f25asm5467753wms.6.2024.02.15.05.35.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 05:35:52 -0800 (PST)
Message-ID: <109c9d07-09e7-49da-90c9-981bb73df451@linaro.org>
Date: Thu, 15 Feb 2024 14:35:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] target: Add system emulation aiming to target any
 architecture
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Alex_Benn_=C3=A9_e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Damien Hedde <dhedde@kalrayinc.com>, Zhao Liu <zhao1.liu@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Alexander Graf
 <agraf@csgraf.de>, =?UTF-8?Q?C_=C3=A9_dric_Le_Goater?= <clg@kaod.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Amir Gonnen <amir.gonnen@neuroblade.ai>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Marc-Andr_=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Luc Michel <luc.michel@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud_=C3=A9?=
 <f4bug@amsat.org>
References: <20240215084654.56297-1-philmd@linaro.org>
 <20240215084654.56297-2-philmd@linaro.org> <8wflq.yweql5v2v6bo@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <8wflq.yweql5v2v6bo@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 15/2/24 14:02, Manos Pitsidianakis wrote:
> On Thu, 15 Feb 2024 10:46, Philippe Mathieu-Daudé <philmd@linaro.org> 
> wrote:
>> From: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>
>> Add the 'any'-architecture target.
>>
>> - Only consider 64-bit targets
>> - Do not use any hardware accelerator (except qtest)
>> - For architecture constants, use:
>>  . max of supported targets phys/virt address space
>>  . max of supported targets MMU modes
>>  . min of supported targets variable page bits
>>
>> Build as:
>>
>>  $ ../configure --target-list=any-softmmu \
>>                 --disable-hvf \
>>                 --disable-kvm \
>>                 --disable-nvmm \
>>                 --disable-tcg \
>>                 --disable-whpx \
>>                 --disable-xen
>>
>> Test as:
>>
>>  $ qemu-system-any -M none,accel=qtest -monitor stdio
>>  QEMU 6.2.50 monitor - type 'help' for more information
> 
> 6.2.50? :)

Time passed...

> LGTM in general overall. In case this wasn't discussed already, would it 
> be a good idea to name the target x-any if it ends up in a stable release?

This will end in stable releases. Do you mean distribution releases?
They don't include qemu-system-all and we don't use x-all. Why would
a distrib want to include a pointless binary? :)

> Regardless of my inlined style comments:
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Thanks!

