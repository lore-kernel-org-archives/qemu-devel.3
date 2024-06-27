Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E397BC3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 12:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMo4x-0005SG-8h; Thu, 27 Jun 2024 08:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sMo4t-0005RP-P6
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 08:18:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sMo4q-0007tv-4L
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 08:18:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719490689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DOfBuSXECtx0UP9l63YBv/eJ7RzU+OwpeKGre3jkOBc=;
 b=d+3P45XtTKFO4VWqel2EdartByLBOa/0SsDYRkjxFiTcvOTqMFmOXEvkS2Dy9rVMNjcwby
 W2bwdyCrgoQrB3PavYvN5RhONTf7cddeD4tMre0b0gxVWb2+u11BHi53RX1AWFHn0rQcOo
 Vce1WVe46o0EnIARPbcVKKlbc+bwwvI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-AaOY-nTuPRagq8HXBYeHBg-1; Thu, 27 Jun 2024 08:18:07 -0400
X-MC-Unique: AaOY-nTuPRagq8HXBYeHBg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-366e84fbd4bso3379690f8f.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 05:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719490687; x=1720095487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DOfBuSXECtx0UP9l63YBv/eJ7RzU+OwpeKGre3jkOBc=;
 b=lbxL16mTldhu7ckimoDX172VvogeiWgIJBuuXNMwppEEczhBedpFpg7jzTX75HOYyv
 +bw5CPlql/ADRA4HfRiCrYAbCzVicwpRAiJ/auGdi84Z/LH3wOIPqmTlEtY9BITlWbwi
 KIYiVT07a6XlkxzDxfpiGtDONXYY1m9rKBVxr8lphMlLhfx3cGbUD6ikyf/sTaXe3ws5
 Ib+W3ryYjkQCQJez1m45w+DFeni+T1brbU2ePq8HRFigjKfW5CFHoMUHKT9/rlel9Gzs
 9N8d9McbaUIRE7sZCJt4+FmyDJJldPV91JqlbZplIdE0UkxI4V6Sg/otXoNAEYBLlPqV
 xpDA==
X-Gm-Message-State: AOJu0YzzYF8Eo96lm5ghsFGQ/2JNnua+r5XBloPuryFM4uA1QEalYtBA
 LfIFYavJis2IZ+OKcLy+gIVZtE2wRKegP8BYokDHSWyZY8sqkedeCW3qv5RljvRfM5vOJU3BlDc
 lxTu4IgbJcePGMTrYJ+Yd0qCFJwSpPrr+kEkm/sfqmQ4tsqZ2gVLb
X-Received: by 2002:a5d:5f49:0:b0:367:4dfe:3e8d with SMTP id
 ffacd0b85a97d-3674dfe4007mr1032479f8f.13.1719490686843; 
 Thu, 27 Jun 2024 05:18:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyz9CgmaOooUqzP26VQOe9V1BJfvThoCJRAibyhfBGTxEUG2sW0MB1baKx9FixdR1cIqf0WA==
X-Received: by 2002:a5d:5f49:0:b0:367:4dfe:3e8d with SMTP id
 ffacd0b85a97d-3674dfe4007mr1032454f8f.13.1719490686487; 
 Thu, 27 Jun 2024 05:18:06 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674357c1e3sm1710255f8f.2.2024.06.27.05.18.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 05:18:06 -0700 (PDT)
Date: Thu, 27 Jun 2024 14:18:03 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Sunil V L <sunilvl@ventanamicro.com>, "Michael S . Tsirkin"
 <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org, Paolo
 Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau
 <marcandre.lureau@redhat.com>, "Daniel P . =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Ani Sinha
 <anisinha@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann
 <kraxel@redhat.com>, Sia Jee Heng <jeeheng.sia@starfivetech.com>, Alistair
 Francis <alistair23@gmail.com>, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng
 <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v4 16/16] tests/qtest/bios-tables-test: Add expected
 ACPI data files for RISC-V
Message-ID: <20240627141803.42cd46c1@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240625150839.1358279-17-sunilvl@ventanamicro.com>
References: <20240625150839.1358279-1-sunilvl@ventanamicro.com>
 <20240625150839.1358279-17-sunilvl@ventanamicro.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 25 Jun 2024 20:38:39 +0530
Sunil V L <sunilvl@ventanamicro.com> wrote:

> As per the step 5 in the process documented in bios-tables-test.c,
> generate the expected ACPI AML data files for RISC-V using the
> rebuild-expected-aml.sh script and update the
> bios-tables-test-allowed-diff.h.
> 
> These are all new files being added for the first time. Hence, iASL diff
> output is not added.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Acked-by: Igor Mammedov <imammedo@redhat.com>

Michael,
can it go via risc-v tree or
do you plan to merge it via your tree?

> ---
>  tests/data/acpi/riscv64/virt/APIC           | Bin 0 -> 116 bytes
>  tests/data/acpi/riscv64/virt/DSDT           | Bin 0 -> 3518 bytes
>  tests/data/acpi/riscv64/virt/FACP           | Bin 0 -> 276 bytes
>  tests/data/acpi/riscv64/virt/MCFG           | Bin 0 -> 60 bytes
>  tests/data/acpi/riscv64/virt/RHCT           | Bin 0 -> 314 bytes
>  tests/data/acpi/riscv64/virt/SPCR           | Bin 0 -> 80 bytes
>  tests/qtest/bios-tables-test-allowed-diff.h |   6 ------
>  7 files changed, 6 deletions(-)
> 
> diff --git a/tests/data/acpi/riscv64/virt/APIC b/tests/data/acpi/riscv64/virt/APIC
> index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..66a25dfd2d6ea2b607c024722b2eab95873a01e9 100644
> GIT binary patch
> literal 116
> zcmZ<^@N_O=U|?X|;^gn_5v<@85#X!<1dKp25F13pfP@Mo12P{Zj?R|`s)2!c7=s}J
> I#NvT*0o0BN0RR91
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/tests/data/acpi/riscv64/virt/DSDT b/tests/data/acpi/riscv64/virt/DSDT
> index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..0fb2d5e0e389541209b765d5092d0706f40298f6 100644
> GIT binary patch
> literal 3518
> zcmZvf%WvaU6vnR;w@IBxlQexl(t(j!ppl%0(ryq<oOYV3X-%9`q=14{b;M9K6c~^O
> zgcx<fqhd2ti4B_~D)B!c1W2sdvE#L7!#}_>eCJ*}oI`D?w!iChKA+$9t$orAn%(bn
> zN+n)t?0eh6a^of6TgGN7rRbcFh1Tyc_k%{iceZVNuIr}z+pT7<?)fc<HI?okw3^tr
> z>)qm0&dr&dmZB`a{a^Ra*0&D5Eo1b;X8Qm}E3gQ<btjYVdtTkbz7rISPX6ODvMUs3
> zVE91w&KfCiza7@#@A>YkTOF1_DRa)WNl^t#{A^TNmZNji{btZCtt5&QPNDqU;E!+b  
> zecnEQ^xc;~?0jvN=B?69B6sx0n@1<N?!0~c*1N~|jvlD2+E~Xu>-LMCh<kUhvyXCD
> z|GVk1+UV8=+`16nn$W3iZBaGE(t=R0Su8V)L_|(iti)M3i8v3Jc_g_<E!HC$=dr;&
> zZ0_+)tcM-v;WLjB?y(x{F%swTD)SiS9?!;ljK+DKGLIDZSc~;Y#d$nr9_i3y=NsQ^
> zu@zZ&*ReP}{EyK3th+T@*_*eqZ#4FX%O>b{iWO(USDtFAW3{YY{55g*p1P}!a8zWX
> z7lz;IPVBzpJS=7G%wV8y2Q62ba|`EHRm#%1lYm%>L=vK=N;x|_7+?*WxKL3R0`umY
> z&O>M<DHHxW7E8~>hKe$y(1g;N2-TU8l!<C|EEb%J4HacZp-Gd8P@M@$nW#v|VwsuP  
> zP=$;-)Haz>@sOMoiwl`i1tW@cj+o4-cu3BPCB-VhD+4MD9hIDroD&Pl#Oi8OIy2%-
> zNlr-4iRFXLXr|LTGn$gL<b>p$V}cX!M^n3=p)tt`$vN>NG_kr`M{qil6Owag1ZPHY
> zW+W#h=gbPutl-Q_PDsv)?-Htwo@Y*Q<|HR1=gbSvyx`1BPDsu<E;z>p=eXpA<eYfp
> zv*(GAkEvZhm4f7i<eWvpSrnW_$qC6hOM<f`I7^Zfl5<W7&I!ReAvqyAXIXHT1!q}u
> zLUPVY!8s{7CnYB&=bRFpQ-X6!azb*>X~8)yIHx5iB<DoK!Jg-g;GB`1keqW?aLx+O
> zS;+~>Ip+lDoZy_3oRFMzUU1F}&UwiR$vGDU=Yrr|kera5b5U?E3eH8z3CTH^1m}|A  
> zT#}rSoU<Z0D}u8kIUx;a@2q9hqcop+`Y3zu*6>5@qiM`L8Qmx@>rXnqyVu6bqy3;0
> zSfN$e$O$X-aop-gjFlN1TJ2C(VM8aZsGs9rPsDhcG3gaHcG3%d9rt=N#><R_Ugd1x
> zYt+>h-rEXOMpLn!a_)bcQwbVUYCt>d6Z~go(OKwiV=x$e6rJOWm8FJLZ)jL(gSOQ9  
> z(=101Q%{N90rg{iGreXyIPiUy_PU*2Ro)uw?+2cJexkhQVfAu5b@3W?^1b$-wSOuL
> z8($pWumAYmuXoN*92)^EIHqx|osu9QI;oM>2efl4w7)DozPM|Bh$~ecUA>%od=bT&  
> z;R0PerC=JrI{7MZ#_1;2tCR9A{Hkc%mp4o`zpVZISFrki`_c5@?b)Ba_T|{c>*}hQ  
> pv@F`;cR<_jYzAT_(hnb+<eKANn;)0v1k>|8pBtRxTSGr9{slF`>K_0A
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/tests/data/acpi/riscv64/virt/FACP b/tests/data/acpi/riscv64/virt/FACP
> index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..a5276b65ea8ce46cc9b40d96d98f0669c9089ed4 100644
> GIT binary patch
> literal 276
> zcmZ>BbPf<<WME(ucJg=j2v%^42yj*a0-z8Bhz+8t3k1-OV?`GjD1M-;Zz#xa0OIBc  
> A0RR91
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/tests/data/acpi/riscv64/virt/MCFG b/tests/data/acpi/riscv64/virt/MCFG
> index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..37eb923a9320f5573c0c2cdb90bd98409cc7eb6f 100644
> GIT binary patch
> literal 60
> rcmeZuc5}C3U|?Y6aq@Te2v%^42yj*a0!E-1hz+8VfB}^KA4CHH3`GY4
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/tests/data/acpi/riscv64/virt/RHCT b/tests/data/acpi/riscv64/virt/RHCT
> index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..beaa961bbf0f0486c0dee25f543377c928354f84 100644
> GIT binary patch
> literal 314
> zcmXAlu}%Xq42FGxD#XNyI`tt=C&buWx`A2-wkXNvbP-K1O46&8iKjrk6)SI3ey5h~
> z@3-SPa`wCa{iPvl)b_RC9X8vKw|)adiC8n)zP^7d?+~A>`lE(^DK1@Wog4=(iq&1K
> z7;1J`gewX|OE=3Z>{xM3wM)ljIQKa+635YaZ7jrOeGc+eJEnks*|jl=GEUBVQ8WhX  
> zK@<flJgso_nMF!k2aE&flg}m^e@2oQd6bm~m(n5!gJ?a<U{EgOALs#2D_Y&qJuA9g
> Pp1|9>GjINg;u`)Bd);9H  
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/tests/data/acpi/riscv64/virt/SPCR b/tests/data/acpi/riscv64/virt/SPCR
> index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..4da9daf65f71a13ac2b488d4e9728f194b569a43 100644
> GIT binary patch
> literal 80
> zcmWFza1IJ!U|?X{>E!S15v<@85#X!<1dKp25F12;fdT`FDF9*%FmM4$c8~z`e;@#f  
> G!2kgKJqrN<
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index 70474a097f..dfb8523c8b 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,7 +1 @@
>  /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/riscv64/virt/APIC",
> -"tests/data/acpi/riscv64/virt/DSDT",
> -"tests/data/acpi/riscv64/virt/FACP",
> -"tests/data/acpi/riscv64/virt/MCFG",
> -"tests/data/acpi/riscv64/virt/RHCT",
> -"tests/data/acpi/riscv64/virt/SPCR",


