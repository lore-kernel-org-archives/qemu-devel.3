Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC23DC25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 03:29:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEKqr-00069f-57; Mon, 03 Jun 2024 23:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEKqp-000698-HH; Mon, 03 Jun 2024 23:28:43 -0400
Received: from mail-vs1-xe30.google.com ([2607:f8b0:4864:20::e30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEKqn-0003sa-QO; Mon, 03 Jun 2024 23:28:43 -0400
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-48bcadbd790so1529687137.1; 
 Mon, 03 Jun 2024 20:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717471720; x=1718076520; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HZwwHuuvB97XosNx34W+gJN3A58SgWLSaycWvV/9O88=;
 b=FJk65/rrop2GIDPOWGVifcmgdzbXnff9ENwrZlpnGgUbYA/ZB49+u+er2awVX0AHpt
 p1a5v+VfO8VOzWsgmobshbCJxRpNBlxN3iQZIYVXPl9BlFIxqJjLvt/jHaDqy2VeXBah
 6iIrXu9lTyO8ngRyEuX9H1I6gaGWWdFvOL6ZMU48If+ZzsyfIJqJ2z6bMkkly8ChLO9O
 EClykSfssUIvRIJkOIhp0y+15hUm9hIFkHXGg/VCzRhOBq8gVCWXjwWPDWYKrYKrqu5D
 Xux9e+ulx+IhZYemWUAY0J4Ub7mWEWG9wnUHXUM92OhgIqT0k23dPqYuL1RJmEJxgeza
 rDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717471720; x=1718076520;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HZwwHuuvB97XosNx34W+gJN3A58SgWLSaycWvV/9O88=;
 b=MJaLK+cgUA4f8joTnBXtSE//yovFs1mLg5OImXm3wlx5y48/LubtOKXNmRj+WZNXEi
 Uf/eSpBSft6ffMMz7pbZTyUhmHzzAUDrOq56MFQQ/z2H0eerWS3dxzuUtKNLUoUBOiZq
 1mPvHjs/evIURKyxDxpS3bt2NRr+f+FkLh4K5GYFEEV7gT/nNxjnpu7K0VrVSsoa6RUp
 nvGcxPCgK8P+ISY/po0APE0dxjCuDut70xGoulzkvKTEYEX41S/1QCkvvpts7BXq6rG2
 70KdfkleZpbQDEd9dTwT9OhLzUg9IivJ4xkG+7aqr7qv+/br5n+/EbdlYea+SZU7Giq5
 IAKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFIpSYEBO7heilm+lltDtPwIH6jqS6sjhKuhjH0bny7U5I4Aw4M9JZ7obzAI1ecIEnl5Nz+OIDrq2QGk/2+eHmI7B9Pir20R8qC3lgQcLCek7YmsVVKs/vo88=
X-Gm-Message-State: AOJu0YyCka3tPgRzYC+bdPPAAXjbx7OzWeq8OO9NHsHXi3MbN8J/9Bv1
 QaI7QOtg9reEkRJfOZOnGfYNYfumi7ZyCQZIGHwXCbMnxz0EouFRW4h8yzRRxa0KPVs1onu5eDj
 LanlcnaCf98/TTCwtPtQH1qJb0mA=
X-Google-Smtp-Source: AGHT+IHvvhLZXa2Q8dzFahb2XYXupKYleSkIqwFuILEjISd5kRIhAdqq2t6r6q9uFC/eIt0uJzFCVZIf0VV+prCBE10=
X-Received: by 2002:a05:6102:5113:b0:48b:d13d:a0d3 with SMTP id
 ada2fe7eead31-48bf23546a3mr1559321137.11.1717471719895; Mon, 03 Jun 2024
 20:28:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240524061411.341599-1-sunilvl@ventanamicro.com>
 <20240524061411.341599-13-sunilvl@ventanamicro.com>
In-Reply-To: <20240524061411.341599-13-sunilvl@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 4 Jun 2024 13:28:13 +1000
Message-ID: <CAKmqyKOVJpD6r6-v8QPf7Nd=DNWjqAo5t9UF1K0K7AF-BacqHg@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] tests/qtest/bios-tables-test: Add expected ACPI
 data files for RISC-V
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::e30;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe30.google.com
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

On Fri, May 24, 2024 at 4:15=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> As per the step 5 in the process documented in bios-tables-test.c,
> generate the expected ACPI AML data files for RISC-V using the
> rebuild-expected-aml.sh script and update the
> bios-tables-test-allowed-diff.h.
>
> These are all new files being added for the first time. Hence, iASL diff
> output is not added.
>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/data/acpi/virt/riscv64/APIC           | Bin 0 -> 116 bytes
>  tests/data/acpi/virt/riscv64/DSDT           | Bin 0 -> 3518 bytes
>  tests/data/acpi/virt/riscv64/FACP           | Bin 0 -> 276 bytes
>  tests/data/acpi/virt/riscv64/MCFG           | Bin 0 -> 60 bytes
>  tests/data/acpi/virt/riscv64/RHCT           | Bin 0 -> 314 bytes
>  tests/data/acpi/virt/riscv64/SPCR           | Bin 0 -> 80 bytes
>  tests/qtest/bios-tables-test-allowed-diff.h |   6 ------
>  7 files changed, 6 deletions(-)
>
> diff --git a/tests/data/acpi/virt/riscv64/APIC b/tests/data/acpi/virt/ris=
cv64/APIC
> index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..66a25dfd2d6ea2b607c024722=
b2eab95873a01e9 100644
> GIT binary patch
> literal 116
> zcmZ<^@N_O=3DU|?X|;^gn_5v<@85#X!<1dKp25F13pfP@Mo12P{Zj?R|`s)2!c7=3Ds}J
> I#NvT*0o0BN0RR91
>
> literal 0
> HcmV?d00001
>
> diff --git a/tests/data/acpi/virt/riscv64/DSDT b/tests/data/acpi/virt/ris=
cv64/DSDT
> index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..0fb2d5e0e389541209b765d50=
92d0706f40298f6 100644
> GIT binary patch
> literal 3518
> zcmZvf%WvaU6vnR;w@IBxlQexl(t(j!ppl%0(ryq<oOYV3X-%9`q=3D14{b;M9K6c~^O
> zgcx<fqhd2ti4B_~D)B!c1W2sdvE#L7!#}_>eCJ*}oI`D?w!iChKA+$9t$orAn%(bn
> zN+n)t?0eh6a^of6TgGN7rRbcFh1Tyc_k%{iceZVNuIr}z+pT7<?)fc<HI?okw3^tr
> z>)qm0&dr&dmZB`a{a^Ra*0&D5Eo1b;X8Qm}E3gQ<btjYVdtTkbz7rISPX6ODvMUs3
> zVE91w&KfCiza7@#@A>YkTOF1_DRa)WNl^t#{A^TNmZNji{btZCtt5&QPNDqU;E!+b
> zecnEQ^xc;~?0jvN=3DB?69B6sx0n@1<N?!0~c*1N~|jvlD2+E~Xu>-LMCh<kUhvyXCD
> z|GVk1+UV8=3D+`16nn$W3iZBaGE(t=3DR0Su8V)L_|(iti)M3i8v3Jc_g_<E!HC$=3Ddr;&
> zZ0_+)tcM-v;WLjB?y(x{F%swTD)SiS9?!;ljK+DKGLIDZSc~;Y#d$nr9_i3y=3DNsQ^
> zu@zZ&*ReP}{EyK3th+T@*_*eqZ#4FX%O>b{iWO(USDtFAW3{YY{55g*p1P}!a8zWX
> z7lz;IPVBzpJS=3D7G%wV8y2Q62ba|`EHRm#%1lYm%>L=3DvK=3DN;x|_7+?*WxKL3R0`umY
> z&O>M<DHHxW7E8~>hKe$y(1g;N2-TU8l!<C|EEb%J4HacZp-Gd8P@M@$nW#v|VwsuP
> zP=3D$;-)Haz>@sOMoiwl`i1tW@cj+o4-cu3BPCB-VhD+4MD9hIDroD&Pl#Oi8OIy2%-
> zNlr-4iRFXLXr|LTGn$gL<b>p$V}cX!M^n3=3Dp)tt`$vN>NG_kr`M{qil6Owag1ZPHY
> zW+W#h=3DgbPutl-Q_PDsv)?-Htwo@Y*Q<|HR1=3DgbSvyx`1BPDsu<E;z>p=3DeXpA<eYfp
> zv*(GAkEvZhm4f7i<eWvpSrnW_$qC6hOM<f`I7^Zfl5<W7&I!ReAvqyAXIXHT1!q}u
> zLUPVY!8s{7CnYB&=3DbRFpQ-X6!azb*>X~8)yIHx5iB<DoK!Jg-g;GB`1keqW?aLx+O
> zS;+~>Ip+lDoZy_3oRFMzUU1F}&UwiR$vGDU=3DYrr|kera5b5U?E3eH8z3CTH^1m}|A
> zT#}rSoU<Z0D}u8kIUx;a@2q9hqcop+`Y3zu*6>5@qiM`L8Qmx@>rXnqyVu6bqy3;0
> zSfN$e$O$X-aop-gjFlN1TJ2C(VM8aZsGs9rPsDhcG3gaHcG3%d9rt=3DN#><R_Ugd1x
> zYt+>h-rEXOMpLn!a_)bcQwbVUYCt>d6Z~go(OKwiV=3Dx$e6rJOWm8FJLZ)jL(gSOQ9
> z(=3D101Q%{N90rg{iGreXyIPiUy_PU*2Ro)uw?+2cJexkhQVfAu5b@3W?^1b$-wSOuL
> z8($pWumAYmuXoN*92)^EIHqx|osu9QI;oM>2efl4w7)DozPM|Bh$~ecUA>%od=3DbT&
> z;R0PerC=3DJrI{7MZ#_1;2tCR9A{Hkc%mp4o`zpVZISFrki`_c5@?b)Ba_T|{c>*}hQ
> pv@F`;cR<_jYzAT_(hnb+<eKANn;)0v1k>|8pBtRxTSGr9{slF`>K_0A
>
> literal 0
> HcmV?d00001
>
> diff --git a/tests/data/acpi/virt/riscv64/FACP b/tests/data/acpi/virt/ris=
cv64/FACP
> index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..a5276b65ea8ce46cc9b40d96d=
98f0669c9089ed4 100644
> GIT binary patch
> literal 276
> zcmZ>BbPf<<WME(ucJg=3Dj2v%^42yj*a0-z8Bhz+8t3k1-OV?`GjD1M-;Zz#xa0OIBc
> A0RR91
>
> literal 0
> HcmV?d00001
>
> diff --git a/tests/data/acpi/virt/riscv64/MCFG b/tests/data/acpi/virt/ris=
cv64/MCFG
> index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..37eb923a9320f5573c0c2cdb9=
0bd98409cc7eb6f 100644
> GIT binary patch
> literal 60
> rcmeZuc5}C3U|?Y6aq@Te2v%^42yj*a0!E-1hz+8VfB}^KA4CHH3`GY4
>
> literal 0
> HcmV?d00001
>
> diff --git a/tests/data/acpi/virt/riscv64/RHCT b/tests/data/acpi/virt/ris=
cv64/RHCT
> index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..beaa961bbf0f0486c0dee25f5=
43377c928354f84 100644
> GIT binary patch
> literal 314
> zcmXAlu}%Xq42FGxD#XNyI`tt=3DC&buWx`A2-wkXNvbP-K1O46&8iKjrk6)SI3ey5h~
> z@3-SPa`wCa{iPvl)b_RC9X8vKw|)adiC8n)zP^7d?+~A>`lE(^DK1@Wog4=3D(iq&1K
> z7;1J`gewX|OE=3D3Z>{xM3wM)ljIQKa+635YaZ7jrOeGc+eJEnks*|jl=3DGEUBVQ8WhX
> zK@<flJgso_nMF!k2aE&flg}m^e@2oQd6bm~m(n5!gJ?a<U{EgOALs#2D_Y&qJuA9g
> Pp1|9>GjINg;u`)Bd);9H
>
> literal 0
> HcmV?d00001
>
> diff --git a/tests/data/acpi/virt/riscv64/SPCR b/tests/data/acpi/virt/ris=
cv64/SPCR
> index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..4da9daf65f71a13ac2b488d4e=
9728f194b569a43 100644
> GIT binary patch
> literal 80
> zcmWFza1IJ!U|?X{>E!S15v<@85#X!<1dKp25F12;fdT`FDF9*%FmM4$c8~z`e;@#f
> G!2kgKJqrN<
>
> literal 0
> HcmV?d00001
>
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bi=
os-tables-test-allowed-diff.h
> index d8610c8d72..dfb8523c8b 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,7 +1 @@
>  /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/virt/riscv64/APIC",
> -"tests/data/acpi/virt/riscv64/DSDT",
> -"tests/data/acpi/virt/riscv64/FACP",
> -"tests/data/acpi/virt/riscv64/MCFG",
> -"tests/data/acpi/virt/riscv64/RHCT",
> -"tests/data/acpi/virt/riscv64/SPCR",
> --
> 2.40.1
>

