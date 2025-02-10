Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96953C0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 01:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thIL6-0005Ir-58; Sun, 09 Feb 2025 20:11:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1thIKz-0005IV-QA; Sun, 09 Feb 2025 20:11:50 -0500
Received: from mail-vs1-xe2a.google.com ([2607:f8b0:4864:20::e2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1thIKx-0005LZ-TV; Sun, 09 Feb 2025 20:11:49 -0500
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-4ba7ef5e501so1947501137.1; 
 Sun, 09 Feb 2025 17:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739149906; x=1739754706; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8QzcDy+Dz4vtdrkTE+WXUEp/yYHUyeKheDi/6LffmvQ=;
 b=D8H5t36ixirLNodLIYCq/JzTK6eoHIw3y3/v7sSrPfzafGJtogiJRQ5neM8Rxfhfq2
 raqwW/Ecm6NY4CzAF+IUl548re+TimyjB6FmpwuIVyzZxISbSGMytyW8BZZrkOorJZ2X
 o7vRt9RtSRhMiNwvGyIJH5EqkkB2y4Ea6/2JYGjZcJFAyOO62k4eZ2XjnWbcG8nVttw6
 VmLlDlemrF1nW7RpBARb+edAS71h7zM2FNUr8d/ecPvggQ/HNu3k1SxqleMV/EA8Udd2
 5Sft4UQK6EJZMUCEkWthD7SoTqf2H3aFJIr/EcXfhXbHLy7Ghq1S92R59GMUAcWS+gDw
 kJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739149906; x=1739754706;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8QzcDy+Dz4vtdrkTE+WXUEp/yYHUyeKheDi/6LffmvQ=;
 b=b8e25lfIjgr1sIEeBV0ORWkBgMu6E6HHDDqS44U18jZpT096LJwjQpkwtlZbGuAAlp
 dmbvYdrDxjq/KJ6929XP3JhFvE8Kpdcc4GSiU60ZeHwUjWSLnxOREwETCpCt7RklhFIo
 pE4wcb+J5Xicr1GrCoC/InIXLY4gf82FPeMCuCq6f/cS9Xj/HZM0QtbS87LLlgK/8D/z
 DPmq3aBl3pmRPSzHkzqolLcDmR3b9tG9mBxNFYaff4eFjo8jYQrxr+MYT5K9PnCXhY2t
 TwvMJA1rfP+o6fCCQtK84aTntAIKnuyyL5NPW6Ko0aEv3u98xIfMPMIw1g0YIVWgq4BH
 B6aA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXshzifVEw7ogUsr4nD17dXbEXQVgsNGmY/Acj54k20SoKKXVffcuFTbFVRs/Rg2G7T2dXLYhJCXiS@nongnu.org
X-Gm-Message-State: AOJu0Yzs6P7yucm03xhK4gW2bF+Ss4eyjCCahSwawGUsAZdlkR7C9PpI
 eRzYTf1O+Xu7qFnOXPPL3uXWZBhxyDzKwTK4kynTtbnmE7RcY5GrbGOjw6vrIDeNqb0DfmlaPwC
 w0ARWuFuRdUyIPvn2yKNz+D6dC04arg==
X-Gm-Gg: ASbGncvpvEiIcauY77RFoMRScoCJkvEhaeMB4yn3wlRQDmurL7xymvFwNE1qKpDxIka
 t+hIQ76lX8P5faeusuem+f2uF+Bt9onJYeLXjIDaRH3szr0V6LkUsZ+De+uK1IsiQXeY1eyFvJx
 sS839reM6xwvsoet+tqZusPrtDng==
X-Google-Smtp-Source: AGHT+IFqgqoHbRkyKItbE9tvzmxjWI2e39RhljQu1PbSbqUnqmuPmeTS6GtrnmQiEfpu7gVM5+9Oz50V/a8hrkHB7os=
X-Received: by 2002:a05:6102:2b92:b0:4b2:5ca3:f82a with SMTP id
 ada2fe7eead31-4ba85dc556fmr8198819137.7.1739149906344; Sun, 09 Feb 2025
 17:11:46 -0800 (PST)
MIME-Version: 1.0
References: <20250206153410.236636-1-rbradford@rivosinc.com>
In-Reply-To: <20250206153410.236636-1-rbradford@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 10 Feb 2025 11:11:20 +1000
X-Gm-Features: AWEUYZmnZ6U7AyiPQI_bNQc3uCcU-wqtBw1vrcTCThzHWLpib9FKn0Ng2CKU4YY
Message-ID: <CAKmqyKOm3uQNKDZWx5zivQCNxm=6CrbJw4RA=Dsx1_pELK072Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] disas/riscv: Add missing Sdtrig CSRs
To: Rob Bradford <rbradford@rivosinc.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2a;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2a.google.com
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

On Fri, Feb 7, 2025 at 1:35=E2=80=AFAM Rob Bradford <rbradford@rivosinc.com=
> wrote:
>
> Add missing Sdtrig CSRs per the latest RISC-V Debug specification. (+ min=
or
> whitespace fix)
>
> Rob Bradford (2):
>   disas/riscv: Fix minor whitespace issues
>   disas/riscv: Add missing Sdtrig CSRs

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  disas/riscv.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> --
> 2.48.1
>
>

