Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6095FCCF9EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 17:15:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDQnZ-00058T-Oa; Mon, 27 Oct 2025 13:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vDQnV-00057e-Rf; Mon, 27 Oct 2025 13:14:21 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vDQnF-0003Zs-Q6; Mon, 27 Oct 2025 13:14:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M6+ytpOvVhWrPLNuus2i282CJJ9cOjX6NBHMS51ZqNSpYUS64g7v75Cmd5i9z5py+9s9ZLdKqF/dLUzlIiT39ibcSlk5oHs534q7ipX6YLnae2BtAYbqNw0JBCb8UeJ1D7CXMRC1K7Gicy93lFz0A0d9z+9Df0GGBLCA5WVPYrkmeI4sc6R5Z/0gpHnwd7dy/v6BUNovedQY4RkOOEXfGR9xOM8h1C31vkE1suzVxE53sAreXNIC5i8CGTrqb9gAxmlLSxz8c7kjNpy4ADeZ19YoGo1TOgH7DzeAv1qQDNasq/uBfJ6UqpIFoHi6PCRJ20cceT/7KBkK5eSAOJpRhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KFdbc2uhKPP9c5Ih9zc+45zYUafk+k/CnjaBNYd1/E=;
 b=uIvHTb/8vkQRPsz7aQKzrlivwMA68sOyfwPPyYBksy+qDmML92RqtSkq36sXhc+y9HmIo+7vmqKLLXDqjUXz48xef4v0yzUmB4ZiwVBp1c+eZD7P5NGOVomw43t7snO+HzU7yIzXkEeMCu3+18C/Sp9bNImw8vVHFu4+inHaU33vls+XV/ZunrrXOx+l6IQWR8cPLvFpIJ6WaRTPowuRzIPPZWJhko/lShJPOrNova2qXhjHNSbylM5Mx946rSN2QdyFz5Bt6cZZRCvLhu0VmguNCM26qAAjpwDdN0i/4/cR1FN99VA+GU1Wii9nLqKgnnPVZ6so0vWflNGpGNB68Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KFdbc2uhKPP9c5Ih9zc+45zYUafk+k/CnjaBNYd1/E=;
 b=N2gdOoImzdUcA5cGNoE4M82NfkM/Jy8fCT6XYKFrXiJCH1MizXacuHtk9/F4KVO+vlVEBrc0M8/NmbdFLgOXOCuETO/lxEg4OXyIwxxbNJMmkvUoyw+AQER4TJNeU4BpmR7mZzPJpB63mtxFVcyMZqAy+jt3Dbq3+r8iypZAKGMkxIcTqNkCLY1vVMMl02bWA7FXlaoNEseXZLdR5Q8CCSC23ei9FDiteJz5dxO1W3h98FTTWAikIWlPZ+xmQNlyTmNpCqDIDeUAm+7LulLRAzEbeHvLYxMMHL61UehMwSfuHvbXKYJczI2E9K0AtMF9pH4jrVuFkA/YDIZtMqd+8w==
Received: from SA1P222CA0180.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::17)
 by MN0PR12MB6366.namprd12.prod.outlook.com (2603:10b6:208:3c1::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.15; Mon, 27 Oct
 2025 17:13:55 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:3c4:cafe::42) by SA1P222CA0180.outlook.office365.com
 (2603:10b6:806:3c4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Mon,
 27 Oct 2025 17:13:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 17:13:55 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 27 Oct
 2025 10:13:42 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 27 Oct 2025 10:13:42 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Oct 2025 10:13:41 -0700
Date: Mon, 27 Oct 2025 10:13:40 -0700
To: Eric Auger <eric.auger@redhat.com>
CC: Shameer Kolothum <skolothumtho@nvidia.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <ddutile@redhat.com>, <berrange@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <shameerkolothum@gmail.com>
Subject: Re: [PATCH v4 22/27] hw/arm/smmuv3-accel: Add support for ATS
Message-ID: <aP+oRLu/BYNaAPHG@Asurada-Nvidia>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-23-skolothumtho@nvidia.com>
 <26f4d9b2-75be-4913-bb60-01e647a7ec83@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26f4d9b2-75be-4913-bb60-01e647a7ec83@redhat.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|MN0PR12MB6366:EE_
X-MS-Office365-Filtering-Correlation-Id: d8e74400-71c6-4f39-9814-08de157c3598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?xD+smRG+MgiFUZM6R2f9GS+JyIDXR0QraPNiWL2OlpdtXDqukuTJ+Co6bR?=
 =?iso-8859-1?Q?yXid/IvJsq0/KqNDdud0ATWZgnynnlJ5XoEc1dVGy37KX18B4hMhyizTLM?=
 =?iso-8859-1?Q?PIYq+XSt3M8j2AxGxt0YrqGSc6z2W+8nM23PrHtNSmooU5eWPlLmN/Squc?=
 =?iso-8859-1?Q?mmLfvFfTkBK9GxsHpsKm5d/wS27B85qCznnTQU8R04NS0zYhoGP+WFySfY?=
 =?iso-8859-1?Q?5f8KkI1rI+JdrGbKxRv0FYlvmFaoSkOeh3ioMjcxTXooqnAShMTrD7unkJ?=
 =?iso-8859-1?Q?COGrf3xRL3mADWY0AEFUH6eJd1s1tYZh3lMvzoowwUVRne8B6P6h5u4PgB?=
 =?iso-8859-1?Q?7auFt5kwMxgfExyEAwGvcVdzSTe7UG+K7zY0A5xC+X8UMYgAjvWOLPRaOD?=
 =?iso-8859-1?Q?ztrtrKKi/r3ecx8OGGGPARNtbdo8kqQF5ICbvSHT3n6u0rnz6vu3MXxmVC?=
 =?iso-8859-1?Q?gw47BGZo2Kd+iZfMsUw68qSEP/YK3vq+iGgavL6Cr2ET1+SKzD1MDM2WnN?=
 =?iso-8859-1?Q?UJuTvAnY4jDBcFUjE1j30BxXHpQJS00+foma3J6ZpOHF8I4bFfiM5awMHZ?=
 =?iso-8859-1?Q?EhdEf64kNE30vqFG0uGqjDj8GexKlRptPJbDm40VFW4RhwkQ27kcDo+q+y?=
 =?iso-8859-1?Q?YG2LpbhBrjHpq54G/b1uHvt0/foEkIg1xRMhp1hVcIV05eFHmWXtzAj0QM?=
 =?iso-8859-1?Q?EBtCfcGBAtzyVsbCqcS1AXS1dsIt1Cj0utV/q3eZcSFcNOGQkiXL/JK1+h?=
 =?iso-8859-1?Q?KfwN/kPxfS6TIwivmrGlSqrrAp00PvZFEL4B71mxbI5eU33gGC9S9LvnrO?=
 =?iso-8859-1?Q?dOG+AhHyiXn3utEvRUTRDcsyOj9RfCaqg5iZBJlZVn+Vt7CNd7F1R2QxpG?=
 =?iso-8859-1?Q?BhqY8qDD7mJNOTubdXG9yRlsbV6ky8Lib0vcCqsFyCEzR5Om5DddI3Pcrg?=
 =?iso-8859-1?Q?9fDtqOzc+G5mdcj/F4OVwE/4ojcnplwTaYpiOvv3l6Atl+lQdYVJJEI5VA?=
 =?iso-8859-1?Q?dSuvzH+SiU/k2zxuXcD7dLbQZgQwexmN5Ek62XyDWSCvyZuCqEkOAX4C45?=
 =?iso-8859-1?Q?zjRo0yNY8pA6o0UAqeYxfb4vLBl5zK41pyyiqmlXQ5C9dA32yoXbu0CgHS?=
 =?iso-8859-1?Q?v2jE2x12x1g+OByVnpLFVsKuTe1JtTpI2tTHKtmPNAcnHZbEa8X7hSVRMk?=
 =?iso-8859-1?Q?N5bTz+YbIoqpSJLO4MmDU6VPJyF1ZyGieQ9aMAAG/NnboezSNXksk3kDjo?=
 =?iso-8859-1?Q?DAcLMC20xEA1v1ryhVY1AvI7qHbD2EmWH4KTvXsw8w4dnDv3JWSno80Sf5?=
 =?iso-8859-1?Q?pg7RILOjXP32weyF7LZxgXhxmKqqVzCPWnPCDr4vWYVXRQWuH+1D4ult82?=
 =?iso-8859-1?Q?BDDFCDC033HhlQjytAcwev6ABa8lcqBEmr7FBGg/nx5AQaRCRkOaQYeES8?=
 =?iso-8859-1?Q?yMBaK8a+4WX8kNfE+Zm+AgFQPQzd307OnbyVrzJApbdYBwTyPggvfu5pW8?=
 =?iso-8859-1?Q?SAVB3fBUU92IaClJ5xb8AkKBkBN7+fYMZcKWUcgbWLh++XR/9RvmIV+1Qv?=
 =?iso-8859-1?Q?94kqPRTPdKTRXCYozG86VVYCVBDoRr3ckdZqeNKUF/sOZ45t3gwrqWSoqc?=
 =?iso-8859-1?Q?7L1UX5Z4EHp53O1PLDlZyKnOH1mGJJCvfE?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 17:13:55.1212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e74400-71c6-4f39-9814-08de157c3598
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6366
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=nicolinc@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Hi Eric,

On Mon, Oct 27, 2025 at 05:59:13PM +0100, Eric Auger wrote:
> On 9/29/25 3:36 PM, Shameer Kolothum wrote:
> > QEMU SMMUv3 does not enable ATS (Address Translation Services) by default.
> > When accelerated mode is enabled and the host SMMUv3 supports ATS, it can
> > be useful to report ATS capability to the guest so it can take advantage
> > of it if the device also supports ATS.
> >
> > Note: ATS support cannot be reliably detected from the host SMMUv3 IDR
> > registers alone, as firmware ACPI IORT tables may override them. The
> > user must therefore ensure the support before enabling it.

> This looks incomplete to me. ATS is a big topic in itself. I would
> prefer we do not advertise it until we do not have full support for it
> (including emulation). Comparing to
> c049bf5bb9dd ("intel_iommu: Add support for ATS") which was recently
> contributed we miss at least translation request implementations
> (PCIIOMMUOps ats_request_translation callback implementation).
> 
> See:
> https://lore.kernel.org/all/20250628180226.133285-11-clement.mathieu--drif@eviden.com/#r

In accelerated SMMUv3 case, ATS translation and invalidation are
done by the physical SMMU. Wondering why do we need this?

IIRC, intel is mixing their emulated translation and accelerated
one, and their pasid table is not integrated like SMMU's CD table
that we already passed entirely via the STE.

> Also in SMMU spec I see other stuff like STE.EATS, ATS skipping stage 1,
> ... Here I only see  SMMU_CMD_ATC_INV and this is only implemented for
> accel. I think I would rather stick to the minimum in this series, ie.
> reject in case of ATS mismatch (for testing purpose you will just need a
> small hack until we get ATS support), work on ATS enablement in parallel

That SMMU_CMD_ATC_INV seems to be the only thing we need for ATS..

Thanks
Nicolin

