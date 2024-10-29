Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C08CD3A660
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 14:41:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5nOT-00074k-HN; Tue, 29 Oct 2024 10:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1t5nOO-00073U-QP; Tue, 29 Oct 2024 10:40:21 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1t5nOM-0002Ib-Re; Tue, 29 Oct 2024 10:40:20 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-72097a5ca74so547442b3a.3; 
 Tue, 29 Oct 2024 07:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730212815; x=1730817615; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=1UUqG8LMQH5EZNY8W+SBrY/LMyHdK3/iMjsnwrOvLEU=;
 b=A4VJF9AEKkjJlNKdrxnssFyPAH1889bDuoV9Pa2dluRTfXTPyD5to4lYCNaiT487X3
 cj2NT/ondwLoyhFllckVoSFxntpyt7lIlhXpZbGPkCQ1goc9Aaqm9A4dO23tWMqyanzy
 ouhxWckFD/2c/DyzUQSRfFhOXU24m1gH5eRdWGb9bx+tlI1rm1ketplzF0mhogNNSB1D
 10m+Ka254rGN9HrutApVF+DjduyYOhcJT7aFgVVBrKvTlwYkJdWcKbUvQRdbX5/8ucFZ
 yzyYbUITFao6r7TRoL4+aGQiPfC9cKUSFInFF8f/j/sNYTXL9GAdxQeBV4/r95w4bkIw
 tl2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730212815; x=1730817615;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1UUqG8LMQH5EZNY8W+SBrY/LMyHdK3/iMjsnwrOvLEU=;
 b=ra4mcZjPxTUZFcICdWHs/fBYsKF+ZMl8WcF0xRv4FHgMaCLUc+8aARE3SmAEhE6Rnf
 K8bSbocdUDmB540oW+TqGf/7BULRz2nWIwL2kiEDdvrY8l3CBMjhuLjFVuDnaD9OlMro
 7+Elji8sOY/4CpNlh4Ep7F66nBUvBX7kjSeRy5+i9S7o8xB17OTQDNKHf0HruQ4EtIfq
 uENfTQakqAGkZszlL/SU1VrZRSUhjHSIEpT0oaQlUQFUqIPKHVmEV3YJu1e5vzXiMOvk
 ZbUArvh4cMzofmpVY0u3DALiZwkhJH5iilnY6P5r/nygPpeHk6LGQWLPwQ41uwJi+37R
 qLIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMSxH0ZdjQrxmEtBxj4vKqu5xv11IHvvCSQU8DkDLDdU+7/Un1Aq07dqtgxIwo/0hrtPJ9YzORs5hm@nongnu.org,
 AJvYcCXVO8HffJEkeZgO93Xsbw7tmBie+Y3WdYGKDqP+Rl3dRvgb4+DUE7b/w0Wn+YHLk+OUajEWAVLyqytR6w==@nongnu.org
X-Gm-Message-State: AOJu0Yyi7e2BB5zYxZJg4+gS+TH+Yrg36oppZR8DK9qoiZQ1leUuBpzU
 pb0o5j+fZUmQtKvbiLjoUa0hHuuISTadnQRMc5Ec4O8Sm8Fi5Xhl
X-Google-Smtp-Source: AGHT+IFVYMaje/M/QWN+wgbJL8F3lk6TGJhkWUxRiYSGNy2Rwcr1TmLp7NDLv8trvNwNpcmQnbL4og==
X-Received: by 2002:a05:6a00:1910:b0:71d:fd28:70a3 with SMTP id
 d2e1a72fcca58-7206308eac1mr17048228b3a.24.1730212814669; 
 Tue, 29 Oct 2024 07:40:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7edc8696bbbsm7627696a12.49.2024.10.29.07.40.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Oct 2024 07:40:13 -0700 (PDT)
Message-ID: <b6641b83-33dc-46f8-b61b-fbdb9ab9bc40@roeck-us.net>
Date: Tue, 29 Oct 2024 07:40:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] arm: Add collie and sx functional tests
To: =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Thomas Huth
 <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Joel Stanley <joel@jms.id.au>, qemu-block <qemu-block@nongnu.org>
References: <20241017163247.711244-1-peter.maydell@linaro.org>
 <a65a224e-4f54-436d-b555-734a8926d941@roeck-us.net>
 <aa7755a2-e6fa-4d23-bcac-a630e6da98db@linaro.org>
 <d9f18091-aee1-4b32-ba72-e1028fe433c9@roeck-us.net>
 <5262a33d-d0c5-452b-9869-f8f482b1c857@linaro.org>
 <07664ec3-6b46-4b27-9d8c-9e2ff34c9dbe@kaod.org>
 <600baa43c3dd3547338934717cfb57c5e12b0d23.camel@pengutronix.de>
 <84c32f2d-7d9a-4e5a-8b67-1f954dd493f6@roeck-us.net>
 <b67f302a11a679c3fdb02318eb9ef0be559d14ce.camel@pengutronix.de>
 <53cbb597-e7f2-4742-bf85-928c704ddbcf@linaro.org>
 <443f1b0c-8184-4bf4-9f68-c23d7de3bc36@roeck-us.net>
 <1bce4c22-9281-44c5-8acb-860881dc271c@kaod.org>
 <c27fbed6-596e-4ce7-a6ca-6d12d7205e99@roeck-us.net>
 <86fa6e68-5861-4d4d-941f-95b278074eb6@kaod.org>
 <1c917e4a-de50-45b9-ac9c-eb04d51401a2@roeck-us.net>
 <00997cca-6f4a-4b99-9616-2af6a25cd4fb@kaod.org>
 <4246f82b-597c-4a5d-9a55-18a584e7d8c7@roeck-us.net>
 <670fa7bf052d8f292f9bd25c330c8d7bdba02770.camel@pengutronix.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <670fa7bf052d8f292f9bd25c330c8d7bdba02770.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/28/24 01:41, Jan Lübbe wrote:
> On Sun, 2024-10-27 at 20:32 -0700, Guenter Roeck wrote:
>> On 10/27/24 15:26, Cédric Le Goater wrote:
>>> On 10/27/24 23:11, Guenter Roeck wrote:
>>>> On 10/27/24 14:13, Cédric Le Goater wrote:
>>>>> On 10/26/24 17:32, Guenter Roeck wrote:
>>>>>> On 10/26/24 03:02, Cédric Le Goater wrote:
>>>>>> [ ... ]
>>>>>>
>>>>>>>
>>>>>> Works for me, though, and it is much better than mandating the existence
>>>>>> of boot partitions.
>>>>>
>>>>> Yes. However, if the emmc device was user creatable, we could use :
>>>>>
>>>>>     -blockdev node-name=emmc0,driver=file,filename=mmc-ast2600-evb-noboot.raw \
>>>>>     -device emmc,bus=sdhci-bus.2,drive=emmc0
>>>>>
>>>>> and with boot partitions:
>>>>>
>>>>>     -M boot-emmc=true \
>>>>>     -blockdev node-name=emmc0,driver=file,filename=mmc-ast2600-evb.raw \
>>>>>     -device emmc,bus=sdhci-bus.2,drive=emmc0,boot-partition-size=1048576,boot-config=8
>>>>>
>>>>> The above would be my preferred approach if acceptable. The "sd-bus"
>>>>> bus identifier should be changed in other machines tough.
>>>>
>>>> No real preference here, though my understanding is that emmc devices
>>>> are by definition built-in, and that is what emmc_class_init() says as well.
>>>> Also, there does not seem to be an sdhci-bus, only sd-bus, and that does
>>>> not support any index values. That may be just my lack of knowledge, though.
>>>
>>> No, you are right. On a real ast2600-evb, the eMMC device is indeed
>>> soldered on the board. But, for testing purposes, it is sometime
>>> interesting to add some flexibility in the machine definition and
>>> in the modeling too. This avoids "hard-coding" default devices in
>>> the machines and lets the user define its own variant models using
>>> the QEMU command line.
>>
>> I would agree, but I had a number of my patches rejected because while
>> they would be useful for testing they would not accurately reflect the
>> hardware. So nowadays I gave up even trying to upstream such changes.
> 
> My patch to make eMMCs user creatable [1] was applied to target-
> arm.next by Peter Maydell [2] last week.
> 

That works for me with

drivecmd="-drive file=${ROOTFS},format=raw,if=none,id=d0"
drivecmd+=" -device emmc,drive=d0"

but unless I am missing something

drivecmd="-drive file=${ROOTFS},format=raw,if=none,id=d0"
drivecmd+=" -device sd-card,drive=d0"

also boots from the emmc controller. How do I provide the
bus and bus index ? "bus=sdhci-bus.2" doesn't work for me.
There is "sd-bus", but it does not have an index.

Thanks,
Guenter


