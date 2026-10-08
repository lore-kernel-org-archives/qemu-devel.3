Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC64CA600E
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 10:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xElKX-0003Vd-OT; Thu, 08 Oct 2026 06:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElK8-0003JA-H9
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:26:05 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElK6-00016n-5r
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:26:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BzM8GalCNPQ1Ev1m3hGlOOZdJufjEr+C80VLbnYkSdrUrLgL7iRqPxtGq0p1fxmp89xiobP0VMFjOFjR+fuVx4WlifOL2o0U2pTJU4x6ngG207viz7jv/VL0Bh1DYH8OcbIG2E7N83+Sx41K43mzPePPLyKUahPqy5miYgrXV99/3RKYTjYUBttfm3Tc0tSwkGC2A4z7LhQ/A7nnlqNzrZiQZQnPZ33+a7tZve45YM2d9hCuBMz+gNe9aGGzu6PYlhxqz9EdoWG6ixmLUf3p3438B3gVAYVdPiRCr1xFXlzuhJ0pNqqU4B6RgdNU5GmghvG9pyZXGIsyyrpnezCMnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drAKAesrt6zn3dVVGT8tS0Fff5fyaU2GIsx2Yzp7c0c=;
 b=pN/43gvsItm1Gsbx+boTJwPZrqPsO6qTqudSka9djK3zGbc2wHF7ss2Zz54k1SF6GbVGu14VApA+Mujv9uj1X9k6YjtMrAdkspbtAHXj7HD5OB3XLqaUIoMr3cbjloHFpfpJcqj6dBGEnogTjJUZm/16L3nyQiNElsHEwuUhAgKBFmM1/xQFT9rCVdPK7TOMX6qeJMvKXWAOZyBMzOTwwQLQwjZdL8JFDoPDNtvoDqMA5nC3Orw2ijJQgzg9wiKVdg7xSyumv99tjjy44OlAcyeSL1LtrrlpuqtNU7rLbZr2X4wCij6yZUs2Cok6eMfimB7a/SNArE9LSH/Zyg3gGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drAKAesrt6zn3dVVGT8tS0Fff5fyaU2GIsx2Yzp7c0c=;
 b=HAV3WwcNEPEAIpB+0xWGrEyVMPaCwPmdCbkjXu6bpon8RVmPGQ+f0OetX7KBCVFbT7t2yjzz1i9O0n3GsneZ62uIBLzuc3GCusX+u2rfu+Beonzx0iQH94FC/hg4UmVJSivlADMfc5I0k9aEWaESP35OKn+KkAr7hey+GYqD7WHnPRknaUlUbVxG6fAc3uN61c5v9eFHAnsKzxRglFVC0TZS+9aXp4e8gCY1pbsKxTGx4APMVw6aGWaBhH5xoaU9PflkBnvel2uTufTcfersby7ZLm4d9dhmXntwh75AEk++01HRRNYNGb2sy1JrN0YmHsjZ0BVkWGrbEEnLhGlfqg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB10270.eurprd08.prod.outlook.com
 (2603:10a6:20b:637::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Thu, 8 Oct
 2026 10:25:52 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 10:25:52 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Thu, 08 Oct 2026 13:25:45 +0300
Subject: [PATCH v15 21/22] tests/functional: add vhost-vsock CPR test with
 a live guest
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-up-vsock-vhost-v5-v15-21-301b73b3f843@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: b7cf4d81-ce5c-47f5-9430-08df252685c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|7416014|52116014|260925021911599003|260925021311599003|10067099003|260925022911599003|56012099006|3023799007|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: 4k8IUS0FyJT4COWQmf5ZTXct2uI7VjlbUKOifHM1vqqh6lDHlPCWhx/lunRLICDR3Y7JzF8ZhuF9H8Lm21dDPkWGbQkbX2c9K7HCHSiXmJzlt1wVLUNh9YNumiEeysCiMDjmrBKp5a6mwVzwpfxnJizd5e3yEOPLrz3OiBI2qmHPTV3Kh8GkNidyRhKpE+tc35h6nfimrYg/THl+xqGun0pdoGFl9vw5AXIMfmf570Z2diEJ61D4VRkr/fXT4qX7QoIIUM7uiJayFikCDS27stwwKdTpbfqIuaeO96cx3u6xVTlo4+CZhyXyp8aTlmfp2qONsXBmO6b59JqVZWedrexeEKFKAXesR/dFo05nQ9nO3WUCHQa7a3h8z+nc/7Gtr2mgx/gSETLccF4+/1YMmBKnBYmFEIHEZmhv7bJllAVMwOEoXxn2VtSfLJ+SQzqar642mPNojvT79e3ArlDEj/9m0vZvHki67aFQyWtxhXYgjbsZNl6ILMSyM+DVzYNxLtqH+qJA0Me1DwJh/m3bXqdA6OtBfXFxp0ujjOL9P4IF2IbWDKFCaOys4bu3RWNFJd5zUgFUs2/srD80repEb4tX91KMLY6BHuuTSaV/F1wuD+IT6uwfwIf2yPTawgH485eTVm8VvNE06GJrRmPSMWhptyPOD7f6e7Yp1WZqARLj6kOvm8ya9nzb1/k7IvP/o8jP6mXINQOqaFScWUA9wHUvE1keMmlY8g/74XJzgdI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(52116014)(260925021911599003)(260925021311599003)(10067099003)(260925022911599003)(56012099006)(3023799007)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDZyQjRMcnp5UURRcUNvcFVIVEtFTFRrWEUweFQ0YmxiWWJrTXpaMVBjbGh3?=
 =?utf-8?B?MXlpVVNNMDkxSnI5MTdpN0ZZRGZnSkpLaEZvWEhsb01PRDZyaThmeXRvS1l0?=
 =?utf-8?B?SnNIVGI4Q3RhR3VKUUhPSklhN1hWekNMTzYxem56RjJac21CWk5DSmR4ZFNO?=
 =?utf-8?B?ME55bFdVL2lQSlhNVGFrRktBY01MYk5Ncm1IYWNnWkp4OXZ2ZjNjckE2a2RL?=
 =?utf-8?B?RkRTOHZaZHJWa0duOEVKdi90eldLV2dONjFnYm8rOXVGNU91KzhaNVNUYVVs?=
 =?utf-8?B?Uk1RR1A1dmsyRnQ0cCs2UHNRV0dHbFVLVTFzY1ZaQ2VMeUM2RVRPeFRWVGJq?=
 =?utf-8?B?UHQrSjVmMkZBb0h4dnRkcXNMVGdpL2p5cEMxRitDenpFY0c5V2YvN1lsclo0?=
 =?utf-8?B?cWtSMUlCS1B5VWhxd3JjclFEUENENzJFTHh6OEU5b0t3c2hEd3Z4Qjd4RHFz?=
 =?utf-8?B?ckFNN1dhbkZCVHRMU1NRcGEvZjc4OG43VUtmanRqTHJMVUpWWUNHRldYOTBp?=
 =?utf-8?B?eWR5REhiYnl1UTBZYjF3N2FLL2RPWHZ2UEdaeHI2WGFPVXNySWhRSDFEb3A1?=
 =?utf-8?B?Q0hYbFR1a1JxR2NnT3prWHl4bFhkcGo3UzlBeEd5MW1aWHFlcGpCekExM1h6?=
 =?utf-8?B?RTlBV3pEU0tlWVowNXNyMW5mR0gzWCtOZ2JKaVV2S0NkYkNPTThpQU43c2Nv?=
 =?utf-8?B?bE83bHNLb0V2elB0SzQ3WVdvMjRYRDVScENBbGR1ZW10bGJySGVaaGJBMmFJ?=
 =?utf-8?B?dVYyS0ZPdW80cnR2dEsxMjdoanBmVjQrdWFxaVdoUE8xU1FrOS9GL2JVUzhN?=
 =?utf-8?B?aG9tRmlBNDVYUXp0UVNUa1JHejVNMHMvNW5uUVpqSjl5ZUtJaVdST0pVSUU3?=
 =?utf-8?B?N3hmeVE0TENCcFlUREFuNUNDMFpHOXVCWEc4a0JSTDJiVGdHTUppaERJNmtn?=
 =?utf-8?B?cElCMXZMRHViYmhMSWxTY0FqVXY0a3R3elhlYWROL0VhZzl1STdyMFFwTmNB?=
 =?utf-8?B?WmZXQk5USzRjb0Zwa0t5UlpVUUViTVdObGVRQTVIVmlPUUVOWFNZR3dVb2xs?=
 =?utf-8?B?WGpFVmwzMkFDVkZBTllIQkE5MWhFcVZ3VFZoeW5rVDF3WnYySVJWVHlqemxl?=
 =?utf-8?B?L3NYQklIUnhzZGhseWJqTHROVHMzQ3M5ZG1vdG9KNXEwblF1N1dXQnIzc0J4?=
 =?utf-8?B?aUxTK003YTdXTlNDYmlndzN4cU5Zc282V29RdTBjVHpIUHMzYnAwdWpBWEl1?=
 =?utf-8?B?V3dGOE5lbWhDeHBBR0xxNzBYOEl5Y1pUMkZQNWF3TndiM0l2WnJrZEs0b0hU?=
 =?utf-8?B?NmJycTNYRlJFaGNiZkwydjlaN2VkaGRyQnk0REF5TzRORTh3T2d0blpvVVhT?=
 =?utf-8?B?VEN1aWNEbVlyVmZvQ2Y4YllHUngrUExWVUdKZU5rQko3SzE5ZHNRSUZyMk5U?=
 =?utf-8?B?S1dGTEhhNElqZUZZMkxyeXhEeHVRa3lJNUxsTDFCckxWOVpoVmxTWUZTRVQ2?=
 =?utf-8?B?MTNWTXRQMUQyWC9GZmYzMWRVTkJ2YWJqbnVyaU5IVmphL1Q4ZXJGdDBqRXVz?=
 =?utf-8?B?V25zZG5hOEtmM09FMVZybVZlSy92N2ZzYmRCRlBFYmljV3RoVXNkMDhXdzlG?=
 =?utf-8?B?QXlsYjJod2pka21ReTZNTU5mYk5BRjJhQm1sWWZIUHZoNmorejhuamlYQWVn?=
 =?utf-8?B?VHdWbW5QN0Q5NnhhVENBSkVIN2Rjc1VaVDdSY281TUc3SDVaTVVxMUN0anVl?=
 =?utf-8?B?Yis3eFUwYlBmWGFRaTRoT2QyQ3g5QzdYQ3dhU2ZNTUpWT0NydmZiaE5BSjBz?=
 =?utf-8?B?N0VybTVYQ1d5ZklvbkczRTdSU2hxdzZBVUk5TnlJNDZlcVZ2SGllUnlGenFv?=
 =?utf-8?B?V2J2WUVyUk9qdU1lSGNoeHFhNUdpNXFaOG5peEdqQlVMSGFYWGlOMU8wbVdt?=
 =?utf-8?B?SDJBS0UybWYwMGx2NEVXRThJb2U2Wk1GU2tlZkhCajVvZGtMZnFnYlJEWjJs?=
 =?utf-8?B?Y0VvVjJEMDJxMHJlcmJpMjZFeE1oZ0pxUzdJWjlZNjFtOWtyZVFLNUFoVllN?=
 =?utf-8?B?bWM5dkxFRzN1ZElLMmhlbXBUcjNIVXRsVzcxbDdOMnJMckNjU0RmaGRXWGV5?=
 =?utf-8?B?SFhETVFoNnBVZU1OVHI0LzVsZzNKRWZ4RGdQQmlLT2RvZGkyVEgrMkQvRUl2?=
 =?utf-8?B?V3hYL3RqUy9JN1FWK3FDamJmWGMwQ1ZtNDlyMHluaURmMUlXR01ETGo5cmJE?=
 =?utf-8?B?ZHJNamhHUTM1bXYvbDdkcGxnMFVPaWMwQy9JRTl2MmFoWHRhdk9lcmJFKzNS?=
 =?utf-8?B?eW5aZjNDcEJiWXlsYVZmRm0xN0h3QlpTL1FtYlFtRXNWczcxdU50bWEwU0la?=
 =?utf-8?Q?i65DJfBjp52YhNVg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7cf4d81-ce5c-47f5-9430-08df252685c6
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 10:25:49.4445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cAhLs6/YKFlniNaInDeL2rpHZ19m78PUbFlKjW22wjPFK2ysCSoqyYR/5ela4Hj6POGCj84e2W3gt6Lc8NJ0Ypod+t7jC+wIxoDh6G6hbZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10270
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

The qtests only cover the QEMU side of the vhost-vsock handoff.  Add a
functional test which runs an actual host<->guest vsock transfer across
a series of CPR migrations, for both cpr-transfer and cpr-exec:

  - the guest is booted on top of a qcow2 overlay shared by all the QEMU
    instances it goes through;

  - the host sends a 512M file of random data to the guest with socat,
    where it's stored on disk, then gets it back the same way; a CPR
    migration is performed every 0.2s while a transfer is in progress;

  - with cpr-transfer each migration starts a fresh target QEMU and
    retires the source; with cpr-exec the same process is re-exec'ed
    over and over;

  - the file received back must be identical to the one sent, and both
    socat instances in the guest must exit cleanly.

The test needs KVM, socat and /dev/vhost-vsock on the host, and a kernel
supporting VHOST_RESET_OWNER for vhost-vsock.  If any of those
requirements are missing the test is skipped.

Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/functional/x86_64/meson.build             |   2 +
 tests/functional/x86_64/test_vhost_vsock_cpr.py | 245 ++++++++++++++++++++++++
 2 files changed, 247 insertions(+)

diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
index 0353b2af8e1..718bdc5195c 100644
--- a/tests/functional/x86_64/meson.build
+++ b/tests/functional/x86_64/meson.build
@@ -7,6 +7,7 @@ test_x86_64_timeouts = {
   'netdev_ethtool' : 180,
   'replay' : 480,
   'virtio_balloon': 120,
+  'vhost_vsock_cpr': 300,
 }
 
 tests_x86_64_system_quick = [
@@ -51,4 +52,5 @@ tests_x86_64_system_thorough = [
   'virtio_balloon',
   'virtio_gpu',
   'rebuild_vmfd',
+  'vhost_vsock_cpr',
 ]
diff --git a/tests/functional/x86_64/test_vhost_vsock_cpr.py b/tests/functional/x86_64/test_vhost_vsock_cpr.py
new file mode 100755
index 00000000000..035307fc82f
--- /dev/null
+++ b/tests/functional/x86_64/test_vhost_vsock_cpr.py
@@ -0,0 +1,245 @@
+#!/usr/bin/env python3
+#
+# Functional test for vhost-vsock over CPR (cpr-transfer and cpr-exec):
+# a host<->guest vsock transfer must survive repeated CPR migrations, in
+# either direction.
+#
+# Copyright (c) 2026 Virtuozzo International GmbH.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import fcntl
+import filecmp
+import os
+import subprocess
+import time
+
+from qemu.qmp import ConnectError, ExecInterruptedError
+from qemu.qmp.legacy import QEMUMonitorProtocol
+from qemu_test import (Asset, LinuxKernelTest, exec_command,
+                       exec_command_and_wait_for_pattern, get_qemu_img,
+                       skipIfMissingCommands)
+
+GUEST_CID = 4000000010    # we expect this CID to be free on the host
+VSOCK_PORT = 5000
+
+TRANSFER_SIZE = 512 * 1024 * 1024    # file size for host<->guest transfer
+CPR_INTERVAL = 0.2                   # interval between CPR ops
+
+VHOST_SET_OWNER = 0xAF01      # _IO(VHOST_VIRTIO, 0x01)
+VHOST_RESET_OWNER = 0xAF02    # _IO(VHOST_VIRTIO, 0x02)
+
+# What a QMP connection raises when its QEMU goes away underneath it
+QMP_GONE = (OSError, EOFError, ConnectError, ExecInterruptedError)
+
+
+@skipIfMissingCommands('socat')
+class VhostVsockCPR(LinuxKernelTest):
+    # This should have passwordless root login, vsock support + socat
+    ASSET_DISKIMAGE = Asset(
+        ('https://cloud.debian.org/images/cloud/bookworm/20231210-1590/'
+         'debian-12-nocloud-amd64-20231210-1590.qcow2'),
+        'b94e3f34db59988a815b33dffc24f5a58502540efece2cc1ed15e0ac8749bb2e')
+
+    def require_vhost_vsock_cpr(self):
+        try:
+            fd = os.open('/dev/vhost-vsock', os.O_RDWR)
+        except OSError:
+            self.skipTest('/dev/vhost-vsock is not available')
+        try:
+            for name, request in (('VHOST_SET_OWNER', VHOST_SET_OWNER),
+                                  ('VHOST_RESET_OWNER', VHOST_RESET_OWNER)):
+                try:
+                    fcntl.ioctl(fd, request)
+                except OSError:
+                    self.skipTest(f'{name} is not supported for vhost-vsock')
+        finally:
+            os.close(fd)
+
+    def setUp(self):
+        super().setUp()
+        self.require_accelerator('kvm')
+        self.require_device('vhost-vsock-pci')
+        self.require_vhost_vsock_cpr()
+        self.set_machine('q35')
+
+        # Use Debian cloud image as a backing.  During host<->guest
+        # transfer the guest will write data to its disk, so we start
+        # it with an overlay
+        self.disk = self.scratch_file('disk.qcow2')
+        subprocess.check_call([get_qemu_img(self), 'create', '-q', '-f',
+                               'qcow2', '-b', self.ASSET_DISKIMAGE.fetch(),
+                               '-F', 'qcow2', self.disk])
+
+        self.payload = self.scratch_file('payload')
+        with open(self.payload, 'wb') as f:
+            for _ in range(TRANSFER_SIZE >> 20):
+                f.write(os.urandom(1 << 20))
+
+        self.sock_dir = self.socket_dir().name
+        self.cpr_count = 0
+
+        self.guest = None
+        self.qmp_path = None
+
+    def prepare_vm(self, vm, name, *extra_args):
+        # We don't want QEMUMachine.launch() set up QMP for us.  In this
+        # case launch() waits for greeting - which won't be sent cause
+        # CPR target is reading CPR migration channel before QMP
+        qmp_path = os.path.join(self.sock_dir, f'{name}-qmp.sock')
+        vm.set_qmp_monitor(False)
+        vm.set_console()
+        vm.add_args('-accel', 'kvm', '-m', '1G',
+                    '-object', 'memory-backend-memfd,id=ram,share=on,size=1G',
+                    '-machine', 'memory-backend=ram,aux-ram-share=on',
+                    '-drive', f'file={self.disk},if=none,id=disk,format=qcow2',
+                    '-device', 'virtio-blk-pci,drive=disk',
+                    '-device', f'vhost-vsock-pci,guest-cid={GUEST_CID}',
+                    '-qmp', f'unix:{qmp_path},server=on,wait=off',
+                    *extra_args)
+        return qmp_path
+
+    def wait_for(self, what, cond, timeout=60):
+        """Poll cond() until it returns something true, and return that"""
+        deadline = time.monotonic() + timeout
+        while True:
+            value = cond()
+            if value:
+                return value
+            self.assertLess(time.monotonic(), deadline,
+                            f'timed out waiting for {what}')
+            time.sleep(0.2)
+
+    def qmp_connect(self, qmp_path):
+        """Connect to a QEMU which may still be starting up"""
+        def attempt():
+            try:
+                qmp = QEMUMonitorProtocol(qmp_path)
+                qmp.connect()
+                return qmp
+            except (OSError, ConnectError):
+                return None
+        return self.wait_for('QMP to come up', attempt)
+
+    def wait_migration(self, qmp):
+        def completed():
+            status = qmp.cmd('query-migrate').get('status')
+            self.assertNotEqual(status, 'failed', 'migration failed')
+            return status == 'completed'
+        self.wait_for('migration completion', completed)
+
+    def wait_running(self, qmp_path):
+        # Make sure we're dealing with the new QEMU after CPR
+        while True:
+            try:
+                with self.qmp_connect(qmp_path) as qmp:
+                    self.wait_for('the VM to resume', lambda: qmp.cmd(
+                        'query-status')['status'] == 'running')
+                return
+            except QMP_GONE:
+                pass
+
+    def boot(self):
+        self.guest = self.vm
+        self.qmp_path = self.prepare_vm(self.guest, 'source')
+        self.guest.launch()
+        self.wait_for_console_pattern('login:')
+        exec_command_and_wait_for_pattern(self, 'root', 'root@localhost:~#')
+
+    def transfer(self, guest_cmd, host_cmd, cpr):
+        """
+        Run a socat transfer between the guest and the host, and keep
+        performing CPR migrations as long as it's in progress
+        """
+        exec_command(self, f'{guest_cmd} &', vm=self.guest)
+        with subprocess.Popen(host_cmd) as socat:
+            while socat.poll() is None:
+                time.sleep(CPR_INTERVAL)
+                cpr()
+        self.assertEqual(socat.returncode, 0, 'host socat failed')
+        exec_command_and_wait_for_pattern(self, 'wait %1; echo RC_$?',
+                                          'RC_0', vm=self.guest)
+
+    def transfer_both_ways(self, cpr):
+        """
+        Send the payload to a file on the guest's disk, get it back into
+        another file on the host, then compare.
+        """
+        echo = self.scratch_file('echo')
+        connect = f'VSOCK-CONNECT:{GUEST_CID}:{VSOCK_PORT},retry=10'
+
+        self.transfer(f'socat -u VSOCK-LISTEN:{VSOCK_PORT} CREATE:/root/data',
+                      ['socat', '-u', f'FILE:{self.payload}', connect], cpr)
+        self.transfer(f'socat -u FILE:/root/data VSOCK-LISTEN:{VSOCK_PORT}',
+                      ['socat', '-u', connect, f'CREATE:{echo}'], cpr)
+
+        self.log.info('%d CPR migrations performed', self.cpr_count)
+        self.assertTrue(filecmp.cmp(self.payload, echo, shallow=False),
+                        'the data came back different')
+
+    def test_cpr_transfer(self):
+        """
+        Perform consecutive cpr-transfer migrations during vsock file
+        transfer, starting a new QEMU instance on each one, migrating into
+        it and shutting down the source
+        """
+        def cpr():
+            n = self.cpr_count
+            mig_sock = os.path.join(self.sock_dir, f'mig{n}.sock')
+            cpr_sock = os.path.join(self.sock_dir, f'cpr{n}.sock')
+            target = self.get_vm(name=f'target{n}')
+            target_qmp_path = self.prepare_vm(
+                target, f'target{n}',
+                '-incoming', f'unix:{mig_sock}',
+                '-incoming', 'cpr,addr.transport=socket,addr.type=unix,'
+                             f'addr.path={cpr_sock}')
+
+            # The target listens on the CPR channel: wait for it to be there
+            target.launch()
+            self.wait_for('the CPR socket', lambda: os.path.exists(cpr_sock))
+
+            with self.qmp_connect(self.qmp_path) as qmp:
+                qmp.cmd('migrate-set-parameters', mode='cpr-transfer')
+                qmp.cmd('migrate', channels=[
+                    {'channel-type': 'main',
+                     'addr': {'transport': 'socket', 'type': 'unix',
+                              'path': mig_sock}},
+                    {'channel-type': 'cpr',
+                     'addr': {'transport': 'socket', 'type': 'unix',
+                              'path': cpr_sock}}])
+                self.wait_migration(qmp)
+            self.wait_running(target_qmp_path)
+
+            self.guest.shutdown()
+            self.guest, self.qmp_path = target, target_qmp_path
+            self.cpr_count += 1
+
+        self.boot()
+        self.transfer_both_ways(cpr)
+
+    def test_cpr_exec(self):
+        """
+        Perform consecutive cpr-exec migration during vsock file transfer,
+        saving devices' state to a file
+        """
+        state = self.scratch_file('cpr.state')
+
+        def cpr():
+            try:
+                with self.qmp_connect(self.qmp_path) as qmp:
+                    qmp.cmd('migrate-set-parameters', **{
+                        'mode': 'cpr-exec', 'cpr-exec-command': exec_cmd})
+                    qmp.cmd('migrate', uri=f'file:{state}')
+                    self.wait_migration(qmp)
+            except QMP_GONE:
+                pass
+            self.wait_running(self.qmp_path)
+            self.cpr_count += 1
+
+        self.boot()
+        exec_cmd = [*self.guest._qemu_full_args, '-incoming', f'file:{state}']
+        self.transfer_both_ways(cpr)
+
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()

-- 
2.47.1


