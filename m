Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0B2606A329
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=Q6oWtqVK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOet9-0003P3-DQ; Wed, 04 Nov 2026 12:35:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOes6-00034y-Ee; Wed, 04 Nov 2026 12:34:09 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOes4-0006Dv-LQ; Wed, 04 Nov 2026 12:34:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+G74AGNS+oji6Q4IsYphkWjhn/Kam5zy0whuIJJAmofY3/bIeHVGUBdn1WQAUZ0FypxwK81Djyy66dS3tEuRFjmuJigHOXevXtKLPW3FeMh2/FYSkFDs1DwgZHRYiFMzWQd5nR5dxozROV1gRd7x3A8MCJRcEqrCYvYQ13JGNDWxNXzZvicIW6jd3RCXVMAH7YULNZWApmY7m5vTozqhQ2WwiKz/6SPa/55BSOr+2QDOa0RuHcsq3ziPQXJSNasllQ0N0Tr2MyWW5yYRam71G0/5zVEX/aAnIiTNh7OTjdCQP/tjUPZlciLdv0F4C08YqWAnYVbFTCwvYpxwZqlHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VM/vztAZpMHfEnBVA0QfBd+qYQ4/DHcngSSUR4tWSKI=;
 b=p9iiTXAyKUIms+yRjeky4vDwKGg3rcijePG6Z+sWcbbauX2JMRJHg43Q22ptryu35UAPqWsM8d3I/kk+QuH79Q1Xam3kt0ZutkFW5V7QodxjJIOVl1f9AA+2Mcdqh8zfaViTL0DT7Y+7ifKLi/qqOrqnmlH0Z4aS8fDhrw0I5IFjyYxSfk6A4dlcr004ptBVoBjcosPCTbhlrPGXtc5G8E3RNBCmFMTdFS9E/fSun7MoOjGc5A/CGnY3Th2cvGSb1p+buHAQIWRmc/8GPZ94CmKmKNZDYGBehtL2kTGrTcd6Jfd5vXsRVTH83Wr1cmRg+OfIlps5BbO265HGWT6NRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VM/vztAZpMHfEnBVA0QfBd+qYQ4/DHcngSSUR4tWSKI=;
 b=Q6oWtqVK6ewooX45pFEwO87KTZ4MWJLcyKIyKI2z+a63ZMwmJKWM8ZbTpVYegOPzdqYIMXsLFrD/Q3WEwGtRt0n7VXzWCvHAbyQGPMvQnCWURRK9LV7Qb5p+K+dEg4CBrcWsqG2jyA5g1qn/zb76mLbVe5XQJEmm0uZeus/M2jvFRTEm2yiuM28VaR8e55yORflLZZO1Ih4XfGnnDxBu21uVFXwFOuoTz0OjUux91nqY0hGiAfqVInHKTVN6yG+XVM2VVRMdfoEmxJOw884+zfgMW2T3gFP9Ly4sO0oaOG7nEUwfkwHTZ5OZQiTeDk7sDVvsWHHVCukIUjT+j3IDGQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by KUXPR02MB8801.apcprd02.prod.outlook.com (2603:1096:d10:4c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 17:33:49 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 17:33:49 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org, Chinmay Rath <rathc@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v2 02/17] target/ppc: Correct the MAS5 SPR number
Date: Thu,  5 Nov 2026 01:33:05 +0800
Message-ID: <20261104173329.706635-3-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104173329.706635-1-bin.meng@processmission.com>
References: <20261104173329.706635-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0044.jpnprd01.prod.outlook.com
 (2603:1096:405:372::17) To TYZPR02MB7121.apcprd02.prod.outlook.com
 (2603:1096:405:2c::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|KUXPR02MB8801:EE_
X-MS-Office365-Filtering-Correlation-Id: 6553f060-97b6-4092-4ae9-08df3a99c93a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|18002099003|22082099003|56012099006|261026121527099003|261021123027099003|261021121427099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: mSHNXxKdUf1xxegXolGQ2xK0ss0kMErXqXaKA+dBQ+0rZEfHqOZYg929qSj61xxCfXis8Bqe+olUfRI7B0g+KwW04GNuSWEMk/4kH4/RqP3au+CjZdjcM5tg5fhORz1h5a7S3hIC/cMBDPDtbzE06ZuNsyWtPWpFJUUodvw6SnuN+V9utzgvXksARluPtMajw0NUS4TUN5xsPibbJY2TYllPQZCfu7mShZLhdRZEdRxLCjfOyNDWDkK77jaTtwGSlqPkDvn9zTdh3Mx6RZNC+Suo4MgsWJYLmMjjnH0hd52Mb+cc5w3px75pEBWbR4GZub9hR1J63fMKZZQc1cPM2wqD8g9RtiOtUbFZ5L49rYP6BtB2m/nvs3CHb55B3B898gXNrWVyNbNQMgvjRnMY/0wX8Ieo/IpxnfnKsfdkQFATZdgTKKsxD8L0xqHt9Z5kRartN09ZaKFm8H4eU91HCMcFiBqxdB6sf5ozHwq95uktsC5jeWNVjibh3dwHnB7VzHOKJA+XrFEGY1khK3TEVY9GYP78yxV+oGE3H64m8JyTWLuzP/imRxyZvZpeixWfL8xi61jCdTXOcIkllCDcJma6dHt2Rvd8sqR4f4DmHvORRkcWvhVCLdjiCkbUCiNj5rxLCMzVfqgDhxJmqtk0PU/tIGGnMOeLMxvDeRV0Rno=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(261026121527099003)(261021123027099003)(261021121427099003)(261102123227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wej35a8Bh1qWAT9FUyonHnXQnzcRB59k+dBJxdOya1k6z1Q8c37y1MQBQff2?=
 =?us-ascii?Q?6kOqELrWRKFC7QaSiY38OcJJvKIKdNdn12aiqrIyAv2y6gAOZXABR4fCggQS?=
 =?us-ascii?Q?/yuQbuIFTBncKlAeFNQgnnZXxnYRBNmzzY/qNoUZyDTbkziEeuuFSHrPVsHk?=
 =?us-ascii?Q?o3KzW3v9qXFkKtqMXJF4I+HZHy5Ut/+QgW2VIS6Rwp3Iku2oNvy1b9UTcNL/?=
 =?us-ascii?Q?KRUDQFtoywcYePI2avbAeEaAG/LBqFxu9e3kzLYqyNw7nPxemzfaqT+zOvav?=
 =?us-ascii?Q?eAsptcYEo86yFIaD3awiumlydiEp1atCwDrjNhUoM2cizgjrav6vqAiJ5fk3?=
 =?us-ascii?Q?J9qWoz03wePt7ff4eEnH+Kjxvw8hQeorudM3ju+dmx47Md/S7gln8pHXZ/VQ?=
 =?us-ascii?Q?3za1DNIzkEHOfyIDcQy3hESxc2EQ5cKmpldQFz9d9Gjuhs62zQL2KO97V1qv?=
 =?us-ascii?Q?tvlXL5sbmPp4PW5StB4kiVsLLfRxRGrsGNAAT75KBJ2a4Zl7V0V3g1W6bqXR?=
 =?us-ascii?Q?wjw1hzwLaQtSXsZWNVmqB5KEsn2i0hs0pLi3J4cXgndLigBS+c6XDp1wiF4V?=
 =?us-ascii?Q?FsAaOje/Pc2ys/v6cnPRbPCLGC5WAhvc7DZecxn4gj9ry/TO8WgSrCX8uo0E?=
 =?us-ascii?Q?NaGzxp9KdyDNycifCAJJuq4odmLIHOagZBQFY/MO+pZHJClfKnsL5Xzlbnjb?=
 =?us-ascii?Q?DfWQtdR5hu8hp+En0fkqhd8U++IyQTDUD5TD09/7SnEZSNUmbehws+ZBApp1?=
 =?us-ascii?Q?Dxq7fbNbCvyGPdx/MddSZVOwqEJWVUOKhCnT83ZimHMnNo1tpg+aVzc68LFK?=
 =?us-ascii?Q?7K+OyHd+MCctx2BTcs3H4yo1ndBflYRf/Tvon8/RFdYp+UndRah3YpBQ7jPd?=
 =?us-ascii?Q?b60hrxKPyCbrkrJ71RhWwx17rPuqP4ti3WUkaOb5JdbNMd0xjVZN8kC4lpdg?=
 =?us-ascii?Q?YCeAIJXdwlLIU7iAfH4kAC7roGBtd0h4zOQmTZ1cAb+XqYMOaNkIWHiq6W6J?=
 =?us-ascii?Q?RfJrqFkXR0s4TYBdkWi/s2M8wLpPVMsOTLTGu9uurY6joejfkjOQFJR4mBsp?=
 =?us-ascii?Q?gB7PueM42dd9+oEEwgzDxQQ2UPm9pa3IT+N8MejqxssoKbFUqxC+ztgruiha?=
 =?us-ascii?Q?v0yDuBb0i+ZNksR4Jfamkh7mUhvhj/wo0Wm+MNJgAQUkDYlcVO79beXecxk3?=
 =?us-ascii?Q?X16QjlXUIriKfavnzO5XIdaHPBLMelw9RvkzA/jwJdPrTX9PxOkoYyRIMCHp?=
 =?us-ascii?Q?8xYkr/mzlzA9nqnRsJ3FX8Kuyzv9WG+UUu3Ym2k9upcc9UrXnZeFjtj/Jgpi?=
 =?us-ascii?Q?KX6UA9AZ1LzMeEa7bp77U+t0eA+zMual6Lm38N3V6rB3Sv8MBhkg/R5tPVDo?=
 =?us-ascii?Q?FdZtDaYrwXGY6H/QaY9XxTp5nWBsMFJpWuCdZBvV40+4WNmz+0tCQTy8lSVi?=
 =?us-ascii?Q?YLm7GmmkZq5TPsAgAW8yIqvITqabQRoxDqeXL+pac33j8oSTuAI0yjpPJgJn?=
 =?us-ascii?Q?IrjbAUy0HPKz6XoJIAxns8WUSqNlqlHrPdWuRMCCDnhvSTM1Mo6onV2j90TU?=
 =?us-ascii?Q?wgT/gLkG7pH8zUUyvyYW6jRxPe2aM1Wv7tpixpqtm4jjp53guc5PkwxGu09u?=
 =?us-ascii?Q?X7mvaO3yZwq8FDajfhvgxVxEDuMZ8C2dSCw7wFFylyvPcYt3kUQ06QgjpBK4?=
 =?us-ascii?Q?23FnTtg6AlxwzyRWQ2+hivFC8gf0O2fiZb9iog2eOf8unGUeoxS22EGzCePT?=
 =?us-ascii?Q?0f+7z0z6heBhwnUj8XutZdfBa5Axeh8=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6553f060-97b6-4092-4ae9-08df3a99c93a
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 17:33:49.1137 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kk2993H3rg/oXQV8c0NNJF5vZr5hmSSvcEen5BysToxpJqdB+G+ax8yCbNNTguizCMhGm0iqVQhcU5Bv2Xdbu0FiL8JZ64rOUdYhUSjTmI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR02MB8801
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

The e500mc, e5500 and e6500 core manuals define MAS5 as SPR 339
(0x153), but the existing definition assigns it number 629 (0x275).
Correct the number and place the definition in its numeric group.

While we are here, adjust the order of SPR_HEIR so that it is
inserted in ascending order.

Reference: EREF_RM (Rev.1), section 4.2.2 and 4.12.10.6
https://www.nxp.com/webapp/Download?colCode=EREF_RM

Fixes: 80d11f4467c4 ("Add definitions for Freescale PowerPC implementations")
Cc: qemu-stable@nongnu.org
Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

(no changes since v1)

 target/ppc/cpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 0f44096bad..0cbc55c470 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1928,8 +1928,9 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_HMER              (0x150)
 #define SPR_HMEER             (0x151)
 #define SPR_PCR               (0x152)
-#define SPR_HEIR              (0x153)
 #define SPR_BOOKE_LPIDR       (0x152)
+#define SPR_HEIR              (0x153)
+#define SPR_BOOKE_MAS5        (0x153)
 #define SPR_BOOKE_TCR         (0x154)
 #define SPR_PPE42_TCR         (0x154)
 #define SPR_BOOKE_TLB0PS      (0x158)
@@ -2044,7 +2045,6 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_BOOKE_MAS2        (0x272)
 #define SPR_BOOKE_MAS3        (0x273)
 #define SPR_BOOKE_MAS4        (0x274)
-#define SPR_BOOKE_MAS5        (0x275)
 #define SPR_BOOKE_MAS6        (0x276)
 #define SPR_BOOKE_PID1        (0x279)
 #define SPR_BOOKE_PID2        (0x27A)
-- 
2.53.0


