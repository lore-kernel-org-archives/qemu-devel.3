Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91772C5B555
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 21:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMCRs-00015V-WD; Mon, 02 Jun 2025 17:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uMCRm-000147-SC
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 17:11:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uMCRk-0004So-1N
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 17:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748898711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IcvOov1uG1A8bgtVh3O5iliUd5dctenVeY27uWju2kk=;
 b=JQXoi8SjW8aY2Hrwca6yfIfyX1TsBzHiI9rTdSiLw/lQtl/wO2xYQv3wTEDMFeyg8RBKzK
 lKAbs6HNpHgsPO3Mmj3GvBGeZUfh7eao5nrcb7auXu7gEGVu17l4okaONfhIeeMlPXuoqZ
 BixQalXOAd1eqS8knvAFqr1k5QZi47c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-p5efybtKMbO2WW2pdAoPOQ-1; Mon, 02 Jun 2025 17:11:49 -0400
X-MC-Unique: p5efybtKMbO2WW2pdAoPOQ-1
X-Mimecast-MFC-AGG-ID: p5efybtKMbO2WW2pdAoPOQ_1748898709
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-442dc702850so32937635e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 14:11:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748898708; x=1749503508;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IcvOov1uG1A8bgtVh3O5iliUd5dctenVeY27uWju2kk=;
 b=sY8zJLeF7ryR8NN+S81gTsqIbUSwZG8grhuFDzpVE8JZpUi9OVgrtStK9pv+ZUzKK8
 Bk5OFH3GAi3rDSdG6Kh5Gz9QOkcXjbc2C5LI8CFMVNKvb1Tu3cQzxwMkaxtOH0AX3BCo
 1TQu9mXJ6ccuYEv58DU9uYL+jfuE5KLOaxEqN2mU/tsrsG8wdqQg8cX5f1Ktmz0X5Hbe
 B5D8+GDg4BwFRROZ6Sg6C53EwYm4JNFqDqV+2Y0Fx1EJ3W/VvCMy5GVV8+B3SjbPtJ42
 meiiP0QtC9LL38hiG+qADwgn1DPpSkgcgkxR16TA7sY/YP43Cs5H53ocCt3Aqwk1wJ15
 cevQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU88GWlej1DriZRt2C25kcvKH/AS6ZP3fZItgp+Aj00zYEvcVhBIMIha945EFjAKn12IaFH5/T64x/J@nongnu.org
X-Gm-Message-State: AOJu0Yzs9r4+t6IHuruadsRU1eKnxdTqU4G7thVYFxnZ+apJO/H25VED
 EcOGmH86jKAwejAORKGsjyFkEWSsG0SFi9YfJLlhlsaFfEHBQyl2rHMU0NOA67vzfxBL5eTqn8d
 Oi49v1IruBAU7i0OQR9S/qkKqt0uXOlHYlcekKpEy1zqEfQJdgGzxLawq
X-Gm-Gg: ASbGncsIBRrB1uBHE7D6tQKw2DrVkjdOpkKZ3cAlGBr6D/TF89jnUAH2uNR+hS30ZNh
 w2Qi/0CVF0XRRD0z9t/055hB3tbvf4pTMO3KMC6BI96emS68FKEFMu3mEdrmdArf9BKZuoZR3cV
 WSOmGrrKtEtfafOs5xiLaIN+f29HAWA7J2LXbqDiIRh0y/3rryWfCAWxplWhhpmqUcJXh0FYk6q
 ELLXnhLWsiFIWoRkYWma3JawhTgaj7kaplirXkgxgdSJBtACnGPoDjRfWsgeHbqkKQKxFgN9q6D
 /ZlNfzDuO4Xc/hzacNfpBHsHfsnUZTEdhklgm3MyDS2/thUUEw==
X-Received: by 2002:a05:600c:1914:b0:442:e147:bea7 with SMTP id
 5b1f17b1804b1-4512655c3bcmr80566485e9.29.1748898708382; 
 Mon, 02 Jun 2025 14:11:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqjHDDQEpCfhY/d3gK5E2dfoZXkOVGSMU71zUgGnpy01NVbOuBl/Nz0jhO6PgwOqVesdEf0A==
X-Received: by 2002:a05:600c:1914:b0:442:e147:bea7 with SMTP id
 5b1f17b1804b1-4512655c3bcmr80566325e9.29.1748898707974; 
 Mon, 02 Jun 2025 14:11:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d8012af3sm134480165e9.35.2025.06.02.14.11.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jun 2025 14:11:46 -0700 (PDT)
Message-ID: <e1abbc4a-7071-419e-ab49-64828e682064@redhat.com>
Date: Mon, 2 Jun 2025 23:11:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 02/77] hw/arm: remove explicit dependencies listed
To: Nabih Estefan <nabihestefan@google.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
 <20250530071250.2050910-3-pbonzini@redhat.com>
 <153c342a-428a-4620-bf91-52ebb4507b97@redhat.com>
 <b7e988ef-82da-43bc-8c57-3b49b3bf9529@linaro.org>
 <CA+QoejVhjy26FraUUMRtZtNPRW6u2MM3T=6hyguttPgx8qpkpw@mail.gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <CA+QoejVhjy26FraUUMRtZtNPRW6u2MM3T=6hyguttPgx8qpkpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 6/2/25 22:53, Nabih Estefan wrote:
> Hi Pierrick,
> 
> For what it's worth, those files were also breaking on Ubuntu and Debian for me.
> I had to explicitly `sudo apt install libfdt-dev` for it to work
> again. I don't believe
> it was installed at all previously, but QEMU was building and working correctly
> without it being explicitly installed.

yes. I had to install libfdt-dev/el on some systems too.

However, for the windows (on Linux) build :

   ./configure --cross-prefix=x86_64-w64-mingw32- --target-list=aarch64-softmmu,ppc64-softmmu,x86_64-softmmu,s390x-softmmu --disable-docs --disable-sdl

It's still broken.

Thanks,

C.





> 
> Thanks,
> Nabih
> 
> Nabih Estefan (he/him) |  Software Engineer |
> nabihestefan@google.com |  857-308-9574
> 
> 
> 
> On Mon, Jun 2, 2025 at 11:41 AM Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> Hi Cédric,
>>
>> On 6/2/25 6:59 AM, Cédric Le Goater wrote:
>>> Hello Pierrick,
>>>
>>> On 5/30/25 09:11, Paolo Bonzini wrote:
>>>> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>>
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>>> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> Link: https://lore.kernel.org/r/20250521223414.248276-3-pierrick.bouvier@linaro.org
>>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>>> ---
>>>>     hw/arm/meson.build | 4 ++--
>>>>     1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
>>>> index 5098795f61d..d90be8f4c94 100644
>>>> --- a/hw/arm/meson.build
>>>> +++ b/hw/arm/meson.build
>>>> @@ -8,7 +8,7 @@ arm_common_ss.add(when: 'CONFIG_HIGHBANK', if_true: files('highbank.c'))
>>>>     arm_common_ss.add(when: 'CONFIG_INTEGRATOR', if_true: files('integratorcp.c'))
>>>>     arm_common_ss.add(when: 'CONFIG_MICROBIT', if_true: files('microbit.c'))
>>>>     arm_common_ss.add(when: 'CONFIG_MPS3R', if_true: files('mps3r.c'))
>>>> -arm_common_ss.add(when: 'CONFIG_MUSICPAL', if_true: [pixman, files('musicpal.c')])
>>>> +arm_common_ss.add(when: 'CONFIG_MUSICPAL', if_true: [files('musicpal.c')])
>>>>     arm_common_ss.add(when: 'CONFIG_NETDUINOPLUS2', if_true: files('netduinoplus2.c'))
>>>>     arm_common_ss.add(when: 'CONFIG_OLIMEX_STM32_H405', if_true: files('olimex-stm32-h405.c'))
>>>>     arm_common_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx.c', 'npcm7xx_boards.c'))
>>>> @@ -79,7 +79,7 @@ arm_common_ss.add(when: 'CONFIG_SX1', if_true: files('omap_sx1.c'))
>>>>     arm_common_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
>>>>     arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
>>>>
>>>> -arm_common_ss.add(fdt, files('boot.c'))
>>>> +arm_common_ss.add(files('boot.c'))
>>>>
>>>>     hw_arch += {'arm': arm_ss}
>>>>     hw_common_arch += {'arm': arm_common_ss}
>>>
>>> This commit breaks building these files on Windows:
>>>
>>>        hw/arm/{boot.c,vexpress.c,imx8mp-evk.c,raspi4b.c}
>>>
>>> Error is :
>>>
>>>        fatal error: libfdt.h: No such file or directory
>>>
>>> Thanks,
>>>
>>
>> Is libfdt available in your windows environment? If yes, is it in a non
>> standard path?
>> On my side, it built successfully, so I first need to reproduce this.
>>
>> Thanks,
>> Pierrick
>>
> 


