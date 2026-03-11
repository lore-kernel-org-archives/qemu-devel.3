Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0618FD0648
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 07:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Dxj-0002xa-3h; Wed, 11 Mar 2026 03:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1w0Dxb-0002uv-Lq; Wed, 11 Mar 2026 03:26:27 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1w0DxY-00052E-6r; Wed, 11 Mar 2026 03:26:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wl5xUB2KAfZbH9z5xK0u6bQJEbpzNqVP9lu/ewua1MPX0L0SdarruBhIKGgk8nC12omlKz6WMChnEEIla0/EuOATYC3/11ucFIsnjJq9/zMWlw7+exvs8wtIDRfRZNqrBf8VZCYF6bdZdo8WHFhcUen0bfCTy9Eo6kazeA42AIGEPxAYIExN4Q9ls0xKnQ/g1GEYMbxfvG5whY0HSJidfuso8o5ZmOdmDpm1haTjzcNbU/7X0lxbg0rzFFXckt6hlpjtok8mgHLt7aMbEXl7TO8u9vOEZsHjtOc8IQZHDDukPXcbnL6T+hAymHMyPsiV6xbQC4CzaHo8ZHvhqd4/2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqg494BvsvvQ6ZpTL3f4JZ4ajiNLwiPpbtsjsthpESc=;
 b=POozIG93F+ipXrP/xczkW3+X03qLebFkHFjC24pRsZCaKTW+PVXl/DiVrSkhDtCS4/93xj4NLFQ2YenCLxAZ2whWpy9byN5e8HCaclF7nAGMnUJxtMKSo47JM/yDRQANf4XAIg3uO39oK8iHBPDt+BwRQeQX+kLh/SKIDaeeXsFUhVe9cq4It+mtYebSczvspbMOtoGk25TI5qAqmXXa+yKpfaZkK+QwPW9lF7CAdlZt8gpx/WXyT0/COMx5TWPzt70CG/6VIecYAnTnK5ZsLuV0PnbTUFEM4U9bF7zASPbMVLUHgFLplz5eoNANO9ELJn0d8yKdbGvj8mkr2wgKrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqg494BvsvvQ6ZpTL3f4JZ4ajiNLwiPpbtsjsthpESc=;
 b=dA9VCOo87XBuVSAxHryvKyX2JHbhxQpVSrWYfpAE82A56kZU7pUW2HpuSfQ3tsxZ5ZmSEQW1DpfQPdo/Be5+IZ8xkrbPhnpd6fZfoNcbiX6Q8ZdpIVv4RCYtOrZy8sb+yrca9y8hji3N9M51Z+PuGlONAyy+3nVKTI4VDAuYmhHTs3k6CKLoEuToo1H502CCq+ad5u0/6Sd8+zM3ZNY2XVCYJElFZRHEQsgMuUR95wDRA27J4mjKjqbGZB0Y96VLpok3VNuWD/PNVq5t+XSLmq4UWgd1q2s+QbFX3UenwJiA7FqbYuONNAsoYGYOIzT38tgzE02Zf7CcF5iKJ83dkQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SE2PPFD6A65AC07.apcprd06.prod.outlook.com (2603:1096:108:1::7ee)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.20; Wed, 11 Mar
 2026 07:26:16 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 07:26:16 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: [PATCH v1 00/13] hw/usb/ehci: Add 64-bit descriptor addressing support
Thread-Topic: [PATCH v1 00/13] hw/usb/ehci: Add 64-bit descriptor addressing
 support
Thread-Index: AQHcsShYjRpsic+o4USpJVYOTq2fiw==
Date: Wed, 11 Mar 2026 07:26:15 +0000
Message-ID: <20260311072614.1095587-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SE2PPFD6A65AC07:EE_
x-ms-office365-filtering-correlation-id: 3bae60e8-ca4a-4e6d-8f0b-08de7f3f7b38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|56012099003|18002099003; 
x-microsoft-antispam-message-info: Wn2/YCOQduxjlfKsbNwQq5GovFWJ8iizwZVh7p5xnBv6s3UbMsoJARCtNbXYNrf497UXqJY+QLM7r6sDNpEyMB56y/G02AhWujmYsMrZN/mc6fgn4QPHw30yC2DehC5hW3c0/1hjBRheEfuQKunAZ47EP+gn+5eHUc/ArnMtfS1wkAF722YIwVhToSaH5jalokKE4+nrvW3Io60W4/0isuxb34KbejHzuDBHDIJnKjdiqrcf2fDfWpJivYia8Rcj6xwKUF6eyWoMpKiYTJCx3Rv1Gpemvi+kQtM0DZwu4toS0eVe++G9fGLPilO/ub0JP95s7G2W9QG+g+I1boj7EKNGo1VEAGWjw3auD48Z7EkGYRzi8KyCwuPGYuMJCpcOSFpbUX8gR4KsVBvbTJKQMXtyxEWPdjTOHWpP1HLXXgYaP1ipwfNJwRtiOJaYv0MgDDmV8+tjFE6342Qaw28OVeeQ73x1iA2qXOYYWxZFOIuiveaB/tBYplKhP8lU3Xl0r8MPEpin9D9nWTRW1nwgmi10+l3BNIFm+sncjvgHDcWcpqK8hgMVaxAhbYWRMftTYcG4QNDkVGTQx9MsJbQSfVkC+J2ZD9QB9vQ1b1KzX0mh/1YBfv4GSfuP/bZcR94kZ2pB+hP95bshxeXtTIfGFRmq+mj9Ktn325elzOu/NKu8udOfKXkzXsq7dxUtX2mI4Ogv3aYKUopFf3tWEboT4Y2/JIB/MsS48D4sJkjvEZknnC13j42LXqiS+jZsQ9NF
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BdmfQTlKIkTrk+T/9s4/7+FharDds0DsXAQL2St1j/urmoMD/CNiHPdHL0?=
 =?iso-8859-1?Q?PuddW4KwGMuh1f7Vc0xXPaH3o6IcHk8fwV4dBmjko0nYkvVMCA3VQD6Dwk?=
 =?iso-8859-1?Q?6FX5G4AD32j1udiOAzRbiG/mbQ6HOiz1qCVk69aCv5YhottqmSghWFLQyN?=
 =?iso-8859-1?Q?PVSKKFbtt18smslky7I+ptz32LItLbXqWHZCHPNSVh/8+gsJKBM6QC5bCj?=
 =?iso-8859-1?Q?9SrbpEpdauh0q1aBDi22AvdgJ3iSwNHxH9uXoxjt76kfGVZEUnTrbveZ8h?=
 =?iso-8859-1?Q?Ug8ScOBb1SrmwLwk+oZjqy1I2G49rGdgi/DG+0f5Dg5z328Kbat81C+yD9?=
 =?iso-8859-1?Q?xzkksmFuC1AAlFoWBdC3shm16PnKWsMW2PzF1IzPUfs8/NQCUU5ARYm8zo?=
 =?iso-8859-1?Q?QhAQSKS994YMovwS+PDvvovd6qafo7O5S+R2O99tSa6+kIkVT2hx2K/JQQ?=
 =?iso-8859-1?Q?NV5w5HGqwcY9tbeOZuIlxg71/e4rBIdhMmXX/0qtY0IreEhkrf8mZ06Z36?=
 =?iso-8859-1?Q?o5t61z2khJ8FDsNRbkYsSazNtMxdckdrKu3hAoaY/Ol0K+iIF8mBH9TO3r?=
 =?iso-8859-1?Q?bB6bPi9fpa+DTsv77aNNBbf1o/ROAWRMEAv2EbvQsxj5/HSBVHfvooI5de?=
 =?iso-8859-1?Q?9rXbqaRpRojHVV2Oe5dCRSKNrEzoZYZfEC9oKdKFlO+j3i0aPH1iMW7+ke?=
 =?iso-8859-1?Q?J76ykS7dStlmvIXcXcGW0wQ30IkJlRk7W8ix70t6YhcFK1RnlUsxOYpaTu?=
 =?iso-8859-1?Q?j0uNMoKJBsL4BjamSR6Puv1j/Pa2mO5HJhE2QEa7ibVcAbzEdFW3+DrYMB?=
 =?iso-8859-1?Q?J+dZJZywXBgaoEWg2non3IXkRzSajIO5guYpcx+qrQnV9CYsnWvb/99u4G?=
 =?iso-8859-1?Q?vlNC+L0Dc6VaTQyt0MBbjp4M0A0oWq8dH0RN9eWPT4PcA3dh8hjCZ+Y0g8?=
 =?iso-8859-1?Q?RWlAXTJtzgBAz8xdwCcUpKkGJB+1iC28DRN2f9UuFo1Ux2pUnoxalIU9N9?=
 =?iso-8859-1?Q?jBENa8urHIvYS1amC6Kaamkx/JMqwTk1JRhspV/Yz6si51RUnQk9Ez4GW2?=
 =?iso-8859-1?Q?gd1E//q7SAWFjbZVo5iBeideg2gCkND3WccOeymXBvf66rtRUGwdHTCxKk?=
 =?iso-8859-1?Q?oT9/akbgd/ifBU7mlzyL8Pjzovjmzs4v2uwiDJAi6bJBoBTWbS9jJKcSFP?=
 =?iso-8859-1?Q?Zb2tbt/v4Ya56d5qs6X5TD7gGiYYsfymJT5fda7bDFjLDtyOz4+TcZiQdD?=
 =?iso-8859-1?Q?wH4e4B2RdKSAj3L/3tmgRS14uymOQ9EJb2AvpBSauYzx4KeAu64JhQML+K?=
 =?iso-8859-1?Q?bGi70kMb0NmMIabUvOJ6KbMT/08Dd1hs5RXPdRzypQJQ0y+zBe7yQnzKDK?=
 =?iso-8859-1?Q?zY7oQQftjRYX8B3/wVqv0TGR4pALMuKwd+ZT2g7/YN/lFUADY2Ia5bHg2a?=
 =?iso-8859-1?Q?Y5ijQm27Rh0shRNUC9FLbQv3/Fszj1jQD3ThOgBUvP5jjmYE/XUMleXUQW?=
 =?iso-8859-1?Q?ED7hvg3fUF4EuX1uUSSUw7i/n2Lcl5lKz2P7z/vvK3pk5sWkTnLiROEyJ5?=
 =?iso-8859-1?Q?GtiVyyQlXU9919wII80SusnNQrVWhws+exGy3nQU2kK2a8+xTv5Xjhcb6S?=
 =?iso-8859-1?Q?qRU7TSmvLvBz3RitFuz6632kzw6Aftl+L1IKCt59/OmKTN+7f8t3hnb/Yq?=
 =?iso-8859-1?Q?ropAf0nQ+GVky1h/7yMxKpO3Iy/1CHd06UU9co62TbFIxyexukQRrwnor0?=
 =?iso-8859-1?Q?qj/tu0l3K2nV9IeJ8ikRiCsCNdsZ/Gk37S3kkK5ApyCylf7AZ6aG2HrDsl?=
 =?iso-8859-1?Q?4M6iZ5dVfQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kAHllKW3k/x1/AKQuevaADWS4t4pf1DQYlwjhHcbTq+QX+YGIwJ2Y+mQpCrGd8yoyAFuC0Lf3sHrmTQG3VTxMHzvc4Phiz/4sqzZhv83nUMlWhhQKuVm6eDxSO/bDcimgimvdM9zliXF18GSNoz2gBJ5Tih8JQYGxprWpnoC+HrKMhWHNWjlwFAtnQlwgX7bvnm8UKBTcKh4JHqXlIz2iEUH3h7SuSP1S/HXMFr6C4lKlizqF1rjZvoT7oATImhni9CmvqpmzWkn+Ydcd3BbzFfaSD49JIDAu2ldYLARTrCQqo7EB3po0pmSuE9QdQIJvzepX+ZmTwHjGwNKluRIYQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bae60e8-ca4a-4e6d-8f0b-08de7f3f7b38
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 07:26:16.0062 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NjbuNXNuvVNCk5rbXvVLDKjDqmQg152DK023HQGTguIBZaNQD4c8XOxTfgKl74hOZhwI4Aln8NSTtVmP4Lqrx1G2CHmCsDSGLQi8V/nPOJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPFD6A65AC07
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

EHCI supports 64-bit addressing through the CTRLDSSEGMENT register,=0A=
which provides the upper 32 bits of descriptor addresses when the=0A=
controller advertises 64-bit capability.=0A=
=0A=
Currently QEMU EHCI model only partially supports this functionality and=0A=
descriptor addresses are effectively treated as 32-bit. This becomes=0A=
problematic on systems where system memory is located above the 4GB=0A=
boundary.=0A=
=0A=
The Linux EHCI driver enables 64-bit addressing if the controller=0A=
advertises the capability. During initialization it programs the=0A=
segment register to zero:=0A=
=0A=
  https://github.com/torvalds/linux/blob/master/drivers/usb/host/ehci-hcd.c=
#L600=0A=
=0A=
The driver also notes that descriptor structures allocated from the=0A=
DMA pool use segment zero semantics. Descriptor memory is allocated=0A=
using the DMA API and platforms may configure a 64-bit DMA mask,=0A=
allowing descriptor memory to be placed above 4GB.=0A=
=0A=
On AST2700 platforms, system DRAM is mapped at 0x400000000. As a=0A=
result, descriptor addresses constructed directly from the EHCI=0A=
registers do not match the actual system addresses used by the=0A=
controller when accessing queue heads (QH) and queue element transfer=0A=
descriptors (qTD).=0A=
=0A=
This patch series implements full 64-bit descriptor addressing support=0A=
in the EHCI emulation. Descriptor address handling is updated to use=0A=
64-bit values and the descriptor structures (QH, qTD, iTD and siTD)=0A=
are extended to support the upper address bits provided by the segment=0A=
register.=0A=
=0A=
In addition, a descriptor-addr-offset property is introduced so=0A=
platforms can apply an address translation when descriptor memory=0A=
resides above the 4GB boundary.=0A=
=0A=
The AST2700 machine uses this property to account for its DRAM mapping=0A=
at 0x400000000 and enables 64-bit EHCI DMA addressing.=0A=
=0A=
Test Result:=0A=
1. EHCI 32bits with ast2600-evb machine=0A=
Command line:=0A=
./build/qemu-system-arm \=0A=
  -machine ast2600-evb \=0A=
  -m 1G \=0A=
  -drive file=3Dimage-bmc,if=3Dmtd,format=3Draw \=0A=
  -nographic \=0A=
  -device usb-kbd,bus=3Dusb-bus.1,id=3Dmykbd \=0A=
  -drive id=3Dusbdisk,if=3Dnone,file=3Dimage0.ext4,format=3Draw \=0A=
  -device usb-storage,bus=3Dusb-bus.1,id=3Dmystorage,drive=3Dusbdisk=0A=
  -snapshot \=0A=
  -nographic=0A=
Result:=0A=
unable to initialize usb specBus 001 Device 001: ID 1d6b:0002 Linux 6.18.3-=
v00.08.01-g172b7e27a30d ehci_hcd EHCI Host Controller=0A=
Bus 001 Device 002: ID 0627:0001 QEMU QEMU USB Keyboard=0A=
Bus 001 Device 003: ID 46f4:0001 QEMU QEMU USB HARDDRIVE=0A=
Bus 002 Device 001: ID 1d6b:0001 Linux 6.18.3-v00.08.01-g172b7e27a30d uhci_=
hcd Generic UHCI Host Controller=0A=
=0A=
2. EHCI 64bits with ast2700a2-evb machine=0A=
Command line:=0A=
./build/qemu-system-aarch64 -M ast2700a2-evb -nographic\=0A=
 -bios ast27x0_bootrom.bin \=0A=
 -drive file=3Dimage-bmc,format=3Draw,if=3Dmtd \=0A=
 -snapshot \=0A=
 -device usb-kbd,bus=3Dusb-bus.3,id=3Dmykbd \=0A=
 -drive id=3Dusbdisk,if=3Dnone,file=3Dimage0.ext4,format=3Draw \=0A=
 -device usb-storage,bus=3Dusb-bus.3,id=3Dmystorage,drive=3Dusbdisk=0A=
Result:=0A=
root@ast2700-default:~# lsusb=0A=
unable to initialize usb specBus 001 Device 001: ID 1d6b:0001 Linux 6.18.3-=
v00.08.01-g172b7e27a30d uhci_hcd Generic UHCI Host Controller=0A=
Bus 002 Device 001: ID 1d6b:0002 Linux 6.18.3-v00.08.01-g172b7e27a30d ehci_=
hcd EHCI Host Controller=0A=
Bus 002 Device 002: ID 0627:0001 QEMU QEMU USB Keyboard=0A=
Bus 002 Device 003: ID 46f4:0001 QEMU QEMU USB HARDDRIVE=0A=
 =0A=
v1=0A=
 1. Fix checkpatch coding style issues=0A=
 2. Implement 64-bit addressing for QH/qTD/iTD/siTD descriptors=0A=
 3. Add descriptor address offset property=0A=
 4. Enable 64-bit EHCI DMA addressing on AST2700=0A=
 5. Configure descriptor address offset for AST2700=0A=
=0A=
Jamin Lin (13):=0A=
  hw/usb/hcd-ehci.h: Fix coding style issues reported by checkpatch=0A=
  hw/usb/hcd-ehci.c: Fix coding style issues reported by checkpatch=0A=
  hw/usb/hcd-ehci: Change descriptor addresses to 64-bit=0A=
  hw/usb/trace-events: Print EHCI queue and transfer addresses as 64-bit=0A=
  hw/usb/hcd-ehci: Add property to advertise 64-bit addressing=0A=
    capability=0A=
  hw/usb/hcd-ehci: Reject CTRLDSSEGMENT writes without 64-bit capability=0A=
  hw/usb/hcd-ehci: Implement 64-bit QH descriptor addressing=0A=
  hw/usb/hcd-ehci: Implement 64-bit qTD descriptor addressing=0A=
  hw/usb/hcd-ehci: Implement 64-bit iTD descriptor addressing=0A=
  hw/usb/hcd-ehci: Implement 64-bit siTD descriptor addressing=0A=
  hw/usb/hcd-ehci: Add descriptor address offset property=0A=
  hw/arm/aspeed_ast27x0: Enable 64-bit EHCI DMA addressing=0A=
  hw/arm/aspeed_ast27x0: Set EHCI descriptor address offset=0A=
=0A=
 hw/usb/hcd-ehci.h        |  36 +++--=0A=
 hw/arm/aspeed_ast27x0.c  |   5 +=0A=
 hw/usb/hcd-ehci-pci.c    |   4 +=0A=
 hw/usb/hcd-ehci-sysbus.c |   4 +=0A=
 hw/usb/hcd-ehci.c        | 293 ++++++++++++++++++++++++---------------=0A=
 hw/usb/trace-events      |  16 +--=0A=
 6 files changed, 226 insertions(+), 132 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

