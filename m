Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF30C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 04:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKUxY-0001Iw-1E; Thu, 29 May 2025 00:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uKUxV-0001HY-Qm; Thu, 29 May 2025 00:33:37 -0400
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uKUxN-0003Ph-WE; Thu, 29 May 2025 00:33:37 -0400
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-87de3223127so124448241.1; 
 Wed, 28 May 2025 21:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748493201; x=1749098001; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OKJAFsHaqTPbavvbHENbp9UkgGNHv2yqdu2MMuLDQh0=;
 b=YxnfoFdFdkOwTT06RtixhSLqj+mb0B6bijymxkWrnVvjZ1FcqV1TYftyIbJ5eG6vSv
 DHqaCKJ9FsSH5VGXkBuUN2i+mw+IlNZ+YxnSXQAeV8M9n9vLtaoXYIyj/I2ieprM5k+q
 DV+UM45SLf9NEoC4F+XF//UyIQjeh9v8l2tX1mM15++R+Y1IIUKhI3hrFq4vFqwHB7C9
 a4U0wNK8ooaia53WTcWj0wlgPPkSKuaQcHLxd1pBVSv96dENtB2y+VxsPtcrQjzu65wa
 w0ZijQU6WsSpkQ1FZgBilX+EYXaQ48KwH2skOd4Dt7ycVR07CRjddBihmrivVOGptr2N
 1GKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748493201; x=1749098001;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OKJAFsHaqTPbavvbHENbp9UkgGNHv2yqdu2MMuLDQh0=;
 b=CX09S90ELXxPfZsvzjuJ7GSCx1VLNBKcikwDVHc4k6o87npHbOvGwd0EaFNwVOQRYI
 MfqBS2VNFBvV/OQ9PR7NfwiK8oIx7X6SxmlxNuBOoFAeb+f/MKsIDOapeKtfplwbULdl
 zeOI0f5xdr1B+PO8G7esKMgmjRbkpJDgbPDbiiM/HEupUgkMn0FHeKB0qHvgNRnwZQaE
 KNuMkRf+fOYuQPNZPue4iec4zzhAfhvfR683kYoBll1cD2DGmUNjBlAnMZQscf1E8YRA
 lh2R5pG7Q6W9QjeDP+SyIkLDQhP/3GqMGtrK6/+kk6BnQ/amdAVfjF/Rw9gl82O1zUZo
 RZvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV78AAwolSka+ugi4N+ThH/P125VzGqAYY3uAkiAR0kKeM6fV/tNPKHatSH/0TY4dMFsEhOUzkeUO9H@nongnu.org
X-Gm-Message-State: AOJu0YyPIrlFBLxhnpt7gB0GHfs1zcoY+eQuU4dH3NzEf1QHflGSqUen
 lrHpPKyjjN/XcqRmoUke1Sv0rUTh9VHLakBb4FXT8/cyjHudoB9QbIB017QEKxxD7Sfn4Ngv7s2
 nZwtMQzZcCcS8NBAgfg+eW9rbDpKDmAI=
X-Gm-Gg: ASbGncsWEaOu0meJd3UMviodaUlz8kPBupM9Vv/05cgAK6faNL1xw6VvVTqq9YhhVwN
 vOqgEByCfAdrT0sjmKLPG1vRBSvndJamDqOCL4IhaMz8sMUU1FnCjXMZL655VlKBZwZJmU4Z807
 0Ovvr7hsLr9dEVIVsn5rRsOAnDMOOfd3mJLrd4rziUq7UsTsdTkbn0Ub58riUqCEk=
X-Google-Smtp-Source: AGHT+IFuF/sNAFIibyxqde3pfkHNNT0TX/vrZQ9agjghhcCI4Dd5VEWg4w4rfrg/wF+hZ7qjA3FGB1KoTTnopa1NsaQ=
X-Received: by 2002:a05:6102:441b:b0:4e5:9fbe:79f1 with SMTP id
 ada2fe7eead31-4e59fbe7f3amr5046944137.24.1748493201342; Wed, 28 May 2025
 21:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250520172336.759708-1-dbarboza@ventanamicro.com>
In-Reply-To: <20250520172336.759708-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 29 May 2025 14:32:55 +1000
X-Gm-Features: AX0GCFt_eTzHLnuH-ngNa_2WQcnzGj9vHbPMn7bySaxjmnWvPY96gbunsdhKRbo
Message-ID: <CAKmqyKOh+JhEUPz9NLbfW_JZaV2-j0_fgopU9BjbNp4EkrD4Dg@mail.gmail.com>
Subject: Re: [PATCH 0/3] target/riscv: profile handling fixes
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, 
 ajones@ventanamicro.com, bjorn@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92a;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92a.google.com
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

On Wed, May 21, 2025 at 3:24=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> The motivation of this short series is to fix a reported in [1]. A
> couple of bugs were fixed along the way.
>
> Bj=C3=B6rn, these patches should remediate the situation you're experienc=
ing.
>
> Patches based on master.
>
> [1] https://lore.kernel.org/qemu-riscv/87y0usiz22.fsf@all.your.base.are.b=
elong.to.us/
>
> Daniel Henrique Barboza (3):
>   target/riscv/tcg: restrict satp_mode changes in cpu_set_profile
>   target/riscv/tcg: decouple profile enablement from user prop
>   target/riscv: add profile->present flag

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/cpu.h            |  15 ++++
>  target/riscv/riscv-qmp-cmds.c |   2 +-
>  target/riscv/tcg/tcg-cpu.c    | 138 +++++++++++++++++-----------------
>  3 files changed, 86 insertions(+), 69 deletions(-)
>
> --
> 2.49.0
>
>

