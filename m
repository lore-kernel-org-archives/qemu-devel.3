Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D88E3CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 17:25:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBbYi-00067j-ST; Tue, 29 Sep 2026 13:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBbYh-00067B-V0
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 13:24:03 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBbYg-0002lB-BW
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 13:24:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UUrp+3N/x9UDOhyL5TKQiIjkmsmvmjyIgUTKPbga90KV5YH6xqzRQ9nOzCrmjzA0VBQC/G9ZbUUg3cTHr/Chdl7KvQ2vHLfJZi+WpqIsYz/xhgnXKMhPVEG1h4jTOUQNh2bqe06r7Du5WvpKaC4VjmjmCfW8f67ijv3z3LheK5nQUZcisFQisG/OTwEhNQPZYFpW7hRfzhCZpppvpn5cY7apy9id34DDtHfAvvKuO/+Vw8blLSIItFO7Y+PAXM+03hTMTRlIsfcIYoZKMf5v6oGKPHfX4zYk9O2OCgZmIPztMo7SjAyDQz2Qlcrz2mPtpeyNfc8QpVec1nt+h/lZoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQgnkcViSHs3Rahhzmph6ktL2+UOz0MojTzm/dDNgZA=;
 b=YrqFnx/N9D6Hl4ev/3KGiRsYp7s3QvgsFv/n/fOoZUMO/z1UN+z/JSnI6Xfyk4CYxA1/ekZZ1G5XpOqLZnFOCWdj+zPpMdVxPcz0cb7rlCXOqXc2CBMpq5yTGC0gGDExINaInawJqJTNDKxmo/SunwqmCUqpf9PR67frgMpyzMQk2kP0TNEd4TTOrm6Y+fV9v3jfCNvr/IbQ7DD8rbSybBmRBpdLnWLf7nPW6WZg78VYm+Ta2xNBDHdwdF2VOcvqfNQ0agCslLQsusndKQo1ccmOhwAaagLXlivCIbQzIibVV0bQ5c60gmSQckBaumwUlUOQGXRxcUPVQa6KXdb2QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQgnkcViSHs3Rahhzmph6ktL2+UOz0MojTzm/dDNgZA=;
 b=U9orHK26z05UEfxIrbEABmlhV4+bcYciCiPMdFWbSOqZmpOCka8C7ARVEMK8cIZSulnUdcCNZUjMB1xgVLoueluJ3wgl+gzTCTMV6yUCPbsp0lPD59J+PPSzbMrXuvGxo+CPRrdBB97CI9Yzhrf0AkE1MvrMJ7bVHSae0n/FeOHttxc2GUB3tMNVbszw4yFFDZ3OCmhFKz4vIqzdUpyuOjG51si9Cl9iLrgyj3Nx5izVQwrCgDrjXdLO9Es/L2ubJtZsV7BsYwbr5apKYr3qX677yQaaZCPGeR/nJ/dUJQsoaRdGgvBbfzsCkhc94hTLk+oEeTYqQsfDOlts0AGJ1g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MA9PR08MB435041.eurprd08.prod.outlook.com
 (2603:10a6:250:101::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Tue, 29 Sep
 2026 17:23:54 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Tue, 29 Sep 2026
 17:23:54 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 29 Sep 2026 20:23:33 +0300
Subject: [PATCH v8 14/17] vhost: add vhost_dev_is_initialized() helper
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-up-vsock-vhost-v5-v8-14-12bcf1c0b84a@virtuozzo.com>
References: <20260929-up-vsock-vhost-v5-v8-0-12bcf1c0b84a@virtuozzo.com>
In-Reply-To: <20260929-up-vsock-vhost-v5-v8-0-12bcf1c0b84a@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, maciej.szmigiero@oracle.com, philmd@oss.qualcomm.com, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, clg@redhat.com, den@openvz.org, 
 andrey.drobyshev@virtuozzo.com, mark.kanda@oracle.com, 
 vsementsov@yandex-team.ru, farosas@suse.de, peterx@redhat.com, 
 sgarzare@redhat.com, bchaney@akamai.com, dongli.zhang@oracle.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR04CA0130.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::28) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|MA9PR08MB435041:EE_
X-MS-Office365-Filtering-Correlation-Id: 5825dc37-80b7-44a5-f689-08df1e4e700b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|7416014|23010399003|1800799024|38350700014|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: C4Fb/1p6/YiOXIDH33kflgdTiu5HUVsj3AFw1YFiHdTKYS331H/zfFzJgsAo0KOatzDbL03xooqLUic9utt3rsUeC18LQsoOLdoDTWHGLxphHlBJDHcytwiPedszF9HkVWkJYsq985LMrKd7YadlmjkCLpnVNYl9ZRd+sY4/naXtwp08J+hphBNpHH69C9oHNbgm0lXPQ/UVc9A1/HbHDeScLD28VbD6wxlZzsNDAGRlKIMy23i8cgvRoF715kLML4zQI5LNoq0lhDfC12cbe+taitD63wP7WKZcPiofO+wTIETdgsISryOm1Nk/FzKCJRqs3iNYCcf/t45mctzDP2rVjqRSd7jyWpcdpm4y/NxQYXMGxJquJU7508SACxMxBEBpX7ert+HP/DeGo2i/tvmBRsZFsjKs0ib6dGaRmUmxsPpAXfaSheatTcz/QRGtNrGE1iRRdEx7uom+7ecYa6R8RieRchOtcVQT+ynAPae9RzVXfX6lPuMi3Ugpad8YL2I0a/PxYB2a3/lq9gVci1e4betSkSRKfMCKT3b0vStGV4xX9h6uiSrVVhXI9xJKWuWp3cq7ejswwkv8Tpp6GIYEhl3Kpk0yqJ+0ZgcnSPSSG+wL0+r1XfPiMvaZKLocLHHTbm+8qOU9eolG4y12v2gC0RNbo3ojcBpD91ELTzKugmUceWiZEIv5Q0LgoepsInAEN00iOBoh12IaxJ+6V89mpPAxtmzkchQHpaJ0lGI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(7416014)(23010399003)(1800799024)(38350700014)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cStqd1hTT1lPTGUxdjg3NlBySEtxeEt3ZDdiVzVsdjlra3crRXZNQVhyZHpH?=
 =?utf-8?B?QmhQV0ZqNC9pTXV5eUxNR293ZkRDUW94eE1UY1EyNWYwTlVSQ3JxN0tvR0po?=
 =?utf-8?B?T00wU2hOTzF1N0ZKd2dQOEVJN1RPVHgrMnNGUm5NQm1Ecy9TVHAydTR6Z0Qr?=
 =?utf-8?B?M2x1UTFIbitXTUlpUHJSeUg2Y0RXc0YzVlkzOVVEYTJhMXJITUFaYXpaL1VK?=
 =?utf-8?B?aEJnVDhBQjNCZHRIWGppYm9kdTVOdk1PNTFLNWptZUJJeEV1U1UzSXppVFBp?=
 =?utf-8?B?QjlsMEk1THN4OUFRaStKNGVZL3Y0REJFNXN1cEhVbTRHRGVuUWVLeXlLa041?=
 =?utf-8?B?YnlKQ2cwL0g0cmg4cDJPNUZCZWhhTG51OFBGWEgvVENXNVo4OGZRd09VM3Z5?=
 =?utf-8?B?MnZIQUVnZEtuOG5jQ29yYnhLUmRwaWY1alI1UjF1L2lEcVlZWFE1cE9SRUcy?=
 =?utf-8?B?dUlSOHhSKzdlMEUxcFZVaFJoR3FDNmFBeUNlaDRLelBHMVp1NElDei9VU0FS?=
 =?utf-8?B?eDdoWXpRdWx1STBlNjVNZ09nTSt4Q2VWWW9mYm1rQWUrR3ZuR3BjQ3M2b3F6?=
 =?utf-8?B?czE0WG1kVWl2YVU5NUJ0aUpONXIrcExCMnE3V3h1MXR2dThSVnRZWTdxUTg2?=
 =?utf-8?B?elFJLzVKZVlpbEdvanFEQkp5MTltcnMvaTFPMFo0T05SdjZVdlFtRW1Cdmdh?=
 =?utf-8?B?VmxpSTNDeEpkODRwUTExSHRJRExSTWJQMWp3empJT1FacmtsRkNtY2cwSG9W?=
 =?utf-8?B?ZTBrWU9TdG9PQmhtditHVjlOSUNJYkQ2cU5MQ05nd1FHZHFDczQ3UTNBUi9Z?=
 =?utf-8?B?bjBLRWp2b3h3WkVnZTJIYnVuUWZWRHNnZmU3bUMwdTdNdFhpcml5alVJZ1Mz?=
 =?utf-8?B?c3EranE0MGllK0l1ODU4MDhZV2d2MzE4UHZDZTRNb2lDQjd2M1FhdjFNdmFt?=
 =?utf-8?B?UFAxTlpyOTFmRVhGL3FkSkdwOTFmKytFY3RWQnhTSnREcnBDNW5tbjh6RGk3?=
 =?utf-8?B?V0ZtZlB1MUY5M204WkkydFpCS0cwelFleDFzK3hWM3ZUWXVpdHFPMlV5Q01a?=
 =?utf-8?B?eUNsZld0bUNhUHg5UXJjQTNaYm1zM0djRDVFOWVmZjVwazgwV3NWZHM2N20r?=
 =?utf-8?B?NUV0MDJDWkxjdHpqYzFPcmtxTkhoN1p6Yk0vcnVqRzV6MDgwb3FsVjNRdmFl?=
 =?utf-8?B?MW9RbGNjQUtxamg5K3liVmt6UVp1RWxxVGpiZ1pVcnVqV0JpZ3J3VlJUUS8y?=
 =?utf-8?B?eW1CbkM5dWg2U25aamtPTllOWUlPWGU5YzY1TjlGYTArVm9handna3Y2ekdB?=
 =?utf-8?B?V0N2TmJDdlB2UHkrakcwL2lUVmkrbnZVK0oxc2ROOU4zMmdqSW5hUzA1S0M3?=
 =?utf-8?B?bURrQlE2SkpOWU93MEU4KzIra3BrOCtXYnp0YlVqY2xWeUtySUc1TkVBS3Vn?=
 =?utf-8?B?QlF1UThWbGFJTXhFQmMzVlZUbUJzSHJqYkF6aXRjSGIyM1BWNWIzNFU5T2xh?=
 =?utf-8?B?OGExNzlycUJCR0pheTk3dlJ3OWNQVytEWnFNTFhkbDVCV2pHSDJTVDIydktu?=
 =?utf-8?B?VXA5QlBFcGhQcUtVcTFBZzVUVUVnN0ZKSkR1MURIVUZraSt4TldXT3JtVWhD?=
 =?utf-8?B?VFdOSmhxR09WdVBGUXBQUkJaMmpBSTNzNmxseGt3ck85QzN4UVpXMGZYQ21p?=
 =?utf-8?B?QWVrckNXSGpKdDNaemw0TzhuWUdzT1dQSjYzbjFmZmlBNmtuN0ZjM1AvaXNV?=
 =?utf-8?B?cG04dkpLMk9QbGdvTEVyQkJMdURJbUdBUC85alByS0pkRWt5M3NxMUFOcFJ5?=
 =?utf-8?B?TTh6SzdFTTU4SUJ3RDhvRHhsb21ad3crRldLVEFtNS91ZVV5WFVvemlMU2Vr?=
 =?utf-8?B?OHFoaWpWeGZtMlp4MFc5RDBjSlZrRjhKOEpxNDIyd1l5dlJ2WkJMTnhFWU1p?=
 =?utf-8?B?bG04S3JvNEJBZDJMNG85UWtyS1ZqeCtHTWFySHFZMURCSGRVT2dIb2o0Nyt3?=
 =?utf-8?B?ZitXdm90d0J4OEVycHVaQkM3aWwvQ3JkdmV2SGNlL0sxT0lWK0NBK3VmWVpB?=
 =?utf-8?B?eVp2elBKWmlGcEZkUnB0NWR4TUxtMkFvVWhkNGRoZW04OUwxNFhZTHVXRkgy?=
 =?utf-8?B?VDVQd015azYxMitWTklkTWZLOEd6TVFXRExhb1NuQ2xzeklIQ0VZeVE5V3R0?=
 =?utf-8?B?cDlYMG16K1FBb3Z0ZFFwdmt4M0d4VCtxMndyeGdSVjZwNEFRcUFSL1k0WmNN?=
 =?utf-8?B?UU1lVDRjV3VGSmNiakFyeDh0blU4bng5NHpDSkRGR1J5RlJHM0ZsNklMUC84?=
 =?utf-8?B?NmFRMnp4ZGszVDZ1ekUzN01EcXd2Zm1MZFFMNVc5SWtOTlJMS3pPeU1yLzl6?=
 =?utf-8?Q?z4n1bmdWLpPakQzQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5825dc37-80b7-44a5-f689-08df1e4e700b
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:23:54.7065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FSFO08aUyDkIk7EUZKswcuQRr+H5ZPa2Tcv41p8nYTJf9i9HteCHqWRDa9iLoNV+pzWJwsyfaMVvd1kTu5MZUMBnLk0BBDuNvjHqqORVuKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA9PR08MB435041
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
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


