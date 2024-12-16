Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEB4E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 03:46:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN238-0005SW-8w; Sun, 15 Dec 2024 22:45:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tN237-0005SA-3a
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:45:37 -0500
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tN235-0005Qb-IY
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:45:36 -0500
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-5174f9c0d2aso1142320e0c.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 19:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734320734; x=1734925534; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X3N40PezsruY20z3fP3NKgqtXUKVRVqUowJvry6Rl90=;
 b=TGkvWfVjRwhCVi0MuplZM9Q8QcMwLV++q5WD4qiFM5Za1EV96GKtKe14avQ4aic1DF
 tfYdakyWfsqUaW25f/YMY2eLFBjWpXgw5zEHZkV/LTEJn63UsKStESKNiE3hMxIEfY2a
 TOR/4PqQicAlohohf3ejvvuvRBpG2jbYBYL+zn2+fT50hs0fuHQvMjKXDSRxPpLZ5ozh
 gRUhJUQP9JiYWGjdDkhx6XD6qREe3CM6DfFUK6pk+QGFSx25o8/rMcQduv58drQhSaxx
 6kx0G/qJMv5rzF8+pHiIIiLGC9Kp0QyvsTxyj4n8Rme1veDgi4tHDvKIn4poJxmhArBM
 THmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734320734; x=1734925534;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X3N40PezsruY20z3fP3NKgqtXUKVRVqUowJvry6Rl90=;
 b=vIYTioHRTsH0OP1+rDJVmACFAVFQtB2KUSFmwQGptbe/tnKyrkWIMOSW/rAZxHpHlo
 AHQEehmapKps2xa0S/AL5vRaUOthf7UDlsQmmmCNe+4b0SZ9pEB/KGHGupY5uJCRY6Oz
 wbv69mpTmjJ5wXBADbzgHizCcKm9PpXzxyXWDpfX3YvyHuxKPChqE23pJrlqXaCa6a1h
 BfXTXvg/EN73EU9GBtD3zBtIIYVuppwMA46ZJQ/z+FaOV09cbykQdg1pH/ovb3NJpYU5
 F4kpTq37bh5ef+wHRjXqP++REDSVi9reRxkEj5I+W3IaoBschC/gKtYhq6ENqBzzSFqa
 FTqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU08oK7yZYAkP6WdlMCLU3UvgafxZoVnAoL428J8i0FPsahCfyBXfs9ucBTdYcxRht9Csh9fdA4NAyt@nongnu.org
X-Gm-Message-State: AOJu0YzEN0Hw6LYNx9h/WAOD41koz9hxFM3kgeCcyNnU7Oc/5A5HZqjT
 pG39fdIhT9xKp54xmxcrRzOH2M/a14bInD9KswmcVOGHLi+2pmsDp33foIil1OrYvHB3784bf/z
 IagYSFNgXYh4zA+Fcor0vR3YirSI=
X-Gm-Gg: ASbGnctZDrvuvc15WqBWu9oM46BVLxEXLx+ekkmdfJblJ9n9WpQzNy0QdxXiB4Piqnx
 KkZMfbs8OG0hKAP29ctN/NGHCWpm4U0LIyEhdw7EK+z5mu+em0BuTO4HGujAIbORuUlt2
X-Google-Smtp-Source: AGHT+IEMx/mYvea+2wKV50yjmzYSjOu0vT5zcoH3nqKXe6C5G6/+K0P64tQXIkmEGIUZfXfjJZL+o2N4p4rIUKr9zHI=
X-Received: by 2002:a05:6102:50ab:b0:4b1:20b1:bff3 with SMTP id
 ada2fe7eead31-4b25dccc0a4mr10629965137.16.1734320734244; Sun, 15 Dec 2024
 19:45:34 -0800 (PST)
MIME-Version: 1.0
References: <20241212090059.94167-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241212090059.94167-1-heinrich.schuchardt@canonical.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 16 Dec 2024 13:45:08 +1000
Message-ID: <CAKmqyKP4gm4xMuMwwvv3fQ_Quq64LU26xcO7ZegBSvVSC_QCeQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] pc-bios: add missing riscv64 descriptor
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2b;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2b.google.com
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

On Thu, Dec 12, 2024 at 7:01=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Without descriptor libvirt cannot discover the EDK II binaries via
> the qemu:///system connection.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  pc-bios/descriptors/60-edk2-riscv64.json | 31 ++++++++++++++++++++++++
>  pc-bios/descriptors/meson.build          |  3 ++-
>  2 files changed, 33 insertions(+), 1 deletion(-)
>  create mode 100644 pc-bios/descriptors/60-edk2-riscv64.json
>
> diff --git a/pc-bios/descriptors/60-edk2-riscv64.json b/pc-bios/descripto=
rs/60-edk2-riscv64.json
> new file mode 100644
> index 0000000000..14811ca307
> --- /dev/null
> +++ b/pc-bios/descriptors/60-edk2-riscv64.json
> @@ -0,0 +1,31 @@
> +{
> +    "description": "UEFI firmware for riscv64",
> +    "interface-types": [
> +        "uefi"
> +    ],
> +    "mapping": {
> +        "device": "flash",
> +        "executable": {
> +            "filename": "@DATADIR@/edk2-riscv-code.fd",
> +            "format": "raw"
> +        },
> +        "nvram-template": {
> +            "filename": "@DATADIR@/edk2-riscv-vars.fd",
> +            "format": "raw"
> +        }
> +    },
> +    "targets": [
> +        {
> +            "architecture": "riscv64",
> +            "machines": [
> +                "virt*"
> +            ]
> +        }
> +    ],
> +    "features": [
> +
> +    ],
> +    "tags": [
> +
> +    ]
> +}
> diff --git a/pc-bios/descriptors/meson.build b/pc-bios/descriptors/meson.=
build
> index afb5a959cc..cdd0be01a3 100644
> --- a/pc-bios/descriptors/meson.build
> +++ b/pc-bios/descriptors/meson.build
> @@ -6,7 +6,8 @@ if unpack_edk2_blobs and get_option('install_blobs')
>      '60-edk2-arm.json',
>      '60-edk2-i386.json',
>      '60-edk2-x86_64.json',
> -    '60-edk2-loongarch64.json'
> +    '60-edk2-loongarch64.json',
> +    '60-edk2-riscv64.json'
>    ]
>      configure_file(input: files(f),
>                     output: f,
> --
> 2.45.2
>
>

