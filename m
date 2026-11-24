Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CDC606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 22:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=colorado.edu header.i=@colorado.edu header.a=rsa-sha256 header.s=selector1 header.b=QS4LpLKX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVyz7-0005he-AT; Tue, 24 Nov 2026 17:27:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Victor.Jimenez@colorado.edu>)
 id 1xVyFa-0005Uk-6Z; Tue, 24 Nov 2026 16:40:31 -0500
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Victor.Jimenez@colorado.edu>)
 id 1xVyFX-0008DO-G1; Tue, 24 Nov 2026 16:40:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJSa8t4i8Yai+WrIVR75Z35a1JXsEfDGXQUsWrdx+bgyNrKcoLHCcfELmCxicut5VM74fQIEwAPs0RBWER14MXcXK6Z2TqnIPpWpiGvaXaF0JJvWye+INQXN/dbwdQSh7c4nUmifgLkVl4Z5DHx5yfoPXp5cLbk2PzyGefS3B6IoPHejzFrkEv+qCbkDI9Ti789bWBKR+TvXfzMgGxF6GG8G6tq5RVqFJuBTT1OWkaNBmFRGv28AhKKD5EIm+yRBSSrUmVl/DKsnQLRDfxWB4Z+wn170qKGuvI2PGDtaT+DxJMyHBfosdiIxkyt4tG97m9pLUSaqtvYekq9XkfY+qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijtp/Y78iw2oiiocZbdMTvOaq63DxnAYa6p/99p0v3A=;
 b=nOfWUJQdNLWv8hI+aZHZcrRSnVHIgVZSzhAthb3s6Or3yZ2JqBCZ2IyOFvgVHiSweq97MpUho6sHiYTk+4+/BZ6l4nReMyp8Mg890shysS3GcHcOd98nFNy7+Fw/1j23YIdC3q+pXQYtF7Scwy+lKWcf6aZbF+ET+CLqwMfVclnhqlxe+JizkPiJBmsxqAS7DCAINRVnLQ3levof7XEcvkNGSdw/5WiwQlO7B7I7gzuPx96fRS9wVHCBDFOh5WZHDouNSxOYNlx7YlDUUrkY4RylOEdSqzY499suFDt6alCZK81Yc7t8UW7b3NHDSzYexI9Z3t0dfwbSJLR6qV3Jqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=colorado.edu; dmarc=pass action=none header.from=colorado.edu;
 dkim=pass header.d=colorado.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=colorado.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijtp/Y78iw2oiiocZbdMTvOaq63DxnAYa6p/99p0v3A=;
 b=QS4LpLKXs/Vvq0gzhjJ8JRmAElhnaRd+T1p914BOmnYVr0NSKHxTp+7dydGuw+Q/ElnTEB3CDuXNK56RnlZ338fhfskpB6u7etpuHinmz2EUPfa2yx8KLNS4QVIvH9zfclNxaoJ32pLFEft3ucceAn8dJ2l7Yr/KiLiI0sFOAKeCFGiriU2JHLguAU9rOeyAGy4FKBz+bRXJwgQJv6B+JbMUT8F7S/rVbXgMzs/zJD/TU0L8zig+eNk7g7R2f6cd8Km7tViln0+tYPE+oClFYJ0DbGMRvnYoPhtK7q2KuDSvtNWHq3S6R2clFEl5o8q4JOJ7Qd/TUmMkHsU44Za2Ag==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=colorado.edu;
Received: from CO1PR03MB5683.namprd03.prod.outlook.com (2603:10b6:303:9a::8)
 by AT6PR03MB406149.namprd03.prod.outlook.com (2603:10b6:170:116::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 21:40:19 +0000
Received: from CO1PR03MB5683.namprd03.prod.outlook.com
 ([fe80::8f3e:f0db:560a:60d5]) by CO1PR03MB5683.namprd03.prod.outlook.com
 ([fe80::8f3e:f0db:560a:60d5%4]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 21:40:19 +0000
From: Victor Jimenez <victor.jimenez@colorado.edu>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 wangyang <wangyang25@otcaix.iscas.ac.cn>,
 Victor Jimenez <victor.jimenez@colorado.edu>, qemu-stable@nongnu.org
Subject: [PATCH] target/riscv: enable cbo.clean/cbo.flush in linux-user with
 Zicbom
Date: Tue, 24 Nov 2026 14:39:59 -0700
Message-ID: <20261124213959.1699580-1-victor.jimenez@colorado.edu>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR13CA0058.namprd13.prod.outlook.com
 (2603:10b6:930:11::11) To CO1PR03MB5683.namprd03.prod.outlook.com
 (2603:10b6:303:9a::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR03MB5683:EE_|AT6PR03MB406149:EE_
X-MS-Office365-Filtering-Correlation-Id: 185b5e8d-9244-4eb8-b3a1-08df4a738916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|786006|376014|366016|23010399003|18002099003|3023799007|13003099007|261021121427099003|261021123027099003|261022105027099003|261026140227099003|261102123227099003|261022075727099003|261026121527099003|261028144727099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: Z1p5LiuGC+ZzwsELWlaAxK1JcPhKUvjh833awwxnq4GDRxaovC99bvGKlwD5/xHkbIlkcqMQUTcyyKZAmyrdoEE4ENzMFAfIDpbcDCWhd42zNyppyp8MjsbVvjDjxgwuDBmWEZN47kA74RF2QK0vWNUijnriWmhlGSr3swqaZxxNOye6GdwuAqm76x4MNO/AIvxtLxTyYeEcJNftwstn8Wd+7oqaHRFfJEoSEUL7bKwKNu2jffTlyOCpL5pywXDYgRIMBW6QeokGjssPuUJYEC9ZTmtvOi1X+07m9lqtDHNRz76z/Z/3xRu5UecNOkUer3fZ/kqhlfw2u+zY7ZwZHjqdak/MLkswaA4MqX90ZHFg6v3xz+xhBgq70jh4lIwok5lzQxaY4RfXOXw89bgTp6kZf/AeqnV2rSzdTgmTmPXbdiG1DVlFEv+ZgoREexKnzM6UND2UUlQyuopDNDbWsXQMpWAj5urWqNeU6yhJyIDcyQv3vBG7L4fYBF7YuZjocmVpuq5kY3I62EyICaCMqcRXA1FQw5unzJtgGgycHLHr3MGYA6JUnfG3F/ZdGAIFZ/cXTi2LRmC365tWMN3oxMa5Gai4S51SdzJjffecEc/pLnSM1mzJycQit9YzcJEG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR03MB5683.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(786006)(376014)(366016)(23010399003)(18002099003)(3023799007)(13003099007)(261021121427099003)(261021123027099003)(261022105027099003)(261026140227099003)(261102123227099003)(261022075727099003)(261026121527099003)(261028144727099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jpGGP2ObDW8NdpyguDz+ZccF4QyQc8sLw14XlPDAZWGq8re1ZP2sCIOzT52g?=
 =?us-ascii?Q?wp1YoD+Arv6RwVQbSWK/0PtIlQm06xfutJE3tDNNnapRHUFo3UveaL+yhHbh?=
 =?us-ascii?Q?2Y2vslPuktoztgPhMdwi1qSpBUXx2J5Cdoadz5WGbcTQTPmd/8obLwl3ynSQ?=
 =?us-ascii?Q?cCxrPwQk2057J7ZhGzj2mdeUB9Bg+mAj5qpHuLrvOFnch8Puz2AFdiaAaaVK?=
 =?us-ascii?Q?8rhEZPzxlxxcWY1nRp1iHCWN5gMEpIg5NJ0cfxynJQyH1QlFxEQkVQXVYEwH?=
 =?us-ascii?Q?RQ/6waTl8G8+x1yK1MVbGHLm7zV0IDQAhlAJk7DwwJXUcT2pCBZkqe2QOhGy?=
 =?us-ascii?Q?qRoyqj3wXKkV/4tTeqZt5SPnzRAwN2RJbQzpt3+Zzpd/T4W/jKAbAIdySdnP?=
 =?us-ascii?Q?FxmUjIfpsA1nrJWrByuqg2gmw3XRrqq/DBVNTOLcMaFrSaLFkmlZsd9kSKLx?=
 =?us-ascii?Q?cTjY9OGkM2uybXj6botMDIuEbbs3paLCSiVKkeHCXPtump6jZvCA4Yky0vsf?=
 =?us-ascii?Q?nRzJc1GFk8k7thVneASBR4gMzIe5YW8Yna+9KaC2q9rfPwtavWW3MILnPzfQ?=
 =?us-ascii?Q?F9H/IqsLLV6qvlZDnC9YDjmFE4Uln7aBpS4gVoT6+fzAkVPUY/fSqhmOoeeQ?=
 =?us-ascii?Q?MHmZ7mGpTACgnYyqf7+EXEJmeYt4dwegLTg3uG1hmDQZ0BO2GfEsJYEF1z+6?=
 =?us-ascii?Q?pRtq3TXJjtvzvCO+brBcKKwusrs2+H3Y5u1miAU2NUQsVCb0DNT6+x6wIRqR?=
 =?us-ascii?Q?+bq73rispuvck+kP/BqorLK6dpqd/WY0Evu/anYeZZA90IHad39raw5mFp9O?=
 =?us-ascii?Q?Hyz9SppoqmowqW1M4Yl+plxpOa1cWkBvrQLbdilXUyMSsuQa21oMwkmjpLIL?=
 =?us-ascii?Q?rD+vaRkQ4iESLMIbSJD1zzfkpz1sec3sYbEyWpqpGklIWiZfxYk3a8N02cO6?=
 =?us-ascii?Q?fBX7T5LaBSO47AXyHeT84F6YoBjbjGP4DxtNMAyqIS9ZZsix+izZtY42TvkM?=
 =?us-ascii?Q?AYsxAoD4sM1nFNPPVIffirIurmzvKQ//vQ0+/ZeuFV9lBWtELGPMiGAYEpkm?=
 =?us-ascii?Q?cJ557B30Es+itgGkcXqiTkAnLetVef7V3Bz+5UFGsKKA4cQwRyHP3ZVxVmJn?=
 =?us-ascii?Q?fy/afw2sY3pj5anRSBIJATMTZZLucWnzTeEdixRJ0bD0C8th8CWE70b0zV5n?=
 =?us-ascii?Q?iq1NZJYt4V6RyZSiM/LnLhOqTzHzpOokc4SYOarkrLuDoWgnq6GuMNzQmtcs?=
 =?us-ascii?Q?2CMmgloBhjAzIOrI9Ym9G2kjuHN/KMEshhZxRLq1P2YzF/0wRDqKhn6lvzwj?=
 =?us-ascii?Q?mUIo/BYS3SU6+Fh1mGYAaOjOWKL/mWwNmyuDLqNk1aGRyrD7Kw00PW9NfH2M?=
 =?us-ascii?Q?Kr1ub17uBh0NpUnyVLUS7TQ981yP57/SUL+j4ogkcXmIgXF63rqQOVwt5D4z?=
 =?us-ascii?Q?Qy5Vnoi3bEqV7dTrHY8f9ruE1/ac0bzndrGkV3d8ZfO5kjjZrrX992aVMubq?=
 =?us-ascii?Q?dA4WJkI/7iNTXXiDAShsn1jKmZL1ILJF08Gy15CBBD0pXyAWgxG0penwP8Dy?=
 =?us-ascii?Q?pzPmBVuNkC/WCHUc6n+EhKguybVxu9Xo7lsLHWKofhzJGhFQYB9J7MsImilL?=
 =?us-ascii?Q?vJfKd6GujY+nMGZeic7s7Hk6bElbuHj+CjY7W8qVWwWMqs5Q3/o/vidBuZxF?=
 =?us-ascii?Q?AJORRafsDztHtRoha1ZWXYFpxZq8uqKdeCtJjmfkQC7dRAY1Z9s3kklLLod2?=
 =?us-ascii?Q?VnrqGze64Q=3D=3D?=
X-OriginatorOrg: colorado.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 185b5e8d-9244-4eb8-b3a1-08df4a738916
X-MS-Exchange-CrossTenant-AuthSource: CO1PR03MB5683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 21:40:19.3303 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3ded8b1b-070d-4629-82e4-c0b019f46057
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RbXbLanYMHT8K4kRufA3VOllXvYNKA+B6PJeJM/Yheq/vPSKeNMr+syfkzHcjXxLrI4qkOgke1N6jpO2i1Y+yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT6PR03MB406149
Received-SPF: pass client-ip=2a01:111:f403:c112::7;
 envelope-from=Victor.Jimenez@colorado.edu;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 24 Nov 2026 17:27:26 -0500
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

Linux has enabled cbo.clean and cbo.flush for user mode with Zicbom
since 6.15 (Linux commit de70b532f91b). However, linux-user only sets
SENVCFG_CBZE at reset, so cbo.clean and cbo.flush raise an illegal
instruction exception, even though hwprobe reports Zicbom. Set
SENVCFG_CBCFE as well when Zicbom is enabled.

Fixes: 12289f2f9a0f ("target/riscv: honor zicbo* envcfg gating in linux-user mode")
Cc: qemu-stable@nongnu.org
Signed-off-by: Victor Jimenez <victor.jimenez@colorado.edu>
---
 target/riscv/cpu.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 15c27f4ce4..09332cd32e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1077,13 +1077,16 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     env->priv = PRV_U;
     env->senvcfg = 0;
     /*
-     * Match the user-mode view of a typical firmware/kernel setup where
-     * cbo.zero is enabled for user mode; the CBCFE/CBIE bits stay zero,
-     * so the cache-management operations remain illegal in user mode.
+     * Match Linux, which enables cbo.zero for user mode when the harts
+     * have Zicboz and cbo.clean/cbo.flush when they have Zicbom, but
+     * never cbo.inval.
      */
     if (riscv_cpu_cfg(env)->ext_zicboz) {
         env->senvcfg |= SENVCFG_CBZE;
     }
+    if (riscv_cpu_cfg(env)->ext_zicbom) {
+        env->senvcfg |= SENVCFG_CBCFE;
+    }
     env->menvcfg = 0;
 #endif /* !CONFIG_USER_ONLY */
 
-- 
2.53.0


