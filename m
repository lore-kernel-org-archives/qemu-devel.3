Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CEE0C88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x62FK-0004IE-KX; Mon, 14 Sep 2026 04:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x62FH-0004HT-R1
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 04:41:00 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x62FE-0005Pw-V1
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 04:40:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QcrvqeIvYePImg2Bwf6Athzn8GpCWcvn/SvsZWUa5GrRuaBjFQGNYuALOUi90+Ma+7ECoRex5MODFZeOh2Jad19Kxtv5TVpcCx61t7FjYFGQcYtttgoYxFNyDO6nGrh1afR7dPu01usW/fPBE9OQaubC1bVkmS5xg5ByAB02vvVIalzWS6Z3DlnFepiP5UaCFvWPX7fVeU51SplB0k/RaQYXhkQl5R5v14BcRfgoYH5n5w23ZVxcK1FpjJJwzye0qfldA+LQOST8037Os5RUwKGD0u9OhMH5c/x4qvX2MjGfK6yXU2MfSrwtHl5hrY24KJcsA4+QUmT7dicOsMF1Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5ksPgqxpkvwMZR46juSzPb3Jx553hY74OuSgtWMf94=;
 b=tZHfH2tCCDnZSFK+0dAxoNOZczTgVzaO2BIiU5bjirG9h0LjmhIBzISNTGWosk3mBq0dN0nWHozPRb/gcmU7YGW91mMnQ2ZVMlLxoqDSk9mbEgj3OnSxf3zEl4F4Z/95AdXlo6oRWCr3k0fVxTURxgslNbgFIur9HlD61bRivpIKnm38NFmFN5MW0dj4Y8k1jopJ6ip8KCUpFIydR5Zz1Uz9/OC1slbMerIo3DeuhvxxMnVTYIIWY9RpewzzAOwFVqBvAsbPjoHSZrGHReckM/lch/eJKB9n/exErl77+UflUGlM/fzb5BQTEcVfZAWDf3TLM/RLx2TG6b9hwquDFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5ksPgqxpkvwMZR46juSzPb3Jx553hY74OuSgtWMf94=;
 b=kqpwSv7xpzLl7LMHJQyrSEe5ZUPVmjmzM6Dwow3qny7vNsuyHZnF+nU8RafqQY10W8d60LORlBo42xlybP4tWpU0zLE+faelkW/jlsR17DudTGAVk8suwKzUhRDH1OqBGaOVW7HPoRYtdUo+m4nbFFfpK4VcbZSbD0I+GcEt9atf+AvPRzu10J1dEFhwPSETnAJKROpTP/YP4Dty4W2qbE6q7Iz+aDvHm+xq63BDzxcEx5Z1gknXiCNNUtEGSWJviQs3ohqwfNicIwTdoPhxRKqrbstkEfJ+ogKjpyKomfLTmITzhanjlFeXLHD4WqUs4hPvjqNHlvn2YkmvQim5WA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GVXPR08MB10916.eurprd08.prod.outlook.com
 (2603:10a6:150:1f7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Mon, 14 Sep
 2026 08:40:27 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.004; Mon, 14 Sep 2026
 08:40:26 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 14 Sep 2026 11:37:38 +0300
Subject: [PATCH v5 07/14] vhost-vsock: don't reset connections during CPR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-up-vsock-vhost-v5-v5-7-d17423589f48@virtuozzo.com>
References: <20260914-up-vsock-vhost-v5-v5-0-d17423589f48@virtuozzo.com>
In-Reply-To: <20260914-up-vsock-vhost-v5-v5-0-d17423589f48@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, philmd@oss.qualcomm.com, maciej.szmigiero@oracle.com, 
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org, farosas@suse.de, 
 peterx@redhat.com, clg@redhat.com, andrey.drobyshev@virtuozzo.com, 
 sgarzare@redhat.com, dongli.zhang@oracle.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIXP296CA0028.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:36e::13) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|GVXPR08MB10916:EE_
X-MS-Office365-Filtering-Correlation-Id: b7481cc6-d33f-415a-0bb4-08df123bd1d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|23010399003|1800799024|366016|10067099003|22082099003|18002099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: 2EVhLKmvIskgjoN1OgSyIRqoImxc9KRWB4W6zlWRqY9a4dNOQzpxC2Zw478JZCIULXsMlqwoVmJ/0uQDX33/yFPk/CMg+L45nQYPq66XdUNdp3IaQA94FGmD96TueL0LPCgiOb9ki0wyaXfdmbK6frNYzzUkprIAcIUUZ8yCMWOr7bn4Kurltv0RbOk5zH93Wb8QLE4cGMUwvDSREKwqfWukIWYdWn00tk+sX1GZmqZyVreWWc1gyc+g3G3r0ZtaJ5zTPE9HMuFltqiYKS4HegZ0xsx3noGQ0IGVuhkobNertNA+1A698eosdYLIfC1a6KQCd7/9GpqmXMFvMZIItBydBnwW+8Z4zCmbHoyZT/3vaFrHvu20lvCgjH1DUUHED62PNmA+xHpv3zl4zGBL99kFhguzgcN5T3WI/Jq7H72rVl1OiueZWffbNKChwn/H3WVCyseXLt7CyfWZQMy3Mah7A8IHRO8sD/Lx8iVnuYiqnvN4MJll2ZohM/h0GTSQHqdSPy1WiNKqoDRo4Xm8HGpTMY2nVO3rVRwkNEDcJAdQNkgIgzOZ7LBDR62suZ6w88mcFyG/6aIo8mAxI/tXp+8PgMa6hVg5gP+2PLWcYKgiL/f/unqLOCZLSQHpZq6Td+Vo7abMKwjdzVxldgzrOboXj9kbvCT8vY++18ZLNOeSGf8k7PdzqypYT0KgFm83fkmFWsfEiozrpCQiq6Hm8DmqmX/5sYL72hHZEtoLS/s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(1800799024)(366016)(10067099003)(22082099003)(18002099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RE9FSHZCUExyN3FwSDJ0VWtXblpkaFlNRnBucitoM1V0N1IvMnlXcDJMdW9D?=
 =?utf-8?B?dHVTbjNZZ05kRS8rUUR0U2xwb1k1eDJLb2RLMG9SbzQwM1VNTEc0UWg4T3px?=
 =?utf-8?B?SFJpdEhOZzI5cDNkcTJnSVVQV3pQR3dQQStYTlhiUE1jcE11VEM0aGJNY3J2?=
 =?utf-8?B?YWlhRGZiNlI4VkRSRUlmZEk2SVhPb2hsdnYrWStwMVhna21PZE5obFNCNzNw?=
 =?utf-8?B?TGJja1hTOENzNm9MUUpEc3pQOEY5SHQxV09sQVZYa2ZnYUdWVnk3c2VxaWts?=
 =?utf-8?B?NGs5TGpVTm5jcTlOVlJFb1QyU0M5UG95bVRtU3BKb0pmTmRKWTRKSzcrZFN1?=
 =?utf-8?B?MGVSbURGc2lzQXJvM2JmZ2F4R2pGclhKTnpXQWY1YWlaM3hVeUVkWUdPOTh6?=
 =?utf-8?B?R0dQR28rWXpmUkZTNEM0TjNzNnk2ZEgralBzR0x2SzI1SzNXNy83RSt0Wk4y?=
 =?utf-8?B?QUdCdldzRzRJV3IvOXFEYlpJaTRPVkdydUdhOWdvTCtjWjdmNEJ1Umloby9z?=
 =?utf-8?B?Z0JHY0FXbUpKR1ViVmxTMitBRGRDSUphSks0ZXhKL3hMSTU4M3c0OFN0R01x?=
 =?utf-8?B?YTk5Y2t2MGoyZ0p5b3dmWnM2SHlQVWhiVGorekJLTUQ4b096eVZpZk5pRWhX?=
 =?utf-8?B?WlIxcTR6eTRRYVNOZGMvTFFsc1hTQVluL1pBYkt0dDlDVGpZUzhKTHllTHk0?=
 =?utf-8?B?SHFULzB2Vm5lVTMwR0hjcnNvUkdJNmZJUWQ5Zi92UCtuVkFJQkRHRGFWYjN3?=
 =?utf-8?B?aWNycUFZME5IQ0k4dUE3SlRUeHJhdDg4TW1pNTlRaGZqSmpWUWpEQ1gzdEsw?=
 =?utf-8?B?eVorMWR2c1FTSVdwRkkxcFdDNnAwMy9va3BmN3JaSjJsc043ZUtPZEdqa1l1?=
 =?utf-8?B?TmdNQmU3anI0d0xZUHF4ZURDMnBmK1QwZ29idVcydXhlcnpqa20yZitZdnli?=
 =?utf-8?B?eTB5TTczRDgrclE3RHJsTEZPUi80UFYvYmkyNE5mTHE5RVhmUDZCeEQ3eURG?=
 =?utf-8?B?RmVxN0lFWlFXeVdLbE9oMmU0dFhwOW5jVGpmMzF2NHFTM3I4eVhxL1ZHbVVk?=
 =?utf-8?B?SEt3NUUwdXdNeFBhRVRlOXNoUzVGTng4ZTQ1aHp4MjhBZml0dlljSzVMOURn?=
 =?utf-8?B?aHV1d3NqVWFFcnlja254TThhcmFweGovcWhxc1pNS0tZUHZlblNsWkZmK1hH?=
 =?utf-8?B?cXg5OTRHYkFIKzNHUVVrdXNPc0dzdmV2MmorQWE5V1hDbFVUM2JzMnJMOHRi?=
 =?utf-8?B?ZzVBT1JBNksyVDl5RGZ3d2JaTEpZOFNqZmpWOGRUZHJEV3pmeTY5YnFDWU5h?=
 =?utf-8?B?VUpnNEFLNkwrc2F6ZC8wRHp4VjdtaVEyc1oraGRybHdQZXUxVEdZUGVuNHVB?=
 =?utf-8?B?UzJuamRGTmovTEZoYWwxeTZsYnF4ZjhIbUltTU9WeHNkNEVKTC9TaVdKR0ht?=
 =?utf-8?B?RUl3bXNyeHZDWFNpNUJYR09kL09OS2htVWNranU3blhVK202VU14aGFUUkc5?=
 =?utf-8?B?M1Uzd0tIbWI0Ny9MdWhCNEtYNnNxandJaHU4T2dobFYvS0F5RU1IWGZmbWlH?=
 =?utf-8?B?eFcwTFhzc01KS1N2SXdWNno0RHNEUThBeE9IK1pPYWNkT0FNS09nRm01cVI3?=
 =?utf-8?B?TGVyb3FBMklrOE44QjRhTGdUTFFQeVFweHN2c0tEZUd4eWxZU0MvK3p6SlVs?=
 =?utf-8?B?MmIwUE1ycXpkOHAvQlYxcFJQaWxkY0VNNjZ2d1MyRFdxUENSclVEL2plSExu?=
 =?utf-8?B?NVNxMWFlME5xOWEvRlRrWFo1VXE5VWFmK25FWnZIc2Y5d0I3VVpBZXVaaGZ4?=
 =?utf-8?B?OUhibmV5M1VlUXhORUVRYS9ERElWY2lzekk0YUdla09MdEtPVDNqUTJ1RTZH?=
 =?utf-8?B?akpCb2NVQUZ5NHdPMnNkRTBHcE1sNk5ldHVQcVZIOTZmVEZ3R2NZUzVnaGpU?=
 =?utf-8?B?NUQxd28rc05JY05YVis2czczYmNSQm92aDlpaDNFbmJPdmtzUFdhN0VoY2tz?=
 =?utf-8?B?bngxeWkvNUM3ODRaQlk2UVZvUFFMR2E2dUtGTW1OTWxkQmZlT3NTb1VvVEo2?=
 =?utf-8?B?T1RVd2p5ak5nODNtcUlNcXZRblpUc21sSUtMdHpaWlN4NHBLY056TWlOcGdZ?=
 =?utf-8?B?WHdVaFNtSStORFhxcWxWc2FpYUxOTEptOVBpZGxneDltdGJBVm5sZU9JTFhl?=
 =?utf-8?B?djZ6eG9UK1huQnp2VEduL0ZaZE44eXJuMExDblptczdkOHRTRWxNZDM5MmNP?=
 =?utf-8?B?NmVJR1hETmtiSmFJUEFKdGxMaGp2QWhJM2IwcWlyM1VXOWR5UWJDN0thSFZz?=
 =?utf-8?B?WlQ3ZkgyUWtjQ2s2TTQ2a1AxNlZKdUNGRkliU1lXVG9zM3hJUVVqWjJ2MEp5?=
 =?utf-8?Q?t0NJwenKus24px+E=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7481cc6-d33f-415a-0bb4-08df123bd1d0
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 08:40:24.3452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQ7wAlJ2jxcoarBg0QmyL+XJZ2+mcnwYmoDlUSlfSnwof9flamzAbF/xqrdY/Dk9BbbWgBXrRrCIwfZEseE/aNQkvE8DwmXHVIDBoXAZHnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10916
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Migration target with a vhost-vsock device in the .post_load() hook issues
VIRTIO_VSOCK_EVENT_TRANSPORT_RESET event to the guest.  This results into
the guest tearing down all its vsock connections.  That reset exists
because after a normal migration the cid may change.

However it's not true for CPR-style migration.  In this case cid remains
the same, and we want the connections to persist.  Thus, let's customize
the .post_load() hook to skip the common transport reset part in this case.

Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 503d248a617..c582ac9fcc8 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -20,6 +20,7 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/virtio/vhost-vsock.h"
 #include "monitor/monitor.h"
+#include "migration/cpr.h"
 #include "migration/blocker.h"
 #include "migration/misc.h"
 
@@ -110,6 +111,20 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
     return vhost_vsock_common_get_features(vdev, requested_features, errp);
 }
 
+static int vhost_vsock_post_load(void *opaque, int version_id)
+{
+    /*
+     * Only reset vsock connections for non-CPR migration.  For CPR the
+     * guest cid is unchanged, and the cid-change reset would otherwise
+     * tear the vsock connections down.
+     */
+    if (!cpr_is_incoming()) {
+        return vhost_vsock_common_post_load(opaque, version_id);
+    }
+
+    return 0;
+}
+
 static const VMStateDescription vmstate_virtio_vhost_vsock = {
     .name = "virtio-vhost_vsock",
     .minimum_version_id = VHOST_VSOCK_SAVEVM_VERSION,
@@ -119,7 +134,7 @@ static const VMStateDescription vmstate_virtio_vhost_vsock = {
         VMSTATE_END_OF_LIST()
     },
     .pre_save = vhost_vsock_common_pre_save,
-    .post_load = vhost_vsock_common_post_load,
+    .post_load = vhost_vsock_post_load,
 };
 
 static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)

-- 
2.47.1


