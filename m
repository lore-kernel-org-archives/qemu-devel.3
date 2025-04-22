Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4889C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 02:49:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u73h3-0000Jv-Vs; Mon, 21 Apr 2025 22:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u73gm-0000CS-GN; Mon, 21 Apr 2025 22:48:54 -0400
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u73gj-0000Zg-AC; Mon, 21 Apr 2025 22:48:46 -0400
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-5259331b31eso2029941e0c.0; 
 Mon, 21 Apr 2025 19:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745290123; x=1745894923; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8DecP5VoIJKYQG1Aebro80pfPsNAz8hbO54IgzeGN8Q=;
 b=bQjmYM958HQrC90jdiDIWxv7GUHz6U1zVN/OW7OmDjn48G9CB1F5RaS9URm6kYLP1r
 zUsK1YMIU5lQt0opRLr+9oVjFW5+15hj2gOGO/O1Ci5YtyC8u2au8CfyC77rd/rhjyK+
 4GNGeZMhTLdsBo487Q3da29PnIrQwdeQKkEhGrqFs2yUXIJs2UCyWtBsqoKK5R9Mlemc
 Ipc7b1aUOomltW+R4j3xZHn8eJ0Ic1SbzRABlPICPlprVYr2/cs5qt6DHZwUqz72Fz85
 GslWTGxwZWIAVoMK6GHj9aDnZJArvqh5lFa2EQZiLc3C2z6Hqtrn0DhFB+OpJJBC0ZES
 ygtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745290123; x=1745894923;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8DecP5VoIJKYQG1Aebro80pfPsNAz8hbO54IgzeGN8Q=;
 b=MKFAno16twC4d5mPNfqQt+PHcEXKfaIimWwY9j4QYnazAoghzohhd3D7KCgOJQ6BmC
 Iut3dynMdP7N/BsaKPn2Mupsi9+Bu01YeZ4Wb65Gy5LOeHMEpJY/0cc7FbmHmzCxQAbr
 oIa0gJohnqkCAbp3Olpw0uL2z6ccgHK/INYoCP//xGlNwfxzoFS5B0SZhYwR6aIGZ32q
 QWEsn3ygz4eOoCdY6W4F/ElKhyCjHc50p480Gs2J3hzsDENuW0pDg20NNRr1kKMPdkQu
 8VOuYCJi0HxPFspRbNhfvGMLk0ymGE00gOoTD+uf1a3ZzfuXuu1xOqbvjqauT/x/lYy3
 8Ijw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAh33v0ns0WfeA2O0vnY7eX1IspV7s/NWkibU0IUPwQZ+O/pBxRByWzlcu3Ys1OEJ9womLCzzaOOtDxQ==@nongnu.org,
 AJvYcCXVMZIOWg6ylSAnesJC47kR7BAucXWHh6qbEb2mCxd0ovAQwaHl9kfL+gqpXyKshoX8Wr+LP3kAVzDY@nongnu.org
X-Gm-Message-State: AOJu0YyTmO/qmM5mu0c/P8a9jyGFnzjGPzej31y6LfFAR0CCjXT5e9WO
 0QDyYrK7pFZ6DZH14zdNfK4zXsoPl9bA6FSqorBbOSiNG4SLjoX0py4vcdAghSkwKsTruIN+jbA
 bfuv/dwVo3yzGco/VyeDOcksDqk0=
X-Gm-Gg: ASbGnctDzg6h7ftOrzSV1DsTj/cTftavYRernyZchfoiyizEd6eTpYNCAFoKLEtZP2K
 iTD+NTju5+b5tb1xIH7wyBnzrQ3V7bUbAeaWhhKkVEHp/HoeENZWKPq0mjN2IoLD0KEHcgblV+s
 iNAV66OCKXWP2llreMOkRe6loyhwLT2P1kKhz87gYe92HGkzX0kVam
X-Google-Smtp-Source: AGHT+IHvuR+PSz4TsD8EAHWWTIT+KmALHYMJsNZymRCNbUHULZYslxT09FfV46BbEquzJORaf5CBmVlQv/QqzAJOyeg=
X-Received: by 2002:a05:6102:5617:b0:4af:c519:4e7f with SMTP id
 ada2fe7eead31-4cb801f61bamr8033685137.18.1745290123516; Mon, 21 Apr 2025
 19:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250417072206.364008-1-uwu@icenowy.me>
In-Reply-To: <20250417072206.364008-1-uwu@icenowy.me>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 22 Apr 2025 12:48:17 +1000
X-Gm-Features: ATxdqUHG4cq2MeU08EMxo4-4e4bOjd2M30GBb0ZJI_-KaYMAr9bsnpIHIjJMJzs
Message-ID: <CAKmqyKP8gSY7J0ArKjnKWzcv7UOUjZ57UApW+6EVRM+P_5gfKg@mail.gmail.com>
Subject: Re: [PATCH] common-user/host/riscv: use tail pseudoinstruction for
 calling tail
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Riku Voipio <riku.voipio@iki.fi>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
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

On Thu, Apr 17, 2025 at 5:24=E2=80=AFPM Icenowy Zheng <uwu@icenowy.me> wrot=
e:
>
> The j pseudoinstruction maps to a JAL instruction, which can only handle
> a jump to somewhere with a signed 20-bit destination. In case of static
> linking and LTO'ing this easily leads to "relocation truncated to fit"
> error.
>
> Switch to use tail pseudoinstruction, which is the standard way to
> tail-call a function in medium code model (emits AUIPC+JALR).
>
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> P.S.
> It seems that moving it to common-user/ makes the file out of the
> MAINTAINERS section of "RISC-V TCG CPUS". I Manually added the
> maintainers there, but the MAINTAINERS file seems to need a change on
> this.
>
>  common-user/host/riscv/safe-syscall.inc.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/common-user/host/riscv/safe-syscall.inc.S b/common-user/host=
/riscv/safe-syscall.inc.S
> index dfe83c300e..c8b81e33d0 100644
> --- a/common-user/host/riscv/safe-syscall.inc.S
> +++ b/common-user/host/riscv/safe-syscall.inc.S
> @@ -69,11 +69,11 @@ safe_syscall_end:
>
>          /* code path setting errno */
>  0:      neg     a0, a0
> -        j       safe_syscall_set_errno_tail
> +        tail    safe_syscall_set_errno_tail
>
>          /* code path when we didn't execute the syscall */
>  2:      li      a0, QEMU_ERESTARTSYS
> -        j       safe_syscall_set_errno_tail
> +        tail    safe_syscall_set_errno_tail
>
>          .cfi_endproc
>          .size   safe_syscall_base, .-safe_syscall_base
> --
> 2.49.0
>
>

