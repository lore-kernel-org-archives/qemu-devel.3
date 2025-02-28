Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCDEC19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 07:46:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnv3y-000176-8c; Fri, 28 Feb 2025 02:45:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Kihk=VT=kaod.org=clg@ozlabs.org>)
 id 1tnv3r-000147-IL; Fri, 28 Feb 2025 02:45:33 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Kihk=VT=kaod.org=clg@ozlabs.org>)
 id 1tnv3n-0005zc-OL; Fri, 28 Feb 2025 02:45:30 -0500
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Z40cD0M0Jz4wcT;
 Fri, 28 Feb 2025 18:45:16 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Z40c76LLGz4x6D;
 Fri, 28 Feb 2025 18:45:11 +1100 (AEDT)
Message-ID: <3430a63d-1fc9-4bb6-8dab-d8ae22afb4de@kaod.org>
Date: Fri, 28 Feb 2025 08:45:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] hw/ssi/pnv_spi: Make bus names distinct for each
 controllers of a socket
To: Chalapathi V <chalapathi.v@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, calebs@linux.ibm.com,
 chalapathi.v@ibm.com, saif.abrar@linux.ibm.com, dantan@linux.vnet.ibm.com,
 milesg@linux.ibm.com, philmd@linaro.org, alistair@alistair23.me
References: <20250103161824.22469-1-chalapathi.v@linux.ibm.com>
 <20250103161824.22469-4-chalapathi.v@linux.ibm.com>
 <D82UR4MO7WG9.RGLCRWPS8I29@gmail.com>
 <b4430243-942b-43fc-9502-c0a328cecdc3@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <b4430243-942b-43fc-9502-c0a328cecdc3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=Kihk=VT=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 2/28/25 04:03, Chalapathi V wrote:
> 
> On 27-02-2025 07:24, Nicholas Piggin wrote:
>> On Sat Jan 4, 2025 at 2:18 AM AEST, Chalapathi V wrote:
>>> Create a spi buses with distict names on each socket so that responders
>>> are attached to correct SPI controllers.
>>>
>>> QOM tree on a 2 socket machine:
>>> (qemu) info qom-tree
>>> /machine (powernv10-machine)
>>>    /chip[0] (power10_v2.0-pnv-chip)
>>>      /pib_spic[0] (pnv-spi)
>>>        /chip0.pnv.spi.bus.0 (SSI)
>>>        /xscom-spi[0] (memory-region)
>>>    /chip[1] (power10_v2.0-pnv-chip)
>>>      /pib_spic[0] (pnv-spi)
>>>        /chip1.pnv.spi.bus.0 (SSI)
>>>        /xscom-spi[0] (memory-region)
>> Mechanics of the patch looks fine. I don't know about the name
>> though.
>>
>> I think "pnv-spi-bus" is the right name for the bus. Using dots as
>> with chip0. makes it seem like each element is part of a topology.
>>
>> Would chip0.pnv-spi-bus be better?
> Will rename the bus name to chip0.pnv-spi-bus . Thank You

Yep. I don't think the bus suffix is useful (minor).

Will you be attaching flash devices from the command line ? Can you provide
an example if so ?

Thanks,

C.


>> I don't suppose there is a good way to create an alias so existing
>> cmdline works and refers to the bus on chip0? Maybe the chip0 bus
>> could just not have the chip0. prefix?
>>
>> Thanks,
>> Nick
> Would it be best to keep the chip0 prefix to have uniformity?
>>> Signed-off-by: Chalapathi V<chalapathi.v@linux.ibm.com>
>>> ---
>>>   include/hw/ssi/pnv_spi.h           | 3 ++-
>>>   hw/ppc/pnv.c                       | 2 ++
>>>   hw/ssi/pnv_spi.c                   | 5 +++--
>>>   tests/qtest/pnv-spi-seeprom-test.c | 2 +-
>>>   4 files changed, 8 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/include/hw/ssi/pnv_spi.h b/include/hw/ssi/pnv_spi.h
>>> index 9878d9a25f..7fc5da1f84 100644
>>> --- a/include/hw/ssi/pnv_spi.h
>>> +++ b/include/hw/ssi/pnv_spi.h
>>> @@ -31,7 +31,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(PnvSpi, PNV_SPI)
>>>   #define PNV_SPI_REG_SIZE 8
>>>   #define PNV_SPI_REGS 7
>>>   
>>> -#define TYPE_PNV_SPI_BUS "pnv-spi-bus"
>>> +#define TYPE_PNV_SPI_BUS "pnv.spi.bus"
>>>   typedef struct PnvSpi {
>>>       SysBusDevice parent_obj;
>>>   
>>> @@ -42,6 +42,7 @@ typedef struct PnvSpi {
>>>       Fifo8 rx_fifo;
>>>       /* SPI object number */
>>>       uint32_t        spic_num;
>>> +    uint32_t        chip_id;
>>>       uint8_t         transfer_len;
>>>       uint8_t         responder_select;
>>>       /* To verify if shift_n1 happens prior to shift_n2 */
>>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>>> index 11fd477b71..ce23892fdf 100644
>>> --- a/hw/ppc/pnv.c
>>> +++ b/hw/ppc/pnv.c
>>> @@ -2226,6 +2226,8 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>>>           /* pib_spic[2] connected to 25csm04 which implements 1 byte transfer */
>>>           object_property_set_int(OBJECT(&chip10->pib_spic[i]), "transfer_len",
>>>                                   (i == 2) ? 1 : 4, &error_fatal);
>>> +        object_property_set_int(OBJECT(&chip10->pib_spic[i]), "chip-id",
>>> +                                chip->chip_id, &error_fatal);
>>>           if (!sysbus_realize(SYS_BUS_DEVICE(OBJECT
>>>                                           (&chip10->pib_spic[i])), errp)) {
>>>               return;
>>> diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
>>> index 87eac666bb..41beb559c6 100644
>>> --- a/hw/ssi/pnv_spi.c
>>> +++ b/hw/ssi/pnv_spi.c
>>> @@ -1116,14 +1116,15 @@ static const MemoryRegionOps pnv_spi_xscom_ops = {
>>>   
>>>   static const Property pnv_spi_properties[] = {
>>>       DEFINE_PROP_UINT32("spic_num", PnvSpi, spic_num, 0),
>>> +    DEFINE_PROP_UINT32("chip-id", PnvSpi, chip_id, 0),
>>>       DEFINE_PROP_UINT8("transfer_len", PnvSpi, transfer_len, 4),
>>>   };
>>>   
>>>   static void pnv_spi_realize(DeviceState *dev, Error **errp)
>>>   {
>>>       PnvSpi *s = PNV_SPI(dev);
>>> -    g_autofree char *name = g_strdup_printf(TYPE_PNV_SPI_BUS ".%d",
>>> -                    s->spic_num);
>>> +    g_autofree char *name = g_strdup_printf("chip%d." TYPE_PNV_SPI_BUS ".%d",
>>> +                    s->chip_id, s->spic_num);
>>>       s->ssi_bus = ssi_create_bus(dev, name);
>>>       s->cs_line = g_new0(qemu_irq, 1);
>>>       qdev_init_gpio_out_named(DEVICE(s), s->cs_line, "cs", 1);
>>> diff --git a/tests/qtest/pnv-spi-seeprom-test.c b/tests/qtest/pnv-spi-seeprom-test.c
>>> index 57f20af76e..ef1005a926 100644
>>> --- a/tests/qtest/pnv-spi-seeprom-test.c
>>> +++ b/tests/qtest/pnv-spi-seeprom-test.c
>>> @@ -92,7 +92,7 @@ static void test_spi_seeprom(const void *data)
>>>       qts = qtest_initf("-machine powernv10 -smp 2,cores=2,"
>>>                         "threads=1 -accel tcg,thread=single -nographic "
>>>                         "-blockdev node-name=pib_spic2,driver=file,"
>>> -                      "filename=%s -device 25csm04,bus=pnv-spi-bus.2,cs=0,"
>>> +                      "filename=%s -device 25csm04,bus=chip0.pnv.spi.bus.2,cs=0,"
>>>                         "drive=pib_spic2", tmp_path);
>>>       spi_seeprom_transaction(qts, chip);
>>>       qtest_quit(qts);


