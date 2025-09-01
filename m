Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0265ECA0FE8
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 03:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usurZ-00046z-6f; Sun, 31 Aug 2025 23:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1usurW-00046Z-1G
 for qemu-devel@nongnu.org; Sun, 31 Aug 2025 23:05:42 -0400
Received: from mail-dm6nam12on2044.outbound.protection.outlook.com
 ([40.107.243.44] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1usurT-00018x-VG
 for qemu-devel@nongnu.org; Sun, 31 Aug 2025 23:05:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9zvCnt56ITrgkGcj9cm05Hg01Et3t4OflKgizQPoM6xpTi7/t5J7cpK0m2Wd2i6SaQGHqDysZNPE9U6BLQA7q0BvF92+YsYggf6pYqG3sZLa3IyloaEBEUiS9YIdwNuL9YoKo12JCHC+N4lOaLNPWc+Tgt4dWeCVk8zL1pEs0cM/apXuN7UlyrjS0XuB8me0uWlLh1o4uUTOu+i73rmNehiIIESdI1DLNBKtoRmXE3PGbs/1SPjBOwhrnuETyrK+/jxkx2sFMb7Oy3ytxJdle4NKsvMiU/yj5wr65bCEdz3oNVGPXp3gHSZVDqXFl9y1KodLjogyFsKe8xSouJ5cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7keR9fknuW8IY5fPGN4DQmJIPf4o1HIL88GMfjUayk=;
 b=UepmjaElm47kqEotuw1CWR918GaoOUTu0NJarag49v7m1DC4q5+PDddYHYhPUreafAHipobgo2rJCKUlYw8hpQiscofIe61At1haGqCRoSmBTmnR45W3OfSOQDOWjD5qidor7vP3osz9GXHR6xCTBjA0lhB4ej+t7ql4Pk0amS/4aX9myQzGJC8rVKSU7coXvGx53Mcs+IVzEJPPQPdgpaCcw5eMFE/oSeFZsOMHuKw3wxvvcgxeiqhD2oWxdobmMjabbqa09ZMnOt+aTahi8flfpjkLj70D8SXs3WW4TY+riOzFjsXuCuauzNk9a9NEOde+uGIsbXM+yDxxT6IUTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7keR9fknuW8IY5fPGN4DQmJIPf4o1HIL88GMfjUayk=;
 b=ns9sBLNK840RCOtGpDVb8/kI6WEKk+w3FNpQQBylzhUdFuYyzCiPYLdOAsQsyoTBhMJQj5zVCvFSg/WQs/ZJWcOL4jwFM6I1eQpXggkklQSpm2o7nluyBW6n4kDOJZyOGCUh8byeTkb+Y/Dn56kgvsUJ8bqvr1m/q0YCu45UCM620u/+RE2tK/lVLF9rwpiiAEfx618H/s5ZGwC6JBv6i5JJHZQN8EWRc1Qcc7r2r84xv/zeByfuDJTWFrZN04vwEhS7GXMN/C4KvETjkYks6QR5t4svmJe2PXRTrFbz7uhCJmXaHXJVity93FWrftNnTeqv9nT3xLV7kaTt3mFJAw==
Received: from DS7PR06CA0010.namprd06.prod.outlook.com (2603:10b6:8:2a::17) by
 DS0PR12MB9347.namprd12.prod.outlook.com (2603:10b6:8:193::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.21; Mon, 1 Sep 2025 03:00:30 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:8:2a:cafe::cc) by DS7PR06CA0010.outlook.office365.com
 (2603:10b6:8:2a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Mon,
 1 Sep 2025 03:00:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Mon, 1 Sep 2025 03:00:30 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 31 Aug
 2025 19:59:58 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 31 Aug 2025 19:59:57 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Sun, 31 Aug 2025 19:59:57 -0700
Date: Sun, 31 Aug 2025 19:59:55 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: Re: [PATCH v5 02/21] hw/pci: Introduce pci_device_get_viommu_cap()
Message-ID: <aLUMK1P3fQ7ZGMDl@Asurada-Nvidia>
References: <32c0a5e1-6529-4978-a0e1-32940e806dc0@intel.com>
 <e6300798-19a6-417b-902f-57fa7ae20355@redhat.com>
 <1ee98764-d57f-4ff9-9018-f07d8ee5d68d@intel.com>
 <153e1475-6678-415c-86bf-b7251cb59f3f@redhat.com>
 <aK8kqQOV28V36wtM@Asurada-Nvidia>
 <ecd95fc6-ce8f-484e-b685-d78a382f1705@intel.com>
 <IA3PR11MB913632FB83D138289BB718C2923BA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <IA3PR11MB9136978139DB0DA6A2A06C82923AA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <aLEd/YAwfhXD2Lro@Asurada-Nvidia>
 <IA3PR11MB9136C7C18941F5DFDA44FCF79207A@IA3PR11MB9136.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA3PR11MB9136C7C18941F5DFDA44FCF79207A@IA3PR11MB9136.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|DS0PR12MB9347:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a3680df-e496-495d-50af-08dde903b61b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|7416014|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BcEyDxp/Zds+2SV1VThMqyOngTPHR0ifxqmIZ9rryLwPoZG2kk/dw+ZFsVes?=
 =?us-ascii?Q?FGL30HrMkYA+51WHTx/nuLy2+RPhm0MaryVXEnQU0Vgiwa6atFVFLKe4pylq?=
 =?us-ascii?Q?AFEz6w9MdcFCRJVpd/khAMLUKy9KKr0zM8SnaeTLEqavdoK84bR0hhc9pqIe?=
 =?us-ascii?Q?nqoUX8Xg8XaVsMHMMe6CKMxPEEE3AfdlFgQ4RcQ8o55dLX6UePoMUSPdMkZP?=
 =?us-ascii?Q?gv3wTaKxfZVxdEMr6s3euzWiefkmE37J2uZN5Mo+AKiE4XqV17ERENz78j/p?=
 =?us-ascii?Q?cCOLyIoqo4mDgv9RAYGVvQFtR4XnGiEog8i6xDjRrTIfWpB5xL5C0AQdOF7b?=
 =?us-ascii?Q?R3jL+2KRZ2+lERUjuU4yjAoHlpo3PvxKkEmOmWPRzMmEwDNj3Jl/VeZDwCUT?=
 =?us-ascii?Q?j2LhJ3Z6AzzrbWRNOXHaQyShDfph5KmVE/VBdj/fLfx6vJrWQnx7lI3F2edO?=
 =?us-ascii?Q?pvx/WxU7+70ePc0DlOTqBLcVB1+SYc2kEQO2LVIk7oEhUckJumPFZ8NP0dOq?=
 =?us-ascii?Q?0Yh31PEk6+fvGwet7LBnsLT4EsfEMA+kHtHbals6leXjk6f+ByWzi7p5DfVf?=
 =?us-ascii?Q?uk6siWzbkya5RArJE5n0t2gRLQ4J/A1sr/rwVP4PYA07zduhDvRMTcxXCiFV?=
 =?us-ascii?Q?X4jjlC7u1tF8qeNLG98w/Z1UnoFBixiQGhDJyL5vjf6octrsjWFx606/bcE3?=
 =?us-ascii?Q?Xn7Mj8XSXgeMlEM6/vMYfqOPUBk7Sj9c0oFfe5pGJbOTHb4SRV0Rbj+SeFLq?=
 =?us-ascii?Q?ACejAzLlfveSrk1cEcXCI6UH1sciddE6LzMSfRmxLcZ13OBt1OiwbPgEwlum?=
 =?us-ascii?Q?Z9GyeQ3YUQLlzQtTYt4IPPapqLLHgNUnKuh5mTkXsKimLb/0r3r6nrUEtzHn?=
 =?us-ascii?Q?8hYB0UEo6rV3dnVkqsGZ9lug6mnaldD/eQDDYfAV3YcrFHi95qAUeY+IoNfX?=
 =?us-ascii?Q?NTPpFhEth/nR3nmMG+szagGHWjTdFLmqQsfP9BVZaJy4xPwBe20MLvcCsUiV?=
 =?us-ascii?Q?mJ88Q4Ea9osP0XbqEIA504zgpLKHyXvyHfLV+V88frTx5XvGsebWcfl3RQcK?=
 =?us-ascii?Q?a3MmO0kMx8mU8lcHITbe3Xe+rTCIK6rzoLoREITlH38l6DwD52g1e49ENlf5?=
 =?us-ascii?Q?8u97vadtOVvpM3IF3JoaNryX7QkJmxVVlcDxp88jZEcyUscmsLtN7d7xxpjp?=
 =?us-ascii?Q?zbK26KSGM+m0QQObPLYRTtfreNPedUIFcafgU0mguQHrHRQJj9SQjfsQkGU9?=
 =?us-ascii?Q?YjZaZSzoJyLkUdY+mVs+F4e8kySsYFLWc0kVMdUiGSu75hiROTNa0aOeokuI?=
 =?us-ascii?Q?q1bOw/MMBg/d/CzxqxwDVnvsiUKut7QPG4WnzgVhr7ndDt3lynYzmMDh3skL?=
 =?us-ascii?Q?V4ogIiG11/V1NydIQ7MFwuy0saAW/TYGPCch4kXqE2aXC4HnChnbYUWFMnac?=
 =?us-ascii?Q?1/9FOvSWaOpNPvSCeu0axpcFCB4nPH5brum0J2wK47QUcykt4b3mcICuEqNp?=
 =?us-ascii?Q?HTkFPGZnKiiMo8zNFzoafjhGpwvsEQjT09wE?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 03:00:30.4480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3680df-e496-495d-50af-08dde903b61b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9347
Received-SPF: permerror client-ip=40.107.243.44;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=2.807, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Sep 01, 2025 at 02:35:29AM +0000, Duan, Zhenzhong wrote:
> >> I just noticed this change will conflict with your suggestion of using
> >HW_NESTED terminology.
> >> Let me know if you agree with this change or not?
> >
> >It wouldn't necessarily conflict. VIOMMU_FLAG_WANT_NESTING_PARENT
> >is a request, interchangeable with VIOMMU_FLAG_SUPPORT_HW_NESTED,
> >i.e. a cap.
> >
> >At the end of the day, they are fundamentally the same thing that
> >is to tell the core to allocate a nesting parent HWPT. The former
> >one is just more straightforward, avoiding confusing terms such as
> >"stage-1" and "nested".
> >
> >IMHO, you wouldn't even need the comments in the other thread, as
> >the flag explains clearly what it wants and what the core is doing.
> >
> >Also, once you use the "want" one, the "HW_NESTED" terminology will
> >not exist in the code.
> 
> OK, will use the *_flags and _WANT_* style, do you have suggestions
> for the name of vfio_device_viommu_get_nested() since "HW_NESTED"
> terminology will not exist, what about vfio_device_get_viommu_flags_W_N_P()?

I don't see it very necessary to have a specific API per flag. So,
it could be just:

    uint64_t viommu_flags = vfio_device_get_viommu_flags(vbasedev);

    if (viommu_flags & VIOMMU_FLAG_WANT_NEST_PARENT) {
        flags |= IOMMU_HWPT_ALLOC_NEST_PARENT;
    }
?

Thanks
Nic

