Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A430C3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 02:41:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWRvo-00060N-FM; Tue, 23 Jul 2024 22:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sWRvl-0005uV-V4; Tue, 23 Jul 2024 22:40:42 -0400
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sWRvk-0005cQ-F9; Tue, 23 Jul 2024 22:40:41 -0400
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-4e1c721c040so2013751e0c.3; 
 Tue, 23 Jul 2024 19:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721788836; x=1722393636; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B5KTnrMAGB3rDMjIul2jMjaJ1uqO0Z/YlMwc8yvIK+U=;
 b=NkxiTZMX0a679Flo0YdhynNlqMcnYmvdeHqLwZwEXBxE+neoAXjpNQheZDsyeJDZIF
 0NwiIStvWFahGOAd6E0S3PRsLJ8cRTMDvFENTeNedvecYtd40FcM67yd7VfuJXfbNOO7
 rVi7W/sPthJAD/R4Bbt+LpZctB0hQf/46CUeJikTzdZherIhZZ8yMemTiOqERMZw2A03
 uZAgQuC7/URpN7TyP+AadKnKEZWDNcJs5bU9Y2CmiJa7J3xyNuwRWPvUASxZ5GsQ56Rb
 Gl1vOc8xEWkeVRxdvw/Po+7jqsPHZ1I19fCHZPfNpg5+I8nS1UcI7ihHd/lhGaSIVGWQ
 GGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721788836; x=1722393636;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B5KTnrMAGB3rDMjIul2jMjaJ1uqO0Z/YlMwc8yvIK+U=;
 b=g6Zwmo8N4MNpNiD00kmOUTjQULNS/JJUYGEgovbkcW8Hgc1Yr2e7ktTyTm3o3oXFER
 9zxBF9yJZaOY7YbJhwD37IkabBYEq9Z10zW7qBJWlxGAslgAfCTi3igPEYyMVm7Ocq/w
 Gd6++sbFGjTrruEWiaPwB+mnodhKQazhQZFzLiEv3QiRR3uo7MWmwmZCSH+zsq9irkJV
 szzGAR+8XsrgmL8DYr94JeaLzNZx6x5VSmngQ01YEHMRF+zgQrbGfsOGhAqDZ4Bj8aBd
 p8WJ8D+mv3P1pAdwiOckjvtBwz6ZEezetQL8Vu+T9KJAcVDLa34056R9IXKem9w7WG1C
 VHqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfWZp/3/ih1mBhlCZKRFK+RdzDNlHTAFeQTc9OgVwDmHZIzJL5Cmemo0gVOVNLQJtMdC3X1SN2OQVcugpw9upHsbMs3d8=
X-Gm-Message-State: AOJu0Ywfcez6qjMhnDFIJJqp9NMyGE1oVVBFs1yNPMF1QutFuSiAjFbc
 xlsJORQF3ej57GTNDsGnFgApVICB1oKAZcC31fGOOj580zd7tyMkmXGuZElhskfrTed8t7YVcPg
 vID7dXfzn7Wwp32fj7mcwxCefUZE=
X-Google-Smtp-Source: AGHT+IETC/V93rL2RjZbRrYANq0lXKSListyRkZGzcAlxwC4cT5r3r1x6T21dEPvzNcMVgBPp+jFlFZC+cDtE4HEHL8=
X-Received: by 2002:a05:6102:8084:b0:48f:4bba:778c with SMTP id
 ada2fe7eead31-493c198b65bmr2032774137.8.1721788836205; Tue, 23 Jul 2024
 19:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240721072422.1377506-1-alvinga@andestech.com>
In-Reply-To: <20240721072422.1377506-1-alvinga@andestech.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 24 Jul 2024 12:40:10 +1000
Message-ID: <CAKmqyKN2hnN+wQzx3bdcFjEpo1R_rW23mR9OiCE8goJJ198-xw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] RISC-V: Add preliminary textra trigger CSR
 functions
To: Alvin Chang <alvinga@andestech.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa29.google.com
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

On Sun, Jul 21, 2024 at 5:26=E2=80=AFPM Alvin Chang via <qemu-devel@nongnu.=
org> wrote:
>
> According to RISC-V Debug specification, the optional textra32 and textra=
64
> trigger CSRs can be used to configure additional matching conditions for =
the
> triggers.
>
> This series support to write MHVALUE and MHSELECT fields into textra32 an=
d
> textra64 trigger CSRs. Besides, the additional matching condition between
> textra.MHVALUE and mcontext CSR is also implemented.
>
> Changes from v2:
> - Remove redundant log
>
> Changes from v1:
> - Log that mhselect only supports 0 or 4 for now
> - Simplify writing of tdata3
>
> Alvin Chang (2):
>   target/riscv: Preliminary textra trigger CSR writting support
>   target/riscv: Add textra matching condition for the triggers

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/cpu_bits.h |  10 +++
>  target/riscv/debug.c    | 132 +++++++++++++++++++++++++++++++++++++---
>  target/riscv/debug.h    |   3 +
>  3 files changed, 138 insertions(+), 7 deletions(-)
>
> --
> 2.34.1
>
>

