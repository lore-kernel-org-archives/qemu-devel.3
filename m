Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8292BFF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 19:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJzNs-0005Bj-O6; Mon, 04 May 2026 15:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wJzNj-00058o-7X; Mon, 04 May 2026 15:55:07 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1wJzNg-0001UW-CO; Mon, 04 May 2026 15:55:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHisFI0xKRFAcASBLF1MS9AaklBjfpcQkqTC4MJ7FFkYvA2nseLVGfVHE4dT+aSPscJVGjgj9pfIObpEDmplNRI0hMT7oOMzlKENhgEAqM3dSgf2PEXQLr5eIy6lMLT1sea/uflaIeQQ6CGmt8AKa7Ap1TCI9ver85KPWCEyFCE9z7Kjs74Ffn7g77NjVpOhXDrshvqBCTDii2mJq8cpbvRzXpwvjIVWUSkq71N91KIhR5msY16yp3rdCwga837BqnFwt5YafsMdyMDvAxa5Y/BBSHQNxLVYBYVve1qwMTM03mEg+WgpschaKmMelw9Lk/ivtkbBQmyew57z7IhexQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77g4e8nvQUqMHDsbuhsQM8TpdWi755umfgPDpUiDkng=;
 b=Ieho9h3e/FpJS/d7OBQJ7KRwpM1cKJB4YmxU3QTIu3Djt/yjmjVrJBXkTy/cbP1tAVmXOsz4njFNdt0J7Q9EeBCfXVKHSMFccLZff+bnBqGKsItP5/TfhMQ7wWHPUHOP7AVQVw2HoGR98kYnto1q9roqVhccDRhS97DjYREp+ADH/snYbLlmaYCv1McGgI0yivVAPA4Dy/ZJjtiWOz0RK/xSOzNGFUE55iKDsO1d1oyw93KQyfevCWsH6NLZlGkaUQNXc7mhG6DY0J5FZQ+RHrBQLjqSKtgFl6GluOPx4YiCnAPWhTpVOYYaRkh4aAj5bUNlKzvdzTmJBGXCDJPvCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77g4e8nvQUqMHDsbuhsQM8TpdWi755umfgPDpUiDkng=;
 b=l/AmQZLsAclL1X0Xbc5ovJfbGYmW99nVL/hdlr2lLMhxij3IkdB7Y4LbBZG3QaT+9k+cWXp3WkQ3XPAzp3MBBhcFRww3i4k+I4gIZXS4Cy7Wbp3F8RuaYZZkzFA42pQiHO7hgKCtnvEto0SwoS6EmWTbQyKHMqdRDKXXI6xef6fyXKEtBQp7lLu75EgQ/7x87I8FBNmVD4urlrCuy/lo0SoJQFzuZsZ1Csmgwn9wRA+1GKKD38M4ECG3PIwIJ69EjSOPotn5Dob4Xb6s7z9q+pVacI3z3gS6d7FW0CL152+yfm+TQGDOaHT2ttaud29HEjyDS7cCASc3xJnboCw27Q==
Received: from PH7P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::25)
 by MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 19:54:55 +0000
Received: from MW1PEPF0001615E.namprd21.prod.outlook.com
 (2603:10b6:510:326:cafe::7a) by PH7P220CA0003.outlook.office365.com
 (2603:10b6:510:326::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 19:54:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MW1PEPF0001615E.mail.protection.outlook.com (10.167.249.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.1 via Frontend Transport; Mon, 4 May 2026 19:54:54 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 12:54:28 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 12:54:28 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 4 May 2026 12:54:25 -0700
Date: Mon, 4 May 2026 12:54:22 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <clg@redhat.com>, <alex@shazbot.org>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>, 
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>
Subject: Re: [PATCH v4 13/31] hw/arm/tegra241-cmdqv: Implement CMDQV vIOMMU
 alloc/free
Message-ID: <afj5bkwFwAJxKIel@nvidia.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-14-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260415105552.622421-14-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615E:EE_|MN2PR12MB4222:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b4454d0-8a4c-4068-a044-08deaa1702e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0dRNemlgHMnsCk9sSecm5DS17JGEuoczDXyLRYvgsqU472o5+lKN7ghLmhGTjQBrsj7pvwwqCZaPkS8JjiGnuSeWx2AlgIQMzDvLEf/Y2Q4FSf7MYvFxAWFmy72kKRKyjr+B6GMS847Aok27fvuN3LtTWONvo+B3B56Rymu3/US/PsCvOYNMvlsZBQc7ZNNAf+l/gZTAiy9ETBWQx7Rz5Nf/ArAsHYw7b/eiqb4g7ts0u55LyDBBv/T2/ABPARFKB2qVt/rjeBXRSvO9lBQIswSbCZHE5T3m1RQS1F8D4wsA+5nCrpDvHphBWfHvaQjlnArDWFrqpSLGnmj/MgWn5KARuaFbxvxHmoCXxPBuf/H6Gh0wqTTOTAHJDIvac1kzTx/ZrjeI7KIxEAJWenQIkUVhnFn+QBtHo9l0xFuDMmoakp7KGOR//mqN557t35HJ3pmL1ws5rvD8TDpB7etCxwAFb5nJ9MOY0Yx3tILoTXXgwOq7sSMaRcF93A+wv4k1L5sw12NABc732RUfw3fOQ9dN72Uu8SYgzajilHO8KIAlvIZiL9MQoCu1OFSHJH0a03ikW/MeY9T+ZxPBT2povye/a5uVGk5x6+oQY9JcCcTRvc0XKeUA4lbLoh8HFYtLpZ2LE2Pkjlej1ybqkSmrNOqqYiJiaFudSYaqY1M9yki2aJJy6BY1j25OuiPUmaEXH2CmKy4AkSwNPJpanCtkYyrvJJmi7GrpSrZJedVnd68=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: r/8Z8rEg9YRr0OXHADh+t2oEMsVa6bXbaY1E/iuOMSI5Zi6A5ea0LTKS8XHf1UtD+wLVdte6t/sn8BOdmHHca5ODD+VxFehVXasv82gurB4CNwm33imNYxWg3nxldg6BSq3LQH+VzEo+ZhDr5js9DoCzZIxw7jeHC1ht2artZ87etr8++hXpet4F6PiWImQ79v3yYOA717EXUznTvqDpxzWjpNVJV70/qV0211RmscLXy3MgFHf0uEN4vO+9KMZmAgz18tKBM+KRoEmtrIqnX77H7Enfy3pZE6/ljOKLlv7RznqL5SdU9B4Uu75V39OHMXNR/OKQA/kM7T62eHdV38PjfSGOVCXW8EBkVPUW/KgHAYPt8A3giOd0HmN2tNh9khiFTuKp09Gaohn98D87MEWpuGH0HR88QBnuLpKNyOUSRCY6ZZTjgqLjRWxl/+Ls
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 19:54:54.2540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4454d0-8a4c-4068-a044-08deaa1702e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=nicolinc@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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

On Wed, Apr 15, 2026 at 11:55:34AM +0100, Shameer Kolothum wrote:
> +    if (!iommufd_backend_alloc_veventq(idev->iommufd, viommu_id,
> +                                       IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV,
> +                                       1 << 16, &veventq_id, &veventq_fd,

I forgot why we use 16 here. But perhaps we could do SMMU_EVENTQS?

Nicolin

