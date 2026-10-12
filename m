Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DEFACA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:31:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGDHg-0007tm-1G; Mon, 12 Oct 2026 06:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDH3-0007d2-Io
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:29:00 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDH1-0005FA-Fz
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:28:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DAc9RGPfz89ZMohv2F+uZhlQn7fzJ5AjAVv34MpA8xQ6E4x5lVt5xIk4nHOkvi2lwG40jjZLjWG49cielnac8HqV8Csn4P8Qe+3LPvgNvXY6tmAJpkgCbnxFv+lxt3JDbWi6W9u8U3WI+vbFMokcpGcwOCrHS3sBOa6kE2K7kj6255U30sqjlQXDFyP/JlZQmSUJUdWF+ert4wFrvaXZd6GGqT2BR2VCrVMlUKnTjnxzp48RZqjg01tn4SGDKz4j0x8E9G/6z/icN02zpDo+KxEgbTZFeZbXj8rC39+VP0iTK/UcLgRM7tp1bTj6UJal+yrlJitLIqfhlD/WMMivMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pI2kEvdyqWo2h3cBz00/awDb1Cv0bW/IrdoDs7geeFM=;
 b=e68nxbtMnRVP73D7BzyM9/ZSVPTrpXc/7syw4/zywMDAOD8Iprn7VoSMfZnG5MBBj5zGSiV+2TDXXkGTHVqLSduGOPtu9CJp5+D5d4QOszxE9fSqzYEu0vJmQ82eqEziTNiEXOYrIfgIYFh36q6CggtJBXP+Ema5BIYhUT3gSJUnd7N7EU/0kuY+yG2olfD/nusYivgkhw2299NZCx/BDYlpOstJeyshzKz1xBMn754mQE9/cw1H9BR+ENTxxXdMkOm2HV5IGGAazbunHom171lrG066mCYJGiE/amUn/eIMbN59GWMlw6O2lj7QCWngKdw+ZL31u1jSotI1TirThA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pI2kEvdyqWo2h3cBz00/awDb1Cv0bW/IrdoDs7geeFM=;
 b=mWTzSn1UyK4Dfbnwh8ylA6pZ6s02WFZoF3558nVwNx9sw+/wH5OeJ77+dLyO0pVorbkjrIh+ZO2xDAmEYfzYKVB/bIE3Q0Cufyi5j/rsNPLNKgjwbn6W8DxqtPwEJqOGLWg/XG3ZbnCUPaBhndYOEnPjLRBeXezuDNBsHm6MTTB4OV7skW4hQ6k4VIB8pTQYpplUGIH8OozW0gZGCC+kjnsEh/Myzf8ZBymMr2hjm+Sc+uuXzkkTFwK2lwLW4OWF85iV4cOWt00YRtntFpLZCLcqx0jiMaXy/JHxqzmmuhyqhYD6JAd2JUwuDmVZtURkShBOlD6wHgoWrE0fE354rQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM0PR08MB5523.eurprd08.prod.outlook.com
 (2603:10a6:208:17f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.11; Mon, 12 Oct
 2026 10:28:37 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0522.008; Mon, 12 Oct 2026
 10:28:37 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 12 Oct 2026 13:28:15 +0300
Subject: [PATCH v16 07/22] vhost: add vhost_reset_owner op
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-up-vsock-vhost-v5-v16-7-36c38bd15ffc@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5277a83e-b075-4822-4fe7-08df284b935e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|23010399003|366016|10067099003|22082099003|18002099003|261009223027099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: wGJSTGXqzKqiGyqJs547xetWP63TJXsLXxLWZtPrNW/s1ex3I3mRtLoj3Jmpqse2mvItYZt8WEUr0+mdojiZ5idlMrBvjnmsoHysRznmKcneGJEiX7g5yqIsKMES3G/+qcZBZteVl+EW40FnvVDynX2XzH4y3Iud8sS9xYActjuN7kZZv8QwiDty/vMuHfmSyJhayA8o9fsxFl7qtTJY3OERKTefdlFzxlpmi16GM+ilMjeP4tE+tLuxqvK5D1Wy0Iz2S/3a4Urt44jmCrv65TqCChxw4vZzDq2RH1z0fg1CfDBM0QLAnVjCOkMFSK5cCAPIPPrL3aY4cRjgdg8awnwNAhgYWtoqbL/8JHVHPyfabYABAl7gKZy8NWR/SueQ/Aqt7YDW7t5Bm3ao+yZ60KcGPjCdE4tkr12hK5C2mvZMEEsqinBzTinMMyGQ1bWmFE847vtf+3CrXkW0TTi8Z+P2/qHj5Lh3qUDQpRXvRSglqle52QoqTFtlqFrVPrW05wOC8to/LCbFZdvqW8sRtWxPntvqDKrITTi3Y6COTJBb+MPItwCz2Z+YCyxTW+KYuXc9IO3gzHLxz03pSpYVYmvCQy3s9/B31Ou+NBtNndh+d6v1vwMEAJjtIkRybGl0cGaalOUfsZjnFGIkfS07evD3HcUkLjQVUfg/rfdXnZy2xiPrRhAKfB5ttXMxg5SvWv2BxQ0Qj7eUd6RGrB6sUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(23010399003)(366016)(10067099003)(22082099003)(18002099003)(261009223027099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eU9zR0Uyd2wzOUNsZU9nNjk5RjJVYWI3bzh4bGFnaUtsOHF2aWdxMm9SdzlU?=
 =?utf-8?B?Yzl2ZmlNNFF5WVRRcThDVmpHbHR3ZnM4Ylp2NW5nUmhRWDZvcWwrVVgvMUNP?=
 =?utf-8?B?enVPbUloWk0rdEZybXZybXIxcE1lZzZReDdjMU1KdzE0a1dtMDdQeUg1Tjg3?=
 =?utf-8?B?VlFyb0hHdk1OYzh4ZE5wQmlzQlhsTmFIY1Vaa2dweGc0NnVLUnZQTFpQUTVF?=
 =?utf-8?B?OGlSMHdiOGRtall3TlVWeG51UFNZVWNSYm5Udlk2OGl5YXdUVFNMbkF4Z05R?=
 =?utf-8?B?bnhyUmxzbHNhWkVMSm1ISmtNY3F3YVk1S1JlaFhSWmo0Sk1LTmM3clAzamNB?=
 =?utf-8?B?emtMS05Vbnh3UnFCRWxtMGV0eXNDK3A3dXQ2THBRR0d5a3dUNzR0Vk5uQlpw?=
 =?utf-8?B?WDBpTUVRUXFnV0E0eGxnalVER0hvZ2RTdUNna2JmUEE1UnQ3S2FCKzZyZVln?=
 =?utf-8?B?SDVpaUxFWmJucHJ2Y1dtanc2T0pBTGR5RTlkQ0EyaVphZExZYVFISkRZbzRG?=
 =?utf-8?B?SWRsWE83TFJwbnRUbWZYRGpaR0ZzQW1MZ2RZazNJMmxZN29FdWR1bDQ4VlJP?=
 =?utf-8?B?T1hmaHRDSW9NRzdocEhneTliT0plSDdreDZyRGNaRTQrVnpWYjY5N0dmK095?=
 =?utf-8?B?Z1FUaWRIa0NDY21WSE5DVFBtWlVmSnBBaTNxaGtTMlhzUzJMdVlJUWRWdGFm?=
 =?utf-8?B?OEpON2htUTZRWkw4ZFZ1YTlDMXhKTnJ1YlFVVjlWZlJIdTU5VVc0ODdCSjFi?=
 =?utf-8?B?UGdIS0lrZStzUmFCTFljaFoyemJBWWYrTXlvaXRSQVY2VmhMcGlzU0xyNmdM?=
 =?utf-8?B?TEN2WDVTdkdrR1R1SlR2YkdZV2hOTlVWWDM4aFFEbDMyK0NrcENKcXU1MGlX?=
 =?utf-8?B?cWVGdFk3Zldic1d5N2xtV0YyWlZSTFJ3akxqdTYzTmlrNHJIcGU2MlZaakp1?=
 =?utf-8?B?OUpHWTBNOXRZbnVzTUdRVlhiT09yd3Uzb05ENVk3a3JTa3k2enpmd1Q3ek5k?=
 =?utf-8?B?SmtjcWoxT3JUOWRwVkpOakVCc1NZL3h1eElqWmQwazNTZWVmWU8rMTFZWmFE?=
 =?utf-8?B?MXl6VFRkNjZxaFNJOUtmQ083L0RzVEFZSkdsWGxoQmtWVHVKR1A2a1VKN1N4?=
 =?utf-8?B?TW9hamIvNVNDQmlJWU1XR2pEM3ZXVS9CbGk4eGt6bHFTNlI4NVExWG1MSGg1?=
 =?utf-8?B?azFRaWtGNjVrYkVMRk9LYk0yWFpST3J5ZVh1UFZWeGl5UVNlUWlJeFFHTjBl?=
 =?utf-8?B?VUY0TUVzSXpEaG9SeVBnc29pZ2M5UzJOdWVOQWZGS0hIbmY3VDR6ZllLdmtG?=
 =?utf-8?B?RzlIeFRsL1YwMHJKQjVUbkFXUU1GT0hieVNrcTVScFNoTzZLNjVaVDZ6ZGdL?=
 =?utf-8?B?MHhQcUZIUGtVZVdXaHZvM05XbE1IemwvREE5T1NwNDU2WE5EQ09jVkRWekVT?=
 =?utf-8?B?dDFYbXVSWjdsdEM1MEo5Ylc2QndCaTh0S0EwcmFzSDdrSUw1THJ6aThyOW1n?=
 =?utf-8?B?ODExVVR2cDhCTnRaaEJ5a0tYR282MzdmZlhYVHZnd3FWMjgvY1cwWVVreVBm?=
 =?utf-8?B?elVVS3Y0Nkg2aGtaaGZUS3Q5ZjlKZHZsT0RUNEQzRDhTUml4cnBHdTh2YUhE?=
 =?utf-8?B?QmMrZ1lYNTc5QTJKZUVYVmtUSjI5YXhFNlJDazQ1UmE2MEFkbXVwdWpqYXNz?=
 =?utf-8?B?MmlhQ05DRlJ4dHhpOThSQVI4S0k1b0FXTnZFVENuZUtNK3B3RjVNUVE3OWRR?=
 =?utf-8?B?SS81Yy9HSk9OZjJrLzFWL3V4ckRXSnZ5UUlBSUFoZW9WMWhQVnh5RGozaGFp?=
 =?utf-8?B?aGUrM1FoU0J0c3RFcTBidkRQVEFsbWRBVm03SjRldmQzOG5JejZHcVA3ajdQ?=
 =?utf-8?B?TGtsZWJBTkFIRlJYVXFOYWlYQjF5WEhJMnQzRkJaY3lEMzVsbEJWRlRBR2Zi?=
 =?utf-8?B?VHJxRXdtTWFpeER5OFR3d1l5N29lV1huaEY3ajFDS0k0aEFSbnU2eFZHcHBP?=
 =?utf-8?B?OWp2VVZWSXUyT0V4d2Jabk9JQ0kwc0ZJRXhuM1BNRE9tKzFKL0FqK01uWGJO?=
 =?utf-8?B?bjNZSnQ2MkVUbklKQ2huT1NHaml4eUh3Qk5NcnlrNzhPK1ArR2FnSXdZb3Ex?=
 =?utf-8?B?WjZTM3BqSDhKbkhCUk9XdUZReFBPZ0RwNUFVUkVyMXZhQm0rTGRFeER2bUcx?=
 =?utf-8?B?ZjN6N1FWZkY0eCtMbTF6Zi9sU01Jc1B4SDZnYnlFcUx5WjdjZE92cmNzMXQ5?=
 =?utf-8?B?S3RBbkQvSUJzZEE5Y2J1YzQxOFR4Q0lxTlBzT0trV1lsSmhVTlEyOU5CaStx?=
 =?utf-8?B?QUtDOWNJRGtHQkV6WVI3Vk1hVlBKbGd1Y3lFOWhZYlhXR0FSNDROUGZ0SGhF?=
 =?utf-8?Q?s1KlK91+ZCEUl/gE=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5277a83e-b075-4822-4fe7-08df284b935e
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 10:28:37.1715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vxuf1CALWp17WRlbtm0bKsh9b2zLhRSyVvtwkUo6xCACseOrzH+rvZRfPIgVJydeYGonZsmEHHB5/398oV2NQg2+AU8EwOc7ruFkfpx7Rlc=
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

Add a VhostOps callback issuing VHOST_RESET_OWNER, wired up for the kernel
backend.  The CPR (checkpoint-restore) path uses it to release device
ownership on the source so the destination can reclaim it later with
VHOST_SET_OWNER.

Originally-by: Mark Kanda <mark.kanda@oracle.com>
Originally-by: Steve Sistare <steven.sistare@oracle.com>
Originally-by: Ben Chaney <bchaney@akamai.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-kernel.c          | 6 ++++++
 include/hw/virtio/vhost-backend.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/hw/virtio/vhost-kernel.c b/hw/virtio/vhost-kernel.c
index 3390b48c6f1..55d316b88e9 100644
--- a/hw/virtio/vhost-kernel.c
+++ b/hw/virtio/vhost-kernel.c
@@ -261,6 +261,11 @@ static int vhost_kernel_set_owner(struct vhost_dev *dev)
     return vhost_kernel_call(dev, VHOST_SET_OWNER, NULL);
 }
 
+static int vhost_kernel_reset_owner(struct vhost_dev *dev)
+{
+    return vhost_kernel_call(dev, VHOST_RESET_OWNER, NULL);
+}
+
 static int vhost_kernel_get_vq_index(struct vhost_dev *dev, int idx)
 {
     assert(idx >= dev->vq_index && idx < dev->vq_index + dev->nvqs);
@@ -385,6 +390,7 @@ const VhostOps kernel_ops = {
         .vhost_get_features_ex = vhost_kernel_get_features,
         .vhost_set_backend_cap = vhost_kernel_set_backend_cap,
         .vhost_set_owner = vhost_kernel_set_owner,
+        .vhost_reset_owner = vhost_kernel_reset_owner,
         .vhost_get_vq_index = vhost_kernel_get_vq_index,
         .vhost_vsock_set_guest_cid = vhost_kernel_vsock_set_guest_cid,
         .vhost_vsock_set_running = vhost_kernel_vsock_set_running,
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index daa979a1aae..fb580aa417e 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -104,6 +104,7 @@ typedef int (*vhost_get_features_op)(struct vhost_dev *dev,
                                      uint64_t *features);
 typedef int (*vhost_set_backend_cap_op)(struct vhost_dev *dev);
 typedef int (*vhost_set_owner_op)(struct vhost_dev *dev);
+typedef int (*vhost_reset_owner_op)(struct vhost_dev *dev);
 typedef int (*vhost_reset_device_op)(struct vhost_dev *dev);
 typedef int (*vhost_get_vq_index_op)(struct vhost_dev *dev, int idx);
 typedef int (*vhost_set_vring_enable_op)(struct vhost_dev *dev,
@@ -205,6 +206,7 @@ typedef struct VhostOps {
     vhost_get_features_op vhost_get_features;
     vhost_set_backend_cap_op vhost_set_backend_cap;
     vhost_set_owner_op vhost_set_owner;
+    vhost_reset_owner_op vhost_reset_owner;
     vhost_reset_device_op vhost_reset_device;
     vhost_get_vq_index_op vhost_get_vq_index;
     vhost_set_vring_enable_op vhost_set_vring_enable;

-- 
2.47.1


