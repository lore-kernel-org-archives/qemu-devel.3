Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F1AFCA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 17:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBbYf-00066M-Ro; Tue, 29 Sep 2026 13:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBbYd-00064p-N2
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 13:23:59 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBbYb-0002l3-99
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 13:23:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8/w/X8RfB1lgbp+6tJkoClO9tP2FH5a/iLW0Uw3CRaRWmRq4kxBLEl8p/AL9WsRL6dbu9PojL8VcR4R33WBuqeNDV2QLMFv8mQZFHU2Xz3kHVeYe94QXC0tG0N02cn1Df3sYtw69FOv6HNFOYVlhc+rMm81pRMeLsZRmIwEIJvwyJQmvrYsf83uU/qxAKaGj6Bz6TgCOGX9NOijybFrYCF21FnUmwOedCzBiMkIDYBcgdm0HTv7NCmKOHQIGBIW62t+ELDpdeIL226/jpKcSDkYur9D8Z+FLnoBMD3WQjUvtQ1lIr5qFLNL4J19D5DSR0KU3tjLgdB1g1n4+plfVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5ksPgqxpkvwMZR46juSzPb3Jx553hY74OuSgtWMf94=;
 b=v8cPtlDLwyuMEFtuKr/5OFOXdSTFHxOgBbwNiIAwxgVmof3wGJQvBkeI6TucR11+PRDKI1G4Zlob752uozij6LlCrXeYBPv4HTct7FFnYOZ7uJji6Pol8V183G7fp1fGrOToPy/xczZwlJ8NwgDTHiPUe3EANAspkVK5s/z//HWKQ1Q6/zJFAJA3FX16jdV3mHC9v8M2P+VTAx+WYk99jrdJsldArK1vWOVI2s/ytnR6PiwazBxfKMPueA00CWd1MWeJqbyGEvl5OtoooN8CTJt//HE8+7UsZx3WE2TcuzP6rxchPjqPNF+OJiAQ/CRHzWA6FbODBDb26huhNk0i/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5ksPgqxpkvwMZR46juSzPb3Jx553hY74OuSgtWMf94=;
 b=qo6BFJbZH3SfyNSQ1cm4vcAROar77BjZVKrvgt5FzgnsFw0EYzn9z/Dk3/h5KF8lHDGo2wa6e2aYwew5hy+F0d/UxnyaBrJEroC475cfg3s9wq2uZu51+OGMJzXQVRGe46Yyv38PB/rwhTXxCj0o5LsOktqdN7E6BHFZLhz2zg+UcOg66+RJWN2UjmCb/dSSDQlheyVhTMpvHwTwQq9tP8XxWOgesxo4K1JRty5AFM+MbiYMeiSbLWAltNLwvohWSLQpV9LLxVN6LxA2qC/HoESjGoWogBMZROCmuSSpCuWpTSOFr7usNTCSNTW6qw34O1byfwUVVceZLJD3NTK6Kw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB8801.eurprd08.prod.outlook.com
 (2603:10a6:20b:5bd::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Tue, 29 Sep
 2026 17:23:51 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Tue, 29 Sep 2026
 17:23:51 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 29 Sep 2026 20:23:27 +0300
Subject: [PATCH v8 08/17] vhost-vsock: don't reset connections during CPR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-up-vsock-vhost-v5-v8-8-12bcf1c0b84a@virtuozzo.com>
References: <20260929-up-vsock-vhost-v5-v8-0-12bcf1c0b84a@virtuozzo.com>
In-Reply-To: <20260929-up-vsock-vhost-v5-v8-0-12bcf1c0b84a@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, maciej.szmigiero@oracle.com, philmd@oss.qualcomm.com, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, clg@redhat.com, den@openvz.org, 
 andrey.drobyshev@virtuozzo.com, mark.kanda@oracle.com, 
 vsementsov@yandex-team.ru, farosas@suse.de, peterx@redhat.com, 
 sgarzare@redhat.com, bchaney@akamai.com, dongli.zhang@oracle.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR04CA0130.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::28) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB8801:EE_
X-MS-Office365-Filtering-Correlation-Id: be7e7dbe-4211-41ea-4de0-08df1e4e6da2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|52116014|1800799024|10067099003|56012099006|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: XZWNPdiRP2o1XiqonBNb1JyRbgdfDBgTIXETqDpfLqyMgyQ6kZ7CZ+XDqlhJAK1UP4EWeX5lMRA9exNy32sePEVVNjRa3MR7B7nrAsUcsSN2V31vy/0Wu8GskJ+YZumReqqMQ7bi7//9G8CCvwY1JldLsun4gpaU7QfhOa9NkOJdXrIly/YFV3N8FZMzrjqz3LeSnbvs76wdBa7y73JybcSQUqhHcw9A0ScJlgwfWJkpBXZLjbv/uKSKa+xdOTTVcmlWPNifuYd+1sHZ2EMEpUOQi/MSFmQ+EXUiyCJEesIcjcQd+Fk+DO6a7H+/ubwhnWNOWIXxm91VCDq4KUwOYZ8GnTJMmAdT3zqtvLoHVyfAY+C5pVU1MyXUGvAarfRyxos/LmOiU1P11UheZWSWzWPhkUncX3YkRgxuH0yO6ZVGg7P9diQahBg/G6DLP4fMYWNtB80MY+sLyPpbdS7nq51wO1dr+ZwWlIHv0DwiE8OX8+q8469zeNgCKmbFPQrDgcfXh6osjSR71ZougP9KLaazwssAqub4mzBYZoE6W40lzlw+Kl/IzcVD38nv2ysemJJ+guJmp4S2ir+wcRIp/pf9OrZFocyC5NuRpSv3ziBNouj8W7i7V40wWvjqB1l40oIWx7sKOHrzuIv7+2eSAT4Q2vA8crzPUpfm9gRZByeK23M6aPqIUuTu4A5+zBb3tmTUY8XVEwS10VlyjVK+qCey4UfDg7czhmpuG/asE8M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(52116014)(1800799024)(10067099003)(56012099006)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHovQ3hrZVZHdStuL2crM2dGVFZadmJMZy9TZ1o2eGRZcVRRMlh5aUpnbC9X?=
 =?utf-8?B?bktHekdLckRJWWFZNmJWbDJtSUhnamUrSzNBNUdMQ1ppVThuRTEvMmd2Mldz?=
 =?utf-8?B?aGdHNWV3UEhJbThFZzZpK1Fqd1krVmFWVmdQQUVqUFIwWURHa29LTGZGZC93?=
 =?utf-8?B?R3JnWXVZamxTV0dFbE96M0dHR09MaDZUTjJoZjdnMkFLMm14cHZzL1ZjS2s1?=
 =?utf-8?B?VlNNUGhITFdUUSs1TU9pbm9BMkU1WkMwL0dmVk93K3dWRkV6dU80V2RmUFFY?=
 =?utf-8?B?blR0Vm5tRkVNQXRuTkdIZGx6N2diVmU3Tjd3d05HOEJjeEhRaFYvNmFnQmNQ?=
 =?utf-8?B?Q2hFT0I1c1pLS3ZBbzliNko5MDhjWGFVMmhldm5JRUNhalJ3MC9uZTNiZkFV?=
 =?utf-8?B?VjF0TGUxanpNVEdXbzRZNVNveWoxQmlaTTBMODExREhPWHk3MkIrTkw0Rjd4?=
 =?utf-8?B?dSt5NjFzMytSaVRqL3oramxYSWd2ZjhUWHpDdFRoNUpSdS9ya2lTMkhpU3I1?=
 =?utf-8?B?WDJZbmZvcExlekdZVU9vR3NqTzMxaXVCN0dEeERsM1UwSUVUSEp6aExWRVh5?=
 =?utf-8?B?WjRIeHJGcVp6bURyMWw5aXYvc3dDdCtYbnFHdlROZzg0Vjd5cWRycVBZdmps?=
 =?utf-8?B?N0N5a0VHZUFqVFVFeUI2Nmo3NE4wcU8yNmxwR2d6ZHhET3E1aWtSSEhTQzBK?=
 =?utf-8?B?bzUzZUl2RTVLbnVub0U1M2VxbW9SRGhyQmRTU2dQb0x4eEVuc3FnbUVpbWFt?=
 =?utf-8?B?am1UdUtkZWpLRnNLWlVZYlNtbFJVQzM1YjN4NUtCekFQZCtrY05MYW5zaDJV?=
 =?utf-8?B?NUdHOVNkbG5tdGxLM3M1Q1FkbjFzN3pOcFJERENKUnRzVzQwK0xrTFdibzRS?=
 =?utf-8?B?RnI1YXR5OHRPbnVUVDI2bmJKRFN3aHJvenhxUGlORElvTkNhSUcxUXRoQVNi?=
 =?utf-8?B?Y3o2a1F4d1d0a3ZhM1JXSlNtbEl4N1ZlL3pFcENVL3U4dm0ySDNiR1VkNXkx?=
 =?utf-8?B?d2ExTVZacTdKc0tqK0pRVWtBNEtYUlJOOWRyRkgvRTF5NE9uZHB0b0RNb2JU?=
 =?utf-8?B?bVhUY0xjTTc1YTdlbVFQRitPVFYzR2FiZ1F4RE8vaHA4dGdJNTJXd3JZaGJq?=
 =?utf-8?B?eUxLMGRtU0lOdVFBNkYzU044RERBb2ttMFBXRzlieko1U0FNYVkyVjJ3NjQ4?=
 =?utf-8?B?VTNaOW9sdnRqdnFDeVV4cFEwYXoxcUpDOVBvQTM3NFdzL09VOFFUbDVFK0ZQ?=
 =?utf-8?B?d284amNpMFFVZWJORU5XN1Z3Y2x5RXJZbFAxNXRrenN3Nlg4ZjI2cTZrazFm?=
 =?utf-8?B?QnJXcmIwdUE4emN5SkFabmY5MjZ1b0dmaWxxNHd0K3g5VzVYYzV5MmdLczZ0?=
 =?utf-8?B?WWFYTTZPM2duSTJ1aXBHS3daZDVaUGh0UjV6alNzUXh4NTNwMTRyWFpqVmZj?=
 =?utf-8?B?WEplVkZNLzdZN2ZnLytZNytyUDRTSDRIalgrV0xTZmFuN3RkLzR5K0wwNUFS?=
 =?utf-8?B?MFhvZWduQnNjNnA2YzAwU3MvdUROVmlFeWs2K1g3bnEra2U5djI1T0E2YnRE?=
 =?utf-8?B?bEdKWU5FSEdEQ2J4cjM4M3dDalRDQ2xRVVg0cjdkakZyVGROM20xeVo4SHRX?=
 =?utf-8?B?aVh5YUQzT3VzYWVDakkySXJZVDNvZUpTRFUvOE1YanZRSmtiK3VRN1g0dXB2?=
 =?utf-8?B?dDNXMWd1MVNrU1FDNVcwdXR2MkhiNENvZ0NTSkVZWVZ3YzV3TmY0Um5scWtX?=
 =?utf-8?B?d2RER3FiZzZmS1ozY1dRa0xLWXRVd1pUZS8zSjBaSUQyY2tubTBSbjNUckNx?=
 =?utf-8?B?c0ozUEtUcTB3WWhOZmJSV2tZTEo5U1c1ZkcvQ2FEZUpsamZYTTYrVTIycUxu?=
 =?utf-8?B?WVk1TTVEb0YwWGFqWTdCWkZMa3ByamNHSzU2K3FJR25jSUV2YXBGdE1zRHpr?=
 =?utf-8?B?dDdmMnNaUXZyeGIxclFaanlWSlRBL3lvZEJnUUIzZE1mU2t0S3ZqaDhBanFY?=
 =?utf-8?B?d1VTYmkxSVZiSEJkTDBPcHJKeUVmK3FKbzlYSkZQMElXbjF5YWZ4UnpnVThM?=
 =?utf-8?B?azdFQWtaTkdZVkRPWm04UlVkNHZJREhkZG5mQ2g2YjNPaDNNZUV2ekNKSTBX?=
 =?utf-8?B?Sno0bVhqaVZyamc3bWJNbGIxbFlxYkpLWG1VeW1LVW8xeUQ3UFVYbHJ0NHNi?=
 =?utf-8?B?NXUvRzduWVM3dkthSUxoVlRZd3ZUU0pQRm1rTlo3OVo4cjRZdlU4OHpkN0da?=
 =?utf-8?B?QURJcVlUbmNua3NsVm5OZHBOYW4vZ1kxODdCRXlQbjI3R1VvUWZVbGFYWm1h?=
 =?utf-8?B?ZW5mdlVlQXVUM3gxbnNnRUljb1FodExSM2ZiWGhVdHduMFl5ZGxBdStLendi?=
 =?utf-8?Q?fJeJ6Jh+aFst3B/Y=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be7e7dbe-4211-41ea-4de0-08df1e4e6da2
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:23:50.6579 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GkI2r6Zj+rEKfaDmMvtw48eFo7jDCiW6Af97i/gN7iWYGndgZaJKOpZquEhgG3E3qCKSrGUEMpVZz0pHcru7Ke8F/tpPyaeiNDPqE/QaCI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8801
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


