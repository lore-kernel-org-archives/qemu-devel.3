Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60817C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 10:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raYdY-00016M-GL; Thu, 15 Feb 2024 05:06:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1raYdW-00011d-3w
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 05:06:34 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1raYdU-0004FT-0R
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 05:06:33 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a3c2efff32aso77108766b.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 02:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707991590; x=1708596390; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=h7j7BDbf/2XTLgGFB+o6WPYFGjyq3xmN0zRxSIya6Co=;
 b=oqdHqpnXSSJqP0h5OCYP3CKaZYdsjEX5W45sX2OPNBLODpopvQR9eTHgI8Vin4URRX
 hpUkeUQYGoYEP1nzlncSpUWYs1mAn1nw4eJ+n4TYz/e0dHMg0EPbkeeysFXZKwys0RGs
 DBywzelVrk5dD7mNtpS7cSwh49NDIQ3MzaxgrREtOnnjNP1vRiEFddsDU9k59UqqWggi
 fj3QqRTE5tQPsPjM58z/kGeHtP7824RwcbZvtgFP+ozIWrk0c8vna5zummH1emYsH5iG
 jVmKVUd/dDuBwMXo7JDifnFbrmYC9SmERbJ0dU1ATr4ajTEbwAmP5vai67qsN1DlT+W3
 ijaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707991590; x=1708596390;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h7j7BDbf/2XTLgGFB+o6WPYFGjyq3xmN0zRxSIya6Co=;
 b=RIZAHMx2eHF9PQmxZnYR36sxoiM3tT75j4+/5NZIDr077xFoCopWaqYZOczaeTeJv/
 61aI0zuIF0psYwB161pan8+DSBcSFBrNBcIspCIjYbTPWY0EBXiZB0qwVko8jWkDEBMK
 hnXv+6PDLcr/A19Kzwpa8ILOgqvsVVwjUU9sFaSUjIdK/G9BfXTq2Rl+RXVYuT/RWESm
 6M1KJVEIGz/o4gavR1A1oxGHy6DO/GUZyyexAyvs2ckzzwW3qAA/3lc7WxELrZyBuzsZ
 b2979tifYbapHPodv+CRxmFjXGNr3XmGYE1KbdizeGNIAQZwzFtl+Yyvwi+x5/AJut8a
 Os1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdPSx+taYl4JCMyTPFzRRx8EAr6c420Gfl/aJIIY2HVkEntSbOL+bUWm7BHTXFe6QFfqGMquc6RP3Twjxli+W3NoQzI08=
X-Gm-Message-State: AOJu0Yzgqh3PdLd0vhmGp2ORs3SphrSrxMejG4ohfNhHT1WkPEJYM5pG
 igeiXji/WntambzDsgR0fMdEG0q9uHodlop+RKaC+zTf0yX4cqvE5RkxsRn8us0=
X-Google-Smtp-Source: AGHT+IEEM0cWgYXokqInqYrcPLv8UI1GS1w0YRnrANXKcGmmDrdUCqlP6GLPJ0jaV0GEu8jCAinSGQ==
X-Received: by 2002:a17:906:e089:b0:a3c:f531:4514 with SMTP id
 gh9-20020a170906e08900b00a3cf5314514mr971601ejb.62.1707991589675; 
 Thu, 15 Feb 2024 02:06:29 -0800 (PST)
Received: from [192.168.200.206] (83.11.22.32.ipv4.supernova.orange.pl.
 [83.11.22.32]) by smtp.gmail.com with ESMTPSA id
 fj15-20020a1709069c8f00b00a3d26805852sm393944ejc.17.2024.02.15.02.06.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 02:06:29 -0800 (PST)
Message-ID: <6c27e4ba-34dc-4ba6-95fb-39989d0c2cc3@linaro.org>
Date: Thu, 15 Feb 2024 11:06:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: possible deprecation and removal of some old QEMU Arm machine
 types (pxa2xx, omap, sa1110)
Content-Language: pl-PL, en-GB, en-HK
To: Dmitry Baryshkov <dbaryshkov@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Andreas Kemnade <andreas@kemnade.info>,
 Linus Walleij <linus.walleij@linaro.org>, paul.eggleton@linux.intel.com,
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
 <be4038e1-a578-4439-a9bf-e936484c64cc@app.fastmail.com>
 <20240215093113.5c58cabe@aktux>
 <7c8a5c5b-a94a-4b87-a043-f1e398b55872@app.fastmail.com>
 <CALT56yPLobsL699K9+DDMBWwi7-iLzaYwuDwV7NmecaTY7Z6Tw@mail.gmail.com>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <CALT56yPLobsL699K9+DDMBWwi7-iLzaYwuDwV7NmecaTY7Z6Tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ej1-x630.google.com
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

W dniu 15.02.2024 o 9:52 AM, Dmitry Baryshkov pisze:
>>>> If we want to actually go there, I think the best option for PCMCIA
>>>> support is likely to replace the entire "soc_common" pcmcia driver
>>>> with a simple drivers/pata/ storage driver and no support for
>>>> other cards.

>>> hmm, main usage for PCMCIA/CF in those devices was often something else,
>>> not storage,

>> Do we still support any non-storage CF devices that someone might
>> actually use? Do you have a specific example in mind? These are
>> the currently supported devices that I see:

> The Bluetooth over the PCMCIA UART worked last time I checked it and
> according to your grep it is still a valid user.

If we want to keep those pda devices in Linux kernel then dropping 
whatever PCMCIA which is not a storage sounds like sane way.

No one is going to use such old PDA as daily tool nowadays. And if they 
want then 6.6 LTS kernel would work better due to WiFi drivers being 
still present.

Bluetooth CF cards are old, v1.x tech. WiFi is 802.11b unless you manage 
to get one of those libertas_cs cards but they were rare even when new 
(I was involved in starting 2.6 driver for it). Camera cards had own 
out-of-tree drivers at that time.

