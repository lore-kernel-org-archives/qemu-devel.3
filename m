Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFACAF8E4B6
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 07:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDdoV-0003z4-8H; Fri, 17 Apr 2026 03:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDdoS-0003ya-W8; Fri, 17 Apr 2026 03:40:29 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDdoQ-00088W-BP; Fri, 17 Apr 2026 03:40:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jtwASvjEsUlusa79OfrdYOlHRnR1mec1al7Ymq/CUcN6PXX1+wmgVv81DmJa+aE/w7G5n3+Pk2EsB8KIT5XVOnRwnlQSI4bCH3DzhhDM6YVX3rMlHWYQagh2PPMhf8GYF4PX/oT5IdqwNg+cdg17Fa1MCy+dGWUAGZ2nyBFSGlnle4f1guzHXLqF2qYvrFqLNnL4PpnHN0aKtIbEm7OsK/3tMPUT5kZ3egDlFBDhEVB2kreRu/tm9vfgiLsYZkIVrL5xvfBYW6iSBuwVBz06OMBLl2mOmH1TEnHI2fMCC/EUTsOAPAlMeDWhWZDHcp0VtS6ph0mJQOfaskrG12SrXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXafBKGpJJv1tbXYvxEdIZ1zzNMvAEM6gv0lrDJtd7g=;
 b=rosNXkspi2CxfCpZQcN0eNykbdp5KnzQ6hw/aDfXPUbPWa6GG1Myf1gf3kq7Y1HGf8vtmK7erFlabysR9EjGlcbQhvCYNnWfs3UPLdv65bYR4ZQx/GZMVXj6/QESVdGbnLlKRLUZAIAn+r/7yDUFMMDIWhE3WYS3DU6cI1i6XbL4qds3fzCm7aTEvYNothR2e5p3NlXQbwfjhw9FOYKb0NXdj4xIU4Rgs9mJ9LmwkxK395KhoPK4xv6iXtWqSAgzYGG3pCLKx6riOuMklBu/hGrZ7Pkydk8D8z/EhDiqB+0Ekz/D65RGiOHlfe06QGClZ+mwS8Vin261vlkSNMPxCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXafBKGpJJv1tbXYvxEdIZ1zzNMvAEM6gv0lrDJtd7g=;
 b=dHnoFP7KWEzNgTPsQNLVyN2eoWG03BMR5rwCjDog5ssQ12nzQVptN9BHWVAIOZg9SKwy9q2tFmH67dPZtZXmdr9azo7BBIadj9PZN/tIB1ypS4mMrPMcVj0E8HPAsr7v1EbAUuqMwtDMzMBPvsT45KnInWTaW82mI+CKYaQnKkZ3w+XrpPaJAmWA6euORP/ZX6ntx4H35apKvaRZoWyAGWjDXQnJVOvCbelkZjkcsPB+P9kRgh42HLxy0sTgT7dfTE6+KxwLWyqxZHuruzuhxa1tPWzXjD9+hzgiFnpUHb0bvv968iTyw17CrOFRLPONVKrBj1zsmLyWmO5gstnleQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6622.apcprd06.prod.outlook.com (2603:1096:820:f9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Fri, 17 Apr
 2026 07:40:11 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 07:40:11 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: RE: [PATCH v3 16/17] tests/functional/arm/test_aspeed_ast2600_sdk:
 Add USB EHCI test for AST2600 SDK
Thread-Topic: [PATCH v3 16/17] tests/functional/arm/test_aspeed_ast2600_sdk:
 Add USB EHCI test for AST2600 SDK
Thread-Index: AQHczUNXa7m48IJ56E+5bAyC84EEb7Xiy+aAgAATUfA=
Date: Fri, 17 Apr 2026 07:40:11 +0000
Message-ID: <TYPPR06MB82064C14C44392EEA1F98BEBFC202@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
 <20260416014928.1279360-17-jamin_lin@aspeedtech.com>
 <1738caec-dfa0-4d88-b7dd-5eabc075f5ef@linaro.org>
In-Reply-To: <1738caec-dfa0-4d88-b7dd-5eabc075f5ef@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6622:EE_
x-ms-office365-filtering-correlation-id: 839f411f-9a59-466a-9e02-08de9c548e9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|921020|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: nhM/OfXO1TQVq9+O1ssQTjcPKRmo1rWujXHDaeCebbGRK1qkwGP0FyZ167gWSghZEW9E2xOC78wBR956ZXrK3UVpiWs1WQezUDVUbIRPPXurCdoepb/86umBPBGPeFgew8wD9VXI8/U9zk/unhKpRuEa/tx/dERP9M55TNJxH7a7/67+Lm0PGAFaMGXQ+OF8YQLo1XTt6TOQ0DG2KzajvdBH6TyGXsphHIU+vAfIBQUh6aKUQbFWqxAwRDVG0aq8hHMPFx8B9UBGW7WoBxxKjHG8Z0SLyzZCkRqOI4vCcWr+BXundXd8l0/QlH7dTtcLGSlJIlkMkGLpu4rUxRD9TnEb9opHwt9Lzj5EEGzZYIlMKP2owaWRTSkF737NFxrYp0fSvUXwXvqajcQZ+N4dDTcGA51nbPnPV63Zars3RU1BkRCRQZtLnEfLL71EaVWIQKf62nV2YxUwLk8ndEP6Yc46TZR6Y6OVdM3hJAnlc/sCxD0QU/amyNCQnwUGzgcMH7MhGyGAeBZD1BCQHrtPAO2IF2O71r+MT5UN7BVLzYaN2wX6nwFa6gZbxjSULwf2G3ohumOWl5KynOA7cGK0lbkfk1YOYTKEr7835fND78dWAQri5wY1DrCqzjJ2LBfa07Fhr4E8pnuziMI0JNpC0f6VPG8EongqgjP5meOkSJLXtHBT4pfovqFoZtIXNSuJ2GBrLiT6rxbKtv3C6e4rSud9PWNqshV7HfWYUo2KbajqLuNDbJgmQwIjWkmv/4SwsHzJCDSpNkKUE8On//RRXB4NhQv0QrtBmGGGfNH+MuMzbLyX9pPRWiPOS9srO7ko
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(56012099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1c3aTdDdjF5WHZJMFRDUXJJMytWdW5QOGdQNFFTR1NTZU8xaS9jeVIxZmFu?=
 =?utf-8?B?eEVKOXhxWGZSRnpTZjkyTDZBRXcwZzNNSEl5UEhReXBzbXBzRkFtdEd4TERv?=
 =?utf-8?B?blhxUHc2M2hkR2ZkbDBKcEZKcFFzamVFWkd0QlpzQVpGN1dZR1l3MmxoSVdw?=
 =?utf-8?B?ZVgzNVppYkJ6YkdPMzF3WVZyUEEvbXlid2RVekZOUkhhcmVlVnc4cFRGbGRL?=
 =?utf-8?B?Uk11dmlHQjcwam43Qnl3bzBhQXllVDVOenE1blphSmhwRmEySm5vRW9vTEc0?=
 =?utf-8?B?eVBkYnQyQUd5L3BxUGVxZjY2bk9ydHpIV0kxN0pkOXI0TkxiSFFWd2RZMDZp?=
 =?utf-8?B?VUtnRzEzNFJoUjM1akhOc2NhZWxIeEd6bVdUakhTWCt0VWJSbjJlbmlZNWw2?=
 =?utf-8?B?YjV4dTM3MERrRFlyNEcyVnFTUTNrMnBGbzduZU90Z1VXOW1wTnF0ZVRMUmMz?=
 =?utf-8?B?bE54cXBlQVVpdG9LZEM0ZU1nYWRwQXhpL01xVGdRSkd1djYrNXAxbXdzMFpz?=
 =?utf-8?B?dFBOZ2VQTlVYVE5ldHg3Y2RpbnNBY1dLa0g0UjNDd0NSYmNWSE9ZTUFNUkJj?=
 =?utf-8?B?Z1N5WmVaQ3JtZ1p6Z0xpSVFqNFc2TS80NUpxZDcyaHM5NWpDK2hRY3pYT0t6?=
 =?utf-8?B?b3Y4VCtocDRpU29iTWFIQ1l2YzBxZzFoV3l6UjhSWUgwSE9DdFpucHZoWHZX?=
 =?utf-8?B?V1d0azVacXdpblkyR0pCZEorMUVGUURPNyt3TGhhUXF1L1BOK1pMUGtnWVlI?=
 =?utf-8?B?QVk1Z3EzaTE4cTFGdmtQbXd5QTl6aFdIMy9TSnZmN0pFV0pabDVzQWc2Unlh?=
 =?utf-8?B?WGxHOW0yWFFIeDNMR0k3UzMyZVpDTXNCbHV3dEl5cHA1NmhEdGlmc3B3Z1ZT?=
 =?utf-8?B?blpRRWxXUGk1ekNHVnZKK25MUmE5T2U1U3pCVURlemxkUStiNFdJZ0FhWElu?=
 =?utf-8?B?MDlBMkdnRTE3cnlyYWNwUUJaQWRhVU5ieWtVMGgrZzhxeEhEdTU1VW40TGo4?=
 =?utf-8?B?bTY3OVp2b3luSVZ4MkhmK3Fkckwrcys5Z2plby9hQmZWOVBhaVBxSjliR2Va?=
 =?utf-8?B?c3lQMTdyaXdTM0NQRFBKcmtJS0lyTUVQd0t1RVJNTll4NVhMd3g1QWJUdng2?=
 =?utf-8?B?TzVOL2dBU2NPTmxnRElIWXpMQ3Zkb3NodDBjYXBzQjIxa0dXYWZDN0FSU05Z?=
 =?utf-8?B?RDlZZUsvWEE5ampGbFYxa21MdUZTY1ZXYnVudHFLZkVEQjlsL2FzdGRKZ2Nj?=
 =?utf-8?B?Y04zWjhoZ05pVmNqdE9OWk9IZjJEYWc1L2ZKVjZoVEMvTVk2TUsrMXJVUC9V?=
 =?utf-8?B?aUZ0dTVlaTZBSWFmRmlvckp5cXN4U1VCVEUxMEkrc2JGdEU3a2dLZ1RnZS9p?=
 =?utf-8?B?N3Fjc1F6RmhHaVBvb0RFN3MweFNjZUFRVlZPQmdWcFZ4YU1CSEJUeUVpUzdr?=
 =?utf-8?B?L2pIblkvS1RNQ0d1OUw1T09wbXhNUmlrSC8vaGgvMTl5M0hpUCtRUTAxRWRG?=
 =?utf-8?B?d3ZqbWpuSDg3aWQ5WWIyTlgzWkVjS2I1Zk80aFYwdFdnNVQyczkwdFl5ZlI1?=
 =?utf-8?B?c25PczdZNWFCTklMM0R3b3ZseC9GTTUwYVUzNEdzakVES2k0cHhLUTVBVUVa?=
 =?utf-8?B?OVlMWnlGL0trWXdvY25GUmxIQkl4MDhOWFJ1dUN0MjFxY2V5aGRlZFkyWnB1?=
 =?utf-8?B?MjhFT1JYUlJlSFd1RzFnb1phK3NsUEdZaTF0UGNOREVzQUV0akptTTYwRjh6?=
 =?utf-8?B?RzE2OXZUc2E2MHpLZEx0YytCNTE0MjVEOWs5UXBuS0NSVHRiVnVQSTdWbCtk?=
 =?utf-8?B?bmxlcG9OekhyaWFqQjB3RHNLRkNDSUJwR1hra0h5S0JncXpoY3lpODVKeGJH?=
 =?utf-8?B?d2h2MzhUc05tZnE0MGRhVW0zdjl6K2VYTWpaWUdBMHpFdFd6QTBzTTRibzdV?=
 =?utf-8?B?TnZXQUZZUk9ldFdOUFBOcXJoNjZWRGtlK1kzdnptVU41Umk3VXdIK1dKdnMy?=
 =?utf-8?B?ZStkbzhXM1grcUt1eXRiWU9BVS9Ec3NoRWduVVNEc05NOXFLT1dnclozeXJH?=
 =?utf-8?B?Slc5Vjh6MGlFOGxxdDVXRklXOThiOVpOdmFLQzdWamlYS3pmbVZndTdzZW0z?=
 =?utf-8?B?MmZOU0FPZ1FvVGVkWmtzUFEwbkx3TUJjK0dzaFdjTUJGS0U2MVF6d0pBbllO?=
 =?utf-8?B?Z0VFQVh2VHhtNU01V3MxeHg1SERLOVc2eUtwZDV3Y2k0eWoweVlaRWMyS0VG?=
 =?utf-8?B?R0U3eXEvSUxYejFPOGVoMnJ6UlBJbDB0dDFtdlkwbVVrR0NoRDJJekhneFha?=
 =?utf-8?B?ZjVJdWMrY3QzZHFVYUxQUWRFR1pPcjRLSE85NEpVTnNOelIwdDM4UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ie6ENmjss90K6BFF8Q8JjIk+M/+tzIm7mMvIikXsguKkJneDUoVJMI7bRYpgJbA99dXZlsrRiCVBXZh19Z23rjwK2qd4R+xJzZKRKSm9e6yhFm7LrnX0zC0Wws9r2BVIpotAn/E0oNVVlnTA0GRSNxtoW/uN/8Xmc2Xfn+XBRtlo/7SaOZ+Pbd6SWk4aZV53xUaVU5v7YgUNGA3VTqKISM08dz9LMDFn6+VZlpUGeEe6uP0ys+QBw1CN3yaGwKJ+Lb43nH/q/DXrnPbnG5ItJxF4W/FTg349fGUHpUfc9BYZ/JFYkJQxvHgO9CJU4t28jBaKNvtqS1yp6FDBxGBVNA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 839f411f-9a59-466a-9e02-08de9c548e9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 07:40:11.6737 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jwJ9nQfK+o3ABJxGSVZSxQTpYyIg6UPyfRQTkjZxwQeJ+MgXM/dCgjXWvQILVr8CHPII+nj64wj4iJxD+NNxnUsydsNgFGLPB11bK2vPcQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6622
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

SGkgUGhpbGlwcGUNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDE2LzE3XSB0ZXN0cy9mdW5j
dGlvbmFsL2FybS90ZXN0X2FzcGVlZF9hc3QyNjAwX3NkazoNCj4gQWRkIFVTQiBFSENJIHRlc3Qg
Zm9yIEFTVDI2MDAgU0RLDQo+IA0KPiBPbiAxNi80LzI2IDAzOjUwLCBKYW1pbiBMaW4gd3JvdGU6
DQo+ID4gQWRkIGEgZnVuY3Rpb25hbCB0ZXN0IHRvIHZlcmlmeSBVU0IgRUhDSSBzdXBwb3J0IG9u
IHRoZSBBU1QyNjAwIFNESw0KPiA+IG1hY2hpbmUgYnkgYXR0YWNoaW5nIGEgVVNCIGtleWJvYXJk
IGRldmljZSBhbmQgY2hlY2tpbmcgaXRzDQo+ID4gZW51bWVyYXRpb24gdmlhIGxzdXNiLg0KPiA+
DQo+ID4gVGhpcyBpbnRyb2R1Y2VzIGEgaGVscGVyIHJvdXRpbmUgdGhhdCBydW5zIGxzdXNiIGlu
IHRoZSBndWVzdCBhbmQNCj4gPiB2YWxpZGF0ZXMgdGhhdCB0aGUgZW11bGF0ZWQgIlFFTVUgVVNC
IEtleWJvYXJkIiBpcyBkZXRlY3RlZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEphbWluIExp
biA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiA+IC0tLQ0KPiA+ICAgdGVzdHMvZnVuY3Rp
b25hbC9hcm0vdGVzdF9hc3BlZWRfYXN0MjYwMF9zZGsucHkgfCA3ICsrKysrKysNCj4gPiAgIDEg
ZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykNCj4gDQo+IFRoaXMgc2hvdWxkIGJlIHBhdGNo
ICMxIDopDQo+IA0KDQpUaGlzIHBhdGNoIHNlcmllcyB1cGRhdGVzIHRoZSBVU0IgRUhDSSBtb2Rl
bCB0byBzdXBwb3J0IDY0LWJpdC4NCg0KSSBhZGRlZCBhIGZ1bmN0aW9uYWwgdGVzdCAoQVNUMjYw
MCkgdG8gZW5zdXJlIHRoYXQgdGhlc2UgY2hhbmdlcyBkbyBub3QgaW1wYWN0IHRoZSBleGlzdGlu
ZyAzMi1iaXQgc3VwcG9ydC4NCkZvciB0aGlzIHJlYXNvbiwgSSBwbGFjZWQgdGhpcyBwYXRjaCBp
biB0aGUgY3VycmVudCBvcmRlci4NCklmIHlvdSBzdGlsbCB0aGluayB0aGUgcGF0Y2ggb3JkZXIg
c2hvdWxkIGJlIGFkanVzdGVkLCBwbGVhc2UgbGV0IG1lIGtub3cuDQoNClRoYW5rcywNCkphbWlu
DQoNCj4gUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJv
Lm9yZz4NCg==

