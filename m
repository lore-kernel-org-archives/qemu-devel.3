Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05BAFC77B7F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 12:34:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV8Hk-0007bt-Dy; Fri, 27 Jun 2025 08:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uV8Hj-0007bf-HF
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 08:34:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uV8Hd-0002Ck-RL
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 08:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751027659;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D3Sv9Y8di8jPYm/s97VvLp8PmHdRBf8mYlRytEYZR4c=;
 b=MlJHDylP+SF9wn2uNQp/AaTMtFq/m7SoQsOxW/Wvh0w0METM2zCNIKEoDrQfrn0SKhgM1C
 sODx9rPoraJLrcC+Y79HbNYUgOekf7+e9kMUsaCxDHFNtObawZtXONCleFt3h0mMM08cbs
 aCktu29sPenV2OElz+Czdh4a1S3kVnA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-8URbAQo7NMiXPMNckgVbRg-1; Fri, 27 Jun 2025 08:34:17 -0400
X-MC-Unique: 8URbAQo7NMiXPMNckgVbRg-1
X-Mimecast-MFC-AGG-ID: 8URbAQo7NMiXPMNckgVbRg_1751027656
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-450eaae2934so15495105e9.2
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 05:34:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751027656; x=1751632456;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D3Sv9Y8di8jPYm/s97VvLp8PmHdRBf8mYlRytEYZR4c=;
 b=WXq1zDrJOwfk/sbF5PIAPcv13QLnYmMdqFyRAeHCJJVyKCydDXwsVazYzlPHI4H1rp
 IEDq6dsVO7Ao9JFvn+ExhbW/9VVMjrlrdYIGZW/Yhs4fssLXYLyxDPYHGyYZf34YTIC1
 eGscR5QntGQc1lxrBocLPVZ2ZzcD6Lpok7t3zc8ex/QdhlN/nCHxS10zyuf6GXE3hQQI
 xomBsR2J55mvlNfCJynDt+tt9J2uQuw/a68sDul8ghxpCWFWT86jrOd85efouP/NXfb1
 8LIGnu2RoaGxP5fwOrL/nueD1z2SB1RrV/z773HBJQCY8OAMlQqLOlXrC/DkP4snUcA1
 67ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMNOhYb6x8OrAg8wZ1b5BCsbSJL/xLhRBRQyEc1VqFGe3IyC2jUWpNCpC5jpgdhGx/M+uO3MuHnoqf@nongnu.org
X-Gm-Message-State: AOJu0Yz1mSB+JLaM+ucL+6HDxyktvI9zl4F4Zcu7P4JIvc9Y5YW24AQ2
 RwiC1CEywWzDaEWGeZpKzN7daM28/JwrLHr2xeJD8l+t+oqQWxE/0JbgqZJfb4kM2pMJia7YL+x
 SvmcgRZdzqiyp4/zF/lPwNOI7tk2Vr8RUiBvMbMjKzNg0oF1nB1UpWJB5
X-Gm-Gg: ASbGncuyhsYxRc2YvxqD60GIkNAHX34qCOFWLq7hIuOPmyguAmq+JAZbykWb1HJAJ+T
 6J1cdldjGsfTUGjFsiJ7leke38iJ0ai3tkIo1FYZTB/8PaWLMpliKfGv0vR7mPwhgZ3OULVt28i
 i1mRwBxJB8ineJ4habryvo0dL7v5iEzj21VCBZA42fEqg3Fzzwpiwacn2CC/uPJ8e1Ktdbr0voR
 o5igTcRt5+TPHorcLASOaXMDMv1ZTZWqMQs/cfQn2auMTG6cNg2M5e9Eb+ySRKerbTyvNozUCXL
 pkK6BDhA2Q3u7LqZVGVBB8dfUcVCkpJbAISlLDhhYsw4a2zn5tkJUYxD2iNTp66peuDQsA==
X-Received: by 2002:a5d:59c7:0:b0:3a4:fc3f:ed28 with SMTP id
 ffacd0b85a97d-3a8fee64fafmr3464655f8f.29.1751027656345; 
 Fri, 27 Jun 2025 05:34:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHriRx80K13pCCYuf97CSL93014QHI8rcf7qERcrxK/9a0yAGNeruxmR6lny8/bEq9dSkGV0g==
X-Received: by 2002:a5d:59c7:0:b0:3a4:fc3f:ed28 with SMTP id
 ffacd0b85a97d-3a8fee64fafmr3464615f8f.29.1751027655799; 
 Fri, 27 Jun 2025 05:34:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453823ad0f3sm81282035e9.19.2025.06.27.05.34.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Jun 2025 05:34:15 -0700 (PDT)
Message-ID: <a9499ef5-17c2-446b-b4d3-167ede3f4f9b@redhat.com>
Date: Fri, 27 Jun 2025 14:34:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/11] qtest/bios-tables-test: Add tests for legacy
 smmuv3 and smmuv3 device
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, imammedo@redhat.com,
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com,
 gustavo.romero@linaro.org, linuxarm@huawei.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250623094230.76084-1-shameerali.kolothum.thodi@huawei.com>
 <20250623094230.76084-11-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250623094230.76084-11-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 6/23/25 11:42 AM, Shameer Kolothum wrote:
> For the legacy SMMUv3 test, the setup includes three PCIe Root Complexes,
> one of which has bypass_iommu enabled. The generated IORT table contains
> a single SMMUv3 node and a Root Complex node with three ID mappings. Two
> of these ID mappings have output references pointing to the SMMUv3 node
> and the remianing one points to ITS.
remaining
>
> For the -device arm-smmuv3,... test, the configuration also includes three
> Root Complexes, with two connected to separate SMMUv3 devices.
By the way I have never paid attention to the fact there is only 1
single IORT node despite we have 3 GPEX/PXB devices
> The resulting IORT table contains two SMMUv3 nodes and a Root Complex node
> with ID mappings of which two of the ID mappings have output references
above is a bit difficult to parse.

Suggesting:
The resulting IORT table contains 1 RC node, 2 SMMU nodes and 1 ITS node.

> pointing to two different SMMUv3 nodes and the remaining ones to ITS.
RC node features 3 ID mappings. 2 of them target the 2 SMMU nodes while
the last one targets the ITS.
a drawing might be simpler
        pcie.0 -> {SMMU0} -> {ITS}
{RC}    pcie.1 -> {SMMU1} -> {ITS}
        pcie.2            -> {ITS}
>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  tests/qtest/bios-tables-test.c | 86 ++++++++++++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
>
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 0b2bdf9d0d..1c50541b43 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -2231,6 +2231,86 @@ static void test_acpi_aarch64_virt_viot(void)
>      free_test_data(&data);
>  }
>  
> +static void test_acpi_aarch64_virt_smmuv3_legacy(void)
> +{
> +    test_data data = {
> +        .machine = "virt",
> +        .arch = "aarch64",
> +        .tcg_only = true,
> +        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
> +        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
> +        .ram_start = 0x40000000ULL,
> +        .scan_len = 128ULL * MiB,
> +    };
> +
> +    /*
> +     * cdrom is plugged into scsi controller to avoid conflict
> +     * with pxb-pcie. See comments in test_acpi_aarch64_virt_tcg_pxb() for
> +     * details.
> +     *
> +     * The setup includes three PCIe root complexes, one of which has
> +     * bypass_iommu enabled. The generated IORT table contains a single
> +     * SMMUv3 node and a Root Complex node with three ID mappings. Two
> +     * of the ID mappings have output references pointing to the SMMUv3
> +     * node and the remaining one points to ITS.
> +     */
> +    data.variant = ".smmuv3-legacy";
> +    test_acpi_one(" -device pcie-root-port,chassis=1,id=pci.1"
> +                  " -device virtio-scsi-pci,id=scsi0,bus=pci.1"
> +                  " -drive file="
> +                  "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2,"
> +                  "if=none,media=cdrom,id=drive-scsi0-0-0-1,readonly=on"
> +                  " -device scsi-cd,bus=scsi0.0,scsi-id=0,"
> +                  "drive=drive-scsi0-0-0-1,id=scsi0-0-0-1,bootindex=1"
> +                  " -cpu cortex-a57"
> +                  " -M iommu=smmuv3"
> +                  " -device pxb-pcie,id=pcie.1,bus=pcie.0,bus_nr=0x10"
> +                  " -device pxb-pcie,id=pcie.2,bus=pcie.0,bus_nr=0x20,bypass_iommu=on",
> +                  &data);
> +    free_test_data(&data);
> +}
> +
> +static void test_acpi_aarch64_virt_smmuv3_dev(void)
> +{
> +    test_data data = {
> +        .machine = "virt",
> +        .arch = "aarch64",
> +        .tcg_only = true,
> +        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
> +        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
> +        .ram_start = 0x40000000ULL,
> +        .scan_len = 128ULL * MiB,
> +    };
> +
> +    /*
> +     * cdrom is plugged into scsi controller to avoid conflict
> +     * with pxb-pcie. See comments in test_acpi_aarch64_virt_tcg_pxb()
> +     * for details.
> +     *
> +     * The setup includes three PCie root complexes, two of which are
> +     * connected to separate SMMUv3 devices. The resulting IORT table
> +     * contains two SMMUv3 nodes and a Root Complex node with ID mappings
> +     * of which two of the ID mappings have output references pointing
> +     * to two different SMMUv3 nodes and the remaining ones pointing to
> +     * ITS.
> +     */
> +    data.variant = ".smmuv3-dev";
> +    test_acpi_one(" -device pcie-root-port,chassis=1,id=pci.1"
> +                  " -device virtio-scsi-pci,id=scsi0,bus=pci.1"
> +                  " -drive file="
> +                  "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2,"
> +                  "if=none,media=cdrom,id=drive-scsi0-0-0-1,readonly=on"
> +                  " -device scsi-cd,bus=scsi0.0,scsi-id=0,"
> +                  "drive=drive-scsi0-0-0-1,id=scsi0-0-0-1,bootindex=1"
> +                  " -cpu cortex-a57"
> +                  " -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.0"
> +                  " -device pxb-pcie,id=pcie.1,bus=pcie.0,bus_nr=0x10"
> +                  " -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.1"
> +                  " -device pxb-pcie,id=pcie.2,bus=pcie.0,bus_nr=0x20",
> +                  &data);
> +    free_test_data(&data);
> +}
> +
>  #ifndef _WIN32
>  # define DEV_NULL "/dev/null"
>  #else
> @@ -2586,6 +2666,12 @@ int main(int argc, char *argv[])
>              if (qtest_has_device("virtio-iommu-pci")) {
>                  qtest_add_func("acpi/virt/viot", test_acpi_aarch64_virt_viot);
>              }
> +            qtest_add_func("acpi/virt/smmuv3-legacy",
> +                           test_acpi_aarch64_virt_smmuv3_legacy);
> +            if (qtest_has_device("arm-smmuv3")) {
> +                qtest_add_func("acpi/virt/smmuv3-dev",
> +                               test_acpi_aarch64_virt_smmuv3_dev);
> +            }
>          }
>      } else if (strcmp(arch, "riscv64") == 0) {
>          if (has_tcg && qtest_has_device("virtio-blk-pci")) {
Besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


