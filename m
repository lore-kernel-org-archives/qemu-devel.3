Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6E3CA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 13:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCcui-0000z5-L9; Fri, 02 Oct 2026 09:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCcuE-0000oW-SM
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:02:33 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCcuC-0007Qg-VK
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:02:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWrXtpZb4RUJl9H1SN7W6kPnohIEZGlgKhc/DR4WSCt8awsVPULya8L3k+CI9//wP7aWhIjEYF+35ueEqkZa7pGuCTv+i1ltHgUWYrAyIpu4b+xePj3lGCbWG18S/J6/3ahnwczNafGDOQJM3bB2ApAKOMna/Gh0vVQDc9D48w9H4FhOfyWt8LGCaRq8qMCE9dZQRUy9abMNf2tsWi70b/pksycajLmcoo1GpbO/IQKv5FaKQ7nTAZBHDH1OQfn3fyEQOJNi6/QxPEOmeqcmHScjtZ4de1N1dLdmsPdllwlCIrwXR8/S6M40h5nB701GRYHed4Yu8NzJdsu/ZUrdHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXgQR79hkZDDfXuHJA0otbnU8q3wx4xJTCQyzRPPke0=;
 b=HTr36V0dInFYxt1jYUWbuT5wtHDa0dT6mldo1qozMmBjmsGovhwaR0ZT1H5PhO0Gkb7qz5TL/hg9wb9tNqh+VTLOe+istVi4iVAEh7IkT4AQnRyhPKat9rHT9TTGuXhpJntfgF4zxZGedQGNooUSpL3mSmsDk5uSQmABXMBRyKx1t2Ct2jdKTICw4eD0fZItvR3Bo/ENdLI7hODSW9E29iz23kivbbl3XXQ6+Ps1aw8Ah4ghjd0RmdwHiGUtNUAgmtsVilUu4iTQRvvaaWS1DiL0Sd6J1J45FrkrH5dMCIPUyi99kLFQxjfXp8TobGUhkCQAmGvKEgr1NUMKGCSUnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXgQR79hkZDDfXuHJA0otbnU8q3wx4xJTCQyzRPPke0=;
 b=peZ2l/V7jRRaqSNajzH8TmR71xiKbfcxe3+cWn5flUDQ2h55qjBKKMrayW0FEBOyEWbwxecXobwip+ncT5hMwRWaNNR8fC6CrjYd2/Mnt5NHvrciioPCD/2fb9V3SvXKyKu5td+Pgk8mB3ZLIlNNrfgmPdU7DzlcEtBTlLs2+/uEq2y8llrAQ0yOcHWYD1cN/ao8jYv3QXEeerWRor3eaWAr5c9ndmMscOckbeSv0wmrZSvJpFonalkiIoYNfiIjugVWdyQ/qHJhu7X1U7r7vrdBFKQWYBMxlwaSLGTeyY+csUhbpPWoR4/ryfyH1HJuEz/ELrX/cb/vZobsBskyyw==
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
Date: Fri, 02 Oct 2026 16:02:12 +0300
Subject: [PATCH v11 03/19] migration: forbid snapshots in CPR migration modes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-up-vsock-vhost-v5-v11-3-18fa09d8273d@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9c376d15-3ebd-4f44-55f5-08df208565ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|52116014|23010399003|366016|38350700014|10067099003|5023799004|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: pb30nUuVLN7r9hHqGcjs3MvgWq0/X85ufvjbT39T8Dp/Vm0WoL8yW0xKimq6aEZD4m8EZpXxhafqrsLgEzIRxcxl1ANQF7ad/EZHR+a606Dd5iB3Jt7cEkGyBKkVlej/bdlKKxQ03dl/5XlMO8mqrYurEDcDN5e1XZxnMPdplvqHMY9JQXSzjhEbyVgLVpYbqR2Gm0tnld0WkYELTaElkZgfwNW2+O66AhxyonShuThoq9gyiskju2YuyRoSpLqeLOzd1rwiGdClnOckfyH0L0L8EIvlAHls0aeNiHrIeotqszOhNgcvQienW0RBkSvbSZYjf+bcxOyC7sUTxGjKLsO7kfg2GbKMCa6QZKyaKQ1HaI953SXBO78uNJ7hrS/Y61jUF7PGX6WXsfXbhFIzchkg4zo9YTQha/9vgNvdIg6SUbd+pzkGCVyBdFIz9J6F3VX1pw+JapCqVNbYOqIf644e3ksesFy2LbzwKlmGF6XGEIuBBEJ3+WGgzZ7vRJ6YXrrTLrRq33mIke/ka7rjJIJL4wtAcoKdMmuAkGxywLu5oM3dRctoxdaR+F1e19Z3ZY3uddqYXJlZsY+I48YvOpKY5V3A89dmAgg55Vl//zG7GD3JwjmhADOagxJm5dsRRjldtDkoa+2cx7jTf4ksLPw/WfLWg98Wwphk8gTN2Q2JFLl3Rjiq2XKiGUJlEygCJeOmRgPviuTV9FfcucEXHH+jVu72XEUY+HLuTk8ALKU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(23010399003)(366016)(38350700014)(10067099003)(5023799004)(56012099006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2JpS0VWQWM2S2pvK1psclFvMjBEcmZTS0JwY1phZnBRMWhpT25UV29xUFZH?=
 =?utf-8?B?RGY3b2FsSDZjSzdpL3plZE5hK0IwS1FzVDhsSDhCSSt1ZWhNQXQ3MEFNYXY1?=
 =?utf-8?B?djM3bjZnVkZyUitLdUk5d1F5Q2t5MlMyS0o3TUNLQ2xLU0x6aFBLOW5TWEUw?=
 =?utf-8?B?MGpmcVRaUEUwQ1JXYXBHaTJ0eTNHTTJKY0VqVTN5ZFFSaHlFV0hvaWR0NTN4?=
 =?utf-8?B?aGpPOW9NcEVKUEhhT1ZvSVArc2NIcS9IYWdNK3Y0SFNMeWR3dXB1elhyU05E?=
 =?utf-8?B?QzN3NUpvL1cvYXRORXFkZmNGV0FJTjlCL3N3aEZ0UFV0K252ZENKR0Y2R1p6?=
 =?utf-8?B?RDA2SWExVFh3eUt1eDM3NXhGYTZFTE4zb1J5V3ByTXNIdUJzYi8xZlRHeWcr?=
 =?utf-8?B?WElSdjJuUkl3NEV6RmlpNmM2N0taNmdObUppZFRmMytLWWhKanF1czA3WVF1?=
 =?utf-8?B?VnRoczYyKzBhZG56T2lEcU9rblZEL2hMSnhnRUR1V2o1MC9aVTJnOVVHdmVt?=
 =?utf-8?B?aVZzWTRsclJrRHF6R0h2bzV3c0gySkdaS21qZWFlUTBqeXhUTHFWT3NHeUlZ?=
 =?utf-8?B?UVJFcmlmMkpiVVdramNMTSt2Nmg4UGRYSG1qU2FodDcvdWZ3bEtmSkVHR09Z?=
 =?utf-8?B?WEtOd0FrMVpuUW51WFlNNWNxM3VVVlRFaG8rZnIxNGd1V2lGUkU0Vms1WTF4?=
 =?utf-8?B?U0t6anBQbnM4TEZQMmxYeUJqTjY2Yng3ZFF1bHdramh3RWZ2UG9uMU9FckRQ?=
 =?utf-8?B?QU5WN04relY4WXo5eFFrSUxWN2pDZjZzdkZkTnpoUmwxV0VWS0JzN1huc1ZY?=
 =?utf-8?B?TnRuSy9DRlZ1NkU0eHFPazNQVjhVbUJQa1ZMUi9VZHJ4b0tUWWdpOS9LaGhL?=
 =?utf-8?B?T3BsNkRCemVQN0k3U3pkdmtOZzRCWWNVclgxRi9tbUF4ZFYzYkJUODFBU0FX?=
 =?utf-8?B?NlJpeTZoNW9RUFFLaFpzUVArUzJ1QWVkck1oQjZhdUN0NUVuYXNISDB2R1Vu?=
 =?utf-8?B?aFlpTzk2V25qVitwVHR4OS9oRllMaVJmek84TDRJTERDeDlpYnZvYThzNFNR?=
 =?utf-8?B?bUh2RTBBd2dpM0s3dDBhNVJKYlM4VDFhcExQaVRHVkxqZnhJdUFRSzBBNmls?=
 =?utf-8?B?ZnJxcHJRQjkzSWVsZHF6MXlkUm1uY3dGQ28zV1V1NkFxMmtwbE9GUVVtVHFa?=
 =?utf-8?B?ZFJIL2tEdWVFSU5ZWWgwOGltS0VEUVdYbnh2eG96Vzh4SndnaW5yT0NaTXcx?=
 =?utf-8?B?eVRCSXdVNUtuTzhYbkRPZWhvMi9WS3FFMlliamVzQko3NXp3czBoVzVhTlZ1?=
 =?utf-8?B?ajVTQ0lEUHRkS0hHVWRMeGJLVmRVSmQrbDBUYWU4L0FhNkEvUVQxR1BrUjRi?=
 =?utf-8?B?c255Q0VGMnlRTjA0b2ZuOWpvWVVDeUtuemIvVmFnazBWdEVQRkZab1J3VjE5?=
 =?utf-8?B?akp3dGp2amt2MmxUN1RoUDc2ZlNUb3pCYmp5RVJJV3pqRVE5bjhVZmM2T0Q1?=
 =?utf-8?B?M3BZTTl0enlZRHJna1Y4Yjc4TGZCaTNtQVB6QmtxZ3FrUElTR09DcWE5TUFq?=
 =?utf-8?B?bzdDUDBGOURlQWdYYVJjdi9aWGVzZ2dqeUJJRGszRVRVNGZXR1YzbnovMFRH?=
 =?utf-8?B?ZGRaYzFQNlhXNkpYTzZVV0w3ekF6WjY5eE1EcmhOT1JIdE1GM3A0dExRWUd5?=
 =?utf-8?B?QW1sSmphbEQzZnVlMW9hYUduSU9Na1JZbG4xdVNkeGVtU0pCNkc3SjNZNzNs?=
 =?utf-8?B?RlBjL3dDRElRZ2h4Yi94NWJSakdWTkVrWmxZVEo0ZkRnU0h0NlhXVnJPQTVR?=
 =?utf-8?B?VlhXRnlTbVZyNnlsQ09CRTdyVEJ4OVlnMU8xRHk3ZTF0ZEZmSEhtWHVRZXEr?=
 =?utf-8?B?SlNSRWFaZHg5Z0xsei95ZlFsS3F4ckVNemlaTkNabFQ2aW5hOS96NFVobVZG?=
 =?utf-8?B?V3diVzc2L25sU0wxUWtsd2xJOVVicDJPVkVObE5ES0VIV1dIK3hHcXBRK1JJ?=
 =?utf-8?B?Smt1Z0tKRStjT3ZNc0VLaVRyWHExTjNMREdwVCtiSjgzYmhhQk5VRzh6Mlpa?=
 =?utf-8?B?RlFxbjhSQVZ4OW85SW9LQ0lxWUt3ZUk1ZEJ4b1M5cWNqbUhLTDBldStkTXJE?=
 =?utf-8?B?Z2puWXZNZXNSV01EMXRPcWd1bmE0M0N4MHdBOGFhZzBFc0pMdGEzU0FPUExh?=
 =?utf-8?B?VVFQc3ZZQ3N0OERhUWU3dEdIYWhUakd6enFqeVFBaUYzbXN3K1d1b05OMFpG?=
 =?utf-8?B?QmpnUTV4YnhBYURuZlQ2cFAxQ0JGU2VLYWZOSTdOemI0VmpuWFhlVThBYXZx?=
 =?utf-8?B?Sy93c3l4dHhCZ3dWNFQxYzJ1ZEZZcWE3SHF5ODlybGp5WkdoQkc1dkpoSUs2?=
 =?utf-8?Q?iPyfxY5L29hA3WtY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c376d15-3ebd-4f44-55f5-08df208565ab
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 13:02:21.9788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /GY5IubP27bMVUsUBvDfZOTZAi+a427/Votwuxbu2okGNkJXrWhJl56aFHNl4FQVGX4k6Gzv/8+EGTQGziNsxFePR1Cqy1ZsprvP3y50bzI=
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


