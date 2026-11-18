Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99AA606A330
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 09:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uTT/PhCG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTcJf-0000lW-5e; Wed, 18 Nov 2026 04:50:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ankit.Soni@amd.com>)
 id 1xTXut-0000V5-2k
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 00:09:07 -0500
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ankit.Soni@amd.com>)
 id 1xTXur-0001Zl-7L
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 00:09:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vAGR0HF0TOozqIZ5qhfLVcGKQQwViDY7Oxh2kWUjXsNA7EjMd4bj+w183S/Tp2EhCIE4WEEIlgDLQOeqz7aFoV58NLay4o9zgqb49oR9kB0HXMwh7F8PPVO2+jvqZCEaN2jdb4J0I1m8psoTj/pgRX6lfcE/HRfmM4inrEq/Ci1QB5ZBJOid5LMi3zc8rcPlabYYA9oGR9XWVs2w97OF6C42rMpX7FkF6+7a5K6VdIb2nNW95pBmnts0aZkwonXfhA9WAXvb7asZ6q5DwLgG3kt7Zc9voTWFADR56f0Di1xp6arFz0H8pYg2REkXPBWCgW7o1N9Ysu16O/KK4DiWeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/bF+2s6db3t4IrOaV82zsSDJZLU5y3MYR+Alv34OCo=;
 b=W4vFEcrfyOSUmxi73a2luEPiLCdRxvUALi6dUGA9LTCuzSj1w8qLlGQJzRQNnBX55Lki7EwGxyLd+l7735PF0gfOW3dcg/PoJDfgs6tBQqCAjChmuAYktEIa0Tz3i0lV87/mtIaFlHzSbDaBHz/4Cv36HAFew21F3n3EQNZujM9N04Rd2p6xmbvVrrURAj3ewhUW44l+4EZbUtvBJwy95QLxpQSQ3IHhofe0vr4Xr0fayPItCIpq8bVqkhJ6Yvs5Co+SUCLdUD2ysC4X5MNUW833u0OYf+/Lgxk1SOiJQ+wUjK9I6VyQPaJDKacVxzFMYNFnAyoJj3D1NUbh4msiXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/bF+2s6db3t4IrOaV82zsSDJZLU5y3MYR+Alv34OCo=;
 b=uTT/PhCG5wwy4Kz9iZqbt2nSRLqclw0oyoQ8uxgADFUcbEEwimCR1VE4W+rrLNNvhjGw1ibXdKpb+IX/mFaNznpP7o0ZZL1FY6Dz6qYMe5GuTbrxVtQ8/dKw3Homd8FrsdQgYo2BE9XMd8YdEQqvo+UnczpL9Vm2BwpkYdyoeF0=
Received: from PH0PR07CA0115.namprd07.prod.outlook.com (2603:10b6:510:4::30)
 by DS0PR12MB8454.namprd12.prod.outlook.com (2603:10b6:8:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 05:08:59 +0000
Received: from PH7PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:510:4:cafe::13) by PH0PR07CA0115.outlook.office365.com
 (2603:10b6:510:4::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 05:08:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH7PEPF0000000A.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 05:08:58 +0000
Received: from BLRANKISONI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 23:08:55 -0600
From: Ankit Soni <Ankit.Soni@amd.com>
To: <alejandro.j.jimenez@oracle.com>, <pbonzini@redhat.com>, <sarunkod@amd.com>
CC: <richard.henderson@linaro.org>, <mst@redhat.com>, <farosas@suse.de>,
 <lvivier@redhat.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
 <vasant.hegde@amd.com>, <qemu-devel@nongnu.org>
Subject: [PATCH 1/4] tests/acpi: allow q35 IVRS DSDT/IVRS blob updates
Date: Wed, 18 Nov 2026 05:08:28 +0000
Message-ID: <b03f38ee325620adfcccf8b63d1419cb57613e02.1794484966.git.Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794484966.git.Ankit.Soni@amd.com>
References: <cover.1794484966.git.Ankit.Soni@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PEPF0000000A:EE_|DS0PR12MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a460db3-727e-4713-d6b5-08df45320db2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|11063799006|56012099006|10067099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3k8Ad7lW59miuZexZ2ygflR/u72Y03vo6/tlxQ4Vr3wmR4Mxblvtj3Pis+Wf0T51ea59AAktI+dSCFHjuoP0ocGwlZwJfVgIt0PeJ+E5nXMXSIh5It6F7rjMZF5boBQVwZ4MUiYmqGxWa62YWs/GtlJVtcs6PMB9y3Rh+6rqxbNsyUgLSkkkQIdrYwPcqnfN9ADORDqK4a+/JwcqEHlAkT6eNFLlhvAQ/5dmVgY5SGs68r93Umh4iO7Pp5p0srAmBf3XZL48obdw1bTXMFr9hcJBuzIs6bMrFwKaPR8JNieHMEMs04BnJdzXCY3BZ/hBKjdpVi/l7S3tORAujgndPCzW5dcjjTp/CbNvYdDDyO/tXGS/VRGTSqAx2k+pXkklcJ7jNveu1hMydUnQjYNl7KdEpO9qiT9ZBA20+oAdptLDMZE7RvUB8EtF0Rk1cgAJicO3FOwA8AYrjl4w9ZSGhxzUO4PDhRoD1HVGJ3NfbYEuCfk/QGcrHkLxkSv+Ti2CTnpaqqWgJpqzo3zNNJr2lDCnrscYHkMOKzYWvAR6pMMNh3jGfqu2Dy5Y2qgqZ0To74lY7Ff1LGkN9TJ6hnQuzlY52zP/PBxjOMeHVo7dwAB8JjuDYv/sgVQVpymIZATyvLTlUjrSPh5NoE9aglyJl8ddeD9M2shO0biMVBW+TgpJF4EnIh9GOsUdUJ/qYQLGqSuP/f80l8fP60dtkKVyfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(11063799006)(56012099006)(10067099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: I4IxzqNfSiEOaP1Qx4I53/llPHwGdspp2bi8yx+b6cxk4nqFhFS0Nma+JTM0PjX4onyg4RU1cFYBUCUbuu4DGX9/ak4jbqF5TxC2MhoEYjzevG8Aa+r0zoRiDeZeKxfOBq35oTZskqvBbhtM2pEwnfJMkWpWP/gyhoHuU+ok0kksEqJRdfF+b5k3xRyxnprzVfcBlvon22sX5edcuxqyAt3iuVODYy/yDGLpFb7bWIG0md0E3TFxv6jB5rMQ9lK/DkzX8g2d5R0HU2lH0z82IFV+5rIy/DccjmOSuze7oMPOWui+Bd03tP182IgLVi/di4k1Hj6lhq/Iq9oiadUjc0W7mtDyo+NxhUeAj0xsI45dYK/w+lujy9OfEnCMBEc3QYLBW/WqyJZ+YhiToAqD0AUfz9udPn5h5oj8yog+f3kzRS8LDme9NbH1JuX3sbZM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 05:08:58.9649 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a460db3-727e-4713-d6b5-08df45320db2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH7PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8454
Received-SPF: pass client-ip=2a01:111:f403:c105::5;
 envelope-from=Ankit.Soni@amd.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 18 Nov 2026 04:50:53 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The next patch adds an FCH PCI stub at 00:14.0. That changes the
q35 IVRS test tables.

Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8bf4..9803ce61b971 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,3 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/x86/q35/DSDT.ivrs",
+"tests/data/acpi/x86/q35/IVRS.ivrs",
-- 
2.43.0


