Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3540FCA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 13:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCcuj-00011p-Nt; Fri, 02 Oct 2026 09:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCcuM-0000q2-HB
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:02:40 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCcuJ-0007RG-P3
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:02:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IxcVOKh0G+JmH2u8qhA2I7jL8nkXsg3+73duPdf1SgvvBkLrDaMQT37kmXmBGXCUyUHAxtGnsvSABpG9/CCn1hP9zcwoeG9wcSxKRA2x7Y1zwHb04vV+SrzN0Fb+jB4a+G4LLI2bFIS9C2/7b6Ut5xncBaV/+cP4gOzP27HTgt9WIWhaO2SMg7EB3ibn0m5vy1OLOGFUgMfb4iVXV/m//+GV/bznlmbPXXSoQq1nwtDb4+n+hqrqO6CY9InJkfCUlQp6k1W8waVvdpwvUFB6wbSIshdPnK0nsuQlTUT0DX0USt25aCS2vnJBDNPKSSuz8I6D0LQuSQAcgoREF+dJjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pI2kEvdyqWo2h3cBz00/awDb1Cv0bW/IrdoDs7geeFM=;
 b=kMYTGBcpmrk6HC1gATKc4cWylyLT4Xh0VjjHsfHBLQmGLGSQ/VJtQaFw9Dy5GkpL2UoBMW+L7xnmFW1spJ0ozLbxrrObQBuPoF/g6vdUpHxTAAn17GVPmQkkjAQvndxYWHt2rt6+w3lPI433AN6Cholvpa4bdKkv7MgwIvNmDMEVExYEuTxnmoQvjtCGjgi9wf7kFgjop5MdPMqvpRVT+YrEFCmQsQbHjheWU7SCe/iOHlysO76nmz5bkE0Utjxwg3rSY96RJvMtbznX2dBzmtpEcGm21FaTGLNo0dl8tJIcKQhd/ih8/jaE4ozAy9entyQOWGKxpSkydZt4YuGUQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pI2kEvdyqWo2h3cBz00/awDb1Cv0bW/IrdoDs7geeFM=;
 b=yrCn2fRMxtpHl9D8vmIHZ8r5RuOGAUnsYFNaBlWJtXYkdf4LTr8QuU1vVmZQtWmt8MKPac17ArWHT6NJoDhiUKxcWgkWCDvy9Uc2mjUoMp6TgGN9fu2AeDdmBntXg9Ap1RgKpLvY+9WBVZVCdSb/bcucAeVK+rPg79bug8KQHUZqxVqbPn3YVWnBRDNzBuyVYm7f0e77NvYez+Kcw3hlSHN6LOMnU7Rx5DwYuLe5Tj3KRCeZDGGFhxF1LALOF+T/4cQQH8q9/VnRkElx0mdOzRvO5Xvsmg3qXrkVS3ONaNFN0Je81sDNvco8P8tot8O8rSRKlo/Oh0Xui9EvUPZ/xw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MIWPR08MB013052.eurprd08.prod.outlook.com
 (2603:10a6:290:e8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 13:02:25 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Fri, 2 Oct 2026
 13:02:25 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Fri, 02 Oct 2026 16:02:16 +0300
Subject: [PATCH v11 07/19] vhost: add vhost_reset_owner op
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-up-vsock-vhost-v5-v11-7-18fa09d8273d@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9dbf1c05-411c-424f-74a8-08df20856788
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|52116014|23010399003|366016|38350700014|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: mVDZLgGOVUtgbbfvtNiBDP991av4qsopEgsf6+DqXjUSe3spAMbqtx4uQyjFcK3Qj8Zqu6XIieDAXHBoDRhLkXbc+vTgpMfkza6dic6a/6R3g6nheMV6np3PjYGkkfhSvBgrqdAKGS1Hc4Ofg7LuIF8ZHTt9k3q+W3bBOf4yHfschLKCDJcspWfy4kam00wyMdj7VLNOQpj0VOdcXvZUH29Z5AVCbLZ4QDHG4Sd/axo1oDSvM0Q2gRFFq++dMrU6u8Q4JT3fB482Ir7rMQie5uLWqamr/a9mfvuvsdbkxAlnMpKO/WMNOsxHhg106Hb5jQ9rOicgt2YjCKPrwXpL/yBR7iF4XrwORKFd8TeVqm3hhhGXw3YiyUquQ/saOMZgQqWlJZIxKRFgehdQlOHNLyBkd7TZVuEInLdBMHMLAhv7ldgm7awWr6ZJNFrJtmH77RneaJYv0aLsRBttZaLFFibJ+naMVoNspRKrOFAua8g3A7cxb7kXMNFp26ZkkVDBfkUrztWjvJhjDASlUXBbB3H9deUbWOJgi17azIN5WC2fTSBF10hobBBb6rLC7VB6BvnrlPMaZYxC+tEmtWVuH1y5T1wCo4Mz2zjf+b3eupdoKFWU+XPz8ey/L0jzt2MErCsrTRZHY2LdBPJTcv3k34K7lpbRzaoqs3z8f7SL2Ob24UtgPSQvE5Jv9EjthybeCqlBSoMdE2dbP6PGj1yLtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(23010399003)(366016)(38350700014)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnN5STZoNHkvMVVsd1JPK2FyNXhoUU9EbEFOOU5TM0VaVHcwYU03K1dDZmNT?=
 =?utf-8?B?S0dpTDMzcGF4ZmZqUGtOeEJOcVlPeVE5UE1DREtGRTB2cVRmRk03MDN5eHNn?=
 =?utf-8?B?aExnNS9tK245bGVGRWxlODlBcndsc1FaMmo5TEI3bmxFdzJuSUdEM0s4VFF3?=
 =?utf-8?B?cktOcjZJUlVtWVBFc2Z1d3pwcC9zRjU2N3F3NlpXVUlFNU9KWXpEU3MxYUQy?=
 =?utf-8?B?VnhqQkErTE9kM3lqSE9BZCtvSW1PeEM4ZzQ5eG1uOVk1TkVwVkdTOFZDZ1pN?=
 =?utf-8?B?VUsySG4ySFNDOWw2UnFSWkpobm80VnFaUXg3M29CcTR5czFSbjdYaWFIL081?=
 =?utf-8?B?RG9Xc2ZVMlFocENVaHpMSnVpVEl5MnBFaExBWGs3MUNBaUNJWGtYMjlPS21j?=
 =?utf-8?B?NEcwUGUyVDY5WVRnOU9TOVQvWkFPNG5OUk5wajhJdXIzcEplK2p5bHY0RHQy?=
 =?utf-8?B?NUpoQ1RlOGJkRTlmUThwYmkrekFMc0JjeXQ1Rlo3VEh1TVkvNnlWcUZpS00v?=
 =?utf-8?B?SyttQmJtL2xKNWJuVUowYzlOVVEzcEhuVEJuTVpHckZwdkhYRkQyanREY013?=
 =?utf-8?B?Z0wveWF0MDFNb2R3L2RLV3dyU1pDKzdlZ1hpQ1J1a3I5WlMrV01vVlZLK0U3?=
 =?utf-8?B?VEtxaU1paUtadG11Sy9URHpZZEtZVDhzeGZraUlBNzltak5xUXBEc0UxNCtq?=
 =?utf-8?B?NkZsdVVnMU9aUDY3VkMzbzlqWmJHMEJtejhmWnR4VklMR21EdVVhVFVkOW9L?=
 =?utf-8?B?bkxiOER0M3JvYTRNK1h3Yy9FdDNsOFRUMGNBS1A1M1Y4OUFJeURxZUt0MlNP?=
 =?utf-8?B?cWpsQWx6WHBhSm5Md2h4VWF0SXFLQ2dtUi9TZk9vTU1VcDlFZjhMSlN0MXhK?=
 =?utf-8?B?THpSN0lBYVdHbUFPTHo4VkVmeDdlN1YvbkUxdnFuMzhwYXpjZEgzQU41UVMv?=
 =?utf-8?B?T2FRc0tWSUt0T0x2QWtJMmZFZUkzUTVWN2VENDFDNjZJNkxud1lKekNjRUhP?=
 =?utf-8?B?MUV6czJKYnlWUHhVd21XaXMvZ2o5Z0RlblpiSmlORGErRXB3djlHbEc5Smxj?=
 =?utf-8?B?YXJIWlRFQk5heko5NkFKU3F3Zy9YVkR6TC9XTG9FYS9Ha1ljYU9hdGtxS0x1?=
 =?utf-8?B?QWRhRGVDZzhLSEoyRWt1Vzl4YS9pU1o5d3dqY1dZOGNJZUxHeWczNDdVVWtk?=
 =?utf-8?B?YnNvbi9xWkFDcWl1QzJRSEtRaEZCUzlrVmFXOG9qNmY2cldqZURzSDlhMmdV?=
 =?utf-8?B?MmpvY0M2aW43S1dhdlV0WWJmWUpkcFJpTVpNTlg4Z0hkS2hwRVE5ZTdhUzVP?=
 =?utf-8?B?Q1JKbEV6QVRvRkUzdzBVc2U4ZytDbUZXZDRTNWs2bnVHSU9abDNZZWVlaTJl?=
 =?utf-8?B?NEVaUFZuWit3VElpa043U3o1UU9LTzdtaVNPb3VTUjEwWXIycTNCNmVwMVUv?=
 =?utf-8?B?ZGxXRzUzYnB1dXlqRjhGdUoxb1d1c3pwOGRSV0p1NnJOMFMyOC9PNTl0N05l?=
 =?utf-8?B?Skp1N0pwNHkxd0xqWEhDMFl4dFo2TGJDUjY1K3NqektuVys5U3NJa08yeFd0?=
 =?utf-8?B?bEVhNE1SNFNXUlZxamU1WW9XK01EYU1HdUEzNnZjMmpnUWVNc2FjaEJtN0ta?=
 =?utf-8?B?NHhta2NLU1IyZHZnVXJlMWdzMkpPeFVYQ3l2dHY3bWJOcEFXam9rNFExRzRW?=
 =?utf-8?B?ZDB2Q05HSlBXK2tTRlpxYXJIT094VE9wN01keGdqSnZ5dVpNOGMyV2UrcHhT?=
 =?utf-8?B?VzNFWnhrbG1rVWFUeWkvbHJlVkJkNTgvREZZald6ajJsSGtLbGFtV3pyckFm?=
 =?utf-8?B?YTNZeDFQL21RVnRGaGlNaVEzYWVaeCtKSEJ3UnNFcVpDQWdZV1dnZzlvVzY3?=
 =?utf-8?B?cTFiYmdZU0FzZnQzT1psY1RnZVMrZTllL3c5VS9xUFZiV1FKMkZBTVVqcmV4?=
 =?utf-8?B?WjVuNDZRcWpOcnFKbXlMZ2ZpUmRsNENVKzQwbEp6eXpQbHFXRHBYQUE5MTlh?=
 =?utf-8?B?d3R2dlVwZmw0RGhqd3ZLcndadGR2NUMxdmV0bFYyZ2ZvWFh2SmJBYjBpakUx?=
 =?utf-8?B?cFcrQjM3Y2c4eG9yVzFoZnVDZmh1VnpzRDlGUUZaUWdSNmxMd1dncTM4QWpF?=
 =?utf-8?B?K1UrUmx4SVZwcW5Fc1FjazZkUXhHMHAyOU9PYW15cTJGKzducW5SZEhhaUha?=
 =?utf-8?B?clEzMFMyeGRJdU9rL0N1Tmh5Z1EwVVdoanloclBOWC9OdHRkQkN1SVNabHND?=
 =?utf-8?B?VEg2ckVyZHdqOGtPRzhyWVZyM1lTMHpwVFplNDhENSthUUVrM1lJRm1NSDBu?=
 =?utf-8?B?MENqdmlTOU05Z0JGenZkamU3SVZaU2U1YkpvRW9ueWhRTmh4MnpVVU5LUWpn?=
 =?utf-8?Q?qWGsH5jWDzG6tfnM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dbf1c05-411c-424f-74a8-08df20856788
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 13:02:25.1029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YwJ43bogHBO/nfcTzdc0LHTZjX2RJX9k/dkH+EewyEvvUoJxjFq71ALV9Mv7RxWYTJz+B/gLOeZKhSU6P3LmLC5mHLC5wDvXDGIAxQH4QvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR08MB013052
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


