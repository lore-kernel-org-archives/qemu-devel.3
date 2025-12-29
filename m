Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9997EE9271B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 19:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaJOx-0003q6-HG; Mon, 29 Dec 2025 14:59:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vaJOr-0003hK-0N; Mon, 29 Dec 2025 14:59:29 -0500
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vaJOp-0003eY-Ms; Mon, 29 Dec 2025 14:59:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HqgdjYRLmkV/5n1hF+RibgnWcaFE3dxLfL/ymCGjvU9y8t6URUbK3oiIcLsDFSNLri9Zl9x8CNJwSJZTyZblnfLh8dUBJGD+F7EeMbCM1dZdsg3ct5KoMpcF0Ny3uwRbzVDQomVj6oIC7ozvdkUN7xiPYR3WzHS5U37XTWpyjLbP1EQoWE8HVsvsdPQSrxtOzsut0CcuteYvOwu1/JoKYtR1RV4sIpcEVN81II6I4y5WTaL7+4hHY0qFs6XV7kCkW2I/CKQUmWm/CwQmQR5eFkWo41zfDxrx0Mr1HmCmJqjYoFQ87kEpeZY2+dpDaCHlbDUkUSgqDl0dzrXkdP3H3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldg2ki9Lb/Ou9oCo5FZvFS9rikg2985fI6wzhLr6WM0=;
 b=ATM49EOPYCVuKN8yOpkC05LoH4dtWUotoxMvGPIk9hfYGg5Qwqrtmy0fIEKIAjtHpGxkuI8XSGCRc/JLxcL1UgBZ8Iz0dQlyL402GrU8WLJCijcYicbQcyuBAH2InWgoH/mrJomU6vJF/398Bkr1Jn+JvZBDFjIOYy6kaKPQpSx3nn7d3KXo32JYG3h3MJcFz/7ZZeBPbqUN+Ydd+uykk0MQeyUCh5s4QlR1kthRNZKJrill+9JQ879TbZOaICl8ITgCdiyku1Uk5BqgpE4b61/ZqJ0dMg4b40XzdRFK2TSLy/9c8tbb0P+r8CSWGkDqCjTbw6pz4ADiL6EZ3+LvDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldg2ki9Lb/Ou9oCo5FZvFS9rikg2985fI6wzhLr6WM0=;
 b=JZvloJ7xzRClBxAdzQJgLoyz+lcL7sRJbmMd0PTPaT6+XyEuamG3TmCzgwmpJ9u3FP2viZj6dLIAnaOo+/TvCI8QYp8LwtNZC2FEEW78s45uQft1sJ0q/u6XUPkXkXRJ7Ji1phUBfVR9oEvK5/LpyteWbeaNmZLQVHl2NVoEti9gWX7NCvqrMNNu9y4vdhJzS0/+2eTlk2l0Qsa+xhiH3rJ278Z0VpO0C211XaC0jdKHwE63dLRsDWyLmQSM88j+yUj3S9ZRTAn/OZe/3mpHatQCd9HI7U2dMKKxf+F/ufblf2ZGWeRfCO5aDEwDTyPFDMCY031kadHmdfpaY6eVqg==
Received: from PH7PR13CA0001.namprd13.prod.outlook.com (2603:10b6:510:174::7)
 by SA1PR12MB8985.namprd12.prod.outlook.com (2603:10b6:806:377::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 19:59:22 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::ab) by PH7PR13CA0001.outlook.office365.com
 (2603:10b6:510:174::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Mon,
 29 Dec 2025 19:59:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Mon, 29 Dec 2025 19:59:21 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Dec
 2025 11:59:17 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Dec
 2025 11:59:16 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 29 Dec 2025 11:59:15 -0800
Date: Mon, 29 Dec 2025 11:59:14 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: Re: [RFC PATCH 14/16] virt-acpi-build: Rename AcpiIortSMMUv3Dev to
 AcpiSMMUv3Dev
Message-ID: <aVLdkkv9eZMqOR9w@Asurada-Nvidia>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <20251210133737.78257-15-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251210133737.78257-15-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|SA1PR12MB8985:EE_
X-MS-Office365-Filtering-Correlation-Id: 44a4f416-0a56-4f8c-bbbf-08de4714c258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xcqo7FuWquBg32XxI+uNzPs/uGJjBm6AUIsBQuKjzrLSiy8fBwCaMWvl3Kjj?=
 =?us-ascii?Q?17Ca3YPQqwe92srJnGWNqnwLXlYjeuwd1DR9o2oAyqJOPg7YlCiiWs7jn4LJ?=
 =?us-ascii?Q?26gPRb+OWmApOX6Btcv1g1cuiHv+/hpscWI+LBg+0t6KCrWkfkPB+WxlCXpc?=
 =?us-ascii?Q?lJLzK+/OE2B/a0swSgCp7eMfc3uTs5oFGX+V01YY5DRMopbaBs6xge5uKy+J?=
 =?us-ascii?Q?gs5bLObAGOKbEbAZ2hsDbCff00q472tg/ZomBofwVm6nljGNqF4TWHBRU4H3?=
 =?us-ascii?Q?FOHFwKqnPF+iUtO/LbEXo6Ut95wP3648sWz9GQmCJIFihDZ1zvUI1t0LuAQG?=
 =?us-ascii?Q?nQg4RC8KZehU/ZfvFuiue+wUeWE8Lc7XIrx24yumyzNgD2YnekzvBiY2O+IS?=
 =?us-ascii?Q?Z95qUTKmGyCc7ZXQt80KQWU5H9q9mCBuSyHpM3EsgxUUel5JbhmhHkq//2Co?=
 =?us-ascii?Q?HMz9zqrikI93qxh4dNpvEyK0aT+rh4m6+TzCBHXapF89mUbFKjiXHQ2WJoSb?=
 =?us-ascii?Q?Wi9oAlVB7z5F3jfRWqDPsDblIisEZ7wC/LRY3qQOhxFoREJhqJJGCYezihjB?=
 =?us-ascii?Q?mD3J8sB6qDuelRDu+tBbo6LgJKqYVVFinINeUvKie0Boi4n88ItqKAoZb5S7?=
 =?us-ascii?Q?Eig9eQE/OZbjdsyPjyMLmZ2h8821jcuscDxv/GfzcTQYuHlQihgZBm6pMS0v?=
 =?us-ascii?Q?JGghw9CPEy49KY4J5UwSa3tAfeWmIAYP1hBD1rnLld3gmw5+Ue8ypjZ8VRWI?=
 =?us-ascii?Q?ca0HWRNX2lIYtkBsBzhQiUtc2tmwX7oVaAb8shxtGwvsdWwh2OfpkkYDlMMm?=
 =?us-ascii?Q?igRetPEIVVHx7VyyHEQF6Lt2RsXwhuSEPdwNQKHdpNgsfoGINMA3kEy6KcyR?=
 =?us-ascii?Q?ZozIsxqfHE3YchXmIv6aHMB/Q7G0iHMkeNgCrcD7QGta7IOgkaWJbZLkgqY1?=
 =?us-ascii?Q?bxydtadgqo/nsa/87/XLEJ6LbqzeClGrNMYvrhvy59a2kwwdqQIbjZwSCGWw?=
 =?us-ascii?Q?bEL9deWylKYHsMxrbixIA7MELvy4oUWNbmG0wqa86sXv8ECbqVsA8+35LPTb?=
 =?us-ascii?Q?oyUjQHoIHp0O+2laozh7fZro8+12afntojN9UPpqwIzXHEilyI6gXUfJqrGw?=
 =?us-ascii?Q?GhhKASCKf2mrpCrNDx3K/E9VanhcgSwQxWMXDPcxZBSX9JKmS3nQrBAUm7Gb?=
 =?us-ascii?Q?THVp4rJ93bbU99caS/Atd5Qp5Y//pcNNMfiOhjOrvx7b9tSejfTBvyST3EUP?=
 =?us-ascii?Q?JSLtJjKK7x/TFe7t0xNsrkEufAzCsZQQX8J07HXXwVED/0a1QCR6JI4OasHX?=
 =?us-ascii?Q?MsRGHcHPQ88xgpQUlJs02nxbPpY9IgzyQLkpS2ynR9wG9L7ijU3l0NWfqp7Q?=
 =?us-ascii?Q?v8sCkU1U4jiPgaFQIpGhLDYu6Ohng0n+upF1wdlM5JiR7XmfCV3ZzrMd0wx3?=
 =?us-ascii?Q?1RxeQjYafbZKVZQAs0MjfUgOhQ6uB+zKM1tQnA+p6quN7y6G3nsgMG6VlUkG?=
 =?us-ascii?Q?sd1QdS5zoOB2b47kv+ianfAGGmb+0BkZ5ZNyM35vCnebmm5lkI2ib4k/QuCJ?=
 =?us-ascii?Q?pmmcdlKIHCbx0TspNKc=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 19:59:21.7246 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a4f416-0a56-4f8c-bbbf-08de4714c258
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8985
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=nicolinc@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On Wed, Dec 10, 2025 at 01:37:35PM +0000, Shameer Kolothum wrote:
> Rename struct AcpiIortSMMUv3Dev to AcpiSMMUv3Dev so that it is not
> specific to IORT. Subsequent Tegra241 CMDQV support patch will use the
> same struct to build CMDQV DSDT support as well.
> 
> No functional changes intended.
> 
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

