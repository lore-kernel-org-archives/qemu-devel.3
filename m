Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5887BFF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 18:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJyNG-0002j6-64; Mon, 04 May 2026 14:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wJyNC-0002iG-K9; Mon, 04 May 2026 14:50:30 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wJyNB-0002zA-58; Mon, 04 May 2026 14:50:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZOFDJb1tWHLDxY3RSwZdz2e3KKNtlNvX+HmTs3llDYyf3Iyotww23Y0fHhBmXYNt9wEPF0TNJO7/9X/NLQ0iGAyqED5NzHAhzTKu19YPBNtkujgScsgEwlGtD4ADs7HOVdp0PVwk+isiMhmvKMvGG9RRikSUbcTcBjMja2Yo0CsEOBTpWQjwz0VlWw6qBQslOm2gAcyIZ23ex7xA5x+pfitB1D67mOLvRyuvqHGeYMYCbJHoGW0mrVdXysh2gIzuvajv02TrL9QCPh5+msaeuySfcHMLpNa4mfxjF6ALLAkAnUXrkOOSAsOT+FVwYS0n/SsTlIKw4kFPmiNOWYRnIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCxZehbTKX4zq74oJKDudCJAg60Xz8B0pNLzdLVD6Vg=;
 b=owqZVe1vIPq3q6h6Qk0Mfl6rSFQG7Gjz8wzYfvKJV84VyUIX2h85FG3laQ7a9NgoCl/Jh3QoKzXzYvjDxEOrMwKg3QKn8GclKQAKw/Zq8kESZ8YVfIBU50YjRVYiDXZtp9JgpZzJydcy4BXMO/EcYMTieDe4qIGEBazsoczhkbag6NPpjEuFtB76ACcEYkHtTall7bbPZBb3DCWKBMdvEQ6vDP5lBtF5TbXAPHeHTA0LEzTY7krf+HR8duxN+T/fxvCtvR5uBP6Z+EY/SeVrqANiuxfeR3PtBalYV7nWb9HHNpDgzDzBwWaG4rdH+ulBJpOd7uA+xYX1f1ULrJYbYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCxZehbTKX4zq74oJKDudCJAg60Xz8B0pNLzdLVD6Vg=;
 b=bqXr4A/NzVgRtFxIDvbCAWvY36DuoeVT+myB04hHARcH/Xjh8o5q4zyi0GrXlJNv0zLrp7SPobSf6iMOc4dxYLKrvwN/eXU8ImkDApjkzfAHTpuU2gfoW0dh/TVKmRN7UQ2+mvS0v1iDQQQjhsdWIa9V5Io1Ws0RnbTeIbqeyl5T1tGvYKWYtjz6JK0O8jofBDHKWRrHIv+5QFTqsgVKCnzMBTCLluZD1AjXGiuBI+7R5b52zNQUTlzzfZ0vnrwTpfAUZcbMU3Y+uyQkBVvL5Bh3ADmJv578WtOUmU92V1pyGhcV7EOHDVX4fJs1agB1kkfN1lSIHwiVVYzl1Hn65A==
Received: from SJ0PR05CA0024.namprd05.prod.outlook.com (2603:10b6:a03:33b::29)
 by IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 18:50:16 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:a03:33b:cafe::d) by SJ0PR05CA0024.outlook.office365.com
 (2603:10b6:a03:33b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.14 via Frontend Transport; Mon,
 4 May 2026 18:50:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 18:50:16 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 11:49:51 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 11:49:51 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 4 May 2026 11:49:48 -0700
Date: Mon, 4 May 2026 11:49:46 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <clg@redhat.com>, <alex@shazbot.org>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>, 
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>
Subject: Re: [PATCH v4 10/31] hw/arm/tegra241-cmdqv: Probe host Tegra241
 CMDQV support
Message-ID: <afjqSppsO8uscVVw@nvidia.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-11-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260415105552.622421-11-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|IA1PR12MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: bf65aece-c517-4f9e-3642-08deaa0dfb6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: utjlXW9hp0pRy8L87Z9AWXwfJ//TwakTHyu+yUNfKoA5852ruwSybYfr3vltakto4p4zVeJNTJjW/AGud6yWA+zxWLA7kwgoHtQ+jNZEmdV2GBwNsqL3uvxlxUGAPuFFpc8uMMthsavj7+hsS8jbKlV8OB+IdrArHaPksQRJvpKigYu221q8kRmnlvsronnzAxLrAGDH3SurccEdk2UP5A+vkwmrZ4f6+Yx+v8dhHsDKkZOE7NqmCf6ZyZc/qR94+rQJ1JNjF6PBwJATN5cQdJ49KD8EPxgI1fl18cgktE1JmJoWVf8+an6bMVyEJr9cG20nP3fKBvs9yDemolWEjOpxAasJ2q7avoAON3sKIfMGpFd6aNifBniuZYM8TtGwb+eRq9G0FOjOS7N3n3hg2dPkg3fwgfC2TKVxo3M43ZwDJ6kiSSWL74ngqbTU/xR53IylSiN68nktfqdVVjY+LDqjlj2MKIZCgO3oOa2eh5eCOvd1nHLP1oU78/UQP+3j9wFH2Xt+F3hVHSh20YebgQiMTLaQnFuXyXtzGcw6mbqIm9DJ4dFwgDQ6Sh2KcCbhA+SGMU5AvFTmWT6R/Bv10+DS4X1Wi/HE7BeUQiXNmazd35a1StOdKzfypWSjW5hT5vBgxLUwx5laaeQnOZCTkg6CaE4D59ciPY8Lmdy4Mw/Xngn/Uuo0Yga61knt4A9PBIfsYG+ATjdQNnQqVWxGtGaaFjH5/lO9cE2z59YSUY8=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zWLE36Gr7XQGN3lKbRCAqOpIUDczDyil4riwUOrNrRsfIoSW4IOqwPheG0KJ5ryNocA5SztzhGtvKdFt5YrSuWE5pBTX/KzpTNIoMHJ/9u50NwuvmGIiRVPqOgMD3yY5ui3ognaM3zVD73/IXFnFYCgp8z86qQHujrpeK4dLEijuH3CtxnjufuTEhq3iOpcZZ+obYFCNgMox4v1SjYsbY761xyRXbcLHPcO034sg+JcHf2HtyP8V/ugD2mGXiRZLVQsdqqrWgpJwamEVQ5yQGg5idE1MojKRHmzyev85ik0aYJ6J1kSMbnsIXsUUD74n0+noMeeHvMcnwoKdZs2Ai/jIQbpnylmrmbZpfKrZZoKk4hTEBLO/97nnzSBTHz4EP9Bp2DH5dHjh/P0paH3Ag9noyIHAFawAeqS/fZN6YVhoRhzER2Kn5J5l30nuN9F8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 18:50:16.1347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf65aece-c517-4f9e-3642-08deaa0dfb6f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6628
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=nicolinc@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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

On Wed, Apr 15, 2026 at 11:55:31AM +0100, Shameer Kolothum wrote:
> Use IOMMU_GET_HW_INFO to query host support for Tegra241 CMDQV.
> 
> Validate the returned data type, version, and minimum number of vCMDQs and
> SIDs per Tegra241 CMDQ Virtual Interface(VI). Fail the probe if the host
> does not meet these requirements.
> 
> The QEMU model supports one Virtual Interface(VI) per VM with 2 vCMDQs and
> 16 SIDs per VI, so the probe ensures the host implementation is compatible
> with these limits.
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

