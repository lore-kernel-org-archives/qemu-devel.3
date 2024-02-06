Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07804C48260
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 02:16:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXAzs-0006XO-K4; Mon, 05 Feb 2024 21:15:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rXAzp-0006Wq-RD; Mon, 05 Feb 2024 21:15:37 -0500
Received: from mail-southeastasiaazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c401::3] helo=SINPR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rXAzl-0000NF-Pj; Mon, 05 Feb 2024 21:15:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n57pKQhVTEVST0KTTOWO6X5tX2JZon13KamobjrhvmxclsaLg7xmMU9EuFAq2MyeY+CjcXQnSL/Zp+0HJ4ICqYTIVFyQQVCnZ/RVsSRATHekfneDl3ot/9kT9wQ/TL2jzSm8P1eoPv/Wmo/S+0i8AkYxloJ/o22wtiCUUhjkEXr6PP8h1f/uMQLBAPsLJqcQ28TLH5biECXBNz/YI9J6HyuPLFA3KL6Zcmd9EaBDyi1V6VNX8CYSrpZ5zR4x2Ofdja/OYjJmJnSFR/niSH79sW20L7nuLH/g69leVroGyp436l0cd5miHKXLngPvbwAFr/NJQVxF1oyif/3LbgOh2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWSu71rpesPte4JlYjtJQCVDPUOpNgMhDcjfs70o8zQ=;
 b=c1GUjSBdqyNOk8mw6IlNIeUFKpP0Hd89rpnD7Cv4Vf6+cHvGbrwKuQMQdwRocKCBWrFxoXy3qAR0R4rjSTUNbbdF3P3Qj/UzJRZn0SVYhV2lEuOhwcLtvhsIBFnEZWZu+WZQV4sFer7S1h+/hVxOulEi7ZoW2suk6b8BvwJ3c01rktrL3DquGt/Wchk+TPcJJ/6nKy6RoUFbVrsFKdlJ8rPyPleyTO/LX+eUp3/S3jZIHEaN/1cSdiJK22+iwXDgP5acwOY1QufhIf8RzjBdZtONUxJRQ6eCNf9Pd2c3545qrsiW+5bESDf4BZ/ggLIJ/oyyIMPIaRM0rEPMCog2LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWSu71rpesPte4JlYjtJQCVDPUOpNgMhDcjfs70o8zQ=;
 b=EOn3K64Mhv2pkeKFBn1ixN5TEAMYVQJEF7u5tTLXNFbGwtwqqP8XrOsXNiHpRkT5pyQ5brxrdPZ1t5LMjjBYSzjxRER3khyR1cMd/KifynbBtEZ8qPmC5v4ETOHDDQtRaE3kBax5WkV5f+IjM6QBlDYxYMZRr898HoaDmwHhgi8s5tlad9ciYkbgIVFbunIA1Q3MXqRG/sElAjrqt3HQeWVLgcwJbTWQ8A+R0vkCbfHgfGL9rNH7KwBbh5TghJTro6e/3ap6c0UtaF0OdQxNMqY+fid+8rHqoDgYTdH+gRp6uvGNYDhGBad5CycIxYOcf9lWcn6WKfVW7dOOSJ+Ypw==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEYPR06MB6831.apcprd06.prod.outlook.com (2603:1096:101:1ac::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Tue, 6 Feb
 2024 02:15:24 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::79a8:927d:1e03:51d0]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::79a8:927d:1e03:51d0%7]) with mapi id 15.20.7249.032; Tue, 6 Feb 2024
 02:15:24 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v0 2/2] aspeed: fix hardcode boot address 0
Thread-Topic: [PATCH v0 2/2] aspeed: fix hardcode boot address 0
Thread-Index: AQHaWBO30bPHmM/RFku3sIerkZYRgrD7v+EAgADNTCA=
Date: Tue, 6 Feb 2024 02:15:24 +0000
Message-ID: <SI2PR06MB504152576FBA9C8017E2BB14FC462@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240205091415.935686-1-jamin_lin@aspeedtech.com>
 <20240205091415.935686-3-jamin_lin@aspeedtech.com>
 <7b35d498-0669-4b54-8111-a598b60981a1@kaod.org>
In-Reply-To: <7b35d498-0669-4b54-8111-a598b60981a1@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEYPR06MB6831:EE_
x-ms-office365-filtering-correlation-id: e11afbf3-f833-4a8b-f879-08dc26b97a72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 28GbYgggq0zmJYcPa4FM8704gWbNsnqlI8hz7cEGfjW0ckexuH+VTwnfJYdN25fJRY83sZ0QJsNcgVaD3ksf605FvOQOOuKZf5PnsOP3j58BjEHjsAp3rceJFeN27SongijbZ+jIKphtwfXnsh0ZjaPfVdFyjL38rVyduy6K3Ic0mFBvy4m/+gTPXunk2N+F7QQbLSlGf9qUZwuDTkXXvw6dmMaHkUdHvrC8xqQhZISTWTZf+qJuTH6VeWO9UTGP7TYc7EtvOJ4VE0cknC5vlofIknEu8cQMvqAW0TKI37zFZGZ1kQsQbDyGrKqrV3kzhNT1tx+yoZwW2kXjIDemdwGDdmlsQy8zyCFh/raHU4V8e+e00ITaymOz+W5roj6E3c2tk/f+8XDiDaCyokFYGijxOj484H44czmtX6Cf/OLpS90PFxdu2fLM5vuw7EK0eg0pBBKWJJ3etGxEkQITJK+6QVCQbQuFKaGUwofpAAqckh1oaCff0RmGYP9ZOhtzAdnpmtDM1AIMLurFEU8SHorrywBYIDV4OfD3vOTxC4oyADEpS9nvbgX28oIeneLaV0ehk/an3CioP6UwBmM+IiXdiKGODhmWwxEF43T99OWQlV2g11MH3fdnY2iqDwcM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(346002)(39850400004)(366004)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(107886003)(26005)(9686003)(52536014)(38070700009)(86362001)(83380400001)(33656002)(122000001)(38100700002)(2906002)(41300700001)(5660300002)(66574015)(8676002)(478600001)(55016003)(64756008)(316002)(66476007)(66946007)(66446008)(76116006)(66556008)(110136005)(8936002)(4326008)(53546011)(71200400001)(6506007)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFJJOUlneUxSNVN4dXVHMUVUNHowOG45K25Nc1RLSkxQZDJSZEk2Ym4waXhq?=
 =?utf-8?B?clFUZ0ZvQmhtVjRCMjkzQTdJQ25NT3N4ZWNSVHYwZnh0S2ZTdy9WRDlQekwy?=
 =?utf-8?B?ZEthU1VoZ2pMSEt3cVdKVUJVSEFQMWhITDF0QlIvMDE1emRPOTdWVkVHU3Nx?=
 =?utf-8?B?UzJPcXF5NXYrOWVtNTROV09CR1p5dmdlTWpPN0NQbURicXpCVFdONGxkbFB4?=
 =?utf-8?B?ajVtWlZmTUhZMkVBbFhiS2RSNWdUUzJHWEY3SmhxckNWNDBjUzVPVUpkQ0U5?=
 =?utf-8?B?NlJCaURKWjk1Y1ZqWmZmQUY5SFJiRkVhRWVmWlQ3djU4WnpNR0NGd1lmbmha?=
 =?utf-8?B?SlJFK2VGdndKcXpSY2owcW5LK3RTOWFCb2kwNndqbnlOaFIrSlo1b3R2Uk9r?=
 =?utf-8?B?UmI3WWRWbERvNUQyRkN5ZG40TEpZVGcwcGU5QWQ2eGhmR2ZVRktyVzBTWC9F?=
 =?utf-8?B?aUk1N3RwWmNEaWtlVFQxcko2OEMwMGFoWEd6SlZrd2lxbDhwaFBXeE1pZ0NV?=
 =?utf-8?B?eDhCdlJISmlGUmVPS1JjWFZmWHBjeGYzVTlSeFB5dUs5RGJOaHpheGdvR2Zl?=
 =?utf-8?B?Z1p4d1QyUUxpU3JpZ010Mk5YVHNvWEwwMzZhRWNrWUJaTjlra3dRL1VldHVy?=
 =?utf-8?B?Z1V6KzNJSzFLQzNjSThvT1VSckd3Q2ltTlpSaTM5VjFTNXRVN3k0Z281OWU2?=
 =?utf-8?B?RVFjeHVrOEFNZEZlMUhHaW5KdGU4ZnJadXZpa3hIdVpmcDZBUG50U3U0bk9O?=
 =?utf-8?B?dW9ERUgzbnN3ZkdoT2dGRXdadnZ5aE53RGtxRjdRSCtLb3FEWldBcWVUMkla?=
 =?utf-8?B?bFpNdzlHY0VjMFQySkJkbmxPbTRQTTM2L2diSEQrS2V0ZHhYVTNJblgxckda?=
 =?utf-8?B?bFcxRW1MWGdJbThKRmVvMjh2OU5wQmpSUlZFdkNOOHM3UGhCZnMyeWh5L2tq?=
 =?utf-8?B?NU5hNlBTYUp0dEhSYUtwdG5RMFN1bXVUbmEzL1NVMkdjWnJEc1ZCZHJ3V1hq?=
 =?utf-8?B?bGs0MSttZXM0WFpOYnlPU3BkdGFzQTNwS0tSWWdDSm9jZit5R0VDdUJidzZ1?=
 =?utf-8?B?ZTFiUmJ0N1pHdjNtSzhweTVuS29KdFN0UDdhVVp4N21tSTlxb0J4K3dDVm4y?=
 =?utf-8?B?L3UxUmRUckkxRVN4dkloUlphbnpzbGhnQ3NIUUpkeFRXNWxBbGQ0eDE3WXJ6?=
 =?utf-8?B?ajlmT0NuTC9FUi9YUkRUV1lJN0FZYVBiMFFxcm1lT3oxMW9Fb0JpVkovaGYv?=
 =?utf-8?B?czEyOU1Cd2pySlFkQTE3N0MrU0NUS2xtbnJnSFBuVnRXcExRQll0YWZQd0xS?=
 =?utf-8?B?Q2RoZFYyU015VWRGUFkyclUxMjBXdDRJeDFwZThRbWFuR0pRcXN6eFY4R0Ja?=
 =?utf-8?B?UkVOUFRicXZvcUxKOXdYVjBJQkVSVDdRcnlaZ3AyYzJXeTI4K3lwb283QlVs?=
 =?utf-8?B?VlpkVkl0dUVUUUE2NDMzVlU2NmpjSTVqWElsV3F4N2ExcUJ4ZzZzVEJ0T1l2?=
 =?utf-8?B?RVJRSUhVU291YnpkbnYzOHBvdVJwaFJpU0Y3dkQ2MEpqYUxtV2ZjSnk2Q3Fr?=
 =?utf-8?B?dVZQbnZSWFZiZ3dGSGUrWlFxdXFpeUh4VnpMNDY1Z0g0ejZuSWF6ZVJRL0Zt?=
 =?utf-8?B?dlBONkwwYnFDaGlXUGw4RGZoQldWN3h2V3l2L3FJTlZEb1NNaCt0ZzBiWXhO?=
 =?utf-8?B?ZmxRaXNvRUZsU1VFbTN4RUw1TnFzUGpxOGQwMjJWTHBuODZmTWpZQUtzUXRK?=
 =?utf-8?B?a1R5am45eFNUcjU5WEdJOGJjaDR6Y2k0WENWMlVrcHR5N2ljNUt6dm1KOThS?=
 =?utf-8?B?cXNQRGNHTEpSZ1kwRU1sQ1QvUTBZM0NrWHphVml2UnBtYlErL2IvckE4clhH?=
 =?utf-8?B?Y1J2aDBZTE55Y0RnY2xJSmV0cG1hTFRUQUhkL2JZZlUyajMzWlRkU0Y5aWph?=
 =?utf-8?B?YVNpU0txa0ZILzZWRUZXTVlieDdrSDBuZmtxK08wVnJYNTVvUzFiN0JqT1pZ?=
 =?utf-8?B?bk5MVHNMVW53T2VmWEU5WVM4SEpxcXE1cHNGYTFrdlluWUlSTHpNenBmOWs0?=
 =?utf-8?B?VU5OdmFXdFJqMnhreU9nTE5BTmpZeHBDaEJ0U0hCc21jY21rN09hbXVlWm1o?=
 =?utf-8?Q?fOIgVLJBg4zsa18CXOBKuLtqB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e11afbf3-f833-4a8b-f879-08dc26b97a72
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 02:15:24.4398 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aMYH9yw2G0SKlkARreeCkLkrU/YMDYO+2MZlzD9PxKUYOkFyqwlK//EXJd0RA8MqKbCa/U1d4JfJv/gdoHzoaw1+S+dTu3Cx4Sz1XRf/WNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6831
Received-SPF: pass client-ip=2a01:111:f403:c401::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SINPR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBNb25kYXksIEZlYnJ1YXJ5IDUsIDIwMjQgOTozNCBQTQ0K
PiBUbzogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBQZXRlciBNYXlkZWxs
DQo+IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBBbmRyZXcgSmVmZmVyeSA8YW5kcmV3QGNv
ZGVjb25zdHJ1Y3QuY29tLmF1PjsNCj4gSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47IG9w
ZW4gbGlzdDpBU1BFRUQgQk1Dcw0KPiA8cWVtdS1hcm1Abm9uZ251Lm9yZz47IG9wZW4gbGlzdDpB
bGwgcGF0Y2hlcyBDQyBoZXJlDQo+IDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+IENjOiBUcm95
IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjAg
Mi8yXSBhc3BlZWQ6IGZpeCBoYXJkY29kZSBib290IGFkZHJlc3MgMA0KPiANCj4gT24gMi81LzI0
IDEwOjE0LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gSW4gdGhlIHByZXZpb3VzIGRlc2lnbiBvZiBR
RU1VIG1vZGVsIGZvciBBU1BFRUQgU09DcywgaXQgc2V0IHRoZSBib290DQo+ID4gYWRkcmVzcyBh
dCAwIHdoaWNoIHdhcyB0aGUgaGFyZGNvZGUgc2V0dGluZyBmb3IgYXN0MTB4MCwgYXN0MjYwMCwN
Cj4gPiBhc3QyNTAwIGFuZCBhc3QyNDAwLg0KPiA+DQo+ID4gQWNjb3JkaW5nIHRvIHRoZSBkZXNp
Z24gb2YgYXN0MjcwMCwgaXQgaGFzIGJvb3RtY3Ugd2hpY2ggaXMgdXNlZCBmb3INCj4gPiBleGVj
dXRpbmcgU1BMIGFuZCBpbml0aWFsaXplIERSQU0sIHRoZW4sIENQVXMoY29ydGV4LWEzNSkgZXhl
Y3V0ZQ0KPiA+IHUtYm9vdCwga2VybmVsIGFuZCByb2ZzLiBRRU1VIHdpbGwgb25seSBzdXBwb3J0
IENQVShjb3JldGF4LWEzNSkgcGFydHMNCj4gPiBhbmQgdGhlIGJvb3QgYWRkcmVzcyBpcyAiMHg0
MDAwMDAwMDAiIGZvciBhc3QyNzAwLg0KPiANCj4gT24gdGhlIHByZXZpb3VzIFNvQywgdGhlIEFT
UEVFRF9ERVZfU1BJX0JPT1QgcmVnaW9uIGlzIGFuIGFsaWFzLCBhdCAweDAsIHRvDQo+IHRoZSBG
TUMgQ0UwIHJlZ2lvbiwgbWFwcGVkIGF0IDB4MjAwMDAwMDAuDQo+IA0KPiBJcyAweDQwMDAwMDAw
MCAob3IgMHg0MDAwMDAwMCA/KSB0aGUgYWRkcmVzcyBmb3IgRk1DIENFMCByZWdpb24gb24gdGhl
DQo+IGFzdDI3MDAgPyBvciBhbiBhbGlhcyA/DQo+IA0KSXQgaXMgIjB4NCAwMDAwMDAwMCIoNjRi
aXRzIGFkZHJlc3MpLiBDUFUgaXMgYXJtdjggY29ydGV4LWEzNSB3aGljaCBpcyA2NCBiaXRzIENQ
VS4gDQpUaGUgZHJhbSBiYXNlIGFkZHJlc3MgaXMgIjB4NCAwMDAwMDAwMCIuDQpUaGUgU1BMIGJh
c2UgYWRkcmVzcyBpcyAiMHgxIDAwMDAwMDAwIi4NCkZNQ19DUzAgcmVnaW9uIG1hcHBlZCBhdCAi
MHgxIDAwMDAwMDAwIiBhZGRyZXNzLg0KDQo+IFdoYXQgaXMgdGhlIGNvcnRleC1hMzUgcmVzZXQg
YWRkcmVzcyA/DQo+IA0KPiBJdCB3b3VsZCBoZWxwIHRvIGFsc28gaW50cm9kdWNlIGEgYmFzaWMg
c2tlbGV0b24gb2YgdGhlIGFzdDI3MDAgU29DLg0KPiANCkFTVDI3MDANClByaW1hcnkgU2Vydmlj
ZSBQcm9jZXNzb3I6DQpFbWJlZGRlZCBxdWFkLWNvcmUgQVJNIENvcnRleCBBMzUgNjQtYml0IFJJ
U0MgQ1BVDQpNYXhpbXVtIHJ1bm5pbmcgZnJlcXVlbmN5OiAxLjZHSFoNClN1cHBvcnQ6IE1NVSwg
RlBVLCBORU9OLCB0cnVzdC16b25lLCBHSUMtNTAwIGNvbnRyb2xsZXIgYW5kIHNvIG9uLg0KDQpC
b290TUNVOg0KSWJleC1yaXNjdiAzMmJpdHMgcmlzY3YuDQoNCkJvb3QgZmxvdw0KUk9NIENvZGUg
LT4gQm9vdE1DVShTUEwpIC0+IENQVSBDb3J0ZXggQTM1KFUtYm9vdC0+IGtlcm5lbCAtPiByb2Zz
KQ0KDQo+IEFueWhvdywgdGhpcyBjaGFuZ2UgbWFrZXMgc2Vuc2UuIENvdWxkIHlvdSBwbGVhc2Ug
cmVzcGluIGFuZCBhbHNvIHJlbW92ZQ0KPiBBU1BFRURfU09DX1NQSV9CT09UX0FERFIuID8NCj4g
DQpPa2F5LCB3aWxsIHJlbW92ZSBpdC4NCg0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCj4gPiBU
aGVyZWZvcmUsIGZpeGVkIGhhcmRjb2RlIGJvb3QgYWRkcmVzcyAwLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogVHJveSBMZWUgPHRyb3lfbGVlQGFzcGVlZHRlY2guY29tPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiA+IC0tLQ0KPiA+
ICAgaHcvYXJtL2FzcGVlZC5jIHwgNCArKystDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL2Fz
cGVlZC5jIGIvaHcvYXJtL2FzcGVlZC5jIGluZGV4DQo+ID4gMjE4YjgxMjk4ZS4uODJhOTJlODE0
MiAxMDA2NDQNCj4gPiAtLS0gYS9ody9hcm0vYXNwZWVkLmMNCj4gPiArKysgYi9ody9hcm0vYXNw
ZWVkLmMNCj4gPiBAQCAtMjg5LDEyICsyODksMTQgQEAgc3RhdGljIHZvaWQNCj4gYXNwZWVkX2lu
c3RhbGxfYm9vdF9yb20oQXNwZWVkTWFjaGluZVN0YXRlICpibWMsIEJsb2NrQmFja2VuZCAqYmxr
LA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDY0X3Qgcm9t
X3NpemUpDQo+ID4gICB7DQo+ID4gICAgICAgQXNwZWVkU29DU3RhdGUgKnNvYyA9IGJtYy0+c29j
Ow0KPiA+ICsgICAgQXNwZWVkU29DQ2xhc3MgKnNjID0gQVNQRUVEX1NPQ19HRVRfQ0xBU1Moc29j
KTsNCj4gPg0KPiA+ICAgICAgIG1lbW9yeV9yZWdpb25faW5pdF9yb20oJmJtYy0+Ym9vdF9yb20s
IE5VTEwsDQo+ICJhc3BlZWQuYm9vdF9yb20iLCByb21fc2l6ZSwNCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICZlcnJvcl9hYm9ydCk7DQo+ID4gICAgICAgbWVtb3J5X3JlZ2lvbl9h
ZGRfc3VicmVnaW9uX292ZXJsYXAoJnNvYy0+c3BpX2Jvb3RfY29udGFpbmVyLA0KPiAwLA0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZibWMtPmJvb3Rfcm9t
LCAxKTsNCj4gPiAtICAgIHdyaXRlX2Jvb3Rfcm9tKGJsaywgQVNQRUVEX1NPQ19TUElfQk9PVF9B
RERSLCByb21fc2l6ZSwNCj4gJmVycm9yX2Fib3J0KTsNCj4gPiArICAgIHdyaXRlX2Jvb3Rfcm9t
KGJsaywgc2MtPm1lbW1hcFtBU1BFRURfREVWX1NQSV9CT09UXSwNCj4gPiArICAgICAgICAgICAg
ICAgICAgIHJvbV9zaXplLCAmZXJyb3JfYWJvcnQpOw0KPiA+ICAgfQ0KPiA+DQo+ID4gICB2b2lk
IGFzcGVlZF9ib2FyZF9pbml0X2ZsYXNoZXMoQXNwZWVkU01DU3RhdGUgKnMsIGNvbnN0IGNoYXIN
Cj4gPiAqZmxhc2h0eXBlLA0KDQo=

