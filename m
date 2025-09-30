Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4355CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 08:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3VPu-0002wA-Gj; Tue, 30 Sep 2025 04:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1v3VPs-0002vn-RJ
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:08:56 -0400
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1v3VPo-0004PC-Sc
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:08:56 -0400
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-78ed682e9d3so46882946d6.0
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 01:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759219727; x=1759824527; darn=nongnu.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vJaksouiyMfTHD4z0d03GiWY3BZU6fWy1Ci2px2ary4=;
 b=hWOrF/EDnt21i5v6fbI4tUMh56dnQh2k4XGEPIdt1ndveaGsh1nkxJ6vM10R7ylXOk
 bphCVP1OtexwO+wMUigiJqK2He3oVyBsyBOwEmPoSERVFQkhR9T70VGiIFL4ErztuP+k
 4h0A4Vvulod1iWbKFODYxOpI1ZMdeAy412H2qAGf2x/28U/e/cjc4T62fosv/NWOTnFd
 YWxNiMYoqQNfUEpctAkwSnPGDApubHXyqo+68EIpvIe9KONGIAqMf7shCZAsIW2YfCtc
 DwjGegnEI7Apv25debJ+OPThmuzE/yZQHQrf+e/PgoH8YTpiBoKjMAs308zeZoRVt+lR
 BMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759219727; x=1759824527;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vJaksouiyMfTHD4z0d03GiWY3BZU6fWy1Ci2px2ary4=;
 b=BaEiK/JYNiXMsVUsir3eRKFi9UOkmBpsVGHUxLa7Y7Ssisq+0XDPh/Pwdej/At6tpu
 /E37qTeVANRwoxTomKR/lDX6WOxa4lqYftqGv3+E+5k6cVCMZpIog0EG485pZix9JlF3
 2JcJmEQf0WahvOynM76qq+gB2E1dpu91bOrBsSn9yvUWAp7QfRCt7yXfa+CBg7qYBCTT
 RwL6DR1V9q/lUCSbaAmh+i1Rx4PtlKjB9nHlrE4m0wSEBelLQL5RF3QkdqeYhn4kAqpp
 7+w7LMavQCamPjotRpa2bQGN3JRaqHIoNMF+DY39ufM+CL43CNXR8nS71h+NPRumsK1a
 Aizw==
X-Gm-Message-State: AOJu0Yw564e2ks7y9moc0rwO1C7PoaTMCiobRnooTOGTA0jHBYZNg4Se
 +5fY1PyKmAjBR7jcWdcjaffVb5KqyErt1MdDDdod1yG6er3E1zVFLncdIsGdIg6+fGbjPjAtME3
 G9+HIXDiRplf2C8LX3p9NQFIEemagPZyBWTpfcKE=
X-Gm-Gg: ASbGncub2tyXHKDT5NsJgrUDfg0AwS6UD9vhMb6Jt6NKX3okeo40QLb1m1WC5LvngAf
 tEL0k/XkCVnaZip9hWdmSj9Ucb1yZIiN9INjfUuCT6V2dAqoLEyO0+1en/rcEs38tCyvVDiBI1a
 awn6SDy59KEKTzdOrkwtDd3XMvB+JGVQ9PrL5iL7lggbusGUk1YEbROb6PiSlBhcCWzZaQevy1L
 9TxbM0kboxxmS7x95ReOl1m7GTBFaDU7XX5W2UNEf3BHPVaKUmuvtk2EluefXSSFwe/ukFlilw=
X-Google-Smtp-Source: AGHT+IFW1bPNdM6TwwzA1HmG10Y8Fx1Kz3vk6LoIzvqKj8NOYAtZmcPeDjTillLnMuyffXg3qSs/Misda1cpf/Pw9ao=
X-Received: by 2002:a05:6214:f0b:b0:7f5:b2b6:2a2f with SMTP id
 6a1803df08f44-7fc45172872mr279514186d6.67.1759219727221; Tue, 30 Sep 2025
 01:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250924120426.2158655-1-marcandre.lureau@redhat.com>
 <20250924120426.2158655-8-marcandre.lureau@redhat.com>
In-Reply-To: <20250924120426.2158655-8-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 30 Sep 2025 12:08:35 +0400
X-Gm-Features: AS18NWBdDaxDvGuPjmA7yd5a2ybjIG9hU43w42kWy0aLHgKJabw90hJgkQ7f8GI
Message-ID: <CAJ+F1CK0gvJ_RFdhK-dHkB31KTskbFZNZfZpA=z=frP9uhzahg@mail.gmail.com>
Subject: Re: [PATCH v2 07/27] configure: set the bindgen cross target
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qv1-xf2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Wed, Sep 24, 2025 at 4:08=E2=80=AFPM <marcandre.lureau@redhat.com> wrote=
:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Implement a bash version of rust-bindgen rust_to_clang_target() to
> convert from rust target to clang target.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Paolo, ack?

> ---
>  configure                            |  7 ++++
>  scripts/rust-to-clang-target-test.sh | 43 +++++++++++++++++++
>  scripts/rust-to-clang-target.sh      | 62 ++++++++++++++++++++++++++++
>  3 files changed, 112 insertions(+)
>  create mode 100755 scripts/rust-to-clang-target-test.sh
>  create mode 100644 scripts/rust-to-clang-target.sh
>
> diff --git a/configure b/configure
> index 66613f3f4c..bf964947b8 100755
> --- a/configure
> +++ b/configure
> @@ -1878,6 +1878,13 @@ if test "$skip_meson" =3D no; then
>        eval "c=3D\$devices_${a}"
>        echo "${a}-softmmu =3D '$c'" >> $cross
>    done
> +  if test "$rust" !=3D disabled; then
> +      if test "$cross_compile" =3D "yes"; then
> +          . "$source_path/scripts/rust-to-clang-target.sh"
> +          clang_target=3D$(rust_to_clang_target "$rust_target_triple")
> +          echo "bindgen_clang_arguments =3D [$(meson_quote --target=3D"$=
clang_target")]" >> $cross
> +      fi
> +  fi
>
>    echo "[built-in options]" >> $cross
>    echo "c_args =3D [$(meson_quote $CFLAGS $EXTRA_CFLAGS)]" >> $cross
> diff --git a/scripts/rust-to-clang-target-test.sh b/scripts/rust-to-clang=
-target-test.sh
> new file mode 100755
> index 0000000000..ff6f8fcdc5
> --- /dev/null
> +++ b/scripts/rust-to-clang-target-test.sh
> @@ -0,0 +1,43 @@
> +#!/usr/bin/env sh
> +#
> +# Copyright (C) 2025 Red Hat, Inc.
> +#
> +# Based on rust_to_clang_target() tests from rust-bindgen.
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +scripts_dir=3D$(CDPATH=3D cd -- "$(dirname -- "$0")" && pwd)
> +. "$scripts_dir/rust-to-clang-target.sh"
> +
> +test_case() {
> +    input=3D"$1"
> +    expected=3D"$2"
> +    result=3D$(rust_to_clang_target "$input")
> +
> +    if [ "$result" =3D "$expected" ]; then
> +        echo " OK: '$input' -> '$result'"
> +    else
> +        echo " FAILED: '$input'"
> +        echo "  Expected: '$expected'"
> +        echo "  Got:      '$result'"
> +        exit 1
> +    fi
> +}
> +
> +echo "Running tests..."
> +
> +test_case "aarch64-apple-ios" "arm64-apple-ios"
> +test_case "riscv64gc-unknown-linux-gnu" "riscv64-unknown-linux-gnu"
> +test_case "riscv64imac-unknown-none-elf" "riscv64-unknown-none-elf"
> +test_case "riscv32imc-unknown-none-elf" "riscv32-unknown-none-elf"
> +test_case "riscv32imac-unknown-none-elf" "riscv32-unknown-none-elf"
> +test_case "riscv32imafc-unknown-none-elf" "riscv32-unknown-none-elf"
> +test_case "riscv32i-unknown-none-elf" "riscv32-unknown-none-elf"
> +test_case "riscv32imc-esp-espidf" "riscv32-esp-elf"
> +test_case "xtensa-esp32-espidf" "xtensa-esp32-elf"
> +test_case "aarch64-apple-ios-sim" "arm64-apple-ios-simulator"
> +test_case "aarch64-apple-tvos-sim" "arm64-apple-tvos-simulator"
> +test_case "aarch64-apple-watchos-sim" "arm64-apple-watchos-simulator"
> +
> +echo ""
> +echo "All tests passed!"
> diff --git a/scripts/rust-to-clang-target.sh b/scripts/rust-to-clang-targ=
et.sh
> new file mode 100644
> index 0000000000..5451807888
> --- /dev/null
> +++ b/scripts/rust-to-clang-target.sh
> @@ -0,0 +1,62 @@
> +#!/usr/bin/env sh
> +#
> +# Copyright (C) 2025 Red Hat, Inc.
> +#
> +# Based on rust_to_clang_target() from rust-bindgen.
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +rust_to_clang_target() {
> +    rust_target=3D"$1"
> +
> +    # Split the string by hyphens
> +    triple_parts=3D""
> +    old_IFS=3D"$IFS"
> +    IFS=3D'-'
> +    for part in $rust_target; do
> +        triple_parts=3D"$triple_parts $part"
> +    done
> +    IFS=3D"$old_IFS"
> +    set -- $triple_parts
> +
> +    # RISC-V
> +    case "$1" in
> +        riscv32*)
> +            set -- "riscv32" "${2}" "${3}" "${4}"
> +            ;;
> +        riscv64*)
> +            set -- "riscv64" "${2}" "${3}" "${4}"
> +            ;;
> +    esac
> +
> +    # Apple
> +    if [ "$2" =3D "apple" ]; then
> +        if [ "$1" =3D "aarch64" ]; then
> +            set -- "arm64" "${2}" "${3}" "${4}"
> +        fi
> +        if [ "$4" =3D "sim" ]; then
> +            set -- "${1}" "${2}" "${3}" "simulator"
> +        fi
> +    fi
> +
> +    # ESP-IDF
> +    if [ "$3" =3D "espidf" ]; then
> +        set -- "${1}" "${2}" "elf" "${4}"
> +    fi
> +
> +    # Reassemble the string
> +    new_triple=3D""
> +    first=3D1
> +    for part in "$@"; do
> +        if [ -n "$part" ]; then
> +            if [ "$first" -eq 1 ]; then
> +                new_triple=3D"$part"
> +                first=3D0
> +            else
> +                new_triple=3D"$new_triple-$part"
> +            fi
> +        fi
> +    done
> +
> +    echo "$new_triple"
> +}
> --
> 2.51.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

