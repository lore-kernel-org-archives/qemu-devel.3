Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCEDEE4997
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 18:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaeMh-0003eh-92; Tue, 30 Dec 2025 13:22:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vaeMb-0003cW-MV; Tue, 30 Dec 2025 13:22:33 -0500
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vaeMX-0007Ew-Ue; Tue, 30 Dec 2025 13:22:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4xK0dN85jmKvL8tbRApH9J4p1jJgmZiMfoH9QzzQPhSyJe5ief4f5lLjbJ+/WH/3ewAksi4lMQyVN1PlWsVqbmFxIRbLiHmDQtQZQfxYIFuNB6YCUgZy9q793ygcZ8QZ1S8WjDoRmWS+Lqlnsd7atSe/6dTwps5Aoc40cWtDyl9fR+s2dPpVoRw6jwXnQBmzfphuX/PqK8Qi+r9v1Db2l5zPPgHfG3aChZyT1hxsuNb79GcgcP8ggNEuGYV2Zji0acDl9Y/H/Uq+Pawyg6r+ywiqjzbEVunhmmoeN6CwPiDtx6x4Q1heHSCGTX2XY6Tt1vZ7JWDJzAfF4SQ4yILxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcuG5woYQxw2VdjQvFaWCrtIcgGK8927nsrFfIQHW3g=;
 b=iUpM70n0DBHbhOeUzAVqMHC4kSTge8oykzKYRhWZnFhPO3kI43gVZJouqgIEwrFQy4A5k5OFjAMg1O0uoOlbRO8/Y9pvupeon1Eq/HFMCJDF6GmKQCcfP2p9OlV2kK/EePFf4g5sH3JEHVoRXpNAjsfj3Nh1H0T/25KUrp9LUkic2O/qr6EyA9ql6VYoORZPt1ZvuHLuwS9yAUrhtz8s7b8obuQ0/zCMMXyPMc41XoZXC+cvSWYR1kCnfvvuhSBna1vG0u0OdQj5TzM2XTOIcaYdjJTpQMX8Ev8WyqjrHuBfO6yy+fbItMffZc7O3uVdGRoVRQLUmayum3PeuX07NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcuG5woYQxw2VdjQvFaWCrtIcgGK8927nsrFfIQHW3g=;
 b=KMvI2ZbDLCk0cPmpiX3nVo/LrMOzXMUckV0OqJH/jbk7LyOEmC2+5BrZSOQ8dFzvsphLRl3ncFoW5ttY6zmYczxltJPAIB4rxd//Ve10se4D0FSJ6WgWV4SyUW4qxH03X3qXSqCtS6DIhwZHsaXRnDH/g0/EucU42Kvy1tHY7VWzalHyE5IOzOSONfQpTl1H+cvI5zRy1o2fUnWbjpcwCqa3RL563OIQnHBTti3rO2WQijK/DXXWKNKsiGcoANevJeGhFuJ2eRK3BkvJJEQU4tLICyYU71jSF4HjtGkckZ6xZ1CNfa3PypCwb5v2c3pZ2w3dPiRN/kV84VAdYxGUrg==
Received: from BN9PR03CA0148.namprd03.prod.outlook.com (2603:10b6:408:fe::33)
 by MW6PR12MB7069.namprd12.prod.outlook.com (2603:10b6:303:238::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.12; Tue, 30 Dec
 2025 18:22:23 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:fe:cafe::61) by BN9PR03CA0148.outlook.office365.com
 (2603:10b6:408:fe::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Tue,
 30 Dec 2025 18:22:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Tue, 30 Dec 2025 18:22:22 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 30 Dec
 2025 10:22:13 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 30 Dec 2025 10:22:12 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 30 Dec 2025 10:22:12 -0800
Date: Tue, 30 Dec 2025 10:22:10 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: Re: [RFC PATCH 10/16] hw/arm/tegra241-cmdqv: Allocate vEVENTQ object
Message-ID: <aVQYUgXv/ZzTEpaz@Asurada-Nvidia>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <20251210133737.78257-11-skolothumtho@nvidia.com>
 <aVLbS6g+Sd6vfaFc@Asurada-Nvidia>
 <CH3PR12MB754807EAC29B50A82B3B84E3ABBCA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aVQRuUkeBroWIAHU@Asurada-Nvidia>
 <CH3PR12MB754883CF90FB349D4CCD2126ABBCA@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CH3PR12MB754883CF90FB349D4CCD2126ABBCA@CH3PR12MB7548.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|MW6PR12MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: 791876bf-529a-416c-0edc-08de47d06051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?phyA5o0JIZf6HLYEq+LktuXHA+lWlk96MdST/nXOFBIztUORGquaayr+Cw3e?=
 =?us-ascii?Q?4BGkA7UiLfGdpqigBJYHSKSnI+M0sKgogiwvbnPFO/oH10pIVCHt7KW+HIDS?=
 =?us-ascii?Q?6dR9yS09a7QScV5AEaVkrbF+Yv5v80mBvylyAD4F14jY/LmgBeLHSwjfg4l9?=
 =?us-ascii?Q?elWc+Jtg0ZKubgn8y57gTRTiimv1i7phAujoyg1YxNbXMe9Cw8w0I5eGq84V?=
 =?us-ascii?Q?KaJxjNcmNZIB37O7b6keq4W+7rNunty2c02VcBHokdtegs49esqpRliyhgFY?=
 =?us-ascii?Q?3uL/9xYDV+s67SbDrF3Dtr+oFxLtKfsFxkSXbAdThY3rNqO6Owq4ep7LgBBU?=
 =?us-ascii?Q?GPnDiPyWSwy8QVKSD9588Lj/uLihZf/QHNOuUx8+eRshnjSiC5D5tuphxd/f?=
 =?us-ascii?Q?k6c2sqHbMjtBQzklcRPK6rmYiBXsimg1NEiolRVav3i/P7uQn4000TAMPJSj?=
 =?us-ascii?Q?nHHInIcR2jtJ2FLHB/+3gGMtAKrNtbcWoeNIP9dwztkdMXm9MzaoGhIFkfJx?=
 =?us-ascii?Q?9G6M3FE/7zkwfPsQFeG98rK7D+lAimHqaawoDhYdtNOBcB4wPlCcKqIIUe17?=
 =?us-ascii?Q?29pmsNyINIAYa2175xEquwZX9pu0FhN3Meuvxfz3P7QFOOK9Jsm4IQJfwIW6?=
 =?us-ascii?Q?QzgJXyVqT1zfIMahqGFat5i6xLe7En7R6mn2k18S/NSIjAfRFZXbWXTlAUqy?=
 =?us-ascii?Q?GfrA0bWXumDFglreHmKWPqFjEzju77CKWGB3Uuy+/6psp//YCLfjcM3LxXL0?=
 =?us-ascii?Q?YzERxaMsA9prVruQxFwpidqV3eQ6n8zlokujRJOY85icV2tf6jI1WCg8PYfz?=
 =?us-ascii?Q?PaXdV96hsH7GtXuQftMDcWzwm/6CF1HTvxU7fO2SQ4JgwHxP7MdDwK8m3e+o?=
 =?us-ascii?Q?LIDrK6M5S4N9m0GtONiNusHGcl9X/sFm6ZVWkv9vleuaLnA0ufr7HKZQiuJk?=
 =?us-ascii?Q?8Ys3rezw3JmRX9H9qncE5OLoB8DB3xXsK0zd7jG4xL6A4YABHiU04jT6UDK8?=
 =?us-ascii?Q?ue3sGqJAd/5ygg8wN/QYbGBif01LFT8ShvgT8SWfFgh0j/nmXp1EtxvJ7fXp?=
 =?us-ascii?Q?qMEZl9t+sGEKmL5QOat/bK+3u7q6qRcgnykaSoC2lZC0U3Me5z8vOsvbQ231?=
 =?us-ascii?Q?dnHyY/ZJIICJxSLtmxfyLgH8DySNcH2pv8Q0iW4G3Y1Y7Hdkwr1hrP4iiS5+?=
 =?us-ascii?Q?i5wP4CwyZR211YjzDTUTuf8I/UX8d9BX4My4eoHF8SEn6uCoTzz/XgeZGZEQ?=
 =?us-ascii?Q?msCv2zO5X2InIo0Iyxf8ZA0ONbskeUDb6ajuBnm3eBxQZZvnsAx8bSEEImV5?=
 =?us-ascii?Q?RvG+3qM56p+R2RWefRitFpRdfhHTFuvw2nuNZq8sHPwaL59/DxyHx6Gpxljc?=
 =?us-ascii?Q?Ccs9n3Cm5+iq2uMXmG2by0hXrS17lLvfg7b7VCxJPcpYkAZyy20yTHB/tAhz?=
 =?us-ascii?Q?UlTahgR/VFU9KmIrSpxy05m+p8EVSDyC08I44h//3oylnafLGK63HlmLQNMC?=
 =?us-ascii?Q?pnyUWx351DsH9k1Hd69KQCWIye2DPF38bVljLH5cVGWq++l+nH6dzSgzYUAZ?=
 =?us-ascii?Q?W1UB6ikmhaPuGSEMeZ0=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2025 18:22:22.6194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 791876bf-529a-416c-0edc-08de47d06051
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7069
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=nicolinc@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Tue, Dec 30, 2025 at 10:10:48AM -0800, Shameer Kolothum wrote:
> > > > On Wed, Dec 10, 2025 at 01:37:31PM +0000, Shameer Kolothum wrote:
> > > > > @@ -259,11 +305,16 @@ static bool
> > > > tegra241_cmdqv_setup_vcmdq(Tegra241CMDQV *cmdqv, int index,
> > > > >          g_free(vcmdq);
> > > > >      }
> > > > >
> > > > > +    if (!tegra241_cmdqv_alloc_veventq(cmdqv, errp)) {
> > > > > +        return false;
> > > > > +    }
> > > > > +
> > > >
> > > > I think this should be called in tegra241_cmdqv_alloc_viommu().
> > >
> > > Should/Can we? _alloc_viommu() will happen before the Guest boot.
> > 
> > I think we can. vEVENTQ only needs vIOMMU ID. It's per VINTF v.s.
> > per VCMDQ (HW_QUEUE). So, it should follow vIOMMU.
> > 
> > Basically, we can allocate vIOMMU (VINTF) and its vEVENTQ even if
> > the VINTF doesn't contain any LVCMDQs, which are allocated/mapped
> > to the VINTF later via HW_QUEUE allocations.
> 
> But what happens when you receive an event from host during that time?
> Should we just ignore it? Or is that not possible at all from a hoist driver
> perspective? To me, it looks like the natural flow is setup vEVENTQ when
> Guest is ready to receive the events.

I don't think that will happen. The IRQ register for VINTF/vIOMMU
is LVCMDQ_ERR_MAP. If there is no HW_QUEUE allocated to the VINTF,
there shouldn't be a vEVENT. Otherwise, it would be a kernel bug,
IMHO.

> > > Unlike the SMMUv3 vEVENTQ for accel case, we restrict the hotplug
> > > use case when the tegra214-cmdqv is set. And as soon as Guest setup
> > vCMDQ
> > > the vEVENTQ is enabled here. Do you see any issues with this approach?
> > 
> > Once guest OS is booting, !tegra241_cmdqv_alloc_veventq will fail
> > tegra241_cmdqv_setup_vcmdq while it cannot break the guest OS any
> > more. Then, the whole thing wouldn't work although guest OS runs?
> 
> If vEVENTQ is mandatory we could exit the Guest with a proper msg in
> case tegra241_cmdqv_alloc_veventq() fails, right?

I don't know. But that doesn't sound right to me. In my mind, once
the guest OS is booting, it could only stop with something like a
blue screen..

Maybe QEMU experts can shed some light here.

Nicolin

