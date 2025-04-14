Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1B0C369AE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 01:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u48Wr-0002vU-5H; Sun, 13 Apr 2025 21:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u48Wn-0002ut-RD; Sun, 13 Apr 2025 21:22:25 -0400
Received: from mail-tyzapc01on20713.outbound.protection.outlook.com
 ([2a01:111:f403:2011::713]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u48Wl-0002aV-98; Sun, 13 Apr 2025 21:22:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYzEsFdQDMXBaXiomnB94nxGOR4ZKWeCQCPoRRV4jZek++/dnkHyv7StyZQisNuMU7lZqrVId1NnsgvSQIVxhlOuT565fhfXjowrWdF9FQ2eiHbJOyJTX/9phhyzSGnA2IkUihTAyal+kVNVjtGHqBmcE8mq/272mmu8IBnP+uPBjX4te00BoehBlXQQahpxlmvYj7q6TYTAs+5w8vNbzYTOh0LKeY/Kjw0+39A02DXdEZF+qwOVCyiMhrzhGN3GbJxXPIBmWhOwJBuYaVkzqvvXP1aPlto+h/8wiwQ36Ax0AKzUHwFRTZOBDFeIdjjcF9xhiNSvm5h5DIH70btp0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eoOZu18wmE7UYiY4aFjPbwp3S2ObjKm+tk1izVtJyGw=;
 b=Ix1ODn4WJE79+2E7HXwT7KuRU65t4fx57AL6DyqNLHwslbk8jrOX/Q540mKEWZJFV/Js9W1qNaN8HtM7JsqDm5LT+1ldQ5reI9MoMBmAO+1pRkcKS7oXCZPWQ0woG8dqJwgCAEnVQHlUe6Y+v8gElyiUTLoW1c+HU7cPbO53vVxOncspM6fxp3OjadZ2QYtpS2zr8e3183rxlxnGc5tIx9HjiaVcs3hR0EGC4hMqlEd52rfBORjAPLehzA9PB+2j1jbp707i0Y6n36oUrZtdFPjPmlGp6y9tkiQWEIfp/CxmmSBb8NbHPIWVDxBwrBnBkBBqYZ7GslljIVtb/btXKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoOZu18wmE7UYiY4aFjPbwp3S2ObjKm+tk1izVtJyGw=;
 b=I5OF4QNk3wH/RCJVHYI39NT4FaZQZxbvv0aZYuuO1n4eOKt1UyEgvJW7eFnwYCBKX5r5l0r63DzVT37izxe7hlpKmb7z7aapvcH/xG3Zwj/IYW9xK0fcgsrZLcIE1D9O+GOIEe5jvSL7wGHFVP2jTfh8+MHwq2UiQkMOinj7iGspiQovPmEj0FKYwG0+YywKM7Jt1ZFtHxLmDaO5LBc8WfmZbgUToToCVxo3SHZsaGJ1ekadO+x+mCOMGY3fP+G4leFgD5KjLfjoYiZ8Fj87ORICq10mjQtCLijDNw8OEM3IjK9mGmODHDZWT4S2kaK761q+Spl8CQqs5qJF4vmA7A==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYZPR06MB7333.apcprd06.prod.outlook.com (2603:1096:405:a7::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.32; Mon, 14 Apr 2025 01:22:12 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8632.025; Mon, 14 Apr 2025
 01:22:12 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: RE: [PATCH v2 04/10] hw/arm/aspeed_ast27x0 Introduce vbootrom memory
 region
Thread-Topic: [PATCH v2 04/10] hw/arm/aspeed_ast27x0 Introduce vbootrom memory
 region
Thread-Index: AQHbqcG7PttqXlHU2EmeDWtT40eKdrOen0sAgAPEU3A=
Date: Mon, 14 Apr 2025 01:22:11 +0000
Message-ID: <SI2PR06MB5041D8F5E953068133C3FFB0FCB32@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250410023856.500258-1-jamin_lin@aspeedtech.com>
 <20250410023856.500258-5-jamin_lin@aspeedtech.com>
 <23839e2c-c2e7-4c63-a647-689291dc0f2f@kaod.org>
In-Reply-To: <23839e2c-c2e7-4c63-a647-689291dc0f2f@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYZPR06MB7333:EE_
x-ms-office365-filtering-correlation-id: 0f23bae7-3ff4-4f5f-576e-08dd7af2c872
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?b0pCUlptSXJFcCt0cFBVZlJlU1pMbjE3cmd5ZldHZGNBUUlSY1ZQQ2JlNlhC?=
 =?utf-8?B?M0hvZzdNVkY4bXFVbVVsWlhscUFlZmdINlBIMFNwTEhweGQ1UEoycnExZkln?=
 =?utf-8?B?Nzd6aHVZM1NQdHVhbWg1VGZ6cU85Mk1LVGpybzc3WlRWcDVwTG1oQUlFa3pX?=
 =?utf-8?B?YkQxOGs2SXlOdERGY3lVbUJobnBCQ1E5SnNCUjNoTHpvZzI1ZHI3aUhGUzNi?=
 =?utf-8?B?VFFBbllaM1l3WkpRWGdsZkQrcjlGYWNMR2dRTXJZa0dOSXRraVM0SmVMdGhF?=
 =?utf-8?B?a0FEdThHN0ljY1U2aFFZTUpLZC9QUUNFclRGLy9sTitySnBxc1dPUTNQNk95?=
 =?utf-8?B?Vy8yVDdXellGOFQ0VGJORlBJMjNoMTJaMjJuSzhlU1NBbkdqVFNtcEVpZzdZ?=
 =?utf-8?B?VHFZNTM0eW56dVlXb0Y1M3Z2azRaRXZTemtWMU5LWnJCeTlLdkJxdVd3MzBC?=
 =?utf-8?B?c0hjNFRMS0Y1cFk3YjV5aDNIc3l2anVoNWE1Z3NsWkZrdVJWem5IaEJyL3ZX?=
 =?utf-8?B?MmI2RFRyaG5GVUNQTXV5L2wzTStZTXpwYUxPSi85dTRFbXgzTllNZFZUTURG?=
 =?utf-8?B?MWZKOUd4UUdsdDh1cDhRV3hnZzVwdXpRQlRmbnY3RFUrdzZJVlNTSS9qdWh0?=
 =?utf-8?B?elhzZ3ZoL0V1MmwvcGMrNWhha2d3TXFhRUd3NEtKZ2NzUWEvdlJ4RWxOQkJW?=
 =?utf-8?B?UG45bWFid1BLNGZoTnRTNU1ieitiRENabFZ5MktDRVp2S291U3ZUa1BiRC9F?=
 =?utf-8?B?UlpzMEwzakdGakphSGIxd2pqU2VLK21lL25kS3dVYmRhMUR0TDNFMWM3Z1hU?=
 =?utf-8?B?UTN1eWQ3QTFINmdJeGIxRXRzeEhRNFhpRCtoQmNTeWVUdldpZmFGSEtXTE1i?=
 =?utf-8?B?T3dzTlhGeHBWbW9BaGJhaU1BakpmS04zYWEyWWJsRldYQlY4YklrMWMva1pz?=
 =?utf-8?B?Znc4MEJzSEVrMDQvaG5lRVpqK0FrdkVQV0RtVWFJRHRmZ3R0b0hBWHhiYnJs?=
 =?utf-8?B?WFFwamNPSlN3di8rcXRxajlrNDMyaTZZWndXeFhacXdEYTFvY3lWaHBHQkJM?=
 =?utf-8?B?SXo3VGwreDJnSCtSa0YxVG15RzdnVDZaOFJObFNLV25HZlRETnBud1A5Vng2?=
 =?utf-8?B?RW9ydXppalQ4MXl5L3ZtcXVxdUtpRzQ0cnpnYWI3UHBQcXBIaVQzR1NFNnRT?=
 =?utf-8?B?QWxaUlF0VytURGRudmlQVUZLbGtvb3d1dHNUSmliT1E3UFU0dUlPbmJZRkdT?=
 =?utf-8?B?NTVOS05XajI4NUFVajNjbWNQY2hTclc0MHZuVWM2YUtaMFhFVXFGZHVpWTVH?=
 =?utf-8?B?Z3l0SHNlZWJLN3pUaGwvS1ZseTdGTDJESjN0RkwwSndHZ255WXA4MG42R3J1?=
 =?utf-8?B?RVNkRUFrQjhDV2dieTEvazQxbTNidHhReTlVd3ZuQ29hamZxUU1pNEIvK0Zx?=
 =?utf-8?B?RS9oYWI1WHA2Y2krbFp1aUxNVFU3M3A3Y1VGS2l3dnFVc2Y0UW9lMkNDVWtt?=
 =?utf-8?B?ZzlWQmlDZzhKb04xMlhQZ2xWZXdiaGpOdHhZazIxSFdwS3VCZFc2VWVnMVJM?=
 =?utf-8?B?UUlWbUxmZVVFeXJERG15R01peGdscTVoZFZPNTlWK1YwVG1wcyt2Q0NLb0xs?=
 =?utf-8?B?OUpDTURjRGRnRVhvSUZTeThCVFNudVk0SVVnZGVrVzQ5ejEwYnpNeTZmczJG?=
 =?utf-8?B?dWtNbFkwVHlxaVdOc3Zaa25mMzJtL2JFUi9pdS9uaUt4amdWN0RlaUQxTS9Y?=
 =?utf-8?B?bk5uYllCS0lwaWFOWmRZSmpFWm1iaDl1MWQwVTlQR3FmaEtnNVUvU2lSZkRG?=
 =?utf-8?B?NUJ4NGJmRGIrY3dpQnJEdURNWHMvSVBCREc4UFhmWmtRKzRCejMzaGFPUXh1?=
 =?utf-8?B?V016SmJWb1FxckFIMUd3aE5XdVowK1doWE1QWDFpdnZCVFJCTTVjWktUMVJV?=
 =?utf-8?B?eG9Xb2VlRUNGNWE0YnIwbDZwY3IvK2cwMGx2a0VDbkR1anpZamMwTDU2MFJz?=
 =?utf-8?B?eXhlRUlBaWx3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVk0WXVYUGNpK2x0MDRRdHJUSWdpYVNjRzZDTzhzQ3U5NVpLaG9wRHBURkNp?=
 =?utf-8?B?Ly9OR3ZrMm95YTh6bTJmVDgxSmN1dmdVaFpIZ2VHOEtZOHlyTWQzKzFCZWtQ?=
 =?utf-8?B?ZURwVnVCMGIvT2ZsQW9uYXhrb2VRS0QyVHBOTTlZdFZzak9DbUxmS2pnTkhj?=
 =?utf-8?B?bGFjSXdCbmt3Sm5XZ0h4cTdpVUZXZ2lmeEtBemo3MC9LTEZrNFFVWndUMmpF?=
 =?utf-8?B?SkxSdUtvUmNydGoxRld5Lzd1VmtlME5jUWhKak5BSHpqV0dLWnMzVlYyMzFu?=
 =?utf-8?B?Q2d0NU1xMm5YQXlMR0dMZ1pJZ3B2TG1OVGVUdHN2SmI4bXJVbTJEeU9iY1Fj?=
 =?utf-8?B?cU5UOVpHSUNWajNpYnV0SzgvaHMvR1k0MUZUdmtpcXQ4RGozTUlCRnJVVHVI?=
 =?utf-8?B?T29CZm9YWFdORytDVjdISm9yem9vbFAwQUQ3amQ5cFVzSWlPVG80MDIzcCsy?=
 =?utf-8?B?ZENhUFlOWXVVS1RSdWpyWjhHN1NsNlEwWGVoYW5VcmQzMTNka00wLzRIT3lM?=
 =?utf-8?B?ZS9uZ0QwZW5DODBRSGhGaHo3aHM2M083ZjdYYzdwV0hKVDFjN1JuTWtLNFhE?=
 =?utf-8?B?YWQ0OEQzWW9UMXhHQkxxV3p1N3E5K1VKS1oxaWVJWmZ5K2dxSTlqbHA5cUtK?=
 =?utf-8?B?bTlpMlROeHZtRHZ6WW9oZnJRckJOVSs3NE4zc2xIWjFyYUU2Y0dTb1V4N2s3?=
 =?utf-8?B?YjNMdVY0SzRpRW9ualBqRFlmOURjb2VmVXU5dm5mRlFlMlczNGYxSkRNdStx?=
 =?utf-8?B?ZGVWYzdQdFNPcVg3Yy96RFRxVGFEeDRhVUdxVmJLdFN6U0JPa01yM3NkQzcx?=
 =?utf-8?B?MlRQZzNLSUVrT29DQS9ELzdySGMrc2ZDa1FTSWxCeFZUWXpuQmtKS3FtajQ5?=
 =?utf-8?B?eVFsZDFZOXFsRkV5bG1zVFNLOENIRjJRcGdpenpwWmNFRWtOOGlpTzRLRVY1?=
 =?utf-8?B?blFIS2MxWGdTS3JpR3owaWt0bWIyQWMzMHF6OFNvVHJCOUt5SWE3ZVVzMm0z?=
 =?utf-8?B?WDZrUU52QUxtUlhrKzBiU2hHaGVuRnFhQzhUSVlVSTdBYW50SlgxSEtFenVM?=
 =?utf-8?B?VjZWSDJCL2pQTGJBZmszdUN6cENnT1A5UGpIM2szZHJ2QkZvanh1VFJadTR1?=
 =?utf-8?B?QUdxSG9sNVA3VG8xWERyUEFYVWhleGdjK2lIeEd5bzJoRnZhQjBKVUJNS08y?=
 =?utf-8?B?QVR6amxNUU1HUklWT1FWNmI5SEdtOWExOHBJMVJ6MitWMDhiT0RUN2RWWnFu?=
 =?utf-8?B?N1ZHMUJ6Z2FBcG0rZmdDTmVRVzJkTmg2Y3BzVTdvOUV5alppR0pWdkVpSVYx?=
 =?utf-8?B?bTFkc2NZMEx2RkFiM0hGdnRCWGJXbWpWOGZHaTVqV1k3YkZ1ZmxOME9rZ1Ry?=
 =?utf-8?B?NmQxcTVhbFZVaEJsZDRLSlp2WjRSdDR2aHpIZVZQbHVNeml2eFV3K3JyT3BT?=
 =?utf-8?B?M2NmT2VMQVhUUVViK1BBV0xyaXUyNHU4S09sQzBMUDNtWG1ZRlFvdDZmRHlq?=
 =?utf-8?B?Y2hiTmdLNEpvZzNxZ3BSTFJvRS9rbFVOa1RlNlEyNDhpUDkxaFJVMEZPVFl0?=
 =?utf-8?B?ZmxUNC9PSDVwTjl5QmJqS0xhcFpFcG4xcGsxZTI5UCtzQlpGTjBpeW92OVVY?=
 =?utf-8?B?SGRZTjNCcmZWd2RtclM5ZFN4Y1hKVEZra0krRWNHbmd2cW5TZ0hjaUxaS1NG?=
 =?utf-8?B?SnJYZTExZ1dBaTlUYVlvL29VTk9ZMzlwNjFsdEJmTnArcEM1QjdPQzFKZXMy?=
 =?utf-8?B?NkxJN0xGK1RGWFpqbURja3l6SGtYMzBYNFdtRFJsclBpNEcxamFLQ3k3SFNi?=
 =?utf-8?B?QWx0WG9UZUg3NVRRVElmZVB4dFhXL3ZUU2t3WGNHeVNqOXAvbXprT2NReWNN?=
 =?utf-8?B?WThDSGF2Slg0MFZFVEtIU3dWMEF1RkZhZm9FaTFzTlJ4TVZwR0V5YTJ5Z3Mv?=
 =?utf-8?B?ZjZzdmJHUWJOeDRoL3ZmSTJzY1RadFlXVldnVmNFZVJCcWlsOFZsQnQwbS9V?=
 =?utf-8?B?bXZ0K3poQ1hwRDd4RktBYlNzY2NqWTJuSFZ3aUdrNDVMSzZsUHJtVWVibHFN?=
 =?utf-8?B?THZXeUh0M3BEOTdkMGZrSi9JVEl2OVRNNzlNbzlwcmR5SUNHaFZraEhUT1VL?=
 =?utf-8?Q?2VXEnVmdvOx/YillKlruYhuba?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f23bae7-3ff4-4f5f-576e-08dd7af2c872
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 01:22:11.9913 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CBej4AnkwBtXIurUUAvYZqn5Hmo+yGfW9bcZCwzRqdDSPQ3yrXE4/aoet7dc127O/QwqEgrtGIm9N9bJ8U1wSVFZ6t8mu9Y2rxz5NvUbwfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7333
Received-SPF: pass client-ip=2a01:111:f403:2011::713;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

SGkgQ2VkcmljLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDQvMTBdIGh3L2FybS9hc3Bl
ZWRfYXN0Mjd4MCBJbnRyb2R1Y2UgdmJvb3Ryb20NCj4gbWVtb3J5IHJlZ2lvbg0KPiANCj4gT24g
NC8xMC8yNSAwNDozOCwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IEludHJvZHVjZSBhIG5ldyB2Ym9v
dHJvbSBtZW1vcnkgcmVnaW9uLiBUaGUgcmVnaW9uIGlzIG1hcHBlZCBhdA0KPiA+IGFkZHJlc3Mg
IjB4MDAwMDAwMDAiIGFuZCBoYXMgYSBzaXplIG9mIDEyOEtCLCBpZGVudGljYWwgdG8gdGhlIFNS
QU0gcmVnaW9uDQo+IHNpemUuDQo+ID4gVGhpcyBtZW1vcnkgcmVnaW9uIGlzIGludGVuZGVkIGZv
ciBsb2FkaW5nIGEgdmJvb3Ryb20gaW1hZ2UgZmlsZSBhcw0KPiA+IHBhcnQgb2YgdGhlIGJvb3Qg
cHJvY2Vzcy4NCj4gPg0KPiA+IFRoZSB2Ym9vdHJvbSByZWdpb24gaXMgaW5pdGlhbGl6ZWQgYXMg
Uk9NIGFuZCByZWdpc3RlcmVkIGluIHRoZSBTb0Mncw0KPiA+IGFkZHJlc3Mgc3BhY2UgdXNpbmcg
dGhlIEFTUEVFRF9ERVZfVkJPT1RST00gaW5kZXguDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBK
YW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gDQo+IFBsZWFzZSBtZXJnZSBw
YXRjaGVzIDEtMiw0IHRvZ2V0aGVyLg0KPiANCg0KV2lsbCBkby4NCg0KSmFtaW4NCj4gDQo+IFRo
YW5rcywNCj4gDQo+IEMuDQo+IA0KPiANCj4gPiAtLS0NCj4gPiAgIGluY2x1ZGUvaHcvYXJtL2Fz
cGVlZF9zb2MuaCB8ICAxICsNCj4gPiAgIGh3L2FybS9hc3BlZWRfYXN0Mjd4MC5jICAgICB8IDEw
ICsrKysrKysrKysNCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvYXJtL2FzcGVlZF9zb2MuaCBiL2luY2x1ZGUv
aHcvYXJtL2FzcGVlZF9zb2MuaA0KPiA+IGluZGV4IDQzMmY2MTc4YWMuLjlhZjhjZmJjM2UgMTAw
NjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9ody9hcm0vYXNwZWVkX3NvYy5oDQo+ID4gKysrIGIvaW5j
bHVkZS9ody9hcm0vYXNwZWVkX3NvYy5oDQo+ID4gQEAgLTU5LDYgKzU5LDcgQEAgc3RydWN0IEFz
cGVlZFNvQ1N0YXRlIHsNCj4gPiAgICAgICBNZW1vcnlSZWdpb24gc3JhbTsNCj4gPiAgICAgICBN
ZW1vcnlSZWdpb24gc3BpX2Jvb3RfY29udGFpbmVyOw0KPiA+ICAgICAgIE1lbW9yeVJlZ2lvbiBz
cGlfYm9vdDsNCj4gPiArICAgIE1lbW9yeVJlZ2lvbiB2Ym9vdHJvbTsNCj4gPiAgICAgICBBZGRy
ZXNzU3BhY2UgZHJhbV9hczsNCj4gPiAgICAgICBBc3BlZWRSdGNTdGF0ZSBydGM7DQo+ID4gICAg
ICAgQXNwZWVkVGltZXJDdHJsU3RhdGUgdGltZXJjdHJsOw0KPiA+IGRpZmYgLS1naXQgYS9ody9h
cm0vYXNwZWVkX2FzdDI3eDAuYyBiL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC5jIGluZGV4DQo+ID4g
YzcxODhhZTVmMS4uMDk4MmU2MzYzOSAxMDA2NDQNCj4gPiAtLS0gYS9ody9hcm0vYXNwZWVkX2Fz
dDI3eDAuYw0KPiA+ICsrKyBiL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC5jDQo+ID4gQEAgLTI0LDYg
KzI0LDcgQEANCj4gPiAgICNpbmNsdWRlICJxZW11L2xvZy5oIg0KPiA+DQo+ID4gICBzdGF0aWMg
Y29uc3QgaHdhZGRyIGFzcGVlZF9zb2NfYXN0MjcwMF9tZW1tYXBbXSA9IHsNCj4gPiArICAgIFtB
U1BFRURfREVWX1ZCT09UUk9NXSAgPSAgMHgwMDAwMDAwMCwNCj4gPiAgICAgICBbQVNQRUVEX0RF
Vl9TUkFNXSAgICAgID0gIDB4MTAwMDAwMDAsDQo+ID4gICAgICAgW0FTUEVFRF9ERVZfSEFDRV0g
ICAgICA9ICAweDEyMDcwMDAwLA0KPiA+ICAgICAgIFtBU1BFRURfREVWX0VNTUNdICAgICAgPSAg
MHgxMjA5MDAwMCwNCj4gPiBAQCAtNjU3LDYgKzY1OCwxNSBAQCBzdGF0aWMgdm9pZA0KPiBhc3Bl
ZWRfc29jX2FzdDI3MDBfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApDQo+
ID4gICAgICAgbWVtb3J5X3JlZ2lvbl9hZGRfc3VicmVnaW9uKHMtPm1lbW9yeSwNCj4gPg0KPiBz
Yy0+bWVtbWFwW0FTUEVFRF9ERVZfU1JBTV0sDQo+ID4gJnMtPnNyYW0pOw0KPiA+DQo+ID4gKyAg
ICAvKiBWQk9PVFJPTSAqLw0KPiA+ICsgICAgbmFtZSA9IGdfc3RyZHVwX3ByaW50ZigiYXNwZWVk
LnZib290cm9tLiVkIiwNCj4gQ1BVKCZhLT5jcHVbMF0pLT5jcHVfaW5kZXgpOw0KPiA+ICsgICAg
aWYgKCFtZW1vcnlfcmVnaW9uX2luaXRfcm9tKCZzLT52Ym9vdHJvbSwgT0JKRUNUKHMpLCBuYW1l
LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNjLT52Ym9vdHJvbV9zaXpl
LCBlcnJwKSkgew0KPiA+ICsgICAgICAgIHJldHVybjsNCj4gPiArICAgIH0NCj4gPiArICAgIG1l
bW9yeV9yZWdpb25fYWRkX3N1YnJlZ2lvbihzLT5tZW1vcnksDQo+ID4gKw0KPiBzYy0+bWVtbWFw
W0FTUEVFRF9ERVZfVkJPT1RST01dLA0KPiA+ICsgJnMtPnZib290cm9tKTsNCj4gPiArDQo+ID4g
ICAgICAgLyogU0NVICovDQo+ID4gICAgICAgaWYgKCFzeXNidXNfcmVhbGl6ZShTWVNfQlVTX0RF
VklDRSgmcy0+c2N1KSwgZXJycCkpIHsNCj4gPiAgICAgICAgICAgcmV0dXJuOw0KDQo=

