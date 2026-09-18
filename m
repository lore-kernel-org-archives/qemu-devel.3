Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3F3C982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 13:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7YwR-00038X-9v; Fri, 18 Sep 2026 09:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7YwQ-00038I-A4
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:47:50 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7YwO-0003Df-K9
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:47:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XAUPcGb8z6QU/CwzS9xVQwh1CXOKx4LeQCn7WOpxyD+ZcGt442hzhzqJFERH+IEVXk7qCOkKFYWQwRuvBHB7XEC+dDreJrPRDQP4rLAqYIRWR1N9nlhSTyBxvTqhsjQevA+Ownoap4Qmp3Vg0IKTDj8RYeDNtXkSZFApP23WdP5VMTOodfvxyDorB/GYbYiNnO/6gSnHUHjDLJma1LDwDPrD3y0219uzJSYIaLAy3B8fqAjl5sNYjnwtkD57fy8+KMdz8T74hbMZu8wmOizK1BFxtCxxOjfwmz/C6467dYwFqr/ygpNq1TOqaPlT+mLLU/rPlgk76JnHmTeG5AwTWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zZJ89Z45bQcI+MDgmQM5LzF7kuk0PxBH91uljpEleQ=;
 b=WWuYO0rnFwhKC5LxBNWV0lfgFFI01F8TtLtyx8S7jfN2z2QZCx6OnAvqHHS5Ywtabtpsr+RyINm8bGDdqb30g/rgzwQENKpu6EB37GWrUhg+uQ/6E2vON2h7GJPiOe+PDulVcRUP6G/s2/r1CrTO53Znz0uyie4HEGEiaA3i5K1GZTvZOl+n6e5Jfnb0wtPrmjuqjab/L6L+bJKKHO39rK0Hbk6LHRMtLwmvHK+H2e4s90CBUdX0VvUnxAx83fnKhzxEsZb8wNh6DadpU7F6COkc1S3Od5578DmCqubef8byYeF7MeKMO+DjAUjg0f13vQRBA7bsQ3Zl4oho+IR7yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zZJ89Z45bQcI+MDgmQM5LzF7kuk0PxBH91uljpEleQ=;
 b=p3LMgjldH4dV0CGwAFY1WpKZgAzEpaHPUe2++2blONo4sW7LXZUbHmApVmn3wXUHZ6eBw/9033kB+qUc9E7pEy1SdvOZZ/2SeMzx4yWbUbe7QUQ0K0l1948Z1K4pcTfFZGzZ5D0m4fhIOX7UaNZC+AK8bOAdNLfPRIAzTDpE9NbHPh484MjY5nrMUABDGYZ2CPQ7VqWN/aSgD+QYLDjpcWPAQrlI6vd7K0hNZ1g+qZjU24Lmqsb2MuPBQGBPpgsmsYTSpNQKACokhK3Z5rhRAaxV/1svox1GxjOMKvkY8jmHQzjF9oMX605IcS406w03zZPYyNj/0JKEX8mQl/G+sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB4PR08MB7933.eurprd08.prod.outlook.com
 (2603:10a6:10:37b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Fri, 18 Sep
 2026 13:47:25 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Fri, 18 Sep 2026
 13:47:25 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Fri, 18 Sep 2026 16:47:01 +0300
Subject: [PATCH v7 10/16] vhost: factor out vhost_dev_init_backend()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-up-vsock-vhost-v5-v7-10-6ef9ef033c35@virtuozzo.com>
References: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
In-Reply-To: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: farosas@suse.de, bchaney@akamai.com, mark.kanda@oracle.com, 
 philmd@oss.qualcomm.com, vsementsov@yandex-team.ru, 
 andrey.drobyshev@virtuozzo.com, maciej.szmigiero@oracle.com, 
 dongli.zhang@oracle.com, mst@redhat.com, clg@redhat.com, peterx@redhat.com, 
 den@openvz.org, sgarzare@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR07CA0292.eurprd07.prod.outlook.com
 (2603:10a6:800:130::20) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB4PR08MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: 48e0ef32-6858-42df-4cdc-08df158b5eaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|52116014|366016|56012099006|10067099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: dX4EAUzJo4/2eqLrwo1eCzGLS+TxM3Py7LygPQOgvWd6jnGkAudxUjGCLUmHhn7bwcuzTtEoUb75QiyuTYm9XbwnSVNGgNUItEkwjkMMgJbs+5AV7cvkDMTC435SfeL/xQkZqYe3qTfHR6uuxtKH7VpnW7Rfhcf/B/LupmW0Xfvh9Z8c3oYJKawP0DDob0d+L2yu3t8onzPQMVjfBY2WF9Paa2DWl56oY77TcvhjOZFpFlvW/SrTOQlm+h6TW3/ltgx3tbetPkZenCJHgx/mzo03apwv9hlAv2m5w38BrIuomesz1bPrXE4uign6JDNiKPiD5nE8rZ9tza7+IhB51UISRKzGLA+7eASdHBW6OffZzU1AYAusaNWliGBcIRnftGBxy0ECS8J/nAMGLTnTIHnIwiZV+qEai/IgOiQJbE05rYGk8uQU+psPjMEKhFy6PnANzFzTHLwYowc+og8m+bn7oMZtFIJ9eEQAqzg8ods7XNTznVGLuTyYJBoh79XSaD9LC2yx9FlBi77zh5BrYy15RJjWksMXpgqwaY2vZGPidzxI6uw3IR7B2+c4PDSmKjTl43a6hKcKB+z7N2qQgP/MYhPCD5t3dZwPOqqfsqnbrYjHk4camxRc/ajdB/U2OvZwV1Ds3Er4zmrTAcKDICshFXT/UHUQVkv3i+iMeZStzdFyMvMIzpziznFTRzArH+3pEPgWqvIV9abJgeK/0Ts4l/U/3BSs1fToyGnVjE8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(52116014)(366016)(56012099006)(10067099003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFllNXloNGU2Q2pjSjI5Z1IwR2d2cGxjbnhIYkMzM2NoNUR2REJHV2U0N280?=
 =?utf-8?B?UEwvUEVjUnZ5QTNPUzAyZmVCWmFDZ0t1WjAyYlBQYUdXejdHTFB3ZmIrQjRY?=
 =?utf-8?B?U2lEZE1hVlhqUitFTW5URFJTZjJ5cXpRRCtpVmJjdytJUE05UFhjWnlNVEdh?=
 =?utf-8?B?eE5xUXFHVTN1NC93bG9tZDBkSG1FOTVpeWhQVWh5RzZuS1BobzE0UXNNcTBI?=
 =?utf-8?B?eWRGYWNZU0V3UzJUVndESC9nWWxWODM1RDE1VnNiTy9vRVIvb2ZBTmI0aFlY?=
 =?utf-8?B?N0lMOHRKQ0hFRDVyT3hEYU1IUzRMK1NSVWFUeEFaZGFjZ0Y2WkRZcWptekZG?=
 =?utf-8?B?Tk9FU1dHNkdIazBNL3ZJbiswVHJ2K29TajVOOXNxMW9GSlJVWUlVYU9jQWVH?=
 =?utf-8?B?eUxaQkZaRlJPakZjZGlBeUhkMDdqL0w0NkRaakx6SnJzL3NsNk9uYjZieXhL?=
 =?utf-8?B?R0xvUGdGY0NpTkZaVVVrb1pSV0VJNEtGNXRsbjg4OE9kZ3AwemtsSVpjYUt1?=
 =?utf-8?B?eGJ2UVBuOXdHODhobmJpZEUveGNVVzFmVFhhbmRPNVZQT3VtVDVEYmhjT2Jt?=
 =?utf-8?B?YzhiZ0Y4Z1VveWp2aVlkS0paN2NsSG9HTnNhL3A1Z3JKcVRzOHRPSUpHc2ZE?=
 =?utf-8?B?M3NDUW1TemVqbWtSWVQ2NTQ2TDNCaXIwLzNMU2NzblZSUENoQ2ROemVNNUNv?=
 =?utf-8?B?QjNOdk9jM0M5UTFzcWtsTW1TOExlWjhwQWsvYS9PZFE5eXFYa24wSUE0V3Vh?=
 =?utf-8?B?OE9NdjV2bVJQOVhHWDdJdDNzajRLRHRkb216cGhuTUhISnBaUGdGYm10OVNX?=
 =?utf-8?B?dnFUKzR3U280bldSUDhEN2VxS1VoS3hnRXBvT0YvQUx0YU45a3ExQVh0VzJH?=
 =?utf-8?B?RFlETGtuY3ViZWpPaS8weDRLYk8xcTJhVzYydGY5eHF4VFVOSmtPTS9qUCt1?=
 =?utf-8?B?YXdSS1dOODlETHllYW9IVE1FS1A3RXBsQTQrWFhhbjdPTVJIWkwzTnNmUUlv?=
 =?utf-8?B?ZEYyeW94TWdlTnNIUFhUZVBqaHBtSEhRMXUxVEpNaitqNVYrYkRxclVGZ1FB?=
 =?utf-8?B?ODdPa1RjNmdOaStjZ0ttbll3ZE85UWREdGdrQVZnQzNWcTZLazc2ZWwvUXlu?=
 =?utf-8?B?alN3anFoNkpvaVFxb2hnTDBQWTh2Ym9MRkhUSXRHOWxZd0Mwc0prbXZQOU41?=
 =?utf-8?B?czFKVm1YWXBUSmlxUGNjYkFRUFc5RU1OR1djRzZ6d2NGZWtDTVFHMHU1ZWtK?=
 =?utf-8?B?Znl6ekR6NjhWZUN6eUJ4L1dNaERMNzBzOHlYdzM1QlBuTWdldnZuY2ZWNnN4?=
 =?utf-8?B?QlNTR1pKaXF1NTVxTUh3TzdBS1VFeU54REpDNFNobDRjYzMzdW04OUdFNWVs?=
 =?utf-8?B?V3dENmU3cC9vNEJzblJJcE9PVWU5aW9JK2JZaUFiRGM3bWJlcE9FeEREdmlU?=
 =?utf-8?B?akQrLzBlb2FhZSs2M0hEYjNrNHpTUU9NVlZoK2dxTjhPQ1V5dmlraTJzNHJM?=
 =?utf-8?B?ZG03M0g3Mmg3WkVhOVMyTTMvSXkwRHhoa3pyMVpqWHR0OTdMdE9GMDRFM2tP?=
 =?utf-8?B?RFc1cWZZeGIwQ2VndHJ1aWszSnd5VHVtZElmeHFCdjdpR3RoYmNHZlVNVWVs?=
 =?utf-8?B?WlJVclMyQzdjMFllL21DOE1ncHg3c2UvZ3R5N2ZZSnVYQWFYbzJPZW9OdnVX?=
 =?utf-8?B?ZC9MeUVjYlZTWlFQRElPMXBqSTZCODY3MUFpVHVoUThlcURzeEJFemZhSWFG?=
 =?utf-8?B?UHlQUGpaMzVoNmhQUFc0OEtGMjhwWEZ4L1lablZhbzdGTThJVXBIYkVldG9p?=
 =?utf-8?B?ZFdwL0JVSkgwWTMyMUYyQkY5U0l4TTdQcWFHd3FXcE1zL2IwaXRoYXNnY1hS?=
 =?utf-8?B?NFdvMTRoN0JpcUZ2dURWVG1CU0p2UlNHYW1PY3JJeXIxTG5kMGluSVVVTmd4?=
 =?utf-8?B?Tng1UVhzOXdSbWczR3RuUXlzMXNxWWRWVHZWTjJIdEZKVzhrUjRjT0pqbkJ3?=
 =?utf-8?B?dDJnd1FmUGlReUVwcmMvaDJVWkcvN0FBaktQejJ6djhEZHcrYTlkb3BKZnVS?=
 =?utf-8?B?RnNXQUNhMk9jemxEdzZKWDR6K01kTzd5SnNjckxQVmMxU3BzeVJnaFZNSUhK?=
 =?utf-8?B?eXBqcjJ4SFdRWSt6L2t0NDJFeFBVak5za1BwaVg3NzFhT1FDRVFyVDNFZjNh?=
 =?utf-8?B?RzVncUUvMnFOYnkwK00zRTJtdXJyV21GdGpEVXBsb241aFNreFlXRXU3NFMv?=
 =?utf-8?B?aUxJazRRdEZua3JRcXp4QWVYbkVGRmtzWVk5MlhVSGtqOXVIRzRVenBqOWZk?=
 =?utf-8?B?UmNmTW1oUGQzZVJHWFVTbm5NblJTV0dNdndjaTVvSFNTUlVnWko3OW4rOXBr?=
 =?utf-8?Q?5bhQvRsJfd2k7VoY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e0ef32-6858-42df-4cdc-08df158b5eaa
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 13:47:24.4775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UasVY2yxg/1+UTCWj6CTb5u8XEYq38Mc0PQoQH+RVhX8SNUHvNJDig4eLWmkhPzBft/JMsEBwSkmFO1FNC+XPJ8qJKVs5foLQzbaT+XVhbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB7933
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

Split the first part of vhost_dev_init(): selecting the backend, calling
its .vhost_init() and reading the supported features - into a new
vhost_dev_init_backend() helper, and call it from vhost_dev_init().

This is in preparation for CPR restore of vhost-vsock, which needs to learn
the backend's features at realize time to negotiate them when loading the
incoming virtio state, but also must defer taking ownership of the device
to post_load.  vhost_dev_init_backend() does exactly the pre-ownership part.

As a result VHOST_SET_OWNER now follows the feature query rather than
precedes it.  This should be safe, as no backend requires ownership before
VHOST_GET_FEATURES - the kernel and vdpa backends do not check ownership
for it, and vhost-user already does query features from its .vhost_init()
before set_owner().

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c         | 33 +++++++++++++++++++++++----------
 include/hw/virtio/vhost.h | 22 ++++++++++++++++++++++
 2 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 68a8e404818..99561ac5868 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1681,6 +1681,28 @@ static int vhost_dev_init_features(struct vhost_dev *hdev)
     return r;
 }
 
+int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
+                           VhostBackendType backend_type, Error **errp)
+{
+    int r;
+
+    r = vhost_set_backend_type(hdev, backend_type);
+    assert(r >= 0);
+
+    r = hdev->vhost_ops->vhost_init(hdev, opaque, errp);
+    if (r < 0) {
+        return r;
+    }
+
+    r = vhost_dev_init_features(hdev);
+    if (r < 0) {
+        error_setg_errno(errp, -r, "vhost_init_features failed");
+        return r;
+    }
+
+    return 0;
+}
+
 int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    VhostBackendType backend_type, uint32_t busyloop_timeout,
                    Error **errp)
@@ -1693,10 +1715,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     hdev->vdev = NULL;
     hdev->migration_blocker = NULL;
 
-    r = vhost_set_backend_type(hdev, backend_type);
-    assert(r >= 0);
-
-    r = hdev->vhost_ops->vhost_init(hdev, opaque, errp);
+    r = vhost_dev_init_backend(hdev, opaque, backend_type, errp);
     if (r < 0) {
         goto fail;
     }
@@ -1707,12 +1726,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
-    r = vhost_dev_init_features(hdev);
-    if (r < 0) {
-        error_setg_errno(errp, -r, "vhost_init_features failed");
-        goto fail;
-    }
-
     limit = hdev->vhost_ops->vhost_memslots_limit(hdev);
     if (limit < MEMORY_DEVICES_SAFE_MAX_MEMSLOTS &&
         memory_devices_memslot_auto_decision_active()) {
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 0a322efec1d..b2b644c0d1c 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -156,6 +156,28 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    VhostBackendType backend_type,
                    uint32_t busyloop_timeout, Error **errp);
 
+/**
+ * vhost_dev_init_backend() - set up the backend and query its features
+ * @hdev: the common vhost_dev structure
+ * @opaque: opaque ptr passed to backend (vhost/vhost-user/vdpa)
+ * @backend_type: type of backend
+ * @errp: error handle
+ *
+ * Select the backend, initialise the backend instance and read its supported
+ * features into @hdev, without issuing VHOST_SET_OWNER, setting up the
+ * virtqueues or registering the memory listener.  This is the part of
+ * vhost_dev_init() that precedes taking ownership; it can be used on its own
+ * so feature negotiation can happen before ownership is acquired (e.g. by CPR
+ * restore).
+ *
+ * On failure the backend may be left partially initialised; the caller must
+ * still call vhost_dev_cleanup() to release it.
+ *
+ * Return: 0 on success, non-zero on error while setting errp.
+ */
+int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
+                           VhostBackendType backend_type, Error **errp);
+
 /**
  * vhost_dev_cleanup() - tear down and cleanup vhost interface
  * @hdev: the common vhost_dev structure

-- 
2.47.1


