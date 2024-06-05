Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E6CFC25B78
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 00:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEeYG-0005ny-Or; Tue, 04 Jun 2024 20:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEeYF-0005mz-55; Tue, 04 Jun 2024 20:30:51 -0400
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEeYD-0004TS-DU; Tue, 04 Jun 2024 20:30:50 -0400
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-4df550a4d4fso1754653e0c.2; 
 Tue, 04 Jun 2024 17:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717547448; x=1718152248; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BiwHFTOvE1iqHuvHSWIj5J/OtL/38NSBC8iLxqtRO6Y=;
 b=DxHzWBhXoeB1N6XNqyZGZhT0T4fjxDlQg4lxJT4u7QMM661rGYxuwbxRXOJRexI7AX
 rpVo7PsjXt/6/i3EmBuuCM71HMtmoDB9F7e85jdDgOMWFSFQw8Us+yHo3pxw4AbUyAk9
 Q3av/xcrCnoacfEyEJIpiSuicTlC5vdI2cySyZtopYDoqCANa9J2k2wcmhtW8bY7xQLU
 fjfj1GtplOS2Xs4OClxW87KGtJqOzas2Iyhj82aIdLbqVnwwRzy4hqhtebY5mTimpMTQ
 DjyFLomkxQQwv7ZNSCV/4vAgU5Jdy2NwDW3nCkk5/Ae7Z6tQIgcIEaARXYqqAHbAjt5C
 3DKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717547448; x=1718152248;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BiwHFTOvE1iqHuvHSWIj5J/OtL/38NSBC8iLxqtRO6Y=;
 b=YuXy25k0tSIfyKCzkmZC0P86McSc1J3OkfQE8qAfvCYY4vlXPR3x7KhWFc5UyirKdJ
 XzomByyUxjrP5k76ex97IBMlDHo81t1odIb8UWnNY9dtaejD1rhvMpY5y/La1SqxScoR
 I9W2ey8rXO1kEAh3ZY3Xq3oZulpCAAmQDJcztR6CF8fSwZKghBZIrPzBLuilVi7o8mRa
 fNJDfoLgJWM4dH4Qwiq15yvbxJ1SIaaprdCFDESIyBPUBS85VwXy2dwPYXvDsDtORgry
 jt5I0zqIWttq7ISoZi+5uPcsTt+Ly7uG/FkoFUE/kiovdsZF5bYHGuqV0eovgO8HBAcM
 vO8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqybGe5JPG+9qV//nshC0HW8eZ8SCc5NrTyqPYEFCblYK7BkAe0ZWXoV5IJhmeaZdgzlS/HyelUVTpUKOOCWZiTORGYoQ=
X-Gm-Message-State: AOJu0Yy+6eKWXb0HiohfLqbIyZYzJIYXr7U7t2WBPcoN6p/HPgzfHvxd
 PWZbpoh7qkHIMiOeVIQl2JkigOycAS1jLgHlA80YyzY8aHHjR42MvDqCPuD8xUkIJnk2ouzQ/Ei
 ymJ46IsOorWI4LQ7BahxDxSMkSrQ=
X-Google-Smtp-Source: AGHT+IFAG4JJsrwMj8/UNJjvWlAVExAXqqzTsTGjOaVa1ZbbRjC1+rdCwy9MUJkWiVltPDtBut32xkcpAzgKzQqZXfc=
X-Received: by 2002:a05:6122:179b:b0:4ea:f128:7adb with SMTP id
 71dfb90a1353d-4eb3a4cb519mr1607354e0c.10.1717547447682; Tue, 04 Jun 2024
 17:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240531202759.911601-1-dbarboza@ventanamicro.com>
 <20240531202759.911601-4-dbarboza@ventanamicro.com>
In-Reply-To: <20240531202759.911601-4-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 5 Jun 2024 10:30:21 +1000
Message-ID: <CAKmqyKMRnuiEECQDmB3D+Ed0W-GjOY7NBX6MhEZFFiTxhu8M1w@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] hw/riscv/virt.c: rename aplic nodename to
 'interrupt-controller'
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, apatel@ventanamicro.com, ajones@ventanamicro.com, 
 conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a36;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa36.google.com
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

On Sat, Jun 1, 2024 at 6:30=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> The correct name of the aplic controller node, as per Linux kernel DT
> docs [1], is 'interrupt-controller@addr'.
>
> [1] Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.ya=
ml
>
> Reported-by: Conor Dooley <conor@kernel.org>
> Fixes: e6faee65855b ("hw/riscv: virt: Add optional AIA APLIC support to v=
irt machine")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 07a07f5ce1..5505047945 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -591,7 +591,7 @@ static void create_fdt_imsic(RISCVVirtState *s, const=
 MemMapEntry *memmap,
>  /* Caller must free string after use */
>  static char *fdt_get_aplic_nodename(unsigned long aplic_addr)
>  {
> -    return g_strdup_printf("/soc/aplic@%lx", aplic_addr);
> +    return g_strdup_printf("/soc/interrupt-controller@%lx", aplic_addr);
>  }
>
>  static void create_fdt_one_aplic(RISCVVirtState *s, int socket,
> --
> 2.45.1
>
>

