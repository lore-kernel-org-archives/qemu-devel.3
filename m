Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EAE0C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 11:15:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sES8I-0000S5-Fy; Tue, 04 Jun 2024 07:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sES8B-0000Pb-V8
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 07:15:08 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sES89-0000oD-1K
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 07:15:07 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-35dceef429bso2426068f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 04:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717499703; x=1718104503; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7fv9m5sIxWhpNdkQXDBoTm9R3u/RGiijs+gWHBT+CoA=;
 b=kGuJLRHsjPqqRGPMF61EwN8rso3Zp/b1Kx2L857xcPidkgjp1QtL4kwGC6QNci95gO
 joy+WmVn7r4F5qBtLOxEEee0Q6Dh1UbgprYGBVqkFki2d8MWG32JJTk2odqLlWemnlif
 KxlkO6b6hX38T2r2MV8Ubnzsh26mvpkiYkc4J+u4/zA8s7cGbHo5bee37wYswfVMxSC4
 LIeO8mKpcbwIbjpQMnYNTdc6JN/l6BPKQyIfRVs5XXRiz/UM2D65oTHI+zOqBBc55/FG
 C2LPrfbBCWqK5iIDmLPyTm7Ukal5NRYTTYQYmSN0C59M0BhSLzsMS+W0xSzHXvShYXRb
 5l4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717499703; x=1718104503;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7fv9m5sIxWhpNdkQXDBoTm9R3u/RGiijs+gWHBT+CoA=;
 b=FVnK6MIm2PdZsZrufDiGMtTggYXgfaI5pY1tohVl6dMtdttCJ2fHJLEoZY1JZD9WK/
 M6Jt5N4XjTbpqCLXlB5bh2DOzt51o+EbdX8lBVZ2XdKyvJtNdsAeLiN2AjcgFTX3GvKu
 vb5cpy1jkTn2URZoFFSP/luk+sFnN47V1oxM+yyLFMdlzFbIQ8Pxe7G1hPduNUKM8iVE
 QPh5e52E6Pe4wFTFOLjMJlD0fkRtve4aH1cup1dXuy02Gwj7CSwWwAi2y6YbjiQEwQex
 pfwMcoMS5LxPK2M9XPdC42LR/AtTsJMOa/9eAbE+reE1f/L71l2SnOuETciw5ikFo5D8
 5cfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUo5x0waVhNEI8jgV/zaYNyBBhojakYrGUYyW8Tsja2sE/ctrK8xBCE9czFBW2VccfNSE9ut6PlYfQbSVTcNFvjJht0NDk=
X-Gm-Message-State: AOJu0YwjPndpH+PZDS4QrQ1FomRJMG1u5drLtMt+6v4afD16vAxHpOFS
 /sXV1GWPPujq6Bbk+LKZLdD9afoBPDGdN0SKFmR6HW7ZkPUXwYByn9ZQADhnRzw=
X-Google-Smtp-Source: AGHT+IFqcxb3XsL84I6oO86GnWPLjKjh/wDop7SgwZfOUhF+lEmp19NOydQNq5beY/D5nXjFBzZR6g==
X-Received: by 2002:a5d:4bcf:0:b0:35e:7e13:fbe9 with SMTP id
 ffacd0b85a97d-35e7e13fdf4mr1532834f8f.13.1717499702631; 
 Tue, 04 Jun 2024 04:15:02 -0700 (PDT)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04d6e5asm11202888f8f.45.2024.06.04.04.15.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 04:15:02 -0700 (PDT)
Date: Tue, 4 Jun 2024 12:15:17 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Gavin Shan <gshan@redhat.com>
Cc: Itaru Kitayama <itaru.kitayama@linux.dev>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ard Biesheuvel <ardb@kernel.org>
Subject: Re: Unexpected error in rme_configure_one() at
 ../target/arm/kvm-rme.c:159
Message-ID: <20240604111517.GB875061@myrica>
References: <0C6F517A-5686-4BCE-8D08-1CED02CB470E@linux.dev>
 <4e7aa598-1a5d-47e1-aaa3-78af05947eeb@linaro.org>
 <CB05CAA2-9301-45F6-8AE3-A2E27A160CDF@linux.dev>
 <cbd630d7-01e8-49ba-9c8b-a6514d898ed2@redhat.com>
 <20240531150922.GA83195@myrica>
 <bd1f84bd-e23c-4f4b-bc0b-a2a1b70081f4@redhat.com>
 <20240603082402.GA25688@myrica>
 <2c81cb47-b9bc-4875-a7fb-49c3a8ab6713@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c81cb47-b9bc-4875-a7fb-49c3a8ab6713@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x430.google.com
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

Hi Gavin,

On Tue, Jun 04, 2024 at 01:02:08PM +1000, Gavin Shan wrote:
> Hi Jean,
> 
> On 6/3/24 18:24, Jean-Philippe Brucker wrote:
> > On Sat, Jun 01, 2024 at 08:14:46PM +1000, Gavin Shan wrote:
> > > ---> guest edk2
> > > 
> > > # git clone https://git.codelinaro.org/linaro/dcap/edk2.git edk2-guest
> > > # cd edk2-guest; git checkout origin/cca/v2 -b cca/v2
> > > # git submodule update --init --recursive;  \
> > >    source edksetup.sh; make -j -C BaseTools; \
> > >    export GCC5_AARCH64_PREFIX=;              \
> > 
> > Doesn't this needs a cross-compiler, something like "aarch64-linux-gnu-" ?
> > 
> 
> No, I was building everything using a native compiler instead of a cross compiler.
> All packages were compiled on a NVidia's grace-hopper machine.
> 
> [root@nvidia-grace-hopper-05 ~]# cat /etc/system-release
> Red Hat Enterprise Linux release 9.5 Beta (Plow)
> [root@nvidia-grace-hopper-05 ~]# uname -r
> 6.7.0-rc2-gavin+
> [root@nvidia-grace-hopper-05 ~]# gcc --version
> gcc (GCC) 11.4.1 20231218 (Red Hat 11.4.1-3)
> Copyright (C) 2021 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> 
> I tried the cross compiler and encountered the same build error.
> 
> [root@nvidia-grace-hopper-05 edk2-guest]# export | grep GCC5_AARCH64_PREFIX
> declare -x GCC5_AARCH64_PREFIX="aarch64-linux-gnu-"
> [root@nvidia-grace-hopper-05 edk2-guest]# build -b DEBUG -a AARCH64 -t GCC5 -p ArmVirtPkg/ArmVirtQemu.dsc
>   :
> --add-gnu-debuglink=/home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore/DEBUG/ArmPlatformPrePeiCore.debug /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore/DEBUG/ArmPlatformPrePeiCore.dll
> cp -p -f /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore/DEBUG/ArmPlatformPrePeiCore.debug /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPrePeiCore.debug
> "GenFw" -e SEC -o /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore/OUTPUT/ArmPlatformPrePeiCore.efi /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore/DEBUG/ArmPlatformPrePeiCore.dll
> GenFw: ERROR 3000: Invalid
>   WriteSections64(): /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore/DEBUG/ArmPlatformPrePeiCore.dll AARCH64 small code model requires identical ELF and PE/COFF section offsets modulo 4 KB.

Ah I've seen this once but it disappeared as I tried to investigate and
I've since changed the implementation, so I don't have many notes about
it.

Maybe you could try to bisect from "ArmVirtPkg: ArmCcaIoMmu: Provide an
implementation for SetAttribute", but it may give false positives if the
error depends on some random linker placement. Could be
"ArmVirtPkg/ArmPlatformLibQemu: Setup early UART mapping in a Realm" which
adds a 4k page to the data section for the ealy RSI config call, though
that has explicit 4kB alignment.

In my notes I also wrote that changing "-z common-page-size=0x20" to 4k in
the link flags may have made the error disappear, but I doubt it's the
right fix.

I'll try GCC 11 to see if I can reproduce.

> GenFw: ERROR 3000: Invalid
>   :
> 
> > >    build -b DEBUG -a AARCH64 -t GCC5 -p ArmVirtPkg/ArmVirtQemu.dsc
> > >     :
> > >    WriteSections64(): /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore/DEBUG/ArmPlatformPrePeiCore.dll AARCH64 small code model requires identical ELF and PE/COFF section offsets modulo 4 KB.
> > > cp -p -f /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/OvmfPkg/VirtioFsDxe/VirtioFsDxe/DEBUG/VirtioFsDxe.dll /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/OvmfPkg/VirtioFsDxe/VirtioFsDxe/DEBUG/VirtioFsDxe.debug
> > > cp -p -f /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Universal/Disk/PartitionDxe/PartitionDxe/DEBUG/PartitionDxe.debug /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/PartitionDxe.debug
> > > "gcc" -MMD -MF /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/CryptoPkg/Library/OpensslLib/OpensslLibCrypto/OUTPUT/openssl/crypto/asn1/x_sig.obj.deps @/home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/CryptoPkg/Library/OpensslLib/OpensslLibCrypto/OUTPUT/cc_resp.txt  -c -o /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/CryptoPkg/Library/OpensslLib/OpensslLibCrypto/OUTPUT/openssl/crypto/asn1/x_sig.obj  /home/gavin/sandbox/CCA/edk2-guest/CryptoPkg/Library/OpensslLib/openssl/crypto/asn1/x_sig.c
> > > "GenFw" -e DXE_CORE -o /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Core/Dxe/DxeMain/OUTPUT/DxeCore.efi /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Core/Dxe/DxeMain/DEBUG/DxeCore.dll
> > > GenSec -s EFI_SECTION_USER_INTERFACE -n ArmCpuDxe -o /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/FV/Ffs/B8D9777E-D72A-451F-9BDB-BAFB52A68415ArmCpuDxe/B8D9777E-D72A-451F-9BDB-BAFB52A68415SEC3.ui
> > > cp -p -f /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Universal/DisplayEngineDxe/DisplayEngineDxe/DEBUG/*.map /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Universal/DisplayEngineDxe/DisplayEngineDxe/OUTPUT
> > > cp -p -f /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Universal/Disk/UdfDxe/UdfDxe/OUTPUT/UdfDxe.efi /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Universal/Disk/UdfDxe/UdfDxe/DEBUG
> > > GenFw: ERROR 3000: Invalid
> > >    :
> > > build.py...
> > >   : error 7000: Failed to execute command
> > > 	make tbuild [/home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore]
> > > 
> > > 
> > > build.py...
> > >   : error F002: Failed to build module
> > > 	/home/gavin/sandbox/CCA/edk2-guest/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore.inf [AARCH64, GCC5, DEBUG]
> > > 
> > > - Failed -
> > > Build end time: 05:42:19, Jun.01 2024
> > > Build total time: 00:00:31
> > > 


> Ok, I can look into this deeply after I can bring up the guest successfully.

Note that the guest edk2 is optional and experimental, you can use direct
kernel boot to get a working demo quicker.

Thanks,
Jean

