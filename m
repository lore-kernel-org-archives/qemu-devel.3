Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D623CCD3439
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 18:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKgsl-0008A4-HW; Wed, 06 May 2026 14:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wKgsh-00089X-S6; Wed, 06 May 2026 14:21:59 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wKgsf-0007cz-VP; Wed, 06 May 2026 14:21:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZDM0DNsHQhxNn2C5XYT12V76AXz8PlUyzwPbkvRP0TA5DKnocJaL2b0rtpbgudb8vGY/2sMCkEVDr6xak0IzmbreB1vTEdfJZtHNu8gvUEsI4tBD3PHhzizqHYHWt7KWjLWMKxBlkvLutS8pFKLqNK2H7gbTkBbVORyggVVFQD7wbH5mDkIECcXspEPMg/CParqZsS4jIM4zfRVSJASZH5IjexXy8CVnrap4VnmrdHta93OB93ZLSHUv9UdzA05Yklt5ZcAqJk4FwLcldS1jy0ORUb5/PewwUXhZyrY9UeNAOUvGZ/cP70PNWTjQFJvSmxCAAJXUB6fj+Z/Nm5phFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jelYwqfb3ouAi21jR0uC43s0TJO7CXDUTiQgYxDHCI=;
 b=p1iwpGv+1FX4Oiuds13wRS5zNKBYwzptmVFQfoS1cG+7goZ/Cwmc33hR6pdqGQ9X1bWOacJ62ZRc3WyZmjrFD7djLdb8JRKDiAPTfZC9yn1rHr+wBLCJW0i3vLnv9TOo404R0D6tLEvMKGPO/vys7TadNSGFSqO4W8t18O16PaooJ2TxRhM+xBWMWAEHEQYBd84Mj5rMe7hp8Wx/a59AWa+gq2KzzByDqB9rxNtJ/T2ZuUbV5KPJ5YQONcIMyEP1XSRLkLrbWWO5rME2rF+E0RGXjvfpsuPm13xWnijE2PuIYRXMPJz84u+J0qoUz/jnFlV6Sfv/bkHUU08J78eyhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jelYwqfb3ouAi21jR0uC43s0TJO7CXDUTiQgYxDHCI=;
 b=ENWjnHi4qrUR0XeH+XxSTlpG2Ooc+gr8+YWpnQl+3X/Hpxi0Yfut8lGSLn/OQ2KkJ1VOsW/Q7ZiR6Dqu3OJjLQdefyZZWU4wfQPj2oLloK2+d/Vd0FVhKCFF3KgLtFhdd7q3XCVYTdLRRdVycb171kedhg0rpkn1n+M5lQPs/yKUyP35iAtSx0LzhgiOTLo+cKuLS+6Wb/4ktpRtUtVUX1GlFsfAFj/SEimFXEp1b7vkp4HPkYC5jfkObKJFcxvLex0Yp6oA/fZoXwneNdTNvIxgrlJ41fyMC4Ht5IV6T0Z4iD287X+/GrVkXJzm+WXKKTG0UUH6bg7lfS9Ns6t7EQ==
Received: from BLAP220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::32)
 by LV3PR12MB9186.namprd12.prod.outlook.com (2603:10b6:408:197::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 18:21:48 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:208:32c:cafe::14) by BLAP220CA0027.outlook.office365.com
 (2603:10b6:208:32c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Wed,
 6 May 2026 18:21:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 18:21:48 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 6 May
 2026 11:21:26 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 6 May 2026 11:21:25 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 6 May 2026 11:21:22 -0700
Date: Wed, 6 May 2026 11:21:19 -0700
To: Eric Auger <eric.auger@redhat.com>
CC: Shameer Kolothum <skolothumtho@nvidia.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <jgg@nvidia.com>, <jonathan.cameron@huawei.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>
Subject: Re: [PATCH v4 19/31] hw/arm/tegra241-cmdqv: Allocate HW VCMDQs on
 base register programming
Message-ID: <afuGnxABp8wa0bMt@nvidia.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-20-skolothumtho@nvidia.com>
 <db7e22fc-f4e0-4caa-894c-fbffe8fae4b1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db7e22fc-f4e0-4caa-894c-fbffe8fae4b1@redhat.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|LV3PR12MB9186:EE_
X-MS-Office365-Filtering-Correlation-Id: 74c0e9a0-c48c-4a0a-3c0b-08deab9c562e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: CP6GAi9qE+JU5nLhRb/tilxo0DbNGhPiBzCD3wyNdkZX+Gn1fU14h5BsqhpEzMfQzg7csCNo3NDCfSxYg698Zc+LMaHGJnQFruIQQXX4c1H3pIMk7vxlpO0SLuUXXXGhiaXRnqOLU95UGh41kXZoPXx9Jp/Q+kC5d/cv3VXA+i0QQwdcujTin8jfbskNgyVn+U6AmLMB6bXRkzT/8/dAjYywB6HbuYxyCLrorKarh+tIMzckts2I6XovyLccAFXnb6r+52ko61GayQlG/mY1KvmPiGox0q/nvZlWwod2B1uMROzhODCfhPiDo+UcQ4x4yHSZbH1J9NEnQQYtg7jFEMMtDpqT5TJ5iDyQJWqFQXSCUPAGWFYupKMG3dWKt4HOelJYdOepp7A5tUNtkX/nNBVkwU5BaXR+JWF1jsD8sO902MRxg4Gx5NDjmsB6s1e4EKblVv2oTgkTO+/IKIv35PBVCigJpSmZzkvCoCm+EA2wxz6KF7fZdM/sZwQuVmkk/vEuVsvrWd+9E/KrvGcw9aXynOADYyBt6yjpcqwhDmIVqjMXS1taeJZ+USKypX9IqRTtv1ZxXaK+/cxbjootIlQNI5T8Y61YtrcFCrqxtNEuQPGKtHDDZwmlopcxfh8KeuMTUaHm/MqONjtNAadWst5fG9s138nP0RbsjBfyz9uMmZkRZrQZRW+NBQbQiTInEz2cB5vRwnjHCDW4Ujs+H5/r+kcokGS12O3QWQ5OJag=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1m5R3aRXjxWj0dgmBV3nhuwJxdzZqCi0yLbWcDLApXP22QyLF9rP54qAJBhIWsJatoV8W58V5PsF2/oS4dYlv9wtGVMiMxXzDX7l8aJlrHfedGH50J8uLmjWQzMIrGdGILNWkhj9Ngra/C5L7FpVDMVisDRt9Mq2+lY9VaKSs0R6HeyDG3lC/bcGGoUpEde5HYeZ4sOSqFukhPuYFvK3/3Twx+NgB1T0ppM6W8yVlsQb1iOznlJSW5TWlWWXgGw5qxoawXh00uPPPfQb1SF/0XGh4M7RgisGIt9KQimOuquOQFjiYpJAhva+TEGi8T13dXFihcCul5AqVFZbefdkAQChR2nDVz6VVfhlaki1NPy6t9VGyXRALruzWR2ne8/xYFDQ8M8zQ8lqSnEbNushVuSUPKpb+NLgO2YuNGz+GqJcDkAaLv5E9pPgI9dyjg02
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 18:21:48.0072 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c0e9a0-c48c-4a0a-3c0b-08deab9c562e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9186
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=nicolinc@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, KHOP_HELO_FCRDNS=0.4, SPF_HELO_NONE=0.001,
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
Reply-to:  Nicolin Chen <nicolinc@nvidia.com>
From:  Nicolin Chen via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, May 06, 2026 at 06:51:24PM +0200, Eric Auger wrote:
> On 4/15/26 12:55 PM, Shameer Kolothum wrote:
> > +static void tegra241_cmdqv_free_all_vcmdq(Tegra241CMDQV *cmdqv)
> > +{
> > +    /* Free in reverse order to avoid "resource busy" error */
> > +    for (int i = (TEGRA241_CMDQV_MAX_CMDQ - 1); i >= 0; i--) {
> > +        tegra241_cmdqv_free_vcmdq(cmdqv, i);
> uapi/linux/iommufd.h says:        
> * - alloc starts from the lowest @index=0 in ascending order
> * - destroy starts from the last allocated @index in descending order
> 
> so this seems a requirement of the uapi if I understand correctly

Oh yea. I forgot I put there too. Fundamentally, it's demanded by
the HW contract. But I think you are right, for QEMU, saying that
it follows the uAPI fits better.

Nicolin

