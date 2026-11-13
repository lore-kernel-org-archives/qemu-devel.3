Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014F5606A337
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 19:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=V46ba2xK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRxO2-0006hr-9S; Fri, 13 Nov 2026 14:56:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Benjamin.Cheatham@amd.com>)
 id 1xRxNz-0006hV-S7
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 14:56:36 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Benjamin.Cheatham@amd.com>)
 id 1xRxNx-0006Pw-L9
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 14:56:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ye+T2F2/jhFNUzBSOCnS0nqWdSBOt18C7r6JjjsZ3qRjGI6dPz5to9jUhjzHosL7kxH2sthQ48x8ejZNYGjNt85rGa+KxYJ2LrJKRE7PeMDI7pVx4S0Jk9NeD3Ypa3AQhi24ifcQv47H4acwU1RNvIzvGJwx7Dkm9LQ5HSOHvEcYZ2h22JiVPqIcKO0E/a0slvRta99vmYC9tU7bwzHhqBHDgLiCzA6/733qSYIQEQC/zEo0DVBosISn+w/eK+ZOULrlXqlJIlhXuPEpYDEwvVxGFKezQtL+57l1L7JapRFl1sY6xqeGrtLW4tiHjuq/PQxRw8s162engddp7YrQLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8jdbOsqr2ZL1+VHt5ivTDw4PxETgdqbggEMSTS8nQU=;
 b=iUB3GuQWaz1W24NMGCIXe/4H5xz1gimESDYNwf9HrjO/ZPFrSxG5DwL2Y38jKPH4AJ1IghBoGdNDHmcjk8p74wRKrPNmZGR2fuWrWqxvaBhR+iKCBkB1+jJBP3hjy3X7TKJG6ltC6jBqVFUVaeJyFX9HI1QEIvNg+cR7ZGEneBT3uuLQRMPVNEovZ94zMwQBrxZDB6OA9/YQpt1LOADn0Zw0ke9EKEAK+jYrhkknazdtp59RVaGXXxsgue5ipCdGlLWdgcIhrb3cxHygbbYnv51Fu8XtWXKPDGG/Vwd5NE0A8HSu/Ouzi398J90wVvVHRldWx5qVJYxq0595UeNnaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8jdbOsqr2ZL1+VHt5ivTDw4PxETgdqbggEMSTS8nQU=;
 b=V46ba2xKAAYNNMXSOk1l+FPSWDbRaQwQNw483wZ7ApgbkeMo5VFI71HvS7Bmjx+UuhhOYgLsSuuAVt8SYuX8PiLS3X7cl9SaqT+URDHjGnVn9YKDXjxIiQWI3PNAbC+p0xzXIs5aSgd9oJ/dSh79lTm9Y2iSoDeVmFrWSAoSPLg=
Received: from DS7P220CA0117.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25f::16) by
 IA1PR12MB6115.namprd12.prod.outlook.com (2603:10b6:208:3e9::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.8; Fri, 13 Nov 2026 17:49:44 +0000
Received: from CH7PEPF0000001A.namprd21.prod.outlook.com
 (2603:10b6:8:25f:cafe::9a) by DS7P220CA0117.outlook.office365.com
 (2603:10b6:8:25f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Fri, 13
 Nov 2026 17:49:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH7PEPF0000001A.mail.protection.outlook.com (10.167.244.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.0 via Frontend Transport; Fri, 13 Nov 2026 17:49:43 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 11:49:43 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <pbonzini@redhat.com>, <zhao1.liu@intel.com>
CC: <qemu-devel@nongnu.org>, Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [PATCH 0/4] Update TSA mitigations for Zen3+
Date: Fri, 13 Nov 2026 11:49:22 -0600
Message-ID: <20261113174926.1861-1-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH7PEPF0000001A:EE_|IA1PR12MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: e791f0c6-b21e-4795-4f46-08df41ae8022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|11063799006|56012099006|18002099003|13003099007|261021123027099003|261009223027099003|261028144727099003|261102123227099003|261026121527099003|261022075727099003|261026140227099003|261021135927099003|261022105027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: VkWn2D2YCtDBRK0JEabmPUX/tL5RWW0G0JJFFLNQTQ3c8CpuG1cO0OJinooTOpbu/sa2TVLkp+BilIG/6F9BtyJyVaTv8A7Ve97dH1zZI8qh54NWmAqzlHMCkc27onYZxsUgkgM5grIrz13rrAcZ1hV7hs1FPg6Xg2k28sAnWs91vb0tNxIwnp3QWjJD6LdD+kXpcF2N9WybdSIEtSUEdS5muGQOd1w1/wjaYUI4/A7h4gPPhXW8Jev1Wk20e7JMV5lenbB8UOS9FE7Vy20J//XdXFny23/GizkprYgqrCmIRGR5W9l5qmTNA9PFE/fx5fqZL6SUk/KmBHsKCWN7LiCEQCum6GltvEVlBMkLW66P+59s6b7XgaZpvQlUuGlReyTCklp4mHZWokLlJKUBX+3/JzDF1TquMsiXVnJOx9W5v1DZn3cdIsxU5E79fIoMtjrdSY/YmMgVA4ZCWd5BoyLeKCpEjWlviExQKwy2Yg7IMLkGMDdZdb2Sy20md5LCHAeBFy/pf3eqlGNRunW5LmBiAH3s8HAzOVrXDOJM9WTY91Nx//MlVaE2RLHaFwgAKKulf204QxyM5DdQ+UqCvoOPsQaEApHmqUqnyi7PjymVlZI3SBbobWdvwwuSIlrk0qyQPp5MVaWIArJ4RR4jIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(11063799006)(56012099006)(18002099003)(13003099007)(261021123027099003)(261009223027099003)(261028144727099003)(261102123227099003)(261026121527099003)(261022075727099003)(261026140227099003)(261021135927099003)(261022105027099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: plkgUrJZnWCHxzs9eX5XwcWfzTZXTPLWbKtuNhkBxsrk5vZk1Aa4/s2nu9ayeBzWGjUmO8F1TqNwBMIiNfQw04NbAB6PhCjvZumzpqAHs2RWAayBqcydq1KMnCi+QM6HX/gna+uWBBiLPa+/xEHQ7EJ1RH771coZ4yhchQ4eq/c1MPo6agwwU6GciQjE7xivZJUMYAAf2Dc8+yD9faOuBRiKQHYqNNkgZJbbcBl2EZD7n3bEhK3OFOjP6AYb8tdfgvd+57zCy1d/uinoX/PeLP9sWA/mLe5bleTJ8RjUJ+BzccqSVMnucS6Mmu0Zpb4KkpSc8Y8upyJxJI+475iLOKNZ+QKkAP53muMwBK6nT9R4o7VQQgVw/SuhumRNlpFr21tNMjbHM0FmaRJcaedySBV8kmVd2wBJJI8hXvXL1ICPhXYJ2DIi65FbMw0rvlMX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 17:49:43.9189 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e791f0c6-b21e-4795-4f46-08df41ae8022
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH7PEPF0000001A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6115
Received-SPF: pass client-ip=2a01:111:f403:c10d::1;
 envelope-from=Benjamin.Cheatham@amd.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This set adds new model versions for Zen3 (EPYC-Milan) through Zen5
(EPYC-Turin) to bring TSA mitigations up to date. This is done in two
parts:

	1. Add a definition for the new TSA-FILL variant (Patch 1)

		Only Zen5 is vulnerable to this TSA variant. QEMU invocations for 
		Zen3 and Zen4 may add "+tsa-fill-no" to the "-cpu" argument to
		set this feature bit.

		This bit is not set by default because it's not supported
		by SEV firmware on Zen3 and Zen4. If you try to start a SEV-SNP
		VM with this bit set the guest will fail to boot due to the
		firmware rejecting the modified CPUID page.

	2. Set the "verw-clear" feature bit for Zen3 through Zen5
	(Patches 2, 3, and 4)

		This bit is used to mitigate the TSA-L1 and TSA-SQ vectors on
		Zen3 and Zen4, and the TSA-FILL variant on Zen5. The definition
		for verw-clear was already in place, but unused. This set
		rectifies that by setting the verw-clear bit in an updated model
		for Zen3, 4, and 5.

		Updated microcode is required for Zen5. Any revision later than
		0xb002175 for Turin Classic or 0x0B101066 for Turin Dense will
		work. Updated microcode is available in the latest PI release
		or from linux-firmware.

		Updated microcode has been available for Zen3 & Zen4 for a
		while, but there is a revision check performed by the Linux
		kernel. If QEMU is complaining about the "verw-clear" bit being
		missing, please update to the latest PI release or microcode in
		linux-firmware.

Linux kernel support for these changes was just merged, see [1].

Quick note: This set conflicts with the Venice & Turin v3 model I sent out
a few weeks ago[2]. The only conflicting portion is the Turin model patch,
either that patch's number can be bumped to v4 or the two patches can be
merged if both sets are picked up at the same time.

[1]:
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cf27412f19c9cc5909b9107cd1b3f4ab7608e362
[2]:
Link: https://lore.kernel.org/qemu-devel/20261029195623.2209-1-Benjamin.Cheatham@amd.com/

Thanks,
Ben

Ben Cheatham (4):
  target/i386: Add TSA attack variant TSA-FILL
  target/i386: Add EPYC-Milan-v5 Model
  target/i386: Add EPYC-Genoa-v4 Model
  target/i386: Add EPYC-Turin-v3 Model

 target/i386/cpu.c | 32 +++++++++++++++++++++++++++++++-
 target/i386/cpu.h |  2 ++
 2 files changed, 33 insertions(+), 1 deletion(-)

base-commit: fd7ab698c921

-- 
2.53.0


