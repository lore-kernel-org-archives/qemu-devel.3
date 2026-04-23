Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9EF3FAD40D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 05:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFmSC-0007OJ-HH; Thu, 23 Apr 2026 01:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wFmSA-0007NQ-V8; Thu, 23 Apr 2026 01:18:19 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wFmS7-0003Bi-W3; Thu, 23 Apr 2026 01:18:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPVfLGm4Z202/0wAxUezqHqGUojtPfW/acQCa1Y/GCjPIuwq8Bz2TYnxc1c0rCQ+N5xjap3eq6iNp5HUMSI03iR/S8eYJT7zyp92lAgQrm1IQQNdPoJmVOG/rcKGz0e6QkiZ12xodaZJLdGUQqIiaxWljRFs0/L9/corMz25Lir8yCBmkN8H55UKRVozOyFkzUh+z4dIcfJgHvJKIywMCOOMhwiNTmbRg8eozAAbb19iFpuc71LofdL92KJsXpz4bDjibve5GQs8e2+LbCD88fVFbjHCzjgQQeFh7GFsRJ21CZisOkiHp3jTUkiRjdo0NiLpzSfS2h22h696jCbO8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4oy7GktlsKBBD8YH5rJpbGkUKNNBdU7R8zKjX79FDM=;
 b=OtMt+r6WZmZpE4WsHTmvAtIWkR5APUWRx3QGec8lrITiKgR55iaNKm5SKRt5+dv4+WuuFetZb+mGSTADyn7fQfDRpWssSsoJjwUfrdms81PQ91qthKPTyeJqMmcCB25NESWpvUv0J8lf0OuDJxNJaZRw+5+TnqBkqBULNzWzKKA8c3iREgIVRPop6xP4zxEg7FkgISEjogXAD4znDOnKslQHUAXJhvd0qZqJMSCb5/hu5mcoiAqxjFGAuRGYW2ce12qW7Nmvx56SsoJIcBDCotHmC9Fu7vOW1XKKEf/k9bIjxjhsixU0T2tInL8O+wHQ7YIRSIilnmymd6Gz/iKWCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4oy7GktlsKBBD8YH5rJpbGkUKNNBdU7R8zKjX79FDM=;
 b=qrW2C0JUR8aPdAsnKIk30cggoGFD9e8AsJuh/ZpKs9Pgg9cQP/eamEduNsoDErXUdcBUEKp+unuqZkOTzpL/sFWZKRDCSt7itwMndMNcC5EVJPp/rxqVFS7PesqeNf1zzki0QSJ5aMP03hKj3I4EmFCwxSRC4YSRfgqyU5GlUXkATEin0M4qnR0yVCS9xeUvUU5OdmANvHJ6EduJo0bWRfeE89WCagBgsv4EMRoOmXb0GhJxFltFK0qUgDgnBDhDztwxeiR9DEGF+gPUjwluDXb874huqIshrucKo8h+6x+rV52qYBO50KsKoEAS1EF5JfFCm+rxRu00VRx9PnC7NQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUXPR06MB8534.apcprd06.prod.outlook.com (2603:1096:d10:9d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Thu, 23 Apr
 2026 05:18:06 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 05:18:05 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@linaro.org" <philmd@linaro.org>, "peterx@redhat.com"
 <peterx@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "farosas@suse.de" <farosas@suse.de>
Subject: [PATCH v4 00/17] hw/usb/ehci: Add 64-bit descriptor addressing support
Thread-Topic: [PATCH v4 00/17] hw/usb/ehci: Add 64-bit descriptor addressing
 support
Thread-Index: AQHc0uCQtpqfmaNv7kiAi9Svgwav0g==
Date: Thu, 23 Apr 2026 05:18:05 +0000
Message-ID: <20260423051804.362095-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KUXPR06MB8534:EE_
x-ms-office365-filtering-correlation-id: 3ca5a1df-c4de-4363-c771-08dea0f7b33e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020|18002099003|56012099003;
x-microsoft-antispam-message-info: 1jb2Eb4LE3sZwzy5TzTt5ESfEcG2njgqlyCpx2D40MoxyC3suanjZZhRqOYdODpGhCtTtvAeVmHQ4dzPlp79m60TwWMmgze6i17ACFPMRBcbk8VpnZMoAyM7daFHuUWyGPiUt8KAoHBt+19WMTM56YKcSwmz5EL0UapdNoXcFpazFlUGNVEO29HE3zpedjKDJbZNZVOKTN616Hyxmsr8SHN5sxmma0JgTSRZUNX/NVDcv/l8t1h9JId4SWCJDmv/Al/oLELE5dBSoFRSym4Y3iZ7BCcvpacbLtaCLdZEJ5T2GwG+zMPJefs+mwSC6r/9Zh2WioC9+JhjRGGaLIShEqFcTl0k8JCABVtufKApOwONKlXBCxfjS/qdDNsQ0LUprZrVORdf3a72wEelNFCajUc6s55wyQ+w9GsIQbawL6XU7PpHTiefAinBj994AlkkXMIPVQEVmJiKcDZrjPA5Y6kAlAnhWKXlbrS0xZqRgdcyVcTxpdpRA7u/oqf2Oj3fvBGYNYeMQ4KrjFTzSsWdtrkoZoNd4hlbO40wA/Xwkg6pQClDBbPMPpX1YsRLZBWQ/eQOStfz4NxlXjFPbKnpBdov1s8+rMqkvbEOFmKZEWY55p73zouUltbuTQR2kVrYmXmXeWaYi23JJEwBbvnFkbTEitDZADSunfMf+uE1fc5sXcEPcmi23KLNXwRbAbIKad7EaQGS7tdRjsHtqj1aDqfcAbg7gQRoiGInq+i/gtApEDm8G3uVcdM1U7kIwVqgUfrYvkWzV8krXTTf4TnbjQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?m6UqNSxSUIXmkl7bCeaP+7YagRex9FidyW5DbeHmNv1Pt/bKvJ3cvs0OHY?=
 =?iso-8859-1?Q?pQ2RbfcrgfuQVOjldeeATvGUm2RLVMzmo/p8JsmQwpMBZz52ThEKU1vNiB?=
 =?iso-8859-1?Q?Cgj5CyHnimtgTHF6+gb9p83vVhIjN5M1jULrxqI6He1VtL2PGlSjvCPNBz?=
 =?iso-8859-1?Q?d/ioGyA46wkrxciSXls0kUYhniMffP/wTpO+HpU6BmrQeSUoNdkNteh3eE?=
 =?iso-8859-1?Q?eC2GJn9/pH1JJleYhvDk6kEVOuPfwzhHcsG/p7qlZR35AGsZWhmjVtuIfK?=
 =?iso-8859-1?Q?JtrkUqtR1obu3G85GY8DcgFjelhDCPVQIgcsYIj2EoqxGcXMj+7d9TSsHw?=
 =?iso-8859-1?Q?RigVmycz5SRy04gsKcfdItMC1FFZgkkWDFBcyFjChlWekxwyq3AKhRHf5W?=
 =?iso-8859-1?Q?q0ihAreclflk/L9XQW+vUQHFpomDj174D+IXlZDljdnblg24Ln4gyE7rQm?=
 =?iso-8859-1?Q?tMfbuSEPlIftQM9k6jriexPEYWw3FK//y4ieMbUcYa8n8USbk2zvq/Avhw?=
 =?iso-8859-1?Q?QukPAucXXIzN3uy/nonlxknKzGwHD5b/OE1c9HsB8wyJ8VrtIZuBna54O3?=
 =?iso-8859-1?Q?s/uLWrOpO7oCayt5KWTW6R+F9W7ZSjiLU8F/ws8D6TcbPpD0BgkWtmvLWt?=
 =?iso-8859-1?Q?gEHjanRCu3oLVuQCKNy1LVcifevkMWVgBvXjIF9TFclKOOnf4nfYeYLMh0?=
 =?iso-8859-1?Q?fRsb4cU1Npc8HYQb2E+Mucv4GLUN8i17Q6PhuNyxzopiH1Gh/byUiqevxx?=
 =?iso-8859-1?Q?tXAxmRvb4qbjtP9+erLFNOPSLPBewPZWWNwXYLi+gdz6OQY8jSmHkpnmu5?=
 =?iso-8859-1?Q?1+udUCAADu7N+gkYXOWxZM8JszcT8oQXqt0j108m7pSF+8iBo0GilqeFJL?=
 =?iso-8859-1?Q?Ff5JCQnTpJFH0fA4lERiBB5OwnlIwiK8hgKsljArUXxz4BPzdpviuqS+tK?=
 =?iso-8859-1?Q?mqjot6KLrjjlQRuMv2sHgq0OGrsQwOyiHHDJa7W2iA2yMuD1yk0WSm3RN/?=
 =?iso-8859-1?Q?0tXOJ7uLbMwg6Doww64mb7tvWdlC7jP3mWKxqZfWRFFVf1ojqFFL7TlAQx?=
 =?iso-8859-1?Q?fosUKwYuO41EMZEb/TVbCIGANJ4BUVqUUh6gTGm4I3+Bjdvsu4PgvLVdKM?=
 =?iso-8859-1?Q?JBhx+tc3SjVZS+gZtDt+EFO65a3T9K4YA3rjSMjPx30xhjHhIAp+0UEm+q?=
 =?iso-8859-1?Q?1Z5xRYW4o2fVLWUa+jhEjojV2c8T0D2u9eaUUSpfLOARoKYdz5lIB+WJe8?=
 =?iso-8859-1?Q?1t1W9d/0ju0Yt52liBCxfg7CbFZ5U+0ZJq1eDM9AcxRO7AfbiEvw5TNGcN?=
 =?iso-8859-1?Q?7ZblQLuC/I/WOew8F62GVfkpWQn1awsD/HrhhV8iaPp9jJFNATg8S5GpMX?=
 =?iso-8859-1?Q?/XRDUv1d37WsAMvDrUd6u1WEWoRixhZZ1UUNX31S+j9ReojYpDmQSAzs/J?=
 =?iso-8859-1?Q?8IyHw/H/qfai1sxgu6WlLwpIf2Ilgzdw8PhT1NJ3970jxtYJ4RcaNdyeCs?=
 =?iso-8859-1?Q?YIv8zjQ6fuyPaQJ118LdrUGf8YZ5pFLB5yZRu6TqHluHShTP1VsT7fMr21?=
 =?iso-8859-1?Q?Iiusgqr7QvBhXAKeMV3mboWsu3ZDF7Ek2ICaULbLLSsmJzqZ30xBSUWOdU?=
 =?iso-8859-1?Q?LtdcnspmIhPf/ujTGI+excpFgFUmFE0UNt5wnJ3xjFsR/fRVoq1ztmtG7n?=
 =?iso-8859-1?Q?PPW6ig17ZxmXE0XrE5ez5sg2zA3JQ6FO81OxNv03wrZrXO5Z4FQ2hPeuIE?=
 =?iso-8859-1?Q?1JJbxgmajNwMTOLVGZKYnTKqhJQrfn1tOgxEOHBDPyq3iP+gfZSHNgbgIX?=
 =?iso-8859-1?Q?itdLgfcXyA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UPCFxiJNVRTuAKI/y6t/DcyxkIe5Q8sjVKalwFtBfGskZJUenYLQp7EFWLSUjiLxTQESlXbHGE4nti30VL4BbzdChNbj9/CgnNbCT7xT2fG07sAA+ipaCr2d5QaoXEKLs+8grH1I3VubQNGjgSjS1Co+/aKeQ8/x/MSL3BfL1blw4O0uxLJAr9R+i+dbGq2yC/qPkRqu3hXnBdA98jgmmqPZaCsPIl1uLq5NXnw0+1Ge0UJjPQce9GsJ4mG5yDY2OahE8YkvS+FfjoKJIelI9HIimrF6r5tLInGERmNJY0GyZp0XyhCOOnPr3zi7pHLt4HjEfrC8cDHm7onMajNZaQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca5a1df-c4de-4363-c771-08dea0f7b33e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 05:18:05.7266 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jsXwMSlY2hlK2+Zg0YhWjGybS0YBqHYJlybR5gCYHxEi3XznqqyKptrZtb6LO8pR8Q1KRCScBVefbOeNYiz1QAIOuXm9f/ieJaRTsn7cXK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR06MB8534
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
v2=0A=
 1. Remove unused EHCIfstn structure and dead code=0A=
 2. Replace fprintf(stderr, ...) with qemu_log_mask(LOG_GUEST_ERROR)=0A=
 3. Replace DPRINTF debug logs with trace events=0A=
 4. Add functional tests for USB EHCI on AST2600 and AST2700 A1/A2=0A=
 5. Fix review issue=0A=
=0A=
v3:=0A=
 1. Add Migration version test function=0A=
 2. Add EHCI 64-bit buffer pointer fields description in commit log=0A=
=0A=
v4:=0A=
 1. Reorder patches in the series=0A=
 2. Fix EHCI migration issues=0A=
 3. Introduce a common properties macro for both sysbus and PCI=0A=
 4. Drop the descriptor address offset property=0A=
 5. Add ctrldssegment-default property=0A=
 6. Address review comments=0A=
=0A=
Jamin Lin (17):=0A=
  tests/functional/arm/test_aspeed_ast2600_sdk: Add USB EHCI test for=0A=
    AST2600 SDK=0A=
  hw/usb/hcd-ehci: Remove unused EHCIfstn structure and dead code=0A=
  hw/usb/hcd-ehci.h: Fix coding style issues reported by checkpatch=0A=
  hw/usb/hcd-ehci.c: Fix coding style issues reported by checkpatch=0A=
  hw/usb/hcd-ehci.c: Replace fprintf(stderr, ...) with=0A=
    qemu_log_mask(LOG_GUEST_ERROR)=0A=
  hw/usb/hcd-ehci: Replace DPRINTF debug logs with trace events=0A=
  hw/usb/hcd-ehci: Introduce common properties macro for sysbus and pci=0A=
  hw/usb/hcd-ehci: Change descriptor addresses to 64-bit with migration=0A=
    compatibility=0A=
  hw/usb/hcd-ehci: Add property to advertise 64-bit addressing=0A=
    capability=0A=
  hw/usb/hcd-ehci: Implement 64-bit QH descriptor addressing=0A=
  hw/usb/hcd-ehci: Implement 64-bit qTD descriptor addressing=0A=
  hw/usb/hcd-ehci: Implement 64-bit iTD descriptor addressing=0A=
  hw/usb/hcd-ehci: Implement 64-bit siTD descriptor addressing=0A=
  hw/usb/hcd-ehci: Add ctrldssegment-default property=0A=
  hw/arm/aspeed_ast27x0: Set EHCI ctrldssegment-default=0A=
  hw/arm/aspeed_ast27x0: Enable 64-bit EHCI DMA addressing=0A=
  tests/functional/aarch64/test_aspeed_ast2700: Add USB EHCI test for=0A=
    AST2700 A1/A2=0A=
=0A=
 hw/usb/hcd-ehci.h                             |  64 +--=0A=
 hw/arm/aspeed_ast27x0.c                       |   4 +=0A=
 hw/core/machine.c                             |   2 +=0A=
 hw/usb/hcd-ehci-pci.c                         |   2 +-=0A=
 hw/usb/hcd-ehci-sysbus.c                      |   2 +-=0A=
 hw/usb/hcd-ehci.c                             | 382 +++++++++++-------=0A=
 hw/usb/trace-events                           |  25 +-=0A=
 .../aarch64/test_aspeed_ast2700a1.py          |   7 +=0A=
 .../aarch64/test_aspeed_ast2700a2.py          |   7 +=0A=
 .../functional/arm/test_aspeed_ast2600_sdk.py |   7 +=0A=
 10 files changed, 313 insertions(+), 189 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

