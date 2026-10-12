Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FF8CA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:31:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGDHh-0007vz-7U; Mon, 12 Oct 2026 06:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDHE-0007ex-Pk
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:29:09 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDHC-0005Fy-AS
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:29:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EqMt6BOCJT0Xagnqjh7+pTUlULIyzKsME/6Gtz91yV5RPXflqTQ6Fx5NIBgwYlb0HKJKVxQOxzNkumSGkLwAo49hWpGWtdfWxvSuyFecpl5C7jK/u6E3wS3+RhtK2MPQ3Arsz5CVxCER5bKP8ZDfiLLL76Zv5lNfx/+O0a9WRh3qBxnoRSyWH1MAh4tKVzKe8d+I1rfdCmvELqZGxkBqZp9O5A72kspDa3eU5Wjw0kWn1LgENercc70eQM5Lak6B/Xl0RdUok3V9Ot+X3CqxDHbphNiV1QmtzD/xg6GVwtsDZGstVpWqvH+QpA0U+kc23HhWmdbPZm3d+NO9JsKazA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drAKAesrt6zn3dVVGT8tS0Fff5fyaU2GIsx2Yzp7c0c=;
 b=y+nzqlQ21ZWkVr0iAmtXdgFi0HgaNKsBr7g8FcYc1vBZxYd9P90RvESsK1HRuQA1Qr73FCORQ5N0nrK+Z2Siu3gJSoxrPy7lF4BwN4RbeVjUAH3KIhgEC1mlodEY2a5aHHeWjUIDs6H8Az0MJ8sLmMVbMgEtNjmeVRrmerKDGvDU1mHsqTdl4CcVaZAHX7MlzC8KZL7rf1A+43+YUNS1IeyZxaEsYKYH8D0JJ2pTTVSMRocSwViCLlKq3qzzQxtJIK8IThnIlYt1OaV1EBicgmznID3A+MoHSB8Z7hdJhYdpSySL6chsrv1ztaUeyqdz/LFeGCW8cBFdhctgOLJJyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drAKAesrt6zn3dVVGT8tS0Fff5fyaU2GIsx2Yzp7c0c=;
 b=dVVkpiqwEzxMZ0FuDHUSxV4uGx00q07HEVflskMgE5tSyTgUL9g/cF1nR0y7WiA20tkuDz+NyxzILUt/pSo3LOJ4Py8ffRTw38i+rkOyuhhNV9bscBRKfrdqOy17f2UNwKKEmfgtk/Jb3c8EszDFTrb0Vl6qQob6Z9ggUjFIRGHGr5QUHXxDpB7mo5+Fgc02yVOoYj3C3M69E/5ypilh/o2XEfwNjcubLqH847cny1bRbrr6zYH53GGAptNjGkTGkOAzEtua9M4HmyMNaeFZUOnSNyQR/uBwk3vOVX8lnRRYc7q8YfYgVHTJTmf6XsYpYM6rp3EhEnikMIqDcr1jBw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB9PR08MB11921.eurprd08.prod.outlook.com
 (2603:10a6:10:614::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Mon, 12 Oct
 2026 10:28:49 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0522.008; Mon, 12 Oct 2026
 10:28:49 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 12 Oct 2026 13:28:29 +0300
Subject: [PATCH v16 21/22] tests/functional: add vhost-vsock CPR test with
 a live guest
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-up-vsock-vhost-v5-v16-21-36c38bd15ffc@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB9PR08MB11921:EE_
X-MS-Office365-Filtering-Correlation-Id: adc6ed4c-4111-44e3-cd83-08df284b9a78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|7416014|52116014|366016|18002099003|22082099003|3023799007|10067099003|260925021911599003|260925021311599003|260925022911599003|38350700014|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: mZ1GlL+QZc9m9H7fAdvKlDjieHA2an8K6ChTdJV7D7MHuxnFINclD0m6T/vJmLLs9IvpAuy68td+DMw/fHxVOYvyNvSGAEb1aXBPnL+vCPEfOEGS9YRtHV+2y2BAMGR3u2ibL8h2pPTDmcaBFWK6IvxzUDh+32lf0tocew0/E6D7zHuev6YdyPprmtWXqboYU4HMXWWxtHo6gxZuGDMqUwTZvjPzVcjkH+DRTPgTyCH6QLwsi5S9J1ITvUXmv7D7NDZy8buow6sDF524zgoLN/+bhwD+3Cv2QwoJPg2pF3bUn0uSOfmN9UMxlnylvJ59ZJAXvIWmVJDaCPhpRyQyrGlmX3MKptcbrkLRJ0W4JIlVJqMI7fNWPdUqZ13zxg9O/pvGPl/W+gIx5m6Kd2zmHjaiZAuDF3tYtWbjIuliHKkv5OtfoA3yTRuzVMmreWRQznNyPrWCVaCYP/xFSMg7f0oWVe72VPojO7UWcgQoUQVVjjjQN7n0XyJUkaZhrZyLYu+rHIIhFX7mUTfPq8mQpOx+xtoewdJTwh+dbDXHWxbe8Vdz7X8d6J6oinfiX/vDeMxXG54C/aFQW8rPzc7fjX2ntZ+TbWnxmHssFoaGo5A7/hzwBhplq+dQusHQQckKtZNfbbu++VukdUA/vDXqUovYZx7fEJ8tZQXZzu/cfXzdDsqTCNyR6Hvg6bSsPjhIEYtj0EXdg2jANcv82ulW4Gyg4lSK99mQUCr2vBIAgSM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(52116014)(366016)(18002099003)(22082099003)(3023799007)(10067099003)(260925021911599003)(260925021311599003)(260925022911599003)(38350700014)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXpWcTFrQndYTGNSZmxTQkFUNm8vT25ySTY3SDArdUpnbmNVV2M5VWVpcjY5?=
 =?utf-8?B?M2ZuNS9wVlZzTkpVOWE0SnRTN1lsMzZCOFpraTkvTVFRUnRRU2ZwTkM4ZGIw?=
 =?utf-8?B?ak1IZHBtZ1AwTjdNVzdEaFFidXBpWkh5dmZwaWlwOVQyZmtzSVdGQXJVSS9T?=
 =?utf-8?B?eVMwUzlMNG0yU0FZb013NkxCTWxpRExFN2tvK1hOeGZTWXpnMG5iOWZuc09S?=
 =?utf-8?B?bzlrektrYVNKUTNRdjMyWE81ejlmcCtROVhxODdKbVY2aUEycnlPaXVBRWpo?=
 =?utf-8?B?UWR5WkdyZXFESjhWekxpR09WeVljNnlnajZBQ1ZxUUZtZVRQdEo0MFlnUURB?=
 =?utf-8?B?elBXQ0w0dXJqVlZ4WnhUSlRPZldVcS9ia2lUOC95TTd2N2hadWROTEttb1lU?=
 =?utf-8?B?VFNCUVYvanVFSm5VbG11WlBOZk9ERk9rNkpiRzRtUEJSdDhIaEFYL3d5Rk92?=
 =?utf-8?B?dVJlYWtORktJdzMzd3lsYVFLUGxqV2JFbUtNRXJLSmp3eDYvKzdtK3VLZ0Nz?=
 =?utf-8?B?dE5NaUxadzd5L00rQ2dtOXV2N1FYdWFjWGJ1UjUrYlBaSVFVNUl5Y25qNVgx?=
 =?utf-8?B?bDliMHRTanNXbnBMUHNIeVpTdkZZaEIwV3Q5Y0VYdCthZlpDNnRDVkxUSUNC?=
 =?utf-8?B?b1VMVUR1NFEvSEM3N2ZoOFBFVGNPbFlyWG9XcWpRRlM3VDNCd1FFbDRrTHIx?=
 =?utf-8?B?VGlFVDVmMmxiU0Z3Q2dJM3d1dzJSVG1ISi9kUHo3U0xkaEQrMThwOXBaV0ZG?=
 =?utf-8?B?eUowdW5WaUdzQVZzK01ybTMwUlR6Z29tQVBSKzdLS0s5cHU0WnBKWTZ1ZWM1?=
 =?utf-8?B?UDRUQTFYTEVsRExvOXBQSXZSNmJsbkk2QkEzb3liMWEvOGx6SVQ1ek96SlI2?=
 =?utf-8?B?cmJkc0t1K1dyWkZCb21lZTZPd09ENEpSVWJEdk45cUkxcllqWHcxcjdhc0ZH?=
 =?utf-8?B?TkxNRGE0R0NJQUxWb0taeWN3NVh6SWVTNzE4Wmh3aEZuenk3c2ZIYis5L282?=
 =?utf-8?B?NGdRYXJCV1ZNLzVDajV3aGdFTnIrdy9Kc3J6aDkzbUR5bzIwWE1CaklRdm9V?=
 =?utf-8?B?S3l5QitFSDJBVFRZNWc3SE8wSk1lOU50WHdkOEE2RkFxS1BHZ0Z0bUxDaDgr?=
 =?utf-8?B?RTArMUJ4SFR1MXhYOXQ5SG0yMDZxTHpSSFpsbHRXVlJ5QmFoZTByMGxuNmkv?=
 =?utf-8?B?RXR6Y2ZzVHkvaEIza0RrNHhLazIyVzlHd2JlQVB2MFFJOTlQLzFEejZtZ0h1?=
 =?utf-8?B?dWtwd2RaK3Q5THpwL2ZzWmJqL2owUi9ydm11V0xHV2J5Z0I4V2ozeWt1Qm5n?=
 =?utf-8?B?VTE4K0FXVmhmb0cwRnU0WjRSZXhhQVBET3E3S1FwZnEvSmt3TzBxQjN1QWZV?=
 =?utf-8?B?WEVrWkNENkM2MzJ5UXp3Ykg1WlNTZVBPcVpYL1dPYysvaGFIVjh0Z2trdFFW?=
 =?utf-8?B?V3BhNGQ2dDVLZENTc0lUL3lXOVNXN0FvbWRkZU1YbzkzY3hjTWd6a0hEYXhU?=
 =?utf-8?B?N2pMVHkwRUdTWjBCTGYvMUJTYXZQRGVCQnlSNzBOUlV4bnJlTHp0elpCVC8z?=
 =?utf-8?B?aW54a3hqbmNWOG8xRE1SVG1PZUU1d0RuSTNJTTFhaVdiZDZ4Q3Z4MjVvZjI5?=
 =?utf-8?B?MjJRS0lBbmtTYW1yZElsYUhPeERDWXg2OUo2RTlBZVpHWWoxNnBJQ09BT2Ja?=
 =?utf-8?B?NVRlWGxLMzFPalNhTWNpU2NBYjdjWWZTUXpUVWt6N1ZrYzVKTWtPcUI4Nmtz?=
 =?utf-8?B?azNpUlNoVWN4K1VWMG4ydWJ1RitqNnpnZU5td2k4ZXNkV0VNSE85Q1VGa1d5?=
 =?utf-8?B?SzVwVjVSajlsbE1hUzc4b0xVN1Q3SGFna3Z0VG9zc1RLcmpkRGIwYTdjUm15?=
 =?utf-8?B?QXlqZlJoanlXQ2hkZVlYWXpzRDBOaUJvTWJCemZneTlhVTBlMlNpOWZRalVN?=
 =?utf-8?B?a3IzZUZXcUw0M0QwS1JrMlBBNDVycWRNMElZYTRRbXJhMlg4RHhzUGJQa1Z5?=
 =?utf-8?B?alJvN01pLzNXSTRHSW4xVDRvbmZFbzZpaVZBNVh0L2JtL3htcjUrci9rK0o1?=
 =?utf-8?B?eEhYMjIrbWtSa1NkdzJKeWNUdkRaeWtLWDA3b0QxcXE3NzMyWHd6OTJ3OVFI?=
 =?utf-8?B?STJicDFuZnZibWhkVXlxYkZzYW03TlU3b25XbjhCN2tBeUNNQ0lPMDRaWjd2?=
 =?utf-8?B?NVBkRHdmSUJJWXNZbXN6ZE9ZL2RoMGZ3cE8zU2FBR2pVWW10b2hiOGFlUFVj?=
 =?utf-8?B?Nis2Z1pSanhJc2NIcnYycytYZUVwc1BIVUN6MlAxb25maXZaKy9vSnRVcGla?=
 =?utf-8?B?cjJkaDh2TFVsU095Q0dZcFJxOWlyTERpdWh3b01NSVFKcUJtVzdEcGZOV2M2?=
 =?utf-8?Q?yI51dQBp4vtgRvxY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adc6ed4c-4111-44e3-cd83-08df284b9a78
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 10:28:49.0487 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ry3GKEJKQaMkt/oZyBEpFpMIsKYp0AikiqoSqEkCrIePpcJWwUxkQxEltynBMroXDxxfp0VH5sO7I5TtY04+K1Jw2S4576U0s1ZTrvlhXMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB11921
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


