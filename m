Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C9DD6CFA2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 20:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj1HE-0004FK-Re; Thu, 22 Jan 2026 15:27:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vj1HD-0003xl-Oj; Thu, 22 Jan 2026 15:27:35 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vj1HC-0002Bz-5v; Thu, 22 Jan 2026 15:27:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y2XA/hwk9JOlDhYvftp9NgZyN4Bfmz7tmKgFPW036wi7YLuAxbMeFfVGPZ/AMrNryEKMdvbXoJPA/d+PK6ohoG1mBeVIlJ3QS/5u1pHahwOSjhervvbRkhhXCbBfTmKxzUfXhNibRtUiGhMaUdfPhZ9I4Xm4S0BwOHPq8i3ZE4IDAXTkWvRFKPD/Co5mknrp7Zn3ObE2HWeoHS2VojKIIT7pJisgIUf6KCSzTmX9y78W9oMiXBVojhb3SZqX6fDSRHdkafVmF0/T4zM5NEMM4piqUTSkuv7XjDpp2svvnvTSuMoZE5X+4Yb944o7wN8/kR234WOmVXcYkB44xtH9sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bp2qwzi6JSYxO0uhqRDIU1alarw+RA871DKoiWOO0No=;
 b=ag5YSA8BN/fS9ygS1tR8lAtLtWN1Gu19aHvYSrrmJSGLxVa3G2PQvESV4iVUt8AQXBK58GVtvYP4Nr0FMd5G6nPKB7KwTA6L81TS7fzi08bBxmlCX4q9B4EM2ZUDZG5epcDvDe3yPqeKwwY0AcyTxv2mWPCYqS8UlBjSfN7vJdEYlwH8q5AehE+3J4DMCIl7iNnpz9isSz9ERIVktkezrZEsq7vlw8PEhszwXrwhHYagRDCdRzrreklZqP34gY9OLHy12yTlQZsWN9XmDdf2xZWgfAwtlzc3Xj2nXEPQYtIR3hZgp5miU5RVoCEo/dp1yUoEjtrgR3egeGkQSUvDRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bp2qwzi6JSYxO0uhqRDIU1alarw+RA871DKoiWOO0No=;
 b=efRblYEgrGfZ/O3HWSbZFCcjvtxXYzIUypL+FphJvcPgMkjTHggHchM3rDwPz5MsRC/5jVOsPDovO741BJOQKH3didOiRRflkgUMDtqkfHJrpTgHskEDmqNxtlLQ8ceID/v0UzfFDMe13WOCVrmBZlzeZEDUMVFcuWCACTQm6fTFlkr876OQCfc439Jo28sgqsV1E95aes30nygmZm3/MljECbQgdTORwDAsHH84EAT3tfKG+LHDSMwmy9jnziEmNu1trk1JnTVP9niUc84BRzKPQTG+cgtRpKVbUpWeRfEdgfMwFXt+pW7Gom0OXy55MNddJflmGL8c1AFcV+Z3uA==
Received: from CH0PR03CA0359.namprd03.prod.outlook.com (2603:10b6:610:11a::19)
 by CH1PPF7A6EE32B1.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::616) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 20:27:18 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:11a:cafe::e1) by CH0PR03CA0359.outlook.office365.com
 (2603:10b6:610:11a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Thu,
 22 Jan 2026 20:27:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 20:27:18 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 22 Jan
 2026 11:50:51 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 22 Jan 2026 11:50:50 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 22 Jan 2026 11:50:50 -0800
Date: Thu, 22 Jan 2026 11:50:48 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <clg@redhat.com>, <alex@shazbot.org>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v8 33/37] backends/iommufd: Add get_pasid_info() callback
Message-ID: <aXJ/mHspND9fdV8v@Asurada-Nvidia>
References: <20260121175248.87649-1-skolothumtho@nvidia.com>
 <20260121175248.87649-34-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260121175248.87649-34-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|CH1PPF7A6EE32B1:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c4af8f3-9b8a-4e1b-8334-08de59f4a38f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|7416014|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aq31Cyxu1au8SslxlmXZHYzhuzVRtMR08MimixJlhz1cz5YF5icqMcJK7qq6?=
 =?us-ascii?Q?e+7y9kQo5QAaiD7ybCr87iXdCaH/bpjzFH6XtKlvxWnoZe5QEe+aLC8a/Bnz?=
 =?us-ascii?Q?ZUl2UJ3Dq+2MN9wp5qMZr/2XlVLMdW1XqaqYbe/P62RjGOfuoBMrJWk4F+Fl?=
 =?us-ascii?Q?vU4K+az4CS8dfpuzomF6iuLCOMrVJs+W7H35ibtXpQQl3ZH6whi9z4DQ4wXm?=
 =?us-ascii?Q?Bt+1H15QyYc5TZW6JmLN5X7xP4ZUWTCMFWvf9/sHyrMgKbhQPFO6BFX16WI2?=
 =?us-ascii?Q?RZUQlsLf57qCgegZ2/oO+HQVxZjOfdgkemeswShB2qU7d0s/5ZBGRWZjt/SZ?=
 =?us-ascii?Q?k70cpX32xU67/8Azp+MNJGaKDXvrDXZKNR58h8/YN/gOld/3zhXSuGivzmgk?=
 =?us-ascii?Q?kfnxkPJitrkHhzHP3v4CBjJ4R8sgrv9QSMaTbhfDkiVZ+wF3H5fn3TI7LSE1?=
 =?us-ascii?Q?nCEAgIBfEjeGIcd07Uood7h24J/FAC0Of1XxQlQx3HiUCpSOOdT9qBt7NuoW?=
 =?us-ascii?Q?2c89h/cEirlmNcJnV5a1it/BOaElXk5hfO63S4LRzekZ8+uU3gm5dpK5oVo5?=
 =?us-ascii?Q?LKk9ym8PFPAS8Ld6Zo/2l5rT0nL4sgFRFFi9v9jXjUPxj0i6erf9bMcjM5dO?=
 =?us-ascii?Q?BN1+ZrtjwDu94a/ZBZoEIm2bX0kpgR84y9Ot9lLdeeOf7gnuCmdmzJXPRrRA?=
 =?us-ascii?Q?QF5yOrLRiq9M81SNuKcWoPU5H8IXOIsOfVBEDavvYCS10+zFnfSD543yp8QK?=
 =?us-ascii?Q?B9Eu5iWN+cSIPKthLq4JkaagWTwMKltpCYsK2nxTHIKu9Yvu8EoD03riFuEP?=
 =?us-ascii?Q?Cf7LExfrYUa3X7y0YnTHSsJKSu+r/b8Fw6xLPpd8WPvZN/dvMWVIEntilBqL?=
 =?us-ascii?Q?TXbKP8ZN8IhkllkXKgb/lOCKMtsx+MDHRbhjt3tigmDIL4uULAqOaQA0v7dJ?=
 =?us-ascii?Q?7euDpy6kBasiMDpmtMUs+szzkBfRHQL7mcfa/YK9u4CvAh5Eyoz8fp9pSSzI?=
 =?us-ascii?Q?ylE2fvIRR0WQgeX7otYL9SkDWPJq8uBZNbu6wc1jgfOWQuwE80P1kWhnLRCZ?=
 =?us-ascii?Q?4xZX70bn/wiiwcnOxQOr/7lTnR5x3QClsXnFih/L5mReHjFJtFnv11XnY+fY?=
 =?us-ascii?Q?NSgiZGbqeKBrE51UMYr9DJuwf5uAAVetDch/qLc6e+9XIIS4GtVUZW4+DOZB?=
 =?us-ascii?Q?EZJfoqhVf6y52JUCgGBMthoBYbPw9psUzmAPYWJGrVh8MRF41KbMOl1GVNAw?=
 =?us-ascii?Q?QhF+9b170zP0uTdSEybhsbGC/ncnytk2q91smGHF0pstBzJDGiZ4wu3Z2AYU?=
 =?us-ascii?Q?mb8dX97QibIGsLjxQlt5jXoEc466Sz40BcGo4f9+bSwt4xfqZ3rZMM9wKko2?=
 =?us-ascii?Q?b6VpgwMNroG8qfnZp8bvLSgmbCpXMSo3JksbqU9iqahC7bHboidW9vKPSlBL?=
 =?us-ascii?Q?HW4yFbm1DfGm9vePS2aNIyJeNPw/VB7GY9CyXmGVpJXK7wOJBrgtDmPjwgBA?=
 =?us-ascii?Q?2BLQjiir+qV+n0MaJJTibYgojgM6DBn+DBjigkaHBCYCNwCVqzVefdUYa+Me?=
 =?us-ascii?Q?DbiK7FCeoFOK2AVrdvhH5XeJ+UJzaB2lBhGnr2F+BzAGbuw+sQ39a2HWkj8s?=
 =?us-ascii?Q?XojHxAOO87XkpyRSF+Kuv1f8oKuI5tzXO4asF9f2JRPEKDGWRu+RhSRlJq5V?=
 =?us-ascii?Q?Xd5OpQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(7416014)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 20:27:18.2675 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4af8f3-9b8a-4e1b-8334-08de59f4a38f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF7A6EE32B1
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=nicolinc@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
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

On Wed, Jan 21, 2026 at 05:52:38PM +0000, Shameer Kolothum wrote:
> The get_pasid_info callback retrieves PASID capability information
> when the HostIOMMUDevice backend supports it. Currently, only the
> Linux IOMMUFD backend provides this information.
> 
> This will be used by a subsequent patch to synthesize a PASID
> capability for vfio-pci devices behind a vIOMMU that supports PASID.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
 
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

