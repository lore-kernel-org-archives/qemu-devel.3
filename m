Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046AB606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 12:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=K6XPppwq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQ1aL-0006fR-K5; Sun, 08 Nov 2026 07:01:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1aF-0006eG-Eq; Sun, 08 Nov 2026 07:01:17 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1aD-0000V3-Hw; Sun, 08 Nov 2026 07:01:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WkRYLm2+NeFYYY2eDduqPuGg59ns1lDFLAcuhmI8thWjEMqyiKT6L+PGtH6zk1iKm+Y110gJReguym5omctB9TyUitGz7yk0MDuBab0tHdLfNhl8eBkt0nY8zei+k8maYMcLwW9zYpCFZaEwMzxKVLdmRkNK0p639g2IyjI3FpifcxdIWMqrroySnVMQqbu3cf9q+C2yZiXWbA2gXLMzBasJ4ZVP+vjoj6BLnA8yEal4BEWE7FHHvFP3dghyB9HbRtVc9vUmUXi7ydzgvO+te7W9lviHqeTiZzmG4/orGkGLjXzisycVJJnLxa0vxFbwoRRrh6SwMDhiK+BZlaFbPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buobxPO3l7B9pDoW5PmnasWQR8qbNymgWEGfxN3AfFU=;
 b=xqHUw07aQYwkeRZZ7ldfwog4r456LIS5PGlV7z1dsMD0Akd3/i9+4IpEHshNp4J6I8LHu6wAkRim+aCIvoZQKlBsK4tOyyih9r++/oUmysm4JqtMdMiqqISCRJGUNziDDKLBWjQ1rOpx6kfPlp4Y0R9o3Jo42CPz7tPIGlOBNHgD5Y6hJ74ClJECQVXs+vQsrBW5d5FHr5SQYgNifiZSDTCRsc/nR0Q9ZEcHp/I2Fefgt1IfwWWrxL38hWJl37Apn468UKhm1xV6EtUeQVRoGIVezPaNzmx2zUuYOQUBkBWVCMO2hAZKA7rk2q6g5fx2WJzzW8GAukwI+l3zmXS3Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buobxPO3l7B9pDoW5PmnasWQR8qbNymgWEGfxN3AfFU=;
 b=K6XPppwqL/ySwcHsnkc4s8t1Zk2YlL4fNgb6mrW+L1u9NGE+tn3hM1cSdRoDiGUQ7LbIy91HdZqZqTinoQ69ds8Q46gDgh7GiLQgtGswJuEo0AI33D1KhmRQtzaJYhiAqFMQ6vdAH3YIfpdE5wdV9FgfoOden+NS4/QBztAe7arz42fplpQ3M29YkEDXt21xMhgSl4/xLHuA2ltgUwtlEHIskDkuhdvy24WN+jDM5ftmnSzCdt2oW6up2YjgksWV1pHb/GAnURTYV5OlOrihImSWVHkxF2vNv2PvqTKny0108HNI3PbSHSaBpoBHryUVCo/C1XfaN9GsbfmXhPksrA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com (2603:1096:820:116::10)
 by KUZPR02MB9138.apcprd02.prod.outlook.com (2603:1096:d10:61::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 12:01:01 +0000
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c]) by KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c%6]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 12:01:01 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org, Chinmay Rath <rathc@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v3 03/23] target/ppc: Correct the e500mc and e5500 cache block
 size fields
Date: Sun,  8 Nov 2026 20:00:02 +0800
Message-ID: <20261108120034.1755008-4-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108120034.1755008-1-bin.meng@processmission.com>
References: <20261108120034.1755008-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0219.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::15) To KL1PR02MB7144.apcprd02.prod.outlook.com
 (2603:1096:820:116::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB7144:EE_|KUZPR02MB9138:EE_
X-MS-Office365-Filtering-Correlation-Id: 82813ca8-969f-4268-5018-08df3d8ff507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|6133799003|10067099003|261102123227099003|261022075727099003|56012099006|261021123027099003|261021121427099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: XxMUxeQNuos+FH+2C2H04Cpxg35t4C2uwIQUpw8/TCujR3juHKulzRe6aRO47vDnjI8/sUJc4PmhQLPXEsPH+GeVAKrSStGG9aE6kaQoEFJYpiPTw1ys6hGZjfZTJFpocaT4wqVZAtxRoREqQI9Y20isBxOgVfOPEENdnO+cOUzalx4DTEM5NH0YI7+PRh2zfUnXcTGpyv7KwGJctqOxfcTZd3a0k8zSrSZ5MLF82/XMWVhblinzl2jy34X4CAeUHIWtUOPrxpdMMVjCubO0ua9Nr2iRmoLImFYdxbM0ic5LOEM9VI/3e5O6WbM/Rw6v65FDsGwGeTHQ/r5b2LquJfuO/vlrcVYpjUfWuaiDxrjcpnZCG2mI+K5kGz10TG6AKGjPqttxxkDSQcCsKWlR7QLcIJM7dH+fgM+UMlAKUrgAHyscXwxmO9eSJfHPt6QmGiLfjHpwMIL49mIS/YDHbo4XlhLQorfL1zwGZwuF2c967zAHXbhc20uc+ymjLT+q7TWs/l6aG75ZVeNLNanQrc2jnPW6Tl5ywWNYxGFt03sUG81DIyweTHQ4r6iomWyD+E6ZT7T86KEdOHPNnVBeub+Lx5dDkzFy8FPLpJ2Nxei1yN3jm7fqTmMGO5Iqk/nYLVJUaJ9X0q4PBKuMDIKfel+w2Br2eKELrVBm+HZ+qGs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB7144.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(6133799003)(10067099003)(261102123227099003)(261022075727099003)(56012099006)(261021123027099003)(261021121427099003)(261026121527099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M+bOeGjNItx3vERBIP1OoYAk08DYv7enafFkxXUzM8Pagc+2VYbWLh9OXd8U?=
 =?us-ascii?Q?BVy6Nj/ZMoGQ36CaCoX22bYTnIZlmZ4HstNurNV4dLNaXuv0XgVSdhRPAiYA?=
 =?us-ascii?Q?3Kd9HFbEINJQsd2aD/jKKK8EGbhG2JUCN+hZQxQw7b1tTGtg7M7wS/hjtYaM?=
 =?us-ascii?Q?J39M9QHVfnlqiD5NRZeqnCI1+quNWC50OjUK+6pXDca9dI8klijSL1PrJDHB?=
 =?us-ascii?Q?BGoK693RDNKAW55JxNuMexRbNijkFCe78JdGQexwncV71NzF/l8h70DaxeT4?=
 =?us-ascii?Q?AQ1N4D0ELwcKNRWslPulEF6xbISNUAzZgJJWSHsP/GhpS3eAxWMg4ysLfWkp?=
 =?us-ascii?Q?XvOtlQiWlEaZylDHMlp/4jaGYMq4kzDrZGlUZ596y6FAX0b64+I/KGxvlS6+?=
 =?us-ascii?Q?offKopJ8vj3NTRll3g21XEU7g8FSMi0YutY/tJ/kkG6DvoUxNrs6mG0EVjas?=
 =?us-ascii?Q?CJgC6XTYUklAd+GsSJlVKCpJoA/h9hxtIiIx2TX9qmhOKGtIZomvFlYncAf0?=
 =?us-ascii?Q?bk3TbsPDlp1qXp9r2AdUWb6khBah1GNpp4Y/nqANyBlXS5YaT31Om84xlVUR?=
 =?us-ascii?Q?InzP+rAjkcQpcmOmoTtJqt3C9oyO/GSJUE+KdemhNuKtVntf0ucL9/xaUnA4?=
 =?us-ascii?Q?7mlF5C3kehuPTLiv7KOzDy/BmBAvC9h+5jJJ87OjA6AdbWeaqal2+b+Tk7JO?=
 =?us-ascii?Q?88L2iWp/el45vCFnfi2uy4mqg93T6ANdko4DbqnbRidCM5Yw0ouhHM/r1Gdw?=
 =?us-ascii?Q?GLYL/J6P3hh0P7i2aMjZ+3GIy2+W+3YJDt+bPVeEHFB9AUEZrX9kXYBBOBgz?=
 =?us-ascii?Q?G/N1j5E0DNm+mNKlI7pjgPzijfaP/YSJFifuMIWNOtkoGctqGSXylt5NLReH?=
 =?us-ascii?Q?L5aiB9+DMcdjkVOzeeaKWDYOV76XmoS0250qsnNPnUQKW06Du0gBKrE5FLDJ?=
 =?us-ascii?Q?ItqdTzf3YCC9Lsv2jypssYYZDYccopgWWXAwPNQF8v4Uhq6aZ9wp6LGYJ/0i?=
 =?us-ascii?Q?HaMq0/OXyxUx4MgZIJXlxPfNajG/wgnh2kD0AEjn3hnihqdokStxmpJehxoj?=
 =?us-ascii?Q?0u80UIelDTMsjc5RM8NB9SLA/GKu7e+/y4MVlUCZGm20kpjJBhMZyeXIVYfT?=
 =?us-ascii?Q?+uu3vAV3re6Sa+RjuFsgiF3CA2cFAZ2NdWNo33u8qS8Q9PwoWAm/wSFm/BX4?=
 =?us-ascii?Q?2cMC33+GTSmgWH1TXcvdW8CD4uG/j7dJqUZPRl5Vh+y4XgxezzN03FxSFFWM?=
 =?us-ascii?Q?togCkk0d/DkJIFDYvKBln6ClvcX5dn7a09xNCpHge6jQJQU+1QVnucpfSYfK?=
 =?us-ascii?Q?Ygv/LxrpxtE3ZilrLHuDoZAWRrPd3+RjbWHZ8HOVUIn81aCX2LY4yl9lXX0R?=
 =?us-ascii?Q?m+VnK1rbE/L5zwFN/AioHOsGRqm2Ps3xM4OJAeWSTLTR1vkBqQRtvtfJJgMb?=
 =?us-ascii?Q?UxiwkmZ5SKOKHVGrLMXT1GapmcwijTvmcdIsiaXRTBeBHn6GVUZC+ykRzwrm?=
 =?us-ascii?Q?U8fCoW9Nb8ZtoNfAqme4DD5GI2bvt1Qi3KFWBrpslhJKmWGKB2zKJZQTwSR0?=
 =?us-ascii?Q?/roWTxd4/PETWh9DPt38D/YDlCGS7Gz/AMZHsTKNoUBRQzVBJYPff93H8u9z?=
 =?us-ascii?Q?rzKfsekdfmSxTU6UwPqxEZjTSo+QpM3KT202ALBWuNXsgabv/LxSE/BAZMzh?=
 =?us-ascii?Q?633Rz1Tjmy92FG6G4i8qiD+VBbrtamvGkK5VI2k2NzsypzlIEqK0hA03P7No?=
 =?us-ascii?Q?htt2w5dPbzQqE0KdwUR4D1sQ7g1cwEI=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82813ca8-969f-4268-5018-08df3d8ff507
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB7144.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 12:01:01.0982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xse669pMZc78CvcH+UsKnD3kh3v90BoiQjmohdoipBfy272K+WlhPr+Dstk4bSccP6+8KXA8J570+SLt1p7zfYyGdVRCWw5Y0Do94E+VQbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR02MB9138
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

The L1 configuration registers encode a 64-byte cache block with
CBSIZE=1. The models instead set CBSIZE=2, advertising 128 bytes
despite using 64 bytes for cache operations.

Use the correct field value for both caches.

Fixes: a496e8eeba51 ("PPC: E500: Populate L1CFG0 SPR")
Fixes: d2ea2bf740c5 ("PPC: Add L1CFG1 SPR emulation")
Cc: qemu-stable@nongnu.org
Signed-off-by: Bin Meng <bin.meng@processmission.com>

---
Reference:
- E500MCRM (Rev.3), sections 2.14.4 and 2.14.5
  https://www.nxp.com/docs/en/reference-manual/E500MCRM.pdf
- E5500RM (Rev.4), sections 2.14.4 and 2.14.5
  https://www.nxp.com/webapp/Download?colCode=E5500RM

(no changes since v1)

 target/ppc/cpu_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 9731bc0bfa..2de2684c69 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -2886,8 +2886,8 @@ static void init_proc_e500(CPUPPCState *env, int version)
     case fsl_e5500:
         env->dcache_line_size = 64;
         env->icache_line_size = 64;
-        l1cfg0 |= 0x1000000; /* 64 byte cache block size */
-        l1cfg1 |= 0x1000000; /* 64 byte cache block size */
+        l1cfg0 |= 0x00800000; /* 64 byte cache block size */
+        l1cfg1 |= 0x00800000; /* 64 byte cache block size */
         break;
     case fsl_e6500:
         env->dcache_line_size = 32;
-- 
2.53.0


