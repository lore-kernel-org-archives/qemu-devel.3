Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27896C54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 13:19:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl7L0-0000Fj-Ok; Fri, 15 Mar 2024 09:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1rl7KK-0006ns-6u
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:10:24 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1rl7KE-0007zW-0V
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:10:23 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e6cadfffdbso1802716b3a.3
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 06:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710508215; x=1711113015; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KQl+6L0VcZgA50SWnKjH1hfXBn+0RZFkMJcMmqNHbzY=;
 b=U4fl/FuIfmhvfpd57CuEGSTBZPqomH+zH3R5OGh0AuCywg5JpaW2XO5EUpxzPiqf8y
 YfzTra2+FBMWVM4CTmILQ3FXSfh2BF57zTF7N2xYfTXxsL3xGOSxVPWLeQI1IP6JM9RF
 PkvpwAnKhA3pj8QhyIQZBCjMQ5zFRE2+N95l7lBSUcGmEJzTwNzu97XNF6Ch6GrHW8z5
 jBlNwhj2pydouInDu6n9Dg4Dqn0ZL5CBwh8Z2Fp7nTcghiQ59KdDA5LCxA/nKkvWwAIM
 peH+ncEN+XsbbF4rKQsBqggbkKZnr8xaY9VXlqAzlenJplZon3SqXFIAE3pdIeUOe8Fw
 9f3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710508215; x=1711113015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KQl+6L0VcZgA50SWnKjH1hfXBn+0RZFkMJcMmqNHbzY=;
 b=H18cDdURfmup4/QhjwJFQvJuh2T/OVDqOyAS1cMHkVWSHlaFRyukPZspWoYvQlD1l1
 rS1P2n60WiaQYwB6K5AJzzOlukddIILKdL/8BrauYpM0KCKg4Bdw+2bURdv9Nx4+JKm5
 WYRHwiI/ABJ8gyCf+b22LaqIiROpdNc2VOnxIrLWP8ZbF9YEXyX5vGH7Z5PuXs7ngXEK
 Yq+zDbnK6ZnxF+6QQYhH3j7WmKJKkNh56R4jVUuxx5yM1AvzxbhoPIQmyqWjbeqKAtdT
 x3mY3H+n3Ri/WFF8Gp85sXM5WKWo+9/+Kp22Vx1mPo7sZdHRCIIaLiOL/uJI6QyAPHPh
 qGmw==
X-Gm-Message-State: AOJu0Yzj8XzEmkritZlF7UBoc5dp2FT02r76CrvZ1TlzRcUzDPnZyhnR
 PT4IAbjgKCAclnnCd5ZAfbKSEsJpiiCLmLiLl1yPUUJYEtS+Fy1ZWbO/fWPX4V1Z1y616Leh0jB
 Y
X-Google-Smtp-Source: AGHT+IEsZrFnzF0nSF1KB0XYo3jYzZt3uc4XUl0wYPF7n36Mll3laOGigFIGHPKuog3Ig9SRChTing==
X-Received: by 2002:a05:6a20:8f24:b0:1a3:502d:cb1 with SMTP id
 b36-20020a056a208f2400b001a3502d0cb1mr1429088pzk.1.1710508214724; 
 Fri, 15 Mar 2024 06:10:14 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.184.12])
 by smtp.gmail.com with ESMTPSA id
 r3-20020a17090ad40300b0029c68206e2bsm2886663pju.0.2024.03.15.06.10.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 06:10:14 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair23@gmail.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Anup Patel <apatel@ventanamicro.com>, Haibo1 Xu <haibo1.xu@intel.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH 11/12] tests/data/acpi/virt/riscv64: Add expected ACPI tables
 for RISC-V
Date: Fri, 15 Mar 2024 18:39:23 +0530
Message-Id: <20240315130924.2378849-9-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240315130924.2378849-1-sunilvl@ventanamicro.com>
References: <20240315130924.2378849-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Add expected ACPI tables for RISC-V so that bios-table-test can be
enabled for RISC-V.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 tests/data/acpi/virt/riscv64/APIC | Bin 0 -> 116 bytes
 tests/data/acpi/virt/riscv64/BGRT | Bin 0 -> 56 bytes
 tests/data/acpi/virt/riscv64/DSDT | Bin 0 -> 3518 bytes
 tests/data/acpi/virt/riscv64/FACP | Bin 0 -> 276 bytes
 tests/data/acpi/virt/riscv64/MCFG | Bin 0 -> 60 bytes
 tests/data/acpi/virt/riscv64/RHCT | Bin 0 -> 314 bytes
 tests/data/acpi/virt/riscv64/RSDP | Bin 0 -> 36 bytes
 tests/data/acpi/virt/riscv64/SPCR | Bin 0 -> 80 bytes
 tests/data/acpi/virt/riscv64/XSDT | Bin 0 -> 84 bytes
 9 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100755 tests/data/acpi/virt/riscv64/APIC
 create mode 100755 tests/data/acpi/virt/riscv64/BGRT
 create mode 100755 tests/data/acpi/virt/riscv64/DSDT
 create mode 100755 tests/data/acpi/virt/riscv64/FACP
 create mode 100755 tests/data/acpi/virt/riscv64/MCFG
 create mode 100755 tests/data/acpi/virt/riscv64/RHCT
 create mode 100755 tests/data/acpi/virt/riscv64/RSDP
 create mode 100755 tests/data/acpi/virt/riscv64/SPCR
 create mode 100755 tests/data/acpi/virt/riscv64/XSDT

diff --git a/tests/data/acpi/virt/riscv64/APIC b/tests/data/acpi/virt/riscv64/APIC
new file mode 100755
index 0000000000000000000000000000000000000000..66a25dfd2d6ea2b607c024722b2eab95873a01e9
GIT binary patch
literal 116
zcmZ<^@N_O=U|?X|;^gn_5v<@85#X!<1dKp25F13pfP@Mo12P{Zj?R|`s)2!c7=s}J
I#NvT*0o0BN0RR91

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/virt/riscv64/BGRT b/tests/data/acpi/virt/riscv64/BGRT
new file mode 100755
index 0000000000000000000000000000000000000000..dccf14cce4063dbfe18cd8a459aaa8b206d3b3f0
GIT binary patch
literal 56
zcmZ>A4+^nhU|?XZ_Vf#J^-*wj@itNb0w$msh!zG)F#_2V3gY!3S{^7-3}gTR|5yhB

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/virt/riscv64/DSDT b/tests/data/acpi/virt/riscv64/DSDT
new file mode 100755
index 0000000000000000000000000000000000000000..0fb2d5e0e389541209b765d5092d0706f40298f6
GIT binary patch
literal 3518
zcmZvf%WvaU6vnR;w@IBxlQexl(t(j!ppl%0(ryq<oOYV3X-%9`q=14{b;M9K6c~^O
zgcx<fqhd2ti4B_~D)B!c1W2sdvE#L7!#}_>eCJ*}oI`D?w!iChKA+$9t$orAn%(bn
zN+n)t?0eh6a^of6TgGN7rRbcFh1Tyc_k%{iceZVNuIr}z+pT7<?)fc<HI?okw3^tr
z>)qm0&dr&dmZB`a{a^Ra*0&D5Eo1b;X8Qm}E3gQ<btjYVdtTkbz7rISPX6ODvMUs3
zVE91w&KfCiza7@#@A>YkTOF1_DRa)WNl^t#{A^TNmZNji{btZCtt5&QPNDqU;E!+b
zecnEQ^xc;~?0jvN=B?69B6sx0n@1<N?!0~c*1N~|jvlD2+E~Xu>-LMCh<kUhvyXCD
z|GVk1+UV8=+`16nn$W3iZBaGE(t=R0Su8V)L_|(iti)M3i8v3Jc_g_<E!HC$=dr;&
zZ0_+)tcM-v;WLjB?y(x{F%swTD)SiS9?!;ljK+DKGLIDZSc~;Y#d$nr9_i3y=NsQ^
zu@zZ&*ReP}{EyK3th+T@*_*eqZ#4FX%O>b{iWO(USDtFAW3{YY{55g*p1P}!a8zWX
z7lz;IPVBzpJS=7G%wV8y2Q62ba|`EHRm#%1lYm%>L=vK=N;x|_7+?*WxKL3R0`umY
z&O>M<DHHxW7E8~>hKe$y(1g;N2-TU8l!<C|EEb%J4HacZp-Gd8P@M@$nW#v|VwsuP
zP=$;-)Haz>@sOMoiwl`i1tW@cj+o4-cu3BPCB-VhD+4MD9hIDroD&Pl#Oi8OIy2%-
zNlr-4iRFXLXr|LTGn$gL<b>p$V}cX!M^n3=p)tt`$vN>NG_kr`M{qil6Owag1ZPHY
zW+W#h=gbPutl-Q_PDsv)?-Htwo@Y*Q<|HR1=gbSvyx`1BPDsu<E;z>p=eXpA<eYfp
zv*(GAkEvZhm4f7i<eWvpSrnW_$qC6hOM<f`I7^Zfl5<W7&I!ReAvqyAXIXHT1!q}u
zLUPVY!8s{7CnYB&=bRFpQ-X6!azb*>X~8)yIHx5iB<DoK!Jg-g;GB`1keqW?aLx+O
zS;+~>Ip+lDoZy_3oRFMzUU1F}&UwiR$vGDU=Yrr|kera5b5U?E3eH8z3CTH^1m}|A
zT#}rSoU<Z0D}u8kIUx;a@2q9hqcop+`Y3zu*6>5@qiM`L8Qmx@>rXnqyVu6bqy3;0
zSfN$e$O$X-aop-gjFlN1TJ2C(VM8aZsGs9rPsDhcG3gaHcG3%d9rt=N#><R_Ugd1x
zYt+>h-rEXOMpLn!a_)bcQwbVUYCt>d6Z~go(OKwiV=x$e6rJOWm8FJLZ)jL(gSOQ9
z(=101Q%{N90rg{iGreXyIPiUy_PU*2Ro)uw?+2cJexkhQVfAu5b@3W?^1b$-wSOuL
z8($pWumAYmuXoN*92)^EIHqx|osu9QI;oM>2efl4w7)DozPM|Bh$~ecUA>%od=bT&
z;R0PerC=JrI{7MZ#_1;2tCR9A{Hkc%mp4o`zpVZISFrki`_c5@?b)Ba_T|{c>*}hQ
pv@F`;cR<_jYzAT_(hnb+<eKANn;)0v1k>|8pBtRxTSGr9{slF`>K_0A

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/virt/riscv64/FACP b/tests/data/acpi/virt/riscv64/FACP
new file mode 100755
index 0000000000000000000000000000000000000000..a5276b65ea8ce46cc9b40d96d98f0669c9089ed4
GIT binary patch
literal 276
zcmZ>BbPf<<WME(ucJg=j2v%^42yj*a0-z8Bhz+8t3k1-OV?`GjD1M-;Zz#xa0OIBc
A0RR91

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/virt/riscv64/MCFG b/tests/data/acpi/virt/riscv64/MCFG
new file mode 100755
index 0000000000000000000000000000000000000000..37eb923a9320f5573c0c2cdb90bd98409cc7eb6f
GIT binary patch
literal 60
rcmeZuc5}C3U|?Y6aq@Te2v%^42yj*a0!E-1hz+8VfB}^KA4CHH3`GY4

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/virt/riscv64/RHCT b/tests/data/acpi/virt/riscv64/RHCT
new file mode 100755
index 0000000000000000000000000000000000000000..beaa961bbf0f0486c0dee25f543377c928354f84
GIT binary patch
literal 314
zcmXAlu}%Xq42FGxD#XNyI`tt=C&buWx`A2-wkXNvbP-K1O46&8iKjrk6)SI3ey5h~
z@3-SPa`wCa{iPvl)b_RC9X8vKw|)adiC8n)zP^7d?+~A>`lE(^DK1@Wog4=(iq&1K
z7;1J`gewX|OE=3Z>{xM3wM)ljIQKa+635YaZ7jrOeGc+eJEnks*|jl=GEUBVQ8WhX
zK@<flJgso_nMF!k2aE&flg}m^e@2oQd6bm~m(n5!gJ?a<U{EgOALs#2D_Y&qJuA9g
Pp1|9>GjINg;u`)Bd);9H

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/virt/riscv64/RSDP b/tests/data/acpi/virt/riscv64/RSDP
new file mode 100755
index 0000000000000000000000000000000000000000..55054f8730c389d0d7eba90c24a1dae6d1283b90
GIT binary patch
literal 36
ncmWFvc2Nij2~zmy<nQbetiV+A;QxOW1_p)~KpIFfhygJG?v)Gy

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/virt/riscv64/SPCR b/tests/data/acpi/virt/riscv64/SPCR
new file mode 100755
index 0000000000000000000000000000000000000000..4da9daf65f71a13ac2b488d4e9728f194b569a43
GIT binary patch
literal 80
zcmWFza1IJ!U|?X{>E!S15v<@85#X!<1dKp25F12;fdT`FDF9*%FmM4$c8~z`e;@#f
G!2kgKJqrN<

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/virt/riscv64/XSDT b/tests/data/acpi/virt/riscv64/XSDT
new file mode 100755
index 0000000000000000000000000000000000000000..c69474889664d72d075419c0a1dcf1d82ec44268
GIT binary patch
literal 84
zcmazDb_oe#U|?VrcJg=j2v%^42yj*a0!E-1h!zG)F&y~+AIN23*Z`#$K<Nokx&cZT
GKxhCTIu!u`

literal 0
HcmV?d00001

-- 
2.40.1


