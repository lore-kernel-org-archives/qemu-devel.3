Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE4D8CD3443
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 20:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKMOr-0002XL-8r; Tue, 05 May 2026 16:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wKMOU-0001nr-Be; Tue, 05 May 2026 16:29:29 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wKMOP-00032N-H5; Tue, 05 May 2026 16:29:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XqshD6KHZGgEUKjBgayXbxreyNK2VHB6mRErGUEJkfkTUoPSO9LBvER8Nrhi7RecG8baGZ6RCEanJveyh+DyuIHW63L/LO1bkUzzqSAIlIZ4hfhjZzgQb/CxeFGwzxDJxlTSjlA2O+AMkvQ4cjlEcrnVe/Y7o2yL++5eIY9mvL4rBw3ZcPYQKHpHgALeQB1C+eLD7zX9RQZbSABREU44aok3SDqjDfUMzQmiNC1+gsnL+pVw/yIdhIzxa5laBia+8dDKjl9M4R5kuxGQGZ7ENiIiWJEhCJPyaddi1PJAYM8/lNUROj0TdkOGsjSdiq+m3QsAmCUi9wKZ64dLYZoz3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYpmhuMHqfnaou3DO3OD2xMT0KY2+zEAQskR25CMpnU=;
 b=l2BKM92k7qo+/aZKkPpIeJPayCUpfpbdfkwPIoaLUUTVKuXYAExuQpLZpuXYgebpg2/eIEk9CoIfQXL5qisi+zBlt+IFgImNUTrThfpRaiS7rSLw2+xUR/zurKmw5qKBrwx7VbDPB/bBqubqmXXxpQZDAK3NoT01hYlIcpaT4bXPTPgsxQlrQ8m1l9k1PRXEhyT9z8WMlMDKYnVLU6x2c/Hm0z6W+f9H54EC8JaM3gLju29WWmThcuWvcv3FklEg3WVL4YWYRLq1rkRdsCV1qNTz1mfFZXkDgevtifazJVgx7P/62E1hLvVqsPreb0Y+LhYTu9F3mQp1+0cAm5/v0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYpmhuMHqfnaou3DO3OD2xMT0KY2+zEAQskR25CMpnU=;
 b=G9TwHZJ/0AsYQPysbuUskWMlFLjaCplOIwuSYpBXaKU/ukLgUMaDKiAo7ebwbyCG+Drl2V//W3h5jNcFj52TKmH/X2NM7AYVVCF8YmehNYhy4oU1Eh9GtAx8ickwTV7c7GuHEKxFOMArUYnkTVgdepGC6FZXPvlpBfk1nM7PPGcCGGECS8e/tqDYX81mG0UsKRuayKSIqArMt/PjVLvzzUl0nFKTbltsKfLdOwDfhIIszKXTjPTDqvshCEBISY2VpKnBADkwhRUNBK5BS8UMOoGNQWi7kH+faPlFwBwPzQzlHSAs3+afgIss3eOkWkRs96kgEs5ggdbsU+xzQzCcyw==
Received: from DM6PR07CA0129.namprd07.prod.outlook.com (2603:10b6:5:330::23)
 by DS7PR12MB6167.namprd12.prod.outlook.com (2603:10b6:8:98::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 20:29:12 +0000
Received: from DM2PEPF00003FC3.namprd04.prod.outlook.com
 (2603:10b6:5:330:cafe::f7) by DM6PR07CA0129.outlook.office365.com
 (2603:10b6:5:330::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Tue,
 5 May 2026 20:29:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM2PEPF00003FC3.mail.protection.outlook.com (10.167.23.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 20:29:11 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 12:52:35 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 5 May
 2026 12:52:35 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 5 May 2026 12:52:31 -0700
Date: Tue, 5 May 2026 12:52:28 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>, "phrdina@redhat.com" <phrdina@redhat.com>
Subject: Re: [PATCH v4 20/31] hw/arm/tegra241-cmdqv: Use mmap'd VINTF page0
 as VCMDQ backing
Message-ID: <afpKfEvuT3ZeBSiH@nvidia.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-21-skolothumtho@nvidia.com>
 <afk+zBZLQx+x+ODl@nvidia.com>
 <CH3PR12MB754892989B2A76D3D3A941D6AB3E2@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CH3PR12MB754892989B2A76D3D3A941D6AB3E2@CH3PR12MB7548.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC3:EE_|DS7PR12MB6167:EE_
X-MS-Office365-Filtering-Correlation-Id: 80a89370-3c5b-4dcd-b1f3-08deaae4f7d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: SEDH05vLwMA9krB1/NWG3xGcSblIZ7sEJVz/TlOBi8h1S2T8lS2QLM9RWdLAX4E8vtvi/zEFMLsCMo77TWy3XQQPg+W/5E5e48wR0II5Nm/THz1BgMdKCQtY766NLT7lQzURmxWqX/tfFAPNHy7X+3j6c8+E2sLX4CD2/qsCi0waUSPgaTXaSroCTasmDpL4jlT2sHvoRS6AR3qnpwQ5Occ/elP0Wjl0wY8HTiSy9kPD2tJ7tzcIxql9R+Iqa9LKmF0UFOYNvx5blxQZp0l/rvD4miilV2V5O1USAzgKKSMmSCTYGHq2LzwqoftH4soj3JJ5PQ8Gm9pDQUwMWqOMSjDJTIpRso1WQdTzlA4JzQ0eMB6K7kE4PRPopi8sEJTbPvuUgFVEgytLjCGHlew5xQSkfh9gJz751Pe7+R+IS2R+csJZ7Du+EPL+S80NeBm6TgfpjPvouJJmsRPv+ZJdvLJvR89fXnZAgR5epwBNUBxrFxNyGgw+dJkzT2bblIx8rtQdGDmICAGOWYn5Th3jafVZXtEsaseQ6uQr8pHYpeiElDWSm8befvR4iyc9EzkvcCklZc4WAZNS7OZdXC90RIUTzzeI2kBOeLh93pngOb+U9nnWJnl937VEljvVI9QSK+onHhzVAG7cZzdHPXQlv3FWsyYZK/YE/pG/1fFBEdShPu0xBm64S7DCdjtS/vwZuEAAmKJqWUJKcIHmWkdDe9tub2Bdo4c70HpfV1nJe7U=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qj5QJkqoaphnAZO13J26FiibimU9R6jURRFEhCM/6zjp1Sxud/xvwagrGcU1GUXr+vVHukEHRutzP0HZljbULJIajypoxp+RPn8yIM7UsTnF7PsE3lU67YRIdA5UYMy83lKTOOhVGk2BTC4KAKVQLidts2E3Vu1T0QIjymoBJnGs2IM7Mc6MsJ2EuGfUVGDeEg3a7Qxh8d9SGTCh/c6ftOjdeoqAO5p3Lp85acQ+uTUa20TbYx42OWbOWC1qgQDVLYfl6vGrA1YyIAThM2zg9WwX36/bLkaQezvkQWv3AMpoSnNtRmniuMuVw/NINY2WwjiCcKEUWGfsUATDBlAoUUsnZr9wixr7OKelBpnzMxS9xbRoK41Hx1zUm2yHqfQ3ECC0U4tzb/CNYxl3YwRQoTB/jU/4zIwM6bFfhcekeSMg/Mox+8JHosfmsiVEjbaj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 20:29:11.8859 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a89370-3c5b-4dcd-b1f3-08deaae4f7d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6167
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=nicolinc@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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

On Tue, May 05, 2026 at 08:13:40AM -0700, Shameer Kolothum Thodi wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > On Wed, Apr 15, 2026 at 11:55:41AM +0100, Shameer Kolothum wrote:
> > > The pre-to-post-alloc transition is triggered by the BASE register
> > > write that initiates IOMMU_HW_QUEUE_ALLOC. No cache-to-hardware
> > > synchronisation is needed at transition time. The hardware mandated
> > > init sequence requires BASE to be written first; PROD_INDX, CONS_INDX
> > > and CONFIG.CMDQ_EN are programmed only after BASE and are therefore
> > always post-alloc.
> > >
> > > Any pre-alloc writes to those registers update only the register
> > > cache, which is discarded at the transition.
> > 
> > Is "discard" the correct action?
> > 
> > Guest OS might expect HW (VM) to retain what it writes to those
> > page0 registers?
> 
> As explained above, I reached that conclusion based on spec p.174/175:
> 
> Under "Enabling the Virtual CMDQ" it specifies the init order as below:
> 
> - Program the VIRT_CMDQ_BASE 
> - Init the PROD_INDX/ CONS_INDX to 0 or a consistent value
> - Program the VIRT_CMDQ_CONFIG to enable the CMDQ
> 
> Since we set up the HW QUEUE on BASE write, a spec compliant guest is
> expected to program the Page0 registers as above after that, and we pass
> those writes directly to the VINTF Page0. There are no GERRORN writes
> before HW queue setup either.

I don't think we can make an assumption that guest would follow
what spec suggests.

Could this be a case:
 - Write the PROD_INDX/ CONS_INDX with a consistent value (0xf)
 - Program the VIRT_CMDQ_BASE 
 - Read the PROD_INDX/CONS_INDX, expecting 0xf
 - Write the PROD_INDX/ CONS_INDX with 0x0
 - Program the VIRT_CMDQ_CONFIG to enable the CMDQ
?

Nicolin

