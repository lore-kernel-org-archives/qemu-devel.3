Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5ACBC54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 13:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJu0O-0007SK-BZ; Tue, 27 May 2025 09:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uJu0M-0007Ro-HR
 for qemu-devel@nongnu.org; Tue, 27 May 2025 09:06:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uJu0J-0005FU-9a
 for qemu-devel@nongnu.org; Tue, 27 May 2025 09:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748351160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wJSb18eNQjK+1799of0iX18ofYOT/jN9CEhj+63eeBc=;
 b=dCd5rRHGG+00HJayQUZrUdLRwaZUnd0OarKu0scbSFxTnUQPPXCKKd9aNJGrrWJLzn4u6M
 GPQaG8I4JHNCzTpU6DXE3RkJ7LxiETbEgXrugkahzpUPQUpsOdTDCJ++rF+rJZGuCJUEgo
 DFKrAiLwUhdZfyGCZqXdZ7j+6L8+THY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483--5AUd8MrMgqpbdsNdpYVXw-1; Tue, 27 May 2025 09:05:59 -0400
X-MC-Unique: -5AUd8MrMgqpbdsNdpYVXw-1
X-Mimecast-MFC-AGG-ID: -5AUd8MrMgqpbdsNdpYVXw_1748351158
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a36e6b7404so1837917f8f.0
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 06:05:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748351158; x=1748955958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wJSb18eNQjK+1799of0iX18ofYOT/jN9CEhj+63eeBc=;
 b=UIm2RUZU/mc7UeFJul/H/2VphbTmfgUeDCvxDQNRXDtNk4aklc8KQd3KA9Z0t2zSf3
 VYUciQ1d0TsveNs1Sk8BbFlQMHTJb/naBsc9eJZeSdcs3IISf8aedrj7HgktEe4MME3M
 awo/nmncXmqnZ+ykp9MlN/5lZOI0/NcunMvXD00RFNYpjxmjGqQLr2co67cXoU18pJTe
 QmVmalSDH7/Ks0heBbs9s49rZD6D2cxTMifONvigdTRJYuXSd1iKoV3s0qcSgcqJHbf6
 sKJtbuF1BJDR0ugVd7C2wREOcr1t3WcObUCdQo49YbWTImYGRvnvLIjlpfWqGvhfk6k6
 mG8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlLeZYQceJChCble3Nu5hYKrkbhjFXSrniBDYAZa0+b+nNdS7akMY4TBSO8wBZKh+K9mbBmEnugXuU@nongnu.org
X-Gm-Message-State: AOJu0Yw/PznujlIwYSe6dZQqgtkQ6Yh3nLFREWsiiK0xU0E7NbX+vLtD
 uHVxui1d4OJmoeTfs3I/VrwjKRcZStH9sVK99XFMyOxrN2hbwQMczmMXXZ10sFBKkdwj8bwjgNx
 fKfgRIwjLZJK36sOIdFHBGIr3DikG5ifbK/iAWvnInTpY3Z0K9abQ80Hr
X-Gm-Gg: ASbGncvQmGvG3/j+bt6qgOlfjZGDJ5/zQVO3eGLgL44Uh+hjSEhkufsF4ZW/v6ZOZ4V
 21loAND6mrUbCB3IuZUmBAPO8xQW69/xGlibbEUNu+EwAaGdY5tJGMyzbQKDH8vSBd5zu3XTNhr
 ZTPYSaY8lc5/PKfb8vcmKTh5QTV0t8yBzdtHN8KH3vj5nCOI35P24DwebP8YhZU5MPNnVqCNl0o
 M3Qg2CNIGp31duRR8WYnx+5cQYtj6QLKjL4lG+iCdl7vzJNB3bagfVnAkmlaye5HR3opdqw6cIm
 keQOHwQZIHSgrhgW2pPam41uVW2lnpUW
X-Received: by 2002:a05:6000:2203:b0:3a4:dfa5:325e with SMTP id
 ffacd0b85a97d-3a4dfa53302mr4236306f8f.10.1748351157269; 
 Tue, 27 May 2025 06:05:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfQGtiZTCSdlvQ1BxZJJ/iuMYYLW5OMGs/NRg/GMLWNDM2/27RpNYK44VU0RsoVyfaJtHwhQ==
X-Received: by 2002:a05:6000:2203:b0:3a4:dfa5:325e with SMTP id
 ffacd0b85a97d-3a4dfa53302mr4236198f8f.10.1748351156395; 
 Tue, 27 May 2025 06:05:56 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca4d1fasm20133726f8f.1.2025.05.27.06.05.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 06:05:56 -0700 (PDT)
Date: Tue, 27 May 2025 15:05:54 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v2 10/25] tests/qtest/bios-tables-test: Update DSDT
 blobs after GPEX _OSC change
Message-ID: <20250527150554.0374eb71@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250527074224.1197793-11-eric.auger@redhat.com>
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-11-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
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

On Tue, 27 May 2025 09:40:12 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> From: Gustavo Romero <gustavo.romero@linaro.org>
> 
> Update the reference DSDT blobs after GPEX _OSC change.
> 
> DSDT diff can be found below.

this needs to be updated to take into account microvm

> 
>   *
>   * Disassembling to symbolic ASL+ operators
>   *
> - * Disassembly of dsdt.dat, Mon Apr  7 05:33:06 2025
> + * Disassembly of dsdt.dat, Mon Apr  7 05:37:20 2025
>   *
>   * Original Table Header:
>   *     Signature        "DSDT"
> - *     Length           0x00001A4F (6735)
> + *     Length           0x00001A35 (6709)
>   *     Revision         0x02
> - *     Checksum         0xBF
> + *     Checksum         0xDD
>   *     OEM ID           "BOCHS "
>   *     OEM Table ID     "BXPC    "
>   *     OEM Revision     0x00000001 (1)
> @@ -1849,27 +1849,26 @@ DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPC    ", 0x00000001)
>                  {
>                      CreateDWordField (Arg3, 0x04, CDW2)
>                      CreateDWordField (Arg3, 0x08, CDW3)
> -                    SUPP = CDW2 /* \_SB_.PCI0._OSC.CDW2 */
> -                    CTRL = CDW3 /* \_SB_.PCI0._OSC.CDW3 */
> -                    CTRL &= 0x1F
> +                    Local0 = CDW3 /* \_SB_.PCI0._OSC.CDW3 */
> +                    Local0 &= 0x1F
>                      If ((Arg1 != One))
>                      {
>                          CDW1 |= 0x08
>                      }
> 
> -                    If ((CDW3 != CTRL))
> +                    If ((CDW3 != Local0))
>                      {
>                          CDW1 |= 0x10
>                      }
> 
> -                    CDW3 = CTRL /* \_SB_.PCI0.CTRL */
> -                    Return (Arg3)
> +                    CDW3 = Local0
>                  }
>                  Else
>                  {
>                      CDW1 |= 0x04
> -                    Return (Arg3)
>                  }
> +
> +                Return (Arg3)
>              }
> 
>              Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>  tests/qtest/bios-tables-test-allowed-diff.h   |   5 -----
>  tests/data/acpi/aarch64/virt/DSDT             | Bin 5196 -> 5170 bytes
>  .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5282 -> 5256 bytes
>  tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6557 -> 6531 bytes
>  tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7679 -> 7627 bytes
>  tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5398 -> 5372 bytes
>  6 files changed, 5 deletions(-)
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index abe00ad4ee..dfb8523c8b 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,6 +1 @@
>  /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/aarch64/virt/DSDT",
> -"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
> -"tests/data/acpi/aarch64/virt/DSDT.memhp",
> -"tests/data/acpi/aarch64/virt/DSDT.pxb",
> -"tests/data/acpi/aarch64/virt/DSDT.topology",
> diff --git a/tests/data/acpi/aarch64/virt/DSDT b/tests/data/acpi/aarch64/virt/DSDT
> index 36d3e5d5a5e47359b6dcb3706f98b4f225677591..21278dd23850f3714f82da4da37d8f6f0def7c41 100644
> GIT binary patch
> delta 113
> zcmX@3u}Oo=CD<jzNQ8lbNoyjPG*hp`Ms+tXCb!9(^SP`!1bx`!{ezuZy0RIZUBV3)
> z__0pjEu>{)oKT&>C7-ZBVAAAF##)dJ7YA5gc+zBNmvG|*h?oFKtRMj-vXE!9v9Kf~  
> E0NvLgQ~&?~
> 
> delta 139
> zcmdm_aYlp7CD<jzM}&caNqQoeG*i3NMs+tXCWon;^SP`!1l>5}{ezuZy0RIZUBV3)
> zc(702Eu`gV6dW25P~hwmZtNTq<WmhIxa2|P0)a`BGZ||^YPmSTI>aVThN*)H3xI?R
> SK#D=)OR^X8ZI%?4WCQ?(sV7tb
> 
> diff --git a/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt b/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt
> index e6154d0355f84fdcc51387b4db8f9ee63acae4e9..a29aa5d2ea83f00c543b58fe33ec7ce826e050be 100644
> GIT binary patch
> delta 113
> zcmZ3a*`dkh66_MvA;Q4G^lc)SG*h$NM)f&dOm34mALX*<5cFY>_YZbv>B?qsb_q9J
> z;Kw>yP*}^vIH5X$OFm(Nz@*8UjI|&cE)KA~@TAGkF5$)r5HSIeSV00vWFgPyPGLz#
> E06pL!c>n+a  
> 
> delta 139
> zcmeCsT%^h666_MPNQ8lb>BdAZX{KKHjp}o_m>i~VKFVdyA?U^#?;q^U(v{8N>=JIc  
> zz=M6Vps<#oQE+HLK!LMMxUq9ckWV#;;F1TC3j`)j&Sb0wspaAT>kykX8Kw>*EC3QN
> S04WBEFUelWw>e)}k`Vy<UnqG1  
> 
> diff --git a/tests/data/acpi/aarch64/virt/DSDT.memhp b/tests/data/acpi/aarch64/virt/DSDT.memhp
> index 33f011d6b635035a04c0b39ce9b4e219f7ae74b7..786466e58a7a81bf81fb7cadbb0630e803f19f28 100644
> GIT binary patch
> delta 113
> zcmbPh+-%I{66_MvEXlyY<UNr~nyGK<Ms+tXCb!9(^SP`!1bx`!{ezuZy0RIZUBV3)
> z__0pjEu>{)oKT&>C7-ZBVAAAF##)dJ7YA5gc+zBNmvG|*h?oFKtRMj-vXE!9v2Yd}  
> E01f0IF8}}l
> 
> delta 139
> zcmZoRo@>nI66_K(SCWB&$z~##G*id)jp}Y(Ob$~w=W|(e2)c2``v*I-bY(L*yM!Aq  
> z@L-?3TS&{#C^$4ApupKB+}JrJ$fp`aaLI$n1p<>MXEN4;)N*lvb%;%x3{wXY761ts
> SfE0tomt-&G+bk)Z#RdSwDJU-h
> 
> diff --git a/tests/data/acpi/aarch64/virt/DSDT.pxb b/tests/data/acpi/aarch64/virt/DSDT.pxb
> index c0fdc6e9c1396cc2259dc4bc665ba023adcf4c9b..cdefdbb92f6b509b39413a3150d0d5d575c22df3 100644
> GIT binary patch
> delta 205
> zcmexwecGDKCD<k8v@8Py)7FVx(oAi)HmbXEF?qIa&ga_8F6hG^?;q^U(v{8N>=JIc
> zz>jruo{W}>aYA(hmwdtkfk~4y8EZi@TpVC|;YpL7UBZnMAYuX_v4RAU$U>gU&tz;j  
> Ze-hGTWOAFlSxLm2gNkNvekLQy2mmfWJ;DG0
> 
> delta 256
> zcmX?Y{ok6)CD<k8zbpd-Q^!OuX{N5b8`a&on4CK{=X3347j)x{_YZbv>B?qsb_q9J
> z;K4rGR!GawC^$4ApupKB+}JrJ$fp`aaLI$n1p<>MXEN4;)N*lvb%;%x3{wXY761ts
> lfE0tomt-&G+dNw+n~}+3>ShiRYYw{DIC-{^?d10|cL0k$O`-q*
> 
> diff --git a/tests/data/acpi/aarch64/virt/DSDT.topology b/tests/data/acpi/aarch64/virt/DSDT.topology
> index 029d03eecc4efddc001e5377e85ac8e831294362..8cb1d9ef7a6e5a0429e96bf4b6529bc814a936b0 100644
> GIT binary patch
> delta 113
> zcmbQH^+%J-CD<k8j|c+;ll(+3X{L7Hjp_p2Om34mTXI`-2>P(c`v*I-bY(L*yM!Aq
> z@ME3aDy(H<oKT&>C7-ZBVAAAF##)dJ7YA5gc+zBNmvG|*h?oFKtRMj-vXE!<Utvi`
> E018GRTmS$7
> 
> delta 139
> zcmeyPIZcbpCD<iIOq79viGL!OG*hGhMs)#hCWon;ExD~Z1l>5}{ezuZy0RIZUBV3)
> zc(6}y71r`I3JwhjC~$TOH+BvQ@~H+9T=F1tfxx86nT)j{wOkxv9b%Iv!_+~91wg_D
> SAjKf@CD{x4Ha`}YWCQ>=S0`Km  
> 


