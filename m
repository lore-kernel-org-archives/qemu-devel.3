Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B20CA6007
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 10:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xElJy-0003FX-I7; Thu, 08 Oct 2026 06:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElJt-0003F1-Lm
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:25:49 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElJs-0000xp-7M
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:25:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CjC8kacKjmBUr9qDtf2tHd8xvoV7kYLqO6sNQ3hKUNbFpTEkSx9hYUes3a9y14lQIps5hdcR9b6P13IItDG2d0rrdj8t4mJoqRTq6amhZVC1JVi1ibWoc1Or/vBldxFGFdNtGrXTk/iVnAi1ZQtBhC6+eeNX0qjT6/+VHUZl1ON/Y9pp02uRk/O5uHsD3U/3Btat3JckgMJ/WVpCmv59xj5jWFaMzzNuE9NNj24brv1GNs3jfQ5ZS13SCLywtrLvTB/HcSZJcU2pjK4jhscPFArFuC3IWpEQkiCufUZ2CoSLqXyvpoRfn1JxrJwmQ2iw8iKtcuSHVav3gYjiaS4lkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pI2kEvdyqWo2h3cBz00/awDb1Cv0bW/IrdoDs7geeFM=;
 b=lvxFHxskmo1C+R3hKvZXF/T+Nf/Ejl15FQHklGEVjc9HMKdQdOvGlC+rH0HVG/oq1e8cI+qpIwGVgRvnFQb+TTPI7ir4DWzw9CuUaalLv9SyjNv2I5WS63+Z9v41hdDtBvMU3+pEuVhsSkORU7P9LIc7m5XepTMG8eBmsHETHS22+9DJCHRy2TdZp9FkT3pyjt/CdjV8kg3Exy3WIhcJTcnhxTiIRbmU/F5AlvyxG1zG9dw+RAKbScdiCnl/PQPnk/JrP3UoTk5XV2lvDLQPjgRAE1BgFOgFRaP9SlovyG/ttVOWtKryZhtuphL1joj+3Iqviwx64iPbwG7FdmfwVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pI2kEvdyqWo2h3cBz00/awDb1Cv0bW/IrdoDs7geeFM=;
 b=ZJGaHo2f1TEpAeFftSFlMwGWTGnTHO4ygy5QdyqRpYcPMdU2tB4kCCn1n0NZ5sQfay+kGkZF/+/2Pp+b5dmxGIxBfmdPawHAoBSEeVfPZlMGvIikmTzSH7bSJ992vkJk8zGOVRCaAq2lis+ZuKxFOucUwqtFcoMo9UwAbePUcZnp/0Dv5irZJ/Q3WiapjRi3SI8EESl10Za6AIJ1M5kkivfmSKi6S2ynAD3BXoFaavowVswfjHWOa9Wm8vj89B+G9HX45H/Q1rLRBFsOcj518Q+2LDHj0VL3bldc5q5S5c5pgNKXHmdhL3ANdDtnEMSXNYKOeq1xhrMQEGheTJiM/g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PA6PR08MB10593.eurprd08.prod.outlook.com
 (2603:10a6:102:3c8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 10:25:39 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 10:25:39 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Thu, 08 Oct 2026 13:25:31 +0300
Subject: [PATCH v15 07/22] vhost: add vhost_reset_owner op
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-up-vsock-vhost-v5-v15-7-301b73b3f843@virtuozzo.com>
References: <20261008-up-vsock-vhost-v5-v15-0-301b73b3f843@virtuozzo.com>
In-Reply-To: <20261008-up-vsock-vhost-v5-v15-0-301b73b3f843@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: andrey.drobyshev@virtuozzo.com, sgarzare@redhat.com, bchaney@akamai.com, 
 den@openvz.org, farosas@suse.de, mark.kanda@oracle.com, 
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, dwmw2@infradead.org, 
 peterx@redhat.com, philmd@oss.qualcomm.com, vsementsov@yandex-team.ru, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, clg@redhat.com, mst@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR10CA0117.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::46) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PA6PR08MB10593:EE_
X-MS-Office365-Filtering-Correlation-Id: 92aa0e23-8797-4dc5-76e3-08df25267e7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|23010399003|1800799024|10067099003|56012099006|38350700014|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /Chlr2QXREFpTyPrVwdRfGJq/2dLI2f3DKdmversBVVkoig7K6dz0dSRcZ3XfGPc7Bglduoz/qchLIbNuap2d5S6B1fWfdtRNLEcft/2AsyyybbNqmTtOP/ot8PWht1xxtJ3JDmVry5xOetDvS1b4i7aDAT4TwQGCjQoXVRwRpcmL/fzIDdRwTCgnDdCMw/S9TI+I9IEkBh+8Am7Mk22GiX7ipWcfnc5twYeL1WJasRSjWajfPuociLtv52BayRMajWLDEKzAaMOui6KbbilmpKHIe24tHZE+VOSH62R2ZWl97DWF/yoT0aL0E0pWs9L4p/x5gk77pmXr0ljrL0i4dHLsrABUDKUyuQq9H58LGtLWbKiUya16/PzifWCgkIlKqvdStXww6RWoylVOpaJ/3yPQG7N0Al1Bw8jHLvriklrTLLLezcq1hvPLRt4dyqPwbPCjXdr6k6S8BXTNy+SFndagE5WX+T6DiaTCnuFxNOwfI0LzGY7zArHEPJmxxacUeThNJjXZUJKIF5zF1O/q7LstO79NQMSxAVNOjooUR8d5T75EeFWUDcFRolAihAkqMMCZMppOvmcgHS4CuD93W5txf+wgTNHj4rl7l6GLwy7C2zp8x+i6pNDOolTkoqZlQEZCYyQfE+2nZO0NA+Cw3uqZ9WFe0BGDeiqMlSFY75Lm6XhdauiJK4cby/+6P1S877LNJ3be/rOW6mpKUCzuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(23010399003)(1800799024)(10067099003)(56012099006)(38350700014)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWhUKzZjRUhDbkxQM2dkSnN4K2svZlovZWEzZ1piTTZzQTlBMWxmK29QT1Q2?=
 =?utf-8?B?bno1ZE1XcmwrU29TR214Y1VSWjVnU1NMYkJUZ0RLZW02ZlM4V3FHN25pYVZv?=
 =?utf-8?B?QWRhSG9UaU9YL0FISXQ1ZElvUkxYdXN3WFN2aEpzbHI5TVM3TjdLN3IvL1U4?=
 =?utf-8?B?QWpYanVqSHFjMW9kM2VnbEFGaUZQdHlnKzdNZlo1di9EUzZlZU1LN2ZabGdo?=
 =?utf-8?B?NGNuYzhtTmpzNnpHMmpvRzJRTXAwQ3Z1cnJlVVVPbDRnSzlGQUxyVXlVN1BJ?=
 =?utf-8?B?QWc4aVY2dUdCVzQ1SkF3eUVubXZ6YmMvbVk5RlFWL0ZXem9qcnBmVkFSMDJs?=
 =?utf-8?B?UDh4R1NESkdWbEZFWHRydnJteStzTVNkdG1URmdUcUhpMjFoTFRNZkpnYjF1?=
 =?utf-8?B?NjFxN3huVUNlY3VucHh4bndUazlIRDFCYWozaDNzOG1lZkFEM2tnckZqWFV6?=
 =?utf-8?B?UXV1V1I4QW1jdXRNYnBxcktpQlJodG1DeTEvWm8wOTdHVkZEYU5rWjMrTy85?=
 =?utf-8?B?V2xKditvaUZZMlZZcythOXk1RFgvM2JXWWd5emtOdnE5T08xZG9CbjJoakM2?=
 =?utf-8?B?NTJHTzhGQUpXamdETFJ1eUZjM1Z4V3VmRktqMjZPMHpock90KzRleDFMcytm?=
 =?utf-8?B?cXlGNkJWWWhkOG5TRTVDY0pKZjEzellJb0k4VmtkeUw2WURwMk9YbzAxRTA2?=
 =?utf-8?B?ekxuUTBwQy9OZjUwdm5vVXUwSjZYZ0Q1R1ptRy9KWU1GSmxIUTF0aytwZ0JF?=
 =?utf-8?B?U0lBRStGRkZKM1FCOStTSjFTL01NVmFobFVTOXB4cFRBTERXemNxUXl3VW1k?=
 =?utf-8?B?d0NjUmczd0xIS1pyUHZML1BxaUZiei9mV0llTXl3bmZ0ZE11WlZXeEUwbm9C?=
 =?utf-8?B?SUVBK0ZDMmlPMU9JSkd2cGxYZ05jeUVFbjJYQ1Q1UGdZcjY2c1VEZSsrdnZ1?=
 =?utf-8?B?cE1wbEtlS1lJczQwNmR0WXZ6Mys0QnpPTWFSclYyOVdjcWhQTW1jMWhTbFhK?=
 =?utf-8?B?T0lQUjZ6SFY0aEhlSElEYXVLMzlkS2NROU9QbmNuSFFnWXJFVlZJN3VHaVdB?=
 =?utf-8?B?LzkvNUtSdERnSTZSUWl0ZW9YZDYrclVsWDMrZHlwNlgvUE9qYXpOSTQyR3Za?=
 =?utf-8?B?QWdWUUhEZDQvOTB3ZzBYOVlkSmZPR1NSaldUOTZEbjZZWHlGVXZRUzJsVVRk?=
 =?utf-8?B?eDZsMGR0eHd5WFRVY1VNV1dES1dTclpPeFBIdUdvZ29IdVI5UmZpT0dEdmhI?=
 =?utf-8?B?RFRzRFJuMmtwREJTYWUvdFpvZFB1R2FVWTdKTXVHTG1hakN1eXp1bjZXeGtS?=
 =?utf-8?B?ZEtSdmpDVWhXV2JYN09COWhDcnAxUS9nN2M4SG1aVWgzWDIrd0M0N29CWm1u?=
 =?utf-8?B?Um8wTGRod21tcmc0YTkxV0dCdFVYZStWUkhSTjk5RGdNaHAvandzRGE3R2lS?=
 =?utf-8?B?Uk5lRVU4djgzK2RqdEpERkFFc3hITEUxQTV6ZG9Yd3RTMDh5S3BNenZHR1Bu?=
 =?utf-8?B?ZVpYVGxnS092KzZaNWNYc2xRSFdWa2c2SFlnVUNMSkg5ZUdlV081NGlkQW5V?=
 =?utf-8?B?cFhWbmtubVR3TEgxQkNnQ1YxaUR1ZUdhYnFCN2NYdUZiU0NxNFV6akswMU5l?=
 =?utf-8?B?WnpMR0x0NGQ4bDZyZHg1cGQ2anVuTyt0RGU4V01Qay94b2dmbVZoL2pMWWdP?=
 =?utf-8?B?WXZwUE0yV1IyUlpQMDhVMGlCZXhyMFQ3aCtZQUMvQStrUGttVjBVckg1SHhD?=
 =?utf-8?B?OEE2ZHBUUE12dC9IRlMyWFJPRnUvQjhwdDlvODViSm05TncxMytCancvSEE2?=
 =?utf-8?B?ZW9nNVczaVliOUl6NFFxWnFtMFEvMGRLSW45S08xZmRrS0xlU3VXOXlEZDZR?=
 =?utf-8?B?ZEY5UFhiNUVlNUZHVldKZWkxSUlxd2FRZ0dQR2pUTG5MdE9remV3V3BzemY1?=
 =?utf-8?B?em0vVnJmeUhPSldCWEFMU1pxdWNFRnV3elZRRUtOUllsWGdHa0FFWHZRL2ls?=
 =?utf-8?B?czdwdmFkRHRLQmpaSithcVdYd1NwQUpFVHBpWEpVUDU4VEpEd09LOTlDQk1I?=
 =?utf-8?B?YmljNEI2czhyQWJVTHZWbjYrVkNlVjFEVjUrbS9XYVF2WER6Ylp5UXA2T2xZ?=
 =?utf-8?B?VXFIZXViNEJ3bkxucmhGVEdzWUsvbGRrcytOeDNjc2c1aU8yQU9aUW1rYitw?=
 =?utf-8?B?WDNBNDQ4NUJyaTdodmNYK09DOTNkcFNVbEg0V2VqaC9URjY2M0N2N3B0TmZr?=
 =?utf-8?B?Q1c1cW44OHRmVW5UbVVYMnNPR0krU3E0SmhBRysyM0t4Q0ZkRjBUbjIxdndp?=
 =?utf-8?B?RmdZYVd6OVVNSythNmw5TFhNTDZkWU5razdvTFAxdjVabEZDd09CY3FOeEsw?=
 =?utf-8?Q?gTvIVLk5HHVeo/CM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92aa0e23-8797-4dc5-76e3-08df25267e7c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 10:25:37.2988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ozfwhIEAl5iTQhozQ8p/r5bBiQ3mX1R5/Gnjo+fYPCDXf0BlEO3iGAVnxGyqeOrUjcPfvClygx6jkGo8UsSy3vorxAPpn3fENxTXYSF9ThI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10593
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
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


