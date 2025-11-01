Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7108CCF9FE
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Nov 2025 00:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEzMK-0004zq-TJ; Fri, 31 Oct 2025 20:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vEzMA-0004vx-MM; Fri, 31 Oct 2025 20:20:35 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vEzM7-0004OB-Ns; Fri, 31 Oct 2025 20:20:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IybYDUJDj0Tzewf/jOh9shSSluXFwZ1j/78AA/Nv8UKjNuV1UZmfcAXoBmS6etAQVeVIPSoQWxmLu5UPxTmKS7NDTDMhko2BED16KvdvfeY051Xvwc78LfeytRyL9yK1BlZdYnzd9G/koB3J+Zwbl82TapbuKkVc197yg+oQ5YKBFs/H+YL24+XBAyxx36j/VG/5PC0doccPvG9/4Oz5Scox8Ml9XqnBjckM2h5lspwLXpJWiuKBs/3pQdB2aAWgmWOIpr+SEb/gqselaIpyidcxRAOIQGrpYs7aIr/oL//XgsQrdzsP0s+sOyYTDkV5oO4ypo76tls+1an4k+c0Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7QBAvDRAyNBPZuIkw75pCP5KHVmnd6erwe+Z730h6w=;
 b=c0OKX3bcJNXjfZPhPLkGvRPi4WpX1b0U4M580D+gD27/tb0WUdENpb366wJV6jVOCZDNPf5sV0IFYdr6CD5C8NofB/sgbH05358T82s3dXoCiXkotzLD+9EcnYKBWbNY639zraMiJDmciwYumO2UER4JFTTYDBEnQv74d628i4ilrp5M0qS/Uc89uzn/q+T6REM5R5jfoPeS8rHn5IbLFvTP0I9x9rGy1vlD6nqQ8nrHvSdyDQaqLncPO/KHvw2mj8FKrt80uyebaw8PRGjkOPaw66IkmdfLLySDHWpIIolyTT8hy4fXdqb5W/cHjR6SZKkNRp9GzGVmLl+uAAyXsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7QBAvDRAyNBPZuIkw75pCP5KHVmnd6erwe+Z730h6w=;
 b=AE0VpL2rMipfGBNa6jhX9/W3HZHHRfG14O+Rlx66RuRCqiUzLwv8zg+kpCjnu0pwpTu4Es0f5bLMvKSHqjLHn2jpqSbmx7w4w0UUizE0XtHg4WPR9WW8GRwzr/22Az9iEi5O0z4e8OR3hIkT4yAyU7GaPviGj1FVYAnOaYb5ns2rB+bvTEkuClHaJ3EOMnErOWKTat6VwfiljAsSA9MnNXi3rwZUfH99cDN3HhSYp8I8IlChNL/lsN1IzwGgqhGoMXI7UW7daptSEbF8nunT5N+fZZ2k2hYmP7KexXZIk+fyBhfhTn8Yhreh5FAjQi7PgwhTKvxzZlgANzZ0VLLL7A==
Received: from PH5P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::10)
 by SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Sat, 1 Nov
 2025 00:20:19 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:510:34a:cafe::80) by PH5P220CA0013.outlook.office365.com
 (2603:10b6:510:34a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Sat,
 1 Nov 2025 00:20:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Sat, 1 Nov 2025 00:20:19 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 31 Oct
 2025 17:20:07 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 31 Oct 2025 17:20:06 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 31 Oct 2025 17:20:06 -0700
Date: Fri, 31 Oct 2025 17:20:04 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v5 13/32] hw/arm/smmuv3-accel: Add nested vSTE
 install/uninstall support
Message-ID: <aQVSNCUGRCNLfSeI@Asurada-Nvidia>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-14-skolothumtho@nvidia.com>
 <aQVLzfaxxSfw1HBL@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aQVLzfaxxSfw1HBL@Asurada-Nvidia>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|SJ2PR12MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a98b1f3-9488-454f-7c24-08de18dc7070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|7416014|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GaSbmlo8xeF6WPq8UCJ1wLmBS4U03kIFIaQ6RjgFZui8Zh/3mVYKoI3CDceS?=
 =?us-ascii?Q?bgmwLomYZL4/9bU3Io73wlQZX7rL14CQucJmZ8nKhbHNjeQs+PDOySXOi+s3?=
 =?us-ascii?Q?oJP+sqZfcM5aIj60MF71zQbTUD/Y9/cEGHv3JBF1m6v9vVHzNGvT9oJpzqc9?=
 =?us-ascii?Q?vjH0nQht04Ur1CEgePqOw7WHQ3K1SFtmGZvjkf++yJhnCeTyYZRAKb9H1eYT?=
 =?us-ascii?Q?2nt3uFEfpFLuS7NSKFHaKXrllXVSmAABUJWdKneydEjs0K78DZvFMczOMc4E?=
 =?us-ascii?Q?EUFBT6lgJbe6/tqtzZ7XVMJyxN/m2w1BbIYWODt9bdss4vqdUov/htOREJY3?=
 =?us-ascii?Q?GGcrGAw5fqZiQ0bJ0G7qO0C4Ofqy/SjRygNTCYXDbGtmXHWKz+oRgL+Wg1LP?=
 =?us-ascii?Q?twB8O93H483t6kOyPmr7y0lp7XavlJW4EkH1wLpN7VlKURt+4YtojE+DRprx?=
 =?us-ascii?Q?WGe/Us65RsWCubyOkhty8SJdytvVkuDiesfQEGjp89x2oRNgbDckYlQXXl42?=
 =?us-ascii?Q?wR10HeQ/xz/lwiToBZYxgby1olYlqOUf/AXKbnNYr3Is8gkvsiTAdn3RTjei?=
 =?us-ascii?Q?6uiQBVixcVB8fdDqYdZJKez1/6c+uTQRsFTai+pcLsMmlzI48KzxDZm3PBbI?=
 =?us-ascii?Q?8mWryJ2cgEip4kDh38DBiUrGAbQpDrDLWAErGKQudrFyScmj2k8EeM5oayUj?=
 =?us-ascii?Q?R7+DGz3YXASzl020bwRwoKrIefGPKRCj+ObPUrNY1qcg72wPfi+lwhfCm7+g?=
 =?us-ascii?Q?RWA9787RueXl7ns5jub0BSk6uT63BMp9dYJJmybQTLwDCJGkAJX10gnwsC4c?=
 =?us-ascii?Q?rXXmwlEiBh4F1vAGiqPZPo4ksXcFbO9Q/q9vMXeCiRIuFDQmJs1TNw2rILjZ?=
 =?us-ascii?Q?6RFO/0xTZkAoSmTQ+XWX+GSpPr4Q9zd3+u59LX746LHzUDuzJ1TPG0Hz/4gH?=
 =?us-ascii?Q?1mG19b4KALyJky85x0KndySFaa5GrkOFnLRCkOe30HBfC0ilzfTXY8HC+nuI?=
 =?us-ascii?Q?MTvThmCA884kTfeNOGkcmGUs/9KFbsSN7s1+zD2/TaD2YM16LLXOmvkAwchC?=
 =?us-ascii?Q?MjbSNLI1LrcRjWS0ZaEdY05VpcKWu7CbQ9mhZK8OSBKbcrkDJ/2LgitdppuL?=
 =?us-ascii?Q?Ynh29hdLW2VzuiiM9xIrOUjza3KKJtH4os+7I4vbYVUX+jPDf6u5gJqXvxdw?=
 =?us-ascii?Q?cCebcvGrdgLYlsYP+suA1sLd1Wu7tr/yqYzuLiuy7YepHNTu+z7s/v/08OYM?=
 =?us-ascii?Q?gSSU2IXccG0HBjk2JDe4DrGnt/ovH09Z/m6nVjH4fiS2WACx/eMzLsyZGA2e?=
 =?us-ascii?Q?AR7tA2urJUc6wHlo0jf7oVxSnZGOVgR+rmnm5nlgClGh5MfG38u5eBO6LWwd?=
 =?us-ascii?Q?FivVBxJfVJnIGHdVUUcZPUgb7ULxCN6DdKBb9/aZVeE7letRRuWfnqUuzR5f?=
 =?us-ascii?Q?hfcZfuRV9c/CBN2BEBxeOz6x/hU53OXeSNQBI9KGc66fXGMhD0UF3iY0eChV?=
 =?us-ascii?Q?F4Hms1hW1tq1zQGzOhHrYBWVOT2N2Dy9YEP9RHNE3ytM43mR6w+PhDQZXejQ?=
 =?us-ascii?Q?e5/7GpuWExfnlXJSeM0=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 00:20:19.0193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a98b1f3-9488-454f-7c24-08de18dc7070
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9008
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=nicolinc@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
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

On Fri, Oct 31, 2025 at 04:52:50PM -0700, Nicolin Chen wrote:
> On Fri, Oct 31, 2025 at 10:49:46AM +0000, Shameer Kolothum wrote:
> > +smmuv3_accel_install_nested_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,\
> [...]
> > +    config = STE_CONFIG(&ste);
> > +    if (!STE_VALID(&ste) || !STE_CFG_S1_ENABLED(config)) {
> > +        if (!smmuv3_accel_dev_uninstall_nested_ste(accel_dev,
> > +                                                   STE_CFG_ABORT(config),
> 
> This smmuv3_accel_uninstall_nested_ste() feels a bit redundant now.
> 
> Perhaps we could try something like this:
> 
> #define accel_dev_to_smmuv3(dev) ARM_SMMUV3(&dev->sdev.smmu)

Oops. This should be:

#define accel_dev_to_smmuv3(dev) ARM_SMMUV3((SMMUState *)dev->sdev.smmu)

But it doesn't seem to be very useful anyway. So, feel free to
keep it inline or just drop it :)

Nicolin

