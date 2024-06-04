Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8E8C25B75
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 01:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEJRm-0007Su-QZ; Mon, 03 Jun 2024 21:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEJRl-0007Se-Pg; Mon, 03 Jun 2024 21:58:45 -0400
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEJRk-0004jS-4g; Mon, 03 Jun 2024 21:58:45 -0400
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-4eb0c729c2eso166886e0c.3; 
 Mon, 03 Jun 2024 18:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717466322; x=1718071122; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bJuj2RFH0dFtelfSdxHxxfez/21ZSAxFzVTSpj1uwm4=;
 b=U1ksQg8/0JuPHTnxYftgC09v3EvoynexGmDUrvY6L3OZGEvCu7LLR/yrUgaE3Yh6pJ
 tdJoYvAqW/DPsOfIA3YbcukTVQSTTH72tlL2bxSbiImaGdR6FvzTVccuCNmaAbzG1QjA
 y7QSvcy28rZfN49Okt7IyagnXvZQXaanGc/uvJnlF6i090eQmtSpcMLisqtMGe+AHAmW
 5tAswmsmr9OSFP0v48VbiWopM5K0GYnAQDg47JAy5sk3RMGyygiwOIqgG6IusE4X20gD
 047jE/vKzuwqOQ2b5TZTjaxp9U7cEijcQl3KoXhs6G8ZoaGVsyzhIQWvvv4aJRbx7Fac
 RxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717466322; x=1718071122;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bJuj2RFH0dFtelfSdxHxxfez/21ZSAxFzVTSpj1uwm4=;
 b=Uk+GiMRu3tnifHA7Em7JP/1CZC3Pnhthcc/YzS1BpcrOLpnjjypjQ15OKI7TiGMHb0
 OJbzHGcSOIgUP/udcKfrRu4/hqmUInAGDIXM4Y7aArsMVWYipoMZytoi7oSs9amJzuWE
 6PvPYCCx5b7doTA9keC0q9jV4QlCpELVfGx886cW5WrB6XcqmKSjB98RvCUlowgEmBth
 uoczZOkeUrWIcp04nazhcqCD6eRfZ+jP2rka6jnPn+I/Zi3h45xYeBRYEQAkVm+qHW77
 7fkrv+xNHBhRkOwh8VfOHEDP4mtp223tl27CDL7+R6AVUegXFUsntOCXLjMJxu+FD1kp
 ciFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrkEN2VKhOElWuX+6iC8NBtMKfB/XAMpWU8DAJDYTPcMs0mH+LUHlh8PKqn5xk3tunfrZuDEMbzTUzQVWzN3CDHHIr7sQ=
X-Gm-Message-State: AOJu0YySdmrZwHRcFI4+VvXJJOutbgnzQiTUDuGNxohu/hQ7WrODKMmi
 9pqooLg6yZvl17akMNjJX+oZ/JFz775TBLWMDqq5e+AR0zNLhI/hIIUwIP2lyQvkCRT4a4D+OV4
 HME2DUzSjDpVjWcOys/XKtnslXGA=
X-Google-Smtp-Source: AGHT+IHvg3iO3Of846QvT1bukC9j240Ohyb+a9kkm5pKCBK6p/c5e9Xv/e58sCehz33Q89V3itQZzIJunlXEWR5gEZU=
X-Received: by 2002:a1f:fc0b:0:b0:4d3:36b9:2c26 with SMTP id
 71dfb90a1353d-4eb02f45d3emr10352373e0c.14.1717466322476; Mon, 03 Jun 2024
 18:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240227012405.71650-1-alvinga@andestech.com>
 <SEYPR03MB6700853CCA2198D3E7DA7E7DA8202@SEYPR03MB6700.apcprd03.prod.outlook.com>
In-Reply-To: <SEYPR03MB6700853CCA2198D3E7DA7E7DA8202@SEYPR03MB6700.apcprd03.prod.outlook.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 4 Jun 2024 11:58:16 +1000
Message-ID: <CAKmqyKPT35UqF3xFqKbGgOx7ba_nDBVWjg20czMeJYfsJY8zvw@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] RISC-V: Modularize common match conditions for
 trigger
To: =?UTF-8?B?QWx2aW4gQ2hlLUNoaWEgQ2hhbmco5by15ZOy5ZiJKQ==?=
 <alvinga@andestech.com>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "alistair.francis@wdc.com" <alistair.francis@wdc.com>, 
 "bin.meng@windriver.com" <bin.meng@windriver.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, 
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, 
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Mar 7, 2024 at 12:36=E2=80=AFPM Alvin Che-Chia Chang(=E5=BC=B5=E5=
=93=B2=E5=98=89)
<alvinga@andestech.com> wrote:
>
> Hi Alistair,
>
> Please also take a look at this series, I guess it is ready to be applied=
, thanks!

This is all acked now, do you mind rebasing on
https://github.com/alistair23/qemu/tree/riscv-to-apply.next and
sending a new version

Alistair

>
>
> BRs,
> Alvin
>
> > -----Original Message-----
> > From: Alvin Che-Chia Chang(=E5=BC=B5=E5=93=B2=E5=98=89) <alvinga@andest=
ech.com>
> > Sent: Tuesday, February 27, 2024 9:24 AM
> > To: qemu-riscv@nongnu.org; qemu-devel@nongnu.org
> > Cc: alistair.francis@wdc.com; bin.meng@windriver.com;
> > liwei1518@gmail.com; dbarboza@ventanamicro.com;
> > zhiwei_liu@linux.alibaba.com; Alvin Che-Chia Chang(=E5=BC=B5=E5=93=B2=
=E5=98=89)
> > <alvinga@andestech.com>
> > Subject: [PATCH v4 0/4] RISC-V: Modularize common match conditions for
> > trigger
> >
> > According to RISC-V Debug specification ratified version 0.13 [1] (also=
 applied
> > to version 1.0 [2] but it has not been ratified yet), the enabled privi=
lege levels
> > of the trigger is common match conditions for all the types of the trig=
ger.
> >
> > This series modularize the code for checking the privilege levels of ty=
pe 2/3/6
> > triggers by implementing functions trigger_common_match() and
> > trigger_priv_match().
> >
> > Additional match conditions, such as CSR tcontrol and textra, can be fu=
rther
> > implemented into trigger_common_match() in the future.
> >
> > [1]: https://github.com/riscv/riscv-debug-spec/releases/tag/task_group_=
vote
> > [2]: https://github.com/riscv/riscv-debug-spec/releases/tag/1.0.0-rc1-a=
sciidoc
> >
> > Changes from v3:
> > - Change this series to target Debug Spec. version 0.13
> >
> > Changes from v2:
> > - Explicitly mention the targeting version of RISC-V Debug Spec.
> >
> > Changes from v1:
> > - Fix typo
> > - Add commit description for changing behavior of looping the triggers
> >   when we check type 2 triggers.
> >
> > Alvin Chang (4):
> >   target/riscv: Add functions for common matching conditions of trigger
> >   target/riscv: Apply modularized matching conditions for breakpoint
> >   target/riscv: Apply modularized matching conditions for watchpoint
> >   target/riscv: Apply modularized matching conditions for icount trigge=
r
> >
> >  target/riscv/debug.c | 124 +++++++++++++++++++++++++++++--------------
> >  1 file changed, 83 insertions(+), 41 deletions(-)
> >
> > --
> > 2.34.1
>
> CONFIDENTIALITY NOTICE:
>
> This e-mail (and its attachments) may contain confidential and legally pr=
ivileged information or information protected from disclosure. If you are n=
ot the intended recipient, you are hereby notified that any disclosure, cop=
ying, distribution, or use of the information contained herein is strictly =
prohibited. In this case, please immediately notify the sender by return e-=
mail, delete the message (and any accompanying documents) and destroy all p=
rinted hard copies. Thank you for your cooperation.
>
> Copyright ANDES TECHNOLOGY CORPORATION - All Rights Reserved.

