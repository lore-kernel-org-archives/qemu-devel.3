Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AFE3E87841
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:41:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnIWy-0003eB-5B; Tue, 03 Feb 2026 10:41:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Manojlo.Pekovic@amd.com>)
 id 1vnIWw-0003cu-Iu
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:41:30 -0500
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Manojlo.Pekovic@amd.com>)
 id 1vnIWu-0007Iw-NJ
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:41:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIxeEtcvVbMNpwiCibxIY2kKGzuT4nNW2hECiSePq3+V3gQyz6WyuvBA9la0+5qPwgUMUBN8+vAL7x7CynZemqZzkjV+znTw9XK5/pR+UllbMSGj22C3+2X2+/1em4XP2KvyiKqigXq0WH8XqHYNkc+lN0ibZkpkujyYa5dvsFhH2pbIjELgGkhKQQqyUxjx7sIHZMlpPunhhzMxsugtoHiy5E3PlNm7s4ZKoSMKRefdfq3DOpde5V4ibYSEh/nLLc8W29OmQMCcRTZ3++JG2BW4ghqX+AZm2TE6R/6cRp+FEN0osDCAZYAjnmvBTcaVpUVI4JfSkstqxVcSrzk8Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/lACOTwlJsJUqtjYzqnYFYF9IgBtoRL556eElujoIM=;
 b=j0qErxAqdYLFPi69ZJshIR+qB881bm65DbgBzDxQZUU6xhnvkH7Lxz6dn89iPFnDBI4OquByDcuhuFT9ZTbqmLK8ChyuNlnDbaaC90izhwpFmdU8gSf35BLcB92xBRsugf9HGScnRw5Tc5IKRMvfzNg/KOyd5yu7J8pFEvxUYRAvwW+xUkaX9gzQnlmqEg7BkH0A9cSvmCCOFPWqkRf7VmEA9eWu37BSMCzT30qum271BIVTiJLWpXA+dtV/cDUnJb6Ew+ai5MSAyhz1wwD6opCkV2sHGBRGftpJyY3PIGn1PyGD1SSH/GphWH5cEyTOnUqNL+IGHkOXh9mU/p6oNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/lACOTwlJsJUqtjYzqnYFYF9IgBtoRL556eElujoIM=;
 b=JH0SO2so/p0RsfWZMWDBz+Xn6mlG0ZAn4xXkxwSiF1yEFcONpwJVMbfnxwGAhecN5bgSyZ15QwPpwU+Q2enjAfvmE8Bm6PS9I5RZ5N9/giB32SGtxKlz4PneTsmfNNYTteFU2dZ+OZrlyWfNCyt6EO4/0v1X9BoZT13h6ow92Qk=
Received: from CH0PR03CA0325.namprd03.prod.outlook.com (2603:10b6:610:118::31)
 by DS5PPF922753E5F.namprd12.prod.outlook.com (2603:10b6:f:fc00::65a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Tue, 3 Feb
 2026 15:41:23 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:610:118:cafe::a7) by CH0PR03CA0325.outlook.office365.com
 (2603:10b6:610:118::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 15:41:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Tue, 3 Feb 2026 15:41:21 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 09:41:21 -0600
Received: from RSBMPEKOVIC01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Feb 2026 07:41:20 -0800
From: Manojlo Pekovic <manojlo.pekovic@amd.com>
To: <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <Nikola.Prica@amd.com>,
 <Dejan.Andjelkovic@amd.com>, Manojlo Pekovic <mpekovic@amd.com>
Subject: [PATCH 0/2] vfio/pci: Add multifunction atomic ops support
Date: Tue, 3 Feb 2026 16:41:10 +0100
Message-ID: <20260203154112.1668-1-manojlo.pekovic@amd.com>
X-Mailer: git-send-email 2.51.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|DS5PPF922753E5F:EE_
X-MS-Office365-Filtering-Correlation-Id: 51b0b368-7cbb-4814-ac33-08de633aae45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aW8rKE1cp2f6G/q38VrFxG6hoGyfPSkMabB7h50VRis3UALGMpreSnxqECU2?=
 =?us-ascii?Q?l7HOHUDNQHnEzxTXUkO1kjNCNS3jemoplVh5DGQw5JlWTfb4ngp2PwO13kP4?=
 =?us-ascii?Q?b7G5B3RgxAtQyTXTiv6ywZpblqngQFzfCMI2ue5uwoHnFiq8SdCTUG5xhsnz?=
 =?us-ascii?Q?1xnTYfeRLK227+MwqRYFaG1tPvUl2TOMwa4BXp0wnexXsu8IPrhIuQATeKij?=
 =?us-ascii?Q?Q2HuwBPJtPqvh8xCVhbLHyI63kgOYSlOmlHjb68pb5JZmT/+z1w+a1VnX6n6?=
 =?us-ascii?Q?6tyzD5zt9ad/Z7yTVXpJ1l2rNrriJk/zDLKyxJTF7aC2CVwa6R8O8lrqcKLc?=
 =?us-ascii?Q?ubom8u3B/imi53uP0wmcUzSuhFgmH0dzPTXMFA2xYSnS1mk9sv30VYE4rI2V?=
 =?us-ascii?Q?F8Q1aQpGK+55W+SGKC4XmZ4idfRtqB6jtyr40ZDi6E64p+wxhw+VomPMdlLn?=
 =?us-ascii?Q?QgaF5BNazRqVNPwrszO8apuCMN+m8oRMrPreS8tVQ1O9pqT4yl4Rb+cu5jDm?=
 =?us-ascii?Q?rBGqTpJBSJcKOPzHFqbCQhB7Oyy+Q2B3J5R7a24eCbRwHEu1jATdx22tQ1VH?=
 =?us-ascii?Q?P8myyJ/FcRv/fdOzuJTmwwih26ZkrrObebPlX0hiPk48ui+HawA96/6niGcn?=
 =?us-ascii?Q?yQ3hqWwcHuenaKrJXkVYje8t1GlVZ6VZtJ278lIUKqHT7HpKTPzXoheRbakv?=
 =?us-ascii?Q?ATbiRcBJ9NQpLF2hhkWkrEhbufAQanccjYJIduy57xEtBrXDlvn62IoTF8Cm?=
 =?us-ascii?Q?+qjr6ZT62Cl0e/wuO8PA65ha53dcqIZAA9Ed8B8Gl6zaUbRuOipf4z9eu/hW?=
 =?us-ascii?Q?/9KjDqUncoQbdlDn4f10MGjH+vUW0VCNtjemGQRP46waa6XBo7QjtYL719jZ?=
 =?us-ascii?Q?luS8NrIc2EkWQ6izM5d/pfsr5Hr0M1A6iUkNEyZrxu9jBsI29q0bvuu8FgZl?=
 =?us-ascii?Q?LP/aHgQx7yxXepJ0zvPKNC1xgjEdTfVgF5duw9kV9c1b1H3C0cFLGGm3FTZ/?=
 =?us-ascii?Q?y5FYgIlg1qgr71xtdvDrjv04I9KC7yu4CIVQX/Lgema0W4C3nLuMKNJGWdJa?=
 =?us-ascii?Q?7DJmiybF2gPPO5A3tlm8pnpiCjXaTbahOZHD7wEOJbPBC3PtYx/0jbO87Y/l?=
 =?us-ascii?Q?c1eccRYs7QLvTQrQn3gB0ceo1uZ8QOt65S2icxfJmqQCZ3XaO67EcDGcWfFC?=
 =?us-ascii?Q?5zSD9+pxjFaWunbngI7jH+IqvsPuxJ2aDE54P79ZPOBX8WFK8ZqJPOoiH8UZ?=
 =?us-ascii?Q?ioajcWeWGwE86s/PP0tgI2CK0Kjfp3OOd+UcobyPwtp5mWAxaeJ1M5FqtksE?=
 =?us-ascii?Q?qFKnkq1tQcsL5LfC502Ikop7Q5aOc4OXb2Qvwi5njhJ0wJ5SRDpCeFXNYlY7?=
 =?us-ascii?Q?qqgfF2cl26caZ8sN89V/pt6jZqncCc7X/we0UVOc37jKTyJZCm2Mm1+OY/zO?=
 =?us-ascii?Q?Nvo1n4ZF26CawvioP22tVPUOyg+zStooVi2NYV2Y+I2p2Ab4OwOBi3VwQHmN?=
 =?us-ascii?Q?zJhgYFAJ+eVkSRkTpDtHqEEaJqCthC+eRB13YCOG4kjmbucyvep6/+sc7iyv?=
 =?us-ascii?Q?l/felLWXngre0jwSDqWB9Io4vwbR4fAxFjOTGmWElQT0K4fgXVB8t5jFWQad?=
 =?us-ascii?Q?iFkprkZ3Gi0s8+zdMXSy87DOmjJ6G/MJPIoR5er3PSB/lPlX8Cfdbw+n27Zs?=
 =?us-ascii?Q?Y7yqVA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Sqan8fYQUAFabxa9t9frPEP0TLsenj5loUABviJA1GMT2ENqtzv1sFeQCY6Q9koCMqOb7jm5OeOSr7xLXazNIpXwHYqhTDL//R9XZDQerJtP/gM0M8lpp2+1h1Bkt8EOTXyfNpqgcBxDA8luy7twAufTOSe6thmujdMx95OmrarxHWj96zldtXMH5bAA+zfxyF+BZrDWsh43udZYLzGiF2AVmY7PNf5dbHBWEfy+oGSLHRY5EcV9CmlNugeDGZZlhXr1DgpL7lSz6YYPqIlMcDkCermfIRKIznays/M+3RR1kyUw08uxg2OGhdz8da5PnAXVvHBP2wDXvc/3DFC0zBOw0UzSQDM0xWJxqaqnr6Lh9Hc9cdV1JXO/VX0sSDP3bAxFkhNXkA8j6BZxqcmtCAvO9pS4+2g4sLVRWX+UQNdjUGYPr3rEdUtAvNRn4bJw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:41:21.5855 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b0b368-7cbb-4814-ac33-08de633aae45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF922753E5F
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=Manojlo.Pekovic@amd.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
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


