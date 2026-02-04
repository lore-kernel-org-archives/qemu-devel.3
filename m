Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA4EE8B399
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 04:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnUQV-0003uG-Re; Tue, 03 Feb 2026 23:23:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1vnUQU-0003u7-S4
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 23:23:38 -0500
Received: from fout-b7-smtp.messagingengine.com ([202.12.124.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1vnUQS-0004HT-D6
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 23:23:38 -0500
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 569E81D0011C;
 Tue,  3 Feb 2026 23:23:33 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Tue, 03 Feb 2026 23:23:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1770179013;
 x=1770265413; bh=/WgdSsNCntby7XMSIdz0zkncGUXCX3d0acE8JmCn+nI=; b=
 dQezSIIYlReEPpmgn/9Z1ZV1G3h3fT2ZeZ0shijOuqJk8iJOzZVkw+HSElsA8IcW
 4CBWQ3w2QWMDeJpOxEg0lFguGt2yMiOF2AcfcbB9Tddf5zzAEZcsOhAGkOT4eVDA
 Upfbk9KjiKiEMX6bImqYUKebZxexI+R2cevqg4nNf7CvqzmC7mDRNHM8cZaPJX+a
 T8qE40/0bUF5Wr+a7iPdLnyXWs8pXfeQ1ZsxB4YnKnYrvYBpl3gKbu9y4OTNnPYz
 L1qEW1PuTWKRRUrDu1+XmhEPLKZBsxcyYHxEg2D6YowfpOQTxgxtssfJL95nQVpV
 zTXR6L/t94LSE70Q3VNqig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770179013; x=
 1770265413; bh=/WgdSsNCntby7XMSIdz0zkncGUXCX3d0acE8JmCn+nI=; b=H
 NlLV25pSCDZ6zQEaxCuESors0ZW8bgODc/L1vtxBHu9WSR5kNc881g/i7LZm4PpP
 j3WUlSjRVHzByFofThCKNG/9ViFyW3G8vy/mgHEi82DuIv9c/XKiC63rEWwpBl3h
 87wdv3/PsnjDN9qnYAPxNjH76yJ1C39wFm7uqGCChFd4QRXUF8ZfhgE/JKLS8IBl
 5n5ZQNZvBpbWXr0FD+HoSEV6QwVArVeuq9XH2lPhi4UGR4tzlVD7UHER9Y+frphi
 ZE4Z6zlwYzXrLdc+Z/X4X4FCPt3/QHG3gRr5FMsdfb4oCIcxZSqo1TmIQoCV/naa
 J61pVsKCylH2DrymoUysQ==
X-ME-Sender: <xms:xMmCaTkqfTh6bVrtbjK5Q_ktbA6nG77gwJtOKDddQy-UJohEZwACXg>
 <xme:xMmCafyJwt9EytbA4WozUc8UDcz480ziACsKJVl-kAv2tM1ZwF_UEIbxE4gdCRxaw
 8juJGjNJu0-IysJSSzuJxeNyDbcwmIWMTZzDWdMp5s5ZsumN1zd>
X-ME-Received: <xmr:xMmCaVNwViCxKCVRdpSd9hFLOxmS7N1pYR8xFSC_rscIM-67bVODwDgLxKE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedukeduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepfffhvfevuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpeetlhgvgicu
 hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
 htthgvrhhnpeegudevhfejueefveduieeuueeifeettdekveekhffgvdetfeelueehgfdt
 heffhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepiedpmhhouggvpehs
 mhhtphhouhhtpdhrtghpthhtohepmhgrnhhojhhlohdrphgvkhhovhhitgesrghmugdrtg
 homhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghp
 thhtoheptghlghesrhgvughhrghtrdgtohhmpdhrtghpthhtohepnhhikhholhgrrdhprh
 hitggrsegrmhgurdgtohhmpdhrtghpthhtohepuggvjhgrnhdrrghnughjvghlkhhovhhi
 tgesrghmugdrtghomhdprhgtphhtthhopehmphgvkhhovhhitgesrghmugdrtghomh
X-ME-Proxy: <xmx:xMmCabqmresnc7pJA9hNubWWBVfxH1map7ux2cTdLjrdDdNu6Qeu5A>
 <xmx:xMmCaeFz9qTeY8Wx8dxO-Ejee9EHqbIobt45-VZzzokd6nkVxhU4mw>
 <xmx:xMmCaYrsZH7OleaRrdRyc2pXvszT7HLZI5wNZRBi502GxZHnG3v7gA>
 <xmx:xMmCafaBKp9IUeCwx05N1KyC38ILJ4vwovPv57aWn53H5wXUmW0rZQ>
 <xmx:xcmCaU-umy95HoJzBAeTyMPCvJuE7izkcceXLuPUwdGlYDRvbcw9toNP>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 23:23:32 -0500 (EST)
Date: Tue, 3 Feb 2026 21:23:30 -0700
From: Alex Williamson <alex@shazbot.org>
To: Manojlo Pekovic <manojlo.pekovic@amd.com>
Cc: <qemu-devel@nongnu.org>, <clg@redhat.com>, <Nikola.Prica@amd.com>,
 <Dejan.Andjelkovic@amd.com>, Manojlo Pekovic <mpekovic@amd.com>
Subject: Re: [PATCH 2/2] vfio/pci: Support multifunction atomic ops capability
Message-ID: <20260203212330.56e07330@shazbot.org>
In-Reply-To: <20260203154112.1668-3-manojlo.pekovic@amd.com>
References: <20260203154112.1668-1-manojlo.pekovic@amd.com>
 <20260203154112.1668-3-manojlo.pekovic@amd.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=202.12.124.150; envelope-from=alex@shazbot.org;
 helo=fout-b7-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Tue, 3 Feb 2026 16:41:12 +0100
Manojlo Pekovic <manojlo.pekovic@amd.com> wrote:

> From: Manojlo Pekovic <mpekovic@amd.com>
>=20
> Extend PCIe Atomic Ops completer support to multifunction vfio-pci
> devices by calculating the common subset of atomic capabilities across
> all functions.
>=20
> For multifunction devices, we now:
> 1. Calculate the intersection of atomic capabilities across all functions
> 2. Only enable capabilities that ALL functions with atomic support share
> 3. Functions without atomic support are skipped (not penalized)
>=20
> During vfio_realize(), other functions in a multifunction device may not
> be realized yet, making it impossible to enumerate all functions. We
> defer atomic ops configuration to machine_done time for multifunction
> devices, ensuring all functions are realized before calculating common
> capabilities.

Exactly what are we trying to enable with this support?  Why do we need
multifunction AtomicOps support versus multiple single function
assignments under separate root ports?
=20
> Signed-off-by: Manojlo Pekovic <mpekovic@amd.com>
> ---
>  hw/vfio/pci.c | 138 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  hw/vfio/pci.h |   1 +
>  2 files changed, 137 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 6a6c8f1807..89f171f431 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1931,6 +1931,67 @@ static uint32_t vfio_get_atomic_cap(VFIOPCIDevice =
*vdev)
>      return mask;
>  }
> =20
> +static void vfio_pci_machine_done(Notifier *notifier, void *data);

Why aren't these ordered to avoid the forward declaration?

> +
> +/*
> + * This function iterates through all possible functions (0-7)
> + * at the same slot and returns the intersection of their capabilities.
> + *
> + * Returns: Bitmask of atomic capabilities supported by functions on slot
> + *          (PCI_EXP_DEVCAP2_ATOMIC_COMP32/64/128), or 0 if:
> + *          - Mixed device types found (vfio-pci + emulated)
> + *          - No common capabilities exist
> + */
> +static uint32_t vfio_get_multifunction_atomic_cap(VFIOPCIDevice *vdev,
> +                                                    PCIBus *bus)
> +{
> +    PCIDevice *func_dev;
> +    VFIOPCIDevice *func_vdev;
> +    int slot =3D PCI_SLOT(vdev->pdev.devfn);
> +    int target_devfn;
> +    uint32_t func_cap;
> +    uint32_t common_mask =3D PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
> +                           PCI_EXP_DEVCAP2_ATOMIC_COMP64 |
> +                           PCI_EXP_DEVCAP2_ATOMIC_COMP128;
> +
> +    /* Iterate through all possible functions at this slot */
> +    for (int fn =3D 0; fn < PCI_FUNC_MAX; fn++) {
> +        target_devfn =3D PCI_DEVFN(slot, fn);
> +        func_dev =3D pci_find_device(bus, pci_bus_num(bus), target_devfn=
);
> +
> +        if (!func_dev) {
> +            continue;
> +        }
> +
> +        /*
> +         * We can only calculate atomic caps for vfio-pci devices. If we
> +         * encounter a mixed multifunction device (e.g., vfio-pci functi=
on 0
> +         * + emulated e1000 function 1), we cannot safely determine the =
atomic
> +         * capabilities. Taking the conservative approach: disable all a=
tomic
> +         * ops for mixed configurations.
> +         */
> +
> +        func_vdev =3D (VFIOPCIDevice *)object_dynamic_cast(OBJECT(func_d=
ev),
> +                                                        TYPE_VFIO_PCI);
> +        if (!func_vdev) {
> +            return 0;
> +        }
> +
> +        /*
> +         * A function with no atomic completer support simply cannot
> +         * receive and execute atomic operations.
> +         * This does NOT mean other functions in the same multifunction
> +         * device should be prevented from supporting atomics.
> +         */
> +        func_cap =3D vfio_get_atomic_cap(func_vdev);
> +        if (func_cap !=3D 0) {
> +            common_mask &=3D func_cap;
> +        }

It's not clear to me that this is a valid interpretation:

PCIe 7.0, 6.15.2:

	If any Function in a Multi-Function Device supports AtomicOp
	Completer or AtomicOp routing capability, all Functions with
	Memory Space BARs in that device must decode properly formed
	AtomicOp Requests and handle any they don=E2=80=99t support as an
	Unsupported Request (UR). Note that in such devices, Functions
	lacking AtomicOp Completer capability are forbidden to handle
	properly formed AtomicOp Requests as Malformed TLPs.

If we're adding an arbitrary device that may not support AtomicOps into
a virtual multifunction package, how can we know that a device that
doesn't have an AtomicOps cap wouldn't respond with a Malformed TLP
error?

> +    }
> +
> +    return common_mask;
> +}
> +
>  static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
>  {
>      PCIBus *bus =3D pci_get_bus(&vdev->pdev);
> @@ -1948,8 +2009,7 @@ static void vfio_pci_enable_rp_atomics(VFIOPCIDevic=
e *vdev)
>      if (pci_bus_is_root(bus) || !parent || !parent->exp.exp_cap ||
>          pcie_cap_get_type(parent) !=3D PCI_EXP_TYPE_ROOT_PORT ||
>          pcie_cap_get_version(parent) !=3D PCI_EXP_FLAGS_VER2 ||
> -        vdev->pdev.devfn ||
> -        vdev->pdev.cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
> +        vdev->pdev.devfn) {
>          return;
>      }
> =20
> @@ -1962,6 +2022,25 @@ static void vfio_pci_enable_rp_atomics(VFIOPCIDevi=
ce *vdev)
>          return;
>      }
> =20
> +    /*
> +     * Single-function: All device info is available now, configure imme=
diately
> +     * Multifunction: Other functions may not be realized yet, defer to
> +     *                machine_done time when all devices guaranteed to e=
xist
> +     */

This also means that multifunction devices can only support cold-plug
whereas single function devices support AtomicOps with cold-plug and
hot-plug.  The cold-plug device can be unplugged and re-added and it
will have different behavior.

Additionally, it seems we only enable AtomicOps if function 0 supports
AtomicOps, what's the basis for that decision?  Based on the previous
comment, the more conservative approach might be that all functions
need to support AtomicOps, but...

Maybe what we really want is for each function to attempt to initialize
the AtomicOps bits on the root port.  The last realized function should
get it correct regardless of the order the functions are realized,
though we'll need to track our 'Abort if already configured' strategy
differently.

I tossed out this machine_done notifier as a possibility, but I'd
rather avoid it.


> +    if (vdev->pdev.cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
> +        /*
> +         * Register machine_done notifier if not already registered.
> +         * The notifier will be called after all devices are realized, a=
t which
> +         * point we can safely enumerate all functions and calculate the=
 common
> +         * atomic capabilities.
> +         */
> +        if (!vdev->machine_done.notify) {
> +            vdev->machine_done.notify =3D vfio_pci_machine_done;
> +            qemu_add_machine_init_done_notifier(&vdev->machine_done);
> +        }
> +        return;  /* Actual work deferred to vfio_pci_machine_done() */
> +    }
> +
>      mask =3D vfio_get_atomic_cap(vdev);
> =20
>      if (!mask) {
> @@ -1972,6 +2051,51 @@ static void vfio_pci_enable_rp_atomics(VFIOPCIDevi=
ce *vdev)
>      vdev->clear_parent_atomics_on_exit =3D true;
>  }
> =20
> +/*
> + * Called at machine_done time, after ALL devices are realized
> + * but before the VM starts running.
> + *
> + * For multifunction devices, we need to calculate atomic capabilities
> + * across all functions. During realize of function 0, the other functio=
ns
> + * (1-7) may not exist yet. By deferring to machine_done time, we ensure
> + * all functions are realized and can be safely enumerated.
> + */
> +static void vfio_pci_machine_done(Notifier *notifier, void *data)
> +{
> +    VFIOPCIDevice *vdev =3D container_of(notifier, VFIOPCIDevice, machin=
e_done);
> +    PCIBus *bus =3D pci_get_bus(&vdev->pdev);
> +    PCIDevice *parent =3D pci_bridge_get_device(bus);
> +    uint32_t mask;
> +    uint8_t *pos;
> +
> +    /*
> +     * Sanity checks: Should always pass since vfio_pci_enable_rp_atomic=
s()
> +     * already validated these conditions before registering this notifi=
er.
> +     */
> +    if (!parent || !parent->exp.exp_cap) {
> +        return;
> +    }
> +
> +    pos =3D parent->config + parent->exp.exp_cap + PCI_EXP_DEVCAP2;
> +
> +    /* Abort if there'a already an Atomic Ops configuration on the root =
port */
> +
> +    if (pci_get_long(pos) & (PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
> +                             PCI_EXP_DEVCAP2_ATOMIC_COMP64 |
> +                             PCI_EXP_DEVCAP2_ATOMIC_COMP128)) {
> +        return;
> +    }
> +
> +    mask =3D vfio_get_multifunction_atomic_cap(vdev, bus);
> +
> +    if (!mask) {
> +        return;
> +    }
> +
> +    pci_long_test_and_set_mask(pos, mask);
> +    vdev->clear_parent_atomics_on_exit =3D true;
> +}

Duplication relative to vfio_pci_enable_rp_atomics() should be
refactored if we keep it.  Thanks,

Alex

> +
>  static void vfio_pci_disable_rp_atomics(VFIOPCIDevice *vdev)
>  {
>      if (vdev->clear_parent_atomics_on_exit) {
> @@ -3281,6 +3405,16 @@ static void vfio_exitfn(PCIDevice *pdev)
>      VFIOPCIDevice *vdev =3D VFIO_PCI(pdev);
>      VFIODevice *vbasedev =3D &vdev->vbasedev;
> =20
> +    /*
> +     * Remove machine_done notifier if it was registered.
> +     * This happens for multifunction devices where function 0 registered
> +     * a notifier to defer atomic ops configuration to machine_done time.
> +     */
> +    if (vdev->machine_done.notify) {
> +        qemu_remove_machine_init_done_notifier(&vdev->machine_done);
> +        vdev->machine_done.notify =3D NULL;
> +    }
> +
>      vfio_unregister_req_notifier(vdev);
>      vfio_unregister_err_notifier(vdev);
>      pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 5ad090a229..9182ab0053 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -180,6 +180,7 @@ struct VFIOPCIDevice {
>      bool skip_vsc_check;
>      VFIODisplay *dpy;
>      Notifier irqchip_change_notifier;
> +    Notifier machine_done;
>  };
> =20
>  /* Use uin32_t for vendor & device so PCI_ANY_ID expands and cannot matc=
h hw */


