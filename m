Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEF7C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 02:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1GLX-0002KA-0k; Sun, 28 Apr 2024 22:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1GLU-0002IX-T7; Sun, 28 Apr 2024 22:02:20 -0400
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1GLT-0007GS-7c; Sun, 28 Apr 2024 22:02:20 -0400
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-7eb2d7f0efeso1806423241.0; 
 Sun, 28 Apr 2024 19:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714356137; x=1714960937; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SwFDl8bE1tlIfuX5MG8P8hS24elpLjSjtpZ0oYqLQFY=;
 b=lJwWf5V/p2WtlMHgAQEujXx411/bxuqieapMy5eTPYuAKVr4vqsbjSzdcfl08dqbTl
 KqslRFJJrPbK6sOoyQe9ACfa0YSkj55QsDHbEZNvdKlTj37Y8laHpaONenwxqbLQu7tZ
 NjXGXln7/UyB20TJrfxpKlJikXdM7QwRhdEQHQQG07Y/oWeNaIIU4GxE5HpYtAlS/W8V
 6/GugKmcr5jCDOsUKay0J4nwugyKcOXVJYIEL6MCdJhbqy7g/GmeAbz7LP2OdvPGgixv
 sVcZ+l0OvoidjRtRb4wVxqV5/iuAbO9JqfAMCyZKj7E7vqQbsw8brjQaucE2iWGEX6er
 El5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714356137; x=1714960937;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SwFDl8bE1tlIfuX5MG8P8hS24elpLjSjtpZ0oYqLQFY=;
 b=JCVIiuQvkHGOCHwwonDcZz4hzWvsZH3nICHbvAqWvWky4gRjhWMTnapn5FwptFw7J0
 F+3GW3rq/fXB2/svAru19fs2F2sU4r+Pz76+JuUhUQXSEmar0wp9wfKcRM0htq6lnEVG
 5+sNYWrmG7sUgj/K+7bzoy7J6zjL0H85KcW+kgXHuxAj0fTGCyLRwc95mN2fFbvBOX7h
 EOcvVdcgEhFEgp7CTQ+OxPjE8UtS8V5sWNnBttEFtyN1Xr9HGtRd3GW5TeB/aV9SE0WI
 ncP2rMLwLvecggJZVz/PHJ6LCxhbdB6QEttcqDM78yF2aHVv+t6H6gpr2zd+41EX8qPa
 hTxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBlWKbXHRTIxAVVX8CVCe3gQKuj4KXHUK5Ns1vf2oIdAoaNvhCfof4X0226YNuBNKZ9q448+moDPG+HXgj2RZOXIIDtCIt29ztkcQEaOkFohGLE8PEVw8jAtFdslcr6p62rMEkGAWJXPK+wLBwOn07gpGU5Q==
X-Gm-Message-State: AOJu0Yw23nJ0lVy+TiWdLYD2B7sASrUn1u2zdKjsnJCWmFA9PBnU7aOW
 /YMKShJpFGIiXnhs9hWg9uY33NrpubXEC40ftBvcMzm8XF+BzrJxQwlxy/0nThUmh6Xr2lSuYiK
 sBdJL/Kiw8nqNgb9BF9+KMUD7Few=
X-Google-Smtp-Source: AGHT+IGNnWg3TiB22ldpgx9AxTOJ5nlPnpG1dCSFVv+xgDlFvl2vfoJWQdfA9RTw3AZE728bX5hv7wuB6HexAXvKIxQ=
X-Received: by 2002:a05:6102:1628:b0:47b:9290:f903 with SMTP id
 cu40-20020a056102162800b0047b9290f903mr7385418vsb.35.1714356137215; Sun, 28
 Apr 2024 19:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240314061510.9800-1-yongxuan.wang@sifive.com>
 <e841b1ba-1348-48ae-89b7-bfa14ff8e70c@tls.msk.ru>
 <2C907355-C0F4-4C7F-B37C-8B4371A57B00@ventanamicro.com>
 <c174a8cd-4a53-4a28-8688-aa62c7eab45e@tls.msk.ru>
 <97934a65-f62f-49e9-820b-07463c3029ed@tls.msk.ru>
 <896AA0CA-E83A-402F-8A07-5BBA7BEF98F5@ventanamicro.com>
 <6b154471-abfa-49a9-a269-912188c4730f@tls.msk.ru>
In-Reply-To: <6b154471-abfa-49a9-a269-912188c4730f@tls.msk.ru>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Apr 2024 12:01:50 +1000
Message-ID: <CAKmqyKNRyRCqpvii=1JnAQ+=t_TVLiD1oQmFRbk8UkLSqCrDcQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] target/riscv/kvm: fix timebase-frequency when
 using KVM acceleration
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Andrew Jones <ajones@ventanamicro.com>,
 Yong-Xuan Wang <yongxuan.wang@sifive.com>, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 qemu-stable <qemu-stable@nongnu.org>, greentime.hu@sifive.com,
 vincent.chen@sifive.com, frank.chang@sifive.com, jim.shu@sifive.com, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::931;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x931.google.com
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

On Sun, Apr 28, 2024 at 2:41=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> 27.04.2024 18:17, Andrew Jones :
> > I wrote instructions [2] for how to cross-compile without a full enviro=
nment/container once. It might be better for quick, local testing.
> >
> > [2] https://lore.kernel.org/qemu-riscv/20230726120706.335340-2-ajones@v=
entanamicro.com/
>
> I just extracted a few packages from debian riscv64 (like libglib & deps)
> in a separate dir and pointed various tools (pkgconf, gcc -I, gcc -L) to
> that dir.
>
>
> >> 49c211ffca00fdf7c is also needed.  So it's 3 so far, still not compile=
-
> >> tested.  Anything else?
> >
> > Those 3, the first of the series [1], are good. Not sure why it's still=
 not compiling.
>
> Yes, I picked up these 3 I mentioned, in addition to the problematic one
> which is part of 8.2.3.  Once I had the build environment, I tried compil=
ing
> it, and it builds fine.  I wrote it is not compile-TESTED, not as it fail=
s
> to compile.
>
> Also, I tried to build qemu on a real riscv64 hardware (on a debian porte=
rbox),
> -- it built fine (with the 3 mentioned changes applied) and is now runnin=
g
> tests, but it looks like it will be fine too.
>
> > [1] https://lists.gnu.org/archive/html/qemu-devel/2023-12/msg01132.html
>
> So yes, I'm picking these additional 3 from this set, - the ones which
> I already mentioned.

Thanks so much for testing that.

I'm not really sure what to do about the RISC-V host builds. I keep
expecting distros to ship better RISC-V support, but still they don't
seem to have it

Alistair

>
> Thanks,
>
> /mjt
>
>
> --
> GPG Key transition (from rsa2048 to rsa4096) since 2024-04-24.
> New key: rsa4096/61AD3D98ECDF2C8E  9D8B E14E 3F2A 9DD7 9199  28F1 61AD 3D=
98 ECDF 2C8E
> Old key: rsa2048/457CE0A0804465C5  6EE1 95D1 886E 8FFB 810D  4324 457C E0=
A0 8044 65C5
> Transition statement: http://www.corpit.ru/mjt/gpg-transition-2024.txt
>
>

