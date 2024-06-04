Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F18C25B75
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 01:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEJP0-0004e5-7X; Mon, 03 Jun 2024 21:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEJOz-0004dP-2N; Mon, 03 Jun 2024 21:55:53 -0400
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEJOx-0003Bs-A5; Mon, 03 Jun 2024 21:55:52 -0400
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-4e4efcc3d8fso191698e0c.0; 
 Mon, 03 Jun 2024 18:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717466149; x=1718070949; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AifoIVClhFyTY/kVE3LzqwChPaDbD1HWrb5HkCwMW5s=;
 b=UaHSzBjbI2hzPAsrxE9jds/QlWBYXHVqO5tFa0i3EcTAoTB5aq34tYDgf7ZMayjNr1
 QLNXtGv6Qim+Wp34Tbz2gAQi0+udqdSboy1MSizsHTKSxDN7UEZzACrjaRiuiiz60gkR
 DigQufZZkw1RLj7qQgbZPM9eqvqt7o6410XqxyIdcT6WmdeAXyztRfH2+xzQeDNuN7zw
 U4wutZjKgpQiPKJWOV4BzuF4vXckKK60TSRxrG1pgzApgZtQxcXBSy56kaCmfZIi028V
 UCYLAQKDd0na+nlDpJFm0Nm/cnDoueUGblnfrEzSqBtWRAkFm3SFdh83QPbhUCK6B80J
 iY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717466149; x=1718070949;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AifoIVClhFyTY/kVE3LzqwChPaDbD1HWrb5HkCwMW5s=;
 b=MM6FX3i+ZtXbmrhtStHNctSO+rYfahS6XTVHXTQfU8ZOvzYK2UqbIfedJ862oiUBd7
 4cn4KXp6kIS7N7hZY371aGR0YWzZcRMgQGfExPo+HVDTJPX3IAMpw0wzThaSu6crcbOO
 rB8qB44zt6oDtKubTVkpG/rYqZ7EYl2NAF/tNNEXQDuxMsi9CCZTlime5DOmVzS8bYBk
 YcfUqpl15rHBJLhSJkL1iJ+GTaa3OTmIeAWEGKhXrr3twHOBCFxGF9D395ap1fMwLizZ
 3nqb6GN9vctsKfBefBiovJcd7U3LkOUmk7gVh448sxqSZgRbskAE0TfPP1xPOS9REx7x
 jZHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUy5Wl5tBZiaDPQx+s4+eWdgd58mbgwIeqw3xjuop6cBbSY8hCxx+i5N3lD5500lB/IEnEdcsBlujElx/0/MqFlZhsSQY=
X-Gm-Message-State: AOJu0YwCi4OjuvRJuMXjuzrYqeZzYjz/dd0lw4RMY1kdT9hEf1UCyuYJ
 w3E9GznPpyqImKS+Ry7jD561JG1BICaW9MUlva15dno5VCU7gP8ymVoy9U4DeXUSS/qbdYf7fxV
 E9mG4D7nG0srCzLUwrjUtOqb2t9g=
X-Google-Smtp-Source: AGHT+IE+33EG7Jli7ObDU1ckZJohLri5dQVTBJXJepYYQl1kconkUAwR5KPvjASsPG9HlcfYNQ12W2EC0XRfO9bUgBE=
X-Received: by 2002:a1f:fc0b:0:b0:4d3:36b9:2c26 with SMTP id
 71dfb90a1353d-4eb02f45d3emr10348321e0c.14.1717466147858; Mon, 03 Jun 2024
 18:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240520125157.311503-1-rkanwal@rivosinc.com>
 <20240520125157.311503-2-rkanwal@rivosinc.com>
In-Reply-To: <20240520125157.311503-2-rkanwal@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 4 Jun 2024 11:55:21 +1000
Message-ID: <CAKmqyKPn95XCZPxVXqY+ZBC8o3Mip_jaC7k693DV4Z2QLMSe0A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] target/riscv: Extend virtual irq csrs masks to be
 64 bit wide.
To: Rajnesh Kanwal <rkanwal@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a35;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa35.google.com
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

On Mon, May 20, 2024 at 10:53=E2=80=AFPM Rajnesh Kanwal <rkanwal@rivosinc.c=
om> wrote:
>
> AIA extends the width of all IRQ CSRs to 64bit even
> in 32bit systems by adding missing half CSRs.
>
> This seems to be missed while adding support for
> virtual IRQs. The whole logic seems to be correct
> except the width of the masks.
>
> Fixes: 1697837ed9 ("target/riscv: Add M-mode virtual interrupt and IRQ fi=
ltering support.")
> Fixes: 40336d5b1d ("target/riscv: Add HS-mode virtual interrupt and IRQ f=
iltering support.")
>
> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 6b460ee0e8..152796ebc0 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -1200,18 +1200,18 @@ static const target_ulong sstatus_v1_10_mask =3D =
SSTATUS_SIE | SSTATUS_SPIE |
>   */
>
>  /* Bit STIP can be an alias of mip.STIP that's why it's writable in mvip=
. */
> -static const target_ulong mvip_writable_mask =3D MIP_SSIP | MIP_STIP | M=
IP_SEIP |
> +static const uint64_t mvip_writable_mask =3D MIP_SSIP | MIP_STIP | MIP_S=
EIP |
>                                      LOCAL_INTERRUPTS;
> -static const target_ulong mvien_writable_mask =3D MIP_SSIP | MIP_SEIP |
> +static const uint64_t mvien_writable_mask =3D MIP_SSIP | MIP_SEIP |
>                                      LOCAL_INTERRUPTS;
>
> -static const target_ulong sip_writable_mask =3D SIP_SSIP | LOCAL_INTERRU=
PTS;
> -static const target_ulong hip_writable_mask =3D MIP_VSSIP;
> -static const target_ulong hvip_writable_mask =3D MIP_VSSIP | MIP_VSTIP |
> +static const uint64_t sip_writable_mask =3D SIP_SSIP | LOCAL_INTERRUPTS;
> +static const uint64_t hip_writable_mask =3D MIP_VSSIP;
> +static const uint64_t hvip_writable_mask =3D MIP_VSSIP | MIP_VSTIP |
>                                      MIP_VSEIP | LOCAL_INTERRUPTS;
> -static const target_ulong hvien_writable_mask =3D LOCAL_INTERRUPTS;
> +static const uint64_t hvien_writable_mask =3D LOCAL_INTERRUPTS;
>
> -static const target_ulong vsip_writable_mask =3D MIP_VSSIP | LOCAL_INTER=
RUPTS;
> +static const uint64_t vsip_writable_mask =3D MIP_VSSIP | LOCAL_INTERRUPT=
S;
>
>  const bool valid_vm_1_10_32[16] =3D {
>      [VM_1_10_MBARE] =3D true,
> --
> 2.34.1
>
>

