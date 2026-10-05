Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E60CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDkCO-0008Nx-Ke; Mon, 05 Oct 2026 11:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkCD-0008JO-Kn
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:01:41 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkCB-00056n-No
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:01:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7YI3DqCirvUGeMu9BIQjnXNbJedLWoaanURfyHYdcT2J0KhWhzr/a8vsWD3E5fhaxnC44sDiGwmK+UaO2a89MTDQERizUJKuZDaNzxldaxMwqEIAAO3AdcqL2yqvD0MYrHZSHh+zRmZWG7LYijmqMibsjZ0ree5GbsbZfATezk64cKDhGr4DgNUvBeq+NBfnSh37EoSzRu0cP0yVWL96Vp6WTJ8os5gE4BPNcmwhdDFc6uGDc+p3UlpaKHFgI+b7/oygQFGvtnlf6i1tpEg0RRWQr9tkIrvvqNi6HDiyjV93mSgfMOeoBT1RVLCvdk2aii/NkKt3bsF5jn9UOQK6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPBBi612BKhqOOz8Ua0FoY9TYg1SLOPvaSNUP572pGI=;
 b=DO20bsSExHBZRS0ULg01n1bxdZOZBfDRXzJQJQkyE4I7/sdKBiAwuhvwuEtGnUFccTUmU88LXsfpVJWO0Qj0Pj9sedOyN3ImzsfEHUK49IeEI2FZVCkfAAOaPnN7YzX8Jaj6KNvSp37LCboeqfnN59MIawS1Sx62SD9Pw9obtKMgmkxLWedSa3dqfFzlSlMKvpCAaG5dpoZJt89IYRVn4OnfgvEe0bhVJ/A+s3d5U9mfgbhsg08Jfma6mEnPxuSGY/XTIUZlO/6YHTKV6cAvXl3mCTcArXdUxQ+dqM5XF7KCfqsHVPVQxds5JkypP+ALfFvXEr09vJzqYVVFjQ7Slw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPBBi612BKhqOOz8Ua0FoY9TYg1SLOPvaSNUP572pGI=;
 b=G3LJPUtnIsqzwjHQMB/8hEyGtmFuvvPkI/hXxc/iZ/4Ewr0+GoOFf7sx/7Zx9Ay0HNzabETlNgBoHEbd58SVn6nY8R0wRk8a0B453ZWdg0Wxy8j0Bi8zEqvkmMTZ1rAGnrZiDd2bjWdHqyUDGuX+xkLhUscLfqtoPlxZaHpY2qJQVl4FOWCPx/cC13UTrMKMrBOWI87oBZhNmhBC6Di411lDcg34w14Yb5AzyBnBEZEma02V7B/l85KU5D1Gt0NYRUFg3+hLSHR41nZWi5bBn2SQpGmK2bgYSAXDLlt1K6NE8ynmYzFqX+uW57fr4UE8F5IXfKsFfXaDUKZK89TtBw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAWPR08MB9736.eurprd08.prod.outlook.com
 (2603:10a6:102:2ea::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 5 Oct
 2026 15:01:25 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Mon, 5 Oct 2026
 15:01:25 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 05 Oct 2026 18:00:55 +0300
Subject: [PATCH v12 16/21] migration: add incoming migration failure notifiers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-up-vsock-vhost-v5-v12-16-40162390c68a@virtuozzo.com>
References: <20261005-up-vsock-vhost-v5-v12-0-40162390c68a@virtuozzo.com>
In-Reply-To: <20261005-up-vsock-vhost-v5-v12-0-40162390c68a@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: vsementsov@yandex-team.ru, clg@redhat.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 mark.kanda@oracle.com, bchaney@akamai.com, mst@redhat.com, 
 sgarzare@redhat.com, peterx@redhat.com, philmd@oss.qualcomm.com, 
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, den@openvz.org, 
 dwmw2@infradead.org, farosas@suse.de, andrey.drobyshev@virtuozzo.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: WA0P291CA0014.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::19) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAWPR08MB9736:EE_
X-MS-Office365-Filtering-Correlation-Id: d4204f44-c705-4748-24e1-08df22f1869d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|1800799024|366016|23010399003|376014|38350700014|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1B66EOGeFvNvWXFj5WAh2vEiMQgO/EdAgnXZcrt+G/5AgvhYvfsm8NchPpH4ITrqjkT7qrgfzr22aJ15tSFMUYipUzh1K6XsGmZXLzd8C1fkxcRw9OObhTqWSwHux8EeEiT1WjpPv5Rkvz7Su5/MirWwG6PgmHXHTUPtobTeL/iv9I3sz8/2pek4bsHlN6TyMDUejtC4p2TABg86KLejmlTOGrN5a947fIUX/L4KIIx06jqnuAcotv8p4Na2odday4yNmjKFB0u4VSM9fpFqQ9c+hPCiFAt+y7LUEXEQDV/F0Q+7mzLtiEeF+N9Q5tSLgsPI14+Zb0kpYLKmxNPL6jUMaP/qi3VrC/XfITuVMSnNy6a2Ps8FOo4AALANtA/eijgQsucTZ5w4Ij1hZYcQ5R4pvzVmrCWk6jOiztS894WkNloHYZRGYfHaPf0xxmAUj2TA1YkrfdVyOs5Ucq5QmKeonzr4qf74o1bCXezol3sdmKNtOeWymT87ZZBq//qP2JKCQF/VjxuZ8guz6P9PXE9mXa4WVpA42wWYu+7oL8Vrbx0EvLyO2WyrqRA3EVA/okaWLaWqYORXYNHX6c0r6ubSE9Jme3bxJdptFYPNbcV24HiRagOXeEv0V6oGiDSPKarX7OwfAMNfCWO97yJ00DT7H3WOFre4SMWIdVOn4L8NDzqzwPotOFytH9BPLdrBqzbPkHxh6ljKjSLnL2GQRD1b6dVVOovWckEXxG+196Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(1800799024)(366016)(23010399003)(376014)(38350700014)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTBZRy81b291MnNuanJyNjZ3c2RoRnRYTUFNazRiaUNzcXprV0wzWEVKVGtM?=
 =?utf-8?B?R0VVTGs5VklaTEJZdEpFUjdGUmFrNk91clR5Q3JiVXFWdnY4WEJjVzJ4WlE5?=
 =?utf-8?B?TkV4c08zSENSdXBSVEN6akxTaFZseTVpK1NHTmE4WnBMalM4K2ZtSjVvWUty?=
 =?utf-8?B?d3VNNmt2UmIxL0RGSmNVdC8xekxBR0pjUzN4UjhvZDJYQWtIMGxNNkJaRng4?=
 =?utf-8?B?MVUwdjg1NGVsL2NOQTJrZXNQS1grZnF0MUY1N213ZUNLUllaOXpYaVBlZ2J6?=
 =?utf-8?B?TlJxTXNnTVBraDJIcWdaZ0dwVUVMU2R5RXY5b0pjMU5OYndwUGlBbGxodUhH?=
 =?utf-8?B?QnRxM2E1WGo5RXQxOUU2aFZTemJmWHAyeUVJandkdCswb21ndUZsNnQ4bndM?=
 =?utf-8?B?ajNHbTNnUFNLcHRwMXlPWTNDdi9HMjRLakViNy95TEVEWHhHL09FT292a05X?=
 =?utf-8?B?NTB0Mjhibi9ZQ1VOUXhZaEIxREZ1d0Y1a2V6aUZGZitzTFpodnZIUzlQVDZO?=
 =?utf-8?B?RTNacnRuYzIvUXl0VFo4ckQ3T0R5cmVCRVFxVTJoU0dsK3drRXU2M2M5YzNx?=
 =?utf-8?B?Z2xBcmNFZzd0a0ZES3YxNmJjd0Nvb2d0S3NhNjVFaG9YeTRlSlNaOFRCY1Q5?=
 =?utf-8?B?dFdrNTBNbWg3SDd5RlBJb054aDlqbVJCa2d3ZW5kd1BmcUhzeG0xOFZwc3V1?=
 =?utf-8?B?eldsMWRkL0MycU9QKzhmM2V2TlVwdXplKzVySkFYTWFQYkNEbEJDSmpnWnll?=
 =?utf-8?B?a2FtUUhtN0xqN2ZCcVlmQTJmbFltdTJjVWovenA5NVBxRThGL0ROTFlsMmx4?=
 =?utf-8?B?WHk1UlRCMm5JYmZSc3pMa0tGOXhYVC9sZ1czbzAzUHlXV1V6TFBwV2lsR1FZ?=
 =?utf-8?B?dGo0dXpvUVlHNFhwdWk4blFLZEhPc1J0UEFWOGlVYXNXbzZVbnZ0b3BUbHFx?=
 =?utf-8?B?Q0diMmkyK0pyYStLbGhqaDI2WW9lcUIzWXF2UGJJSlpxUlRMY0pVZ04zcktF?=
 =?utf-8?B?SWo1aVZINzdrWnBSTzQ3eHVNam9IZTBFSUN1eWI3cnhtNW1mRDN5bEIyeXZr?=
 =?utf-8?B?b1NPUXhlWFJrK2w4SDlUNVFqcEQ4T25peE5vcTUzSXpkc1c2QkJtVE0yRm9V?=
 =?utf-8?B?bEdDekJlZVRVSElQdnYzZHVFUllnNU1OeGU3bnlueG9BY3dFN3FxUWlsM1pW?=
 =?utf-8?B?MnU1UHRTbDBmbjUvQ0NlZklQYjlpS29oQm1ybzFiblZ4M2pNMXdSUS84b2My?=
 =?utf-8?B?L1pRS2JTNEdIK1lzYWZuMDhrMVBENDF2ZUJtUVBVYllIYzFkYnE1WndlTUhj?=
 =?utf-8?B?Y3FkRU9rZWsxbWF2azZTMSt6Q0lTUE91aURHREp0azllTUt0aXBFdk5BaEI2?=
 =?utf-8?B?SDI4MjFTVUVzanhkdTJiZnJoZFY0S2dReVluTEtLOFAxdUgyRUtWdE5PeGNu?=
 =?utf-8?B?Yit1UlA2RGxzU05VdnNaY3lmQTlWdi82TCt6V3dYb2VKWHRLS0dPbWQxMnVm?=
 =?utf-8?B?Nm55ZW1xeEphSEdsdzBzU2w5MGZzN1BKZ0p0NlgwU1BXSGRNQ2QybXlwMnEv?=
 =?utf-8?B?blZ4ZjhSaHBxNkhibEszM3VEekZML0hFMEpzbGhPNnVtdHJycEozOFc2ckxz?=
 =?utf-8?B?ZXMzN1FGY3lyTkcyN0orZUZZV0htU2tlS1hKczRwQXZrMUQ0a2FJOGRXaW11?=
 =?utf-8?B?YVFYcEErWlhMaDUzd01nRDVZNXJoV0tpVisyb1V5VmZJZEJnbm0wWURXdXlr?=
 =?utf-8?B?RjlqUVhHWGtVNVFpN2NVN1d1emVYZ1lJcVJPbVIxZ3ZrVW9TSnRic1MwY0xG?=
 =?utf-8?B?VjZBQm5vandDUVVkNUxQNmZaaVNjUXBYOWFqY0ppQUJTTFFtTUsrRzkrWmtw?=
 =?utf-8?B?ZWtFS0ozVEVEWlVvVmhDd3lSanFWa2oxNmpralR0L3JUemE0WFg2Q01vWXgx?=
 =?utf-8?B?MkNvVVhQYk50blNIUHZob1htZkxCVElJcnpMQjQ1bkRGTUZ3ekhFb2dOVGFs?=
 =?utf-8?B?enVtUXhqcEpNZ0tnTWxHUXJaZ0hCVXJUbFJVeHp6YVBmZHQ3T3REVERpWUZK?=
 =?utf-8?B?NXkvOXlUM3FiUHdscCtKRmNOTGNRTTVESkdWQ05iVklZRXpxTVJKV1JYRmF0?=
 =?utf-8?B?N0htOUtTMytHSkI5aXIvTEVTSFQxOXBzQmJmRFl5cW5iVVdGVlgyZ3gyc3c2?=
 =?utf-8?B?ckQvOHRKK0krcEVrNWlBRnU5ekVqQTlaK056bzhnWW04UHNIbGltM0pQQVoy?=
 =?utf-8?B?dXJpcDlsNXBDN0xGYUZBSWhJKzQrelRLS2NZMU83OEVIc25qQ0dSZmhoMjRk?=
 =?utf-8?B?N2lQN1RDRjZOeXE1TG82eFBwcGtJaWZJTmNZS2dTSThWRzE2UzVZdzNnY1R0?=
 =?utf-8?Q?dWYEfeVRBssHJzNI=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4204f44-c705-4748-24e1-08df22f1869d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 15:01:25.1874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iWgxUUccRJunS4Mj5iGjam3KO0cq10SttR6mTyhWGd2xZ9riedTMyMS9Ik46mSTLZAe7oXfVKobkzRYgEII5d4kK7UufYNxtlY9DJl3ZdHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9736
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
device to give that resource back before the source is told about the
failure over the return path and resumes, or before the target exits.

Add a notifier list for that, called from the failure path of
process_incoming_migration_co() before migration_incoming_state_destroy().

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 include/migration/misc.h |  7 +++++++
 migration/migration.c    | 23 +++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 019717f4cda..08d110750fc 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -112,6 +112,13 @@ void migration_add_notifier_modes(NotifierWithReturn *notify,
  */
 void migration_remove_notifier(NotifierWithReturn *notify);
 
+/*
+ * Incoming side: @notify is called when an incoming migration fails,
+ * before the target dies or before the source is told about the failure.
+ */
+void migration_incoming_add_failure_notifier(Notifier *notify);
+void migration_incoming_remove_failure_notifier(Notifier *notify);
+
 void migration_file_set_error(int ret, Error *err);
 
 /* True if incoming migration entered POSTCOPY_INCOMING_DISCARD */
diff --git a/migration/migration.c b/migration/migration.c
index fab7949fe11..55ea1e019fa 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -71,6 +71,8 @@
 #define INMIGRATE_DEFAULT_EXIT_ON_ERROR true
 
 static GSList *migration_state_notifiers[MIG_MODE__MAX];
+static NotifierList incoming_failure_notifiers =
+    NOTIFIER_LIST_INITIALIZER(incoming_failure_notifiers);
 
 /* Messages sent on the return path from destination to source */
 enum mig_rp_message_type {
@@ -818,6 +820,17 @@ fail:
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                       MIGRATION_STATUS_FAILED);
     migrate_error_propagate(s, local_err);
+
+    /*
+     * Allow the devices which have registered their callbacks for
+     * migration target failure to undo the changes they may have
+     * done in post_load().
+     *
+     * Do that before migration_incoming_state_destroy() reports the
+     * failure over the return path (if present) and before the exit()
+     * below.
+     */
+    notifier_list_notify(&incoming_failure_notifiers, NULL);
     migration_incoming_state_destroy();
 
     if (mis->exit_on_error) {
@@ -1590,6 +1603,16 @@ void migration_add_notifier(NotifierWithReturn *notify,
     migration_add_notifier_mode(notify, func, MIG_MODE_NORMAL);
 }
 
+void migration_incoming_add_failure_notifier(Notifier *notify)
+{
+    notifier_list_add(&incoming_failure_notifiers, notify);
+}
+
+void migration_incoming_remove_failure_notifier(Notifier *notify)
+{
+    notifier_remove(notify);
+}
+
 void migration_remove_notifier(NotifierWithReturn *notify)
 {
     if (notify->notify) {

-- 
2.47.1


