Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E26E7FDE0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 22:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn28m-0005g0-SH; Mon, 02 Feb 2026 17:11:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1vn28Z-0005QY-Lx
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 17:11:21 -0500
Received: from fout-a3-smtp.messagingengine.com ([103.168.172.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1vn28X-0003H4-Gk
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 17:11:15 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 4DA99EC011F;
 Mon,  2 Feb 2026 17:11:11 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Mon, 02 Feb 2026 17:11:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1770070271;
 x=1770156671; bh=PRAbBoU7jtLdO4Q4hEEIuypjeDd2RkyyL/Rtl1co6BQ=; b=
 jsETRkfe3wDgBhhcIM7g+XtKJSVbsYjgWNykA68NjlFUJDcNM0GtoyaXsHWg/PT3
 C3qh6Edmfzjeks90eAxNh0H2NcNIUDgA/bwFTK+ph7OmE6h7EdqYGqmVFaK++cv4
 5xD7rZJ32xzhpjGgVS+r1xDHXB+07sOHCF0xYLs3eZvJqDQuxdda/uOAeinN+HvS
 l0WsvhaISZAJaRfyythxlJsj1ki5htpQTa6adtHvFO6nAQdHXh5itRW9y63d+JST
 ZkuU/zSmGqE9Z/jNFWcHTTpQA4iRR8I5ujyJ74t9h6gtuWavH0GqXku+y0Wld/c6
 jnqxWNQDjwztohk9mpipiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770070271; x=
 1770156671; bh=PRAbBoU7jtLdO4Q4hEEIuypjeDd2RkyyL/Rtl1co6BQ=; b=s
 LeLtiFiOL6VcFyjIyfVavZ655zuB8IKx87Q/VDyBa+VCNq/VV3JCBeQaXF7SfEia
 QQml0Uauzs5JNHnRTD1QDQ2lhao7nSqKQuGju+r4YBfU8KqpE2XLe3TKOj6n7NZu
 WEUjb/sm1xWxB1aa2QuAvXGh064jycYWvgoZhZyTGfnAgcE21ZUkuW/RLAYe9QnO
 t34zJBcX0pAy59ZUoMH9jf7//ipFWeJ0YwmecoHV5q3b+kN5XeSzGZuXgotsXOUv
 NwA7Sebodatvzee+KpHuHpenZQF4TY6h8AXVqOrfL/1UwxXLge8V41t4R/gxKOpr
 goB2Iawv2ShEpzkLgRSqQ==
X-ME-Sender: <xms:_yCBafzJAsJ_Xowo7CFkMqzKtk9pL21WIiJQvX4b_ku1esi3kK-cuw>
 <xme:_yCBaSu2jifefLMvFtCTYIvL5uhPjggvC0wKqrZMsDllOrg9BzbateWet5LaTbfIA
 2GjmZWBZIBCIdODfAs3i2mIh7SUCBYixZHgjtiPU7flbvBkUDcx0Q>
X-ME-Received: <xmr:_yCBac1F_dBe07Cm0zxSiyPzrLeQ1FVRvdHBhfb1620E09YAxD8QUrkMPaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekkeduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepfffhvfevuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpeetlhgvgicu
 hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
 htthgvrhhnpeegudevhfejueefveduieeuueeifeettdekveekhffgvdetfeelueehgfdt
 heffhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohephedpmhhouggvpehs
 mhhtphhouhhtpdhrtghpthhtohepmhgrnhhojhhlohdrphgvkhhovhhitgesrghmugdrtg
 homhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghp
 thhtohepnhhikhholhgrrdhprhhitggrsegrmhgurdgtohhmpdhrtghpthhtohepuggvjh
 grnhdrrghnughjvghlkhhovhhitgesrghmugdrtghomhdprhgtphhtthhopegtlhhgsehr
 vgguhhgrthdrtghomh
X-ME-Proxy: <xmx:_yCBad_MtcIb97nz3nhkWoXqXOlZsJ52W2hOv4WSxHaVMFoQjlOgKQ>
 <xmx:_yCBadMnHyCP8GiPmSDChid3eB9N5xn6rE5-wAoIus7vG3iEnNp7qQ>
 <xmx:_yCBaRexMOGM-hOxveEZSNOHpc1tfmx-QJcM5DU0T_Rc8TiMAJd1Rg>
 <xmx:_yCBacXNHwlxB_j_K3lG6dtyOniIiaGBsFBvqsVSl9vKUjFgwF5i9g>
 <xmx:_yCBacxc1LpkQkMkhj8j6K-GyYXf5KakFU9AQzU5i2DxpX7a1Yd03x6k>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 17:11:10 -0500 (EST)
Date: Mon, 2 Feb 2026 15:11:09 -0700
From: Alex Williamson <alex@shazbot.org>
To: "Pekovic, Manojlo" <Manojlo.Pekovic@amd.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Prica, Nikola"
 <Nikola.Prica@amd.com>, "Andjelkovic, Dejan" <Dejan.Andjelkovic@amd.com>,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH] vfio/pci: Enable atomic ops for multifunction devices
Message-ID: <20260202151109.4f3a3c42@shazbot.org>
In-Reply-To: <CH0PR12MB5283A1315E28D8A347AF222EFA9AA@CH0PR12MB5283.namprd12.prod.outlook.com>
References: <20251209143250.714546-1-manojlo.pekovic@amd.com>
 <20260112091641.4d86d8e5@shazbot.org>
 <CH0PR12MB5283B2F97D090DA29776370FFA89A@CH0PR12MB5283.namprd12.prod.outlook.com>
 <CH0PR12MB52830768E66CE6734381065EFA89A@CH0PR12MB5283.namprd12.prod.outlook.com>
 <CH0PR12MB52839D25259B76151B3002ABFA89A@CH0PR12MB5283.namprd12.prod.outlook.com>
 <CH0PR12MB5283A1315E28D8A347AF222EFA9AA@CH0PR12MB5283.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.146; envelope-from=alex@shazbot.org;
 helo=fout-a3-smtp.messagingengine.com
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

On Mon, 2 Feb 2026 09:11:28 +0000
"Pekovic, Manojlo" <Manojlo.Pekovic@amd.com> wrote:

> [AMD Official Use Only - AMD Internal Distribution Only]
>=20
> Hi Alex,
>=20
> Is there any new info on this issue?
>=20
> Thanks in advance,
> Manojlo Pekovic
> Software Development Engineer 2
> Cloud Software Team
>=20
>=20
>=20
> -----Original Message-----
> From: Pekovic, Manojlo
> Sent: Tuesday, January 20, 2026 5:01 PM
> To: 'Alex Williamson' <alex@shazbot.org>; 'qemu-devel@nongnu.org' <qemu-d=
evel@nongnu.org>
> Cc: Prica, Nikola <Nikola.Prica@amd.com>; Andjelkovic, Dejan <Dejan.Andje=
lkovic@amd.com>; 'C=C3=A9dric Le Goater' <clg@redhat.com>
> Subject: RE: [PATCH] vfio/pci: Enable atomic ops for multifunction devices
>=20
> Hi Alex,
>=20
> Here is the second part of the patch.
> I didn't take into consideration the non-vfio-device in my first patch.
> I fixed it by using standard that I saw in the code for getting vdev in t=
his scenario, hope that it is satisfactory now
>=20
> Previously, PCIe Atomic Ops support was only enabled for single function =
devices due to potential conflicting capabilities between functions.
> This patch enables atomic ops for multifunction devices by finding the co=
mmon subset of atomic capabilities supported by all functions.
>=20
> The implementation checks all functions on the same slot and advertises o=
nly the atomic operations supported by all of them, ensuring compatibility =
across the multifunction device.
>=20
> Signed-off-by: Manojlo Pekovic <manojlo.pekovic@amd.com>
> ---
>  hw/vfio/pci.c | 47 +++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 41 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c index 6a6c8f1807..a6723063ab 1=
00644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1931,6 +1931,34 @@ static uint32_t vfio_get_atomic_cap(VFIOPCIDevice =
*vdev)
>      return mask;
>  }
>=20
> +/* Returns biggest subset of supported atomic ops of multifunction
> +device */ static uint32_t vfio_get_multifunction_atomic_cap(VFIOPCIDevic=
e *vdev,
> +                                                    PCIBus *bus) {
> +    PCIDevice *func_dev;
> +    VFIOPCIDevice *func_vdev;
> +    int slot =3D PCI_SLOT(vdev->pdev.devfn);
> +    int target_devfn;
> +    uint32_t common_mask =3D PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
> +                           PCI_EXP_DEVCAP2_ATOMIC_COMP64 |
> +                           PCI_EXP_DEVCAP2_ATOMIC_COMP128;
> +
> +    for (int fn =3D 0; fn < PCI_FUNC_MAX; fn++) {
> +        target_devfn =3D PCI_DEVFN(slot, fn);
> +        func_dev =3D pci_find_device(bus, pci_bus_num(bus),
> + target_devfn);
> +
> +        if (!func_dev) {
> +            continue;
> +        }
> +
> +        func_vdev =3D VFIO_PCI(func_dev);

As Cedric notes, best to send a v2 rather than bury new revisions in
replies.  However, I think this was actually better in the first
version.  Previously it was unclear how we could skip taking
non-vfio-pci device atomic ops support into account when creating the
common mask.  This implementation will segfault if it encounters the
condition of a multi-function device composed of vfio-pci and
non-vfio-pci devices.

Also, since this is called from the function zero realize path, can we
actually rely on the other functions being populated yet?  It seems
like this would need to be evaluated in some sort of machine ready
context.  Thanks,

Alex

> +
> +        common_mask &=3D vfio_get_atomic_cap(func_vdev);;
> +    }
> +
> +    return common_mask;
> +}
> +
>  static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)  {
>      PCIBus *bus =3D pci_get_bus(&vdev->pdev); @@ -1941,15 +1969,12 @@ st=
atic void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
>      /*
>       * PCIe Atomic Ops completer support is only added automatically for=
 single
>       * function devices downstream of a root port supporting DEVCAP2.  S=
upport
> -     * is added during realize and, if added, removed during device exit=
.  The
> -     * single function requirement avoids conflicting requirements shoul=
d a
> -     * slot be composed of multiple devices with differing capabilities.
> +     * is added during realize and, if added, removed during device exit.
>       */
>      if (pci_bus_is_root(bus) || !parent || !parent->exp.exp_cap ||
>          pcie_cap_get_type(parent) !=3D PCI_EXP_TYPE_ROOT_PORT ||
>          pcie_cap_get_version(parent) !=3D PCI_EXP_FLAGS_VER2 ||
> -        vdev->pdev.devfn ||
> -        vdev->pdev.cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
> +        vdev->pdev.devfn) {
>          return;
>      }
>=20
> @@ -1961,8 +1986,18 @@ static void vfio_pci_enable_rp_atomics(VFIOPCIDevi=
ce *vdev)
>                               PCI_EXP_DEVCAP2_ATOMIC_COMP128)) {
>          return;
>      }
> +
>=20
> -    mask =3D vfio_get_atomic_cap(vdev);
> +    if (vdev->pdev.cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
> +        /*
> +         * Only process the through the root function
> +         * We get through here only on function 0,
> +         * through check vdev->pdev.devfn
> +         */
> +        mask =3D vfio_get_multifunction_atomic_cap(vdev, bus);
> +    } else {
> +        mask =3D vfio_get_atomic_cap(vdev);
> +    }
>=20
>      if (!mask) {
>          return;
> --
> 2.43.0

