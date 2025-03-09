Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 400BAC28B25
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 12:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trFzq-0000wg-Do; Sun, 09 Mar 2025 08:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1trFzn-0000vC-Lr; Sun, 09 Mar 2025 08:43:07 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1trFzm-0007jE-2K; Sun, 09 Mar 2025 08:43:07 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9A5204E6034;
 Sun, 09 Mar 2025 13:43:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id kzM84zWCOWGl; Sun,  9 Mar 2025 13:43:00 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9588F4E6019; Sun, 09 Mar 2025 13:43:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9347174577C;
 Sun, 09 Mar 2025 13:43:00 +0100 (CET)
Date: Sun, 9 Mar 2025 13:43:00 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, 
 Bernhard Beschow <shentey@gmail.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>, 
 Guenter Roeck <linux@roeck-us.net>, qemu-block@nongnu.org, 
 Bin Meng <bmeng.cn@gmail.com>, qemu-arm@nongnu.org
Subject: Re: [PATCH v4 04/14] hw/sd/sdhci: Make quirks a class property
In-Reply-To: <f59df0e2-d6bf-4950-aaf6-02333183501b@linaro.org>
Message-ID: <5c9b053f-033a-0d7e-bd7d-9d5b50fd8e23@eik.bme.hu>
References: <20250308213640.13138-1-philmd@linaro.org>
 <20250308213640.13138-5-philmd@linaro.org>
 <11b37245-5dee-122b-cdfb-dfc820a38661@eik.bme.hu>
 <f59df0e2-d6bf-4950-aaf6-02333183501b@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-12532334-1741524180=:41275"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--3866299591-12532334-1741524180=:41275
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sun, 9 Mar 2025, Philippe Mathieu-Daudé wrote:
> On 9/3/25 12:43, BALATON Zoltan wrote:
>> On Sat, 8 Mar 2025, Philippe Mathieu-Daudé wrote:
>>> All TYPE_IMX_USDHC instances use the quirk:
>>> move it to the class layer.
>>> 
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>> include/hw/sd/sdhci.h |  3 ++-
>>> hw/sd/sdhci.c         | 15 +++++++++++++--
>>> 2 files changed, 15 insertions(+), 3 deletions(-)
>>> 
>>> diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
>>> index c4b20db3877..0616ce3aa59 100644
>>> --- a/include/hw/sd/sdhci.h
>>> +++ b/include/hw/sd/sdhci.h
>>> @@ -95,7 +95,6 @@ struct SDHCIState {
>>> 
>>>     /* Configurable properties */
>>>     bool pending_insert_quirk; /* Quirk for Raspberry Pi card insert int 
>>> */
>>> -    uint32_t quirks;
>>>     uint8_t endianness;
>>>     uint8_t sd_spec_version;
>>>     uint8_t uhs_mode;
>>> @@ -112,6 +111,8 @@ typedef struct SDHCIClass {
>>>         PCIDeviceClass pci_parent_class;
>>>         SysBusDeviceClass sbd_parent_class;
>>>     };
>>> +
>>> +    uint32_t quirks;
>>> } SDHCIClass;
>>> 
>>> /*
>>> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
>>> index 4917a9b3632..2b7eb11a14a 100644
>>> --- a/hw/sd/sdhci.c
>>> +++ b/hw/sd/sdhci.c
>>> @@ -345,6 +345,8 @@ static void sdhci_send_command(SDHCIState *s)
>>>     rlen = sdbus_do_command(&s->sdbus, &request, response);
>>> 
>>>     if (s->cmdreg & SDHC_CMD_RESPONSE) {
>>> +        SDHCIClass *sc = SYSBUS_SDHCI_GET_CLASS(s);
>> 
>> I don't like this because it introduces a class look up which may be costly 
>> in a function that could be called frequently. Maybe you could just drop 
>> this patch and leave the quirk handling as it is. Changing it does not seem 
>> to improve the model much.
>
> I thought about it and was expecting a such comment.
>
> Initializing a class field in the instance_init is an anti-pattern,

Why? It's not a class field, it's in SDHCIState (we have another quirk for 
rpi already there which could also use the same bits). But you could also 
init in realize instead if that's better then no need to duplicate it in 
class struct just to copy it to every instance.

Regards,
BALATON Zoltan
--3866299591-12532334-1741524180=:41275--

