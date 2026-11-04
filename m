Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2967606A328
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=ncMppnUN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOeNH-0002UH-EE; Wed, 04 Nov 2026 12:02:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOeLE-0001Bz-5b; Wed, 04 Nov 2026 12:00:07 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOeLB-0002VQ-MP; Wed, 04 Nov 2026 12:00:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jHazldITGjTkWK+f5jvaepoR5oUIo0bkSnJWzD+Bflb+Ogc7ZXJihf/Po3JtHJo/eRGp9Yn8T+95OzBGrjAdWz6js15ymNsiSCxRrsBlZus89J8T+yiEkoiZCEvE0WdrO2TGQzuUdQruJYMRjFGM3VF1sIy2SxJ/7TZcjUUX1DHZeRDB/1ecCoqiqfk909WY1P63hlvazgQ5knvGlFxGHe0Mq+GDEnXQFF4mFTS+YaQgIQmw6pZMafLajUfoooFWE7RORKTY99nkV2hUGKVJZY8UNp853ZsSo+dNfzE7eejziCAYTMJtAceW2pboYTKaYHbDsTYHCmmGcy2+020T/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uK/duh0AWuFpBpIYfr+TjDIQxYHK11cGS8mL0iG6VEw=;
 b=trowAJHpzlAJRgWr4uZ0Yf92Yzntz2b1X/8H92lB8poN0kaNxKwj9EpCcSqAgVO4lAuQunG9GsQZx54nmrQTMevzl+y/7xyZlMPnH2e97ABupiWxqoy9V0TdLqIXvF4micMwdZZVgE3B5rLFito9QBLzAkMBm+aqXbMxPipcQ0kFZKj+dHUuoFLbgb2a8UcxLuE2VVySmvYDdIOip4MfuqZObnli4bfOTWhmXyYWXi0NAJU0eMQE8rkmVhpUSAXE6+RBCHi6d+b13PD/wpimYm9itttzINqmiz6ostMA1Zb0vuQvXXhHCdcwxehyfzdrEiM8Tg8TZc9LhMME6dOucw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uK/duh0AWuFpBpIYfr+TjDIQxYHK11cGS8mL0iG6VEw=;
 b=ncMppnUN57SXt7Nv8dTk7Yk7nA52u7NMU1IGBLEj/uYA9QhH/h2FDhcsDE10wYXI4xVU3zcxedDGwa9SMmtnYPNOyoYZk9cpGJoTU3egF25Bn9NcsGmdAvZf13hhYpIufVzaa1NwJP+vRqVcY11ucaXE5aJbi9HI+5E4fLFjdunDI1FwG16otcVj3gQr1+jxjz2233esrMEvNFxNY1eq7uURg6sa8EDwYr8vrT7h1votzgqggq32V9I5DSrubnz509AVLsn3POcLdG6sxQlcNHqaON1KEaYYz9GUTwNONfMhx3td4VO58b+1Rqu+jQqO+kOUnrZggk0PjlOdDtwQZQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by TY1PPF1EEEDC6B0.apcprd02.prod.outlook.com (2603:1096:408::94d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 16:59:55 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 16:59:55 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-block@nongnu.org
Subject: [PATCH v5 07/10] hw/sd: sdhci: Preserve uSDHC status enables for
 U-Boot
Date: Thu,  5 Nov 2026 00:59:19 +0800
Message-ID: <20261104165927.678833-8-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104165927.678833-1-bin.meng@processmission.com>
References: <20261104165927.678833-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:405:372::19) To TYZPR02MB7121.apcprd02.prod.outlook.com
 (2603:1096:405:2c::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|TY1PPF1EEEDC6B0:EE_
X-MS-Office365-Filtering-Correlation-Id: c27656aa-e1f3-4a9b-9260-08df3a950c3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|6133799003|10067099003|18002099003|22082099003|3023799007|261102123227099003|261021121427099003|261022105027099003|261026121527099003|261026140227099003|56012099006|261028144727099003|261009223027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: f4yVSTSYqXBzLSWVX/bY/XUNzDulSTHSQaLEPzdyomd8EqFq4ip7vM1SLD/Yuqy022vw6DHHs8dB/l2aZ8EcVnpR39mwuiXQ/rArnXh6VPFX1B4MbvXf4UMjtuqcDofDktXcHebtXEy5Ay+QGmdaGXJuNpgJKJ9CycvVerE1VjrF4YeiXgjB8tpj2bsb6gNPgLIrynscjtNRHaar62LcNwkHa57ST6ogwKZBZR47xgleAqGzFyNH8N/PNi4r7rE+H3d6/qqIFqGgfPgPEBevyvXj0G+YNiVom4BoYQ93l0bMPIZgool8T53GNPb8ZrUpRn/5ehikwtgLo9UICK7MBJo22c2VFOfCwOMRocnOvemJiqVmVikqvmzbxUUMC2GuUm7+P6W7CBFj0ZWjUZy2CEHoTC3xoedUYcmzQZjl38soXVXUVW2z1+wzeUspmhq9NkM6o0LfSWQ2cR250i7Mhqeg66yxzcl9YFTTDhD2Q5qBTK8SyjZF+wYFIGy+9GytABz1FqnBrML8TbEUGtXP4OK9fZmMIhE0VmpW0faUuokTTMGQoPrZlbuqpMnqRFMSM8c8URLG8kqapngMNykNk+8KClsu0KUnxjHRDe5V2gV4HcBOENma0NgA7Fb0vaKCtQEUCV7K14zFhqcZJBEFMbX939QF2oldt+4hr6Skrts=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(10067099003)(18002099003)(22082099003)(3023799007)(261102123227099003)(261021121427099003)(261022105027099003)(261026121527099003)(261026140227099003)(56012099006)(261028144727099003)(261009223027099003)(261021123027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8gGoGkzRh7WtFYpi1vnWdPj6jBCsqvYObTBh7kxX7n96r+DaLvJW7NU5VlKd?=
 =?us-ascii?Q?Pq9fc7tkLtuypr0505052agB8CV8/ynoyYVwPZUpK0N1fjDuiRU0ePoBGX2u?=
 =?us-ascii?Q?cAFS3GKRYMqw7HD03L47GkAYQ9eJxslExiEoSEGFLYROkV2Cv8loUfMzTL51?=
 =?us-ascii?Q?n7f2+poVcCUtNwStrwIDJMN590BDxTThSRYRs83O0wqOZ6Uz3wzWtL7Z2643?=
 =?us-ascii?Q?HGRY8ovARS6bjj9lI24hv7U+ST3mPMSIEQC4/a/4O2WBVKT2mtFAN2/yFM6N?=
 =?us-ascii?Q?jua3i0LHPrIFYEBMjP7Qf1dtvXNC6gziUMnb6AWw9QW6wEALmD+Qu8BNSSQu?=
 =?us-ascii?Q?d0kSWZJvjmcdXuwJgVEO7vkGTKWkqsQp3UtRfkUfefneuMhTzMBqZ1FT7J1s?=
 =?us-ascii?Q?h80L0PbD1lLMST74JlQO6LrgKyyoaFlBBY5a7FN+HJRej92MQYhwD/s/6hFo?=
 =?us-ascii?Q?Z7aUnEGUQMpdg9v+0Aqh/e8aCLn1dHpl6pAE3jemFKdn7Xjm1PIcLPGAS6TK?=
 =?us-ascii?Q?fglDyeIyOaQ0Pwo+XZaakpFMo4IulItcmcOd0+02+tVjI1IuDpwLmQaThku+?=
 =?us-ascii?Q?B0h2aA+OZ+qM8utjmw5/Q/kWz8feDIsNbrlCulobLniVDCKfl4wajLLZjYvZ?=
 =?us-ascii?Q?Ro2LSNKUmaUyMVbEucrH2D63kW1aeHe7yswgo+kDqaTI+Fwaow7q/ITg1xAO?=
 =?us-ascii?Q?Cy1PlbnaEk4aBZtY16mUbE6AXZxScPxUjmudXZKuJ3R3QQnrtkfPbu9bUIi1?=
 =?us-ascii?Q?XMCsie+2zbjf3cYAmQvmpaaQlO4feexCpC8Bi1WumaMc+x/Vo+wwkg009KUn?=
 =?us-ascii?Q?U71Dzpp76nGSCs7GngK6gRC/wxjmp7D34LtzCphxPyM2zJ2MNxqzkhCQVxPv?=
 =?us-ascii?Q?ZvumLjKL0W8Te5pXWXiWnIpv9lRn2hBgf+Fa7GNeH5EJnPqcvZCENjH9sBce?=
 =?us-ascii?Q?uHVnkyftaFkFWRXg5r508fy/sy+Qlgu1vu5jJY+Qpb2mesFgZJdZirovrEdZ?=
 =?us-ascii?Q?KEnTaoZYRcNllblFExQAcdZGKO+2LtENppOAzTiuwjLSGVw9r/+y9A+ZYYII?=
 =?us-ascii?Q?BVuIY1mab0Rx9nNyWqA5YYMcIC4kB94EXE7YQHAHBIXmkTezkqNSWYhA/CQe?=
 =?us-ascii?Q?vAETkI7pSo+1uBYjXvT2GgzbYGnalwPZJeQc5h7Gzl1DBfpvbCu46xnPQNad?=
 =?us-ascii?Q?tm0mCXhEcfgyWjmStRbE/kJ55lqGPR9ZhIo+QLqMfPcjHtpIu/Q9OuzBPtqu?=
 =?us-ascii?Q?XmOQSu+EyBVTk9BX00pdGLOsQD9AgpiPfxr7VVEhkMk2FcS2++Vuh+x7BMdH?=
 =?us-ascii?Q?++ityfpfNREFZK0zq71eCylXNcer1+Z5WsWANVlp/9O3503xfNOeb1hvQkf3?=
 =?us-ascii?Q?7jS0ArJaJn43V+UIi7VplQQbTk3z+19tIuU4/ceyYRrqDlxxyAIXmyYbVUa8?=
 =?us-ascii?Q?AkzrO1VYTG0QJ3hIxGuEu4RZ+3nuCgEqM3/urvge2Ls672p/shL6zY/oIX9S?=
 =?us-ascii?Q?Phk+gZDbxk3GpWxgU9ldirBhDKHF0/YJo63/72hjEL0z7bAbl+LuhiujzLUM?=
 =?us-ascii?Q?/ev0lfb9bqexA0DgZ0SUnxDE0sENqct2qhYezHRc1f0eYHCyzoclj9uD6GUv?=
 =?us-ascii?Q?NSw536DACRcQquFldp8Bz6/+aN+f4s8pUK+I3TluCQyYCPA+rjocwhn+RrLT?=
 =?us-ascii?Q?IfGLrlO0Ya+w7GXSsN3n+wmJdRWyDZubs/ViOwaCY+u1jg3s6K3BAAYZQhTx?=
 =?us-ascii?Q?zpVU8x0dHXkSXEX/+wrEus7kszeYyDU=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c27656aa-e1f3-4a9b-9260-08df3a950c3f
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:59:54.0660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZGqN7nkptq+2GkeyIIqgxuZNx9KinENvGTieo4TgYtV9tgmgaNqNX7EIazQoeVBRTjSe+HWszS6a6zbYdxEN2Yvz86VQfCUG4jT29gc8EeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF1EEEDC6B0
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=bin.meng@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

U-Boot's i.MX uSDHC probe calls fsl_esdhc_init(), which resets the
controller and programs INT_STATUS_EN. esdhc_init_common() is then
called, which issues a second RSTA and only clears the BRR/BWR
status enables afterward.

The generic SDHCI reset clears QEMU's normal and error status-enable
fields. Consequently, the second RSTA removes command-complete,
transfer-complete, DMA, and error enables. Commands still reach the
card, but QEMU does not latch completion status, so U-Boot times out
and fails to expose an MMC block device.

Preserve the normal and error status-enable fields around RSTA in the
i.MX uSDHC register path. Signal enables still follow the generic reset
because U-Boot disables interrupt signaling and polls INT_STATUS.

The IMX6ULRM describes RSTA as clearing read-write state and does not
document INT_STATUS_EN as reset-persistent. Treat this as compatibility
with U-Boot's established two-reset initialization sequence rather than
as behavior directly specified by the reference manual.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v5:
- Adapt RSTA status preservation to the unified uSDHC switch

Changes in v3:
- Preserve status enables for byte, halfword and word RSTA writes
- Integrate RSTA handling with the uSDHC clock translation

 hw/sd/sdhci.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index df921b85e8..f6419319da 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1831,6 +1831,7 @@ static void sdhci_bus_class_init(ObjectClass *klass, const void *data)
 #define ESDHC_TUNING_CTRL               0xcc
 #define ESDHC_TUNE_CTRL_STATUS          0x68
 #define ESDHC_WTMK_LVL                  0x44
+#define ESDHC_SYSCTL_RSTA               BIT(24)
 
 /* Undocumented register used by guests working around erratum ERR004536 */
 #define ESDHC_UNDOCUMENTED_REG27        0x6c
@@ -2127,9 +2128,25 @@ usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         break;
     }
 
-    case SDHC_CLKCON:
+    case SDHC_CLKCON: {
+        uint16_t norintstsen = s->norintstsen;
+        uint16_t errintstsen = s->errintstsen;
+        bool reset_all = (val << ((offset & 3) * 8)) & ESDHC_SYSCTL_RSTA;
+
         esdhc_write(opaque, offset, val, size);
+        if (reset_all) {
+            /*
+             * U-Boot programs INT_STATUS_EN before issuing another RSTA.
+             * Preserve status enables for this initialization sequence.
+             * Signal enables and pending status retain generic reset
+             * semantics. This compatibility behavior is not specified
+             * by the reference manual.
+             */
+            s->norintstsen = norintstsen;
+            s->errintstsen = errintstsen;
+        }
         break;
+    }
 
     case ESDHC_MIX_CTRL:
         if (offset != ESDHC_MIX_CTRL) {
-- 
2.53.0


