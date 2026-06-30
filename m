Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82295C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 13:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weYye-00020Y-N1; Tue, 30 Jun 2026 09:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1weYyb-0001zp-Cj; Tue, 30 Jun 2026 09:58:13 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1weYyZ-0003om-JZ; Tue, 30 Jun 2026 09:58:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V82lJY92TQpYfOd9InG87QPchhE1WWAb7Gxvn56B815NRAwLOuHC6GtESk6cbDSRMxinP2SVOynqScmfRahVtRJ8HGt8mjbj/FBnvhds/XGmYGemLGeZbJoscDEwt9Flzron7S2LNYs09jYi6bx5W1T4DYQi3AFXXxX7VpnvWrP8Ux3uZjL0W4U1NnD5Mx1cfNEv6rm6D7TGZsDm4dv3gpZtR81lvrmjjXzjFsxWOrOnukLEpvf3pxyAGXr2mjiAj4l6kJHlglP1Xlq3oNXNgHbSy/kgGewUS/Xv91vnkyX44OSgWuK0RbFOy/M4h3Gm+CIVB6fsiTwDcEqRmt7ytw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLsSlafMQoxO5KBYnsvhQrjJj3NvaFSO8CQRi3ObJzo=;
 b=K9zGgYD8fI8GM1CJMuX1tlpL4eo77bOySc529DHpKsSzGjlBwjuFhkJtSajLazc2Qr1FPyiCAHx/75Wcdamn8kZXtOZQEGnFdaPxn9m/sSdWUEZ7bNG1rWsE/hAKrXudJhKhMUwg6VL37SC8wAQjw7mkrl/VAJBpEfg2JeigY9nJRJ7CZIhqczcSoDmY+j8P3+iRMF4ocktqF3qwxKm9Df+/Kf+lrSDd6RRfQmPn3CtoRQU3jRAaYsDmiX3aZ9v+SCweNU03QIJUJp54ltWkefmp/eX3wSackoDK1XOWjSUox8W5xhP5bkVQuzhUDp3gCg24AZ1R6Ov0+202Ab5rBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLsSlafMQoxO5KBYnsvhQrjJj3NvaFSO8CQRi3ObJzo=;
 b=gNHKCGtfFWvJApsKcTuYjN/HRzzdV+R+1xcimL9oP28FNyyJ0EGPndWwtY+ZaAZSncqyiVx0jL1YpWEz2JZTXqMcXDRE9LnudjXrTmGrLCW5B4tKUicQuvRQbPHYM/cgRj3EvPS+tM9hYO3qklfco+W+GjjATxxTPSVvJw5XMZ0L/a1hg/uOMNtpKIANxqFJL7WFMxaxVJLRKShMr9jckcyc7m+aG674fehQEOshOjYLseWwmAfp3+qK272I8p3HxHIkNTqjGqZex+nA678C7W25/KkEUicRtASpQ7jPBX4bfxYp6HYSX4RgpZx94sEuN9f7RLpess1n5sYKVyBr7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYPPR02MB8959.apcprd02.prod.outlook.com (2603:1096:405:382::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 13:58:01 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 13:58:01 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH 02/10] hw/block: m25p80: Fix dummy byte handling for
 Numonyx/Micron flash
Date: Tue, 30 Jun 2026 21:57:21 +0800
Message-Id: <20260630135729.466264-3-bin.meng@processmission.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630135729.466264-1-bin.meng@processmission.com>
References: <20260630135729.466264-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0161.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2cb::15) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYPPR02MB8959:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b07adac-6b22-4207-013f-08ded6af991a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|34096008|23010399003|3023799007|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: UldBxGvQiJ/G24ZRH2FBcfQc25ovFYht8GNJWBEpnNeqEkMxuGQxasmn5pXjWls4w48RMbColAg79jjSLzw3wp4kFI3LlVlMKORQS1BWeK8nzjP4lFK2rF5C5muPpOObCLQ7VBx8Gx9dPx6+XOqW3pCc/Y658veRBdX54WzCEe+revgp4bd6s+If649ZQPZsUP/HvJmkmKUHDIFYiLZrwniKJZtN237Ar+Fy3AOMPe6Aww9VLM/0liP//L4qvhRx7HRZYGxFmiGwZtE+XzVngq2EYFdPDBSNOV5QiDr0iFRjalSWAnI42EKvMmhGnu6v2IPIddc+Z03ScYXDODPo6bmuiUNzUU/NWI/4U+6Q4O+G/1aERoduXJOIilat41932bc8KKCjI48OYOy2EVykcYv8UMfTvOR62KtZpJJvG2wBuJJM8rrQNyut9UtL2npJz+Sb/BU60TxWbOB3RMAM/z+uIpM/2/gXSn9yVrsBhb9RjCHmDshfzGVNpRV7sY61Xfi71RUf++jT3yD4KFyLdtryMe8oisENyBPwDGBm91JzYfabThfDOrjDm93MPrLcqerwU0AQihSSlbVpbCyImQhcdHwn0g9ReTKF2Pu1j3PLNDJN7W0ENrtI0ESelaeit0wTYvKYlPv6qDFFtzkmhhYGeIIjNlWwtxb4sXi1dGY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(34096008)(23010399003)(3023799007)(6133799003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BvY4drkiw81PDBcS58RKe/hvex1f2lASzOQsLmHviNHw7d0VRgFFuSvshpdt?=
 =?us-ascii?Q?+dHvFEG4zd811a3e/iF1aLH5sKVLYB+DAfLC2G0w74W3Rh8L1m4BXRcjgo+O?=
 =?us-ascii?Q?G+FwsI99VDUwcJ8xKq61ly6WdQVH2U52LFVaQftDAVUz9KVN2jAUNV6U1j84?=
 =?us-ascii?Q?Nvw3mQZ87vG3XIKro/1biwRyqMk8vklXBzyGSH/vz+ZdnCx+jcrfIFhRIptv?=
 =?us-ascii?Q?jOYWa1FoLOXw5NpEhxfecIZsdMnmt7t9H8fZyCmHBI8K2DbdvGa85PQh54UD?=
 =?us-ascii?Q?zAaXrcHtD7hevHLtixeRNlh9koTKp++IxjMqh8qyCZpCavUF5jL7+upiF0Xk?=
 =?us-ascii?Q?ex8PvFCurQhYZW6/OhSBh4F7uZt+qptfJOCmtJuOuE0Mt83zXTESqBZrW0S0?=
 =?us-ascii?Q?dEdJ/bcmM+JH/4JGeVxCzlbVPgugB45tJ3KPVcgoWGPYSV2Of+RRGIz9rGa4?=
 =?us-ascii?Q?n+Fca7DwFy50rCV9z6DizKF3UdpvJH5yIOG6lOzLFWLlhEwy9sqM+uVTN7G0?=
 =?us-ascii?Q?66cm2O7HGqiRkEGxxg0r3pRZW5zfslUeG+f1F8gcs9aJi6ONWw68GENS16zK?=
 =?us-ascii?Q?Q+qncDxbZIaQJY+9LufvQU+9BkaJ2QZoMvq0/0B8CXKahwtNNHjSzqB7Ac9w?=
 =?us-ascii?Q?Iup3Uqg2roVeaQyVNxlqSZ9bydQl/3M/Fdv+apwaJca+5T/OnjEkpJn16rvr?=
 =?us-ascii?Q?kZskHgiRwL+Wm+lFrkrCnWEN6FC3y9icBJ9y/+XnexZnGzKMwPOEYYw2uWrJ?=
 =?us-ascii?Q?DDP84xbpbz7H/dbslGE42Mv3wQ327aGRuTxhVJN2DZ7kXU6NVaOVxiplMSGD?=
 =?us-ascii?Q?0BQftlTwmTIKM40jUOg5lfuC4lofTWjX/pif3wQ31xWC1cIRFfM5lnVmek8l?=
 =?us-ascii?Q?RwIzUgXzCD+NmeBb6lQeq2LRM2P0VLp675fQ5c2F5LcNdm8fXiugT3dVvVLe?=
 =?us-ascii?Q?nM5GXaAlGW4y8IlD1lG/ff180nGRP0d/keRieYVbC1lIerxZeE5YB5B4/4wp?=
 =?us-ascii?Q?RrZzVX6DKmkA72FZWqpLa25Q7yRUjkOR4gxIlCDn0RRSs+78ddYD2JBZai1z?=
 =?us-ascii?Q?7hzyApw+VNyboJHnfVQ3QHAK3CUM4bRp6jwPNo9eP+eZp0Do4vhC6ejk8XQ0?=
 =?us-ascii?Q?IQtViqBwVggMNX9TTN9wdwPQZSDihlskY6IXujJgBogqFr6ro9/m+/ayx2Xk?=
 =?us-ascii?Q?Stao2mLRp6GHIU/s0HGsJS73xaigdK7Qx6+jmkHTfGtyF/aGTaQMdqMp8Co1?=
 =?us-ascii?Q?oyIaqvCecnN++d/Km4cRh0pRqqAg09lX+Zp/ck2+orgH2mqosmo2bzqau/sn?=
 =?us-ascii?Q?16GnHcRPRI4U3lyPC3WaEj+mV0qWJMNlIU7RBAsaIgWDS1mDYySlA3PtZ0Jo?=
 =?us-ascii?Q?Mjdz2289s5kMiVcABufvlLn53/hzNFhH88O2BlFWe1+SdBlxW/QGSLsgHxAJ?=
 =?us-ascii?Q?o5Io2TtkC74aI7miPtLepynP37z+kqSfsuU6y+INegnzNkC9W356Z2WgtrfZ?=
 =?us-ascii?Q?qZ9G7qrIfiefmUYlAFSDQ+gzP5F84tlkVtFWEyLn35/CpmQJ0sEynR4p+08G?=
 =?us-ascii?Q?BmNwbd8ONGu7xK3fHh2MWQ+E7EexCQVuCSatMY2DCjSBDeqVCXr3OOl3+eKi?=
 =?us-ascii?Q?AQs8F88IJbiLxHX9Ded65fJR2hn6JSa5vAmQW+9I2dG2fD+h6YXere1a2ap3?=
 =?us-ascii?Q?hZasHWRcMbn4W3toTCdsaxJDuSuHmqr8JQWyJ1vQBoie4e5JCsTGAeaFvnch?=
 =?us-ascii?Q?RsDf7k7cagDkZvI5YsRMw6TOwjuIaQ4=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b07adac-6b22-4207-013f-08ded6af991a
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 13:58:01.1749 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YVMjy8yX9LDttmfjVah/F3Ax5+QqBck8iYVg5Rpm969ll9z685v+KkNHUYZMYsj3QGEdIGxKfWo2St7x6UFjIRs4aiNov+JTufHZI1afDhU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR02MB8959
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=bin.meng@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

Numonyx/Micron flashes do not use one fixed dummy-phase width for all
fast-read commands. The volatile configuration register stores a number
of dummy clock cycles, and QEMU must convert that value to the number of
SSI bytes consumed by the flash model.

Keep the existing default: 10 dummy clocks in Quad I/O mode and 8 dummy
clocks otherwise. In Quad I/O and Dual I/O protocol modes, all command
phases are transferred on 4 or 2 lines, so the dummy clock count still
needs to be scaled by that bus width.

Standard SPI, also called extended SPI in the Micron datasheet, is more
subtle. Quad Output Fast Read (6Bh) and Dual Output Fast Read (3Bh) keep
the opcode and address phases on DQ0; their dummy phase is just a clock
gap before data is returned on four or two output lines. Do not scale the
dummy count for those output-only commands. Only Quad I/O Fast Read
(EBh) and Dual I/O Fast Read (BBh) transfer the address and dummy phases
on the 4-bit or 2-bit bus, so keep scaling those commands.

[1] https://media-www.micron.com/-/media/client/global/documents/products/
    data-sheet/nor-flash/serial-nor/n25q/n25q_512mb_1ce_3v_65nm.pdf

Fixes: 23af26856606 ("hw/block/m25p80: Fix Numonyx fast read dummy cycle count")
Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/block/m25p80.c | 44 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 59ecb32c0a..ba109cc055 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -980,19 +980,53 @@ static uint8_t numonyx_extract_cfg_num_dummies(Flash *s)
     mode = numonyx_mode(s);
     num_dummies = extract32(s->volatile_cfg, 4, 4);
 
+    /*
+     * The default nubmer of dummy cycles is only related to the SPI
+     * protocol mode. For QSPI it is 10, otherwise it is 8.
+     */
     if (num_dummies == 0x0 || num_dummies == 0xf) {
+        num_dummies = (mode == MODE_QIO) ? 10 : 8;
+    }
+
+    /*
+     * Convert the number of dummy cycles to bytes.
+     *
+     * In the Dual I/O and Quad I/O protocols, all command phases use 2 or 4
+     * lines. In standard/extended SPI mode the phase width depends on the
+     * command sequence: output-only fast reads keep the dummy clocks on the
+     * single address line, while input/output fast reads use the same 2-line
+     * or 4-line phase as the address.
+     */
+
+    if (mode == MODE_QIO) {
+        num_dummies *= 4;
+    } else if (mode == MODE_DIO) {
+        num_dummies *= 2;
+    } else {
         switch (s->cmd_in_progress) {
         case QIOR:
         case QIOR4:
-            num_dummies = 10;
+            num_dummies *= 4;
             break;
-        default:
-            num_dummies = (mode == MODE_QIO) ? 10 : 8;
+        case DIOR:
+        case DIOR4:
+            num_dummies *= 2;
             break;
-        }
+         }
+    }
+
+    /*
+     * If the total number of dummy bits is not multiple of 8, log an
+     * unimplemented message to notify user, and round it up.
+     */
+    if (num_dummies % 8) {
+        qemu_log_mask(LOG_UNIMP,
+                      "M25P80: the number of dummy bits is not multiple of 8");
+        num_dummies = ROUND_UP(num_dummies, 8);
     }
 
-    return num_dummies;
+    /* return the number of dummy bytes */
+    return num_dummies / 8;
 }
 
 static void decode_fast_read_cmd(Flash *s)
-- 
2.34.1


