Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED7F606A325
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 09:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=X2dWmr6O
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTcJc-0000kb-Lp; Wed, 18 Nov 2026 04:50:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ankit.Soni@amd.com>)
 id 1xTXzU-0000qN-7W
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 00:13:52 -0500
Received: from mail-westcentralusazon11013006.outbound.protection.outlook.com
 ([40.93.201.6] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ankit.Soni@amd.com>)
 id 1xTXzS-0006le-HW
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 00:13:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7LNRy1vDq54OTo8P0FUsOiyQuTVOcxXiZVHPAm1T6WHOtLTrUf3XDwPT6aIJkmGb+WTMZEXL3N9ZzxxIyE+rw+60Hi1B4bL21Zqtb8OLFHbviIS0yKfEgqajpPKky9ddDR3PSOv2qyB5YuCjRO0jEG7ZVTq+eFSFgXOC5BSCU+ViDErWYzbQD5ZGZxbFa60/eQaUxIWU9SYMjGILT+PHjXAVG6Izark4axU20oPFDc9RDR7wsx14/9bbw4eCKgNrWPnJ5ykVpSilGbjepFi7DV4PK6av6O6k8yGElHyM6W96cvQ8/bLotkIBRccD0E/P8r65d9j1VfNV+ZrWgcDYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LTNshym94ZgYoMOAwQlJvjDmbxp81h66SmLxi7ZLKaM=;
 b=xSziJd79VJ9wsS8d0rSH9ZXqPGEEqlbGmyWpPrIx6TpCRfe53IYJ5Mip2yW6iPk4zCHs2ND4xUZdrUjuSTXSu9lBJVJdHnfYXXLB9RBCNlRPF7eYCRSnWmvaSFWPieJWE91GHPgMBmwkqMMKwP6cVn0wLK9PjsTctXlCsM/KRCofmVCuGqRny84VfQOBk1MEXPk51lV5R1Vbfw7uV9XbZYW4xybzIHQYzyRsUgnN3BI3oFZdIdJXDNP4M/Yocki2T/XdANWHWGA77/tBCdryo/wKs6KXV4qPvS0cPLYOOZc8yBpj5Tvfnj3uIuwBCrMUeOxzq7Yk4wTB2lFqD/yDeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTNshym94ZgYoMOAwQlJvjDmbxp81h66SmLxi7ZLKaM=;
 b=X2dWmr6OEamZZ2BKRvEGIlWOEJs7imhBnz4QAXEg0kUi7/SOSenXykmVP8an93a8m2n4SoNdZpB339b52aHndiFpo+ILJvv2+/mF0H15kQ+/WrIcpp1cTDNN4BXH+NCD9RueHHaCW2t4hEao2aTCPKcP3E6vo84SUFUX4v4/CrU=
Received: from DSSP221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:3d5::13) by
 SA3PR12MB8045.namprd12.prod.outlook.com (2603:10b6:806:31d::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.14; Wed, 18 Nov 2026 05:08:43 +0000
Received: from CY7PEPF000000F1.namprd05.prod.outlook.com
 (2603:10b6:8:3d5:cafe::78) by DSSP221CA0001.outlook.office365.com
 (2603:10b6:8:3d5::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 05:08:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY7PEPF000000F1.mail.protection.outlook.com (10.167.247.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 05:08:43 +0000
Received: from BLRANKISONI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 23:08:39 -0600
From: Ankit Soni <Ankit.Soni@amd.com>
To: <alejandro.j.jimenez@oracle.com>, <pbonzini@redhat.com>, <sarunkod@amd.com>
CC: <richard.henderson@linaro.org>, <mst@redhat.com>, <farosas@suse.de>,
 <lvivier@redhat.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
 <vasant.hegde@amd.com>, <qemu-devel@nongnu.org>
Subject: [PATCH 0/4] hw/i386: amd-iommu: add FCH stub at 00:14.0
Date: Wed, 18 Nov 2026 05:08:27 +0000
Message-ID: <cover.1794484966.git.Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000F1:EE_|SA3PR12MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: 48c9d650-fb73-4019-e684-08df45320473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|56012099006|11063799006|261026140227099003|10067099003|261022105027099003|261028144727099003|261021121427099003|261102123227099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info: PUQXuPXEFNMZJEVN0DVg5n6Llgtnc8cD64ykFDTIxY2Xe6GAyLBKrw88HiBLKLaqxwSyi5gfcyP7AEl2XZeQWoL8woLnQbBdJAVZRnPVoGmeA+ps+a3wxJDhT+Etcm9PxQlFTQstfZ0532qI87kR5aFVAj47vQg4tQZCWdDG2e7J3KIBhrUZBOeF0AcR5KumNb9OdtE3RjzjjDMZfRD7bbtr3um96F/rPOApm88+4ve/KZbkvdaZIOrUWfGekxaIHFQAE71pLoplItM45N62qOTjnZfzG6hezNzhgW5R44p+cvd1F4vvKTgndFes08Tvbq+IsdfGkeUl/oy+mwShUk97WnS3mz5sMdyBmiDyjmrKPlcyM86zXKLiixwugVaoZ5nvKuidLVNfGUrZLuDkZg6hgPPiArlkLMmbcOaxYLbZL5DuJ8PX2rD3jshE8UIeSBKrdVD4byWXcUz6Fm8pNwvjZFkI33piCPshpKdNEHU/How4haXIG1snkbIHLgsIQ76Wbbenj3DIPoF1+VVy1hrjiBq7931KQva/+0lKu1NoQCZP0ErDapEhhsbSyqnto0S8HOcfEsnOS8FUqpSfCs858wSdyXJAa16rMqP/OvyJ4POZxSPbp4E7TDRrIOHO08XJlftSpNIvVtcc/Wrw4LOWQXn5xxlEJblENE1wvs3go7Ep9tzQwwCeGRAkmmehXb5Ifue2r3vKHbokoN9P7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(56012099006)(11063799006)(261026140227099003)(10067099003)(261022105027099003)(261028144727099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lVP0O3OXneavzSu1FrJ5YIZXSc8OtBZfia+026sk+qDcmJx5ypz8QS4fZ5oGYyoAwBkdyNZV7bLkGtDeFVvqf+0Sn2lR1FQN7uc0is1gV1LBq7uC+y4WpUywslj3SfNHlbfSZWiKmKrhHf3XlYRLllzimsCkoekUWUkdAh56zvwikpf69mOayp7UYQncMqLlyCMEH0GHcXmS3tJKfph2KurbGCyl41q7fAxDZ9NA6SUF6aAC6E/8d6BStumBkgtKtFIjC9E+oGxyiJOTfJz3YrJkfKplrL6oeuNLP6HOxWmC4+/Y3S2zL+Zw3HJaqEnrJ6JpttGM8xzMm1jE1mbPwrLah6QSJ37bwkoo38XZugatNYc0S6l807GClB8KMRgUw9LI/OHFWh56TmL47xS4fbOzyR+39W3UuA7Qveoqh1l59G1kXGk4Dg17pG+3cZyc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 05:08:43.4465 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c9d650-fb73-4019-e684-08df45320473
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY7PEPF000000F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8045
Received-SPF: permerror client-ip=40.93.201.6; envelope-from=Ankit.Soni@amd.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 18 Nov 2026 04:50:54 -0500
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Linux AMD IOMMU interrupt remapping needs an FCH at the IVRS
southbridge IOAPIC SID. q35 leaves 00:14.0 empty, so the guest
class check fails and remapping stays off.

This series puts an SMBus-class stub at 00:14.0 when amd-iommu
is realized. ICH9 stays at 00:1f.x. Occupied 00:14.0 fails
realize.

QEMU ACPI tests require the usual three-step blob update:

  1. whitelist DSDT.ivrs and IVRS.ivrs
  2. FCH stub, vmstate, add a qtest
  3. new expected blobs, empty whitelist

The stub uses AMD FCH SMBus ids (1022:790b) so it looks like an
FCH. Linux IOMMU only checks class. i2c-piix4 may still match
the id and fail probe. That is dmesg noise, not a timer hang.

Ankit Soni (4):
  tests/acpi: allow q35 IVRS DSDT/IVRS blob updates
  hw/i386: amd-iommu: add FCH stub at 00:14.0
  tests/qtest: amd-iommu: test FCH stub at 00:14.0
  tests/acpi: update q35 IVRS expected blobs

 hw/i386/amd_iommu.c               |  52 ++++++++++++++++++++++++++++++
 hw/i386/amd_iommu.h               |   2 ++
 tests/data/acpi/x86/q35/DSDT.ivrs | Bin 8445 -> 8462 bytes
 tests/data/acpi/x86/q35/IVRS.ivrs | Bin 176 -> 184 bytes
 tests/qtest/amd-iommu-test.c      |  30 +++++++++++++++++
 5 files changed, 84 insertions(+)

-- 
2.43.0


