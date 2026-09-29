Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2BCCA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 17:26:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBbYf-00066L-R5; Tue, 29 Sep 2026 13:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBbYe-00065Z-FQ
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 13:24:00 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBbYc-0002kz-KC
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 13:23:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z4zKXQ2sn9p2S3jT8grYkdvvWQdaDVbGcjzE+rgnRBHahrEHkjNMlC0LRyfMen4uDDDE8D7xm8rQUTCW2q/k2eFFiIucgAGqs8v3aEEsKHGmkYowyvMol9ZvS4D+9WZ6x+SNc/mHQ/2SLwLq/wQb1F1b8tXyYG93WykNDu+w1SYvoynH3u/6vdMR8FOTsiSYJCxwUUz14OcfLZQ+PtOW/6J6jLXm/EYsGxGDXZzbZ98DWXgC6HTI6DxM4z38jCFMhwTuVpSmdzOqL3pBS+bxlTebewZfNF5F0C8RfILSfdLOZ0TWdeTus+VF9bpLmdMpxeoZ/bJKHd+F2k4N1tZinw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXgQR79hkZDDfXuHJA0otbnU8q3wx4xJTCQyzRPPke0=;
 b=avAmLFermko6h0IYiX1H9m6/WAgTh+rbyIjReEaoZ43U4mPpFY1riN5esqSXXtDQ97g138Tb/N5tXHW++K0MuOkCIpUodoGstvQqLdxfVHb8vUQHnbg4ffeosVNupxDPxbHPz/oiXX0BntJVy/CtpgcmYHtrfa+5N4Mvt9QEfU++T5oX1XqY2XVsno8+diORK9UnZYsNXRaAoura2BNfA+lKeE1rMnptA86fg7Okl/2tNeWwo89ME4ZQ3wOn0BGiTq9UVGvhQY/K+zvQAjWb1aoq1vB2/IHgFIcMjOLFtdlZc2IhrZjzQmeOV/HZRbRS+9/ZJ6sBZp+GyNJpLNTDjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXgQR79hkZDDfXuHJA0otbnU8q3wx4xJTCQyzRPPke0=;
 b=VFrTmAKO/5fYSelVnJ8lw+fv4E1GywXk+XDEQnWALK4wuYF4v5BNdUGKcQ7+SCLpe6pjNloNqhVkDxrHL+HtX6tfP88qTQIVCsMSCqFwZtoHJQAbl3sKWHbvdqN13sj/8tzpq3x+RKPUGC45a4FJBbmOzNegKTUNzk+fT6HlC6F9Umd6h+9kTOw3BX1i/6EjrX+0LQYEOL0lws3vuNNWAZpnPznyOGYghtkglfcMnPIBykqdAI1KcnfDR5ooTZFPbdOu4qvUs76YbJULXUuQ6do75IznEfzTMZ8MgG/vPBdkTmo5QzPqqhgwfpeSZI+x46YMyudnzpZWmHLXjsmyng==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB7910.eurprd08.prod.outlook.com
 (2603:10a6:20b:50b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Tue, 29 Sep
 2026 17:23:49 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Tue, 29 Sep 2026
 17:23:49 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 29 Sep 2026 20:23:22 +0300
Subject: [PATCH v8 03/17] migration: forbid snapshots in CPR migration
 modes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-up-vsock-vhost-v5-v8-3-12bcf1c0b84a@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: d250fedb-4ebf-438e-4fa2-08df1e4e6bd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|52116014|1800799024|366016|10067099003|56012099006|5023799004|3023799007|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: N5hUPFd+TLsBg/StABBBcQjf+JJXcAB5UUT29Hlv5u6cbz2FpqKcTl2u2tsJiYQAVgmQtAPqGNFcGjZRKTQqSe/MmugOESMzlz0Lj9TFQKQkPI3VggDyRFwfMXZu3OSr1GhDusFjMOnrdaqLXvdMvrc/G9Nwa9mg/kR24d9S4YRSjgof3HDL5pNmEeDTyW9lRLqC7ENT/THbXVNnI0HpiNgj/ZgTJk6hpFWcJTkYq+7fCr7Zuts4/p+M7yqhJktO8wuhMeiKpEeA/52sUy3WsYkOTHDxkSc6IBbyFV0Kl55iGZ8QV4jUunU36Jbfiwxg0ms/3REet5gFAKtPfMVJE2bU4wvPBFoYWsXt2/W/fi0ttyI1WfOYNY3ssl5l64xd9AzMCdz2Ojmxb/Yn6Y2/X3iZY4UZt78koLF7G2DkNqr3LtZUI2isNNyllLnFcmFO3UXqviAtG3RUNZp+R4DD1ux1A+Uw0dMZKNeekLjcbiEDXzilVBwB5iPoV76N+0DSts+msZb+oyiPVTybQ1x9OLXP/Xc8RtN1+2E9Be0K4hC2ST1IQm4OinzDxcCyLTVXv37U8UC2MmBzYtEyPYSISA9+geqRb/ytlRF7v/Nw2Ij5AorvQUEhhju5GNtEVjvyHg9+TN5/CzJvTrVZwBrBboBCyiWuGJj6Ny66RGo5gsBWJbNDObUAJLyZRRqIUbxe8QI+HBdXCABIq/+3bw3LVXX30MYN6/5COtQXMe/joDo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(52116014)(1800799024)(366016)(10067099003)(56012099006)(5023799004)(3023799007)(38350700014)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azVlcFczekdmTU9VamlGWEdxNmVhTjFUd2lXd0VudnU1NmsvSTBZNERnbGxM?=
 =?utf-8?B?Y2tDdnBrK1pocjdsNzU1MFdwVXJKdHpKelAvN0FJY2IzQ2dSRzA4OEl4WXVa?=
 =?utf-8?B?YUJsbkVwQ3FJWjVsM004bVA3akZHMk1vekpDc0VldFdRWU1KdVc0OENkbktu?=
 =?utf-8?B?bm9SaVJiWHBrQUg3NWtjSDM3VzRidjRPai9Rd1R6QXFhd2NZT1k0azdVb3lK?=
 =?utf-8?B?R0doQThDQTVDL203RkR4YS9BQ1E3cHEvTTNyQlkvN0k3Q0ZPSjB4RHJNZU5w?=
 =?utf-8?B?MjJTSHhaUWlrZnhLWTlYSDB6bG5VMG1IL2xmZ2krKy84cHhJOWJYeGFyM3Rx?=
 =?utf-8?B?ajVhQVZlbkpRZ0ttNFUxS04xL0hZNDNDdWNPNnI4YnRLaTJ1YTZtM3hqaTVS?=
 =?utf-8?B?cVpFb0Z2dFRUTFVtWjlIMWNDdCtqRnlHS0NHb09aYUVrcWpOdXRNT2NGQ3dn?=
 =?utf-8?B?WTk3bjF3aTlsVE5YRE95SmM2Nm9iRUZvTHdaMDNJYXBlTld1OEtvbEY5YmMz?=
 =?utf-8?B?SUpaeE90aGxjTWJ1dmtqdit4MGxoYUNwS2cxdHRRNFRVejloSDZSYWw3ejJz?=
 =?utf-8?B?Sk5nRHNCaUFrOGpHNmRsUmlGM3JTdlJ1b1FWc2gwTzNvaHlCQUUzQkd6NDRD?=
 =?utf-8?B?dTh5YkM0QWJGZDBwSHoyRDZJZDhITmJDZzZMSU95QmoyVE1qdDF2djFwVDBG?=
 =?utf-8?B?UUdONDM2VWI3bEkvazd3M1pmUnc0cmRVWWpRWVhXcnNGMnkweXB3ZmgzSnh2?=
 =?utf-8?B?M3o2elJDbitkek1HbjZ3YStxV2xhcVNKcjVmbEE2cndHREdUM2FodDRhL3JH?=
 =?utf-8?B?c1dOZjFtNThWc2lrSGRjNXloYXExeGk1emhYSFNJLzN2WXN4SUI1aExqUGpY?=
 =?utf-8?B?eFI5RExsRWt3VTBjbXBRRmhWb1ZYQVV3QW5WRkFpNkNoaG51eWxUNE9lTnB1?=
 =?utf-8?B?QXF3VXdqSjZqU3FPZnRweWhUL0Nvb2lwYkdnSXlCZGkyYzV6aTdhcGJIcmpI?=
 =?utf-8?B?ajVaVEErV0hpelpsRW5xUjZXcUJYOTAwalR6cjJsNnNPQTFONDQ3WUpaakdY?=
 =?utf-8?B?S3BNNFgyOGhsTzJKQUVPaEl2TTRiZ2lUVy9YdU5LbEgvOEwxUlBLelErR1pT?=
 =?utf-8?B?TDdvYS9kRGlBQ0QyMU9ENkxoVzA2MTJBVWFzd3Y0bHd6WXdPTWV0SnpRS0pq?=
 =?utf-8?B?T2w0ZHlORW1weFRTTmt1UHlETWg0Uzh5WFNCMUxYUzB4aFVqQ2llNWliUGZC?=
 =?utf-8?B?azUxZVdJeFNLRjcwakNQR0dQVllocXpJVnJ2RlRldXRKbHp6SjJVTkEzWW5U?=
 =?utf-8?B?c0tjamNyNE5ldTdTWVd6WTdwYm4wQ3pWQzROOW84dGxOaVEySDBCMGltQklj?=
 =?utf-8?B?Z3BLcVphNEducEhCUnRnL3Z6akVvRUpEVjRkVWtWaDBzSHQzMC9YWG1wczlX?=
 =?utf-8?B?ZDBnbzU1UjFFZ0JDSC9RbzRMNXpRNUVwdkxvb05oM0phN3oxeC9yWmMxNzZh?=
 =?utf-8?B?aU9XbTRTVmFVUXc2cU1kL0JOUGxIOVpQTis1SWVJcy9VOUtVazY1RHpIazBu?=
 =?utf-8?B?NnFkd2p0bkU5WWcya012OGszalp4Zmx3SmhqV3Nva0I4TW9GSlhjcnlCR1FZ?=
 =?utf-8?B?Z2JPUm5wL0xLMU83WWx6VXZQLzl2TlQ1UTRZeUtNNlVCb28zaW5CZDBnZ2hv?=
 =?utf-8?B?dzIrZWFDclNZUFliUFlRbkhvTklCY002WjhGV3JHaHZDR1lBOEo1VEEycXV0?=
 =?utf-8?B?MnVQejNNbnlZQnpHUnpVY2ZxL0JFRGY2RDV4REk0dVQyQ2RFNGRXTjhVU2Q5?=
 =?utf-8?B?ckJDZW91aGM4UlN5WTdYNW5yNGh0NEcveGdkU3NLOGFmZVlxRzhvSGd4V3J4?=
 =?utf-8?B?RDd5VkdxV1BvMnhyTGtPZDJSbEZhM0xBSHhiYlpZYlJqTGZSZzcwZW1PUTRs?=
 =?utf-8?B?MDB3L0FrcElBRXQ0cTJFSFp2cjZlbGFoVUZaVDBMVTZlWG1jMGRNb3hKWXBo?=
 =?utf-8?B?UTZoU0hyRHZDTUZDUmRieFB6ck05L0dVWUdlN010QktIMXBVTkpSZTI2bW15?=
 =?utf-8?B?OFFiSlM5UXJNelk2ay95Wng4WUs3U004SzgvZDJDcENZZmJ2aUN5NkI2bG9h?=
 =?utf-8?B?THU2M210aTFhZWFFOWNSdFJnQVY0RUd4WGdUMTFjOUdaR3I3bGo1bHRlUU5S?=
 =?utf-8?B?ZE1lRFR2NHVRRFQrT2hrNDR1V1Y2ZnRndVFPNGxsVUJYMFpJTmtoMFZ1UGMr?=
 =?utf-8?B?UGQ4STRjdDhyTWlWUUhiU0llQmRwNTlMZ1FNK052eFJSYVk4Q3lOUmFyaW5H?=
 =?utf-8?B?NmozR0dBN1hiUW1zVDI0bkFKQXNJWVVMdC9EOXVzRFIvaDBFZkNkczZsWmFs?=
 =?utf-8?Q?VB7tOfv+XpocQw8c=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d250fedb-4ebf-438e-4fa2-08df1e4e6bd5
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:23:47.6623 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qky6wQvDGweBSkuQwDZagsvHaJKTD/kwFtPCPjVl0DnnKAXYQp1sOZ6hCltrLl5kKjGq8xKjA7tRtHGpa2eA4ZaC6NVqTUpTTuSg9CBKa7s=
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


