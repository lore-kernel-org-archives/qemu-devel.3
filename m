Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B7DCFB44C8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 08:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGBY1-0005LM-Ku; Fri, 24 Apr 2026 04:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wGBXo-00056J-57; Fri, 24 Apr 2026 04:05:48 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wGBXl-0001I1-Ax; Fri, 24 Apr 2026 04:05:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNHcGJO840b06Zm/U1gmAwNsWJYI9/3aiMSdwtb9fIeIGlX1pjPk3a3KWId3zTlIlQDdwMFwA1fgGvWi+Y0ziOwcewBaTnIQLHzL7eFKMV0cdi/Cr0eLc8D14QnjQ2wSd2z2g+/iXEHRndqOnk/iHnjVeqQVPpgO9cvZOZgyc/w9YndxBaFtOifyWjABSDPjLdnFSvoeqhsd0ofR1cZv+enM5jzYQoY1Ur1HNeTUFGf9W4fXB8EfeduZvjQLqBsMcAH3QcGTd2q9ugLSfmo8GyP1J5cd50kn3HP8u08M9aLo3KWpckT1taB7XWPJlwKyYbQcoka9qMluZUB9NHL0Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SoGU+rJVb29U1hotc8FeJWSPA97ppI+JmgDf35F05Y4=;
 b=rbMmWC5ZqvTG+KuEpK5xg0710QT9iLzPCK4rh2geN5sutn7lghceSUrACXHa78FQxJvK2nNWHgnu6W9wSuxdtq3A41GwA0Gl40yJvhy7UN+EkvSr89XY5jVPEuPzNvEdnOhN5OWBBw6UOSCbxMUQjoFruwMuvaVEy2HR8TEllk8iNTZthsJZSX5PuEH59u38DWKeaPqosxFJh9uq0oBj+QfakDbr7t2albGkXwpXuRlO0K2Ce+NmQPU3StDY5iYpUnHfyb6efWXWVWAIhY9mrtJpYsQ40fP16G961rcoTB5IA9ZQUV9WetN4s8aFd3dU6Zp4sVixodTInxkcFu8Jrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SoGU+rJVb29U1hotc8FeJWSPA97ppI+JmgDf35F05Y4=;
 b=nN8vHLRuiE/PDKPcenFwYVXJdbWYZC3C2/DuKFYRITm1bHgTXGJSusroSaK1JxQ2Ry/4m1FdpCndoU1iP/YC9mpov8PAqqIHK0cJWP//bSjtRHTjVb7zXP+RW+wh1c4bcTg/qvuo7M0khe29yV4yA5ETMSEzHkVw0XHTJp/jNHED+vwcIGFa8aOPcJxmPfkHjL5OR4yWyHiWe+Jwu/Hx53quw7r7kKOIXCSLYbAmbSX/6H4Y/AYSgPi72sghcMOV/xyIf1hURfB0FV12mg08Ap2ZETQuVKuNJohGcAHl7VlgvwZmzpVql+0PRiDIdcB6ART7Rhr2MccgwxkbZOJZjA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5856.apcprd06.prod.outlook.com (2603:1096:101:9e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Fri, 24 Apr
 2026 08:05:29 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 08:05:29 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "peterx@redhat.com" <peterx@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Cornelia Huck
 <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, David
 Hildenbrand <david@kernel.org>, Halil Pasic <pasic@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:sPAPR pseries" <qemu-ppc@nongnu.org>,
 "open list:S390 general arch..." <qemu-s390x@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "farosas@suse.de" <farosas@suse.de>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v5 15/18] hw/usb/hcd-ehci: Add ctrldssegment-default property
Thread-Topic: [PATCH v5 15/18] hw/usb/hcd-ehci: Add ctrldssegment-default
 property
Thread-Index: AQHc08EdvTuRAugJRkC+lDbQz1jutA==
Date: Fri, 24 Apr 2026 08:05:29 +0000
Message-ID: <20260424080508.53992-16-jamin_lin@aspeedtech.com>
References: <20260424080508.53992-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260424080508.53992-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5856:EE_
x-ms-office365-filtering-correlation-id: a299c037-ce1f-4947-273e-08dea1d84062
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: LrLdzdTpXfElMxykly8d9ilb5MFccTjQKDmLFwb2j2pmXME2kYzMc56bQo6k+KbT8eaSN+y3FGn1cHV7Pm11R1vFQKYUCq7qKVtco7vkxvCu458/5o4Qfoj+BpjIW9P3RpP/agJpdxjqP8V035x5PkNMMJ2KiZSkilFLioqw3oNkvwXUcP7rc6RJ4QHimLm+p6ORlPqHqdO6GoSP4XqCiBREo7C/D5m5N3NByBo/EL5b/E9heKSF/IaS5puztSY/eL/TOxMkPLx6AQW+SerqU4AMAr2BlAXheepABeHZ7LYfRsMsIV01gwzP/44TN2tc7yuBCA6GWTAoJi6bjO/ZS11K6uhic8r1lPrTrANoy01urP8MSkWedfjfbp7yCuMdUgz0PuknGuCAAd2qoddyynVQNXER9uClIFhctVrz4TQD2u0KmoOb66yzA/uoyi5Rpcq7MEcDX1ZtvXZR8NVZcl9+3JmRMe2CwIgDyYKMGhYTsGgPjQZwrltDoYitnZMLoHHLqqU/Za7JpiudTxzHnyCHJsAfiN4QlDwDFeOctqRqYJzSXZ5WlN5Zf/2eJ3ejuWbrnAfDX3N8PYS+dBVbKZOBPvKKpi6FIKUtx/0wY1QIxCn9hjp/mBAYiWcUR3MRzjQJiv+TSK+X+Es55bv4ig67ZjsVYPJrANtylR7X/Xu+JISNRvIUyw2teBxq6rfURnwmKfrsS9J519GG/4uuiP2Mdv398uid2yQ6PfJkpDcbeVyCav03OJYaN0ys2SlNSz94hoaeuLXGiSdT5Y5JzUWdx4dBIsNPyiTXaYxMLmUonfYYEeivEC8zd5QoiVNW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?S5uotPeQ7YAGVjV0jegHStTa6A7Sc1x++x3IwncMf/UrI3y8Z0NAdQnPHH?=
 =?iso-8859-1?Q?mm9AUPeudxBxGWXJHtRgrspdC6OgIe5yO9o/6jiGU6JfXceB7pM4Pcrd3o?=
 =?iso-8859-1?Q?Pe8ssPiqbNP+cKiQ/88mLd9TQ6dt0ySWl8juzR4pHIjbJ8GEWxYMRaurEF?=
 =?iso-8859-1?Q?W5AXrWo+tb1SwYmZTYRk+mRWW6nj3v6DQi8mo3+owBOs3/yCIzXiJ13h37?=
 =?iso-8859-1?Q?hE1NhDlggrPxOQix1lByXvLU83u0qVqJ0l3HVrr2+dpdkr0U+me+RICvXc?=
 =?iso-8859-1?Q?3bpCJ/fjr6lhT1MMdaKAJPLswWJOJAbXB8PDyyC7+SSsHLqMWe+HYG0GgI?=
 =?iso-8859-1?Q?ZLBPVWGA1VCSGf2oUUFm78xRLLz0I7GZ3p1oogY7q9q/u7ZOAmNJDuB3we?=
 =?iso-8859-1?Q?oLjTVRKSUdtm7N64BIaycc9Z4A9PkPS//Pqv7wdDd1R4UW5sfnhpJb9/BT?=
 =?iso-8859-1?Q?Z/uu94MNZnr5zHqHf9dGlFyADwU6HrMOZonU00NsP/hzG/wxt/Z/+LaHwf?=
 =?iso-8859-1?Q?FsXW1TTD4QqUyUPKvIwue9o/2frqEBAZUaj4GIELbRZUo0UMQpqpn+RNnI?=
 =?iso-8859-1?Q?/bI/LoX0IPLNh9TNOn+htW6hQzxYkITXMuHuxmbz1kG5mSADf9staMdUvj?=
 =?iso-8859-1?Q?2gMblHKmccIUf+Ox6my6AuVz7ovsvkxYljqcbME6mi9dM9CekE4tjRIhGr?=
 =?iso-8859-1?Q?iNO8RhkSaRXZTH4+Yy9jULKNQunFCMt2ALBWTIHnZ5em7KaMNHv/aWzPff?=
 =?iso-8859-1?Q?dDhw/afCtWkcVt34bfiFbUhRftQP+Mig4/oIrevoFwDz+7HkBZX5br9IDL?=
 =?iso-8859-1?Q?QMSf4No3qStiIG1Vma9Lyts8jpm6Ad1S/4MzRNmTpOAuhb4s4CtQfDeHVQ?=
 =?iso-8859-1?Q?OFSHGFoOHTv0hw5bvq4dgs2VHnFmwGtHx4LiTFXrnj64D7JTNATHG2jgkZ?=
 =?iso-8859-1?Q?yFtTuRkf4bF28JYSx88RigQMSOe2COpoYZkuOiFCtyogRzDcQU/z8y/28u?=
 =?iso-8859-1?Q?5/cCRlYeUJPNuqDC79kNF0lZEamgEBbkiyO0dlDrab/wgIOfxn+cqWxIaI?=
 =?iso-8859-1?Q?36utabk5mP7fttzU/7ofEymy2Nn2xjSVArRNr+nKjCUo46VprqcVqGXgfM?=
 =?iso-8859-1?Q?LSPjlU12FAw7M0g2bFXXKLSyvU02IjswkOxAhPG9PS3l94GhPrA3cB8+9Z?=
 =?iso-8859-1?Q?mDmWZus11YQVmMXsxruHAYbitB2QheOjVKdUQtP445ZFwu0wMY8zy6pj36?=
 =?iso-8859-1?Q?kQZrbKClsBtnBcRDgrbMBh6TIoZvBpGXMnbVCjsOXIRVBDRLt46vhPSjBv?=
 =?iso-8859-1?Q?a/wZAq2ssUTJ2i2Z9/AlPdWaEnkFRCKvKJSXjfIOVGoBCVPyX7mWlg+wVN?=
 =?iso-8859-1?Q?/Ifdn5D8isWhxDKssfOUY2Xqjb1HcGipK+KWO22KNsoJcb6YDGEwVtDtrK?=
 =?iso-8859-1?Q?3FWT1cqcbk3k1x1JnhO/yylm7Rx+rKYOBCq/qGQ/jVTWwvgk+VbL2il6U4?=
 =?iso-8859-1?Q?+7UmR67H6qvWSHi5qK4pZlJhLUnwUVZ8hprRrX2SgEWXvzExgB53mHPnbJ?=
 =?iso-8859-1?Q?hhEzZwyjde3FFFogCp/ARvhj4GBg0ZkrsT5emuaB4nWsSm1u8eH4vnskQf?=
 =?iso-8859-1?Q?6pOrh1sCYlPrb1SJTtxn0ofYMZkm0/WRTr78JM72yLUvIJtbrqV1Ndv+VD?=
 =?iso-8859-1?Q?LtIockw/rXaL76LMAIonQ9A4csR+U9ms7XGdVa+g9+O1uqguPA7y7DMNQA?=
 =?iso-8859-1?Q?n+iANSJmAUIRUhrlSO9InrzcKL6jXQWnoTpvV/xUp4vJbK1eureKwVcH6P?=
 =?iso-8859-1?Q?YPvOghSZYA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UPTJNHTp0GHKw89e+qLinmf92upcOQ77cLtZOQtyxq5qKBNwNnEzsxQw3B3xrjfb/iaFcWuo1tLLX9KBGcY6acNCaINO8g8t4QFXOwveRmY1eHdSTwCl2qAMitrElZfa/YLscmPTgL2YGf4p02/AnNiWc+dV8vijjJz7YymO60UaWIxT+M8uIe+a2QJ6apQRMWpizpKkKQL6JhfG3uqgsjH1WQUY+h49gv7oNp6UDrKIwna/XBOk9bDYu6XlvXg3IiOEXZ6bVAYYtriAsrfFC+x3vnkv2EvdKj410qHHFLqX7QKmin6s8Zef7jHq8l/sWZvhUoov9inpsWnFx77svQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a299c037-ce1f-4947-273e-08dea1d84062
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 08:05:29.8111 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bR3YP51ilwnHhG7CiOa9yfXkypboBT6XR5xmh5vPkytc51SjKzoq2+xwEV2nGTzskxJAvLBav2JVfLoTWorTmjbdmQgvP01Cdr9vDWeiw2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5856
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

When 64-bit addressing is supported, the Linux EHCI driver programs the=0A=
segment register to zero. See ehci_run function:=0A=
https://github.com/torvalds/linux/blob/master/drivers/usb/host/ehci-hcd.c=
=0A=
=0A=
The driver comment also notes that descriptor structures allocated from=0A=
the DMA pool use segment zero semantics.=0A=
=0A=
Descriptor memory is allocated using the DMA API. The platform driver=0A=
configures a 64-bit DMA mask so memory can be allocated above 4GB.=0A=
See ehci_platform_probe function:=0A=
https://github.com/torvalds/linux/blob/master/drivers/usb/host/ehci-platfor=
m.c=0A=
=0A=
On AST2700 platforms, system DRAM is mapped above 4GB at 0x400000000.=0A=
As a result, descriptor addresses constructed directly from the guest=0A=
EHCI registers do not match the actual system address used by the=0A=
controller when fetching queue heads (QH) and queue element transfer=0A=
descriptors (qTD).=0A=
=0A=
Add a ctrldssegment-default property so platforms can provide a=0A=
descriptor address offset when constructing descriptor addresses.=0A=
This allows systems where DRAM resides above 4GB to access EHCI=0A=
descriptors correctly.=0A=
=0A=
The default value is zero, so existing machines are not affected.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 hw/usb/hcd-ehci.h | 5 ++++-=0A=
 hw/usb/hcd-ehci.c | 1 +=0A=
 2 files changed, 5 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index 8e6a8cdfb0..3d57e1de5f 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -264,6 +264,7 @@ struct EHCIState {=0A=
     uint32_t maxframes;=0A=
     bool migrate_fetch_addr_64bit;=0A=
     bool caps_64bit_addr;=0A=
+    uint32_t ctrldssegment_default;=0A=
 =0A=
     /*=0A=
      *  EHCI spec version 1.0 Section 2.3=0A=
@@ -322,7 +323,9 @@ struct EHCIState {=0A=
     DEFINE_PROP_BOOL("x-migrate-fetch-addr-64bit", _state, \=0A=
                      ehci.migrate_fetch_addr_64bit, true), \=0A=
     DEFINE_PROP_BOOL("caps-64bit-addr", _state, \=0A=
-                     ehci.caps_64bit_addr, false)=0A=
+                     ehci.caps_64bit_addr, false), \=0A=
+    DEFINE_PROP_UINT32("ctrldssegment-default", _state, \=0A=
+                       ehci.ctrldssegment_default, 0)=0A=
 =0A=
 extern const VMStateDescription vmstate_ehci;=0A=
 =0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index dfeb8ef70f..e8086f0432 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -1134,6 +1134,7 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,=
=0A=
                           "      64-bit addressing capability is disabled\=
n");=0A=
             return;=0A=
         }=0A=
+        val |=3D s->ctrldssegment_default;=0A=
         break;=0A=
 =0A=
     case ASYNCLISTADDR:=0A=
-- =0A=
2.43.0=0A=

