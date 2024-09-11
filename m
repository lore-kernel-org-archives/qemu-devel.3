Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ABDBEE01FB
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 01:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soCYJ-0005PL-JL; Tue, 10 Sep 2024 21:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1soCYH-0005Lf-Oa; Tue, 10 Sep 2024 21:53:49 -0400
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1soCYG-0007sf-5Q; Tue, 10 Sep 2024 21:53:49 -0400
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-502bb8ebd2aso917146e0c.1; 
 Tue, 10 Sep 2024 18:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726019626; x=1726624426; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TW3BqcGPjNt7Mw09dd8OMaaE8b0rwQoc8fos8Revnj8=;
 b=Disec7VXFsf0Cq57BpTLED30JTMC6en5FkJ5s+EAJpc+yxQCr2RCllUvtJqDlDajK1
 XOQpjLyu+5NZhuFgZtH9TN8sJtn5qiNzCVOAANQW54sM6RvsbgrZqUyEdZDgFx+VEymZ
 bpBWitBIWKiVfyykDBFbMATtcY3p6gA/Vg+OAvxT+ZonyDDqe86pTiq0weARwLEwfm6Y
 GTNvarTU/ulcy8M7dL0phdpYVcezB0sUT2ounrMx/HI3yuzJxcL/VF+y24T9PzBTlBVY
 +XxkgJkojim1wNxbs0Mhh3K97MTlmGLEgJkfoCe15e4hJi8PkLNsHW3D7DzxvN+43gzs
 U8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726019626; x=1726624426;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TW3BqcGPjNt7Mw09dd8OMaaE8b0rwQoc8fos8Revnj8=;
 b=RTzAWDj8s29Ptxd773BU8cmAlsesZgIv8rVeRNXuGr6eLue4yhYcA2FROvgaq5xo3I
 kUS95uhytfeoz8Pq0emia8dnp5IvLOqRbOXRdm+WqwUFrV6XSnuqnNZaX+IlRtrf/sLp
 OhnhzALFlF7nzEwJ1oi/XpXpbGYcf7TBlPu2fAlWWaDFWRC1lEnZFHNikOmG5tDSSlTK
 od0LhYuUS9QW/7YbB8caJPYJk1q1GUQB66BDoW2VZ9cOkx8U3SsBTs13SdrvFb9E11Ph
 6voIK/CrkbEccV+NKM5PqXvivuDg2kCBqLy4Xjt0Gpexrkj1U80s71g9mrOynZOrvQ63
 Fn2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4Wokp8Zn2eko633LsP97zN2pAzFbwZY4CO28cg25vObfy1iDpy2cDn7Buh/I45cZqDuYlicxCI3Fb@nongnu.org
X-Gm-Message-State: AOJu0YxdOEpoPX176IWomg6aLBWXxa48gvhUyhYaKYMTd+HnXDym7QV7
 UNcljRqlFsEKJiyz/6iQr5vjSgUcbhU/3aRsFtastr+wUv0+jVng0a8doi2EX5vsHjGmNZQlwmp
 49k9/lLgjEej7hM8HvjRdlmZ3YV4=
X-Google-Smtp-Source: AGHT+IF7Ye2EBHmgZiZHfb/YixxlOF3ngj6WyD8mVLZXY/WaJuXIEe24MvQMZ0QnHjDYBVD28Y1AKspvsXuWlgncywU=
X-Received: by 2002:a05:6122:3d13:b0:4f5:254e:e111 with SMTP id
 71dfb90a1353d-50207c86218mr11245316e0c.7.1726019626480; Tue, 10 Sep 2024
 18:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240910045419.1252277-1-alistair.francis@wdc.com>
 <20240910045419.1252277-3-alistair.francis@wdc.com>
 <1eadf79e-ffe3-4d46-93a8-bebebf38e03c@ilande.co.uk>
In-Reply-To: <1eadf79e-ffe3-4d46-93a8-bebebf38e03c@ilande.co.uk>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 11 Sep 2024 11:53:19 +1000
Message-ID: <CAKmqyKP4zBLKdPzFQ2Z136y3zztGOWYLCWAcB0St+9PNyrGPtg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] hw/char: sifive_uart: Print uart characters async
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org, 
 Bin Meng <bmeng.cn@gmail.com>, palmer@dabbelt.com, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org, 
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 atishp@rivosinc.com, dbarboza@ventanamicro.com, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2b;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Sep 11, 2024 at 6:35=E2=80=AFAM Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> On 10/09/2024 05:54, Alistair Francis wrote:
>
> > The current approach of using qemu_chr_fe_write() and ignoring the
> > return values results in dropped characters [1].
> >
> > Let's update the SiFive UART to use a async sifive_uart_xmit() function
> > to transmit the characters and apply back pressure to the guest with
> > the SIFIVE_UART_TXFIFO_FULL status.
> >
> > This should avoid dropped characters and more realisticly model the
> > hardware.
>
> Does the UART work reliably using the fifo8_*_bufptr() functions? One of =
the

I haven't noticed any issues.

> motivations for my recent Fifo8 series is that these functions don't hand=
le the
> wraparound correctly, unlike the fifo8_*_buf() functions in my recent Fif=
o8 series
> which do. This was the cause of Phil's async issue in
> https://mail.gnu.org/archive/html/qemu-devel/2024-07/msg05028.html.

I'm not sure if it matters here

    characters =3D fifo8_peek_bufptr(&s->tx_fifo,
                                   fifo8_num_used(&s->tx_fifo), &numptr);
    ret =3D qemu_chr_fe_write(&s->chr, characters, numptr);

    if (ret >=3D 0) {
        /* We wrote the data, actually pop the fifo */
        fifo8_pop_bufptr(&s->tx_fifo, ret, NULL);
    }

I don't care how many characters are returned from
fifo8_peek_bufptr(), I'll just write them and then pop that number
with fifo8_pop_bufptr()

If fifo8_is_empty() isn't empty I re-add the watcher for qemu_chr_fe_add_wa=
tch()

Alistair

