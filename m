Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76461C3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 08:49:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u24da-00010v-UZ; Tue, 08 Apr 2025 04:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1u24dS-0000zq-9A; Tue, 08 Apr 2025 04:48:46 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1u24dK-00030H-G3; Tue, 08 Apr 2025 04:48:45 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZX0856DJtz6FGp6;
 Tue,  8 Apr 2025 16:47:33 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
 by mail.maildlp.com (Postfix) with ESMTPS id ECDCB1400DB;
 Tue,  8 Apr 2025 16:48:28 +0800 (CST)
Received: from localhost (10.203.177.99) by frapeml500003.china.huawei.com
 (7.182.85.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 8 Apr
 2025 10:48:28 +0200
Date: Tue, 8 Apr 2025 09:48:22 +0100
To: Eric Auger <eric.auger@redhat.com>
CC: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <mst@redhat.com>,
 <zhao1.liu@intel.com>, <dapeng1.mi@linux.intel.com>, <armbru@redhat.com>,
 <farman@linux.ibm.com>, <peter.maydell@linaro.org>, <anisinha@redhat.com>,
 <shannon.zhaosl@gmail.com>, <imammedo@redhat.com>, <mtosatti@redhat.com>,
 <berrange@redhat.com>, <richard.henderson@linaro.org>,
 <shameerali.kolothum.thodi@huawei.com>, <jonathan.cameron@huawei.com>,
 <jiangkunkun@huawei.com>, <yangyicong@hisilicon.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v8 0/6] Specifying cache topology on ARM
Message-ID: <20250408094822.0000012f.alireza.sanaee@huawei.com>
In-Reply-To: <7cad3f1f-1977-4d98-900c-080aa5ad32d5@redhat.com>
References: <20250310162337.844-1-alireza.sanaee@huawei.com>
 <7cad3f1f-1977-4d98-900c-080aa5ad32d5@redhat.com>
Organization: Huawei
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.99]
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500003.china.huawei.com (7.182.85.28)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Mon, 7 Apr 2025 19:24:16 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> Hi Ali,
> 
> On 3/10/25 5:23 PM, Alireza Sanaee via wrote:
> > Specifying the cache layout in virtual machines is useful for
> > applications and operating systems to fetch accurate information
> > about the cache structure and make appropriate adjustments.
> > Enforcing correct sharing information can lead to better
> > optimizations. This patch enables the specification of cache layout
> > through a command line parameter, building on a patch set by Intel
> > [1,2,3]. It uses this set as a  
> some dependencies were merged. The series does not apply anymore.
This has already picked up, thanks for pointing out. Will remove in the
next version.
> > foundation.  The device tree and ACPI/PPTT table, and device tree
> > are populated based on user-provided information and CPU topology.  
> this last sentence need some rewording.
Sure, gonna fix.
> >
> > Example:
> >
> >
> > +----------------+                            +----------------+
> > |    Socket 0    |                            |    Socket 1    |
> > |    (L3 Cache)  |                            |    (L3 Cache)  |
> > +--------+-------+                            +--------+-------+
> >          |                                             |
> > +--------+--------+                            +--------+--------+
> > |   Cluster 0     |                            |   Cluster 0     |
> > |   (L2 Cache)    |                            |   (L2 Cache)    |
> > +--------+--------+                            +--------+--------+
> >          |                                             |
> > +--------+--------+  +--------+--------+    +--------+--------+
> > +--------+----+ |   Core 0         | |   Core 1        |    |
> > Core 0        |  |   Core 1    | |   (L1i, L1d)     | |   (L1i,
> > L1d)    |    |   (L1i, L1d)    |  |   (L1i, L1d)|
> > +--------+--------+  +--------+--------+    +--------+--------+
> > +--------+----+ |                   |                       |
> >             | +--------+              +--------+
> > +--------+          +--------+ |Thread 0|              |Thread 1|
> >            |Thread 1|          |Thread 0| +--------+
> > +--------+              +--------+          +--------+ |Thread 1|
> >            |Thread 0|              |Thread 0|          |Thread 1|
> > +--------+              +--------+              +--------+
> > +--------+
> >
> >
> > The following command will represent the system relying on **ACPI
> > PPTT tables**.
> >
> > ./qemu-system-aarch64 \
> >  -machine
> > virt,smp-cache.0.cache=l1i,smp-cache.0.topology=core,smp-cache.1.cache=l1d,smp-cache.1.topology=core,smp-cache.2.cache=l2,smp-cache.2.topology=cluseter,smp-
> >  
> s/cluseter/cluster
> > cache.3.cache=l3,smp-cache.3.topology=socket \
> >  -cpu max \
> >  -m 2048 \
> >  -smp sockets=2,clusters=1,cores=2,threads=2 \
> >  -kernel ./Image.gz \
> >  -append "console=ttyAMA0 root=/dev/ram rdinit=/init acpi=force" \
> >  -initrd rootfs.cpio.gz \
> >  -bios ./edk2-aarch64-code.fd \
> >  -nographic
> >
> > The following command will represent the system relying on **the
> > device tree**.
> >
> > ./qemu-system-aarch64 \
> >  -machine
> > virt,smp-cache.0.cache=l1i,smp-cache.0.topology=core,smp-cache.1.cache=l1d,smp-cache.1.topology=core,smp-cache.2.cache=l2,smp-cache.2.topology=cluseter,smp-cache.3.cache=l3,smp-cache.3.topology=socket
> > \ -cpu max \ -m 2048 \
> >  -smp sockets=2,clusters=1,cores=2,threads=2 \
> >  -kernel ./Image.gz \
> >  -append "console=ttyAMA0 root=/dev/ram rdinit=/init acpi=off" \
> >  -initrd rootfs.cpio.gz \
> >  -nographic
> >
> > Failure cases:
> >     1) There are scenarios where caches exist in systems' registers
> > but left unspecified by users. In this case qemu returns failure.  
> Can you give more details on 1)? is it a TCG case or does it also
> exist with KVM acceleration?
Yes, imagine your CLIDR register describes L1, L2, and L3. Then in the
interface we only describe L1, and L2 and leave L3. Situation for L3 
right now is undefined, in a sense that what is the sharing situation?
This is failure.

I think this is applicable to both TCG and KVM, because, the miss-match
might come from real systems' registers or emulated ones. User might
not exactly know the supported caches and misconfigure.

I spend some time thinking about a default behavior but then that
again will be unclear to users, and decided it is better if users
decide what EXACTLY should happen in an informed fashion.
> >
> >     2) SMT threads cannot share caches which is not very common.
> > More discussions here [4].
> >
> > Currently only three levels of caches are supported to be specified
> > from the command line. However, increasing the value does not
> > require significant changes. Further, this patch assumes l2 and l3
> > unified caches and does not allow l(2/3)(i/d). The level
> > terminology is thread/core/cluster/socket right now. Hierarchy
> > assumed in this patch: Socket level = Cluster level + 1 = Core
> > level + 2 = Thread level + 3;
> >
> > TODO:
> >   1) Making the code to work with arbitrary levels
> >   2) Separated data and instruction cache at L2 and L3.
> >   3) Additional cache controls.  e.g. size of L3 may not want to
> > just match the underlying system, because only some of the
> > associated host CPUs may be bound to this VM.  
> Does it mean this is more an RFC or do you plan to send improvement
> patches once this series gets upstream?
Short answer, I think I am better off sending upgrades once the main
patchset got merged.

Some of these TODOs are good to have really, i.e., L3 size is something
I have received some interest about already.

Or separated data and instruction is interesting only if someone plans
to build one (maybe there is already and I don't know).

Or arbitrary levels is not a challenging mod, so can be added later,
if people want to have 7 layers :)

This is something community can help me knowing what else might be
interesting.

> 
> Thanks
> 
> Eric
> >
> > [1] https://lore.kernel.org/kvm/20240908125920.1160236-1-zhao1.liu@intel.com/
> > [2] https://lore.kernel.org/qemu-devel/20241101083331.340178-1-zhao1.liu@intel.com/
> > [3] https://lore.kernel.org/qemu-devel/20250110145115.1574345-1-zhao1.liu@intel.com/
> > [4] https://lore.kernel.org/devicetree-spec/20250203120527.3534-1-alireza.sanaee@huawei.com/
> >
> > Change Log:
> >   v7->v8:
> >    * rebase: Merge tag 'pull-nbd-2024-08-26'
> > of https://repo.or.cz/qemu/ericb into staging
> >    * I mis-included a file in patch #4 and I removed it in this one.
> >
> >   v6->v7:
> >    * Intel stuff got pulled up, so rebase.
> >    * added some discussions on device tree.
> >
> >   v5->v6:
> >    * Minor bug fix.
> >    * rebase based on new Intel patchset.
> >      - https://lore.kernel.org/qemu-devel/20250110145115.1574345-1-zhao1.liu@intel.com/
> >
> >   v4->v5:
> >     * Added Reviewed-by tags.
> >     * Applied some comments.
> >
> >   v3->v4:
> >     * Device tree added.
> >
> > Depends-on: Building PPTT with root node and identical
> > implementation flag Depends-on: Msg-id:
> > 20250306023342.508-1-alireza.sanaee@huawei.com
> >
> > Alireza Sanaee (6):
> >   target/arm/tcg: increase cache level for cpu=max
> >   arm/virt.c: add cache hierarchy to device tree
> >   bios-tables-test: prepare to change ARM ACPI virt PPTT
> >   hw/acpi/aml-build.c: add cache hierarchy to pptt table
> >   tests/qtest/bios-table-test: testing new ARM ACPI PPTT topology
> >   Update the ACPI tables according to the acpi aml_build change,
> > also empty bios-tables-test-allowed-diff.h.
> >
> >  hw/acpi/aml-build.c                        | 205 +++++++++++-
> >  hw/arm/virt-acpi-build.c                   |   8 +-
> >  hw/arm/virt.c                              | 350
> > +++++++++++++++++++++ hw/cpu/core.c                              |
> > 92 ++++++ hw/loongarch/virt-acpi-build.c             |   2 +-
> >  include/hw/acpi/aml-build.h                |   4 +-
> >  include/hw/arm/virt.h                      |   4 +
> >  include/hw/cpu/core.h                      |  27 ++
> >  target/arm/tcg/cpu64.c                     |  13 +
> >  tests/data/acpi/aarch64/virt/PPTT.topology | Bin 356 -> 540 bytes
> >  tests/qtest/bios-tables-test.c             |   4 +
> >  11 files changed, 701 insertions(+), 8 deletions(-)
> >  
> 
> 


