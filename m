Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A2FC982E0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 13:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7YwA-00032Q-HR; Fri, 18 Sep 2026 09:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7Yw8-000326-Bf
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:47:32 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7Yw6-0003Df-MD
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:47:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nu8Vxs3EHsp4CfxxtolQvi3pqairZaWCY2iiIOx4cruNrBZgAbhqXYpJX9CAbzF7AZcPs9IHJJg9eOU62q+OpE0FnXJpCxCby96QZ1q0syJoHBpml5y0I9zNx/oGVtSVjyJL+I6th6P5OwqwTVmg2CLEDX0xDiw+UyZZN1nZHgUIlqIUDR3glkcS1KjSwVoTZaTa7RnDwAHDDSbG2kpKqzljXsAclOYoI0uAWmfDWmKnEsrbTOm+ayK5pwlB3snNKFIvu0ADf/o9h/7MQlQoXag4ZxoQD8HLM3OqNEJ+0ZqM/mZuiUZRo0Gq1w48Fj8w+O0XmrDaLFtt/5xZZK5hpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WebTp+tcOwBl/cWDYNPVeINW0qQudSX1ByQo0NMoTmk=;
 b=At+9+Ar2MVKGU/Pxsd1zj0mAdhG7mdxk2rPzyCfP8uDDpXPKF1kR/HlxJ5rj2OhkrChlHo3sRZBhp34cWn5dlI5dO5a0nVFT74ylp/sCKPWS8IMM8SD0OTuH78YZmjLrYu1jVVh2wV4xac6ys/ZodbslhgJLgTzm54EqrmbWJozNEFbdzxTwXq1x8/3nap2uqLcBUeVWuq0LUYRIdR0xa8UGELsduF3WdVwkl41WDvGnH0NhOaaak5qYGwiWAUqjkuJtYIwXyGzXvNunfg7w217y/y7pjCqwThI5PDeJJ83YOaf0ljnkDUs37CArr0qolSLae1WNiN9azGwb3TF7Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WebTp+tcOwBl/cWDYNPVeINW0qQudSX1ByQo0NMoTmk=;
 b=KmESWsd0CcyK0i4FXaSU5So9PXpk6urCKnXSbrD3KpKrXyo5TlBbf2J3N8JE4do245Rq9rGz3mAUt+PYZfFkoA75OAnzrPhPQRf5GO9QfRdNkg6pblxblVmPvR7HZhHhzYA6fuCgs/3iMzQM3uEX3aroUFdnhoc2fsPgiAqVHXgy0AnezBI2mnhM4e27JA/Q4I88b4s4nYgDttJtRZjbo5CO1t6+rBFMJkU80EThKfAsmniaDXNODFiMYuysRvYr4cFmIi8YsJuZTXtVm4NhvEm21nYlu95LzEjUWxSpwIJKQiSfstB5dErT2PNv64lKbr8zK2JvQWz5oWfFk5rFMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB4PR08MB7933.eurprd08.prod.outlook.com
 (2603:10a6:10:37b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Fri, 18 Sep
 2026 13:47:18 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Fri, 18 Sep 2026
 13:47:18 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Fri, 18 Sep 2026 16:46:54 +0300
Subject: [PATCH v7 03/16] migration: forbid snapshots in CPR migration
 modes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-up-vsock-vhost-v5-v7-3-6ef9ef033c35@virtuozzo.com>
References: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
In-Reply-To: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: farosas@suse.de, bchaney@akamai.com, mark.kanda@oracle.com, 
 philmd@oss.qualcomm.com, vsementsov@yandex-team.ru, 
 andrey.drobyshev@virtuozzo.com, maciej.szmigiero@oracle.com, 
 dongli.zhang@oracle.com, mst@redhat.com, clg@redhat.com, peterx@redhat.com, 
 den@openvz.org, sgarzare@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR07CA0292.eurprd07.prod.outlook.com
 (2603:10a6:800:130::20) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB4PR08MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: 767e2fcd-39ff-4923-a0cf-08df158b5b30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|52116014|366016|5023799004|56012099006|10067099003|3023799007|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: svVPTvUZH9jqu58wgkIg3L49eFzYx80R6Mebqsv9L8LcXIN26fB65jUCYAL0QyBG+QLaiyZJBLK1Y0ZsaIQfLJGn3G+EU7IjydReadXh/WZIPvO/ar+37lsPI1aLUdJh7D9nCxzXhPMQqGO+ZHrB3ZMeC91A64i8cjGK7/Fec4ECz1rz/yVf/vDUP0voovX+DHgOoYyZsudqGRRUMNO2VJFTieV0HSzRmXRm0sijubmuLEQK2ymgLV99zgaJAwdNrp62EO5WUkqAF8IwAXjokhNUeOWZEkAuYnsLQRhDp7W91eUBMyjHHF3CCEhgFYUcn5q8w6a9aIPudN7JpTa8YYs7vu/kXO6gBLMLUBEBMMYZABrfcQ8M6O9B4128q+sREdZDo6ZNGTjGoJre0Xs77yugKJk4maQzY+lQ+0vzJ/gikmS4u85Ae2zKKXrjSEvAUmAdQMJcNfm9qt19ket/b/YC2k+kHXrYeAJuGMBpw9wP+lGh6fJA50ef5dzX0IuN8xkova+iBcpzmFTjXs/RHdieAb6b2wjEfb+cRBM3H1OGC3o4uBvauQfMSot5ZuBOibO4RdMY9KTk5z2j7iaUYrY9DBMkZG99y7sdNnTNznIy1sYF99untCL6cPUuyLeJS5x4NqdvXXlQSL4+1Ou1y5xikeG37itksHATHYIZ7iqYjOGZabj3JOPGtMvVWTrYgDsRJspbDloFD976ZEGXIDsJEg6dG0tJDKEnyz2hB8A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(52116014)(366016)(5023799004)(56012099006)(10067099003)(3023799007)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDF4M0JzTUdXV0pWZnNSdkh3VW53ZGdxMzBCM1dlazVJcDBlTFRVQ3pBSStQ?=
 =?utf-8?B?OU1qejBRWWRFdGNTaGcwNzh2TWZGZXcycVdtQXorbFJvaVI4a08zcVlrdEU4?=
 =?utf-8?B?UnRUcjZpOGl3SFNjNitlbERXMjlieW85dldiT1FuQzdyRDlCMWhieEJ5TUgz?=
 =?utf-8?B?MUY0TXQ1K3lxSTBoajdVc0ZQNlFUd21XNldPZ3BCNWdZRHJzRml4K2NEank4?=
 =?utf-8?B?dlFEamJBeFZoMWVVZmZIcG01Vys5VXJWYlhoZTRsN0MwaGlUbTJ5QnpaNTJW?=
 =?utf-8?B?MFAzT0xocmVxaTJSVWdKblBOb081VWN4RUVSRTNod0ZMaS8wU1BRWTJUQXJS?=
 =?utf-8?B?M3RZRDM4TVFkQUduZmJaZzVITUM2M1dGRUhZajA4U2xlaUdlbW1yU0dORUNW?=
 =?utf-8?B?T2FhdWMvVkVWUEIwUXh0d1lTU1g1VVp6czBxaW1vOVZFWkU1encyOUZ1M1VM?=
 =?utf-8?B?YlMrRlozWjF5cDJkN2xpSG9XdmcrbUJYRkowY0hEeXBPd1hIMWwrSHloZ2tJ?=
 =?utf-8?B?aFkwVEh3dVZMWFdrM09DaXN5MjVuempUclZweXRhQTR3OFV6elRYTXNRblFy?=
 =?utf-8?B?T0FDOXpHTjZJb0xXckJzVGRUemtFdE9tT0E0YmFVYUViNEFvOUduaEExNG9y?=
 =?utf-8?B?RmM3eGNsazIycVFQcDNVZk1IWFVzYVlpRnVzNW5JM2t0eEM2ODhHUEhaL3Bs?=
 =?utf-8?B?OEEwdkMwb3JRbXZUQzBSTXZCdmlUaWFoNzY2YjErcHNMMEdROGF6UzB2TFFr?=
 =?utf-8?B?M1M4dmIxaVozR3pHUjlqQ2JpTVlxU1dZOUxzRzlDMytKSk1zbTVqSWUvMkRj?=
 =?utf-8?B?bWNzRDRlZFdBQlRuMnZ4anpYN3pucVR2MnhwQ3BDUWREUEZMa0swUjhWYS9K?=
 =?utf-8?B?am9HMzRabEJvdGphTml6NTMrYjBlK0lOaEhicUx6aUNMYUxNcTdXRktOR2Ni?=
 =?utf-8?B?VzNSTGgrV3l0MHcvdGtHZWNSUGdGcC9mbklTR2txUGk5Y3IzY3hQYkh2U2Zt?=
 =?utf-8?B?VlZMYUc0QmoyNWhWV2N0d2Z4S3p4NGhNMXcxaWY5djlOaTdBVGlWVklmMVN5?=
 =?utf-8?B?OThCd1dkVEVJSTQxTzJBandzK3NVVkY0bGNZVWJqY213L1R0VVBPSkVsVjE4?=
 =?utf-8?B?QkR3TTZ2SWFsN1JPNzErZFo2L2NlTXBXZzdUUytLL3lZZ3UyOWFPRG9vSXlV?=
 =?utf-8?B?cVNQL3dZa0dNelBsNVJpd2s0VGMwckVXc3Z2Q0ZVbkNXQmdqTjhtRk1hVng0?=
 =?utf-8?B?RDF4NWtkV25YOVB6c0NPTmFTdmRTMFRONVhvMHgyVEFGQXFaZ0hva0pNQkJP?=
 =?utf-8?B?b09la29oVzQ3dHEyVzJKYm1zd252aTN5K0VhbmZOaEI4bVloN2svZmVZMmlZ?=
 =?utf-8?B?ZXhhRkk3S3ZpUEdSU3pud0d2WDNnOGlxM1dDU3NSK3JtYzVFOStWS3kydzVU?=
 =?utf-8?B?S2IzTVBLNlR3QWF3WmYzNWx2cWx0aXZNOFU2cHdXMzA0SzdRK3YvUDVFUTg4?=
 =?utf-8?B?VkpHcHdDSFlxZ055TW1tSDl2WFhiRHEvcndDUUVValZqTE1tSVljTkd6bXpx?=
 =?utf-8?B?WnprVkNySGlIYXYzcS9MNlZTcS9CRGJudklqZzl4MjJtYnJML21hV0tObTdq?=
 =?utf-8?B?QVF3WHlDYUtvdFBrNENmcDIxVkVNSUFZNFBuZ2xncmVDOUxQRmQ0NWRqWTF4?=
 =?utf-8?B?aEhZMFBZOEVBTmdNc2ZEdjBRSUxHZDgwM1lBU2ZqdkljSUdtdmpNUmlhYllq?=
 =?utf-8?B?bUJqSWJ6NlFEZ1VZbnJXaEtyT2hPYmN0K1o1OXdSMmFaai9YYVNEc2lPU01O?=
 =?utf-8?B?eWtYV0d1L1FuMCs1T3V2WWF3ZGsvU1dvSjFuNE1US0VXeEc3UGl2NDBTV2lQ?=
 =?utf-8?B?aStqMm92VC9nc0lUcmVJRGg2Vm1mZE1Odk15cVNwc0xBQUt2aFE3NkhiU2Fp?=
 =?utf-8?B?K3ZBaXNkdzNNRFA0Q1FCbkVmNFhXZnZiUk5hNXZYK01ReUhpV3R1S2kycU9p?=
 =?utf-8?B?aHM3STBLTDEwMjFYZ0RQTWlreTFicUZTekdFUE1VRE9hZldKTW9Ocm42QzR2?=
 =?utf-8?B?cTVZVVl2L0JiemJSZG1hY2ZTd1J4cCtaQXBOOXZIbzBOSFZIdnkzN2N6bEVh?=
 =?utf-8?B?THZjdWlia2g4S0ZQeXR3Zjg1NGo1b2VuY2l3TUFnYnpZck54Ykh6NVZLVkxl?=
 =?utf-8?B?Y2tyZkFqQ2c0QkNodUxNQVkrM2VkcGNUdUNrVXZQY29Fa2JNUG93ZlVudDdE?=
 =?utf-8?B?OWZ2VHpOYW9UeEVsU2xVL2lwa21CWmlYa1VxOVJ1RFhvQ0d3czN1VklJcGNC?=
 =?utf-8?B?c3lLdGNuOHFRMTViODVVbk5KampPMmtCbE5LK0JFbW56YnRvSHZJUlRuTWdo?=
 =?utf-8?Q?cc0Z+hTBcrHNf9Qg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 767e2fcd-39ff-4923-a0cf-08df158b5b30
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 13:47:18.7118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/gorY9dTNBEfuk6nywt8Lv1nE4unbi6mfOXIllC00jwbIvDYZXaqyxmxhnoigMPasrfhmAnEoE/YkICZjqX9zG8BVmiRGBOYnkaOUqSN34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB7933
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

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 migration/options.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/migration/options.c b/migration/options.c
index 05b026f4bf2..f648be1302b 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -555,8 +555,15 @@ static bool migrate_incoming_started(void)
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


