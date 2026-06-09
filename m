Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8AA9CD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWyUx-0004st-0E; Tue, 09 Jun 2026 11:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wWyUu-0004qs-MP
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 11:36:12 -0400
Received: from fout-a8-smtp.messagingengine.com ([103.168.172.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wWyUr-00016h-TM
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 11:36:11 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 9E854EC023E;
 Tue,  9 Jun 2026 11:36:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Tue, 09 Jun 2026 11:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1781019367;
 x=1781105767; bh=hF2IFSFBDpx+d12z93iCXasTHdzej0IuaPWBqz+ox9o=; b=
 MZEj3v02BvG5MLVTMqm+BHFeFEi5999lH+MtJtK6hUhXvcfR52rlXBMzQE4pvxM9
 IK097oRGUz+5ZzdfaR6IXSl7nswLlifrMNzZcuVHBxo4zuAnDH0H0q9XR3gqrLhx
 6geHd6oP51rs9N1rMSZIfbyDI7X9iaFT5oNyZivA8bNXIoWyLjxxqp7EirGISuHp
 1gdMuNxU4DV4F1jITV7d+s+ODISGTsXglLedxVBi4XRN1B87pNoBb3PnhpH4/DJa
 PwL/2flObkTQsFBn1beyxbcdzbUgg3oxzENNVh/yGa3AWzpH82p/ED5pplRLCSHa
 8mf0RBXRFInEBM9TwXiUjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781019367; x=
 1781105767; bh=hF2IFSFBDpx+d12z93iCXasTHdzej0IuaPWBqz+ox9o=; b=X
 hpUpBAl/xfVXeiCUQFhbpHO3VGTi80yaBbzv6tZMGsYxFlozFl38pn/lT2FAL7MN
 Wv5YWqHm32JQejOsZ/jJ8MoTXLHPNffyvFMRxOo5eRbywqfpz0/aj7ixdxRwQhwK
 pXyf16vJvioGAkOxflJh9rLUGRchF/oQ2lsvv63lCayZRROhPpUlC1XuNrQZWm1F
 nNXLUUgU3T4HFVvHhuwVP+qKOVfbP7drl8bYV0ARbzkUb7VFPxcv3wj/xWU3U980
 x8JD+koPzHpnMgy2yhUApVm/CnfhEfvl2Sw82uysBYBeOpr6Yq4245y2cTkMyXxX
 L+lYtxxBNk0X0ge6tevCg==
X-ME-Sender: <xms:5zIoaqgy7-TDNHQeDeASCL7hqI1Al8erVWxhs2uBPyu4Rfvp16OYXQ>
 <xme:5zIoaj_bN8jMFJlQweSytSVIP_vfJz07G-qKMLa8dFQ6scm4vllrxL2C4RXQwSN_I
 BQoEsRiJOT990NJIToQor6Tl96mShWPGYbD0RiojUZrue5OnIaIhw>
X-ME-Received: <xmr:5zIoato7EIXuTlHNL8DI63_0bt9YvCFoFIcP9bnkOaZXamvCu9Rsl2wq4Fc>
X-ME-Proxy-Cause: dmFkZTFDp4hn9yJlTVOgAh1GbnLh12kIMdsGHUkCUPTOk7zXSzkdMPRTC77WP+iDJxzenq
 vfTio6CT2pL7LrIyDKtsYZiHUluFLZ01APhc3NRWpgwVe17fxXZxa9LlMWHZoXWTfeLNcW
 Q8AwUP65L4NVO+9/8XhJSte9b6uRwZZXUOBb9XSI+M8fVJCJAOvIwLTqlkmln2WDvjFnMU
 K+X9BfIeX3snXkTTN1zH7ahjszSnwKZ83V6FpW7W4oiBhSUlek7RUCPcVuHjZEiEdGyar+
 BHB8qsbnLDXjjLUz0eH3LPujw+NaxbXiCTQi/uS7gM/GzhlDgh+jmMKf5byElKhUIHydSQ
 xDPwFp4VsH53DAyWnh5V8M//NHYg4EOBLpchBboqTp9KWmqUnzY96rqN7O96htvq/ZZ1yv
 h8+u0qUvEN2AUh3SW+byAeb0jPblua2IHlpJz7bqis89p+mA5z/oObUdLv9cGGKPFOCnJB
 eMWd/Oz8oC+MCxF+PYnIfQ+Tj+bS3+agjWrh458CkJDXqFejZjjV8i4eneeD01+l/YIqu9
 jGs2kUuhfbarMF2EH8PYOoIzOgmSz2Q61uT0YgdKMLIbGIL7ZfdrO5qb0yMKv7sUoAC8rM
 cIeyyZ2wLckCGnNFF9vO9kK7kutlPxKeQHUngaCgf67FKZTGcmfv+gbUmazA
X-ME-Proxy: <xmx:5zIoajWZGG7EREFRp19RhoaJb73ft6e-7xejPT4R6sqMyOkJjUWNvw>
 <xmx:5zIoakA0vnVeL4aYTZscinkRSIVVaeDt_2cQgmjyzU7RIZm8-y2Qdg>
 <xmx:5zIoav0u25PweW1Lwb1T1KJ0Se5zYl5HETq-AGk9dpy6Wcn8kl3OlQ>
 <xmx:5zIoau0ePP4UFf4S9wQvfQg_RAm-cuS_VndWMp5S70MWroqNyjUefw>
 <xmx:5zIoagwjnsdWgoX4qlLrttvIoXFX_ldmbxiA841DXt1x2HuAkNWLrJUO>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 11:36:07 -0400 (EDT)
Date: Tue, 9 Jun 2026 09:36:06 -0600
From: Alex Williamson <alex@shazbot.org>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clg@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, K S Maan
 <kirandeepmaan45@gmail.com>, alex@shazbot.org
Subject: Re: [PATCH v2 1/7] hw/pci: Recalculate option ROM checksum before
 patching ID
Message-ID: <20260609093606.1dbbd177@shazbot.org>
In-Reply-To: <20260608134559.23971-2-tomitamoeko@gmail.com>
References: <20260608134559.23971-1-tomitamoeko@gmail.com>
 <20260608134559.23971-2-tomitamoeko@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=103.168.172.151; envelope-from=alex@shazbot.org;
 helo=fout-a8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

On Mon,  8 Jun 2026 21:45:52 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> pci_patch_ids() only adjusts checksum based on the new IDs. For an
> option ROM with invalid checksum, the patched one will still have
> an invalid checksum. Always calculate the checksum and patch it if
> necessary to ensure the option ROM is valid.
> 
> This is intended for fixing the romfile used in IGD passthrough as
> multiple IGD devices share the same rom with possible non-matching
> device ID, and its checksum is known to be bogus [1].
> 
> A helper function pci_rom_calculate_checksum() is added and exported
> for reusing in IGD-specific quirk later.
> 
> [1] hw/vfio/pci.c:1090
> 
> Reported-by: K S Maan <kirandeepmaan45@gmail.com>
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
>  hw/pci/pci.c         | 35 ++++++++++++++++++++++++++---------
>  include/hw/pci/pci.h |  2 ++
>  2 files changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index cec065d108..742917f79d 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2479,6 +2479,21 @@ static uint8_t pci_find_capability_at_offset(PCIDevice *pdev, uint8_t offset)
>      return found;
>  }
>  
> +uint8_t pci_rom_calculate_checksum(const uint8_t *ptr, uint32_t size)
> +{
> +    uint8_t checksum = 0;
> +    uint32_t i;
> +
> +    for (i = 0; i < size; i++) {
> +        if (i == 6) {
> +            continue;
> +        }

If we remove this continue branch...

> +        checksum += ptr[i];
> +    }
> +
> +    return checksum;
> +}
> +
>  /* Patch the PCI vendor and device ids in a PCI rom image if necessary.
>     This is needed for an option rom which is used for more than one device. */
>  static void pci_patch_ids(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
> @@ -2514,25 +2529,27 @@ static void pci_patch_ids(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
>      trace_pci_rom_and_pci_ids(pdev->romfile, vendor_id, device_id,
>                                rom_vendor_id, rom_device_id);
>  
> -    checksum = ptr[6];
> +    /* In case the checksum is bogus */
> +    checksum = pci_rom_calculate_checksum(ptr, size);
>  
>      if (vendor_id != rom_vendor_id) {
>          /* Patch vendor id and checksum (at offset 6 for etherboot roms). */
> -        checksum += (uint8_t)rom_vendor_id + (uint8_t)(rom_vendor_id >> 8);
> -        checksum -= (uint8_t)vendor_id + (uint8_t)(vendor_id >> 8);
> -        trace_pci_rom_checksum_change(ptr[6], checksum);
> -        ptr[6] = checksum;
> +        checksum += (uint8_t)vendor_id + (uint8_t)(vendor_id >> 8);
> +        checksum -= (uint8_t)rom_vendor_id + (uint8_t)(rom_vendor_id >> 8);
>          pci_set_word(ptr + pcir_offset + 4, vendor_id);
>      }
>  
>      if (device_id != rom_device_id) {
>          /* Patch device id and checksum (at offset 6 for etherboot roms). */
> -        checksum += (uint8_t)rom_device_id + (uint8_t)(rom_device_id >> 8);
> -        checksum -= (uint8_t)device_id + (uint8_t)(device_id >> 8);
> -        trace_pci_rom_checksum_change(ptr[6], checksum);
> -        ptr[6] = checksum;
> +        checksum += (uint8_t)device_id + (uint8_t)(device_id >> 8);
> +        checksum -= (uint8_t)rom_device_id + (uint8_t)(rom_device_id >> 8);
>          pci_set_word(ptr + pcir_offset + 6, device_id);
>      }
> +
> +    if (ptr[6] != (uint8_t)-checksum) {
> +        trace_pci_rom_checksum_change(ptr[6], (uint8_t)-checksum);
> +        ptr[6] = (uint8_t)-checksum;
> +    }

Then this just becomes:

    if (checksum) {
        trace_pci_rom_checksum_change(ptr[6], ptr[6] - checksum);
        ptr[6] -= checksum;
    }

The result is the same, but this avoids the uint8_t casts where
checksum is promoted to an int for comparison.

Patch 7 would require an equivalent change:

  -    ((uint8_t *)vdev->rom)[6] = (uint8_t)-checksum;
  +    ((uint8_t *)vdev->rom)[6] -= checksum;

Minor change, slightly better form.  Thanks,

Alex

