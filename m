Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B86C02182
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 02:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb9m2-0006Io-J9; Thu, 23 Jan 2025 21:50:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tb9m0-0006I2-3c; Thu, 23 Jan 2025 21:50:20 -0500
Received: from mail-psaapc01on20713.outbound.protection.outlook.com
 ([2a01:111:f403:200e::713]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tb9lx-0006L0-9M; Thu, 23 Jan 2025 21:50:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N6yzJmbM138gO/BDUAfXXDm7OYl74OkI2eivCLmM9CMwg/fdZ4gjCDY3uo6pLToRjSUVPCQF+76il2soxKFHhYHKI6BX4lm/kgBOBe51VYko8hlGZrT996BFHNQoVYEY3vGQdVLJAk1+8G0jBzSVl256Qe9Qyt3GLcbFntUT5UwFU8+Fgqj0lZpkrJjruTCW9kusZO8H/s71xcg6eF2dbrKiDKAxhs3Gp5QxAHc0o2Qj7+uwLMQZPg70GOmcHQD4ug22n5GToM1/nSaiYZlssfVjgqYqcShi58PD/jHSjwEjpZyHdjp00slNEzvavxHRvd4u9Wi69JhXa7+TVc0Ahg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+ohJGCN3DTcNQ9tFi4R48hcpIjBvtzIVTwufQLI5Nk=;
 b=Xspq3F8oVnz0p+RUvDbBaU9x9ovp9r8mrtJyb5rcrt9hp2yQVJEu+vdgXsvUJEf+vcRB5pB19P8Wx6cc+oWODxr9nTZLLSo65EMfBPsil4RicRGMwLVdw/2GEqAhqYW3tPJelceGXCyv1ZMDdBTKiR8og7fepdBKt9R1ZxR1+NY9A0/EW3cLUA2H37s54llrdbDWiqDne/USkqyGDMeFkByYhULCmE6Dt9r/0Jr+t69Mt4bqiRAh9jMbtSIW5Xxz+/ZDfcV0+Iqm5kB6usaqig5XWEoOvL01AOefsGUcAjZhHBpMJSl2dmno7nOSKSmCrQ0EdnUwTrBVAepksXGQvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+ohJGCN3DTcNQ9tFi4R48hcpIjBvtzIVTwufQLI5Nk=;
 b=q8G0yi/YOCnzFEx6mLJX3OnmYrFX/EuwbJLixYnfPA+uQA8HKf6zj2N3IUR4Lp0MdPbF8jCrFhw9Ni6LwnN9bE5KrTlSMdPA+qpozmDAnw2+ULiAj6ed3hOonQfJCyEcKMluariFaHXtw3lO82A7fCDqXQxA1jgdLMnV5knA4SBnzpCMoU95Z6GCvMoXtSOTG2Ma8tIyygv3fZmvsfknjIx9njmvyZ+MbegOEG6V7sxPjEmG7E58YiDsy35WLD2UxIHdjxnNl5UT0jlN3CTXczlIh7U175wX1opYb+400dVO6r6unbbmO0Lh2AKLqJ/jdsPySWDPIcIEhy5CF0mcjw==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 PUZPR06MB5572.apcprd06.prod.outlook.com (2603:1096:301:e9::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.13; Fri, 24 Jan 2025 02:50:08 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 02:50:08 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v1 2/2] aspeed/wdt: Support software reset mode for AST2600
Thread-Topic: [PATCH v1 2/2] aspeed/wdt: Support software reset mode for
 AST2600
Thread-Index: AQHbbW97PUdwjvbFekSSSVsnx8YeD7MkswYAgACGQYA=
Date: Fri, 24 Jan 2025 02:50:08 +0000
Message-ID: <SI2PR06MB50419CFA8AB56B763776B041FCE32@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250123081901.2688471-1-jamin_lin@aspeedtech.com>
 <20250123081901.2688471-3-jamin_lin@aspeedtech.com>
 <335251f9-fea8-4eb6-ba97-6d8d3a68a98b@kaod.org>
In-Reply-To: <335251f9-fea8-4eb6-ba97-6d8d3a68a98b@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|PUZPR06MB5572:EE_
x-ms-office365-filtering-correlation-id: 837b6e3f-2b8d-44ef-e595-08dd3c21d05a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SkU2OVF1a0IwMFdJWHVLeG9udm1ZZFJtaFBqMHBxU0JOMlBhY3I3d1RscmN1?=
 =?utf-8?B?amxLRHlCZ1JIQ2dHMHFrSzZ4a1QxWG9JdURrVm5XOXlpbEF3d0RsOTk3amJI?=
 =?utf-8?B?ZUZiaWxMSUhxcXpCcldmazR6aEIzSGgwSXhIdFhXdDlaZlFxSlV0dzBxMlVD?=
 =?utf-8?B?RDNzYUxzVGMxZmNFUzVmZXdHZnEvN01iTWxieHlvUGZaNnRuL3ZYdmJVdW9D?=
 =?utf-8?B?M1JPMmJqNTl0R28ranczeFpUVDIvWHdzOTVIaENBY1ZHK3duQWpSQUFPUkl5?=
 =?utf-8?B?VHM4VFpwRk03Z1g4bnowd3JzTk9Dc0tkaVRLSndBYU5JZGdDbFpISGRnTWxr?=
 =?utf-8?B?QmhITnUwSEtJTG5yVGlBb1h5Q1N4UkVhaDRhbXdaTzg1U2hHaGFXdGsrV3Rz?=
 =?utf-8?B?QlMwQmdhSjZVMUtSSkxsaGRwNmMzQW40LzhpaHNpdi9QSjJrd0xicGZKNi9r?=
 =?utf-8?B?Qjdpc3VNSjhxU0dSL0tsVy9aWmFLRUV3eG1NT3lkY3EzQVVzZlljUjlVckht?=
 =?utf-8?B?ZU9oK2dDS0ZNL0w0T0I5ZVNuMW1Ca1hkTHhTS0EzMGN1SmpLc3BMNW5CTk1V?=
 =?utf-8?B?bTZhMkxGZ0hxWlIwem8wSitIQ0IyQ1MxOFo5eG1RNmptRUlpcW9yM21yTXp4?=
 =?utf-8?B?Yyt1MjlCK0dFN0M2Q20vc0pwWWxoTXNlV2NLOFByQ2hFYks0Y0xXdDRQOFdI?=
 =?utf-8?B?Y3BqVkpkdUs5bXlRNTlRZkxjTU9XNS9KbnRMbzAyZlEwTDB1YWVsajh0TDdy?=
 =?utf-8?B?ZUNqWFJlRGtteDNnMDh5ZW1KbnBlMEN6NVU5enI4TXZpZDlvNTNUMzRVYjNl?=
 =?utf-8?B?a3JKb2VRRU9oaUNYN1ppOUh4eXdKaCt3T05CQW1kQU1xZ0N4OXNiT2hNR0cz?=
 =?utf-8?B?TVhlNURNd2N3VE5rRDN4NnhrUHI1UGhzR2VwejAzVGhXQmxXY1RVM2tINzY1?=
 =?utf-8?B?NEVBQ2pzS2taVXZQWVBiaUNSR3ltVVArOExuT0NSdXliWWswOUVVRXRCZjU2?=
 =?utf-8?B?VG9nRkxKQm1PS21XZ2JPQ0VmWWZnZnVNZ0grMWdSS1liSlQrSTk3MzFMbFZl?=
 =?utf-8?B?V1NPNVN0R2lMVzFpd1l0bVNSOUtsVXYwRjNOUUFWSFJsN21NVWJDVG9KVnNL?=
 =?utf-8?B?LzcrNEtCNm5YbmUwVWJHNUp2OGwrSXcyb2ljVWNRWEtDZkdhUFc0ZWd0V2JR?=
 =?utf-8?B?TUZjRUxhb3lsVG92MXB6cmJ0ajUwYjFoWGZCNjVBUDJYc2ZXRjFNbyt6dGJW?=
 =?utf-8?B?cUdNUHNRN1A2R09zcFZjTWkxQzJSK2cwbXV0UVo2QUtiNm9vNW5Na2k5WEgw?=
 =?utf-8?B?Wm5idWdKWjlGQ29HR0pPa3FvK3VXMnJDaHFjb3Z0bFVpMkM1T1BJY3o2VWt0?=
 =?utf-8?B?YnpmY21nUStxSG5IbHNVdnVIeExRV1VXOUFOU2xpdHRvcC9Icnp1Y1EzdXU3?=
 =?utf-8?B?UHpBTGFiM0U5WStPQ2hmdnJuWS9HS0dOb0FmTjhraUxoblZ4WHVjUDQzWFJy?=
 =?utf-8?B?SzJXSGJ1eTNtN2ZsazNLeHpkeDdOOHhiQjBxTllwVjdmTTdrbXg3MGdBeXVH?=
 =?utf-8?B?RGpqcEgvWHNSdjhWNzREWGwwS0RIOE9ySlA3WmdhSnVsTGRnWXcvUEsvbGhi?=
 =?utf-8?B?Qi9MWGIrdk1WZzBzbDlPK2VGMy81L0ROMVRQbFowWDAxNUVmamhmVnZxeFdK?=
 =?utf-8?B?MGgxUERTa3JGOXZ0YlN3ZlRWT0pLMlByOUtqY2NCeE1WN1VrMTZLelp3U1dy?=
 =?utf-8?B?MmhBY1daM2FmeUZseS81b21WaGMyTzNxUUoyZHdseUNUNHE1VnFzeXRyRGRD?=
 =?utf-8?B?eENSb0xtUUY3RmlZWWdGa3J2VUlHdTZvYkNvMytFelAxOHZMRFNjQmpkclY4?=
 =?utf-8?B?d3psSnl3MTdiL09ORTUrV04zalFZWUs0dld5YnNaZURhNUJxK2RLRlY0aUhQ?=
 =?utf-8?Q?6xn00RO1L/U3vCP4ojwV/afSkSGkzn3h?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFloSkdNQlBqOHhmN3VURVV6cmR5SEt2MllxUEtPY2p2c0haS0tjYi9aanM3?=
 =?utf-8?B?WGdreTZPaEI5Y2N4T0ZtZThJWGZIUEpXb3JsMVFSZXQyamhsZ3dEbURmYXdm?=
 =?utf-8?B?RG8yYURVVXBJdTN3TXMwajJkRVNxZ3F1Y29Qd0MxclNhdkFYbDRVc3MveWJx?=
 =?utf-8?B?MUVKUkhFWWpTZlJFa1F4TUN5RVFSNDhndFpoR3p4bGk2YlU1RVdKWjVSTUlV?=
 =?utf-8?B?UjgxZTFyR0dIcFI1TUdsZlRBSm1IdjlPMFFNK1EyU1RUdVkzODRhckdTLzlZ?=
 =?utf-8?B?cnJFRXBsaUhXdlh1ajcxd3dMZ0xzTGxSVmV5TWxpZXZRWTBBd2tOajJTeVc1?=
 =?utf-8?B?SG1TbXJUNzFDS29SUUFLSktkYUpTS0svM0hiUDNFKytoc05qTU5vakI1ZEFh?=
 =?utf-8?B?UndmaUIyanV6djZJYWN3TVcyNE1XL3M4bjZGUURCMVlPU1pXS0lBSHVaVkF1?=
 =?utf-8?B?MlB1elJ3WG43Wmp3R3FyaU8xbmJoSmtjMVJXRzVkdW93OThVbjBybURPcUh2?=
 =?utf-8?B?T1N4bXB5YStzWkZrYkpWeFB5K0RBVDNhWVVDVFZ6VndqazVad0pJV2ozb1FW?=
 =?utf-8?B?cmNZS09YU25oV3V0Unp0WmpQYmtVQ2U3VlpTajdnYmpTdmdJUmQvS1VGU1NX?=
 =?utf-8?B?WWt3OVFtSk5lcnM1ZWp1RE5UeXl0MElDc05WSktWQ1pGdjRkVEFOa1orVk01?=
 =?utf-8?B?Z2VQL2t5aU40K2ppNWxOMU9NNVFSbFlIRWFDZFJLeHdpeGIxSWpvTlN6S0xC?=
 =?utf-8?B?YXhMUVVlS0c5MDVMbzM5VFhSdnlOOUZhRWtlVmtuMXNzT3hCUzZjYjNPVDVK?=
 =?utf-8?B?TDg0Y3JOcXpYSHF0OU9sb3FPUUJ2S3ZRRytkRGJrSWROQTRxUk82ckpnYlVI?=
 =?utf-8?B?TEd1R2plNkF5UGZIbytCeU9JZnRPQmx3RnNEeit6S0dFZVk5T1lKRS8ydzZE?=
 =?utf-8?B?NDJFSS9JYTMwaEhBL3o3N1pjZ2QvT0JHTFMyNGhVZ0ZpbCt1Z3c2SFAwbWEv?=
 =?utf-8?B?bEVscjR4N1JwOGJsQnVwdjBrK0hoclVYSVUxbFMyOTFtQTZnYW1NOStDT0Vm?=
 =?utf-8?B?bis5eTAzVHg0OWxCWHd0UU1qVUI3OWRqTkx1L0lSaWdPa2NnbTBpR1U5ZkpS?=
 =?utf-8?B?cHVEZE9wWnZrMmkzcnU1QzU5R3dhU0hvZFQxaTJvNGV3QmNaOGl4UTNoN2M1?=
 =?utf-8?B?WWhIRUJkTEtteVB5TG5Rc1d2a1grc2ZJQUdVMGFpRU0wWmFBT0RMWkI3RjBh?=
 =?utf-8?B?elJ5Z0NCZ3ZZTHIzSHM0VzFia2lDaFpzUlpRRElzU1k0RHQ0bEJlazE3OHNh?=
 =?utf-8?B?WWIyRS9qd1BZVXhaVWp0Z012ZWR3TjVqcU1RdlhjYzVGdm9xOHIwTytXOEQx?=
 =?utf-8?B?Q01KbDV1KzAySi9RSzJ1VFo0TFBZNHNSMlRPTzNLdC9oM2pVTmhlaVRWa1Nk?=
 =?utf-8?B?RjFKTkNpcEdwMmkxRExwcDRtSFpROGhwUGJVbHpPeDJFQmJrOWREa0xQenMy?=
 =?utf-8?B?bStPTWM1QnNuV05xM3pUd3k2SjRiQWE0ZTd2TE1TWnJmcThlMFVGMVB2VFk3?=
 =?utf-8?B?aTZlQlhnVlZRN3g2WTVockNvN2FBNXVFWEhYUzR5RjJVRXhVNlBlSnZmekFM?=
 =?utf-8?B?aGJOSnNXWlY2cUtVQTNzMHpYSzh6cU9QcXZoSmM1K0xKbTVoTm9LQnlyUWM1?=
 =?utf-8?B?K0xBTWdnQTg2MHU5SXRnWTBkT0kxZUVTQ1RyUWZLSFNKMTJhUGE3WFdvc1Zl?=
 =?utf-8?B?Q3RpMjRqSGs2N2JVU3dIdS82VHhKczArQ1dMM3pCNDR6UkRWTEtFR29qQUJM?=
 =?utf-8?B?WG1jenJ2Q2oyQW9FMzBUbTRUVUdTSzhXUTVZMG8wWTVQR3gwQWZOK3RRdndl?=
 =?utf-8?B?OWZVSWRVeHZpUHRtRitCb2liTG85bTBzaW5xbWR2QXp2a0ZzRjEvQ2I0NnFt?=
 =?utf-8?B?VzRSeU5DeUZrS0t3UVM3TTliMTVKOTNncmhDUmdTSWsxc1hsTU96aVlVQWgv?=
 =?utf-8?B?ZTBCMHV6U01LMmlLbjkzS041VVpOTElJaFdQNXZoMW5rdkQ1cGFTcmV1Nndh?=
 =?utf-8?B?a2JmVDBxVkQzYmdqc2crcjNFbGFQTEVkQVhyZ0FmZnFEMVZvODhKR2lIajMv?=
 =?utf-8?Q?kwlZKjL9JmDcVA+eq595qXjdN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 837b6e3f-2b8d-44ef-e595-08dd3c21d05a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2025 02:50:08.3225 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FPYoM3PPClzYnBMaywhjlt1mAB7IiBtBmCrikCqz3gHTGnpl8x0Pk0Qh9nVBPZfF98tuljjCKvattwI0XXa5lfzaOxabudfgBLdLQ10MJBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5572
Received-SPF: pass client-ip=2a01:111:f403:200e::713;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
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

SGkgQ2VkcmljLCANCg0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0K
PiBTZW50OiBGcmlkYXksIEphbnVhcnkgMjQsIDIwMjUgMjo0NSBBTQ0KPiBUbzogSmFtaW4gTGlu
IDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBQZXRlciBNYXlkZWxsDQo+IDxwZXRlci5tYXlk
ZWxsQGxpbmFyby5vcmc+OyBTdGV2ZW4gTGVlIDxzdGV2ZW5fbGVlQGFzcGVlZHRlY2guY29tPjsg
VHJveQ0KPiBMZWUgPGxlZXRyb3lAZ21haWwuY29tPjsgQW5kcmV3IEplZmZlcnkgPGFuZHJld0Bj
b2RlY29uc3RydWN0LmNvbS5hdT47DQo+IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+OyBv
cGVuIGxpc3Q6QVNQRUVEIEJNQ3MNCj4gPHFlbXUtYXJtQG5vbmdudS5vcmc+OyBvcGVuIGxpc3Q6
QWxsIHBhdGNoZXMgQ0MgaGVyZQ0KPiA8cWVtdS1kZXZlbEBub25nbnUub3JnPg0KPiBDYzogVHJv
eSBMZWUgPHRyb3lfbGVlQGFzcGVlZHRlY2guY29tPjsgWXVubGluIFRhbmcNCj4gPHl1bmxpbi50
YW5nQGFzcGVlZHRlY2guY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDIvMl0gYXNwZWVk
L3dkdDogU3VwcG9ydCBzb2Z0d2FyZSByZXNldCBtb2RlIGZvcg0KPiBBU1QyNjAwDQo+IA0KPiBP
biAxLzIzLzI1IDA5OjE5LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gT24gdGhlIEFTVDI0MDAgYW5k
IEFTVDI1MDAgcGxhdGZvcm1zLCB0aGUgc3lzdGVtIGNhbiBvbmx5IGJlIHJlc2V0IGJ5DQo+ID4g
ZW5hYmxpbmcgdGhlIFdEVCAoV2F0Y2hkb2cgVGltZXIpIGFuZCB3YWl0aW5nIGZvciB0aGUgV0RU
IHRpbWVvdXQuDQo+ID4gSG93ZXZlciwgc3RhcnRpbmcgZnJvbSB0aGUgQVNUMjYwMCBwbGF0Zm9y
bSwgdGhlIHJlc2V0IGV2ZW50IGNhbiBiZQ0KPiA+IHRyaWdnZXJlZCBkaXJlY3RseSBhbmQgaW50
ZW50aW9uYWxseSBieSBzb2Z0d2FyZSwgd2l0aG91dCByZWx5aW5nIG9uIHRoZSBXRFQNCj4gdGlt
ZW91dC4NCj4gPg0KPiA+IFRoaXMgbWVjaGFuaXNtLCByZWZlcnJlZCB0byBhcyAic29mdHdhcmUg
cmVzdGFydCIsIGlzIGltcGxlbWVudGVkIGluDQo+IGhhcmR3YXJlLg0KPiA+IFdoZW4gdXNpbmcg
dGhlIHNvZnR3YXJlIHJlc3RhcnQgbWVjaGFuaXNtLCB0aGUgV0RUIGNvdW50ZXIgaXMgbm90DQo+
IGVuYWJsZWQuDQo+ID4NCj4gPiBUbyB0cmlnZ2VyIGEgcmVzZXQgZ2VuZXJhdGlvbiBpbiBzb2Z0
d2FyZSBtb2RlLCB3cml0ZSAweEFFRURGMTIzIHRvDQo+ID4gcmVnaXN0ZXINCj4gPiAweDI0IGFu
ZCBzb2Z0d2FyZSBtb2RlIHJlc2V0IG9ubHkgc3VwcG9ydCBTT0MgcmVzZXQgbW9kZS4NCj4gPg0K
PiA+IEEgbmV3IGZ1bmN0aW9uLCAiYXNwZWVkX3dkdF9pc19zb2NfcmVzZXRfbW9kZSIsIGlzIGlu
dHJvZHVjZWQgdG8NCj4gPiBkZXRlcm1pbmUgd2hldGhlciB0aGUgU29DIHJlc2V0IG1vZGUgaXMg
YWN0aXZlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNw
ZWVkdGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gICBody93YXRjaGRvZy93ZHRfYXNwZWVkLmMgfCAx
NiArKysrKysrKysrKysrKystDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L3dhdGNoZG9nL3dkdF9h
c3BlZWQuYyBiL2h3L3dhdGNoZG9nL3dkdF9hc3BlZWQuYyBpbmRleA0KPiA+IDIyZTk0ZTdiOWMu
Ljk0ZmI2NDMzOTUgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvd2F0Y2hkb2cvd2R0X2FzcGVlZC5jDQo+
ID4gKysrIGIvaHcvd2F0Y2hkb2cvd2R0X2FzcGVlZC5jDQo+ID4gQEAgLTUxLDExICs1MSwyMCBA
QA0KPiA+ICAgI2RlZmluZSBXRFRfVElNRU9VVF9DTEVBUiAgICAgICAgICAgICAgICgweDE0IC8g
NCkNCj4gPg0KPiA+ICAgI2RlZmluZSBXRFRfUkVTVEFSVF9NQUdJQyAgICAgICAgICAgICAgIDB4
NDc1NQ0KPiA+ICsjZGVmaW5lIFdEVF9TV19SRVNFVF9FTkFCTEUgICAgICAgICAgICAgMHhBRUVE
RjEyMw0KPiA+DQo+ID4gICAjZGVmaW5lIEFTVDI2MDBfU0NVX1JFU0VUX0NPTlRST0wxICAgICAg
KDB4NDAgLyA0KQ0KPiA+ICAgI2RlZmluZSBTQ1VfUkVTRVRfQ09OVFJPTDEgICAgICAgICAgICAg
ICgweDA0IC8gNCkNCj4gPiAgICNkZWZpbmUgICAgU0NVX1JFU0VUX1NEUkFNICAgICAgICAgICAg
ICBCSVQoMCkNCj4gPg0KPiA+ICtzdGF0aWMgYm9vbCBhc3BlZWRfd2R0X2lzX3NvY19yZXNldF9t
b2RlKGNvbnN0IEFzcGVlZFdEVFN0YXRlICpzKSB7DQo+ID4gKyAgICB1aW50MzJfdCBtb2RlOw0K
PiA+ICsNCj4gPiArICAgIG1vZGUgPSBleHRyYWN0MzIocy0+cmVnc1tXRFRfQ1RSTF0sIDUsIDIp
Ow0KPiANCj4gQ291bGQgd2UgdGVzdCB0aGUgZXh0cmFjdGVkIGZpZWxkIGFnYWluc3QgV0RUX0NU
UkxfUkVTRVRfTU9ERV9TT0MgPw0KPiANCldpbGwgdXBkYXRlIGl0Lg0KDQpUaGFua3MgZm9yIHJl
dmlldy4NCkphbWluDQoNCj4gV2l0aCB0aGF0LA0KPiANCj4gUmV2aWV3ZWQtYnk6IEPDqWRyaWMg
TGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0K
PiANCj4gDQo+IA0KPiANCj4gDQo+ID4gKyAgICByZXR1cm4gKG1vZGUgPT0gMCk7DQo+ID4gK30N
Cj4gPiArDQo+ID4gICBzdGF0aWMgYm9vbCBhc3BlZWRfd2R0X2lzX2VuYWJsZWQoY29uc3QgQXNw
ZWVkV0RUU3RhdGUgKnMpDQo+ID4gICB7DQo+ID4gICAgICAgcmV0dXJuIHMtPnJlZ3NbV0RUX0NU
UkxdICYgV0RUX0NUUkxfRU5BQkxFOyBAQCAtMTk5LDEzDQo+ICsyMDgsMTgNCj4gPiBAQCBzdGF0
aWMgdm9pZCBhc3BlZWRfd2R0X3dyaXRlKHZvaWQgKm9wYXF1ZSwgaHdhZGRyIG9mZnNldCwgdWlu
dDY0X3QNCj4gZGF0YSwNCj4gPiAgICAgICBjYXNlIFdEVF9USU1FT1VUX1NUQVRVUzoNCj4gPiAg
ICAgICBjYXNlIFdEVF9USU1FT1VUX0NMRUFSOg0KPiA+ICAgICAgIGNhc2UgV0RUX1JFU0VUX01B
U0syOg0KPiA+IC0gICAgY2FzZSBXRFRfU1dfUkVTRVRfQ1RSTDoNCj4gPiAgICAgICBjYXNlIFdE
VF9TV19SRVNFVF9NQVNLMToNCj4gPiAgICAgICBjYXNlIFdEVF9TV19SRVNFVF9NQVNLMjoNCj4g
PiAgICAgICAgICAgcWVtdV9sb2dfbWFzayhMT0dfVU5JTVAsDQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgIiVzOiB1bmlubXBsZW1lbnRlZCB3cml0ZSBhdCBvZmZzZXQgMHglIg0KPiBIV0FE
RFJfUFJJeCAiXG4iLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIF9fZnVuY19fLCBvZmZz
ZXQpOw0KPiA+ICAgICAgICAgICBicmVhazsNCj4gPiArICAgIGNhc2UgV0RUX1NXX1JFU0VUX0NU
Ukw6DQo+ID4gKyAgICAgICAgaWYgKGFzcGVlZF93ZHRfaXNfc29jX3Jlc2V0X21vZGUocykgJiYN
Cj4gPiArICAgICAgICAgICAgKGRhdGEgPT0gV0RUX1NXX1JFU0VUX0VOQUJMRSkpIHsNCj4gPiAr
ICAgICAgICAgICAgd2F0Y2hkb2dfcGVyZm9ybV9hY3Rpb24oKTsNCj4gPiArICAgICAgICB9DQo+
ID4gKyAgICAgICAgYnJlYWs7DQo+ID4gICAgICAgZGVmYXVsdDoNCj4gPiAgICAgICAgICAgcWVt
dV9sb2dfbWFzayhMT0dfR1VFU1RfRVJST1IsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
IiVzOiBPdXQtb2YtYm91bmRzIHdyaXRlIGF0IG9mZnNldCAweCUiDQo+ID4gSFdBRERSX1BSSXgg
IlxuIiwNCg0K

