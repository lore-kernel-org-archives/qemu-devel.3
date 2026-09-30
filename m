Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA20CA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrJf-0000in-O0; Wed, 30 Sep 2026 06:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBrJe-0000iI-Gc
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:13:34 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBrJc-00045T-VB
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:13:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=baNw4jGCze0SIZ55l0CHDDb9Mfo7hIRsID6Zi6a2xCAsCoaB0zw7ryr7AAb4Z6RRRw4+tchxlRsbz1rHQieOUOVKTJPLxnGxAG0TyMZSQEDZcVBCsmLsR5ye8dBUSenHHl1fTfJ2vIAz6GmmzFrvFjOJIpPNTn66lA6s8vOzP9HE89pL/JcUxLg1/ZPHAOssYins2exPm15+X68FC1ChC48aQf/EOd+OwokPhvCkN0r4JinQ7kbGLG86OwqzTa0mMPfXZgy7vJnWWI5XLP2kdOm1SIE1H5Xq/2GsaWWObwBq/j0/LX+zBMlVtkPLpK8hTQbH1GPW51RQuboLYDMHqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFLHrTXYn30DKBGfZX9XawwQGNuxnOEL0tX4YglZD1Y=;
 b=b0s8eQzBuNarZzDzb6quHIRfC4FrqEHuMD7colzCbI9i/XfWDcf1tuIzhmk36DyO3un+HY9H/C0y/d1RDv74XFSFN6GAYZMF+2/fjPgCDutZcE8rz5Qm7Kylu2Zy6Ow1X2NfPyyak5/6b4RVFYW+WQBbf4o6Hrer5WOMKT2p75opbJNIA0+TVdQ0G7RgKxt5XL3pIv+8pniVW4Ry/vvNGi7FaYvcpOfatN9z1WbxUwGWI7Mf9OgQJJg5lHz8qxuNS+NexaSRFocZUfE7eqRtfgMwcz884Kvk+ssRY8exCdkN7e5AH2OCRft5tL3dWc80ct7B6Q6pnKtrgDG/9A+lcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFLHrTXYn30DKBGfZX9XawwQGNuxnOEL0tX4YglZD1Y=;
 b=LxHsfLvQ8g68Ot8yVy1zycIu8OQQOANcsJhqguEMPoAOZbkDqWEro6s2S5tm2JJ8p+eQWrJfCA2436QxrPMcj79JlleJws0hKygreKLFlP4HquPjVtmNJzDdVC83SssTK21hEUzj3xJJ5cGoBKFxe6GFOA2VMQuKnKSXliQd9QNVT4ncmxnwSrg9U6bl5ufhCAsTUzndTqA3JHQhZHKOl20SR/zlcZz7D9EnSUOm0Npa4kzuLM+A7Nwd7+ISIDwKQ2Gp+5gxHxTALAC3iIg5Y6xknYZ9AzvxZUOIFHEbZLjsxT3+C22rsjpE9ONcIKH5N3F1ro0z74HLjSIx4dlL+A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM8PR08MB6420.eurprd08.prod.outlook.com
 (2603:10a6:20b:314::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.9; Wed, 30 Sep
 2026 10:13:22 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Wed, 30 Sep 2026
 10:13:22 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Wed, 30 Sep 2026 13:13:08 +0300
Subject: [PATCH v9 09/18] vhost-vsock: fix FD leak in realize()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-up-vsock-vhost-v5-v9-9-e9096f629770@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: a86aeda2-cc92-4fb7-b28f-08df1edb751a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|23010399003|366016|1800799024|10067099003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: mPqtAdiycb0VUXex+foJYwK3qcJINnhqhEr0kSL+dMlRKX0au8wSp/41zwpIckBjTRvUi0QJhatrnbNMTsiTBVYJVUecn+8oPeY3mo8t2niHtHtZP/i5J58AQTQmQA9f1RhlG5V50LDr9st4+QaN5N4G86+d/i0gLLvii+M7ejQf56141l3CYURa8BRfOf6PvDPLPPwQfZL/0M3xsXfdOvtPmqsxi5Je8BUkAJDksPl9vgHEmCyenzQ7POqUHHX0OVVUvvD2F9s95naoJFXif688Sw8lmNargin7j+VjeCRQ5THqV1dVBwcxlx6Vogxepd4ewYGV2pG1A48zZBu9aPFtq33VXLZisiFUWqfV0SECApPPx4xu2OE+CyfPP4t9ttnlE6o5Zc94JvWdbNVLGRCCxdDq7L+OmrQpQOTdeG+DoO8ZUK2v07mdUm9xf2iXmIiooI7TeOuog/oj4ixF/ob8mnaOruwB3BVfJw2LL2NJ6UXz4KrDDq/8u5bQmWYp52AL3vWBNagvU82qFxI/MfmliToFOEomLc7jvZGc2WNvqPO6DXx0JBHGYWQFwnQdfRGTDsIHRg0tT6LKY4Ybf0czpYBVUytaTdOxF74yWVDK8wceUHYbIzMQCjRn8blIodm0nXC7QssowlPTAfgMuYaLjZcvameL8GK/XWu3APwkrL35MkZMD21HNBWTxkPGCYUiHyp8Lh6a025HnHD4Wz/InuCg8GPjanCMVet8Zdc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnFZa3pRdVBtUGdPV3FKT0VOK2lkVVF3ZktRSE8xbCtQcDB2ZVlxejlrdkJL?=
 =?utf-8?B?bW5uaTV4T0JtbTQ4T0xrN2pUT202U0xmWWJ2QlZ5NEd1cS9GNHpLY0JtcmJu?=
 =?utf-8?B?SnVsbEdkVlRRN0ZSMnZOWFRuUysvSDNyNzhuY2RFNjgwTmxTdjBubGV4a3Ju?=
 =?utf-8?B?Z1RwRkZDUVk2SzhDZjZDZGQ4Z29jdVFyNWFXQzFtbUxIS0VodE1MMGRWZEtw?=
 =?utf-8?B?MDM0U25yRW1VZmdYa0RWWGdRbHdMWHFENHVhZVRYWWw1Rzhjd0x2U1ZOWEpy?=
 =?utf-8?B?blpFWjIrbU1GMmp0M0kyTEVoRVVickdubENwRSsrMjVpRFF4eEE5bU5INzFu?=
 =?utf-8?B?andNNnluazZiQVFxN2RPV3lXOGJ4NjdpM3FkWm1UMGYvV3NHMUI4OWNvVmpB?=
 =?utf-8?B?VUdGb2x3U1BBN0VyWXF3WFdPMW9RbUJLd2lLTENkeVk4OFhSZjIwN3VIV3B4?=
 =?utf-8?B?K3BjYnRodmpET29INUtFUTZYZWF3a2xKRFpxNFU4aWpPM1Vrd3pxOXZjcGti?=
 =?utf-8?B?Z3dlQSt6NXpIWlMvczVsZHR4aXY3WTRsMFgvbGtKRFRsQzZCT0ZLTFZhTFI4?=
 =?utf-8?B?OE1aUXZRZWVNYkMrM0dOZjNMRk1wcjZyWU4wbmNNSXVtZFdDUnk0L2JQMzVP?=
 =?utf-8?B?YjRCVDJFNTFGd0xUaUxsUHgzWFAwNGpjRHp0REFJT0VId0VlV25BVHFDeUlM?=
 =?utf-8?B?N3o1TncrRE9qUXB1bDFCVnBmWTkxZHAzbmtYRjRHcDNja0pyZTl5aDAzQ01W?=
 =?utf-8?B?QVZEQmwzZWhNbEZXWERSVWtJZTNPRTdQbVhwaVU1ZkV1aVMrQ05yL0FrTUla?=
 =?utf-8?B?aC9nU0JRZUh4bDRtMk9LU0d4REhkR0RiTU9jbDdJNEl4TWYxRzlvMkhkQWZj?=
 =?utf-8?B?WHF1dDVLamJPTDd0TUdnKzBGbU8xV1pOMlAvMHZXRmM3SXV4bTE4YWhJQUMw?=
 =?utf-8?B?QUEzYXJKRWRrcVlndmFKa3VIRGlwZ29kRUJjQjJTcnZQSDZTRnRvMnZBSmFH?=
 =?utf-8?B?MjBkcW40Q1JWeW40QnJaa2FWc1hNbWFROVFwQkpJWWVvbGlmL3NiUXBqTldi?=
 =?utf-8?B?QUFRU0xiMWQ5emUwK1Y5VVpndnIydUR4Unp2c0M5QklpdHBkWDZEWlhOYmgv?=
 =?utf-8?B?ZG9EazQ2cDUzTWtpN2ZvNjNac2hRUldscjFBbVB5RXowTFhGYjQybjU2amdz?=
 =?utf-8?B?VWtBamtkUzFVVURFT0RyQzFHQVhzQ1lOQ0xkWXU1SENBeVBwVjl5NENRYXQ0?=
 =?utf-8?B?eXJNcEpiV2ZQdTRYMkZBSDMrb25PMWFBWllBMmFPQXQxQkpvdXZpU3RDNERB?=
 =?utf-8?B?OEV3VUN1ZUVLeGRvcUh3ZW0xVlIzNEVZQnNqVUNTcDZPZ0s5MmVtbXltNzR5?=
 =?utf-8?B?Tm44TVRHUUhrbkIwVzRCTC8rei9uM0c4RllNNWtsa1haQmprdzQ0M2VNdGFV?=
 =?utf-8?B?dXpyU2ZKa0pSdDVQSVVNTTV3Zy91VnFkL3NnYURxT0tyT2JmZEtDNE1IaWhH?=
 =?utf-8?B?djRtOGZQN09JbUZzb2g3RzB4UXZHdHVScDcydG1Qa3RJZHAzMFIxYUZ3clhJ?=
 =?utf-8?B?TXRlMXRVWEM3ZDUzSXJSMGNWMnZoc1FWUTRMV2pxUEU0RE96RDh0eFBEZVlF?=
 =?utf-8?B?SDhPdm1OWFNXVHFCYUlEWFdKYUhDd0JDQk9HcUs0cEZKT2J6N2VzaHhRY1ln?=
 =?utf-8?B?K1I4aHJTL1VpOVU5bWtiaDdoWmV2RHgwa0ZxbmVMNzQvQ3ZEZjIrQk9OcjhQ?=
 =?utf-8?B?RE5LQ1dSdDVpK21STUhjZ2x1a0tDY21JQ2R4MkhKR0dnRmZNeWFlZkVSU3Rm?=
 =?utf-8?B?L2VYT2RpZ0FHdHdEbXBiTXFBbVB6YmNJTE1xRk5tRWVJMEJ4RFE2S2ZEYXVZ?=
 =?utf-8?B?TmwxbWdpaVlkUzNtZzVRMkc1dWdUY3RZV3lmOGJDend4cHlnaUZxZnZXYmpV?=
 =?utf-8?B?WTh4MGc3ZjhycFd5U3lWV2xESXJUaG5ISFVHUmJTZW1RVHZjcTlBMXFvd1Vu?=
 =?utf-8?B?b29SUjRzTGlYTFVJVFE2dzBraEFKTkhMU0tJS2VhMGlnQlUvWllzUEhKU1V2?=
 =?utf-8?B?b3NtQ0dnQXNrYlhJbDdhSmZTZEppS2Y1ZFRubWsreEVPalUySTIyOHFlZEZG?=
 =?utf-8?B?SUs2c3VoREUxNXZRRFdWeENxaWlBU252Qmg3d05vSUxRSERvUHFKN0tmNEV2?=
 =?utf-8?B?cHRtbTRhOG9nUjVESTlqNEc0Rit4bDNpV1F6NWVZbVFNMlQ0cTFOWldrN2VV?=
 =?utf-8?B?WUpQbWlqaVkrU3JuTVU1U25ySXk1QTBYZ1llUWJrOEcyR05Tb0RyUFF4dDN5?=
 =?utf-8?B?MzMzWWdiVUFCR2pHZzBjN04xTzhxK0FxczFCQitPaGd6ZGhBTFhLZzAzWkt6?=
 =?utf-8?Q?adg9lwYLVSjYmo5c=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a86aeda2-cc92-4fb7-b28f-08df1edb751a
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:13:22.2152 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ULtEYnxF1LJX1r7OK6Oi4BUqa10nT1xYC8jDrtd3fR1DEI5f+OIuylH2KjgoLJoLsJNwDreomyPaLasQzpoBCkuDrXiuUT9hyOKudyGr8tc=
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


