Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B6ECD8C83
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 22:03:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVcd7-00014S-4w; Fri, 05 Jun 2026 18:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wVcd6-00014K-2m
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 18:03:04 -0400
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wVcd4-0000wm-Ev
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 18:03:03 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id E4934EC011A;
 Fri,  5 Jun 2026 18:03:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Fri, 05 Jun 2026 18:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1780696981;
 x=1780783381; bh=BrRzzTmA+xQvWeI6UA5gDb94oacoCFBkcVRzPJInAYg=; b=
 f/dZVHuWowflwFgLaLnNj0Ltkxh+TXFFqcYowqum0+EGRFiJEPTrHf+qIcO6JINC
 oy0zMTZtgfCre53ht5wPFjqPNTKV2nPqlix++MssAH46DIDxUvjlcCWh6VoQI/eQ
 sRNaVGHdSCmczlIo4Ut8Rf+w27BtP1xMjhvUuVqfp2NL4jpPQi8ycFe523yK5QCy
 b3wznV0eGNce6v4BAkJSBfn+qAqfrAJ7ZzcO1D+OZSe9+9fNrR99u5kGxRNzrwnd
 5kMS4yTsQZ7cbXDsVFT+ynf6Kq/Hnkssu/mrrHufYQRH79qyl3dpjtzDxZZhC1LZ
 DVs5wAlTjiA8Qj0g+ySggA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780696981; x=
 1780783381; bh=BrRzzTmA+xQvWeI6UA5gDb94oacoCFBkcVRzPJInAYg=; b=Z
 lPDnwPJjrhKo26dpAflmM05TvXKAmtw25z1SDC2QjMLgPm9w1NVHBJdY7rftxKJT
 fNiLkyr0ZG1aYeV3qF9s1gTMjPxPHsO8eRSc1TUiVzhjsSBMrehHzxCVHWYSklb5
 3Y6KYVEVeakLJpFNF6qYyZUQT8PuAU3tyRNGOzcFr43UH2sc2duIBa+YDQd12Byl
 awIaRpPU52Zb4Vy3DIJ2/hkpVGQNKeTTNFE1KMYiX88QF5oynKxf490mb9kMYJph
 vKkw4qjPRvYR94WjQ3Mfnuh7qAq+nVeZST33iZdGgpEZ0TBoGSZhj3/2lbo7YLPw
 Ag/Kq5lpB1XO/8wWNuOjg==
X-ME-Sender: <xms:lUcjanmrvAWEx6KS3jK6TxPJaXc1yMrzaUtNZ7hLqHcEQNiB1647hw>
 <xme:lUcjajwS7PiUWRNVhsqiKYzzKpBCCZ3Az0wIRmkUsCQGzyqmdiVSCg-BZ3-Gh6N-q
 uyY62zYm53GGAMRjWyYvTDOu40ne_AXFMO6vvgt6H0ovFJ4FBBmaA>
X-ME-Received: <xmr:lUcjapPzbkICffAKUbm-WETGBl6JL6_DW6KeLmQuP5BIW2pijJxDvJCpQoQ>
X-ME-Proxy-Cause: dmFkZTFW0/HJg84SCHeNWA+1evtL1PhrZVIVRZTGAahxDG44rtp+xna683lf2rr+HHhFct
 syN4BxA5h4qmlSK6Q/oZ4UDNrK3oKLxN6mddwTuiGg/kkdspU7b9Fwle1S/UHOY+i2ummn
 1E6a/sw4sW2oOfVLzLyXTlFnHiodofTFoNKzRI99JFdw03GPzNaRnSviTKnFW0L6FLq69y
 kVdD/8IOAFDGLIeuctWdeVIVm8vK572mRrVXPGNrinbqNggysXZVDWuFzAqW1xDzJQ6Ksz
 9+Hj67Wo2MUZB+csQwUxkiW6Lm5V2ZkoQIJ0gP+6rs2dHxNhYc+IdlJy7x4yAkemAcddqF
 ql+9U5vFqFpwBNamsBOQPrV3VoLKbpK3RXMJH2hZ8WZGWqvyq8rFD+JT4dyOIY7AoXECen
 fdc1XJ+j3rZ7hmbTGbVDVK0HJ6LxUKqdEGe9V6nHbLCsQ6tlf64w0IFpnIuwV7b3fc1K3J
 COH5GI8TDBfa5kRYSpHVlqX6UM8ZKX/VFsCJfukL/73dr1ocXDi/dm+jYzzi0Gtu3o3FMK
 0SQ87igjmi+o149y64UqSbf7m6MYk5E8uOWqzHKHzEbZUMemVFJHsyXqjKtIWPn2yklPmf
 /CL4xxT9Kcik8tMk5TeQIlqHI5m9SwbPX0iaup7BuzLOEJkz/z1NLm1z5kQg
X-ME-Proxy: <xmx:lUcjavoICfUizYbwpae1P-H8SXJUTsDx8m73-io6VaCRiIGeLLZ1WA>
 <xmx:lUcjaiHJJM6WP79wqxPFKM5XzIF8tOj_ThsiiIB0qgMSPtPa1uBfjw>
 <xmx:lUcjasq4tr7CG88zPksH7ROjXeBw7AgS3Y1KZRghiF6kt1_WFqrBxw>
 <xmx:lUcjajb5f0q2j6UPJGOjdGI4npFi1YfLw4otEe9-_7hGuaG1JCvv7g>
 <xmx:lUcjagGsU3Vww6zB07Oz_gyzX-wQ92rbdukocvytunCS84IIqSvKqf1g>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 18:03:01 -0400 (EDT)
Date: Fri, 5 Jun 2026 16:03:00 -0600
From: Alex Williamson <alex@shazbot.org>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, K S Maan
 <kirandeepmaan45@gmail.com>, alex@shazbot.org
Subject: Re: [PATCH 4/6] vfio/pci: Use pci_rom_patch_ids() for IGD ROM ID
 patching
Message-ID: <20260605160300.73b4c36c@shazbot.org>
In-Reply-To: <20260603173355.36121-5-tomitamoeko@gmail.com>
References: <20260603173355.36121-1-tomitamoeko@gmail.com>
 <20260603173355.36121-5-tomitamoeko@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=103.168.172.144; envelope-from=alex@shazbot.org;
 helo=fout-a1-smtp.messagingengine.com
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

On Thu,  4 Jun 2026 01:33:52 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> Remove the duplicate inline logic in vfio_pci_load_rom() that patched
> the device ID in an IGD option ROM and replace it with a call to
> pci_rom_patch_ids(), conditioned on the rom_need_patch_id flag.
> 
> Reported-by: K S Maan <kirandeepmaan45@gmail.com>
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> Tested-by: K S Maan <kirandeepmaan45@gmail.com>
> ---
>  hw/vfio/pci.c | 31 +++----------------------------
>  1 file changed, 3 insertions(+), 28 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 9c06b25e63..6cbd65126e 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1029,6 +1029,7 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
>  
>  static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
>  {
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>      VFIODevice *vbasedev = &vdev->vbasedev;
>      struct vfio_region_info *reg_info = NULL;
>      uint64_t size;
> @@ -1084,34 +1085,8 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
>          }
>      }
>  
> -    /*
> -     * Test the ROM signature against our device, if the vendor is correct
> -     * but the device ID doesn't match, store the correct device ID and
> -     * recompute the checksum.  Intel IGD devices need this and are known
> -     * to have bogus checksums so we can't simply adjust the checksum.
> -     */
> -    if (pci_get_word(vdev->rom) == 0xaa55 &&
> -        pci_get_word(vdev->rom + 0x18) + 8 < vdev->rom_size &&
> -        !memcmp(vdev->rom + pci_get_word(vdev->rom + 0x18), "PCIR", 4)) {
> -        uint16_t vid, did;
> -
> -        vid = pci_get_word(vdev->rom + pci_get_word(vdev->rom + 0x18) + 4);
> -        did = pci_get_word(vdev->rom + pci_get_word(vdev->rom + 0x18) + 6);
> -
> -        if (vid == vdev->vendor_id && did != vdev->device_id) {
> -            int i;
> -            uint8_t csum, *data = vdev->rom;
> -
> -            pci_set_word(vdev->rom + pci_get_word(vdev->rom + 0x18) + 6,
> -                         vdev->device_id);
> -            data[6] = 0;
> -
> -            for (csum = 0, i = 0; i < vdev->rom_size; i++) {
> -                csum += data[i];
> -            }
> -
> -            data[6] = -csum;
> -        }
> +    if (pdev->rom_need_patch_id) {
> +        pci_rom_patch_ids(pdev, vdev->rom, vdev->rom_size);
>      }
>  }
>  

Wouldn't this provide cleaner bisection if we call the helper here
unconditionally and make it conditional in the next patch?  Or just
re-order patches 4 & 5 so we set the flag before we make this
conditional on the flag.  Thanks,

Alex

