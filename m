Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70242C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZGGf-0001rV-Ta; Tue, 08 Jul 2025 17:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uZFNu-0003Ng-Mv; Tue, 08 Jul 2025 16:57:51 -0400
Received: from mail-dm3nam02on2062f.outbound.protection.outlook.com
 ([2a01:111:f403:2405::62f]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uZFNs-0004au-9V; Tue, 08 Jul 2025 16:57:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQEk40bf2NS1cafuasGW45zDPRF2eS39q3zFqqpizFMxCYu/Ztz0lDYjQ4x0TjQqidnVgyJuA3+7JHXxEQLTch5ncjg/AyP6fdI+kdOHlkUcIZk0KYSySG5Faw/hFn3lxUAWbohorYWEqD3zUzkVE1TLR1HiUAmNqdiNi1ESB3PvkDvH6KZtZwhrsntREaT8fmjJ+0qMLR1s+ne3xaKtad1Iby6kp8+PMOyrN60TzBuvK9g0wBGtGQOQKAULJDDbVvb/PR4U59lP739cMdiZL72C07QauhPMhY+LxtpiNkH8HWE0Ens4sAaZS5iVR2mHGsFaQuY9oEZ1dOwgEhrl3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kK9jSARqPuvWbl5749UosbYAUaWsHaHrNSagQNp95Bw=;
 b=D9JAq3AYRvjaUWe6+fJ/fc248xrCFhZ5KBUT6zM4HWHT19y2e35tWBXLeYHq9Y34zIf9hYp308gRv3u6QzUe/W4AfXC4UK6k48dotcguY2gzaO3H66+2o0nGpDDBNipiAmiuPY2Gw7CGopFqA26ld41P8orRZFM13UvQ+f+AHXUXPHXus33pga52sFPyJuccV8j/nDRBf3wUg5adDivDcKYvs/L/JO9v4rCNGBEO5XTiBxJKgC91jC3dMhG6V6M8ICSJ/prLUEELliay9s5i+kwmkjLe8PnC0QYIjT6rDzCemFOZwHZzkOhwNAfoHcJDkyLs3QT1P6jynsSvf5ZFTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kK9jSARqPuvWbl5749UosbYAUaWsHaHrNSagQNp95Bw=;
 b=e33rpU9bl3pZg7k43EICDgwRbr3qjXSvrSrDdcqmtp4NOHGz/DuOXg+0sVpwuGlwYtRCDAUxswIJGcbfXhR1H8VPNGkYlrHZ1GuzbRu+jA6J1zXswQ06Xbk8FaqJGuQfNIpPx7zhidBRiLVfg8TqDUWaHO2OHDaL3COMYUA3xBy9OkpTbeVgiUXFS5XX2kbtCpW6DVF3jVv8krlCpLEayw2r0yeknK4NVViIN4Lnd07+JNcVGQiWQn1BeKEdp11dY+NptJUd5gwk4eOpvXCkuTE4zCNvV4Zb8aLvakiKSONzJsfhuhMZ79LV7SysSI6KKjIRXsZNBWr4jMTa58Idag==
Received: from CH0P223CA0028.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::25)
 by CH3PR12MB9123.namprd12.prod.outlook.com (2603:10b6:610:1a4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 20:57:43 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:116:cafe::e1) by CH0P223CA0028.outlook.office365.com
 (2603:10b6:610:116::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Tue,
 8 Jul 2025 20:57:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 20:57:41 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Jul 2025
 13:57:27 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 8 Jul 2025 13:57:27 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 8 Jul 2025 13:57:26 -0700
Date: Tue, 8 Jul 2025 13:57:25 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <imammedo@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <gustavo.romero@linaro.org>,
 <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <linuxarm@huawei.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v7 02/12] hw/arm/smmu-common: Check SMMU has PCIe Root
 Complex association
Message-ID: <aG2GNcXW89stIZHa@Asurada-Nvidia>
References: <20250708154055.101012-1-shameerali.kolothum.thodi@huawei.com>
 <20250708154055.101012-3-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250708154055.101012-3-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|CH3PR12MB9123:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e624108-b98a-495f-699f-08ddbe621491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N+f8+Hh0FDKk0XVSRMBWOmY9+RFeCttEGb9JnQtjA0QiqwB4Q3rnW5hKYcHf?=
 =?us-ascii?Q?zNXBwrNO+qY7LuL13i9QB+F+CKscHCapBDoLw7LtpljS42nMy5H7DPmQZYAz?=
 =?us-ascii?Q?rP6lngGdSo4QfLOo+x3f/ReK3dfLhO5HtTYQgAbIZ6lZ9LcIrgDn20TAt2hS?=
 =?us-ascii?Q?NIuf6jQfZTHnXxa4Hb4wuHXfS2CrlsQZhRvgbcsWJNoQueaS/WE6i707roPj?=
 =?us-ascii?Q?ZsHBXBusjgAAE5cUZ90PrqgLekxzDb9NZ5oGycDuRDu3gXg3lOGLOFyvA1hW?=
 =?us-ascii?Q?ClQLM2Q7PNv1RXrsRp5gD9g1xVSrftcTo3cQY6PmpQTkCF9GObkJT+GnbB0A?=
 =?us-ascii?Q?FnzbsFgPldhAqouvoVtlwJLs1w0D86BR7JdYyXBIUobicTkSjVuguS63/++R?=
 =?us-ascii?Q?cLEWZtQD/QX97j9c8JdAsh7QJWIINDOeUibPQPwBUx8gPpwGJIFVrHcPaCMV?=
 =?us-ascii?Q?Bwi3Jj84nfwGWH1/tgTAT5QuivE9KIg42YcD0sqqJa96Vo+/Y3XgN7CZ5CDt?=
 =?us-ascii?Q?lI1piMqtUhhbPpoDiXLoTkPpdRexfJY+tTPzNMsGbwN0pM0EHoMAQJqcxPkN?=
 =?us-ascii?Q?XgK7+nHOs1cHw42dG9adprEPII/I0461ljGYW7ABnAamEk53yOCPNx8Siiah?=
 =?us-ascii?Q?UwfFmQjJ98ErTN8K5cFzCgXyg1aeVsPkw9aHzmTMWbYCgUpCtCmFy5JOh/nN?=
 =?us-ascii?Q?aBtKTkQf3qbaFwOlEg7v82jI0EsVyoW2nff7MKkrCNB/qwB3wzX8VkJtn2gu?=
 =?us-ascii?Q?ULIV5CmZDB0mQXgFzbT/IonNl6L2MzgPXVmcs1SfVQcj/icd/pn4MF7qWM+z?=
 =?us-ascii?Q?4ioqh09jzvb/vQARZVwNMVsoVlBgmqshaq03RTvEAg6bbwkjma+/nqVSGKwI?=
 =?us-ascii?Q?V+1M5qiokVVVkZozm337RkfbGs8vfdK/pCbgTfFScOIw0WYIc4hm2E8qpwmL?=
 =?us-ascii?Q?9EB7AGyuj4qxmLEQRaSMBjzBrH6FgwTAECnQfQfxpZAK7mYTyhDtBC/BUmz1?=
 =?us-ascii?Q?zG9Bf5IXZnfOXKfuLUn010Vdzp9Eqgph7dMt0T+AmS9eDr6oxc3fMQxbFpsc?=
 =?us-ascii?Q?50Y9LbuZGNlsH5qlBoJvRwQCyhgzWj3gkWzyuoG3+R5NXWoFmG3iMz0/QoxZ?=
 =?us-ascii?Q?ckQ3xErkIQOg/pJ+zodGg+I7ZBLkHb6EPVFTZdnnHInfU8Jv86Daesgna9BN?=
 =?us-ascii?Q?omzxbt60fqfolMDEb0fXN14/Qi3kI1ph4OiesjX8Wo1FDCDko8oxG9PEHHQD?=
 =?us-ascii?Q?ZUwLU+VQv+yaFbWVDo/ACcTu8f8MgXYHOJwgNoA63aLsLUImqmYrqG6tGjID?=
 =?us-ascii?Q?u0ueWF2JmuLHgmD3g1Qdr3J3M8nUTSZ3o+/Sa6oiWwsrZfLt41DkhPRevGxO?=
 =?us-ascii?Q?DYBWUCjPtoAvrBF0IvSbx9cfHRLAma/6pb+s4hk78zZzMflNY0Fj8auPgKrE?=
 =?us-ascii?Q?zmbuxcWF7QMGtoQ5ykG9cNJqVAhezjxPBywckoApfae0DHziE/9QAoOQFWOB?=
 =?us-ascii?Q?ojqEoHp3RQv+w1XbAtx30xeTd08DslFzwwYl?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 20:57:41.6433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e624108-b98a-495f-699f-08ddbe621491
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9123
Received-SPF: permerror client-ip=2a01:111:f403:2405::62f;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Jul 08, 2025 at 04:40:45PM +0100, Shameer Kolothum wrote:
> @@ -937,11 +939,32 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
>                                       g_free, g_free);
>      s->smmu_pcibus_by_busptr = g_hash_table_new(NULL, NULL);

Although this is not introduced by this patch, is there a
g_hash_table_remove() somewhere in the code?

> +    /*
> +     * We only allow default PCIe Root Complex(pcie.0) or pxb-pcie based extra
> +     * root complexes to be associated with SMMU.
> +     */
> +    if (pci_bus_is_express(pci_bus) && pci_bus_is_root(pci_bus) &&
> +        object_dynamic_cast(OBJECT(pci_bus)->parent, TYPE_PCI_HOST_BRIDGE)) {
> +        /*
> +         * For pxb-pcie, parent_dev will be set. Make sure it is
> +         * pxb-pcie indeed.
> +         */
> +        if (pci_bus->parent_dev) {
> +            if (!object_dynamic_cast(OBJECT(pci_bus), TYPE_PXB_PCIE_BUS)) {

The pci_bus_is_express(pci_bus) at the top is equivalent to:
	object_dynamic_cast(OBJECT(pci_bus), TYPE_PCIE_BUS)
Then here it is doing:
	object_dynamic_cast(OBJECT(pci_bus), TYPE_PXB_PCIE_BUS)

So, this checks the same pci_bus but expects two different types?

I don't see the code check "PCIe Root Complex" explicitly, which
should be TYPE_GPEX_HOST?

Thanks
Nicolin

