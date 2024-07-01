Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C8CC30653
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 21:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOOBz-0004bM-GR; Mon, 01 Jul 2024 17:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOOBp-0004aI-SR
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 17:03:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOOBl-0007jZ-Qi
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 17:03:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719867832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ScHz/Z23DDe8prbj9gqgLTx5aMeEg72fOoq/GVUATco=;
 b=EPWlipcsnYN5G60mQwxzH85elXmFGXUKHzCQk63Sfx/t0qjoKnXGqClxgHwvgM/qBmB53w
 A19i89gTsvyDLsveUXdhITe46kYFlrz49Ucpxmidgx7UB0BOkbTECVw0EHoROxZMVYPbZh
 PWYPkj7mxF1cHEvD5g8i/4LkT7KUv5c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-CZw6gwc3OkSNiB09wwHAPg-1; Mon, 01 Jul 2024 17:03:50 -0400
X-MC-Unique: CZw6gwc3OkSNiB09wwHAPg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4256809ae27so22768035e9.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 14:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719867829; x=1720472629;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ScHz/Z23DDe8prbj9gqgLTx5aMeEg72fOoq/GVUATco=;
 b=rlYFXnmFyvk2BDtScvqEWe6uB81pSnToOCfoemt/lFdzAi+EmQMv99iS+KE0o7TI62
 PxirJ7v/GyZrqsH5IRlPkPj/ePkbvQ7ovEEwjx1TIO+hASWSr4sjc+YNXSee/dKwqKjP
 KZLtmsgmPSJagA8up+PXHBDLdl6rnKjWuLO2u5+0gkCqg13RH7ncNkfegVQwt856RlwX
 wsiNN6/AtgIVH/2q7eS/5XT4A04DwnOpnQrkRPDooeQHmPggFCdIjMv83dJUVzMZTe6j
 zQum61IDIZRfLv4lhHgy+I070VY8k1wkSYTq/nnAg/70Wv3WeQiggIQjVioXVFviJOFz
 v0Ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIHaNOJSmXt2kUeCm6iea4oDICt+XcDhufWHI0traUng+eoJniSEWzqQvYMOoLNakrbfvGxG6nP1lkJ2dd6NdRZAntPIE=
X-Gm-Message-State: AOJu0YyI/srWvgIPgP31FVjaJBRfwlmpw1OKl9xzV32hdCCO30fRZT84
 5fZU3MoZ5GAAMQCtX6EyvUQb04e2eNC/4L6KiXvWvmm0nyyLOs4NcLinpeqJwoxQPDZWOAMQbQr
 cKJ/i8aHwrScKZfVavPmzvLMisLCV/vwBmgk/cqrv520B/7tg+Xy2
X-Received: by 2002:a05:600c:c88:b0:424:a5af:4e55 with SMTP id
 5b1f17b1804b1-4257a05b491mr44610725e9.29.1719867829750; 
 Mon, 01 Jul 2024 14:03:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGds95kgk8fz/lSw3YQ7ACwZzTjhsLjizakPK/QNS4yPkgoMnBuL2+kp7JvkmmP5ScLxA7QcQ==
X-Received: by 2002:a05:600c:c88:b0:424:a5af:4e55 with SMTP id
 5b1f17b1804b1-4257a05b491mr44610475e9.29.1719867829163; 
 Mon, 01 Jul 2024 14:03:49 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b0c0f26sm166557125e9.39.2024.07.01.14.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 14:03:48 -0700 (PDT)
Date: Mon, 1 Jul 2024 17:03:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Sunil V L <sunilvl@ventanamicro.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alistair Francis <alistair23@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v4 16/16] tests/qtest/bios-tables-test: Add expected ACPI
 data files for RISC-V
Message-ID: <20240701170330-mutt-send-email-mst@kernel.org>
References: <20240625150839.1358279-1-sunilvl@ventanamicro.com>
 <20240625150839.1358279-17-sunilvl@ventanamicro.com>
 <20240627141803.42cd46c1@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627141803.42cd46c1@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Jun 27, 2024 at 02:18:03PM +0200, Igor Mammedov wrote:
> On Tue, 25 Jun 2024 20:38:39 +0530
> Sunil V L <sunilvl@ventanamicro.com> wrote:
> 
> > As per the step 5 in the process documented in bios-tables-test.c,
> > generate the expected ACPI AML data files for RISC-V using the
> > rebuild-expected-aml.sh script and update the
> > bios-tables-test-allowed-diff.h.
> > 
> > These are all new files being added for the first time. Hence, iASL diff
> > output is not added.
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > Acked-by: Alistair Francis <alistair.francis@wdc.com>
> > Acked-by: Igor Mammedov <imammedo@redhat.com>
> 
> Michael,
> can it go via risc-v tree or
> do you plan to merge it via your tree?

given patch 1 is merged, I took the rest.

> > ---
> >  tests/data/acpi/riscv64/virt/APIC           | Bin 0 -> 116 bytes
> >  tests/data/acpi/riscv64/virt/DSDT           | Bin 0 -> 3518 bytes
> >  tests/data/acpi/riscv64/virt/FACP           | Bin 0 -> 276 bytes
> >  tests/data/acpi/riscv64/virt/MCFG           | Bin 0 -> 60 bytes
> >  tests/data/acpi/riscv64/virt/RHCT           | Bin 0 -> 314 bytes
> >  tests/data/acpi/riscv64/virt/SPCR           | Bin 0 -> 80 bytes
> >  tests/qtest/bios-tables-test-allowed-diff.h |   6 ------
> >  7 files changed, 6 deletions(-)
> > 
> > diff --git a/tests/data/acpi/riscv64/virt/APIC b/tests/data/acpi/riscv64/virt/APIC
> > index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..66a25dfd2d6ea2b607c024722b2eab95873a01e9 100644
> > GIT binary patch
> > literal 116
> > zcmZ<^@N_O=U|?X|;^gn_5v<@85#X!<1dKp25F13pfP@Mo12P{Zj?R|`s)2!c7=s}J
> > I#NvT*0o0BN0RR91
> > 
> > literal 0
> > HcmV?d00001
> > 
> > diff --git a/tests/data/acpi/riscv64/virt/DSDT b/tests/data/acpi/riscv64/virt/DSDT
> > index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..0fb2d5e0e389541209b765d5092d0706f40298f6 100644
> > GIT binary patch
> > literal 3518
> > zcmZvf%WvaU6vnR;w@IBxlQexl(t(j!ppl%0(ryq<oOYV3X-%9`q=14{b;M9K6c~^O
> > zgcx<fqhd2ti4B_~D)B!c1W2sdvE#L7!#}_>eCJ*}oI`D?w!iChKA+$9t$orAn%(bn
> > zN+n)t?0eh6a^of6TgGN7rRbcFh1Tyc_k%{iceZVNuIr}z+pT7<?)fc<HI?okw3^tr
> > z>)qm0&dr&dmZB`a{a^Ra*0&D5Eo1b;X8Qm}E3gQ<btjYVdtTkbz7rISPX6ODvMUs3
> > zVE91w&KfCiza7@#@A>YkTOF1_DRa)WNl^t#{A^TNmZNji{btZCtt5&QPNDqU;E!+b  
> > zecnEQ^xc;~?0jvN=B?69B6sx0n@1<N?!0~c*1N~|jvlD2+E~Xu>-LMCh<kUhvyXCD
> > z|GVk1+UV8=+`16nn$W3iZBaGE(t=R0Su8V)L_|(iti)M3i8v3Jc_g_<E!HC$=dr;&
> > zZ0_+)tcM-v;WLjB?y(x{F%swTD)SiS9?!;ljK+DKGLIDZSc~;Y#d$nr9_i3y=NsQ^
> > zu@zZ&*ReP}{EyK3th+T@*_*eqZ#4FX%O>b{iWO(USDtFAW3{YY{55g*p1P}!a8zWX
> > z7lz;IPVBzpJS=7G%wV8y2Q62ba|`EHRm#%1lYm%>L=vK=N;x|_7+?*WxKL3R0`umY
> > z&O>M<DHHxW7E8~>hKe$y(1g;N2-TU8l!<C|EEb%J4HacZp-Gd8P@M@$nW#v|VwsuP  
> > zP=$;-)Haz>@sOMoiwl`i1tW@cj+o4-cu3BPCB-VhD+4MD9hIDroD&Pl#Oi8OIy2%-
> > zNlr-4iRFXLXr|LTGn$gL<b>p$V}cX!M^n3=p)tt`$vN>NG_kr`M{qil6Owag1ZPHY
> > zW+W#h=gbPutl-Q_PDsv)?-Htwo@Y*Q<|HR1=gbSvyx`1BPDsu<E;z>p=eXpA<eYfp
> > zv*(GAkEvZhm4f7i<eWvpSrnW_$qC6hOM<f`I7^Zfl5<W7&I!ReAvqyAXIXHT1!q}u
> > zLUPVY!8s{7CnYB&=bRFpQ-X6!azb*>X~8)yIHx5iB<DoK!Jg-g;GB`1keqW?aLx+O
> > zS;+~>Ip+lDoZy_3oRFMzUU1F}&UwiR$vGDU=Yrr|kera5b5U?E3eH8z3CTH^1m}|A  
> > zT#}rSoU<Z0D}u8kIUx;a@2q9hqcop+`Y3zu*6>5@qiM`L8Qmx@>rXnqyVu6bqy3;0
> > zSfN$e$O$X-aop-gjFlN1TJ2C(VM8aZsGs9rPsDhcG3gaHcG3%d9rt=N#><R_Ugd1x
> > zYt+>h-rEXOMpLn!a_)bcQwbVUYCt>d6Z~go(OKwiV=x$e6rJOWm8FJLZ)jL(gSOQ9  
> > z(=101Q%{N90rg{iGreXyIPiUy_PU*2Ro)uw?+2cJexkhQVfAu5b@3W?^1b$-wSOuL
> > z8($pWumAYmuXoN*92)^EIHqx|osu9QI;oM>2efl4w7)DozPM|Bh$~ecUA>%od=bT&  
> > z;R0PerC=JrI{7MZ#_1;2tCR9A{Hkc%mp4o`zpVZISFrki`_c5@?b)Ba_T|{c>*}hQ  
> > pv@F`;cR<_jYzAT_(hnb+<eKANn;)0v1k>|8pBtRxTSGr9{slF`>K_0A
> > 
> > literal 0
> > HcmV?d00001
> > 
> > diff --git a/tests/data/acpi/riscv64/virt/FACP b/tests/data/acpi/riscv64/virt/FACP
> > index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..a5276b65ea8ce46cc9b40d96d98f0669c9089ed4 100644
> > GIT binary patch
> > literal 276
> > zcmZ>BbPf<<WME(ucJg=j2v%^42yj*a0-z8Bhz+8t3k1-OV?`GjD1M-;Zz#xa0OIBc  
> > A0RR91
> > 
> > literal 0
> > HcmV?d00001
> > 
> > diff --git a/tests/data/acpi/riscv64/virt/MCFG b/tests/data/acpi/riscv64/virt/MCFG
> > index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..37eb923a9320f5573c0c2cdb90bd98409cc7eb6f 100644
> > GIT binary patch
> > literal 60
> > rcmeZuc5}C3U|?Y6aq@Te2v%^42yj*a0!E-1hz+8VfB}^KA4CHH3`GY4
> > 
> > literal 0
> > HcmV?d00001
> > 
> > diff --git a/tests/data/acpi/riscv64/virt/RHCT b/tests/data/acpi/riscv64/virt/RHCT
> > index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..beaa961bbf0f0486c0dee25f543377c928354f84 100644
> > GIT binary patch
> > literal 314
> > zcmXAlu}%Xq42FGxD#XNyI`tt=C&buWx`A2-wkXNvbP-K1O46&8iKjrk6)SI3ey5h~
> > z@3-SPa`wCa{iPvl)b_RC9X8vKw|)adiC8n)zP^7d?+~A>`lE(^DK1@Wog4=(iq&1K
> > z7;1J`gewX|OE=3Z>{xM3wM)ljIQKa+635YaZ7jrOeGc+eJEnks*|jl=GEUBVQ8WhX  
> > zK@<flJgso_nMF!k2aE&flg}m^e@2oQd6bm~m(n5!gJ?a<U{EgOALs#2D_Y&qJuA9g
> > Pp1|9>GjINg;u`)Bd);9H  
> > 
> > literal 0
> > HcmV?d00001
> > 
> > diff --git a/tests/data/acpi/riscv64/virt/SPCR b/tests/data/acpi/riscv64/virt/SPCR
> > index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..4da9daf65f71a13ac2b488d4e9728f194b569a43 100644
> > GIT binary patch
> > literal 80
> > zcmWFza1IJ!U|?X{>E!S15v<@85#X!<1dKp25F12;fdT`FDF9*%FmM4$c8~z`e;@#f  
> > G!2kgKJqrN<
> > 
> > literal 0
> > HcmV?d00001
> > 
> > diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> > index 70474a097f..dfb8523c8b 100644
> > --- a/tests/qtest/bios-tables-test-allowed-diff.h
> > +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> > @@ -1,7 +1 @@
> >  /* List of comma-separated changed AML files to ignore */
> > -"tests/data/acpi/riscv64/virt/APIC",
> > -"tests/data/acpi/riscv64/virt/DSDT",
> > -"tests/data/acpi/riscv64/virt/FACP",
> > -"tests/data/acpi/riscv64/virt/MCFG",
> > -"tests/data/acpi/riscv64/virt/RHCT",
> > -"tests/data/acpi/riscv64/virt/SPCR",


