Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D3FE6FE57
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 10:39:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smspi-0008C3-Fr; Sat, 07 Sep 2024 06:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smsph-0008BC-9r
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 06:38:21 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smspf-0002fU-QE
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 06:38:21 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a8a837cec81so98738666b.2
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2024 03:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725705498; x=1726310298; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IUtn1iZf+4tPsiWmBa8HqfPqfMkyZN6GIF9GSONOtWs=;
 b=RPbVGDTB3UCx7DSYBTZtoB/afaKhyRkvWCHjHTUsPS6qi7zjKXeu4k/8S4ofA5SMog
 R0BFv4+qs/lhogNePjgsnKEfh1nRwEWb5ZHpyerIN3wJar5rO5aJEzwvRmq626JYoMkr
 lEfWl4MZ3RY+CSMX6uwJvW/0qTTiJpmKe/Di4dkriSRECtwc9K8D2TawAazUtZeAmJ3t
 3VtABVmwu2Zbjv3A9nxOnq/qXZ3HXCXKgw4YAKlIBM4O6Y722RWagckb8zUCkGRwxBRV
 vVYIPvKYlIiN4r5ZHQHnpTAVJdXRdbz22N82mzR5grme/4SrlXXeUYd2la/imTrNU6BZ
 PhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725705498; x=1726310298;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IUtn1iZf+4tPsiWmBa8HqfPqfMkyZN6GIF9GSONOtWs=;
 b=MXTIEUL/y1leyKO6RMI1G874tGKqS3CylmEIECT9TuRjsUnfcNEW8zzEhxoPISdYtP
 AK7QYK0JYgA8kjOISoLFjvtwDrlyV8XKa10nU1hZaK6CTermiL6DKj1nHS/0Wo2yvhwB
 iRMhNsGA72vkndcnx2fhAFBx33hl+NFDI1c7Sck6fwtz4mpZyIEv0lXYwZZTTyvTUPjv
 wNfgixhNK7Q9od1QErZUd/iS2qRMU/s7vb9YmtJJ9e47TbUVz23MjECyriqoYZ+dfdeQ
 sieeS+3yy58xEgFXGKkxxtHhJ9bFUkObz9justr3r+H/qCJAPhbHI42RLebc1wDxea7m
 xJBw==
X-Gm-Message-State: AOJu0YxvGHA7oUz7ul2IfaKJcY1QnvkARS4x1NWQE3hK0AKeErWPReFd
 TWwYnG0ErVXXz6wf3hbHVTmj45aXYha4nd8mo41evi4ap92W3sB/J5wDh3iHY2GD5wQ2R9vgbol
 vk9sJ2sCtc396oO7czQJ5qafr1vZHiQ5fFg6xAw==
X-Google-Smtp-Source: AGHT+IFLEdkix1grotQ6GupBYAZveOlR00mvpnnBV5VJyv7YZmpUMsbOYvQFAgIG/Jne5YlnoXbQibDGABN2adEZJs8=
X-Received: by 2002:a05:6402:5405:b0:5c3:c296:1bc9 with SMTP id
 4fb4d7f45d1cf-5c3dc7c03d3mr3934864a12.29.1725705497756; Sat, 07 Sep 2024
 03:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240719181041.49545-1-philmd@linaro.org>
 <4bc83012-3b9c-4b99-8b6b-65f041652540@linaro.org>
In-Reply-To: <4bc83012-3b9c-4b99-8b6b-65f041652540@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 7 Sep 2024 11:38:06 +0100
Message-ID: <CAFEAcA-x_avaFQcrWQj=-e8-5_C4NeWUNxgRqLqKbrJ2HpK4pA@mail.gmail.com>
Subject: Re: [PATCH v5 00/16] hw/char/pl011: Implement TX (async) FIFO to
 avoid blocking the main loop
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Tong Ho <tong.ho@amd.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x635.google.com
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

On Sat, 7 Sept 2024 at 06:42, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi Peter,
>
> On 19/7/24 20:10, Philippe Mathieu-Daud=C3=A9 wrote:
>
> > Philippe Mathieu-Daud=C3=A9 (16):
>
> >    hw/char/pl011: Remove unused 'readbuff' field
> >    hw/char/pl011: Move pl011_put_fifo() earlier
> >    hw/char/pl011: Move pl011_loopback_enabled|tx() around
> >    hw/char/pl011: Split RX/TX path of pl011_reset_fifo()
> >    hw/char/pl011: Extract pl011_write_txdata() from pl011_write()
> >    hw/char/pl011: Extract pl011_read_rxdata() from pl011_read()
> >    hw/char/pl011: Warn when using disabled transmitter
>
> >    hw/char/pl011: Rename RX FIFO methods
>
>
> If you don't mind I'll queue the reviewed 2-8 & 11 to ease my workflow,
> before respining the next version.

Sure, that's fine. I don't have anything pl011 related in
my queue that would conflict.

-- PMM

