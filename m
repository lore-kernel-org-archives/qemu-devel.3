Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C261BCD98CC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 12:52:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXetN-0007Ls-Rs; Thu, 11 Jun 2026 08:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wXetI-0007LQ-Ao
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 08:52:13 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wXetG-00043n-2A
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 08:52:12 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65BCpvEo068154
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 11 Jun 2026 21:51:57 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=I1FpxiGyJEaRAaJS7TW3i3gvw4E+i7sYFyXio9k1S9A=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1781182317; v=1;
 b=ehkeuyl2K/TYX59XVmZWXv3ugTskqcrp6I7yyq4eNthc0O7cg4t2csszQTMOTDdE
 +tjS4D6eeW6sMam0IPJ0pRcpavtfW23qWo58kk5xoxVZdVHfNSTmyj1i04f/w955
 XdWLCmtA8iw0M3XvxFMt/AQe0Zy/kGlRbIAPk9/jleOmTOL0KjV0A2FiJpz/1qgk
 3Nr+tHp8hcEH1bpHsjPlPsfvmbpIIp3Rh/aJEimDfhTswzCqJl81gqx7YBSghrwu
 PGCEpULSNnxSQwYjhHW2szrx1TWWHrNdsgjyOicoX1PKdS36NA1myu4eZoKMcItG
 DXckISZKFAAAwpTGJBZVoQ==
Message-ID: <19f575cd-1716-460b-bb4c-49ff81226afb@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 11 Jun 2026 21:51:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] igb: Add a test for Transmit Rate Limiter
To: Josh Hilke <jrhilke@google.com>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
References: <20260611023028.102071-1-jrhilke@google.com>
 <20260611023028.102071-6-jrhilke@google.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260611023028.102071-6-jrhilke@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/06/11 11:30, Josh Hilke wrote:
> Add a test for the IGB transmit rate limiting functionality. The test
> verifies that TRL is enabled by setting the appropriate registers and
> that data is transmitted at the appropriate rate based on chosen
> target rate.
> 
> Signed-off-by: Josh Hilke <jrhilke@google.com>
> ---
>   tests/qtest/igb-test.c | 161 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 161 insertions(+)
> 
> diff --git a/tests/qtest/igb-test.c b/tests/qtest/igb-test.c
> index 3d397ea..9c93abf 100644
> --- a/tests/qtest/igb-test.c
> +++ b/tests/qtest/igb-test.c
> @@ -34,9 +34,11 @@
>   #include "qemu/iov.h"
>   #include "qemu/module.h"
>   #include "qemu/bitops.h"
> +#include "qemu/timer.h"
>   #include "libqos/libqos-malloc.h"
>   #include "libqos/e1000e.h"
>   #include "hw/net/igb_regs.h"
> +#include "hw/pci/pci_regs.h"
>   
>   #ifndef _WIN32
>   
> @@ -45,6 +47,71 @@ static const struct eth_header packet = {
>       .h_source = E1000E_ADDRESS,
>   };
>   
> +/*
> + * Calculate TRL rate factor for a given target rate.
> + *
> + * Rate Factor = 1 Gbps / Target Rate.
> + *
> + * The hardware TRLRC register stores the rate factor as a fixed-point number
> + * with 14 fractional bits. Scale 1Gbps by 2^14 before dividing to preserve
> + * precision in integer arithmetic.
> + */
> +static uint32_t igb_trl_get_rate_factor(uint64_t rate_bytes_s)
> +{
> +    return (E1000_LINK_RATE_1GBPS << 14) / rate_bytes_s;
> +}
> +
> +static void igb_trl_enable(QE1000E *d, uint64_t rate_bytes_s)
> +{
> +    /* Select Queue 0 */
> +    e1000e_macreg_write(d, E1000_TRLDQSEL, 0);
> +    /* Enable TRL with target rate */
> +    e1000e_macreg_write(d, E1000_TRLRC,
> +                    E1000_TRLRC_RS_ENA | igb_trl_get_rate_factor(rate_bytes_s));

Indents are somewhat off in this file.

Regards,
Akihiko Odaki

> +}
> +
> +static void igb_trl_disable(QE1000E *d)
> +{
> +    /* Select Queue 0 */
> +    e1000e_macreg_write(d, E1000_TRLDQSEL, 0);
> +    /* Disable TRL */
> +    e1000e_macreg_write(d, E1000_TRLRC, 0);
> +}
> +
> +static void igb_msix_clear_pending(QPCIDevice *dev, uint16_t entry)
> +{
> +    uint64_t vector_offset =
> +        dev->msix_table_off + (entry * PCI_MSIX_ENTRY_SIZE);
> +    uint32_t val = qpci_io_readl(dev, dev->msix_table_bar,
> +                                vector_offset + PCI_MSIX_ENTRY_VECTOR_CTRL);
> +
> +    /* Unmask (clears pending bit in QEMU) */
> +    qpci_io_writel(dev, dev->msix_table_bar,
> +                    vector_offset + PCI_MSIX_ENTRY_VECTOR_CTRL,
> +                    val & ~PCI_MSIX_ENTRY_CTRL_MASKBIT);
> +
> +    /* Mask again */
> +    qpci_io_writel(dev, dev->msix_table_bar,
> +                    vector_offset + PCI_MSIX_ENTRY_VECTOR_CTRL,
> +                    val | PCI_MSIX_ENTRY_CTRL_MASKBIT);
> +}
> +
> +static void igb_read_tx_tail(QE1000E *d, void *descr)
> +{
> +    QE1000E_PCI *d_pci = container_of(d, QE1000E_PCI, e1000e);
> +    uint32_t last_entry;
> +    uint32_t tail;
> +    uint32_t len;
> +
> +    tail = e1000e_macreg_read(d, E1000_TDT_A(0));
> +    len = e1000e_macreg_read(d, E1000_TDLEN_A(0)) / E1000_RING_DESC_LEN;
> +    last_entry = (tail + len - 1) % len;
> +
> +    qtest_memread(d_pci->pci_dev.bus->qts,
> +                    d->tx_ring + last_entry * E1000_RING_DESC_LEN, descr,
> +                    E1000_RING_DESC_LEN);
> +}
> +
>   static void igb_send_verify(QE1000E *d, int *test_sockets, QGuestAllocator *alloc)
>   {
>       union e1000_adv_tx_desc descr;
> @@ -70,6 +137,14 @@ static void igb_send_verify(QE1000E *d, int *test_sockets, QGuestAllocator *allo
>       /* Wait for TX WB interrupt */
>       e1000e_wait_isr(d, E1000E_TX0_MSG_ID);
>   
> +    /*
> +     * Read the descriptor back from guest memory again, now that WB has
> +     * occurred. This is required because if the packet was delayed by the
> +     * trasmit rate limiter, e1000e_tx_ring_push read it back before QEMU
> +     * actually processed it.
> +     */
> +    igb_read_tx_tail(d, &descr);
> +
>       /* Check DD bit */
>       g_assert_cmphex(le32_to_cpu(descr.wb.status) & E1000_TXD_STAT_DD, ==,
>                       E1000_TXD_STAT_DD);
> @@ -133,6 +208,29 @@ static void igb_receive_verify(QE1000E *d, int *test_sockets, QGuestAllocator *a
>       guest_free(alloc, data);
>   }
>   
> +/* Returns the amount of microseconds it takes to transmit a 64-byte packet.*/
> +static uint64_t igb_send_and_measure(QE1000E *d, int *test_sockets,
> +                                     QGuestAllocator *alloc)
> +{
> +    QE1000E_PCI *d_pci = container_of(d, QE1000E_PCI, e1000e);
> +    QPCIDevice *pdev = &d_pci->pci_dev;
> +    QTestState *qts = global_qtest;
> +    uint64_t start_time, end_time;
> +
> +    /* Clear any stale pending interrupt for this vector before we start */
> +    igb_msix_clear_pending(pdev, E1000E_TX0_MSG_ID);
> +
> +    /* Clear EICR to allow new interrupts to be raised in MSI-X mode */
> +    e1000e_macreg_write(d, E1000_EICR, 0xFFFFFFFF);
> +
> +    /* Send a test packet and measure the time it takes. */
> +    start_time = qtest_clock_step(qts, 1);
> +    igb_send_verify(d, test_sockets, alloc);
> +    end_time = qtest_clock_step(qts, 1);
> +
> +    return end_time - start_time;
> +}
> +
>   static void test_e1000e_init(void *obj, void *data, QGuestAllocator * alloc)
>   {
>       /* init does nothing */
> @@ -191,6 +289,67 @@ static void test_igb_multiple_transfers(void *obj, void *data,
>   
>   }
>   
> +static void test_igb_transmit_rate_limiter(void *obj, void *data,
> +                                           QGuestAllocator *alloc)
> +{
> +    QOSGraphObject *e_object = obj;
> +    QE1000E_PCI *e1000e = obj;
> +    QPCIDevice *dev = e_object->get_driver(e_object, "pci-device");
> +    QE1000E *d = &e1000e->e1000e;
> +    const uint64_t expected_baseline_elapsed = 10 * SCALE_US;
> +    const uint64_t expected_max_elapsed = 530 * SCALE_US;
> +    const uint64_t expected_min_elapsed = 500 * SCALE_US;
> +    uint64_t elapsed;
> +
> +    if (qpci_check_buggy_msi(dev)) {
> +        return;
> +    }
> +
> +    /* Send a test packet to verify there's no rate limit. */
> +    elapsed = igb_send_and_measure(d, data, alloc);
> +
> +    /*
> +     * QEMU doesn't emulate the hardware line rate of the device, so the packet
> +     * is processed instantly (requiring 0 clock steps in wait_isr, which steps
> +     * by 10us). Give a 10us margin for error.
> +     */
> +    g_assert_cmpint(elapsed, <, expected_baseline_elapsed);
> +
> +    /*
> +     * Enable TRL and set the target rate to:
> +     * (E1000_LINK_RATE_1GBPS / 1000) = 125 KB/s.
> +     */
> +    igb_trl_enable(d, E1000_LINK_RATE_1GBPS / 1000);
> +
> +    /*
> +     * Send Packet 1 (no delay)
> +     * The first packet triggers rate limiting for subsequent transmissions.
> +     */
> +    elapsed = igb_send_and_measure(d, data, alloc);
> +    g_assert_cmpint(elapsed, <, expected_baseline_elapsed);
> +
> +    /* Send Packet 2 (should be delayed) */
> +    elapsed = igb_send_and_measure(d, data, alloc);
> +    /*
> +     * Expected delay: 64 byte packet / 125 KB/s = 512 us.
> +     * Since QEMU steps the clock by 10 us on each wait_isr iteration,
> +     * the delay is rounded up to the next 10 us step, which is 520 us.
> +     */
> +    g_assert_cmpint(elapsed, >=, expected_min_elapsed);
> +    g_assert_cmpint(elapsed, <=, expected_max_elapsed);
> +
> +    /* Send Packet 3 (should also be delayed) */
> +    elapsed = igb_send_and_measure(d, data, alloc);
> +    g_assert_cmpint(elapsed, >=, expected_min_elapsed);
> +    g_assert_cmpint(elapsed, <=, expected_max_elapsed);
> +
> +    igb_trl_disable(d);
> +
> +    /* Send Packet 4 (no delay since TRL is disabled) */
> +    elapsed = igb_send_and_measure(d, data, alloc);
> +    g_assert_cmpint(elapsed, <, expected_baseline_elapsed);
> +}
> +
>   static void data_test_clear(void *sockets)
>   {
>       int *test_sockets = sockets;
> @@ -247,6 +406,8 @@ static void register_igb_test(void)
>       qos_add_test("rx", "igb", test_igb_rx, &opts);
>       qos_add_test("multiple_transfers", "igb",
>                    test_igb_multiple_transfers, &opts);
> +    qos_add_test("transmit_rate_limiter", "igb",
> +                 test_igb_transmit_rate_limiter, &opts);
>   #endif
>   
>       opts.before = data_test_init_no_socket;


