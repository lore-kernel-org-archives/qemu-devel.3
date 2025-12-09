Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C533D3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 10:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSun1-0000IP-4Q; Tue, 09 Dec 2025 05:17:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vSumx-0000H7-GK; Tue, 09 Dec 2025 05:17:47 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vSumu-0007ho-KG; Tue, 09 Dec 2025 05:17:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yfC8vlHWH+OCV4pbFe2ig8hbDqt8p1z0opaLYz3+Kp0DcsS+t5nq1lnX4yCI7gYmhweatvXK3+mPYqWJXyd7NlZaE0wid7JtaDC6fp4Nu7GGWtBOSaQokELjk7XIE/yAeLsCnREsVkiVZBDyOfoXu1VdYOubsb9IeJiRIUh/LBr0V5gKXUP95N2YJraivg6POQ81wX1AE2Mjgn08zAPTBbraODI96GWXndC+n0wdpjXgic8iNRN4mOA/0VfEntrWyIXb+35fYUT9UrPP5gozuaHA4XjH9aSaL4rg52E5W27MnSGtd1p81xSis/+JEipN/wwRa+hc0Jfh/29PImV2jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvXIZEDvJeOh2yII63KEH7I/3ICg7BsHmVsNF646T48=;
 b=Q/Bhf3XqSTs5cDGp4npOfzJL4WAZQDo8sGo320LOCQ7PfYl11aaAQLkzKjaBL8PA9Ws+9nbRHY4xgVUgILswFooJYwl3HC8IBihNZDoso/JK7Etsb5OzXunZm7WP1oNmmv75CcBibOd6gqA+0+qy5sgj9NfbGgB6srOlQ5pZMzCo7pFkTkX+WnZAg5QwmLAyaq+cLO2T2zxeveuag6tyRBzSsjE6PPm7GSRFyexee0zbvVogM0/WtAWwsMCDIasZC5/k78n0Z8amWvz0tzgO22zlhq7+oJE+4ZEOmVCBOc1F7R+HCoAuAdw4tWBGSjheyDnEeddu7wAwftdxBHpTrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvXIZEDvJeOh2yII63KEH7I/3ICg7BsHmVsNF646T48=;
 b=Tj0NqnG7EaWxPPDH5c5P0bhvhMTB0+PrlEKVTvF8H/D5lQE2Tql4ZV8MTRQZM9CtPMxf8tw3gOEgNSlxHNErtd509oLo5VbQ5wWBvOWtVWdJ/S+jgcbhaImEDpqXnnS5PvzEAT9dMPjEyY7uD0CPWQYZ7f9Rmg8Vm/JiKw5rPDglwSfOo1yVIBAaxskK5T69795xse8K9a21dvYy2PgA2JSv+fX1BqCak2y01DROLfuRN3n47Oe7vlS2jc9lNl6J7aTINUkikh9DhfN1enHDu8MDkN5AM9eFjGVQD9mSIymvgGZJCnjqeSd3OJzKyZ84Es4rGbU/HVJ8m1x8Q7BnFg==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by SEZPR06MB5175.apcprd06.prod.outlook.com (2603:1096:101:72::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Tue, 9 Dec
 2025 10:17:35 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca%6]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 10:17:34 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Nabih Estefan
 <nabihestefan@google.com>
CC: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>, Troy Lee
 <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v3 17/18] hw/arm/aspeed: Attach SGPIOM device to AST1700
 model
Thread-Topic: [PATCH v3 17/18] hw/arm/aspeed: Attach SGPIOM device to AST1700
 model
Thread-Index: AQHcaBaMGpOEPelOUkq2whAOlbhSdrUYDsGAgADyaQCAABd0UA==
Date: Tue, 9 Dec 2025 10:17:34 +0000
Message-ID: <SI6PR06MB7631AAA39D7A4638DBCDA191F7A3A@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20251208074436.1871180-1-kane_chen@aspeedtech.com>
 <20251208074436.1871180-18-kane_chen@aspeedtech.com>
 <CA+QoejXUfmJfuWSPndkuF=Dqu7QBJF7ACgH90Wmfshr4+3pDoA@mail.gmail.com>
 <1891c6bf-9dfd-429b-9fdd-130233a01d96@kaod.org>
In-Reply-To: <1891c6bf-9dfd-429b-9fdd-130233a01d96@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|SEZPR06MB5175:EE_
x-ms-office365-filtering-correlation-id: d51354b9-55a3-452f-edc5-08de370c2bd6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?eFp1WWtDN0c5cWVaalRuYjQ5djY5ZlptcVU5YjVIYzd5Z1lwUWhZUU9YczV2?=
 =?utf-8?B?ZFFXNjV6MWxPN0tiRmFZVVp2WldreHJuZnZaUGdaUFQwRWJ3WVJwWkJuNVhW?=
 =?utf-8?B?UGMvWDRuZDJVelRZRlJhU2pOUlF4cVptZWlqeDRma29obUJpZ0NEYmtwUE43?=
 =?utf-8?B?dWphRmZFYi82QTh2Umt6cWd3bWlKUCtBTFFKYzBJcmROYmhkTXRlUmMyS3ZP?=
 =?utf-8?B?VzlNVENZVVM1clBTZCtmOEMvalRTSnR4WVFzZktXSVJDUCtwSG9IWTZtVTcy?=
 =?utf-8?B?S1dBU1BLTDgxRGZBdysyR2M3SFV1UGZUTE5IRzBuRG5NYVphVmtzRXU5RHpK?=
 =?utf-8?B?TXFDUEl0Smhrc0o5OHFJaFlLSzA5K094VUpLSi9iYXdnY1BCaVluWWFwRUFx?=
 =?utf-8?B?WVYvZlRLNDZDb1lsMjFYOVQ3WWVsVUNnWnExTWJVNHJ5SWVnNHRaeS9oQmxS?=
 =?utf-8?B?Rk1IYkx4c2lyT3NxaHJ2NU5xRCtPZWhpWGM1Um5saGRSV0dOUnl6MzUrZWdn?=
 =?utf-8?B?Smtvd0JJWmJ5S2hMSCtvS0lxck9EWlFhWHI5VmJSVTFjSEpRSjN6RzZaVGNI?=
 =?utf-8?B?ZlAwcFNkMEpKMSsvUWlORGZtQStiZFB6TG9CanRoNUhtYkVMQ05PRXNHK21O?=
 =?utf-8?B?d3FqTmRJUnloREZhNjVYV1B0TzJkY0tXeXViSmRXUEJkTWc5NWNRSTREd0tP?=
 =?utf-8?B?NDQ1RlA2Z2hUOW94a2V4TEFOamJhQ3pRdmRCYllNZXN2Q2VVaFhHZnoxR0M3?=
 =?utf-8?B?SlJkNmcyMkdja29rUXNDZXV4TC9BbmhCbEFIY1VqZjV1OGtndkFaN09DKzBV?=
 =?utf-8?B?N1NjMjIzQ3QxREFzdm14aTZxbGVab0R1T2NxMmIwZS9TWTVsNG82WGEwb3R4?=
 =?utf-8?B?cXZzZHAySmhUYko4SDFCSDBTc0Evek1LeWdhaUJpL1Nwaks1V081bTY2VHdB?=
 =?utf-8?B?OHRqYlc2NnZwbmRWMDBaWkx6YVFNMDJLVVovUjhuM1RZM3hxSGVRaFZLRW5p?=
 =?utf-8?B?Wmx4cmE3a3pVTUNuL0hoaDhvNkxIZDNuNWdVRVVSWDhrWWFoakt3UG52dFJw?=
 =?utf-8?B?dTdpZ05VZkhoeWcyQzN1bitLOGR5U05LVTN3KzdLUExOS1lOTDBCR3NOMXM3?=
 =?utf-8?B?cjk3YWFmMHFGRFVpTEtSUmRJaGs4TUh4aXhSbzZVUktISXNIUDNxbW16d2U4?=
 =?utf-8?B?b3hwcit5MFZuWmJhVDl4c3ArZDcxUktuaE5NeEc5NVBsRExoVFJCdjJwSGFp?=
 =?utf-8?B?dHRQdndzSlREQnZSbEFYQUdNNytibmZlNXRnUjcxRkk4NzVENzgyRXRFR3Fy?=
 =?utf-8?B?N1NjL1hYaG9GTmZwUi94SGRnUFh0Wmx3M3ZicVA2b1B5UzZhRU1wcVBSUTV2?=
 =?utf-8?B?UGMwSHp4Vjhia1BkOXVnQVhacGVsQ2tjTHhLS3N0OFo1Nk1BNk56U3d2VHB4?=
 =?utf-8?B?V2FOMXZqTEE1YlNMRXlCOW9JZUxKaUZxQW5MbVMzYUFkMkV1aXBSTk5YRGtT?=
 =?utf-8?B?M1B1Syt3K0FsbG9ITUthbEtja09DbXdORzhEcGJNQWcyOTJFQjN4TTJ2Vmhy?=
 =?utf-8?B?NnRsb2NOd2FQekEyZTJBQ2FReGQvU3JnelQ0cFpyMS9MUDEreWFSSTdtTitT?=
 =?utf-8?B?WnF4V3RQeTFJa1R1Q1FXaWwxdFBDMHE4Ui8xTmJEclVTakNBdzVjaFhLeXV6?=
 =?utf-8?B?Z3plWmd2ZjdCaS9HYVo2V3F0RzVmL203TUNOOGxjZGplWEtINFFQVmtTSk9i?=
 =?utf-8?B?UWFRQWxoektlejhGc2c3YnI2dnhRUFJ3TTNwWEZJT203Uzh4SGhRaHUwRDFm?=
 =?utf-8?B?dGdBMlAwdjJEbFU4akRTRGpiV0FlRjV6aHNZMnZscjBGbCtOVjhEazVJV2hx?=
 =?utf-8?B?UlFBWTBxbUF5V1dEYVE3cEV2TUo3YTVUeHE5N1V6UHFPdk41VGlKdjVCV1BY?=
 =?utf-8?B?SktIaXNtemNlRG14ZHlZY2hIRkhZVGRCWDkrMEF0WkpZT01SdXI2ZkJHcVBs?=
 =?utf-8?B?VXhseFRaNHZZOHFSYzZjQ2FMYWltMXFWWGFJdHBnbjJtQU01YWNOallFUDFi?=
 =?utf-8?Q?65Agwt?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDBtSzRiZ1NneSswZXo4NENSTVZNSVNTRVlFSk5VRGw3R3NoMGR6bHZpb3F1?=
 =?utf-8?B?SmJlQ29pcWhJSzE5Tm1JREZlMll5cWc3T2pZcnE3dHNjZzJ6c3pjOWZCT09z?=
 =?utf-8?B?WmUrYnRBc0VPN25QblRIZ1g2RzEzMURMYmZONUttSzJjYTdSaWEyVG9BcjAz?=
 =?utf-8?B?V0RVQ3lNMUI4Qk1mZEt4dFYvWGxtVFpaT3lHUmU1cmxBenovTnRWbUNDUEty?=
 =?utf-8?B?VlltS0s5cWxIZENSL3BuNnFPVGo3QS81Q2dueUhEMGx3c0VBR0hEbVZZN1VB?=
 =?utf-8?B?c1RHaDFzbnp5Rmk1eXJJeS95NUtYd0NqOWRibTltYjBlZlgwVVNLOU9pL3pB?=
 =?utf-8?B?VytkQmlpNGdVT2lMU25tcG9Gb0Y4V0ppekdxeFhReEUwcnRaKzFwbmU5c0xr?=
 =?utf-8?B?L1Bsb3M2YXlFRmpoVXVDZTI4cE9WTjg1TEI3RlJkU1JrN0FCdWJneUVSaGZB?=
 =?utf-8?B?ek1HeG1XR0k0bUt3Z2Z3bTBpbEFObnppbU9UZGJjSFNLbjlsbUFsSXpPTUVP?=
 =?utf-8?B?d3lyclM3V3RlVGlQTHJLcmtoUVdud0MxeWhZZWgydEhoT2lZRWwzOFprVVNU?=
 =?utf-8?B?VjlLWCt6blVxbkR2YU4wcXBlYVoxSXVEOUVBZmFMVDJkZkMrbkU5MithOTc5?=
 =?utf-8?B?NzJTcThoaEZZektHUS9uMXMrMFl0QlRZZitSY0RuZGJiSXFsY014clREMnZF?=
 =?utf-8?B?a3VOWGxSZHNnaThVSnRWUWEzcFVxSXZOYTVxUUw0eXZORWVNWkFqcG1oQmZk?=
 =?utf-8?B?YjlZUHhrQ1AyeklGS2cyb3ZyajdyNDZGR3ZaNHpxanRkeWMrRXdhNzdwMDJG?=
 =?utf-8?B?aDBXclAzTzg5VjhJblRiZXcybnArdktJWlkxQzdjdk5DUUU1blpLSlZ2dlNu?=
 =?utf-8?B?S0ZLZ1FQQ25aaXEyb0xldTY1eWoxeWdOUmtTQUh0Q0h4WlBBOEltVEovWjNx?=
 =?utf-8?B?alkzckNYaTdSV0FGWGhjK0hyNUo4a0lIUFdUcklDbk80SEZ0ZWlmQy9Bc0RS?=
 =?utf-8?B?L21saDZqQjR2OUF4OVhFTzV3SHM1dnRmbFN6TnloOWVqdEdhWUVOVVlEM0RR?=
 =?utf-8?B?bHJCemJobDZsUG1sd2J4TkN2b1FsL3FOcjNWaWU2QUxoeE1rUjVMUWMrNVhZ?=
 =?utf-8?B?aVdUMHFsWkRjSlpHbXM5TENya0Q3eUNHSk1xMHFLRUtuR1RJeHo0WG9XditY?=
 =?utf-8?B?QnB2UmgwNWRsbG1hQ3lETDdjYkwvcmxTNmxTaDcrK213NzZnUTlRcjRxckRh?=
 =?utf-8?B?QUtVUFFBaUV2UVlIeFVBLzk1RzAvK3B1UER0UXBMcmd4d1plQURnL2l5OVVm?=
 =?utf-8?B?RWRiWktXd0x5T0dmUTZGRis2QWlJUDNuUktsaGtweXNJZ1AyYXNaWSs2b0pp?=
 =?utf-8?B?U1Rsa1d1NmVMczhTMnFNS1ZlNXlYYTZPckp1aEVDd1M5UkZBbHpSbnpIVjAw?=
 =?utf-8?B?eEhja0ZDQjMwZ0s3SWVrc3NuZlQ2TjMyOEVVc0hWNnNQVXF1TEpLaVV6MHlW?=
 =?utf-8?B?NzFLaEU4UDNrUW5nenpha0NtSFNUdUxNSC96YjJPRElzMUQ0alYzYnM0ZDZB?=
 =?utf-8?B?dmlEVHRLV1EvcVBQMXRubkxPVnZUeXI3U3JObjBtY0JoaDMyVE9SaXRCWUJv?=
 =?utf-8?B?OEdqMVhRcDYvWUprcVlHZyt5VmdHTm15cnhNNzRWcVE1SmVEU1hkWlBRQk00?=
 =?utf-8?B?SUUyNERJZHk4T3JIdER3Wnl0SnlxZXhjdnRYci9CRWh5UjJMaU5BUlVwTFVF?=
 =?utf-8?B?SVg3WU8rT3F6cUp2dzVqTmJTZ0N4bU5RZUNXd3U1WUF6V3BzNjFVOVZVOEFH?=
 =?utf-8?B?eTE1OVRCVG5OTUNub29vSHN6Mzdhc1ZDWUhOazJOdk9rdW1lY0xFTDkwMDNm?=
 =?utf-8?B?NE1IOXBWREs4SEU1YUR5WStYWGthQUY0RUhrN0VxSTVhK29iV2xiWSsrZzA3?=
 =?utf-8?B?VnkzUmxlempPK0d4NzFDTHg2Q0o5UTJsVk5HWmFmSUwra1pFYTl5NWxwNzhH?=
 =?utf-8?B?ZFhWak9OYTMzaEF4akxJTUU0Vm9pQXFhRHQ0VmpwRDBpN3hjL3BKRGlDWUlT?=
 =?utf-8?B?TWNvME9mNSt4MmRRUXRYUnBsdnc4UjkzYkhqRXMydnpJcXU0L3JjMWRKUjlo?=
 =?utf-8?Q?1nCyuCpYD2uWaDQC+AbPrd//y?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d51354b9-55a3-452f-edc5-08de370c2bd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2025 10:17:34.7586 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eFgZL4/CbPGuYJT93XoXh1o6i1Q2jjygR2reiD7Hv3scVHZ6jYb9WN/X+t/Jr+51zBjdAqIMKg3FboBmIwSREPdsSV4GFTUigc1VAvO5ey8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5175
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=kane_chen@aspeedtech.com;
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8
Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBEZWNlbWJlciA5LCAyMDI1IDQ6NDkgUE0N
Cj4gVG86IE5hYmloIEVzdGVmYW4gPG5hYmloZXN0ZWZhbkBnb29nbGUuY29tPjsgS2FuZSBDaGVu
DQo+IDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+DQo+IENjOiBQZXRlciBNYXlkZWxsIDxwZXRl
ci5tYXlkZWxsQGxpbmFyby5vcmc+OyBTdGV2ZW4gTGVlDQo+IDxzdGV2ZW5fbGVlQGFzcGVlZHRl
Y2guY29tPjsgVHJveSBMZWUgPGxlZXRyb3lAZ21haWwuY29tPjsgSmFtaW4gTGluDQo+IDxqYW1p
bl9saW5AYXNwZWVkdGVjaC5jb20+OyBBbmRyZXcgSmVmZmVyeQ0KPiA8YW5kcmV3QGNvZGVjb25z
dHJ1Y3QuY29tLmF1PjsgSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47IG9wZW4NCj4gbGlz
dDpBU1BFRUQgQk1DcyA8cWVtdS1hcm1Abm9uZ251Lm9yZz47IG9wZW4gbGlzdDpBbGwgcGF0Y2hl
cyBDQyBoZXJlDQo+IDxxZW11LWRldmVsQG5vbmdudS5vcmc+OyBUcm95IExlZSA8dHJveV9sZWVA
YXNwZWVkdGVjaC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMTcvMThdIGh3L2FybS9h
c3BlZWQ6IEF0dGFjaCBTR1BJT00gZGV2aWNlIHRvDQo+IEFTVDE3MDAgbW9kZWwNCj4gDQo+IE9u
IDEyLzgvMjUgMTk6MjEsIE5hYmloIEVzdGVmYW4gd3JvdGU6DQo+ID4gT24gU3VuLCBEZWMgNywg
MjAyNSBhdCAxMTo0OOKAr1BNIEthbmUgQ2hlbiB2aWEgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4N
Cj4gd3JvdGU6DQo+ID4+DQo+ID4+IEZyb206IEthbmUtQ2hlbi1BUyA8a2FuZV9jaGVuQGFzcGVl
ZHRlY2guY29tPg0KPiA+Pg0KPiA+PiBDb25uZWN0IHRoZSBTR1BJT00gZGV2aWNlIHRvIEFTVDE3
MDAgbW9kZWwuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IEthbmUtQ2hlbi1BUyA8a2FuZV9j
aGVuQGFzcGVlZHRlY2guY29tPg0KPiA+PiAtLS0NCj4gPj4gICBpbmNsdWRlL2h3L2FybS9hc3Bl
ZWRfYXN0MTcwMC5oIHwgIDMgKysrDQo+ID4+ICAgaHcvYXJtL2FzcGVlZF9hc3QxNzAwLmMgICAg
ICAgICB8IDIwICsrKysrKysrKysrKysrKysrKysrDQo+ID4+ICAgMiBmaWxlcyBjaGFuZ2VkLCAy
MyBpbnNlcnRpb25zKCspDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2FybS9h
c3BlZWRfYXN0MTcwMC5oDQo+ID4+IGIvaW5jbHVkZS9ody9hcm0vYXNwZWVkX2FzdDE3MDAuaCBp
bmRleCA3MjkyNzE5ZGMyLi40OTBmMmEzYjA1DQo+IDEwMDY0NA0KPiA+PiAtLS0gYS9pbmNsdWRl
L2h3L2FybS9hc3BlZWRfYXN0MTcwMC5oDQo+ID4+ICsrKyBiL2luY2x1ZGUvaHcvYXJtL2FzcGVl
ZF9hc3QxNzAwLmgNCj4gPj4gQEAgLTEyLDYgKzEyLDcgQEANCj4gPj4gICAjaW5jbHVkZSAiaHcv
bWlzYy9hc3BlZWRfc2N1LmgiDQo+ID4+ICAgI2luY2x1ZGUgImh3L2FkYy9hc3BlZWRfYWRjLmgi
DQo+ID4+ICAgI2luY2x1ZGUgImh3L2dwaW8vYXNwZWVkX2dwaW8uaCINCj4gPj4gKyNpbmNsdWRl
ICJody9ncGlvL2FzcGVlZF9zZ3Bpby5oIg0KPiA+DQo+ID4gQXMgZmFyIGFzIEkgY2FuIHRlbGwg
dGhpcyBkZXBlbmRzIG9uIFl1YmluIFpvdSdzIFNHUElPIHNlcmllcyAobGluayBiZWxvdyk/DQo+
ID4gRG9lcyB0aGF0IG1lYW4gdGhlIHNlcmllcyBsb29rcyBnb29kPyBDYW4geW91IHJlcGx5IHRv
IHRoZSBzZXJpZXMNCj4gPiBpdHNlbGYgaWYgaXQgaXM/DQo+ID4NCj4gPg0KPiA+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnLy9xZW11LWRldmVsLzIwMjUxMTA2LWFzcGVlZC1zZ3Bpby12MS0wLWIw
MjYwOTMNCj4gPiA3MTZmYUBnb29nbGUuY29tDQo+IA0KPiANCj4gTmFiaWgsIEthbmUsIEphbWlu
LA0KPiANCj4gQ291bGQgeW91IHBsZWFzZSBoZWxwIHJldmlldyBZdWJpbidzIHNlcmllcyA/DQo+
IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0KDQpJIHdpbGwgdGVzdCBZdWJpbuKAmXMgc2VyaWVzLCBh
bmQgSSB3aWxsIGxldCB5b3Uga25vdyBpZiBJIGVuY291bnRlciBhbnl0aGluZyB1bmV4cGVjdGVk
Lg0KDQpCZXN0IFJlZ2FyZHMsDQpLYW5lDQo+IA0KPiANCj4gPj4gICAjaW5jbHVkZSAiaHcvaTJj
L2FzcGVlZF9pMmMuaCINCj4gPj4gICAjaW5jbHVkZSAiaHcvbWlzYy9hc3BlZWRfbHRwaS5oIg0K
PiA+PiAgICNpbmNsdWRlICJody9taXNjL2FzcGVlZF9wd20uaCINCj4gPj4gQEAgLTE5LDYgKzIw
LDcgQEANCj4gPj4gICAjaW5jbHVkZSAiaHcvd2F0Y2hkb2cvd2R0X2FzcGVlZC5oIg0KPiA+PiAg
ICNpbmNsdWRlICJody9jaGFyL3NlcmlhbC1tbS5oIg0KPiA+Pg0KPiA+PiArI2RlZmluZSBBU1Qx
NzAwX1NHUElPX05VTSAgICAgICAgICAgIDINCj4gPj4gICAjZGVmaW5lIEFTVDE3MDBfV0RUX05V
TSAgICAgICAgICAgICAgOQ0KPiA+Pg0KPiA+PiAgICNkZWZpbmUgVFlQRV9BU1BFRURfQVNUMTcw
MCAiYXNwZWVkLmFzdDE3MDAiDQo+ID4+IEBAIC0zOSw2ICs0MSw3IEBAIHN0cnVjdCBBc3BlZWRB
U1QxNzAwU29DU3RhdGUgew0KPiA+PiAgICAgICBBc3BlZWRBRENTdGF0ZSBhZGM7DQo+ID4+ICAg
ICAgIEFzcGVlZFNDVVN0YXRlIHNjdTsNCj4gPj4gICAgICAgQXNwZWVkR1BJT1N0YXRlIGdwaW87
DQo+ID4+ICsgICAgQXNwZWVkU0dQSU9TdGF0ZSBzZ3Bpb21bQVNUMTcwMF9TR1BJT19OVU1dOw0K
PiA+PiAgICAgICBBc3BlZWRJMkNTdGF0ZSBpMmM7DQo+ID4+ICAgICAgIEFzcGVlZFBXTVN0YXRl
IHB3bTsNCj4gPj4gICAgICAgQXNwZWVkV0RUU3RhdGUgd2R0W0FTVDE3MDBfV0RUX05VTV07IGRp
ZmYgLS1naXQNCj4gPj4gYS9ody9hcm0vYXNwZWVkX2FzdDE3MDAuYyBiL2h3L2FybS9hc3BlZWRf
YXN0MTcwMC5jIGluZGV4DQo+ID4+IGM5ZDdhOTdhODAuLmUwMjdhZTAyYWQgMTAwNjQ0DQo+ID4+
IC0tLSBhL2h3L2FybS9hc3BlZWRfYXN0MTcwMC5jDQo+ID4+ICsrKyBiL2h3L2FybS9hc3BlZWRf
YXN0MTcwMC5jDQo+ID4+IEBAIC0yMyw2ICsyMyw4IEBAIGVudW0gew0KPiA+PiAgICAgICBBU1BF
RURfQVNUMTcwMF9ERVZfQURDLA0KPiA+PiAgICAgICBBU1BFRURfQVNUMTcwMF9ERVZfU0NVLA0K
PiA+PiAgICAgICBBU1BFRURfQVNUMTcwMF9ERVZfR1BJTywNCj4gPj4gKyAgICBBU1BFRURfQVNU
MTcwMF9ERVZfU0dQSU9NMCwNCj4gPj4gKyAgICBBU1BFRURfQVNUMTcwMF9ERVZfU0dQSU9NMSwN
Cj4gPj4gICAgICAgQVNQRUVEX0FTVDE3MDBfREVWX0kyQywNCj4gPj4gICAgICAgQVNQRUVEX0FT
VDE3MDBfREVWX1VBUlQxMiwNCj4gPj4gICAgICAgQVNQRUVEX0FTVDE3MDBfREVWX0xUUElfQ1RS
TCwNCj4gPj4gQEAgLTM3LDYgKzM5LDggQEAgc3RhdGljIGNvbnN0IGh3YWRkciBhc3BlZWRfYXN0
MTcwMF9pb19tZW1tYXBbXQ0KPiA9IHsNCj4gPj4gICAgICAgW0FTUEVFRF9BU1QxNzAwX0RFVl9B
RENdICAgICAgID0gIDB4MDBDMDAwMDAsDQo+ID4+ICAgICAgIFtBU1BFRURfQVNUMTcwMF9ERVZf
U0NVXSAgICAgICA9ICAweDAwQzAyMDAwLA0KPiA+PiAgICAgICBbQVNQRUVEX0FTVDE3MDBfREVW
X0dQSU9dICAgICAgPSAgMHgwMEMwQjAwMCwNCj4gPj4gKyAgICBbQVNQRUVEX0FTVDE3MDBfREVW
X1NHUElPTTBdICAgPSAgMHgwMEMwQzAwMCwNCj4gPj4gKyAgICBbQVNQRUVEX0FTVDE3MDBfREVW
X1NHUElPTTFdICAgPSAgMHgwMEMwRDAwMCwNCj4gPj4gICAgICAgW0FTUEVFRF9BU1QxNzAwX0RF
Vl9JMkNdICAgICAgID0gIDB4MDBDMEYwMDAsDQo+ID4+ICAgICAgIFtBU1BFRURfQVNUMTcwMF9E
RVZfVUFSVDEyXSAgICA9ICAweDAwQzMzQjAwLA0KPiA+PiAgICAgICBbQVNQRUVEX0FTVDE3MDBf
REVWX0xUUElfQ1RSTF0gPSAgMHgwMEMzNDAwMCwgQEAgLTE0Miw2DQo+ICsxNDYsMTYNCj4gPj4g
QEAgc3RhdGljIHZvaWQgYXNwZWVkX2FzdDE3MDBfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBF
cnJvciAqKmVycnApDQo+ID4+DQo+IGFzcGVlZF9hc3QxNzAwX2lvX21lbW1hcFtBU1BFRURfQVNU
MTcwMF9ERVZfTFRQSV9DVFJMXSwNCj4gPj4NCj4gPj4gc3lzYnVzX21taW9fZ2V0X3JlZ2lvbihT
WVNfQlVTX0RFVklDRSgmcy0+bHRwaSksIDApKTsNCj4gPj4NCj4gPj4gKyAgICAvKiBTR1BJT00g
Ki8NCj4gPj4gKyAgICBmb3IgKGludCBpID0gMDsgaSA8IEFTVDE3MDBfU0dQSU9fTlVNOyBpKysp
IHsNCj4gPj4gKyAgICAgICAgaWYgKCFzeXNidXNfcmVhbGl6ZShTWVNfQlVTX0RFVklDRSgmcy0+
c2dwaW9tW2ldKSwgZXJycCkpIHsNCj4gPj4gKyAgICAgICAgICAgIHJldHVybjsNCj4gPj4gKyAg
ICAgICAgfQ0KPiA+PiArICAgICAgICBtZW1vcnlfcmVnaW9uX2FkZF9zdWJyZWdpb24oJnMtPmlv
bWVtLA0KPiA+PiArDQo+IGFzcGVlZF9hc3QxNzAwX2lvX21lbW1hcFtBU1BFRURfQVNUMTcwMF9E
RVZfU0dQSU9NMCArIGldLA0KPiA+PiArDQo+IHN5c2J1c19tbWlvX2dldF9yZWdpb24oU1lTX0JV
U19ERVZJQ0UoJnMtPnNncGlvbVtpXSksIDApKTsNCj4gPj4gKyAgICB9DQo+ID4+ICsNCj4gPj4g
ICAgICAgLyogV0RUICovDQo+ID4+ICAgICAgIGZvciAoaW50IGkgPSAwOyBpIDwgQVNUMTcwMF9X
RFRfTlVNOyBpKyspIHsNCj4gPj4gICAgICAgICAgIEFzcGVlZFdEVENsYXNzICphd2MgPQ0KPiBB
U1BFRURfV0RUX0dFVF9DTEFTUygmcy0+d2R0W2ldKTsgQEANCj4gPj4gLTE5NCw2ICsyMDgsMTIg
QEAgc3RhdGljIHZvaWQgYXNwZWVkX2FzdDE3MDBfaW5zdGFuY2VfaW5pdChPYmplY3QgKm9iaikN
Cj4gPj4gICAgICAgb2JqZWN0X2luaXRpYWxpemVfY2hpbGQob2JqLCAibHRwaS1jdHJsIiwNCj4g
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnMtPmx0cGksIFRZUEVfQVNQRUVEX0xU
UEkpOw0KPiA+Pg0KPiA+PiArICAgIC8qIFNHUElPTSAqLw0KPiA+PiArICAgIGZvciAoaW50IGkg
PSAwOyBpIDwgQVNUMTcwMF9TR1BJT19OVU07IGkrKykgew0KPiA+PiArICAgICAgICBvYmplY3Rf
aW5pdGlhbGl6ZV9jaGlsZChvYmosICJpb2V4cC1zZ3Bpb21bKl0iLCAmcy0+c2dwaW9tW2ldLA0K
PiA+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiYXNwZWVkLnNncGlvLWFzdDI3
MDAiKTsNCj4gPj4gKyAgICB9DQo+ID4+ICsNCj4gPj4gICAgICAgLyogV0RUICovDQo+ID4+ICAg
ICAgIGZvciAoaW50IGkgPSAwOyBpIDwgQVNUMTcwMF9XRFRfTlVNOyBpKyspIHsNCj4gPj4gICAg
ICAgICAgIG9iamVjdF9pbml0aWFsaXplX2NoaWxkKG9iaiwgImlvZXhwLXdkdFsqXSIsDQo+ID4+
IC0tDQo+ID4+IDIuNDMuMA0KPiA+Pg0KPiA+Pg0KDQo=

