Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 711DDCD37B5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 09:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMN8t-0002R1-Mi; Mon, 11 May 2026 05:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wMN7r-0001wz-73; Mon, 11 May 2026 05:40:35 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wMN7k-0001RA-5U; Mon, 11 May 2026 05:40:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2fsAfohkeNnKI2uJoW+WOkXlR7ykcKzIlT4VsorQ++AfaSusjOXezEksakD0wlyYk4LC3+0JZON75Kr7WZ0oWn7QWTghm+Z/HQyhmzk1abafHID/Pa5JMNFK3OxhdGQs1WnA+WUDSFjHlh508R+HARjIYYZKINVhfklX26VFEbRAG8mHW9hTKhIXhxZlyHnViYmdDYyb9kgwPcv36dyYnTDO1DCxz+Th7R2+SEyDtS4yVswEny61Dj4RkaGE4FFFhEEqJbPYvl2O9yLLdFQg+xv2kHVWlgXuMCj6soCPiNNzOimo4TIiWPI5KVbwf8kYyNrywsoxWhnrPPWP8JqDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddK7Rom0AYFdxbB8gCajhiYQui/iJNt6SZbcvbfdXOU=;
 b=Kxq+LJ4cXSB+dmWLBHNcXdy1vIp/ZWhvTKDGeC0hzj/qSgWibKTSuMaSBkfKqTalX24ktloz7FNzoR4mhbrH1CIURzsDQYl7G3efpeborPMiN5pIIDsbOideud8B12VN3YApr/qr7R53kq9JLQfaPfKSp06TmJuLQ4k2f9qNtkjThnCgpQyo/pIPrrpnptOsFSv4mtZstaYc0w9oht4SbNWSmV90+AunrfhQcbC95T7sxuV8j+sPzyfwVhQeFzolIQh30OQWHkE2pALZVH3gGMdyC9tH5M224D5siwf6ly5Ukf1TNuuGRtnpTN6IFKMVtxkHyXlavx+AdslgGoK2kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddK7Rom0AYFdxbB8gCajhiYQui/iJNt6SZbcvbfdXOU=;
 b=H+6zozvtpBHjF/r0xrvuzwjU65BHhjMUErMGmvhm8e9oPHLgyEMFA+vzN5gayIrHMqvzNEVmU8GKTj21I4V1MoxBz0Bz8E1AwU56LxQFOXMsPAKF9ktFizFmnGhZhrQkQyBvwkiU60c0vpakGB9gbJd4t7EqEV3Bpj8FUEu8EzIsTs4fcc2zv1WlKgpFQh5QLat7iVEqxHwmiNqHS4Hueqg6PA419mU1wgYROVP1k0lFgqRUfGFKy8hbXspMBv+d6IKs//64TtHXj9Zma5ccHw5y+w9GdCRD+1ta3YktUKeeU4ujHjdbk0C+rltQ7UGEQFljUmfZN2i7o3zhW6nHsA==
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com (2603:10a6:102:412::6)
 by DB5PR09MB8695.eurprd09.prod.outlook.com (2603:10a6:10:64a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Mon, 11 May
 2026 08:38:27 +0000
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442]) by PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 08:38:27 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: [PATCH v9 1/7] target/riscv: Define MSTATUS_SBE and MSTATUS_MBE bit
 masks
Thread-Topic: [PATCH v9 1/7] target/riscv: Define MSTATUS_SBE and MSTATUS_MBE
 bit masks
Thread-Index: AQHc4SGJewGFqI/iUEy4/7BmFq9dSg==
Date: Mon, 11 May 2026 08:38:27 +0000
Message-ID: <20260511083819.206216-2-djordje.todorovic@htecgroup.com>
References: <20260511083819.206216-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260511083819.206216-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA2PR09MB7634:EE_|DB5PR09MB8695:EE_
x-ms-office365-filtering-correlation-id: 7cf7922f-a136-42f3-8e6f-08deaf38ac28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: P1MZE8REPD2LVM+9h7joj7kjMKhJwtUCaFUcz1gXyD5kSjJ4t+fO55x06YIFgeOeG1Xj9KzdEt3MphwLIIeYZ9sWmbIK/7gwAE+dP/QQUo/wPmjOvP9In67QlQWh5YQG2vowXojx77g4rdjro8/hxcMAJk13pE0OdqxM4hPxOHF/OCgY8T+h9ie5T0TMDaaCr7OLcuG0jADizF4UBdggEWVYJjE0Q/2D4688XH7nSpH+xmT9YSQOL09i5mGDayMlf0BNfTC56VrD5VgplXs8Mnna0Cg4aDdtmSOqsbfbBOB9C41I7xjh4eXkHCgwl3BwfvAW3arueMop1QwjZRDn1z17JCypcW+Dumf4vPV5xyjOOdKvnPLWRf31l0isIQbQ69XzgmpGDn+h7/GWa83xT6//KjxgsWbNZn1qEsDvp3vH0uQ3xCmSFqXyUFCOI8KFlIUjehtp7y1xkCquQzTUoZyCSLfg0cN6qhXJ8HgzAQW/iKz4sQ/wNVGjbontJvlKhqqxQe5xcTE/EzXTxkOTyaF2UUapx21zuD5ZgJPnb0wk/imMKc9h3lRk+aZHq6HvBD5bx4CMIlvDAaUXtafzUgP9BVrh6P9l7U1FfOjUFbwRxP3m20DYj0aR3oOvW8zPfNNmSBVVfTpdLhOwVOWgm/rEoFzdZwHRk4h8QbcToiqkOe/EIzXrt745l5R12TuUYNGzvezpW4MLML/96o7TcBaoMmqjZmGBuKbym+VVeW22a3VeIR/hHjuXawRfsrnA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA2PR09MB7634.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVBzekcwaVQ4SkhPdkFOYkRPeUNUaUtCckI4WUdCY1FQZnREVDdIZ3pPUUN4?=
 =?utf-8?B?MXI5RzJXc1NhblljYXJFREFCYk50bHdGcUdiSVZHN3g2UzlIZUFTSk1CY29o?=
 =?utf-8?B?Vzh0V1hscU1OVHlra1NmUW52aWcvN2o2OEhtc0srelQrZExSazIxdzYyNUIr?=
 =?utf-8?B?bG9aUTQ4WmR6NHcrMUJCQ2Q3T2Y1ZWZlNU5TTWZheVZFRDZvVmhUQ3RKMG5W?=
 =?utf-8?B?TDBnV3l6Q1Vwa25qVlRmU1MyVEI1RDR1ZndOQ0lZckttazEzeVE0Q1UzT1U0?=
 =?utf-8?B?elFuWmZVa053M01FcGg4aDBlZlg2a1pvZnEvaHh0OTl2VGlyOUtSSzF3RytI?=
 =?utf-8?B?K0krL2RsR2ZWc2JwaytoN1BldU1ZeWtPbGtzU09kdW5CUlBNK2I3aWphd2JV?=
 =?utf-8?B?aXE4SklmazNta2htbitMTEdYam5LaVgySDZyZ1ovSzU0Z0VPM2lCRWZZM0VZ?=
 =?utf-8?B?TkdGajdIZHNnR01RZU8waXpKWm1XSlpFVkswQlkxb1pVTzdCLzVoOUUzeTlP?=
 =?utf-8?B?WjVybnhVNXhYTDBiSU1QUFlZT2x5U3ZkVUJ4ZmF4Wm9aVnFpR3graXRLcHVK?=
 =?utf-8?B?NU1TeS83TW5jUXFQWTBjZi9QQVlta1VjRGNsbndmTjBxNGNwTVo2a1RiSnh1?=
 =?utf-8?B?a0pYZXpBeGZEeStxZi9WcjVEb2M3c3Q2NkthcjlZOXA4RTVyb0JWd0dyUXhi?=
 =?utf-8?B?czNFNGJaVTlydFl4eXJPSC9LUk12blpXSFJQSFdhSGNzK25iM1VMYjZsWHc3?=
 =?utf-8?B?a1RLa1hIU3hxV2tWa3duQ05Ka1RaY2VlV2tZWnloaXdDV3V1UFN1Yk4vYnor?=
 =?utf-8?B?ZmUrOCtYSjRBZDZhZHVCUUJNcDJFMHBQTHYyR0NwTVF6MXRaZ3ZBOUNHR3ZH?=
 =?utf-8?B?QkNjcEFVRXdSUG1vczhhajQyQjFmV0lHRkE5TERVMnpaQ0ZBN0tubUhqdUxt?=
 =?utf-8?B?TVIxVms0ZzNTeTlwNGZGdzJ1Rnk0YTUrKzBUS2ZlTTg5ZmNzZFdoVlR2RCtQ?=
 =?utf-8?B?akVHUkZzekpoTUxmVXNRY0FCTUdXTStKOVdJaDdyNG11YUxvREJHQ1EyQXo5?=
 =?utf-8?B?N0E3b29mVG5meTNUYXFVdUlhdFB1SWl0SDRweUtWVFZLNUpueENxS3J2M3Bm?=
 =?utf-8?B?dC83TjR6M05UeXRhKzdkQjgzZCs1OUlCczhic2hWdEdWOUEwbVIrZVE4dUlj?=
 =?utf-8?B?V3R6V2ZTMnhCYXREOWwyOVB5L0ExTTkwZ3RjSmowZ1lLZFR0YkxMbkdmUzdU?=
 =?utf-8?B?bnJ5RzR1SGZ0My9UUVRLYkRhb29KMzhLWE05T2Fsa2hYQ3o3aG8rNWdCYlc1?=
 =?utf-8?B?bm1aY3pUYml5b2k5VkR6NmRYUkhCcHFQaDMrbnhjN3JFNXMrV1VBNmNPU0l0?=
 =?utf-8?B?VVRBVDJQaUxaWVIyMGtMSDZ0V0pmOGRrM2N5NW5lTjFDSlZHY010NHhaMUFo?=
 =?utf-8?B?ZWQ0VzJ3MFBsSWE3TlIzMVoxZmJiS01aTFF5WUZQUnNvdFZySkVBT0YzSkhF?=
 =?utf-8?B?cnpaem81Tkp1b25mK2hGNzZJMjlPNU9sYVVsOWUvcER5ZmQ0b3JuVTgrdTVE?=
 =?utf-8?B?bGdTWFd2RUxMRU1ScFBObTdRRncwVGVOdy9MR3RsMXNjVENzRDFFcGZWK29K?=
 =?utf-8?B?aVZUVHlnVlQ0V2hkdkVIOTRrQ2kzVG9uWGRrMHdwd0lzZHo2UHBVbExZTUxE?=
 =?utf-8?B?S3dHR3ZrMFM5MUN4TGM2SXQ1SXlhT3dud283bWZVblIwODJlMDZqQytqODZB?=
 =?utf-8?B?T3BCTmNiS092N29jdzBRVmlkSSt2OFpaU3ZzZkFIN1kxci9KWS82M0tVOG9p?=
 =?utf-8?B?VmlzT2VwUFlWSHhCM3BZYkM3OGVBckZkTGhmcGE4eWpwZDYwbS9uNDRRZGpT?=
 =?utf-8?B?KzNsWGt5alNYQm8rWmxqc0lFdjdwQ2htQU1aVGh5ZUkrMXlCWVltYTd3eHpS?=
 =?utf-8?B?N2diQm5yQVBPWTVSeFJBcVlSV1JYYVRPZVR0QWp2WkloVUkxSDE0aHJ3SmRw?=
 =?utf-8?B?Tm9iWG00ZldxVzZEUkFjYjVYa2owTy9GMHp5UlQ3aU5VcXYrWk1VWlplOHBL?=
 =?utf-8?B?RVlTeURyOUZpRXRuQlFPMzdOb2lYNXlFRFRTRXd2K1VteEJEZkxsL09rdVNX?=
 =?utf-8?B?YTl0V01SbG1XcXFreTlrSjN2M25HRkRZODdSdTlTWWZtbG9wTjRYUElLdjVE?=
 =?utf-8?B?OG03QmxOWTlnMExTOEYrQ3pDNjVQUjBOSTc4S2VYTG1jTW5GNEIrRHdJZEpG?=
 =?utf-8?B?NFQ1amlOWlV3RkUyU3FSbFZIQTRqYkhnbGlOV1Z2V00ydjZMS1ozcnp4MFA3?=
 =?utf-8?B?NC9aclZFS1N4ZW52UzFpNWN1Y3VqWUx0K3g5L2JxYUZadGpRRHdNZkZyOEk3?=
 =?utf-8?Q?3inh9gKcnOYfrwGntoNaEz51am5r6OnQns9pn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <35B1A3E8CDE2764A8C7C878C7C8690EE@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA2PR09MB7634.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf7922f-a136-42f3-8e6f-08deaf38ac28
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 08:38:27.4521 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gP/1x/IxOJRplhzILhCVlQdlQJZ410lCzTEAb0qmZeFGRJcnq5LlXhVM4QC/C5fXR9+KxUsmwlpaorGExarTFsugovj7KCOu+ViJOT9xJ4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR09MB8695
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
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

QWRkIHRoZSBSSVNDLVYgcHJpdmlsZWdlZCBJU0EgZGVmaW5lZCBiaXQgcG9zaXRpb25zIGZvciB0
aGUgU3VwZXJ2aXNvcg0KQmlnLUVuZGlhbiAoU0JFLCBiaXQgMzYpIGFuZCBNYWNoaW5lIEJpZy1F
bmRpYW4gKE1CRSwgYml0IDM3KSBmaWVsZHMNCmluIHRoZSBtc3RhdHVzIHJlZ2lzdGVyLiBUaGVz
ZSBhcmUgdXNlZCBhbG9uZ3NpZGUgdGhlIGV4aXN0aW5nDQpNU1RBVFVTX1VCRSAoYml0IDYpIHRv
IGNvbnRyb2wgZGF0YSBlbmRpYW5uZXNzIGF0IGVhY2ggcHJpdmlsZWdlIGxldmVsLg0KDQpUaGUg
TVNUQVRVU19VQkUgZGVmaW5pdGlvbiB3YXMgYWxyZWFkeSBwcmVzZW50LCBidXQgU0JFIGFuZCBN
QkUgd2VyZQ0KbWlzc2luZy4NCg0KU2lnbmVkLW9mZi1ieTogRGpvcmRqZSBUb2Rvcm92aWMgPGRq
b3JkamUudG9kb3JvdmljQGh0ZWNncm91cC5jb20+DQpSZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0
aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KUmV2aWV3ZWQtYnk6IEFsaXN0YWlyIEZy
YW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4NCi0tLQ0KIHRhcmdldC9yaXNjdi9jcHVf
Yml0cy5oIHwgMiArKw0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCg0KZGlmZiAt
LWdpdCBhL3RhcmdldC9yaXNjdi9jcHVfYml0cy5oIGIvdGFyZ2V0L3Jpc2N2L2NwdV9iaXRzLmgN
CmluZGV4IGI2MmRkODJmZTcuLmMyYTNlZTRiZjMgMTAwNjQ0DQotLS0gYS90YXJnZXQvcmlzY3Yv
Y3B1X2JpdHMuaA0KKysrIGIvdGFyZ2V0L3Jpc2N2L2NwdV9iaXRzLmgNCkBAIC02MjgsNiArNjI4
LDggQEANCiAjZGVmaW5lIE1TVEFUVVNfVFNSICAgICAgICAgMHgwMDQwMDAwMCAvKiBzaW5jZTog
cHJpdi0xLjEwICovDQogI2RlZmluZSBNU1RBVFVTX1NQRUxQICAgICAgIDB4MDA4MDAwMDAgLyog
emljZmlscCAqLw0KICNkZWZpbmUgTVNUQVRVU19TRFQgICAgICAgICAweDAxMDAwMDAwDQorI2Rl
ZmluZSBNU1RBVFVTX1NCRSAgICAgICAgIDB4MTAwMDAwMDAwMFVMTA0KKyNkZWZpbmUgTVNUQVRV
U19NQkUgICAgICAgICAweDIwMDAwMDAwMDBVTEwNCiAjZGVmaW5lIE1TVEFUVVNfTVBFTFAgICAg
ICAgMHgwMjAwMDAwMDAwMDAgLyogemljZmlscCAqLw0KICNkZWZpbmUgTVNUQVRVU19HVkEgICAg
ICAgICAweDQwMDAwMDAwMDBVTEwNCiAjZGVmaW5lIE1TVEFUVVNfTVBWICAgICAgICAgMHg4MDAw
MDAwMDAwVUxMDQotLSANCjIuMzQuMQ0K

