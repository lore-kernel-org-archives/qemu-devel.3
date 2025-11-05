Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B58CCF9E3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 02:47:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGTXj-0002np-S6; Tue, 04 Nov 2025 21:46:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vGTXK-0002d4-Im
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 21:46:14 -0500
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vGTXH-0005r0-Pj
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 21:46:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G3KhRcvkK2N6lAdD8LWjNVvIEVmhyJMYK0cv2iLYaOB/7KI3hcjB58qUMWlPSoG2ZcmB8RWuBDjt7uyaZmi9aDY6UUo1/HhjpxD68iOsn+dIP/mmKCLFbOraM1ecWDSsUuWHIaZw5vX+thwZDQblV+yHYkRYyUqKqQwHHZGU/kh4sKHeMzDRdBh9lb3aw2COiBmWFgQqiDwBKEzvfcfqNsZ9eWlgCro9l3Q7ylEnHUBUSKDixn84+NMVHWie7+MkuqabvWnqk3KI9Lf2itWQ3kERIUx23Zz4MftZqbhBFQuPUu6WgthTupA/2SVKPOKNW0Jmv+V5qdffV/zGBDh3qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+n6lq/1BWBAsb7P40XKKfLtAhHYXWfUDVVdC3BrReWU=;
 b=YpgTSYLDzFnfv4+6YYDAvTYH0sKriA2FPNVGMdd4N73ezSsw+0pFk5snP6jlKPvFEZwAf6OheZFCFQ1oiqk0FTobipB4fprr0qvtwXdXeciy3UNT64uXLRGN9dunqx920aVFDvl9ifmW0AcnFYIqOL+hXhH8AjxC2vHyWfPSfHVje9VR1kI80WN//Ar/Fv7JJoqQHZTaM8TnXuUgGXtRVBDod6FLf9OTfyENklTfjjrjepPuR1fw0dlE+DywkhkuVTuiJcwI255gGCGEKm0E9K15gAoXUaSSfq3zZMLZN9MUgotwCSmdl4w6EZbVYz7n0H4HoH4p5US53+9haIg5XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+n6lq/1BWBAsb7P40XKKfLtAhHYXWfUDVVdC3BrReWU=;
 b=dnE5gSzkaW99gKk2VSk71JI08wfp+t/mqnHBMPIQ0I0O28p3RaVAuVXVIUdKsKc8ieM/huivRcCvP8iY7PsM5dAHT6BB84z/SlOI95fw7LtuuEbOKqXJFJ7vIo0f2RapzPJRBZZBM21aY3Azy8C+5nJMxa3/qETBuzg0u460I6z0PC0aGOOuP5i9zeNbc2qYENVxwHp29Y8UiaxgH9oe67JUrgYRdRThr1AACkann8YiEUq6HUpPq5ZgnO680SNzi+y1y9asUbRHQSD+0eiAGBpZt66sWE4yKgM5j+9agJFB7c60BZyN7J8fLF/ak44QRX+0E5wStRKdtB4MILSvfQ==
Received: from BYAPR21CA0025.namprd21.prod.outlook.com (2603:10b6:a03:114::35)
 by CYYPR12MB8891.namprd12.prod.outlook.com (2603:10b6:930:c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 02:46:05 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::e0) by BYAPR21CA0025.outlook.office365.com
 (2603:10b6:a03:114::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.6 via Frontend Transport; Wed, 5
 Nov 2025 02:45:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 02:46:05 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 18:45:50 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 18:45:49 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 4 Nov 2025 18:45:48 -0800
Date: Tue, 4 Nov 2025 18:45:47 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao
 P" <chao.p.peng@intel.com>
Subject: Re: [PATCH v7 09/23] intel_iommu: Stick to system MR for IOMMUFD
 backed host device when x-flts=on
Message-ID: <aQq6W3EHf0rM0x2Z@Asurada-Nvidia>
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
 <20251024084349.102322-10-zhenzhong.duan@intel.com>
 <d9eedc35-1548-4011-8eb3-5f6a4dcefe51@redhat.com>
 <IA3PR11MB9136B987085148D724C0144092F8A@IA3PR11MB9136.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA3PR11MB9136B987085148D724C0144092F8A@IA3PR11MB9136.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|CYYPR12MB8891:EE_
X-MS-Office365-Filtering-Correlation-Id: 9158b1bd-60b4-4023-6e00-08de1c157757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|7416014|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7FHVKZmATkhXfysC0WpqCPQ1WU0kRRpM+XldRuhMUlM0LYIMDdpMxNWwdvQg?=
 =?us-ascii?Q?ViAxzkfpkfVfW1uKxOEbP6CJ87Iyhw487WbAb3z8ZyQkUh6yHu0J7F31r1Bv?=
 =?us-ascii?Q?6Jy8+dFWUWPV5dHS9ILxL2DYNjqdbw1q/wtJtkamQXTWXTB4g+ccs9QNKgOB?=
 =?us-ascii?Q?LIL4++TP/KgFa13GvTzepUZSRRC+42/5Fs9xt1cYEhvdYsf/4cIUw6JL6I7B?=
 =?us-ascii?Q?ELEf7/78iOEoemmaMzG2GPqKICzToylLRanaOPdN+UtP04CVGtpUwK8TladC?=
 =?us-ascii?Q?UOUUEzo+5hXeepvp/Zb9A6N2KXM1v5Hk9JiNmsenETl6Kf1sBlis+4KOFdVi?=
 =?us-ascii?Q?cKpfNU0R8ugfwFPHyP5Nx+JPV2psYlNPEkN95+3/oQYGmElplT4ztLYXwn4m?=
 =?us-ascii?Q?AfiwS0Rz8hsYHQpHpSzknetYS3+2Im9hff9OCc/dpHchkPUChnGG/+J651+h?=
 =?us-ascii?Q?3zzA5GE2WKZY7TX379n8Auzn96goWHKo/1rFXVKiXFmEah3A1yIvP2Lg09Aa?=
 =?us-ascii?Q?cWEIJlLHmwv7oniOYgw7VJ3dcbHt9G7t3VnvW+7E5xbB3UuQA7AJasVMV3fZ?=
 =?us-ascii?Q?w81i44XQyIBpMiYN6pZYqfTvzUqoVwI0ssufPVERY503huBee4cHq85tyibA?=
 =?us-ascii?Q?ezpglOIxjmUxuR7MrF+BEIEKvfh1ko9E7Sc/+gw55NI/FLSAor73qZ1AvBKY?=
 =?us-ascii?Q?nbTN3sORdIfd1HbT8Q6ijAHPkoCdGPE8QdWIU6O8dLjQUflyIkgL3kJ5se+u?=
 =?us-ascii?Q?2NqTkvspLFzgddWLb6w+Oxh9B+H6SuVshy8kyxaHHmSapTleVFSnuvPzXTjw?=
 =?us-ascii?Q?itrbrhuHE8p9TFymTaoGtkKM2HUVjZTT7yBDZPJdh21dzCmZvGJb1AgN0jfj?=
 =?us-ascii?Q?iXLMvXT6yPYrb7xJXVQ66Q4P24EE+3w4SsTvyXif96m3i+pg6ZhpZIXW6/6q?=
 =?us-ascii?Q?2Xcn2npLEqP+lLCQaNG3p4Lrtbx8ZSmeeW2rok7dEbBe8MaLBtdz7qOlHgYr?=
 =?us-ascii?Q?GV/5EdUTyDSvBSDSrB2j6vyCzofl8Blq99cJ3HEgrx/revcTti3sQ8ikKaIk?=
 =?us-ascii?Q?DusZ3CvZVUWqjtSZEny07OXZLyYdPouRIMCig9sMVPQ472xy181jUeJwHhEe?=
 =?us-ascii?Q?0FLlv8Yj8KTkFETvBiewL+aamEwirVET2JMD0zDX4U0B8O6+8KQ8SBq0k7mz?=
 =?us-ascii?Q?F6jbNsLRmDW2nfMDYG1QMAEfYwtyLSq16V/2wh+VX37fn+//j2BkD1D7DgG0?=
 =?us-ascii?Q?RYZQXPyKoDvjkJrEu+MJ51zwEOD97qUidrhLtcC+km9eEASheoKmBCOg+GZG?=
 =?us-ascii?Q?HqdTzKZX/GZvOIHwTm1nWivL44D4q49SZ2acm1HljMjjiP9RPox/gJTVr2Yl?=
 =?us-ascii?Q?0kncYczDn8BN8802r3DrHP6Vn4tgJZuE+89j8qCFlz2Ybw/zxWtfEoo/ZIj/?=
 =?us-ascii?Q?RZldI1CAOnlADOOxSKkyZPULiRM/N7+By4OiC4I0LU5t+etAnGu0CWZNMSex?=
 =?us-ascii?Q?Jlh1aOegEnfne3csvdVI48ktQpnTKKLOrDAug7hFM05k9boYupoDyhO9XKyI?=
 =?us-ascii?Q?KDLOjYvYMarwKZWSs+E=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 02:46:05.4871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9158b1bd-60b4-4023-6e00-08de1c157757
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8891
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=nicolinc@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Fri, Oct 31, 2025 at 09:52:16AM +0000, Duan, Zhenzhong wrote:
> >> +    /*
> >> +     * When guest enables scalable mode and sets up first stage page
> >table,
> >> +     * we stick to system MR for IOMMUFD backed host device. Then its
> >> +     * default hwpt contains GPA->HPA mappings which is used directly if
> >> +     * PGTT=PT and used as nesting parent if PGTT=FST. Otherwise fall
> >back
> >> +     * to original processing.
> >According to the above comment you have a S1 translation in place but
> >you set use_iommu = false and use system MR?
> 
> Yes, we have extended the usages of MRs under IOMMU AS with nesting.
> In nesting mode, system MR on/off isn't aligned with S1 translation anymore.

Does Intel vIOMMU need S1 translation when the working in the HW
accelerated mode? I thought everything is handled by the HW..no?

Nicolin

