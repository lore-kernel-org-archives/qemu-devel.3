Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C272CD3427
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 18:29:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJy2I-0003gb-7f; Mon, 04 May 2026 14:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wJy28-0003fO-85; Mon, 04 May 2026 14:28:44 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wJy26-0002gq-Ci; Mon, 04 May 2026 14:28:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dzHZrDLnuqEVpbM08k84wCrTD0KFj5phRCkd6X/Y7Uv7i/VVDra3QgV3BxxKkvyqAMaYkWrEwnlWzuAQGW7m9BwpDZ6rKuLFd9Q1DWwiuFB4iY8TRW9z2PFNety4ZoqCZy+iQ/k8hExJubew++acteZSgK51WpYzK0PNWHv2qvWhHlOS3lXV/Unxd5ZOuI37RcZGa1Z9mP5NJJLyxW3pjjEP7uYT4R+NjV4jF/eQwIz/srRs1yhYSp7/eqmEaSk0rH/kdNznspyiPHsGwRTliLRabMTF4kSVvNgFZrkvYqzBAuLjifkadr4ScW2EbwWnEwhdVbDy0aPnDbkO5fPz/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYNn21DD5aM4UdBJbkEy6I3nZfuNV9fOaGC8tKCYnoE=;
 b=Fju3lcTqlpuQ151y6AWLHvRhTUbB8ST/2Zs5gP1/4sNvTIwezw1XAUJZ9+MsiGn/1xexe3JuHVDOCjK4ghOnSuo9xJKpnEVYE30xgUfFkylfei/M0TnWEdAmnNSRkNctpFR4m39Nu1jWGuyJqzTv4h4Tl2G8iEzokPn1jSL+WUBPtjMbzLk+Q4REuvffmLLUu3MvMrilVuDY9WUlcuv265c7vGDPQrE7a7YsJGxTOI7Eau9XL3V0EVjW2JW+4O5lbH7tKMm7HDgR2B5hlJyacKqQEnMLuEXJsQPNG9brkW8KIclVwl6+BLy6HK8fBH+HWkdKx6z3SmB2O4UsOqwoCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYNn21DD5aM4UdBJbkEy6I3nZfuNV9fOaGC8tKCYnoE=;
 b=Y/r5V4F7FsVe6rAnQH8qYWFbAZlWhYdQoWPWv5IkGJLg6BUHNtozPl2xvaLV5IzIqK52hzH5Z0GcYjL8TMjsWNLF5nkGXgPJfj0TZGSqsXRl6ZJKyGooLy0zi+ULo0dtSwlAJkytGNeCBxPxHUbopYlyZsDn9CpIlxG45G1JLLEgkWt7I7ggIm4RRktauvDfxef/z82MeDTUNW5/7ehX2M5HpqUnZkrDWbvPz6JTzlkETIXHupyO3LoBJBZ6X5iCaYcW9zWX995bueXghY7qunmhOhdfY9gHV7epSI5XtAwXE1U0LGrS5O7ptqqLpJj19NpYwj52zb1hUB/zQvrqSQ==
Received: from SJ0PR03CA0225.namprd03.prod.outlook.com (2603:10b6:a03:39f::20)
 by BL3PR12MB9051.namprd12.prod.outlook.com (2603:10b6:208:3ba::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 18:28:32 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::69) by SJ0PR03CA0225.outlook.office365.com
 (2603:10b6:a03:39f::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 18:28:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 18:28:32 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 11:28:08 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 4 May 2026 11:28:07 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 4 May 2026 11:28:05 -0700
Date: Mon, 4 May 2026 11:28:02 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <clg@redhat.com>, <alex@shazbot.org>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>, 
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>
Subject: Re: [PATCH v4 06/31] hw/arm/smmuv3-accel: Introduce CMDQV ops
 interface
Message-ID: <afjlMlW1KFiH1QYN@nvidia.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-7-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260415105552.622421-7-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|BL3PR12MB9051:EE_
X-MS-Office365-Filtering-Correlation-Id: 6707a194-9191-4985-9ec1-08deaa0af224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 8MNQwMv67zmYxWJ9N1uTXPJkoH+nlRm1c5EaToCPpbUsdIKX10n1A1xGZ3/H5eis+TiepYP1YsMWCZnrZWtviuoqgiebKdzmuSmn4zt2gp5Xosf6i9+mv2pSrlyRqAhXKaAm5TjYBPf+9B3ghITv3IvBj7gE1zaOs/4l9bGdWX/XsOejGwU28Kp3M/f9BhCL7ijW1011wUvJHrh4hdvCfV5pEuPRi0392266+AjLnSV73261OEraW82f9EoGBzqdbAO+A7ONSjtqTUXBrJ1ihnnf3GLpYksCIpzf25wgCGWxD0cKbx4UdeS8vibwVz6Fvg9OzqsWOMZqDgu9y020JyEzMpLv4fUfY5pbAPiXRe1dbDBDJhq4LHtCwAKHCdQk3+tUeAloyLutFzYAwQJtbigNEXL7S6h/gImcPz52uQxya+BO2WEZ5vwEGK5Nro992BXYPL8mp9vb2bZhbEya9ukPyLQlgyE5EW68n5HB3RHwhzOD47t/rIxTPkxO9jbkEuaVSrUBPMkvJyzr2Q6a8DNBd+JBnVSfwEAAdbfnxjvmQjkkqpBb5BilYzOw9MGondYzrF423Wq8SDNLMcWbOO0oDQ4FjDCSAIPv24Qchilw2207kTufVnjSCBCzX4DDpeKVrKNxybI/HdvtqogMBX4ldaifF7v+A0Atd5JdjYQkvT7qd3wJW/Of2jkipU2b7+cbs4irq8M37LAO81Hp02RMxISW64zcmdz9yegRJ9E=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dfAnS180Xd8cjDLQncLGe4UdXRcQ0C6DtEaNXn1xdsjIyXyg5+q4pacw3DqCQ9nqsS+pj5169ggVKypQkrtwec1dgtpuYAVsyislUZWvL9AzEGG1YEtTAJ7kwY9dx9PakYHclh5eG5A4+DIk4VZNGjAuR0YpslS3HSM+98wcQkxjgVC8fOHgnWZAhS4OIFSXnqSTFGyx95pJM0gTr4OV2EN1OvvBJr2eT/skIgdAEPPq4X0eCZhnXGFu3gP3I7dYAeotqZzeEZTptkdZ8WsV5j1bZMINqFgh4n4PrjLzjWTTUWnUW6xlelN+JSSGuHVViVDARdEpzRjrVhIXjQna+Q0HrUwdNGhxC8MFZipvGZedMoSs9kS7MPJb9tIXmE3F8gfZuIcB8NM4A8ixviNtqjjcwqG7iiJXckuoEjjTCQNuW+6g82znKwJ8CRsyA2I7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 18:28:32.0740 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6707a194-9191-4985-9ec1-08deaa0af224
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9051
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

On Wed, Apr 15, 2026 at 11:55:27AM +0100, Shameer Kolothum wrote:
> Command Queue Virtualization (CMDQV) is a hardware extension available
> on certain platforms that allows the SMMUv3 command queue to be
> virtualized and passed through to a VM, improving performance.
> 
> For example, NVIDIA Tegra241 implements CMDQV to support virtualization
> of multiple command queues (VCMDQs).
> 
> The term CMDQV is used here generically to refer to any platform that
> provides hardware support to virtualize the SMMUv3 command queue.
> 
> CMDQV support is a specialization of the IOMMUFD-backed accelerated
> SMMUv3 path. Introduce an ops interface to factor out CMDQV-specific
> probe, initialization, and vIOMMU allocation logic from the base
> implementation. The ops pointer and associated state are stored in
> the accelerated SMMUv3 state.
> 
> This provides an extensible design to support future vendor-specific
> CMDQV implementations.
> 
> No functional change.
> 
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

