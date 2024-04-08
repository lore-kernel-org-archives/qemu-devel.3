Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 595AACD1292
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 07:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtjVY-0004yW-Nf; Mon, 08 Apr 2024 03:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gavin.liu@jaguarmicro.com>)
 id 1rtjVX-0004yF-15; Mon, 08 Apr 2024 03:33:35 -0400
Received: from mail-psaapc01on2072f.outbound.protection.outlook.com
 ([2a01:111:f400:feae::72f]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gavin.liu@jaguarmicro.com>)
 id 1rtjVU-0001lv-PV; Mon, 08 Apr 2024 03:33:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LeLHC7M1sFPg5nkB/2qdfWUeQklOmV/hCSaZ00ASRHQcrqdPjSzDL80dhVOioadIEukn/GeOiMGKHfeezXolBe9gXgX0iS0In92y1qE26tr45cIHlr3SbDltIki2b6WVzR8zz6DfzWf72orl9aMXDqI0JsEZy6TJcWRVVCJC92h+fKNF8frsVa0F8dpNSOw7GBvGUMivR90CjB1acXOdoFqdJxQ6JM13BXh3C0u+uV5ML5jHNmFqqBEb1eRTQLQZNsGa9v8c84wYvQVjH9t0pWt8cZ+vcUZzbXCCOSAZbJYrU9UZO9Kx2vh+qA3tIV8h6XlindoZ3RWYeT69A0mJEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mENliEQ2u6a58UAv5r74EC8EOrR6Ue3K6RE0GFoTuHU=;
 b=idHhehrer9mxkUIIkcE3bhV1hiXlkIE7Txwq0L5Tw7f0jPnq+dl3bd2PdLOTfsw8lgV2/ksBuVywN8GeV6lQ6VmuaLE13iccW6+btf/HOT5oojmashDKbvBz7CMxD4nm5nvwUjbUyB7gdCuiGz6a0ZGZaQzvHABq9iUi4xIsn2hxGbQNwUmlmsXQ7moRd7xNPvoAVGeIKyw4oQPl3cRRKbui5DrGDn/MtTCnlxC+8UWtwV7k2/duCUNYBr+fJZZrtQ6GzCbmXUxb7N2rMiTfzgiUHfVCUQUpfi/nQlI6oamgksEPotkPTbD/qinnZcq+njsHPlNRm5k6CIVRzV9dpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mENliEQ2u6a58UAv5r74EC8EOrR6Ue3K6RE0GFoTuHU=;
 b=qLL2FNeXLGgBb2TEt3vzQKOImGUaldUYGW8ucS5aRBf6AlM6wvyHK7UbTd0aHFOuuHflVMIz5be8bEFx6+03m1GdgNH81HKgH4OhWRmEaOTn9YEp154F9WpJkLxxltePz4Nw4LDr06ThgN97AbKwTYtpjdF8gFtmFy0NhHcESAn9I+Z/3narxQeaNLQrfm+7x0dI/83PuuJDIbOVkdmJbIf6//sC6gy9N0lHYStLy0FnxdBrf+TXYZ8yAKGdyfxFanQJD6bMWsrqjaScR6hLWgh7mm7h0Z6igmtcnt0NLGj9HUIu3x4vd+cJJbPUwGcWOq++QhHIeEfUjv5Or1NO/A==
Received: from SEYPR06MB6756.apcprd06.prod.outlook.com (2603:1096:101:165::11)
 by TY0PR06MB5778.apcprd06.prod.outlook.com (2603:1096:400:27d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 07:33:25 +0000
Received: from SEYPR06MB6756.apcprd06.prod.outlook.com
 ([fe80::922f:a649:adbf:6634]) by SEYPR06MB6756.apcprd06.prod.outlook.com
 ([fe80::922f:a649:adbf:6634%6]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 07:33:24 +0000
From: lyx634449800 <yuxue.liu@jaguarmicro.com>
To: jasowang@redhat.com
Cc: mst@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 yuxue.liu@jaguarmicro.com
Subject: [PATCH v2] vhost: don't set vring call if guest notifiers is not
 enabled
Date: Mon,  8 Apr 2024 15:33:11 +0800
Message-Id: <20240408073311.2049-1-yuxue.liu@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <CACGkMEsrT4xxW-KzLm=rTqXf0P+u2=0fy03z3EsHZFEqQePjJg@mail.gmail.com>
References: <CACGkMEsrT4xxW-KzLm=rTqXf0P+u2=0fy03z3EsHZFEqQePjJg@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::8) To SEYPR06MB6756.apcprd06.prod.outlook.com
 (2603:1096:101:165::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB6756:EE_|TY0PR06MB5778:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tBspZ3PU1HmeeUbMUa3s0invelVUB0gY1fE4Rhi5zsC4KV7rpbjrwpjJ2zPKxajzbDELl1/Mztl4T/wMcc7/lKZ6MTlwW/8fQYjDb60Mnz2oISj+TVX1u/bp73EWTLwVY7/ZjI/MNNxkxwB22X+Pz64QUUKXyqEasiksflsDyhjLJMwtiw47KICYSdI4k7HE+V3lGZTf7GGL/XT184f1lfMUkqCC9/f6ID7RpqVFsuAPJUcv4GN3YhKSNc308C3RK3+uz6fVRbc0+pu8sxZT7/vopPpzf6ZTbDhzUjPSJr/pxfeQIz+Ozwl46Vvx26OjXc+Mi3BdgTijMsuTPFMOMjSoWe5LxzHLp+P7A4vNkGffDmKfjzSJJxF46qjJB8l3fFIGwvJA7j8EKVO9ETcejRuE0uYO5tIgTj8eZe67+7f1kaZNi+YR96fifL7bKEwrC5t7PKKKzcxqootmt23CqO2J0wyjlkkfL3aKBls+K0qsLcno7fIXhqASODrsXJ8eHV3Khal4KVxRuNJnkwzFLfSCyqV7LWa8Gpn5lP1o3NCWRI2JKUxh/1aF5tN5V4/GnBbviyQICK72MCulXOi9S6O36gvb/a0MK5iffjuXnjKY7xaf10gE8uZe1rYFFHsOlcMsOX67xgl1w3nropqLG1cMYR4u1AfQx4U1G1nCJYnxp/CPr2EzWndjib4uTU7MaRsct/16ELWJXZxOxsSUzzojgzom4QlMtlDHt7I+3KIUq77W+QnAufgmrwqG2WG3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEYPR06MB6756.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(366007)(1800799015)(376005)(38350700005)(43062008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IdWdq5rdVjfNxA5di2cp1GWBKFc9VmAZZs+Mt0fIIbJFDM++jWAuLGmLhyTZ?=
 =?us-ascii?Q?OQA9WMZ2ZsYv0yOcDQe+KbfMmYwTyEPnW9qlfXj+0gEH7AT96SCc6en7J/d5?=
 =?us-ascii?Q?FKRnNDQrTykKW5goVFZp//YWEUUbpR5+w+B3p/zDqQVrx8W3YDg4HREcWwZk?=
 =?us-ascii?Q?Fwa12Rj2r4hdpX4v9I9b+I5mJX8mp0fFr2vBbfkzOpIIG7ifY0KL+HJs0bAR?=
 =?us-ascii?Q?Rp700qCrkogtehr9cfQ3AT6jcifs5y0A0pUeAicQ2YQIZQE2cKh03bQpah7I?=
 =?us-ascii?Q?5jklbSZOU7bCx11QSBMvYDu9qkDpgcg0dijRapOT+hd1uLj/KRxSCtpCGZ8H?=
 =?us-ascii?Q?C7MlyOheW2AQPxwrew7NWfC41S6T5Lwd7Mso7lvPfjCt9AF18nfUTP2yCtM5?=
 =?us-ascii?Q?Me7T1dc2+IAF0L5+tqTb3I7JrwuY8s0eCOabrskLGb9Yy3lPzFjlT8ZvnOv+?=
 =?us-ascii?Q?pB2W0WhejVr4k12iL3tI9xSZq92hqJjgG8Yu9HwK55bJnC0uc76GDyli4mG8?=
 =?us-ascii?Q?h/C3t17BhC2SC4L24pnXZRL++qjY7QOADHNz/4qzc7qqf0gMdV25jl560d4Q?=
 =?us-ascii?Q?O6F1kdy48XptGvKupiMxM94VGWOOOC9NpWcarC/ET6z9rCFd1Vbdnh1KSAxs?=
 =?us-ascii?Q?qXAAs4ev256td6m7T6WUUkF0N/vU+RqiCLZJ1qym//U6+E+QldtaN5wYQAqe?=
 =?us-ascii?Q?rhljJJBwF2pDgut4jl/H17UxWbAAJlfBjbhOjF1749bIhGwFOOlvyUk84yJl?=
 =?us-ascii?Q?CYKI1JePzVEcSxciV5Xey1r0/1c7hH6/WxhJC/TnvTreVCOGEoNRVL+Y+jUK?=
 =?us-ascii?Q?eKpVS7gnLFOCir9yeC+m8QVNTrC7Rm6a2NMfXbNwr5xPXFrr0KRe9IK8rr02?=
 =?us-ascii?Q?9br3G32549E59SH/p+Jqy9KCk6etxIohICY0k0n+CludPmlbmj3ZJloDOjYo?=
 =?us-ascii?Q?6bfU6ah279xFDMpxbFzzcPZpj0PA3nXC2eG3aTZ2eiBCXja6+NSKULTVHQTU?=
 =?us-ascii?Q?ZPl3bYvYJUAOQR4WN3CDkFG5qttOteYwPuev3oZLDpl8R6QVgWcrUOnJCrLG?=
 =?us-ascii?Q?8BnhN/5q/Tbpb7kBDl8kcZ788wKNn/kOPm19sAFGrb8JqV9ogydnZV6ADGca?=
 =?us-ascii?Q?V62O4csbqdQzorIOBzt/bLQRqONAGKUwq0T6pYKkWO88sihNWHOTYgpnxxZP?=
 =?us-ascii?Q?8bjnP4Zb+ytMKj2Lt0YmF3yESOqi2CMJYMVwEkAsCaB+7g9MUmGtVOczF247?=
 =?us-ascii?Q?KDvTsA9miP9GHXBSMGiTyr5HjZh+SmzLixrdk0jYphKhUTcmOHrZZ5ELjmDl?=
 =?us-ascii?Q?MGNLrVxj1FExP8sw0yFvMAlIhWuuVf+vxbZ2tq4a61gojo5cHPIz7QVoflxw?=
 =?us-ascii?Q?+vy+c9oYK2Qix161CooxfZwdMwrR9DT6vB64Bj/eF5SdUZDFwNuQ88Cr2x/E?=
 =?us-ascii?Q?R4Wq5CggJaOSOqd/2X6wx9X83X/YttIN4w7aPyX55NbpZF5MPtCGx8utqWtl?=
 =?us-ascii?Q?FKyUsOrMZv/e9nQmewpz6NRLYhvBrmgFEfPqdijA6ZpdwN14U5nd2SPhrwCN?=
 =?us-ascii?Q?N2o27U3Tyz4mTcuj7ZW+wyW8tlKeFK9S1EWZHXZyLaUTeITA8Vpx+PD/AFWz?=
 =?us-ascii?Q?WA=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb10c1c-abec-4bce-1b7f-08dc579e2c7c
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6756.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 07:33:24.4765 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u50eQvZrUNt/NS1mFTDzjgIOMPgv3WWaKm7UNidKvLsHFyZt2c+iisD1eBqVemZdItBBC3EP5lwwh5IuIfNMyMTdBYSeYUSKZJ2PRkQdMXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5778
Received-SPF: pass client-ip=2a01:111:f400:feae::72f;
 envelope-from=gavin.liu@jaguarmicro.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When conducting performance testing using testpmd in the guest os,
it was observed that the performance was lower compared to the
scenario of direct vfio-pci usage.

In the commit 96a3d98d2cdbd897ff5ab33427aa4cfb94077665, the author
provided a good solution. However, because the guest OS's
driver(e.g., virtio-net pmd) may not enable the msix capability, the
function k->query_guest_notifiers(qbus->parent) may return false,
resulting in the expected effect not being achieved. To address this
issue, modify the conditional statement.

Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>
---
V2: Update commit description and title

 hw/virtio/vhost.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index f50180e60e..b972c84e67 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1266,13 +1266,15 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
         vhost_virtqueue_mask(dev, vdev, idx, false);
     }
 
-    if (k->query_guest_notifiers &&
-        k->query_guest_notifiers(qbus->parent) &&
-        virtio_queue_vector(vdev, idx) == VIRTIO_NO_VECTOR) {
-        file.fd = -1;
-        r = dev->vhost_ops->vhost_set_vring_call(dev, &file);
-        if (r) {
-            goto fail_vector;
+    if (k->query_guest_notifiers) {
+        if (!k->query_guest_notifiers(qbus->parent) ||
+            (k->query_guest_notifiers(qbus->parent) &&
+            virtio_queue_vector(vdev, idx) == VIRTIO_NO_VECTOR)) {
+            file.fd = -1;
+            r = dev->vhost_ops->vhost_set_vring_call(dev, &file);
+            if (r) {
+                goto fail_vector;
+            }
         }
     }
 
-- 
2.43.0


