Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A552C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 11:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVras-0003RR-5s; Mon, 22 Jul 2024 07:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sVraq-0003MP-SX
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:52:40 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sVrap-0004dH-3P
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:52:40 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5a108354819so3539104a12.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 04:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721649158; x=1722253958; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jZ21KlAEvzdkGQiCLnhBuH8HdKOIkcFxqc4EGBXsvdQ=;
 b=iZa5apFjtolR7+63JM6zUNvqkqs6idAxWZFrDMMhSQinvg10XBmAcbCz1bWlacm2Em
 pkLgrPco2WeGD0P5F9bICQMJ8lfY04WUg5VrC+H/r/Lkx8BkDQtluU02HdIpVEzYNuQv
 jdqo4AbNgP/kNz+EaXM4DcTcT1TJ3VbrFod4m+NAd5tFawiMFnOstwBCiDg5hbZJY51v
 NGNcA9nNOgUo2qxK+Uu/pSmHp9gK17XO+NZDYMmfJ7U6S3gH+ZFCRyqsaWHIBClkci+q
 y7Q2rw+Q3vKTPislUWkNxFAFMGzOSaERywZipE02mu2kMbL5PjzgsbHa3rOZKsYPP41B
 rlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721649158; x=1722253958;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jZ21KlAEvzdkGQiCLnhBuH8HdKOIkcFxqc4EGBXsvdQ=;
 b=GeE6nh4KGmUOn70skLl8jjAQ2ay2daZwxejk/8CH2yEHSj20mI0Add6Zq3L+vDEV5o
 BWY0wMEGMXMDprxdbhkPw13MJXKjw4abVmn8ODZq+FB/5LTOvO+4PMoAy4w2Y7Lfp6nn
 TRDkSfgxvduVCCurLylT8N1Nvdba5jPdencHA0jquisdERWGKGvuifqUtgwneFAKO5qU
 qBKc55Qb1Se2m244Ld0Snm7RkatIhxFS0HhpmY8/2Ubqcw7jnl68aUmzZHf+fXlv5rTG
 mrO983Jtyu4/0vsy/wFSCMnZeOxRrZktgGpkP/Dt+h1MLWdJ3QD/sUJCQFWxlephudZa
 v0qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrfFnwin/w/tgQ5J3o5HGnCFWsSKHo3yXcLIjC0y+mkACAoFrTg5aHjEo40HlJ2kUKb0KSocTbCkXb6TGGvQuE4mBPAGg=
X-Gm-Message-State: AOJu0Yxe0CnsiY8QMowPJXJR+eZ8VKX/dtW8migZa7GhaTDW0/P4dtxh
 SHXVucfL1bHmqQIHpbobf/N7wgHZNbbhhUsznrPiemdijILivSED/0Pi6eej0Ur189zS1IQREEY
 hAL6v0+lrc+AsP+qY2s7VrDv/TR3carZ/wVTdhQ==
X-Google-Smtp-Source: AGHT+IHgA7yujrNVyQWap29X4Y63y3pXU4QwgbxsjHRZKzjoOp8xab3VuWjJx4fAfVb7anjSIzjNOaN9YX4YZqUgZOA=
X-Received: by 2002:a05:6402:510f:b0:5a2:fc48:db2d with SMTP id
 4fb4d7f45d1cf-5a47adf870fmr4934004a12.31.1721649157547; Mon, 22 Jul 2024
 04:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240719151628.46253-1-philmd@linaro.org>
 <20240719151628.46253-4-philmd@linaro.org>
 <e49735e8-1c33-42cb-9181-662a0c010b97@ilande.co.uk>
 <69df9510-1b1a-434e-bbbe-1df7acf49f58@linaro.org>
In-Reply-To: <69df9510-1b1a-434e-bbbe-1df7acf49f58@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jul 2024 12:52:26 +0100
Message-ID: <CAFEAcA_Ec_P1fNqs6aDK_QnGFDhSapf4btYoM5YjRf_3a4nRPQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] util/fifo8: Introduce fifo8_change_capacity()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 22 Jul 2024 at 11:56, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 19/7/24 22:21, Mark Cave-Ayland wrote:
> > On 19/07/2024 16:16, Philippe Mathieu-Daud=C3=A9 wrote:
> >
> >> FIFOs can be resized at runtime. Introduce the
> >> fifo8_change_capacity() method to do that.
> >> When capacity is changed, the FIFO must be reset.
> >>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >> ---
> >>   include/qemu/fifo8.h | 10 ++++++++++
> >>   util/fifo8.c         |  7 +++++++
> >>   2 files changed, 17 insertions(+)
> >>
> >> diff --git a/include/qemu/fifo8.h b/include/qemu/fifo8.h
> >> index c6295c6ff0..9fe0555a24 100644
> >> --- a/include/qemu/fifo8.h
> >> +++ b/include/qemu/fifo8.h
> >> @@ -31,6 +31,16 @@ void fifo8_create(Fifo8 *fifo, uint32_t capacity);
> >>   void fifo8_destroy(Fifo8 *fifo);
> >> +/**
> >> + * fifo8_change_capacity:
> >> + * @fifo: struct Fifo8 to change the capacity
> >> + * @capacity: new capacity of the FIFO
> >> + *
> >> + * Change a FIFO capacity to the specified size. The FIFO is reset.
> >> + */
> >> +
> >> +void fifo8_change_capacity(Fifo8 *fifo, uint32_t capacity);
> >> +
> >>   /**
> >>    * fifo8_push:
> >>    * @fifo: FIFO to push to
> >> diff --git a/util/fifo8.c b/util/fifo8.c
> >> index 2925fe5611..c453afd774 100644
> >> --- a/util/fifo8.c
> >> +++ b/util/fifo8.c
> >> @@ -34,6 +34,13 @@ void fifo8_destroy(Fifo8 *fifo)
> >>       g_free(fifo->data);
> >>   }
> >> +void fifo8_change_capacity(Fifo8 *fifo, uint32_t capacity)
> >> +{
> >> +    fifo->data =3D g_renew(uint8_t, fifo->data, capacity);
> >> +    fifo->capacity =3D capacity;
> >> +    fifo8_reset(fifo);
> >> +}
> >> +
> >>   void fifo8_push(Fifo8 *fifo, uint8_t data)
> >>   {
> >>       assert(fifo->num < fifo->capacity);
> >
> > The changes look okay, however I'm a little confused as to why this is
> > needed as generally hardware FIFOs are a fixed size? Presumably this is
> > related to the PL011 series?
>
> Indeed, this is to model trying to stay as close as possible to
> the datasheet, which states:
>
>    2.4.3 UART operation
>
>      Disabling the FIFOs
>
>        Additionally, you can disable the FIFOs. In this case,
>        the transmit and receive sides of the UART have 1-byte
>        holding registers (the bottom entry of the FIFOs). The
>        overrun bit is set when a word has been received, and
>        the previous one was not yet read. In this implementation,
>        the FIFOs are not physically disabled, but the flags are
>        manipulated to give the illusion of a 1-byte register.

Notice that in the hardware we don't actually resize the FIFO,
though -- we just only ever keep one element in it...

thanks
-- PMM

