Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9446C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 01:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXAbW-0001WI-BC; Mon, 05 Feb 2024 20:50:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rXAbS-0001VM-3o; Mon, 05 Feb 2024 20:50:26 -0500
Received: from mail-eastasiaazon11021007.outbound.protection.outlook.com
 ([52.101.128.7] helo=HK3PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rXAbP-0002Yn-H1; Mon, 05 Feb 2024 20:50:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n49XBwS7KJ5nl2v0AEKMxSh9KOH9KRTxmwiFRdKKo51UEqEEMzFjxqVQf7trSyffp/dtRng0hfpUVGw8O5XJ9kGgziWUTQnf3TZo9CRBhPBPITRbORNaOfgQOvwmzxnyo9QCJ4SlQRBwkvQPvlbw/JMwfiek+VOXrV0wTtXKxx76ejF0w/2vgRq7VjEKDfuM0tsS62dcASuEly2SOlWcuVK5LlscaZInM0iFNd4Ayw+HngjW+pTQoWKkjod8eNubnBeEukIdmnn4CNOF4gJ4nxKkopdM5XuqTmN9EswxVNFElCOwTUCA5hHWksOc36CfbUxDnuEZAglNJN1QZbREaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djr9ClZufJcYf3TsI13dMhEhADDi9hOSpeTjpaEzjkg=;
 b=H26xX0P2+1tDAsOpFmhmc0v4IoFybGRiLTSPhEHpCaQb+CAbzx14yFoYGcFe/9KXV0RLsq+svV4mmM95OoRVKiOAaQHnfz/nnsIDMxWqNxlyc2lXdXF+LIMdLJ2aa1vOYZJF3eL6lQK0oARwPUaHKrExvIzKgTRnnTUMTXUMfiowAdR1eh1q1ACVWvrS50AQcjpJ0589Q9mlSBkGHQxgv5DmXl+FsF2ASta2M3Z8hBd68IqWMH8qp9PUzXy0uXpPpeXxKcgCxCRCG3y9hz6EdRS25l/0E/Ii3+dKdrr7XSKD1XF8CtSP1NuMQSFGnffE40f1cxux3v03fcZf/CzvKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djr9ClZufJcYf3TsI13dMhEhADDi9hOSpeTjpaEzjkg=;
 b=GyMDHpNbvARvp4jMexmnkh2nSh/aTCjjlK/KN7zOJ7AoG1k1jci5ZSbx36sqni0SuwAhwAV3aER9W1qejdcxxREsP+j/yN2Hud3UBKnXt/0CqOxDOIr72isAZf+MBM9lsGzMTdq2CZn5In6Jv5caKxUhot2G8yGZVR/rX4+khz3El/uJReI+iBK2Ia2YW/+7V41kl3ykcbnk+auxrxYFSPKsh0NAiXlCsDTByCtrkTkvtKPSg2nA7dapqufIQlg2drc3mFUlDZBz4rWGNgTB0kAC8JnobOwjJfAV1/cAkD7n7vk9DgF1W13Bd+Yy+1exFUcMg6yLK/HS0nV6nGMvLg==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SI2PR06MB4073.apcprd06.prod.outlook.com (2603:1096:4:f5::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.36; Tue, 6 Feb 2024 01:48:46 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::79a8:927d:1e03:51d0]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::79a8:927d:1e03:51d0%7]) with mapi id 15.20.7249.032; Tue, 6 Feb 2024
 01:48:46 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v0 2/2] aspeed: fix hardcode boot address 0
Thread-Topic: [PATCH v0 2/2] aspeed: fix hardcode boot address 0
Thread-Index: AQHaWBO30bPHmM/RFku3sIerkZYRgrD7vACAgADOZEA=
Date: Tue, 6 Feb 2024 01:48:46 +0000
Message-ID: <SI2PR06MB504143638045D7666B341C09FC462@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240205091415.935686-1-jamin_lin@aspeedtech.com>
 <20240205091415.935686-3-jamin_lin@aspeedtech.com>
 <46d14718-2b2c-45aa-aa12-854a2704383b@linaro.org>
In-Reply-To: <46d14718-2b2c-45aa-aa12-854a2704383b@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SI2PR06MB4073:EE_
x-ms-office365-filtering-correlation-id: 35ec00e3-cb78-461b-85b5-08dc26b5c1bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZMwZv4mN5n4v2hRZaRgMQUEU2GGxP8OG6++YYJfUSKvdXs56WGuSncxvzYLIMjSBJweIPHxqkBCMnC8ff8D6TLXoJPe+YDwdfoHWzO+1+eOiYGmb+GdYMa1kCTDa8CKYlW0Awe5JwY6BkmCVp50uTqxGrJPowekXDCHKDx+IdjECqLfZvjmNhHigejNf3IbUCV+n14HjF0P7OwkmSC8+Emsirqqa6fnmihe5itLgXRfKYH32MicCQGQquFJfd0aEJ3lbfJYRNCnOAEXkDrA33OaV0nehxB0XcuAUTIjCNw4hCEmePadSCGflBxTNtIyhhxPrexQciLblcTeK6xylpVGdo2bmP/8yUH3+JYzG9Jx3YivNxvYJRrc3uuMg/BlStiERignNuKmNxUff9k+QDTZAG8Eyn0Gqx1D7dWh94IBqBC92ZF01Ta6C5sxsQPl0U/MNni14HeExdRPdSDFmeOWGUXCA26r5zH2C1rmikWOLflwIpdZPgBtgCnt211+GbTSCeJwZgvgsgB+uFV95RMxvuF0IQ5XSvDrmQjblxDd5OcOQafYV1kJjt2G4+ykQp/Zl0KUBs37V88WuPuUk8Tr5vYBTnqwZNqnL9vdavlTtRJZGzT5NsF39WCpZfAua
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(39850400004)(376002)(396003)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(38100700002)(122000001)(55016003)(83380400001)(107886003)(86362001)(26005)(66574015)(33656002)(71200400001)(7696005)(6506007)(478600001)(9686003)(53546011)(52536014)(76116006)(316002)(41300700001)(110136005)(66556008)(66476007)(66446008)(64756008)(66946007)(38070700009)(8676002)(8936002)(4326008)(5660300002)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0JNQy9uWWR3YWhVaFJNeTlHQktjb215Q0NVZnYwbVpDNDBvbDNhNWxsWE93?=
 =?utf-8?B?blVCSitWWC9zTHdFNGFvTTd4bmhTT0srWjhCbjRnQ09OUGhjYnZxdHpBS2pO?=
 =?utf-8?B?OXpLQ0tEZFpaL3NhU3lEVkF6QUE4ck5UVjc4VWpRUlgrK00xSWJOQU1kSkxT?=
 =?utf-8?B?TzAyQVFGQUp0UldnOTg0V3J4dDJBTWJub2pxZUoxMk5CZE5ncjlMcHJ6WTRB?=
 =?utf-8?B?OFMzK2wraThoZTUzam1EVWdrUUtTcUQvejVsV3VGc2FzbVlIbXhQNmRhbnI1?=
 =?utf-8?B?SEhLRGdDaUhNYU92ME1XL3dSN2YycHR3MVJiQzJnb0ErcUtzVi9vTmtQSXkx?=
 =?utf-8?B?NnZ6cnlrbngyQ1BxeXZJUUliZEZJekpXSEh2bjI1cmZKdHBKM3hiWFRhOTR1?=
 =?utf-8?B?S21wSkR1azRkcTl2Z01YbHowV0k2c3FLN1gvb1dEWjVkdzRqNlFyQ2pKK1FO?=
 =?utf-8?B?amZxTmdOSDRJOWRvOE1uQklwTlpHdDFHakhmYWZVWWNZeXJuYXN4Q1dRdUpC?=
 =?utf-8?B?a1ZPVkR0bGErenZqV055Y0JqYXdZdXl1MTJoM3VwbXFwNlF5QUVsRUY5ZE5a?=
 =?utf-8?B?WmhhbXhJWUVYbDR3OVhJc05nNW10U3IrdDZFZUo3RnFNYVFzQXpIM3JveURU?=
 =?utf-8?B?NGZlR0x5ZFRaZ0lMdlMzMHJjZzZLUjZMaXMrMzBCUWNXRzc2d0pwcHlKL0Y3?=
 =?utf-8?B?M3BvMXRPYmV5djFRbGFvK0FFQVpLNDlpdThxa1Q3T3l3Qmk2VEVTRGZUTnpY?=
 =?utf-8?B?VUNrYWV1U3NvWkx5dXI1R1RNM1R6NkZ1QnYvNkVEZFBJU0pFdGhDMFJMaTVS?=
 =?utf-8?B?R01nU1d5N1hXTVJGd0pSWFR0YmhkNnMrbUF4cG1qbzZyQ1NqT3Blcy9neVYr?=
 =?utf-8?B?cnpGQWVkNUxyVTZQZ093SU1GbUU4S3NnSHFUVVZSWGk5cHhubnlnUDFOZXM1?=
 =?utf-8?B?WUZXcTZQSUJzVmtMK1h1Z3h4SHJtZ3FBYWluSEl6YTRMMkQxM0wrSG54T1Bs?=
 =?utf-8?B?QVJ4U0svek9OR0llMkQxQW9Bak1TUWx3cjB3WUNVUDJURnhzL0VDNGpML3lF?=
 =?utf-8?B?QWFjbHlEZkdoY2FtRDJJbjM2MGJlT3U5UjJwRHJKdnlGL1BwWWFUdkxSYjBC?=
 =?utf-8?B?WWRVV3dpbXJIZVVLVWhCMUdHUEVxSTlwOUx0SFZZZGFBcUJrbFBPdXRSL291?=
 =?utf-8?B?eGMvaEdmenJpYkxzN2FObTY0RjZmcHhGdVF3MTVEWEpFSjJ6L3NLMk9ubW1U?=
 =?utf-8?B?U081K0FGWS9DdWk3aFZoSHM5MlBOOG5CbFFvNWMvOW95TGdtWGhjKzZ3MU4w?=
 =?utf-8?B?OGxXakp1d3JuVzBkcnRtd0xTM0paMGFvQmJ4VEdOQ0JnNGtBejg4b3BWM09V?=
 =?utf-8?B?Z1FvNTBOaFVFVlhZZHVXZSs2emxNV3p2TXgzRC9FRTY5ajBMWHB1bXZJYmtX?=
 =?utf-8?B?eExyeHlXa3dKUVdqWTNzbFRXbFJhMWtTa3IyaFlRUHNZdk0wWDFhZkRPSTZ6?=
 =?utf-8?B?SDBVTlJybWlxUkxEOGVLcnJ3NUozL2txNGNrZGRzLzM1OWtpUGQ5ODZ2amZB?=
 =?utf-8?B?UVVrVDZGLzZWUVlzcGVickZLeVMwNDVCMzRaN1NRSUlwK29TNUtmSGV2UmNh?=
 =?utf-8?B?d3lPTmxZWmdKd1loOGF3REVwbmg0TWxHSlEwbmxFd1RnRjlsVG13eEZYWlVH?=
 =?utf-8?B?L1VWVlJITGlJQ09YYzhlbTFXZEhuL3NZRi83a3JUQkJrKzZvbXFSNjd0SG1p?=
 =?utf-8?B?bXNydHdhRmVCZ3JlblhvbVI4VDU5azgvVzRkT2p5cmMra0tybVJab1Q5UkMy?=
 =?utf-8?B?cGFhVjNUcnNpUGNhSkM1ZzBKR05iakwrVmxzcFVPVWtQcW9KemRBR0hLWWdT?=
 =?utf-8?B?MmpQVUZTcmFWSFdINk9GRHdxaURrdVNlZnpvT1YwbnE5TGlCSmRMbHdjVU5i?=
 =?utf-8?B?cjlBTlh4dWtGQStXK01RZktReHpmZUhtVjlGUWUrWHdKOFRHWjNJN3BybHUw?=
 =?utf-8?B?OG9ZUW1uV0FydU50b3BqSnhlcGJ2YTAwejBTSXNOMWx2M0ZZOW9nTWdabDda?=
 =?utf-8?B?UEVhdmNtaFZ1YzJRbUJsb3hGL2tEaTZZZkNEbzBvSW5uUUNOOVdZSy9rWmky?=
 =?utf-8?Q?lgMQk1x4xK+pmZE0Nfi0x57aR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ec00e3-cb78-461b-85b5-08dc26b5c1bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 01:48:46.0627 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VpqTSrNm27uS7PHvuI+fX7txDkTsz/7c172vL9TQE+aa86aQd/WrvIGXS64FJcdm59ckzuiO52scGdegPORxoGtC9shsp1Du1vA3Ajd914E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4073
Received-SPF: pass client-ip=52.101.128.7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=HK3PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQaGlsaXBwZSBNYXRoaWV1LURh
dWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgRmVicnVhcnkgNSwgMjAy
NCA5OjIwIFBNDQo+IFRvOiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT47IEPD
qWRyaWMgTGUgR29hdGVyIDxjbGdAa2FvZC5vcmc+Ow0KPiBQZXRlciBNYXlkZWxsIDxwZXRlci5t
YXlkZWxsQGxpbmFyby5vcmc+OyBBbmRyZXcgSmVmZmVyeQ0KPiA8YW5kcmV3QGNvZGVjb25zdHJ1
Y3QuY29tLmF1PjsgSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47IG9wZW4NCj4gbGlzdDpB
U1BFRUQgQk1DcyA8cWVtdS1hcm1Abm9uZ251Lm9yZz47IG9wZW4gbGlzdDpBbGwgcGF0Y2hlcyBD
QyBoZXJlDQo+IDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+IENjOiBUcm95IExlZSA8dHJveV9s
ZWVAYXNwZWVkdGVjaC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjAgMi8yXSBhc3BlZWQ6
IGZpeCBoYXJkY29kZSBib290IGFkZHJlc3MgMA0KPiANCj4gSGkgSmFtaW4sDQo+IA0KPiBPbiA1
LzIvMjQgMTA6MTQsIEphbWluIExpbiB2aWEgd3JvdGU6DQo+ID4gSW4gdGhlIHByZXZpb3VzIGRl
c2lnbiBvZiBRRU1VIG1vZGVsIGZvciBBU1BFRUQgU09DcywgaXQgc2V0IHRoZSBib290DQo+ID4g
YWRkcmVzcyBhdCAwIHdoaWNoIHdhcyB0aGUgaGFyZGNvZGUgc2V0dGluZyBmb3IgYXN0MTB4MCwg
YXN0MjYwMCwNCj4gPiBhc3QyNTAwIGFuZCBhc3QyNDAwLg0KPiA+DQo+ID4gQWNjb3JkaW5nIHRv
IHRoZSBkZXNpZ24gb2YgYXN0MjcwMCwgaXQgaGFzIGJvb3RtY3Ugd2hpY2ggaXMgdXNlZCBmb3IN
Cj4gPiBleGVjdXRpbmcgU1BMIGFuZCBpbml0aWFsaXplIERSQU0sDQo+IA0KPiBPdXQgb2YgY3Vy
aW9zaXR5LCB3aGF0IGFyY2hpdGVjdHVyZSBpcyB0aGlzIE1DVT8NCk1DVSBpcyByaXNjdi1pYmV4
IGFuZCBpdHMgYXJjaGl0ZWN0dXJlIGlzIHJpc2N2LTMyLg0KDQo+IA0KPiA+IHRoZW4sIENQVXMo
Y29ydGV4LWEzNSkNCj4gPiBleGVjdXRlIHUtYm9vdCwga2VybmVsIGFuZCByb2ZzLiBRRU1VIHdp
bGwgb25seSBzdXBwb3J0DQo+ID4gQ1BVKGNvcmV0YXgtYTM1KSBwYXJ0cyBhbmQgdGhlIGJvb3Qg
YWRkcmVzcyBpcyAiMHg0MDAwMDAwMDAiIGZvciBhc3QyNzAwLg0KPiANCj4gT0ssIGJ1dCBJIGRv
bid0IGdldCBob3cgeW91IGdldCBmcm9tIGhlcmUgLi4uDQo+IA0KT3VyIGRlc2lnbiBtYWtlIE1D
VSBleGVjdXRlIFNQTCBhbmQgY29weSB1LWJvb3QgaW1hZ2UgZnJvbSBTUEkgdG8gRFJBTSBhdCBh
ZGRyZXNzIDB4NDAwMDAwMDAwIGF0IFNQTCBib290IHN0YWdlLg0KSG93ZXZlciwgUUVNVSB3aWxs
IG9ubHkgc3VwcG9ydCB0byBlbXVsYXRlIENQVSBzaWRlcyAoY29yZXRleC1hMzUpIGZvciBhc3Qy
NzAwLCB0aGF0IHdhcyB3aHkgd2Ugd2FudCB0byBjaGFuZ2UgdGhlIGJvb3QgYWRkcmVzcyBhdCAw
eDQwMDAwMDAwMA0KQW5kIHVzZSB0aGUgZm9sbG93aW5nIHN0YXJ0IGNvbW1hbmQgYnkgUUVNVS4N
Cg0KLi9xZW11LXN5c3RlbS1hYXJjaDY0IC1NIGFzdDI3NTAtZXZiIC1ub2dyYXBoaWMgLW0gOEcg
XA0KIC1kZXZpY2UgbG9hZGVyLGFkZHI9MHg0MDAwMDAwMDAsZmlsZT0ke0lNR0RJUn0vdS1ib290
LW5vZHRiLmJpbixmb3JjZS1yYXc9b24gXA0KIC1kZXZpY2UgbG9hZGVyLGFkZHI9JCgoMHg0MDAw
MDAwMDAgKyAke1VCT09UX1NJWkV9KSksZmlsZT0ke0lNR0RJUn0vdS1ib290LmR0Yixmb3JjZS1y
YXc9b24gXA0KIC0tLQ0KIC0tLQ0KDQpCeSB0aGUgd2F5LCBJIHdpbGwgc2VuZCBhIG5ldyBwYXRj
aCBzZXJpZXMgdG8gc3VwcG9ydCBhc3QyNzAwIGluIHR3byB3ZWVrcyBhbmQgDQpXZSBzZXQgbWVt
b3J5IG1hcCBmb3IgYXN0MjcwMCBhcyBmb2xsb3dpbmcuDQoNCnN0YXRpYyBjb25zdCBod2FkZHIg
YXNwZWVkX3NvY19hc3QyNzAwX21lbW1hcFtdID0gew0KICAgIFtBU1BFRURfREVWX1NQSV9CT09U
XSAgPSAgMHg0MDAwMDAwMDAsDQogICAgW0FTUEVFRF9ERVZfU1JBTV0gICAgICA9ICAweDEwMDAw
MDAwLA0KDQpKYW1pbg0KPiA+IFRoZXJlZm9yZSwgZml4ZWQgaGFyZGNvZGUgYm9vdCBhZGRyZXNz
IDAuDQo+IA0KPiAuLi4gdG8gaGVyZS4NCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogVHJveSBMZWUg
PHRyb3lfbGVlQGFzcGVlZHRlY2guY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEphbWluIExpbiA8
amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiA+IC0tLQ0KPiA+ICAgaHcvYXJtL2FzcGVlZC5j
IHwgNCArKystDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL2FzcGVlZC5jIGIvaHcvYXJtL2Fz
cGVlZC5jIGluZGV4DQo+ID4gMjE4YjgxMjk4ZS4uODJhOTJlODE0MiAxMDA2NDQNCj4gPiAtLS0g
YS9ody9hcm0vYXNwZWVkLmMNCj4gPiArKysgYi9ody9hcm0vYXNwZWVkLmMNCj4gPiBAQCAtMjg5
LDEyICsyODksMTQgQEAgc3RhdGljIHZvaWQNCj4gYXNwZWVkX2luc3RhbGxfYm9vdF9yb20oQXNw
ZWVkTWFjaGluZVN0YXRlICpibWMsIEJsb2NrQmFja2VuZCAqYmxrLA0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDY0X3Qgcm9tX3NpemUpDQo+ID4gICB7DQo+
ID4gICAgICAgQXNwZWVkU29DU3RhdGUgKnNvYyA9IGJtYy0+c29jOw0KPiA+ICsgICAgQXNwZWVk
U29DQ2xhc3MgKnNjID0gQVNQRUVEX1NPQ19HRVRfQ0xBU1Moc29jKTsNCj4gPg0KPiA+ICAgICAg
IG1lbW9yeV9yZWdpb25faW5pdF9yb20oJmJtYy0+Ym9vdF9yb20sIE5VTEwsDQo+ICJhc3BlZWQu
Ym9vdF9yb20iLCByb21fc2l6ZSwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZl
cnJvcl9hYm9ydCk7DQo+ID4gICAgICAgbWVtb3J5X3JlZ2lvbl9hZGRfc3VicmVnaW9uX292ZXJs
YXAoJnNvYy0+c3BpX2Jvb3RfY29udGFpbmVyLA0KPiAwLA0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICZibWMtPmJvb3Rfcm9tLCAxKTsNCj4gPiAtICAgIHdy
aXRlX2Jvb3Rfcm9tKGJsaywgQVNQRUVEX1NPQ19TUElfQk9PVF9BRERSLCByb21fc2l6ZSwNCj4g
JmVycm9yX2Fib3J0KTsNCj4gPiArICAgIHdyaXRlX2Jvb3Rfcm9tKGJsaywgc2MtPm1lbW1hcFtB
U1BFRURfREVWX1NQSV9CT09UXSwNCj4gPiArICAgICAgICAgICAgICAgICAgIHJvbV9zaXplLCAm
ZXJyb3JfYWJvcnQpOw0KPiANCj4gUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOp
IDxwaGlsbWRAbGluYXJvLm9yZz4NCj4gDQo+ID4gICB9DQo+ID4NCj4gPiAgIHZvaWQgYXNwZWVk
X2JvYXJkX2luaXRfZmxhc2hlcyhBc3BlZWRTTUNTdGF0ZSAqcywgY29uc3QgY2hhcg0KPiA+ICpm
bGFzaHR5cGUsDQoNCg==

