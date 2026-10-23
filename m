Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6FD606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 20:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKLdI-0008Up-Ig; Fri, 23 Oct 2026 16:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1xKLcy-0008PA-Cw
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 16:12:37 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1xKLcw-0006um-RK
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 16:12:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUFSRrOvtrslE8KAuRIIKyRj0HtpUsDrJOT4NBBjIrWAliGyXCZAELEcvpMYrm+GXUuZYBHBvv9xGPvrnh7pe4alCDyE65jzgoDJNU2SfT0Tvm16t2p7bBzwCLilGUzRQlItdN9vgVWb5UofP6hfs+IQx1cpCA7hNpOsjZ2UYYucYOxfIqc9ghI62bwWcc/doKnNVyNJfF//c+sGDtRLKEY2USpzPQYW6dwTqgCK4b6NyYmZdLa8aKyoeRA5mSsc3w080IONQpHFj7vSRmHYlvwybOfdyikUWkobUhgZo0EgAp9iKAeLp3nPh8NVAsZzVMtYFoo/NU+Gv6GnzmaMyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSo48iBi1YqafviJQ0A2i/ksb4IX8X1V5V9SpSAYNrs=;
 b=HcVvC6V3murVg8J0lctiN+qdCUdM/Affm92NGAoF+3bVA8FurtDk5vu+lVH2tsXlfjOu1uZR1zOtDZYSHaRnSsb5PqEzbwrUhmd5WUFSjsx6N+I1kahtxJfImUOrzgP6H5Wius3fekRSrgQDx0gNSM0TmgrY1hmINzB4yay6yTzKpOQqP0R/tYXcRLsDI/ws5dXu0chMUrLyF4Kr4YWoxUHtgHqNZMDw5U/VKpTo/vy9/h2Fn06IbKKUI9WJfFhz7ac1PxyxQC6xwmxcb+rIp6vCV+/LK2hFXVul8QcN4sDuTCE99uBEP2pKxgCl8YQqFeyaenPoJYXqOIGUukHAFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=linumiz.com; dmarc=pass action=none header.from=linumiz.com;
 dkim=pass header.d=linumiz.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=linumiz.com;
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com (2603:1096:405:3c::9)
 by SEYPR06MB6107.apcprd06.prod.outlook.com (2603:1096:101:c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.3; Fri, 23 Oct
 2026 20:12:29 +0000
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01]) by TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01%4]) with mapi id 15.21.0569.002; Fri, 23 Oct 2026
 20:12:29 +0000
From: Parthiban Nallathambi <parthiban@linumiz.com>
Date: Sat, 24 Oct 2026 01:42:02 +0530
Subject: [PATCH v2 8/9] MAINTAINERS: Add myself as maintainer for TriCore
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261024-dev-ifx-tricore-upstream-rebase-minimal-v2-8-c722e4ca5661@linumiz.com>
References: <20261024-dev-ifx-tricore-upstream-rebase-minimal-v2-0-c722e4ca5661@linumiz.com>
In-Reply-To: <20261024-dev-ifx-tricore-upstream-rebase-minimal-v2-0-c722e4ca5661@linumiz.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Saravanan Sekar <saravanan@linumiz.com>, 
 Dineshkumar Selvaraj <Dineshkumar.Selvaraj@infineon.com>, 
 Christoph Seitz <christoph.seitz@infineon.com>, 
 Sivashanmugam Natarajan <Sivashanmugam.Natarajan@infineon.com>, 
 Parthiban Nallathambi <parthiban@linumiz.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792786334; l=921;
 i=parthiban@linumiz.com; s=20241125; h=from:subject:message-id;
 bh=zbsEZ4jr5X6jqfgLfXBRyy1ioXsL4OL/s6tUG7sIFcc=;
 b=t6SAAqzYhAOkhJpSi80QeXxwyEgo4Kamyc5GFuRGRjwm+FvVV6QSATY6R7uzdWTf2vnxolaqR
 ArvmRgVzvlBCc1LpX6njHWpPU3AJVzzHLsWM5xELDedP3uQ8clLkMXY
X-Developer-Key: i=parthiban@linumiz.com; a=ed25519;
 pk=PrcMZ/nwnHbeXNFUFUS833wF3DAX4hziDHEbBp1eNb8=
X-ClientProxiedBy: MA5P287CA0172.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::16) To TYZPR06MB6935.apcprd06.prod.outlook.com
 (2603:1096:405:3c::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6935:EE_|SEYPR06MB6107:EE_
X-MS-Office365-Filtering-Correlation-Id: ce2d4e6a-9f4b-4056-3267-08df3141f686
X-LD-Processed: 808466aa-232a-41f4-ac23-289e3a6840d4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|23010399003|38350700014|56012099006|261022105027099003|261021123027099003|261021121427099003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1LYG9gM8skD4IusclCGhwF8NczI65MaK2OpEpRw6ipMJBscaFf5FBN10CwsIxjV14Q646nvPujjrpV34Cg+UF5Zt+yljmq2KrXL5auh8loUo4PUVQcYL0baHtdqcfanNVzGK56RjeMWauNjXn+8jxEP6RoLGy9kuASpAUj4B+boC8HWJhrjfhiJr0xEE3i73L+OL595IdkVpdSuKLJnvLxiOAb3rIxXKhHxdZVTl48678qFunojwaLUknOIclU+1b6F7NWZpd8rgqIVkf5rZOerDqgfFi68K6IQ++S95S5QIt7IirG/538eqz6mUfrbcs4Xh0V1urwrNa5oS5r5KyqPbE+vJCySjxup1mH0X7FX0YCR3bSrZ6YJ17JTem9PkEfVPlb95O9fQgIRp3EYKEMA7MJMRyCQ9CkLAmk7JPFgrwLvDIVGNaMdT8tEXDj7hxiWRpDRAdw724yCYqHBnjXnycrKet8PJHDbTvmh7wJ5QeL4Li9h3nwN0j/yYq911GXzRi9eFaSs59MYu2SsoUPptCj/zz6PvEL+o2WqfGNa4UVwzDIq5Qu+bbOQcPMu1xBgNQDd3kkS1yvbLE5KaSot+OAsLj2jZZt25+CY+yBEzeI3FJAEPv2QGK2i9EUOkfV9W3iAxs0BYQ7hIJoQuk8zzGYL2FGnVnpWhgxHKLIAuhtZFXzp0H7XosKwPysdLvgn4D766IMye0Qw1SHNzYU+/omD9jJ4UNrH0/dmoLcU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB6935.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(23010399003)(38350700014)(56012099006)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGNxb2pRZ3VFVGZ0QnZrOXlHb1ArQVhnRXZaNzhNNHhZaitxZTZJRjB2a1Ay?=
 =?utf-8?B?YzdnbVFBNXpucHNGVXRLaHo1QU1sTE41UjRqdnZYQnlpRExpWndRV0NpbU5F?=
 =?utf-8?B?ek5xalpRTkI1enBJZFFCdkoxYzBvWklOdXBQWnRYeEFVTU5ucWd4bGxzSU5C?=
 =?utf-8?B?MSs0UzgvYkZvZnd1OG52YWJPUzExby9Gam9WYW00M1FlRW5lRUJpTW0waFF3?=
 =?utf-8?B?S3ZEVFNEbjdsT0xrVmZHSGR3MUhmU25YOEhVWGxCbFM4cUVndGltbm9UaCts?=
 =?utf-8?B?ZkpIdFhwczR5KzJXWTZkN0FlRloyZ0YwTEJsQk0wOEVva1dnZXRvdHFrNXJt?=
 =?utf-8?B?eVg5OUFuRVNDVFBha2RZNVplR28vQ3R1QWkyaDE1V1hrS1ZKMm5YblRuUUhy?=
 =?utf-8?B?YkNtakdvMGhOL1B2em12TVc1bzVGQUptbzVpNjVMMVQyWEJESWNnSEl3cmdO?=
 =?utf-8?B?K2YxUHptbjhMVU5hbENNWnNIRlA4dEFCSjBHZE5YWkkvdDVYdVlXcElmc3da?=
 =?utf-8?B?ODFCRVNqcHBpa0svVG5ET0Q1d0hWVGRiZ29XdGczVEd5STRRaHVqMzk2WlBv?=
 =?utf-8?B?a2hySUtWV0dUQi9xSTV4WTFxNVVZK2hGQnZXMFM4VFg4aGtXNzBoaEU5Qlpl?=
 =?utf-8?B?eW9mZGZqZlM3WFlEMGNKTmwraE10M1ozTm04b0pBMTd3YTVuTEl4ZmliRVM4?=
 =?utf-8?B?bUltSUozbW1ZK01kUnljSS9sZ3NYU2JDT29kZ05ZODNaclBXMWNTWXVYK09w?=
 =?utf-8?B?MXl2ejNZeVZwQ2lzQm1rempuN0U3TW9FR2x0SkYwNVd6T2FjVGxYcGtEUU5T?=
 =?utf-8?B?a0hmSHdNeVJWdzZwb2g0elloRlhvRVlpU3cyb2FKdnZhb05ZVUYyU2svOG1T?=
 =?utf-8?B?WEd4Tk9CS1Mzdlg0cC9RN2NqaHhxa2RVdDFseGMrOCtyY2MzYXh1a2RvbHdh?=
 =?utf-8?B?MHptTllpT3g1TXd4WjU2TEwyZ0k5Q0VzYWZDVHBSK3U3V1JHQWZ6RnU2b1BS?=
 =?utf-8?B?UWo0UXRZeDE1RGxpVnEveTBMSUJJamJrRGw5ZXJ6bXQ4eGJoR2lTd0JFdTVB?=
 =?utf-8?B?SDhDNllGRHlyd1dmWXhjWmNSTTY0UnRqcDlKME5aWDQzQmlzYkplN1c5U3c4?=
 =?utf-8?B?d0dHakFnZWl2VlJJMlJTclJKa3FQaks0dmV4YzNlRXdtdFZ4VklMd1JUVmUz?=
 =?utf-8?B?SkpwdUFxd2xEWGZKNVdod1YzaXk2NHlhSk5MYnJkYWVySys2d2N6aEFVN2li?=
 =?utf-8?B?ZWl4VVhuczIrcEFnWHJ0YUJzdTN4SWU4NVRrTkN5ODlQc0VPVlFZa1JtV2pI?=
 =?utf-8?B?SjhldnlCeFZLeHlsSGUxTGlkU3JaY05KTzhPVjlPOGtESk92bFdxVlA3ci9u?=
 =?utf-8?B?Y3pic2RiSjdKdjFBVzJkcWxKZURVZHhUTmZwdXhFL2N5NGVPcFcvL0c3dVlL?=
 =?utf-8?B?NW4xNTNWK1FtaEpTOTJCNmpLUnBseXBUOEgzQ0dnN2ppUmtiaFA5amhuZXVQ?=
 =?utf-8?B?NUsrbVdtcmVOcnVleHM3WHBtQ2N1TEVLbndjaVNNS0pFN0JVaC9oOWxXN05n?=
 =?utf-8?B?eGM4cWVPZ1RsWGhRSkNkUTUxc1MxcTBsSGxMYVk0SkxrV0hnYWtkeDhUSW1q?=
 =?utf-8?B?Z3dtWG4yL2tsaTJ0d2tLRlBwTkJSV0p4MGpocGcyVDVQckFQWGlCT0ZmbFUz?=
 =?utf-8?B?QUtLRDg4bzJVQWVpb3NrUWdrNnFEVXRlYis5WWlmZjkvY0M4NWhsN2FGS1ll?=
 =?utf-8?B?TUlqRm1RNlZsOW5NLy9Pa0ptdEp0U0piNlFoSk85N0NTV282RXVTUFY4TExm?=
 =?utf-8?B?bHREeEFPaTRML3lZNDhlZnFXV0pKYVNwd0xLMFB2Y1FHdHBuZloyQ05qV09R?=
 =?utf-8?B?STJJYm9YKy9GVWw4ZEs3MFhlWHdWVlc3YTIzS0d6a2NwWlRmVzlIbmZBTWMw?=
 =?utf-8?B?dE1tcVBCOTFzWHhFb0FwMnQxTnRGNERBTngzQkE3VnBVeDhibVg4ZHNTK2pT?=
 =?utf-8?B?TTJyMUhLbGxIc200SEx2Y0EzRERVRXFEQ1JVWTQzNTAwai8wTDJtZitDc3RD?=
 =?utf-8?B?NDRxaElVenFvM2ZwY0lScmd2SWFoMGpoVDYzbmQwWEhnSVNrS1F4VzB5eUdX?=
 =?utf-8?B?bUY1NGVuRDNzeWdESHF2WW9kU3c2OGtJeVFIdC9PNUsrZkJ2OUUzdktqd3hW?=
 =?utf-8?B?MXNEdTJYQnBLUE1xWkNETVUva3ZpMW8xV2J1bCs2SzVuRVM3RFNtdFluV21N?=
 =?utf-8?B?MXl2YlRDYm1WVERtUnNyVzI5WlUwYUwwQ2pqQWF3S2xWUE9laVpXVWt6WjZ3?=
 =?utf-8?B?Y00rcmdPVm84aFNrVnUycGIvbklIemtHTHFjL2JzZXVEVUI0ZTAxdz09?=
X-OriginatorOrg: linumiz.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce2d4e6a-9f4b-4056-3267-08df3141f686
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6935.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 20:12:28.9451 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 808466aa-232a-41f4-ac23-289e3a6840d4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FJ2ZUfjMFMhbWaM7tRpS5ZjGe+LocBDhV9pQtxKWOUR0LV/BV38c3LGqwBMdMHVSrU2zpySQuj4E3GKKdNY2dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6107
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=parthiban@linumiz.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

TriCore TCG CPUs became orphan with commit 8fedb9cfcc ("MAINTAINERS:
Remove Bastian Koppelmann").

I am working on AURIX TriCore support in QEMU, used for the Zephyr RTOS
TriCore port, and plan to follow up with interrupt delivery and the
TriCore 1.8 ISA.  List myself as maintainer and mark the target as
Maintained.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 540325d78c..47c25e9ffb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -474,7 +474,8 @@ F: include/hw/xtensa/xtensa-isa.h
 F: configs/devices/xtensa*/default.mak
 
 TriCore TCG CPUs
-S: Orphan
+M: Parthiban Nallathambi <parthiban@linumiz.com>
+S: Maintained
 F: target/tricore/
 F: hw/tricore/
 F: include/hw/tricore/

-- 
2.47.3


