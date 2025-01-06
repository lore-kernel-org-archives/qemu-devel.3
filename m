Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC81AE77197
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 01:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUbuj-0007sR-ES; Sun, 05 Jan 2025 20:28:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUbuh-0007ry-Bj
 for qemu-devel@nongnu.org; Sun, 05 Jan 2025 20:28:15 -0500
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUbuf-0001Pw-R5
 for qemu-devel@nongnu.org; Sun, 05 Jan 2025 20:28:15 -0500
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-85c4c9349b3so2899958241.3
 for <qemu-devel@nongnu.org>; Sun, 05 Jan 2025 17:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736126891; x=1736731691; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w3qw3I00CMB6EznQ4XXjqmDcBgRIShrFfpZw0BdII3w=;
 b=Dup2JowaW1PKjcl1+SCPMir8nmnVhvF4K1RrTolhOZluYym027GeZx4w0G4cGKHn51
 fgjdhxHgCszKjuT5MmX8eQ32MXv7ZPv6nyK7xR4cBjBi6Q/T5+1oxv0KkiP0sr9zXv9W
 ZoJoIfAJcYyO4jCETOhoM70bLaz4erICV7GEo72i2uiDaob0RLw2M9aVPLo9Uw+fJYxV
 7E5H+VS73eNs6JKpn4SJyZPu1ssOdm6gR42iqV8yfie8FK1oM7lz3S51A01kp3TiksyL
 lvvsVKz0pYJIAzgvBNG5GvWPU5nc9/Eu3Y1cwWz3SaqWHWnJ89lpH5ArDpKOi8f55LOY
 q0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736126891; x=1736731691;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w3qw3I00CMB6EznQ4XXjqmDcBgRIShrFfpZw0BdII3w=;
 b=MX8uxHOKZPP989nziWT6vKy8uQsanD1CL1WNMX9K+kmUMzmz5hZKSicpWXic18JmdR
 6EFkkjM9JStqCNZG0VhV3JY61sXOWvXa+enfymRpBywr2ViYuE6qV8zhTLOBfqqzF87O
 nMGrV5nqgFsQNu2/V2tWjK2IE229Zu384fJxN+A9b5XvtZKgKYe43R67Bu9Zk0U11agG
 58ryn41shwu+hL2SpA377BoNdxajrpeGyyYQQkMlvzhvrRpNd4gpM6+feV/DrbEKpBiw
 N45NkPOvvG2G/81DGNUUXJ7/EwUemMRY/SCP0IlO39ETIS1JxwAYGyQf/D611hQ39c6K
 GImg==
X-Gm-Message-State: AOJu0YwJLqfZfbdSHwMfFrPiGup4JKH90bBGDdYfry8q7Je1Q3OE1gPh
 U0jD9vjd9KhuGW7OamdYOdSozP+SShPQC/1WMQhWRoYNE4zzb8MSjBw1i+d5pt8Hhv6fcCfq4+q
 o5U/G+AIAYn8lYxoOuPHc760c8fA=
X-Gm-Gg: ASbGncvgNZ2rDDPgjeJeQEM/T/yzDYZ6WwzRC4tWNqCVJYroN6uLxotGT7YR48edStk
 haZCQn+WLn0fNNQ+wivE1yVNQ9H3oMMUWiPY1RmT48xFNn0oaDYUEvhSS88Wca6H9Icg=
X-Google-Smtp-Source: AGHT+IGzFoID6nYbzlxsV7kG3vKsNPYfiqsU4fnqa2hZaPzQf7Mju0Oyxc9hfni9xuD1ynDAy0G4Sar0U75iTYA/hBU=
X-Received: by 2002:a05:6102:50a1:b0:4af:de39:c55 with SMTP id
 ada2fe7eead31-4b2cc48e5dbmr40997859137.27.1736126891190; Sun, 05 Jan 2025
 17:28:11 -0800 (PST)
MIME-Version: 1.0
References: <20241203094702.124748-1-abologna@redhat.com>
 <CABJz62PDz_LJdji-NC7LdmonjshG4w+OqGJPzkuStECzMcYSBg@mail.gmail.com>
In-Reply-To: <CABJz62PDz_LJdji-NC7LdmonjshG4w+OqGJPzkuStECzMcYSBg@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jan 2025 11:27:45 +1000
Message-ID: <CAKmqyKMkN7z51MoAeOK-buDZjKeEV7AjzviyVcZ_AyMEJPgg0w@mail.gmail.com>
Subject: Re: [PATCH] binfmt: Don't consider riscv{32,
 64} part of the same family
To: Andrea Bolognani <abologna@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 David Abdurachmanov <davidlt@rivosinc.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92e;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92e.google.com
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

On Fri, Jan 3, 2025 at 2:04=E2=80=AFAM Andrea Bolognani <abologna@redhat.co=
m> wrote:
>
> On Tue, Dec 03, 2024 at 10:47:02AM +0100, Andrea Bolognani wrote:
> > Currently the script won't generate a configuration file that
> > sets up qemu-user-riscv32 on riscv64, likely under the
> > assumption that 64-bit RISC-V machines can natively run 32-bit
> > RISC-V code.
> >
> > However this functionality, while theoretically possible, in
> > practice is missing from most commonly available RISC-V hardware
> > and not enabled at the distro level. So qemu-user-riscv32 really
> > is the only option to run riscv32 binaries on riscv64.
> >
> > Make riscv32 and riscv64 each its own family, so that the
> > configuration file we need to make 32-on-64 userspace emulation
> > work gets generated.
> >
> > Link: https://src.fedoraproject.org/rpms/qemu/pull-request/72
> > Thanks: David Abdurachmanov <davidlt@rivosinc.com>
> > Thanks: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > Signed-off-by: Andrea Bolognani <abologna@redhat.com>
> > ---
> >  scripts/qemu-binfmt-conf.sh | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
>
> ping
>
> There are already two ACKs so I think we just need a maintainer to
> pick this up.

We didn't get an answer to the issue of a CPU supporting RV32 and yet
the kernel still calls QEMU.

I understand this allows things to work out of the box, but seems like
a disservice to any hardware that does support RV32

Alistair

>
> --
> Andrea Bolognani / Red Hat / Virtualization
>
>

