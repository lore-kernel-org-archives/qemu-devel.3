Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC716D58E47
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 03:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwu4J-00014G-2s; Sun, 01 Mar 2026 22:35:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vwu4H-00013p-4X; Sun, 01 Mar 2026 22:35:37 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vwu4F-0001S9-Bp; Sun, 01 Mar 2026 22:35:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I3Q6EV7lricpGGyExmSxujZjRLjA0qY/ftQgdPhNc4yC9JizLyT9c64FMfCYlGnXVqug/cATssfJuocSgAWKBl0tf62wUFp8BwLnU6DjMhWQg82L5nWaiKyP3v/Y1JKjPT5re7iaxo7eB1ZSxvqJqa+mX6eoD2VywMqbtQZd5pEYfiqsQRLs25PhGTCB82Eu8knTM2jDQafq4+jbwzPUujJrkI1ay27GObF47InmX2GaWstPtEbJwQo8fK3aiHHnz6IUgscQL1RqM1ITIDznOHTUIpBgBuYm1kxL+XijXoUc46tZAbw1AvJ/rjHidUwuchz7DJfA0ADlxjWQKf0gsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gMEdcgtOloSjPzscxeAzSyh9B5UbylBsl8wFSHs/V8=;
 b=MescfcSz11AfecSJQYDR4Q8st+vtN5S1dmnuWQoaR3JPTpcynURoWre/pE+2wAIZynSfeMo6eVTRSWM7OPbcoOBEVUGdRwKGq3NsWZb1jWYI8uadgby2tjQ2DSR3LxPbq6QZ9kI/KT8hns+Z6b4R0oLwV3j9mdnRSNYemAMdhDLsl/+T0Yv1W2ZE1lKgmukSiCoGgfhw7z4eB842J/1K0mXiMJLyERberiRy/CmA7Za08RmAE4fIycrih2TYeL4TGtwIaRD+S1F6Kca/lBlDutajNqJpo9ODgob5LgyOLMeohNFeScUg4Chh3ndmADuGVQS51qOD/pXoYZ5IR8G9Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gMEdcgtOloSjPzscxeAzSyh9B5UbylBsl8wFSHs/V8=;
 b=UIRSOddc6yudb6g5MCsJ2W2noiWt6Ize9Ql1fss1TYunlyqSTlGRPYBaLMILZA7Vu2MxHc8A6fZdg+72n3bFhz/u4s3EHQ8EArahS5T41zNiXC1VwSfWM/zozUghuoDafseINOiJ9YqoGhDzUSoNYcu/vh30qHUf+tzOS9MUXoJtdWke2MgYMxiPz8LgARhYVefmoy2zJrbyQDAaIcUTAvKjio9ZJNsooMjT+GklWulJipORFzi2bJZg+lbp9SQMSDfMeFrIXecar95TNaOTddDV1hHrlODiDq1w62fhWWunGNdGe9Qz67ccDqxlZGEESGUmjjSvMw/rX1iS/FhZOQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB5372.apcprd06.prod.outlook.com (2603:1096:400:203::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 03:35:25 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 03:35:25 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Jithu Joseph <jithu.joseph@oss.qualcomm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:ARM TCG CPUs"
 <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>, "komlodi@google.com"
 <komlodi@google.com>, Titus Rwantare <titusr@google.com>, Patrick Venture
 <venture@google.com>
Subject: RE: [PATCH v7 18/22] hw/i3c: Add Mock target
Thread-Topic: [PATCH v7 18/22] hw/i3c: Add Mock target
Thread-Index: AQHcpfwz6dtr4P+XREmLu/9O1ZNFdLWVyO2AgATWKtA=
Date: Mon, 2 Mar 2026 03:35:25 +0000
Message-ID: <TYPPR06MB8206161FCD799923A1B37491FC7EA@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
 <20260225021158.1586584-19-jamin_lin@aspeedtech.com>
 <c904f61d-b836-41e2-8032-31ea32324396@oss.qualcomm.com>
In-Reply-To: <c904f61d-b836-41e2-8032-31ea32324396@oss.qualcomm.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB5372:EE_
x-ms-office365-filtering-correlation-id: 9e3b4b8a-d98b-43f8-e62d-08de780cbdf8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|921020|38070700021; 
x-microsoft-antispam-message-info: D2oedC9NGtADkyfViljgz59lrRydvbrTWlu2fKXQis7K/FjXCE39VHhPUN06gDIF+Nu/Omj5WK40sBH+jTq1vnBQiqb/ZH+FadDZiRXYOl8i+LTmrWA0w0rVfYiggTJpHfbM6CBlDXzPfq0LzlOAclFxbyRXKOEzuEycGuEcD/RLRiyf1A4zO9lbVXglY05MS/erPaxWhLNgWUZBMAGbjyHWfhvTVig2WCdksk3nBD0T7/2koGYtmqeeHdHtUEJPLEL3jRHSrZPsIhFCzKsJ5pIyQQXLMs/x45FjqKoUwkBLMta9ZzX2ASBachp4apeZ21AT8MAQB1BoSeG9TnA+S1zhMByS3QZssFG4gJotz/+sB+uTVfTbIhv+qfxEccR8dWqmWLAeytwVsupfnQtrHEU5cbD2QBuN/+Ds2n8jyNyiekiNkTyXUMDNt+w95GA1kKH2rlX7gunstywfQPGYYH9QgfQynXpqHc+S85rEK4AhiwK76Ac91y57nHj5GGTLjS3NS49YuQO194UwIdffzxzCoY2MHha6ML4Iqj+s9R6zlBBY3z0Z/kdHDns6yP5K8womOgQbqMmXTvyBuO82bo/SCZgNZTnv7gcYKt4fYdzm20hWKYVtoMqzJL8QXcM/G/p8iGMz0MQDJ7WU1TUyAozuBuQzdnxqeV31EQhZWjdKg7bXrE4VJGX4o3CrPkcar6EoP67MBV+e+MmYWLCpqpsskziLmlFU6OA/W5vn54NA+fH7V6aI7SndEUb+9SOghR0+PNy3/Pgm743ccT3Hx2B+Hhjdv/4+Bwet5Mk3hlp6WasQiJWDBFxp0nakWD7V
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajJhUW9YbEQrcFNZbjNlNWhObkQxdmVqY3lDS0ZDSmhob0J6K28rYnZGV0l1?=
 =?utf-8?B?Q1BKazVYYklERUdjUzFRT2hwUjBCNXEwN1k4d0QzZGVab0xySllVS2NFeEdM?=
 =?utf-8?B?cDJNZjRTU0JBSlRyczQ0VWl3THl3OGFWQ3FhK2RYaWhrMGtKM3BiL1RoUlRP?=
 =?utf-8?B?MFRQZVdYdDFVaUdyZDNpVDZGdWo2VUo5M21yKzA3OXcwTXdVWUc0YTd2eDhn?=
 =?utf-8?B?Zmpyd3ZSV1ptZUZKRmcwT21SUDl6bmdpcDdnUGpWRHFzSkUxdUZLTUZ4OVVn?=
 =?utf-8?B?SFZXMEpQc29lc0pPV0dvb2tLUUVVYjE1UGM2V0lZejY1Mk9xWnBLR3JmcVBk?=
 =?utf-8?B?V3VQNHA4ZVN4SDZRbTQ3SWFYakQyUUVidGJSZ3BGTXJTOFRoaXFOYkNZZ1gr?=
 =?utf-8?B?VWdVaWxicWxUaEExVkJuZHhka3B4ZlR4VmE5cmw5UGVpdEM3V2YxemExUGpG?=
 =?utf-8?B?RmovanZXckY1cGROSUViN1JmK2t2a0JpUklqSHcrcmgvSkI1RE1NK0lFWUJv?=
 =?utf-8?B?T0RBY2U0RnpmalptWWlvMHZPV2JFejNaUVZBMlBqK0x0cDhYWU1aSys5RE5E?=
 =?utf-8?B?V1pINkIwdGJOMEx0NjJlTGRjRjRpamRNaUdPOEpLYjNYM2tQZWtFeUUyT2kz?=
 =?utf-8?B?SUJwRXFBcXJuenJqMGxiSGJyM2FoREtodW5LeW0rN0xBbCtyOU01M01LZU0z?=
 =?utf-8?B?QkpDNVlvdjBtdWZxeXEwTXFZclhSMXJsNEdKWG5MNFNXZU12aUEwQ1lPRlRy?=
 =?utf-8?B?Q0E4NmhIaDNGTzk4cUNlaFpRSUlOakI3VVdTT2w1b3d3ODRVcTdjWktwRTV1?=
 =?utf-8?B?bnpPY1Rjem54c3dxMG04RE9DL3JUeFpVbVhyaURpcThoTVJVRkgwN2NLc2to?=
 =?utf-8?B?LzNSZXVDYVlqQmVGRzJXOC9sYlVPazZ1WXhyT3RSMW1IL0Noa3VZR25VR2Fq?=
 =?utf-8?B?V1VsbVRiNEVwNmJQNis4MVQyTGxvbnoxNVRvNkZVdFlrNDBzMlpTdjFSSlhE?=
 =?utf-8?B?YzVsVTRkUFpWZlBidEhOdmlOYVVTaDZrdVAwQ2dQWEppTUo0T2FVR2Qya25k?=
 =?utf-8?B?Qy8vbzYwbk15ekVIeWgvOThmd3R5Nm9PcFIwUko3a1lCd3g3dG5mb09EdkVv?=
 =?utf-8?B?OFFxbjBDWlhncmU2TXNqZ0VnN0dERmR0Q1p0VEZJazJtWkdHbGNWNWk2dklG?=
 =?utf-8?B?cys0VnVDRFF1aEkweGV4bDNENXllRENldVhOeTdMWjNOR050NGRDRlJWTTgv?=
 =?utf-8?B?QmxUN1RzZEtUaThwa1Y3WE91bmFpb0lSQzdnSkJKN09xV2lGWlhJMjUwYTZ1?=
 =?utf-8?B?YWw3eDhlc1JJMlZPSkw0bitiN2gxUTN0YkZNQjhiSTY2MmtZR25nRmpSQUpz?=
 =?utf-8?B?Vzd3QmNlZHQvRFlCdXpOUHU2b2ZDMUovT2JPRkxDclAwak5CQ2MzcGR2ZXR4?=
 =?utf-8?B?MElhMU85eEpwNE1jSmF1dkluMGpXUU9ZOFVocENRL1Exam53emptYWlmWjhh?=
 =?utf-8?B?dE9kTXFmRFcwa3AxbWIzSmNGMjhXeG1ZU1lKUzk3Zi8vZ091d3QwRnkxeGUw?=
 =?utf-8?B?OUFxUUlrREk4L1VKZ1hCOGlQT3Y5R0hZZzg5NXlSa0prc0xDbUlLaHdKTVJZ?=
 =?utf-8?B?VVRxQzYvcU0vWUIvUkl0N3pra3pONm5TV3FtS0h2bzQvZFdueUkwOEtqcnF1?=
 =?utf-8?B?RWE3SGw0WlZ5N2FwWHJiMnpBTE1vaXhQNE1TMnkvY0F6QzNSV2srb3RvamlY?=
 =?utf-8?B?M0Y5RCtkb0JxTSt6ZG1vS3A5WWI3K0xPK2IxUU51NGFpTjNOeGZQajJQNmpK?=
 =?utf-8?B?Q2Jzb0ZFU1dTai81ZXI4cEJiTXFVY250Y2dpNVZhVW9JN2V3cWcxNGowbUJC?=
 =?utf-8?B?T2kvOWg1Rk9hM0pOaWtVSWtCaWFiNHJrMkpxc2NlR0RVUVFGdnA4Y1owSGkv?=
 =?utf-8?B?ZDk5d0trakp0L2JudWsyNll0cm9xbklJMFVhZXZINFI4UktlTUQ3TEs1TEFX?=
 =?utf-8?B?bzY5RWlKTzdvdnhKZDhodjlrSlY0cmZEQ1orYlpWV2pZV2I2RGplellYcmZS?=
 =?utf-8?B?OHdWVVU0cStHenpqN1lOWjhOS1g3cEw5Vzlqb3NZYXRUMGxkWFo0bjVYeUNr?=
 =?utf-8?B?d1hDK0NSY0g3aUdoYytkaFZSUkNNTW1TVHlqSURRbkNxRHZlQXhxZkh1cGRh?=
 =?utf-8?B?WG9MTW1DeTJZbVNHZXlhbXhhaFJ5eWp1dnZyV1ZMYTBQbjRsdzRMNUhWTjNR?=
 =?utf-8?B?V0NjRVlzSklZbnREaW1vZUFzVWVRVjJXdDRZVzdueFhTa0lGWkpYSDV1OTJB?=
 =?utf-8?B?T2VqNS9LRFpMMFlBNnAvcWNPVmgxMjZJWVNoblgvOU92a0VER0JIUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lS8zmcB+fJS1/LLjWpTXteavbMBA2zanQZzdyRPOi3pPH6vfv/4whaqnK6ePS3UzftRyaHljI5KZGH1CgSfc34jBkRozzd6/nQKn/qEQaVCK2YoYtZ6qoLZU3jrB5ArhBMDKC5m/2N8S0TPBICm3Pzld57oW3Pl9asfQ501sqJ+ZM+44WOocehFM3hfNF3f1pJW5pDsAmSdSWgMz2CMSS4HOvuTQX6YHXvsyoI+MKeaspXwPN2XaKdtRcJOk4O5xYBsLzYvH+AA/EhbUBYv9d8+NynZ6dbuHJ1Ue2oSaUXD58xSIUAGvpLIVTzLtjTE93FH8mAfx7Nq0kMqmdXI33A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3b4b8a-d98b-43f8-e62d-08de780cbdf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 03:35:25.5309 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /2RlASF84pvDjuJ47wxZtrCXa+d82msyCQXiY8jByMmRgPraa/whCD1+MdrUSi6X7AbGoEKx/x8WrGtliEhTTRJ4RoGFcuR+Xe769hYMUvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5372
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

SGkgSml0aHUgSm9zZXBoDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NyAxOC8yMl0gaHcvaTNj
OiBBZGQgTW9jayB0YXJnZXQNCj4gDQo+IA0KPiBBcG9sb2dpZXMgZm9yIGNoaW1pbmcgaW4gdGhp
cyBsYXRlIC4uLiBJIG9ubHkgZ290IGEgY2hhbmNlIHRvIHRlc3QgdGhpcyBsYXN0IHdlZWsNCj4g
VGhpcyByZWFsbHkgaXMgYSBtaW5vciBjb21tZW50IC4uLiBjYW4gYmUgYWRkcmVzc2VkIHN1YnNl
cXVlbnRseQ0KPiANCj4gT24gMi8yNC8yMDI2IDY6MTIgUE0sIEphbWluIExpbiB3cm90ZToNCj4g
PiBBZGRzIGEgc2ltcGxlIGkzYyBkZXZpY2UgdG8gYmUgdXNlZCBmb3IgdGVzdGluZyBpbiBsaWV1
IG9mIGEgcmVhbA0KPiA+IGRldmljZS4NCj4gPg0KPiA+IFRoZSBtb2NrIHRhcmdldCBzdXBwb3J0
cyB0aGUgZm9sbG93aW5nIGZlYXR1cmVzOg0KPiA+IC0gQSBidWZmZXIgdGhhdCB1c2VycyBjYW4g
cmVhZCBhbmQgd3JpdGUgdG8uDQo+ID4gLSBDQ0Mgc3VwcG9ydCBmb3IgY29tbW9ubHkgdXNlZCBD
Q0NzIHdoZW4gcHJvYmluZyBkZXZpY2VzIG9uIGFuIEkzQyBidXMuDQo+ID4gLSBJQkkgc2VuZGlu
ZyB1cG9uIHJlY2VpdmluZyBhIHVzZXItZGVmaW5lZCBieXRlLg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogSm9lIEtvbWxvZGkgPGtvbWxvZGlAZ29vZ2xlLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTog
VGl0dXMgUndhbnRhcmUgPHRpdHVzckBnb29nbGUuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBQYXRy
aWNrIFZlbnR1cmUgPHZlbnR1cmVAZ29vZ2xlLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogSmFtaW4g
TGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFtaW4g
TGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gIGluY2x1ZGUvaHcv
aTNjL21vY2staTNjLXRhcmdldC5oIHwgIDUyICsrKysrKw0KPiA+ICBody9pM2MvbW9jay1pM2Mt
dGFyZ2V0LmMgICAgICAgICB8IDI5OA0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
DQo+ID4gIGh3L2kzYy9LY29uZmlnICAgICAgICAgICAgICAgICAgIHwgIDEwICsrDQo+ID4gIGh3
L2kzYy9tZXNvbi5idWlsZCAgICAgICAgICAgICAgIHwgICAxICsNCj4gPiAgaHcvaTNjL3RyYWNl
LWV2ZW50cyAgICAgICAgICAgICAgfCAgMTAgKysNCj4gPiAgNSBmaWxlcyBjaGFuZ2VkLCAzNzEg
aW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9ody9pM2MvbW9j
ay1pM2MtdGFyZ2V0LmggIGNyZWF0ZSBtb2RlDQo+ID4gMTAwNjQ0IGh3L2kzYy9tb2NrLWkzYy10
YXJnZXQuYw0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvaTNjL21vY2staTNjLXRh
cmdldC5oDQo+ID4gYi9pbmNsdWRlL2h3L2kzYy9tb2NrLWkzYy10YXJnZXQuaA0KPiA+IG5ldyBm
aWxlIG1vZGUgMTAwNjQ0DQo+IA0KPiAuLi4NCj4gDQo+ID4gK3N0YXRpYyBpbnQgbW9ja19pM2Nf
dGFyZ2V0X3R4KEkzQ1RhcmdldCAqaTNjLCBjb25zdCB1aW50OF90ICpkYXRhLA0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBudW1fdG9fc2VuZCwgdWludDMyX3QN
Cj4gPiArKm51bV9zZW50KSB7DQo+ID4gKyAgICBNb2NrSTNjVGFyZ2V0U3RhdGUgKnMgPSBNT0NL
X0kzQ19UQVJHRVQoaTNjKTsNCj4gPiArICAgIGludCByZXQ7DQo+ID4gKyAgICB1aW50MzJfdCB0
b193cml0ZTsNCj4gPiArDQo+ID4gKyAgICBpZiAocy0+Y2ZnLmliaV9tYWdpYyAmJiBudW1fdG9f
c2VuZCA9PSAxICYmIHMtPmNmZy5pYmlfbWFnaWMgPT0NCj4gKmRhdGEpIHsNCj4gPiArICAgICAg
ICBtb2NrX2kzY190YXJnZXRfaWJpX3RpbWVyX3N0YXJ0KHMpOw0KPiA+ICsgICAgICAgIHJldHVy
biAwOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiArICAgIC8qIEJvdW5kcyBjaGVjay4gKi8NCj4g
PiArICAgIGlmIChudW1fdG9fc2VuZCArIHMtPnBfYnVmID4gcy0+Y2ZnLmJ1Zl9zaXplKSB7DQo+
ID4gKyAgICAgICAgdG9fd3JpdGUgPSBzLT5jZmcuYnVmX3NpemUgLSBzLT5wX2J1ZjsNCj4gPiAr
ICAgICAgICByZXQgPSAtMTsNCj4gPiArICAgIH0gZWxzZSB7DQo+ID4gKyAgICAgICAgdG9fd3Jp
dGUgPSBudW1fdG9fc2VuZDsNCj4gPiArICAgICAgICByZXQgPSAwOw0KPiA+ICsgICAgfQ0KPiA+
ICsgICAgZm9yICh1aW50MzJfdCBpID0gMDsgaSA8IHRvX3dyaXRlOyBpKyspIHsNCj4gPiArICAg
ICAgICB0cmFjZV9tb2NrX2kzY190YXJnZXRfdHgoZGF0YVtpXSk7DQo+ID4gKyAgICAgICAgcy0+
YnVmW3MtPnBfYnVmXSA9IGRhdGFbaV07DQo+ID4gKyAgICAgICAgcy0+cF9idWYrKzsNCj4gPiAr
ICAgIH0NCj4gDQo+IA0KPiBudW1fc2VudCBpcyBuZXZlciB1cGRhdGVkIHByaW9yIHRvIHJldHVy
biwgc28gdGhlIHRyYWNlcyAoZnJvbSBjYWxsZXIgaTNjX3NlbmQpDQo+IGxvb2tlZCBhIGJpdCBj
b25mdXNpbmcNCj4gDQo+IDxzbmlwPg0KPiBtb2NrX2kzY190YXJnZXRfdHggSTNDIG1vY2sgdGFy
Z2V0IHdyaXRlIDB4MTINCj4gaTNjX3NlbmQgSTNDIHNlbmQgMC8xIGJ5dGVzLCBhY2s9MSAgIC0t
LS0tLS0tLS0tLS0tLS0tLS0tLT4gaW5zdGVhZCBvZiAxLzEgYnl0ZXMNCj4gbW9ja19pM2NfdGFy
Z2V0X3R4IEkzQyBtb2NrIHRhcmdldCB3cml0ZSAweDM0IGkzY19zZW5kIEkzQyBzZW5kIDAvMSBi
eXRlcywNCj4gYWNrPTEgPC9zbmlwPg0KPiANCj4gU29tZXRoaW5nIGxpa2UgYmVsb3cgaXMgbmVl
ZGVkDQo+ICsgKm51bV9zZW50ID0gdG9fd3JpdGUNCj4gKG1pZ2h0IGFsc28gbmVlZGVkIGluIHRo
ZSBpYmkgbWFnaWMgcGF0aCBhYm92ZSkNCj4gDQo+IA0KPiA+ICsgICAgcmV0dXJuIHJldDsNCj4g
PiArfQ0KPiA+ICsNCj4gDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcgYW5kIHN1Z2dlc3Rpb24u
DQpJIHNlbmQgdjEgaGVyZSwgaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L3Fl
bXUtZGV2ZWwvbGlzdC8/c2VyaWVzPTEwNTk3NTcgYW5kIHJlYWR5IGZvciByZXZpZXcuDQoNClRo
YW5rcywNCkphbWluDQoNCj4gVGhhbmtzDQo+IEppdGh1DQoNCg==

