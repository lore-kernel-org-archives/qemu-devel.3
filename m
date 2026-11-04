Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC63606D83B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 09:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.a=rsa-sha256 header.s=rs20250326 header.b=hGlzZAZ4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOX4t-0007qz-G2; Wed, 04 Nov 2026 04:14:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xOX4n-0007pw-8e
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 04:14:37 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xOX4j-0007UX-2T
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 04:14:36 -0500
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6A49EMRa061723
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 4 Nov 2026 18:14:22 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=yZVkgGU3Ae6jkwkvFu5kw1PQ5JTq5t/sLV9sNNKrSN0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1793783662; v=1;
 b=hGlzZAZ4NG3ca89mxHN8Ym3MFb7rvtwYno/OTepjd5QWXIxXuadxY5YDyIQskqlg
 La+O8X02GmoOsZFzdHi8tDDIUvXTDcWUYpHnr/I0vlqJoDFeuQ+TUG9jOOg4GW6/
 SYxBY0unV1psBHBpqa6EzvEhLvJFRNGfSwJTUJWVheao+niGCV3S2Id+RovkD2Bd
 BaZH9iYFnelmIN4b+F4JpbC9JHyAT+HUxjKbMcHHNlau3HYs3mTGISIvfP3j8hmD
 4ZvJO+giwnhrcYIZzWghCWpLDTaKS7JPBOBJHdsDw4AqFRDuvMeRhgrG81HqKiw4
 7DPaWX7dzAh2eUUa7RTuIQ==
Message-ID: <f3a8a416-e5ad-42b5-8800-cd5879a34e4d@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 4 Nov 2026 18:14:21 +0900
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] tests/qtest: Add Cnuas virtual network adapter
 tests
To: Weqaar Janjua <weqaar.janjua@packetfive.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, peter.maydell@linaro.org, mst@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, jasowangio@gmail.com,
 pbonzini@redhat.com, farosas@suse.de, lvivier@redhat.com
References: <20260929202358.725310-1-weqaar.janjua@packetfive.com>
 <20260929202358.725310-4-weqaar.janjua@packetfive.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260929202358.725310-4-weqaar.janjua@packetfive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026/09/30 5:23, Weqaar Janjua wrote:
> Cover PCI identity, register reset, DMA, and packet transport.
> 
> Signed-off-by: Weqaar Janjua <weqaar.janjua@packetfive.com>
> ---
>   MAINTAINERS                   |   1 +
>   tests/qtest/cnuas-vnic-test.c | 233 ++++++++++++++++++++++++++++++++++
>   tests/qtest/meson.build       |   1 +
>   3 files changed, 235 insertions(+)
>   create mode 100644 tests/qtest/cnuas-vnic-test.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index efcb15c52d..7be5622f23 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2778,6 +2778,7 @@ M: Weqaar Janjua <weqaar.janjua@packetfive.com>
>   S: Maintained
>   F: docs/specs/cnuas-vnic.rst
>   F: hw/net/cnuas_vnic.c
> +F: tests/qtest/cnuas-vnic-test.c
>   
>   VMware
>   M: Dmitry Fleytman <dmitry.fleytman@gmail.com>
> diff --git a/tests/qtest/cnuas-vnic-test.c b/tests/qtest/cnuas-vnic-test.c
> new file mode 100644
> index 0000000000..fc27b7fa8e
> --- /dev/null
> +++ b/tests/qtest/cnuas-vnic-test.c
> @@ -0,0 +1,233 @@
> +/*
> + * QTest for the Cnuas virtual network adapter
> + *
> + * Copyright (c) 2026 PacketFive
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/pci/pci.h"
> +#include "hw/pci/pci_regs.h"
> +#include "libqos/pci.h"
> +#include "libqos/pci-pc.h"
> +#include "libqtest.h"
> +
> +#include <sys/socket.h>
> +#include <sys/un.h>
> +
> +#define CNUAS_VNIC_DEVFN           QPCI_DEVFN(4, 0)
> +#define CNUAS_VNIC_BAR_SIZE        4096
> +#define CNUAS_VNIC_REG_TX_ADDR_LO  0x00
> +#define CNUAS_VNIC_REG_TX_ADDR_HI  0x04
> +#define CNUAS_VNIC_REG_TX_LEN      0x08
> +#define CNUAS_VNIC_REG_TX_DOORBELL 0x0c
> +#define CNUAS_VNIC_REG_RX_ADDR_LO  0x10
> +#define CNUAS_VNIC_REG_RX_ADDR_HI  0x14
> +#define CNUAS_VNIC_REG_RX_LEN      0x18
> +#define CNUAS_VNIC_REG_RX_STATUS   0x1c
> +#define CNUAS_VNIC_REG_IRQ_STATUS  0x20
> +#define CNUAS_VNIC_REG_IRQ_MASK    0x24
> +#define CNUAS_VNIC_REG_LINK_STATUS 0x28
> +#define CNUAS_VNIC_REG_MAC_LO      0x2c
> +#define CNUAS_VNIC_REG_MAC_HI      0x30
> +
> +typedef struct CnuasVnicTest {
> +    QTestState *qts;
> +    QPCIBus *bus;
> +    QPCIDevice *dev;
> +    QPCIBar bar;
> +} CnuasVnicTest;
> +
> +static void cnuas_vnic_test_start_with_args(CnuasVnicTest *test,
> +                                            const char *args)
> +{
> +    uint64_t bar_size;
> +
> +    test->qts = qtest_initf("-machine q35 "
> +                            "-device cnuas-vnic,addr=04.0,"
> +                            "mac=02:11:22:33:44:55%s", args);
> +    test->bus = qpci_new_pc(test->qts, NULL);
> +    test->dev = qpci_device_find(test->bus, CNUAS_VNIC_DEVFN);
> +    g_assert_nonnull(test->dev);
> +    qpci_device_enable(test->dev);
> +    test->bar = qpci_iomap(test->dev, 0, &bar_size);
> +    g_assert_cmpuint(bar_size, ==, CNUAS_VNIC_BAR_SIZE);
> +}
> +
> +static void cnuas_vnic_test_start(CnuasVnicTest *test)
> +{
> +    cnuas_vnic_test_start_with_args(test, "");
> +}
> +
> +static void cnuas_vnic_test_stop(CnuasVnicTest *test)
> +{
> +    g_free(test->dev);
> +    qpci_free_pc(test->bus);
> +    qtest_quit(test->qts);
> +}
> +
> +static void cnuas_vnic_test_pci_config(void)
> +{
> +    CnuasVnicTest test;
> +
> +    cnuas_vnic_test_start(&test);
> +
> +    g_assert_cmphex(qpci_config_readw(test.dev, PCI_VENDOR_ID), ==,
> +                    PCI_VENDOR_ID_REDHAT);
> +    g_assert_cmphex(qpci_config_readw(test.dev, PCI_DEVICE_ID), ==,
> +                    PCI_DEVICE_ID_REDHAT_CNUASNIC);
> +    g_assert_cmphex(qpci_config_readw(test.dev, PCI_CLASS_DEVICE), ==,
> +                    PCI_CLASS_NETWORK_OTHER);
> +    g_assert_cmphex(qpci_config_readb(test.dev, PCI_REVISION_ID), ==, 1);
> +    g_assert_cmphex(qpci_find_capability(test.dev, PCI_CAP_ID_MSI, 0), !=, 0);
> +
> +    cnuas_vnic_test_stop(&test);
> +}
> +
> +static void cnuas_vnic_test_registers(void)
> +{
> +    CnuasVnicTest test;
> +
> +    cnuas_vnic_test_start(&test);
> +
> +    g_assert_cmphex(qpci_io_readl(test.dev, test.bar,
> +                                  CNUAS_VNIC_REG_LINK_STATUS), ==, 0);
> +    g_assert_cmphex(qpci_io_readl(test.dev, test.bar,
> +                                  CNUAS_VNIC_REG_IRQ_STATUS), ==, 0);
> +    g_assert_cmphex(qpci_io_readl(test.dev, test.bar,
> +                                  CNUAS_VNIC_REG_MAC_LO), ==, 0x33221102);
> +    g_assert_cmphex(qpci_io_readl(test.dev, test.bar,
> +                                  CNUAS_VNIC_REG_MAC_HI), ==, 0x5544);
> +
> +    qpci_io_writel(test.dev, test.bar, CNUAS_VNIC_REG_TX_ADDR_LO,
> +                   0x89abcdef);
> +    qpci_io_writel(test.dev, test.bar, CNUAS_VNIC_REG_TX_ADDR_HI,
> +                   0x01234567);
> +    qpci_io_writel(test.dev, test.bar, CNUAS_VNIC_REG_TX_LEN, 4096);
> +    qpci_io_writel(test.dev, test.bar, CNUAS_VNIC_REG_IRQ_MASK, 7);
> +
> +    g_assert_cmphex(qpci_io_readl(test.dev, test.bar,
> +                                  CNUAS_VNIC_REG_TX_ADDR_LO), ==,
> +                    0x89abcdef);
> +    g_assert_cmphex(qpci_io_readl(test.dev, test.bar,
> +                                  CNUAS_VNIC_REG_TX_ADDR_HI), ==,
> +                    0x01234567);
> +    g_assert_cmphex(qpci_io_readl(test.dev, test.bar,
> +                                  CNUAS_VNIC_REG_TX_LEN), ==, 4096);
> +    g_assert_cmphex(qpci_io_readl(test.dev, test.bar,
> +                                  CNUAS_VNIC_REG_IRQ_MASK), ==, 7);
> +
> +    qtest_system_reset(test.qts);

System reset clears BAR0; qpci_device_enable() restores only command 
bits. The cached BAR address therefore returns zero without accessing 
the device, making every reset assertion pass falsely.

> +    qpci_device_enable(test.dev);
> +
> +    g_assert_cmphex(qpci_io_readl(test.dev, test.bar,
> +                                  CNUAS_VNIC_REG_TX_ADDR_LO), ==, 0);
> +    g_assert_cmphex(qpci_io_readl(test.dev, test.bar,
> +                                  CNUAS_VNIC_REG_TX_ADDR_HI), ==, 0);
> +    g_assert_cmphex(qpci_io_readl(test.dev, test.bar,
> +                                  CNUAS_VNIC_REG_TX_LEN), ==, 0);
> +    g_assert_cmphex(qpci_io_readl(test.dev, test.bar,
> +                                  CNUAS_VNIC_REG_RX_STATUS), ==, 0);
> +    g_assert_cmphex(qpci_io_readl(test.dev, test.bar,
> +                                  CNUAS_VNIC_REG_IRQ_MASK), ==, 0);
> +
> +    cnuas_vnic_test_stop(&test);
> +}
> +
> +static int cnuas_vnic_test_listen(char **path)
> +{
> +    struct sockaddr_un address = { .sun_family = AF_UNIX };
> +    int fd;
> +
> +    *path = g_strdup_printf("/tmp/cnuas-vnic-test-%u.sock", getpid());
> +    unlink(*path);
> +    g_strlcpy(address.sun_path, *path, sizeof(address.sun_path));
> +
> +    fd = socket(AF_UNIX, SOCK_SEQPACKET, 0);
> +    g_assert_cmpint(fd, >=, 0);
> +    g_assert_cmpint(bind(fd, (struct sockaddr *)&address, sizeof(address)),
> +                    ==, 0);
> +    g_assert_cmpint(listen(fd, 1), ==, 0);
> +    return fd;
> +}
> +
> +static void cnuas_vnic_test_transport(void)
> +{
> +    static const uint8_t tx_frame[] = {
> +        0x02, 0, 0, 0, 0, 2, 0x02, 0, 0, 0, 0, 1, 0x08, 0,
> +        'C', 'n', 'u', 'a', 's',
> +    };
> +    static const uint8_t rx_frame[] = {
> +        0x02, 0, 0, 0, 0, 1, 0x02, 0, 0, 0, 0, 2, 0x08, 0,
> +        'R', 'D', 'M', 'A',
> +    };
> +    uint8_t result[64] = { 0 };
> +    const uint64_t tx_address = 0x100000;
> +    const uint64_t rx_address = 0x101000;
> +    g_autofree char *path = NULL;
> +    g_autofree char *args = NULL;
> +    CnuasVnicTest test;
> +    int connection;
> +    int listener;
> +    unsigned int i;
> +
> +    listener = cnuas_vnic_test_listen(&path);
> +    args = g_strdup_printf(",socket_path=%s", path);
> +    cnuas_vnic_test_start_with_args(&test, args);
> +    connection = accept(listener, NULL, NULL);
> +    g_assert_cmpint(connection, >=, 0);
> +
> +    g_assert_cmphex(qpci_io_readl(test.dev, test.bar,
> +                                  CNUAS_VNIC_REG_LINK_STATUS), ==, 1);
> +
> +    qtest_memwrite(test.qts, tx_address, tx_frame, sizeof(tx_frame));
> +    qpci_io_writel(test.dev, test.bar, CNUAS_VNIC_REG_TX_ADDR_LO,
> +                   tx_address);
> +    qpci_io_writel(test.dev, test.bar, CNUAS_VNIC_REG_TX_ADDR_HI,
> +                   tx_address >> 32);
> +    qpci_io_writel(test.dev, test.bar, CNUAS_VNIC_REG_TX_LEN,
> +                   sizeof(tx_frame));
> +    qpci_io_writel(test.dev, test.bar, CNUAS_VNIC_REG_TX_DOORBELL, 1);
> +
> +    g_assert_cmpint(recv(connection, result, sizeof(result), 0), ==,
> +                    sizeof(tx_frame));
> +    g_assert_cmpmem(result, sizeof(tx_frame), tx_frame, sizeof(tx_frame));
> +
> +    qpci_io_writel(test.dev, test.bar, CNUAS_VNIC_REG_RX_ADDR_LO,
> +                   rx_address);
> +    qpci_io_writel(test.dev, test.bar, CNUAS_VNIC_REG_RX_ADDR_HI,
> +                   rx_address >> 32);
> +    g_assert_cmpint(send(connection, rx_frame, sizeof(rx_frame), 0), ==,
> +                    sizeof(rx_frame));
> +
> +    for (i = 0; i < 1000; i++) {
> +        if (qpci_io_readl(test.dev, test.bar,
> +                          CNUAS_VNIC_REG_RX_STATUS) == 1) {
> +            break;
> +        }
> +        g_usleep(1000);
> +    }
> +    g_assert_cmpuint(i, <, 1000);
> +    g_assert_cmpuint(qpci_io_readl(test.dev, test.bar,
> +                                   CNUAS_VNIC_REG_RX_LEN), ==,
> +                     sizeof(rx_frame));
> +
> +    memset(result, 0, sizeof(result));
> +    qtest_memread(test.qts, rx_address, result, sizeof(rx_frame));
> +    g_assert_cmpmem(result, sizeof(rx_frame), rx_frame, sizeof(rx_frame));
> +
> +    close(connection);
> +    close(listener);
> +    unlink(path);
> +    cnuas_vnic_test_stop(&test);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +    qtest_add_func("/cnuas-vnic/pci-config", cnuas_vnic_test_pci_config);
> +    qtest_add_func("/cnuas-vnic/registers", cnuas_vnic_test_registers);
> +    qtest_add_func("/cnuas-vnic/transport", cnuas_vnic_test_transport);
> +    return g_test_run();
> +}
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 33f58b0e95..84d2fa702a 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -59,6 +59,7 @@ qtests_filter = \
>   qtests_i386 = \
>     (slirp.found() ? ['pxe-test'] : []) + \
>     qtests_filter + \
> +  (config_all_devices.has_key('CONFIG_CNUAS_VNIC') ? ['cnuas-vnic-test'] : []) +            \

The test always launches Q35, but its registration checks only CNUAS 
support. Kconfig permits CNUAS with CONFIG_Q35=n, so that configuration 
receives an unusable test.

Regards,
Akihiko Odaki

>     (config_all_devices.has_key('CONFIG_ACPI_VMGENID') ? ['vmgenid-test'] : []) +             \
>     (config_all_devices.has_key('CONFIG_AHCI_ICH9') and have_tools ? ['ahci-test'] : []) +    \
>     (config_all_devices.has_key('CONFIG_AHCI_ICH9') ? ['tco-test'] : []) +                    \


