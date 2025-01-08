Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA5DE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 16:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVYt6-0003B1-I8; Wed, 08 Jan 2025 11:26:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1tVYt1-0003AX-34
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 11:26:27 -0500
Received: from mail-ua1-f46.google.com ([209.85.222.46])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1tVYsz-0006Qz-6d
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 11:26:26 -0500
Received: by mail-ua1-f46.google.com with SMTP id
 a1e0cc1a2514c-86112ab1ad4so4229245241.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 08:26:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736353583; x=1736958383;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t9dwBsCn6Dej+H2X6wzFVUAriPyGB2FbdKvWMgwyGcw=;
 b=VXHB1UDzdsQph2thOcKKewz6EHrhmxYGJfBI+WK6QtU6I25/ytx1tL+nHc2h3MePTr
 Ckzet/JE07AaFb3NyF2Gpr0fpV2/3aXP6Wyio8JDk5piZ3Ph+8yz+TyPzLw7DypxIKbI
 wT378xGOlzg3zKEMs9ORPREJLkuFk4+25ahS/u1BgpF/+DKVtAz3f5FgQbe0EF/0wA2J
 DTuKP/lvWrdQqYbM0HEl3+ATX1rKInOpRCXzc3j1o2xHlRwJ9uzW1/vJYGNh1u6BKGAv
 QgQQZ1Iocj6+CNyWxyMyDcghCb2jgUkdTJ5ANDnYw7+OjT5TBPUN4o7hK/p3c/rZiR4p
 OkAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcRVYYYz3rA6iWJm5qZK15REhQMNAFddjsySIDM7ViAmD7BX1GBDNGr0rVm3zL4u4kDPAgMi5EonTw@nongnu.org
X-Gm-Message-State: AOJu0YyAb8YWanT6XMwRgDTtpWfnbEwD9Tafq4a+pldoTX3EaRCzmprQ
 6anoVZIsjlL9Am0lJjPmuDPjQUGRR+olyOBJQx82rxMPFqX/fFSFWfjsEYhJ
X-Gm-Gg: ASbGncvyg6MKzxA2BypO7rhyy8EXtfyCIHwJlpmUUW9WcUd+P6IkJQSM5dL5ZBq6HEw
 4PlIxFg08StlXHKFuxuDBOWRkEmcdTul3BxEp2rDUvQqKQm+7/sG0GsO99xZdbKWHt4SGZZyOc6
 Z7aZqRxKOUZ/gLG75FnOMDb/Xo9485c8OPGWm85F2f1laebu4HRq+1+D0yTxbizviRyyLPhhdK2
 853LUeFYTamYNVhKV5x6fPIR41CYHMajDpcJrFCEWANhbPqBn3u/eASAEUAnx5P53VSJ2Yc8i/C
 kD01yHXuEpCzBOe5hiw=
X-Google-Smtp-Source: AGHT+IFJ9r9Xfkn29euUP6sw9oGH3pqdCGyuxFsiXaF8i4EJBbB/r49Av25TSrludwcvbi14wyg/yg==
X-Received: by 2002:a05:6102:2acc:b0:4b2:cc94:187a with SMTP id
 ada2fe7eead31-4b3d0d8442cmr2698460137.1.1736353583022; 
 Wed, 08 Jan 2025 08:26:23 -0800 (PST)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com.
 [209.85.217.49]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-4b2bf98d122sm8520934137.7.2025.01.08.08.26.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 08:26:18 -0800 (PST)
Received: by mail-vs1-f49.google.com with SMTP id
 ada2fe7eead31-4afd56903b7so4220137.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 08:26:18 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUIQ7tdbvadj5ArimiBemo1GTwhpWkR7tymavZLQUStbC4O2V4uERfepzmZW9pUcp2xdCOLehppQrYk@nongnu.org
X-Received: by 2002:a05:6102:511f:b0:4b1:1232:def with SMTP id
 ada2fe7eead31-4b3d0d84163mr2204501137.4.1736353578692; Wed, 08 Jan 2025
 08:26:18 -0800 (PST)
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
In-Reply-To: <ecdf9e8a-9886-43e6-bb02-bf04fc1e88a4@landley.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Jan 2025 17:26:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVDhdkLEc-YuDCXHaCpkdtj0QL6wudXDFi0E=PqXyJDtA@mail.gmail.com>
X-Gm-Features: AbW1kvaWzqf26nImabkvqvG5nDawWn3pXa2qtdMQU5IFOL6qj_weGxNPM3O8VjQ
Message-ID: <CAMuHMdVDhdkLEc-YuDCXHaCpkdtj0QL6wudXDFi0E=PqXyJDtA@mail.gmail.com>
Subject: Re: or1k -M virt -hda and net.
To: Rob Landley <rob@landley.net>
Cc: Stafford Horne <shorne@gmail.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Linux OpenRISC <linux-openrisc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.222.46;
 envelope-from=geert.uytterhoeven@gmail.com; helo=mail-ua1-f46.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Jan 8, 2025 at 5:23=E2=80=AFPM Rob Landley <rob@landley.net> wrote:
> On 1/8/25 02:24, Geert Uytterhoeven wrote:
> > On Tue, Jan 7, 2025 at 11:53=E2=80=AFPM Rob Landley <rob@landley.net> w=
rote:
> >> Microblaze has no /dev/?da (as in there's no device I could attach it =
to
> >> even with the long option, I'd have to use NBD), sh4eb has -hda is
> >> working but it's having some endianness hiccup with the network card
> >> (works in sh4 but not sh4eb, I'm trying to track it down, I thought th=
is
> >> worked at one point), and the two "No kernel" ones legitimately have n=
o
> >
> > That's using sh_eth, right?
>
> 8139cp: 8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
> 8139cp 0000:00:02.0: enabling device (0000 -> 0003)
> 8139cp 0000:00:02.0 eth0: RTL-8139C+ at 0x(ptrval), 52:54:00:12:34:56,
> IRQ 128
>
> Is there a different driver I should use? That one works on sh4 little
> endian with almost the same config.

Oh, you're using an SH4 SoC without internal Ethernet (sh7751 in landisk
or rts7751r2d, I guess?). That indeed doesn't use sh_eth.

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

