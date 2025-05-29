Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E383C54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 21:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKkYK-0005Tf-Gl; Thu, 29 May 2025 17:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uKkYJ-0005TH-Ae
 for qemu-devel@nongnu.org; Thu, 29 May 2025 17:12:39 -0400
Received: from mail-bn8nam12on2072.outbound.protection.outlook.com
 ([40.107.237.72] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uKkYG-0004pw-P8
 for qemu-devel@nongnu.org; Thu, 29 May 2025 17:12:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4o1UISJxLy/b3Dp+m0PJRV+649fJt6Xr4gTB9MFRlUx4RlmdGZS9Qul4hIiVD6boaZqjXhJdoZchBK4k47ce2owmMfh9zB8RyJo0Se8oDgSgiqp/H92Jsg3mcv9wcnEVDZI8/qtebx/W77EtGkuxnFaLsVDUkR/d1m56y7+Tn7rwbmRvFvJRnBCKb4VHQIUPd2Qn8rJRII+VBmaho+0zmEl93fptxW5gemuukMtIJ9yWOW2Zca/sN5Yz/4yAc2xWtww62opZ4mgIEmuma/tFcVprQG4egONSPmVKsGJTpToP7lrTqSos++e0wG+ohBAIzLEWQEQ/0lEblnxrJEIoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nJKDHkchxUJWkMq6VUvHRpbRcmq1DgfnxuCVm9cg1Q=;
 b=QNWfVZKD8lcFHTyf7JUxPmIy1/cpqwisZMwfCMXGM1WBgMza2DhcMjw3snPr3sHM/aK+VTwApSwFVcAabAterguy2wE4p/leQ9pE7Kpk3mYrHionMTCkf/VRVnEQ2WbtAQ8EECK7MRXBivg5ucOZEmKpTFrf467aRs39Mn6YwRnRsHJ3pyZDHkcr+X8zbt2x4BvDL8oFL6WF7GCz3ZqJ3xL4XVr6QCvljgIPBhmpnG3dXIvgJgy1ecyOc8XM1tOwTDCwrtn/Ajd8tNK/fsI9lz+tIfmtjYEtAXd2GyVyzlVwXzrBvIRjG8e5rbNFNVBxLcuaMgWjM6pvvVSmoVF/YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nJKDHkchxUJWkMq6VUvHRpbRcmq1DgfnxuCVm9cg1Q=;
 b=P39JGsZ6QDPpkg6D466a/9lINo5ASBM7lFUn+VX3yqGplbTEE3yZViI6dEQ/WQAYR3NqlKCfxFnPMJYWYvYhOAaILLZnHLjSZ6mOvszArivwKiv6OnIBEx9KqHeenYms3Ams4kRXHzNMVtQPnYiZTEVmiZFJk61CFEKQ+31ISuOzFRdyAvfZOqCZHd2FViqhTkGQ/sXCqp32Q07ZqyDjyuaWvPgtrPzfU1KKPp7wiwCEhNO/CbEh5zu/RVzildUlUjHC9CPPp2JpaBQ/Lfxv8Q35xdUTqDuGm//12YNtq921QyQcM0JDN8de8VWns+96GoX57iMUxYI2T7UYI1ESsw==
Received: from PH8PR15CA0024.namprd15.prod.outlook.com (2603:10b6:510:2d2::9)
 by MN0PR12MB6054.namprd12.prod.outlook.com (2603:10b6:208:3ce::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Thu, 29 May
 2025 21:07:27 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:510:2d2:cafe::57) by PH8PR15CA0024.outlook.office365.com
 (2603:10b6:510:2d2::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.20 via Frontend Transport; Thu,
 29 May 2025 21:07:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8813.0 via Frontend Transport; Thu, 29 May 2025 21:07:26 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 29 May
 2025 14:07:10 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 29 May
 2025 14:07:10 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 29 May 2025 14:07:09 -0700
Date: Thu, 29 May 2025 14:07:07 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
CC: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
Subject: Re: [PATCH v1 1/6] backends/iommufd: Add a helper to invalidate
 user-managed HWPT
Message-ID: <aDjMe56/goeuu386@Asurada-Nvidia>
References: <20250528060409.3710008-1-zhenzhong.duan@intel.com>
 <20250528060409.3710008-2-zhenzhong.duan@intel.com>
 <538e848b-148a-49f1-bf06-f534ff44bf87@redhat.com>
 <SJ0PR11MB6744B5EEAD02E7DA89263AA99266A@SJ0PR11MB6744.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB6744B5EEAD02E7DA89263AA99266A@SJ0PR11MB6744.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|MN0PR12MB6054:EE_
X-MS-Office365-Filtering-Correlation-Id: c6a4ec0c-64e7-45b3-2a3a-08dd9ef4d0c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|7416014|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yCHHtPFzkvMkd4lNE+v8OeWVnkvFD1Cs4G4vUDiIhU0WzjXKdFTFCAlIwcdQ?=
 =?us-ascii?Q?mkGM6SqcmC33ii7zTimbuAqj4YDjzXqyZC2o0KDJgJz5qAPKlk98kaPDZRfQ?=
 =?us-ascii?Q?VQMrIvUhTyFrNnWd9eUV7vB87Itk9ZWo24Nvl8m1pH+0gzPCNk7DXPGOzkc1?=
 =?us-ascii?Q?DjUSJz3H4VC4mQ8TLqo2crhNmZVR0ycuyAcOyvYErfK5f75ok/yZLQ4AEfqn?=
 =?us-ascii?Q?JLYOEmtKPb8QfzndsSoppDeJoO0FnFSUMqK7fy0rjTqi2gZ89xtQvPKxirQW?=
 =?us-ascii?Q?8QvGmRKY5hTktH8lxoIp9ak6owyaRQFomVWFvZpjk3iRYryzwsmI90xa2xuV?=
 =?us-ascii?Q?gYd5HCtoAGrm4GC4RMjGwKF6qwtNn3UeFwMtqI52l0TcXGDCb1eYlah6kIdY?=
 =?us-ascii?Q?AZykhdKvk5SaR/W3zewnP3/6GtigeBr+zAZE1oLzUFelZYr8NQBe4rayyOgW?=
 =?us-ascii?Q?6gsiEh5bHbJ1lTLxcKxnLm1A5H2GtXvBhIMBJVmKS4COCQBBe+nwPSnuxGJh?=
 =?us-ascii?Q?PA3Tnc1IUvpNzk6myZ69BgiiRNrVYOhRmuklDC8c2LkqQ6utKJ4Ii7MJDl7R?=
 =?us-ascii?Q?VCEymcnCumF9j6bpVn2XccBDVUsUqM2Hw9e/+mvaEdd7fSkT1yxYOdr6eMA2?=
 =?us-ascii?Q?zymKAQKTzcHBSoEAHV3sAiKwA/usI3IhL4k+3TIT/RTxpX390d5YRm226/8R?=
 =?us-ascii?Q?TMbKIwS43qIoD00rcWGRR+kq/S0FFZ99NNMVFAdzLNbZOBJuSZT2hO/fxf7j?=
 =?us-ascii?Q?IM4Vcdf9hh+34dp1Ss/rXm1QiShqFi0ZO6rQ48XKiPIKVoy4cgiSOL1O6IOQ?=
 =?us-ascii?Q?j/oUgG13j1lYw6cnFsMVBg4wUwNU+j4WPIS8K3FY95uZaw551eLfDXGl2ODj?=
 =?us-ascii?Q?ZAl40N2qntSo3gpsZitsZ0KOdLoAfEokZmqBYm1plWECdiCSdFIlKcWLPB7N?=
 =?us-ascii?Q?ye6wYTaZ20Hysc8yfXBqh3mYxghmSvY4uzk5djDjUt4G9BCGKDk6l0D7cWRl?=
 =?us-ascii?Q?k2Lup0FSyiuW+oQ/dUOmUe/VizDWJMCT+Uf/ytLPb+JCetHRCxZqFWIqCIjc?=
 =?us-ascii?Q?crBducC+mnT/FrL53CU6YoeEsTq1zrKg8gF2CtqsqKbQ+5w+q1LOOjK6VJkR?=
 =?us-ascii?Q?/DObDOSN+zTFctnN1GxNnanl2RA99Bv4b986u7//nZ+a3pLe2f85szYKoU3j?=
 =?us-ascii?Q?4Y/63bbMJ4GMXozmGvN/wC+GU+EhsftGmkSsDicHrYxL3V2eSmVLd6T6nXJj?=
 =?us-ascii?Q?4hW0B2hrsivVAY1zjqatG9C3Mo8hqTfXSUqcvv2SLLtNkPJAdxryJnJQ8Wad?=
 =?us-ascii?Q?7afv1R/90PtVS9mbAJyZwZ43zf/GFrwdqnDpz3eOHeG4ae5RvzAGZPom169v?=
 =?us-ascii?Q?PWi+c/ehwOQ58UqYrS4BpB9uVd3kOb4Qzargix17AGdxDZi7PBAoXogiYnRa?=
 =?us-ascii?Q?jwfS6leFGktPwRpBPhb5EGh3rsrcbpdczfGKJ1psie6zEzdO56tEoH9bHGxt?=
 =?us-ascii?Q?F3u2XpSfUyYw17vv2szZ0iNsOM4s3yD2S5P+?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 21:07:26.6885 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a4ec0c-64e7-45b3-2a3a-08dd9ef4d0c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6054
Received-SPF: permerror client-ip=40.107.237.72;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, May 29, 2025 at 06:46:20AM +0000, Duan, Zhenzhong wrote:
> >Looking at the kernel iommufd_hwpt_invalidate() routine and
> >intel_nested_cache_invalidate_user(), it doesn't seem possible to
> >return a different number of cache entries. Are you anticipating
> >other implementations (sMMU) ?
> 
> Yes, same for sMMU's arm_vsmmu_cache_invalidate() and selftest's
> mock_viommu_cache_invalidate() and mock_domain_cache_invalidate_user().
> 
> I'm not sure if this should apply to all types of IOMMUs, uAPI doc doesn't talk about it.

It should. The uAPI defines that at entry_num:
 * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
 ...
 * @entry_num: Input the number of cache invalidation requests in the array.
 *             Output the number of requests successfully handled by kernel.

This applies to either ret != 0 case too.

> @Liu, Yi L, @nicolinc@nvidia.com, @Jason Gunthorpe, should I treat ret = 0
> and total_entries != cache.entry_num as a kernel bug or not?

Selftest has that coverage, so it would be a kernel bug that will
unlikely occur. That being said, it doesn't hurt to do that IMHO.

Thanks
Nicolin

