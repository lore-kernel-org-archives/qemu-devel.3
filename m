Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCED3CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 21:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Vq6-0002YJ-OZ; Thu, 16 Oct 2025 17:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1v9Vq5-0002Y7-HX; Thu, 16 Oct 2025 17:48:49 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1v9Vq3-0004fL-5z; Thu, 16 Oct 2025 17:48:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBVN6j8mDoqmxtWo4ar+WMrbNJz3t+0Plf2Keaauo7mhJZCE4ttC/3qsM42gaaE4wLAL7YlwQdL6xxRx6qoQGbeqEW/NlmmIxRMVBH5k1Jc8U0ywXZowxHX/XzHejrYS5wYIajfqYRYpsxQTEDZ0QpVjFVFBwSVF+EJIJma7XUYje8LWEltN73X4Er77+tAfwKoZIpnU0CVWOHsFZla24gjnQ2MMTC11qcXjrZbhtOvX99BvVgzSPiHW1o05aBTSdZusXqQeRb02y2OVCIv6H55JQldInHyuVQljZYSDYenEfUUpYVzOd83fvg+3eoKbxjsPPgUjApU8cwxzkdAJ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whthyiAI2DBYZd4Y4veBADFPT1WSb96NW/DOEQ9mYMA=;
 b=A43q70lHeMkZjenRmwPIab7lgUJiTJOsHnGUM42ssuCmbAEM+u8iSSbZCPZKPzltQQqYr4bRBGviSzJPgj5ziE/XhM5mFmz971PAav19qFDBzITZ1mHbzfWo6LB797vqbtIM02LIq9183vPb/HeTYWsEfWHg4fk6JwIYZz6LhKL81VKt6Qne6OK3GDxiidSD5Rp2PZITRGo57Bw1Byx2XOKJlsTvITTF/pPukJ2ia7LC4OGlXgIyZlgZx+hqqyf/krXnsOLxAA8FwXa4032EqHIFnm+v7Rw319wq5S03wsAsBvX4cjERZEhMjMAiw9fgDhU2WlpseGNCfR+mOqszUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whthyiAI2DBYZd4Y4veBADFPT1WSb96NW/DOEQ9mYMA=;
 b=SJttiY4b5ZtGmNjVj22XEyZWrjOui/qFe12WfgVxTgGf7CJkCV4QusGoj9n7JTNgvevhfS1mlU0uPA0dfsWIdOxb/jhp8Mhd7NjnI04B4rUwFDndsRvsL/GeLc9qPNSjmIbFCZH3o+Mx1qPz+eK48ZoTplCu4iRCRX+FGFDU8MfSX50Om4+SkrMpu3t/Xfl0P47cwMq+7bSnP/EEssFVckkWJ+Gf749fhfrOaeL9egyvrLB0knB4jg72mjsrUQcx0FeVXkgBFf0OAHJ2Fh3GiRY17MSSiL37C+CEWtTyzJQbpm3zXQO9TUyTuUZRSAZ3u6/5y2RACAy+ewbDpJSjNA==
Received: from BN9PR03CA0638.namprd03.prod.outlook.com (2603:10b6:408:13b::13)
 by CY8PR12MB7147.namprd12.prod.outlook.com (2603:10b6:930:5d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Thu, 16 Oct
 2025 21:48:37 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:408:13b:cafe::9e) by BN9PR03CA0638.outlook.office365.com
 (2603:10b6:408:13b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Thu,
 16 Oct 2025 21:48:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 21:48:36 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Thu, 16 Oct
 2025 14:48:20 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Oct
 2025 14:48:20 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 16 Oct 2025 14:48:18 -0700
Date: Thu, 16 Oct 2025 14:48:17 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: Re: [PATCH v4 20/27] hw/arm/smmuv3: Add accel property for SMMUv3
 device
Message-ID: <aPFoIcxQnOrQVNTE@Asurada-Nvidia>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-21-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250929133643.38961-21-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|CY8PR12MB7147:EE_
X-MS-Office365-Filtering-Correlation-Id: cb16723c-42a8-42d4-e0c5-08de0cfdc2b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RUhqK2ZhSlA0ZmZ3VjlLWHNWamlBSm9FY3NaRXRJVW1GSGQ5dFZ6SHNpcS91?=
 =?utf-8?B?QmtOWWpUV2pManlXTGFhcnpMdCtvcmJuYitXdG9UK1F6QytUaDJlZHUrVWlM?=
 =?utf-8?B?TW9iOWZUbmZZWXVLbkFMOFNWYWRUSUQ0OGVhaHRXRlFXalhORDZ6UjNiTHpE?=
 =?utf-8?B?eUthSkFDU3MxLzRXdFNDcnlPMWJ1T1RiU0JxaGNEMk1zWW83eVd1REUvZzd4?=
 =?utf-8?B?c3ZBdHByZkpyTjFqTFhWMFl5VTlYcUJNNG5JY0NYSDNybC9tcGdkQkk1SG0w?=
 =?utf-8?B?K3pIOW83UC9IRTJ3bzcrMjZHVytjYXluNmVuc3Q0U2ZwOWxkbnowT1M2c2pT?=
 =?utf-8?B?eW5zL1d3bnB0ZllZTmFPWkN6QnB1aXlqOUJ6K1d3S2QwQXJkeVg4VC9iWTNz?=
 =?utf-8?B?aUJPMFJvd0VPWUY2c2lKVXdORmpEdU8rVUpCV1l4L0FpS2ZsbFBITTFobjdD?=
 =?utf-8?B?K1dnVVIrdEtaeE15a2xkUVZWR1pHYXRzY2daaDZFbWdrZXphb0dNbUZtYXJx?=
 =?utf-8?B?QlVFM2d2dmdHTlVFUlRpQ0djMmQzM0VLaTFjRFkzTVViRDdaL2pab2NnS2du?=
 =?utf-8?B?a1hzRUxTc2p2YkgyK3FkQzVROStObzFhV2MrSDZqY3o3cERsbFZmVzUvTlA5?=
 =?utf-8?B?WHRTQW9jYWttOXlxQ0ZPbFkrTzQ3dUVyaHVrYmhOTEFtNGZWdURJb1RHSUQx?=
 =?utf-8?B?RVN3NCtRWnBWalp5QWJ2QnRlbmtFb0JiUjRsVVVTbTM3cEdmb3JMQlBGN0Vt?=
 =?utf-8?B?K2pWQzFVUERNREJscnBnRzByN25nUkdRYk91L3EwMFliM3ZkNnRWbityMmww?=
 =?utf-8?B?YVpCdHZWZGhRNjdQZ3pIWDM4RUVVU2JGQklPMUllOTVpZUh2dTJsRFVxOFpy?=
 =?utf-8?B?MnFqK2hGUWhtc2lCdTZhZGcrcGd6ZmpZOXBCeHcyL2pRaTFCVGpYSDc5Sk1E?=
 =?utf-8?B?N2QvcjlrTG53TUJ0Q1hEallzUHFndFZ4T3RtcnpCZ0RBYWVjQUZ4cnBzenFi?=
 =?utf-8?B?MVYwUTJXUlAyMFVyeUlpcHBUUFp4aXNUVlpSRVpsK3VBdmdkbTNiYWVzOVJR?=
 =?utf-8?B?dWVTcitTeGhvY1dGNm1wOW5oa0dVYXg0RXFxSW5zWXp4Y0thd1V1WWhnMmE3?=
 =?utf-8?B?RnJ1NG9tM0VpZUNWamVLOGV2Ti9UNE5RU0VWcmZwQklVa3MzVHJwUFhNS3RC?=
 =?utf-8?B?WFVMcUsrUzB3RlJUeE1IMnYwelhlN0plYzd5NFdoWVV2RkdDK0dOSGs0bUZl?=
 =?utf-8?B?M0hsNjNJblJuS01nVkhERFdiRFhtQm5oL1hvYVdpejQraEM3V1BFbnB3U2pO?=
 =?utf-8?B?cnloVVB0cHRoc1BCUldsaDNHWXhCVmpYbDV5V3ZML2F1WWxKRFNmRENTcGJJ?=
 =?utf-8?B?a1NveVRJMDhENElud3lXeE1LZ05mVGtBNHhWQXdrZndubEtxdkE0TkdwdXRF?=
 =?utf-8?B?TXVaWnNxWEJJWS9CSlUxdC9EU2l1TW1MSkVDcE51NndicU1SV1BBaFNkRnZ4?=
 =?utf-8?B?NXRmQjZyV3VWTmhYSE1mMUZ2djd1Nmx6UXpXNFpIWnQrWUpkaGNMMjllK3hW?=
 =?utf-8?B?MytibE4xWEloRFpTM2pYVmJlUStUM2RpVU8vdXdoS2NRU2pkekcveFZUYy9m?=
 =?utf-8?B?Z1ozVXN3S2d5NjcxVUhlR0VSNElMZk9jWFBOTmUwRzFNcVJIaU9YRDZIcEU3?=
 =?utf-8?B?Q0tPWk1RWENQSFFsaEkzWXNqSkhSRTBnSXJkY3ZPMy9sVDhGMWtFVjA4Ky8y?=
 =?utf-8?B?M3BGamUzOHdHdXF5Ylljb0JadE9sMEtTOGlYMllEYzRDTGR6UHQ1RUsrem4r?=
 =?utf-8?B?K2VOZ2N4K2Z3Rm1wVEZGeTQxYmhaU2hibFlpNFNnOGNGYUk2MlpQcDNlbis3?=
 =?utf-8?B?WWkvbnloMVlaUHVTcWdEbk5kYkxRVFZXR0UwbjFQSGVJZDBQTDIyOUtUVXJn?=
 =?utf-8?B?dFFmenNMTEZ4Z3h4UjBxSmwzdE1wbUhmeGxtRHcrUmJ4YlJ1RktlZUgzdW5K?=
 =?utf-8?B?SXdlYWRBNWV1N0phTDF2U0k3UlhhQVJPNzMzREZla09Ja0Y1a0tEN3dsM21Z?=
 =?utf-8?B?WGJONkE0dHpsMEFxUy82VU1XdlhhTlRGeW5OVUthdFJtQ1hweHh0L3YrMHJT?=
 =?utf-8?Q?h0vo=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 21:48:36.4454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb16723c-42a8-42d4-e0c5-08de0cfdc2b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7147
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=nicolinc@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
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

On Mon, Sep 29, 2025 at 02:36:36PM +0100, Shameer Kolothum wrote:
> Introduce an “accel” property to enable accelerator mode.

Looks better with ASCII quotation marks: "accel".

> Live migration is currently unsupported when accelerator mode is enabled,
> so a migration blocker is added.
> 
> Because this mode relies on IORT RMR for MSI support, accelerator mode is
> not supported for device tree boot.
> 
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

> @@ -67,6 +67,7 @@ struct SMMUv3State {
>      /* SMMU has HW accelerator support for nested S1 + s2 */
>      bool accel;
>      struct SMMUv3AccelState  *s_accel;
> +    Error  *migration_blocker;

No need of double space.

