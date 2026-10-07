Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8C2CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENsf-0004TE-4N; Wed, 07 Oct 2026 05:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENC5-0001Dm-Nt
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:23 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENC2-0006jK-Ts
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2LKftoE9/ILUQgyGDVtmc6uOaLOCRHyFfGhyDNXyBFL+p9iuZx7/a6+NEYk6FJ4Y5Cqn/vKrjMlo6Fe+UiSf0LLOHnF6GC5k14y7f/ESfR2F3eoCNjLkHjGZDi9joltK/lPi4zol1UGWClKLRzTtzTkAjpN8bq1f4ygghucnI1TPPlNPfZfhrvoxSUEDRWVpb5AAeCmlJiMN7sryvkMvloFNcolVe/OI6pEUnYZyJlVxg1i+qf0Ev5NbLEI2XywMa+K2ooO0P/PemZUGum/1nrhz7CL9RJJ7Y/1+TSZqtt7SB43DeZW59i521nolK9NW/mKrmp3a3dLb98ndEzVSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXgQR79hkZDDfXuHJA0otbnU8q3wx4xJTCQyzRPPke0=;
 b=HpTTzbjz14S2q4Zxyrv/rfJApaY2mzn62v4XqJXm3gMv1CLDNtZ7VzshakOUgwBhL9DfQaYC1XY8KYsQ/3mNIiVeIwVffZZ0BET7kPGDPgLwZgqGtoD4F6ufwss2DNxdLtt3Z08LYgwGG/5EPWJhizq8SjTLkAAO9S7FMLt2TmaApHNOT1lJXiwrHvvz9qCVIXqUoMfyUygYfcxdNhw5gLdYpFUMU0lux0pzB6oAWKFXz8Ns+VqkBM6cHuG3viLzInI8G8D19iPa56/VK+QHsZYIPQ5qdxu14vZ9toYMAccsQ/2raJPRR6veOXScbeyGnchxIIKSaTh3ki70+JNljQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXgQR79hkZDDfXuHJA0otbnU8q3wx4xJTCQyzRPPke0=;
 b=Uk2QSF8rPDGOwK0ryz3Ej/XxSggwAreNkSL0NEBcpSBtT+WH2QF2g/re/9us1gFd798i76PYs8kXor5wuUnv8LUCV6zxJe2AhpD7ymeKXoVj3mKDDuP4zetPgRvatV65negq0lbBw8PvlP3gRVpfYQziYI7LsUUeL5n+DXo4+oMHnxecW0orUuyFZ7T3EpDvIAnwW5jzBi2Ovm/ip/42+lHvf9wfsGc9vIdDWmMrBOJzcgnzskA4s1OKZN9Bq5jHrxVePlxXFfkl6Hk49dlY83gXOQgeKDiIxo8+hu9/B5X+r9NtBbIIEhjsUt/DEzxN1P5eOVikkKDzO4Wi0CzVwQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM9PR08MB6292.eurprd08.prod.outlook.com
 (2603:10a6:20b:2d8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 08:39:59 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 08:39:59 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Wed, 07 Oct 2026 11:39:56 +0300
Subject: [PATCH v14 03/22] migration: forbid snapshots in CPR migration modes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-up-vsock-vhost-v5-v14-3-e16de9962df0@virtuozzo.com>
References: <20261007-up-vsock-vhost-v5-v14-0-e16de9962df0@virtuozzo.com>
In-Reply-To: <20261007-up-vsock-vhost-v5-v14-0-e16de9962df0@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: dwmw2@infradead.org, mst@redhat.com, vsementsov@yandex-team.ru, 
 farosas@suse.de, peterx@redhat.com, dongli.zhang@oracle.com, den@openvz.org, 
 andrey.drobyshev@virtuozzo.com, mark.kanda@oracle.com, sgarzare@redhat.com, 
 maciej.szmigiero@oracle.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 philmd@oss.qualcomm.com, bchaney@akamai.com, clg@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI6PEPF00000236.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8ee) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM9PR08MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: cf794a87-04ba-4cd8-5d08-08df244e9278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|52116014|1800799024|23010399003|38350700014|5023799004|56012099006|22082099003|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: hHR4wOw4jgzxZiBq9GebfIRjRwLhgMqQjCMeLUQmMyKwmOs6hdGL6VwYgojwTHg0/wByH/67yJPYScECxtMXo9Zwhup27ZP+mIUEXfHNj5FCyO+y/z4bfj0EF1+fHTJ4FgyOqpnlekizQivd1MzQcgdznke++ITdIG3yPrL05dP2x4n5c6eDEa1wz4tBelSucQ4VVAJcO/PNBmLKjP1+NyQpH+Yz2LyV3mwc/sHloatMdm6vS7rYzeuRF/toomx5A3nn/ZMgrE/a8wBSiZyyGTNqTsfGlaAVXa/ynMTjsyBH1HS5DsFZhFYF9xr2C0Co6Qi817VZk6GHrk1eP6evVHHMtySHjot/vv26xw09OWJt2r8shWd7UqqCHJJgJKxZlBVZFURiX4b9kJ5cYTYukH1LZGJieQmgWuP+JRRnOgc5xYQ8W8QA0jNJTJ7ND91CzziICzIM35+fWuExC36pM1IkJyGisx+B7SFMZOETC4yTUGTinAmXXUS/PzJQdgNOODH3udbwTUGonHszQlKWFX7yakN3zj+tlgjLh0Iq7/5Le55jCna72OffmEfTc6GfKbvKHVCzoy2pDfvcxXQFs0DT897eivuX1Qp5Yk/LM2wOspg7Gh3eIDDm6X6h/dhqZEYCXEiMDjLnp3wFDYvZg+iv1XpImrtbfjzUfqW7IMvbUBnTKJKQVCmA6SRtPe0uMqB7VRCs7YYFNOFNuzBb8MAbxdqN7G5qKtZqcRmLbjg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(52116014)(1800799024)(23010399003)(38350700014)(5023799004)(56012099006)(22082099003)(10067099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1lhcXBrY25ldUJ1WXY0SWkwZ25OZnZ0QTdmWWg3MXRWdHAyVzNLM21OM012?=
 =?utf-8?B?WkdnNW1EWFpTajlMenZaQmVZN1JBdUp0WlVUd1pyVDhKOUFNS25VZlZwSThk?=
 =?utf-8?B?ZVAvUWwzSzJocUxtdkp0LzE2S0NMOXIwVVJ1M2VjWHBINUJONU9ReDNHVTJY?=
 =?utf-8?B?VElwczZLNVJBaDhkTEpHT2h1V0EvR2p3SEEyS0xyZFR3QllIUnFLek81V0l3?=
 =?utf-8?B?WnRpNTlFaFJBamwzNmhwOTFUSlJBaFBQa2s4bEV0QW5hM1JwM0NjVExvcHN4?=
 =?utf-8?B?akE1dHZCd3FkWlIvRzBwZ0E5RDNGdXNlb0o4Y0lKaUFlb1ZHaitTSVhuNVM3?=
 =?utf-8?B?MmFiOUJWZ245b3VXTm9HT2ZCRDNyWUhOWGZQVTZTb2ovbElpR1RMZjl2TnIx?=
 =?utf-8?B?SmFOQVJ6M0p0dzBxTUpUNHFsTUdVQ29CelV3bEQveFFuRGFETVBUZmtuMHlr?=
 =?utf-8?B?N3pxZFI3TUxoU1d4UnJMUHhWeXVWTmxCZWtOQ1UwZ2krWTNCemVoRGRzRGkr?=
 =?utf-8?B?KzV2cDNPcU55d3RLNExFdWliRkwyb1ZHNEordURxenhjalFXYVNIdEZkaVha?=
 =?utf-8?B?bDVTL0JOQ0NGRzRhV3c0OGJJMFFUNFB1ck1VbEYxTG5uMk1iZ2lxWWhhWGta?=
 =?utf-8?B?UkNkbVVsNUtBZ09xNC9BS0VrMVNpM2RqVDJIZ1FINGFRUGxnZlN3NHlqbXJ0?=
 =?utf-8?B?MWNWbjBhbXdnalMvenFXcXgyUGx1K1pYeUM1aFhPdHc1eWlMME8zS05wNjE0?=
 =?utf-8?B?SDBmMmFhaDFHMEZhWDRJcVpWbURJdEpHa01CenBnR2ROUnoycGlpTFhKZXBy?=
 =?utf-8?B?TUJ1TzNWaFB6OXJ0NjdrbXV3dldSOEhwUHBROHF5emkySy9GMGVwdC9LT0t5?=
 =?utf-8?B?bFRoajdac25ucDJ4VURobkhDYUh0SklWRTJ4MU9zQytkQUxwMzhmU3Bzbll3?=
 =?utf-8?B?eFgvdEhXYVlaVDQ5QVBtbkVLOVBjRExDUldUbU9pQXhydGdaS2xiWVFJUDFh?=
 =?utf-8?B?U05PS0VpemgyZWQ1bXNvVklYQVhudVVRL2xVazhKczBEUWNJRnJydDdIZnJ5?=
 =?utf-8?B?anBaWVQzMTVpbldQZUo4Z1hQU0FpZ25KY2NIbklIV08ycTMwam1lYVRuZGxa?=
 =?utf-8?B?K05mU2k4dUxjWTVWaURrdHdsL2RvQXBOUm9tdjFMTDYzVXJJTHNmUEQ2djI5?=
 =?utf-8?B?Y0NqaFdwT1h4V3phdUJEclBuczhQcDB3TzV4VU5yUFRUcFVPcEpGR3JmcDhw?=
 =?utf-8?B?N2NGbWdEOGE2SVJEUzMzSWhCdG80Q1RjTldzMmU3RVVURjMvcStIZXlsVmh6?=
 =?utf-8?B?Qll2a3FtbkxxUWdJVnlSUWVLcUNnTytGNWlkT0ZoTjFGYkNjL3BwbmZGalAw?=
 =?utf-8?B?TXhoeEpWRHhlL0FHMXJNQVNlbkxRM2lYa0JhTlZFQ1EzZG9nc0lIcDNHU2Rt?=
 =?utf-8?B?N2NCZXdaMmlmRTQ4elNkUG9MMXFXbUlOamFzMEdpTW03RVNEWkdKREtOY09t?=
 =?utf-8?B?SmhsL2I3aHBhRi93MS9sMkZrVE9keWZXM0R5bkFQeG11MTAzT0gyYldUSEJN?=
 =?utf-8?B?WmlRWFBNVXlKRGJIdlZkSCtpSGJ4T2RzelZlakc3UzVSb2xhUlJaczZ4YVhw?=
 =?utf-8?B?Skk3Y3lVeEdvRTc2V1k0THR5dnZKanV0bnoxVklablF3ZUZoS0VLVE5JTHNo?=
 =?utf-8?B?YUxIWmZBeGZRN3FITjZUWDVXMmZlU25HZjdMRGZWVlBSNFI3eGFMNzcxZFJz?=
 =?utf-8?B?MWppME1VRDFabVBMYVprdzhjWFc3ZXJCVEswMGlaY2dYRDVFa0FNMUM0VDFj?=
 =?utf-8?B?MFNHc1ZZa3pqYmVhZlNWSWs0ZnhVZFQxV3kremI2Z1BlZWVyQ2lkZkxvV01w?=
 =?utf-8?B?V0hXeTFuVGtqbFdBU1FNaWJheWEvV25XZnRKU0RqbC9Wa21zb1NXMHV0Uk5F?=
 =?utf-8?B?ZEM5b01vWWhDbW5EMmVvT3ZNUUw3MlhUdGNMZE1iT0JJZThHUDhlTWFhcUF6?=
 =?utf-8?B?YS9YbXZ1ZXp0UUd5SjBBLzliUGtyMUYzZGpYdzZmQWdQalhZTUlKVTNXTEVq?=
 =?utf-8?B?d0xPMEhZZXdnYWpkcXFkVnpNdW01YmJ1Zmdha1BLcW5UemxiU2pvbHRTQ3py?=
 =?utf-8?B?VGVSWjhtclFkVzMvWmQzT0dKdnNyQ2J4Sk9QQURjU2k1N01NTlQybmUyV3Za?=
 =?utf-8?B?YXpPWmQ2LzJVRVFlb20zN0UyNUtVMDdUTHBGbHJxWU0wbExPY1ViWEdKVWN3?=
 =?utf-8?B?eXFoWjUxc1dpcityUzluT00wdHgyNE1XbEVOK0JCWW85b2hsWmQxcnY0ZzNT?=
 =?utf-8?B?UFlkOFVDQ1R0aWRBTG1CMS9BUFYyclBKNUR6SzNxUnRHT1gwVkVOVENtaERs?=
 =?utf-8?Q?2Ik6EBCsJ8sYIx2w=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf794a87-04ba-4cd8-5d08-08df244e9278
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 08:39:59.4392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vSTONijEeG8hbBdGFSJHfwjYFSqOkXZNPgbrKvLE8uHiT2zTJXhUDiproFgxuNg8/w3h4Iy55NqI5CxszghkY/v69uVUNLF6VcaNnMyUqCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6292
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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

The savevm/loadvm operation doesn't make any sense in any of the CPR
modes.  Saving VM state implies saving its RAM entirely, while the whole
point of CPR is avoiding that: in cpr-transfer and cpr-exec modes RAM is
preserved in place and never put into the migration stream (see
migrate_ram_is_ignored() in migration/ram.c).  As a result, a snapshot
taken with such a mode set has no RAM in it, and loading a snapshot with
such a mode set fails in the RAM loader.

Currently nothing stops these operations from firing with a CPR mode
still set, e.g. after an earlier CPR attempt.  Reject them early in
migrate_can_snapshot(), which guards 'savevm'/'loadvm' HMP commands as
well as 'snapshot-save'/'snapshot-load' QMP commands.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 migration/options.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/migration/options.c b/migration/options.c
index 46d040fc3f2..92eda90114e 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -560,8 +560,15 @@ static bool migrate_incoming_started(void)
 bool migrate_can_snapshot(Error **errp)
 {
     MigrationState *s = migrate_get_current();
+    MigMode mode = migrate_mode();
     int i;
 
+    if (mode != MIG_MODE_NORMAL) {
+        error_setg(errp, "Snapshots are not compatible with migration mode %s",
+                   MigMode_str(mode));
+        return false;
+    }
+
     for (i = 0; i < check_caps_savevm.size; i++) {
         int incomp_cap = check_caps_savevm.caps[i];
 

-- 
2.47.1


