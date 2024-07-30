Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1DF5C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 09:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYjdF-0003sy-4M; Tue, 30 Jul 2024 05:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sYjdD-0003kG-DE; Tue, 30 Jul 2024 05:58:59 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sYjdB-0003Xg-Qz; Tue, 30 Jul 2024 05:58:59 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E825A4E6005;
 Tue, 30 Jul 2024 11:58:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id C2AQEdHpCEbU; Tue, 30 Jul 2024 11:58:53 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E75A14E6001; Tue, 30 Jul 2024 11:58:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E48D8746E3B;
 Tue, 30 Jul 2024 11:58:53 +0200 (CEST)
Date: Tue, 30 Jul 2024 11:58:53 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org, 
 Sergio Lopez <slp@redhat.com>, 
 =?ISO-8859-15?Q?Fr=E9d=E9ric_Barrat?= <fbarrat@linux.ibm.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org, 
 Artyom Tarasenko <atar4qemu@gmail.com>, Fabiano Rosas <farosas@suse.de>, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 Hanna Reitz <hreitz@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 John Snow <jsnow@redhat.com>, Thomas Huth <huth@tuxfamily.org>, 
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Leonardo Bras <leobras@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, 
 Kevin Wolf <kwolf@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v5 11/11] hw/isa/vt82c686: Implement relocation and
 toggling of SuperI/O functions
In-Reply-To: <73127b3f-7a56-46f3-892f-a7ffd542b4dd@linaro.org>
Message-ID: <bba2e80a-f509-d7f5-3846-14b4ebced5ac@eik.bme.hu>
References: <20240114123911.4877-1-shentey@gmail.com>
 <20240114123911.4877-12-shentey@gmail.com>
 <73127b3f-7a56-46f3-892f-a7ffd542b4dd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-976674846-1722333533=:80219"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

--3866299591-976674846-1722333533=:80219
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 29 Jul 2024, Philippe Mathieu-Daudé wrote:
> On 14/1/24 13:39, Bernhard Beschow wrote:
>> The VIA south bridges are able to relocate and toggle (enable or disable) 
>> their
>> SuperI/O functions. So far this is hardcoded such that all functions are 
>> always
>> enabled and are located at fixed addresses.
>> 
>> Some PC BIOSes seem to probe for I/O occupancy before activating such a 
>> function
>> and issue an error in case of a conflict. Since the functions are currently
>> enabled on reset, conflicts are always detected. Prevent that by 
>> implementing
>> relocation and toggling of the SuperI/O functions.
>> 
>> Note that all SuperI/O functions are now deactivated upon reset (except for
>> VT82C686B's serial ports where Fuloong 2e's rescue-yl seems to expect them 
>> to be
>> enabled by default). Rely on firmware to configure the functions 
>> accordingly.
>> 
>> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
>> Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   hw/isa/vt82c686.c | 65 +++++++++++++++++++++++++++++++++++++++--------
>>   1 file changed, 55 insertions(+), 10 deletions(-)
>
>
>> +static void via_superio_devices_enable(ViaSuperIOState *s, uint8_t data)
>> +{
>> +    ISASuperIOClass *ic = ISA_SUPERIO_GET_CLASS(s);
>> +
>
>       memory_region_transaction_begin();
>
>> +    isa_parallel_set_enabled(s->superio.parallel[0], (data & 0x3) != 3);
>> +    for (int i = 0; i < ic->serial.count; i++) {
>> +        isa_serial_set_enabled(s->superio.serial[i], data & BIT(i + 2));
>> +    }
>> +    isa_fdc_set_enabled(s->superio.floppy, data & BIT(4));
>
>       memory_region_transaction_commit();

Is a transaction needed here? We're just enable/disable independent memory 
regions here and I don't think this function can be interrupted but having 
a transaction does not hurt but I don't understand why we would need it.

Regards,
BALATON Zoltan
--3866299591-976674846-1722333533=:80219--

