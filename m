Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 396FFD1D878
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 07:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR406-0003bt-An; Thu, 04 Dec 2025 02:43:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vR404-0003XH-M6
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 02:43:40 -0500
Received: from mail-japaneastazon11022123.outbound.protection.outlook.com
 ([52.101.126.123] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vR402-0007Yx-Ab
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 02:43:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y5j3eAv7asPxmRXj8zCdSuenrbalUafX0/nWjdh6dgb0WkdcWaq2NcLS2T7YBg5cobq6E65oz29KlA9Gkdh30K6SMZO/jS75v9jk8W6kKaJWJaCqFzjjtxeaBYzHfglPEvWs/e8gt9Yy8zmXW6hdXDOcOjB2T9IDyWIzJXAxliqpERycFVoqoq97WctuFRYV048OZyXlDbQbfSin3EXQdJQEQkbZSM5unckkVxB6wise7qDcGng1f7psCgGvoH5nX3NfBNlo3SPHAiyKPzBWiHqTyCL8Ruxs7Waa5g1QYOpQcfKQHm1WBDwz/SYhASPUbZ/4Nzr0weigMOlmIErklA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCOiFyfMDzXy/HB9eCBdmeDwIZUVzIHxTz0bJQyO8u8=;
 b=Ly76YpZlXsQLw58AdJyrmayHAVRBh9MV0oFkqlEuU5HhHY1fPeSjREQMmwCd6qafXdm2gG+ZtTspDs/5tjzxCYA2Sy5gpyBgcSMInJrvhXbAPeSJ6Ml7gaXuK32/DZ9EVL0hR5o+TFqGlkiyjUpE15WQ2h4HGe5zx79FJr/QRhoi5CxBgS6PNcW/kvBfvo6lwLshQ7w0xsp9WcZ9ls6h5NXxlAeeRsAUYzJmV3jSocMWmLW4JthJG6t9qxNTIq/nKNuP09EffMcZWB/RCnhmbmisy52vWs6CmbRmdHlqovXXA1nzRFFH3puBW7I2cXo1AZORlbGL+y8syb5anBXclA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCOiFyfMDzXy/HB9eCBdmeDwIZUVzIHxTz0bJQyO8u8=;
 b=WF1t/hjK+ybMk0Oi4Edy+XIOvDI2+mreLa8awbpKZX9+EYfLuOjSjvdGLsjCRJnDJe4KDIFCgLzpsaaQrGTx/8e7IyADd7oZmJJrBOIhAPzqu1HRv8HPoYMBl3gyQyT0kZ8cNn2fcDboBizhggoyWGcVzsbUryJ7TXdIMdodkeXm7k12/1Hk7WkhaYpahSYDX0BP9nu3drjOoF/sgAjXB95J5596GAyPVRT6jPxmM7d5CTb8OuqImXvs05KVciqLRBP9lFC3Yqvmy1b+2vC81nIZE1SgdbozdfHWS1T6ufl1u9oec8jwfcW54XBNRGyihtuyQ6g57vyGuqSLs38ogw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by KU2PPFDF24F4212.apcprd06.prod.outlook.com (2603:1096:d18::4b0)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 07:38:26 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66%6]) with mapi id 15.20.9366.012; Thu, 4 Dec 2025
 07:38:26 +0000
From: Wafer Xie <wafer@jaguarmicro.com>
To: mst@redhat.com, eperezma@redhat.com, jasowang@redhat.com,
 qemu-devel@nongnu.org
Cc: leiyang@redhat.com, sgarzare@redhat.com, angus.chen@jaguarmicro.com,
 wafer@jaguarmicro.com
Subject: [PATCH 0/4] Add Split indirect descriptors for SVQ
Date: Thu,  4 Dec 2025 15:37:46 +0800
Message-Id: <20251204073750.8953-1-wafer@jaguarmicro.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0035.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:7::7)
 To PUZPR06MB4713.apcprd06.prod.outlook.com
 (2603:1096:301:b4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4713:EE_|KU2PPFDF24F4212:EE_
X-MS-Office365-Filtering-Correlation-Id: 3081d0c6-845c-424c-5214-08de33081c3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+jkDOJlwjf4aAXwGwZKKJnwS0bLG8P8nN8Q+IHMlvxxxuRHhRPDp065TN4jS?=
 =?us-ascii?Q?ifw2KTQ5mtvAOuJH45MEgEyeL4u9WakDMKufG6hqVQU+yvvgIllKM0QqE8JT?=
 =?us-ascii?Q?MWXZFxUMfx8kibnlIg1FIxXAVRrusNGgCKbz7U2pK6vrNWJQJNJ1IXgJQGKf?=
 =?us-ascii?Q?2Y4D19nwWbgXaDWapwAgyxvpoTP8yVFD7p+XAihRwnERpzSkvLa3JWq9mHwX?=
 =?us-ascii?Q?j/Q2g7K++y0ajx1KTHu8LuslD57jh7ETOdJL8LZRN72aPBJy204aw/h5ylql?=
 =?us-ascii?Q?Cqa3694TqOupzacnBbu9oY6aea35KqpOTFDY6E3f+MwZkK1j8W+1Ja2Tw1L3?=
 =?us-ascii?Q?WRRvywHlTv1ovcyUWDEaN1ZCafwmTYdvS+GfnSFpoLpxUJClbhzxwSW2VUsP?=
 =?us-ascii?Q?4B9XYnC//LlTCPGt/O2MNk1iDauC0r7JdnxNotZZqZTwnMRo0v6IdlFpknv4?=
 =?us-ascii?Q?OpI4spEv7WqmAY4EoUplA63LxWdrfI/EwPMcgEjgk5GXyYSq5Tgwm2UoLE7i?=
 =?us-ascii?Q?a7kIysYd/vCWNx+3ooz13VdzfKgmoJYCoxMzzfTXQ4rb7F81NvuE0mcYJfEa?=
 =?us-ascii?Q?wHdcmdFhaI6Lj77H7yDQIxh9u+x+Y3/aO4+X2ibJUsKnOaf/U4ubKS/ATJvR?=
 =?us-ascii?Q?aTXDm9i8RNgB5/dbZkXVdlL+ORfsvK56d31QJSS0ieEKKLuF4X1W0PRnRdEx?=
 =?us-ascii?Q?BbmPj/qN3NVnPE+p8Mwa6sJ/WR4f3/cTe8ZEro563K0eDaOSjn/YWGpO+m7Z?=
 =?us-ascii?Q?RaGjjgPUbA0IePqeE0tDLtxpWFvfwnqsiJbieUdMVMyb28TmAlGSI2J1WkC9?=
 =?us-ascii?Q?U/ERoGv8zXj1dPBteZVpZpsCYH9ZAipEGmDVCrvpEaUbzobAxXJLuSMtJIJu?=
 =?us-ascii?Q?YZUoYPWGhzyzDjSkxsnkRA1cYosr7tAzLdvS7i9QUV7/o5U9VKJCbk7+5zcD?=
 =?us-ascii?Q?UXTzOOC9Jl8z0kODz2vPnKtqnE8sw1xj9FIIpb4TSxK/72nUU8aGMaYL9Qqq?=
 =?us-ascii?Q?61/7Oz2D0sU0lyuaCKloOH/H62z/+3MqupHPe61sRIUFFBytHoliCAkKDbNC?=
 =?us-ascii?Q?dWnJ9Piy01TImvYjBDnmlol0TfebcR9az9n8pzVdf0MY50rTxj+n43X+W8r3?=
 =?us-ascii?Q?jRP3DB7YLIMsWVNnGpy6pypuZk2x1YKUZ1u/obTgrOgJ76sc9pHl+gPQRPxU?=
 =?us-ascii?Q?P4BllzoGsgXECRPWBnmpv98QrXrA9B/EzZGhi5t4Qu/Y1cJ3Wd1PsdRrCsHd?=
 =?us-ascii?Q?Sc8kCExeZl+1K1fG5jIoaNvKTff30mWz8kKJVfJLDqpv2Dp8oUx3+oBeYbLf?=
 =?us-ascii?Q?c8zho2gpw6r01MKSYyzNeWVj94LH01OsFgKIxR6amGlgwt6Tvk5xYUk55+Wi?=
 =?us-ascii?Q?LiodJnwC28//cz/F7L+kF70oUry4g+zhnUdeYShi/zb413IFyyEX/UB0ApeB?=
 =?us-ascii?Q?fN+TekF8P60Vt9NmFDsDvqxtCAMMBQe3Hb3WGeN89svwkDoQWbA4VExctUuk?=
 =?us-ascii?Q?5D01ZKaIbQcOQaCUOSeOy7ijVWwIsQbF4x/T?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8cwKRIdF2tCWHnFsbsRCaILsRbawiVdBXlIhl1AtdOkaMdGoVDxAmZ6uGluU?=
 =?us-ascii?Q?poFan+HqqVYuhfuinWk0nAi85sFdxq+2mpNH4rpv8l98QDO9dmtMpXBjGv/G?=
 =?us-ascii?Q?+zMD1PH5gcpckzoxPO2F8danfC2hK/jve2/qs4iyXlBjirF+lC4czwxQ9D+u?=
 =?us-ascii?Q?kl5A5mcBPAXvX4GWy7yjz98W2vJIN77n6Dc1vmOWfy5XJiJ9kuL3FL3a5PZD?=
 =?us-ascii?Q?Z/YUjhl6ckjd8q43Ha78KskQHmWqBEpiC43OoOBy2okTGfON2vnTSZ8KjfYL?=
 =?us-ascii?Q?Af/qpgSZPMecD0os63c/B7q62sdBLvvpV5J4CJ7Zdd3358t+sDMmibnl/uE8?=
 =?us-ascii?Q?FWPpRKHMEFmRNQ3Gl6JdtpMROdoLLpj2zmQHjwvYMI5dr9gVkfSyJZ6/KTH0?=
 =?us-ascii?Q?Yt3iRKiou9fWzqTJYVXsdAddgS7N27e+LPdJoHxSqVYQQ/Ait3ak5HcWF4kf?=
 =?us-ascii?Q?c4N4tuEeeA/Ke95ciQnCt4WfrLioXzCDgRtaSgIy4gFoU0p7G4x6K/NrSYPL?=
 =?us-ascii?Q?sVzzpoFUjPPR4FGX7veKr6T90Gc1zN2BuwfXFJQnGUNxJg+3PNnFN11fkfhj?=
 =?us-ascii?Q?uG/w+3Z6sCSwajEqKsC/aq/eKuV7ArcvURLsYCUqUvR2HSGmP4Oj35hUs6EI?=
 =?us-ascii?Q?sajrKWyfPBRSJh5ggARwHwSWrSNy31oFDMVVEFGBbV39ONv85qqDyNO260do?=
 =?us-ascii?Q?uqD0sdcwYoR9JBXz9Uo04YBdbTQsXeXvkRbUrvmXUVSTyp4afrcMtK0bOaW2?=
 =?us-ascii?Q?ofkQKTUCog9cpYk1W0J+Y4XSlaG4DPDC/Y8wPYqC5bVBC35RDz2eIyoE6pBo?=
 =?us-ascii?Q?1klNfaLVA9UNcH/ySmnNfhYRIg+3svTZmsx90qc/LLfnSoptQd5LisiE1Iu3?=
 =?us-ascii?Q?K/YYFQVdzX/vl95/MZJEHIZjYNpOKypj3OrpATzEuTwRI/TKgWhjlqJXqn+F?=
 =?us-ascii?Q?xECc65sk6/Q+Kx8Dx67SE+LTIlroBDfRCjJv4GsyyOaXW0dy3wPKFIUT6e/6?=
 =?us-ascii?Q?TDmCf59zpsbGF2e7SCapPIew86YT/wv2twEyuDGo4jynui1dWhzrP72qKUOW?=
 =?us-ascii?Q?4EB4d6gvJSLt6DAsRjqMbDkfyYki3h+yYLFZflrZVQqS6JOuc/uV0TKAodjX?=
 =?us-ascii?Q?Q3mhLOcz8TYSBXmVsgJquEYHp/hhlft8hmoYq7B6p+hQ1J9JMfGkgxK/eafj?=
 =?us-ascii?Q?Cvp+iYN3QKOGVTUvzPnhtXvNaanWJJ+jite11rKter/bJsLuG75HOhhp3i5U?=
 =?us-ascii?Q?jYmzAfWATA2q6OkiNudDbXtUPeGrY5sjoeHOJs2+3w2eV2GquG5fnBySIvxm?=
 =?us-ascii?Q?SQHX8d9h7z1so9UNtxNBwxgIWui7K5IzAywCI6vcpfQ0xs+ydwrjxtaeWzrs?=
 =?us-ascii?Q?5yO9r/osqYTsPgfAqc9DBiXA6Hj0KwBWuhSE4CKJT44VS16CGJSi0ahl5hRi?=
 =?us-ascii?Q?ENlGFRmRZf4xfymqB2PHnOnzp/BqSGZojHYFylMgNKWbWWUvPHUGXWpcZXDw?=
 =?us-ascii?Q?dopCgAwf0b0Ysq1bhU+QM2DtqFMFmVG5LY/hCjnZKbbsu3GcWnURQ3mxGW2S?=
 =?us-ascii?Q?vsKAE94D5nste85Ac3kPtt8WGBedtb7XohA38cCs?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3081d0c6-845c-424c-5214-08de33081c3e
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 07:38:26.3728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ORfKek8oy04wUxYjadg9fV0nQm0vYCe5v0kpxJehW1jUPpLzatvGqW3HfDWL1vjwQMM7MArL5J9OKAj91WsjkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPFDF24F4212
Received-SPF: pass client-ip=52.101.126.123;
 envelope-from=wafer@jaguarmicro.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

This patch series adds support for VIRTIO split indirect descriptors.
The feature is VIRTIO_RING_F_INDIRECT_DESC.

Eugenio hs submitted a patch: vhost: accept indirect descriptors in shadow virtqueue
https://lists.nongnu.org/archive/html/qemu-devel/2025-12/msg00056.html
Therefore, this patch must be applied first.


Wafer Xie (4):
  vhost: add data structure of virtio indirect descriptors in SVQ
  vdpa: implement the interfaces alloc/free for indirect desc
  vhost: supported the virtio indirect desc of available ring
  vhost: supported the viriot indriect desc of used ring

 hw/virtio/vhost-shadow-virtqueue.c | 224 +++++++++++++++++++++++++++--
 hw/virtio/vhost-shadow-virtqueue.h |  57 +++++++-
 hw/virtio/vhost-vdpa.c             | 130 ++++++++++++++++-
 3 files changed, 395 insertions(+), 16 deletions(-)

-- 
2.34.1


