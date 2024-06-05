Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7983C25B78
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 00:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEedG-0008ST-6V; Tue, 04 Jun 2024 20:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEedE-0008RN-BF; Tue, 04 Jun 2024 20:36:00 -0400
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEedC-0005h0-PO; Tue, 04 Jun 2024 20:36:00 -0400
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-80ac4f4be36so2019923241.2; 
 Tue, 04 Jun 2024 17:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717547757; x=1718152557; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ic7WtsCdi8GziyL+4Bq3ITyg7RVrfQoscrYgYHZPkB8=;
 b=Pjh8DnHEI80wHzmOdz8Kdb7tVIMhNAK3xHYKlqchMIQuDvi4O12cbmpFsZBw/iOpH+
 QmAqkeUka2Lv9ymbQ+ulGB+8P4lyaPAdtcUp0LW1e4Xqw2zDY5quIdzrMxJ+rc+sIn2k
 yjrMWImTW9qHex4+gk3cdJRYXjaIqwH22Bpomh2CLP2pdJyRAF7rcjV492/+OxvuBttf
 Q6Giv1PJiH+FpG4ftzZcyH4tnYcKx+4tlop1gdk8CzkyrT24CFtsX1HHKQ6IpH4ogxGA
 D93KU7H8KhZgjgpbrieyUVb5agmgASl34K4TZymCLx/txAU92z9hGo6cHqPni6NLJACT
 j/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717547757; x=1718152557;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ic7WtsCdi8GziyL+4Bq3ITyg7RVrfQoscrYgYHZPkB8=;
 b=HN5T9+tQXPWy0/+2Vd/7uNHJHteeVF1JWlBqQKtliAizAuuROLuF4Cc1hifP6SzRqA
 3tSisxkIZs9zDQ/umE/iPJyNrAcpulCKP6tUD/JcM9nOx+9BOyn7ZMPSW3JfkI6NrXs0
 epoXWY14Mq3hPEOTOxjsXwIhqcKF5MeRGJ1rIf94S/zU5gUriQGtvza3+SGbkT67/WRQ
 I0Q0VAkZ478Mu5/4cgiYLgxvwPmXJ5HHpxLjoT4zrmj4a8wYnbvyyeYn15/aJmzf75nU
 OxsZaaWCQsBdmNbLsODj9DGJ8j+fCcATl0sJ1gVFeUPOgDBrlgNo+lG3QpymtZ73mMSB
 c70Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7i+23blhB39mYy4azyH+fNWFaGcqAKlWE80VanLCe50SutfsPA/W02/tZgcycWIY2TNrLw3CE07a0ikNOekvesIE7GkM=
X-Gm-Message-State: AOJu0Yy1UdHtyRp2vezEl/K1VfkWsB6antcqHFsimMggfN+df2mi5FdK
 YJBjK0WoWFTH0mJoK/OIcKGjNS8SnArUgFgyDEtkOBPVzCw0RdMAGgHRmNEykQQEoeL7XGBkHGB
 cazxhuf4PKlcT1utroEp8tpjtz4g=
X-Google-Smtp-Source: AGHT+IFfOAU11qt7+Jias4QatavyWnx6aIH9dDMPO8Tot6N/j0N00GnrpKXk6X6RPBvqnMkERllE6Rf0ZixkUmc4waw=
X-Received: by 2002:a1f:73cc:0:b0:4e4:e6e5:aea with SMTP id
 71dfb90a1353d-4eb3a3cb8bemr1473358e0c.1.1717547757191; Tue, 04 Jun 2024
 17:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240531202759.911601-1-dbarboza@ventanamicro.com>
 <20240531202759.911601-7-dbarboza@ventanamicro.com>
In-Reply-To: <20240531202759.911601-7-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 5 Jun 2024 10:35:31 +1000
Message-ID: <CAKmqyKOXh4adyQPt5zwWgzNORTyH7H0QndKaMN-J+TB52xTihA@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] hw/riscv/virt.c: change imsic nodename to
 'interrupt-controller'
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, apatel@ventanamicro.com, ajones@ventanamicro.com, 
 conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::936;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x936.google.com
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
> The Linux DT docs for imsic [1] predicts an 'interrupt-controller@addr'
> node, not 'imsic@addr', given this node inherits the
> 'interrupt-controller' node.
>
> [1] Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.y=
aml
>
> Reported-by: Conor Dooley <conor@kernel.org>
> Fixes: 28d8c281200f ("hw/riscv: virt: Add optional AIA IMSIC support to v=
irt machine")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 0a18547c6d..56d7e945c6 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -538,7 +538,8 @@ static void create_fdt_one_imsic(RISCVVirtState *s, h=
waddr base_addr,
>          }
>      }
>
> -    imsic_name =3D g_strdup_printf("/soc/imsics@%lx", (unsigned long)bas=
e_addr);
> +    imsic_name =3D g_strdup_printf("/soc/interrupt-controller@%lx",
> +                                 (unsigned long)base_addr);
>      qemu_fdt_add_subnode(ms->fdt, imsic_name);
>      qemu_fdt_setprop_string(ms->fdt, imsic_name, "compatible", "riscv,im=
sics");
>      qemu_fdt_setprop_cell(ms->fdt, imsic_name, "#interrupt-cells",
> --
> 2.45.1
>
>

