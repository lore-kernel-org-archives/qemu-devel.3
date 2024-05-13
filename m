Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E5CC25B5F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 02:58:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Lt9-0002LN-7M; Sun, 12 May 2024 22:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6Lt6-0002KP-RY; Sun, 12 May 2024 22:58:04 -0400
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6Lt5-0006zf-9h; Sun, 12 May 2024 22:58:04 -0400
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-4df36a7a6f3so1458993e0c.0; 
 Sun, 12 May 2024 19:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715569081; x=1716173881; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LZ7ba1DGDxR5WoyIdaA7skRpAqKyJ2BY1my8U5HygUg=;
 b=AOFPzrxFzjkppratTzQ3a6qI56Uz4zjT2atpajB5mqCROf75taaQivz9dceUFLX8YD
 48p/4njCLzx+wpRgSwcZSyfae4XaXMJRaOoOBW9DmZtr/i7sND6RbZ68JQmOlXvXiaEj
 Sf9DVEWoqhnp6fFTAVqYJxMB3BZDyX6CbdgNWTps27VottIlnonus6xSX3NRfe8RtBjk
 9Mv4hAC5NA/P7g9AgpOvSqMFGjTIpftARpc42iGLY9Y8SucYs7XrQ7uL8qXxAKoNBLWP
 UNmjcp8xhxkdVFuJ0hNjak9sxhW73PUpSTspyBPiAvgQlq6gsg0LAxshnVcbBCKEmKcy
 wI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715569081; x=1716173881;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LZ7ba1DGDxR5WoyIdaA7skRpAqKyJ2BY1my8U5HygUg=;
 b=YWdEndiPrGOr6j6Pc+NABY4qcJc0Ft3Eo+8H6CJti2jIfD2dLNg+bdPb3EpUxWVXE4
 r30LEeoMP0q8HApQoAAsLI5R9UKYF1aSZC4MkS8ChMIU/UymciJObfCN6CB6VLNDLXmn
 ztavYBV68BH3od2aiCg74wtg4S5iEW2e2sgSCJN+VLbJZt9gTdEd5YcjwYZzhF/gYazN
 KSY7AYFFJT5zJwAp+q5+lFfPEPlQvY9X/yDdjfrC+AZts1ur5k39w7sULWM8kes+CkU8
 E6ZFBv3CAvz/ARL5LG6vUIbghmSpBKp4YYBIfZ+KRUVWUTLPaErOHTmKpSOj7XUciqkk
 W1lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOJTCIyQNvK4W0WdqNTqPHozRkgo0GAwq3MVsipu+Mi8zY7j14yVtLXQ3vGF9LLkX/wtiulZn12qgcc23hy8FUx5h3MZI=
X-Gm-Message-State: AOJu0YzzreKIw/xpnW41z1QnC/9bFutuB08JU+FWUCia/eeEEbFKkHPg
 QjR+dIEMkxImh94CKj55CgpSKJj2kJ4Y6S6jNBPyHcdytcxftKxKWqET/fgfocGuYOV27QV2kSA
 n5rOsIE98+pu6FW7aGw+8MjNOKgw=
X-Google-Smtp-Source: AGHT+IGx3mOtFP2/aMkmcunHJ+XCgF3HUtuh3aE+csfyWlkQYEXiUCUds3w5FVwxuz5DAw0195Glh4w/l8nz0Avfy2E=
X-Received: by 2002:a05:6122:4699:b0:4da:e199:4411 with SMTP id
 71dfb90a1353d-4df790f5f50mr10161460e0c.7.1715569081384; Sun, 12 May 2024
 19:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_7E34EEF0F90B9A68BF38BEE09EC6D4877C0A@qq.com>
In-Reply-To: <tencent_7E34EEF0F90B9A68BF38BEE09EC6D4877C0A@qq.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 May 2024 12:57:35 +1000
Message-ID: <CAKmqyKOYDQXXVRbSqMZbzS6+YVxQvaktw3eRVj_eJawqynzTqQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] target/riscv/cpu.c: fix Zvkb extension config
To: Yangyu Chen <cyy@cyyself.name>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a35;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa35.google.com
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

On Sat, May 11, 2024 at 9:28=E2=80=AFPM Yangyu Chen <cyy@cyyself.name> wrot=
e:
>
> This code has a typo that writes zvkb to zvkg, causing users can't
> enable zvkb through the config. This patch gets this fixed.
>
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> Fixes: ea61ef7097d0 ("target/riscv: Move vector crypto extensions to risc=
v_cpu_extensions")
> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index eb1a2e7d6d..13cd34adbd 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1535,7 +1535,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[]=
 =3D {
>      /* Vector cryptography extensions */
>      MULTI_EXT_CFG_BOOL("zvbb", ext_zvbb, false),
>      MULTI_EXT_CFG_BOOL("zvbc", ext_zvbc, false),
> -    MULTI_EXT_CFG_BOOL("zvkb", ext_zvkg, false),
> +    MULTI_EXT_CFG_BOOL("zvkb", ext_zvkb, false),
>      MULTI_EXT_CFG_BOOL("zvkg", ext_zvkg, false),
>      MULTI_EXT_CFG_BOOL("zvkned", ext_zvkned, false),
>      MULTI_EXT_CFG_BOOL("zvknha", ext_zvknha, false),
> --
> 2.43.0
>
>

