Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE32CA9ED2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:30:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGDHe-0007on-1K; Mon, 12 Oct 2026 06:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDGy-0007bn-Fu
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:28:50 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDGw-0005Eh-Vm
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:28:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZMB+2u5dkC8ccfhEQ6xSMfKQvyZTEn1E2PbpO18Msfap50P6Ab3RDC3Nm+ldwwmVEWrGZlZM0S93W9UdEQ7UTLjMRTI/1FtTTIAIQeBD1VwOkMGG40P9qCFOYysS88CFjt5GUK6mtk13Qb9/FfEjGHUa+FJHRo/gU/GJeEPKDo8AfS3CpCPSPuDDyW2R6b2Na1EZyEJOggpsP4oBMfpMumwsfwLcbqE0fXs9DQ6VSa9fiimK7XkdDObjFV73TTBc1xQWuxwH5V0SYUvycWhe7JwAmQpth0HS5rNDT3qeEexLhI6Ly9cjp3O56SBK9DXXc0nNsdUigBoi2yxqNSPGMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsFB3FDQ+3FBoUdGrsPH789lm9GaLA45KHUm/J4Q16c=;
 b=Na79ZMRSfGBcv+Ua1gCfM2B0KCTYoRobYmLhvpMHhBVtXj6Dg9tLkv/Bk2RSxpFRt8MyI1IMAi3N8qFX1yVwB5pmYGG2HBd7Pm4/Z04NAowpHfJ3KHAgutfTkPFwpgo9OC0ED5unjzLzdteY1pWDcJozB3Nu7AH23x3vwgZaQyYL8/Osk7fvoITFdRaQXjRObaP3uZpBki4eO+hcJpd+sAA5bxURRfs6jBr6Xcp7pYZXuMVuoZeSCAOASM0IOll2gO6CC5OVgkY7wd0Qo52qeqmiCtIaX3l1bEU9IDd2B1Ibo6SKjU6xbKuQ85+JcJMChY20/T+7kr3LnDojxcrRaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsFB3FDQ+3FBoUdGrsPH789lm9GaLA45KHUm/J4Q16c=;
 b=Ae/qogwnlO7N7HNcb2+ychsi29+TJH3VyrqapdeiTcJmFlNK2xaBigXJ1Rx2SF/qEBVahuhubnWCcy4e6xwoEg9rRo9cN97AMUGkkmLl3/zF6IlCk3TwXB4+9ETdUXmEYFnxIYtRZr3O/tuPONaSCVN3G+9LQ8Vbi1aAiiL7jZntUocBq9O5I5+Myv0eTFD1x0VI4g+fmCgXHnyFPG0TQgMQJ00Vt2RkaOY1Bs1NxVwzpQyeoOrNVyfQDk0BGoQStNkGq1DQlqZtMprUITCca4L44HCl8FV3Lg9HotlaIT4L/nS4TlTICkMGmOJ7zjTn0D0IGFYsPV9znjFhWTXxdQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM0PR08MB5523.eurprd08.prod.outlook.com
 (2603:10a6:208:17f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.11; Mon, 12 Oct
 2026 10:28:34 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0522.008; Mon, 12 Oct 2026
 10:28:34 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 12 Oct 2026 13:28:12 +0300
Subject: [PATCH v16 04/22] migration: forbid snapshots under Xen
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-up-vsock-vhost-v5-v16-4-36c38bd15ffc@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7e131773-eb6f-405a-9ef8-08df284b91aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|23010399003|366016|10067099003|22082099003|18002099003|261009223027099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: wSvPdY3Y/PmLmsgl23O7OCCoDAgy1FCyNkZL5CLJZwNpWk/01mxrH+XeHASHhft1/yUl5SlX18MhnCNYFkXTqPLO69ZjaIneTGCo7OyBvGNmi/KAsKO+VQfgjzPQU8jF7RDVf5ZM/1Sa5LSAU//D1F90Y0pOKI2/ev3MCPH9ql28v2tqe8irP2W6TwcE+JqHdCFbmdyySbWokoP1NooYDn7wfIgOxYIq8A0eZEy+j7Z/scTeOObB5vuffVLLtD9ETBThF5xaJBE2D5TSnfYmZVIvyTXzMZr9yrptKiV/UrPqNDMqfM2NT6Uq3PLRQ/jmt56Fq59rTnlAjXtXudqNhP1Sm7n5P4ERNLh5mwmM/J4I4yI6mo0vdgHAwoP8E2YoNAkVLCqF6u6wAz67nQMridlaLh5T0uePnVhgf0zL2BnpLxKza76NVSxF2JUVeO6J73r0a1AI0ae577/PEsIDEewZXiO9vYrCt4rUG/dYoOybaxgxPSWocvOg5sQz1gaKDNFLiVtkJr6GeCh7jtXvjGCcDcrRqJOjCYhUM0sXeZ3Xc/O7hdSTfG6k+AR49sVKSLJU1/7Z3CrljacOI4L+TMdFs/15wouti/8uXEsci086GAXEqEyFHcU/OUP4ohbpt7MqgR63HGL9cbblt3EKIycwgk/Q2LFdgo260H/owcYFQ1DcdlIeANtwKJT8M3OG/DUXsFz3nsHxWPXj0q6/8mQQKV7lM2E9kg3Ei5xFAKM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(23010399003)(366016)(10067099003)(22082099003)(18002099003)(261009223027099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVVJU243cnZodHBLVVNMWXZRK1pldE9TQkhlNjcwN3p4UHpSY2YveWJJOE80?=
 =?utf-8?B?RTliMmZqY3U2MnE2RTRVYjNJcDFtZ0cxam0zbjJ6dXVBR0d1RnFLU3RCOE9j?=
 =?utf-8?B?L0lXNXlsT1kvYnd5VTVHSGdaM0kzRngyUTdMbm9KZ3E1YTByYVZvVnJVNkJs?=
 =?utf-8?B?b3FpelNqTXpGV2JaU0VCSjc3dDliNjEvMm80TkVPVjZSRXkrOFIranpqdG1I?=
 =?utf-8?B?T1V0aXo1b0twMEdiU3FZYU1kRFZQbnpiVUVLS0JjUVRiMWlFeTNQdjNRdXpF?=
 =?utf-8?B?WGg1L3d0ekQ3UDY3aCtVSDNIVSs0UW1Xb3J6OEYxekZoMWpVUHg5aXk4OUtS?=
 =?utf-8?B?cHh6MFJIS1BKSEQxd1ByUmlhWkw3K3gwYkQzM0JKTFBOdnF6WU1hQjRTSzV2?=
 =?utf-8?B?Y2d5eEJmWWFkb2dnb0p3T0tjQzVSaUFVMmFGamZSRC94UXBHNzVyOW11Z2o0?=
 =?utf-8?B?VVl3TFB5Q3IrR3BsZVFHQVJ1RnNkUmQvTlFMNjNoRkxSR1RCU1Zsd2FyWlYy?=
 =?utf-8?B?ZThBUitWaEwzSm5oSnJTR2U2N3dIUjR3VmgyR203QnpRdnlsUGNzWEx3KzlY?=
 =?utf-8?B?S1lEeHR1b1FMSUhjUFdRSzIvVTVHZXlxQzBoT3VMQ2dNQVBBVDg5cEdsRldz?=
 =?utf-8?B?djlEWlZTYkJrY2NIaVBEeXh2MHBoTHR4cCtGeXN3RldqWHVXRnBrdEJkQXEz?=
 =?utf-8?B?cGVpRmVFS1BaN1JrS3BUTWZVQUk5dE13TGF0alZXVnQxd0daaldVYStRMkFF?=
 =?utf-8?B?SHFCNUJqWE53M1dNa1l5dkxMWWttT3dpdG9OeEQ3dUhNRWRZOW5qZGJlVSsx?=
 =?utf-8?B?Q09BRnp4V3RUdUVjTHJjTG1uV3c3R2J3UlhLMDB1U3NMaEhaa1FWWFA2NWdj?=
 =?utf-8?B?eXR0bkdPK2M3Qkg0a1RmeVpaaEl4aXg1YzVrcFA4MkMvL2daRm8vNFY5V1gv?=
 =?utf-8?B?TTBVdG82dlBUWmFKZEEwSy9QVUJCSHlER3dwRGp0VTd4Z3orc2V6RHkrOUpp?=
 =?utf-8?B?b2NCZ1lHbWx5OXBDRURwY0tHQ1orT2pGbDdoRTdneDV2TDBMdk9la05QN0xB?=
 =?utf-8?B?bnZjaW1xUTgwY2hHQlRhODZZMHVGNUVhWVkyMDRDSVlpTENmOEtsR3BxUGhu?=
 =?utf-8?B?b3lTMGdqRDlzazlRWVJvTkpEWU1RbE5POVNUSVNWVWdOZzAzbUVSK0QwUmhY?=
 =?utf-8?B?U2hwVXA5T1I2cmJuaUlXbVlpN2dQNDNSUW9QRGxIay92SzdsajhmRytGZ25q?=
 =?utf-8?B?R3IvRVRmYUJlcmZPS2VoZG9LRlVGNmR1SEloanRYMHcwUVh3SUlPZVk1V0F4?=
 =?utf-8?B?NTZRSUlyVWtRc0Fxd0JvMjVpdHlMV2I4MDdXSFZwOTJ5Ump3TlhuYWpjejJo?=
 =?utf-8?B?SVlMOFRleFF0OUozOXhEN3Y5V1lzTFNMbERJVmpwVHhQdkNrSkJjMFNXUjQr?=
 =?utf-8?B?ZTJYT1luL0RXRVUrWXhXMEhabGVFck5pZkxkUklQR2xRQWdQdlFCM1BHeWNC?=
 =?utf-8?B?VGU5aUZjNHk3czJDWDY1RXhtQnJqeDJQQnZiNWw4MWhGbEg2ZUZZVU1jYm5Q?=
 =?utf-8?B?MWRzN0VjdFB0VUlOTVo2TlRDRnNsRXJjbStPcGNCcVZpZzBnYnU0Ly9kejBL?=
 =?utf-8?B?YSsySXNHNUNhanY5MTZNa0lkWWx0MHN2WkZiSVdMN3dNZzBhY2NVNHRTSk9a?=
 =?utf-8?B?bzFGaEZCb2R0QXBKbzNNekMrbnpCbFVubVlvVG9jZDNRdVVEckFmWlh2UkNX?=
 =?utf-8?B?enp6c2oydUhrRkJMUVZmaUJsUlBEb1RGNlQ1bXhUTG9QT2JJN3dqdkNrWWRy?=
 =?utf-8?B?M1FjQmVJcXp2eWhBRHl5TFhlZzNJemg5aGtrOVBvV05UdlIxaEFtVkRxWVIw?=
 =?utf-8?B?UGh3eXhiQ1hmanpwZWZEMnhQemNsUkJRVGk5OG56b2NUT29qWGsvak03ZVB5?=
 =?utf-8?B?dXlZVFk0bVk5Tm8zUnYvSVlIODhuQVVPM2FiMGw4aG41Z3NYQVdSOENNT1Vi?=
 =?utf-8?B?MDY0ZW5TQjlVK2hlcEFEbEc1d2k1UnhxMTI5UW1EY0ZNdmUvY21lYk5PSTlT?=
 =?utf-8?B?VGNNYlNQUmVGR0F1Y2pRdVRFaEtuKy9mTTNNWGVkYWI0Y3pIQTNzakVpQ3Iz?=
 =?utf-8?B?YW1uUFRiNUkwa3I0dStYOTd0TXZLalBOMEl3Ty9DODNHV1U3MjE0aWRRWjNE?=
 =?utf-8?B?Vktqa01SOWZaZSsrNUo5TG52YU1xcFcraHpBVTdOazM1emd5SDJpTEc5SnBx?=
 =?utf-8?B?OFBWVzVINEZWb3N5TzdaNXpXSmxvbjhPbUx0OUREeTF6bGlhVDdKd09BaFVo?=
 =?utf-8?B?WSs2bGwrbStMdnlJbjJrekEzamNENmV0UlAyZE8rZVQ3L0RyaTNlRjJlV1c2?=
 =?utf-8?Q?KSJw+aqcuOibhEaw=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e131773-eb6f-405a-9ef8-08df284b91aa
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 10:28:34.3469 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3HFs9DsiIAVL+QUpm25TTcwZuNgp06LFvNKL+kc87Df1lLgUWb0x45xxaIBq/Mr/Ed10DGyaPgu/oCHfrlKEyf9tewGBxpqoKDzPkaQNPUs=
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


