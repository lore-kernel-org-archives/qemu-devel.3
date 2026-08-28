Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80211C61DC6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 08:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzsE1-0001Y7-M4; Fri, 28 Aug 2026 04:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wzsDw-0001XX-EM; Fri, 28 Aug 2026 04:46:08 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wzsDt-0000bP-HW; Fri, 28 Aug 2026 04:46:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cHyJZi529QpxFVde0/jWBjG7bh7UkQwt0DvjklI/tGeonTl09184cQphMKUT8Y48HSt2NbXhrMX/9SdWBuj2W6EvbiMYfk2gO67L5HohdWFeRlJ3cI6NDE/q/RJnutU1mSAOpE13D0Q0Rx+3UuwPlPDuVlPjsMDdjxbNrzhyTqWRFu7ore6Fmjtnp5YpMTj2JSqrIsaOSH7EoOitUPGv+F4OKE1k4n06qJiPVfbRwFz7WAnrOhhZG++OfISdkFbA428C5Cwu9RMVscUvd2zZOKwiPivqohAedv3nI/r9nfqxosHY/vyIJk14Jy4BVW+nScoYCesMMLrcuqmRHdbeMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4qZnWyTgK9YoN1SsA4OXIbwFostQxqZEv++xDuXQ8g=;
 b=RwuNkMW+8Yz9UNWl2mLImUi/wXXm+EFQeLqvH4u92i59jdAyeBtkmmjDrGsMoQyXE5lGaF6XUhXpIAJqKDT1sypdFxIsIE0l6myk8JDeaoZR+AnjqwzY1ndYL3fDL7eDKU6Dj59mAwhPiACIVekO2SAtDO573y85TbM1NwMfH0bwIq/l0BiZFJU2URWK24YbBAgE6Wlu0Z1G7gDrN85s82Nkxuh51nkLVbvU/1mMW7FG9qG8HIvLeR6JmeY+AOAYFV0Udf44WuSbaSGjXBtg+JzxIH36uuJKwznmtWfjuIU+WGqmx2huVwYRNFkILhuv0x+SRIcrRuCyG4/Ix5FGmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4qZnWyTgK9YoN1SsA4OXIbwFostQxqZEv++xDuXQ8g=;
 b=RGzCeHszapf5oGJpir8gAqfhQuLFSxNy87dqMgRjY/9239KAfBZsGtl3ycR0heTO7eB5fRO4AQFjl7T5jWMRXd1LKLxx4bUvkZBYos/jYXAlbF/edY3kYdASDVYmCOB07VvzrqrN8UlThKuGJTYnpbDBq19GQrvlBFP+CRl8DjZtxzTaunitvNAIDyx8vKKOC8h2mufkyWzRs/ToU2uvoxBhNOM9CTppEs9CRXirYXLxgi9xP+kpjXM0Cb69todAMJOFo9KyrfOB4JPRzbU28aQqgwMxM58SftbTqDQfqA5z0tPQID7DbhgJWYmGDblHFNuZxyR0s2g9cy6TSwcVSg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYPPR06MB8301.apcprd06.prod.outlook.com (2603:1096:405:396::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 08:45:57 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 08:45:57 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open list:ARM
 TCG CPUs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 3/3] hw/arm/aspeed_ast2600: Wire up the UDC
Thread-Topic: [PATCH v1 3/3] hw/arm/aspeed_ast2600: Wire up the UDC
Thread-Index: AQHdCr+oNl8HJH0GCUqipWD50Ge917ZluV4AgE3EIiA=
Date: Fri, 28 Aug 2026 08:45:57 +0000
Message-ID: <TYZPR06MB49801C1B2D4EE24ECF19DAA3FCAC2@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260703074332.1049473-1-jamin_lin@aspeedtech.com>
 <20260703074332.1049473-4-jamin_lin@aspeedtech.com>
 <38bae6ba-b380-47a1-a134-f16313a1f7e3@oss.qualcomm.com>
In-Reply-To: <38bae6ba-b380-47a1-a134-f16313a1f7e3@oss.qualcomm.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYPPR06MB8301:EE_
x-ms-office365-filtering-correlation-id: fb31c6f6-e2e8-497b-349c-08df04e0c74c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|921020|38070700021|10067099003|4143699003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: pm3N2M4weHBbtjl7I1YSaWOqDIqH/3KE8vsnYYkN58f1coDCyvYva4ew8crGOZcGK7EeUH0uiRA6agH5hI/lAcBKkg+9lNstZck6CQkcF1KfuYY5aNexVurlm0aKTFVQBj/NdZJDXAemX2Q2ETlbG8klFA+Hr+ZjILWTMv4IwNcII3qgc41g0lX/O/vqyqSkVT72QsEfJGSCr4ITVtA4gc23Oj8/a/RwboBQERtrFhfh+5njhQas+nWSGKGXo05ZYtIUYBxRz21s1zPEd6UA6UC7XEgDo7q5AHdytiVFcxdgB9aHj6dJJ8r7lybKj8Z32KMhACghQy/NW5Tpnrhy2JNcuodbHBnK+qUoL4QwV/IxYy7YpoKZEmP/9c0WK4UHY4KP2iUnNC7ueDATxI8xLmCt72Unw/5ciQxZgf//ziNenV7QigdxqMX7e0mGysfAwTXa+ii0348Xo4xstwyWuF9nxgoRbM/a1zQO428cOLhlK0ThVAR0DoWZQ0ox8tXcp96/ZCTWXVSYCkQhe1hrJZfQS/3hyZ7rPiAvXWT5xC/md3Lf65fXft8BGaH3TTDviHCyRhD2JlfurIGsl1OXzd6cXvwfcZJGi6p7E7Er+4N0YfP3U7Hcdm+SOnwgetdSfS1lUSwhd9xMg/fzmmt4PIPMulqJC+1UyXYMPSEqNbuimg7wm3Aj+Xdgsk9WsAml7PQbJYEnbDGvl1RkLTo90knScGqwH/crbwDG2mADi9Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(921020)(38070700021)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHJYSytMYmR1K0tYNXUxYVhwS0ZZdkYrM0JMMWw4NTkxclJnU1RHK01uTXNy?=
 =?utf-8?B?ZXE3Q01mbEtsV1R0L0U1TTFmaGRsUkRZWXF6QWc3LzI2L3lSR2g1M2NGS29v?=
 =?utf-8?B?V20weXl5a0h4eWJmczhVLzBNcXIvM0pjUzZkY0JMR1cwQ1pjdTgyT2pYSkZL?=
 =?utf-8?B?eWhoVU5WQVd4Q1RnZnBNR3V0T0hkTWRjUWsrQzhKVDAwUmxZSGJBc0FMQ09G?=
 =?utf-8?B?K001a1orM2lqNUhZUGdxRjhKdUs5WW43MUh6Tjcvdkp2OGNTZmtMdWFiSWRp?=
 =?utf-8?B?cnNhNFBVVit6RjFicU94MUV1Q2Y5dkJNaCs3Qlc1SVh2WWgxSWVSVlBoYTA2?=
 =?utf-8?B?b3liUDhpcEovN2YvTnQ0Vy9wQnFydW9VOWwrMlBJbFZJZjVqWmZVNDYyZlJX?=
 =?utf-8?B?eml3WEhaY0tMQTJIeVFmWFlBc0FlelJVRnB6NStkY0p4Y3MxUnBPbkxWMWxj?=
 =?utf-8?B?UjBBQnNoblg5ZTVZcmdTZVdxUEorc1FXeUVwOS9RbHFtc3lpWTVZNDFTZEhu?=
 =?utf-8?B?Y3NJMC91MUxTRHdsYW9aNGdkanYya2xCYmtVVzZscHJhRmUwcjZWbEt6R0RZ?=
 =?utf-8?B?SkwybENLbDc3S3IxVm5saVR2S2FtL1FpVTltWHJpcHRsVjFhSkdVUHJkYjRB?=
 =?utf-8?B?Z1p5MGhjTVpHdW9JZy94ancwWVkrbHBmQlFCL3kwYW9JZldsNWNtdUlzcTdO?=
 =?utf-8?B?WEVUM2JwT3N2ZitJODM2OVVnUG92dnUxTHQ4RzkzODJIOFZvMHVneXlDN2RX?=
 =?utf-8?B?UnQxK3hVUFZ5NklWZndFclZDTCthallYVHgxUGVrMTNaTU9Fc1Vta2xNSCth?=
 =?utf-8?B?cmlFdXF3T09BZklFN3VLZW0vYml0MVowWTJwOVo1aEFrNTZBV3YzbDBybnc2?=
 =?utf-8?B?WXlOMXNwblEzbGtBQjFsYmFueFpUeG1sOHNKQTNpdElvbVlwdVR0a0s5bGZq?=
 =?utf-8?B?MmwvK0RteWcrRTQ3c09BM0JLdkpWeW5BTmE3bVgwaS9TYXBXcEc2bjZQVmFE?=
 =?utf-8?B?bXRwRE90Ukl6c1dFSWl0VnNFNnc2Ris5T0R0anFDSHBtTTN3ZGxUM1F4dG5t?=
 =?utf-8?B?Q2NYZXNFaVl5NFllZUd4a3pQWWRMVnBIOXdYTkI5aEpKWHhoUnk0eDR5Q1h4?=
 =?utf-8?B?SUs3dSsrNWsvaWN6ckJjdnhFanJtVjM1aXBqT29RSnEwTkU2WnJKUVlkS3pP?=
 =?utf-8?B?ZHJwV2hTSElINXZwQkxhSXJrSDEycjMxNFJ5c0RWVEtpR0g2RUc0WUZYRkNm?=
 =?utf-8?B?THZ5YkVGWkNDanoraEVsTGEveU5INklidzFUdmcvVkxHeW00TzlnR3cya0RC?=
 =?utf-8?B?a1gwRGI0UUtacmdEcEw0d1VrcVV4bzFQSnIwL1JqN3NjS1I3TU1ESW5QU3NC?=
 =?utf-8?B?d3hqaXBidlcyakd4ZFQxZEt2U3pucEhZK1pUaFBZUFlvdThlTDBmWnBFci9j?=
 =?utf-8?B?SVRIeGFYcXdkK1B4R1FYTk9ncHR5anBpQzhKYVVESXp4MmF4c0ErRlRLRDF0?=
 =?utf-8?B?TklFVTF6RlBQRkwrRWVXekplMXdOQnVaZDdBRTRtRFZJai92QWY2b2prczBJ?=
 =?utf-8?B?Q01WMmNHM0d0T1F1MW1Rek9rUlV6ZSt5L0doeTJFTkxKSFBsZUlLWnFwajhp?=
 =?utf-8?B?V25QV0w3THk4L0FVeVVzK2FraWZkVTJlTURjTmI3amFiVDZzZlg2YTdoYkI4?=
 =?utf-8?B?bE1Ed2pQRTF1cTVLRVlZejFCT3BFbGFlZy84WHMrVVBXSVdYMllTMzdYbnFk?=
 =?utf-8?B?Q283TmpxMEM0T2NSMmdVRFdsblpKS0M4Q2prYzNMUGIyOU4wTng2ZGdwVVAr?=
 =?utf-8?B?dCtWR3c4Z2lsdjI0Qm1RYjhVY055WXFpZHVLeHJ3SFdCK1pxdTA3SFdOVGNh?=
 =?utf-8?B?bnpQVVczenJaN09IaEZCQitkOUNtRHBqY2xVdFh1b0RxTzFuMmdqemJpT3Zo?=
 =?utf-8?B?VXdvd3Bkc3Nrc2lzQjRhSDJwdE1WVXQrNHJGaHJzbml0QjRpRDBzdjZHQ1hr?=
 =?utf-8?B?ZXREY0FNSDNpbk9kcCtRbjdMWGhBWHFwRWl1N2Fodm1SUDE1WDZ0ODh5aG9X?=
 =?utf-8?B?NzdaaitUQUg4ekpKc1pXMldYTzlYNVFoNk1va1VYd01BTGo5L0xleWh0SGVL?=
 =?utf-8?B?TndyUFBlQkJDZG1MYmFTQ3hYQkZGS0IrWEYwbzBtR1RFRXZWMGZycVpmZ1Rx?=
 =?utf-8?B?MHhaQkRYK05kK3NodUVwSHIrWG1McEt1K01aWWtVU1VKQUJFSEVjTFMxZ2Jl?=
 =?utf-8?B?aU5KQ2ZkRVBZS21YVjJPNEtMY2VYRVVBc1p0MnBHMUs2MWFCbWYvZk5MK1dZ?=
 =?utf-8?B?L0xpNW1tZmhQN25EQkluanVRR2I0VDBFR0xJYnRQaWQ0cHRqSFVoQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: G/MRE8lL6LRbu4bNcgwJbKP4u2D0fFiZCFj3QtXbn6vi+JHfs0sJaKcxHYhU366JojU7e3fRzwNVurfxDmkGYouCHklWPmeTlAjWIbOUwQKa0/5I/qSRU/RJKn7znHn22aW+ROXpROpZywIE1Vp4h60fNlq5SUnXjxtUv15bi3hZ7B+VkH1hF95j567I+iRlXQrP3Jlk4wbnsyMClq8DPIPF1jXLz+VkbLy7qZW+SZtoOcAEP6QAmlHcngfpoggNo7CBDuRX3a8mo9EUXVqV/30TwL5sqhFW0kKh8HxZOWi9SO8Ono9pe42cJ6P53j98JhPxECv2k4FworQBCwHIGQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb31c6f6-e2e8-497b-349c-08df04e0c74c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 08:45:57.2513 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PBo5WE/dWdRHPlysSysXdqCdsoeCAnC3dm0gYjvDM08UIsw+MvMNGNidQpkYolM5UPM6xS6xE6syJhWgFU222UWCtlE3mZmHJyL7/v5j0OI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR06MB8301
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

SGkgUGhpbGlwcGUNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDMvM10gaHcvYXJtL2FzcGVl
ZF9hc3QyNjAwOiBXaXJlIHVwIHRoZSBVREMNCj4gDQo+IE9uIDMvNy8yNiAwOTo0MywgSmFtaW4g
TGluIHdyb3RlOg0KPiA+IENyZWF0ZSB0aGUgVVNCIERldmljZSBDb250cm9sbGVyIChVREMpIGF0
IDB4MWU2YTIwMDAgb24gdGhlIEFTVDI2MDAgU29DOg0KPiA+IG1hcCBpdHMgcmVnaXN0ZXJzIGFu
ZCBjb25uZWN0IGl0cyBpbnRlcnJ1cHQuDQo+ID4NCj4gPiBUaGUgZ2FkZ2V0IFVTQiBkZXZpY2Ug
aXMgbm90IGNyZWF0ZWQgYnkgdGhlIFNvQy4gSXQgaXMgYSBzZXBhcmF0ZSwNCj4gPiB1c2VyLWNy
ZWF0YWJsZSAiYXNwZWVkLnVkYy1nYWRnZXQiIFVTQiBkZXZpY2UgdGhhdCB0aGUgdXNlciBwbHVn
cyBvbnRvDQo+ID4gYSBVU0IgaG9zdCBjb250cm9sbGVyJ3MgYnVzOyBpdCBmaW5kcyBpdHMgY29u
dHJvbGxlciB0aHJvdWdoIHRoZSAidWRjIg0KPiA+IGxpbmsgcHJvcGVydHksIGUuZy4NCj4gPg0K
PiA+ICAgIC1kZXZpY2UgYXNwZWVkLnVkYy1nYWRnZXQsdWRjPS9tYWNoaW5lL3NvYy91ZGMNCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29t
Pg0KPiA+IC0tLQ0KPiA+ICAgaHcvYXJtL2FzcGVlZF9hc3QyNjAwLmMgICAgIHwgMTMgKysrKysr
KysrKysrKw0KPiA+ICAgaW5jbHVkZS9ody9hcm0vYXNwZWVkX3NvYy5oIHwgIDIgKysNCj4gPiAg
IDIgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2h3L2FybS9hc3BlZWRfYXN0MjYwMC5jIGIvaHcvYXJtL2FzcGVlZF9hc3QyNjAwLmMgaW5kZXgN
Cj4gPiBkMWYxOGU0NzFhLi43ZDk3ZjEwNDQ4IDEwMDY0NA0KPiA+IC0tLSBhL2h3L2FybS9hc3Bl
ZWRfYXN0MjYwMC5jDQo+ID4gKysrIGIvaHcvYXJtL2FzcGVlZF9hc3QyNjAwLmMNCj4gPiBAQCAt
MzIsNiArMzIsNyBAQCBzdGF0aWMgY29uc3QgaHdhZGRyIGFzcGVlZF9zb2NfYXN0MjYwMF9tZW1t
YXBbXSA9DQo+IHsNCj4gPiAgICAgICBbQVNQRUVEX0RFVl9TUEkxXSAgICAgID0gMHgxRTYzMDAw
MCwNCj4gPiAgICAgICBbQVNQRUVEX0RFVl9TUEkyXSAgICAgID0gMHgxRTYzMTAwMCwNCj4gPiAg
ICAgICBbQVNQRUVEX0RFVl9FSENJMV0gICAgID0gMHgxRTZBMTAwMCwNCj4gPiArICAgIFtBU1BF
RURfREVWX1VEQ10gICAgICAgPSAweDFFNkEyMDAwLA0KPiA+ICAgICAgIFtBU1BFRURfREVWX0VI
Q0kyXSAgICAgPSAweDFFNkEzMDAwLA0KPiA+ICAgICAgIFtBU1BFRURfREVWX01JSTFdICAgICAg
PSAweDFFNjUwMDAwLA0KPiA+ICAgICAgIFtBU1BFRURfREVWX01JSTJdICAgICAgPSAweDFFNjUw
MDA4LA0KPiA+IEBAIC0xMTMsNiArMTE0LDcgQEAgc3RhdGljIGNvbnN0IGludCBhc3BlZWRfc29j
X2FzdDI2MDBfaXJxbWFwW10gPSB7DQo+ID4gICAgICAgW0FTUEVFRF9ERVZfU0RIQ0ldICAgICA9
IDQzLA0KPiA+ICAgICAgIFtBU1BFRURfREVWX0VIQ0kxXSAgICAgPSA1LA0KPiA+ICAgICAgIFtB
U1BFRURfREVWX0VIQ0kyXSAgICAgPSA5LA0KPiA+ICsgICAgW0FTUEVFRF9ERVZfVURDXSAgICAg
ICA9IDksDQo+ID4gICAgICAgW0FTUEVFRF9ERVZfRU1NQ10gICAgICA9IDE1LA0KPiA+ICAgICAg
IFtBU1BFRURfREVWX0dQSU9dICAgICAgPSA0MCwNCj4gPiAgICAgICBbQVNQRUVEX0RFVl9HUElP
XzFfOFZdID0gMTEsDQo+ID4gQEAgLTIxNCw2ICsyMTYsOCBAQCBzdGF0aWMgdm9pZCBhc3BlZWRf
c29jX2FzdDI2MDBfaW5pdChPYmplY3QgKm9iaikNCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgVFlQRV9QTEFURk9STV9FSENJKTsNCj4gPiAgICAgICB9DQo+ID4NCj4gPiAr
ICAgIG9iamVjdF9pbml0aWFsaXplX2NoaWxkKG9iaiwgInVkYyIsICZhLT51ZGMsIFRZUEVfQVNQ
RUVEX1VEQyk7DQo+ID4gKw0KPiA+ICAgICAgIHNucHJpbnRmKHR5cGVuYW1lLCBzaXplb2YodHlw
ZW5hbWUpLCAiYXNwZWVkLnNkbWMtJXMiLCBzb2NuYW1lKTsNCj4gPiAgICAgICBvYmplY3RfaW5p
dGlhbGl6ZV9jaGlsZChvYmosICJzZG1jIiwgJnMtPnNkbWMsIHR5cGVuYW1lKTsNCj4gPiAgICAg
ICBvYmplY3RfcHJvcGVydHlfYWRkX2FsaWFzKG9iaiwgInJhbS1zaXplIiwgT0JKRUNUKCZzLT5z
ZG1jKSwgQEANCj4gPiAtNTczLDYgKzU3NywxNSBAQCBzdGF0aWMgdm9pZCBhc3BlZWRfc29jX2Fz
dDI2MDBfcmVhbGl6ZShEZXZpY2VTdGF0ZQ0KPiAqZGV2LCBFcnJvciAqKmVycnApDQo+ID4NCj4g
QVNQRUVEX0RFVl9FSENJMSArIGkpKTsNCj4gPiAgICAgICB9DQo+ID4NCj4gPiArICAgIC8qIFVE
QyAtIFVTQiAyLjAgRGV2aWNlIENvbnRyb2xsZXIgKi8NCj4gPiArICAgIGlmICghc3lzYnVzX3Jl
YWxpemUoU1lTX0JVU19ERVZJQ0UoJmEtPnVkYyksIGVycnApKSB7DQo+ID4gKyAgICAgICAgcmV0
dXJuOw0KPiA+ICsgICAgfQ0KPiA+ICsgICAgYXNwZWVkX21taW9fbWFwKHMtPm1lbW9yeSwgU1lT
X0JVU19ERVZJQ0UoJmEtPnVkYyksIDAsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgc2MtPm1l
bW1hcFtBU1BFRURfREVWX1VEQ10pOw0KPiA+ICsgICAgc3lzYnVzX2Nvbm5lY3RfaXJxKFNZU19C
VVNfREVWSUNFKCZhLT51ZGMpLCAwLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGFzcGVl
ZF9zb2NfYXN0MjYwMF9nZXRfaXJxKHMsDQo+ID4gKyBBU1BFRURfREVWX1VEQykpOw0KPiANCj4g
RG8gd2UgbmVlZCB0byBtdXggdGhpcyBJUlEgbGluZT8NCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3
IGFuZCBzdWdnZXN0aW9uLg0KV2lsbCBhZGQgb3ItZ2F0ZS4NCg0KSmFtaW4NCg0KPiANCj4gPiAg
ICAgICAvKiBTRE1DIC0gU0RSQU0gTWVtb3J5IENvbnRyb2xsZXIgKi8NCj4gPiAgICAgICBpZiAo
IXN5c2J1c19yZWFsaXplKFNZU19CVVNfREVWSUNFKCZzLT5zZG1jKSwgZXJycCkpIHsNCj4gPiAg
ICAgICAgICAgcmV0dXJuOw0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2FybS9hc3BlZWRf
c29jLmggYi9pbmNsdWRlL2h3L2FybS9hc3BlZWRfc29jLmgNCj4gPiBpbmRleCAzYWFjMTQ0Y2Q0
Li43NGZkODNlOTU3IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvaHcvYXJtL2FzcGVlZF9zb2Mu
aA0KPiA+ICsrKyBiL2luY2x1ZGUvaHcvYXJtL2FzcGVlZF9zb2MuaA0KPiA+IEBAIC0zNiw2ICsz
Niw3IEBADQo+ID4gICAjaW5jbHVkZSAiaHcvZ3Bpby9hc3BlZWRfc2dwaW8uaCINCj4gPiAgICNp
bmNsdWRlICJody9zZC9hc3BlZWRfc2RoY2kuaCINCj4gPiAgICNpbmNsdWRlICJody91c2IvaGNk
LWVoY2kuaCINCj4gPiArI2luY2x1ZGUgImh3L3VzYi9hc3BlZWQtdWRjLmgiDQo+ID4gICAjaW5j
bHVkZSAicW9tL29iamVjdC5oIg0KPiA+ICAgI2luY2x1ZGUgImh3L21pc2MvYXNwZWVkX2xwYy5o
Ig0KPiA+ICAgI2luY2x1ZGUgImh3L21pc2MvdW5pbXAuaCINCj4gPiBAQCAtMTM4LDYgKzEzOSw3
IEBAIHN0cnVjdCBBc3BlZWQyNjAwU29DU3RhdGUgew0KPiA+DQo+ID4gICAgICAgQTE1TVBQcml2
U3RhdGUgYTdtcGNvcmU7DQo+ID4gICAgICAgQVJNQ1BVIGNwdVtBU1BFRURfQ1BVU19OVU1dOyAv
KiBYWFggYmVsb25nIHRvIGE3bXBjb3JlICovDQo+ID4gKyAgICBBc3BlZWRVRENTdGF0ZSB1ZGM7
DQo+ID4gICB9Ow0KPiA+DQo+ID4gICAjZGVmaW5lIFRZUEVfQVNQRUVEMjYwMF9TT0MgImFzcGVl
ZDI2MDAtc29jIg0KDQo=

