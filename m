Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC07606A898
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5Q/cK5m0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSx5a-0004cI-D9; Mon, 16 Nov 2026 08:49:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1xSx5V-0004bE-Om
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 08:49:37 -0500
Received: from mail-eastus2azon11010045.outbound.protection.outlook.com
 ([52.101.56.45] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1xSx5T-0007qd-Bd
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 08:49:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rcKO6TJRjUd/8CtbJCMuZxnLBoAbNYJikXaVFabwtJNZghPOXArH1JlsNwx83A3J3myWWwB0VvHBjfQHYtCEYAn8nnmhIwpo8XVyp3tK2phlwgz6ac+uJF1lrdRa1X+MKmqxPB3y94bNhzgk+oWzp4z3+AUiLUX5FwLRpHX6HyiwvpflZ1pUY8o26Mgqs5ziQ8gpwLGIZshyxNrkPrtEn7fttYs+JoomvYtlfW+E7HQQqddIHM73X7FNcM2WojjbSRlk9VqBC5Iqi79M9gVb7rrAz5+VW2Gtm54CmpqGLeIpEpj2xcyvrYs+AIboPCEI8POp1c7enlvivXKWlWYJ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DstsUlbTnf4X5DQD5zsV5cDSQ22A6gW59S48sLuciGQ=;
 b=yYZhoQK8/Tpfeef0Uh7SfzrF0Xv4A01FLMc2GGZpFVvIZTVgrtHxZB9HdIjx01N2IYq7FyxkWMcq4GiCxlXQDxNkeWp6Q0VstXV3qIsSFnaa/54ffp9zpJitqJEvviUTK7Nb7FzkhHsn5a8IqOWBA3nFt+KDWwHwvaIWxduSxazXAA5lQMYZYQfmjLx6jufXzbDyYLYlttuG4i8gJR9DchZwsEHLm+zMqoxPLcPE6joMeXRmd03rIeQpAywfdxWrRVSu9d5CcbZ+MC5KR8D7JfQR7phDUlEb5eZxivMjlMBAU+eXpf0UysOIaDzAChMG8yNFSz56lfa5xDDToKn5RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DstsUlbTnf4X5DQD5zsV5cDSQ22A6gW59S48sLuciGQ=;
 b=5Q/cK5m04o7ijQVPMj4SwZ8h+SqYI9smprJeYostI+PGh0vQTyaFnKb4Denhsws2GHBzj8TNGI292k6Adwvznvu44fsLVPXqJdSrCk/XmYWfCnch7ADDL6oArmHSyT1FU9/7fjypS6x40eFA5aJU/1F12/cUelGaKPYzd/QEeFQ=
Received: from CH0PR04CA0089.namprd04.prod.outlook.com (2603:10b6:610:74::34)
 by CH3PR12MB8076.namprd12.prod.outlook.com (2603:10b6:610:127::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 13:44:22 +0000
Received: from DS8PEPF000000E3.namprd05.prod.outlook.com
 (2603:10b6:610:74:cafe::42) by CH0PR04CA0089.outlook.office365.com
 (2603:10b6:610:74::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Mon,
 16 Nov 2026 13:44:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS8PEPF000000E3.mail.protection.outlook.com (10.167.23.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 13:44:21 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 07:44:18 -0600
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>, Sairaj Kodilkar
 <sarunkod@amd.com>
Subject: [PATCH] acpi-build: Walk PCI root buses when building IVHD entries
Date: Mon, 16 Nov 2026 19:12:09 +0530
Message-ID: <20261116134209.30331-1-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS8PEPF000000E3:EE_|CH3PR12MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f52bb08-66c4-4305-b181-08df43e7b812
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|11063799006|10067099003|56012099006|261026140227099003|261028144727099003|261022105027099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: TEnKJ5r/pPY09yUDLiyBkBZmIWXqs6qR5p5SLPXaZY/eQAQVvuCs9ILHChqu9qF7RKh/9Rbguyd20T+BvdLd6NfNxGMe4U7FrpE038YlOi9N+Or3K9doasLWWXHUGW5b/2w5ZXwgZkqRfu6B5W/x55YaxXZ0ig87/Z3v/h8i8GZ4Duvf0RtyevZmusV3WgOsIGTk0Gcdxf6538Uf3cG+juS2GX2lGEwZLmUP+519vm8kB6KgQDA0T9UfEJdWHtqJbm9HGeRgm53qrBdMegiQXLVHvgDj93Gpx+kWNjEvQgvkr2ottqWJDzmclk90lQHxc7o1JRfTSgVWnAlqe3UOVXmes0tPoC99yIOOe9nFcdhkjFzECBqsapz4uxLDaPnDlfkSkwtWM4jCaGL9806G66Gxwt/O2XO+pRRDjXhLbpHaOf1aKMlDTay705989cRBpTI5ezDCkQnx2xvF6YL2qQDCzJJJsr3IyeYaMaaE3AzNN5XwvkDXQv51RVjWMBEsuBHuxcDW2oKfSvvRGWKqlPx9C+1UA3J8MK5DdVYpyS3VlfL68t+ROTav7e/9zcAMCw782hz/cn0vmqbmddPwAwKtNApL5Ct7xSyldNUhncKCQ0FhOP42pGtJI9BWnhJNEJGRABnq/csGxCdhsJtwwA2cr1w0GGdaxw+2Kl7MWnUxShQkPTyug2uoL1L3xBU9kGNMd57gT97NjVo/3BOQ1g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(11063799006)(10067099003)(56012099006)(261026140227099003)(261028144727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: euf9+OAKW/AL4PvaQrkAK0idxAB4hcL+p7eXQBDrIN9MNMsvZebKn+SHTRHbTyOnwFOC8m7MlOTy/SJY0A4OaAKecCB5SEtjTq4lojKYr8EswrOa0mCr7OG+kgwB3oaPGbHUmo7MYhK2wki5unECZMhalRQSaqNEPglku3q5HZ6v2/CT7d2uYxqWSopogbAnqqQdd84aFnr0p2C0wCsZGHJ/WQDrZJUfWefIR/QHS2x0IRpmtkqEbUWlFuYIeNO4zAOeBY00WCKFY0sMuI9MchtyKyFva/ujQIN3d86FxGXNy62cayN/+TO6gZZxYFfG0GF0aKjiPQPLZFofFu2bS6n7VZvZ2fAdSlcWD40aR63F6LGEXZe48PmF4y8MNPP05eXuyCZ0Tr19ByjGVfCyt8g6EJu4EvRUIhWLFsP5deJhWUu2Q8HtKyVW3jjd46cS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 13:44:21.3873 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f52bb08-66c4-4305-b181-08df43e7b812
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS8PEPF000000E3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8076
Received-SPF: permerror client-ip=52.101.56.45; envelope-from=Sairaj.K@amd.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

add_ivhd_entries_from_bus() treats every bus with parent_dev set as a
bridge secondary bus and reads PCI_SUBORDINATE_BUS to decide between a
device walk and a leaf range. A pxb-pcie bus is a root bus, but
pxb_register_bus() sets parent_dev and links the bus into pcie.0's
child list. The pxb device is a type-0 host bridge, so offset 0x1a is
a BAR byte rather than the subordinate bus number. The walk currently
selects the devices on that bus only because the BAR byte is 0 and
bus_nr is not. If those values match, the builder emits a range and
skips the devices and bridges under the pxb bus.

Treat pci_bus_is_root() the same as a bus with no parent device.
pcie.0 and pxb-pcie then get a device walk. Bridge secondary buses
still use PCI_SUBORDINATE_BUS for their range entries.

Fixes: f3370c89e1726 ("acpi-build: Create PCI topology using amd iommu root bus")
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 hw/i386/acpi-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 985515434974..84a8b14d83a6 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1776,7 +1776,7 @@ static void add_ivhd_entries_from_bus(PCIBus *bus, GArray *table_data)
     PCIBus *child_bus;
     PCIDevice *parent_dev;
 
-    if (!bus->parent_dev) {
+    if (!bus->parent_dev || pci_bus_is_root(bus)) {
         goto select_devices;
     }
 
-- 
2.34.1


