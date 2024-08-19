Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 813B8C531DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 01:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfr3l-0006Bq-Sp; Sun, 18 Aug 2024 21:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sfr3k-00069P-BB; Sun, 18 Aug 2024 21:19:48 -0400
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sfr3i-0004fy-N1; Sun, 18 Aug 2024 21:19:48 -0400
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-4f51981b1beso1268609e0c.2; 
 Sun, 18 Aug 2024 18:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724030385; x=1724635185; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oUvlVOeAEry/s9UMgf+wh6xooEFlNwLz8N7xW8MIXlY=;
 b=FZ/qbW7rSLoOe2VUmURCnmuhpiyWWLsad8eeiR69bjuLsfKm9aFdVcDu7rSubr2uZa
 yQbaRzwU/T0JUMzgZ3rb5gWTcxF8T0W3aVJtpC1p3bvMcRS2O31WamtfY275TsLLID8w
 iSadJtz2fphhhN4NmSxWMI/fGMfDqV0J84YoKI2esDdf24Kdx2p+M42qyBkwe2Nf4Sbo
 zQaxYIIYvNQ7kkFe7K6oNTNlVXx7DiEWdOCdRr8ukvpijq64f8wtaZ2wuuvmgfevilOv
 AS8qTjU9vmRaJWz8l68M8BQ28CakXHcx07yBRK3ZbHb3yZchF6ULPpxyqVyZ2jbBDAEY
 QN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724030385; x=1724635185;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oUvlVOeAEry/s9UMgf+wh6xooEFlNwLz8N7xW8MIXlY=;
 b=KHuW5iIEm5zNaQ9c1zq0cUGsUTmws0o+F1TlDwwz3rCauAtt0ALVZEOW7aUgWWxdzR
 OM3gwTVjmzFRLm4KJ9gk6gzOYIf2SCWW7wrnfwiUCI5hQNQKZuw3ARR4bDCLwX2DVqKw
 aot4K+N32ciD634hrHFqjXa1PEGBRmOTJmvhDNHbrbXdoiUbsv3fN3S9W0k26gAw/njU
 xr6dCXVPWOmXVixRk1NtmQFfBzu46IDJDIEFglCPeZVzkHc7zaj2ntkVzk/FBMaOi36I
 /lxj/wi/zgSrADwpiTdyjWnh4V+We1pqjyMCoQfa88xGZkSRLi3IlZoR+71PCm8ub/4v
 u2bA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6u4YlPUkdEloE5j5ycmg7kFi7aw8RIx2CsaBw7FWxdzS5AMIO9IyyoeLMQtAumHjQqT843y4FvhQggDLLF2VO5GxAs8s=
X-Gm-Message-State: AOJu0YyJmymtNolySoDeHq7X0Laee8froJPtEUmvTnSaGha6tzZ4u67D
 HpNFy6NtV1BgeGig6nHq4MHhJLIDuU2cR8LiI+v8PnbbNbxXA6AheCbGIj1cEvMqzel6LOm35S1
 Gww/mAZs70YmJaqjg9L3Juyp5iCU=
X-Google-Smtp-Source: AGHT+IGVix57xLbtQ+y1xl0m9glAeLWQdaPMDNpHM4e9guP1XDV6Cm5dA20A+1SmzPRYw/gj3J1am9KELQj1SzYCZPg=
X-Received: by 2002:a05:6122:2a07:b0:4f6:a85d:38b3 with SMTP id
 71dfb90a1353d-4fc6ca10d25mr11961948e0c.13.1724030384934; Sun, 18 Aug 2024
 18:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240816160743.220374-4-ajones@ventanamicro.com>
 <20240816160743.220374-6-ajones@ventanamicro.com>
In-Reply-To: <20240816160743.220374-6-ajones@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 19 Aug 2024 11:19:18 +1000
Message-ID: <CAKmqyKOXS+Fmb1Jxzwh3fAkeKi5eXQZ+JKkc3H77XjKrrKXe-Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/riscv/virt: Introduce strict-dt
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bmeng.cn@gmail.com, dbarboza@ventanamicro.com, 
 Anup Patel <apatel@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa31.google.com
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

On Sat, Aug 17, 2024 at 2:08=E2=80=AFAM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> Older firmwares and OS kernels which use deprecated device tree
> properties or are missing support for new properties may not be
> tolerant of fully compliant device trees. When divergence to the
> bindings specifications is harmless for new firmwares and OS kernels
> which are compliant, then it's probably better to also continue
> supporting the old firmwares and OS kernels by generating
> non-compliant device trees. The '#msi-cells=3D<0>' property of the
> imsic is one such property. Generating that property doesn't provide
> anything necessary (no '#msi-cells' property or an '#msi-cells'
> property with a value of zero mean the same thing) but it does
> cause PCI devices to fail to find the MSI controller on Linux and,
> for that reason, riscv virt doesn't currently generate it despite
> that putting the DT out of compliance. For users that want a
> compliant DT and know their software supports it, introduce a machine
> property 'strict-dt' to do so. We also drop the one redundant
> property that uses a deprecated name when strict-dt is enabled.
>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  docs/system/riscv/virt.rst | 11 ++++++++++
>  hw/riscv/virt.c            | 43 ++++++++++++++++++++++++++++++--------
>  include/hw/riscv/virt.h    |  1 +
>  3 files changed, 46 insertions(+), 9 deletions(-)
>
> diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
> index 9a06f95a3444..f08d0a053051 100644
> --- a/docs/system/riscv/virt.rst
> +++ b/docs/system/riscv/virt.rst
> @@ -116,6 +116,17 @@ The following machine-specific options are supported=
:
>    having AIA IMSIC (i.e. "aia=3Daplic-imsic" selected). When not specifi=
ed,
>    the default number of per-HART VS-level AIA IMSIC pages is 0.
>
> +- strict-dt=3D[on|off]

Hmm... I don't love the idea of having yet another command line option.

Does this really buy us a lot? Eventually we should deprecate the
invalid DT bindings anyway

Alistair

