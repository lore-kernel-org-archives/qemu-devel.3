Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4872CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:31:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGDHh-0007vw-7p; Mon, 12 Oct 2026 06:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDHI-0007hN-Rg
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:29:09 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDHE-0005FA-Ry
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:29:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNar4qNTPh+czuoSB8aqnqaWLN6cveKfOA8D0KKA+kg/fwHybx0L0ksDmkvV2R19K/kzOSLXYXh0/xKoNuTkQ8qUoAkNikJ69xuilV01jEbdD4s1yo4OE2RVqodm0cHDIMfFSuO9pE+pRVA0vgOB9jT35e1iQeDe/unnujtOgzbnCXV7JoWPgJR7YTtumqDHUsRjfCsj2Xpje861fX4YqPL2+Q1TF7xeyg41nN9S3iaOS22CFlwoOLWpkfXREUN/86aAjb9ltAQP+0KwrjYBCSTkhz+3WRIzXfisJpsLIu38HCC+Eyed7pPdVgLlq0niho2GgDhH2tvvp819VaIfMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/loml3enlc59rmXiaz7S5sIhG/WnHAXU5sTXFnDUBVQ=;
 b=lrwpq2Lou35Bc7dBEo7YCFwMcgH7Sp6m8vXzmQboM38CoKVh6vhZHI8oopivbEeqG91w1xuDeYxrjTTn6XlWm6WdJeDquKtGKUDYdGJ9ImqSTCn5pVrNA9aW/SSi77toga6Baa5buInESF22ARi+BDIHDbaKgLwj5CX8qvezdo1YTVE0z7ZA3qFhA7CMOKg73ADpBnZMY7PRWCYtaPqra1pFDWRgwh12uCsCbSfv8jellIkaSQptiLft2BHOs7AnrsUTF3XRO4Itukd0n7VYleCKmxgzLP6DJFIkHryVnBqjbQ7d1OV8k6CkwH1Z/AjEXtbzNl0hmRpj499/9CyErQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/loml3enlc59rmXiaz7S5sIhG/WnHAXU5sTXFnDUBVQ=;
 b=TeRb8BfUKSqh5ZPcUQl8zlZQYhxZgn53NOXtNcApsWuWlpX10peOwTSB2su/WngWS7OoVTyHNOPNliC+B43dpiYK4+uTPY03UM4eFRwGFnXjyhfPHECAjJsyFc1vDmdMEUIZDyJ5UCs+lPZwS5ek9Bxon2+raag+W7ly51DpDgm3UqPT9chu7GxovICohmO86xZlwdukU/49y3Xx+ZIaQjlyAoF81IUBu3WAN/g7g6Zey8JkVkzcnLXivXQi5e3M2X2w0A+hJfY8o7d4huRj96o7eQT2xBTRaiZx36BoPUO12qZUs0Rn3xMTDNFr7bzy/Jy7kEq/kXaT5MuN4fKigQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM0PR08MB5523.eurprd08.prod.outlook.com
 (2603:10a6:208:17f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.11; Mon, 12 Oct
 2026 10:28:43 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0522.008; Mon, 12 Oct 2026
 10:28:43 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 12 Oct 2026 13:28:23 +0300
Subject: [PATCH v16 15/22] vhost: release ownership in vhost_dev_cleanup()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-up-vsock-vhost-v5-v16-15-36c38bd15ffc@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM0PR08MB5523:EE_
X-MS-Office365-Filtering-Correlation-Id: 74f56524-afb8-4cf8-31d6-08df284b9712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|23010399003|366016|10067099003|22082099003|18002099003|261009223027099003|5023799004|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: jiqhn03cjP8pME0YHOZ5T//4zrX+ZvgbFWFQ5g2QXl+B6wwbxdpxiE36GgTZO4n1MT4RVBcNHCfrk0EnlM3kLSjR3zIOWhBm3xh+L8FrZQZZDm00o4rts9Uu+8RorW5nhiy7vfDUs2LBbMqk709A3woXwuihqU2nH9hfeGjdgYm98oZBka8wtFSlSOcH8K9s4sHOOGrJdtL1/7WiHYbYjGHbfh7IhgL3aIq7YzLD7GCEp/0seA5xHII49Rl3oBnaQ22cKAQfLVb29TXDfINI83tyRchjq7p+O5BTysxRNOexZeq53o9EBD7DFoI2PW9sPFpj3eHIDP4aZPFpzEwANtrjGOH6OE0elzr1Ohz9lWrUe7cVXmaMKeSNCUDF2QIBYKcoJEDdRQ03ty2th4QT9ssY2ZxQQgLk0Za4lCB1yUPMTyxPY8wfDhfrtGF8mWKnGd/I1Z1QwVlnxDxGv9OL/Y9OfquHgWrr6apMP/Z2ZrMeoVqhqAJylAPdW2UUWGWiPySJo5kNTQVdU0inR/WPxaalSzWWKqQip4V5ZpUA0a9D3YHvKM9bljaivhBkAWeuR9WwU6DapAe37/Ejl4cWShQ7nvzOXAWtLOFixYFlmm9nAm1NmE4JcLSMN0jPwn1IqAZXHzM8H4TcckLivr/xIiTssaODSTO2gKwT7wi/uQYJ+qzTgs85qExscIELlwSMQZZLaZQutLHTNewzjv3FxGNU+7GMHHJ6YldcIh9+fx8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(23010399003)(366016)(10067099003)(22082099003)(18002099003)(261009223027099003)(5023799004)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmZtY1loamk5Sk5qRWdDd1dMK3VtVmo4dnh5RnMyVE14bWdRbUNOeDBLWFgx?=
 =?utf-8?B?Z2tQVEIrc2ZnR3o1L2NIY1dzYlFFL2IrNUtaYTFiNGhXRzBta0NpT1hReU9L?=
 =?utf-8?B?bUxIQ0dDSjd2WXBQcjM3UTRRUEYveWhBZ3Y0RS81L2phNEUwQVg0YVkraFJk?=
 =?utf-8?B?emhSTDN6bjh6ZWorVlZvYjZXVktZczBzN2R2Vy9pcStSZVZ0TjhHMnhmWkYz?=
 =?utf-8?B?WnI3WkFIOEJWVHRuMWlKN285aFFWaFZWY3lkc1ZGdjM3RTh6SEMyUnJLSndP?=
 =?utf-8?B?NVZkVXhpMjRHSHZ3YkI0SGllOFNSVTcvWWZ2YitNbkt3ZW9KUlVvalNSVGhJ?=
 =?utf-8?B?M05ra2dSZmdGM0Vhc2VidXNOWDQxWGh5YmkxY25vZE9iUGtqVDJ0N2tZYWdB?=
 =?utf-8?B?cVJ1YmVJNUdqVlJ4eWpVUVlqNEEvaHA5OW44L2l5MXp5VTlGbGx4R1IzdGNR?=
 =?utf-8?B?QndPM2hEanRuYWhqTzR2akJVZFBOclNYRFJqaGttS25XZjZQbzI0c3pEZndz?=
 =?utf-8?B?NUx5SlVkbmVUbkdEUk1mZ1hheGNXb0h1aE1rY2t1UGlBVkNxNVMvNnprVUdC?=
 =?utf-8?B?TmxNWFJIVlJKNmxTdVQya1F2R3pOLzNQenZ1THBmSG9QQml2MjFRazhmYi85?=
 =?utf-8?B?a1JTOWhpSk1aNXkyZTdEcnJmOThXaEdaSzlnREJnQ0hDL2FXS3BYdCsrU3J4?=
 =?utf-8?B?UExZaHkwS0k3RTY0Q2RNd1dVNVJqZ1g2eEprbHU0SGRTeUx3V05BYW9tOXEw?=
 =?utf-8?B?TVBINmxDZnRIdlEvaXJUTHNTcysxYTN0Zm5aOFpFSHVVVUNOd3A2Q0J2RExq?=
 =?utf-8?B?bGpWYktvMG5tUHpCeTBGNFJXU3YwbWVGZC9vTlc3eWx5Tkd2L0VTQXJqZ1RO?=
 =?utf-8?B?WS9HNHFqazIyaWJ2aGRpVXZyTDhWRWsrNmFEZnpFWVFGZ2ZsY1NmS2Mva2NC?=
 =?utf-8?B?dnV6SW9WSlhWNXNsVXMxVXU5ZG8vWmwxaUh1a2o2Tk9WdW9sNnNYVnl1eTl2?=
 =?utf-8?B?UHVlTnJBMDd6WkZKTDB5L1FENkhqSXhoRjdtcktjVU5jWVRCYTVYcFArVUla?=
 =?utf-8?B?QVhQanVQTTFvVTlXdjRLTHF4SXl2bDY2enRmTVZmZXZiZ0Fodm5qM2x6czJJ?=
 =?utf-8?B?aWRVY1pkcnVMdVd4cFNCeXN5Yjg5cUs2Y3MxM1RxNU1TOXpQUDAwOFQ1SU1V?=
 =?utf-8?B?WlFaZFhKUDhNOHBIc2VPSy92SUlVYXA1VFFPWGdITHh5aWZCZlg5dk9pS3Z4?=
 =?utf-8?B?ZVIyamlyUmtudTAzQjlqQXRncUkrODJCTlAxUXRFR254Z0d0MkN2OTFpeUFD?=
 =?utf-8?B?cUd2UUhIV0xhdmFobWdUaG5tckN2c0Z3WVpXMkRPclZVTVdrOW1relhoVHB5?=
 =?utf-8?B?YVFpVzJDMWkzcWVpbVd4ZFkxbEpDS2VRRFFWdDEweTAwOXBGUHgzRFB5V1FO?=
 =?utf-8?B?R3BDM3FwVmFoWUlydFpDRkViOGZaUnhFbE10dEJIK091TmJxOE9ZNnRSaGtF?=
 =?utf-8?B?T094M0lmMzNTNWVRbHpQOEg1eHpkNm1lcG5ic1RtbkRBZWhqeFpBaFNOZGxj?=
 =?utf-8?B?elJ0elBzRXgydFZVMmR3T01OZCtVTU42VVUxbHFZallBUVBDdzlXMmJqYTlq?=
 =?utf-8?B?YjMxVmVMRnd4dFQvTjUzVHMxOWUwTUVYR0twVFFrNzlhQzZwOEV4cWpJanJB?=
 =?utf-8?B?VG1ZbDY2SFlod01tb1V2MmEwc2ljb2RmYUFRY3JqY2xIa211NGZFZzAzMkZx?=
 =?utf-8?B?Q2JBdTMyWGQrb3B1UU5VNjNUUi9CVnNDNDAxekZEZ2tScGFsVmVzZkxkZGVh?=
 =?utf-8?B?Q21WUWFVOG4xQ0JHWEx5OHl1b1pWVm80QWJaVHlhTDYzaUVFQWtSNmpTeFdr?=
 =?utf-8?B?OGpzYk5xVEdrdnpxYjAwMS9uWmN1a1UxNzJIZWRQN24zMWlmR0ZhamNrNjJj?=
 =?utf-8?B?ZXZzcUsxN21ldVhWN2QrbmNqK2RqWVpNSmo0RFhUUmd2K09USTlHU3U5bVY3?=
 =?utf-8?B?QlBzN0E3eWNxbG1zT3VBd1dyOWZKNEk1T0EvdVV0OEdncUVHSFlRVzYzU3RG?=
 =?utf-8?B?bUZGZzJsblVpelg0Rk1PUkdRRjJyRDRuL2pwZm54Yldib2ZxN21Gcm1JUzVR?=
 =?utf-8?B?RzZ4cVM1b2ExMTRWQjNzZTlIckVnZWNsRzYwMUZQeVBRakpxa1U2RStZTFky?=
 =?utf-8?B?MHNLUStETTIxT0dOMTZ1RWhFcnRKY3NhSzU4UUl3dXUxcTUyVHpCb1c5bEJ6?=
 =?utf-8?B?RVJieUY0ZlJLNC9QMDFQMTdhRFp0czVzNFJoTERxUkEyeGZ2ZG1JREhHdUdF?=
 =?utf-8?B?Q0Q3TVFqdXUxKzlpYldKKzFzQU9kakhVdkQ2dUFudmNPYjkxenlQNGlNc3Fl?=
 =?utf-8?Q?fT07UDLf+/isXCBs=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f56524-afb8-4cf8-31d6-08df284b9712
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 10:28:43.4861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TWV4q7Dpq22ruHOtjtChVAoRBz7QLa5E2vkj1TZp0T9D2GokuCNNpoCLZVgPGYDt1frJPp1a3/jywqV+jwgKhG3O/yeqrasPwvl7l4+J1xY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5523
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

vhost_dev_cleanup() closes the backend FD, but that doesn't release the
device ownership taken with VHOST_SET_OWNER if the same file is open
elsewhere.  That's the case on a CPR target: the source keeps the FD,
so if the target fails after SET_OWNER, either inside vhost_dev_init()
or later in its caller, the ownership stays with the target.  Once the
source is resumed it can't take the device back, SET_OWNER fails with
EBUSY.

Track the ownership with a new 'owner' flag in struct vhost_dev, set and
cleared by vhost_dev_set_owner() and vhost_dev_reset_owner(), and issue
VHOST_RESET_OWNER in vhost_dev_cleanup() as the common teardown for all
those paths.  Only do it if the ownership was handed over to us by
another process, which is marked by the device with a new bool flag
'owner_handed_over'.  Upon ownership release failure, we have nothing to
unwind at this point (CPR target teardown), so we just report the failure.

Reported-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c         | 40 ++++++++++++++++++++++++++++++++++++++--
 include/hw/virtio/vhost.h | 11 +++++++++++
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index c01ccc800cb..085e2ef6f16 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -53,6 +53,25 @@ static QLIST_HEAD(, vhost_dev) vhost_log_devs[VHOST_BACKEND_TYPE_MAX];
 static QLIST_HEAD(, vhost_dev) vhost_devices =
     QLIST_HEAD_INITIALIZER(vhost_devices);
 
+/*
+ * Release the device ownership if it was handed over to us by another
+ * process, e.g. the CPR source.
+ */
+static void vhost_dev_try_release_owner(struct vhost_dev *hdev,
+                                        const char *when)
+{
+    int r;
+
+    if (!hdev->owner || !hdev->owner_handed_over) {
+        return;
+    }
+    r = vhost_dev_reset_owner(hdev);
+    if (r < 0) {
+        error_report("vhost: cannot release device ownership on %s: %s",
+                     when, strerror(-r));
+    }
+}
+
 unsigned int vhost_get_max_memslots(void)
 {
     unsigned int max = UINT_MAX;
@@ -1705,20 +1724,32 @@ int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
 
 int vhost_dev_set_owner(struct vhost_dev *hdev)
 {
+    int r;
+
     assert(hdev->vhost_ops);
     if (!hdev->vhost_ops->vhost_set_owner) {
         return -ENOSYS;
     }
-    return hdev->vhost_ops->vhost_set_owner(hdev);
+    r = hdev->vhost_ops->vhost_set_owner(hdev);
+    if (!r) {
+        hdev->owner = true;
+    }
+    return r;
 }
 
 int vhost_dev_reset_owner(struct vhost_dev *hdev)
 {
+    int r;
+
     assert(hdev->vhost_ops);
     if (!hdev->vhost_ops->vhost_reset_owner) {
         return -ENOSYS;
     }
-    return hdev->vhost_ops->vhost_reset_owner(hdev);
+    r = hdev->vhost_ops->vhost_reset_owner(hdev);
+    if (!r) {
+        hdev->owner = false;
+    }
+    return r;
 }
 
 int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
@@ -1864,6 +1895,11 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
     g_free(hdev->mem);
     g_free(hdev->mem_sections);
     if (hdev->vhost_ops) {
+        /*
+         * Release the device ownership if we hold it.  Needed e.g. for
+         * failing CPR target, so the source can re-acquire it.
+         */
+        vhost_dev_try_release_owner(hdev, "cleanup");
         hdev->vhost_ops->vhost_cleanup(hdev);
     }
     assert(!hdev->log);
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 73ea130d7ee..efe1eed2606 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -111,6 +111,17 @@ struct vhost_dev {
     bool started;
     /* @initialized: has the full vhost_dev_init() completed? */
     bool initialized;
+    /*
+     * @owner: has this vhost_dev acquired the device ownership?
+     * Updated only by vhost_dev_set_owner()/vhost_dev_reset_owner()
+     */
+    bool owner;
+    /*
+     * @owner_handed_over: CPR target side.  The ownership was handed over
+     * to us by another process (the CPR source) and must be given back
+     * when this vhost_dev goes away.  Set by the device.
+     */
+    bool owner_handed_over;
     bool log_enabled;
     uint64_t log_size;
     Error *migration_blocker;

-- 
2.47.1


