Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98841E67818
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 19:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXlWU-0003bF-0o; Mon, 22 Dec 2025 14:24:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vXlWS-0003av-U2; Mon, 22 Dec 2025 14:24:48 -0500
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vXlWR-00079U-83; Mon, 22 Dec 2025 14:24:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRiahnk0tWohxpM2wweYETX3pAdpmG3aaHqJeHZZ8n+yJSjB2lCQtcYEVu9hxERt04Mci279J6Wt2Jm0H8Bwhu4V+KVnAYVckm1mXyIV38iPWFPzd3I1A0G5rl4Hlzil/Mb/iq629M188wtcaqUN59QXzw66XXgWSmGpjiYxuFZYnyLGMpsYajZKaUaKBgEWqevqMsyWsO6O11wmVaWcrYFOLpxPBzACzegzc3f5DHcqwAhi9jb7H+lE+rFW5DFNBOaiyl7KuXIEamgI1FLPEWCxWQrigtQIYro/MlSe7f56/Zx7B0OrJe60FSKMwRZ6gEBVoON9zXhmEGiLUq7j2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1GQ7fXQz45LuHj22Ce5fVU7a6O2XwKtYigLRIzrFp8=;
 b=migz3YKiV469D+dk8c7u0ilNIRFoyYw6iWgRqcOD/1hDrEPHTHO+yZxPG+i78Y1MDFkB3orbPItmZ07C+/+ldOASYAVhX8LtAOjbAm7GQP+6ClpKARNsSdd6S3z1VVlCdZtopdFLneLaLnQhnrw7o7a3TgYM/g/H/LDzFiU+fh1iSaPhvzUY0XvlnY9T6BL0JUs++nX45YxIfwdiU453nRsgTX6PxXrjiP58pW7FAIID5hg/fR6LjGwVE/G5wn+4ZL+SGBNPI5UEioyFzudOJhungh4tMXRlaA4uxq5NhFXS8oPN2xcQgHmQOeC8V0DUDgwneO6ZXbghX19v0kSt9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1GQ7fXQz45LuHj22Ce5fVU7a6O2XwKtYigLRIzrFp8=;
 b=iBnscD1QD6IkAvVNGXVS/P/mwaO978tn+Q4DAybkEZE164auX2iL8G1oTxHqoQAlVIY4t6G0lNKgngBE5ossN+UgtPHO8yf8aA3Wy9f5WXOHpj88aZtLfm10aH6DiA7gAoOum+rhAgBLPRoPo/73T8ayuCfnawJrNn6d5FgGpO+wkWyB2RPpyF6nlk4Yw9OhXP9qedqZzX9BJOZh1Xn71DSLnjn3pvMq6hNMWoNWoZcY2tQ+Jend7C52rJzV2Uk+lntfgzOqe4R+8bTIVD0Dd3LkNJBXztHOs9PP1ow2IjPwZ/RmiIMY1UMFKDkpczj3Lbx98E4kM9B+hBZA7FCT0g==
Received: from PH8PR05CA0012.namprd05.prod.outlook.com (2603:10b6:510:2cc::11)
 by IA0PPF64A94D5DF.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd0) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 19:24:34 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::70) by PH8PR05CA0012.outlook.office365.com
 (2603:10b6:510:2cc::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.10 via Frontend Transport; Mon,
 22 Dec 2025 19:24:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Mon, 22 Dec 2025 19:24:34 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Dec
 2025 11:24:16 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Dec
 2025 11:24:16 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Dec 2025 11:24:15 -0800
Date: Mon, 22 Dec 2025 11:24:13 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v2 0/4] vEVENTQ support for accelerated SMMUv3 devices
Message-ID: <aUma3X5YAvPllp+W@Asurada-Nvidia>
References: <20251204092245.5157-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251204092245.5157-1-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|IA0PPF64A94D5DF:EE_
X-MS-Office365-Filtering-Correlation-Id: 11acc884-deb0-488e-f4ff-08de418fbd16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vssiJ0MYiOn8AGWJd9wdZyzFMDl06qujlRCcAOJ8fRFFozimGlHEo9eL/F6N?=
 =?us-ascii?Q?kEbKayO+XCK0H4MikVF3acu2bl36wYU2MM0LcviwgOH5hyF+ej95CInOGnkQ?=
 =?us-ascii?Q?kHcjilwJm2S40m/dyshysBNrjxAuz4RDNKlL9NcneKf3k64MFc3NSEOVowhh?=
 =?us-ascii?Q?Lar9OH1AssTtJCtRzdUFvcyXHSV2qgTpU+S9cbDlJE4Tpo9tRVA6l/uCx/RN?=
 =?us-ascii?Q?DV3AS0T5DUzzoFQZUOLApWcl9b+iEmHkmF8pkcXPsx7R4Ir7cWV3XDDoMINc?=
 =?us-ascii?Q?DBoXha9hk7xMJZH8+XMIwwhzHy5GuDqfocSdZ9yv5G1V0hwpj5dADi8lM8I0?=
 =?us-ascii?Q?dFiJOK27UldYeeg2D53j/ZC0Ly/QGR02qYDJvSjru4n7IeZbNQTjBAmyWMMg?=
 =?us-ascii?Q?V6muvtvQI9Y3idQAY6lAlmigmmlJaqS1+PNqfJVQ/xQI5bTT/w7OD6Fuqgt4?=
 =?us-ascii?Q?s98+9q1XyuXsc7as/2l7GuLJPii6untIMko2/YoLaD0d7Ne4+Yjed8s+lOJb?=
 =?us-ascii?Q?MSLUXKgjf7FY/4XuMK3oL8TXXB/mx7ge4776MZrxmr/y/1nzIQo+fLj8OhXZ?=
 =?us-ascii?Q?CqjnN2kX6aecAjStOqWe3xmxm+m5RfRlTD1jVW0QVYeq+O4QvU0bRmPZqxKX?=
 =?us-ascii?Q?k5RKeuzNJ+fIqDALtc47TZeYpdpWEozh8V1dMAzuMO10DPifTVkWtXFcPnHg?=
 =?us-ascii?Q?Pc+3kJglmCXipfsL0rYEDC8g7KH7EKJZvvFTefviKJPliyWwX8CoLdSODF6s?=
 =?us-ascii?Q?W8795KZb0sdo6hxcFnpyfwVlrPkynGVDHKJCKSh7tXuTqeY1cCmh9bd6DjqD?=
 =?us-ascii?Q?7khD9pKoJKX1BXKA/bRRmVHgaOxOFqYEIZ0/8LbQ8paDhWB9dfKRbCRv78Db?=
 =?us-ascii?Q?/rVP5JjJillhEYGxDscIFTSgkF1N5TKkFkif9DpEPAByvrpnM5dFxOkPo52K?=
 =?us-ascii?Q?+6SKqLKLAAOKYyzuLn1LcU82+n5M+UGII+2HEc8rqesiM30toRxpgNaVGbMz?=
 =?us-ascii?Q?QsOZUSLLnwOMCW1W4AAX7w0qqtC52Lcclcrx8ZAL78IuqrWuy8s/UHaNqzcQ?=
 =?us-ascii?Q?/9/wBAIZhjkFoUUBryQYAzPazoe4ddWOPY9AJer+DoMjyB50D7uzbSD9G+W+?=
 =?us-ascii?Q?5ttjIgtElX6wRGgiciC04emd9n8vJVYjD/xwDquxAbu5Z+Y+RjMbrJ57RlwS?=
 =?us-ascii?Q?zQ7jdJSycLf+USBkXXDYaUM+PnUTlvbciGxeTSinaCLzVPZl81RijKZJLYcR?=
 =?us-ascii?Q?ZqgRpSg8oht2ygK3nPFij7Fht+d8auodvdP0U69t3nG0uJHfhi3olzv8jBVS?=
 =?us-ascii?Q?wHC/UJquHb7IIGBAjYA43yiyxPWpHkx0sfQ6AMhhkxskXLGhlD/pdiU8nS6E?=
 =?us-ascii?Q?cnvVLEEa4FcYJsZFC/A3hzZ0A30650e1JnN+EBE1b6SHXXxWIVe34FzRppcp?=
 =?us-ascii?Q?beiQq4PelJDZv8gCoDiWYGADErF99mMQc2Dq5DJDUi1/n6iYRpvl57+JB7t8?=
 =?us-ascii?Q?LZrjcti9lfKl7VI50OwpStS3QmAQK3G71ubwRoEnlpX5AR6WSPkWzCWLKueP?=
 =?us-ascii?Q?34Ma9rladeKyAkbCbfHmB4QP5Gctp+pY5LvACuni?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 19:24:34.0377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11acc884-deb0-488e-f4ff-08de418fbd16
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF64A94D5DF
Received-SPF: softfail client-ip=2a01:111:f403:c10c::1;
 envelope-from=nicolinc@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

On Thu, Dec 04, 2025 at 09:22:37AM +0000, Shameer Kolothum wrote:
> Changes from RFC v1:
> https://lore.kernel.org/qemu-devel/20251105154657.37386-1-skolothumtho@nvidia.com/
> 
>  -Rebased on v6[0] of the "accelerated SMMUv3" series
>  -Addressed feedback on the RFC. Thanks!
>  -Dropped the RFC tag as the accelerated series is now more mature, and once
>   that lands, it makes sense to pick this up as well since it enables the
>   delivery of SMMUv3 events to the guest.
> 
> When accel=on is enabled for an SMMUv3 instance, the host hardware SMMUv3
> may generate Stage-1 (S1) fault or event notifications that are intended
> for the vIOMMU instance in userspace.
> 
> This series adds QEMU support for receiving such host events through the
> vEVENTQ interface and propagating them to the guest. The implementation
> uses the vEVENTQ support provided by the IOMMUFD subsystem in the kernel.
> 
> I have lightly this on a Grace platform using some hacks to generate fault
> events. Further testing and feedback are welcome.

I've tried a quick sanity test via VCMDQ:

Tested-by: Nicolin Chen <nicolinc@nvidia.com>

