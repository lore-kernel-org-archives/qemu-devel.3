Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6002CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:44:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENwb-0004cS-EG; Wed, 07 Oct 2026 05:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENCL-0001MW-40
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:32 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENCJ-0006kK-7P
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srkjeDi06v7kqGl7ArRda0OWQ5N5Q3PtYp0e/ebuW55lYWfhfeC+z7H3VDOcWpFwIZgMR1V+uc2s5GK4qpt6O4Y2vNuAMeVfJDal9cGNjUTVh0tWIuNbIyvUZfPY/VaMN5q5gJetgLtlIdoqcxjYTAmjgrt41FJV7C978mHe4KOSOrPuT/S+y4m2s9M6WlM4Pg99hHocxB6XqPoqasjYoJnTltt0l/wEb1Gi7kfKAOtDS3wk/wFDvrXHjYMo68Hbc8hp6DdNAkUfhYPLQqlvvXZymVka1GWj7LpdmVjeVuErwuPBasAQvZJSQkQFynl5ZboZExZ3ob7hcWLJLwqlIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFT3LiMQn8S1inTR3/7yiapL1srtQ+psgaRlzFZKuug=;
 b=A9mA/gr2hWGmK1hiiYisSL6nuXbStpCaPj/h3paMBfIjdx+HdHqottwyzRxfFhi4RGO5eiqZSrtmCG9hdx1u6464hXrxsGAr3Amdwop4w6aGumaPbxu57iQfRfsr2JDBppHbgOsIKRfFNndE/L5QaG9uZl2KuV2NKKZybyUipptJQBDt/QwER0S2KT7R+xtFO2ypRIrvMWMEnaIa6ygWnjb6xRGtxLe1RH8lXwOtBpELrvcfqjOLQnYBg0zkF/cMMBTMsQE3WEfW3duccVTBbW/cAPA3vm6tQsz+aaC5GaP+6rIpewJettUqmK2nXW2k9+D8dCLVI9Fz3+L3zPrxVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFT3LiMQn8S1inTR3/7yiapL1srtQ+psgaRlzFZKuug=;
 b=flIFEXvA4z2G2MaSyZHKUJMa3I0o3tZ99/QVebPNOyqvC5VGSCZTNLUfErsL4agKat78NTXD95pWKt9ZzmXnYw7cG8ceqJvjTfo0LjVusw/0n/4mpLQ7fx6o741x2EFyKG6vwDWuerO1WhpS48HeHNh9k8z4E0c4WXhvOhKj/b6NxBGCe5Lk1h9GW1pjKs9xsRw2qo4MTmYPEJkx2u24j3HEi7cz0rCMQfN2i2GIi3RWFUTrXmw6HZbLe2wlboFwmYj0CU0gz71qnc5fsmotltqhpRJ3gD1XZQCyPXxPf5Rxq24pL3bJRwyXSE+ta+lSsGUbuH9T0+3OUTZH25koVg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB3PR08MB9058.eurprd08.prod.outlook.com
 (2603:10a6:10:430::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 08:40:08 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 08:40:08 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Wed, 07 Oct 2026 11:40:09 +0300
Subject: [PATCH v14 16/22] migration: add MIG_EVENT_INCOMING_FAILED
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-up-vsock-vhost-v5-v14-16-e16de9962df0@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB3PR08MB9058:EE_
X-MS-Office365-Filtering-Correlation-Id: 61a93ece-0119-44b9-df09-08df244e97e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|23010399003|366016|1800799024|10067099003|56012099006|6133799003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: eP5wR/kUGZDlGsjC7X5X6ulv9Dj+2ysoWr7cu1WqO+4OrO+05os07mIeaO4d6O7QKmGyFT/s92gALIQ4gbcfObnKXTH3Fkx6JchZHr43aYASCB6wno+SwJHUU/hqQ4lI4WS2w/p0RWfOF33T/2nGba/mJINNTGqvjdUwtv8MRPqGRW4nd8Ej87341TX7U+aBEgnXc8hI1IGs1vOf/i9s4eInZeugNsZ1IqsLRIEvo/seN1QaITF4xs2CWZjsLm6qT4gClUGSfAZmas6PjPvpRkYdtQvpEWePVk1gRwFLoiGky5F95tvNHuxZOCb4qEZo842+lcfRcU+MQiWjln4uKdL80wdDyzqKrPqJoxQLAHo7hiCv0sol4oQ9HXSQlBDPH27l3ZNjkPyrY6HDx1NlZHyZkYFMO8wssf3AOratFEwdlZsMnYwDJ1ZwMqATOHpp/qVN3RQV35PMeHjGQKc2PXCAYXkJwedTURY2qblFo/AeiaaxO/udvCPBfybHDqMvzjbk7qS61vSuPuc/6/Rwv6bIWk2la2Lyi7EHpqS1x5PgrTPqgjIHRsIf6xs3m+pQ0vLE7oAbtUMiXk3P+Cdf6G5McLKDa7cNMzEZi566YpdQxkUvq/H9jxvXknTK9lHm+l/fVTgzn7Wk47TQbNm0zhxLv1cnOlYGo1smXp8Da2dQA0AweabalWwMIADRUBZ73tBVm9/XPY2X13zosZc5GsMDR0vlS0vGZzCZHr5EySg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVVWL0pHcnpMdDFkR3VPQ1JCWlIzMlZsR0daMkRKSjRCTlhmd2RBdXhXOC9H?=
 =?utf-8?B?VkNIU3NiQWY0V2xpa0w0NGpXTmVxMjg4MmVvdUFWazU2b3JidGw1elF3Z0Y2?=
 =?utf-8?B?d2hNRG9CVHJFQXN0bVlGQTJ6U3RWdnVwNlBDaWZVeFpuMzZ1cWhjSytQZ20w?=
 =?utf-8?B?WWYxZmF5ejhKenV6dzdTamx1MGdUN1ZxeUN4Si81OENBcERuWnRZR1gxYTBO?=
 =?utf-8?B?M2pHRW1MN2ZTb0lOZmNLK1V4NkE0Q0dXTkp3dnZITzRnaE4xY2YxQSsxS3lI?=
 =?utf-8?B?YXNQcG5Va3lXSjIxY1RxcEI1MnlVSU5QSjJkMWlVcGpXVHkwSUZyamdqdmdW?=
 =?utf-8?B?cHA3RlJmU1hYcWZzMlk2MERDTVZsbFpubkRiUysxM2lmckV4U3NSWWw2RGor?=
 =?utf-8?B?WlRHMkNRMEo5SUZuV0ZMMEZVemVDZ3JaZXp0OStYN3VFSkMxTFl1WjlLWE1D?=
 =?utf-8?B?bEJmdEdYRWJRSERJQjZmYWs3NHhlbk9jaFAxRk93V2tlWlRDOWFtQ3dtL2xC?=
 =?utf-8?B?RCtLVlRVZm1sYkZjNlFiZ2s0eUkrV3hGUVZRdGxOdFcweXNrTVpmZWRrdnk3?=
 =?utf-8?B?Sjd5MGlKc2tTekFZcDNHbDE0bmRvaVFtVHkzclZLRjZMNmVHSnNYWXVvNVhD?=
 =?utf-8?B?NnNxR3NQTVU4cFBZUEo2c3VicUlYNGNHWUQ4N28zc3lMYUYzWERtYVozWnRp?=
 =?utf-8?B?L1VUTGU5OTJCSjh4Z0F0L2tjM3p2LzNVTmRkdEVuOWNRSmdBaklUTDZxbHlP?=
 =?utf-8?B?azNwcU12bWZrZDJDV2l6aHI4YTBHRjV1dFR1QWdTRkUyTjkxZzdUdXBHVVpp?=
 =?utf-8?B?SXJnUVltcyt4N1JFNDdNeE8rbldISVUwQkw5ME82cTBXMDg5ejdlNkwxN3pR?=
 =?utf-8?B?R1N6Sit4bU5GZk13aE1BUHVlTkorUDVDMHd3ZVlSckVIaGwxRnpmSVlHRHRt?=
 =?utf-8?B?bDB2UWh2SWRqV2licWg4anRZMm8venJqSVJ0MkVSSnh1NnoyaWZMcWkwTzlT?=
 =?utf-8?B?WWlHc1h2VWFXa3piVGJOVlBneXFtc1NsQW94TDlYQVFDdHVZd28veVVxa01D?=
 =?utf-8?B?ZzBCWVZtditVZksyRjBYbHVMQ1dEaTBzd0lmRERpRlc2V29wRFhoMHJUNFFP?=
 =?utf-8?B?VVhsa0RYZmUxbVEwRFJSazV1US9WUEpSUEo0amZiUm1vVnhlci9mU0lXaGJX?=
 =?utf-8?B?YkFzZ2hHUExQMG02ZEFkRkpDaURHOGFCbURld1lmY3RFdllIRmpzVFFPNlJr?=
 =?utf-8?B?VXh1dUJVQzFiS3BhMDFMci8veWdtbUhhMTl5MStRWExSdE8xZVJnOVJOYjY3?=
 =?utf-8?B?cTc4ZXZRL1lGWklPR3RsTGc5Uy9aZGxKN1ZaK0p0Z1RpZ1pGZkY2L3d2YUN4?=
 =?utf-8?B?M2FYQTBFOXVyazJQRllhaldwOFBnK0xobks4Z3J0aVQzSzhwMlR2b3N6Rm1C?=
 =?utf-8?B?SE9reDFwb3FpMTQxUUY4TVFEOExXbysxbzZnSVd4Yk5kR0JkSjRxUFFOazk0?=
 =?utf-8?B?SEFBU3dsLzdSekZmTkphcmordlFwbUZZQ0k2aGU4cVNUZWNoU0NjbWNndGhj?=
 =?utf-8?B?QnlwV01CclRTeFphVU9kcVVLemdGK1BJb1UwdXBzYml2ZzEvamQ2RDgvQUd6?=
 =?utf-8?B?MzVIMEVyMS8yODdscTUzTmp6ZGdPYUtOcVpkTXF3R0JhcjVvQXAvUVkrYjll?=
 =?utf-8?B?M3BmVUtURGFpU2hyc1dqTXMycENyMjF5QnhNWnVkUldmTE5GbG5wVCtlazlq?=
 =?utf-8?B?a2ZJeENKZzVHTjRnVnMxNHdML1dwc094dENlSWl4L3Y3WU9zMGg1U3ZUUWpP?=
 =?utf-8?B?U0YwQUdyZ21iR1djekFFRU5EVm9Pb2JaZ3lRZDhEd3JWY0c1ek82bXd4VXdv?=
 =?utf-8?B?QWdObTkyOHQwUTNxUDRuZndtL3BnaHRZdFlhWTRjNkFzVTgwTXVKSDF0ZTlk?=
 =?utf-8?B?Q21TODdpMy8rM25yMC9jSGN3SHIwUG80SUdxUXlhb1ptMVMrN2l3U0phY0Y0?=
 =?utf-8?B?WFFuTXlRTzVUVUtZTk4ycjZ2MHErT0YyNk82TkVURC9pRjdNT2JGdC92RG1F?=
 =?utf-8?B?eHJZSGxSM2NNRStETVRPbDh6MnkyVjZEU1dqZ00wMDBCaEhvamxlNDNNM25u?=
 =?utf-8?B?MGc4Q3FTc2ZVNHl5WFdITGNRdEZSbUhhdm1zOTFQQXZDOEk4N0tTdFZYUDR4?=
 =?utf-8?B?bGUzQlZDSlB3WndpdHBMK3FqL1JJTWt5OFJWY2IyR2xCRnV0NnpYUkNYemZS?=
 =?utf-8?B?dlBYbFJ5LzVzR0loellBRUtWMDJVaHV5RmlSc0RUWmp5Vk5vL3NpU1EyY3FS?=
 =?utf-8?B?Skx5clpFRTRJWmgvOTRXQk5kbFNlb3ltWUQxZmJSb1hxbDhlbnNwQ0M2TUQz?=
 =?utf-8?Q?q4K+1U7c9cuuf4kM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a93ece-0119-44b9-df09-08df244e97e8
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 08:40:08.5659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PPNVMui46K1GDrJ5Cno6zLv3P+kJ9bhmN2DNp8y+lbpz3yDsZKfdcWGp6DXPerBsoNJ2BUKB9yaiY0Knb73HxlFcb1lUvIS0xXShABM1TUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB9058
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
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


