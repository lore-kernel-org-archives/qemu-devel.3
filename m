Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83375C47DA9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 00:47:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUcGo-0004z9-Dq; Mon, 29 Jan 2024 19:46:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rUcGY-0004yW-DY
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 19:46:20 -0500
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rUcGW-000334-Jo
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 19:46:18 -0500
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-4bda5740d2dso529039e0c.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 16:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706575575; x=1707180375; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=voQbyWk7CDPfyWX1JLY7o8EKz2lJdsKpQihn9HuNlSk=;
 b=FX+JzYMB8iIuvf2jiy/d8ZtGnPhZzgegNrmyqBk7CgPoa34r8Qfd4JZ+zgyJ/fZNAf
 pHD0kyf9vFtQqZtK9Mk4rzUneSO9JxDt5Z4zeDI3ZgaxcSDyRNamgqUchtfqCY4J1Uww
 BbXu8fJkrBqR5caY+y2GOHwlBz7wbHeFHKYVwZKlixdMkFhfIw/uSn8uZKMEg8jyxF8i
 YmwUISudfLlr4LwQkHfWkuGOqf6/uL+7mVnTPVlakKyyBd1we1MaiFfaGuzczuDFTQ9n
 o/XBhzAO+slWnN5PzCpXsBw+yjUDWsU/OsoYuGrEb5eGa3Wp11dkd9TwQ9qFaoblyKw+
 m0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706575575; x=1707180375;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=voQbyWk7CDPfyWX1JLY7o8EKz2lJdsKpQihn9HuNlSk=;
 b=gwSfKvdmnWZWspouQsOqDFgvMofeGoima97X+ZVz0jM7UdRUU+2HEcNlhI+mGC5jsn
 /AHC9ioa+jT9xitujrP6H7Y7/5peyWvQpkqoiht5vzv6slvBveHLbCjy4rtFA6c6JVmF
 hZPadWA46CNmarNE4MJFMyNIia+w97Mlwa+fCjSPVv+Pc+jmnXmacZJ8hugEui6wK3Db
 gQaxqtWsmCnBs7ToJaeLLMkcjrbmOGFQAPa2MwXQknrY/wm1uTsHkSjgdNmKC50SDylG
 QuIoebmvFTzT388OkdX5v0SVRUD2tw0U7U7AiFhiUT+CebbKijcFrMqSTFP4JVhO9xcz
 dOZA==
X-Gm-Message-State: AOJu0Yx4L5X9ktxNhSfSrK2v1X9+2ASTw8siAPqsr4ZUNLbwoGYPD74Y
 cIriI1kb6O/ZWViO7+k21U85t1ej9cO29NjzNBBVL+c6ItMNtInlfsPIP1crlz0B/Co+dn4yoV5
 ja8/aBHiN9BurZsdeK4ec8296xrk=
X-Google-Smtp-Source: AGHT+IENftbNzg9Gm6iVVgcedGkBrDgGkZ7CMid+MENsZAzyUlaS83ZxHLOT0E2uyWaa8V65OhKL6qwjig5vK/N7ZP8=
X-Received: by 2002:a05:6122:2186:b0:4bd:29f7:53c4 with SMTP id
 j6-20020a056122218600b004bd29f753c4mr2828104vkd.1.1706575575361; Mon, 29 Jan
 2024 16:46:15 -0800 (PST)
MIME-Version: 1.0
References: <20240129115809.1039924-1-pbonzini@redhat.com>
In-Reply-To: <20240129115809.1039924-1-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Jan 2024 10:45:49 +1000
Message-ID: <CAKmqyKPbyAQCK5gvwg72G3GV61bUibzXdZ7H1CQ9in=e_6HKJg@mail.gmail.com>
Subject: Re: [PATCH] kconfig: use "select" to enable semihosting
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2c;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2c.google.com
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

On Mon, Jan 29, 2024 at 9:59=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> Just like all other dependencies, these can be expressed in Kconfig
> files rather than in the default configurations.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  configs/devices/m68k-softmmu/default.mak    | 2 --
>  configs/devices/mips-softmmu/common.mak     | 3 ---
>  configs/devices/nios2-softmmu/default.mak   | 2 --
>  configs/devices/riscv32-softmmu/default.mak | 2 --
>  configs/devices/riscv64-softmmu/default.mak | 2 --
>  configs/devices/xtensa-softmmu/default.mak  | 2 --
>  target/m68k/Kconfig                         | 1 +
>  target/mips/Kconfig                         | 1 +
>  target/nios2/Kconfig                        | 1 +
>  target/riscv/Kconfig                        | 2 ++
>  target/xtensa/Kconfig                       | 1 +
>  11 files changed, 6 insertions(+), 13 deletions(-)
>
> diff --git a/configs/devices/m68k-softmmu/default.mak b/configs/devices/m=
68k-softmmu/default.mak
> index 7f8619e4278..8dcaa28ed38 100644
> --- a/configs/devices/m68k-softmmu/default.mak
> +++ b/configs/devices/m68k-softmmu/default.mak
> @@ -1,7 +1,5 @@
>  # Default configuration for m68k-softmmu
>
> -CONFIG_SEMIHOSTING=3Dy
> -
>  # Boards:
>  #
>  CONFIG_AN5206=3Dy
> diff --git a/configs/devices/mips-softmmu/common.mak b/configs/devices/mi=
ps-softmmu/common.mak
> index 7da99327a77..1a853841b27 100644
> --- a/configs/devices/mips-softmmu/common.mak
> +++ b/configs/devices/mips-softmmu/common.mak
> @@ -1,8 +1,5 @@
>  # Common mips*-softmmu CONFIG defines
>
> -# CONFIG_SEMIHOSTING is always required on this architecture
> -CONFIG_SEMIHOSTING=3Dy
> -
>  CONFIG_ISA_BUS=3Dy
>  CONFIG_PCI=3Dy
>  CONFIG_PCI_DEVICES=3Dy
> diff --git a/configs/devices/nios2-softmmu/default.mak b/configs/devices/=
nios2-softmmu/default.mak
> index 1bc4082ea99..e130d024e62 100644
> --- a/configs/devices/nios2-softmmu/default.mak
> +++ b/configs/devices/nios2-softmmu/default.mak
> @@ -1,7 +1,5 @@
>  # Default configuration for nios2-softmmu
>
> -CONFIG_SEMIHOSTING=3Dy
> -
>  # Boards:
>  #
>  CONFIG_NIOS2_10M50=3Dy
> diff --git a/configs/devices/riscv32-softmmu/default.mak b/configs/device=
s/riscv32-softmmu/default.mak
> index d847bd5692e..94a236c9c25 100644
> --- a/configs/devices/riscv32-softmmu/default.mak
> +++ b/configs/devices/riscv32-softmmu/default.mak
> @@ -3,8 +3,6 @@
>  # Uncomment the following lines to disable these optional devices:
>  #
>  #CONFIG_PCI_DEVICES=3Dn
> -CONFIG_SEMIHOSTING=3Dy
> -CONFIG_ARM_COMPATIBLE_SEMIHOSTING=3Dy
>
>  # Boards:
>  #
> diff --git a/configs/devices/riscv64-softmmu/default.mak b/configs/device=
s/riscv64-softmmu/default.mak
> index bc69301fa4a..3f680594484 100644
> --- a/configs/devices/riscv64-softmmu/default.mak
> +++ b/configs/devices/riscv64-softmmu/default.mak
> @@ -3,8 +3,6 @@
>  # Uncomment the following lines to disable these optional devices:
>  #
>  #CONFIG_PCI_DEVICES=3Dn
> -CONFIG_SEMIHOSTING=3Dy
> -CONFIG_ARM_COMPATIBLE_SEMIHOSTING=3Dy
>
>  # Boards:
>  #
> diff --git a/configs/devices/xtensa-softmmu/default.mak b/configs/devices=
/xtensa-softmmu/default.mak
> index 4fe1bf00c94..49e4c9da88c 100644
> --- a/configs/devices/xtensa-softmmu/default.mak
> +++ b/configs/devices/xtensa-softmmu/default.mak
> @@ -1,7 +1,5 @@
>  # Default configuration for Xtensa
>
> -CONFIG_SEMIHOSTING=3Dy
> -
>  # Boards:
>  #
>  CONFIG_XTENSA_SIM=3Dy
> diff --git a/target/m68k/Kconfig b/target/m68k/Kconfig
> index 23debad519a..9eae71486ff 100644
> --- a/target/m68k/Kconfig
> +++ b/target/m68k/Kconfig
> @@ -1,2 +1,3 @@
>  config M68K
>      bool
> +    select SEMIHOSTING
> diff --git a/target/mips/Kconfig b/target/mips/Kconfig
> index 6adf1453548..eb19c94c7d4 100644
> --- a/target/mips/Kconfig
> +++ b/target/mips/Kconfig
> @@ -1,5 +1,6 @@
>  config MIPS
>      bool
> +    select SEMIHOSTING
>
>  config MIPS64
>      bool
> diff --git a/target/nios2/Kconfig b/target/nios2/Kconfig
> index 1529ab8950d..c65550c861a 100644
> --- a/target/nios2/Kconfig
> +++ b/target/nios2/Kconfig
> @@ -1,2 +1,3 @@
>  config NIOS2
>      bool
> +    select SEMIHOSTING
> diff --git a/target/riscv/Kconfig b/target/riscv/Kconfig
> index b9e5932f13f..adb7de3f37d 100644
> --- a/target/riscv/Kconfig
> +++ b/target/riscv/Kconfig
> @@ -1,5 +1,7 @@
>  config RISCV32
>      bool
> +    select ARM_COMPATIBLE_SEMIHOSTING # for do_common_semihosting()
>
>  config RISCV64
>      bool
> +    select ARM_COMPATIBLE_SEMIHOSTING # for do_common_semihosting()
> diff --git a/target/xtensa/Kconfig b/target/xtensa/Kconfig
> index a3c8dc7f6d7..5e46049262d 100644
> --- a/target/xtensa/Kconfig
> +++ b/target/xtensa/Kconfig
> @@ -1,2 +1,3 @@
>  config XTENSA
>      bool
> +    select SEMIHOSTING
> --
> 2.43.0
>
>

