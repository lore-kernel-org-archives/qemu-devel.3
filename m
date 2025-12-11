Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9F8D3E79D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 07:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTbGH-0005X7-9T; Thu, 11 Dec 2025 02:38:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vTbGE-0005WY-NI; Thu, 11 Dec 2025 02:38:50 -0500
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vTbGD-0001x2-9U; Thu, 11 Dec 2025 02:38:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MwVHBx5x5yXk/sDTcEgkLvisKchucJKHWyzpL+8ac7pNgLLOCTU0ch/S4gcMB4X2Giado+rYFEXzj5J5mmAo5V2rGCffwENdgbY1b5nPFurmhImAH8URxtbmM2RsRhZwg1rZiWD5byeWxEhuTDh6EziR/0f97VpFI/0Jl2koKyljrLwDXwlmAzEiuv++Dk4RVQEsp3xAWEqBF/aa//gJjEv68f3ZknqQR2/hU05fWnR6ZLtn1ApTkPs78Q98prLxoc+B27LJogi2C/qUXyd/2xLlsYGFgyzQGGWRIR5lftTWfk5iAPoNWdwieuIZXUifAcBs0iNcGERlpOmqi0++3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gEjiLWyvA45rUJeJ9csf+MM2H4G7Y9sPUMjQJSUxv0c=;
 b=Qp/v1F+TBQuw43TxfE3gdO39wJVjpiqF9RCPsmbdLH1cCbJfspBsVhDNqIirHCnlW/SSYYWwkeHEDJZEDArRNOoKkvdRViXEbacHRRVDlx/xtv0CJeSItAa3PaprKi8m4t84gpPa+S6R1rvAN0e4iVMokE5b7IY6XWizlFqoudf+9JOqZoW+fr81ii1wZiOxqYEFAeQcsZPBigiIsVAN884u8SGeX4wvqZflH4h9IrK9s9MkHg2MmzL1BE6ZkpLPizSphgV8Np2rhWLeY51KZ4r394cPN1zc3KJwkw1C95U64H0BGK66fNaxlvnuTvpRf4miHL32a4o1H0HZ2YQToA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEjiLWyvA45rUJeJ9csf+MM2H4G7Y9sPUMjQJSUxv0c=;
 b=kWYw+dhWFCvR2RmIK05tsuyMyxXy6xwsLlgcIwIoERtPbF/SJVnqqognajKi+ckHg91KDfxEuJAouAA1FvFWPsKQL+uOf257U4BrRFqtI4xWpEHw6fRrd5qMwrnkw7cgQwB3Uo4kIXccIixG2BCJ0MiyoPTHcTL+Iwq2r4XEQTpqHQu9xLpYqApmQ5axZK87gRrSpWgMxbovCbZHAFPeXZu5dh3VA7w2mPCNFAJ+xZaZsWBG6qe0/KyI/e7l5kqsn0jiR5jJZ+fRbzTFNUXbviKPnzz5kzCelWx53U1WtGeWsAAqJ3C2YBpvWHVBEOzRkn3nu+jBC/tKa88jZArxmg==
Received: from MW4PR03CA0321.namprd03.prod.outlook.com (2603:10b6:303:dd::26)
 by DM4PR12MB8500.namprd12.prod.outlook.com (2603:10b6:8:190::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 07:38:40 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::c3) by MW4PR03CA0321.outlook.office365.com
 (2603:10b6:303:dd::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Thu,
 11 Dec 2025 07:38:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Thu, 11 Dec 2025 07:38:40 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 23:38:24 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 23:38:24 -0800
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 10 Dec 2025 23:38:22 -0800
Date: Wed, 10 Dec 2025 23:38:19 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v2 3/4] hw/arm/smmuv3: Introduce a helper function for
 event propagation
Message-ID: <aTp061rnZfKziOZy@nvidia.com>
References: <20251204092245.5157-1-skolothumtho@nvidia.com>
 <20251204092245.5157-4-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251204092245.5157-4-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|DM4PR12MB8500:EE_
X-MS-Office365-Filtering-Correlation-Id: 87bafe75-e254-4124-d608-08de38884dbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F9izr/CwvfOmTNTqUDprIuR7jBADIzzykbYPZAT8OZCsQo2z6e/1RA8Cy8yk?=
 =?us-ascii?Q?vWf77F09rS/UO+GqFuMEDfEIAnuUL/ogZ3h+inKstpLxTEq/QsrYKa8RVPbY?=
 =?us-ascii?Q?lucWbzCoreWmq2u2Df/nD/ycJ/FKmDNL0vs2rP1gKsY+LBoUf8emTOVVgECN?=
 =?us-ascii?Q?XnpkmuLiwSgSSvMtANr1tSL5sA4jaqflku40ZOvqijJpgRLiIZ5uPPz1CatD?=
 =?us-ascii?Q?0RHkizOzRjDkKZOY9Y1VyLtu0TpK6JrCMpZTv89FJVEd1lN13zN3VckWYMQr?=
 =?us-ascii?Q?9DTBGkv2Q8G0VkKD8kpPQOgNCMBO7gNVvx5GQageO5KIdq8jCPN64+g0n5Es?=
 =?us-ascii?Q?TrS1bc1vHibo5yn0O11ybcL2VjMnk/rJWDt7eqHC7ijvm5ZBc8V4JPumBMCv?=
 =?us-ascii?Q?t2mtqk12Xu/irCWMbGj4nc89c/VudZcaAnHtWwD6uf6Zk56sqEYTlLa53cgT?=
 =?us-ascii?Q?eB4/QIZsyKR3IGaOdNNJH1SO/lkqHKu94s3k8j6iJN+2VQf7dqQyTGrWHpeH?=
 =?us-ascii?Q?2K76+HWh4koe9F5diomdgoTUv1ClX9k1DUEV6XZcGHeK0pYRdMI+re97LNAE?=
 =?us-ascii?Q?iDlmhoS1anuhmdOrOshSssimbfYgTlmVPTJF+SxOSfJ/lR8KTjjoJVhfcZRa?=
 =?us-ascii?Q?DPJEK4tpD9+VHHvn+r44wnMxWJjZKj7zEK5Nab/01/JsaaKLuU1gn5Qj0pa2?=
 =?us-ascii?Q?HYHLIhrd6hy+u0E0jZiD5C0fE/mXojPQ3GqB0IstX3R5BBtgYBDySB/tMAVs?=
 =?us-ascii?Q?cnsAgpNL8r6pzJGuby09PunUYGWUK6VMulJgf0xp2LqXsnQx0osrTBdTCvNG?=
 =?us-ascii?Q?B2qh7n6WTMtdtd3kMFz+4fTgEuhdUwy/n9Qg7E8xQL3Psdg7Xq9iv/ZQfdyd?=
 =?us-ascii?Q?SAFCrwGc6RcCxpo3Fe9tacUQ3vdgw9Ldu+kZFml6BdpIsnTXOhSxutbt81Kq?=
 =?us-ascii?Q?sIXVUjPf0e1e61wrXE2vzAwxeG9ZwGGuOfh81ZsMZ1i3VXWP0ophO3Ph/PXY?=
 =?us-ascii?Q?K8VDPaz6a4IObmdf/d62GO1kO417oGHvgxFX7O2MFTnu+eMLSnWM6aNsoWCy?=
 =?us-ascii?Q?w6k1mZeg7vE00HS/k95MTpTw1FqTgDM/sIegDSso3iNTbxk0BO57NH0TWSb1?=
 =?us-ascii?Q?6krw4JEe430GQZdZCuQ6wvkfAExg/hASmw/Wz302nyoovLxVf0UDVNwDgayj?=
 =?us-ascii?Q?SRUXi3OEyGbY1a5qnh7nbQsKmTlbBTcyrSqeczkche1TsqCvUijDPXCsibSc?=
 =?us-ascii?Q?v9cvGM8IWW2nbd6Jnwqu0lV2BULNcOCkGbbjH8J+WEi04l5588nEC30Va+P9?=
 =?us-ascii?Q?RfF3RBZ08pu1Ev5UNmtDZ3tkXqdSpk7X0O1iDZ9789nkcJ9k3W1/tffC6M4T?=
 =?us-ascii?Q?ggIqi3QvdAxMR7gS3GxpNPKZnMo3DcB+Y2cRXnJ6C/aIUBDwe7XawNJ4o427?=
 =?us-ascii?Q?OBLzjWQxWmZl+C+GxRm7swWhw3PRbmTqiuno7NmsLngf+PKvWVWLh0W5o4po?=
 =?us-ascii?Q?U5vpwV/zCaOyP9dMT8MKkBhnO4sP9mbSekK6AyuNQU/xShygVuaZWBPnQQkU?=
 =?us-ascii?Q?0P3BKHUYfcJ/DYiyqQE=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 07:38:40.2683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87bafe75-e254-4124-d608-08de38884dbc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8500
Received-SPF: softfail client-ip=2a01:111:f403:c100::f;
 envelope-from=nicolinc@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Dec 04, 2025 at 09:22:40AM +0000, Shameer Kolothum wrote:
> Factor out the code that propagates event records to the guest into a
> helper function. The accelerated SMMUv3 path can use this to propagate
> host events in a subsequent patch.
> 
> Since this helper may be called from outside the SMMUv3 core, take the
> mutex before accessing the Event Queue.

I wonder if it'd be better to use a different mutex so eventq and
cmdq wouldn't be mutually exclusive?

Otherwise,

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

