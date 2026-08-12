Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A86C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 16:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuBsP-0003s0-Cv; Wed, 12 Aug 2026 12:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuBsA-0003iu-Ij; Wed, 12 Aug 2026 12:32:12 -0400
Received: from fout-a3-smtp.messagingengine.com ([103.168.172.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuBs6-0003C2-Cn; Wed, 12 Aug 2026 12:32:10 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id D9123EC01CE;
 Wed, 12 Aug 2026 12:32:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 12 Aug 2026 12:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786552323; x=1786638723; bh=nH6kcuakMQ2SsVnpoSn+atcyoaiKefcm
 s1CSP93mMoc=; b=1D5x3Vevk9jdGXd7/LnFMm2CKiu7I5oJggpJJmRMaYvkszvQ
 4O/J7uUUsnydTetO2OL9MZ6Zb9JO5uPbURkCcaRShaWllj6OeJnMc+PgxwXshmjM
 5zzCM37h5YpH+vJlw2EcH/xW+SnaB5ZLvxgH3pOgV2JdfYNryb/a4GhlEmK/JqkI
 pYa9Gg+i6KdkX9TXGpwrI+HujcHBmJ1nyOtWuXect8EaOoct6qDpkPbJc1DoWXvI
 u5wa1OZMfpthyb7yJn+t0Cc6JcdPPloyWi4V545M564L92i6gSasCHD4We6HSp1D
 CfUNX2oXTGbHfdNSBwZWJubV5KQxWqiO/4reUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786552323; x=
 1786638723; bh=nH6kcuakMQ2SsVnpoSn+atcyoaiKefcms1CSP93mMoc=; b=X
 U7ZMAhPR/iEY+9xVmOhkz315RwexPLv3TC7tdmi2StJi7/VtTtBW0aDwwi5fUBiv
 pot1YCpuSFBmiGLhAN/KnE74TQ3gfwG1bEA6skkmMyZ9wNqqzztayc+RouLE1BcI
 ryyeq7ZmbZb95VJiNZP+OhPNQw4ESwVJvclc5hVPD+Vm9PlssY2XLt+DLG6CIwLt
 u+vx7Q6+/GwWlZ+hTuo2lE/YGhmNEdeUOQTVU138BhDgoXU6HnPwSc/NzGMhUH8I
 mJ+hPyWsYwLLL1lmXnsRsAzJwxwgZ79jl7qWDPbNiIni5BwCO7+2QC/+7CbIO8On
 U3tkGnNCauQjAjZOTkvpw==
X-ME-Sender: <xms:A6B8am6ACffIaGsIwIUvAUFXGi9FgcG1Cs4yQFjvZvTp7lPq-8pw2A>
 <xme:A6B8aiKHpIB9a-eSFH1bB0sNXjQXp0Tte38SEWd8z_-jN5k2nh-K8Imnd49CNH-7y
 iPaBzYhCM28EOg8QyJ6qUEeHgr1opkJ6vXDYuoB2pTZ8ZZ7K4AEr51X>
X-ME-Received: <xmr:A6B8anvxEZLe1l4a1mKmfxKASRaD8u-1kSRvTwom4oa4q03ExBzlB63vMhUDTkBvz4841g>
X-ME-Proxy-Cause: dmFkZTGfZqx43RyUR2OadXaisrQm3T9Fdec28nyUdB7Y3CiKujuqJLYRr8ETsui3f8MpTz
 vXRK65pSRHsVCLeXO0/VTkT5H28QsuUq8+WhKJ85iAWZtUa4KtKc+N6PRbuoO08uOIli9E
 99aY9NaKW/cxB5pdNuRDhDRBGPI3RyRVteQWvqUl3c3Qn+noIZgo4SbBzjMWg9U9TftaN8
 mLrpBJAzSgRFMrlP0kFdv/I11n7sMt6QKmyUZ/dCx4TOYHkB6oYTVWS4kBM84TPgYPpcrO
 eQYB0FdR9LZpAHfzYZS4ZvE06xqdTTWptdzo3MeIC06NZkjfwwEhSluQ+Rb8xn8/pkgQgu
 OtKxU4Tb6hgTZBPCu8A4MkjNSSWWxahABCjStC0mU2RhxFOGAWvQDsJqkOqE7/BhpoKrJC
 tyAapl7PjTJVfciZHC90NnK3IqShV+m0aZU5E/Aw31XU368pOFdP+vGkmLoxccoUSHhUeJ
 NziAwS9p1j8ws2CH5LCRBvSAekPPiLaCqqaW+pMdbECt5+t2Na6PpwVXcm0dAS2FcW9eCf
 OLM6ldvNBU9WGq8eDOGO4AS0iwWcgCFMjV2zCDnhuTtxGgtZcca6mF17lKtiOzAYnVjut8
 2uMBOJCy7HsQ+V2OX2T8f+n4PnpuB15dFKc/3EbHk5LlnGzdgkk/+zbspazA
X-ME-Proxy: <xmx:A6B8apLBqyYsVZNyrqFbvnPxJVdvhtqmleVRIUwK0MN81SkhnAJTEw>
 <xmx:A6B8ao9rVx199ZM0b20BhLzdYF9aiW5TxxcZlZW74WbqEprWW4bwgw>
 <xmx:A6B8aqyl_IShFdzPlRCc5XSmGQ_k2WnQFXaT3-BqlSwEx28VNG_21g>
 <xmx:A6B8at5t1fK7i2MriJqUsftdvlaD79SVTDg_bjH0LvVx62mv3thjbg>
 <xmx:A6B8anYLnqdGw3BNIG8dk1_9m5xWMN8NFJuSvdWdZAWirvFKitmReVPq>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 12:32:02 -0400 (EDT)
Message-ID: <f5b0c7edf64449e78260c5ee0cc1a4b5c6716077.camel@alistair23.me>
Subject: Re: [RFC PATCH v1 11/17] hw/virtio: force modern virtio for a CoVE
 guest
From: Alistair <alistair@alistair23.me>
To: Baolong Duan <blduan@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair23@gmail.com, dbarboza@ventanamicro.com, 
 cxx194832@alibaba-inc.com, zengxiangyi.zxy@alibaba-inc.com
Date: Thu, 13 Aug 2026 02:32:02 +1000
In-Reply-To: <20260731035011.4178103-12-blduan@linux.alibaba.com>
References: <20260731035011.4178103-1-blduan@linux.alibaba.com>
 <20260731035011.4178103-12-blduan@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.146;
 envelope-from=alistair@alistair23.me; helo=fout-a3-smtp.messagingengine.com
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

On Fri, 2026-07-31 at 11:50 +0800, Baolong Duan wrote:
> Devices have no direct access to the memory of a CoVE guest, so DMA
> has
> to be bounced through buffers that the guest shares explicitly.=C2=A0
> Offer
> VIRTIO_F_ACCESS_PLATFORM unconditionally, together with
> VIRTIO_F_VERSION_1 which Linux requires whenever ACCESS_PLATFORM is
> offered.
>=20
> Such a device therefore always negotiates in modern mode, so the
> legacy
> IOMMU_PLATFORM check in virtio-pci does not apply to it either.
>=20
> Signed-off-by: Baolong Duan <blduan@linux.alibaba.com>
> ---
> =C2=A0hw/virtio/virtio-bus.c | 12 ++++++++++++
> =C2=A0hw/virtio/virtio-pci.c |=C2=A0 9 ++++++++-
> =C2=A02 files changed, 20 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
> index 9b545acda3..2e2917236f 100644
> --- a/hw/virtio/virtio-bus.c
> +++ b/hw/virtio/virtio-bus.c
> @@ -29,6 +29,7 @@
> =C2=A0#include "hw/virtio/virtio-bus.h"
> =C2=A0#include "hw/virtio/virtio.h"
> =C2=A0#include "system/address-spaces.h"
> +#include "hw/riscv/cove.h"
> =C2=A0
> =C2=A0/* #define DEBUG_VIRTIO_BUS */
> =C2=A0
> @@ -75,6 +76,17 @@ void virtio_bus_device_plugged(VirtIODevice *vdev,
> Error **errp)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 /*
> +=C2=A0=C2=A0=C2=A0=C2=A0 * Devices cannot access the memory of a CoVE gu=
est directly, so
> all DMA
> +=C2=A0=C2=A0=C2=A0=C2=A0 * has to be bounced through buffers the guest s=
hares
> explicitly: offer
> +=C2=A0=C2=A0=C2=A0=C2=A0 * VIRTIO_F_ACCESS_PLATFORM unconditionally. VIR=
TIO_F_VERSION_1
> has to be
> +=C2=A0=C2=A0=C2=A0=C2=A0 * offered as well because Linux refuses ACCESS_=
PLATFORM without
> it.
> +=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0=C2=A0 if (riscv_cove_vm_active()) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vdev->host_features |=3D 1ULL=
 << VIRTIO_F_ACCESS_PLATFORM;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vdev->host_features |=3D 1ULL=
 << VIRTIO_F_VERSION_1;
> +=C2=A0=C2=A0=C2=A0 }

This feels like a hack that we shouldn't need

Alistair

> +
> =C2=A0=C2=A0=C2=A0=C2=A0 if (klass->device_plugged !=3D NULL) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 klass->device_plugged(qb=
us->parent, &local_err);
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 6f5db5fc42..b257d4a09f 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -34,6 +34,7 @@
> =C2=A0#include "hw/pci/msi.h"
> =C2=A0#include "hw/pci/msix.h"
> =C2=A0#include "hw/core/loader.h"
> +#include "hw/riscv/cove.h"
> =C2=A0#include "system/accel-irq.h"
> =C2=A0#include "system/kvm.h"
> =C2=A0#include "hw/virtio/virtio-pci.h"
> @@ -2048,7 +2049,13 @@ static void
> virtio_pci_device_plugged(DeviceState *d, Error **errp)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
}
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (virtio_host_has_feature(v=
dev, VIRTIO_F_IOMMU_PLATFORM))
> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * A CoVE guest always n=
egotiates in modern mode:
> ACCESS_PLATFORM,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * which shares its feat=
ure bit with IOMMU_PLATFORM, is
> forced
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * together with VERSION=
_1, so this check does not apply.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (virtio_host_has_feature(v=
dev, VIRTIO_F_IOMMU_PLATFORM)
> &&
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !risc=
v_cove_vm_active()) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
error_setg(errp, "VIRTIO_F_IOMMU_PLATFORM was supported
> by"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 " neithe=
r legacy nor transitional device");
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
return;

