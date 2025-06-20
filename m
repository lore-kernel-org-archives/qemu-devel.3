Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09197C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 09:00:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSXb7-0006eh-8o; Fri, 20 Jun 2025 04:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uSXb4-0006c7-K7; Fri, 20 Jun 2025 04:59:42 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uSXb2-0003qT-78; Fri, 20 Jun 2025 04:59:42 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bNrxY2nHfz6M60G;
 Fri, 20 Jun 2025 16:58:57 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 41A9E14033C;
 Fri, 20 Jun 2025 16:59:35 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 20 Jun
 2025 10:59:34 +0200
Date: Fri, 20 Jun 2025 09:59:33 +0100
To: Eric Auger <eric.auger@redhat.com>
CC: <eric.auger.pro@gmail.com>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>, <peter.maydell@linaro.org>, <imammedo@redhat.com>,
 <gustavo.romero@linaro.org>, <anisinha@redhat.com>, <mst@redhat.com>,
 <shannon.zhaosl@gmail.com>, <pbonzini@redhat.com>, <philmd@linaro.org>,
 <alex.bennee@linaro.org>
Subject: Re: [PATCH v3 10/29] tests/qtest/bios-tables-test: Update DSDT
 blobs after GPEX _OSC change
Message-ID: <20250620095933.00006eae@huawei.com>
In-Reply-To: <20250616094903.885753-11-eric.auger@redhat.com>
References: <20250616094903.885753-1-eric.auger@redhat.com>
 <20250616094903.885753-11-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 16 Jun 2025 11:46:39 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> Update the reference DSDT blobs after GPEX _OSC change. The _OSC change
> affects the aarch64 'virt' and the x86 'microvm' machines.
> 
> DSDT diff is the same for all the machines/tests:

Is this diff backwards?  It's the opposite of the one in patch 9.



> @@ -1798,6 +1798,8 @@
>                      0x0000008000000000, // Length
>                      ,, , AddressRangeMemory, TypeStatic)
>              })
> +            Name (SUPP, Zero)
> +            Name (CTRL, Zero)
>              Method (_OSC, 4, NotSerialized)  // _OSC: Operating System Capabilities
>              {
>                  CreateDWordField (Arg3, Zero, CDW1)
> @@ -1805,26 +1807,27 @@
>                  {
>                      CreateDWordField (Arg3, 0x04, CDW2)
>                      CreateDWordField (Arg3, 0x08, CDW3)
> -                    Local0 = CDW3 /* \_SB_.PCI0._OSC.CDW3 */
> -                    Local0 &= 0x1F
> +                    SUPP = CDW2 /* \_SB_.PCI0._OSC.CDW2 */
> +                    CTRL = CDW3 /* \_SB_.PCI0._OSC.CDW3 */
> +                    CTRL &= 0x1F
>                      If ((Arg1 != One))
>                      {
>                          CDW1 |= 0x08
>                      }
> 
> -                    If ((CDW3 != Local0))
> +                    If ((CDW3 != CTRL))
>                      {
>                          CDW1 |= 0x10
>                      }
> 
> -                    CDW3 = Local0
> +                    CDW3 = CTRL /* \_SB_.PCI0.CTRL */
> +                    Return (Arg3)
>                  }
>                  Else
>                  {
>                      CDW1 |= 0x04
> +                    Return (Arg3)
>                  }
> -
> -                Return (Arg3)
>              }
> 
>              Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>  tests/qtest/bios-tables-test-allowed-diff.h   |   6 ------
>  tests/data/acpi/aarch64/virt/DSDT             | Bin 5196 -> 5158 bytes
>  .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5282 -> 5244 bytes
>  tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6557 -> 6519 bytes
>  tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7679 -> 7603 bytes
>  tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5398 -> 5360 bytes
>  tests/data/acpi/x86/microvm/DSDT.pcie         | Bin 3023 -> 2985 bytes
>  7 files changed, 6 deletions(-)
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index 75f057767e..dfb8523c8b 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,7 +1 @@
>  /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/aarch64/virt/DSDT",
> -"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
> -"tests/data/acpi/aarch64/virt/DSDT.memhp",
> -"tests/data/acpi/aarch64/virt/DSDT.pxb",
> -"tests/data/acpi/aarch64/virt/DSDT.topology",
> -"tests/data/acpi/x86/microvm/DSDT.pcie",
> diff --git a/tests/data/acpi/aarch64/virt/DSDT b/tests/data/acpi/aarch64/virt/DSDT
> index 36d3e5d5a5e47359b6dcb3706f98b4f225677591..acab6e65febbc210158d4c39be0680bbb90250f5 100644
> GIT binary patch
> delta 114
> zcmX@3u}p)@CD<iIO@x7g>C8kfX{JVpjp}Y(OkR^V=X2?C2#NTx$NL96vvg%MIJ<-!
> zF7RWWyjw`i#5kckflEGNfxx86nT)j{87>a6yzr#S&Mx7`2@o*>kXS(iNMs?;W@BMV  
> FMgSUfAKd@|
> 
> delta 152
> zcmZ3caYlp7CD<jzM}&caNqQoeG*i3NMs+tXCWon;^SSgm<T!#u0|FR0oI`?q7)0DS
> z<Nbr3S-P?roL#~V7kIEwUN5BOX9QAG;Or7^3{q7MBDmy1<N|?7lQS7>L29`;z&gYx
> bO@^t12n&FO3qXoN;!Cm@@@?i7mSh9~5Tq&5
> 
> diff --git a/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt b/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt
> index e6154d0355f84fdcc51387b4db8f9ee63acae4e9..54c27e7d95b4956ed1b5dee0d299ccb08dc2a73e 100644
> GIT binary patch
> delta 114
> zcmZ3a`A37xCD<jTMudTZsdFNiG*i3lM)f&dOkR^VALY{H5EAiWkM|FDX6ediaCQkd
> zT;Rt#Sx{KZ#5kckflEGNfxx86nT)j{87>a6yzr#S&Mx7`2@o*>kXS(iNMs?;=1yTr  
> FMgUJNAb|h?
> 
> delta 152
> zcmeyPu}G84CD<iokq83=(~XH-(oDVX8`bA<F*!`#e3VO%LyjXjG$4S1!#O0#he5=R
> zGu}VgnWZb6!PzC;aDfN=WL9A<KO>Nm0%w<SW00z95Wyu6A{Piunw-g43sTF)0oEZl
> bX);V5L|6bMTmVuG5?_+NkZ*Icup}b@<J&8B
> 
> diff --git a/tests/data/acpi/aarch64/virt/DSDT.memhp b/tests/data/acpi/aarch64/virt/DSDT.memhp
> index 33f011d6b635035a04c0b39ce9b4e219f7ae74b7..4330bc97cba0950191c45ac833533db7a190db81 100644
> GIT binary patch
> delta 114
> zcmbPh{N0GlCD<jTT#|u->Fq==X{M&B8`a&on7k%!&gatO5EAiWkM|FDX6ediaCQkd
> zT;Rt#dAE?3iE%=80+)Qk0)a`BGZ||^GF%*BdErTuon69>6Ch#&AhCi3kjO%w&Bnr6  
> FYyg6XAvXX3
> 
> delta 152
> zcmexvG}oBRCD<iot|S8klg&gfX{L_p8`a&om>i~V&gatOkmCpr4G3W1a1IIbVGwcS
> zjQ0<AX6ediaCQkdT;RbzdA*R9pAkq&fwN1vF-TQ4h~Sb3kqZPSP0nPj1*zrY0P7H&
> bG#RE2A}jzBE&wS8i7&}s$hVnSIExJcpiV0*
> 
> diff --git a/tests/data/acpi/aarch64/virt/DSDT.pxb b/tests/data/acpi/aarch64/virt/DSDT.pxb
> index c0fdc6e9c1396cc2259dc4bc665ba023adcf4c9b..7fdbc03e2bf9fb7d35704779253de36e362f0bf9 100644
> GIT binary patch
> delta 207
> zcmexwz1f<}CD<iovn&Gx)9r~|(oB6fHmbXEG5NM`&ga^|E+pc^9`7IQ%+i(3;Or7^
> zxWJEfa-NKqiE%=80+)Qk0)a`BGZ||^GF%*BdErTuon69>6Ch#&AhCi3kjO%w$<JhL
> aH-8e+V`TE0v{^|+kAs?qZ+<2t$p`>t?mg51
> 
> delta 282
> zcmdmN{ok6)CD<k8zbpd-Q^!OuX{N5b8`a&on4CK{=W}gfm*WTy4G3W1a1IIbVGwcS
> zjQ0<AX6ediaCQkdT;Rbz*-%K!&j_TXz}Y3-7^JEiL~zN2$OQtECTB9%g4A+xfOUvX
> unhaA15f%Um7l0Il#Fu0*<lEdYl+DQGFm>}EVLcA|TR*v9$aeB|nL7Yd7E^Zs
> 
> diff --git a/tests/data/acpi/aarch64/virt/DSDT.topology b/tests/data/acpi/aarch64/virt/DSDT.topology
> index 029d03eecc4efddc001e5377e85ac8e831294362..969b4f6560d3ae39f5b7e0064b7122905476fce8 100644
> GIT binary patch
> delta 114
> zcmbQH^+A)%CD<k8g9rly)24}B(oEex8`TB4nY<=#w&d315EAiWkM|FDX6ediaCQkd
> zT;Rt#xm8%p#5kckflEGNfxx86nT)j{87>a6yzr#S&Mx7`2@o*>kXS(iNMs?;=D)&{  
> Fi~vUbAmso6
> 
> delta 152
> zcmeyMIZcbpCD<iIOq79viGL!OG*hGhMs)#hCWon;ExGkL<T!#u0|FR0oI`?q7)0DS
> z<Nbr3S-P?roL#~V7kIEwt`yetGXg0oaCQkd2C1qB5nS>ha)H34$(f9`Ahlc^U>#zU
> bCd1T0gatst1t7&B@g>;{`8Hn{mSh9~yBaCk  
> 
> diff --git a/tests/data/acpi/x86/microvm/DSDT.pcie b/tests/data/acpi/x86/microvm/DSDT.pcie
> index 8eacd21d6ecdf9a3cd3e4f03cf1b40748dcbf53e..ba258f454dc0e59ef2fd67e0ce37e270e7c122e8 100644
> GIT binary patch
> delta 113
> zcmX>vzEYgaCD<ioB{u^D)Axy7(oD|VH>#&HG5Ji`+{YxqAtd6%9`7IQ%+i(3;Or7^  
> zxWJEf@*XZN6XS&H1TMLR1p<>MXEN4;WVkrM^1_oQJG+D%CqTpmKw<?6Ad!VUlTEm1
> F0{}^9AprmY
> 
> delta 151
> zcmZ1}eqNl*CD<k8JU0Ualj}q-X(rE|8`V>pn4BhW?qd?*kmCpr4G3W1a1IIbVGwcS
> zjQ0<AX6ediaCQkdT;Rbzc>|Z0pAkq&fwN1vF-TQ4h~Sb3kqZPSP0nPj1*zrY0P7H&
> aG#RE2A}jzBE&wS8i7&}s$Tyjfdo}=5#47aw
> 


