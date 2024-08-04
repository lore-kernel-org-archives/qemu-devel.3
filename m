Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3185C3DA7F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 23:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sakym-0007Z0-DO; Sun, 04 Aug 2024 19:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sakyj-0007YQ-UC
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 19:49:33 -0400
Received: from mail-vs1-xe34.google.com ([2607:f8b0:4864:20::e34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sakyi-0001U0-0V
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 19:49:33 -0400
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-492a8333cb1so2661095137.3
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 16:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722815370; x=1723420170; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GGTCmR7kkClvZIZs6lrtScNEmD/YUImi8xWUQhBZMlY=;
 b=fE0m6/2porgs+yHvsRHPViJUq8TwQ0dihKvSBt+fxILXSsTVrplOrehuJ2Wo+PKpVR
 IqBsZJfFlqeTK3agS9ROWd572hyd6MhRNi6ihtZfmqcTejjPDTanY1hIkJRoUNAcoToq
 cCibkyS0ECiaNqmSYEPPW+jRvcPErWAeaueuvADm47qxcVpZDpvi70xt2+e/zwyYCwbc
 7+ShpAePdPsx2BDbcCbsmnaj2Ubu6xAsklJE/NP9+6QkP9E2zcZXA6GtzlK4AgDVG2Dz
 CJb/PCFg1CBXJwnhmiY9oG9C5uIl73Fc5i1GRgU8PrAtawE/SElFW096+9k3CwRbh5R/
 FCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722815370; x=1723420170;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GGTCmR7kkClvZIZs6lrtScNEmD/YUImi8xWUQhBZMlY=;
 b=qQBbwjLz8KvBA+avG12vP7+TY/YKzWBuAJ36F5ETZO+kW2gBkpEBXttS1EGhhnaaEV
 z8t8Eo7drpox9L23v2h4aKm6rctQmUaedOqSfTJ2wh2wTBAiEPm5d9e/7dzuecMirwwa
 ct5qCeJlTfJ6r5zz1wR5DePk0rxCJJ9klL2t0Pi755jm2eGGJZDTdC4ROy6SaeoGAJ64
 088jBwpKg8owfSV5XMDPMet3SCRprUfc+ZUBGAW9DQWmA2glXd7DlAnFOjpLeh4cS6h7
 l2dlkhrs0GhrKJHN+han+Px7f3LTSl1E5NKYeCYK9Qjb4jOklr81PEaTpJYLff2JWwQI
 zKqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUg4Gl2KBDXoYuSP1akQOFzM0t2JWkcSfpFDqfoF8RhhFKUqFuBSAgyl+2b+XbOhqg2tIDdqlQ/8zAuy+oEGphIWdW2OpE=
X-Gm-Message-State: AOJu0YzTaDCH1kKISx0JwdCvUYQXV6pFWE/vLEvwSqZYi3uyC3nivU97
 PN9QO/nCw3OehjFKjg6b2Qhvqk9Luxp2G1Tp9xhU5oz1UVP4w0FPBBVkXDTfjugdMYL0YDSpdPe
 u0UxMDh+8KnYQZqpeRrcFQZex0g0nxqeU9Bc=
X-Google-Smtp-Source: AGHT+IGAkzCGWiOLvW6dnPHQeM+ZNvmX5rxR6NUrdmNsUWRmMKM2vZcB96q3dJAmq5ajnZxjpAQCqWmYN5IhvrKS7j4=
X-Received: by 2002:a05:6102:3ece:b0:493:badb:74ef with SMTP id
 ada2fe7eead31-4945bf0540dmr12357791137.26.1722815370570; Sun, 04 Aug 2024
 16:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240730123559.35115-1-n.novikov@syntacore.com>
In-Reply-To: <20240730123559.35115-1-n.novikov@syntacore.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 5 Aug 2024 09:49:03 +1000
Message-ID: <CAKmqyKNBSuBFWTwmojqnFGUeRh9c-6tkyGP=22dqBLA21ZrB1g@mail.gmail.com>
Subject: Re: [PATCH] hw/char/riscv_htif: Fix 64-bit var write order in 32-bit
 system
To: Nikita Novikov <n.novikov@syntacore.com>
Cc: lureau@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e34;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe34.google.com
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

On Wed, Jul 31, 2024 at 12:51=E2=80=AFAM Nikita Novikov <n.novikov@syntacor=
e.com> wrote:
>
> When we are trying to write 64-bit value in 32-bit system, the value in H=
TIF device divides
> on 2 separate 32-bit parts. So device expects write to xHOST_OFFSET1 firs=
t, then to xHOST_OFFSET2.
> But some compilers (ex. CLANG) can change the writing queue (xHOST_OFFSET=
2 first, xHOST_OFFSET1 second)
> because of machine instructions order swapping. That causes wrong behavio=
ur of HTIF device.

I don't follow, isn't this MMIO why is the compiler swapping the order?

> This patch is removing dependency of writing order, so the device will wo=
rk correctly regardless of compilers.

Urgh, the HTIF is undocumented, so there isn't really a way to know if
this is right or not.

It kind of seems like the QEMU implementation is the best
documentation at the moment [1], so I'm reluctant to make this change.

>
> Signed-off-by: Nikita Novikov <n.novikov@syntacore.com>
> ---
>  hw/char/riscv_htif.c         | 43 +++++++++++++++++++-----------------
>  include/hw/char/riscv_htif.h | 11 +++++++--
>  2 files changed, 32 insertions(+), 22 deletions(-)
>
> diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
> index 9bef60def1..d914f158ea 100644
> --- a/hw/char/riscv_htif.c
> +++ b/hw/char/riscv_htif.c
> @@ -233,7 +233,8 @@ static void htif_handle_tohost_write(HTIFState *s, ui=
nt64_t val_written)
>          if (cmd =3D=3D HTIF_CONSOLE_CMD_GETC) {
>              /* this should be a queue, but not yet implemented as such *=
/
>              s->pending_read =3D val_written;
> -            s->tohost =3D 0; /* clear to indicate we read */
> +            s->tohost =3D 0;
> +            s->tohost_status =3D 0x0;     /* clear to indicate we read *=
/

This seems like a separate change?

>              return;
>          } else if (cmd =3D=3D HTIF_CONSOLE_CMD_PUTC) {
>              uint8_t ch =3D (uint8_t)payload;
> @@ -258,7 +259,8 @@ static void htif_handle_tohost_write(HTIFState *s, ui=
nt64_t val_written)
>       *  }
>       */
>      s->fromhost =3D (val_written >> 48 << 48) | (resp << 16 >> 16);
> -    s->tohost =3D 0; /* clear to indicate we read */
> +    s->tohost =3D 0;
> +    s->tohost_status =3D 0x0; /* clear to indicate we read */
>  }
>
>  #define TOHOST_OFFSET1      (s->tohost_offset)
> @@ -291,32 +293,33 @@ static void htif_mm_write(void *opaque, hwaddr addr=
,
>  {
>      HTIFState *s =3D opaque;
>      if (addr =3D=3D TOHOST_OFFSET1) {
> -        if (s->tohost =3D=3D 0x0) {
> -            s->allow_tohost =3D 1;
> -            s->tohost =3D value & 0xFFFFFFFF;
> -        } else {
> -            s->allow_tohost =3D 0;
> -        }
> +        s->tohost =3D deposit64(s->tohost, 0, 32, value);
> +        s->tohost_status |=3D 0x1;
>      } else if (addr =3D=3D TOHOST_OFFSET2) {
> -        if (s->allow_tohost) {
> -            s->tohost |=3D value << 32;
> -            htif_handle_tohost_write(s, s->tohost);
> -        }
> +        s->tohost =3D deposit64(s->tohost, 32, 32, value);
> +        s->tohost_status |=3D 0x2;

Won't this break existing users?

>      } else if (addr =3D=3D FROMHOST_OFFSET1) {
> -        s->fromhost_inprogress =3D 1;
> -        s->fromhost =3D value & 0xFFFFFFFF;
> +        s->fromhost =3D deposit64(s->fromhost, 0, 32, value);
> +        s->fromhost_status |=3D 0x1;
>      } else if (addr =3D=3D FROMHOST_OFFSET2) {
> -        s->fromhost |=3D value << 32;
> -        s->fromhost_inprogress =3D 0;
> +        s->fromhost =3D deposit64(s->fromhost, 32, 32, value);
> +        s->fromhost_status |=3D 0x2;
>      } else {
> -        qemu_log("Invalid htif write: address %016" PRIx64 "\n",
> -            (uint64_t)addr);
> +        qemu_log("Invalid htif write: address %016" HWADDR_PRIu "\n", ad=
dr);
> +    }
> +    if (s->tohost_status =3D=3D 0x3) {
> +        htif_handle_tohost_write(s, s->tohost);
> +        s->tohost_status =3D 0x0;
>      }
>  }

1: https://github.com/riscv-software-src/opensbi/issues/238

Alistair

>
>  static const MemoryRegionOps htif_mm_ops =3D {
>      .read =3D htif_mm_read,
>      .write =3D htif_mm_write,
> +    .valid.min_access_size =3D 4,
> +    .valid.max_access_size =3D 8,
> +    .impl.min_access_size =3D 4,
> +    .impl.max_access_size =3D 4
>  };
>
>  HTIFState *htif_mm_init(MemoryRegion *address_space, Chardev *chr,
> @@ -343,8 +346,8 @@ HTIFState *htif_mm_init(MemoryRegion *address_space, =
Chardev *chr,
>      s->tohost_offset =3D tohost_offset;
>      s->fromhost_offset =3D fromhost_offset;
>      s->pending_read =3D 0;
> -    s->allow_tohost =3D 0;
> -    s->fromhost_inprogress =3D 0;
> +    s->tohost_status =3D 0;
> +    s->fromhost_status =3D 0;
>      qemu_chr_fe_init(&s->chr, chr, &error_abort);
>      qemu_chr_fe_set_handlers(&s->chr, htif_can_recv, htif_recv, htif_eve=
nt,
>          htif_be_change, s, NULL, true);
> diff --git a/include/hw/char/riscv_htif.h b/include/hw/char/riscv_htif.h
> index df493fdf6b..2b6d50dc60 100644
> --- a/include/hw/char/riscv_htif.h
> +++ b/include/hw/char/riscv_htif.h
> @@ -27,8 +27,15 @@
>  #define TYPE_HTIF_UART "riscv.htif.uart"
>
>  typedef struct HTIFState {
> -    int allow_tohost;
> -    int fromhost_inprogress;
> +    /*
> +     * Vars below can be in 4 states:
> +     * 0x0 - nothing written
> +     * 0x1 - xHOST_OFFEST1 written
> +     * 0x2 - xHOST_OFFSET2 written
> +     * 0x3 - Both written
> +     */
> +    int tohost_status;
> +    int fromhost_status;
>
>      uint64_t tohost;
>      uint64_t fromhost;
> --
> 2.34.1
>
>

