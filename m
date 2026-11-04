Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9D9606A32C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=u6I2c1q7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOesy-0003J3-Qn; Wed, 04 Nov 2026 12:35:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOesE-00035j-0B; Wed, 04 Nov 2026 12:34:13 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOes9-0006Er-13; Wed, 04 Nov 2026 12:34:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TiNb3GB9CQQ1/nusTeVxV1ZRxSUEr74TXjYQuFzfQz0wXvacMgh5BIEY+7TZe/fBo5TgOdqFzLngmDzmycTTOJjpVV3TY47HQTeYu+AHOXsIkW98RuMxyQEJiswKxCv6FUH0mxSAJuwsb2hXPIrwzZ6kqC1SnLJ8VDjezKgA7PiSV8WL2rOCMTIKoVXhJjvtD54PwjJfDdW0ilDZ/cj8rzDhUNkGM41BJEDURmc//bVrA/78H80tGHd3PZXOrJz7L0GiJWXVlBSnJ6roQLgCj78LDrpc1wtT79tH4EbBu3TOa8LoTjqlqrgcB0El+uH0pQrqlgofBvBba9m7gMb1ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oG/gX2E3aG4iCZbJEbGmI/SnMg85lTNOomRXKFdrmwI=;
 b=AEqroSiNBeQ8JD6MOLF4/UDfHxfZVJdPK3Eq/kqCDY3tNW6pMMnrgJ6UnOCnOUhhhMwNU/Gdju7OmliGTmlLuyh4EC0v1jWVuti8gDYxxi4khvBjnGlY4lzc5pz0hufps822Yz7H2YKwebzw3oX6asKwv4IX1yfoj2bouFg7txnSFpYsXMfnPgqau2+TMyHFkXUCD2xOBjNQ7cA7OuWTd15SNimCgYMEniNPrhmO7arUcdqFs5HvOZ40xsqXnPiN2vQ1O95ERDZjFKfywyt7az2LIfHrA+32RaFoQ7eSWjIQweRpUvw9F5z02buLteNzCgfvlCdKqi9NhTYI7ptrXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oG/gX2E3aG4iCZbJEbGmI/SnMg85lTNOomRXKFdrmwI=;
 b=u6I2c1q7IwXLkvMwy8QJ77ueg8/tvGXOeUM/IthYXPzZUy3d1ZOxdcJvge79iza0LQvyMfyxA/eHOP1D2hmqzxFRI74Poqzhcccqq/Ity87tEEKDfEUrh2zfBYGmfBspUK4edsf8YpvBmWen6PzLqRX9fhf6Rr8rJRcW4bIGH9lxxGfv9zoBTfYDuLcorA+lXkkI22GIpqB0gvcM6TdqCI5W6pBaudyA1s1OhPM/PJzrv6GghpheGwK3JFt8mqv6wxxLJmlr0n3QWqxnoS0MUpJcXX7XKIDDoNFXtre0RYgWrGRHfIOuAyqyoXQWRj+SDbx8SV+YcUoGfMf1okjMAQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by KUXPR02MB8801.apcprd02.prod.outlook.com (2603:1096:d10:4c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 17:33:51 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 17:33:51 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org, Chinmay Rath <rathc@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v2 03/17] target/ppc: Correct the e500mc and e5500 cache block
 size fields
Date: Thu,  5 Nov 2026 01:33:06 +0800
Message-ID: <20261104173329.706635-4-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 71c6b273-2795-4d64-d6d5-08df3a99ca61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|10067099003|18002099003|22082099003|56012099006|261026121527099003|261022075727099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: WJ7oFu4p779610Ej0v+ngSQnBhS9HdvJlQE7wruhD0/shXlgpCfUMXjdigcWbAIy4LK1PbrFx/AH3Nuc2QWNsYMho2WyFubZ3Ki7Aiyq6uevOjSJ7dITmrw+V72RZYvLz0zrw2sW+nVSMiNAACkamOQyCbVMxWwfQkqw1AZstJ9N/M9jU4ifoFB9/jtJ18ApFZO3OD1XjtrJVfECECKCEruGmNDldIdZYd6l3pHt79TALiWN46R3eG2B2YXGP8gPNml+iRBlup1GPsr6V++i+CHsCQBj75JM3WImZqAEgqm++QMK1DEbKm4hbRl/lc9kX/rBzQjyDfe5OvoSWnFAtk+A69wQxnU7+OZXOu/Fy9xxHka3lptGq1H/9fjW/kh9pYhPmRtDiSjy6gZY1tElCYkCRRyJzhblWWfwSA5vjizNp6HXPTiHAiJXxjoZHO9pkJ5gL9Fy2RXGvTGhkdRrCMR0VBQFh5kmzntlqa1RKUf+3e0yqJ29QnyCkN4QBuyHgEl9dUvR113aoJAlBXqA+2kYts+u+mtvZbqZfgjF9f5kYg3OTzIvUW0d7euXJMnYNZc2r1mhI6GOaGDbQMs/Bwx7T9yQORw1YlKNZ9eqnduwfcFeZTqa81LOhll3cCOlmc85h72+sbZTmAoWN3+uLWE+fbtslkvOBxSMAheLlPA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(261026121527099003)(261022075727099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J8InmNXk2IJ3R7PIwN1P6XQo9n7+FO1bc1TVTlhikStTLYk4ISgjvYlGVO+B?=
 =?us-ascii?Q?W4j4udraj0kXOTjNMVUqzNPnAxVES+TInpw07+IKzuELx3b1rmOiBxmFwl6R?=
 =?us-ascii?Q?k2UnW2OVGxTwj98cCY0A9pmX92niw3eEPFXYQZiQ3fWF0IuxW3J5esbrG8MS?=
 =?us-ascii?Q?520KfAS2eiwZWEA67B5mCH2I9mOcOb6BzKNN0i4A2y5OXNIznGV/oqC1hwaf?=
 =?us-ascii?Q?T5wXwEkceG+z9yVXsblzOSjwXlsVnBGMWtbdVCcoQ44dCq6H5PR628ee78Cg?=
 =?us-ascii?Q?tLVmlSH8DGFhRmJNPceuy6bBtTRq/BsuvY2ckwMAvvx7ywQ78+XlZcByxHPW?=
 =?us-ascii?Q?6CbRtcyglzTgpmkPISi3uT+zXcJQcyoej3NgZNASRp23BZfE43aqrAM92uOo?=
 =?us-ascii?Q?8eVjli5nvsp4Z7MLdysmqnj8bSMFy5h3m32Bmryo2frXq6KTZah2qu5l3haB?=
 =?us-ascii?Q?OQo+6iqbuxvZNzUxXShCPjkzrTScuVvAJ9pgKuAAEK6vfGjy0kgnFWkXOhoa?=
 =?us-ascii?Q?1rqRIFDsKCbg9Jx2kMBejtS88cWXU9Q8CKnLoe7O/9xXFK6+dCILvOYKpTnx?=
 =?us-ascii?Q?NHh9D7RTs3i41YVRS4kc0W6AePcZnn5y8h433wbA9ZsjYGivAbI++u2X/35F?=
 =?us-ascii?Q?yFeTr4vgYOqxwQxfQvXoyVyUlqUmUtH4cCYG1xOyipFCmPgLGcE7EvncZ1N3?=
 =?us-ascii?Q?8jPQwD0Vl/3TpvWaZIGxQvWCw/FBYUyAP51bcOq4RclpohWAVABrkHXMURAD?=
 =?us-ascii?Q?JKgL6tSRE2wMAsaelqcKpCMXzaqUhpLUNV+jOdUe1fUTpscwvZgjVWr1EUPU?=
 =?us-ascii?Q?kNxIrdLh+Wcu2l/Hgm3deY/81NJvZxIBGKM7iThKpfN0Cp8vNKADyX19xkNA?=
 =?us-ascii?Q?gDpXA/jIAos+cMmvXxz9XHHzrUwRNeUTDe9HfgXkJ4Ju2YGDaRTAXeu4DawO?=
 =?us-ascii?Q?BXf9oIl62TUfk2e0pTM9b3LSarjFazrQKCSt6vY3frC/rwqcHzZHBExdGORd?=
 =?us-ascii?Q?/94Yias4aL60ddleY52KPzIK5rNhblDMpdw5541EluOVZKEN7vNQ3GbRu53q?=
 =?us-ascii?Q?s0BATaSkMN9Pqzt5g6NFyifzTzoZt8ThcuMW4I30CWmK47TMGT1bZxNdZF8G?=
 =?us-ascii?Q?P6/slIFrdu4T2lJZdoSptv7iwkeWsy3ChsmZtcoRpyId0qMpOh0PU9KJsuz2?=
 =?us-ascii?Q?2pKSSb68C+mVK3r+qib5S6MnfW7K1c5qTL2dcyII74S8hnTc1V5HMknI8p6F?=
 =?us-ascii?Q?ouhAS2x6HBAZDzDBZu/rJcRBpQDmdpmTEI3IK419aBIDHarCByy7LPYECRUt?=
 =?us-ascii?Q?OsulO2mutgX+mFzW0WF/HJjc0U6XABPnLBWiaC+KmmPmsPGy+sZSrvJBMH0M?=
 =?us-ascii?Q?nN2V2sGoVpRd/IDrqXxq1HS+IeItLwGOZRktSGFSHaK8PixwCg7bgcU1vWe7?=
 =?us-ascii?Q?vPWE7/mCjiXNPjG0p2iPzB9NPQerPm8mrRhz6ptDNY9ptUMfG8RKZL8v/Zuk?=
 =?us-ascii?Q?hSZbsQ+viVEgCK8fHMbAL/hmSngIpGymshTtIN6ePh33GPSBGih0hMKqqkGd?=
 =?us-ascii?Q?MeHN7WjnbwK2mFevz7VoRwQIyT93Xf/Tl6KMrRo4jbOoo9cJbMo1Xc3fUwOH?=
 =?us-ascii?Q?ARkd7CBWs9d4u+VxGqpphdjTuYmY9OQMXA/dXcNIANQLVgavucFrpjxni1lB?=
 =?us-ascii?Q?Smj0xjWTpCMhCu1ccILN1+wa9bE3y/7DG/yZuHc3jm92coMBbaGhSHE3osu9?=
 =?us-ascii?Q?OY9AR1P0a/42qPEaveahwEbobKi8O9U=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c6b273-2795-4d64-d6d5-08df3a99ca61
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 17:33:51.0468 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 69m6KV8t8dXm40Y0JAD62rYqfi/ICYWoQykY04swX/xf/0MZVLVU3nXh9xoPddqPFNGgjsjgyg9PM4yHHJW7HnfbLyiF5ehlpyblysvSDMA=
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

The L1 configuration registers encode a 64-byte cache block with
CBSIZE=1. The models instead set CBSIZE=2, advertising 128 bytes
despite using 64 bytes for cache operations.

Use the correct field value for both caches.

Reference:
- E500MCRM (Rev.3), sections 2.14.4 and 2.14.5
  https://www.nxp.com/docs/en/reference-manual/E500MCRM.pdf
- E5500RM (Rev.4), sections 2.14.4 and 2.14.5
  https://www.nxp.com/webapp/Download?colCode=E5500RM

Fixes: a496e8eeba51 ("PPC: E500: Populate L1CFG0 SPR")
Fixes: d2ea2bf740c5 ("PPC: Add L1CFG1 SPR emulation")
Cc: qemu-stable@nongnu.org
Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

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


