Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9016EC19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 09:28:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnwew-0000q3-Ex; Fri, 28 Feb 2025 04:27:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tnweh-0000V9-Fc
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 04:27:39 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tnwee-0001Dw-BA
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 04:27:39 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxXWuGgcFne9OFAA--.33057S3;
 Fri, 28 Feb 2025 17:27:34 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxLseBgcFnU5YtAA--.40659S7;
 Fri, 28 Feb 2025 17:27:33 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 5/6] tests/acpi: Fill acpi table data for LoongArch
Date: Fri, 28 Feb 2025 17:27:28 +0800
Message-Id: <20250228092729.543097-6-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250228092729.543097-1-maobibo@loongson.cn>
References: <20250228092729.543097-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxLseBgcFnU5YtAA--.40659S7
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The acpi table data is filled for LoongArch virt machine with the
following command:
  TEST_ACPI_REBUILD_AML=y QTEST_QEMU_BINARY=./qemu-system-loongarch64 tests/qtest/bios-tables-test

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 tests/data/acpi/loongarch64/virt/APIC          | Bin 0 -> 108 bytes
 tests/data/acpi/loongarch64/virt/APIC.topology | Bin 0 -> 213 bytes
 tests/data/acpi/loongarch64/virt/DSDT          | Bin 0 -> 3614 bytes
 tests/data/acpi/loongarch64/virt/DSDT.memhp    | Bin 0 -> 4951 bytes
 tests/data/acpi/loongarch64/virt/FACP          | Bin 0 -> 268 bytes
 tests/data/acpi/loongarch64/virt/MCFG          | Bin 0 -> 60 bytes
 tests/data/acpi/loongarch64/virt/PPTT          | Bin 0 -> 76 bytes
 tests/data/acpi/loongarch64/virt/PPTT.topology | Bin 0 -> 296 bytes
 tests/data/acpi/loongarch64/virt/SLIT.memhp    | Bin 0 -> 48 bytes
 tests/data/acpi/loongarch64/virt/SPCR          | Bin 0 -> 80 bytes
 tests/data/acpi/loongarch64/virt/SRAT          | Bin 0 -> 104 bytes
 tests/data/acpi/loongarch64/virt/SRAT.memhp    | Bin 0 -> 184 bytes
 tests/data/acpi/loongarch64/virt/SRAT.topology | Bin 0 -> 216 bytes
 13 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 tests/data/acpi/loongarch64/virt/APIC.topology
 create mode 100644 tests/data/acpi/loongarch64/virt/DSDT.memhp
 create mode 100644 tests/data/acpi/loongarch64/virt/PPTT.topology
 create mode 100644 tests/data/acpi/loongarch64/virt/SLIT.memhp
 create mode 100644 tests/data/acpi/loongarch64/virt/SRAT.memhp
 create mode 100644 tests/data/acpi/loongarch64/virt/SRAT.topology

diff --git a/tests/data/acpi/loongarch64/virt/APIC b/tests/data/acpi/loongarch64/virt/APIC
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..3477789f422cad54f16734b3ec9ad1ff5135165d 100644
GIT binary patch
literal 108
zcmZ<^@N~{$U|?YU>g4b25v<@85#X!<1dKp25F12;0Eiakhw;E%5ne`ShX4P;(hQ=)
ZK)Db4AdUkN9{^%8L6C9*AO@2T3;;5a3;_TD

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/APIC.topology b/tests/data/acpi/loongarch64/virt/APIC.topology
new file mode 100644
index 0000000000000000000000000000000000000000..e14bbf758464b146665bb0e46d193fe2b57b5db6
GIT binary patch
literal 213
zcmXwvxeb6Y5CqS>5dw=RrUP04oInH;2^CN$P0$A&m|b)}X?!!br+sygh?r~M+;a5u
zxw{@?a7X9naN9CeNOl0P5t8WV7)mq~DA7!zL^FdD%^XUYO<`j39)@XaT)hKz1UKj`
Ke^uZ=NBIDAN(})3

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/DSDT b/tests/data/acpi/loongarch64/virt/DSDT
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..6a619874ff25a5eacd68d0dd51e8314df3a7aad3 100644
GIT binary patch
literal 3614
zcmb`K&u<$=6vt=nb!@MHWbHUVoH((2;(&_QwIV<QDfZe)T<m1=rUc<it`w!B1cmTZ
zDitE+P$1&cTH=C)jL2VskXnfoH*QpLNI7ufjySsCx3lZa1Iw4Pl4tfi``+94nVt2#
zt-JM|m9!Arx3z71(=F9rckB`lO$b5f)SI@^b8Efs$t!VtyKTjKo6UO4*>bE^t1M!@
zYt1@Z+pcP8J8tGB<Hgfwg-DXCcRbb}7wP0YBzrlE*0=a_O2oAq^likcyY*}(l$kNi
z+@s-dKOBD5KE3zjHxI6UuVo8bHXllgKmLxS_TGMH@8I&y_x2Cp{c!(q@AkiPERV^N
zvYU{jpWAtOLXP%R=2-XVu|@NEWlWAnXmXN%a_9PlB<ufYl9h2uh9@WKCwCs1kYwZO
zlI)%|^_FEROVPI0M@!McB1{_zEGtcO{2S52<YT$1p4)LXKa{d!Mxn4`)KIUE2_?ry
zp{`O^%7Yz+q6e$S>Wqmc$9ODd{x4!-{?%CSm{@Xb6sy*E?4~kXRqF+MW&PK<YE_`z
z#s=D2ZEG}-?oKCDGzyNeMN{mHlCbcr<Lo1GOYET+6vTU{oX*Zn>wV)mo6r-(p`d3Y
z<hh3PvdAWB+z8S11R@Mk5!sZU91ihMAnklbUNB6{Yn~rW14*8U@7abtPuTj3JOk5^
z@H}Dac|wvWvhi%go@bCjSdeF68kU|g^*kZTGq{WHc?KEio@ZdHOV1#ANR>0fI3u2C
zU>cF0LGq9)=M>|_(pEU9I47ja8D*SN#u??DkSb@4amE;DjB`S&oN>k(XPj})38``#
zjMHG82IquSITMUC!8j9~6H?_&GR`F9Oma?0l{3XSQ;ajkIU!X}?77N{N;A$h=Y&)_
zry1uo<DBN4kSeFiI8DZBa!yE<Gs8GDj5EVIAyv*S<IFP7Ea!w&IcFH>4C9>PoRBJK
zj&bG~XO441s+_ZobCz+=a!yE<bB=M&G0r*838`|<GtPO&InOyERn7&*xxhFVI47ja
znP;4N#+m1wkSgaQ<6LB%i<}cu<y>N%ON?`gb3&?|1;$xmoCVGasd6qe&Sl2A%sC-d
z&K1VF!Z=qrC#1@WT37xzd%H}LaTYlzq~y#cdv>iV&hSqpO4w9Ut!zb%H@-*-6ufkN
zir=yL9IGRVeM=t02k6(tf_NwdueiN&G{fPL9Mxlu1PX2Un&XI=z0+xl+<LsX?b`b3
zfw1el<-umO|0WgS-S+R5e~N{*uXjJFK79Gto2Lhc4udP`W9TbKBq$D@R4CLPYK$Va
z1M`0Wmi7s*ls)V6VD5fDu#>|kT|6RV8b3SuE-lCDCgrn(++}<WwDrLynawZH|NN)B
z`f>Z-{9o<-Pj-6{@4qF^GGR@lMs!cwdZ*zkMUIXAT25ufu>LbYC7K7!&ok632lhOg
zpYBO5di^>2?Ad74d$J0y+D;SY0~Jg7=1Jj#A72)hVQoXY9ydCurSRO+rlEH~OOUi1
zZlhJoE%zF)?Zl5r+!&bsJ2wofQSLgsotkmnJ;~F_MagYjw!9b8DX+HzxYkx@8+oky
u*Cb=cNZ-Xiiwy9#2#pBH#jk6*i~pf^;eywMTuk#iV!ErnY*aT;s)#2;qXaGh

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/DSDT.memhp b/tests/data/acpi/loongarch64/virt/DSDT.memhp
new file mode 100644
index 0000000000000000000000000000000000000000..d7e2ff7031f5fd853a3a49e52f865f8d4ce49e2b
GIT binary patch
literal 4951
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

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/FACP b/tests/data/acpi/loongarch64/virt/FACP
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..04d8d4c26fa2be24af40cd7a72959ec6b12790e5 100644
GIT binary patch
literal 268
zcmZ>BbPnKQWME+Ra`Jcf2v%^42yj*a0-z8Bhz+8t3Rnaf7&sUh<QVvX44@rUHJnJp
PfcDEk?FYF<7Rm+yEcXWi

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/MCFG b/tests/data/acpi/loongarch64/virt/MCFG
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..5f93b05abe1669fe4239edbba8aaf4fe666f5b95 100644
GIT binary patch
literal 60
rcmeZuc5}C3U|?XJ<K*w`5v<@85#X!<1dKp25F11z0R<?#9z+8GC8Y-e

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/PPTT b/tests/data/acpi/loongarch64/virt/PPTT
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..7a1258ecf123555b24462c98ccbb76b4ac1d0c2b 100644
GIT binary patch
literal 76
zcmWFt2nq3FU|?Wc;pFe^5v<@85#X!<1dKp25F11@h%hjKX%HI*fMQ%gwhD|7qyeJ>
B2LS*8

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/PPTT.topology b/tests/data/acpi/loongarch64/virt/PPTT.topology
new file mode 100644
index 0000000000000000000000000000000000000000..4017e2927c15c08c7e1a7e4d7eb10f416b63d69e
GIT binary patch
literal 296
zcmWFt2no?(WME**cJg=j2v%^42yj*a0-z8Bhz+6{L>L&rG>8oYKrs+dflv?<D8>h5
zS>O<Zn}MVkSq!AN1c;en`l055#F&x9KunOm=;}5A#aKX+AOO`15@Q7mK*T^ykX~f-
UK=!@?Vm2TK1E^k*7&}x50Csu}0RR91

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/SLIT.memhp b/tests/data/acpi/loongarch64/virt/SLIT.memhp
new file mode 100644
index 0000000000000000000000000000000000000000..67f00813af7b2356fe74eed943ab8dcf2291578b
GIT binary patch
literal 48
scmWIc@eDCwU|?W;;pFe^5v<@85#X!<1dKp25F11@0Wk=0iHdRo0OYg>0RR91

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/SPCR b/tests/data/acpi/loongarch64/virt/SPCR
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..3cc9bbcfb8051e632592d9db0fe3dba0af53ed8d 100644
GIT binary patch
literal 80
zcmWFza1IJ!U|?W6=;ZJ05v<@85#X!<1dKp25F12;fdT{L1I7pP5RMa&VrKx#G5-ew
Ih!}(f071qL0RR91

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/SRAT b/tests/data/acpi/loongarch64/virt/SRAT
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..ff234ce45cbdd32f57fc0668aba135992e5ca887 100644
GIT binary patch
literal 104
zcmWFzatz5}U|?We=j89~5v<@85#X!<1dKp25F12;FdPV=@)<SYGB5@QjDf5V0BFYt
A0RR91

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/SRAT.memhp b/tests/data/acpi/loongarch64/virt/SRAT.memhp
new file mode 100644
index 0000000000000000000000000000000000000000..60e8d2a136be43c6479740a28b85a1348f044322
GIT binary patch
literal 184
zcmWFzatztQz`($G$jRT?BUr&HBEVSz2pEB4AU22wVK@*#<uhu)Wnc^z7z0@!qXwJ@
WlZVkL<|C=&fSO|gGmja@0MY>X$p`@e

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/loongarch64/virt/SRAT.topology b/tests/data/acpi/loongarch64/virt/SRAT.topology
new file mode 100644
index 0000000000000000000000000000000000000000..75e0703ae0d3348919e2b583d1b4f4b8bb3ef65d
GIT binary patch
literal 216
zcmWFzatyh_z`($`+R5M9BUr&HBEVSz2pEB4AU22wVK@-L;4`AhGokUB(fBNAd{#6*
V8ycS-na`*JcL|Ka0b?Mm0|55#2mt^9

literal 0
HcmV?d00001

-- 
2.39.3


