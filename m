Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA945C3DA7F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 11:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDGh-00029j-Pv; Tue, 23 Jul 2024 07:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDGZ-0001K3-TG
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:01:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDGX-00034G-UM
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MeXmlkXUO1c12DbabmZ2BwxdEJDDqafMQQCrC5Sf5B0=;
 b=WrxhFKCRwxQ3be9QrNOeGnF/sX9Gw962dcVN1eb+5i9Dhw35ketMsJiR8Ma6uEwDd1gnKt
 CnqoPZ/mQx5ej3KrTxaEaQQ8EyP8idX5F/ChgUrT/vgeCYuXXhPLVIAcT9vifRnPM9bgh5
 g5atlO0Qnx1khlR0qT1hJ64FCtSeX8s=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-Cv0cazVyNzikwozuR2Qxkg-1; Tue, 23 Jul 2024 07:01:07 -0400
X-MC-Unique: Cv0cazVyNzikwozuR2Qxkg-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2ef311ad4bcso17984551fa.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 04:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732465; x=1722337265;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MeXmlkXUO1c12DbabmZ2BwxdEJDDqafMQQCrC5Sf5B0=;
 b=anrKIizCZ25AuiP0llJbs9KxNIGNqNFuvoeU1c2kF+No79rxIY1x21+Wi/iH1zlXQ3
 Lb3izXzhQShOqZDqABl0wS6Bt2aNb/CcfXCQfbMGCRY8JWIwbVLm9j6KaPAxRPEqSH6Q
 zygDd+/arFxtj2dKwM+PtyUF2vI3MpTwuGn4tZYXrGaQIKnErIpE3UxuW3+FIlEYWJ2/
 cyAiq0jFIivbeH/TijQ6vWCb5LCh9+mvOTXR+Z7Cp+FyPnaAc6g0acFcI/lxY9DP1LvM
 HYjDFbn6ksblkJ9Ib4sQkZrrzleW+j7/wnYRkgA2X8PoOwHUvxSgvBP4PpcBavlBXaz1
 7g3A==
X-Gm-Message-State: AOJu0YzhvLZKhaqSvGXWB1dyxCsfYZ/RNQC45/PixHoA+4Gz2krLLFeE
 fIqXG0jtzb2Wdjw/UIovFIqgWDXNzPq2OHW1NLou8TBKPF7m0BAF4OifsYqBzVbdhWn9vURLD6g
 XLX3EPgqAZbs4DzoVzwJ8SYdss8g+mzZudYCQV1sFLnYvfJKK/53dAdLIpdNjVl8pCPRupZsvGs
 iXzpSg92W043YpYFEG8YR/rij85Rzy0Q==
X-Received: by 2002:a2e:b5b7:0:b0:2ef:18b7:440b with SMTP id
 38308e7fff4ca-2ef18b7487cmr57324851fa.12.1721732464981; 
 Tue, 23 Jul 2024 04:01:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGk4nm09xoUh8cIMmS3LS83RAFgUA+XZw7BRqAtMwF4Omqwx0DD5SaIbJEssNRSdJx3QuDPVA==
X-Received: by 2002:a2e:b5b7:0:b0:2ef:18b7:440b with SMTP id
 38308e7fff4ca-2ef18b7487cmr57324471fa.12.1721732464078; 
 Tue, 23 Jul 2024 04:01:04 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5a30af83177sm7419744a12.42.2024.07.23.04.01.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 04:01:03 -0700 (PDT)
Date: Tue, 23 Jul 2024 07:01:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL v2 58/61] tests/acpi: Add expected ACPI AML files for RISC-V
Message-ID: <e9c0d54f4aebeeeebf1124d6acd607e3015e0a51.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Sunil V L <sunilvl@ventanamicro.com>

As per the step 5 in the process documented in bios-tables-test.c,
generate the expected ACPI AML data files for RISC-V using the
rebuild-expected-aml.sh script and update the
bios-tables-test-allowed-diff.h.

These are all new files being added for the first time. Hence, iASL diff
output is not added.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240716144306.2432257-10-sunilvl@ventanamicro.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   6 ------
 tests/data/acpi/riscv64/virt/APIC           | Bin 0 -> 116 bytes
 tests/data/acpi/riscv64/virt/DSDT           | Bin 0 -> 3576 bytes
 tests/data/acpi/riscv64/virt/FACP           | Bin 0 -> 276 bytes
 tests/data/acpi/riscv64/virt/MCFG           | Bin 0 -> 60 bytes
 tests/data/acpi/riscv64/virt/RHCT           | Bin 0 -> 332 bytes
 tests/data/acpi/riscv64/virt/SPCR           | Bin 0 -> 80 bytes
 7 files changed, 6 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 70474a097f..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,7 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/riscv64/virt/APIC",
-"tests/data/acpi/riscv64/virt/DSDT",
-"tests/data/acpi/riscv64/virt/FACP",
-"tests/data/acpi/riscv64/virt/MCFG",
-"tests/data/acpi/riscv64/virt/RHCT",
-"tests/data/acpi/riscv64/virt/SPCR",
diff --git a/tests/data/acpi/riscv64/virt/APIC b/tests/data/acpi/riscv64/virt/APIC
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..66a25dfd2d6ea2b607c024722b2eab95873a01e9 100644
GIT binary patch
literal 116
zcmZ<^@N_O=U|?X|;^gn_5v<@85#X$#prF9Wz`y`vgJ>9#P+??1=7Rt_Us?qr5)aeJ
KkN{%wz_<X^jtBt&

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/riscv64/virt/DSDT b/tests/data/acpi/riscv64/virt/DSDT
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..6a33f5647ddd6de3a0f000f718b58f6fff44f0fd 100644
GIT binary patch
literal 3576
zcmZwK&u`mg7zgmjiJLf%lR7`zq;1+{Fo^@2^d_OS7etfS?V2fRL!7NhLGq-k6C-Gp
zF^~pAOg%8DxNJpSxD?U90wICKi5oX25JxWj18_5X{3G*svn#pr+xPjt@8_-EzP4;@
z{9leJakslKckM>^&7o{G8V!Yr_%nYu<zH_(cGsDl?5a`-p*g!fE7y_3o)BV#H0OHH
zBF!0e#)X&k%hk&YaaHtq_Ih%%xpN?Q{Gd0s2iJuVEz%r&+|jd|BV|X?967QJ1wH?H
zhRaQ}N<{Z*a<b8r;S@%;ydi{W&ZcnH?$R@bWDwo-3T0aE4}!@DmF-z254NmV{K3fN
zA-_zKqUheJnq%2kv6U#4bhG@#{o{u_Uky$l{rK%q*S=SZD@w7N$Q{1>-r@Aht-D9>
ze|U7~@ID!|wMmncj(TGhPPe}|+808sKOJ=D42L$oFMnuWGzNPSO@FO0f*0wzh(;tL
z5kz!(7Ol7lJrS27A{ohOMmshm8JDpY$xx#iuf%4kaT&u%##}UGJvL)5F5_k-BNfef
zH8vv^mvJ1)NJld^Vl&cl84n^ET9DCG`?Ke1xHlA1?96VC;m9uJ^{jUnHoX4+osDhf
zlw*%<W#UH#cL_u(8bn=+iSpZKQP+4@!QBE;e6vKS^+HUR--cPiU4vOk%z7~<%Ws=y
z^}im<Uhn{OR!3~|n)IyTil1hC`zmQpx4So6M|(Uf)b-ksB=zWs8YHMe79G(?bej(8
zh=@bH$7nbjm--**4~khe>$=3h8}dIZef~33G`L+)@bZKg$-WS6D&|zfbrs^8=In~A
zT2##YKlAF^PcOMr1bq`;WovfDm0{O}Unzph1bLO=C`qp}oI%p747(=%%4SfR^ee+r
zRIf6ef$CL;T~)s_oV@B+hNH}Za}Jzy=$!K_!%<S;Oo20n&J;S+;7o%vjm|VWHE?R+
z)X=G+GXu^HI5X(Xpi>8@4o)4NIy$r9%z`tE&MZ0&a2nt=&}pDE2hJQgbLh;WGY`%@
zIP>VtqjMgd^WdCE=R7)1aGKyW(P^Ty0L}t93+ODMvk1;2IE&~kqO%0f5;#lfETOXu
z&N4X5=q#gi0h|lqTtMdnIv2sY2+l=xE~2vn&I&jy=&Yc#3eGAxtLUtva|xVF;9NrI
z5;~W`xeU%_bS|TF1)MA3TtVjwI&0vpfwP9r8ah|OxeCrzbgrUv4V-J>Ttnv?I_u!9
zgR_p#dgv@0j_h{m!XP5y?^brx`n@l5l;9>Jmru&W3Xu`M5^TAy`&sa=u=TJ)ioqLB
z?{K~Dlq6E<^yNs6ckrIlbzT0)0EfTV)a>iSA!%|v>Qi|q<Lui~J)M%Y4w~n?>9e<a
zCqEhd+5Wd)+xq6<Ugzi6e!q1()m3R7v`(kGCar_^F<)>Fe`s^mCw$WDd_FfHpWRkI
z<v_1@^L+8~S=i5SHu;Cg+?m@irr+iLb{?d8F)d$lEPJ4yU-D=3+s3bd+v^_>9##Gs
zEd3$}=b5v2=%SER6h6`9WT1|=?a1~=daq3U;?mZ|bL%5`QC!!39TtaQZM==v|D}}K
A9{>OV

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/riscv64/virt/FACP b/tests/data/acpi/riscv64/virt/FACP
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..a5276b65ea8ce46cc9b40d96d98f0669c9089ed4 100644
GIT binary patch
literal 276
zcmZ>BbPf<<WME(ucJg=j2v%^42yj+VP*7lGU|;~TK{R!N0J?Fk=mG-;0$qJWL3RTG
D;^qed

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/riscv64/virt/MCFG b/tests/data/acpi/riscv64/virt/MCFG
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..37eb923a9320f5573c0c2cdb90bd98409cc7eb6f 100644
GIT binary patch
literal 60
tcmeZuc5}C3U|?Y6aq@Te2v%^42yj+VP*7lGU|;~TK{OIDfU^ICXaEdF2LS*8

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/riscv64/virt/RHCT b/tests/data/acpi/riscv64/virt/RHCT
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..4f231735abad925435c3cd052e6641b1b4187278 100644
GIT binary patch
literal 332
zcmXBQu}TCn5C-5sDu-BDTQ1g?$6<ZfTp=iGVK+>&SuVKAE}7g4Q~4C)^I7^5Cy7(c
z_YX|<Kks+14+b#T+sEDhrQ5ze?Yge(41k)ebw0non->7?Tl$5;5Aw2EhsZ<kNQ2v~
zZN*OUpZOoHIF1vy5QfGm?aO8H^-d*Mr0&5d=L2atgj8lewvWRcNn<>Yq`X;YA!Uve
zDUVqk>2Qc4kvb-IJ*j0<Ye}t;z84a4ZZ5ex9aHhyrw<Y-3y<9Nt|wWz_asY53y&nr
fY-54J6%4S#>I|1P;dHuz!Fg+;c5!QfI|KXypVnys

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/riscv64/virt/SPCR b/tests/data/acpi/riscv64/virt/SPCR
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..4da9daf65f71a13ac2b488d4e9728f194b569a43 100644
GIT binary patch
literal 80
zcmWFza1IJ!U|?X{>E!S15v<@85#X$#prF9Wz`y`vgJ>{NU;r@%Kx_d9E(Qh$c8~z`
M|NsC0LsftQ0Q@}*0RR91

literal 0
HcmV?d00001

-- 
MST


