Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FD0CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 17:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBbYm-00069o-Lo; Tue, 29 Sep 2026 13:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBbYk-00068N-Ld
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 13:24:06 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBbYi-0002lB-Ar
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 13:24:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLgHrs6GwDTAIgcW9wrihyhskTai5bZ4Nc4gE7mQQJfmxpdMfwubq9L713C+nQ73O98c2VeiSGqHt/ebV/ILrKzs7DsGJkwlhO7O/mJLrlOjwWwWURDyVGD9c5ODCiutwB3aUP1Jw99Zd0PQ++BIXs0Fys+cfjd1siv+3atBIL12gOoQQENdQwzEzhfKjYDGBlQbHP9hKqQhAhMvBxCIzx56pNrh+C1X9ygy6GKQo6/pxKUtxmer5TWQWK8o8YCsOe3iWdwHsDKERnltC0onp5DtKhAWFD0kgNqjufyawOrv79fkH0scK4aFIcFT0lG29ZhSr2S0/1lXYil+8bF4NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwrMOjbNDkBKfvJaT15RqDxDYeominibToCZs4sNc1I=;
 b=GaqKu4yWeAa9mKihj6rW+yNhICN5PI1X/Mc4Dx2ifanCJ0SoCZ8emnTtyctVvmovoFxkhVufueuahl2Bzdhlyqw/WEDauNp301OBpSgxkd0xseMlBKh5o+gu93KQAJJtQjo9i8jPSRldKWx5VLISdUS5m5nkFXUMqujpOKKJgIaxuXsU0adqNmrnKBGGnHPhozzErGffYXSlV1MlNu+/FcDi9Sey7wLO1OzWaD803PdLnakH00ryB3Tr7gq2iX4dAmn/16tE/q4EkaXlasOzlU2O6jDMdHSUWe8fuCgvgfe8ZmPGDWY4iJiJYURc3vKiAhG037TMW9GjtJ+2ERPoAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwrMOjbNDkBKfvJaT15RqDxDYeominibToCZs4sNc1I=;
 b=QgeRNgEZc0oEbCJ+HzPXsoi2APfKT8oE1K5IWaLeadj/no5XS6Wpor4CXPMV3MisGxAJ1/e2FmPuqdKfLH0gLveysE6QaiMyeFVBYj2uDEstif26+2N6NJY5TE/xj93iZG3e/XoxlvCAn/MI01SkZ+nQRgjReuyB0qAw27TfAcVVq+I/MF8YA5ju0bHRAFGcZxVTP9aoc+7xTomKVpTPD7QcF7UXgBGYl52H8mxT7pi4sM3nL97uCtnDM6aPcDN0m+XQhYU5qNzyOnuxFQ4krO3HJEWZ1+NyKgHOCQRYe84Dh9LW/8hHHactUDbREo2J93cFAIvhcLPJinB5QVw58Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MA9PR08MB435041.eurprd08.prod.outlook.com
 (2603:10a6:250:101::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Tue, 29 Sep
 2026 17:23:55 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Tue, 29 Sep 2026
 17:23:55 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 29 Sep 2026 20:23:34 +0300
Subject: [PATCH v8 15/17] vhost-vsock: hand off device ownership across CPR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-up-vsock-vhost-v5-v8-15-12bcf1c0b84a@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: fabba8b5-a657-4a8e-1fb2-08df1e4e706c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|7416014|23010399003|1800799024|38350700014|6133799003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qMZ3LJcDv0NEo2WN/n4tqKynJHNxU6r93Jih6UOpdUvbH6g4PRYEHHf0bWImvoOedP/nryqZEeeE69TIC0jFrB9oq7wiYgZDVD7BLxlKlMteANDGsajWPCWJ/16w8zSqQcs1p/MLsRgDHhrGShIayBtZZVi31Y7HkP3IjrxH2Fin8djQKJVFGQIhyMq76+cyE30f7r1KvcnDF+NTDU017t1khqiIVVnw1CmKPMhoNibUF7YW3kwfETozXTxZVIkpKrC89Kr7Ryz409DfrKQ9l4KZWxXYaQnKz5LCnJ8YMJwAMf45aO0/bXeP49LLMiCrB6aJ4qPtqXW83RfFTb8IzdyaKKWLcUspo2XGnskkunCtD8i6ayLtTm/5Ja2K1Z0+X6BeyFEpVC28sHTjQjCg+DfOUou70QtIUAdD9ng6SoTbPIMO6HAaKUlJebocxO4FbA9kG6r3GMgdSxzdr5WImtLTXH2uBsra8/fFrgrVDWDh8ou7NqSBP3bs91ufmUEpjwLDicKQ4thctzT5nQ+n5G1+/7t/1PaQAHAWzrdc9s3j904sBGPo9/qCZ27SoLw9Gciyt9Slgz9Hcu0zRlE92zL1PhHsC8JpUr3o7CP6KBo75OXLkst4c+3RvvtDjVmfkxtg7N88Ygott9scY/2nlxelqPQHm8VHX4H3dNWjvV3Drg3Kl6IhIZ6Yicz6CBazqGi0DikUuyhaZs6vHfE9oplVoio9gbdOdHmiKlymmJk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(7416014)(23010399003)(1800799024)(38350700014)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SURnOUYwYzRWTUVjOTdkcWtDSDNqdTF2Qm9tNUhjKzRPRnlpSFhpVE5pakFs?=
 =?utf-8?B?bkZDcHZkVDJSOWROWDUyZzlYK01VdjNVYU96VndXMVdrTS9qdHY1WVJjNUxC?=
 =?utf-8?B?bTY5T0liclptcE1wUVhWbEExZ0l1KzRwcUNHdy9ybDRXamZvOXZxSFgwbnZM?=
 =?utf-8?B?dWRoUUF5Q3YzODdVTWhNWEZ0OEFlREZsTDhBZkhuaGpyR1pQVTZXNGQ0dW15?=
 =?utf-8?B?R1FhaFFybUVQbU5leDR5b2FKVitDVXpoaENjTGw1MS9wdE81UHYvTjV6Y1R2?=
 =?utf-8?B?TWlpd1JQT29TaXF0UmJFS3EwMkNQNW9oMGdrVkFPa3V3Z0t0UGlMWkpLSUQr?=
 =?utf-8?B?WWhqNkQ5Si9BeFhnaVZwdzBnMWduOXcwV1YzeStIQ2ZxUi9RR21QRUVwUkZk?=
 =?utf-8?B?b2FQNUR4YmV3MktGNmZYOE5pcDF5NzlyUElOZG9VRlV5MGh3UHRPcVVoQXlV?=
 =?utf-8?B?a1ZDUnVSMy9LeTR1bGRzWVU1cmVBeWxnN0Jja3g1dlFNUytpRy9zV1ZXR2c3?=
 =?utf-8?B?M0FidjFZbUVxSWIyOS9TY2kxK2ZqcGt4ZVFmTDhoK3JzZ0xIRGlJRXd1ckFN?=
 =?utf-8?B?RVdlSzNRREJSZWp1U09MSXFyMzAzMFlIeFNtWnU4bnBtaHNUZW1PeWZxcVUr?=
 =?utf-8?B?VUloQzFGS0Z2T1AzbHhmSUp6OEVSU29yZys1TUlLTktvUWI2YkdwcnIzOW5q?=
 =?utf-8?B?UXl4UVMrVjcxeU0ybUJzVHNYRldjTmU4SENoY2FNTkFwa1VhQm9SNmdSMnF4?=
 =?utf-8?B?OTh6R0RwdDRmckM5SlFKWWNGeDJqMm0xdDZzajlQa0pzcVl5aHQrZHYzNm9D?=
 =?utf-8?B?MzRPZmt0VTNvbDVSZllaeHlMQXVkUnNuaTJXU0pCL3hkOHlkZElReTdUYXVn?=
 =?utf-8?B?V1FpUWtYOFgvWkhvOThDL3B2ZWRITFBseWk0V1JHOGZobC9rcDY5dzhNSXE5?=
 =?utf-8?B?dmdVYTVTRFlhbng5UGNUb2RoOENWTnMyKzJzN0RtWmtDNXJrVmhKeVhac3p1?=
 =?utf-8?B?Ymh0MUlXNHhMclBVYXFrNmhHcUFIbVgzUGJ0VkZpZS9DaHF6RHo5aXdtc0Rt?=
 =?utf-8?B?Ri95VjdWTW92Nmo0VGpqR3dQQjJrQTE0MDkrTGlsRGZlM3I3SE9BZFdreXY3?=
 =?utf-8?B?WE1DeU14dUg0Zk0zU3loTkFBTlFKVldVeXYyVWM4a2JwSnFDVGR2NmY1dTUr?=
 =?utf-8?B?TWxTSEdDcUtaZG9PZ3I5VGR3VzlTSGxvTmtsb3grNmR3OUd1R0w1ak5UUEhl?=
 =?utf-8?B?SlVhNllWL1p3TGd2NTZQajhmL1loSlRwcUVvSDJHNEcwUnF4TktuVWdlUnc3?=
 =?utf-8?B?RWtnQ1YzSU9raUovVnNtTWl1YnFwdk9JZXpxbVc5aXRFNjdQOVY2ZXBrclg5?=
 =?utf-8?B?eHUzQStMY3F2RjRFOXNTcW9obFB3d2lyS3NjazcxZGdxSzAxNVpsQWZObURj?=
 =?utf-8?B?Ny92dlQrQ2RVU3ErZmR3Zll0bWErZytKSVdqQzIxeGNvdm91SWVTSHEzZkVt?=
 =?utf-8?B?OWdLRlpubHBGUTZYMXQ1RU1QSTUxa1lmdjVHZnlvakR6NnE5TWhWUm5vN0Fn?=
 =?utf-8?B?T2ZieTZhaG8ydndudW1sTHBOZUwvakFZMHpQTXJROTdyZjBFaHVmZjlUWkp3?=
 =?utf-8?B?WmFqNXRLelNMWm9sL2lTWUR4ZWQyb0JwOUdPckZwNFlKenc3VW8rUlJkdDlK?=
 =?utf-8?B?TW9CYzFUcmFJT1ZocFRrVWxpQnQ3Y29pNzNmclh5SVVJWTU4Z2gxUDd4dks3?=
 =?utf-8?B?elg5ZkdGR1MycFdrZlEzRTl1SmRRSVVod3YvTGRpRTRnZ0tPWVlnaTdGUGZ5?=
 =?utf-8?B?VUtCRHBtbFB4cjZLaEdra2VRZXRJWWlyb3dHVnptK3BwRTJicWptZU5HVWxX?=
 =?utf-8?B?VnNjYXJPeFRSOFBLZVRlelc1WE41RjVTT0lXMUl4M0dIM1NpcHZzdFJUYUNv?=
 =?utf-8?B?M0lNQzZpTW8xT0lOQWlseWNsZ2pudWdWKzVZczQrUUo5aDlqRUxuSlFRbE9P?=
 =?utf-8?B?S3cyWDB0Y2VEWGpzTFVqSmZZTGxJYXpnb2E2RGpFbEVRcFVqdFpWQjVwOEJD?=
 =?utf-8?B?b2lETlJ5YkJWdmMweVZrbWliM2c2Q0lKM1IwSEdnc0lFYWtnaENUTHV4UTh0?=
 =?utf-8?B?aGxJOTRyc29lWkNtWnZXTGNDU04vU29UUU9kWVVGOU5MbkxlQ29NK0RJazhD?=
 =?utf-8?B?cW1HbU9XU3BkUTdVOHFSeHFtT05tTDlRdit0T2hWa3hHSW5MdnprV2RFTnBz?=
 =?utf-8?B?THcxTUZsdXVEc29EdjJIRTdKaEtid0hCdTBZdG42Z1dMOElzcENZd2w3RHRo?=
 =?utf-8?B?ZUNwOTMwV1BpcGRzSE5qeDR5L0VZMTJJYnlBMmRycERJK2w0TC9pZEJJQVFX?=
 =?utf-8?Q?Xjrr2W90iFWDVnTc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fabba8b5-a657-4a8e-1fb2-08df1e4e706c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:23:55.3033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tOMvOlg/2/uzLps6mPa/b8KSToDr68F4PjI8NXMLZyXPvV4reIwffCUx7QzOjdqUoIQnX1F3n3NV8zWM2bazgHKOKRUhXjQicOkLSxh4VqA=
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

The previous patches reuse the source vhost FD on the destination,
however both source and target still call vhost_dev_init() (VHOST_SET_OWNER)
in realize().  For cpr-transfer the destination realizes while the source
still owns the shared FD, so its SET_OWNER would fail - ownership has to be
handed over explicitly.

Do this through the device's CPR vmstate hooks.  Namely, release device
ownership in pre_save, reclaim in post_load, re-acquire on restart:

  - .pre_save() releases ownership on the source (VHOST_RESET_OWNER) once
    the VM is stopped, for the FD-preserving CPR modes (cpr-transfer and
    cpr-exec).

  - .realize(), for an incoming CPR, only sets up the virtio device and
    queries the backend features by calling vhost_dev_init_backend().
    It doesn't take device ownership and doesn't touch the VQs which
    still-running source might use.  The full init is deferred to
    .post_load().

  - .post_load() reclaims it on the destination: the full vhost_dev_init()
    (VHOST_SET_OWNER) on the preserved FD, plus sets the guest cid, before
    the device is started at vm_start.

  - .set_status() refuses to start a device whose init hasn't completed
    yet (incoming CPR before post_load).

  - .set_status() re-acquires ownership before starting the device if
    pre_save released it and this QEMU is about to run the guest again:
    the migration failed, or it completed and the management resumed the
    source (e.g. cpr-transfer target died).

With the handoff in place, lift the CPR blocker.

Note: this requires kernel side support of VHOST_RESET_OWNER operation
for vhost-vsock.  Otherwise CPR attempt fails in .pre_save().

Suggested-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c         | 157 ++++++++++++++++++++++++++++++++--------
 include/hw/virtio/vhost-vsock.h |   2 +-
 2 files changed, 128 insertions(+), 31 deletions(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 6e89007b2ce..65ba573da4d 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -21,7 +21,6 @@
 #include "hw/virtio/vhost-vsock.h"
 #include "monitor/monitor.h"
 #include "migration/cpr.h"
-#include "migration/blocker.h"
 #include "migration/misc.h"
 
 static void vhost_vsock_get_config(VirtIODevice *vdev, uint8_t *config)
@@ -85,14 +84,46 @@ static char *vhost_vsock_cpr_name(DeviceState *dev)
 static int vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
 {
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vdev);
+    VHostVSock *vsock = VHOST_VSOCK(vdev);
     bool should_start = virtio_device_should_start(vdev, status);
     int ret;
 
+    /*
+     * During CPR, on target the full vhost_dev_init() is deferred to
+     * post_load.  Refuse to start a half-initialised device rather than
+     * issue vhost ioctls on it.
+     */
+    if (should_start && !vhost_dev_is_initialized(&vvc->vhost_dev)) {
+        error_report("vhost-vsock: refusing to start, device init incomplete");
+        return 0;
+    }
+
     if (vhost_dev_is_started(&vvc->vhost_dev) == should_start) {
         return 0;
     }
 
     if (should_start) {
+        /*
+         * vsock->owner_reset is only set in .pre_save() on CPR migration
+         * source, after a successful RESET_OWNER op.  If we end up here
+         * with this flag set - that means that either CPR migration failed,
+         * or we got 'cont' cmd from the management (e.g. cpr-transfer
+         * target died).  In either case, we need to re-acquire device
+         * ownership.
+         *
+         * On failure leave the device stopped.  The next start attempt
+         * (guest driver reset, VM stop/cont) retries.
+         */
+        if (vsock->owner_reset) {
+            ret = vhost_dev_set_owner(&vvc->vhost_dev);
+            if (ret < 0) {
+                error_report("vhost-vsock: cannot re-acquire device "
+                             "ownership: %s", strerror(-ret));
+                return 0;
+            }
+            vsock->owner_reset = false;
+        }
+
         ret = vhost_vsock_common_start(vdev);
         if (ret < 0) {
             return 0;
@@ -123,8 +154,44 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
     return vhost_vsock_common_get_features(vdev, requested_features, errp);
 }
 
+static int vhost_vsock_pre_save(void *opaque)
+{
+    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
+    VHostVSock *vsock = VHOST_VSOCK(opaque);
+    int ret;
+
+    ret = vhost_vsock_common_pre_save(opaque);
+    if (ret) {
+        return ret;
+    }
+
+    /*
+     * Release the device ownership now for CPR migration.  The device is
+     * already stopped at pre_save, and destination reclaims it by calling
+     * VHOST_SET_OWNER in post_load.
+     */
+    if (cpr_incoming_needed(NULL) && migration_is_running() &&
+        !vsock->owner_reset) {
+        ret = vhost_dev_reset_owner(&vvc->vhost_dev);
+        if (ret < 0) {
+            error_report("vhost-vsock: vhost_reset_owner failed: %s",
+                         strerror(-ret));
+            return ret;
+        }
+        vsock->owner_reset = true;
+    }
+
+    return 0;
+}
+
 static int vhost_vsock_post_load(void *opaque, int version_id)
 {
+    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
+    VirtIODevice *vdev = VIRTIO_DEVICE(opaque);
+    g_autofree char *cpr_name = vhost_vsock_cpr_name(DEVICE(opaque));
+    Error *local_err = NULL;
+    int vhostfd, ret;
+
     /*
      * Only reset vsock connections for non-CPR migration.  For CPR the
      * guest cid is unchanged, and the cid-change reset would otherwise
@@ -134,6 +201,35 @@ static int vhost_vsock_post_load(void *opaque, int version_id)
         return vhost_vsock_common_post_load(opaque, version_id);
     }
 
+    /*
+     * CPR restore case.  The source released device ownership in its
+     * pre_save.  Complete the handoff here, before the device is started
+     * at vm_start.  Init vhost device on preserved FD, issue
+     * VHOST_SET_OWNER on it, and restore the guest cid.
+     */
+    vhostfd = cpr_find_fd(cpr_name, 0);
+    if (vhostfd < 0) {
+        error_report("vhost-vsock: could not find restored vhost FD");
+        return -1;
+    }
+
+    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
+                         VHOST_BACKEND_TYPE_KERNEL, 0, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+        cpr_delete_fd(cpr_name, 0);
+        return ret;
+    }
+
+    ret = vhost_vsock_set_guest_cid(vdev);
+    if (ret < 0) {
+        error_report("vhost-vsock: unable to set guest cid: %s",
+                     strerror(-ret));
+        vhost_dev_cleanup(&vvc->vhost_dev);
+        cpr_delete_fd(cpr_name, 0);
+        return ret;
+    }
+
     return 0;
 }
 
@@ -145,7 +241,7 @@ static const VMStateDescription vmstate_virtio_vhost_vsock = {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
-    .pre_save = vhost_vsock_common_pre_save,
+    .pre_save = vhost_vsock_pre_save,
     .post_load = vhost_vsock_post_load,
 };
 
@@ -171,37 +267,24 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    /*
-     * CPR migration of a vhost-vsock device is not supported yet: the
-     * device ownership is not handed over, so the target fails to set
-     * up its device.  Fail the migration early and gracefully instead.
-     */
-    error_setg(&vsock->migration_blocker,
-               "vhost-vsock: CPR migration is not supported");
-    if (migrate_add_blocker_modes(&vsock->migration_blocker,
-                                  BIT(MIG_MODE_CPR_TRANSFER) |
-                                  BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
-        return;
-    }
-
     if (cpr_incoming) {
         /* Reuse the fd handed over from the source QEMU */
         vhostfd = cpr_find_fd(cpr_name, 0);
         if (vhostfd < 0) {
             error_setg(errp, "vhost-vsock: could not find restored vhost FD");
-            goto err_blocker;
+            return;
         }
     } else if (vsock->conf.vhostfd) {
         vhostfd = monitor_fd_param(monitor_cur(), vsock->conf.vhostfd, errp);
         if (vhostfd == -1) {
             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
-            goto err_blocker;
+            return;
         }
     } else {
         vhostfd = open("/dev/vhost-vsock", O_RDWR);
         if (vhostfd < 0) {
             error_setg_file_open(errp, errno, "/dev/vhost-vsock");
-            goto err_blocker;
+            return;
         }
     }
 
@@ -210,19 +293,37 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         if (cpr_incoming) {
             cpr_delete_fd(cpr_name, 0);
         }
-        goto err_blocker;
+        return;
     }
 
     vhost_vsock_common_realize(vdev);
 
-    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
-                         VHOST_BACKEND_TYPE_KERNEL, 0, errp);
-    if (ret < 0) {
+    if (!cpr_incoming) {
+        ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
+                             VHOST_BACKEND_TYPE_KERNEL, 0, errp);
+        if (ret < 0) {
+            /*
+             * vhostfd is closed by vhost_dev_cleanup, which is called
+             * by vhost_dev_init on initialization error.
+             */
+            goto err_virtio;
+        }
+    } else {
         /*
-         * vhostfd is closed by vhost_dev_cleanup, which is called
-         * by vhost_dev_init on initialization error.
+         * CPR restore case: only learn the backend feature set now, but
+         * defer taking ownership or touching VQs (the still-running source
+         * might be using them).  The full vhost_dev_init()/VHOST_SET_OWNER
+         * is done later in post_load.
          */
-        goto err_virtio;
+        ret = vhost_dev_init_backend(&vvc->vhost_dev,
+                                     (void *)(uintptr_t)vhostfd,
+                                     VHOST_BACKEND_TYPE_KERNEL, errp);
+        if (ret < 0) {
+            /* vhost_dev_init_backend() does not close the fd on error */
+            goto err_vhost_dev;
+        }
+
+        return;
     }
 
     ret = vhost_vsock_set_guest_cid(vdev);
@@ -232,7 +333,7 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
     }
 
     /* Register the fd for a future CPR after a fully successful realize */
-    if (!cpr_incoming && !cpr_save_fd(cpr_name, 0, vhostfd, errp)) {
+    if (!cpr_save_fd(cpr_name, 0, vhostfd, errp)) {
         goto err_vhost_dev;
     }
 
@@ -247,22 +348,18 @@ err_vhost_dev:
     }
 err_virtio:
     vhost_vsock_common_unrealize(vdev);
-err_blocker:
-    migrate_del_blocker(&vsock->migration_blocker);
 }
 
 static void vhost_vsock_device_unrealize(DeviceState *dev)
 {
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    VHostVSock *vsock = VHOST_VSOCK(dev);
     g_autofree char *cpr_name = vhost_vsock_cpr_name(dev);
 
     /* This will stop vhost backend if appropriate. */
     vhost_vsock_set_status(vdev, 0);
 
     cpr_delete_fd(cpr_name, 0);
-    migrate_del_blocker(&vsock->migration_blocker);
     vhost_dev_cleanup(&vvc->vhost_dev);
     vhost_vsock_common_unrealize(vdev);
 }
diff --git a/include/hw/virtio/vhost-vsock.h b/include/hw/virtio/vhost-vsock.h
index a964d57e1bc..6e1c39383ef 100644
--- a/include/hw/virtio/vhost-vsock.h
+++ b/include/hw/virtio/vhost-vsock.h
@@ -29,7 +29,7 @@ struct VHostVSock {
     /*< private >*/
     VHostVSockCommon parent;
     VHostVSockConf conf;
-    Error *migration_blocker;   /* CPR migration is not supported */
+    bool owner_reset;           /* CPR released ownership; needs re-acquire */
 
     /*< public >*/
 };

-- 
2.47.1


