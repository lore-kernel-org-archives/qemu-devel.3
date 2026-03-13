Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F3D7105F797
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 11:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w10M9-0008Ha-AI; Fri, 13 Mar 2026 07:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w10M5-0008Fx-Ja; Fri, 13 Mar 2026 07:06:57 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w10M1-00055u-IJ; Fri, 13 Mar 2026 07:06:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QOqU75B5up4rwJzvrozAQsU+6MXxgNsEACe54h8uB1y4NTGXazCKYX9IUYnV1V5vSn86ugnbp/kyD+s9R2fiTr/1fWxXxXPKEO+8H/JcOoXVxozkTzlbkQNYhnVvAjgbj0+5bZIYMViOpUktTqGRcL0zH44+pJsiwZ6bR2FSltuDndIMNo9q4DSF+tEw/sn6q0oCc6rj+MGn/kc4LUhSt0wqNJAjdwmiySw0jntwnIRCATP70m5s5UNFB4WQ0s7EhclV9MMWROa3RhCgJEGr/uQb525zerlAdcxtIQtYgaqtpyBw11S/FxfHwrYBJf408OG2D/RSp5cPQmNVXM3FKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3S+TGVTBSIlKVRPMCcb3RLxt/q8MFmdTSITt3ArbI8=;
 b=Js6d58Pq1FW9u9egCKXpb2NtysxS7FeKIokt5gFmW1xz2PPp73WAaLhFGbA39zs5wZiMJ310WSKDfuQg9Njd2aOk5c4shdCe+WWchOp+FJrjl7HZYXcUF1pA4q8WvX3K8eu8zI65MXS7XXUrzFbnx81QR+B8nCa1Fb8IYYGHUeTrdGN6kltGw8291v3g5X9hcQBgOS3rDxOuKf0673atGrj4t5FQ0xy/1n6oHZVmZJoOFd3hQtDVnpBiB53NTfpIjmqD0mQuOPCCUy0k5Gl4aKP3yp4wXp4hRMxxnOS2jFBL2qEx1Sp4RNYsnO7mEfMo+x2K6g8tp1BXcOC63Zn21Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3S+TGVTBSIlKVRPMCcb3RLxt/q8MFmdTSITt3ArbI8=;
 b=MkYJ73HB4AbvnEblmUlnyUvmHZhae45RH0lJ7oKMjsXwd6o9C7CopMEz8IdjkfanridqV+wl98z9ul3x+iYvufPTTdPAdn5tAwtVBl7ApI7vZg9gHpCX+k1ZicRWApEhmwHLleuHdvAegQ9I51XWFY7yxRcDBG3Ft5bshIkOVB4xdtszEnj5k0ppcdoz0J2ZQ29I+Qp5l9BV590+NejrUcADTjifbF26OVoReRFhT7XnGS3LXNDM9cinmrJB21spmLJlTWIgP9DqPstWik4Q4dyoSvS/gIruNhN+dikyflqilfpB6mID1v6ree6vl/9/CU1lnV3Fldxbj1pQpPPBsQ==
Received: from IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5)
 by MW4PR12MB6998.namprd12.prod.outlook.com (2603:10b6:303:20a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.7; Fri, 13 Mar
 2026 11:06:44 +0000
Received: from IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::5a27:a8d9:43b7:3b8d]) by IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::5a27:a8d9:43b7:3b8d%6]) with mapi id 15.20.9723.008; Fri, 13 Mar 2026
 11:06:44 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>,
 "phrdina@redhat.com" <phrdina@redhat.com>
Subject: RE: [PATCH v3 00/32] hw/arm/virt: Introduce Tegra241 CMDQV support
 for accelerated SMMUv3
Thread-Topic: [PATCH v3 00/32] hw/arm/virt: Introduce Tegra241 CMDQV support
 for accelerated SMMUv3
Thread-Index: AQHcpw3oDG8WqWxWgUa8hhn9GSra0LWpupEAgAAAwzCAABnkAIACjn6w
Date: Fri, 13 Mar 2026 11:06:44 +0000
Message-ID: <IA0PR12MB7555CA822FD5AB486C7512E6AB45A@IA0PR12MB7555.namprd12.prod.outlook.com>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
 <254dceca-7864-4dbc-b25c-928add5a78e3@redhat.com>
 <CH3PR12MB7548B7D18FA56E6F8EA657C0AB47A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20260311200010.GD1448102@nvidia.com>
In-Reply-To: <20260311200010.GD1448102@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7555:EE_|MW4PR12MB6998:EE_
x-ms-office365-filtering-correlation-id: fd60986e-0074-4284-daa1-08de80f09cf1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021|56012099003|22082099003|18002099003|7053199007;
x-microsoft-antispam-message-info: ZnvixXYkeXsZuC86mpR4T9WAKrQMM9GwuBiHqxLnzNNJRYxQXt1po+kSdHWIAJLvnPTQUZHUd/HiJodnD3vC4nslKcTEq1x9hm0NEmxKVnlT2E4ZjULIecilZpG6Lb+e5iwsUMuTR9sxghgOtx9sK860FyvlEfBLMztag22ks74Q59+N2kyX26ZbArULKeWaxXi5v/emK95PAiMphUJ32+M2A0r1OSZ+R7VVNyIuH0F1lafVcpV5IocyStep3/mpFQj467GXwF/folGnpruN6RwosYjXsK+BHbY9JjkQKJGd7YgGqdq7i5e683xFgxw1PwEjCQhwlE08uPzycGwF1QWMjaLGlP23+r33/1ZoYR8Ez8J0h6/puoxCI9DIpDVmYlORKN4Qj51IILJja8yEPe3xyJeA7SsdWnFLlVmAMxlUkVlxu0Z9jSSFYymoy+UYV/WaLHgM+tvMdxrW/iPHSrt6DngoNOWgFWXDBxYSj/+uhuVJCvJ1npx9rQ8fF8kOxhGPeQxpCvBgApWUgK2cIpVuJxgF/PMocI/SHHXt6GQrv2V3ziRBWfy5QjOfUe4y2VhauB9iIOGb0H9brwXHggnAKReraFbdknWN2vCMQCbpLL5CLbZCDCA9N3KR3H7EHRltCC/PvLScmi+tfvJsVh+77kp9TvqdWKYTyCTVRLFhQLqBPY0Pol1N3QxN3N4Y1E7qk+40ZkPEvJ6obiJhZ3TSgqWsknT765eNJTvk8lOReaczmHu9kLRbamOgUGT6I9iLXwdL4RcLWEZVDLIGgTCTRyI45v9xHzMZwSDhYuY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB7555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(56012099003)(22082099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7iEP6dhpajqTG4s99l2TRQlP6zN7rDTuHjtLQBrb5cKftU7K7IOs4UuH5eDX?=
 =?us-ascii?Q?aILbFFY07WS0XvVkAq4/mgGYzypbnrVN7vCOkRTeRGOZWyU1uXiOB7hDYSeF?=
 =?us-ascii?Q?B6eSVxS6l4+CsqFsIRqyju22eRHs4iaploUY6uSnOH1R6s2k/N86/e6xp4j5?=
 =?us-ascii?Q?QJz3UwKw17SNLvJwBIRjk6YXBxT+13BvdTvVC5DCJ7ZRO/V2+7s18nEfp7V0?=
 =?us-ascii?Q?PH7lkhRlx1WCI6AVjSFYT79DDqiidYvJ3U3FYv2yjT7qk+s6QTExbN0oMZw8?=
 =?us-ascii?Q?dyAEeUjwqlvolhdPtqxSdwExQ0WK0zCvo8qg0XmXptW2sYfqTclwjl7TtyEB?=
 =?us-ascii?Q?FZQJp9u0Z3CFnaAbL5zWbaLIs9BNDg9rRSmIUPGB7lHX3Cz8mwerF1a2pr+0?=
 =?us-ascii?Q?XbDk1ggFHRNmQBEZ/6VD+iXP3Ik99wEkK4AmLjUAVqSfTMnVR1wPdU8O7/Fk?=
 =?us-ascii?Q?GajodpSit6HSRlMzrfZgYslGEobWgbJYQMU47FJiCdGMrG9ohkktepV11wPk?=
 =?us-ascii?Q?MlfXs6Hlqriynjjv2SlJjRL/liygtflc7q/U+VWTH4bC+OVOzbI+iBmDoM4k?=
 =?us-ascii?Q?4859WWHdA6I4Vd7ZvDulWnSywsssycHYAaB/4Z/IbNETtI3u2l+FnZpW1pyp?=
 =?us-ascii?Q?RICgChIjdT9P0uDyO6S6vHgBhiBrlBZQQ0sEDpVjPRAkFb0msbHijn+DmMNa?=
 =?us-ascii?Q?1ujVQ8b9U/8MAohSWGul2o7I0jllOtoHhFXxmShlokkuXfJnkzTgHCs3cBhM?=
 =?us-ascii?Q?LqLbabtB4m4K/nFRaQGtMZ+5GZtDSe1YkycFDjEpewb+hMc+JkmdElavWWNK?=
 =?us-ascii?Q?5+n8qdp+ETWIIimd1C0VB1XtNCJxd1CyiZ/Om0fh1AZTG9ZgR23tvm9kzGGW?=
 =?us-ascii?Q?djfhF+8xsUw8vI4W5OvhIbN/dnmI749Z3vUl/R8D0Q7FdXK03SPVUjnK+LMt?=
 =?us-ascii?Q?XL1tt3G88G2NKfKv0FEbGd8pfjBCVY5/38KNrpMo3xqZ+xKiIDI4DExBC29V?=
 =?us-ascii?Q?hQCcHs5wFdamZmgYJS4RVJSB+gwx4WhKrCQqub74SHycUYXMtpaee9Z5ytca?=
 =?us-ascii?Q?+Jf32Ybfup6TtSEI2gJvIuNAhMjGY31GzhBt2AJbjPot18JDkBXlqrNXHcXv?=
 =?us-ascii?Q?33w2urCy1SF3TyFlTS7d3VWOhcJDg9kfyr7NXNAyjAD8OERlP15TSrT1Oii2?=
 =?us-ascii?Q?LaJ9ObluXvshcmbkAtw/52sPkgmofQepZvex3p8fixkVRbPsbprE4KANe5Ty?=
 =?us-ascii?Q?YpxFyO0WBwIyB7cQcd15ZwsrPU0t86i5mZGQKnx5lIFghqERU3IGJeFWAlxn?=
 =?us-ascii?Q?O/atZcLjWZtXyTv04jrAhf76HDTIx1tct02imPorUsH63Kj1qzz9Gte3xzPq?=
 =?us-ascii?Q?DIjRp092fsHYPOk8f+eQQg8i/W/ymOgyP0UbAhQ+nJeyVBDgNe1FsFMR0Jsi?=
 =?us-ascii?Q?wQbbvISOfNQ2g5YqjfsLlkwq3/hA6eLdK2wJZUsb0UkP/Mlzvr6dTZA8xC6F?=
 =?us-ascii?Q?DvlYXkgOTBFkxvDwvT6dvNX5te5NGT91l8IUfqo4Xdbee4pg0G6Z9tSUsgKN?=
 =?us-ascii?Q?l8jVgEnEh3EP+b0gNO/GeHcbhEWBZJoZq6zGv7v4EPBjj9fgeGxtsrpaWCY3?=
 =?us-ascii?Q?rGbEGIKT2YQyQqm/y4P1DxjkFrbxv0QGAwW7wACt4wNXzK2aLKpv4mF73H6M?=
 =?us-ascii?Q?HDLZh9sRnyZkd7F1g2nK4bSe6fQM5bxAbTnKdcxw8BKQerG5zVHhzzfgA7+o?=
 =?us-ascii?Q?mSrSu/hGwA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd60986e-0074-4284-daa1-08de80f09cf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 11:06:44.6588 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iMf9oE4DsPPJJV5SfmadEKUOQ4HgSRbIPhNYD5+PB3mlN6LFCEl3DYVOQa93G4VVqyYJ2p+/tHwgZgQ2o4l3sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6998
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: 11 March 2026 20:00
> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Cc: eric.auger@redhat.com; qemu-arm@nongnu.org; qemu-
> devel@nongnu.org; peter.maydell@linaro.org; clg@redhat.com;
> alex@shazbot.org; Nicolin Chen <nicolinc@nvidia.com>; Nathan Chen
> <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>; Jiandi An
> <jan@nvidia.com>; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; Krishnakant Jaju
> <kjaju@nvidia.com>; phrdina@redhat.com
> Subject: Re: [PATCH v3 00/32] hw/arm/virt: Introduce Tegra241 CMDQV
> support for accelerated SMMUv3
>=20
> On Wed, Mar 11, 2026 at 06:34:38PM +0000, Shameer Kolothum Thodi wrote:
> > I do not have a way to suppress that warning currently. It should be
> > safe to ignore, similar to the behaviour before the dma-buf support
> > series for vfio-pci PCI BAR mappings.
>=20
> qemu should have the concept of memory regions that are not available
> for DMA peer to peer operation - ie are not mapped to the iommu.
>=20
> Now that the kernel strictly enforces this it is essential qemu itself
> keep track if it thinks p2p should work or not.

We could introduce something like the below to address this. I will
include it in the next respin.

Thanks,
Shameer

---
 include/system/memory.h | 2 ++
 hw/arm/tegra241-cmdqv.c | 1 +
 hw/vfio/listener.c      | 5 +++++
 3 files changed, 8 insertions(+)

diff --git a/include/system/memory.h b/include/system/memory.h
index 02b2e83fd7..fb37616503 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -874,6 +874,8 @@ struct MemoryRegion {

     /* For devices designed to perform re-entrant IO into their own IO MRs=
 */
     bool disable_reentrancy_guard;
+    /* RAM device region that does not require IOMMU mapping for P2P */
+    bool ram_device_skip_iommu_map;
 };

 struct IOMMUMemoryRegion {
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 42d7dbfde7..4647b4db54 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -212,6 +212,7 @@ static void tegra241_cmdqv_guest_map_vintf_page0(Tegra2=
41CMDQV *cmdqv)
                                       memory_region_owner(&cmdqv->mmio_cmd=
qv),
                                       name, VINTF_PAGE_SIZE,
                                       cmdqv->vintf_page0);
+    cmdqv->mr_vintf_page0->ram_device_skip_iommu_map =3D true;
     memory_region_add_subregion_overlap(&cmdqv->mmio_cmdqv, 0x30000,
                                         cmdqv->mr_vintf_page0, 1);
     g_free(name);
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 1087fdc142..d47439befb 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -614,6 +614,11 @@ void vfio_container_region_add(VFIOContainer *bcontain=
er,
         }
     }

+    if (memory_region_is_ram_device(section->mr) &&
+        section->mr->ram_device_skip_iommu_map) {
+        return;
+    }
+
     ret =3D vfio_container_dma_map(bcontainer, iova, int128_get64(llsize),
                                  vaddr, section->readonly, section->mr);
     if (ret) {
--
2.43.0

