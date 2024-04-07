Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D5CCD128A
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2024 12:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtRcx-0003w3-5S; Sun, 07 Apr 2024 08:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gavin.liu@jaguarmicro.com>)
 id 1rtJ7T-0002rd-50; Sat, 06 Apr 2024 23:22:59 -0400
Received: from mail-psaapc01on2070b.outbound.protection.outlook.com
 ([2a01:111:f400:feae::70b]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gavin.liu@jaguarmicro.com>)
 id 1rtJ7R-0000ma-6P; Sat, 06 Apr 2024 23:22:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUNzEobse0Yam/RwbTDxB+ywgcj84vEWPSZybJpF7eUMMl6riY8Uy+o9qJzwsk++N8ws3FCDYhLw60cHcsepgQlZE0kgfpzjm4RSd5GmrzGI0OKmdiKHQO6YvsmH+uBLNnfidR8XlhqmejQ0zAM+3EZaCjZf8x3VyrHbWTU3PUlbCgOD2BA0WZMdioTORcScNWZdW8epyoHKbOpW0hIZ9L2KHasw0RNtm8EaOHMSWiWeX6VnHsNt669PobFcNeRY6za3k6hK6dNvezIsZjgADP9V0nrL3NLdWFIHUXKV5Up5+FBIYO+rIAVH+wFnSX5q0+8VNBbZRyoqFkgFCeA3Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbyoM/19MKqKhFs1g3+ieZ+Pd1IO8W1XD59zxXOHjVk=;
 b=iuSZGUuGYCV73Qb8wa3Uo3dP+8EOraTMeDEZFDGy6E4KfwenxGjVIXAFaVuaNlNcAyjeosC5NXrtbk7jp1SVtfS/zm4T1WtaSVgUjJT3bLgC7ob7PkUpbM056Xl80vhCiTmP1ChbnWKMfBMJ5ksnBPS+TnEK/GWPwfdmsc0VpQAxN0qw/pMey3Xr7rz/m3n1epJH86VgGfbiOChzmtzWLf8P9U0ZEneI7QQLyFsOIlJ6sZ+7DZTqs6lJMwg3LksQBRpQotI4HQBp/nKC+bLsvQT9aKA/qN2xFh9vIvaaRDeUyaUJtWGZXpfPmiaNLM+P8TyZTNbz3lWEq2NExVGUUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbyoM/19MKqKhFs1g3+ieZ+Pd1IO8W1XD59zxXOHjVk=;
 b=ERF0guVnBN782hdNM4oE1spp8fr+7J2fw1zpVMDQccIxXz9eZRRYHVBQCCrmEmoHFa0O5lQJQt3zaJnhmlrwxbwdbYGMa25T4wLsZQjQI8t23dcrscxIbKmKyKgbfJ1cpJhTlJ9bs5ZfGU5f+Un4xgs6A9+jmwKYPYHg+hq/mnKnx1iATkulu7Rt1kXhc5sNM16GO4ssOjwseZntA7/HWPN9IvM7T6xf6dd+g7BVvDfrtFRcrUwUl+iyb6LryaZtg4cx5U3rwNP7VhCTgZqvMEq/H9KGj1lMzvCvOCYbTZI0gdD4k8o3z6Iz3YwudWe82qehlbE+d67dsIfik+hkDg==
Received: from SEYPR06MB6756.apcprd06.prod.outlook.com (2603:1096:101:165::11)
 by SEYPR06MB5160.apcprd06.prod.outlook.com (2603:1096:101:5c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 03:22:44 +0000
Received: from SEYPR06MB6756.apcprd06.prod.outlook.com
 ([fe80::922f:a649:adbf:6634]) by SEYPR06MB6756.apcprd06.prod.outlook.com
 ([fe80::922f:a649:adbf:6634%6]) with mapi id 15.20.7409.042; Sun, 7 Apr 2024
 03:22:44 +0000
From: lyx634449800 <yuxue.liu@jaguarmicro.com>
To: eperezma@redhat.com,
	sgarzare@redhat.com,
	mst@redhat.com
Cc: qemu-stable@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 jasowang@redhat.com, yuxue.liu@jaguarmicro.com
Subject: [PATCH] vdpa-dev: Fix the issue of device status not updating when
 configuration interruption is triggered
Date: Sun,  7 Apr 2024 11:22:40 +0800
Message-Id: <20240407032240.1898-1-yuxue.liu@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To SEYPR06MB6756.apcprd06.prod.outlook.com
 (2603:1096:101:165::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB6756:EE_|SEYPR06MB5160:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: prFxFqDm7hPjGoLuUnF8hnnWobd9aEVgor7UF4mKOEMt0yo9x9ZgK6oZbC0TkXG0+dF92/yiIpl3nQ5y6y6Z18ERezTRbcnGiNfzeLbXpru5e4NDx9DRDadbq0ZinQmLDOv+0AOsyCxVL0OcLXjhdln+6C7PBuRQSQgWZXnGwGosab+b78imJPwQ+9edQSjWrUMGWWuIkA2TTUUATa9mfY92KrkXrjQy/X+NKvdgjKY5K6dxebkOhTlurZ8p16V/nlWYlQK6o6zp1hZVxuphGF5BRL9GlN53HYi0nuHYJsSe3qiBl8Iqx6R66pluzarQDu1cP7Jq0UqyLWTRREWGoNGJt7WByuLkyZXcx8l0OfNGtktqWt/klgHmOkqJgLMag/k6Cgb49oo78erlCY28O0OdQdS90lUkZt2nutGnRq/iw06n6wbhkUAhpmkNh1kjYmqDH1DMdM3sFECF47ugF+BfxuwhaZRtz2PBR+ulMHhFGQ5xWm7oT+qqoQG/hA/X//Ye25xN+ukdHhRQQ8qoEhr7bzTKJUbIWuhBsXSNPTx3QOKi7cpwMZG0DAkaiNUOTtPjwMwUI8msMrPXoE5/nKw7b33uDph9UQ/NrGG0/UHE9zbV70AbF1avLuTUbLSs9q0PcwBRQidIaab36Ha2PT33O0qAyvzHsF+42ngRgUlVplXces2Jp9hv96xsptejnebz1vsyp47LH0rmDUVtVxypxbcTAB8eHb/IadyqCFoQw2ki10lY5/VC+UNve9Eb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEYPR06MB6756.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(52116005)(1800799015)(376005)(38350700005)(43062008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6xOEPAg7T3Rc9QoftKFghqq23VHA1MzXpyoN4OaIJYn4jnLcEo3UXEzmFkmr?=
 =?us-ascii?Q?Gt1g7JzGVah2VZd2L0b1vrlbcZIKT8fULmr9vowbd7NnRetdOcjqhLC3gFdc?=
 =?us-ascii?Q?a4w4jyKCE7QgTS1SLrmr63Ll1IMQUV4azKlbDWQSoQ4/36BAagNoeZ5npUma?=
 =?us-ascii?Q?03VfHPILIWaCamXhlnt4ZQzYHcsN94HhTXwoOoxFBOqHE/9hNEVetaBLmtI3?=
 =?us-ascii?Q?xBdsAYt1iViLkMR4okriwqjpLxCOS+quKNJ0ICsQq0InjU8AZCBrJ6LGymWJ?=
 =?us-ascii?Q?x6QA9yDnCk7jhkOZX+g+zmB2OmAizzlF9aYNKk3FO5beb3PgltSeV++UMp2R?=
 =?us-ascii?Q?non+JfK1cRL4RIYp2lTjszu250rn2++V/rYUpcTcUOMv6e4b0I2utiYOJPwb?=
 =?us-ascii?Q?szVdCTvq8bXRU6Oaf0oE5CnqEu8PnIBJWvYGo5Djrc0Yi5mVd3XxU3hxm98B?=
 =?us-ascii?Q?sicTXULhDmMcHWzosr9xM3ZABpkS4PvopGyJtJqgX/K/e2Iux/9N5j7VJ43s?=
 =?us-ascii?Q?nuTHgOc0JycCRPMxdafR6Pih45OB+cKImSpvJ00VwK6lV7fuLZqvtKWQRMX3?=
 =?us-ascii?Q?FUlVuONp3RhHoRDfX0/878NfjlYzv7ocKBGzTGj1YBK0dWx0gKlu1UfAmFhs?=
 =?us-ascii?Q?0YJ/4OKnC8ENiheV757XgJOVbOmVkEOuKhqFEKK9qafn1uSQWdWjsbBEkZIb?=
 =?us-ascii?Q?346GJIl/uNskUtzMBle088Q4t9XB7DU9Qx7CXJWmgZU2h482OHnkxr3ohbWx?=
 =?us-ascii?Q?YauNO3Xp/mxVDTmLP0nsrYwXWkR+AzWF2pwdRIRoqAbXjhiECugjRZ7+QR0q?=
 =?us-ascii?Q?Si5Op4q3ehTjUD5Jgf7sppb+9qYt0jGdW3YOzvr9cxmoBK63GVxEZC74asZN?=
 =?us-ascii?Q?didcaAJ/z6Rt4C0fe6HmT+5Q1VFtFKkQvT6aJOM4h2kmzz6qxJCDZps8Fkjq?=
 =?us-ascii?Q?HI5pFAHIvyzmxh4VtbZXmGwyngKhQsf/iAnnvHke75HxhXmOXax4/9TqA90C?=
 =?us-ascii?Q?b+040LPZdOo7BmikiOs+nEe1ODaWtTE7r3AsSaeNHYssjd/ktGhfPo9Zs3GD?=
 =?us-ascii?Q?MLpQ5KMJ69hTNWGEzhruRDMc7KLrggfL/YXlcz1zyFldr5MDGPN8n5JnA/Ay?=
 =?us-ascii?Q?PctznMLvQ/DVz9lmLxRju5lC3sAevoFakPVTCuB1s+N8gB2UlCy+Gvshjc5A?=
 =?us-ascii?Q?G8npEkaBfcq+I6bfM/McUadvOSmzypxlfQnBCTRj6wE+pqvYQC+sfCtZ1d1j?=
 =?us-ascii?Q?cvO/+FTr74nLIXQbmGRydfE/gReCF/4lQFKIkVZYdKxt8S88JKRZFMY23R2k?=
 =?us-ascii?Q?+G4MJ46+wVkIuVG+6Z8qRTrfsrMOqGbPt5qX2Z5KCKuQqFTc9ojfTJrer4cn?=
 =?us-ascii?Q?dpClp4ddFjM9EESG1rkHKCsdlC6bCzZxwm9LjL7eKCMbnoVOJaqsYzb5T0Kq?=
 =?us-ascii?Q?czSc71JsY3U7MOMM7v2muRCL4EFm8wilcBXncvfXgv+maQBpLo/Sd4xsE1ny?=
 =?us-ascii?Q?O66F5rK034OGDwA9sinK2mlWDRh/PvPtiP1P4xpAQNOPvpCgHziaQO+gr1Xn?=
 =?us-ascii?Q?SmBcHMhyy50iJtJ5YGPbKLoVGO9Lp30t2JbF9z5ATqZ7YVJw9YeQqWvonxZ2?=
 =?us-ascii?Q?eA=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4640fcea-f81b-49ff-5c09-08dc56b1fd89
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6756.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2024 03:22:44.4594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cU3ERq6QIS/GjIpwqZOvIZFjutF0XrMq44ywVmmARHvOCFnTP6b4jtwbes/+Sj9c93pub8FK1ZHn6JI7cPrE2OJxOEyOJlezUQBIu9uHpTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5160
Received-SPF: pass client-ip=2a01:111:f400:feae::70b;
 envelope-from=gavin.liu@jaguarmicro.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 07 Apr 2024 08:27:53 -0400
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
device, causing the GUEST OS to not receive the latest device status
information.

The hardware updates the config status of the vdpa device and then
notifies the OS. The GUEST OS receives an interrupt notification,
triggering a get_config access in the kernel, which then enters qemu
internally. Ultimately, the vhost_vdpa_device_get_config function of
vdpa-dev is called

One scenario encountered is when the device needs to bring down the
vdpa net device. After modifying the status field of virtio_net_config
in the hardware, it sends an interrupt notification. However, the guest
OS always receives the STATUS field as VIRTIO_NET_S_LINK_UP.

Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>
---
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


