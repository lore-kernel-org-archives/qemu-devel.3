Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59AF6E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 08:25:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVRMj-0002t7-Ks; Wed, 08 Jan 2025 03:24:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1tVRMh-0002sp-Nh
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 03:24:35 -0500
Received: from mail-vs1-f47.google.com ([209.85.217.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1tVRMf-0003Ge-LC
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 03:24:35 -0500
Received: by mail-vs1-f47.google.com with SMTP id
 ada2fe7eead31-4afeccfeda2so9624035137.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 00:24:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736324671; x=1736929471;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BaBeI/iD9rwPK/9Kgw+JgxCrmVuCW+9PizmHcP7JTnk=;
 b=HANK5hYhChhKAaBQMgG70QwBbWfidZuAyYhE4Wq2nzVScKQP9K5QoUHmoqHf6LtFMW
 38+ZReFL0xb8/4jLak0bP6HVKOz+EOt7ukcXKJRvqyue6OUBAB/lYaVrQ0k0PXl85Cr/
 cCehcH0TZooeuVV3PSjAu0caWwEAYikD9t+1bp6f0q3l/UuzTc7HSe4TjNFpE9yNgR55
 E4GCabH7ZtcwXTuyqVI5GjRmFVZ+15FxGFcNN/OAbNgLzzNiuFEvqDlDuOv9QxyIOv+y
 XFaxMC8zLPW5eoNnB0YK9D+VS9Bwoj2bIxHO5qcafQ4S7rlMYgo78oBUcP05IXKnMkt4
 FBrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQEHd6Ya25XkV9Fa9nhqVlViGi1i3wKkguNuOx+1AKLxUNtrBEgNbzAB68gCYN3OmUQzOBrxAPVFdf@nongnu.org
X-Gm-Message-State: AOJu0Yzkzfr5kD19PDO84BpngsikDydkLqMUHhjovfKKMFKtZlNrJuFv
 2/TCuzrIzNcV/KeSILrJwqwUDp9P42OxmEoWG1s+ePPd1ZykFvpTOGXHnDuB
X-Gm-Gg: ASbGncv1uQ+q5SK4hizeRg0nzSyhWIGAJrWLNQRbTTgNKCf0rjcPU6v0ZdSjEVJoNe1
 bjdGh2cwOE5b0GUUoKWkyX3oD2pMMZFAIPEQUj0bS+IvWF39s45dTdxXwBmRIVfesHl0434NLn+
 6JdYXeYjUpT+SJ8rUj4Be+FtDRL8je4c2k1WZxW2Gyo0bFWLCuPXJ2Z9FnlHpX7kVcl82cdpisy
 mhZBkZEnFi6pAQhelTEeNCYrW2Q9HJoHEkw9ob5Tp8RK7psWADqw7mb4CoSki8Olt7GTsIep+jc
 5LH41dMjVpbVbk5xFvBKxdY=
X-Google-Smtp-Source: AGHT+IHjLjuxpMqkp/SLFa6KIiZN2XqXjZ2Hs3/BwW8CffmtCPoYek7okJGIzwyJCvG6MlXNclel6A==
X-Received: by 2002:a05:6102:548f:b0:4b2:49ff:e470 with SMTP id
 ada2fe7eead31-4b3d0ec6b9bmr1207138137.21.1736324671248; 
 Wed, 08 Jan 2025 00:24:31 -0800 (PST)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com.
 [209.85.221.179]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-8610ad72cdbsm8669792241.36.2025.01.08.00.24.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 00:24:30 -0800 (PST)
Received: by mail-vk1-f179.google.com with SMTP id
 71dfb90a1353d-51623968932so8811861e0c.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 00:24:30 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWe5Ax30rVVcltHfjAWwsfQlIw/fH0sXF9tQ1yLQtf5rxmr7owAfIANKK2lXj7/XyKQELG23oLmBHcz@nongnu.org
X-Received: by 2002:a05:6102:b02:b0:4af:56a8:737c with SMTP id
 ada2fe7eead31-4b3d0dd199cmr1341907137.12.1736324670156; Wed, 08 Jan 2025
 00:24:30 -0800 (PST)
MIME-Version: 1.0
References: <9b2761aa-8ee0-4399-b237-31e70e3ed165@landley.net>
 <Z0Cyx3i3z7Zl7XPm@antec> <31fa6255-8e0c-4d05-bad9-dd843c676244@landley.net>
 <Z0GSETLeT5w8B2DX@antec> <87a6b910-5af6-47ad-ad8d-b79f11a7cbf2@landley.net>
 <Z0LMqEqcdjkAxnN-@antec> <57c5207c-3aca-47cd-bfd3-3d7eb7be3c0f@landley.net>
 <Z2lgL31ZeSkO59MZ@antec> <8807078a-0673-4b27-8d58-4a2a3ce4987d@landley.net>
 <39511711-b86a-4ac6-8bd6-8dab824b693e@landley.net> <Z31k3zNN3pOdGWWK@antec>
 <0d2df37a-a167-445f-aacf-714a29587511@landley.net>
In-Reply-To: <0d2df37a-a167-445f-aacf-714a29587511@landley.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Jan 2025 09:24:18 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU2XT=xHr3D4kWVSU=h4jJSoQj1RAdeXDNGEDXdOaqBjQ@mail.gmail.com>
X-Gm-Features: AbW1kvZzrhxO471coP-DUQZQXWDXgFR5eNkZOOkRN3HgcaBG79rM4GHszy7Ikb8
Message-ID: <CAMuHMdU2XT=xHr3D4kWVSU=h4jJSoQj1RAdeXDNGEDXdOaqBjQ@mail.gmail.com>
Subject: Re: or1k -M virt -hda and net.
To: Rob Landley <rob@landley.net>
Cc: Stafford Horne <shorne@gmail.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Linux OpenRISC <linux-openrisc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.217.47;
 envelope-from=geert.uytterhoeven@gmail.com; helo=mail-vs1-f47.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.24, RCVD_IN_DNSWL_NONE=-0.0001,
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

On Tue, Jan 7, 2025 at 11:53=E2=80=AFPM Rob Landley <rob@landley.net> wrote=
:
> Microblaze has no /dev/?da (as in there's no device I could attach it to
> even with the long option, I'd have to use NBD), sh4eb has -hda is
> working but it's having some endianness hiccup with the network card
> (works in sh4 but not sh4eb, I'm trying to track it down, I thought this
> worked at one point), and the two "No kernel" ones legitimately have no

That's using sh_eth, right?
Last time I tried booting a big endian ARM kernel on Koelsch (R-Car
M2-W), it booted fine until "unable to mount root" (I have no suitable
userspace), except for broken Ethernet, so it failed to obtain a
DHCP lease.

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

