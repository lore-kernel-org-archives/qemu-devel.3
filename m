Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C15D3E771
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 18:46:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTPCL-00077V-Un; Wed, 10 Dec 2025 13:46:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vTPCJ-00076w-FB
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 13:45:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vTPCF-00048p-4A
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 13:45:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765392354;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sMS+Q+wF/hCn/MwWLwr4ed1U6EOVDi5hMKamvBt1DII=;
 b=PDXlSuI+mrT6A+oHewmFUxOe5WOjAzC6hKO9WKXRt9tMRwI1oKlLFp8K0EiN3GDb1hUwlI
 +gOiQ8qYFiKBEI4kJthyZ6qjLb6YbdYJFj9Awtycx8LRbwYuQadNsgu9RwLKEwpr5R/7Vj
 XHlMNQP3jqsqI59U7rEUEZHCQxGMGLo=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-ofSba8BSNbmYQGmU-7VhZw-1; Wed, 10 Dec 2025 13:45:52 -0500
X-MC-Unique: ofSba8BSNbmYQGmU-7VhZw-1
X-Mimecast-MFC-AGG-ID: ofSba8BSNbmYQGmU-7VhZw_1765392352
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-340ad9349b3so299443a91.1
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 10:45:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765392351; x=1765997151;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sMS+Q+wF/hCn/MwWLwr4ed1U6EOVDi5hMKamvBt1DII=;
 b=GDMbYT0Zo31FZcOxzuv+CRUXQ1AALQy/HqJgk4wgAPI2YRSZhmkb/4bmDVXP34EnZN
 0ruQwrCwsfTRm5mshb+cD8SkvFSGTOQWEBpeb6ssgQ9bmMAGjXzoIY2LC/mn8dIkqZg+
 Cd41BntQJbulzTD3y4JIzYHv32IvLf7H2uPSRpxT+ykllNbvzonJ6J79lfCiClW+5mfv
 /vrvBzaCxeaZT07F8pcddAvvKLpTuVUekmcYwNp6QOpBFm+Hnf+o3JM2zItZy6xg6vHa
 jEiwP8wb8zBYwtlTZVc6hEjJQ4MbUMnfNcXRQMnTJQO1olOR46zOburqOiAKx+jYFGG/
 M96w==
X-Gm-Message-State: AOJu0YyIqIx+uFPupEMKmHXB/ohTJR0VLRPEDXbpWXKqLJol10Xyidp5
 z7JOeUPiVh/NB8V1DMCWWRoWy+qaMLY+h1lPGnrZ7OkVWW8dOefakTYeHQZwkB5hqIuFYf7V8rv
 miGtM2oFYr/l5GSP9iQ+/JA29Okil8I1lEr8B6iKluIPY6KE/C+vNjFXXniOiSlYv
X-Gm-Gg: AY/fxX6iwSKt3mHTZp68MooiPxn8OSWIgwlyYJ/9IzwhlnV20LsU4sQonJ76kyycxvd
 mK+z+ntvfm1ppNU7XAIDCqVDyFfNo6v67le+r42/I6mYnTyQ625py17rxulY7bVMbkSzkcKIWm3
 ERW9rxUgE3itbB0qy4EshfQ4gMReLx7jsKu3Cdv1TRs0D+nh8bHnNeVqy840Kdz+tPupv+NQXqy
 OyPr5uk9nXZv3+QLCpzmc9VlHimA2KBcH7hfZS5DnrKYOIsUklQMDs3dMZOUtqv7L6OffIR+BY4
 zDU9xbn1QKiut+MQuVhyhVA9VsdqG+k5iAPaPrzxtB2kTamke4vzazxH9kawQ9ENFs6VIxBc5iE
 Vg8Sx++YfsvDPQdaDWQ7PP5F4Y9NqktAAJbVb8FGmgamBEPiB7/Ycej0Ufw==
X-Received: by 2002:a17:90b:1652:b0:343:6a79:6c75 with SMTP id
 98e67ed59e1d1-34a72885eecmr3361363a91.29.1765392351425; 
 Wed, 10 Dec 2025 10:45:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhKxYByZS4f0rrYGWGJy5Zy4BJO9Wako6wTfGp19VHDrVUB4vTdDdNWG3lV6arEXR4RTj57Q==
X-Received: by 2002:a17:90b:1652:b0:343:6a79:6c75 with SMTP id
 98e67ed59e1d1-34a72885eecmr3361338a91.29.1765392350888; 
 Wed, 10 Dec 2025 10:45:50 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34a6ff019f0sm3206875a91.1.2025.12.10.10.45.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Dec 2025 10:45:50 -0800 (PST)
Message-ID: <629e6b11-069e-45c9-9119-b310db85a82d@redhat.com>
Date: Wed, 10 Dec 2025 19:45:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC RESEND v5 4/4] tests/qtest: Add SMMUv3 bare-metal test using
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
References: <20251126154547.1300748-1-tangtao1634@phytium.com.cn>
 <20251126154547.1300748-5-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251126154547.1300748-5-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 11/26/25 4:45 PM, Tao Tang wrote:
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
> ---
>  tests/qtest/iommu-smmuv3-test.c | 114 ++++++++++++++++++++++++++++++++
>  tests/qtest/meson.build         |   1 +
>  2 files changed, 115 insertions(+)
>  create mode 100644 tests/qtest/iommu-smmuv3-test.c
>
> diff --git a/tests/qtest/iommu-smmuv3-test.c b/tests/qtest/iommu-smmuv3-test.c
> new file mode 100644
> index 0000000000..af438ecce0
> --- /dev/null
> +++ b/tests/qtest/iommu-smmuv3-test.c
> @@ -0,0 +1,114 @@
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
> +/* Test configurations for different SMMU modes and spaces */
> +static const QSMMUTestConfig base_test_configs[] = {
> +    {
> +        .trans_mode = QSMMU_TM_S1_ONLY,
> +        .sec_sid = QSMMU_SEC_SID_NONSECURE,
> +        .dma_iova = QSMMU_IOVA_OR_IPA,
what does this mean? QSMMU_IOVA_OR_IPA

Eric
> +        .dma_len = DMA_LEN,
> +        .expected_result = 0
> +    },
> +    {
> +        .trans_mode = QSMMU_TM_S2_ONLY,
> +        .sec_sid = QSMMU_SEC_SID_NONSECURE,
> +        .dma_iova = QSMMU_IOVA_OR_IPA,
> +        .dma_len = DMA_LEN,
> +        .expected_result = 0
> +    },
> +    {
> +        .trans_mode = QSMMU_TM_NESTED,
> +        .sec_sid = QSMMU_SEC_SID_NONSECURE,
> +        .dma_iova = QSMMU_IOVA_OR_IPA,
> +        .dma_len = DMA_LEN,
> +        .expected_result = 0
> +    }
> +};
> +
> +static QPCIDevice *setup_qtest_pci_device(QTestState *qts, QGenericPCIBus *gbus,
> +                                          QPCIBar *bar)
> +{
> +    uint16_t vid, did;
> +    QPCIDevice *dev = NULL;
> +
> +    qpci_init_generic(gbus, qts, NULL, false);
> +
> +    /* Find device by vendor/device ID to avoid slot surprises. */
> +    for (int s = 0; s < 32 && !dev; s++) {
> +        for (int fn = 0; fn < 8 && !dev; fn++) {
> +            QPCIDevice *cand = qpci_device_find(&gbus->bus, QPCI_DEVFN(s, fn));
> +            if (!cand) {
> +                continue;
> +            }
> +            vid = qpci_config_readw(cand, PCI_VENDOR_ID);
> +            did = qpci_config_readw(cand, PCI_DEVICE_ID);
> +            if (vid == IOMMU_TESTDEV_VENDOR_ID &&
> +                did == IOMMU_TESTDEV_DEVICE_ID) {
> +                dev = cand;
> +                g_test_message("Found iommu-testdev! devfn: 0x%x", cand->devfn);
> +            } else {
> +                g_free(cand);
> +            }
> +        }
> +    }
> +    g_assert(dev);
> +
> +    qpci_device_enable(dev);
> +    *bar = qpci_iomap(dev, 0, NULL);
> +    g_assert_false(bar->is_io);
> +
> +    return dev;
> +}
> +
> +static void test_smmuv3_translation(void)
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
> +    /* Run the enhanced translation tests */
> +    g_test_message("### Starting SMMUv3 translation tests...###");
> +    qsmmu_translation_batch(base_test_configs, ARRAY_SIZE(base_test_configs),
> +                            qts, dev, bar, VIRT_SMMU_BASE);
> +    g_test_message("### SMMUv3 translation tests completed successfully! ###");
> +    qtest_quit(qts);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +    qtest_add_func("/iommu-testdev/translation", test_smmuv3_translation);
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
>    qtests_cxl +                                                                                  \
>    ['arm-cpu-features',
>     'numa-test',


