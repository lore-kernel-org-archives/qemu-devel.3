Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65285C0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 00:22:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thHZ6-0005SG-98; Sun, 09 Feb 2025 19:22:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1thHZ4-0005Rp-41; Sun, 09 Feb 2025 19:22:18 -0500
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1thHZ0-0008Dn-8l; Sun, 09 Feb 2025 19:22:15 -0500
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-86712bc0508so552462241.2; 
 Sun, 09 Feb 2025 16:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739146931; x=1739751731; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mBElaxVntqJAi3XpxfBeAiLLX6H7NYr1dd0yqY68g20=;
 b=VZcNp7fK6/c/K8IH95fPRt986kDzIuTlOwfxIjNhabuSCngWG4/Mj4NCMdUZYtmEhf
 6btiFiJj20YV/KjMcGwsRkxFnaQLgZU8628PZLdQ+f/6t2gIGOa2d4wjCc0gsxFh5ISg
 3BqWCdyFh5GpNbPbG6BDv3m7u/KgJBvQldt09gUIUkDjPRLTbORHFF+uxuXf0+KTPzU/
 bscupOdgm6LnOdUlIjHpU+qdQ3t/bddNsKYv0Bsn0wFtSSZjLFeISsik9dA4+elM0D7U
 RdEi2/HaHHn8r6Htp5UBNezN9/UVVp53GlWQZT0gNZHrytEXT+hPSCRsxjcRh34y5hrg
 /6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739146931; x=1739751731;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mBElaxVntqJAi3XpxfBeAiLLX6H7NYr1dd0yqY68g20=;
 b=AVZcEvbt3euY+TE2xuGzHM1MNFs2iTVDBvw9o6hlr/XtxiASqGWgfde6gl+jGDMNEI
 n+Lc6Lz9e1INlvbTJvAWx3R5ju2P50N8v94J4tDlctIvJSzXMHpT9QnNjU8fzPTKEot+
 Z3vu27tvHdfTwBvjnIOrwVLS2ld/mPb7dV3OLO38/iKT2MKfxQW28cfWUh19B9T5xN5l
 JzQrdofQWc21McCYt0E6JvhkVVCj//Sqj48bUdv389F2Be0IWcXmrVvt58MNFuKSBgs4
 06x+dHlQW+lYTcbRkf40lXrOC1UBmnY9ym7M8PEwInYyBHAkjsXdrTzd8UPej2zVKtDO
 OhDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+bA5uRAWLfKceC7Mi/Inb8f1EGGwBmbz4FAauOkkN/rISO/CsXqYzbzFRC4cmYGm7b5Ljj+p7qGyF@nongnu.org
X-Gm-Message-State: AOJu0Yy8UIkAjLlS2aY6SFHdPc3zJgx8o3d5nxr6FZHUeuA1jccaXtCE
 rteN4c77rN7DkGC6ECxXHEud1Ab3bpAPpo+/YADQIEG8Kzp2aMqZPDhC1JAM8Z7W1Wpiq/gSY/c
 51a8mxQju0v0xwaKw2kkGS2BW26U=
X-Gm-Gg: ASbGncvo21b+h+sFBS7n9BBmT4RYe89eMHujSKddvayiRuJ0kc2s8MUI4ffa9fxlYcP
 X+j1Krq9WYxpN1hADXCDZD6S5d6sMPtMcptLHIy4Za33rNTfDIOAj+Y175tF8kNnQD35K++CgW3
 qqXc6QhWqr2qeoSLKRORvZj6n/2w==
X-Google-Smtp-Source: AGHT+IF6O5epnJPTJIpUQyRHfjqoUl/P0MK9B/qEAEbk09pCT9mBViGUaVfje3i0vTuJSB/gVsy85XRZLke9K/ZnR1w=
X-Received: by 2002:a05:6102:418b:b0:4bb:5d61:1252 with SMTP id
 ada2fe7eead31-4bb5d611970mr2965371137.23.1739146931203; Sun, 09 Feb 2025
 16:22:11 -0800 (PST)
MIME-Version: 1.0
References: <20250206181827.41557-1-philmd@linaro.org>
 <20250206181827.41557-4-philmd@linaro.org>
In-Reply-To: <20250206181827.41557-4-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 10 Feb 2025 10:21:45 +1000
X-Gm-Features: AWEUYZltez5mZGL1EOoR5Y_BhkiYfKVQo9jWoiaHEWaGyorOXSaSdYdL-1wP_jY
Message-ID: <CAKmqyKNGQ6-i62iczWOcXC0meA0hXJSCapc=oC3kUoz0xUX=8A@mail.gmail.com>
Subject: Re: [PATCH 3/7] hw/riscv/opentitan: Include missing
 'exec/address-spaces.h' header
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>, Sunil V L <sunilvl@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::929;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x929.google.com
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

On Fri, Feb 7, 2025 at 4:20=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> opentitan_machine_init() calls get_system_memory(),
> which is declared in "exec/address-spaces.h". Include
> it in order to avoid when refactoring unrelated headers:
>
>   hw/riscv/opentitan.c:83:29: error: call to undeclared function 'get_sys=
tem_memory'
>      83 |     MemoryRegion *sys_mem =3D get_system_memory();
>         |                             ^
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/opentitan.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
> index b9e56235d87..98a67fe52a8 100644
> --- a/hw/riscv/opentitan.c
> +++ b/hw/riscv/opentitan.c
> @@ -28,6 +28,7 @@
>  #include "hw/riscv/boot.h"
>  #include "qemu/units.h"
>  #include "system/system.h"
> +#include "exec/address-spaces.h"
>
>  /*
>   * This version of the OpenTitan machine currently supports
> --
> 2.47.1
>
>

