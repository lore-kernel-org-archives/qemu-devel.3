Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8466606A329
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=Vbko6Xsc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOd9u-0002rl-82; Wed, 04 Nov 2026 10:44:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd9h-0002fO-58
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 10:44:06 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd9e-0001J5-GF
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 10:44:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xpQFysM/RjgEpfY3CN/gxHQdbd2I71jCtr06yAaZqqog3n1QUFLzi+TZxbVzX9onKgb3QbDs44NKPql+3duwP8toLZK7lCUy0mnr0+/ngJz8OpY+0yKOMzRKqU/PSKBDbYXIuG+2ke3aNYq/iMiNfwd4LwFOd6bMfucKonw0rgrQYv/diGs+2CFyMIric1/XmTqUY9SR/4cMfAqWx9fBW0kuSm99pgyaBPjOk0DAEsYW1sDe3AF6aPTfSIC/VQ1wxQ/jd0fszAKUuOvguCdPmNPdSuD/0j8dVc9Vwfv8vsXmDtDoLl6pWheWr+XHiltWo6F8/dScIAfxZ/pWX6q5mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7Lr/EegCLy4TAGWgBwX53xakB785wpZ+FfUldNv5b0=;
 b=cw1C80w6fJdgSs/8T8Xd/1+EyYD6oRANUeY5xwv9Z59Z671QeO5MdfDSc6aG8+kjSiaSMD/p3C0jssrVWEGPHGqEZlmlI/glQVUYQMQ3Pjm8spAbmwykaCaFJUccBP6f8IbVNNY5PweEb606znrFnRXmLmFPh+OTBwppAnTR0YLpyf+uW8RLNwCkvcFRQN+o7ZvBzpAZhRKCe6WGRxxgmPt0alFjyWt32X043+UawFELnym4lPXb85ZMV6ZXCsKh1W6casFbGxFeJBpOS3LUFEFE4vs3NSMo3EYPl9dx60RreE84DFQrAoHU6l07AV3L0/uNhzFE5gDhy2XW4BwSeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7Lr/EegCLy4TAGWgBwX53xakB785wpZ+FfUldNv5b0=;
 b=Vbko6XscXQNAabFKwKnRJLySH4jfzGeurbfzNhaS7BQg6/t2C9t7DuX8STKoiYNljYrLOe2n7mB6nTLvWDcpD+BRZRkqazN20Y2N9BL1BDj3vU/N57/UKJ1gIckaBR6LD0IcRiM+uOQZYjJE9J9ENToWGSkGiQ3En0kExR9GwqauTfwPVlV/nn3Lw5605c/y6T21VNh2mVsjCEs/NGgDJF2W6n5MFoqLwh0A00ZbegYYp2vdhwwlJg+wVHi2traPkUbvA3qhaA6hBe5ONN7Sq/5HndLRx4kUzzwrT40u75kExDOgjwrhmb6B1E2nEiAFnuxOXEdljQH7WXttwbfJhA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by SEZPR02MB7162.apcprd02.prod.outlook.com (2603:1096:101:190::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 15:43:12 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 15:43:12 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor@kernel.org>, Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v5 25/26] MAINTAINERS: Add PolarFire SoC Icicle Kit maintainer
Date: Wed,  4 Nov 2026 23:41:52 +0800
Message-ID: <20261104154207.641511-26-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: ef208601-ff0a-463f-d932-08df3a8a556f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|56012099006|261022105027099003|261021121427099003|261009223027099003|261021123027099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: RGTD1Fz3RoF/SYmx1fareW1tppBL3juxfgHaUbQeCZOnR5a06Zgnxi2+MX7ETrEYRd8phAHqkFLR0KZ1J8LvVlmka2OhrhqENBNYixpWlQISSqm7cRu0flz4I6+aOML0Cdx6pS+Sjma53Sy2WBhDtmQwwiRjtrOh42IU2+Z4CGV1bTJl2/+BFFUXSWMv0pWI/xiw3W+EKPnxhUZImoqBoqPhK15jm0rAWWaQvWMy6EFMgEVRvERlvK/hSt+GFE4ALO5L4TeW1eiiMz2Bh8xlcRYMZae7j/7aoWSL6g8tmD5VG5Gap/gc13Ow7Sflk1v5OHUoRsN4piR65D7sfY6b+7R3I/ZWK9FW/Xng31K/CBmEeAv8r+OQ/zvqsDOmKNvxkP0FbxH444PJUISaFgAUKRf9XhDKSPoDgvsuqYBdliV1jIHJHlDz56IlL2PdTOdMu+S+xawneu39GnyT2bRn2bWGjGBE12aePXuTZiuSeCZ6r0WX9Mrwokeaw4KEKwHagmBOrIsDJs4P/dQgUGGS8T6gje2acNXVwzheVSbdyhacR3cGOoRNxtwX0hypOGUBMXKjOPaS59VONPX3CxJtFvOgzo1xuVXaEJbOd0CFadRanSVs98zuJWGJL3n7P3bS6+YML9XxmDTkHmyjzs/y3eOZHZKQ+w+6iXVclTRshcQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(261022105027099003)(261021121427099003)(261009223027099003)(261021123027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ePu8yTf9aSMQzlHef2OfLAZ4EE3ywLVE7DhFyZ/1GJa5CJnmMCrdq5PfTLC8?=
 =?us-ascii?Q?xsqKQwdla37KIxoftsXWFnZix/KdksHXpyNs74JRmJRXoSsnl+fwTHSc5Hqj?=
 =?us-ascii?Q?1jgFwHrBPNKVWTYzHdcXWJl1xZg1jI3En2Fbkz8QlDBOXUSM0xTC20bXXODH?=
 =?us-ascii?Q?2JTJJcrJTgPdoLJfIQ5ocgRknatZJUchqYjk9apiiTGvFvzUD6OzeGv0Oj7Z?=
 =?us-ascii?Q?6iD80bDX/dmmzkYlMtmYlHHDb3NKJeDmwCKVtDD8Sr5241NYy/WMk41Y/fLZ?=
 =?us-ascii?Q?5tOpsE73HRwTDEaJAGvYTgOPV08VnzeDOO19d9mBsnLjUIlJEi0owNdf6Vfu?=
 =?us-ascii?Q?oKILOuM4dm6iGwnb64VlP0dqsjO9g0ykeAY8H+X2mbZfuoc89mOPbVMclpZu?=
 =?us-ascii?Q?frqgBlK3VMEhpZR5m6D8Hi2kwIgCwPi9NcqCM81momcuLiyiOKj77yLtW8nD?=
 =?us-ascii?Q?mpBTw2aUbMlQ7tI/3MdRPgTbEeHGns5iqPBF+VFF93NOWf9aAF6nYI3HZZMU?=
 =?us-ascii?Q?DHdjogtWaHjYI6D/BoxaztRCnO7MzaigtZ04/nwP74oNMdUhFpx9JWCnvJA1?=
 =?us-ascii?Q?iotxB7wTj15J71BuzoHqu6gh5iwCG5SGrhiqldWRq2uJpVAlhiy7hrzd+A9W?=
 =?us-ascii?Q?1dTPs7f9wUkMIBA5Gp6+8hXEOZY2TyihP+P7aoxCtOMw7dw9wWyjnnaxsptk?=
 =?us-ascii?Q?uQzw01x2xms4gTjlHKemrWiknGQJou2n+BUHpDNSu1Q36w1O3vc78aBki5JV?=
 =?us-ascii?Q?iDBEAOnRdOVrQU0kP2g91eRTIS59hkco0ryiA2AVcWr6ZDriT19fEqKAFSUk?=
 =?us-ascii?Q?NgYKY7OJjsLXiJoM3FU5oueEK2FQ2X6i3ywbrtApzqtGQODiFYqAgFP73Q0Y?=
 =?us-ascii?Q?96ZMj3nZ6FQ2wRHHyZvgWUSGIS+G3Jr/nyxAlf3f7FllLxjOIpeXyiZGlzMO?=
 =?us-ascii?Q?9Di1Pqh5KS8DhXrGKHvfkndUX5moNvSie1sWSRTgCTO5hsQfw6qRRCDZo35P?=
 =?us-ascii?Q?2Wd9ufCQ13klCdQ+7yOkvwPNMlnqhtI9dAnEBAjLdNHosXxzde+X1D2nCrYk?=
 =?us-ascii?Q?crtj9uI0ZYHKEMxD2bVCeVzgCMAqbK36/aV6WFCwKiuow84aXAPoYgkFqkRs?=
 =?us-ascii?Q?/uhWYO+xhe1ScgTUr8UbBxgmoogKETsMrOQH2QMpqBVhJyDicOMJEAtRKpoU?=
 =?us-ascii?Q?nzv/99/k8W3fhNuGYHY6rX/QojgiwREXz/pYXVLS47JPbgKUl5ZEEDPu0F0M?=
 =?us-ascii?Q?ijbq/RCXRTxumeXLCabYc40mAr/hfniG0BH1wseqiRwDVVeKVKPIro9daCz1?=
 =?us-ascii?Q?I4C2kjq40fa3tnd2EjCMQbYp8zpBuhaq2fnkrq1CNl3udwGWBDk4yEHE6l7C?=
 =?us-ascii?Q?U1Qh/cS6ZJGcf1Vu89Q8VmMrCqlGcW32uDRX1bXIVdkJkPg3DBIDNxUXvKQP?=
 =?us-ascii?Q?1zOJP4ve3eWCQhMiBrI5PJYP7yOdpiPlg4GpxQ+w+8zgjzsg1fu95Znecym2?=
 =?us-ascii?Q?w/YfNILwZ3Y9uvL2hC1NTfZgq/edA+8M9Xz2ijlp16Rr5qFGzGZlrkFIplYm?=
 =?us-ascii?Q?N/KsJfdKM09lcFDdyGXVYzVuvgTdRwuFwgdqJkirPM4z8ni73zFpb3xWzC7Y?=
 =?us-ascii?Q?4WIeVDjcV5ldJ5fldJG00Jh1dQfyhga6xxPK14MCXEg7KkLczXHjgoa2Rmrw?=
 =?us-ascii?Q?uBkEo/alIB/N4vopMAr8bbKdrsvDuIiXv4OQ/W5WiDqWCwYJuOeM/sqUsO90?=
 =?us-ascii?Q?838AyBWptAAQL+gX0yRQ2dwRW7ArUxA=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef208601-ff0a-463f-d932-08df3a8a556f
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:43:12.4172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3eLVqDMrcoz+N+K/dWAAqmyFdjx+KW1CvgJtvstD54Mxvoxh+ynnywCBRu6hIvZsv9J/8ga9Rlklr3jysI1tuZKmV2IiHhfWLU7bgF3VLY4=
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The preceding Icicle Kit updates restore HSS, U-Boot, and Linux
boot. Functional test coverage is also added.

Restore myself as a maintainer and mark the machine as 'Supported'
to reflect its active maintenance.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Acked-by: Conor Dooley <conor@kernel.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---

(no changes since v1)

 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6c7437f8a5..e50ebbe5d2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1817,10 +1817,11 @@ F: target/riscv/xlrbr.decode
 F: tests/tcg/riscv64/test-crc32.S
 
 Microchip PolarFire SoC Icicle Kit
+M: Bin Meng <bin.meng@processmission.com>
 M: Conor Dooley <conor@kernel.org>
 M: Sebastian Huber <sebastian.huber@embedded-brains.de>
 L: qemu-riscv@nongnu.org
-S: Odd Fixes
+S: Supported
 F: docs/system/riscv/microchip-icicle-kit.rst
 F: hw/riscv/microchip_pfsoc.c
 F: hw/char/mchp_pfsoc_mmuart.c
-- 
2.53.0


