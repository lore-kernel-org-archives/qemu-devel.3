Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63213CA5FA5
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCC8P-0005eO-RK; Thu, 01 Oct 2026 04:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCC8D-0005OR-11
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:27:10 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCC8A-0003Pc-Vd
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:27:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=deMyiNUXveLBoyj1fHYi3ufEPgpRxcqYuZK8qnsMUunHgoKBl/SHss2BZ00Rjl8hUMbMSYL8XZhE88vSwUXriSOUf0maMoqEor6sTYaNvcYZTJwjDLeAa/wlFwZr18ZHq7A/tE/xCQnWURF9EdVKoQJgFJDeu4GQ/ORKwgCTcKrAxU6wrMtgGC4zTZ2ziY9A9E7cnNHWOZe83pIqKr5Tg2ZORxb8le9YJrF2+B8t+7DP2G8wY2AYg99cgSVPL0rVM8DaFC4CRU9UVvyMbHjAogY7dVpuMLjUmhBAznsUe/zr1dQUkHNB2FIrQ9gfgfwFJ9Hh1RQrg33EysotvrBS4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Q/HDXLoyiC61Uu3uiyDBlQDft7G81VamCAO8Ca1qio=;
 b=sVsLzuBQfbKRPllLfkMxtvLArVkYvkjTI9KRVAKNB55qTcy1IzZSdiQPk88KnJKkh7QNMZCgVcDRKQTU9voIRxCGob9xdJOvO7N+ox4dRsMCBzRY+ds+PV89t+wy2neDVW4efzcFxMzvjcXdHZ9pRGKujFJgrBhi6tjbEK96WfuU12xMQAALD5LEp5XviNQ4OYmP5KdkXOvvthiDPdgauALIw+UMxn8SFHuVhDHf5ht5l/jxDbvSXhalJcdNgtwEE5yTY811tvN5yLmaIqSrIQBpxW1Wssc27QAalSDPlmHh7G/q6S9N7iTYWNDJpdjiebzlNFAZN46kMgUUDSDEAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Q/HDXLoyiC61Uu3uiyDBlQDft7G81VamCAO8Ca1qio=;
 b=EHFnV5UMxWnlwUe1iM9zqwVzJ2xyZ/E9rPr32fFP23vQ2BLkBsd8et/Ou5WtAxQ5t2J5QKDXKnR4g9sCWmE6ymKrKdNTKfB5R6Ixom3SsWaz+tlnmGBg8w18Lr65E2PnI+scynilkMEPNpKHmdWhgfA5wWxz0NgQQCz6yHz1jiSOkQZT3nPod7qUyQk0Jysk1OrUvxHrcMPrsXe+pfv4mFSi1PC+iPqTCtKwyV+HpCUAdmQviiVThpdTRabmhCjonz9OrXXq6Q9bEKA2b9RMv+r03JYv8IK3QrN2AW3tqOmDjxwNVGy9029g59hRLUP+sxf+lApeqhffm6/xAQC1yA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB9PR08MB9442.eurprd08.prod.outlook.com
 (2603:10a6:10:458::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 08:26:51 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Thu, 1 Oct 2026
 08:26:51 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Thu, 01 Oct 2026 11:25:17 +0300
Subject: [PATCH v10 17/18] tests/qtest/migration: add vhost-vsock tests for
 cpr-transfer and cpr-exec
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-up-vsock-vhost-v5-v10-17-8c094843e98b@virtuozzo.com>
References: <20261001-up-vsock-vhost-v5-v10-0-8c094843e98b@virtuozzo.com>
In-Reply-To: <20261001-up-vsock-vhost-v5-v10-0-8c094843e98b@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, odaki@rsg.ci.i.u-tokyo.ac.jp, dwmw2@infradead.org, 
 peterx@redhat.com, mst@redhat.com, sgarzare@redhat.com, 
 vsementsov@yandex-team.ru, farosas@suse.de, mark.kanda@oracle.com, 
 dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, 
 philmd@oss.qualcomm.com, bchaney@akamai.com, clg@redhat.com, 
 andrey.drobyshev@virtuozzo.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR07CA0284.eurprd07.prod.outlook.com
 (2603:10a6:800:130::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB9PR08MB9442:EE_
X-MS-Office365-Filtering-Correlation-Id: dcb2beca-e91f-496a-7e9e-08df1f95bd06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|52116014|376014|23010399003|18002099003|22082099003|38350700014|6133799003|10067099003|260925021311599003|260925022911599003|260925021911599003|56012099006;
X-Microsoft-Antispam-Message-Info: xaSMFGZ0EtcB7K3JQrzNb4HyFprbx1/F5aUUQ0kq6kUh1KGVQBA89Tw2RbhS7SmNvz1HfhlMAxlz3btTXk/Vxnejgd4i73Qcz0tvjMovaiCdYyXoGRuMZV3/0pE3Toh62AU1Fy52azYxKs4MODlTL/yM2foiT7WQvcNFTLW9bNNugHq2wHSD4ChYVMitz7ssyKLmZmFXWu9evZFqedlrcIXxr6vGTeDXbtUgGoRYt5MBRfylgY4Vem6SNMKBokZkXSShwyvzpThLyxbFMufc2MiwRDeKN0dvhdT2V4GM6F2PgQcgVKZeG5hyXw7RkQT11MENcoh7Dzmt2r7a0R90RDJStt3ZnRgx2nDmHpPFyVrqMmK9BwZun+zy9XbzuKLTaeaiD2Z635BN+gYyekHf1Nu+9bd9EyzWjPIG5QtEkN31htQMlHWCPqCRNzHtwZFWdxducTLE7QevOQoH0T/0xsWK6lLBO7YE1dbn/T7svqHXIEpHXEqtL9iXkjyaPo4yz1elwwcZEthAZlMw+3Qz3815N20Np7w5INhig9ldIFOkDPGZTi97MdMXYpRvDRtL7dG1etwe0WXkpddlQjLO3Pa+V0Yw2jtLmuXxB7jxB+CjoWpIAhpW9OSgy9BIcpeqDeei4Kpu1bhjclpoUDKpQdBeZwH1af8U+9z6/yhJDNAF04xh+LoBwqgV4tjZ440aRLwrOdOpJhFdsJyiqKwyJnwX0mjqA57xVHU36/53L30=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(23010399003)(18002099003)(22082099003)(38350700014)(6133799003)(10067099003)(260925021311599003)(260925022911599003)(260925021911599003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDBQQS9qVGZqU2c5R0xlK0NLcGhHUkZCMXBhQkk4VlhMeW5RYzJ3WlF2b2ox?=
 =?utf-8?B?ejhaRVJubC84cERwYjhLRTBOTGxzWi9USUsyQzN6VHJabUd5MTNIQjZLV2ly?=
 =?utf-8?B?VG1pT2J6RWVXNjJPNVVBMGxOc0x1M0E2V2V6OWZqSmtKMkd6QVk3cG1zWEpD?=
 =?utf-8?B?Mis2anhpdlNhS0hWVHd6TzViY21sQVRDcExreW1MSVAvcFYzY1Z1TDZSbWI4?=
 =?utf-8?B?Z3hUSGFlT2VxclN4QmxpQUJXUFZjYlZrQVRwUUZpYlpIZEo2V1Z6cTkxTlFI?=
 =?utf-8?B?M0xHcnBGRGFYNExKVU1XcldVZWlaMnJIeUI2enRPSXJNQkpzQkRDbjNVYnUz?=
 =?utf-8?B?Z2FrM0FDUmVGVFpUdHpBTWg1T3V1ZlI2bXR5Q0QrbkF6cTM5VWZBLy9OaEZp?=
 =?utf-8?B?SWpFUCtZS1dLZ29uNUU5WmpkZW5sbW5UMXBmdXY2d3FYUjh2T0tHdjM3U2FF?=
 =?utf-8?B?VmN5VzRTWG9YdC9uVmVRNGpQVkRJc1NMTkY3ZzRCaVNQNjlqTFpGSU1lUVdC?=
 =?utf-8?B?MjBNbnN4bDlPRFNVK1FrZWdYOXB0NTJ0c3hYSGZOTmg0blRiTE54aVh6bW5x?=
 =?utf-8?B?K1U1NjR6eDA1anVYMjI5T3FtdnZ1amRLbUREK0NYRjNUNENoVUhBQkpySnF0?=
 =?utf-8?B?a1lNK0NNL1VCYWE2c2YwcTFyNDErZDcvRHlhRFozOGF5Vm9GUk5sdmsvV0NW?=
 =?utf-8?B?YlRCaHhXcktvUHhuVmNFaHRZQTZZMnR2dGRoaC9haXI1UXdIc1NhV01LK2Fq?=
 =?utf-8?B?d1dqWlZkcmNoR2tNcG0zd0hHajVTRFAvUFJmaFJrNUw0RituUWVPMzFydndP?=
 =?utf-8?B?MFNRUyt1akIzV2NQcEdlVGFxQmkvbkhTNEszbVoxbjNSWnpkYzNVWVc0TjNB?=
 =?utf-8?B?d2RETmtySlVCQm1PQ0tsZFRuM01NRXFRaXFWeGpqWEllVXNsbkdwOXFJL01C?=
 =?utf-8?B?ZEZHN1d4MnE1NUU5Zkk0RjBQWkY3UmdCWDBnenZKNEFzQXNuclBBbWlneHkz?=
 =?utf-8?B?eklzNkhEcDNZOTR0QWxHalYxR0V0TW5sZ3pmUWdNR0dkMXYrdGkrMUk3VlU0?=
 =?utf-8?B?OUVURVh2T2lrSVp5V1lVd2Y1TWY5ek5hM1JYb09QVDJsREhJSE5rV25XUmRi?=
 =?utf-8?B?ekFyU0twWTJTR3JZVERiNk1lWjZHN2VRTXR4SXBzeHJaYUdxU3g4bEdJcjU5?=
 =?utf-8?B?Z0FiMkRCTUZzaW1qZGpWZzdUbXd1eW9CYitNRkpkc0h5M1FoSk82ZmJZWDV5?=
 =?utf-8?B?T2NDenlkT20vQU14VG5SRVQvUEtwOFBKbVllZWtCakN5YWRpUnFqOU9DQk9M?=
 =?utf-8?B?azRDU01zT0gwN0lIeGR4dUtQby9BUkM5NmM0c1VxTnhTRUhjWk9PbGgzMmsz?=
 =?utf-8?B?MWJBNjR4dWtENXhpVDRxZ3RqeVFlbTJIZkxYVDR2TUZCY2hOYUxvejZJdkt5?=
 =?utf-8?B?WWhlUFlhWE0wVkoxaTZBaVZxV0d3Tk9tNTNRRGNBZGN2THhBeklMNW9FRkFp?=
 =?utf-8?B?S2ppNU5yM0gwVGlyVWVQWlJoUmJ3QUZveDI4TkRmRmxEaTVvb09VNW8yYnRG?=
 =?utf-8?B?YjZ2dHNiRkJ3ZTVCREFrM2ordzdkbkx2c3lQcUtMMHR2RE5mU0gzS3docVl1?=
 =?utf-8?B?VWJyNHhpZVlKZ2M5Q3lOZkdSOWFWQkFESjNYdlIwMjNrc0VQeC9OZ2kzdTJl?=
 =?utf-8?B?aGUrT2VoQnlLYXo3N1A3UnZKQ2gzbXBaeVM3M3pLalgwN0wzRVpZcXB3L2pU?=
 =?utf-8?B?Rmd5UFNWdjVVTVFnc044ckx1WldVSGZMOFJ4WWt0UXRjOFlubWJYYlZqa05Z?=
 =?utf-8?B?RS9Dc0g4VWVxbDJPbTk4d0UrampreTRyU3ZXRnlaWSszc1FsNkZINVJQRzZi?=
 =?utf-8?B?Y0k0NEg4OE82bkEybVJqWmhPaE4rS0cwUytabFkrOURLblBESFBsUVFKbkZn?=
 =?utf-8?B?eVJaeDRwOUVtMnE2dk1JRWxwM0lGT0NPa045dXYxU3hOWEk5VWM5bldXYmVP?=
 =?utf-8?B?bjVPSjc1R2F5aGlDTGxEaW1pTGY4TGNkSE1GMWZjQWZ1eTlXN05Fb1RENXhE?=
 =?utf-8?B?M2ZpQTRDam9TNlhBQ2lkUU9CTVlaNFJaOUdKaUVqcjVjaFdiSTVwY0FDdDFP?=
 =?utf-8?B?Qks0Z0xSb1g1enUxYjMrZ3Z4clorMlh2WGhzeWxSSGJqdjExVGdUaG0rZnVP?=
 =?utf-8?B?SnRUdXM1emQ4TE84aFoxc0RCeHZUWGFhVjFpc2RTaW1BTjRZV1oyZEZvRGpX?=
 =?utf-8?B?R3pqaUJPdFF6ZTdoeUgxS0VnamlFVHZ5dXo1QUcxcXhaL1h6ZTQvdTJSa3Nm?=
 =?utf-8?B?UUhFZDB5Z1lYUW1aazFyQ2ZYMmtOdVVYMktsM0plS1BCSzJhS1VWM01LVTZY?=
 =?utf-8?Q?yq/wkw5yy0Mqa0zQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb2beca-e91f-496a-7e9e-08df1f95bd06
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 08:26:49.2808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bz5tV1fFo8P7fkkvWMEzvPbXZJ9M+2c7ZkyTlgPMRiJjdhE1C/7aQQmStLj+LgWYHIUKMEPofXCGqSG5l1Ybt8Bru4T5DvS4N/k/7BuWaHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9442
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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

Run the existing cpr-transfer and cpr-exec tests with a vhost-vsock-pci
device attached.  There's no guest involved which is driving the device,
so here we only test the QEMU side of the handoff, i.e. the vhost FD is
preserved, the device ownership is released on the source and re-acquired
on the target.

The tests need /dev/vhost-vsock on the host and a kernel supporting
VHOST_RESET_OWNER for vhost-vsock, they are skipped otherwise.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/qtest/migration/cpr-tests.c | 93 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 87 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 05c2ac1336d..3c21b79001e 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -19,6 +19,13 @@
 #include "qobject/qjson.h"
 #include "qobject/qlist.h"
 
+#ifdef CONFIG_LINUX
+#include <sys/ioctl.h>
+#include <linux/vhost.h>
+#endif
+
+/* We expect this CID to be unassigned on the host */
+#define VHOST_VSOCK_TEST_DEV "vhost-vsock-pci,guest-cid=4000000000"
 
 static char *tmpfs;
 
@@ -101,14 +108,17 @@ static int test_transfer(MigrateCommon *args, const char *cpr_channel,
  * migration, and cannot connect synchronously to the monitor, so defer
  * the target connection.
  */
-static void test_mode_transfer_common(MigrateCommon *args, bool incoming_defer)
+static void test_mode_transfer_common(MigrateCommon *args, bool incoming_defer,
+                                      const char *dev_opts)
 {
     g_autofree char *cpr_path = g_strdup_printf("%s/cpr.sock", tmpfs);
     g_autofree char *mig_path = g_strdup_printf("%s/migsocket", tmpfs);
     g_autofree char *uri = g_strdup_printf("unix:%s", mig_path);
     g_autofree char *opts_target = NULL;
 
-    const char *opts = "-machine aux-ram-share=on -nodefaults";
+    g_autofree char *opts = g_strdup_printf("-machine aux-ram-share=on "
+                                            "-nodefaults %s",
+                                            dev_opts ? dev_opts : "");
     g_autofree const char *cpr_channel = g_strdup_printf(
         "cpr,addr.transport=socket,addr.type=unix,addr.path=%s",
         cpr_path);
@@ -154,12 +164,12 @@ static void test_mode_transfer_common(MigrateCommon *args, bool incoming_defer)
 
 static void test_mode_transfer(char *name, MigrateCommon *args)
 {
-    test_mode_transfer_common(args, false);
+    test_mode_transfer_common(args, false, NULL);
 }
 
 static void test_mode_transfer_defer(char *name, MigrateCommon *args)
 {
-    test_mode_transfer_common(args, true);
+    test_mode_transfer_common(args, true, NULL);
 }
 
 static void set_cpr_exec_args(QTestState *who, MigrateCommon *args)
@@ -276,20 +286,85 @@ static void *test_mode_exec_start(QTestState *from, QTestState *to)
     return NULL;
 }
 
-static void test_mode_exec(char *name, MigrateCommon *args)
+static void test_mode_exec_common(MigrateCommon *args, const char *dev_opts)
 {
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                            FILE_TEST_FILENAME);
+    g_autofree char *opts = g_strdup_printf("-machine aux-ram-share=on "
+                                            "-nodefaults %s",
+                                            dev_opts ? dev_opts : "");
     args->uri = uri;
     args->start_hook = test_mode_exec_start;
 
     args->start.only_source = true;
-    args->start.opts_source = "-machine aux-ram-share=on -nodefaults";
+    args->start.opts_source = opts;
     args->start.mem_type = MEM_TYPE_MEMFD;
 
     test_cpr_exec(args);
 }
 
+static void test_mode_exec(char *name, MigrateCommon *args)
+{
+    test_mode_exec_common(args, NULL);
+}
+
+/*
+ * A vhost-vsock device can be handed over across CPR only if the host
+ * exposes /dev/vhost-vsock and its kernel supports VHOST_RESET_OWNER
+ * for it.  Skip the test otherwise.
+ */
+static bool vhost_vsock_cpr_check(void)
+{
+#ifdef CONFIG_LINUX
+    bool set_owner, reset_owner;
+    int fd;
+
+    if (!qtest_has_device("vhost-vsock-pci")) {
+        g_test_skip("vhost-vsock-pci device is not available");
+        return false;
+    }
+
+    fd = open("/dev/vhost-vsock", O_RDWR);
+    if (fd < 0) {
+        g_test_skip("/dev/vhost-vsock is not available");
+        return false;
+    }
+
+    set_owner = ioctl(fd, VHOST_SET_OWNER) == 0;
+    reset_owner = ioctl(fd, VHOST_RESET_OWNER) == 0;
+    close(fd);
+
+    if (!set_owner) {
+        g_test_skip("VHOST_SET_OWNER is not supported for vhost-vsock");
+        return false;
+    }
+
+    if (!reset_owner) {
+        g_test_skip("VHOST_RESET_OWNER is not supported for vhost-vsock");
+        return false;
+    }
+
+    return true;
+#else
+    g_test_skip("vhost-vsock is Linux only");
+    return false;
+#endif
+}
+
+static void test_mode_transfer_vhost_vsock(char *name, MigrateCommon *args)
+{
+    if (vhost_vsock_cpr_check()) {
+        test_mode_transfer_common(args, false, "-device " VHOST_VSOCK_TEST_DEV);
+    }
+}
+
+static void test_mode_exec_vhost_vsock(char *name, MigrateCommon *args)
+{
+    if (vhost_vsock_cpr_check()) {
+        test_mode_exec_common(args, "-device " VHOST_VSOCK_TEST_DEV);
+    }
+}
+
 /* Snapshots must be refused while a CPR migration mode is set */
 static void test_mode_no_snapshot(char *name, MigrateCommon *args)
 {
@@ -354,4 +429,10 @@ void migration_test_add_cpr(MigrationTestEnv *env)
                            test_mode_transfer_defer);
         migration_test_add("/migration/mode/exec", test_mode_exec);
     }
+
+    /* The vhost-vsock handoff doesn't need KVM */
+    migration_test_add("/migration/mode/transfer/vhost-vsock",
+                       test_mode_transfer_vhost_vsock);
+    migration_test_add("/migration/mode/exec/vhost-vsock",
+                       test_mode_exec_vhost_vsock);
 }

-- 
2.47.1


