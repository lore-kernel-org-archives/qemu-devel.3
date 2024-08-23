Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD05C52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 13:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shUDH-0005ig-3R; Fri, 23 Aug 2024 09:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1shUCw-0004Y7-BS
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 09:20:05 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1shUCq-000193-Ve
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 09:20:00 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-429d2d7be1eso10202555e9.1
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 06:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1724419191; x=1725023991; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=c3Iy+EmEFhSfRcw35yG/DpcncueMVCKcsXZFQjjA4OU=;
 b=Z1idFMXi52JkfwfmHZ2aWWwHWPppBboCDkpaeJMb1dT4sow+/R+4idoaQk8metE/ew
 RyISKPd+1a43tt1Qrj2acCz8x2bxm6jv1T6Jx7ix1r9GzjK57kBi0uYuJw2mIw4+rMXS
 PcCfglAouRDbJMmPNM5obKKyghFd1YublKAgGDOu5NbTLTXa8bqDl1d3DOdX9sFuC1kq
 iWpRSoSILpVWxWp8LOEyNAe1aOy3D+t6c6vtUKICtamATxyVdF9jqh1CgH+dscjpK3AB
 MbhvhvYNQI4cImbjSOI12WUTjgopDptkm9Wc4chlmWVXYvFugrr0hxYjbqbnA790aawG
 s97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724419191; x=1725023991;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c3Iy+EmEFhSfRcw35yG/DpcncueMVCKcsXZFQjjA4OU=;
 b=bAc6/0aPsHJUwEseP1zfXjaDDNz4P/pWSnuhfNdsX9NzWK1lIwvOcW0x7Z621O0o+V
 rpeLYTPYHdsKVVU3IbNmjC8H+HdBN2HFxh0WQwrx85LrEm2uGvjHqzkF+KT23pexWKKW
 rmQo7jScM3Y2AEpgiqxIIG7GHBehwG+8SsStA4u3H64QZ3c5Csp+Bd5yzp/b1/jFc4ip
 1PfDa0N70MFwNOBSA6kAY/osWHsImJJ1qcZq0y6Z5bwYgK/si3/YHN6pTFLV+vc7aljg
 zeFeyzOe6riS/l1Ev28u2z0+kxN8sTfueK1v1g/hqTp20RTqivMS1WXAq+z5F5g8N785
 7FrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlvW0cFdic9DyJq7+Yi0g92mRpFV01NzWJdX8ILR57spWfSf8jHKvKwLu2tqR95Skn6ZOKFcbWEXWp@nongnu.org
X-Gm-Message-State: AOJu0Yy3xsKUJ0hA5Mee2F1HA8wvQ/fmzkibP7nSZ20C5e8WyOxs5SeI
 jV5BqTEyJFb4IDVbRihWU0/MQTop9FqWALX0jM+RJ+4PUN8Yic4pdeQiZbv605lQSmpPfceLR0+
 Zqgo=
X-Google-Smtp-Source: AGHT+IFAXohcgwGwhM1MODuxLvLf18VebjSVYufdGt++90DbHCQ+e0XPEW+suSUUVopv8lEmJtfWWA==
X-Received: by 2002:a05:600c:a04:b0:426:526f:4a1f with SMTP id
 5b1f17b1804b1-42acca01a23mr13272315e9.16.1724419191013; 
 Fri, 23 Aug 2024 06:19:51 -0700 (PDT)
Received: from sunil-laptop ([106.51.198.16]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-373081ff654sm4137939f8f.75.2024.08.23.06.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 06:19:50 -0700 (PDT)
Date: Fri, 23 Aug 2024 18:49:38 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com,
 palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH RESEND v4 3/3] tests/qtest/bios-tables-test: Update virt
 SPCR golden reference for RISC-V
Message-ID: <ZsiMah7pBYLOqHXA@sunil-laptop>
References: <20240823113142.161727-1-jeeheng.sia@starfivetech.com>
 <20240823113142.161727-4-jeeheng.sia@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823113142.161727-4-jeeheng.sia@starfivetech.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, Aug 23, 2024 at 04:31:42AM -0700, Sia Jee Heng wrote:
> Update the virt SPCR golden reference file for RISC-V to accommodate the
> SPCR Table revision 4 [1], utilizing the iasl binary compiled from the
> latest ACPICA repository. The SPCR table has been modified to
> adhere to the revision 4 format [2].
> 
> [1]: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/serial-port-console-redirection-table
> [2]: https://github.com/acpica/acpica/pull/931
> 
> Diffs from iasl:
> /*
>   * Intel ACPI Component Architecture
>   * AML/ASL+ Disassembler version 20200925 (64-bit version)
>   * Copyright (c) 2000 - 2020 Intel Corporation
>   *
> - * Disassembly of tests/data/acpi/riscv64/virt/SPCR, Fri Aug 23 02:07:47 2024
> + * Disassembly of /tmp/aml-Y8JPS2, Fri Aug 23 02:07:47 2024
>   *
>   * ACPI Data Table [SPCR]
>   *
>   * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
>   */
> 
>  [000h 0000   4]                    Signature : "SPCR"    [Serial Port Console Redirection table]
> -[004h 0004   4]                 Table Length : 00000050
> -[008h 0008   1]                     Revision : 02
> -[009h 0009   1]                     Checksum : B9
> +[004h 0004   4]                 Table Length : 0000005A
> +[008h 0008   1]                     Revision : 04
> +[009h 0009   1]                     Checksum : 13
>  [00Ah 0010   6]                       Oem ID : "BOCHS "
>  [010h 0016   8]                 Oem Table ID : "BXPC    "
>  [018h 0024   4]                 Oem Revision : 00000001
>  [01Ch 0028   4]              Asl Compiler ID : "BXPC"
>  [020h 0032   4]        Asl Compiler Revision : 00000001
> 
> -[024h 0036   1]               Interface Type : 00
> +[024h 0036   1]               Interface Type : 12
>  [025h 0037   3]                     Reserved : 000000
> 
>  [028h 0040  12]         Serial Port Register : [Generic Address Structure]
>  [028h 0040   1]                     Space ID : 00 [SystemMemory]
>  [029h 0041   1]                    Bit Width : 20
>  [02Ah 0042   1]                   Bit Offset : 00
>  [02Bh 0043   1]         Encoded Access Width : 01 [Byte Access:8]
>  [02Ch 0044   8]                      Address : 0000000010000000
> 
>  [034h 0052   1]               Interrupt Type : 10
>  [035h 0053   1]          PCAT-compatible IRQ : 00
>  [036h 0054   4]                    Interrupt : 0000000A
>  [03Ah 0058   1]                    Baud Rate : 07
>  [03Bh 0059   1]                       Parity : 00
>  [03Ch 0060   1]                    Stop Bits : 01
>  [03Dh 0061   1]                 Flow Control : 00
>  [03Eh 0062   1]                Terminal Type : 00
>  [04Ch 0076   1]                     Reserved : 00
>  [040h 0064   2]                PCI Device ID : FFFF
>  [042h 0066   2]                PCI Vendor ID : FFFF
>  [044h 0068   1]                      PCI Bus : 00
>  [045h 0069   1]                   PCI Device : 00
>  [046h 0070   1]                 PCI Function : 00
>  [047h 0071   4]                    PCI Flags : 00000000
>  [04Bh 0075   1]                  PCI Segment : 00
>  [04Ch 0076   4]                     Reserved : 00000000
> 
Shouldn't iasl print additional fields added in version 4?

Thanks,
Sunil
> -Raw Table Data: Length 80 (0x50)
> +Raw Table Data: Length 90 (0x5A)
> 
> -    0000: 53 50 43 52 50 00 00 00 02 B9 42 4F 43 48 53 20  // SPCRP.....BOCHS
> +    0000: 53 50 43 52 5A 00 00 00 04 13 42 4F 43 48 53 20  // SPCRZ.....BOCHS
>      0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
> -    0020: 01 00 00 00 00 00 00 00 00 20 00 01 00 00 00 10  // ......... ......
> +    0020: 01 00 00 00 12 00 00 00 00 20 00 01 00 00 00 10  // ......... ......
>      0030: 00 00 00 00 10 00 0A 00 00 00 07 00 01 00 00 03  // ................
>      0040: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
> +    0050: 00 00 00 00 02 00 58 00 2E 00                    // ......X...
> 
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> ---
>  tests/data/acpi/riscv64/virt/SPCR           | Bin 80 -> 90 bytes
>  tests/qtest/bios-tables-test-allowed-diff.h |   1 -
>  2 files changed, 1 deletion(-)
> 
> diff --git a/tests/data/acpi/riscv64/virt/SPCR b/tests/data/acpi/riscv64/virt/SPCR
> index 4da9daf65f71a13ac2b488d4e9728f194b569a43..09617f8793a6f7b1f08172f735b58aa748671540 100644
> GIT binary patch
> delta 32
> mcmWHD;tCFM4vJ!6U|<oR$R))nG*MNX3&>+&Vu)bSV*mhNumqU^
> 
> delta 21
> ccmazF;0g|K4hmpkU|`xgkxPn^VWO%w05v59j{pDw
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index aae973048a..dfb8523c8b 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,2 +1 @@
>  /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/riscv64/virt/SPCR",
> -- 
> 2.34.1
> 

