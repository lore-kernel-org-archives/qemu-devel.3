Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E79FCD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 17:35:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSI9T-0003Lu-W3; Wed, 27 May 2026 13:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1wSI9R-0003Lh-GX
 for qemu-devel@nongnu.org; Wed, 27 May 2026 13:34:41 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1wSI9P-0007om-0X
 for qemu-devel@nongnu.org; Wed, 27 May 2026 13:34:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ViG0zwEafacqPPHp37PhesMbSR39DWK3yjmm8ou+PhqWANjMfFpXIEQfq9KIGr4GmR/vzDdsBEB0VC+z6bZydpY1pl/cNBPrBlY0tgBoRl6B/yo3eJ0E1FZTrL6ZVud3cQxWEzjSABNgUvlOKk8pfGK3v8g4C0GEiRrodcCRvTqb9zHxhTKAMLolqef4IBqVytu1UQR1MSobtF5LQyyIa97FIEL+ecyh26sQTu4MWQDPuk3dVs46ILd9XZur9Rul/gTAt9cfMeN0+ml7FYcfWMJOW/XBtgJ3u+6Y7V15yapfNe+4lYBKCxQJUtnhAppfiZGrmeUBMN/7u74+xgtgrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XsZVvrSXFIByw0FB8QZb4fZOgFjXkp1Aqt7zR7LTO4=;
 b=J+lJYHPsDgLvvC+H0NwN7m7V1izYXJ8Xs4WEIygXfaY2y/JeLuGCWawgQfJAAyrd09rOuzEIjZ2Mo2tWE0sohDS74WJ5T3fimg/hn9OlOkJ93HBgOBBDNWF3RC9sZYdWSDgBB8Rpdux8MRaNuFsOB7yP6SZ65/RtTAFaKfHSat14vGWkVHuSjfJA3vXb1LY1wS4JhaNyX1iivTse8yMkor0JQpU7M1G8jrbBBk8bFhaEAH8RgGXsxfrf9Wla2TliFvy6BLhj3xLlgfZ5rpr2/nlV5KOpDGvqeR9dxLewHiTRQGUpMxl5NScpUFQHU6Bf/uB08NUX0vxh+fgYiE9q1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XsZVvrSXFIByw0FB8QZb4fZOgFjXkp1Aqt7zR7LTO4=;
 b=JSVWPgELVKYR5bNO+3zAtinP8FZlZjuP1uO+maceCVtvyGloVWGrR1opfdLJmNifUvTFqnDuTVu99xBzwZkMB9yihgRhOejF9sJlTn5zm93sAneAItf2m/3oDlVOxkXdqTJqeu71WqW10ao83SJS4P+xxXZp9qfmz83f55Yl4uEBmwAX43chaiZlfdvGkq0RVQNV2ts30nl1AslDiwn9WZ/Mtp4x4k1BnUqn1Qm10/zRMQNYs53YAfUN6ejzIUnN9/XUq8Dx44iGSTUBJNqtaSov/FsCdF7u/Rrgtmeo2hMSOaEspI9cH/7jBGDUwtW8ud2+z+C60ugUreHMN2QoRw==
Received: from AM0PR04MB4370.eurprd04.prod.outlook.com (2603:10a6:208:6e::32)
 by GV1PR04MB10080.eurprd04.prod.outlook.com (2603:10a6:150:1a0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 17:34:34 +0000
Received: from AM0PR04MB4370.eurprd04.prod.outlook.com
 ([fe80::fe3b:fb2c:9dfc:9b]) by AM0PR04MB4370.eurprd04.prod.outlook.com
 ([fe80::fe3b:fb2c:9dfc:9b%6]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 17:34:33 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: Bernhard Beschow <shentey@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
Subject: RE: [EXT] Re: [PATCHv1 0/7] hw/arm: Adding Cortex-M7 Asymmetric
 Multiprocessing boot support for i.MX8MP
Thread-Topic: [EXT] Re: [PATCHv1 0/7] hw/arm: Adding Cortex-M7 Asymmetric
 Multiprocessing boot support for i.MX8MP
Thread-Index: AQHc57japbF9zYMUCk+sqgi5ImZErLYg3SaAgAEzEAA=
Date: Wed, 27 May 2026 17:34:33 +0000
Message-ID: <AM0PR04MB4370F0A97B0CF2363BFE9CA187082@AM0PR04MB4370.eurprd04.prod.outlook.com>
References: <20260519175635.3245229-1-gaurav.sharma_7@nxp.com>
 <D6AE3A65-8ED9-47B9-B7D5-51D8500B47AF@gmail.com>
In-Reply-To: <D6AE3A65-8ED9-47B9-B7D5-51D8500B47AF@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4370:EE_|GV1PR04MB10080:EE_
x-ms-office365-filtering-correlation-id: 672e4a55-cec8-46e9-a667-08debc16373f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|376014|366016|38070700021|3023799007|5023799004|4143699003|56012099006|6133799003|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: qvVbxaGbuSkIU6t6M9cbmQaY6i64MJDjy5fGBMsxfEZETCkmphqSZcGDnBjfAwEieA06fuuYnMq9As8/64SsvQxK6SrLtld3mubOvfpvgOYpiI4pfVgr2zaCi18ERoP3pMMXIF0gVffAl6sq6dXwQdD2Y09Q7dd0P+EKLzFy+xAqfHtyQfWItMDnjtlsG6d9Cy5ngc4ho2tZIFoGjopP6Qwj8rg7/zrrAPPIz4nOgVR9eKJHYy0k2n4W2hCWlwbue7Rbdc8ZKR1njvvn90icUAhnBTZw95UPntiiLXdCNapxG2RB9w6jHklk2tgHnPXWnSO+CQJtfKhU18bGMCtcEAAFqBlepTqaY9l/iowvsaLmSXrPFqiurjAz2Jm/KjEUVmWzKn3AK6Vke76YfluTi9r3TAaP2HN4pyB4hP1nhjGipGcIXYWWHCILRmZY+cj/oDcuuNGt6wLTJYkty7/xBaqD6Lgq8oVP8LPeF30SoSBFe6cLRRWvq2RsUbmZUxVZrFTdJJSdwDhZnOvBw+fwmaXIqk1qSgGrln5gD9YLq14R3SzfeqKvGY9YI8dw9wU6Phnu86ZD0zdcd7eKlgdY7K2QCRnyAaLKVLsgZoZt0TVbQb+EjfLBymLUsIjxX1MBEYo1bObq8mMNDqX1kJhBZjQ3gmE6rNypxFNSmAWgOv1erf7kJ6YMahsaQeCvTf9dS/0bSdVDHMVXOOtjfVtwYX+CQlCM3uu28PypEdFZWyk+JRm9N6n2abSzmEH5mC5y
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4370.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(38070700021)(3023799007)(5023799004)(4143699003)(56012099006)(6133799003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHhnb05GZHJQNmsvY1Y0YW9pRm1tem80UWhMMG9EbzUwcmQ4cWE0Q2VFY1dT?=
 =?utf-8?B?a0NhWC9mZXFVOTFHY21WMFFhNVRwUTcrWlhiUkJjNmtSaWplSTI3TVNON3Iz?=
 =?utf-8?B?aEJQYjVMYUV4d3lDNFIrbmpmK1JkTldGemhnZ1hZeUtWdWtqdEF3TUxvNjZD?=
 =?utf-8?B?a3YrSkZXczlXeGVlOHJ5Ui81eFFWMFBYK2hXam1VZXBvb1oyN0htUDh4SUV4?=
 =?utf-8?B?UTIwamRMSTE2Uk54Q2E3MlplZ2g3OWZ5OUpISUlmWWxDU215c3I1WWE0bzhh?=
 =?utf-8?B?RTZWV2hBUDdmRXM4NW1vQ3F0UVdiSWd3M0t0a3BTWHBiN2ZHK3ZRcS9TNTNG?=
 =?utf-8?B?QUFscEVWenJnUUp5SDJSWnQ4V0J5TU16SU9ORUhIRlJFQWVDV2ViQUNSZyta?=
 =?utf-8?B?OHV4MkpGcXlyeFV5WjMxeHFnSzV6UXVhNVY3M3NqcGhXNFppdXJYRUkwK241?=
 =?utf-8?B?UGpiWWNlcWVCNmFyQ0ZiR1RzN3pWZWR3RmI1ejF6UzlMRS9Hdlh5V0RUdWFo?=
 =?utf-8?B?bURPcURJMHdnc1loQ1lZL1lRRERkWi9NR2l2OE90TmlRNitmTDgrZTE1Sm5W?=
 =?utf-8?B?TWgxT01OK1M4VEpINGlJOGlyWlNkcy9YWDd1dUxKRFFYSWM2aGRaWC9xa1dU?=
 =?utf-8?B?MytodkVITUo1RnZyMVNIV1M2aU1ORStIZndaRXVBajdOelhIL28yT3owaWhN?=
 =?utf-8?B?eFQvMENUeVFiU0JzS1hRQXdJSkluR2grMnRZa25XZTliSFVKemxXVkVhZnNF?=
 =?utf-8?B?dHhxOEVRVTVXUGIwcVlvV1B0SUxWVWJKUVlqb3J5VFJqMGt0NWFoZkVBVHJM?=
 =?utf-8?B?ampTbVVMSGhyK0pjQncyaFEyZmFZY2xlUWp0cXFHLzZMVmVLNUh1eU5uNy9D?=
 =?utf-8?B?MHY3cXExRmtSa0N0VzRBOTgwTnpkWXlzMExDMUVhd253cGZ0aFhTN1ZoZFg5?=
 =?utf-8?B?Vm03enRBSmJnV1RocTNmY1dKSlZjWXpiWS8vT3ozeDVUTjlBU0pKcURwYUxY?=
 =?utf-8?B?N0xMdFhsenlTbFhUVWREYW5qNFRZMGZYcE1iV0xnR0R0M3RXZ1FlWWd3a3Mz?=
 =?utf-8?B?NDNhRlFUUGJ3Rkk5T1ZmdjV1dGlsd1BnemtvME9NYXpYd1U2TERJbGQzMjZW?=
 =?utf-8?B?bExZOHNQbGVGMmIvZTlvaFRwTlAwbmZZQjdVcEc4cW5qVWxXamF5TllyMHpM?=
 =?utf-8?B?OFJEQU9FOS9CRkVGY2llTVZaTXF1SG1WelNXSGJZM1ZkRjBweEFTUnFwa2xL?=
 =?utf-8?B?Rjk1Tm1nbldmT0VOZmhmNEJhcjh2MDZnYmpPd2pRRmNDSW92RFZxaURHUERw?=
 =?utf-8?B?RjdmcFcrbTBOL3VZZDhhbDB6ejJoS0JDYStaSlN2dXFpbHVBVEgvd2R3aU1Y?=
 =?utf-8?B?UGpRY3NoeDI3M0VGVzE4UFl6THpHLytJZFBCRVFjTGp3VkZuWUpCTDdPL2Zz?=
 =?utf-8?B?b0s4MXRtQmdhOHFabm5PL1JsWWc3TW1ERjU2MUFDb0JDdDlJSzkzQmJKQUdu?=
 =?utf-8?B?TEJscWd4bzJ6U1A5Z2lrSU5vS1gveDNnbUt4b3A5M1hsVktDaVdjL3hSb0xS?=
 =?utf-8?B?VE5jRzlFb0RBMHArWk5qcUVEYmIxT0tET1dXejF0SmVTaFRqSnE2d2NZdXlP?=
 =?utf-8?B?QlphSXQxWDBJaTZaRjhhQ1kvd2t1OUk5UUlST3dJcFBnblptam1INVhEaklB?=
 =?utf-8?B?OHVKZjU5U0FoKzZYNFZ1WUVIaDhxaGZTakwyRktmYzlhTk92KzB5THI1eG5V?=
 =?utf-8?B?cG9QT2JlZkx4L0lxZklqVjN0ekI1SndjS2g3Z2VNOE4yY29ZdHVRTEh5RTdr?=
 =?utf-8?B?ZWVuN3NSV1RPYXZWdDR5bjZKQTd0RG5OZTFORWgyTnF1bTc3d3FjdGRZNndz?=
 =?utf-8?B?d1BGUXdQWHAxOU5IYkxzenpoS1pXTnQ4TUp6RkhJOHJ0dU4wQTcwRDhJazl5?=
 =?utf-8?B?TXF1VDI3alhQaFBvNXJDb0Q1QWVHOG5FUGlSZDJuK2xQcUVBckVycTRVNDFp?=
 =?utf-8?B?Ryt2OHMrUllBSUhvYXlXVUNVSVdIWkVtZjlQbi84SnlwaTgzaXFRS0ROTGo3?=
 =?utf-8?B?YWQ1bkczT2lZS3hpZE43UE1MTHJ3VFlFWnRtYVh1UXZES01CUGNFdzFGeE9X?=
 =?utf-8?B?QUlrTWNaaHQrWFBGR2lTVmNXc2UzVkJOZk1ZQW5ORFhMOGZoZnVLM3RzTHl2?=
 =?utf-8?B?enhiRWE2NGJTSUtBeElTY1FKUDVTckQ4dXREM25pZ29RWGNTMlNWS1I2emNW?=
 =?utf-8?B?OS9Zb2ZEeEVCV293UjkzOFRaa1gydmd5RG9RVXR6NDVUSnRNSjFRejB6KzBU?=
 =?utf-8?B?MVBVQmt5L1Q1L0xseG9rL0FjelArcVVzQjFLSlVIU3U4dGNHR1lKUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4370.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 672e4a55-cec8-46e9-a667-08debc16373f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 17:34:33.5205 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DxkXXFLdeYrETK4EUu0n6ywoHlMyzUlUiAC4lRUeRiwu3u2KXmjWNEe2GCSInDEc+/tnEUthTyo8izuHuAtL6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10080
Received-SPF: permerror client-ip=2a01:111:f403:c201::1;
 envelope-from=gaurav.sharma_7@nxp.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmVybmhhcmQgQmVzY2hv
dyA8c2hlbnRleUBnbWFpbC5jb20+DQo+IFNlbnQ6IDI3IE1heSAyMDI2IDAyOjU2DQo+IFRvOiBH
YXVyYXYgU2hhcm1hIDxnYXVyYXYuc2hhcm1hXzdAbnhwLmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251
Lm9yZw0KPiBDYzogcGJvbnppbmlAcmVkaGF0LmNvbTsgcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3Jn
DQo+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0h2MSAwLzddIGh3L2FybTogQWRkaW5nIENvcnRl
eC1NNyBBc3ltbWV0cmljDQo+IE11bHRpcHJvY2Vzc2luZyBib290IHN1cHBvcnQgZm9yIGkuTVg4
TVANCj4gDQo+IENhdXRpb246IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0YWtl
IGNhcmUgd2hlbiBjbGlja2luZyBsaW5rcyBvcg0KPiBvcGVuaW5nIGF0dGFjaG1lbnRzLiBXaGVu
IGluIGRvdWJ0LCByZXBvcnQgdGhlIG1lc3NhZ2UgdXNpbmcgdGhlICdSZXBvcnQNCj4gdGhpcyBl
bWFpbCcgYnV0dG9uDQo+IA0KPiANCj4gQW0gMTkuIE1haSAyMDI2IDE3OjU2OjI4IFVUQyBzY2hy
aWViIEdhdXJhdiBTaGFybWENCj4gPGdhdXJhdi5zaGFybWFfN0BueHAuY29tPjoNCj4gPkNoYW5n
ZXMgaW4gdjE6DQo+ID4NCj4gPlRoaXMgc2VyaWVzIGFkZHMgQXN5bW1ldHJpYyBNdWx0aXByb2Nl
c3NpbmcgKEFNUCkgYm9vdCBzdXBwb3J0IGZvciB0aGUNCj4gPkNvcnRleC1NNyBjb3JlIG9uIHRo
ZSBpLk1YOE1QIFNvQy4gVGhlIE03IGZpcm13YXJlIGNhbiBiZSBsb2FkZWQgYW5kDQo+ID5zdGFy
dGVkIGZyb20gTGludXggcnVubmluZyBvbiB0aGUgQ29ydGV4LUE1MyBjb3JlcyB2aWEgdGhlIHJl
bW90ZXByb2MNCj4gPmZyYW1ld29yay4NCj4gPg0KPiA+VGhlIHNlcmllcyBpbnRyb2R1Y2VzIHRo
ZSBmb2xsb3dpbmcgcGVyaXBoZXJhbCBtb2RlbHMgbmVlZGVkIGZvciBBTVA6DQo+ID4gIC0gR1BD
IChHZW5lcmFsIFBvd2VyIENvbnRyb2xsZXIpDQo+ID4gIC0gR1BSIChHZW5lcmFsIFB1cnBvc2Ug
UmVnaXN0ZXJzKQ0KPiA+ICAtIFNSQyAoU3lzdGVtIFJlc2V0IENvbnRyb2xsZXIpIGF1dGhvcmVk
IGJ5IEJlcm5oYXJkIEJlc2Nob3cNCj4gPjxzaGVudGV5QGdtYWlsLmNvbT4NCj4gPiAgLSBNVSAo
TWVzc2FnaW5nIFVuaXQpDQo+ID4gIC0gRXh0ZW5kcyB0aGUgQ0NNIHdpdGggTTcgY2xvY2sgb3V0
cHV0cyBhbmQgd2lyZXMgaW50byB0aGUgaS5NWDhNUA0KPiA+U29DDQo+ID4gIC0gRW5hYmxlIENv
cnRleC1NNyBib290IGluIGkuTVg4TVAgRVZLIGZ1bmN0aW9uYWwgdGVzdA0KPiANCj4gQXdlc29t
ZSB3b3JrIQ0KPiANCj4gSSdkIGxpa2UgdG8gZXhwZXJpbWVudCB3aXRoIHRoaXMgc2VyaWVzIG15
c2VsZi4gQ291bGQgdGhlcmUgYmUgc29tZSAiY29va2luZw0KPiByZWNpcGUiIGluIHRoZSBib2Fy
ZCBkb2N1bWVudGF0aW9uIGZvciBlYXN5IHJlcHJvZHVjdGlvbi9mYWlsc2FmZSB0dXRvcmlhbD8g
SXMNCj4gdGhlcmUgcGVyaGFwcyBzb21lIEJ1aWxkcm9vdCBkZWZjb25maWcgd2l0aCB0aGUgYXBw
cm9wcmlhdGUgc3VwcG9ydA0KPiBlbmFibGVkPyBPciBldmVuIGJldHRlcjogQXJlIHRoZXJlIGFu
eSBiaW5hcnkgaW1hZ2VzIHRoYXQgY291bGQgYmUgdXNlZCBpbiBhDQo+IGZ1bmN0aW9uYWwgdGVz
dCBpbiBhZGRpdGlvbj8NCj4gDQoNCkhleSBCZXJuaGFyZCwgDQpUaGFua3MgZm9yIHlvdXIgZmVl
ZGJhY2shDQoNClRoZXJlJ3MgYW4gYXBwbGljYXRpb24gbm90ZSB0aGF0IGNvdmVycyB0aGlzIHVz
ZS1jYXNlIChBTjUzMTcsIHJlZmVyZW5jZWQgaW4gdGhlIHJzdCBkb2MpLiBIb3dldmVyLCB0aGUg
Y29tcGxldGUgc2V0dXAgcmVxdWlyZXMgY29tYmluaW5nIGluZm9ybWF0aW9uIGZyb20gbXVsdGlw
bGUgc291cmNlcy4NCg0KUmVxdWlyZW1lbnRzIHRvIGV4ZXJjaXNlIE03IGltYWdlIGxvYWRpbmcg
dmlhIExpbnV4Og0KDQoxLiBSUE1TRy1zcGVjaWZpYyBkZXZpY2UgdHJlZSB3aXRoIE03IEREUiBh
bGlhcyAtIGNvdmVyZWQgaW4gQU41MzE3DQoyLiBCYXJlLW1ldGFsIEVMRiBleGVjdXRhYmxlIGxp
bmtlZCB0byBydW4gZnJvbSBERFIgLSByZXF1aXJlcyBidWlsZGluZyBmcm9tIE1DVVhwcmVzc28g
U0RLDQoNCkJ1aWxkaW5nIHRoZSBNNyBmaXJtd2FyZToNCg0KMS4gRG93bmxvYWQgdGhlIE1DVVhw
cmVzc28gU0RLIGZvciBpLk1YOE1QDQoyLiBCdWlsZCBhIEREUi1saW5rZWQgZXhhbXBsZSB1c2lu
ZyB0aGUgQVJNIEdDQyB0b29sY2hhaW4gKGUuZy4sIGJvYXJkcy9ldmttaW14OG1wL2RyaXZlcl9l
eGFtcGxlcy91YXJ0L3BvbGxpbmcpDQozLiBDb3B5IHRoZSByZXN1bHRpbmcgRUxGIHRvIHRoZSBn
dWVzdCBMaW51eCBmaWxlc3lzdGVtDQo0LiBMb2FkIHZpYSByZW1vdGVwcm9jIGFzIGRvY3VtZW50
ZWQgaW4gdGhlIHJzdA0KDQpDdXJyZW50bHkgdGhlcmUgaXNuJ3QgYSBzaW5nbGUgb2ZmaWNpYWwg
ZG9jdW1lbnQgY292ZXJpbmcgdGhlIGNvbXBsZXRlIGVuZC10by1lbmQgZmxvdy4gVXNlcnMgbWln
aHQgbmVlZCB0byByZWZlciB0d28gZGlmZmVyZW50IHNvdXJjZXMgYXQgYmVzdC4gSSBjYW4gYWRk
IGNvbmNpc2UgYnVpbGQgaW5zdHJ1Y3Rpb25zIHRvIHRoZSByc3QgZG9jIGl0c2VsZiwgcHJvdmlk
aW5nIGEgc2VsZi1jb250YWluZWQgcmVmZXJlbmNlLiBIb3cgZG9lcyB0aGF0IHNvdW5kPw0KDQpS
ZWdhcmRpbmcgYmluYXJ5IGltYWdlczogV2UgY2FuIHByb3ZpZGUgYSBwcmUtYnVpbHQgdGVzdCBF
TEYgZm9yIGZ1bmN0aW9uYWwgdGVzdGluZywgdGhvdWdoIHVzZXJzIHdvdWxkIHN0aWxsIG5lZWQg
dGhlIGFwcHJvcHJpYXRlIGRldmljZSB0cmVlIGNvbmZpZ3VyYXRpb24uDQoNCj4gTGFzdCBidXQg
bm90IGxlYXN0OiBXb3VsZG4ndCBpdCBiZSB1c2VmdWwgaWYgeW91IGJlY2FtZSBjby1tYWludGFp
bmVyIG9mIHRoZQ0KPiBpbXg4bXAtZXZrPyBQZXJoYXBzIHRoZSB0d28gc2VjdGlvbnMgaW4gdGhl
IE1BSU5UQUlORVJTIGZpbGUgY291bGQgYmUNCj4gbWVyZ2VkLg0KPiANCg0KU3VyZS4gSSBjYW4g
YWRkIG15c2VsZiB0byB0aGUgTUFJTlRBSU5FUlMgb2YgaW14OG1wLWV2aywgYnV0IHdoYXQgZG8g
eW91IG1lYW4gYnkgbWVyZ2luZyB0aGUgdHdvIHNlY3Rpb25zIGluIHRoZSBNQUlOVEFJTkVSUyBm
aWxlID8gDQoNCj4gQmVzdCByZWdhcmRzLA0KPiBCZXJuaGFyZA0KPiANCj4gPg0KPiA+U2lnbmVk
LW9mZi1ieTogR2F1cmF2IFNoYXJtYSA8Z2F1cmF2LnNoYXJtYV83QG54cC5jb20+DQo+ID4NCj4g
PkJlcm5oYXJkIEJlc2Nob3cgKDEpOg0KPiA+ICBody9taXNjOiBBZGQgU1JDIChTeXN0ZW0gUmVz
ZXQgQ29udHJvbGxlcikgdG8gaS5NWDhNUA0KPiA+DQo+ID5HYXVyYXYgU2hhcm1hICg2KToNCj4g
PiAgaHcvbWlzYzogQWRkIGkuTVg4TVAgR1BDIChHZW5lcmFsIFBvd2VyIENvbnRyb2xsZXIpIElQ
DQo+ID4gIGh3L21pc2M6IEFkZCBHUFIgKEdlbmVyYWwgUHVycG9zZSBSZWdpc3RlcikgSVAgdG8g
aU1YOE1QDQo+ID4gIGh3L21pc2M6IEFkZCBNVSAoTWVzc2FnaW5nIFVuaXQpIElQIHRvIGkuTVg4
TVAgZGV2aWNlIG1vZGVsDQo+ID4gIGh3L21pc2M6IEV4dGVuZCBpLk1YOE1QIENDTSB3aXRoIENv
cnRleC1NNyBjbG9jayBvdXRwdXRzDQo+ID4gIGh3L2FybTogRW5hYmxlIENvcnRleC1NNyBBTVAg
Ym9vdCBvbiBpLk1YOE1QDQo+ID4gIHRlc3RzL2Z1bmN0aW9uYWw6IEVuYWJsZSBDb3J0ZXgtTTcg
Ym9vdCBpbiBpLk1YOE1QIEVWSyBmdW5jdGlvbmFsDQo+ID50ZXN0DQo+ID4NCj4gPiBkb2NzL3N5
c3RlbS9hcm0vaW14OG0ucnN0ICAgICAgICAgICAgICAgICAgIHwgIDkwICsrKy0NCj4gPiBody9h
cm0vS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA0ICsNCj4gPiBody9h
cm0vZnNsLWlteDhtcC5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgMjEyICsrKysrKysrKysN
Cj4gPiBody9taXNjL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEyICsN
Cj4gPiBody9taXNjL2lteDhtcF9jY20uYyAgICAgICAgICAgICAgICAgICAgICAgIHwgICA5ICsN
Cj4gPiBody9taXNjL2lteDhtcF9ncGMuYyAgICAgICAgICAgICAgICAgICAgICAgIHwgMTI0ICsr
KysrKw0KPiA+IGh3L21pc2MvaW14OG1wX2dwci5jICAgICAgICAgICAgICAgICAgICAgICAgfCAx
MjkgKysrKysrDQo+ID4gaHcvbWlzYy9pbXg4bXBfbXUuYyAgICAgICAgICAgICAgICAgICAgICAg
ICB8IDMwOCArKysrKysrKysrKysrKw0KPiA+IGh3L21pc2MvaW14OG1wX3NyYy5jICAgICAgICAg
ICAgICAgICAgICAgICAgfCA0MzEgKysrKysrKysrKysrKysrKysrKysNCj4gPiBody9taXNjL21l
c29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA0ICsNCj4gPiBody9taXNjL3Ry
YWNlLWV2ZW50cyAgICAgICAgICAgICAgICAgICAgICAgIHwgICA1ICsNCj4gPiBpbmNsdWRlL2h3
L2FybS9mc2wtaW14OG1wLmggICAgICAgICAgICAgICAgIHwgIDI5ICstDQo+ID4gaW5jbHVkZS9o
dy9taXNjL2lteDhtcF9jY20uaCAgICAgICAgICAgICAgICB8ICAgMyArDQo+ID4gaW5jbHVkZS9o
dy9taXNjL2lteDhtcF9ncGMuaCAgICAgICAgICAgICAgICB8ICAzNCArKw0KPiA+IGluY2x1ZGUv
aHcvbWlzYy9pbXg4bXBfZ3ByLmggICAgICAgICAgICAgICAgfCAgNTYgKysrDQo+ID4gaW5jbHVk
ZS9ody9taXNjL2lteDhtcF9tdS5oICAgICAgICAgICAgICAgICB8ICA1MyArKysNCj4gPiBpbmNs
dWRlL2h3L21pc2MvaW14OG1wX3NyYy5oICAgICAgICAgICAgICAgIHwgIDMyICsrDQo+ID4gdGVz
dHMvZnVuY3Rpb25hbC9hYXJjaDY0L3Rlc3RfaW14OG1wX2V2ay5weSB8ICAgMyArLQ0KPiA+IDE4
IGZpbGVzIGNoYW5nZWQsIDE1MzUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkgY3JlYXRl
IG1vZGUNCj4gPiAxMDA2NDQgaHcvbWlzYy9pbXg4bXBfZ3BjLmMgY3JlYXRlIG1vZGUgMTAwNjQ0
IGh3L21pc2MvaW14OG1wX2dwci5jDQo+ID4gY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L21pc2MvaW14
OG1wX211LmMgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gaHcvbWlzYy9pbXg4bXBfc3JjLmMgY3Jl
YXRlIG1vZGUgMTAwNjQ0DQo+IGluY2x1ZGUvaHcvbWlzYy9pbXg4bXBfZ3BjLmgNCj4gPiBjcmVh
dGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9ody9taXNjL2lteDhtcF9ncHIuaCBjcmVhdGUgbW9kZSAx
MDA2NDQNCj4gPiBpbmNsdWRlL2h3L21pc2MvaW14OG1wX211LmggY3JlYXRlIG1vZGUgMTAwNjQ0
DQo+ID4gaW5jbHVkZS9ody9taXNjL2lteDhtcF9zcmMuaA0KPiA+DQo=

