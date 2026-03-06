Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE0FF0182B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 12:16:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyU6K-0007Si-42; Fri, 06 Mar 2026 07:16:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1vyU6D-0007MC-Cw
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 07:16:09 -0500
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1vyU6B-0008PE-1U
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 07:16:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U+eZ/fl+yuFpMIkANKZGncC11RSivNnYY600vkmAa/lytpEhqnm5VIf7wc/FTDgYZpGvq9lZxRAxZGl/N7ls1kINpFzHYNVAy7ZVuXDQymtEhF1goBa7ywkUzgO5U9gronXp98UvGrBdqTnK1HulOrOZoWW2MI7LfmwYENauQdh91QzOyk6+646clkWStdvIyui+gIi9x74fGvLmrv4e3sns8JoHwR5QQzWs+PbUTEG+IiwYmRNPUcrV3/AtAx3SOaHtaWcsh24HvcdBdUYPYjzSLmDuhUrChuI6bbTHvlPVQ83BdiiKJZw5AcIq9cQpyoot4KBVFTsJVMqGUI8z/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqamMI1Euk1BzPDOmezYGSMzxAW/2jSDoX9x7hsRPXE=;
 b=c5+ofvNNRJIjW5c3QzlODVzMF2kubvW/pF19hO5fcKhn8R9UODuPJzjaBMVE0ISSEms7BIJQfHsQg2swoDy+dC5nlj6VVx71x36ZHdGrcD3yRWBT7zcRfX0YrGris4V4wpbG+f7SExsr75PEyC86cIlCD4NBDWZIQ5Ev1fwZpMjzzBO2yz2WiHtNC+z+0Vw+gmDs4vMldzLm93b5vLa+Twv/dqXsoZ5VZGlenog31OfDgKgOZrKIBPgJcXS3/6Yqeb4vigaHkp4TeUlVBTlzTKPEyLkB+k9HuC1wUhL1xXADIegt3WxqHfh9y0INFKUlfv7Vip81njJs5wYH7gMMBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqamMI1Euk1BzPDOmezYGSMzxAW/2jSDoX9x7hsRPXE=;
 b=Enootx0JwQYqgnOzcztjagPNMcnidGPYhBFWJHnTrr814z2MzB28WuD2wh2DWuN3a99jLkmDlHeyylt/GHVmbq5Ti9KMtsS+vc2X3U4lRqAdLrstKnryZ4LF0Kjn3XHPIRAQqiKfveoS5OCltVOOv3Spbir9rq8GYmSN8JQBzRgDAddfONlXxF2JzEaAqi8dBj5vKruUSE99yNpPYsRhCVvEXwy4G2ePHzwyt+/hKvo7VQZtOYPldUW/o8U3aseuj1dc1e5X3ojxRmq91JuBLG3W8NHC5zudCkGG2CB7Mwb7nRKLievilQX0+R7tgiEGZEvY24V0/TOBUiVpALJcpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19)
 by IA2PR18MB5977.namprd18.prod.outlook.com (2603:10b6:208:4ba::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Fri, 6 Mar
 2026 12:15:27 +0000
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba]) by SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba%3]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 12:15:27 +0000
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v1 2/2] hw/arm: Add Axiado EVK board
Date: Fri,  6 Mar 2026 04:15:11 -0800
Message-Id: <20260306121511.1781020-3-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260306121511.1781020-1-kchiu@axiado.com>
References: <20260306121511.1781020-1-kchiu@axiado.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH5P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::13) To SJ0PR18MB4479.namprd18.prod.outlook.com
 (2603:10b6:a03:37f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR18MB4479:EE_|IA2PR18MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b2632a1-4a8f-4565-a67a-08de7b7a0d60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014|13003099007; 
X-Microsoft-Antispam-Message-Info: aIbteRHlpyjVrRnuFVnc68PbMxVeCJlnkA9eMojq47YzngDXoxkpe7iLyEwCaz2pN3VWLffnZiJQdDztWCEHSKik+TLMlExscLeensmYiaIEz/S0xQM1QfEsVPr+kI7v3vpDjcGTfr+JrC7fXS52828dUb4EaBXouSwWhNTtzLYac9u2XA+cjwuMVhnjxntV/0GUIGJWCj09j3TNHyBkKmlg9aTrdfKw7jH+94nmk+Pj5LEIFeWb0+m3Szz7JAm69IzkNFrYVRou39TY3DhcYMbjCamBC7j8lr+PNo6a+ue+X+0bkh3hd3N1+YTVwv3HiZDPqoDpkQbG9lG8vPoawWaNUOzkGXtukBKjaWBpHlRVk4dAKn35Jg/Qy/pa8/0O3+O0503mG3Oxs6rN4MHVylt9Iqf3UIeYxN7/JUaAOyGaJcz3diWlBz4dCuGOkVJ6JsrX1D5SSH6D19kfAVeA7XM5GQRI1RZb6voKMiOdHRFy8w25jjD7F/6NotB2lVxoD6a29/bYliB4u8c89fQiI0nj7Ns8gKpmzl2l2SvzQk7prBdVGZCjdE1+ymaEUF9U4KNbevZCmNfGiuKdqmLM/X1xglnXGKOBtqg0UMQ9jkgZeON6v+xixVZprFr7PepmAx3q+J6lghQ5tu7MpN+P+ZtOMVf8cAQTZ1vymTqoVVTo5sJlAz9iTBgwrJuVBMcw5VsG0MmIfAYDg3CkcUX53LVVZFz1TrUhMnmAKMlcEH1FdYehSh4iA8hW5zlHMeITxXahCV5fPllHSyqRddHnkdmlvTJn8EnCFc2tGqaTZso=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4479.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(13003099007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?miC1MiiTcG04VhhmeulHFG+ipmnWnT67TP9a9WiE2z5fHYbBPbXkLorsbQwV?=
 =?us-ascii?Q?nM1bczdffOsSuwTVKUAxZDCpyxYka9SAoLMjDw7YqO7QBFTVY5T+lwido6kw?=
 =?us-ascii?Q?ypwJwfbqCY6fp2JcOt/m11a6/UquKyxw7JbdUh/YgIQl/5ZqUm47EZA+KL78?=
 =?us-ascii?Q?oUiN/x+8eyVH48l4xeNY53qFDcrvkIUFGWf6proGdBJs+fbEAkE3xgrUQ5rY?=
 =?us-ascii?Q?CAL8BgeFni10uuEGY5fV41ZKZ0Hj0x9As9YNEavTwrXeIgPBNPwkVSfdJa0+?=
 =?us-ascii?Q?KEfXBf9ALRY80pnu6+a6XGguEKeSt+EAmGt8zSPrYEpnWQIZknyFVd+c25Fw?=
 =?us-ascii?Q?a66WTyl64sPsgdO78Vr1urxVGK1GfS8j3u+n/GoHgiQddh0vCErPjS4wzglc?=
 =?us-ascii?Q?qrP6gFo3gVrOLfYIJy08T50bm1OiW66Ucgb1KJIxzm0c4kbq5S+q+5AWvXWx?=
 =?us-ascii?Q?LuCYssX2ofbIFhnUuzXwGMFXBQXlyGF+4mEUZOO7Ph7pMs3qhsIoKOwfCCCg?=
 =?us-ascii?Q?bZ4JYMUlI9QBoqSXwJFeAFCYx/2ihYnpHfRpTnM//kRYpNLWX1pY41qIBt2/?=
 =?us-ascii?Q?ZSR/5ZCfft14Y93bSu/M6Uz+AMovb0s+BieE1f0DEwzBrBJLaoU8T/9obm+w?=
 =?us-ascii?Q?mgraYrMjOuN7Nu9wNw++UkUMKSfgixeSinoqAkwAGhaCYzbf4tIn37kpLXKV?=
 =?us-ascii?Q?32/Q0DjbD9Lvp0vSlAMCR6g07lM5Kitt3a00ngZkm9B7XinVWA9daJYoA2/f?=
 =?us-ascii?Q?9Ybp4rgNgdfjMOjyznOmI9Axmn0dXAtasd2QS/dpO/dXKvVwwkoBW9DBbT6x?=
 =?us-ascii?Q?SJYE7dmiGR3SYSIpReRR/f26gSHo07dpGBBa5Agv2n7MrIdhr780pPGrEhH4?=
 =?us-ascii?Q?w3nMBlHyV57DLLgCGG+/ebFpeEr3cAurZdRBczHq7/iEGUCMVGVWNFFpfIRy?=
 =?us-ascii?Q?FjxCEVE4MTdmeLhh94RoLwMpMCTpB2cMiF7SsbPcu8QNysauUWLl6DdO/E4W?=
 =?us-ascii?Q?7RbOE89yPyk06k/mzP05MtKW7lHBPMsjBS6cz6nXJpWW+WzPrRPISgwE965R?=
 =?us-ascii?Q?705/nwFSdCFhF22HbVDUnlOShYvhVoCbpPCV4xvDvqDORxTRa2g2I3MUDHee?=
 =?us-ascii?Q?QsJMgPx7/JVB1dDmoIo4EJ0Ro7lSsYMPKlsrtamZfNhRlal/NKb6UcdT7Agt?=
 =?us-ascii?Q?5jLe/0SfX9ywz2xJHjWMD8C/2zsuW7Efiilf9c8a7dLEgCU+wtS3unQOf+DE?=
 =?us-ascii?Q?6DDkOBIHZJWmTmag1ZAGINYcofdwY6YiueyEZzPb3AonE34DvC59a1Gb08Py?=
 =?us-ascii?Q?DzaO2lCdl+FYY7OvPv3rmKadx1Gx9lb2rlY9HEqVR0luxuQTcumOLpQayO9A?=
 =?us-ascii?Q?x1/Clapusy7/C1YMtLJURgI2eRBAKAgtE8+bVIM0P3ZR3aXZGmfvacokt6xX?=
 =?us-ascii?Q?JnRYqxAJlI8MrECXyI3u9IoKq8kmCyCC+2G51ki/pmClRyP4xP7IOc0/P4SR?=
 =?us-ascii?Q?pR+4Wo/F9tA5c7GafMm6KkqScghBIQ266hQl7Y0a7ieJcYdWpyqA67wMR0Ux?=
 =?us-ascii?Q?pcT4nv3Nsw/LCWvLRk+tuu70AajR20KyNGFFexvZEmMbee40qYCNv+GAUxoH?=
 =?us-ascii?Q?9Va4LmJ57LC7oXyheSgN3z60flr1sm3zHoaxFCbEJVg8SG9w/+Vi1WJGAPGq?=
 =?us-ascii?Q?6aOnMs1n4ldWgavZnuYI/qUrKMlfd/LDvplyjUOlg6nSsBswv1D5rQXTcJUm?=
 =?us-ascii?Q?V0kj+XFGKg=3D=3D?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b2632a1-4a8f-4565-a67a-08de7b7a0d60
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4479.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 12:15:27.5141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MvDFXMdwQp6xdZiUmf6w9ll3sBNQ9AqkZMkEEW26Q8kEj94s7ygdvxfCEoCChJtgAk2G0w8n0dETkD9sy+NMsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR18MB5977
Received-SPF: pass client-ip=2a01:111:f403:c105::7;
 envelope-from=kchiu@axiado.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch adds a new model for Axiado SCM3003 EVK with Axiado SoC AX3000

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 hw/arm/axiado-boards.c         | 78 ++++++++++++++++++++++++++++++++++
 hw/arm/axiado-evk.c            | 38 +++++++++++++++++
 hw/arm/meson.build             |  4 +-
 include/hw/arm/axiado-boards.h | 41 ++++++++++++++++++
 4 files changed, 160 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/axiado-boards.c
 create mode 100644 hw/arm/axiado-evk.c
 create mode 100644 include/hw/arm/axiado-boards.h

diff --git a/hw/arm/axiado-boards.c b/hw/arm/axiado-boards.c
new file mode 100644
index 0000000000..802d2e5665
--- /dev/null
+++ b/hw/arm/axiado-boards.c
@@ -0,0 +1,78 @@
+/*
+ * Axiado Boards
+ *
+ * Author: Kuan-Jui Chiu <kchiu@axiado.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 or
+ * (at your option) version 3 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/arm/axiado-boards.h"
+#include "hw/arm/machines-qom.h"
+#include "qemu/error-report.h"
+#include "qom/object.h"
+
+static void axiado_machine_init(MachineState *machine)
+{
+    AxiadoMachineState *ams = AXIADO_MACHINE(machine);
+    AxiadoMachineClass *amc = AXIADO_MACHINE_GET_CLASS(machine);
+
+    if (machine->ram_size > AX3000_RAM_SIZE_MAX) {
+        error_report("RAM size " RAM_ADDR_FMT " above max supported (%08" PRIx64 ")",
+                     machine->ram_size, AX3000_RAM_SIZE_MAX);
+        exit(1);
+    }
+
+    ams->soc = AXIADO_SOC(object_new(amc->soc_type));
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(ams->soc));
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(ams->soc), &error_fatal);
+
+    DeviceState *card = qdev_new(TYPE_SD_CARD);
+    DriveInfo *di = drive_get(IF_SD, 0, 0);
+    qdev_prop_set_drive_err(card, "drive", blk_by_legacy_dinfo(di), &error_fatal);
+    qdev_realize_and_unref(card, qdev_get_child_bus(DEVICE(&ams->soc->sdhci0),
+                           "sd-bus"), &error_fatal);
+}
+
+static const char *axiado_machine_get_default_cpu_type(const MachineState *ms)
+{
+    return ARM_CPU_TYPE_NAME("cortex-a53");
+}
+
+static void axiado_machine_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AxiadoMachineClass *amc = AXIADO_MACHINE_CLASS(oc);
+
+    mc->init = axiado_machine_init;
+    mc->default_cpus = AX3000_NUM_CPUS;
+    mc->min_cpus = AX3000_NUM_CPUS;
+    mc->max_cpus = AX3000_NUM_CPUS;
+    mc->get_default_cpu_type = axiado_machine_get_default_cpu_type;
+    amc->soc_type = TYPE_AXIADO_SOC;
+}
+
+static const TypeInfo axiado_machine_types[] = {
+    {
+        .name          = TYPE_AXIADO_MACHINE,
+        .parent        = TYPE_MACHINE,
+        .instance_size = sizeof(AxiadoMachineState),
+        .class_size    = sizeof(AxiadoMachineClass),
+        .class_init    = axiado_machine_class_init,
+        .interfaces    = aarch64_machine_interfaces,
+        .abstract      = true,
+    }
+};
+
+DEFINE_TYPES(axiado_machine_types)
diff --git a/hw/arm/axiado-evk.c b/hw/arm/axiado-evk.c
new file mode 100644
index 0000000000..ddfb68d5c0
--- /dev/null
+++ b/hw/arm/axiado-evk.c
@@ -0,0 +1,38 @@
+/*
+ * Axiado Evaluation Kit Emulation
+ *
+ * Author: Kuan-Jui Chiu <kchiu@axiado.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 or
+ * (at your option) version 3 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/arm/axiado-boards.h"
+
+static void axiado_scm3003_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "Axiado SCM3003 EVK Board";
+}
+
+static const TypeInfo axiado_evk_types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("axiado-scm3003"),
+        .parent        = TYPE_AXIADO_MACHINE,
+        .class_init    = axiado_scm3003_class_init,
+    }
+};
+
+DEFINE_TYPES(axiado_evk_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index c3c96c0a70..993a95d33a 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -106,7 +106,9 @@ arm_common_ss.add(when: 'CONFIG_SX1', if_true: files('omap_sx1.c'))
 arm_common_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
 arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
 arm_common_ss.add(when: ['CONFIG_AXIADO_SOC', 'TARGET_AARCH64'], if_true: files(
-  'axiado-soc.c'))
+  'axiado-soc.c',
+  'axiado-boards.c',
+  'axiado-evk.c'))
 
 arm_common_ss.add(files('boot.c'))
 
diff --git a/include/hw/arm/axiado-boards.h b/include/hw/arm/axiado-boards.h
new file mode 100644
index 0000000000..f17d513572
--- /dev/null
+++ b/include/hw/arm/axiado-boards.h
@@ -0,0 +1,41 @@
+/*
+ * Axiado Boards
+ *
+ * Author: Kuan-Jui Chiu <kchiu@axiado.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 or
+ * (at your option) version 3 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef AXIADO_BOARD_H
+#define AXIADO_BOARD_H
+
+#include "hw/core/boards.h"
+#include "hw/arm/axiado-soc.h"
+
+#define TYPE_AXIADO_MACHINE       MACHINE_TYPE_NAME("axiado")
+OBJECT_DECLARE_TYPE(AxiadoMachineState, AxiadoMachineClass, AXIADO_MACHINE)
+
+typedef struct AxiadoMachineState {
+    MachineState parent;
+
+    AxiadoSoCState *soc;
+} AxiadoMachineState;
+
+typedef struct AxiadoMachineClass {
+    MachineClass parent;
+
+    const char *soc_type;
+} AxiadoMachineClass;
+
+#endif
-- 
2.34.1


