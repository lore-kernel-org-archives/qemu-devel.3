Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6E6C282D9
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 06:14:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpi1S-00023q-Hz; Wed, 05 Mar 2025 01:14:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tpi1L-0001tp-QQ
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:14:20 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tpi1I-0004R3-SN
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:14:19 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z72J740FGz6D8XX;
 Wed,  5 Mar 2025 14:11:51 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 257E31400D7;
 Wed,  5 Mar 2025 14:14:06 +0800 (CST)
Received: from localhost (10.96.237.92) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 5 Mar
 2025 07:14:04 +0100
Date: Wed, 5 Mar 2025 14:13:59 +0800
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: "Michael S. Tsirkin" <mst@redhat.com>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH] docs/cxl: Add serial number for persistent-memdev
Message-ID: <20250305141359.00001288@huawei.com>
In-Reply-To: <17b91a9f.2847.1955fd23d78.Coremail.wangyuquan1236@phytium.com.cn>
References: <20250217112039.138650-1-wangyuquan1236@phytium.com.cn>
 <20250220161213.000049a9@huawei.com>
 <20250221065509-mutt-send-email-mst@kernel.org>
 <17b91a9f.2847.1955fd23d78.Coremail.wangyuquan1236@phytium.com.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.96.237.92]
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
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

On Tue, 4 Mar 2025 14:22:48 +0800
Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:

> >=20
> > On Thu, Feb 20, 2025 at 04:12:13PM +0000, Jonathan Cameron wrote: =20
> > > On Mon, 17 Feb 2025 19:20:39 +0800
> > > Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:
> > >  =20
> > > > Add serial number parameter in the cxl persistent examples.
> > > >=20
> > > > Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn> =20
> > > Looks good.  I've queued it up on my gitlab staging tree, but
> > > Michael if you want to pick this one directly that's fine as well. =20
> >=20
> > See no reason to, I was not even CC'd. =20
>=20
> Hi, Michael
>=20
> I'm sorry, this is my fault. I used "get_maintainer.pl" to check this
> patch's maintainers but it shows "No maintainers found, printing recent
> contributors".=20
>=20
I usually stage up multiple series together and send on to Michael.
So it was be being lazy for a minor change rather than anything much
that you did wrong.

If I get time I'll post a series with this a few other patches
later today. =20

Jonathan

> Yuquan
>=20
> >  =20
> > > I should be pushing out my gitlab tree shortly (bit of networking
> > > fun to deal with).
> > >  =20
> > > > ---
> > > >  docs/system/devices/cxl.rst | 18 +++++++++---------
> > > >  1 file changed, 9 insertions(+), 9 deletions(-)
> > > >=20
> > > > diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.=
rst
> > > > index 882b036f5e..e307caf3f8 100644
> > > > --- a/docs/system/devices/cxl.rst
> > > > +++ b/docs/system/devices/cxl.rst
> > > > @@ -308,7 +308,7 @@ A very simple setup with just one directly atta=
ched CXL Type 3 Persistent Memory
> > > >    -object memory-backend-file,id=3Dcxl-lsa1,share=3Don,mem-path=3D=
/tmp/lsa.raw,size=3D256M \
> > > >    -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \
> > > >    -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Droot_port13,chassis=3D0=
,slot=3D2 \
> > > > -  -device cxl-type3,bus=3Droot_port13,persistent-memdev=3Dcxl-mem1=
,lsa=3Dcxl-lsa1,id=3Dcxl-pmem0 \
> > > > +  -device cxl-type3,bus=3Droot_port13,persistent-memdev=3Dcxl-mem1=
,lsa=3Dcxl-lsa1,id=3Dcxl-pmem0,sn=3D0x1 \
> > > >    -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D4G
> > > > =20
> > > >  A very simple setup with just one directly attached CXL Type 3 Vol=
atile Memory device::
> > > > @@ -349,13 +349,13 @@ the CXL Type3 device directly attached (no sw=
itches).::
> > > >    -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \
> > > >    -device pxb-cxl,bus_nr=3D222,bus=3Dpcie.0,id=3Dcxl.2 \
> > > >    -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Droot_port13,chassis=3D0=
,slot=3D2 \
> > > > -  -device cxl-type3,bus=3Droot_port13,persistent-memdev=3Dcxl-mem1=
,lsa=3Dcxl-lsa1,id=3Dcxl-pmem0 \
> > > > +  -device cxl-type3,bus=3Droot_port13,persistent-memdev=3Dcxl-mem1=
,lsa=3Dcxl-lsa1,id=3Dcxl-pmem0,sn=3D0x1 \
> > > >    -device cxl-rp,port=3D1,bus=3Dcxl.1,id=3Droot_port14,chassis=3D0=
,slot=3D3 \
> > > > -  -device cxl-type3,bus=3Droot_port14,persistent-memdev=3Dcxl-mem2=
,lsa=3Dcxl-lsa2,id=3Dcxl-pmem1 \
> > > > +  -device cxl-type3,bus=3Droot_port14,persistent-memdev=3Dcxl-mem2=
,lsa=3Dcxl-lsa2,id=3Dcxl-pmem1,sn=3D0x2 \
> > > >    -device cxl-rp,port=3D0,bus=3Dcxl.2,id=3Droot_port15,chassis=3D0=
,slot=3D5 \
> > > > -  -device cxl-type3,bus=3Droot_port15,persistent-memdev=3Dcxl-mem3=
,lsa=3Dcxl-lsa3,id=3Dcxl-pmem2 \
> > > > +  -device cxl-type3,bus=3Droot_port15,persistent-memdev=3Dcxl-mem3=
,lsa=3Dcxl-lsa3,id=3Dcxl-pmem2,sn=3D0x3 \
> > > >    -device cxl-rp,port=3D1,bus=3Dcxl.2,id=3Droot_port16,chassis=3D0=
,slot=3D6 \
> > > > -  -device cxl-type3,bus=3Droot_port16,persistent-memdev=3Dcxl-mem4=
,lsa=3Dcxl-lsa4,id=3Dcxl-pmem3 \
> > > > +  -device cxl-type3,bus=3Droot_port16,persistent-memdev=3Dcxl-mem4=
,lsa=3Dcxl-lsa4,id=3Dcxl-pmem3,sn=3D0x4 \
> > > >    -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.targets.1=3Dcxl.2,cxl-f=
mw.0.size=3D4G,cxl-fmw.0.interleave-granularity=3D8k
> > > > =20
> > > >  An example of 4 devices below a switch suitable for 1, 2 or 4 way =
interleave::
> > > > @@ -375,13 +375,13 @@ An example of 4 devices below a switch suitab=
le for 1, 2 or 4 way interleave::
> > > >    -device cxl-rp,port=3D1,bus=3Dcxl.1,id=3Droot_port1,chassis=3D0,=
slot=3D1 \
> > > >    -device cxl-upstream,bus=3Droot_port0,id=3Dus0 \
> > > >    -device cxl-downstream,port=3D0,bus=3Dus0,id=3Dswport0,chassis=
=3D0,slot=3D4 \
> > > > -  -device cxl-type3,bus=3Dswport0,persistent-memdev=3Dcxl-mem0,lsa=
=3Dcxl-lsa0,id=3Dcxl-pmem0 \
> > > > +  -device cxl-type3,bus=3Dswport0,persistent-memdev=3Dcxl-mem0,lsa=
=3Dcxl-lsa0,id=3Dcxl-pmem0,sn=3D0x1 \
> > > >    -device cxl-downstream,port=3D1,bus=3Dus0,id=3Dswport1,chassis=
=3D0,slot=3D5 \
> > > > -  -device cxl-type3,bus=3Dswport1,persistent-memdev=3Dcxl-mem1,lsa=
=3Dcxl-lsa1,id=3Dcxl-pmem1 \
> > > > +  -device cxl-type3,bus=3Dswport1,persistent-memdev=3Dcxl-mem1,lsa=
=3Dcxl-lsa1,id=3Dcxl-pmem1,sn=3D0x2 \
> > > >    -device cxl-downstream,port=3D2,bus=3Dus0,id=3Dswport2,chassis=
=3D0,slot=3D6 \
> > > > -  -device cxl-type3,bus=3Dswport2,persistent-memdev=3Dcxl-mem2,lsa=
=3Dcxl-lsa2,id=3Dcxl-pmem2 \
> > > > +  -device cxl-type3,bus=3Dswport2,persistent-memdev=3Dcxl-mem2,lsa=
=3Dcxl-lsa2,id=3Dcxl-pmem2,sn=3D0x3 \
> > > >    -device cxl-downstream,port=3D3,bus=3Dus0,id=3Dswport3,chassis=
=3D0,slot=3D7 \
> > > > -  -device cxl-type3,bus=3Dswport3,persistent-memdev=3Dcxl-mem3,lsa=
=3Dcxl-lsa3,id=3Dcxl-pmem3 \
> > > > +  -device cxl-type3,bus=3Dswport3,persistent-memdev=3Dcxl-mem3,lsa=
=3Dcxl-lsa3,id=3Dcxl-pmem3,sn=3D0x4 \
> > > >    -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D4G,cxl-fmw.0.int=
erleave-granularity=3D4k
> > > > =20
> > > >  Deprecations =20
>=20
>=20
> =E4=BF=A1=E6=81=AF=E5=AE=89=E5=85=A8=E5=A3=B0=E6=98=8E=EF=BC=9A=E6=9C=AC=
=E9=82=AE=E4=BB=B6=E5=8C=85=E5=90=AB=E4=BF=A1=E6=81=AF=E5=BD=92=E5=8F=91=E4=
=BB=B6=E4=BA=BA=E6=89=80=E5=9C=A8=E7=BB=84=E7=BB=87=E6=89=80=E6=9C=89,=E5=
=8F=91=E4=BB=B6=E4=BA=BA=E6=89=80=E5=9C=A8=E7=BB=84=E7=BB=87=E5=AF=B9=E8=AF=
=A5=E9=82=AE=E4=BB=B6=E6=8B=A5=E6=9C=89=E6=89=80=E6=9C=89=E6=9D=83=E5=88=A9=
=E3=80=82=E8=AF=B7=E6=8E=A5=E6=94=B6=E8=80=85=E6=B3=A8=E6=84=8F=E4=BF=9D=E5=
=AF=86,=E6=9C=AA=E7=BB=8F=E5=8F=91=E4=BB=B6=E4=BA=BA=E4=B9=A6=E9=9D=A2=E8=
=AE=B8=E5=8F=AF,=E4=B8=8D=E5=BE=97=E5=90=91=E4=BB=BB=E4=BD=95=E7=AC=AC=E4=
=B8=89=E6=96=B9=E7=BB=84=E7=BB=87=E5=92=8C=E4=B8=AA=E4=BA=BA=E9=80=8F=E9=9C=
=B2=E6=9C=AC=E9=82=AE=E4=BB=B6=E6=89=80=E5=90=AB=E4=BF=A1=E6=81=AF=E3=80=82
> Information Security Notice: The information contained in this mail is so=
lely property of the sender's organization.This mail communication is confi=
dential.Recipients named above are obligated to maintain secrecy and are no=
t permitted to disclose the contents of this communication to others.

