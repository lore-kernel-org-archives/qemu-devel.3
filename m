Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBEC7C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 19:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkTAM-0000y8-W9; Tue, 18 Feb 2025 14:21:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tkTAL-0000ww-4V; Tue, 18 Feb 2025 14:21:57 -0500
Received: from mail-mw2nam04on20620.outbound.protection.outlook.com
 ([2a01:111:f403:240a::620]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tkTAJ-0006E7-3w; Tue, 18 Feb 2025 14:21:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TgEA/kzp+RY+HtWzcCNBKb/CzM/97KWUVrobcV2k1QBMQaETVGnJ4eW03P+OPYtOwDq4OV8e6FhXvUjNFz8u+zHK3Qznw+eCR9p2jKhArNraa0KEDJJMQrI9Y8bntauj25AcrS3RMKwdDfaWZddgNpQhjb4JSjVLJKBTwXwJQdsZL4OtLho8mtDEhpYvZf8wiQHAbi/KpEq5Lt32atdlWJ34o/rIGk8uvQngbESAG8ASHM9sgW67Hq2rrlNmly4oWqGwae83IS3zoQb2kmQCp0iwwt7e3nvqZgg+Y2gT1qd0NDfKB/pCAgPSNnp5LuDPWULH8xQIvr14sMZLygXCMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phVOR3vWw5KeWTzx+0ZwZKsI+ZyZTWXHdcid3T2UUic=;
 b=SAU3Z1I389R0rxrmi02zxu5T0u7R/Z06yFOzoa1N3HULOO/h8e67ln4/kX83Ni5nH2mlkM2JCsEQM1WTfVe5TsIvSvlK5Kn4UWx4f9ydKrh0FVagaEqqNW5pXmyuO9Z7rEpCIpSSASnnjQ8MrEuHbgEmeYfFXfiz70taLCxWPNkexYzmu2PBn8kMEHddZ37idlnqfMjJ10RT5TuoHwnJtZ6nNH268LeLOb3O/WwVGQN9ZqGuSOsRh4S34ktcu5VpQ8noEUAK2HXnLvmCp4RlSbf6xLWiq40rI3V6PbUIpg1cZdbLD+sDpRWk+7k/9UK3DC0mFV1vejnOYIH+ZbzCgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phVOR3vWw5KeWTzx+0ZwZKsI+ZyZTWXHdcid3T2UUic=;
 b=Voecw4Hroc9MdShG42rlFMrDbmo/fK1VRnqaKSI37m3LVs1DaiW7H3N5ElXtyRQdv+lZc5+y6l5ZHRuSx8OVcPfO5Pp3bgS1gaO4EoA9uN9RArKEJwo+0pIXqYM8sk985TuzYyARGyiwrO8V5i6UBpxzqTgr40rI/Zn2TVoK9y2XscknjRikiQinBpNmdASFSCQszxtxPqrwRD3WcRzyrPwqhutccLJQVtNAq4wrqRQ02lbxGJGlGSNYWMogNAepNZRHWIsXNfmx2gtmMuVUGKkI4iSJzQmfPjP4zD3F6NTfaxVC6K/ek+ondeJpBKk7Wul/diGOeV6lh1alLYVQiQ==
Received: from DM6PR11CA0008.namprd11.prod.outlook.com (2603:10b6:5:190::21)
 by PH0PR12MB7862.namprd12.prod.outlook.com (2603:10b6:510:26d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Tue, 18 Feb
 2025 19:21:41 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::54) by DM6PR11CA0008.outlook.office365.com
 (2603:10b6:5:190::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.18 via Frontend Transport; Tue,
 18 Feb 2025 19:21:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 19:21:39 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Feb
 2025 11:21:29 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 18 Feb
 2025 11:21:29 -0800
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 18 Feb 2025 11:21:28 -0800
Date: Tue, 18 Feb 2025 11:21:26 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Matthew R. Ochs" <mochs@nvidia.com>
CC: <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>,
 <eric.auger@redhat.com>, <nathanc@nvidia.com>, <qemu-arm@nongnu.org>,
 <shameerali.kolothum.thodi@huawei.com>, <ddutile@redhat.com>,
 <ankita@nvidia.com>, <philmd@linaro.org>, <gshan@redhat.com>
Subject: Re: [PATCH v5] hw/arm/virt: Support larger highmem MMIO regions
Message-ID: <Z7TdtjCd9dBNesJK@nvidia.com>
References: <20250218190240.3070040-1-mochs@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250218190240.3070040-1-mochs@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|PH0PR12MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: d1c38756-9191-405a-0d8f-08dd50517882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l4wP4io1aoS3OmABH6kC7XyZuGe9pCEO9bjmYh2FAOjHsTOwatiEIwQ4rRfh?=
 =?us-ascii?Q?Sh+vOPgVcm8jGAGbX/OqpvtJ9VBJvVqLdzHE/nocVTfJW/cwLe/xPz2gvUOe?=
 =?us-ascii?Q?GGniVGEAYxFcSSYZOMiIWDqq0Yi2amcex7IGQLAs9ypFtBiL9Z3Msg760R9t?=
 =?us-ascii?Q?/oz3UbXwHhzsh2tALvwlFakpOJIBPTTNirbydPCNsSrN3YtVGpR4IN+KACEs?=
 =?us-ascii?Q?38MdqRxus7OeuLNr8e0TModar+Q5TIsq1xRbqfna7TjCSmIIUjnShngaaADV?=
 =?us-ascii?Q?ZpHhFqX52vYxBKRc7rgwD9tCgzzvp6az1tW4dJRBLz7DPsD3G56ESeLeyuxN?=
 =?us-ascii?Q?tGAw5hUdP6gr/407IAly41Vo9YvMOvJeXiGsVUThDzj24Flh+BWqeYnHGcD4?=
 =?us-ascii?Q?AeG3OayjAJPR1Jwjhy1h1SJuvjRb4lZrvfjSqzaI1Lzv7RRYqFzJWsZXN3Ll?=
 =?us-ascii?Q?1t2dZUq9je8QR4RVqKi6RJ8a3lTTg0upvZrs3GwnWdLnA+kUBF4+q8qyD03B?=
 =?us-ascii?Q?zBseVcIvUeRFbZc66o3jno9VpG9/4NVQRpl3FsrWa5FOwrTmjucdGGNIMtHx?=
 =?us-ascii?Q?0cWioqgfcDh81pskzb1yFnw/mjXowtLttyKFgnFVumPg3kqVq4gbgAbH1etd?=
 =?us-ascii?Q?fSZEj/QanTOKIXGlDg3sDNHK84yRGlV0Acnr4PsFizOKYjUBf9k7XiaW25WF?=
 =?us-ascii?Q?igiWDWofow8Zj/rkd/h6zNve030+Ezn/id7dU1Xsd5LuI+5BgZLDvEjo7eam?=
 =?us-ascii?Q?FZUv5TvgoV8BrkrL0YX/JnfgYkwXTai91ldlmK1Oq0G9zxLvT+rUCiU2soB6?=
 =?us-ascii?Q?ady2Y8v75M2IAH/FRDbi/EcVA8g83VDYqe8hRVeG1r+n4BHwgBUKILsZ3nCy?=
 =?us-ascii?Q?YRQuhSMWZTphuFKxM8V3+6tuhSBbqXqYozafJYHvFm1yPTA5m1YvchmjcwLP?=
 =?us-ascii?Q?jtL4OHLZ7aR3pIhR8tvnC+sEfWkKgTmJqdtPJtLdoMV1MlAgDwyWsAhq717D?=
 =?us-ascii?Q?FfCNE3ZlW5TGNbAlRkS6dvRysFXbTVScQS3ORaHEilwUBlZHByqWMOJ8BdTX?=
 =?us-ascii?Q?RIW9rm+F7CKZzezFA9fs4yi5U118hX38k0w+lEukfQ7HjN7qYQ3Y/4tctuqa?=
 =?us-ascii?Q?7U0NgdSNhGO/b6MUdOh/E4H2mzQMzMHpzP9SPPG300zl04jrKSaFLOTPdCVg?=
 =?us-ascii?Q?rOlh0CiNUUU8FxjIdrpbTEZJHks3txqz+WcZggxNaBJKhkF5W7cOzRCy0Hbf?=
 =?us-ascii?Q?MqV/vjNfwnKRu4agtkNiFfmeOUqZRF99/VumusYOUBBg0A8MVFO4+zAjWhy8?=
 =?us-ascii?Q?dm5M985xbTKTri9akVCHfUIyXuaJybeWdzihw7e0/CR+YrHvH+UUNMGn3Shz?=
 =?us-ascii?Q?Onl6u95lrol+ulik8tGzD4WQlUkef4H1wcDue65cTSbV3NsMihzheQEgVd4P?=
 =?us-ascii?Q?LLG5OaoNFBgFImeK/1bVQiT59iijsp5WvnW4RZfLf9yF8mM9cxczApNrzSwE?=
 =?us-ascii?Q?4YDVBkdeP3+dSbY=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 19:21:39.9434 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c38756-9191-405a-0d8f-08dd50517882
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7862
Received-SPF: softfail client-ip=2a01:111:f403:240a::620;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Feb 18, 2025 at 11:02:40AM -0800, Matthew R. Ochs wrote:
> +static void virt_get_highmem_mmio_size(Object *obj, Visitor *v, const char *name,
> +                          void *opaque, Error **errp)

Just some coding style nit:

static void virt_get_highmem_mmio_size(Object *obj, Visitor *v,
                                       const char *name, void *opaque,
                                       Error **errp)

> +static void virt_set_highmem_mmio_size(Object *obj, Visitor *v, const char *name,
> +                          void *opaque, Error **errp)

Ditto.

Otherwise,
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

