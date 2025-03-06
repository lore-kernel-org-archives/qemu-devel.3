Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD24DC282EC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 00:38:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpzFW-0000v2-NU; Wed, 05 Mar 2025 19:38:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpzFQ-0000ug-0Y; Wed, 05 Mar 2025 19:38:01 -0500
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpzFO-0001Iv-EM; Wed, 05 Mar 2025 19:37:59 -0500
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-8670fd79990so18436241.3; 
 Wed, 05 Mar 2025 16:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741221476; x=1741826276; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Svd9OLzX1Sn3/+gUIk3LrI+gQyj4CDufe4yMBqv8cdo=;
 b=G4CzwPncwRWc71mZwFfbN/cKmAVmBGlUrYgncwOIPgvez4tglQAUOVh5LG0EhTfDTI
 +vHa+eu45aBN+hCuU/MRjCE+71DHdTM4zdlbE1TFpcKN+s4EJosneqCnHuKYPl2Z3M9A
 i9wuHuhhcDVnjjlBjYz8fEkhta68wDtuJzot9c1OgyMINp57Pk9OBwPBa9/Twqyzeb9F
 zpHe603ok18DaPhwNHArW4opbOzRn2MKriKnux/9+VcsYR5dUyCAcxSqusxPY0O0ViGv
 omZLmNF9otuGcwyq9juOAkcOa3rGGxZWH0BxmhVBMKqqER5WZXiPO3BT9bscSs9WJkHt
 5U/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741221476; x=1741826276;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Svd9OLzX1Sn3/+gUIk3LrI+gQyj4CDufe4yMBqv8cdo=;
 b=JpKgyHm1RyGflsbwtJNHTu7zRsY4ZUqK17hbBrE62FnF0NgesdNBb6nQsQInp1UZnD
 tURETNoqVylnCfvr09ELl3IxF1Z31z60/hPmVARa3eURskuRyhy8phjjgr94kgh/S2Fk
 cn7nlDE1xbDhjoHJIoDrD/8o9ry3YYm3g4XpumjJ4pTUBkun+TX+snC6u9f5LnWg+e1d
 cnxmMkOt8MyW97HyCIOs85Vkxf2uxP6Zlo8d/K7tJy6rQ4b8Sfi9LYFGKqT/uerGxo70
 1r01B24+hY/e2YEtiuhtIDPzvRMF03LInzng8/IQmfBjd5yzSolMCjVpypePzl8YBg1M
 Mjkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWF09HG3abzeipEkPaHoMaGunQYsZxMl6eHoKafZYqmxragrOP1F2+2pDx2qDAkHooxjgf4XkvH8XjDSrI=@nongnu.org
X-Gm-Message-State: AOJu0Yy0zuIu63cooCAFyhql9CFWBR/cnDLOhFswS6lf2V2s/uojlecK
 ZvVwoXAPKLDHaBZmkh+dumsWZistJ1TGBYV2YV3PPTmDUSLhYp5C186I9yYUbNs0mfx0NDQb0Pl
 qpekGK7ZEekVjS+g4uAsdlpIMtIs=
X-Gm-Gg: ASbGncsnhy9F21VqOSxoMf1bMm5j1Rilptt7JDbnMf2sdLGBdYlz/9fyfv7dYnYbbrl
 5IV0P3QwUHAfXdOhoZ6eBh07sA+sQsyeH8KqNqaZEa1iFVB1OZcqHlJl8V1GICcDj0n91vQFogx
 ZxTEQhFkw8bfZlu2fTg7HPMToyhOMoSoJD5JI4PxLSBxmif4n+brPM8/no
X-Google-Smtp-Source: AGHT+IEFaMYZybJRhlJjukL6l6+SHRRuQqSvYcoWYXs4dodZlJu2b3j3SP+njb3rswmEO5hi5olJqC28wUP+D9KULG0=
X-Received: by 2002:a05:6102:2ad1:b0:4c1:8e95:24f3 with SMTP id
 ada2fe7eead31-4c2e2937761mr3916088137.24.1741221476174; Wed, 05 Mar 2025
 16:37:56 -0800 (PST)
MIME-Version: 1.0
References: <20250305102632.91376-1-santimonserr@gmail.com>
In-Reply-To: <20250305102632.91376-1-santimonserr@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Mar 2025 10:37:30 +1000
X-Gm-Features: AQ5f1JrS-atBK_GfeWxePzbMmUg4w9MC6eYvLhuJTOP9Gf6ie_oZRoKd52EY7xc
Message-ID: <CAKmqyKPck+4pXF7YMEuqJ=JoDBDyJ+ZmwhK_O4csgdsBqujYCQ@mail.gmail.com>
Subject: Re: [PATCH] docs/about/emulation: Fix broken link
To: Santiago Monserrat Campanello <santimonserr@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, laurent@vivier.eu, 
 mjt@tls.msk.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::934;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x934.google.com
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

On Wed, Mar 5, 2025 at 8:27=E2=80=AFPM Santiago Monserrat Campanello
<santimonserr@gmail.com> wrote:
>
> semihosting link to risc-v changed
>
> Signed-off-by: Santiago Monserrat Campanello <santimonserr@gmail.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2717

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> the original one linked it's still accesible on
> https://github.com/riscv-non-isa/riscv-semihosting/blob/0.2/riscv-semihos=
ting-spec.adoc
> ---
>  docs/about/emulation.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
> index 3bc3579434..a72591ee4d 100644
> --- a/docs/about/emulation.rst
> +++ b/docs/about/emulation.rst
> @@ -171,7 +171,7 @@ for that architecture.
>      - Unified Hosting Interface (MD01069)
>    * - RISC-V
>      - System and User-mode
> -    - https://github.com/riscv/riscv-semihosting-spec/blob/main/riscv-se=
mihosting-spec.adoc
> +    - https://github.com/riscv-non-isa/riscv-semihosting/blob/main/riscv=
-semihosting.adoc
>    * - Xtensa
>      - System
>      - Tensilica ISS SIMCALL
> --
> 2.43.0
>
>

