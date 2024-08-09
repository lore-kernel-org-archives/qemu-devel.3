Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1631CC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 06:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scIwA-0007LN-CX; Fri, 09 Aug 2024 02:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1scIvm-00071e-48
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 02:16:57 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1scIvk-0003ll-5q
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 02:16:53 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-6e7e23b42c3so1318073a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 23:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1723184211; x=1723789011; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4TqpIFadNi5v5sQhWgTeHLQy9O7ODf95h21P3+FaHFY=;
 b=Lyu2LaTr/4b78LIttOTuz3HdVMItziNt4DDsVtrr5hdwTv9hD8WbHJ2lDPotWXqxDw
 dlfge5G86Z4CcQB7ZjQ7aFJk6SgXcCcRgPl2gHCPgs+AULKT/ziGsbV55yMZUBwmHBv+
 tBB3NK+MePtQc69balrZHQkj+rBphSrVdka8TGZNKitGmalWoz9QyYb0O7aq9FhF0PhY
 gBmn+yI8DHiG83Ku0Ap/qQk42BLLDK7LTVv8K66fBFTFyJ7dA0n3jEYdviXzx2kFs39X
 Fjv9c1VqvHQVbl9sc4Y/wsHv+ViAmRPCO8aqTJXA60MfDGbNqDfnM+GALFGoU2hhqFw/
 ICcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723184211; x=1723789011;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4TqpIFadNi5v5sQhWgTeHLQy9O7ODf95h21P3+FaHFY=;
 b=DeEp0v8yHUn7qrBq+SwS976gt1oxkJdOQ1J/BUXXQ9VDDuveabKv/92dLh3XnYC1Ym
 2aeHBQZNJ0cbfRFSpY7OfGQOSNO4oNqml+2s2PS/Ka7BCaf8V2TSucRuiOMxemMEBzO5
 lp+o9W4gBw7PIxM6745NJ7k/llIVFAiWaHVx2GQ/dC46jL0VP1AZh1I115C5yykrgJK3
 y0OlYHwU8p88t9g7bCvTW76YDlfZy7/kN88mX45qaWCRGEhsXZxx+WaNY9ZT67PgIyNe
 HJpDSDZzDeXobjR4cgNNl4rIN90x/V4YCfq+OBEjfiZ72aDJ0P3NR9/a9Tfba5tsS1fD
 j09w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlRotqBfwXd97bjGXW5zKjvc1QoDOXzuAdbTVGNAL1CjtlJB2bvD/Et0ogTMa4jMdm0I05lAEaZzJXNmmDnj263g4qkUM=
X-Gm-Message-State: AOJu0YxV8HmzB5i04pG85kE1vxLwGTyNJgtKSvZ4hI5/WocY9n19ivVK
 MEIi3fKP39xrbVcgsAwKv0qOVEh03Hf1BnQY72sRPT6oG2rYR2dY47FSCGPILhtbBCxVPPxmxKh
 +ExDFDA==
X-Google-Smtp-Source: AGHT+IEwIYJx6Yzme3jW7M4CvgNyuIbeBwBnU6TfxyPGaBG8VPJUrCEIL19vu5b9n0m+UywfPFw4Ag==
X-Received: by 2002:a05:6a20:9c90:b0:1c6:fb66:cfe with SMTP id
 adf61e73a8af0-1c89ff26fcbmr861866637.21.1723184210694; 
 Thu, 08 Aug 2024 23:16:50 -0700 (PDT)
Received: from sunil-laptop ([106.51.198.16]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff5905eeb2sm134456625ad.154.2024.08.08.23.16.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 23:16:50 -0700 (PDT)
Date: Fri, 9 Aug 2024 11:46:44 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Haibo Xu <haibo1.xu@intel.com>
Cc: alistair.francis@wdc.com, xiaobo55x@gmail.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/3] tests/qtest/bios-tables-test.c: Enable numamem
 testing for RISC-V
Message-ID: <ZrW0THilK3yLzoeJ@sunil-laptop>
References: <0e30216273f2f59916bc651350578d8e8bc3a75f.1723172696.git.haibo1.xu@intel.com>
 <a6f7e1a4b20ff7eb199e94ca0c8aa2e6794ce5b2.1723172696.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6f7e1a4b20ff7eb199e94ca0c8aa2e6794ce5b2.1723172696.git.haibo1.xu@intel.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pg1-x531.google.com
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

On Fri, Aug 09, 2024 at 11:09:48AM +0800, Haibo Xu wrote:
> Add ACPI SRAT table test case for RISC-V when NUMA was enabled.
> 
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  tests/qtest/bios-tables-test.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 36e5c0adde..e79f3a03df 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -1706,6 +1706,32 @@ static void test_acpi_microvm_ioapic2_tcg(void)
>      free_test_data(&data);
>  }
>  
> +static void test_acpi_riscv64_virt_tcg_numamem(void)
> +{
> +    test_data data = {
> +        .machine = "virt",
> +        .arch = "riscv64",
> +        .tcg_only = true,
> +        .uefi_fl1 = "pc-bios/edk2-riscv-code.fd",
> +        .uefi_fl2 = "pc-bios/edk2-riscv-vars.fd",
> +        .cd = "tests/data/uefi-boot-images/bios-tables-test.riscv64.iso.qcow2",
> +        .ram_start = 0x80000000ULL,
> +        .scan_len = 128ULL * 1024 * 1024,
> +    };
> +
> +    data.variant = ".numamem";
> +    /*
> +     * RHCT will have ISA string encoded. To reduce the effort
> +     * of updating expected AML file for any new default ISA extension,
> +     * use the profile rva22s64.
> +     */
> +    test_acpi_one(" -cpu rva22s64"
> +                  " -object memory-backend-ram,id=ram0,size=128M"
> +                  " -numa node,memdev=ram0",
> +                  &data);
> +    free_test_data(&data);
> +}
> +
>  static void test_acpi_aarch64_virt_tcg_numamem(void)
>  {
>      test_data data = {
> @@ -2466,6 +2492,8 @@ int main(int argc, char *argv[])
>      } else if (strcmp(arch, "riscv64") == 0) {
>          if (has_tcg && qtest_has_device("virtio-blk-pci")) {
>              qtest_add_func("acpi/virt", test_acpi_riscv64_virt_tcg);
> +            qtest_add_func("acpi/virt/numamem",
> +                           test_acpi_riscv64_virt_tcg_numamem);

Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>

Thanks,
Sunil

