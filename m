Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65240C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg8oH-0001MB-Lh; Thu, 06 Feb 2025 15:49:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tg8oF-0001LV-8Y; Thu, 06 Feb 2025 15:49:15 -0500
Received: from mail-co1nam11on20620.outbound.protection.outlook.com
 ([2a01:111:f403:2416::620]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tg8oC-0004Nn-Je; Thu, 06 Feb 2025 15:49:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QpVF4JlHPWAA7Ef3omTYTe5hahcV9aYXXSkCdTUVFmpgsP+zZ6s1wymXtxHUznkIJGWpP1RgWdgcrF8HWBz1ScF0ixxTOSnXuR7frfwOjv9QZoCtnCSOyLmz3QaRAthlWjw8YHWUhciKtx+3lQ8T2E9HCHh4O7gdV1dvL/APALOaGZaVFVtJW1YEUSN4fgG+Q6meIhJwT4hC0rUlaFli7qUP/6irZ1p2MJkuj38gh1enD/EhYz2vXu+clH5Ph+b//VEI6MmXeBLZuEGnlQIKSZx/Ae45ssZgpaF7NiXRmo/+9EXIeiB12J3csMJpBmejoZTlv99w3vwlh5AJWBQuSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXJwW57LzaUDrD+4lkdFcdekX3oC8oAe8+SDZ1PTA80=;
 b=PF2B5okgMqlOxjRjIfcUQ8L4EpP1lYqy+Y6mr8zAjuxSJjbuZGU5DkXeMfga/lnzqR11o2alHgrmx/gVHBKBzeTcis6B7zow92G/D33xY08qMm0bcNFfoilGLxooC/dXhbRVgpnH8vEgLPe8jwkDTmfjjRbEWvfkH6gQS7AouPNYDcwS5rx7ggVTLtvW3ehSn6H7yHhsLeBLvK8bGddX9S4O2/pGkOM/JRLKIjwEGzlQzUh1j2qD3mfhJJNwLgwZK5gDxLWPEY7bPukKtum4H+ZVNYBmOGYPKDCSg+sMJYHW4K8Ftau7/xMVxxzP+TdT+iWbvrEl6Jz5WfE6RRd9Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXJwW57LzaUDrD+4lkdFcdekX3oC8oAe8+SDZ1PTA80=;
 b=Wsfi5WUsM4mWJLj7hqbAFkvdlAksU3Vae4mletPxks+NccjmaRiMrV04IAUFFcK1ySNcs4z9oNWu0TPCQgqpiZprQguzn3cpRIJfyfuTdvzVK9tyws3rH8y8uPc5MJnRRxxsHKVfBGg1zVNSoigZok69U62p/jf4vAVKBQNKGIxkXfoHSghkyGpFIEdftiM2sKDZdz/kh46RY1RAW8cEppYhEBytMm8Y25EKHWTUgeNtaFj/pfuNDj7BDFCfxJP6iezF68dIAToV37iMUbhqCqmRZpduorFl3Pkus/S74EYPPNeZCXya7zfNHmLL8hoEB7MGw1TzjWrrpO2DMo6Z8g==
Received: from MW4PR04CA0295.namprd04.prod.outlook.com (2603:10b6:303:89::30)
 by PH0PR12MB7487.namprd12.prod.outlook.com (2603:10b6:510:1e9::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Thu, 6 Feb
 2025 20:49:04 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:303:89:cafe::b4) by MW4PR04CA0295.outlook.office365.com
 (2603:10b6:303:89::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.29 via Frontend Transport; Thu,
 6 Feb 2025 20:49:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Thu, 6 Feb 2025 20:49:02 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Feb 2025
 12:48:42 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 6 Feb
 2025 12:48:42 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 6 Feb 2025 12:48:41 -0800
Date: Thu, 6 Feb 2025 12:48:40 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Daniel
 =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "ddutile@redhat.com" <ddutile@redhat.com>,
 Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "nathanc@nvidia.com" <nathanc@nvidia.com>
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Message-ID: <Z6UgKHfGD34K3Rcs@Asurada-Nvidia>
References: <Z6TtCLQ35UI12T77@redhat.com> <20250206174647.GA3480821@nvidia.com>
 <Z6T3cX_fM-aeYbMI@redhat.com> <20250206175843.GI2960738@nvidia.com>
 <13b1d8b97a314cb28b87563fa9b45299@huawei.com>
 <20250206181306.GK2960738@nvidia.com>
 <02a0080a4a1642d69b7f5dd4707a5b3d@huawei.com>
 <20250206182201.GL2960738@nvidia.com>
 <Z6Ucj/u3wt9muakb@Asurada-Nvidia>
 <20250206203855.GM2960738@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250206203855.GM2960738@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|PH0PR12MB7487:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fcffaeb-d253-4ca4-6b3b-08dd46efb090
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0Njbu7mxXEFE2IIn81MbHb3O8OCWr9SttXe5iIISWFruww3OezeptW70Bs2c?=
 =?us-ascii?Q?k+R+GISXmh7cq4M66TF8oXHCirUidEv1+Y/DNsuczNpqXVYJJd3iO91zTNEL?=
 =?us-ascii?Q?Z1RFTYKgcqrC/LSp6w3yuEp+8DhtQMl9XdyVeeogZVw5vNHLv7/OgtchLo5S?=
 =?us-ascii?Q?LGbg/kNEMRHtiVX1Ma9yZaOA1xuEfnBfG/TUZzkHqibTw1Vi9mZhXLoPr/aa?=
 =?us-ascii?Q?Vit4i3n+ZJ//JPembDsOvz7mK7EQnhin7MjmNzRbTjQ5LVocfEUVHthIeops?=
 =?us-ascii?Q?VXlOdG5VzvwmGgHNhl8b1kMEqtxF4gx21U/ywAeZInVsMCkgg7fZZXVQiScg?=
 =?us-ascii?Q?IkHtRz1kgoRsjtfoCiIId5FP18pxaIi5ZfKIXquk7WN99VaVxJz8vn6U6Jx1?=
 =?us-ascii?Q?+fJ6tXq47OkGNPXQQs/SxEHgswD5FCyKUcyDqFXmyb0F/291LTcidapxP/69?=
 =?us-ascii?Q?AhYX/EM7bNCSQiSPg5Mcptuhj91lSZikpcBuk50vcodUG+6rFmExsLmiZVvR?=
 =?us-ascii?Q?tciqTIOKkc51qSv9aJ3FIcd22t+9og2iGI3cdhRB3dKqEnD1RQims1XiFTx+?=
 =?us-ascii?Q?VYzvJg3oOLEtlvvxLOp+OE1ppCucJt4Zsb/eMctfDVLa+SRjpN9vim6p2nXm?=
 =?us-ascii?Q?EyngVZS1S92b3mmT10dNg9Hpv6Tn75iMn5EPbniF6Q+oMEA1n43wBRk5DKia?=
 =?us-ascii?Q?UcaqoFuxZ10DttFmQRIDhVh/2v2c6h5fkSM6TaRMGYjG2ks+VhXVQ/9q8Rk5?=
 =?us-ascii?Q?TU+2O7jGNE+74qx9xTbv0oZjjq+kXaN9KctLPg/NHNqi817qpXt7GduUMd2s?=
 =?us-ascii?Q?kZLyjSoHps6MNKUh2o2c3emDDxtphIHHop6oIWzmMb1XH1fog8qWg6sp3N0V?=
 =?us-ascii?Q?eEGNGm0dhZ23eoVysveCZFsAKp9Maur4PWGwesdTsXjc/RHtlqH+4srZ3Nn4?=
 =?us-ascii?Q?h3SmKqBsbVeORlNFDwt40VAtXlUTv3XNFNiKAHzxV2xJFo+qS0936GU5t6JZ?=
 =?us-ascii?Q?VPoe9zgLe5vapZCav7l3yq4C2XiUMC1aZzuFUhoNoxTaEtiNN4Wg3OjwgHd/?=
 =?us-ascii?Q?5WPz8y0VHBmvXANP+WgVtTi25MJJLd9bh4ORqAtLWCUA1JIXA2DOEIhkqMJx?=
 =?us-ascii?Q?KynKQOS8TzwDL46zJrVrk1nKAxvSlCs3OT6e6+OghHu1i50mtCps9usa05fL?=
 =?us-ascii?Q?H64bLkN1eTyl/scGoro/7Hjn/HeZ8Etb7DyljFTJE4uAsshPJYc8FvhKw0m9?=
 =?us-ascii?Q?0flpLSetoL7yS9OHWZbrBmkyBzZdVEqwbgOwXPpxQITfaXqko7+ZYlylbrIh?=
 =?us-ascii?Q?nXOIIFwso7HNiHV6fQR+7T4lkWnESniv1ibWucMXO9qtEbrDQCaZ0KXTNx8/?=
 =?us-ascii?Q?eXIJWP/xBBAy8LPche9geaqgcDXpBHv+tUn8qJiopsrBo8SRN5ZMBnJFZxAS?=
 =?us-ascii?Q?t8MHi94wXOk6h1HXvGqvUd5+nlckZfpJU5ATseL/C3BZUTmjMapq3t3QzxBA?=
 =?us-ascii?Q?5/FFquYmukxf0T4=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 20:49:02.8923 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fcffaeb-d253-4ca4-6b3b-08dd46efb090
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7487
Received-SPF: softfail client-ip=2a01:111:f403:2416::620;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, Feb 06, 2025 at 04:38:55PM -0400, Jason Gunthorpe wrote:
> On Thu, Feb 06, 2025 at 12:33:19PM -0800, Nicolin Chen wrote:
> > On Thu, Feb 06, 2025 at 02:22:01PM -0400, Jason Gunthorpe wrote:
> > > On Thu, Feb 06, 2025 at 06:18:14PM +0000, Shameerali Kolothum Thodi wrote:
> > > 
> > > > > So even if you invent an iommu ID we cannot accept it as a handle to
> > > > > create viommu in iommufd.
> > > > 
> > > > Creating the vIOMMU only happens when the user does a  cold/hot plug of
> > > > a VFIO device. At that time Qemu checks whether the assigned id matches
> > > > with whatever the kernel tell it. 
> > > 
> > > This is not hard up until the guest is started. If you boot a guest
> > > without a backing viommu iommufd object then there will be some more
> > > complexities.
> > 
> > Yea, I imagined that things would be complicated with hotplugs..
> > 
> > On one hand, I got the part that we need some fixed link forehand
> > to ease migration/hotplugs.
> > 
> > On the other hand, all IOMMUFD ioctls need a VFIO device FD, which
> > brings the immediate attention that we cannot even decide vSMMU's
> > capabilities being reflected in its IDR/IIDR registers, without a
> > coldplug device
> 
> As Daniel was saying this all has to be specifiable on the command
> line.
> 
> IMHO if the vSMMU is not fully specified by the time the boot happens
> (either explicity via command line or implicitly by querying the live
> HW) then it qemu should fail.

Though that makes sense, that would assume we could only support
the case where a VM has at least one cold plug device per vSMMU?

Otherwise, even if we specify vSMMU to which pSMMU via a command
line, we can't get access to the pSMMU via IOMMU_GET_HW_INFO..

Thanks
Nicolin

