Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DC9CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 18:25:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNAR-00056y-LI; Sat, 30 Aug 2025 11:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uruUl-00034I-1a; Fri, 29 Aug 2025 04:30:03 -0400
Received: from mail-mw2nam04on2061d.outbound.protection.outlook.com
 ([2a01:111:f403:240a::61d]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uruUh-0006UI-Gy; Fri, 29 Aug 2025 04:30:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x461pTgqtmzRa5k/ffRGMzDAtqVtxJ9YAvoYuO6od4jvldAGpVOzzH9KKcBkcbqy1MiNwZKJY2FzTDXyqc5VhEBPwKEu41iq8vjmo/2TPtZ+1YQGsBy4niIHDVLQ/s2YnH5wj1Psf/3wwmXrJGlpr+XyBfnwOcGiEhwn/YXL+f4kxgl/P75ZWLzBDz9VfALBiAkAKKAhRjQa+GoYEbS1IDnbgJVnl0vza8lVUpjKybqXRfuKV1/bxzNxLQYYTiBpIFFYyyocT1YUUWT3ne+PAKQDKLGoy6BSnX2nG1QJ1x2lRBy0H90ot0dRN3MZKQDcE30dZ+9LTrU4f/oJOEzKzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4p/y8dKHVq3BrKUSgydRgSCUFCC2hm8DTH2PzBYn1b8=;
 b=YUea1FJNTqEKRFbVCWVBYFUQDwn/VrOQNpWgVS2mpoa8HSaS4qD6/tcCtknIgqMdU1wtySI1CpGQg3BWhHf44FEuMaKey6FZKXbdK43AHs7Wdw2cWzlMY2JAGXQ57huGmRFXWPiPIzdfg3NlP9dkpmcQkOzio8MxlbMtQgLz16meJKMg0JBMGCmcCikrNgQybugQfV+hpifQEJtENkwt57dUJQfjLX7tD9Z/EdlJEzEmkKAam0pLvSSTF56Vjf9ImM87ygjYyG1qypxwRV/1Nrc7mdXJTDJriqSEQOz4MH1rJ1xiAUA/lmBvqcUb2+9cYSPdZ76HhCEIHpnErnEi1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4p/y8dKHVq3BrKUSgydRgSCUFCC2hm8DTH2PzBYn1b8=;
 b=rPYSQEfxFtRe6sGIEO6IAj87/MwNcGxivEvIleSHGnnZpyhmYI0AGpot/7lMZDQ1I6YnUxopESxvQLEVvK+Vlb/fGE2tpkkaBmBr0+qg5VGIoVWm2sPhAAzzw28ELT8pQ37Yz5H+q4iUmY8ilYszlR6dysjs/6dcytvKpV3qcroObpWaNmgTPQNnlk9iVI2lpfjqJphWRSlU+cVTsPA1Xu6LWl/ZZW+t1Sr15pPHfzxrWTpSNmSDtBnl6AsO7YtXyTgpIasjvmB7/JdHj7gsBIT02s27FqvWEhY2JChmJiBtWY37WP0U7lfwNf5r5N0HOJyXHSts60AWhJXMV1RhpA==
Received: from SJ0PR03CA0012.namprd03.prod.outlook.com (2603:10b6:a03:33a::17)
 by DS7PR12MB8276.namprd12.prod.outlook.com (2603:10b6:8:da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Fri, 29 Aug
 2025 08:29:49 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::5a) by SJ0PR03CA0012.outlook.office365.com
 (2603:10b6:a03:33a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.17 via Frontend Transport; Fri,
 29 Aug 2025 08:29:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 08:29:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 29 Aug
 2025 01:29:38 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 29 Aug
 2025 01:29:34 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <imammedo@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: [PATCH v9 11/11] qtest/bios-tables-test: Update tables for smmuv3
 tests
Date: Fri, 29 Aug 2025 09:25:33 +0100
Message-ID: <20250829082543.7680-12-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829082543.7680-1-skolothumtho@nvidia.com>
References: <20250829082543.7680-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|DS7PR12MB8276:EE_
X-MS-Office365-Filtering-Correlation-Id: e23079a8-63a9-48a4-122a-08dde6d63768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|7416014|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4y2UobMvQHt4QtrS03/aAjls+hev+uWMiIA3Ap6o8R5+TXhhiPomj29HET+C?=
 =?us-ascii?Q?AbOHHsIF1jtl+9jd3ZnwnUZq1aiHMcZpSu/+agqW+wuRBNhTKrBLsetUKPwv?=
 =?us-ascii?Q?3UmE7GVx55XfTxbawGPtadYyZOj0CxiZQYmDSKyVdJhR0RKIGo0Tb4cdxIT/?=
 =?us-ascii?Q?O7InWG1WQ7mJ0zPxloeGTnWjXe7wPO636ZmeTpxuCsDF8qPl/LvzePVmaQSt?=
 =?us-ascii?Q?+pOGAqRg5Nx6iQ17pIS1uLgXxbHmifeNWv2AIZttn9J/9jl3O8JmclLbDf6c?=
 =?us-ascii?Q?+xBetnIc7TixhwbJ2AKaU9cVSanoj2Ezl2LagGvwTArW+X3VD0yVZWIffmic?=
 =?us-ascii?Q?gxMCJLx0za/R3ymw7/hmO50tnI/CqSzAQIDWVwwqJLoFGqfkl8zZmZXXwyQ3?=
 =?us-ascii?Q?t0YB8wRwKmcy4Bfp5k5RkereGfesYpOIe5LUcK/i7WSoUWzlqsX+d6sKbDz2?=
 =?us-ascii?Q?LMU6vWOcic78s7I5YgOnlfaDmghc2nazH6vDRRdL8SY9l1lW5HvpEhkpJUXZ?=
 =?us-ascii?Q?9cc4Iqeqykru7jMlygb74ivjamKeaO7bJTXyvbsxJdEVm9zakyhY8PdL/NBe?=
 =?us-ascii?Q?BoI1ySrST78aNNz2nhZyAB9sXPWsNVIPf7WDt+XxOR/Z13c9SBO+umDo8QP+?=
 =?us-ascii?Q?iqPDHK2rX927RbHXx50kctJVDvQspHncZCYFn7UPdmbh9pQG4eLUZVD1o/hY?=
 =?us-ascii?Q?ziWQ0oq2lLqEWspaLs60h6G4MdpX9Mi3TzjzdjsqTisO8Otdbl/QLQfe/iWD?=
 =?us-ascii?Q?fdw3WzRraQMeJso/wWIFeGA1ia9My+GNfvnGzeX478UQxdvtnyyUk7qSNeNE?=
 =?us-ascii?Q?bSyYrl+EjMFUmTujxyOFAyADCZy/rUROyNiAwzzBCWNI+75zFHUH7IcDbcTg?=
 =?us-ascii?Q?4onJH8OrHCpcWFrQrAY7mfAae9D9rIy2yN8zmnKcp1McyZo6qBMX2kgQuX2r?=
 =?us-ascii?Q?rUv1hma1Lb1R+N0E+dIVBNaox0CvIVJL5kYH0ghIuNt5XDOM+A3JufdGuRxb?=
 =?us-ascii?Q?EFmp0T344izpMO6EQknipi8R9YsYYl55kSVaqmVnCYfXZkE7ZLj3dQ9jnTZo?=
 =?us-ascii?Q?DlNWXofA2bdmOK0ozOQTcAWJPFOY+ayWQGpZwT1WAv7wD5HXc5Lf9uaO2sew?=
 =?us-ascii?Q?lbVRVr5mw4sZpbD4Lk6leWm7afLIHe+Znm1G+nL+Mqpqs7N59UVqoJb2q4Ti?=
 =?us-ascii?Q?JYvbi2qP9YNaYwOYwB33QNkXTvDi/cN0M7J5qe38Eb5iL7gC50g4PIy3DHEG?=
 =?us-ascii?Q?iLKdZuSZ7LLKJi99dtP9aFOiwRdyAdJm0r69ZI+xLai24M42uUP/+W/zSY+0?=
 =?us-ascii?Q?j4UNDbbPjTi1H137jUHyygd4+7i1d+gk5aHlUgLz581jsS1ktygGE0iN4DhD?=
 =?us-ascii?Q?ozLYGwdeWLEar7LFGUF8zw/i4yNDQgzm9cU8IMAHg4tRKrhHh/uhKJvZJkZ1?=
 =?us-ascii?Q?OJyyglC5QGRLlIQIZLhhDsCiMPrFEDWCrfQlubBM5oqXFTot9txafWizgo2u?=
 =?us-ascii?Q?oHvbeKqBXlCP9W0Y9J4PXlFvf4w2clCnyKFD?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 08:29:48.3112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e23079a8-63a9-48a4-122a-08dde6d63768
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8276
Received-SPF: permerror client-ip=2a01:111:f403:240a::61d;
 envelope-from=skolothumtho@nvidia.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 29 Aug 2025 09:59:54 -0400
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

For the legacy smmuv3 test case, generated IORT has a single SMMUv3 node,
a Root Complex(RC) node and 1 ITS node.
RC node features 4 ID mappings, of which 2 points to SMMU node and the
remaining ones points to ITS.

       pcie.0 -> {SMMU0} -> {ITS}
{RC}   pcie.1 -> {SMMU0} -> {ITS}
       pcie.2            -> {ITS}
       [all other ids]   -> {ITS}

...
[030h 0048   1]                         Type : 00
[031h 0049   2]                       Length : 0018
[033h 0051   1]                     Revision : 01
[034h 0052   4]                   Identifier : 00000000
[038h 0056   4]                Mapping Count : 00000000
[03Ch 0060   4]               Mapping Offset : 00000000

[040h 0064   4]                     ItsCount : 00000001
[044h 0068   4]                  Identifiers : 00000000

[048h 0072   1]                         Type : 04
[049h 0073   2]                       Length : 0058
[04Bh 0075   1]                     Revision : 04
[04Ch 0076   4]                   Identifier : 00000001
[050h 0080   4]                Mapping Count : 00000001
[054h 0084   4]               Mapping Offset : 00000044

[058h 0088   8]                 Base Address : 0000000009050000
[060h 0096   4]        Flags (decoded below) : 00000001
                             COHACC Override : 1
                               HTTU Override : 0
                      Proximity Domain Valid : 0
[064h 0100   4]                     Reserved : 00000000
[068h 0104   8]                VATOS Address : 0000000000000000
[070h 0112   4]                        Model : 00000000
[074h 0116   4]                   Event GSIV : 0000006A
[078h 0120   4]                     PRI GSIV : 0000006B
[07Ch 0124   4]                    GERR GSIV : 0000006D
[080h 0128   4]                    Sync GSIV : 0000006C
[084h 0132   4]             Proximity Domain : 00000000
[088h 0136   4]      Device ID Mapping Index : 00000000

[08Ch 0140   4]                   Input base : 00000000
[090h 0144   4]                     ID Count : 0000FFFF
[094h 0148   4]                  Output Base : 00000000
[098h 0152   4]             Output Reference : 00000030
[09Ch 0156   4]        Flags (decoded below) : 00000000
                              Single Mapping : 0

[0A0h 0160   1]                         Type : 02
[0A1h 0161   2]                       Length : 0074
[0A3h 0163   1]                     Revision : 03
[0A4h 0164   4]                   Identifier : 00000002
[0A8h 0168   4]                Mapping Count : 00000004
[0ACh 0172   4]               Mapping Offset : 00000024

[0B0h 0176   8]            Memory Properties : [IORT Memory Access Properties]
[0B0h 0176   4]              Cache Coherency : 00000001
[0B4h 0180   1]        Hints (decoded below) : 00
                                   Transient : 0
                              Write Allocate : 0
                               Read Allocate : 0
                                    Override : 0
[0B5h 0181   2]                     Reserved : 0000
[0B7h 0183   1] Memory Flags (decoded below) : 03
                                   Coherency : 1
                            Device Attribute : 1
[0B8h 0184   4]                ATS Attribute : 00000000
[0BCh 0188   4]           PCI Segment Number : 00000000
[0C0h 0192   1]            Memory Size Limit : 40
[0C1h 0193   2]           PASID Capabilities : 0000
[0C3h 0195   1]                     Reserved : 00

[0C4h 0196   4]                   Input base : 00000000
[0C8h 0200   4]                     ID Count : 000001FF
[0CCh 0204   4]                  Output Base : 00000000
[0D0h 0208   4]             Output Reference : 00000048
[0D4h 0212   4]        Flags (decoded below) : 00000000
                              Single Mapping : 0

[0D8h 0216   4]                   Input base : 00001000
[0DCh 0220   4]                     ID Count : 000000FF
[0E0h 0224   4]                  Output Base : 00001000
[0E4h 0228   4]             Output Reference : 00000048
[0E8h 0232   4]        Flags (decoded below) : 00000000
                              Single Mapping : 0

[0ECh 0236   4]                   Input base : 00000200
[0F0h 0240   4]                     ID Count : 00000DFF
[0F4h 0244   4]                  Output Base : 00000200
[0F8h 0248   4]             Output Reference : 00000030
[0FCh 0252   4]        Flags (decoded below) : 00000000
                              Single Mapping : 0

[100h 0256   4]                   Input base : 00001100
[104h 0260   4]                     ID Count : 0000EEFF
[108h 0264   4]                  Output Base : 00001100
[10Ch 0268   4]             Output Reference : 00000030
[110h 0272   4]        Flags (decoded below) : 00000000
                              Single Mapping : 0

For the smmuv3-dev test case, IORT has 2 SMMUV3 nodes,
1 RC node and 1 ITS node.
RC node features 4 ID mappings. 2 of them target the 2
SMMU nodes while the others targets the ITS.

        pcie.0 -> {SMMU0} -> {ITS}
{RC}    pcie.1 -> {SMMU1} -> {ITS}
        pcie.2            -> {ITS}
        [all other ids]   -> {ITS}
...
[030h 0048   1]                         Type : 00
[031h 0049   2]                       Length : 0018
[033h 0051   1]                     Revision : 01
[034h 0052   4]                   Identifier : 00000000
[038h 0056   4]                Mapping Count : 00000000
[03Ch 0060   4]               Mapping Offset : 00000000

[040h 0064   4]                     ItsCount : 00000001
[044h 0068   4]                  Identifiers : 00000000

[048h 0072   1]                         Type : 04
[049h 0073   2]                       Length : 0058
[04Bh 0075   1]                     Revision : 04
[04Ch 0076   4]                   Identifier : 00000001
[050h 0080   4]                Mapping Count : 00000001
[054h 0084   4]               Mapping Offset : 00000044

[058h 0088   8]                 Base Address : 000000000C000000
[060h 0096   4]        Flags (decoded below) : 00000001
                             COHACC Override : 1
                               HTTU Override : 0
                      Proximity Domain Valid : 0
[064h 0100   4]                     Reserved : 00000000
[068h 0104   8]                VATOS Address : 0000000000000000
[070h 0112   4]                        Model : 00000000
[074h 0116   4]                   Event GSIV : 00000090
[078h 0120   4]                     PRI GSIV : 00000091
[07Ch 0124   4]                    GERR GSIV : 00000093
[080h 0128   4]                    Sync GSIV : 00000092
[084h 0132   4]             Proximity Domain : 00000000
[088h 0136   4]      Device ID Mapping Index : 00000000

[08Ch 0140   4]                   Input base : 00000000
[090h 0144   4]                     ID Count : 0000FFFF
[094h 0148   4]                  Output Base : 00000000
[098h 0152   4]             Output Reference : 00000030
[09Ch 0156   4]        Flags (decoded below) : 00000000
                              Single Mapping : 0

[0A0h 0160   1]                         Type : 04
[0A1h 0161   2]                       Length : 0058
[0A3h 0163   1]                     Revision : 04
[0A4h 0164   4]                   Identifier : 00000002
[0A8h 0168   4]                Mapping Count : 00000001
[0ACh 0172   4]               Mapping Offset : 00000044

[0B0h 0176   8]                 Base Address : 000000000C020000
[0B8h 0184   4]        Flags (decoded below) : 00000001
                             COHACC Override : 1
                               HTTU Override : 0
                      Proximity Domain Valid : 0
[0BCh 0188   4]                     Reserved : 00000000
[0C0h 0192   8]                VATOS Address : 0000000000000000
[0C8h 0200   4]                        Model : 00000000
[0CCh 0204   4]                   Event GSIV : 00000094
[0D0h 0208   4]                     PRI GSIV : 00000095
[0D4h 0212   4]                    GERR GSIV : 00000097
[0D8h 0216   4]                    Sync GSIV : 00000096
[0DCh 0220   4]             Proximity Domain : 00000000
[0E0h 0224   4]      Device ID Mapping Index : 00000000

[0E4h 0228   4]                   Input base : 00000000
[0E8h 0232   4]                     ID Count : 0000FFFF
[0ECh 0236   4]                  Output Base : 00000000
[0F0h 0240   4]             Output Reference : 00000030
[0F4h 0244   4]        Flags (decoded below) : 00000000
                              Single Mapping : 0

[0F8h 0248   1]                         Type : 02
[0F9h 0249   2]                       Length : 0074
[0FBh 0251   1]                     Revision : 03
[0FCh 0252   4]                   Identifier : 00000003
[100h 0256   4]                Mapping Count : 00000004
[104h 0260   4]               Mapping Offset : 00000024

[108h 0264   8]            Memory Properties : [IORT Memory Access Properties]
[108h 0264   4]              Cache Coherency : 00000001
[10Ch 0268   1]        Hints (decoded below) : 00
                                   Transient : 0
                              Write Allocate : 0
                               Read Allocate : 0
                                    Override : 0
[10Dh 0269   2]                     Reserved : 0000
[10Fh 0271   1] Memory Flags (decoded below) : 03
                                   Coherency : 1
                            Device Attribute : 1
[110h 0272   4]                ATS Attribute : 00000000
[114h 0276   4]           PCI Segment Number : 00000000
[118h 0280   1]            Memory Size Limit : 40
[119h 0281   2]           PASID Capabilities : 0000
[11Bh 0283   1]                     Reserved : 00

[11Ch 0284   4]                   Input base : 00000000
[120h 0288   4]                     ID Count : 000001FF
[124h 0292   4]                  Output Base : 00000000
[128h 0296   4]             Output Reference : 00000048
[12Ch 0300   4]        Flags (decoded below) : 00000000
                              Single Mapping : 0

[130h 0304   4]                   Input base : 00001000
[134h 0308   4]                     ID Count : 000000FF
[138h 0312   4]                  Output Base : 00001000
[13Ch 0316   4]             Output Reference : 000000A0
[140h 0320   4]        Flags (decoded below) : 00000000
                              Single Mapping : 0

[144h 0324   4]                   Input base : 00000200
[148h 0328   4]                     ID Count : 00000DFF
[14Ch 0332   4]                  Output Base : 00000200
[150h 0336   4]             Output Reference : 00000030
[154h 0340   4]        Flags (decoded below) : 00000000
                              Single Mapping : 0

[158h 0344   4]                   Input base : 00001100
[15Ch 0348   4]                     ID Count : 0000EEFF
[160h 0352   4]                  Output Base : 00001100
[164h 0356   4]             Output Reference : 00000030
[168h 0360   4]        Flags (decoded below) : 00000000
                              Single Mapping : 0

Note: DSDT changes are not described here as it is not impacted by the
way the SMMUv3 is instantiated.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev    | Bin 0 -> 10230 bytes
 tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy | Bin 0 -> 10230 bytes
 tests/data/acpi/aarch64/virt/IORT.smmuv3-dev    | Bin 0 -> 364 bytes
 tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy | Bin 0 -> 276 bytes
 tests/qtest/bios-tables-test-allowed-diff.h     |   4 ----
 5 files changed, 4 deletions(-)

diff --git a/tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev b/tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..53d4c07f423886d8c4b57f1da6498eef5a08b556 100644
GIT binary patch
literal 10230
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
T>d9`i-)dK@cGVtG`#|_F_?bX?

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy b/tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..53d4c07f423886d8c4b57f1da6498eef5a08b556 100644
GIT binary patch
literal 10230
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
T>d9`i-)dK@cGVtG`#|_F_?bX?

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/aarch64/virt/IORT.smmuv3-dev b/tests/data/acpi/aarch64/virt/IORT.smmuv3-dev
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..67be268f62afbf2d9459540984da5e9340afdaaa 100644
GIT binary patch
literal 364
zcmebD4+_a)WME)E<>c?|5v<@85#X!<1VAAM5F13Z0I>lOgMkDCNC*yK9F_<M77!bR
zT_CbNAPOcA5rU8tfYd}Fo(#m3AVP5R|9=P*W*^90CZG_)Tqd06P64W$3dGZacp4BR
z19WqlN*I`#feJu=QvqVAJ3&HV-~grnLnS<*d<Fpq2Cx%>^a7X|(1HJXfgB(Wb2oz^
MQ0yI03`oPo01?F*0RR91

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy b/tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..41981a449fc306b80cccd87ddec3c593a8d72c07 100644
GIT binary patch
literal 276
zcmX|*K@NgI3`M`puy8?wi3^u3IDkhWzycE!jI!Vis5{Ti6^7s1@{>QmeVugXHa@5G
z0SNbY?1op>&X2C5h#<9Ops%#*0ztdHi8G?q;$EluQNrhn>{ys@`b&R|d8G8O{Jrdl
mkP$_?rfr{mN!3^;8w}Q?1auX1XIzvDUSRruoXA!(rn3!nx)K2Z

literal 0
HcmV?d00001

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 2e3e3ccdce..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,5 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy",
-"tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev",
-"tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy",
-"tests/data/acpi/aarch64/virt/IORT.smmuv3-dev",
-- 
2.43.0


