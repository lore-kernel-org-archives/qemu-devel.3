Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D91D41D74
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 07:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV3SZ-0006yx-R8; Mon, 15 Dec 2025 02:57:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vV3SX-0006yk-Gt
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:57:33 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vV3SV-0003fY-CU
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:57:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMmLO0wms889z8/dZ337oh04V6KOpvDKPN7CZv9GT6r+/w2wT23DrnfA6fO6+ZUA9L23goCE1rPWLTltAu+jpFx/6lSFRw44RswOIWVDn9VDIlracE2C9YLVU0/5fnWYSlG9xz8APvA8CuWl5cfOvh3NLjhJ5PNmFj0HBz9p5vtuoa7XxI5ReZ0NT+y/ia2ea5JUBS4nkZ1p2fv50LzLV59WO/rLUGiYLXuMFV12gd9eeFwADbCgOJf/V8FyttNbbyMqCV88mQeOW2/9tLh2VQtY/q+BB/dWGolonBLqyTl++uE38t+7LmiAN1n+c8BDCM4rrEPsbQX7u1bOkDnIyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDBhK0ltn8U8oW54Y4E27+KDFWOMPNTHaisoipiJqNI=;
 b=bgjCy+UAPXPeZU5MHxbzhMYT/2uGm1OLgnuEaLkKEAtyFtjA5gG6rtdZJkjROz+fy75hIR18SuzsFfUZ0ZcSJeCgVc+dx/iV23emSQrINOgTeXjXabAxePU+89HBM9e5iOlkf5Djc09Lhprw7tHXd1nTS5SyR06EUJ2c2xetq3F6SZ/KYBeQn+qS7Q4lCt1Sslat3V9CjHy3ellsjqHeFRc516LKhQWQRAi4avdwxy3/G6aC57SYClgT4HPtf3bSwbOQjW6O8pHo6Dvs+6n22qGs3KVKVmAwP0+aI1KhLFhUstN1V4q4Jell9s1sigOjim2e0SCCRytCDJ5fgTYAsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDBhK0ltn8U8oW54Y4E27+KDFWOMPNTHaisoipiJqNI=;
 b=T08w3hFkxDQntc7+9c9Q4s2uT4MWBFXD5p0ev2qsliRQjzvKsQBq2gic2ETyAzOIdutmP0alz57pGzgVsGUnl3tX7y8MQ+2BhwpU0wQbVrQl7qxk40kZbOUk6y1T+JtSk+s/giiasC/dOPZL2lCfdtRCBB+q2Szn8rWoi531MIMcq9ZicVdOygbXetjIBqBIqAwBOlZ8OV9SuzIgn7ohHySigRKwdeTQ23s4nXbqvcj2Jmv2AgQX1zDFqmjPKVkGKpCjyQMBI51FcvdcTMGgibSCiBaVRyu/Uj3MoYyJ/TLwz0V0U8gjcIUIph+zW4J1wYR7kf5FvdZpTg1ogtJMOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by SE1PPF215029121.apcprd06.prod.outlook.com (2603:1096:108:1::40e)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Mon, 15 Dec
 2025 07:56:53 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66%6]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 07:56:53 +0000
From: Wafer Xie <wafer@jaguarmicro.com>
To: mst@redhat.com, eperezma@redhat.com, jasowang@redhat.com,
 qemu-devel@nongnu.org
Cc: leiyang@redhat.com, sgarzare@redhat.com, angus.chen@jaguarmicro.com,
 wafer@jaguarmicro.com
Subject: [PATCH v2 1/4] vhost: add data structure of virtio indirect
 descriptors in SVQ
Date: Mon, 15 Dec 2025 15:56:42 +0800
Message-Id: <20251215075642.2245-1-wafer@jaguarmicro.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KUZPR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:d10:31::17) To PUZPR06MB4713.apcprd06.prod.outlook.com
 (2603:1096:301:b4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4713:EE_|SE1PPF215029121:EE_
X-MS-Office365-Filtering-Correlation-Id: cd3781fb-4698-4a8e-19e9-08de3baf82c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y4jpp0EpH5kFi0KKCc8q08SDidTu1S1B+I9tzMnT7z+0b0Mx9Q4YN5gXbRdF?=
 =?us-ascii?Q?QwO03a2mGbKF4F3a1UKq+W9JaY6nX0+GfiRNvEEvJYDSmA7DeqysYVWqg7uH?=
 =?us-ascii?Q?eIigUykEGhN+Xz3aOIiwfUU2gvnQZO8Q3+dLSVn7ISJ6bFCA0mPw89MUeXlj?=
 =?us-ascii?Q?IE9+aRCBKwNfetqqlGxLOUi3FM5falyaWo+5zpTgQtcs+oX7l9rQubZ318zX?=
 =?us-ascii?Q?bMEqK667gmPok5wI2D90dc1C2fUM4CeyoGfuOmmZj1Uj18XavlsIAMegWm2h?=
 =?us-ascii?Q?hJ5hAnwT/wyJpQlxHE4Qi1etVtMbZQjVRpBl/EMXjDm1rmKiejcx4efpxoMC?=
 =?us-ascii?Q?376GT9Ne9d5uAefK4u7rJg3kzJIU8n/fRbQy28IJzuMhen3wBiajU3am8mjL?=
 =?us-ascii?Q?3HC8FSS7V0j208kMK7Yrgdpl/Gt+XZdrrxRnx8qrNXRR8kFQsRjqhGBxlpg9?=
 =?us-ascii?Q?h9Xeh21y5kXLt/KqLvzhpq7+sjGw441SVCMRzFBmNoT/yRHAeiOIDolXbX41?=
 =?us-ascii?Q?oZm/OoIjNgFMptk+vPIq3JFPIcNVAQtcIm2ErBvSmjwf3STypMwFDuHJgiwW?=
 =?us-ascii?Q?UPFv6mkFH5KABvS5FSUjSRZAvitx3nJDHSyBAsm7P23+6QKxxBL9s5g7E/J8?=
 =?us-ascii?Q?9y+3Eo5XWBvVUoJ/U5ELC392RZZkfWNnPGTEZGuYUZ+R7ZJtaDl4DgEk3F1L?=
 =?us-ascii?Q?hSlnQffbAb46nfiNW0UnjJkgiiFVY02VtObHuy+G99fqrR/Q4c1VyvLqtRDC?=
 =?us-ascii?Q?oCTy5Cihsvs8AYYD2SkDK7Yf+fmG8qJh59fVcgc0xbchX9We9T3+wrNLtuKx?=
 =?us-ascii?Q?jlBGffdkNTzzGNaJ6F7qkL/De0DV608NV266vBnh8IOy6eHpj1SXYdrHN+px?=
 =?us-ascii?Q?AVWeVH7bnKturZCL2l9BXZTs002cJNrmbuoxui4R5G2Hv2PS7fRoLNapZJOe?=
 =?us-ascii?Q?3dLuohkmliw2ZVNZU2TYrPNXFUZjAl2CT2bHsx2F1OZa6niH/Yf7zVbJ1Mzn?=
 =?us-ascii?Q?swxXMmK8L4FJsr0gvIwcstBtnZHx//YjGlN1xFZObnOaDApLwtgiXrOaNqyY?=
 =?us-ascii?Q?UmGEAPb0hXm0G0/uo9HBufPPdRCIuMb1nxfh4JySQtr9Z6Yo/KAYQbDkUjuV?=
 =?us-ascii?Q?qhvvJy15TGtyLC5nxG/FRnLRBtTfzDp9fQu59Kgq96sRaZWNI0+FNt/FhSPh?=
 =?us-ascii?Q?iqi3sHRi5vqfcVn719AK8y2R6ijNQ7Ei7K4tBvF2VD+0KhXocwTW5SBXbSkl?=
 =?us-ascii?Q?T+pqrmyXZWgXYB7h595MyScR3rwTfBnbGy51eW0Zjfpz2KzPTS07y8cnfOaG?=
 =?us-ascii?Q?74hECWSRrrYH2pyUB0lxUPatZFoAv15Lw1UaV+ukJ3n7OEwTE+z/UgXghYTX?=
 =?us-ascii?Q?kHAGqYg5qI7M13/pIa2c0B268IRzSDvPkl0E3agezT/tZI1/W/z6Twcl1zWq?=
 =?us-ascii?Q?KodpDKyscQkOfFDSXoaOQk3LMdYjlWwOV+kHBm+8CyDUUqjXURkT7wbmLsLG?=
 =?us-ascii?Q?z3ED7Sp5tTT7Dgj1S/qndeGnwJhlm20hMQG4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dMLTunfXo+Y5v1l6AiQ7PRggrPfdCS6zxTIZ1Opw8C0bDyNi0ZN9e8nSUdVh?=
 =?us-ascii?Q?vq6mP8/HCy/ou4HN5jYYUjjXnApu8Sy48DciuFqDdVooRHib3LE7C0sUDKnK?=
 =?us-ascii?Q?CjcRf3MFD3pLH4L8AP6XcBsYkrAcTb+r3OTqcEyCfo78o5ZJStDlitwWrXvD?=
 =?us-ascii?Q?uO5yiVKqGZzfuCMnsbxGTUF/jnxpqwjBqg+JZJtyMw1KfWhi4UEh2Q0OiIn6?=
 =?us-ascii?Q?RoI+6vxui0pLOmNQ4JjvS21xrp94Y7bNZrCzopqB5lOZooS2AEtwHaZYazoj?=
 =?us-ascii?Q?lfJYM5T3Ct/7W88HSBcxDzA5OFEYNvUeih66sbLOvMMAshrPmEtq2O+0lZgM?=
 =?us-ascii?Q?uwMus1R+dC0Ulhp/7/AdvNrINzXJhLhzXKhp2+VgT3y3xcw1jPDX+T13OHWV?=
 =?us-ascii?Q?mGcG/XpzIkWs3+QlihIH1feDoy0oE19aVXLHzgYRYZcX9gJn4OdMmcW9kqff?=
 =?us-ascii?Q?1h0u0SodU1ho3hj14uTTmeZPy8m8wv7f8m23sNti60UCb6XVZvwmRIwhZcpA?=
 =?us-ascii?Q?528BL7LTjJIn2ZDoJcdaOqTfcuPXVr0LwlCDy9ys2ialZrHEzXsa2tvBoAum?=
 =?us-ascii?Q?wBD3hLAK2li2NfBCKU1aTesbjlrE1Mmm6rb5vLXDBPHOpaXLTKvrZas93xBK?=
 =?us-ascii?Q?8PfURBq42p9JC4YHnSslHLFM9bP5uVtPXvxv/mRWcyUyvuZFFdXc4OLlPXvv?=
 =?us-ascii?Q?awehl8TrH1p+Ric7abA0J3p4v35FtZQTgn42tOHn7gnox8SEa02UPTvcbQor?=
 =?us-ascii?Q?Yqn/ccaGRvYD4QYVnq1tpYHcazf3EARhMGU1SxsSRsIgwNFn2wi6SwdrQ6Co?=
 =?us-ascii?Q?HSmHKzRRr3R7xVB73/TFhigfUtIVcKSWVWH+Ej6mBHRsM1mum4evUZvy73u5?=
 =?us-ascii?Q?3VCquYN7WumMN2ulZrwzF/iCL+parDX1j3AJ0jwqV8PXoJFOQ7zoQxkjWaYN?=
 =?us-ascii?Q?43sjdLbK8i2AY4xVKOOyq/hVhTGGu6UhxY4jts59TR4qCdbwbuVpMjIdR8Kh?=
 =?us-ascii?Q?yxDETdhS6rKlnC1yjqmREp1SYxDZDrlxJQ/rclTOXbYaJs8SOd3OW1eelm2j?=
 =?us-ascii?Q?1usgc9MklYwW2RDmSHQN4a1zQsVnZludGMReA6aE2gMOY8wII43lBbhsU9SM?=
 =?us-ascii?Q?KlrzDoKJ79WfbfZR3ihRWWRTC+yUCfW+13hpunBpmWT9PDLhID4VIA3tyroZ?=
 =?us-ascii?Q?5abB7Kk2DdLonoR8Aiune/M6D1Z5X08amGoZ2fCw2Sxm7NMuANfn70xl3U4p?=
 =?us-ascii?Q?S8ksEgC3GqFCuhpbgEZAjVdshZUSNXKzKNJNGw+WdWgerTQIaEk9vRSHqvt4?=
 =?us-ascii?Q?y7ZDG5vS38ujgeRjr9aVarUYes5aC4hKa/Crf17ahPkTRsOQkPHeIxS9axgr?=
 =?us-ascii?Q?QdKovsSI+pn0kkfNtN79GchRzzZ51zMpRH++jMSjCze1DUzlW9uHPDEjT1/+?=
 =?us-ascii?Q?M8W1mBSYsyKQ4aUHggbaAJXtyz7ZsYOxyOB6A8BotuMef+mOba9IqF1jSmE5?=
 =?us-ascii?Q?hlRFjupit9REzwW9jIp7TEOAX3zrbxZjLW3rywNSNauUKC6RB0yr2HI3wSOh?=
 =?us-ascii?Q?tgEc0CZ0YkgniGOnZ5pqMb/Ajdw8YA5WfeP96FE4?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3781fb-4698-4a8e-19e9-08de3baf82c8
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 07:56:53.4742 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qx3S+2Mwxqkdi8cV3Oz14BovjKPDWbzy5dF6qk0PSvX9HoJhZepkoRHOdWjxglXsfj4G/9K/5sQb5TyODRhSwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPF215029121
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=wafer@jaguarmicro.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Using multiple statically allocated buffers to store virtio indirect descriptors

Signed-off-by: wafer Xie <wafer@jaguarmicro.com>
---
 hw/virtio/vhost-shadow-virtqueue.h | 45 ++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-virtqueue.h
index 9c273739d6..ee8f0660b6 100644
--- a/hw/virtio/vhost-shadow-virtqueue.h
+++ b/hw/virtio/vhost-shadow-virtqueue.h
@@ -23,6 +23,12 @@ typedef struct SVQDescState {
      * guest's
      */
     unsigned int ndescs;
+
+    /*
+     * Index into the indirect descriptor buffer (0 or 1) if using indirect.
+     * -1 if not using indirect descriptors.
+     */
+    int indirect_buf_idx;
 } SVQDescState;
 
 typedef struct VhostShadowVirtqueue VhostShadowVirtqueue;
@@ -46,6 +52,32 @@ typedef struct VhostShadowVirtqueueOps {
     VirtQueueAvailCallback avail_handler;
 } VhostShadowVirtqueueOps;
 
+/**
+ * State of an indirect descriptor buffer
+ */
+typedef enum SVQIndirectBufState {
+    SVQ_INDIRECT_BUF_FREED,    /* Buffer is free and can be used */
+    SVQ_INDIRECT_BUF_FREEING,  /* Buffer is being freed (descriptors recycling) */
+} SVQIndirectBufState;
+
+/**
+ * Pre-allocated indirect descriptor buffer
+ * Each SVQ has two of these buffers for double-buffering
+ */
+typedef struct SVQIndirectDescBuf {
+    vring_desc_t *desc;         /* Descriptor table size = num_descs) */
+    hwaddr iova;                /* IOVA of the descriptor table */
+    size_t size;                /* Size of the mmap'd region */
+    SVQIndirectBufState state;  /* Current state of this buffer */
+    uint16_t num_descs;         /* Total number of descriptors (N * vring.num) */
+    uint16_t freed_descs;       /* Number of descriptors available for use */
+    uint16_t freeing_descs;     /* Number of descriptors being freed from used ring */
+    uint16_t freed_head;        /* Next free descriptor index in this buffer */
+} SVQIndirectDescBuf;
+
+/* Number of indirect descriptor buffers per SVQ for double-buffering */
+#define SVQ_NUM_INDIRECT_BUFS 2
+
 /* Shadow virtqueue to relay notifications */
 typedef struct VhostShadowVirtqueue {
     /* Shadow vring */
@@ -96,6 +128,19 @@ typedef struct VhostShadowVirtqueue {
     /* Caller callbacks opaque */
     void *ops_opaque;
 
+    /*
+     * Pre-allocated indirect descriptor buffers for double-buffering.
+     * These are allocated when SVQ starts if VIRTIO_RING_F_INDIRECT_DESC
+     * is negotiated.
+     */
+    SVQIndirectDescBuf indirect_bufs[SVQ_NUM_INDIRECT_BUFS];
+
+    /* Index of the current active indirect buffer, -1 if not using */
+    int current_indirect_buf;
+
+    /* Whether indirect descriptors are enabled */
+    bool indirect_enabled;
+
     /* Next head to expose to the device */
     uint16_t shadow_avail_idx;
 
-- 
2.48.1


