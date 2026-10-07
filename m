Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2359CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENwU-00045V-Tu; Wed, 07 Oct 2026 05:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENCF-0001H3-U1
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:28 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENC9-0006kK-6x
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mFYz6kcljk8PhdgCzIyxnuFNRprCqU/TkvBs42KZrO+d+QQF0eYA7vUWOWOzT27fU0XKO5AZ8yU+BwUbS1HlzqMYThJQV+VJnTfRRFTi/+A+bFDPmilzR6VfP0mNoYr+dksGI+ZqLWygjLJgEcEYp/tkSU4oRqRCa5U/xpd1n62VKuOchlgBdi+4z8ZlAkEB17OmrLmA+3sQaY4/zzPOJeTUUB5thv0PdOk3aeu1kpjvdnHs3Yw2D7EAvmOyZ2JnF8fu7NOwLiVZlYCoszeaIFnV0pkAzlfOuQLO5V7AMZoEgzIIA4+SZ0oj6RYM9BBynjkYWsIhDmVGgeGiZNKghw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5ksPgqxpkvwMZR46juSzPb3Jx553hY74OuSgtWMf94=;
 b=PQiNthc6bNWQaNICdIub89JRFZ+jhHa2biNljIBbtR7tEqaNrTL3EUsf6DCnKb9P0TB+D+C2gqeZTeGqNoPg3JSBoqwzAwxjTOZ29ByVSOcTwvk7Nli37nyv3z99CKkZCARK3Csa64eREVXlFPpTBmtpMIe4JoSzhmr6dX9pzuIyVkvLV+QaLYWHKl2T3sDVe0/bNU+09CeRanKhCTZ6W4wwocjeSAKHVeul33bnsoJLZZV15rYGy5K551hTR1ZRTgIpdOD7N90kShl7Q820tgnw5wLedDs0osIgF7MXO+ijDWONvSAdvufztDU9JxJR5GcbDsI5Kh9UQgnyZRRUKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5ksPgqxpkvwMZR46juSzPb3Jx553hY74OuSgtWMf94=;
 b=hppc7euubkoa2vAbIayovs3cil6gDYKP73WS+LVZHtMNVJCZClCCXZulY/IEDmX32ljATfWVr0qY3K/HXBI41bXIxJ+UALYpyWPFOdEpz5vnBs2ogHrhTPx8RzN4/TTn1eC4R5ycZK5OeoJgsQ+GqcMkeD2AKZK65HSq5n9rhcJ08RjUyTQspPSEHgdUxyrgCatcg7yzvKbuK6ietvHWImJHR7KBJg8p86GfTC6K5eXo+ZfPtcEkok8KDqtgkkuf+jZnCIH3S4nYBMtbfAdiOZWjXSdx37e9odAIKEnmM/vIFrgTZjX/GSkjLGHN29QXdnHylsiig+vf8WxBnLQ82A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB3PR08MB9058.eurprd08.prod.outlook.com
 (2603:10a6:10:430::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 08:40:03 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 08:40:03 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Wed, 07 Oct 2026 11:40:01 +0300
Subject: [PATCH v14 08/22] vhost-vsock: don't reset connections during CPR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-up-vsock-vhost-v5-v14-8-e16de9962df0@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 85e6a304-8bfb-40a3-34cb-08df244e948f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|23010399003|366016|1800799024|10067099003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: PgBXnzjKKhYTIQv9JP/XGm1rn47NgwraaVHopCHoeFci8UERh8gh0tRkt9O1SZBY0DdQ07IgJ+1PeQ3uIgjOiyWEgaiOhIiJrWn71hZcOOwZyJrlEmdnCLiEQxL74r+N9pke5qvahxConT8ae6TNMEa+xYeX3JHQT/MtJ06AbPADAM0rBBNESfdkiS4XYvjoXWYPzbTc21Cf9Gi8hQbxjKGYZlPNJ1C8pS7fGILMF7bL5hbPpLfK5UQXcYHcIZ/GUvJWyiNTAx5bhSvf0hoIFbI05AqKnqJgaLsvEJE1A6mYbAi72K4He9mSDO75vxKUTzPNNu/loXPxqWprGBv1cRtm+ySDoTKgv5t2oEI3p06PnvyBV28z1o/CaNq6GFTI7siYLk4/fM/x+0cL9D4d+sH+sSktSMkM8atQLFGfcRVwi0Arv2oxpT71HXU/3N4rUY33sYYk1xpJVQEMWb7/KvN0VU6ZcjJJkHAt/F3WTD53fA0oKQYwAXuwD6faAOXwLp2QCNIcZEd9AL0NR1uCzi7JU+fI4tNntDImNeDSBhRg0+GtiF17T0HreWfD/+XMhZxnPgB9s7gb0gfmzBhMMbSZf2P/s/Hbcqa8ZPTOolCnT7/mS7R3KO5UTA9ycZKTAvH3R7lAq1CacQNLoFV9xvZG+pumuJ2QlL1cxNYnPOs1Ol7E+kf3YTuzq4cIGK1K5D+SEq7iOX6O7r2kGSveSufhK3gRZN9zjgY95K8bKLs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTVqUVZta3hxNHNLeGtNR1BXWUlmb3l0T3RWdWp2d3p0TVlUYUlPa0t2Sk1O?=
 =?utf-8?B?bmh3RHY1YjFTd29ROCtuRU1WaDlOLzc5dTRGVzR5WjJqZnFnTUQxMDQzYmRI?=
 =?utf-8?B?RWU2ZmJoTFJnMHRick11NlA5WG55eE9Zdm1pUWRYTWFWcTk3aEVDVUVaMkpT?=
 =?utf-8?B?QUpyZldGMjBtWGdJMW8xd3o3azJQOTRra1hZSnRxeTl4SVZ1ajhTZGdySnhx?=
 =?utf-8?B?QzZLNFVGaXRMbkk1TEpiRDJ3dmZOSE83TVhURGV0WVBYTnNsMW9KdFBVWnFG?=
 =?utf-8?B?RDZja2RMVzlUN01lTGlycHZwU3NZdERlc21IRXI4U0JmY29pSDlmbmNVa25n?=
 =?utf-8?B?QVN4eWZuUHJ4SGxqalROdHlpeU44UlpCdk1VenJ3ZEFHL1luekZaaU01OG41?=
 =?utf-8?B?T0FHUVNSTGp1ei96dlYwalJXNzl4d2NNbWNWa1FQYUU1WE5tOENOZGNQRWs1?=
 =?utf-8?B?MHVDdnUydmJXVEJrYW56dlNBSG5GLytjWDJZTk9ISDhDWEhvSjdvRVpoU284?=
 =?utf-8?B?WXgxNVUzV0dNWW1uT3JSZXgwb0NZRVludmRMaUlpTlVPMkh5N0d0RThIbElB?=
 =?utf-8?B?MUNVMmxPM1hLaUJQTTltYzk4bXJkbFBQOEwraVF1SFZoK1liazlQOHlrTmtn?=
 =?utf-8?B?NFFya056OHNoK28vSjNSck5PNUZKTklVWFdDcUtITS9LRjVtYUFmWWtlNVZJ?=
 =?utf-8?B?Smd2TDNUeVlFdnZNWDFlb2dpTFdkWHNDRVE1Wlc3RWx4SVB4cVo1UGlscTRY?=
 =?utf-8?B?WGlhZHhUd24vaUZxZWY4MnRGU05XQjVUS01CVTFtZzVKK2VQd2dKaGd5clNi?=
 =?utf-8?B?ekhEck82aHRESDl0dE53dzBSQ3NqVjAyNjlENzNCSFU3cFhXd2JaalVrcGNm?=
 =?utf-8?B?alQ4ajlybG9tbEJRRFZxYTFZNXRRdWk5aktBalVqQVFESXp4V2VyK2JiMm5W?=
 =?utf-8?B?Wit6VXpua2o1bHlqL0Nrb3lWQ1VnWStjbTdlWitpSlo2ZFVOeHJWdjdLSlVt?=
 =?utf-8?B?a2RFeDVnUjJjaDJxZEphaTNhSUZRMkhvdW8xZGFvMlJkdzgzZmw0ZzN3bFpN?=
 =?utf-8?B?V3hYQm9WTktSS0NPOHZGTm5jZVVNNHRYQ0prSWlLTXVMQmUwa0NJK2s0QlNZ?=
 =?utf-8?B?a29CY21Fc1F6eHlCSmRlS0N4U1paZFBUZk1WcVNyL2d2c1V4NVZRM1VuS2M1?=
 =?utf-8?B?RWxlSXhOeUtITm4wTmRlcXY3ZG52dzNIN1lidU1US1Z4M3RGTi8zQm1OQlFJ?=
 =?utf-8?B?VXBEdi90bVVOQXFvOHJBczh6R3NVQ01ET1dTbWlxSXI2eFJpbmFxV1NpWW1x?=
 =?utf-8?B?NGY4QVBmVXlmVytlaW1sdUU3SmdxTVhkR1BMYnBnMHdsdTFjTStBeDBmbXl3?=
 =?utf-8?B?SFdZY29JSlN6TUhMMVAzZHBTTW5TYXcyNmc3U3R2UFNxbmVjZks2RGsrU3hw?=
 =?utf-8?B?Tzc4NmFjUTdabnJIWVdGOVcybElZcU54dDdsUlgzTDNxb3ZDY1lGSHVQVk04?=
 =?utf-8?B?b3FSc2Vpa2p4VDNldERETHVsRDJCUGp2c0IyZ0NSN0xpb085bXB2Vkd4OXJD?=
 =?utf-8?B?Sk8rWHYyUXczZ3lzQVJPNDJnMWpNTEV0TGVRcVN3TEExNXlqTDgrT041SHNK?=
 =?utf-8?B?RUpBWFJqdzJBV0xYalJQd1BiWkhrMUdkb0kwM25oZHJxYU55blBWRVRpMXZL?=
 =?utf-8?B?QXRyRmJpMXR6TnE4anNUSnhHWmczUDFCaXlaTmJCRzhBY0pkek1qTkNrRUdY?=
 =?utf-8?B?aHhGaGJxZDk1WnZoMmNhdnMzckp3UGZ0Q01VVTNCTlZyUjR2a3o2T0pZMDFi?=
 =?utf-8?B?a2xCbDVoUjNibzJYMk4zUEpsaCsrclRFbFExTVp2YTJPUm1WVWVMWXF1Zlpi?=
 =?utf-8?B?WjZXeXdwL0hQRXhWUXNaVWxhbTYwK2FjbklBaktVVzAwVVpkUWFKYlJXUFEw?=
 =?utf-8?B?amlvNG1IOGFTNGpoR2NWMEJ6MkJEdWlRR0FiSTQ4Z1gvb2NhNDVaMUlab2JR?=
 =?utf-8?B?ajRHbnVlL3dwRzJ2Q3NyOW5jK042YWFMWWNjbU9EZy93QzJaMHR2bEZpRG5t?=
 =?utf-8?B?eTlIUXFvMVQ0bWxHVnBsTXFJcUlmMi9NNkpTeHlQTEI2MitBUXh6MkthdkUz?=
 =?utf-8?B?eC9sdWQxTjNtVGI0N0phSWU3WW1YMERoN21VbVJ4NFJIOWorS2pmalFPaE1v?=
 =?utf-8?B?SEZqNmNod3FZa0t3WE1SMG5jNTdDTHMrOHh2a1RvOVAxclJublYzbEFMM2hu?=
 =?utf-8?B?ajFyajV4RU16ZUl6WWhXWVdjWDRGVzBweFBFTGNRQjdyaHVud1lwQ0c0RXhL?=
 =?utf-8?B?Qlp6YksvZnJDdlovWVpWVXJNMlJhYkhydmdrODlERUIwVjA1R0FMWWgwYVpQ?=
 =?utf-8?Q?+dS3R/7QSnqcJMkU=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e6a304-8bfb-40a3-34cb-08df244e948f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 08:40:02.9688 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zdAt6Ky1SMlvcf/fcLJq2tjsoksywnFIpxcmXthayo7kBYhdz7dtmdQTKWBTm05tm18Z3U48DsTfMZNPBArvhr87Edno/OyRwQQjSptuqzk=
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

Migration target with a vhost-vsock device in the .post_load() hook issues
VIRTIO_VSOCK_EVENT_TRANSPORT_RESET event to the guest.  This results into
the guest tearing down all its vsock connections.  That reset exists
because after a normal migration the cid may change.

However it's not true for CPR-style migration.  In this case cid remains
the same, and we want the connections to persist.  Thus, let's customize
the .post_load() hook to skip the common transport reset part in this case.

Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 503d248a617..c582ac9fcc8 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -20,6 +20,7 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/virtio/vhost-vsock.h"
 #include "monitor/monitor.h"
+#include "migration/cpr.h"
 #include "migration/blocker.h"
 #include "migration/misc.h"
 
@@ -110,6 +111,20 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
     return vhost_vsock_common_get_features(vdev, requested_features, errp);
 }
 
+static int vhost_vsock_post_load(void *opaque, int version_id)
+{
+    /*
+     * Only reset vsock connections for non-CPR migration.  For CPR the
+     * guest cid is unchanged, and the cid-change reset would otherwise
+     * tear the vsock connections down.
+     */
+    if (!cpr_is_incoming()) {
+        return vhost_vsock_common_post_load(opaque, version_id);
+    }
+
+    return 0;
+}
+
 static const VMStateDescription vmstate_virtio_vhost_vsock = {
     .name = "virtio-vhost_vsock",
     .minimum_version_id = VHOST_VSOCK_SAVEVM_VERSION,
@@ -119,7 +134,7 @@ static const VMStateDescription vmstate_virtio_vhost_vsock = {
         VMSTATE_END_OF_LIST()
     },
     .pre_save = vhost_vsock_common_pre_save,
-    .post_load = vhost_vsock_common_post_load,
+    .post_load = vhost_vsock_post_load,
 };
 
 static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)

-- 
2.47.1


