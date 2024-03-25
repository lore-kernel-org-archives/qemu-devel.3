Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C8A4C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 09:40:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rogo1-0001ca-IJ; Mon, 25 Mar 2024 05:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=rDMc=K7=kaod.org=clg@ozlabs.org>)
 id 1rognz-0001cL-F3; Mon, 25 Mar 2024 05:39:47 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=rDMc=K7=kaod.org=clg@ozlabs.org>)
 id 1rognr-0006Tg-A2; Mon, 25 Mar 2024 05:39:47 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4V37Dz4LZ8z4wcd;
 Mon, 25 Mar 2024 20:39:31 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4V37Dv31KKz4wbv;
 Mon, 25 Mar 2024 20:39:27 +1100 (AEDT)
Message-ID: <3fc15c01-82d4-4243-b6fd-95cb9d2f5548@kaod.org>
Date: Mon, 25 Mar 2024 10:39:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] qtest/phb4: Add testbench for PHB4
To: Saif Abrar <saif.abrar@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com
References: <20240321100422.5347-1-saif.abrar@linux.vnet.ibm.com>
 <20240321100422.5347-2-saif.abrar@linux.vnet.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240321100422.5347-2-saif.abrar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=rDMc=K7=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Saif,

On 3/21/24 11:04, Saif Abrar wrote:
> New qtest TB added for PHB4.
> TB reads PHB Version register and asserts that
> bits[24:31] have value 0xA5.
> 
> Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
> ---
>   tests/qtest/meson.build     |  1 +
>   tests/qtest/pnv-phb4-test.c | 74 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 75 insertions(+)
>   create mode 100644 tests/qtest/pnv-phb4-test.c
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 36c5c13a7b..4795e51c17 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -168,6 +168,7 @@ qtests_ppc64 = \
>     (config_all_devices.has_key('CONFIG_PSERIES') ? ['device-plug-test'] : []) +               \
>     (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-xscom-test'] : []) +                 \
>     (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-host-i2c-test'] : []) +              \
> +  (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-phb4-test'] : []) +                  \
>     (config_all_devices.has_key('CONFIG_PSERIES') ? ['rtas-test'] : []) +                      \
>     (slirp.found() ? ['pxe-test'] : []) +              \
>     (config_all_devices.has_key('CONFIG_USB_UHCI') ? ['usb-hcd-uhci-test'] : []) +             \
> diff --git a/tests/qtest/pnv-phb4-test.c b/tests/qtest/pnv-phb4-test.c
> new file mode 100644
> index 0000000000..e3b809e9c4
> --- /dev/null
> +++ b/tests/qtest/pnv-phb4-test.c
> @@ -0,0 +1,74 @@
> +/*
> + * QTest testcase for PowerNV PHB4
> + *
> + * Copyright (c) 2024, IBM Corporation.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +#include "hw/pci-host/pnv_phb4_regs.h"
> +
> +#define P10_XSCOM_BASE          0x000603fc00000000ull
> +#define PHB4_MMIO               0x000600c3c0000000ull
> +#define PHB4_XSCOM              0x8010900ull
> +
> +#define PPC_BIT(bit)            (0x8000000000000000ULL >> (bit))
> +#define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(bs))
> +
> +static uint64_t pnv_xscom_addr(uint32_t pcba)
> +{
> +    return P10_XSCOM_BASE | ((uint64_t) pcba << 3);
> +}
> +
> +static uint64_t pnv_phb4_xscom_addr(uint32_t reg)
> +{
> +    return pnv_xscom_addr(PHB4_XSCOM + reg);
> +}

Please use tests/qtest/pnv-xscom.h instead.

> +/*
> + * XSCOM read/write is indirect in PHB4:
> + * Write 'SCOM - HV Indirect Address Register'
> + * with register-offset to read/write.
> +   - bit[0]: Valid Bit
> +   - bit[51:61]: Indirect Address(00:10)
> + * Read/write 'SCOM - HV Indirect Data Register' to get/set the value.
> + */
> +
> +static uint64_t pnv_phb4_xscom_read(QTestState *qts, uint32_t reg)
> +{
> +    qtest_writeq(qts, pnv_phb4_xscom_addr(PHB_SCOM_HV_IND_ADDR),
> +            PPC_BIT(0) | reg);
> +    return qtest_readq(qts, pnv_phb4_xscom_addr(PHB_SCOM_HV_IND_DATA));
> +}

> +/* Assert that 'PHB - Version Register Offset 0x0800' bits-[24:31] are 0xA5 */
> +static void phb4_version_test(QTestState *qts)
> +{
> +    uint64_t ver = pnv_phb4_xscom_read(qts, PHB_VERSION);
> +
> +    /* PHB Version register [24:31]: Major Revision ID 0xA5 */
> +    ver = ver >> (63 - 31);
> +    g_assert_cmpuint(ver, ==, 0xA5);
> +}
> +
> +static void test_phb4(void)
> +{
> +    QTestState *qts = NULL;
> +
> +    qts = qtest_initf("-machine powernv10 -accel tcg -nographic -d unimp");

"-nographic -d unimp" is not needed.

> +
> +    /* Make sure test is running on PHB */
> +    phb4_version_test(qts);

Please add similar tests for phb[345]. See tests/qtest/pnv-xscom-test.c.

Thanks,

C.


> +
> +    qtest_quit(qts);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +    qtest_add_func("phb4", test_phb4);
> +    return g_test_run();
> +}


