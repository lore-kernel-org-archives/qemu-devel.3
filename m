Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA47CC3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgmW-0000aX-JC; Sun, 21 Jul 2024 20:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgle-0003VX-8U
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:19:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVglc-0005z1-Fu
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MeXmlkXUO1c12DbabmZ2BwxdEJDDqafMQQCrC5Sf5B0=;
 b=LxIodMakSr3W+4vcYDMODrdyrUEMHtSUmeiteCv9pVSz9ZUZgA1EBSNuIOGl4Uuk3QmmL8
 31VldqHq27k9Imf6XemxthNpWo8wt8BxjoHK2EprblFESOehS0DsBB3eJ2wyV9gCipfrz/
 z7Vih9p1swQqu3qget2vss7+xdxfLcM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-mI3AK4OmOByK3xvdwfHEaw-1; Sun, 21 Jul 2024 20:19:00 -0400
X-MC-Unique: mI3AK4OmOByK3xvdwfHEaw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-369bf135b49so665407f8f.0
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607539; x=1722212339;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MeXmlkXUO1c12DbabmZ2BwxdEJDDqafMQQCrC5Sf5B0=;
 b=s0xvFkdI6RnH/yrC9pynPWsCdLf/l625pWulRlpAz4BaQW5tLyEtR5CYf0+cffIfvx
 vINrj34yuq831CULaqsCDOUS6bfTjRsS8lfypY5JNmhVp7yIWx+2z+EWUEBgudoEdmRj
 BdPOMWP7ZePXS0xYQT8JL6Fwut0IyWSEiwYTJOHbQdfGKLfpBnSoaRQnhDNZ0hzlayQ5
 NQa0HS4qMOQbI7FsL10hqczd3hFrIR2JHh3gC437jPTJgdc7xEUislXPVKlCG33dRwAD
 /XjOlS5IyK3hdC1Uzo4n/eFG+/ppr4gI2MX1ARjXr/d+rPd8/APdkCsC/Tz9hi4qtovj
 kCCw==
X-Gm-Message-State: AOJu0YxCOjknUwajaEsnSySPAdcI/t3Ocd5eUhTjQu1TPKXHNgCTFQj0
 qL5ZEV1na5d8MsR4hMCj6kHBBj4A1W5RHafd1+ucONxuOcBglwmzU0ENPnGmLgGpEV7mKV9iak3
 aW6VzH9M1O4SOKanKIua3j1X6cWh9Dx/uSYcGIE775W3eMOhOJTzfq2P2CaEgVOUhzSDOIRF1pL
 m+nGjD59i9dIWt1nhwUyyNP57mdQAEIw==
X-Received: by 2002:a5d:6e06:0:b0:366:dee6:a9ea with SMTP id
 ffacd0b85a97d-368740244d5mr5158849f8f.26.1721607538727; 
 Sun, 21 Jul 2024 17:18:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK4RM+QFGyLG5C1KGTK/gxitW6L130y3xBcxwJs2s7cA7UZeBkcqghNyypqVCn4UqfRX+4XQ==
X-Received: by 2002:a5d:6e06:0:b0:366:dee6:a9ea with SMTP id
 ffacd0b85a97d-368740244d5mr5158834f8f.26.1721607537941; 
 Sun, 21 Jul 2024 17:18:57 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868480csm7009779f8f.13.2024.07.21.17.18.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:18:57 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:18:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 59/63] tests/acpi: Add expected ACPI AML files for RISC-V
Message-ID: <ec737d2443427a6313cf8af2fa0c5f375938aab2.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


