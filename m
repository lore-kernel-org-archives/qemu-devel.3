Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED002606ECC0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=TOT1nhxz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOetO-0003jB-A4; Wed, 04 Nov 2026 12:35:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOesG-000361-Iw; Wed, 04 Nov 2026 12:34:13 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOesE-0006Er-UP; Wed, 04 Nov 2026 12:34:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tcfgF2CkFCWd8QIFTffYBY9a5vKBLeO7EuQAQMISL2Yx18Q8jvM76VDonKGEEl39i5lRKss03FBZODQd7IKuvb1zg6Jh699MC+kTbAtxcsr/GD/cZt8Fups4ShZ+a87XLV3vPR3pAyEZdwaO7SXP6xMnAhKrdNM6nVvDzn3XmUhWhS1tuqHV5I5adG5TyEBobkz5kAiBIbSbrsGS4XybzuRXPx+L/PTtf7vDVj9xFUIVslqnL9+vxmgatJDtFWlvIFeOZNnoetSZegnq/VhG/Q/sa6H9AW01/rsKIo7Bwpra/YedOyanO4n9A7dyKHLSYYk2YxTSL6iz6dF3fFv7cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7imHapBasv+lalQDS9Zfjwlm5UbxFQhVR0cVa7XB3I=;
 b=cvt6jMvLc4JC42Tn4iJw0iD6HdTsu0pDfQu3qrSKau9doVcdzuDWrrEG9kCASVv6xINtO5G5fcRrqvYxND6Wf/p2c3Ym8PY4DxKMZTnmTREwDm8IgHqgZSDBOGhFuIXsJ/UqgCBsNhPozcXRou6wTY+G3uq1WMnP2Z381F2udwyHJPECC4/9dvnuiah4b0BCTg+X8b/JED28rseBGNuI+T9mFJNkME1KlJdh20g0hKoum62Hu0Lanjg9eocG8TjbGKLEGp6pnPOSDcIHqUGNsw0kcPWic+xJ7pfqwGLMBfXx4oGEFh7Zea7OY4Pzv4SSVvLFEayPgrpzAq8KVnaJPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7imHapBasv+lalQDS9Zfjwlm5UbxFQhVR0cVa7XB3I=;
 b=TOT1nhxzSRckeGWhydwXN8EiWxAwvpAOxxeT/OTtre0eKND8ylxEOciuF79Mw6dQPrwShG9Wx1STe86QWDqhpnDfPjBF9Hs9kLm2n6sRt7kSf2CkQd9rnuOzALVhudtyXoRtRGQ3fJkfsa27OEex5jLHEQtg1CpWGPpq0bk5qugbQT6PAfGWHHbpxmxkxWGcYLUQnzd31tKe6xjnkaZVj6BExWJKHHA4vTU4OUiFPaunGcOavKnf6E3ZyJ8d0TUAMap3VzNDQLt36QJw2wZJ/XEaofo20fV5dJ68jKQRmdER0li+f1PwTE9EujlrDxKeqzz8+U7DxqnLpXNch458xQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by KUXPR02MB8801.apcprd02.prod.outlook.com (2603:1096:d10:4c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 17:33:55 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 17:33:55 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v2 05/17] target/ppc: Complete e500mc and e5500 L1 cache
 configuration
Date: Thu,  5 Nov 2026 01:33:08 +0800
Message-ID: <20261104173329.706635-6-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: e644eed1-483c-4d65-4dc1-08df3a99ccb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|18002099003|22082099003|56012099006|261026121527099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: t6H987KCHdl7/IJmNGMOUWPvlRj3lJCozNo2q6pjWTbFzOrjcIu+FbnY5cTM6zWXJbl8+xVuoBSMwsGSoAS2K/XGGlwYgOiz6+qFwkXWNtC3KMuINRm/OS1nA2R+bSL7S5537eXuNghLBl/+Jo6Tr8XL08tJhpJ/lyHkzl+vSQ/eaPl1N2Vy0MSZqSz/Ztv3AXyW48RLoA1Cxu/KhGg52ILkqTdMHVkK/08uL1m0DLYnXv9ggUH3/ZizinNgFN1HOa7GKhNfISib1GUd9K/IfZRSJ6wB58qpI0m66gc9b9lDNQF3dteJfdQfhC06Y/wisBNThiAxVF15BHGWwpBLsoFh3Eft04Gbv0drlD33qQ0pdsAa+auWUaI/5Yc3xLsayMBGk3gdcUuHMLyb1OvEiHiKP7L3LBEWYwkRV7rmxwIbs2pKMESoMBOPic8dE3W22q+VdQG5QNWOfYLON+sjP1BeMOE8+RUPK7N1LWlyAzRKpZ6DSCSEeed1PDpplWQzhkBNJ77FoXcTLShOPDZdJMHCkqyBOH+OU+9w6YyWvbhK3REhrcVwZ5RCugVWfHxiWAUJd2J3SXvzJ32FrWPIDpnNoU5lt68qzy34PRt8KwkCU216geuaCMLnBVZWTTgnBkCgxzLxkJ4/zLYlED5VPHYBAm32VvEXfIPhgsxxEFM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(261026121527099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OHCh/NpgiFtEuWlGTHQ7KTDRPhPw8p+Z2RNxVoM7qJwYGa6pIkNiaEgD9pm1?=
 =?us-ascii?Q?4XoYGZncQvkgSShDb6XyadTLrW8ubXZEuOEIBd7iLIsthYmcOFgGSsE4bRaW?=
 =?us-ascii?Q?+8b2skVNlu0Xu+MILBrqP+s8UXsY4N8sdYTFqfyvfIpavc7jmZfBBGGzfb/w?=
 =?us-ascii?Q?fiEAdynfZRYBarhiZJEje9ur4K8mRM3/wnEG8YG0GwNolkHzkO9YSUkKB92a?=
 =?us-ascii?Q?eV4H4iPJwCyQU6aKNB/mF29pnY0BUcPjUZeLxw9uJpGH01LHvGLMkUJ+zLIm?=
 =?us-ascii?Q?A5fNjam5rMGVUvjlMhTdNLHT1amWyxbuRBllILjQDGH9nSaU3ku5THws5fcc?=
 =?us-ascii?Q?gG+1KrRN0EOFSSM+/QacbXLssyK7CYt6hhGsl7xHaGEd5sh9CDBrCrHZNP1N?=
 =?us-ascii?Q?8/BCr7A2mCcBEKjva4QpTBxIIqlMGbQjfjTohroMoQ6CMPoBJ/r3CVoEyTgG?=
 =?us-ascii?Q?HU5PxQ7DZntGjL23kj23CUUNNCAIKwYfvIj+QDoTyz/SmYQXMJB1svJq9vin?=
 =?us-ascii?Q?Zjaf3ZaxqoG/dx2Rp/nX/d4JeuRHJ7tUj2TWdTiKFVSZ15buvoMYVl84uCKI?=
 =?us-ascii?Q?Zhekcln9RZpItDTkOgi6UsrSbURsZDaB/4EXsg6Ia683TVPNlNTX0NjLo+DX?=
 =?us-ascii?Q?6952vjg68w/Vl9xS28ltT5pKG4Lkul5IpcgmBOM506oZOiNqGNJcj9QwYjzy?=
 =?us-ascii?Q?wn7HHUPXXeVQYsCjPvdOd0vMhqvlEzIDIp5hF3rkC5QsGeqTFfKQu9R06/Wy?=
 =?us-ascii?Q?s5063BM7pjJ2H0sbH02KoUmUuidna7/6HoBfycJhRYBwIURyii+s+dNfkjcc?=
 =?us-ascii?Q?Zx+d/D8ktHnt8hA1BYjtyBUxsw3aqxHooaMsYHsdAvFhU0go7x7Rf93mggs1?=
 =?us-ascii?Q?br0ReBDDA0Yf6gBBZ2c3USNvrrnqLKMIgJkixRyhTC/nkOp6MgNio5FSS17K?=
 =?us-ascii?Q?Hmnz00+KhQHTWcuGorG7kYvNm49uasIpeB9ttWaCPOcCEU89Z0O0w5aEByYo?=
 =?us-ascii?Q?irj9jVV7zhURyAokpfifODokKSrdetUnoLaGnQENuzBxHRjfdNd9duYyW9PA?=
 =?us-ascii?Q?S3TxWHBj5RqIOnCFnEjXFMEm8m/iwAnbReWx6gNecweiTP2eB7asPRCDOr8c?=
 =?us-ascii?Q?miFBuJjbJ0Wb5t8oNWuI/T0ATMYp0djtRSq0L0Db8csTTaU8B+xpHR/cf+D4?=
 =?us-ascii?Q?Jtq9u/9nPgO5snU4Ur5JD08zvNRWM0pjPqkaKcparOfxuDnK766w2gXwBOtU?=
 =?us-ascii?Q?7DVPogIYBomtZyjpKQFZ5zb/sDjbBtF5OBAbD9AyjZumo0tY4zwMdBdwcZ2W?=
 =?us-ascii?Q?ZScsj3DymPpvglSHol+PI5mbTI/L+9m7aovejUG9wjkoMuRAroPYYputjiBT?=
 =?us-ascii?Q?brhXusfLZuQZWoXJAw1N4B2BCsib34RHWX7qm3FJt7FQVSWKta2nnobnTm+Y?=
 =?us-ascii?Q?UTspNaDOHE4fXptvafrGhKE1fSy5F44oGEcsOLLY8TQAyIW/1r500pINjPmr?=
 =?us-ascii?Q?cr2+e5XhHmI0lFBlbHevid29YzB8rjLI8FXnittvP5Ahf8X3k6TUaQa6VLbs?=
 =?us-ascii?Q?gJh3q0EYfi4s72+u4CcHnBACQ4y1E1403HFjxHw4oOqumauPJhPSntqInvp3?=
 =?us-ascii?Q?VM9++U0Ek/Bbm3gXavL0cVfg+z9uMewXy9cUO7do7kAgJHkpnqETLUrYRJBr?=
 =?us-ascii?Q?d7dImFrWRdlx669ji3mgQikHXl77bcQh1J3BkDra3Fe8Wnfv5x5VsQt0zpYS?=
 =?us-ascii?Q?Djh1UuPzquR2D6uDVWz5d5aAGJ6lV4w=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e644eed1-483c-4d65-4dc1-08df3a99ccb0
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 17:33:54.9230 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ctMI+xxfdqKQFGQqvPVaRviLbE4wunv+w3ElYvcZE6gXUBP3SDOC5aNXAKZPuKTaQdo1EvWmgAbiF2xRlxzflh3TpVwSs3U90d+z0QG42z0=
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

The e500mc and e5500 manuals specify pseudo-LRU replacement, cache
locking and parity detection for both L1 caches. The reset values
describe the block size, associativity and capacity, but leave
CREPL/ICREPL, CLA/ICLA and CPA/ICPA clear.

Set those fields to their documented values so both L1CFG0 and
L1CFG1 reset to 0x00B83820, including the shared eight-way, 32 KiB
cache geometry.

Reference:
- E500MCRM (Rev.3), section 2.14.4 and 2.14.5
  https://www.nxp.com/docs/en/reference-manual/E500MCRM.pdf
- E5500RM (Rev.4), section 2.14.4 and 2.14.5
  https://www.nxp.com/webapp/Download?colCode=E5500RM

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

(no changes since v1)

 target/ppc/cpu_init.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 3be3e44aad..e2182720a3 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -2886,8 +2886,9 @@ static void init_proc_e500(CPUPPCState *env, int version)
     case fsl_e5500:
         env->dcache_line_size = 64;
         env->icache_line_size = 64;
-        l1cfg0 |= 0x00800000; /* 64 byte cache block size */
-        l1cfg1 |= 0x00800000; /* 64 byte cache block size */
+        /* 64 byte blocks, pseudo-LRU replacement, cache locking and parity */
+        l1cfg0 |= 0x00B80000;
+        l1cfg1 |= 0x00B80000;
         break;
     case fsl_e6500:
         env->dcache_line_size = 64;
-- 
2.53.0


