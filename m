Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B513CA6007
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:40:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENsd-0004Pc-DO; Wed, 07 Oct 2026 05:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENCJ-0001MN-L3
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:32 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENCH-0006jK-WD
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aw3khB6oAeZpIyADwnqRHITo6OesUduHrfAjoelqOANOdGvwxqoT5YcFrRaKaiAsr9w7j2rAppqqVwb3kLuVSLxFvRTCcn8+KgxJTYvShnHvYbZxBkbgQ/9ESAb/oL2dGB7VF2KdCMU37bi7K9ru7uIVaa2EELV9xdZ5y/jIMXbiF7fCuInznseJoEdXWfg7zXHqBwK+W/iH/TGmwwXBuDtT4gHUz+4btYsCTkfwcYIMA0lRbTbklpMihXSFZgPZKQQk7FsOanL4SjkfcGNeYzT0ymsmOyFbm0sgoRDbiR7IE2c7RWrOhVnPjRoQ+xrMnmqr4lmpibPdr0nvXUWs6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42TxjWWVF52+WjX+vXTK/F5rsdLUfNrhRilXbJ+LOJc=;
 b=uJPsF8heY1hJpgbH3o0bbsq9Wbqbd29baGpamryIo7wBGLr8YoZhE3VLbnUKhh+sWkLFVXFrJJwwLyzYIbvU7u6GbaJ+OD2z9B+k8pt3TSb0N89XZsFyjRRksxY/apBaOh06Ye0ri1LgNdk5gdsPd06pioEe/2qsOVRtaYZ0i6shHqMWOyZRpTeFihHKvtDUbeDWezjOPbdCxQ3me6+NpUFu9QgC1euQfPokZ6dATKav/GwFu12Tmr+vNrwAvSPlsrgxa6bD90Si9hYK0hP/iOy+xTY2cInv4jXjvP0KDHcvwNczRphnE3klEfWkilNJSbHqtjKkbJHRsjlVzdjzYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42TxjWWVF52+WjX+vXTK/F5rsdLUfNrhRilXbJ+LOJc=;
 b=taC4v1y405BzuEX7qhURBtol27ZyvBSwA+59RgYvsi285xfb0h770xKDMVU/UHrQ7mIAtTCUQ70ATA0IHhX36zdiHxdb5XlqaOMzyuqgJ4mwNp8WHX7YJyoUMDzcluJ9mqTUJW241Q+A38KE+VExZiviXwM9/BTCOxYUecOIjjUS+Uam4ELT14oItkkGIGXg7XnxFFL6PHlayOCc/QEuZ8jRY2XBYvom4c6HHgYO76LYqCu57oF9APIscT9d6m0WJOCQ1lx6iPtpbHxgmUMPWLOB0hzlHQu0BwbqJPj4rbITYbV5uNTbJkgE5r72dcGJnztXlt8yfYucL0hIBbl5NA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM9PR08MB6292.eurprd08.prod.outlook.com
 (2603:10a6:20b:2d8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 08:40:01 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 08:40:01 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Wed, 07 Oct 2026 11:39:59 +0300
Subject: [PATCH v14 06/22] vhost-vsock: block CPR migration modes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-up-vsock-vhost-v5-v14-6-e16de9962df0@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM9PR08MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: 008f4df2-d1a1-4b06-e0cd-08df244e93a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|52116014|1800799024|23010399003|38350700014|56012099006|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: vvSaW5E0KVva79khqiG1HGu655ZKQ7pA0r5Cgond6uVM332lI81T8g5wWmhZgh3iBPfXxhXLJvFUhvRgP5g8EoHDF7YI7qs8Ws9H20ALbaArOOb0XJH7e4DwU3gQ3KImNk2JnbZGAnYw1PprNVHxpng3ZE6tlumhpEt/1mw7jD590PQo07lpt7WEgkX+8K7Y7RQ/xL+i65X+x3AmZ6x8EDjsVRopiBd5xlxvKRqvJJUGhvkWMVvPovf+UenIeEB6qlXLCgODe3XQiNntU6LIxDHdAKtgS03/9TbK2cj79OGT3RtanUjfwt6mNqJNX8zUblZIEVFrr8IzRKClO+iZqz2ySDWVVG6Fm1VZadcJ+OHsVmv4VV+0NeQWRbXR8p8Db2x1+icqPEOXwZjKRsT+eZ6WvbFU2D24VPM1zQ3ZvVld5g4q6rP7oRwWmaUGBEPi+mZQP/A7EgeBqkAsGUgnimaY3lMXzccQFhnFntOCK0g4uaaDhnvGJoKh0iW4dHiwYvZs5rp2tIWRDsPX4DvXvhvWaUN/JXnF0FgRn41iCPFLsKMU1qDDBGIR2YzsKcJr2U0//OMVsfgp/1z2Fcg9HCCY5r9c9VyeKE7ewn5/5txoNW5P7u9oMfV9Ij5ujDb+ih0YGvyH/I8vnPuqepAj1Kppql0lP5cAeFLbYGkhXmghXKmfNN9muGuH4gRytiRgO2Xxm4nevEciJweFiiGIUBI/9gDX8sj0tgiQpL4ZQLI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(52116014)(1800799024)(23010399003)(38350700014)(56012099006)(22082099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VG9yUmNScHlLbjU5eUtVLzh4ZnB2cjRPcU9waFBSQTAyNTJ5M3ZZSWRmUnNJ?=
 =?utf-8?B?QlhwNGxwbG93aXY1dlR1Q1o4ZnZpamg5UzNoVWp6RW5pT1dxdTE2SHJad0tk?=
 =?utf-8?B?d0dyaThCT0ZycDZPSnhmMDRqTHBVbXRCRGs4WUVkakFLWDlEblhZMC9zZGNQ?=
 =?utf-8?B?bXRYQnZMNFcrbE8rN1BobllOb0p2RFlWN0tMdHZ2UlVoNW91OE9tUmhMNnF4?=
 =?utf-8?B?a3lmeWRiY2JXWGtUVm04MG1qckNsanVSOXFkOFBMZkMyc0x2cHBOMUdaYm1u?=
 =?utf-8?B?eUUwUGs5SWVLZHJvRzVhWWtUb2lzMk1ReGg2cUhESUUyamg3eHZHTWhHRFpU?=
 =?utf-8?B?QUVqcXI5N0YwODI3VFBhUTV3eFhjcVloY0xXcDcwWnZCYVBXSFJqSTlyNll4?=
 =?utf-8?B?S1RUNWQyZnh3akJ5Q2R2RjFicFpmTTBDTnBMYTV0Z3h2d1VRRUlmQnNUWlNt?=
 =?utf-8?B?aUZpWDRSbjcvWXNQenVIalJOZUM4ZlpRZjgvRVE4UVFJOVZBVkRwL0VuaUxB?=
 =?utf-8?B?dVg1TkJCQnFBTkJUbFpZclo1ZGVvd2VyL3JrWE42cXJTTGFRVFlVZDRxUVY0?=
 =?utf-8?B?Q0ZpWlA4eEo1aXRRaDlpRWQvbGtCNjl5YldKVk1vSVZlRjdGeThzRTVySHdj?=
 =?utf-8?B?M281cGdWeVIxTlZGeURkY0IyNkU3dVFoWGw1cGhUekVjaHd4V2hqYUpsKzlP?=
 =?utf-8?B?MU4xbnd3Y0F3aEtORUdCQ2NsQk5TcCt5dzFRNGRNbmxKaVJxK0RSRXM0WWxr?=
 =?utf-8?B?S1lDYXBkMFpDRVY1RWdwVGRGQ28rdi9qSGdKRGtZbG5sUForaTJkRXpLa3JX?=
 =?utf-8?B?ZnF1MXFhZFlxL2JsNEN4TlJyVW5nSU51UXJmYS9aMkh3a0tXOFcreHY3WjVP?=
 =?utf-8?B?a2JzTHZpWFRFUGlxSHgrdWszbnBJYTNSRloyckczZGRLd1AvR0laVEFvZkp1?=
 =?utf-8?B?Z3g5Y2RqODN0aHlicng0NmtCVnRNU0JBd3BqczFsd3Nja0pqemlyVGxTVDdt?=
 =?utf-8?B?dkVwWGhvNjdLRjN6RS9TaE5Va24xUDJoM2NIZmUyNHBZaVhqaWltNmdwNnNB?=
 =?utf-8?B?YlIyUE83R3pPMnU1bmQ4OUxxQmdsOXZiM3NmMmltalRkWC8wSjVZb00vV0Qy?=
 =?utf-8?B?RWd1VDdOV0xjeXlkZndJZnpSVzgyTXdUOEtuODM5V2pXeTZsdGQ0amdJM3or?=
 =?utf-8?B?NWI5WTNtMmkyeC8yUWlHc0hQa1Z4V0Rpem0xSmh4NGxqZzFOSzVYSXQwcytj?=
 =?utf-8?B?SU5BUVlsYS9VQkhVRGUzQW84OHU1aEJZOUF3a0pmY21mYWY5bm9RMUNkRWlX?=
 =?utf-8?B?MjdZdmJ2T1JxSUIzWWlOdlc2MkdZKzdtYXNkaFJkQWxncVU4ODdEWjZVMk9Z?=
 =?utf-8?B?dSt6MzJGa3c1N0lqRlV3QzF1dDNKL3dCaHpCbVZVOGR4MzJtMlZ3K0kwMnB3?=
 =?utf-8?B?d2dRMDE1K25BaVBzeGtBOHJIQzh4MHZsQmJvL2ZockNnN0MzcTRWZkU1N0tQ?=
 =?utf-8?B?MFhTb3hSd1FRTlJySFkyVHYrV2U2QmQ3UDREdysrYTJmUnMyZWN0SVZrTjc2?=
 =?utf-8?B?NGZTQ29CK0FQa3ZDaWdCSy8xRlZuR01pQW9QZEJVcDN3VGhMWnFNYjdndGh5?=
 =?utf-8?B?bkpVVHNBMmVWTUJBQTByZnhGVlRueEtrYjRYUkd1QzFXUVd5a0x6d01vT21F?=
 =?utf-8?B?ZmlVTmI1cU92YTV5V0dFUmJHNVNUN3ZaWlVRSVVMV2ZHYXFoTFVFcXVZUzVu?=
 =?utf-8?B?NmFtZ1JwZjhrak4vSTRaeERna3JTKzZzdndkeEZqdEJjV0VqUTZITXdDMzVG?=
 =?utf-8?B?bElRTzY5dmx3QWdYMUVNVitWYlFQeFljODVkRDVHL1F0N3I5U3Q3OFNTVXRv?=
 =?utf-8?B?VkhNYW11SFlwcEVycm5HbVNtcHJZUU92UElwdzVMc3lPQzM0VThmVFptWHhS?=
 =?utf-8?B?TXdPTndaajJpRjB4aHZmeVFXbDRaN3lQeFY2T0RRMmhXbHhDZjhTOEh4TUpw?=
 =?utf-8?B?UmtKdEp6UEtLNEVDaGVzWWF5WVpNQis5VlBLWUo0S1JmL0dmMFFCN2tXK0k2?=
 =?utf-8?B?Tk4xVkw3MUdZZVZpVnRJR3NJTzlYS3ZTME01NEhHbHM0MDJYU2J3TUZsRjdO?=
 =?utf-8?B?aE51UUdJNVI2UVVCTDJZU3BDVWpueUVBa3Q0d0NZdm92bDd5SW5kYVFueXMx?=
 =?utf-8?B?OVdNK0REMU41a0VIVFZRWEt5WXdKQ1A4d1RXWlk2empLaVJ5ckJDNXZFMFY1?=
 =?utf-8?B?WXF2UG9QYlpPWGZweG4rVGhiNXcwZUZOZXF0TFdPRDRUYUVsZjRjbWhTZU9t?=
 =?utf-8?B?NzlEQm9pdFhNUVkrMmdkYk4zK08xRERmUittSllHenp5UllNQ3d4Y0tuT2RD?=
 =?utf-8?Q?6m0/wabBli8zCKuQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 008f4df2-d1a1-4b06-e0cd-08df244e93a5
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 08:40:01.4159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cn5gU0UMObxp3hUdyDed/83+rOPgXPxV4NmeRilK6Xkag/hHQ4dgU8WlbrNyavw06/1FmhZmDplyRWR3J4qNPZj8Gaap4tyf0mT8Dtca1jY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6292
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

CPR migration with a vhost-vsock device currently crashes the target
QEMU.  The device ownership is not handed over, so while the source
QEMU still holds the guest CID hashed in the kernel, the target's freshly
opened vhost-vsock device fails to set the same CID in realize():

  qemu-system-x86_64: -device vhost-vsock-pci,id=vsock0,guest-cid=3:
  vhost-vsock: unable to set guest cid: Address already in use

Add an unconditional migration blocker for the CPR modes, so that such
a migration fails early and gracefully instead.  The following patches
implement the actual vhost-vsock CPR support, and the blocker is lifted
once it's fully working.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
---
 hw/virtio/vhost-vsock.c         | 27 +++++++++++++++++++++++----
 include/hw/virtio/vhost-vsock.h |  1 +
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index da244eb1657..503d248a617 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -20,6 +20,8 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/virtio/vhost-vsock.h"
 #include "monitor/monitor.h"
+#include "migration/blocker.h"
+#include "migration/misc.h"
 
 static void vhost_vsock_get_config(VirtIODevice *vdev, uint8_t *config)
 {
@@ -140,25 +142,38 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    /*
+     * CPR migration of a vhost-vsock device is not supported yet: the
+     * device ownership is not handed over, so the target fails to set
+     * up its device.  Fail the migration early and gracefully instead.
+     */
+    error_setg(&vsock->migration_blocker,
+               "vhost-vsock: CPR migration is not supported");
+    if (migrate_add_blocker_modes(&vsock->migration_blocker,
+                                  BIT(MIG_MODE_CPR_TRANSFER) |
+                                  BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
+        return;
+    }
+
     if (vsock->conf.vhostfd) {
         vhostfd = monitor_fd_param(monitor_cur(), vsock->conf.vhostfd, errp);
         if (vhostfd == -1) {
             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
-            return;
+            goto err_blocker;
         }
 
         if (!qemu_set_blocking(vhostfd, false, errp)) {
-            return;
+            goto err_blocker;
         }
     } else {
         vhostfd = open("/dev/vhost-vsock", O_RDWR);
         if (vhostfd < 0) {
             error_setg_file_open(errp, errno, "/dev/vhost-vsock");
-            return;
+            goto err_blocker;
         }
 
         if (!qemu_set_blocking(vhostfd, false, errp)) {
-            return;
+            goto err_blocker;
         }
     }
 
@@ -187,16 +202,20 @@ err_vhost_dev:
     vhost_dev_cleanup(&vvc->vhost_dev);
 err_virtio:
     vhost_vsock_common_unrealize(vdev);
+err_blocker:
+    migrate_del_blocker(&vsock->migration_blocker);
 }
 
 static void vhost_vsock_device_unrealize(DeviceState *dev)
 {
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostVSock *vsock = VHOST_VSOCK(dev);
 
     /* This will stop vhost backend if appropriate. */
     vhost_vsock_set_status(vdev, 0);
 
+    migrate_del_blocker(&vsock->migration_blocker);
     vhost_dev_cleanup(&vvc->vhost_dev);
     vhost_vsock_common_unrealize(vdev);
 }
diff --git a/include/hw/virtio/vhost-vsock.h b/include/hw/virtio/vhost-vsock.h
index 84f4e727c70..a964d57e1bc 100644
--- a/include/hw/virtio/vhost-vsock.h
+++ b/include/hw/virtio/vhost-vsock.h
@@ -29,6 +29,7 @@ struct VHostVSock {
     /*< private >*/
     VHostVSockCommon parent;
     VHostVSockConf conf;
+    Error *migration_blocker;   /* CPR migration is not supported */
 
     /*< public >*/
 };

-- 
2.47.1


