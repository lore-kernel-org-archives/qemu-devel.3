Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 645B4C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 11:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFAu4-0006O4-O5; Thu, 06 Jun 2024 07:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sFAty-0006MD-Sv
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 07:03:29 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sFAtu-0007za-1x
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 07:03:24 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-421572bb0f0so9581995e9.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 04:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717671800; x=1718276600; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YDtFm+bfOyx7ii8ukPFhPK6OMhezvNjUdfnyr+Oqe5I=;
 b=Lw/Q8hAX2TK7JWZW+adv63l8NPOx7qwADGoez3UsbGyv0wcWcJnN+0OLo+z59BvYkr
 q6lIrD5LBzLwTZlY1FUNE4Dyn9OgD5IbXbLvFau0smgaD0UJlTp0k30YjvENfWuMypaZ
 PUg9GphvKu2fbU6+luii/s4Xb5sFZ5x/D+koSApD06d2Y74M54uncKjn3077bURi+i8X
 BzytwoQcGuo6RhqZSFOg7mYNVjjzYp4QI7ssIUknUxAQ7c+LTXUCWyGhqZEsHhTIpQT2
 8NQPvRHZDdwuaq+NX/DInsHZuJctcudnJSfv7zLVuvBdBn+8SNhzeDgRRzUb+f1er+as
 UeEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717671800; x=1718276600;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YDtFm+bfOyx7ii8ukPFhPK6OMhezvNjUdfnyr+Oqe5I=;
 b=LV4jll23GkHDCdG9pTsDyX/2PAZfzNT2L5vL/s1oJ2w0MLBhMAal997UFt1psYtC28
 QMJ3Fsi+gdD6sF+tqhviDAE/gyni+GJ6ogKXiCcnmTqp1WP89kxk8nf0cjRLYAb39QdB
 WKBI9zLyC7RZKw4c/u4iU8MI4/ytOXrCekYV/ysS16JNl0ESe4V3R9KQm9PU3HLQk1ng
 F6K0HTHtVCW40pbx3n5s1bgxUcEvnyoEgxmuVq/3gxf7R3U25iv18KJ+A/9O+hku1Ojq
 IpFi0lJrw7C2x+CE9gAFhjZlGfYxtSUJCyd7OjAKcsdwxk6z7N5btmdwcYgXLEq7gn3n
 1YOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXb/VlMCfBe0gFyqzGMX5E3Q4YbnMeEPIc1W6ZzKSaH9LMgCXblR5lSHz+Paq8+8z80ST+wzcY6+aWV/2Y6TkxTagv1gAU=
X-Gm-Message-State: AOJu0Yyq5Eiqn3ztcbziMTk14nGHYk4zf9lJVvMITLveyxUApey8mroD
 uHvfTAzoHetOofLUsdcPTtrVuKaD6GPb+76UcMP7zLpSiW/Omdm3HZby4Ua1+NM=
X-Google-Smtp-Source: AGHT+IEswG3HUBTA7tTnLvzBdqZFTi6pG25bq9dEXjSuS6NVl+yXPBTIpbWDfzN1df/5WtRisGiuaQ==
X-Received: by 2002:a5d:4ec6:0:b0:35d:bed3:634e with SMTP id
 ffacd0b85a97d-35e8833a0ffmr3705182f8f.30.1717671800194; 
 Thu, 06 Jun 2024 04:03:20 -0700 (PDT)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35ef5d29b1bsm1258845f8f.3.2024.06.06.04.03.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 04:03:19 -0700 (PDT)
Date: Thu, 6 Jun 2024 12:03:34 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Gavin Shan <gshan@redhat.com>
Cc: Itaru Kitayama <itaru.kitayama@linux.dev>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ard Biesheuvel <ardb@kernel.org>
Subject: Re: Unexpected error in rme_configure_one() at
 ../target/arm/kvm-rme.c:159
Message-ID: <20240606110334.GA3707954@myrica>
References: <CB05CAA2-9301-45F6-8AE3-A2E27A160CDF@linux.dev>
 <cbd630d7-01e8-49ba-9c8b-a6514d898ed2@redhat.com>
 <20240531150922.GA83195@myrica>
 <bd1f84bd-e23c-4f4b-bc0b-a2a1b70081f4@redhat.com>
 <20240603082402.GA25688@myrica>
 <2c81cb47-b9bc-4875-a7fb-49c3a8ab6713@redhat.com>
 <20240604111517.GB875061@myrica>
 <e7748b25-a01b-49e9-bbeb-cd03abb91cf6@redhat.com>
 <20240605155608.GA3251699@myrica>
 <1089f920-aff9-4d16-829d-5d058908a11e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089f920-aff9-4d16-829d-5d058908a11e@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Jun 06, 2024 at 03:05:02PM +1000, Gavin Shan wrote:
> > This commit moves the page tables from .rodata to .data. When linking
> > IdMap.obj into ArmPlatformPrePeiCore.dll, the alignment of the .text
> > section changes from 0x1000 to 0x800. This change comes from the linker
> > script putting .rodata into .text. I don't know why the included .rodata
> > alignment affects the .text alignment, but I don't think it matters here.
> > 
> > In GenFw, ScanSections64() calculates a mCoffAlignment as the max
> > .text/.data/.hii section alignement. Since with this commit, .data
> > alignement (0x1000) becomes larger than .text (0x800), it picks 0x1000 as
> > the output text offset, and then WriteSections64() complains that this
> > offset isn't equal to the input .text alignment modulo 0x1000.
> > 
> > The linker script says:
> > 
> >    /*
> >     * The alignment of the .data section should be less than or equal to the
> >     * alignment of the .text section. This ensures that the relative offset
> >     * between these sections is the same in the ELF and the PE/COFF versions of
> >     * this binary.
> >     */
> > 
> > but that's not what we're getting. I don't have a fix yet, other than
> > forcing the .text and .data alignment to 4k.
> > 
> 
> Jean, thanks for your explanation. Right, the issue is caused by mismatched
> alignments for ELF and PE/COFF sections. I ever dumped the variables at the
> failing point, showing the mismatched alignments (0x800 vs 0x1000). Apart from
> that, the virtual address of 'text' section is aligned to 0x800 instead of
> 0x1000 after ArmPlatformPrePeiCore.dll is dumped by 'readelf'.
> 
> SecHdr->sh_addr:                    0x800              <<< Mismatched alignment between ELF and PE/COFF
> SecOffset:                          0x1000
> SymShdr->sh_addr:                   0x800
> mCoffSectionsOffset[Sym->st_shndx]: 0x1000
> GenFw: ERROR 3000: Invalid
>   WriteSections64(): /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore/DEBUG/ArmPlatformPrePeiCore.dll AARCH64 small code model requires identical ELF and PE/COFF section offsets modulo 4 KB.
> 
> # readelf -S Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore/DEBUG/ArmPlatformPrePeiCore.dll
> Section Headers:
>   [Nr] Name              Type             Address           Offset
>        Size              EntSize          Flags  Link  Info  Align
>   [ 0]                   NULL             0000000000000000  00000000
>        0000000000000000  0000000000000000           0     0     0
>   [ 1] .text             PROGBITS         0000000000000800  00000800       <<< Aligned to 0x800
>        00000000000051b8  0000000000000000  AX       0     0     2048
> 
> With the following changes, I'm able to build the firmware successfully. I don't
> see how COMMONPAGESIZE is sorted out because I don't find its definition in the
> source code.

It's a ld builtin, set on the command-line with "-z common-page-size=X" by
Conf/tools_def.txt, in this case I believe DEBUG_GCC5_AARCH64_DLINK_XIPFLAGS. 

> 
> diff --git a/BaseTools/Scripts/GccBase.lds b/BaseTools/Scripts/GccBase.lds
> index 9f27e83bb0..5463df47a9 100644
> --- a/BaseTools/Scripts/GccBase.lds
> +++ b/BaseTools/Scripts/GccBase.lds
> @@ -20,7 +20,8 @@ SECTIONS {
>     */
>    . = PECOFF_HEADER_SIZE;
> -  .text : ALIGN(CONSTANT(COMMONPAGESIZE)) {
> +  /* .text : ALIGN(CONSTANT(COMMONPAGESIZE)) { */^M
> +  .text : ALIGN(4096) {^M

Build (after clean) fails for me if I only change the .text 
alignment, I need .data as well. So changing Conf/tools_def.txt is easier.
I'll try to find a proper fix but it will take me some time to understand
GenFw.


> > > > Note that the guest edk2 is optional and experimental, you can use direct
> > > > kernel boot to get a working demo quicker.
> > > > 
> > > 
> > > I never did this before. Could you please provide the detailed steps on this?
> > 
> > Removing the -bios parameter to QEMU should be enough. You can also add
> > 'earlycon' to -append to show early boot errors.
> > 
> 
> I didn't get a chance to try this yet since the host can't be brought up now.
> I will try this later. I originally thought some sort of boot wrapper is needed
> so that the kernel image has the capability to boot itself. For example, Mark
> Rutland's boot wrapper [1] can be leveraged in this case. I don't think Image has
> the capability to boot itself, right?

Yes QEMU can set up everything so that the Image boots on its own. What
the boot-wrapper does is minimal hardware initialization, handling PSCI
calls and passing the DTB pointer in x0. But that's only needed when using
the Arm FastModel (boot-wrapper is a lightweight firmware specifically for
the FastModel). QEMU can do all that itself so you can boot a kernel
without any firmware.

Using edk2 in the Realm guest will be needed for example to boot a distro
image which contains the kernel, but direct kernel boot is useful both for
prototyping and real-life use cases like confidential containers and some
cloud VMs.

Thanks,
Jean

> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/mark/boot-wrapper-aarch64.git
> 
> Thanks,
> Gavin
> 

