Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF43C5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 04:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxGwX-0002qy-JJ; Fri, 21 Aug 2026 00:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1wxGwV-0002qP-4k; Fri, 21 Aug 2026 00:33:23 -0400
Received: from canpmsgout05.his.huawei.com ([113.46.200.220])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1wxGwR-0006jD-FT; Fri, 21 Aug 2026 00:33:22 -0400
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=Xxfma5pym43SlojEDrOy6v30g8JtMUCyh52nI6HIn2o=;
 b=j9skg5ThZhTkW5vUtPEreLy+aTcwan97YAf5TLot32sbUwALSOuAlrpyARqfCaRv9f/dQ3WOy
 pDYJhgvHbz2uNsSUBrQG7kzPBvrxkMe2OvCEvC6DgkW+Hu+mgU03cbyxgc2jhcUV6ymcWEOZLxs
 SqJyPXqTslEWzH2/Y6/x8h0=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4hR6bY0wT7z12LDV;
 Fri, 21 Aug 2026 12:22:33 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 3A1C34057F;
 Fri, 21 Aug 2026 12:32:53 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 21 Aug 2026 12:32:47 +0800
Received: from dggpemf200006.china.huawei.com (7.185.36.61) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 21 Aug 2026 12:32:47 +0800
Received: from dggpemf200006.china.huawei.com ([7.185.36.61]) by
 dggpemf200006.china.huawei.com ([7.185.36.61]) with mapi id 15.02.1544.011;
 Fri, 21 Aug 2026 12:32:46 +0800
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, =?iso-8859-1?Q?Alex_Benn=E9e?=
 <alex.bennee@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@mailo.com>, "Pierrick
 Bouvier" <pierrick.bouvier@oss.qualcomm.com>, Peter Maydell
 <peter.maydell@linaro.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 zhenwei pi <zhenwei.pi@linux.dev>, Stefano Garzarella <sgarzare@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, "devel@lists.libvirt.org" <devel@lists.libvirt.org>
Subject: RE: [PATCH 6/6] docs: deprecate virtio-crypto
Thread-Topic: [PATCH 6/6] docs: deprecate virtio-crypto
Thread-Index: AQHdL7xDPMulce9vkkqeI9nS0bLVqLalZXoAgAKFTDA=
Date: Fri, 21 Aug 2026 04:32:46 +0000
Message-ID: <391b6b3c0a0c4284a39d3acb9633b7b9@huawei.com>
References: <20260819-fixes-for-11-2-v1-0-b7981c2cc371@linaro.org>
 <20260819-fixes-for-11-2-v1-6-b7981c2cc371@linaro.org>
 <20260819175408-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260819175408-mutt-send-email-mst@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.54.174]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=113.46.200.220;
 envelope-from=arei.gonglei@huawei.com; helo=canpmsgout05.his.huawei.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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


> -----Original Message-----
> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, August 20, 2026 5:56 AM
> To: Alex Benn=E9e <alex.bennee@linaro.org>
> Cc: qemu-devel@nongnu.org; Philippe Mathieu-Daud=E9 <philmd@mailo.com>;
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>; Peter Maydell
> <peter.maydell@linaro.org>; qemu-arm@nongnu.org; Gonglei (Arei)
> <arei.gonglei@huawei.com>; zhenwei pi <zhenwei.pi@linux.dev>; Stefano
> Garzarella <sgarzare@redhat.com>; Laurent Vivier <lvivier@redhat.com>; Am=
it
> Shah <amit@kernel.org>; Marc-Andr=E9 Lureau
> <marcandre.lureau@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>;
> John Snow <jsnow@redhat.com>; Kevin Wolf <kwolf@redhat.com>; Hanna
> Reitz <hreitz@redhat.com>; qemu-block@nongnu.org; devel@lists.libvirt.org
> Subject: Re: [PATCH 6/6] docs: deprecate virtio-crypto
>=20
> On Wed, Aug 19, 2026 at 10:22:06AM +0100, Alex Benn=E9e wrote:
> > We have outstanding guest exploitable bugs in the code which is fairly
> > complex and needs some serious love to clean it up. As off-CPU
> > cryptography acceleration seems to be waning in popularity lets just
> > deprecate the sub-system with a view to removing it in a couple of
> > cycles.
> >
> > Link: https://gitlab.com/qemu-project/qemu/-/work_items/3625
> > Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> > Cc: Gonglei <arei.gonglei@huawei.com>
>=20
> Let's see what Gonglei thinks.
>=20
Hi Alex, Michael,

Thanks for the patch. As the virtio-crypto maintainer let me first
respond to Michael's three points, then give my formal position on
the deprecation - including a scope clarification that I think the
community should be aware of.

I ACK deprecating virtio-crypto since 11.2, but I want to be
explicit that this is effectively a *subsystem-level* deprecation,
not just a single device:

- In QEMU today, virtio-crypto is the *only* frontend device that
consumes the cryptodev backends (cryptodev-builtin,
cryptodev-vhost-user, cryptodev-lkcf). There is no standalone
vhost-user-crypto device - the vhost-user crypto path is driven
through virtio-crypto as well (virtio_crypto_vhost_status ->
cryptodev_vhost_start). So removing virtio-crypto orphans the
entire backend subsystem, backends/cryptodev-vhost.c, and the
vhost-user crypto session protocol support in hw/virtio/vhost-user.c.

- I'd therefore like the deprecation to cover that scope explicitly
and to plan the cleanup of the backends together with the device,
so we don't leave dead, unmaintained objects behind. This includes
deciding the fate of the recently added cryptodev-lkcf backend.

The basis and commitments behind my ACK:
- The emulation has had a string of guest-exploitable issues
(CVE-2023-3180, CVE-2024-3446, CVE-2024-8612, CVE-2025-14876) and
has been unmigratable since day one (.unmigratable =3D 1), which
indeed undercuts its use in serious virtualization. Maintainer
bandwidth is limited.

- I will keep landing fixes for the known guest-exploitable bugs
during the deprecation window (several are already in flight, e.g.
the asym/akcipher size hardening addressing the CVE-2025-14876
class of issues), so the code stays safe while it is being removed.

Realistic migration path for any existing users (there is no virtio
replacement, so it's honest to say so):

- in-guest CPU crypto (AES-NI/VAES etc.) for the common case, and
- host-side direct assignment of crypto accelerators via VFIO (e.g.
Intel QAT, ConnectX) for the workloads that genuinely need
offload, which is also the better-performing path (avoids vmexit
overhead, as Mohamed noted).

Finally, please let's use the deprecation window to surface any real
users before scheduling the actual removal.

Proposed replacement text for docs/about/deprecated.rst:

The `virtio-crypto` device emulation is quite complex code with a
number of known flaws. It has never been migratable, so it is
unlikely to be used in any serious virtualization setting. Modern
ISAs provide on-CPU cryptography instructions (e.g. AES-NI/VAES,
armv8 crypto extensions), and the Linux kernel deprecated AF_ALG
and dropped its off-CPU accelerator support in Linux 7.2, removing
the primary userspace path for off-CPU crypto acceleration. The
time for this sort of off-load has passed.

> > ---
> >  docs/about/deprecated.rst | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> > index 0c656a968fc..3c22981fc8a 100644
> > --- a/docs/about/deprecated.rst
> > +++ b/docs/about/deprecated.rst
> > @@ -276,6 +276,20 @@ future release. Where no 'dh-params.pem' file is
> > provided, the DH  parameters will be automatically negotiated in
> > accordance with  RFC7919.
> >
> > +Devices
> > +-------
> > +
> > +``virtio-crypto`` (since 11.2)
> > +''''''''''''''''''''''''''''''
> > +
> > +The ``virtio-crypto`` device emulation is quite complex code with a
> > +number of known flaws. It has never been migratable so is unlikely to
> > +be used in any serious virtualization setting. With most modern
> > +systems supporting on-CPU cryptography acceleration via their ISAs
> > +sets
>=20
> ISA sets?
>=20
Fair catch, that phrasing was sloppy. The point is that modern ISAs
expose on-CPU cryptography instructions (x86 AES-NI/VAES, armv8
crypto extensions, RISC-V scalar crypto, s390x KIMD/KM, ...). For the
common case there is no longer a performance win in bouncing the
request to an off-CPU engine.

> > the need for off-CPU acceleration is also reduced. Add to
> > +that the kernel has recently removed the ability to use off-CPU
> > +acceleration
>=20
> did it really? I thought it's just for af_alg?
>=20
You are right. To be precise: the virtio-crypto *driver*
(CONFIG_CRYPTO_DEV_VIRTIO) is still present in the Linux kernel and
is still being maintained (it received fixes for CVE-2024-26753 and,
most recently, CVE-2026-23229). What the kernel actually deprecated
is AF_ALG, whose off-CPU accelerator support was dropped for Linux
7.2 (Eric Biggers), and AF_ALG is the primary userspace path a guest
would use for virtio-crypto (e.g. OpenSSL's afalg engine). The docs
should say exactly that, not "the kernel removed the ability to use
off-CPU acceleration" in general.

> and putting "recently" into cde will not age well.
>=20
Agreed. "recently" is time-dependent and has no place in
deprecated.rst. I'd reference the concrete kernel change instead
(AF_ALG deprecation / offload removal in Linux 7.2), which is
version-stable.

Regards,
-Gonglei


