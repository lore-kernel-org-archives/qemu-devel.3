Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ABEFCAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 21:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Loq-0004JI-5r; Mon, 29 Sep 2025 17:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1v3Lon-0004J2-I4; Mon, 29 Sep 2025 17:54:01 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1v3Loi-00033Z-4J; Mon, 29 Sep 2025 17:54:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W5i+VqWbxjae6B+pR/VvxP8oAWXoClgqFiWs4LkJ+Uuhz+geuJVNJR7Cz+EWAZIUmSmz4nm2BHqFHICp6RADYPFWAx8hG4BPY+iUWiVkUhwabh0YcNikuxDASpASESn8X4LEuo4Y9xMVIBsDn1Y/h8Vj1nXSh6oXxiuPX8970ZTWQQJsIhUEJhDVu1e2AM7dTPJvrQa0KiwYAIBbR/B4cCYCgLaRlxTJtWTpUwjvoaj+dp4mwQJUEjlc1CzKV5wpnIZvUf0VI5QckmFqT/oimPJSWTKP+7rEKUYyuJ9dBvAjcEe4I+KJSpVeVTcpe+KG75KUaZ9j4LQ0IzloqDdCdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Clv/9u+5YNB68pMxyZwvHidhVmCEiHixRTJmxBBa2Q=;
 b=xAz/ffcIx7uy/HbiICXIxwdg3YWRmoDg6EYeKaUcj4Dlvn7Mb98ELSTVgAAyCtEeuC5FgryxycoJE0zGmRgGkKOFxZP7kShwPVb6ml7ua9m7Tt6a3SIAUYhPybNipkobbHTMN7KYx5WjPQmcUSZBriufP/EKJ/i8l5m2T+ZNVJKEoXSQksEe3V0knxg7JStugXCNZtKeEUujJz167bagwarDShbqSshbQEGAoZIdYiLSrO+uOLGg+Q9KU4TtrmgGGdcI7a/elBrPlzB9723o6A6Q61C76E8eU2s9NMktZBE/CFia5IFWnfCd4GT8fkVAZ/5MvYeLey3Dy58mBXNpzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Clv/9u+5YNB68pMxyZwvHidhVmCEiHixRTJmxBBa2Q=;
 b=t1msZidPuAEhDc2ComI3EArVGKukiOL1N3fNN3AQQ8qXCZQVInIvNa6i0NPQLNqkgivwvOCm5VrFvUmJMYhr7qrU4AwNaRLR1yZFz9T4sJi+7+QNO+zGlmG+g9g8RWAur8ji5y/ldDuX1sFp8aj9QoP8Nopi/cJa5pO35sFVTMn9LCCWyq/sfL2w9MemhfmbWE6E6y5s/hSP/3V0QR/6bvo5/FepMFaJl8YenfB0WzNNZi6ieQ5Qhw5E3Cow5gpQZyR6VYSfhSspkZSUn11L6zwcxiRehC7yR6prj+NKMW8k5iF4rafvI4s13pudNdTIXbyi+ICDA1VDBf/yDRv+Mw==
Received: from BL1PR13CA0190.namprd13.prod.outlook.com (2603:10b6:208:2be::15)
 by PH7PR12MB6489.namprd12.prod.outlook.com (2603:10b6:510:1f7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Mon, 29 Sep
 2025 21:53:45 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::41) by BL1PR13CA0190.outlook.office365.com
 (2603:10b6:208:2be::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.13 via Frontend Transport; Mon,
 29 Sep 2025 21:53:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 21:53:45 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Mon, 29 Sep
 2025 14:53:28 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Sep
 2025 14:53:27 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 29 Sep 2025 14:53:26 -0700
Date: Mon, 29 Sep 2025 14:53:25 -0700
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: Re: [PATCH v4 04/27] hw/arm/smmu-common:Make iommu ops part of
 SMMUState
Message-ID: <aNr/1fxA8pqGs7B0@Asurada-Nvidia>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-5-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250929133643.38961-5-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|PH7PR12MB6489:EE_
X-MS-Office365-Filtering-Correlation-Id: b1782880-f1cd-43fe-85e4-08ddffa2a9a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|7416014|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?50QJOE16V0L2n+sitSrNKjMw0IYu1lU1eQtVdkIJFQnLFXnIcCmhgpO+9Z?=
 =?iso-8859-1?Q?3VW5gPesoXl3ch8jsSN/K6bjuUqGFFsALdzYknSjHUq9MTBzRmeqDkUfDm?=
 =?iso-8859-1?Q?rbPiktaIr+Ssa3z4WOep4sIhGwk4JuE8szGJZOOCeAdDXcCOrk3f7tt5Hw?=
 =?iso-8859-1?Q?F7wBZDkUdRmwgv+fxA5o+Cp3XBEW+cSqTpGxrJvGhLNOxUYKfIAGxYHJEi?=
 =?iso-8859-1?Q?RU9f3AptCZJ8LISdAeUVb70u/apcmjiFmxsqJMzMZwloHkgrAs7rtPoJll?=
 =?iso-8859-1?Q?oOtAzDeLIwvSzkity5su7DgEgaW9rhPbdwRN5H4KAkB1gT9UMUtyAenvni?=
 =?iso-8859-1?Q?fcNxKPI24JlFLpsj+kYf/UJWi1htxqaKn7uoj/Cuzk1LoiM4/BRCgndNGk?=
 =?iso-8859-1?Q?ztQ76nEAu1iFf4DnFsYi8Un5G0PmNUOBJw+2nMpWVvSl4LCEglX7o5IKnm?=
 =?iso-8859-1?Q?MrLjlcEiQ0/FNbkOvyGMN4slW1lef+QW6rsm0pwZMG/ThjO1X9Rin2dgh3?=
 =?iso-8859-1?Q?oiC9fUubcyhIr9f/UoWnXMCk5v6hOei91s22ziC8dkdM0nuDV9sn1YskU9?=
 =?iso-8859-1?Q?i4LOXnLC+JTfb+bhQfTkYOJpy/pfz1jb4dJi3DVTb1NU1RQDTYfJaDNElE?=
 =?iso-8859-1?Q?Oc3GfJYBivSQ7KEQytP6yA3GU4a+r/PAV91kE0CMAqaVeHtstF7Thffgqk?=
 =?iso-8859-1?Q?h8dM1Jgs8pvTUX/6+jcDldFI9/2xuCzyvyVagekqN+V6dxwJAc9/bIrsXO?=
 =?iso-8859-1?Q?9z/WWaAxFgr0BgV/Nu035VhcCBo3KARgqCWjRKsPOPjHGsPqYGV7KueUr1?=
 =?iso-8859-1?Q?BPyLDIAsnGxW1oEx52Gu1EmXARzxIMgyhNEq+TlS05QZvF3kzQTn5mVPf9?=
 =?iso-8859-1?Q?+GGJismzoGOjoPj334VUvlVXmOCTAzIX+1P3WcLBzVThhF6blaCe2Quegp?=
 =?iso-8859-1?Q?iI90OqFah1KwkWdttUOes/U9EW6DjKk8MEpA87wXJJGod+V6CkdZUheRLF?=
 =?iso-8859-1?Q?NVAmj6VVMc1/RwXhFdVfdmcqxgwORKw2zS4HuiCrnh9QcbEm0uflzl9JYJ?=
 =?iso-8859-1?Q?d6Nj6nqe10yK6SKtb2HLHEpyauYuM1t32PO2O/9biqkkXGEHSsM3Xn3MgG?=
 =?iso-8859-1?Q?KB8Ymknv36gqQj876l4cuG3T5G7TvqQiExqV3iqOXzMkzYYI3XA21k7M0g?=
 =?iso-8859-1?Q?wjrSNjXBwx7TvzTNrFH6X4aVl9dbIsb1yDQFNeSUhIb64EF5KNtgykVlLI?=
 =?iso-8859-1?Q?Zm9JixjJh5a1YZTX3MLAb/6J6iKK5h5i+MpZSricS7IFyCmOciWIwqxCZ3?=
 =?iso-8859-1?Q?EAenCARVT+AstDmESxq53RF6idI3APcchLUV5aLkOJdT1bh7UDZIGWLDZ7?=
 =?iso-8859-1?Q?ahm102DFUk7sfpsVsBI4fOnWu8bTcueMuEaI5j7L5j7QfzCBTqOKfpopu1?=
 =?iso-8859-1?Q?t9Gc1PS3/xsPi6gVNT+39wq9baqsVPzhRHWB49pWONVd5PCDDkK/ZQEMYI?=
 =?iso-8859-1?Q?tB/SU44smLBqGMZf5k2bFg6QeVAIAnmsoX0ZlBlpy63IwjkZYF3sW7jxD+?=
 =?iso-8859-1?Q?Iz2bXUdEezxw3a0V5grw9Nhqc5jwsXEZK0Pst2v5YBui0naNxi0s4G+rQR?=
 =?iso-8859-1?Q?DuNySdIRkD9ck=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 21:53:45.0634 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1782880-f1cd-43fe-85e4-08ddffa2a9a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6489
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=nicolinc@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FORGED_SPF_HELO=1, KHOP_HELO_FCRDNS=0.4, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Reply-to:  Nicolin Chen <nicolinc@nvidia.com>
From:  Nicolin Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Sep 29, 2025 at 02:36:20PM +0100, Shameer Kolothum wrote:
> And set to the current default smmu_ops. No functional change intended.
> This will allow SMMUv3 accel implementation to set a different iommu ops
> later.
> 
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

