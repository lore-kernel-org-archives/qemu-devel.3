Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6EECFD356
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 20:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNcrf-000609-Kk; Mon, 24 Nov 2025 15:08:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vNcre-0005zo-7s; Mon, 24 Nov 2025 15:08:46 -0500
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vNcrc-00065A-9k; Mon, 24 Nov 2025 15:08:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QycrrzDhzHMxvNoGgucn3pVduVFMPpUiyDYfCEcyCfpvLUGzh8BGxZ01bAECUM+8XowiqCGu5PCYwqHWe5dWaUaAHgEotE+eFMUPIe/JudJuEZe8qksuSimBS/GdNNAcM+CahKIUiyaBqwj89VV1N5jkMDmJnHumjynP633XD8QJHOoVQIsBLb+4f+lxVa8dGnDb9+iDUWLdTn25ZOcy7aC1SQvuDDrPVg50L3JbEs+8M1FvlVNXEOcLp3wOYpL2uzDipu0fuByv9hsbJmnPCyUrapvHf/mcIFQnJgL6I/VTGx5kmNX6oU3lYdTxOXaQRixzlQsHCi41k4iAaZgaWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYw0kg8ZNKon+Pzkn/3b0Vhq6v2BxXSAByX3jM237CE=;
 b=FGP5+ywB7LUmhoX0zchDWPud6ZU6UI7bc5b+jH2gEJep+FRzyPiQ0HL8gHPNk1TJzJoJMuPo4rX3Yp7fVW0Hi9A8oAnpqA23sjGMIv0GYuu3y786vPtYLvYTZdsrMiMpW9CJpuDoh4g39W44dObG8m+JgQ8gXB2U1/1q/4OuGPmA9cNuDYy1mGCI43LDdpE90+rafssx4QmtiTxj3muROPVYnUicKXPiQSyITEWI7T8usHCyBzObdl9/UMie7MfzAhQ0dNMKlaHuWicqc2PbW1oKMslSAcehjVtqD6sxm4X47vMVL+imhbNgFoENB2u7w60f0ekf177b9eN0ZJQH6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYw0kg8ZNKon+Pzkn/3b0Vhq6v2BxXSAByX3jM237CE=;
 b=umuFPjv9bLNe1Bv51LwfKAdEi7XlnTzWIzCrnjenG5L7UGmB5wHV2EScwt9fJ4I4eSgZvRG9juuBXFgLMRCUcmpCRR9pJNrNxPQzm9lxqJkQlNFOkA/ZnwVe1M2sp2oFkZ7sbX9ZDHFaGHq1Zo0ffXGj8bncOHc3CrvpUdhbhzwZC1pnwTW9wdHxrgBX0y9Y1qPaUd5Z0qGVAFzkp836nmjy4PRA+lD/RlnBbtIVcKwy1EgtVCft3x6ZUS1yA2hWMLpoODjjOGMX6HE2KUqGOGPWMXJj3jM3wea2LZMbhF/lbXpfgVNotrnVKTF+hbopy4g3n4uUP064T0Y47dXwPg==
Received: from MW4PR02CA0026.namprd02.prod.outlook.com (2603:10b6:303:16d::25)
 by DM4PR12MB6063.namprd12.prod.outlook.com (2603:10b6:8:b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 20:08:38 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:303:16d:cafe::62) by MW4PR02CA0026.outlook.office365.com
 (2603:10b6:303:16d::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 20:08:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 20:08:38 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 12:08:24 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 24 Nov 2025 12:08:24 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 24 Nov 2025 12:08:23 -0800
Date: Mon, 24 Nov 2025 12:08:21 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: Re: [PATCH v6 17/33] hw/arm/smmuv3: Add support for providing a
 direct MSI doorbell GPA
Message-ID: <aSS7Nbe+JpM1tJxQ@Asurada-Nvidia>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-18-skolothumtho@nvidia.com>
 <aR+Ga0DrveuOd3v7@Asurada-Nvidia>
 <CH3PR12MB754869BFD4D1B5C65EE30AB8ABD5A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aSCnyrcIe7kqIncW@Asurada-Nvidia>
 <CH3PR12MB7548BCF00E128545097E3DE4ABD0A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aSSlJukXV0C48pFX@Asurada-Nvidia>
 <CH3PR12MB754878079B614319CC6FB9C0ABD0A@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CH3PR12MB754878079B614319CC6FB9C0ABD0A@CH3PR12MB7548.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|DM4PR12MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: 14fd84e7-54b3-4735-d6d6-08de2b954185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|7416014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TxOowBUppodp5W/kNjaBygz387zydNanCB8nheqTfo/7WLx7EUK1Tcqn4fQu?=
 =?us-ascii?Q?O6dm5p93EKsFbY4kzRHhUbDOj8zvLL/48Jrv0DMl1DfVjeAtqajWXG5PXv0s?=
 =?us-ascii?Q?5vnz9T63ooK3kkcq+FfwUjOVrzIJWkgqomtmZGaDmVt+rqlFqbYy2+VbzMZo?=
 =?us-ascii?Q?P5dFFnhCp1g2N3I5rBu02pvYJqnO12afU/+2+0k5JGy9SEj4xYcSWoC+DGS4?=
 =?us-ascii?Q?BwkpMYjr1pjkoPoEOqFec5IoMz7rB8Rv8OOy45vkD4odC41LyFaVrXD9o+Ka?=
 =?us-ascii?Q?bgNPReZeuTTqbSonUlhmLBWGkCe10IsytvF7+xjdnR59/+EpD14fXOO71xfC?=
 =?us-ascii?Q?Axlm4oXcj4WUJWW9xXS35AFHvgQESjuV15o0qHP3ttKAVY3b9VpC68dWKRe5?=
 =?us-ascii?Q?f2yRjtiuB/ibuHEoBpY4ypi4mnIwpn2zLzm3XLfHqAw4Ttkbqe5DdUGGxUWR?=
 =?us-ascii?Q?IUHr+ZiJBxWJSSO/0q+xjHm001hEKh+0ddpEdYjOQt1jDzOZbFEEx13pIQEp?=
 =?us-ascii?Q?KBKSe7jrH9qvkRBkKknKgUIH347qDmdRbtAO+n/22xjlCw+cyjWfx1qHmVYD?=
 =?us-ascii?Q?gW1YlRdpZGN+BfRjgRrMcz4Yeio4XZtDI7hx68q06tndzutD9sPRKzeR9g6Y?=
 =?us-ascii?Q?OgOf5yu3hNQSBgLN/hpcLgh/gVCpRC+8RbOn6BQ33Mc8YBwQO2KMk91Ka3x7?=
 =?us-ascii?Q?hnaT0GBSaJdebOh9/hiHEepbfXxjsnyZd2Ey+o/1BXCmZvQipMZAHGMb619X?=
 =?us-ascii?Q?aESKK7UFzOEwd9JynPLj3J54Flg23ee2LX1VrJ1y3tXHa/gn3GSRbhUd0065?=
 =?us-ascii?Q?up6eJohhi7PfsWN9BZ7mZaqByOEwB5/HnBw3LK+5FG8/geySQeW9QT/CEkyv?=
 =?us-ascii?Q?xtBHAcIz8kuALeFPH38e7xyD3YiD3nLEBw0XqIuahKToeu4k+dPclo8omgNm?=
 =?us-ascii?Q?7MdcuAM79eoweK+Yz6yqIpJmY5RL59iAE7z+pgP4ATHbp3uOzivOVrcfIgoa?=
 =?us-ascii?Q?y3NloCRefQM2ccpV8T56CdsWzZJUW3bDngvx6fAhaA4OAOWiXAbJlA9DLojv?=
 =?us-ascii?Q?UAqBFADTEoywuyjQ+qVM89x+TWvGQWQl1HEisjjN5HbISNCzXXMI3m5EmDTm?=
 =?us-ascii?Q?YuUNOs6l8Ln0W3KHCrblXE0A4hFiRGWd29WIUWsCEoWa8qBDFVdcAvaryJ2j?=
 =?us-ascii?Q?0tegH1CtFXXLn5xqqsVzYclBCGjv0pQ/vx6z9Wyk3Hgcxgn0SwCc5xeuNGr6?=
 =?us-ascii?Q?Z9X1Op2yRQ/vfFHogvc/H/GRnjOO1eT7Nt7gCa3kJS0YVmdOnTtiyvByuvqB?=
 =?us-ascii?Q?a6L4M4iq2MQIkeS6rjale8tV7rtPt7fDy7IsiqKACmLdX+DJZSErtyz/N7tZ?=
 =?us-ascii?Q?tQBJ7eI8OuORer9vXv0jWK+fABbqANY1crEHyYKFRwiQSQNcFoah/2F3960I?=
 =?us-ascii?Q?XV4vLqoKsHNbdOSo+oxasYC49UFRfBxzyOe4VPwM7UKIgPdMf2J/YjydAWPP?=
 =?us-ascii?Q?TrmO6yhFvBdHnLzRbHJnp+Ji+pmWFKgDmwSDYsNHK3P0n8oBBfool5oaOvwd?=
 =?us-ascii?Q?z2znH26aaS7tFuoHDUg=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 20:08:38.2314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14fd84e7-54b3-4735-d6d6-08de2b954185
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6063
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=nicolinc@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.075,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Mon, Nov 24, 2025 at 11:01:57AM -0800, Shameer Kolothum wrote:
> > On Mon, Nov 24, 2025 at 12:05:38AM -0800, Shameer Kolothum wrote:
> > > > > > > +        if (object_property_find(OBJECT(dev), "accel") &&
> > > > > > > +            object_property_get_bool(OBJECT(dev), "accel",
> > &error_abort)) {
> > > > > >
> > > > > > Do we need object_property_find()? A later patch seems to drop it.
> > > > > > Perhaps we shouldn't add it in the first place?
> > > > >
> > > > > We need that at this stage as we haven't added the "accel" property yet
> > > > > and that will cause "make check" tests to fail without that.
> > > > >
> > > > > We remove it once we introduce "accel" property later.
> > > >
> > > > Hmm, I assume object_property_get_bool() would return false when
> > > > "accel" is not available yet? No?
> > >
> > > It is the errp that will be set if there is no "accel" is available that will fail the
> > > tests. Another way to avoid object_property_find() is to pass NULL for errp
> > in
> > > object_property_get_bool(), but I think again when we introduce "accel" we
> > have
> > > change that into either errp/error_abort here.
> > >
> > > I am not sure there is any other way to handle this.
> > 
> > This path is to set MSI GPA, which could be optional, right? So,
> > we don't really need to exit when accel is not found or accel is
> > set to "n".
> > 
> > In that case, could we just use NULL even when "accel" is added?
> > Why do we use error_abort or errp?
> 
> I cant recollect why I used error_abort here in the first place. May be
> since we used that for the "primary-bus" above. But as you said,
> we could argue "accel" is optional property. However, if we pass NULL
> and then for some other reason it fails(even if accel=on),
> we will end up ignoring the error completely and silently boot without
> "accel" ?

OK. I see now..

What we want are:
1) When "accel" isn't defined, don't abort it by calling that
   object_property_find() to make msi-gpa optional.
2) When "accel" is defined, remove the object_property_find()
   because object_property_get_bool() will never abort. And it
   will make the msi-gpa optional depending on accel=on/off.

Perhaps we should re-organize the patch sequence, putting the
MSI one later. Checking the "accel" before we introduce it is
a bit odd. But any way, I think we are fine here, if you don't
want to change.

Thanks
Nicolin

