Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2E2D5B87E
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 01:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVKJX-0006yQ-M3; Mon, 15 Dec 2025 20:57:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vVKJW-0006y1-5Y
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 20:57:22 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vVKJU-0007si-E8
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 20:57:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AzF3pt5aA1ZwuLjM5YxKy2ByxdTX8PGTa3w7Q8TisIN7DWMRk2OS9DslpbPVBDXLzPw76slhrnz3xnzyUvzjq02lCgZF9xjjZd9OdampHT79MaQVeTNUJUzSrpNIp6UmWnIvPmVyDIzUtfyRf6+zY/WQex/SqLSZlj+p36mLxOB4gdTeJDlekqpIPQLUJEOmOm7Vy699psUPMZ7k+XbFtep9GI6sebHYTMEJtw1Bh8Xi24+LYWv5UV8oB5X3AhE6r2NOAomzg5A3De8xYw6zZ6r7rZD/RJb7FL5yh1uK22CrJak8d5Ihqe/T1o1RATcxjA1uMwh8ScEcZcd50j5QLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F31tcNbGDuo+bCqE9hUHMpKgoHKN9Xbq11mdJUXikI8=;
 b=xcnP9VMMScb0yvpCyIXaithUuRaFPPIl3MwBXJzLGHKiB8NLKqCa4AmzAXbsX0kmE8VbuHOzbWYe0riQ62Fru9eMZJQwYyLm9iIyhzZ9XtEY/TPfjAk/QmdBgvSAI2pHGT4fx1KLfP5yb3q93+GOqZqjvUOsIw/7inO0btcL9/78f5sSpSxHFpxN9xe/C50BzAttFKxZ40KlbY4LCnxjuFZAKVmkFCBCwW0FM5JZTDDzFot70F3kWUaRNUa5d7eLTeeycKrGUY64C96YaRjJfwF5+Xd0OMVy20E9WQSA5Rp1FGmdABVTcXAhF2jXqtZQ04Dr1Wtz2fw0+QsNGHvtkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F31tcNbGDuo+bCqE9hUHMpKgoHKN9Xbq11mdJUXikI8=;
 b=hMNvpXtdkPeIcMbuvAG0oXlI05L5QgkI655Pzl527vT+E3zy6BARQbOTinCd0W5lRJEeGZFHCk0GRXnqQPGK+nbfy01WXhQA/Xn52mnAGagI7IEgiu/pGqLESonKEkHTTdpM6UU/ScWChfVwNB0FgsDWojg7kEK8dp0D1hT+83cfkJRDS5brSC0PSQM3c1mFBwFE39inSYV32KcdFx9C4+hbq0tfXLYfqjrjM0/cRN3M3frqrX7JsEerTGCfnYTOyUGk9IUBaed4NozCa15AYWEUxAxaInNuHiEFPYZVf6L1lz+/rXcauxgfP+KZlgQJGco5sSdl/xpfjo2mtyCxiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by SEZPR06MB5689.apcprd06.prod.outlook.com (2603:1096:101:9d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 01:57:11 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66%6]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 01:57:11 +0000
From: Wafer Xie <wafer@jaguarmicro.com>
To: mst@redhat.com, eperezma@redhat.com, jasowang@redhat.com,
 qemu-devel@nongnu.org
Cc: leiyang@redhat.com, sgarzare@redhat.com, angus.chen@jaguarmicro.com,
 wafer@jaguarmicro.com
Subject: [PATCH v3 3/4] vhost: SVQ get the indirect descriptors from used ring
Date: Tue, 16 Dec 2025 09:57:01 +0800
Message-Id: <20251216015701.6601-1-wafer@jaguarmicro.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::9) To PUZPR06MB4713.apcprd06.prod.outlook.com
 (2603:1096:301:b4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4713:EE_|SEZPR06MB5689:EE_
X-MS-Office365-Filtering-Correlation-Id: 87eec2c5-cf2d-4163-daf9-08de3c466d21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qlcp1AaoxNNYpLLKvGxZX4An1hbMSZmVVSwaFuuZv9uBZZuYu1EF+YT2iBfX?=
 =?us-ascii?Q?4SYppNp9ImtV/OfxBSYyGsBiWuIYtFp0hBJ7iEwkPupYH0uNOFqENlsYCYfZ?=
 =?us-ascii?Q?SNtqZnxk9uOHz2QKjRqX0XN4l27Li2CyXTFIluNpf3cdcNx1HzKUzEkEXqV3?=
 =?us-ascii?Q?h/EDKK+jsrB5I2AW83KtiF5LN3CM0k5Pn3ex4x18uSdWtXedIAMJ+KvA5I1N?=
 =?us-ascii?Q?N6KvxVCAtz4bpoiO/tQHyDHsqSiLY4vsF4+La4k10EwFr6b2LnkUYFdWb9gN?=
 =?us-ascii?Q?PbahZoGN8YeYq4uF0dsOy4U3NrmVymM/XnjBcYJd9IesLtwf6Hrwtoy6rzEP?=
 =?us-ascii?Q?FM3ml4a35r4iuuhsQgcaFXFkgxpsjIHTnVeZJRX91YG7l+XVWnytvTXm6Bp/?=
 =?us-ascii?Q?eX18qEl9caxMU0aPvRUvcFFunQAy7IkCNucRQJZGm8F/IU3unky3ORF5urOk?=
 =?us-ascii?Q?JfnQXTwN0aTdAS6f3TaY9y65L9C/a0t3DfgVsFHBxG+5JBb+/+QwRuzKcEg5?=
 =?us-ascii?Q?8cm1Y5i+sU9VFTyPxkuRH+dH1yvwKUFJSjeXEffHRmE/6CjLk9g1jIzsDzOj?=
 =?us-ascii?Q?0nTFdeOoi4JRpefpp3cRZA3YZUVxu0nMk2ZD6pIx2K4fNOw/qSAF8CMMzkHF?=
 =?us-ascii?Q?fJuOGeAPPSMb4hcdz7Tmbui1nYmeNvdCvWSjaQf/8Fkmlyv1LlFnAYWwtiZA?=
 =?us-ascii?Q?I/IN/GUYK6CvIbKmmWAzcDts14VM46aigQxqy5hgxWohb4uQ6yk9Rs5rZiWE?=
 =?us-ascii?Q?VL3HJ/Tspbk1If6/tutKNvZ/uF2CRgPua0BL4mzixN9qC6RBMyv7auiXSlZz?=
 =?us-ascii?Q?wQ+FvasX8UGxdPnX9Na7uZkyjI33wE4IJfbgNAhXTftyjtrH4RhI+DyABunj?=
 =?us-ascii?Q?l2BiqkS+gCdEnbIyhOpey2xfu6xQ72UqAFC7CaSR69zaa40w1S4cn+L+VkkF?=
 =?us-ascii?Q?W5m4+k10PUSbO2YvzxeBYs+BheIs2bzM0vPa58E1yzLmdm/ES8h4OMkDslaJ?=
 =?us-ascii?Q?oyyuJA66wY/++cHgKl4VcG7sQvcd9/spRErOrAgNMfJgEMpieIeo5kmalPbx?=
 =?us-ascii?Q?SaHJQucq5yvhBASYWFgmWmZCAcTq85WDWU+e56k4aHN87iWarFLF/Ld71rya?=
 =?us-ascii?Q?5D9RTjocDMbPS/vU5UfDn3+PBSIEwiR2uw+7EEUSveHriCIKBS27wAfkztp4?=
 =?us-ascii?Q?7jLsXRbu+BrqXLVDhh73SSsUoFec0haCAldcr4Mlmi6ubL8bA2GlRMfZr1YJ?=
 =?us-ascii?Q?meYkNo1/5+/LtlFZSYivFqGscO8CmoFK8c5Idz6jPYDfQX3ecQ5q+mZy15tk?=
 =?us-ascii?Q?i97cBEoL1eI9Yjka8pBeJAC2yjHJo8W+gSI7XUyjP70vN+LKU/VtHPGIoR9y?=
 =?us-ascii?Q?1YHrjHJdnpD0g5X55e0ESxN2AZ2Z+WXHbUqGUkF4PWPfqXtDbQvNHaRrB0pg?=
 =?us-ascii?Q?LTc4xH34h1TvoGGCJ/y4J6oiT8HFsRKB9VW2zE/UvxAaz4a6X8NjgRrxntyf?=
 =?us-ascii?Q?nasgW3j/sTii5Kxyi41/Pt6lmYxJUU/85/qR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FxwT54OeLhdez4wb2hJknoS/sGDJR02TUXfDHvC5jVQGucdnNfgXXh6c9qHf?=
 =?us-ascii?Q?ish1CFYp5v9baGs2kKDwQb3gFbF65VwXV4ukleqRFeT/id4J5Zz2D4ZxZ4MW?=
 =?us-ascii?Q?sARqwzt44q901qZTnz4ALxhvOeNHkId0G60IgwC1/Psg9ndV76tU4f1sJj5o?=
 =?us-ascii?Q?B3SHBL5Memynq5B8B6xQjls/JVLzCISvUCMYACCXV8Tbp1Eqhkpvxx/9RALE?=
 =?us-ascii?Q?Hmnc96l7L8ZRbp1kWXCywfRGKpuv2tV0IpUbvtbhRy9FyXZQjrluQ51SbCYV?=
 =?us-ascii?Q?Kab1/67rCLBbRm20O0frLXm2s0/D8NZ7/xEHlRVDVFvGa2fduOJfL6JG27ua?=
 =?us-ascii?Q?e5dKf/W1+hwU/LAHcbPQW9XFLxZZH1BGLy8i7g7wuvQFVrMK+omnbPt0QC4u?=
 =?us-ascii?Q?4JAsWvQcbRauaibyzF0u//GphtZZtA8DT1rlibMuHeBipo3NCN09i/XC7Xm6?=
 =?us-ascii?Q?Fmk7RB+NJXAwYkdbOW2L9KecfoFBL2+9YE1yoPVX7j4Gs7nXl3HjZ2I/woTc?=
 =?us-ascii?Q?bdNLgB5D07y7MD7Zee5rNDStLeHmMob71x+o8Ihs7w8xCWWUOLur4bT9MuZI?=
 =?us-ascii?Q?Ug5aj/CIqOusbOX67RWGwOX/Wk94+jrmxXcVOXQkZxvWnLQcckwwB0uo22sM?=
 =?us-ascii?Q?y5wSJnEE3TuBA5618SKBxs8iKuo8b4D70XWzDkWJxehlbdGS4UabbdDfoaMv?=
 =?us-ascii?Q?F2aQGmz3zLn0SSkWVqqs9a3BX0UPB9j+URHKw9cl+xhMnLMknuoXKw1zi5yh?=
 =?us-ascii?Q?/HX2l1SzGhULFvUoATowePeNcRxF+qeE+bszIBvRO5q9zt8RBEzYHHqyMof3?=
 =?us-ascii?Q?V3c6SlQm9lvVzNRk9p7SEfuTZYV5fJYAG1uPQlUNZc+DhCAnkNlEDgayxymL?=
 =?us-ascii?Q?QuQfc4/ybqv/ublLGDPZZRH4k/sVFReVgXDRHIxvceK/CsNNXH2Evof5sVAC?=
 =?us-ascii?Q?/+mHtpj2g029OX7/CVt8Tp7eHm1MVqGrgcvHysvlWK15SVEfCRBSDUwP/miA?=
 =?us-ascii?Q?BpuhSmzE4bGMbiMlFMtlqBsG/rP/nJfwiyZ/+amBDVM2A8YysCOtGoNYGda/?=
 =?us-ascii?Q?yDXnrnY8WRMQGOx7DCmLDI793Ply8XPZydS+0nEmGnyP9HzTq0Gfyi3YHEbX?=
 =?us-ascii?Q?C+KMnSD6OHYYSOgEEYxgAVwVq76JYe7SB8WdEkGiLm5CecMRASM8Rk2pBY5b?=
 =?us-ascii?Q?/iJTY52W4ezOxBnN4N/wQ+JCV8BNuveUIwEgY3aSz/8pZm+pM7FyFTXNI1i8?=
 =?us-ascii?Q?Ui1ESQ0OMzAvwd7/ZkW3iVWBkfqHiuxvx3aQp6Q5Ge3r09zNyyBkt80XU5WM?=
 =?us-ascii?Q?iTHb5dt8Q+qbNg3nZ3AsPjDLs1wkvIdmWnMEgVqHrcq1xckGIt2fL/pCHxcH?=
 =?us-ascii?Q?Fb7cUsTpdktdUXLPaDDSnWCjovqHmuGW1eNMnqi4HPp4H/AscvcS3D/yvopz?=
 =?us-ascii?Q?hRFj/lmCfZq8JtTD19MmfWlxKz9JU0k+6kuwHoY0ElkGOveKFoc4tEqFcAlg?=
 =?us-ascii?Q?7SCPF6oz+i8SUNHAhOdBPOrhwOD+F2LaJrwp3qeoQfFV22ALaC2VyfJL5DU2?=
 =?us-ascii?Q?1JzJurt8d8iW3OpRd6gtwjd5v8cbtHJJgfk9CONj?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87eec2c5-cf2d-4163-daf9-08de3c466d21
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 01:57:11.2182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bgu7amxQRMUeyIa7RF2KADGGy74gftVwje5IBzGGbGAwdsN2KahWad0DDZUAU74Hi3dla3dmecT/gJm78FFK9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5689
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=wafer@jaguarmicro.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

From: wafer Xie <wafer@jaguarmicro.com>

For the used ring, based on the state of the SVQ descriptor,
if it is indirect, retrieve the corresponding indirect buffer by index
and then increment the freeing counter.
Once all descriptors in this buffer have been released,
update the current buffer state to SVQ_INDIRECT_BUF_FREED.

Signed-off-by: wafer Xie <wafer@jaguarmicro.com>
---
 hw/virtio/vhost-shadow-virtqueue.c | 43 +++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 85eff1d841..adee52f50b 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -469,12 +469,47 @@ static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *svq,
         return NULL;
     }
 
+    /* Check if indirect descriptors were used */
+    int indirect_buf_idx = svq->desc_state[used_elem.id].indirect_buf_idx;
+    bool used_indirect = (indirect_buf_idx >= 0);
+
+    /* Update indirect buffer state if it was used */
+    if (used_indirect) {
+        SVQIndirectDescBuf *buf = &svq->indirect_bufs[indirect_buf_idx];
+        unsigned int ndescs = svq->desc_state[used_elem.id].ndescs;
+
+        /* Increment freeing_descs for descriptors returned from used ring */
+        buf->freeing_descs += ndescs;
+
+        /* Check if all descs are accounted for (freed + freeing == num) */
+        if (buf->freed_descs + buf->freeing_descs >= buf->num_descs) {
+            /* Reset buffer to freed state */
+            buf->state = SVQ_INDIRECT_BUF_FREED;
+            buf->freed_descs = buf->num_descs;
+            buf->freeing_descs = 0;
+            buf->freed_head = 0;
+        }
+
+        svq->desc_state[used_elem.id].indirect_buf_idx = -1;
+    }
+
     num = svq->desc_state[used_elem.id].ndescs;
     svq->desc_state[used_elem.id].ndescs = 0;
-    last_used_chain = vhost_svq_last_desc_of_chain(svq, num, used_elem.id);
-    svq->desc_next[last_used_chain] = svq->free_head;
-    svq->free_head = used_elem.id;
-    svq->num_free += num;
+
+    /*
+     * If using indirect descriptors, only 1 main descriptor is used.
+     * Otherwise, we used 'num' descriptors in a chain.
+     */
+    if (used_indirect) {
+        svq->desc_next[used_elem.id] = svq->free_head;
+        svq->free_head = used_elem.id;
+        svq->num_free += 1;
+    } else {
+        last_used_chain = vhost_svq_last_desc_of_chain(svq, num, used_elem.id);
+        svq->desc_next[last_used_chain] = svq->free_head;
+        svq->free_head = used_elem.id;
+        svq->num_free += num;
+    }
 
     *len = used_elem.len;
     return g_steal_pointer(&svq->desc_state[used_elem.id].elem);
-- 
2.48.1


