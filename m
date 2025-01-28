Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D58C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 10:35:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcivi-0006EV-0N; Tue, 28 Jan 2025 05:34:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcivY-0006Cq-16
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 05:34:40 -0500
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcivW-0000sH-Gl
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 05:34:39 -0500
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e573136107bso8994863276.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 02:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738060474; x=1738665274; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y0OHA9rm33lGie9sv0JBjn3ZpI8DI9Dz60NLKtMDdSo=;
 b=c8hSf/yLjpLoWXo7RuqG41nZe5fQ1fGqs+3IWi//TbcZ1rsc42QoUKNaapafSmM+Mm
 SbEMiDZ/dYCSrnGOsIhsBOoUy/CnweaymoyhbyD5yK9zbhglAjylmgEvscEzrLKxWnTC
 7nKzlZeMdl7sGD8lwET3wvI48ItUQXUuK7AwUA46+OIFfdiEvG6UZwc6nediOXgnjP0S
 gd5qrpskOPIS4QUQO+BH9cqrWNmlAtnfHEz/YKBH+Htndyu3Gti4G9t7HO7hjMKz4T+E
 OFwTBCUnn1KFWRA5qswwkeb6n2/96C6TxfgYHcOCyh/OJbB2hMAhE+VzVgS4HZdOkXNh
 tPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738060474; x=1738665274;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y0OHA9rm33lGie9sv0JBjn3ZpI8DI9Dz60NLKtMDdSo=;
 b=TcUz7dBThIrRGKmQXFKDQLFx5a67ubLQeYfzMAPDQ0Idk1IQUgNhjM53KxlnKTY6pW
 aVabjgvzeoyf3fy9a09tJHNMB8TCP4kcFX/ByosKDX+5dM0x/Hjapjwjr+3wLynDhWQ4
 S9UC1qjrs0435zv/MgW/IY5TdPok8A0Awl3t5uPjaax27krGJnSIqbu6PZTQ54+ej33w
 akq5rjBOSfcCdRInfsxBvj+2g7fJ/PgGiGOohq7kYJC1lP18PeIjgR2CItm86XKU/L8O
 hhUMUqNl3VVO3p9IsuIQndLKBGvdoWcPPFhe6CHGNL16DSn3XoGzhCvp9QY3An0IB2t7
 yNWg==
X-Gm-Message-State: AOJu0YwK4qnUh5tVwgJzEXiydTNmB/ZK7hm2I831JNd1pf4zNrPjkT20
 RcfIpBtNsr/s4cvwxup5nQNEqCYh+jEZeJm6Bza1X/MGmKWq5ymPi71lQ4RxJYMenW865JO4JYd
 2cB/qAStfa8QLofhoIXFQHD8oSM9IdlshGqSB7A==
X-Gm-Gg: ASbGncvt3bvda6JAm8mWNxe5zo50QCRf8im25HCOhhr3pCWsA/tcABrS6Vk8ZZob283
 ZkpNs++sbZwc4U2Ah3LudH4RlbUuXa6XL+9UHvG5h+gN7K0sEMPVTwvZugbOvfOzvfPwRF65g7A
 ==
X-Google-Smtp-Source: AGHT+IHqMy2XU0uUgPCW6MM8rjcfdGIo29ILl+epwUXt6wV+5ueic5xoGlbVV+TT9INo/KWqtBF9TXdaGwXKMfgUJow=
X-Received: by 2002:a05:6902:841:b0:e30:ebdf:9643 with SMTP id
 3f1490d57ef6-e57b1039cc5mr33290277276.8.1738060474550; Tue, 28 Jan 2025
 02:34:34 -0800 (PST)
MIME-Version: 1.0
References: <20250111183711.2338-1-shentey@gmail.com>
 <20250111183711.2338-7-shentey@gmail.com>
 <CAFEAcA_m29rWYQPtz=xSBsS_FXb5_L6+DGBA2o_TrLcFy6YC3g@mail.gmail.com>
 <BB80F4B5-02D5-411A-95DF-9EEE91237EDB@gmail.com>
In-Reply-To: <BB80F4B5-02D5-411A-95DF-9EEE91237EDB@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jan 2025 10:34:23 +0000
X-Gm-Features: AWEUYZnFdLOz3esAFPsdw6ALQspsJMycIuoQyLwQr78QvRL3XQ3yHF1OvF1VCtU
Message-ID: <CAFEAcA-V1fuGeSRvEusMg-03rwBwLq4rKoVPcrW95ByzeQ3kZA@mail.gmail.com>
Subject: Re: [PATCH v2 06/13] hw/sd/sd: Remove legacy sd_set_cb() in favor of
 GPIOs
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, Guenter Roeck <linux@roeck-us.net>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Laurent Vivier <lvivier@redhat.com>, Bin Meng <bmeng.cn@gmail.com>, 
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2f.google.com
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

On Mon, 27 Jan 2025 at 23:11, Bernhard Beschow <shentey@gmail.com> wrote:
>
>
>
> Am 27. Januar 2025 13:24:46 UTC schrieb Peter Maydell <peter.maydell@lina=
ro.org>:
> >On Sat, 11 Jan 2025 at 18:37, Bernhard Beschow <shentey@gmail.com> wrote=
:
> >>
> >> Commit ce5dd27534b0 "hw/sd: Remove omap2_mmc device" removed the last =
user of
> >> sd_set_cb(). Rework this functionality into GPIOs.
> >>
> >> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> >
> >What is this for? We have a non-legacy API for "the SD controller
> >needs to know when the SD card is inserted or the readonly
> >status changes", which is that the controller implements the
> >SDBasClass set_inserted and set_readonly methods. (See the pl011
> >for an example.)
> >
> >I would prefer it if we used that consistently, rather than having
> >two mechanisms, one using GPIO lines and one using class methods.
> >I think we should delete the sd_set_cb() API and handling code
> >entirely.
>
> According to the Linux MMC controller DT schema, there are actually two w=
ays to implement cd and wp lines [1]. When implementing the imx8mp-evk boar=
d, I thought I would need to model the GPIO style [2], hence I implemented =
it plus the active low part on the SD card. Later I noticed that the card g=
ets detected anyway without the GPIO wiring, so I'm fine if the code gets r=
emoved instead.

Even if you did need to implement that GPIO wiring, I think the
right way to do it is for the SD controller to implement a
subclass of SDBusClass so it can have its own implementations
of the set_inserted and set_readonly methods, and then it
is the SD controller object that has the GPIO lines, not
the SD card itself.

(I have a series almost ready to send out which QOMifies
the omap_mmc device and then deletes the "legacy" SD API,
including sd_set_cb().)

thanks
-- PMM

