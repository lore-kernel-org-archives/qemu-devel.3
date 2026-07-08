Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45AF0C44501
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 15:01:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whTm0-0007mV-Ib; Wed, 08 Jul 2026 11:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1whTlu-0007fa-PH
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 11:01:11 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1whTls-0003b4-5P
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 11:01:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3Jqb60ujqezKqJcBbYfXrk4dJoyBxYOUZ6X5p/V4fF5KZcES1zZJgn57c+N4w7O9yYDz1NH8yoltd22ocrMhjyKTFT0QW/HX6gNSpT9RGOa/cCRnO10+UkWnDgSHEfFWPRlMn403J1132MBufOfFLs/WDCigVSR+12PQXMS8dOkuwQmAXcIOCknzKUW02SrrUK4DhVRQW8G7O1ZuhvtQ5dI67T4VtRRRkUc0SHKPH4gFnpFooHh/EXVORMTNvqBT91Hv7EVIrAvOvBy3aNyYg8NsHHnnnJAGuUrNna8AWMihZ5+Q9eADrr/oAWlLCb5lk/K8yF+RqoE2yQ6JxLcbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dbPbCg2NvFnl3CDlzq/rPt85EEmQhIwAO/8qy8lSJs=;
 b=q4chlE4xlEPgEEY2j6wcTynbCSrWCsaQKuxQUt/vj1WKZMtWQizZmTHxLmfMnFLY1EgZI5Se6JqGf6b8d9q46f6v+7PuRLSuSSNltG+6Sd8powUPkkYqePI0iS+rr9Ei4aSyt390ZaOYTUiqsQze8GvWThqDoDyn5bl1vtxd5KyF66kOlbTkRWe5LNNqwq4ilUlNc8axPgG3oCgihyFcyfvyhg7EEqy3wAJoqEiJmVkO+WvGjhZAHaXL7U14UzKM6OHlXlWQ1ZtS+vg1DKhYqZ6SmEFhB8mdQWPHoVbnwdnTf6IkpCnpHYFdSF4tRMh91xB4Is37cERXJZkVLxZ+6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dbPbCg2NvFnl3CDlzq/rPt85EEmQhIwAO/8qy8lSJs=;
 b=oq2+qw+rGy7QtjMpCjOucgswmouyUuJxCV+o8ChkUWud7C/icXdm5ZpS78aOZz2WCo53GehXAsLzkaGfZd21Iqbgg4jZKy/2ytZ0j+IIj1eazplqDfZ0MsMZj+LERyJPsoXmRbfEalnq69xh5VeMxa06vqeI1dUIzbNmx4lHCmNWsoniV0SKWo27jevYivvi3oab2SIRLbG0inkRBHJIzq8N8ulQ0wc3kW9sioNshlzp6B0s2ol9R7gTw76U9T3GJY8gsluXj03q1z+YXWDDGcukqMfPhRk1idMk0tBFo+ZCQnkFaACXF2hY8fEkiqbguP+qL9NM+tHiwmFKu9EO7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by JH0PR02MB6440.apcprd02.prod.outlook.com (2603:1096:990:13::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Wed, 8 Jul
 2026 15:00:59 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0181.014; Wed, 8 Jul 2026
 15:00:58 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair@alistair23.me>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4] docs/devel: Document SSI dummy-cycle ownership
Date: Wed,  8 Jul 2026 23:00:38 +0800
Message-Id: <20260708150038.46113-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SE2P216CA0090.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c2::13) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|JH0PR02MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: adc23088-39e9-46c8-2fee-08dedd01b799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|34096008|56012099006|3023799007|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: mopqCd1YWsAB7TYMa6N/0baibIMmAEeB7EQehQ4NtdWhyVF7om+KNfRGCh/E1MSzuZZPqPv4el8DFUAzPmeSoBYP4SJpeiRMCVct4Ecv5cuX4iMvePBiZaOvOcCbdoRzlJ1KLvhzlNYb5XUDtZ23dNAVd5pQIh/tbsjlZKaT5cMIgz0NPpnmC9VhgumfOJfL/ZTJiFNRrVXjylq+YocecFVm3Y4uF5o/T9feO/AiM4wK5prM523o9nRYfegK3uCbedbGFvuBUzE25Gek9tpIItgysdrCqieK1ZlY/oEEEur+y1ZjpHhCgW286vLq3XiPTZtVuO35IzscCednHSabmM6judB5BE7yqLNAaKYU/m6rCZiBiZaKgWmKJ3MdavTnH6sd1TC26d9/b314PkcnNoITgMs4KyzZHl9rn0E0arArTjU43L+7TlKBG6Cbw3ZMD/au5GzT3TARdxn4eB4cvWcm5ineifJTFjH2YclFstJ3SwIHDEE3inWUYp0a3KCHRyvl9eokCBoU8Kx2hKeskSXjm+L7aJk51LGN1P9R7TxsIRIfcFIVCRvYTTZP43Cc0kgRE1ZhBVSYcdUq5wN3eu0cdis6FxT17FmsL+NdCcXKw48qydVI/6OJKNuDnVw8+XpQqLJWb6tje+fnlcXJy55UWbskyAHZ4dQSZBs/0hc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(34096008)(56012099006)(3023799007)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVA2TVhSRXE1bGJBQ2FlM0pVOEVHQmFWbHZVQkVCeEdFTm5yb1ZqakpCSWpq?=
 =?utf-8?B?S3psY0F6TlRFRzE3dVVCblA5SWE5M2pwMXRJeWw3NzZkYVVpbXVOWUFxWW0w?=
 =?utf-8?B?Zk5SYlVXZk51SDdBZkZvTGYrSU9keUk4SWwrSzJ0UC9TSmx3SDdFbVQxV1Fv?=
 =?utf-8?B?Z2dwMjQ5Tyt2SXhBUURwOWRkRkZwZGMyNXQrdWpKRlFPRUxoVjlldG9PV1d5?=
 =?utf-8?B?dENPaXZuclhrS3dsUmxoOG5xbFJxVHBqMDczSU1ZZVZTV1EraUtjUWZsaEZL?=
 =?utf-8?B?NjZnRzhIVDlFeXErcHpZam5hR09WbE9pRFBkTWRNV0tDZ2x2YnZIUDFpVXRT?=
 =?utf-8?B?bGxiM1lrMWZJU0Z5aEU3UEYzendiZGZSY3cyN010VFNzQ0YwTEpubHJ6QmJv?=
 =?utf-8?B?OUZVajdZK0ZzeFhTeUNDUmErY1plbnVHL3RSSUowcUxGY2JtdU5vS3AzelJK?=
 =?utf-8?B?eTEveGVEMWQ3SVNOaTNpSitSU1l0dkhPZHdYTW5vOXU1VU9qS3VKcnhxL2Fj?=
 =?utf-8?B?TUZicnk4azIyNG1ybngvQ0U4bDUwdzd5ZXFZNXpITFJGcFpxdm4yZkVSeUU5?=
 =?utf-8?B?V0IrTHhJbmVLRGY5bXRBakszVXFKOHJJcU95L0RIT1F1eGxjRlJoYVhraTcw?=
 =?utf-8?B?dW1veUZ0VEU5d2JMSHBiUXFGT1ZFVE5BV2lqQm5GRXNUeFRIMGFvY29JRFdx?=
 =?utf-8?B?QjhoZ2lYUTh6MW1zV2Y2ejliYncwZUhhNDFiMUhSejJWVWtmNkVSYlVJdVh6?=
 =?utf-8?B?cnltUDdSZkorRzZVaFFDclprdkhpSnY5VDh2WE5UR2hQVnhNTkdJVitwOWR5?=
 =?utf-8?B?cnRTRFBwWnAvS3RURHZPM0NLTFR3TjVHR1FsRlhyQUZ1WjB0QWhOR0E3djBo?=
 =?utf-8?B?SVhQZ3RDdHdLdU9ZaHJ3SjY1dThneW5JRHQyT3Rta0FOcVpwdXY5SmtQUzAx?=
 =?utf-8?B?bTM0T2tScUZySzhUUHJmdUVMc3A2RUxITzV3eDJwNHlSSmt3WGlkQm4zVEND?=
 =?utf-8?B?WFIrdXRhYVAwNmRpVWdXVkZHVWw4TVlBR3F2QUpseHJiRDF3SzY2RFNJdkZK?=
 =?utf-8?B?dHpOblFISjlLczRFMXJEWGRFZlZ5cURBL1NKQUlWQXNJUmh6UG84WGZMTTFM?=
 =?utf-8?B?RVBlZis0M1JKamI0Z25nTzdIY0MwQ3lJb2Vzc2M0dExoSnVIbDVkWGdKeVNa?=
 =?utf-8?B?ZUxPUDV3dS82WFdNV0lDZlNlejcrR3ZvZkpadHJLeGQrQTZsRDhxcmFhcktL?=
 =?utf-8?B?RjRRVVAxTEoyTDVucWFmZ3NGN0hNdHUwZ0RjUXZKVkNZMWxpbnBibldZblhY?=
 =?utf-8?B?T3NVS0h0VEJrb1RLSTRSeEFtb1pxeWFlTmlQY3JFZVJTVytSTEJQQUFOSU1t?=
 =?utf-8?B?VGN1SXFIQkFYL1haNG5Ua0RiYmxvK2pEY0MxN05HVGNuUHpXazRjaS9qRW1k?=
 =?utf-8?B?SzBmcXBQZTR6Y241UkRwTThJWm1rSm5lT25ib044QUxFK3ZLTmJSbEd5bFNR?=
 =?utf-8?B?Y1l6SCs0Nk8zYTBSNWhCR1JNOFhmM1FMdGtlQzNlcE0rczVRTGJTUlZiWWtr?=
 =?utf-8?B?alZxWHRRMDVMaEg3ZHJZZ01RdGhmN3RkRmk5Tnd5UFBISXd0RlpoVFRWRldH?=
 =?utf-8?B?Zk5GVjlGT3h6VmovUHJtWnRyZFBhWTF2czdJMU5FVkVlQm9pM3pSaUt2OStN?=
 =?utf-8?B?eGIydjh2QTRjbFgwOEVSZndGdlRaUDk1NGFWYzFhenFCU1RkWCsrYUhPclVv?=
 =?utf-8?B?QndBZURKYnR1a1RpMklINmJ3d2hlN1FjOGp4VldRSitYZjZtU0h2MFBNekNw?=
 =?utf-8?B?dnJaRC9wSHA2YzlDTXNDMkNwRktkWGxsaVBCVm84aGJoQUJ5WnduZmVwMitm?=
 =?utf-8?B?cXdlS0llU24yN3NSMXZpbnRvZEZWQ0VwaUk0Ykk1N01UYmlOZ2FqRW4zeU53?=
 =?utf-8?B?N0lYVjV2blR6L3I1bjVLb1BBYzgyYUxka0NBRlEvcTlZY00xMzM3RnFLRlJ4?=
 =?utf-8?B?RlVXc3AwaVJVSDRTdXRhWEpTWWUzdVU3QzRtS0RheThpYXZrdmdxMXhqdTlw?=
 =?utf-8?B?NDF1YTA5ZkZDZTlmbzRmK2tNb2hXZVZYVUh1U2ZwQUdlN1JGVmdaTFphVVZr?=
 =?utf-8?B?SEw3MFkvVWtNSFZuQzRndU84TGN2ZzMxaWdDdW1RQXdLU2NhYjBuYnlPVEJQ?=
 =?utf-8?B?b1p6dUJwNVZ0VjFZc1h3enludnpzYnl5OFJvNWlwekswU2xBVHo0NDB1bXJD?=
 =?utf-8?B?bUIzMnUvR1hPTi9zTFk4S0tHUDBzUWJRbS9lTU5JMnpuSDRBK2VCQnJyTmM1?=
 =?utf-8?B?eGY3N1U3QWpIbG4xMmUrN1F2M1AwWWRqdnhERFlKRnROZmE0N2lScUVEUTZU?=
 =?utf-8?Q?6UO7sBx6ezNycanQ=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adc23088-39e9-46c8-2fee-08dedd01b799
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 15:00:58.2365 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4gs9gQ6yuKl8mExgFyGkSFE9uUjKE74Lsi8g3YRNBNUsTUpVZ66XZ8jZ0Jbam2T58vXdvVZAjrq+a3V5MLRa/haw4GHngLP106bViJ5BQvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB6440
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

Document the boundary between SPI/SSI controller models and SPI flash
models when representing fast-read dummy cycles. It explains that
flash models own command semantics, while controllers own
hardware-generated dummy transfers and cycle-to-byte conversion.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

---

Changes in v4:
- fix checkpatch ssi.rst warning

Changes in v3:
- fix checkpatch MAINTAINERS warning

 MAINTAINERS                    |   1 +
 docs/devel/index-internals.rst |   1 +
 docs/devel/ssi.rst             | 134 +++++++++++++++++++++++++++++++++
 3 files changed, 136 insertions(+)
 create mode 100644 docs/devel/ssi.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 6171cc7494..77ca6e6c31 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2347,6 +2347,7 @@ T: git https://github.com/bonzini/qemu.git scsi-next
 SSI
 M: Alistair Francis <alistair@alistair23.me>
 S: Maintained
+F: docs/devel/ssi.rst
 F: hw/ssi/*
 F: hw/block/m25p80*
 F: include/hw/ssi/ssi.h
diff --git a/docs/devel/index-internals.rst b/docs/devel/index-internals.rst
index b89bab9b30..a8f5e310df 100644
--- a/docs/devel/index-internals.rst
+++ b/docs/devel/index-internals.rst
@@ -20,6 +20,7 @@ Details about QEMU's various subsystems including how to add features to them.
    reset
    s390-cpu-topology
    s390-dasd-ipl
+   ssi
    tracing
    uefi-vars
    vfio-iommufd
diff --git a/docs/devel/ssi.rst b/docs/devel/ssi.rst
new file mode 100644
index 0000000000..7475d7f241
--- /dev/null
+++ b/docs/devel/ssi.rst
@@ -0,0 +1,134 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+================================
+SSI devices and SPI flash models
+================================
+
+QEMU's Synchronous Serial Interface (SSI) bus models the full-duplex transfer
+of words between a controller and one selected peripheral. Most SPI flash
+models, including ``m25p80``, are attached to controllers through this bus.
+
+This page documents the expected boundary between a controller model and a
+flash model for SPI fast-read dummy cycles. The boundary is important because
+many real controllers expose dummy-cycle configuration in registers, while the
+flash model observes only the byte stream delivered through ``ssi_transfer()``.
+
+SSI transfer granularity
+------------------------
+
+``ssi_transfer()`` transfers one SSI word. Flash models that implement common
+SPI NOR command streams usually consume one 8-bit word at a time:
+
+* command opcode;
+* address bytes;
+* optional mode or continuous-read bytes;
+* dummy bytes;
+* data bytes.
+
+The SSI core does not model individual clock edges or the number of active SPI
+data lines. If a real transaction has a dummy phase expressed in clock cycles,
+the device model that generates transfers on the SSI bus must represent that
+phase as a number of dummy byte transfers.
+
+Flash model responsibilities
+----------------------------
+
+A SPI flash model owns the command semantics for the flash device:
+
+* which opcodes are recognized;
+* how many address bytes are required;
+* whether a command has mode bytes;
+* how many dummy bytes must be consumed before data can be returned;
+* manufacturer-specific differences in fast-read command behavior.
+
+For the ``m25p80`` model, ``needed_bytes`` is a byte count. It must not store
+raw dummy cycles. When a flash datasheet describes the dummy phase in cycles,
+the flash model converts the cycles to bytes using the bus width used for the
+dummy phase::
+
+    dummy_bytes = DIV_ROUND_UP(dummy_cycles * dummy_bus_width, 8)
+
+For SPI NOR fast-read commands modeled by ``m25p80``, the dummy phase follows
+the address phase width. For example, output-only dual and quad read commands
+such as DOR and QOR use one line for command, address, and dummy phases, then
+use two or four lines only for the data phase. Dual I/O and Quad I/O commands
+such as DIOR and QIOR use the wider bus for both address and dummy phases.
+
+If the exact dummy phase cannot be represented as a whole number of SSI byte
+transfers, the model should round up and log the limitation instead of silently
+treating cycles as bytes.
+
+Controller model responsibilities
+---------------------------------
+
+A controller model owns the behavior of the controller hardware:
+
+* how guest-visible registers select command, address width, bus width, and
+  dummy-cycle count;
+* whether the guest supplies dummy bytes in a transmit FIFO;
+* whether the controller itself generates the dummy phase for a memory-mapped,
+  direct-read, or other automatic transfer mode;
+* how chip-select state changes around controller-generated transfers.
+
+When guest software writes dummy bytes into a transmit FIFO or manual transfer
+path, the controller should pass those bytes to ``ssi_transfer()`` like any
+other guest-provided byte. It should not add more dummy transfers on behalf of
+the flash.
+
+When hardware registers instruct the controller to generate a dummy phase, the
+controller must emit dummy byte transfers before data transfers reach the flash
+model. The controller should convert the configured cycle count using the bus
+width that the controller uses during the dummy phase. For example:
+
+* 8 dummy cycles on a single data line become 1 dummy byte;
+* 8 dummy cycles on two data lines become 2 dummy bytes;
+* 8 dummy cycles on four data lines become 4 dummy bytes.
+
+The controller should not duplicate flash-specific opcode tables merely to
+guess which commands need dummy cycles. In automatic modes the controller
+already has enough hardware configuration to know whether it must generate a
+dummy phase. In manual modes the guest-provided byte stream is authoritative.
+
+Avoiding double counting
+------------------------
+
+Exactly one side should generate each dummy byte transfer seen by the flash:
+
+* If the guest sends dummy bytes through the controller, the controller forwards
+  them and the flash consumes them.
+* If the guest programs a controller dummy-cycle register, the controller
+  converts those cycles to dummy byte transfers and the flash consumes them.
+* The flash may know that a command requires dummy bytes, but it does not create
+  transfers on the SSI bus.
+
+Do not implement controller-side snooping that watches manual-mode opcode
+streams and injects extra dummy transfers based on flash opcodes. That mixes
+flash command semantics into the controller and is fragile when flash models
+gain correct dummy-byte accounting.
+
+Examples in the tree
+--------------------
+
+The following models illustrate the boundary:
+
+* ``hw/block/m25p80.c`` keeps fast-read dummy requirements as byte counts in
+  ``needed_bytes``. Manufacturer-specific helpers convert datasheet dummy
+  cycles to the byte stream expected by the model.
+* ``hw/ssi/aspeed_smc.c`` generates dummy byte transfers for direct fast-read
+  mode from controller registers, but manual user-mode writes are forwarded as
+  guest-provided bytes.
+* ``hw/ssi/npcm7xx_fiu.c`` converts the direct-read dummy configuration to the
+  number of dummy byte transfers sent before reading data.
+
+Review checklist
+----------------
+
+When adding or changing a SPI flash controller or flash model, check:
+
+* Are dummy counts stored in byte units when they drive flash state machines?
+* If a hardware register stores cycles, is the conversion to bytes based on the
+  bus width of the dummy phase?
+* Are manual guest-provided dummy bytes forwarded without extra injection?
+* Are automatic controller-generated dummy phases modeled by the controller?
+* Is flash-specific opcode knowledge kept in the flash model rather than copied
+  into controller snooping paths?
-- 
2.34.1


