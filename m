Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555B3CA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 09:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDIAO-0005y8-It; Sun, 04 Oct 2026 05:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xDIAD-0005v6-LC; Sun, 04 Oct 2026 05:05:46 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xDIAB-0005jQ-UV; Sun, 04 Oct 2026 05:05:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vq9Mq2k9IJ5GKXXu3/mQlafQuP2pJdcWFLDoklV/Z1JECzaXqdkLK87HpAmJFJHQpfL93QAowJMgytYoWpk1PnEJXXIGRacL8RcZ+9p+rNurqJDDAmUXxs+NWUVhTLVBVExB8vXHTD/O7iDPBhR1r2yh/pJZSaHlLUgAKmCOGeI/LKkyuAjvDTNlxZJlAroiyv9kys7S9u0fZiozGn1eBOd73MSSXO3lZapQqUw4/RlAWUULyOkXaMSxk77HExaZ49UwG2pfGBCl+b2apNC7Pztt5NhNBmChJFhwBwpvntZUi8mM8HpgrVEnqjhz5ovylUcSkEH08QDYLz7YXvbXkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZggDO/vh5keP2ri+CBhZAzKeezsH2XHuKL+w4Is6OM=;
 b=iKA64M3FBhDl+Rr4MU3tRGiLMxGAx/a833V1pv6iLt3gG0lAihIZEb6uj5NXQ+nzDMUwOGgPnR4aFBmGuOVlCZX5MHDEBk7Hkdb70qNSg2w8TGy++fLgx3YKcWC1spAdb6a9+8TWNAyuPM4ojvwzDe5T4bbUx79swLiKAol8TtAzHVA9DPM2JrbyAwFl2R6MioiygR9Waj46JvzRTv0/odaxsrRc/itY8zNrAG13lD9Relz4EpnR/3lHw4nI9jTcOXmXlpk6c0EJ/cA95Vtm82RwaT+BXe3CePizBQZVr5AfsneusLeVKsJlCV6tIySQvhMQPvanSIPl6GBST9S/7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZggDO/vh5keP2ri+CBhZAzKeezsH2XHuKL+w4Is6OM=;
 b=adX4vfSQTxld9o583SXSLcJJIzewnx2ZG/TuPHd8p1fNKFLPWf/spopKmyPyIAvu2OEgqM7pwDjHFD1S0hiG01oXNO4AzgbtD31JSUG5F+na70M8INTupdpWDeJZff1iWS/3cRk6/KInXxTy+LStY2jRfZrnE7JQq4mvKT6ppYVcIbtbUC2+Agey8OVV4drTq2ecuoCLwjjBVyHMe4fJAVvAPbU5xYaRwT1ECf+NoIuCtSTyQXNNB6FMTLwnLgV5Dja8gXPlZXkJTHtGtk4KHRDc2CxB4yeBINRVJk5CA6sx8McKSEM35daiDitebbsjN6rK+pELCEsTpKuv1zNiIQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYPPR02MB8958.apcprd02.prod.outlook.com (2603:1096:405:382::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 09:05:35 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Sun, 4 Oct 2026
 09:05:35 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org
Subject: [PATCH v3 09/10] docs/system/arm: Document MCIMX6UL-EVK Buildroot boot
Date: Sun,  4 Oct 2026 17:04:54 +0800
Message-ID: <20261004090500.3082641-10-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004090500.3082641-1-bin.meng@processmission.com>
References: <20261004090500.3082641-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0002.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::20) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TYPPR02MB8958:EE_
X-MS-Office365-Filtering-Correlation-Id: 8360ec8c-8c5f-4895-73bd-08df21f6a69c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: g1a3qWeoz4mNH1uu78EZ5fIpjii2CMFM8fyO0WmpJuITbLo/KVKuw0/wcOb7ZnW9J0ww1qRXRqrFt14dKV6xZQX8Ti7gwxXWu8xpOeqF5aVcTiz/j83Ks+57UZ6kYsTKZlAnfdYs2JJsKBYX0WQQ6BWzM6xjfdCvtHJlOxRduq1KK+BURr5ig5vT9QN1H1dFK91qnXItXHOTSxwma3y+CCmhUiwaXljgtLQ+D57zJ2Q/N3QEtLbcFAuIN5q8Lq5cUe7dWftaqseSdzzYSjbLufsg73RfI0YEzlh5YwTQdEeHbTIiomLm5qnjRC9Z44lWKH0u6VlBDKj2KBdqdsV2nOUlvnMGaHCmDxfcqHtBcH6wVkFzqUUVdCrEqZtUdv6A0/v/WI+MEPDk/C1iZ42tuAU9hMF4I2d/1rlP4UuNrwqh9dA33FN/GxQbfkQIqE7ZBqSF4Zvdb4+oV1LTCcRBRL3GOJChOSns5w2TcCW89zIflloB+/Pl+gwmgq3HTvXspzCdqo9zzfnA7RcZ3/8NQQ15vwFWBcSi2dO26h7JLgI2tp6jCdoiBh86/DKol4Hn+NhAPr2lEq3ftR9wPTt1RNPDF4o6Jt8WtOuQUFGs9LLOAGSDzTNSJweSYzXVUuba+AGSYybDL3NzU1fHqU5a9FREHVJqZsd8G9H0LPNcx2s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NbyeXgYoyz16lZzeQ+IsIqjsD2LVHb/rMcnhrtDIIblaqGCE3xvHxRQ32KQf?=
 =?us-ascii?Q?d8RPvOrWngyWGgtmwFQfXGrhuLf5Zfk7VailNHDQFN57cyakzdGVKooUY1A5?=
 =?us-ascii?Q?fz36HTL/PBEM70UbpVnl/gQtisJqB9jI2CRpYSHi3IRvDHujQeW6UqJ+6riO?=
 =?us-ascii?Q?8LWuIkHP+VQFgQPF/iI/cHUQAOL/T8a6W2eSsM2IaIoCEMassmoFGJnmXfJ+?=
 =?us-ascii?Q?54MX+sYKjN7Ae3xlBg0YAChLv7pmIjW9JbUbiZB8sf0qhfd1I+NeDBFZTsyT?=
 =?us-ascii?Q?WZ2eoFCJHccr4dqz7bCNh98d2ACdBGf3+l4ABLrLgCaGrZUJ2s8rIDpDqpGG?=
 =?us-ascii?Q?OENVmv1PoXCn0Gu87iMzeQQ3E5yR4vDyiiiVLN4bOQlsXPzhjPyx8YwDwe/m?=
 =?us-ascii?Q?Ps4hOBbgP3OkratOmEPeeCyyDvPd9en3J+Ej5RMf8+IlT/5jOVvgR+OoM3YP?=
 =?us-ascii?Q?t0ewSG0OsZFy1KNBN8uGpHwfkIjzyI9zmqlrgjSFfrA+xtR+1cyCjrUplxCZ?=
 =?us-ascii?Q?DrjMOEc+F0fHY4WZOG59Os9WbRPffnFTrgi39ylHVmJZH/+8AWMmsucULYdK?=
 =?us-ascii?Q?QFyZc9bO3eJKzZhLCiLA0/B04g5IsGUmb0Di3sdwMUb8MKx8PrxryaA9caSQ?=
 =?us-ascii?Q?bSS63B4STzsJ8fIgJSLYHvkVvt08bxA1MZSZmMaTL5Z3BIYMRigEDlGEk6fj?=
 =?us-ascii?Q?dgB7JJGYwWRwKRDShppr6G72Z9rXJYEP7LNikLR5PLpTCW24MmPcoxGx5gAo?=
 =?us-ascii?Q?4MPOwJWtji1gNKwOwaha61pyJUPG+My+GDuCsBSS3iqJ7/WkjcvVWMGXOeMs?=
 =?us-ascii?Q?enLUb4dXr9s2VCy9NnwfV/Lp7e0FWFooQBEZnYTxvD4+FvNF3dZGbp7Erj1q?=
 =?us-ascii?Q?QBBXxvTMPUWA3tfyAYwMmA1whO9RBJr1ZNi0vx2SC9cNfB7yFCNqUPf6wwwz?=
 =?us-ascii?Q?Auosgp8ncAS/ia+GkSMohtDimPQfvTZPa4r+VSMwcpWMLaO814M6hYm6FGdO?=
 =?us-ascii?Q?RYsxQoDNieo26uMvAVQvrDG0l5cCnFttiVGAPJKjYehP1yO3LVNzMTIzWhAV?=
 =?us-ascii?Q?tujg7u/zYdH7bTKtFz3cmZof/4Yd/EeGJOsLWPCU1UsstiXLfzViUjPnxaX9?=
 =?us-ascii?Q?GTZhXaVOABmfqdLGvGiJTAVAU1KzvVeD/MYbbAMG3xLsKARRJzmYGRGBMAx1?=
 =?us-ascii?Q?ZGoMkG7vJA2Je9+eq8zBTfnIRK3xF4BUV4OAgFUOUhHozCpXz+SklRATqQax?=
 =?us-ascii?Q?26qnEZH6Ppb2I21MaudDpSDS1zSOxj//qU8v2U39MPhau8PBQ0crD+gWd+mG?=
 =?us-ascii?Q?3gdlpokp53r3TNjyjI05N0nPJ4vdC/b968ZjJiIRgWrvriPAXE9JT054gMhg?=
 =?us-ascii?Q?1PjKrFVVHk418nZfnVko1CdoTs70N5jlKF+/TzNzummGm6pmkzT/nWpr9Kay?=
 =?us-ascii?Q?P1v9RVRxiWt9b0EIHE9mkIXYiuqeEw2rV7H50s9uHMfTOyS2AHxayg7evg6i?=
 =?us-ascii?Q?ee95TzbQnV1cFrsw0mqjiyKLUlWCKVdGUDUqLBFxaRPcv58O/rZ+8wnqba1l?=
 =?us-ascii?Q?L6TgGtF0+DJeSt6iDYcj0g5Yaj5Qc80z/CB8VHx1gO2Z3UJ80k6CBV91FoLd?=
 =?us-ascii?Q?4mKIq2wynwSi619+soeTEOYpz7iFRP8xNMIV9N1lsj+Re/R9JEa2wgLUCemG?=
 =?us-ascii?Q?h7Z9PFJuUrNL1l+l1ReQtllwruoYfke7GNuX+gwu9DpSU5r5QM1J0hUMPXGA?=
 =?us-ascii?Q?sbJdlWuV/Ux5IpuxWVompS7tnuOMW/A=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8360ec8c-8c5f-4895-73bd-08df21f6a69c
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 09:05:35.2130 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cdEDYAYt6YYO4xRrdE83HZFIWObbEDFe9Xpt617iBnNjgBHTZWAaM7puZaTrTgJ/ltHH8rUa0EJ57woEdSoiiJoz2++XCUQ6Wi5xu6QLUMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR02MB8958
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=bin.meng@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Provide verified instructions for U-Boot and direct Linux boot using
Buildroot images.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v3:
- Document the RAM limits and firmware geometry rounding

 docs/system/arm/mcimx6ul-evk.rst | 72 ++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/docs/system/arm/mcimx6ul-evk.rst b/docs/system/arm/mcimx6ul-evk.rst
index 8871138ab3..a84b447019 100644
--- a/docs/system/arm/mcimx6ul-evk.rst
+++ b/docs/system/arm/mcimx6ul-evk.rst
@@ -3,3 +3,75 @@ NXP MCIMX6UL-EVK (``mcimx6ul-evk``)
 
 The ``mcimx6ul-evk`` machine models the NXP i.MX6UltraLite Evaluation Kit
 MCIMX6UL-EVK development board. It has a single Cortex-A7 CPU.
+
+The minimum RAM size is 16 MiB and the maximum is 2 GiB.
+The MMDC geometry reports the largest power-of-two capacity
+not exceeding the configured RAM size to firmware. Direct Linux
+boot uses the full configured RAM size.
+
+Booting Buildroot images
+------------------------
+
+Build the SD card image with the tested Buildroot version:
+
+.. code-block:: bash
+
+  $ git clone https://gitlab.com/buildroot.org/buildroot.git
+  $ cd buildroot
+  $ git checkout 2026.05
+  $ make imx6ulevk_defconfig
+  $ make
+
+The following examples use images generated by Buildroot::
+
+  IMAGES=/path/to/buildroot/output/images
+  QEMU_BUILD=/path/to/qemu/build
+
+The generated raw ``sdcard.img`` is about 84 MiB, which is not a capacity
+supported by QEMU's SD card model. Resize the image in place to 128 MiB::
+
+  "$QEMU_BUILD/qemu-img" resize -f raw "$IMAGES/sdcard.img" 128M
+
+This modifies the Buildroot output image; rebuilding the image restores its
+original size.
+
+The SD card must be attached to USDHC2 with ``index=1``. It is consequently
+named ``mmc1`` by U-Boot and ``mmcblk1`` by Linux. The first partition contains
+the kernel and device tree, while the second partition contains the root file
+system.
+
+U-Boot boot
+~~~~~~~~~~~
+
+The machine does not model the i.MX6UL Boot ROM or its SPL loading sequence.
+Load U-Boot proper at its linked address::
+
+.. code-block:: bash
+
+  "$QEMU_BUILD/qemu-system-arm" \
+      -M mcimx6ul-evk -m 512M \
+      -device loader,file="$IMAGES/u-boot.bin",addr=0x87800000,cpu-num=0 \
+      -drive file="$IMAGES/sdcard.img",if=sd,index=1,format=raw \
+      -nographic
+
+The default Buildroot U-Boot environment selects ``mmc1``, loads ``zImage``
+and ``imx6ul-14x14-evk.dtb`` from the first partition, and starts Linux with
+``/dev/mmcblk1p2`` as the root file system. A ``bad CRC`` warning while loading
+an uninitialized persistent U-Boot environment is expected; U-Boot continues
+with its compiled-in defaults.
+
+Direct Linux boot
+~~~~~~~~~~~~~~~~~
+
+QEMU can load the Buildroot kernel and device tree directly. The kernel then
+mounts the second SD card partition as its root file system::
+
+.. code-block:: bash
+
+  "$QEMU_BUILD/qemu-system-arm" \
+      -M mcimx6ul-evk -m 512M \
+      -kernel "$IMAGES/zImage" \
+      -dtb "$IMAGES/imx6ul-14x14-evk.dtb" \
+      -append "console=ttymxc0,115200 root=/dev/mmcblk1p2 rootwait rw" \
+      -drive file="$IMAGES/sdcard.img",if=sd,index=1,format=raw \
+      -nographic
-- 
2.53.0


