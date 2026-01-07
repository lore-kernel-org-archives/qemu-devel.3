Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E32BCFD626
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 13:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdTTK-00039u-8H; Wed, 07 Jan 2026 08:21:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vdTTJ-00039S-2L
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:21:09 -0500
Received: from mail-dy1-x132d.google.com ([2607:f8b0:4864:20::132d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vdTTH-0004Qp-Ai
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:21:08 -0500
Received: by mail-dy1-x132d.google.com with SMTP id
 5a478bee46e88-2b04fcfc0daso1534347eec.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 05:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1767792065; x=1768396865; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4zjXYBDH4fZc8OGNSJ+bGs1K+cyneUM9beDgznDe/w8=;
 b=fucbaES/ImW8gbxqGjfI9tCHjMxbryS2SbZdp2GT7qbh4XjPO9unoyH1S0ooiC1B0Z
 LKS9skNqRa5yfVQTulFEZs/EDwtGrk8ILbaXd2fWidw6ab6FnWBDqVK3eTnOlMSD4ZHs
 7COxbU63ieXC6xFVXFbaJHqfu4TdG6qt3xze6U+Q8KXvPwZRh2xrxlsu+HzZx2VDZCfm
 /7qq7zrCI95vS1gB1QF7QGO3fnsqz2Wnc7/fMIhpBBUU4fAkaCSv0COMEMNzABazhpZW
 Ub72BDWZbjAQ95YFor99Ft2IQ4FVaTCj4HI2E9I4yQaePfh26/oKx0JbcsWr55MKM0SD
 gGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767792065; x=1768396865;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4zjXYBDH4fZc8OGNSJ+bGs1K+cyneUM9beDgznDe/w8=;
 b=lqzZfz5aVFuKaLcO5nkRaIzXZpm34+n+CNiv+oKPxo5YKXiYd/0560mmox6yLUqzN5
 62lbsWqqHTAQWDth6GP8TV+jJJkGp4AtrndbCjqz8DfOigkdhkmA6YYX7elLdexWSZHn
 mUbLXM33/uDpIB6XgtRn1kkbisHv1H9oLFmMSZBu8LfmzF737wLSLnl77hT6FOHlk2TQ
 neiBlnUIj2k/3cIsqGZZeWvudEkPXrVYR7N6p25ONxWKn61Bn3ShSf7vAde6osMnSCfO
 Hco1VY6dpoQ3v/+WQh1Tj2dhtP977SdA3XN0ddQsA1eOmdp3hwHJ+uNCIrSPL1kUNVC3
 TQxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoLHsiw19eD5ffMa+AH0h/CIvkx6zncwJnEvrHIXN8AMr/9gsS3Zn1fEvmH7JNgc4pFoDAG0om+vsv@nongnu.org
X-Gm-Message-State: AOJu0YyEbWpfcAxB/iGzwz3A3kELRXbd4eWA5UQ2svSfEv0X/tsjh3hx
 fT17HgjdUIXOrx8QUmNgjO51blAyhIGi01Nk1BzyP+2O0vELFLYm/SLUUMG6NRRfHss=
X-Gm-Gg: AY/fxX7LdOwpE6g19HutqaK38QAg4jS9U/VtUURfQPI53c1BWnplxNMP0jveLxCkdVo
 sAWA+YCsf7joMwHxkF/3p4jpFfaLSJqR57sHnwz78Fhd7dwcU3Nl2gVRtpaK0Pi+hu95gA1d5O5
 6e2HPyd8ddJ69KqYYpZ+566CgWQurlsJMi16niNzudNjo06Zmx5/CjUg/W17R9kgMK0W/0qS3HU
 ThCmR2F0JqGL6DoAjETmPlWvaICLN31kR5DREBsIKzZdWsFBKAxyrFuxd7xTsMGpgPUSXi9nmx5
 0zTm8JOlCjydONai/nkrmlQyZQOIuYANi389itM4x2iXqJNpFDpLU5dsOlsyLjwXx7sgSmcg/al
 S/TTPzkDlnyDGWfcggJ8XxJVCbGClv8uOWx0CKAkWuI+fXErUlvlYtC6HsxFzrc0vfyQ5DpUonC
 2o5E+8OiTOj4sWXDNpbRqNUNfi2BtZlWal2c1wjTKrXVb340ZgWr9rs0HBsD7D8Q2/xDTmGdsc
X-Google-Smtp-Source: AGHT+IEPRllOVi5b2y5roVGyNg6WCdEvEkNx/tzIq7HmNrFVsUfSSmhJagZskCvR4pWw/9PS3uzNZw==
X-Received: by 2002:a05:7300:d709:b0:2b0:4fe2:6a2e with SMTP id
 5a478bee46e88-2b17d238bbfmr1930812eec.9.1767792065126; 
 Wed, 07 Jan 2026 05:21:05 -0800 (PST)
Received: from [192.168.68.110] (200-162-225-127.static-corp.ajato.com.br.
 [200.162.225.127]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b175bee31dsm4771188eec.32.2026.01.07.05.20.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 05:21:04 -0800 (PST)
Message-ID: <af7be4a9-b1d4-4759-833a-390e1032c1f3@ventanamicro.com>
Date: Wed, 7 Jan 2026 10:20:57 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/16] hw/riscv: Add the Tenstorrent Atlantis machine
To: Joel Stanley <joel@jms.id.au>, Alistair Francis
 <alistair.francis@wdc.com>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Chris Rauer <crauer@google.com>,
 Vijai Kumar K <vijai@behindbytes.com>, Sunil V L <sunilvl@ventanamicro.com>,
 Ran Wang <wangran@bosc.ac.cn>, Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
References: <20260106055658.209029-1-joel@jms.id.au>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20260106055658.209029-1-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-dy1-x132d.google.com
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



On 1/6/26 2:56 AM, Joel Stanley wrote:
> Introducing Tenstorrent Atlantis!
> 
>   The Tenstorrent Atlantis platform is a collaboration between Tenstorrent
>   and CoreLab Technology. It is based on the Atlantis SoC, which includes
>   the Ascalon-X CPU and other IP from Tenstorrent and CoreLab Technology.
> 
>   The Tenstorrent Ascalon-X is a high performance 64-bit RVA23 compliant
>   RISC-V CPU.
> 
> This initial series adds the base machine support including:
> 
>   - AIA (Advanced Interrupt Architecture) support
>   - PCIe controller and DesignWare I2C integration
>   - Serial console and device tree generation
>   - Functional tests for OpenSBI+Linux boot
> 
> Changes outside of adding the machine:
> 
>   - Atlantis maps DRAM high in the address space but maintains an alias
>     for the first 2GB at 0x0. We have updated the RISC-V boot loader code
>     to support boot_info for discontiguous memory layouts.
> 
>   - The riscv64 virt machine AIA initialisation has been moved to a
>     helper file to allow code reuse with the Atlantis machine
> 
>   - Revived the DesignWare I2C controller model (previously proposed for
>     ARM virt) with permission from the original author.
> 
> I hope to get early feedback on the base machine now. We intend to
> continue modelling the soc so it can be useful for firmware and
> operating system development and testing, so expect more patches to do
> that soon.

Good choice on the machine name. Looking forward for what's coming next
(Poseidon, Varuna, Anuket, Leviathan ...)

As for the patches I see stuff that could be sent separately in a prep series,
mostly the 4 patches on hw/boot and the 2 hw/aia patches. You can refer to this
prep series as a prerequisite for the main series that would include just the
machine specific stuff.

This prep series would be easier to review and would probably be merged first,
alleviating the review effort in the Atlantis series.

Also, the designware i2c controller patch seems fully reviewed. I advise sending
it standalone to be merged right away. I believe Alistair wouldn't mind pushing
it via qemu-riscv.


Thanks,

Daniel

> 
> Chris Rauer (1):
>    hw/i2c: Add designware i2c controller
> 
> Joel Stanley (6):
>    target/riscv: tt-ascalon: Add Tenstorrent mvendorid
>    hw/riscv: Move AIA initialisation to helper file
>    hw/riscv/aia: Provide number of irq sources
>    hw/riscv: Add Tenstorrent Atlantis machine
>    hw/riscv/atlantis: Integrate i2c buses
>    hw/riscv/atlantis: Add some i2c peripherals
> 
> Nicholas Piggin (9):
>    target/riscv: tt-ascalon: Enable Zkr extension
>    target/riscv: tt-ascalon: Add Svadu extension
>    riscv/boot: Describe discontiguous memory in boot_info
>    riscv/boot: Account for discontiguous memory when loading firmware
>    hw/riscv/atlantis: Add PCIe controller
>    tests/functional/riscv64: Add tt-atlantis tests
>    hw/riscv/boot: Warn if a ELF format file is loaded as a binary
>    hw/riscv/boot: Provide a simple halting payload
>    hw/riscv/atlantis: Use halting kernel if there is no payload
> 
>   MAINTAINERS                                  |  15 +
>   docs/system/riscv/tt_atlantis.rst            |  38 +
>   docs/system/target-riscv.rst                 |   1 +
>   hw/riscv/aia.h                               |  59 ++
>   include/hw/i2c/designware_i2c.h              | 101 ++
>   include/hw/riscv/boot.h                      |  14 +-
>   include/hw/riscv/tt_atlantis.h               |  95 ++
>   include/hw/riscv/virt.h                      |  30 +-
>   target/riscv/cpu_vendorid.h                  |   2 +
>   hw/i2c/designware_i2c.c                      | 813 ++++++++++++++++
>   hw/riscv/aia.c                               |  89 ++
>   hw/riscv/boot.c                              |  73 +-
>   hw/riscv/microchip_pfsoc.c                   |   6 +-
>   hw/riscv/opentitan.c                         |   6 +-
>   hw/riscv/shakti_c.c                          |   6 +-
>   hw/riscv/sifive_u.c                          |   3 +-
>   hw/riscv/spike.c                             |   6 +-
>   hw/riscv/tt_atlantis.c                       | 917 +++++++++++++++++++
>   hw/riscv/virt-acpi-build.c                   |  24 +-
>   hw/riscv/virt.c                              |  94 +-
>   hw/riscv/xiangshan_kmh.c                     |   6 +-
>   target/riscv/cpu.c                           |   4 +-
>   hw/i2c/Kconfig                               |   4 +
>   hw/i2c/meson.build                           |   1 +
>   hw/riscv/Kconfig                             |  21 +
>   hw/riscv/meson.build                         |   3 +-
>   tests/functional/riscv64/meson.build         |   1 +
>   tests/functional/riscv64/test_opensbi.py     |   4 +
>   tests/functional/riscv64/test_tt_atlantis.py |  68 ++
>   29 files changed, 2365 insertions(+), 139 deletions(-)
>   create mode 100644 docs/system/riscv/tt_atlantis.rst
>   create mode 100644 hw/riscv/aia.h
>   create mode 100644 include/hw/i2c/designware_i2c.h
>   create mode 100644 include/hw/riscv/tt_atlantis.h
>   create mode 100644 hw/i2c/designware_i2c.c
>   create mode 100644 hw/riscv/aia.c
>   create mode 100644 hw/riscv/tt_atlantis.c
>   create mode 100755 tests/functional/riscv64/test_tt_atlantis.py
> 


