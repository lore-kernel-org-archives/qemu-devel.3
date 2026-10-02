Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931F4CA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 13:03:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCcuk-00013A-NZ; Fri, 02 Oct 2026 09:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCcuR-0000tn-ON
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:02:46 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCcuP-0007RG-T4
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:02:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGzJuiokM8o8S3lu6ej37cg4aXch8ZnORURnr6dAVJN1TO/sDxj5i8YJNOa3/3H+HTM5KPUrL9LsTjx19OvAWHTv0QlC3TBRLSs0HCj/uXLyAjmgTpnz1lwR/uMcnEbp9sPCOf65bm8wh2qDERLpZBjjw+BOwyTSCwFjwMwlYQZG2bLyvPrWFCvDbhwqV/26wOumes91SkILAdd7OeLCqZa2J/sMnTHe4IXqjD1oL5H87oIHKcnctOid6rk0wCenU3/LuQMm9TnuqufuvnH0FGs7lzMmyTrfKZHsh7NFiIbkAZk3fP2HvztjMK1xD9rngOx4K3b4v63/GVDFmShGKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsVXvvvzwqJ72NVYywAYrq/LWoyKs50mmgOws/1FLo0=;
 b=PStiVX+XTCr4h/1InIvF3k0Z9MNQRk9L4tUhcZ1UuGMunocap6MT4YUzP3Fz+ti7o0e0cvsLdEJjVZ67GdEnmcSXVVpTKWMqwN+/T95WSGA51/ZS27mYMIZtjuYdByBcOZj3XKuSA79gobHaMvCOHUfTNpXEceNhZaNPXtBlUwpPLss5tdDzSrYH/jj18thgQWkFzSlxvjztQnxmdxsNsxpY0udcHZiK9rxT8lCFY6QWWb6DTtc7cEm7k92jR4hyZvzlFKRhoP4bIQTt1GEjhILDDL/0L7JFqM1X58dxLz4WP2rBVydwpBPgRAB5zIiz0Bc6uqfsvGI15cmWd5WPEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsVXvvvzwqJ72NVYywAYrq/LWoyKs50mmgOws/1FLo0=;
 b=KLnEcqev7TpMNXaCl/Jwestrl22yIjvElsN3s0c5WTY43xt6XaAtGgb8KcP2pH/CCEeuYqg04s5GsO2XxAdFkXxzycVd+7CHr/TCOJh193kSmOVoMeevLIQGOUaBCRLNAxWyUNHs2bMCXajBgZkgUxNl7nQl2uC6sIH0Gl6fVlCG3vQIYPh6vSL+HHRdyaD/Ph8T4dX15VWNLGWklv3JNN51l5qmcaaf2UsgPRuU5zei/CUWGPLYeWO2KY1Sexna5HeO5xbA6+rxzF56z6rJdFFp3aEPkGMt0qSh//xVilI0TUwaD2XUOIW9XggtYR34y8pUeY1ugDKvK1sk3OpViw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MIWPR08MB013052.eurprd08.prod.outlook.com
 (2603:10a6:290:e8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 13:02:29 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Fri, 2 Oct 2026
 13:02:29 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Fri, 02 Oct 2026 16:02:22 +0300
Subject: [PATCH v11 13/19] vhost: add vhost_dev_set_owner() /
 vhost_dev_reset_owner() helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-up-vsock-vhost-v5-v11-13-18fa09d8273d@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 72f107b3-051f-4ea5-bceb-08df20856a41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|52116014|23010399003|366016|38350700014|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6ykfLGnTAZjdtSuZZsLb8fSEbqt+mta0FZQwdC/HLYV4Dwrg5zatYZzPeh2vl5jna9ocWPrElHlNhD5pwit4E/Uq1TLxs6Tos7I9YNeJnLpF8mD8nL350IhVVbNjVDrdx6ZeBFiKzUhT1iQIud9+EkJQSNDGynKC7y9z8JadO2gyXrMtMFOg9fCj7/i6UJ9qZG2Qrff0GzN3Q0XkjOxLu/M8KsWtBx9H7KRlVMmlTxqRBGkJZFEj/TCnT5oNa5nhgmVkpk0IH98ztRWA6jAYxcrDRTaNLueI0Spp/Cbj27SxBmwtO4iPKimBnzDz6u0bdDGn8Xx81mBw0tU7iy1fyzdXRIMXgRdVZrfIW5Hui5dy2opoEkWFSV/l2wikPyogJEjT7B2dCNgq8bzxUi9SFdPLzduHgpxP8RRby5wxJde15PW1It6eyz0UgT2NRsBzzSOtMafSWnfoHpY1AkIyUKx/QrMwDhmLs84U+Upsk0IF32m9cygBFDJmuTNdczlrUSw6N6/Xt9ib6BrKMqNz7XjJvtHfQBvpSrSxrFMuqsdd434K3kBZcl/vIpO0ScTjP2vSH2oDGzWlkP5UB5YH7EfU3CiQg5Ek9o0YgziU7KbLVI1iyNwufVpwyLvufvjM5vegyS8rQnTtSaWTlMskgdHvkeXMRO287FM1FX6cH2tFDS6BtQv3zEWux1li1BEi6qeMYKgUNDsE8S3SbzNUd0rifzq2PqJovVr8hx5UwcA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(23010399003)(366016)(38350700014)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWVxSkZsN05zQXlYSlc3Wm1iaStPSWZkdkIzYTR2T0ZwQUl6S3AxQjd6NGYw?=
 =?utf-8?B?TXk4N2doTWhRVUprVncvby8wZURzQ1BzT3pkUFJlL2EzbVZLZnBYaU5uVWVu?=
 =?utf-8?B?QU5hbnhuK2xjZjI1bUhqREd3dEYwaWF3Sjl2d0w2dy9SWTlmNkc2VkdxRUVn?=
 =?utf-8?B?eDJuV3BqVlJZdE40T1NNbXpXM0ZIcnlWUTJpWVVjL2ZscjBqWUlhL25pQTlP?=
 =?utf-8?B?ZWozYkhEMFRQOWF0ckhmQk4yMTNKeVQ2a3h1VmpydDFoajN2OUtrY2RZM2RB?=
 =?utf-8?B?MXJXeGJKb3ZHTmZrSEwyZU1GVzhxem9MNzNVWVFHdWp4a1ZpVE92VnpReWp5?=
 =?utf-8?B?NVl0NHZuUGRjUzFiMFVacnE0am5NTjRRVUVNV0p0Ym1FWndlQnEyeHo5R2xi?=
 =?utf-8?B?Q1pua1IveFluSTB2YkJwNGU3T1VlS1hxWks4U09QdXdEczNkQkVFSkZCQTFs?=
 =?utf-8?B?a1VNYldrSTI5a1hXMkw0dWFRc3FidUM3RFN4NE4ydTF0Zi9iajF6OW9UU3li?=
 =?utf-8?B?RlNvZGt2WU02dnRuSjVkeE12aXZrSXJCWEZ6K2FwUy9HejFwbTBGUDQ5TGFq?=
 =?utf-8?B?ZzRWZWdYZGV2ZGVPVHR3YlNyNGZHeGl0UXd0cDkvbVB3MUZaSmhVTzVIWjBo?=
 =?utf-8?B?S05ZSzhqdVl6QkRIZEpkRFNEK1ZEaGc3cDBMYkk4R2ZBakEyZllqVVZMYWVE?=
 =?utf-8?B?NTV5ZERPNGFUVThxaVhvbVlZLzYyeTdRVlNuM2F4S1dTQU5oSGVhVHdDZGw5?=
 =?utf-8?B?V3ozVEpvMTdFVTJRZkRDOFVQS0Z2WTB0ak02V2F3L2hEbVVMU25kNmlFRHRv?=
 =?utf-8?B?TEljbFpDaTN5MFRLeUdOS0w5NlhvdVZWLzdrZWpoMHBCdUFwTndJSUNSeTRW?=
 =?utf-8?B?cUQ3RDdxQTRBTStXTWNsd0l4SElPS0Q4MnNzQmZWb3Q4UE51RWlQUDFWNFdS?=
 =?utf-8?B?SktyOEgzczhmN2JBa01PaGVjaDRvTUJVY3FQeXo2VkZRWURMVXh0cUkzMlVh?=
 =?utf-8?B?cUNURldyTzFqOXJ2TGYwcGl1cGRVemptcDRPWG5BSzU4NGVPRzZyams1RENI?=
 =?utf-8?B?V1VnNmMvdWJsUjgxKys3YmJ1WFhoaDY2RjJKVno5a3doU0tXbmVDQ2NOR09S?=
 =?utf-8?B?cHQ4RCtJNWZYOFpab2NzZk5rT2ZidHNUN1RUR0Y3MTlXRUtROXljMmw3VWpz?=
 =?utf-8?B?OTJNZjcwSEU0SllQY0xPMVI5b0hhclhLem1BSTV4MGZFbDVVQlF0bVQxZnpn?=
 =?utf-8?B?NktnVGxFYmZuLzhIcjNhaXhmbjM0Vm85MXB0YThObm1BOGlPN0ZCSHVnSXFj?=
 =?utf-8?B?b0I3K3h5STJ0NW9RZkdyVFRKVFJBcVF4ZWx0MGdjRzRpYkxJOWQ1Qzc4WWZD?=
 =?utf-8?B?aTR4Tkd3RlZ2eWVNeGhBd2I4KzRxd1gwNXlyVVUvVHI5NTQ2a096eEhiZDly?=
 =?utf-8?B?RFB0T1ZjQmRtTUJ0eVVTWVdvOUgwL1NZVUxUYlkvQ1lnYlN6Rk1PdHptOEpD?=
 =?utf-8?B?WmVGNTNaYWVsUitTZlA1bjlORUF4R0daQmpDUHVhUDV2cnVVU2tkeHNUbkdO?=
 =?utf-8?B?Z1dWWlBzU1RXa1hYcXJ4cEFQeW55d1NsOU9LN3BhZ2M4bFV4dEpWb0Irb3pR?=
 =?utf-8?B?QUNONlVlV0g5SGdMR3l6TnlKS0dseFo0eE5kMzRCMlN6V3dVKzJXT1FxL0Z4?=
 =?utf-8?B?U0dtT29IcmpVOVF5RzZRUW1rR1pMZkcrT2E3d1F5SEtBK0psV2JxanIzWkZO?=
 =?utf-8?B?bzNaNy94YjJGSHRRSzY3MUtqTHhOcGsycWFEVEtLYy9zcDZ5ZmlobHpTNjBS?=
 =?utf-8?B?OFJvczgyTGc4QWJnYkV1RVV5TE9xbmYycnh3cURINkV3b3dNNTIyd09ZYTVu?=
 =?utf-8?B?cXFZc0hoL0o3VFgvQW4vV0J3TGE3S3FxdnNqZGVEb3pPdnZ0VnlRRTdyL25v?=
 =?utf-8?B?RVpQZnU4VmhzRkNsaSs2QndjcnhaYVlGRUhsVmJmTjNQYnVKVTJ5b3VlbFA5?=
 =?utf-8?B?elVyOEhUT2NXbXlBbzBYWVU3Rll2M1h5SytwVmhkSjdsZzlkeEdXdnN5U0pK?=
 =?utf-8?B?Q2hTYVJTWDhqaTZNT3R1Ty9WampuaGJFUzZ0T0krdGFSd3ZzUE5qQU5HSTVP?=
 =?utf-8?B?Zm1MNjNVbXJLcWRYeVlodlBoUERUYk5NbkZLN3lici83R1J1L0JpVExqRmRD?=
 =?utf-8?B?R1RwOWppaVlTcHpHZUNpNFAyOHdoUytHd0V6RWhpVDhiQnVMeXNmaWlzY1h2?=
 =?utf-8?B?UnZ4U2o4Q3dYMGFYdzVMNXN5czNaTmY5RmdCN3pxSXpxa080WmNmSWQ2d1Nq?=
 =?utf-8?B?UndSYkVCcHlvdSs0eURuaHdBaS81a1FUc3JTTzBpU0FNUGZmSXQzTytEcGEx?=
 =?utf-8?Q?Q0codX17JZ3pcF0g=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f107b3-051f-4ea5-bceb-08df20856a41
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 13:02:29.6930 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CoyhP30jAJrBhj0AFmuSSkm6fUephAfqrqcG0KmbF/NAzpv0AZXWs019emoMwQNH3PwJljmW/4i9myCTKpAyRdGHt0K7rHMojjyfAPSCp4A=
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

Wrap the set_owner/reset_owner backend ops in dev-level helpers, matching
other vhost_dev_* wrappers, so device code can take or release ownership
without reaching into vhost_ops directly.  vhost_dev_init() now uses
vhost_dev_set_owner(). Both return -ENOSYS if the backend has no such op.

No functional change.  These are used by the following vhost-vsock patch to
hand a device between owners during CPR.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c         | 20 +++++++++++++++++++-
 include/hw/virtio/vhost.h | 25 +++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index dfdfd49da3f..56fa4345886 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1703,6 +1703,24 @@ int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
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
@@ -1720,7 +1738,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
-    r = hdev->vhost_ops->vhost_set_owner(hdev);
+    r = vhost_dev_set_owner(hdev);
     if (r < 0) {
         error_setg_errno(errp, -r, "vhost_set_owner failed");
         goto fail;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index b2b644c0d1c..8127a9a5a2c 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -178,6 +178,31 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
 int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
                            VhostBackendType backend_type, Error **errp);
 
+/**
+ * vhost_dev_set_owner() - take ownership of a vhost device
+ * @hdev: the common vhost_dev structure
+ *
+ * Issue VHOST_SET_OWNER on a device that has already been set up, e.g. to
+ * complete a CPR handoff on the destination, or to take the device back on
+ * the source after a failed CPR.
+ *
+ * Return: 0 on success, -ENOSYS if the backend has no such op, negative
+ * errno on failure.
+ */
+int vhost_dev_set_owner(struct vhost_dev *hdev);
+
+/**
+ * vhost_dev_reset_owner() - release ownership of a vhost device
+ * @hdev: the common vhost_dev structure
+ *
+ * Issue VHOST_RESET_OWNER so that another process can take the device over
+ * with vhost_dev_set_owner(), e.g. on the CPR source once the VM is stopped.
+ *
+ * Return: 0 on success, -ENOSYS if the backend has no such op, negative
+ * errno on failure.
+ */
+int vhost_dev_reset_owner(struct vhost_dev *hdev);
+
 /**
  * vhost_dev_cleanup() - tear down and cleanup vhost interface
  * @hdev: the common vhost_dev structure

-- 
2.47.1


