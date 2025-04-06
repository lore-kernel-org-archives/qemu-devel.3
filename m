Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7102EC36002
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Apr 2025 23:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1ZOJ-0007pt-8T; Sun, 06 Apr 2025 19:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u1ZOE-0007g6-H8; Sun, 06 Apr 2025 19:26:58 -0400
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u1ZOC-0002sw-T3; Sun, 06 Apr 2025 19:26:58 -0400
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-51eb1a714bfso3990385e0c.3; 
 Sun, 06 Apr 2025 16:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743982015; x=1744586815; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tEo0vczNhLg3tSNl0bNy5WyiU3Cmaih0wihWUGV6FXA=;
 b=SiptiGB7XMsQuXALBAqa2R8E0gzSPlCGlv4lUF5WrKG5dvoRViqX6ghyFURiPM4MlG
 L755bdHWjtaLnJN1uC4QSacwstI6hVV1FHRqmFctD79eGHF/Plq4Dn/wooR+Hm20gZ5F
 TQzeX1TKM72n0KWOlNHgTReSh/UBGR9a8Y+YtnwyoRkUtAP3ijOO9ckhlhEY8njeYbF6
 9Akv/mn72c0f8VLRoz1mqOaH7g24ioke09VdumN4XzMYpTt5VX0Vi6VnbRMoM0xB+mVR
 v4f7Ief6PEtRXZu++UZsVAUS986GvLiuE/AAcEfmHYADyvuGS8pnC6FIrzMjRRNUoty3
 W/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743982015; x=1744586815;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tEo0vczNhLg3tSNl0bNy5WyiU3Cmaih0wihWUGV6FXA=;
 b=QcNXGA6fCTV0n1z8r8NKmzMSu/Wkpl8wP0sMJxgUYE/7A32qz4hCjlnypvolxlBqEj
 s2JzQ6tN1I5D78HzSPIBxOgwAGiAHq35fzs9KZbGqtHMxfSGVdMcjD64o1pbN6OEk49w
 UTdGvyLfELrBfiYAcGB1XM9u3PnXiJsCxgLwWR1W3PrxiNoNeOYsmChRR0CHAvbDSnX2
 hBUw84Q8bDWoQJDn5EtxvxW3STfcL3P+MAjS9bFDX9a3LKCMjQgcY5Dq1RQPOCQt6NQT
 B4gh273i6bNUewDaEOssw6WZ1T12g7dSBEjq2Wv6h6yrKRZrSPI7gz0BSQXr5LwM6o/3
 5inA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWU5FEU4qoF3nPBbsJuIg5C7+UuxbD+DTnXWyOIwX9V1dRC7Gd1itGBrt8Y9wlWk9k5F/HgGQzLIkP5@nongnu.org
X-Gm-Message-State: AOJu0Yz5NNV8lWED2jYGVCRYiw3v2Uax0LvwS9VJWD6ZzVFyoiBwbRl/
 OUc2sTkYRTBm6/aolPYNhdfC3STqYsYv9MTGurXS4lCz5HXx2lbPKSRRq4KaAr4SeXVo/1Yb404
 zMi/Tf6SHsXQ1wsgi2oNClc3+eq0=
X-Gm-Gg: ASbGncuXdd/tDDQWMKKG9Ms9KXhBZJXVf4ss+WeUQPX8c4WPgqjop36uWpFQOOGKh9y
 KbiA7NVsgYodXsmLB9LXV0wAfNuLh6WS1Jamgf8T607gcAPyRoGMaqv9ZE8L+1/3xvVjAvcCkXJ
 UPWltDJL1I2r0t1k10+YHHTRCGJxzqbDnBevPvv2jUulkdpvqk1IrkK/z7
X-Google-Smtp-Source: AGHT+IFi8CtqgD2Db5DdF/RoeeUk5BZA3CiWlA9xmp7rXqNJ/ZqProABO1TIYcIEAVltpSDT1JmDWNQveaQ/oOJ2iTw=
X-Received: by 2002:a05:6122:181b:b0:520:9688:d1bb with SMTP id
 71dfb90a1353d-52772ede57bmr3972472e0c.2.1743982015305; Sun, 06 Apr 2025
 16:26:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250404152750.332791-1-dbarboza@ventanamicro.com>
 <20250404152750.332791-2-dbarboza@ventanamicro.com>
In-Reply-To: <20250404152750.332791-2-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 7 Apr 2025 09:26:29 +1000
X-Gm-Features: ATxdqUGi2UZyoWy4OXIpo5YPLq85X3YUuUxONVxEiHeZoNKQSK4NcUxyiaWYqBw
Message-ID: <CAKmqyKMD31SLQeYt0Psi1vDcpK6cvPPtP1JQfh7sUgqqEJfYag@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/riscv/tcg: make 'max' cpu rva23s64 compliant
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, 
 ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2a.google.com
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

On Sat, Apr 5, 2025 at 1:29=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> The 'max' CPU includes all available extensions we implement, but at
> this moment it is not rva23s64 compliant due to missing checks that
> the parent profile (rva22s64) does.
>
> Users might expect that the a CPU called 'max' CPU will also compatible
> with our latest S mode profile. Let's make it official.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/tcg/tcg-cpu.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 5aef9eef36..cd489ae35b 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1486,6 +1486,8 @@ static void riscv_init_max_cpu_extensions(Object *o=
bj)
>      if (cpu->cfg.ext_smdbltrp) {
>          isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_smdbltrp), false)=
;
>      }
> +
> +    object_property_set_bool(obj, "rva23s64", true, NULL);
>  }
>
>  static bool riscv_cpu_has_max_extensions(Object *cpu_obj)
> --
> 2.49.0
>
>

