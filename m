Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAE3CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENsj-0004hh-WE; Wed, 07 Oct 2026 05:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENCT-0001Sw-1O
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:50 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENCQ-0006kK-Rq
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=siRhOWkdQW45fqMIcJSG59bC8gtrHOQw6rl0fUKENDf2yYpydaoQ0Tbc2HDVxfoIocg7CROtcanadLxPWDxL0LTKxvcYTTiQSBgBboKgcqCJ+s6fZ2YMJef2HdKePY+hYV9gytkRuBk/rQ1p+kvxHKXn+fIYXI0KHfLLxgoahQRhg5fdy6AGl2YK7E5kwyzNnYlsVxh5HcXGXRnFcL7NElpoGEs5z+jBsCA6aaVSBuz1PytuJ56vlZWgdG8NpEY1wNHoOixajktfxs2J5A06S6zqZXAkPl7c6fz7Xq6SVS6Ax87xUvwQBzJvGqxGYsiraulUQzEW1Mm4sBw0XG/jeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9uyq7mQIpionRYH4TGd39qHDkvCHjkKh3DniesFcmA=;
 b=WFv6KK/4yfMPMqFLEsxgPPGORkX5VK3NDFx/eTy89ME5TMa6vtmyudpf7/KFIPu8HkOBoQLLKPv6HHLwVW70d2qVifug/VM8RY6A+brd8kK0Dtph1zvCjlR9/bdhlygZ+iswFobj3EFAAXXnjvTl/r+Znj9yqo1PLse5oXYfsHy0YeHpVDoJOIRHFrrWIn3DksLwdVRDhjp3MM+nUqLLUDksmIVlgshTY+H7hQmU0VThESBBzK15IcWf+7UODb/CRqgkrwPUsYKTNyW11ujueIGyKyqG1r7n/40fNN0xODHARU8Km0/EGuL1GbXcG7WfcQV6kkIwTvHW+5ZvuVx4Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9uyq7mQIpionRYH4TGd39qHDkvCHjkKh3DniesFcmA=;
 b=snKKDs57eDoiTl4kjOHhRCsppUjrHoSIribQ4Kpt5prpJwhetFO/EEgvF1aO7Qnz+oU6bJ+lEroUIaCk8DypEE+OfFIvEoaHIW9QUJVPfTrJnNpA7ljIlUIvhlu83SxjGmCv38gZTrQaMdcH9xKJuOZy00POISD8Aq4oSlfoWbniis9Ia+m/GLSOrJvtl7qTM0gZgiYbCcitj7LCZJ6ACJDZBvT4D+k4FdfusVAWwgZTqM7x3IX9aMx3FAgo5PDhCMkJ8/mgjD8ouIIrxh2QfPTZttANLdfzgDNd5G1BockPHLyzuE0MCqoXw7qL9VFB8VkuVrlFApzbBBb7boUaAg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB3PR08MB9058.eurprd08.prod.outlook.com
 (2603:10a6:10:430::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 08:40:13 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 08:40:13 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Wed, 07 Oct 2026 11:40:15 +0300
Subject: [PATCH v14 22/22] tests/functional: cover a cpr-transfer target
 going away with vhost-vsock
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-up-vsock-vhost-v5-v14-22-e16de9962df0@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0f873170-c95d-4ec2-d0fe-08df244e9aad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|23010399003|366016|1800799024|10067099003|56012099006|3023799007|6133799003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: +hXkATxhBdlboDFEUEBr4eRbPWyGMmOGBj7bjsHUzQZAiM87w53bn3IOy0joZ/4io5GDa9aKuvSHhVWl/pfy1OOcXKCPXEsHiUNYucKtK+Tssx60PjcOIgSXgNH+GujiG8vJSbn6mdeA9wkUmqBB+6XmpWMeTlogTUuL+qCOpTFVqoro073ypggv2VxZOYRF9C5gISL2tJKdrVeC3mxToHHqGeu6j5pyBEI9TGzSWLAuFhDEM7hzj5X4uogPhsCn4ofMNpZfzfAE5slmokTMY8eVw7Skmrdgmd/WmbVR09FirKupu8ltaOuUrFXT6oQ29hvhXbwgaG6M+1Mr/u44Ddq9EEnPGjNzvVG/6koqK024FZ9ZR11WgpR5Nwh4Gr3RsdCcZ+dZKR0PpttYw+2/IaCd4PN98d1u1S/okeE29XE6ISwLfc2IIeqp4vL9+DgTBtVdM1ETqAhAJ3w67t9ie4QNCl73kzARzy2ESUXhxL8VZb4yBcxt1yZGYEDSxI7T7TkI1sE1skGRtQiwr8K7sSlwZNc0L6cpleGueBewlH93Xy+da4Jt8SH64gGZmu3bl5WAF4CPiKB6O9ogK1vh6b0PYseZkMLGHrV+fQOwMNlOKdRsjb1RPGkeWXtCUGu52MOz8npskCNo2dw6y/HPBsefqbGRIHTINnwAlsa7wwKe6ORHNDC+Jk49ncxWOH74m2lsm8v1d1/xUMj57aA9WhqcGPfY5i9DD1tB/RH3g08=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(3023799007)(6133799003)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFNFSDF1dmJ5RTM5UWdGZEk4YmlTUmhRWFJDN2tUWnlUUE54Z3hmRlp6YUox?=
 =?utf-8?B?cVZZdFVnYUlLMEduSmhVaWdyRE9Dbyt3cGkyaTVidjBGeC9Jd2V2cFppYkJx?=
 =?utf-8?B?ZE5maEYzd2thUDRKNVRjWWZTVWpXck9EcXdybGwwdDBiKzR0eXU5LzV3b3gy?=
 =?utf-8?B?Q3BJZ3JMU1hwTGlrRGswVHBmbVE3RFVSZno5L2hVQlRmVnJKRG14WXFlSC84?=
 =?utf-8?B?ZjhYa29oQkZFb3VtS3lZWEJFR3lvTWdETnE4YnYvR0JuMG8zSHh1bjYyUGk5?=
 =?utf-8?B?eVBOVVRPU2x1ZkpUOGgyeGNQTW4xZldJeVd0V1lVK09wSngvcHFucy9QRnho?=
 =?utf-8?B?UmVnaE9Nc3BpVXB4ZWJIS3pPazNQQjRKKzRoNkxoZlV2M1A4NGN2ZmUrV2F0?=
 =?utf-8?B?OUl3dlA4c1ozdUxOQmxPTHcyWDl5a2Q1TmZwemdjbjF4Tk43VmZSelJWV0Zy?=
 =?utf-8?B?c25odFE4L1ZiSHRqYVZ0clVTTGhjc0VveWhkdWpKVUFrNGtEdHFUZlhCb25q?=
 =?utf-8?B?akF5VTg5cThPM3gzYVk4ZHd1R0Y2a0JEdjNmbHNRby9UWWFtSmx6ZGdOOVFt?=
 =?utf-8?B?WTZZY3R5ai91ZzFacEltcmRCTDFEQVR4OE1RTHdiNWp6Ujg0T2hHRE1zZVY2?=
 =?utf-8?B?NjRocEEyQWJwL29RcENQb1RDV0RLNE5ObzVCa1hDYWZqeFVHYXd2RWV2a3NU?=
 =?utf-8?B?bkkzMm9DZ2t1K0tFcmYxby9saGE5Mlh2ZDR2Q3hZSTZvbjNLWGczSURqMGZo?=
 =?utf-8?B?Z0FtTktWcDYwRzB0NFhlQWxFWG9tcUNCOHlmUUF6cHBsYklOV2tRbnZiQ2g4?=
 =?utf-8?B?UWJOQ3gxMzg4RzJFZjlQVm9QT1pSbGdhVE4yZWtEL2pXNGFoUFQwVktKcFpU?=
 =?utf-8?B?M1dJUlQwZlhPajRrWDcxc09aUVgvajlnV1hKNEd5a2FQZVNQTGhZaWY5clky?=
 =?utf-8?B?akd1N0o1Z2NraTZZMEtXTzFBbk80WEtHdzRDaEVLQXVYaFo2emlGUTZNbHZC?=
 =?utf-8?B?ODRTRXY4M2FDQmswdGR2RDhLbThzY2JCUUxzZjNzQ0RaNlgwb3JxR29Ib3lx?=
 =?utf-8?B?R3dwYU9HVDJjTkhOOGk4ZmFyTjdNYm9ncllSVU9mZkNvM3VBak9raTVpNFlG?=
 =?utf-8?B?bWZZV3dLR3E2RHVjZkxKSXJURHhEOUFwMWR5enlhQlphWGRLT0hvcW05MlpN?=
 =?utf-8?B?amo2ZVdNSGRVNTJPeGswVURMVnFDR3dHNU1PMHpZamNaNkpJRmNwRkdIckxF?=
 =?utf-8?B?NUZqZktqRkJ0WHhzSVNUZTlrVXZpZEphd0dCZUZ3czVQeWsyOW1nSFBlUUYz?=
 =?utf-8?B?Q0pNSEVZR2tCL3dNZnNKRDdBLzNZejlDb2NCa2pKVlBaWVcwc2p1bHNkeFpv?=
 =?utf-8?B?Z0EwTHdRMnpYbytyV2RTVmw0bVMvalhHTGFNejBOSTZLcnhab1k2eGExK0l3?=
 =?utf-8?B?QWJqcTN2RUJVVGFJdWhrZzUvUzN2bnhHWW51bnRiN2FicXc5MGE1REc4QnNq?=
 =?utf-8?B?NnVrRzdzNzQyU1k1bnczUGJEdHZlbDF6cGVlbnpPV0ZyVWpFK3FwVFRyM1Nv?=
 =?utf-8?B?MUR4d1U5UWVOZ3pvc3YzclNjbStkNkVDNG9UeStpTFVoUGdZNTZFQmFuUXMv?=
 =?utf-8?B?VnhwdklYK1prNzVBcVNoWjVhcUhQcjZSaVF4RTg0N0lqSTVVbG9ST1F3TS84?=
 =?utf-8?B?SElTWjJ5NlovbVExQnkwUXdRckc2WlFiRlhLUkIwQ09USW9nOGprSVZKU2Ri?=
 =?utf-8?B?dmtBanJrNUs4TDlxaU0vcHhHYThhK2t4dlJPb0F2elpKWjFrUHcybmphNTdk?=
 =?utf-8?B?b1paVHdscnBxUlRiZU5wRWNRY2hlZHowdnZ2YVpUNVpTVHN1QllJSktTSnpp?=
 =?utf-8?B?SzdzMnlDZ2ZzOW9HeHlsVXJzT2VWZmlMV2s4NkFjeG1SKzhtNDRFejByMHZY?=
 =?utf-8?B?NVFYZkxtY25JQk5Ia2JJYS9RTS9uczg0UGc2dFdTb0NNV053YUZWK1lZSEln?=
 =?utf-8?B?UStkcmNzY0ZvOC9MQ2EwNm9mQWg0by9mVEVZNk5jK0NMOERDaVZBWjZic2tY?=
 =?utf-8?B?VTJMc0haREJDbmN0Z2g1MlNSdDZ0Tk1hLzJ1eDhxK2NYNGF6bnhJMnFnTmlm?=
 =?utf-8?B?a1ZuN2dnZEJ2ejRNbHdJN1UwVlhqeWdBTjUxbXZyaC9weFE1QWdUQlRXdms1?=
 =?utf-8?B?ZlNXd24zRTV2UHlGc1BYUEU0dnNWNDdlOHk5MDhxc0hSb1pFM1FJY2QrK1cx?=
 =?utf-8?B?TTVMSG1tekNIY01vaDJURDhjZkw1Rm9DNlZDQ1lHZlo5ampSeURReU14TFNG?=
 =?utf-8?B?OHJVOXBHZHRicUVVTHFKTmFueXQvODE4T2pxU2tPTFpnSWtoRDhlbHY2QTg4?=
 =?utf-8?Q?cj0UZwqBA1kS/V/s=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f873170-c95d-4ec2-d0fe-08df244e9aad
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 08:40:13.1966 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hgrTCfTFzW8/n4bS50pqJ2iNKfS/7nHp4iHn0KYumRHcPZsHj703TRnkn+bDM6fDEeV67h+yFFHDTdOLV6tOPqbijti5dYtxcdPpwlcs/04=
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

A cpr-transfer target takes the vsock device over in post_load().  Make
sure the source gets it back when the target goes away afterwards.
Three cases, in the first two the target is made to fail the load by
lacking a device the source has:

  - the target exits on the failure (default exit-on-error); the source
    is stopped beforehand, so it stays paused until we 'cont' it once
    the target is gone;

  - the target stays alive (exit-on-error=false) and the source resumes
    on its own (return-path capability);

  - the target loads the state while the source is stopped, stays
    paused and is quit normally; the source is resumed instead.

In all cases a host<->guest transfer must then work on the source.

The transfer helpers get a payload size parameter, since the plain
checks don't need the 512M of the stress cases, and the target start
code is moved into a helper shared with the existing cpr-transfer test.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/functional/x86_64/test_vhost_vsock_cpr.py | 178 +++++++++++++++++++-----
 1 file changed, 140 insertions(+), 38 deletions(-)

diff --git a/tests/functional/x86_64/test_vhost_vsock_cpr.py b/tests/functional/x86_64/test_vhost_vsock_cpr.py
index 035307fc82f..3ac0a80c5ed 100755
--- a/tests/functional/x86_64/test_vhost_vsock_cpr.py
+++ b/tests/functional/x86_64/test_vhost_vsock_cpr.py
@@ -24,6 +24,7 @@
 VSOCK_PORT = 5000
 
 TRANSFER_SIZE = 512 * 1024 * 1024    # file size for host<->guest transfer
+CHECK_SIZE = 16 * 1024 * 1024        # enough to just check that vsock works
 CPR_INTERVAL = 0.2                   # interval between CPR ops
 
 VHOST_SET_OWNER = 0xAF01      # _IO(VHOST_VIRTIO, 0x01)
@@ -71,11 +72,6 @@ def setUp(self):
                                'qcow2', '-b', self.ASSET_DISKIMAGE.fetch(),
                                '-F', 'qcow2', self.disk])
 
-        self.payload = self.scratch_file('payload')
-        with open(self.payload, 'wb') as f:
-            for _ in range(TRANSFER_SIZE >> 20):
-                f.write(os.urandom(1 << 20))
-
         self.sock_dir = self.socket_dir().name
         self.cpr_count = 0
 
@@ -121,12 +117,16 @@ def attempt():
                 return None
         return self.wait_for('QMP to come up', attempt)
 
-    def wait_migration(self, qmp):
-        def completed():
+    def wait_migration(self, qmp, expect='completed'):
+        def finished():
             status = qmp.cmd('query-migrate').get('status')
-            self.assertNotEqual(status, 'failed', 'migration failed')
-            return status == 'completed'
-        self.wait_for('migration completion', completed)
+            if status in ('completed', 'failed'):
+                if expect:
+                    self.assertEqual(status, expect,
+                                     'unexpected migration result')
+                return True
+            return False
+        self.wait_for('migration completion', finished)
 
     def wait_running(self, qmp_path):
         # Make sure we're dealing with the new QEMU after CPR
@@ -139,13 +139,37 @@ def wait_running(self, qmp_path):
             except QMP_GONE:
                 pass
 
-    def boot(self):
+    def boot(self, *extra_args):
         self.guest = self.vm
-        self.qmp_path = self.prepare_vm(self.guest, 'source')
+        self.qmp_path = self.prepare_vm(self.guest, 'source', *extra_args)
         self.guest.launch()
         self.wait_for_console_pattern('login:')
         exec_command_and_wait_for_pattern(self, 'root', 'root@localhost:~#')
 
+    def start_target(self, name, main_incoming=None):
+        """
+        Start a cpr-transfer target listening on the CPR channel.  Return
+        the VM, its QMP socket path and the channels for 'migrate'.
+        """
+        mig_sock = os.path.join(self.sock_dir, f'{name}-mig.sock')
+        cpr_sock = os.path.join(self.sock_dir, f'{name}-cpr.sock')
+        channels = [
+            {'channel-type': 'main',
+             'addr': {'transport': 'socket', 'type': 'unix',
+                      'path': mig_sock}},
+            {'channel-type': 'cpr',
+             'addr': {'transport': 'socket', 'type': 'unix',
+                      'path': cpr_sock}}]
+
+        target = self.get_vm(name=name)
+        qmp_path = self.prepare_vm(
+            target, name, '-incoming', main_incoming or f'unix:{mig_sock}',
+            '-incoming', 'cpr,addr.transport=socket,addr.type=unix,'
+                         f'addr.path={cpr_sock}')
+        target.launch()
+        self.wait_for('the CPR socket', lambda: os.path.exists(cpr_sock))
+        return target, qmp_path, channels
+
     def transfer(self, guest_cmd, host_cmd, cpr):
         """
         Run a socat transfer between the guest and the host, and keep
@@ -160,21 +184,26 @@ def transfer(self, guest_cmd, host_cmd, cpr):
         exec_command_and_wait_for_pattern(self, 'wait %1; echo RC_$?',
                                           'RC_0', vm=self.guest)
 
-    def transfer_both_ways(self, cpr):
+    def transfer_both_ways(self, cpr, size=TRANSFER_SIZE):
         """
-        Send the payload to a file on the guest's disk, get it back into
-        another file on the host, then compare.
+        Send a random payload to a file on the guest's disk, get it back
+        into another file on the host, then compare.
         """
+        payload = self.scratch_file('payload')
+        with open(payload, 'wb') as f:
+            for _ in range(size >> 20):
+                f.write(os.urandom(1 << 20))
+
         echo = self.scratch_file('echo')
         connect = f'VSOCK-CONNECT:{GUEST_CID}:{VSOCK_PORT},retry=10'
 
         self.transfer(f'socat -u VSOCK-LISTEN:{VSOCK_PORT} CREATE:/root/data',
-                      ['socat', '-u', f'FILE:{self.payload}', connect], cpr)
+                      ['socat', '-u', f'FILE:{payload}', connect], cpr)
         self.transfer(f'socat -u FILE:/root/data VSOCK-LISTEN:{VSOCK_PORT}',
                       ['socat', '-u', connect, f'CREATE:{echo}'], cpr)
 
         self.log.info('%d CPR migrations performed', self.cpr_count)
-        self.assertTrue(filecmp.cmp(self.payload, echo, shallow=False),
+        self.assertTrue(filecmp.cmp(payload, echo, shallow=False),
                         'the data came back different')
 
     def test_cpr_transfer(self):
@@ -184,29 +213,11 @@ def test_cpr_transfer(self):
         it and shutting down the source
         """
         def cpr():
-            n = self.cpr_count
-            mig_sock = os.path.join(self.sock_dir, f'mig{n}.sock')
-            cpr_sock = os.path.join(self.sock_dir, f'cpr{n}.sock')
-            target = self.get_vm(name=f'target{n}')
-            target_qmp_path = self.prepare_vm(
-                target, f'target{n}',
-                '-incoming', f'unix:{mig_sock}',
-                '-incoming', 'cpr,addr.transport=socket,addr.type=unix,'
-                             f'addr.path={cpr_sock}')
-
-            # The target listens on the CPR channel: wait for it to be there
-            target.launch()
-            self.wait_for('the CPR socket', lambda: os.path.exists(cpr_sock))
-
+            target, target_qmp_path, channels = self.start_target(
+                f'target{self.cpr_count}')
             with self.qmp_connect(self.qmp_path) as qmp:
                 qmp.cmd('migrate-set-parameters', mode='cpr-transfer')
-                qmp.cmd('migrate', channels=[
-                    {'channel-type': 'main',
-                     'addr': {'transport': 'socket', 'type': 'unix',
-                              'path': mig_sock}},
-                    {'channel-type': 'cpr',
-                     'addr': {'transport': 'socket', 'type': 'unix',
-                              'path': cpr_sock}}])
+                qmp.cmd('migrate', channels=channels)
                 self.wait_migration(qmp)
             self.wait_running(target_qmp_path)
 
@@ -217,6 +228,97 @@ def cpr():
         self.boot()
         self.transfer_both_ways(cpr)
 
+    def test_cpr_transfer_dead_target(self):
+        """
+        A cpr-transfer target which exits on a load error after having
+        taken the vsock device over must release it on exit, so that the
+        source can be resumed afterwards.  The target lacks a device the
+        source has.  The source is stopped beforehand, so it stays paused
+        on failure until we 'cont' it.
+        """
+        self.boot('-device', 'virtio-rng-pci')
+        target, _, channels = self.start_target('target')
+
+        with self.qmp_connect(self.qmp_path) as qmp:
+            qmp.cmd('stop')
+            qmp.cmd('migrate-set-parameters', mode='cpr-transfer')
+            qmp.cmd('migrate', channels=channels)
+            self.wait_migration(qmp, expect=None)
+            self.wait_for('the target to exit',
+                          lambda: not target.is_running())
+            self.assertEqual(target.exitcode(), 1,
+                             'the target did not exit on the load error')
+            qmp.cmd('cont')
+
+        self.wait_running(self.qmp_path)
+        self.transfer_both_ways(lambda: None, size=CHECK_SIZE)
+
+    def test_cpr_transfer_target_quit(self):
+        """
+        A cpr-transfer target which has loaded the state but hasn't been
+        started yet may quit normally, and the source resume instead.
+        The target doesn't unrealize its devices on quit, so it must
+        release the vsock device on exit.
+        """
+        self.boot()
+        target, target_qmp_path, channels = self.start_target(
+            'target', main_incoming='defer')
+
+        with self.qmp_connect(self.qmp_path) as qmp:
+            qmp.cmd('stop')
+            qmp.cmd('migrate-set-parameters', mode='cpr-transfer')
+            qmp.cmd('migrate', channels=channels)
+
+            target_qmp = self.qmp_connect(target_qmp_path)
+            target_qmp.cmd('migrate-incoming', channels=channels[:1])
+            self.wait_migration(qmp)
+            self.wait_migration(target_qmp)
+            self.assertEqual(target_qmp.cmd('query-status')['status'],
+                             'paused')
+            try:
+                target_qmp.cmd('quit')
+                target_qmp.close()
+            except QMP_GONE:
+                pass
+
+            self.wait_for('the target to quit',
+                          lambda: not target.is_running())
+            self.assertEqual(target.exitcode(), 0, 'the target did not quit')
+            qmp.cmd('cont')
+
+        self.wait_running(self.qmp_path)
+        self.transfer_both_ways(lambda: None, size=CHECK_SIZE)
+
+    def test_cpr_transfer_failed_target(self):
+        """
+        A cpr-transfer target which fails to load the state after having
+        taken the vsock device over must give it back to the source.
+        The target lacks a device the source has, stays alive on failure
+        (exit-on-error=false), and the source resumes on its own
+        (return-path).  Then vsock must still work on the source.
+        """
+        self.boot('-device', 'virtio-rng-pci')
+        target, target_qmp_path, channels = self.start_target(
+            'target', main_incoming='defer')
+
+        with self.qmp_connect(self.qmp_path) as qmp:
+            qmp.cmd('migrate-set-parameters', mode='cpr-transfer')
+            qmp.cmd('migrate-set-capabilities', capabilities=[
+                {'capability': 'return-path', 'state': True}])
+            qmp.cmd('migrate', channels=channels)
+
+            # The target opens its monitor once it has read the CPR state
+            with self.qmp_connect(target_qmp_path) as target_qmp:
+                target_qmp.cmd('migrate-incoming', channels=channels[:1],
+                               **{'exit-on-error': False})
+                self.wait_migration(qmp, expect='failed')
+                self.wait_migration(target_qmp, expect='failed')
+
+        # The source resumes by itself, and vsock must work on it
+        self.wait_running(self.qmp_path)
+        self.transfer_both_ways(lambda: None, size=CHECK_SIZE)
+        target.shutdown()
+
     def test_cpr_exec(self):
         """
         Perform consecutive cpr-exec migration during vsock file transfer,

-- 
2.47.1


