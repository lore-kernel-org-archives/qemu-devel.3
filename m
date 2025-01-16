Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5FCC02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 10:58:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYNaF-0005Jn-8k; Thu, 16 Jan 2025 05:58:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tYNaD-0005JP-C9
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 05:58:41 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tYNaA-0007mu-Cz
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 05:58:41 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YYfvK5x3Jz6L55W;
 Thu, 16 Jan 2025 18:57:01 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id DD16D1409EA;
 Thu, 16 Jan 2025 18:58:34 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 16 Jan
 2025 11:58:34 +0100
Date: Thu, 16 Jan 2025 10:58:33 +0000
To: Itaru Kitayama <itaru.kitayama@linux.dev>
CC: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>, <qemu-devel@nongnu.org>
Subject: Re: CXL emulation on aarch64
Message-ID: <20250116105833.000056da@huawei.com>
In-Reply-To: <88E9D774-A760-45F7-A173-24A07BB55733@linux.dev>
References: <0C019F50-9020-42ED-B051-998F03BFB709@linux.dev>
 <483e8037-3c72-4560-b4b8-2437d37ca8c4@fujitsu.com>
 <20250110123128.00004a5b@huawei.com>
 <09D52CDC-44E5-48C4-8D32-E4DD0964F9AF@linux.dev>
 <20250114102626.00000c53@huawei.com>
 <88E9D774-A760-45F7-A173-24A07BB55733@linux.dev>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-1.793, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, 16 Jan 2025 15:04:53 +0900
Itaru Kitayama <itaru.kitayama@linux.dev> wrote:

> Hi Jonathan,
>=20
> > On Jan 14, 2025, at 19:26, Jonathan Cameron <Jonathan.Cameron@huawei.co=
m> wrote:
> >=20
> > On Tue, 14 Jan 2025 12:03:03 +0900
> > Itaru Kitayama <itaru.kitayama@linux.dev> wrote:
> >  =20
> >> Hi Jonathan,=20
> >>  =20
> >>> On Jan 10, 2025, at 21:31, Jonathan Cameron <Jonathan.Cameron@huawei.=
com> wrote:
> >>>=20
> >>> On Fri, 10 Jan 2025 09:20:54 +0000
> >>> "Zhijian Li (Fujitsu)" via <qemu-devel@nongnu.org> wrote:
> >>>  =20
> >>>> On 10/01/2025 13:29, Itaru Kitayama wrote:   =20
> >>>>> Hi,
> >>>>> Is anybody working on the CXL emulation on aarch64?     =20
> >>>>=20
> >>>> I'm not currently working on the CXL emulation on aarch64.
> >>>>=20
> >>>> However, IIRC the CXL maintainer's tree should work.
> >>>> https://gitlab.com/jic23/qemu/   =20
> >>>=20
> >>> Pick up latest branch from there. I'm prepping a rebased version
> >>> with some new stuff but might take a few more days.   =20
> >>=20
> >> Thanks for sharing your work with us.  Your master and cxl-2024-11-27 =
branches give:
> >>=20
> >> $ qemu-system-aarch64: -accel tcg,cxl=3Don: Property 'tcg-accel.cxl' n=
ot found =20
> >=20
> > cxl is a machine property not a accel one. So needs to be after virt
> > There are tests in the tree for bios tables. Copy the command line from=
 those.
> >  =20
> >>=20
> >> My commands are below:
> >> $HOME/projects/qemu/build/qemu-system-aarch64 \
> >>        -M virt,virtualization=3Don,gic-version=3D3 \
> >>        -M acpi=3Doff -cpu max,sme=3Doff -m 8G -smp 4 \
> >>        -accel tcg,cxl=3Don \
> >>        -nographic \
> >>        -bios $HOME/cca-v4/out/bin/flash.bin \
> >>        -kernel Image-cca \
> >>        -drive format=3Draw,if=3Dnone,file=3D$HOME/cca-v4/out-or/images=
/rootfs.ext2,id=3Dhd0 \
> >>        -device virtio-blk-pci,drive=3Dhd0 \
> >>        -append root=3D/dev/vda \
> >>        -nodefaults \
> >>        --serial tcp:localhost:54320 \
> >>         -serial tcp:localhost:54321 \
> >>         -append "root=3D/dev/vda earlycon console=3Dhvc0" \
> >>         -device virtio-net-pci,netdev=3Dnet0 \
> >>         -netdev user,id=3Dnet0 \
> >>         -device virtio-9p-device,fsdev=3Dshr0,mount_tag=3Dshr0 \
> >>         -fsdev local,security_model=3Dnone,path=3D../../,id=3Dshr0
> >>=20
> >> Yes, I=E2=80=99m using Linaro=E2=80=99s CCA capable OP-TEE builds abov=
e. =20
> >=20
> > I'm a little curious why optee is relevant for this but shouldn't matte=
r as long
> > as an appropriate EDK2 is loaded.
> >  =20
>=20
> I picked up your tree=E2=80=99s =E2=80=9Cmaster=E2=80=9D and =E2=80=9Ccxl=
-next=E2=80=9D as of today, and only the latter at least booted.
> The former gives:
>=20
> qemu-system-aarch64: Property 'virt-9.2-machine.cxl' not found
>=20
> Should I stick with the cxl-next? My concern is that the base QEMU versio=
n is a bit old
> 7.0.50.

Always use the latest dated branch on that tree.  I release whenever there
is something new to carry or a major rebase needed.

cxl-<date> is the right branch to use. Hope that helps.

Jonathan

>=20
> Thanks,
> Itaru.
>=20
> > Jonathan
> >  =20
> >>=20
> >> Let me know which branch you were suggesting.
> >>=20
> >> Thanks,
> >> Itaru.=20
> >>  =20
> >>>=20
> >>> Note my main development work is on arm64 so that tends to work
> >>> more reliably than x86 which I only lightly test for stuff that
> >>> isn't ready for upstream yet.
> >>>=20
> >>> Give me a shout if you run into any problems.
> >>>=20
> >>> The main blocker on upstreaming this is resolving the missing device =
tree
> >>> support for PCI expander bridges.  I've not made any progress on this=
 since
> >>> talk at Linaro connect in 2023.
> >>>=20
> >>> Jonathan
> >>>=20
> >>>  =20
> >>>>=20
> >>>>=20
> >>>> Thanks
> >>>> Zhijian
> >>>>  =20
> >>>>> If there=E2=80=99s a WIP branch, a pointer would be appreciated.
> >>>>>=20
> >>>>> Itaru     =20
>=20
>=20


