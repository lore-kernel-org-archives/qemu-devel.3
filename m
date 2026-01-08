Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 917F8D1D482
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 17:08:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdtSz-0002hw-DE; Thu, 08 Jan 2026 12:06:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vdtSv-0002YE-G4
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 12:06:29 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vdtSs-0007W7-1D
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 12:06:28 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47775fb6c56so32304315e9.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 09:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767891984; x=1768496784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mQjzKNAy6CG28NG8GNTB3HMPJ8m0jDO+Hq3BSKSnCUM=;
 b=tiyDQLR0+5r88kUlSu2VmZCL2Zj7WGToscCAWRYUO0X0RLojmiAkVg1Xgg617gNluz
 C6QiKSO6ihmuKubVUYD+y/Q+DU5GrLucUcr1YGuSglX/myKLWfo1LkM4y3wrkFX/Fhno
 +0VeED762qmZfch9CTm42DYizgw38I7/mRRu64c3KW/Bi1tEPIQycwapy4wMPcQPintJ
 YSZ/Wrexq5o0fsRz+k529HWkzmuSxcns/oYbwFCgm/VGhLA9RPugAzrgJgc49i3LKOw8
 KhkH5Q/sA/c29a/tm7SNgXfKsrWFSpESr7xKrTYKcDDgxJLgWauT3JRk73qEZnSry4Dj
 fhBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767891984; x=1768496784;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mQjzKNAy6CG28NG8GNTB3HMPJ8m0jDO+Hq3BSKSnCUM=;
 b=MupNUXneFj1XSPnaBK5+RPR+s4y4ot0d5+Eh3SUgY2Y5khk2En8nV0oZ+i7eU7XaWZ
 gtpBYp2i4uysJX6gIDEUphFiHe7hDQYKPobJuG71/9I8hBnOeV2l0u10IHhoUymRD0/R
 tPdQLU7tsKH3SW3h81XuMKmQ52iOzcqIQUEBKbik5BzUHJ2YTG+qsVrdtjXd7P0gctpP
 ojIHqolmq7BRXOTbUcVDY2FMrnIslhEMByHgMIugCRRPs0w3OvrKK6Lhmp5gWgKleYoe
 s7TT8FxvB3sBxL9Tj94ritk2kciWBSQf1dXWUAcrFCNpK5SXvs6/O5nNBwhxwxpw0kjm
 9BKQ==
X-Gm-Message-State: AOJu0YyopGA/0HZURZAmGqNdAZLGsB1jWmFAf8bHGoGZfFr9ZdMmIy47
 thed3xjw/sp1f7CjdZxO1F/z/e0P47gUtzMWV7MOqP6i6vXX1PS3FwQYgoUx8ic10Mk=
X-Gm-Gg: AY/fxX7VEVwpCE+bN4Epvxd/OmYBE4zDKV0dlGwc1bgu6TsvzpXR7uwbuP3MgdltwH3
 IAup5naxRkJVL1WzaCoiyXty+/DbWUXF1SS1AbOueWjUNszuPuB1RBa3dARb+YbJ7aI/7xUx+fz
 +ibwBPWZ79eSsu7NrbhBqnhE9SgY6xfAZA6IT8rW0nynjpjJOXNMUm3s3I6Hxf7TXjMpiJ50w4C
 Pk2Z2MDl8/SvVkFX0z6lp9NvFjfvNovL14g+KZbX7B66vQrcBLrpIdAKjIMeAMUh9jMxiauuFGM
 Ukk5YUpEGVN981wJu5DfTaEOgI7ndunP/v4dBJh4+ATczyYsmUvHdoK1Vhu7NqfgEDpqUb9pOm5
 pk4mWeQv1ZboNtAuz7LFkd6vACy+BFTl4C3/NwSfgSt0/16YMSdpH1hY1ch5z+kejABlh3yQySI
 MTSs72N+RQzSc=
X-Google-Smtp-Source: AGHT+IGnmzr1bseGU2OtbvMfCwNBKDuJ/WWGTWtl7xC8EETvQR6U0m0gRbT48Qb5msp4Gdir09RkSg==
X-Received: by 2002:a05:600c:1992:b0:477:7c7d:d9b2 with SMTP id
 5b1f17b1804b1-47d84b4a815mr86456565e9.32.1767891981042; 
 Thu, 08 Jan 2026 09:06:21 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ede7esm17279987f8f.32.2026.01.08.09.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 09:06:20 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A11465F804;
 Thu, 08 Jan 2026 17:06:19 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  =?utf-8?Q?Ma?=
 =?utf-8?Q?rc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v3] system: Convert qemu_arch_available() to TargetInfo API
In-Reply-To: <20260108163601.18676-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 8 Jan 2026 17:36:00
 +0100")
References: <20260108163601.18676-1-philmd@linaro.org>
User-Agent: mu4e 1.12.14; emacs 30.1
Date: Thu, 08 Jan 2026 17:06:19 +0000
Message-ID: <87ikdc825w.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Get the base arch_mask from the current SysEmuTarget,
> making qemu_arch_available() target-agnostic.
>
> We don't need the per-target QEMU_ARCH definition anymore,
> remove it.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> v3: Return directly within switch
> v2: Prefer switch over array (pbo)
> ---
>  meson.build        |  2 --
>  system/arch_init.c | 30 -----------------------
>  target-info.c      | 60 ++++++++++++++++++++++++++++++++++++++++++++++
>  system/meson.build |  1 -
>  4 files changed, 60 insertions(+), 33 deletions(-)
>  delete mode 100644 system/arch_init.c
>
> diff --git a/meson.build b/meson.build
> index 734c801cc77..435dc6e3c8e 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3419,8 +3419,6 @@ foreach target : target_dirs
>        config_target_data.set(k, v)
>      endif
>    endforeach
> -  config_target_data.set('QEMU_ARCH',
> -                         'QEMU_ARCH_' + config_target['TARGET_BASE_ARCH'=
].to_upper())
>    config_target_h +=3D {target: configure_file(output: target + '-config=
-target.h',
>                                                 configuration: config_tar=
get_data)}
>=20=20
> diff --git a/system/arch_init.c b/system/arch_init.c
> deleted file mode 100644
> index e85736884c9..00000000000
> --- a/system/arch_init.c
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -/*
> - * QEMU System Emulator
> - *
> - * Copyright (c) 2003-2008 Fabrice Bellard
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> - * of this software and associated documentation files (the "Software"),=
 to deal
> - * in the Software without restriction, including without limitation the=
 rights
> - * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> - * copies of the Software, and to permit persons to whom the Software is
> - * furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be includ=
ed in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> - * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> - * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> - * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
> - * THE SOFTWARE.
> - */
> -#include "qemu/osdep.h"
> -#include "system/arch_init.h"
> -
> -bool qemu_arch_available(unsigned qemu_arch_mask)
> -{
> -    return qemu_arch_mask & QEMU_ARCH;
> -}
> diff --git a/target-info.c b/target-info.c
> index 24696ff4111..774fdcd2c46 100644
> --- a/target-info.c
> +++ b/target-info.c
> @@ -11,6 +11,7 @@
>  #include "qemu/target-info-qapi.h"
>  #include "qemu/target-info-impl.h"
>  #include "qapi/error.h"
> +#include "system/arch_init.h"
>=20=20
>  const char *target_name(void)
>  {
> @@ -33,6 +34,65 @@ SysEmuTarget target_arch(void)
>      return arch;
>  }
>

This looks fine to me but I note the API takes a mask which implies you
could potentially pass multiple arches in the mask. Not an issue now but
we should probably add a kdoc to the declaration to make it clear you
can only test one arch at a time for now.

> +bool qemu_arch_available(unsigned qemu_arch_mask)
> +{
> +    switch (target_arch()) {
> +    case SYS_EMU_TARGET_ALPHA:
> +        return qemu_arch_mask & QEMU_ARCH_ALPHA;
> +    case SYS_EMU_TARGET_ARM:
> +    case SYS_EMU_TARGET_AARCH64:
> +        return qemu_arch_mask & QEMU_ARCH_ARM;
> +    case SYS_EMU_TARGET_I386:
> +    case SYS_EMU_TARGET_X86_64:
> +        return qemu_arch_mask & QEMU_ARCH_I386;
> +    case SYS_EMU_TARGET_M68K:
> +        return qemu_arch_mask & QEMU_ARCH_M68K;
> +    case SYS_EMU_TARGET_MICROBLAZE:
> +    case SYS_EMU_TARGET_MICROBLAZEEL:
> +        return qemu_arch_mask & QEMU_ARCH_MICROBLAZE;
> +    case SYS_EMU_TARGET_MIPS:
> +    case SYS_EMU_TARGET_MIPSEL:
> +    case SYS_EMU_TARGET_MIPS64:
> +    case SYS_EMU_TARGET_MIPS64EL:
> +        return qemu_arch_mask & QEMU_ARCH_MIPS;
> +    case SYS_EMU_TARGET_PPC:
> +    case SYS_EMU_TARGET_PPC64:
> +        return qemu_arch_mask & QEMU_ARCH_PPC;
> +    case SYS_EMU_TARGET_S390X:
> +        return qemu_arch_mask & QEMU_ARCH_S390X;
> +    case SYS_EMU_TARGET_SH4:
> +    case SYS_EMU_TARGET_SH4EB:
> +        return qemu_arch_mask & QEMU_ARCH_SH4;
> +    case SYS_EMU_TARGET_SPARC:
> +    case SYS_EMU_TARGET_SPARC64:
> +        return qemu_arch_mask & QEMU_ARCH_SPARC;
> +    case SYS_EMU_TARGET_XTENSA:
> +    case SYS_EMU_TARGET_XTENSAEB:
> +        return qemu_arch_mask & QEMU_ARCH_XTENSA;
> +    case SYS_EMU_TARGET_OR1K:
> +        return qemu_arch_mask & QEMU_ARCH_OPENRISC;
> +    case SYS_EMU_TARGET_TRICORE:
> +        return qemu_arch_mask & QEMU_ARCH_TRICORE;
> +    case SYS_EMU_TARGET_HPPA:
> +        return qemu_arch_mask & QEMU_ARCH_HPPA;
> +    case SYS_EMU_TARGET_RISCV32:
> +    case SYS_EMU_TARGET_RISCV64:
> +        return qemu_arch_mask & QEMU_ARCH_RISCV;
> +    case SYS_EMU_TARGET_RX:
> +        return qemu_arch_mask & QEMU_ARCH_RX;
> +    case SYS_EMU_TARGET_AVR:
> +        return qemu_arch_mask & QEMU_ARCH_AVR;
> +    /*
> +    case SYS_EMU_TARGET_HEXAGON:
> +        return qemu_arch_mask & QEMU_ARCH_HEXAGON;
> +    */
> +    case SYS_EMU_TARGET_LOONGARCH64:
> +        return qemu_arch_mask & QEMU_ARCH_LOONGARCH;
> +    default:
> +        g_assert_not_reached();
> +    };
> +}
> +
>  const char *target_cpu_type(void)
>  {
>      return target_info()->cpu_type;
> diff --git a/system/meson.build b/system/meson.build
> index 4b69ef0f5fb..66e16db55ce 100644
> --- a/system/meson.build
> +++ b/system/meson.build
> @@ -1,5 +1,4 @@
>  specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
> -  'arch_init.c',
>    'globals-target.c',
>  )])

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

