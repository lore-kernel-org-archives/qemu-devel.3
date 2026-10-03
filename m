Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C7ACA5FED
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xD3As-0000Me-6D; Sat, 03 Oct 2026 13:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD39M-0007JD-BC; Sat, 03 Oct 2026 13:03:57 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD39K-0007Ds-Sy; Sat, 03 Oct 2026 13:03:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RiAZgdldMcS32RB6dwWX2wcyi+9ijDFuP3PwUksq/WeznXFTWGR+7baDxfRiteV0tYh/sx/sV776isOQ2+DB0r6rax2sZP5Pj3w/60BYMdZsI/A/lP+sQDxdj7+yK7X84z9dFxMq4JMbs1HJq0cDvD8Etfk5pxpJOQdQLnIXk+/Xw2ETXeKUGNjqmozeVTZDRFmOqzP7lPnwfaNQQcIeefU472RFZXMZR0afMPxvqS8WoXzb1c4a2HAcEy2x+vpVKJSIJhQQwQqeZgrKFpvGQZGxdkTYFw2pAd2zxcfXszVIyTGX4+cSCtBR0j6HLbOZGklEzJVzklLtLYbRv33KUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhS/fFdjwqmRcQp0JDNHwkK4SiImM83ZLq1a+oQkVCg=;
 b=Y9dHS+w2Uppgqw+uVSpa7XNW6I66K7BBOCxPIzClWU1d2dxCRg4FhguMQschF/t+sVcN4msHv4cnZqHlh1oOajBFEp4M1Rw3qirkpqoCCUm+K0+nahPCl2pKeIPOTJP2u9D96gfGiy4VYGfIu0YmZet4flDDDQg7yYgQNypiKySUlbctCHshAT8hwH79TrneTuP20C/BEZLzToR1Xr8nJc4FQTxobtu5fxG92lO1kFYiQl+5foAj+KnqR8e/ERZOTRTtlEsx4cMOJHQit1H0X/RQQiRq4cpaiXNYmL3BeslghK4AnnMWwV6Uk7gllVyiyZMTM7RyquZOf2MTca7Qcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhS/fFdjwqmRcQp0JDNHwkK4SiImM83ZLq1a+oQkVCg=;
 b=qtVbU3eN321ma4EteI+/lfHrfxB6i9ywN6egFhjq3U3L1fhSt0cBb/P7nenjNlVgIUw0of6tef4444TvwnHPXP+X657kSipzjNxKXxAJRBEk1kEjMdTkT1+HaxdyLXWyNpTwIPb3+itt6OL8qT5jMqFOHIPxS6tjbKSTI7xsVte3Gcw9wT98bdeYqlYOoDqbjX8m37tRsNQz0IyCP82Fruf9NH5ND5hmUSmQGi3oQYGcn6Fe/CvhhbSh9wezuWugAJqDJiua6Hl659nCKl+YDGTvc2b2zW/xSf7yieR6bSMipKfU97rmY+1X9km3I7drqMvl7DcnOVSzyhrlme9oWg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYZPR02MB6993.apcprd02.prod.outlook.com (2603:1096:405:29::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sat, 3 Oct
 2026 17:03:43 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Sat, 3 Oct 2026
 17:03:42 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor@kernel.org>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
Subject: [PATCH v3 18/27] hw/misc: pfsoc: Honor service notification requests
Date: Sun,  4 Oct 2026 01:02:08 +0800
Message-ID: <20261003170232.2450916-19-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261003170232.2450916-1-bin.meng@processmission.com>
References: <20261003170232.2450916-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0100.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::14) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TYZPR02MB6993:EE_
X-MS-Office365-Filtering-Correlation-Id: 93b77f93-af1a-42ab-204b-08df2170475f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: P+wV2iRWH+aP7TSPLMSKifo05blcpphonio/H7ddJEefZHolvg6BP06NDpv9vYWJbX8EceY8EXbbu/3TzQaQBiI2BdS1KYfkQW1sUvZqxkowIC3cmgh8/tX9AkSM6Uxxscshr5nDe6+kJpH1w6ZJr1GpspXKYPOuTFtRsZaecxA89FdPlScNfa8boA+Xs/b03aL9hUv/h/ODv88l4k0uNDMvUVfKgk9BHiO+Yis3n84QBaEpijts+7wEHpPskkO3CfaXDVdjlBBnmdnYuglFswkWHH3sisuKu22DCR3mEPa3I9tA3RtLHj97YXdPWYMpnDwJO2JhnruDRy9GUJl/YiNe3YJYVS7d7li43VU9PQXqLj4EePwtn6mUhtCmsGdROseiD1DAeDCBPhFRW6GPaUrhFxIlUQw3d/NN1EblfU9tEbqDtc1tPeHpyWqraYi+WWhylGkMUKpnIV/Fo6ftz8pr8m6nFn1qVdo6CDLO/x2+evacGKkX/2pumdGUdeJWPbbJIk85uW6a733dVW1w/ccNR3kDCHfIDIuXAaYsiLTzAy+Rj9IOxZOeZlMR5tRHEB+hk2NNAAfAkJ1/7R1ihbY+0F9/WcNN+qvujU+uDXF6K0yAt3OXIcwqoRyMoyvY3RDmi0K1eOgSGQZ3VYyb+vadZnJhWF7i48gock7Dhs4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sfv2jUA/KmLneHUGy53iuqiCXIUbr5lqHtXPlNVkIvd3nCgv8vi8eUZlQxwv?=
 =?us-ascii?Q?hEkpn2VsKLazVCwVw8iqRk3p/36Lb8n8XaX+KkgzAWlAhIgVk83atTHwdCJw?=
 =?us-ascii?Q?oKOmAaWZFiSZ5nEKAQj3EhShNTZbhjknEYVlGeeGCVeH4RhfT8nKOlrCZEMa?=
 =?us-ascii?Q?plBAqa4wjFxM25Qo1dB9TMKekXT9c9qHy+2SGW0ulnwqI/Z1i83GVsv9Z+nK?=
 =?us-ascii?Q?fFwxYVQiGx/HHlpE/o1gXHOj+dGxCH1BGZbJfBvXdhmr3TlYOpTOpFkhFIpf?=
 =?us-ascii?Q?kXEvZ/15F/I44hcfa9IwxBxXLFmIQCSuqo6cYUBmyZOWkMx9IDIGa6F1Wa0T?=
 =?us-ascii?Q?W6V4Hz8tvkHtzL59l7f2u0akXylhWmaDyjAwrcVuuwpDwJEN7aRwYRHXk5tY?=
 =?us-ascii?Q?LkcaKK2gdn3GLl8RNtbIh6MIYnmyRPmr6WzKJaYL1qHcLw3die2H0YGKYis2?=
 =?us-ascii?Q?gbiVRULlDcHjM54vA5NDmuXKsKqSOy0I/uupbuy/irwbMvuYS5cad7S1elR8?=
 =?us-ascii?Q?snTlGs6X51hebDBPUbvVRe+UiLrC0l5s9/1GDnqlToUlcgFMrFKWYGNLqKbb?=
 =?us-ascii?Q?5gfKtK8xClosHy4o52Bm1nkSkIEiybWmCn550H1kp/p+oG8yTP24JicIJPb9?=
 =?us-ascii?Q?rRoQuScnXD3+KfAPF1GX/F5nDdzfYkRLCgkM000dOxl2UyWwLhyX3/deRz74?=
 =?us-ascii?Q?HwZLeCbsO75JEN4aFkzXl+1H6M+0XGcNOp/Notxw8ngic6cTwLjX35mlb08R?=
 =?us-ascii?Q?w0yt80g9hxIziW4ASdtG3Zv23pepzzDD3KrSDqcni/fAYlajtpD9uQmayzF5?=
 =?us-ascii?Q?BRBvruLS+hqUHSVBW9ZQ6gYbsMbPQljv1e+maglKaBFKTZWhH9f96efHtIjP?=
 =?us-ascii?Q?G4rxqRqZJDZPm+n8Ov+a31Moum5lPxzrX+uEYghwKBu4W6Eyg503pqbcaH6v?=
 =?us-ascii?Q?gOXfnRpsfZ4TV4JIGdHA1cxeab2KiEAlVxKuKrfHJyxP6RteBzhmLEFT6wPO?=
 =?us-ascii?Q?e2BhvzOP927jVDICawWLuoMFpRwLkY5qdg3d9mqH1A+Xp9SZtoX/jRFjDkhk?=
 =?us-ascii?Q?e3NnamhUZ56tnQ8YSMY0mQWgy25b/v1aUGDzH5SpX9sku5XKX7GlhUk+03oi?=
 =?us-ascii?Q?4UJ+x1eJP3qKpk+TalJ+V3e9X6vNogDZtJVrjS2Wzuf9hHqt3r3y1owTgakN?=
 =?us-ascii?Q?jX9+Mi7HbbmpGwRViJ299Vt1gDcozMVRYQX7jBOI096fOmOJZbPwcn0SzSiM?=
 =?us-ascii?Q?UDXZ/Yp4+aAIuyt2TKP8+7F2u2OuBYtWNwBUNTlzjS30rQqlDvIBedM4+UPQ?=
 =?us-ascii?Q?iR0HzmwYpNXv4hxp93Nm9Y0m8AUZRexerMitCamWorEnFmh2wOIrikhLbs5z?=
 =?us-ascii?Q?GAtTHbH7uXBKtVHGrT3SIuQDXSyrOmy/9u4cQsTH7KBdY9oQY4h0/lP337o5?=
 =?us-ascii?Q?EMj+3YbEclISZekgaT2yZpxEfBNiIm33vHyDTFox7a/Gz2tQWFC+aEcHpNeT?=
 =?us-ascii?Q?Ewu/YfqUmyfcr4+Cja5CmC2UIQHut22q23pc4Fm4hchVk2Kl69/LH2kWVmLS?=
 =?us-ascii?Q?WKNmw6i3TN+g7hxj7SZFJFWnpjfYXAOu5fGVmabWKPQ+tPO9Q6jDcydi9Jq/?=
 =?us-ascii?Q?8TVU+fFHkZON+XVkppCo1gcpsUXr3ZElOfwcdvQ3oN2hv8y8LZ28AdJNVUQ+?=
 =?us-ascii?Q?p4sGuirSUyWSm120Fe3cFQcrDCl0CuNwEjFR3+hmoZCHlmqAv/vW0/6dckRe?=
 =?us-ascii?Q?fS7bziKEN1UYkTRbYZghvBjlSURMcfw=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b77f93-af1a-42ab-204b-08df2170475f
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 17:03:42.9031 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BsLBLPym2//ZI9O/4S/IqxwergocOT7UWbHdEmx27HotwwUpEu1FqSfGVYc1YK6SJSKT544Y7icIDlLtonm1KUV5CjcP7PZ0h9X8czG1VXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6993
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Polling firmware requests system services with REQUEST set and NOTIFY
clear. Raising PLIC source 96 for those requests leaves an interrupt
pending that Linux can receive before submitting its first request.
The mailbox interrupt handler then has no response buffer to fill.

Raise the completion interrupt only for requests with NOTIFY set.
The serial-number service already checks REQUEST before processing a
command.

Fixes: 592f0a9429b9 ("hw/{misc, riscv}: pfsoc: add system controller as unimplemented")
Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v3:
- Split the NOTIFY fix from interrupt acknowledgement wiring

 hw/misc/mchp_pfsoc_ioscb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/misc/mchp_pfsoc_ioscb.c b/hw/misc/mchp_pfsoc_ioscb.c
index 850125c8b4..bde1917c10 100644
--- a/hw/misc/mchp_pfsoc_ioscb.c
+++ b/hw/misc/mchp_pfsoc_ioscb.c
@@ -247,7 +247,9 @@ static void services_cr_write(MchpPfSoCIoscbState *s, uint32_t value)
     }
 
     s->services_sr = status << SERVICES_SR_STATUS_SHIFT;
-    qemu_irq_raise(s->irq);
+    if (value & SERVICES_CR_NOTIFY) {
+        qemu_irq_raise(s->irq);
+    }
 }
 
 static uint64_t mchp_pfsoc_ctrl_read(void *opaque, hwaddr offset,
-- 
2.53.0


