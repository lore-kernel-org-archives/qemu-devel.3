Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED8A4CA5FAD
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 17:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBbYh-000676-Cg; Tue, 29 Sep 2026 13:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBbYe-00065h-NL
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 13:24:00 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBbYd-0002l8-4S
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 13:24:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VVHVJPeA8xiyaSF8m+kYn0BvkH1TjXBFJIxMxjTE475AvfEaWKSnLXDFpUDBpjhSbrxxVkabnTe7pb2BAqHXmNnjYjxRn+VjG/pdtQEwA3Mknuap6tJRZIxOdb2gUJBzDykTyipu0Hm+GiuY3CGqW8HxrRLdjni9kururgXYgZBugPgNAFkLj8Xv6CB0fEPiSSUJEgIl8wtPmgdUHdPCdVd1P7qjQm3JGRzdws3E44ng52u1pTthTEfi4Asu+0m7ToPXffElEpQfFVpUmvqadYioBArjZX2IJG7+VcduOWv80X7KaeFcSTF1VCrWI0SrQuRp/e7KSi1dPL2iTYkhOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPFbMPhIZxoaP4e9dULQkwyI4cq6XSDNW0FRpINx2RU=;
 b=sNYhNLbqcNP1TQBce9pHoEDXIgMnA8m7P+nlzd7xQJ/6uGU9zC94OQFhqsTxzBYVy5q8mzzLchu0H4/cjs3+6lj3mjbOEo4Yf+3PKYhQA/Z6T7ylERxNSPlf8rpGhKc1LRuKzkrNxLiexm5cM2Qx2HbbnSMYJYeKGuq5/E46iAZt4kBSaDTP2HA3Yqjx+6BLOA32AVfpUhmuDKBjol91sAxEg6d6HW058kuVjEA71J2lhVKXWc6gvLlpBZAiCi5taQq6d0f4OeGmfJH6ZbT2tUYgtaNs0ngjZObcwLXhgIaaUmW/8rNTd7O1qq9vN/dwxSQ90jdElXyhDlKfTxiGdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPFbMPhIZxoaP4e9dULQkwyI4cq6XSDNW0FRpINx2RU=;
 b=PkawKYT3RZlf9U3oMFPt1/OiVjtjozQJutBDK+Rk0hTOJQ9RSziJyKI2FGGTh47uVsBZmpu7REZstBQYmNebUJhogt7d6A/OYr7habAZPs+D6S2yYENgcn7CbN2pMWTkMxO47dXrbUMfc+2VWw5CbavIwMC8KTZtQA6qCw4zvqZ0/rdqeEaUfDuzvFnO8uUnz43zLBCbQp2NDsDRBnAkJiwFajPjlibHuMCDo5xjHMqhwKGnyG4dIh9MPtSQY8MUeB7zL0Y60K3JH6GLGh7laIbY6FkrlU/0oBvj4y0SAq+sFpVYAu0/NDDZLFFPpLPoPelarAvtT7Y/SGlEovvLMA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB7910.eurprd08.prod.outlook.com
 (2603:10a6:20b:50b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Tue, 29 Sep
 2026 17:23:50 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Tue, 29 Sep 2026
 17:23:49 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 29 Sep 2026 20:23:23 +0300
Subject: [PATCH v8 04/17] migration: forbid snapshots under Xen
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-up-vsock-vhost-v5-v8-4-12bcf1c0b84a@virtuozzo.com>
References: <20260929-up-vsock-vhost-v5-v8-0-12bcf1c0b84a@virtuozzo.com>
In-Reply-To: <20260929-up-vsock-vhost-v5-v8-0-12bcf1c0b84a@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, maciej.szmigiero@oracle.com, philmd@oss.qualcomm.com, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, clg@redhat.com, den@openvz.org, 
 andrey.drobyshev@virtuozzo.com, mark.kanda@oracle.com, 
 vsementsov@yandex-team.ru, farosas@suse.de, peterx@redhat.com, 
 sgarzare@redhat.com, bchaney@akamai.com, dongli.zhang@oracle.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR04CA0130.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::28) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: 9690ef3d-18a5-40c9-d7bd-08df1e4e6c38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|52116014|1800799024|366016|10067099003|56012099006|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: PqQgG2nRcdc6eXoSb0NAHl99AUu9n+gjagrQStpBmMANX5rhobPE24evULiefXRux0DOioZ9yftwvksS0Kjo1qv0ld32U1RPRI5w+s+e6fWZ4uYy88GhbiswYixFM+6XFHKeZFImfj7skZI94Q4YelMMM5qIpKMO85ZkcXKOCELR8MeP8xKvNXL7x2Wf/UuOSOVpAKL0ni/upa2jnqxbHCLTpqDjLrKAKTQhKVJdFIVWY34rENfMvrvEw0u6XyXvUOovdKf7SJkN7Tp72NAfRsiJK+DPYWS647NRiNlhVxwrXygqkd8GvNsVPFcFGaFDclvRNfMR6k4QltmHqw8IplkSMgpOOdTY9bMnoe0ETCfqWcr15MMHPTZ+0nMolZyZMDBCUjpVkt8/IAeT86zY4Px5yuYliyoQOmTIQEF1c5sZsSOvZ06kWgXaEIq2EXRnRvFIACqwbEPG+euzA/kkgh4Pu8CJMu3M7/T5hh55wQgnBu3J7iPeN7l2Spe73QmL/mzHJ4MsbB1GB/Jy5yMuNyFLa8w2O1wMl6VjVKmu63gy6PBij9/R17OOuQ0KaNvitxG2MPWgg/y3Jo6BVnswpxbByUBnCeb7ggGyqkLMZIYVEudAXqKL1FYc+qBtE2Jb82L8XXJWOH7Hl03bh+XSPBG6AYea5uWXgeTx4wnOb6SW1DQ4J7C3fC88m2R8n6brn3Ntkyt/abQDxGJ/10nVXo5XtrvF6YcvrFY31BZHoLw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(52116014)(1800799024)(366016)(10067099003)(56012099006)(38350700014)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWhxcXVrN1I1NWgrTEV3bTcyMk1rRW0rb3M1MVFGVjUwelA3WHRJVXJ4SUpZ?=
 =?utf-8?B?bEdXS0plSUViNWp2eE42VWVZN0ljckdDMFM0ZGF1bzhFcUtOb0I2MlU2aHJj?=
 =?utf-8?B?YmptVER0Tk1vUVZRWFJUa3g0VExVZlNPSVJML0J4T01ydFg1ZWNLOG90aVB0?=
 =?utf-8?B?Nk5iR09ZWWhkeVRHd21Gb1RkQzRrUnlGTVdOQ01pbCt4OE1sOWFqQzFPZkFO?=
 =?utf-8?B?clA3U01FTWZiK290TWNXQXdEV1NycVU2TU5YaERkcysrWm0wSHR2WXM2WmV0?=
 =?utf-8?B?R1gvenVhNWkySW03bWJOZWhPTGVwa3VSbWwyVmo3eWhlMHQ1ZlVNeUJvVnZW?=
 =?utf-8?B?S2Z4a1N1alZEMHNVbTlUQWZPV0tjbkYxVlZ4L210cVZqSVdYYVJ4RVdWd1V0?=
 =?utf-8?B?UVRQRmxsV2lRZVZaNDZlS2R1WnpwZzJvSXRINWNtR1NkaFRCODE0UGs1a2Nn?=
 =?utf-8?B?eUk5TjVnaFNTYThodkUyaU1DRkxteGw1ZVNob0xZbFNjWW9tUDNZamQxNWFo?=
 =?utf-8?B?ejVKejB0NjU1ck9aSStMNVpzTksvVldja3JTbzJLcmtpdXZVbGFXSmU4R2s5?=
 =?utf-8?B?UldQVEQyYXo2QkZWMUxQUTVXTFg5aDdabS8vQThsemNPRUREZEhCelFHZmgw?=
 =?utf-8?B?cDZCQjQ4UllXTFdIWmJ1dWNVT1ZWY3NoMm80WWRzTGNVSTB2ZnNqUDNIRlVN?=
 =?utf-8?B?TERNc2d0b1ZWS202QXU3d3hlNzBLTmRYSnV6YXBLRjRxSENNckEwL3JCZEU5?=
 =?utf-8?B?VE9sYlB1L095TWxQVkhEMU51MUZHQnFRdjFycUJvd1pOcmFBWEJXV3pSbHNv?=
 =?utf-8?B?VlQyNHpmM3JnRzZsMDFFNkhOaGsweXZERThOaHlyc1R4Z3hLN0hpTUZlVERw?=
 =?utf-8?B?aTdvZU5sQ0RCR3ZJWVZ5OVh5WGd2YVllMzd0c2g4TWtJR1NueHNuMjhjV0hI?=
 =?utf-8?B?MTMrSjlWdlBDUE4wV0d4UkhEUnRQNnp4WGxBSHlIREUrUXhMcWxkdXBadGxk?=
 =?utf-8?B?VUdYM2phRm5ucWkrNlpSbno1WUNVNXo3T1lSc2ZqeC9qSzB3NUs4U2lDVjFy?=
 =?utf-8?B?VmdJSENpRDUxZWZDQ3VVeHhES3AxK29qSWR3V0NKOFF6eVhxRk1vRm53b3hS?=
 =?utf-8?B?SUxxa3JGczhIdytlNXovZmRRWW9zU01Tb2d6RjB0MzZZMkNTUFVHbjFpa2Rk?=
 =?utf-8?B?OUFhV1Vzdk56bCtiRzlJNUNDUnkxV1NDdWsyNEs3ZkhkK0JxU2ZjM24rZzM5?=
 =?utf-8?B?RStSdkJGRE02TzRKVnp4VmFTZ0RjTWFZTElsaHlLNTFrdjRwM3g3UVRGTURL?=
 =?utf-8?B?dTRHYjRLNGh6QWdEYmlzT1FBZlhyMHlFWXRsQWZELzM1MmlMZUwrUFdnQ0pQ?=
 =?utf-8?B?K09PUmxBVkhOaHlrMXg1ZXFyTVhpWFlQakdPSTA0bnR0b052QzRXMzV2aU10?=
 =?utf-8?B?cCtRUWZzY3JTZ1ZucFMramZTamw0SzJzZGMraVBQaWJGdmZ3TElNNnFGSng0?=
 =?utf-8?B?YUpLMVZsQTBzMnRxaFJJdlJZWWNnUHhtYVdiQ05lMUZmUXlzbUR0SjNRM1Vj?=
 =?utf-8?B?d2JQODlxdUtldFA3cE5pTXNFb0VSMnQ5aW9Ed0QxaEJHcTNJK01vZkpYZ0hK?=
 =?utf-8?B?RngyUlVBemJqTlk5SVZEcGZsZEt1Y2w4OElwMGpGWkNtN2s0eEFMWFg0TzZU?=
 =?utf-8?B?VWI0dUQ1Y1JMVWd5K0YrR2RoN2NZTWJWeWFXMGd1Z09oTVJ5elF1ckNUM3FJ?=
 =?utf-8?B?QTA4RkxCYk5ISitqc2dhbTJybHNxVEJiWk9DcjQ5YjV3Q1gyZlFBRENBN0to?=
 =?utf-8?B?V09GUzBGVWY2ZzVWTmVGVmVLQ0k0U014c2dUeVlHSXlWUXVvZmJuaS91VVZv?=
 =?utf-8?B?UmlVQnFWTHZ2dWJpM1JydENXaDVDZUg5RE5hcENuV1R1dkQraXF1WGoyZXZp?=
 =?utf-8?B?dk9kdDNmbE5YR0Zndk00SCtyY0U2QjhLZmR6YVJSMVQzR3MxSkNYS0lFampo?=
 =?utf-8?B?YUF6cHdDUTRBNElHMEFRczlLU0h6S21yOWsrNEhOYkd3NitIbVZkLzZrc2xq?=
 =?utf-8?B?SVdWM1FRMkNRTDRiOVJwSjNjWGs4NnV1UDRybmtidDdranhxaUNPVHYvTVlZ?=
 =?utf-8?B?enRVY0JPQ2QvUlNqcmVETHlaOXRQUzlmM1pUeGdKWnlLbVNManc3dzVLZzNj?=
 =?utf-8?B?Rjg0RklEOXU5QlNYSlN0d3V4UFlmR1lMSmtTdlFnMGdyMCtwOHd3dHJLQTZl?=
 =?utf-8?B?cHk4RFZGQXc2SGpRRzQ0dHNvUDBGeDdpbHF6V2FCb0NCbDhvSzVUMjk5K0lt?=
 =?utf-8?B?My9HVmprRXBvMFdZR2dHaWdBTzRpZ3B1QVVNZXlwR1JURFdSMEdQeTF3OCtO?=
 =?utf-8?Q?S/cIy+OQJHXY9GM0=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9690ef3d-18a5-40c9-d7bd-08df1e4e6c38
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:23:48.2789 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SYUI8LUzmYSUszK+mbXBxFLt/B5jdDwBZUN03GJHqXVg9qBlfzGn5JUAJHSmCpw0VtfO0nSp5PXhppUhvMdM/4g/FA4Mahs5atQxAJW+7P4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7910
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The snapshot RAM-saving path does not support Xen's memory mappings.
Refuse 'savevm' and 'loadvm' when running as a Xen device model, the
same way they are refused for CPR migration modes.

Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 migration/options.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/migration/options.c b/migration/options.c
index 92eda90114e..0b7f393492d 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -37,6 +37,7 @@
 #include "ram.h"
 #include "options.h"
 #include "system/kvm.h"
+#include "system/xen.h"
 
 /* Maximum migrate downtime set to 2000 seconds */
 #define MAX_MIGRATE_DOWNTIME_SECONDS 2000
@@ -563,6 +564,11 @@ bool migrate_can_snapshot(Error **errp)
     MigMode mode = migrate_mode();
     int i;
 
+    if (xen_enabled()) {
+        error_setg(errp, "Snapshots are not compatible with Xen");
+        return false;
+    }
+
     if (mode != MIG_MODE_NORMAL) {
         error_setg(errp, "Snapshots are not compatible with migration mode %s",
                    MigMode_str(mode));

-- 
2.47.1


