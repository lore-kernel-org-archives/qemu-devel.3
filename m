Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E7CC5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 11:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh65a-0000Uz-1V; Mon, 04 Mar 2024 06:02:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rh65W-0000Ue-Sr
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 06:02:30 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rh65U-0008Au-7o
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 06:02:30 -0500
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8AFAD3F277
 for <qemu-devel@nongnu.org>; Mon,  4 Mar 2024 11:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1709550143;
 bh=uiY8NqiPOKqKZHs73FbG/rU0tKKAruIzl88i5I30NHY=;
 h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
 In-Reply-To:Content-Type;
 b=h640bZ4Pe6tPV343/uz3Z5h+7CVxUhXfA/op2nptup1RCiOgprFiM/BTG88Z4Aei1
 VL4Y1yL/gfxIbfy6rSWXTSOrZY4Unm43tQS8RdRPgNB78CHq6mann2dYBiIPFkzy66
 KbrIVPpB0VIKLqo0JAvmyTsNkxNw7UMKQmma06qPEntEH+YqzNatPwHUFC62pImHWo
 lkXU7AG6MocEbrGo3TcBqyk6cys6LGOBMxd3SM8AgxwnrsX44guu+gQMVMEcdL/3ms
 cm5z6MjiUxB8h/HZU6eMAP6g02/vJPytv/EUbbU6UXcCk8muFmWvVO932NBPPvEbQ9
 ZKn+3vBi7PxMg==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-412d433bba5so10186275e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 03:02:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709550143; x=1710154943;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uiY8NqiPOKqKZHs73FbG/rU0tKKAruIzl88i5I30NHY=;
 b=Pu8AWnWHDABpQV1GfLEH7Q3e2urLeFta7UjORnqrHkdB68zGcb9ooTDbOyzElWgXKM
 BfRi3dAzs6W9M6ms+HJ5SaD7UK49XtUQUAqM5LpPGu7FJP0L0qiK4TGYSzl1lPlIswlH
 1nWCa9dvPSL8KRYqvrv4eUdEIZwNKJSVz6hehWHjNK4aj2PrKb3Q6vIHSf86x36zZW0Y
 Im9kyg2IWlyMEj06OlPQdVqGTLAmibC4zMQeHFhFMxWvDABargyCLY2ex3F2wwYSJ5Ay
 iMpJQOwSS3qcIOGfgC/KMIps510b3qwUPSrmLzJhYqY3PtrBLP7l5lWea9DkoLrPUXRT
 rm9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9fz8mPL0VEZ3r5RAy0ngMDSd061K6htX7KmE65VOQqIIn7+7CHpGOWU7/+AVPSXSIeHgTU3mdqbXdhpESC/dvQ2thxlI=
X-Gm-Message-State: AOJu0YzolegNeHXGCTi7M4eA6VmZLZgErKWOv5IqxF4gyB0qxKHajHPY
 cOzOPEmp/gb9dtpV4ThzIo01q3JTReHCET2DnxqlLI9cgLdlMoSpLbdmtxXmT/EsYlvvhjWso/Q
 h2g6J+UEiIqzhm0o+Fyu4TpH+azJZfzOa1Fhim1whGIDH57zpMFT2iMKg5oDaHubcQ+cI
X-Received: by 2002:a05:600c:474a:b0:412:7489:c8c0 with SMTP id
 w10-20020a05600c474a00b004127489c8c0mr6028302wmo.34.1709550142971; 
 Mon, 04 Mar 2024 03:02:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOOVXIGXuGD5Vsvm8bHYcdzuL8LADwI6ksGTIofa1mnBSIuR/wo4Iq9UjgTbSEStSHd7q+uA==
X-Received: by 2002:a05:600c:474a:b0:412:7489:c8c0 with SMTP id
 w10-20020a05600c474a00b004127489c8c0mr6028275wmo.34.1709550142588; 
 Mon, 04 Mar 2024 03:02:22 -0800 (PST)
Received: from [192.168.123.67] (ip-095-222-037-056.um34.pools.vodafone-ip.de.
 [95.222.37.56]) by smtp.gmail.com with ESMTPSA id
 d8-20020a05600c3ac800b00412e84e59d8sm457721wms.44.2024.03.04.03.02.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 03:02:22 -0800 (PST)
Message-ID: <d1bde67a-0f02-4fa4-a736-cbd3f35ff553@canonical.com>
Date: Mon, 4 Mar 2024 12:02:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RISC-V][tech-server-platform] [RFC 0/2] Add RISC-V Server
 Platform Reference Board
Content-Language: en-US
To: "Wu, Fei2" <fei2.wu@intel.com>
References: <20240304102540.2789225-1-fei2.wu@intel.com>
Cc: pbonzini@redhat.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 andrei.warkentin@intel.com, shaolin.xie@alibaba-inc.com, ved@rivosinc.com,
 sunilvl@ventanamicro.com, haibo1.xu@intel.com, evan.chai@intel.com,
 yin.wang@intel.com, tech-server-platform@lists.riscv.org,
 tech-server-soc@lists.riscv.org
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20240304102540.2789225-1-fei2.wu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 04.03.24 11:25, Wu, Fei2 wrote:
> The RISC-V Server Platform specification[1] defines a standardized set
> of hardware and software capabilities, that portable system software,
> such as OS and hypervisors can rely on being present in a RISC-V server
> platform. This patchset provides a RISC-V Server Platform (RVSP)
> reference implementation on qemu which is in compliance with the spec
> as faithful as possible.
> 
> The reference board can be running with tag edk2-stable202308 in
> upstream edk2 repo[2].
> 
> The qemu command line used:
> 
> $QEMU -nographic -m 4G -smp 2 \
>      -machine rvsp-ref,pflash0=pflash0,pflash1=pflash1 \
>      -blockdev node-name=pflash0,driver=file,read-only=on,filename=RISCV_VIRT_CODE.fd \
>      -blockdev node-name=pflash1,driver=file,filename=RISCV_VIRT_VARS.fd \
>      -bios fw_dynamic.bin \
>      -drive file=$BRS_IMG,if=ide,format=raw
> 
> Since there is no ACPI table generated in this new machine type, a
> corresponding EDK-II platform (WIP) is needed to provide related ACPI
> tables.

The need for having a platform separate to virt for compliance testing 
was discussed in RISE in RVI meetings. Thanks for driving this.

Will the EDK II platform also generate the SMBIOS table or shall this be 
handled in QEMU?

Will further work in edk2-platforms be needed to provide full compliance 
with the the server platform specification?

Best regards

Heinrich

> 
> For testing purposes only, we used a workaround to generate the ACPI
> tables in Qemu with a dedicated downstream patch.
> 
> [1] https://github.com/riscv-non-isa/riscv-server-platform
> [2] https://github.com/tianocore/edk2.git
> 
> Fei Wu (2):
>    hw/riscv: Add server platform reference machine
>    target/riscv: Add server platform reference cpu
> 
>   configs/devices/riscv64-softmmu/default.mak |    1 +
>   hw/riscv/Kconfig                            |   13 +
>   hw/riscv/meson.build                        |    1 +
>   hw/riscv/server_platform_ref.c              | 1248 +++++++++++++++++++
>   target/riscv/cpu-qom.h                      |    1 +
>   target/riscv/cpu.c                          |   62 +
>   6 files changed, 1326 insertions(+)
>   create mode 100644 hw/riscv/server_platform_ref.c
> 


