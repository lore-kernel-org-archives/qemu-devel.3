Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A3BC021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 21:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkrsO-0001us-UT; Wed, 19 Feb 2025 16:45:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tkrsM-0001tP-Ih; Wed, 19 Feb 2025 16:45:02 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tkrsK-0004HI-JS; Wed, 19 Feb 2025 16:45:02 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-abb7f539c35so64753566b.1; 
 Wed, 19 Feb 2025 13:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740001498; x=1740606298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qMUMjboRNAy18NMEZj699jQWyk6xIgQJY40hHkPwU6E=;
 b=He/iNt0PK/4KQsjbY3PsACNSA4G6bJMg2YFei4OmYInm2J9+iNsAPhyoSMQvhbAoQi
 mHq4wijEAhB0HFkeS2x4q75zMX8lsiiEhFs6uSIdro5bdSivpA0RwbXoWfmRjyeStMDe
 cVMlPZO8toYU5mORA207mONkKns4XdPQG2E9M8uY9CHvRztvy63tnIjhMybs9xHwQPUP
 8FG8FuMJbyD+prqWgA9ijHjgrW0adKVkBHfn3sbJG869F7dEXF3587y+8LTQuZwAkOHh
 etGziJQuWdonZHfZGxmSvxKuS/PUY6MeJRa8PRm3FL25mQU3ExdYezt7HKmRUjQD4TBo
 j1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740001498; x=1740606298;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qMUMjboRNAy18NMEZj699jQWyk6xIgQJY40hHkPwU6E=;
 b=DyST+CgcgHLLMofo3DCQ0Z7F1fnualcfw71vLfBKmAN7M8SlzLQTvY8zfvfrPi0o3m
 tZOSH+n44l0Rf3FscWgyG02NhhzEu04+hgMoGcROgKfFB6bqcwq2fSx6Q0OkcCaNTZ5j
 E04jqjltxu1Iwsk5ZaXqO3fDNWQYBsm6Qvs9qhVVOcleMvb4VXMTS6s/7gXU7rce6D6R
 pKznaskX24BpMaC0bpAEiXtfueGf0XdOi2bjH/T0iz7b8iF4tNAJk23Al1X+YxBuaaq+
 Bldz8A3L1vF3K7juB685zZuHoU0mJGbeuWilcg/lkEa49ZrreCqf5bbnvSQNF/3d0fXF
 oIhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpvraQKU4oE5DoCaEiULvnaj9/8e1HDb7BovoKwr7/UXH+1QC2bSNmn1C+psiN9N6HkPKZqijB5A==@nongnu.org
X-Gm-Message-State: AOJu0YyHdAJaNzL7eW31506K7l+ddhyX5QIQy1XpOj6A6vhkQaDHzqgt
 YRuP6UkrXVrAo2RFFaWK3NlTS5MWlY+Dk2G27j9eyv0iMDqx8S13
X-Gm-Gg: ASbGncvNf/gVrclFRGCcWVoeNk58I6va7rHoUOpJhpQqGfMXBFwMIVH6i9KFuRNkWjZ
 Zvn96XnMe3Kcwi2mg4xPrLcDFOxeATLkga7W1CXQCYPA3YUdKb4eWKY/I9caWNp+BrwxkbCwAmx
 MF3y6VOYe4uf6yaZ1ndjfcfDvyyeU4tiz5Iiytif5p5917VOr7sPUEqCQWXS5nPMJS5jR/cyzDG
 KEy+PjknvwG7yLquEIUWS6xS5lkUmvJ4NKbktBjwAjVFWPEwe9qac3vk4eEiQyovMNduICx4WdN
 0fFg6SsF032yclsimmkj++XbiKZcMXQ07W+8LGZGz8V9pZg3KswQO9sS7YhQAIg12Vg=
X-Google-Smtp-Source: AGHT+IE3rtRkykFi0q3EMY6UzuGdS8WAl0OIn3SBTC2KuIFg/+4NRUmz6P726J7x+mRRVbE7kvwEvA==
X-Received: by 2002:a17:907:d9e:b0:ab3:2b85:5d5 with SMTP id
 a640c23a62f3a-abb70df3417mr2171594466b.49.1740001498082; 
 Wed, 19 Feb 2025 13:44:58 -0800 (PST)
Received: from [127.0.0.1] (dynamic-077-183-067-186.77.183.pool.telefonica.de.
 [77.183.67.186]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abbdf076360sm161654066b.110.2025.02.19.13.44.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Feb 2025 13:44:57 -0800 (PST)
Date: Wed, 19 Feb 2025 21:43:50 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_03/18=5D_hw/gpio/pca955*=3A_Mov?=
 =?US-ASCII?Q?e_Kconfig_switches_next_to_implementations?=
In-Reply-To: <CAFEAcA_4ONvJB0xSSGKo4RXVfjBxck8N3mD6G=n=DKbfK4r41g@mail.gmail.com>
References: <20250204092112.26957-1-shentey@gmail.com>
 <20250204092112.26957-4-shentey@gmail.com>
 <CAFEAcA8yayMSe+64VDV8TwSMi7u0_wLM+y9-TKsnaZS5seNKZA@mail.gmail.com>
 <18125593-7729-40FA-9FC1-7DC912287503@gmail.com>
 <CAFEAcA_4ONvJB0xSSGKo4RXVfjBxck8N3mD6G=n=DKbfK4r41g@mail.gmail.com>
Message-ID: <6DE88581-5B09-4599-ABE0-780D1BC76E66@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 18=2E Februar 2025 10:33:26 UTC schrieb Peter Maydell <peter=2Emaydell@=
linaro=2Eorg>:
>On Mon, 17 Feb 2025 at 20:21, Bernhard Beschow <shentey@gmail=2Ecom> wrot=
e:
>>
>>
>>
>> Am 17=2E Februar 2025 13:35:04 UTC schrieb Peter Maydell <peter=2Emayde=
ll@linaro=2Eorg>:
>> >On Tue, 4 Feb 2025 at 09:21, Bernhard Beschow <shentey@gmail=2Ecom> wr=
ote:
>> >>
>> >> While at it and since they are user-creatable, build them when
>> >> CONFIG_I2C_DEVICES is set=2E
>> >
>> >The patch subject says this is just a rearrangement
>> >of the Kconfig stanzas with no behaviour change, but then the
>> >commit message body includes one=2E
>> >
>> >If you want to build these when CONFIG_I2C_DEVICES is set,
>> >that should be its own patch that does that=2E
>> >
>> >(The move of the Kconfig bits to hw/gpio is fixing a bug
>> >in 6328d8ffa6cb9d ("misc/pca955*: Move models under hw/gpio"),
>> >which moved the code but forgot to move the Kconfig sections=2E)
>>
>> Okay, I'll split the patch and use above commit message=2E
>>
>> >
>> >Separately, it's unclear to me how worthwhile it is to add
>> >these to CONFIG_I2C_DEVICES, because they're GPIO devices,
>> >which means there's not much you can do with them as a user:
>> >as far as I know you can't wire the output/input GPIO lines
>> >up to anything=2E We have the device models mainly for boards
>> >which provide them, so that guest code that expects to see
>> >them doesn't fall over on bootup, and because the board
>> >model code does have the APIs to wire up the GPIO lines=2E
>>
>> It's basically to satisfy Linux which will clog the i2c bus if such a G=
PIO expander is configured in the DTB but missing in the emulation (it will=
 defer probing which will never make progress)=2E Once it is its own patch =
we can decide separately how to proceed with it, e=2Eg=2E dropping=2E
>
>If Linux wants to see it because it's in the dtb for the
>hardware it sounds like the right answer is that we
>should create it in the board code, which we can do
>without adding it to CONFIG_I2C_DEVICES, because we
>can make the board code's Kconfig do "select PCA9552",
>like the aspeed board does already=2E

These devices are primarily intended for modeling our custom hardware on t=
he command line, for the purpose explained in [1]=2E While the real imx8mp-=
evk has a tca6416, I'd rather avoid creating it in board code, even if ther=
e was a model for it in QEMU=2E The reason is that the machine works fine w=
ithout it as is, and that omitting hardcoded peripherals seems to increase =
the utility of the machine because it allows users to customize their machi=
nes without hardcoded peripherals getting into their way=2E

Since the two device models in this patch work by chance if other machines=
 select them I'm fine with not implying CONFIG_I2C_DEVICES=2E

Best regards,
Bernhard

[1] https://lore=2Ekernel=2Eorg/qemu-devel/831901E4-69B2-4637-8507-77C7BF4=
DA65D@gmail=2Ecom/

>
>thanks
>-- PMM

