Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E2FC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 23:20:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubovB-0006mY-Td; Tue, 15 Jul 2025 19:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubov9-0006l4-Ti; Tue, 15 Jul 2025 19:18:47 -0400
Received: from mail-bn1nam02on2054.outbound.protection.outlook.com
 ([40.107.212.54] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubov4-0003xl-Gw; Tue, 15 Jul 2025 19:18:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHZqnzOwJZHptLvOAb5h9I4MSNz3fw+14tJWE24fZIwsk5xSUADlBWinlMBoMAHD6GdcXDlcfz+6tZtK4113txZwQAze/cqdcvLa+hPK93ucggXENEovSCBiz41uf3lRChfynl1fXu35D2hJGda+LhdqswP3su9bdhaQ7q/pzypZEmeuX0dHQMOfn45opOB2BPRBNXRgYMbOsVDALnSUlq3MdJQLck+jj2mU8+VnlQBlkj+D7lEu9I2HwJJVExUVmbq/Ja3j5lEon6hgYTOp1RkRB32kn0lDRsrD84PuxFWIxVatv86+CAsNuv7ctHAXCOuSoD4oP7otsKYJSGwxmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZeKyrPckwZq7I6z7s2VUiK33kASBwDNWOhMGmWeebs=;
 b=T/uxiz76dHfxLevVYyQWEPLfhw6MTUu0wOAHR23sD91N7iMV8HnHJiMJEQ4SU5tMuIo1lkJfddRjiQed7k/ozHICJnMaOZNIQ/MPOIIGVjNf7WZD+Stwti/EsC3z6oKIpH1NAqlGqHOIPCBu3YU5T/PskZd8YX8zpJGH5PIKRSyTBM7kFrnpyc/RPESe4GqdKnXSYbbr8/XG6VufxVpiwoehdHLCSh65gktaGz5ksGVv0QE5UzZwEkm68yN3QzCof4VcJ7YGmFtd6l2oO/xAHfk286N68Zwmyo5wCopif3Py78CWSFuiG46lFHPnk8iMRwgMd2ZYt6vLPrx56SFaqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZeKyrPckwZq7I6z7s2VUiK33kASBwDNWOhMGmWeebs=;
 b=syAqNbAK8p89NM8nG7L7rXNG5dzYx41VooaMYzA+rAAPpJQFM8uTBbPh0ZtuuFtIP0tF8MlfuXTqu8HVU8VwyVqsRHfJFXmXV1uihZ2/oS3W2m1DJOypu291+DfkcdF0jTbbN+jYQXyxoE+78hl/SeQIV6nEke7KuxFVvJLHO6cFn3L0YJnW+RO4wuKX4Y4QlOpWEb4gtri6YplAqvUoH3I4d0JM2kbPYZRKdJukRY+4j+g+4SmXwaEjEQA+K8yD5o+AL2+EIukMwCn8aoym+11Hwqcc6th1bcKCMLrUzwcuKhMJNuhDcQDPnh9lLj04VgGV0DjKIUctn1IKMMPB/g==
Received: from BN9PR03CA0549.namprd03.prod.outlook.com (2603:10b6:408:138::14)
 by DS7PR12MB9504.namprd12.prod.outlook.com (2603:10b6:8:252::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 23:13:32 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:138:cafe::a6) by BN9PR03CA0549.outlook.office365.com
 (2603:10b6:408:138::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.27 via Frontend Transport; Tue,
 15 Jul 2025 23:13:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 23:13:32 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Jul
 2025 16:12:53 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 15 Jul 2025 16:12:53 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 15 Jul 2025 16:12:52 -0700
Date: Tue, 15 Jul 2025 16:12:51 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>,
 <shameerkolothum@gmail.com>
Subject: Re: [RFC PATCH v3 09/15] hw/arm/smmuv3-accel: Support nested STE
 install/uninstall support
Message-ID: <aHbgc8LXuuuJ/cz0@Asurada-Nvidia>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-10-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250714155941.22176-10-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|DS7PR12MB9504:EE_
X-MS-Office365-Filtering-Correlation-Id: a0b5837b-3d8f-4b47-ed9f-08ddc3f537a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|7416014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G2TcJxJLDt077pmij68294450sKPy4i7aESEdhJ4JKoglRNlOxomlmT7+YuW?=
 =?us-ascii?Q?4wEH3l8Y5GvxvUE+iNdtHbwZ3OMkWpwT4Hj590r3TwTF8uw9A6w5fDUD72GH?=
 =?us-ascii?Q?H6E7TbikG5WSDvRr5JGb3Q91Ii9xlakPXnKpOhqJhS0n14WYiY0/Ka7fkzT1?=
 =?us-ascii?Q?+lE2NdTFQlYTAZZGnpE5hLEazssBviBdDNxdaNEY+tuE0B3AOXJrflQ1EHwR?=
 =?us-ascii?Q?cClnN1aee6X+Ww3ZzLPDZlAl+0azJMPCHTMnNUId8Hk6/Ty9IlW++zT6jh+8?=
 =?us-ascii?Q?xKao084wssuYasiUOhgGFtokmbjAY2tBg1wbKgfqnLRYYGlYdMC+aZp83N9P?=
 =?us-ascii?Q?YJjl2rMTeqRec/gIP9IIjXAqxadovqDg4Oeej1XhRKVusOIrCdG3QhwiY7Ge?=
 =?us-ascii?Q?HdZlB7YJQxkJy78wo/PeNVWf9MsqJ3pPsJK3njA7DoZd+wqtWl8ZjRFhkNHO?=
 =?us-ascii?Q?9sC7t6Yab9G8PHAnYyfPW+iVVd5nzHh6YRAvKozjYgfqCbmyG7w0h3L1Zyrb?=
 =?us-ascii?Q?rCSHMFhcFOHUTCyq9M4xaSUljakW8CoUJJMhCFg4sJVOKfJg/UCrkTsLj5Jg?=
 =?us-ascii?Q?Z1/DFzWh1Hqo6pyE0AwDjvpdnQT8uOTxiYCSrqIRpUudyzKxDd+53fIpzutU?=
 =?us-ascii?Q?Vacw1T1Pl82ZMdrfcCOL7P2QWS87Y84BibD54N3d0Z3npQezex6sSq1qiGK7?=
 =?us-ascii?Q?ZmKxsxKiN2ihydJnTBmkOV/dtnod+LN3WCaSgeTJVDUuUREuJ9E8MOz9uwKZ?=
 =?us-ascii?Q?0XG0ez9f8Nssx7bAU0neNXQg3Y2xTkv0MPhK6fvUS6Caq3h7zXFQNN2E6uUk?=
 =?us-ascii?Q?GIb6eRuXrc5L6mkMn/J0uWFAOpp8bmwd5gRq9nLMZEstP3ptFmFk5reUMxUT?=
 =?us-ascii?Q?KuFuSuTmDDQhd3YwrKC6E3Q032acNeSoaOOTNedirWWCA6lkBNTO2wJQmE+u?=
 =?us-ascii?Q?jMLEV/MwOvqjodUYJqAEBiZZMyMAFvhpdG5kMzUSNg2LlS6NPDP7omd196kP?=
 =?us-ascii?Q?SE0kcn0c46yq85aYuT8EVewzbjLggGZSN9XpMwkaIs0Na1I/P/z0SaxBrTtD?=
 =?us-ascii?Q?sXoV6VAczZkUHikUTx2ICmo681YWlYw27mZAcEaFcUb51ZrPM7FcfD2qOwpe?=
 =?us-ascii?Q?v3iNgfOq8VFE48OeHz46YiOeygvy7tGKN3XxOtjnWIqBdfUImDP8s8NU67zW?=
 =?us-ascii?Q?IcifRe5uRnnM7Uo7LRm/Xc+msDG07rfV0We+rR4GcjT/JkislHvfGiUdeMTZ?=
 =?us-ascii?Q?J40m+nhgOzTmZMvm5jheQSA8zp0AdBZWRfTcj55JMVRtmsBSJw//BYFCmhON?=
 =?us-ascii?Q?TLYMWMStIvOm2Ty3Sep+PM2JZjHCLlP3vI0cUjeaX/Z6X3Q1ffRd8Iz+zRyb?=
 =?us-ascii?Q?O/nJh/2zkFPADJBpJW3jOHo1EiIsB2N70MBnhg/FhGYIvd/ie82kWluaJqOR?=
 =?us-ascii?Q?+liI3gHUIdOOZN88gI8yw690YNsXEVDuMDat17DeD7x1BRiFliBdHNfwzCR3?=
 =?us-ascii?Q?4UyP18d1NmrU+spxB7scoJj8e00k01H06pC+?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(7416014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 23:13:32.2740 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b5837b-3d8f-4b47-ed9f-08ddc3f537a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9504
Received-SPF: permerror client-ip=40.107.212.54;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Jul 14, 2025 at 04:59:35PM +0100, Shameer Kolothum wrote:
> +static void
> +smmuv3_accel_ste_range(gpointer key, gpointer value, gpointer user_data)
> +{
> +    SMMUDevice *sdev = (SMMUDevice *)key;
> +    uint32_t sid = smmu_get_sid(sdev);
> +    SMMUSIDRange *sid_range = (SMMUSIDRange *)user_data;
> +
> +    if (sid >= sid_range->start && sid <= sid_range->end) {
> +        SMMUv3State *s = sdev->smmu;
> +        SMMUState *bs = &s->smmu_state;
> +
> +        smmuv3_accel_install_nested_ste(bs, sdev, sid);
> +    }
> +}
> +
> +void
> +smmuv3_accel_install_nested_ste_range(SMMUState *bs, SMMUSIDRange *range)
> +{
> +    if (!bs->accel) {
> +        return;
> +    }
> +
> +    g_hash_table_foreach(bs->configs, smmuv3_accel_ste_range, range);

This will not work correctly?

The bs->configs is a cache that gets an entry inserted to when a
config is fetched via smmuv3_get_config(), which gets invoked by
smmuv3_notify_iova() and smmuv3_translate() only.

But CMDQ_OP_CFGI_ALL can actually happen very early, e.g. Linux
driver does that in the probe() right after SMMU CMDQ is enabled,
at which point neither smmuv3_notify_iova nor smmuv3_translate
could ever get invoked, meaning that the g_hash_table is empty.

Without the acceleration, this foreach works because vSMMU does
not need to do anything since the cache is indeed empty.

But, with accel, it must call smmuv3_accel_install_nested_ste().

So, I think this should foreach the viommu->device_list instead.

Thanks
Nicolin

