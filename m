Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4EC4E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 12:40:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLM06-00078g-H2; Wed, 11 Dec 2024 07:39:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1tLM00-00075l-Jx
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 07:39:30 -0500
Received: from mail-tyzapc01on2115.outbound.protection.outlook.com
 ([40.107.117.115] helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1tLLzy-0000LH-LO
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 07:39:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHw1OkqSc7IqFcx+A+fhZCbGcY/rFPMRUXp4HhEBAAydoUxWHS8UBbhukMzvRNF2m/w09vYdb4qRXO2vTQshnvruUZG3LftO0n4Y5VQtN2oR7k5JKahDJg5gwApQ0EpJpP5BiLL8dRUyFUfjefDdNAOkbXgK8b3nXCWnAdFaYStWoqwu7S3BAvFYm4B4AoI7m8O5HFY5vfiNpFHEEGFh6w1xBfrLjZkfWKm8kCKwgPHD5nkcwcm6Q/F5n/HPyKXq3yiKBYbQ79xCqmFDEM7Qi45XhUq14cQccpkb1vNYK9z19k12jvfSdNuz8ETrgFZ/F4OEI++7kipjNjIIPt9cBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cF41o0xA41dkxAh6dq/fuwNqF1r3lyLKL6CMI3sPOVM=;
 b=X6WispKGyC/lVdy4zMHxTt6QqrWaSLE2Wi9Z3/GwX4ygGN4GmXb/Nl7q6HBrDROIRix7Y8lVRu2TpFoqWYaahPYwGNERMad7PORrF7lYytg2NmUMjWaLbHehOZdBy/zlWuv5BjRlcPsSkTAv62OrKnJBhBSQJd+WcNWJE2LOnHxyCjD07IZ1jaOMwCfvTW9ZtDNnbKHYRCP0mtpS74LNqTY6hkSUeckc5oSbhW8CDlZ/d7eoWVxPGnaAq2SYDdF23NhGz970ruToC2BkczTE41QthKGqTBCdRUB1T3V0otfEaBaK2Jst41x66EQbJpXwmxxloDegpQTkKkv6Scgtmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cF41o0xA41dkxAh6dq/fuwNqF1r3lyLKL6CMI3sPOVM=;
 b=bmZwT1ptaakNzeijrthMBrgbukNah7P9rNXMbT/ut1IB4pHTNb9T3O/+uPQNmGZukmCDCpjdW5tRbipf6pYtrRsX0/GMmsn4XRr4JmCnpOwt8dqnm3TCO+OmymjY498sJBJG5SNQuCKs7MftBnTZu21KYjK8bPPfEro5LLZc1SSdsJi9NCkdqXUAzpE+hM7fc4VqV/pEp4Pk1rje/7lbn/UgbUjtselcK6P6mXpTDpCj0vv7xmo1lXRiph8sOW70qdD/v7SlCEQMRpMVFc6o2TIo/SSBe+rqCrMI5pa0KMfKsR9bOuucpm4Yj0w4mTHh/VBO6+njYlKWQnPNlyKXbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by TYSPR06MB7046.apcprd06.prod.outlook.com (2603:1096:400:46b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.12; Wed, 11 Dec
 2024 12:34:17 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::b6f8:321a:6742:9bde]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::b6f8:321a:6742:9bde%5]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 12:34:17 +0000
From: Wafer <Wafer@jaguarmicro.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: eperezma@redhat.com, qemu-devel@nongnu.org, angus.chen@jaguarmicro.com,
 Wafer Xie <wafer@jaguarmicro.com>
Subject: [PATCH v2] hw/virtio: Fix check available index on virtio loading
Date: Wed, 11 Dec 2024 20:33:49 +0800
Message-Id: <20241211123349.904-1-Wafer@jaguarmicro.com>
X-Mailer: git-send-email 2.33.1.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0183.apcprd04.prod.outlook.com
 (2603:1096:4:14::21) To PUZPR06MB4713.apcprd06.prod.outlook.com
 (2603:1096:301:b4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4713:EE_|TYSPR06MB7046:EE_
X-MS-Office365-Filtering-Correlation-Id: d877bd3e-476a-46a1-6fe4-08dd19e020f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MONx0Bdj6t5hzu8h2vDu7c9aLpNJ8+Zqg+Kd/uLH2kSjb866PRhSPsREeHKX?=
 =?us-ascii?Q?/NqqLT6YpOBiXo0+sIrmtR3C3hHbqELZsIy9Usc4iRxlXPPHApblsxcHD5G+?=
 =?us-ascii?Q?QCW8GYTfGfKS3xEKd7JoMPDThJI4YaHweJMsXTRWaNB2gAmklj4uh1+PwFPD?=
 =?us-ascii?Q?x97/aLxdG9vsyXrRHLZNkwAS7UahUq4axg6mnsqfKDJ4lIgTzfs0WUf/0OsW?=
 =?us-ascii?Q?nCHvAG3S5yDClRpsYqlInEgoePQYIhY/UhuMQHJoFbMfZ6dwpRCqq/4Tdg0M?=
 =?us-ascii?Q?fxQXrFi8jV/QDRUHcbV2OnYcNeGo5RW0wfQWCHBU+EAo4MBfoAhWAIoAVzPT?=
 =?us-ascii?Q?L4hmxZEIJmvTuRY7lF1O1VCxGfuNZhyWBLp4e5OeoBNb76DfTdp8gQUMPSKh?=
 =?us-ascii?Q?pdkrc9654rQrkiYmH6DbYak4jbpzHhEfE6IQ4mCl2exBHySRmafBKtNhlEXH?=
 =?us-ascii?Q?7GDXByAcRmiFGtH8GYjPK3gNF+aRWKAxebGZnRO7Uj8WufycRHGvJLYxwzHk?=
 =?us-ascii?Q?hTOoo2pEDc1Lst5Pnp6kwM89I28cNFRQUgKfiV9oqgpEgBwBtrNo5jgI3X1A?=
 =?us-ascii?Q?iwdTKss/2Vva51hsx1ZvskrnC7FBIHnAfiEx6etb0ahrYqCmAqtU7ObRe7JY?=
 =?us-ascii?Q?BZgd+t1GYe/Tv5V0bJXJVHTMh8Z0IEW1ZaIlzD4r/K9ajaGdcGvHbDRiiIWW?=
 =?us-ascii?Q?+ArTmElIjIR64xlOpKF0n8BleYFcHOourQIaZzAy0lisRtA/2LUMI0JChyQb?=
 =?us-ascii?Q?ne9fwE4uQhG2Sphd++eXpFHi7ACUIy5exMx7w3Z0QLlQ9OFIr3vXm+5/7e3R?=
 =?us-ascii?Q?GtDW0b2JmGfok9YYwvnEPmii4Y6Jgy1+0DGP2Spsj8yA4U3vPsOA337rEJ7r?=
 =?us-ascii?Q?HvjsNJzYUbK6lfrenIDUxuhwJJ6IkKU1JqoTKWyul2bf8yC30A2utw6cIB3/?=
 =?us-ascii?Q?Bn+PGJRWPVVtdAadzi1u8qTMcIEPUr6cn/3VsxdAYx1LchiLD/xm2oyFYeIG?=
 =?us-ascii?Q?tgYrgZSw6Q5NU0wKCaL1gc06ai7eqjQGviT1KU+7bk1UJQTxejW7yjKyXpbZ?=
 =?us-ascii?Q?BB3jPhA45qwMRsrRJoi+Wxsw/hjMRHCkC6KTqhcUGYQf5uAG5cmPaUuLiUiZ?=
 =?us-ascii?Q?zEKoxkIC2RgB2STmZO/0HyeHOf8Y8w7J50bPk6ruOodEHdCtl9JfOQZtctKH?=
 =?us-ascii?Q?0bZQKJfZa2aF/w12oINdi4MB8ROjcdQVVbUjnt5ZPmlW+F618ttGds9lP/Dw?=
 =?us-ascii?Q?u0gkuiZzh+Tb7knSQ+BEyRmw/ElQ0bFZ/vFxjrOFoMdqQlXEptTZ08BxcxQZ?=
 =?us-ascii?Q?YZwCZ8+adNqWwhc6oGi/t1qA2j/xCwpoV24V3bOtmIH0PsK4s1nWXW0S7pda?=
 =?us-ascii?Q?WZeN4afw1p8f1ZzXcKN6PgarEJ339Zi+GB+LWV6d4PQnK736dQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w+4022ClPriQsLN3LmXmIZ6/TGtEkUZGF5soVf5mjSS3Tw2QUy4cpwQMXw6k?=
 =?us-ascii?Q?I3wnMwLg9K3/IMkkEnkkspXkU7l3dRkiQcqXJU/oujgK/F5dPo109eDQk7DU?=
 =?us-ascii?Q?wbZGkUXyPl7lMyFC4qOQ9Qhjkh7vrGJWHAAQ59WuuxGabAnygdQafulSbLCg?=
 =?us-ascii?Q?jPO1jKYrQFl8rVBzknCwRjJLwfW3w1/qhP7OZp4UWPFjs5auOvpx+UJTGJ9o?=
 =?us-ascii?Q?Ailz0KYpuYtgFIadfd3ywY80dyvb+zlkLAo/ZxtaovBYex03IZSHfHJ1LpHa?=
 =?us-ascii?Q?Qdp/5nqBcxiHp0335xtCUQa1yym5QuReCEXEBsK7L+/UK2OXJiYyrUGjoNo0?=
 =?us-ascii?Q?AmbnpOWqAKYCGUaI6hjE1/6TH1SWY+mfWu1FaNo1fif0x9pzZgUBPjSBfe0d?=
 =?us-ascii?Q?c0Yg3NhwBVIwEUK3AGzz3G0HfsaIfxXPlmm+bhDnt6AS3ogrPRZZ6D3Gi68x?=
 =?us-ascii?Q?z3gNYt8VLrSETc2soNlOW7c2xAbfyLTkTTi7fh+zGRtRGBbCxBRsU0KY8/Fb?=
 =?us-ascii?Q?TKrTipJIWE4QcyqcxpVimVNGXFlhNA4S6USBi6SFxqQ9M+fmRtNo0JbwBCJt?=
 =?us-ascii?Q?zHmHH9GlPap2MIZXc8C64Za/JuXc6ufiAn56gFJ0frcEpVRPra1p9+J++/qW?=
 =?us-ascii?Q?EO71uRDjVRM8RoYBoe2cy9pb966wRQevugskD+YJknjjcy/V+LesDVXLH15q?=
 =?us-ascii?Q?5RSylcn7LjJGkXRQH51SkbxefWFzCqyp2KQNJ1kOdtJ0LeWVy0/F3eUiqjVi?=
 =?us-ascii?Q?vs5eMYkpMNrekMHRNkOy1vKlK8zF/emU5hYwu+jZ8ftbAt4WCWGqZcjkk1iS?=
 =?us-ascii?Q?gUrQXiM3Z+UE8tLJagmhKBiYXqJv5kuQ26+m3xqy8tlt8AH2PZd97GIvXUHT?=
 =?us-ascii?Q?kORN84/96LZVBfySu/JLZJrzdnclcWMcV6ZtFXWVE54DafBQUMSgPZ1gQ16z?=
 =?us-ascii?Q?ApT5/q+Mn6Ro3Mu/UbvPTNqtZD3n4ihEMrgtyk2XW4/llZ0k0EZ8Kzp4jEwi?=
 =?us-ascii?Q?XkubwdvdxQrX6mlBwXBEH7/QfsnMCMEN94VNnn7EOMgj5jMt2eg4NyuFSbbi?=
 =?us-ascii?Q?D4Ekh0eeA+6pg1LPDkl3kK2ARYG1k8/APN2Ic7YchBcszv9Y8BNCxjo1I1AB?=
 =?us-ascii?Q?as5gr5jItJXBWl05hacpbyd0Yu8dVnIKhGov1RuGrr3LThrasb6LDU1VvVZx?=
 =?us-ascii?Q?fB20+TO0D0+LZM044ZvOrrpdFMlQ6BF/Ws95JlA94YDCt/++dfQOKNpGGL7I?=
 =?us-ascii?Q?JAWcAyvUxM89K00fa7NB5u9rXli8oJ5hlnXVavQjcZC+lwncBdILVedXBR0Q?=
 =?us-ascii?Q?EJgxWFCcU8+m7ZR/T5u8KBRqOb4E/em7IxY1rvqr4kYeuMbxgO5o37Vfbq01?=
 =?us-ascii?Q?nEcji3EYJxvJTcGrsykIau6d3RTfIt6rEXHs5tuhfpSdw706ysws3Zi1tD7R?=
 =?us-ascii?Q?tcUYHP9SE6px47Kfzp8TufYn7LTkJj36pAAemcRxuBmPZkaQuoLzKSCvxRTq?=
 =?us-ascii?Q?H75gCW9I875aF297vs32MjrGX+r7R1OgQOfBKOlwQl30Mie2mztJstpREi+S?=
 =?us-ascii?Q?3RLjsNJU5PWwaK8WhgnWdNC9GS9AV7LQE5zkjEki?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d877bd3e-476a-46a1-6fe4-08dd19e020f0
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 12:34:17.7502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S4uqUT9V3KTenx+UzV3rESfQx5z3zJsO34qTyRk5B96uatozvEzNqR9OLeGEE0EdU6rhENdnqaJEJnTb5/I1IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7046
Received-SPF: pass client-ip=40.107.117.115;
 envelope-from=wafer@jaguarmicro.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Wafer Xie <wafer@jaguarmicro.com>

The virtio-1.2 specification writes:

2.7.6 The Virtqueue Available Ring:
"idx field indicates where the driver would put the next descriptor entry
in the ring (modulo the queue size). This starts at 0, and increases"

The idx will increase from 0 to 0xFFFF and repeat,
So idx may be less than last_avail_idx.

Fixes: 258dc7c96b ("virtio: sanity-check available index")

Signed-off-by: Wafer Xie <wafer@jaguarmicro.com>

--
Changes in v2:
 -Modify the commit id of the fix.
---
 hw/virtio/virtio.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index a26f18908e..ae7d407113 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3362,7 +3362,13 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
                 continue;
             }
 
-            nheads = vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].last_avail_idx;
+            if (vring_avail_idx(&vdev->vq[i]) >= vdev->vq[i].last_avail_idx) {
+                nheads = vring_avail_idx(&vdev->vq[i]) -
+                         vdev->vq[i].last_avail_idx;
+            } else {
+                nheads = UINT16_MAX - vdev->vq[i].last_avail_idx +
+                         vring_avail_idx(&vdev->vq[i]) + 1;
+            }
             /* Check it isn't doing strange things with descriptor numbers. */
             if (nheads > vdev->vq[i].vring.num) {
                 virtio_error(vdev, "VQ %d size 0x%x Guest index 0x%x "
-- 
2.27.0


