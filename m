Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D4BCD98C7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 01:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXqhA-0008Fm-Qp; Thu, 11 Jun 2026 21:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wXqh9-0008Fa-6z; Thu, 11 Jun 2026 21:28:27 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wXqh7-0005hR-FV; Thu, 11 Jun 2026 21:28:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xwW/rPiPXyh5kagqFzd7KRTN2mbJAiea5xWydPcYnrV0LKrAEzmD7vRAgX4GlqOHXEZQ1AMSBK1ZLxvjCXEKeSPnEYW2kON+WMBHS6gVKxSeXVnatQW81Pi63ZjdfVlbuHQoLuCBKwx1pYOi5qO687YyIudxe8XqyKN8w0AYi97AKbmiY9KnqpgZ2OBJLWU+UOB+lPzL9MIA03MQsyfgxAMZD/32cbyRFw/aRn9bgZm1Vgp2iPPOysgFdWm3o+h94X/+C21GaOjTGphHcoBCiURTSBYlYYrtpwfFqXhmgQfaCtgI8+BcldyU7IipKHTAfQtMb3R+k2xn07CeN5pZyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQC/o20VQ5FamrcJrauSWPdlS0V8dsW6N7bqaUNIWn8=;
 b=u8TRrO2XnZCTCbSyzNuMJUeAAwF3FDAnIlDssYfYYhi52SaxaSOZePiq66N4OVeGMdTGCifj3ysLzAhSp3VGhZMei3b5MSLViTu+P9gWSfE5Qd27jY2smimHs0YGLnwL8L1FUAFDzskHC4Xfq5mpD+SWsrLmaTSE30EjLV3UmYyDxkCqCiD6u0XloFF4oKwDPtSkV91iM7s3B7EJ7AKtZwD2BPdybRV9DBaNwMqdrEJFicXais6n5mHrxmhNRx0PywHtxSxI2tqn5ogskuPnl8PjlKee94uOFMQZ9aRSirWoFH4I7AsHcjBa22M9QWMXGydbMR4u3lJxFND/GEQ4Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQC/o20VQ5FamrcJrauSWPdlS0V8dsW6N7bqaUNIWn8=;
 b=BeCWDWHBuMfQDzY1H58m5QQvP45zRE4KkeP+yQZyYS3NCnbjGABfR6q9MFug19afsbb62gMl0/eyogrZ7HEDmm7kP2/6XjwCoJIvuyrW7fLf9kY337OzFJ4LXNA/MtOy7C6OJwP2NVf0cV5muIAqOtMjPLbQJnBjiCbEwA1uK+4qLQvSLDaSRb1n3LlWZ7e3EDFh/+tmoxtTd9DoL+xSqpCgHX4/0239kxlZJaxmmU3yjZpGP2LEHv1F0qhIoIrbgIoSTX5Qt48ekzK/IQXXYoI3OVCGKU1Jeja2AJ2rpMYQ2OaL5SijgsWUG1Fjgr7H8xYFBVxlch9VGBTeTvJDFA==
Received: from BL1PR13CA0136.namprd13.prod.outlook.com (2603:10b6:208:2bb::21)
 by LV8PR12MB9081.namprd12.prod.outlook.com (2603:10b6:408:188::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 01:28:15 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:2bb:cafe::62) by BL1PR13CA0136.outlook.office365.com
 (2603:10b6:208:2bb::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.5 via Frontend Transport; Fri, 12
 Jun 2026 01:28:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 01:28:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Jun
 2026 18:27:54 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Jun
 2026 18:27:54 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 11 Jun 2026 18:27:52 -0700
Date: Thu, 11 Jun 2026 18:27:51 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <clg@redhat.com>, <alex@shazbot.org>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>, 
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>
Subject: Re: [PATCH v7 19/31] hw/arm/tegra241-cmdqv: Route allocated VCMDQ
 Page0 accesses to the mmap'd host VINTF page0
Message-ID: <aitgl/dvBMAZCBFK@nvidia.com>
References: <20260609112552.378999-1-skolothumtho@nvidia.com>
 <20260609112552.378999-20-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260609112552.378999-20-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|LV8PR12MB9081:EE_
X-MS-Office365-Filtering-Correlation-Id: 697f0b4e-58a9-46a3-65c3-08dec821de03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dDlXjXpSnxwzlARYPD3aLg6ySGqeM7tOLnpnFKUdHvYb2W7zFSqM66ZSRP2ugWVkRLD0NinuFukKdxT70+NOZN7MSNIzufDYg/OK/0dB8BU7YKxsb5l5AaIdRabzj35XY/8SV7+qUppIEG52PI2hABzQ70Wwp2ZgK0VqT6b2Gpe+WLiYavVzJCLGmmjTdmvaXHSlNBlhKbBfkXroBcXbXbdq9XbL5kdgedX/UOVZEy/w3VKg/mu5wh9z1x3f4x9PVhsOjd2IOS2F5wemJ/LyXpDj0K9BZZODoPuvNtX+WfXZtjJ9qfNZoK/+RaheUDJHp2ILNbpX7+bFp9KWnFRpIFwgPwTb1Cpx9bFWsM0W060EQ/nGYdRMTrXU4zDfYdGpjoYpZDn/7XnqBL7J+Fajqh2/mJKFXzFLqnxOnAoM9/9hqw8nGTSh4L+BmAK2dqX9ZHrH00tBpucuSE1qX0QfWqZMHbUuUy0cssjdLsV5WtqCdF3PmcIuUBPvfUhCRCkXBftgYJzRrT0QV1+nGLfM3mFB4BTvBLj5W8KkvuEzp9UwrOXbNa1Lv9X2PxNOJM8/DHFhZ6ubE3+fuXrEp991ctlWSZPk4lgn1Tbar89RZZAxY4KM6cFPxNuLtn2d9bhmjzghKZbXOxPoOGSEnter1IQP2rxeWYC43VoQAcvoDaHm4RnseNGTx/Q3B/nOQLwWgZE425bk57N5PJM1XSlsNUu6jCPjf7jO4I+2PKJAHqw=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 24hTR1pBPMW3I15GNYgdjYxJ9Wv2R/dhFnCo4ilHHenBzK0teSjEzFCNhQGsBPe+NC5pE0DAvVt8dnvTA2Jlu/+pFZLulIoFq7DHosu0rSo7hoCs0M83QvVvgdoxAOcjA5E1u+cA9yj9wSi67tNdupyFwEodTbdISs7JzxS0rK0cE2MqYWFd5TzC8L74X9J21fyx12YMqRFO5TXuH/eirwFazmpXvjYgWpLj7QujuLA34zkQZF37MYa8HiP+IpKExUnprqEG8bxGaMTso2yIW51V9sEmtIN6RJqlkfOHeYA3vvWlV+afMTb3zoEXTsgiZ9R1EOeOw7u5q+wFYN/5JBqTz2LULlF3tPd2WteIcsBKnfHhkF8hU/hZlG+MoGJUxvj0V6vtIUozkniBioTWmMWC9RjuxcJn7X2AKm7e/B5jTZq4OcmCYSIP2Ye6wlEd
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 01:28:11.5586 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 697f0b4e-58a9-46a3-65c3-08dec821de03
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9081
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=nicolinc@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Tue, Jun 09, 2026 at 12:25:40PM +0100, Shameer Kolothum wrote:
> Introduce tegra241_cmdqv_vintf_lvcmdq_ptr() to route VCMDQ Page 0
> register accesses through the mmap'd host VINTF Page 0 backing once a
> hardware queue has been allocated for the VCMDQ.
> 
> The two QEMU-trapped Page 0 apertures (direct at 0x10000, VINTF at
> 0x30000) are hardware aliases of the same underlying registers. A
> subsequent patch installs the VINTF aperture as a RAM-device into
> guest MMIO; in this patch both remain QEMU-trapped.
> 
> The direct VCMDQ aperture stays QEMU-trapped (rather than aliased
> to the VINTF mmap) so that writes to an unallocated VCMDQ remain
> well-defined. The CMDQV architecture allows software to program a
> VCMDQ through the direct aperture without first allocating it to a
> VINTF; aliasing to the VINTF mmap would route those writes into
> unallocated logical slots where the hardware silently drops them.
> 
> A VCMDQ Page 0 access is served from one of two sources:
> 
>   - Cache-backed: no hw_queue is allocated for the VCMDQ
>     (HW_QUEUE_ALLOC has not yet succeeded). Both apertures use
>     QEMU's register cache.
> 
>   - HW-backed: HW_QUEUE_ALLOC has succeeded. Both apertures access
>     the registers directly through the mmap'd host VINTF Page 0.
> 
> tegra241_cmdqv_sync_vcmdq() copies any cached writes (CONS_INDX,
> PROD_INDX, CONFIG, GERRORN) into the mmap'd page on the cache-to-HW
> transition so the guest's earlier register state survives. Freeing a
> VCMDQ clears the cached Page0 registers.
> 
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
 
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

