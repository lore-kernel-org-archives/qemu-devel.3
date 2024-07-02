Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0CB6C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeEJ-0006OE-Ce; Tue, 02 Jul 2024 10:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeE5-0005Ra-Ol
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:11:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeDp-0000Rl-Sw
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:11:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0xyAuW055SU97MgsZtqzgKijVpNO++k4HuluYJlbn+s=;
 b=GHQGKpSw0wmhP6WEyuhf5Bs7LZzJ+vmIUzSxGFqTlGg9EiiL5xx+zRXP2Imh2QgUXnHbUI
 s5hK4K5vCzv/3zYvpI7nr+ZZqQJRHg3ipB3Y53LmCr65XkXNB5ntAdDGchWAhkPWFfL5F0
 a3eLIIrqauvyRdf5QEeRntsVA6Az4R4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-phX1d6ZbMjujvU-Du6Fjjw-1; Tue, 02 Jul 2024 10:11:01 -0400
X-MC-Unique: phX1d6ZbMjujvU-Du6Fjjw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4210d151c5bso29352615e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:11:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929460; x=1720534260;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0xyAuW055SU97MgsZtqzgKijVpNO++k4HuluYJlbn+s=;
 b=bZVmouM81vgtwDQQnvwOqihN1MT3O6wxvzYuKh7nG7DXz7aE76kBye5FkI3BJ23zBR
 iRXxFyUuFjWpbNRAF7z83Rd4DMBP2NZcXCa8Y+e728UPih4OvzbMPAK1J+0OfpGPLs21
 GOk8Kv9w2ewC9EsaCEqdxDA3cee+c6rpATUfdMzHTR5wEQRiFVUUhhzFgzZFy65I1B9s
 8QDtAtwqYXo7VtOvu+SNsXjQV0bH1vACLazt6aD/mpjtbvUSRVfbWvcpJZ1e0mgylk1s
 3ZW4GERPz0XugiRxZms3qZsvbJOMBwDW8Nyx1oscWfMl8oopNgV3ckomLNjYF1lIA3wa
 +qOQ==
X-Gm-Message-State: AOJu0YwAtLLiB6/OEhNux4BDiYH4ippmBPwbo4oiQTN+rPKJefV+aO01
 tUtNpt9/QH3WguTiUQAEwAH+wKm45pWbaDt7geB1JjP+c8/aOab2qJatoDQANwaOaF2lwc6NLvr
 3MUTGVKq2AjmT0DrsWW+iR6R3tLsXWJ4EbW3e8rQxSOcpRovXxFUXqrL3g97CHFzJZ8X9yGGDeX
 lxzdhET6bcfe7AQwU7CMJJlvi3jwS+0g==
X-Received: by 2002:a05:600c:5486:b0:425:672a:7688 with SMTP id
 5b1f17b1804b1-4257a02b722mr60396605e9.31.1719929460285; 
 Tue, 02 Jul 2024 07:11:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGB4Hx420q2AMejLtsc1rfQ0V0LnpzgBIxjP8QLTBlTubxh+yxZcos7opNP6u6wCRpnaDkxqQ==
X-Received: by 2002:a05:600c:5486:b0:425:672a:7688 with SMTP id
 5b1f17b1804b1-4257a02b722mr60396355e9.31.1719929459789; 
 Tue, 02 Jul 2024 07:10:59 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0e169dsm13256393f8f.65.2024.07.02.07.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:10:59 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:10:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 77/91] tests/qtest/bios-tables-test: Add expected ACPI data
 files for RISC-V
Message-ID: <5d7dfa170ec9731cf2808102c0f65517a8fd2b80.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
Message-Id: <20240625150839.1358279-17-sunilvl@ventanamicro.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   6 ------
 tests/data/acpi/riscv64/virt/APIC           | Bin 0 -> 116 bytes
 tests/data/acpi/riscv64/virt/DSDT           | Bin 0 -> 3518 bytes
 tests/data/acpi/riscv64/virt/FACP           | Bin 0 -> 276 bytes
 tests/data/acpi/riscv64/virt/MCFG           | Bin 0 -> 60 bytes
 tests/data/acpi/riscv64/virt/RHCT           | Bin 0 -> 314 bytes
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
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..0fb2d5e0e389541209b765d5092d0706f40298f6 100644
GIT binary patch
literal 3518
zcmZwKO>g5w7zgmjiIX_aOKm4@(l%|fuo4Hf(j=j@7eo`gFRq%_8>bX0AR|>>u>>sz
z7Ni9sRynXxaoMfJg-a2Y_znmG5+`olcsq093+&NoJa*Q9)~@8n(|P_gKi86<Sgtkt
zu|$-5y?<!#x~=}Jj@fFpS`rcQ&-}M$|M{Bd_Pz0RS2h`AinnW9rJm{7jIni6yd&Ep
z#T)cS`g7{_`gMtTRs8t>^?16meQa)vpqpERBgR;V6we*?)PmxfW=~Q)bLi^2TK+80
z%QdY|ME7Vs?dQzHLAVF!z+r2wJ=+2=SyF4Fgfw3GMV2H<4Qdt7axJ5i(krS~{low3
z`#WC_&L95p^-p`>O2)Ee)KjICx8FIL+_?4L>AN4C-Z{BPMcUk;@w6wuGK}2&2g5_g
z*xHjtXS<D-)`B0gG^g`z2N7){#t2S*DxwvONJVnKi%wF6no7!Gv5a&)qnntKPRiJf
zWytZ27ZNk%qzosPk%?!lC1zxjGTw+~WaAkxCT3)lGR|Tdxp>BUVn!}0<9;kd2{ZP-
zb4)w-ME2MQDV}Lt!SmT;UH)Wm?U3U2`v<ef#vKjyrrL1GB%4mDMT}Zx(J6gMx9NmV
ziFioxU^v53W&eHkzEO}1zE3-@%}9Kfc3itnMv;%JsU6quL>K8D*Y1*0l8e4C5wB^_
zu6R|4jI#J!P}hBO$tzhnHx*QNW>>s2nwk=oEUZjXP#LX~4l1J^q=U+6YFbpb!^*U%
zj8>6@%4i32P#H~?MP;;kSyV==WWbpLX9k@aQ5mh01!oqVS#)O6nFD7IoH=yn(5Zk^
z0jGja1)X_t=E0dqXC9p@I8|_}=v2{J0A~T51#}kBSp;VhoJDjN(OCj#37jQ#me5%S
zXBnJjbe7RM2hKTg&Y^P-of<ebaBAq((5Zt{2d9os9i0X^4R9LhG|*WAX9b)UbXL$=
z1!onURdiO-IS<ZxaL%K19-Rx|Tma_+Iv3Dc17{7KHFVa{SqEnwoON{8(YXlDMQ|>n
za}k|O;9LUd5;~XAxeU%_a4w^B8J!JqHo)0HX9Jxp;9LRc3OZNNxeCrzaIT_r6`f6R
zHo@6MXESn+r?$*rYT`A|n?{pu&tAmN(ACRoA!rm^!7E+#o;X&`dhXDb!l<y3gD6RX
zsA~yPVr&+*$9EMrbP&b+x%jr8Nyrjom=!j5n3cw?XA`o-SeR8UdS<^zS4ARX;#TbD
z)VrUTD8+|}e14K1)QE~vW54P9{-<Hbzxkj>Qjs^D!QltfDNQ8N`SY=w;NU%_@B92U
z3Ww-575B(-NHIsleX4Hfy+hZO&nIMB$L-7A+{K%`lOGTM?mlidHorQ)+xz*Y-*25y
zRN1tSJLeNsF|Fh78Nc8;{6m*Veaug4lb<iOM;EuHPk3N3yM4Lv=pvdYhBf}jGd`J*
zUroL#i*de4`)X3X;aToLzPu)O^V|Bb|F~-(4IbA19W4H04leT-Z_$;WmLz_n@pK>$
hw_JD<`4=Dl#igsVr|u8qH^uk;m*M8{uQtJd@jo@e>K_0A

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
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..beaa961bbf0f0486c0dee25f543377c928354f84 100644
GIT binary patch
literal 314
zcmXBPu}TCn5C-5sDu-BEiq$^EvWVqvbDg3Vc0-cQvcXL@WO5Nw`4r+?+4?po$xSie
zKQPVzav0wp1t8S^X*|4k`}gOu>$*+=sJU9_>-(p91>m8jKM4FH=ApMv&XcBM_0X$|
z+T59Nrc|_an{2_(jg{M%j%@1fQ><{^v+>$kDt56x1$k^AOK?==&_|{+FV1=@T2j#y
z6(y-CMMW`{k3`H`hZL*Z(I*p)|0L#=<tm#-PsCYHhB#ZF<w~4`atRQ)fdF>cUEsPV
SoKANTxNMzk^IHMj3*aAn-C+R$

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


