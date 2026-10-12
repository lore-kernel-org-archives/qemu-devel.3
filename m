Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 244DCCA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGDHw-000052-Kc; Mon, 12 Oct 2026 06:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDHK-0007iF-Pg
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:29:12 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDHH-0005Eh-Ct
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:29:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xkC6aaAr2GvwL+chpC90wJhEMtkh3YiMT0O4uNVONWSKSLMtVIhhTeSl0teyTHDssEm2KoZnzwNRT+qNHH3cpgavbCo7CUHDJ+mENXfw3DJKLfvOq636OtIIztmbN67zBxqCBleBP2Ch4wRcLnX2t9KP6cqCFUcQlCm77Zd00AGdEEnXBiMlUj5p5SbIxWjk8ylipo8jyM7MLKAjOfsuMSmyRaoPh9DsDpuDhfyuf3LyrckQFOAA4QaS16RB7aIidpEaj+LCImkc/Rf2PKbDe7rQJZCQQn8MH7+j8JRB/r7IqyfCv7UOaP7i0veH2QnWVUxfgHmlDlUfTzmoYPvTaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqFyiBMw7BGy2xf/Bhra5i6q6k7Q2873lM6tyUGhHq8=;
 b=hNoF/FdGAAKwux1zQboKUr2JzjbHS/lCfabZQ4eRf/r58OxD3Q+AqP142HboTxeunSpKtgWC0JVtM8fki1VqiSk+mVuEeba35V5xQev9+GZ7FyqHzoHHtWs/2vWIXW3ZgBAYT7XYPt3qvpBSCDvsLK+7Jg7t9xcEULRp95xS4Pql2Ll6vhvM2axB3q245jqt+o6FrhMUdJz6PU3rKes7KzUoOs5L1HeobnBEZgesZTpRRojAO7sHOC/vSLrAUY/S/+biC+pg4rXA2dAcWwhHJcudUJNw08PzvlxkdnDSYiw6XMQ4lNhQ498y6QAAuAIJOMvsrwy0NUsSuHefNAGoXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqFyiBMw7BGy2xf/Bhra5i6q6k7Q2873lM6tyUGhHq8=;
 b=okRfRUvWSxf/nIE9o5e+fBMwoGPJ3OSHLTeNA3f285B0fWMAeajAnKJMtRzjVwvy1TTg4AZ5VIGTlLpFj/Alv3usYCF15CaznHUFwFObGFZBz3pJ7NMIl0AE0glX7iv1DzUAE/bf/r6X9DmEA7rYJ2L1Yj3a0zfDggG1diXY/UiJG+SUr/4X8d1ZQbW063d04z4x8A9yl1wViRfGLuIptFxNQdYQx2aQHvGUTVPYiYnWAjxrP3E88JavMJ848LXrMaNbPLsAA5NgzFNLuNOVNWtxvcmUcKDqjoKkD2upTQAOs6SNHtxwKVgmUqkz3hGqHPyTJ7aR9KJus8e3EMbXHg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM0PR08MB5523.eurprd08.prod.outlook.com
 (2603:10a6:208:17f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.11; Mon, 12 Oct
 2026 10:28:44 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0522.008; Mon, 12 Oct 2026
 10:28:44 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 12 Oct 2026 13:28:24 +0300
Subject: [PATCH v16 16/22] migration: add MIG_EVENT_INCOMING_FAILED
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-up-vsock-vhost-v5-v16-16-36c38bd15ffc@virtuozzo.com>
References: <20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com>
In-Reply-To: <20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, bchaney@akamai.com, mst@redhat.com, 
 maciej.szmigiero@oracle.com, sgarzare@redhat.com, mark.kanda@oracle.com, 
 vsementsov@yandex-team.ru, clg@redhat.com, den@openvz.org, 
 dongli.zhang@oracle.com, farosas@suse.de, andrey.drobyshev@virtuozzo.com, 
 peterx@redhat.com, dwmw2@infradead.org, philmd@oss.qualcomm.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR03CA0043.eurprd03.prod.outlook.com
 (2603:10a6:803:50::14) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM0PR08MB5523:EE_
X-MS-Office365-Filtering-Correlation-Id: 29f43359-b5cf-46b9-5ec7-08df284b97c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|23010399003|366016|6133799003|10067099003|22082099003|18002099003|261009223027099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: AUXAScLG2FPerr4HCfnERxX9I+u//DPdTQ+fJzHK5g6s8p3sxDoQIEIH8XZ90Mq+QbJET7bi4DAgAOVrQAU1/Bqh6jhUmW7lTeUkqJjXm4OrzwncUN8U8etVLb7rRm5DZFl1BPnBm0wc6P82dwUyZ1QF8fFhvKLNJRO+5g/tYCvOhkB5G387Twz9gnSFmqB45MLvKfcdEYddH1ajQuucS5wphIxD488NeL3Q4dLPK5CB+bnxuU3jqwEHtK6wPDE4o5DuWwmHKYlHrUB35P3X+awQhLVMmy3LlxPTifw67HEu2TQhKoATqEk34NK82ZCBxw7npx2s8wHqOFdIusCBKciFMU9rJ98ifBT0ckp8he2E1pSe7DlV5Ki7p4YKosXwC9llX1DEDCHe7MYcygySKiekbidB+4BejNKNR0GDJfDuV+HEthlZHDlKymx/rQ70uMaMCHrIUxgYpmR5xr71e5E1+YuYhWOAbQQdW4td+fnUsyIHhqFBr+QNYsOc/IuDq1LF/dNPRcNUJeDlBNAKTuIDmD39mV0/520/QZWw0IsYqympykSXwvrLVWwXWk3DOLSzrtXsSJsBXolFwmZuImwF9l/rHwmti5B+HWnl3SQZ2uKwrnHFwXpZFsCv4krYRQBh6PzG6pMcbiPa+Z4246PqcwIvW7wlF1TeesU+72lqdTyiaJbuyTnU+nMRFJaKcj5GwbtxmBWy7Vys7fCWUtQIjCTTHNi/+Vq3gLEPDLQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(22082099003)(18002099003)(261009223027099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGw4NUVWdi9VQm1VQ3R2RDdwTklBZm5yZEE3a3J4YnVQNnBQLzNOTEdYZWtm?=
 =?utf-8?B?Rm1KcHhFOUFJc2RlZTkvV2NMNFJaL2pjcWtnSXlTZ25HMDJGUlJCcDN3Y1B2?=
 =?utf-8?B?V3lGSFNNZlpwNFBMRExjRGdBYmtvcFRUYXNDUkRQbitPY0p2VmJIcTNQVFM3?=
 =?utf-8?B?QWxtazRGQ2JXMU5ING9qdWZZbFZ5aWFHMEhQeXBYVWVQdUIxcmF1VGJnTERS?=
 =?utf-8?B?MTE1Q1UzQ1hDd3VFSndtbFFlMDdEdlBOcktrcUVNUXYyeVFrTFFwT0ZRbHVB?=
 =?utf-8?B?VjIwbWFCZFh0WFpOb0YxMEJUU29HUm5kUDhIZWN5MmpIWVBNYlBIczNMKzFo?=
 =?utf-8?B?L1VlRHhYVk40THJRckdsOHV1cXQ0Q1pRTE5VaXg2bDN1eU5oQ3p2YnI0dE1B?=
 =?utf-8?B?bEhEUFdZMG5qMXhGeUdTcVNWVzVXOEpQRlhPQmwzWUVGQTdabkNmMFBvcktv?=
 =?utf-8?B?OVJjQm5YaGovVXR5OEdYYWJXUXoxV2tvRkh2b0J4alVwYW5sRU82TC9venhF?=
 =?utf-8?B?Ni8wUGdaSjBPd2NEWmNVY0FQRUlIdi92UFQ1azBnRTV5ekxrOVZlMEIxK2tu?=
 =?utf-8?B?dEhDRk12UmNnT0k0VlJMM0pDT1VjYVlpTkxDaThJeGp2cmRnc0FZeTRmL1Vq?=
 =?utf-8?B?OXZMaWovVHdFTzdBUlc1THZFampyZ0lFVmtvbm9GZ0p1Skh3YnVsL3pJK3Nj?=
 =?utf-8?B?M0hzQzQxVWNucEpEb3FjOWNiRzlUa1k5eURIelVNczBIUTV3RExDZy9IMmFS?=
 =?utf-8?B?YzJXRDVOY1owM1ROTEcrMkZCc3NoNVFsWm5hRGFNV1NTVnoyTGJTVk9WTFdy?=
 =?utf-8?B?N0w4WXRiT3JDN0o1SG81SW5kK0Q5US9YSzJ5TzVaanUyV053MW5aMGpweWV6?=
 =?utf-8?B?MW53YTRjaTJhdFN4RVl3N2VDTUZyeFhMT1NIT2Z3TTlyaUcwbGxlZDRmR1FY?=
 =?utf-8?B?dEhuY3F4eHJyVDJYYnRrN3U5OVVNMGlhNHlIM1JUak5aTm43Q0I2TFgwek9E?=
 =?utf-8?B?clZSRVAyb0dNWktuYmRxaHRRZTUzZTZMUGswMkVtR0N2ZjZzTDhqbHhBbnBD?=
 =?utf-8?B?MjZMRGtybEk3ZEJCNnYxOXNpMTNUOHhSdGw2N1FOanlFY0xQTUJSVWpLZmFv?=
 =?utf-8?B?OTNzSHR4SDhyN1RVdXNSUFQ3bEJqWml1QmU2L2hEM2R2T1dSOXFDOGVxT2pw?=
 =?utf-8?B?SE1mMlBHQVZ4djROb1VQQjZIVDV3N1YyR2NGMVNQYXA5c0xmNG9UalgvdjZU?=
 =?utf-8?B?SmNlUzZ4L3dVNjFrMmtsU2d2SEM3cC90dkRlbklzTTJSNFZ2R2U1MlZqazh1?=
 =?utf-8?B?enhxc2hkN3phOUhyRWpTemZwMFYxdjJzSnFOZFFxZkI3VTlNQzJIVG8yd0Ra?=
 =?utf-8?B?bG15UE1vU0hMSk9yTWluQ2s4bEhzemlWaVM1NDJnTW5UVTNyOE9sRGFWL3Fw?=
 =?utf-8?B?UmFOK2RTNDBoSjA2WXR6bWJhaFJlNUtQaUZRTUV0ZXlUR0UwQWgrcm1NanNU?=
 =?utf-8?B?cTFpWFpGRGhVejh3UW1XMlVCWUgwUjFjdk9KR0dQYjZENGdiZ0NrMFJqZSsx?=
 =?utf-8?B?TjdRNkE1NjVnR2RzNmJkVnVQbzRoMzJvbXFxTDUwbno3cmRPNVZjaG5ZZkpL?=
 =?utf-8?B?UWg1QjhoOW0wK1hrQWh5UzJZVkkyMWw3SlR5aHpGL05kT1lZa0UxRWZidVBK?=
 =?utf-8?B?czl1UjF5Lyt0OXBxNFdDLzB6cGlyRUhYZStvUWorVmJBVS9sd1ZGWjJGamwx?=
 =?utf-8?B?M2JMVkhOaGFkc2RhT2tIRUlsdHFXRjRxNE81eitMcTg2aUN1ZzhXSzlESjdS?=
 =?utf-8?B?bFVud2wwY3YxWTQ5VUFxby9iTFNyd3hDMDBINkdsTXJUVUhnMG1DUUFPMm5F?=
 =?utf-8?B?OEhJVnFaZkF2TFNKQTMvY0lNeThpZW1wVmNDL3doN29RQjI2VW8zOXNmTVBS?=
 =?utf-8?B?ejdYK2o3M0tJczlEMHBxWHlZQXdGRGFPS2VKdW94UTV1QU9GNHlBZUJZZWpH?=
 =?utf-8?B?L0FTR2xuWS90citlbnFqejh3MG9WSDhYSk82QWp1NTY2WXR3b1ZuVGpPbFlm?=
 =?utf-8?B?TmhCY3RlbE13ZlFINGR4WWh6NDg2TzQzelRxWXFWMHRCVkltQ0VvSTdEelV0?=
 =?utf-8?B?QzMzSjhzN0dadEtFaW9mZFhkSEFVbGdzYU9pSGxyOU5kcGVaMjVWNHgycngr?=
 =?utf-8?B?VVVtbWlaTmRwckFubG9KUUdHRTF6NVIyZjhQYUlCUm1RbzhHSDdtZEZydHRy?=
 =?utf-8?B?ZlFUY3pSWFJFNm1tQ0Y1YjVkK0RpM3dpU3dWTUFUMCs0YWlPQXMzdDNnK2hl?=
 =?utf-8?B?cko5WEc2Z1pvYkRRV3RNK3Y3OHpsMmFmbEVnM2h6RHNZbEpZQkV5bytiamdS?=
 =?utf-8?Q?JYIb/CN0I5mIlDTM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f43359-b5cf-46b9-5ec7-08df284b97c0
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 10:28:44.5969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5tF1QRcK5xbRQup7RDzjL8V6lmllxzgy2+in6yHfGMyE1hoqzZK3Yo7neR7Q05JtOStdKsGhy+ztBGzZldVfO+cgz3L2Q+QyUrm7mISQL2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5523
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
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

A device may take over a resource from the source in post_load(), e.g.
vhost-vsock acquires the device ownership on a CPR target.  If the
incoming migration fails afterwards, there's currently no way for the
device to give that resource back before the failure is published, i.e.
before the source is told about it over the return path and resumes, or
the management sees the MIGRATION event on the target and resumes the
source, or the target exits.

Add a migration event for that, sent to the migration notifiers from
the failure path of process_incoming_migration_co() before the failure
is published.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 include/migration/misc.h |  5 +++++
 migration/migration.c    | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 019717f4cda..86cc7eefd66 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -65,12 +65,17 @@ bool migration_thread_is_self(void);
  *    - MIG_EVENT_SETUP [-> MIG_EVENT_POSTCOPY_START] -> MIG_EVENT_DONE
  *    - MIG_EVENT_SETUP [-> MIG_EVENT_POSTCOPY_START] -> MIG_EVENT_FAILED
  *    - MIG_EVENT_FAILED
+ *
+ * MIG_EVENT_INCOMING_FAILED is currently the only event sent on the
+ * incoming side, when the incoming migration fails and before the failure
+ * is published.
  */
 typedef enum MigrationEventType {
     MIG_EVENT_SETUP,
     MIG_EVENT_POSTCOPY_START,
     MIG_EVENT_DONE,
     MIG_EVENT_FAILED,
+    MIG_EVENT_INCOMING_FAILED,
     MIG_EVENT_MAX
 } MigrationEventType;
 
diff --git a/migration/migration.c b/migration/migration.c
index fab7949fe11..82a8a252289 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -815,6 +815,16 @@ process_incoming_migration_co(void *opaque)
     goto out;
 
 fail:
+    /*
+     * Allow the devices which have registered their callbacks for
+     * migration target failure to undo the changes they may have
+     * done in post_load().
+     *
+     * Do that before the failure is published in any way: the MIGRATION
+     * event emitted by migrate_set_state() below, the return path (if
+     * present) in migration_incoming_state_destroy(), or the exit().
+     */
+    migration_call_notifiers(MIG_EVENT_INCOMING_FAILED, NULL);
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                       MIGRATION_STATUS_FAILED);
     migrate_error_propagate(s, local_err);

-- 
2.47.1


