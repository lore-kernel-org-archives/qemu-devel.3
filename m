Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BE4606D827
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=HmOh6jS6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOdA1-0003RF-8z; Wed, 04 Nov 2026 10:44:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd9e-0002eG-0B; Wed, 04 Nov 2026 10:44:06 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd9c-0001J5-Gk; Wed, 04 Nov 2026 10:44:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFY88BRI5Epooy83U5EspNzwFtQLiIZI+eYEN1guLY75PJUKf9bcbFq/yscwlF9rflZ//6GjrIK8C75+21JowHK8qEgbo7tFL5PHngT80OyOeQx6leargIqIMrWlKNG203m3wfC8YTrkz0Zo/aUd1kn5S+R7TQxmWT+hh5dWukHSwM4df8gpU7lNhztF25lE7ATIS+K6h+etAh9Bop8Zh9utzeFYAImreD0fE+TFAyJv8yjiFW6PY9AffbD3FOKWtIzquJEExa/aROU+p4yL8DgnrY0ktmsP2ZnKFyRmjY2QqU84UqGje/SubRmL4xqzLvfputVjbiyr/pTEwIpS5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7Pt0G7M57nqYiigc/P1FRrS+xjJh6M4kU6I/uTIWMQ=;
 b=rZCwaMUUwkApzYQsZWm5bztdHr4dXtIOT0eHf6D/XgClZpImM2eKqqotX59D5/tPX4sZZzNBDaw6TUgPxSuyZmYokuIRu/IXcozqna2twLamHVV8rI0d+nFUw6DMuNzNQVWl655L72PKIaCpxAIBodClx60LS70SzwNm+sKztpeqtl7UgsIFAYzDRuanhPktavuuNEGM8vtOUI8W1ftl9QLOX6WUurCeVTUtzduKU5EaFZv4p29chlzAoUGal83HSE7z83KmGbhQu/2jKvynZ5dEGghmG3pHCsnnXhJ3mdpNWPERkBRLH3+p18HNnhhCufhW++MQDdmzAtYOBeJiFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7Pt0G7M57nqYiigc/P1FRrS+xjJh6M4kU6I/uTIWMQ=;
 b=HmOh6jS6S5h7TwD4PEAw2njeYC5/RCvnouSe+Ea2OHOkFZQH/Kx8LgfXlgi/3ok08LZzRvrBPBzxasb8AXoVNg0n4OEQwKnPgbdr/C6uSCQx41z+xipsVR9hdpwHZ+AlvtVVjcCjAI3StXRpGL5vJ01TIJhNNTzwfoUn83Vq9qyjyJvzYrbjAXCseO5AR2/OToayLtDVgLsZtX6UYgsZdN1jlkHWo/9dD92eHB28jJ+mXXyH6wRnsLKFkN6kEevzTdwR06s+6BZUT14fuiGsPNeF3za9iqc0qdBwnqk1ZTV6br0B5jKhMtXApBiRUSxwibD3Me/wvObq7DScYmXg1g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by SEZPR02MB7162.apcprd02.prod.outlook.com (2603:1096:101:190::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 15:43:08 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 15:43:08 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
Subject: [PATCH v5 23/26] docs/system/riscv: pfsoc: Document CLINT topology
 for direct Linux boot
Date: Wed,  4 Nov 2026 23:41:50 +0800
Message-ID: <20261104154207.641511-24-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104154207.641511-1-bin.meng@processmission.com>
References: <20261104154207.641511-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0056.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::16) To TYZPR02MB7121.apcprd02.prod.outlook.com
 (2603:1096:405:2c::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|SEZPR02MB7162:EE_
X-MS-Office365-Filtering-Correlation-Id: 416d87a3-0f4d-46c7-6f51-08df3a8a5327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|5023799004|56012099006|261022105027099003|261021121427099003|261009223027099003|261021123027099003|261022075727099003|261022115727099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: a4R/lKdh91vELppSEI1Lw23Y+VE5paMZswpuNEAO8FOUByQUGZ/V4Mwdxj3LWdXGRO6ZpnLAxpfXJtTME1C2NfekgHD/4c0+qijGXN3zUj12QTSK2xY7RGYbn3OwEoM2lecd4QkNEXsUWMPxsimtFUcjChztouSZj2atFa7j+l6WfEJtvf9uJlt1uQyqUebe+xxUzslw8KoZSWnGgD9n9Ip9DVO/q+RenI1VqbTxM2vh/3nJCKSe6RUpZGQajcHDQ3ro1QbEtO1etgUuHky6AVVIZ5uLAhzNSqGaUgSuUiZAW5mXLam5M2fF6HvbdpVbVsUoz58ThqjWdhLmjx4DbFTZ9op7FI1QAznkrGyTGMyyTTOIUBzLi7UtEErITCNogCNjheIn7+jcoEyRu4AuYlizwUvD/daHcya0g7CsbBcpvmMLO4Z0P3RXnTcWTs3zjIdPrSmSJyIWuxOx3Hy1kO5P81di7ioNySFplLtQfDs7IR/LIUCrwbUC90HuS8yEAc+rOVKBIJQq8btanFnSji2EhPasOex3ri9xduz9ubLJUExe0hBiKhcyyNL1W2Sv9Y9ZpRjKaYhI/jMjlW9ozMn6gL+b7BS9ANm1ymnUx6Vww7wC/NCxd24Wh9ms7ZBf35Y3Aoy7hlaPDExz4YZCfGjscOpa18nHbIkj83sR0R0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(5023799004)(56012099006)(261022105027099003)(261021121427099003)(261009223027099003)(261021123027099003)(261022075727099003)(261022115727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ku57lB6j28DIOW1XVz8WI/XeZJi/ZuHidVsGC038UmNJJo9C6fxUsKRXL7TU?=
 =?us-ascii?Q?YzEyTbMCJEik42+G53k8oqm0eEbrYqrDsRbWEP4VGYH/KMRRQV6juqYjCfJ7?=
 =?us-ascii?Q?tmApuPsysR8D9ny1OolYPET7usso+sRletelhjVtihYVRIKXgjHcYzD2nU9h?=
 =?us-ascii?Q?Hgu8FepN5UG21TX3ATPFWEAdnAtEUoiuxTEl0g8HQR7ODz5os000uGpZzXzJ?=
 =?us-ascii?Q?kRedjHWeMmU7Yoi+HlsIYZvN6C63MQkFhsM30bTMg0sUi0tY8pBeoG2WdtBo?=
 =?us-ascii?Q?jS8J2gBHncrQ0MQPpgC4H2ccyC+7StTPTvuHNAtrXyyLTAowUQeQvHcgOcsP?=
 =?us-ascii?Q?Fwe7/mPh2xcZMn3t249F4I4KG4ljm3jy30hZ8bXhkiG4XhFx4thEsbBB8qWF?=
 =?us-ascii?Q?6Yp2pgWklozhlg991urTP4gv3CM2tIwuWgbVhQpe4/WN5YJTzd7w+vkwXOEL?=
 =?us-ascii?Q?Aq58ngPAPazqk4L8vYTkpUbSMmdWW4pBlY8dfo3b/r+JLnCiC4K5KYxydpsP?=
 =?us-ascii?Q?tvgBZCPIPMuhIohSHCjIK4bZth6rn9C0p+7wISHQmXkJdlPG1wygNM4G2dHA?=
 =?us-ascii?Q?Jsm8WggpXt142eIxZS4jyT6uPA1U4RqNrxjIFcVn/P2QE9neDYp8pBNoqaH6?=
 =?us-ascii?Q?pxuUH0iUnisMZduOjUTB1707a1x1wXJdT60wKO2aX6f6f4vq05PiM16XwqG5?=
 =?us-ascii?Q?PDTtgyDMQ0duS1/euqs4mAvm/gBpf+rPGfHoPyqqaYi9UoCW0f3/ajrn38Kb?=
 =?us-ascii?Q?gIEylYBiJTbkjhjgbGzQuHStDHHY161Can5YhTf4rlwTuC1Y/ah9x0jJjrhO?=
 =?us-ascii?Q?myVjZbBK7mHnDYRcM9YDlH09DRpalcicFofV5L5qbhVkhJHYIHMpeNEfMwDR?=
 =?us-ascii?Q?fwFMSlzn5bsM+b+aPVrjkwVxa4shbDqOLAQp0uM4aM85MsR3n3DlUbnIrc0L?=
 =?us-ascii?Q?9mBG608ARl7qlv8vWvrrfPuBJ9P6Pog0c696B7gCu6LEgyWSRHuaCpVCXCLx?=
 =?us-ascii?Q?a5a5gM1/1qr/+8txwymeJldhJ8Lf8g94zauKAeXo9l7TWXqj/MnZvxYQCVKF?=
 =?us-ascii?Q?Y+WH7tI7vno1tTbiFHzjH835rk/cm/O6j4zGGruldJxVOC+Fl96wC6bWp2Kv?=
 =?us-ascii?Q?W1Rv82ktQ7xqCDXgIBxbZpPQpUpDlKxbktF/fEJfA/JHmsEqd3TXehXJH02O?=
 =?us-ascii?Q?iMpuNnTYeoQb9q7oUiR+Z+0h/id0D9f9nXwo55IjcubujnVvFsd52Dn6S6Ud?=
 =?us-ascii?Q?3WxXNBhJj7qc6/rXBSRgwfCTZiOarW7K9d2cFC0DaIle31M4ZI8KevMnq19t?=
 =?us-ascii?Q?TWkHnos1Av35n20H8asr2gJ5PPhhWLm1f5TkO9fTRiZjfkZdVWZsdJdhFCLJ?=
 =?us-ascii?Q?NiMpo86VR28rXrD2l8XHKWs2M+O6QCb8pQfrNLGyAYLO0HyhaB3v+TO+OV7A?=
 =?us-ascii?Q?T8XccJgE4b5qRqHM/yu0/sDSrAWiMCfClRa8/XFMCpQnkuYHZAIO+rvYxMUQ?=
 =?us-ascii?Q?ADJr+yqx7GkgaL+Isoa5Gv/ORWVRyiv3Zb1I8QThX9FbXMHjqcExOr+D1FEM?=
 =?us-ascii?Q?7tKkUZbGNWOjAmLFjkO9IAsnHLHh/Y74telPIK/J5DGD4fhnAJG9xImHL5mv?=
 =?us-ascii?Q?C1ze6BGKziMoPznMv37hWwWhqjwwRLOnkHOmMouBTI6o4ya/pGrA+WIFzaeI?=
 =?us-ascii?Q?CSQ0pOpF+AbLqb9a376oKrfaj5/woLx4GZT5BTnBtPL4nRWeOCjIoQi/kCfR?=
 =?us-ascii?Q?khO276Xjsdae+Ks5vtVg2olVAdK0HfM=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 416d87a3-0f4d-46c7-6f51-08df3a8a5327
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:43:08.5737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZIriYwNsQ0kW8s4QVuiSAmyAcJfbZlCqXouI1HiwAwgR/VPWfK5q+eKeMbK+BsT7exEx0nag3m2X1sq5huctcpN1119XpkHVjsljt/VwJ6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7162
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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


