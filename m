Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321A9C19F32
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 00:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpzKY-00029I-9a; Wed, 05 Mar 2025 19:43:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpzKS-00028Q-0D; Wed, 05 Mar 2025 19:43:13 -0500
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpzKM-0001uV-1z; Wed, 05 Mar 2025 19:43:09 -0500
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-5236d34a37fso40119e0c.3; 
 Wed, 05 Mar 2025 16:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741221784; x=1741826584; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RoHudwowyeHQI/sVge4Yz/or3zZHSKFuniJ8Gp3LYyw=;
 b=GLzwF8JSV8uf9Gg2Zpw2i/c/R9zUoDQW6IlZpEmGKf/0Ag7ILiLCPYBpPODrXr7gUQ
 2IMrhDzgK/xJF+f5XnCUw5xSvd0pSn9fJRAd0NZ3zfaMHVJ5vvTqoXklGW3JgJGr1J5b
 CExVRsHYH87aggjlooWfuQAOfyCWjFS4ApAgfuu8itDak+vNENlvXC30HnQaRVcJG41+
 1M/qZduswfdFQmdRctjLjuT9B31JIQzPy3Kbii3gteEtsCm0A/HuTPzDjYnlVzmrhAcX
 UGUcx0qBJIhuXp2YT8Qk/9GCL6DVKE4zQ1SjIZP2ztapC8Lz25SGRUDZCEceIfFUqnTv
 KMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741221784; x=1741826584;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RoHudwowyeHQI/sVge4Yz/or3zZHSKFuniJ8Gp3LYyw=;
 b=jm8VkJaJE9zsl6dKBwZk+zbjpHek6t9/ryRG4/ji+CIzjZcmzEc39LCJVtkRMKGc/r
 uEWMN52vXx4HFxTw/f4zsBcijc/Ak9dRnwHOOqPrXiCeGTYWRRLY/lp0jDZNFaIKhXH1
 5cqATjVD3XfGZ6hTMu6dbbPsYZaBkPRcWZ+VSAg2+5PE9XIboCe2miFc+lmprY1Irk4w
 yQPolnsKo42fK7azKF2V8TZXM5tX+IuqcsbM9jn/gfWycWUCvpIb10in39dFa/x6dM9G
 dJs2twocqorDvTuHW1SaSLkXpstxb8nd7PrUaIghK/1L35oVImPKGQQjtWTLwF3E8E8w
 +DQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVknWFbn1VMXeM6sa8cYytZztM0EluC5jWkW08iV7KNlW27XEAfitXlV8YOzCm/8++hPBlobQFn7w6FVzk=@nongnu.org
X-Gm-Message-State: AOJu0YwrgXdc/ONCdcRVnzg3joiPlisPTOZsCUQv2pPHoWrjPKSUAZjX
 lVq8kbjKtjnHwVL8F6AvgdU9afoWhU7n+TgvWJ+nN9XK8ATmicQybt70GkLnb0FR5YgyQhaE0//
 pxBhdBsLqs/ePcMk7quIzl+qB25A=
X-Gm-Gg: ASbGncsLxbqFU24Azx7H34a0r/Tm/UxYxVZ06XH8PZElS3DCgoKZlYb/TtxMTlEPfCU
 J5Em/wxei2OeUYDQ2oaHZR6lIyZ2aqdpG+ELy16Jqh/2memuNdpBRHoFkJdwot8LBkh79t+3p1Z
 zeXv4ENkt3zhRIZtg/X0/j12bVbe360fFo+zRRBv2VhaFLqXKgU3ncMsQx
X-Google-Smtp-Source: AGHT+IGJlFw3HQXnuMZxKltSm836f8PpQ/8tyYNVsfw454QIBJMHONmSXkM5y9eJwTpyF3VADFN6QAFZXE5hJghiyuA=
X-Received: by 2002:a05:6102:4a81:b0:4bb:d394:46f4 with SMTP id
 ada2fe7eead31-4c2e2744b13mr3824778137.3.1741221784405; Wed, 05 Mar 2025
 16:43:04 -0800 (PST)
MIME-Version: 1.0
References: <20250305102632.91376-1-santimonserr@gmail.com>
In-Reply-To: <20250305102632.91376-1-santimonserr@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Mar 2025 10:42:38 +1000
X-Gm-Features: AQ5f1JorVzbYnRWw3ZoKFfFlvLANvWR1ezYpVRcRDu2U28eOQmscUW1d8XSG6NE
Message-ID: <CAKmqyKOQq0L0Wc3X3jTw31P4XSVucti2qL8fWH-XH3r96wCtuA@mail.gmail.com>
Subject: Re: [PATCH] docs/about/emulation: Fix broken link
To: Santiago Monserrat Campanello <santimonserr@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, laurent@vivier.eu, 
 mjt@tls.msk.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa31.google.com
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

Thanks!

Applied to riscv-to-apply.next

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

