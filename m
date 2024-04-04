Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8335FCD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 17:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsQUG-0004KF-8V; Thu, 04 Apr 2024 13:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1rsQUC-0004JY-Su
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 13:02:49 -0400
Received: from mail-tyzapc01on2117.outbound.protection.outlook.com
 ([40.107.117.117] helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1rsQU6-0000eN-8U
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 13:02:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNKoniCAVus1jTG/qsw1fAGQfv3BX0VvntJc65IgFi1y4Nm7lGeMbY4KxH/Gwe/+yfDqeaWBLjry2UfQWzjtr3c48FWgsokFkaTqcC9CNz5rbBf0MQdBEZAiDARsjJq1Sq/EBcky1GzeePT3rShHP9ZuZuuairx9T6iXrG0hQye2XYxM0enROSYVqoUVNaujhe5wHzvG+nLyf2MIqC09sf+EMziCr6G036TjYFszpaSV6lh21dRZCu+FIkcZCjJj32v0ITxARry/s+eJ8Xczo6kKpVj/fbD1Ea6NEUT0xdEjHEt4ug1knozhIhW7/0Wkg94SlfdUTo+l4NmGPGjRuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwDzHiCDBH2brPtN142TsURvVfW3NodchY7UKIQDcD0=;
 b=fxQck9xCNJ7xnbn/wCkLc9sxjOI9rMEbgM+B6dY2XMucBxtFm8Wn9gsYJ57XaRkDGc0BF0aj3Qe81jlcAjWKO3YOIMOhP//r9bNL+ss1qOGVY/Xm51h+r5+DcM349EydC9w4dY89kDRolPGvDYLrD0m1oVW1FIow1cniUMoiZLbofdA6v3vRoQVB9bTBiCgjcSylU/kDLZb4clbViqm3zE4UnUP2T5NAzLpsm8hsBtaS5+xgTQZvp2Xi6AP2HE7++UGVxzEfQLPFcL24+MQBjuQEgR6s1sHaqEyNb5dHHPqsMxIyH0fnz8FeGHrYZ0L7N1P1ziGgj4eVtxdbU1v9oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwDzHiCDBH2brPtN142TsURvVfW3NodchY7UKIQDcD0=;
 b=clWh3XsFXN2nt1KzvZkVZxiOGAmbr79cTy6cB99kf2zJa7ZnvSwS7K9R215jzhmS6STZpgP6FOOK7/SQhY+fXGX4uHkvbHlj5Sm5HJ5WygzDNGOGVugUSoEbCUdNwtpTrYagq0mzrmWbo5YMGJJvYjEHnhmLm9Vf/wlKGpx7iCNYN6FqNmBo3a7kwSK31pC+3AWNQcQsQo1FD5IzsxtQKIiiitBV3vuD0tytdks7YeYFPX9Ov5ch59I6sogUhonQLiUG9CftyRgGkCfLytwNKNgDe4qyIUXPw/6I+KiDOECdfeNpbw85XnBst9MOkC4CSKj79gZRynGATszlCP+oCg==
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by TYZPR06MB6325.apcprd06.prod.outlook.com (2603:1096:400:419::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 16:57:31 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::807:eccb:cfd5:e6b5]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::807:eccb:cfd5:e6b5%3]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 16:57:30 +0000
From: Wafer <wafer@jaguarmicro.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: qemu-devel@nongnu.org, angus.chen@jaguarmicro.com,
 Wafer <wafer@jaguarmicro.com>
Subject: [PATCH v2] hw/virtio: Fix packed virtqueue flush used_idx
Date: Fri,  5 Apr 2024 00:57:06 +0800
Message-Id: <20240404165706.23338-2-wafer@jaguarmicro.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:195::21) To PUZPR06MB4713.apcprd06.prod.outlook.com
 (2603:1096:301:b4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4713:EE_|TYZPR06MB6325:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NMyfZUqvqz+hCkz0f6Fd9HRz9XFnNN34OKOZ9rEIerDenOeAjp6F0YILVdUwAGqV5SIrpg8pP8wpfVujkKMKbTig5U+MSKOwcvsFyRyKFJw0uXiBQgXJoWODpF+u9EJZxJ3IHM0Hyk4bkYcdGIxOyQZXT6y6MmrrHpycAFd6sb46U2kQu19QQxp/xV0x2vr1IH4LSDDa1jdLI4QCpSQEAlA2JA823huEY3syfiqd8WCWwvOcGZDUYuTVwCEY1ECn3zEQwF15zvWI2O13DTgy0xlvH+cZsktxaEPuy2orq8lUqY4NAGc1fNaE02aDqsaa1CAXVGSh74oKH5MZo9NhyLnuh3Y6Wsk+ZfSluMor4Fgz/36mjPIcoupFKFX9TfBVtzV/3ck8CEdFyLSt7RmgIuPgMQWeACLCShygxrIJGiCwyY2POik9M7Fkd3BO3nvLSXgXkIFigCsQ6/A023Edj3LRKa9g3Uf6kVKYFY50YWrLoyttS05nAdiHgnd1PdAR5rnaFtzM++X6DzSfb7sACxgUySSZaXNMBG+gVf2RnRkneu3rTJ2quAC9GPt+El3+2FL//m+c1F88w8rIOAr6ZZm1AY90jzdL/IVUHjT0twNI9qfeA5GmyFXx6NIjCXXKqhC26fVeJnquD2AOnEYQJNa+GizkvbJ9rMCuoOXff3cFI/nvW2Vk+dRImXy6H2HeRenT7308w6I69fKh7SLgSmYvG8dsgzlJYSV63nraSf4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(366007)(376005)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uCEpaxEDKTz0739v/mciqejdS42OAp/Z0jmEqmVRmDA3kRcZsfYlkqBq2or3?=
 =?us-ascii?Q?UuIuP2Ahum1vc/UikVFZMek1GAw2IJGqorIo3/yqckcXfPeOcBZMhfa6Sj0r?=
 =?us-ascii?Q?DH41qnBRAsf2TFdq2QF8ynvPqxfxv+FkDAC37jcptE5qr96I3iEmhgwY1aPK?=
 =?us-ascii?Q?czmXORVS1uD3oTklioa3IbJG9m8VD3s/4yUCNAJ0d6BZm4QG7VWRqHmvvq15?=
 =?us-ascii?Q?i7FrCAnnSrjL1bCOMKTPdARxy75juJ0cOGZ7NOwnaRlrNGDwTJAe2UXNgvMp?=
 =?us-ascii?Q?VFXry+Lw7Whc+d72L6QivJocN1IHv8yL70XwbxRFIzH/J7IORwJVyvZlDW4T?=
 =?us-ascii?Q?q3KwMxXB7qPJC2jvSJACW7lQjRLMsgZa1dAP4jNlGNWa+tGND6F5SUfqlRaw?=
 =?us-ascii?Q?MdunrdvbGP6wzMvugQ4uqkLcrlPmkhRxMgOKAiuTwtr3QL1FbnwbqaBOVUmq?=
 =?us-ascii?Q?c8ck5MsX4tLS+yAKPQCAAyd6x4/+HIsyu3XriO0qtjDAi6J6hQh2FwakQXX+?=
 =?us-ascii?Q?NPJE4ye64717DGs8TnL78l/rRonOckrqTkeSKckfnEcZkYwvPC+6agZ8USC1?=
 =?us-ascii?Q?kgMw3cGGOyBZKgfjvqtJ0ifZaPJEklVpm/8BJI+5i2pm3I0SzfeX4C4RicYQ?=
 =?us-ascii?Q?03hqmyA0PQH5h24egkOmjWSTEx9k7DNvp0WRc7TtX8IPydE3pc+1wE4n/W5R?=
 =?us-ascii?Q?b3WZCyOSd4JvkDRIQL5LZQEjCgN7sVhcOAS06RXdLBTbt887I6eGq3aR3Jb1?=
 =?us-ascii?Q?/QnD7CN1GbVxBpMHqv5YLHNqR+PmIE5Sbv6BgpUL8tloWZWK7ZX+9SLPEMeb?=
 =?us-ascii?Q?uMahPjuX661b/ndpvFLK8k8Ot0I8vznLmfQ0vU5fW8EJRNJxrmzSKrJL/29h?=
 =?us-ascii?Q?9BvStNyLBxXLgyZd5awqyZnYqN6hfCMLFEsX5tCnLrnGUfzndG9U7yB8wIiD?=
 =?us-ascii?Q?XYDPhx42nj7Gd64FHtqexP5Fb+0eBU9lpk2bILB6Zw41Sczn2qc4To/XxaCZ?=
 =?us-ascii?Q?659B2mjlYZ4Z1dqKxlSvItDBzWiooFoWFBBXvEP3b+U3jlxCZ5rj5x3ktbk3?=
 =?us-ascii?Q?OwMeDWh2rE4KwEkBkbwM5I7R4fuV1Vi+n2xI1lkll1u0/GBIEmWEBUli5s19?=
 =?us-ascii?Q?xpOn38YXMy5gQ1h0f4lWVu3/KBoBBia5injpvCLpVIhlJJzUmbvVoOh0RNBg?=
 =?us-ascii?Q?3v5BdgpNhMe4R9WyvnZCip8bI08v9zSwqighTk5MImR+q6Vc/aUWOAR/X3xI?=
 =?us-ascii?Q?xGak1LK03f/0Z8G+7tQQXzVeKPw2lEO3PgLwxea3542nGgV5HY6l1hUPG+GW?=
 =?us-ascii?Q?uQjZFluB24BXZEoycsbWCf+uRBg0D6spLrD00VB6xMUF84VwnXxTNYF/aRri?=
 =?us-ascii?Q?r+JrDAYMK6u0HQ07H4N0F3hdQl6KgxKCsCljpcMvci5zKaQ74NiRdspE4qXK?=
 =?us-ascii?Q?VnXFMPaFbLuTNoTqEq+AFw72ly088FaP3Z9g2a5PTW0iD4IlxGpx3FO3X4w2?=
 =?us-ascii?Q?ceAN5+FPMm+Uk/yo72uaxC4rffOtHPqjtykUkn/mKqO+doMHl+J7Bacy4Cd5?=
 =?us-ascii?Q?SDLp1PkqoztK0w1YO3Lt+VLTgULcdl/1l6mvHggvdX5229A1J7DwsgV/CMC2?=
 =?us-ascii?Q?nA=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6db98aa-b195-49da-e894-08dc54c850e3
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 16:57:30.8717 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cdowz/GDuag9dd9FswODtH5iwj72gaTihDWlQ86pUvH2aDfL2iV12DTRINQO/7s/UlJglmZcMjHMvSTTJ87eMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6325
Received-SPF: pass client-ip=40.107.117.117;
 envelope-from=wafer@jaguarmicro.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

If a virtio-net device has the VIRTIO_NET_F_MRG_RXBUF feature
but not the VIRTIO_RING_F_INDIRECT_DESC feature,
'VirtIONetQueue->rx_vq' will use the merge feature
to store data in multiple 'elems'.
The 'num_buffers' in the virtio header indicates how many elements are merged.
If the value of 'num_buffers' is greater than 1,
all the merged elements will be filled into the descriptor ring.
The 'idx' of the elements should be the value of 'vq->used_idx' plus 'ndescs'.

Signed-off-by: Wafer <wafer@jaguarmicro.com>

---
Changes in v2:
  - Clarify more in commit message;
---
 hw/virtio/virtio.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index fb6b4ccd83..cab5832cac 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -957,12 +957,20 @@ static void virtqueue_packed_flush(VirtQueue *vq, unsigned int count)
         return;
     }
 
+    /*
+     * For indirect element's 'ndescs' is 1.
+     * For all other elemment's 'ndescs' is the
+     * number of descriptors chained by NEXT (as set in virtqueue_packed_pop).
+     * So When the 'elem' be filled into the descriptor ring,
+     * The 'idx' of this 'elem' shall be
+     * the value of 'vq->used_idx' plus the 'ndescs'.
+     */
+    ndescs += vq->used_elems[0].ndescs;
     for (i = 1; i < count; i++) {
-        virtqueue_packed_fill_desc(vq, &vq->used_elems[i], i, false);
+        virtqueue_packed_fill_desc(vq, &vq->used_elems[i], ndescs, false);
         ndescs += vq->used_elems[i].ndescs;
     }
     virtqueue_packed_fill_desc(vq, &vq->used_elems[0], 0, true);
-    ndescs += vq->used_elems[0].ndescs;
 
     vq->inuse -= ndescs;
     vq->used_idx += ndescs;
-- 
2.27.0


