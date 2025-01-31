Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE4D6C0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 19:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdwMs-0008Hq-Hy; Fri, 31 Jan 2025 14:07:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tdwMp-0008HO-Jz
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 14:07:52 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tdwMn-0005sn-Kf
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 14:07:51 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yl5263mW6z6M4T9;
 Sat,  1 Feb 2025 03:05:34 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 455EE140A86;
 Sat,  1 Feb 2025 03:07:43 +0800 (CST)
Received: from localhost (10.195.244.178) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 31 Jan
 2025 20:07:42 +0100
Date: Fri, 31 Jan 2025 19:07:41 +0000
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
CC: Jonathan Cameron via <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, <mst@redhat.com>
Subject: Re: [PATCH 2/2] hw/cxl: Allow tracing component I/O accesses
Message-ID: <20250131190741.000049cc@huawei.com>
In-Reply-To: <d5749a49-a12f-4485-b2f1-189b3d9cc89e@linaro.org>
References: <20250122065624.34203-1-philmd@linaro.org>
 <20250122065624.34203-3-philmd@linaro.org>
 <20250123095151.000041a0@huawei.com>
 <20250124162028.0000464b@huawei.com>
 <d5749a49-a12f-4485-b2f1-189b3d9cc89e@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.195.244.178]
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 24 Jan 2025 17:28:02 +0100
Philippe Mathieu-Daud=E9 <philmd@linaro.org> wrote:

> On 24/1/25 17:20, Jonathan Cameron wrote:
> > On Thu, 23 Jan 2025 09:51:51 +0000
> > Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
> >  =20
> >> On Wed, 22 Jan 2025 07:56:24 +0100
> >> Philippe Mathieu-Daud=E9 <philmd@linaro.org> wrote:
> >> =20
> >>> Map the component I/O region as UnimplementedDevice
> >>> to be able to trace guest I/O accesses with '-d unimp'.
> >>>
> >>> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org> =20
> >> I'm not that familiar with this infrastructure but seems
> >> fine to me.
> >>
> >> I'd definitely be curious if anything is touching this space so
> >> tracing may be helpful for that! =20
> > Hi Philippe
> >  =20
> >>
> >> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> =20
> > Retract that.
> >=20
> > Can't instantiate a CXL device with this patch because:
> >=20
> > Device unimplemented-device can not be dynamically instantiated. =20
>=20
> Hmm the qtests using CXL devices pass, how do you trigger that?

Seems oddly enough to be arm64 only (well not x86 - there is
no support for other arches than those two) which isn't upstream yet
hence no tests upstream - I'll get back to that sometime soonish
as the blocker of dt-bindings for PXBs may be less of an issue than it was.

source of that print seems to be hw/core/sysbus-fdt.c
add_fdt_node(). Seems it is looking for sysbus devices and gets
confused when it finds this one. I'm not sure if it is in
/peripheral or /peripheral-anon.

For now you could try my gitlab tree
gitlab.com/jic23/qemu.git   cxl-* whatever has latest date.

Or shout if you want me to try anything.

Jonathan


>=20
> >=20
> > Reverting this patch on my tree fixes that.
> >  =20
> >>> ---
> >>>   include/hw/cxl/cxl_component.h |  3 ++-
> >>>   hw/cxl/cxl-component-utils.c   | 14 +++++++++++---
> >>>   hw/cxl/Kconfig                 |  1 +
> >>>   3 files changed, 14 insertions(+), 4 deletions(-) =20
>=20


