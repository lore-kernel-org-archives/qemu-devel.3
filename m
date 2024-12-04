Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37524E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 04:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIhEG-0005ri-Lu; Tue, 03 Dec 2024 23:43:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIhEA-0005qu-Kr; Tue, 03 Dec 2024 23:43:07 -0500
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIhE9-0003UH-4z; Tue, 03 Dec 2024 23:43:06 -0500
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-51532deb8a4so1621700e0c.0; 
 Tue, 03 Dec 2024 20:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733287374; x=1733892174; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fWETwWX5HED8osVL7iEPOTA8shavm+TigW5fgB2BzTo=;
 b=c9krm8WrSDr9hRbSPcGrvqCAuLl9yDPyvttOHlFBPJdo7ggS0wJgws5c9H0CdxrdMH
 S8Dpb2DZgid+qw9uUT0AzW9155eV0WNsfaPWzAtjUUx5LycPCCpuh/G/7Rak+cBW7LrZ
 8BqbI697TAdYzBi7QKhyKQ2g6WSbwTDwHWJ3/sc7/e7tTh1ehgYIkuU51kBlI+reIcQz
 INnUS/+QuC4am5HBv/WOwogd6x1fNe+sBmuUUZ2hJ/Wjh/Q6vcYEn33YWGVZ/YLDA0kJ
 PGZFBKrTYsacl6gwJymZsAlBa4q9eDQw7ioDtuGLFiwUYY+mgoSGkkyPpRVDrC+a2jl2
 mPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733287374; x=1733892174;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fWETwWX5HED8osVL7iEPOTA8shavm+TigW5fgB2BzTo=;
 b=eFzj/4ruIxPlWjUkyur7irYtdzZpFnETBIuIi6zaVKXJNHfp8JzmvyJq/MvgWXo3Ek
 +jTQViyoD+r7L06GvnKISdwvy1RX2nl6sJF7ZqSmussGBVSgtFZg07ER34lTlXtfEbyL
 OaueDT+Bs7l8HQkQ98Q5g0l64ias/LuBLIfqcI5FIDwR/iWOLGcHQWUL0LLJAMg0JmLD
 ArdDOpq+nT7zitXFOhFy+qBWd8D5R5C2iCgQVoNohstx4DyFEols+IGCplyS0dyXgRSN
 hRI2hFkzwJWrUe6WPNziwSIj/YpT+dONnsHIdaCjuGNATN8IadFbk0lF6mFWwesyC/v0
 +T7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW14opUbkoPbcneKvIbNbIIjhsTSGHVmgJYVGHTYOhRVT0ueTs1+v8IRzLzZDA8xELpgsGnZBLdsu49@nongnu.org
X-Gm-Message-State: AOJu0YxG7NRRGCuBn8Ur8BZocxQXXHTSG5SedlszH2AGtqG+n46jIwGJ
 Gsq0rh3qAzltSSKExIjkLURbWAxJBOaK5c1922DwbW+38ttmyZEBi60KSL6trZX4byjDg0A4a+3
 FnFK2OJYS6x4HOY7lYD+YEQOEi0M=
X-Gm-Gg: ASbGncvRyZMvwdEmNJ5utnJPpw54yEeKeR171LhtiBYAzQbpcBBCyzeTls3oaWYLMQK
 /CAYwS+UBnuH4d9UlfT74oF6F0A1Ot2az
X-Google-Smtp-Source: AGHT+IH/1GqvL7QHq5Kr5WCX8AoNKuxzSQPu/RlNWX+JMxV1LOjGlHFwPvVk2JWuVGt2mMn/pPpfiwQE5dmxC2JMmho=
X-Received: by 2002:a05:6122:da1:b0:515:5008:118c with SMTP id
 71dfb90a1353d-515bf50a748mr7372424e0c.6.1733287373751; Tue, 03 Dec 2024
 20:42:53 -0800 (PST)
MIME-Version: 1.0
References: <20241113171755.978109-1-dbarboza@ventanamicro.com>
In-Reply-To: <20241113171755.978109-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 4 Dec 2024 13:42:27 +0900
Message-ID: <CAKmqyKPnY89MFTY=R4kUydXoAGVYLnH8iX9v0-nF1Kjf21vGsQ@mail.gmail.com>
Subject: Re: [PATCH for-10.0 0/9] target/riscv: add 'sha' support
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a32;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa32.google.com
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

On Thu, Nov 14, 2024 at 2:19=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> 'sha' is defined in RVA22 as "augmented hypervisor extension" and
> consists of a set of named features that must be enabled.
>
> RVA23 makes 'sha' mandatory, so let's add official support for it in
> preparation to support RVA23 later.
>
> Most of the named features added here are always implemented by TCG.
> Only 'ssstateen' has a runtime dependency.
>
>
> Daniel Henrique Barboza (9):
>   target/riscv/tcg: hide warn for named feats when disabling via
>     priv_ver
>   target/riscv: add ssstateen
>   target/riscv: add shcounterenw
>   target/riscv: add shvstvala
>   target/riscv: add shtvala
>   target/riscv: add shvstvecd
>   target/riscv: add shvsatpa
>   target/riscv: add shgatpa
>   target/riscv/tcg: add sha

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/cpu.c         | 10 ++++++++++
>  target/riscv/cpu_cfg.h     |  2 ++
>  target/riscv/tcg/tcg-cpu.c | 30 ++++++++++++++++++++++++++----
>  3 files changed, 38 insertions(+), 4 deletions(-)
>
> --
> 2.47.0
>
>

