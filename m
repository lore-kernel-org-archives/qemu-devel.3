Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E08C5CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrJZ-0000gC-Ff; Wed, 30 Sep 2026 06:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBrJX-0000ff-LI
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:13:27 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBrJW-00045T-2r
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:13:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJMTHgo/DoejiPOzOS53feOf53n6bCGA0A6YCF127feON7sh9hcJMdCSJ6rqjDLPdpa316SB6Wkhuux0pkz8pde9xYpzvyfRDsLavdGCPicBYButWzwz6zdKHDc24f6CfaXUcKW5It6ZZn5d1Nak8WM9aTsg/ud7Fmuk2nKtZHUw09m0+I5V3SalcYSs18/D1XAIrBFNVWk9L3eU5iPA5tb0MGXdieR3CoAMw1lct32SnaBfpDM92M1NZbA67ymg165EuQmlcziucfkWx1S4k6XQdXBhhZqY1zqz9b5Ste+SMNYIC+f8G4DgpllKpXWbMJbJ/AjxuUIJTvJzV0l56A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXgQR79hkZDDfXuHJA0otbnU8q3wx4xJTCQyzRPPke0=;
 b=KeRuDByzVvhhCBtNlMAj++BIUA9blU5BNQQ5tdM2Q5yT1/AzNenzlVryuu2M3hctYW6lw81r9trAYTJ1pjIobhRfaAEmi7o2XSMVgq+sxNCZzSIbi6PNTIKAoQnM9yJJ26Ia2lcqSDihzP7JrIBFob2lwNeVrGvzVZl4cUIU3zY4sWaQ8PgwEo7hc02/WRFvjXisDPnUC0fYxouujCux8kPItEDz9afE2CHQ79ljpsnMNRTsi0aGc0pql2DUGYlRFkif9QCmamdCWzSLqc9ONvbNPz8E9/v6xiDtHna5ctvlEQbGjKF+Xv7i5zLATyFf4RVVk/Bv1eMsFTLKMvRqZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXgQR79hkZDDfXuHJA0otbnU8q3wx4xJTCQyzRPPke0=;
 b=DXvmWiVnHby2WlaPR69mnxVnPLiTcxu2RQrAoGoFFAB545u8hiKtnWTNC9Y7rDWLtDybPzm9tcGlzQZN2NjrFgx2heSQHn1YbiuF1x9DhP+vtfCEY7bcX7hOuEpE10TlDx4RkW/GhKr/x1E7Kd15/HZ1ZUufR94xy7qdXklHIvRvcLk59uj4ytyCrpubSc0Azeua3B/5uXIWgkjalWyRScusGYpz+49sS12HuZmMt9GwcC7PL6ORnfjCxph8RMVtGtQNdmw36ToN0TtilNP9nZXnxsvlSNSPWyUmcIxGq4fUE4uz7AjuiBVoPKK49GX+eFhpJK5qqMBKGpTcUnM1Aw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM8PR08MB6420.eurprd08.prod.outlook.com
 (2603:10a6:20b:314::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.9; Wed, 30 Sep
 2026 10:13:18 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Wed, 30 Sep 2026
 10:13:18 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Wed, 30 Sep 2026 13:13:02 +0300
Subject: [PATCH v9 03/18] migration: forbid snapshots in CPR migration
 modes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-up-vsock-vhost-v5-v9-3-e9096f629770@virtuozzo.com>
References: <20260930-up-vsock-vhost-v5-v9-0-e9096f629770@virtuozzo.com>
In-Reply-To: <20260930-up-vsock-vhost-v5-v9-0-e9096f629770@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: andrey.drobyshev@virtuozzo.com, clg@redhat.com, mst@redhat.com, 
 sgarzare@redhat.com, maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, 
 bchaney@akamai.com, philmd@oss.qualcomm.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 farosas@suse.de, mark.kanda@oracle.com, dwmw2@infradead.org, 
 peterx@redhat.com, vsementsov@yandex-team.ru, den@openvz.org
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIUP296CA0066.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:337::10) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM8PR08MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bd9b1f6-7203-4937-24e1-08df1edb72bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|23010399003|366016|1800799024|10067099003|56012099006|3023799007|5023799004|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: hG3L9Qk1zFsufJxtFSbm7NccEXXEa2GlGnuutOFTWS+CUyXyUlTTowC9F8brvmFQQPRf2a6UUnXWB334+TPiir2CwSw+e2b6YVBxkpn4xKV3RSRff+Wkqp/SxwHzDLx59WP/q0xAjC0Hcs4cs8kKlQKlVMehp5vJ0fddbz143aiOhwyqwgcuD6T00BCLG+7hWuBa2t/mFXSR20Bk5bYy3hNFkAib3c35rl5jeIwNYzCc1gI+Fv1HUy4sZnOc7T28iOc4JTm/TsOiyzTLZkkffun4CnZ1bvDyYxjtdwXwwzntN3kj1TeeLc8ZNqdY5dpVx4i6qd5/aSJoS8WL8+j6Qzjp1rUqNfWsirGK8odNvED8RxQDjOhbKzkwWz8YulYArbaJG0SdUoFg4q7pIhR5dS1qwNB9c4s2jNe9hhISneZeiRHct49HsMWE0Ay7JuPujtx7jFDAy8l6txhZDHadUq0lgNcEoEhYu/0Ns8iyY48w71xj47nIn4lhKK/VZ/s4hGZCI4IwzjNCsXlDMZe8KxhD4jbESqWQEmsGyCN7msL9Wma0bnL8Bt9eAlHRoHAzkP8iA3/QiyF8RwGBVDCL9pDYoCcFPrIrxcD2gZYk679AbuprnnWF1Lj7DTRhbt2jmjMa1Lx09ywIxx30js7Z2R35OqVDIcCygvkeZwbr2QWhZRGBqXqelPHucYGtYPdaFEIelynsYi3WxKHZpybH6A5M6aMJS8s9lCVVGZqhBmY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(3023799007)(5023799004)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uy9ZSGp0S3hhY2FxK1JVTkZudXFiaEpXajQydjUvdUtCQmY5anpDUEd0NWNK?=
 =?utf-8?B?aUxoZmtqSTV2VVErQ1B6cm5rOUs4RHpKTnZwSmVWN1V0b3pObldTYjVPNTRL?=
 =?utf-8?B?aUZJbmlqU3k5TzN5akQ0L0IyWXBRZStPRnVZdVlqRjcrSWkxR3pBcnJHVjlv?=
 =?utf-8?B?MXdEamUwS1l5dDRPcVpyV3g1Q0wrb1JIM1gzamRGbjd3clNadHZ3UnBpbGgz?=
 =?utf-8?B?VHZOeFUwRTg3TkpUTmYzNG14ek9YQWZEQm9VZlIzRDZ4ZWdvaFBDZC9IdE5F?=
 =?utf-8?B?eElCejFYYm12cTN3UzhZTHQ1dUFwdVJmSG1nQUoxZllsZUUzY3ZaU2gvQUtm?=
 =?utf-8?B?MEw5aG5Fd2d5QXNOUms2N3dBUXF3RTBoRGk3ei9nci9wamxYVHVzRDdPMlpz?=
 =?utf-8?B?dXlFSnNXbW1wZU0wdC9LUHEremd1Qm9RV05FYklXVzNIcU42RGlhcEc4SWlI?=
 =?utf-8?B?SzdKQjJ5U1cxOXo1ekh3K3l5SFc5bVhsbk85SW5LNnE1WG84SG9mQk1rTTJq?=
 =?utf-8?B?Uy9CajdDdWM0b2J2U3Z0cHIxSmFGVVVHNmJHL0g0VVNFRHJIWjJxbDV3V08v?=
 =?utf-8?B?Mmt1Nm4vNHhpR3ZvNGR1L2FYVUV4cklZVWtXSjE4RkVSSnVKR2tvOU1vOFp0?=
 =?utf-8?B?cnl5UXFQb2dtTXkyMXRvRjhUZFdIcitXRGRvQTVtZkI1QVIwMTNiM1p0MExq?=
 =?utf-8?B?blh1alRsU09zNG1FZGM0M0orNCtkTW9sZ0I1S2JVNWhvdi93akNnVXd2Tnhw?=
 =?utf-8?B?UFpNTGFVbnZtQnQwRUZkOE83RlJJNnE4MEVzUzl5WDhEZ0hnbmdXREQ4S1g4?=
 =?utf-8?B?MlJUQjh4L25UbUdjUHM1bms3Nm42aG5IcnJkMGxPR3NRVm1ZWG9LYUl2TERj?=
 =?utf-8?B?WldGamgyRlR6UVFJdGtNSkl3UktWb1VhOGtFdXM2MnIyOU5FNFBYV1h3UUtY?=
 =?utf-8?B?enQyNXBlcHB2Nk51UVh4eG5SaC9JVUp3bXFwbytUOGhkYkY3MTJoMktBT2VP?=
 =?utf-8?B?L21BK2hzZTZMZEdUV2ZBM3dkUEl2UGFEcEQxRE12dXJxV1hWRkFsQ1pnRXBl?=
 =?utf-8?B?a1hWcEJiSS9kSFVKSU8wMEpqOEJ2ZjJMaERlZitiU3Z0MzlNWU5SLzVGanB3?=
 =?utf-8?B?aW8yQmNJdFJpSkcyeHFwTFFUcy9NTXE4MUQyMFJ5WWFqQmZwZFdCbnlMQkwz?=
 =?utf-8?B?dTlhUnVuelV1VDUwMGg1cEY0Qlo3UHlDclVXWmxwdlZHQXp2YXZBUm1XYXp0?=
 =?utf-8?B?RWhiZjdwMkdOTnlzVmN4T0V2SXBMWXVLaER4ZTBKc0xiUUdYdytWVEdaWW9w?=
 =?utf-8?B?STJZZUs4aGhCcVpGRU9EVVRBMVBiK2ZXWFUraGxwRU1oek1GckFsVXlTcW10?=
 =?utf-8?B?d3hPS3EvQWdaRnVkZzdNRTZpbFE2UEtRbCtsaHFYMEpVVlZMRGk3TkVYOHJq?=
 =?utf-8?B?eDJEbEpUdEhXVXBQQ1F5Zys2c09nZGdBcmhlbUtLNFZiMVlocGIxa3VZTzFB?=
 =?utf-8?B?MHFscjdHczVXS1dpZ1dqdGgzZnZKK2kwWlMrMVVyT3JheFQyOUJNekJROGRU?=
 =?utf-8?B?TlNQSjJWSjVmeVJIRzBJN2lhNnlkYlkzazdaWU5nZGQ0SWZ1dGhpa2hVVktn?=
 =?utf-8?B?TzJ4RllJTjJ2bmtva0NWSGdHc3FrM2Y2TTY4QmJLdzZpREgxRkxPSld4OEVK?=
 =?utf-8?B?dFdMNk9iaUR6aWlLc0F1aGJOZHRTQm0xY0pzaHZhOWJNSXVLQjVZckxIeWcz?=
 =?utf-8?B?ek1wT0lDUURROUk1MStUY2RBU1dSNG1oWXJDcnBtWXluT3JiNXo5UmpkcWcz?=
 =?utf-8?B?SmQrMFRLdmpPdDY4RUMwQm5ndHBRdUVrVkZHb0RkcnRFMXpwWlJQS1hJdFox?=
 =?utf-8?B?aEt2c2YvS1ZjZlFBNm00SEpCTlRITFBxa3JKcStOK3FjQXA4RzZRZHd3SGFB?=
 =?utf-8?B?dkcrYjhOeUpwVVB5KzNYVTBGSnlZSzAxb3dZQi9BTzJ5bUlJTU9Jc3ltTEJI?=
 =?utf-8?B?WDYwTklDZnJGSk9WY1RaOGhENDR5a1ZLQ0dVRGUveTJ3V2orbW5udUdsbktx?=
 =?utf-8?B?dzBRWHk1SzlZTC9tcmw4bVFYMjNhVCtTKzJwY2pwUS9CUG5HMjBHTEtCN0tZ?=
 =?utf-8?B?SWJVYXhScGhWRkczd0gzUnIxT2l3Z3JkdDdsTlZjZ3JXbE1GRk1rT1ZUUFVT?=
 =?utf-8?B?cXMvc21raCs4T3BVRmZJL2Z3bEhyajA4aVNjY042RDI4WjNrUDdPVXVROGEx?=
 =?utf-8?B?Z3RncDVuWW5Kd2ZHN0x6eUFjVzg1Rm1SS3dVZFpsUUdLcUtmL2dUMjhWandB?=
 =?utf-8?B?V2RZUTExWWJ3dElLb0ZKT3pxRUQyTnhyelZMUFlSTm9jd1dBN3RpRnlkUUc1?=
 =?utf-8?Q?HxV5wnUm5e+50sbY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd9b1f6-7203-4937-24e1-08df1edb72bd
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:13:18.2929 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QnamE4SQTd/C7V1YRYFmz1gtYE5GSpb21KKJpHPIAH4h1tmspfLqoiLk8bMcRfy5Lk/bt2poEhsG9P6ppNTPH8Wn60vCCJBhNd9910GPiVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6420
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


