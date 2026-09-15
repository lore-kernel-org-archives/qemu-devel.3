Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B64C88E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 21:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6aIo-0002wY-Ia; Tue, 15 Sep 2026 17:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6aGw-0001QS-RZ
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 17:01:01 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6aGl-00011o-A4
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 17:00:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QA/4kvwpbszYFwJCmWlUdu3DQN+EVZhK5D/qao3dV2SI6pvc9UWUhNhGmejf/nfck7YH/VuK1UcVkNUDUx1YpY9LBfclckkg8iVe2JaP3NGLwG9kWAniFl32/fL6o8JuBYK3i6zHBKJr7a3bFJGRlSNSmefaspTMv67EB+YfuwGdMokU/GzhmpWUfUdgTqTgrCPjyONmRVja5uSupRDBdENF+RT1rS9XdZ4sB/tbwUj9tZnYvpiObOyJt/NE+s5vfsu4fb3YiP6fXcklf2Ao7+0Z7E+XxodtSBhhYh4/E3qgTmVMjwlK3PdUL41GXPq8wtP3T/eY1TyQUne7I8Svvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWXhh68le3RfUJjypRVq8x/GzIl/qjsOycrfUzYBtG0=;
 b=OtsBaxmVqIx5u4ps7URbhUkvzo77k9kSCDGr8n5pDe37YEjIHO4HtiM8wfrSZQ3IeNu4j4sRrFjGEPMRWSR5aLZW7OxgA5q1v2AiMfH3ZSp14DzzIcCz+IpnZN6MptdkPhZXLtc8/BHOz98frKRwjhgDvykCqmc/LLFgQ3HrYogCXIQoxWYBuCtIsjKEZSXSvR2/+A1IshedpinbHFHH3K7fgRUMwqCveyIZt7bbeNB2VTRjJsJC8DSKRGwV3NxjvM5I/DURtMnJUHMWZ5k2o7kBOHyHUA6EDZecdLW4tDRDTDCxf1RLlPilVDxwcwuzkjicD+IrtUIQE9NthzrA6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWXhh68le3RfUJjypRVq8x/GzIl/qjsOycrfUzYBtG0=;
 b=v0h7w3Tds3r3m+AGmb6ldKZhMfLS2l1s8KseCWocItkHGMdDJ1Au86KPxfvA+11Kt30K59ghWYq/uJ0At9KfN8XKXRD62ToespT08cQ8XpzAdd7mualK3mGtQ+9B3pVXAdl63l6F28AAoetafPxLgbq+vYuSxCx6wdT9HBYh42YPdnyMwA7hFfaNg3hR55bTqoIURCt7RhN1Js93mE4yOUaZbSqtnyKLdwAsZ7Sx6x/pr7TNUnhejatFZEBdIXXhLLekeJbzNDlHLHj16jjrH2jOhDrKFcNVQCkQrgtcgQ+g8Lh7Gj9w8tnrtv1YgHEP8ipGp9U/8jxJDRP/3dE7lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB8708.eurprd08.prod.outlook.com
 (2603:10a6:20b:562::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Tue, 15 Sep
 2026 21:00:37 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 21:00:36 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 15 Sep 2026 23:59:47 +0300
Subject: [PATCH v6 11/14] vhost: make vhost_dev_cleanup() safe on a
 partially initialized device
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-up-vsock-vhost-v5-v6-11-4d31b2dc6afd@virtuozzo.com>
References: <20260915-up-vsock-vhost-v5-v6-0-4d31b2dc6afd@virtuozzo.com>
In-Reply-To: <20260915-up-vsock-vhost-v5-v6-0-4d31b2dc6afd@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: bchaney@akamai.com, mark.kanda@oracle.com, farosas@suse.de, 
 den@openvz.org, clg@redhat.com, sgarzare@redhat.com, 
 philmd@oss.qualcomm.com, maciej.szmigiero@oracle.com, mst@redhat.com, 
 dongli.zhang@oracle.com, peterx@redhat.com, andrey.drobyshev@virtuozzo.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR04CA0053.eurprd04.prod.outlook.com
 (2603:10a6:802:2::24) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: 59fde426-591d-4524-ab9b-08df136c6428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|7416014|52116014|376014|22082099003|18002099003|38350700014|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: QqnRhqGV/BuH1wNdvhi1+/VUNTN5O2Z61mA2FtKbtWg2Qi175mNmhb+XUv2UMccDLhKY0Pzvmxgc2r3eoTpgHlJ2JqEbeYuZeCrke3ITgzoHRdsnqn+unJ2DnOflya61/ujBVxkWkNoLeFG9NHQWGwGE/6Q8RpIZ/EwLPjnZDMxK4r8LwNGGtfhCxZEXFXgG+qQZP2WvXrkyswsk9NEeh+nqh+41Cd6VcB2f22cV8YU5DJeLtMgheyZJQCyrUU9eZapIbJZZd+9CRX52a2THZAvSfszCsrFWIB86yzTr2UZcrWh5be9xTPYAi8wV+YkBKa8FRQUeV0sKfsUsO42chdgdCR213gQOUrmcsqJBiOmGQ6vAiu7ZVHxYh/wJN6+YOH86Yv70exAKKF8g6w8Kg2PdkTRtw7xJRNpvACYgy5teGuMEbnALBtDIaO+8ByXozdIYZEjdwtM3+aQnrWp3dSAaCeZNY3dTHKIaCJzQXWTfe3KtB0Rx/H8y+2HGWImqYkJQGtHVZF9s9dPAum68Ym9BvdBLmUBhd2nQcJFKUwh9/WZdfpnqtoeFF+7xXBpF2Jqo/SlLLgRHxNmQdqFxk0wZCYaO4Uv0i1P0a2tJQ5ASvorLUj5JiylStU+y8yAiOZdYZCpu8H0AVWp8USXntzjU0q6i7337rsyJDgTjK/jOpiERjp1S9A48mVaHa5xVm/Fp70mq6fO9g0RwNnNo4X1JbH01J6w2fYzEw4MuP28=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(52116014)(376014)(22082099003)(18002099003)(38350700014)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFptU0F5cE92ZzFucFZaOFNreGdWeTRid0h4OW1xWTNSSkZDN0gzQ0hGTEdI?=
 =?utf-8?B?ZHMzNklLZXNNU2JreUpiTy9LVUpIcmtpNUdQMmJTdFpHdVVNUUlaK3dldklP?=
 =?utf-8?B?K3g1elBUOVo3NmVYbUM4OG1qS25ERUFDZVVOTW9GelpJR1lxR214WW5OOTRY?=
 =?utf-8?B?K2hFTVdWbXp2NzhSa2t3aVhJckZEdC9JNTNyb3lSSmZSWElkSW9sYW9iM0oz?=
 =?utf-8?B?Q2FyRjRXYzRyVHBmR1h3czFEdWZPQ2VlV3hsYThTYjlqcGRmcDBYdjZmc1Q0?=
 =?utf-8?B?Rm1JYkN0RE9TL01HRTlkcHpHT2FobmZPWmVsZHhVeE9abXJ0N0dEbnhYZGIw?=
 =?utf-8?B?MWN4V1ZPWXhRWmJrTWZjK2lxV05Oajdhb2QvTEpwZ2NzRXU4U1BwNGhnRU8y?=
 =?utf-8?B?WjdkWVF2RHA5enNQL1FoTGhodjVEL2xWY1lWSHFkNm92VktFQTBHY1hyenR3?=
 =?utf-8?B?THNNS1pZbGo5dlJLM1FNeXNVQ3J4SWhMNHpMRytKMzhsRmFRWmYxQkZ5eHdi?=
 =?utf-8?B?Y1BjN0RBT0NiZU02bjhsNVVZTG1JdS9VWDhzV2hqRUZ5TmxCOUZtbjRmc2dw?=
 =?utf-8?B?RFVWZThTM2NvVEtJZTdHUHNyazZkNXNuMkp5c0V2dDMvaVpMeUUvNmlBY3po?=
 =?utf-8?B?cmRQRVIwV2FNTkRPY09KQWxTZmpoQUxtV1d6amxSQ2w5OHZ3cGdVVk15RHcy?=
 =?utf-8?B?S1A0b3BBWTJoR2tuQnl4Y3BLMnpMVEwxSWJ2RWpoakxTRERDVnpZRVNRSGRO?=
 =?utf-8?B?L3NQRUJYY21GNEMxR2NDYlhwbkVXRnh5YmMvTkZ5Ukh1THRqV1NMdlNlSTkv?=
 =?utf-8?B?T0w5SWdLbFYxUnRreW4yU0l2VEFIdzBUUkNqUUlqVEkxOVVkQ3ZCN2tLU1dj?=
 =?utf-8?B?amdUZGhyYkNJQi9Zcis4ck1ra1B2elhXYVQ2RHNHcE4xYlRoeGlQTTQ3eFho?=
 =?utf-8?B?djBCT3IyOVhBMTNnRTZSME9wYTFMUzUzQng0NFR2QlJNVlp2N3dyaWpUU3Fq?=
 =?utf-8?B?azBhZ2ZpRGlETmszeDZzQnV5SVA2U3NSV3JVV3ptbXFsc1Vub0lUTGZYb2dl?=
 =?utf-8?B?M3E4L2dwTk0vQUFXTU1DWlVXODVpbmNqTTV0TmVmRnlFaExJZTBPNy82QUQr?=
 =?utf-8?B?V2wwdWsyVDhzRnppaUVaaDlqRkx2alA1alNOdk5DbEhXeTlXNGZuQnBROS91?=
 =?utf-8?B?TVgxdWZtdVNwa0JpV0RSalU3UWpqNjdBUTVKcmhGQklFcGNqcnllOXRLL3lV?=
 =?utf-8?B?dURPOGtaN3V3NDRtU0MyZ0E3WlNWc3Q2aUFId0ttOEVIcUNQdVVPOUNiUE1J?=
 =?utf-8?B?WjdFcDdDNUNIbHFtYzM5NHNZck1XbzkrNFhpT1MyVmE5a1lKK05KeGF6aFFH?=
 =?utf-8?B?K3UzeUpUamNxRWUwZjMrZ3VHL0s0MENXRll2UjgvcHRTZnlxODd4Rll4K1E3?=
 =?utf-8?B?UFlLMzVaWXBtT3ZFSnhSbmI2YUFNTkRRVElaMklSZ1ZXdXlMeGM1UkIxZmJP?=
 =?utf-8?B?Q2VsVXRPMTJ0eTZpMFo4QVp6aVpIc2pMMW1teHJ2K2swRGpwMUMrU1RkOEFu?=
 =?utf-8?B?N2YxK3plYXhzSDdDNEZjdzZYTTVycHJQQzZOaktielhXa1YwL1lBNkJnWUU3?=
 =?utf-8?B?cnFDeHlRaGQ3Z1hwZ25oV3A0bFc4T1JiZ2NaQ0E2dmp3YUs3dEVuakhoblpv?=
 =?utf-8?B?REY3cWxyUGN2WEhsNTQzelZDSThVc2w1T0VDc0ZyTU5tdnN4NjhDYk9xd09Q?=
 =?utf-8?B?TXpLM0szWG5hcWpRRXNaenpncTBlS2QwcCsySUlpdzM3cG9Qdm9teGR5K0RW?=
 =?utf-8?B?Y0JQNXcrYjJrSmRHUzJMQ2RscEx1YmVKdk5saXhRRTgxUmlqb2pmdjBsZ0tj?=
 =?utf-8?B?eS94d09HWHZGVWhRelgrMjVPOERaNWxmQjBhRWpCamRnbUYxZExCdTRTU1Jo?=
 =?utf-8?B?dFNyNTVIb21zdzhNZWdUZTg4YlpsM29DaHI0bTBHY0t6cVpVSFZ4T1Z6ZDV5?=
 =?utf-8?B?Y0JzQmJqdVR1YzBTK2VNZFBMUVFxMEpxaHg0dlpuYWwxYitEVDFpN3dOMDZi?=
 =?utf-8?B?QitGdkluL2hqZ3hGUng1ZDM0SktUdkh5aWx3bWlKbmhCUXFmZzZZb0RkKzdU?=
 =?utf-8?B?VEZkTlFNWmNabU5JK0tWMU8vd21iUlIvNDcxWTNFcEk3WTc4eTFseDFzaEFp?=
 =?utf-8?B?REM2dFJuN05lTE9zdEdjNmtaVkl5am9WYU1jYkNZemYxWGZQUWh3T3FyUFVT?=
 =?utf-8?B?SE9qSFZNSXBoTEJJZnh5aUl5Y3d4blNaZUJvUjlEZmtlWEI3U2wzdFZvOWxt?=
 =?utf-8?B?YnQ2UzVJelFIZjRvTWw4WElKemZnK25CbVJuZXNlMmU2cm9MTnFhcXJzNFVQ?=
 =?utf-8?Q?ZWTcN1BxA90u3Mkc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59fde426-591d-4524-ab9b-08df136c6428
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 21:00:36.8959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ht/JB7DxDvl7dYRMtdRUvkpyDWQG1cg1vFtlvZPTGIZc7TFWKesaX+/jeaaC5fCOxgufnnOGw2Sczj7dBVVG7slgWbKJK+NlrqKwoKFwFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8708
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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


