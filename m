Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D896E83EE5
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 07:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnXYJ-0006MW-90; Wed, 04 Feb 2026 02:43:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vnXYI-0006MJ-BZ
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 02:43:54 -0500
Received: from mail-dy1-x1342.google.com ([2607:f8b0:4864:20::1342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vnXYE-0002sH-DR
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 02:43:53 -0500
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-2b834e17c3fso513258eec.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 23:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770191029; x=1770795829; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5pvi1DfQZXI3kydk5Lj5uGMaKdl4PFR8RowZ7E/L3j8=;
 b=OUu9v/2eYq07J7ODIREm+zLfxM51rECHTdGGjLJ65sVj2t13vBsJ3R3PJgzO7Yy7ce
 TvasuFYnH/q3YSBPR17f8tPUPDTVeHnoyPQTHK+/m/CCQ72phVCiIYtO5Xn2bChmQG5l
 ndqGPU1SFXarXK4Z2xTaUCYlke9YbcV4oo3jZZnnGRMVITyy0FPPzI98qxweTqrTdYKu
 uIHP4xCJw6M2lFuJqsvvwOA5memctGGTwMH29miVPudPACagmkCkV01t8tzYZXHgJi1H
 4s3y8E8CJyXXY2c438HH8a50pIw6GTrhvo9978LORLc4ivt0JsJ7w3XzIV4SzouCRcAi
 bGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770191029; x=1770795829;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5pvi1DfQZXI3kydk5Lj5uGMaKdl4PFR8RowZ7E/L3j8=;
 b=TVcngt2KF0RgU26aOwsd4uO0u7Kzu1bonIBy0k1K94YzO9t2WukCvYz8fgVhzm1Id9
 XJkGqAaMxrn8QbuJEiGGvLpo14QXSns+UsnA/NZywbvIPeah+v4wGC48O6Q5yjJnDrxD
 DgVWGdwoHf9mskrz7vV2IKYaHCENGVsVgrM/ge+fsWJfFRagvxmKSscmjtXHbIJJiuIF
 23NusiOHtnmMBAJa7lokE40SjaHbixxkB9+YWTzJbdN11hdqR4hKNiTwMQLGTrz15xqP
 IQsPH1jdigF6u+K2aecwTGpgbIBKmRSAsJfX5xjjx58Tyvqt2yjS9xZFV3FccvCjF59M
 vxdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUaK6QIoIsUJQydzg5pIH98aUJ4bu28ZBPAtJd0Y7tj62xgajL0efkKmnluM5wC8AK7IpJ3wVCPzGi@nongnu.org
X-Gm-Message-State: AOJu0YwD/D2ysrZmzYIINYzN8S4Nml9afmlsVbeLo7qemkBa2mS7PlT1
 EPMjvjnKc1jTQGYTCLxkhGrKdylA34fTLfUofT67atk8aaKXROzLjz1k
X-Gm-Gg: AZuq6aIxwHQrm7i1wsZ8gE0vdwlZjlNqYSUCQG8ZK0MM4LYApqEgq1lYVWTbrw5yBbh
 qdRQz1/YxzEUCZWGdEpji4Sw5cnwIPX7NUJyEFgGHRvPIwAWBAkGFMaIJgsDhF1CiznIgc8Pygr
 en6Y1gSctr0ygzyXFngVI+pIjA7NUydV9fS6xnXubtheEvsdJiWey8QSGBvqIOEkdriUbyRisbT
 Ozu7tT0spwbg1DJtXzgXH9TsYIDAO0EtNQTWPRk9pj8KfL/hL5VrpBBbdpJh0klWoeMni4TRkXw
 7e8z+8ZPVokhvPv01YmmHBOX4MeCtv993qccNEHUikQR8gCFKSJLbs79Wh5XeLThOXhJLMYuCYx
 NxSMFv3uoT3qxA0WIFBkBp4vVZefZYDbT7/YFu/dy46XW0vKELIgH2b68N6BXal+uURkfPUlTVm
 jRRVYYlB9FQ1ZXo0NpNrgL+wyK8Cm7hrtr0sk23pD5/wOakC0uzSHYJdm0TheF98pI4KFwI71qx
 hn30b1o9WE70g==
X-Received: by 2002:a05:7300:862b:b0:2b7:1d38:3596 with SMTP id
 5a478bee46e88-2b832878959mr901390eec.4.1770191028270; 
 Tue, 03 Feb 2026 23:43:48 -0800 (PST)
Received: from ZEVORN-PC ([38.95.120.198]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b832e4d08dsm1094265eec.11.2026.02.03.23.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 23:43:47 -0800 (PST)
Date: Wed, 4 Feb 2026 15:43:37 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Fengyuan Yu <15fengyuan@gmail.com>
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Tao Tang <tangtao1634@phytium.com.cn>, qemu-devel@nongnu.org
Subject: Re: [PATCH RFC v1 2/2] tests/qtest: Add Intel IOMMU bare-metal test
Message-ID: <aYL4qVS1IEbcoPL2@ZEVORN-PC>
References: <cover.1770172615.git.15fengyuan@gmail.com>
 <89909ddad9c2b887056344bb93e5407e3639980d.1770172615.git.15fengyuan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89909ddad9c2b887056344bb93e5407e3639980d.1770172615.git.15fengyuan@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1342;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1342.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Fengyuan,

On Wed, Feb 04, 2026 at 11:06:20AM +0800, Fengyuan Yu wrote:
> Add a qtest suite for the Intel IOMMU (VT-d) device on the Q35 machine.
> The test exercises pass-through and translated translation modes using
> iommu-testdev and the qos-intel-iommu helpers.
> 
> The test validates:
> - Root Entry Table and Context Entry Table configuration
> - 4-level page table walks for 48-bit address translation
> - Pass-through mode (identity mapping)
> - Translated mode with complete IOVA-to-PA translation
> - DMA transaction execution with memory content verification
> 
Good commit message.

> Signed-off-by: Fengyuan Yu <15fengyuan@gmail.com>
> ---
>  tests/qtest/iommu-intel-test.c | 137 +++++++++++++++++++++++++++++++++
>  tests/qtest/meson.build        |   2 +
>  2 files changed, 139 insertions(+)
>  create mode 100644 tests/qtest/iommu-intel-test.c
> 
> diff --git a/tests/qtest/iommu-intel-test.c b/tests/qtest/iommu-intel-test.c
> new file mode 100644
> index 0000000000..9f631be2c5
> --- /dev/null
> +++ b/tests/qtest/iommu-intel-test.c
> @@ -0,0 +1,137 @@
> +/*
> + * QTest for Intel IOMMU (VT-d) with iommu-testdev
> + *
> + * This QTest file is used to test the Intel IOMMU with iommu-testdev so that
> + * we can test VT-d without any guest kernel or firmware.
> + *
> + * Copyright (c) 2026 Fengyuan Yu <15fengyuan@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +#include "libqos/pci.h"
> +#include "libqos/pci-pc.h"
> +#include "hw/pci/pci_regs.h"
> +#include "hw/misc/iommu-testdev.h"
> +#include "libqos/qos-intel-iommu.h"
> +
> +#define DMA_LEN           4
> +
> +/* Test configurations for different Intel IOMMU modes */
> +static const QVTDTestConfig base_test_configs[] = {
> +    {
> +        .trans_mode = QVTD_TM_LEGACY_PT,
> +        .dma_iova = 0x10100000,  /* Use address in guest RAM range (inside 512MB) */
> +        .dma_pa = 0x10100000,
> +        .dma_len = DMA_LEN,
> +        .expected_result = 0,
> +        .domain_id = 1,
> +    },
> +    {
> +        .trans_mode = QVTD_TM_LEGACY_TRANS,
> +        .dma_iova = QVTD_TEST_IOVA,
> +        .dma_pa = QVTD_TEST_PA,
> +        .dma_len = DMA_LEN,
> +        .expected_result = 0,
> +        .domain_id = 1,
> +    },
> +};
> +
> +static QPCIDevice *setup_qtest_pci_device(QTestState *qts, QPCIBus **pcibus,
> +                                          QPCIBar *bar)
> +{
> +    uint16_t vid, did;
> +    QPCIDevice *dev = NULL;
> +    int device_count = 0;
> +
> +    *pcibus = qpci_new_pc(qts, NULL);
> +    g_assert(*pcibus != NULL);
> +
> +    g_test_message("Scanning PCI bus for iommu-testdev (vendor:device = 0x%04x:0x%04x)...",
> +                   IOMMU_TESTDEV_VENDOR_ID, IOMMU_TESTDEV_DEVICE_ID);
> +
> +    /* Find device by vendor/device ID to avoid slot surprises. */
> +    for (int s = 0; s < 32 && !dev; s++) {
> +        for (int fn = 0; fn < 8 && !dev; fn++) {
> +            QPCIDevice *cand = qpci_device_find(*pcibus, QPCI_DEVFN(s, fn));
> +            if (!cand) {
> +                continue;
> +            }
> +            vid = qpci_config_readw(cand, PCI_VENDOR_ID);
> +            did = qpci_config_readw(cand, PCI_DEVICE_ID);
> +
> +            device_count++;
> +            g_test_message("  Found PCI device at %02x:%x - vendor:device = 0x%04x:0x%04x",
> +                           s, fn, vid, did);
> +
> +            if (vid == IOMMU_TESTDEV_VENDOR_ID &&
> +                did == IOMMU_TESTDEV_DEVICE_ID) {
> +                dev = cand;
> +                g_test_message("Found iommu-testdev! devfn: 0x%x", cand->devfn);
> +            } else {
> +                g_free(cand);
> +            }
> +        }
> +    }
> +

This manual PCI bus scanning is verbose. The SMMUv3 test uses
qpci_device_foreach() which is more concise:

    qpci_device_foreach(&gbus->bus, IOMMU_TESTDEV_VENDOR_ID,
                        IOMMU_TESTDEV_DEVICE_ID, save_fn, &dev);

See iommu-smmuv3-test.c for reference.

> +    if (!dev) {
> +        g_test_message("ERROR: iommu-testdev not found after scanning %d PCI devices", device_count);
> +        g_test_message("Expected vendor:device = 0x%04x:0x%04x (PCI_VENDOR_ID_REDHAT:PCI_DEVICE_ID_REDHAT_TEST)",
> +                       IOMMU_TESTDEV_VENDOR_ID, IOMMU_TESTDEV_DEVICE_ID);
> +        qpci_free_pc(*pcibus);
> +        *pcibus = NULL;
> +        g_test_skip("iommu-testdev not found on PCI bus - device may not be compiled or registered");
> +        return NULL;
> +    }
> +
> +    /* Enable device - iommu-testdev only uses MMIO, not I/O ports */
> +    uint16_t cmd = qpci_config_readw(dev, PCI_COMMAND);
> +    cmd |= PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER;
> +    qpci_config_writew(dev, PCI_COMMAND, cmd);
> +
> +    *bar = qpci_iomap(dev, 0, NULL);
> +    g_assert_false(bar->is_io);
> +
> +    return dev;
> +}
> +
> +static void test_intel_iommu_translation(void)
> +{
> +    QTestState *qts;
> +    QPCIBus *pcibus;
> +    QPCIDevice *dev;
> +    QPCIBar bar;
> +
Please add a machine availability check before qtest_init(), similar to
what the SMMUv3 test does:

    if (!qtest_has_machine("q35")) {
        g_test_skip("q35 machine not available");
        return;
    }

> +    /* Initialize QEMU environment for Intel IOMMU testing */
> +    qts = qtest_init("-machine q35,kernel-irqchip=split "
> +                     "-accel tcg "
> +                     "-device intel-iommu,pt=on,aw-bits=48 "
> +                     "-device iommu-testdev,bus=pcie.0,addr=0x4 "
> +                     "-m 512");
> +
> +    /* Setup and configure PCI device */
> +    dev = setup_qtest_pci_device(qts, &pcibus, &bar);
> +    if (!dev) {
> +        qtest_quit(qts);
> +        return;
> +    }
> +
> +    /* Run the translation tests */
> +    g_test_message("### Starting Intel IOMMU translation tests...###");
> +    qvtd_translation_batch(base_test_configs, ARRAY_SIZE(base_test_configs),
> +                           qts, dev, bar, Q35_IOMMU_BASE);
> +    g_test_message("### Intel IOMMU translation tests completed successfully! ###");
> +
> +    g_free(dev);
> +    qpci_free_pc(pcibus);
> +    qtest_quit(qts);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +    qtest_add_func("/iommu-testdev/intel-translation", test_intel_iommu_translation);
The test path naming differs from the SMMUv3 convention. For consistency,
consider splitting into separate test functions and using paths like:

    qtest_add_func("/iommu-testdev/intel/legacy-pt", test_intel_legacy_pt);
    qtest_add_func("/iommu-testdev/intel/legacy-trans", test_intel_legacy_trans);

This makes it easier to run individual test cases and debug failures.

> +    return g_test_run();
> +}
Missing newline at end of file. Please run scripts/checkpatch.pl check
it.

> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index e2d2e68092..344e836300 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -95,6 +95,8 @@ qtests_i386 = \
>    (config_all_devices.has_key('CONFIG_SDHCI_PCI') ? ['fuzz-sdcard-test'] : []) +            \
>    (config_all_devices.has_key('CONFIG_ESP_PCI') ? ['am53c974-test'] : []) +                 \
>    (config_all_devices.has_key('CONFIG_VTD') ? ['intel-iommu-test'] : []) +                 \
> +  (config_all_devices.has_key('CONFIG_VTD') and
> +   config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') ? ['iommu-intel-test'] : []) +      \
>    (host_os != 'windows' and                                                                \
>     config_all_devices.has_key('CONFIG_ACPI_ERST') ? ['erst-test'] : []) +                   \
>    (config_all_devices.has_key('CONFIG_PCIE_PORT') and                                       \
> -- 
> 2.39.5
> 

One more thing: the MAINTAINERS entry in patch 1/2 only adds the libqos
files. Please also add to 'X86 general architecture support':

    F: tests/qtest/iommu-intel-test.c

to the IOMMU section.

Overall, this is a nice addition to the IOMMU testing infrastructure.

Thanks,
Chao

