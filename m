Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37EEC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 04:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrWDn-0005JJ-8w; Tue, 02 Apr 2024 00:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yajunw@nvidia.com>) id 1rrWDl-0005J9-QX
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 00:58:05 -0400
Received: from mail-co1nam11on2062.outbound.protection.outlook.com
 ([40.107.220.62] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yajunw@nvidia.com>) id 1rrWDj-0000HH-IQ
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 00:58:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SG66WaHZJvGgimn5sNXe44zfN1zmngeLWosPC6gxTiceV50Z3je7agU2S47bpuXv9yT22T7hsL2bTS1Sf5XykhLaOxh67/DE2CJM6O+RTg8792JNn2IDahDsa/7aTfe2+yYjhmjm55miA7WgFeC8sA1E4jneAiC+wtxTRrVDcrLJO3YuYOnEB8Z7Rts+zTy/uThoZO3NztOzigFVP+M8ddwZUSvlzEdUdO72/CI1tAngDdoGCVdpk5YfN3GrNFDj85l98H4HkLEp+WbYrIT55w10Th/usYEslCgMBVwaQtwr+LOS7JdSKvkiZ8IrPIxgif8fudaPCEhH4F4wBfgB9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fzfaCxp/e6NyZKmkJCWgkSAgVRUD1zk8GTIICIvxD8=;
 b=WN1VNixiS6OG2+EYyEzTwNruA/q7LqA/XdwT3B9NkYJdDJ7H8e40QDtdGa52RA7OqJTWgPKbxpIkv1PsEuxFDiZkfeCdOXhp60w3Vupc9unoTYuk4tV6qPDS4iL1g4hVxivU16Mk//q5NHi51lTHCF9UuspPQ4lqqvsFan9/dtD8IC/yQ946pETjB1logmnrY4LSDhRuhVUCWkAyZpOI87o24Dew8KyReabwqLV4rzdRMqvWCnnbl5pZw5fzjuOk7YjNWGYrsugU03mi0FWv2Zh6n54Ng8rZmkG6LCyZphygs/zd146IWbfYZ3n7oOlx3+rD4W0CxEk7WScSja/gZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fzfaCxp/e6NyZKmkJCWgkSAgVRUD1zk8GTIICIvxD8=;
 b=qVJAob7ayNOCET/sIQUuzgcv9ju8NSHnE8ShoW3yvT7bTqaNtJn+WHdqtnVIIVCPLtnt8dHP80dmlo3E+mtBn7L4i10G/84Qn6BYZeF5nEa8Jrvs+imxYIMjUCwg/o6p7ciwrpONYEhit87O64ozDvLRCx/ibBanoesMQLwZhuSMRGZ6Oov+LfV3ym1u41eZuDyt49oIEUpaLuBAAj3a5AVKZM5Tw7twaVuOi8TZCvhjSVyx+fJj/TfIMbGWFre8WLG+1H5UHeDXFW82sgu4gd44CsywupKER7jPYzo2qCsoW7WFoMHVNsDEf543BbrGWMwIH0R6mAdsfw7S4yniFQ==
Received: from BL0PR03CA0001.namprd03.prod.outlook.com (2603:10b6:208:2d::14)
 by MW3PR12MB4457.namprd12.prod.outlook.com (2603:10b6:303:2e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 04:52:55 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:2d:cafe::e2) by BL0PR03CA0001.outlook.office365.com
 (2603:10b6:208:2d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 04:52:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 04:52:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 1 Apr 2024
 21:52:44 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 1 Apr
 2024 21:52:42 -0700
From: Yajun Wu <yajunw@nvidia.com>
To: <qemu-devel@nongnu.org>, <mst@redhat.com>, <jasowang@redhat.com>,
 <maxime.coquelin@redhat.com>
CC: Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH] virtio-net: fix qemu set used ring flag even vhost started
Date: Tue, 2 Apr 2024 12:51:09 +0800
Message-ID: <20240402045109.97729-1-yajunw@nvidia.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|MW3PR12MB4457:EE_
X-MS-Office365-Filtering-Correlation-Id: d76c8940-a2bd-4cca-f7f0-08dc52d0c232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B+5MMuamyL/UQUmpkuETn0i+bChZuTHX1Q4CzxBkRnZdL0EAcN766meb5ygMcIziLsOI4g54DXa9v3VwZVxCaReDimdPDNu29ntX0U8PyhpEnSoBpCQdak/wNYw3PO+HclB9Q1f+tDDPxGMn105uAoX1mNfQyCXrWJPmtbslMGpI0fLfw3xG4uZlVuxw3iDnggeEHsWQ3LxKefbfqu0mwAUsEJoD2nYhWWxsyVyz5zmj5mr7gkUMj8V8CoRuaKhb4WI2Sik1Lf6nE1tIQEAIFWtAROhMmbKnsIL08FRph6Ntsj6CqxgtLpMuP+D6jCyiqWeHhsxWaTtRku41uned3jQBLQi0bDeI0kkw6Jn9vRdsViWfUtzwnRBsHHg7PnIEW3voG7zPpJsZDodzuZmDb5Hkgjni/2q17Kq++HDEvXYmVExf4NIW2o7HXOHfVzUKOlE1H1J2VKKrjEJmTPX8WU6HaE2NYSquavl5iOEw70tAkfrdpVoMt7dkiiH34UxOesHCPGwipQSwyuusL+SNGwSX4jqwbCIC//B6/5Ngz5qT6+gzoQlQ0TBSMrbsYxB3oHuPVuNRWUcRAMjC8PhYvwb/giOtuARt1ib+6MKZC/g/njjjITeUTN9KJYxFaQlEKBgeEHM2LRf7c1DTTQ0IxU8v7R7rUzYO5WJ9vOO9sb6Qh8shONsgijVMjkFtnoakR8kN0O4pBkwDzbdW/nKlu+MadCLdKad2o402ZQZLZV+EnG6Q7OuyVBjIftQ3InOA
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 04:52:54.2531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d76c8940-a2bd-4cca-f7f0-08dc52d0c232
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4457
Received-SPF: softfail client-ip=40.107.220.62; envelope-from=yajunw@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

When vhost-user or vhost-kernel is handling virtio net datapath, qemu
should not touch used ring.

But with vhost-user socket reconnect scenario, in a very rare case (has
pending kick event). VRING_USED_F_NO_NOTIFY is set by qemu in
following code path:

	#0  virtio_queue_split_set_notification (vq=0x7ff5f4c920a8, enable=0) at ../hw/virtio/virtio.c:511
	#1  0x0000559d6dbf033b in virtio_queue_set_notification (vq=0x7ff5f4c920a8, enable=0) at ../hw/virtio/virtio.c:576
	#2  0x0000559d6dbbbdbc in virtio_net_handle_tx_bh (vdev=0x559d703a6aa0, vq=0x7ff5f4c920a8) at ../hw/net/virtio-net.c:2801
	#3  0x0000559d6dbf4791 in virtio_queue_notify_vq (vq=0x7ff5f4c920a8) at ../hw/virtio/virtio.c:2248
	#4  0x0000559d6dbf79da in virtio_queue_host_notifier_read (n=0x7ff5f4c9211c) at ../hw/virtio/virtio.c:3525
	#5  0x0000559d6d9a5814 in virtio_bus_cleanup_host_notifier (bus=0x559d703a6a20, n=1) at ../hw/virtio/virtio-bus.c:321
	#6  0x0000559d6dbf83c9 in virtio_device_stop_ioeventfd_impl (vdev=0x559d703a6aa0) at ../hw/virtio/virtio.c:3774
	#7  0x0000559d6d9a55c8 in virtio_bus_stop_ioeventfd (bus=0x559d703a6a20) at ../hw/virtio/virtio-bus.c:259
	#8  0x0000559d6d9a53e8 in virtio_bus_grab_ioeventfd (bus=0x559d703a6a20) at ../hw/virtio/virtio-bus.c:199
	#9  0x0000559d6dbf841c in virtio_device_grab_ioeventfd (vdev=0x559d703a6aa0) at ../hw/virtio/virtio.c:3783
	#10 0x0000559d6d9bde18 in vhost_dev_enable_notifiers (hdev=0x559d707edd70, vdev=0x559d703a6aa0) at ../hw/virtio/vhost.c:1592
	#11 0x0000559d6d89a0b8 in vhost_net_start_one (net=0x559d707edd70, dev=0x559d703a6aa0) at ../hw/net/vhost_net.c:266
	#12 0x0000559d6d89a6df in vhost_net_start (dev=0x559d703a6aa0, ncs=0x559d7048d890, data_queue_pairs=31, cvq=0) at ../hw/net/vhost_net.c:412
	#13 0x0000559d6dbb5b89 in virtio_net_vhost_status (n=0x559d703a6aa0, status=15 '\017') at ../hw/net/virtio-net.c:311
	#14 0x0000559d6dbb5e34 in virtio_net_set_status (vdev=0x559d703a6aa0, status=15 '\017') at ../hw/net/virtio-net.c:392
	#15 0x0000559d6dbb60d8 in virtio_net_set_link_status (nc=0x559d7048d890) at ../hw/net/virtio-net.c:455
	#16 0x0000559d6da64863 in qmp_set_link (name=0x559d6f0b83d0 "hostnet1", up=true, errp=0x7ffdd76569f0) at ../net/net.c:1459
	#17 0x0000559d6da7226e in net_vhost_user_event (opaque=0x559d6f0b83d0, event=CHR_EVENT_OPENED) at ../net/vhost-user.c:301
	#18 0x0000559d6ddc7f63 in chr_be_event (s=0x559d6f2ffea0, event=CHR_EVENT_OPENED) at ../chardev/char.c:62
	#19 0x0000559d6ddc7fdc in qemu_chr_be_event (s=0x559d6f2ffea0, event=CHR_EVENT_OPENED) at ../chardev/char.c:82

This issue causes guest kernel stop kicking device and traffic stop.

Add vhost_started check in virtio_net_handle_tx_bh to fix this wrong
VRING_USED_F_NO_NOTIFY set.

Signed-off-by: Yajun Wu <yajunw@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 hw/net/virtio-net.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index a6ff000cd9..8035e01fdf 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2865,6 +2865,10 @@ static void virtio_net_handle_tx_bh(VirtIODevice *vdev, VirtQueue *vq)
     VirtIONet *n = VIRTIO_NET(vdev);
     VirtIONetQueue *q = &n->vqs[vq2q(virtio_get_queue_index(vq))];
 
+    if (n->vhost_started) {
+        return;
+    }
+
     if (unlikely((n->status & VIRTIO_NET_S_LINK_UP) == 0)) {
         virtio_net_drop_tx_queue_data(vdev, vq);
         return;
-- 
2.27.0


