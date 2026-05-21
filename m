Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1199DCD5BAF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 21:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQAqe-00010n-6Y; Thu, 21 May 2026 17:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wQAqB-0000y0-6h; Thu, 21 May 2026 17:22:08 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wQAq7-0000gZ-Ic; Thu, 21 May 2026 17:22:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cHYAU0veo++RHa1J60IVTsXzPLpa1AcCWe0szCXMETcuyYmOmZXjEq/m+xw74OhgvIVLsROft2uiRxR1Rpa9SYXuYp64EsxsRrcOTHEJMEZpnd4xohLlY94KA0KXkZRy+LCehVsQ2BXiY8i7U4km5I48KQh98E8cnya0QHPzxfB0RNXkBDndfHdwTAtaQcFtUq68jebbavaNsoJYH+M5KlHTcwLu5Ht5sPAVKmQ8pNg7UaxFyYFJf4MQfvHcFPzMoadB/IByV+5CNa8ssTl6Iu8KHSkUFN9LuDVdOPa21Vr4z2g3m8ah5ywbe6J6u1VMSZtDOkK22uZkvtWu20Bd/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPqoc2818VM2+ILaPtUp67f2gSSayn56I+Th2iB8H9k=;
 b=R7mHqqh2qNH2YjC18JrMlBmV7Zncyhbnz4jMc+FsZfLe4uHcWPs9ucY59M+iEnmV09PyN7U5hj80Rof1dghfUy+5Aun0xzJyhSMdrgyvBqFBuhG0wqszoQ64/0eiiLvtsboVr19g6NKMhuGXIHHXFYXDWlHlHf7/u9sp6i9SgehVM87VF4kLxvGDNS0fjHFWQGcDbby/JpAe4GtRx1mh4dDMW6pDcTrHFlMBcRux7BFXFByTWySOVRrkydJRt4PG8M0MfIVFQE5s1fCy4y6OUnI4HIbwZjHT9+XKu3KVVvMOzKw+7Tgtg3ffIc2KSQxwlpXbe6WifUr9HBq/YzKXhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPqoc2818VM2+ILaPtUp67f2gSSayn56I+Th2iB8H9k=;
 b=IAPzVjibwk8xj63n6IrX7boqoOh7KVgL9L1CIMXl80OLi3Vdb6NhLLKVYIEL4eF7pZ5YfcLqbVQsGt9gGc8cpRbw9khnbJa/h/ktu6aVIIen30wKg5Lj0FPa7qmKQTIKPt2I3bXhhFDTZgI+/M03PhxMLmotHRAl+CEqeap5Ikmbhb2Jv83ZYJ7jw2QwsigoqpHVtKe3ZZRyNmcDHdTzD/EWw0+PnSNepxd4ot+Ypdn+316Yyn3Aj5XP/J2o6iTsi4/C5bR+mJAhZjmAaJ6HgPTh0nhmh5vwTM4WwOKLiTBHf7YOV/vNvM3+opdIiDV44lPhFFqpuKp1yo/l4i63Ag==
Received: from BN9P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::22)
 by PH8PR12MB6892.namprd12.prod.outlook.com (2603:10b6:510:1bc::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 21:21:48 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:10a:cafe::ce) by BN9P221CA0025.outlook.office365.com
 (2603:10b6:408:10a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 21:21:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 21:21:47 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 14:21:27 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 21 May 2026 14:21:27 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 21 May 2026 14:21:26 -0700
Date: Thu, 21 May 2026 14:21:25 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>, "phrdina@redhat.com" <phrdina@redhat.com>
Subject: Re: [PATCH v5 20/32] hw/arm/tegra241-cmdqv: Use mmap'd VINTF page0
 as VCMDQ backing
Message-ID: <ag93VQRqquJe1TOo@Asurada-Nvidia>
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
 <20260519103727.899332-21-skolothumtho@nvidia.com>
 <2a4edb3b-064b-4c46-8737-1bd74d5f22e9@redhat.com>
 <CH3PR12MB754807F1C34CCB89A73A219EAB0E2@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CH3PR12MB754807F1C34CCB89A73A219EAB0E2@CH3PR12MB7548.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|PH8PR12MB6892:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b657397-b489-4093-354d-08deb77ef799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|3023799007|4143699003|11063799006|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: PX9h0gxrvo/05mROFri3wbpm6y6Aj1HwG+PzH5LbM83RSqd5jKMVCY7J9PCRtV46f4W6dtOZ9A69Zzu0c2iLpfKF6pVN77emJNUQnAV/3zVjjTB4eXZrUd64g2ADw90EeQj3ZWzKxqVCyZPG5KdW9M2tzwjtv0w6YLxjsystxNq19Yc14c19nOE3yfKP6rJ4X5Tkvrr4zRYZIrdKlabEFTQDuFbFJ7vPgdr42HDXDmhdsMQebfxeiIuoKo6yL3M5LwKqktxUOI8SjR4ChpNeBgupWVsL+YXieFNJasRuJk2yLQIZcpalbuBYFpw5c9CnpRSWALAwVjaU4gYTpmRcT4SQa6pQEhlchIMUuBHZCFxhD3E7IBtrOv7NLtKQPL8wH0kyT7/Q8WWi7qcMVGb/PuS3KeXmzYrxqgaJMlEHcv1IiWQRMov4f5hUozIpqVv2qnXwvbjoF/nXsLFiGo8nIts41KPxzFVPtg6MpfCGmMB2eSgWfSqPw1q2uj7FaStiUVRHGCawxbZ4qaXPFOad+KrjQi8E93iVrSpMs+IIVee6fZXsT2v82EgYqDjNRYUk8dxqm2wI2GAgdQpzdy+ECe4yTIe1RKwaLDvnG0MJErC4HPUmKP7oPJqx/FZ1XlwcYDbtr3KPr3PzhTEBdWvkmcMIDguP0RUJtYKH4K/B4BX/qy3MRLoxacf+RKKvbocbfRzVFtuGUVQopvgBAknxPSBYGMP177fWwuk/KqyFkMI=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(3023799007)(4143699003)(11063799006)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rGRc7r4jdYC3hB3FfBPy8c0lAwa4eQcXhts/O5W7QmVw1tIE0SZM2WVeTS5xv7f4S3w93wewNA7jJZ84X2gSqJeoZTrfvUMAr2jYm3cIeAefOj1jOWDYX9Z+tOU3KyS3q2HPYAEr8kvBSWbpvhOT9tpvRFAHyWyIHeIjJejgcwezK3elJBs0PxdlYY4+2TuFikcPCuPQ/zWA3epiPWxShSm3j3SXy+9+Ok7yITtPVstir5bUNhUDe8c9zLHY23gR+AcNCLGn4VZCjwHGaEgAA8N6e9Yub3xcEisY+MGArH3Qaaa983TeWr15+X+eZDMz9c2TGBsSK503N8bx2yRlFpzRGZYI6mdRH9UZpK1SND8QB9L2r6GPTMi6QPpZ0RADggT2016kGYv0nR5bcuKsgYlJflaJ4r5JAiIp9PXF6MwadohYTQPkhu8Zok97DqYb
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 21:21:47.9512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b657397-b489-4093-354d-08deb77ef799
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6892
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=nicolinc@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, May 21, 2026 at 08:46:07AM -0700, Shameer Kolothum Thodi wrote:
> QEMU advertises 2 VCMDQs (CMDQV_NUM_CMDQ_LOG2=1).
> Guest allocates vcmdq0 only, leaves vcmdq1 unallocated, then on the
> direct aperture for vcmdq1:
> 
>   write 0x10 ->  A_VCMDQ1_PROD_INDX
>   read     A_VCMDQ1_PROD_INDX
> 
> If we aliased the direct aperture to the VINTF mmap, the write
> would physically hit VINTF Page 0 in HW at an unmapped logical
> slot. And the spec says(p.172):
> 
> " If no Virtual CMDQ is mapped to the Guest, or if the logical CMDQ index in 
> the Virtual Interface being accessed by the software does not map to any Virtual
> CMDQ, the access is dropped with no Fault/Interrupt."
> 
> So even though guest is using the direct aperture, in turn it ends up
> accessing the corresponding vinf page0 and won't see whatever it wrote.
> 
> I think this contradicts spec p.176 where it says:
> 
> "While the software can program the Virtual CMDQ(s) directly using the
> direct VCMDQ aperture (and not through the Virtual Interface), it is
> required that the VCMDQ be allocated to a Virtual  Interface before it
> is used to send commands to the SMMU."
> 
> So the spec allows register programming through the direct aperture
> without requiring the VCMDQ to be allocated first.
> 
> @Nicolin: did I understand your earlier reasoning correctly here?

Yes.

Nicolin

