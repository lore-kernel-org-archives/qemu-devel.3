Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13459C54E4A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 12:34:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhqSr-0007kt-TC; Wed, 06 Mar 2024 07:33:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rhqSp-0007k4-Pj; Wed, 06 Mar 2024 07:33:39 -0500
Received: from mail-mw2nam10on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2412::601]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rhqSl-0002ti-89; Wed, 06 Mar 2024 07:33:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zm4I3mMe1f+CRPHlYYeQ1ff/vLNPMWUNoIDG2jlAeV5/tHeX5gsbYDA2c4xZDntcXy8DyHviZgCvU3e+4cu8mahOlGvyKw4ZTJBRsqoSO2vXUVHPe7ruXw7cFMbJpEp7g1GrDKje/PTZ/bXAHZ0qHQxbAjs1YA5aS//4dGMaHnNbvFzd+l1R4zFyWMoNmmJnoZwE8PF5w0mj50a9SL4JLTFysuHzn9TcM95DF67T2mzieEDGRxRZisoj7MhP0r46MTL13EgOF8Tb6YbYDPRRhvGtoiMZIxptb2kPzsdlcWhriHrHlEP8A/V8vC/VY7hUSAc9JIhicglpdZj/xgtHkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6gKNxCyS7Sr4D+XIcxKv0S0Hy99F9ARIfXO1XPC7I8=;
 b=l5NVbJCEW7FPUfuw8Et/sWebIKp2xi53Ck9OeTwQJfX7Oyv2XFZaLdks5Fw+/Dvwm9Lr+jgULoG9jHhogDCza4DGdKDfdIf5807TYYlVa50xqNdo/00ABOzjm2k2JDZ61FMWVid2MNUwRwuTIc6K6xjPRSFzRRU2ScZ6G70X6NaAxwgRZWyxtzJ/HEffS67qeHj5AI7HNbGG1ZpVOF99cyzHPXL0U0eqB0/eiX716myzHY1ATeWMwND94ncsluYvS9E8REwUfaSGX1a/bDABDKZMPgm5cg9d0A10d9eX/HhfgzFUxJTzFjSMq5Zl1VcH1Nd98zYlmcCR5FY4NZ7LRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6gKNxCyS7Sr4D+XIcxKv0S0Hy99F9ARIfXO1XPC7I8=;
 b=rHDM5beQKcMYDZJzHLN4mmWGnLZQyKiR8oS+AyKv9GRn9zwtxJS3do5uPYNeCoTa9Vz2NHEGHoSAKRMO7oYp2zBrmmcqRsLXuaqIgUNz0glJ0DkOLlCwktr1KpFnHJebXomXEYWAOhMsb5PxFavk66fgDrWR/a/Uj9It/2upeyQFrFD6cwWQO37EejvYociGK+C6mV+E+D+FN6QprprcqVCXamihdEJosejELwO2Svw6OCvCGJhh+qC578TpV/DZyBMEXOMUdGRi56fQl018pmFWDWufpLw6/jrlTTif0XEf/cBlSqpClqeoNRnoA1Ffb0l294AttyA7KAJjuY96HA==
Received: from MW4PR04CA0193.namprd04.prod.outlook.com (2603:10b6:303:86::18)
 by CH2PR12MB4296.namprd12.prod.outlook.com (2603:10b6:610:af::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 12:33:24 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:86:cafe::62) by MW4PR04CA0193.outlook.office365.com
 (2603:10b6:303:86::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Wed, 6 Mar 2024 12:33:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 12:33:23 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 6 Mar 2024
 04:33:18 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 6 Mar 2024 04:33:17 -0800
Received: from host-10-63-191-31.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Wed, 6 Mar 2024 04:33:17 -0800
From: <ankita@nvidia.com>
To: <ankita@nvidia.com>, <jgg@nvidia.com>, <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>, <wangyanan55@huawei.com>, <alex.williamson@redhat.com>,
 <pbonzini@redhat.com>, <clg@redhat.com>, <shannon.zhaosl@gmail.com>,
 <peter.maydell@linaro.org>, <ani@anisinha.ca>, <berrange@redhat.com>,
 <eduardo@habkost.net>, <imammedo@redhat.com>, <mst@redhat.com>,
 <eblake@redhat.com>, <armbru@redhat.com>, <david@redhat.com>,
 <gshan@redhat.com>, <Jonathan.Cameron@huawei.com>
CC: <aniketa@nvidia.com>, <cjia@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <vsethi@nvidia.com>, <acurrid@nvidia.com>,
 <dnigam@nvidia.com>, <udhoke@nvidia.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: [PATCH v8 0/2] acpi: report NUMA nodes for device memory using GI
Date: Wed, 6 Mar 2024 12:33:15 +0000
Message-ID: <20240306123317.4691-1-ankita@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|CH2PR12MB4296:EE_
X-MS-Office365-Filtering-Correlation-Id: 07ef8430-b12c-4e40-b012-08dc3dd99d7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r34zsy2FCTK05IBngwli25HD+S1WSf3XQlgVNoJzOmiNAhWGWHqO8W1HLnK0QLDmVUYpPn2/sPHw5r8gwjUtAKpw3FwecjDRIIwPgcWw9OVej4GcwKYN77ujQL8Pl1+GF/Ek2RVBpnZQKEUG/kaCidRuzEMMZN+vi39+c+zIYIRl1uOFhDQAdX2WHra0IAjjuzxy6/bVjsQv6IvR5uIMli7ZwPw2bZmQkX318eqGlJqUh0NIh22QLQgFRZAfCm6M9nZGlRtR7Ru9jpKgZbxHveqbPB5a/+0i1hSAez++nbyxDFBFWIKivF2SmU7bW66in9DMOFTvQymnQB9fR+68mPWpUBe+Z28P0Sp1BCfQnXTOofYcAN/UsqFiac+UhwRZ9Gn0YI4wzJSPrZUIL3KlppiE896b/fcN/KgLVR+vDpRKM4vgEVAUpULtEfvUFL8By48f7hBudnGR3y/rfl1xSsw6nbG/b8T5Jw3h00HQSX5OhfigfPHw4/aR00rG2Pwxl6/XDwdL92ixuRnzS+9dNVSTWOyW9/W7f0W7+BZOa08c9zK2fqjfIjdcsH/g49ndwl2nFQG2yoCvJkFfzRUi7D6LqYftNZZz7mnnpMF16ldRKkU8jZjEAqjhfbICoMvc6vDtgPc2zLt19OZTJ+OTKPKepOgOVN5ivNZ8MWkBBIE2Ttessn/lwoPPLvf3WZ1sOq3LNVphpDPr+X4mosPbbc4kAjgB+NKgki6WLO7KV6RfsrZ7mU9Rd7ba1u/juvLQq+QBimMM+jea9YpmW65cqg==
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(921011); DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 12:33:23.8131 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ef8430-b12c-4e40-b012-08dc3dd99d7d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296
Received-SPF: softfail client-ip=2a01:111:f403:2412::601;
 envelope-from=ankita@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Ankit Agrawal <ankita@nvidia.com>

There are upcoming devices which allow CPU to cache coherently access
their memory. It is sensible to expose such memory as NUMA nodes separate
from the sysmem node to the OS. The ACPI spec provides a scheme in SRAT
called Generic Initiator Affinity Structure [1] to allow an association
between a Proximity Domain (PXM) and a Generic Initiator (GI) (e.g.
heterogeneous processors and accelerators, GPUs, and I/O devices with
integrated compute or DMA engines).

While a single node per device may cover several use cases, it is however
insufficient for a full utilization of the NVIDIA GPUs MIG
(Mult-Instance GPUs) [2] feature. The feature allows partitioning of the
GPU device resources (including device memory) into several (upto 8)
isolated instances. Each of the partitioned memory requires a dedicated NUMA
node to operate. The partitions are not fixed and they can be created/deleted
at runtime.

Linux OS does not provide a means to dynamically create/destroy NUMA nodes
and such feature implementation is expected to be non-trivial. The nodes
that OS discovers at the boot time while parsing SRAT remains fixed. So we
utilize the GI Affinity structures that allows association between nodes
and devices. Multiple GI structures per device/BDF is possible, allowing
creation of multiple nodes in the VM by exposing unique PXM in each of these
structures.

Implement the mechanism to build the GI affinity structures as Qemu currently
does not. Introduce a new acpi-generic-initiator object to allow host admin
link a device with an associated NUMA node. Qemu maintains this association
and use this object to build the requisite GI Affinity Structure.

When multiple NUMA nodes are associated with a device, it is required to
create those many number of acpi-generic-initiator objects, each representing
a unique device:node association.

Following is one of a decoded GI affinity structure in VM ACPI SRAT.
[0C8h 0200   1]                Subtable Type : 05 [Generic Initiator Affinity]
[0C9h 0201   1]                       Length : 20

[0CAh 0202   1]                    Reserved1 : 00
[0CBh 0203   1]           Device Handle Type : 01
[0CCh 0204   4]             Proximity Domain : 00000007
[0D0h 0208  16]                Device Handle : 00 00 20 00 00 00 00 00 00 00 00
00 00 00 00 00
[0E0h 0224   4]        Flags (decoded below) : 00000001
                                     Enabled : 1
[0E4h 0228   4]                    Reserved2 : 00000000

[0E8h 0232   1]                Subtable Type : 05 [Generic Initiator Affinity]
[0E9h 0233   1]                       Length : 20

On Grace Hopper systems, an admin will create a range of 8 nodes and associate
them with the device using the acpi-generic-initiator object. While a
configuration of less than 8 nodes per device is allowed, such configuration
will prevent utilization of the feature to the fullest. This setting is
applicable to all the Grace+Hopper systems. The following is an example of
the Qemu command line arguments to create 8 nodes and link them to the device
'dev0':

-numa node,nodeid=2 -numa node,nodeid=3 -numa node,nodeid=4 \
-numa node,nodeid=5 -numa node,nodeid=6 -numa node,nodeid=7 \
-numa node,nodeid=8 -numa node,nodeid=9 \
-device vfio-pci-nohotplug,host=0009:01:00.0,bus=pcie.0,addr=04.0,rombar=0,id=dev0 \
-object acpi-generic-initiator,id=gi0,pci-dev=dev0,node=2 \
-object acpi-generic-initiator,id=gi1,pci-dev=dev0,node=3 \
-object acpi-generic-initiator,id=gi2,pci-dev=dev0,node=4 \
-object acpi-generic-initiator,id=gi3,pci-dev=dev0,node=5 \
-object acpi-generic-initiator,id=gi4,pci-dev=dev0,node=6 \
-object acpi-generic-initiator,id=gi5,pci-dev=dev0,node=7 \
-object acpi-generic-initiator,id=gi6,pci-dev=dev0,node=8 \
-object acpi-generic-initiator,id=gi7,pci-dev=dev0,node=9 \

The performance benefits can be realized by providing the NUMA node distances
appropriately (through libvirt tags or Qemu params). The admin can get the
distance among nodes in hardware using `numactl -H`.

This series goes along with the recenty added vfio-pci variant driver [3].

Applied over v8.2.2
base commit: 11aa0b1ff115b86160c4d37e7c37e6a6b13b77ea

[1] ACPI Spec 6.3, Section 5.2.16.6
Link: https://www.nvidia.com/en-in/technologies/multi-instance-gpu [2]
Link: https://lore.kernel.org/all/20240220115055.23546-1-ankita@nvidia.com/ [3]

Link for v7:
Link: https://lore.kernel.org/all/20240223124223.800078-1-ankita@nvidia.com/

v7 -> v8
- Replaced the code to collect the acpi-generic-initiator objects
  with the code to use recursive helper object_child_foreach_recursive
  based on suggestion from Jonathan Cameron.
- Added sanity check for the node id passed to the
  acpi-generic-initiator object.
- Added change to use GI as HMAT initiator as per Jonathan's suggestion.
- Fixed nits pointed by Marcus and Jonathan.
- Collected Marcus' Acked-by.
- Rebased to v8.2.2.

v6 -> v7
- Updated code and the commit message to make acpi-generic-initiator
  define a 1:1 relationship between device and node based on
  Jonathan Cameron's suggestion.
- Updated commit message to include the decoded GI entry in the SRAT.
- Rebased to v8.2.1.

v5 -> v6
- Updated commit message for the [1/2] and the cover letter.
- Updated the acpi-generic-initiator object comment description for
  clarity on the input host-nodes.
- Rebased to v8.2.0-rc4.

v4 -> v5
- Removed acpi-dev option until full support.
- The NUMA nodes are saved as bitmap instead of uint16List.
- Replaced asserts to exit calls.
- Addressed other miscellaneous comments.

v3 -> v4
- changed the ':' delimited way to a uint16 array to communicate the
nodes associated with the device.
- added asserts to handle invalid inputs.
- addressed other miscellaneous v3 comments.

v2 -> v3
- changed param to accept a ':' delimited list of NUMA nodes, instead
of a range.
- Removed nvidia-acpi-generic-initiator object.
- Addressed miscellaneous comments in v2.

v1 -> v2
- Removed dependency on sysfs to communicate the feature with variant module.
- Use GI Affinity SRAT structure instead of Memory Affinity.
- No DSDT entries needed to communicate the PXM for the device. SRAT GI
structure is used instead.
- New objects introduced to establish link between device and nodes.

Ankit Agrawal (2):
  qom: new object to associate device to NUMA node
  hw/acpi: Implement the SRAT GI affinity structure

 hw/acpi/acpi_generic_initiator.c         | 146 +++++++++++++++++++++++
 hw/acpi/hmat.c                           |   2 +-
 hw/acpi/meson.build                      |   1 +
 hw/arm/virt-acpi-build.c                 |   3 +
 hw/core/numa.c                           |   3 +-
 include/hw/acpi/acpi_generic_initiator.h |  57 +++++++++
 include/sysemu/numa.h                    |   1 +
 qapi/qom.json                            |  17 +++
 8 files changed, 228 insertions(+), 2 deletions(-)
 create mode 100644 hw/acpi/acpi_generic_initiator.c
 create mode 100644 include/hw/acpi/acpi_generic_initiator.h

-- 
2.34.1


