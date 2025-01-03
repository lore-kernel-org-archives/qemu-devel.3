Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C6BE77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 14:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTiIh-0005hY-CX; Fri, 03 Jan 2025 09:05:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1tTiIf-0005fP-0V
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 09:05:17 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1tTiIc-00026U-BI
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 09:05:16 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YPlbG58ttz6K9LP;
 Fri,  3 Jan 2025 22:00:42 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
 by mail.maildlp.com (Postfix) with ESMTPS id 68DF91406AC;
 Fri,  3 Jan 2025 22:05:04 +0800 (CST)
Received: from localhost (10.47.74.248) by frapeml500003.china.huawei.com
 (7.182.85.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 3 Jan
 2025 15:05:03 +0100
Date: Fri, 3 Jan 2025 14:04:57 +0000
To: Zhao Liu <zhao1.liu@intel.com>
CC: Rob Herring <robh@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrang" <berrange@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Philippe Mathieu-Daud
 <philmd@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, "Michael S .
 Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Sia Jee Heng
 <jeeheng.sia@starfivetech.com>, <qemu-devel@nongnu.org>,
 <kvm@vger.kernel.org>
Subject: Re: [PATCH v6 0/4] i386: Support SMP Cache Topology
Message-ID: <20250103140457.00004c4b@huawei.com>
In-Reply-To: <Z3efFsigJ6SxhqMf@intel.com>
References: <20241219083237.265419-1-zhao1.liu@intel.com>
 <44212226-3692-488b-8694-935bd5c3a333@redhat.com>
 <Z2t2DuMBYb2mioB0@intel.com> <20250102145708.0000354f@huawei.com>
 <CAL_JsqKeA4dSwO40VgARVAiVM=w1PU8Go8GJYv4v8Wri64UFbw@mail.gmail.com>
 <20250102180141.00000647@huawei.com> <Z3efFsigJ6SxhqMf@intel.com>
Organization: Huawei
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.47.74.248]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500003.china.huawei.com (7.182.85.28)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 3 Jan 2025 16:25:58 +0800
Zhao Liu <zhao1.liu@intel.com> wrote:

> On Thu, Jan 02, 2025 at 06:01:41PM +0000, Alireza Sanaee wrote:
> > Date: Thu, 2 Jan 2025 18:01:41 +0000
> > From: Alireza Sanaee <alireza.sanaee@huawei.com>
> > Subject: Re: [PATCH v6 0/4] i386: Support SMP Cache Topology
> > X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
> >=20
> > On Thu, 2 Jan 2025 11:09:51 -0600
> > Rob Herring <robh@kernel.org> wrote:
> >  =20
> > > On Thu, Jan 2, 2025 at 8:57=E2=80=AFAM Alireza Sanaee
> > > <alireza.sanaee@huawei.com> wrote: =20
> > > >
> > > > On Wed, 25 Dec 2024 11:03:42 +0800
> > > > Zhao Liu <zhao1.liu@intel.com> wrote:
> > > >   =20
> > > > > > > About smp-cache
> > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > >
> > > > > > > The API design has been discussed heavily in [3].
> > > > > > >
> > > > > > > Now, smp-cache is implemented as a array integrated in
> > > > > > > -machine. Though -machine currently can't support JSON
> > > > > > > format, this is the one of the directions of future.
> > > > > > >
> > > > > > > An example is as follows:
> > > > > > >
> > > > > > > smp_cache=3Dsmp-cache.0.cache=3Dl1i,smp-cache.0.topology=3Dco=
re,smp-cache.1.cache=3Dl1d,smp-cache.1.topology=3Dcore,smp-cache.2.cache=3D=
l2,smp-cache.2.topology=3Dmodule,smp-cache.3.cache=3Dl3,smp-cache.3.topolog=
y=3Ddie
> > > > > > >
> > > > > > > "cache" specifies the cache that the properties will be
> > > > > > > applied on. This field is the combination of cache level
> > > > > > > and cache type. Now it supports "l1d" (L1 data cache),
> > > > > > > "l1i" (L1 instruction cache), "l2" (L2 unified cache) and
> > > > > > > "l3" (L3 unified cache).
> > > > > > >
> > > > > > > "topology" field accepts CPU topology levels including
> > > > > > > "thread", "core", "module", "cluster", "die", "socket",
> > > > > > > "book", "drawer" and a special value "default".   =20
> > > > > >
> > > > > > Looks good; just one thing, does "thread" make sense?  I
> > > > > > think that it's almost by definition that threads within a
> > > > > > core share all caches, but maybe I'm missing some hardware
> > > > > > configurations.=20
> > > > >
> > > > > Hi Paolo, merry Christmas. Yes, AFAIK, there's no hardware has
> > > > > thread level cache.   =20
> > > >
> > > > Hi Zhao and Paolo,
> > > >
> > > > While the example looks OK to me, and makes sense. But would be
> > > > curious to know more scenarios where I can legitimately see
> > > > benefit there.
> > > >
> > > > I am wrestling with this point on ARM too. If I were to
> > > > have device trees describing caches in a way that threads get
> > > > their own private caches then this would not be possible to be
> > > > described via device tree due to spec limitations (+CCed Rob)
> > > > if I understood correctly.   =20
> > >=20
> > > You asked me for the opposite though, and I described how you can
> > > share the cache. If you want a cache per thread, then you probably
> > > want a node per thread.
> > >=20
> > > Rob
> > >  =20
> >=20
> > Hi Rob,
> >=20
> > That's right, I made the mistake in my prior message, and you
> > recalled correctly. I wanted shared caches between two threads,
> > though I have missed your answer before, just found it.
> >  =20
>=20
> Thank you all!
>=20
> Alireza, do you know how to configure arm node through QEMU options?

Hi Zhao, do you mean the -smp param?
>=20
> However, IIUC, arm needs more effort to configure cache per thread (by
> configuring node topology)...In that case, since no one has explicitly
> requested the need for cache per thread, I can disable cache per
> thread for now. I can return an error for this scenario during the
> general smp-cache option parsing (in the future, if there is a real
> need, it can be easily re-enabled).
>=20
> Will drop cache per thread in the next version.
>=20
> Thanks,
> Zhao
>=20
>=20


