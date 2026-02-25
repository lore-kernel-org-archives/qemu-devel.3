Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD52F5543A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 02:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv4OO-0003fQ-AP; Tue, 24 Feb 2026 21:12:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4OH-0003Vp-La; Tue, 24 Feb 2026 21:12:41 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4OG-0000T6-CC; Tue, 24 Feb 2026 21:12:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TjM3CHbBs32JP0URERwhiVyRekd8u+VWAH382ylQxxFzei5rsUnYoCTqsB60TFeOGdWK5vjZPqQfYhDlU35b9puWwOPe3K5jBuft5JJ2RVOAAn30K56mspCq23NV8OFYllBQ/LSaALKLVcXADhrwh6wdDwMshZQ5ZptOYR02nPWmQ2nxvsoUIRh2lEfgJpIhO8JtvLKxaz/Yq1pac5ojyiMNEOfMKCp8DfA89A7sruy6DM17DYfuo4ms5+uo3ZC88bASpobUdcgjlRLofwE+dz/pUOSMbdo2GfkYEL1fvsKXrEfPqK66SY1tk4tkvgTIGjJROV+Zn+L2WwEgVoabZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqnQ8AIJ+wAsb2dwMNcPSHGBFXE01d27V9qBZn9sxzA=;
 b=tcfFVsqKefiCCCTSxkp1jk1bCHV294dtQNKiQsfiC+DDsX9yBv5IznG0kZx3RW0Q0p6frKqmJS2mFft/P6ss/ewRnZIW/W1/4VsWcK2BJSQ5muUYdA6i4ZX+KPZTK5HzCjRJjOq9Bv7ZZqAkQaFp+yEARJefsjCPvZEIXkEhcTUFSKE4kBbHUXqX6B6tsZnUa1npY6mLp2UdGSA/lM92DKmoaq6hoJXv9jaguQTt/t2pEIi/JZ57uhOLfKX1ZNRYiRg4pGhTF628mwVJ+qv3kQlNlN9+DKkRg2zI8xwJ5m0I5aXeuaBkjBXt6BTTyDWgZvEp7g6dpVPFUya5njgrqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqnQ8AIJ+wAsb2dwMNcPSHGBFXE01d27V9qBZn9sxzA=;
 b=ifYDmwkOFMUuisIyhMdBT+G0DA01xvM13OhMOh3CV1/Ek8BYgrmLnfQ3qe8RMIxEPSSL7ErppT5ouDc0cjX009dcdP2Iy41hGJYUypR2v3AEjMXxra60L3+7zQdFkdyv3F1vYmAsziU4U5+wcjNVqPguJEbVO8C9Gj7cNyyaKGiSynZiQYFQJHpVkiJ+4WN7M2Dyuksxu0Z805CI3g0r1z8dQ3P5Ci7Cn0dgJuoGo5ihOZ+E3r5HxMgj6KeZYHKB1i5FfAgts0TwLSuWnCfkZNS24hwGwjNRJ3Fu8uIRYIlzueJmiGsl6lh/sX6yJsIT26KwKmZPvx3PvsZPhPx9yg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5118.apcprd06.prod.outlook.com (2603:1096:101:38::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 02:12:35 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 02:12:35 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>
Subject: [PATCH v7 19/22] hw/arm/aspeed: Build with I3C_DEVICES
Thread-Topic: [PATCH v7 19/22] hw/arm/aspeed: Build with I3C_DEVICES
Thread-Index: AQHcpfw0VBVge1mVO0ejTKhiurQD+Q==
Date: Wed, 25 Feb 2026 02:12:34 +0000
Message-ID: <20260225021158.1586584-20-jamin_lin@aspeedtech.com>
References: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5118:EE_
x-ms-office365-filtering-correlation-id: d10c2c26-7cbd-4fc5-0da9-08de74135739
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?lMmV4JmgxBYYQNU22QhYdi79AzBkkoMQZvRfSCDjICLvgZDEW0LBdV8S+W?=
 =?iso-8859-1?Q?1yHs3CLlz7ZemIBxaLmf7zhTgbWBhz7164qu9gK1WrTa4IUNnoNmZo6eRh?=
 =?iso-8859-1?Q?V+dwrrKtsZz3ODW/waHSE1UrRoKlbr7aRgC8eFn0NfXQVFYedOGg1XNCQU?=
 =?iso-8859-1?Q?qlftKSMPRm/ugV+PiA9enh4ox2guDXCi2VKUzOD+83EcKglBPBf9pcKBA3?=
 =?iso-8859-1?Q?8ktalWWPsm/ZQzJjYNas4xxNmACGAb2gS1kKYb/tVujSqod7Z1W189IeuW?=
 =?iso-8859-1?Q?phiGQBFmCK+67mFtEJUc4IzAIBZiyRygdS52OQ3KPCYQ01h4Rm+nT1rS++?=
 =?iso-8859-1?Q?ObnpA1tlwwx2fxiXv390cGgoof4QRo4MyprPLVh17kZXJUtVPPiA6///o/?=
 =?iso-8859-1?Q?QTAommFkijNVqtuPqUS1b7NT/FPWq/nr72Q7u54sYvMr88G6sxLkb4lIs4?=
 =?iso-8859-1?Q?HRjwMXOcf1etush2ePbF362mBB4EN0533/B3ZuYJIdoF2KPKcAwyIjr0AU?=
 =?iso-8859-1?Q?pIxHAwHZV5cP+9CLcBOVOcbzur7jHVY3DsddF5MGiuXj4x/PI+43fQHsMv?=
 =?iso-8859-1?Q?W2ynyeU3pxt2ENs8miSxCIrr1rYHAOb9KDtskUxkCrqErz7EoT3IXtZYJf?=
 =?iso-8859-1?Q?2eFZoqNQeq+THU1JCHSeKPsLEMa2UmhKwVit+fHRPYfkQv+i9KpklB7vOC?=
 =?iso-8859-1?Q?uF+N5I42oQEXmpjz7vORozMJB1I2KEGoslxpV3/ynPMugMxozJ3Cq+we5d?=
 =?iso-8859-1?Q?tkvAy/dIk9a/mW+gNJIoe0zyMoojghbkZs9H8lSsXQSdEUIJK0ygPrFkNI?=
 =?iso-8859-1?Q?Mjc7nkxUCXOHoE0f9+8BC5yT2uD5Keba2D3QpIoeWalP5t217ydOMYUVC6?=
 =?iso-8859-1?Q?VU2dqE3cCyyLKSuIqIPd5PlPAVrTPvi0Du/dR9m6vk/xIIKlUUqOZxL4V3?=
 =?iso-8859-1?Q?9xO1TP3rnZMDRCY+eOlY6VMME2iU8z+jKGc/zhJtikQe7QKsqUAxe3hNMg?=
 =?iso-8859-1?Q?LkPe9bLnLIdAFgkTe32AOaZUSYlaWKsiXYzKQaWdS//MhMYuyziOT6giCK?=
 =?iso-8859-1?Q?8knnNMorH79AliCudI53qTyaMRCA/22XxcZsfPudh/HqMjNGplC1EsarfV?=
 =?iso-8859-1?Q?WyNBsZwGIaDuhKHsWm0h8TI/QrVWj59q3A4s6Vk1VM80kYn3u0C3vBFQgd?=
 =?iso-8859-1?Q?4dbLicRic7WAE9FnBp88XEivThxvLIBT1n9C4m34H6QeQguniqdGlDl4P0?=
 =?iso-8859-1?Q?/nfrAXfn4sfd5V/RwS0Xuh/hG4cq0w1wmGVQbmqNm3elOVt30fUsmls7GI?=
 =?iso-8859-1?Q?4WX9YaMmkQ0/TD2XUZjO+Sp0Hm3mgnAXXYtpcC5IJQgVoAC1uCe3PTFnH1?=
 =?iso-8859-1?Q?yqBfBs1UeV3/93GQig6qXjmiPw5NmjlNuatHqP4Wg7zOP1ASioyXI/dKxc?=
 =?iso-8859-1?Q?25tUyj8ub6t/Zq9E1Fr5AMYB83/HEbZfvEjS7m/g564C8gj62ugrr5Dvnb?=
 =?iso-8859-1?Q?p0JZ2RNQo14sbcEgDiL/XuC2s9Q6AhK9mI/dS8Fk+lA7XhFoSLfrvSoUMm?=
 =?iso-8859-1?Q?r9NFZHOUXqPQ0QeOfxnNAqxCCxG/AWTSebSBPZAQV2aA3sJZdBl4cTkExd?=
 =?iso-8859-1?Q?C+H/WwH5p0vNunyR0RZMwWnxvnaRCT1nrPGL4JeAuZbgpNjyNqWecoar4H?=
 =?iso-8859-1?Q?+kRuFvH7b9Ooyfb6nHi1RcH457f1q+EEHj/bn9lz?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jKPfj+D13KSWjl7uONMIp7SP8R6Ct4DCEBK4Km/+omFPPeZtlxF6n8C7Vn?=
 =?iso-8859-1?Q?jN04U0ZrnLamhrptKhjfLWrSuFa4roA13ADcjw6XD2H5sZuAs4ZP6eCnJL?=
 =?iso-8859-1?Q?CFGSrYGXPrsrsR8C8ju8rACwVl1oVNMg/+qkl51+rqGlCtIScoQQeuWN/6?=
 =?iso-8859-1?Q?qDl0N/836rTrNsIWS/iZsPfPUnpimcF64qUh8CTGonKsp7f47NVVIfqlPf?=
 =?iso-8859-1?Q?McUZvJogoqBKVPwq8+m71cHTjg0Adl/2K/J/6+QDJMSeDcgk/4GW+VUAmE?=
 =?iso-8859-1?Q?83O0FC4ag/G1hcOXW2GcdqBtV3MUFHtMX06DvN9z+iz9zDCR1yUQYFuWz2?=
 =?iso-8859-1?Q?76JJeYtN7PiBpKXRoJypyku0AYt3IrjJq8LhBQzmvb+kbjv0wVFGyJOxVc?=
 =?iso-8859-1?Q?U5rSyQE11Vw6lfG2vgvKvyaw6+At+NaAsFk3LSmIDISQUqqRFbCvbeMIsr?=
 =?iso-8859-1?Q?Vc9B3wmcBvjvaWV7UxN8+FE+/hDle9tflFP4cT9VZqIoliZ0AEiHr2Ufgd?=
 =?iso-8859-1?Q?XIJEoQSyaKk/ppr84XTj+IgoptupvSQ0LAYgujPds3jVmxAroZtMUrNYyQ?=
 =?iso-8859-1?Q?RHKD18u5YqAXcPr5d2U6pS/X4Xmr1nDieriF78Cf6gkoVhi44lx68wR8BP?=
 =?iso-8859-1?Q?apUKkMA/bVwUmoi0H2rLTXz8BtgY48cw2SeY7VJjyWzcmhyrqOiXI1o0mP?=
 =?iso-8859-1?Q?XCGcxI/QWPn6Xp2FW1QsMqUtun/Lf0nfbaztQaDWLqZO+INDmdwoGQXLU2?=
 =?iso-8859-1?Q?3eqHQbtoq+i95O0bg3DpKBqNTjMSLDTxd0VnDwQqVqCRK+WkuYhREDLZgM?=
 =?iso-8859-1?Q?ECx+J/+RXiCwDVHddrKIO2Xasly6SuAAi/VHj3m9iN16VbVIzIfKM7ygeL?=
 =?iso-8859-1?Q?+dxZpgMcq46lXCUqvlNtaC/HfcRpQzKEBYMPXrRPAN7usl45n/ha5Y7KZk?=
 =?iso-8859-1?Q?frclsQ3o3POVbJy/sU6hxbI0jG4ULl7G/sLMzjX8B3zVDizokJB/zgcuQp?=
 =?iso-8859-1?Q?+R1aCBUHMmfa2RzdQLx34XTlA0/44nrf/A81O3ahIHM7a56euoB+QfbQdj?=
 =?iso-8859-1?Q?D3VEM/kro65bBS21Tx3WhEuEzr4kblFc+xdPJpkB97U6RvmtXJqJZY186C?=
 =?iso-8859-1?Q?0p43BKmkUcBKfPpc+xeTB++x+wYZAf8u3kNNvq4Y7rTmEklqBTLPkFXiGT?=
 =?iso-8859-1?Q?oX6ndqnZ0igv9Gjxc6h/EU8nGA+RuU9X9kAjOsDGGZSAWIin01O+k4SUTz?=
 =?iso-8859-1?Q?dO94HP2b3EmUwzzdYG7xInywyZdUdaGp7J6td25AZyMG8ZqnQUz90J1Qu8?=
 =?iso-8859-1?Q?TbBSMuPzC6b9G8isBQjFhFGO/X436ZeWE5JJMAfIVnwHQinevHQfMGeeuT?=
 =?iso-8859-1?Q?YH3A1oOglg2RMPAGIFnF10ogSiG7v1XRxCMBPRj6LVgw81E8fl8Pj4g1Nf?=
 =?iso-8859-1?Q?GqqmBvOunyfbKIBHEI1lN1EAuFk0GV/A7yEaiIN7L+b0ABZcGSkL4desJG?=
 =?iso-8859-1?Q?WkRLk5sgNTGLhOwoXoaBp5a792KRddTFeAZAhDmexyHTJJZhKVhSgx5ICi?=
 =?iso-8859-1?Q?iIoYvlSG+L61f58JOitfDdKi8GYgMof/oSjGtC6ntf4UAyqoUyzqa/OoGS?=
 =?iso-8859-1?Q?S4atwg0AEIgrLC7JhDa29gyGPnx2H8+pQikyxa7Ahj4FJOdeJ2YXrCBAGf?=
 =?iso-8859-1?Q?h6SRxH9h5AmgDvl/vhgEQYkQRx1IOWM71+GxMUV71pC1UbGRyOjnBPLtN7?=
 =?iso-8859-1?Q?MuE7Ags70leSH7vAlYTSpvzzjMPOFkGKlMmPEBk5YUlkkW7cCr4Ob0EVvG?=
 =?iso-8859-1?Q?Q9lNovazkw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d10c2c26-7cbd-4fc5-0da9-08de74135739
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 02:12:34.8779 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VLi16QCPZzbeJeA/NUGR83kncb+tVLvmJ5tI1pkzXhSCiz53bpxumO3cEwUELtRBNOP0j6n3fdCuJIg5Oh+Qhm3HXwLpZNKGLQonvwrsT0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5118
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
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

Allows us to attach the mock I3C target=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/Kconfig | 1 +=0A=
 1 file changed, 1 insertion(+)=0A=
=0A=
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig=0A=
index d545ecd712..3396a32fd7 100644=0A=
--- a/hw/arm/Kconfig=0A=
+++ b/hw/arm/Kconfig=0A=
@@ -547,6 +547,7 @@ config ASPEED_SOC=0A=
     select I2C=0A=
     select I3C=0A=
     select DW_I3C=0A=
+    select I3C_DEVICES=0A=
     select DPS310=0A=
     select PCA9552=0A=
     select PCA9554=0A=
-- =0A=
2.43.0=0A=

