Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C13CC98318
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Jan 2026 10:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vh3Ae-0000L3-Lf; Sat, 17 Jan 2026 05:04:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vh3Ac-0000Ji-IW
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 05:04:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vh3Aa-000555-Rc
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 05:04:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768644276;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h4Sfo3Dj9Onxd6boMFWvvcilrVAM7fseffZ2IBDUC+8=;
 b=blRRquB7d6Vs6a4/KZFwq8dUs31tselsHZELxsTljNFzqnjQDaIjvR0tuBZS02I5j2D6Ob
 ffjPziw0PUp7D2XENIzAMWSIM1jNLUax26rtyjMF3BoViXZNeSQ2NzuUtltHKrolC5DGNE
 3H2r66N1hW/VtXrGdW5jxpHKNMKkP5g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-QAtfvT3NPSChi-ROmTsgHQ-1; Sat, 17 Jan 2026 05:04:34 -0500
X-MC-Unique: QAtfvT3NPSChi-ROmTsgHQ-1
X-Mimecast-MFC-AGG-ID: QAtfvT3NPSChi-ROmTsgHQ_1768644273
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477cf2230c8so24644095e9.0
 for <qemu-devel@nongnu.org>; Sat, 17 Jan 2026 02:04:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768644273; x=1769249073;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h4Sfo3Dj9Onxd6boMFWvvcilrVAM7fseffZ2IBDUC+8=;
 b=ClkcXqKel+9HkAkp1TMG/l4+wxgHJ3IYGbBnG5XQkKetmqTX1vYnQmyuyZfTvD6Rd4
 sjwlaf58Kv6UE3E7eRtm/vZ8DQI484TznwIkhBwnx8kc7lI7ph8ISNVcwt/eAAVzWpkF
 OCN+cpJefoH28BFUIhNgk5fIyaVEO7+oecaFAQxL0nrM/In3Q1D1j+tLXdcLpJwMOK8c
 QnlY6oHa+8FMVZLs/qC400/2NGLHjEdrou+Qdk00wTlAujbqJCXORIcSeLKbkermfIog
 Gpx5zbx+DLBg81C4aMV1dVNUOM+dzflSFsmNG5CdTOcI/h+04HLYvJw8XLggjTosVVIh
 UK3Q==
X-Gm-Message-State: AOJu0YyP4xob9Vde7RS+ka+9ni4KwoM5agfAoG48udnx30bREDKLxI2b
 45fW/f2l3kCOvDlm+2g3Ok04lZnSKv20daxV+SJw/DYOgb4EW/nsLE0Dm1PCYYbnmlEWD+p3m4Z
 /1nHi+9p1FYn1yMufQ0mPL/0z0atnaufwbFFuJqFJB+wwpZJeaQi+pKIo
X-Gm-Gg: AY/fxX4hlarB9XqNuzp/ao6rTOciq94TYE7cJ++oevNwSeioqeVEn5APUgfzv0FAv3/
 6ndYciG5GCCFZ8GTFXJ0SIGnaFrp+1utpIZ9KhhKj1Vv/+TRU1i/bioy8mG6gdfRCRNpxl/R+ga
 9DKpmZqQrGYPTaWhDAasi/5G0DD1SVWuV6qLwFR1Ftga1Vt0eHCuAcOUIpVInKJ8daRcbHa6yeR
 qzJ4CcIr5SDV+HKfKr0OCPLIkKDmn3f61s4W1xIt1EWHLPJJNhnNoMK7qRRv+lI614BmeXL14en
 bHlwWWL7QUT4xRkajB5Ns8QBtl7vkJ9du6cOeMfFNW0s6V0CRgoBHRWu7/daBHu/KPXXs1teeO8
 Y8W91fH4IMV6watx5xDE2KX7VDKZcQuCgSJHIiwJew37MSTM42M3LnvGNPg==
X-Received: by 2002:a05:600c:630f:b0:475:e09c:960e with SMTP id
 5b1f17b1804b1-4801e3495e9mr69854215e9.32.1768644273166; 
 Sat, 17 Jan 2026 02:04:33 -0800 (PST)
X-Received: by 2002:a05:600c:630f:b0:475:e09c:960e with SMTP id
 5b1f17b1804b1-4801e3495e9mr69853965e9.32.1768644272703; 
 Sat, 17 Jan 2026 02:04:32 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f42907141sm141789755e9.9.2026.01.17.02.04.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Jan 2026 02:04:31 -0800 (PST)
Message-ID: <0b4b21e5-40e4-4d09-8624-7507dbb220e3@redhat.com>
Date: Sat, 17 Jan 2026 11:04:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v8 7/7] tests/qtest: Add SMMUv3 bare-metal test using
 iommu-testdev
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>, Paolo Bonzini
 <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
References: <20251224034647.2596434-1-tangtao1634@phytium.com.cn>
 <20251224034647.2596434-8-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251224034647.2596434-8-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Tao,

On 12/24/25 4:46 AM, Tao Tang wrote:
> Add a qtest suite that validates ARM SMMUv3 translation without guest
> firmware or OS. The tests leverage iommu-testdev to trigger DMA
> operations and the qos-smmuv3 library to configure IOMMU translation
> structures.
>
> This test suite targets the virt machine and covers:
> - Stage 1 only translation (VA -> PA via CD page tables)
> - Stage 2 only translation (IPA -> PA via STE S2 tables)
> - Nested translation (VA -> IPA -> PA, Stage 1 + Stage 2)
> - Design to extended to support multiple security spaces
>     (Non-Secure, Secure, Root, Realm)
>
> Each test case follows this sequence:
> 1. Initialize SMMUv3 with appropriate command/event queues
> 2. Build translation tables (STE/CD/PTE) for the target scenario
> 3. Configure iommu-testdev with IOVA and DMA attributes via MMIO
> 4. Trigger DMA and validate successful translation
> 5. Verify data integrity through a deterministic write-read pattern
>
> This bare-metal approach provides deterministic IOMMU testing with
> minimal dependencies, making failures directly attributable to the SMMU
> translation path.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  tests/qtest/iommu-smmuv3-test.c | 121 ++++++++++++++++++++++++++++++++
>  tests/qtest/meson.build         |   1 +
>  2 files changed, 122 insertions(+)
>  create mode 100644 tests/qtest/iommu-smmuv3-test.c
>
> diff --git a/tests/qtest/iommu-smmuv3-test.c b/tests/qtest/iommu-smmuv3-test.c
> new file mode 100644
> index 0000000000..b612f5ca6c
> --- /dev/null
> +++ b/tests/qtest/iommu-smmuv3-test.c
> @@ -0,0 +1,121 @@
> +/*
> + * QTest for SMMUv3 with iommu-testdev
> + *
> + * This QTest file is used to test the SMMUv3 with iommu-testdev so that we can
> + * test SMMUv3 without any guest kernel or firmware.
> + *
> + * Copyright (c) 2025 Phytium Technology
> + *
> + * Author:
> + *  Tao Tang <tangtao1634@phytium.com.cn>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +#include "libqos/pci.h"
> +#include "libqos/generic-pcihost.h"
> +#include "hw/pci/pci_regs.h"
> +#include "hw/misc/iommu-testdev.h"
> +#include "libqos/qos-smmuv3.h"
> +
> +#define DMA_LEN           4
> +
> +static void save_fn(QPCIDevice *dev, int devfn, void *data)
> +{
> +    QPCIDevice **pdev = (QPCIDevice **) data;
> +
> +    *pdev = dev;
> +}
> +
> +static QPCIDevice *setup_qtest_pci_device(QTestState *qts, QGenericPCIBus *gbus,
> +                                          QPCIBar *bar)
> +{
> +    QPCIDevice *dev = NULL;
> +
> +    qpci_init_generic(gbus, qts, NULL, false);
> +
> +    qpci_device_foreach(&gbus->bus, IOMMU_TESTDEV_VENDOR_ID,
> +                        IOMMU_TESTDEV_DEVICE_ID, save_fn, &dev);
> +    g_assert(dev);
> +
> +    qpci_device_enable(dev);
> +    *bar = qpci_iomap(dev, 0, NULL);
> +    g_assert_false(bar->is_io);
> +
> +    return dev;
> +}
> +
> +static void run_smmuv3_translation(const QSMMUTestConfig *cfg)
> +{
> +    QTestState *qts;
> +    QGenericPCIBus gbus;
> +    QPCIDevice *dev;
> +    QPCIBar bar;
> +
> +    /* Initialize QEMU environment for SMMU testing */
> +    qts = qtest_init("-machine virt,acpi=off,gic-version=3,iommu=smmuv3 "
> +                     "-smp 1 -m 512 -cpu max -net none "
> +                     "-device iommu-testdev");
> +
> +    /* Setup and configure PCI device */
> +    dev = setup_qtest_pci_device(qts, &gbus, &bar);
> +    g_assert(dev);
> +
> +    g_test_message("### SMMUv3 translation mode=%d sec_sid=%d ###",
> +                   cfg->trans_mode, cfg->sec_sid);
> +    qsmmu_run_translation_case(qts, dev, bar, VIRT_SMMU_BASE, cfg);
> +    qtest_quit(qts);
> +}
> +
> +static void test_smmuv3_ns_s1_only(void)
> +{
> +    QSMMUTestConfig cfg = {
> +        .trans_mode = QSMMU_TM_S1_ONLY,
> +        .sec_sid = QSMMU_SEC_SID_NONSECURE,
> +        .dma_iova = QSMMU_IOVA,
> +        .dma_len = DMA_LEN,
> +        .expected_result = 0,
> +    };
> +
> +    run_smmuv3_translation(&cfg);
> +}
> +
> +static void test_smmuv3_ns_s2_only(void)
> +{
> +    QSMMUTestConfig cfg = {
> +        .trans_mode = QSMMU_TM_S2_ONLY,
> +        .sec_sid = QSMMU_SEC_SID_NONSECURE,
> +        .dma_iova = QSMMU_IOVA,
> +        .dma_len = DMA_LEN,
> +        .expected_result = 0,
> +    };
> +
> +    run_smmuv3_translation(&cfg);
> +}
> +
> +static void test_smmuv3_ns_nested(void)
> +{
> +    QSMMUTestConfig cfg = {
> +        .trans_mode = QSMMU_TM_NESTED,
> +        .sec_sid = QSMMU_SEC_SID_NONSECURE,
> +        .dma_iova = QSMMU_IOVA,
> +        .dma_len = DMA_LEN,
> +        .expected_result = 0,
> +    };
> +
> +    run_smmuv3_translation(&cfg);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +    qtest_add_func("/iommu-testdev/translation/ns-s1-only",
> +                   test_smmuv3_ns_s1_only);
> +    qtest_add_func("/iommu-testdev/translation/ns-s2-only",
> +                   test_smmuv3_ns_s2_only);
> +    qtest_add_func("/iommu-testdev/translation/ns-nested",
> +                   test_smmuv3_ns_nested);
> +    return g_test_run();
> +}
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 669d07c06b..e2d2e68092 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -263,6 +263,7 @@ qtests_aarch64 = \
>     config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
>    (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed64 : []) + \
>    (config_all_devices.has_key('CONFIG_NPCM8XX') ? qtests_npcm8xx : []) + \
> +  (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') ? ['iommu-smmuv3-test'] : []) + \
One question: since it can only run along with VIRT machine, how do we
make sure this only runs with that machine enabled?

Thanks

Eric


>    qtests_cxl +                                                                                  \
>    ['arm-cpu-features',
>     'numa-test',


