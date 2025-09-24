Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DD1CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 08:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Krl-0005bc-2f; Wed, 24 Sep 2025 04:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1v1KrO-0005Z2-Ad
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 04:28:23 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1v1KrH-0005MA-1Z
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 04:28:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rj89D+H4Q27Ey+Nk9+trI3egX8lK5i9KZAs0qhOO5excizwH65ZPgdBQdB7Jts6imBTY7X9glwradu/H4N3uHJ5oShZqI9q+HRTkSY/6K7wQOQcUzTIv8HIZfVwnNg7Pmo6xofNDFJ9Vhxa227XukHAucszHfugYHF49DRzjPCVN4SP61sN+IxE59+WyXUC0hx4vaBiparNRTvpUVxak+k6w7QdfpTmuivgE7vCmpTDMtsaags+M++Rx+1t5FegK4JKIDIjKnU3KwNMoiejtb0ClqA6mzsAJX1TAgM3gEFKAup3Jb1lKXxNS/qvExysamiRtGfLC7ggK326xYgTqxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLLaTO2E6gwFBqA7ppxgK+IMFftU0OPqc6jZYXxzvNY=;
 b=P6JT1l8dethkqJ7CHFRD17SLQomSNlafGyLhwKF552nWFvhMNTQLLV2J0BQJSh4/zy3ESiME9swWTbJS9rnZxezIIZLsv1VCatQ2W4q441crK8XUbezuusUB/1P/kIE+G3kows2LqfMaiZPyDjMPBtNjwlhuh2UQOUFKTVsJ4EgCIyQnGwkvkeN2sze+A82Nt1nvnktMWlJ2CEuoSeQwRECD+TP7sF3zsWk/1uFR8W2xVcssasTNUKaCOABqUsYMlldv60z3wobdLWKclmESKmcPL3yO4odym4+4cyHa5zK3PxGBJckUbUZOYXAUXlxymM3mU3S2CUNyIdcFk8Vylg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLLaTO2E6gwFBqA7ppxgK+IMFftU0OPqc6jZYXxzvNY=;
 b=AZ1F+iD6P1ZBe/QjyO70nR8aJrID1gllSU95WLCYkZg6mIl4VF8SDeD425f+kcy/DWP3RV/yntSDcbBEqJ8v6lae1Z3wdNuGIubG+7WRXG62RWIgW7nokhgL/S1GOKNsO06dsJjFks+yK541iDRnY58LICNd+ZUBS2rhSsZea84tif0z1HZNZ2s/1r7H1NxxHbpCOoBJknP+CODRipZhOjCWbol9yPpTCStlCMejxlw0EPL21ojtcaHTyjRBf19cyrpvDguTKUqGxDwmkzi2evnmMeMfEz+i4rfCozaucUew47LRv1dB9sCdic1bsicF7QDWAmYZS9cb63Wv3v5lpg==
Received: from BLAP220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::22)
 by BL1PR12MB5922.namprd12.prod.outlook.com (2603:10b6:208:399::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 08:28:05 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::2e) by BLAP220CA0017.outlook.office365.com
 (2603:10b6:208:32c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Wed,
 24 Sep 2025 08:28:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 08:28:05 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 24 Sep
 2025 01:27:56 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 24 Sep 2025 01:27:56 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 24 Sep 2025 01:27:55 -0700
Date: Wed, 24 Sep 2025 01:27:54 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao
 P" <chao.p.peng@intel.com>
Subject: Re: [PATCH v6 18/22] iommufd: Introduce a helper function to extract
 vendor capabilities
Message-ID: <aNOriuyx9Fhw7aMI@Asurada-Nvidia>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
 <20250918085803.796942-19-zhenzhong.duan@intel.com>
 <aNL4zruHP8P8ExrM@Asurada-Nvidia>
 <IA3PR11MB9136B5015A5396E5FC782B8C921CA@IA3PR11MB9136.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA3PR11MB9136B5015A5396E5FC782B8C921CA@IA3PR11MB9136.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|BL1PR12MB5922:EE_
X-MS-Office365-Filtering-Correlation-Id: 60dafa31-30c7-4f10-92ec-08ddfb4448fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+a0smOLuB0kNkoJortQ6lkjxZ8C2SfSuKB4qOEKM+sp09rxWervntNFNw2BI?=
 =?us-ascii?Q?Ey/Rtokt8JhnXZfvBXD61BOtmurYok7Ao+/pQVIJ1cqZcMzrhjx7/MHck5ZR?=
 =?us-ascii?Q?d34yObzOMjSUkURo6+VyrmB0xGymgUKd8/qq7KF22J5OdPUQp4e4QNrwDUZr?=
 =?us-ascii?Q?SrkRMyaIm0sISmacwXIfYv2MS3Z5i69nl4P2VTbhnkqW9lq51zvoy29TfB1n?=
 =?us-ascii?Q?DPHNQf+3PW3JzlAAEu5P3OCbieR1voFK+lgIXgt32Q1wJeDW4cZSwvXu2MXS?=
 =?us-ascii?Q?CqGL28QG6zYxu1dOWgg38jDC4N0Bk3jE3kB/U+4burSWF660pzbv3Fye5Ll9?=
 =?us-ascii?Q?0E0LhpQHkk8rP1vEAsIiPb0bR1nq9CCGyC19GkomgD1F3h/PUfOoLMnR5Lmq?=
 =?us-ascii?Q?DKRe/BkzdqigSrKgcqYZnFEpsM5xab1bq0W+Oyv1O0B6EgX4XU63z3AVZtzf?=
 =?us-ascii?Q?XnNFMmx6kd6rfDYxY/xek1QER0JpzNlL0mo41WQQWJbTC18pyNujN0rL6G5x?=
 =?us-ascii?Q?aeL93dK32siVgiExETDEaZpQVc8qsdMEnZJlgrkAKVeepNHNodRv7pmr3RyJ?=
 =?us-ascii?Q?G5B2ZrIWx6fsjYCLjyOT0hUDrmOc2ze4y49R3EwlS96yQg5Tft8yfsuw/r6j?=
 =?us-ascii?Q?vtZ16iDqNdRkM8u45imw4LyEX+n3XvSESM4DHcWRxspkIAJ4aXBO8nmp8sR2?=
 =?us-ascii?Q?NqeAhqkCmQeWqor18AOoE00Lr80fpBwMt0bqth9uxYOWsU/CajyQ8a52GicU?=
 =?us-ascii?Q?vsSTw/aXdhtNWC97hQSE2eMOZ4dvNCxCT4kk0fpHeG0jX1FrSS1IKWofwOqC?=
 =?us-ascii?Q?i5FyV1YS5CoAlvx9PQrE6V8x+GtafI46mqyOtpmedON79M4xlr67e7QnBcDw?=
 =?us-ascii?Q?3kVJvGYIcEAjjBF/v8HeNTfPNj/C8Cw4oeA3hMhiSXWPqpAwESprCmI0UI/l?=
 =?us-ascii?Q?5GDOtqVeN7qVOH81XygMK+1vyOVzSS73rZRyH2+lYd3XiXR/telJ8eUDZKMr?=
 =?us-ascii?Q?jmjybkDzjOGBitqpREuod1AlpB+sqALGoCNjIrwTC9A+GUzEtUlD7rMEYf3r?=
 =?us-ascii?Q?19oEHWKrpCf5cOcBdhX2Ey8xNxAVSNCRba6650pUuUzn8APSVKM/Ex+BZDAA?=
 =?us-ascii?Q?fbk911TRqo2lX0LMFW5OEcIBHlYnbxW/DnMJ6r3FY7ubnhRo06fFKkY2zhi2?=
 =?us-ascii?Q?emj+d42Y6w5vv9bBOFIfBWuXr6gEDCDuAgTLPXRtGJfqOsEO074AAoRoADsH?=
 =?us-ascii?Q?5PLyA5xtDfzjl4yuwA+PT8eMwg3rvSq3DpcnqyywifxEP9kskfdIw/lmPD8w?=
 =?us-ascii?Q?A4scYkzX7t34INw5oq1ydWA/rCnxogJ3bV7Q0EMVfWVvHK5+d/kpk4T0wS9j?=
 =?us-ascii?Q?GSj/rs7kfKlYDrDx4nauvRcFNXD6BeoJbBo808XlwQxqRzUvFkEjyxwAC+d8?=
 =?us-ascii?Q?BSk7v1Z4uZAsGa5Z+viBYv7JOEljGDCP2JNMhVe0jA/oBNjplGfyTWaC9NJb?=
 =?us-ascii?Q?mgB/SEbBq28L5GcdZ4K6X1NYsCmixGEetMGJ?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 08:28:05.6095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60dafa31-30c7-4f10-92ec-08ddfb4448fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5922
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=nicolinc@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_NONE=0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Sep 24, 2025 at 08:05:36AM +0000, Duan, Zhenzhong wrote:
> >uint64_t host_iommu_extract_quirks(enum iommu_hw_info_type,
> >VendorCaps *caps)
> >{
> >    uint64_t quirks = 0;
> >
> >#if defined(CONFIG_VTD)
> 
> I have applied all suggested change except CONFIG_VTD here as it's a device config and iommufd.c is device agnostic, it doesn't recognize CONFIG_VTD.
> 
> ../backends/iommufd.c:419:13: error: attempt to use poisoned "CONFIG_VTD"
> 
> I thought this is trivial and OK for not having CONFIG_VTD?

Hmm.. I didn't expect that. It seems that QEMU does encourage
moving all vendor specific code to vendor specific file :-/

Anyway, I think it's fine to drop the ifdef. The VTD type and
cap structure are defined in the shared uAPI header.

Nicolin

