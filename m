Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46235D59D99
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 07:57:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV3Sb-0006zN-Ph; Mon, 15 Dec 2025 02:57:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vV3Sa-0006zF-FJ
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:57:36 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vV3SX-0003jH-QT
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:57:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LFi2jguYiQifX7xe3F1j1rgn+f5aW8yXwMAdpRLQnXfJ4y8ZFEqmv1aia82cG+ZGGp/8bZf8swYl7XSQrwEZkXd2gCEgAIjx66X24NYh1mi6q6B0Dk8BO8QEWmDx7IU3038pBS1gA9M2LUc9iDbi99BONKzvty/r5g9jJGbPGh96hQW32/F9VXUbHT/ncHN5tm2Y0ghGUyAXgYM3QsSm6WmCvZT00kHFD9qcRRp2wBK+9T1I+ywI5RIV5uf3DMkEsJfC1Iclzj9PPuXIrzpvwjwwvgkTY5jDwwapeJU15KnLCjoFRP06VS+EPM/4BLO/JgW+vpyf5Gs9zm5+WbVFMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TH9K4oMnrsU4tCvsW0w1nRq+IT1Z1oO4Ed7GZp5oYw=;
 b=sFqom5wsz97PEQXyA5ir6nzJTO3uYQ3W3cOWwfBWkxoY9GTjuUidVUD19p9siI3AJN8/ECIpxj3wrXqYl08XrZgIdRZ+a318CtyY5PE+AMtlzxvyS5Ym0yY9U1BCITgnRdm6gw1PR0Lue2sXTrIj6QFVQnC1d7bd17edZGZkkeBlVrwPYJbIVG3YggcTxEHGBmT1Nl6CpT2ZOC2LaxOddLm14um4/JFktuowC+u0uX9xdQqbR5lVFprsN53XWIUMPQ5zso0i3CnKFEDpea3Ls2eqicig5stzGVrweVlpVJ62L8oV5TtWeqlR5x30/rA1miIyl/M9reLIanWz5z/xEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TH9K4oMnrsU4tCvsW0w1nRq+IT1Z1oO4Ed7GZp5oYw=;
 b=hWUmX7KXWp4D3Dj1GUMZ6pnLL7OzP3U4q14vImZkKDZ9pWn6hJ4hzW2b0nCAl/n5/FMAVWzYazgJheaKf/cIwlRFx0BdlScsLY7DOZmEFLVex53099Vy3mzPCvIZ4ISN5vTcAK9RprPfqPEGSMOcuqZ+ZDrwo603cgN6jJeePdPNPT8xBM++JckOc7ipakviZ8GMwDGm8ChSirQKLmIus6Ai9ojeEs6A5RgNqlG1aME3gDGLt13nLLmSNEN/3VfUPKfz8nPPKWa3BlxMMhnwx51hOM8CBDUttsw1VB7UnUppYg71tGM46b/OygWiK24ASF9UqwMzdDg3tKXe6W9xxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by SEYPR06MB6081.apcprd06.prod.outlook.com (2603:1096:101:d6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 07:57:28 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66%6]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 07:57:27 +0000
From: Wafer Xie <wafer@jaguarmicro.com>
To: mst@redhat.com, eperezma@redhat.com, jasowang@redhat.com,
 qemu-devel@nongnu.org
Cc: leiyang@redhat.com, sgarzare@redhat.com, angus.chen@jaguarmicro.com,
 wafer@jaguarmicro.com
Subject: [PATCH v2 2/4] vdpa: implement a statically allocated buffer for SVQ
Date: Mon, 15 Dec 2025 15:57:13 +0800
Message-Id: <20251215075713.2306-1-wafer@jaguarmicro.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0012.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::16) To PUZPR06MB4713.apcprd06.prod.outlook.com
 (2603:1096:301:b4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4713:EE_|SEYPR06MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: 301de4e0-d6a5-45be-b9e0-08de3baf9748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N+yJ8I6+KzbcXw6oO41gPSBk3ldxFtNYcqU/+JgLAmJLG2nZojU/RLTnK/u4?=
 =?us-ascii?Q?SUBKm1aFKUJLc3yJOsn4SDiSm3OEs/3gnud5DwfQ47klIWbr1JXYc9QCJDNw?=
 =?us-ascii?Q?zMkCHZfjp9SLPusMZTbeahm/tN6NZeM4jwIc45A1V9BqF1IjyhuZbPerBea/?=
 =?us-ascii?Q?iKJuBR8K3oLE0c09ZqPaYL+Zrz5MEQ6xpKsLCJvzkghlgBkPSLbPLFk7/bKR?=
 =?us-ascii?Q?QAf7g0QLbHJT4WT59zgImDIWKOxUoMcl40p6Ah0Vewp4xflKMYosFDyB5t5h?=
 =?us-ascii?Q?ZPopTuaK1EfNryxM3PBRY0rta5ncHB37AslEoZwbT42iOVo1dso3T24bPC0V?=
 =?us-ascii?Q?ZOHrMba78B1oNVG3ah0e1S9zGzeq33k0s8Nh5/Z90kYPVm7nXAPryIeKkzJ7?=
 =?us-ascii?Q?QVGzdZqHEfxr1qwCCYlxI5yURsd2dylEjiJ7hYB14JVaUoRGqc1Fdo/VPN4G?=
 =?us-ascii?Q?EFxFv0Jep3nxbQNLSFVnlc9cF09nass0ao8bSsOJsTlNIvBXUsuosmuZ/pTx?=
 =?us-ascii?Q?cDquFqb6mT1teUnHJUHPfbXAHEWSsKbNg7YwE9oRgG8QycmZ4/HJ9geExCKv?=
 =?us-ascii?Q?J4BPjIQxM5tbga/dFcQWZBhu77vpT0diwyLvHujVKn13mUoSBY0L+Cx76Hq8?=
 =?us-ascii?Q?099U+wepiaiMfFUttfXIIhxBDDF6VT8YLDpbFg7dTY2rIDdO4OO4Hixt9ZTe?=
 =?us-ascii?Q?rrTaF4KdgaEuqzw7wFfdLgY3Fk2jsg7MNGooud33gJGYcilawa9Qj2tQTHdC?=
 =?us-ascii?Q?8OPYMQ6xGUKkWnVpiixKZ+f7qG6SEOyzctdBkAWiw3uJ924iCpdG5R5QxhlY?=
 =?us-ascii?Q?07kPh2lQRbCox3Fo1zcqNf2Drqpcuo6PgQ46c7dxq+ffJrxM4omQN3zenunz?=
 =?us-ascii?Q?/x5hKaai5dtYr29rZmGUBLJqN0Enah2MNJHqP3oKEdaLIkVFxaGn0qQzDF51?=
 =?us-ascii?Q?jfU30FndRZEQq0z8Vl+OF5tC++xmeFYSgbi5VJCY9iCVqiWxw4KizlV7FjWw?=
 =?us-ascii?Q?CSNOycwTJkyuBE5OTKQ3XK0pyBibKFT8HfPnvMTAZvX3q9SUZa06IuMY6tWD?=
 =?us-ascii?Q?W+yzdreoQiK3smRThtx66NVwL+3X6cTQV6ZWl0NtDZLMMXx17R7BNLB6E6Uk?=
 =?us-ascii?Q?o0RBRZPRlWxKAXqdoiHPW/aFhLfiq7X43Q3pl79neykjDzGEGI6QsE7c47Xq?=
 =?us-ascii?Q?Q7Jh0IXSWpMyqKDC8UrpXAL+yRM9ttrYyYSZvM20s7lBCVISKbVpFMKj8tjQ?=
 =?us-ascii?Q?qYBRAIdEvBSZaggXbVPyOdnyaWJZltG2tB4nSqonYISxgjYposW/MfrajHYq?=
 =?us-ascii?Q?EHjiZkqN9cZfc7WS0oBkv3gx8rY3xneTSi/0Fr+tuKrPfFC+7BOLI2jONesB?=
 =?us-ascii?Q?5YOy0nTi7Wne1uI+AiqnsC8acORIOqnTQvReErQmyY/2viMfDO+xmvp+Wnz5?=
 =?us-ascii?Q?Ysp6uwLJhTOeO7sW5rggoll9KN5IwZEU+vutt4lH0GJ/3v/3sw/A36juF/q5?=
 =?us-ascii?Q?m2ukwfgK3WRqIpvvE4mwYgMOJk1xVEbUqVPn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8wwSfDBi4jleY0NTV1oAwbJhx0YtR+Bwg+kd9WtBaP46dWtz+MiUs5mc/sMY?=
 =?us-ascii?Q?Adfe4yVncqMGhR6gIfSvimhzrelhnbJU6h+6fOpamWGDSMf5x6+qnxlTMCCo?=
 =?us-ascii?Q?myyZmi3aFxNbEHobU7awixcBsKqTwftlsfbYblou2qBPY3GhREF/iQw/GscZ?=
 =?us-ascii?Q?B7iiw4wDoMhGhLwyZ4M7He81mMZZhL4AvJZA7IX+vYDRRDfH0XhMxwf9UWff?=
 =?us-ascii?Q?takCkqg6zqkNR4WfQWmrQyZMNBK1/8G1PQGgwcC7+GEsdk9cy2PRd+Pvd+Kl?=
 =?us-ascii?Q?E49fucSDxDxSWAFAd8aQtB8L5TjrC6Ar72xL/4IPS4ZTKt5ujeZnswA33YCZ?=
 =?us-ascii?Q?+M4w0Umy7/429xdqrf14OPsbcHbfOa15Y3TEgdrUVGvndpyotjoBUVdkWBAl?=
 =?us-ascii?Q?d9exUkXGjbhOhwPhd54bTCa/rYHLqMMLSwcPUXd67mJGt1GNJuI8yyQgzFdj?=
 =?us-ascii?Q?gxSTzRWrAHJBmCX4QT755/8c/GFOeyN/1BoGUfxM/MGFZ9tFUWNDko8O8eLN?=
 =?us-ascii?Q?3GGr97zU3IS8cjbepEhC92FtaCLIRbaya4EijnRmQy/xvyKB+6k9TgfgilDo?=
 =?us-ascii?Q?z3SCIqrzywPoAQ1pcz37zOkyNEZd5rpJ1SQpHdvWZSGUBXiEgxP3VY2Sq2CW?=
 =?us-ascii?Q?pIta8NhE9EtrDNf+vSI5/AyGl2Ot+X8PlFr8k7wyH65O3NlMyCxRz1DqGcgQ?=
 =?us-ascii?Q?VEGxZjHx74ULWF/gRt0cYw5kDEhsDl+bDAdJiDNwWAnsY3yk6LIpB9B2l8X3?=
 =?us-ascii?Q?7SzYU6jkxDg3Jt8+k6iuKqsleNCWcwggScGqhTUcOe78bsZBFvl6fwXeq0LB?=
 =?us-ascii?Q?2P/Ekn217wJD7mCeKRzGS4LyFHnyn8sNXeQcCS+JYpkhPhYLdECTX3Uhphm1?=
 =?us-ascii?Q?CWW31rusAX/8sH0Jv+ZTQgVJtOuaeIqitbbd7nKGqs2xTgUxt6k7HfVNYLK1?=
 =?us-ascii?Q?WDvxVMRkfcbwNnDLtvW9CnbYu2bdgoGLu9UOnbBFKJ3p1D8uqoT4rVGUH+YI?=
 =?us-ascii?Q?YJHKDw/uwfKc98RQqsKPJZVO/bD1GGfwz9nUZgj3nHTTnoEsPCAiJ+H07Cmm?=
 =?us-ascii?Q?Ax+lUsyYwXL6IpqP7IC+U8p+zz/AJi8lk4Weir/pCsIpNV1AqBRvHP5wvTD2?=
 =?us-ascii?Q?VSn4wlAGifrkVn3b24H+cvE4jnURCQjtr2pkgpkmixjEgZ5miwAzKKUWF0c+?=
 =?us-ascii?Q?/gDj8j0LXFxoVJfvsk/kfAfYVMmd3V/rti1aZ0cmMNLl9nXvbXQcqfxk5Ei3?=
 =?us-ascii?Q?TU9E38EuLAqx18O1X/aw9cctk0kir0D6sR9bKiG3jXU0NXgAbT4EhyJXMwFu?=
 =?us-ascii?Q?2zmx93DWla87R83cQuuLed1wmEv89qrgEANYB7lFdl/0PLDHe9txdCsWVncF?=
 =?us-ascii?Q?ut6ln6wQTw0fIp5Hc5DuhsP15+eHl8xW0PH2uzcHgI0LSwVcfz9TqHHZU32R?=
 =?us-ascii?Q?nhKa4+kmzoh5CabBdvZrMirT531RY95fL2ZNVG0faLc9KFEPF2fV6c7/xeMz?=
 =?us-ascii?Q?I3Xx9bjoBtI4V83gJ5X6WSLomb3cLoU7u+9jFIrElDvYqjpkLN8e6pe5ZRoK?=
 =?us-ascii?Q?y2G2IJF7EWChT3QDkeF9Aark7RJNBw17FiYv53UM?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 301de4e0-d6a5-45be-b9e0-08de3baf9748
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 07:57:27.9060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YM57bh5n4mJW+xRpSib7fNhClXIkFnwgPMAjpDI9UIZnF4hzPSTK0Opn2FrsbgiYftqoqGJflfhJjyOPXMnH8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6081
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=wafer@jaguarmicro.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

allocated and initialized when creating the vhost-vdpa device,
and release the indirect buffer when vhost-vdpa is stopped.

Signed-off-by: wafer Xie <wafer@jaguarmicro.com>
---
 hw/virtio/vhost-shadow-virtqueue.c |  25 +++++
 hw/virtio/vhost-vdpa.c             | 163 ++++++++++++++++++++++++++++-
 2 files changed, 187 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 2481d49345..85eff1d841 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -708,6 +708,25 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
     for (unsigned i = 0; i < svq->vring.num - 1; i++) {
         svq->desc_next[i] = i + 1;
     }
+
+    /* Initialize indirect descriptor state */
+    svq->indirect_enabled = false;
+    svq->current_indirect_buf = -1;
+    for (int i = 0; i < SVQ_NUM_INDIRECT_BUFS; i++) {
+        svq->indirect_bufs[i].desc = NULL;
+        svq->indirect_bufs[i].iova = 0;
+        svq->indirect_bufs[i].size = 0;
+        svq->indirect_bufs[i].state = SVQ_INDIRECT_BUF_FREED;
+        svq->indirect_bufs[i].num_descs = 0;
+        svq->indirect_bufs[i].freed_descs = 0;
+        svq->indirect_bufs[i].freeing_descs = 0;
+        svq->indirect_bufs[i].freed_head = 0;
+    }
+
+    /* Initialize desc_state indirect_buf_idx to -1 */
+    for (unsigned i = 0; i < svq->vring.num; i++) {
+        svq->desc_state[i].indirect_buf_idx = -1;
+    }
 }
 
 /**
@@ -748,6 +767,10 @@ void vhost_svq_stop(VhostShadowVirtqueue *svq)
     munmap(svq->vring.desc, vhost_svq_driver_area_size(svq));
     munmap(svq->vring.used, vhost_svq_device_area_size(svq));
     event_notifier_set_handler(&svq->hdev_call, NULL);
+
+    /* Reset indirect descriptor state (memory is freed by vhost-vdpa) */
+    svq->indirect_enabled = false;
+    svq->current_indirect_buf = -1;
 }
 
 /**
@@ -765,6 +788,8 @@ VhostShadowVirtqueue *vhost_svq_new(const VhostShadowVirtqueueOps *ops,
     event_notifier_init_fd(&svq->svq_kick, VHOST_FILE_UNBIND);
     svq->ops = ops;
     svq->ops_opaque = ops_opaque;
+    svq->indirect_enabled = false;
+    svq->current_indirect_buf = -1;
     return svq;
 }
 
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 7061b6e1a3..816868d153 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -584,6 +584,155 @@ static int vhost_vdpa_get_dev_features(struct vhost_dev *dev,
     return ret;
 }
 
+/**
+ * Allocate a single indirect descriptor buffer for SVQ
+ *
+ * @v: vhost_vdpa instance
+ * @num_descs: Number of descriptors (should be vring.num)
+ * @buf: Output buffer structure to fill
+ *
+ * Returns true on success, false on failure.
+ */
+static bool vhost_vdpa_alloc_indirect_buf(struct vhost_vdpa *v,
+                                           uint16_t num_descs,
+                                           SVQIndirectDescBuf *buf)
+{
+    size_t desc_size = sizeof(vring_desc_t) * num_descs;
+    size_t alloc_size = ROUND_UP(desc_size, qemu_real_host_page_size());
+    DMAMap needle = {
+        .size = alloc_size - 1,
+        .perm = IOMMU_RO,
+    };
+    vring_desc_t *indirect_desc;
+    int r;
+
+    /* Allocate memory for indirect descriptors */
+    indirect_desc = mmap(NULL, alloc_size, PROT_READ | PROT_WRITE,
+                         MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+    if (indirect_desc == MAP_FAILED) {
+        error_report("Cannot allocate indirect descriptor buffer");
+        return false;
+    }
+
+    /* Allocate IOVA for the indirect descriptor buffer */
+    r = vhost_iova_tree_map_alloc(v->shared->iova_tree, &needle,
+                                  (hwaddr)(uintptr_t)indirect_desc);
+    if (unlikely(r != IOVA_OK)) {
+        error_report("Cannot allocate iova for indirect descriptors (%d)", r);
+        munmap(indirect_desc, alloc_size);
+        return false;
+    }
+
+    /* Map to device */
+    r = vhost_vdpa_dma_map(v->shared, v->address_space_id, needle.iova,
+                           alloc_size, indirect_desc, true);
+    if (unlikely(r != 0)) {
+        error_report("Cannot map indirect descriptors to device: %s (%d)",
+                     g_strerror(-r), -r);
+        vhost_iova_tree_remove(v->shared->iova_tree, needle);
+        munmap(indirect_desc, alloc_size);
+        return false;
+    }
+
+    buf->desc = indirect_desc;
+    buf->iova = needle.iova;
+    buf->size = alloc_size;
+    buf->state = SVQ_INDIRECT_BUF_FREED;
+    buf->num_descs = num_descs;
+    buf->freed_descs = num_descs;  /* All descriptors are free initially */
+    buf->freeing_descs = 0;
+    buf->freed_head = 0;
+
+    return true;
+}
+
+/**
+ * Free a single indirect descriptor buffer
+ *
+ * @v: vhost_vdpa instance
+ * @buf: Buffer to free
+ */
+static void vhost_vdpa_free_indirect_buf(struct vhost_vdpa *v,
+                                          SVQIndirectDescBuf *buf)
+{
+    DMAMap needle;
+    const DMAMap *result;
+    int r;
+
+    if (!buf->desc) {
+        return;
+    }
+
+    needle = (DMAMap) {
+        .translated_addr = (uint64_t)(uintptr_t)buf->desc,
+    };
+    result = vhost_iova_tree_find_iova(v->shared->iova_tree, &needle);
+
+    if (result) {
+        r = vhost_vdpa_dma_unmap(v->shared, v->address_space_id,
+                                 result->iova, buf->size);
+        if (unlikely(r != 0)) {
+            error_report("Cannot unmap indirect descriptors: %s (%d)",
+                         g_strerror(-r), -r);
+        }
+
+        vhost_iova_tree_remove(v->shared->iova_tree, *result);
+    }
+
+    munmap(buf->desc, buf->size);
+    buf->desc = NULL;
+    buf->iova = 0;
+    buf->size = 0;
+}
+
+/**
+ * Initialize indirect descriptor buffers for a single SVQ
+ *
+ * @v: vhost_vdpa instance
+ * @svq: Shadow virtqueue to initialize
+ *
+ * Returns true on success, false on failure.
+ */
+static bool vhost_vdpa_svq_init_indirect(struct vhost_vdpa *v,
+                                          VhostShadowVirtqueue *svq)
+{
+    if (!svq->vring.num) {
+        return true;
+    }
+
+    /* Allocate indirect descriptor buffers for this SVQ */
+    for (int j = 0; j < SVQ_NUM_INDIRECT_BUFS; j++) {
+        if (!vhost_vdpa_alloc_indirect_buf(v, svq->vring.num * 4,
+                                           &svq->indirect_bufs[j])) {
+            /* Cleanup already allocated buffers */
+            for (int k = 0; k < j; k++) {
+                vhost_vdpa_free_indirect_buf(v, &svq->indirect_bufs[k]);
+            }
+            return false;
+        }
+    }
+
+    svq->indirect_enabled = true;
+    svq->current_indirect_buf = 0;
+    return true;
+}
+
+/**
+ * Cleanup indirect descriptor buffers for a single SVQ
+ *
+ * @v: vhost_vdpa instance
+ * @svq: Shadow virtqueue to cleanup
+ */
+static void vhost_vdpa_svq_cleanup_indirect(struct vhost_vdpa *v,
+                                             VhostShadowVirtqueue *svq)
+{
+    for (int j = 0; j < SVQ_NUM_INDIRECT_BUFS; j++) {
+        vhost_vdpa_free_indirect_buf(v, &svq->indirect_bufs[j]);
+    }
+    svq->indirect_enabled = false;
+    svq->current_indirect_buf = -1;
+}
+
 static void vhost_vdpa_init_svq(struct vhost_dev *hdev, struct vhost_vdpa *v)
 {
     g_autoptr(GPtrArray) shadow_vqs = NULL;
@@ -791,8 +940,11 @@ static void vhost_vdpa_svq_cleanup(struct vhost_dev *dev)
     size_t idx;
 
     for (idx = 0; idx < v->shadow_vqs->len; ++idx) {
-        vhost_svq_stop(g_ptr_array_index(v->shadow_vqs, idx));
+        VhostShadowVirtqueue *svq = g_ptr_array_index(v->shadow_vqs, idx);
+        vhost_vdpa_svq_cleanup_indirect(v, svq);
+        vhost_svq_stop(svq);
     }
+
     g_ptr_array_free(v->shadow_vqs, true);
 }
 
@@ -1299,6 +1451,13 @@ static bool vhost_vdpa_svqs_start(struct vhost_dev *dev)
             error_setg_errno(&err, -r, "Cannot set device address");
             goto err_set_addr;
         }
+
+        /* Initialize indirect descriptor buffers for this SVQ */
+        if (!vhost_vdpa_svq_init_indirect(v, svq)) {
+            /* Non-fatal: will fallback to chain mode */
+            warn_report("Cannot initialize indirect descriptor for SVQ %u",
+                virtio_get_queue_index(vq));
+        }
     }
 
     return true;
@@ -1313,6 +1472,7 @@ err:
     error_reportf_err(err, "Cannot setup SVQ %u: ", i);
     for (unsigned j = 0; j < i; ++j) {
         VhostShadowVirtqueue *svq = g_ptr_array_index(v->shadow_vqs, j);
+        vhost_vdpa_svq_cleanup_indirect(v, svq);
         vhost_vdpa_svq_unmap_rings(dev, svq);
         vhost_svq_stop(svq);
     }
@@ -1331,6 +1491,7 @@ static void vhost_vdpa_svqs_stop(struct vhost_dev *dev)
     for (unsigned i = 0; i < v->shadow_vqs->len; ++i) {
         VhostShadowVirtqueue *svq = g_ptr_array_index(v->shadow_vqs, i);
 
+        vhost_vdpa_svq_cleanup_indirect(v, svq);
         vhost_svq_stop(svq);
         vhost_vdpa_svq_unmap_rings(dev, svq);
 
-- 
2.48.1


