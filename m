Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C1FC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 08:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYhKn-0003Lm-Nj; Fri, 17 Jan 2025 03:04:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tYhKm-0003J8-Ic
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 03:04:04 -0500
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tYhKk-0006dR-3K
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 03:04:03 -0500
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-303548a933aso15784031fa.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 00:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737101039; x=1737705839; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jbd5a/iALj6Zh3q4rOsOeTPG8nmgzacpvmEmW6NCWoY=;
 b=GTsQnJqsYmtxXsAijO3UG4d1xBJhXZhlfpV4mRS4ZRFCpIQs/80N/GqJXWxA8yNnPp
 UHwiOBrjY08zToxZ/GrpEZgzRJWPq/AF5alp5AZvjTp+NgV4gg8+gTTZWldslvDkgTv5
 iPXwUtBYk6RRskkWFIJ6bD2gNAGoSC/YMzSrf8mMWsrcXCd7RkcxNVvqCrFxLNryQxT9
 JR3ISzE5ih1vtkNLW/5WZIcQPn6+8vxMXTcrEnM7DUhAF0mpRdmFF+wd5cSTurpwtLXz
 WYCTlokSR0E/cQrSyU4EO8bScItFaa7E/0ZxMHK5f2k5s4b9ZMjfFn/0/b+dl9b3pqMN
 PlCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737101039; x=1737705839;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jbd5a/iALj6Zh3q4rOsOeTPG8nmgzacpvmEmW6NCWoY=;
 b=Rr4GyfBoLzU4tWng6N8O6EIFRMAxSPoVaxTFEqEhcCFz8vg72DndFo1TnB8p783Hmg
 KLYV8knMMvztaKAltAetyu8pQK1QedtcE9e85WJ7Ix4eDs7TjxuWuIGZ9C27bxES7RP4
 GranFrvnvTE97eaU1SOGU50D5Xz22aIraK0avjAT5/+KP11maiMHZxdX+7P8EIdwHh5b
 JUOdKxjlmn5yO8yHdTlz+rqUVdCwOmPItTJcG0w622nDeukW+0+hsqeF1ziKJjzTfXxj
 OybuZChrYNGaeA0AGE5X5HT440Gmv+lv7lEX2CP0roVOEZwrpbPPqlTJf2gfJmxrhl7S
 34jA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXIvYqSlXivbMq8s2xkJB9nd3Bu9dyt9rQTVAbBpShXQRWIiwfPYYlxAhGNDm14/7y2Tasn/xpdkzt@nongnu.org
X-Gm-Message-State: AOJu0YzMVahsxN4KYgrxg6GDAFSLHMEQTzCBTHqmS7xmyVVA9Oop7cxn
 nOcYpOyWnnoVNsKYBkFOegRZMfmpu0UUfibHUodolLCqKb/XGi4C+zxNIjZRdZ4iNTXrzV9jFdn
 Thl0FnDCAipLABXR55gG+o8wlEm4=
X-Gm-Gg: ASbGncv5vB7eM2Kuk0ELQYkHIsBA0eemCHPbn+NBpCIycHzNYM69AGdPbAPVu/+yM+i
 XMx2qsFUNP/L7AhdCQdnxHEN5w8H4CK0JkpUGNWMnCfQKSA1PsbnX87HPREFAVOKHwlUypqRd
X-Google-Smtp-Source: AGHT+IFrI/YBM+RrwkYmsj1vS+8eJOaCuWpWxUXMQUa7oyW9hnxfFXgoNwy28nDqvfG536nTiE3Uk7FCbSF8seOXzN4=
X-Received: by 2002:a2e:a987:0:b0:302:3d74:a1af with SMTP id
 38308e7fff4ca-3072ca99b62mr5438021fa.20.1737101038774; Fri, 17 Jan 2025
 00:03:58 -0800 (PST)
MIME-Version: 1.0
References: <20241016102605.459395-1-r.peniaev@gmail.com>
 <20241016102605.459395-7-r.peniaev@gmail.com>
 <CAJ+F1CLkn2WcmJEmNpJwNcc5VPriDTdSFWcv44QWaYtvHycKcQ@mail.gmail.com>
 <87frmuwo6p.fsf@pond.sub.org>
 <CACZ9PQUk7ZjwfYWVNq3z2Wp_pnkKO8ObhLc6uy5ABHq2yCL9Ag@mail.gmail.com>
 <Z4jtJMNeXexEEpVZ@redhat.com>
In-Reply-To: <Z4jtJMNeXexEEpVZ@redhat.com>
From: Roman Penyaev <r.peniaev@gmail.com>
Date: Fri, 17 Jan 2025 09:03:47 +0100
X-Gm-Features: AbW1kva1CIjRSbJxyAYznbzAgDurxKTvQOg7XfBqsqN6pcrkRFQ0FmjF4b8iPDg
Message-ID: <CACZ9PQVzRwgqix=6Do67kgLEJNP4xQZ4dHKrfONHh78vJU1CLg@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] chardev/char-mux: implement backend chardev
 multiplexing
To: Kevin Wolf <kwolf@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=r.peniaev@gmail.com; helo=mail-lj1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Kevin,

On Thu, Jan 16, 2025 at 12:27=E2=80=AFPM Kevin Wolf <kwolf@redhat.com> wrot=
e:
>
> Am 17.12.2024 um 11:32 hat Roman Penyaev geschrieben:
> > Hi Markus,
> >
> > Thanks for the explicit info. But I have a lot to ask :)
> > Do I understand correctly that there are two ways to parse
> > arguments: classic, via qemu_opts_parse_noisily() and modern, via
> > qobject_input_visitor_new_str()? (for example, I look in
> > net/net.c, netdev_parse_modern()). My goal is not to create a
> > completely new option, but to add (extend) parameters for
> > chardev, namely to add a new type of backend device. This
> > complicates everything, since chardev uses
> > qemu_opts_parse_noisily() for parsing and bypasses the modern
> > way (I hope I'm not mistaken, maybe Marc can comment). And I'm
> > not sure that it's easy to replace the classic way of parsing
> > arguments with the modern way without breaking anything.
>
> A few years ago, I tried to unify the QMP and CLI code paths for
> creating chardevs and this involved using QAPI for everything. As far as
> I can remember, chardevs don't use any of the QemuOpts features that
> don't exist in they keyval parser, so it's easy from that angle.
>
> What makes it more complicated is that CLI and QMP options have diverged
> quite a bit, and while generally the same functionality is available, it
> sometimes uses different names or is negated in one compared to the
> other etc.

Right, I noticed that as well.

>
> So I ended up writing compatibility code that translated legacy CLI
> options into QAPI-compatible ones, and then I could use the exising QAPI
> types. Part of it made use of aliases, which would have been a new
> feature in QAPI, but Markus didn't like them in the end. They could have
> been replaced by manual conversion code, but I didn't have time (nor, to
> be honest, motivation) to work it any more when Markus had finally made
> that decision. It shouldn't actually be very hard.
>
> Anyway, if it's of any use for you, feel free to resurrect parts of it:
>
> https://repo.or.cz/qemu/kevin.git/shortlog/refs/tags/qapi-alias-chardev-v=
4

Nice, thanks for sharing, will take a look.

>
> (Or maybe I will eventually...)
>
> Whatever you choose to do, my one request for you would be that you
> really make sure that CLI and QMP are structured and behave exactly the
> same with your new option, to avoid making the problem worse than it
> already is.

I understand this as keeping compatibility between CLI and QAPI at the
command line interface level. In simple words: a new command line option
"list.0=3Did0,list.1=3Did1" should be parsed in CLI exactly as QAPI will pa=
rse
it in the possible bright future (I mean once the whole chardev is switched
to QAPI). If my understanding is correct, then, with Markus and Mark-Andre
help, I'm on the right track.

--
Roman

