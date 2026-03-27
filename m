Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BBC10F286F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 20:53:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6EAJ-0005GE-2y; Fri, 27 Mar 2026 16:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1w6EAH-0005Fz-TD; Fri, 27 Mar 2026 16:52:21 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1w6EAG-00034t-FV; Fri, 27 Mar 2026 16:52:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjllrLbquPTNjuB8s+PYN54yr5/3H2RuWjmbpJ4F3pA25NO6kB/bCFzGQCI52o01Y/3n9dLtDVvIdhiwOmYv+h5jpk5QCXrpFTAYuS5ldNDgsG7DfNb96MSUfRVad/cSTy9Nku06dZfl8NhthkUeJBsm+kMmaX8md2NxjTnw1Ab01MfhaAhsS7sWpUeJeajTKn7TWYz9rvRysVVUMo2udWWfJGpu/qZnzRRulDyLVPZrolB8x0PZjQEEM5s340GodI7kILDjXry/Y7cC5cx1HQXPBValVxfRBXDHBEZMiJgvldvRlr5GYuVJMC9kZ8NiK8Hnp8qpQq4gmYlU6odGcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/+P8ZpzDyuvj8HPn+7aseuFbYhZ+ZRc5oszUlvwI+0=;
 b=Nyr1UuAeBfdm+J2l9hLLfmNlu87ZTMzuChyUUyPiSccRzQgoSx7SA1K09RxAodv2DqfjLMz6PqYnpzlvyn/W1oQSP4Bw1ccOP/x8v4QBjyldKBRGPMOw8ZfD4Q8nL5fNJUYZoCVFaXHAXTIT0FDy77WzoubLTLP36D/DBSdyaOzzPs/thw+VxwgUHVhxOq77f7Xrk+kk8E8p9ExeAD3BBUOem3NziDZXcSmtJNwCdvLhNViUFUE5CfvZYlGl3rlxMA4xgj6i7CyHgMWrw9CqPvgtKRLdJog+7mXMtE2Rgh615ZOEekxWQanv81nmx5MxLWlhGEiNry4NEak7Yg9tyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/+P8ZpzDyuvj8HPn+7aseuFbYhZ+ZRc5oszUlvwI+0=;
 b=ntazmXVCRtKf+UGPc3cuJnwCs/vwtsEfc/itGRl88VPajV9BG8G5Gyv1l+OW5TBxCox5JLvdAgUHrz7+Ehnq4q2xzThe/i3wAkBa+eZP2QggGsSegoCXm+wmRTUb0SAXe+HHGH2VJIr8IF+b3FtMvncDvCCyR2uc8tGVEJ3mKhOz5jvaAnaEhGd81wiWr3Kr0N+E5f9fxHEA94QIR8hE52ps+bkC/U7RpO5D8IEBjxVRReApU8hbqmzRcSYf2/Xv7ni7lBjZC2Fh3WXaubEm42hlHpbjmeUXBaXuTN2DZFwrcMgLZkg/oJon3FwFGvY1P+vAY7lkCQKMEJrhwA/CIw==
Received: from CH0PR13CA0004.namprd13.prod.outlook.com (2603:10b6:610:b1::9)
 by SA3PR12MB9199.namprd12.prod.outlook.com (2603:10b6:806:398::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 20:52:13 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::a) by CH0PR13CA0004.outlook.office365.com
 (2603:10b6:610:b1::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.23 via Frontend Transport; Fri,
 27 Mar 2026 20:52:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 20:52:13 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Mar
 2026 13:52:06 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Mar
 2026 13:52:05 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 27 Mar 2026 13:52:00 -0700
Date: Fri, 27 Mar 2026 13:52:00 -0700
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
CC: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alex@shazbot.org" <alex@shazbot.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "skolothumtho@nvidia.com"
 <skolothumtho@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@bull.com"
 <clement.mathieu--drif@bull.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, 
 Yi L" <yi.l.liu@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: Re: [PATCH v2 02/14] iommufd: Extend attach/detach_hwpt callbacks to
 support pasid
Message-ID: <acbt8FaZwzDaXtmT@nvidia.com>
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
 <20260326091130.321483-3-zhenzhong.duan@intel.com>
 <acWwwzfNEzBg4n96@nvidia.com>
 <IA3PR11MB9136FC71017C3B05CE3C881D9257A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <acX9/RjKaO0bBI/d@nvidia.com>
 <IA3PR11MB9136D9DAD0B8698841CEF4429257A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <e97aec85-c9f0-449c-99e9-bc4b4f2d33d8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e97aec85-c9f0-449c-99e9-bc4b4f2d33d8@redhat.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|SA3PR12MB9199:EE_
X-MS-Office365-Filtering-Correlation-Id: 117f108f-8c36-49ff-3dd7-08de8c42b8ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|1800799024|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 8Ze/qkRz52dbVFhZPW3Gh7o2aJ8/YckV/Bxx/ZPEwzKgGrenZy1ZYX+pDZz42lFEPNB5QjJu/A450JiYDC1vcIeG/CHO39iwXfX9+TfB3iMFOIwH8VS7FTtI/FCZ741EyYsfj0kgajITNEY0fcG40YAHXBmPrnfFnEnU8mzta4XVoWntTE8n4yLR+f/upEgmzSY/SUB1MRDYvFxkOzYJ7g9CzcNhrDg3x3FcLMKCjScrlON7/PbQH8B5cWHoF9xK0HcDBYyC+Ehs+IoF6+Pq8lLHLt3yOypXO8ZzExlrR0PmZ+cJDn/W7Ru/N7FM5MI5lZAx0MKArsb4Oqh5X/H3gPtEOZ5YAO/gPMyAUXxzQTXejvPqEVwwZ4Nwdqq09rsEvaMUMxwXJ7hG4M1euvlxdTTF+2vwpMpDGHEuwtDcj1Pyc9gR4wRL0X/LOBaoywjGApexT9PlhA4Fb9NnQYXz7JB9jL/D1qxOVlxvFXWZa2zo8C3Xd7XmZ0IqKatJ/XzMHZleuHuRxUeH1wkua2f1LSkcTWJs/1Tfks0RMNprtBQEZLBO0uwmIzdEaTBVCVKZ5NFcby5Ji8HfewX9ROSB2+gL1jci5FAwq4loPRWD+/bCQmN7m9R9puCzUR899Jtkrdj0KaRv1G4zs6IaNdBA7s5WeCAMHDEp+kZRtQg2HF0LGIXJFgcWeskptbgM0xAam03oh7NPkJtMW7XxVC9K2PT2d8l2ISFWVNQDyU+6P+t1LvefrzHdGV6AzMpFfM/tzQGCJ22nfmbGE8tHw/KI8g==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7gwRlp+pgPk7xLo2ZFS+MzkIwaARiQf+vLrKpi95cYO/Rf/cB2Zsb3V4NtoM5ovOyKtcEDMM+4RR3eoUcULy82WNzqMuze65+hi1fjtaaChkIuwnE3qT7svi7GqK8sPgYVj/4i4Vmjk95/e0WKmopU1APSD3AirGuragoC6gIEklQpeXfefbYNpz0JixhsJWobEAq9e4sD8BK1azKraSnBfKPNotgARAU/m1d+iBYZK1zc4b7FoShOfoB9jJ+nrk3jOxcBnDfznS1jkhLg2EaaG5qzILV3YCkfc/bTkXGahFzgWGMGl/0Cm0WlbnIpLetElZ8WxBnNigpBulicSGEC1ehuSq20qYXOLoaQxH4uOLj12r4ay3cdAf2kok2JEDiZd08ey+A9ofDna7M5G1USOU0QURFQHnhLsGxpGpba6gY5d/ZV7adXAHbhOsZt0v
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 20:52:13.1113 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 117f108f-8c36-49ff-3dd7-08de8c42b8ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9199
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=nicolinc@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Reply-to:  Nicolin Chen <nicolinc@nvidia.com>
From:  Nicolin Chen via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Mar 27, 2026 at 10:34:01AM +0100, Cédric Le Goater wrote:
> On 3/27/26 07:44, Duan, Zhenzhong wrote:
> > 
> > 
> > > -----Original Message-----
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Subject: Re: [PATCH v2 02/14] iommufd: Extend attach/detach_hwpt callbacks to
> > > support pasid
> > > 
> > > On Fri, Mar 27, 2026 at 02:32:57AM +0000, Duan, Zhenzhong wrote:
> > > > > -----Original Message-----
> > > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > > Subject: Re: [PATCH v2 02/14] iommufd: Extend attach/detach_hwpt callbacks
> > > to
> > > > > support pasid
> > > > > 
> > > > > On Thu, Mar 26, 2026 at 05:11:16AM -0400, Zhenzhong Duan wrote:
> > > > > > @@ -138,14 +138,16 @@ struct HostIOMMUDeviceIOMMUFDClass {
> > > > > >        *
> > > > > >        * @idev: host IOMMU device backed by IOMMUFD backend.
> > > > > 
> > > > > Not commenting against this patch, but I just found the "host IOMMU
> > > > > device" and the "HostIOMMUDeviceIOMMUFD" a bit ambiguous. It's not
> > > > > an "IOMMU device" right? Perhaps somebody can help me understand :)
> > > > 
> > > > A host device under host IOMMU?
> > > 
> > > "host device" would make sense, not "host IOMMU device", right?
> > 
> > We want to emphasize that it's a "host device" backed by "host IOMMU",
> > "host device" is not enough, I think.
> Yes. These are related to the Host IOMMU device backends :
> 
>   - VFIO IOMMU Type1, a.k.a legacy backend
>   - IOMMUFD,
> 
> There are other implementations. VFIO IOMMU Type1 is versioned and
> a ppc flavor exists.

But the @idev here is a passthrough device (VFIO/PCI)?

"IOMMU device" would be SMMU, VT-d...

Especially we are adding @pasid parameter. Relating it to SMMU or
VT-d sounds weird.

Nicolin

