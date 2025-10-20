Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA08CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 14:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAqTt-0000nr-Kw; Mon, 20 Oct 2025 10:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vAqTr-0000lT-51
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:03:23 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vAqTj-0006AS-Nr
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:03:22 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BC037597306;
 Mon, 20 Oct 2025 16:03:10 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id wAPbnfeICIcs; Mon, 20 Oct 2025 16:03:08 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id BC4DF5972FF; Mon, 20 Oct 2025 16:03:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BA8E959703F;
 Mon, 20 Oct 2025 16:03:08 +0200 (CEST)
Date: Mon, 20 Oct 2025 16:03:08 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH] i2c/smbus_eeprom: Add minimum write recovery time for DDR2
In-Reply-To: <102a9874-27db-4073-b4ff-dddeb450ff5e@linaro.org>
Message-ID: <879d49b7-40d8-7ba5-f1d2-ccb37669f9fa@eik.bme.hu>
References: <20251008122502.9DA8956F301@zero.eik.bme.hu>
 <102a9874-27db-4073-b4ff-dddeb450ff5e@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-740830889-1760968988=:64218"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-740830889-1760968988=:64218
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 20 Oct 2025, Philippe Mathieu-Daudé wrote:
> On 8/10/25 14:25, BALATON Zoltan wrote:
>> This is needed for newer u-boot-sam460ex versions to pass the DRAM
>> setup.
>> 
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   hw/i2c/smbus_eeprom.c | 1 +
>>   1 file changed, 1 insertion(+)
>> 
>> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
>> index 0a1088fbb0..26e211b31a 100644
>> --- a/hw/i2c/smbus_eeprom.c
>> +++ b/hw/i2c/smbus_eeprom.c
>> @@ -288,6 +288,7 @@ uint8_t *spd_data_generate(enum sdram_type type, 
>> ram_addr_t ram_size)
>>       spd[33] = 8;    /* addr/cmd hold time */
>>       spd[34] = 20;   /* data input setup time */
>>       spd[35] = 8;    /* data input hold time */
>> +    spd[36] = (type == DDR2 ? 13 << 2 : 0); /* min. write recovery time */
>
> We are adapting DDR2 values on a method written for SDR/DDR[1].
> Better would be to split and correctly document each format,
> using proper values.

I plan to add separate function for DDR3 which is different from these 
(Bernhard had a patch for that which we can adopt but I haven't got to 
that yet). Maybe a split could be considered then but these formats up to 
DDR2 are quite similar with a lot of common values and only a few 
differences to have them in a single function. As a documentation better 
consult something else, e.g. wikipedia has a good summary.

> Anyhow, for this patch:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thank you,
BALATON Zoltan
--3866299591-740830889-1760968988=:64218--

