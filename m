Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B4FCA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:30:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGDHy-0000BP-I1; Mon, 12 Oct 2026 06:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDHE-0007eu-HH
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:29:09 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDHC-0005FA-UZ
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:29:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZW/J6PhbUPijkS8wm0ZwdNmOqaZ73D1FSN0M1QdD2m+6hf2IztkKyoLAq09IgGyOraZ+dId7fzO90kT/SA261fz3NuJ8i7BIADZa+mloPXdvTK4NFOKekUsUQvVewuSboIJQUe2Ff9FdXiRw6/5YFs7Dwb2TCQBNsYNAMtUBjf8CR12zPEIIz4BtuDRIQfS4+VHVUWJq72HzEqjQ+CWxFiKaPhLHhI3IhSPjokXZViD5ACICt3vItEC4Mnaqt+0+JKUv8qB8M6Hq2Ta2m+7UHyfbLzbKFk6nB86WbQ3FO4QbeDbzP6IN7BgSy9sJZl/IzkgJWj4v/bzX79ISy8UBTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsVXvvvzwqJ72NVYywAYrq/LWoyKs50mmgOws/1FLo0=;
 b=ao7nZ1pPur32QOqSWPvEliOJuZzsYG0AI0UX4Krp0YWbdaD6c9XM3nK2l/DO1gWQ04A35nK2/WaMZfI//IzgnzoxeUITVseXGIb+fWoi6O0W8jRBmHqjjDDhtBHVVA8n7HbwP0T/kTtQNXFp3h8b5/7SiB4AjQ92ZVvNRMH+xHHf5XGOpH2WTuC+8WaOZ/MZutfEy0S7nycyXpyB+/MRtyWI4giNCG7Dp21segnLBV2kXWEVA6CYQdVkhU3hJPYxPdqwax9y8i6VqNcfdRKiKW6XT5KFAeV54kAXqyJNxbIURloeMKMw7Y4xY5jSLMXODi2ZAlhK6EtmK1Qoy4di7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsVXvvvzwqJ72NVYywAYrq/LWoyKs50mmgOws/1FLo0=;
 b=vEn0x4SojQ9wSHUl+nt+233Aqxz90bXtwZd4AmbyoUQEN3L38snGYKz3we50nh00/DpfhMUJ03rG52TGe2juziMuiv9avIh4TnxSydyFhHBL2qi1T00M1dkZw2knbwgVHUi0uxnXp0O2EiX5bqUxdHqFxC0cfPcNFM1Khe4L4dPS4xvmXqpnZgAXEayt3EO25wCQJ1Mek4NLaPJBCSnIwM0FipscWXqE8sMVmq00RstYV1Bk7a89O1SFP5xyxbNPak/w74EGyzBpg3NclHm95PVmYiMqNPFTX7xPRsKd+5FS/LqLhIkByBHLTzIzhx4G+HiQzG7vKXaRMWluBbatxA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM0PR08MB5523.eurprd08.prod.outlook.com
 (2603:10a6:208:17f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.11; Mon, 12 Oct
 2026 10:28:41 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0522.008; Mon, 12 Oct 2026
 10:28:41 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 12 Oct 2026 13:28:21 +0300
Subject: [PATCH v16 13/22] vhost: add vhost_dev_set_owner() /
 vhost_dev_reset_owner() helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-up-vsock-vhost-v5-v16-13-36c38bd15ffc@virtuozzo.com>
References: <20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com>
In-Reply-To: <20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, bchaney@akamai.com, mst@redhat.com, 
 maciej.szmigiero@oracle.com, sgarzare@redhat.com, mark.kanda@oracle.com, 
 vsementsov@yandex-team.ru, clg@redhat.com, den@openvz.org, 
 dongli.zhang@oracle.com, farosas@suse.de, andrey.drobyshev@virtuozzo.com, 
 peterx@redhat.com, dwmw2@infradead.org, philmd@oss.qualcomm.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR03CA0043.eurprd03.prod.outlook.com
 (2603:10a6:803:50::14) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM0PR08MB5523:EE_
X-MS-Office365-Filtering-Correlation-Id: 3413c97e-e101-4636-2f8b-08df284b9615
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|23010399003|366016|10067099003|22082099003|18002099003|261009223027099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: CQJwmlt2g+DJ6r9yicv/aYwlCgBdNYzaqqNBMIUndLhHLjXmvu/ZOayzy2lmziT8OtDLhaFTBDetRU+js3bpapwJLOlZD4hdpcYvfbPyzXHGQpHnzLLu2tFsCnNWwSw/MNcs0zx1iCiHjLJ0C4pl8Yc4mQVzql6AdzjbmN7bLznvjzDPUfWrMxi7v/yuEap7jcwJ7Zr1CfZPX7epTM2YgsjIsZrRYGEQ/cnKq3AIqQrT+tJE58rYrmbavOPCmnTwGNOWV6LWLVVvtpYrzrYZ2JbrtdeJDlU5GOt3TZB1lHgQ7Kf4ZiP2dq9+cIsfhutDDN72JTdPmLY0z2YdVkGcsAVXF5egsodcg+9iasDyw6qsEquaLnTCQhQ4I/tjC3OSxMG2L6ouw86hvo3bKYLziTA+aiS5jk+ISVUobd2D6MUmLa+lpkNWMy1Z1tU5NrZohnumwYYVW7kSCEebkzTTANRIIFu4OveJ+NadWfGY4bo2fopM4yTCSmNOQ8txubUcm4cXcoQRe4i7JxX9B6FslAD4GmQ6MifXng0CP57sDedAEJUkXrQJUw0zwfuaEbcrewOcEN8b8Voj1c+dLBFPdWydGxrd7vY6ymAH/mQ9JJf2HaO74wSWY/Pjz2Xsad+lFA46xL6erJUDICckVYP/xpMpLDX+R0TaYfsARPCQBR8oeXf3bxYRZdn5lTehOA8QkINuUMuRLpGIIgoY3ZqB4f73DWzzw44HQauv7Ro7tjs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(23010399003)(366016)(10067099003)(22082099003)(18002099003)(261009223027099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGV2cGs3aE1IZ1VaZmU2VERoTXhoY1ZmaGtqdHpCZlR2M2JGZEQxaUFVT1FH?=
 =?utf-8?B?d2NIdVBhc2tPeCtqRU9ub2tRZmxpMC9xNVNNV1dMNmpMQmhEdTl6NWREQVpG?=
 =?utf-8?B?M1JaWnFNT3lzTmRrL2RGS3JvRzhEZnBEdU9pNC9yVE94bGJ4WTdubjBrSGVB?=
 =?utf-8?B?dnBOMU5LWEFjTll1RFM3b1g5dlk0TUdiZmxsdnpQSjZBU25MVUpjK2NHZ2N4?=
 =?utf-8?B?bTZjYjYyT3B6dmMvYTBvZGJIOGZvWmJtY3owVEsvQ0xxSG1mS2lsOFZJcVVr?=
 =?utf-8?B?ckZFZG96dlNVcjk4N2x3bFVHNEE5T202cTRiRDlDL2ZDWjl0ZUlLRFdGUnlL?=
 =?utf-8?B?bzdoRTFwTitpb01VWDIxL24xb2w4MHdmcEVhZ3hiaER1TitBejlRb0pPZTgx?=
 =?utf-8?B?RDQ0R1F0NzJLVC8vaWlGMFltbVFZbS9QenhmZ2JDSGtwV0daSitmRGxLWWNE?=
 =?utf-8?B?ZmR0V05Cb3RvUk9MMUwrSFdUbUxYd2RCZkV0ZVJiRHplaG1SVllsNlkrQjh5?=
 =?utf-8?B?cVdBNDBQOHE5SzI4ekV6alo2VG81d2V1R3pXcWtDaEp2Q1RZZ0JCbFRoQ0Ft?=
 =?utf-8?B?NElvVXpNZVJzMjB3N3NaU25paG1Da1JFcXJSaGtCcWZIMzlvWVVMUmtuUEpp?=
 =?utf-8?B?cTd3TUFWWFR6M0M4M1Q0NU5YR0J1NVpabE1Tc2x1cm1lL21aQ1FHN05UMEcr?=
 =?utf-8?B?SFlNWTN2TEFPYXptclBGY2w2aVRUSjlwT0NXYUhTMk1FY3UzU2g4R245NEUr?=
 =?utf-8?B?ZGFkQUUxUUdMTkFZTVc5ODNGeWplU25ENUsybjBNQ2tXVVkxY1pvYXBjaVh5?=
 =?utf-8?B?YlhxT096R2t2YktkTFlZZm50OGNvNHF2R3Q2OEg2REtzaXZ2bmxDdE9tZHNG?=
 =?utf-8?B?MDZQL2J0RXlGL0xIOUgreVBHNi9zckZaZXhNUC9MMGpKL21LUlVLK0k0NjVS?=
 =?utf-8?B?SllxbHJUQUZzUVE5TGJTbThXY0RlWXdkdmNMcDZUTVFibEd5MkNYN1ZBRjhO?=
 =?utf-8?B?M3JOdTl0ZEZoRXdXM2NxNFhac3JkSVJjTDFSdWxhNkhoMzBTWXhrVTNDUy82?=
 =?utf-8?B?dFVCdnJpdUUrSmh1TUxhdzNVcCswUXdKVXpBSS94UXY5czRaeXY3YldmTDBL?=
 =?utf-8?B?SjVNT3EzeUwyT01naWpjOUYyVDdkSjlMcEx5WFF1eTN1VTdpenBGaHhucEVn?=
 =?utf-8?B?WisxVGpQRFFRMDhUNXhhVGhlbFhkZ0UvM2luU3dZMDFaNDdBd0I4ZEdXRUJD?=
 =?utf-8?B?bSs0aEtta0FNeXlURS9wNXVkZDJ3TVFKa2lFSmlEalFJaW1DMDhGWGt5bjh4?=
 =?utf-8?B?NXlHbXY5ZDlITGNmb0JTQ2lzTTUrbzNXT0JlN0VyRm90eXROMVR6UjRpdEhD?=
 =?utf-8?B?RnNqbG5nRHNsZmM3bmo5eHFNS2RDRFk3K2NiRTZ6RXk1QzhXUGV0QUtxNUF1?=
 =?utf-8?B?Q0xkbTB4RXgwQWJxMGk1R0IwMXRLNGFHUEdNUkIzbTg2VHZQS3RZYktDL284?=
 =?utf-8?B?bkxjSnBqNnlBOStDazNiTDdlZmZPc1pWcGlrcyt1SVB3VXgvQ0lxQS9SdUgv?=
 =?utf-8?B?cTJjWGtJekxKbTlxaVNiZVEvSUJhZmJ0NlhVRXdhbkl1RnlCQW9TZnlXYjFO?=
 =?utf-8?B?OEZoKy94UE9IOENtbGEvWkhlWi82R2RCc0d5K0wvS3FyZmIzck1OK25ZeDVO?=
 =?utf-8?B?QVo2Rk5SR0g5S2s2aHVZTXFDUzdiSjQwVmU0a29XQ3czR3dRak0xSUFZN0tR?=
 =?utf-8?B?bDF4UXRGTDB4WlF0M043c1VldjBkdWozWDBKczFwUEN0QUFvOGpqdWRWK0lX?=
 =?utf-8?B?NmJ3VEVIajlVVjQrU2cvOUNOaXNpRHVMSDZjU2ZtYThzN2QvQ2pEZTBQRkdo?=
 =?utf-8?B?VUdJVWFkclphVDNiTkdENTREelJkWVBoK1RSOG1DK2VzMUhVU3V6Qk54UWsx?=
 =?utf-8?B?UUprOUJkVkFlRGUrS2JiNkpnT2l0VSttR09sRWhnTGRadXZMWmhPM1FPMm5Q?=
 =?utf-8?B?NW9BRGJlSXRoV0lHL1hhNzJjdkk3dnhHYVJGTzM5QVlZWno4TUtJSzE3UjVy?=
 =?utf-8?B?OWtRMHhHRTNjWGpNeVBuUHQxZWIwbmdiN3dyOVN5VHo5UktOWm9jeXM5aU1C?=
 =?utf-8?B?UU11bHVaZjBmKzZhTUZxSitEZk8yS2RleHpRbGZ5U0xVT3NGYkhickNCV1BV?=
 =?utf-8?B?TjVKVk9BaCtVN3ZsUzFDNVY4NTR5U0FqY2IrVVdrVWtDa1Q4bmlQaW42YVZ5?=
 =?utf-8?B?Ty9OaGF2czBKcFluTjViODNGNkM5TGZ6ejFQWEZiOThOUGZuMG1Xdmg0KytU?=
 =?utf-8?B?M0t5ejExUlZTeVQwaWJkUThQdXRlVDNwa1VJNVhmNmE3UmJoVU02bnpJdHN4?=
 =?utf-8?Q?MMmX+ObWHbJ3lLv4=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3413c97e-e101-4636-2f8b-08df284b9615
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 10:28:41.7310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqxbzycS5u4guc6nR3JGbjAjKTem7637pzJeeWtvugmRLtv4kBUBDa1UjpJcp8dYL2xO8y7vog6KcwWNcAQwwz7bRqrk0b7VWGGbX3qLwaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5523
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
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

Wrap the set_owner/reset_owner backend ops in dev-level helpers, matching
other vhost_dev_* wrappers, so device code can take or release ownership
without reaching into vhost_ops directly.  vhost_dev_init() now uses
vhost_dev_set_owner(). Both return -ENOSYS if the backend has no such op.

No functional change.  These are used by the following vhost-vsock patch to
hand a device between owners during CPR.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c         | 20 +++++++++++++++++++-
 include/hw/virtio/vhost.h | 25 +++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index dfdfd49da3f..56fa4345886 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1703,6 +1703,24 @@ int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
     return 0;
 }
 
+int vhost_dev_set_owner(struct vhost_dev *hdev)
+{
+    assert(hdev->vhost_ops);
+    if (!hdev->vhost_ops->vhost_set_owner) {
+        return -ENOSYS;
+    }
+    return hdev->vhost_ops->vhost_set_owner(hdev);
+}
+
+int vhost_dev_reset_owner(struct vhost_dev *hdev)
+{
+    assert(hdev->vhost_ops);
+    if (!hdev->vhost_ops->vhost_reset_owner) {
+        return -ENOSYS;
+    }
+    return hdev->vhost_ops->vhost_reset_owner(hdev);
+}
+
 int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    VhostBackendType backend_type, uint32_t busyloop_timeout,
                    Error **errp)
@@ -1720,7 +1738,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
-    r = hdev->vhost_ops->vhost_set_owner(hdev);
+    r = vhost_dev_set_owner(hdev);
     if (r < 0) {
         error_setg_errno(errp, -r, "vhost_set_owner failed");
         goto fail;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index b2b644c0d1c..8127a9a5a2c 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -178,6 +178,31 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
 int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
                            VhostBackendType backend_type, Error **errp);
 
+/**
+ * vhost_dev_set_owner() - take ownership of a vhost device
+ * @hdev: the common vhost_dev structure
+ *
+ * Issue VHOST_SET_OWNER on a device that has already been set up, e.g. to
+ * complete a CPR handoff on the destination, or to take the device back on
+ * the source after a failed CPR.
+ *
+ * Return: 0 on success, -ENOSYS if the backend has no such op, negative
+ * errno on failure.
+ */
+int vhost_dev_set_owner(struct vhost_dev *hdev);
+
+/**
+ * vhost_dev_reset_owner() - release ownership of a vhost device
+ * @hdev: the common vhost_dev structure
+ *
+ * Issue VHOST_RESET_OWNER so that another process can take the device over
+ * with vhost_dev_set_owner(), e.g. on the CPR source once the VM is stopped.
+ *
+ * Return: 0 on success, -ENOSYS if the backend has no such op, negative
+ * errno on failure.
+ */
+int vhost_dev_reset_owner(struct vhost_dev *hdev);
+
 /**
  * vhost_dev_cleanup() - tear down and cleanup vhost interface
  * @hdev: the common vhost_dev structure

-- 
2.47.1


