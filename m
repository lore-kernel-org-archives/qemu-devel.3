Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB24C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 22:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr2l1-0000v8-NK; Sat, 08 Mar 2025 17:34:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tr2kw-0000sc-Fu; Sat, 08 Mar 2025 17:34:54 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tr2kt-0007fV-Ow; Sat, 08 Mar 2025 17:34:53 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8AC954E6019;
 Sat, 08 Mar 2025 23:34:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id mUl9YcOaJ0Ul; Sat,  8 Mar 2025 23:34:45 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 91D8E4E600E; Sat, 08 Mar 2025 23:34:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8F93C74577D;
 Sat, 08 Mar 2025 23:34:45 +0100 (CET)
Date: Sat, 8 Mar 2025 23:34:45 +0100 (CET)
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
Subject: Re: [PATCH v4 03/14] hw/sd/sdhci: Introduce SDHCIClass stub
In-Reply-To: <20250308213640.13138-4-philmd@linaro.org>
Message-ID: <1839f9de-2370-50bd-7003-ade92707f137@eik.bme.hu>
References: <20250308213640.13138-1-philmd@linaro.org>
 <20250308213640.13138-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1192097316-1741473285=:94708"
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

--3866299591-1192097316-1741473285=:94708
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 8 Mar 2025, Philippe Mathieu-Daudé wrote:
> TYPE_SYSBUS_SDHCI is a bit odd because it uses an union
> to work with both SysBus / PCI parent. As this is not a
> normal use, introduce SDHCIClass in its own commit.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> include/hw/sd/sdhci.h | 9 +++++++++
> hw/sd/sdhci.c         | 1 +
> 2 files changed, 10 insertions(+)
>
> diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
> index 48247e9a20f..c4b20db3877 100644
> --- a/include/hw/sd/sdhci.h
> +++ b/include/hw/sd/sdhci.h
> @@ -107,6 +107,13 @@ struct SDHCIState {
> };
> typedef struct SDHCIState SDHCIState;
>
> +typedef struct SDHCIClass {
> +    union {
> +        PCIDeviceClass pci_parent_class;
> +        SysBusDeviceClass sbd_parent_class;
> +    };
> +} SDHCIClass;
> +
> /*
>  * Controller does not provide transfer-complete interrupt when not
>  * busy.
> @@ -123,6 +130,8 @@ DECLARE_INSTANCE_CHECKER(SDHCIState, PCI_SDHCI,
> #define TYPE_SYSBUS_SDHCI "generic-sdhci"
> DECLARE_INSTANCE_CHECKER(SDHCIState, SYSBUS_SDHCI,
>                          TYPE_SYSBUS_SDHCI)
> +DECLARE_CLASS_CHECKERS(SDHCIClass, SYSBUS_SDHCI,
> +                       TYPE_SYSBUS_SDHCI)

Are these two together just OBJECT_DECLARE_TYPE? Then the above typedefs 
are also not needed just the struct definitions.

Regards,
BALATON Zoltan

> #define TYPE_IMX_USDHC "imx-usdhc"
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 149b748cbee..4917a9b3632 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1960,6 +1960,7 @@ static const TypeInfo sdhci_types[] = {
>         .instance_size = sizeof(SDHCIState),
>         .instance_init = sdhci_sysbus_init,
>         .instance_finalize = sdhci_sysbus_finalize,
> +        .class_size = sizeof(SDHCIClass),
>         .class_init = sdhci_sysbus_class_init,
>     },
>     {
>
--3866299591-1192097316-1741473285=:94708--

