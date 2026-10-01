Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF341CA5FA5
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCC89-0005FU-D9; Thu, 01 Oct 2026 04:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCC7w-0005AZ-Nh
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:26:54 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCC7v-0003P8-7v
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:26:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RTMFREh0tz5sRfqYssnVfDcH8ogW9o+9/jipWhmAOukdDDLBTPX3jYrVwSOxIpGq0o333rZ0T52Q9wUzdar7VRSWkOz6g7ol5WSyK9rS/b8gcz/3BPGaOBQbuYulXVjsk9a1NLWdZeXlrbuy/Pe95ZWmS5JfUycPMHfjbleym8AHecNCKJuZ9L155ePzs9Rf3SV/ayKOV/SZ2H7eLxOF94wk++huuKRuFxDB31AdVC+AfIsCztCg7DcGQULJX7LFDzkAa1pAHWEDAGpRH0veNW6Lry7lLgFHetyB98nmlYzEbek9UDZreJUATpUNtycl3GTKXl2QxjNexulUjafYGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXgQR79hkZDDfXuHJA0otbnU8q3wx4xJTCQyzRPPke0=;
 b=RD7qKL8o0vXzWpJJHjVYWeqHRU4QIGKYUvT6W8t6/Lx4s91nfgEN7Oq0ydwxOeoW92EyUVCcqwX9RONcPLcot0gs/IVKRPA9n+PyBsxzL6jO7vmJhniVcBAcVbvuv9q4LjqAZr+52Jl38+z77pRLBZmSMZcFv7FSMbr2Toj3CP8Q0vV1cER8ZTuSTmLJMtXRt0e1XcNrGq2YfOA7ZTfA3H1h4fJ/5m+ilfPHps8FPpW4UGNt6Ku6//82wJ1xMpz6iz/Y2P6+RTo8K9kW+tkQSnzQgg5EfIsMHyNCtCN0lhunsFZSE33Td4MxQeXe0FBwvB+qpZMfwsobUJsSEFbr5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXgQR79hkZDDfXuHJA0otbnU8q3wx4xJTCQyzRPPke0=;
 b=D8UIBhfMdaiyosMLSnGI/iwqbOdKApqc/b++JKQiuQ7MpY50pgZggh41YsrHtzJPpA0Oz5QEQnMTIMaiJaUlhgiSSMirr4pQtFEmgL41J8POM6Lt6wVXfFP+JqW9LO4+dyf5oYpP/GkhFGOkB2tZwy9ntHSXwEyftRlu4wB9R3rsSECcqG05liu4d9izBSsFOVUQ+mAVwuJDwDptaLDmJyQdM/QLZk0t0z+OteDTl8+2wQMwnRxzqpfwfTFmA3kW5hlsFhJxTtK+4YtrXLSfjnwbZYrTgHM1ZVuI9wWcxSfqyNHNwtt3vSn70kyZs7MNrtmypHp/w+OJ8ZGknAeuNw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB4PR08MB9261.eurprd08.prod.outlook.com
 (2603:10a6:10:3fa::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 1 Oct
 2026 08:26:39 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Thu, 1 Oct 2026
 08:26:39 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Thu, 01 Oct 2026 11:25:03 +0300
Subject: [PATCH v10 03/18] migration: forbid snapshots in CPR migration modes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-up-vsock-vhost-v5-v10-3-8c094843e98b@virtuozzo.com>
References: <20261001-up-vsock-vhost-v5-v10-0-8c094843e98b@virtuozzo.com>
In-Reply-To: <20261001-up-vsock-vhost-v5-v10-0-8c094843e98b@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, odaki@rsg.ci.i.u-tokyo.ac.jp, dwmw2@infradead.org, 
 peterx@redhat.com, mst@redhat.com, sgarzare@redhat.com, 
 vsementsov@yandex-team.ru, farosas@suse.de, mark.kanda@oracle.com, 
 dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, 
 philmd@oss.qualcomm.com, bchaney@akamai.com, clg@redhat.com, 
 andrey.drobyshev@virtuozzo.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR07CA0284.eurprd07.prod.outlook.com
 (2603:10a6:800:130::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB4PR08MB9261:EE_
X-MS-Office365-Filtering-Correlation-Id: a72321e1-9e1a-4cf3-7e64-08df1f95b757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|52116014|7416014|376014|1800799024|10067099003|5023799004|3023799007|18002099003|22082099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: 4RZSFh6G0WZmlLTU4w1cpxIv9MGlZBFw8Es+Ti4VWAp3wRDafxqCk414/pvIM8fyu6OtCtA6rlX+L7PSWGO4js0sb5lWkCA7qc/qN+sjzLaq11cz+np+qo5dv0QoZUHT2543Fdk5bW+qCbWO2scKZ+Z2SemblEvdQr1nbNE/c1dEebUeHoUc6wIyRmIbkA/CZuHPyvq94teZm+wJ2mG+DDRfumkKP5L+xqXu3pUixltHVA7iBMPkaqMA+uDooTOD31+tZxyUP3SN1yRrmsMhNEfPtuDHHmBFIlHUycQqbd7nDENpCKOmcIb70UttFPMXoYOiekY/mgRx+lhuLi0/kMYCQCvs8rqMytufRNkl7GdYQpjsDHTqMIfZFdWvMyQwknD96/CJZekyk9fOry1gcFRHcR6UzsUBuHvTQSVs1QwLC7lMyevjJnogNxbePqO9GKgK3LFpScHTGjctuL+QsH8SrPl5HU4kILTfprikpt0ra1Vqh8kh5uk+GcJt8jDCiVZoJLNWGzJjmQ73PcEqdsjDqNUf9CmZB/VmrBzFrjVAclpOA9gE7v+8cS8ClYEQ5njZKr5NFg9yT7I++QMAuDgfTYHG3N6Aajuq17vLuDcSDvdRM7G80ImCGZppYfYofDQsgdacyKnd2bRgPOeWYgRJo6ve1SBN/HxMrfuorj/vELU2HtH9OOEIRp3dMJpakGu/eZVgg3k42kRgBzBENjV2kjwdbVuHeOaSk56Nf2E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(52116014)(7416014)(376014)(1800799024)(10067099003)(5023799004)(3023799007)(18002099003)(22082099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEZvVkR2N2dnQXRhc3R2dGphMFpuaE9qdFFYUWptUEUwcVNiYUpzK1dIUnR0?=
 =?utf-8?B?Y3dOQys5ZzFCaC90TFVSQWh2bkdHKy91Q3pTRmtWTEphUkJYTWJNSWgveGpy?=
 =?utf-8?B?QmVBYVJURmtCV3NpMmF3WWY4Q2lFWnJ2WHQ1TmU1M1BIWk1oeEhCKzAvMkVl?=
 =?utf-8?B?SUk2S0g0bFBvU1hNTG1qWFJJeFNtYm9pdTdicDFPRzZzdW40cVQ4c0JOMkVz?=
 =?utf-8?B?d2RieGxuUkloZ3U4VWI0bWV4dzJvQ2RRSTZmbVlEcUplNDdsaHRsRFlXVzBq?=
 =?utf-8?B?Z25Bcjd1UlhEVDVNSk5GUENnZDNiRXN1QkNSZUU3ZDBaQlY1SnNHOGh2TGV6?=
 =?utf-8?B?RE00WkhKdGEvMkhJVWlRMjNDTHVIVU9OMkFvbGtYbVNuczBqYVpaUXRBOTlZ?=
 =?utf-8?B?cnIrQkxHOVJWRVZhdnYxUlZCQUxaMTNLWXNoTVpDa3hiajU0QU5UcFB0Szgz?=
 =?utf-8?B?WnJoL1A1MDE1RzlTMkZFRzJCOWk4cDB1UHRaV2JwaEJWSW9yUERwOTZQZHFh?=
 =?utf-8?B?azc2azRDNWtlcy95dHdGbkkyYm8wV0lGdFUwTzRQaUNUbmdQeThyMU9ZZXNL?=
 =?utf-8?B?NUwwNVA1RENjMW0xNGZVOERJd1l4VkhKMnhPcFYwaVBVb2xYMmM1UUk0RDVV?=
 =?utf-8?B?YlMyUThNZitScFB6K2JWVkJpc3BEOTh6d0ozU3hnUnlKOXJja01RUGllK0RN?=
 =?utf-8?B?ZFdmTk9CYU45WUo5SndTcU0zRkxrb3MrckRyeXM4S0w2OGhUSnFTbGRZekh0?=
 =?utf-8?B?b3l0OEtwSkxZYUtyT1BiWWppRzZPckZSczRrWjVlZldaQndvejFqeGY0QnRk?=
 =?utf-8?B?c2xnVFQ3eGRSTHdlM2x1ZDJ2alVVLzlON2JKd3VqUU5rRUlBeW13Z2FGSTRC?=
 =?utf-8?B?OEhjRjhscyt5QWVrc2tDcWJncFJROURCSnNGenhWWGptSTU1SnNzVzN3ckxC?=
 =?utf-8?B?dW51QWhKRHVxYkgxRG5NRTNZMElGekx2RDVETHRLcVZWdU9GMnduV09BQVlL?=
 =?utf-8?B?dWxCQVh2OEpmZXhXV1A4YkRBR2E2czd1Unk0UFhLeG93U1Y2U04yMnNQMmYv?=
 =?utf-8?B?NWE0K1J3M0dSYWFkdmRtTnh3OUNDYklYaXVwV1FnK0tseTdYQXBBRUNnc3JM?=
 =?utf-8?B?aXdVVTRpbHFpd1dKbkZQZzVIL3RLS2xRU2s1QnVwaDQ3SjV6bFp3MW9BRGVI?=
 =?utf-8?B?TVJCLzUxWGlyRFA0U1RmM3V2YnQ1SWNQQlk3bW5YYmU4cmFWaURCNG0xQW9H?=
 =?utf-8?B?VXA1azZsVWdvOExFcFVmeHd3dHlxcDQyK1BES2lyeC9JVVZVejljUnA0QVVW?=
 =?utf-8?B?Q2oyd1RYUDg1Z01Haitkd0VITXVLRVVmMjZBdy9FKzZaS3FVTTVuRlMvbDUw?=
 =?utf-8?B?UjdROHROSWhOU1RIN1A1TjdKZnNsc0huWGp6endsMWtDUjRKV2EwR0pSRU9m?=
 =?utf-8?B?TzNuUTRmNk9uQUdOeHpQTGVLMDZNWi9QdnUvUkl6cGl5dExpZDQ3M2tZS0Yr?=
 =?utf-8?B?ZjZySkNUODVnR0lXKy9BZFFSK1NFYW15QUp0ZmRhTGgwOVBjVkNkRVBRVGhM?=
 =?utf-8?B?RDNzeGZaRVhtYXZpVlRxZll4dlVXNFNlY1ZVWlBQL0x1cFRGaTQvR1VaQkFC?=
 =?utf-8?B?c0RTZlNkdkJldjlweEtSNXRlYkhZZmk4a3dMSjBIaXRwQU9qcjA4QXVzcmtk?=
 =?utf-8?B?YUFCdWJsd3RUYzM1VHI3Y3RHU2lOSTM3UzNnNGpTWE9HUXJaOCtqdDU0ZjRn?=
 =?utf-8?B?dmZXZTkwUnR0SnYxQm5YYnBkdEp2OHMwME9od2NBL05SK1pHcnBtQVZSWG1N?=
 =?utf-8?B?THQyQnF4ZFVPejJ5VHdRZ2xmNTc1WndJTnNjSVI4OTBGWUtKOEIyRUdyNGV3?=
 =?utf-8?B?alVwemc5MSsrVWVQRjFmTzEwcWFhNCsrUmdqVVdTWGh5V2NpaFpDcFNZWmw3?=
 =?utf-8?B?QnM0UThIVGpEUk5iOG5IbU5GaTE5QWdFR3ZuS0JwNFhPODFwWWJteC9UWEx2?=
 =?utf-8?B?bmI1NTJDc3VuOGNpZC8rVWs5VVN5VXdYM0dmR01JRk9IenoyYTJ4TU9rOGNV?=
 =?utf-8?B?dm9PY295alBWd2xSVkovWWN2MGZ4c3NsZU5CckF0ODJ5R3ZtYnVRRmZJYXNk?=
 =?utf-8?B?dVFOaGdUSmFkSjF6OWVQM3NaaXBCaEFMTDVoLzUwY2hYMXRnczZ1VEFUdGpW?=
 =?utf-8?B?dkhnK0VwRFo3REowTDlZUFk0SWVoUXlpM2ZiUG5DeU5PQklWSGx0YW9SRlJO?=
 =?utf-8?B?cW9VdkNCcXY3UVNqSVE1N0MzSmxmNGk5TGZWUTRlSXh3cXhNOElFSlFLc205?=
 =?utf-8?B?UFRMMTlJT1ZIZ2hZU0ZFSEdKcmdXRlV1TWVzS1hKOWY0M1VqbGdjQ0crdVlo?=
 =?utf-8?Q?jAZH0HFwEJMyjEsk=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a72321e1-9e1a-4cf3-7e64-08df1f95b757
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 08:26:39.7577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p1UwWC+bnaunb97kbEZZ7JCNSp3FAb5+s9PBIETCwkZ45ENaYZtwtS5/FhML89VajzySQsY6wt2ESijjUbQUaQpfB1y0yDbsRAxdKq//cMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9261
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


