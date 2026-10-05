Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06213CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:03:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDkCM-0008Kk-OM; Mon, 05 Oct 2026 11:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkCB-0008Iu-AZ
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:01:40 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkC9-00056n-0h
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:01:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w7UXS/GkfJ8Hyrv3Vme9V163XTajd6VKOU6dEzyVBPkYmpLTMNEJGPVItQfEH6YaOTEnjeKMwCrg5HZZk3ImmuxNcD+bi2MKvrh5X+NcXA6oIJqU3QnDho4Rc4uhmwSXZTCMbRaI24s2GFsO6WkOekJzzS/+7aGhNF45rSQjjtiXUL04iLGhYDDK08lBt34VKT6rOrMxXPBCsTJEr28fjRyiqI0+7J++qSUN0PsewCCL1k9oOvGLdnUIRTF9n/2RUYQDXPrWRHEVqyE7r573JFzSrth+hbB1ehYXQvb0MsdtEXL8omzjI8jUFgCjTsmH0WHhuRAvdRgJ7v4NXYqd9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQgnkcViSHs3Rahhzmph6ktL2+UOz0MojTzm/dDNgZA=;
 b=SnmUzuIDXfYQhsRiocQemlZB13n5M5WHyEg1V5++Cue4QCoxddx5QsSY2WeDs///PZ1XKIm8qm7fthLY/ynjq4LmD6QpkdIlanOaCgx7ZaQHQ12Mfjuo2uCD/T2OoadJ+EH797LB7jAs84nHOI1Y1Ic524MjE4l/lzTybNO5yQXMS6NRTCja1VELlRVzDz6bHdHB+nq58rc/Xbbl1LtP6SGuanoPMYaY7RH+IiAqutJWjHHD9RN7BzpZDi1aenIBFOy3/jIOJjO/M0Xm/qLaerkXWU0xyri4Q3IvZYX/eYPnlCDq5vbO/efnQFwO5mFR89tCVNeD4qV/EjO8Aaa35w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQgnkcViSHs3Rahhzmph6ktL2+UOz0MojTzm/dDNgZA=;
 b=nAWWeyv2FJ2bokvQUCUnue06h2CiNlUD/Rd/eqcxzFOfrSnRWcDrrB70lBPz1Ni3O21iwGlMHx692CdRIYVJsHDAt9mFcYx0OEpCebwLRSGvkea6joU8bRdTQYKpsd9lsQCMcP7CQgbKgr9nG672nAEj9OUagM+C+OU7NWT9oMUvpkb1BF39C7X4elYl/jjkkrA0zHWMgNr9FONMAeXNQLRGn6jQSLxxmeN4LNoSmyq2DzZplUg3hagXht13N4Qo03J01qiLPZQb5poqY7gUBor8S1Tr7WCcoGaqZs8EP/jKavddUJhXU+Eve1/9X34DUCE8HZ2Nw8vzaMsFvF5UBw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAWPR08MB9736.eurprd08.prod.outlook.com
 (2603:10a6:102:2ea::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 5 Oct
 2026 15:01:24 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Mon, 5 Oct 2026
 15:01:23 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 05 Oct 2026 18:00:53 +0300
Subject: [PATCH v12 14/21] vhost: add vhost_dev_is_initialized() helper
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-up-vsock-vhost-v5-v12-14-40162390c68a@virtuozzo.com>
References: <20261005-up-vsock-vhost-v5-v12-0-40162390c68a@virtuozzo.com>
In-Reply-To: <20261005-up-vsock-vhost-v5-v12-0-40162390c68a@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: vsementsov@yandex-team.ru, clg@redhat.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 mark.kanda@oracle.com, bchaney@akamai.com, mst@redhat.com, 
 sgarzare@redhat.com, peterx@redhat.com, philmd@oss.qualcomm.com, 
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, den@openvz.org, 
 dwmw2@infradead.org, farosas@suse.de, andrey.drobyshev@virtuozzo.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: WA0P291CA0014.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::19) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAWPR08MB9736:EE_
X-MS-Office365-Filtering-Correlation-Id: c1e8392b-9d9b-4bf7-05ea-08df22f18544
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|1800799024|366016|23010399003|376014|38350700014|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: pP/gM2JZwZPF8CYKcWUxXiD8/kXA1RCHx7Q0iCY7C2UkKweNPWxgQwEMnUGoo2/imB2RK2blz09JN1oxr1GI410s+JqzSWP8P8RwY8ex+uZo403F4v3WMG79HXKzbyHFKj3JX6VoMtouvlBmveBpgRtJUTKI55mbV69AFg0g8Q9WDBOD6V7WekxT0PXNMh8YKdJRriKjiz9tUMhCjZsE4NrfIkxF7qtFjKnF5VVAHy8LZJP13X5x9t3o4H2TPMTaG3VXn76ZaOFVaWgkSLMZ2KCmnroqZl+B8wZ8sT4cJlsIAXeB+qeDPI5gByPp2ly8EW42FrvIHpi1F1ThpQZdn/TcHjaFLe0FUu/DPP9WC1IwwB5qZGdLUXat6zd5WPFrqxpobHfjJtnai4A69MjNltobEKs5urEq0xhKUdJkzMRF5wClTyA8jKliIo5d3Q8/TFV5R6vnNXRosK+3cNyCuv6V3z7pZm4vTOWbZOr0fAV4H/wX8d69BGgfmqkP5wlmuDZUi06p3ZpsNy+o9ViN7SGjfYb2PTA/wVQ0d5tQRZlLazz8Ucp1D3gQKlrlBsevDf2FM8JC9HFhG7Ba4Xmp1tUgSNhv8c+ZkedCs/IVuBeZtMrXRHq/ajphVSUEp12W4AewBO3Y6Ag9fAWQ2uqpk3ZYdNllv1HXHNId69U/jD3kkD9R3eiT4ABzBWMG9FAlBHh0RiDB0YWpG4tPgUz1GwqZgTdugr3/BWTFU7hTNBo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(1800799024)(366016)(23010399003)(376014)(38350700014)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2tqTVl6c0lwcmlvNW1OUXo5Vm1lQnRrSkFvTEgycHlGMW1tclhKOTZoUE9L?=
 =?utf-8?B?d2FaaFFWOGpzcDg5TWwrRFI4MWlyNWU1VlR4akVSMjBoUzVqS3Z3ZjlkTHd5?=
 =?utf-8?B?QjBIdVplTGxlSnZ2WUlrV21VNkF2OTRtZzFNd2wzNjZWMzFqN0lvblp6d0tv?=
 =?utf-8?B?TjdRcHA0WE01TXRKWXVlNDJJYzRwNktoUWxiYjNWbnFsUEVyWWdRY0pWaUZR?=
 =?utf-8?B?VHN1QmRvdkEzdTFmRGphcGlneUFkM3RpVDR0Q2RGbW4wS3FIUldWWkRnb29n?=
 =?utf-8?B?MURkQ2ltZDlKcE0wOXZBT1EyQlVHZ0NnVXRmalJkSngrRlZaTXhhRmtZeG1w?=
 =?utf-8?B?bUtMNmpOTWtmcWxXRmxnZ3NtLzlqUHllekRySGNaSjUzZzZFY3FEcWlUQ0Ex?=
 =?utf-8?B?YzZOZFJVVklZL3VZOEVHYldjNFVJZllHMzdRcWFPcWdhTnFKSVRNTmROTkhH?=
 =?utf-8?B?dTNhcjNJRk5XU2VuYXp4N2V1Qm5UZjBZVTUyd0VDWHNnMjZtck1hZUNnbkVa?=
 =?utf-8?B?N2hMR2c0UEtUejdMK0Z0dWVXMUxTU0w2WTRybUtYK3lDRVEzc013eXNZS2g3?=
 =?utf-8?B?YVl2NzRvajRKWUczN3BkcVhVbGJzSjYwTS9oQi9mNS9WTitHbXBIaXgyMDQr?=
 =?utf-8?B?MjNydGpPYkNsYzJDemZxM25pN1BOZkRVakFWbUFiOEx1NWt2ZGxGamVhc0hz?=
 =?utf-8?B?ZUtJNDcrMDlZUi9yYmsyZ0d6U2w5U2FmOFNpbHhoMURsMWI3aStVa3N3VDh0?=
 =?utf-8?B?QUM3UFpFMWFWSTRZUzlaNi92SEU5L0tJTjZtQjdVNjlkbHk2USsyYmJPSWww?=
 =?utf-8?B?MksvVjZiWm1tdHAzUEthSVoxZnJNQUZSZFJ6ZUl1cytLOURKU1phSGIzRzZy?=
 =?utf-8?B?Q2RUbUVKVE9ldm40S1lCcTkrMnlGNGN1WGdhOFZjR0Iyb21mWTRPQzY4am5K?=
 =?utf-8?B?WDYydk5PNzdNaWRoOFFudzlHSFlWRlRtcCtsRUlGRzB3VXVVc0lPM1ZhUzY4?=
 =?utf-8?B?MmVzNU0wQVVKdjJRdk1BdmNuaHBHWlVwWW9qTkFwclIwdWJlcWp2M1dkOXVU?=
 =?utf-8?B?SUE3UTA5NWpCL0k3dzllMnpaU0tTc1dUOWlVRHdwc3VhUmY2M0cyV3dRb3dX?=
 =?utf-8?B?cnlheGorZko2Vjkyck5kaHdwUWlwZjFDTFgzNW9oNWRmd1RISldWVzNlR1Jp?=
 =?utf-8?B?bFdnUFJHRHRxREMvd3hNeXRsUjBRNDhHdy92bXVHVTlLNldxcXBjRnlSL1R1?=
 =?utf-8?B?bHRIRVNzSUh0NllCSHZHUm4vU25OZFAxZHJJQ2F5T3RBcXlLRlRXZVpiamQ5?=
 =?utf-8?B?andremR6blZGOFZ3TmlCVGlSOEFXSzV4U2dxRjljRGNNZ1JybXIxVFpqbG9R?=
 =?utf-8?B?dTJ3NDZFTVI5MkxiWkdTZ1BQVkhkb0tzNllyQk5lZlNsdmx4SWdhQ1M1U2xo?=
 =?utf-8?B?RXU1blV1em9hUE02djNtcW5ucmx6M0NyYThBNGpLc1N1L0gvSWp2RUJQczVN?=
 =?utf-8?B?bkhWeDdOSUlUUzdqdDd1Y1Z0aWtBT0hQS090cDkrQVNYcW5yck5OR3A1SVk5?=
 =?utf-8?B?TmdTc3VlSmNsZmduNE1pckVqRXFOd1V6cjZiZjl6Z1lRM2FJSHRrNVhrV1lr?=
 =?utf-8?B?dDdtRGk1R29zdzU0Y01ILzFjcTRiR3hpdWV2M2RudnhXOUhnSUNzcmViL1Zm?=
 =?utf-8?B?Z2NDRStnaS9DWTMweC94RGlRYkdzN3VKU1huREdJb1VTM1laaGFRUGh5dEF3?=
 =?utf-8?B?K0tlUngxRTNVVXBvYVJsdnVoM0VxQUduZ0ZENlQzdmNWTXFHTENSSGR1RExV?=
 =?utf-8?B?bXJVcXR3R052L3pLK1BCTmkyUnFVRmVxVU52R05qbXl5dFM4TEFsRkhLOWlu?=
 =?utf-8?B?OS9idXIwUmNIOFpkRHQ4RUpaSXRNUlAyakV6SElLS0NYdXpTZ2trajJkbjFX?=
 =?utf-8?B?QWxuOVpLTXFkODZCMC8xMlM4NHYrWG9oODFHNGdFM3JwdWExKy95N1JpeEZw?=
 =?utf-8?B?cU9qYWtxckcyZThhWFlTT1NJZWQ3ejhVVnorYkplUnQvWitNMVRrcDY2Y0ZH?=
 =?utf-8?B?TURtQlBwN01NeUpqWGRRVEpxd3lnNW9Gc1JBMzh0TGlURzlSWmo1WGtyM0xE?=
 =?utf-8?B?NkxXYXJMazB0Zy9mLytwU0FqU1lSVW1lSzA5Tzc5bVcyaFplaWZsZmdncmFx?=
 =?utf-8?B?NTd2Z2ZSUkJyelJ5eUNNNDFyclh6MUg4aGIrR1lvb2RsbngvUDRlajdFTURs?=
 =?utf-8?B?TEh4OVNPTTJrWlR5MEtJKzlBM3VYWGJ1cTVhZ0NXL2JTTVdCOEFOYWVzSHlu?=
 =?utf-8?B?MXEvcEpyMmdXbHBYWWFrUzltMnIrMUJVb2JpdDAvSGdaN0ZXMVQwY2FXNzlj?=
 =?utf-8?Q?D+evDzK6iHd2Oigc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e8392b-9d9b-4bf7-05ea-08df22f18544
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 15:01:22.9484 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ipN8ktdtLabWtLQF4f6IdpLAeHwQzS3xAJ5sbk5+y1KjykwZirchtM2Iq+jCy54dxi87D4Kq0Zanf0kxWdNA2SElmSUDF+B5c23cscqVf0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9736
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
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

The upcoming CPR support for vhost-vsock defers the full vhost_dev_init()
to .post_load(). On an incoming CPR .realize() only sets up the backend,
so we need a way to tell a fully initialized vhost device from a partially
initialized one.

Add an explicit 'bool initialized' field, set once vhost_dev_init()
succeeds, and cleared only in vhost_dev_cleanup() (by memset(0)). Also add
a public vhost_dev_is_initialized() helper.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c         |  2 ++
 include/hw/virtio/vhost.h | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 56fa4345886..c01ccc800cb 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1834,6 +1834,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
+    hdev->initialized = true;
+
     trace_vhost_dev_init_out(hdev);
 
     return 0;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 8127a9a5a2c..73ea130d7ee 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -109,6 +109,8 @@ struct vhost_dev {
     uint64_t backend_cap;
     /* @started: is the vhost device started? */
     bool started;
+    /* @initialized: has the full vhost_dev_init() completed? */
+    bool initialized;
     bool log_enabled;
     uint64_t log_size;
     Error *migration_blocker;
@@ -248,6 +250,18 @@ static inline bool vhost_dev_is_started(struct vhost_dev *hdev)
     return hdev->started;
 }
 
+/**
+ * vhost_dev_is_initialized() - report init status of vhost device
+ * @hdev: common vhost_dev structure
+ *
+ * Return true if the full vhost_dev_init() has completed successfully
+ * (and vhost_dev_cleanup() has not run since).
+ */
+static inline bool vhost_dev_is_initialized(struct vhost_dev *hdev)
+{
+    return hdev->initialized;
+}
+
 static inline int vhost_dev_set_vring_enable(struct vhost_dev *hdev, int enable)
 {
     if (!hdev->vhost_ops->vhost_set_vring_enable) {

-- 
2.47.1


