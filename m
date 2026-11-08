Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5305F606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 12:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=qMynenFf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQ1cl-0001Cw-3M; Sun, 08 Nov 2026 07:03:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1b4-00075X-KB; Sun, 08 Nov 2026 07:02:08 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1b1-0000hv-Hv; Sun, 08 Nov 2026 07:02:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pM11/IkgRXpE4ujCgxI577+qH0x7yd0G2kcoiclG1k0+ytGUdEG3lz38bgyegra3qxeWY1Nl/Cp/uoFurfLgS6pRREW7qbNOLousNHcUHTKGR7sotABqud8BKAXYwCFplmcn+ErehqSb18KEU2ziAwn5ikPyB95TPWvPTJwHz1SnqPJ69qpfLdphHr+JDA9QEzp2C8k5hh6idWbntFEX+YSFW+TqbX34FQDPJ9htChMjUAutjVZWdidFsoW9987k+X6Rhb69Ef2i3Im1M7RPuiy5uTJkhMl1l2Am+OPlpvx/WkOW7/0wsnnyEgzaRWzOejRkrOkOvLeKpkFsbLgdRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Ih05nJulPfsErG/XDDI8m+yr7a9ofhesdIQbK6kM7Y=;
 b=lL0M4eTs8xc8KF7ZFxv9bBCkvgrFvDqtCW+1NAWc+5fD8WWz4FMYUQ6dZSclL8H5sfrHfa55Eyfe+uCfp36j8+89xLrVgG3n3pEaDbvGgv/MKoVoA6a3RwdEj/19lchVOAtxZosFY3eTP7Ur/QZJVSgBCjol9DYDVYcE1kgbQZ0h6872hgG0kb88/rcT2cvLdyEJtdqAOx9pf/lJ70sGu+bSM/zpkQbM9CwZHu4fdEHogHMYIymlgeUlfBIm/AmkQWTvoiON2pTAn/svU1gQ9nkTzfguzr91RUBdnkL8QkKYa7jNmvt3+crwGATfr+H7M2P86h3iTBSsAgeeVRq8OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ih05nJulPfsErG/XDDI8m+yr7a9ofhesdIQbK6kM7Y=;
 b=qMynenFf+Wxza3moqVtQ1cHjYbeO1TZeCD1dXL10DxpFuu3m1W5UNy79Ku+vvi7iLvHIrSeUsusQL1fi2F4yisP+Awk+GC7XAgRaWqyjW083054dO9hMInES1l8ZXRMBH86CraFhCWS9LpQnuvEl7oboLhGTzq+QH3QHYu7voBEOhqFvMm0ZYKJqeq9+sDBa+vzGnuR3D0d48/0FmcI7qbI8jnTt3RbB+Egya0mwJaWINC0iANZmFzcpFv7Q6E43y10cP++cpEYKKwmQIF2WAILT8a0sIySbPVHq0kip4khXwMJt90VXcEXVOFHaO1TP1jhLNj/ETlxIQIf1LR/M2A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com (2603:1096:820:116::10)
 by SEZPR02MB6945.apcprd02.prod.outlook.com (2603:1096:101:19b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 12:01:50 +0000
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c]) by KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c%6]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 12:01:50 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v3 21/23] target/ppc: Express e6500 TLB configuration with
 named fields
Date: Sun,  8 Nov 2026 20:00:20 +0800
Message-ID: <20261108120034.1755008-22-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: KL1PR02MB7144:EE_|SEZPR02MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: a5f7cd2d-fd1a-4e6d-ee5a-08df3d901295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|10067099003|261028144727099003|261102123227099003|261022105027099003|56012099006|261021123027099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: XNcTg7l6cgG2haDbn5G8lhHnHYaOYZqTwFfn9zYeEjxv0XW+2UeLjrCGYKteS6BnRb3gGPWTmn4Wt3yhGXLkpzXO5lNJBphrODd7dY51BaqRW5G9Ewh4ecqlcmUF0Iz0/1P/ixsOe+Ca1y3uZ2ATEFsNnhRjWrIZmmVWIrxWuxO0ghDDOUBa6+YH9qDkO/vUmdXpvw+vBTf/eN2idW4IQNuWHTjRcCvXBHBfeY6x8mS/W94HWY27csPEn4ObQJCUaDEoVun6xh4VMlZfkqPW62yK3Dbtx7CldbmfARFCvBoyfRM4NmiaN/GUY0kuArk43FdCYb7m0sTHfNk/en3da/sPmj+hUEz+4gXBXwPU29Gv4qhRVTUr7agX3dJXEQeiXzWslbTc08+bEhXN/NNxA1bWM9h/hQskfNuSn3qw2ICLXTDnxx9wfiXHcqxcksypGpkQoHknkI+tHKhzsTHTFsgo6X/Tc6R6YrYUoBBn1KDZxoTHf+TW3U+GOBkYPkMIXLom5aikH+iYrTd2QPZ5raGAc9qUGiB6BYaNCxP45f99aqs4GapKdkuTyA5QMMEL6j/1bB34XDkphkP3fVL8bBjiQpa4vVzlq+IZ6aLkrrYESMS3w+JMFC0XKLDtpdu5ZIndwyZ9qzarjcJlsMwqAIVS0BuxDF8U4iYbS8h8pEQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB7144.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(10067099003)(261028144727099003)(261102123227099003)(261022105027099003)(56012099006)(261021123027099003)(261021121427099003)(261026140227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rGwUoDYijAQCxnx9ly3nxH/e0X6UmFE1Ozir2LDbA2o2YeQrMAs5rRoqUkGc?=
 =?us-ascii?Q?CS4QDvDE0kMmvlfrotIJ3cSQSyu70S/GE+rHE8zaTXuxjhplp/4pv2MSooP2?=
 =?us-ascii?Q?nOIs7VIdJXhRrt2EWvWVxthOPIiU2lUYSE8M3OHCu95mxYshwopl6EyzM/Hc?=
 =?us-ascii?Q?m5vO3SeE6D+1nQHXJWrG++NlhlicfuwaQY7N9W3A1ahySup+VUJ3nfSu4xwu?=
 =?us-ascii?Q?N/7OheBokQtxDvRkbDao/+cMBClXSHDw29SvfHxBEjRXai9p+jtOkUe6WVKH?=
 =?us-ascii?Q?NT7s0JegwOowbTp69hSD8HwwaPmjIK4viDpjJMfDcWdeLZx7jBfSN4dgd7dG?=
 =?us-ascii?Q?oB88oYEdBHx0gJDa1KpkK2C4ERYWGbffvEWteepE7FPYOkbm0B7EAtpQ6vDi?=
 =?us-ascii?Q?GVTDbTF0vvwH5XrdF8ei1p22KbOv2d7omT5VbHXFfeHion4SmMxZemvjKaaP?=
 =?us-ascii?Q?5Kcaz3fBy9dNb6DY3PvLl3ghR17QgP3/iyLILDqyHlTaRD9O9yx1G4z+mBWE?=
 =?us-ascii?Q?NRH9WFO7HPpmVkeSkO5VaTffSWjF3zfb13NtpF2ZwIJuuD3racEsm5tTCvRL?=
 =?us-ascii?Q?sMGQQbpbFhZjN6DsoEi1W0oODNATxVJO/UV++dpcY+ov75NKbfaV50GYjsA2?=
 =?us-ascii?Q?VCkb/RjCI2H/wfoiZddNpxct26K/rKCIsxxeObQwoTL1ADLiWErTSBffCsXd?=
 =?us-ascii?Q?HeoQzrteGuETT3fcVloj6pM4a1lpJdRVLxTkW0Y3StY5z3pZosizFHwBSfAO?=
 =?us-ascii?Q?kVStoV4LjDi5uWswM3m0Zmc23t56cY6Cz55btNUmdB8zWI5oryB+4rn90IUQ?=
 =?us-ascii?Q?xR4SBvvF6dWoiGcx/nFwgB+IAxbZ4SS53EVPiLAtxghEDQHMzIOS6Q9KEJ49?=
 =?us-ascii?Q?ssFBGnf34AStBu5/pCl4mw6Dze4bxiCj1OikQ/lJiQrnyzIsAK3nFqKAQOgM?=
 =?us-ascii?Q?udqrDEs8qjYsjJmuHmkjpBlycpICSQMnvXuekwlTgSF78Wz/367UHPMlzXqW?=
 =?us-ascii?Q?ymCho4yAFDVv39eH4WvZsPdak6C//JoxR3n86urY2W0UfCHubRCurdz2XY3i?=
 =?us-ascii?Q?HFIkbxmzA/681phF2D3OsGcAhEu4iXe7mwL72B93FdDzRDrPUh30Dow9URd8?=
 =?us-ascii?Q?+/TK/AUjVpw/8O6Ct/4lWHSk/N2JZ5AUWhHfifmaxxmoy/7naHkLCs+wU1XD?=
 =?us-ascii?Q?w9n1Kbe3NvWituRgvC+VlzmgbzaEqOrhzuAZSONXY4xSVLLec+progSX0aVk?=
 =?us-ascii?Q?8vUJ5akp95WLQo3ghcLrj8UAnYCl4NG/Nf12pUbDwbjvujgYRbQ0GxsGy3Zw?=
 =?us-ascii?Q?rbKfwEDujEpyuNuMvtgKiZMvXyoIejqlKjDT0GO/W6OWKoifbsIP6ML2uFkt?=
 =?us-ascii?Q?UwDzDtE4Tbxgzn5iLBTRktFYRSRZDKf9BUZP7bkW2cTwfC4MSC+HkLkJoFeN?=
 =?us-ascii?Q?k33nla3O8hIpq+yeyflt4uHRATch/azUz4cyIadsf0bY5v5tAP+6zr4yOCPd?=
 =?us-ascii?Q?9eqRc+HwFPFzo+HGmqbOOPPuDbv3twxATbXTngDZanUIZhfNEztggHGUTrOB?=
 =?us-ascii?Q?oy9WdhDHs8oEstkaScNxR0HHngwZbgnzCEvp2UPaLHk1k/IPu6auflqr49yK?=
 =?us-ascii?Q?GjVs5Bw0oZmuoXg8tbpkTVtKZQE1XRblm3PlxPJbmKrhMpIbTmcvjMB7HNNt?=
 =?us-ascii?Q?JFtpnDQscbUVQfgGQgkHljB6gzBks116HZaHE6PEb3QEMU4uqDCgBp9xKWyT?=
 =?us-ascii?Q?engGC1DakAnCc5uMmbXKCZNDGt6cAXc=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f7cd2d-fd1a-4e6d-ee5a-08df3d901295
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB7144.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 12:01:50.7945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QRrWnMlIGfBIjGPLL9sdgVL1xFjw2Drhu4NBwYFITsqLIG1rogzj6HF2Z7431BZeCB/4lewlh9DHjUKH7jgB+5AMdv6WUf1LFoyo941sFjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB6945
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

Use register_tlbncfg() with the existing named flags for better
readability. The register values remain 0x08052400 and 0x40028040.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v3:
- New

 target/ppc/cpu_init.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 8cbdd36df4..b522702e2e 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -2877,8 +2877,12 @@ static void init_proc_e500(CPUPPCState *env, int version)
                  MMUCFG_NPIDS(1) | MMUCFG_PIDSIZE(14) | MMUCFG_LRAT |
                  MMUCFG_RASIZE(40) | MMUCFG_LPIDSIZE(6);
         env->nb_pids = 1;
-        tlbncfg[0] = 0x08052400;
-        tlbncfg[1] = 0x40028040;
+        /* MMU v2 reports page sizes through TLBnPS */
+        tlbncfg[0] = register_tlbncfg(8, 0, 0,
+                                      TLBnCFG_PT | TLBnCFG_GTWE | TLBnCFG_HES,
+                                      1024);
+        tlbncfg[1] = register_tlbncfg(64, 0, 0,
+                                      TLBnCFG_IND | TLBnCFG_IPROT, 64);
         break;
     default:
         cpu_abort(env_cpu(env), "Unknown CPU: " TARGET_FMT_lx "\n",
-- 
2.53.0


