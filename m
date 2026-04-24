Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB784FB44A6
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 06:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG9dt-0001Vc-6g; Fri, 24 Apr 2026 02:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wG9dq-0001UI-Sz; Fri, 24 Apr 2026 02:03:54 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wG9dk-0003K9-R7; Fri, 24 Apr 2026 02:03:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+I/Ap57KsggPeHprnzhVuRNNdY6HXFNVtLQiuEoHau7IfX0gp1rIkyY6YVQ6igFNvTfdwV2EyWjKHwgkFdFeFAtQ6Ug2f3fxcx1JdcvdV1pUPodMoVAytn7uonnio3DVv6SVnAp6VgwyobXHCkTXrGChCq/cuTK5egnEIGA5n87YjCnLakR68AlzERgAT00ADIGlwzJcoZza4Nb0MGFfwLEzN78DAxOYJwxPdMJv7Z729WyxY7hFzglCFle177OKebirsE7MYpRBmfurD3VA/YdTdagIMHXPhpks28Stu+IxU6js2QiVhC/crb/aTviq+40I2/nhrlXhPso835oUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gM2yEi8tDmkwgZzfcD/SoD7Yxp7W8GptoH3e9H0e2cc=;
 b=ZRM9IF73Bel3enDpVVff8Pb/31s0MMaS0aeLGvY6v6ZBN4+c6NSnHBj4reL3JmnEfq/ysNmIJ+3LFQuCli2ZBVA1yDwlhx7//pJT721bEelg9REAMnkeE2VAs5ba4kGuSnKx6jiuR+f82GhAXulaTuzE/8aU+lQR1YIsIBxZoCOdmnw1i3mgpl5R4wFahREiDfolrg9GK2Htpk3DuM9xL4hXUGuQDCEfFrCj3j5KAYs8iVskESG8QrUjhM2gWNny2LAtNer3Ug1BGMo0k5xWpu/YZ70iTFpjhDJND0NBzqIcC4eI0XJjH1/cJNNVcnIEilQnuKyNVL40o6QcNMBy1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gM2yEi8tDmkwgZzfcD/SoD7Yxp7W8GptoH3e9H0e2cc=;
 b=nxGH6cO+v85au7fdrCAj7QhC158EPuhh22tDH7QkX4QRt4X73pmcp/7T09jBpYvUVxGHxLRd0hq+zKzVeZ2z5lWRmDHcCiqHLnAXLXYkhkkCxEl+bXphazFCcKzHF+q3HLFv8UfLPc4G0eMbRjaPK5yqcz7PuwbVTJnj4wZkEPvgL2RPlZt4XtJ7PljznbeBo5Xo4fcmYv3NAKLsMji02Dv1zEE0/WlrqANs/68VDjK/8c+GEMwnpjOV/Dj/8frK1N8Tlc3JHWs3VF3/gHfRhbec7FlID69iHQI0tW2XCSKI4XkLkFlOAKBuUDtSx+Je0owjd5imDeWD89oGQzDcxw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5829.apcprd06.prod.outlook.com (2603:1096:101:c9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 06:03:38 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 06:03:38 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Peter Xu <peterx@redhat.com>
CC: "philmd@linaro.org" <philmd@linaro.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, Troy Lee <troy_lee@aspeedtech.com>,
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "farosas@suse.de" <farosas@suse.de>
Subject: RE: [PATCH v4 08/17] hw/usb/hcd-ehci: Change descriptor addresses to
 64-bit with migration compatibility
Thread-Topic: [PATCH v4 08/17] hw/usb/hcd-ehci: Change descriptor addresses to
 64-bit with migration compatibility
Thread-Index: AQHc0uCWDRW5scSU9kSZ62gwOB1gJLXs0MGAgADpgKA=
Date: Fri, 24 Apr 2026 06:03:38 +0000
Message-ID: <TYPPR06MB8206D2B9E0632433CB9D3C5BFC2B2@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260423051804.362095-1-jamin_lin@aspeedtech.com>
 <20260423051804.362095-9-jamin_lin@aspeedtech.com>
 <aepDtUYjYfag6TeC@x1.local>
In-Reply-To: <aepDtUYjYfag6TeC@x1.local>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5829:EE_
x-ms-office365-filtering-correlation-id: 333fb694-7ce8-4b00-2814-08dea1c73a75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: cp0rYDNBnejylr1pAOrd21m1Cu92uf3i5+TLY+PwHLedA/cfnEjQh3S7ETE6B/gJwbDSJSrrazFOJOZBSh7S7CqRk54wlK1iAn0vVLcRwpheQsVTlzKuE7YFQ1aG92kccp6zyzDzAAjbD9yEUR6sl8F9ibC7qcyPkqDZ/fR06xCHcnJYiNfWgoLiIWXGS7HxUeNFkSddh/Yd9WAHVWe1pHJJi+5DGmqJ2nFld4pf/mVrh68lzvPs6l4eyWOQmrxwue50PF8R3Nypq6YnD85oSf12c19MtzECrGXofQxuO2QX8yE50vOXwC7DTaBMZOF1PkepoktXkkyCXDEMbCZ/V/rPH2yy4foKZ6oYRb5DLJ7HlbLY9z0UzfbIz4Uhb++2kQlvl3k8A7TMtcobL2KziF6r1LTEopmrkSv8VB5EOB5Rv+xcWvKudq3zqHcWri+ZMwC6SbpolV+J1H19//UBWpw+XAJgDo1sCP9U/vm29LKgsJItUs1Tw9542yz7wCf2YUEiJAAQbot246dEApOhOOIFAhpgmgtNt03E1DGcOv+xsVJqPU5pFoDKsO5vQl0RFLFDZRyWI84apqJn2I4vIPbjLASQ8XYqL04Gvoec44tAhmNItIa5sKcGxOJzWBnGxtOv+xKN4DUdFYz5VQer/PNictDgUsdI2zJbcgMD4H5a3z1vL8/sEp7oOg+3RsVN1QDTdNlUfjzm4KU4FueEZtJ2QkfD5rGrNLe9KCDPWrxJD4oxSll4KCDZ+PFirvVGeRK7o1Icv7+iBdLs16SJjtY/NMdfqQBwZIZoxFzC9gI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3J1aUtLNm4yeEcwZm1xMWt6WGdvZWR1bjg0bGEzL1pBdXJuVVhGZGZiN1ha?=
 =?utf-8?B?L0p1c2xEOFRRaWdnaXE0MGlDRzI5ZExicXRKL3MvNjc1RWpueEdCeEczR2JG?=
 =?utf-8?B?RzFFWXVoS2tmeHBFYnFpamxnemQyZzUvSnR4cGt5bEc3RVJCdmRWa0VSZTRK?=
 =?utf-8?B?TVJLYTJzb0JzK3ZpVGpWczFUdDBQRXIxODgrK0FUWWF6Y3JHM0c1dm9PWEFW?=
 =?utf-8?B?UTIrUWg3MTJrT283blVpL0J5QVpjNlhhbHVzSDZnYXU0Y0VJZ2JYbGt1cU5D?=
 =?utf-8?B?Uzl5c0w4bnlyQzhnWVFiSVBNOTNxQkxtb2MwQ1NpRUh0WFgvODRnTnV6b2tr?=
 =?utf-8?B?dXNFdkxnNCtya3FlcCtmUWJmcmJBNEtlRnZOSE1Id2hlS2dNd0xjYThCaGpy?=
 =?utf-8?B?MnNuMHVqVyswNGY5R0ZIMzJ2MENhQkdKUzZrU3pZbm96cXNTOUhlZ1piMzAy?=
 =?utf-8?B?NEw5cDh4L1BmNXc1T1lHQ3ZKNkp1aGVnWVNCMldWdlJZTlZtMkw5N1R3Nm1K?=
 =?utf-8?B?SVNwL0dpQlBST0VEVDZ1cDQvSDF6QThmYzloMGtZc29lcVZMRnZkbkVsbmNo?=
 =?utf-8?B?dnQ1RW9WS1ZXTjFSSGhzam9DOWNCZXBDcm5hVmZKenk0cnkrU0FuQXpGMHo5?=
 =?utf-8?B?UUtMYU0vaEVDM2VGMzR4QjNPc2xOS21KcUZra29XV2UwMGR5akRrWmVkaVVq?=
 =?utf-8?B?dHNXNnVpbm8xbGN4ei9aNXppL2hYUHhRTUlTK21PZG1Pa2c3bUhxVUVteUxs?=
 =?utf-8?B?YUUvLzFOSUNTTENBOVpqaStqMC9mTlRIQjk4S2tHOXNFc0FhTkhYMXlqcFQv?=
 =?utf-8?B?TFlwNEVQTlVEVHdncXhtWktEbVFqQlNrUDFsQm5ncDM2MWNuU2g4bGVvd2tG?=
 =?utf-8?B?Y2hoaEljNHJSSHZOZjRmb0ZpSW1iTDYydXgyWDVsRFkzczJTWEgzRkdPU1Rn?=
 =?utf-8?B?Q0dpMThOWHorV1RHdUdvT2c2c0tpVEZ1YWNiSGtlOWxrU09TZW1xMEk0RTlI?=
 =?utf-8?B?UyttcTJBWE5oWGpHREpINFhrZGRhZ1dQc0FQTnhKY3lpdy9WTkVYZ2xKTmVP?=
 =?utf-8?B?MlhJYWN4MWR0aE80b1phbnExLy9kL1JudjBBQVlmbC9HUHl6cmd2a2ZnVzV1?=
 =?utf-8?B?UXhQVmJ5TC8vMURVWFdhL295RVpyc1g0bU1leGUyMGRyREF6ektFQ3d4YjNk?=
 =?utf-8?B?ODBWSldZS0kyNlZ1ZmFxakNYMDR4RVRrNllCbWtLRTl3emtSSnQrN3dwbGdh?=
 =?utf-8?B?WUhXNEJ3UlBvdElSanRteWdLRE1ZMjlFQUtvZUNCUUo1THE0RUFvRGo2V0ZG?=
 =?utf-8?B?MDEyb1dYei9LRkhCY05UQk9IQmw0WURLMTJObE44d1lPOXdmL2I2RGp1cHUw?=
 =?utf-8?B?ZzFLT0h4cUxXNVBQeXBJSU05WE9DOGg0UXF0RnNyb05DZUNLSEo3TndJa201?=
 =?utf-8?B?ZHhCRTk0T1VvTGRaZ0trR0FaZzFtRUtweXVTUTA5dUxWWWFjWlQ0cGQrelFl?=
 =?utf-8?B?WDBVZUh1MFRZMUd2VXFFcmdLa1g4VTdTVVhCbjFRdDhyVGZvV2h1d054M0xH?=
 =?utf-8?B?SzBRcElzcGl0Y2FJejR3SHJKMDBUUW0zMERVTHBCNTZyaFlJMUc5RlM3cVJ0?=
 =?utf-8?B?MUE0UTEzYkwwVEVwZ29oeWV0VTMxVkZrQm1yLzZJT0Fjc29kWncwRmFqN1ZY?=
 =?utf-8?B?K3M0aEJ5N3l1QmRPdTh0amJBK0luZ1h1S1dReHdxSlNFT1ZNZCtKL0dHVVY1?=
 =?utf-8?B?aVRPMk5oOXEzeFhJTE1ySXp1ai9BWnloNmtHeDJMc0tQNXp6K2V5RkEvSllE?=
 =?utf-8?B?WHB1S0NRR0VSTzVNcFdpMGx6aGM5L1RPdFJGUk1XSE1ianNYaGNvWDRMa1Ay?=
 =?utf-8?B?QnJiTVpDU1pEeXFqbFI5RzlZTkxTSHN2TjQwaG02LzdiV01Qd2RYY1pZRDN6?=
 =?utf-8?B?TzRrdHZ2cHhVQ09pTVFxVDdBVzNVbVVHYkFWVEtsRU1UY0NJTG5Hd21IMzFN?=
 =?utf-8?B?dWd2aW9EZ21WMnNUQXR3RjVML0l2WnZNZG5zbytkejQxUmRHNVlybDdoang2?=
 =?utf-8?B?WjFZTHNlMWtNM2hRbmdPeWdrR3RZM3U0c2RFOTIvMUFhM0dZZWpVQjVxZy9T?=
 =?utf-8?B?WWVidmtRYXhCdFIxSVdYNllSOTVEc01VT0RhbXh1YWJNRGZHck5zYVFuUUw2?=
 =?utf-8?B?cm5pemVzdUc5akFKT21iaFkvdnMwKzdRRWZEY3JqcFNjT2NJeEtkT01sS2hJ?=
 =?utf-8?B?YjJEQURrM0NNblk2ekN5cFIxcTE3ZEFXWG91MTJoVVlOei9yMGlMVXAzMG1m?=
 =?utf-8?B?Unp6aXMxSUp3U1RQdm1BSDdmVzR2elpaTFY5Sk5tNXprd0NKVXFrZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: josT4DFYurntpH27ymJdhyOkC7HEOn8fVMKG9Nty5LEBqdxwcKmTp1QqQ/LBuIWuQ9IokN9PWvshb5gakbjKh/WUPQ+E73vGr6n/ZVmczD6BSdvOhWnjys5u+QYNZD0oyEhms7dQ/BMsPmK0Lc0Sz5wmRBzq4U39yxWZ7igigOiIrWe2jdSRzccuUzd40fw5O1FE9TZS3l7XPCh8f68It845T4iuYVteb9Dme8fPxEwX8tHXVRrdHR1jn2tuSwx/zsvABWY2xY56epLCPycYMshkeA70SfyFY0IPij8vYKBJ2kC9et1yHdk6xVcXCjHnFJ5rzbyA0KpSLRPV1bwgrQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 333fb694-7ce8-4b00-2814-08dea1c73a75
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 06:03:38.4047 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XwkL1lD8M+ZesNSzLdFK9vp14tGyH3HcRcWnc52FAWZ0ObJeTTpdfOwlzP149CYLiUKXCaL+iDE0P4AU62mr73tdgiKQ4/m/M7LG0AuC9Jo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5829
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

SGkgUGV0ZXIsDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAwOC8xN10gaHcvdXNiL2hjZC1l
aGNpOiBDaGFuZ2UgZGVzY3JpcHRvciBhZGRyZXNzZXMgdG8NCj4gNjQtYml0IHdpdGggbWlncmF0
aW9uIGNvbXBhdGliaWxpdHkNCj4gDQo+IE9uIFRodSwgQXByIDIzLCAyMDI2IGF0IDA1OjE4OjE1
QU0gKzAwMDAsIEphbWluIExpbiB3cm90ZToNCj4gPiBkaWZmIC0tZ2l0IGEvaHcvY29yZS9tYWNo
aW5lLmMgYi9ody9jb3JlL21hY2hpbmUuYyBpbmRleA0KPiA+IDBhYTc3YTU3ZTkuLmU3NzQwMGM3
YWIgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvY29yZS9tYWNoaW5lLmMNCj4gPiArKysgYi9ody9jb3Jl
L21hY2hpbmUuYw0KPiA+IEBAIC00MSw2ICs0MSw4IEBADQo+ID4gIEdsb2JhbFByb3BlcnR5IGh3
X2NvbXBhdF8xMF8yW10gPSB7DQo+ID4gICAgICB7ICJzY3NpLWJsb2NrIiwgIm1pZ3JhdGUtcHIi
LCAib2ZmIiB9LA0KPiA+ICAgICAgeyAiaXNhLWNpcnJ1cy12Z2EiLCAiZ2xvYmFsLXZtc3RhdGUi
LCAidHJ1ZSIgfSwNCj4gPiArICAgIHsgInN5c2J1cy1laGNpLXVzYiIsICJ4LW1pZ3JhdGUtZmV0
Y2gtYWRkci02NGJpdCIsICJvZmYiIH0sDQo+ID4gKyAgICB7ICJwY2ktZWhjaS11c2IiLCAieC1t
aWdyYXRlLWZldGNoLWFkZHItNjRiaXQiLCAib2ZmIiB9LA0KPiA+ICB9Ow0KPiANCj4gU29ycnkg
SSBmb3Jnb3QgdG8gY29tbWVudCBoZXJlIHByZXZpb3VzbHk6IHdlIGp1c3QgcmVsZWFzZWQgMTEu
MCwgSSB0aGluayBpdA0KPiBtZWFucyB5b3Ugd2FudCBod19jb21wYXRfMTFfMFtdIG5vdywgb3Ro
ZXJ3aXNlIHNvbWVvbmUgdXNpbmcgMTEuMC4wDQo+IHJlbGVhc2VkIGJpbmFyeSBtYXkgaGl0IGlz
c3VlcyBtaWdyYXRpbmcgdG8gc29tZSBuZXdlciBiaW5hcmllcyBiZWZvcmUgMTEuMS4NCj4gDQpU
aGFua3MgZm9yIHRoZSByZXZpZXcgYW5kIHN1Z2dlc3Rpb24uDQpXaWxsIGRvDQpKYW1pbg0KPiAt
LQ0KPiBQZXRlciBYdQ0KDQo=

