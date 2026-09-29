Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F20D3CA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 17:25:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBbYp-0006Au-G4; Tue, 29 Sep 2026 13:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBbYn-0006AT-LS
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 13:24:09 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBbYl-0002lB-Bi
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 13:24:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pnqLblPImWxl1Tby+/ZGeDBoKBjvlufi2TbeO/i5OMAPdTPGnX32Vi8G7CN7MFHDPqlUcL2yD+9F49O1S8fJE0A8RFMTJWSOBrvHvyImONxKl/x826LyDnsMAZ0/8mWXWhMZ6Phu75aLjsFxTr6pqepJRUv2DUqzgNLVrXeYGi8xYYb8qr2YKKXGhmh7pevIOmAmveAQGT7TpwDGu0XQTNm3AMgcKk47iTm43hd/6Jrb6FHnSi9s7gwgbkdBggkxWmGSYdIv3gRQAkDgOU+/5Kd2UEUCaET7hhia9ZHdwzsJDc9+29VAj3caEY+b0ZvdJCA/3zvhBREnd+K91AKt+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drAKAesrt6zn3dVVGT8tS0Fff5fyaU2GIsx2Yzp7c0c=;
 b=njMSc6OHtbB1KqKoOLDZW3MufnNiPX2rsN14Y1SnOPSpuCPpHAltI1qHhHV2eweBwhuU6UeWIfyODtu4girT+azquWj5a9oQF8+6GMEAJX6WH4Ar02i/YM03XVo8IgPgjz+Dk0PhnkAZ08KGT4O/DyYyK/l+oWbIUhKfU4AMMkio/gA/QfhiGrgFU61aeYUFdN8zOLGnGRQC0/pNV+1KH2hBt+rGHAscapepvry4lvTrRn39It+x7uq64xDscECFEm3zaHZYWUTqS4YZaapKbRa+smfGmnXLvLBmeS/ybbOqpeTqyV96d0dnmxiBv3KIjalXloNfiiiZdSjsPlNC8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drAKAesrt6zn3dVVGT8tS0Fff5fyaU2GIsx2Yzp7c0c=;
 b=eUdUaudxJDxiiqGg9SUA8ISEaxpLLYpGPNL3UZ9POsgvMWBJwAoISK34C25TckETDErE/nkLVDi4+5SyoKQaJZAVrxjERE741cRCJ4KDJrMdV/E/SXKuheZY8fe202AdrpNxU/SkRUC9XJ9QOZPu34aleRaEtnpr1xFsEJqnDhF+M8dgA7NWnb9pkF9WLEJGKOyl27S2niBDftpyUMmD3XU6A0Ku0G7WbZhZOpVvxZBHacNLnZpQG+b4Ex8y5QSKBl4/99z679C9tNYy/X63Ry8x4WiU3X56h+QABWQLARvwx7D/lCkPQGLn8JJd191MtzN073tetl/ca/6192VBjQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MA9PR08MB435041.eurprd08.prod.outlook.com
 (2603:10a6:250:101::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Tue, 29 Sep
 2026 17:23:56 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Tue, 29 Sep 2026
 17:23:56 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 29 Sep 2026 20:23:36 +0300
Subject: [PATCH v8 17/17] tests/functional: add vhost-vsock CPR test with a
 live guest
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-up-vsock-vhost-v5-v8-17-12bcf1c0b84a@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|MA9PR08MB435041:EE_
X-MS-Office365-Filtering-Correlation-Id: ff373430-136c-4a03-6e09-08df1e4e7138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|7416014|23010399003|1800799024|260925021311599003|260925021911599003|38350700014|3023799007|56012099006|10067099003|18002099003|22082099003|260925022911599003;
X-Microsoft-Antispam-Message-Info: vBxj0iWG/acGTdkP7yBfMxUH45MmOl8B5ACwTX0d9d9fCGrzWvbQ2nXtrooGG6jWLwau3d+fAiJbnZYgyeL4JpxF/LiYyIUvDasaFDoUzuy0i2J2ZbQgaY7Rst3az0dBM7inD5W8W/GwKIda/SI0xTjcwcqwT5AhjQ68Tcd18PfX50CTGYZxbGQMScTBWo/1JhyEpbuIQfJFib4hbm1ndhge0BKBR8e+DshuAbC0bzMy30nZwGxVoBtLL47tyKyROPWE84C31uaZU65oR0LtF0DV0oa70pitZoaRvaHrBKNbLrgoDiJmR+hgHhZOjZeWzJSY8sfQxAx4VjZvyCFMabLwVRV07lqJLRfD87xGUFHdzVSruAoIOI7hBWKteqem6eW/JabJ9D5vL4amIxEWlAdK93V+j/A2CoLwrfn/Cmqz6SuCr7UoSLafeU9aHQINkm4UHElEOXyGA0tbHYH4v5oSXWp16d0UaALUbPUmtQytbDU2UXcDZeNWukgeoZ8ZXHe98xrcI1t39DEXMqv5rrSuZrfQCcs5nfqlP+eOocLKti9dfqcv2Sbn6N1yiJUGVkM6QddhhSDHn4KbhDwWLorec6AHtmm5U5hOQV0NL6BN11Xrtn7ZD9GTC2Y5a0VDckMDGxHCjP1fd4e0/05DsFtznUgRprysgiDbFQtBkCIEsr5FV03r/3QHvKGEBfU+2KQB6zf4mpxIZ4nvw7Ab09rI/Tt53IEUJA9Zsqjflkw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(7416014)(23010399003)(1800799024)(260925021311599003)(260925021911599003)(38350700014)(3023799007)(56012099006)(10067099003)(18002099003)(22082099003)(260925022911599003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTRya1hLYlJ5N0JERS9IRW51VExrZWxZN1U2Y2o2MGxvTUhOaStKbE0ybkpV?=
 =?utf-8?B?Vlg0K1dXb3Z6ckdYWE1XZWdnUnROT0phY2NQd1RlYURIQ2NMMCtXL3gyN2xU?=
 =?utf-8?B?c2dqV2FpOFlPdm1NSHVZRDZFaDdYcStwTHBHQnFOQnVqSjhiTENjYTBGSmpY?=
 =?utf-8?B?cmRyanNrNkRQaGJPVENxaFZCZ3hvVVNGQmlvVzM4ZU0zYjdVUHJsMlhldU5u?=
 =?utf-8?B?NVNOVXo4b3NqWnhpdWhkSmx4MVhJVWJLY1ZSVmF5ektmR1BtMmZJVEVXOEh4?=
 =?utf-8?B?SjVSejdlZUhmQzdaTmV4TU1DaGdBMWptd2hHZ2U0UWZZSk96dG9VRks5cjln?=
 =?utf-8?B?ZVhDSWpNcFdrdWhtOEptWEFMTVR5MEVNMHdaYVB0MHdoUjFqWTVQdDRYL0N1?=
 =?utf-8?B?bjhHZ1pkYjVxT2t1MjlHOFo5RlBMOXFNSkwvUU1oTXpVWGo0MUtsUmdlclEy?=
 =?utf-8?B?aDVaK0VKNVcvTisycytGV21LNXI5aE5UeWZWT1VNTWVqbGh3QXRvbS83MEtv?=
 =?utf-8?B?U3AvSndVR2Qxb0ljaVFxZzMxODUreXM3eDJPRk5RWHVqRXVQWHVvcTZTRWY0?=
 =?utf-8?B?NVF0d01FY1Y5UHVaMVBsZ09Oa2dNMmNUeUp3QTVsYVI1TGdwRXNDd2VCTU5m?=
 =?utf-8?B?c3ZMMkNxaW5WOHg5eWFlVS82ckR3Wk5leTNBQlFEZnpjeTBVREthTTl4eDVp?=
 =?utf-8?B?VVpjMDVxNUlHYmV3MUtIRnRNdCsvSFIyc3laUHlGQXc2Zm1rTWJONmQxWWlx?=
 =?utf-8?B?MGJjZzQ3cXg4QWZraWwzSmFSdzZSNEk5NGluM0FZVEFrSlduclNZVFZPNXRR?=
 =?utf-8?B?SmdiQkZFZ2p5WEJqZ3I3eFBRamhoTGw5VE9nMW8waGVWQTVYcnJpS0ExeGVJ?=
 =?utf-8?B?amlYQ0lTYmlnRjNOdEpOR2JVTFl2MFBRWU9DeWduUGtyaUVyaFhUQmNrc1RK?=
 =?utf-8?B?dDJ4TUVFZTVXWmdJUkM0K1lEZXFoSEd1LzFaVWI1OTg0dHpuK1RrMUUraU9o?=
 =?utf-8?B?VnZOM0NqQ0ZVVUhTVktNUWtuWFJLdm1mMUM0bXl2eXg3OTRSRTRtRGRHK3Ju?=
 =?utf-8?B?SnVLU3llcXE1NDY3RFJhZmZ3THFKQXVMcjNhM0JMSlg1VkFrN2RxdG1TL0x5?=
 =?utf-8?B?N1RUVS9Wb1BBRFlJeGo2UEZPY3RBTWVla3BwcHo3UUdQUnNueHM4RVVJNXM3?=
 =?utf-8?B?SnpmTWppeFhTcFFhNTFLYmdjV01pNUx0RkpjcEFwTEt1TjFxYUFaWlR1MnVr?=
 =?utf-8?B?UUhxMjhKOVdlb3JqN1hINWlDcUVsaUVMNnkvNVhiQ29LaGxoekxNOEdxdDYx?=
 =?utf-8?B?K1ZnYjc1eVplbktVQ0gvUmVqaEdZeTR3YTlYN0dyd3JTd0FCckE2QzJ2Vkh4?=
 =?utf-8?B?am5nRGVZZEFhR3hPemJLOGZXMmlYZVhncmY0eFZNUzZRcldOWWlSSDZWWXR4?=
 =?utf-8?B?eFA0Smhjc2kxR1FyV0xvNHJucWNwTmZQRDdaUTgzRTdzbEp6Q21oT3YrV240?=
 =?utf-8?B?TE9YamNwV0Z6VUxMOXZETDFPWW4vUU1COXg3UllORllwdkI4ZStWb0hCQThQ?=
 =?utf-8?B?RTlRSy9XTzRWNWJNUVFCcldhTEVJYTVTVEU3dy9PZGlGeWdjWEZCT2wxOXFK?=
 =?utf-8?B?U2ZDZ1NlVTFHcTRzcDFBTnJQTkE4Tmw4KzhxN0JIVjJtcEtucDlZMG5DU0pl?=
 =?utf-8?B?akVUOXZNZmFKN2duZEx6Q0x3bVRkNjdwaDJqMGZWUFZ5SzY4dzdwekdCZFdW?=
 =?utf-8?B?d1NmSXh2U29UTHorM251WS9RQ2R5dnZjTTRqbE83Y1lHc1I0RXNVa1VibERG?=
 =?utf-8?B?aVE2L3JyanptTWs3RXVLNDMvR3diK2xNbVBhK1pCbi9IcWd6ZnJWMzhKUXlq?=
 =?utf-8?B?UWxaU3BzVlcvbE9lWTVuZ08wazdBN3YvQ0Q3QW9pWmw1ZktwVzBBd3RSVEdi?=
 =?utf-8?B?UE1Udlc5a0RMZk5vM24vNUZkU2hCUXd2d1J0NDdMU21tRGRlcEtBTGQ1STNQ?=
 =?utf-8?B?YytHZ0lhR3YxdEpJTHdwVGVoTU5hQjBUNmFHeXNsZjNsWVQ3TnJ1U1BsM0pp?=
 =?utf-8?B?SW56MVVLRVJ3Ym9yVDFOZ2c4c2Nmd0tZQy9LemViaUU0bkRWVXExcEVrcEdI?=
 =?utf-8?B?VExGRUE4UHFQekR6Q1VrUk54dk5VM2JHYWlHVDVsQ1VxbWNWeE0yd2I1ZU9y?=
 =?utf-8?B?K1o5K0lVL01CLys0aWVxb1pqNWQxclk3bXZFaW96S1hQUnhBUTRUZEZuSUhj?=
 =?utf-8?B?aFhUMlFuZHJHdGNFRm00Q2g5bE1KeURIdHdmTWh6M0RFZTBuM2N1cEdQTy8x?=
 =?utf-8?B?Mlg2VzEreFlsYks5Y3FHOTBWR292cnVuSVB1cStrUjc0SzFBdGlEYXlyNzAz?=
 =?utf-8?Q?2F4dvNIx9GP1QK+E=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff373430-136c-4a03-6e09-08df1e4e7138
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:23:56.6777 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LceYMiguPHUkzIkp5jO/JH4sI/YGgKarCWf8nL4ZB/bRmKahk8jq5ZDKtWSdqScNoI1tW+Ww2lUaAjfz5gxSCiCeaXD73cZljld4duhaudA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA9PR08MB435041
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
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


