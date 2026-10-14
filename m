Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC07CC6B19
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 01:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGnkO-0006Pe-5Z; Tue, 13 Oct 2026 21:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnjh-0005oE-Q1; Tue, 13 Oct 2026 21:24:56 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnjf-0006vY-Ld; Tue, 13 Oct 2026 21:24:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sYiOwTgQCgXjSKH0gLxfNNMe2drkQ00CoNmEX++vEgoO4ubt/ipb9qpLLr8Lvk1Ee0c9dVJkp0s+WIhBd9ad+MjAJ6U0FCpAW94n0f54pbquGZqrHrbRm9zM9dJG9Z1vfQIUnI6hlLOxNXYuofgSM1r1qC9j0RM8l00MZq0+4JO7YGuN/HEqI8dNFkqDfLc5xqTDiIq0fiB73zW/m09SDDMsbrmMfcN8q0k9L623DUzpBEf5Jug7TegbJ7DFmYa1gMRC44QouaDer/WzWJ8u64ix5AQeLS7DOKVYQyggTN2oGxm0hQ7pgpi9AwwVFwmU/8s4xTZTGoDDKTlaTLLS8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/fX15NyMg2FUWXvrzeSgk7xRqMUxSwpaCZcX/lV7Uv8=;
 b=WeU3DdhR8rC2Lc73KCdw1UqBhfJwbZoUGp5EJWszQxjdrTsd6Ifw4uwEnOpTgxGZyh4n4HyFjCIhkuELK78M1GZ9hVA2ocj3wqKs9uTyRji82u4HRLeagD/+4/J/X27uTPrLXdaeIidfreXDUQuVGgNKiRm0A1mmMCG8EKsanSXSkAuPpPOmzke1pqw5J1urznwor1GCgV2mOACYq/glF6jV0vbS5qY2S2qOXvjvOSYYYBTokbFbtHsE9Al+gCf/APxH3GgN7FQt/3+MeFQkjUcGxGFlmTwVLOaf7mcAn8vPifrjW0diDXxFN+aQkgmbFktqFspgxJTr9wUhPtKEAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fX15NyMg2FUWXvrzeSgk7xRqMUxSwpaCZcX/lV7Uv8=;
 b=k/JCXF9/PQZWHN0oLRL2MZ32lANWkYyYTeAK7NJ3yNuXedoDipUFsSk6Lqxh0ogAFKfyJ8v92hJJqW6gZ1Sn/EMHaobL9ipW/IXLY7U0NKvDn9hKTK61uwHfbaXu0KTiJJEFcbLxLNEeQXNGcS32o7nn6SQ4+2Wv/ct7k9FZQnN5uUvFgVU2zLndoSb0a55wsMw7WldcedQ4YXYKEjNTGdorF/5MGkW8E9JhsiIUBPiopbqp0LUAuC008fu6iTd3FUVRAu5UeyMEjsdlBPsCgwtGr3bkFbTO0EaBeUZ5q0DYagKlZqi7XjpXmlf4pPH0YZFhDYjrRRe9+ZzKZPHmlQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by KL1PR02MB6214.apcprd02.prod.outlook.com (2603:1096:820:9e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 01:24:31 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 01:24:31 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, Conor Dooley <conor@kernel.org>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
Subject: [PATCH v4 17/27] hw/misc: pfsoc: Model PolarFire SoC serial number
 service
Date: Wed, 14 Oct 2026 09:22:57 +0800
Message-ID: <20261014012323.322790-18-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014012323.322790-1-bin.meng@processmission.com>
References: <20261014012323.322790-1-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY6PR01CA0005.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::12) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|KL1PR02MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: 356fda82-a155-45ea-05a2-08df2991e61c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|6133799003|18002099003|22082099003|260925022911599003|10067099003|260925021311599003|260925021911599003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 56NUU2hz8TS3HW0yUxbXurEJaPiPcSU1fSSgDTBF+sasf1+aHhfIuh/4rbsiZ78IMGlHHd49viGiiJ/UhUDHPuQgEVsv3jJzeTxq5JwMB0UQ/Se8BMtvPNmqZejqG75+W5YL16GHATUhmSnnykxlhcVOXrK/UaUtUB0M/Qa5tK6vK3X1oYUVWHgPTP4mgTrWyOrxMscweQbrBOyhl/lRseSl28s4zVW1pcwER3AA3Qfdhr3ZYz6lsKSlyS4jHtl8Q2SjPLhuUSdXRueW3mPI71awdKnk2EJ2GjCDNC+doBmV3kz6DJ4HM2W9b5SXUcKHtNO1xfr1H9fVfgnYDqO2cyArCcLk6Clxkh9zwJD4MyLKrueZjOOZU98nOwp7+L6Yr7UF6gZZ7NtwY+EaKt7ekBqYPXODL2BHkNatwq8TLnIhsRLoXLNbLWiKo+H5avXP5w16gbEWzt6iqzDtZmaBTpADkXzpbsAAZQkrCXrIPNwUtLdrTjSfjF9V0aJdoW//FNufkrIkXA4RPzzXsE3tVpQko2Qu2ZnXpoo2ORQlJaNAcJYzDx6UlrbIbYuLnYGzLBiwSdYvhhJpy83bzQPmIdzpcoBLR2OHXsPn81aY3r4kSiuGJ8G3Zd5B+v72JpPtxThx3Y1THzoh3XyXGSHRfjrFfthu2UAAS2WtI9e9ig4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(18002099003)(22082099003)(260925022911599003)(10067099003)(260925021311599003)(260925021911599003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGppOEFrL2RrZGdaUFNnaVlLUGx2Rkc4Y1dyYVdUY3JVUnUyYmhZU2JiT05x?=
 =?utf-8?B?MUU5dGNsL0pKeGxhWDVKa25ZS3JVYlhtR0NFc1pkZW1DbGh0SmxHMHpPb2Fi?=
 =?utf-8?B?ajAwMDRqazFIUm10NzBHOGk5Q0E5dTlDUWpwZk5XbmU5MEpFN0xUM1Y1NmRr?=
 =?utf-8?B?eXFmeGZIMnQxY0JKcnBVR1JzY21na2pDczhPUGo4UzViSk5wdU5PcCtLMlJy?=
 =?utf-8?B?dlZkRDdGem8yemVpd1l6VDFYY1BvQ3c1T1pUb2tqWk50TWwrc2t5a3YvVW9q?=
 =?utf-8?B?cm5CUU9tT1hCR3liaTlXeklZTmpzYjE3a1FQRzJuRTN2WW9rOTdGcVZHQWxa?=
 =?utf-8?B?YSt5QlBudWt0L094cDFIbjZla1UveGgxTEFDb1F2Znp0MjllYlpoNm1iYUZG?=
 =?utf-8?B?em5GK2VvaXF4ZTA3OFRMaUoxZzByalZ1R0Ztc1FPdlNQSTVJRDhaOUJISlo5?=
 =?utf-8?B?K1l2TitHMzBrWnBvN2dRTE1JVk1QQ0tQcTkyT2tsS283aEJxZS9Hd3lhSzht?=
 =?utf-8?B?TmdYYk5LWGlYUmswZkMxMFpoUG1HMjJKb0VSR2J0MzZWYnF2d1pHZEFEZXJz?=
 =?utf-8?B?cVdMLzdIbm9qa1NUSzJrQmpNWnF0Q0RJRGdGbjIrNi9EZjRoejlOWi9EaC9B?=
 =?utf-8?B?SElkRjRRZXFLWWpHTEpmNHc4VmEwNkdhZUNZVmJoSEFqTUVWNGFNQTdHcyto?=
 =?utf-8?B?Y09hNklwZk5vQ2MyVHE3N3d5VEhCSExQQU9MbWNLaTJQaTBaV3RVcUhnZkUz?=
 =?utf-8?B?U1FBLzYvUjlJVjBqSHVuMG0rQlQ0SXZsUVI4QjVwbFhacTJ0M3RvL2hmOUZh?=
 =?utf-8?B?ZFFtQVFJYnJ3ZjIrT05BbTlFeG1ZYU1OMG4wVUQrRlZWTjZLYVJtaXpOdFQ5?=
 =?utf-8?B?endVZDBNR0hkYlZzbm5TVktkeSsxQUZQSU4rbVVDMXF6enF0UWlFeHAzWU9E?=
 =?utf-8?B?cW1ZNVdaaG1SaVU2QUE3b1d5TlpHaE1nVTBzQmlHVysxUHhmTUtZRG9mWW8v?=
 =?utf-8?B?aGZ6N0lnNW4zNFh2WkNSdm9YTUZrK0V5dXFGd2xrUHdrbjkvQnBEVVFlYUNk?=
 =?utf-8?B?OW96dVFvaHFqTldXbDRyRTRpR0hzV3BFOW1PUjROU2lsY09nZ0dUYTBodEts?=
 =?utf-8?B?MGtrR2lJTEppUVNLL053aTQ2eFFTdVJkMzFUOU9WZ2FtSWRSQ2g4amtyWElR?=
 =?utf-8?B?MDJISzVhcXFkV0JGYWxsb0VmS3Y3cVo1aUV5NnRzSGw2RXdlNU40eHU3NnlC?=
 =?utf-8?B?aDg4QVRmQ0pGNU04V1Z2YkZ3WlJ6c2E5anpEUWZ0UzUwdXhRcUQ2ZHJkSnZU?=
 =?utf-8?B?czd6VHZHU3d5L3dJQWtJdWV1K2FHbDRaQ0lnNDNDRUEvVDRmWDJQKzl0TU13?=
 =?utf-8?B?YUtxU0ZBL2hnNXlGMHRGd2JWYXF5bmdLWGFidWc0OHF4OWtTcyttUjRMc0ww?=
 =?utf-8?B?WVB5d3BuczJ0NFpYUi9Ia3BuVFhONzh5TEozZHdMVzNUNlZFSEJjWVZCYWxM?=
 =?utf-8?B?akNwbDlUU3haTWk3Y2psblZhZGF2VVJmNTBVYW9nQkRZbUFNMUlOK09GNEJN?=
 =?utf-8?B?MWxNNTNEYVQ2cGFmbFo4YXRjbHlFRlFxUnpRVFc2NFNFMms0b0FrZUFWVll6?=
 =?utf-8?B?bE9BcmVOR0JrWlBPNmRyNi9NNk1LcTdEN2MrSFRwNDhtbGVHY2dHUlVMTjFx?=
 =?utf-8?B?QUdQNUNDU3FJTUFNTWFKaWd4VVJTZjM0RnYwcTh5Z3dnMFc1UHlRVXNTZDZE?=
 =?utf-8?B?TzFBdVJtall0cGlKYUNTd0IxeFYzamlLTklhRWFZbHlYZThFRmdvVFU2QXUv?=
 =?utf-8?B?c1FsczBZLzF4QVdsNU5hcW5ja25xTTEzK2xZa1VOUHVpemVQbytJUWwwOFdG?=
 =?utf-8?B?NXRacTRLdW1tMjJCQmRlNXE4c2lFSlhzNUxheGRmaUZ0b3ZjaDU4NVZwWVRZ?=
 =?utf-8?B?QkNMak9xMG5QS2J1QWdhV0hwYnh3YjEzWWFQS1VkbGUyK080dXdrdHMxZWxH?=
 =?utf-8?B?OFYyVXc0RTB4c2haWEdjNTNQeVBOdjFEelRYM1BOaStaOTF4T1FwRzl1cTZK?=
 =?utf-8?B?SXhldFlTTnZyYU9uZEVLbGM3SGJpYnIydkcxNllkVS9qUTA2TmhPL1Z6R3do?=
 =?utf-8?B?WTIvMmZZTWVvbTBUcjBIUDZ3dDRlZmxnb0xaV1FMOWJrSi9Ra0h3d1NFTnN1?=
 =?utf-8?B?dWF2a2RKbHg1cFZOMFQ0Z3pTaXN2QVgzS0ZkNGEyWVpqWmR3c0RVSHhabUw1?=
 =?utf-8?B?Rnk4ZUNjTUIvVi9tNmtNSWhRWkFxNFA2bFg5OTZkU3dVcmdaZEI0OC92dW1r?=
 =?utf-8?B?NWdJWmQwM0xZY3J6MHpwY0RiVFN2TUFnRi9hdlV1RkZnZEZvYW9ZNGRMQjda?=
 =?utf-8?Q?ef8tkk0xtGu2d45M=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 356fda82-a155-45ea-05a2-08df2991e61c
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 01:24:31.8934 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l5OTtWrjBJ8sdC/gPoSbaHfypMm+d6R3sD5D4SFcQYr1qjMSbWex+vtnHhogjlDWRP/dAxiCwj+R0zH/0T0juYjIvt67xBwLJuKdEvetmFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6214
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

U-Boot requests the PolarFire SoC device serial number during board
late initialization. The IOSCB previously rejected every request, so
board setup could not complete.

Model the System Services control registers and byte-addressable
mailbox. Obtain the 128-bit serial number from an optional device
property, using a deterministic value when it is not configured.
Return an explicit failure for unsupported services and reset the
new runtime state with the rest of the device.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com>

---

(no changes since v3)

Changes in v3:
- Decode the seven-bit opcode and nine-bit mailbox word offset
- Bound serial-number responses to the documented 2 KiB mailbox
- Mirror the current control flags in the status register
- Use default access sizing for the control and mailbox windows

 include/hw/misc/mchp_pfsoc_ioscb.h |   6 ++
 hw/misc/mchp_pfsoc_ioscb.c         | 156 +++++++++++++++++++++++++----
 2 files changed, 144 insertions(+), 18 deletions(-)

diff --git a/include/hw/misc/mchp_pfsoc_ioscb.h b/include/hw/misc/mchp_pfsoc_ioscb.h
index 9687ea25b1..aa108d2d88 100644
--- a/include/hw/misc/mchp_pfsoc_ioscb.h
+++ b/include/hw/misc/mchp_pfsoc_ioscb.h
@@ -25,6 +25,8 @@
 
 #include "hw/core/sysbus.h"
 
+#define MCHP_PFSOC_IOSCB_MAILBOX_SIZE 0x800
+
 typedef struct MchpPfSoCIoscbState {
     SysBusDevice parent;
     MemoryRegion container;
@@ -47,6 +49,10 @@ typedef struct MchpPfSoCIoscbState {
     MemoryRegion cfm_sgmii;
     MemoryRegion bc_sgmii;
     MemoryRegion io_calib_sgmii;
+    uint32_t services_cr;
+    uint32_t services_sr;
+    uint8_t mailbox_data[MCHP_PFSOC_IOSCB_MAILBOX_SIZE];
+    char *serial_number;
     qemu_irq irq;
 } MchpPfSoCIoscbState;
 
diff --git a/hw/misc/mchp_pfsoc_ioscb.c b/hw/misc/mchp_pfsoc_ioscb.c
index 09b702e520..850125c8b4 100644
--- a/hw/misc/mchp_pfsoc_ioscb.c
+++ b/hw/misc/mchp_pfsoc_ioscb.c
@@ -25,6 +25,7 @@
 #include "qemu/log.h"
 #include "qapi/error.h"
 #include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/core/sysbus.h"
 #include "hw/misc/mchp_pfsoc_ioscb.h"
 
@@ -37,6 +38,9 @@
 #define IOSCB_CCC_REG_SIZE          0x2000000
 #define IOSCB_CTRL_REG_SIZE         0x800
 #define IOSCB_QSPIXIP_REG_SIZE      0x200
+#define IOSCB_SERIAL_NUMBER_SIZE    16U
+#define IOSCB_DEFAULT_SERIAL_NUMBER "0123456789abcdef"
+#define IOSCB_PROP_SERIAL_NUMBER    "serial-number"
 
 
 /*
@@ -186,33 +190,88 @@ static const MemoryRegionOps mchp_pfsoc_io_calib_ddr_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-#define SERVICES_CR             0x50
-#define SERVICES_SR             0x54
-#define SERVICES_STATUS_SHIFT   16
+#define SERVICES_CR                         0x50
+#define SERVICES_CR_REQUEST                 BIT(0)
+#define SERVICES_CR_NOTIFY                  BIT(3)
+#define SERVICES_CR_COMMAND_SHIFT           16
+#define SERVICES_CR_COMMAND_WIDTH           16
+#define SERVICES_CR_COMMAND_MASK            \
+        MAKE_64BIT_MASK(SERVICES_CR_COMMAND_SHIFT, SERVICES_CR_COMMAND_WIDTH)
+#define SERVICES_CR_MASK                    \
+        (SERVICES_CR_REQUEST | SERVICES_CR_NOTIFY | SERVICES_CR_COMMAND_MASK)
+#define SERVICES_SR                         0x54
+#define SERVICES_SR_CONTROL_MASK            0xf
+#define SERVICES_SR_STATUS_SHIFT            16
+#define SERVICES_COMMAND_SERIAL_NUMBER      0
+#define SERVICES_COMMAND_OPCODE_MASK        0x7f
+#define SERVICES_COMMAND_MAILBOX_SHIFT      7
+#define SERVICES_COMMAND_MAILBOX_MASK       0x1ff
+#define SERVICES_STATUS_SUCCESS             0
+#define SERVICES_STATUS_FAILED              1
+
+static void services_cr_write(MchpPfSoCIoscbState *s, uint32_t value)
+{
+    uint32_t command;
+    uint32_t opcode;
+    uint32_t response_offset;
+    uint32_t status = SERVICES_STATUS_FAILED;
+
+    if (device_is_in_reset(DEVICE(s)) ||
+        !(value & SERVICES_CR_REQUEST)) {
+        return;
+    }
+
+    /*
+     * System services complete synchronously in this model, so clear the
+     * request bit before exposing the response to the guest.
+     */
+    s->services_cr &= ~SERVICES_CR_REQUEST;
+
+    command = (value & SERVICES_CR_COMMAND_MASK) >>
+              SERVICES_CR_COMMAND_SHIFT;
+    opcode = command & SERVICES_COMMAND_OPCODE_MASK;
+    response_offset = ((command >> SERVICES_COMMAND_MAILBOX_SHIFT) &
+                       SERVICES_COMMAND_MAILBOX_MASK) * sizeof(uint32_t);
+    if (opcode == SERVICES_COMMAND_SERIAL_NUMBER &&
+        response_offset <= sizeof(s->mailbox_data) - IOSCB_SERIAL_NUMBER_SIZE) {
+        /*
+         * The descriptor contains a seven-bit opcode and a nine-bit mailbox
+         * word offset. Return the 128-bit serial number at that address.
+         * See section 3 of the PolarFire System Services User Guide.
+         */
+        memset(&s->mailbox_data[response_offset], 0,
+               IOSCB_SERIAL_NUMBER_SIZE);
+        memcpy(&s->mailbox_data[response_offset],
+               s->serial_number, strlen(s->serial_number));
+        status = SERVICES_STATUS_SUCCESS;
+    }
+
+    s->services_sr = status << SERVICES_SR_STATUS_SHIFT;
+    qemu_irq_raise(s->irq);
+}
 
 static uint64_t mchp_pfsoc_ctrl_read(void *opaque, hwaddr offset,
                                      unsigned size)
 {
-    uint32_t val = 0;
+    MchpPfSoCIoscbState *s = opaque;
+    uint32_t value;
 
-    switch (offset) {
+    switch (offset & ~3ULL) {
+    case SERVICES_CR:
+        value = s->services_cr;
+        break;
     case SERVICES_SR:
-        /*
-         * Although some services have no error codes, most do. All services
-         * that do implement errors, begin their error codes at 1. Treat all
-         * service requests as failures & return 1.
-         * See the "PolarFire® FPGA and PolarFire SoC FPGA System Services"
-         * user guide for more information on service error codes.
-         */
-        val = 1u << SERVICES_STATUS_SHIFT;
+        value = s->services_sr |
+                (s->services_cr & SERVICES_SR_CONTROL_MASK);
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimplemented device read "
                       "(size %d, offset 0x%" HWADDR_PRIx ")\n",
                       __func__, size, offset);
+        return 0;
     }
 
-    return val;
+    return extract32(value, (offset & 3) * 8, size * 8);
 }
 
 static void mchp_pfsoc_ctrl_write(void *opaque, hwaddr offset,
@@ -220,15 +279,22 @@ static void mchp_pfsoc_ctrl_write(void *opaque, hwaddr offset,
 {
     MchpPfSoCIoscbState *s = opaque;
 
-    switch (offset) {
+    switch (offset & ~3ULL) {
     case SERVICES_CR:
-        qemu_irq_raise(s->irq);
+        s->services_cr = deposit32(s->services_cr, (offset & 3) * 8,
+                                   size * 8, value) & SERVICES_CR_MASK;
+        if (offset == SERVICES_CR) {
+            services_cr_write(s, s->services_cr);
+        }
+        break;
+    case SERVICES_SR:
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimplemented device write "
                       "(size %d, value 0x%" PRIx64
                       ", offset 0x%" HWADDR_PRIx ")\n",
                       __func__, size, value, offset);
+        break;
     }
 }
 
@@ -238,11 +304,62 @@ static const MemoryRegionOps mchp_pfsoc_ctrl_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
+/*
+ * The System Controller uses the mailbox as a byte-addressable shared buffer
+ * for service command payloads and responses.
+ */
+static uint64_t mchp_pfsoc_mailbox_read(void *opaque, hwaddr offset,
+                                        unsigned size)
+{
+    MchpPfSoCIoscbState *s = opaque;
+
+    return ldn_le_p(&s->mailbox_data[offset], size);
+}
+
+static void mchp_pfsoc_mailbox_write(void *opaque, hwaddr offset,
+                                     uint64_t value, unsigned size)
+{
+    MchpPfSoCIoscbState *s = opaque;
+
+    stn_le_p(&s->mailbox_data[offset], size, value);
+}
+
+static const MemoryRegionOps mchp_pfsoc_mailbox_ops = {
+    .read = mchp_pfsoc_mailbox_read,
+    .write = mchp_pfsoc_mailbox_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void mchp_pfsoc_ioscb_reset(DeviceState *dev)
+{
+    MchpPfSoCIoscbState *s = MCHP_PFSOC_IOSCB(dev);
+
+    s->services_cr = 0;
+    s->services_sr = 0;
+    memset(s->mailbox_data, 0, sizeof(s->mailbox_data));
+    qemu_irq_lower(s->irq);
+}
+
+static const Property mchp_pfsoc_ioscb_properties[] = {
+    DEFINE_PROP_STRING(IOSCB_PROP_SERIAL_NUMBER,
+                       MchpPfSoCIoscbState, serial_number),
+};
+
 static void mchp_pfsoc_ioscb_realize(DeviceState *dev, Error **errp)
 {
     MchpPfSoCIoscbState *s = MCHP_PFSOC_IOSCB(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
+    /* Use a deterministic identity when no serial number is configured */
+    if (!s->serial_number) {
+        s->serial_number = g_strdup(IOSCB_DEFAULT_SERIAL_NUMBER);
+    }
+    if (strlen(s->serial_number) > IOSCB_SERIAL_NUMBER_SIZE) {
+        error_setg(errp, "The serial number can't be longer than %u bytes",
+                   IOSCB_SERIAL_NUMBER_SIZE);
+        return;
+    }
+
     memory_region_init(&s->container, OBJECT(s),
                        "mchp.pfsoc.ioscb", IOSCB_WHOLE_REG_SIZE);
     sysbus_init_mmio(sbd, &s->container);
@@ -265,8 +382,9 @@ static void mchp_pfsoc_ioscb_realize(DeviceState *dev, Error **errp)
                           "mchp.pfsoc.ioscb.qspixip", IOSCB_QSPIXIP_REG_SIZE);
     memory_region_add_subregion(&s->container, IOSCB_QSPIXIP_BASE, &s->qspixip);
 
-    memory_region_init_io(&s->mailbox, OBJECT(s), &mchp_pfsoc_dummy_ops, s,
-                          "mchp.pfsoc.ioscb.mailbox", IOSCB_SUBMOD_REG_SIZE);
+    memory_region_init_io(&s->mailbox, OBJECT(s), &mchp_pfsoc_mailbox_ops, s,
+                          "mchp.pfsoc.ioscb.mailbox",
+                          MCHP_PFSOC_IOSCB_MAILBOX_SIZE);
     memory_region_add_subregion(&s->container, IOSCB_MAILBOX_BASE, &s->mailbox);
 
     memory_region_init_io(&s->cfg, OBJECT(s), &mchp_pfsoc_dummy_ops, s,
@@ -343,6 +461,8 @@ static void mchp_pfsoc_ioscb_class_init(ObjectClass *klass, const void *data)
 
     dc->desc = "Microchip PolarFire SoC IOSCB modules";
     dc->realize = mchp_pfsoc_ioscb_realize;
+    device_class_set_legacy_reset(dc, mchp_pfsoc_ioscb_reset);
+    device_class_set_props(dc, mchp_pfsoc_ioscb_properties);
 }
 
 static const TypeInfo mchp_pfsoc_ioscb_info = {
-- 
2.53.0


