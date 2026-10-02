Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568DBCA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 13:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCcwn-0003Eu-KI; Fri, 02 Oct 2026 09:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCcuP-0000qf-HW
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:02:42 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCcuN-0007RG-5o
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:02:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQjbNEYUFlEIfrKNmU5HGEdrrM/uqOIMgzlY9OPohfvZ/XlyQzvctZYKFGCmuVGYdFx0b7ufsvFINsIMPOxd4K6g75RUp87N4lOCSA0AUt6Y937S3VzLw7ofIMyoHoOLfxEzbmmIGfwayb1awA5bsRX1XxBb8s0qOrL4OzUdQBzga72frrrQORkJ6n2o9xGItFsSZd86hllwjJORO0eJiRg8W5nalg4/whEsa1eypPN3WVLy2DVmBGYPLaYPzsfAadXgp7wAEhDR6Sxh9azuoq6vXfwY9P+tZzo7+N7dS9lexZHac2EWnwZbIh5L57ApaDP7lq8I5ITToWBwL7NOXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFLHrTXYn30DKBGfZX9XawwQGNuxnOEL0tX4YglZD1Y=;
 b=TtBEGJneYgR1qA34QfdgSFtJ1Q7es+mHYtad15PGCrYbaQIBD2wxLAhQU4eZOUSmocPO5N2kTQkDalf/qnkOFMFPg3ec6sPn9QING7GXuZoWGdw5sAMlPNcLGjejYkPnuN5ZXcllYAlC13boUGPYI0BznpZEZB1mw0rta7o3hhpNp9QkNGeUtbkdBiE22rCdpqpGcP5vOZaynpbV6e5uFW4UaFYFfC6We0Kai1lNJYZTfWRwYqP0Szs8yGAtm5pXDFx34BA6wMo5t2NxdLYilRqQ0zWD47tT2wbv6gIhHPsQfFB6jMEv6FnZyd6HQaDIcOgQmjBTKhRfIHHLvC3SwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFLHrTXYn30DKBGfZX9XawwQGNuxnOEL0tX4YglZD1Y=;
 b=Bk3uvuYGXlKexVjcMO6sxt1/RIR59M/5QsXErTD92+Yh1xBl3Q6Ic6rj0b+GbC84UigfRI1T0k10IsDy6aUZasiI5S8mcsi+JS9okJIuYPvDQ6YecxqqHH9lSwAf2R4nb8y2SB5WMx6Wze2ZIfdSOgL1zlgKojl7i2TmblnJtfhKWs8w/XCw+VHOSv61Ddk+noYxh4zkL5zMH8Do8tSs3tav9KmJss3YsV5zItUn6u4z+eoj11tDmTWUJSwyQtDDWjNayqVwiT1Fvisn3ISBD5FMZ26n6/OnFQm8/lf43NORgRZMSGZr4Do5bdq1BD7LnXleH/eBKOkErHhx2QRmWA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MIWPR08MB013052.eurprd08.prod.outlook.com
 (2603:10a6:290:e8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 13:02:26 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Fri, 2 Oct 2026
 13:02:26 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Fri, 02 Oct 2026 16:02:18 +0300
Subject: [PATCH v11 09/19] vhost-vsock: fix FD leak in realize()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-up-vsock-vhost-v5-v11-9-18fa09d8273d@virtuozzo.com>
References: <20261002-up-vsock-vhost-v5-v11-0-18fa09d8273d@virtuozzo.com>
In-Reply-To: <20261002-up-vsock-vhost-v5-v11-0-18fa09d8273d@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: farosas@suse.de, andrey.drobyshev@virtuozzo.com, bchaney@akamai.com, 
 dongli.zhang@oracle.com, vsementsov@yandex-team.ru, philmd@oss.qualcomm.com, 
 maciej.szmigiero@oracle.com, mst@redhat.com, dwmw2@infradead.org, 
 mark.kanda@oracle.com, sgarzare@redhat.com, den@openvz.org, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, peterx@redhat.com, clg@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIUP296CA0042.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34d::6) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|MIWPR08MB013052:EE_
X-MS-Office365-Filtering-Correlation-Id: 09246247-c3a8-43db-16ce-08df20856861
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|52116014|23010399003|366016|38350700014|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: IdeTthqS43BcUahBdp8Ljqi0zs9Jm4UtV1lu1MXyj4B6glWw5ioyCE6U1CTOK1FZatKZODpuFU+13r5AOLYJzvFyB72+gwtERg15t5EaVuhjSwqyv+KDbT+wTnyzXsCX1l/gu97BhBYL2XDO5e4a4YeOes6Jr+TJMWCU5u0DCJvryE8NmmSl1pgVIgMAtJrL8r/NNGs40+R6nNzne2clvV7jezWAGiPc85Os6bi4fcehbAB0WPD0cgTwQ+JTmVutJiSXyJo+FN/IFMpV2bdJv92RitUFbJma2mdKOxZZKlIC0DudpbfA622tPNPSo6C6tRW6ziJfnQtgPumn79m1qGhog4pxdkbs2tLKnGKEow8MCpJsMLXd9xpqNCTFZ2SelSP/AsNMEmFK2u6ChP9gVSJEhtdotb7PERdoLjS5cClMAqtrybX/rYSOoKZPUBCaTxfcW1Zs3RLs97vQRR81xelykskcbMuWMPXlDH/CRv7Tuw5VznU1fMwxP60Oqy4BKl14Ozz6L6v5QYd7TalQHzNPVUN8vITXZjCdDSvPxh01zLY5LeFqO61gn5+iMdECDltavUACF4q6OBUW56YhirzLpjciO9tKEsMfTE1iofNWhTAAXO+JwK8/gV1kPit8VbyrnLqExWQ5uh/AkAaf3F9V/Njwcs7USDAjvLWkzGqHVfMUodZulkGOPVXDmcnFEGXWl1FdVqVZ9zi/GFkGKmvvKygzmlooUv409uZJ450=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(23010399003)(366016)(38350700014)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmwwTFRGc1FwVkVIRVlTVCtXanlSVUlWVkxyZjh5N2ZKbTFxcTI3K2dSaGIv?=
 =?utf-8?B?V2pSeWtzbVVQVXpFQjhIS1NMbjI5UDBNTjQ2SDhUa3F4WWJUV3dHUzlOWm1h?=
 =?utf-8?B?K2lsWFVWbHZXUDZYMXpEUVI2L1c1RTVieTAvK1RDZURlUnBzSm0vZkJLRHJX?=
 =?utf-8?B?VE9ZSml0SjJrUmIrUVpFeGd6RDl0WU42QmZJMVdsZCtSWXdLMXZIdm1OeVFk?=
 =?utf-8?B?S1NrbGJXMkdTZXFmQVFsbS9VdEhoZE85dzFHSWUzT2o0UEV4bVp5ZnpaWGYr?=
 =?utf-8?B?TDBKclZ3ZmlLbm1nbDJoYnFaeUFLZHZjWS9HNVppdGpuRi9KeSthWXJXQ3NI?=
 =?utf-8?B?OE9nRUJBdldkZnZSeXBCNVFJOXVoWlYwUkhnek13V0FiZ0pqeEkvenMwRW9i?=
 =?utf-8?B?eDVIZ05USmIxUGpFai91S2VDZSticCtVK2h1RFpqYTJ3UVlVNWpWcXBlZkxB?=
 =?utf-8?B?RUpuT2x0dVBoWVYwWHpzK3NHdE5MdHZ2VllMaDE5d1c1OVBHTzR6a1R6STN6?=
 =?utf-8?B?dC95bzJlRXZ5SkRQMlZBNzdnOTA2RUlGWlNTdE5MTHplV01BVnN3MThEL1JT?=
 =?utf-8?B?cVB5SDBhYjA0UkZJYUtUcTFaRk9LSG0wUHlWMTd6d2lYeUFwVEx4enppZzcr?=
 =?utf-8?B?VnBXaVhaUDd4Ni96bmhvTnliTlNDY1dLdm9oU0hmSTViaXJUYWFhZzZMVHpj?=
 =?utf-8?B?S3dVK3NQRHQ5YWt4UVBCenkrVmhOUGw2WkFKenZ6TUVMa1BzbU5nV3RXYWJj?=
 =?utf-8?B?TTVqOVlPWjNlTTNkYlVQR1Q3STVxMjVtRitUemlVNHZHZWZMYlY5Unk3djE1?=
 =?utf-8?B?TXMzcUxFWFZJd0pJWDQxSTJYNjlkY1hYSWxqVm9NcXFmcnlRbU01dHFxNjV2?=
 =?utf-8?B?VUxibUN1SzNRNzBlbXNtQk85T3hyRFZ0RklPZXp6Nm9SR3RXVTVqWFcrZjVP?=
 =?utf-8?B?RGg0WXk1UGhFRFNoVmtvNklCRk1Kcmo1aCttUVpvbWJUelRBeTBncDZuVjVr?=
 =?utf-8?B?ZGl6Z0xHK2l6Ty93M0h0M3Npd05hdGxvc0hobzNheWFwdzB0SUFud05IanZY?=
 =?utf-8?B?OWZiZVhOWEp5NnV5REt0NFhBbThHeDFKdys2WlFYQkRTWkgzSm9TWjk5QUVm?=
 =?utf-8?B?NVRDblNJcmZsdzBnNS93MCtjOGw4L0krUmVndE0xd2llb090WEFXNmEwYUhW?=
 =?utf-8?B?cDFTWENaZmJsUzQxSFhxNk9PRmZNR2d1aWZ3KzRYOW1nSWMrRFBwK0pHR2Z2?=
 =?utf-8?B?VWJtTE14bVpnR0Y0V3UxR2RrcncvUStkVjkzQnZEOEVMWWRMMEJLdmE3YW4r?=
 =?utf-8?B?WFpNMDFvWUZVWWg1RlBKQnpJUGlBVU5GUCtMRmlnd0lIam9QOHVOeHozMEVh?=
 =?utf-8?B?YmRwU1EvcUxOVHdaQk5ZRVdHWkZlekw3VXI2dmJJTmRqVU13YUxjRW9UWTVC?=
 =?utf-8?B?cUl5RHh0UmhwUVNMdFYrdHU2UVViTzlqS1ZwQ3ZIT1NLTnV0WXk0bktqM2RC?=
 =?utf-8?B?dHBhbVM2VXBjN1IyRUloV0cxRjFmT0dFTXErMXNZMlF2cjMwdVFreDljNXhh?=
 =?utf-8?B?WXY0VDFaQ0ZPV3J1TFZBbnJoRWlYZ3J5REw5T3FGSUl2WEc5V3k3c0E0QTU2?=
 =?utf-8?B?bjRZOGl3VzNxd09OOUdHdkcvK0FuTDFKQjdDcVJVMjlReEtrWXRqWlFuLzQr?=
 =?utf-8?B?UWVac0g5aFlveVBBMm9vZWpmbVBaT3gvOXM5OCthUXNaSk1uREp0bzlHa2xn?=
 =?utf-8?B?SExzT3hobjJwdDREZnJvZG9ONFpjTmd6cXNFcFFyVHBjM1lJQjdEUXhCMUt6?=
 =?utf-8?B?akc2K1FNcHR4R1VoZkZQQUVla2RBRS8yZDMyN2NhbGw0cjVseUhsYkpZL2M3?=
 =?utf-8?B?NlhZR1VDbTVvWTFRbmRXL0JvYjJ5Z1NjblpueHp5bE9lTi9DSVRlTTlkMngr?=
 =?utf-8?B?WkM5a2NPbDQ4UEo0ZTh5cnBWTy8wTXRkWW5wSnRXa3lreW05eTc3VDBQeDUx?=
 =?utf-8?B?QjBEK0ZrUnhxdUpYZDBiNHNQQkdTd3JYRTBqaldCdktaMHYrblFmdXplb3BZ?=
 =?utf-8?B?RDZpejY5V1oyRzY4dmx1a0RTRlB5TUxleUxaM2FYS2dvYi9yRFF1UUlhUWpm?=
 =?utf-8?B?cUNuemQwZmxrUHQ4eUZzQ3luMThuTERMTkZ1MjFhb3RGcThJSFQvTDNNaVNj?=
 =?utf-8?B?K2RKamFrZlNZVG13NXgwWlRhOWFVMUxBWDhtL2RxVTJTemxpcWxxbEhQZkZa?=
 =?utf-8?B?dGp1NnBBY28vZVNrakpCVmhyaUtBdUZBMXlIL0FLd3F4MDJ1Y25OQUxsUnZh?=
 =?utf-8?B?RHlTdkxmb1B6NE40L2JmNW1LNVMxMkcvSEdBTVFTWThSWmduTUp0S0hSeVVO?=
 =?utf-8?Q?obrFmrvvQcmDEAEM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09246247-c3a8-43db-16ce-08df20856861
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 13:02:26.7047 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iag2w/UfjCpEzOlIRml+DhZPE951w++gU2V0DTNWuhIKQimrRK10UsnMKtcvr14WUOlKuwWu+htjtY27I/NGKgrCyI2DBQ8dTL/YB9izjFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR08MB013052
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
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

In vhost_vsock_device_realize(), after unsuccessful call to
qemu_set_blocking(vhostfd, false), vhostfd gets leaked.  Let's close it
explicitly in this case.  CPR-saved FDs don't get automatically closed,
thus it is safe both for vhostfd obtained from cpr_find_fd() and from
open(/dev/vhost-vsock).

Fixes: 384c2561bddf ("vhost-vsock: set vhostfd to non-blocking mode")
Fixes: 701544cfaf46 ("hw: replace qemu_set_nonblock()")
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index c582ac9fcc8..3ec20d87606 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -176,20 +176,17 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
             goto err_blocker;
         }
-
-        if (!qemu_set_blocking(vhostfd, false, errp)) {
-            goto err_blocker;
-        }
     } else {
         vhostfd = open("/dev/vhost-vsock", O_RDWR);
         if (vhostfd < 0) {
             error_setg_file_open(errp, errno, "/dev/vhost-vsock");
             goto err_blocker;
         }
+    }
 
-        if (!qemu_set_blocking(vhostfd, false, errp)) {
-            goto err_blocker;
-        }
+    if (!qemu_set_blocking(vhostfd, false, errp)) {
+        close(vhostfd);
+        goto err_blocker;
     }
 
     vhost_vsock_common_realize(vdev);

-- 
2.47.1


