Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91C6C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 03:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXYr0-0008I8-97; Tue, 06 Feb 2024 22:44:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rXYqy-0008Hh-Dz; Tue, 06 Feb 2024 22:44:04 -0500
Received: from mail-sgaapc01on20714.outbound.protection.outlook.com
 ([2a01:111:f400:feab::714]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rXYqw-00035u-O9; Tue, 06 Feb 2024 22:44:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgOatTizxk7m6RuaaHUeokQL+XywQIUJdHjoaqudUv/sOmFOM9jS/iyhSQvgZ0r1bZP6j9GoLMIcBy1DW2bFdnN/ZhYJeqXgoEBx/j8uRp9yN71UKmgRU+OybUlDfNCnAYnv6Fa20PTiE/O80/yN0O++pnSR82YlpKh4mfsqfDrGk0nHYvFI0XZVXBxFPLOfhRWBMgUhR1IEMQV1nx3F/lToKQqnOIb7W+x6UM1FkNYC63dUkNAksCT9JxqjhwzODr/DmnpBxUai3hwSzQXayy6+Aa/DBmHowqMuJM95zbIbo9YkEUv0AHU8iLyTBUe6DwCP+gMMDrjvyj+SZb2AOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9oYvzAZ2mnsnPjHyyNbjU+SoAU/maoRXYDLqyGMxPY=;
 b=AwMtFuGjhaUNnoYoeTEfbYyGiQZCQLQzz/ZBQSHX9IUYe7GOOdMgbxic6Gvbo+BnmxUab3wPOgt3kNEqrtSGfQhO+aVXgm/7tvHD6I5NzGNQh8JIwlxPlEYaml2+NlCwGdlKbQD+seuXeokp22/YGn+UyNjg9Tfhc2+rNKkgvf4CFVXTkj97+NcpvXQoFwQmXx4ugpShymTY7wtdoezGM/NrEVxu0N6hLWXXKW4BzeT+E4ZPWcLKbWpPReB1rYVgLIW09fTeCuhllnr7hDeYBFZ7oA9XQFuThyK/ycHGeL6CchAFoX6Umx0/Lr6czwmZVsgvGsRMKTAjMciHfVj3jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9oYvzAZ2mnsnPjHyyNbjU+SoAU/maoRXYDLqyGMxPY=;
 b=nCsJY7dcuZGpgnsz9HKGhqG7FTO1JWRlfk06zu2uYd/nKUmolhu0ZJM0aul2qV1cdFqcgRGebffttTupaDUIqinp8E5HwhH2X833bEf7grorIx4/w5Az0BSfrl2EDr5evxb3i5cAiokIl8Egqc87a5vbvbEeQRR9MPpm4U9tReAeg7LOTW/h439AqOaCk7UaHBIRdG9u4OTaNl5i87RAOV+R4Gl5cZZXwtQEmn4MOrs3h24nQV+M4yRC9mOsB+b874T2pKXGKYw3c1TLmTds39uMIn9+ZUZ1f0Pz9PYpH8vR//gF61If3Ev+0s9wuH0uzDfIUYJygEzqffXTxVVwmg==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYZPR06MB6639.apcprd06.prod.outlook.com (2603:1096:400:45b::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.36; Wed, 7 Feb 2024 03:43:53 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::79a8:927d:1e03:51d0]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::79a8:927d:1e03:51d0%7]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 03:43:53 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v0 1/2] aspeed: support uart controller both 0 and 1 base
Thread-Topic: [PATCH v0 1/2] aspeed: support uart controller both 0 and 1 base
Thread-Index: AQHaWBO1pIX+mXoppkCs9A5dfg25WbD7kN+AgAA9OQCAANX3QIAA538AgACz0IA=
Date: Wed, 7 Feb 2024 03:43:53 +0000
Message-ID: <SI2PR06MB5041FB3C1DD5CE419D1016A0FC452@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240205091415.935686-1-jamin_lin@aspeedtech.com>
 <20240205091415.935686-2-jamin_lin@aspeedtech.com>
 <aab5b2fb-e7f0-434b-935c-ff5ad5d39f21@kaod.org>
 <30e7e323-369b-4ee3-994e-a6cb9205a4f9@kaod.org>
 <SI2PR06MB5041FC68062741DB853B979EFC462@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <21cf49a2-8e3a-4dc5-9b3c-841818b20469@kaod.org>
In-Reply-To: <21cf49a2-8e3a-4dc5-9b3c-841818b20469@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYZPR06MB6639:EE_
x-ms-office365-filtering-correlation-id: 40cfcca1-5d38-4866-2fc2-08dc278f015d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vbJ4ImhtVTX9h3eyZqB4PwVLqaz2P6rGa7IF9pkhOIfH4KkTwYeN0uc7VFlG46w8kFqoVLHkfyuoM1hs3fdi7E/8JYSboFRsN+fjFZRqWwpX66r13sFJEQ5MuhW9w/TO3921gSKtcT285usDXcJt31D4UGlTsJxXTMPtWvBNffVLjJXTvz9xI3rg94xq0aLQnTgCyIpVzhtGLTZfLWcvUMn9Ze1hjDDfaKnQQWPzDLZRoEvBhP5K23WhIcyC85PNJ3odTvOIzNRdf6/uqAdVnjPC5EE0/6ARH2ehZqj3NWjNSU+dNZrmOEmbLFxqZ+fEkv2QJoLY+KE6jfYW0ilkyy9+H3oOg4CntCXmymNHUgBlXrMroPT1UDqTEE/ZjTLHV/9WB7aqHngaVwFv1Xa7FkadMFC6maqtTIRUNprv0Kp8on0pszcpaPOv0Xty/dGTiuyNnTtN2thphYm3QMyOj+vo3eu8KLhDvMWGOQtRE2ViD5dXU/BXbtB8EVI4i5k2tsa+EX6sYjaSNFMuYluoqs1OYOqTGtf673CJ7AMt2R6FGNaFrm/uN+miIcdCsDQHuiofP//TcTlfA7ZQq0/qQ+rINRNePVaIWZQdweTk+vU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(39840400004)(346002)(366004)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(41300700001)(38070700009)(110136005)(64756008)(66476007)(66556008)(66446008)(76116006)(66946007)(52536014)(316002)(5660300002)(8676002)(8936002)(4326008)(2906002)(83380400001)(38100700002)(122000001)(55016003)(53546011)(9686003)(71200400001)(86362001)(966005)(66574015)(33656002)(26005)(107886003)(6506007)(7696005)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFEwSDNtSjI1YldPOEs0WE0wa3FDRjRTVFhyenRIR3RNTUlOdEJRbWpVU3Zr?=
 =?utf-8?B?Y2sxZEV4aDM5SHBTV3preG1ydU1xOEVseXZLcGE3TjJqMnE1b1JWTDE5RnRY?=
 =?utf-8?B?Vy9FNDFLVlpidGc2UGZpMjZ3Q3NESUVMYkZIVGpsL1BiYW05bjNwWXhZSG5C?=
 =?utf-8?B?bUJlUkFzV0RsejRWcUJTRytWSVVveVNoSU13YVlOSHBlb1EvYlhsem54QUFP?=
 =?utf-8?B?eElveEpTNmtjRElsTmJGNGQ1bjNsc0c4ZmZEU1NWY2E4V0haamtrbmExaThn?=
 =?utf-8?B?K01QSEExV2JWRzUyeWtBSHh5dDhlVHRBK1Q1TkZZdk5scHkxMm53UktJM0VR?=
 =?utf-8?B?cWRLdUMrMlY4ay9GMU9WVU9pYWltWGd2QVF6UFptdlNqSmRZdHNUSFovT1RU?=
 =?utf-8?B?cXQ5dHdkWGU3bkZEbXZqUWdlVUh2SmRiVzZtMFFSK0VKU2xCZS9RMlIvMjV6?=
 =?utf-8?B?eUQzWVZvNStVTG5tc1hMQlRpeFdRK0Zac2lBQ1dzNUlYU3dseDZKY3ZpclY4?=
 =?utf-8?B?NUpXWW54SERqUHVwUWczalBDOWxoYU1GRy9TdE0rRWFIMnhMdXloMDQwdDI4?=
 =?utf-8?B?ak95Vm5mZy9xTkR6eW9oYldOTXZubmcvSkdDeG1zbk8yYjF4aUZJelMwNkZq?=
 =?utf-8?B?VThvbkVMMDE3dWhLdVlKMVlpUDJRdVl0ekw4SXgyamk1a3AxMzlwWER0dzFi?=
 =?utf-8?B?bjdHaE9VbmduS3hzZHBXWHBVM2RuRlBKK3Qwa3J6ekZDWk9RRFBmckJRanpo?=
 =?utf-8?B?Y2QyMlpJWkZsR1FvREo3RkR6aU1id0R1M3VBSmxZUEFncEtEU3NyeFpVZWtk?=
 =?utf-8?B?SnZRanRRR0orckMvM1FWbXVhVWxxOUxjSDhRRGl2cHRZME1FNm9rZmM0RWg0?=
 =?utf-8?B?blNoRElnYkJVcGdwY3NPNFdydGQyRW1HVUhuR0doU0lLRGN3cWF5YkVLQmRk?=
 =?utf-8?B?WmV3RDJmV3REdTRlc3hKUVIwamQ4a0VMRFdDWDlZUlBjZSt0MktUZU1MYWoz?=
 =?utf-8?B?cEo5UC9tK1BDbXcwdmJVL09QTG93Q0FieHNGUjErNVpnakl4NlExdld2Y294?=
 =?utf-8?B?Vnc4RVNFT0k2blpnbTU4RE4vTk9rTnFHV0Q5UW1sMVFEU1lWTCs3VkUwOTZs?=
 =?utf-8?B?ait6am8rOFgwZHhET3l3c3MvclJobFlqS0V1R0dKWHgwbURDVmRCR3lXa0Jr?=
 =?utf-8?B?MmV3RHQzaEgzOWtGaERPUmZ4MExGOWIrTnJPNlcrYUVsMjZrWmtzeVowNHVm?=
 =?utf-8?B?bXZhcjV6bDlQSjd5SWprQytURVcyUkUwNXpZQ2lSSHpWUVMyY3MvM3M5V0lT?=
 =?utf-8?B?NUlLTlBmRjdjOWJRa3g4VnBQUWRPZzRuczI5Q3hKT3BVZ0tLbGgzc0hXSVJr?=
 =?utf-8?B?cGtYYys5TXFTeHArV1R5UXByMzcrakozVUdxVmhpK1BLdlJKV2FSdjFDbG9E?=
 =?utf-8?B?ekQ5RE9pWTJ5YzZ4MXRMWS9hejBUUlVRZ1hzQXBWTk1vQzFBWmp5TjRHck1V?=
 =?utf-8?B?UFZKWjM1cDhNTmhWZVBKQ1NNM0FHNkhtaHJURUw1Q3BKMTBkT2dIcjQxQlB0?=
 =?utf-8?B?YmhleG9SLzFiYUpVKzAzK0lXN09NNVdZRHBSeTZpSExPcUlXTEZQWG9JY0pH?=
 =?utf-8?B?ZDdTNXBjaHF4SzVVdFo3SlZtQ2pzbXBjL1NmaXZjejZUWDMwdmVuMG5zaDlE?=
 =?utf-8?B?MDB1WGUra1BYZmJmTDlKa0pVcGNmNFp2WFN3WUZxekRGaElMUUE3NUlKVG5G?=
 =?utf-8?B?alpvTGJnNVliOEw1cEZnTEV5UG9rMW1NQ0IzcFI0NEQ1WTlGVkpnY0ZlNUs3?=
 =?utf-8?B?M3NHSGlpeHBSakZVMW9neEVDQnpCV0FDYk5PV3ZSM2k5MTZKS2E3am15QWV3?=
 =?utf-8?B?M25sckJLSFp0RVhxQlp5QVpXY2ZMVk5xV2ZoVWtMb3VQK1lGR1FhTFk4SkNM?=
 =?utf-8?B?bEwvaVNSTWtqL2tXZXlzV2h0cXdXUlowMFRZQ2VHTjVKT2kvSDF0Vnk4azE5?=
 =?utf-8?B?MkpHSmw5OGl6d3R5QmV6eHVkem04UE9NdHNDN0pyYnpVQ3c5RHhLMGE4SFlo?=
 =?utf-8?B?RVkwcVZJV0x3MnhISkhYUlBCVFJHUDJxcW1Zc1RBZzlQVGZSMjF4bjkzNTdm?=
 =?utf-8?Q?uEWeNcJ9p/GOh5e5TWa3vOGJu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40cfcca1-5d38-4866-2fc2-08dc278f015d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 03:43:53.6137 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sN3oGeDlw5Ps1rnOa/AkXXyA/VyLBkQvA6LESUHMiC8CCyFp3emuITZ4LVY6993G+PihJNCqq4tsAV4b2Hc8e203sPPs+ZkDS5G+wN+7c0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6639
Received-SPF: pass client-ip=2a01:111:f400:feab::714;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
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
Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDcsIDIwMjQgMTowMCBB
TQ0KPiBUbzogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBQZXRlciBNYXlk
ZWxsDQo+IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBBbmRyZXcgSmVmZmVyeSA8YW5kcmV3
QGNvZGVjb25zdHJ1Y3QuY29tLmF1PjsNCj4gSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47
IG9wZW4gbGlzdDpBU1BFRUQgQk1Dcw0KPiA8cWVtdS1hcm1Abm9uZ251Lm9yZz47IG9wZW4gbGlz
dDpBbGwgcGF0Y2hlcyBDQyBoZXJlDQo+IDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+IENjOiBU
cm95IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djAgMS8yXSBhc3BlZWQ6IHN1cHBvcnQgdWFydCBjb250cm9sbGVyIGJvdGggMCBhbmQgMSBiYXNl
DQo+IA0KPiBPbiAyLzYvMjQgMDQ6MjksIEphbWluIExpbiB3cm90ZToNCj4gPj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gVGhlIHVhcnQgZGVmaW5pdGlvbnMgb24gdGhlIEFTVDI3
MDAgYXJlIGRpZmZlcmVudCA6DQo+ID4+DQo+ID4+DQo+ID4+IGh0dHBzOi8vZ2l0aHViLmNvbS9B
c3BlZWRUZWNoLUJNQy9saW51eC9ibG9iL2FzcGVlZC1tYXN0ZXItdjYuNi9hcmNoLw0KPiA+PiBh
cm0NCj4gPj4gNjQvYm9vdC9kdHMvYXNwZWVkL2FzcGVlZC1nNy5kdHNpDQo+ID4+DQo+ID4+IAlz
ZXJpYWwwID0gJnVhcnQwOw0KPiA+PiAJc2VyaWFsMSA9ICZ1YXJ0MTsNCj4gPj4gCXNlcmlhbDIg
PSAmdWFydDI7DQo+ID4+IAlzZXJpYWwzID0gJnVhcnQzOw0KPiA+PiAJc2VyaWFsNCA9ICZ1YXJ0
NDsNCj4gPj4gCXNlcmlhbDUgPSAmdWFydDU7DQo+ID4+IAlzZXJpYWw2ID0gJnVhcnQ2Ow0KPiA+
PiAJc2VyaWFsNyA9ICZ1YXJ0NzsNCj4gPj4gCXNlcmlhbDggPSAmdWFydDg7DQo+ID4+ICAgICAg
ICAgICAuLi4NCj4gPj4NCj4gPj4gSSB0aGluayB0aGUgbmFtZXMgaW4gdGhlIERUIChhbmQgY29u
c2VxdWVudGx5IGluIHRoZSBRRU1VIG1vZGVscykNCj4gPj4gZm9sbG93IHRoZSBJUCBuYW1lcyBp
biB0aGUgZGF0YXNoZWV0Lg0KPiA+Pg0KPiA+PiBJIGRvbid0IHRoaW5rIHdlIGNhcmUgaW4gUUVN
VSwgc28gSSB3b3VsZCBiZSBpbmNsaW5lZCB0byBjaGFuZ2UgdGhlDQo+ID4+IGluZGV4aW5nIG9m
IHRoZSBkZXZpY2UgbmFtZXMgaW4gUUVNVSBhbmQgc3RhcnQgYXQgMCwgd2hpY2ggd291bGQNCj4g
Pj4gaW50cm9kdWNlIGEgZGlzY3JlcGFuY3kgZm9yIHRoZSBBU1QyNDAwLCBBU1QyNjAwLCBBU1Qy
NjAwIFNvQy4NCj4gPj4NCj4gPj4gTGV0J3Mgc2VlIHdoYXQgdGhlIG90aGVyIG1haW50YWluZXJz
IGhhdmUgdG8gc2F5Lg0KPiA+Pg0KPiA+PiBUaGFua3MsDQo+ID4+DQo+ID4+IEMuDQo+ID4gSGkg
Q2VkcmljLA0KPiA+DQo+ID4gRGlkIHlvdSBtZWFuIHRvIGNoYW5nZSB0aGUgbmFtaW5nIG9mIHVh
cnQgZGV2aWNlIHRvIDAgYmFzZSBmb3IgYWxsIEFTUEVFRA0KPiBTT0NzPw0KPiA+IElmIHllcywg
aXQgc2VlbXMgd2UgbmVlZCB0byBkbyB0aGUgZm9sbG93aW5nIGNoYW5nZXMuDQo+ID4gMS4gYWRk
IEFTUEVFRF9ERVZfVUFSVDAgaW4gYXNwZWVkX3NvYy5oIDIuIFJlLWRlZmluZWQgdWFydCBtZW1v
cnkgbWFwDQo+ID4gZm9yIGFzdDI2MDAsIGFzdDEweDAsIGFzdDI1MDAgYW5kIGFzdDI0MDAodWFy
dDAgLT4gQVNQRUVEX0RFVl9VQVJUMCkNCj4gPiBUYWtlIGFzdDI2MDAgZm9yIGV4YW1wbGU6DQo+
ID4gc3RhdGljIGNvbnN0IGh3YWRkciBhc3BlZWRfc29jX2FzdDI2MDBfbWVtbWFwW10gPSB7DQo+
ID4gICAgICBbQVNQRUVEX0RFVl9VQVJUMV0gICAgID0gMHgxRTc4MzAwMCwgLS0tPg0KPiBbQVNQ
RUVEX0RFVl9VQVJUMF0NCj4gPiAgICAgIFtBU1BFRURfREVWX1VBUlQyXSAgICAgPSAweDFFNzhE
MDAwLCAtLS0+DQo+IFtBU1BFRURfREVWX1VBUlQxXQ0KPiA+ICAgICAgW0FTUEVFRF9ERVZfVUFS
VDNdICAgICA9IDB4MUU3OEUwMDAsDQo+ID4gICAgICBbQVNQRUVEX0RFVl9VQVJUNF0gICAgID0g
MHgxRTc4RjAwMCwNCj4gPiAgICAgIFtBU1BFRURfREVWX1VBUlQ1XSAgICAgPSAweDFFNzg0MDAw
LA0KPiA+ICAgICAgW0FTUEVFRF9ERVZfVUFSVDZdICAgICA9IDB4MUU3OTAwMDAsDQo+ID4gICAg
ICBbQVNQRUVEX0RFVl9VQVJUN10gICAgID0gMHgxRTc5MDEwMCwNCj4gPiAgICAgIFtBU1BFRURf
REVWX1VBUlQ4XSAgICAgPSAweDFFNzkwMjAwLA0KPiA+ICAgICAgW0FTUEVFRF9ERVZfVUFSVDld
ICAgICA9IDB4MUU3OTAzMDAsDQo+ID4gICAgICBbQVNQRUVEX0RFVl9VQVJUMTBdICAgID0gMHgx
RTc5MDQwMCwNCj4gPiAgICAgIFtBU1BFRURfREVWX1VBUlQxMV0gICAgPSAweDFFNzkwNTAwLA0K
PiA+ICAgICAgW0FTUEVFRF9ERVZfVUFSVDEyXSAgICA9IDB4MUU3OTA2MDAsDQo+ID4gICAgICBb
QVNQRUVEX0RFVl9VQVJUMTNdICAgID0gMHgxRTc5MDcwMCwgLS0tPg0KPiBbQVNQRUVEX0RFVl9V
QVJUMTJdDQo+ID4gfTsNCj4gPiBJZiBubywgY291bGQgeW91IHBsZWFzZSBkZXNjcmlwdCBpdCBt
b3JlIGRldGFpbD8gU28sIEkgY2FuIGNoYW5nZSBpdCBhbmQgcmUtc2VuZA0KPiB0aGlzIHBhdGNo
IHNlcmllcy4NCj4gDQo+IExldCdzIGtlZXAgdGhlIGRhdGFzaGVldCBuYW1lcy4gSSBoYWQgZm9y
Z290dGVuIHRoZSByZWFzb24gaW5pdGlhbGx5IGFuZCBmcm9tDQo+IGFuIEhXIFBPViBpdCBtYWtl
cyBzZW5zZSB0byBrZWVwIHRoZW0gaW4gc3luYy4gSSB3aWxsIGFkZCBzb21lIG1vcmUNCj4gY29t
bWVudHMgdG8gdGhlIHBhdGNoLg0KPiANCj4gPiBCeSB0aGUgd2F5LCBJIHdpbGwgc2VuZCBhIG5l
dyBwYXRjaCBzZXJpZXMgdG8gc3VwcG9ydCBBU1QyNzAwIGluIHR3byB3ZWVrcy4NCj4gPiBXZSBl
bmNvdW50ZXJlZCBHSUMgaXNzdWVzLiBJdCBzZWVtcyB0aGF0IFFFTVUgc3VwcG9ydCBHSUMgdjMg
YnV0IFNQSSBkaWQNCj4gbm90IHN1cHBvcnQsIHlldC4NCj4gPg0KPiA+DQo+IGh0dHBzOi8vZ2l0
aHViLmNvbS9xZW11L3FlbXUvYmxvYi9tYXN0ZXIvaHcvaW50Yy9hcm1fZ2ljdjNfZGlzdC5jI0wz
ODMNCj4gPiBodHRwczovL2dpdGh1Yi5jb20vQXNwZWVkVGVjaC1CTUMvbGludXgvYmxvYi9hc3Bl
ZWQtbWFzdGVyLXY2LjYvYXJjaC9hDQo+ID4gcm02NC9ib290L2R0cy9hc3BlZWQvYXNwZWVkLWc3
LmR0c2kjTDIyOQ0KPiANCj4gSWYgeW91IGRpZCBhbnkgaGFja3Mgb3Igd29ya2Fyb3VuZHMgaW4g
dGhlIFFFTVUgbW9kZWxzLCBwbGVhc2Uga2VlcCB0aGVtDQo+IHNlcGFyYXRlIGZyb20gdGhlIG90
aGVyIHBhdGNoZXMgc28gdGhhdCB3ZSBjYW4gZGlzY3Vzcy4NCj4gDQpPa2F5LiBXaWxsIGRvDQpU
aGFua3MtSmFtaW4NCj4gPiBJdCB0aGluayB0aGF0IHdlIGNhbiBkaXNjdXNzIGl0IGluIGEgbmV3
IEFTVDI3MDAgcGF0Y2ggc2VyaWVzLg0KPiBTdXJlLg0KPiANCj4gVGhhbmtzLA0KPiANCj4gQy4N
Cj4gDQoNCg==

