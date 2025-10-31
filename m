Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4532CCCF9FF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 06:47:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEitR-0004Qi-F0; Fri, 31 Oct 2025 02:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vEitK-0004Pq-Bj; Fri, 31 Oct 2025 02:45:42 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vEitC-0003Wo-A4; Fri, 31 Oct 2025 02:45:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N28J2O+EhQdEkxfSZccGciA6wQ+EI1AlABatTR3lmKRWStxX1O8ow4YQG1DLvmMDdo3RVTcS+1RW0Mu9mirTIdk726xtgNaWs+f4vfHgJN1kv/h1WUmcBOYXnMA377VIBfzoxrwU3tMgwVYOEEX0FesU7SNw3rvBBt2L66pSJmIcnesOaB0rU9UngaoTOxg9LbLclBU/9/wZEymMQ+DFPGsKtDPJm0CdXeio1CWyUi91WfqTfiHjEd2449+LDTIpZsWs9m18qHzkzHdbf06y7GjO8oNFOIc8YTomiWNIb14dlyFEZOOFtQx676+TdUhKe5Rm33Msha/vLm5sbMrKwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zaAbDb4eLXd5yCEP+s+4aYfo9q9wSyIlO+kYyuL7QRY=;
 b=jdLK2X/hiDGqxdM7iDepUcIeVdt8/mWmCwr9ws7yXuT8C3VeyffLzvfRSQu/oOqWc3tyYhQ996Oy2s6Q6Kzo08/aNgx9frqhQorHOLbF625ur9fCQwOBG7uPlWyhN10NWT0n71gpW9X7S84In/MlSgXqkQ/qp39n2+rSfkxnFp1fnJBsd6xT0hfcMOSRTt2xbz+TENG5PEJd9JS07sO6EVTDTnOp36cwOCg/DNu2BTKjHPKE4ZEuK+/KJUWhXMFbal93oq1Finr5kuA4EJCv0H3o5Q0mWvi6MUZFHd1n16skC/2DoQHdVHfoEQ9ui5QKUpk4WaHEzM6h9t6pd4KRbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zaAbDb4eLXd5yCEP+s+4aYfo9q9wSyIlO+kYyuL7QRY=;
 b=rKDuZDgGZGxMDxKw18M1OxARyqkd1DcqMYP5KHV8Rxix6YTeixcUvO563pQxp5ODcTDXCRBvnkKR+aYJQltMffaWZ8JKzIoCfGdiofTJvfXGcbYHKHiQD8dZVJWuCIq3T20CcI7LKm0e9SR4xhI8rw+WK5OzCZUCU7c+JB5jTAw5KZ/dQd+5w2a/iThiVQp2Im2YLpz9d5OihOakRGUStRlZRMTqr4kQVkwuI3Qs+WVM1ReoZCOJcicXRH+xGUBEUNgyX5jN4Kpfy3cvwlFPkUYSZ7o/UXoWNB2lkoau2llCbrVKtmZ0LWixsJzP42lKTFVB0jO2lqoWKTV/T/3yKg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TY0PR06MB5442.apcprd06.prod.outlook.com (2603:1096:400:31e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 06:45:20 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5%3]) with mapi id 15.20.9253.017; Fri, 31 Oct 2025
 06:45:20 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: RE: [SPAM] [PATCH v1 03/13] hw/arm/aspeed: Make create_pca9552()
 globally accessible for reuse
Thread-Topic: [SPAM] [PATCH v1 03/13] hw/arm/aspeed: Make create_pca9552()
 globally accessible for reuse
Thread-Index: AQHcRAQRFYH8ewlI4UWlZk+HTMDL2LTZZWaAgAJ1LvA=
Date: Fri, 31 Oct 2025 06:45:20 +0000
Message-ID: <TYPPR06MB82063447974895D3C4C7703CFCF8A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20251023100150.295370-1-jamin_lin@aspeedtech.com>
 <20251023100150.295370-4-jamin_lin@aspeedtech.com>
 <b622dd42-1e36-453e-954f-c2aa07cb5d1a@kaod.org>
In-Reply-To: <b622dd42-1e36-453e-954f-c2aa07cb5d1a@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TY0PR06MB5442:EE_
x-ms-office365-filtering-correlation-id: 3468b237-c9e7-46cb-ffcd-08de18490f45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?K29ZT3N5akp5VlBza1ExamgraGRiQ0o2Q243NGVaNHoxMkZ5Rjg4dHJXb2lZ?=
 =?utf-8?B?OFRWRmpGRktZR2FZWHZpbjRDcEUzQmJmLytiM1R0YnBzM1JNSkRCYXl0QnY2?=
 =?utf-8?B?T2dwWnhZaXAwQmJzMlJYczZjQ3h2MW5sTkk2VURVMkwyNHB6SUtYVnRZa3NS?=
 =?utf-8?B?OC82NVpEY3p2Ynd5NTlLcjFvRGtLeU1BTW4ydzgzb3Y1bnUxaitNbmtFbGkv?=
 =?utf-8?B?ZnVmNDZnUjg4TEdFOUZidnV1RUpNUVBMeUdNcXV3T0N2SDFGRGFuT1pmOWw0?=
 =?utf-8?B?RGVueXFzeXFxeXoyMEpTL3F0blVCOWExNHRDNWxBUWV2SkdlZEFsQm84OXdZ?=
 =?utf-8?B?WGUwaWdNQzdqNVQzZ0twQUxBZWZtZlU4QzdxWjJhdkVRWWtZSElyelkzMnlE?=
 =?utf-8?B?R3hRN0hXbU5UQkFJWklTWjlpa0VBQ2FIU0FsR2laUGxDZnFjWGVwSGthMUVz?=
 =?utf-8?B?Sy9FeUcvbmdnME9SQWd2dVVlL3Z4KzZRV29TRnJ2VVArY25KZDcvb0s2Q20y?=
 =?utf-8?B?M0kxWGFISjVKUjV5Vk1wNVp0NmQ1aGM5dURXaFc4L0k3ZWlhUUJFY2Q5NndJ?=
 =?utf-8?B?OVllYjA0NG1IUTRTUVNDT3B2Qy9TdlpHWmNtcVJoR08zYzBLLzhiTlNKbnN3?=
 =?utf-8?B?eWMwU0l3ZDFoY2g4ZEdUY1o2WGhGWldNL25VN0ZhRGRDc2hnQjQwRG1OQWNJ?=
 =?utf-8?B?VW5Kb0kyUWJYcHpjN3Q0Z3FnVmUxRW5nOXUzN0VGY09yWXZtTWpLT0ttcDBI?=
 =?utf-8?B?VDNCQ21nMzNnbTNMYm5VSXBZc01xVmcxN3IyRXVPRXZCRmhQNzVSS1NGWDlh?=
 =?utf-8?B?RmdyRmEwRS9sOS9mREwxMXoxSGtpOUlpbUI4eEFoV0NvYldsVnZqcHU3SHVI?=
 =?utf-8?B?aWkxNWFNclVKakV5Qmx0RjVBOE9zcjFjSmlncjdpOHdsVFUwNDRUd2xuYUVT?=
 =?utf-8?B?UXpHc01ZNVNrUmx2SDllU1E5aG9qWGxOR1JyOWwyMGI1eWxmdVN2eUtITlRr?=
 =?utf-8?B?SDY2R0o0ZXJOdHpoMTlsZzExbHdQNUtqQ1BrYm1mS2JnVksvK1RvY1libWRi?=
 =?utf-8?B?VGNZcGk2SVFoVElLVkkzZGNXeHhIWHRGOVJySVhZblpBQ1VEMmF4a3E5UU85?=
 =?utf-8?B?YW1SRDl3NVliL09tSVBKM09ZL3l0WThTSHVHOEwwRytEaUNkMkNQa0RkQ3FB?=
 =?utf-8?B?QTZGRmJ4WExieG5PeXBFQmM1YTJQMFNCcGc2bWpMQldRalNDREtRSDlVVEtE?=
 =?utf-8?B?SDhJRVNXRWxnWVN6TGFxNEtnb1pvdTJuclRiUmxwelhNc28zN1owbVRoVDU3?=
 =?utf-8?B?VGxRRFFFVEhsMTRESFp5dnlJV3pKU1ZZQjFNem0relJzWmJCK1I5NXhpRTFT?=
 =?utf-8?B?T2kyUkRKNnpJbVFnaFJtTFRObzZkYitKMThxbDdYaGErbjRucW1BZFVQalp1?=
 =?utf-8?B?QmpPZWtDS29ZQk9ZYm1QZWI2M1IvMk1BckY4b1BGTlJvdjlUb2dtNEJSWGQr?=
 =?utf-8?B?VDNuaWJzVjVGK2IwR2dYM3RvMSs5ZzNXMDZrWi9nbUFKaTJJZHJaRnZoOHVR?=
 =?utf-8?B?cTBtdHNhRE5Meml6bXcxR0Z0M3hnN0xOL3BxL21sd2xEWHRnVk9NMGFlODBP?=
 =?utf-8?B?MG5kMWs3TC9EU0kvRm9kMlVBeDZocDlNcGRXc3JzN2VZWCt4M2xWMXI1UEVx?=
 =?utf-8?B?VXJNek0yWUEvVGcyeHQvZDVaMmd2UnowYVpxVUkvL1U0OTFvQmdqakFwcE4v?=
 =?utf-8?B?T3hydkhzUGc0OFZoK01Qcy9QRy8rejhBV0RPekVNaWZYNFdmUFlCVTJ3ZE9Y?=
 =?utf-8?B?WWFxbzhlMndKaktvN2JWZFY5WDZrUTUxZ0hkbWE5N3FmWFJiNXB0Unh6dzFy?=
 =?utf-8?B?RmVBc3BSc1ozbXZIMEdLU2VnR0E1bEVNbmZEYkZvSC9peGV3NXlRclhuVlpy?=
 =?utf-8?B?YnRnQWRMQVNieTJUWHMreHBaMllHMUdNeVNjWlo4ZitWOXJpRzVpTEd6RzFp?=
 =?utf-8?B?R1pvQU9MY3U1TC8wL3p0c1kzZ3dIbVNFNFBNNVRkUGZUem9WUHFYbkp6R01S?=
 =?utf-8?B?TDh2NG5XV0FTbnhaNDdlalQxUXdtbUJ6Ujl6UT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TW1nZGQ0ZjEveXVlNkwva0MyaDRMWFNJby81alhhL2xldTZscmNuRUxmWDJB?=
 =?utf-8?B?c21TdmJOK0R3RVRFYjFqRWNSL01IVytjenZ6MzR1cXdVekdJeDVLQnFoMTNZ?=
 =?utf-8?B?WVBRbmxsc2pJaUVlcGNBUXozcDVUNEtGazBuQy9rdnlJMytnLzd4NVNZZms3?=
 =?utf-8?B?SkFvcUlDUXhqc3lxSzFKeEtmcktCdG1YT1RzT0w1M1lpanJXUHhaZWhNRUll?=
 =?utf-8?B?dzd4UkRsaTA3M1NiR3FnWEMyTjZITURORnQ3NERmcUp2dmRRbDNOYTZGV1Ra?=
 =?utf-8?B?dGF4bUZQTFNDUVJYc0pqL1JCS1RPdGdvNHNUR0t2Tlp0YTFLZCtaSE9pOElj?=
 =?utf-8?B?S3FxYjc4My9Hem8zbFZsSzB3YTBUamxJdkl4ckIwZ2NuaUJZMnRzT04wVTJE?=
 =?utf-8?B?cWZ0UjcyLzd0ZENvRmMrY1FpZWtyeFlvaU0ydzdNUEV6QStoTGlJTmQ4Z2o1?=
 =?utf-8?B?dTdRd0I3WklFaCtPQjM1azBvaW5ZcndsU3J3ak5rUFcxc0xHY1hyeXNQRFNk?=
 =?utf-8?B?azNQQitqb1hjUkVsNklNY0sxdXRaeE5oQUNTN2dMWFRka1lZeFhxeGIyK2M4?=
 =?utf-8?B?R29xcXZlWXhRN3lhNUdST1BBLzI2RFk4N1dwbk83d21WL3lJNGJHMTRtbHVZ?=
 =?utf-8?B?SFF3cVg5WjlmUWh2UHBpeHBDbTBzVnMwaFpaSWZmdXVBYWErUXpXN1pwbDQ1?=
 =?utf-8?B?c0xkR3JYL1c1dmNZT1JrNkFqSDVWeUN0bVQvVmphL2J6UXVCZUFwY0dXeUda?=
 =?utf-8?B?TTRldVVhKzVXQUxEb2tvUmJ3Wktmcy9YVlh1bFNGNWFOVnIzWWdDczdsaWVW?=
 =?utf-8?B?dVFVdjlHN05qUFZXKzZLc29MclVoWFVDenVWTklVV3IxRTQ2WGQreFlzMHNF?=
 =?utf-8?B?OXJsUTllbUQ4b0FsMU9zWWhHbTVBNVoxWG1tdGNOeGVYOGs1SWNvL1JGclpJ?=
 =?utf-8?B?Y1FHYXVoU2FzWk5CVjJzK0hselNEVDBwclgrYTluL0RaMUV2QVlBb3J6K1FV?=
 =?utf-8?B?NlhPTklSNzVnU0ZOUmtQaW9DN0FqSTlMZnpoY25leThUeFNOOE1OYmdNR01k?=
 =?utf-8?B?bWhwK1RVZHJzQldTNmZtblZMdDZOakNSdHV4REllWjVvTlYzL0xzc0NXL29G?=
 =?utf-8?B?UWFOTkJZSlhnMmJ0Z1BDVm8yVnptWmp3blR4QVR4c0F6Nm55Zm9NeHFYN1ZE?=
 =?utf-8?B?ZFhLKzFNWjZVTmdqMVdnY1luUXM4TDU2TjljVi9TeElaMVN1dndMSGZkZTBY?=
 =?utf-8?B?RHZEdzRxZTBvZ1E2QkVpTlQxUnAzSDAvcDI1SE9jYUFZNU4rdTZwem9KM2RH?=
 =?utf-8?B?VFFZaitTa1prV1RHT3JBVzRjSTQ4c2l4QWpQUkdXaFpoMmRkclR4Q0hOZjVl?=
 =?utf-8?B?aytPc1lqc2R6YTQxVTNXajVPRmJROGJtc0FveTBrWklsaDVjV2lHTlp1TDNJ?=
 =?utf-8?B?RHdVRHFSUXpQemxQMXY1b3RDblFtSVBYMkw0MFdVL2VXSEVQeUlVbCtHWWdq?=
 =?utf-8?B?c1NyNWwyMkpzdndna0Vnc1NQalBJcXptYVBWcW4wZkExVzh1bzlhWkVBZ0ZX?=
 =?utf-8?B?UHBwUS9WR3h3Y2dYc2dzeCtJdEdpMmQyRTU1SjBVRXRPOVpwOUZCUUdtQnNh?=
 =?utf-8?B?OWJSRElwVi9DdVlvczBVLzZKMUlCM0VTa3ArYVduNTEzQjNlVFloUFpqaVJP?=
 =?utf-8?B?bkN0NXA1c0VTVUs2ZXRYeURPNzduQjd0ZTRsbVp4aUdqQ3d1NGphaWpISmY2?=
 =?utf-8?B?TU1kSzlhMlovc2R1N0dpWFZPaUJwYnhSYWw4RTFhSmcvRWFHU2hHZklqVWhp?=
 =?utf-8?B?ZXBZcmhOT0lCUHBJMHRpeUNTck1OTUlKeFhxNzBQYVp3aFQ0V25OVmRCL0U0?=
 =?utf-8?B?LzQ1WnpxbTY2NjE4Z1pOOUZ5eGE1aGtpOFFaUjVRZkVZR3FUNDlvUkM2aFN4?=
 =?utf-8?B?Q0JSOEdRQi9mSEk2Q3Z5TlFLbjc4MS8xRGxGV1ZLSWFxNjBoYy93N05QNTNl?=
 =?utf-8?B?amQveDRjV3p1Nmo0OHpQOFJ3Q2RoQ0tkY0JBQllmSy9mZ3RWYzdwcGtodXNo?=
 =?utf-8?B?a2pPd3Q5QkJEYXUvcnhRQThVb3VDNVkyK2o5YjhXdDlCb0UzQmt3Sy9WTHI2?=
 =?utf-8?Q?kvzgEE+3gTrdil4HMjRphmjRL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3468b237-c9e7-46cb-ffcd-08de18490f45
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2025 06:45:20.0980 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z+tOm0cXkhZoCMH66db3TtQt+iWHjTXur8EgM589+umvP70bYRmpvh1CoaxBkqQ8Xfyt2tGr+FlO8LgIh3Bj2M5pyT2eqcPLrdHALLppcys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5442
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbU1BBTV0gW1BBVENIIHYxIDAzLzEzXSBody9h
cm0vYXNwZWVkOiBNYWtlIGNyZWF0ZV9wY2E5NTUyKCkNCj4gZ2xvYmFsbHkgYWNjZXNzaWJsZSBm
b3IgcmV1c2UNCj4gDQo+IE9uIDEwLzIzLzI1IDEyOjAxLCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4g
VGhlIGhlbHBlciBmdW5jdGlvbiBjcmVhdGVfcGNhOTU1MigpIGlzIG5vdyBtYWRlIGdsb2JhbGx5
IHZpc2libGUgc28NCj4gPiBpdCBjYW4gYmUgcmV1c2VkIGJ5IGRpZmZlcmVudCBBc3BlZWQgbWFj
aGluZSBzb3VyY2UgZmlsZXMuDQo+ID4NCj4gPiBQcmV2aW91c2x5LCB0aGUgZnVuY3Rpb24gd2Fz
IGRlY2xhcmVkIHN0YXRpYywgbGltaXRpbmcgaXRzIHNjb3BlIHRvDQo+ID4gYXNwZWVkLmMuIFNp
bmNlIG11bHRpcGxlIEFzcGVlZCBtYWNoaW5lIGltcGxlbWVudGF0aW9ucyB3aWxsIHJlcXVpcmUN
Cj4gPiBJwrJDIGRldmljZSBpbml0aWFsaXphdGlvbiB1c2luZyBQQ0E5NTUyIEdQSU8gZXhwYW5k
ZXJzLCB0aGlzIGZ1bmN0aW9uDQo+ID4gaGFzIGJlZW4gcHJvbW90ZWQgdG8gZ2xvYmFsIHZpc2li
aWxpdHkuDQo+ID4NCj4gPiBUaGlzIGNoYW5nZSBpbXByb3ZlcyBjb2RlIHNoYXJpbmcgYW5kIHJl
ZHVjZXMgZHVwbGljYXRpb24gYWNyb3NzDQo+ID4gbWFjaGluZS1zcGVjaWZpYyBpbml0aWFsaXph
dGlvbiBmaWxlcy4NCj4gPg0KPiA+IE5vIGZ1bmN0aW9uYWwgY2hhbmdlcy4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiA+IC0t
LQ0KPiA+ICAgaW5jbHVkZS9ody9hcm0vYXNwZWVkLmggfCAxICsNCj4gPiAgIGh3L2FybS9hc3Bl
ZWQuYyAgICAgICAgIHwgMiArLQ0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2FybS9h
c3BlZWQuaCBiL2luY2x1ZGUvaHcvYXJtL2FzcGVlZC5oIGluZGV4DQo+ID4gNzc0M2FkMmZiMC4u
ZDRkNjM5OTZhNiAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2h3L2FybS9hc3BlZWQuaA0KPiA+
ICsrKyBiL2luY2x1ZGUvaHcvYXJtL2FzcGVlZC5oDQo+ID4gQEAgLTYwLDUgKzYwLDYgQEAgc3Ry
dWN0IEFzcGVlZE1hY2hpbmVDbGFzcyB7DQo+ID4gICB9Ow0KPiA+DQo+ID4gICB2b2lkIGFzcGVl
ZF9tYWNoaW5lX2NsYXNzX2luaXRfY3B1c19kZWZhdWx0cyhNYWNoaW5lQ2xhc3MgKm1jKTsNCj4g
PiArdm9pZCBjcmVhdGVfcGNhOTU1MihBc3BlZWRTb0NTdGF0ZSAqc29jLCBpbnQgYnVzX2lkLCBp
bnQgYWRkcik7DQo+IA0KPiANCj4gUGxlYXNlIGFkZCBhbiAnYXNwZWVkXycgcHJlZml4LiBXZSBz
aG91bGQgc3RhcnQgZG9jdW1lbnRpbmcgdGhlIGFzcGVlZA0KPiByb3V0aW5lcyB0b28uDQo+IA0K
SSB3aWxsIGFkZCB0aGUgYXNwZWVkXyBwcmVmaXggdG8gdGhlIGNvbW1vbiBBUElzLg0KUmVnYXJk
aW5nIHRoZSBkb2N1bWVudGF0aW9uIG9mIHRoZSBBc3BlZWQgcm91dGluZXMgLSBkbyB5b3UgbWVh
biBhZGRpbmcgdXNhZ2UgZGVzY3JpcHRpb25zDQphdCB0aGUgYmVnaW5uaW5nIG9mIGVhY2ggZnVu
Y3Rpb24sIG9yIGNvdWxkIHlvdSBwbGVhc2UgYWR2aXNlIHdoZXJlIHlvdeKAmWQgbGlrZSB0aGVz
ZSB0byBiZSBhZGRlZD8NCg0KVGhhbmtzLA0KSmFtaW4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMu
DQo+IA0KPiANCj4gDQo+ICAgID4NCj4gPiAgICNlbmRpZg0KPiA+IGRpZmYgLS1naXQgYS9ody9h
cm0vYXNwZWVkLmMgYi9ody9hcm0vYXNwZWVkLmMgaW5kZXgNCj4gPiA1ZGEyMWE0ZDZhLi4yNjk1
ZjBjMTFiIDEwMDY0NA0KPiA+IC0tLSBhL2h3L2FybS9hc3BlZWQuYw0KPiA+ICsrKyBiL2h3L2Fy
bS9hc3BlZWQuYw0KPiA+IEBAIC01MzYsNyArNTM2LDcgQEAgc3RhdGljIHZvaWQNCj4gdGlvZ2Fw
YXNzX2JtY19pMmNfaW5pdChBc3BlZWRNYWNoaW5lU3RhdGUgKmJtYykNCj4gPiAgICAgICBpMmNf
c2xhdmVfY3JlYXRlX3NpbXBsZShhc3BlZWRfaTJjX2dldF9idXMoJnNvYy0+aTJjLCA2KSwNCj4g
InRtcDQyMSIsIDB4NGUpOw0KPiA+ICAgfQ0KPiA+DQo+ID4gLXN0YXRpYyB2b2lkIGNyZWF0ZV9w
Y2E5NTUyKEFzcGVlZFNvQ1N0YXRlICpzb2MsIGludCBidXNfaWQsIGludCBhZGRyKQ0KPiA+ICt2
b2lkIGNyZWF0ZV9wY2E5NTUyKEFzcGVlZFNvQ1N0YXRlICpzb2MsIGludCBidXNfaWQsIGludCBh
ZGRyKQ0KPiA+ICAgew0KPiA+ICAgICAgIGkyY19zbGF2ZV9jcmVhdGVfc2ltcGxlKGFzcGVlZF9p
MmNfZ2V0X2J1cygmc29jLT5pMmMsIGJ1c19pZCksDQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgVFlQRV9QQ0E5NTUyLCBhZGRyKTsNCj4gDQoNCg==

