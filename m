Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F75CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 13:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCcwa-0002BU-MS; Fri, 02 Oct 2026 09:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCcuJ-0000oo-DR
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:02:38 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCcuH-0007Qg-Cv
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:02:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HsjaVLuk+hBsv48gU3T98Juz8FPysnbcFl2KTcCsLI1kqKkr63nmF3IokcX5wYTwY8e68eDDd1a+G3oQCq/hRc7YfmXJtoj7KEldSUyontI3bNspyLOq1fI4NvKGi/rhsJks0IGW5BRyk0q75j3F+0wm6rqcZLyX0fcPwZ5d8cLHBCA0Ic+YH0rt6AYn5oRCMgt4WKXyqP1zuHnO0LY59DxnfpdHcYZ8f3L97e/ndugZbmw2cl7G0QsHk13FhWiLKtFt6CZa0TE65Z8NkrDhfvoytOrIBBbhpqWD+tiQ0vijZX5WCmWZ4b1Hyg/0Z4q18E7iafZzTBhwk3uczOFLIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsFB3FDQ+3FBoUdGrsPH789lm9GaLA45KHUm/J4Q16c=;
 b=nMF9Ghd4k712DwR8Umkzoql8HhI5/Y2vHzh7qQ5Zpv1TS44+VVna+lc6rIXTFy02HdP/zrhAytImFjug3UfIYlrHAc68+AHPMOQ/7QEXEaOjiZ+Gzwp3f3VuacUKhYK0vSnUb1eLcRrB6PQRYEcFIGB+KKh4CcHXiEAh9DzdY2j7jTZ2Kw3xTCfUHJEbMpb2cuFxM1f+AITYsFxwj0BEHJwi0t3ndNoFD1qIhoz9jEk/r66sDDJHJoF2K9jBkVr1vWtz389YPRgZ5NDYStIXDwza1yVuLhub7rreCJ2wA60PKFWeEC6hXhISKJfQmXaR/hLiwziyi2QUtKHV0bBalA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsFB3FDQ+3FBoUdGrsPH789lm9GaLA45KHUm/J4Q16c=;
 b=tZAc713dy2ghpw+rBFAhK9R7RnmyJWcTg9HfnJUYG420MPkzZExjLhfMqymosfGZVQeNB/cbGbw9oK2mpPPJW5FN8UspbjfcHgRgd4FDpbdQgFtyg5Cp9ld1Ovz6RhQhYfPzOXBNg2aLvbeL7mwwR0MhAq+D3EufSi1v/PEbG4vABxbKDQQQhpKjuPCDdJz1t0/ODVCNdb7En9ZWIwGWngD9X77xF7q99+GR2x+0nuxDQlYozfVKlNMWhoRfzC4FSLRd7W546OGoviN/bnoAF1uGWxvUC6mLa8SuEj2ppvQDM73BOcVE12l1XiGlEHmRxWc6+7u2/xMotFcyx5v0PQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MIWPR08MB013052.eurprd08.prod.outlook.com
 (2603:10a6:290:e8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 13:02:22 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Fri, 2 Oct 2026
 13:02:22 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Fri, 02 Oct 2026 16:02:13 +0300
Subject: [PATCH v11 04/19] migration: forbid snapshots under Xen
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-up-vsock-vhost-v5-v11-4-18fa09d8273d@virtuozzo.com>
References: <20261002-up-vsock-vhost-v5-v11-0-18fa09d8273d@virtuozzo.com>
In-Reply-To: <20261002-up-vsock-vhost-v5-v11-0-18fa09d8273d@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: farosas@suse.de, andrey.drobyshev@virtuozzo.com, bchaney@akamai.com, 
 dongli.zhang@oracle.com, vsementsov@yandex-team.ru, philmd@oss.qualcomm.com, 
 maciej.szmigiero@oracle.com, mst@redhat.com, dwmw2@infradead.org, 
 mark.kanda@oracle.com, sgarzare@redhat.com, den@openvz.org, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, peterx@redhat.com, clg@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIUP296CA0042.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34d::6) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|MIWPR08MB013052:EE_
X-MS-Office365-Filtering-Correlation-Id: 512f44c7-2225-4de9-c3b8-08df20856625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|52116014|23010399003|366016|38350700014|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: wrV3jg2UV7BPP5yL5Xlsxvb57qKjr9sHadUWLGOwIZBOW9wWBVhMJbT6ujo++uYxUHPrbCjtDys63ybLSp0sTcI1Tth6eTTbI1UzFnIo6sd5Dvf6SAWB02r1UzmPNedjDFZzf+CZnXQz7Q/EhgqcvTROmquifykyyRgyu4xH4EvRhHfdCkB9z/IJUG1O9FhVRdM+4Ugzc4/D7UhWwIz37PsHUMdHlD7CVJt2oy5eAx2ctrgE2fHgLqEICN6Tg+/BArF6e4qk5mulFp5WviabgN/TablRDdSlX5/ckqBstCD8I+ntNTjKYho/sSSm9pjkcewsvsEkIC0mVgIrzhjzEEdIys9HRVIQijRQrTxxww2GqxZKT9wdj+Wpj/dytm/SSzF8WSBilqEWrLq0abXPyKmfNwpI5e4V8H1WXcGZ8OntiP/x6RbMjrpC3g+9uuWvlNU1J3Zg4IHmeUJgmMf3f1+ZrZe7Jp/Cp/JMXZHpUeCPV7sF3zfdzSRIUGRB4TtVKnnm0wbC93NBxHY2gxfNKtaORoU0x8IMtY6ScNZ9K1KE4Pj94yDGMdUl91Ngr5d2nbjfRjiV/IPNuWLSbiVnWqUB5glz8VYq86mk19zl7rrOJDCMr4WXFqdxnguLlYWVt6uvlEy5mN3YW2MYdtVUgcp6yfRTyHpCmF9IczY6EWJcdNsA7qkeE97oYFJMp9DdF8ux8T2vw3Ctr8leuodH3HuyjTReBzJbf7U5Umr2X7g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(23010399003)(366016)(38350700014)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkNUTlNjTnJFVjZXclRtbkNMdjU0YjdObFVMVnpHaVc0aHdFRW01L0xxZVhV?=
 =?utf-8?B?L1A3RXFIYmxtTXNmYnRNaVlwOStPc2dCdWNmazlDWnREUkRJSEpjTTFlQ2hR?=
 =?utf-8?B?OW9aT1dZS2ZxRnl5b3JtRGQ3TkYwVUtxNlNtd242UHQxcHpNeDRsWFBraHFM?=
 =?utf-8?B?czlUTCtWdEZNNFhjVUJDK2QwQmZmaThTbURDZmlEU0puckMzeGs5WVc4Qkl1?=
 =?utf-8?B?WXUvbjhuSDgrMjNhOXZ2TVpBRE1Ic0FWWkRjMGdjSjBXMFcrTUJEeFE2Lzhu?=
 =?utf-8?B?bWp5MTV0Yjd3dU5EZ1NuaFMxazg0cEszMnA5djY2U0svNHFVaXhyV3BvYXN0?=
 =?utf-8?B?UVVhOWd6a2puRzNlWklkczhreDBLMEk2UERLYWJVZHpGYS9OTjRCY1pDdUxG?=
 =?utf-8?B?VnVnOG9nK1JKaFhzdk9ERHllV2JlSXN4SlVPQ1dOZGtqYmN2ZXl3WEd3a2dP?=
 =?utf-8?B?YXd6TDVCRm5waitqN2N5S2EvTFZkeHU2bjBCNFc4VS9DbVNPVkVNeVYzN0cr?=
 =?utf-8?B?ODJNMnRrY1BWajZnWDJXQ2gwUENBMUVkVUh2dSt3L0hZTy9FVmgrV0VOUXBI?=
 =?utf-8?B?dUZwRGVZNEhTWnBXcGxYRytxc0tHejV3VnFnRXBEZnN0dkJ3Rm9JeTFVaWM2?=
 =?utf-8?B?MDNveURQOWZNNUFLQ3V5Zm84K0tweXV4NmNUWmpuaUlXbEpqWDU3SDBEY0Fp?=
 =?utf-8?B?cVhHZytzQmxrK0ljeE5tNXVGUnZsczI3aURvcDV6bjFIb09YdU1nM1JnZWtm?=
 =?utf-8?B?L29aU21sRy8xT1lVdGVuaml2Z0hiNWdPdGdHL21Ea3RrZEJDMC9xMGw1MDhw?=
 =?utf-8?B?bWlSZ3RKR2Q5amlaSXdDMDZNbkNKS241VTYzTmRwd3U0V1NGU293cGxjcVM4?=
 =?utf-8?B?cDhxeitVbXd0aGFGUUovUTV5SWN6cWlpYmlMdFBzVUl0WTYvYVI3amkwek5V?=
 =?utf-8?B?c3F1dGQzZUFtdXJsNUdhSGI0WW9oZEJtUk5ybk85VFRkTURQWE1CaVVrejlw?=
 =?utf-8?B?UWZ2K1EwNUwvQzhzVVRiZXhSZ045QzB5NnpIM1A4WlQ5a3lleWFaZm44OGNX?=
 =?utf-8?B?N00wMjVNdm9ZRW83NmJuMzdGUmM4ZTVJdkNJRDlBL3hJNXl2NGRPb2RuWHhq?=
 =?utf-8?B?TDNVaU1BYmxsMWVDVzJKWktrNklxbHM0YjhVbEVWRkZvaDcrMnBZUVA3cnVC?=
 =?utf-8?B?bFdKZkJHYjh2em5XWWQyZ2tiV3pHVVJ3WTR2eFJIalNRWmtsUVZ4TjZNTXJw?=
 =?utf-8?B?WDBJNlJYTXp3STBmc0pCbkpDOG1YT1VsL1lGWmJNY04rcU5ManZhTXRzb09E?=
 =?utf-8?B?Vm9lNTE3YkhsTk1wZmx2UGcraFB6elBpU0orb2cxanNVNUo5aGt3UUZ0Y0JH?=
 =?utf-8?B?VktJOUNPS3FvTWRwRFVSZzd3Q2lrTHZXcERSZFhEdWt5b2wvQXVyQ3JzMGs3?=
 =?utf-8?B?blRwYThSV0VWbWZ0dk5uNklZMmtKQ1c1UUNLaERkUHExZkp4cElJekJ0bkNx?=
 =?utf-8?B?NFNwVk1FSkFsbW5FUk9oYzJDSm9pd1JNcTdPS25Jd2JJWEZuaGVGaDBReUtY?=
 =?utf-8?B?YUVtT09QVkFkSFFqaWtuNW52UlBFOEg1aGpVdy9pV1BidWZBYUgrYnd3NXN6?=
 =?utf-8?B?QnliZWoyRTI0TXRKand2VGJ3T3Q1YVJyWjdvOFBORnJDMlllSENDbjd2cEx2?=
 =?utf-8?B?VitCL0VXQmp4NTJRVzR2Uyt2L1VqWkVidVlhejc5aXhSeks0c0xQMFNGZmll?=
 =?utf-8?B?NHdzRjhqS0V1RFJrYzJCRmVyUm5wVnZrOUYyMXVEcWtYUkNhT09Gc2k5aVVH?=
 =?utf-8?B?RXZyRW40L3JIUzhOM2JiOXhMMFNSUkVmN05paEFuZmRuZTlmMDdTVWpSRkRJ?=
 =?utf-8?B?VjVUS08vZG10cjd0aTdyMWNHdjRzQzJ2QStscGdUYk03K2gwTEtRdFE4NDk5?=
 =?utf-8?B?Y29nc0VvRUl4UUZjQkIzUU9xTEpER1JMejErOTIrM2U2WWJjOU5QTncwQnhN?=
 =?utf-8?B?MlNUcXVFbXpOelg4L1g4TUNoNGtoRGJ5SkdSTThRQlhLTWYyZHZYTzMyQy9s?=
 =?utf-8?B?YWdTTjFvVnNBeFIrVU8wVkUzQmhxQ2VoZzRQekFpSGFjNjBiV1M4cm5pZVBt?=
 =?utf-8?B?VlJHNitvbTF3bnVMR1R2dUhkVGJJamlIalBtZXZheGNFSk90bUJkbTBMb3Zr?=
 =?utf-8?B?dnVZV29zSENNUHF0S2FKSEh5S1phekVvYmZZQlRrc3JYbzFkUUxubEhETnZw?=
 =?utf-8?B?bkVXbkp1NG5HSjc2MjRBTkg0Z1FQREczQTRaL2J4eHhUbHRzUmdwdndaVUZC?=
 =?utf-8?B?T3NVMktCRmthVjl3Nmo2WUZTdjYrQ2lYNnZyNkVxdjFSOFE3d0Q1M1NJdHIv?=
 =?utf-8?Q?koSxnS8W7t2zWvG4=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 512f44c7-2225-4de9-c3b8-08df20856625
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 13:02:22.7855 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ku5TlDLV/2FE5UAmHKRhumCqgsbopPrrWHgejyeyT78PtQ5hinLbo8EON+TSzhR0SG72xDTu2b49uch6Rn0XLZ2SFkvk4DIl/1IxGJ0J31o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR08MB013052
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
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


