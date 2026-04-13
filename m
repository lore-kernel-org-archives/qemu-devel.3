Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A5CE9381A
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 05:20:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wC9ih-0008Dc-Bc; Mon, 13 Apr 2026 01:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wC9ie-0008DG-FC; Mon, 13 Apr 2026 01:20:20 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wC9ic-0003Zh-Ek; Mon, 13 Apr 2026 01:20:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KG54p6heiRBgiThgj5Tf3iT3rHP78u9Fj9NF10LsXzBdFuCO9mJl94wLh6F2ynLX/27VtHLfZqEZFzRL2AxAnSqZLz71KXPTnFtFptn8tFdm6hjTdOxj86DtdK6BdC+gloYaF+MYumObmC2nX2dCrQ5Ewgug/Chl03yCqQiJOMOvAYeMCR8RD5T8FeYL8EJBddBpm8JlFHYiCwlDR69FP7sCNCfHD0bi1vwBC1cn+l4+B9stzxHErb9Z/GBS0HDygvjAAKrSYknnEO8BODwXPNV9xr39dtP8Xu6yk87eKq2j7Emr45JH+eXfQE6werdLdX9Pf6gMjKi9oxKz6KnLIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q02Ko79jUCdHKL20nuXrvnPbPCDSnsPvJFSw5Sq6e+s=;
 b=d4Eb81bmaBucKllEdWT2ICl2c4ETTUeeyulbXurxBruSHUASX/WX4dAqUlbyvHK0LmmPXHZhs9H2FVoR3Jdi1GZTXc5ppOuaC09W2h0vlVAIVPr7sX1MUatte3LVvpY65tjf5Rng2XZ3GK8F4p9j0UVNst2XpWqaUTeA5jjrnKvJEK+sbXQfRzPnoiC9YombeaNuYOkqJVBdKJ987kT5XurOgnxd3ce4HanfFDdlVGLk4aAYKRayCAgo5lNifuzREZ4mKQVL/mB9NG7SgSQ3CTQ4vVEoHz3pPhMjn2M0aSYNbaDTgMAD/n9x9fNu81KfuHgjzdaIddGUp870jPx2IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q02Ko79jUCdHKL20nuXrvnPbPCDSnsPvJFSw5Sq6e+s=;
 b=RoXFLEw0jkk3xHUDpRzTz6rCGBEVN7xlFlNfi5rckMnw4mF7y5O1vDa91YzNvRCwfBPxypAOYdjdhSxhVc050tMtoNgkmth6BX5ftOzIUQnBmRGZ1DP+GbgiwH4KdZltsY+sHJhkNAGlYJfZUsbqIWfqGEqa/Vm/0rJihzqDPpKPSgkfNlgUDxVDT30WPW6POvfUEgVFCRbkIo0sT9Uwu+X2frQJ5p0r17Xd4kkYnU9JeuXyb4MvWI1TpKfpgmDJP/6nOkzMO+CWTBhrKXfVYMjQCnacMdihVx65bSpeH4S2fEmL3vRY3EhsIbMr11X59PFcQLECaRuZEWjwprW0bQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by OSNPR06MB8226.apcprd06.prod.outlook.com (2603:1096:604:45b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 05:20:13 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 05:20:13 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: RE: [PATCH v1 06/13] hw/usb/hcd-ehci: Reject CTRLDSSEGMENT writes
 without 64-bit capability
Thread-Topic: [PATCH v1 06/13] hw/usb/hcd-ehci: Reject CTRLDSSEGMENT writes
 without 64-bit capability
Thread-Index: AQHcsShdLGpD8fDkyk64iqNp0KDcw7Xb13qAgADQd4A=
Date: Mon, 13 Apr 2026 05:20:13 +0000
Message-ID: <TYPPR06MB8206079A6AC97DB7E04ED387FC242@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260311072614.1095587-1-jamin_lin@aspeedtech.com>
 <20260311072614.1095587-7-jamin_lin@aspeedtech.com>
 <fa5480f6-6e71-4165-a738-926d78036c65@kaod.org>
In-Reply-To: <fa5480f6-6e71-4165-a738-926d78036c65@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|OSNPR06MB8226:EE_
x-ms-office365-filtering-correlation-id: 77308d17-ce66-453e-2744-08de991c5717
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: CDwUavxsB1S1y5uoIUvA5gy4emBO2L190FHUgp2Ti+k7HhvIljviQxHdsQiJzbZgwZt5btjHapI4V3oJJCDGVBIuKsryQbd8+ZGyIQknf/2rwblyRqYNddZzRTdkvzL1+Gslr6MgRn35uRSA91aLhmS7b50QI2nlxom1SMcrCOABpepdmJHGay3s8I6OZ6Xs2Jderr9Kmu8N8p6ZLgYTXj1eX5UgkEwLNIeSXLjPdAfN8uQcvif7X8CfW3ciR/rE/AjqYztxB02GKFe1nPEVDzacIvrzoYtm2EELl/64ZvBsFbFSj9Sx7nURkShJQRsFT/67oa1eDPLfNWIENAIEZvbD/ahMzGzX5lvYCWxPwIGrotOMFMlqvrGK/oO9zKyKnKvnIGOedy7cQ/8yGTTZHRO1Xh5n3XT91+pl1BGDJG5chwfltTgAjMfEw/51Vy9DrMhi9cVNa3RJfoI2O1EiF3IJ4dwLDKKCCADJAFmULBv8Pb3e0s5UEM/7pHzwGaH5OI7mm4CGpgKRD4PSAsLR2HiLpSvZS8BUM4i7jiJAFgH2RgkrcDPK12DTU7vX9q+fk1WaEirSus/KTrbWoe2BP+rO+rJ8ze0xfuxqy6daUkT0Loxn8Wps0bv3w/DvuS90+MTrBoA1d9ADeCsjgzJ/EWOOeHTOA1oEALLPXz6QIagqQ1RskKKEGJEpwWgmwh0AR/Yr0MYwbVJ9cph2uNDyVs/GB0Htaz4poZqdTwps9Yc6IXd3NTLaEHsMBCr/y1GySZSpQgaWOK8toD0aqgEQvNz3K9u0GXpzQGMMKu2vN68=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3ZONjNuQ2hYTXN2VFViazhJSWhmSVVHUE53Q1JlYTBvbEFSOC9uTmlKMlo1?=
 =?utf-8?B?cU5JWUFQTFYybm9haUF0bEZNWUVmZmRYSGFvY3B2aGVnT1AxWk12Y1pScXNk?=
 =?utf-8?B?OVRPWmpFWWVsYU9tWUg2aXRLakVaZXBwV1ZuSHQzU3Q3TEJVVER1TGtDVzZk?=
 =?utf-8?B?eUlVazhQMnpHWDFRWGJBL2ZLRDArbGE4OFI4KzJvTGcrUDgyVnQ3L2tnMWxs?=
 =?utf-8?B?S21NZjU1a2tFT3Q2NG1GdW0wYVU3aUZob1dFM1FyRTlPTzUraG5zL3diZFVW?=
 =?utf-8?B?RnRrK1hTRnhzbzJzRFkyckpQYk9ieTVkaFRRejBtWVRHN1B3Y1lzWllob3NW?=
 =?utf-8?B?SjNUblZwYlhYY3BmcUdBLzN0QllFRDlVeVp1QWE2K2NsSmlqanlVZHhlaGpO?=
 =?utf-8?B?U05YMDMxQUIwMGNZVENGMFdNNXFPUkJIaENRbGpkSFRreHNDMW9oSkg5TWQ2?=
 =?utf-8?B?YlVXcDZXdjQ3S0gweWNGY1RNamtjTnRwOVFDZEd4UkMrSEhGT1NZV055M0Rn?=
 =?utf-8?B?UkxOL0hoTkR1eXRUNWNJM09zNVA0eEVKRWtuaytUTkRNcURuWnpPVERMeE9a?=
 =?utf-8?B?L1YzVGdROVgxaEVqU2FVU0JwQ3UwZkp3RkQ1VzBYdy82eDFlbzdhTWNxa0F3?=
 =?utf-8?B?enhQRXhPMXg4S2FNUlczMExiOUl1aHZxNms2K3lJTTdob29Iemw3QkFUemZ4?=
 =?utf-8?B?NWxZcXZYb0owOXNnT053MU42V2lRZHg4S2hoQkpsTThuMzJIWWFvUHl5bmNZ?=
 =?utf-8?B?eEhjei9wQ0VSMnJ1SnNVbnJjWjZ0K2t2VHBGQlJraTZ6aythY2VlUmlGYUxC?=
 =?utf-8?B?clBpdndyZ3FiWEg2YUpzNjhQYkc1Nnh0ZldRRmo5SThLYjRXcEtGRkJ6TktR?=
 =?utf-8?B?ckhPVHFDREZxNmZ1UlpVcmNlOUZ5aCtLa0I3blVHamVaQisrVmJBKzFuUTU3?=
 =?utf-8?B?Z0JuNlNNdW5sT09GaVIwNjFHRDloS0JtUWVuSWEyR3BLR3Z3b2JYYUtvMFpN?=
 =?utf-8?B?QlBMSlRNQzVjZ0crS1ZxME8rWHFUUW8vOURSMHRIbnBWSFhJc0FTVEx2MW02?=
 =?utf-8?B?SjJuSkFjdXVURkxCZnZHVm9wSWlFd3FKQlR2Z3NOM1dZSlFsMVJ2S1ZDTFVD?=
 =?utf-8?B?b1QvMWdGakNrenB3RnZ5aERHYkJLNDlyWk5pNkh5aTBXN1BQSDZZWFRGUzBC?=
 =?utf-8?B?dUhCYVhoczFWaFJMY0V4Q3ljNG1yY3lGV29BZ0FqbmpaLzhWMEtSTDdra3hi?=
 =?utf-8?B?R0Mydkx0b2Y0V2EvUWpmVEFyMkx1UzJzMXpPdXp3NVFiLzY0THM0L2ZyWTdY?=
 =?utf-8?B?SlE0aVNJRytxODBNdStZNlpnNlcyNjRwNDREK1YvV3NkTUxiZk0zR3pGU2Fz?=
 =?utf-8?B?TGlnM1N4ZFZ3dGlIbkNhRW9Gc2lHcWFHTmJmTFNML21YcThYcVdjcEdURG1V?=
 =?utf-8?B?YlVRNnlsWFJYb2tSQlNrNDAzSy82RjhLVGpvU2tlZ2JFVlFkbDk5b0p6QnpE?=
 =?utf-8?B?U0hHVElCY0JBMEQvMGRWU1Ivd3NURUMvcGVQME10dkI2Z241WkRTNUFtbzk5?=
 =?utf-8?B?aWJ0NnhjaldIOVFvVWpZY1NMZ3VJTmtkUVZYRFV4d1lZbjhGWFNNbWZUWTVr?=
 =?utf-8?B?YkxQKzIwMzQ2WDNVb2c3V0tMNUVKdTArZncrYkpvUGw3NGk2TnBZeGhwWGtj?=
 =?utf-8?B?cmxlMkpOTnpidkJjSGlmb0NKd0RYT2RiMHpvTU01MDRiT09hZVRLVnR4bmR4?=
 =?utf-8?B?akp0MHdBVDZtWnlJVDlvVlQwMkErVy9NTHIySVVQbDBxWW5VWVh3WmV1aXdB?=
 =?utf-8?B?WnplN3FjUlZiVkw5RkM2cDFZMHN6NU52MU1GMEJIbElrNTFrblFEbDQwUXlL?=
 =?utf-8?B?cTNnOVBTclNFODhvNUxBYVd4b2FjbWQ5eTY0VTFsRUlaNHZnQ01na25oejhL?=
 =?utf-8?B?YWhqNDViaFpsQkorbDJSMkRNY0FZbUR2UjhmTVIwbkZCY3JUcjhsMjMyeHd5?=
 =?utf-8?B?NVRiNnJOdzhDMEFsaGZBcUdqRFF2OTBiMkhKVE5XMFQzMlg4U3ZQK01qcXVM?=
 =?utf-8?B?L25RSUlmM21hSXM4NVdiLzlieS95Wlo2VjZsbjMrZVVGckF4Z2ZNWmN4Q3Er?=
 =?utf-8?B?TTdzRzNwOWoyTmlHbWVUcTVDdHA0V09BRGRnNVFoVmpGTVhYWCs0Z3RvNDBi?=
 =?utf-8?B?cjBTaW94MmVEcEtBWmpqMllnM1JHZVJVcnRNbzlPUjRxdVhZWFhpNTU0VjNT?=
 =?utf-8?B?aXRZTDE3YVd0WjR4elVIUExtS05jZGlwUWZuajhvWGlQVWV3TmRzSUhKNFU4?=
 =?utf-8?B?cHNKY2NxNXh4OTI3ekRiWmJJd1J0R1RLOE45VTY3YXVkWHRzTlVsQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ca7hpeROsQzst5OINbQYkK2zYxmW90TdIU1bcCG8jlOUv+aoAjUjsAbNkcOZ0FC7V7ZpieZLhtiQwotCltGSwnNPRLWv2Ne5umbU/dpjD85tVt77IAWiQuoXqQh8nwUf2mTx7EMxrB9TeOddzoROPWHVS8zlstXCMeqQtXQVqvMmheC7upLGqrJ8uJEph3UPl4AO5yxwjPV+y4VR9cJE8AbgwC/i9YCeGRifrOBHP6EORxFeLBLFIN5CUXtxd4erMig76T4YwuET65EyFraRhrsXXIAi5rr5BcGJSFwcFtmw8DM+iOWu9EpHHE/mm8AJRndAbhO2xS2nQ9BQDhoiEw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77308d17-ce66-453e-2744-08de991c5717
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 05:20:13.2124 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QaMlGw7tpQX4eFRWmcSmckxwbhpd9OzGIrh1yEmNqsHRSdkBF0lOsSMa0b2PQOC82c4I6/lULh8F9oRA/lsdjL7qsbdknJvEKNafy6uZ20Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB8226
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDYvMTNdIGh3L3VzYi9oY2Qt
ZWhjaTogUmVqZWN0IENUUkxEU1NFR01FTlQNCj4gd3JpdGVzIHdpdGhvdXQgNjQtYml0IGNhcGFi
aWxpdHkNCj4gDQo+IE9uIDMvMTEvMjYgMDg6MjYsIEphbWluIExpbiB3cm90ZToNCj4gPiBUaGUg
RUhDSSBDVFJMRFNTRUdNRU5UIHJlZ2lzdGVyIHByb3ZpZGVzIHRoZSB1cHBlciAzMiBiaXRzIFs2
MzozMl0NCj4gPiB1c2VkIHRvIGZvcm0gNjQtYml0IGFkZHJlc3NlcyBmb3IgRUhDSSBjb250cm9s
IGRhdGEgc3RydWN0dXJlcy4gUGVyDQo+ID4gRUhDSSAxLjAgc3BlYyBzZWN0aW9uIDIuMy41LCB3
aGVuIHRoZSBIQ0NQQVJBTVMgNjQtYml0IEFkZHJlc3NpbmcNCj4gPiBDYXBhYmlsaXR5IGJpdCBp
cyB6ZXJvLCBDVFJMRFNTRUdNRU5UIGlzIG5vdCB1c2VkOiBzb2Z0d2FyZSBjYW5ub3QNCj4gPiB3
cml0ZSBpdCBhbmQgcmVhZHMgbXVzdCByZXR1cm4gemVyby4NCj4gPg0KPiA+IEFkZCBhIGNhcGFi
aWxpdHkgY2hlY2sgaW4gdGhlIG9wZXJhdGlvbmFsIHJlZ2lzdGVyIHdyaXRlIGhhbmRsZXIgYW5k
DQo+ID4gcmVqZWN0IGd1ZXN0IHdyaXRlcyB0byBDVFJMRFNTRUdNRU5UIHdoZW4gNjQtYml0IGFk
ZHJlc3NpbmcgaXMgbm90DQo+ID4gZW5hYmxlZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEph
bWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiA+IC0tLQ0KPiA+ICAgaHcvdXNi
L2hjZC1laGNpLmMgfCA5ICsrKysrKysrLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L3VzYi9oY2Qt
ZWhjaS5jIGIvaHcvdXNiL2hjZC1laGNpLmMgaW5kZXgNCj4gPiA5ZTgyMzI4MTE2Li5kN2EwOTE3
Y2FmIDEwMDY0NA0KPiA+IC0tLSBhL2h3L3VzYi9oY2QtZWhjaS5jDQo+ID4gKysrIGIvaHcvdXNi
L2hjZC1laGNpLmMNCj4gPiBAQCAtMTEwNiw3ICsxMTA2LDE0IEBAIHN0YXRpYyB2b2lkIGVoY2lf
b3ByZWdfd3JpdGUodm9pZCAqcHRyLCBod2FkZHINCj4gYWRkciwNCj4gPiAgICAgICAgICAgICAg
ICAgIiAgICAgIGlzIGVuYWJsZWQgYW5kIEhDIGlzIGVuYWJsZWRcbiIpOw0KPiA+ICAgICAgICAg
ICB9DQo+ID4gICAgICAgICAgIGJyZWFrOw0KPiA+IC0NCj4gPiArICAgIGNhc2UgQ1RSTERTU0VH
TUVOVDoNCj4gPiArICAgICAgICBpZiAoIXMtPmNhcHNfNjRiaXRfYWRkcikgew0KPiA+ICsgICAg
ICAgICAgICBmcHJpbnRmKHN0ZGVyciwNCj4gDQo+IG5vIGZwcmludGYgcGxlYXNlLg0KPiANClRo
YW5rcyBmb3IgdGhlIHJldmlldyBhbmQgc3VnZ2VzdGlvbnMNCldpbGwgZml4IGl0Lg0KSmFtaW4N
Cj4gVGhhbmtzLA0KPiANCj4gQy4NCj4gDQo+IA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICJl
aGNpOiB3cml0ZSB0byBDVFJMRFNTRUdNRU5UIHdoaWxlICINCj4gPiArICAgICAgICAgICAgICAg
ICAgICAiNjQtYml0IGFkZHJlc3NpbmcgY2FwYWJpbGl0eSBpcyBkaXNhYmxlZFxuIik7DQo+ID4g
KyAgICAgICAgICAgIHJldHVybjsNCj4gPiArICAgICAgICB9DQo+ID4gKyAgICAgICAgYnJlYWs7
DQo+ID4gICAgICAgY2FzZSBBU1lOQ0xJU1RBRERSOg0KPiA+ICAgICAgICAgICBpZiAoZWhjaV9h
c3luY19lbmFibGVkKHMpKSB7DQo+ID4gICAgICAgICAgICAgICBmcHJpbnRmKHN0ZGVyciwNCg0K

