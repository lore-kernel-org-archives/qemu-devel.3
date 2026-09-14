Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1907AC88E50
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x62FQ-0004Ix-0p; Mon, 14 Sep 2026 04:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x62FN-0004IW-B7
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 04:41:05 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x62FK-0005PZ-7P
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 04:41:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kwJwcL6HRJ5eczJyPUUB7hlhHndC6uKxdUYrbk62qKiVYxLcsba71BJs6xiPnzyiWZijTkaPs9SHR/ZKUavG2lVzXXAAfYjxRwfV9uUDvHnawupBRmlFH+rmykWVEC6K5Av1PohRIbAnuGuhNWzKVfRc9vEZXp8Fy8t3Q1+AgceHRKVnNkbmsNoLVCupTVUOEgz42V2BW7evApEiQglBZtrl9+NGjimGgH8qkwmGWaf3CfZ0Bi0n+5C3U0lylcfAfVgGj/ukmaAwU6aqbfKfd3Aw63u/PFH6VapE0dZvfeL4ZSO1mNKzwgF2xqNVNEBhdYnQP3FF+lXJlW21Nixbmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFLHrTXYn30DKBGfZX9XawwQGNuxnOEL0tX4YglZD1Y=;
 b=Twbg03Afq7nVSb74uHtuxtMg/DZXEYouJB7J1v31ofRNN3uvmD8OghuJW7ub3W6ufJC3/9aQBi329/5J1gkBgf5KhhrCeHO3/WM0XR6hKmUnL1swsLe79jgT1ASokJExzUr8Gk7wUvi7JmX/Nyx+NGPO818t+WcqAfRO2O3Tci+gghDcmWgsI8Whf0jGGNQgWhKflrKHquN5vZAToufXUA8/65SG+txebgwWwhhNzI4a1WqwXcmcZbl52xAG15gzvX9srvOTa8m/90IWM/VpJR2h9bnxe5x4O6odWZb5ZsbkQA3n3WR1hNzS8/jWCNBQ3aCCB76qJNnm6+0knIxmMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFLHrTXYn30DKBGfZX9XawwQGNuxnOEL0tX4YglZD1Y=;
 b=EQxe40ludbMRaPKEp+ft9jrfw6Qso21bUCnugRzmAyipfzhe3+avNuEBu9RbgKXpwhZHwyX7wKMpw2xOIhCxPv1MEHR9nZcFNbkFqogLmacX1Sqz/kfcfd3o5+CPvWExiSb8Cm1Izmg+yPHU+0vFZIrZD95GpHuy4/hfB1mPyxbkQS1XgkDzDL0UVC/kkLE9GkI1wLXlo1w6fU8sIh1ilpglDl7kj4UoWQbBgol0SlDLLa7+W9sVtgif9Rc1PPYzUrZ9tA+WvrXi0DPyac/o7rCGgxsAMlxoi8rgUUHUtArpIJYcdkSEoh6Vie1S0dx6T5/i+5lgDHPS07nmSm8maA==
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
 08:40:27 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 14 Sep 2026 11:37:39 +0300
Subject: [PATCH v5 08/14] vhost-vsock: fix FD leak in realize()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-up-vsock-vhost-v5-v5-8-d17423589f48@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: b6d9b419-f102-4eca-8084-08df123bd22e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|23010399003|1800799024|366016|10067099003|22082099003|18002099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: Zl7X53MDCC4NUjSZKnqzAmtrwvRxMyJJ/1kY9s5twITr7D5nc+XeAfbzFkaAe9Tcr/sR9VlV0kNLrhAlTbP3sYpr8vpmdlJ6U8YKUWFr5lARqovK2vuGSDwXsMW8yHjtGA09fJC178tqu7ZPQjIxtRhBpB/oL8GIYw1es5slSQSdwgShlzae6xj0/NzOvVBEed6QFIeaR4/Gyinq3VS3u3gozfiWKfJiE7eti8aU0EclRjXAGg6wQs4J536lOi7+EsFd9VYmR5n3CdveZ0VKLl3jrdNPnk0XWJIzP2N3Yg23lMa3ylw8yEtTLNsbbQHnQRI9BMOdqcv1PcsF5DoOPPiSzpBlRApoDDQIBnsyMrIQx3dRg858xRqYk5yoBG1unPMCcAX/WiL+5W5l63FupG9Q5Hfz4/VzsMJiP3crAFd+p+PcGbnaPy8u+6R7as9Y2lKk/XzyO2nE95RURB5fTllDXidB1R/xxKmBj17TkC+mEnCvyCaeI+rvWQfxHfqxC/CbO6T8CYLIcMRZWIAh6lbsY1UeD1qs7ve7AMxfEBs1z2RaLAFzgdFK1KPH4s6KaPp8+XHZGszDcqKweApaGxq7q72fvqISMBTf7jImVIbTgJNMV8EqYWN5CoerghQdU11qfY9UliouG93E4rjaRWQ7YgntJuhiL9sCGq0O9tNIYfYgDCoP339GMDPVzfBYo1AMI4O3ITBoTGTemX7ulkGtbLvU8JeCnhKhtAmXxTQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(1800799024)(366016)(10067099003)(22082099003)(18002099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmswU2IxYnd4c1VxSkJPbnZaZ24wc0RvVHRvY0t3dmZRdXVWeDF5M0dKM0lL?=
 =?utf-8?B?WWp3dEdEbldZNHBiK09lOTJHT2U0Y0lRTExzV0JSaHdYRExOZ1hhL3RRTGs5?=
 =?utf-8?B?SkIrTXJ6WDc5RWFYYm11MzlCTURMaVdBNnFsTEZXN05scXIzNVVrOW5RZDRB?=
 =?utf-8?B?N24xbG9wb0YwOUVtSFdaRllrME1MalRwd0FoSmdzUU4rMGVpb25OdkVVNEs4?=
 =?utf-8?B?NEp1bkN2VjdpTVVydDFaNUlDaVMzVTZnY0Y3c2psUnZ6NUM4UjRSMWFnYlI1?=
 =?utf-8?B?a1Z2T2N0RE81RHRTbklBK3BCRk1KdlhudzRBQlZJS01NYmF6L0VZalR1clVj?=
 =?utf-8?B?M24rMmliSDZ2cmR1MXJ3UWNzTFozZGp0QW5hanp2Y2VEdVJ3c3EwU0JMVDI1?=
 =?utf-8?B?MXdRR2lXM1VyTjlpVVZjakhhakZQb0FUaFJNQWNZN3VXOVRGTE0rblpVdUc1?=
 =?utf-8?B?Ui82K0tCUmxVRTJWTmovb0tDYzQ2V3VDb1ZvaTRJWFpCYmt6OHVjb3RYSmtr?=
 =?utf-8?B?WUVPbzRaU2NWS2dJU2djU2FFSVNjREp2cGxWbGlSUmJXTWY3MWFFeVdJWjdq?=
 =?utf-8?B?OCtpUWsrQ3NpRW12THllRUVGdVJLekdMWDlEQjZ3K0k2QzVIRzhUcmZVcFY0?=
 =?utf-8?B?SnBUT05RQW5pbE1WcmFpOTRqUE01SEJ4aFFYdEZ1N2pZMU45dG0yZUhOMHY3?=
 =?utf-8?B?REwyR3NmVGhLazgxUkROM05WbVc5aGVwRHEzM3FWL3lUdmQ5dzFaeU1nWHNl?=
 =?utf-8?B?aEMyRHNocE4xbHlSKzU1MVhNUmNBZHU3aHVaNGdhYlZUVXNENXpkOG9ib1dY?=
 =?utf-8?B?NHJLci90ZGY1Zng4L2VoSWpQSjVuMmZ0NlR5cXNQUm5IUlFSK29Helc5Vis5?=
 =?utf-8?B?cC90VXdtK2kyZTFzWFUwUnY3dUJtSUZUZG5KRk9XZ3dHVGVkOXNhUm9MZTVP?=
 =?utf-8?B?V1ZPaEtGRytlc2haTzNmQ2FmWXdPNVVVWldGWmpuSlcyUjVoMC9NanBJOHVy?=
 =?utf-8?B?N2dINUZhem1NMjFwclYwUnJ0Tk0ySDlRVWNvSHhvaFBvdlV1UVVhY0FPb0hI?=
 =?utf-8?B?eTVOaTg5VXdLNnZ2UHYvbnJMMWF2TjFheGpVRVl0NCtKeTNVQ2EwMW5JakV1?=
 =?utf-8?B?MjBGL0hJUFhCb3UyVTd0TFpkTHJQWGEzLytjckhkUzVLb2J5WUxBQWt2YUwv?=
 =?utf-8?B?WktaTzRTbU9SQ3EyOTlOb3hLQ1ljanBjMDFteXF1ZHlHY1g2cTlSM0ZVRmJs?=
 =?utf-8?B?bFk4c3dnTmU5aEVUTm1KZE5aMW05UzJsMFZxODd2T2N5TE1NS1Y5RFpjSmo3?=
 =?utf-8?B?WTBOZldZaG5DMUpESWtETHZQY2NIUVllY0VVZThLRHlBVndSYkJmY3JzNXFo?=
 =?utf-8?B?R2pjaThyZU5mS3hST0paMWtSbDllTzRvSDZ1dWFPVkpTYWhsYTFZSjU1a00x?=
 =?utf-8?B?eGM4bGVnR1lmSWlCUmFYaWsxcUtON1NGY2p0VHZvUjQzNVVkMkVyTFlWeFhx?=
 =?utf-8?B?dmJ0RlVNUHpjT0lGYjNvZklLUk9ZM3BQc0Z5aVpLREVOdW42ZFV2T3doUHdZ?=
 =?utf-8?B?MjdDcFNySTBjN3pscU5BVGZTS0k2QXNzNnpSeDdMaUpYU1dLTmNVSmF2SjJQ?=
 =?utf-8?B?MmM5NlVKelJ6Y1lGcjVwMzh4QndVQ3RHUnY4M0RvSjZtb3dKWGR1dFlrYUEz?=
 =?utf-8?B?T2ZnYUtWZnJoNHRvSFhjUlptWWwySmt1djhNNmJuT2tqU0cwYnhWVFNLUkdh?=
 =?utf-8?B?RUw2NXY0T3c2RFh0U1FqOUpqZnA2a1BEMWprTmllV1dqZVVFVjRpdmtkZ0dL?=
 =?utf-8?B?NmRUUFJtRGo1OG1YZDRLMHdlNGljYXRMUVlsQ2dMNC9pK2p5VjFNYUZLWTdZ?=
 =?utf-8?B?UURGdThPMVBYZ1JCMGw4UXVHclJsOWdrejI1c2FLZ2k0WG5TNG5xYkRTUjFM?=
 =?utf-8?B?WlVjZ01XditTOEkwYVlZYTR2KzRjR3h2ZkNTRzA3SnZkMVNwN0s5T0xXRStn?=
 =?utf-8?B?WkZSVURiT1NZQzdGZ0crbVd5UGdPMFVxRlZFT0Fyak5QeGFldU5pUWJiNXdi?=
 =?utf-8?B?bWpGbXNXRWtFSVRzdmxJVXRVeHROV0MrNFYxcjBnNGNXaUtpSFZ4RFJjeXpP?=
 =?utf-8?B?KzZHNFl0ZUR0OUkyRnQ0c0lkNVJaK1VNQUN1YlFaRjRWQm9LcDJIazI1WmEy?=
 =?utf-8?B?SzRDb0Z3bDdCcEZ1TkNvcWVtNkNoLzVDOVdzV2hWOCtMM3FkdVZEY28zMDBp?=
 =?utf-8?B?Qmw0WTZIMzRBTU5oMWo4NFRSMXBZQ3dXWTdDYkthanA0Uk5TVlErb2Z6ZnhL?=
 =?utf-8?B?RnV0bm00aXlNQUVSbTEyNzZXM3YybndoSExzVG5CZ1hCa0hXcENOaVlPRGtO?=
 =?utf-8?Q?glhyV0tbAyaDqcnc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d9b419-f102-4eca-8084-08df123bd22e
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 08:40:24.9897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQDWfSYAneOfZGU4jj+9uW+dffs2/6kXrJcl0TOvpsRpFnncEatbOU3vPDH7BzQdBWNgt+UPOpXACFM3CRQgaVNJ7IATBZ4RtwnBt4hZJ2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10916
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

In vhost_vsock_device_realize(), after unsuccessful call to
qemu_set_blocking(vhostfd, false), vhostfd gets leaked.  Let's close it
explicitly in this case.  CPR-saved FDs don't get automatically closed,
thus it is safe both for vhostfd obtained from cpr_find_fd() and from
open(/dev/vhost-vsock).

Fixes: 384c2561bddf ("vhost-vsock: set vhostfd to non-blocking mode")
Fixes: 701544cfaf46 ("hw: replace qemu_set_nonblock()")
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index c582ac9fcc8..3ec20d87606 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -176,20 +176,17 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
             goto err_blocker;
         }
-
-        if (!qemu_set_blocking(vhostfd, false, errp)) {
-            goto err_blocker;
-        }
     } else {
         vhostfd = open("/dev/vhost-vsock", O_RDWR);
         if (vhostfd < 0) {
             error_setg_file_open(errp, errno, "/dev/vhost-vsock");
             goto err_blocker;
         }
+    }
 
-        if (!qemu_set_blocking(vhostfd, false, errp)) {
-            goto err_blocker;
-        }
+    if (!qemu_set_blocking(vhostfd, false, errp)) {
+        close(vhostfd);
+        goto err_blocker;
     }
 
     vhost_vsock_common_realize(vdev);

-- 
2.47.1


