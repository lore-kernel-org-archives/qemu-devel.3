Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33E7CAC598
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 18:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyxAT-0007mV-Cl; Wed, 17 Sep 2025 14:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uyxAC-0007j4-Ib; Wed, 17 Sep 2025 14:45:56 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uyxA8-00075B-BY; Wed, 17 Sep 2025 14:45:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LE1pn8SA84a865nUYlxzcFlZDkItQkAxpLGPCoWWMEFGhpAGAmVCLMVo6QjyFEAAjLC4QTgVgznrCOvH1+ddYdag1M7UJZkssW53wGzYHRtPVDkEB6cl6NEIUxEppiw3QSZZogxQDRve7r7+PF+mn89H9j4KiNfIci8r61FwVFtgn+Fjaa8Qahqp0zQGwKkN2tCEpjdaFCsOTST8EpXUHi0wla5S35simAnqEydzgo/seJ4YfWn8DmIVw1/WO36ac3iqgbe6Dml6XiNJfJc+saw/iYRAUT1BJ+DVfw9l2A9gkFxPwhg3H1U9Fb9J7ztKKb/VEsRomUg6bNb5YA9Jdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iC7YJSnvKluXcnJNkKqa52Md3iCoqqeNfx6oPoYyA38=;
 b=C/1d32kI6RwIGAEuPPhqllX15O5YsVL7Lm+nhmdKHIpQcxM2dEtuw1UB5FVl4ggzCLOBO3C4jeWZVkOnMhCdwJg4jIl6fnkAJNMuu0htnvVVhvGYWDlM80P4GW5wywVQw9tEruZWFFoatcAyKFYmXgP6VORtG9qIaHxZtIPbBniNVQ4U/qgvKX2mdlSvD+Y02WVn0QcIK7lHlipv9y/Sc6BryNyRHQs83AmfpvPeRv1CGKvfuur2zUViS+WHdJzcxYtFKzNotRYkvrj21rCTSX2QJTIpabKg8q/PiPj/kvAdr2Wu7emwvKhCUK1uDaxfDLyt9pxPyvINQJq8SuhBmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iC7YJSnvKluXcnJNkKqa52Md3iCoqqeNfx6oPoYyA38=;
 b=qn69Fs+5xdnim+BIH4+1KY4tfyrFfjUiug2HndaF0V8CA93nK+2LMjdkMRvO+jvFpZrkYnnTWPpMP5Kq3aQXrxsClqQ+Fmh3diFjuVEYVQ9JaNNbQMbCn1w1sHSxI7VKB+VHuTwEnV+TzaV4y9O2vuFaTtUPB2Y6sQXEGKBNG5W9A3hJf8N2zfqyDAx95Pv0rFNZPJzYwxlnqRjcd9vcXoX4vg8Nx/cPMivA+7rlX4IxI826poP5tKqVwMN+ZPOknaR6D+5HUPBqwk9MNWnBzTqdZuYmyDSHxcq77kcKgMh2ZInp60E5+oM5GJ6+0fAnYLWSnhePikDIRwkEGGND5g==
Received: from BYAPR08CA0033.namprd08.prod.outlook.com (2603:10b6:a03:100::46)
 by CH3PR12MB9731.namprd12.prod.outlook.com (2603:10b6:610:253::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Wed, 17 Sep
 2025 18:45:45 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::1a) by BYAPR08CA0033.outlook.office365.com
 (2603:10b6:a03:100::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Wed,
 17 Sep 2025 18:45:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 17 Sep 2025 18:45:44 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 17 Sep
 2025 11:45:21 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 17 Sep
 2025 11:45:20 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 17 Sep 2025 11:45:19 -0700
Date: Wed, 17 Sep 2025 11:45:17 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <shameerkolothum@gmail.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>,
 <skolothumtho@nvidia.com>
Subject: Re: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Message-ID: <aMsBvSSEzsgeMHkK@Asurada-Nvidia>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-7-shameerali.kolothum.thodi@huawei.com>
 <aJKn650gOGQh2whD@Asurada-Nvidia>
 <CAHy=t28z=wrXbXOJjD4sFw0RxJR3fccqF-EdaQDB_s_F6RC4FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHy=t28z=wrXbXOJjD4sFw0RxJR3fccqF-EdaQDB_s_F6RC4FQ@mail.gmail.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|CH3PR12MB9731:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f90a896-21be-49b1-e8ff-08ddf61a68d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VVFXAxRSgmpHirpz4xj8Wia+KCziQMFcPagMS/hi6L1HnbcUgRnk9cOQAUF2?=
 =?us-ascii?Q?/wF4zRG6irM6uGdVfRHdFv9ZGTG6KsLbwo6cHXgiVz6+wH7Y7W38qO0pvUGD?=
 =?us-ascii?Q?P2iO9xiNZL2edpdIcT/7CwOGPJHnVROY+lsZEiUkiDmjXigy4g0rntmzI2jy?=
 =?us-ascii?Q?KsqiB8BKRDx61jEqJLIuv4WgPwM6qlCokRhaJ+cBqNOD4+vp7IbTqvAGBDyd?=
 =?us-ascii?Q?VU12vtZKvseCIdM6bDqVoyiuMZJj1ZbsQlElS7NP/tg0pAMtLbC/Z829MTlW?=
 =?us-ascii?Q?BpXLkuZBX6Z6NBuhgRiLqse1vbYbbyY4RguzkvY6mNiHFTQNtBpO0Ktwb+Rw?=
 =?us-ascii?Q?OK7kMqPfO2QrfsnYrzwOSCiELQohUuC/NdEaMw/243ZdBZvR9d07nX/kpR8X?=
 =?us-ascii?Q?vEKWk7tKA0FJMC505QuHEwHlUVOICnW0jTScl+OtYHp21FxDJqXSfgSmwHCW?=
 =?us-ascii?Q?I1JUJLDeI6MiEv3h790k9eh0kqeLQN/u3CQiaQQdg737dFcKUpuIVru85haB?=
 =?us-ascii?Q?/euRZGKn5lR7TGBxfE2zvfQ2B7fcfIPv8+K8hdPGXDMsNXtEjchaW7C/hCpQ?=
 =?us-ascii?Q?7zgZnMmvVJ6DAiXGeEgAn/eQu75Dvpeu8jx149/urxsFjuBHiURjqKBzMqHX?=
 =?us-ascii?Q?ra5rzvXRQsNpLdHp0ZC8HC3W6ucc35Cu7rjgdFtXeFkZ2GviZuO+G+ZkdnSs?=
 =?us-ascii?Q?Xl41wcpM2QZX32g9QUrGcLYNwrUm+JX88mprnJYBGLyubK45FKkrNNwNopVU?=
 =?us-ascii?Q?DOoCXz8oTN1+iCO+Hc9v7eVSsx7rz2IoCAOg/QAuEfXwQAWmElw95LDa1+lX?=
 =?us-ascii?Q?Xiue9lmUbCAuQSqlmjX+pMgzY+4/PQhp+OQZVtyasa6FA2qzvwtpECIjIhds?=
 =?us-ascii?Q?UmvG00LDWLyMAW2NdGlMHn9+ct0KZQg85qZ6PMPAfZywihxm/hvvPIwdYQOr?=
 =?us-ascii?Q?x8ck43gMLzj8lTl9rK516vESadSqaLUgvH+A2jrb5gtOqK2IqHo5At+N9Knt?=
 =?us-ascii?Q?pG5sW1Ky9oakWlENi+TvAenkvpMrp8xdo07XO92Vq8Q+vhb4eRVUjVtDepUy?=
 =?us-ascii?Q?PCWprPKhTbmz2t4iFfPgErZELQEzIxHQPgQdqWLSTYsoxENXpPO4Xigaqrza?=
 =?us-ascii?Q?+Dg9xZTPIbdmS/Yk5k+nq0hqyW6OHE3P4pb7Rjq6ItwEKBDPlofSCC+MDk8n?=
 =?us-ascii?Q?8exOfeTVGDsHbwaOMITglkx26G7COPttlIcfq1K8rF9RIYy5ybuB76VhsrTt?=
 =?us-ascii?Q?9w0AQpVA7mLpSpIl17FKUFHYgKJt1zmCM1QxBq4/TCw6u7MCcaug0dzsIE+2?=
 =?us-ascii?Q?Dts1oiwAP57PQLBs5hyqrUEyKbjzhYyDmrlcRDDK7vdtxdY4bZjrPlhMJo/3?=
 =?us-ascii?Q?V3AX3nfpF6uaQh5og1n3/wjAnpx86XsFRPHtwF9XE9r74sdSryqVc+U4yRl5?=
 =?us-ascii?Q?xUi6E0W9bGObI9VAha5W/dmxq31LhTVxjsDp5cLoJvnc+kdTp55qG998EsxP?=
 =?us-ascii?Q?EXd+n1YiUsws5/Gx7qsJibXqNAfMfYVFMSwS?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 18:45:44.3432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f90a896-21be-49b1-e8ff-08ddf61a68d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9731
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=nicolinc@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
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

On Tue, Sep 16, 2025 at 11:33:21AM +0100, Shameer Kolothum wrote:
> > I found a new problem here that we initialize new as_sysmem per
> > VFIO device. So, sdevs would return own individual AS pointers
> > here at this get_address_space function, although they point to
> > the same system address space.
> >
> > Since address space pointers are returned differently for VFIO
> > devices, this fails to reuse ioas_id in iommufd_cdev_attach(),
> > and ends up with allocating a new ioas for each device.
> >
> > I think we can try the following change to make sure all accel
> > linked VFIO devices would share the same ioas_id, though I am
> > not sure if SMMUBaseClass is the right place to go. Please take
> > a look.
> 
> Ok. I think it is better to move that to SMMUv3AccelState and call
> address_space_init() in smmuv3_accel_init() instead. Something like
> below. Please take a look and let me know.

[...]

> @@ -37,7 +37,6 @@ typedef struct SMMUS1Hwpt {
> 
>  typedef struct SMMUv3AccelDevice {
>      SMMUDevice  sdev;
> -    AddressSpace as_sysmem;
>      HostIOMMUDeviceIOMMUFD *idev;
>      SMMUS1Hwpt  *s1_hwpt;
>      SMMUViommu *viommu;
> @@ -48,6 +47,7 @@ typedef struct SMMUv3AccelDevice {
>  typedef struct SMMUv3AccelState {
>      MemoryRegion root;
>      MemoryRegion sysmem;
> +    AddressSpace as_sysmem;
>      SMMUViommu *viommu;
>      struct iommu_hw_info_arm_smmuv3 info;
>  } SMMUv3AccelState;

That's changing from an ioas_id per VFIO device to an ioas_id per
vSMMU instance, right? I think it's still not enough.

All vSMMU instances could share the same ioas_id. That is why I
put in the SMMUBaseClass as it's shared structure across vSMMUs.

Nicolin

