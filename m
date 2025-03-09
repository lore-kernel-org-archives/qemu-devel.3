Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 584BAC282EC
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 00:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr4Da-0004ya-3v; Sat, 08 Mar 2025 19:08:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tr4DW-0004wo-1m; Sat, 08 Mar 2025 19:08:30 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tr4DT-0003ug-KM; Sat, 08 Mar 2025 19:08:29 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 902514E6019;
 Sun, 09 Mar 2025 01:08:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id VbmAVbkL4Wvx; Sun,  9 Mar 2025 01:08:20 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 921B34E600E; Sun, 09 Mar 2025 01:08:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8F53174577C;
 Sun, 09 Mar 2025 01:08:20 +0100 (CET)
Date: Sun, 9 Mar 2025 01:08:20 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, 
 Bernhard Beschow <shentey@gmail.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>, 
 Guenter Roeck <linux@roeck-us.net>, qemu-block@nongnu.org, 
 Bin Meng <bmeng.cn@gmail.com>, qemu-arm@nongnu.org
Subject: Re: [PATCH v4 03/14] hw/sd/sdhci: Introduce SDHCIClass stub
In-Reply-To: <142807a2-9536-4483-80ab-5f24793c841f@linaro.org>
Message-ID: <670a5a3c-3476-5b8d-775a-ebff83acc33d@eik.bme.hu>
References: <20250308213640.13138-1-philmd@linaro.org>
 <20250308213640.13138-4-philmd@linaro.org>
 <1839f9de-2370-50bd-7003-ade92707f137@eik.bme.hu>
 <142807a2-9536-4483-80ab-5f24793c841f@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="3866299591-506894546-1741478647=:25248"
Content-ID: <448b264e-e1d4-492e-e4e1-068729623c90@eik.bme.hu>
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

--3866299591-506894546-1741478647=:25248
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <8c000124-2e48-adbe-0a7f-53e142bd2287@eik.bme.hu>

On Sun, 9 Mar 2025, Philippe Mathieu-Daudé wrote:
> On 8/3/25 23:34, BALATON Zoltan wrote:
>> On Sat, 8 Mar 2025, Philippe Mathieu-Daudé wrote:
>>> TYPE_SYSBUS_SDHCI is a bit odd because it uses an union
>>> to work with both SysBus / PCI parent. As this is not a
>>> normal use, introduce SDHCIClass in its own commit.
>>> 
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>> include/hw/sd/sdhci.h | 9 +++++++++
>>> hw/sd/sdhci.c         | 1 +
>>> 2 files changed, 10 insertions(+)
>>> 
>>> diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
>>> index 48247e9a20f..c4b20db3877 100644
>>> --- a/include/hw/sd/sdhci.h
>>> +++ b/include/hw/sd/sdhci.h
>>> @@ -107,6 +107,13 @@ struct SDHCIState {
>>> };
>>> typedef struct SDHCIState SDHCIState;
>>> 
>>> +typedef struct SDHCIClass {
>>> +    union {
>>> +        PCIDeviceClass pci_parent_class;
>>> +        SysBusDeviceClass sbd_parent_class;
>>> +    };
>>> +} SDHCIClass;
>>> +
>>> /*
>>>  * Controller does not provide transfer-complete interrupt when not
>>>  * busy.
>>> @@ -123,6 +130,8 @@ DECLARE_INSTANCE_CHECKER(SDHCIState, PCI_SDHCI,
>>> #define TYPE_SYSBUS_SDHCI "generic-sdhci"
>>> DECLARE_INSTANCE_CHECKER(SDHCIState, SYSBUS_SDHCI,
>>>                          TYPE_SYSBUS_SDHCI)
>>> +DECLARE_CLASS_CHECKERS(SDHCIClass, SYSBUS_SDHCI,
>>> +                       TYPE_SYSBUS_SDHCI)
>> 
>> Are these two together just OBJECT_DECLARE_TYPE? Then the above typedefs 
>> are also not needed just the struct definitions.
>
> I'd like to but it isn't possible because the same object state/class is
> used by distinct types (PCI & SysBus).
>
> The following (expected to be correct) change ...:
> -- >8 --
> diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
> index 966a1751f50..341b130995b 100644
> --- a/include/hw/sd/sdhci.h
> +++ b/include/hw/sd/sdhci.h
> @@ -155,10 +155,6 @@ typedef struct SDHCIClass {
> #define TYPE_PCI_SDHCI "sdhci-pci"
> -DECLARE_INSTANCE_CHECKER(SDHCIState, PCI_SDHCI,
> -                         TYPE_PCI_SDHCI)
> +OBJECT_DECLARE_TYPE(SDHCIState, SDHCIClass, PCI_SDHCI)

It would be same as the original patch if you omit this one and only use 
OBJECT_DECLARE_TYPE below. You didn't add CLASS_CHECKER to the PCI version 
in the original patch either. But I see now it's more complex and so maybe 
it's not so easy.

> #define TYPE_SYSBUS_SDHCI "generic-sdhci"
> -DECLARE_INSTANCE_CHECKER(SDHCIState, SYSBUS_SDHCI,
> -                         TYPE_SYSBUS_SDHCI)
> -DECLARE_CLASS_CHECKERS(SDHCIClass, SYSBUS_SDHCI,
> -                       TYPE_SYSBUS_SDHCI)
> +OBJECT_DECLARE_TYPE(SDHCIState, SDHCIClass, SYSBUS_SDHCI)
> ---

[...]

> Meanwhile the current legacy macros seems good enough for soft freeze ;)

Good enough for me. I was also happy with my way simpler solution. This is 
much more clean up already.

Regards,
BALATON Zoltan
--3866299591-506894546-1741478647=:25248--

