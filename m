Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B3D5C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 22:40:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr2pj-0003I0-Mu; Sat, 08 Mar 2025 17:39:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tr2pc-0003Fv-Nx; Sat, 08 Mar 2025 17:39:45 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tr2pZ-00085D-ED; Sat, 08 Mar 2025 17:39:43 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9D8734E602B;
 Sat, 08 Mar 2025 23:39:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id XN-Le2_xAzHX; Sat,  8 Mar 2025 23:39:36 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id AFAE84E6019; Sat, 08 Mar 2025 23:39:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AD25E74577C;
 Sat, 08 Mar 2025 23:39:36 +0100 (CET)
Date: Sat, 8 Mar 2025 23:39:36 +0100 (CET)
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
Subject: Re: [PATCH v4 08/14] hw/sd/sdhci: Simplify MemoryRegionOps endianness
 check
In-Reply-To: <20250308213640.13138-9-philmd@linaro.org>
Message-ID: <b2c9e1d6-c73e-4f11-352f-453fbe4f77d3@eik.bme.hu>
References: <20250308213640.13138-1-philmd@linaro.org>
 <20250308213640.13138-9-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1940948962-1741473576=:94708"
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

--3866299591-1940948962-1741473576=:94708
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 8 Mar 2025, Philippe Mathieu-Daudé wrote:
> While little endianness is the default, ome controllers

Typo, ome -> some.

Regards,
BALATON Zoltan

> might be only implemented in big endianness.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> hw/sd/sdhci.c | 18 ++++--------------
> 1 file changed, 4 insertions(+), 14 deletions(-)
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index ae485f90dfe..a2e7162e289 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1444,20 +1444,10 @@ void sdhci_common_realize(SDHCIState *s, Error **errp)
>     SDHCIClass *sc = SYSBUS_SDHCI_GET_CLASS(s);
>     const char *class_name = object_get_typename(OBJECT(s));
>
> -    s->io_ops = sc->io_ops ?: &sdhci_mmio_le_ops;
> -    switch (s->endianness) {
> -    case DEVICE_LITTLE_ENDIAN:
> -        /* s->io_ops is little endian by default */
> -        break;
> -    case DEVICE_BIG_ENDIAN:
> -        if (s->io_ops != &sdhci_mmio_le_ops) {
> -            error_setg(errp, "SD controller doesn't support big endianness");
> -            return;
> -        }
> -        s->io_ops = &sdhci_mmio_be_ops;
> -        break;
> -    default:
> -        error_setg(errp, "Incorrect endianness");
> +    s->io_ops = sc->io_ops ?: (s->endianness == DEVICE_BIG_ENDIAN ?
> +                               &sdhci_mmio_be_ops : &sdhci_mmio_le_ops);
> +    if (s->io_ops->endianness != s->endianness) {
> +        error_setg(errp, "Invalid endianness for SD controller");
>         return;
>     }
>
>
--3866299591-1940948962-1741473576=:94708--

