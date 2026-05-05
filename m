Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC0CFFF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 00:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK3al-0003SR-SU; Mon, 04 May 2026 20:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wK3aS-0003P6-CZ; Mon, 04 May 2026 20:24:33 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wK3aQ-0003I6-Qo; Mon, 04 May 2026 20:24:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fF8s4AZFy2av0w5IprNcWUAE7ph3i+tOIVDyC/92SWGN0oTR0D0iPyn9MmNsw4olvp3BthBeIMUpoaYsPFbUrOwXkpC3Pru4KB9UWRhVy6kTBd5sLigWvCSURGNaStBnXIiQL4pvMYAFOJrh8T7tp/n1LryXEDaC9Pztgi66j7XaXpSeYY7Nvp6BIEC2Ko7T3okk0eBW5D+XsjJV0osORjSpNvnTAFjg0uSlEoHcrdy/YhrWoB6YpWBU7HWokE4XoCeDbWWZlRUhHnqby+6kkn2iGEww6t+kN73ERcaQPNNgo47uoBNepJZR+A4RWbsUyFUd0r2/I4TI0q5EWTSqrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MBwpM/3MlovqksHRVEY6arKjmTOLLhskGBBfhVbNCY=;
 b=Ngz7KH5mZJCaSNysAmw/ouXazlxqc2yuYTGsDjQa/atdZvO4KaenC+B4qrjwb0c9Hw5tjoN9bCBz53C28OfzcRWQpLo2tZcEzE6liQ8ydnw928Vwi3FtBfJunBxrsXRlXyRsFCpHDRDnZxToN6qE8sRN1J5JqxbyCxRiqQ7nFGMF7H4nNAHoLPYGrjA5C2RKMJ6VZFXuTZL8qsZThm0fIL+4NiyLqXkg/uFOt83iJicid+3QvbCLva02ptbeYJSEsqB95pxtsbaeClCIsWDVGwgkn152kYfzv0KC8jgeYiH4kUhgLN8MYkgoWPQPCVr8pFiV+vYbT2lpQuocpCLQQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MBwpM/3MlovqksHRVEY6arKjmTOLLhskGBBfhVbNCY=;
 b=FyEPWq601RYgrSbPxt0/vkTmFLt9fG/y4Nr6l5X8TB1mideY+svcRFKBYr9bXcJVqs/baJpzrz4VSf2mr+tEIARyJYbTvjyx1IHdCFPI6gpP/ZNAlD+maiGfZeyg3As6Eiq8LsCaqfRpIf0l37fKX3yExrehEv7EEuwx+8MewbdSrnfmovaYo9JuykU+7Y4oUyoidQToFCx+3XazCzZ89arccDXUwD4nzkWxIv29paG6PJrAFff1zqhcgEIzJDPRLxvm8XaToIsQQEM7HjfsUXKUr8P6TKspcYSrH+mWIIx2Ha8oQCjK/XBwfElLuCbXL+CpELFkpaXCuRNbRITezg==
Received: from BYAPR08CA0020.namprd08.prod.outlook.com (2603:10b6:a03:100::33)
 by DM4PR12MB7696.namprd12.prod.outlook.com (2603:10b6:8:100::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 00:24:23 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::37) by BYAPR08CA0020.outlook.office365.com
 (2603:10b6:a03:100::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Tue,
 5 May 2026 00:24:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 00:24:23 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 17:24:09 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 17:24:09 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 4 May 2026 17:24:06 -0700
Date: Mon, 4 May 2026 17:24:04 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <clg@redhat.com>, <alex@shazbot.org>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>, 
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>
Subject: Re: [PATCH v4 18/31] system/physmem: Add address_space_is_ram() helper
Message-ID: <afk4pJYEGkIk6rfH@nvidia.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-19-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260415105552.622421-19-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|DM4PR12MB7696:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b5849ab-b818-476a-cce8-08deaa3ca85f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1S7fM6Z0owg2CT+LW+fjvJMy5m/Brb3t+eJ0lkM96Jb93tMKn6BQRwrFuEOBuTjDFyd/j+W7zRAfTJzqYa+RHBzGIiJrJ8/v5YE530XOE5+fc5L8eeESeuCSOV4F4ZMtmTTpv6W8RX1eUL+x2ke/li6+/CaDBeUVGnLWS3PAE+Fduq7hnpXFeMpVmIiXc+DhCr5A6aoEG/DE5GDhYI0ctvQZf7xWNSKBNcBz1XDkWEcgnUsvPh9TpdLkwhY3KjbJDk2WrVPZOHm3yUvIwK9VuK+B4qDlLgWczw8aXDgCgxQytbrmI0HpBDtzIZORgm406a1gjfx2NMY0xDzVgnU0hxPpWEq8NiCkxRj0DpncZ92GAn22U39bHnetDv2Eywo6DbDQMtbzjHCzcJkhOlUVRBQI1JnT0pWPzJN1Q+U8CLRWdLE7tkrkF9Ddttnj6X+KBILlcSvFPpD5LB38iYXCRVWDGEi0CjFq3XGB0dd4pBHCFRxLPBR6F/W9MnfwZIqMdjLrsbOzCAwSX+9e0vsnChvMJ8Ce/z7SsZPH95AWQf3hVilfrYryKtPuHAEy0k6uowSqNkSiAo1F3ciyVz9X3afgR0kb70R+18eAhk7JZb/zqRYahI+yGc/3ShoQNvDNwdFwTZvrGaChv5DmTrUdslq8jAAn6jR4kjiPThZMKIwJouoZRUYSIGc5rR0WFmavLP+t5QECvNjjuzdNkoS5h75mQdoUtSXV/eXifN0qO8k=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BtbZYPutaSM0/V5SlxtNtqnen0RYn5+0iCzbpD4xs6etU89O0FF0Dko70bURzJSUTq3+hBUK0zuzTJs53xOIyqGG1et6HHB2e1BuIOvRRywBy/iu+u0ERx3VGBVXEAi1Kh6nI+dLIAazLhAI35rdRg1VkeIIUmAlm5QeqzfOlNnEffjoJYrg/sJsGlrE/tAjuC9P+e5dZxxWigM4cAWIAJSB1nysLc58CiPvu04IZFmnNigceILifyLP5OwDtMcI6GdostPLu+OS0UbOt1OKZGyui6OeUXdxPvl4/RvabTdNGAlGBVwY4SCJE+HegAojQOdprxWkfNN8Ip7KMAQXA/WoNPpFVmyPVloSeJFhISqL3Uv/amv3sci2/tMfq2UwnPhFPpgl9ErNHnf4kCVri+OseMKzQ5T4PJwxANXSyycyuxV3yIfqWu/WZy3rsnz2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 00:24:23.2472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b5849ab-b818-476a-cce8-08deaa3ca85f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7696
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=nicolinc@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Wed, Apr 15, 2026 at 11:55:39AM +0100, Shameer Kolothum wrote:
> Introduce address_space_is_ram(), a helper to determine whether
> a guest physical address resolves to a RAM-backed MemoryRegion within
> an AddressSpace.
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

