Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A097DCA600B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 10:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xElKK-0003K7-Sx; Thu, 08 Oct 2026 06:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElK1-0003GU-RE
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:26:00 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElK0-00015i-9s
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:25:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P04uMX4fHgmP1RwFMybiN5dRojEOTSRlr7BlMoyi2MJCQsCMD5UcWerHR8gZVvVO3QU25GptFFFNRfkC+UTj204eJ1gxAYLBkcaFmTusgGZoYoXTlCxEds1m4ym06yX4eQCFNSOkJxx3NT+gNWiih7mOqn5FZO1MIG6Gj9qRnYL+zgnIJVDvGRgaChXBuplxBm/QC9HJ3n9Ba3fFF66IONY05DEk23eUVErtP3eKMDZZNT7Gfh2XEqY0nN5UbSRCIEYsuzxAHosNBdt/9t2C+RQbDxmddcszvkZ/3HpHt3Bh/+3MKnWNC3bbb7TXOTGx8LtU85RRJGPWj835lwcUlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqFyiBMw7BGy2xf/Bhra5i6q6k7Q2873lM6tyUGhHq8=;
 b=RMECKWk6cdFMw5eAosuT8Q0fBs0kSTsfWmkuCHYLF9zrc1qtmAEO/cUHy7etgMi/EGrjPeJX3z7qTWLnHSoj5vZohL6Tro+Llsk0ciTQPUYbE8Naa+KXPGyFSaopglSbaCuxJ5SiwDMksrpbItpG5DjLK8y2hd/WIxIGIEM7k+F83/dhiz8OFbEF1vKvJZsbYIt1i+ISteGRW0H3O9DH9tDOTQwKthEfT01/ZhZ92E9llvgkhHZoUonH1ZA/jlzTxeLqnz2ougXHvGU6mg9uA4F2zl7Bphjr1VVcnRTlm+Bhzhv5uLwUDxvP1PssX1prGUHqNgc0SjBpstnGFCscAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqFyiBMw7BGy2xf/Bhra5i6q6k7Q2873lM6tyUGhHq8=;
 b=DsJUfAExlKDh7VdthnaQ6ue4cLCiTqBo3b//7ir/oxlZLtZsXPOsBAe1nZALFInlXzbwfHqDM4fnEL6Z0DiXWO7GVTM9meYDoxXUrEdiAkTDhdlwv8kPbHJIbnmzOVVyL6L8xXE+tQ4a7UM9uo95wXUi8t7XxtMn35fAct3EBtGWysEGpIq8sZegskcd6I/0LoallzwSBBLkfxcLzDA4rb+eLr/ywzZUuj8EJsPvE7QPbHhrqDLdbRBAXWeEWiAXkZF6SGA6xFOWlKx0qcpOz3mJKQ1gWG/vRpkIuBRELUv5gVkGwb2GfzUcX6RhF7F6f5bIMtpBIiI1+mA/v5MpPg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB10270.eurprd08.prod.outlook.com
 (2603:10a6:20b:637::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Thu, 8 Oct
 2026 10:25:47 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 10:25:47 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Thu, 08 Oct 2026 13:25:40 +0300
Subject: [PATCH v15 16/22] migration: add MIG_EVENT_INCOMING_FAILED
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-up-vsock-vhost-v5-v15-16-301b73b3f843@virtuozzo.com>
References: <20261008-up-vsock-vhost-v5-v15-0-301b73b3f843@virtuozzo.com>
In-Reply-To: <20261008-up-vsock-vhost-v5-v15-0-301b73b3f843@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: andrey.drobyshev@virtuozzo.com, sgarzare@redhat.com, bchaney@akamai.com, 
 den@openvz.org, farosas@suse.de, mark.kanda@oracle.com, 
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, dwmw2@infradead.org, 
 peterx@redhat.com, philmd@oss.qualcomm.com, vsementsov@yandex-team.ru, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, clg@redhat.com, mst@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR10CA0117.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::46) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB10270:EE_
X-MS-Office365-Filtering-Correlation-Id: 39bf50ce-5dc5-4143-2504-08df25268287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|7416014|52116014|10067099003|56012099006|6133799003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: nPaQL5qkXWKPo2ONsgwqa8trl/fGOqb2M6ET4Mim49+YhPpAOO+OllopTOrVKQ2l0M74Io26FHArJ/luulpV4NPXa8SRJLPYZDE/1fXhd4zdfFeX3dKt0hZeXYGrUX7ZgwV8zpXBSUdw46pF7MCL6MKb3Ynr54cXDnwelufXGkZwmJt+z1gHvaztJ/z4sr/gcNveQc1ka/XHWgzTVJsz9LXnwh9WQBD89oU5kqn8/PmBzFCNgCKPAwjyib4X7y8uwX1SKVIQdLad47x5DqePAIZoolkyqiS617o1V31jzitAaR4BPnt0XeG3KHEpNSHNJrwgmkbp3+EGWskkvsmxBFX9Fnf0VLf7MkVyBz9GB8wrXyK4qTU74kzeR1dqOR/fNRVXhfd6ronpg6vuG08WmG4JhNOs9zNq8N0zNpsETDhcFOb0UBlab0cAuVPMwefSSTDcF7NN+omQjU6ykGT/y/z3/EdCW6RnIReetJ19ePa18THt+OOtql7GPWKJ6jjhzzM/BvRxvYSJsqLOxEOOj93t60BGjZ8cBidGY09dWnTodF/Vvfx1odFE+YJilAAa/UHec2pLaAbFennVJ1PtqKAJWcSMHIT3Aikzd8GZhNwq8//vIHd/ZjAVNoIPj2cJkgZ/3//EEOqLXJ/RGMmGuBgJzOiQbXCbaGX4je2uFjwbqv3UYKPs/4wIsI1WqVO2XtaroSsr08DVL7zzACpcrxZ/pU0p3qaPQWX0KjLfrQQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(52116014)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHVwOUxodU9BWHRsam9sdzdPQlljUEtpMUtuSWVuWmlGcjBvbzgwUXF0eTFL?=
 =?utf-8?B?VmdGS0Z0ZzZickRqYzlJeW13OGdNOG9DenNqNHg1dEVldExBdk9JbWNMNjl3?=
 =?utf-8?B?aFVBbmRteFVnQ3l1UTIzZFpYbVBaYkRxM2FrSkR6Qk4zWnhiYy9rM2dRbS9F?=
 =?utf-8?B?ODYvZ1RvYkRpMm1GeGxCTkx5NkYweWdtNHErTGhYbER5NlMxZ1V4VkFWallS?=
 =?utf-8?B?Ry9mSkQ2U243TVhLZlZtZk1MSDRLeTc2Rm1uL3BDQXNuK0tGa1NTTlhvN014?=
 =?utf-8?B?SmplcjF4K2VpY1V1eHdybmNVZzduaXgzeEw5NkNldFprWmU1VlozSGNCM1p4?=
 =?utf-8?B?TC9FRldGeFhPb2JQWnk5NTZWZUsrL1hKb1NnMis4YWhHY1RXcHI5ZWFvQWI5?=
 =?utf-8?B?NnpPWi84REdMR1NKRVdpNHhmSThxcUpCdXF4Y2V6VVR1cVhwU2xERy9hS09l?=
 =?utf-8?B?S0VXcnlrWUZHMU5qR25Kd29qZTVzUitpZG02KzNMcWlwRENpTVo1eDZ4cDV5?=
 =?utf-8?B?SElZR01pazYxMUxzNnV2Ui9RYnNFU3dETHJDejluTE1SNG5uK3ZicU5vL3cr?=
 =?utf-8?B?UlM4ckgrV1ZqTmxIRzlZZXhLMjdnQUdiMDNUbFBVV1QyNHQvRldaL0JId29L?=
 =?utf-8?B?RndHUE1uSDlVcEJ4SnNvTmV0dkZWY29yU1BFbGIyUEhDYUJtWUF2bVcxcHRu?=
 =?utf-8?B?b0drYzkrdnRsdE1jYlAyMm4yYUVrQzFuR0FJTHltQnl6V2RkMlZVakJLR3Jt?=
 =?utf-8?B?Q2JFNHhxeTRqWEh5UEFzaGZsSHc5WlJiMlZISkFXTWZGMTQrUDVCSlM5Tjhi?=
 =?utf-8?B?dFJrdEhJZVIyem5uY3lJSkxWa2kxakFZOWhWVE1hUHp5bVA2Y2ZkSEZSc3Mx?=
 =?utf-8?B?cy9EV1RDSW1PR3JENGhkcExQOFZUdW1NaGZxRVZDTGNRcW1PeHVRVjRwUlpH?=
 =?utf-8?B?Sks2RndYbWltaTUwL0V3UDZLTCsva3YyV2szN1paMit1azkvMDNhaUNrU3pk?=
 =?utf-8?B?cUZsMlVvR2I2cmhheVR0bEhTdjBodTI2WUNVVHFtVVRxZ0FQYkZ2ZERFRzRW?=
 =?utf-8?B?SDJLZUdkVU1VdlUzOFZzQVdpWVBad3VGNWpHUVJGQ2JOVk9TM0Q4TnBDc3dY?=
 =?utf-8?B?WnNYbktYS2RqVVdYSDgxdUd1VmlYUW5pR1BLNWNHT2gzUVI4WWpkK25JVjBK?=
 =?utf-8?B?eGMvVStmV0hqZnE3YnFKbmVnUVRNZjZRbVExTFVPS1VOUllpUUxOY1F0UHhn?=
 =?utf-8?B?VXFmR1g2WHU2Vm1CeTVqRktRSVpSTCt1eWhJU3ZYSklUZHpOVGE5OEU5Q3VI?=
 =?utf-8?B?amVEZUdoemFVYWNKcjRhQmZaeFd1UWdUOGIvL1RLSWpjWDhsY0tRWHRTWHRV?=
 =?utf-8?B?TW9ja2l5MGluVHVZZzR3ZS83VG5xcnVUbGpZY1dPeUh0UlZSd2pvZC9mU240?=
 =?utf-8?B?bnJPdUZHWWIwWk5rTGhmVC9Bd3NZemtZb2tzakpIbHV1T0gxa3cxMCtjVGxX?=
 =?utf-8?B?ZjZRL3lpamlTVS8vTURLZ2FpeGVRdjhtdWwxMDJ0dHc1aUZDK0VsbVd1YStR?=
 =?utf-8?B?VEI4TVovblNwNHFnc2VINXo2Q2tadGYxNWJqelNFQTh5VS9Ldkp6SWNKVC9R?=
 =?utf-8?B?OGhtNjFHQVJIejFPNnNOeHN4M0VOaFpacWltRzhhdm1VWTRWbzFyV29NVU92?=
 =?utf-8?B?dGd6eGRPMWVpbXZRZ25qNWVoMlY0NWh2ekVxT1g2d0pyV1FENHF5R3VVdzVx?=
 =?utf-8?B?REVTWG5pTElYU0g2T1BmZ2Q4WEpST1hvK3M5THNmL1JuWm1LYk9NTjZ0VUZp?=
 =?utf-8?B?L3lHQmpLSEVpZUxHQTBYZjNPTlp2SktxdzQwMVkwZ0dLQW5lVkJ3LzYzQXVJ?=
 =?utf-8?B?Z0Q2R0hLSHpydWN4OEF4Vy9lU1B4RkQyYlFOaGpMekVRVTF3WExmVTNwek9x?=
 =?utf-8?B?QVlTbU5obnVkenlGc2lpUVRqWERUeHNMVjd1UWdLN0dEY2JiMjducDgycVRj?=
 =?utf-8?B?bGx2VmRBU0RGTUVnTTBmRG5qbW5iL0FFcEV2KzlQZ1o0Z1RucFJKV2VMTCtn?=
 =?utf-8?B?LzRtV0FrSlhhTks1U3RpZnFnTkR4N2ZJOUVuenhKbU5waktRVFJlOGtRVUQy?=
 =?utf-8?B?eC9Od2RobGUxWjFWNGF2Y2pDbFErN3ExK1lFcjU4ampTbkVwTnFMZmY2Kzk0?=
 =?utf-8?B?N3Jic1lQQk9IOEVQelVQK2RPWHRZNFYxVE1JbkUyVEQydXJmM2FQSlo5RmtP?=
 =?utf-8?B?UHBrdjdoRGJYQk5RSVlrSzVOUGQ1MDFkVUJmZTNvMlNWMkY3QnBMRm5ydkox?=
 =?utf-8?B?UHdjV0V6VnErcFJnUUZPRHBjQ1BRell5ZmQzdzJNalhXamhSV1ZLdzBrK0x5?=
 =?utf-8?Q?wvFWGHFEjStmnHeM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39bf50ce-5dc5-4143-2504-08df25268287
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 10:25:44.2144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9RhBt/QqBD7hXrPhVXydfodz3Cywopmicr07JYXXFVi1cPmtneg/nsnleSBG+oyeNKGT7SlfSfwbbGcPm2+XLLXZO8VHiJLlgeD/ET/HbAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10270
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


