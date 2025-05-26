Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B0BC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 13:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJYFn-0002mZ-NU; Mon, 26 May 2025 09:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uJYFd-0002ib-Mh
 for qemu-devel@nongnu.org; Mon, 26 May 2025 09:52:26 -0400
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uJYFb-00045Q-AI
 for qemu-devel@nongnu.org; Mon, 26 May 2025 09:52:25 -0400
Received: by mail-vs1-xe44.google.com with SMTP id
 ada2fe7eead31-4e2900db5f1so624419137.3
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 06:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748267542; x=1748872342; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tvYr9isK5TGICpDGzSUfitaCoF6wE0rY08Ts6Lkwo/M=;
 b=BAmoXbcuhWHokJiTds/jRl/P0ygiYLWev7Bn3vOrX57BUn/xZkQiVG4xU0JFj/LZxB
 fIt+M+/5PuN3WHUmXjEA2lXu1agApwhzt+TAzC+EeXuAeoxAFH23sh5invYbovIafPQD
 bLte9mcmn1gojz49QgeLuYwr1wNzvmmnEUKUnG/5gRXbGHhG1CwcyGKx5sSftNuGgtPy
 jhpdCFZa7+iJkuCMYbS9xKi3DFigWSdwGndDw2hc4Ytt5Zl+dKBERYU3GhtecvXvJXDm
 QSct4Q02VREOfOIJif5fQ1w+0tX1UMM5wARx1snkdHSNBzmTZ4TtxkdMttm2ytHyG436
 Hslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748267542; x=1748872342;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tvYr9isK5TGICpDGzSUfitaCoF6wE0rY08Ts6Lkwo/M=;
 b=hr4eHhBfrQELm3BU6Dfz8SLFsARDVmwGttfLUTvDMeHKRpi6Cr7z+QWiOFcBDmc5Sq
 +EqULzuundlYO73VIQ+VBtI8rhaztUD5BS62UhBCs/A62x3qAFvCupLfhrC6aWtrIQfP
 P1ff0by9icafYQx3Kyi60QXjjYDPs6sFFmrDIMqZ7jFA56z4n22Oc4MBYi629VIOIORB
 sa4TvJqVLTj+FbtxeVO+hHjNKaiXS4G/LX/5Z5s/WXNXU77YY0YyEWXrIXJuWAAds4ZR
 BGVZ6nssZQAvDBY8t8VNmbrfTWvbCb1rfyZnN22sACEmB+3xZp8Ka6Q44+W4Hr7leysA
 O7AQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWL+1HvrcBwYNz9EIVUCAbKKJVTIzwsN1KwGyUGKsH2NHa9Bk9zlV8PooskT1jSbezMfNcXTvdJn1bD@nongnu.org
X-Gm-Message-State: AOJu0Yxj8PLAklrO2XDjd7i4Wy6pGCc+g1OduR26T7kAqzaEEHfIl+bp
 TSMYw5TMtcM8rUREhhWAPiPBma7Soub1zih9lwG6fF1Jz1HIMMEqpQXD0f4D7liDXEY=
X-Gm-Gg: ASbGncsvhcdXIjsJlOemhnXGAmlSHFV3+0UwnLKwImtXGVlzvhLFgWTyUIFeL+eL7tc
 sTKakPwZ6lv++OE9K1ZZdhFK638rhb51gsOcaoujTfcS78lgOYsX1DVALH/olCsTObkTid+WHg6
 T0w0nms3FFom+Rz85RUYzOk9CvT/cw5dReX2DigzV0rs84ukow9/BX6QVMSmAQ1Yd90MfF2qOta
 MYz78QDCw6Yzxyf0ZCYPnG+QPqsF2LaJ0sRAva4e9T2j76yGaFXXIiNWXSkZpz3Gc5VX3HMOp7a
 JUr3CHKxTUvt3kYnlw7O62dcKJLXSF4oFECXOmSYQBkjfQZ98I4Oyipo4J+SRkSS/PG5c1M7HM/
 pzFvOBcK1vQGgt5QTRMaUs90s6YLsaA==
X-Google-Smtp-Source: AGHT+IGgNKBphVthnl/DZ171FGUYQWAdqCW0CDGzMO4ipaMzsWiyuacbgHKgKHA0aAxVDqq3l5tA8Q==
X-Received: by 2002:a05:6102:32c7:b0:4dc:81b7:f031 with SMTP id
 ada2fe7eead31-4e423ea7f29mr7545250137.0.1748267541894; 
 Mon, 26 May 2025 06:52:21 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b402:6ba2:d081:510e:25da:56a5?
 ([2804:7f0:b402:6ba2:d081:510e:25da:56a5])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-87dee1c2af6sm3500319241.19.2025.05.26.06.52.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 06:52:21 -0700 (PDT)
Message-ID: <f310d7e1-6a18-41b4-a2f0-73f961aa63f4@linaro.org>
Date: Mon, 26 May 2025 10:51:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] tests/qtest/bios-tables-test: Update changed ACPI
 blobs
To: eric.auger@redhat.com, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, thuth@redhat.com, alex.bennee@linaro.org,
 mst@redhat.com, imammedo@redhat.com
References: <20250526053123.1434204-1-gustavo.romero@linaro.org>
 <20250526053123.1434204-4-gustavo.romero@linaro.org>
 <fb728394-74f4-415d-9cb6-967526a86147@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <fb728394-74f4-415d-9cb6-967526a86147@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e44;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vs1-xe44.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Eric,

On 5/26/25 07:25, Eric Auger wrote:
> Hi Gustavo,
> 
> On 5/26/25 7:31 AM, Gustavo Romero wrote:
>> Update the aarch64 'virt' base blob and all of its variants. All of them
>> have the same diff, so only one is shown below. The essential changes is
>> in the AML code of the _OSC (OS Capabilities) method, (variable name
>> from 'CTRL' to 'Local0') and the scope for GED device.
> 
> Maybe we shall split the update into 2 steps

Yes, I think so.


> 1) introduce/validate the changes related to _OSC first

Yep, if I'm following you correctly :) When you say "introduce/validade
the changes related to _OSC first" you mean putting your series [0] (all patches or
at least patch 08/22 "hw/pci-host/gpex-acpi: Use build_pci_host_bridge_osc_method")
before this patch, 3/5, and after 1/5? If that's it, yip, I think that would
be the right thing to do.


> 2) produce the DSDT ref code with ACPI PCIHP hotplug elements

Yep, but you mean "with ACPI PCIHP hotplug elements" when acpi-pcihp=off, right?
Which is equivalent to put this patch, which contains the DSDT ref code with
ACPI PCI hotplug in place and with acpi-pcihp=off, after your changes in _OSC.


> What do you think?

Yeah, feel free to pick patches 1-3 from this series and apply accordingly to your
series. Patch 1/5 would be right before the change in _OSC in your series, i.e. before
patch 8/22, and patches 2/5 and 3/5 right after patch 8/22. Is this what you meant?

It seems there is also an inoffensive change in the scope of the GED, but I'm not
sure where it's coming from, maybe it comes from yet another patch, not from 8/22,
that also must be included between 1/5 and 2-3/5?

An alternative, which I think is less ideal, have 1/3 before your series and 2/5 and 3/5
at the end of your whole series. But I prefer them "sandwiching" the 8/22 patch and the
patches that exclusively touch the DSDT table, instead.

Then patches 4-5/5 in this series would come a separate series, after everything else,
and so can be merged separate.


Cheers,
Gustavo

[0] https://lists.nongnu.org/archive/html/qemu-devel/2025-05/msg03487.html

> Eruc
> 
>>
>> DSDT table diff:
>>
>>   DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPC    ", 0x00000001)
>>   {
>>       Scope (\_SB)
>>       {
>>           Device (C000)
>>           {
>>               Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
>>               Name (_UID, Zero)  // _UID: Unique ID
>>           }
>>
>> @@ -1794,53 +1794,52 @@
>>                       0x0000000000000000, // Granularity
>>                       0x0000008000000000, // Range Minimum
>>                       0x000000FFFFFFFFFF, // Range Maximum
>>                       0x0000000000000000, // Translation Offset
>>                       0x0000008000000000, // Length
>>                       ,, , AddressRangeMemory, TypeStatic)
>>               })
>>               Name (SUPP, Zero)
>>               Name (CTRL, Zero)
>>               Method (_OSC, 4, NotSerialized)  // _OSC: Operating System Capabilities
>>               {
>>                   CreateDWordField (Arg3, Zero, CDW1)
>>                   If ((Arg0 == ToUUID ("33db4d5b-1ff7-401c-9657-7441c03dd766") /* PCI Host Bridge Device */))
>>                   {
>>                       CreateDWordField (Arg3, 0x04, CDW2)
>>                       CreateDWordField (Arg3, 0x08, CDW3)
>> -                    SUPP = CDW2 /* \_SB_.PCI0._OSC.CDW2 */
>> -                    CTRL = CDW3 /* \_SB_.PCI0._OSC.CDW3 */
>> -                    CTRL &= 0x1F
>> +                    Local0 = CDW3 /* \_SB_.PCI0._OSC.CDW3 */
>> +                    Local0 &= 0x1F
>>                       If ((Arg1 != One))
>>                       {
>>                           CDW1 |= 0x08
>>                       }
>>
>> -                    If ((CDW3 != CTRL))
>> +                    If ((CDW3 != Local0))
>>                       {
>>                           CDW1 |= 0x10
>>                       }
>>
>> -                    CDW3 = CTRL /* \_SB_.PCI0.CTRL */
>> -                    Return (Arg3)
>> +                    CDW3 = Local0
>>                   }
>>                   Else
>>                   {
>>                       CDW1 |= 0x04
>> -                    Return (Arg3)
>>                   }
>> +
>> +                Return (Arg3)
>>               }
>>
>>               Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
>>               {
>>                   If ((Arg0 == ToUUID ("e5c937d0-3553-4d7a-9117-ea4d19c3434d") /* Device Labeling Interface */))
>>                   {
>>                       If ((Arg2 == Zero))
>>                       {
>>                           Return (Buffer (One)
>>                           {
>>                                0x01                                             // .
>>                           })
>>                       }
>>                   }
>>
>>                   Return (Buffer (One)
>> @@ -1851,33 +1850,36 @@
>>
>>               Device (RES0)
>>               {
>>                   Name (_HID, "PNP0C02" /* PNP Motherboard Resources */)  // _HID: Hardware ID
>>                   Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
>>                   {
>>                       QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
>>                           0x0000000000000000, // Granularity
>>                           0x0000004010000000, // Range Minimum
>>                           0x000000401FFFFFFF, // Range Maximum
>>                           0x0000000000000000, // Translation Offset
>>                           0x0000000010000000, // Length
>>                           ,, , AddressRangeMemory, TypeStatic)
>>                   })
>>               }
>>           }
>> +    }
>>
>> +    Scope (\_SB)
>> +    {
>>           Device (\_SB.GED)
>>           {
>>               Name (_HID, "ACPI0013" /* Generic Event Device */)  // _HID: Hardware ID
>>               Name (_UID, "GED")  // _UID: Unique ID
>>               Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
>>               {
>>                   Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, ,, )
>>                   {
>>                       0x00000029,
>>                   }
>>               })
>>               OperationRegion (EREG, SystemMemory, 0x09080000, 0x04)
>>               Field (EREG, DWordAcc, NoLock, WriteAsZeros)
>>               {
>>                   ESEL,   32
>>               }
>>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> ---
>>   tests/data/acpi/aarch64/virt/DSDT             | Bin 5196 -> 5178 bytes
>>   .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5282 -> 5264 bytes
>>   tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6557 -> 6539 bytes
>>   tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7679 -> 7635 bytes
>>   tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5398 -> 5380 bytes
>>   tests/qtest/bios-tables-test-allowed-diff.h   |   5 -----
>>   6 files changed, 5 deletions(-)
>>
>> diff --git a/tests/data/acpi/aarch64/virt/DSDT b/tests/data/acpi/aarch64/virt/DSDT
>> index 36d3e5d5a5e47359b6dcb3706f98b4f225677591..5c73e64e0c29d3cea5299929afd00e9a1238e559 100644
>> GIT binary patch
>> delta 125
>> zcmX@3u}g!?CD<jzN`!%dNoFFKG*h4XMs+tXCb!9(^SP`!1bx`!{ezuZy0RIZUBV3)
>> z__0pjEu>{)oKT&>C7-ZBVAAAF##)dJ7YA5gc+zAbZJYoR699=7B!EN~@=P`s?&1(|
>> P<BW+9c8Z_8SGXSlZJ{Hk
>>
>> delta 142
>> zcmdm`aYlp7CD<jzM}&caNqQoeG*i3NMs+tXCWon;^SP`!1l>5}{ezuZy0RIZUBV3)
>> zc(702Eu`gV6dW25PyiG$b`A;hsRj{T@*r}7z@*8UjI|)OTpVB>Vv{Dr)Io#=K*9we
>> U#USw|*$eq5OA2>QUM<`Y00vhni~s-t
>>
>> diff --git a/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt b/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt
>> index e6154d0355f84fdcc51387b4db8f9ee63acae4e9..b0a875d8da3592b5927095304ca31ceb001b2fdf 100644
>> GIT binary patch
>> delta 125
>> zcmZ3aIYE=lCD<iof(Qcx(~F5*(o8M38`bA<F}Y3Ne3Z+YL(qpk-apuxr7N4k*(Ka?
>> zfgkH+L18Tu<Amx2F8PE70+S|ZGS-4*xH!P_!jmQgY2yTlm;gwuAOR$@kY{qIa2JPw
>> P8)r;>uv7eGVUd0S*;^zc
>>
>> delta 142
>> zcmbQBxk!`CCD<iokq83=(~XH-(oDVX8`bA<F*!`#e3Z+YL(q*g-apuxr7N4k*(Ka?
>> zfd~6!L18UFqu|hhfC8Y1v2#d}Pc?|(k_V9s1SU<+WUK|L<>CPA5Sug^rVb)301_?$
>> UDF%rz$zI4eIbXPIGNVX80DOQd2mk;8
>>
>> diff --git a/tests/data/acpi/aarch64/virt/DSDT.memhp b/tests/data/acpi/aarch64/virt/DSDT.memhp
>> index 33f011d6b635035a04c0b39ce9b4e219f7ae74b7..21a6b086cbf72298d125d8bfc4c4b7ec9315267b 100644
>> GIT binary patch
>> delta 126
>> zcmbPh+-=O|66_MvEy=*ZWIK^dnyJrxqq-XxliTFY`CQf<f<El={=v>HUD*uIF5!j?
>> z{8%UN7Sb{?PN+`cl22G5FllloV=YLAivuh#JZUnJHco(u34p{35<nsgc_teRcX0@~
>> Q$Hl}4JH>C_EBt^J0I0kqp#T5?
>>
>> delta 143
>> zcmeA+o@>nI66_K(SCWB&$z~##G*id)jp}Y(Ob$~w=W|(e2)c2``v*I-bY(L*yM!Aq
>> z@L-?3TS&{#C^$4Apa3Xh>>Lv0Qw<`x<U!;Dfk~4y8EZjmxj4W&#3oIKse=d$fP@P`
>> Vib3K_vKR7AmK5&Vyju7HD*$j8Du)07
>>
>> diff --git a/tests/data/acpi/aarch64/virt/DSDT.pxb b/tests/data/acpi/aarch64/virt/DSDT.pxb
>> index c0fdc6e9c1396cc2259dc4bc665ba023adcf4c9b..c8548a5e5d41a843142c7bbe64580025e006445d 100644
>> GIT binary patch
>> delta 217
>> zcmexwec77JCD<k8vMd7w)AEU2(oF3aH>$gFF?qIa&ga_8F6hG^?;q^U(v{8N>=JIc
>> zz>jruo{W}>aYA(hmwdtkfk~4y8EZi@TpVC|;YpK$v~dDNOaLTSkN^@{$TRtwjP2%6
>> gLVAo$Zj(1FiCA+`*X%A10XNQ=_+Y2_$py0g04PO4(EtDd
>>
>> delta 260
>> zcmca?{ok6)CD<k8zbpd-Q^!OuX{N5b8`a&on4CK{=X3347j)x{_YZbv>B?qsb_q9J
>> z;K4rGR!GawC^$4Apa3Xh>>Lv0Qw<`x<U!;Dfk~4y8EZjmxj4W&#3oIKse=d$fP@P`
>> oib3K_vKR7go-LHk$mB3}Glz&Z2VHEOJX^?i@_QNI$u6?}0Luzao&W#<
>>
>> diff --git a/tests/data/acpi/aarch64/virt/DSDT.topology b/tests/data/acpi/aarch64/virt/DSDT.topology
>> index 029d03eecc4efddc001e5377e85ac8e831294362..73aa833317627204aef7ac858d178445bcd37a54 100644
>> GIT binary patch
>> delta 125
>> zcmbQH)uP4a66_MfBFezPBruUnnyJHOqq+b$liTFYmfY4Hf<El={=v>HUD*uIF5!j?
>> z{8%Tq3Tv4dCsZeJ$tNrjm^3+)u@)r5#Q~NVo-`Rq8z(@-1VCa12_TV$Jd^(lcX0@~
>> PamK_4JH=0K7wHE8^splO
>>
>> delta 142
>> zcmZqCnx@6&66_KpCd$CT#6OWsnyJx$qq+b$lf%@_mfY4Hf^MAg{=v>HUD*uIF5!j?
>> zJlH3<3Tycp1&0O%6aYnxokN0rszC&oJcwK%FllloV=YK67YA5}*rdrYbr4|zkZ=J=
>> UF-Uw#_CmhNkA=G?mx}ZQ0C4*#-~a#s
>>
>> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
>> index abe00ad4ee..dfb8523c8b 100644
>> --- a/tests/qtest/bios-tables-test-allowed-diff.h
>> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
>> @@ -1,6 +1 @@
>>   /* List of comma-separated changed AML files to ignore */
>> -"tests/data/acpi/aarch64/virt/DSDT",
>> -"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
>> -"tests/data/acpi/aarch64/virt/DSDT.memhp",
>> -"tests/data/acpi/aarch64/virt/DSDT.pxb",
>> -"tests/data/acpi/aarch64/virt/DSDT.topology",
> 


