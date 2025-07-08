Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E0BC8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:43:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZG4Y-0008MZ-Eu; Tue, 08 Jul 2025 17:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uZElg-0000GU-En; Tue, 08 Jul 2025 16:18:20 -0400
Received: from mail-mw2nam10on2060d.outbound.protection.outlook.com
 ([2a01:111:f403:2412::60d]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uZEld-0006Z9-UM; Tue, 08 Jul 2025 16:18:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahS8ajCK3O9En1DkksZo06VQqY3+aIBMlWHyWCHm5GBA+gJAjiamPlWMkAyr8s6s8dioLfVeDhzIOs3FtdwKhK22VGuRqQBw7eXcnioIiSABsNYhR1gyjcPkNzAPJ0YJFufb7vJBSryEwuHboDUtkZb/8JgtErBFe65c8RHo+sVULU56tR9vNBNUi8X1djiSkNGSjJuk4AUsSeD1WTij2MKzDM3BlMz6kMby6mtfYgemEles8a4i6d/fT+cUdCFOrKXrt7IQIN7PrHTRp2zM3zCXsFgWWhR6nN8Em/0yUhIWkKDrugfTvwTyeA/7HJJFpamdqOlLwmip0HX4PveR1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKOBrOM/m48kxkmIbL3Cr9HP8SKLTxirjHaWIn63VcU=;
 b=zVdyJv6Z6CQ6UlATG4cWThVQwXDHMgYpIyx5pOtvSVE50DvKZBmnK+EH4oiaf+BwZb+ChuYXPQ+UVhm2IarFCbiIzU6lRP+5D9enTdoYGkjkH1NcYO2e281WEv2Rze5fgfxJo2imqsr8KUQzxYuf8cINHmj66v1ZsqNBgyn71tVCeYJT+xVQyq/5tOGgTQcB749nELMHTUCzbtYRzlXrIXcSHXi2Wnt3MZ/0of0gaBYcHsIrplZuXiwlEz/8Hq8VisjS9L9iQc+KxdMUOcvLeFD7piDexvZAUH+lubKwEMUsMYLAOHzudDF4p11N/0dSrEJCOgbbWf7nBVTwntwXUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKOBrOM/m48kxkmIbL3Cr9HP8SKLTxirjHaWIn63VcU=;
 b=eTN6A9XR/a3ItHkq3li45mBuxw9uuByRyyRr0QHgHoLYFxMw9kteGbESdMIt7zqJ2OG8sJxKen+4HK9QTXFwJMZOBozNYiXLko1NID50jaYZ5M3nPLdOBvrQYw7f2QojPe+a0CtRRFcr24QNWBqxix3miW2tfh/TTz7NPaizmDl4AL8cs+QD8MfcBayvOUam8En6yVIyEb4jcfgPh/8CuCr8AeAt2dyfBrLXct0zZ2F0UR2pKFVgp4kjScbh1nfVFdwGevGl5Vz77WfagoJGrV9aWc5OdqKINm53A2UN+nKNkvzMROTMXUWp3xDTuYCjNNDxrKeG+QpVnqBhxf67DA==
Received: from DM6PR03CA0053.namprd03.prod.outlook.com (2603:10b6:5:100::30)
 by CH3PR12MB9145.namprd12.prod.outlook.com (2603:10b6:610:19b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 20:18:09 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:100:cafe::94) by DM6PR03CA0053.outlook.office365.com
 (2603:10b6:5:100::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Tue,
 8 Jul 2025 20:18:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 20:18:09 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Jul 2025
 13:18:01 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 8 Jul 2025 13:18:00 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 8 Jul 2025 13:17:59 -0700
Date: Tue, 8 Jul 2025 13:17:58 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "gustavo.romero@linaro.org"
 <gustavo.romero@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, Linuxarm
 <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v6 00/12] hw/arm/virt: Add support for user creatable
 SMMUv3 device
Message-ID: <aG189lO48Yz+Xef2@Asurada-Nvidia>
References: <20250703084643.85740-1-shameerali.kolothum.thodi@huawei.com>
 <aGzPgZEhORuRyIdl@Asurada-Nvidia>
 <8e57288e83b24db5a09ab00e39d42940@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8e57288e83b24db5a09ab00e39d42940@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|CH3PR12MB9145:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f0d4d03-5c9b-46e0-5eb7-08ddbe5c8e9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JO9zEqA8e2shmMYECvLU9Dof0DAsVaFjSETG7fdiFvZLuMBb5Vq39qt8HRO1?=
 =?us-ascii?Q?EvlNPsTO/Ilaq4l8TKVnOS0+Lf6SI9vbXoZtVy3MRxnzBbWldPZgwxzFF1cc?=
 =?us-ascii?Q?95xhw46443WXpqOuggH9Zg1MBGpRpMgpaDwbmiknkAJgrRe9OT8m5wC/vvCt?=
 =?us-ascii?Q?p0Qeb4QhBnD+C1TV/LDXvdyQ/PrnLoQF1Fvcr6ztYMRoCunL9vbxAui9865r?=
 =?us-ascii?Q?Fscs3Hf71nV8s3VtZBFyZDdNjkLxzaxtnDWeU76Go7cDSdwuxM4u7Y9LsmtA?=
 =?us-ascii?Q?xqwMkMYFnlRD9/LaXu5+z9UNgFwKCgAT/sYstAaVBW07foLY3sT8XoS05c80?=
 =?us-ascii?Q?UDcOKD6/nRWWlgcObieO/pidHctBYjAHpjkIJ3ME3pPXx7e2ffM9rCCbpSYM?=
 =?us-ascii?Q?yEtuHYa0LJe23as4gpVlhEeCJ3FsCSW1ZWGj+ZXms2ZHr+nBb/9J9v6LGcD8?=
 =?us-ascii?Q?OFhT7HFfg9itb3jSJP1qCAoXBWSPbEZTaQsNH9DYPOofcZ3xylXP3hjb+olY?=
 =?us-ascii?Q?5k1DTyELOjfPvbFK5rn1kA8R9IEy61G61mfzHasKIp5j3RGU8vxtb8ME/9gw?=
 =?us-ascii?Q?F5AIo/CksR3ZJYpoz6UZj4Zcoc4kxHe/NqZmlJ/ZrTQmt9VYaFB7gK0eoRxy?=
 =?us-ascii?Q?i27nYu6xpW+9En4Tmjbgp2AwSK4YH6O0rfGCbOWT5uifLgZYHUBTtmnUVg5L?=
 =?us-ascii?Q?dsynjNGqQH0wvrsdkqSrYWc0NypW+b9GWskl5+4HAe8QxZHJ3Hs/Xc+O9224?=
 =?us-ascii?Q?0Z0t4PjwJIYbIe+WLIufF7tcBFwYRuFdJzt9zYZJ+79IrucQ2CFbC+eAF4FA?=
 =?us-ascii?Q?toin1U+0CJkpW47CFik+0V83JgZtWMSWXgW/eKbFo7EhWb3U6cusrM24ESqa?=
 =?us-ascii?Q?U00y/KdCKXFywXGkeZShF+7C6wo5DL6Z45zffB8FUl8xTx1yjEj8fYIULxrx?=
 =?us-ascii?Q?cKmYw3pbMpAEo80s2pSvT7CvbeCBH32q1U2FHUEIcvlJc5fTIqZNI1ZlTIhM?=
 =?us-ascii?Q?/6PDBHqpFlLDVlYm+rMD0k8H8ey3kLkZGdQ09lUMpade35WTpvkxJNqveS9k?=
 =?us-ascii?Q?wH5oXoOgC50yfjBFrE7IW35vpC5ycBdotj851Anh+5YIeyYpy3aaUKXPB6Gq?=
 =?us-ascii?Q?nqr1q+MDTZhrNsHR5aT/sroIMh7Fs2/aOEMkKTJr302zrwqstE35a0m5Jqfp?=
 =?us-ascii?Q?w2rJ5P8JEz/UVVqME9I4vMXViFhMjWlUCj2qy1+E7wNiCesOlXs6ojxEbP6P?=
 =?us-ascii?Q?EMe+bdNYiqKcnrUamleH6AKwQ3W7Pbo5Y3NY+e5qSbW+nZFOaI7YvSx3XjHD?=
 =?us-ascii?Q?Pc5/Yk0vhRuk1FaHK/xN3jB+qCefSOTUNHSWaWymaVHoxQ3hw2JHIHA2uvQ7?=
 =?us-ascii?Q?F+9jnFZMpC7aiD4/MVJV2Nd4RqRacnmW3gGmz7WQYd7kRg70Ade636AggwBA?=
 =?us-ascii?Q?42jyd66+wAzlv1VMqCzx73JWcPZeaa+0vnbCCLOeiVVfmtTxVWU00eIgLvuw?=
 =?us-ascii?Q?W4GygV9zjEGwK4jEuhGoNMHZrx7+SKItyQjT?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 20:18:09.3994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f0d4d03-5c9b-46e0-5eb7-08ddbe5c8e9d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9145
Received-SPF: permerror client-ip=2a01:111:f403:2412::60d;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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

On Tue, Jul 08, 2025 at 08:57:37AM +0000, Shameerali Kolothum Thodi wrote:
> > Thank you for the effort and the work here.
> > 
> > A separate topic: do you have any preparation for the vIOMMU uAPI
> > patches (iommufd backends) in QEMU?
> > 
> > I think it should be the next step after this series, so I wonder
> > if you have done some worked already to test this series.
> > 
> > And maybe I can start that review process in parallel, or we will
> > have to wait for the vSMMU code.
> 
> Yes, I have something on top of this series that enables the accelerated
> support.  I need do a bit more testing and then will send out that as an
> RFC v3. Hopefully later this week.

Sounds great. It'd be nicer if there is a branch to try :)

Thanks
Nicolin

