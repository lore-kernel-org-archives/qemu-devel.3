Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BBACA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 23:15:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upaxz-0004Hh-Ik; Fri, 22 Aug 2025 19:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1upaxs-0004G2-Ny
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 19:14:33 -0400
Received: from mail-dm6nam12on20613.outbound.protection.outlook.com
 ([2a01:111:f403:2417::613]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1upaxk-0006nO-Cu
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 19:14:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rlNaTIi+8f7hnJofPYprVKr4E39l9/tF7XKMcaBMCr9sQk8lOQWHMouuIbE+UG6/zGQoMHq/rTAATJ968xXbV3L6KDpgzGf49Vqak9Ceua0pOiVkhLTr09uXc7CNs0VR7BJ+9qorVw7eAxdKUCYP+gfZXPGWp6TUjt0+yqcfT1uNypraVvGDE0CKPPjMMX/vKDO8XtH2c4KI9AE0LV7cuI59qLgL927xrSoQo97ZkelgtFvw6+Z4YpddkcAFjNP6ElVDJL2A3dpr3GmY5d5b3T3PVoZAOu5ZRJIxKlhSbA6RBpCc1zuiXiM1j0wgmv58QTYflsCUPJu4cs2cxv4Puw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5lnYNuNNIcwbx9LQ8sV0l4Tgfz+BHzQvkCtbTVlCsI=;
 b=LPVCwxiOIlbMcdztxagBldlp01af1k40g9JN5Bz0qaV6IGsyu0NnsmNY4wyZHTjFZH6jGVUIa9wJR0U5vIKD4RLo9UzonUjZqUa7hCwWp8nT6mCd5iazKA4qIJuEJq0UuERz1iFL40pdKOnqF9KZGvAg74alqvl8fzvStZbfT9a2GoGQDeM/xYwUImGpbdyrBIf/A4ORO0zGxN3+GShlN1OkYgDKH+/YsYLsseM+Ubl8RBFYsgzAThIwdKGRHKjVSwUsj2KM+Yl8tUMal8tQR4b/EOQejoqI3uxTo6qcX8t46+fg/SBUnHP9eqYg5U6SYirycrrSGXLmu2FMvuv8Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5lnYNuNNIcwbx9LQ8sV0l4Tgfz+BHzQvkCtbTVlCsI=;
 b=gCHwYYKca1BZXXacTKJyhije6W1ZGc4Ldb+IvL5ErWmkiD0deYSUESvpfs34tY8dkiQCTyVbj0oxEgtI5dpKs/MfvUjZYg+kftY7IFbpThh7nTRPwPPm8c/vA5qLMVuw4jI/RXDI8zSgGG19hwc/Iu3QG5bTTJM+mdvmPKLKEhsql9djBnLC1KmxODSsBOafWpT8ibdEQA+imFuKKG1UTfTt7pv2dWi9vkhmNKpK0gbl30odhvkDZD4Pv9DiPAt4YwMStUdECt9xm1T+CJRgaSV2I64RZidQTOKaecOgERXWrNSGK8UzqI6HvDkKIQjpvD/8qh83CHrrX0ggySaMDQ==
Received: from BY5PR20CA0003.namprd20.prod.outlook.com (2603:10b6:a03:1f4::16)
 by DS0PR12MB6487.namprd12.prod.outlook.com (2603:10b6:8:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Fri, 22 Aug
 2025 23:14:07 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::5b) by BY5PR20CA0003.outlook.office365.com
 (2603:10b6:a03:1f4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Fri,
 22 Aug 2025 23:14:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 23:14:06 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 22 Aug
 2025 16:13:52 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 22 Aug
 2025 16:13:51 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 22 Aug 2025 16:13:50 -0700
Date: Fri, 22 Aug 2025 16:13:48 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
CC: <qemu-devel@nongnu.org>, <alex.williamson@redhat.com>, <clg@redhat.com>,
 <eric.auger@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
 <peterx@redhat.com>, <ddutile@redhat.com>, <jgg@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@eviden.com>,
 <kevin.tian@intel.com>, <yi.l.liu@intel.com>, <chao.p.peng@intel.com>
Subject: Re: [PATCH v5 06/21] hw/pci: Export pci_device_get_iommu_bus_devfn()
 and return bool
Message-ID: <aKj5rIhXBlpciMX4@Asurada-Nvidia>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-7-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250822064101.123526-7-zhenzhong.duan@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|DS0PR12MB6487:EE_
X-MS-Office365-Filtering-Correlation-Id: df6656d8-6ad2-4e26-9dc0-08dde1d197b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|36860700013|376014|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o501EkuOMrmkBjzALiJt3eMClTs+ilP2hn7AwBI5aGnYftCKME1vidF1V/GA?=
 =?us-ascii?Q?XStvOeZdTGLITWBRRBXGoJPk7WiahOv8A6JPgcbQlUtH8rWdc6a7wrIEcCD0?=
 =?us-ascii?Q?eJPinh5usCC3lrzZ7ozUa46KyuBQENuQkJtxu2EmIGcbq09VTIeJ/gP8f+Oz?=
 =?us-ascii?Q?9Kt1f63n22ULwIBdNhhKrj3jFRyNhbkdFsVNr8+rPTWN24kW4WW8BWiG3j8J?=
 =?us-ascii?Q?Pp82+72JJuPfRDgcnimu2SIGTYd9NDDZvd0kuN8oNJUK3hnHsk9vYj8VYJ9a?=
 =?us-ascii?Q?FzeMluNcyX4P36nYnEsr65ifUoDlZKwx4C3uMECTf2dGQXT/noCemIrAmrxb?=
 =?us-ascii?Q?MLxcyzu84P6slQexkoXVzLA15TEOEWyhFDlrLxwiseFH+aers6YzEkNSRrnG?=
 =?us-ascii?Q?38EOqvI1jYnfMVWYhIliqv1x4WSJx7x3StZwN4TAdMAuQMZEXj0QvPReIGPK?=
 =?us-ascii?Q?cWv26lGW4pUO+/oamvHH77kYV+GAv0wIpqRtOHkic+07Ue+IvpsB1yBMiepQ?=
 =?us-ascii?Q?rPk4DE19mhp+ip+wJj8PgzGkosbTr8IgOeFAwbpdtPDR053K1d4SqkprvFXX?=
 =?us-ascii?Q?tTy1PtbJFeh5BlrIvyD2F7TAll1XvNjumTHagKfNqznYXeuJLelBtzRh+Hzt?=
 =?us-ascii?Q?u0CVBJKkdRRMblR6r3zECGTCPnT6Wpj09Xrt3szJH+aCryuTDEpH8p/ncOkd?=
 =?us-ascii?Q?rQgAbQgXUkXGYG87Mvdhi66VWoXCVHAwnRMeG595ht2Ewv1oWcafzWm4zYvp?=
 =?us-ascii?Q?uyIYHBXlTHZbO1x3fHrd7uUHqqfApuar5bef5SDkc1x866a34ML/VgWaxsSo?=
 =?us-ascii?Q?uyK8D/1uvb2Mo5tYhiDTZnAV5girKlMKQbt34iVQgbYwaG4oZnPq+i3Wepjn?=
 =?us-ascii?Q?qGxjbOuzDMZk/Ho+Trfh8ueS8M+uW981eCb1QlAqX3W2Jp9TVbbo6/hckMHj?=
 =?us-ascii?Q?hs+wHw4EWgsbcjPgTxNDrf/0DblbhmjUEaIqDqYUsTJN1O1QGO71Qe/82yrS?=
 =?us-ascii?Q?R2nAsx4Z2FNX/97H8DTqAe6ySwGec9ECVUjhBL9HN2pcm6UhIxOt9CJ8EHMY?=
 =?us-ascii?Q?CFFuYZ1AkWSiKrAHwaU1owEiyVKI4kFLeFxlLGTB+bMuoi3XYUS8n0Lu3ydL?=
 =?us-ascii?Q?iDXIU7viALe2c7zNBa/iG2dkdf+9IMDjB2RX4SZSymQzpaYluWAo3XFfKh9I?=
 =?us-ascii?Q?1eAkWZN+fVHW7wwZ6vokxplNLDU+ndFmKboMd8U+07fsJvDhJUepDOoBpV5O?=
 =?us-ascii?Q?MDToJOBqPZNHuYeyYiIB+UlY0lZW5MLCvpubBgWsGOhty3+wukaIkXOnvl7G?=
 =?us-ascii?Q?l2A6lGcQOjhS8SXs2T1wHZYQ7VWS8MKwJ4W5TORGOfwBOzZzDsttr+ZqzYeI?=
 =?us-ascii?Q?mtntvTGp+fUgerUhl4YeC8bK6Hup7VMj+gf/pvBf4a1wQeEQA1eYq+wqjERH?=
 =?us-ascii?Q?a46qhVUUNBRMT/eRPJio5cqdAWEpakDry1ZyNiPzRgL4mFPzIPb787OeHQYG?=
 =?us-ascii?Q?ZeIBQdWuQwm52egWnQc2+TyhS1iFvxjVFMD7?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 23:14:06.5805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df6656d8-6ad2-4e26-9dc0-08dde1d197b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6487
Received-SPF: permerror client-ip=2a01:111:f403:2417::613;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_NONE=0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Aug 22, 2025 at 02:40:44AM -0400, Zhenzhong Duan wrote:
> Returns true if PCI device is aliased or false otherwise. This will be
> used in following patch to determine if a PCI device is under a PCI
> bridge.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
 
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

