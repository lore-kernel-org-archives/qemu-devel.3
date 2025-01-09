Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB8FE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 08:50:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVoEb-00071L-1J; Thu, 09 Jan 2025 03:49:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1tVoEZ-00071D-8p
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 03:49:43 -0500
Received: from mail-vs1-f44.google.com ([209.85.217.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1tVoEX-00078j-CT
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 03:49:43 -0500
Received: by mail-vs1-f44.google.com with SMTP id
 ada2fe7eead31-4b1279ca1d2so213084137.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 00:49:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736412579; x=1737017379;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=980cp5wg6VreAhZrvif3H7Z9Otc1vWhF3tByoZBAw1Y=;
 b=XsnBAngG04Qg4NZ3wL4saMS5r2/v4cm4SqzwiZK5arbtzcdj8j9I7pZAn5tjO1iDlY
 V2nyEUbwTUxwW9k53BnUQsgZ+Inm7z2//Apt40YNR1AAMFzKzNGFYGql16A0TPUPkIMQ
 7E3gT85w2xbk4amWCDHOaTQCx0gemBjRSIn8jUv1Mrxi9HhIP3OjYc7hxGDo7ShGTE50
 yGK7Jvq8FAUu39/y22TodStGN2gD7xaIgBpu097pjSHCFYckIZyaw5nmjETYYwzm7+fy
 eGzVYk9wkNJg5A6rxXBNBK9GJK08qw4u0Sw+boOl/m2SyRtwQ4pW7J4aCVdIfFKNlLnn
 wnFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuWgmNiwCcF8h1r+aRw6kUd+QdRXBtuQ6vWdaQF1hPMkapMSVLmxWdi/PpHXAm6WjDqmdlKvWcof48@nongnu.org
X-Gm-Message-State: AOJu0YxATsyyUd0MeMFRSttFP++/W4ft9aC9AWFtkLDAlvy/8Gq0NuGH
 XplqzsCJPiAsZQwJ+gprpq2QGZZdBNSlUDYv3Ia1GEo3d1Kpd+WImZYPS9WJ
X-Gm-Gg: ASbGncsx2tDaLOi7djk4fith76dP9TpKgLTOdHZtyNJRCkBwutlAJXqiWvm3SE51u2U
 JQnj2qjt/DvxdkKYYrvg/ZICLWn4ScqDg3I0iV0pEv0tuZHAyqY4nWo+UMzq67YRmy5iq6l18OR
 YyUPk0c7yzihDYtX24oMahM4Xdl1+ECTxcBZ1LpAQq/uEDIrb5QIK8Jl7BdZTQONyCFQ3Kb8XDz
 4Lv0axAfFdASFRVJTbhQ9kJ+iqsHSadeswitOJyEL9hKnRvNoJoxhBaM+aLMjaJ6YYG6Mh+umjq
 YpbyRH5X83XxLXPOV9c=
X-Google-Smtp-Source: AGHT+IFi5wa/lQ1fgqhhV/USMoVDcuV4kGfWx9V4BGPXyidQZowg1v3fAcnFtobcSLIB3t2rqeej/g==
X-Received: by 2002:a05:6102:b12:b0:4b2:5ca2:5b5a with SMTP id
 ada2fe7eead31-4b3d0f05be1mr4454037137.9.1736412579457; 
 Thu, 09 Jan 2025 00:49:39 -0800 (PST)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com.
 [209.85.217.52]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-4b608f890easm532272137.19.2025.01.09.00.49.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 00:49:38 -0800 (PST)
Received: by mail-vs1-f52.google.com with SMTP id
 ada2fe7eead31-4b11a110e4eso170922137.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 00:49:37 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXdpaZak7/yTapJJBtUHaxsxw+mc4PEWfdSh+iZcGkXbV4FrTdW8btfqSM5/7RfCy82I3Zkn4R4elYU@nongnu.org
X-Received: by 2002:a05:6102:290f:b0:4b2:5d63:a0f3 with SMTP id
 ada2fe7eead31-4b3d0f2d89cmr4381603137.15.1736412577224; Thu, 09 Jan 2025
 00:49:37 -0800 (PST)
MIME-Version: 1.0
References: <9b2761aa-8ee0-4399-b237-31e70e3ed165@landley.net>
 <Z0Cyx3i3z7Zl7XPm@antec> <31fa6255-8e0c-4d05-bad9-dd843c676244@landley.net>
 <Z0GSETLeT5w8B2DX@antec> <87a6b910-5af6-47ad-ad8d-b79f11a7cbf2@landley.net>
 <Z0LMqEqcdjkAxnN-@antec> <57c5207c-3aca-47cd-bfd3-3d7eb7be3c0f@landley.net>
 <Z2lgL31ZeSkO59MZ@antec> <8807078a-0673-4b27-8d58-4a2a3ce4987d@landley.net>
 <39511711-b86a-4ac6-8bd6-8dab824b693e@landley.net> <Z31k3zNN3pOdGWWK@antec>
 <0d2df37a-a167-445f-aacf-714a29587511@landley.net>
 <CAMuHMdU2XT=xHr3D4kWVSU=h4jJSoQj1RAdeXDNGEDXdOaqBjQ@mail.gmail.com>
 <ecdf9e8a-9886-43e6-bb02-bf04fc1e88a4@landley.net>
 <CAMuHMdVDhdkLEc-YuDCXHaCpkdtj0QL6wudXDFi0E=PqXyJDtA@mail.gmail.com>
 <4b9b20a0-ab3a-4ef5-9ae5-5a32a2eb6be7@landley.net>
In-Reply-To: <4b9b20a0-ab3a-4ef5-9ae5-5a32a2eb6be7@landley.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 9 Jan 2025 09:49:25 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVZU1JBFg_Z8gkvi=ovXdyFomvG4R-oUUCKiiuyXs2LKQ@mail.gmail.com>
X-Gm-Features: AbW1kva_tBde59Tj-FtT2FMM0NeMlWqY72yftUafHQ8o4qk5LZMDGlu0s4tj9bc
Message-ID: <CAMuHMdVZU1JBFg_Z8gkvi=ovXdyFomvG4R-oUUCKiiuyXs2LKQ@mail.gmail.com>
Subject: Re: or1k -M virt -hda and net.
To: Rob Landley <rob@landley.net>
Cc: Stafford Horne <shorne@gmail.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Linux OpenRISC <linux-openrisc@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.217.44;
 envelope-from=geert.uytterhoeven@gmail.com; helo=mail-vs1-f44.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=no autolearn_force=no
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

Hi Rob,

CC linux-sh

On Wed, Jan 8, 2025 at 11:40=E2=80=AFPM Rob Landley <rob@landley.net> wrote=
:
> The sh2eb turtle board uses JCORE_EMAC which is still an out of tree
> driver. It's not secret, just too ugly to go upstream: done by a
> contractor and never cleaned up, full of half-finished IEEE-1588 support
> and so on. It used to be on
> https://web.archive.org/web/20200812035510/http://git.musl-libc.org/cgit/=
linux-sh/
> but alas Rich purged his trees when he stopped being maintainer and
> archive.org didn't crawl that far down.
>
> I have the patch locally if you care, but without the corresponding
> hardware, not much point attaching 1600 lines. (We sent several turtle
> boards to Glaubitz and his assistants last year, and at least one of the
> recipients asked for a copy of the ethernet driver patch, which I sent.

I still have to ask you for that driver, so yes I am interested in
the patch ;-)

> Still applies and works as of the last kernel I updated on the board,
> 6.18 I think? The update is a "pop the sd card, stick in laptop, copy
> files, move sd card back" kinda thing.

... which has been the main obstacle for me to integrate turtleboard
in my regular kernel testing workflow. There are only 24 hours in a day,
so usually there is no time left for juggling SD cards :-(

> I should do a linux image that
> can wget and kexec, but haven't yet... Anyway, doesn't help with this
> issue.)

Does kexec work on MMU-less J2?
On SH4, there was never an upstream kernel that worked with upstream
kexec-tools. The only one that works is the kexec binary from the old
landisk distro, which predates SH support in upstream kexec-tools,
and can only start a new kernel from a system that is running kernel
2.6.22...

BTW, this is seriously off-topic for openrisc and qemu, so please
reduce the CC list when continuing the linux-sh discussion..

Thanks!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

