Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CD1C44506
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 03:27:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wj7KC-00006M-G8; Sun, 12 Jul 2026 23:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wj7KA-000066-0u; Sun, 12 Jul 2026 23:27:18 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wj7K6-0006V2-NL; Sun, 12 Jul 2026 23:27:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1og70ZFTDY9quKEiqOVRQhs0pcLTLXvgGMQCgcWzWUFmqu45HtS0hkNKKk3lWR/CO7UcgdOCJoxV6d6PQSTv55OZU6FtZmzLm5TYJEPv7Piv1nTup2g46HDOv53nnuMOMwYmyaMaLwQW9RuvNesHGHDXJbt+/T0n+dWw8v2THhhIl37QoWuMmeB1lmWGr80QMu2GkbavNmVdo9xAWmUau8CcLMbfNrcy+sN7UcviAK2UJoF2yGPKv8Zon92EwcQPxBFDLV91A8Bh+5l7l1XQcyiiyQCR6qSE5JEUECkbqm+CVt6EJRtjCzV2+JMmqwJRIDtneTu4d9ZzlY6T+D9eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idLERRnz34H6vjFJ9sRloae+dTz9M67UoZUjF+uZWVo=;
 b=trk0d9JJBnSR7Wvjo3k9LvtKPqSf6jKZQiPmGVDOM1a7rkKasXhPaCvb71WgefKnbGyIZeAcc+0MefkZkSkHnlAJD8Yn/v4I6KkS3bE6QBTe0eM9IVJQ+sfXbGrRLivXLewhKBJZrQZjlULBzvkYbE2uTC1MxWbwFRKtf8HxEZrZpX+Gjn1FnUVAVVqjSCvMRxNObtRWuf2avStdqpitoTdgyLvxe1b3d1S3XCwk07UYlUK5ymJU6aD4k6tbHXBZ5KH7YFbi6t/8Lgb+3s6g+3xJH4c5oFP00VT7AgAo7v+2uY4pKXxKBeJPfPGpPA+DwOGxNpYkBAM9Q6VumL8B+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idLERRnz34H6vjFJ9sRloae+dTz9M67UoZUjF+uZWVo=;
 b=bKwGqIomy+f5s2sD6KsGOA0279Rey2822ZEQGV3V3LQ9QcwcYby7DSUbkFADlR3zSXxMk/VyOkhLi53KEYSk6y7DI6MqpJTgbjqWVqP6yoW4dTyRdi7exYGwLNv+AaYwk2hIgqchIhPtYNEQK0hxGUvNE5SYGHoRMtvhz2NwVaP08B8TtrXYDCs0534P3CtboXcvlpr+1CTjFnC+BrxFw3llQlMZJNbOA2waU3aHpKZ5iXYJeD8Er9LSVVb5k7ZStFXa9GKKGspCQZ/XytC7Gnm1BzP1RyLFbDDEDzCXEF3R38RKPeHXpbTR5R2+4PuupgKSatdaBSXnq582rToMug==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEYPR06MB8221.apcprd06.prod.outlook.com (2603:1096:101:2f1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Mon, 13 Jul
 2026 03:27:06 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 03:27:06 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "peterx@redhat.com" <peterx@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@mailo.com>, Zhao Liu
 <zhao1.liu@intel.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: [PATCH v7 00/10] hw/usb/ehci: Add 64-bit descriptor addressing support
Thread-Topic: [PATCH v7 00/10] hw/usb/ehci: Add 64-bit descriptor addressing
 support
Thread-Index: AQHdEnd6rBxKQKF6yku39aaAj2XShg==
Date: Mon, 13 Jul 2026 03:27:05 +0000
Message-ID: <20260713032704.3583103-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEYPR06MB8221:EE_
x-ms-office365-filtering-correlation-id: 52d55185-9259-41c9-28ba-08dee08e9d36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|7416014|376014|18002099003|38070700021|56012099006|6133799003|921020;
x-microsoft-antispam-message-info: NFbFudRXs0imw27Gu8g0z8kN+q7/D9wLtoVl5fXuEdwYnmqi6gdwnwDoAZlbVZWk37KGMPbOkVAn+ujecqidOlBqN3tLzlZmof1zNYEaLknaI3pCIK1cIi2n39GCGcciishJMOrY4z4exSW/AfHzXrmr776wj8f5YliEFPgso4Wp5SFOthnBFCD//6RclyUWmISLp73LDBxjFB8N1dr9J+vLHFyp89a8ZC+dta0foD9XM4k6QyCgdaN2rEHgkZLtw8viRQ17LI7RcgqEvW1WMQz+k96sRFam+of4snLpitWVH8KA4sCeuWjP8I3Cx/1IzOrD9gas089t6gGWlnnzHITXjkACksAV5ePGua51DVirV1gwDIi4w2VpPuauV6KChAWhbQEDZBBv8N4BcwnDRzIgy6d7rSSDPrulxeOXyphwH/K7rGBf8MzDHtQZ9jUc/DxeKC9/uRSDBnJ2Xa4Y4D4A1klNx8VgNEZLhj7Lo/3x3zBmkUo3IMNzUWD1GlXftPnQUidrktCZLcCJWS3r7H/fmU1yVf14ec706M1LOSm2NtwIWF3aSkjHBjKDNZd4TXvoveX78AwnxCovCTl8xtmNwKrFaRs5eaZpIworaviD9V6UgbOMnJwNcLh9a980VVS6bkDy/50jWY4srZ3HcAFxVSuY9N/1D5vjY0yvtKsBd3o94MsQSYAKoZ/tCkU7Jo1QoKM48044gKJ1l4B/K2qWOw+T4aCTI6HWnykXsFJbyNL/IztmNPevU59IUtLi
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(18002099003)(38070700021)(56012099006)(6133799003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?l8+hKj9Txy6Bv8ZKaaBrO4fP/ANW0bCf9/Eizp79jYu6BjCrQ3SsK5JPLL?=
 =?iso-8859-1?Q?BSjxadIk0HG6xAugDKOYclQp9fS7IIIJdEt1Y3fBf9jPHwxJCQH2m7NMZS?=
 =?iso-8859-1?Q?nPMEobRFC6Zqr6hrM+XzPw62kpk7P4mz7W0LIT+/IRwlr6UEOSIuxrQG+O?=
 =?iso-8859-1?Q?pxTprUulVa6cjlr3wXWE1RFaLXYZ/J2dEXwcWINUhZBHIzFaVreUYP1cks?=
 =?iso-8859-1?Q?DZpTtuW73Ucm9wWl4DE5ir195mNtWcsl+/4QB5Il+QMenOOklLQmF2rD8W?=
 =?iso-8859-1?Q?DVDpT87DHVXJnTeKzSPkZCVrJNc/9oil9qmo0iKCrBPvo2Q5V1KxJnelnX?=
 =?iso-8859-1?Q?h9FvEwbov8COdBm+0fSS15mTznp1UkIskPVcZxp+PdkUnyH+kmnDTY1LjA?=
 =?iso-8859-1?Q?y0WQ0TiIEpMC4MKj0W0i5P7pF9GNdudjOUDD0/4SA1LQBpjCO7DvjtxLXP?=
 =?iso-8859-1?Q?NgjHjiShA7VKIaCxQD8s3H8xt9IlhCfV8Njv2Ues8IzHSmeofrG1P6ghvk?=
 =?iso-8859-1?Q?4pVodJzfjEoaZ5PKG+XHK9SIBVIQjmFT+AOwPOIjDNvMQECqbgt6n2Y9e5?=
 =?iso-8859-1?Q?ZaRn5wyVMUa1rTUl85ZcG7r42JoGa2rTndvzaYuvkQslzP3u6Qa3MtNmy6?=
 =?iso-8859-1?Q?BNvcIFzr1f3XHihJE3pvdR1YZrmBRfo2TGXSSLZyX6klADCDmXF/YPKBJw?=
 =?iso-8859-1?Q?xaJhIpAJOxHpqk4OEmRb9KGqqOPyHeukjHjUML8h/kYfHXJPY17xQdgU7A?=
 =?iso-8859-1?Q?Npkia1iFT8VEkm8tyZAe6FNhF7nNtb2JXTeZATIJcO1lyDn2wmMLhCSj2A?=
 =?iso-8859-1?Q?PtovsjJtjEaWS5XycbtFDJBb8xdUyXfukpjvNHR6HxSLa+sk+xo0lpXffb?=
 =?iso-8859-1?Q?FGN0la32yjePFx+q4hA3t5cmFApqaA4BqYvh8O9KynVb4K+goVhk1X3NgY?=
 =?iso-8859-1?Q?GM1lNN9TKxPmFtecU3zX5GpU1VnFf/IuJK+OL+GtVOH+EGKiNQGtZDJKAc?=
 =?iso-8859-1?Q?mVmZsKUfluMBrF92umy4XZNqvWyWZOpQgmQ1M9/1mHfzAUHfryp4j6GfcZ?=
 =?iso-8859-1?Q?6nkq1c+PMzjJzzC2uryaX72tyz3cTDe4hf6l8RUtY94Xt0xpYcugwZDSNW?=
 =?iso-8859-1?Q?osF29XYXtWwhp7QNN2LnPVOf7D7/D8Ml4sSLdYx6w/Cyc2PdEGR1XG9QNf?=
 =?iso-8859-1?Q?8v4VNXYu6vRxP66xTc1q2fv5Ggu23RgzztQPD7M8lBPvwTBg4KdeTny1CV?=
 =?iso-8859-1?Q?BEKI0TZYbKHsWc4spzjUuimCVvr+Ja2Z0OTxwJ/KGu3WeRrwbbeKrLSAex?=
 =?iso-8859-1?Q?kPDsyxLZ/zSsUuXjjUmRV5yb/UXufeB94xFhQnwi6en5vgUUnZoKXWr4rj?=
 =?iso-8859-1?Q?XFXz8GfBmQHZl46jonIog9f38YobSDROV2wAc2pWJoysugskBJ03L9HcTd?=
 =?iso-8859-1?Q?3eD8Ph3bG/wuB0xYdto8iMqXZLl/tY5mt8tLnujxbSEdSB+UF35ZgyICQ0?=
 =?iso-8859-1?Q?yJXOKsLCagwV0GoujMyg3tykyWp6lAntlbWBvvREePHUWr+ozQlBlNa19H?=
 =?iso-8859-1?Q?WOmxqnYCB0bJBxMhhEVG/TuOoEM4lMPWSAuqUhH7mfySZJzOzZTZOJqitD?=
 =?iso-8859-1?Q?eukl6XV3YXBU1A7F7YhR8jY1kIoAnIemszevqJTj52CqWU0ZtiCBkZVvEb?=
 =?iso-8859-1?Q?veTftXlbq6TgS6y8oRnv4b5ZC5KocyKts7+bjfW0J+WQXGekcFAYDfWwFJ?=
 =?iso-8859-1?Q?BImkd7qwRxaiO2xxc4fm+GQF/VBQDPDumsurKgdNSELxD9o6LMR1q2gRF8?=
 =?iso-8859-1?Q?BkNyKYKz1g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: moYvQUl9GPNsm6lYs41RT0DOy48X9LZNfqqQC+7+q+crQfNt1igrUwCgyd+08eKJPUP4FY00o5cbWn09LEAi1TRl4lYkV1qbn0LvlhfElwPpW4/jbjOOxvinKSIamOrDYR1RvKFYSsYFoAWVvbBiWn4SmrKW4xwTcPDh3G9imiT5FINmqIl+TYNPiBy+fkgLsKw/wWCzJRWaYyVXQ32pR1jEjsdlHBRszOnwSIMeBf7kpLJAEI/Hsl6YyNUZc5ScTUhOVEFE8nEKC/816/MDdu4FhgIxp70PfmF6N/NjjqqtgDwmcGMfVmyNPLNci2JUHlBDJDJYl/MEOryfdJKfIw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d55185-9259-41c9-28ba-08dee08e9d36
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 03:27:06.0135 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WUB5DVQpZ2Vw7Qz3IAkRRxsbIWQLwx7Kv/SmJoQLcUj5RTMj6oTBSoylgMwU6ozinIUlyxec0bXpf015zSjhFCviXyRIHLnSoRJRN2ifO2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB8221
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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
Add a ctrldssegment-default property so platforms can provide a=0A=
descriptor address offset when constructing descriptor addresses.=0A=
This allows systems where DRAM resides above 4GB to access EHCI=0A=
descriptors correctly.=0A=
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
v5:=0A=
 1. Add 11.0 machine compatibility properties=0A=
=0A=
v6:=0A=
 1. Update reviewer suggested improvements.=0A=
  =0A=
v7:=0A=
  1. Limit descriptor DMA accesses to the specification-defined=0A=
     descriptor size when 64-bit addressing is not advertised=0A=
  2. Read and write the extended high buffer pointer fields only=0A=
     when 64-bit addressing capability is enabled=0A=
  3. Zero descriptor structures before partial DMA reads to avoid=0A=
     stale high-address values in 32-bit mode=0A=
=0A=
Jamin Lin (10):=0A=
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
 hw/usb/hcd-ehci.h                             |  42 +++-=0A=
 hw/arm/aspeed_ast27x0.c                       |   5 +=0A=
 hw/core/machine.c                             |   2 +=0A=
 hw/usb/hcd-ehci.c                             | 214 +++++++++++++-----=0A=
 hw/usb/trace-events                           |  26 +--=0A=
 .../aarch64/test_aspeed_ast2700a1.py          |   7 +=0A=
 .../aarch64/test_aspeed_ast2700a2.py          |   7 +=0A=
 7 files changed, 231 insertions(+), 72 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

