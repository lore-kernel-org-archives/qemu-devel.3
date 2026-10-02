Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8E5CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 13:05:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCcwZ-000266-L0; Fri, 02 Oct 2026 09:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCcuS-0000tv-Rg
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:02:47 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCcuQ-0007Qg-HB
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:02:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4ZH2DIbopjJe0viEwNbLIG/nyDvXgAl3rp4blkaNB1edZN6ADLpzmEui5dI7s/CSNpqn3MM5kqj4o11EozC7lVVsT3Nt3C3eX2dJOOU+kDUkTv2xa22aEXISDsDn8mY+/Qp+V+NRicbrN3vGV4GcjA3FsbjQuo9wP75wvnALO7lL4vdbGG8Md4D3FNZ2gU89XyUWTXlRSPdfTnsIfBE4iVpiSfbXFTR+7laDv9UbwnnspgyeHp8UGGEMpSv66erZr+sOpzxUXj6Y81GhtALVNZTX4rLnjCCltmr2HA9Lrz9jM2qf9m+tV0wmTvHvozrHIuisPxEsRlOnvofxKgFww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQgnkcViSHs3Rahhzmph6ktL2+UOz0MojTzm/dDNgZA=;
 b=sEBU6nTFETKl8GROqYLCK0oR5KqcCmU+PB29S86ynMmHJKvl9B6sZ6xQZBfOBSE5vk+3sRywSM/cWSXwBv5lej5qnNyHmNWOCwW9+2wvUn3XCn3+iEsFtZ6a3+HsWZASA++7tBj1Sf/v0/MPgOWq8FAXH2awqVIJb/+NH4x+ZBgewApuy/Wdk3AGkNGv7m6i9JIWrKZL3sFfulYYOHbttbCQO/v7ynXH/lYqOgXsi0YdQl+jwURr2fp/2NUXSQJuC6EGSxAjKPOH0BOnO4ujqLLARUJdMTUbQ33zngdyPkv+of5+vQJ5CFMj/1n3lCjdEcVykD2qo5RpqqAuFYRbcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQgnkcViSHs3Rahhzmph6ktL2+UOz0MojTzm/dDNgZA=;
 b=KbLkkU94MNFCNCiq5VIe1S/uIjH+0cwECDuZ2uQv+TBMNqAlm1bWAHUYqziT2GaBiZxQG0RtswFMcO85CRnYbVaJLDqiPgJyu5YwGiHWgTgUajrDvBd8jB18iEwE8xnRza6xyZ9VoyCcs03TRi6cE908RB/AkwPs3tRFoXpMXItbkfbbVHLbn4ltr0KQqd3HZNiyauoIllxXkzlGJIx2gqSfh4aFnDFGF/is5ZuHSZ7B9HqzsbTn+z/mgVhCCZogzFuWE0NabSIsokjfgovg/PBXsZ/8DinHy5vTUc7ojO3G8G/52VI5nYZcSRVEJ6Ui2x6iOs8E0qxCFg9CnyvXEw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MIWPR08MB013052.eurprd08.prod.outlook.com
 (2603:10a6:290:e8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 13:02:32 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Fri, 2 Oct 2026
 13:02:30 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Fri, 02 Oct 2026 16:02:23 +0300
Subject: [PATCH v11 14/19] vhost: add vhost_dev_is_initialized() helper
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-up-vsock-vhost-v5-v11-14-18fa09d8273d@virtuozzo.com>
References: <20261002-up-vsock-vhost-v5-v11-0-18fa09d8273d@virtuozzo.com>
In-Reply-To: <20261002-up-vsock-vhost-v5-v11-0-18fa09d8273d@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: farosas@suse.de, andrey.drobyshev@virtuozzo.com, bchaney@akamai.com, 
 dongli.zhang@oracle.com, vsementsov@yandex-team.ru, philmd@oss.qualcomm.com, 
 maciej.szmigiero@oracle.com, mst@redhat.com, dwmw2@infradead.org, 
 mark.kanda@oracle.com, sgarzare@redhat.com, den@openvz.org, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, peterx@redhat.com, clg@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIUP296CA0042.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34d::6) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|MIWPR08MB013052:EE_
X-MS-Office365-Filtering-Correlation-Id: 35673c6a-b567-429f-7e35-08df20856ab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|52116014|23010399003|366016|38350700014|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: nNZfrH5rV1Lb7qWmeO63uF7bA+wm1WJUmPTB6u+Wtx7cOBjCzggWabGUMgZSgtafAkzJFNSbi210B3dd43aMbAd0jBDkDSG6jTdNjVG5uiOgqwmEnKWoTIhTkwnIjRf9b0G8SGy6/fsGf1J2ANbQiGE95PrmL+2HdmjuR7vOnZEaYGopvmIU7mP1WVYgKxAO0Jy8PbpL+rRtuGpWGpRzoicdBLWNy9rdMUl61LZSI+PVifefyIjqAKZGbGGQQkhy1TF8oE0b2SKu8CgpvdfTx1sm0MdXGzqyBVByk5qFC8oKvqCZ+zjDXDWBlCLdwgiM+QNeeuaEcUTtpYnpDKUJkoKA2FoMAjGXcC7xGrlwBUjYNeSX5iK4uE/X4yduoIFuiHUtB1EwqHA3otTPeCqu5cbJez4KbROERT/I2K1ijPrJvxIjkoqN95uu2bq0sP95BNz/unjKpJbo/3+5Vqb+tOKFEQ77JCYxZE2byyK1265Dp5Y2TiwEc4cXfbNO3QvaX8gQi6gyn3g8U5gSav3e1N655ZzowQLd4yw2OPoUbXyz3dkd3Zj+OPKZnSC9uepU/diL6lOATE50m8d6CEHSuoaWB7SXQJObVTE1ApbdyNiqz1cN4sjs9Px4l2UGHSLDy+Kk3GwOOG63l8T3JpH0hyEm13OpxVrNfNOwG/kIUGTSpAWjDi1YgId895wo4SHi6cifPzVBJbcFXMy9Fvo4oT8PRfJJz+dukNtlu0y8SEQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(23010399003)(366016)(38350700014)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3lLNUVsVldyTnBYMFZRQVZWK3NrRXhWRTM2MWw4azVPTXh1OUp0NVRZVGtR?=
 =?utf-8?B?SE1GK0NGRHljU1VvYjBUdExYdnpuN0ZBZ3Q5WFFYSW1xdUJoRWRGcXFybnpC?=
 =?utf-8?B?N2plUGl1c2JOY1hVYW1NeE1RbVI1SWl1TDk4R1BvTk5kWEhoUHBMSlZzaGpP?=
 =?utf-8?B?WGZDa3ZueWFTTEIxUlRDSHlTcEFTUzNXRHpSMnN2MjRPTUxQNnYvb1k4ekp2?=
 =?utf-8?B?L2pDcWNTZ0VjUXhJd01oZVdQRTVoeHFHMEpFS21Gb0dRZHNUZTJvZkZLUzRp?=
 =?utf-8?B?eW9VTlJzRkdxeEl0UUliYXdLbE9EV01MNVR3amc2akg2bkZXS2NaZUh0OW1t?=
 =?utf-8?B?N3psMGpRV3czQWMrMHJudGpIZEt1YW9qemREMkxSWE5pcXhuQWFML1lHQkJo?=
 =?utf-8?B?K3R3RzV0ZFU1RkJnYkZJSUZFeFNlQ1ZlZmdUVk9JSTUwQVU1OXRvaVVPL2dD?=
 =?utf-8?B?YnljZ3JONzBJQlNUdm1IeEtsTnZWK1JtcW90T1NuQzVxbXUvbE1XRlhPbUlz?=
 =?utf-8?B?UzNRT1hUMlpuWkQ4N2VFLzl2c1RLQjFKakhJYUJWL3VDN2hoSjdQYy82aStT?=
 =?utf-8?B?eUwzMnRLcXgyckMwaUQrZWpEeHoyQllFL3Q2Y20xQVJ2aDgwbnp2ck5FdWZz?=
 =?utf-8?B?bjB2UGcybHBkL0dqam4zM1kzaUJwWDRkakpjTmt6K0RlNExmaEJKbjVRUUN1?=
 =?utf-8?B?Wlpmc3VKV0JsTitLSVdGeWpEUU9zNXhtUVdkTTBqdW4rVjRyeWU0aFA5NVlQ?=
 =?utf-8?B?Um1wdFh3RG9GNm9CZkVEbUxReGlHUFZPYWgzdGNLYVRtUk41WHdBM25ad1lD?=
 =?utf-8?B?ZHFVcU4yU1FOOHJYU09vaFlLR1Nidm8vaHFiUWoreEk0VDQ2VDlrRGtMMDJv?=
 =?utf-8?B?UmNSaTB6S2k4aGxnN2VVNENGd3o2UUtxdEoxWnpmVmtOdzZiNHZpQ3VOK1dR?=
 =?utf-8?B?Q2Zpbkw5Z3dSTTFGSjBSQ0dWaTJ1bUt6NkVjRk9odWtTV3ZtS3hHSmJkWGF3?=
 =?utf-8?B?bG5RSjVzaWV1UUtCT2E1VTdzYWVpNnlHamtEM2o0aWxTb1BqOWx0MFZ4UlpF?=
 =?utf-8?B?eHMrcnl4M29iMk9hTUtxTy9vRmp3YlNuU0JFMDFRTEVSZWdMWDk4aUtuamtM?=
 =?utf-8?B?bEY1K3ZiMWl3TUdPOU5nVmw1UFlpYU9ocktUZkhBUnRQWnpXakxQY0xRZG4r?=
 =?utf-8?B?MkszMjRDUlBYR2J6WFJENzM5MGUySFBKa1RBRVBSVzU2RkNLWW9sUVdUSExE?=
 =?utf-8?B?Z2tJZjE4TjU0elljdktEemQvWElLWWdlLzN5djVFUEViZG8yL3NrTzE3cU53?=
 =?utf-8?B?L3F0dmFPZ3I2MFJlZEVOVlNYL1pYbmw1VlR2UUgzcXNjcVl1djd2QXFValk3?=
 =?utf-8?B?ZXp4SCt5WFJTaXUrSFdHT091NnN3VFVIUEhod0R5MXpXemp3UE9LYmtkSU4x?=
 =?utf-8?B?YjNMOS9rSjNrSldoVnRqMTM2S3hJZHIwMGkxUXVteENxa1RXbmozMGRheDR1?=
 =?utf-8?B?ZHh4K3hTbVkwbmxtZ3NZNXRzYThhbXhWQWVFeWNCVm0zajBrTzZlRnRENjY3?=
 =?utf-8?B?LzlsY0lCNzBDNnlDUzFWdjNnVUZSU0RwSlREZkUyRHhSRVNuNkZhMDFBa3pY?=
 =?utf-8?B?RnJwNXNWYU5lYUZrdFNZL3JxM1gxaFRITk9Qcm8xSmJ4YnU5T3c0eloxWVMr?=
 =?utf-8?B?SEhsZWNsVTQrSnRXWEZod2RUUGNiNkQrS2tSYndGTWNocXpQQm1hN1pUbXpx?=
 =?utf-8?B?TEIrSk5uWlg2eUp2K0xRU0IvMnVramJ6L21NS3VWSjFEYk9HejRhS0xZeG1o?=
 =?utf-8?B?OFJtOW55SWt5cFdINkNHVURiMXN1bG5OeVphNER1QjVBUnZ0TUxWSnUvS1dW?=
 =?utf-8?B?R0FJV0o0NWdCaWNMaERHTllxUk5wZ1VWS0hqOXg3UzFpNlB3WmNMdzI0ZGpu?=
 =?utf-8?B?WnRUdmVIaEF0cDZQMnZidG9hcFJ1LzErM3ptdk5UeXFmS3Q2YS9EeFVmR05j?=
 =?utf-8?B?YVpWa09RMzJBZmc0TERtTCtyS3czbnBkZTB6M213dEtoWFlwWnRUeDk2WVV6?=
 =?utf-8?B?cGpXSTBSZnFML2hFRFB5QlRXTWFvZXd2TWhVaXhJVVczRmlKNFd1NkwzbWJS?=
 =?utf-8?B?TmNodFJXSDJvcyszT0RMTldFUUM2TVloWTQwL0xHdjUwL2JTK2VHckFlS2ZU?=
 =?utf-8?B?TW5UeXVzTWwrZ2RqdExUTVduTjMzZ0lqMFExODh4OTZkQmdGQVBQRmhNNlFo?=
 =?utf-8?B?N3pYTlJ6cjNWWk1vd1FTRHA1Uk0veXlWZVY1R1U3SGpROE51bzIrb0pneUlG?=
 =?utf-8?B?VlJQS3lJSEh3YWdZRFJybkNTeG01SnlnREFHc1dja2VyR1lwVGg5QjdueWdp?=
 =?utf-8?Q?HGevlcV8HslUmtmA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35673c6a-b567-429f-7e35-08df20856ab0
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 13:02:30.4392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4o4PLmrHQ0cCCQL0dMdf0jt5fbBXiGH6D45BxAy9jbJJc1r37Vf124dl/q4YF6wp5A5hLTavDLpMqVIUoPD8CuT/N7tzFVI2cObCHZn8HM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR08MB013052
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


