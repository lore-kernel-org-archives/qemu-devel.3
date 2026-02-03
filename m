Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C26F1E87841
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:40:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnIVa-00027j-Uq; Tue, 03 Feb 2026 10:40:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Manojlo.Pekovic@amd.com>)
 id 1vnIVY-00027C-Td
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:40:05 -0500
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Manojlo.Pekovic@amd.com>)
 id 1vnIVX-0006J7-57
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:40:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8K63o6t8mttjMArUFXp67Cnk297hTDqkCP1gSw32kUUGV9xtvrrTdTX7yX2EFjeMWsXqaqWUcqj4jFyNu2yctlG2cpK8tWS6IPTiCT/0m7HGW/LZ+eSVdFhS9/Fq1YE3P+EJrO5IOKJuhfBTWYLcdrTwVVJZJ7AAUGAuJqjPHR60omX1DfB80J7b4/u0C+H0TzMVwXRINxbgHEgRQY7pUKliLB1bLB2GI3fMmIW+SlJtKFJmoKNciIJ/dWWHrWNwINaqocSaHf0RRQ8r17zEZt4+L0+LsizDrBKpF0qQNgZBjkXww3yEOmsvusN9QurFF+5/2TuLZpeocAIxmA3yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/lACOTwlJsJUqtjYzqnYFYF9IgBtoRL556eElujoIM=;
 b=C7c09MjC8gez1BXiziIxHuhGRjCw+QdPgDcl/C2U3j3NSTxRkri4sH+iMoGaezhEMKP91dVBVGTpMYblCaw51hpkrxwdnIW2dbhhjY07rfxxpUHlOWwY4JEC85XLEB6ig2O02dBbGYinId+GroJ+IawZ1JEIAcHiaBA0uImBDvF0nIxn+Rm4Ivw+EA/zROQPpmWyjAdv282L+Rh780msEsSmIR6FtRG+FM74Y7QYJLZAaJMgoQn6OzNERNbI2UJwHPkqgaZgWLL+dZh7tueKd3bl4jfb7Ot3DayNAbK722ZFjPmPvCMxc4RRJZ6zzaoPA4dtlkvD+WBlCjPZC+6uVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/lACOTwlJsJUqtjYzqnYFYF9IgBtoRL556eElujoIM=;
 b=dQNytArNjBFs/j2Siybnw+5VIiPV1hOWTUZYzABmh3/1GzgmnsRTjqbX/1SKBEVrbkH6ZuiyN7PHQB2Hvq87FirQ5g2Gxhgo3Chpa4sD4e9YfMPfMO8o6eKAFMLwDlG0SJY/KznnW0Mlojqi3ivrsYmJzY5SRyvh8+Uw+KfuUV8=
Received: from BN0PR04CA0183.namprd04.prod.outlook.com (2603:10b6:408:e9::8)
 by LV8PR12MB9407.namprd12.prod.outlook.com (2603:10b6:408:1f9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Tue, 3 Feb
 2026 15:39:56 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:e9:cafe::74) by BN0PR04CA0183.outlook.office365.com
 (2603:10b6:408:e9::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Tue,
 3 Feb 2026 15:39:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 15:39:55 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 09:39:55 -0600
Received: from RSBMPEKOVIC01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Feb 2026 07:39:54 -0800
From: Manojlo Pekovic <manojlo.pekovic@amd.com>
To: <mpekovic@amd.com>, <qemu-devel@nongnu.org>
Subject: [PATCH 0/2] vfio/pci: Add multifunction atomic ops support
Date: Tue, 3 Feb 2026 16:39:50 +0100
Message-ID: <20260203153952.1337-1-manojlo.pekovic@amd.com>
X-Mailer: git-send-email 2.51.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|LV8PR12MB9407:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b1ef1c7-f4ef-4c81-1a9b-08de633a7b2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nQJaxR5OEQxXlTX+l2e8+qCsYQkySYO4dHTYVExelC9FFLHSInsTe3PfHOnR?=
 =?us-ascii?Q?aE0H/9Dy1ob4qDSvNN990DIDYWo4aRvW+YxAUT1eIwLeG3XGFBEJe3SGvfA9?=
 =?us-ascii?Q?I+c2IxPUm2IirPUMaGiHmmmlxrvOKWjvKbc2lOvybGZfNUAQK8TLiNCi86Z9?=
 =?us-ascii?Q?oqvxbXzOmdUuuOdcIYYx0LJY8RDrlhAtrmSyGmB1UgNrgl+T/Vdvf509aZcZ?=
 =?us-ascii?Q?RAR9/dApCD1F7xePlb5H9kiQwoWPNQd2TAABymx1EnCU4YqwnOxRdlPFPYGO?=
 =?us-ascii?Q?BJjugcLXYG698hJ+Xkeb2NVJ9h7lZMBe4GUSOykUwdNj+jLR8uhZtX1cjBJK?=
 =?us-ascii?Q?f3d86YIxrXJne0ug4D73rlrbYlHbTATdvc8Jc8HG8l8uVNkykkTC+q+Nd2HA?=
 =?us-ascii?Q?H10VoWhn86EfSMHxUGEEKB1/PtKX7dq1DQUWQ56OdsWlRvMH33Qq5GswvRxU?=
 =?us-ascii?Q?OjvrWHtnIqI/QSRgINjyUJ3p5ITf8Y5w3S/5QuVLVavDzf7PteZGpaizqiZH?=
 =?us-ascii?Q?M8/pCVTU835irx6kQAxskO4MJvI6bvxYJQ50vOX9aRX9gtjH4HRZMb0b/4UN?=
 =?us-ascii?Q?+At4ewXQzi+/98mIjpEM3zQjV3dYtXAChffMtq83X8g4B28UexvBdh3niKiM?=
 =?us-ascii?Q?zJ5HCjcJTK3wmB3vinLp7knj81Vp4NZmh6K4FS0nIRjtxS08INyNeAWrQ3ZO?=
 =?us-ascii?Q?gfKeqOm4pm/YdT2q+Hbig5amgI+avPpcqjquMxhzMgpKtqOISswT9UeSEJYa?=
 =?us-ascii?Q?Pg4Orh1p5+Hmx7rkqPfWh+LucD1dnN8IPebg6CFc52aFxM71+pHyNbAKtwbU?=
 =?us-ascii?Q?Utwlbt6njV0WKoyllqY0Bd3cGz/npxAMA9cBOFteqnxja2bFiqCiX3WVtO2y?=
 =?us-ascii?Q?z6zn4AI/gp43zxC8zCQPgkK2A+Wyr4HAcx/05LElez7SrUr7kzuiPmCoXgMP?=
 =?us-ascii?Q?8FgsZ7j3LVQlGk4qMKgUOeFGFy4ye29hB0AaKcq1y5aw/AWhERhYtfjOfUus?=
 =?us-ascii?Q?HvMn/p2EN3tb3mhnZY3ut3GFTr7vq+nAz27y+I49joqfWuaoFs6h+BpVihLI?=
 =?us-ascii?Q?moUEm7gomjbv2t/CAWQvr2DPtflmAXgj0W+lNbDFTIo4et8xyoca3UMWUfUR?=
 =?us-ascii?Q?NyLm7472FHAFvVrmSGrYkBwidH06JQj1u41EMo3bw14Q0GDqjxlZOdUpCVGZ?=
 =?us-ascii?Q?ZvjfaTrenyENR0r/zEfXbwLa6wwqwG8pOuKwQ3+BXP4JYiHocRSCQDHrzGmz?=
 =?us-ascii?Q?6jo6uz/OZEmpeTtwndzOpV7yP0DF+2VGNH32OPmqz1nKK/GY2kLj9+YKxgN6?=
 =?us-ascii?Q?CrRRQiozIyPBFR6/ztQizLTXJwfn881RnFlFYDCVW/DMzVdlMxzi0KFym9cR?=
 =?us-ascii?Q?/B3tgG3a78e1epepJ8OVU3zFeqdXtkf1tkh5+QZJjNZNCtNFqg5fTnmDJp/5?=
 =?us-ascii?Q?6uxqgNW0VEFzjnUsbZWEli7uWS7paK6/VMDUkSN00zoSJCOF2kQC1orEuBvv?=
 =?us-ascii?Q?F8QCiycGsrqYVBOHIrf89KSgZtiP+S90x0oZnpbR55g74w7K7WR+GolLnLpE?=
 =?us-ascii?Q?UFTcg42uClptQae34M9qB8iaHCUIAZLk3HIY0VfrP06X6Uz/Kfc5lVOxMe1y?=
 =?us-ascii?Q?8xh41QgLzGW4T6uLkmkA6o6uR1CnY4WOBFT8Y3wjjPPLGp6fNyNya6udD1aS?=
 =?us-ascii?Q?htpeAA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: K923RaivGi8ZcjavlMX8NYBOj82TxWq1wguA1tI9FeR/x/4jZ4C7g7RDuRFNqznj4kdUFSUkib3RurIKxOsy5SgcYi05Swe2awgkT4OrNJeNra+6vA1NNFvk7Z08f01eM/dWtyCB7ULQaVkeB07uHAuEjDNaWDE6oKIeffUlPo4nDrp01VGairF2LBXY+WYMBWAPmb3YajAeLnDo1blrF8ag3tSrZYQYJH5S7Px2oIivg9cFNy/0jRMI/c+MfzTupztH3O9s2wnzDlI2JRqFe+rjdQHWXZ9m3rmdxLzEIlsjpOlZNTJAO8rLYXjeuf/FUTRlGA0Y1LAgVx1i6FegspkXuHFdkonc09G8oWcc6L5hO/uPmTPvN7PNIB+6kG0HnlUVgeOPPvC5z2XeATKqDwwnIJ1qKp1IFmBpiQ4e14g8kUWfJuegbNzswScx9nFY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:39:55.8369 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b1ef1c7-f4ef-4c81-1a9b-08de633a7b2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9407
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=Manojlo.Pekovic@amd.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Manojlo Pekovic <mpekovic@amd.com>

This series extends PCIe Atomic Ops completer support to multifunction
vfio-pci devices. 
It is an update on previously discussed issues

Patch 1 refactors the existing atomic capability checking logic into
a reusable helper function.

Patch 2 extends the support to multifunction devices by calculating
the intersection of atomic capabilities across all functions, deferring
configuration to machine_done time when all functions are realized.

Manojlo Pekovic (2):
  vfio/pci: Refactor atomic capability checking
  vfio/pci: Support multifunction atomic ops capability

 hw/vfio/pci.c | 177 +++++++++++++++++++++++++++++++++++++++++++++-----
 hw/vfio/pci.h |   1 +
 2 files changed, 161 insertions(+), 17 deletions(-)

-- 
2.43.0


