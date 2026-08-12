Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1665CC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 01:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtxu6-00083c-Cf; Tue, 11 Aug 2026 21:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wtxu3-00082S-UC; Tue, 11 Aug 2026 21:37:11 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wtxu1-0001Yf-JW; Tue, 11 Aug 2026 21:37:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K5yiIQ7uXSbkLtWzu5hjZd3CCXOpBKZZW+vtGX9AQg5SGaV50/ssaP4tbjoUco9Nlan2ltcSYC1GsVO2pi2Git5CoQ9Jvw7LgCJxyPHtoqZ2HlfBV3+stINuJqs52qHj0N9T8tHq9m9/GIljOZ8yWSlE4sQfmhxVgcc+WCBUX96VI3uKzmPmnJONJYuqNxM+8IeJBObMUqnSBYqNWF41xheR0GMyS+lQJANKgeTfs0j6Nc5WlvKQvJ4GTcyYAd/QEJLvWMl2rKwmtij9vrvh3+8jLUx+lpLPd5Rvwoeopae0Vtt/2KUy+o/1eJghdEr0hXdZuM5Y+8RTr5qv3boJxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewTWxuCGQ/uZfSV9doHWz1t2dDzT21/e/RHmiQUjP3M=;
 b=QDWfX9VWcaQwJUNwqzVAalducrb7ou6cyXIyNQbj71C/V1oBIavo6pC7pmgt3zXtRjdRLa0Edzu/iQ4dKEckzwCSTzhn5e/ge8dkLMHQ1uK6zpl5R0ZbCWka2Nluo9ze7tEvZm7VGtG7ucjCn4iqeIIpqURxaZ7uWVH9F5E36Pxr6Bl20yOhxiqXFiIJSZH2ugLRarlbgWOSxdQ/+zV3/J/DNJc0bJxsRIFlzcbWd/7unfVgqVPL2h8n5VV3rdJ9dwE1zkXd05kOShwcTCP8a2jF4GbaPgEypkkR6gDKfsahY8hmc5zkb9w5C4o0PkCRVRKqM2q5nPhJobb+pEcCSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewTWxuCGQ/uZfSV9doHWz1t2dDzT21/e/RHmiQUjP3M=;
 b=hW2XiZKLCu7BVfoIPgLveOuozqT5FmZxKd3Zh0geR90BG0SBEzdPeC6kw08TInR+cJ+DJIRsiQF6H4yHc4Bm+0FfYe9K9iEkr5eKVAUEfD9oGXHWvpQe0GPVzVInq4tpEZvqy0SV3+53KhWrMXvnLdgUnDXKwWT2II3tfanaE0rCA/3TGRgsr1HuP3xrjOfiNNudLrrOKyII41IyENKboo6gFqSn+I1BgnKJMRoGkW9YzgxI0ezUENAo2UtX+/rxlP+78vqzDuSXAWa1GFU7B67WhfW5eO0/aJAoloLS8FIh2/cfGj2+UcecgR4agXf3ZQUjhyqfeyxF6G+OP23WQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SEZPR02MB7871.apcprd02.prod.outlook.com (2603:1096:101:216::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 01:37:03 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 01:37:02 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 qemu-block@nongnu.org
Subject: [PATCH 05/10] hw/sd: sdhci: Use a QEMU-local no-busy IRQ quirk bit
Date: Wed, 12 Aug 2026 09:36:08 +0800
Message-ID: <20260812013619.2134092-6-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812013619.2134092-1-bin.meng@processmission.com>
References: <20260812013619.2134092-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DU6P191CA0007.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::22) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|SEZPR02MB7871:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ea0d264-8f3e-4029-4edc-08def8123575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|22082099003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: oSSWVxHrSnxU5+jiMKLXYVfDdi+zq35TYRPNfhJPjORQm2jCIR9FahuYRVgJ6ov+vwCS8sk/3c/2Hz5r76zX0Pj9il0w48F9/bEPnxhi5GcR0ahn4e6bYY/KVu4s9UeXwojt52v19E3aZSmaqKrIh3U59X5w2KweL/2i7cG3ydkQLSIOp49DcTD1vH+h33cz2vgo82OaIkvkfXoz08MwW8tGBcmZ0aHIsrcoxYSNLBBzW6UHA+u7fSNcwuw1wIu0Fkgi7oCEDlnb1xcGqHisOZSDfDe57AvTgxyXIHyzdwkGGnrJuqqeQQCavoVuTJVCPHKEkWjdUBAqbzq25OYZLuYI9WKpOJF1HaNchNSCDmJPYhX6G3z9P9lZK6t30d1Pve4QPJahM28TQLEvBN6mQxh9wXQ2oUU1+1bNmTruaqAYqBH5+yupTkzte8xydOLaqHZBnkvZJex6SPhlRkQFVfcoEXFT1vOd6a156Wa+fNBopjYjuVxgaES/PN6Gri60+QX1kGS322YIbCX9LRJ2W2LMANhLStYExHXwc3eJHGKtgoSPO22dhOdnCFc9NFdidjzWmG5LUL/BbIRD+KCKnlmOa2Edf9719rBnq5hYvKi+B4NvYDrPK8//AnAD1K1KHmam/7T9HUU7Wfj0JLa/TAodbg1NQgAO/nUxAGQM5Zo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0K6quVXnJ+dGjsYUteXApEbXWvQfDKXsvAp/rNbEic4KPtyfdNxGangoLyy7?=
 =?us-ascii?Q?wAW7SZyW/XZ5sE2/WthtYgVOGolKm9iRMOpDU+3n0MAirZvFFJKPDKLL4IhM?=
 =?us-ascii?Q?rqE7LKAVF8iZXHAdeDb+8UyeJvtddDdq/cKqkcfWcZW0PDc/LjsJySpT+8tl?=
 =?us-ascii?Q?JmqJXwrnuIp4zILNZbFK9kPqWP5hmu0OEeMYLXg/Rkvt2D5/Pw2+uXwP42hH?=
 =?us-ascii?Q?1IDjBIGaUkFVtX3jg1fD0IecQ98wZjJT6WFMzylJdxxN+YOvP8QL0cOwi6pc?=
 =?us-ascii?Q?PHYfB5Y/xJ6xZnbmxVjsLejKeEBn+WvzB5flulcQgMv/0s28kJlZzBaLsQKH?=
 =?us-ascii?Q?NhcPThdj/RtCjBZRPRrjW+GP1pOwzMmBySnMCYEyKTBTEhBlu8ewQKNDbP8+?=
 =?us-ascii?Q?WSKVwJsKlYtO+o6zagVzDhipwPshjTC3oREggbFfcVizyIjH/YxgNQCrU3Jc?=
 =?us-ascii?Q?QEEqNmmrOFKNP2OdkUqOG0aXKfrBu3o7kN01/ya0bR7pfE8xqBnrTxeaSaiA?=
 =?us-ascii?Q?/zkGdh8FSrFmhFQOu17kqfIogaC/TZ12rTNPLHGuTSgc2Q8ZtM3V99Bb+0jq?=
 =?us-ascii?Q?+RMXAUuDtDTTOCDtJe+OBIIQp9jqKYfeaq9MzhetFP8hd+qnQAJCiTIQZt6S?=
 =?us-ascii?Q?VJyG5tozMZ/fGsYpookppb0/ZRqD9ip9gH7zD45wsbCkGBZHKACfpo4bgzyM?=
 =?us-ascii?Q?lEJUe3c7pHzTuwC9UC34PmnvCpCw8+f+/c0oLoAUxpRJ7ppJgLYkeAzc4n99?=
 =?us-ascii?Q?mKAGVfUy+TeQ1vyD0A/FaLe2W2oqXxZlDNIUpCeV2NHvEJqItNFd1MLIg3ju?=
 =?us-ascii?Q?RlWk4+U1JpxnmMrfA1dSl4/Hwpx98Ydg9Vc5IwE1lgBQdGWxHcpT4m6kJlSN?=
 =?us-ascii?Q?gmFqNuNjKmuNMDN6jPGVfD9tLfw0iC/J1YKt52sRueg/iPwoqMVawg8UOsPs?=
 =?us-ascii?Q?2JWMH31KUFS8p28zZ/Qil85kWx++NALw+AK8A5eV3/SA0OjuaGrNduF1R08m?=
 =?us-ascii?Q?izHprMPAvYy71emFiLf5HXZtSsFkvOwf1nCtKWKDlM2lXsk8XfnE2lGvBKbd?=
 =?us-ascii?Q?QeiAHtEmzLXDEmZ2a82BxDUjR7PR1dRW2oDgEQJDFICV9OW8RLIQ8GH7kM0E?=
 =?us-ascii?Q?7PTsQkzQhTYX3Frbwk5T+qI7sEaPmAmwZYVlFw7o8I89qZDX5RelDEwZRmGS?=
 =?us-ascii?Q?ksIMycewHGpVfonEYMGfNeoQJHeZkZhl3vt9S/c/kVWvmJAnTaAeOscb5JDY?=
 =?us-ascii?Q?1exP2bfGanc8Bta9uluxbd/0DZHPOPN9VheAENzExNIaahVtUzetVjfA/hyD?=
 =?us-ascii?Q?1NhcRVfXguFVTmNNQni4sX7fBdls8YhGCeNCeEwporm6yv5H2epwE6weBe2w?=
 =?us-ascii?Q?v9jOfSJl347U7L+tzhQ31/eYHELcZAVToqKMsirP01dex2a4oEZNJidSTZcj?=
 =?us-ascii?Q?2cXZTIAYe8aqCKbzMwYW8u1G9yip9qa0Po1zfsH30RRKWFg8ECTtv/meoKnz?=
 =?us-ascii?Q?fmwkVDNxsoh1jy3hZxE01t57S8EvbdDpWtkmSGSzE8NVVwU/4P/XL6t+2PCi?=
 =?us-ascii?Q?1XSxE84v7/xQGjziqpUHJLOcswC5O5zeoeK91RS1pe32JxtUTr+ZTb25JdVG?=
 =?us-ascii?Q?3k2CXUZ+TPkoPq50Stsm2rmyXyj1s75D2TFNt5J6xRyA+qBgV1Y9jEQzVgKJ?=
 =?us-ascii?Q?I8xvR0Kora2aCYETNRVL35dJ3jw6Sqmv61NqutefHnL76lgeepMAoTpYyDUP?=
 =?us-ascii?Q?IZN5XhdSJ3SV3hJ3j9RlAe2m7tTO4Z8=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea0d264-8f3e-4029-4edc-08def8123575
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 01:37:02.5921 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e4FTYyGXE8W01/A//mwRBgiCBMbJzqnl5zy5W77aBD9MZ6HZ/cWu3wc6A0+KYbUvX5i7SDVuoPKhSZH2Bu6vUprVuG5/PrqYQ9XsCwH9kxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7871
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=bin.meng@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SDHCI_QUIRK_NO_BUSY_IRQ was copied from Linux with its bit number
unchanged. The quirk mask is internal to QEMU: it is neither visible
to guests nor part of migration state. Mirroring Linux therefore
provides no compatibility benefit and constrains local allocations.

Move it to bit zero so QEMU can allocate SDHCI quirks sequentially in
its own namespace.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 include/hw/sd/sdhci.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index a9da6203fc..8083379de3 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -109,11 +109,8 @@ typedef struct SDHCIState SDHCIState;
 /*
  * Controller does not provide transfer-complete interrupt when not
  * busy.
- *
- * NOTE: This definition is taken out of Linux kernel and so the
- * original bit number is preserved
  */
-#define SDHCI_QUIRK_NO_BUSY_IRQ    BIT(14)
+#define SDHCI_QUIRK_NO_BUSY_IRQ    BIT(0)
 
 #define TYPE_PCI_SDHCI "sdhci-pci"
 DECLARE_INSTANCE_CHECKER(SDHCIState, PCI_SDHCI,
-- 
2.53.0


