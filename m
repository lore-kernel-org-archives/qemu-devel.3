Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6819C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSJE-0005JM-VD; Mon, 14 Jul 2025 19:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSHu-0000fX-5k
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:08:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSHr-0005kz-N4
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:08:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V/R+KY4VQRRbizT88wU7WUhx0oUQIp3fO24ZLvNWgZU=;
 b=hgx9SCa+4L3GaxXoAXhLzFq/myyRC96hslz2YIqvlFkHTCI81GfR3CTfArm+7FAzCHztYd
 Apk/aHhfvuHUXTJhvuzZZUjgGQai9sxMUCvlS8EzQAzqn9TjtmSJ0Av7MEea/NVnEEvhyF
 2MAg4vsJjmA9L5l+L8/tHJatepRlgTQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-ChGyyuyCMKem6qBr6vsd1g-1; Mon, 14 Jul 2025 19:08:41 -0400
X-MC-Unique: ChGyyuyCMKem6qBr6vsd1g-1
X-Mimecast-MFC-AGG-ID: ChGyyuyCMKem6qBr6vsd1g_1752534521
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-453817323afso30143765e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:08:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534520; x=1753139320;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V/R+KY4VQRRbizT88wU7WUhx0oUQIp3fO24ZLvNWgZU=;
 b=p8zyP/e/9zglQ2wO9S5JZHI5R36v6OCIHkKMwgoXMpdQ+1qAxDY1ip+NOvZVpKu2qT
 xPOGR4uYEjdv7GVuKuiaq3BbqHwwf5myXOHbXh54Mkpl0iJpwopmaJLHKjEtWry4cqny
 DNdBO325o+fWcjFCNp9Eig276oxenHBmmeuuY/Elfxlus1Qudf8VlW46Ym0gR+SADDJ7
 f/iHePePF/pQ0I/QVeDXuVWH8XMr/OS0DmcKHnFIPiqZLcKFNF0O26iUQqqJpezkaCKU
 dxUoEnDQJY9dejVUNQO3/w2g9ps5gnY0YK1vgnzaCtC2vwWxORSJZBywXaxXOVfFlikm
 oSPQ==
X-Gm-Message-State: AOJu0Yw0k1nfaDzkPzXT2lol7IkhemdbtQJbCUEW5pzRZMp2lfgbM0Zn
 Jb5DA4bKI3bnmI814lRqq+Sx3NosjQsGvsnrVGXBZTtHVbhnL09IX3IwKuBrg93CssYk7Y/WXDT
 0dcdesK1/pdrIB0rIlD7CoCWYpNPNOvF0WMx38of/MUjIyR2LRkiViNK426BUkxvEyIqdYkMj1h
 k3MxSqxY/GXHJPF7UOTb8oUpIor2wRf9+Uxg==
X-Gm-Gg: ASbGncv1qp7hjYZTSva1gGq92S53rYZi0PvMw+HxJracYypMgPzp/a5GTYualf4/KLv
 eSLSIARYRL3Q1rsnZHY+YnKzE25vjAjce1AnodoDRZpUf6wySiLexjM9AvP5F9mz7OTvn+JtwFF
 LKA6qH33bar/CenBMDQi/EnuzOnyEylRsHyy+8L6Loo08k/OVOcxq+qBnmm2FiKnNwWuaFAGSp+
 njdXYhwADkz/wj+j8uD767Niy/8+HCOyaSkpGLqrR/oab5aG884mUqkjwt1qOU5siAsR48PYmE1
 3JJ2cUIiE7ukXZqYBirT97yezAzNAi39
X-Received: by 2002:a05:600c:1911:b0:456:1121:3ad8 with SMTP id
 5b1f17b1804b1-45611213e56mr89942055e9.10.1752534519687; 
 Mon, 14 Jul 2025 16:08:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2Aj/fEqrfbWaXIgnIhxGjFU9/8STpcIqEYgLQZS9QpAiasXhxney2CLGzcaOQOS3zb9wpZA==
X-Received: by 2002:a05:600c:1911:b0:456:1121:3ad8 with SMTP id
 5b1f17b1804b1-45611213e56mr89941815e9.10.1752534519151; 
 Mon, 14 Jul 2025 16:08:39 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd4669c3sm143763815e9.14.2025.07.14.16.08.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:08:38 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:08:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 56/97] tests/qtest/bios-tables-test: Update DSDT blobs after
 GPEX _OSC change
Message-ID: <e3f9a69b374b7924711738493ebc378833ba3625.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Update the reference DSDT blobs after GPEX _OSC change. The _OSC change
affects the aarch64 'virt' and the x86 'microvm' machines.

DSDT diff is the same for all the machines/tests:

  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x00001A4F (6735)
+ *     Length           0x00001A35 (6709)
  *     Revision         0x02
- *     Checksum         0xBF
+ *     Checksum         0xDD
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPC    "
  *     OEM Revision     0x00000001 (1)
@@ -1849,27 +1849,26 @@ DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPC    ", 0x00000001)
                 {
                     CreateDWordField (Arg3, 0x04, CDW2)
                     CreateDWordField (Arg3, 0x08, CDW3)
-                    SUPP = CDW2 /* \_SB_.PCI0._OSC.CDW2 */
-                    CTRL = CDW3 /* \_SB_.PCI0._OSC.CDW3 */
-                    CTRL &= 0x1F
+                    Local0 = CDW3 /* \_SB_.PCI0._OSC.CDW3 */
+                    Local0 &= 0x1F
                     If ((Arg1 != One))
                     {
                         CDW1 |= 0x08
                     }

-                    If ((CDW3 != CTRL))
+                    If ((CDW3 != Local0))
                     {
                         CDW1 |= 0x10
                     }

-                    CDW3 = CTRL /* \_SB_.PCI0.CTRL */
-                    Return (Arg3)
+                    CDW3 = Local0
                 }
                 Else
                 {
                     CDW1 |= 0x04
-                    Return (Arg3)
                 }
+
+                Return (Arg3)
             }

             Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20250714080639.2525563-11-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h   |  11 -----------
 tests/data/acpi/aarch64/virt/DSDT             | Bin 5196 -> 5158 bytes
 .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5282 -> 5244 bytes
 tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6557 -> 6519 bytes
 tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7679 -> 7603 bytes
 tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5398 -> 5360 bytes
 tests/data/acpi/loongarch64/virt/DSDT         | Bin 4641 -> 4603 bytes
 tests/data/acpi/loongarch64/virt/DSDT.memhp   | Bin 5862 -> 5824 bytes
 tests/data/acpi/loongarch64/virt/DSDT.numamem | Bin 4647 -> 4609 bytes
 .../data/acpi/loongarch64/virt/DSDT.topology  | Bin 4943 -> 4905 bytes
 tests/data/acpi/riscv64/virt/DSDT             | Bin 3576 -> 3538 bytes
 tests/data/acpi/x86/microvm/DSDT.pcie         | Bin 3023 -> 2985 bytes
 12 files changed, 11 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 8d9673cb5d..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,12 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/DSDT",
-"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
-"tests/data/acpi/aarch64/virt/DSDT.memhp",
-"tests/data/acpi/aarch64/virt/DSDT.pxb",
-"tests/data/acpi/aarch64/virt/DSDT.topology",
-"tests/data/acpi/loongarch64/virt/DSDT.memhp",
-"tests/data/acpi/loongarch64/virt/DSDT.topology",
-"tests/data/acpi/loongarch64/virt/DSDT.numamem",
-"tests/data/acpi/loongarch64/virt/DSDT",
-"tests/data/acpi/x86/microvm/DSDT.pcie",
-"tests/data/acpi/riscv64/virt/DSDT",
diff --git a/tests/data/acpi/aarch64/virt/DSDT b/tests/data/acpi/aarch64/virt/DSDT
index 36d3e5d5a5e47359b6dcb3706f98b4f225677591..acab6e65febbc210158d4c39be0680bbb90250f5 100644
GIT binary patch
delta 114
zcmX@3u}p)@CD<iIO@x7g>C8kfX{JVpjp}Y(OkR^V=X2?C2#NTx$NL96vvg%MIJ<-!
zF7RWWyjw`i#5kckflEGNfxx86nT)j{87>a6yzr#S&Mx7`2@o*>kXS(iNMs?;W@BMV
FMgSUfAKd@|

delta 152
zcmZ3caYlp7CD<jzM}&caNqQoeG*i3NMs+tXCWon;^SSgm<T!#u0|FR0oI`?q7)0DS
z<Nbr3S-P?roL#~V7kIEwUN5BOX9QAG;Or7^3{q7MBDmy1<N|?7lQS7>L29`;z&gYx
bO@^t12n&FO3qXoN;!Cm@@@?i7mSh9~5Tq&5

diff --git a/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt b/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt
index e6154d0355f84fdcc51387b4db8f9ee63acae4e9..54c27e7d95b4956ed1b5dee0d299ccb08dc2a73e 100644
GIT binary patch
delta 114
zcmZ3a`A37xCD<jTMudTZsdFNiG*i3lM)f&dOkR^VALY{H5EAiWkM|FDX6ediaCQkd
zT;Rt#Sx{KZ#5kckflEGNfxx86nT)j{87>a6yzr#S&Mx7`2@o*>kXS(iNMs?;=1yTr
FMgUJNAb|h?

delta 152
zcmeyPu}G84CD<iokq83=(~XH-(oDVX8`bA<F*!`#e3VO%LyjXjG$4S1!#O0#he5=R
zGu}VgnWZb6!PzC;aDfN=WL9A<KO>Nm0%w<SW00z95Wyu6A{Piunw-g43sTF)0oEZl
bX);V5L|6bMTmVuG5?_+NkZ*Icup}b@<J&8B

diff --git a/tests/data/acpi/aarch64/virt/DSDT.memhp b/tests/data/acpi/aarch64/virt/DSDT.memhp
index 33f011d6b635035a04c0b39ce9b4e219f7ae74b7..4330bc97cba0950191c45ac833533db7a190db81 100644
GIT binary patch
delta 114
zcmbPh{N0GlCD<jTT#|u->Fq==X{M&B8`a&on7k%!&gatO5EAiWkM|FDX6ediaCQkd
zT;Rt#dAE?3iE%=80+)Qk0)a`BGZ||^GF%*BdErTuon69>6Ch#&AhCi3kjO%w&Bnr6
FYyg6XAvXX3

delta 152
zcmexvG}oBRCD<iot|S8klg&gfX{L_p8`a&om>i~V&gatOkmCpr4G3W1a1IIbVGwcS
zjQ0<AX6ediaCQkdT;RbzdA*R9pAkq&fwN1vF-TQ4h~Sb3kqZPSP0nPj1*zrY0P7H&
bG#RE2A}jzBE&wS8i7&}s$hVnSIExJcpiV0*

diff --git a/tests/data/acpi/aarch64/virt/DSDT.pxb b/tests/data/acpi/aarch64/virt/DSDT.pxb
index c0fdc6e9c1396cc2259dc4bc665ba023adcf4c9b..7fdbc03e2bf9fb7d35704779253de36e362f0bf9 100644
GIT binary patch
delta 207
zcmexwz1f<}CD<iovn&Gx)9r~|(oB6fHmbXEG5NM`&ga^|E+pc^9`7IQ%+i(3;Or7^
zxWJEfa-NKqiE%=80+)Qk0)a`BGZ||^GF%*BdErTuon69>6Ch#&AhCi3kjO%w$<JhL
aH-8e+V`TE0v{^|+kAs?qZ+<2t$p`>t?mg51

delta 282
zcmdmN{ok6)CD<k8zbpd-Q^!OuX{N5b8`a&on4CK{=W}gfm*WTy4G3W1a1IIbVGwcS
zjQ0<AX6ediaCQkdT;Rbz*-%K!&j_TXz}Y3-7^JEiL~zN2$OQtECTB9%g4A+xfOUvX
unhaA15f%Um7l0Il#Fu0*<lEdYl+DQGFm>}EVLcA|TR*v9$aeB|nL7Yd7E^Zs

diff --git a/tests/data/acpi/aarch64/virt/DSDT.topology b/tests/data/acpi/aarch64/virt/DSDT.topology
index 029d03eecc4efddc001e5377e85ac8e831294362..969b4f6560d3ae39f5b7e0064b7122905476fce8 100644
GIT binary patch
delta 114
zcmbQH^+A)%CD<k8g9rly)24}B(oEex8`TB4nY<=#w&d315EAiWkM|FDX6ediaCQkd
zT;Rt#xm8%p#5kckflEGNfxx86nT)j{87>a6yzr#S&Mx7`2@o*>kXS(iNMs?;=D)&{
Fi~vUbAmso6

delta 152
zcmeyMIZcbpCD<iIOq79viGL!OG*hGhMs)#hCWon;ExGkL<T!#u0|FR0oI`?q7)0DS
z<Nbr3S-P?roL#~V7kIEwt`yetGXg0oaCQkd2C1qB5nS>ha)H34$(f9`Ahlc^U>#zU
bCd1T0gatst1t7&B@g>;{`8Hn{mSh9~yBaCk

diff --git a/tests/data/acpi/loongarch64/virt/DSDT b/tests/data/acpi/loongarch64/virt/DSDT
index f32e732b11a557ae01c7f383625d3b6f459ac9f7..b31841aec6ed296f10ea1695a67ead38f45424d5 100644
GIT binary patch
delta 108
zcmZ3e@>`k9CD<k8w;%%pW9&w*JIqWz6E?qK7T^#P@nMhm4|Znh%4TqO2{&Be$2wVz
zN6W-Gp*n#}E@6Sdq{*3#wICTT4zRrNq{+@M;l>FNF#(WRK>|o*A<yPMp2@5L$8#Uk

delta 146
zcmeyZyikS9CD<iIQHX(oannYwJIqW@lQ+L$7T}QM2o4PhVBl~L3G!hOapR2l4|Znh
z%4TqO2{&Be!9JObN6XI$q@=*vCEOUKsv1Oa$%DuR0+S|ZGS-6Ba&drlh)tRdQwI?i
V00|d>6obT<WH02~oWV1h6#%3ZDaQZ+

diff --git a/tests/data/acpi/loongarch64/virt/DSDT.memhp b/tests/data/acpi/loongarch64/virt/DSDT.memhp
index f19eae7d00f9c0eefc9e92de2c8a24863bf309d6..e291200fc91caa3d93dcd6ec4736f7340f5e3f65 100644
GIT binary patch
delta 108
zcmaE+dq9`VCD<k8fEWV<W70;hJIqWz6E?qK7T^#P@nMhm4|Znh%4TqO2{&Be$2wVz
zN6W-Gp*n#}E@6Sdq{*3#wICTT4zRrNq{+@M;l>FNF#(WRK>|o*A<yPMo(L`gz<eKx

delta 146
zcmX@0`%IV1CD<k8nHU2D<BpA7cbJ)+CU1VhEWjbh5gZy2z`)@g66C`m;>H>8AMDK1
zmCfMn5^lJ_gMBg=kCvYiNJ)XSOSmyeRW*p<k_V9s1SU<+WUK|L<>CPA5Sug^rVb)3
V01_?$DF%rz$zI5}IfEyH3jiWADt!O|

diff --git a/tests/data/acpi/loongarch64/virt/DSDT.numamem b/tests/data/acpi/loongarch64/virt/DSDT.numamem
index 9b462869cd4911714e7c2a22025c465afa2a7d52..07923ac39584c5a5e73c9556d251814ce10de6cc 100644
GIT binary patch
delta 108
zcmZ3k(x}4a66_MfD8#_P_+lg19cCt<37cOq3vdXD_^`+O2RpNLWivRtgc~mKW1TF<
zqh(^8P@TXfm#{!!(&S9WT96DE2UuQs(qw0saN`7sm;gwuAOR$@kY{rr&rDVTYN{Ui

delta 146
zcmZovS+2t666_M9F2umVXt$B;4l|R}<jpUb1vun5f<prW7&x3mf_xZ6+&JU?gPmEr
zvKgFR!VMRAuutaV(eg6_DJgJv2{#6*ss<5U@*r}7z@*8UjI|)OTpVB>Vv{Dr)Io#=
VK*9we#USw|*$eqLXYkBq1pq1IDC__L

diff --git a/tests/data/acpi/loongarch64/virt/DSDT.topology b/tests/data/acpi/loongarch64/virt/DSDT.topology
index 65111aa822663a907b83487cb496be38a4bdff05..6dfbb495f88b74b87849b58473e46717bc588a56 100644
GIT binary patch
delta 108
zcmX@Fwo;ADCD<iIQ<#B)@xn%~JIqWz6E?qK7T^#P@nMhm4|Znh%4TqO2{&Be$2wVz
zN6W-Gp*n#}E@6Sdq{*3#wICTT4zRrNq{+@M;l>FNF#(WRK>|o*A<yPMo`Y-vl^q|3

delta 146
zcmZ3fc3zFkCD<jzUzmY`QEemF9cCt{$(vs=3vkGB1cwF$FmO1B1o<$CxN*k&2RpNL
zWivRtgc~mKV4uvzqvdA=Qc~dT5^fAqRShDz<U!;Dfk~4y8EZjmxj4W&#3oIKse=d$
VfP@P`ib3K_vKR7g&fq!71^{DJDS7|^

diff --git a/tests/data/acpi/riscv64/virt/DSDT b/tests/data/acpi/riscv64/virt/DSDT
index 6a33f5647ddd6de3a0f000f718b58f6fff44f0fd..527f239dab13a00ad42e5a70b8dc2b89f12aa84a 100644
GIT binary patch
delta 113
zcmew%eMy?jCD<k85-$S-lgdOcX(r!W8`WD`nA|39UdN)vAtd6%9`7IQ%+i(3;Or7^
zxWJEf@;4qW6XS&H1TMLR1p<>MXEN4;WVkrM^1_oQJG+D%CqTpmKw<?6Ad!VUlk<4H
E0ByV>p#T5?

delta 151
zcmca4{X?3|CD<k82QLEyQ_(~&X(s2p8`WD`n0%&eUdN)vA;%FM8W6z1;T#g=!yw|u
z8SfwL%+i(3;Or7^xWI#b@+%%KKO>Nm0%w<SW00z95Wyu6A{Piunw-g43sTF)0oEZl
aX);V5L|6bMTmVuG5?_+NkZ-aFZx;X$O)QlF

diff --git a/tests/data/acpi/x86/microvm/DSDT.pcie b/tests/data/acpi/x86/microvm/DSDT.pcie
index 8eacd21d6ecdf9a3cd3e4f03cf1b40748dcbf53e..ba258f454dc0e59ef2fd67e0ce37e270e7c122e8 100644
GIT binary patch
delta 113
zcmX>vzEYgaCD<ioB{u^D)Axy7(oD|VH>#&HG5Ji`+{YxqAtd6%9`7IQ%+i(3;Or7^
zxWJEf@*XZN6XS&H1TMLR1p<>MXEN4;WVkrM^1_oQJG+D%CqTpmKw<?6Ad!VUlTEm1
F0{}^9AprmY

delta 151
zcmZ1}eqNl*CD<k8JU0Ualj}q-X(rE|8`V>pn4BhW?qd?*kmCpr4G3W1a1IIbVGwcS
zjQ0<AX6ediaCQkdT;Rbzc>|Z0pAkq&fwN1vF-TQ4h~Sb3kqZPSP0nPj1*zrY0P7H&
aG#RE2A}jzBE&wS8i7&}s$Tyjfdo}=5#47aw

-- 
MST


