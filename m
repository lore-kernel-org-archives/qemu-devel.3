Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A48B0C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 03:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXYou-0006f8-Cq; Tue, 06 Feb 2024 22:41:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rXYor-0006d6-N7; Tue, 06 Feb 2024 22:41:54 -0500
Received: from mail-tyzapc01on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2011::701]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rXYop-0002n8-MO; Tue, 06 Feb 2024 22:41:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Um/GVt8rrKP9hXCHLHFjnGj4BetbnsGZ6LLvBObIl4pnwsyfYEJjdw8jhkgDAlTvIudbR1HNW3eR45xYRRlf7rJNUaggiCls+M0ry33NLLh2QTDpvO69bNTzEytr0pjC7cc5Vs4pMh0su82qAWCVktVx1IjtSciNnOENyVEHWBNB5tN96YGDbtCMajU0AIOfLcmi+mH/bTBlMJNei+j+bmzFJ/6l8bdOWW2jRKNLetqicgYvis7D9aSbOsDIKPW7WSgHhSjfygF3Rlz7Dv4KFWdFj5ntIeYf1XsneeV6Ysxz6xDHjqX67Uh2MCH8tAs7kqWAifIMcseNwVmM9C3iXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dDQt86nTalbrX+1zIoL8CfKjXnrMCSBqkYturzsqvc=;
 b=GXQ+GPyfFsvVeEwUdczplnBTYjiZNva9mSFWzA8XD5Mm6n1s1AeCMyQpqBeKbkrewqUEElnLQxnCmDiMEe+03GZ+7GoX5XZ37WfRqGWuSI9k8cEyNgcB9s9czokY25oPLRD+hT1m6T+JJwxv0nEP12caIa4poCIb17qdUPzGbxxDTPODSsRd24jOAlXM5kKqLpTePoHfqJibd9sCH1aYynVpNT3P3NMQvMJmMEtWiAx2jplXlK6Qa6jEV0eiEusjhKSK0Ocvh8UkiHyhXUHni1CbRGaLFKAgXaPYCGV8IsBSOEihb0mXbo9/Bd7o9Y5hR77JGETVQ3ONwQdhQN7GvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dDQt86nTalbrX+1zIoL8CfKjXnrMCSBqkYturzsqvc=;
 b=T35sNM6KwaKEpnfo7uEW2TzkcDIGRqwiDg7v9nnsefDDOnQaOD2mqvux7K7AoqpwJPwWaRsalPAfjZu1SyQLOjeZQ5m02QyhxPDF5V1MG62UtQ9c/XCjD6VCDfUcod28ZQ4szSiYUpk/UbdMCpgWTOTbyoJ4pZ2IaAzrBaBRxtk7Ch5sAkloIk/vNyIEwlopckRUpd9KNSiWJg5F/I1Pg1urf1uIH6EGS1RUgHrhxi2VbIXWnaSNX8hjzdDXRtja1D/eeR0Uem+ejnDvK/lWArKcbf2wz5PQ1ITVH29PactwhE4OZLZcL1ssiKndpmYKQXRV+zZwpTrMCw9AoB6oSw==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYZPR06MB6023.apcprd06.prod.outlook.com (2603:1096:400:341::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 03:41:42 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::79a8:927d:1e03:51d0]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::79a8:927d:1e03:51d0%7]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 03:41:42 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [v0 0/2] uart base and hardcode boot address 0
Thread-Topic: [v0 0/2] uart base and hardcode boot address 0
Thread-Index: AQHaWBO0Zy59L2t+qU6o5dbQw4unp7D9iEWAgAC2kQA=
Date: Wed, 7 Feb 2024 03:41:42 +0000
Message-ID: <SI2PR06MB50417F69DB4CFBAA29741991FC452@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240205091415.935686-1-jamin_lin@aspeedtech.com>
 <29131068-f8ef-4e78-8c42-89b6377b5d09@kaod.org>
In-Reply-To: <29131068-f8ef-4e78-8c42-89b6377b5d09@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYZPR06MB6023:EE_
x-ms-office365-filtering-correlation-id: 56b5085a-40c4-4c23-f67f-08dc278eb336
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KTbQIikoLct3UC7ncjgNTsgi7OoB5Zy/nGjyGrSgW7yVuZtntxZvv+JSRuuuLLkFWrY4+rjQQD54/E/s60DvrI9GnQ5J8pDGLK8w/+963Wk148fEp7X1LUNEuxlgNY3ItbQp7BiGue89+LHC9P34ICjx0lgVqSaDiZr/H7AxIlWbbDoRVbTgJMiDZqinnJY/mmUprjHQ5b9bFrCMNlBuByPMFoS3A2L7c5NftF5+wzYcb8PFECNmZDZ+os/bM4xavUmryo78doqsvxFGE7BSwBwQvbMyvjj8cAAICyzhPi/h6SEPp1TZzuLfdNmnLPrOtoJycsGZeSSmQvN1b6p91Wxuz6aXTmgw9QMWtHl1KKKgPeBqBKnqhObi6XoVYMqJaYjiLggHtGpLEMMoPBwqejbdfUXWQITB4QzSk9hZXFFl6d2aHeI0jEPx5iVNFoabjBE3LOyAqNPd94/pepoqMtahY6lBkRblcV3ZMTw1qKpTvsQT58FBoVQRgNwkPPOIHD2rzDrqwHzGaDdnZyP3GP2Q0y1jIBi/WIsMloJpzSibMpLFLGzGKsdHzKFyGxFpNIK0OOrQPxPWBEVYuDuJqG064Wa7CzO2JEDc+L/v4aIfC8WwYV1iDktbWc0ODho6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(376002)(366004)(39840400004)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(38100700002)(33656002)(53546011)(7696005)(122000001)(6506007)(55016003)(83380400001)(86362001)(41300700001)(26005)(52536014)(478600001)(107886003)(8936002)(4326008)(8676002)(9686003)(71200400001)(2906002)(5660300002)(4744005)(64756008)(66946007)(110136005)(66446008)(316002)(66476007)(66556008)(76116006)(38070700009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXVYa3VpM2FmQVZKcG55eVVJNjg5R3o4QnlaZ3l5b3g4bWNSbUV4NDN1Vk05?=
 =?utf-8?B?dWY3UkhqWm9pWUVQbXZYQ0FkYXNYZHBEZ1EySnBsSGlid1ZwZ2QwYzQzMTNx?=
 =?utf-8?B?TTFwRzJUc1NjYjUwcTYvWC9LKzVoRTNFVk40SmtTNGYwd2dXbzRrcTdsWnNC?=
 =?utf-8?B?c1M4cEIrOThIQVpGL1JyTzlScWxoKzFobWJmajV1WGFrRDlmalBIRytqWm5o?=
 =?utf-8?B?TGVrWHc1Q010VFVTMU5jb2ZKUXdObkwvYU9QVmtmQ3N0dllTbEdoc1BPaVdJ?=
 =?utf-8?B?MUFzdkZLQndDSGNSSkkraEgycGpsMzJTSWliM0NVZTd1WXBzbjBoS2pNUFdU?=
 =?utf-8?B?ZHVXOTRiVnA1MU1HRWY3ZWlPZ0htVUpiL25NVExIU1ZTaTNKTmEvZWQvWXNL?=
 =?utf-8?B?aHN3R0NTMjNkbXkvVldDdGxPSGlUZjV5VGVHdE52TnU1Um9ZZWdQbFhoNHBv?=
 =?utf-8?B?OWUzTXQ1YzBxOHRBcjJSWE42VFNpUUNtcFlKakp0bVo2cGFwWFVEb3RwRzdC?=
 =?utf-8?B?eHNvOFQ1U1l1TG5td0tUampVSDBmaVphYnNRUHdSU0l4R2wzSjFwdmx4K3oz?=
 =?utf-8?B?SUtIbXl6Z0FFRUhLbktRNHFoL0Q2cEhtRG81YkhpTXowL0lMS0hCT3N2Ri9Q?=
 =?utf-8?B?Ly9uU2Z2QmRBUWdCbk9mSVAvNEZVcG5zazkyUG9hcGM2QTMzRlh4VDY2MmJw?=
 =?utf-8?B?MW1Dem50cnlsb3NGclArTk5ySFRmNWxDSDBHTmpzMkhlTHBuRE1ORkliWWdn?=
 =?utf-8?B?aFQ4S2JIWnQvWFVrT3BUVWg0b0dvTXYxL1o0Y3NBc1hURXo1ZEdBZTNoV2Nk?=
 =?utf-8?B?bUF4NE4yMm9LTHJBT01iOXBUUy9abHFITlhmdkU4TS9MUlJBM1pPODNCZUNE?=
 =?utf-8?B?YnJjeHdhNittU0t2RitwaDlZMmYwZFdLb2xLbEp5dm93WkNieUwyM0NzUnVD?=
 =?utf-8?B?ako5RW9lRVNYeC9naitXL1ZCbEhlRExkUG5vdkkvQXVFYnhNcGV3TU9UT0ta?=
 =?utf-8?B?MHU2YXVTN3Q2ZGdVcEl4bFVuK1JZQ2s4THJUL3pzK2gxd2xPSVltZW04NmZB?=
 =?utf-8?B?S2tNSE1BT0xGT21jcFlNalc2cjc4MDRhQ3dpK3JBS1N5N21lUkNmaUgrbWdO?=
 =?utf-8?B?SnB0NTN0SUp6ak1ucyt4aUl6V2Nyb3RJRmVZVFZ2MVdTZGp0RnFrang4d0RK?=
 =?utf-8?B?NWZrMXgycFZIQ29pMHlEL1dUR2t2bU5EZVJBT1MwZ0diWXpmK0dBWFRGMExz?=
 =?utf-8?B?KzdSRlBrc21UZ1FaZXdLYzU5ajU4NWdyZWJQN29XM3FVUTVMSHdsYTZSUkVF?=
 =?utf-8?B?V1FQd3RDR1FsbE9qSGN3ZjdUMllENjN1dXcyQjhJU2tBbWlJcVNhS2o4REVm?=
 =?utf-8?B?OVAzcHBCbTNGVGF1SjdUV2hYemMraDhUWWE0a3B2ZVBVZTk1bUhHK1pWNVBC?=
 =?utf-8?B?OU1PMno2QjhIOE9IZ0NhaU5YRFpyUERaOEpRUmJPRUVMQmxNeWNMVVI5ZHZi?=
 =?utf-8?B?L0JCYWhqOHY3bVRyNUoyTTc5WXFwV3htTjd1R2kyNjIwQ3NNbjQzQitiZWlO?=
 =?utf-8?B?elFHK3dMYWQzU0ZUNjhpUW9CSDJwVnRDd0t0bmo1Umd6TUQ2azRFcitOSmhm?=
 =?utf-8?B?bWpLa3BwTlN0V2FEbldkd3NYOU1VYVQzMVpMcmpOUmx0VmlFVXdaRkRGeWVv?=
 =?utf-8?B?KzFVTEZWQ3gxZU1DdmhVb1hLcUJqTUpIR3ZiVXRsOVVXdWhYSXhGR2MzaTNL?=
 =?utf-8?B?bWNuTFBVYzZtYjZ0amozUTExZVd6bHRINjZQSThlRVVnOERnUnp1eW5hVGFs?=
 =?utf-8?B?enp1dmVZcldFTCtPN2hob2FyU1hEWjV6N2JzSWJWNEc5dDBIL3grbk5aUW1a?=
 =?utf-8?B?YlNQY3pNc1pFVzRmRytiSHNCOWNERGd3RG9jNWYzYTR5ayt6dnF4aDg2dEd4?=
 =?utf-8?B?Q01ZY29vdWVZR3hBVWNVY1hzTnlJQk8xZXRvTFpCamw4eDJnSDRKQ3psMFlG?=
 =?utf-8?B?dUZwNWJsK1NHUXFsNFp2RVljMnIrZ0V1VHc2aUM0VjRPYitMQkZaRlp3aGZ4?=
 =?utf-8?B?SHZLKzQ4Y3pGNk5kc2RwUFQxZHk4cnVWRlp5Qzhha3ltQlN5WVFmNTBhak1i?=
 =?utf-8?Q?664k5apLEf5Z4KEkIyulgxiwa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b5085a-40c4-4c23-f67f-08dc278eb336
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 03:41:42.4706 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1RRo47szRfiWK7ZvDmSEoReAa105PsZB+tTu/MomWDw74aQkBsavHrGnunyEOLmJX2ZEsth/d7Ha81RZdRUXnbZ9Gb88b3t3nfzgdhwas2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6023
Received-SPF: pass client-ip=2a01:111:f403:2011::701;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
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
Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDcsIDIwMjQgMTI6NDgg
QU0NCj4gVG86IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPjsgUGV0ZXIgTWF5
ZGVsbA0KPiA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgQW5kcmV3IEplZmZlcnkgPGFuZHJl
d0Bjb2RlY29uc3RydWN0LmNvbS5hdT47DQo+IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+
OyBvcGVuIGxpc3Q6QVNQRUVEIEJNQ3MNCj4gPHFlbXUtYXJtQG5vbmdudS5vcmc+OyBvcGVuIGxp
c3Q6QWxsIHBhdGNoZXMgQ0MgaGVyZQ0KPiA8cWVtdS1kZXZlbEBub25nbnUub3JnPg0KPiBDYzog
VHJveSBMZWUgPHRyb3lfbGVlQGFzcGVlZHRlY2guY29tPg0KPiBTdWJqZWN0OiBSZTogW3YwIDAv
Ml0gdWFydCBiYXNlIGFuZCBoYXJkY29kZSBib290IGFkZHJlc3MgMA0KPiANCj4gT24gMi81LzI0
IDEwOjE0LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gdjA6DQo+IA0KPiB1c3VhbGx5IHdlIHN0YXJ0
IGF0IHYxLCBzbyB0aGUgbmV4dCB2ZXJzaW9uIHdvdWxkIGJlIGEgdjIuIEluZGV4aW5nIGFnYWlu
IDopDQo+IA0KR290IGl0Lg0KVGhhbmtzLUphbWluDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0K
PiANCj4gDQo+IA0KPiA+IDEuIHN1cHBvcnQgdWFydCBjb250cm9sbGVyIGJvdGggMCBhbmQgMSBi
YXNlIDIuIGZpeCBoYXJkY29kZSBib290DQo+ID4gYWRkcmVzcyAwDQo+ID4NCj4gPiBKYW1pbiBM
aW4gKDIpOg0KPiA+ICAgIGFzcGVlZDogc3VwcG9ydCB1YXJ0IGNvbnRyb2xsZXIgYm90aCAwIGFu
ZCAxIGJhc2UNCj4gPiAgICBhc3BlZWQ6IGZpeCBoYXJkY29kZSBib290IGFkZHJlc3MgMA0KPiA+
DQo+ID4gICBody9hcm0vYXNwZWVkLmMgICAgICAgICAgICAgfCAxMiArKysrKysrKy0tLS0NCj4g
PiAgIGh3L2FybS9hc3BlZWRfYXN0MTB4MC5jICAgICB8ICAxICsNCj4gPiAgIGh3L2FybS9hc3Bl
ZWRfYXN0MjQwMC5jICAgICB8ICAyICsrDQo+ID4gICBody9hcm0vYXNwZWVkX2FzdDI2MDAuYyAg
ICAgfCAgMSArDQo+ID4gICBody9hcm0vYXNwZWVkX3NvY19jb21tb24uYyAgfCAgNCArKy0tDQo+
ID4gICBpbmNsdWRlL2h3L2FybS9hc3BlZWRfc29jLmggfCAgMSArDQo+ID4gICA2IGZpbGVzIGNo
YW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+ID4NCg0K

