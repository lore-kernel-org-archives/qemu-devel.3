Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65D1C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 13:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raFUC-0004T5-2t; Wed, 14 Feb 2024 08:39:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1raFU9-0004PA-86
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 08:39:37 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1raFU6-0000kW-Fj
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 08:39:37 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a2a17f3217aso705577566b.2
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 05:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707917972; x=1708522772; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=LggHhwi3m1WRsUhddvjIokNLKTx/WSiLR+NxAO/q2io=;
 b=UvUxQ181Eqo1G06DgGbKG+mVHxkqTj0fPDddrM6j2SAaGd/eoM5EUDyt3aqqD6wMN0
 r06dIWyLc+R0TfktADrnAl5IR0yQ2LSMBxw0JQZMSRv2pyFqX8W2+5pG9dRnwF/Ia0zT
 5vxL04z1Uwns7f/oXIuqJKgYuBL5AAWCLR4cR4IZ1Z/SbRGesrSLw2ebFlNz0xBYf2zt
 iQKVYfoqyl5vMsOdZEuw6bHy2uwau6zUph8nhr6iTrZ7rHD7IZ1UDYlWB7y2SmNTuVDv
 7tqypDFiTNxJ79mQrvKsfeyzg8WyF715+7ooBdDAtsK0gmHMtHm+glB5a7enG8IitS+N
 bYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707917972; x=1708522772;
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LggHhwi3m1WRsUhddvjIokNLKTx/WSiLR+NxAO/q2io=;
 b=cnj0zF/i61/lJo+MvLzIh1OQ+QCsSckyWaU7xLSQyxVx9FtT+eTJ8HIpKY3IMGcONy
 RrJyEdi9kKpKqnj9GsuLG6Sp0RnZmrkdrafeQXMRV2tqyg9qIlLqlbOScT7dVbutfCk+
 571j2YT5HDbkrjgmbuBQD5IL5dqaP272BgNm8x0m/ySKT+Ji/K0CJKc/UqiqenCMqMEH
 jRthSn8Lc7SpoA048bG3W/U9oT1y9W2hlDv6CunRj1JRk/E3eYELZYrR/CqDPZ9sT3LA
 uJ0hBUuSK0BStciRtOV0OWcVRYA40iukegFFlrP1iZ5jGKMuq5goW9ZO0RM5sXGwPrvZ
 gTdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBSbPwx9n5vVPyarcm04Qkgn5l77VKEc48bBbZItAsXNvoPjWHZU4vYn6cA9L4P4NB2HFtutXdQdkubeXk2vQQldPVFRM=
X-Gm-Message-State: AOJu0YxZPpRsya+P3Wbo3vfU2KevrZsJUMug/BetBGuxW9mFpPsgxD1F
 JC+O6UF0U18akIY9sbPcDIgX0wxelSjieGwOQHK9nHuqWpniSak0LDzN4T73F9M=
X-Google-Smtp-Source: AGHT+IG+ZZoCq+Vw0RPwMQXSsDJliPkaaA698cupwHx3vT4Gqm16aJcc9rjorgM/7kx7Bb5/8IxP7w==
X-Received: by 2002:a17:906:5589:b0:a3c:edf6:a735 with SMTP id
 y9-20020a170906558900b00a3cedf6a735mr1936289ejp.47.1707917972495; 
 Wed, 14 Feb 2024 05:39:32 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX0tgkHYOIoiME2Z+tJNPcYcVzP/fojlHePP5zXMs6K2bBngkU0lk4Gmu7Is0ep84jGi534r0JEwwiSwDSKc3QmcDn8TysnM6YcepFmZNjpZArdIXY+AI0pGq4l4XzPbUyQJ5efXI6dJqA+v2Jxt3WZrJ8/3YbxbD2OVug9GwYKPqWNR6UztA9/JadzVO4KJldLOJnxHwa6zQiSGuQ7XGJn3ZJ/Hg9MGJ6JWkx4ox7r2RoABvQsVNtV3SUpGAwhKQCAiiAgH5jW0eVlNlmO/54O8vGHYhno5Msr8h5RjvhKA+RJePKH2JJbWv5QcXIioF2AekpK6MOKZP5dQAUkR72K0MFDiMKzLJEJlMytIQ1RQ4tK0hAkn1p3OZDrPelBEptnr1gRydW/dXWtI9FRs4hZ6VkAunAXWnAq3Z7BcblHqZdHqQ0gnzaRiebGuAflPGTQHXaW9dEk8hvbm56YgDjA8iaTb87h9Az3GntkAPWsNd49DrWxW0rVfa1C3YcpwT5x+mzS7Nr2Rpt6Qths
Received: from [192.168.200.206] (83.11.29.216.ipv4.supernova.orange.pl.
 [83.11.29.216]) by smtp.gmail.com with ESMTPSA id
 tb16-20020a1709078b9000b00a3ce9081547sm2051268ejc.39.2024.02.14.05.39.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Feb 2024 05:39:32 -0800 (PST)
Message-ID: <4781f6c5-4a0c-4b24-bf8f-5fdc17b074b2@linaro.org>
Date: Wed, 14 Feb 2024 14:39:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: possible deprecation and removal of some old QEMU Arm machine
 types (pxa2xx, omap, sa1110)
To: Dmitry Baryshkov <dbaryshkov@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, paul.eggleton@linux.intel.com,
 Andrea Adami <andrea.adami@gmail.com>, Guenter Roeck <linux@roeck-us.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 Aaro Koskinen <aaro.koskinen@iki.fi>,
 Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>,
 Linux-OMAP <linux-omap@vger.kernel.org>, Daniel Mack <daniel@zonque.org>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Stefan Lehner <stefan-lehner@aon.at>
References: <CAFEAcA88UGhjh8-iBvhxx6GdWg74dinYouiguTcz=qEe51L7Ag@mail.gmail.com>
 <fe5476c7-82e0-4353-a943-7f39b14e1b5b@roeck-us.net>
 <CAFEAcA-bqOM4Ptws-tsEwo2HDZ6YSX1Y+xGkR0WueRD_dUd0+Q@mail.gmail.com>
 <7bd858a2-9983-4ddf-8749-09c9b2e261f9@roeck-us.net>
 <fbab8e59-6d2d-4193-a5ca-9fea3c524229@app.fastmail.com>
 <CACRpkdbmJe8ZE7N0p_utWucyw+3mp1Qrb0bQEKcJPmwNFtVA_g@mail.gmail.com>
 <CALT56yOT_U9jVkhTP=zZu-32B4pta5zaJocn9695N7ari4cFyQ@mail.gmail.com>
Content-Language: pl-PL, en-GB, en-HK
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <CALT56yOT_U9jVkhTP=zZu-32B4pta5zaJocn9695N7ari4cFyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

W dniu 14.02.2024 o 1:26 PM, Dmitry Baryshkov pisze:
>> The thriving world of PostmarketOS only exist because Google was
>> clever to realize devices should have a developer mode.

> There were two projects that worked on reenabling phones and PDAs from
> that era, hack'n'dev and handhelds.org. I think both of them were dead
> when the Zaurus was still alive and kicking.

I left handhelds.org developer community in 2007 due to trademark wars 
when admins wanted to take control of several projects hosted there.

LinuxToGo was created in 2006 and some projects moved there from hh.org 
server.

Most of OpenZaurus/Ångström developers abandoned Zaurus devices in 2008. 
Usually in favour of Nokia 770/n800/n810 tablets.

Both OpenZaurus and Ångström used own hosting in handhelds.org era.

