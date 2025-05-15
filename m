Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF406C2D0CB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 05:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFRIt-0006lL-Bt; Thu, 15 May 2025 01:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uFRIo-0006bf-RN
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:38:44 -0400
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uFRIn-0007ft-6T
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:38:42 -0400
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-52c6f67c6c5so167522e0c.2
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 22:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747287520; x=1747892320; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vSVPPDX54kOYXjEskzCbq/UHPSBv+Yq+Qenn9t6+A98=;
 b=IzuibHMsIKNY9nvKoO41YQ/OHHCXZe53a5nhome4wQv/bqEMjbN6AL/Dfns6oS5hoT
 nb76wFT7FPJouylKjEbIdCMYpIjkS1iw3f/OiLw335ibGhd4/VHsTRTSuPl16WPW0fLs
 04mBjrRhULMArS1nHUoR4awOVNkvppM6HcucoSGNFa9gjzEeHGjhtROFwtukOHje3McD
 cjaVOM6kQN7dorszyy+vwn9BA6MX/3Gn8GMF/9ICvnYS53vqbhddzULO7MW1oTQcGkq7
 7m1Eqg7WHv9MnOcN0inRi9ygawnbp1ySUuD29Rmx1M984yhYEsHOQLNKNnw2sPxXoBNY
 UBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747287520; x=1747892320;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vSVPPDX54kOYXjEskzCbq/UHPSBv+Yq+Qenn9t6+A98=;
 b=nA/W/rZqIzHaA6Fcohg6bDC6J5tDvOW+ZdImH+3v+ztrEovPXYg+qk87FdjW+HY6QR
 UOicONhZdcZHGDUDnvTlaA1Aw0wV0akPtTTxfPziZOWQWRN9D7kARV0iISnKqQNdq4xO
 G6EcgcE3/67ro1d7Ec+ooMwd0RxQw+s0qRfFmJX98MrPQe9wpc5/hhLQEBYMwfKzVqs7
 G6IBrweECKLuh/LZwzZZriyekWpOgxURDchfrOgOKisyGLdeqkG0KzpSWs/9MnfRoQPM
 UsUvjZq+NgcM2TdHLRlKwpvrX3xTOY7dR7/ZD2BfF743J5HeuEYDT4BbmF03wAnDMe10
 NRxg==
X-Gm-Message-State: AOJu0YxiD6zJZ6apIZ5hunA1UEfnSysNZGzBqVY8juUBzy7R3N9ZBSra
 ixKRPX/JbutVveIZYaSP6XYE6b+TtJ2vXMv9WmXl9mdezNUK9AVTK0t26G2vOTHOX8ckN0IjJhm
 7tbO+9eiQ8gGm5NKN7IazbTwGOR0=
X-Gm-Gg: ASbGnctCbDWHsVc/LsQcwXDIST/TBYo6K2a26NFQbcrQ6lmXkIsOHDLeAjAfNcd0He/
 wKa23SJP7zHD/4hCa7K8C4cdyURzv6Mc8aE9MNiSkpBbYDV7vAF+o6G21x17Lbi36/5LcjkEE71
 VIfIajtf4WGYFeXiehs45gG4mBoI9B+dmo15lErFR0jaP9X5HVgngmChZMb2GCSwc=
X-Google-Smtp-Source: AGHT+IH9AQLyKwN0UINojfRvTvlSd611rXM9+MXnW4TClJGxGpo4fQIweHHZmf+hlEC2wTu0/xvbwqh2Ot44oo7PlyQ=
X-Received: by 2002:a05:6122:1781:b0:52b:789:2d0 with SMTP id
 71dfb90a1353d-52dabcfe957mr845864e0c.5.1747287520026; Wed, 14 May 2025
 22:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250512095226.93621-1-pbonzini@redhat.com>
 <20250512095226.93621-20-pbonzini@redhat.com>
In-Reply-To: <20250512095226.93621-20-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 May 2025 15:38:14 +1000
X-Gm-Features: AX0GCFu0gk-U8AIaEjOwBfQPb9GuEh8m4cBWfyYNKVx3cBF8tDQExYASoqpi4mE
Message-ID: <CAKmqyKPUGEEgC3w44FsenuZEMqqr+f_KSn6qm3Fj5X2SvFW4UQ@mail.gmail.com>
Subject: Re: [PATCH 19/26] target/riscv: th: make CSR insertion test a bit
 more intuitive
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, dbarboza@ventanamicro.com, 
 richard.henderson@linaro.org
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

On Mon, May 12, 2025 at 7:54=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> In preparation for generalizing the custom CSR functionality,
> make the test return bool instead of int.  Make the insertion_test
> optional, too.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/th_csr.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/target/riscv/th_csr.c b/target/riscv/th_csr.c
> index 6c970d4e813..969a9fe3c80 100644
> --- a/target/riscv/th_csr.c
> +++ b/target/riscv/th_csr.c
> @@ -29,7 +29,7 @@
>
>  typedef struct {
>      int csrno;
> -    int (*insertion_test)(RISCVCPU *cpu);
> +    bool (*insertion_test)(RISCVCPU *cpu);
>      riscv_csr_operations csr_ops;
>  } riscv_csr;
>
> @@ -42,13 +42,9 @@ static RISCVException smode(CPURISCVState *env, int cs=
rno)
>      return RISCV_EXCP_ILLEGAL_INST;
>  }
>
> -static int test_thead_mvendorid(RISCVCPU *cpu)
> +static bool test_thead_mvendorid(RISCVCPU *cpu)
>  {
> -    if (cpu->cfg.mvendorid !=3D THEAD_VENDOR_ID) {
> -        return -1;
> -    }
> -
> -    return 0;
> +    return cpu->cfg.mvendorid =3D=3D THEAD_VENDOR_ID;
>  }
>
>  static RISCVException read_th_sxstatus(CPURISCVState *env, int csrno,
> @@ -66,13 +62,12 @@ static riscv_csr th_csr_list[] =3D {
>          .csr_ops =3D { "th.sxstatus", smode, read_th_sxstatus }
>      }
>  };
> -
>  void th_register_custom_csrs(RISCVCPU *cpu)
>  {
>      for (size_t i =3D 0; i < ARRAY_SIZE(th_csr_list); i++) {
>          int csrno =3D th_csr_list[i].csrno;
>          riscv_csr_operations *csr_ops =3D &th_csr_list[i].csr_ops;
> -        if (!th_csr_list[i].insertion_test(cpu)) {
> +        if (!th_csr_list[i].insertion_test || th_csr_list[i].insertion_t=
est(cpu)) {
>              riscv_set_csr_ops(csrno, csr_ops);
>          }
>      }
> --
> 2.49.0
>

