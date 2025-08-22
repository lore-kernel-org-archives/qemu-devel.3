Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474EFCA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 22:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upaC0-0007Js-Ie; Fri, 22 Aug 2025 18:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1upaBx-0007CO-Fq
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 18:25:02 -0400
Received: from mail-bn8nam11on2063.outbound.protection.outlook.com
 ([40.107.236.63] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1upaBq-0000au-Bl
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 18:25:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crx82ZwnRCBJKIO+LRF+y/NVw08Sa2ZEsd9xXfxtRo8r+c/NcXw+T1rzysWoApduHj65mainBqjpwiJQAjRD7PdElFXUyLF2wbPBfjhgV2qVTe3TbnvonfC1soXCHWf9llz6LZ3xfr7iXDUipGEsME03XUkLaeL0eEkSGYnEQxBp6DPrxIjNGx377otEYA0gyLiUoVV/c7SLRFZxIbKPLuqJMb9B6FhT4HKG5ftRMXGkBIa1gKtEmLPhgPlOrPeUyyNVv5KwtiC4ckwfH8JPedAxbSypWVrQGh1GgHMb/NYQtye2BwFO8unAzkyGo7U9HG8rEfBJa2wYG/JmQS8tTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9xJA7xdYQpGT3+GTwi7pNtgFiw5G1CwQiRDC0lRfZI=;
 b=IjIsv3XSCX7n+4vuFfiXGUP9CdONFvat6UKBAWZpnO0da9lUsV1eDjxTXLhu/DAR8TImhLGfHlqg5Bu556YrkNR2m+ToJeIyxn6FwqtJ8MnM5LgCO6BgfTGEhYyYegZKatEomFOHUjEiK7gjZtNb52SlbA+9SPuZSqgtE1k4ddWMu0epEtL/u0U5Y5fJ1eg9dESxtfPYJy7r27sO0GaRnQiG5BtFEWNUqsd1QHbh6PuDQYKC5UUpsUXsbs1o+LRlmQrsdcstHOWoDIDyaVAIsZOS0HCDznMa165re5Kn46poxeSabvs4dqUM/2zCWrJM/g7cQMHgMIbX8czPQGZoew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9xJA7xdYQpGT3+GTwi7pNtgFiw5G1CwQiRDC0lRfZI=;
 b=DsrCZ3osYRpHrjZDkntTx1OeUjQvjZHQVpPpX0aYA9uBdc8YGLH0ytjWhnTCKRr6HdkVJCYBkY1RSb6wjpgKjspluUKcHrUYIvRDRXjfPhlrILx31MK7OvtZdphBKQyOjpxr9O17n92y8xyXPQT4Zt0UqyqgAjK2ZK1Ux5KK5yo1eUwaa3qSbVV7o9u+4BVOdc9NJnZ2+lM6VyhOeZxEw7KP66g2LUbLi3sK0UwpFVG3SromSRFpxHoKsqM/i72bqvy3eGJWydfETxTWLig7R8LeMZT+uTr1Un/yYFxZ/eP7qnrkEIYFAeHrzdQ/XZDEFRCuZ13GbN8l14+xyKod8g==
Received: from DM6PR08CA0051.namprd08.prod.outlook.com (2603:10b6:5:1e0::25)
 by DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.18; Fri, 22 Aug
 2025 22:19:41 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:5:1e0:cafe::54) by DM6PR08CA0051.outlook.office365.com
 (2603:10b6:5:1e0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.17 via Frontend Transport; Fri,
 22 Aug 2025 22:19:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 22:19:40 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 22 Aug
 2025 15:19:32 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 22 Aug
 2025 15:19:31 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 22 Aug 2025 15:19:31 -0700
Date: Fri, 22 Aug 2025 15:19:29 -0700
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
CC: <qemu-devel@nongnu.org>, <alex.williamson@redhat.com>, <clg@redhat.com>,
 <eric.auger@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
 <peterx@redhat.com>, <ddutile@redhat.com>, <jgg@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@eviden.com>,
 <kevin.tian@intel.com>, <yi.l.liu@intel.com>, <chao.p.peng@intel.com>
Subject: Re: [PATCH v5 01/21] intel_iommu: Rename vtd_ce_get_rid2pasid_entry
 to vtd_ce_get_pasid_entry
Message-ID: <aKjs8WHmFDIxxUh2@Asurada-Nvidia>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-2-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250822064101.123526-2-zhenzhong.duan@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|DM4PR12MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b6a20c7-b27c-4d49-fa6a-08dde1c9fd40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|7416014|82310400026|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?mzq+dYv6kFAM0CAE3zWKRS8icGhXoNiQi2BZTpQ2KMyG8sM3Do7qw518Vu?=
 =?iso-8859-1?Q?oPiD0X6OEQTFkEw10RhbGg4mjsvaYSbZYvVqHOMk7B/PHHekwUUDPGwj6g?=
 =?iso-8859-1?Q?jP+5d/men5C/IwYPAafdWD6wuDoCMQqcvieX8r1g5Jx900O2ajh3oblZUd?=
 =?iso-8859-1?Q?WlqALm83hm9MJObs5sUm6rnO2noNaqKnOMfHZkJncrHi6fo/vWw7lGqX+X?=
 =?iso-8859-1?Q?/VZql7FL30Groqw+exvPgB9WgFCcU/NNmmgtbbxxybOhXIID76PqLgZ0/R?=
 =?iso-8859-1?Q?6TB7f85XXQTzOqsY63OPzxrxxVQ0BMfudYerPLbnAVxjqShpnjX2Q3QaCQ?=
 =?iso-8859-1?Q?7sQ3MLeMHv6aFkGhPKLpwQdKLtnvQLj6eWC4sbYBbDTA1IbQ7xOwHt/sVW?=
 =?iso-8859-1?Q?1U80xfHI79Fis0NTBklqB1zHLBXkZicW9EkfPChhMQcpIWp6Vqu2PiozbO?=
 =?iso-8859-1?Q?LnwqdNA36Ruu7FhPaok9B1jpsJZaOwS/NZ4coAOgYaeN6eSk828ZZL8P1w?=
 =?iso-8859-1?Q?LI+Ob5M1SsOgU1m6JAroFnR2A0nxxvJeM+3sDm//Y66LeMXmAofImF1oe/?=
 =?iso-8859-1?Q?soAr6b6LWhQ3k+ISQotDa2hQJ91aDPbWHUB5c/ayIu/NIiaIGYgpMfcIoK?=
 =?iso-8859-1?Q?QnLXy1TQfBaSrUPV+K/V4NNpZvuwgQRohbbK6xhirjCS7UaqRtakWtVFW9?=
 =?iso-8859-1?Q?snIJoQbem29OsoCYobUMhSXkn8OSkXeEPJXKn446JzENEJOPSxVw0Iv18g?=
 =?iso-8859-1?Q?9nyeC9I+p3+gMt+9G4AgbWRKM6HFylmEtHQeV5x+GYKfCq7M9IPJQ3Zg0u?=
 =?iso-8859-1?Q?CEYWIkAvWpkmwUBQ5qUkUpCE/H5ATW4FpiHwCNbjXd1mrE8MwvYEScGdqK?=
 =?iso-8859-1?Q?UzIeAG7Nmkk9L+8Pg3pxWNk7tpgwdE9u8vwxiwymG7fTQTS1ZLv6RMQWMA?=
 =?iso-8859-1?Q?cu+pQ25u8lHfcA1O+B03r1yHypH/9LxzuQ/w/LqsQxdhj6g/OzvgLO5DHs?=
 =?iso-8859-1?Q?xnBAhU5DRNHPjOOSB/3fWhA0qeDBjMReK7/UrxNYHY0MhiU9hMC229nkDm?=
 =?iso-8859-1?Q?2JmWCyXdHbJ8/TPayJoVhropRQTz1KxVzNYhRY/y12q71FDbHUTxUMJl96?=
 =?iso-8859-1?Q?HjbKLXMlY2VjIBYYN6fGV05sDX0u1sqVOGhvJgys0YreSsL6ZKKKhpc4Bl?=
 =?iso-8859-1?Q?zVckNLMjCmx5aQTlTbHjEi/v4leoVJnph1Bv7YaGeW9XGqEEdVeicsXl5J?=
 =?iso-8859-1?Q?Vb6L4SXggnz1jAQJcls4CffUFdzzv2+TrEE1hNhi4dN20y5ffHyXHI88lY?=
 =?iso-8859-1?Q?uZiRkVCJ+kRR/EDmhbV64FEH4uFajEYSevgTwa5scA8XYK0yB0cWAFPUU+?=
 =?iso-8859-1?Q?IiuTc35FHay1SReIQq9EkQkuVDapYBrZjbbKiv6HP6p/FvCwQrI9x9JgL7?=
 =?iso-8859-1?Q?KTYhZotrNBPH+zkDp258w69PFzXzO4GH9wJxbGlEG2530x/lQy9Ncdtekb?=
 =?iso-8859-1?Q?X4UyQlyHlCy152gUjYNVgBNJkYIIWzWUcPkHUpOhlY0w9Ajybw7khYG5G1?=
 =?iso-8859-1?Q?91Ezp+aPo7dMkeTBO4onZWgUelAj?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(7416014)(82310400026)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 22:19:40.8442 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b6a20c7-b27c-4d49-fa6a-08dde1c9fd40
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7765
Received-SPF: permerror client-ip=40.107.236.63;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Fri, Aug 22, 2025 at 02:40:39AM -0400, Zhenzhong Duan wrote:
> In early days vtd_ce_get_rid2pasid_entry() was used to get pasid entry
> of rid2pasid, then it was extended to get any pasid entry. So a new name
> vtd_ce_get_pasid_entry is better to match what it actually does.
> 
> No functional change intended.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

> @@ -944,7 +944,7 @@ static int vtd_get_pe_from_pasid_table(IntelIOMMUState *s,
>      return 0;
>  }
>  
> -static int vtd_ce_get_rid2pasid_entry(IntelIOMMUState *s,
> +static int vtd_ce_get_pasid_entry(IntelIOMMUState *s,
>                                        VTDContextEntry *ce,
>                                        VTDPASIDEntry *pe,
>                                        uint32_t pasid)
 
Nit: it could be re-organized a bit with the shrunk indentation.

static int vtd_ce_get_pasid_entry(IntelIOMMUState *s, VTDContextEntry *ce,
                                  VTDPASIDEntry *pe, uint32_t pasid)

