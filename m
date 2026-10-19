Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D94CCF2D4
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 02:11:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIcpg-0001H9-2v; Sun, 18 Oct 2026 22:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xIcpd-0001GK-N9; Sun, 18 Oct 2026 22:10:33 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xIcpb-0000Rg-Br; Sun, 18 Oct 2026 22:10:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lycn89tQahMtJIlgPL1povc/r0maGs91YQga23ZNmCGE01iwbeRAboVi0x0kYf5Gyo/R/OLdqjyyXyLlQuUlzb0eocsrydyFzfBAbZ6AWE8GwmYvN+MJBCikzo+PWQr6kqF1f+xPajfFaE3dDqPSaNN8S70hL6A16a3w59u+XfNb8GoVsar9pNT2t6wScDRlaul2hCBO7Vf1121e4sbTeUAj/zGBFR0TA9mJhTAjEgOB5gljnEuph/xY1OL/K4Yez0XiUdOfpIEsQabOdBx8UeWXZsTtTJOy55stZWh1V5mfeKD10ucQY+if0i7F49ZQfVHJ9DD/1T/rCSWLgCkq5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9cbU9Guofu3xnKETTgYNBHGvVlECbVnNiFDKgWLddw=;
 b=HFoGnnvdVt3S2nB6q3rmqmjyjGqCaCSqeBrtid43GciMLgpYpnhInHCMFNDID1DB21NKRC3virjfFn/j8Riya2Na8e8gklfdY87vu+Pz/0FWqxpFvvbNtR9sFDiBARNDRdNHYqoW2bC6ZPBpLWx3ZnB9LkImSSWgEhcW9UPvdQxOxvpMnuXsAJRwTrmtQJ9O5Zr7NENm51KBEXmJLt1M3JKQaaZQ6RywD2UAyg3r6MDcKWnOkFVr7A4hN9eYtKo6W83rVc1pj2U/qdz6KWLb+BDMkNxytZ/FdmxH2zp4k6SjY3GWhvzTG/EFG9CaBtE1Y4gyS++Gx/fn1l9xkaqd3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9cbU9Guofu3xnKETTgYNBHGvVlECbVnNiFDKgWLddw=;
 b=LLPqDsRk4irWcf3ksoOIlmBzG2FyUAvcjSSqhOHuYAnU+XCrIKa7eT/AOnz8rWTHPUqWPE3QxLXIlVOvC5q9tx2mvDEA9TbByBoPumm7IYN6tpBgCnUPn2LKfWIhshw4LAK1VLMXFE1V39RRdTUnYsu/nR6lj7CQLgwmfiBe2olfv3ly5PIquYaYPWCirnWgzCOR7Oyc6wWPoNDzNpbU3vP1lDFZ6RtDQJ7aypEi8u9DANVkMMuhFpJRKJERW08eve3Wt6Cn0UsIVCPtv2Ohnun1kE8FFL8taDfFiyTFvG9YR4aUzXvcV7Tbj7Vv+rSEQ4rpnaf9serVe0uVuM4mzQ==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by JH0PR06MB7108.apcprd06.prod.outlook.com (2603:1096:990:9d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 02:10:16 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 02:10:16 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Marcelo Manzo <marcelomanzo@gmail.com>
Subject: RE: [PULL 16/32] hw/pci-host/aspeed: Add AST2600 PCIe config space
 and host bridge
Thread-Topic: [PULL 16/32] hw/pci-host/aspeed: Add AST2600 PCIe config space
 and host bridge
Thread-Index: AQHdXk5+XKvco56d8k+3dnrLUmlJ+LcEIR0g
Date: Mon, 19 Oct 2026 02:10:16 +0000
Message-ID: <SEZPR06MB73624DCE6F9E2F004231387CFC982@SEZPR06MB7362.apcprd06.prod.outlook.com>
References: <20250929165230.797471-1-clg@redhat.com>
 <20250929165230.797471-17-clg@redhat.com>
 <CAFEAcA8OKABUH8S_F4HrWLKDC9XYqWGxD5_xMAPOPmc614u4UA@mail.gmail.com>
In-Reply-To: <CAFEAcA8OKABUH8S_F4HrWLKDC9XYqWGxD5_xMAPOPmc614u4UA@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|JH0PR06MB7108:EE_
x-ms-office365-filtering-correlation-id: 5b57f483-f458-402f-a3fe-08df2d861e4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|38070700021|56012099006|4143699003|261009223027099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 8u8h3+X6E8x49/E1eh5yM96ruVbh45sHZ8WyUF9HNX4ssMZd2kjmk0cN9ZaGUwrhi3eIE6HbwZS+ZOBWQLd0rxPry1z7n+Tlhh/nLNPzhS4QXgcJN9LsmIz6ygs97AOc8nOwqFKLkNqIShKJAUX2fwpgPg/PnaBVamFF6lS12KY3L13swq89m12nCIYZZSnjxGoRLpN7C8QrdYbO81VwSks5X06tDUfVzxYCUXnvnvIpSLjUAalyi3TSy0zcOKeQ4SoHv6iOoRq6ZnMQCjZtmcCjp0manYDXGMEYSYOLGKXOThn6/xX3RKD5XI4pNH2nVb2UzlB6JWF4xk8Hy5nX4hVI0Rr/tpCIcXU3uiaFYoXYWfu/8ad+3zwmJbfPnt3xjn7e2CpXlfS/7eP0Kbhq6i19X665UfingkRBXANmE+L3tyae+bQo5xZKVgq1CYB4yhToaNJBIPu3DxgWSL5O0TPYTZPmOP+YnPuN2VbbP5hp5nwV5l+cQkf+wYVFTo19vYT1SwlER9M3nTPJ8bl6nwbAytsaaJUgoWStZdyLfcdDL1DN4/O1r4Kbxz5gykDVxk0PdFnUY93Y1XGzhHtOG2oOR0gAA7O56NHpgM+msi/PWxNHSlBMLvI8omIZYkCrZoljSqZuQZq4BFcJUE87cYrKcN3OycFj6tcv87UVFBOYb7R+lKhcH3B5oq9TZ/PTdf2F04p3jiTcSmUlYm7goBVK88g/NkqG6B/tRbxLYEY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(38070700021)(56012099006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTRQTUdIRWIwc0tzNTlLMmo2b1Z6Y0xyRW5KbEZlQitXRS82WjVGS3V0RXhG?=
 =?utf-8?B?MTVsbm9JZ0pVT004SlJzQmNZS2ZpU1p5c1Nnb2pYT2RwT3Q4NUNUMzZPVlNn?=
 =?utf-8?B?aytZT1oyVVo3VDl2RmwwckxTY04yWENEaFV2SXVXK3hKbk55b1lERkhOWWFi?=
 =?utf-8?B?UTY1Yi9RMXN4L0pITTlYOGFJbEo2QlRBS3lZcjNabjVUVFBkL0xBbUNzSEhp?=
 =?utf-8?B?NGZ6Rml1Z3Z5Zit6Nk9qSXFkZWlqVlZrcVFxcXgyZWcyeU9Za3dJbDAwbkNa?=
 =?utf-8?B?WWNrMlV4OGdxVUlNQnJDNlhKZU1yOWVFQ1dKSE82UWVyUS8wM2VWbkYyemJT?=
 =?utf-8?B?L3lBNGVzYmpQSWlyZ2VQdXdKTnhxaDI3WG96QzZQVmpvMDVkZ3RWOTNrbDdq?=
 =?utf-8?B?QVVlQ2hIaTgwdHBDbys4dU40R3E0bU9JMjdUS0J5NHlVa0ZwVUcvWW83SGRO?=
 =?utf-8?B?Yyt1d2VRam9TT0k4c2Z5b1FWZ1piakVvNWpEa0YxeDdPOGpXcVBqMURIMG4z?=
 =?utf-8?B?TnVLRDdoTS9DaXllVGpCUkphR21tYnNGaFgvVE9VS2hSNU5lbk12LzAzaWdO?=
 =?utf-8?B?dUhFamFzdklmT0RxWVJNSEJKbGwvV3RjNUdiWGo2SWhLZEpLOUpLci9FdlRE?=
 =?utf-8?B?YU9UekpyN3QvWnhxSzFyVk5xY2lWbUxmaHZrM1lJbWErajhqNXp6Mks1Y0Q1?=
 =?utf-8?B?VjJaYkNzcmlDZnYwNllNemtPY3ZrZVg1LzRIQXN5TWZoVzdBaWYvQnhjZGZL?=
 =?utf-8?B?NGdhVkFHM3JMYnc0cTZzQlA0SlJGRFBFWENZWitIOGpyVElkYzlUU1c0YjZ3?=
 =?utf-8?B?VUw5bXh6WWJrc0lyazhrVDNUZG9rRG5DZnN5bloyejEwblFLcmt3Zng4Q3d6?=
 =?utf-8?B?YVRoU2s0V2l3NXN0SjJzQU5MWkUxSFdkdnFQOWl6Qnp2aEN4ZkEzMzM1Sitk?=
 =?utf-8?B?OVFLNXdYaDNUZ2FZOGV1RXI1TThQWDhmWGNUUnNSRElVRHdTVW5EcGU3dWV4?=
 =?utf-8?B?a0tHOCtBRG5pUkZWZXRoTnpCYnM2NURSdGs0YllUZnU5WnFDK3BvdlRsY1Nm?=
 =?utf-8?B?STU3VWx0MGFQUXV5TTk0YktXbVdaQXpXNzVRVVVuQUVIa3cwVE5zcU9JdE1a?=
 =?utf-8?B?c2J3L0Y1ekpORDZTKzZpb2liY3ZOR0VEbzI0TklOZ1A5ZUJNc2tzaC9xYXJH?=
 =?utf-8?B?Zk9jUSs0V1pLaDRxYTk4TnA1cjFBck5Nb3pWSTFzUGROaERDT0ttVGlVcGJQ?=
 =?utf-8?B?L0h0M0ZlcEE1NjFPN3JjbWlHbFo5d0s5REhDRVZIbytmaERXak5uMEdEN0U1?=
 =?utf-8?B?WXJrT1UvMW13cFk3U2VoQmRKUlJyZUptejVBRkE4V0lmN01wbkh6aHhRM0Jw?=
 =?utf-8?B?Q2VuL0ZaT3pMVEoxcHJVS2JmdGFiRkZrd1dSOWhML2ErV1FwTVdhdFZRbXly?=
 =?utf-8?B?eHRxZVQ4aGZ3R3RVcGxqcWpUczhkeE83R2QxSkI4ZlczWTBISUNjRkt1cyt3?=
 =?utf-8?B?Uk0vanFrcnlPOGk4M1dSaTJ3RUoybDVFaWxmU3J1NmdKdE9mU1lzT0NjS1Bh?=
 =?utf-8?B?bWxEczZ2Y3dBd2x3K2lGZFFnUTZUcU90TWtDeTFaanZSY2djVnpWeTRQRU1w?=
 =?utf-8?B?VG1rcUtBM01ZYXNXQmFpNUhTSUx2bHc0ZFpzQ0RTVVRRR0cxMC84TE02VWFY?=
 =?utf-8?B?bkRhWS9BdXhCMU9kclpzWHVqMTdTalZ6ZE43YzBDVmxadDdqSlJsckF3VlhO?=
 =?utf-8?B?dm16c1p3dXZVQ0tFTWFWdENpdjZRTTJNSG10NDRTVUF4UmlSc085ajFZT0Rz?=
 =?utf-8?B?NmMrVnBUNzA0blhnZWtVU1lJdm9SajdscndIL1NoYUVSYUxBdW1TWTErSVBS?=
 =?utf-8?B?WUNCby9zR1A5UUc4enliOVlOZ2xEK1V2OVZFeHN0M1JNQS9YR01DMitCR1B1?=
 =?utf-8?B?cjcvTWxrV1VpckhlbnMweW1lYldIM1ozSmVHK2hvbWd0aVhsR2RWOG5MSXpp?=
 =?utf-8?B?VDNBN3lpOHhYcDNmRHRPTkRrY1BqWGJhVnB6d05hd3RDc0NEQk9GQ1VsVGEw?=
 =?utf-8?B?Zkc1UWVGUmFyZkpLdW43b0IxWDA3c0Z6Qk5vZzJOZXBoRzZxeCs5eVZUTG9X?=
 =?utf-8?B?TDdXWm1ILzNqLzJQZitUalJWNmIxVXdyQ1Z3MFZ2TnRSdnJFMWJWQzQ2UTdY?=
 =?utf-8?B?MnY2eXhBMnlEWDJLZmJWU055bmVkbEtjcFg4bDJqNW5SRlUyWW9CV3RRZkhj?=
 =?utf-8?B?czFCRERnYWpvamRNYXk4ZVc2U3Nka0I3Yk9sM0dqZFM0VnFvV2NrSjNXUk9F?=
 =?utf-8?B?VmJ3RVdpUXhVeWFOdXdwQjRmYWhsOTVtbnBnMXBGNW5PdlhXVXN3QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KYZMHZFKLbE6ssLoY5686HRW9e9H8pSSxQOgUqrdUswquPxaOviyxFJwv/CAxlEgUWeRGDfRzApHzwcm1Z7L+dRU/TmVQJ+kQ773BXyfMUU03BOLbOFHMoybrXxWaOTqbDqcqX4EkARyTL4W2Ee4iK5zdXhO3pchfx/l46/2E5MK7uOyI/NJ2UOg1bf/BE1LU+ArncB5RU6BBH/c4t0Hm1x1IBARE3/Mv0nCQWY+x8/5kNrqpL+a2auzL/z0I6ZE0C66NA/Yx7Y9JQ7IOFxNhJOfvpldHc6moaps94OT5qX5S0A1hdjSJJAe4nC33e2+d3Ua6bYhsktquADhf1EAOQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b57f483-f458-402f-a3fe-08df2d861e4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 02:10:16.6918 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jjkt+g6SiOYeO5WrYLcvGrCF02JBYqrj8/bGDiFqSMAMqircl0PYfBMZpKv+n9sgDvhPLPB32WMLpW+pZvpoui4saGFdco74TwFoQkQs1bU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7108
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

SGkgUGV0ZXIsIE1hcmNlbG8NCg0KKg0KPiBTdWJqZWN0OiBSZTogW1BVTEwgMTYvMzJdIGh3L3Bj
aS1ob3N0L2FzcGVlZDogQWRkIEFTVDI2MDAgUENJZSBjb25maWcgc3BhY2UNCj4gYW5kIGhvc3Qg
YnJpZGdlDQo+IA0KPiBPbiBNb24sIDI5IFNlcHQgMjAyNSBhdCAxNzo1NCwgQ8OpZHJpYyBMZSBH
b2F0ZXIgPGNsZ0ByZWRoYXQuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IEphbWluIExpbiA8
amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiA+DQo+ID4gSW50cm9kdWNlIFBDSWUgY29uZmln
IGFuZCBob3N0IGJyaWRnZSBtb2RlbCBmb3IgdGhlIEFTVDI2MDAgcGxhdGZvcm0uDQo+IA0KPiA+
ICtzdGF0aWMgdm9pZCBhc3BlZWRfcGNpZV9yY19jbGFzc19pbml0KE9iamVjdENsYXNzICprbGFz
cywgY29uc3Qgdm9pZA0KPiA+ICsqZGF0YSkgew0KPiA+ICsgICAgUENJSG9zdEJyaWRnZUNsYXNz
ICpoYyA9IFBDSV9IT1NUX0JSSURHRV9DTEFTUyhrbGFzcyk7DQo+ID4gKyAgICBEZXZpY2VDbGFz
cyAqZGMgPSBERVZJQ0VfQ0xBU1Moa2xhc3MpOw0KPiA+ICsNCj4gPiArICAgIGRjLT5kZXNjID0g
IkFTUEVFRCBQQ0llIFJDIjsNCj4gPiArICAgIGRjLT5yZWFsaXplID0gYXNwZWVkX3BjaWVfcmNf
cmVhbGl6ZTsNCj4gPiArICAgIGRjLT5md19uYW1lID0gInBjaSI7DQo+ID4gKyAgICBzZXRfYml0
KERFVklDRV9DQVRFR09SWV9CUklER0UsIGRjLT5jYXRlZ29yaWVzKTsNCj4gPiArDQo+ID4gKyAg
ICBoYy0+cm9vdF9idXNfcGF0aCA9IGFzcGVlZF9wY2llX3JjX3Jvb3RfYnVzX3BhdGg7DQo+ID4g
KyAgICBkZXZpY2VfY2xhc3Nfc2V0X3Byb3BzKGRjLCBhc3BlZWRfcGNpZV9yY19wcm9wcyk7DQo+
ID4gKw0KPiA+ICsgICAgbXNpX25vbmJyb2tlbiA9IHRydWU7DQo+IA0KPiBUaGlzIHNldHMgdGhl
IG1zaV9ub25icm9rZW4gZ2xvYmFsIGluIHRoZSBjbGFzcyBpbml0LCB3aGljaCBpcyBydW4gZm9y
IGV2ZXJ5IHR5cGUNCj4gY29tcGlsZWQgaW50byBRRU1VIGF0IHN0YXJ0dXAuIFRoYXQgbWVhbnMg
aXQncyBlZmZlY3RpdmVseSBmb3JjaW5nIGl0IHRvICd0cnVlJw0KPiBmb3IgZXZlcnkgbWFjaGlu
ZSB0eXBlLCB3aGV0aGVyIGl0J3MgYXNwZWVkIG9yIG5vdC4NCj4gDQo+IFlvdSdyZSBzdXBwb3Nl
ZCB0byBzZXQgdGhpcyBpbiB5b3VyICdyZWFsaXplJyBtZXRob2QsIHNvIGl0IG9ubHkgdGFrZXMg
ZWZmZWN0IGlmDQo+IHlvdXIgaW50ZXJydXB0IGNvbnRyb2xsZXIvUENJIGNvbnRyb2xsZXIvZXRj
IGlzIGFjdHVhbGx5IGJlaW5nIHVzZWQuDQo+IA0KPiBSZXBvcnRlZC1ieTogTWFyY2VsbyBNYW56
byA8bWFyY2Vsb21hbnpvQGdtYWlsLmNvbT4NCj4gDQo+IHRoYW5rcw0KPiAtLSBQTU0NCg0KVGhh
bmtzIGZvciByZXBvcnQgdGhpcyBpc3N1ZS4NCldpbGwgZml4IGl0IHNvb24uDQpKYW1pbg0K

