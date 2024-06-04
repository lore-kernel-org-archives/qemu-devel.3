Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382D7C25B74
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 03:24:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEKm5-0003KD-IQ; Mon, 03 Jun 2024 23:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEKm4-0003JV-S2; Mon, 03 Jun 2024 23:23:48 -0400
Received: from mail-vs1-xe31.google.com ([2607:f8b0:4864:20::e31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEKm3-0001hl-C8; Mon, 03 Jun 2024 23:23:48 -0400
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-48bdcecf6efso522259137.3; 
 Mon, 03 Jun 2024 20:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717471425; x=1718076225; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gRqDm73lezK5ItBSrk7ApZcs8MdvU9lRFQQIYl5N4NA=;
 b=l3hqHtm6o74OT1lhpPdYunMJSPX3oEKp9+vF9lQKV4GeGy1Mxi9+mQ6hRAnFBKaiYh
 VlrPw/4b0Gky9TRndm0rV7HfzbhqucChkU9mmLEBzh9bgUyIndDsH/Md5ItSMSeIOBB1
 Oyj/sYbBu9lAADWiGZI72S8ibAzz/VGhMV4lEt/MLU0J6gbLjKmBMo4FpuyNtizBU+uW
 DAINcxRyJ6BGGljWzmwnW8nS2CfcX9aV7AIisEMryasfalG9/EUhcFK92+RhvWiIF7Ia
 uRlTjNBhb2snpuUiQglQk7oc1pGpeex9ZI4GGAUjc3T370gyCmefZlOGIzQog9VXoWP1
 jUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717471425; x=1718076225;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gRqDm73lezK5ItBSrk7ApZcs8MdvU9lRFQQIYl5N4NA=;
 b=I+B1b6I6rajByGg8zkPUFyi1DyJ1b+ZHLEF8WjX7cXcvotIKk2MpEUTuGvIolpr8cu
 fjqCw8lhwDPBVwkAnkTkEQuERCi9FTVEKyQgQBlgOSUc9TBksa126jMPOwia63pDVlsh
 LPLibydU1HTmaTQXzVuDSabcBdknldqPEeNMQzfGwue44eGDm2KywFRcYeHXPZb+lv8x
 +RLJucujPHbP/NSXDoKmc9tlLyYsHudi0r13EV1aI15kmkLG3ov58z+pRHstJET9W4pJ
 drjSYTpQAwEjU2vn3itlvijEZKu99AGNgz50hduWywww+jl87yIZUJtlKuFsxlHTGhiO
 +RXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXy7VUMq7bHHQVSlDiihZVwiNRxWlG9eMuJBpTMxOm4fjRC46FUSXFOl4pMGJg/ZDkAwWJHnny9IYQj2ApxwHRkyBJi2UpiLIrozihTncY4UGLZ2quRhX/lPW0=
X-Gm-Message-State: AOJu0YzJM0VN1YepdT1auM3lcfVX8l11ubwBNKIZYcnlC1uVuG6VRGCe
 91nBIPXMwKw989RUwN9OBHRTUBJkEXhngX4odjQs3zxLkevYiQSD4N22wXH+V741yY6cvRqHyAJ
 5ERS+52NGwC5Y90fihc54XNnCu8g=
X-Google-Smtp-Source: AGHT+IFGHa4F+Kud+Za8oBgjoJ6IJ+pW8vZz0GuWhXp9kZfqNdSKC1zmMi6kXYXUwT6LkEp+JgjaWHmSQO2NvKLVz+o=
X-Received: by 2002:a67:ce81:0:b0:48a:31d7:656e with SMTP id
 ada2fe7eead31-48bc2367ae1mr10406613137.30.1717471425498; Mon, 03 Jun 2024
 20:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240524061411.341599-1-sunilvl@ventanamicro.com>
 <20240524061411.341599-2-sunilvl@ventanamicro.com>
In-Reply-To: <20240524061411.341599-2-sunilvl@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 4 Jun 2024 13:23:19 +1000
Message-ID: <CAKmqyKM=AUt+D379Arr2_RoH6b6DNAaJdJEDmOdry9QkavxzfQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] uefi-test-tools/UefiTestToolsPkg: Add RISC-V
 support
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Sia Jee Heng <jeeheng.sia@starfivetech.com>, Haibo1 Xu <haibo1.xu@intel.com>, 
 Anup Patel <apatel@ventanamicro.com>, Andrew Jones <ajones@ventanamicro.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e31;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe31.google.com
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

On Fri, May 24, 2024 at 4:14=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> Enable building the test application for RISC-V with appropriate
> dependencies updated.
>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/uefi-test-tools/UefiTestToolsPkg/UefiTestToolsPkg.dsc | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tests/uefi-test-tools/UefiTestToolsPkg/UefiTestToolsPkg.dsc =
b/tests/uefi-test-tools/UefiTestToolsPkg/UefiTestToolsPkg.dsc
> index c8511cd732..0902fd3c73 100644
> --- a/tests/uefi-test-tools/UefiTestToolsPkg/UefiTestToolsPkg.dsc
> +++ b/tests/uefi-test-tools/UefiTestToolsPkg/UefiTestToolsPkg.dsc
> @@ -19,7 +19,7 @@
>    PLATFORM_VERSION        =3D 0.1
>    PLATFORM_NAME           =3D UefiTestTools
>    SKUID_IDENTIFIER        =3D DEFAULT
> -  SUPPORTED_ARCHITECTURES =3D ARM|AARCH64|IA32|X64
> +  SUPPORTED_ARCHITECTURES =3D ARM|AARCH64|IA32|X64|RISCV64
>    BUILD_TARGETS           =3D DEBUG
>
>  [BuildOptions.IA32]
> @@ -60,6 +60,10 @@
>
>  [LibraryClasses.IA32, LibraryClasses.X64]
>    BaseMemoryLib|MdePkg/Library/BaseMemoryLibRepStr/BaseMemoryLibRepStr.i=
nf
> +  RegisterFilterLib|MdePkg/Library/RegisterFilterLibNull/RegisterFilterL=
ibNull.inf
> +
> +[LibraryClasses.RISCV64]
> +  BaseMemoryLib|MdePkg/Library/BaseMemoryLib/BaseMemoryLib.inf
>
>  [PcdsFixedAtBuild]
>    gEfiMdePkgTokenSpaceGuid.PcdDebugPrintErrorLevel|0x8040004F
> --
> 2.40.1
>

