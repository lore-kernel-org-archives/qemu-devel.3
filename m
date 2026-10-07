Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46317CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENwd-0004oV-B6; Wed, 07 Oct 2026 05:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENCI-0001LA-IU
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:32 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENCG-0006sq-85
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lr13eeWVxWat0qgyS8ze+WCnfiEP2TCFQsEb2tvdq6fUN5BuY7tkCr0DLUj+D9R6Ob7fDiPSyn1OYUNap3X5Bip/d6s6uE6k2A+JNDAzcLAnYiLnv2p2JrzLnNHjPTtfKyvDmZ2bOXJ5fTng6fk83Md4IVItkJsXdVdtB446awT1cOsqWKCaEyUE8F0owzT3fmYjqTJz/LLZoMYTpZ1z9ZLPKVXPKH0UOR0mYgCvBkAyCEOOyDT9hb1NCF9CvZ+PdHrCPBZ1qvWZdn2VcxLcuZQBoPmLaTVlo+WKQRQiNyCa40EqyKh3GeGUXSpMAi6KnNkHzyNUOeiew/qkMOriPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWXhh68le3RfUJjypRVq8x/GzIl/qjsOycrfUzYBtG0=;
 b=k2QXIBsLBEuMlVb+bfQTbsvFv21Icv9K2aBdoonvJm3toup9dprc95oIIRmEd1F7XEPk9m3sb8YwAs3pIUa9FmAvEsclOjhqyP/HAKil6t5Kfavb8I0BtudZIKnojSho/ToUPQSRPJVUt37CzgHyy7drwLhNJ7Q91hlbdq1Xjlm+qKdduvS5hFhvf03gfeilXwhCfZW4TnFHAubLskjjzTxrGNmKO7AOtnaevMCqlaVTvKMO6FXUh0K2yEJ0/MNPXbh/vn3LhEj66ms7Zi/fQcTyZ0qYFlAe/Sx7Zp2VWG6+VKoANsflD8wtGMrztxoy7IdRgY2mX6/9UNfWDQMI0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWXhh68le3RfUJjypRVq8x/GzIl/qjsOycrfUzYBtG0=;
 b=tt4nDDE78uwI2KtYuSg8Xpmjo4M37ViVXy0RZHTaWukxRlhr6I3xsuHO0PHs6SRa/rgheyVn2kjRSz1s0GdLoSojY9kYF5pHRPDJNW1s6YTzJvTQ0C+aE6IDI1iAGhpkZGP3DQ3fNvX9T752RsUlpIdv7NStVs6XaOAW51x+irwP5CXTzpbahxpLCKpLBnW5+9VTC2lVNf9maEdWuvsoc8r8jCjw3osZLqh3nmcVW0TmNIFlZYxLf8jg9Ej289INTZO1Ax4JxeVydJM2kg4+Yipc5z/yETTgRN1Cygn5K4d9QkLw/UHedqGaw2bxbw8Wtx4qFTa/uOFUtwvy8f5kyA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB3PR08MB9058.eurprd08.prod.outlook.com
 (2603:10a6:10:430::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 08:40:05 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 08:40:05 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Wed, 07 Oct 2026 11:40:05 +0300
Subject: [PATCH v14 12/22] vhost: make vhost_dev_cleanup() safe on a
 partially initialized device
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-up-vsock-vhost-v5-v14-12-e16de9962df0@virtuozzo.com>
References: <20261007-up-vsock-vhost-v5-v14-0-e16de9962df0@virtuozzo.com>
In-Reply-To: <20261007-up-vsock-vhost-v5-v14-0-e16de9962df0@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: dwmw2@infradead.org, mst@redhat.com, vsementsov@yandex-team.ru, 
 farosas@suse.de, peterx@redhat.com, dongli.zhang@oracle.com, den@openvz.org, 
 andrey.drobyshev@virtuozzo.com, mark.kanda@oracle.com, sgarzare@redhat.com, 
 maciej.szmigiero@oracle.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 philmd@oss.qualcomm.com, bchaney@akamai.com, clg@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI6PEPF00000236.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8ee) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB3PR08MB9058:EE_
X-MS-Office365-Filtering-Correlation-Id: ab9f5fb4-8a1d-42f5-3734-08df244e962b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|23010399003|366016|1800799024|10067099003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: N9tX5P4WWN65mXslrLiHM21NOglMVUzyTpHZScsz3qCPbgi0NEKrQBN0szgKruFj1vF7lJ4+TD4CgtaWXfZ/AFvCAGKK1Syf/8IdYYcQdLvHv1a5U+kcP6ptuC7h3L6Ow1C0amDSb9fJzPl1m4yhjX0JTq6jgVP7rr4Bvdv08LIFvqQfUXJM/FxbYblcPpwOL7BfSgXjDzxCUhd00LBOI3AUfQX9utocQlhzkDIJUpvDBxNcMSDtaxeudMgQC6LAJxwyqSX00Eq0OCEbZSKpsHACsOLXqiUGssov46phPfbpiFnH5Ujjfp64cORxEwW3nXdoFEQ4CyuVtg0UfpMpUWM/J2V44N1IuzBK9F8RZHG1OrzpnlvrJEAjByKF9lvODJIMPmZUyyFYVq1yKDnnkaW7MAYtkllZbMRqkneUvoQOqp+mjgFL8fSXjoBN6hQzaGwMfcerWzh29RSTp4LfxnA9uNY3oZd9UrVQ7s/gsDP5Ip4eCDD2RWeqsP3E9uJjzWUncJNb6jPxPI7GCLACpS+IK2B8h+Upus3BmgXw87ksOJ3OoDbG7bJlrGv4HNV98PaMYrcGer08tybhvBq72y0FSruphqe9FTatiDNEMEv2oSkqO0W3K1Xg2dI3K30hW44Yqar4lM5/S5HJ5vTKu4ya8QAVZ/F7GrdmVQvDRhH6wd2Pw2LlN2+uOUSo+05WSPTjhV7YteQBf7EfjTMPS3myioCTcFb2M+wLUzfsAqQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFZrZS9NNjJjYjBGTTVubUZzQ0N1eCtnUkY3YkdDajRrNzRRd0x2RVpYd0Zr?=
 =?utf-8?B?alI4dTI2SityNUFIYnR0Q2JKTmtrVU03cHRwM1JnYlVSOUkrcy9rQnAzVkVJ?=
 =?utf-8?B?K1lkeXVSUWxGMHpOanlLWGtNdXAzZkVsTHQ3SUx3VWdVczM2VTgrMVZyemtk?=
 =?utf-8?B?cThmc2RoekFEejlHYVFnODBsdGFTTkc1N1RRSHFpd05VMzdYZ0FKcTR5SGxH?=
 =?utf-8?B?d3B3Ymt3REJQa1lHQm1RSFBVTm1ub3U0RzV6VzVHUGJIL09vQlBrVXBPb01F?=
 =?utf-8?B?NXZydE5IeTRFMXBBQnUzTnBuWkpGN2pMUDlRY2NHYVI4Y1FLNFZnMHdSMUFz?=
 =?utf-8?B?ajhnaTRqeUpCM1JyMUNsRVJxRzQ5OWEzWVhydVBjMVNKQ3lBVHlQblFIVHgy?=
 =?utf-8?B?QVJ4Q0V0WkhQcnJBaFB4WkxvTHBuUnhMdkg2N1dFUkdDT0pSWDNPRnJTOFc3?=
 =?utf-8?B?SC81YURhYWFiWnFWWXRETS9hYU1KeG9JNXpwS1RHQ3QrR2MzbHlrWFVqMjl0?=
 =?utf-8?B?Y3A2N1puTndxdzQ1NW93MlQ2WjcwSW1FTGlnVUg5cVdKOG9XR1pNUDdqTDlk?=
 =?utf-8?B?WUZ4VWlNOGhpVVE0cjE4MlJ4UzNSc1dGekpmaUVXeXVQQ0tGY0pGTER1eHBX?=
 =?utf-8?B?MFhrU3kxZk80QWtUQzNLalZYdWluWDNaaTdkSG9zRjl1VWNzS2w5clFJVmZX?=
 =?utf-8?B?aHBhaFdHSWlmcjhpTkJXOTJaWWg3TFFuVlFMQWpEZmRIQjQ4SDJNTWVOUS83?=
 =?utf-8?B?OHNLSVV5cHM5cEo5bWo5dkpXR1piWlJZUHdkck9IV0ZUeWhzY1IzWUNEdXhS?=
 =?utf-8?B?cE9qbUNLemE1bFB4WjN4SmRTTUlhWnd0emdwQ1hCUEhmbmJiQ3hlTzFFOEd3?=
 =?utf-8?B?ZmFqeUtGa0p3SFRQVEo1N1ErUnpSNkNQR1NwSm4yUDdmSFN2dEhVZGo3aWtY?=
 =?utf-8?B?OHNyQjFxQUMwK2RSTFk5MTFCazRHZDN6d2N0UnpQK2gyNVlyQkpYRy9uUm93?=
 =?utf-8?B?R0tac1g1RCtuZG0wSDNkZEJkRHpLMm5XUS9xcnhjUjU4bERmUVBKdTNiVjJ2?=
 =?utf-8?B?dDRqQ0NyZnM0dTR1aGg3WmRYQ2dZZXhnQytnTzR4bzFmU2RyTzVJMkZGWWtH?=
 =?utf-8?B?YWVheUNvblJmaFpYZWdCNkVEakdRbHF6V0JNTXVrOFlTS3Q3NTcxMFBUKzlh?=
 =?utf-8?B?ZnJyVTQ1R2p5TlFGRmFOb05qaG1zQzBFSUg0aFJRWWhKeXNNNTAxckxJMHNl?=
 =?utf-8?B?aDdUdUJRWkdtVUhCWExRU1g4LzRZTUQrajVaUFNOcnc0djB5N1laOU9vNlB4?=
 =?utf-8?B?aTRxd2xFS0k2MkFQelBVNkNTRDJnL2s2OUVudjJGb215bWM5eEFJTlFvdzZy?=
 =?utf-8?B?Q2dmRHVIM2RBL1BrRGYxL2M3R3lTSUU3VnJDbG9SYjN1M1MxMXRtUVlsZkFy?=
 =?utf-8?B?U1FBYVVUdXVEMjlrWThjbUdaWlA4RkFMT0RTcXdkNkt5clhydTU5OXdxYjZj?=
 =?utf-8?B?eCtnODVsK3J5eWNoQ3duSjRlM2s1UEVKd21Md1cyekQzY2Q4VS9rek1qamll?=
 =?utf-8?B?alF3ZkJ0SGsrL2RkUW5rc0t0YkZJb09VS3R0WW0xZHUwbmFiN0NHeU9Fa3BX?=
 =?utf-8?B?R0JoSXNlTVg1c2xjMUVUeFJLWnk5N09XQUQyQ3hEcCt4c1VsQnp1NW91YldQ?=
 =?utf-8?B?ZW9XUFpKMU00dGdBRG1oVEJNUUdLYkFuZm9BVVA1UjR4YnMwTzRsNWJUZStl?=
 =?utf-8?B?dE9TWnNLdVZIdWtxdjVWOW5lbFRhOE5ydFhoRFU5cWxRQnlyMG9VNmxTcFk4?=
 =?utf-8?B?alRka3pUT3dNc3MyalR0SWxtaWR3UjhCRjhqODVSbUYyOGJOdXRMak5sUUtQ?=
 =?utf-8?B?b1NuNVEvMnk1Uk02VGErWkNwczlxYWhpODZ0MEY0WWNyQTRmckpqdVJTZ2kz?=
 =?utf-8?B?RFBIUGptMTkrVWlrS3R6a3luOTRxMllBVGMxUU40aGF5Wms4MEFNM0lHU2o3?=
 =?utf-8?B?UFRqZlZENldHWVJmTTBBVGswN0ZuSmMyUVNqWEpJT2Ryakx1UEhEdXQ1M0VT?=
 =?utf-8?B?OEtUbjVTb2hvMzBBSmFKVm83dmRFRnVOdjVSMWtCMnNFY0hlQXhjRTJzVHk5?=
 =?utf-8?B?blVhbEpJTEZtcnZJSmdTbGdkc3Y1Smx4M1ZrNTA5R2I1QW1VQlpkaCtUZ1h0?=
 =?utf-8?B?R2FaRThUczFvT0xIOU0rMzBhdVJVVTZnMStIcXBBbStiVXJEWWIvcUI4WGEx?=
 =?utf-8?B?NUF4VFhzNDhJN1QwTHFtTENjQnZaUXV4bEZ6Z2RxQUhKVURhSWtDOWx1ZFVv?=
 =?utf-8?B?WUpsaXo0RXQ4OTJZdlJlc1BnQ1pRWW56bW1SL2cwanRkdXV0NS8vK0pKeFBv?=
 =?utf-8?Q?+7yw7PXXg1glN1Dw=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab9f5fb4-8a1d-42f5-3734-08df244e962b
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 08:40:05.6492 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oPTr6FehJI134jiDZW21KMIHc0JwQIgK/QlpGUYlViVGKIQIsPn7X7xwNPd4zD5IHVncQgVaj+we1bA95P449vbhEIHDd0EkpdfIG8RR83s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB9058
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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

A device which only went through vhost_dev_init_backend() has its VQs
not yet initialized, so vq->dev is NULL and vhost_virtqueue_cleanup()
would crash dereferencing it.  Check vq->dev before use, so that
vhost_dev_cleanup() can be called to release a device whose full
vhost_dev_init() never ran or failed along the way.

As of now, there's no way for the cleanup path to be reached with
vq->dev uninitialized.  However after a subsequent patch adding CPR
support for vhost-vsock this'll become a possibility, so let's prevent
such a crash beforehand.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 99561ac5868..dfdfd49da3f 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1661,7 +1661,7 @@ fail_call:
 static void vhost_virtqueue_cleanup(struct vhost_virtqueue *vq)
 {
     event_notifier_cleanup(&vq->masked_notifier);
-    if (vq->dev->vhost_ops->vhost_set_vring_err) {
+    if (vq->dev && vq->dev->vhost_ops->vhost_set_vring_err) {
         event_notifier_set_handler(&vq->error_notifier, NULL);
         event_notifier_cleanup(&vq->error_notifier);
     }

-- 
2.47.1


