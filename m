Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9469ECD1292
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 02:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rteJE-00072B-7w; Sun, 07 Apr 2024 22:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gavin.liu@jaguarmicro.com>)
 id 1rteJA-00071a-Vk; Sun, 07 Apr 2024 22:00:29 -0400
Received: from mail-psaapc01on2072f.outbound.protection.outlook.com
 ([2a01:111:f400:feae::72f]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gavin.liu@jaguarmicro.com>)
 id 1rteJ8-0003ev-Bj; Sun, 07 Apr 2024 22:00:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBaSsY0A6pbX3DCCN1/rN+UEC7+aDutGz5D76mt8Wc5w2kGj03YKzV3TQuLvDd8q4Nne/5Ocek6p104NdGgKCnU9xUOIu9E4za8jw0SjuXQdaOWPn40EXR04QUMTq6jV1ZRd5ZUl71Sg8pfDzIt4NMXRG8a/Lx1tlT1U8Q1vbHgfCE/su6f9nlumJsB5sIyP1KhBBqUVtkOrLPIj6Aj9LkRgbvgoxInfvK9uzaa4xrG7ylWVilXZIycG+RnKLHvLU3SG/QkwlPXvaQg1JzJkzvFdVYzFZySydqqQXK6hLKDg5UMlGfbyfsYMMdqNLqN9/LPoLCb7RArgja0+LlhNOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJLBINvVEnRwBItmF+XaRySy8ZzAEQAkCMGJ92kkQ9s=;
 b=aoMRSRf39zM3ddRcBdUZOuoBhBlouJPGvAaLjrJ9ZnCleoZ10u1q0SjASw/7s8EleUrWJOcZFZ4JyRD/qA3YwrY1C5/ItqFg9UY30IA70JY4E11dcPl0MB0NNhNa/Y7YytNbDyDdlCw9H3l5urek1kfa9/ZUq6NEP5uSW/Js7X1pixKtggbB0Oc/P0rSSvOkWR5NM9nFK9hJ7TBI6AbluQvr+hnOIbT1Vha5BG4sPDNX7+cZxXV9qiuHan06DEUG/UE89mH7U82wL3UCAhS7j9LkKtiZg0/puPKFu/YjYmoeQYVQamAraR3yqa8VCQx54B6tSUj2d9Uk5Ch3hoY9Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJLBINvVEnRwBItmF+XaRySy8ZzAEQAkCMGJ92kkQ9s=;
 b=VFz73+NhssefSuZ+pSCT/95R8wAbIQRqpMdrb4bP4HwgPupr+NY3Kom18vGLLUh/pPxA0ARFw/BbYRAVw1okbiPD+2zK+RoeniyMJb7Gjm6IcrXVMZgLqFvPPLMBhu+HmOpQdlESQ/qd7/Iwrow5qtZf9/XegyeUYBEd3PiZncqkdz43Yo7Ixp6Whh/b+o4Sqc+vZSTRiSmnjOUWf/Scmbj5F7XKjckNWm6Diq+/xF90Lj+GwFeI1p/fFH40poy5uZUd7vkCWgM5a4s3UKYrMOfAxlCjc5eo3fOGCsbugxEV45GlJjhojLxBbTfiRPlrYCOyGUQ5aXu/CdIXXQPVEQ==
Received: from SEYPR06MB6756.apcprd06.prod.outlook.com (2603:1096:101:165::11)
 by SEYPR06MB6613.apcprd06.prod.outlook.com (2603:1096:101:169::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 02:00:17 +0000
Received: from SEYPR06MB6756.apcprd06.prod.outlook.com
 ([fe80::922f:a649:adbf:6634]) by SEYPR06MB6756.apcprd06.prod.outlook.com
 ([fe80::922f:a649:adbf:6634%6]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 02:00:17 +0000
From: lyx634449800 <yuxue.liu@jaguarmicro.com>
To: jasowang@redhat.com, eperezma@redhat.com, mst@redhat.com,
 sgarzare@redhat.com
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 yuxue.liu@jaguarmicro.com
Subject: [PATCH v2] vdpa-dev: Fix the issue of device status not updating when
 configuration interruption is triggered
Date: Mon,  8 Apr 2024 10:00:03 +0800
Message-Id: <20240408020003.1979-1-yuxue.liu@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <CACGkMEs6FE7iZJAspCacWs+v4XTs9GsTHNdDVtcqoNfdDF_+3Q@mail.gmail.com>
References: <CACGkMEs6FE7iZJAspCacWs+v4XTs9GsTHNdDVtcqoNfdDF_+3Q@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:4:186::8) To SEYPR06MB6756.apcprd06.prod.outlook.com
 (2603:1096:101:165::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB6756:EE_|SEYPR06MB6613:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tZpEzjPuVMevqTI/YHcvQ2DPSX2ZoESSpKxlomQCzJ9wqQ7WeC8PV56d5rGlgTXRZUJOeNullMZtvkOcS1KLTmO8TGdnKt/ekHS75ij9zOIZqBU56UOiCtwhHOM+F+ttq78D/tQJUIKiuGNIKaCV1KBMZRHG2uRsQPmldKxBYYagdbXgKeX/0MA/cdpHcHeL6Yc/RQbpm2P3HEQfBubxyQvRQ1KYdg7dSIoifgl/yk2DjOHecugK7h9nmPFDv6g0jJoxw+J2mNiRsZsU64McIKh6SoPdX94qbhldlyp/htidqcbBMMC9ysW+Jm3sX8eUeJeF9muF8PtQOHKysBvPz4udaAOrHE/CUd/tShGn5HUrqu7crkZzm3UGow1xqkxccFbaVy9+JFAUOv5O7YX/5KSF3qwZLb0fqcfzssTYyw77c/hh62FRmaGDh8RbcKeQFMae/R7G6jE0zhssy9rdQonUlwmEPQU9j957cR3TcFl9/wTqVRo0Hu5xPxiSL4hM54gzdxB/qB4T+fHUMXPw08sa9WzVTzgZd3jEn6+OhSkGuNbD7PEnyeYu3v1S6vBmDyAO+CagJ7k0bMR3akrISkEW2pDVcQezqeHkZnWmQ84iEiTxR7Cz0cBOUvn56jz2UO68myWiOm1tpzIUNNoxpwYqYc5aWinWVxB3CMb0JJOAhhpwyeBCHF1C62SX+8EYJ0tJZN5LEFB5xd3YGaHoesTflWULro1r8pnSqCuCFLcHzXOTaly/67IU030SaHU7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEYPR06MB6756.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(52116005)(366007)(38350700005)(43062008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cKZ9z9Q4Gks5hgtUmOpPyJr1Vreob6JzOzhC5W0zIt8GgYOGK4264bkkVyxS?=
 =?us-ascii?Q?zpIbT5CWUFeziYmhnHcpzhb/9DMDezKp9fOrop7hA0gRL6HcHE+rwCF9+TS4?=
 =?us-ascii?Q?BcrxznjuifeOLSB+OWE2jYataMfDaTVFoVdrfv6sSjGfSgw0PbIKCpJk9zoG?=
 =?us-ascii?Q?iMaEaWj6Tc8yfHMLgYLl3biphLa/gIFcUrm6o+OzjjTmNi+wAO5MFVbQDPY3?=
 =?us-ascii?Q?5Epo0MCbm2gsmYk5is3gsx+UkXhKfFFxeZ0/l+9f5MvltkxBrCWysC48z6Ie?=
 =?us-ascii?Q?gsOFz+mHwhMmcKoKdFTLivntBEYt+PCdBrsVrw4rJ8b+kUQSWASA98FXUr7o?=
 =?us-ascii?Q?TawrwQ1qVIwSS7ZTPI5WU7kW+zpKQbjA3PCQoSM6dDP8olFEEkYZolB0Mzs2?=
 =?us-ascii?Q?0FlXQlA58jIr1fjSMjIcCYPdUTHj4gJ5qtjtlpF3Bv8Ymo4cqBMuHQaAVajy?=
 =?us-ascii?Q?eRFKXIoJhR8Micc+DAYHVGFvfuW+rf6NuDxy29v4hL35DsLNJIsz8y1wvfzs?=
 =?us-ascii?Q?wo3sAkOdM/8U0CsSOo+7bqIz4bs+o7Xa4Lupihcrhsp1tJzs170YYa2L2GsH?=
 =?us-ascii?Q?47rR6j0jcfbjEL0Zu1554XHyjVJHPT/tjvJL7alkBqZWYQSzpuWClooXgwTi?=
 =?us-ascii?Q?SprjYvImLcxizdFDp+90s/y3fAF+KdSVxkO8MnVuBYshWiMno0xLHuL6Gweq?=
 =?us-ascii?Q?HJpFUebYth4dqot+VxFSqB4KlVDIqc64vcxvQwlyzdCnX8w40KrDWSySx91B?=
 =?us-ascii?Q?VOKH8pShpuZobr7NpRjLp+7RL9PAELgt1n8BpD48gpNfMotAeQSlYi8zRhYq?=
 =?us-ascii?Q?r/OPnBNQuKR8akITKYnM61AViZg+3Jer9HToAwP8GrfGCaaIL/y/9i33PIKc?=
 =?us-ascii?Q?gqFNJovvq5WZ4pOjD3rDyOdCI2UZmhV+eGyVLidAjNa3zlk1GsW69Hp9eg5t?=
 =?us-ascii?Q?LHgPsgyoFDQM4rN79PIWJsaM+MShP9JbN1aUD/i60Wn2a+TAQcNc6BgaiEmT?=
 =?us-ascii?Q?WSeTFeqpTMcbUbkArosr03Mq8Yneo8EQO1fVplzWX664xthjhk3svEAT+DQh?=
 =?us-ascii?Q?8eRyMcoTJsMbC7ZsESGJqc60bSUxquapGX5OEiCJ2gDb/2o3MK9UN9LDW5iy?=
 =?us-ascii?Q?YmuVvDgB/H18rsEcvkk3tUfJFpfIGEw/4/6PapJd55yW1eDtc8WZefyhZcbo?=
 =?us-ascii?Q?q1dCvTpDKfWYRd6C5k6T2s9+SXYVlCkEhXLa9r5G59nz0DHIxRRR8P8y5oyC?=
 =?us-ascii?Q?relGsQBGOogdukgeOFtUG5Bw0p9A0FV3KHsRU46dCkoUkHSVk7n/VwOGOPr8?=
 =?us-ascii?Q?Cl2QZoTw32KGVGUn587ZEhVPj/DHe4koMRKTCPskR/zyWFBmz8l1XBoqf7KD?=
 =?us-ascii?Q?PqewT2XM0Cb4RjPd7SrvHHPJyK8d9Yf3zrwH/O+CwnJUHLFZSlNr9vlb2BHx?=
 =?us-ascii?Q?CRtq4ud5ldb5Tn6AcCMGHKa6GSHlVn6JURhIe9BzUJ2RjzFdHNgImF3vz3g6?=
 =?us-ascii?Q?munffu6DoY0fiectyXMwbrAjQI3XpONESvcp55btSh3bAZsHtQ+JVSM59lso?=
 =?us-ascii?Q?0ZC97NvS1sVZnIK20Z5y4Xj082CrOgO8huKldvPCZ7gV9bbgv2/vjz8d/aPS?=
 =?us-ascii?Q?iQ=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e49ed7fd-4ad3-49fa-8eff-08dc576fa31f
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6756.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 02:00:17.2078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LVLIdY6Jv4ROsEc9aAhM2PP/5W8ZCLC60p/Q6pSyucZ7Vq3qnbuYdATeL6mRKLd01sEKvBbXIKxTXcXgD03FPbW3cOO9LGVOTJSXTjvlzsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6613
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

The set_config callback function vhost_vdpa_device_get_config in
vdpa-dev does not fetch the current device status from the hardware
device, causing the guest os to not receive the latest device status
information.

The hardware updates the config status of the vdpa device and then
notifies the os. The guest os receives an interrupt notification,
triggering a get_config access in the kernel, which then enters qemu
internally. Ultimately, the vhost_vdpa_device_get_config function of
vdpa-dev is called

One scenario encountered is when the device needs to bring down the
vdpa net device. After modifying the status field of virtio_net_config
in the hardware, it sends an interrupt notification. However, the guest
os always receives the STATUS field as VIRTIO_NET_S_LINK_UP.

Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
V2: Amending the capitalization issue in the last commit message

 hw/virtio/vdpa-dev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index 13e87f06f6..64b96b226c 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -195,7 +195,14 @@ static void
 vhost_vdpa_device_get_config(VirtIODevice *vdev, uint8_t *config)
 {
     VhostVdpaDevice *s = VHOST_VDPA_DEVICE(vdev);
+    int ret;
 
+    ret = vhost_dev_get_config(&s->dev, s->config, s->config_size,
+                            NULL);
+    if (ret < 0) {
+        error_report("get device config space failed");
+        return;
+    }
     memcpy(config, s->config, s->config_size);
 }
 
-- 
2.43.0


