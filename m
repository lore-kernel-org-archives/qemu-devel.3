Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C03606A33D
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 22:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=P6B+J4lJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVcGG-0005Wt-8I; Mon, 23 Nov 2026 17:11:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1xVcGA-0005Vi-4P; Mon, 23 Nov 2026 17:11:38 -0500
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1xVcG6-0007D7-BN; Mon, 23 Nov 2026 17:11:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUHpEp3dCqqV0Mdva+e80rm2wRJeUb1/CS3acvB1pZiHrLAiB+705Hl3bYbU59KG+9gkYehFjW3ES6Hpp+ZsHASQ0B5YH5gcU6JDrdyG3hKqGBwVhRddWuDDcQ4pQJP8WtEHYuhTdwA+Atk/feP4TO8q5MVjkRlkkXsgFKJLnBNc3CWUIZSEiDCcMCEfcw6Sj1zZLiVX04r55HWHKGH0f/Hgu0cY7YtDqNO1eOs5as7nG5YGsmmUPDCW2ukHO+61WG4Zh8jPM5A1XdJcVIc8V/7st0x8cHX3EWumQoto2VWcgP3cCOSGO1tW0qAPbT6fjYasvuUjiTxfM1MBbjq+6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=co2kgF5qlTYL/ukv1JwRBhtYsNTLDtRkLedSogbyV6g=;
 b=i5j2DMT6dyyOKiuUG41MbQd6/sAWIbEAnGoKQlUzI1pWgFVQ9dh67B9eRkUexngghs/hNBVbIoX0MYpr7OdwIA6UVzq++P+acisbWYlwqB67mr+lBFM3zpdvi9l1SfCZzdkR+0YLiVyElxRPdP5cuYHicA3kkjMAXxk293Ij/akmUxISF55lBQuLPLUtOjIGej44X69j4IvscOQTPVLwvuzUKlMZJtMlZJ9DxBMAuxVwAXfsq0FgrkWGwsM6uyuhxAu4k80AwPm28uvxGKsdeggZM0hA7tckQPXMdDQc1WVhffvBaddNMcjfLfTPc8pHo66MyTShyGuzA0qXE7G9CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=co2kgF5qlTYL/ukv1JwRBhtYsNTLDtRkLedSogbyV6g=;
 b=P6B+J4lJO6NojPOsLmdZWp6vv/6uUrWAX05e63FwiRMlUFtMRh/5lHgfsUU5BRgDirgADnlQtAInecw5F1US6kTBq2QTA9P+TfgQsESrz+9En0til13lLQecTEmCkurdTCiB25+90BbJ8Z9OEr1o80pwbdiG3QOh20Ex4gz4hUBphXUVUiSyEPugv4Wj0lmq6gP0j159B0eB35m0KV/Raj1H2aBt0ASSbTnge5yRez1qFyeXruwIqJpKVU9yYTlQMgNxBkiWrA0UweggwVXVW5Vg+WH/lVwhzXFUlKaPiSSDTc5o+RBwMK6Wd2SpHw8KAXTewIocY9PTYX7lDx0N4w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by CY5PR12MB6551.namprd12.prod.outlook.com
 (2603:10b6:930:41::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Mon, 23 Nov
 2026 22:11:23 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 22:11:23 +0000
From: Tushar Dave <tdave@nvidia.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 marcel@redhat.com, devel@edk2.groups.io, alwilliamson@nvidia.com,
 jgg@nvidia.com, skolothumtho@nvidia.com, ardb@kernel.org,
 kraxel@redhat.com, clg@redhat.com, tdave@nvidia.com
Subject: [PATCH v3 1/5] hw/pci: introduce PCI fixed BAR properties
Date: Mon, 23 Nov 2026 16:11:01 -0600
Message-Id: <20261123221105.37029-2-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261123221105.37029-1-tdave@nvidia.com>
References: <20261123221105.37029-1-tdave@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0165.namprd04.prod.outlook.com
 (2603:10b6:806:125::20) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 937254f9-b682-44e3-65af-08df49aeb59a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|261026121527099003|261026140227099003|10067099003|11063799006|261102123227099003|261022105027099003|56012099006|261028144727099003|261022075727099003|261021121427099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: dYhicffuVi/zaG8SMt07qZM4Jv2+k1qRRNE9BFBOty/5tR1psruJhzAD/G9KLrYtWFFKE8e5it8YlgGTynuL7TZ9XT7xOtPwCREReIg+dqqI1hLe9lCBGmpOMIiui9GYa/URE4FIyL+MJga64Fl+QY5QrEvT7cCv8ImeXNtDbPA7m/E6LF4ZlzLJa59TB0rrAW77WanYfLqnZTNdZZ10JtyT/IuvHr0mrXqbURlZC8yDWvo0jlnOrGdM1RwbrN5YH/1o/VHL4oo3jEMQmLbMGpgs5RG7Lbh9cLrZHXKO1s3qLPEjJS3ttQOQ6ZUG3o/l0Tpx0dvBsoIP30r3FCi+NmDS/X2MCuoByPrvOVABGnmYnUr2TMzyEh9Cn71hLVCKsqlOkYgbimQtJ/KZx/gCUcPRo6IpIZ5ehJPs90KSOVR7EI3yN+oRb7W92DjQKWhuYHXrX2DNpBW5FSfNMaUhka0VbDq+UHP1AZ0dcvbNSRpuhHSM95UheiA4AdOmt2IX7ajX8C5raH5Sm6dPheZh1q9T0ROZLktaHJAlzNoNy5GcjRc65zDeI/OI9bec21L69C/4yCS9piENxDmaCo8qDNPkK7YFbFPuox7GiNVOl5zYBSdJuqwZlldCJTVhA5cUQzIMYqdrF+NV1g4oFZ5ld70G75ecFCqYJHhcVokZDBo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(261026121527099003)(261026140227099003)(10067099003)(11063799006)(261102123227099003)(261022105027099003)(56012099006)(261028144727099003)(261022075727099003)(261021121427099003)(261009223027099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vajv94YB8WR0I9vh+XyXKtI+URyv0bCXshoLEAAlFjgyb8wZfyRi/Lo/NmIa?=
 =?us-ascii?Q?KAPNdu7FsmGmJA8Op71vIDA9pdCAkVDz/rjbrcBaN/HHZIp+GUJDzo+eSQJ5?=
 =?us-ascii?Q?G9TtCbYWlTPwdTqw7A5cjBx+NYZ2TfP4RpjXQnxzJe43bgIfuapD/+uO35rs?=
 =?us-ascii?Q?mb99cteITz9wzMFpdijy/4ekdzvkmW6meDcm+1//Pt2/BMVqsdz7zF0eU/dz?=
 =?us-ascii?Q?3lElsZ56Tl/QfOV+LNQ90SoxrEdlDTYnUxEYa7uMQvpWaiaTr05RWhN/Vvuc?=
 =?us-ascii?Q?HGnXftQ8uTeRJyI4wdieCuJa8mcNKnBtu6UntlceqcMNVA22VGal/0DDkVh/?=
 =?us-ascii?Q?PT/vT3tqY0scHiCKcSmOIlql4DI9fQ2Q3h08DOs3C86qrSCetjPYn4AptZH0?=
 =?us-ascii?Q?8VgHqwk23BUXRHzRqoQHi94OHwO7i9AXchDMb5ci2iGWKg9wqbws0uuH7+Vi?=
 =?us-ascii?Q?BjQyjv30OzjqZMWEHjkpFJzezlvQT/FrdguqHciedV2IErEgE87lYRYNoazB?=
 =?us-ascii?Q?dSrcClYqXE0zo9MMXPBCkUYq9n52Q40Otk93yoZOTvjy18HyVWznL/CdEkjy?=
 =?us-ascii?Q?+HV4Y/3PUMYxBLG14MIsVJ+c5EcZre0h9OBDOp5qkzGtZKx+8IyxGbxBN5w5?=
 =?us-ascii?Q?xBBT3ZDaEUuNROoZaI4h3Lh1mNen0kr33qkNTrvSR73mxqUSY4XasGjIKRI5?=
 =?us-ascii?Q?x9+TWFU+M1izh55fP871YwB+PhLgsHli8TerSmz+Aw9xENozwVQFnFy84tY2?=
 =?us-ascii?Q?1FD6xjey7xCDczXCAiUF1L6a9HZ9xQre+c/BnZmzn0esqgZPnBfAuCbgb6sa?=
 =?us-ascii?Q?LJEwKk4XNxR8NWrvADsUau16ZY+x+o00WG4nuRXlde0N3hp05F4wXTftl53Y?=
 =?us-ascii?Q?jaHYGy2V92n/8i7zPdbVjHBBRdcfbMLWDI5O8C0IO0AP8vBkVE00lCvBk1G1?=
 =?us-ascii?Q?8usZerzaV6bcGZwwdjRXEFTUVo1wQSNY2SC3YrNGWjffoZ5Swg4y+QWGcFXU?=
 =?us-ascii?Q?8QH/dfFNs0lsMNzgrA6rC68uDsl2UtxaXEnAgm964S9nb6Wy8z2cKFNUO8nh?=
 =?us-ascii?Q?nLkEcwk/p/Pn/ayHk/xpuWTE0qtha0gYGeJ6gu2WqbrMd6F0DwFjTAulX+HZ?=
 =?us-ascii?Q?4ZinvKzMUF4KdXlt8iTRh4I4zOYwxZ6iEbB7GQR+Tz0ibN2GzhxzlV/OnW8Y?=
 =?us-ascii?Q?jMEWnJR2Qvz1vuI4ceuRlTzaEsfFBPSg7W8XJuwMvZ6tE+nxQc5iJ6nYlloF?=
 =?us-ascii?Q?+e2cQ0TE0z1/SfBCG329sHlJA5uq0CEmj9UwvDdE7Kne4Que1KsxDr1AbOtj?=
 =?us-ascii?Q?FLgvIrPG5LiI2jE/2UXNQNezGMGNuX+Wylb10xsr0oMAEtqA76oBQtuwr7Vc?=
 =?us-ascii?Q?WbECHk03xL0wrt3g4Dlt7wa6xlbOZdA9uLIDEEyXBEedu9HrJELwrbHMID0u?=
 =?us-ascii?Q?qai81Jn27bnJdVtJKh3N1TP6UbkBlr4biJcBUcPrDyrlfGjzM3FGrcq+RWtM?=
 =?us-ascii?Q?eGK1AzAh1aEC8/WZ82LAR3Gm1we4GvZQoH7Z0qOoUkknk+olo07qOH3yu26i?=
 =?us-ascii?Q?E5YiiHQyjWfHIA8ntLXolcAafz7wqLwhapDGeK/aDqxnyD06xZ2ebqoxSl8+?=
 =?us-ascii?Q?GEFERBAzn7TGtLz9hVmi0Z2r4xHCFKcOnU5QK7PdC7Frg3NSZYdFfchf0dzo?=
 =?us-ascii?Q?nnDMKhoEpLNwSBN8Z22WfuZH6F/GXdbj2pFjOJGL3I6RMgNV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 937254f9-b682-44e3-65af-08df49aeb59a
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 22:11:23.0701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pXBtd/YkXcGKxvZEH5YuQgUjaaiYrvU0wvgKXM2Tskt0z95O0tlXCaklCAF3cC+2WmiHjLsD5pZYr6KO1hVMog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551
Received-SPF: pass client-ip=2a01:111:f403:c105::7;
 envelope-from=tdave@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
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
index 57072590b1..8e6a3778ec 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -91,6 +91,18 @@ static const Property pci_props[] = {
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
@@ -230,6 +242,58 @@ static void pci_bus_unrealize(BusState *qbus)
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
@@ -2408,6 +2472,13 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
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


