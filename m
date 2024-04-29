Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDEFCC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 03:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1I55-0001Yx-4e; Sun, 28 Apr 2024 23:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1I4y-0001YG-SP; Sun, 28 Apr 2024 23:53:25 -0400
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1I4w-0008Cg-NI; Sun, 28 Apr 2024 23:53:24 -0400
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-7f0470a1f28so563597241.1; 
 Sun, 28 Apr 2024 20:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714362800; x=1714967600; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UgH4o4OMq5IRG8loAQwdzj40pVoo/PRU24w3h0s7bsc=;
 b=mbwiYcw+RuMioDpUyRPOqS33H9pUWntzWpoLzUzYCC8uaj/9PSyMcj5Tk2dcSR6FbU
 C2uivztTxFOBlSwVh72OsySqkyO/wUCoQofJnqKBFaurzMlKIUTiwpidiN8SrdNZnz07
 dPOdK/ov58qSaNoMKr8JVs6AGacJzCMqUeqQpbD0LD7j7Htre3teWuN6xBos5Bqberrk
 4VM32xGwc5cpzvRo+r12xvkBBJPCjcG3YEpoZMiO7+HKCPM38GbgRzH9CerRTsAOV1U/
 d6nDil0ixZvmb4iUTme5Kp+QXgpQqrcrWVFyUEyqcqaHm7jBh9MuASZR0FdGTJqfQJBz
 phKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714362800; x=1714967600;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UgH4o4OMq5IRG8loAQwdzj40pVoo/PRU24w3h0s7bsc=;
 b=eK8zIUQqNMk631TzoeAisv3dL9WXHAmYPaKkYZqriSO0yDZbs6vpVwe1XZgBvjZkP9
 S7rx+ArmAsGW5j1OYp6Bv3vRmRs9EPGKoby5pWHHoyocsusGdabASn0+AhR740JEwIrI
 eu3v/yN0cnjAqYbEeK2ilHyp4z2mE1urWz2EkiyUTnubRvhafxLFRZEKIexuZSSwMPB6
 8IHOJGWvT56GbBMmDKUP7sSH8fEygRPloeCemNLn2EfFoD1adG3ad9SCu0PH6wmGsk2K
 BBmTM6p5bo2lbL6wFuM7LEbaYC/phRWaB0YRyjl8DxEXmoTpVkxsuij7W7mJWE+kbqs7
 iR4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdOtwTRpUQ7GLgAmm56QpqCrzGRPryb8XVXsC2bxoUls/nU/4pj3JP5RohCfZmrGntP0AiBXz5br00hKywfVSlfNUfE9EmIjyUv8741GR51+ySHCp7aEKrINM=
X-Gm-Message-State: AOJu0YwXYIjoUfW3CLQm8mdEjDkZFHcOUqYB012C7dE3qL4Bk8F7XK9D
 Wm54nPXiPcR8taz+JAO5aUlHjPfweUFyOdZefa0HMppsw+aK6TxLbQzsFtjHa4kuQW1fjRMgLJV
 hX6kKkI5d1BnW6EiFxFjUFvvW2Jc=
X-Google-Smtp-Source: AGHT+IGC5EytXBmHl+9yOas6CBMjSIaAYzZdop52wgw9OZCG4VJ8KyMCxwz+w2THox3wfY2RE9sGAimSwvzOfbDKqFg=
X-Received: by 2002:a05:6122:d86:b0:4de:d0ee:7751 with SMTP id
 bc6-20020a0561220d8600b004ded0ee7751mr9123158vkb.11.1714362798320; Sun, 28
 Apr 2024 20:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240315130924.2378849-1-sunilvl@ventanamicro.com>
 <20240315130924.2378849-9-sunilvl@ventanamicro.com>
In-Reply-To: <20240315130924.2378849-9-sunilvl@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Apr 2024 13:52:52 +1000
Message-ID: <CAKmqyKNNYQacVwaF2qsn5ggLMmrts-HPNwAu7C88=c+Zyt2C4g@mail.gmail.com>
Subject: Re: [PATCH 11/12] tests/data/acpi/virt/riscv64: Add expected ACPI
 tables for RISC-V
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>, 
 Anup Patel <apatel@ventanamicro.com>, Haibo1 Xu <haibo1.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::936;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x936.google.com
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

On Fri, Mar 15, 2024 at 11:10=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.co=
m> wrote:
>
> Add expected ACPI tables for RISC-V so that bios-table-test can be
> enabled for RISC-V.

Can you detail where and how these files are generated/built?

Alistair

>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  tests/data/acpi/virt/riscv64/APIC | Bin 0 -> 116 bytes
>  tests/data/acpi/virt/riscv64/BGRT | Bin 0 -> 56 bytes
>  tests/data/acpi/virt/riscv64/DSDT | Bin 0 -> 3518 bytes
>  tests/data/acpi/virt/riscv64/FACP | Bin 0 -> 276 bytes
>  tests/data/acpi/virt/riscv64/MCFG | Bin 0 -> 60 bytes
>  tests/data/acpi/virt/riscv64/RHCT | Bin 0 -> 314 bytes
>  tests/data/acpi/virt/riscv64/RSDP | Bin 0 -> 36 bytes
>  tests/data/acpi/virt/riscv64/SPCR | Bin 0 -> 80 bytes
>  tests/data/acpi/virt/riscv64/XSDT | Bin 0 -> 84 bytes
>  9 files changed, 0 insertions(+), 0 deletions(-)
>  create mode 100755 tests/data/acpi/virt/riscv64/APIC
>  create mode 100755 tests/data/acpi/virt/riscv64/BGRT
>  create mode 100755 tests/data/acpi/virt/riscv64/DSDT
>  create mode 100755 tests/data/acpi/virt/riscv64/FACP
>  create mode 100755 tests/data/acpi/virt/riscv64/MCFG
>  create mode 100755 tests/data/acpi/virt/riscv64/RHCT
>  create mode 100755 tests/data/acpi/virt/riscv64/RSDP
>  create mode 100755 tests/data/acpi/virt/riscv64/SPCR
>  create mode 100755 tests/data/acpi/virt/riscv64/XSDT
>
> diff --git a/tests/data/acpi/virt/riscv64/APIC b/tests/data/acpi/virt/ris=
cv64/APIC
> new file mode 100755
> index 0000000000000000000000000000000000000000..66a25dfd2d6ea2b607c024722=
b2eab95873a01e9
> GIT binary patch
> literal 116
> zcmZ<^@N_O=3DU|?X|;^gn_5v<@85#X!<1dKp25F13pfP@Mo12P{Zj?R|`s)2!c7=3Ds}J
> I#NvT*0o0BN0RR91
>
> literal 0
> HcmV?d00001
>
> diff --git a/tests/data/acpi/virt/riscv64/BGRT b/tests/data/acpi/virt/ris=
cv64/BGRT
> new file mode 100755
> index 0000000000000000000000000000000000000000..dccf14cce4063dbfe18cd8a45=
9aaa8b206d3b3f0
> GIT binary patch
> literal 56
> zcmZ>A4+^nhU|?XZ_Vf#J^-*wj@itNb0w$msh!zG)F#_2V3gY!3S{^7-3}gTR|5yhB
>
> literal 0
> HcmV?d00001
>
> diff --git a/tests/data/acpi/virt/riscv64/DSDT b/tests/data/acpi/virt/ris=
cv64/DSDT
> new file mode 100755
> index 0000000000000000000000000000000000000000..0fb2d5e0e389541209b765d50=
92d0706f40298f6
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
> new file mode 100755
> index 0000000000000000000000000000000000000000..a5276b65ea8ce46cc9b40d96d=
98f0669c9089ed4
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
> new file mode 100755
> index 0000000000000000000000000000000000000000..37eb923a9320f5573c0c2cdb9=
0bd98409cc7eb6f
> GIT binary patch
> literal 60
> rcmeZuc5}C3U|?Y6aq@Te2v%^42yj*a0!E-1hz+8VfB}^KA4CHH3`GY4
>
> literal 0
> HcmV?d00001
>
> diff --git a/tests/data/acpi/virt/riscv64/RHCT b/tests/data/acpi/virt/ris=
cv64/RHCT
> new file mode 100755
> index 0000000000000000000000000000000000000000..beaa961bbf0f0486c0dee25f5=
43377c928354f84
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
> diff --git a/tests/data/acpi/virt/riscv64/RSDP b/tests/data/acpi/virt/ris=
cv64/RSDP
> new file mode 100755
> index 0000000000000000000000000000000000000000..55054f8730c389d0d7eba90c2=
4a1dae6d1283b90
> GIT binary patch
> literal 36
> ncmWFvc2Nij2~zmy<nQbetiV+A;QxOW1_p)~KpIFfhygJG?v)Gy
>
> literal 0
> HcmV?d00001
>
> diff --git a/tests/data/acpi/virt/riscv64/SPCR b/tests/data/acpi/virt/ris=
cv64/SPCR
> new file mode 100755
> index 0000000000000000000000000000000000000000..4da9daf65f71a13ac2b488d4e=
9728f194b569a43
> GIT binary patch
> literal 80
> zcmWFza1IJ!U|?X{>E!S15v<@85#X!<1dKp25F12;fdT`FDF9*%FmM4$c8~z`e;@#f
> G!2kgKJqrN<
>
> literal 0
> HcmV?d00001
>
> diff --git a/tests/data/acpi/virt/riscv64/XSDT b/tests/data/acpi/virt/ris=
cv64/XSDT
> new file mode 100755
> index 0000000000000000000000000000000000000000..c69474889664d72d075419c0a=
1dcf1d82ec44268
> GIT binary patch
> literal 84
> zcmazDb_oe#U|?VrcJg=3Dj2v%^42yj*a0!E-1h!zG)F&y~+AIN23*Z`#$K<Nokx&cZT
> GKxhCTIu!u`
>
> literal 0
> HcmV?d00001
>
> --
> 2.40.1
>

