Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D8B7CA5FBA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrJj-0000l0-G1; Wed, 30 Sep 2026 06:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBrJh-0000kC-U6
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:13:37 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBrJg-00046g-97
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:13:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XcPDatFmijv6gmGy9xrBmWlbaaEap8LAoZCKe7QM0w5ACYFUCOmThlMno7lZRtRaWjagXSaX7zkuVIXmkNqPRrchwVUDH4KQn0tc5pHDJoY6JRXJE68CS8LbVBPwzpaFeAQ4D+S1wSwhKJVlY+fBxCwHwQbsv8BlK4lLoLvLAjcDcZKmeZ1hfPDh5XPpByb84QgnHkSAGDMCsTtguCAvRdJI0xsu5ro6Op0JaYsehV4L2mICpC5Qz7jCl2GoC1wJVqeo0m72CKYRXrS7LkPDzmOzmBT2BrCAjvvWXGdilNNC2GHADT0mIg9Xz646RqUXF/eiT2D2A3DXFhOSNZSQMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQgnkcViSHs3Rahhzmph6ktL2+UOz0MojTzm/dDNgZA=;
 b=IPSeNauMvGFbMam47ULGtyC98ulxRytGOAJQ1OjhvZkYqnb9UNbaoTnCi510+L+sW5KBTZN3Xs4ndlkebbms2k913nZlAjACbQmSCZCxNjlBLev5IVYVagIfE4kp8UfJ7SrP6j4ydJ0eofw98GbNFYP0BMapaKxeDu2MfgWcDsdwpwMcnNjEFenOyG1+Uo6796EC9i7hv2qYfabj16/oReRr60nNTLCJ9gkwxZSMdpfzqAPZbwatY0C5cW/Z9PvR2FIU848qKKXk9YRsR+pZmNvzso+KC+iEMwAvvCiJMhL+el7Rz9scsICKQdTaem/2LutHBD+sNM2QUA7vzBo4nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQgnkcViSHs3Rahhzmph6ktL2+UOz0MojTzm/dDNgZA=;
 b=XF31tlxq5RiusFGn2c/VI1Jt8fTHvX6U7H7q0VWzUju7IGfX+jTEXZLMLR+oYU+QknvQIfonA6UbaWq4Lhpg/UQCrkJJERg7mlM62EdCkoiWGLCaau5pd+r7WxsL9yCcRFbypUJSRtXkMDZKygDxejybaduUXvRz7QdUwK+Ee7ujlr/LEDx/KE7wajY0yw7i4A+03P4+v13Q6GWf+mUOFhJoRmXeaV5SIrSSf0/y0P8j/yLwZUzjL08CtnF+3d5OHIBuyjYj6BJNhMOviSemjYDTVmQE98yMYP0/e5AHhmm9micaSUT0+bpjKwF4F4YRNkov4h9elrr3Q3vej0W9Nw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM8PR08MB6420.eurprd08.prod.outlook.com
 (2603:10a6:20b:314::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.9; Wed, 30 Sep
 2026 10:13:25 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Wed, 30 Sep 2026
 10:13:25 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Wed, 30 Sep 2026 13:13:13 +0300
Subject: [PATCH v9 14/18] vhost: add vhost_dev_is_initialized() helper
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-up-vsock-vhost-v5-v9-14-e9096f629770@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7ad4505a-452c-4186-460d-08df1edb7723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|23010399003|366016|1800799024|10067099003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: XDO7ELagM5I9zxYj5v72BHrxbqaXeAGgqPpNJVz+DQHHN7yaLIyBy9ID5MN8ZQOjMhl/Z7FL7S8UO4nJdpLuUciHPIbMeuwJz5yNuoODQDK8jj4aNWT+z8Vnt/vHsf4rG+C2/umtnv74lCSXKXpbObzYl3a3JUHPHYszseQeE0VD/t6pHfvIiN1so8+68Z43qLaTHiz4N60PLKRQWfdPcYmfYtSRaHEB0GYbtVt5ZSfc0V68WpMo8FqWkSDSfpby/VtW1Eai3iJaIaKlHplg9iuuFClp1eAngHzmKMSY00yV2fAOeWr52God+MkUtJl4Bis7O1vRoM5YeSoqqGA2if00IdArEVJNatfOyMvkJKt/k+ReSGzNPqQDEHuk90k0hsHcWCTc0lHH4TUih476yIKmfmb1xYts5A068QhnLUVf2ZAebJetek9FtLU8eapN9tV6sX+zJ4Iou4mhs1fjurutJ3+1PD4mD9qQSNKSGMLJmVotmvViVEge65NG4ZZheUfkqpurzuLjbC6R3BWyzdsRe/GnKuaAah1+W2YmhnidZuDrPwQ6MrkcVWakLF8WlnpHvQ6z8lGkH2ZgcuqnlC0Gg3urhCwBCg1xmMpijglqRV4ylYLX/CehKk9nFuYiCRDrUQoQjhvq6Wy7pg3wukC57M0eQdi0CucaQEiUjjThrPg7eiFTaZFkaPaaJ+Oj2qmzlosMuZWXnLKz9y+otCuPbG3oG4dqFdE3aqeBUD4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0s2TVRoVjEvd2F1em9SSVdJQWlZK0h1TGgxTSsyNDVsdms4ZStMaHJJVGFN?=
 =?utf-8?B?R3hFRFRPU1ZlbFhIdm9kR1FSbGlnVElJZEdpeTRRTENjdkx1VXpIUjJwbElk?=
 =?utf-8?B?T0NILzAyN2lFVSt6Z045NW0vL3Z1MmY5azF4cHpoMFVMSjdGVzMyZFhRbld0?=
 =?utf-8?B?TjA0R2JIbXlhYVkyTXIwSkpwRkFkUEcvR1U4SnBuM0NldERJa0dMeHFhNVNm?=
 =?utf-8?B?d0svM1NmR0RUMXVCMDhaU0tTSkZGUGpBdzduNTI5aHN0RTNmQ2pBVFBsd29p?=
 =?utf-8?B?bUxmWmJyS0dsWEFzbTBFTm16RGFPcnBVTktaM2RHVUFtTWxTVU9PajdvTzdz?=
 =?utf-8?B?bm1EblRQRzIxU1RnSjJENlhheWdrRXBCemdoNnRRWU11TUx1dFlpaXlEc0k3?=
 =?utf-8?B?eTNwOCt2K0NFa0MrZTllbG9rNWhHM052MmJUbER6dWRicHRrWlhCdWFURWRp?=
 =?utf-8?B?eFdVS0hwMm4rRXF0b2dsTWtkRFF3RUlKeEUvVnhEenEvNlNtcS9kVlNHR2F5?=
 =?utf-8?B?WXZtQ3JvVWVtOEpGZERaL3VqRG5yZy9XN05rWFZMRTh6NDVYM3hJOUF3K0ty?=
 =?utf-8?B?NGcwVDhlMjhvRlNpdU9RNHpmU2Qya0k4bFhSc1czQXpmY3pZZGU4dUJpYndQ?=
 =?utf-8?B?NXl6KzlxWnAwU0tENytCQmtyQkF0cU9icDUrUmpxQjRwZHV0WUxWeVBtMVBO?=
 =?utf-8?B?QUUzOVp5ZlVxRG45V3FGSVVvaEZTVzF6d3Nxb0pyRDF3ZEM5eFBtYVFGbE5t?=
 =?utf-8?B?cGkvN3REQlBQYURWbFZhS3hxbFRkdnFuQkpwVUMvTXl2azFnOFVQVmtjZUJw?=
 =?utf-8?B?bG1NZlRoMGd1WWhDMWFZczV4QXNMbmtwbWw3Q0N6ck9zUi8yM282MEZIZlBG?=
 =?utf-8?B?cWFTUGlaVXFWd0R0SFhTall2cFpWREltQXhNZjlZZ0RyeCtZTEdRb3Rpbm9K?=
 =?utf-8?B?Ym9OUmJRUEdtS1dFcW5XeHlCTlpRNlVaaE50TUgzVjRobjIxM1JzcDNJZngz?=
 =?utf-8?B?Znp3anZVUWRNQldYSkQ4T1BWeFd3dVJaelhCNWFiL2Y3elN1bjR4eHVMaHdK?=
 =?utf-8?B?d0l2OUJkUmE1ci9ZT09JSVgzOTdkT3paSm4vUGVHSkNXS2kyaDd6QVlSaUQr?=
 =?utf-8?B?Zit6QytsamdMMzVZTlBxVEJDanJqS3YybWFyQ0tiRjdRZXdCbmdYTkp3Rng4?=
 =?utf-8?B?c2gxSnozOEszbG5tWW1vS3RySHA5YmJkNW1DUmYxVEdpNkVVZGVRZllVUlBq?=
 =?utf-8?B?M1pJYXpmTkp4NFBYQXZDRjYveGdCZEQyWHgydUxyZU1lL0VVTWlhUHFUWkM2?=
 =?utf-8?B?MnAxcGhINWl6WUhISlNDWE1vV0xKV21rR3BCRnZ2aXJhYjYwaG1OWjZZSGdR?=
 =?utf-8?B?eHBReHIzYm83T3JVN2pwaHNhTzFRUTFhRlZJcGl4OHhvclFmRlY5OVczR3dN?=
 =?utf-8?B?cnY5SnU4b05xNWhpTkRTZnU0TWhiK1pLbVlRODVubzBWQlNrL0RUZ1ppTFI2?=
 =?utf-8?B?cjVYNlJXYnk5OTR5eGh1QVpTMFFlUmNXZHZOLzZNWFFJS3dBTmhrTjkzUGlJ?=
 =?utf-8?B?VWl5YWFvYWJlZU0wc3lPRGpXZDJEanZIRlRHaU9RbXFpalhyRVpRdzcvd2xx?=
 =?utf-8?B?Vml1QktyRzI2WnZMV014elRRM2FMWDU1MEUrR0gwOWE0YjBnWStoa25OK09I?=
 =?utf-8?B?Kzl2Zk5XVGZlcDB4dEVNc0dlNkNEeXpHT25oR3lpbytMeC9uelJCWXZNbUhI?=
 =?utf-8?B?OGRoNU1YYXo3WDRsdUx1TzhiVUJ5Y1BhTmZKZi9uK0t3ZnZtYXQ0NUpGQzBN?=
 =?utf-8?B?SmJvU3FpQk12MmRyRTVKR2R5Uk9HSmlHbllQQXp0N1dJRFNIOE9VWkUxK2lV?=
 =?utf-8?B?Qk83UHc0NHNJYklMSDRzMFBwSzdsTkk0Rm5Jc2prYTJNMVZnZWU5MmQ0NzFV?=
 =?utf-8?B?V0t0REdjenZTZkZkVlM1L0xSZW43c1B6akdFU2tBM25qRm5hQ09tVHFITW9G?=
 =?utf-8?B?SWFUWUpTamkyS2Z5OURtZFVIYlVrODVOMVRZQll4M3g1cCtIb0NTWUdxQUdT?=
 =?utf-8?B?YXdnOEkrcjdGTjhhbVJxYjhac01ROWRmVy9UcTl1VEYwQllsV2o4VTBMNm5K?=
 =?utf-8?B?SDczbEFzS3lHdDJ1T1VieWFFZmwweWVvT1RzNVFmc0FUeStNMlZPc3pibUNM?=
 =?utf-8?B?cUhiTEJsZDVrU0tGRzdZdEJXbnBJZk5YNnJXeEhyNDg3bnR5V2dBK0ZFMzI5?=
 =?utf-8?B?Y2FDYUtPenJDbFJ5S1Q3c2JDWS9sOXhkdlJmK0taZ0dmSG1LaUVUVGV0YWJD?=
 =?utf-8?B?U0U4amdqUTdhQVFYMGxxSWJqdTl0NFk5eFNYWS90azl1RVM3WkVOREpsL2pY?=
 =?utf-8?Q?s/9RvZbqX7NrbT44=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad4505a-452c-4186-460d-08df1edb7723
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:13:25.6380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +oBYjl03lt0htW2k0OAWz+nXHVNqq1y4OE1zTvgXpSNDIGfIRtVVeCH55yD1c7mqiYCg+xHg4N6bRU5Wom+ZociJ3p6w9vjzDJCuP8mNdF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6420
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
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


