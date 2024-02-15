Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD51DC48BC3
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 01:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raQbp-0005dA-S9; Wed, 14 Feb 2024 20:32:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1raQbm-0005cE-97; Wed, 14 Feb 2024 20:32:14 -0500
Received: from mail-psaapc01on2071c.outbound.protection.outlook.com
 ([2a01:111:f400:feae::71c]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1raQbk-0004Je-8D; Wed, 14 Feb 2024 20:32:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyNFyk9nZb3BG72e9Wt1f/vj4XVOcyXMYqVwIdt1m9RX9r4yskLW1LfM7e0tewQl2h1pdrqJZ9FZnnzCgTqJhPRFSijckDVGvp8vga8+9Aq5UnlaSqgd1k5Isydf2BJM5O9wBGcryA1M6dpjWdDqX6bABPw0KhVdfUqGsNWbF+JZY5Zb1LR3JxQ8QtK/PA3JoZliPAzXHJ3nSfRoe/50DfLpKsAbvZpzxl2/YHCNfjJ2d0vprBv4oy+/vN9J2de66R9ldICkBRlGesdJxejkkHTLl4Lw+XZnQsBYFjmweVyJkYPACv0Da5I7odfANN/S638FrYMNYDy3ig4FCD05RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSC9j/fDPIy+yf1bwEdCRV2Uu6mVP1CS24+qlFzCZRA=;
 b=GOsIbNOJr8g95behGDD3Agm1diVq4ab7SPWyZxAGW5KqllmCIoi/q8htyH6g3BowPSp1WrV/K+W3f3jaaLneGZdjwxIK8xM3v92qJt9UmxDrBuT48yfMYEplDkJ3J9ZwU3xnyupXpYhAaOjwwFL7HjxXGyTUomuzlvrwx/LpCOoJbNfb37vfoNhFrgrOMQ8SFI4VTaKehrFG4Wyertjex5G7K+YWmpghxsrMctWkdzOAwuM/N2HVkytSlOzTzJxFfbCjdc8BFF60J8apcjul+jJ3HmrAzUFDpugxO3sefnOHhG3kK2Zyck+4j4mIV0LaI5k8e/JEmssrWYbJSSF/zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSC9j/fDPIy+yf1bwEdCRV2Uu6mVP1CS24+qlFzCZRA=;
 b=mRfQgGyFkcli7MnbrH7onQ9uluLUxOtNvGIubmCTE1t5uczwrI0BG8Zv6ZHggmHQSiS4pigXjFWkl1rD7mPR5ikc6iFiJIVCRhvG8oKddfxDd89aPNzHGnAgpxx65FK8RpN6zYn42MdmA74bVSzDlrbSiPxEfzB5Io8ALV5ogI0kKQh8LyOhrU+pDeiEVYZJiVqsNXhcOZDeAB4DPWLz3Jzl2DH4kpLoa0riG/LeljSykF9z4rjCQd6IbkXZYCjKNgBV/9zn5xq5kb8yDDJKzUnYOoiUw9CrORCXfulnjt45K5mVBqkz0DkCs/HrR2QjBtJYmJeKiInISRVNJLC8uA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 JH0PR06MB6775.apcprd06.prod.outlook.com (2603:1096:990:39::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.39; Thu, 15 Feb 2024 01:32:05 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::79a8:927d:1e03:51d0]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::79a8:927d:1e03:51d0%7]) with mapi id 15.20.7292.029; Thu, 15 Feb 2024
 01:32:05 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v2 2/2] aspeed: fix hardcode boot address 0
Thread-Topic: [PATCH v2 2/2] aspeed: fix hardcode boot address 0
Thread-Index: AQHaWf8w9ds0mW/nUUuxu7qEysR4x7EBsNGAgAj4uDA=
Date: Thu, 15 Feb 2024 01:32:05 +0000
Message-ID: <SI2PR06MB50410FE954C326B4A4260754FC4D2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240207195224.452987-1-jamin_lin@aspeedtech.com>
 <20240207195224.452987-3-jamin_lin@aspeedtech.com>
 <99e302b1-d24d-452e-87d0-ff7f47bc566f@kaod.org>
In-Reply-To: <99e302b1-d24d-452e-87d0-ff7f47bc566f@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|JH0PR06MB6775:EE_
x-ms-office365-filtering-correlation-id: 366e0546-60c4-4ca8-580b-08dc2dc5eacd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YCiMgJEZhtSUm/SDZCRY+hsfBfZea/Rn+K/bDjV9V0ja7YYDnNdAN4ebAVbp6MZo4ZSjSqP5wtd7VwXBB2rQL5YBtEY34WBwdeOCtYcMH7xYzLwsJvLaUF4Xq23kbcgItoaROudj92zANKfEMolrtH9qUgcZ3TC632vNKv/6wirYSn6NX+0x5IvXNzKG/F0mXM8aw1+SNQat1t7Y43v7P7S0nSPYu3D/kMviGTBbgCwox9+6K2PVxJo5Bo5PGWogdZAtWUOqmMml0Aac8IAOjv7t25OpRzoXpqu79TS6vkNTXn10D5SYTr8j8q/IhJ7fvdg5dkz8c9QCWhCnbGdVJx4sd4Zt4I1U5kWFTtNSHgg6o0Xd/KdoSfV8IczQLjcEZzpXud3vNJ/3Gmf6HmxI1YeP9OdbNBIXzdb5MEXv8vTUnoYx/7tgmljC1zHQzW4a9Yv7O8XrbB8YdslqxB/g+EinwoD0ZhIVWhhT9UfqU0YnnbbRCCGCqwSNW3zDo9bSI58rhl3/JQOft7VkS42Ej7Sb7uHWZR16fVRcTEMUONBSPrXt+uBLEpxwS9g6A4OkVTBSlzLJgoNqlptbRO4ZX9Npai+55/9UG/xbzgdRRLPeWALrMN+rcktkmWXGIPAi
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39840400004)(396003)(346002)(366004)(136003)(376002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(26005)(122000001)(66476007)(107886003)(4326008)(66446008)(8676002)(64756008)(66556008)(8936002)(83380400001)(66946007)(52536014)(76116006)(478600001)(2906002)(6506007)(7696005)(41300700001)(9686003)(5660300002)(110136005)(53546011)(316002)(71200400001)(38070700009)(86362001)(33656002)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXNNMGNjSG1rTTRHRzJIbjB1UW9XM0hvYVNZWHJIbmxLbzBHRWtJRGcyOUVM?=
 =?utf-8?B?bzNNNThmeEpLZkhEeG4wb2gwNUtWL1kvTzQ4VXJsVjBPRkNSNVJ2MXVOUVZO?=
 =?utf-8?B?K2piNnpUNU8zK3VmVUZVSmRKcHBFcXJRNkQxb0RlRFNpV3NDWXZFclE5OHdG?=
 =?utf-8?B?c1F2UTEyK1A5aTBNR2xjc2xVU1lkWkRuQTN4UDllRnR3YmJwM0dKN0NjNUlz?=
 =?utf-8?B?MDBXRDExOWtwZE5vYTd2ZHNBR3JTOXlqY2JUM0RCN0t0OUZIQjRRczFwNkU2?=
 =?utf-8?B?M05uYlU0Y3dxSll2aVpJeG4vQWtZTzFrc05hZmtqS29rdkZWOUtZTGMreDVM?=
 =?utf-8?B?YTJRckoxc1F0THYwY0lZdkg1L21MeTU2cmFZOVhtZlQzYityR2YvVGtoU3JF?=
 =?utf-8?B?SXlCZ3E4UStTVUIySXZTTm0rUm8zYXNNU1BJdHhsaHVpUFdld05PZU1zRFRm?=
 =?utf-8?B?U2RGMStsbXI0Wi82N1BXRFRYa2Znd1J0RHgxNzNCUHAyNTh6MUp0b2dBMnVr?=
 =?utf-8?B?QW15eDZFSDgwOHRNSGttVWlwRGxzZmdmd01tT1hteXZsQjFIa2U1TjE0MVhJ?=
 =?utf-8?B?alNjL0xXV283SEZZaVI1STZ5eTJxTUJ4eXJvdkY2ME1uN1VuQ1p0TTlid2Ry?=
 =?utf-8?B?NXJGVlEvSHFYRXlncVdqUkJPVEdVb1dTTmdQS2tZOTBhTmNhcUVlK1BmbEY3?=
 =?utf-8?B?Ym82eGNwOW5xbUNyblNnSmVCUFdXUmRGZzlmMlRjUDREV2pNU2U2cytkckZQ?=
 =?utf-8?B?VHpYMXlPRUIzSGFZZFVFMzdESkkwV3pmRWRvWlhGc0tzQlZlZXhvSlVhblpN?=
 =?utf-8?B?d2RnQkNtRlB4OC92SmxjTHJqcVNTWEF2VUo1Rk1JTm51WmV0bVdmRGdpTWd3?=
 =?utf-8?B?bVBDVDQ0bDVLeGRvVDFnR2t1d3d4MmVMSUIrT1VnejU0V1loVTlSYUhMcUFq?=
 =?utf-8?B?Y0haYW5mdjg3SENqaHloT0ovQWlySUVMSjVVSVEzVnRLYnVwMmVxZWZGODFy?=
 =?utf-8?B?Ri9XVEhyVjlpRjF3ZVU5RjN6Zk40YTM2TW80dGRkd0JNZHRIL0duTkFteVpp?=
 =?utf-8?B?RGlkRktYS1NHQjVhTXBJV0lrYmMvbjFIVVcyOC9VY3M5Zjk1eUpEWTVsSWds?=
 =?utf-8?B?ZVdwNnNsd3ZRSXNiSHFCL2dwYjMrTWc3MVJ6Y3Z6bTM3Q28zcFRqM3kyQldY?=
 =?utf-8?B?M0hlUE8wTTJvbFZ3TjFXQzJ4V2h1dXRiSTAvL21seHc0SVdXTHl1aHhtMnI0?=
 =?utf-8?B?Q3hONDdaMWx5ckNoS21yUDlwMDhSQUNTbmNKOVZESFBteGJNZG9FamZmSitT?=
 =?utf-8?B?Y3l0Y1BWa2lKSVRPa2wxOFBEYWdpMGVmL2FBOEtEeERaWFpQcEk2UTZXOGs1?=
 =?utf-8?B?bUFocFVUaGFrb2l1Rm1nYnVYcXBpVmxIWWFoQi9aQUZpbkJaSmZPNmRMZGN0?=
 =?utf-8?B?YTZyUlkwT1NXN214L0NNdXFQSjRYWkYwblR1dFZwdkRiajdpWFg4VHh4U1NV?=
 =?utf-8?B?T3F4Y01VV1luNVhEK25YM2JuZ2dxUzAyaFRXY296eDF4SjYrNTdWdjhpN1JP?=
 =?utf-8?B?OUtZVzdsQkU2Ym5PNEpYbFMxaHZsbXU4Q1ZnYUMwbG5oUVljSjlPWjNSdEpm?=
 =?utf-8?B?VW5WbG9jckpvTC9NQVdPZEZpU05KZnZJc2JkaURjSC9acTIySVNueERQU3A3?=
 =?utf-8?B?SSt6dnluNVJia2ZNdHBXV0R0MGZZengyNTRvYUt2bDM3K2FzWENOUlAzbUJC?=
 =?utf-8?B?YkNPTUhIeEg0U2krRGlITEo0TGYvUUJPeTUyUlUvcG0yclZKNTkzVmt6aysy?=
 =?utf-8?B?UFVacGxtdUdEc1FHSmszOUFXQjNmL3UxK0FRTWg3dHgvQlZGZ2ZEVWhzbnU0?=
 =?utf-8?B?Q0xleHlvUjN2T1pwUDd3TUh4TlpFNU55MDlLL3ExVUliK3VUUEFGSDVvMEkx?=
 =?utf-8?B?WjFQeHdEZ2ZaNFBmQmxFcko0Y0pJODdObkhCV25zcm5ENTZHbTVLZThlbnJo?=
 =?utf-8?B?QUZ5ZEFLQlU4Qys1RHNDNUFYN000M1FxbzFhQ291eWRGOXlOYmoxZHJ5WDR4?=
 =?utf-8?B?ZzFFVHpjWndmaUVsVU9FRHE3RWFaYXpsYmE1WTFBUXdZVTN6WlZBMjFKTEFj?=
 =?utf-8?Q?IoGP9EhMLcFOUFUrHBL+lgs0t?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 366e0546-60c4-4ca8-580b-08dc2dc5eacd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 01:32:05.0567 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZjXa5nM/oFVeQAxQA3YyKnkebNw/t4h+1x4+4+D/sfxDTwroq1YAj2L/lvSIwocqAWmR/NEVPTPYr2nfspp5p5xNdzteic5vyd06KKtEGjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6775
Received-SPF: pass client-ip=2a01:111:f400:feae::71c;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8
Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBGcmlkYXksIEZlYnJ1YXJ5IDksIDIwMjQgNDozMiBQTQ0K
PiBUbzogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBQZXRlciBNYXlkZWxs
DQo+IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBBbmRyZXcgSmVmZmVyeSA8YW5kcmV3QGNv
ZGVjb25zdHJ1Y3QuY29tLmF1PjsNCj4gSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47IG9w
ZW4gbGlzdDpBU1BFRUQgQk1Dcw0KPiA8cWVtdS1hcm1Abm9uZ251Lm9yZz47IG9wZW4gbGlzdDpB
bGwgcGF0Y2hlcyBDQyBoZXJlDQo+IDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+IENjOiBUcm95
IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIg
Mi8yXSBhc3BlZWQ6IGZpeCBoYXJkY29kZSBib290IGFkZHJlc3MgMA0KPiANCj4gT24gMi83LzI0
IDIwOjUyLCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gSW4gdGhlIHByZXZpb3VzIGRlc2lnbiBvZiBB
U1BFRUQgU09DcyBRRU1VIG1vZGVsLCBpdCBzZXQgdGhlIGJvb3QNCj4gPiBhZGRyZXNzIGF0ICIw
IiB3aGljaCB3YXMgdGhlIGhhcmRjb2RlIHNldHRpbmcgZm9yIGFzdDEweDAsIGFzdDI2MDAsDQo+
ID4gYXN0MjUwMCBhbmQgYXN0MjQwMC4NCj4gPg0KPiA+IEFjY29yZGluZyB0byB0aGUgZGVzaWdu
IG9mIGFzdDI3MDAsIGl0IGhhcyBib290bWN1IHdoaWNoIGlzIHVzZWQgZm9yDQo+ID4gZXhlY3V0
aW5nIFNQTCBhbmQgaW5pdGlhbGl6ZSBEUkFNLCB0aGVuLCBDUFVzKGNvcnRleC1hMzUpIGV4ZWN1
dGUNCj4gPiB1LWJvb3QsIGtlcm5lbCBhbmQgcm9mcy4gUUVNVSB3aWxsIG9ubHkgc3VwcG9ydCBD
UFUoY29ydGV4LWEzNSkgcGFydHMNCj4gPiBhbmQgdGhlIGJvb3QgYWRkcmVzcyBpcyAiMHg0IDAw
MDAwMDAwIiBmb3IgYXN0MjcwMC4NCj4gPiBUaGVyZWZvcmUsIGZpeGVkIGhhcmRjb2RlIGJvb3Qg
YWRkcmVzcyAwLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogVHJveSBMZWUgPHRyb3lfbGVlQGFz
cGVlZHRlY2guY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEphbWluIExpbiA8amFtaW5fbGluQGFz
cGVlZHRlY2guY29tPg0KPiANCj4gSSBhZ3JlZSB3aXRoIFBoaWxpcHBlIHRoYXQgdGhlIGp1c3Rp
ZmljYXRpb24gY291bGQgYmUgc2ltcGxlci4gVGhpcyBjaGFuZ2UgaXMganVzdA0KPiBhIGNsZWFu
dXAgcHJlcGFyaW5nIGdyb3VuZCBmb3IgZnV0dXJlIG1vZGVscyB1c2luZyBhIGRpZmZlcmVudCBt
YXBwaW5nDQo+IGFkZHJlc3MuDQo+IA0KV2lsbCBmaXgNCkphbWluDQo+IFJldmlld2VkLWJ5OiBD
w6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0KPiANCj4gVGhhbmtzLA0KPiANCj4gQy4N
Cj4gDQo+IA0KPiA+IC0tLQ0KPiA+ICAgaHcvYXJtL2FzcGVlZC5jICAgICAgICAgICAgIHwgNCAr
KystDQo+ID4gICBody9hcm0vYXNwZWVkX2FzdDI0MDAuYyAgICAgfCA0ICsrLS0NCj4gPiAgIGh3
L2FybS9hc3BlZWRfYXN0MjYwMC5jICAgICB8IDIgKy0NCj4gPiAgIGluY2x1ZGUvaHcvYXJtL2Fz
cGVlZF9zb2MuaCB8IDIgLS0NCj4gPiAgIDQgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCsp
LCA2IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L2FybS9hc3BlZWQuYyBi
L2h3L2FybS9hc3BlZWQuYyBpbmRleA0KPiA+IDA2ZDg2Mzk1OGIuLjM5NzU4NTU3YmUgMTAwNjQ0
DQo+ID4gLS0tIGEvaHcvYXJtL2FzcGVlZC5jDQo+ID4gKysrIGIvaHcvYXJtL2FzcGVlZC5jDQo+
ID4gQEAgLTI4OSwxMiArMjg5LDE0IEBAIHN0YXRpYyB2b2lkDQo+IGFzcGVlZF9pbnN0YWxsX2Jv
b3Rfcm9tKEFzcGVlZE1hY2hpbmVTdGF0ZSAqYm1jLCBCbG9ja0JhY2tlbmQgKmJsaywNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90IHJvbV9zaXplKQ0K
PiA+ICAgew0KPiA+ICAgICAgIEFzcGVlZFNvQ1N0YXRlICpzb2MgPSBibWMtPnNvYzsNCj4gPiAr
ICAgIEFzcGVlZFNvQ0NsYXNzICpzYyA9IEFTUEVFRF9TT0NfR0VUX0NMQVNTKHNvYyk7DQo+ID4N
Cj4gPiAgICAgICBtZW1vcnlfcmVnaW9uX2luaXRfcm9tKCZibWMtPmJvb3Rfcm9tLCBOVUxMLA0K
PiAiYXNwZWVkLmJvb3Rfcm9tIiwgcm9tX3NpemUsDQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAmZXJyb3JfYWJvcnQpOw0KPiA+ICAgICAgIG1lbW9yeV9yZWdpb25fYWRkX3N1YnJl
Z2lvbl9vdmVybGFwKCZzb2MtPnNwaV9ib290X2NvbnRhaW5lciwNCj4gMCwNCj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmYm1jLT5ib290X3JvbSwgMSk7DQo+
ID4gLSAgICB3cml0ZV9ib290X3JvbShibGssIEFTUEVFRF9TT0NfU1BJX0JPT1RfQUREUiwgcm9t
X3NpemUsDQo+ICZlcnJvcl9hYm9ydCk7DQo+ID4gKyAgICB3cml0ZV9ib290X3JvbShibGssIHNj
LT5tZW1tYXBbQVNQRUVEX0RFVl9TUElfQk9PVF0sDQo+ID4gKyAgICAgICAgICAgICAgICAgICBy
b21fc2l6ZSwgJmVycm9yX2Fib3J0KTsNCj4gPiAgIH0NCj4gPg0KPiA+ICAgdm9pZCBhc3BlZWRf
Ym9hcmRfaW5pdF9mbGFzaGVzKEFzcGVlZFNNQ1N0YXRlICpzLCBjb25zdCBjaGFyDQo+ID4gKmZs
YXNodHlwZSwgZGlmZiAtLWdpdCBhL2h3L2FybS9hc3BlZWRfYXN0MjQwMC5jDQo+ID4gYi9ody9h
cm0vYXNwZWVkX2FzdDI0MDAuYyBpbmRleCA5NWRhODVmZWUwLi5kMTI1ODg2MjA3IDEwMDY0NA0K
PiA+IC0tLSBhL2h3L2FybS9hc3BlZWRfYXN0MjQwMC5jDQo+ID4gKysrIGIvaHcvYXJtL2FzcGVl
ZF9hc3QyNDAwLmMNCj4gPiBAQCAtMjYsNyArMjYsNyBAQA0KPiA+ICAgI2RlZmluZSBBU1BFRURf
U09DX0lPTUVNX1NJWkUgICAgICAgMHgwMDIwMDAwMA0KPiA+DQo+ID4gICBzdGF0aWMgY29uc3Qg
aHdhZGRyIGFzcGVlZF9zb2NfYXN0MjQwMF9tZW1tYXBbXSA9IHsNCj4gPiAtICAgIFtBU1BFRURf
REVWX1NQSV9CT09UXSAgPSAgQVNQRUVEX1NPQ19TUElfQk9PVF9BRERSLA0KPiA+ICsgICAgW0FT
UEVFRF9ERVZfU1BJX0JPT1RdICA9IDB4MDAwMDAwMDAsDQo+ID4gICAgICAgW0FTUEVFRF9ERVZf
SU9NRU1dICA9IDB4MUU2MDAwMDAsDQo+ID4gICAgICAgW0FTUEVFRF9ERVZfRk1DXSAgICA9IDB4
MUU2MjAwMDAsDQo+ID4gICAgICAgW0FTUEVFRF9ERVZfU1BJMV0gICA9IDB4MUU2MzAwMDAsDQo+
ID4gQEAgLTYxLDcgKzYxLDcgQEAgc3RhdGljIGNvbnN0IGh3YWRkciBhc3BlZWRfc29jX2FzdDI0
MDBfbWVtbWFwW10gPQ0KPiB7DQo+ID4gICB9Ow0KPiA+DQo+ID4gICBzdGF0aWMgY29uc3QgaHdh
ZGRyIGFzcGVlZF9zb2NfYXN0MjUwMF9tZW1tYXBbXSA9IHsNCj4gPiAtICAgIFtBU1BFRURfREVW
X1NQSV9CT09UXSAgPSBBU1BFRURfU09DX1NQSV9CT09UX0FERFIsDQo+ID4gKyAgICBbQVNQRUVE
X0RFVl9TUElfQk9PVF0gID0gMHgwMDAwMDAwMCwNCj4gPiAgICAgICBbQVNQRUVEX0RFVl9JT01F
TV0gID0gMHgxRTYwMDAwMCwNCj4gPiAgICAgICBbQVNQRUVEX0RFVl9GTUNdICAgID0gMHgxRTYy
MDAwMCwNCj4gPiAgICAgICBbQVNQRUVEX0RFVl9TUEkxXSAgID0gMHgxRTYzMDAwMCwNCj4gPiBk
aWZmIC0tZ2l0IGEvaHcvYXJtL2FzcGVlZF9hc3QyNjAwLmMgYi9ody9hcm0vYXNwZWVkX2FzdDI2
MDAuYyBpbmRleA0KPiA+IGY3NDU2MWVjZGMuLjE3NGJlNTM3NzAgMTAwNjQ0DQo+ID4gLS0tIGEv
aHcvYXJtL2FzcGVlZF9hc3QyNjAwLmMNCj4gPiArKysgYi9ody9hcm0vYXNwZWVkX2FzdDI2MDAu
Yw0KPiA+IEBAIC0yMiw3ICsyMiw3IEBADQo+ID4gICAjZGVmaW5lIEFTUEVFRF9TT0NfRFBNQ1Vf
U0laRSAgICAgICAweDAwMDQwMDAwDQo+ID4NCj4gPiAgIHN0YXRpYyBjb25zdCBod2FkZHIgYXNw
ZWVkX3NvY19hc3QyNjAwX21lbW1hcFtdID0gew0KPiA+IC0gICAgW0FTUEVFRF9ERVZfU1BJX0JP
T1RdICA9IEFTUEVFRF9TT0NfU1BJX0JPT1RfQUREUiwNCj4gPiArICAgIFtBU1BFRURfREVWX1NQ
SV9CT09UXSAgPSAweDAwMDAwMDAwLA0KPiA+ICAgICAgIFtBU1BFRURfREVWX1NSQU1dICAgICAg
PSAweDEwMDAwMDAwLA0KPiA+ICAgICAgIFtBU1BFRURfREVWX0RQTUNVXSAgICAgPSAweDE4MDAw
MDAwLA0KPiA+ICAgICAgIC8qIDB4MTYwMDAwMDAgICAgIDB4MTdGRkZGRkYgOiBBSEIgQlVTIGRv
IExQQyBCdXMgYnJpZGdlICovDQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvYXJtL2FzcGVl
ZF9zb2MuaCBiL2luY2x1ZGUvaHcvYXJtL2FzcGVlZF9zb2MuaA0KPiA+IGluZGV4IDVhYjA5MDJk
YTAuLmJmNDNhZDgzNTEgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9ody9hcm0vYXNwZWVkX3Nv
Yy5oDQo+ID4gKysrIGIvaW5jbHVkZS9ody9hcm0vYXNwZWVkX3NvYy5oDQo+ID4gQEAgLTIyNCw4
ICsyMjQsNiBAQCBlbnVtIHsNCj4gPiAgICAgICBBU1BFRURfREVWX0ZTSTIsDQo+ID4gICB9Ow0K
PiA+DQo+ID4gLSNkZWZpbmUgQVNQRUVEX1NPQ19TUElfQk9PVF9BRERSIDB4MA0KPiA+IC0NCj4g
PiAgIHFlbXVfaXJxIGFzcGVlZF9zb2NfZ2V0X2lycShBc3BlZWRTb0NTdGF0ZSAqcywgaW50IGRl
dik7DQo+ID4gICBib29sIGFzcGVlZF9zb2NfdWFydF9yZWFsaXplKEFzcGVlZFNvQ1N0YXRlICpz
LCBFcnJvciAqKmVycnApOw0KPiA+ICAgdm9pZCBhc3BlZWRfc29jX3VhcnRfc2V0X2NocihBc3Bl
ZWRTb0NTdGF0ZSAqcywgaW50IGRldiwgQ2hhcmRldg0KPiA+ICpjaHIpOw0KDQo=

