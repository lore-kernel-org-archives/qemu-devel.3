Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B437EC25B75
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 03:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEKRK-0005gB-UI; Mon, 03 Jun 2024 23:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sEKRJ-0005fw-Vy
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 23:02:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sEKRH-0002ZZ-TS
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 23:02:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717470138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X4caMMEs04BIN2gFo1aaUNUVWiGoKOv1S6GuO5UnMGw=;
 b=D+RH27PZVib80HFPiZtKcIkpewVoG/YVJwBKyQ5hnON1CawBXGDY2RyJGA6eOa9uV+5blm
 +KgaOFtno2IM5Nx9gaUYwZ1PkegeSAzguZ2vQ52xnBK2TkqfANGtqipyiZHHUXd3kTNQT1
 t9jwba0+yK/PqMhzRmLs6GzV9nEDnR4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-iTSki3-hNpGv1han03UW8A-1; Mon, 03 Jun 2024 23:02:17 -0400
X-MC-Unique: iTSki3-hNpGv1han03UW8A-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1f6810e43e0so10371145ad.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 20:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717470135; x=1718074935;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X4caMMEs04BIN2gFo1aaUNUVWiGoKOv1S6GuO5UnMGw=;
 b=WvV2Qtiq5CntjdxmEHhQ9TejNJWHwxIHEtrJzN+OQsna0xz/9rab9hymy81J/RQgSy
 qMsmjMcEMnbY4toWCd/soBL35EOzBnnecWcg13OBaK4eOLNcFcdtjnbJXW552BA18Bim
 G0P+SsUAoZugtbZMEkZcDDAX4RNUbBbsZb4qBFmFecD2YPud2LPRD5dXIqs6/poYB9fQ
 w3MUjk2f4K/aQcqRm2pUYS0H3NdkNx0NJ1ma83dXsSOzCes2Tpc2zyJcuJxUPmS1GgtB
 5QXvyRiiCNJlvxMZ8fg3g7UGE/PCojJafD/A8jL+SOvVZalVSi6aCjPdTLC3INmEADDA
 gpaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcYw+HME2YQTTBrO9U+HOo9Z1bt5U1vTrX6p82nC8h9sIk04I6H3JOct21WZXs4eUk9suPPlzyKrfyhMfZsa+mHQBtT4s=
X-Gm-Message-State: AOJu0Yy6UJomzhi1FlSVUU3g16SK46Dr3+8mgHTCUlXBCBEhFtpSAoIB
 ovZz9AaIe0lxpPuAneXc2gr55M1H+l2w/ugJHBrABdV3Sd/3LWeTHJdwn4/6T6a2ikCZnVp97fZ
 7ShTCK8o1iY/e9suvrNBENkr1wFT5s8RzdzI9YC6QX+s2e5GWTiHHmgOx1Akb
X-Received: by 2002:a17:902:cecb:b0:1f2:f8b7:60cf with SMTP id
 d9443c01a7336-1f69390b9b3mr23415475ad.27.1717470134703; 
 Mon, 03 Jun 2024 20:02:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgjFdsB5muAC+B/VP27Th2nDAUL+T2KAw5wvrM0MeaxZa6k90zVyOWPwsB/aH5oOF+hJawgA==
X-Received: by 2002:a17:902:cecb:b0:1f2:f8b7:60cf with SMTP id
 d9443c01a7336-1f69390b9b3mr23415185ad.27.1717470134223; 
 Mon, 03 Jun 2024 20:02:14 -0700 (PDT)
Received: from [192.168.68.50] ([103.210.27.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6323f6da2sm71867115ad.227.2024.06.03.20.02.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 20:02:13 -0700 (PDT)
Message-ID: <2c81cb47-b9bc-4875-a7fb-49c3a8ab6713@redhat.com>
Date: Tue, 4 Jun 2024 13:02:08 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unexpected error in rme_configure_one() at
 ../target/arm/kvm-rme.c:159
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Itaru Kitayama <itaru.kitayama@linux.dev>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ard Biesheuvel <ardb@kernel.org>
References: <0C6F517A-5686-4BCE-8D08-1CED02CB470E@linux.dev>
 <4e7aa598-1a5d-47e1-aaa3-78af05947eeb@linaro.org>
 <CB05CAA2-9301-45F6-8AE3-A2E27A160CDF@linux.dev>
 <cbd630d7-01e8-49ba-9c8b-a6514d898ed2@redhat.com>
 <20240531150922.GA83195@myrica>
 <bd1f84bd-e23c-4f4b-bc0b-a2a1b70081f4@redhat.com>
 <20240603082402.GA25688@myrica>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240603082402.GA25688@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hi Jean,

On 6/3/24 18:24, Jean-Philippe Brucker wrote:
> On Sat, Jun 01, 2024 at 08:14:46PM +1000, Gavin Shan wrote:
>> ---> guest edk2
>>
>> # git clone https://git.codelinaro.org/linaro/dcap/edk2.git edk2-guest
>> # cd edk2-guest; git checkout origin/cca/v2 -b cca/v2
>> # git submodule update --init --recursive;  \
>>    source edksetup.sh; make -j -C BaseTools; \
>>    export GCC5_AARCH64_PREFIX=;              \
> 
> Doesn't this needs a cross-compiler, something like "aarch64-linux-gnu-" ?
> 

No, I was building everything using a native compiler instead of a cross compiler.
All packages were compiled on a NVidia's grace-hopper machine.

[root@nvidia-grace-hopper-05 ~]# cat /etc/system-release
Red Hat Enterprise Linux release 9.5 Beta (Plow)
[root@nvidia-grace-hopper-05 ~]# uname -r
6.7.0-rc2-gavin+
[root@nvidia-grace-hopper-05 ~]# gcc --version
gcc (GCC) 11.4.1 20231218 (Red Hat 11.4.1-3)
Copyright (C) 2021 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

I tried the cross compiler and encountered the same build error.

[root@nvidia-grace-hopper-05 edk2-guest]# export | grep GCC5_AARCH64_PREFIX
declare -x GCC5_AARCH64_PREFIX="aarch64-linux-gnu-"
[root@nvidia-grace-hopper-05 edk2-guest]# build -b DEBUG -a AARCH64 -t GCC5 -p ArmVirtPkg/ArmVirtQemu.dsc
   :
--add-gnu-debuglink=/home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore/DEBUG/ArmPlatformPrePeiCore.debug /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore/DEBUG/ArmPlatformPrePeiCore.dll
cp -p -f /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore/DEBUG/ArmPlatformPrePeiCore.debug /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPrePeiCore.debug
"GenFw" -e SEC -o /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore/OUTPUT/ArmPlatformPrePeiCore.efi /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore/DEBUG/ArmPlatformPrePeiCore.dll
GenFw: ERROR 3000: Invalid
   WriteSections64(): /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore/DEBUG/ArmPlatformPrePeiCore.dll AARCH64 small code model requires identical ELF and PE/COFF section offsets modulo 4 KB.
GenFw: ERROR 3000: Invalid
   :

>>    build -b DEBUG -a AARCH64 -t GCC5 -p ArmVirtPkg/ArmVirtQemu.dsc
>>     :
>>    WriteSections64(): /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore/DEBUG/ArmPlatformPrePeiCore.dll AARCH64 small code model requires identical ELF and PE/COFF section offsets modulo 4 KB.
>> cp -p -f /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/OvmfPkg/VirtioFsDxe/VirtioFsDxe/DEBUG/VirtioFsDxe.dll /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/OvmfPkg/VirtioFsDxe/VirtioFsDxe/DEBUG/VirtioFsDxe.debug
>> cp -p -f /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Universal/Disk/PartitionDxe/PartitionDxe/DEBUG/PartitionDxe.debug /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/PartitionDxe.debug
>> "gcc" -MMD -MF /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/CryptoPkg/Library/OpensslLib/OpensslLibCrypto/OUTPUT/openssl/crypto/asn1/x_sig.obj.deps @/home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/CryptoPkg/Library/OpensslLib/OpensslLibCrypto/OUTPUT/cc_resp.txt  -c -o /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/CryptoPkg/Library/OpensslLib/OpensslLibCrypto/OUTPUT/openssl/crypto/asn1/x_sig.obj  /home/gavin/sandbox/CCA/edk2-guest/CryptoPkg/Library/OpensslLib/openssl/crypto/asn1/x_sig.c
>> "GenFw" -e DXE_CORE -o /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Core/Dxe/DxeMain/OUTPUT/DxeCore.efi /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Core/Dxe/DxeMain/DEBUG/DxeCore.dll
>> GenSec -s EFI_SECTION_USER_INTERFACE -n ArmCpuDxe -o /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/FV/Ffs/B8D9777E-D72A-451F-9BDB-BAFB52A68415ArmCpuDxe/B8D9777E-D72A-451F-9BDB-BAFB52A68415SEC3.ui
>> cp -p -f /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Universal/DisplayEngineDxe/DisplayEngineDxe/DEBUG/*.map /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Universal/DisplayEngineDxe/DisplayEngineDxe/OUTPUT
>> cp -p -f /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Universal/Disk/UdfDxe/UdfDxe/OUTPUT/UdfDxe.efi /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Universal/Disk/UdfDxe/UdfDxe/DEBUG
>> GenFw: ERROR 3000: Invalid
>>    :
>> build.py...
>>   : error 7000: Failed to execute command
>> 	make tbuild [/home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore]
>>
>>
>> build.py...
>>   : error F002: Failed to build module
>> 	/home/gavin/sandbox/CCA/edk2-guest/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore.inf [AARCH64, GCC5, DEBUG]
>>
>> - Failed -
>> Build end time: 05:42:19, Jun.01 2024
>> Build total time: 00:00:31
>>
>> ---> Use the edk2 image from the latest QEMU source
> 
> Unfortunately this can't work at the moment because edk2 needs several
> changes in order to run in a Realm
> 
>>
>> # cd /home/gavin/sandbox/CCA
>> # cp /home/gavin/sandbox/qemu.main/build/pc-bios/edk2-aarch64-code.fd ./
>>
>> ---> Start the guest and no output from the console
>>
>> host# mount | grep 9p
>> shr0 on /mnt/shr0 type 9p (rw,relatime,access=client,trans=virtio)
>> host# export SHR_DIR="/mnt/shr0"
>> host# qemu-system-aarch64 -accel kvm                              \
>>        -machine virt,gic-version=3,confidential-guest-support=rme0 \
>>        -cpu host -smp 2 -m 512M                                    \
>>        -object 'rme-guest,id=rme0,measurement-algo=sha512'         \
>>        -monitor none -serial mon:stdio -nographic                  \
>>        -bios /mnt/edk2-aarch64-code.fd                             \
>>        -kernel ${SHR_DIR}/linux/arch/arm64/boot/Image              \
>>        -initrd ${SHR_DIR}/buildroot/output/images/rootfs.cpio      \
>>        -append 'console=ttyAMA0'
>>          :
>>        <no output from the console>
>>          :
>>        (QEMU) q
>>
>> There are some messages from host's console indicating RMI/RMM servicing
>> states when the guest is running at background. After the guest is terminated,
>> the host crashes.
>>
>> SMC_RMM_RTT_CREATE            102dff000 122c2e000 1e00000 3 > RMI_SUCCESS
>> SMC_RMM_RTT_CREATE            102dff000 1234a7000 2000000 3 > RMI_SUCCESS
>> SMC_RMM_RTT_CREATE            102dff000 1235bd000 2200000 3 > RMI_SUCCESS
>> SMC_RMM_RTT_CREATE            102dff000 12387c000 2400000 3 > RMI_SUCCESS
>> SMC_RMM_RTT_CREATE            102dff000 123a5a000 2600000 3 > RMI_SUCCESS
>> SMC_RMM_RTT_CREATE            102dff000 12407d000 2800000 3 > RMI_SUCCESS
>> SMC_RMM_RTT_CREATE            102dff000 124109000 2a00000 3 > RMI_SUCCESS
>> SMC_RMM_RTT_CREATE            102dff000 123e49000 2c00000 3 > RMI_SUCCESS
>> SMC_RMM_RTT_CREATE            102dff000 124275000 2e00000 3 > RMI_SUCCESS
>> SMC_RMM_RTT_CREATE            102dff000 123138000 3000000 3 > RMI_SUCCESS
>> SMC_RMM_RTT_CREATE            102dff000 124d07000 3200000 3 > RMI_SUCCESS
>>   :
>>   :
>> [22768.994481] rcu: INFO: rcu_preempt self-detected stall on CPU
> 
> This is a warning rather than a crash. The current KVM patches spend too
> much time tearing down guest page tables (SMC calls to RMM) while holding
> the mmu lock. Not very nice but harmless.
> 

Ok, I can look into this deeply after I can bring up the guest successfully.

Thanks,
Gavin


