Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E748EFF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 01:35:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK4hO-0004fZ-Ix; Mon, 04 May 2026 21:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wK4hB-0004eK-8N; Mon, 04 May 2026 21:35:34 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wK4h9-0002dI-95; Mon, 04 May 2026 21:35:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pRtfDI9e1qADr0THusO2+H+yYXn+0yarZZ91ctUjQNkV1XuUtBGLY07HTGGd2zHhEdVl9yzvzf98OivnKt+QIxPrQwNppfQmHXOc3aWuThrjEAz1eTsrq7OJZuiFICqyckb9RjWWYiaG+j3ESfj7NtVliO48FE0S03aJX0z+1ZF7QSV/mx31hNKrJZE+cjqBqx/sJzpSpUaGX0QluBjBx9/0FosX92HrJvf8ZPh6kj4Xr0V3OcGzPkhF7Tr4Ly6l0WGSX/FC4jMCP5u6vOQ2zt337TNAvZEFTPyJPtX3nPbI8WqSVdzT59u8uDkG1aKMW/4ijQC5t0YzJFMQXXGrVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GKuCPBvkYxlhYnk1vDCd5V0lkCQ+CeP6KdsE1ffRSU=;
 b=AfiiUK9cxXGxyBcs1+NxSeMIlysbmmodW23LWLz5nWsL7lLRQidsqBNuOWr3M3pyOa8PaSl8MTdKXvMuWqbMCU3qTTzyz2ZiP7oNoJqwhck/88QLgTTIcMJe1p2wDG6kK5gWSC/PptzhMEFLfXtdaEmCnJbCw7kgbiL4zyAY0SwAbPKOpQo/uISZU6lSXx9b+T/AC5emwAooQFPJYhVk8IOIeINRmoSMy1JAB0xkI0UJM0FDvLFSFVvG6p3GOIGoma8prnpdNFfVlxMs7ibmXhr0zcNmiBjzMBBH9ECkSds13pbM2tgJUzjT1rLlUPF9DuJEOOwWcXGqDbsfwVStRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GKuCPBvkYxlhYnk1vDCd5V0lkCQ+CeP6KdsE1ffRSU=;
 b=DlA6lkQivNYMPsQa8fF5vaa/IqhfeaObQ00qIuQIumF41yfkAlrrRQdyW40BK7K0rOkBi6zZ1NrIicKI5dxxBUt2CMI+mb5JU2v9ou+m6XYT2QXJQgcvuCkiyd3NjwnVmKdhoKxo/IA/KpP2vVY1gYqcSW10wQAnz5SmMXMVwIMPuy/tYjqz6BhirdGvDUNPtYmM0rTuOLUJ6qZXpCXoPoZUoa0dmX8UFuY8i9V49KGfK7kwT+X0ybbVF7Apys2sKt56VIx8pWMfWdOt3qde3YqhQjzKb3NZAB1LkhueNyXKj8Py1NAAiNS5mbfx59ccbscbstMTpr/aTrBhLFpllg==
Received: from BLAPR05CA0016.namprd05.prod.outlook.com (2603:10b6:208:36e::22)
 by BL4PR12MB9536.namprd12.prod.outlook.com (2603:10b6:208:590::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 01:35:25 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:36e:cafe::1e) by BLAPR05CA0016.outlook.office365.com
 (2603:10b6:208:36e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.14 via Frontend Transport; Tue,
 5 May 2026 01:35:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 01:35:24 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 18:35:09 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 4 May 2026 18:35:09 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 4 May 2026 18:35:06 -0700
Date: Mon, 4 May 2026 18:35:04 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <clg@redhat.com>, <alex@shazbot.org>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>, 
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>
Subject: Re: [PATCH v4 30/31] hw/arm/smmuv3-accel: Enforce viommu association
 when CMDQV is active
Message-ID: <aflJSCGIgILA1w/4@nvidia.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-31-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260415105552.622421-31-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|BL4PR12MB9536:EE_
X-MS-Office365-Filtering-Correlation-Id: dcc4a153-31e7-4190-df57-08deaa469477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: s0wX3nQBHAL2EBC8LkjnquZ910mpzYz5KwmFDU85RKxS7JxubW4AFsvm/Vt4mYdFoEoZJlnpunJY+3MvGXMYdweZV1GJRltt8pCyMcxrquDylkc1M8K3W10baekm7etiffjULCxSnNyICahk83JFoybH+0OEpGdHMt0fqUoUExmc20S+oyaq1Rd0OvKSLA3HpMxtS+VL1+V0VkOG/llFVeBKCrCMLMN7r4Ryp/EM06fzVoPIw68Yt2m9CaKo0J1E6lY3T+YpV3aCmq6PwuqkMjTzKOWpiqpW3RdGdWVONjwxovOyYbSlEOq212S5PnJV+d36mhfXkUWlCs53rjnuH2+H8GwrVhJ94PvCx+DN6MoFQr/hLf0yDJJv0xbGaLggYc0I3MJMnMxgzFsmeVqzNpfJuDHWbd6f4OFjyTxp009TxHEFEZHDxer0VS3MlEGKQpIZuXyNqVT/jT8Ga8f7jcaocEToyddRGc6ItiEclpitK9Ms81gmr7jAxLMLO4RqZSxW8DKWAC2k3ov33CRSUyLIffYyzg7rmSEf21OrcnESHBrfMmcpXpA9nbyHtRNWvr2n+IQxNxv6Tm5MQ07u4yEJ7Vtu4ImWmIwEe2xQ8q554ZtyQPt3L+MhbihHoz+YtvZKB5Mtpq5agvAiCkciIdLE1+0zErRjMTW8ye0vMFLSLbmHrn6vRVbuVXCShjTv7ak117/Lixui0opFFO1S101jpkeOdATCtd3FYIcSXUQ=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ni/ipCCYamJHmvGqopy42AcRZy8dlSCKiXiW43FBiRgGOE7akc/lZs4KE4GrIY4aFrFTtXqChBcC1G0S1R01yQY5O1EmCzCm0MZe2fynz9SKeBiJVOEQHFX+cbT/RCVcSGmwNPMO7kUgH+nHUb1fgaImHBTlLLHIun+O2sYM06PMY2vI1fwbWfSYaZ1BcAsNm2i17VIKAwnBs/vai2C/TXXkgulDUkTiZE4a73Ornx7o+M3HSt2WRe1A5ikVe9ttfAQY8eAxcpjPWgm9baqvwN761wAb1kYZd8dky7sYkh2hUwHAxnPKGj1nmGhl/28pUHMSHes7jwR30CBgBIdYWe3y5d00nrz01xoWhKlFkFqJhz2phrLumzEQzMfuNpklZZ6u1lDq2JzOGyUehIz2kmR+MPFDwyRFpVgSSCcCrOEORaqXYQxYT6mFE+cliST6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 01:35:24.6614 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc4a153-31e7-4190-df57-08deaa469477
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9536
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=nicolinc@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
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

On Wed, Apr 15, 2026 at 11:55:51AM +0100, Shameer Kolothum wrote:
> When CMDQV is active, the first cold-plugged VFIO device establishes the
> viommu to host SMMUv3 association. Block its hot-unplug to preserve this
> association and the guest's boot time CMDQV configuration.
> 
> Also abort at machine_done if cmdqv=on is requested but no cold-plugged
> VFIO device was present to initialize it.
> 
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

