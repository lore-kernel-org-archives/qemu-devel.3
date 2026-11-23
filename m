Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23333606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 22:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NxRQOwoc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVcdi-0004og-NK; Mon, 23 Nov 2026 17:35:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1xVcdZ-0004nI-20; Mon, 23 Nov 2026 17:35:49 -0500
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1xVcdX-0004BV-0G; Mon, 23 Nov 2026 17:35:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aq/9Gq5W300WDFXuU4k6JiZhbfaVynPanHfTYKSado5lWaJtCuUQV5eFo5ItLiCxdP0sAnuUasL3iCMJY3MaghDLjfPAfgIEBIk3lAMAalOilUnKsIG0G7TNZlHzfKPo9InKwYcDLTJeMxSCvLjuN6r7rM/0HZjzki5jcwBIyf8S1JVAdMkD8qB4/o+3PQF7Jp+d3XIcd8/wUagFs5X6vOMe3LXrnVdgSewFWwqq3LTqzMUDEPL7SPPhKPlV/noOIoKqTYgL3x9sxahDWkiUQHAveZ0YAuaeLxJv2yQdB9z9tx3nD+EKg2kfML6nYHUOfQ6F2oYXVxeJSNWIBLck2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGnByXuOEIp58duUE8fnlTjfo3iGNV37CAfUhf8t4jM=;
 b=XLSYJ+jKuZBBVdnZCUAr9Tjv4eEj984EWeBj6ssXBwzUfu/VdFl6c1CjTvssKB5QnQVUmq5OhMh9eda6okVqDC0eIrQhgPB+oAiacMfWRRoMLlm651D2i7WkyA70bdtvztiUXMbEbrwx4onFEVWDPwtiGH/xl4Z1Q1SIPjYmGgX2sOBocmg4S2cEgSVX/oSydHtgyhvvJGeMSicLf8ALvStoy3TRqAr170Nyx0PuaHz9TM6u9SGCNF/ERWtd2tCm2gT+mCU35c7R2Mw+dsf4Ut3+hl2SJ4KUulLW/8Qy3plbl4n5rr1S+83+u6gwwPciV0Y2u1en5Qz//sUwtCK7Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGnByXuOEIp58duUE8fnlTjfo3iGNV37CAfUhf8t4jM=;
 b=NxRQOwocPCQoGXTQxq8I1odnSPnyF7i6VICNEYakr8sx8Yv6NTuqswaB09NTLwkMrZPuNFQdintXHgHUfnU606eD0rydZoabrrhpYAOQ7fTuJDcs013Oes9D9k8IEVIZq2XdT30AUmDhbj4ZL8jpiztulmyrajQUarEkfRu3frSQ26h2gN3zYdbImELvqmI7Xfx0X/IxyDiiBTKtM2OL+v6sLBs1GT2q9nVaJgKoeXh0+ePa/wIO/ShyTApQt5jTpyYk7Bay8uSL81o4dIAu0Jve2QP0KZsKMPGDgRAjJW2i99J3FYpFM9t18Z/pdJ0mItNgnTRwTIksWfsin/5MNQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by CY8PR12MB7562.namprd12.prod.outlook.com
 (2603:10b6:930:95::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 22:35:34 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 22:35:34 +0000
From: Tushar Dave <tdave@nvidia.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 marcel@redhat.com, alwilliamson@nvidia.com, jgg@nvidia.com,
 skolothumtho@nvidia.com, tdave@nvidia.com
Subject: [PATCH] hw/pci: Add acs-ctrl property for root and downstream ports
Date: Mon, 23 Nov 2026 16:35:23 -0600
Message-Id: <20261123223523.47719-1-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0042.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::17) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|CY8PR12MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c842b1b-9a93-4351-94ad-08df49b216ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|56012099006|261021123027099003|11063799006|261102123227099003|261021121427099003|261026121527099003|261009223027099003|261009221227099003|10067099003;
X-Microsoft-Antispam-Message-Info: NT+fKXzpCkTiMm+BfOr7RDYFNiJmxR4VdWlEeDFNJOiwJA9szkU2Ieri3obmSidSwcr0EtG1q6Ds0LT7C6m1+WHkiGNDfT1tXHyFzoGP5OR1lcKDA8jmgOAcBQy3ixcQEx+RpwhT9F2KAC4B1Ai/tvcYfvVio7RCXj2iOklZWOiP7YR08agCW4GjJq3vTqhBUHDRGv+GLXgWgJMA3IfAPqLy/d6qUH3H3OmbHB18QgxTkFbfbtVGT1iHnlw5CXlt4raH9brc5og2YC9ZtDBgEjvfC5vxM3h5nEqxK9f4marhWoI6udbuH+KGw9M6mEoIHj0O/19TM5thNpCfxce0+cpBtEh7xz3MQjXcKyEuI4XysH0mwJ7HD7jCG3/msnhk5ehaAiUKreJxwozn+ejO39ga2qAF/R/jVgUf8jM1iq9Fr2fYuAUpUJrRbHoQtBEIyRYAAdV9RsSFSIZ93fBuDykQcLQ2WAWyoeuKJFk62KlJ264WfcJmlESjkLilEaXgQq8b+wZbwy0mtvbUrtYKJcuGR4LkPpPJp+knTwVm8nr7n6Ipg6j6ncdluf1ovo7dWquNQnreba5fWwHkCjeCC0XkjxhE8n3KU62gnj3pWl4XNYxEHnkFs0rbnM4BHw27
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(56012099006)(261021123027099003)(11063799006)(261102123227099003)(261021121427099003)(261026121527099003)(261009223027099003)(261009221227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6nCgiSYPHWPOvCAkUOSeWZo8zxfy35cVvds4nVWIazrE2+hEJliWeE9fYYv/?=
 =?us-ascii?Q?Bx2SKxT9qh5qMjVdbUQIQzBnXy1w5M4noDRUJkquOzQ49oeypqmcPaN0HJDe?=
 =?us-ascii?Q?rP+VfDcMuf44NRojzfMAEpuyKaKv+ZGSYpeSygGR+WVaQinA4vzdY0jV2LRT?=
 =?us-ascii?Q?e4aotX0i7GsAbnRnPAfib/uHeqZ2OEvzUdZ6EEaa8mtD6XM/LkHLffgTjIwM?=
 =?us-ascii?Q?W6P8APPGld8PtWg/VL933DvubiJhZi1AlcnQqN7mX5JCnB2wd23H0Vre/uzt?=
 =?us-ascii?Q?rO2p8Y+mugHrOs1aZHcLmSJNNGCZH6YnWnX7zmPoGcXMg0mszjvkvkfhytLO?=
 =?us-ascii?Q?HLlHFTUlu9C6LfEhp0Erqz6h6CAAGYsLz04slwWphMBSlrwzGQiO2odP4j6X?=
 =?us-ascii?Q?lIzXky1JHE3obHoN3uDHnb9wROGz4ZskBaRvYaOgCpn2mzIsoHb3t+MtRNbW?=
 =?us-ascii?Q?cZK0uQP56xkMmPwLxU9FWzRB5UjHj3ApaEnjl9EO65TZxMkmWFMjBwsuDjmk?=
 =?us-ascii?Q?0Xr9MOBUiPK/tcMiN3Qpf9XkJUO9b13mdbql4XL+02C2aUx3rrrdOrzd8YUk?=
 =?us-ascii?Q?MNFJkDfZWHy5ruoqFdrSw2VJ2pBykVi0D4kzl19TiInpMVooUo0c1rW3ojdp?=
 =?us-ascii?Q?4QyiliNanWmcvKHgwTNAVwWSXJdcVp4JjHB9cD5NMTdzeNIO9mQTnkYmx/Pg?=
 =?us-ascii?Q?nncg5WTL+I48Y0o6DuwPQLP7yYYD5gKAXUX4OB6NCH3Z3WgE2YiDdwD9WJsL?=
 =?us-ascii?Q?D10KbH3BW46QwKr4VpC5Pju2+LSY8ngjYitB2c7ltqBAhUBWneE4mjWljv+8?=
 =?us-ascii?Q?PY/CWJ4S2bQuisNolqBuymKkmpY5ImBa5Gyh86vQ3357XgGxffjRf4miLe1P?=
 =?us-ascii?Q?vt33qwq+Kjc6Bw3387hy9UT+8TaefyImAzG85EZl1Bz0p0icItu/x/c0PTgW?=
 =?us-ascii?Q?EszdBPm9FkyTXdBPeGrT9mIW+4IyxSxTkd6YSL6RAk6wsI7jVhYqBNoZut7p?=
 =?us-ascii?Q?iECBuKuo2vjvBnZJeJyMgdqCUHr6JDTRqFi4UyE7s+S8Yx0OxEuSxNSKnvJL?=
 =?us-ascii?Q?dMeMVDoRutn27O0pMHh6bP2bfz1cwkx4lxK1z1/GYFeRQc+vAILUeGOE5erg?=
 =?us-ascii?Q?CFdO2MiDXSHFyKDUui0NAvUwSPQEW4eXOGjCRMohYruFZfOM61a9nGlWNkXh?=
 =?us-ascii?Q?2CxLXw2h+hb9ZOSnb+U64+oRNOxjHvwDu0oOLs5Z60/gnjcjFqY1dguRMA/l?=
 =?us-ascii?Q?XiBfZORSe3iNlLyxovTDgbfrSjNeRtix0b5MJs1hDRKOt1aO8/M3ngWEf5mt?=
 =?us-ascii?Q?rmyAHsIIC+yXYVdamqj0k119F9VEimmqgKsME1K2qZBsIZiW3o2Sypa9QIaX?=
 =?us-ascii?Q?QSz3HubRgc7tKPHtEAcxhvsDsvTBogDzmuoP+Gy528QWbVHq2Y0ST55GVnzJ?=
 =?us-ascii?Q?mUFDP7lpmsWpu/1wX/93IkR45yRK7zwSlnSzovbTjQcc8njlgaWsEOrHpgQA?=
 =?us-ascii?Q?mAG6UtUE/mlsSWWArMNDE7ozubGSqhIIcquRBCeS+F6uD8Lt4I/ua799M2bN?=
 =?us-ascii?Q?QyIjLei2Ij2jNa5HKauJNbjxCKYwigNoVvrw3QyjywS9qRjujJn6zJM0mQpV?=
 =?us-ascii?Q?tm1ps+2j3iQsav/BrlOzucek6H/vFrN/2ri4LnBGdsTjyJegGb8C8ZS1mBqy?=
 =?us-ascii?Q?R3ud++cZHnu0S9bCbSr1B8s9qbPK7M55e4qOvNDL3uZh0cEU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c842b1b-9a93-4351-94ad-08df49b216ec
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 22:35:34.8229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4dedoduQXt3enPzzdjLtRZknsVGu2Ely5ThOufaBdCYs5j5vOv+oVUTY3ZGDgIEYrLHebgN2mauwYWgHDS9DiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7562
Received-SPF: pass client-ip=2a01:111:f403:c110::1;
 envelope-from=tdave@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
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

For P2P to work between devices assigned to a guest, the ACS Control
register that the guest sees must match the ACS routing that the host
administrator configured. A mismatch can prevent P2P between the
devices from working as expected.

Add an acs-ctrl property to the generic PCIe root port and the generic
PCIe downstream port, so that the administrator can configure the ACS
Control register.

Signed-off-by: Tushar Dave <tdave@nvidia.com>
---
This replaces my earlier ACS series:
https://lore.kernel.org/qemu-devel/20261006013133.3457555-1-tdave@nvidia.com/

The patch that made ACS Control read-only for the guest is dropped,
along with the patch that adds acs-ctrl for x3130/xio3130. Instead,
acs-ctrl is added for the generic root port and the generic downstream
port.


 hw/pci-bridge/gen_pcie_downstream_port.c | 11 ++++++++++-
 hw/pci-bridge/pcie_root_port.c           | 13 +++++++++++--
 hw/pci/pcie.c                            | 17 ++++++++++++++---
 include/hw/pci/pcie.h                    |  5 +++--
 include/hw/pci/pcie_port.h               |  1 +
 5 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/hw/pci-bridge/gen_pcie_downstream_port.c b/hw/pci-bridge/gen_pcie_downstream_port.c
index 3084a208a8..e5d1f642ba 100644
--- a/hw/pci-bridge/gen_pcie_downstream_port.c
+++ b/hw/pci-bridge/gen_pcie_downstream_port.c
@@ -72,10 +72,12 @@ static void gen_downstream_write_config(PCIDevice *d, uint32_t address,
 static void gen_downstream_reset(DeviceState *qdev)
 {
     PCIDevice *d = PCI_DEVICE(qdev);
+    PCIEPort *p = PCIE_PORT(d);
 
     pcie_cap_deverr_reset(d);
     pcie_cap_slot_reset(d);
     pcie_cap_arifwd_reset(d);
+    pcie_acs_reset(d, p->acs_ctrl);
     pci_bridge_reset(qdev);
 }
 
@@ -115,10 +117,16 @@ static void gen_downstream_realize(PCIDevice *d, Error **errp)
         goto err_chassis;
     }
 
-    pcie_acs_init(d, GEN_PCIE_DOWNSTREAM_PORT_ACS_OFFSET);
+    rc = pcie_acs_init(d, GEN_PCIE_DOWNSTREAM_PORT_ACS_OFFSET, p->acs_ctrl,
+                       errp);
+    if (rc < 0) {
+        goto err_aer;
+    }
 
     return;
 
+err_aer:
+    pcie_aer_exit(d);
 err_chassis:
     pcie_chassis_del_slot(s);
 err_cap:
@@ -163,6 +171,7 @@ static const Property gen_pcie_downstream_port_props[] = {
                                 speed, PCIE_LINK_SPEED_64),
     DEFINE_PROP_PCIE_LINK_WIDTH("width", PCIESlot,
                                 width, PCIE_LINK_WIDTH_32),
+    DEFINE_PROP_UINT16("acs-ctrl", PCIEPort, acs_ctrl, 0),
 };
 
 static void gen_pcie_downstream_port_class_init(ObjectClass *klass,
diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index 7c3e78010b..e7cce8c0ee 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -46,6 +46,7 @@ static void rp_write_config(PCIDevice *d, uint32_t address,
 static void rp_reset_hold(Object *obj, ResetType type)
 {
     PCIDevice *d = PCI_DEVICE(obj);
+    PCIEPort *p = PCIE_PORT(d);
     DeviceState *qdev = DEVICE(obj);
 
     rp_aer_vector_update(d);
@@ -53,7 +54,7 @@ static void rp_reset_hold(Object *obj, ResetType type)
     pcie_cap_deverr_reset(d);
     pcie_cap_slot_reset(d);
     pcie_cap_arifwd_reset(d);
-    pcie_acs_reset(d);
+    pcie_acs_reset(d, p->acs_ctrl);
     pcie_aer_root_reset(d);
     pci_bridge_reset(qdev);
     pci_bridge_disable_base_limit(d);
@@ -118,11 +119,18 @@ static void rp_realize(PCIDevice *d, Error **errp)
     rp_aer_vector_update(d);
 
     if (rpc->acs_offset) {
-        pcie_acs_init(d, rpc->acs_offset);
+        rc = pcie_acs_init(d, rpc->acs_offset, p->acs_ctrl, errp);
+        if (rc < 0) {
+            goto err;
+        }
+    } else if (p->acs_ctrl) {
+        error_setg(errp, "acs-ctrl is not supported by this root port");
+        goto err;
     }
     return;
 
 err:
+    pcie_aer_exit(d);
     pcie_chassis_del_slot(s);
 err_pcie_cap:
     pcie_cap_exit(d);
@@ -151,6 +159,7 @@ static void rp_exit(PCIDevice *d)
 static const Property rp_props[] = {
     DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
                     QEMU_PCIE_SLTCAP_PCP_BITNR, true),
+    DEFINE_PROP_UINT16("acs-ctrl", PCIEPort, acs_ctrl, 0),
 };
 
 static void rp_instance_post_init(Object *obj)
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index bd00305ecc..57dd873eb9 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1278,7 +1278,8 @@ void pcie_ats_init(PCIDevice *dev, uint16_t offset, bool aligned)
 }
 
 /* ACS (Access Control Services) */
-void pcie_acs_init(PCIDevice *dev, uint16_t offset)
+int pcie_acs_init(PCIDevice *dev, uint16_t offset, uint16_t ctrl_bits,
+                  Error **errp)
 {
     bool is_downstream = pci_is_express_downstream_port(dev);
     uint16_t cap_bits = 0;
@@ -1302,16 +1303,26 @@ void pcie_acs_init(PCIDevice *dev, uint16_t offset)
          */
         cap_bits = PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR |
             PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT;
+
+        if (ctrl_bits & ~cap_bits) {
+            error_setg(errp,
+                       "acs-ctrl 0x%hx has bits not supported by this port "
+                       "(supported: 0x%hx)", ctrl_bits, cap_bits);
+            return -EINVAL;
+        }
     }
 
     pci_set_word(dev->config + offset + PCI_ACS_CAP, cap_bits);
     pci_set_word(dev->wmask + offset + PCI_ACS_CTRL, cap_bits);
+    pci_set_word(dev->config + offset + PCI_ACS_CTRL, ctrl_bits);
+
+    return 0;
 }
 
-void pcie_acs_reset(PCIDevice *dev)
+void pcie_acs_reset(PCIDevice *dev, uint16_t val)
 {
     if (dev->exp.acs_cap) {
-        pci_set_word(dev->config + dev->exp.acs_cap + PCI_ACS_CTRL, 0);
+        pci_set_word(dev->config + dev->exp.acs_cap + PCI_ACS_CTRL, val);
     }
 }
 
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index ec25e7a7de..678ad73f7f 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -137,8 +137,9 @@ bool pcie_insert_capability(PCIDevice *dev, uint16_t cap_id, uint8_t cap_ver,
                             uint16_t offset, uint16_t size);
 void pcie_sync_bridge_lnk(PCIDevice *dev);
 
-void pcie_acs_init(PCIDevice *dev, uint16_t offset);
-void pcie_acs_reset(PCIDevice *dev);
+int pcie_acs_init(PCIDevice *dev, uint16_t offset, uint16_t ctrl_bits,
+                  Error **errp);
+void pcie_acs_reset(PCIDevice *dev, uint16_t val);
 
 void pcie_ari_init(PCIDevice *dev, uint16_t offset);
 void pcie_dev_ser_num_init(PCIDevice *dev, uint16_t offset, uint64_t ser_num);
diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
index b28af067a6..2ad9a563d9 100644
--- a/include/hw/pci/pcie_port.h
+++ b/include/hw/pci/pcie_port.h
@@ -36,6 +36,7 @@ struct PCIEPort {
 
     /* pci express switch port */
     uint8_t     port;
+    uint16_t    acs_ctrl;
 };
 
 void pcie_port_init_reg(PCIDevice *d);
-- 
2.34.1


