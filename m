Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 768F6C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 12:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7wYD-0000Xu-TD; Fri, 17 May 2024 08:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1s7wY9-0000SG-12
 for qemu-devel@nongnu.org; Fri, 17 May 2024 08:19:01 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1s7wY6-0004cT-GU
 for qemu-devel@nongnu.org; Fri, 17 May 2024 08:19:00 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VgmBG4FByz6K7Dw;
 Fri, 17 May 2024 20:15:18 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 6DEEE140B2A;
 Fri, 17 May 2024 20:18:53 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 17 May
 2024 13:18:52 +0100
Date: Fri, 17 May 2024 13:18:52 +0100
To: fan <nifan.cxl@gmail.com>
CC: Gregory Price <gregory.price@memverge.com>, <qemu-devel@nongnu.org>,
 <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
 <dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
 <nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
 <Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, <fan.ni@samsung.com>
Subject: Re: [PATCH v7 00/12] Enabling DCD emulation support in Qemu
Message-ID: <20240517131852.00006bc7@Huawei.com>
In-Reply-To: <ZkY83c9PXoop_r1A@debian>
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <ZiK25Log7LmtBffa@memverge.com> <ZkY83c9PXoop_r1A@debian>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 16 May 2024 10:05:33 -0700
fan <nifan.cxl@gmail.com> wrote:

> On Fri, Apr 19, 2024 at 02:24:36PM -0400, Gregory Price wrote:
> > On Thu, Apr 18, 2024 at 04:10:51PM -0700, nifan.cxl@gmail.com wrote: =20
> > > A git tree of this series can be found here (with one extra commit on=
 top
> > > for printing out accepted/pending extent list):=20
> > > https://github.com/moking/qemu/tree/dcd-v7
> > >=20
> > > v6->v7:
> > >=20
> > > 1. Fixed the dvsec range register issue mentioned in the the cover le=
tter in v6.
> > >    Only relevant bits are set to mark the device ready (Patch 6). (Jo=
nathan)
> > > 2. Moved the if statement in cxl_setup_memory from Patch 6 to Patch 4=
. (Jonathan)
> > > 3. Used MIN instead of if statement to get record_count in Patch 7. (=
Jonathan)
> > > 4. Added "Reviewed-by" tag to Patch 7.
> > > 5. Modified cxl_dc_extent_release_dry_run so the updated extent list =
can be
> > >    reused in cmd_dcd_release_dyn_cap to simplify the process in Patch=
 8. (J=F8rgen)=20
> > > 6. Added comments to indicate further "TODO" items in cmd_dcd_add_dyn=
_cap_rsp.
> > >     (Jonathan)
> > > 7. Avoided irrelevant code reformat in Patch 8. (Jonathan)
> > > 8. Modified QMP interfaces for adding/releasing DC extents to allow p=
assing
> > >    tags, selection policy, flags in the interface. (Jonathan, Gregory)
> > > 9. Redesigned the pending list so extents in the same requests are gr=
ouped
> > >     together. A new data structure is introduced to represent "extent=
 group"
> > >     in pending list.  (Jonathan)
> > > 10. Added support in QMP interface for "More" flag.=20
> > > 11. Check "Forced removal" flag for release request and not let it pa=
ss through.
> > > 12. Removed the dynamic capacity log type from CxlEventLog definition=
 in cxl.json
> > >    to avoid the side effect it may introduce to inject error to DC ev=
ent log.
> > >    (Jonathan)
> > > 13. Hard coded the event log type to dynamic capacity event log in QMP
> > >     interfaces. (Jonathan)
> > > 14. Adding space in between "-1]". (Jonathan)
> > > 15. Some minor comment fixes.
> > >=20
> > > The code is tested with similar setup and has passed similar tests as=
 listed
> > > in the cover letter of v5[1] and v6[2].
> > > Also, the code is tested with the latest DCD kernel patchset[3].
> > >=20
> > > [1] Qemu DCD patchset v5: https://lore.kernel.org/linux-cxl/202403041=
94331.1586191-1-nifan.cxl@gmail.com/T/#t
> > > [2] Qemu DCD patchset v6: https://lore.kernel.org/linux-cxl/202403251=
90339.696686-1-nifan.cxl@gmail.com/T/#t
> > > [3] DCD kernel patches: https://lore.kernel.org/linux-cxl/20240324-dc=
d-type2-upstream-v1-0-b7b00d623625@intel.com/T/#m11c571e21c4fe17c7d04ec5c2c=
7bc7cbf2cd07e3
> > > =20
> >=20
> > added review to all patches, will hopefully be able to add a Tested-by
> > tag early next week, along with a v1 RFC for MHD bit-tracking.
> >=20
> > We've been testing v5/v6 for a bit, so I expect as soon as we get the
> > MHD code ported over to v7 i'll ship a tested-by tag pretty quick.
> >=20
> > The super-set release will complicate a few things but this doesn't
> > look like a blocker on our end, just a change to how we track bits in a
> > shared bit/bytemap.
> >  =20
>=20
> Hi Gregory,
> I am planning to address all the concerns in this series and send out v8
> next week. Jonathan mentioned you have few related patches built on top
> of this series, can you point me to the latest version so I can look
> into it? Also, would you like me to carry them over to send together
> with my series in next version? It could be easier for you to avoid the
> potential rebase needed for your patches?

I wasn't clear - I meant other way around.
This series is built on a couple of Gregory's patches.  Gregory can suffer
the pain of rebasing his stuff ;) (or I'll do it depending on when things
land).

hw/cxl/mailbox: change CCI cmd set structure to be a member, not a referenc=
e=20
https://gitlab.com/jic23/qemu/-/commit/f44ebc5a455ccdd6535879b0c5824e0d76b0=
4da5
hw/cxl/mailbox: interface to add CCI commands to an existing CCI=20
https://gitlab.com/jic23/qemu/-/commit/00a4dd8b388add03c588298f665ee9186262=
96a5

I was suggesting your next posting should just include those two with
your sign-off added. That way if everyone is happy with v8 Michael Tsirkin
can pick it up directly, saving a step.

Make sure to add Michael to the to list as well for next version.

Thanks,

Jonathan

>=20
> Let me know.
>=20
> Thanks,
> Fan
>=20
> > >=20
> > > Fan Ni (12):
> > >   hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output
> > >     payload of identify memory device command
> > >   hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative
> > >     and mailbox command support
> > >   include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for
> > >     type3 memory devices
> > >   hw/mem/cxl_type3: Add support to create DC regions to type3 memory
> > >     devices
> > >   hw/mem/cxl-type3: Refactor ct3_build_cdat_entries_for_mr to take mr
> > >     size instead of mr as argument
> > >   hw/mem/cxl_type3: Add host backend and address space handling for DC
> > >     regions
> > >   hw/mem/cxl_type3: Add DC extent list representative and get DC exte=
nt
> > >     list mailbox support
> > >   hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/relea=
se
> > >     dynamic capacity response
> > >   hw/cxl/events: Add qmp interfaces to add/release dynamic capacity
> > >     extents
> > >   hw/mem/cxl_type3: Add DPA range validation for accesses to DC regio=
ns
> > >   hw/cxl/cxl-mailbox-utils: Add superset extent release mailbox suppo=
rt
> > >   hw/mem/cxl_type3: Allow to release extent superset in QMP interface
> > >=20
> > >  hw/cxl/cxl-mailbox-utils.c  | 620 ++++++++++++++++++++++++++++++++++-
> > >  hw/mem/cxl_type3.c          | 633 +++++++++++++++++++++++++++++++++-=
--
> > >  hw/mem/cxl_type3_stubs.c    |  20 ++
> > >  include/hw/cxl/cxl_device.h |  81 ++++-
> > >  include/hw/cxl/cxl_events.h |  18 +
> > >  qapi/cxl.json               |  69 ++++
> > >  6 files changed, 1396 insertions(+), 45 deletions(-)
> > >=20
> > > --=20
> > > 2.43.0
> > >  =20


