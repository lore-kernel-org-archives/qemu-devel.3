Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE43C43602
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 16:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd9iB-0001Qg-WC; Fri, 26 Jun 2026 12:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wd9iA-0001QD-17
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 12:47:26 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wd9i8-0007dq-6I
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 12:47:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=voyx+SagNpvnurCM0+2XxoCToR25zDuMvPsMzPvoDAMnRMDVrmjTzwvUtRUiMycFvwD5eO1K5i7DA26MURcCk0R5mth8X0f+eyDWEgi8TMJUT+b7Pq+7F021UttcM+So+DEajxiPjU8CgJ5DFrlUpkQR5zUPAmRIoRAuQU4aH0Bf9BbZifn6A34T83kLY26/z6e0yQq0WkX/ggx2L+0TeR5X+zYTIlS3I0cRKHJvZFmlMHrlphM9NPkAwlPKx1vGXF/dqZed3yiUadhjij64Kvozh7OwnteiQKBxQuNKwHyf0Ks0TUUU1sEGpZpvWLtF+1CiatE3hheqnLuZzVuS9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWjLJ/q9dFHjP0mairF30QN8tLMnE6pjHjyFGjiaNPw=;
 b=UWMYZNGX/9qfiyEP4aoYoaPICK7k7OqI4QLvo2UluZwALQEjmXWYt1uM3USF6LVxmeNTaXF4aGvkvZLt1VqjWhL58pMVfFU/qvyXoXB2GfDlQ+bOEkpjFx6BXDvfjWQMHvKJfTRq37JAQsoaXG5ShZl46ShKCpK8yiKC1dqgxHmXgVobH+r0/0UkV9xhbryKYlsqFvtlWKobZ/sG4dKT2X4xqJKh8yzq1ak0/1NOnE0I6lRzv/Qwpr6o9e4eh/DMT4a78+KWPDmHf8NMw/SFgRtRDR62a9hM6Y2CpaG+s/JOA8HFzNobmayKEfCTTbr/a4oxjZ1UNxG5LiqKLOFlcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWjLJ/q9dFHjP0mairF30QN8tLMnE6pjHjyFGjiaNPw=;
 b=yNqTTteuamDSkTdWinMzMKo3nfgrmTwQz6hzPZmrfdOVZwmODtInUj7+LQzMVecgkOiL+isjkIhiq/HeL96Yt5yLqZL4XONrMixOMxlKxdqHn3RiMeGgJPP5yc2Lj4KZ3isE+La/AmZ4CkpQXUV5gFqEnBCEyEF/y0YfpL6f4Y1upJsFcn3aSxd7YxPIBguyB+LCE+408UN8Z+qlC3htLjuosaJRmkUBFmKkMNlF5MxBNvMurYL9FfQH4i6/LfFzdTq1bMynU6impqGWlmelToQLe9V6guJG8nqaiO7RIuRzOpSHPCvOoUzUSCVhYvVf+GL7upZzmxeS1FqDM+xEAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB9PR08MB6347.eurprd08.prod.outlook.com
 (2603:10a6:10:253::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 16:47:04 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0159.013; Fri, 26 Jun 2026
 16:47:04 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, peterx@redhat.com,
 dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com,
 mark.kanda@oracle.com, den@openvz.org, andrey.drobyshev@virtuozzo.com
Subject: [PATCH v3 6/7] vhost: add vhost_dev_set_owner() /
 vhost_dev_reset_owner() helpers
Date: Fri, 26 Jun 2026 19:46:42 +0300
Message-ID: <20260626164643.2526-7-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260626164643.2526-1-andrey.drobyshev@virtuozzo.com>
References: <20260626164643.2526-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIUP296CA0088.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35c::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB9PR08MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ab22af1-2245-48b9-6ce0-08ded3a28d8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|52116014|23010399003|376014|38350700014|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: x7IUrF16e/yFg7mhKJVzPa0CjIK7fBkFgfnHXZamWMTHPMQmFDGtrgx+W+dAs0eLm3b7Ece5m2INOfMinUAzRD3WzFRktuiYpsjh2Mh9VPsDF+m51YC59ZiyU7bs+JElMgQJng6LIyIlG3+xN1zRCBlhb1BOOCv8GMx02jOzP8dpomZKQMhCOkTpl8NwTuET4Srn7B8Xyz7tFlbm390wkznhi6J0vi1PdQKfp3CMY/FSqfGZwsylaP3bvff70KHt9BQ7w9WSEZwdYVnps8fQ7/nWUbf+eva6QDxujEBhpI7ZXN6vCdHpjWnch6B/hHFz19S0F64wv7E6CwNhFbFSDVf+z+dqTZi4i5B/OM65NEUlQP+20uDBn2ELe9e740XC1FdprWuliNb24VlCQH4TFDjrM5FDC8AsRx20oEtmJvsCaYQ+VzXaCBeYqhfwDIaFLKJWadzxvF557VIj0h263/1UP88al2uN6R9CNm0R5fXYCnuOwbMj/N0GWpMHzLU3oWe0ltpszM97HjVgDuu7XG22JgnjbKv1TPnUCOCfKGSRHopBgXHWS5oieeMrpZ1iOvfL044uEvsdWaOdHv9wfZX6g7BfjyBY+ECrFoTnL6MS9ldsE4dGTkNcikmbxiSSTCYw8P+1yE/c17b+k6b6fCSFo/tcFRVwUeQb/JI+FHPSS4ZhtW2HonVbw+R/JfiimlDsficeVVUD0q1M7x8sKK3DnobqHlVQI0KPHZmDCdc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(52116014)(23010399003)(376014)(38350700014)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZLG9PcTeg2JCYHxgWIdLQ9urBLeqTjuL+/ukim/soAqJ6PZqqdUvDQ8UGwcC?=
 =?us-ascii?Q?gTqz7sDrIrj+8Y4EmP422xBhkXqBd5Rx7WWP7MAESu/pb6E/h0NFKdw5aDMv?=
 =?us-ascii?Q?EaHkNIWCCt9kN6/OR44EmRQMrvG6w/piMHPT1+Hb9kdg4bGs02I6oBaaqXpK?=
 =?us-ascii?Q?GmSVO0UHYRw6/W1mQvOHBA5v4PadH3WU940hrLTL2dyve5LlSgqrOIEk75RI?=
 =?us-ascii?Q?/5jzYXPPa44yd4LAibUXFVA14TfFTri7pVETK7UxV+Q27VMfnLKrRQKxLo3V?=
 =?us-ascii?Q?iD6c6VSFcvXdJZsZAf6ln8oRCd+5JL2AVesQF4m0rbzB2iEOYpwpFDqD2nDr?=
 =?us-ascii?Q?cfX/pL4etzdmU5tV7yTotXgk8/JfT2J0/MkPQkgybfdvHOZTQRZeo+3ZPuds?=
 =?us-ascii?Q?pqdUj/jKfgL/RA0MdL4dKPpAXdFyKUAdN5uSeEqfKEpDyvG2EBh0I4qY7i5Z?=
 =?us-ascii?Q?om81aycHrybkIISJY5Lu4qLgoZG2ncxyYN2HqetDde0YEBLDV1dpOtUSpTXD?=
 =?us-ascii?Q?zgW/K5otVGSrmJnsRuEn7X61RdyLnoTBmrfpX/OaSJIvrpzDbjch5dRpf1p2?=
 =?us-ascii?Q?12N3OTSsOXaqvbi1NCVnq308XZnfugqwCCKE5Ia15Yyd3RLUe+6usMohdcnd?=
 =?us-ascii?Q?BGJodFWJfJE6qYjdOnIcNymIKSYb8NFrnZUMsQSN7RYpARfQ458m738bx8OV?=
 =?us-ascii?Q?q6599khVZJWelF443ofZ7rtc1jGQSSMNTgSP8An77NPkcCtC9qQrxky3C2ax?=
 =?us-ascii?Q?S/bW22q1x6JsdzWEOEE0kWiUUILZUQGSBrrUgZQOMEVK9BSpk413zahC329V?=
 =?us-ascii?Q?l05IPDfQv0oh6Ogvop7YIYDADR9R25ySwGJKYAxpgl2mQwcNizh+p6w54OVG?=
 =?us-ascii?Q?JOXyi8IO+ZGWQKFwiEYTTfGyJZm/W7tZvzzQEqR1v4vJNcTZOwEdZHQYCD7/?=
 =?us-ascii?Q?75qX/UEVuC3YWG7kZDl7N48GTpSi5M4ttW6AMf/fIjZm1FFwdruiW3sS1sFT?=
 =?us-ascii?Q?KHFY2txUZyS6b8JE36qsj77h7wW6QdC5WIrmaOHzlorklshzMPEBT01XSt4Q?=
 =?us-ascii?Q?4U/QYZYplzN7tux4E0VuqzGR9SgSNxNsjURqmOzW/n74vMs3XoLP5pj0KEWU?=
 =?us-ascii?Q?BcRenz2D0ucwthKpp8pmffggpG9bspUKPlYc+16mvlXcXGxzogmhpOeMqoHE?=
 =?us-ascii?Q?0QwQ4jx+IyEXI0TN542oTs3p0Mhg5TAFVhGtyhRBJV2LR0sVELpB8FuqWzIR?=
 =?us-ascii?Q?thXAzAuGNw1VnatC9PLgequCBPOXdP4eI687X+g+61AJypnptsDFFmhaARbi?=
 =?us-ascii?Q?1Z10OxVDy0rFo+Q2EirEekOTUdp1Xx9aWQRUslUNdQW+zkBfrI4R4QCOpuoZ?=
 =?us-ascii?Q?gU8jcXe6+bLn6K62IAQ/wUUr0Q+NHeUyTwdj0lbeNWNuM98AKijw1JcxPUsW?=
 =?us-ascii?Q?OrogqkyU1KRipP6eoij4M56g7Klhv+J5J+QnlHfRM4K6YRx3n+UO1P2gv1Pz?=
 =?us-ascii?Q?0am/uuvH1R1fmgMfBgOd9LPvSBaW9ulTlUhqP7XyHT6iqJwPhOW5/5pFg6vZ?=
 =?us-ascii?Q?GVQPS06pQoAjUzf3nrASpjA0Vt8SeCvisrPnA6GVq8iday0Fc8ctZcMAzylU?=
 =?us-ascii?Q?NWqVhi8JS3pKmeUJ7+Bqc3YxB9OPCrmn7R+4ASHH5Yfw/8NuOEp5mxrE2iUh?=
 =?us-ascii?Q?B0q8xUr/TbKbWkjhNYx9/RzfNdAoyMLT294WcuvXEOUq3D0XUB7dbhZ7CtJK?=
 =?us-ascii?Q?CX8C04/PirrWDmyaYHfPPgiy5rwet70=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab22af1-2245-48b9-6ce0-08ded3a28d8a
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 16:47:04.6976 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AzeH3lT6QoGl137OX4wxqeePkK4Q00dw9x/Ktdu/67Nsap+DDv1UwQQjGVkNlUNj/zuC2EbdzzfmTSZYPbo6yjnVXJZGZrez7RmNOzT6hXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6347
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

Wrap the set_owner/reset_owner backend ops in dev-level helpers, matching
other vhost_dev_* wrappers, so device code can take or release ownership
without reaching into vhost_ops directly.  vhost_dev_init() now uses
vhost_dev_set_owner(). Both return -ENOSYS if the backend has no such op.

No functional change.  These are used by the following vhost-vsock patch to
hand a device between owners during CPR.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c         | 20 +++++++++++++++++++-
 include/hw/virtio/vhost.h | 13 +++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index f11588cc51a..7ae2abe33cd 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1689,6 +1689,24 @@ int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
     return 0;
 }
 
+int vhost_dev_set_owner(struct vhost_dev *hdev)
+{
+    assert(hdev->vhost_ops);
+    if (!hdev->vhost_ops->vhost_set_owner) {
+        return -ENOSYS;
+    }
+    return hdev->vhost_ops->vhost_set_owner(hdev);
+}
+
+int vhost_dev_reset_owner(struct vhost_dev *hdev)
+{
+    assert(hdev->vhost_ops);
+    if (!hdev->vhost_ops->vhost_reset_owner) {
+        return -ENOSYS;
+    }
+    return hdev->vhost_ops->vhost_reset_owner(hdev);
+}
+
 int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    VhostBackendType backend_type, uint32_t busyloop_timeout,
                    Error **errp)
@@ -1706,7 +1724,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
-    r = hdev->vhost_ops->vhost_set_owner(hdev);
+    r = vhost_dev_set_owner(hdev);
     if (r < 0) {
         error_setg_errno(errp, -r, "vhost_set_owner failed");
         goto fail;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index bc81e09663e..a56a2b66bd5 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -175,6 +175,19 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
 int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
                            VhostBackendType backend_type, Error **errp);
 
+/**
+ * vhost_dev_set_owner() / vhost_dev_reset_owner() - take / release ownership
+ * @hdev: the common vhost_dev structure
+ *
+ * Take (VHOST_SET_OWNER) or release (VHOST_RESET_OWNER) ownership of a
+ * device that has already been set up.  Used to hand a device over during
+ * CPR.  Returns -ENOSYS if the backend has no such op.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int vhost_dev_set_owner(struct vhost_dev *hdev);
+int vhost_dev_reset_owner(struct vhost_dev *hdev);
+
 /**
  * vhost_dev_cleanup() - tear down and cleanup vhost interface
  * @hdev: the common vhost_dev structure
-- 
2.47.1


