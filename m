Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 870FDCA5FBA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:16:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrJd-0000hz-MO; Wed, 30 Sep 2026 06:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBrJb-0000gy-E3
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:13:31 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBrJZ-00045p-NV
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:13:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LGfQdS6KhclCD9pq6FKkBdmWxyM6mjXA57vbGqMwbpFfuPQ1e658+3pS6ia25TvfxlIHjhcNTyG+Nc2LN7pqvxSwz9N5fIpNZ+wbNyzl4FWkUHjoaON9+q/GQaU/cf9ZSV2fhIg53fsiXztUP4Wy073rCHYd1yAoPrrfblVESFPTZ+w/BS+JMjAMT1qzjUoBNQF/X7sqtDCR2g85ahwINgIXrzcK9MX3QmaDJyGApSQjVZettfFhQrSbhf8BYtCcwqUqFOGt3JTUSlt6eisCL5Jq7Dd4LAtEz/T21V6QK/RRhJsRbudj2MKhlMcwqQOh77dsy8QDuRMPwLukC7yIBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pI2kEvdyqWo2h3cBz00/awDb1Cv0bW/IrdoDs7geeFM=;
 b=JVMncWu/62I1Bcxhqrw0K9dB3t+A/IpCvq+gBly4Q6/Tg01lofl/8JAPtM3+X6DCMn2ElC4GEOVetif9zfrWFZtVhR89ppxv3KjAraKvjdDMsZCbf9IawfR+Zl3S8WXnt8beKojIvwHlGw2DLt9u841KSXDxqHT2eZ1En2zBnzCBz2P0q2H+0XGFe1tgb0yH7aKf9LFsc0Jppr/cqjzOWsUXm0GJ9SaCWT83P5ufK/SS0ObknXwmAUM2yHUsqydGMv/R0BYM9eHn+ApLbAEJyjymY91b1R9t9KG8cqefznPDqAY+vxdg1X8pdXudSfR86oPySI/DqwXI+unh5aO6CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pI2kEvdyqWo2h3cBz00/awDb1Cv0bW/IrdoDs7geeFM=;
 b=SK1BkDUQ+QTSN5ObDvXGoxt2TjGBmqrw5NuyAZPBt76aKDFx6Otj9wkGLv5nga9wccuy3AehUvb9rz6hjLcdCr/Id6rsPsaRvAz1j1AJ5c+Ojc2PDZpXf+Bcsqi9tHnt5ikIAsPn0AGrlR/PabF/1z2LwOtfI8fD+giPO3DGwLe6rk5wUC52eA4kWTCf+72zEVSPLcVKr5xD9QOluoUeEUd9qXm1yOJqEYpUgTz6AagokcuNLdane0b/BDDTCkJR+3SNSqjzpNTYxQaSuA2Ib4va5frJtmvg8r0x6kAeFlKYDP303lzQf2Qm2eYtlAPwgP6MGrpsaVcP1OiC4RRgHw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM8PR08MB6420.eurprd08.prod.outlook.com
 (2603:10a6:20b:314::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.9; Wed, 30 Sep
 2026 10:13:21 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Wed, 30 Sep 2026
 10:13:21 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Wed, 30 Sep 2026 13:13:06 +0300
Subject: [PATCH v9 07/18] vhost: add vhost_reset_owner op
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-up-vsock-vhost-v5-v9-7-e9096f629770@virtuozzo.com>
References: <20260930-up-vsock-vhost-v5-v9-0-e9096f629770@virtuozzo.com>
In-Reply-To: <20260930-up-vsock-vhost-v5-v9-0-e9096f629770@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: andrey.drobyshev@virtuozzo.com, clg@redhat.com, mst@redhat.com, 
 sgarzare@redhat.com, maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, 
 bchaney@akamai.com, philmd@oss.qualcomm.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 farosas@suse.de, mark.kanda@oracle.com, dwmw2@infradead.org, 
 peterx@redhat.com, vsementsov@yandex-team.ru, den@openvz.org
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIUP296CA0066.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:337::10) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM8PR08MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: b3250a2c-df76-4203-715a-08df1edb7450
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|23010399003|366016|1800799024|10067099003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: 2NV6Der+yhd66sZzhJNm+GwAm32CnkX/emHMa4DEtlhDRAxCcYcfaAurgQFOvYBHLvtpt1eEXBuNc2jQ8KdzJwCcjaNkvc+qWLe9JZHGjYbtbk05oidUuMpu20BtMFQzEy8qhQqyGRTMtoJnQ7ae4PfBDVFn01kj4aadxz9YwsBVTAAD+zKR2lUygRl1ZDQHgSLnzYFvSvZ3ldhwOTuqA/h7Y4A2CwWNP2FKkHHgmFLJpm6in5XaDxm9JRgh5W4WxR1mxHzA6oCqtoNgbfwfyLMYOce8yTS/NLt9igmksk08tu2Tg+/nBH+5Rgi3dg6Xd+d8RfxkvUKx5SKbGzeW52UQPwnDkNgA7dz3/d93UxpfJFaKIlmYPGhJcWh+fzINDpA2VtW6CSWTGcHLV+XowIipXJCnEJs75b3m2Vs5KFqFMLeb9tc6i7Ks46Aic3zgLS4iFJ6HCyNKGy1QF0bzbvjQiY7GwHDQ309BANAxrB/GveFPgFUbkN81K1NOZFDJHdUqUx14GGRAaY0HdUG8hg0k0wY6cBNDM/5MNVCxa3S2a2ovhiu4A8VX1kxcxHeYe3ycPMgeerCd8LvF0cwNtywHMbfLV4kY+42Jz2bK3E8+sRczNABmV6L+LSl2Ev8HGGjpBu1p/O64YckVyyvyl4OAQduxK4ObIYFRm0Cs43OX0VZbEe+AHr2dQ8Jju06W6DPV6qAucDwNMApuzQDg0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGJYU1NOM3E0dStQbS9Dbmt6OUFDZkUySHgrOFRKVWFTRVM4UFY3aEdnNUtR?=
 =?utf-8?B?MHhDbG0zTTVwMEM2M0N0aUVNWEQ0OElFVHVRRUo4Mk1EL0VVcE5hR0N6WWhq?=
 =?utf-8?B?aWZTU3p1QmQrTUJVMkRWYVBDb0lFUVdCd1kxK1I0R2x5VXpQZlArSjQ1R2JI?=
 =?utf-8?B?L1JRTWpGeUhjSU93TklPYmcvWmNIN0lCNXB2RlVtRU1QWG1RRzM5amx3WnNu?=
 =?utf-8?B?UnhZUk9PcGorcWR2dW03TUVZU1NkL0NxOFFKcmY4YTlOaW0wMmxjWHlWWEpL?=
 =?utf-8?B?aWxTMXl3YjMvMGpFaWppb2RMK3pRTGpwc3Mzait6NG93TFhzMW41UmF4TkNs?=
 =?utf-8?B?bjFLRDNhWVkyN1hFdzdEbnNQOWw2eXFzWVBtVytUOHp6U3FDWGFicE9tbmxh?=
 =?utf-8?B?czU5bWp4Q1I3UGhUdVpmL0l4WDJodDE3TGhUWUp4bmpvdUpVUE1wTWNMNlNX?=
 =?utf-8?B?ejUrQ0lVMmFETlBoNW54dzR5RTJ6R2h1aHNURjdzdU5tcGRHUDFQaHNHTVdG?=
 =?utf-8?B?UC9SNUlDQzZ3SUdNTnkzN29MOTM2ZWkxWjM0S1BlbnlkMUtyaGdkMlpoUVpr?=
 =?utf-8?B?K1ZhOTFnUkx5alVBakpuRUw0VDFSbFZLYkgwZlRESTFLdWtFWndMYzNubldH?=
 =?utf-8?B?a1ZNVnpzcDRZK2NqaUU2NnlHZHM3T0RmU1lYcUVyUExkQXlab0VYT1BIODVO?=
 =?utf-8?B?K3dvYlE4WnFYVjkxSXNjY2NYT2graE5qSUE0Y3VJMzh6bFRIVlhOKzNQZ2dZ?=
 =?utf-8?B?a2hHZVJSQ21WVzZBaGdaREI4eXp6aCtDakc1U1VUSWNXblhja2FZUkFVYU84?=
 =?utf-8?B?ekJpRkFTV3I4R3NsYnZDMjR0aitzWDBBbFhjOFdrQkFVOUpnVlMxMVUwaG5Z?=
 =?utf-8?B?dXk5K2hWRC9idW1GMkkyaTMwWjQ5MzNHemZOcFY0bUdveW5uRTFMNFI1MitM?=
 =?utf-8?B?ZFZMV1A1YUI5L3NpblVHUkJrMlNQdXQ1YnE5bU8yU1JRUGkyell0N0R2a2Uy?=
 =?utf-8?B?VzNZL081MytNVzNuNGxhRlRlMXIrSmlSRU1vSkl1RTdLcUdHVjlQQkc2aWh6?=
 =?utf-8?B?Q0FPSUY5bXBhSzlQWlpaaGxEcTZuS2NMb1pzaVlhWENRNy9ka1JoNHZSSE1J?=
 =?utf-8?B?cVp1VVFIaW9XaHVQVVlxV2lYTnlsanlZMGQvbTVyd1F3cEY3Rmc1citLZ2xz?=
 =?utf-8?B?VFpvNk45TkJabTg5djc4akJBc2VKVVRqZ3RXQUxCZWlxWDhFc0JIVDB2NXVh?=
 =?utf-8?B?cmJsa3hXdkJkRUR4QmlraS9zbTB0S2VkejRZQ21LdEk0WUFoVFJwQ2RCNi82?=
 =?utf-8?B?c25kRkhQUzgyV2hvdUtKS1cyNUMwSjdXWGZZQ1cyT1B2cXhlbmJHbUYwNE5q?=
 =?utf-8?B?UlJadDI2RXp1S3hSR3RPVXRQQzNyZmVraWpJOGJlVTRqR1ZtTUYwSHlOb20x?=
 =?utf-8?B?M2Vvb2FIQnpkNjFzNHlIYlp3cXJVV0gxS0I0b0IvQy9BN1dlUTJFaW9BSThT?=
 =?utf-8?B?QWVvNEt6clhyem5Td1NmYWRUbTdrYk1tanRsak1IY1QyUWtSZUNqM2Nlc2l5?=
 =?utf-8?B?d09XQ09lNkNjUUdpaDVjLzU2VTdkQTRZTys4UXBCRG1RYnJ3R0ZheGR0M2Yz?=
 =?utf-8?B?SzdjbTljQjZ5NG5JQUlwMkljVGgxOWdyMkN3akE5anBjdE5VSkhLZHQyRzdp?=
 =?utf-8?B?RzJncVB0OGtpdDBWRERFbGJRL3hMdmRaQ1REdktsZVlaRXBMWkVtbDdJVnpq?=
 =?utf-8?B?SUM4QURYa3BFMzJjcXVYSXNKdWlLaGhoT3ZPRDdsakJVQlV0dk9PNnA1MHNy?=
 =?utf-8?B?dkFudnF3c3BZbmxCVW5NSjJBb1NmTzhHa2xqc0h1N1pjOFhVcHhNbEV2aDJX?=
 =?utf-8?B?Uk1ZcUJ4T0F4YThLUmk4UFVsWXBpQ3V5ZTNXMzdBUERpTmsveGI1R1hxdnh6?=
 =?utf-8?B?Z3A1MHg3RDNQVzZDVVBxSGNiZ3czUGIwWG8rMFMxZDJNRHRtMHRhaDNiR2g5?=
 =?utf-8?B?cXd1bzNTZjBhVEprSlBqVERNOXFrbFd5WGVPUmFUWU5vMTBtdlFwZ0o3MStt?=
 =?utf-8?B?WEl0ZFJVUkxpTGh5YWhuckJudVJMRHU2TFA0MUxldWRSelBoODRzYjhkdW1P?=
 =?utf-8?B?RkZwWkNCZml1WUVEQXpzdU1oTDJKaFpDSG9hUFU5YnFIS3ZiR2h1UVpQcVJE?=
 =?utf-8?B?UnppVW5aQWQrRWp0ZU02U3d1NlZHQmQ0SFVEc3JIbU1xNlh2N1hFdHphR3pQ?=
 =?utf-8?B?ekRDSzlXRjk4V3lDSmJ1aVdRSkpjRVcrV2x6UU1ZY0VLRVBvRERxMHJOVHlW?=
 =?utf-8?B?cEdJcGFTNy9xb2w2cCtpK2FHVzNvR0ZUbHNaWUl6UlFCb1YxWXE1L1UxLy92?=
 =?utf-8?Q?sZ4Dg5AqxSGburPI=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3250a2c-df76-4203-715a-08df1edb7450
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:13:20.9236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TZhdk1Z15ia5q/7LMLBa47HpAQD29neUdpMtUoIoiMz2yBfIGiauDPRded+r2FImmrsI8N06E8BpDOyYEfvzAUsZSteRrAQ8fIBVGHkYlgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6420
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


