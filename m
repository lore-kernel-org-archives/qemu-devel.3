Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91AB6CC6B19
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 01:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGnlG-0008GX-PB; Tue, 13 Oct 2026 21:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnjr-0005tq-32; Tue, 13 Oct 2026 21:25:10 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnjo-0006wT-NF; Tue, 13 Oct 2026 21:25:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zc4goPg2EYAYF8UUA3Co/eTb5J8cJ0u6qlEKNCDs+cdEegn8rU2L6qbE1Z96zO5GhJrothYmOkNG30hXta07uFhLdvmMkqw5yIi82umsZgf1bp8GEB2GKTUfYJ8j0SFdo1UUVRNgFdOSvdi8SuJlVIeHGniT240rL6vHse9GMIAInoFOgls3OW8UZUhNuot+3bUzPQvogRKBtPVT/N4pEFIosGK/ftzb4zeNSvZ7Sf4Rb+Ie2LXu3OT64MM/Yl3ywqF/ChHE3HkMAGl6zCRinhU/wQPedv5TGVKVqs4iLIo1mKqa2XzvKFIA4i+sFaoA1Bdf2y5SDi7JMkt+zenVrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7Pt0G7M57nqYiigc/P1FRrS+xjJh6M4kU6I/uTIWMQ=;
 b=SOh77YPPNrS4oOhgn2hBsMWlM9Kp3Wf1ESx/k7zqypNWCJIjqTha4XjR5OmyL8bi6yy0q63m9/vmp7kpnT3hPEH8Bw2G/EnkThZKwASC9PCx2UUUlkZnk9MQF004SM9s5O0nAOdGzWS9uh3cChAPC9yGMUgv7qd24D169g6FoRGpkaSKx8sM1Ud4i1uIo0ufThw3xk5MtifOOsn1UQehNkP0zQairdISKdodBsppktvJPtrx725sNi9s1TFYemxIIRF8LcS5cjHv169AquhE/UdE3pkVPT/Cf9Y877UjQ9hkYwuuNNIGxWMVO5yAVBnlxWA3d7dt52tG7FbtYQV+EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7Pt0G7M57nqYiigc/P1FRrS+xjJh6M4kU6I/uTIWMQ=;
 b=PWO/jTJCDCbCKnL2FGtX0bONEsxv0h31rU+4/lRapicdgv5LtsJfdoZSRFpFyOA4W5b0SGUaH7+shkLvNPl+KJKo4oka7gUNDbpwgRf+kcbzBe6veKIw/xCkS7vIC/ykd3s6mrVsXlHfvPAItLNZzc/UvSm1K4QwadhWSCNxVUZIL4O/MsXlM3JYWZfymxA0Fmo/j4zYx2AJ7cHlFzxZTGpRPiiIN3aIJpFc5yyNe834T3WlC3ZYIDxCcXWpM0H31cySYlz6pH+shcFHj3P3GGjA6XWfITzsYrjmzmhsZZuwl5By1pTMMRyUt7jmJ6BJFsPB8WWDmnmkoz7JKiWlxw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYZPR02MB6222.apcprd02.prod.outlook.com (2603:1096:400:282::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 01:24:52 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 01:24:52 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
Subject: [PATCH v4 24/27] docs/system/riscv: pfsoc: Document CLINT topology
 for direct Linux boot
Date: Wed, 14 Oct 2026 09:23:04 +0800
Message-ID: <20261014012323.322790-25-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014012323.322790-1-bin.meng@processmission.com>
References: <20261014012323.322790-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6PR01CA0005.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::12) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TYZPR02MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: 1449a15b-fe65-4474-59aa-08df2991f219
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|10067099003|261009223027099003|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: BPNtp4CYsR55Tgk1jGgBQkTzALf9SRsYdu1DVCLfX+ZAg3VmLlHZU66pIiTe8xHfG+6OuGXJix4i4gE9mrrsh1b3JSP0k4YwLd73/dViq67WGz+j5o3u3zZL+5pwbnyaTtUsvDi9RkFB/uML2IRkPml19Y726Dg98lgPQNK6KPbatTiqhn6dwDFIhtsaeZ0dSSnFcV1XDjU2KNwoFYfhrPMQ4RoS9aoKr6rI64IM5hBTHMvlgvlCD+LCf+BDBo8y/PK/RZwXB4VoOmY1w3uETd5MamNDYSBlvxiEitQ9/sSGrCnSKdY5Q4599kL5xg8acGEi+QK9kV3Q36o2wDThkyll6jFPJH7oNirpPr7IPsBSsj9x+2ljn/88E4QoVcEQmaHGw26jx4IcUpk6iBVpXOZGqsfZd2tKpc2erU42uhyKAE8Io4eRa5xz9xTB6utMMIgRE6phxCnXs8sVLb3aQEZ3LfCkguPIB4qRxGP1wBxvmaiJIT9f0twzB6NFu0+ADOU8z62td9lVxx579XwooWx0My3do3ysqVSum5tjMgy3Por6tc+sjAr/XNmwhEDyeM9xnFD+6cDVdR0aH6h4uqn7SmYkWRJW0lhLiaQHU6eMDmUwAdXlcm+7+aDPGc+RbLh9NFjRd5I/+T/6LjpWjARgGLBdu/UaWNmO+qQpd7A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(261009223027099003)(5023799004)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vP7IW+IrChQcOVdxxP0K/THA6pxuvrcz3ronT40/pM9xX8mU7kYbM1ZGnqeU?=
 =?us-ascii?Q?RiPal5+db7vXYpTlk6YUAnNzVFjaO966pcHnn6X6q2EfV4ghKb8Q3BTU9m38?=
 =?us-ascii?Q?pLaIPP4rORB8IT34r860Mv4xFG7yP3pH0tPGUauQjdVdB1SySOMyMB/20I6H?=
 =?us-ascii?Q?q1BaDYLRQ7La7CnMDQPJ1/5OMrX08E+L8Jr6btTRsuYzp2Bt/jSSfbkEK6SR?=
 =?us-ascii?Q?tNi3T+ut+E99iLD0dnyai/e4tV2QSxhwryHOJQ8gm6aEq5Vp/G4MvaenL2jo?=
 =?us-ascii?Q?x4qnK+985qPvL+juBFnBoTyYI9RbYO/9Pi02FrHiEcVvOP94C9xNaauLqkzZ?=
 =?us-ascii?Q?x0bLnWIxmwVNCgjI993s+QxIoAOfFRsICxUGVObKpvaWPGnuHK4/JvKzaJWZ?=
 =?us-ascii?Q?JCp0xvCdMN6gDTDr7FdXhngVzMgDwBI8twHMmDPFTsigXqPY3rX5vQHUtX+t?=
 =?us-ascii?Q?yXvmzVk7jBrEYVx1SD52HYYrKSe4AFrEJrGOOENy/PaM1f8eYO4pePtpHaFy?=
 =?us-ascii?Q?lqJXWuxw0c4sbAs/7OJm+RfmcZmOh6dxELS7VcScWDNN3feY2ledylJEpMam?=
 =?us-ascii?Q?eMljqM4wXjzJrrMo5Gc1NP/HBSVsGC1BYOH8MRmFzmldq69WvgyTVeHnFaJX?=
 =?us-ascii?Q?WwLbpp5mkar9f5T0kimGkuE26a5GwJkO275P+Tluc7kojF5kUsCHAA/8MJ/K?=
 =?us-ascii?Q?0VlDnuAnPH1j6+hfHmAqy0acyTER6OxNhhlnDtWEyHBvA1xVF/eJvF8oSDN8?=
 =?us-ascii?Q?/VrHJZHROE8UaFOWYnlBFgmnbFN1FPvjiUtY3aEVbkBHttZpC76o4TROntu9?=
 =?us-ascii?Q?iQmfATjGPwkuNOcuHtpTpUMmE+sDgh+8TZZC2VU4ZFDZoaje26FH1gv1JN89?=
 =?us-ascii?Q?Xh0UsHGs5ool2/Qm/xcbhl7XFk0CdGJvxUwQCBsFha9L3M+pPoZ4nMphw1gB?=
 =?us-ascii?Q?VWIS5EdCcxYPDc83AEiywz9h15LsZGwKBx3K8SAC2aRm+hSuVksk8gv0JQne?=
 =?us-ascii?Q?UIFa0+8QUo+35Vk7JvkTINmRDV7xZxMPdFP3I/W4r+1Kwr0aJVKRKBlDnPBN?=
 =?us-ascii?Q?CYBXkp35mJwYBlIaE/oTHbQpIRpwbaQi4VTYBBTkASwaj5CQ/I0bML3MA9Ru?=
 =?us-ascii?Q?YyZaArbkdEpvS1gc0Q7gPkT+OVyFX7jNz0lEQEE1KGX2uiFt1tYgdJoTkm6w?=
 =?us-ascii?Q?1w6lWZ9iQjBmlYYcARsXbT84K3P1O9OQkbWZmhC08ciDxYKtr3vqIOFhCZvt?=
 =?us-ascii?Q?Z/XSrdilCrdGGaEpgAuV5BoFkSza2VawiNJ51dDDb6qdIj7GtP+EEXtZsxhN?=
 =?us-ascii?Q?rO09sE/9iSTeMlf7EItYtf6R2t3UycnrloNBmNVIZUhXP2rHKfho9wECoCzI?=
 =?us-ascii?Q?PhKCliPMVqOZod8txCo4QVhOWVqZTQUisVihKInJZjHZyDgdOVfYmzb6HXWj?=
 =?us-ascii?Q?Aj283YavsJXIVJ9RaJ/xz+3DhRcgu5+v4SufQbjpa6sDguTh/XjWsULV9hQX?=
 =?us-ascii?Q?u0C2QJD527tcLNz1LFfZd2iwSaMc4AOHOdnA8w6ETON70l1GdifQNaujgGfd?=
 =?us-ascii?Q?fniFO2tzldnA0611g8OYbQdjlzBk9u2Rf2NybvhkyMB20V+6HS1hN4ib8yJh?=
 =?us-ascii?Q?FnhwW3YoZzDO1TL2EKcTPYRbjeg0mihbYfTWwuOMMK97pOJCVS41h2yqhfzs?=
 =?us-ascii?Q?vKhvewRppuG81UKWyx+Y96rql4I84fRe+wy009BtC3zjTqFDwpsdCLOQ2Avc?=
 =?us-ascii?Q?9SPQGvTs70qTgqgoAzSwyU/gQAuuMAE=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1449a15b-fe65-4474-59aa-08df2991f219
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 01:24:52.0126 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NEz5qLQtVXo3HhKgHGteHAb5/QnafIobgDiFWWl6hx+gBy3Ea1zP/fpd+2h0ivoz71nZeXVcYmieYjOV/AHdEvnNKxeyn7oOgEuSCRRV1V8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6222
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

The generic OpenSBI platform derives the CLINT first hart and register
slot count from interrupts-extended.  Some S-mode-only MPFS device trees
mask the E51 M-mode interrupt entries with 0xffffffff, which shifts the
MSIP and MTIMECMP slots when the same DTB is used for direct boot.

Document the complete five-hart CLINT node. Require interrupts 3 and 7
for hart 0 as well as the U54 harts.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

(no changes since v3)

Changes in v3:
- Explain how reduced hart topologies change the CLINT DTB tuples

 docs/system/riscv/microchip-icicle-kit.rst | 26 +++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/docs/system/riscv/microchip-icicle-kit.rst b/docs/system/riscv/microchip-icicle-kit.rst
index 2159e8e461..038ea7221f 100644
--- a/docs/system/riscv/microchip-icicle-kit.rst
+++ b/docs/system/riscv/microchip-icicle-kit.rst
@@ -66,7 +66,31 @@ should meet the following requirements:
   option.
 
 * It should contain a node for the CLINT device with a compatible string
-  "riscv,clint0".
+  "riscv,clint0" or "sifive,clint0".  Its ``interrupts-extended`` property
+  must describe the M-mode software interrupt (3) and timer interrupt (7) for
+  every hart, including the E51 hart 0.
+
+For example, the default five-hart Icicle Kit CLINT node can be described as:
+
+.. code-block:: none
+
+    clint: clint@2000000 {
+        compatible = "sifive,fu540-c000-clint", "sifive,clint0";
+        reg = <0x0 0x2000000 0x0 0xc000>;
+        interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>,
+                              <&cpu1_intc 3>, <&cpu1_intc 7>,
+                              <&cpu2_intc 3>, <&cpu2_intc 7>,
+                              <&cpu3_intc 3>, <&cpu3_intc 7>,
+                              <&cpu4_intc 3>, <&cpu4_intc 7>;
+    };
+
+When selecting fewer harts with ``-smp``, remove the absent hart nodes and their
+CLINT interrupt tuples from the DTB while retaining the E51 hart 0 entries.
+
+Do not replace the hart 0 interrupt numbers with ``0xffffffff`` when the same
+DTB is used to initialize the generic OpenSBI platform.  OpenSBI derives the
+first hart and the number of CLINT register slots from these interrupt tuples;
+masking hart 0 would shift the per-hart MSIP and MTIMECMP register mappings.
 
 When ``-bios`` is not specified or set to ``default``, the OpenSBI
 ``fw_dynamic`` BIOS image for the ``generic`` platform is used to boot an
-- 
2.53.0


