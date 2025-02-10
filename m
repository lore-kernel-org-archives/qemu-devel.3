Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9D9C0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 00:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thHuk-0008Hy-I9; Sun, 09 Feb 2025 19:44:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1thHuj-0008HX-K5
 for qemu-devel@nongnu.org; Sun, 09 Feb 2025 19:44:41 -0500
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1thHug-0001sm-Ux
 for qemu-devel@nongnu.org; Sun, 09 Feb 2025 19:44:40 -0500
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-866f61c01e5so1155735241.2
 for <qemu-devel@nongnu.org>; Sun, 09 Feb 2025 16:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739148277; x=1739753077; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FH9gaPOUXqlV0eC3tdI/bbstRUYJzar55sXppBsjXxs=;
 b=PFkCwpnPy3GWZfnpYKGzYjBqHhn4aRTGv3IlzMHQz8/aW3oG/V60qto+MscyxaEr0v
 9v3abFmIM5P2nIie1aFXUDKcJWBBokkNiHFM4LIARlQAq0d2D5uXY6fy6zovmfP2cGMr
 kEOOFceSvwCLMKxTfq1dZec9drEvztydTDg944wZRLOOGyDGfVa92L20gHBdBCUdeape
 UMOkon6nZ3go0/soZ5xWcTu1OEQVsJUuEOu2b+UMXb9bDFhCxt30NiNq9/uGG22HtlfQ
 g//2ZiPJdG3QB08smuWgfEZLq9eGuxgLb/PafzDFFyxP99XZkgmvtRGbdf1hyDrQ8EZI
 aOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739148277; x=1739753077;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FH9gaPOUXqlV0eC3tdI/bbstRUYJzar55sXppBsjXxs=;
 b=cq1SwcDr9zgUO/S7zv8AOSeVMBFih68Fb+zcjsiW8vILwHsipXZP2l2d7OIqO5ij5D
 ZthiCoZRr41ZF+DIqFgRWRz/zNSALgTCr7PBFzTT7hlvrRka+eML1tYXFjYu6hgJQMEh
 Bzeldj4DEwsCHM7m+n7WJTbBhIOot1f0g2FcMzgnOqu7MiPXQhkSyYMj4YKtUXdTMky6
 Cwj7vM2dQYiklNcy7aECiMORms8eWYXXWWFHRMnkqMya78IWRYKFtWuKidNVs7n7bnI0
 kfhSqDLL9EumaWfnkf/FzJ6DEH2KSCxwvcNr3BB5iIgUJntAdVi5Gfvab/A4oCAuF00x
 4qOQ==
X-Gm-Message-State: AOJu0YxgIOqI4EJP9W2TggyWmqNf62J1lDJzAVSd91GnunKQbNOKGRGF
 4XFhSlVrx45iqir6bInXZ08MAbiKYyLDsWGoYjMsMmiSlTfHeHNhz909FEc55NXbNa6ZgBRH3Ts
 f7W7Mpb1kYuz3Lo1ZHL1Orp1NrT0=
X-Gm-Gg: ASbGnctVyu2hKr80uO8MlR5ARXgcpXasZGSH347kNbI0j7XW9GM3HSt1wvGe8GORq/e
 uHtH1yIN5sl+4obE3neqlNmP2OjvyMShVLJBGz7qwRAszym2FVcyjO2bNUr0YQwjmqhzSI0Zgcr
 /T1zRl7xiM3CwOHhuuqRWPm5KfAA==
X-Google-Smtp-Source: AGHT+IFnZs4+RFJwk/28WebhCYHp5GumMqF9reZi15f16Z3dVtdMLSHoycSUpHaC29VktRJcKj0exhhmFzHN8vwRasg=
X-Received: by 2002:a05:6102:6c7:b0:4bb:b868:9d2d with SMTP id
 ada2fe7eead31-4bbb868b96fmr2849597137.24.1739148276799; Sun, 09 Feb 2025
 16:44:36 -0800 (PST)
MIME-Version: 1.0
References: <20250206182711.2420505-1-pbonzini@redhat.com>
 <20250206182711.2420505-2-pbonzini@redhat.com>
In-Reply-To: <20250206182711.2420505-2-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 10 Feb 2025 10:44:10 +1000
X-Gm-Features: AWEUYZmMpgyPo_Pw0qB-ypNmaF8782UvD6-W2AfiKP-PgPo-4Yudc3ZeIMpRf7A
Message-ID: <CAKmqyKOwkVnumAXB5JH+YDP9BuJKXdtQUBuaewnVSebMhx-2Rg@mail.gmail.com>
Subject: Re: [PATCH 01/22] target/riscv: remove unused macro DEFINE_CPU
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com
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

On Fri, Feb 7, 2025 at 4:29=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 3d4bd157d2c..ed9da692030 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -3051,15 +3051,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt,=
 char *nodename)
>  }
>  #endif
>
> -#define DEFINE_CPU(type_name, misa_mxl_max, initfn)         \
> -    {                                                       \
> -        .name =3D (type_name),                                \
> -        .parent =3D TYPE_RISCV_CPU,                           \
> -        .instance_init =3D (initfn),                          \
> -        .class_init =3D riscv_cpu_class_init,                 \
> -        .class_data =3D (void *)(misa_mxl_max)                \
> -    }
> -
>  #define DEFINE_DYNAMIC_CPU(type_name, misa_mxl_max, initfn) \
>      {                                                       \
>          .name =3D (type_name),                                \
> --
> 2.48.1
>
>

