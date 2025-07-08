Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 672D7C83F0F
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 22:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZGTV-0004xO-7M; Tue, 08 Jul 2025 18:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uZFy4-0001gp-F5; Tue, 08 Jul 2025 17:35:12 -0400
Received: from mail-mw2nam04on20621.outbound.protection.outlook.com
 ([2a01:111:f403:240a::621]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uZFy2-000191-1E; Tue, 08 Jul 2025 17:35:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SEC/MZDp99EtFFaJaJWq/vFM1xNneFcRQX3Xn8CQx8kcf2i2ZOOqwFK1cUiC9Bl8iqKvFXlWa7WT1M86UhvMk1FR25SEp8xd8atvGzf507ZH19thmMmFmnRFe7/bqK+MqSWF3qjSioPEZA522dFnBOSCKaN4IPX7LVhxqAlSBbPL86Cxvhy+k3As0W3sl3IWxAE96DtiMLqH6l01f6wTrNGCq8jiK+QxQ2jQ7AlLpvPJeGx5JDRtxCWH1/hu0FgWmTUzuB76Kh0dCBOG/Pi6pXL3Va2PUork7rZyQBqViDvtT7aLYC3tXokBfXBDBVbVKFo7+70BBcrgr2+nnJMckQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7Z6H4XtvejlbscMq9w9JBxPJ8WBhvt7fIEfzKZcUgs=;
 b=Sl7KXUEjLL0/NUdw3vA7f9v+4p9JePZ8UBYTocZLaBOmUTNy2spEnarYvlomCqMphKTVh10Eax3dXousBpfGfZ45OvK/hsM2D6Q7oWMBSV6L3euQacE0MW2NtnqdadmMQCRPZ3LBxc4+9YAkmIpdyJnekKQ3xmNUWOzKwgVOTxySRIVED3OcVODC4h+PIBusYNZNT5SiPu9uBVad1G+WfpkNIb+vS9Jx1lgFCj/IeCrp+P8mZwNt8m296rSL6ctT2BB4JAIEx7S6EsxuAs8pjoP8ZKTnH+nQlmyaeKs86uuIboPDHZzxTL/UmcTHrrvnEucRaxBkn+jVBpbsvZSsyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7Z6H4XtvejlbscMq9w9JBxPJ8WBhvt7fIEfzKZcUgs=;
 b=Dc0wargoEBXRp39jUBxshvvCaujbRhRGS3apgXaw0rTEMN4Qp8O6uSMKFJMUDLXYHF72YHXFYyrOG+bZcXQ1yrevHt38SgEU1LffjlWky+Eiw1eHkaIM5YhptBittrzL8OFcX0hycyytsVy8urApaPtBRj4SiAw9fnnlEHhJoJxbRsvxGoqTG//09H/edfw3fItyARQCyqNQFMdsDA1jrquxZ6sKPNw9xtrpesUcITa5o77R1jV5spKPFI/ouxhD/ymSElP2nnXW5P0HmbkaeENCjyBmcgrC+nYZd3KMOTzDu/rmulGGzMADmNNmUhdIONGU/a9ttJRBWZKyIFQdyQ==
Received: from SJ0PR05CA0069.namprd05.prod.outlook.com (2603:10b6:a03:332::14)
 by LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 21:35:02 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::6b) by SJ0PR05CA0069.outlook.office365.com
 (2603:10b6:a03:332::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.19 via Frontend Transport; Tue,
 8 Jul 2025 21:35:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.20 via Frontend Transport; Tue, 8 Jul 2025 21:35:00 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Jul 2025
 14:34:32 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 8 Jul
 2025 14:34:31 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 8 Jul 2025 14:34:30 -0700
Date: Tue, 8 Jul 2025 14:34:28 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <imammedo@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <gustavo.romero@linaro.org>,
 <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <linuxarm@huawei.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v7 08/12] hw/arm/virt: Allow user-creatable SMMUv3 dev
 instantiation
Message-ID: <aG2O5DA/n0NMYYzG@Asurada-Nvidia>
References: <20250708154055.101012-1-shameerali.kolothum.thodi@huawei.com>
 <20250708154055.101012-9-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250708154055.101012-9-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|LV5PR12MB9779:EE_
X-MS-Office365-Filtering-Correlation-Id: db99f78c-f0d7-40a1-fd47-08ddbe674acb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OHBtMWppbFVvK0lDSVo4T3JFZGtIR0xMWWl5YjlOK1NYZEg3NEhtUlhIY24r?=
 =?utf-8?B?ZWIwNTFrQTNnckZRa2ZGRVN3ei9zZTNVQjFmcU1taUtXY1pWZm1DSUtnSHBY?=
 =?utf-8?B?REtOek1BUFVkcXJyYVVlOVlXYlFLd0FqQTJKQk5nM0kvTFZpQ0EzLzZZYmVS?=
 =?utf-8?B?R0lYMmhNbzVXS1hsUjFkbWE3NktEOUp6V2l0cE9GS0hKeHBkYnR4WTNGSzlC?=
 =?utf-8?B?TWxvSWJsWGJiQ2lYWUcrU0VIMFRBc09QRVRmcElpMmVmUlBWdi9ERzhIQncv?=
 =?utf-8?B?WmxpaGhwb1Vwd05tWUJ5cDZjTFNuenh1azZhM3RsUFExWTN3ZmJaMkdKS3F1?=
 =?utf-8?B?WjN3TXlKWUFPQTArV2hrRmN4UkxqdWE1MENaRFlpOWFpTzc0QytjR0g2WDVy?=
 =?utf-8?B?alp6MDdMT0NJTFJhdzlrOFUwc2UvU041Skk0Rzk5blNUT0pWUEduUnpuOGVN?=
 =?utf-8?B?RWQ1bXd5dWIvKy9IT1BMU0h5T3VMM2NhYWRIaDArbXB0R1N2OVhLcTZTSVQ0?=
 =?utf-8?B?YkpQZUR2WXNNa2VaRmJFUkZ3U3U2N0p4VGRaei9kakloOUFRdFE4dmI1bWcx?=
 =?utf-8?B?RXdNUklkcWZyejNwQlh0c3RrY0lQMnlpLzd3ellGZFlJRnRzWkVONXJJbUhP?=
 =?utf-8?B?SmFoMXRiTlRSRFpOZnhsWXQzM3pDdm9Kc1pPdVhubEtGd0Y4MGEra090S0M2?=
 =?utf-8?B?cjZ6cXFDQ0NvZVM1MW5tZ2pWRlhMMjUwOTRaRGplcEcvM2ZZSDZEVmcvSStU?=
 =?utf-8?B?dXp4dUpoOWRiWUp5Q1YyakMvVTJOSmcxeVVPSkRPQkQyRlBwOW5mWDdxRFlF?=
 =?utf-8?B?N0hCMjJINGRTVmJxZVRrWENjUGxiRzQvU2VxTHU3bS92TEpBTFpVQll0WC8v?=
 =?utf-8?B?VTJ6SFpqRW9wbkVhTFJkbWZ3VU5pVEZMSy9VQzJlajQ1a1daRUI0WjNsUXlP?=
 =?utf-8?B?WVFpU2hXMzFRR1daRDRod0JYMTMra2pxNE54Tks2ams2dis4eGc1WTJTZFRs?=
 =?utf-8?B?bTVSQ0JFam03c0lYZ3lkNWFRQ1ltM3lxUHBtUHk2Rlc4VExPYm1RcjFvbURP?=
 =?utf-8?B?ekc3SXJQYWloYXExMjN6QTQ0dnl0Y1hUQVpOV3E2dkFIc1hnYm9pVWFNMFVN?=
 =?utf-8?B?Qkx6dlM0WEd5cnI2Y3JEc0NXcXhjLzZTc01UcG92YnJXOCtTczBJUGxGSnoy?=
 =?utf-8?B?bXQ1Y1B6VWZ5WVNNRGx0QkxPZHZWYVlUUGZCVHk1SHcxM0NEVzAzNHNqOFVQ?=
 =?utf-8?B?WmRPRVdHYy9lYmpOYTVXNktXeEt4RWVMa1poMU1HdTBpeEd5UHhnQzE3SUJ4?=
 =?utf-8?B?UFR5eG1JNHNBREVyVE1mM3dxcXJtODl1c1ZtaFFiM2x6UGs5dmduQ2JrWEp5?=
 =?utf-8?B?ZGN4UkVmU2Z1Vyt1ckk5NDFOTmUxOGlyRThmN1pia3g5ZmVSWi8ybkxFWG56?=
 =?utf-8?B?Z3p2bFZXcERZT1NvcHVUWk1PR0NXL3pLRWxFRzh1UzBXcnBQUFZkWnpEVmJq?=
 =?utf-8?B?YUNhblQrd2VnenhLa2t0eEFpK1NBYndoQXRIcjF0Nlg1M3VjMkRMOXFLaWo5?=
 =?utf-8?B?clc5K21RNjVyNVZJdTAxZk1NUEZWWkFUQng3ek9kdjR4cXo3MXhlazFiRVFY?=
 =?utf-8?B?bktnZC9ubWtsaTY5aU91SlNuTlc4U2k0NHhhOVN4WUFkY1dZbi9YdkMwVXF4?=
 =?utf-8?B?U0JLVUxDdk5pV2xTa3RvUHlSMy9iMnlSUjVXZi8xeTlBdmNzMytQT1AzZnN1?=
 =?utf-8?B?eTBwcTBlZVlIOVphWlJMb2puY0t4UmZCekRvRUhkVFo0cjVFYk1MNko5SDYx?=
 =?utf-8?B?dk1vdXZTNGxVMDdkbnZPb2RaZlh5c2hxY1pYbFlPd2FWeVJkLzdvWFlNUUwv?=
 =?utf-8?B?MXZxSlZtVG5TUmE5M2gwVnVObExrWFRDNXJoOGhlWjBTWmhWKzlEclRuL25V?=
 =?utf-8?B?aHlGVVBtNG8rYzlHNmtIaHNaVmhiYU14YWtEN0VyNC9xWDg3VUhWMTJzeGVr?=
 =?utf-8?B?aDZqTUZsalgzK1E2akliZW0wK21OdFI2K1dzY3N3dGE4elhNN0hJcEp2aGVn?=
 =?utf-8?Q?RRbAD8?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 21:35:00.1119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db99f78c-f0d7-40a1-fd47-08ddbe674acb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9779
Received-SPF: permerror client-ip=2a01:111:f403:240a::621;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
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

On Tue, Jul 08, 2025 at 04:40:51PM +0100, Shameer Kolothum wrote:
> Allow cold-plugging of an SMMUv3 device on the virt machine when no
> global (legacy) SMMUv3 is present or when a virtio-iommu is specified.
> 
> This user-created SMMUv3 device is tied to a specific PCI bus provided
> by the user, so ensure the IOMMU ops are configured accordingly.
> 
> Due to current limitations in QEMU’s device tree support, specifically
> its inability to properly present pxb-pcie based root complexes and
> their devices, the device tree support for the new SMMUv3 device is
> limited to cases where it is attached to the default pcie.0 root complex.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Nathan Chen <nathanc@nvidia.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

