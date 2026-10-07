Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD917CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENwk-0005KA-KP; Wed, 07 Oct 2026 05:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENCS-0001Sv-Gh
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:50 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENCP-0006sq-TG
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zDv6it7KL50dOl2W2BuorSkaY6iQ1yOFijuTxVoOmdtaZwuI7ANqpHARLZWZQqsYz6msIwBuD5j5Q/GcJPFEiJG/tYZ694TFcsNoHRdilE/x+RixMklK5SFT0pvTNuPfvDx+fVUhkBrli5qH/ATMQFkyPtca7eivhbO6QSW8r8z4CO3+tQyHhsWab3J/u622lya/5n3lXTiPodcVUOkYBkWORiGhewyFeZwHrZUTzXumTGZExYsO9FCudG/LO/jxnvxJQNoRV0no6Rviw/JAQHz0xSRWSLmN5b5RJvuFhj1pkhyMIWEwqaaIlLxiMF0sEDWM1hsMx2EozGdGbHMD7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drAKAesrt6zn3dVVGT8tS0Fff5fyaU2GIsx2Yzp7c0c=;
 b=c86h1s9UEtyKxl6m7AICgI6HGPpdTG2ahONL+3zNYSjcScbbtnTyMfBMgZ0PoP87JZcNs9XlfrT28dxb7fWI9A/diQVKyV9lt4wTCiJ54rRwICBJ2aRp2wvSKaRPr8XPpwvBbjhfBzEqWdQL9NwZ7VmiLbDlwrwhEnUlNxHM900DObpkT8nDRpDMP6UchueEtf8E5lu7F4pm9YcHb4zlci4WYjJ8rpXkKNI/Xb7gyQ/VGJ+j6fZQD6TTUHO+QIFhEI39rTCyYn36CE71cjnqQJ5DBP+TKIy6FiO9LYb7hZKtGiR+4acJ2DhUFfKq4c6xfmq2yQWApLITB1InOGQbgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drAKAesrt6zn3dVVGT8tS0Fff5fyaU2GIsx2Yzp7c0c=;
 b=rIPXyuxemV+YDqET5CPXUaxF1RiuhljxMN+L/AaXNgyWHR8PnX61jSlahajYg/JV3zyojtf2AdHDfKbs8pUTmXEK403Mxnl1X9Z7OFFcpHedkn3Lbl/asqxkpLeNoSkiCN1kJnuk99RP50kOxDQbcm9MjSsLl8alYTy8F+Q2XaDrt71V9x//5/oENwrzCrgfoM+FQUh1WtOJLM1mqVoDZ4eC5bmLJB7vpXzrsRCtgHUR6B5Gfyl4xrykTumENkFAY2CTowuUHCbDnBcm4c3BPYwn2k7K+b3NubjjJ5sHcgHic+Dtlwig7QfCUg1FFj5UtOThzjUBXOWtQsVoM+WxmA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB3PR08MB9058.eurprd08.prod.outlook.com
 (2603:10a6:10:430::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 08:40:12 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 08:40:12 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Wed, 07 Oct 2026 11:40:14 +0300
Subject: [PATCH v14 21/22] tests/functional: add vhost-vsock CPR test with
 a live guest
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-up-vsock-vhost-v5-v14-21-e16de9962df0@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6184f893-09fb-423d-af21-08df244e9a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|23010399003|366016|1800799024|10067099003|260925022911599003|260925021311599003|260925021911599003|56012099006|3023799007|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: nsI0qEr5xaJnWBEIcLN6soBKf8qe3mMruhYat337T9ujszXt3gxTuRrLafnlLCib35zCL3vyrRPS3uBy6dNlpg7sP7QX3wqK2XAJYxgesr5uqQBvUy3hfHFj+wjfAXMbsIkouhgMYBW9yWon/N2okwvloffzu8/LcNE5TZ3wQ67h3jWzL7lHIvggzeR5fF9Ex4rMA6kfqHMoYCrWFivwxmZtpVZSJFWgYl7OClsp13CbT04QLcQdDKTdyigKiofb73lUO8592s43wMyjDX/yH/0+0QctFIM2PtBoI9YXjrnthIDJYT5HhHKSy4a7j0/QMGi4KyVQBaWlPTeBzaZTR7EULWNL/Gl8LF4zXLVrAkLx9YlHx+8nNn2XxWujiu0oJQUODnspGz3sGHTOXZiZeIqsUvjorHRi93C4f2w8ZYfw11k9m9DjWJtMxiebfmIe9nl1l1BiTJoKoT44HZGQHdqFvWXEM/7VHlWgwAG3vRrlL/o/+RqefS3qMK0EJPzwwcfLJ+pA/Iq8Jzz6jzR0IE0mjDyJ4rVARnIzvjXcqNMEk78eXODOts7HPqa8BvpN60cmb0sO8DSBFgSj+1Q1quPQyhlQEjTCCSVkrocI6hbn8OC7Uf31Q01hpLtaFq7iGhUbpgQijbgfKGa/j/8VLxKxp+iwXgHxPOtNKY1Xz2oFO7nUAgq0lPYqAI5KbcvQthvsZY7bxXmwGrShFfuUtkblohddqCOp6+u7I6l+L0M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(23010399003)(366016)(1800799024)(10067099003)(260925022911599003)(260925021311599003)(260925021911599003)(56012099006)(3023799007)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU0zY0lKUUU5U05ITEdxRXZUckdxVU9jU1EwTHBvNGRmQi83aEg0Wi9ZTXlS?=
 =?utf-8?B?MWhMQ3AxRWV4SUcra0VqSjdKbzZXM2lmTGFCbjdaNGJEelB4Q0VXeDU4a3Iw?=
 =?utf-8?B?NllOR09YTi9LejlQR295WDg4ZFdwQ0xVRDM4WnRpWEk2ZEsrNzRsYjlNcndi?=
 =?utf-8?B?V09zMCtWajJjcFlHSEdBOGkwTXRxaTUycU5wQlJuVjJIUm12c2FUTHBMbDRI?=
 =?utf-8?B?WTcwekdTRUxvQlBlOENlZUg3QlUwa1JQbHNhNElidHFubHYrUWNiUDZ1V2Rt?=
 =?utf-8?B?b0N5RW8zNXkrSE1HdVdiOWIyUmxQemJMak1RdE5zQ2M3Qld2WG8wank5RDdy?=
 =?utf-8?B?S1lyMFhpZDBBUzJZUU5RYTd5b0VZY0lEZ1MwMTI4LzE3Nmg5QlltUFM3ZytM?=
 =?utf-8?B?M29uYTVLcHhSWXNzNmVUTmNJVU1tU0JrVUhPV05qODNxV0lZbW1ZUktvbUlE?=
 =?utf-8?B?dkpFaVV1UE5uWmlhQXFabm9YUEpNazlWOUdKaTFkVXVSTUljRkZTWkxKZjdP?=
 =?utf-8?B?SE03clUvWitleGdmZGs2czhzV2pYVGdPc3JjbkdJQ3RRTitjT3oxKzZUaXFp?=
 =?utf-8?B?WXM2VUFYWE9ablhibHhVSGxCck1zNXpmZ3JNQlJRZlBBOVR6emRoeGFIM043?=
 =?utf-8?B?TTlnRG56cmNoZjZoSDdYVUUxcGJwRFZFQngzOXhBL2lTYVp5eDlsck9TWHNN?=
 =?utf-8?B?UnlnTDZGRjVyVDdGTWp3WGRHZ20vSDFGZTV1czFOdDlOaWNmalVUdW10NTd2?=
 =?utf-8?B?cVdWR3FSRk1iS2g0VDJUcFQvRVJmWE5IV1ptNVpteFJVaFlWYzVjTU9CWUl5?=
 =?utf-8?B?UHNJdDV2TnNsUXRHOFVsTmdjMVExUnpiUDhxdjJmYSsxbnJaUTc0M08vM3Iy?=
 =?utf-8?B?eDl6Zjd4WVBESDM2bjYvcTQ2b2lpSWlQalNZR05iVHlZZkIzbHFmOXQ4Z1RF?=
 =?utf-8?B?N2JZa1Q0WDFKUUc0YkdMdlczL3hsRWJpS2x1cUFvWFhrVE94cHZHM29DZ0xN?=
 =?utf-8?B?ZlpIVW54TFdBYXN3T2JlcmxIMHpacDNERmRkWnBnN3ZYTG5wbEJKUy9yVUpq?=
 =?utf-8?B?WUx3RDdKK3FsUm1NRVYxOE5JZlpVUkhYRUdIRDNSTHFaZlIwSzNhd004ODBH?=
 =?utf-8?B?TkY5YmREdnBZRzBqOTRRcnJKM05URjVMMmpvbmRZcXcvUzFxeG15empPd2Er?=
 =?utf-8?B?ODJDVWx1Rm5GMUw2ZVc4OE85bC93TGdkZGNtWVBhZ0pwbVlhZGdKSGVXN2lH?=
 =?utf-8?B?MWxBdlUvcDgrNXdaeldVOWlvSFBFb05EcGJneGUrN1dYeFA4aElId1hHam5J?=
 =?utf-8?B?VW0vZld4MFdrc1dwSndRMllVclVtWm11UE5LNUo1QTNIMDNnODVqMm9ORmRj?=
 =?utf-8?B?SkUzV0JWdWJDQkNRMEoxa2lVQTZXODd0V245c2Zod0FDdTVaTGFLeWVtcjgx?=
 =?utf-8?B?TnpNaTNOYjh0WElHM2ZYS0gwZGdIdkJDVk9hbTdZN2tXN3JKRVc1VmVnNS91?=
 =?utf-8?B?SDBUeWZtQkttaXZ2elFabThOWUY5UGUzRFVCVmh0LzJ4UVp3djEzWllpcTI4?=
 =?utf-8?B?cGo2ZHlGYTVSejNyS1ZFbkxqeFl3czEwWEhscG1VSXAyQk5rY2ZoMzFwOUw4?=
 =?utf-8?B?ZWhBaDFLZE1VSGpjWGNNZmY0dVNjOWg5RHpwZm5GTnVIbDdPZTdFSFMraXV0?=
 =?utf-8?B?Uzc4OFhQRmg5RnAyUEtKdWtHU285bDhxUHhENnBpYXpWQXpWYzVPRkpYcTdi?=
 =?utf-8?B?bnJnZXM5MkhTSGZmUndHa3ErTy9SMmJLWXhQTWVJUXQ1dFFIKzRpZUFybWo2?=
 =?utf-8?B?ZEFTalBnbElFeldBM3NuSU9ZeSszVnUyNmFOMVd6cjR4OENtcXZPVG9iYlJ2?=
 =?utf-8?B?Y2NJQXUvYkNxazUzakJMZksrRzFSc2pzQTFiaVhGaHVtTXphWkxXemJJM01G?=
 =?utf-8?B?ZnM4U1ZLeEtRLzFjc0txbWF6YjEwL25Gd3YyVHd3WEZsTDFHdHNnWSt3YkEx?=
 =?utf-8?B?MFBXMERWZThtUDRmRUNOSW44czBlOUdrOEVta0dSdG5XTlJyYmtYRlRaV1hC?=
 =?utf-8?B?blg0L3hrWDZGRmEydlJVYU95Q1IrUU5vQ2hpdmdTWm9oR2hDWXVjY3JYSWZv?=
 =?utf-8?B?YmZTb3Y3S0piZ21EUTdCSmkxaHhldklDRDh3a1BvOExITUJ6Yyt2S0twSzRn?=
 =?utf-8?B?REwwRTJsaFFnVmhNa2tSU2R1TzhKUXdWRWFFaWNJWkU2eEkvWUxaWmNlRzE4?=
 =?utf-8?B?TFZhQlRmeTcvdG9NUnFHR2VlRERTZzVzUnlNeFdUcmxQNUN3Q0hYd3hDbnV5?=
 =?utf-8?B?QzlzZ3RnWmVORnhGdm0xVWovYUF3VDlXU2NlaGZKRndWODRZZHZuV0dvdUdx?=
 =?utf-8?Q?9PuihGxA33BaLpLA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6184f893-09fb-423d-af21-08df244e9a4c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 08:40:12.5602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HHt0zrkwYvnf1U/d1Xr8cqAFb2ZATjc+1EayW3rSLjJCdsIe30mhYL5H0P31JS5RsV5gLMxruuYlPe3cLv/7mbXIxbW6UC2x80a+G1g+Xmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB9058
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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


