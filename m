Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FCAC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 19:33:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tn0fv-00031z-0Q; Tue, 25 Feb 2025 14:33:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tn0fO-0002v7-AY; Tue, 25 Feb 2025 14:32:34 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tn0fL-0007uL-JM; Tue, 25 Feb 2025 14:32:29 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5debbced002so257095a12.1; 
 Tue, 25 Feb 2025 11:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740511945; x=1741116745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sR6GciG0hUFjtAqEnQdV01KN1dYZppetZ+rCB8dzr2g=;
 b=gapiBc/KByD1XUuphbX80LNMlWSXmH/oyP0ssumkqyY3bL05rqiTUFcRIVoTBkGCO3
 JgRmt21V9BudjrxYHWN8u8tCA0bLPjiAHWIN5hfC2OgY+4QvuNhsIUdY309EAN3YqmR8
 ya98JA++RI0tWEt1hW7BoZUd2VYDLSaJj5eHNo0nTAUrW8uQex2b+UY/YSN+cFjNjTwJ
 QQH8zo97NEe9Gr2rHeTWSu/nYLuvPDG8Qsa/s8ft1gPNNrlDqEQ5W3dopjsSkMNkLGNQ
 pSp2VTpVMt9LXs7PyBC6lt9rYQ2PIivRwWKyzPIKf8mGrfh5kUhGM90TAjCCwssbRB03
 0MXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740511945; x=1741116745;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sR6GciG0hUFjtAqEnQdV01KN1dYZppetZ+rCB8dzr2g=;
 b=NgeV2a6jSmnT4Ume0OD9zixrI7mDhzpRI3s7p8FLF4VyQcspOczksftfPk1MFwiyTy
 ukoiXzxgkW7L8u8uJkUZ9byA6WAV0HyWltTZtcTT+ZDQyzUl0hUGZBUSz3jbwoZMPJ5o
 MExnmWwxWFAP7R/zHuASzYgqdPkRkXE+py0fpbp8A5VdurBksR1sXCUs+6Mp9S5p643b
 F9V9QDokPIf6sYg4fSRMZfnvzDQPmJ/ppm++ftWm38CVdngqrq28V8Q/jiTJPv0pEHYm
 KQtX1R6U9uruNJMPDzmddLMSP2DTwsvYDoJAgr2jCE0LZmW2Kmq49idfNbiH0GAlHdh8
 7KAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU79Xf9RMcMd6dira44xn010DlncSsQmAl5p/WGYtjf0Fkgh0ptKhlr3sR/NRSsyB6pcIQ4vhXm+A==@nongnu.org
X-Gm-Message-State: AOJu0Yw0DqEhqPRb2s2efBiW95Fubh8XCsEErDcU6nNB0iSbySutnE+b
 98g/aIClfcHvqEIwo7dL9eW3OXSXxizRzkEtrqoxZfTPCzApEzXz
X-Gm-Gg: ASbGncsfBrwqSmpYB2GqkCFYj+btSpQIAkmK48TIASCObk7x1j7wK5/HUpPNOr6hNMA
 fSncPW6tH39PiPC0YmEnRCowNtBfLvKiQvRKxYrKA7cRjm5bdcJ2qlz7n8AaNBpBdjojSaDi3+l
 YD96hp1u4xbmiOoWKbqyEt+qtEkR0UOaWwk9hknLiEM2OTqopqabI70MgmFsr9w0JcTMWPpKTY2
 p7WoUo7YT4IT7AaIu5iIMbu1dr7vD2FcEUZcwpLd6WAO4CrWmKjHVIUUvvPlexdiW64ylTc9b/z
 58K2V+mk/C96CmqJk2H0NS/DYRg7zeQzSVqMFQBo32BpvnOjGL1VG7zDBoSHZIuE/z+yy0wASFY
 /xe0=
X-Google-Smtp-Source: AGHT+IHymZ2ZWXwm6t43QilU/nD5vly40BoeUpG79Skm2hsyKZGN/9hF76hPeUEiMpncywJwu2Q91g==
X-Received: by 2002:a50:cd05:0:b0:5e4:95fc:d748 with SMTP id
 4fb4d7f45d1cf-5e495fcfa13mr2039829a12.5.1740511944450; 
 Tue, 25 Feb 2025 11:32:24 -0800 (PST)
Received: from [127.0.0.1] (dynamic-077-188-213-172.77.188.pool.telefonica.de.
 [77.188.213.172]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e460ff861esm1666545a12.49.2025.02.25.11.32.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 11:32:24 -0800 (PST)
Date: Tue, 25 Feb 2025 19:00:44 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 00/18] Add i.MX 8M Plus EVK machine
In-Reply-To: <CAFEAcA-2KXeCVKrx0VQ1axA+nbTKV2fpy--Mti1Q+yFL5XC5KA@mail.gmail.com>
References: <20250223114708.1780-1-shentey@gmail.com>
 <CAFEAcA-2KXeCVKrx0VQ1axA+nbTKV2fpy--Mti1Q+yFL5XC5KA@mail.gmail.com>
Message-ID: <B0823784-69FB-4008-BC71-62F66184C8B9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x534.google.com
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



Am 25=2E Februar 2025 14:43:32 UTC schrieb Peter Maydell <peter=2Emaydell@=
linaro=2Eorg>:
>On Sun, 23 Feb 2025 at 11:47, Bernhard Beschow <shentey@gmail=2Ecom> wrot=
e:
>>
>> This series adds a new aarch64 machine to QEMU: i=2EMX 8M Plus EVK [1]=
=2E It allows
>> for running Linux distributions such as Buildroot
>> (freescale_imx8mpevk_defconfig) and Arch Linux [2] via direct kernel bo=
ot=2E
>> U-Boot does not work yet=2E I plan to use this machine in CI and I also=
 want to
>> make it available to a bigger audience, so I propose to add it to QEMU=
=2E My goal
>> would be to have it added for 10=2E0=2E For this, a Changelog entry cou=
ld be added
>> under https://wiki=2Eqemu=2Eorg/ChangeLog/10=2E0 such as:
>>   * New board model "imx8mp-evk": i=2EMX 8M Plus Evaluation Kit
>>
>> The series is structured as follows: The first three patches fix some i=
ssues in
>> device models reused by the new machine=2E Patches 4-17 add the machine=
 step by
>> step which includes documentation=2E The last patch adds an I=C2=B2C RT=
C which I'd like
>> to use along with the new machine=2E
>>
>> I've based some code on existing one (see "Based on" in file headers) a=
nd I'm
>> unsure how to handle the licensing and attribution correctly -- advice =
welcome=2E
>
>Hi; I've applied most of this series to target-arm=2Enext:
>patches 1 to 15 and 17=2E

Thanks a lot, Peter!

>I've left a comment about what
>I think we should do about patch 16 (the bootrom)=2E
>Patch 18 (the RTC i2c device) I don't have any objection to,
>I just didn't have time to review it now and didn't want to delay
>getting the new board model in until I did find that time=2E
>Since the board code doesn't instantiate the i2c device,
>the RTC is kind of a separate thing from the board series
>anyway=2E

Yes, it's fairly separate=2E I'm looking forward to any comments=2E

Best regards,
Bernhard

>
>thanks
>-- PMM

