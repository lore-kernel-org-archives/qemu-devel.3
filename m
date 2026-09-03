Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605C1C624DA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 15:08:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x292q-0002bz-S1; Thu, 03 Sep 2026 11:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1x292p-0002bg-Qs
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 11:08:03 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1x292n-0005tm-WA
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 11:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1788448082; x=1819984082;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=RXcG0zuVb1VYLd1MqOZbtFQ58iE+a3KUCc4Qmz0adjw=;
 b=qpZe/+3+NxS6K4288HeuDaDLV5YhgsVnQ+jfDUkwSJ290bY1pptynTFW
 JVjQK87S3yah5SDbMJeG6B/Q/1FBpGL2OdZjSTA0YoJ+PkNfxX+1kS5WJ
 v0mPh3NMjufKL47kYFfrm4L4D1inN8yF4zqXCMrwJgJSo0SrhAOzUuW08
 zSE9am3mvT9Ff9C/ICQ/qizXOUGQsqVYGSdUpsq5yWGtxPVL6mSbr6bw7
 +0RiiO5GTsGjh9JgJ67U7IyjKHhhabHWnc6q3wFsKSRa5n5WG3KTXPwX9
 vH8jHzCy5G8ZSxAwIsFDqInuFdAY6QWDXHHzzhCEGBjZmu3VMxsEEiuWX w==;
X-CSE-ConnectionGUID: 1pdRYhnbQgWbyabSPu4FAg==
X-CSE-MsgGUID: WEH7kNDgRceDQH6MEt4lpg==
IronPort-SDR: 6a998d4a_nwBIMt5wuHahg3n5FGf9K3Bjpbf2awZx5tdzXBCJ2hYC8vw
 pLiGaMKsiSrulSyJYANgujCbSu2Zosk873AARTA==
X-IronPort-AV: E=Sophos;i="6.25,260,1779141600"; d="scan'208";a="48705326"
X-MGA-submission: =?us-ascii?q?MDF8rASZEf5NQnmteL/+HQL5698Iqr++RlphiM?=
 =?us-ascii?q?/OthjjFyyAn3wlQk3vlilyUQu+9Ri/qEKWaD/KRdIlsfC3Zrjz6+RIjv?=
 =?us-ascii?q?rYF1T9kIeWB1kT4zxegyqHZOHA41XRvRQuetzdnmSVaeS3LR9alojaJU?=
 =?us-ascii?q?5zf3byC1Dco5zZUSNf8kfeAg=3D=3D?=
Received: from mail-francesouthazon11011029.outbound.protection.outlook.com
 (HELO MRWPR03CU001.outbound.protection.outlook.com) ([40.107.130.29])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 03 Sep 2026 17:07:54 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t+yImj28fI+McPMerh2CN5VHRRC2eaD4a+ta7ilQlsRVyv40rEZA3W1JMBwsySrn25rpaKfgssvL5HUTnYYXq+5SPikLgaloboqSstUIIs9KiALTTJ6spSm+fwpuqhVpccBxmqjA8Y4c9q4uLxdBvamXigKN24Y4TnXlORCFT5OGZ42Y7QPEqvoaKau1FtTkxkRyMtqE2yVQdBG2qiUyEP4Pg03yFlFVIxbSuj6pjtozN1p4Vl/dIuuiKNF468G+PKEpN612RVVVGtYZbvMHG0X6Yj0R1BbtL/UgFFWRWYPaqRnB0x6YQBj5gz4+Sm/gwr7Rt1FGYDw/c/bLSFInxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvLg1nAtgLUy2+kCN/l36dnMiikLELPYIR3AnZsdlxc=;
 b=fUwD/lK5xifBNkR9Xl/nnPWgicg9hle/4xgeMMe3gz6/B5q4SBzyD8b53N3UMh9c9Csf3F+nILj4kXYeqDXdB4kNppN9Xl/GJxjEJ9jaS8B8kNJOGglggv7asu8Zzp7QOo6EfOZrQsaTzB0VIsbQBCZdHHW4gvggMhzbTEw9GR2OFpyb8uhlPPOJL3t9tuXLK86Vnz/vJEZbxF2/Kmdd3VacvumFJbHPkLVD6jWLLl7rxIPCnkeMTx3KQYY24kduUePPTVIURhkJpAFINo4Zb9uHJzai4V3xUdLseGd2PyleBcsMhI0pQfq3KdBmMce41qcd4uOQx1Ry9zRNlPrV8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR0701MB7038.eurprd07.prod.outlook.com (2603:10a6:800:19b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 15:07:51 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 15:07:50 +0000
From: =?iso-8859-1?Q?Cl=E9ment_MATHIEU--DRIF?= <clement.mathieu--drif@bull.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowangio@gmail.com" <jasowangio@gmail.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, =?iso-8859-1?Q?Cl=E9ment_MATHIEU--DRIF?=
 <clement.mathieu--drif@bull.com>
Subject: [PATCH RESEND 2/2] intel_iommu: Always write all the flags passed to
 vtd_set_flag_in_pte
Thread-Topic: [PATCH RESEND 2/2] intel_iommu: Always write all the flags
 passed to vtd_set_flag_in_pte
Thread-Index: AQHdO7X8BIz1nHrNf02/kmvoJPcS4A==
Date: Thu, 3 Sep 2026 15:07:50 +0000
Message-ID: <20260903150649.2281104-3-clement.mathieu--drif@bull.com>
References: <20260903150649.2281104-1-clement.mathieu--drif@bull.com>
In-Reply-To: <20260903150649.2281104-1-clement.mathieu--drif@bull.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR0701MB7038:EE_
x-ms-office365-filtering-correlation-id: 0b227972-8856-4aa2-762c-08df09cd1f13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|38070700021|10067099003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: jOr2CdUDrVI/HeaBArUDPR37hZ/+2/Oxggp50Z4ONw5Bn9/r+AuXrFS/VJncKgD+v/a/7aB5+H3aIaVPkvBCp5h7G9Yj8XbQGGqtvlrHtFiDodXtoy6LVAaQ05jjPz43tXs75lQWKg7XaKGZxkYd/BwXUj4MDKcOsL2H8lCetom3IuZF3sHb+V/SD5XL5LshU3Z2pKoS+2qs7GTC5SAg/E1ta1e/A68+COUsVxVi60kh17VAtEh5Pid0UAMXZKH+0eazp1OiPKwFuweH6n34CyJkFksA4bzA3yrsjPMjRMW2ExH+Kv084N+dzhTpicoRZGv2QSmy/7QW+8Nwza8fURLSY1aH6moS5LYVz9u8+iHd2wFRWbJaZ471D0XF2K63AjQcB9J/pneNnihE4UPd4RcamVdXNYY9Rmsq0qyQYDcA7bhFqrq4I8LzClWsXCD3jXLqq87ICs6MUmwn5plGB6xHkTWYANDyTxwOUN+6PKTznywuKxX+UxkXckbBWMXohGZqN5BEgaJnUmeoKi1lE/NOTgWkVV7C3QAx4rwr1JzOCAlHCIpOPlGvDQCEILcugJH7eil7PxHCsPp0ILmOeJ5PcwfKG7bX8UXT+7tswDRddfFYS6+0HXbr+VLOIUzTNfk1GUeH08l+m+gHK664PN8+p7ozlp8txJwLcjGHH8ThlFqblVsDb1kF4PiOooRJyYynFzR5Ia7jxE+IVgUZXgbUVJj0l+UdcQme0biY5dA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aUcQdkrqi+w2dXmiumi4I+Z5qkuShs0H2hpMVSRMEx6jl1zw82tGuGWoqa?=
 =?iso-8859-1?Q?YS7ku1Msnjf3XNtct3/0DAbbf8nfQMMt5V0S4GI88vBQjr0GUBkGqExB0n?=
 =?iso-8859-1?Q?iRiu8wxFVK/ZNYAlI0Bc5vUfgYZtj7BqrEe0PK/gW//CVIlEAHIbTeQ8L5?=
 =?iso-8859-1?Q?gWx1ZS8oA/qRtfVwiEofJI+dDCVHSeNUsNoSBJxyJTrvpDEZzdibxC0Zsj?=
 =?iso-8859-1?Q?EJGx+U4odHIXhMtmjSa51UmKXi6J8Kzvvkv9DDMU013gXLEFbzUkJPWsmk?=
 =?iso-8859-1?Q?sqhe66eScjgaIs7Ec40fupPS46U9ZfQyaydrhzuO+Ol3MbxIiwE+DSbBxH?=
 =?iso-8859-1?Q?CGF+XGNYSkGAnBM7klHjDkRpVYY/1mMXacpYsW3uyNzudeCgY+BAiUhIOd?=
 =?iso-8859-1?Q?FBNEi4yDQe69+6TFR2fdaoQ5PdRR+bLha24t1GIlXfHfGiHvHRDin8JPs8?=
 =?iso-8859-1?Q?j6n5+aAEdYHjkLbUL5CMkTZHuQAWblZocLaTlfhf02gNkZlyitSpDtg4zU?=
 =?iso-8859-1?Q?JYT15rnr58qYiNkcyYldkJz1FxP/y+4JREnYlDC30kSbxtSCFS0LjFBGYf?=
 =?iso-8859-1?Q?7mpUtxPyFXy0QA5lHPOamVi4gNj6PsqFkbuugfo1owEm2PrOLjOrQum6ro?=
 =?iso-8859-1?Q?LXVMsjnuK1mXVRkYPneZYWqkWfp/GWKspNdcHJ3DMs/bFow+KdwE+8lJEJ?=
 =?iso-8859-1?Q?PO5ME/s5Nvlkq05ZH3qxun8SuDvdawrbj7t3y3vjUULCZJIA3SSBXvFpzr?=
 =?iso-8859-1?Q?DYvezbrmdA0RE5r5it60r9VBhXmNi4EJTVVIaDKT8+JOgGU3NuVpJZc0u1?=
 =?iso-8859-1?Q?2Xo5b/Wjb9TOWuXbKrtEX42sYfNiXPZItK0vcqS78wb7HNrPVLsT4xaZk5?=
 =?iso-8859-1?Q?B6sCH14OTw4eoute+Lh2RGUYa6KT9UVc+kVNZQfjX4TQvnPEAPBhdo2pI9?=
 =?iso-8859-1?Q?epbrf+L+VbT6thg+BAUXP2VqwJJID0aIrcEvdxuVHIEGqkA8C0RSb0wsBN?=
 =?iso-8859-1?Q?rcYbjjoIlqtizuCKB4GOnrJcqvWuhtLnNmMos2COmsinTSbYWl1w4FTFoo?=
 =?iso-8859-1?Q?YLUGaFPlfW5SuzKRBZzy54bp8JmT/BLgg3QhpT2utoH6/xd3GKVcUhwuba?=
 =?iso-8859-1?Q?my+PC/dRn9hlgGwRGqTT6cs2DhRx0hitqsRQ4Qr3iaA7V3rI9wSyaNgu/A?=
 =?iso-8859-1?Q?TMuhhSd3iKRWqn6S+x/GliYIPBYHByuv5awcD8GkWIEy9cE+Vdke5jUYh6?=
 =?iso-8859-1?Q?mwjONeeBbAAA7lVq4ejstgr/E9p6jhgp/xF37jFVHpMEJq6CTaGHqkM2xV?=
 =?iso-8859-1?Q?fTBRmlts1yXac0EfNyPO40Pcj6nD0lJIRqTqt/cYJtMFvBcrDtiPQMU67r?=
 =?iso-8859-1?Q?kL+J/vUYgsHlul2hYHHX3FUYYij1Bfwx8mwpfUUo1EXQsiDLHHxqS0eJ5K?=
 =?iso-8859-1?Q?hDlGeq348CxcCxwP89rLKt/CkSDEgEUGDJKgc7JeutGumikxkMkT3iH2hE?=
 =?iso-8859-1?Q?VqEcmcrJJjrlVjF9aF+mJYtnBhWeo2seh8VSAe5qa4WlEgDyhRtQx0u62r?=
 =?iso-8859-1?Q?erMSE0/YJVnszS7WCv8V/0W2mnzbPACfebYIncGns5LKYRlYMz7uM35BRZ?=
 =?iso-8859-1?Q?JqAvdn0W3xpFG2705+Ef/CGCeFyUpMLbjrMULpsBU9dj5/V8YrfikhzVe/?=
 =?iso-8859-1?Q?pS1u53qPGyDxtU3NID8N9pAVOuoLuLio3WNDSRSFN4i120QQQqVZUXkQjX?=
 =?iso-8859-1?Q?Q+T/V/cwXjuMaduFFwcumbwWS1oyyj7xpFioPKVqXWB7QiIq4gJmqgERpY?=
 =?iso-8859-1?Q?15pwJOjDq4+EFe0rfV8ar29skWoT7vjf4654W9oBubPal/ZQIuxZ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tvE8HE8NWP3zTbXthEhe9iyUscgidJ6NQktEBOjqSvnrx1GgI9w6K55XWybH1ooxYOP4WlbrOy4/niqDOuXa9s8LYZYjTeO0iRBNNdoai+Kp5wPj8g2GpnM6AkUBTrmzlVurzaffdlhyLGSw2P1mjw/GvasFvxuW/rAQRAS23Rpp6+fntu9Tk0pJjeXxyfZ3sg5+86nsVNriLBQ3yZpUfUCEHuQ5xnF0+kmMOd0aU5aicHUU+0zRH2egmGXLgHD7qXSk5LIZR8jIq0dhYrfMfr2a6vIHZk0C+U3/2iSb1Fsde+cY0ujRVzUGvA5I1YlTf6bcG2LApPc50dFFEZhNkQ==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b227972-8856-4aa2-762c-08df09cd1f13
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 15:07:50.3771 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NSiwXfOjrzRO5/4DmgItiwHulq++92IJ0V8q1xvWWTk8f0DWVDq9mJVkGP47GZnSOX2wUVdqweULmqJhff6n9W3Z1mKBGf0E46XVS6jxgbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB7038
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

This function was initially designed to write a single flag in a pte.
The current implementation expects it to set several flags.

Fixes: 65c4f0999991 ("intel_iommu: Set accessed and dirty bits during stage=
-1 translation")
Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 114b1d7cac..350d2b7753 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1964,13 +1964,13 @@ static bool vtd_iova_fs_check_canonical(IntelIOMMUS=
tate *s, uint64_t iova,
     }
 }
=20
-static MemTxResult vtd_set_flag_in_pte(dma_addr_t base_addr, uint32_t inde=
x,
-                                       uint64_t pte, uint64_t flag)
+static MemTxResult vtd_set_flags_in_pte(dma_addr_t base_addr, uint32_t ind=
ex,
+                                       uint64_t pte, uint64_t flags)
 {
-    if (pte & flag) {
+    if ((pte & flags) =3D=3D flags) {
         return MEMTX_OK;
     }
-    pte |=3D flag;
+    pte |=3D flags;
     pte =3D cpu_to_le64(pte);
     return dma_memory_write(&address_space_memory,
                             base_addr + index * sizeof(pte),
@@ -2043,7 +2043,7 @@ static int vtd_iova_to_fspte(IntelIOMMUState *s, VTDC=
ontextEntry *ce,
             flag_ad |=3D VTD_FS_D;
         }
=20
-        if (vtd_set_flag_in_pte(addr, offset, fspte, flag_ad) !=3D MEMTX_O=
K) {
+        if (vtd_set_flags_in_pte(addr, offset, fspte, flag_ad) !=3D MEMTX_=
OK) {
             return -VTD_FR_FS_BIT_UPDATE_FAILED;
         }
=20
--=20
2.54.0

