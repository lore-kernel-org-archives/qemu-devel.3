Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBEFFC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeLs-0000if-ST; Tue, 02 Jul 2024 10:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOeLd-0000Wb-0u
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:19:12 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOeLZ-0007Hq-41
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:19:07 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-424ad991cbbso33078225e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719929942; x=1720534742; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XsgGTvTlNoxE2PA6imqpfUttw4MzXq9eE6nVA8ZM0LI=;
 b=e0YjmpYC6cfPMwVGxqnCdK5gcOZyp/a/Vs2KrmdXlqA5J9/Eaa/bc+Ezdv5wTiBAlU
 40PuiZ/8HCaojifmFddZirmlachoV0JmA9UaBgmw7DRslnUn7t5siTMd9zZ3bLmQiWbQ
 37bOXza2J1ZYZ46zZSmHyc/boMbhXOhkBqCjz0is92C8eP36ni6moZ/hQ6tVUPpsghNV
 I+mHVc1nlv8oy/a4377kCxBwKznV34JdVQ2mEPFRVUh/g8Q2YDVLIY9OJQJunPxTFD7G
 TjfgUeTOt212ybC4esdR3sU/iBRQ4oQqJsIdFBZ6fvG4P6uunKWXb+pfYd/v+i7B/xGZ
 MMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929942; x=1720534742;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XsgGTvTlNoxE2PA6imqpfUttw4MzXq9eE6nVA8ZM0LI=;
 b=u0OJWdY/FnQ6HDJP5lrqlf/bDloWspj6m3HfTNGyxayTvxId373+jQe9q83YmeJaiG
 /eOs5iH6dpd7CEea8XM4Aa0IeHDJVLqUYSCcekpDTgaQ0SfrwjYCBrssA5QFj9PHHNIH
 5ti35SjkjeuXZKAeb8RpVSWlIM2YjxzEHlsXahXmfOuIWHJEtLoMlIUhFOwXZRh7Sqw8
 9ojcp+PDD01MLSWvNr9GHswtucS1U167cadXAyH0nQ5sWil1pG1ov0wAs+ezFvhJHbAN
 TH6usLv6dolPKicEusA9N7qBtppPWYDmqRaXWlZw5BWHR4FSbrgk5xhbN7kDBehdYN7Y
 pDCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUydojx1R98SBYvyhT38sQnchW3kEchbePkZhxrb++KxYDaFuGsEHfKedRfSFucPUvQmHNt+VMbB7whoLimHLpF45aklmk=
X-Gm-Message-State: AOJu0Yyl9ybcK3OhSP3YFtpZLIVEBs8uv/M6q1Tex9H8GZAFHdSAtwyR
 NUunDqrSINAi5iW8ftAA2RJcKynrljwMHxvQ7UNi4CZiLrMV5e1dSYUNcqUHP7Q=
X-Google-Smtp-Source: AGHT+IHB2KW4HfFI/kszd+A6pIMVdT+U6nAPiVRQ+9IWkRYmVuR5cqGXj2SRz9QG5th+nRHL8kDA1g==
X-Received: by 2002:a05:600c:4f12:b0:425:675a:d52e with SMTP id
 5b1f17b1804b1-4257a02147cmr59664885e9.2.1719929942351; 
 Tue, 02 Jul 2024 07:19:02 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b0c19eesm204892695e9.45.2024.07.02.07.19.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 07:19:01 -0700 (PDT)
Message-ID: <cad162ba-db4e-4acb-b45e-39053ebb02b0@linaro.org>
Date: Tue, 2 Jul 2024 16:18:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] target/riscv: Expose RV32 cpu to RV64 QEMU
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240701033722.954-1-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240701033722.954-1-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Zhiwei,

On 1/7/24 05:37, LIU Zhiwei wrote:
> From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
> 
> This patch set aims to expose 32-bit RISC-V cpu to RV64 QEMU. Thus
> qemu-system-riscv64 can directly boot a RV32 Linux.
> 
> This patch set has been tested with 6.9.0 Linux Image.
> 
> - Run RV64 QEMU with RV32 CPU
> qemu-system-riscv64 -cpu rv32 -M virt -nographic \
>      -kernel Image \
>      -append "root=/dev/vda ro console=ttyS0" \
>      -drive file=rootfs.ext2,format=raw,id=hd0 \
>      -device virtio-blk-device,drive=hd0 -netdev user,id=net0 \
>      -device virtio-net-device,netdev=net0
> 
> OpenSBI v1.4
> QEMU emulator version 9.0.50 (v9.0.0-1132-g7799dc2e3b)
> [    0.000000] Linux version 6.9.0 (developer@11109ca35736) (riscv32-unknown-linux-gnu-gcc (gc891d8dc23e-dirty) 13.2.0, GNU ld (GNU Binutils) 2.42) #3 SMP Fri May 31 08:42:15 UTC 2024
> [    0.000000] random: crng init done
> [    0.000000] OF: fdt: Ignoring memory range 0x80000000 - 0x80400000
> [    0.000000] Machine model: riscv-virtio,qemu
> [    0.000000] SBI specification v2.0 detected
> [    0.000000] SBI implementation ID=0x1 Version=0x10004
> [    0.000000] SBI TIME extension detected
> [    0.000000] SBI IPI extension detected
> [    0.000000] SBI RFENCE extension detected
> [    0.000000] SBI SRST extension detected
> [    0.000000] SBI DBCN extension detected
> [    0.000000] efi: UEFI not found.
> [    0.000000] OF: reserved mem: 0x80000000..0x8003ffff (256 KiB) nomap non-reusable mmode_resv1@80000000
> [    0.000000] OF: reserved mem: 0x80040000..0x8004ffff (64 KiB) nomap non-reusable mmode_resv0@80040000
> [    0.000000] Zone ranges:
> [    0.000000]   Normal   [mem 0x0000000080400000-0x0000000087ffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000080400000-0x0000000087ffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000080400000-0x0000000087ffffff]
> [    0.000000] On node 0, zone Normal: 1024 pages in unavailable ranges
> [    0.000000] SBI HSM extension detected
> [    0.000000] riscv: base ISA extensions acdfhim
> [    0.000000] riscv: ELF capabilities acdfim
> [    0.000000] percpu: Embedded 17 pages/cpu s37728 r8192 d23712 u69632
> [    0.000000] Kernel command line: root=/dev/vda ro console=ttyS0
> [    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes, linear)
> [    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes, linear)
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 31465
> [    0.000000] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]       fixmap : 0x9c800000 - 0x9d000000   (8192 kB)
> [    0.000000]       pci io : 0x9d000000 - 0x9e000000   (  16 MB)
> [    0.000000]      vmemmap : 0x9e000000 - 0xa0000000   (  32 MB)
> [    0.000000]      vmalloc : 0xa0000000 - 0xc0000000   ( 512 MB)
> [    0.000000]       lowmem : 0xc0000000 - 0xc7c00000   ( 124 MB)
> [    0.000000] Memory: 95700K/126976K available (9090K kernel code, 8845K rwdata, 4096K rodata, 4231K init, 341K bss, 31276K reserved, 0K cma-reserved)
> ...
> Welcome to Buildroot
> buildroot login: root
> # cat /proc/cpuinfo
> processor       : 0
> hart            : 0
> isa             : rv32imafdch_zicbom_zicboz_zicntr_zicsr_zifencei_zihintntl_zihintpause_zihpm_zfa_zba_zbb_zbc_zbs_sstc
> mmu             : sv32

Please provide an Avocado test (i.e. checking /proc/cpuinfo
contains "isa             : rv32"). See for reference
tests/avocado/boot_linux_console.py.

Thanks!

