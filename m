Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3285C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 12:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY2Pq-00035q-QF; Wed, 15 Jan 2025 07:22:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1tY2Pp-00035i-7O
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 07:22:33 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1tY2Pl-0003HF-Jg
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 07:22:32 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YY4pJ0g6jz6D9Th;
 Wed, 15 Jan 2025 20:20:40 +0800 (CST)
Received: from frapeml100008.china.huawei.com (unknown [7.182.85.131])
 by mail.maildlp.com (Postfix) with ESMTPS id 30105140442;
 Wed, 15 Jan 2025 20:22:25 +0800 (CST)
Received: from frapeml500003.china.huawei.com (7.182.85.28) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 15 Jan 2025 13:22:24 +0100
Received: from frapeml500003.china.huawei.com ([7.182.85.28]) by
 frapeml500003.china.huawei.com ([7.182.85.28]) with mapi id 15.01.2507.039;
 Wed, 15 Jan 2025 13:22:24 +0100
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "zhao1.liu@intel.com" <zhao1.liu@intel.com>, "dapeng1.mi@linux.intel.com"
 <dapeng1.mi@linux.intel.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "farman@linux.ibm.com" <farman@linux.ibm.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "anisinha@redhat.com" <anisinha@redhat.com>, "shannon.zhaosl@gmail.com"
 <shannon.zhaosl@gmail.com>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "mtosatti@redhat.com" <mtosatti@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, Linuxarm <linuxarm@huawei.com>, "Shameerali
 Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, jiangkunkun <jiangkunkun@huawei.com>,
 yangyicong <yangyicong@huawei.com>, "sarsanaee@gmail.com"
 <sarsanaee@gmail.com>
Subject: RE: [RFC PATCH v6 0/6] Specifying cache topology on ARM
Thread-Topic: [RFC PATCH v6 0/6] Specifying cache topology on ARM
Thread-Index: AQHbZq8tUlyBinQe9kOCCI6eg2r3KbMXwaBA
Date: Wed, 15 Jan 2025 12:22:24 +0000
Message-ID: <e96a4aca0ece45e69888818e37116faa@huawei.com>
References: <20250114180611.353-1-alireza.sanaee@huawei.com>
In-Reply-To: <20250114180611.353-1-alireza.sanaee@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.75.97]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
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
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi everyone,

There is a bug in this patch-set on loongarch (function signature of build_=
pptt), that I will fix in the next version. Just wanted to point this out. =
Anyhow I will allow time for hopefully some reviews first.

Thanks,
Alireza

-----Original Message-----
From: qemu-arm-bounces+alireza.sanaee=3Dhuawei.com@nongnu.org <qemu-arm-bou=
nces+alireza.sanaee=3Dhuawei.com@nongnu.org> On Behalf Of Alireza Sanaee vi=
a
Sent: Tuesday, January 14, 2025 6:06 PM
To: qemu-devel@nongnu.org; qemu-arm@nongnu.org
Cc: zhao1.liu@intel.com; dapeng1.mi@linux.intel.com; armbru@redhat.com; far=
man@linux.ibm.com; peter.maydell@linaro.org; mst@redhat.com; anisinha@redha=
t.com; shannon.zhaosl@gmail.com; imammedo@redhat.com; mtosatti@redhat.com; =
berrange@redhat.com; richard.henderson@linaro.org; Linuxarm <linuxarm@huawe=
i.com>; Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>; J=
onathan Cameron <jonathan.cameron@huawei.com>; jiangkunkun <jiangkunkun@hua=
wei.com>; yangyicong <yangyicong@huawei.com>; sarsanaee@gmail.com
Subject: [RFC PATCH v6 0/6] Specifying cache topology on ARM

Specifying the cache layout in virtual machines is useful for applications =
and operating systems to fetch accurate information about the cache structu=
re and make appropriate adjustments. Enforcing correct sharing information =
can lead to better optimizations. This patch enables the specification of c=
ache layout through a command line parameter, building on a patch set by In=
tel [1,2,3]. It uses this set as a foundation.  The device tree and ACPI/PP=
TT table, and device tree are populated based on user-provided information =
and CPU topology.

Example:


+----------------+                            +----------------+
|    Socket 0    |                            |    Socket 1    |
|    (L3 Cache)  |                            |    (L3 Cache)  |
+--------+-------+                            +--------+-------+
         |                                             |
+--------+--------+                            +--------+--------+
|   Cluster 0     |                            |   Cluster 0     |
|   (L2 Cache)    |                            |   (L2 Cache)    |
+--------+--------+                            +--------+--------+
         |                                             |
+--------+--------+  +--------+--------+    +--------+--------+  +--------+=
----+
|   Core 0         | |   Core 1        |    |   Core 0        |  |   Core 1=
    |
|   (L1i, L1d)     | |   (L1i, L1d)    |    |   (L1i, L1d)    |  |   (L1i, =
L1d)|
+--------+--------+  +--------+--------+    +--------+--------+  +--------+=
----+
         |                   |                       |                   |
+--------+              +--------+              +--------+          +------=
--+
|Thread 0|              |Thread 1|              |Thread 1|          |Thread=
 0|
+--------+              +--------+              +--------+          +------=
--+
|Thread 1|              |Thread 0|              |Thread 0|          |Thread=
 1|
+--------+              +--------+              +--------+          +------=
--+


The following command will represent the system relying on **ACPI PPTT tabl=
es**.

./qemu-system-aarch64 \
 -machine virt,smp-cache.0.cache=3Dl1i,smp-cache.0.topology=3Dcore,smp-cach=
e.1.cache=3Dl1d,smp-cache.1.topology=3Dcore,smp-cache.2.cache=3Dl2,smp-cach=
e.2.topology=3Dcluseter,smp-cache.3.cache=3Dl3,smp-cache.3.topology=3Dsocke=
t \  -cpu max \  -m 2048 \  -smp sockets=3D2,clusters=3D1,cores=3D2,threads=
=3D2 \  -kernel ./Image.gz \  -append "console=3DttyAMA0 root=3D/dev/ram rd=
init=3D/init acpi=3Dforce" \  -initrd rootfs.cpio.gz \  -bios ./edk2-aarch6=
4-code.fd \  -nographic

The following command will represent the system relying on **the device tre=
e**.

./qemu-system-aarch64 \
 -machine virt,smp-cache.0.cache=3Dl1i,smp-cache.0.topology=3Dcore,smp-cach=
e.1.cache=3Dl1d,smp-cache.1.topology=3Dcore,smp-cache.2.cache=3Dl2,smp-cach=
e.2.topology=3Dcluseter,smp-cache.3.cache=3Dl3,smp-cache.3.topology=3Dsocke=
t \  -cpu max \  -m 2048 \  -smp sockets=3D2,clusters=3D1,cores=3D2,threads=
=3D2 \  -kernel ./Image.gz \  -append "console=3DttyAMA0 root=3D/dev/ram rd=
init=3D/init" \  -initrd rootfs.cpio.gz \  -nographic

Failure cases:
    1) There are scenarios where caches exist in systems' registers but
    not left unspecified by users. In this case qemu returns failure.

    2) At the moment, the device tree is not able to describe caches
    shared at core level. In another word, SMT threads cannot share
    caches. This will need adjustments in the SPEC. It is worth noting
    that this particular case is completely OK in ACPI PPTT tables.

Currently only three levels of caches are supported to be specified from th=
e command line. However, increasing the value does not require significant =
changes. Further, this patch assumes l2 and l3 unified caches and does not =
allow l(2/3)(i/d). The level terminology is thread/core/cluster/socket righ=
t now.

Here is the hierarchy assumed in this patch:
Socket level =3D Cluster level + 1 =3D Core level + 2 =3D Thread level + 3;

TODO:
  1) Making the code to work with arbitrary levels
  2) Separated data and instruction cache at L2 and L3.
  3) Additional cache controls.  e.g. size of L3 may not want to just
  match the underlying system, because only some of the associated host
  CPUs may be bound to this VM.

Depends-on: Building PPTT with root node and identical implementation flag
Depends-on: Msg-id: 20240926113323.55991-1-yangyicong@huawei.com

Depends-on: i386: Support SMP Cache Topology
Depends-on: Msg-id: 20250110145115.1574345-1-zhao1.liu@intel.com

[1] https://lore.kernel.org/kvm/20240908125920.1160236-1-zhao1.liu@intel.co=
m/
[2] https://lore.kernel.org/qemu-devel/20241101083331.340178-1-zhao1.liu@in=
tel.com/
[3] https://lore.kernel.org/qemu-devel/20250110145115.1574345-1-zhao1.liu@i=
ntel.com/

Change Log:
  v5->v6:
   * Minor bug fix.
   * rebase based on new Intel patchset.
     - https://lore.kernel.org/qemu-devel/20250110145115.1574345-1-zhao1.li=
u@intel.com/
  v4->v5:
    * Added Reviewed-by tags.
    * Applied some comments.

  v3->v4:
    * Device tree added.
=20

Alireza Sanaee (6):
  target/arm/tcg: increase cache level for cpu=3Dmax
  arm/virt.c: add cache hierarchy to device tree
  bios-tables-test: prepare to change ARM ACPI virt PPTT
  hw/acpi/aml-build.c: add cache hierarchy to pptt table
  tests/qtest/bios-table-test: testing new ARM ACPI PPTT topology
  Update the ACPI tables according to the acpi aml_build change, also
    empty bios-tables-test-allowed-diff.h.

 hw/acpi/aml-build.c                        | 205 +++++++++++-
 hw/arm/virt-acpi-build.c                   |   8 +-
 hw/arm/virt.c                              | 349 +++++++++++++++++++++
 hw/cpu/core.c                              |  92 ++++++
 include/hw/acpi/aml-build.h                |   4 +-
 include/hw/arm/virt.h                      |   4 +
 include/hw/cpu/core.h                      |  27 ++
 target/arm/tcg/cpu64.c                     |  13 +
 tests/data/acpi/aarch64/virt/PPTT.topology | Bin 356 -> 540 bytes
 tests/qtest/bios-tables-test.c             |   4 +
 10 files changed, 699 insertions(+), 7 deletions(-)

--
2.34.1



