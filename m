Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7918C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 14:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTjPX-0007DO-NP; Tue, 16 Jul 2024 10:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sTjPJ-00066T-Pk
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:43:59 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sTjP5-00032h-EM
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:43:55 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-78cc22902dcso1901691a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 07:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1721141019; x=1721745819; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fTj8JqwW6HZgP5hs1FYsc9VV2SpEFSu80LfSG1MxQFQ=;
 b=MbcAXUozDKjZpV6b4aVrQb9RkX8Hub0euz553v9Mxk6MVsUyBATuTj2foLNmH8pPgc
 D4E0ord+t1T+kYlLjtyGG7RROJD1spoqQWlhA6rrccvg1SrdeATJRiySr/t1cqY2o8BW
 BwqDYb3b7aUbBu/pnWFKvknkwbEylzIiolQx4LYghH5JzDeZX+ueJ3K3UpAocGEVQneo
 pdhcRV6T6cQgwuuyJmYJGaEM3032atWz0GozsGr8maIGRvb/5NLTGOgdRq3vg1L8xR1X
 aqfQ3TTYtHV+K6TbGGQWwtVf5EQm2qWgt3DwIeuN2MFQpncVeVSpdzbj/k0jDqIKh4GZ
 o94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721141019; x=1721745819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fTj8JqwW6HZgP5hs1FYsc9VV2SpEFSu80LfSG1MxQFQ=;
 b=hk5UHH5+mc+F6UHecDeoRBmfyLNX47LkvdDQZ8PHgcs1TgWAKuS8Wcoa2GNu4Ge3JG
 xG7xFS7YhOeZXhI3jvuueiGUO/e510RJiq3OsLQenCXzyBe+c++aFy1cJruAwILBApDB
 Y4bJqnXsQx0C2AI+nMegPI89CH/N8PmYmdkk4HbjMyjeP1qUdWFi6/eD4HgiCUBbtwHe
 1VwJ4DhNkJv2RbNPmRgKzbp1kaAqrVrWpp0N0LmJX93etmqXNSvNMFpQQ3FJov8erSby
 7nCPVnmDOsvjeUnO018IrsFtUeJvj8+942Jt42c22sDfLXaVABxi0IjckbB+VRMBwbq+
 2e5Q==
X-Gm-Message-State: AOJu0Yz7QtfzJnCplg2MVh1dLrOcMcZsLHcBLL6zHtzpaA42iha8fdjn
 tYOac9zit8dzzKimh2yvjF8eyEx5FSRI7VghMJ0pzJ1lA4yhQoMUusN73oFwkJjtuUsCfDIU4Xn
 Z+Lw=
X-Google-Smtp-Source: AGHT+IEibsKqbGAfWg4cqDlIJ6gQcY75hf1XJuEt2oDRNBhJ84dOEqEbXXQOTHQ56Ys6sd+bRji8eQ==
X-Received: by 2002:a05:6a20:12c4:b0:1be:bff4:83e with SMTP id
 adf61e73a8af0-1c3f12718c2mr2976978637.36.1721141019041; 
 Tue, 16 Jul 2024 07:43:39 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2caf480d61bsm6084782a91.18.2024.07.16.07.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 07:43:38 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v4 5/9] tests/acpi: update expected DSDT blob for aarch64 and
 microvm
Date: Tue, 16 Jul 2024 20:13:02 +0530
Message-ID: <20240716144306.2432257-6-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716144306.2432257-1-sunilvl@ventanamicro.com>
References: <20240716144306.2432257-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

After PCI link devices are moved out of the scope of PCI root complex,
the DSDT files of machines which use GPEX, will change. So, update the
expected AML files with these changes for these machines.

Mainly, there are 2 changes.

1) Since the link devices are created now directly under _SB for all PCI
root bridges in the system, they should have unique names. So, instead
of GSIx, named those devices as LXXY where L means link, XX will have
PCI bus number and Y will have the INTx number (ex: L000 or L001). The
_PRT entries will also be updated to reflect this name change.

2) PCI link devices are moved from the scope of each PCI root bridge to
directly under _SB.

Below is the sample iASL difference for one such link device.

Scope (\_SB)
{
    Name (_HID, "LNRO0005")  // _HID: Hardware ID
    Name (_UID, 0x1F)  // _UID: Unique ID
    Name (_CCA, One)  // _CCA: Cache Coherency Attribute
    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
    {
        Memory32Fixed (ReadWrite,
            0x0A003E00,         // Address Base
            0x00000200,         // Address Length
            )
        Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
        {
            0x0000004F,
        }
    })

+   Device (L000)
+   {
+       Name (_HID, "PNP0C0F" /* PCI Interrupt Link Device */)
+       Name (_UID, Zero)  // _UID: Unique ID
+       Name (_PRS, ResourceTemplate ()
+       {
+           Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+           {
+               0x00000023,
+           }
+       })
+       Name (_CRS, ResourceTemplate ()
+       {
+           Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+           {
+               0x00000023,
+           }
+       })
+       Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
+       {
+       }
+   }
+
      Device (PCI0)
      {
          Name (_HID, "PNP0A08" /* PCI Express Bus */)  // _HID: Hardware ID
          Name (_CID, "PNP0A03" /* PCI Bus */)  // _CID: Compatible ID
          Name (_SEG, Zero)  // _SEG: PCI Segment
          Name (_BBN, Zero)  // _BBN: BIOS Bus Number
          Name (_UID, Zero)  // _UID: Unique ID
          Name (_STR, Unicode ("PCIe 0 Device"))  // _STR: Description String
          Name (_CCA, One)  // _CCA: Cache Coherency Attribute
          Name (_PRT, Package (0x80)  // _PRT: PCI Routing Table
          {

              Package (0x04)
              {
                  0xFFFF,
                  Zero,
-                 GSI0,
+                 L000,
                  Zero
              },

               .....

          })

          Device (GSI0)
          {
              Name (_HID, "PNP0C0F" /* PCI Interrupt Link Device */)
              Name (_UID, Zero)  // _UID: Unique ID
              Name (_PRS, ResourceTemplate ()
              {
                 Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                 {
                     0x00000023,
                 }
              })
              Name (_CRS, ResourceTemplate ()
              {
                 Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                 {
                     0x00000023,
                 }
              })
              Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
              {
              }
          }
      }
}

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 tests/data/acpi/aarch64/virt/DSDT             | Bin 5196 -> 5196 bytes
 .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5282 -> 5282 bytes
 tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6557 -> 6557 bytes
 tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7679 -> 7679 bytes
 tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5398 -> 5398 bytes
 tests/data/acpi/x86/microvm/DSDT.pcie         | Bin 3023 -> 3023 bytes
 tests/qtest/bios-tables-test-allowed-diff.h   |   6 ------
 7 files changed, 6 deletions(-)

diff --git a/tests/data/acpi/aarch64/virt/DSDT b/tests/data/acpi/aarch64/virt/DSDT
index c47503990715d389914fdf9c8bccb510761741ac..36d3e5d5a5e47359b6dcb3706f98b4f225677591 100644
GIT binary patch
literal 5196
zcmZvg%WoT16o>EFlh__VVmr?J;S@^6GqU5nTG|qO>?AIBVmwKMluE9IK$L7EQ6ZHI
zDP++?b~J)@kn)Ehv0}%LMb~Wj2iRfGojc?Fj&erwc+Si{-`sC}Y@eCBSKn(Dl#0yM
zcHM1nq4sIVU7*EMO6hI=o_$%f9`(Fh@9=cmEtN{~-gdK|uDYEj1#2qa+i%v@;prWB
zw;dkqwzo^Aayd8_@3~zsH|<QkNGJ_VsH{>y4lB#LLD4hHUEe%#Hx2ibMth&QOO)&F
zRh=XyyH(2|a!$q|B8kZ$vuZ!=hEr<obayFr<?6J9%&U_-DiWN$gov^^J4fi#UPDCG
z6`~v<YI+t+62gf{3>z3r$f$^nsKgisMg<wmBEyy#abPSXV?|^PNel-VE67+C8N(7I
z1&mc>tci@6#K-_+4H@eqBQ7zrz*tAdZIO|X7<pja21Ysfa_|y!9Eni?#vNpcWy-%K
zVX2P;<3nV~b()gqF$s*j$dKzaEitBnaSs`Con|D)EHLgPL$1>ii7^k1kB}kPX;xw^
z0Am9ga-HTR#v8z>B15jzyu`Q(j2bfJIvtf5w}9aSV@a;lg2Z?m7<FXGbvh<7-UUVj
z8FHPDON{q{v55@1PA4SBA~3d)A=l}o#3%t{8yRw)PDzX<U^I~-*XgvxSO&%eWXN?o
zBQaKi@i8*wI-Qjm>%eFsL$1>~iE#%QZD3U7I-QpocY(2k47pB=65~EFb^}J!ZVeiu
z&Q7P~mNo~?M~8ZzjFa^HoHzaPM7_4JFx>OHo^^QYqk`!$6g44;x+$Q{z5(iio>lPe
zVJO{<AnPrGW%hAa@GasjYD$oGOJJFO1J=gR9k&^LYMNCot<%+VshKoUMfZG-En3%V
zJA>=!?R9fSXSSnU)l{FW1y!O~owmMFPt<4ht~A7N(>mR~(bm__Nj_;O`+cQ98)ddF
z+AgbnO7C|f`tpQ9l!A)Nr|nd~Zz-Ka<AO+M(ZGy3=I7DSFw~jE_s3FCX~qVT&J2fA
z!>G?lL;Xw&b!K>$sGk|mAgXj`I5cW9X{et`q0Xck`Dd~H%y0&_pBWCN1~ahqGbu#R
zA?7*cXNI0bCNrEoh3GlVJgJ4J`GiBMAw^FL(KE(8W6U$gJt;)bIP;7%PikP%lS1@N
zFi*PqFjvpNBnj?GA$mH@(_x;}@S-P$=$T}mN#>d4o)n^Iig~7(CpF0ENg;ZsnP-}L
zrnx7D=$T=j8Rkh1HF{Ero+He2gn5o|PYThKZvIS-`&FD}p45P&Cxz&lW1czYnd6=m
zqGz6Y=9woo?C41$dX6&BQRX?yJt;&_x~&G!0`sH>A3Z5V&oSmX#yrQkCxz%a&OFDN
zC*2UBCxz%a!8|9J=LGkp5IyNu96TqPC*44xCxz%a#XP5&=M?v(5Iv`v=QQ)A8xHiO
z5Itv@=M3|l;hq$t=PdJ_WuA0{f}Rwj=N$8#W1e%|lS1^IXP)!SlWu6xlS1??GS4FO
zEOJi@jb|a-b8A&~NxupzyJ7xVsbkrWIZuB`s|fu-(bCr|>m}7oivBPCCEM@+r*F$>
z=`Yd|D@FfmW}&}fTKaU<QfKc$j(_+>AJdB;U9I%~XDaUPcRDKW?sZ$Lu$k!XdaiwT
zq}=*J`C>bE{$*~|$sV>}SN<)|Zv1lawEEk<zrHv-a%>u~MDKBWuN><@bM!_<qn_)P
zQ`GB=?5p!9)^~KI?2j&AjK4Y$$C=$(eehTh*84Aye$ANu`XuGcqrwNhy4SWZZkXBp
zx%S83-paS_pC<lkPyOz;FB0cpsmol{vh<1`bhYhn!-E#c^&fQUwy@%qu3aDhGoY(e
z+_<_ldW(KR&2zI_?9rlrGPl*J_skOt^H{E|TPb=hm!<={I~uf|QR^L(deZ1pr$wJ=
zJmJ`f-zRnGHoQh_p)l8LJlsnh>)`Q4_Wb!{M|UtUItSgFb8>h(r8msUOhf1ft=j+5
C#r7@$

literal 5196
zcmZvg%WoT16o>EFlh__VVmr>uc{qhq@vO#n^Jr;H?6H%$#EJ2w4N@w(5&}`OsYHcT
zDx{D_3)#^~Yza~%{tYBn?AWnj&4zz~9p>D*Gs*8LXQYhh%-r+M{l>@f@oo97-K~;R
zv7eed-lo6U{J7^W(q<{8^s#=;zie6$2Yz#~e^mBd*G&#KJFRTP>vbqtQOUvmPD||{
z-ST$2(Y1be({-!W@LF=<_5DKGnR<~@8kkafrM@3kmUV@qXOz3TzUQqQ?nmwJed5+A
z*WYb8X-f7QmO&JpoI%7=(_v=Ae$bDmw6)#eq12^|+n#4$+}u&I@a8Tes^;z-p>KN$
z5mOh4YKUm+S=1zi6O$M=FlxxCi;TF$7zIWh88<|REisb7xPgo%kuf4M9AGRVV_9U3
zN{kFJmXWa{G7=Ia2aFYDtcr}J#K;3<6&W{0MoMB7fpHTU)$qf?OU!X3MhO_VkRg^S
z|BytbJ_(HXks;S<Mw-VoFm5A5uG6f<C<EgTGUPhVNsKvQ+(m|5r(+Uh0T>@3L$1@j
z#8?Ez8ZzWMEl7;lfYCsPT&G2eaTOR%WXN?oE-|hF!vjW5uG5mlcoP^cWXN?oAu-+t
zMjIJ&olZ)OcY(2v47pCHB*t}MY#>9f(`kv}0%H>ya-Ggdj2bXH$dK!_EHQ2X;~p~P
zI-Qjm%fR>$8FHP@NsLusY#~Fg(|L(;3m9Es)a5!|kQldtv5gG5PAd}QE--dN#`Z5g
zuM^Irx7~9a?kY7O9<@g%s_QPMy+QkCbNjq4@pt=$iZj<!p6aMi)uM9guSG{+smJOQ
zdQ}<{G#<VF?)cW1&S5car-wte;dfkRjx9Q_s$xc;cVZOOq99H|T@|x-W;nEz&Y^K(
zq_b#X&Rh%fXlNAbOyUP)sY^0r!$@aFL#YMQcch^~CWSgPx=TFBjAjs5Ix`v?H<>gv
z$fQtb(u{(;*g<AA13So!hEmHES_YXEqUQ+n90@Wb&k>UuO`byZ9A%!=l+t{nq10lb
zCxz&lV4ex)nc$ujqGytMCYdL-WavpDdZw5swbSP51&<`fJt;&_hj}{8lUg|Rq!2yR
z%rnhA)7+Cn^vp2N4D+Ox4?QVF&n)xIGS4jcq!2xG%rnP4sYOIj3ej_nd5$s9G44qr
zdeYAsQ{zDu=b0z9l;}wzdKQ>xfq53VCxz%)WS&LlNi8UPQiz`8%yXQ1j&n~6(UX2C
zf@g_&Qp<{-6r$$@^PFIw6Wo(R^qgd#lgyJ^T=b+6J*SxG6!V<oo)n@d{kR0rY34~S
zF?v#no-@pIhI!6#PYThq%sk7?lUiu>q!2x4nddC?oaLSrqURj*oMWEUa-%1O=sC|k
z=b7g`_oNU#7ntV)^Q0CXJt;)b3iGTm&kFaX(0J}2b!`1snxAj_OWAYR&%cO!v@DTx
z(!o;1>%mt#eeYg6R~jAoecuXEVaLEwv`&Dis{+cLJ4fBqvkDtrhSKW=$a+IynRA>K
zHoBZe>jucWCa}!8kX6bLyk<k4(f?4DU!$FQ9GeN}>33NbqkreL4fW1?NuRC^br->w
z9}fT1Kg(zvUZ*QohI#<AQPV=(kgi(l_#MazE+6V^dJCe9oj(6eCH?!oo=SSV{Vi2m
zPYrf_&ptj-UTd#<x|ulnyfE(M_q%`9|E<ie{kZqE@#~#GKRZ5fY#LCb*Cf5xpXfky
z^g&&tp6i`c(fiZ<tCPppH*}>MjIN$ezB-A<nbUcF@rfR+&z~LqoHOV3O{!-HrS}Fc
zziXdfF|+w&<@dk+rLVg`O#RcH`OWK|rcS<4XN9<B=^ZU}b?tuJXVs_|x^&Ie9rx1n
z3El&GI+eAHN28DE`^K!BH4_i7>y^2Uc57ft+$_sgb>m6Pa#^|%@=cw`t+!0-VY^R#
zDZQh~lw<FIo7SP%_S;*FrTIbo!EWk_4j!H6Po6(=bienax7Tkvhx<n}`T##qp1GI$
EABWcyJpcdz

diff --git a/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt b/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt
index aee6ba017cd730948bfa93e91551eb10a6809293..e6154d0355f84fdcc51387b4db8f9ee63acae4e9 100644
GIT binary patch
literal 5282
zcmZvg%WoT16o>EFlh__VVmr?J;S@^6GqU5PNkdy=kDbINPK+mMkW$H&5QvgZBr2p*
zA%!doRANCRSO=6p1c?>9?m%MAhJSz^=G?h6&hI2=q}X%j-t*1<#>erQseAR^UkXY^
z{;ch|o8DaQ!?rs|o28V}`}#fm{f70R>(#mkCzEceREl>uoAq?nZ8s@cR`Kp$v#!io
zSsJqrPNpbtK^k)+X0Rd-Mh{L_-JMo=#!hRqR4SK)Gse4a$IDGRW6u&wFEgRCN_{t|
zEbAIYPiRFe>-+Ay0e{eF?a^u%DA(JqI!Q`)tCm6JoQy$465~N;)xO^eMYpy)JCwR~
zaoT?7#mOBN2~J)@L~uPgLZ9{uBBCx3<p5FBs|YR|M>r9QVFP0U8Nt=P#E43aL10vn
zv1l&jC5A0A;=ou$#*)YwkQfdymXL8%WDH7-6fkZgV_9UxBt`}p%g9&}8F7h`1;z?8
zZi$S9#K;5V7BI@em*djs;z*1FFjkQvmMQ;|grz<TjCYYC*J(;x$2c%<BSWs!w8WSM
z#vNqHb()bF)4;fk47pB+B*rW--b035r&)<H2aGjj$aR{N7_R`MiVV3<^Ah7aFlxw<
z>vULR+yI6Pj0L$)3ligXVAPQz*XfAFcoP^6WXN?oDly&$#yT?OIvtZ3^T60ZhFquP
z5~Bo+O=QS*Iw3I@fYC&TT&I%~V-XnlkRjLUl*G6RjQ5ct*XgvxSOLZsGUPg)kr=DM
zXaS=l*XgXpxDAYLWXN?|lo)q`u@f+w_Ex{mYHznoZfU*We6*?O$v8>B&w16KPt+^N
z3WHs*<5A<~qk`oy6g44;x-Ov1u|DdaURChzVJO{<AnP@OWsY%H@GasjYD$oGLtvR>
zeb(BKZMPYGYMNCot<cqSsYNwWMfZG-4SKEBw)@x7+wJ6v&U9P3s;NF!bE-stb=vzv
zJyIXhyV4N9O>1{{hqpd=j`K-7+3P9&*(kGb(SBLwQ~J0Q(U&I-q7+nAK5eIZJxl2v
znioVmiza5wn4d>e!%$}u-=9l8rI{N<Iy0O~4Wm9IP4zP=)S2N~qJCz$f~eA&;nb+f
zq^W);g*uZ~<e$a%Gs6|wer7n88qC1b&!iAN2bkx8pBZ`%n9OkT6r$%K^Q0D@))P*p
zh7>(1M9&!Wj4{s`_oNU#<IFS8JgI?2PYTg9!93~a!(2W8k|ek%h3M%pPltI@!;792
zqGytMCYfiFds2v=Ddw4Cp41?tCxz&lW}a#0ndY7pqGyJAW|${6)aXeedJZwqA?7*6
zJt;&_y7@CT?pJY^c~S$8o)n^Ij(O&oXO4SPh@N@onP;BVu%jo1=sC<hhneRv_oNU#
z>1G`~3(S)meDtIcJx7@52=g4_o)n_zDDxa;o^(Tio)n_z81o!so@3mTLiD6taqt{x
zo^%6&o)n_z1oNC=o)g@YLiC(uo|DXzZaC1BLiC(so>R<oihELsp3}^8nt9R<3VKqA
zo-@pIhI!6#PYTg<mU+%HPr9K&PYThq$UKY8v&cOuG@gZQ*R566IsI2q*){XSN*&8)
z%z6B6T1Ds|6m32IVtqsPlA_;Bf6MlI|LNN@+IsUeVx{O;&202DOk0meE%p2@$nl4d
z^_brL=;B2mf1={vUc0U0?rvvG71k5o9nZC&A1b%LUq0K6oqn1dcCrVpzbgM0r`LYk
ze_Z|b&L5vVKXh!Gut4u|daoSmKy&m?MWdeT7pJIS&$2I0A6Z|~NZFrVJ{x^;8qPC^
zvwHAIPu9oJ4}Z>><N74!^TWbB-MZJZ&#sx(yj=eMZ*S?#)(>O<v?hLYTW5*W&(wJ?
zYFYY)9(1+rPQ!y1$n_s|>9(-ql&)MK|1+SgQ(U{aG<uKzgPP}Nwb+As{k(6ZQSX{3
z6y{-HS+`R3urEymx;yH(ol)xzlX~3fP^U$oXguNA2VW<3=r+8@)?8tx+ql1*IMTtx
gv+U{9hmP)Gp0)QoHRt%?WJ2$llbMFl4O+GT0UqoMJpcdz

literal 5282
zcmZvg%WoT16o>EFlh__VVmr?J;S@^6vl`n?la{u`9y^IkoET5iAUTpNArK{-N>oUt
zLJC<FsKkOsVjWN<{tYBn?AWnj&4zz~9p>D*Gs*9?XQYhh%)RHE`;Cv|<7xWM-JeTJ
z#SR)f-lo6Q_^|6O(Pk;7^s#=;f4^ZJ4E)BRe?05CuA3Zewwu|y*KJd<qLPEXc2k+L
ziZo{RkLM__DvdcYGguP`<Nf2C-cBdFVz0C5x|K?J#pJ;2`Gr|$>S;>pWu{bKsqaRW
zWnH4^F|BBIecxL*;161zJz8y*a{b-9lcr>^ZW%<u$r(f}H63Qw?R&jQbZfh}L#fLb
zmp#wCxVWQY;l*7<g!h9Z^krW{#MA|%5+WLU72$2;2qz{nY+zK85#HSw7;%X)3XB>u
zu9+M80>hRVNnl(<#<Iv5kr)mzmXUE?WQ<CT3^1-EV?|^nBt{MxE67+C8A*we2gWKg
zZitMO#3%ye1~4k&hvS9!#gP~#VBAE8Sf>0#5|#QSFy2LmT&Edn9n-+Lg$%h)vl3$#
z7`Krj*J(~-%md>NGUPfPlNgJ@cn=wJo#rLR5-`?~A=ha^V!Q&3Ix^%sElP~bz-S;t
zuG4XeaRnG2FsgE$mL$gOz-S^vuG0yL@g^`@$dK!FQewOfjCEwlbvh+6t^#8N8FHOY
zOAHqno5+ysbVg!Sfzd{WT&J@V;~FsTB15jzIf-!{81ExPuG4vmu?mbWWXN^8ATe$N
zqXUeZT&If?;}$Tsks;S<Sz_D)#!krC{-x`+!*z7GyKdcGrRKw<rprV%-Nm#vXy0gT
zpSLCcZm&>w=DW&MZS}EQQZD^9>F5jfKz&57N<)IiqubjZ-}>A+DyHr9aHux?wyVss
zMaLCY%;@t@jDl(u#3`t$V%E+KhnCVgG%t*F7ER2Vu^^A8Mxo9melVB1Br`XRbY?V_
zS|EKzni^zMs57Ih#DmOe1#zV_qp5L|NmGMN3Uwx}D7cCpWJW8ngUo0uwM?O9kVzqW
zjxf)WAT#nDF`3cgDMZgv=1EN{ttXmFEf#uGh@J`NnP8p??nxnfCYfiFc~VP;o)n^I
zig{8yZSG!hOH$mELiBW)r^7s{g+osY(KF3F)66r?Jt;)b4D-w|PipzllS1^&GS4jY
z%yLf((KE+9bIg-kMD(N(J;#{m81o$Co)n@d{hTp19#nCjc~VP>o)n^Ifq52~XMuZC
zh@M5}S!ABnf}$sd=sC_j$C>9i_oNU#>E|bSmY65CtmsK0dQLFU3FbM$Jt;)bN#;4p
zJgLP+PYTg<ig`{k&nfOnA$rn}OYod#p41YfCxz%a!#ro0=M49x5Itv^=PdK278*S%
zM9(?qImbNbxF?0^InO-jnJ2Z}=t&`ZE-=pp=DEN<DMZgj=DEl`sYORm3emI7Jj=|p
z%snYIp8eytt=~%X^G$y#d+z%A7jc&!OXQq%@F?Qd;47WJcV9YJ8XfpOpPr2bsIX&T
zD0)tSsLKM%oI6L|)vF2{T!zxm3y}4iz%u7JD{OQ*i=G=G>x#fK=R#H~KkyoLbw>X~
zRep_j=5}l*oJZegRgC_f(>ByQ>l^xXWvIIdw)}ATpZ-}!+wdxlSQ+X8%tlQMZ9^Kh
z)U&rBCm24`V|ojsi=96ISS9_vZdWC}-QJcet)~V%zGpu>R9<txa=Mu~`Lr<Z<olh!
zYX6q!*M8i8RR8t%pPxKCbZnYXrPn0A)*k9WbM!$?qn_xUQ`Y;_{PU9s)>kxA31(ML
zC!e20^UUeI9(<@L>+@%aKjqAMeUZx9Vd<Sg)9=`)m&|JZSo!^LfBDPK4^#hiW`6TJ
zr>T?A)L9{JS$angx;l2R<+Ezk54v>C)g1Sw`xCqeba%>Y7q><q(f5scZq`T~T-DF}
zHd@VrDRJ|#uc8}Idf1nxfsk+NJZ`;VQjc0a>PzVzO{N^X|8-i2UdwN7EtM7qt$Vwv
hhdQ`_nm>7R-_iZv)9!w+;T-jkXY>Jno;-6c^*?7DCOrTE

diff --git a/tests/data/acpi/aarch64/virt/DSDT.memhp b/tests/data/acpi/aarch64/virt/DSDT.memhp
index bae36cdd397473afe3923c52f030641a5ab19d5d..33f011d6b635035a04c0b39ce9b4e219f7ae74b7 100644
GIT binary patch
delta 1923
zcmY+^OOD!55CzZ&HXna5*!=%npg}#0ltdy@kTOeV*+cK3^`vYd1Jpwn(aI{ak}QMV
zS9XcIBm0WFxQ-3Joo=V}{Qdmnwsfxj;XQp$I+ys{;c)#o`Wl7fv8<1;<wf$}@=N^l
z*QdAZ=j6p>;NYq(&hGaX&YxVBhx4?JaMTcLCsz&P98=EKb4>~@3>Nig(!;36(8Tx4
zY+IU`ZBl4@oozd*Vpgh%p^9~6IFhQa5V=s*(Wq`>RGNsPsh5eRsVl_N)X~_bzHv$w
z*-ASk?MPLno%*7>J))I%N!pdBj&=#^@5ol#BWaJMJ(eO`X`iHhlJ@JSZjabNz1-e}
zqzOqAmLghdO45|1DM{~$7Me*jJbzgsBWcD`L@Uinnv*nVDPkj)s|*M_aINtB*Sj)c
zDWa7YBrQl<uoTfshtgE&kf46ZQba2qk#t1T5la!Rv?OUMO@)>Zs1JWzWGk&mT9LG3
zDWa8*NjfI!n4yTF>9LbMnF&cJB%QDn(MqQzosx9=kOnBCh0dI7p1-UxBk7E#h*ml$
z>71l<mLi6xLKg(}3z9BaifE;H!Q+ecowy|FlBI}Nx{{`@uzEl}?#ha#h*r8L>6)Z#
zmLgi|hNK&UZW^d>-rC4kx+UqBq+6CETIr6YyN49e9YYbLkLHH%NxCQLo~4Mj^iNU!
G?)?X92B*>h

delta 1922
zcmY+^IhNW`5CzcRk{C1~K+JR2v2BibfCrLJy0hLxdkOy>Z=eHWV#hw-fY;&8;P*?v
z4)r2<P*18Wfv(5vu{b@SUal+WlE1%;&w29n>++*`^WUD&A6!#r<?Z%>_a9wTh4)2*
z@JU08aCFTet1#tUI~P-EVX$t$lO9Gjh9-_Lvxzh@8&ha{olTrnF)LNXP{lejoJv(!
zNL{GvXxcV0Dow=D)YD|r)D<#m>S*Q)ADvP~w$ctsJ5p6?r#-1|k7%V`l6Ix3qg{gf
z8?u%5NZKQ5kEMuK+9zqBr2V$3+apG(m&==zG$(1!Qba2)NLrAzAn6U!LQ83e`!6e$
zBrRErXr&cNE0R_$MT}B8%YdK*_Yi*ndQ}E2MYPhIq%}!vmLgi|P?`!I64Vb_ifE-H
zl8#6^Vkx4Pj!8O}rb5Ses1JWzWGih*+K{wiDWa85NID_ugrSI`>9LdCnJG!9B%QJp
z(Mo3|oso2Qmj)=Jh0dLe_g_|+lXT8fL@Qm8bV1SuOA$j;p-Y1LB}tboMYK{pym26X
zCay@jVkx4PuBE9ftnW~dtFmS(qLpq)x*_R?rHEF#CFz!++X(gXsf}!<JCg25x??G#
zmF`Kpze@q#GZZoXYA)!3qz957Sc=$6Uw@u69O81yzlRSl@A36tewO@LeECy1@4f#-
CLc~`9

diff --git a/tests/data/acpi/aarch64/virt/DSDT.pxb b/tests/data/acpi/aarch64/virt/DSDT.pxb
index fbd78f44c4785d19759daea909fe6d6f9a6e6b01..c0fdc6e9c1396cc2259dc4bc665ba023adcf4c9b 100644
GIT binary patch
literal 7679
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

literal 7679
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
HYpH($%hpa?

diff --git a/tests/data/acpi/aarch64/virt/DSDT.topology b/tests/data/acpi/aarch64/virt/DSDT.topology
index 501314c91be01d927fd125e0c72e919fdd85592e..029d03eecc4efddc001e5377e85ac8e831294362 100644
GIT binary patch
literal 5398
zcmZvg%WoT16o>EFlh__VVmr?J;S@^6GqU5nTG|qO>@+TMVmwKMluE9IK$L7EQ6ZHI
zDb1olb~J)@kn)Ehv0}%LMb~Wj2iRfGojc?Fj(bMRc+T8=zL{_4*f}$Guf8`vrc`94
zw(D+r3$;(%?gA~AQc7>@&+PME>tWZcbq`Oc-BPI(?`}2g>8jgqQn04t-Th`=nX$4o
zW*wf+P~MU>=0wb3MI4Np!DVsKHiIkT;E)+y6$gjS;F>rXJ3PJR?zTe9PHU@FDwhMx
zc-QTCxoKzOMMCLIlTcZuejHYob&aB@bQRV&58O=y{-n{`rz^BXx!zvYNm8;~wG1NX
zWDFvbm<%$j_JdA%akqCmyOg?eb=ZF9)xjMV2@YODL~su{LLc@uL_}R7$^oLL&my>0
z9N|PHh7F7*WCV9~fDx4#!@#H@Be?Mc3|nHvfw7E?pgsl|LlVOQ#tJfmG8$kEON<mS
zR*?}@+W;dbF*3kdL&mx(tN}(`Vq}4_j*OckBOx*Jz_<yFa`5FCI1fi+6o7FH8Dg38
zFG*PH<G}b38FHPbr1O{r#%*NCb()qK)4;fc47pA-5@Qw^cab62>4?Ob2gXOpkn1!n
zF&2Qafeg7$a}whXU{sMI*J)m2Tn9!C8FHPDN{k!8aDlNT*J(jwybX*xGUPfPlNj#;
zqk#;$PRAw2`@q;lhFqr;5@Qh<_mCmi>7>Lc0b>gpa-B{|j3r<+ks;UVw8U5j#(iYS
zbvh$4R)O&`GUPg)l^E;5*hYq2r*jhH7BE`CsK|9XFEMTdV+R>>ofaj=U1016jHbQa
zZ|&MU?UGyC>^C26>UlCw((iNL^yd@xwS9%*uGjIX+4E7s=`a*EA&9yzpv=BL>b^d!
z;M>Dcx*0*%TLR1M<E-FY#97poAnS&}GW+_hji1|YGq`J-RV}U4)pDsVHc>_Qe2sgw
zuGMz>*U{VS<ciL0Te+&KK35B>M1OVK`bIrgpV6n%5Wh`pclJiNzjjXYNjur=DSdC0
z*|uoAtnw+n--+nU69!QVDk`70Q@x(0bPml6BArDOGiJ=sqp4x2Gl}odrJmBv4I-Tx
zPNjxXACac|nH1{G@F-C~GdzQ+(wX7ZsL7<MekO%Flg`LLitT5HXJGr8;Z$lc14}=X
zLi8MBo<n|S=s9FE!;_~FJ%^bmweWO4;Z$l!(UU^-j4{s`^Nev%3ehvpJmbuh8d&tC
z5IqyjlO8_I)$=b&f_qYko(}VLm?t&7=t&`ZCYfiFc_z6hh3J`Lo+;)@4KjLCh@NTY
znP#48?nxnfW|(J&c~V1-o)n_z2=g3ao+I3oLiD7EKU3p=6=#_zHQ?w;A$sPRXO4O1
zxF?0^nP;AP=1C1ZdQym<qs()Zd5&^V3emH`JPXW|8hrGm5IyPD0$ri-7h;Tgj&V;4
z(Q}-6jx$esAV5zF(Q|@%PB702?nxnf(xW)s&q?M<4-n`{A$m?R&nf0P#XTuR&uQj4
z%{=LW13f83&l%=9!#roWCxz%a%RFb9Cq1B`Cxz%a$2{kl=N$K>5IyIa=REVI2O9LG
z5Iu{`v&cM)+>=7%S;%(XT2)=ruY$^Mn18I)v24YhCqJZBgnpoC>FJgAJ=IH!{$Kh_
zw%7YlKbFzbTci;yMgP^zLjQ(o>CvdA&fbF@fA~a?>BWz(R(k(a75DbrZ54O-I@_wS
zndt6%u6=f--1<TJVk>t3Wp32T9=2Xp{w>aK{BrQ5`rDnqzBoH_Y?`n{pK<!E9P2=H
z^hQOap6QiS)a#4v%k#(9cQjJ=XO}O=U!I5a%<ilnJl2!-{>!6ZGiJX&Ncr-p@Iklk
zwd{*)=4}34`{QqK<=fUz6aTcPes^0JiSw`2WiD!2dPOg~T6U-5K?~&iFS>MFSaC|P
zT_67*(A6n!TwNNyMZcity;&{xa8bWwyw|9A@x5GGw^H<iF--%yJL<QcQR^L(deZ1n
zr$u)(o^b5L=Sdy94X?4iP?+mB9_%HKb@1pSd;aW^qdS-v?SoFuIXOI?(i`SrrXh5L
GR_%Y*aw0td

literal 5398
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
My@B5+&m2qr5A>`*Jpcdz

diff --git a/tests/data/acpi/x86/microvm/DSDT.pcie b/tests/data/acpi/x86/microvm/DSDT.pcie
index 765f14ef3d1e54d3cadccbf0a880f8adb73b3f1f..8eacd21d6ecdf9a3cd3e4f03cf1b40748dcbf53e 100644
GIT binary patch
literal 3023
zcmZvezi%T&6vyA%>v%o>k+tK*aeg^mi$LpG(a|8Cy>=2KJ6XKW1>uwSBn09}6A6R_
zC!~<#fOMQCY9r+jprt#Bii+zfD7c1(hLWq!eBVwsnkTZ7XXiWf-rM(iv$LLV*d70t
zCrb4?NB%*$-FYwYw{clS#C^WI{hy<-6HPAO+&l62oamt6Exy|u9($g*LrxTq+bZuw
z{wORLmD;!5jGM6vU(n=Y$3Gf2WBWq;dB$?0<9-({J1lAkR~7fIm+6;ja_+dqK7)n*
zUN_PYY5PIn^O`L@1fE4qpvTWCsr+{fl(urn4o>I2QE#6LM6*}Qo_w8W>G#6kV7s~*
z_3n>zXDlAh-09<oDn%;wBsdv$)cNG1&K>=*;4tuf&)3gFA|3nw$h)iO28W{~(C+F<
zl|>eQ8zh{|nyNj?kwvASUQvn&d0AFX=XKGy2XHgv?_I}tqTq(ZvXDABOtxgKx)6n<
z(3<E_x|l_s>UAijVTLN+5=xKVgnEaw+PNhwm6EYax5Uz8GFI!hSZNt+@s?P6>?T%c
z8u)#qT5azwt_fD2f!iLx2O$>Pi8`G_w0I|YWIQT2)J8x)_31;}CJ(<ZdY{uH`T%!=
zkzTG~G+r8fs?IBUJ3pTjuMO$Gg?^JN1s+!^E>9xT5G|?{?ZSMH&7keB6??(3q~~Hk
zm?n}v5kI!Yi=l0=6?-P8{6cEe*b|aHkxguyjy;nM(!`#K8k?rICrlH`p2#Tnv}4aC
z13UIiOl|F%BoAqFW&~#@_DoDO+A~QW(&StaoY)G;Cox@+oRB7GR&ZtoXI64Tnw*Z{
zbOfg(IU!9>d_IgyV-xG@#l_4?PDqne2~H(AmE?ppIq|L4HHp_KFF5m(6Vl|wM*^P7
zdKLs{L2^QxoY?;cXHjq#B`2iGiQTSi5@%ZyoF&N#X>ww38=Q-Rb5U|anw+lSbOom?
zIU!BXvfwNW&a&i$G&w7Rvm!Vvk`vP8ToRm1f^$i7LYkaa!C4iYRmllyaxM$bWx=^D
zIU!BX6~Vb8I9DVmq{)fDG-Ew$g0m($Ax+Lz!MQ3pS0yK;$ypbib-`JeoRB8xn&4a$
zoNJO3(&Sthoa=&fU2;O2oEw63LvU_LPDqn;Q*dqy&P~Y)X>x7}&Mm>YB{?BY&W7M@
z2+oG&gw&kXLgaVabj8P&7y7hvm{IS4Tci{Z5zV==zQMav;DaMy&*t;_pSnxim#-T$
zdKxV(@NX=ydyqI0g~vfajz1m^sJfSnjzZtQJSD$-(wrS+ryrM>lsg&z(fYTsaqowd
z&)U!4{{5rNQ)R<o2X_be))@<q!<`m~dd!V#a65CKP9IrcVWt^dH)ktPr-_{&c6suQ
zjd}d)^v9AO=Z7?}POEQ3-Ee5nUenn;zx(T7;qI5i?`wY#>%aKJS#J6XU6s?8#SM;?
wLwnQ<jYEzfpP~66*;3yB>hprDg6jOkcjLl0lI!ET5BLPM8&$Hl!oN2C2j(D$9{>OV

literal 3023
zcmZveJ!~UI6vyA%>v%o>$oeDSAI{O94y|oPM}ri5?IcEVvUr^f!bp1(0&%2?1VVxn
zQb=(?IxZ5mks@kZx|67=xDF%=uA!l!<f=3Ox0B7yQ*I^C&VS~;H}Cg$Jv-g7JNhk8
zl=`D{;O~YTop%C%1D8ca+~>R7|2Yaf(fI83?IVBNiFW(l;@iE!q33x`a-wk5R(U7#
zhhe#>)Q;t5+>BNDoW^HO|6tIF?F;Rv8Ow<d`(3o`FsmJ0Rot<jr=O?EdCevE*_+wv
zbtAn<+YkDl*Jxo8cos2%9<NhU`EO?^ZRL<1oKAbg-VPOrCNGpd{wmMX?}fd+joMn&
zyEn?6u(&^QFCN}kDN?CN!O^gzPRD0U+|i2#`+?_szFrH7bnJUW@2;NP+aDf)c2iHP
zEVA(1AmLn=)xx73SycMz1*M3Pmt`&Jyw0|M4E(<LGJe~8g9*UGtF=8Q3z51LbvpYx
zIFF2m<+@r8$frJiKpW)Y*G2C$dO+{vPB7951jA8v?-O-e$=mtqly<_tN4jsJ-=Io?
z$5jfVnTRw*iz-FCFrDJ@YP&1NUN9`_x!4b;iDXa2k8OdfZLbu2CZ=3sZ5n$*vL~{M
zZPT%5l0ll-6H#N+wDyE)BH0re#h!NTnPgzco{6cgJ(J`iP0ozq%*39FX-0b{$wQi)
zGlCNj7x^TnGm;b1<je}rtl-Q_PDqo}5uA?TbR;LF$%#LNQE9xEx_WUjbCMI%<Wz!F
z2~H(BAx%!~9=ay+Gs+9jyyS#5Iq{E$XYxD?g0mnwAx+Mr;4BKxqU3}$IZJ}GBsfcw
z6Vl|I6`Zqzb5?Rfnw+lSbOom?IU!BXvfwNW&a&i$G&w7Rvm!Vvk`vP8tP0Mm;H*kc
zNRzWBIBSBlCOIKZ&N;z3CphOMC#1<aFF5A~=e*>EG&!+J8}IFc;9QWLkS6D%;9L}(
zi;@%4<XjS*OM-JrazdJ%%Yt)Ra4t(uNRx9#aIOf>70C%{a;^%_Rl&I`IU!BXHNm+i
zIM*a6q{+E1IM)T|y5xj3IqQP6E;#Fw6H;@I&-ylRK`%eizPEk-Ar7vO8kU8<3P%n7
z$=An^WUMw5g~QOg3Z>6G@%Q~Y6iy0eC~RIgLg}&VP;YTo%~xclQZg2{vm3GWn2gnW
zRjjm(g$?dTEIoD=t5%5oPMa>d7SD7k_A~0;Z;F)SA)+Za*4OxF75L!D*OTdV`j_s~
z#`$eyMo*)K1<o$=+JZ#6!^0pT#~%&%sJ5Mp4np5PKPJC>)R^pMFFq<)l{+5%+4`@(
zy7m3hr|l<i{{G?lv9e*%#NENYb;5$<aHqwg9&)4V+)mub7Z0p2G1G{x8<Y9R7m1x7
zc6suIjd}d?_=l1n=S3Qq$F)0AHyqfLTRNMkcYpmm-27tj-NHYErC<EPBzN&KU6#|9
y#SM;?1AEvD#rwu*Xg)}`ly{>(&$ue6&cA#&E__kAKCb&7oWsqilC>4iIP^boV5A=a

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 9282ea0fb2..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,7 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/DSDT",
-"tests/data/acpi/aarch64/virt/DSDT.memhp",
-"tests/data/acpi/aarch64/virt/DSDT.topology",
-"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
-"tests/data/acpi/aarch64/virt/DSDT.pxb",
-"tests/data/acpi/x86/microvm/DSDT.pcie",
-- 
2.43.0


