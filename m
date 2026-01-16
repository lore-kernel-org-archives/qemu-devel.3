Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97668D4A61C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 09:32:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vggAz-0002jT-1V; Fri, 16 Jan 2026 04:31:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vggAt-0002hG-Tr; Fri, 16 Jan 2026 04:31:25 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vggAr-0005S1-Uc; Fri, 16 Jan 2026 04:31:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=glbcMxCkI/chwEHsAqA0Na2XfAsTlxpAydellgV56TfYgldAUfSgI8G1yO75w1yHWQmiceiOZ8O/3QsKp4leSLr7RBvA9UvuGpDjuCgj7JdT018Jdb7PVi5BenRauJzmZmw517fhy7JnmFmdyntx0okkb7yy1bahAbtJP/7rZDlRdqS3AFbywCB5Eqe4VPE76hBEdxK91PstjdSFStDBy0zc8boso+885+VIeMJqY6TNu8D7vsv/Oz4RYBKWD6EGRh0mUF3ItJLxBS/s/N/jY82anKWVcOFO7gwswfnC91kAgmSBLZn6htgaHYdMMptUNSlwwxEiP5fvGx8ZRv24Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPdtU7qvrYLc86zYS9HKuPyuJKSq1QSK19XS1rHjhIU=;
 b=NuPixRBO1REKcxJLYdrL//+Z3lGpxmkW5+tgwXqddigAtj5NYGBvlLp64E3QMft5G4FYivXXfRti5MPOCQ5UKz9lEwDnT9uIJqFSXV1A+zjf42dAUz28PI3ccMFSTT9yHmWtgunvBLnRA/i+ReMP2xRJYCmCMsxr/kkgXCcLdV/PQDiwABdqXgP2VpCNozjd5fRgX4rw/7hldwlPer/veDoJjCMkJsRhG9e5VCMsOzo416oqa+xnoP5dEnXRTxQWQRiBG+rAZ1MVpDcyWOTuNDa0KbGd3rmN+8Oxy+pssx19qqh8jcnj6Dn8VGxTMiVAhSp68D58AO0tnm21iPC3HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPdtU7qvrYLc86zYS9HKuPyuJKSq1QSK19XS1rHjhIU=;
 b=Qud0T2dcQpCTTLnnJZJWY2fa5mRdUfy6vBhTk+DiXfB6HLoo9T6MVX/dvFRwq1U/5pAqhhkLBLDf5m62eSMOTyIGOKKvebvoh1TTFY6eD39JK6oZSJeRTw4huvse2tLTfm7oqZWZMVpt5eE+4QCBxcChU0jVIIK6WMmOJ06O0mJW8ErlxjgX9lY7ENgDTzdzRxSzT+PoaEA71z2naq9hiw2sQ1z5/yuRNBzAYdttJZExqVjmF3dHW1gkIWY5J/C+/goStfVwHfTbqEmA5ennn278RaJ3UcoIDQbifmoxl/1pYtYunQE98lFf6FNitlNVgR/Mfo8ivtuwtDVINjRsyg==
Received: from SJ0PR13CA0219.namprd13.prod.outlook.com (2603:10b6:a03:2c1::14)
 by CH1PPFB21296325.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::620) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 09:31:13 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::a6) by SJ0PR13CA0219.outlook.office365.com
 (2603:10b6:a03:2c1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4 via Frontend Transport; Fri,
 16 Jan 2026 09:31:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 09:31:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 01:31:01 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 01:30:57 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <alex@shazbot.org>, <clg@redhat.com>,
 <cohuck@redhat.com>, <mst@redhat.com>, <nicolinc@nvidia.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <vivek.kasireddy@intel.com>, <kjaju@nvidia.com>, Jason Wang
 <jasowang@redhat.com>
Subject: [PATCH v3 2/4] hw/net/virtio-net: Adapt hash handling to updated UAPI
Date: Fri, 16 Jan 2026 09:29:47 +0000
Message-ID: <20260116092950.15796-3-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116092950.15796-1-skolothumtho@nvidia.com>
References: <20260116092950.15796-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|CH1PPFB21296325:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b7a55cc-a126-4165-0834-08de54e1fda7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|7142099003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0doQS9CVzM1YkJkREdhRG9tL1ZyQlNsTjRIT055cHJ1N2Z6WlYxQ2JSSU9G?=
 =?utf-8?B?dnRKZ0w1Ti9lbnNZQXBoL3l1V3E5UmN1MStxNkpOUmdYV3R1dk92OHdkdDlu?=
 =?utf-8?B?ZEViTEpnSklvekg0TjcyZHNMWE5pSmtVR3MxcHBmbmtEdXpvKzFQb2RqTitm?=
 =?utf-8?B?OTVjYVZMTlF0L3JUdWVSYVNudUpHTFhPRTJ5VE1SL2k5dkh1alV6bnhwdks4?=
 =?utf-8?B?N3drcTYzNHpiOE13M0pMZWIyclI3QlY3OTJteHRhbk9lUk42dmtGNk1aV0tK?=
 =?utf-8?B?Q2pBMlJVRnVWTTVwdVBzZW5EeTE4ZnhKN3ZuNzdtNVRJRUZZa1UwTkRXdFRB?=
 =?utf-8?B?eWtrWTVJcjJJdG9rNEJCRkh5M2dWWC82S2J3RldFOEdsL2lEdXduRkhrUERH?=
 =?utf-8?B?cVk2VWRhMmEwdFpUTUxGTGVaOWp3VUpOTWJEY3ptZnhqUkxESitxZ24zbXp6?=
 =?utf-8?B?anF6TVNMOTErYVh1eCsrcGkzQ3UreW5oTXhhUUFXOCtoaVdNd2R1a0R4M0xv?=
 =?utf-8?B?Uyt6N05VWW5iNFlRaDdLQ3VUbEo4djU3YVFJMUZURzZjbUlDUzVHYnZJNGRq?=
 =?utf-8?B?QmhNcVRWU3hPWUhmMDFBWE1mbXZUSTIvUTBxR1F4TFFYSFBBZ1I4ZS9vdWFF?=
 =?utf-8?B?L2dmRlpCRllTelNza2RxT0tydHFLRGpROXFCeXVJMXFZVkZvMTFxUllOUndV?=
 =?utf-8?B?Ym5qWGZUQWVGUE1vQ1Z6NW1qMkMra1Q0NWRzVWkyN2tqTmg1UFdCY1VHRUZY?=
 =?utf-8?B?b1Y5VDA1dlg2OGYrWitzWXg1ZFdVblpFc1NqMUdKM3lVcVEyMnNUM2t2WC8x?=
 =?utf-8?B?RG9RTDhyWnNUVkdLN0FidjVoSzFjd1Y4eDg2d3plRTdubDlJb1pzK2k2VlJ0?=
 =?utf-8?B?SFNlcDZ0Y0JvbmowM1ptVU5VNkxhOU80Mm9wVkFZSy9mWGlhZHVvUjJ3NGRr?=
 =?utf-8?B?cFBpQURGNytPUFZ3cGp6Rmo0dVJCTGoybjlwUFRWZTRWb3NWa1RiblYyWVh4?=
 =?utf-8?B?UkpyRU4rR2RndTUyZGhkbFdvaG85a0s2YUZDK3o3OGdjcUlUK0ZmY0p3WDFH?=
 =?utf-8?B?WmFrUWdzQm9tRDYwRzJpOUwvcWd1L3o2aXVHeE1XM2VuSlhPN1lPWGd3RHhk?=
 =?utf-8?B?b1FWQjNQYjVlVjV3b0pCcDRVZW8vSUR0MDd1VWd3Rnp5TEFLZWF6ejV1VTdL?=
 =?utf-8?B?SXdCRGhFWFp1anFNRXJPNnBIaDZnY0x3SmZZcThIQzBjVlRPTk5rM3kyM1Fr?=
 =?utf-8?B?UWVyR0ZTZUpLM21HNWdPVUdrQkc4aGU5UGozMDlUYmdhRFgyclF1Q3lvakM5?=
 =?utf-8?B?bTEyRFpmeGc0azdtSWFvV1V4T1ozOXpHa00zS0JFcldLVjM5dkVTU3V5QlNI?=
 =?utf-8?B?c0ZYaEVGaHpqTWlBVXppRU9uREh0ZndqOVdjWE9Vb0xkcHpIYXZpUTZ3YWhW?=
 =?utf-8?B?WDR5Q3NPaU5abGVxVVY2TTZ3K3JHcWJRTUtXd1VVKytHblpBYjlSRkpQYTRC?=
 =?utf-8?B?Vjh4dTZ3SklaOUdPZVN1SDFKTTZJcnVBZ2svdEZ4cWVHbFlFeElHUXd6aW9R?=
 =?utf-8?B?UENLVkpRQmk4aklQR0wwMUV4U3RqMXl1T1R6cGR4VUE0cHdIRDRnaHBvMDNW?=
 =?utf-8?B?WFVFRlBmcmk2L1RUUC9ZOEZTanpYZWN1N0g0aEtncE9tODByaStKampZSWpw?=
 =?utf-8?B?UXUvdjlKcWc4OGh1U0xoRkdQNUhyMEt2dmpkNWlWTCt1YXhwdkRoQVFyWGR6?=
 =?utf-8?B?MWd5M25yYUlNd0NNaWdZdnJYMG9CV0FzNUdXdHovdXdzTy9VdXQ0ZjQwSFVI?=
 =?utf-8?B?T25wWFNBYnlDakpaUUtvN1hwY0RqOHVNR2lxaW9QbG9iTE5CVDZYM1BHZlNt?=
 =?utf-8?B?OGpKTE1PY0MwcjVhMXlxYTEvazl3WkxqWTY5VEhZVUo2OHp4SUpQL2RPd2xp?=
 =?utf-8?B?WlArc0lHcFdPeW1UUGVCTUsyZkNDWlk5RDJZOXRNVXV6K1M2Z0ZxRFdrRmxO?=
 =?utf-8?B?MHlqWW1ad3N1c0ZHVFp6UzVYM256WW8zQWx6eHBiakRMKzRNbWRPb2dObmhD?=
 =?utf-8?B?eFJPQlREWlRZWUJucWdFcjUwSVNoYmxWY1B6bkZ5M2R0ZXdPU3RuOEJTK1FL?=
 =?utf-8?B?ZHVxVHdldERnNUZxampRRm0zaFBTZWJHaThHeU9UQzlhTU1DeCs2ampSMUpU?=
 =?utf-8?B?Q1pGaEJUWi9xcGVIcUVRako1enM4Q1ZpZzNtK3lLZ2wyRGpQaUROM1h2a1hN?=
 =?utf-8?B?Zy9BUllNVktIOWJlNEU3S3JRU2VBPT0=?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(7142099003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 09:31:13.2719 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b7a55cc-a126-4165-0834-08de54e1fda7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFB21296325
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

The virtio_net_hdr_v1_hash layout changed in the Linux UAPI, replacing
the 32-bit hash_value field with two 16-bit fields, hash_value_lo and
hash_value_hi.

Update hash handling to populate the new fields correctly and adjust
offset and size calculations accordingly.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/net/virtio-net.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 317f1ad23b..512a7c02c9 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1879,7 +1879,8 @@ static int virtio_net_process_rss(NetClientState *nc, const uint8_t *buf,
                                              n->rss_data.runtime_hash_types);
     if (net_hash_type > NetPktRssIpV6UdpEx) {
         if (n->rss_data.populate_hash) {
-            hdr->hash_value = VIRTIO_NET_HASH_REPORT_NONE;
+            hdr->hash_value_lo = VIRTIO_NET_HASH_REPORT_NONE;
+            hdr->hash_value_hi = VIRTIO_NET_HASH_REPORT_NONE;
             hdr->hash_report = 0;
         }
         return n->rss_data.redirect ? n->rss_data.default_queue : -1;
@@ -1888,7 +1889,8 @@ static int virtio_net_process_rss(NetClientState *nc, const uint8_t *buf,
     hash = net_rx_pkt_calc_rss_hash(pkt, net_hash_type, n->rss_data.key);
 
     if (n->rss_data.populate_hash) {
-        hdr->hash_value = hash;
+        hdr->hash_value_lo = cpu_to_le16(hash & 0xffff);
+        hdr->hash_value_hi = cpu_to_le16((hash >> 16) & 0xffff);
         hdr->hash_report = reports[net_hash_type];
     }
 
@@ -1990,10 +1992,11 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
 
             receive_header(n, sg, elem->in_num, buf, size);
             if (n->rss_data.populate_hash) {
-                offset = offsetof(typeof(extra_hdr), hash_value);
+                offset = offsetof(typeof(extra_hdr), hash_value_lo);
                 iov_from_buf(sg, elem->in_num, offset,
                              (char *)&extra_hdr + offset,
-                             sizeof(extra_hdr.hash_value) +
+                             sizeof(extra_hdr.hash_value_lo) +
+                             sizeof(extra_hdr.hash_value_hi) +
                              sizeof(extra_hdr.hash_report));
             }
             offset = n->host_hdr_len;
-- 
2.43.0


