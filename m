Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA881C83F27
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 04:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uf9fF-0006g0-9k; Fri, 25 Jul 2025 00:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liujingqi@lanxincomputing.com>)
 id 1uf9eo-0006at-Dj
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 00:03:42 -0400
Received: from sg-1-19.ptr.blmpb.com ([118.26.132.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liujingqi@lanxincomputing.com>)
 id 1uf9el-0007wv-UR
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 00:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1753416208;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=Jcs4v6qK8o7HqKb2WWsc6we9zXzeK8o0vFNRRrd95RU=;
 b=0FzgjOoTeQIieMscPTulHXWtPcLpawHvqY2Xg1pgE7VYAh4tXEHqAxhAQGbduBHYCdgKKz
 V/TDSnWE6k3coj558+9uLRRw5D6KdX0JJsi8r++yEBNmlJ8iG5m9686r5bAKGS/yJQ6+ek
 +0XGVIvpUqMC5qzoKJl0YE2esfALgtwOP6xufx2AfqTqCOBV68MbDaISdM5ofaTg4kUAtG
 U4m9EKEUDxkoIXEbV2o31AJBLIaa4SeVY3i8MxG55rYa5e1nbOSPFYAR0yACHhfn9vzDPt
 aI/JSy8Aqdju1wjn1GuCFPNnlj4ptxQ1v3QTqhoTlJrBZa1SMiebJB0XRZVfVg==
Subject: Re: [PATCH v2 3/3] tests/data/acpi/riscv64: Update expected FADT and
 MADT
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26883020e+e22382+nongnu.org+liujingqi@lanxincomputing.com>
To: "Sunil V L" <sunilvl@ventanamicro.com>, <qemu-riscv@nongnu.org>, 
 <qemu-devel@nongnu.org>
Mime-Version: 1.0
X-Original-From: Nutty Liu <liujingqi@lanxincomputing.com>
Cc: "Palmer Dabbelt" <palmer@dabbelt.com>, 
 "Alistair Francis" <alistair.francis@wdc.com>, 
 "Weiwei Li" <liwei1518@gmail.com>, 
 "Daniel Henrique Barboza" <dbarboza@ventanamicro.com>, 
 "Liu Zhiwei" <zhiwei_liu@linux.alibaba.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, 
 "Igor Mammedov" <imammedo@redhat.com>, "Ani Sinha" <anisinha@redhat.com>, 
 "Andrew Jones" <ajones@ventanamicro.com>, 
 "Anup Patel" <anup@brainfault.org>, 
 "Atish Kumar Patra" <atishp@rivosinc.com>
Message-Id: <0d863e5c-ceb2-4e86-8c1a-be13ad36acc1@lanxincomputing.com>
Content-Language: en-US
Received: from [127.0.0.1] ([116.237.111.137]) by smtp.feishu.cn with ESMTPS;
 Fri, 25 Jul 2025 12:03:25 +0800
Content-Transfer-Encoding: 7bit
References: <20250724110350.452828-1-sunilvl@ventanamicro.com>
 <20250724110350.452828-4-sunilvl@ventanamicro.com>
Date: Fri, 25 Jul 2025 12:03:23 +0800
User-Agent: Mozilla Thunderbird
In-Reply-To: <20250724110350.452828-4-sunilvl@ventanamicro.com>
From: "Nutty Liu" <liujingqi@lanxincomputing.com>
Received-SPF: pass client-ip=118.26.132.19;
 envelope-from=liujingqi@lanxincomputing.com; helo=sg-1-19.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/24/2025 7:03 PM, Sunil V L wrote:
> Update the expected tables for the version change.
>   /*
>    *
>    * ACPI Data Table [FACP]
>    *
>    * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
>    */
>
>   [000h 0000 004h]                   Signature : "FACP"    [Fixed ACPI Description Table (FADT)]
>   [004h 0004 004h]                Table Length : 00000114
>   [008h 0008 001h]                    Revision : 06
> -[009h 0009 001h]                    Checksum : 13
> +[009h 0009 001h]                    Checksum : 12
>   [00Ah 0010 006h]                      Oem ID : "BOCHS "
>   [010h 0016 008h]                Oem Table ID : "BXPC    "
>   [018h 0024 004h]                Oem Revision : 00000001
>   [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
>   [020h 0032 004h]       Asl Compiler Revision : 00000001
>
>   [024h 0036 004h]                FACS Address : 00000000
>   [028h 0040 004h]                DSDT Address : 00000000
>   [02Ch 0044 001h]                       Model : 00
>   [02Dh 0045 001h]                  PM Profile : 00 [Unspecified]
>   [02Eh 0046 002h]               SCI Interrupt : 0000
>   [030h 0048 004h]            SMI Command Port : 00000000
>   [034h 0052 001h]           ACPI Enable Value : 00
>   [035h 0053 001h]          ACPI Disable Value : 00
>   [036h 0054 001h]              S4BIOS Command : 00
>   [037h 0055 001h]             P-State Control : 00
> @@ -86,33 +86,33 @@
>        Use APIC Physical Destination Mode (V4) : 0
>                          Hardware Reduced (V5) : 1
>                         Low Power S0 Idle (V5) : 0
>
>   [074h 0116 00Ch]              Reset Register : [Generic Address Structure]
>   [074h 0116 001h]                    Space ID : 00 [SystemMemory]
>   [075h 0117 001h]                   Bit Width : 00
>   [076h 0118 001h]                  Bit Offset : 00
>   [077h 0119 001h]        Encoded Access Width : 00 [Undefined/Legacy]
>   [078h 0120 008h]                     Address : 0000000000000000
>
>   [080h 0128 001h]        Value to cause reset : 00
>   [081h 0129 002h]   ARM Flags (decoded below) : 0000
>                                 PSCI Compliant : 0
>                          Must use HVC for PSCI : 0
>
> -[083h 0131 001h]         FADT Minor Revision : 05
> +[083h 0131 001h]         FADT Minor Revision : 06
>   [084h 0132 008h]                FACS Address : 0000000000000000
> [...]
>
>   /*
>    *
>    * ACPI Data Table [APIC]
>    *
>    * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
>    */
>
>   [000h 0000 004h]                   Signature : "APIC"    [Multiple APIC Description Table (MADT)]
>   [004h 0004 004h]                Table Length : 00000074
> -[008h 0008 001h]                    Revision : 06
> -[009h 0009 001h]                    Checksum : B4
> +[008h 0008 001h]                    Revision : 07
> +[009h 0009 001h]                    Checksum : B3
>   [00Ah 0010 006h]                      Oem ID : "BOCHS "
>   [010h 0016 008h]                Oem Table ID : "BXPC    "
> [...]
>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
Reviewed-by: Nutty Liu <liujingqi@lanxincomputing.com>

Thanks,
Nutty
>   tests/data/acpi/riscv64/virt/APIC           | Bin 116 -> 116 bytes
>   tests/data/acpi/riscv64/virt/FACP           | Bin 276 -> 276 bytes
>   tests/qtest/bios-tables-test-allowed-diff.h |   2 --
>   3 files changed, 2 deletions(-)
>
> diff --git a/tests/data/acpi/riscv64/virt/APIC b/tests/data/acpi/riscv64/virt/APIC
> index 66a25dfd2d6ea2b607c024722b2eab95873a01e9..3fb5b753596fc7c2618b3d5210be8b00b0c177f6 100644
> GIT binary patch
> delta 16
> XcmXRZ;c^V{bS`0FU|`=okt+)TB&q~M
>
> delta 16
> XcmXRZ;c^V{bS`0FU|`!akt+)TB&h^L
>
> diff --git a/tests/data/acpi/riscv64/virt/FACP b/tests/data/acpi/riscv64/virt/FACP
> index a5276b65ea8ce46cc9b40d96d98f0669c9089ed4..78e1b14b1d4ff0533a6a4c041f195a69b4ef114d 100644
> GIT binary patch
> delta 30
> mcmbQjG=+)F&CxkPgpq-PO=u!lB_rF!iPaMgcqj8PasU8k76z;U
>
> delta 30
> mcmbQjG=+)F&CxkPgpq-PO?V<#B_r#^iPaMgcqj8PasU8k8wRWZ
>
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index 0c3f7a6cac..dfb8523c8b 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,3 +1 @@
>   /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/riscv64/virt/APIC",
> -"tests/data/acpi/riscv64/virt/FACP",

