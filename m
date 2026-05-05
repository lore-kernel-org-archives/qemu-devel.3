Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AEF8FF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 01:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK4cv-0003SE-Is; Mon, 04 May 2026 21:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wK4cr-0003RQ-EL; Mon, 04 May 2026 21:31:05 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wK4cp-0000jv-Jk; Mon, 04 May 2026 21:31:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hoSAmxDOzk/MuI9+12sJSjvNjlIx2Xr5W5h/WClbNUAKi+Mepc7EKmHhbJw/W+Mv302xLfl2J5MILCp7tyrCBlf0hJPT9e89Ig/pp59PlYgyLHHpwtxlo2zZhl0e2hE51EVbXNoht8qdG/WO1zfiJrY7PPVW6Cy+r++y2HsznruLK5ABUTm9G63EgPFexWipyXVdgnH5u3Q+tMkdz53D77kZ5czDLWy0sqRW5tWYaei9rXWHysPvkxo7OLYZuE1p2nEnGRCtD/2LMcZuebL7QXcNRFWLtrJxqFsgs2W0uJkpj83/EEZr4GO1NNaOkbYByJLzm65ap7KW/EVMZBuSSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHABl5ndncxJWx/W0T9hBZy9lgD7C1kUa+rwV/d+gkA=;
 b=VbviUFEQeyobwiiBzD9gW1nihdYhynj3K94AS2OTM5VUe2faxbTrAfp4jcDgIyxL52R9Zy2iWtR8hUhGckqUrNztE7sEp7nMjp7QL91EjsC9CNvGSHjCSvCbWHF7iOvt771h4nQ7C2fXOrghsyeUfgdQnkc/tUFCXO7nGk6Ipdc74+v55vSIgvkzmfvoZvCXRVor4G/RF06nXyeotdcjPYPB+Bv61JspzRKNYnevSpYnEShYpWmx76wnhdXAeL9LZM4T6Xf5QemMPYeGWZvv1nU4EB6kk+XwpkBebMwcLGXBMA9NueUmkgj+eAspHmqLIXRGtzpAwNpfzTQ1RBcdvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHABl5ndncxJWx/W0T9hBZy9lgD7C1kUa+rwV/d+gkA=;
 b=o9f//dPEF4QHEv1L73oiq+0tRKSovHcN1QHDY7kANFqShDEpnhULO0j8e9iTE/G5XLSQALb7yS74n55n5l7/sL0Eg969saOtpPtudfeDRgTUdNDR4eTjwqWcU0Kflfn+eKVRF+4t70CFibynnhjLakhOEbXuF2mmk1VWXayvc42CWks4pr6t04BcwtM3ln0AxdY61Kp5RzNoY48TMqDkilsHUFEkoUqrsXEAC54Gb8kCX4QuspSP+OBTqrZfgIO6hlYVORi955tL7S/WHFd9uMXkUx/mIqIw4h+XzW8nb7oDeVu5vKr655Hg23EsI+5ivI9aKo+VBMc1U/EeBi+KIA==
Received: from SJ0PR03CA0083.namprd03.prod.outlook.com (2603:10b6:a03:331::28)
 by LV5PR12MB9756.namprd12.prod.outlook.com (2603:10b6:408:2fd::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 01:30:57 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::97) by SJ0PR03CA0083.outlook.office365.com
 (2603:10b6:a03:331::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Tue,
 5 May 2026 01:30:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 01:30:55 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 18:30:36 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 4 May 2026 18:30:35 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 4 May 2026 18:30:33 -0700
Date: Mon, 4 May 2026 18:30:30 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <clg@redhat.com>, <alex@shazbot.org>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>, 
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>
Subject: Re: [PATCH v4 27/31] hw/arm/smmuv3: Add per-device identifier property
Message-ID: <aflINq9B1Mm+7zDp@nvidia.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-28-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260415105552.622421-28-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|LV5PR12MB9756:EE_
X-MS-Office365-Filtering-Correlation-Id: e1ef118e-480a-49b1-0c18-08deaa45f442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4N0NEpBNVGZXtJS8O1dlx9IEzjgP4Qsm8GU/agtbhABI1v9BvvKOZBOlDC1y1rF/LagtiF3Ofr7kZOtXWimMUEnYG91UoOxkre5Vef/PoEMxqqhpUPkM2VF7lVdcUSw3Fmi/lhpsMKWOm9aMw0/T7fflx76b9P4JX+BZx2K23wKwvpyj1ZyZTar8xY9TttGgx+yHAW5Je7mSHGE6PaovqdRK9Z2slyLZGj2b5n0nGbCiMxiTgEfQhSdRsP38D2rCulphVBbNXyyaAgaMjOo/W0GD7UmxeRTF4BsuKThn4osJAOT3BkMI0tp3PegO9ueFOyupGipFqb+S/yks/IKpCrYNTkh/C6Xn41LqSghWWM8FxveP2zXkXmrwP7hdnFxLXtYx1KiStlwpQubxnUjo+wkr34uFr1S2H1I/UZf3kfinxP6ECHupIo8xVF46DshN9cvnEgcQ863fxJtv2llFodZmoboG8wdvIUyqrW4j8FPrqWFz71eIldmEVdYzv4BjqhHcrD+5EDVPxanFdiJWKkvqpDIxtPotfx3BAlIj1njcb/gwvBU17M5k6gwR/HQEH3nQbCj9WetPQmdcbss+62BTd/4ZSdIqqrq9TEiiHQWoPnqQM34Gq7wYZ24N0xrjKKAfvoBu5KnScGFikjNVSMfxXbpOZp9bTHPDdy7B40m1SFAvG2WYMIBmZnbqXV6JD5V8A1po0tNgCow09HKd8nKyqQ0wuiJB5gi9Y+LMjkk=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QBmqbhDmUuBv/ZTMBbfMspxfOgCSdyKHQo6H6QQfJFBvsA8FEYj0AthnXY0JdrSnbB8tzlp1Qew9HZzKIjwgb6E0q88OJE8XlbrcXOWc7P2TOjD1n0L6pPNwS4iF1SbZrldi/ZzrAfeNiUp2i2LycOVg/IuMZcHjIpLkvl3ovWZJPiBnBHcWt456+A26QM3+TDehACNb3emaApJKfhzf9vYdaolWjYio2biqrDxZnT8ziWxV25CcXBH2TghX5pqOAdJvlaDZZzuqAHpPpsnw+Rto2d2isBOEj53eiHrQ+dNdqoatgc9BtKrM90EXOCJIBYdlW7lEBe1On/2g6Z9gt6MMr0v2nWonBsx0e7w/X+ttKHuVu6mqW8BZ0RlypUZpbrFqmECszFUieL1/TOYe70ov1De7lcEBO+aRvO2Y2DNET0ESITA/oOWrH6TlxbxZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 01:30:55.9309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ef118e-480a-49b1-0c18-08deaa45f442
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9756
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=nicolinc@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Wed, Apr 15, 2026 at 11:55:48AM +0100, Shameer Kolothum wrote:
> Add an "identifier" property to the SMMUv3 device and use it when
> building the ACPI IORT SMMUv3 node Identifier field.
> 
> This avoids relying on device enumeration order and provides a stable
> per-device identifier. A subsequent patch will use the same identifier
> when generating the DSDT description for Tegra241 CMDQV, ensuring that
> the IORT and DSDT entries refer to the same SMMUv3 instance.
> 
> The identifier is assigned at pre-plug time, accounting for the ITS Group
> node that build_iort() places before SMMUv3 nodes in the IORT table, so
> that identifiers are globally unique across all IORT nodes.
> 
> No functional change: IORT blob content for bios-tables qtest is identical
> to before.
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

