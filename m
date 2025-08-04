Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E3FC87FDB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 06:43:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiouM-0001RF-39; Mon, 04 Aug 2025 02:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uiotE-0000Wc-UJ; Mon, 04 Aug 2025 02:41:49 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uiotB-0000N3-9t; Mon, 04 Aug 2025 02:41:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yEEztpjSgF0TX+Fr2Im4Butjx/3CAXwMnzbNt018RinPZnsc4W73rN8hcz8eiXYWVOvKlnpMQkP3Y2VE5mR+Qj8lOWMrx/jdiyoTgHchYZPbtBaf1koiQOoPYmPVqnbVOJ6a1wNAru3ccHDoL20VT+Gw2p+lTTRdn7O5TJclmycrwDh0Z9ZNXcDkF76oeXLcCZJ1VeSxxCks1MCcLEU5jOyfroeBMn9UcPGMigYDLwvun26UK+ZdgTu7kFsG1zzhXOW9COVHTer/Q5yyVQeI8L15A6ImIstceEoLBZVqUaaBNWo50dnqUJCNPun8jiVXBvi2dMhgh5M7V0mgOmAQLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfD6UF+XF1HSXVV/CSuPmndlasNGMJxo+ExKb25SMeE=;
 b=pauYYkmfbDNyZToDAyw+E2tFKsuOHqbxswnfqdgXgR/n8/Pepc4FzsTXe35GR7pwIy2ejXiur26Xd9Vp4TltMtnF2s27YmRDeGVDQhiacAdSzQeBxlvwtwnaEQlnR5EBaWaNXsSrzgfdWssEA0tFOypE5cV++DCLlkaZ/pZUmq925b9XGL2HVcrz8U97Qcn6GiUZa6KsetjtW+auf01BDzd1/lrk5buNpdh0Aq1qisBfmcH3Oth4DdcvWtm0Yhdv+MtzqlCcB2hcCxH9yrNt1Q72ShkcQGKOxhmeisK01SYK7aOlbOmElsu9xkGhHmozy+AA+3a6whYzE9DhOygOGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfD6UF+XF1HSXVV/CSuPmndlasNGMJxo+ExKb25SMeE=;
 b=fF1NOIeX1z9F40gkkemvt5E6HmX8La/iu/5EcdyE76dVJ9U1Ed0oWpGNrUcsFbvf/ABG99JnudAl4H7GDZ8/7caDE9BbIqBA9s2V1UOGgcFamXLTnF1o/NhDSqGWaOATOA+YsnjuhXXcgNAx4ELV449dSEsuy+cAC+Q+hM61sH7ktHQZY5kShw9AF3+pxdXbQHviwltzTO+oQwvUSqrvuC/25nDxjjLrR5zhz81+qaok3CjwwipCOyPddENPP93wHeAG5/UdXcA6/BCruqjyTE31XPpNgZ9WdGZY2lU3bt9KApA8bnzufceOS+LIdRD7WkDTP3KppVKIxH8cQONP+A==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SG2PR06MB5129.apcprd06.prod.outlook.com (2603:1096:4:1cc::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.20; Mon, 4 Aug 2025 06:41:27 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%7]) with mapi id 15.20.8989.017; Mon, 4 Aug 2025
 06:41:26 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Alistair Francis
 <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, Steven
 Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1] hw/ssi/aspeed_smc: Fix incorrect FMC_WDT2 register
 read on AST1030
Thread-Topic: [PATCH v1] hw/ssi/aspeed_smc: Fix incorrect FMC_WDT2 register
 read on AST1030
Thread-Index: AQHcBOGf+NaDt6pEnUmo/De6cpsHuLRSCZgAgAAA+8A=
Date: Mon, 4 Aug 2025 06:41:26 +0000
Message-ID: <SI2PR06MB504111C126DDA681D08DDCBCFC23A@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250804014633.512737-1-jamin_lin@aspeedtech.com>
 <08588dcd-d622-49f2-86ed-354a896d2cd1@kaod.org>
In-Reply-To: <08588dcd-d622-49f2-86ed-354a896d2cd1@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SG2PR06MB5129:EE_
x-ms-office365-filtering-correlation-id: 4242271f-42fb-4eba-d8f0-08ddd321efc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dGdnVWpwUWlMSW5aMU5yMjl2L1p4R3lnWTRSUkZzZmFRNnNWMEgxMUtsSHlt?=
 =?utf-8?B?cTBPSlY5SjRlSUJEN3VpY0V2MFduRjhrWkcwVUdzalBXb3BkaVRaam1Objdm?=
 =?utf-8?B?UW56SklRMEVvZjVhS3JGd3lJZ1RyRWl4UVArU3ZBY3pwOTRZb1pqeG1qa1Fw?=
 =?utf-8?B?NFdycUkvZHdHdmI0VXJpOTc3Y3NkOW1vRzBPY2FVQTFKTEF3UDU4dDRBVUNV?=
 =?utf-8?B?dVczZmFJMTRyeG9CdFhlWVNYdnlZbTdrNHpyV2xJTWR4aTk1Q0RGU3A3aHZj?=
 =?utf-8?B?M1JJb1JMVUROVGU1VDZBYjA5V0dtL2JScWZYekR2bFFEc3k5cTd5b0lYQzl3?=
 =?utf-8?B?M29xQXozcU1PN3dzbjFrTC9sV01wTHVNNkd3bHJOY3hBTm0vaUUyalIwL2tu?=
 =?utf-8?B?UllBcitvNHViTmpoWHJQRVdMd2d0bGxpWFpFMWxXSFhXSXBQZzMxeTRLM2Ra?=
 =?utf-8?B?ZTFMNWt2WUhWMjFuZndmcjNvdGpJNWo4Snlwalh6YUdDdlI0dEZPazJUUjdU?=
 =?utf-8?B?V1VmMWJmSmlSQmpFY1VEU3F5eExGMXpYTm1lQysxRWVVbUVoaHovQkxrRUZt?=
 =?utf-8?B?WWQzdCtaTHJia1QyK0IvQi9zNU5rNGpLZjVRZ1ZmTkN5RVNUMHR2aFNWczQ3?=
 =?utf-8?B?M2ZEMmo4Ym1zbnFlNVlFUWN4UDNlTGJkanJaS1h5U2daNHEzYUZCVDdZR1NQ?=
 =?utf-8?B?a0FmRnd1TitzS0VFdTg4Q1NTV2d0eUtEdEpTbGoyRVlWMXp2ZW9Xb0VJK1BT?=
 =?utf-8?B?YzhnZkNvYU9TVFdNdGxBc0NhSWhQcXNaVFlqYVlKNmxabTlXTHdoL1ZmSlJO?=
 =?utf-8?B?amNucWFFSVZWMmdkaitBbmZ5MDRYSjR4RG5pQWdhdTRwTENJd3k0cUZqQWlK?=
 =?utf-8?B?YnhucWpNT2pubXQ1ZUZhK1lZSmorTVNTWFJNeVEzRDRBUEs0MUVTY2FXZ1RZ?=
 =?utf-8?B?cnZLOGRwRDgzdDRKQ3dJU1VubWd5eHd4QktIWUs3ZzhLdHIyaVNkejJReDUy?=
 =?utf-8?B?Vlp1WDRCVUtlNnBpZGtzNjlHcnZoTGx0cExUK2lUR05STWpMQjBmOWhRTzl3?=
 =?utf-8?B?NWE4am83VUMyTGdGS2tlaGRtdk52K20venZuOERoT2xQR0ROTEIvWGdBaUlo?=
 =?utf-8?B?ZGJwdGRoZGdIZVFYeFYzY3BRS1NDcDExU1dvY0hRKzNkeVJSZzhMN1R2QThv?=
 =?utf-8?B?T0gxVFFmNlVYZTFMSDVwdWllNnlKSCtLTWJmUThvTEpOWlBvU1FVWVFjWnow?=
 =?utf-8?B?RkJueGtIcDZYOG1Qakd3Z1I4SU5Sam9wcXl0VUg5bjQ0RFlhaGErYjlLOVlX?=
 =?utf-8?B?KzRvWk1NREloTHl5N1VoRy9nMEVlTis3dzVOOW11NWVvVDIzMWY2MVh4WVlx?=
 =?utf-8?B?cHdmaVZhakZFSElyZit3anJkY2xLYkhmY1FGWFVvNkYwNSsrUk9pSXMwL0ZY?=
 =?utf-8?B?a3A5VXM4R3dhdlFMczlhR3J4VWNqYWc3aFlwNm1GRGR0Y0NIaWI0ZnNmRkE1?=
 =?utf-8?B?UG94NWc1YXdpRmJDMzhSTGJNc3gwYTdlVDlHUVdVSWpoWm1HKytvWFR1QWNq?=
 =?utf-8?B?OUlyTXA0SnFVK1pqOVJKQlh5L2JkQm9rQmtuR3NvanIraENYbFVJZFRTL0lX?=
 =?utf-8?B?WnpEbitJYW1GNDRsVE9FMjlTOWVlQURiN25iNnhBZkpxSUVteFluOFZUeitB?=
 =?utf-8?B?YUtTUXZ5ZkpHbGFrSWxDTHBtMWpJeXF0OFdwTDR1RjJxcXJHKzhrMSs0Umh1?=
 =?utf-8?B?R0ZKYTUvbEt1NnlQczVLQ2VRVHNNa0xRSk90N2hMTERpc2VsNUN3Ylh2NkhX?=
 =?utf-8?B?NzRqQUh6ME9tVnMzVWc1Qy96eEVtT3ozdVhnb1FEOXdOaGM1THhUdnU1aVBY?=
 =?utf-8?B?cmZrMnl1S2U3OVorak53UzIvaEVmNFc4eGN5L3BiL1hYR3VrdnVCRGRlUXJF?=
 =?utf-8?B?MHB0c3I1RmVDSmFpL0VadUpwVVZ0ZG1QczFBWUdCK0JzdFBYSmc0cnJQbnE3?=
 =?utf-8?B?UTI3OHRPS0pRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlBCYkpwejNNNldKVXVFYVJ5ZlJjVURjZlV2VXRVZStHZ1BRenM2UjM1U0VW?=
 =?utf-8?B?Zk9TK3BuTkllc0xoYmI0bCtwNFN4MWd4MzBsb3pab2xuZDRUSTBacGp0aVp2?=
 =?utf-8?B?TnplNTdDd0VHTC9OL2xBaXU5ZGhZak14RUdNaUN6bFVsWm5jSHhRSGIra0Fp?=
 =?utf-8?B?ZzNrUytFTUxVNGpKQ3dDd3M4dTdadHhRVjNFWGZJSDVzUHpHdTlxNHE2cWNT?=
 =?utf-8?B?U2dndUtSVERCQ3ozZyswOUtmT25PbVJYWVlwZXYrVk1FYis1Nm1PdlJHTjlU?=
 =?utf-8?B?ZTdMLzlmNm5HTzNHREhhQU1pbS8zSDgvaGV1VStBYWd3aDN3UzE0allFS3VS?=
 =?utf-8?B?cEtkc0hMSUN2ZVpncG1lKzEzM1ZyVjByM1ZDK2lvNTF1YkpFYUNGTGtwSFpM?=
 =?utf-8?B?TStLWUxvYXZJUW1kOFUzZlpIT1dkR0NzQ1hTRHJaVXcvamw3aUhRd2RLcVZM?=
 =?utf-8?B?OUJKaGY2UmYzK0F3UWNDZUV4dGt2bldiNDMvM3hJVVJsbkwwRGdrMUttNXVW?=
 =?utf-8?B?WDRsMHN3S3Y0R2l5aUNJZ2hyY3U0ZW9NdXc1cVMvc2lLVnlZTGZOVG0xdnJ5?=
 =?utf-8?B?T2pFRkVwYm5CK3gzR0JhajB1NEJYTFJnNUNLM0VwYklHSXp6djFObitoMEVp?=
 =?utf-8?B?V1p0VHovNml2a0RYWGxCemg2KzVOUDFVaUdhTjBRWDV0ZmFhTElkaVRheDlI?=
 =?utf-8?B?Q2tNR2tvQm9MM2xqRlFLQUdqVlNOWk5TNFllM29XNUExMUJvRHUwb0d2a2dL?=
 =?utf-8?B?T0YyalcrZU1Hc3orSko5cmxKU1libEk4dEVMMUFwZVdEM0ZaVG85OCtJUVNu?=
 =?utf-8?B?djVBM0xOS1RIMHBodEQzVlZJRmZxdWRWdlJHU25tbW51RVRsam9VMFdKSU02?=
 =?utf-8?B?ZmErWlI5VzVzbFd2Zkh1bkNCb3FJY29kZkUwQXliS25CeEtKd3VLMjBFVWRL?=
 =?utf-8?B?SzdFa2FwcXA4cmtYQy9Jek53RnRzd0lWMEpqcmhMdThYSUx5OEZWbnJBQzd3?=
 =?utf-8?B?dERUMWh6ZGRFQmNKcXc4TXY5N294MUxIcEpxQVd3SGhpYmxwRWhML0J0QkZ0?=
 =?utf-8?B?cTlTNDZtVkJXQ0d5VE1Ta2V4c0R5SWkrdStNTkorRjVGKzRON1liQ3dqczdm?=
 =?utf-8?B?NlN3d2xhWGJSOWpCMjEwNi9ibkR1ZDhjSkVlenJ6ek9MSkNvalFsMCtBMExE?=
 =?utf-8?B?ekRySW9rdFpmM1A3ZmNjc1N6R2VIMFpMeUxweWRUUEl3TlZEVDdCVEpBQ1Ay?=
 =?utf-8?B?eENsOTZWaE5iRkU5UTZ1bXFiYVVkSVBUSXBRMEZhNloySUc2d0xuTDRTU3o5?=
 =?utf-8?B?T3FQeHYwSko3NENsWnE4NWJiSzhFbmYyQm9Ib2V1TVFnMW1EZzBRUUdJdkdR?=
 =?utf-8?B?T1cySWFtcGV2NWYySytlcXp0ZzUyZm9yZHpydTFnWTlqRS9TN3pwYnVsNWlT?=
 =?utf-8?B?ak1JWkZvVjBrRjdYK2tsaGh4OGptRFp1YnB0bXZNMmpieWtzUXlWclVrL003?=
 =?utf-8?B?UlNWYzlGS0NuQXFTanZBY1k2eFRwWG9qK3F5T1lWT0JveUxEaW9DN1dXd0R0?=
 =?utf-8?B?SkZIenNRSEpkUENPKzQyZTd3b1ZBK2w0YnN1bU5TSk43bVNyc0pzQzVac1Z5?=
 =?utf-8?B?bk5TOWNOemlLWWMyNW8wYkZXYzNQZ1p5RS9NQVM5ZkJidkxpMHZVVGh6emlG?=
 =?utf-8?B?K05kckdFYUhYY05PaExaRjNCRVQ2NHFNMXVyVWI2aVVjb1JxbnNsZzBQV3E3?=
 =?utf-8?B?R1hjSXViQlA2bzNBNU1pYnFUd01PMDk2bnBQcGdFZEhrZkhMbkZuU2JqMlFh?=
 =?utf-8?B?VFV2dlRnZFlhMGEzVW1KQzFnbk8xYjdCeWlMNzJFcTd6UzFCOUNuTi83bkVx?=
 =?utf-8?B?S1J4TXlPaFJRUFVhQXNvU29FK211TDRWR3M5TUhEOFowWU53UExnU2x0b3Bx?=
 =?utf-8?B?aFQvcW5NbUVmd2hXUFFyZTNsa1FZUXByYmhjVS9JT204RGtaYkE4VlhaRmk0?=
 =?utf-8?B?eDlkWFJtR0I3NC83WTdIQ0xZRE5LcGFtV0V5WUd3V1pRandZT0wvNVFWSjVa?=
 =?utf-8?B?MklHWHhzdXJsYkcraDQ1UVE2d0dieW5lbllhRDdQdnlXeEN3bnI4enRuL2VP?=
 =?utf-8?Q?C3s929UuT1CtQellDtBzeEpIY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4242271f-42fb-4eba-d8f0-08ddd321efc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2025 06:41:26.5764 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vkccpaph+1JBSABMlJNTUN9DLiaitj4fWc2CCgejtvxEiV8ROboQr9UDF83G1zRb67mZijsaW91PXgMmTCKuH+mYmxGSjlg8O7IqMpGWEwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5129
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGkgQ8OpZHJpYywNCg0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0K
PiBTZW50OiBNb25kYXksIEF1Z3VzdCA0LCAyMDI1IDI6MzMgUE0NCj4gVG86IEphbWluIExpbiA8
amFtaW5fbGluQGFzcGVlZHRlY2guY29tPjsgQWxpc3RhaXIgRnJhbmNpcw0KPiA8YWxpc3RhaXJA
YWxpc3RhaXIyMy5tZT47IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz47
IFN0ZXZlbg0KPiBMZWUgPHN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5jb20+OyBUcm95IExlZSA8bGVl
dHJveUBnbWFpbC5jb20+OyBBbmRyZXcNCj4gSmVmZmVyeSA8YW5kcmV3QGNvZGVjb25zdHJ1Y3Qu
Y29tLmF1PjsgSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47IG9wZW4NCj4gbGlzdDpBU1BF
RUQgQk1DcyA8cWVtdS1hcm1Abm9uZ251Lm9yZz47IG9wZW4gbGlzdDpBbGwgcGF0Y2hlcyBDQyBo
ZXJlDQo+IDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+IENjOiBUcm95IExlZSA8dHJveV9sZWVA
YXNwZWVkdGVjaC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjFdIGh3L3NzaS9hc3BlZWRf
c21jOiBGaXggaW5jb3JyZWN0IEZNQ19XRFQyIHJlZ2lzdGVyDQo+IHJlYWQgb24gQVNUMTAzMA0K
PiANCj4gSGVsbG8gSmFtaW4sDQo+IA0KPiBPbiA4LzQvMjUgMDM6NDYsIEphbWluIExpbiB3cm90
ZToNCj4gPiBPbiBBU1QxMDMwLCByZWFkaW5nIHRoZSBGTUNfV0RUMiByZWdpc3RlciBhbHdheXMg
cmV0dXJucyAweEZGRkZGRkZGLg0KPiA+IFRoaXMgaXNzdWUgaXMgZHVlIHRvIHRoZSBhc3BlZWRf
c21jX3JlYWQgZnVuY3Rpb24sIHdoaWNoIGNoZWNrcyBmb3INCj4gPiB0aGUgQVNQRUVEX1NNQ19G
RUFUVVJFX1dEVF9DT05UUk9MIGZlYXR1cmUuIFNpbmNlIEFTVDEwMzAgd2FzDQo+IG1pc3NpbmcN
Cj4gPiB0aGlzIGZlYXR1cmUgZmxhZywgdGhlIHJlYWQgb3BlcmF0aW9uIGZhaWxzIGFuZCByZXR1
cm5zIC0xLg0KPiA+DQo+ID4gVG8gcmVzb2x2ZSB0aGlzLCBhZGQgdGhlIFdEVF9DT05UUk9MIGZl
YXR1cmUgdG8gQVNUMTAzMCdzIGZlYXR1cmUgc2V0DQo+ID4gc28gdGhhdCBGTUNfV0RUMiBjYW4g
YmUgY29ycmVjdGx5IGFjY2Vzc2VkIGJ5IGZpcm13YXJlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gICBo
dy9zc2kvYXNwZWVkX3NtYy5jIHwgMyArKy0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9zc2kvYXNw
ZWVkX3NtYy5jIGIvaHcvc3NpL2FzcGVlZF9zbWMuYyBpbmRleA0KPiA+IDYxNDUyOGI4ZWYuLmUz
MzQ5NmY1MDIgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvc3NpL2FzcGVlZF9zbWMuYw0KPiA+ICsrKyBi
L2h3L3NzaS9hc3BlZWRfc21jLmMNCj4gPiBAQCAtMTg1Nyw3ICsxODU3LDggQEAgc3RhdGljIHZv
aWQNCj4gYXNwZWVkXzEwMzBfZm1jX2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKmtsYXNzLCBjb25z
dCB2b2lkICpkYXRhKQ0KPiA+ICAgICAgIGFzYy0+cmVzZXRzICAgICAgICAgICAgPSBhc3BlZWRf
MTAzMF9mbWNfcmVzZXRzOw0KPiA+ICAgICAgIGFzYy0+Zmxhc2hfd2luZG93X2Jhc2UgPSAweDgw
MDAwMDAwOw0KPiA+ICAgICAgIGFzYy0+Zmxhc2hfd2luZG93X3NpemUgPSAweDEwMDAwMDAwOw0K
PiA+IC0gICAgYXNjLT5mZWF0dXJlcyAgICAgICAgICA9IEFTUEVFRF9TTUNfRkVBVFVSRV9ETUE7
DQo+ID4gKyAgICBhc2MtPmZlYXR1cmVzICAgICAgICAgID0gQVNQRUVEX1NNQ19GRUFUVVJFX0RN
QSB8DQo+ID4gKw0KPiBBU1BFRURfU01DX0ZFQVRVUkVfV0RUX0NPTlRST0w7DQo+ID4gICAgICAg
YXNjLT5kbWFfZmxhc2hfbWFzayAgICA9IDB4MEZGRkZGRkM7DQo+ID4gICAgICAgYXNjLT5kbWFf
ZHJhbV9tYXNrICAgICA9IDB4MDAwQkZGRkM7DQo+ID4gICAgICAgYXNjLT5kbWFfc3RhcnRfbGVu
Z3RoICA9IDE7DQo+IA0KPiBDb3VsZCB5b3UgYWRkIGEgRml4ZXMgdGFnIHBsZWFzZSA/DQo+IA0K
Rml4ZXM6IDI4NTBkZjYgKCJhc3BlZWQvc21jOiBBZGQgQVNUMTAzMCBzdXBwb3J0ICIpDQoNCj4g
SSBwbGFuIHRvIHNlbmQgYSBQUiBiZWZvcmUgLXJjMiAoVHVlc2RheSkgd2l0aCB0aGUgdmJvb3Ry
b20gdXBkYXRlLg0KPiANCk9rYXkuIFRoYW5rcyBmb3IgcmV2aWV3IGFuZCBoZWxwLg0KSmFtaW4N
Cj4gUmV2aWV3ZWQtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4gDQo+
IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KDQo=

