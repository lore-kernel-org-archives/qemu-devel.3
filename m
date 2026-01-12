Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EAC6C9EC94
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 16:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfKbQ-0000Be-5O; Mon, 12 Jan 2026 11:17:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1vfKb6-0008Vm-0A
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 11:16:59 -0500
Received: from fout-b5-smtp.messagingengine.com ([202.12.124.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1vfKb2-00078K-24
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 11:16:50 -0500
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfout.stl.internal (Postfix) with ESMTP id 9EBC21D00017;
 Mon, 12 Jan 2026 11:16:44 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Mon, 12 Jan 2026 11:16:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1768234604;
 x=1768321004; bh=9Cr/skI19sYXpSpMP3Hgkhay+i7mdljYVJOyFxHWORk=; b=
 SE0CZFlzFv+eEkThAZ3tYK/hqFhi1h+pU4LaEuIQV70rTXB+UcCoDBZ3xTgz6oiJ
 iWtBdlrabJ+W+8ub0XIlYYURx0FgShr4f1o+hL90ALhaxkdtQSx7oIMR0kvwa22o
 DGf9FuFVQJ8UL7uU4e2dSKVDH9E1VUcD1tMqjJOmMY2xWJgvC8vfQA95N73NZD3z
 BG5pi4+Z2YLR9s+0HQVfX77YjucIt69GuFdmsvKdE6Q/AIsQEEWXBo9hP7J5vRuo
 Z+OLQd2oKsFgBoD9+oN1fnGSKssvdJZgdHpAj/e7b9QFGoKRVUZe1CsCk1sSiXib
 IHAbYiSnvjX7AGafw9FKHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768234604; x=
 1768321004; bh=9Cr/skI19sYXpSpMP3Hgkhay+i7mdljYVJOyFxHWORk=; b=N
 TXks1Klkv96/m1OgmIktkEFjgHxx4JQD134sZh7PrYtaFm0pJcKk3OXsWzM4IzHA
 z1HJ4jyoFsJWLifEl+B3MkWdJ1xUhE4xWJXCehpYhH9YHoIsGJFoElqIReZqjHto
 qfGEFoe6xjJqWAZvtF7Zg0yvBAuDAN9cIgkxlgM1ma3OLr8SP6Rl0Iozu8MOFIMn
 gHcyER/EjXlfphWM1m5nuyEwAR8kPIAF+1BFH4Z9NSWC0jSRfrgDLdyadj7whfKi
 olCNZwhrrqg3n007VUhAAhqp0l9sJjGCUDiN5hrS22tmubtTxzspgQhm5ihfJ6Zr
 L0Z4NmkrEJZXzj2jvgZqg==
X-ME-Sender: <xms:bB5laUZBCyEQrxwrCruKdND9_C7z8Qb-e7TwhJs934mrWMZRrs4zSA>
 <xme:bB5laYUI9BIDIVAtU7zt3mrEOQLGMaUpNIbZDTXuyFV5vDJZkNfQvT36l-DxttTn5
 GnnuF1idkhG3HjVLBp2TgdnwcLR_Dz7C5BvgeqVadEWJo3OWn7BqA>
X-ME-Received: <xmr:bB5laahmZNivEQxq0a9It9_-IG2j52kbBek8IUrATzAvvp5JX9ydp2ZWeZk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejledtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
 hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
 htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
 veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepiedpmhhouggvpehs
 mhhtphhouhhtpdhrtghpthhtohepmhgrnhhojhhlohdrphgvkhhovhhitgesrghmugdrtg
 homhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghp
 thhtoheprghlvgigrdifihhllhhirghmshhonhesrhgvughhrghtrdgtohhmpdhrtghpth
 htoheptghlghesrhgvughhrghtrdgtohhmpdhrtghpthhtohepnhhikhholhgrrdhprhhi
 tggrsegrmhgurdgtohhmpdhrtghpthhtohepuggvjhgrnhdrrghnughjvghlkhhovhhitg
 esrghmugdrtghomh
X-ME-Proxy: <xmx:bB5laevmS6H2UYEZ3F7y6sWQxK-6YxvLNwn3d4LpKc_jvr3_VejUWA>
 <xmx:bB5lab7OL9KEWoOMNBekAH2xofZ-Iz-ilQcu69TDT1iZd97dHysrsQ>
 <xmx:bB5laaMqL7EpKpBpMVWDYt8_NzAHWsEqaLbSuHPXIWXucISu0suEvQ>
 <xmx:bB5laZtoHeAMZgeL2kG4WRHUCMY10H4GHQXsO1eLYK-jxbB7jbKnmw>
 <xmx:bB5laQjHiZqWO4PdynYx2A1-RPL3dDxObmZEaCdLx9DEQLcbHF4aB2UX>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 11:16:43 -0500 (EST)
Date: Mon, 12 Jan 2026 09:16:41 -0700
From: Alex Williamson <alex@shazbot.org>
To: Manojlo Pekovic <manojlo.pekovic@amd.com>
Cc: <qemu-devel@nongnu.org>, <alex.williamson@redhat.com>, <clg@redhat.com>,
 <nikola.prica@amd.com>, <dejan.andjelkovic@amd.com>
Subject: Re: [PATCH] vfio/pci: Enable atomic ops for multifunction devices
Message-ID: <20260112091641.4d86d8e5@shazbot.org>
In-Reply-To: <20251209143250.714546-1-manojlo.pekovic@amd.com>
References: <20251209143250.714546-1-manojlo.pekovic@amd.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=202.12.124.148; envelope-from=alex@shazbot.org;
 helo=fout-b5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Tue, 9 Dec 2025 14:32:50 +0000
Manojlo Pekovic <manojlo.pekovic@amd.com> wrote:

> Previously, PCIe Atomic Ops support was only enabled for single
> function devices due to potential conflicting capabilities between
> functions. This patch enables atomic ops for multifunction devices
> by finding the common subset of atomic capabilities supported by
> all functions.
> 
> The implementation checks all functions on the same slot and
> advertises only the atomic operations supported by all of them,
> ensuring compatibility across the multifunction device.
> 
> Signed-off-by: Manojlo Pekovic <manojlo.pekovic@amd.com>
> ---
>  hw/vfio/pci.c | 104 +++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 77 insertions(+), 27 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 14bcc725c3..9d1faeabff 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1900,28 +1900,88 @@ static void vfio_add_emulated_long(VFIOPCIDevice *vdev, int pos,
>      vfio_set_long_bits(vdev->emulated_config_bits + pos, mask, mask);
>  }
>  
> -static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
> +static uint32_t vfio_get_atomic_cap(VFIOPCIDevice *vdev)
>  {
> -    struct vfio_device_info_cap_pci_atomic_comp *cap;
>      g_autofree struct vfio_device_info *info = NULL;
> +    struct vfio_info_cap_header *hdr;
> +    struct vfio_device_info_cap_pci_atomic_comp *cap;
> +    uint32_t mask = 0;
> +
> +    info = vfio_get_device_info(vdev->vbasedev.fd);
> +    if (!info) {
> +        return mask;
> +    }
> +
> +    hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_PCI_ATOMIC_COMP);
> +    if (!hdr) {
> +        return mask;
> +    }
> +
> +    cap = (void *)hdr;
> +    if (cap->flags & VFIO_PCI_ATOMIC_COMP32) {
> +        mask |= PCI_EXP_DEVCAP2_ATOMIC_COMP32;
> +    }
> +    if (cap->flags & VFIO_PCI_ATOMIC_COMP64) {
> +        mask |= PCI_EXP_DEVCAP2_ATOMIC_COMP64;
> +    }
> +    if (cap->flags & VFIO_PCI_ATOMIC_COMP128) {
> +        mask |= PCI_EXP_DEVCAP2_ATOMIC_COMP128;
> +    }
> +
> +    return mask;
> +}
> +
> +/* Returns biggest subset of supported atomic ops of multifunction device */
> +static uint32_t vfio_get_multifunction_atomic_cap(VFIOPCIDevice *vdev,
> +                                                    PCIBus *bus)
> +{
> +    PCIDevice *func_dev;
> +    VFIOPCIDevice *func_vdev;
> +    int slot = PCI_SLOT(vdev->pdev.devfn);
> +    int target_devfn;
> +    uint32_t common_mask = PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
> +                           PCI_EXP_DEVCAP2_ATOMIC_COMP64 |
> +                           PCI_EXP_DEVCAP2_ATOMIC_COMP128;
> +
> +    for (int fn = 0; fn < PCI_FUNC_MAX; fn++) {
> +        target_devfn = PCI_DEVFN(slot, fn);
> +        func_dev = pci_find_device(bus, pci_bus_num(bus), target_devfn);
> +        uint32_t func_mask = 0;
> +
> +        if (!func_dev) {
> +            continue;
> +        }
> +
> +        func_vdev = (VFIOPCIDevice *)object_dynamic_cast(OBJECT(func_dev),
> +                                                            TYPE_VFIO_PCI);
> +        if (!func_vdev) {
> +            continue;
> +        }

Why is it justified to continue here?  It at least seems worthy of a
comment why we can ignore non-vfio-pci devices relative to the
advertised atomic op support.

> +
> +        func_mask = vfio_get_atomic_cap(func_vdev);
> +
> +        common_mask &= func_mask;

Factor out func_mask.

> +    }
> +
> +    return common_mask;
> +}
> +
> +static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
> +{
>      PCIBus *bus = pci_get_bus(&vdev->pdev);
>      PCIDevice *parent = bus->parent_dev;
> -    struct vfio_info_cap_header *hdr;
>      uint32_t mask = 0;
>      uint8_t *pos;
>  
>      /*
>       * PCIe Atomic Ops completer support is only added automatically for single
>       * function devices downstream of a root port supporting DEVCAP2.  Support
> -     * is added during realize and, if added, removed during device exit.  The
> -     * single function requirement avoids conflicting requirements should a
> -     * slot be composed of multiple devices with differing capabilities.
> +     * is added during realize and, if added, removed during device exit.
>       */
>      if (pci_bus_is_root(bus) || !parent || !parent->exp.exp_cap ||
>          pcie_cap_get_type(parent) != PCI_EXP_TYPE_ROOT_PORT ||
>          pcie_cap_get_version(parent) != PCI_EXP_FLAGS_VER2 ||
> -        vdev->pdev.devfn ||
> -        vdev->pdev.cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
> +        vdev->pdev.devfn) {
>          return;
>      }
>  
> @@ -1934,25 +1994,15 @@ static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
>          return;
>      }
>  
> -    info = vfio_get_device_info(vdev->vbasedev.fd);
> -    if (!info) {
> -        return;
> -    }
> -
> -    hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_PCI_ATOMIC_COMP);
> -    if (!hdr) {
> -        return;
> -    }
> -
> -    cap = (void *)hdr;
> -    if (cap->flags & VFIO_PCI_ATOMIC_COMP32) {
> -        mask |= PCI_EXP_DEVCAP2_ATOMIC_COMP32;
> -    }
> -    if (cap->flags & VFIO_PCI_ATOMIC_COMP64) {
> -        mask |= PCI_EXP_DEVCAP2_ATOMIC_COMP64;
> -    }
> -    if (cap->flags & VFIO_PCI_ATOMIC_COMP128) {
> -        mask |= PCI_EXP_DEVCAP2_ATOMIC_COMP128;

Nit, it would have been cleaner to factor out this helper as a
precursor to multifunction support.  Thanks,

Alex

> +    if (vdev->pdev.cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
> +        /*
> +         * Only process the through the root function
> +         * We get through here only on function 0,
> +         * through check vdev->pdev.devfn
> +         */
> +        mask = vfio_get_multifunction_atomic_cap(vdev, bus);
> +    } else {
> +        mask = vfio_get_atomic_cap(vdev);
>      }
>  
>      if (!mask) {


