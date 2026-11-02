Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7E8606A326
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 18:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rXAm1vzt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNwXS-0004zd-Pk; Mon, 02 Nov 2026 13:13:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1xNwXH-0004vy-MG; Mon, 02 Nov 2026 13:13:39 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1xNwXE-0003Yr-QM; Mon, 02 Nov 2026 13:13:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWQzH/8CILD/Qrevh1t8af+VxUxALp7D6DZ5CqyERrnnZK/JZu+WkfZ/xlnWnwsHciaQayiInZlDDJNP7+5Yuf61touo3KgKuegtdHBDyTwlFxGNtT/F4d1+1H1MVQdbG9ZxC5IakEP7m71TvOok0eXcU89suhJ69sDjUr99XgiYDCB9KM5ytl8XM9oYrf14AtUjPzhNYjT3MiJZHhLA2fXJSVIP21Tigkn5fbBza6qDi+nIbalhOUzYAK0yfKp8fS0Izslwb2xxGsbBNuj0SQNtte4wPYLQFhBcGObND8pVQtI3trrgKoN1BK7TaWrgyZAEcRyY/YC3DC4SS8y1/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ad487xinjB6pLt2nzkmVd9lN0ap/UJ4uHyCssk0HV7k=;
 b=RB9LlIyPU2A/7PzBNd2GH1+PaCiWdrV7e5zN4w3TYQ9G7Hg6LIk2CxUicintkJdc/7zISyY/5ytc/yGZt/fUdtlx4UF9VnleJ9X5ru8pqtiVlLx4zpW4qaLiSqSGHyQc2Alsud06w0ClvzwxCyxOSG3BqKzNLgok0Lq+/GXFdRoQeKtwdB1poWaBh3eTadfwQrGBq9DS/oIUMDByMyiTppnFuL/oNXTM3rOyai+X4c+nuc77PceT7l1k07310vr/FTeVmj6OBb9u23ed+bj3Glacn21YncCu36F2hfgBTmuvp7fEykyUtCWLAtA0nRCcNIPdOY6wC3GNmvG17hwBsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ad487xinjB6pLt2nzkmVd9lN0ap/UJ4uHyCssk0HV7k=;
 b=rXAm1vztyLA1Un08Z/DT0Ddi9hleUWf995Up7fpj2VY7RmqkEUhUu5I+fe7TIjwEv9kFQwU3ZVpz5nr6BZp5jP4mlRh2Mv5zKj+m3zNkzyTpunt0KGP3K/545cY3x9jOI0somNS1XXFJK4KFGJz53t3WXhUjrAxNC7/ywr9cZISg8HsrOhCUXFaYV5kBkIHZd4OA/AV3utUmej0JL+hqS0aOPPApz8C67AU3KEfvzmSZGyGCXvXezKkqojCLJ5/igJW2UU7Kud+wexkVDDZ4hMnOC+c1wn3x80FmrhJEP05dgSH+M8QoPoSyr5ST1K1sbAiIYdvR3d+VARMuqBZmNw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by BL1PR12MB5993.namprd12.prod.outlook.com
 (2603:10b6:208:399::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 18:13:02 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 18:13:02 +0000
From: Tushar Dave <tdave@nvidia.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 marcel@redhat.com, devel@edk2.groups.io, alwilliamson@nvidia.com,
 jgg@nvidia.com, skolothumtho@nvidia.com, ardb@kernel.org,
 kraxel@redhat.com, tdave@nvidia.com
Subject: [PATCH v2 1/5] hw/pci: introduce PCI fixed BAR properties
Date: Mon,  2 Nov 2026 12:12:37 -0600
Message-Id: <20261102181241.3077981-2-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261102181241.3077981-1-tdave@nvidia.com>
References: <20261102181241.3077981-1-tdave@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0034.namprd04.prod.outlook.com
 (2603:10b6:610:77::9) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|BL1PR12MB5993:EE_
X-MS-Office365-Filtering-Correlation-Id: f7f99946-b002-4019-fc31-08df390ced14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|11063799006|56012099006|261009223027099003|261028144727099003|261021121427099003|261026140227099003|261022075727099003|261026121527099003|261022105027099003|10067099003|22082099003|18002099003|261102123227099003|6133799003;
X-Microsoft-Antispam-Message-Info: nRFucZTMSoMvjnWC8ZQFCEBC4WSol1OKGI2UZeDHZIwo2BKVM4g4VSbQOEXqi7cQhgmJCg30mxRhJp1etYDCHFyNb1rdiBK6M3VddmSucMmtgreKD+Lj885OvBXXBEsgjOm8XTCMTJRf47JlS3m0EPabU5t/NcX5HeoeID0Ar3juSRZ6qgiO1QO87BCMJXZZYCZuKUmfmWYqpFERmWvV3oWT05PVvM4EZEdeo+ifqEly3OlDnmfwYGYthAS/12eDRCvYW5xF84CKQpR7gRVgVO/JqZp3RZyzgsvaAlFib6pDXJp41Cw+A7iL58JPY/PvGVmNrBrNRBlibuLKWrXUqzuj5A9jDQgY3vTp/PaCXoO0QNFRVJE3S9HZ5s40I1Y8fCLHvKdM/ArIeVYWe6/62CvXL77vLFnRs7MgwrDSiiQovdMSuFvIb5IlVpFiYTn/6glQ9tQGTIkShuhPTp14vt2UIiSeDYDZmYd7gGji2WOKaYgyiFe4sN9lcQ//ctFaZtCjBqqLbTZKvhE6HfFBtiEtTuLr9bGqTjQGSHlgMd6hh5xdCltXwWVy4m8rSyKJw184i2Jk4krd95n9hPCNhlvrxj/ki19hIaCOs10JZ1RGV+6V+GGyx5H2oonSce7JEUu3jkDvkTt4kQhuCRdqqOpBfJt04ZN9dTTTP+d80u8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261021121427099003)(261026140227099003)(261022075727099003)(261026121527099003)(261022105027099003)(10067099003)(22082099003)(18002099003)(261102123227099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kp1UF+lXhD7Nf4EIxWdmzxbTqfESHc4HCRrQw1ZKw1liFdJiBRgJzTCtyhp/?=
 =?us-ascii?Q?A8Yi1hpmrrGfASH4yue8ZyF32MAf+fbPqeyps/Cn3SI7JtykqaAf3P4XzspB?=
 =?us-ascii?Q?KslCtnaPXXgkOGxCf++yijOQh8b7nAmBHgV3iWimZqJnoj6eDiKygdpq6hCk?=
 =?us-ascii?Q?VtPObC3B+cCAm6DG2Op/4GVUDhuP+2SQCRYyXvJWV3ejSicSDzyhlh5AYLyk?=
 =?us-ascii?Q?Tv/5f6SEGx9KRcheOI613itjxtqlCqduidzEBLtbug17dZz1J2fPFD2Sx9x5?=
 =?us-ascii?Q?Hw9WFU6TsWQ7vC5RNrNAZBF6LLh766h9loe8eiR4bOQjZ1Xk3CaQkEbN+XdJ?=
 =?us-ascii?Q?41bw67I4Afc5bBiN4z0FNUbcvFn8sDX2t/KMn1QExEYRNeTz412m5dz6dgwA?=
 =?us-ascii?Q?fCPP0Db1jT2f+shrcwwIFan3/739wFLQcNVVNbyHUDk9fJow7cXWpdsXyW3g?=
 =?us-ascii?Q?Xk5b3tZgT+kOOyR8uHiE/bM1C0igrhJ1kztvpGA4GNRnQjDtHXZ48PD4WttB?=
 =?us-ascii?Q?4p3mbIJSA017orVpvNo8+O0/zwOBVTq9BJQO6huHxY675Nxk7dq9Dt1SsD3P?=
 =?us-ascii?Q?Wfsj+RTABKkEocS59CffgJ2jP27M4TpoEYL9CEpj+UqA4IaI5OumwlE1AFvl?=
 =?us-ascii?Q?dfbXdUf1btKiE2Nt6zb0bUufwmQOurcFaM925SUIIR8pwtgqVHcNla4CmeZp?=
 =?us-ascii?Q?nOzmbDsiWECxe1vlIw7VgOmJrlFfdWpqmRNYNzBrJE6bJirBia1G+lqq2CeF?=
 =?us-ascii?Q?LGL3DjojMV8WEi0AfLpURVULRYeNy2X8WZx5a/Wf8YLwD1/UX4+pbg2EGkRD?=
 =?us-ascii?Q?knZ4oGxaIs+F1ou5vuAHmgJSkZJdhcLENe+SUYXxlxHJi2s/Gt9uZGew2TxI?=
 =?us-ascii?Q?zGp+4PHygHO7Xo7kadV53lzwbEiIInGHPgk740G+Dynx0WNfRQiIykGOwfk0?=
 =?us-ascii?Q?8erJ9fudqPxvo32SbfF4lJbxk2/EDnYRfOwChKzcXnGBgLb0prIk0voQTgJO?=
 =?us-ascii?Q?c9pX3SFYih35qOi2Q7CG/7gq9MxIQw2MEJ6RIalHaWmzegu/1kurghsLyDnm?=
 =?us-ascii?Q?qKZ3njMDhkx4tW5gxncZ4y/ByMlLcvkf9x+Sw7bzqywn3KCBecx4+sYgIQ/i?=
 =?us-ascii?Q?PA1ECpr5Er0J64prvUZtYoTn8REowIbY9yow5ZQM6CKlJc/tQMB1yIrmP5pB?=
 =?us-ascii?Q?yCJgRsKXfaWShAGSIu94eFR7wFKEZyqrburEL4CMgfdjIUsJ7vJReKqKicp1?=
 =?us-ascii?Q?QM/5IKHrMF3SSYCy5AaNPqoyYK9oWphYbIEXfUkZ067wTw57HFqzz2/q2e2I?=
 =?us-ascii?Q?qidMLyamraO1pgOkAJ5Q+CnqI9wNJarqr3K2ziPldx7lHTJppXWK9OHBLdoW?=
 =?us-ascii?Q?mCPP3w9UK79Ls37N9g9mpsTM5wzqrsW5jdg7gZ+9+4F7rbGjM7PbVYpFGAko?=
 =?us-ascii?Q?D4Vc9JxVmAMJoldKtS3dUGXgG2T6i1jibbPm+aBHdzDXIizJPxV2pgtAg6E2?=
 =?us-ascii?Q?mfhmKomnzvXUk2hbf/Domxv7sG6yZ5sObQtju9N06uWoP8+rjWK9P4qRNw4x?=
 =?us-ascii?Q?QAl59TvTBQdy/8hRyE6/LKtpUo5/3sOJzLl/O5uoonu4+/NLVjbazIpAO4KS?=
 =?us-ascii?Q?VHNBKIZaLwL+U5GnlYX9903N/gWfncrXavfjQCc/xRQZGxNf111IgxMBfDgs?=
 =?us-ascii?Q?r5Zg6DOvAsvvyBCHUKCXiZwxlHoWTqt8N2anYdKQIJ7FpukN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f99946-b002-4019-fc31-08df390ced14
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 18:12:59.0799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 34vMiL8OMW4m/7zV5228qvDCJ9R3IRlo0Rs/320Es6kZjj0XjI6dsdkrJnE3bkZ7dhN+FuLKUme1Thm4MbnECA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5993
Received-SPF: pass client-ip=2a01:111:f403:c10d::1;
 envelope-from=tdave@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Add fixed-bar-N properties to PCIDevice to allow the guest address
of an individual PCI BAR to be explicitly specified. The properties
are available for PCI BARs 0 through 5 and accept QEMU size
values, for example fixed-bar-0=0x40000000 or fixed-bar-0=64G.

e.g.
-device some-device,fixed-bar-0=<addr>[,fixed-bar-1=<addr>]...

During realize, validate that each specified BAR exists and is a
memory BAR, and reject fixed BAR configuration for hot-plugged
devices.

The fixed BAR properties are only supported on machine types that
implement fixed BAR placement. Add the `pci_fixed_bar_supported`
MachineClass flag to advertise this support, and reject fixed BAR
properties on machine types that do not set it.

Signed-off-by: Tushar Dave <tdave@nvidia.com>
---
 hw/pci/pci.c                | 71 +++++++++++++++++++++++++++++++++++++
 include/hw/core/boards.h    |  3 ++
 include/hw/pci/pci_device.h |  7 ++++
 3 files changed, 81 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 2d2fe02c68..e9ae0d5648 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -89,6 +89,18 @@ static const Property pci_props[] = {
     DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
     DEFINE_PROP_UINT32("romsize", PCIDevice, romsize, UINT32_MAX),
     DEFINE_PROP_INT32("rombar",  PCIDevice, rom_bar, -1),
+    DEFINE_PROP_SIZE("fixed-bar-0", PCIDevice, fixed_bar_addr[0],
+                     PCI_BAR_UNMAPPED),
+    DEFINE_PROP_SIZE("fixed-bar-1", PCIDevice, fixed_bar_addr[1],
+                     PCI_BAR_UNMAPPED),
+    DEFINE_PROP_SIZE("fixed-bar-2", PCIDevice, fixed_bar_addr[2],
+                     PCI_BAR_UNMAPPED),
+    DEFINE_PROP_SIZE("fixed-bar-3", PCIDevice, fixed_bar_addr[3],
+                     PCI_BAR_UNMAPPED),
+    DEFINE_PROP_SIZE("fixed-bar-4", PCIDevice, fixed_bar_addr[4],
+                     PCI_BAR_UNMAPPED),
+    DEFINE_PROP_SIZE("fixed-bar-5", PCIDevice, fixed_bar_addr[5],
+                     PCI_BAR_UNMAPPED),
     DEFINE_PROP_BIT("multifunction", PCIDevice, cap_present,
                     QEMU_PCI_CAP_MULTIFUNCTION_BITNR, false),
     DEFINE_PROP_BIT("x-pcie-lnksta-dllla", PCIDevice, cap_present,
@@ -228,6 +240,58 @@ static void pci_bus_unrealize(BusState *qbus)
     vmstate_unregister(NULL, &vmstate_pcibus, bus);
 }
 
+static bool pci_dev_has_fixed_bar(PCIDevice *pci_dev)
+{
+    int i;
+
+    for (i = 0; i < PCI_NUM_REGIONS - 1; i++) {
+        if (pci_dev->fixed_bar_addr[i] != PCI_BAR_UNMAPPED) {
+            return true;
+        }
+    }
+    return false;
+}
+
+static void pci_check_fixed_bars(PCIDevice *pci_dev, Error **errp)
+{
+    PCIIORegion *r;
+    int i;
+
+    if (!pci_dev_has_fixed_bar(pci_dev)) {
+        return;
+    }
+
+    if (!MACHINE_GET_CLASS(qdev_get_machine())->pci_fixed_bar_supported) {
+        error_setg(errp, "fixed BAR placement is not supported by this "
+                   "machine type");
+        return;
+    }
+
+    if (DEVICE(pci_dev)->hotplugged) {
+        error_setg(errp, "fixed BAR placement is not supported on "
+                   "hot-plugged devices");
+        return;
+    }
+
+    for (i = 0; i < PCI_NUM_REGIONS - 1; i++) {
+        if (pci_dev->fixed_bar_addr[i] == PCI_BAR_UNMAPPED) {
+            continue;
+        }
+
+        r = &pci_dev->io_regions[i];
+        if (!r->size) {
+            error_setg(errp, "fixed-bar-%d: bar%d does not exist on %s",
+                       i, i, pci_dev->name);
+            return;
+        }
+        if (r->type & PCI_BASE_ADDRESS_SPACE_IO) {
+            error_setg(errp, "fixed-bar-%d: bar%d on %s is an I/O BAR, "
+                       "not a memory BAR", i, i, pci_dev->name);
+            return;
+        }
+    }
+}
+
 static int pcibus_num(PCIBus *bus)
 {
     if (pci_bus_is_root(bus)) {
@@ -2399,6 +2463,13 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
         is_default_rom = true;
     }
 
+    pci_check_fixed_bars(pci_dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        pci_qdev_unrealize(DEVICE(pci_dev));
+        return;
+    }
+
     pci_add_option_rom(pci_dev, is_default_rom, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index d0e4ad9820..8092634eb3 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -242,6 +242,8 @@ typedef struct {
  *    is not needed.
  * @numa_mem_supported:
  *    true if '--numa node.mem' option is supported and false otherwise
+ * @pci_fixed_bar_supported:
+ *    true if the machine supports fixed PCI BAR placement and false otherwise
  * @hotplug_allowed:
  *    If the hook is provided, then it'll be called for each device
  *    hotplug to check whether the device hotplug is allowed.  Return
@@ -317,6 +319,7 @@ struct MachineClass {
     bool ignore_boot_device_suffixes;
     bool nvdimm_supported;
     bool numa_mem_supported;
+    bool pci_fixed_bar_supported;
     bool auto_enable_numa;
     bool cpu_cluster_has_numa_boundary;
     SMPCompatProps smp_props;
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index 5cac6e1688..db4a003ae3 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -187,6 +187,13 @@ struct PCIDevice {
     uint32_t max_bounce_buffer_size;
 
     char *sriov_pf;
+
+    /*
+     * fixed_bar_addr[N] holds the guest address configured via the
+     * fixed-bar-N property for memory BAR N. PCI_BAR_UNMAPPED means
+     * the BAR's address is not fixed.
+     */
+    uint64_t fixed_bar_addr[PCI_NUM_REGIONS - 1];
 };
 
 static inline int pci_intx(PCIDevice *pci_dev)
-- 
2.34.1


