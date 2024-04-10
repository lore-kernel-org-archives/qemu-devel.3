Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98064CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 16:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rubAa-0004ld-Tq; Wed, 10 Apr 2024 12:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rubAX-0004l2-4z
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 12:51:29 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rubAU-0001q1-4C
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 12:51:28 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VF81s3HTwz67fw4;
 Thu, 11 Apr 2024 00:49:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id AAC89140D26;
 Thu, 11 Apr 2024 00:51:15 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 10 Apr
 2024 17:51:15 +0100
Date: Wed, 10 Apr 2024 17:51:14 +0100
To: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
CC: "Huang, Ying" <ying.huang@intel.com>, Gregory Price
 <gourry.memverge@gmail.com>, <aneesh.kumar@linux.ibm.com>, <mhocko@suse.com>, 
 <tj@kernel.org>, <john@jagalactic.com>, Eishan Mirakhur
 <emirakhur@micron.com>, Vinicius Tavares Petrucci <vtavarespetr@micron.com>,
 Ravis OpenSrc <Ravis.OpenSrc@micron.com>, Alistair Popple
 <apopple@nvidia.com>, Srinivasulu Thanneeru <sthanneeru@micron.com>, SeongJae
 Park <sj@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, <nvdimm@lists.linux.dev>,
 <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Linux Memory
 Management List" <linux-mm@kvack.org>, "Ho-Ren (Jack) Chuang"
 <horenc@vt.edu>, "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>,
 <qemu-devel@nongnu.org>, Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [External] Re: [PATCH v11 2/2] memory tier: create CPUless
 memory tiers after obtaining HMAT info
Message-ID: <20240410175114.00001e1e@Huawei.com>
In-Reply-To: <CAKPbEqry55fc51hQ8oUC8so=PD_wWoJMEPiR-eq03BgB5q86Yw@mail.gmail.com>
References: <20240405000707.2670063-1-horenchuang@bytedance.com>
 <20240405000707.2670063-3-horenchuang@bytedance.com>
 <20240405150244.00004b49@Huawei.com>
 <CAKPbEqpGM_nR+LKbsoFTviBZaKUKYqJ3zbJp9EOCJAGvuPy6aQ@mail.gmail.com>
 <20240409171204.00001710@Huawei.com>
 <CAKPbEqry55fc51hQ8oUC8so=PD_wWoJMEPiR-eq03BgB5q86Yw@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Tue, 9 Apr 2024 12:02:31 -0700
"Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> wrote:

> Hi Jonathan,
>=20
> On Tue, Apr 9, 2024 at 9:12=E2=80=AFAM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Fri, 5 Apr 2024 15:43:47 -0700
> > "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> wrote:
> > =20
> > > On Fri, Apr 5, 2024 at 7:03=E2=80=AFAM Jonathan Cameron
> > > <Jonathan.Cameron@huawei.com> wrote: =20
> > > >
> > > > On Fri,  5 Apr 2024 00:07:06 +0000
> > > > "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> wrote:
> > > > =20
> > > > > The current implementation treats emulated memory devices, such as
> > > > > CXL1.1 type3 memory, as normal DRAM when they are emulated as nor=
mal memory
> > > > > (E820_TYPE_RAM). However, these emulated devices have different
> > > > > characteristics than traditional DRAM, making it important to
> > > > > distinguish them. Thus, we modify the tiered memory initializatio=
n process
> > > > > to introduce a delay specifically for CPUless NUMA nodes. This de=
lay
> > > > > ensures that the memory tier initialization for these nodes is de=
ferred
> > > > > until HMAT information is obtained during the boot process. Final=
ly,
> > > > > demotion tables are recalculated at the end.
> > > > >
> > > > > * late_initcall(memory_tier_late_init);
> > > > > Some device drivers may have initialized memory tiers between
> > > > > `memory_tier_init()` and `memory_tier_late_init()`, potentially b=
ringing
> > > > > online memory nodes and configuring memory tiers. They should be =
excluded
> > > > > in the late init.
> > > > >
> > > > > * Handle cases where there is no HMAT when creating memory tiers
> > > > > There is a scenario where a CPUless node does not provide HMAT in=
formation.
> > > > > If no HMAT is specified, it falls back to using the default DRAM =
tier.
> > > > >
> > > > > * Introduce another new lock `default_dram_perf_lock` for adist c=
alculation
> > > > > In the current implementation, iterating through CPUlist nodes re=
quires
> > > > > holding the `memory_tier_lock`. However, `mt_calc_adistance()` wi=
ll end up
> > > > > trying to acquire the same lock, leading to a potential deadlock.
> > > > > Therefore, we propose introducing a standalone `default_dram_perf=
_lock` to
> > > > > protect `default_dram_perf_*`. This approach not only avoids dead=
lock
> > > > > but also prevents holding a large lock simultaneously.
> > > > >
> > > > > * Upgrade `set_node_memory_tier` to support additional cases, inc=
luding
> > > > >   default DRAM, late CPUless, and hot-plugged initializations.
> > > > > To cover hot-plugged memory nodes, `mt_calc_adistance()` and
> > > > > `mt_find_alloc_memory_type()` are moved into `set_node_memory_tie=
r()` to
> > > > > handle cases where memtype is not initialized and where HMAT info=
rmation is
> > > > > available.
> > > > >
> > > > > * Introduce `default_memory_types` for those memory types that ar=
e not
> > > > >   initialized by device drivers.
> > > > > Because late initialized memory and default DRAM memory need to b=
e managed,
> > > > > a default memory type is created for storing all memory types tha=
t are
> > > > > not initialized by device drivers and as a fallback.
> > > > >
> > > > > Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> > > > > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> > > > > Reviewed-by: "Huang, Ying" <ying.huang@intel.com> =20
> > > >
> > > > Hi - one remaining question. Why can't we delay init for all nodes
> > > > to either drivers or your fallback late_initcall code.
> > > > It would be nice to reduce possible code paths. =20
> > >
> > > I try not to change too much of the existing code structure in
> > > this patchset.
> > >
> > > To me, postponing/moving all memory tier registrations to
> > > late_initcall() is another possible action item for the next patchset.
> > >
> > > After tier_mem(), hmat_init() is called, which requires registering
> > > `default_dram_type` info. This is when `default_dram_type` is needed.
> > > However, it is indeed possible to postpone the latter part,
> > > set_node_memory_tier(), to `late_init(). So, memory_tier_init() can
> > > indeed be split into two parts, and the latter part can be moved to
> > > late_initcall() to be processed together.
> > >
> > > Doing this all memory-type drivers have to call late_initcall() to
> > > register a memory tier. I=E2=80=99m not sure how many they are?
> > >
> > > What do you guys think? =20
> >
> > Gut feeling - if you are going to move it for some cases, move it for
> > all of them.  Then we only have to test once ;)
> >
> > J =20
>=20
> Thank you for your reminder! I agree~ That's why I'm considering
> changing them in the next patchset because of the amount of changes.
> And also, this patchset already contains too many things.

Makes sense.  (Interestingly we are reaching the same conclusion
for the thread that motivated suggesting bringing them all together
in the first place!)

Get things work in a clean fashion, then consider moving everything to
happen at the same time to simplify testing etc.

Jonathan

