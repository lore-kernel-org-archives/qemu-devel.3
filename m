Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D046E776F0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 18:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYTkk-0002ZE-Nq; Wed, 24 Dec 2025 13:38:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vYTki-0002TD-27
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 13:38:28 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vYTke-0005Fy-S2
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 13:38:27 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-64c893f3a94so6227853a12.0
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 10:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766601503; x=1767206303; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v9xCD7U7/dSlIZeeZ/6BGMZARlgT8coK9qlYuTEfKCw=;
 b=s0Gv8CY1P7ePWbg6ci5csNU1W24mHFk/pDQDmaK/ATy6IziTqje9w/vlycvqpvgWmI
 UquBWC87YGufcTP1PWgjP2hEwYPKi0p6mIJCHqcBqAtmHFlU29LnkRL3pBAWnDYQEErz
 DA7EVHC7EhIJF74+RG080IZVKlHimOCVehY1GllX4ZvTpI4VwVGUfv2qe8o4YywBiQZK
 FkXPshJsUhXvWZfKg3VFokA6Hi2xbX41zQ2+eTPfXDOYuNOdzCpaZy1UbPholnaoEc2h
 zpQzIClVWbxUWngtPloaz+vBSgoCE9qOCgKgdNDYWnz3xBvHna+FzmwR9Envi3MZHNsx
 EO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766601503; x=1767206303;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v9xCD7U7/dSlIZeeZ/6BGMZARlgT8coK9qlYuTEfKCw=;
 b=XlDfDMaShutTW4UKZWBCjwoXsDFwUOI/0duPuCUmEX9L9lI4YhBqUT2Be5O6zV3Ys+
 53PXV1wTcX13JJWOC9VavBVinT6rPTXO9yLYf5TiYcgZWQ8Qwday1zLDwe7Qw0a/Db6k
 eqs3y4X+BcCvhfgFGUp6Gg9N08KBLLUE4Krks69zPDey3cd2cs2Vhx8Of2GtTqR0OwpR
 +lPYU1ks5NFtTYxhmXTMT2nxZ0evWBZ8erxczxOHezfqVxH3/LVHePEAozWoLHN/9662
 T7NTg7Zm7nSDukd4k7x5aimYvb40OabZ2pTsOW4KO78P1IPsxumusUZqTZWf95ssRa/i
 wKfw==
X-Gm-Message-State: AOJu0YzYhBwe9+lyOQLHAag7C9+ecSRu7x+NZRywwWJPuJ6uemordNbQ
 3SB5Dy3SaNwWlnZuS0clGNi+tTXhO3AGxDRgOI+Z/mkECHQiU238sVl0s6rAcCs+DoqRMY9tLVQ
 ji1T83OKLny4wkllTW5HrAgWN7mn0XVD73hQYRHZPvg==
X-Gm-Gg: AY/fxX6agwXyVHjHAYFNs2IoyaBlov87FAwNHRVI2+eC3AcmCF0/V2W+B4wmzGL+id+
 A5PjcQDv6WVC965GTobhZN5ir3yg5pOr4fXGvdbwjQKDmzL3DgRUstOqJuYFBM209r1tGMprHye
 fSFpJVgpcDa29gCHkhOIYG6O4xkC3Alhc0jLECV47p+M2Tsvjsj2T/jC0XB9EMTrJFRFEhLV91X
 9y7UYGNO+6diBwnbzjU/+paY13knrZ1io9GvZwfztW8ReghtsxG9/383RJrald7WtBzvMQ=
X-Google-Smtp-Source: AGHT+IGPsjnHq0hIUa1OSg+yf340C5m78uKM/aPgpEm1hRL4pDJEvguORboZ36NCm4bv8Sg/xFAy30qcclXUWd8ckD0=
X-Received: by 2002:a17:906:fe0d:b0:b70:d1ea:2748 with SMTP id
 a640c23a62f3a-b802043fd32mr2546139366b.11.1766601503098; Wed, 24 Dec 2025
 10:38:23 -0800 (PST)
MIME-Version: 1.0
References: <20251224151351.86733-1-philmd@linaro.org>
 <20251224151351.86733-10-philmd@linaro.org>
In-Reply-To: <20251224151351.86733-10-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 24 Dec 2025 20:37:57 +0200
X-Gm-Features: AQt7F2rxur4AuRuJCQLzN5yRKQWL7uU37JCgGTvn_3KurxuMPh85EjxdqtydxA0
Message-ID: <CAAjaMXZf2kxQD4nxKLiSy92drd1VNbyPYNr92s=np_boSOOj6w@mail.gmail.com>
Subject: Re: [PATCH 9/9] configs/targets: Mark targets not using legacy
 ldst_phys() API
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Andrew Jeffery <andrew@codeconstruct.com.au>,
 qemu-arm@nongnu.org, 
 Peter Xu <peterx@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Weiwei Li <liwei1518@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Anton Johansson <anjo@rev.ng>, 
 David Hildenbrand <david@kernel.org>, qemu-riscv@nongnu.org, 
 Steven Lee <steven_lee@aspeedtech.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Troy Lee <leetroy@gmail.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Alistair Francis <alistair.francis@wdc.com>, Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Dec 24, 2025 at 5:15=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> These targets were only using the legacy ldst_phys() API
> via the virtio load/store helpers, which got cleaned up.
>
> Mark them not using the legacy ldst_phys() API to avoid
> further use, allowing to eventually remove it.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Nice cleanup!

>  configs/targets/mips-softmmu.mak     | 1 +
>  configs/targets/mips64-softmmu.mak   | 1 +
>  configs/targets/mips64el-softmmu.mak | 1 +
>  configs/targets/mipsel-softmmu.mak   | 1 +
>  configs/targets/or1k-softmmu.mak     | 1 +
>  configs/targets/riscv32-softmmu.mak  | 1 +
>  configs/targets/riscv64-softmmu.mak  | 1 +
>  configs/targets/sh4-softmmu.mak      | 1 +
>  configs/targets/sh4eb-softmmu.mak    | 1 +
>  configs/targets/sparc64-softmmu.mak  | 1 +
>  configs/targets/xtensa-softmmu.mak   | 1 +
>  configs/targets/xtensaeb-softmmu.mak | 1 +
>  12 files changed, 12 insertions(+)
>
> diff --git a/configs/targets/mips-softmmu.mak b/configs/targets/mips-soft=
mmu.mak
> index c9588066b8d..95397af9442 100644
> --- a/configs/targets/mips-softmmu.mak
> +++ b/configs/targets/mips-softmmu.mak
> @@ -1,3 +1,4 @@
>  TARGET_ARCH=3Dmips
>  TARGET_BIG_ENDIAN=3Dy
>  TARGET_LONG_BITS=3D32
> +TARGET_NOT_USING_LEGACY_LDST_PHYS_API=3Dy
> diff --git a/configs/targets/mips64-softmmu.mak b/configs/targets/mips64-=
softmmu.mak
> index 7202655fcac..f9cc41b9ed4 100644
> --- a/configs/targets/mips64-softmmu.mak
> +++ b/configs/targets/mips64-softmmu.mak
> @@ -2,3 +2,4 @@ TARGET_ARCH=3Dmips64
>  TARGET_BASE_ARCH=3Dmips
>  TARGET_BIG_ENDIAN=3Dy
>  TARGET_LONG_BITS=3D64
> +TARGET_NOT_USING_LEGACY_LDST_PHYS_API=3Dy
> diff --git a/configs/targets/mips64el-softmmu.mak b/configs/targets/mips6=
4el-softmmu.mak
> index 3ebeadb29ea..4e7dedc5f30 100644
> --- a/configs/targets/mips64el-softmmu.mak
> +++ b/configs/targets/mips64el-softmmu.mak
> @@ -1,3 +1,4 @@
>  TARGET_ARCH=3Dmips64
>  TARGET_BASE_ARCH=3Dmips
>  TARGET_LONG_BITS=3D64
> +TARGET_NOT_USING_LEGACY_LDST_PHYS_API=3Dy
> diff --git a/configs/targets/mipsel-softmmu.mak b/configs/targets/mipsel-=
softmmu.mak
> index 90e09bdc3e5..b0fba8a9d0a 100644
> --- a/configs/targets/mipsel-softmmu.mak
> +++ b/configs/targets/mipsel-softmmu.mak
> @@ -1,2 +1,3 @@
>  TARGET_ARCH=3Dmips
>  TARGET_LONG_BITS=3D32
> +TARGET_NOT_USING_LEGACY_LDST_PHYS_API=3Dy
> diff --git a/configs/targets/or1k-softmmu.mak b/configs/targets/or1k-soft=
mmu.mak
> index 0e47d9878b0..89f81b75bf7 100644
> --- a/configs/targets/or1k-softmmu.mak
> +++ b/configs/targets/or1k-softmmu.mak
> @@ -3,3 +3,4 @@ TARGET_BIG_ENDIAN=3Dy
>  # needed by boot.c and all boards
>  TARGET_NEED_FDT=3Dy
>  TARGET_LONG_BITS=3D32
> +TARGET_NOT_USING_LEGACY_LDST_PHYS_API=3Dy
> diff --git a/configs/targets/riscv32-softmmu.mak b/configs/targets/riscv3=
2-softmmu.mak
> index db55275b868..7476e596082 100644
> --- a/configs/targets/riscv32-softmmu.mak
> +++ b/configs/targets/riscv32-softmmu.mak
> @@ -4,3 +4,4 @@ TARGET_XML_FILES=3D gdb-xml/riscv-32bit-cpu.xml gdb-xml/r=
iscv-32bit-fpu.xml gdb-xm
>  # needed by boot.c
>  TARGET_NEED_FDT=3Dy
>  TARGET_LONG_BITS=3D32
> +TARGET_NOT_USING_LEGACY_LDST_PHYS_API=3Dy
> diff --git a/configs/targets/riscv64-softmmu.mak b/configs/targets/riscv6=
4-softmmu.mak
> index 2bdd4a62cd2..f836f08c5b9 100644
> --- a/configs/targets/riscv64-softmmu.mak
> +++ b/configs/targets/riscv64-softmmu.mak
> @@ -5,3 +5,4 @@ TARGET_XML_FILES=3D gdb-xml/riscv-64bit-cpu.xml gdb-xml/r=
iscv-32bit-fpu.xml gdb-xm
>  # needed by boot.c
>  TARGET_NEED_FDT=3Dy
>  TARGET_LONG_BITS=3D64
> +TARGET_NOT_USING_LEGACY_LDST_PHYS_API=3Dy
> diff --git a/configs/targets/sh4-softmmu.mak b/configs/targets/sh4-softmm=
u.mak
> index 787d349b501..e0b51f8108d 100644
> --- a/configs/targets/sh4-softmmu.mak
> +++ b/configs/targets/sh4-softmmu.mak
> @@ -1,2 +1,3 @@
>  TARGET_ARCH=3Dsh4
>  TARGET_LONG_BITS=3D32
> +TARGET_NOT_USING_LEGACY_LDST_PHYS_API=3Dy
> diff --git a/configs/targets/sh4eb-softmmu.mak b/configs/targets/sh4eb-so=
ftmmu.mak
> index cdea2c61c58..7850dac8191 100644
> --- a/configs/targets/sh4eb-softmmu.mak
> +++ b/configs/targets/sh4eb-softmmu.mak
> @@ -1,3 +1,4 @@
>  TARGET_ARCH=3Dsh4
>  TARGET_BIG_ENDIAN=3Dy
>  TARGET_LONG_BITS=3D32
> +TARGET_NOT_USING_LEGACY_LDST_PHYS_API=3Dy
> diff --git a/configs/targets/sparc64-softmmu.mak b/configs/targets/sparc6=
4-softmmu.mak
> index d9d51d21e59..8ee6d057682 100644
> --- a/configs/targets/sparc64-softmmu.mak
> +++ b/configs/targets/sparc64-softmmu.mak
> @@ -3,3 +3,4 @@ TARGET_BASE_ARCH=3Dsparc
>  TARGET_BIG_ENDIAN=3Dy
>  TARGET_XML_FILES=3Dgdb-xml/sparc64-core.xml
>  TARGET_LONG_BITS=3D64
> +TARGET_NOT_USING_LEGACY_LDST_PHYS_API=3Dy
> diff --git a/configs/targets/xtensa-softmmu.mak b/configs/targets/xtensa-=
softmmu.mak
> index 2a9797338a6..6aad751e2ba 100644
> --- a/configs/targets/xtensa-softmmu.mak
> +++ b/configs/targets/xtensa-softmmu.mak
> @@ -1,2 +1,3 @@
>  TARGET_ARCH=3Dxtensa
>  TARGET_LONG_BITS=3D32
> +TARGET_NOT_USING_LEGACY_LDST_PHYS_API=3Dy
> diff --git a/configs/targets/xtensaeb-softmmu.mak b/configs/targets/xtens=
aeb-softmmu.mak
> index 5204729af8b..537407e11ae 100644
> --- a/configs/targets/xtensaeb-softmmu.mak
> +++ b/configs/targets/xtensaeb-softmmu.mak
> @@ -1,3 +1,4 @@
>  TARGET_ARCH=3Dxtensa
>  TARGET_BIG_ENDIAN=3Dy
>  TARGET_LONG_BITS=3D32
> +TARGET_NOT_USING_LEGACY_LDST_PHYS_API=3Dy
> --
> 2.52.0
>

