Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36119CD6E6E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 22:03:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVcd0-00013o-QM; Fri, 05 Jun 2026 18:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wVccy-00013E-C7
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 18:02:56 -0400
Received: from fhigh-a2-smtp.messagingengine.com ([103.168.172.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wVccw-0000v3-Kl
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 18:02:56 -0400
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfhigh.phl.internal (Postfix) with ESMTP id D16231400144;
 Fri,  5 Jun 2026 18:02:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-07.internal (MEProxy); Fri, 05 Jun 2026 18:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1780696973;
 x=1780783373; bh=5VvBWt46BROkzteYsD3w+k2Y0ycL/MWLwPxsCmCfvzM=; b=
 BeuzxzNs0D3eCNWzL3MLZH6u9LS1/LE7m8z//uanvD10lz0L8BRTJWJxryKTVM41
 LQx1zjj1rK3eGrpZPtzWkbR+fF8QdHJjhYxJVjtwCkTx2s/e7bgA4F7v1vHu4rZp
 uWSyrDFv8CDWQ8JMqxKMlK7+cpTpQm4Lhk9RJA+nFgJNfhzZnt6UdPf3pxzKRqXM
 qfIHPmQYnjf2YkY6V5EXlxa1e8QqBtvdj5N97cSl4R/BXhctECSd9WkIYwftYj9n
 2K42hCWkHuqs1f+XADIkIVAN6vY8PaNmWJGEjM0hxFBytfelqvEqfN+JzMUNVvzM
 aJIaRkFl7bUp1y1BrKM8Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780696973; x=
 1780783373; bh=5VvBWt46BROkzteYsD3w+k2Y0ycL/MWLwPxsCmCfvzM=; b=G
 ipfW4K0eV4drF1zLLBXF+rsyXxudZ60si5gFti+1tgcuEROJ66pOp/ybTlxwFaSi
 0ceY1mjIsdMYswFW03BytNA9WisNPuF+Z1WDB+OKgSVboM2RMX6FGXwcCQ0DYDTC
 BEgXIv8dx40nnvtWk1hXWbBhOZzTBQo69ibmA1Qtgswoa5J7GqbDNaYqe4rw6i8F
 TBIDfklrOSfIGnWGdTxQTk6gLdDm7EHb74EVp5ZI5vl+U6DI6WxrW67t9yGiM+O5
 25RCF6KtsjckVYRBkmFheVE+8A3ngvrgxddGQwYaDyjMDWSFfowmPROH6bO0jxg4
 nF/dSkzGd9w+CNBc94uXg==
X-ME-Sender: <xms:jUcjau78IboOi6NIPHLJeeLPNMwiPAfALVzaUFd6c6J09hHbxm7BdA>
 <xme:jUcjag3fGl2jFUSUjYHN-uG9AKG3kHu9WNyJ3uovQ_uibgYCS4WfEPBsAqf49FSwX
 sEhOmItKT_yvTqDKiwxiEc7sF-7KAz5IBEaw0Qihtt5d2bYYL6sUA>
X-ME-Received: <xmr:jUcjapDuCwX9Xemhn0oNCYyjItx0DsCkQ03TDSb42DNCHewoow6I3Roc-ek>
X-ME-Proxy-Cause: dmFkZTGGJd3OEbRBajcsXpavUPnGwIxLnr+81C1kXVZy8LYnHTtKp91O2HMlqWx4dLa6se
 kQn5S4N/5FN8JHf7aY1sgJaXOUeDH4xFDctLsBU+umt02xx81kj5bjK1lJJVGgfxseaguE
 yyEjOAAaafM8Gi7qPVI652cAbgDeOXpn4m6ps9iUqrfzXXxMPZm/mVVmag5WOqVKMrANiL
 B0VEtzKUBBYXgx6OWY2grYg5o1vDGy1HxNJzUtrXBGoM7dsfxiLNjgIyTpwWJxbFBDhzPD
 LGlAFfK+GYeyHKKfrWRdUZIKwQqkt5bQl7aQZu9UFxV+pc6nf5bKl+yZDXriaeKoZkdmNz
 Z1y6Xs7Y/ba7gFVUxZfbZ0454kWARcGLaEdSl8jyAdBJHJ/R2K42y4Xs/8i1gyDU8Gj4Qt
 N7poRSxA+rskJIBKCHAvHkJQMLNYsjHgx496piVrH3/OL0i7yxWGTKv//aDUTssbT0k9Ep
 hdaoOlspHiU8FCWI/M/W0BzRui53IdoqbfjFGsBKd0Qbv+NTmPab6z1iWhgYcmY37yz1g3
 YqQqo7Kl/hrMKAKVo2aWGNHGKsU62MCQw7pwxmo6MHC3URL/IK0tMykxVYidkuZOE3KI7Z
 ZMREOm4jYsjh15/BUrWypTz56augfOwnNRg6NzNDbZ4NzEvnDQk1Ku9vVhUg
X-ME-Proxy: <xmx:jUcjarM0m6K0a1nsSXL8Uh-OWc45zEfmGbLzygOtGCRXGrzNhm6_fg>
 <xmx:jUcjauacNcWR_-8-x2OYaACXHjeXBcp8oT0fJaoHTZ7a6AJ16AC5aw>
 <xmx:jUcjaqvhvx6A8QQaDbrQ9n2L6pFO6aK--zuoXHc5_GQSm735W2rhog>
 <xmx:jUcjagOHjDYiYGymMh9KqhGbxqshVk64GJI6kzGgn_CPzG5tgxsErw>
 <xmx:jUcjaqoXhkTRrl4_dVW1yEDkFACPeucNjwpZTHxWz8X9XJcfYxQTZHLi>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 18:02:52 -0400 (EDT)
Date: Fri, 5 Jun 2026 16:02:51 -0600
From: Alex Williamson <alex@shazbot.org>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, K S Maan
 <kirandeepmaan45@gmail.com>, alex@shazbot.org
Subject: Re: [PATCH 5/6] vfio/igd: Toggle rom_need_patch_id flag on IGD devices
Message-ID: <20260605160251.4995910b@shazbot.org>
In-Reply-To: <20260603173355.36121-6-tomitamoeko@gmail.com>
References: <20260603173355.36121-1-tomitamoeko@gmail.com>
 <20260603173355.36121-6-tomitamoeko@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=103.168.172.153; envelope-from=alex@shazbot.org;
 helo=fhigh-a2-smtp.messagingengine.com
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

On Thu,  4 Jun 2026 01:33:53 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> IGD ROMs are known to have wrong device IDs and bogus checksums.
> Toggle the rom_need_patch_id flag when the IGD has ROM BAR or custom
> romfile so that pci_rom_patch_ids() will correct the vendor/device IDs
> and checksum.
> 
> The ROM BAR availability check is extracted into
> vfio_pci_igd_has_rom_bar() to avoid duplicating the region info lookup.
> 
> Reported-by: K S Maan <kirandeepmaan45@gmail.com>
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> Tested-by: K S Maan <kirandeepmaan45@gmail.com>
> ---
>  hw/vfio/igd.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index e091f21b6a..17437ae18d 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -509,11 +509,22 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>      QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, bdsm_quirk, next);
>  }
>  
> +static bool vfio_pci_igd_has_rom_bar(VFIOPCIDevice *vdev)
> +{
> +    struct vfio_region_info *rom = NULL;

Nit, copied from existing code, but the initialization here is
unnecessary.

> +    int ret;
> +
> +    ret = vfio_device_get_region_info(&vdev->vbasedev,
> +                                      VFIO_PCI_ROM_REGION_INDEX, &rom);
> +
> +    return !ret && rom->size;
> +}
> +
>  static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>  {
>      struct vfio_region_info *opregion = NULL;
>      PCIDevice *pdev = PCI_DEVICE(vdev);
> -    int ret, gen;
> +    int gen;
>      uint64_t gms_size = 0;
>      uint64_t *bdsm_size;
>      uint32_t gmch;
> @@ -556,8 +567,6 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>           * - OpRegion
>           * - Same LPC bridge and Host bridge VID/DID/SVID/SSID as host
>           */
> -        struct vfio_region_info *rom = NULL;
> -
>          legacy_mode_enabled = true;
>          info_report("IGD legacy mode enabled, "
>                      "use x-igd-legacy-mode=off to disable it if unwanted.");
> @@ -567,9 +576,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>           * there's no ROM, there's no point in setting up this quirk.
>           * NB. We only seem to get BIOS ROMs, so UEFI VM would need CSM support.
>           */
> -        ret = vfio_device_get_region_info(&vdev->vbasedev,
> -                                          VFIO_PCI_ROM_REGION_INDEX, &rom);
> -        if ((ret || !rom->size) && !pdev->romfile) {
> +        if (!vfio_pci_igd_has_rom_bar(vdev) && !pdev->romfile) {
>              error_setg(&err, "Device has no ROM");
>              goto error;
>          }
> @@ -610,6 +617,14 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>          goto error;
>      }
>  
> +    /*
> +     * IGD are known to have bad checksums and wrong device ID in its rom,
> +     * request to patch it.
> +     */
> +    if (pdev->romfile || vfio_pci_igd_has_rom_bar(vdev)) {
> +        pdev->rom_need_patch_id = true;
> +    }
> +
>      /*
>       * ASLS (OpRegion address) is read-only, emulated
>       * It contains HPA, guest firmware need to reprogram it with GPA.

Nit, the commit log rationalizes extracting vfio_pci_igd_has_rom_bar()
to avoid duplication, but both call sites are within the same function
and the status of whether the device has a ROM BAR is invariant.  We
could test once before we branch into legacy mode test and avoid the
helper and duplicate test.  Thanks,

Alex

