Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3BAEC4828F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 03:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWpU8-0005lf-UT; Sun, 04 Feb 2024 22:17:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rWpU7-0005lA-1a; Sun, 04 Feb 2024 22:17:27 -0500
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rWpU4-00013i-4N; Sun, 04 Feb 2024 22:17:26 -0500
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-7d6024b181bso1633639241.2; 
 Sun, 04 Feb 2024 19:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707103042; x=1707707842; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lg+O/1jVtaCJ+RF5VCezLc+6UWjGS+drNB7RquN1z10=;
 b=M93Ke0RfdrxKTBoaCoqh4C1IwFWo4Ipulg9/izGvzx1pXUj6EGjW+fNkgLcjKGSTJ/
 2j1Y9BIDBYZS87TkwaQ0ViCEC4eNdZp7l/PotrJPwgZJvL4Gh7yS2KPEyi4Tc2AO8G/p
 hAWIwweBh5g7kbFy3qwANcT/SXdGqcgiKXgW/aGu+rrzEotElfIZSocTxRnmd6e2hIqy
 6qyaXYQMUFn3rgSDIAA2+YQC8ydngQukLUTxLvPVa1E6V/WweefMDKwfQr+TOzNXif0A
 IiPvmKAHOIJFa5wXkxFZD0hMbYu97GIAY4qj8SLh1aVQgl314oQ4RDX8//FGEspH1y8V
 NurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707103042; x=1707707842;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lg+O/1jVtaCJ+RF5VCezLc+6UWjGS+drNB7RquN1z10=;
 b=UuTJI+JHZ2sOTS9eV3FSi4u0MbolVMIEYvwZM/OwwjHjBZVht+bxNcfJGCQm3qAFuF
 3jpvwL32BlqewA4/Z/fVVWovS5GV9DaRLsDASQBdFjqgP/FrN1DK1HUNPV4iVUiiRKiF
 1LhRQPfqf4xUWh2j2HSQu96N4f0yUGdD0zIQP89QAaNOxRNBCmn3cf3oQJaFBGw2nT9q
 GSnAyYNDjty9wQBSXyaAlteVaow9hfr6cQl2lsbGHTosY2Mi8nJPVpstuCcNk1lmmxMk
 1afcQDtrSqJpTcJuS9hUe5gHgkmy8uhqKrDA4aGA2dfd0gbzbL5P7IntzjeNVNlmFb73
 EvGw==
X-Gm-Message-State: AOJu0Yz1v9P7tPILyywk+uDWAq5i+/oOdzIWAIKfIHhi5WZtK2acpPbk
 R4v/CCZH9wCQlgyz3girL2x4Q10Hdn+wLWrRcWm9JttbejUeMHEApDElY1+b2L3otiBOdhqbfQP
 2nuCwr9xGf8/SqzDxIuj1yIgsIDk=
X-Google-Smtp-Source: AGHT+IEymLrqDuF3BVCUrJV5vgO+A2ur91Y0f7OUYRYgsfp3YLSzR1ijjZmwI8r+iL5Y5vO0Km/l2XtXSWI7V9koa8o=
X-Received: by 2002:a05:6102:1886:b0:46d:1d8a:5ebf with SMTP id
 ji6-20020a056102188600b0046d1d8a5ebfmr3143601vsb.27.1707103042335; Sun, 04
 Feb 2024 19:17:22 -0800 (PST)
MIME-Version: 1.0
References: <20240122221529.86562-1-dbarboza@ventanamicro.com>
In-Reply-To: <20240122221529.86562-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 5 Feb 2024 13:16:56 +1000
Message-ID: <CAKmqyKMYvxOVZ_jPtvgmsZLxr-9ht0si7wR3SdvgiAP6B2ePgg@mail.gmail.com>
Subject: Re: [PATCH 0/7] hw/riscv: fix leak, add more g_autofree
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::934;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x934.google.com
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

On Tue, Jan 23, 2024 at 9:39=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> First patch fixes a leak found when using Valgrind. The root cause is a
> missing g_free() in a string.
>
> In fact, I found while doing reviews that we keep repeating the same
> pattern:
>
> =3D=3D=3D=3D
> char *name;
> name =3D g_strdup_printf(...);
> (...)
> g_free(name);
> =3D=3D=3D=3D
>
> With this in mind, I ended up making this rather trivial series to
> introduce more string/array autocleaning in the 'virt' machine code. The
> advantage of doing 'g_autofree' is that we'll guarantee that we'll clean
> ourselves up when the variable goes out of scope, avoiding leaks like
> the one patch 1 fixes. We want to enforce this autoclean style in
> reviews, and for that we need to get rid of at least some of the uses we
> do it right now.
>
> I didn't bother changing the 'spike' and the 'sifive' boards for now
> because the bulk of new patches is done on top of the 'virt' machine,
> so it's more important to tidy this board first.
>
>
> Daniel Henrique Barboza (7):
>   hw/riscv/virt-acpi-build.c: fix leak in build_rhct()
>   hw/riscv/numa.c: use g_autofree in socket_fdt_write_distance_matrix()
>   hw/riscv/virt.c: use g_autofree in create_fdt_socket_cpus()
>   hw/riscv/virt.c: use g_autofree in create_fdt_sockets()
>   hw/riscv/virt.c: use g_autofree in create_fdt_virtio()
>   hw/riscv/virt.c: use g_autofree in virt_machine_init()
>   hw/riscv/virt.c: use g_autofree in create_fdt_*

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  hw/riscv/numa.c            |   4 +-
>  hw/riscv/virt-acpi-build.c |   2 +-
>  hw/riscv/virt.c            | 109 ++++++++++++-------------------------
>  3 files changed, 37 insertions(+), 78 deletions(-)
>
> --
> 2.43.0
>
>

