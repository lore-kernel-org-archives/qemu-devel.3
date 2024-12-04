Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9BABE7716B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 02:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIetc-0000HG-1L; Tue, 03 Dec 2024 21:13:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hongjian.fan@seagate.com>)
 id 1tIetU-0008N4-3f
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 21:13:36 -0500
Received: from esa.hc4959-67.iphmx.com ([139.138.35.140])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hongjian.fan@seagate.com>)
 id 1tIetR-0005Xu-CS
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 21:13:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
 t=1733278413; x=1764814413;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+7s5YxCcPou4+jptJ5a/8KpnpHkVJl7MhtJ/XXpRI7U=;
 b=cJi4n4CUK0Kc2sXGHaUJ2Qw268wFQgqlpmozJPttdYMabLdP9Rxxnj4U
 SG+nDo3Zin3zKxJA+Ngd60LVL+3su1aAtpUN9MdP8fS1b5/QdWCnMIh3U
 94KFVLuNoMw8H8TYtuxSiuoj1y9XEkBBcUec1/A+njv6qh58K/XPCIggz 4=;
X-CSE-ConnectionGUID: lSjEudgYSVK3A6voXpuDsw==
X-CSE-MsgGUID: 8Muekj57SSqy3AI0zJk1cA==
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
 by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Dec 2024 18:13:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EYqEhA8PTchMAqkhPZCxqZY9XZ/P5OZMmm6zRi6QKHSs/YyOISyaUojvTUo3QVWGaGneTOrBabBRK5Y1QlJbzUwgPWePBvvt6NEgX0hTEe48mjwQBz3NuvUM8LaDPxnEa896MDCKp8RhEckNbgPF2QnF+8MEiKbgSwZJMb+iT45cypCH3/ydPkWyt9Bkt5UncojkY0ebjM0wKtdKko1HNAr/pMOiMUQT0LK5n8nTLh4q9+YQnkDV0r5y4RA1yCPqZc7dWay+LySyOeNNHpo1e6lsocOGlvRwOZni7gugvF0h3TzGyhqYUdfg7RE763g8b8LBs3vcNBkjaFLXvYTj1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfLP6VNH5k9Lq6gOZ7wCWaVDzYSts8l/dxvWw+CZ7sE=;
 b=IBaq4Sr13iXt01lRZBoRqHc3lluMp4rtGHxvTB/gG2KblCYVBXPID3YamQAGDUEzpoiv7k/5WYCOtv3zUtuUl6+hrfns1igj9cTj3Hor0dBJIZOzEkzB7V3OYcgTeplxcXwmg2jIY9o7h4IECRKAKFuiMh8HEv/XwlhrWLjvJzm4CAaIupDbg4MESW7xI0ll68yAek5K2msdRYg27S12caOUx8ONH7Izy15Q8Xp2rew+LBmAik/59VN8qoft58W+YsXTLhuhHT5wO9Ze3mH4dyTVSrrjkHL8z6siv5iZZ9vN1x2yJQDtYIBP1XeMP9mAZmzlg9OZxfo6fosaJxLFwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 134.204.222.52) smtp.rcpttodomain=nongnu.org smtp.mailfrom=seagate.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=seagate.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfLP6VNH5k9Lq6gOZ7wCWaVDzYSts8l/dxvWw+CZ7sE=;
 b=fbXFOkJAjj5AJpuc5U0ip1CZizRbII01DaEtjXxg/LERXf0cM4+LZ96vZWTKcWjteDmpGgEYMKMPFuUD6GOaMOTS3ThJ5UQPWbRyYN75JxftWG6SGKHEjaxjmSJJCus1GjRWGFmkEt9HzswNF5G5RRTb9/cyfne32QvzJLVnH2M=
Received: from CH2PR12CA0022.namprd12.prod.outlook.com (2603:10b6:610:57::32)
 by DM4PR20MB4872.namprd20.prod.outlook.com (2603:10b6:8:a5::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.9; Wed, 4 Dec 2024 02:13:24 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::6f) by CH2PR12CA0022.outlook.office365.com
 (2603:10b6:610:57::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Wed,
 4 Dec 2024 02:13:24 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 134.204.222.52) smtp.mailfrom=seagate.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from lcopzesaa001.seagate.com (134.204.222.52) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 02:13:24 +0000
X-CSE-ConnectionGUID: QSggXAh+SO693vznrlQilQ==
X-CSE-MsgGUID: t1fcy6QVTDGr+VTzuxJJJg==
Received: from lcopiesaa001.seagate.com ([10.230.120.52])
 by lcopzesaa001.seagate.com with ESMTP; 03 Dec 2024 18:17:01 -0800
X-CSE-ConnectionGUID: pxKNXXo9SIW51BBl0feTtQ==
X-CSE-MsgGUID: hVHhVBbPQoW39jRpKYsiZw==
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; d="scan'208";a="112360643"
STX-Internal-Mailhost: TRUE
Received: from mag-tester2.shk.minn.seagate.com ([10.52.21.5])
 by lcopiesaa001.seagate.com with ESMTP; 03 Dec 2024 18:13:07 -0800
From: Hongjian Fan <hongjian.fan@seagate.com>
To: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 jonathan.cameron@huawei.com
Cc: fan.ni@samsung.com,
	Hongjian Fan <hongjian.fan@seagate.com>
Subject: [PATCH v2] hw/mem: support zero memory size CXL device
Date: Tue,  3 Dec 2024 20:26:19 -0600
Message-Id: <20241204022618.1572959-1-hongjian.fan@seagate.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241203172328.00001a00@huawei.com>
References: <20241203172328.00001a00@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|DM4PR20MB4872:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1b5a1e53-02d8-46f0-41c5-08dd14093b98
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MY/4IxtWG9s1R2H0ZH5nS6FcJoUnmuomOHtHVjqfCMBqcCyU2dz7T8qB7qT+?=
 =?us-ascii?Q?lbs/q3OxcLcKPKGictTNPCWCBUDTBZu1HQ5ACcDcZ3L0+TUrUWbjk4UCKhSJ?=
 =?us-ascii?Q?daWiFk0Zlm/k+xuE+LRofoxFqoU6CBNqe+2M6XlmAOr29brg+wh35VS7JkLt?=
 =?us-ascii?Q?T1bA2wWShFzjwWJHs5CsPXlg7mruMzClWoK2oSvSVeeg/w59bTuYe7TdQZea?=
 =?us-ascii?Q?f2r9s48zW5KzvKmFIWe8XHXm+Qxyp4D383ckN6QfS3OQMNphEufkj+0qkV9h?=
 =?us-ascii?Q?pGxgpwSQQMpLMbgtcVMwGE9NmZEN2LEi3wojzM0jxcsXvTPiwofC/naKuQ+4?=
 =?us-ascii?Q?4fysM7PzkB5p8zXTXH1MEDHsQEvtfYjaGY0Gpkd6AGpa6UH5VRpK+IhqRxL5?=
 =?us-ascii?Q?RJaHSXPZP8VB50tQPQ+xhpyuembI8Mpn6reWl39GWkzrJFqnFScSzzmj6S7n?=
 =?us-ascii?Q?gcr5aLbgMFS1EC9eAGaS0OKHyN4ocL6qPYNg2jGliBewlEgYkglu3B/5h+p1?=
 =?us-ascii?Q?hAg6Fzs35s7MlVSmKk5MQaw/x+1p54XfRyppkvZmGtWViEFlenrM3k3baZM3?=
 =?us-ascii?Q?FFYgI3lBrqaVw9lQbfXzzjmLF8l12QIq9KMO0C4Ur/ayJ3MlLMaopMW1wpr+?=
 =?us-ascii?Q?bbqzOsHACTwXn52yyMkBiU7gGY/r4XPj83k4GmD8gzVpgOAW5PTuZuZDzWpF?=
 =?us-ascii?Q?O9yzWfOHJqQZx4fIT0uSyMCEgt2ipQC/SDRpMu0hyZS+HTuhB2FAN3T5pk52?=
 =?us-ascii?Q?9RA87q0jHDrzPI7x8f7vHrlqQ0QojDAardj5NNys5+++JxTw1pFukSCKbb1T?=
 =?us-ascii?Q?d5DwdEhks6C3Fs7Qal85ECMH/EJEYeSw8qqULzCJxW0+0C1BJZ/kqSO2lO8q?=
 =?us-ascii?Q?dKy8q6+G0TlqNWEqAu9TSJMoHCAVVWTrLhKyMUcuqWCJS3N8O4mlocWPbfbr?=
 =?us-ascii?Q?ZqFslWZrvXV36FXLhzJR5jL7xmAWv9EUhv4W697YBLOZ1I8RLDyRcpP1vU6S?=
 =?us-ascii?Q?eHsiw5KmKcQw43Nla9uIQbNefjwDlkvJVr2JBQuMQHQNRZ0i7kJQE+mpQyhz?=
 =?us-ascii?Q?Rwf3fFL1bwtTPi87samqep8ZHWu+ALgU78s+FYwn8MA0fkXXXauvMTErzmhm?=
 =?us-ascii?Q?Zvrq/WwUf0jSvFL/DrC4QZeodFubrD6TynONvfJaaIB6ASj2jT6IgPN2BS/A?=
 =?us-ascii?Q?d4jH8HlmsNnkM+Te71DpiVuW1Bh7U0d8Wfasawp4SMVjayJDc6pdamoN3Qrs?=
 =?us-ascii?Q?VWaHNAG4ytx39vzqeLOOcFdTXlBNaUmR57pDoBy6mCvkJ0x8GJRKsf/R74HU?=
 =?us-ascii?Q?RW1v6WsOPJQZcl/GTE1+9RG5yBAsrjN0CQfHqthIpHe52IgUvNPb23Yaj5rt?=
 =?us-ascii?Q?8m28FebGcHTKrlEoP5UeHYice8I4iUQOas6B1d4xDbWt4ySn0hMjHT1NakYH?=
 =?us-ascii?Q?KvRvHaTev57SIDjdEBakLQX5Kvshu8a1?=
X-Forefront-Antispam-Report: CIP:134.204.222.52; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:lcopzesaa001.seagate.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QWlURbg0OFNZTOiZ8X4ax1nMfM6U+qIKJu8f+psDOhiVQGw8JON8EM5KThrWf+oHDz8TWOu6NoRzl4054LFEN9f5wg5B6tA/2+cFJbf1kd+kWcrSRuLaY5oYGtEfJKjROA5clpu0MEqZgZd8TkzJTQyoAxGF/+Yhy9XOXw824O+OSQ65RHX7LuJ8mMB5/UQsGILz4bTKunqm7oWtJ41/LcIL0ipoVPIy82YI1+1IGq5tY4SsyP0JDskHd1JVBms9VZFE08NFLL/V143v1ol7HXwGSDOfbNwySOWSwLIy22zi5O1C6fAnaa4TDAHzMO5AZHLD28a3xHSvTEPPRJAhuN4OqSr1gYC+X95tqPpLfK8NIwI/Lv7TkINEjFjmApmudfcDDHpx3z8yJNKFGhLQy64j7ldFtM19L6MKYgjyyzax3oq5mUIKzDslZEpMkibvuocCFoAAgPLDbvpoUDgRpHmQS1GWm5aJ81LZm6LL9rCPz3FwZyXV7VfrA+r6L58ZhMFRNOhFLEsnfrjP5DEK4uHIqB4noTi1lwbOnec9lZ+kMtfcMMK2Hj7FDHgiJnrklIRm8VyiOmsGpoMLfwGh+p0cPfpYkWrKh3naaFmyhyX9Ob2qmbS9amBQ+evTRjGG
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 02:13:24.2011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5a1e53-02d8-46f0-41c5-08dd14093b98
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe; Ip=[134.204.222.52];
 Helo=[lcopzesaa001.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR20MB4872
Received-SPF: pass client-ip=139.138.35.140;
 envelope-from=hongjian.fan@seagate.com; helo=esa.hc4959-67.iphmx.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

This patch allows a CXL type3 device to be initialized with zero memory
size, when there is no memory device property provided.

Signed-off-by: Hongjian Fan <hongjian.fan@seagate.com>
---
 hw/mem/cxl_type3.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 5cf754b38f..4c9d6b8f17 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -159,7 +159,12 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
     int len = 0;
 
     if (!ct3d->hostpmem && !ct3d->hostvmem && !ct3d->dc.num_regions) {
-        return 0;
+        /* zero memory size device. Build one entry with size 0 */
+        table = g_malloc0(CT3_CDAT_NUM_ENTRIES * sizeof(*table));
+        ct3_build_cdat_entries_for_mr(&(table[0]), dsmad_handle++,
+                                0, false, false, 0);
+        *cdat_table = g_steal_pointer(&table);
+        return CT3_CDAT_NUM_ENTRIES;
     }
 
     if (ct3d->hostvmem) {
@@ -712,8 +717,11 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
 
     if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem
         && !ct3d->dc.num_regions) {
-        error_setg(errp, "at least one memdev property must be set");
-        return false;
+        /* no memdev property provided. Default to zero memory size device */
+        ct3d->cxl_dstate.pmem_size = 0;
+        ct3d->cxl_dstate.vmem_size = 0;
+        ct3d->cxl_dstate.static_mem_size = 0;
+        return true;
     } else if (ct3d->hostmem && ct3d->hostpmem) {
         error_setg(errp, "[memdev] cannot be used with new "
                          "[persistent-memdev] property");
-- 
2.25.1


