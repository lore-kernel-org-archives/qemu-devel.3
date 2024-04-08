Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72065CD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 06:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtiBt-0005tw-M8; Mon, 08 Apr 2024 02:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gavin.liu@jaguarmicro.com>)
 id 1rtiBr-0005jX-45; Mon, 08 Apr 2024 02:09:11 -0400
Received: from mail-sgaapc01on20730.outbound.protection.outlook.com
 ([2a01:111:f400:feab::730]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gavin.liu@jaguarmicro.com>)
 id 1rtiBp-00067Q-3M; Mon, 08 Apr 2024 02:09:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ni3KVp9vLY0WFy6KuK+52UnNO6gjqSIBd57Q+IjLV3bHEaoO300ZAysO2sP9g/m3NE5v5rxAfcav42dG5qQvEwN1dFs0qZMc0voyO7kOvws4nbc1ZKHGaPAfWzu5kd0Bm1Khdwb6/vDCO6AHHE4XDG3q3F2T0W6r41yIRcw6HK6DUngmBdOyYnops+fX8FLdIt7Y3pKw6AjjccDrsXBRkDy0omBIw4Ug/4XAfLUyjREsjJPDFzrdoGF82jj2ioWTN+IeW+bShemzHrwM6/ppZfSZ/yADI2qMN47xMpyyT8qsCU3W/NjXX/GaceNc7kYpwANp7M/rnAIiOW+WSp7U3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJsBQ42pKoVa9gdFpc0BKD+MBpYDIDlnEkhm4GeadY4=;
 b=dqFqQJ+OokBsXno8rcFg1nKSWyL1b3NDYI9SeeJJVKxLV3tKlh6yYK0XO8GsttENJ0tMRrpfo7HGym27DF25Y+9vnM0WTQz2MJBLZgjgcc1pHtiWFu2e6PRyrk0BD7E6eZuGAEevzMtZl7KlvGOL+Tgqcvf817+TpMDRPazpFTJSGG3dvBVIdgop1yR77IYo/soKt4cazv+t2n+gmOyV0SAc0InY/MIdybt2/jYwiDl3sY5t66/gAtF8iwG/pgTj5f3MSTKj1wpLL4QbVLp4HLL1X6mCpl1H3e7Dzl/v/E5fnUTs02AFf8LjhtXZRPh6QVSBVHXUnB7YYhXD0aUHvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJsBQ42pKoVa9gdFpc0BKD+MBpYDIDlnEkhm4GeadY4=;
 b=jmZnz02ijnnkS7Tcvkge9nogcJ7m6ay2dApacACD+mFnWyVECaFXXBMz3ndGLzFvmOI7PLdJ919BIl9CAtMBF6JmA3NDQ9bcyjwMUBrTEYGAHF0KUr8QjVxT3/VmJJIxjPi5iZ0epZIqxvruc6nKPY3OqMAT/l7J0hKNRIPwzLJn1V4+wBEs4N6Ndioj81BmwLkN7giDzv7mYa3f+Mor9jTDqj4V9Zl8hlLpUGiVTOyq97aHDMt8izH0x4ClamJV5oAfpziRqdx9Hb0helOuB2R/P2yXUfFQXcGS0XhEu2viRZASNeCzE1h6GfrRwGK1IXHcWoEol8kik288BnSrqw==
Received: from SEYPR06MB6756.apcprd06.prod.outlook.com (2603:1096:101:165::11)
 by SEYPR06MB5816.apcprd06.prod.outlook.com (2603:1096:101:b0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 8 Apr
 2024 06:08:56 +0000
Received: from SEYPR06MB6756.apcprd06.prod.outlook.com
 ([fe80::922f:a649:adbf:6634]) by SEYPR06MB6756.apcprd06.prod.outlook.com
 ([fe80::922f:a649:adbf:6634%6]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 06:08:56 +0000
From: lyx634449800 <yuxue.liu@jaguarmicro.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: qemu-stable@nongnu.org, qemu-devel@nongnu.org, yuxue.liu@jaguarmicro.com
Subject: [PATCH] vhost: don't set vring call if no enabled msix
Date: Mon,  8 Apr 2024 14:08:42 +0800
Message-Id: <20240408060842.2012-1-yuxue.liu@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:404:a6::30) To SEYPR06MB6756.apcprd06.prod.outlook.com
 (2603:1096:101:165::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB6756:EE_|SEYPR06MB5816:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yDLg6LOQnqm8efjxFFGckZzlmOMHGU0wHrVsqH/k6Y70sOeqy3p9zbJAUfjETwo1EsnGpHDJDa/mlChwJW5N1qOucw/lY3i6/pMu/drzLZMeVkV7IRoYOhjePFK/WMNbA2uFZ+/r3zQ4dpeVebd10hrSlAh2LFH6hqkoEvG/Q+Npv+JwI8hnuQL1fIvCx9nRdcYRnIcfAPBVxc3LTAaa6I8BA/Vc1Qyp0Ixgoi8BdbanZIOgdr08NKKEwfoa7Ahr4VeVMyRLwwOfA/59qgpsh1SddxYOMLGhKrJ/6vEwzfMgRrCuH+8UeZf0tQRwLY2Jkk15q765FazV2D7R9albwQS9cD/ws7xtWf9Yk9UX6g7SCZ+AQ2cfoUvGa1oQ4SJUbSQ5OdtlYZaGijJJlXAvyAJa05p8QUtN8pk5YI95ws1caumUkmNzySbr25Jh/85ilmj8sCj1712Q7X6nG2rnGVEV+Wizoa/99YqG0Pb4VzKdbJcfzz8ne+LBg3WxCMEB/RsloTXN7LblpqOg6di4d8ZlvDym3bDD+wWd8SPoLJTI6BEALcnzbgUZDSHH02iAB0+cI0qC+ykvrx38QYBmyRa90EEnQUVDE+pIKm+H90Y6XFN8DK28YIEMMd8f4/C1wZjrfnk8pP8KmRLHmIL6++GnDbq27LPw/KH0d9yF7XiH1DBa3QRUqvFyPlL3VyHJ2bfRJuEA5YVSjVwgC40Mh8fLBzZltSqnkLWBMEOp7Qc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEYPR06MB6756.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(52116005)(1800799015)(38350700005)(43062008); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I2A15wczFgdK/UEBxr5Obu7vnRFYcOhmqpGSBooyzcgGsp3euxcwUUwpCNgM?=
 =?us-ascii?Q?w0g/nFFhbdYsP3n1ZUsEW6IRKherffoO8H3rZ7X6T7DbJgZXkL4iDq4gSdIl?=
 =?us-ascii?Q?X9MTw2mR9owldRAz4dtVevIxQMUetN2G3ROWkbdPiUHMSm7KKqxz9rygh8TZ?=
 =?us-ascii?Q?bkd2pE8+MbwvfyCyZX0TCQE1dHNxbL8SQiIZ3aRhnVpY+wi10bkmoxKtcQZ8?=
 =?us-ascii?Q?hElY2/K0Vy/DHi0NQKTAWnLr1rgradDFLDwWU47MyelOBjycpAwY1FmoVZM/?=
 =?us-ascii?Q?rLqxXFwFKPkmeyNXPpIFMoX/rDKqIvDj04ejvKGkYPZE7/r1LuXpvEIrbPBH?=
 =?us-ascii?Q?Ruz8oTH118Ym5tfD+bGpsvIpV+rLW29LVpirit5HveXMgC39SJGYGby+SYlY?=
 =?us-ascii?Q?T1sNHUk5JvchEwZwYTzE9RH+YDFP8NMm7n8ajZDEY2wlGCmmFqEScmMk2qL6?=
 =?us-ascii?Q?Z7IM9GugGl19qcRemxjnoiQhQAslHVhzkj8lvGbJVSPB5MnIYaDPB3yNLelY?=
 =?us-ascii?Q?HcSD16qvnh4YWyqUs4O1MOkAzp5PcnJE6rHPMKQ7Pleq0ek60sn5AzUSXdv+?=
 =?us-ascii?Q?UbvJTiQfiFDXLQCtuRk5aNZmtHZpdBZj1WJPsCrGG+cf/NLqdI5CAMviQjC/?=
 =?us-ascii?Q?TOAcFQcSQ48nfrMuhxM4gsYa1zcNSG1DUID9glV3DkmhipVFP1MahkiFIMat?=
 =?us-ascii?Q?ApPkXPmL6KEkr39E6ePJgcvmc23NiTuVuCphlTWFFO8Wv7NLw/irlLFHWx5P?=
 =?us-ascii?Q?yHmL25BmkL4QSAkUxGm/JR/d6ryExIaOR1fqx6s1/1TUZ7uxQAbCbDdsPzMM?=
 =?us-ascii?Q?TL+ZhEblhDOpeXmNOZ69ePgYS6yzOlTh+VozDNA/6MNsiLFGtY0Lrqw7iLOF?=
 =?us-ascii?Q?p1cEzOlghFlzyNoiElDkXzbwpl1z77sCppJieuppIXziq6uFIxwoQsQQkYl7?=
 =?us-ascii?Q?w0JRKT0d5lbxC7zFFNJ3zV0m2cM2jRrPFFD9UlyLr7Yux7KCiVzh9KKBUjTP?=
 =?us-ascii?Q?bibBFaYqxAw7Z4uLVx0hoMXa0Pl8azV3QWQeAki3Ijcm1BAwjhRtOh//Vb8/?=
 =?us-ascii?Q?lhSEVHG+oYJ8uVc5rYvkHXDzxDsKH9zee+tr+7BJxqLTSYSJMRyWXZ8dq+Vm?=
 =?us-ascii?Q?i4rneWiB/jy6rYBzpr84EgrLDApBxklbOb6HL18ZuX2eI5Vu7YO1ffza4ikD?=
 =?us-ascii?Q?hkEIHJmsjRt2zOqgN1apGsU+XJmkT0uyuxJThyejmnirR1XkKhmNp9VIVqXK?=
 =?us-ascii?Q?R9UT0rDZPE/uGu2QS7J2/LY22UhqrLtE2Vjtrjm7eGcct3tAn3u3PAAHTFjl?=
 =?us-ascii?Q?3Vzo3uYhg8hmjIU6W2J6PfYQAsm0datLPyDL/VZwapCZT7alYM0WOaMsBjgo?=
 =?us-ascii?Q?ad3rM8dMUpvi+j3GaQ6Nt4aNfGxfMap/PYPEmlqJBMtTMaZ4yeP5ohR2JCRt?=
 =?us-ascii?Q?Nkvqw+hqEOPRr7Y3m21EBY+fkEitbd1Ku8gVuN8wxLQZgJb3ESZZsdix4F31?=
 =?us-ascii?Q?OfL1AlvZi34Qc3aelxKhpWH+0Rgz/jXhSnjRV4lHIYCVfuJ1xdZ+ucQvnppm?=
 =?us-ascii?Q?nnQS29krAtjmtoCAT0UIf9WCk863P1GpeidUh31MctHrPoFPwTsPx7tM+Bqr?=
 =?us-ascii?Q?vA=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a723657-42db-42a1-14fc-08dc57925f76
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6756.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 06:08:56.1062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QPsHOU+RjSgBMXkY/hIuRLKePsF4/ecBcudlx2kEEC2yAwpYlWXWdBQUN+E/FM7s0IaYMwSA4KjtQtx7BheDBgfxkvHRTq57zm5ncJOnXEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5816
Received-SPF: pass client-ip=2a01:111:f400:feab::730;
 envelope-from=gavin.liu@jaguarmicro.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
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

In the virtual machine operating system, even if the virtio device
does not use msix interrupts, vhost still sets vring call fd. This
leads to unnecessary performance overhead. If the guest driver does
not enable msix capability (e.g virtio-net pmd), we should also
check and clear the vring call fd.

Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>
---
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


