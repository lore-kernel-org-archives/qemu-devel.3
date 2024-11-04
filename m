Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913E3D1CA09
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 23:00:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t863g-0003Kj-MN; Mon, 04 Nov 2024 18:00:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t863c-0003JW-Hp; Mon, 04 Nov 2024 18:00:26 -0500
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t863b-0007pQ-22; Mon, 04 Nov 2024 18:00:24 -0500
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-84fcb020503so2504188241.0; 
 Mon, 04 Nov 2024 15:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730761221; x=1731366021; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nHwSgr+gFj+EGVo0e9DkYDUGLBMjLwHHhNZW8mSrM4A=;
 b=HOSVdaAO/+iMUbIRuLcB8roZV8u/2aMbDkbhtH38uvYfMun9DW6W8ifBWqw8vNH854
 T4GzTcPppLCrNfMJ6OcOGat2yZljvhVcy9HY1uH2U+EoeBvWzuNN9P1WFqVchrMjQa9c
 IHHS2W5E3DVd/kNI36jK+83r8adllyQ7tTd7G2AT2GINirj7RwePpBQVSeEYedCuixwJ
 +ATanF7oM4OMqwGf/uvAb4Gl/d3OiRPLoCEjEX1y+ydo/rLcxDNhNOyQiB40e/fJSjKL
 QYbqaidUcpQH1PtIIsl/kNQruSkymM10B2H67nnwPKA+PDFB75LHd6fkPN0gf4xA0AfB
 ACqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730761221; x=1731366021;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nHwSgr+gFj+EGVo0e9DkYDUGLBMjLwHHhNZW8mSrM4A=;
 b=QpcRiCuU+ZuQi4o9PvxyyhA+g4RrEEBdwFmy3lw8IzybephPXmCjiQz3uBhZTRk+cu
 +hzcxWLcIYBVTFRdvcYeAcmXxg7iIxHpScEzzb4gBA32olwCSfznYm/hVhj5sktPGyd6
 RUa/OUfNqGQ/GW6dbBaZm/0tiBbVLeLTqNT0LQ6uvNQeW00sH8lW0JpC9GnJ13PsYTo7
 5NjPBfjUecwJCzYUaMJ4y01Gpdeb78hRWxGOL8muT1S9oyf9eaSYMdiAlY5Ujtx6dUY3
 aHXdJiK6scXp6wvnfd35cQft8FkjQcM2zJii2QkFELXz4O35u1rk0L0eBYtdJBI/pYP6
 pDsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWrUbivFHlFqTjkGqbVEeG3ksC6eCy3LYME1mXKfFCYmW8lkJmpcOdmlD/vCDXjNJm2s9g12kOcHpt@nongnu.org
X-Gm-Message-State: AOJu0YxMQBDFMMiWh0wbLX4EvoV12ZZ4rBL2OEEmnBJ9Db6re5PxVdtr
 XaQe1+4E3BSaJChNFDtU2ocfhl7LjK/gQhDqcnF65Uqeb80Z0ZSLhHWEGA2WA6B/oaafJbWag2v
 18azuA2GcbdGaZS+eI2MLaAaTYXo=
X-Google-Smtp-Source: AGHT+IFx8baZxnVT1IplkzHIfNRat8CuWXEIebKjl/M10aqb9RDbdGGgjVNEs+7TfJe1ZuA6Kvxs2p6FallqTgA6MBo=
X-Received: by 2002:a05:6102:f93:b0:4a4:87a7:88ed with SMTP id
 ada2fe7eead31-4a961ad0eebmr12339372137.2.1730761221296; Mon, 04 Nov 2024
 15:00:21 -0800 (PST)
MIME-Version: 1.0
References: <20241104173551.125069-2-ajones@ventanamicro.com>
In-Reply-To: <20241104173551.125069-2-ajones@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 5 Nov 2024 08:59:55 +1000
Message-ID: <CAKmqyKMizDtNt8VQKXkA=GgLKEu8-V1zZHzsmeA6RQky2ZC7YQ@mail.gmail.com>
Subject: Re: [PATCH] target/riscv/kvm: Fix leak of reg list
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bmeng.cn@gmail.com, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92b;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92b.google.com
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

On Tue, Nov 5, 2024 at 3:36=E2=80=AFAM Andrew Jones <ajones@ventanamicro.co=
m> wrote:
>
> Free the temporary register list.
>
> Fixes: 608bdebb6075 ("target/riscv/kvm: support KVM_GET_REG_LIST")
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/kvm/kvm-cpu.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index cbda4596da73..effd8fed815d 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1170,6 +1170,8 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *c=
pu, KVMScratchCPU *kvmcpu)
>      }
>
>      kvm_riscv_check_sbi_dbcn_support(cpu, kvmcpu, reglist);
> +
> +    g_free(reglist);
>  }
>
>  static void riscv_init_kvm_registers(Object *cpu_obj)
> --
> 2.47.0
>
>

