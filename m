Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A3A6C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 19:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj0uW-0001fp-5n; Mon, 04 Aug 2025 15:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uj0HT-0002PY-Ge
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 14:51:34 -0400
Received: from mail-mw2nam10on2060.outbound.protection.outlook.com
 ([40.107.94.60] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uj0HR-0003LE-Fc
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 14:51:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQ0kcoiJ/GsJsmCkBcui4SxV3D282aghDg0npfxdEDluEDfGkkIM71+TChzzUi65AVUmTaDEK4yGj4o43KvVGSWFVoi51LZh63SAtuwPNeJXZmHmz32RQonaKh12j8oGi+DdHGoOaiobXfI7Cnp1NMvk/pVSrYwR32i5wtWugGCn4myaJsWcZjBdwh7tPunm0o02zP9eGU3zzPS7LjpC9m3JURJq7I2Cj+1+oie1HQi87zFiRRduqo/oqKjn0Bpl0asbyaPs6ILh/zuyfI+t1+EFpGMZopnC+aUEJ7EUtRGxJyRyFuFNKgsZm9mprvNNcaCzK0Jhx75w6McMZ6J/QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4N9zrYPo1jVCBG6Yg1XPbu5ulmmvEoO/S0ySTEqlaM=;
 b=Ly7/6FI+I8yYXUX02TGq+EzDjYH/fZDu9RwPYnPUPX1TxzbuyD6MsB19O0lGIpdj71xxay9vtssX5hOVUSkAOq2sQ7cJwtg9sRFKKGN+IyBWAJ2Maw4VB1jsgv5ELi9ABPHBokiGbmSIcqpfWuvaqmDDDvgZ08pdg31q8sl1mTQF/hp4TQIiaYVEcKBZWltYcKV0huwt60f3SHa/r+IVz/jYqebWCpgoFXmGMLPtZn+anL5MaLufUqSvTB2LYJY1Qe/YRSLJOrvDNCVgkhGQ4F8MS26KPhu/vnNp+OjHfxynrx/3o2U/SW/8C3U+5pmB66FKl1xYd/MHRoW4Is1WVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4N9zrYPo1jVCBG6Yg1XPbu5ulmmvEoO/S0ySTEqlaM=;
 b=VROgNe6FFNjNIaZNzUE1DzBldoY0zZOl6XWWF7OvIllqfAwweXyOWRuUB3MmlYdstoYjkAKGgBQNyDMrv11RgNKjKZaigbC38RAK9rxUZHX84/Y4tMoFAhUfxG4dLKM1bGODDcJD7+AZGH2QSXaZ6JLRLLWHjIRYQ7vy8Zg09EOURya1tlqlO0TDzrnr18faJXisH+3BbvdRzf6/eOxbrb8UZzjS48BebDbQdHyYZKr+8Qe4I3zVN1BLcq6UlAeR7l9dPI84Iy01knBDzAa1ib9KWv6ZkUQtS+37xmO8zBjYmCcr5i84bsH1PGAtyhmKu32y4SHKNaX77B/PRbvyIA==
Received: from CH0P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::28)
 by DS0PR12MB8043.namprd12.prod.outlook.com (2603:10b6:8:14d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 18:46:17 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::dc) by CH0P221CA0011.outlook.office365.com
 (2603:10b6:610:11c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Mon,
 4 Aug 2025 18:46:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 18:46:16 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 4 Aug
 2025 11:45:52 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 4 Aug
 2025 11:45:45 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 4 Aug 2025 11:45:45 -0700
Date: Mon, 4 Aug 2025 11:45:43 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
CC: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: Re: [PATCH v4 02/20] hw/pci: Introduce pci_device_get_viommu_cap()
Message-ID: <aJD/1w/sNcy7C3Uv@Asurada-Nvidia>
References: <20250729092043.785836-1-zhenzhong.duan@intel.com>
 <20250729092043.785836-3-zhenzhong.duan@intel.com>
 <9989340c-c304-4208-9c33-f54fc5d1e865@redhat.com>
 <IA3PR11MB9136DEF9919BCB1B4F9662619224A@IA3PR11MB9136.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA3PR11MB9136DEF9919BCB1B4F9662619224A@IA3PR11MB9136.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|DS0PR12MB8043:EE_
X-MS-Office365-Filtering-Correlation-Id: 24250d41-a7b9-46ef-ce47-08ddd3873210
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iEx4kRoJlY0YRAcLsHp0s0JOBQPcx9ED4q29fCNAWmoW4dV1wX+ICPqOsIno?=
 =?us-ascii?Q?ftNbmULrgSSShiKtp9CrfigvuyIq3+v5jcmymJpNUA9f4fRpieycXQ1mGLIU?=
 =?us-ascii?Q?2qJJ32SoVzcaJHtTNJ188vsUvT5VSqQIR9zeL59wIsPr7x1xpPLOfgFlY9FW?=
 =?us-ascii?Q?bVR1unV+g/gArgjOsapzkKnLgxTCsFHU8xYB0aMYeaJxhYg+zWGI6byxEvkZ?=
 =?us-ascii?Q?EcxkclFxjdnQQ7XvaA4Ae7772DAiB8F/FCEj0Zm0bumv23ptNRSm9tCliEwR?=
 =?us-ascii?Q?+JfcqhNnEiMcwKdi4z7Udy38gMKIuBiNT960aNi8lM6UcDACrZDvjexwGeJQ?=
 =?us-ascii?Q?M3HdGMBKDcw777nsswav+8jZCOgmn7ohA2ILa9ouacDMih0Ae4cLiZx0s2EU?=
 =?us-ascii?Q?Z+BDZzkNiNiRV4jUys9S5m8toG4sRsqReimwnullb7sWSmyooqdG092u3mws?=
 =?us-ascii?Q?QbZfT/txDnL4UCFKPpzZ0Mzy4D6TwP0/6pYm8KdZFkFrmZMyL7nbgV2lMLl1?=
 =?us-ascii?Q?h1un+L4QkwGd/4lGON2c38uqSrZVzbbzbkZWwfADEvwB34X69f/PNbwCNsOd?=
 =?us-ascii?Q?jN6bZDysGIJ1ldiq3c4oIeWv1iUMGiDfRYxb9ruzNHlItLWVuNao7qsoHbtU?=
 =?us-ascii?Q?3F6S4+Iq9ZM5oQMhIEygbeHI3M0r4aOm7pnyKpEsDs6AvTySvFA8gi6SlDph?=
 =?us-ascii?Q?cMD0Vxec1mPfy/ITNmM/XvwLH3JbsP/3NaHmUPrE3Uns1XntZ/Z/gc+2TuJo?=
 =?us-ascii?Q?kdpYjH+MC0lHZ4/2VLlYsxoirsaWlWMyN5O0aYi0MXT9/U+/TUMGuNadbkR8?=
 =?us-ascii?Q?ZN/ToAVAiEkU31xVyJTfb2LZ00quhciQipvBqd5lWRJkht09o2UpGhf8wpqq?=
 =?us-ascii?Q?5tuQWgcx3gVwQEBy8C7vEB2aH74OEFa2yBuxSTOgm7ee6xyfST9WPGyseQ3w?=
 =?us-ascii?Q?P9JrOJUT740vJo1tAVLzX85Qsz7PjdRQXTxptNHjU7yE9/Cr3u7JRyBv0C1X?=
 =?us-ascii?Q?t9XGGgixf2RHfvq7FCLZWwsBiB/PNubfP39zBNEAf0Zmy0EyF4cySRB/4WAg?=
 =?us-ascii?Q?IB8kbPit/0ynZxkbzKxSBy0QHMnBHA2LlGOErPIxWUd5Kp1fl9D9cvVlyFSh?=
 =?us-ascii?Q?N06kIUEDtTQIwOAuEiDaK05+nCouVVH3mjBKjZHS27c8yPtkcj6k25IS8qCm?=
 =?us-ascii?Q?ZknN1US0+W9BbYyA63JB+dp33bXbfH76FljUQS8EdzLZpjCq9wBvl361lwON?=
 =?us-ascii?Q?i6MRVR3Vmdcjm4npWJZsUTpMszE3YwEAqMjkmoxRGMPlv2XjoA+N4G7LC/zA?=
 =?us-ascii?Q?R3zb7GzniJV+TAzs0Tm0KyAuCr4ZXJwYhitnmuq4LSc/rEvkEfn/EcPMz7J1?=
 =?us-ascii?Q?NFYqDJSCU/nBzX2+aOYTnfLhR1TCv+WxpJtSJ454cmHvqY4qim8008YoXLy3?=
 =?us-ascii?Q?H85xF8vjci4HxvWO+YhrKzM3RqtJCUkD4IxaepAme3bdKHuLz8uCclMb9KIw?=
 =?us-ascii?Q?2pK/p7HwT8lAgjyYkT+X4lI4Qcc63rM35qle?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 18:46:16.6940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24250d41-a7b9-46ef-ce47-08ddd3873210
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8043
Received-SPF: permerror client-ip=40.107.94.60;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On Wed, Jul 30, 2025 at 10:51:13AM +0000, Duan, Zhenzhong wrote:
> >> 2. there can also be more than one vIOMMUs with different user
> >>     configuration, e.g., arm smmuv3.

That's correct. But would you please elaborate how different user
configurations would benefit from this new op? I don't see a good
reasoning behind that.

> >> 4. It's too late for VFIO to call get_viommu_cap() after set_iommu_device()
> >>     because we need get_viommu_cap() to determine if creating nested
> >parent
> >>     hwpt or not at attaching stage, meanwhile hiod realize needs
> >iommufd,
> >
> >hiod -> "host IOMMU device"
> 
> Will do.
> 
> >
> >>     devid and hwpt_id which are ready after attach_device().
> >
> >I find the above sentence difficult to understand.
> 
> This is trying to explain the reason of order between attach_device(), get_viommu_cap() and hiod realizing.
> What about:
> 
> 4. host IOMMU capabilities are passed to vIOMMU through set_iommu_device()
>    interface which have to be after attach_device(), when get_viommu_cap()
>    is called in attach_device(), there is no way for vIOMMU to get host
>    IOMMU capabilities yet, so only emulated capabilities can be returned.
>    See below sequence:
> 
>      attach_device()
>        get_viommu_cap()
>        create hwpt
>      ...
>      vfio_device_hiod_create_and_realize()
>      set_iommu_device(hiod)

I think it should be:

    vfio_device_attach():
        iommufd_cdev_attach():
            pci_device_get_viommu_cap() for HW nesting cap
            create a nesting parent hwpt
            attach device to the hwpt
            vfio_device_hiod_create_and_realize() creating hiod
    ...
    pci_device_set_iommu_device(hiod)

?

Thanks
Nicolin

