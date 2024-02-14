Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684C7C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 22:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raNzC-0001vi-Q2; Wed, 14 Feb 2024 17:44:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrea.adami@gmail.com>)
 id 1raNXg-0001ZJ-NR; Wed, 14 Feb 2024 17:15:48 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrea.adami@gmail.com>)
 id 1raNXe-0001sL-Vb; Wed, 14 Feb 2024 17:15:48 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5c229dabbb6so188714a12.0; 
 Wed, 14 Feb 2024 14:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707948944; x=1708553744; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wKyrozdZpKUAYYjUCslzqK5jqOXXWwotKTLp3TH3Ng8=;
 b=EzByRGoXRsQG++g5Ik3g03wZwIccQYgw7nbJMCUDLZ7u3YNmv8MuibrJ0xBjnRNLyV
 OGM8AA0K8YFVfbNLzygQWEE2eWBd/rDCURGgpXOMtAwK5TjbFNt5RP0VH/7P8Fe03O8Y
 7zY/f4UeLZUwd5k4Aul5RPV8hcdlqzqCUpYcHrNkoznn23aT6alZvoWjKyLVS1EYzbX6
 TDyLmCI7ZM3uGqsoc1IS7Yq48U6ZN9edlospbRW1oFSx1AJKGHykpaQ5nd8hHeuof5n2
 pGG2E1prHxJZn4elaaoPiqqZzejh/ANpk6LgFW3TVcTYtl0NEqnmRY1n/SvfLU4w7vld
 Vipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707948944; x=1708553744;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wKyrozdZpKUAYYjUCslzqK5jqOXXWwotKTLp3TH3Ng8=;
 b=QvYU69JMGK/CvjHse9LZksfxvY4UY95c/tw3JLhkz0yat2TrEwgN7zd3jbRbfpRZMi
 GJuwC1rLXn6siG6wdKiseDuj/rVSEc+rgu51LOfpWV2TcepAyaHsaI5YwTlnRQUQEgvC
 6WaI5re7Tn3f0e8WRp5a8/ZGuGfvHiWe9tb0Bnjs4T5Zv5zyC4xfEjl4JrONAkX/wEJl
 f3stY/RcxqWiSIqVQNiEXAnVVz8j5iD2ijy9qkp8WeDTMJi/KpvLH34pHCe9xsp2yUNW
 +5i14IUcH/S7EjLGvOA7xbOo/XGXhyWTfaJbhfRc6X18Ak4/cBeXDlZCtFQHTVPz3qYL
 055Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAAAZTbbunxw2DrYWwrqf+VUp9IxJQMrMov5k6dBKQMKqsZqxl37/LDG1TbRkuU0rwvq6hs+P1b8JBMxkAhgoK5jylcfrTTY+fW9yjmIzswYJvpdBtXcEHgmw=
X-Gm-Message-State: AOJu0YytkOaqwn22H2/XwQ3CZuiegsVzDWoUUqZWODijN5IPWvShXlEP
 WYh4k57RfNB4uT/TimbCaGqbmDTuR8r+LatMe8s3zsGdgXFzxuQ0VeYz7QTqziDViADkqPtUcmL
 rAp0LfvUHdDehQH7MfTnHBGvU/zY=
X-Google-Smtp-Source: AGHT+IF8XOaISlxWHzhOD+q/rFwcHP8bty1nhxQi1CoqlyUcyQ0/MQm7ZirVDOIcQLpXMU0xB1iPz2vCCGHKKnN/Wnw=
X-Received: by 2002:a17:90a:d318:b0:298:b2d7:77b5 with SMTP id
 p24-20020a17090ad31800b00298b2d777b5mr57226pju.19.1707948943387; Wed, 14 Feb
 2024 14:15:43 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA88UGhjh8-iBvhxx6GdWg74dinYouiguTcz=qEe51L7Ag@mail.gmail.com>
 <fe5476c7-82e0-4353-a943-7f39b14e1b5b@roeck-us.net>
 <CAFEAcA-bqOM4Ptws-tsEwo2HDZ6YSX1Y+xGkR0WueRD_dUd0+Q@mail.gmail.com>
 <7bd858a2-9983-4ddf-8749-09c9b2e261f9@roeck-us.net>
 <fbab8e59-6d2d-4193-a5ca-9fea3c524229@app.fastmail.com>
 <CACRpkdbmJe8ZE7N0p_utWucyw+3mp1Qrb0bQEKcJPmwNFtVA_g@mail.gmail.com>
 <CALT56yOT_U9jVkhTP=zZu-32B4pta5zaJocn9695N7ari4cFyQ@mail.gmail.com>
 <4781f6c5-4a0c-4b24-bf8f-5fdc17b074b2@linaro.org>
In-Reply-To: <4781f6c5-4a0c-4b24-bf8f-5fdc17b074b2@linaro.org>
From: Andrea Adami <andrea.adami@gmail.com>
Date: Wed, 14 Feb 2024 23:15:32 +0100
Message-ID: <CAAQYJAuq03WcC49c6cecEvRzgkQQxB0H3w4RKUz7DsGZG=dXcQ@mail.gmail.com>
Subject: Re: possible deprecation and removal of some old QEMU Arm machine
 types (pxa2xx, omap, sa1110)
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, 
 Arnd Bergmann <arnd@arndb.de>, paul.eggleton@linux.intel.com, 
 Guenter Roeck <linux@roeck-us.net>, Peter Maydell <peter.maydell@linaro.org>, 
 QEMU Developers <qemu-devel@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, Janusz Krzysztofik <jmkrzyszt@gmail.com>,
 Tony Lindgren <tony@atomide.com>, Linux-OMAP <linux-omap@vger.kernel.org>, 
 Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, Stefan Lehner <stefan-lehner@aon.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=andrea.adami@gmail.com; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 14 Feb 2024 17:44:13 -0500
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

On Wed, Feb 14, 2024 at 2:39=E2=80=AFPM Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> Most of OpenZaurus/=C3=85ngstr=C3=B6m developers abandoned Zaurus devices=
 in 2008.
> Usually in favour of Nokia 770/n800/n810 tablets.
>
> Both OpenZaurus and =C3=85ngstr=C3=B6m used own hosting in handhelds.org =
era.

I joined OpenEmbedded in that years and it was the only reliable repository=
.
The most recent works for kernel have been committed there, in the
meta-handheld layer.
Due to my limited knowledge I could only contribute to finish MTD
support for Zaurus.

I don't have anymore the devices, in perspective I can only imagine
Qemu support if any.
It was fun, thanks to all for your support!

Cheers
Andrea Adami

