Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19FEC43602
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 13:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weYz9-000282-42; Tue, 30 Jun 2026 09:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1weYyt-00023y-Bw
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 09:58:32 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1weYyr-00040A-1r
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 09:58:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OgpRrTjlyu55rUKOj7aobGJWeFHOSXwgSHVYFvIsnjaxy4H5/0b2f5TzgMsliYOlsBKnkpCHABzs8WEnqrBwjvijePLu1bK0MPcFkdVWF395n163Y6j3tj2wpR69Of6p40CY+B/QZ4yblA8CyCUIab8rWWeY59DrYLFt38UAYnOz8L4at9spV7lcpxJgYYc/h/lR59Qcl1vfo5B/75GVfVs156l7NUuAABiRDV+wgY0bFcgqRmC3xHd2XyCOh2WaiZ7jhP1Xx7aDc4mNnqyF8qSqB8wRc6mn0nPc4S7OsrcHcN9lVi4ega/0N62h9vKJST9CJtraRyKVV560x+6Xrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksUkVinOTOjeo50pPGA0fWpcnbrzHI0E555tMPtXK9c=;
 b=Q7lMzaah7J011hHiZiOWcWaHKmC0p9RXyuNAxP/GaHRMJhHOo8d65FYq046t5QJ2ex5x0qqIusOo3o2cYFNP2b1JTC5Is/orBGaY6/MY1Vsfdr6KnzEq2LzxCVWeweEdd8PuArfFkAR0475xxoCC4mIQeT909Xhon+5FN1QqSH4W/yYdkQz6afxP8KDh64+D5r6ivoQA1Wu/ISZWVQnLpFCeFdxqWKFRoR/7liO9t7Dv7Q9L0s6elbTotnLBfmMQgVMhBIGlY69Pqgq/UK8cZ/+l2s8aASZB6n/2m++5OmwQpFLHneHiiwhUXAj/ElB64mzHu7xpUtWxw2noZaE0sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksUkVinOTOjeo50pPGA0fWpcnbrzHI0E555tMPtXK9c=;
 b=Sfjh1WD68cAGpyppaTCLQnWn9mOTliGUSssZWtJ7UP4dhRTCY9p3KRqNRlX/p3ycx7mabf+a0OGIwMP50eggevb2TE8vn5L8x2DH7ht6N2f1JWb37sEFYMTUiN1cFaAXm09Qw95Yf/2ecMUUI+yarcrayV8+AuHr9igiHhlG4cfDvy0fmVVVyO4iX0mv6tZFXhKTMt0xud4LCQ8OkYi1EO0BPWHQFhsAU+RkawTonF5yl+nGPrymJbMkG56x83JDRaTyHzp6xBCTfCCDlSZ5FOZfTovXMMT62eeiaCVQ+eOiSJ213f0r+TYAG00wO6zaTvgt9oNtpBT+CotUUF4pgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYPPR02MB8959.apcprd02.prod.outlook.com (2603:1096:405:382::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 13:58:18 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 13:58:18 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 10/10] docs/devel: Document SSI dummy-cycle ownership
Date: Tue, 30 Jun 2026 21:57:29 +0800
Message-Id: <20260630135729.466264-11-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: df028f6a-667d-4076-88f3-08ded6afa36c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|34096008|23010399003|3023799007|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 7mtaIPR6/sVLIFRSVP0LJySb/zNeA4xKnT0RJwZ9+teo6tbufhUZwmTQn0PgLTRB+X3FfI8MlDd+Guw3+5nnHFIHKmNevyjr02s3A2FyMbnjaJZNOiuKgRARLZuumbY8yGvjD8IBHzu1UeBW9KkyS+WPgfcKCPxcRpyK/5khr4DcvAPLUqAbSVJvoYJk577XHLXDQo9drHkCGeWfiSNtJuolohXuD19t5+6eA6g0bHPBmYjTuXoZq/Kafb9rnXZelmgrBVLrwpMJnlx6Bp8UMBVP+ijIE80kcCwKupzL8CrIbaKmqCMw+KjwqUqV22ui41WPeaU5pVjvkhy44XiG1sJpH4oHIMGA/0RmwpzuQuf7lcvrW8mIfOn1PuMKW9TPRSZieg8LEcWXQDsjL9KFuJijJMOE9fKoA2i3DMEtQl+aTMzVHptriaD9LUAl2NHIBQYvG8kxx9qydfo0ArAXcb4fK84h1jEZHdPRyF/VkMrAg9zkLrip5dByiGSqPhAOTpyU/HSbFzOhnMA7Va/OLQFJeufJ+Yrm5vZt9kFCeyK/hvNwz+u8rDaYdqlxCaHzN0Nc7qBq0wLpacaAC9OLE3u0ya1w0zJVzzqptiE9+fnXIWdR4d5WxSgouDaD6HYkOB4ADcG12AwoOJnCd49Dag4rLYlnDzZaSDRzR2LjN9s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(34096008)(23010399003)(3023799007)(6133799003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DAeVtRzAZ1jOSwsfAmvj2WfxMRXJNgfliq/nehigQdCBLKtinFeiwSpYVARd?=
 =?us-ascii?Q?nZNKggT/RlbBBj2YmaiONUKmbn4CKGUUOinItiJFa9Rm+3Xdy2Y8S3IXk61c?=
 =?us-ascii?Q?gGG3rgJmQQ2J/zvsT1gRU06T0RGOm+AZFjAL5Hw7VJSdXdDJANONQVK7yQxJ?=
 =?us-ascii?Q?4+44r1o1mmNOn39gqInTmY68L604Ke6XplrOqvERnXXpa2MWJNO3IQXDMnw0?=
 =?us-ascii?Q?ynH3qNQq3OsCgf/g3HxZIgXmYz5wKtvMYnpt7Npa4hmkd/DJYLR1r1c/jgWy?=
 =?us-ascii?Q?fjawuscbohnvQUI0dBejIJrF1cRJtFzkwUIqh1g/j8ffpfie45F4OqTR2k4A?=
 =?us-ascii?Q?nqRJTaEDynN1lh3QfOn7jKWQWQN1+zf1gY9pLu/NvJA7rPXdeIX4M6zQyX18?=
 =?us-ascii?Q?2R9P3wBUBwjd7YKT0BvUhEVS5eyyd6Gwz0mi+pSkLM11gIoJTtsNX7VjtAUN?=
 =?us-ascii?Q?uscJyKAIQuY9U3yY+C6wNbBunyoQ1n3EEryoNPU84r6+Aa4qslhetG4+gMB3?=
 =?us-ascii?Q?2FVccD3NkN8yPZNHWRfZQxN4n83XXRhyUpd6HlubEDRp+pAnfohWGqHednG6?=
 =?us-ascii?Q?NdDFZhf3J2NoKQjUpH++qzjp/oiLXeboiZsx3NhbkzrXJwv5ogMHb55Th8zI?=
 =?us-ascii?Q?ZPHmcJ7Q7VAULLV2w0qb7XSWii3raZOphKaDkSKRUMEqTJljLYoG6OwRicnX?=
 =?us-ascii?Q?kfaTz4xDVa16YmvxV7T7l1T9blaI6RDlrTYto9nRnNmypKx4HdQ+H9KniKlU?=
 =?us-ascii?Q?+W8WuULfI7ySubixWM2vznYRMmfqI5cxpsbjIpzV23I+aNM7h2x2j6nSpk7n?=
 =?us-ascii?Q?VE2m60mmZ6FVgN+K+8WaCu5HC2yCI6PMvwVJjsoskwD9nCw/m91Hw/jDLa35?=
 =?us-ascii?Q?ym9mqVbm3iuA4vScqfMGCPNpFOjd7HUPs/j3GtbuAGp/9bFdCKiQGMmEMus/?=
 =?us-ascii?Q?RUz/hU3gYDdsyw3o8PrT7ihp+8GhKXhSmkCqDdbzG1B39euvaSs+D4UlRlGd?=
 =?us-ascii?Q?tR2opf6JahWeufYdu7J36Tq45smjFKjmXPglQwatIaDt4Y63Z7SBxlWn5pI1?=
 =?us-ascii?Q?3fMNRRAGo4uf6P2ktkHcZg24+qrQ984fLtQ4krCwKzA/xnpl18dUdd9VUQev?=
 =?us-ascii?Q?uIHha7/c3VQ0pF6w7uau6N5SLc27uyzY4OchDjnNEVAIULPfhUPoeJFNmQLO?=
 =?us-ascii?Q?rAty8vqWC3jNu42ZJVkDnaqst7ZFjMnTUtIJfFEoCuN2LL2UVzLStO07Cj+5?=
 =?us-ascii?Q?o1BmFQ0bumfaUUoHI+/zFmynVtJsrw5dM2j1cyhMAIseOOL2p/dF7M98u7io?=
 =?us-ascii?Q?HbKNU8SOH6ssj6zV4kwVDg8Y21kCHEC2SoaIEivSXbFZ54yowG4l4tfF3kP/?=
 =?us-ascii?Q?K99aUc7qprGHLB/6Da0aNBRA0j41k0kW7jqupRcmUe4Qk5F85gs5CPMRfZHr?=
 =?us-ascii?Q?q1I38ierZHCbMkdI0mcqwSexbvJ6+2oUtCx6AUYtXpTQUwm2oWiV5JYaWlrA?=
 =?us-ascii?Q?WrSi1CZRiUu2VVPR4SQhStDiSrCOYz5+5yvsBGbwJjAKVZzS0IEmuYcu5ert?=
 =?us-ascii?Q?zCNSVzMGqW80E3R+wnV8DrTDULE1i3b9SgdtyMxfuqmTPWBwoDYSsQFaZfv3?=
 =?us-ascii?Q?mRj12QoHGHJXrAN2fH3LbIw6w7QhfD+OoLvPkhakBmaGRQOeBHV1pem1YHJe?=
 =?us-ascii?Q?F9INmLOoU8RW9InjHYkDkwQtY2QSlScwE4pQ6km46bLpfEWJeAteyVW07wCd?=
 =?us-ascii?Q?V9r5bqSUDfj90bseBLdUhDbvsRLBwD0=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df028f6a-667d-4076-88f3-08ded6afa36c
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 13:58:18.4249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9nWQCtQeKkwdGcQlNK0UH9PUJCIYoRgrUQ6CwClLy5Hg4Iy22IiOTZ5/uskNX8rqBuS0nvvvGQfov8DFsZc+xBVxRbqBH5BGKTBSJgebPVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR02MB8959
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=bin.meng@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

---

 docs/devel/index-internals.rst |   1 +
 docs/devel/ssi.rst             | 132 +++++++++++++++++++++++++++++++++
 2 files changed, 133 insertions(+)
 create mode 100644 docs/devel/ssi.rst

diff --git a/docs/devel/index-internals.rst b/docs/devel/index-internals.rst
index 198f155247..3a428b3c5f 100644
--- a/docs/devel/index-internals.rst
+++ b/docs/devel/index-internals.rst
@@ -19,6 +19,7 @@ Details about QEMU's various subsystems including how to add features to them.
    reset
    s390-cpu-topology
    s390-dasd-ipl
+   ssi
    tracing
    uefi-vars
    vfio-iommufd
diff --git a/docs/devel/ssi.rst b/docs/devel/ssi.rst
new file mode 100644
index 0000000000..864b5d9320
--- /dev/null
+++ b/docs/devel/ssi.rst
@@ -0,0 +1,132 @@
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


