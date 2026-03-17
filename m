Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD894FD7077
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 11:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2SOb-00081S-9e; Tue, 17 Mar 2026 07:15:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1w2SOX-0007zz-3l
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 07:15:30 -0400
Received: from mail-dy1-x1343.google.com ([2607:f8b0:4864:20::1343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1w2SOU-0003Cm-GE
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 07:15:28 -0400
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-2bea8a1c040so3505779eec.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 04:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773746125; x=1774350925; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eRnYMET99zbH5OBuOJdTyZrVImvdstF9rWmNszuj5ec=;
 b=GjETo75LnVBycTvvbuynldohAdvQ4WkndNkfp7tFYm88kYVj++E1Kd4mz5UZfHucg/
 P0bY/EMHOWt0G9rQy7cw3Ti6ym9vTg4d/E1MTYcdGJXpYCVNVFWaPxnmmCbOf7OD5df7
 tYgqmzP84SGswrvWJYeHHYAOELcDXUyQ2hHS+FNFx9chIBp8e5AhSurpkrnaH0AnbtUJ
 M9Sqa6t8/a0CvPu7RUOsDRANnW+loGD5YRuGNgQQZP1MRlHiATIn7oobRwVZd5tbeuNO
 rz6ErNOqiuUrCV6xkP+5jpEpYZ6cNvMdF4P5ajEM/IVNwHjZEEKkscfTs5XzooA2cPPA
 eeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773746125; x=1774350925;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eRnYMET99zbH5OBuOJdTyZrVImvdstF9rWmNszuj5ec=;
 b=RxQ9k6BhBAfBU9Ks9nqPt2Scz1Gio9VmlKXBRKtssRFHALi/VmmaSaIFkrqoliKdTM
 zElV4FWttbgYfBITimaPQPHU4LCDVoXKoaRMEagbssWIhDUIoWJKGc2Wmxw3Ixa+wdqq
 aj1IXk2wpltoEa04miAOwFBLarco68LhUGNH14nJNhn5CUPOVk8Y9qwFh+YjfXPgYLNJ
 /jVVTtCFr7CeIlp/oxDzhVSQRhsleuURwi10qIiAZNOSY7Gq63yJdbaqZA3diF/GJcH6
 3MJHXNMZ7+xK6vtqUsawRRdXvX+6xNQ/yR6m4KGXy6mbard2Cl3UwWix9xpWuKrt8ZQS
 T6dQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaLeVDPK1iPtujaPoRbvn0Zm9PIRaSEPxYj0NXRRTZesvjoRlOwFs1hRFZvxnk6n+r0kD/1Vey4oyB@nongnu.org
X-Gm-Message-State: AOJu0YxNBY/NqwmGNdhpTLnwnZG46VRQVXVA0pp+FR4SYlQTm3qr58sS
 96FL0PQrAyhfLhyHvr1x1POI7Xm1lzn6OWTg8ScPka1kmwcyKBBVCa26
X-Gm-Gg: ATEYQzz/0AC07jY/Fjv/JeA5MJV6wZ51yn7eqKrACF0iGbOTgAaPq3tZU3XftE/rJx/
 MfvrVut3s34wdN7QCjUFDJXDV4GiiF743KzQNa+BDVYCxDpsVnh6PB6L0xky80lmPO/pMObKBiR
 e0H7abaoww8pGfWdyTqkE70qQ+v0Sxm7ogxOkl7iNeTsjudROVGjACsveQKsYPZ984/QDEylAzY
 RandCOOY7RsIu/+9xypTQQ6cL7GOSQX3nFFQSlLhEHRM/coBlr/1PFG9Xf0Hea2yhl1J68u/oW3
 u2SX6mUwKNxJ4Ecctd68323i7uqIUwqZE340ChqgOkHxviufpQZ5wNNSlZ5YeWUagQtTsoRkJ1f
 PiVgMPW0yv0GRGgFIriBvrPa3xujE5zqaIZU0Kq63LSv+CCqGWRlfuVbxGZMfDEVjscscr9hEpN
 c/xoHf7NgjPSRpEbWntWv115i6Zejt/jmTfwNModYp/9IdCx5P3Do2vJQNK9akv/IvqN8ui+BvM
 IOHjn+rxG/pVQRS1eFnDF3co+peB/vnBR4DgiWRpw==
X-Received: by 2002:a05:7300:2216:b0:2c0:ced1:5857 with SMTP id
 5a478bee46e88-2c0ced15d13mr2000073eec.4.1773746124571; 
 Tue, 17 Mar 2026 04:15:24 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2beab3ea2cfsm22130216eec.11.2026.03.17.04.15.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 04:15:23 -0700 (PDT)
Date: Tue, 17 Mar 2026 19:15:11 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Fengyuan Yu <15fengyuan@gmail.com>
Cc: Tao Tang <tangtao1634@phytium.com.cn>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, 
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@bull.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 2/2] tests/qtest: Add Intel IOMMU bare-metal test
Message-ID: <abk3Z7dKXu2CjSfT@ZEVORN-PC.localdomain>
References: <cover.1773450180.git.15fengyuan@gmail.com>
 <4bb96344e7d181473b0ed4520bef783cbda586e1.1773450180.git.15fengyuan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bb96344e7d181473b0ed4520bef783cbda586e1.1773450180.git.15fengyuan@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1343;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1343.google.com
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

On Sat, Mar 14, 2026 at 09:11:37AM +0800, Fengyuan Yu wrote:
Same as patch 1 -- the commit message needs a body.

> Signed-off-by: Fengyuan Yu <15fengyuan@gmail.com>
> ---
>  tests/qtest/iommu-intel-test.c | 215 +++++++++++++++++++++++++++++++++
>  tests/qtest/meson.build        |   2 +
>  2 files changed, 217 insertions(+)
>  create mode 100644 tests/qtest/iommu-intel-test.c
> 
This is where the MAINTAINERS entry for
iommu-intel-test.c should be added (moved from
patch 1), since this patch creates the file.


> diff --git a/tests/qtest/iommu-intel-test.c b/tests/qtest/iommu-intel-test.c
> new file mode 100644
> index 0000000000..ec74a4c0d4
> --- /dev/null
> +++ b/tests/qtest/iommu-intel-test.c
> @@ -0,0 +1,215 @@
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
> +#include "hw/i386/intel_iommu_internal.h"
> +#include "hw/misc/iommu-testdev.h"
> +#include "libqos/qos-intel-iommu.h"
> +
> +#define DMA_LEN           4
> +
> +static uint64_t intel_iommu_expected_gpa(uint64_t iova)
> +{
> +    return (QVTD_PT_VAL & VTD_PAGE_MASK_4K) + (iova & 0xfff);
> +}
> +
> +static void save_fn(QPCIDevice *dev, int devfn, void *data)
> +{
> +    QPCIDevice **pdev = (QPCIDevice **) data;
> +
> +    *pdev = dev;
> +}
> +
> +static QPCIDevice *setup_qtest_pci_device(QTestState *qts, QPCIBus **pcibus,
> +                                          QPCIBar *bar)
> +{
> +    QPCIDevice *dev = NULL;
> +
> +    *pcibus = qpci_new_pc(qts, NULL);
> +    g_assert(*pcibus != NULL);
> +
> +    qpci_device_foreach(*pcibus, IOMMU_TESTDEV_VENDOR_ID,
> +                        IOMMU_TESTDEV_DEVICE_ID, save_fn, &dev);
> +
> +    g_assert(dev);
> +    qpci_device_enable(dev);
> +    *bar = qpci_iomap(dev, 0, NULL);
> +    g_assert_false(bar->is_io);
> +
> +    return dev;
> +}
> +
> +static const char *qvtd_iommu_args(QVTDTransMode mode)
> +{
> +    switch (mode) {
> +    case QVTD_TM_SCALABLE_FLT:
> +        return "-device intel-iommu,x-scalable-mode=on,x-flts=on ";
> +    case QVTD_TM_SCALABLE_PT:
> +    case QVTD_TM_SCALABLE_SLT:
> +        return "-device intel-iommu,x-scalable-mode=on ";
> +    default:
> +        return "-device intel-iommu ";
> +    }
> +}
> +
> +static bool qvtd_check_caps(QTestState *qts, QVTDTransMode mode)
> +{
> +    uint64_t ecap = qtest_readq(qts, Q35_IOMMU_BASE + DMAR_ECAP_REG);
> +
> +    /* All scalable modes require SMTS */
> +    if (qvtd_is_scalable(mode) && !(ecap & VTD_ECAP_SMTS)) {
> +        g_test_skip("ECAP.SMTS not supported");
> +        return false;
> +    }
> +
> +    switch (mode) {
> +    case QVTD_TM_SCALABLE_PT:
> +        if (!(ecap & VTD_ECAP_PT)) {
> +            g_test_skip("ECAP.PT not supported");
> +            return false;
> +        }
> +        break;
> +    case QVTD_TM_SCALABLE_SLT:
> +        if (!(ecap & VTD_ECAP_SSTS)) {
> +            g_test_skip("ECAP.SSTS not supported");
> +            return false;
> +        }
> +        break;
> +    case QVTD_TM_SCALABLE_FLT:
> +        if (!(ecap & VTD_ECAP_FSTS)) {
> +            g_test_skip("ECAP.FSTS not supported");
> +            return false;
> +        }
> +        break;
> +    default:
> +        break;
> +    }
> +
> +    return true;
> +}
> +
> +static void run_intel_iommu_translation(const QVTDTestConfig *cfg)
> +{
> +    QTestState *qts;
> +    QPCIBus *pcibus;
> +    QPCIDevice *dev;
> +    QPCIBar bar;
> +
> +    if (!qtest_has_machine("q35")) {
> +        g_test_skip("q35 machine not available");
> +        return;
> +    }
> +
> +    /* Initialize QEMU environment for Intel IOMMU testing */
> +    qts = qtest_initf("-machine q35 -smp 1 -m 512 -net none "
> +                      "%s -device iommu-testdev",
> +                      qvtd_iommu_args(cfg->trans_mode));
> +
> +    /* Check CAP/ECAP capabilities for required translation mode */
> +    if (!qvtd_check_caps(qts, cfg->trans_mode)) {
> +        qtest_quit(qts);
> +        return;
> +    }
> +
> +    /* Setup and configure IOMMU-testdev PCI device */
> +    dev = setup_qtest_pci_device(qts, &pcibus, &bar);
> +    g_assert(dev);
> +
> +    g_test_message("### Intel IOMMU translation mode=%d ###", cfg->trans_mode);
> +    qvtd_run_translation_case(qts, dev, bar, Q35_IOMMU_BASE, cfg);
As noted above, Q35_IOMMU_BASE should be replaced with
Q35_HOST_BRIDGE_IOMMU_ADDR once the redefinition in the
header is dropped.

> +    g_free(dev);
> +    qpci_free_pc(pcibus);
> +    qtest_quit(qts);
> +}
> +
> +static void test_intel_iommu_legacy_pt(void)
> +{
> +    QVTDTestConfig cfg = {
> +        .trans_mode = QVTD_TM_LEGACY_PT,
> +        .dma_gpa = QVTD_IOVA,  /* pass-through: GPA == IOVA */
> +        .dma_len = DMA_LEN,
> +        .expected_result = 0,
> +    };
> +
> +    run_intel_iommu_translation(&cfg);
> +}
> +
> +static void test_intel_iommu_legacy_trans(void)
> +{
> +    QVTDTestConfig cfg = {
> +        .trans_mode = QVTD_TM_LEGACY_TRANS,
> +        .dma_gpa = intel_iommu_expected_gpa(QVTD_IOVA),
> +        .dma_len = DMA_LEN,
> +        .expected_result = 0,
> +    };
> +
> +    run_intel_iommu_translation(&cfg);
> +}
> +
> +static void test_intel_iommu_scalable_pt(void)
> +{
> +    QVTDTestConfig cfg = {
> +        .trans_mode = QVTD_TM_SCALABLE_PT,
> +        .dma_gpa = QVTD_IOVA,  /* pass-through: GPA == IOVA */
> +        .dma_len = DMA_LEN,
> +        .expected_result = 0,
> +    };
> +
> +    run_intel_iommu_translation(&cfg);
> +}
> +
> +static void test_intel_iommu_scalable_slt(void)
> +{
> +    QVTDTestConfig cfg = {
> +        .trans_mode = QVTD_TM_SCALABLE_SLT,
> +        .dma_gpa = intel_iommu_expected_gpa(QVTD_IOVA),
> +        .dma_len = DMA_LEN,
> +        .expected_result = 0,
> +    };
> +
> +    run_intel_iommu_translation(&cfg);
> +}
> +
> +static void test_intel_iommu_scalable_flt(void)
> +{
> +    QVTDTestConfig cfg = {
> +        .trans_mode = QVTD_TM_SCALABLE_FLT,
> +        .dma_gpa = intel_iommu_expected_gpa(QVTD_IOVA),
> +        .dma_len = DMA_LEN,
> +        .expected_result = 0,
> +    };
> +
> +    run_intel_iommu_translation(&cfg);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    /* Legacy mode tests */
> +    qtest_add_func("/iommu-testdev/intel/legacy-pt",
> +                   test_intel_iommu_legacy_pt);
> +    qtest_add_func("/iommu-testdev/intel/legacy-trans",
> +                   test_intel_iommu_legacy_trans);
> +
> +    /* Scalable mode tests */
> +    qtest_add_func("/iommu-testdev/intel/scalable-pt",
> +                   test_intel_iommu_scalable_pt);
> +    qtest_add_func("/iommu-testdev/intel/scalable-slt",
> +                   test_intel_iommu_scalable_slt);
> +    qtest_add_func("/iommu-testdev/intel/scalable-flt",
> +                   test_intel_iommu_scalable_flt);
> +
> +    return g_test_run();
> +}
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index be4fa627b5..264bce9f81 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -96,6 +96,8 @@ qtests_i386 = \
>    (config_all_devices.has_key('CONFIG_SDHCI_PCI') ? ['fuzz-sdcard-test'] : []) +            \
>    (config_all_devices.has_key('CONFIG_ESP_PCI') ? ['am53c974-test'] : []) +                 \
>    (config_all_devices.has_key('CONFIG_VTD') ? ['intel-iommu-test'] : []) +                 \
> +  (config_all_devices.has_key('CONFIG_VTD') and
> +   config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') ? ['iommu-intel-test'] : []) +      \
Good -- correctly gates on both CONFIG_VTD and
CONFIG_IOMMU_TESTDEV.

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
>    (host_os != 'windows' and                                                                \
>     config_all_devices.has_key('CONFIG_ACPI_ERST') ? ['erst-test'] : []) +                   \
>    (config_all_devices.has_key('CONFIG_PCIE_PORT') and                                       \
> -- 
> 2.39.5
> 

