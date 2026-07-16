Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79042C44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 14:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkMhQ-00023y-PR; Thu, 16 Jul 2026 10:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wkMhM-00023X-MD
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 10:04:24 -0400
Received: from smtpout8.mo536.mail-out.ovh.net ([51.210.91.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wkMhK-0001XU-5j
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 10:04:24 -0400
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo536.mail-out.ovh.net (Postfix) with ESMTPS id 4h1FCP4d39z87y9;
 Thu, 16 Jul 2026 14:04:17 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Thu, 16 Jul 2026 14:04:17 +0000 (UTC)
Received: from mta6.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.188.192])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4h1FCP3Wm4z1y44; Thu, 16 Jul 2026 14:04:17 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.4])
 (Authenticated sender: clg@kaod.org)
 by mta6.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id AA1691B43C7B;
 Thu, 16 Jul 2026 14:04:14 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-113S007e8815a55-d7be-40af-82a7-a9d10b32c296,
 816DE1EE18DD2826DFD8B9EE289546F56902E1FE) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <94ffa2a9-d534-4f65-8f77-2bbf8a745e99@kaod.org>
Date: Thu, 16 Jul 2026 16:04:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/5] hw/sensor: Add UCD90320 model
To: Mikail Sadic <mikail.sadic@ibm.com>, peter.maydell@linaro.org
Cc: pbonzini@redhat.com, ninad@linux.ibm.com, titusr@google.com,
 jeuk20.kim@samsung.com, philmd@mailo.com, steven_lee@aspeedtech.com,
 leetroy@gmail.com, jamin_lin@aspeedtech.com, kane_chen@aspeedtech.com,
 andrew@codeconstruct.com.au, joel@jms.id.au, calebs@us.ibm.com,
 milesg@ibm.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20260715155037.2237011-1-mikail.sadic@ibm.com>
 <20260715155037.2237011-4-mikail.sadic@ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260715155037.2237011-4-mikail.sadic@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 16492463312808160421
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFYu6RYzP0DpaOmksmukHbgT54jNuALVIu+GXs+psQ0E9dqEPGz6K+BD1P06cjkuSHa9lnSuVIiHgyfhznBXrT1tc5Fdmbeh6sDHwOxN34+81BkDOpNEdXP/OpUUEJuJXOaKzNxY5JqduiQrEuc8kHqDh1CtoWR9mIGk5/e5IEPmFpo/eN8C+BhIhJaltGqT3Ppg4+HCVfQitgKikZK0KCKElVjrIgVCa1NSjya/MNvDkOPkuDFtmejALNhtO/+4uidfwSmBPH6V52NJQGOUgql8wMglYc91g4uWF6AWFEqrUEcAai71cDCkLeHE7HHJrPbajZ1s0xn/U7VAER7bvAPEvsaMj5XORmgynh8pMV7nDYLsDdCUMkc8Mm5yjR4F3pmKR2DQy/UXtjGzXjUMsn/aRqqp4CRb0bb2TcoNFuh9wogK3YmZi6xX823gYq3Xy+fJM7pZwGMxJP6UV7OwOnxUU8WfJoBd7qMsx10YBY5WCgzJjUX4r6avrS0+6HlN+W2P3QN5/ib4rff0Y4v53nfPlOdcg1mkrsfYOqVwoYfTN4COT32hRV+cHMu/vfbfXfuiEwjry3l3m8ZT63I/+qAjWGiYCBgP/cOqq4cYn/nxK7MaqUMcoPZJ8SU85DAv/2A8czXgOLhTRhajwN9OI9B13dxjoR8yHFQlo2uE3eEdQ
DKIM-Signature: a=rsa-sha256; bh=RTRJ6unAapuQN1XfdoXsa+5k5dHZA9kpMYBWWBlFlDE=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1784210659; v=1;
 b=v5VhDm825rlU5HVC7Zj+5ipQPkCqmk2gNhmRU4xR4yR0C2EO8VmyGEFLJ8ArJMqU4Sxqt9ia
 QL+um66s89o8G02CgsLlx8u/gs3OJMJq1NEA89GidPEtk8F4LsW0JOVzp+IGEmXpvHHkLgXVSFL
 rg8ACTeE62ncYQythYvjz7petiOMvy0B67V6gRTWJkFIUzWHCL1f3KmGKOzYgf/LdKBONdI7nZ/
 e4xrbae9BSqKXgGmGBvLr8MDuNJbaNpRNc78YRJWh/UvC6kkApWnew58o+OzzuqZLVtnEK0lsWM
 UAAdQGYp0rzdAq+Wp5EFBlyB4Js1IilrxtjGEUUHcZUNA==
Received-SPF: pass client-ip=51.210.91.17; envelope-from=clg@kaod.org;
 helo=smtpout8.mo536.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 7/15/26 17:50, Mikail Sadic wrote:
> Add a PMBus device model for the TI-UCD90320 24-rail power
> sequencer. Configures 24 pages with linear vout mode and responds to
> the vendor-specific UCD9000_DEVICE_ID, NUM_PAGES, MONITOR_CONFIG, and
> MFR_STATUS commands, allowing the Linux ucd9000 driver to bind and
> create hwmon sysfs entries.
> 
> Signed-off-by: Mikail Sadic <mikail.sadic@ibm.com>
> ---
>   MAINTAINERS             |   1 +
>   docs/specs/index.rst    |   1 +
>   docs/specs/ucd90320.rst |  36 ++++++++++
>   hw/i2c/aspeed_i2c.c     |   7 ++
>   hw/sensor/ucd90320.c    | 144 ++++++++++++++++++++++++++++++++++++++++
>   hw/arm/Kconfig          |   1 +
>   hw/sensor/Kconfig       |   4 ++
>   hw/sensor/meson.build   |   1 +
>   8 files changed, 195 insertions(+)
>   create mode 100644 docs/specs/ucd90320.rst
>   create mode 100644 hw/sensor/ucd90320.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ecb8cfdc41..b2861dfc79 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4059,6 +4059,7 @@ F: hw/i2c/pmbus_device.c
>   F: hw/sensor/adm1272.c
>   F: hw/sensor/isl_pmbus_vr.c
>   F: hw/sensor/max34451.c
> +F: hw/sensor/ucd90320.c
>   F: include/hw/i2c/pmbus_device.h
>   F: include/hw/sensor/isl_pmbus_vr.h
>   F: tests/qtest/adm1272-test.c
> diff --git a/docs/specs/index.rst b/docs/specs/index.rst
> index b7909a108a..4de65e2fdf 100644
> --- a/docs/specs/index.rst
> +++ b/docs/specs/index.rst
> @@ -39,4 +39,5 @@ guest hardware that is specific to QEMU.
>      riscv-iommu
>      riscv-aia
>      aspeed-intc
> +   ucd90320
>      iommu-testdev
> diff --git a/docs/specs/ucd90320.rst b/docs/specs/ucd90320.rst
> new file mode 100644
> index 0000000000..fdc0878c75
> --- /dev/null
> +++ b/docs/specs/ucd90320.rst
> @@ -0,0 +1,36 @@
> +Texas Instruments UCD90320 Power Sequencer
> +==========================================
> +
> +The UCD90320 is a 24-rail PMBus power sequencer. QEMU models it as a PMBus
> +device (``"ucd90320"``) so the Linux ``ucd9000`` driver can bind and create
> +``hwmon`` sysfs entries.
> +
> +The model configures 24 PMBus pages (one per rail) with ``VOUT_MODE = 0x00``
> +(linear, exponent 0). ``READ_VOUT`` and ``MFR_STATUS`` return zero on all
> +pages.
> +
> +Vendor-specific commands handled:
> +
> ++------+---------------------------+--------------------------------------------+
> +| Code | Name                      | Response                                   |
> ++======+===========================+============================================+
> +| 0xD5 | ``UCD9000_MONITOR_CONFIG``| Block: one byte ``0x00``                   |
> ++------+---------------------------+--------------------------------------------+
> +| 0xD6 | ``UCD9000_NUM_PAGES``     | Byte: ``24``                               |
> ++------+---------------------------+--------------------------------------------+
> +| 0xF3 | ``UCD9000_MFR_STATUS``    | Block: four bytes ``0x00 0x00 0x00 0x00``  |
> ++------+---------------------------+--------------------------------------------+
> +| 0xFD | ``UCD9000_DEVICE_ID``     | Block: ASCII string ``"UCD90320"``         |
> ++------+---------------------------+--------------------------------------------+
> +
> +``DEVICE_ID`` uses the vendor-specific code ``0xFD`` rather than the standard
> +``PMBUS_IC_DEVICE_ID`` (``0xAD``), matching the Linux ``ucd9000`` probe
> +sequence.
> +
> +The UCD90320 is instantiated automatically in the ``huygens-bmc`` machine on
> +I2C bus 5 at address ``0x11``. To instantiate on a different Aspeed machine:
> +
> +.. code-block:: c
> +
> +  i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5),
> +                          "ucd90320", 0x11);
> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
> index 27afcaecee..facb54d27e 100644
> --- a/hw/i2c/aspeed_i2c.c
> +++ b/hw/i2c/aspeed_i2c.c
> @@ -365,6 +365,7 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
>       uint32_t reg_pool_ctrl = aspeed_i2c_bus_pool_ctrl_offset(bus);
>       uint32_t reg_byte_buf = aspeed_i2c_bus_byte_buf_offset(bus);
>       uint32_t reg_dma_len = aspeed_i2c_bus_dma_len_offset(bus);
> +    bool first_dma_byte;
>       int pool_rx_count = SHARED_ARRAY_FIELD_EX32(bus->regs, reg_pool_ctrl,
>                                                   RX_SIZE) + 1;
>   
> @@ -391,6 +392,7 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
>           }
>   
>           aspeed_i2c_set_rx_dma_dram_offset(bus);
> +        first_dma_byte = true;
>           while (bus->regs[reg_dma_len]) {
>               MemTxResult result;
>   
> @@ -407,6 +409,11 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
>                   return;
>               }
>   
> +            /* Mirror first byte to reg_byte_buf for I2C_M_RECV_LEN. */
> +            if (first_dma_byte) {
> +                SHARED_ARRAY_FIELD_DP32(bus->regs, reg_byte_buf, RX_BUF, data);
> +                first_dma_byte = false;
> +            }
>               bus->dma_dram_offset++;
>               bus->regs[reg_dma_len]--;
>               /* In new mode, keep track of how many bytes we RXed */


The I2C part belongs to another patch.


> diff --git a/hw/sensor/ucd90320.c b/hw/sensor/ucd90320.c
> new file mode 100644
> index 0000000000..f3b2a5d777
> --- /dev/null
> +++ b/hw/sensor/ucd90320.c
> @@ -0,0 +1,144 @@
> +/*
> + * Texas Instruments UCD90320 24-Rail PMBus Power Sequencer
> + *
> + * Copyright 2026 IBM Corp.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/i2c/pmbus_device.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +
> +#define TYPE_UCD90320 "ucd90320"
> +
> +/* UCD90320 has 24 sequenced power-rail pages */
> +#define UCD90320_NUM_PAGES 24
> +
> +/* Vendor-specific command codes (not in the standard PMBus register table) */
> +#define UCD9000_MONITOR_CONFIG  0xd5
> +#define UCD9000_NUM_PAGES       0xd6
> +#define UCD9000_MFR_STATUS      0xf3
> +#define UCD9000_DEVICE_ID       0xfd
> +
> +typedef struct UCD90320State {
> +    PMBusDevice parent;
> +} UCD90320State;
> +
> +static void ucd90320_send_block(PMBusDevice *pmdev,
> +                                const uint8_t *data, uint8_t len)
> +{
> +    int i;
> +
> +    pmdev->out_buf[len + pmdev->out_buf_len] = len;
> +    for (i = len - 1; i >= 0; i--) {
> +        pmdev->out_buf[i + pmdev->out_buf_len] = data[len - 1 - i];
> +    }
> +    pmdev->out_buf_len += len + 1;
> +}
> +
> +static uint8_t ucd90320_read_byte(PMBusDevice *pmdev)
> +{
> +    switch (pmdev->code) {
> +    case UCD9000_DEVICE_ID: {
> +        static const uint8_t id[] = "UCD90320";

this is hacky. use device constant reset values or class fields.
Same below.

> +        ucd90320_send_block(pmdev, id, sizeof(id) - 1);
> +        pmbus_idle(pmdev);
> +        return 0;
> +    }
> +    case UCD9000_NUM_PAGES:
> +        pmbus_send8(pmdev, UCD90320_NUM_PAGES);
> +        pmbus_idle(pmdev);
> +        return 0;
> +
> +    case UCD9000_MONITOR_CONFIG: {
> +        static const uint8_t cfg[] = { 0x00 };
> +        ucd90320_send_block(pmdev, cfg, sizeof(cfg));
> +        pmbus_idle(pmdev);
> +        return 0;
> +    }
> +    case UCD9000_MFR_STATUS: {
> +        static const uint8_t status[] = { 0x00, 0x00, 0x00, 0x00 };
> +        ucd90320_send_block(pmdev, status, sizeof(status));
> +        pmbus_idle(pmdev);
> +        return 0;
> +    }
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: reading from unsupported register: 0x%02x\n",
> +                      __func__, pmdev->code);
> +        break;
> +    }
> +    return 0xFF;
> +}
> +
> +static int ucd90320_write_data(PMBusDevice *pmdev, const uint8_t *buf,
> +                               uint8_t len)
> +{
> +    if (len == 0) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: writing empty data\n", __func__);
> +        return -1;
> +    }
> +
> +    pmdev->code = buf[0];
> +
> +    if (len == 1) {
> +        return 0;
> +    }
> +
> +    return 0;
> +}
> +
> +static void ucd90320_exit_reset(Object *obj, ResetType type)
> +{
> +    PMBusDevice *pmdev = PMBUS_DEVICE(obj);
> +
> +    pmdev->capability = 0x20; /* PEC supported */
> +
> +    for (int i = 0; i < UCD90320_NUM_PAGES; i++) {
> +        pmdev->pages[i].operation     = 0x80; /* on */
> +        pmdev->pages[i].on_off_config = 0x1a;
> +        pmdev->pages[i].vout_mode     = 0x00; /* linear mode, exponent=0 */
> +        pmdev->pages[i].read_vout     = 0;    /* rails off, pgood=0 */
> +    }
> +}
> +
> +static void ucd90320_init(Object *obj)
> +{
> +    PMBusDevice *pmdev = PMBUS_DEVICE(obj);
> +    uint64_t flags = PB_HAS_VOUT | PB_HAS_VOUT_MODE |
> +                     PB_HAS_STATUS_MFR_SPECIFIC;
> +
> +    for (int i = 0; i < UCD90320_NUM_PAGES; i++) {
> +        pmbus_page_config(pmdev, i, flags);
> +    }
> +}
> +
> +static void ucd90320_class_init(ObjectClass *klass, const void *data)
> +{
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PMBusDeviceClass *k = PMBUS_DEVICE_CLASS(klass);
> +
> +    dc->desc = "Texas Instruments UCD90320 24-Rail Power Sequencer";
> +    k->write_data = ucd90320_write_data;
> +    k->receive_byte = ucd90320_read_byte;
> +    k->device_num_pages = UCD90320_NUM_PAGES;
> +    rc->phases.exit = ucd90320_exit_reset;
> +}
> +
> +static const TypeInfo ucd90320_info = {
> +    .name          = TYPE_UCD90320,
> +    .parent        = TYPE_PMBUS_DEVICE,
> +    .instance_size = sizeof(UCD90320State),
> +    .instance_init = ucd90320_init,
> +    .class_init    = ucd90320_class_init,
> +};
> +
> +static void ucd90320_register_types(void)
> +{
> +    type_register_static(&ucd90320_info);
> +}
> +
> +type_init(ucd90320_register_types)
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 82e0bc2e70..ac44740547 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -555,6 +555,7 @@ config ASPEED_SOC
>       select LED
>       select PMBUS
>       select MAX31785
> +    select UCD90320
>       select FSI_APB2OPB_ASPEED
>       select AT24C
>       select PCI_EXPRESS
> diff --git a/hw/sensor/Kconfig b/hw/sensor/Kconfig
> index bc6331b4ab..135ffa7d5d 100644
> --- a/hw/sensor/Kconfig
> +++ b/hw/sensor/Kconfig
> @@ -43,3 +43,7 @@ config ISL_PMBUS_VR
>   config MAX31785
>       bool
>       depends on PMBUS
> +
> +config UCD90320
> +    bool
> +    depends on PMBUS
> diff --git a/hw/sensor/meson.build b/hw/sensor/meson.build
> index 420fdc3359..c0583161d3 100644
> --- a/hw/sensor/meson.build
> +++ b/hw/sensor/meson.build
> @@ -8,3 +8,4 @@ system_ss.add(when: 'CONFIG_MAX34451', if_true: files('max34451.c'))
>   system_ss.add(when: 'CONFIG_LSM303DLHC_MAG', if_true: files('lsm303dlhc_mag.c'))
>   system_ss.add(when: 'CONFIG_ISL_PMBUS_VR', if_true: files('isl_pmbus_vr.c'))
>   system_ss.add(when: 'CONFIG_MAX31785', if_true: files('max31785.c'))
> +system_ss.add(when: 'CONFIG_UCD90320', if_true: files('ucd90320.c'))


