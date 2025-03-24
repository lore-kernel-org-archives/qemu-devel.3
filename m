Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC9FC28B30
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 02:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twXlV-0004pW-NH; Sun, 23 Mar 2025 22:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1twXlT-0004o8-Mn; Sun, 23 Mar 2025 22:42:11 -0400
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1twXlR-0000no-NV; Sun, 23 Mar 2025 22:42:11 -0400
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-525b44b7720so643810e0c.0; 
 Sun, 23 Mar 2025 19:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742784128; x=1743388928; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9MAEjp7Ar9/XStKkk6SdiYAmgEQt2fog4Ffv93nY/vY=;
 b=gRHRAIJFqQgG0phUjAcNGh7m/r2KSxzUiG6OIXfs9NnSv5RVbFTwNYTAPEN95buANk
 O6GSTNZnyS4whKOP/D6aX11SGFkQPUfmq0xHRiQi6lk86YoxUdb6K0M7xv7DFPhamVkR
 Huz21CYmYA4wsD3P6JxdZXz63nYn+q+EAaq8OWxslgPPWiyM1UAZCPTBnSQbAE4YtgO0
 WPgvorqacOFliJ1WxsYGxTlIbAuVowrduEF/m2o0Uph2Wv1+jJqBdcGnwYN6b1B2JfT/
 3oDgJZ++VNsbSC3X0ANAlQPcaB3RJguv6G6BsGj8+sOY/MepKvq0ET4LPtCxQn6fcn/Y
 PVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742784128; x=1743388928;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9MAEjp7Ar9/XStKkk6SdiYAmgEQt2fog4Ffv93nY/vY=;
 b=f7ICyZWf4IRdFnfo3mwJDfH/DWxl4bgCQJhNlUF5lkW0xY7DSzD2miRwIY8Gqx+NtP
 +Tfdro4ZMgBTerDJLp+isuOHPJ2gIJJKBkSMwiOoHWFus97zq/BhuqNLSI6T8mOkbXXs
 1JdfTTGLoi3fcPrXLn1GrFK3ZZTbn4eW0obtBrPQ192mmYwcfzHECcEZL2X1kk6ay//+
 r1GDIT3b+9UXIjldzz4sh2ebP/ZnEWvoA5Ml0aqvhWjgdAmVWS3L2+OLFOzlIn0jnuId
 LJOj8B7uHPpvXbkepjwZcrZTIhmSb7qgDFkAA9WjPO1LE14ogMUAilH1Ynf1Ef2roDPR
 dNUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPxqvPcYR4YdQzsRuKLsPkW4gP4ffmwzhP0dDPElEQjS1+8eSrRWSypx/8WHjmHzc7+xfBihfJiFK/@nongnu.org
X-Gm-Message-State: AOJu0YwZp6zZV96+lGMyP9/YDvX4srnvW0yfe+JfqGS6B0ph3/JSWClk
 FINRx68spgHA50fs5RQiDAuHyNyjYw8MRNU66qoTFiaRfRVu71I5DR4VmqA6ASOvbhhu84bf3mm
 Sla05jzbzhAIW6LlkvTGbq/b+J2I=
X-Gm-Gg: ASbGnctxet34PBg4Q2o8qNjbY8HpyCZWyC5NO8s4TRJ11UTj7ll/XnjL5t/3hLgz2S/
 e3hY40qgf34zYzf3gfyg5sWCl7YKRGvrQPppe8cPn1IgLVwgSaxu/vm4S2jmf7KU6JO/P9guCac
 oC1z/dU1HNugLMMB4T4C6KUxUEOw2Tjs9I/LR35ZkpqDzLiLY97AIATYY=
X-Google-Smtp-Source: AGHT+IFMAe3OXMyR9hc+PTqQ0FnXFTw9RCeD19JMLzV14ZoVbfNMdIfXX8HAMAYB7p+o1lsNQfGoVVJKJ4hkgysfGeo=
X-Received: by 2002:a05:6122:3226:b0:520:3987:ce0b with SMTP id
 71dfb90a1353d-525a82ebb2fmr8297580e0c.2.1742784128044; Sun, 23 Mar 2025
 19:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250323063404.13206-1-hemanshu.khilari.foss@gmail.com>
In-Reply-To: <20250323063404.13206-1-hemanshu.khilari.foss@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Mar 2025 12:41:41 +1000
X-Gm-Features: AQ5f1JqY6fV7OY37SPRY4rL1vVadaazvgdyy8SeQGNHxUvWiGRslCWVs3obaKEY
Message-ID: <CAKmqyKNKzQCNJS=vwvtOk0VC70jE8Qax7Trgw-cY-SFJ=rWWTQ@mail.gmail.com>
Subject: Re: [PATCH v3] docs/specs/riscv-iommu: Fixed broken link to external
 risv iommu document
To: "hemanshu.khilari.foss" <hemanshu.khilari.foss@gmail.com>
Cc: qemu-devel@nongnu.org, Alistair.Francis@wdc.com, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2f.google.com
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

On Sun, Mar 23, 2025 at 4:36=E2=80=AFPM hemanshu.khilari.foss
<hemanshu.khilari.foss@gmail.com> wrote:
>
> The links to riscv iommu specification document are incorrect. This patch
> updates all the said link to point to correct location.
>
> Cc: qemu-riscv@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2808
> Signed-off-by: hemanshu.khilari.foss <hemanshu.khilari.foss@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  docs/specs/riscv-iommu.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/docs/specs/riscv-iommu.rst b/docs/specs/riscv-iommu.rst
> index 000c7e1f57..991d376fdc 100644
> --- a/docs/specs/riscv-iommu.rst
> +++ b/docs/specs/riscv-iommu.rst
> @@ -4,7 +4,7 @@ RISC-V IOMMU support for RISC-V machines
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  QEMU implements a RISC-V IOMMU emulation based on the RISC-V IOMMU spec
> -version 1.0 `iommu1.0`_.
> +version 1.0 `iommu1.0.0`_.
>
>  The emulation includes a PCI reference device (riscv-iommu-pci) and a pl=
atform
>  bus device (riscv-iommu-sys) that QEMU RISC-V boards can use.  The 'virt=
'
> @@ -14,7 +14,7 @@ riscv-iommu-pci reference device
>  --------------------------------
>
>  This device implements the RISC-V IOMMU emulation as recommended by the =
section
> -"Integrating an IOMMU as a PCIe device" of `iommu1.0`_: a PCI device wit=
h base
> +"Integrating an IOMMU as a PCIe device" of `iommu1.0.0`_: a PCI device w=
ith base
>  class 08h, sub-class 06h and programming interface 00h.
>
>  As a reference device it doesn't implement anything outside of the speci=
fication,
> @@ -109,7 +109,7 @@ riscv-iommu options:
>  - "s-stage": enabled
>  - "g-stage": enabled
>
> -.. _iommu1.0: https://github.com/riscv-non-isa/riscv-iommu/releases/down=
load/v1.0/riscv-iommu.pdf
> +.. _iommu1.0.0: https://github.com/riscv-non-isa/riscv-iommu/releases/do=
wnload/v1.0.0/riscv-iommu.pdf
>
>  .. _linux-v8: https://lore.kernel.org/linux-riscv/cover.1718388908.git.t=
jeznach@rivosinc.com/
>
> --
> 2.42.0
>
>

