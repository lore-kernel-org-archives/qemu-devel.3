Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03A9CA6007
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 10:26:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xElKF-0003Jk-Ct; Thu, 08 Oct 2026 06:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElJw-0003Fc-Lo
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:25:52 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElJt-00014o-5l
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:25:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R4+On4e1IzC0IadbYOOVhXfSdIqZptfAZwQBVHhisVgOJv8zmPhjXSCDHn6Hd+BHKnzkhkDkrherIpCfxDClJK+GO5+LKtU4cAbl+RkGWwFTA2OvTmcuWCePCGZAmyuCFNke2kJfyHG5azIrftlWL01Z2sE6wg81rXDG934D61qIchysdJxxZbH2XC0uxqSYLW5HH+uusNJt7lbVUgYk5fnpEI7S+d6D7pkxX14f9K/drf0hzjbqV2B0Rzp7ZNYVT85AJgUX4KpH0neolij3sSaKWlo0oDJ6CBXgpZmvzM2mV+Zgzvb8LmlcOQz8bvehP8OBa4rKfXJ4iAuSwN/iOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWXhh68le3RfUJjypRVq8x/GzIl/qjsOycrfUzYBtG0=;
 b=M/JZGTlWfPqJpoc5h7Wa3Mz1ZaXKMUGLq+UVbs5A1YCmSwedMutjr3OiKylyNPyRUOtPk0Ej831EwuvgRqCz/IPzGE1VDQQIY5I9O7NVzAI89WOc+FzqdSadGeW3cl3SdOT/ynWjrpKWN6Er3UPBfbN2AwqXhRs8dz4f+g4bEAkQEPNZ22h6Erdpg54lo0vSYH4oZMkXWYq5LMwE/ECqGbC1nPRQ32/scHHUxBOkbGkuXl62fM0Pe2PAcBQVO2WV4NZ0yTfFRM5CDnKwVby8iZu6WVWbw4jUKtDzM7+phuhODguTf0sYnoGmk7NTvgcirivHPee6FLOvNegv1aNwCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWXhh68le3RfUJjypRVq8x/GzIl/qjsOycrfUzYBtG0=;
 b=pvR3ddndXUMFOAVrK4xTL1Uoe6i3CUdzlVQWdIZe7Bxbkcc1YAiW2oPNA9EVfspd/Q6p2QmCqXVE3kLICR5aNVpNzPpVrnL8ISLPV3s8Mu2lN4LUXxFpfhgLr0xMTyLndPMM30fnBOq35VkHlqfQvAYMgCjo7lSe2hzOEOYUJKapeneyG+9Oxur9MF4sPeHcYnwa1Ovq3MwR4CAiZc3QZbtUZ/w5N+89awaalBTY4hid0bYjSd9VDZDRTku4CntQ2p4spmLHmJL9R7Ycl7yNW5JuiQKYI3DBFATpyXkwdfUcsqfHaIT8AfNWz+LonUyHKqFulElZ+Jm3KMqmSSwe/g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB10270.eurprd08.prod.outlook.com
 (2603:10a6:20b:637::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Thu, 8 Oct
 2026 10:25:44 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 10:25:44 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Thu, 08 Oct 2026 13:25:36 +0300
Subject: [PATCH v15 12/22] vhost: make vhost_dev_cleanup() safe on a
 partially initialized device
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-up-vsock-vhost-v5-v15-12-301b73b3f843@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9ca77f5d-bb2f-42a1-42b8-08df252680c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|7416014|52116014|10067099003|56012099006|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: 50Qq0Htxf6vEys6xq3rpDyf1KYKAXBhQT6O8+AKLSF5iUniXoTJttcp85T+X7xBzsbRoGicYt78W5Ukw8dfUow7SD3KmK0FXNCXu/3AAMWqRYtt+AVqyrMGj95x38NjBOItiIIc7AupsD9EOeUFhWRzhHoqCg6XZTNYRbwdJe9n9htTGEUQaSQm3P4yuOXLZ6f10TsUswyTDJg5xa9lB2Csv8Lvq9KYYRFGFnIkvY82tsoGnfGWNHIPJa6gThl2msc43hCBGh2YeZbDdR4hF+qCkuW7bMzI8ezFM+GttkMQC1vDkrXAwfjLRpclA66OvhlXOezKNod6vQd/9/BKw594G4jtlWlbqniIJwXDKp6YChQmWAu9KvCq0jbFw+3kREy5rRM8zuKiGkxojeZOxx+KcxkhTKxiifxAoC/0+whS83ig0uwIotyeb9j1MLeo7LySz6wnVHlRSJ4K22KbqGmU95g+VROqo8rCEQIMBPSesHoQdKLvqGUihg1qgu77V1Mo8RZRFv9O5SUq7KxsPnVJjhf5mO8RS87+vvn38tGDNee3ooPwUY9Jl7pb1kUqo5vYsp1wnHVmp4kPDOZM3MSWvvnn4b76UjwzUJTelNMu3WSDGtbnHfa4Xt/F/NQx2ldJk77NlC0FD2aLCXIXozQfCOZiphZN/+z7CkaJB+CoDn1AZ4Gk3SA7L/DZ5Nj1sW7ahAY4wtqWqTZJttlD6OcUJpnv0YUhtAWY0zeEnO0s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(52116014)(10067099003)(56012099006)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MExZdGFhQ3M3c2xGOXRpbFczaklWd1c2cHF3bGM2NzlEUm9xNFpyYityM3pt?=
 =?utf-8?B?cW5WaWJOOG5LQ0RoSUdIUUtaNlNBTldtT2JHWjYzQUNIWGgwU3JLNXJQU1hU?=
 =?utf-8?B?MXdwbFUwbHdhM0pxTlA2Y01USTZSUWJ0bXZsWnoxSGlXT2hGaWpESVRMNjdj?=
 =?utf-8?B?ZjhiekxWNGRUdmRPdGMxbUVqbHlZYjRYYlZqRklQN0p3R3AyeUl3ZWEwOTU4?=
 =?utf-8?B?UWZReUluckhydzdTajJEclZQZGJLSU9KZWpFaXhJRDhvUWJNbWUwS3FyRUNU?=
 =?utf-8?B?dU5EYXd5YUlaSDdaWTZuTHZnNk5PVmJ2T0k5czc3QnAvYTZkek1lSXJPWkV2?=
 =?utf-8?B?MXJXbEZrbGxKeVdCMEFJZWp5Y0owVDJienNReXZsUEppZHh1VHcwZWxUZko4?=
 =?utf-8?B?QkRCWmcwVkFHSm82QlBDRlBYT3BjenhWYUNIZHpXVXVubjdmSmFnQUpJUkIw?=
 =?utf-8?B?eDVYamNnR244NXpnUXdrS1U1QjdQSVlZbFpGVnVjWE80ald0bmJteFRPczZ1?=
 =?utf-8?B?QmxKblAvNTlGMkdSOWFjQ0RJY2NHbUhvWXJnMzBpTFRjMEVsVTJwUjV3M3k0?=
 =?utf-8?B?SEZ6T01ON3c2eFZkN1VxWlBwclAvTWFBMFhBV1lWQ1JDekVDN2xuZ3RNaUdn?=
 =?utf-8?B?WVFnSktyV0Zrc1R6QzdHeW50SG1TSTdhdVQyWE1RckVWUEx2b1JnTksrWm82?=
 =?utf-8?B?OE01Y0xIV0szRVZaV2xpSFZIWUxXbE56UkdHUzlmdDFqeVorU3lHamM4Ym5P?=
 =?utf-8?B?b0dJaTk5VjZLdlArWklaQzJrNFMzVFNqS2dMSkhtb0s3akkyQVpEVU1DNjZv?=
 =?utf-8?B?Z04xQnJsY1N0TUNYdERYbVZKaG1jK0JDYWZ2V2lDMjNDVmNkMlhZcDZpL3NP?=
 =?utf-8?B?ZjBsUzhGVEZaSmxFaXoyVFRiTGdQN0JvSW51aHV6ZG8xemRFZXBSUXhRMlZq?=
 =?utf-8?B?Um56VE00Und5dTROYUc4cEYvemQyams1Yy9xWFI0QVlkMHluRkVxQTl2MW5k?=
 =?utf-8?B?OEtWaXVRcG43YTluc2dNMHR3Q3o4MFhVbXpmZFMrRXpHSFA1S3lZMTQxVEdP?=
 =?utf-8?B?UUQ5TlJEYXhvR0t5eTRmZGxHWmRvSU0rSm84UzZtZDhFUElLeXBEdDhNRDNQ?=
 =?utf-8?B?NG0zY1drc0dlZXo5SU84bllGUDJSSVU2dWlMTmJqeFJnZDdoN0JKWnA2eGZI?=
 =?utf-8?B?YjMvTDdWbTdNamlmWUZnQ2l5eTBMd1ZMME0vZ3hpb0xLSEVWdk1FWGVpdGJH?=
 =?utf-8?B?RWF5MXFyeTI4YjhHWG0xSHd6MThDWjVBUUsyelVEM0FOMHN1czZyVkJXWFBY?=
 =?utf-8?B?Zi9VeDhxYVhnMU5qazF1a2pCVm1zR0RxMkM4ZXEwZDRVMHlZdjl1ZC90aTJi?=
 =?utf-8?B?My9sb1VzY2tCK3JMSUZJM2N2QW44cCtMblFVYi9ZMlJqS0hOS2xJRUVCejNV?=
 =?utf-8?B?VkkzR05BNktHN2R4R1ZKWlZSRGNtSHloeDRZZWY3ZHhLY1d0azN0Tzl2MGpQ?=
 =?utf-8?B?NVQxUTl0TUZLU3JXUEZWNWNiK1Z1YTJic0pHeW1LVi83SnlSZFpqMXpVR1FX?=
 =?utf-8?B?UUlDN1YySmFHSVBFTmIvM1gyNWFqdlBOSUM5TzU2QmFKQlNkY1hONEhhNXhF?=
 =?utf-8?B?d1J4QWhoQ2Y1ZHhJMHE5REJoQ0xlRVprTWRWZG9kc1hqSXo1SE9tcFJ5KzR5?=
 =?utf-8?B?R0FnMlVBamh1dFh0WDZLMzhybmtycnpiQ0pZWldocWNmbVNDeENjd2N5VWFD?=
 =?utf-8?B?VTZSWmhUb3lFODhBTFIzRW10Z2UzZkVwSE91RFFDRUUrOHIrV2lOM0JkanBI?=
 =?utf-8?B?N3hjeVJKRHJXTnFRaEg4QjNVUDU0Z2VjTVJ3L2dvVDB3Umo2ODBBVndLMXY5?=
 =?utf-8?B?ZWJxSWxqanNmcU9OVmF3VExlcmJRcEZzL0Q5ck4vTmxoVSt6OEpseHB3QUQv?=
 =?utf-8?B?MVBMcTNuWURwNWR3dGoxWGlUR3JYZmwvb3pscTdVYTd5amVqd3NhcHBXR2tq?=
 =?utf-8?B?N1B6alRNdnJNQ3huSENPb0dLWWQvNHlkZ0Z6eU5DU2REaHZqd1RweGgwNEMr?=
 =?utf-8?B?Zm9JSFFMTGRBcWxSdno4OVZaZmxxMy9Yb3VtSW8vblh5YklPTHl4dm11dCtt?=
 =?utf-8?B?YWlCTUlyczBaK2REM0NNemRhUW0rSUtRMWo3cndUUUdFRllyWHNydm1ZV09G?=
 =?utf-8?B?a3JaWVMwVkFEaW9tTnF2WXZ6WUZ0eGRHamZiZU1KSjUwMVNPa1VMTTFYNnox?=
 =?utf-8?B?a2dJM2I5R2dnWWwxL0ZsZExTRDBkeis1RUNDRyt2VGZEWTZkL2lpcVFhRTI5?=
 =?utf-8?B?bHdab3A5MkpmYUttbWFET0hxMENCS3ErYVMxR1FhRlZ6aG42WEtKbnlIRmlD?=
 =?utf-8?Q?pVgpu7uooVxpQq50=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca77f5d-bb2f-42a1-42b8-08df252680c7
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 10:25:41.0299 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQoR90EN8highpGGrdMajaDliSQjAUwL3qtj4zrR6/TeyV/c1PiJ17wXBlSpCIk+te4TiJZJk/Nb73F2Wa5HPl04Q3oEKDpOHq3Z9mv3Phw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10270
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

A device which only went through vhost_dev_init_backend() has its VQs
not yet initialized, so vq->dev is NULL and vhost_virtqueue_cleanup()
would crash dereferencing it.  Check vq->dev before use, so that
vhost_dev_cleanup() can be called to release a device whose full
vhost_dev_init() never ran or failed along the way.

As of now, there's no way for the cleanup path to be reached with
vq->dev uninitialized.  However after a subsequent patch adding CPR
support for vhost-vsock this'll become a possibility, so let's prevent
such a crash beforehand.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 99561ac5868..dfdfd49da3f 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1661,7 +1661,7 @@ fail_call:
 static void vhost_virtqueue_cleanup(struct vhost_virtqueue *vq)
 {
     event_notifier_cleanup(&vq->masked_notifier);
-    if (vq->dev->vhost_ops->vhost_set_vring_err) {
+    if (vq->dev && vq->dev->vhost_ops->vhost_set_vring_err) {
         event_notifier_set_handler(&vq->error_notifier, NULL);
         event_notifier_cleanup(&vq->error_notifier);
     }

-- 
2.47.1


