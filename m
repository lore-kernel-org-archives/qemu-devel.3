Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB4CC3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 17:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAubN-0005qP-Er; Fri, 02 May 2025 13:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uAubK-0005oL-BO; Fri, 02 May 2025 13:55:06 -0400
Received: from mail-co1nam11on20605.outbound.protection.outlook.com
 ([2a01:111:f403:2416::605]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uAubH-0007fk-Oj; Fri, 02 May 2025 13:55:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKUu2g1J+fKCeGq0acf6L+7eMXRBqrRMmDWt8yu1UcD4xJzKiY6v5QVjRHOEnHoyHgCpzW1jfMTeiVc2hLcFOQQnw0wmFOTdzWQPNLnujtwpgSXFRY5rNm0avpAzNQjw8zqTATMeDutgpdBE31XrT3+XhjSrgaWyXSlkGtuG8c+ImKqUR5oJaSWPxzrsudUlDWV50RsmZ3JEp710nD9wF9CbEKDTLzY7IzSGppO9yp13eUjlxC/GV+aQ3+tueqv7PJFQcMFElchM+/ly82fvgroTDnPmNnFSYlTZKwKdYtgIGh8p3xFZo1mnKa1vUrkutYx5gGaUi231d/V33jGZig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZnriH9jjytVosM+Evu3JGQKii9nVNBewaaNRp4iYSo=;
 b=e54dV4ckahO8PU5Yw7fQJwWLjTxCQ42LUfxRR/WoYYEhEUedVuesyJvrqh8l3p6qvtolAPsXc35gw9lNuIwYEmApVhUr/I/y/uN89EzjZeRzFaoodWIE83tNVSyxFtdEYYipnhmLLqy0ukNxEtF34DiL6CgvHcybrn8GY2eOgwmzjrc+iZuFeGIbA6mnRKWRRHBcAz/2WWAk+dFe4/ihqryxhfSvrY0cDVEVq/8jsmVRO5VKo1k9rURK9BKDtfvt5OqUjxFn1uYAsBTkijb2c8EBJnK+6xru5OrRaDH3Dlzd/gGCviW5mXIZVV0LzYpnPGdARsJbmXMv0blrROMrLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZnriH9jjytVosM+Evu3JGQKii9nVNBewaaNRp4iYSo=;
 b=kcy+uXoveyyM9JrvJbLqp/PwJRvf9GYqqrR+iQHSFCRX98JP9H7y2aRTE6w0jvFHA0dwogEdvsf3iEcQGI31SyotZeysi/7nRI4BVQ8G/h7dKVqsqkGnvu9CQEcGmZ+sMeKpnxQL7e8RoW8oUTdzkqulGH0SA2PTJSJ59xZCKe72OzdpQuDRzIvG9UlzHBU7uUrestXzvncEws8+KZCcz33ywwCiOe3pXbvKdJrkjIRSTd+oOHT5O4dy3ngOoYMptAwMcdZXf7gov2Fh4l+/JgURGLpskQsJ3INxrTZDXejIbruhutIvhq28cv4PDW7zYxKObplvUHql3T423HN0sQ==
Received: from BN9PR03CA0046.namprd03.prod.outlook.com (2603:10b6:408:fb::21)
 by MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Fri, 2 May
 2025 17:54:56 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:fb:cafe::2b) by BN9PR03CA0046.outlook.office365.com
 (2603:10b6:408:fb::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.24 via Frontend Transport; Fri,
 2 May 2025 17:54:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Fri, 2 May 2025 17:54:56 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 2 May 2025
 10:54:42 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 2 May
 2025 10:54:42 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 2 May 2025 10:54:40 -0700
Date: Fri, 2 May 2025 10:54:39 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v2 5/6] hw/arm/virt: Add support for smmuv3 device
Message-ID: <aBUG34ZMbv+AspsR@Asurada-Nvidia>
References: <20250502102707.110516-1-shameerali.kolothum.thodi@huawei.com>
 <20250502102707.110516-6-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250502102707.110516-6-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|MN2PR12MB4078:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d93ac41-1a35-4fcd-405c-08dd89a2732f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K/00NE5JmE5IAM9m8Ah7QX0P3YEhEhb5iS4T/Glf/yv+bv8bjSDaCcQ2oRjW?=
 =?us-ascii?Q?LFY3C2kNr/4VZNI6hmcGiK8EgwBZIlhaN1jg4VfztJSGK7IeGTNteKxIKb4c?=
 =?us-ascii?Q?aVC1qsY/PO6mrZFy4GeM2C1hrw/zbuvMfAFcepPTg05+wXY+/iVW3DbJmuf7?=
 =?us-ascii?Q?Zn262MVDt0/SZYBDSAwQtJCWskNd0LZoxp6m/Fha46PLuO3UFddWxpxQpY+C?=
 =?us-ascii?Q?mmuUOqu06Wp0OhRoa/NTZeTpKUm/njzZpJRMxFteK3ShvX6NCZc+d9c7zf5C?=
 =?us-ascii?Q?OoKVLZXxaNkvP4d3WEIK+Dvv8M+cOjpOE3trX145aqFvk1O+S+UHccmtlGH+?=
 =?us-ascii?Q?6nmHRDRNYhCtjCf7hn295B6/pkJQZDuYOgynEj9aQD1qcK5/N5gt//UHVfs3?=
 =?us-ascii?Q?t/44EA+PfVEfLkLKiKthmU9RWcZgnlHJZ42FlYI/xSExWYTI0J38tQcE1WBY?=
 =?us-ascii?Q?PpRJ3Tqg1e+XZaRG3fdBWS5UKuu9iI5DX6kwdOE7REf+YEMemHVU07R6ZQcF?=
 =?us-ascii?Q?yktjRvkf6N+Q2tTFmuXKd1loI8XnGM5tMCCbzET9jgBePjr7g+/enQzueh2y?=
 =?us-ascii?Q?0gEsrfnTOaf+zqcm1IniULA1DPQJISEs6WUOCqntD7usZpyePOAMxFlxymQp?=
 =?us-ascii?Q?qHZFDANVURfppC8Jp4yjj/gCgPdgE7AfoiIOnK2oZGTdY1Ty8WgC+WfOldpT?=
 =?us-ascii?Q?InL+6+nzo3w/fvY4ABtWt5gfHoGMXrzpdRwUNYnbcY43BSDb71cnfX9rRDtW?=
 =?us-ascii?Q?OwQrEqIQlq2HOlfJQp1tTWUhrIp3vb9IPLMMYkqK2cY/gOwJVQaZ1KtgzyPY?=
 =?us-ascii?Q?M8W/Tik5Zr+UyewXzzXm+IlAxwtVpvQezQxE0Rmg0XCtuOWhYRhuw8njtjel?=
 =?us-ascii?Q?KWICBx9qP44ak6hMW5TrNg+411Knpgd/h8Uo7x2PLzarKMFRnIl7nuv/COqO?=
 =?us-ascii?Q?14Kvo2RcVAYHo8ZmeUJduI1juZBvMLRX/9Kb6+n/rrQRBGsmQCqHlccJotz5?=
 =?us-ascii?Q?Jq4gnCv7o1zUxwYKQWME/W2IRws/f/T5p7M4+lFvC00thRHFbwiOWu5i98gC?=
 =?us-ascii?Q?RM7IG2uSelzM/7Y/djz3DeVshi64nseJqgi6DyK24mm9k0AMF16Jv0rZmsWf?=
 =?us-ascii?Q?ZICYOrHX+Mr9LpGEhQAgTGRANnZgIAUIN5qo+avsvLcC39s9ezleDZ3gnofe?=
 =?us-ascii?Q?KJwsazSy3fihxoYlGNvUQdYYJ3nJy0JUIBi/dLPb3dS19xRL94lJezpiG8z6?=
 =?us-ascii?Q?YFS8ADdgSTozCqBUUnG/xgB+O5IkeCVyPaFsioz9hCy589HcHptWN1XHUHNS?=
 =?us-ascii?Q?iOqH8KaPgmCdailtEX2HUXNLnJiCGFArKh3H7vphkSqkw0cfKce+gZajhC8T?=
 =?us-ascii?Q?PEpdwYpQrhR4re8Qlbdj9KmuWOKm3qqEFMrVJFHtRF/+k5nPf9srFdqWiu/j?=
 =?us-ascii?Q?46MFXiNxn+OsB2RrSvdz9xFZ6SD8Czq9Y0woQLKr7gKifPS2T3Z+7f+4ge0m?=
 =?us-ascii?Q?RF/1CvbmRgwm+liq/j/MFV5y8Afp2zscPsKU?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 17:54:56.4677 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d93ac41-1a35-4fcd-405c-08dd89a2732f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4078
Received-SPF: permerror client-ip=2a01:111:f403:2416::605;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
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

On Fri, May 02, 2025 at 11:27:06AM +0100, Shameer Kolothum wrote:
> @@ -2972,6 +3004,21 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>          virtio_md_pci_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
>      }
>  
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_ARM_SMMUV3)) {

This seems to be on the path of a hotplug function? Mind elaborating
why, while PATCH-1 sets hotpluggable to false?

> +        if (!vms->legacy_smmuv3_present && vms->platform_bus_dev) {
> +            VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
> +
> +            create_smmuv3_dev_dtb(vms, dev);
> +            if (vms->iommu != VIRT_IOMMU_SMMUV3) {

Should this be VIRT_IOMMU_NONE only as the other cases are rejected?

> +                vms->iommu = VIRT_IOMMU_SMMUV3;

Thanks
nicolin

