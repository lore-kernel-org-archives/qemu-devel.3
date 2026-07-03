Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02EBC44500
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 06:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfXSu-0002Cj-NU; Fri, 03 Jul 2026 02:33:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wfXSt-0002CN-MV; Fri, 03 Jul 2026 02:33:31 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wfXSs-0000oF-3W; Fri, 03 Jul 2026 02:33:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWBji3VKLqPv1asjNECww6t4x+RhR5Mlr35u6nclszwzPtpDm57lS5tjALOu2E7xWOkPOUc+/zCFXKTc50tJH0IEwvhvZnd6E3b7XQ/R2VP9T1LFoyjlgD9M11/YPgOZSsDc4CRc29HtWsG/8ELeKMJCdPGYoaxUpVDZ33aBz97QWIieWGnbOypNVJuoMbAca2b4RwFL996dwx92cruSDPylpcASkWwMERKb1wS+wO4vs6fMGFwOEomACA9C0L6s85lqTvt0nPjlG/gNIR9ohR19Uki3xK3oVE+NUKnQhG49MkWBxDfxy+gA2eZz/UTYModBr3WOzWDL2E1B2KMxbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kVSdR9L8vRcWJtAXSmi/IjTqNDIYAK1TX+lXNcoUps=;
 b=m5oEy57j83uxQMExI/MwWESVTpfmYBT2bFtjVZbchq+5+B1iziQXAa0LwIxOB4ilWNbmY3dQAoBrpnXQdBS5ePp2D8PGmKfqMXNIMX00O/v0WZVHfgDCb+/UOSCwg3QOsIZ6njnDpOgA+f2YUDwtid/r9YuzptBGjQhiMKY3HdDxYLEYlp2FO49Tk3wc6nst39tvR2cXOXhUpxujjGdnwkAseXej7sp6tUzODdKGojM93HCRdq0zxiGeQZP4sQeLJRFbjNcZ4i/lEiEhVsNbuPNBeWB+GTnvciTDJMQTSzpNj04LIgeER2gpSBxrtlCg3GCbV4uHdtsQAUh9RwhTRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kVSdR9L8vRcWJtAXSmi/IjTqNDIYAK1TX+lXNcoUps=;
 b=DCPLWi5/7PADfzRX1MKZaMVo9ZEY8yG4b2fXyJ7/vDCObmWEE4ekFzsGuLcIl/s6C1iWMLq5JkiL1rFW5OLRt3AdL2cZzAQmRCmc+yxl6NjOy9arMxg4XEeSRyh5n6CdlhkzemBkfidCkQ67E2F2llbmdugCgj8iF3UIdkTy1Ub4gviTqh1QeJfmQw7Z5RcdCmzQjjVDWkADl4Z/dEaHmyi8FCqYV/WqjH9LW2dTN88Wp8UdM21MtRQ9I3NGHozv0hZEHcVx1kYlUjVsIM+i5AYauQ6li4GJCZnzvjqsEJ9YBzkUiyOOHwF9a7wIDWp6EufwWwrMlPOyVEuetrT9xw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by PUZPR06MB5819.apcprd06.prod.outlook.com (2603:1096:301:f0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 06:33:25 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 06:33:25 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@linaro.org>, Alistair Francis
 <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:Block layer
 core" <qemu-block@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v4 17/21] hw/misc/aspeed_scu: Add AST2700 SCUIO RNG
 control and data registers
Thread-Topic: [PATCH v4 17/21] hw/misc/aspeed_scu: Add AST2700 SCUIO RNG
 control and data registers
Thread-Index: AQHczhpVrugVxWMklEeYg06fZ9cdhrYqOd2AgDGVj/A=
Date: Fri, 3 Jul 2026 06:33:25 +0000
Message-ID: <TYZPR06MB4980C9F7FA48660D0CCE5F5AFCF42@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
 <20260417032837.2664122-18-jamin_lin@aspeedtech.com>
 <89fdb3d4-edf4-43f6-a489-076863325d0c@kaod.org>
In-Reply-To: <89fdb3d4-edf4-43f6-a489-076863325d0c@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|PUZPR06MB5819:EE_
x-ms-office365-filtering-correlation-id: b239ffc1-8122-4bf3-d6df-08ded8ccfc6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|7416014|18002099003|22082099003|38070700021|56012099006|4143699003|921020;
x-microsoft-antispam-message-info: iC/8ioxTLQN0PR8Unl78oBscf9XyylrTMNbW1EodvQ6Gmbc+BAihkmKx/8cSPFRBam3+PtdwsTLsPB3hpTPw4SntjS7+5gea5W3+D0gXbY5rA+kTuxnp7OsOT+VAKai6+1llg6geyynJtW6t/ooM9M5gP2rEISnktz4hEjEI35EcEUwhdt1+A26lSX9H+s73hNa2cC1+2u4tnnp361bz099SX+h3iHLwn2RM/ywvg4AxrzsrsC2Vo4pb9Tst3XRVdVAB2oG4lp1k9NGDkNq3EnmHygM5h9PoRHpbN7uYZJJjkBa2lGhVrbFk3nm3nVrrG9DzHO/+eGkxKpo7FnjfLg5nn3l77vi6CWaneMIGVhNQtHCZNc/ZHvbTXy5HxZ3O3+26GYYBzM5Exu/vD0GlAF0TjRg+xUGC5uDlThh5Zn9Bio3gqifPptl6I91m1xEuICUkyvZ9Z0ykPWn9CxQSclcfx/vHS6dGuu8qELYQWLeqtntmZUcLwjMinkMWCO861U53yb1pT5egvtxsP37krL/ezCQaH+tImFRmONtlJ0PVK8BOASMqDIe/U9KOx/Gl9yX2koPtQQZFaMT76my30MSUfupMX7N8FieuJCI0fPAmDkjlkTA56/Xuzpx+/AWdYnd79zsggoiDOuGmXdb8gO4VqKEFhE7xPzZQuHndVoAT+RKSGfSJte45b0iEGtWjZLYZjtSyks16MHNB/D4wRsV+ZF8bq/mcavWr+7NJFZI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(18002099003)(22082099003)(38070700021)(56012099006)(4143699003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2dXSTFPL3hqRFNxQVM3aWhNRnlYK0hvRnkxT0N1cWlOaHNsMjVzSDhGdWFu?=
 =?utf-8?B?Rm5ZcEVIMmZ4LzRFTnpCK1RuQ1JGdXRFdkFqbkdIOFp0bWkzcUVlaXVteFR6?=
 =?utf-8?B?bEY4NXFNVFhuMzQ3V1dxMVRuL2V2TGN6SEk0bmFXclhtUVJHUUJHRmZUYXR6?=
 =?utf-8?B?clBpd0F5d0FZeVdOcGhuWENDdGRNS3Q2eTBWV2l4dzg4TnIwMFk3djdqdkhJ?=
 =?utf-8?B?bSttSE1MdkUvMlNHNU5DMUEyem1ubjhQWktsQmxMMGZIR3hXa0xOYjNRQVNn?=
 =?utf-8?B?Wm01NXVEU3BWeiswbkRKSG8xOXA4M2tKQ1pTUDZ0UU1rNTg0TWFnVllMaDhq?=
 =?utf-8?B?aTREcDBIZWRTaWZZRWUvVGdnZGpqbEtCVGRRV0tZS1g0Vi9DanFneVNZVDRu?=
 =?utf-8?B?NlpFTEJobEZ4aWpyNE1JeVU3dFgxN3ByK294MUJucG0yeGdsUmY4QlFmeEww?=
 =?utf-8?B?T1ptMUJRZzcxOE9HTkd3SXBNbFFlQTg2Q1FQaFh0VjhzUjd4TXRGUnZGcURM?=
 =?utf-8?B?aXJOMmUrWUcyZGh1NFhaOG5tU0c3dXRLT1YzQW81bi9sWXRWejRTNUlYUWlz?=
 =?utf-8?B?YWpOVEczM1YxekQ4QUFkZkJMNW53WmNvcmptZDRneCtaVE12UEJ2b1pqMC8y?=
 =?utf-8?B?Yy8xei9mbWNBOUc2THFheEZ6aGVSTFJOcmFzdUFBM3BwUGVucHhHeFVFWUpD?=
 =?utf-8?B?SUxBajF3WlI4NWlhNVJzSTVHOXIyNEdlRU9YdWlVYUtEUjhQZ2xveTIvNnVM?=
 =?utf-8?B?dWFkVmtoNEJOTVJXaWg0V2Y0QVBoaEVubVlPNHRaL0dsRWhKZGNUNU12d0h1?=
 =?utf-8?B?N3QzbWxxMFZHVU9XT2t4WjdIV3hUdlJDUkYrRjNDTy9hUlpURnVwdG40c2NH?=
 =?utf-8?B?WHB5bXlKak5HcnFEUmlvSHoyOERyR2tIUUZiV3VObzdmYldkL2JlQVZBUWZE?=
 =?utf-8?B?aXhOdWFVa2N5bmUrWnRxNHFSbXdodzRsakNHMFFILzFQZ1BZcE0ycVBIa3JO?=
 =?utf-8?B?LzlDdklOM2pxTDJMSkk1bmRQRTdiYVFPMlVJbzVyOS90ampLRXpVYzUxVGYv?=
 =?utf-8?B?L0V2ZzlqVUc5NmVhNDZFNkFnTGRSQ1VsczYzMzhTNVN6dGpqYkhHbnJIWUFL?=
 =?utf-8?B?WXEyUmk1dWpTbkZaODMxRTNzZnY0MzBoZ3MwM2dYU04zR1VkSE1ReERsWkpG?=
 =?utf-8?B?MlQ4YkxzdUlkcU1ZOEE2SFpVRVlMdzdIYU9vUkJOUUlZTmNUZ1JCaW1rYitQ?=
 =?utf-8?B?UEVvY295YXJ6RHFHYXluWFhqWVFrY1o4ZWtFTUYxSTBYa3FFbGFIR1hWSlV2?=
 =?utf-8?B?b2JHM2phWDVVcnNPVDl0UWV2aHYraFBndk5ib0krS2g3MXdnVjZBOXVZa2w1?=
 =?utf-8?B?NDNjWUJKVWhMeXNKYUhCSndqNDJocWY0NC9CRU9QU0VSY2doVnhHTG5zem1U?=
 =?utf-8?B?ZVJaeitMdXA2QnQ2T01JVDlNbVM4dkNuOEtuUjR6ZVVmZmhyMkhBTTdTSi8r?=
 =?utf-8?B?a2JlU1hhN1Z5SHFTR2lnaE43dlA2REFZT0dPNmdNNFl5OUJxdEVRMy90OHdr?=
 =?utf-8?B?RnIwbmNvZ1kyQ29SaExEZ2dHaGtMeDdEcUZVQ0RYUGdqYUpKdzlLTkIyV3lV?=
 =?utf-8?B?bk05enhtUGo2L2QvQ2IwVnhwZ3NZTkdkRG1UVDVsTmdhaVJXNXQ0dEpkVU1v?=
 =?utf-8?B?S3o3NHNyekMyc2dUTllhS3ZRUlRvczIydlJQdmxwbGo2OEx5TXFyeWwwNHU3?=
 =?utf-8?B?UldtQjdvK21mL1RiU1ZFazlHWFZFcjU0SDJBMjMycnRSSFJ2dDBCc3l2bVRG?=
 =?utf-8?B?YThoN0ZHNFhPU2RJVC80ZHRiR3hiYjBzak85a0JjUFRPR0pLUjhWZmhHcENv?=
 =?utf-8?B?OFpUTUVUS1MxdE9KVTJUM0ZmRlpnVVA4THRycFZBdWdpS1ZWNXduVWdjSEph?=
 =?utf-8?B?WGpnYzA3VFlYcExLRWF6dXlhVHgxdlQrT2F6QXBlYmRBeVBYckF5NllWVlFD?=
 =?utf-8?B?VEhGZFdJM3dFSTZ1VWxOaVNjZ0g5WlR2cWlxNUxLUkgrd3FqTXdIbFNjcFAw?=
 =?utf-8?B?WGdvVE5wckk3SUVCVHZEbjdncnBwMkpVbm9CcndXYXYvVkErR1BWNnVyemI5?=
 =?utf-8?B?UWFFelc5QTdJdVBQOXE4UUdWSDB6eUQrWnBOOC92Z21lVWhwSE5KK1I2Y1l1?=
 =?utf-8?B?MGR5Y2tVU09ldjE1ZENuTDkwakpZWGx4VkIwWkRoSmdnS2ViVTNkVG93TkpS?=
 =?utf-8?B?QU9jRm9DRmt5T0cwQlJuY3dVaWx4S1o2K3pubWFIakkwdERNM0IxZlpOMUQz?=
 =?utf-8?B?QW80S2ZpSlJSclB5Qk8wWnp0Si9mYkYydlp1NEZqa0I5ZTA0WDd0QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qOgEXgWBd+OuClVASKydRn8rYU6QFI8oVZYN5NnKePLWPU94PBt6KTx4NMPbGA8FgnM9yyz4qKdKrkHWRh92oMwXi5W7oogqVv5HDw0edpafL062nXQmTVQGZHJ7/vAY8O4M/7fKQHRrQL55ZBjlk5ISjvlxCa6eq6JoWsZ1qKhOyYEhQS2Wk8XV6daJD0eIERtXCPoRomEAK0yIetBEKgbM88DQhmnFWy1xznVC7LWvclhiSdqTQddyyIPJGLkdLcmQozZYnfhPLB8l9N2Tmn/6trt6BAmN6x0sDM0WGGFz2ax/lgNFn/pYAhxhj0Tsn9pUWv3nQ0J7tDF0CeBu2g==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b239ffc1-8122-4bf3-d6df-08ded8ccfc6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 06:33:25.3088 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kO8il9rpV0beTbewE1wnahFf0NAIu7ygfyf9wDJATpBoSsfSN0K1cp2cboaFzHyCLG0XnKzqr5NLJ2Jl4PXY/n7Bkm5meyIE/7uj24XNYRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5819
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

SGkgQ2VkcmljLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMTcvMjFdIGh3L21pc2MvYXNw
ZWVkX3NjdTogQWRkIEFTVDI3MDAgU0NVSU8gUk5HDQo+IGNvbnRyb2wgYW5kIGRhdGEgcmVnaXN0
ZXJzDQo+IA0KPiBPbiA0LzE3LzI2IDA1OjI5LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gSW1wbGVt
ZW50IGJhc2ljIGJlaGF2aW9yIGZvciBSTkdfQ1RSTCBhbmQgUk5HX0RBVEE6DQo+ID4NCj4gPiAt
IFJOR19DVFJMIGFsbG93cyBndWVzdCB0byBlbmFibGUvZGlzYWJsZSB0aGUgUk5HIHZpYSB0aGUg
RElTIGJpdC4NCj4gPiAgICBPbmx5IGJpdHMgWzA6M10gYW5kIGJpdCA1IGFyZSB3cml0YWJsZTsg
b3RoZXIgYml0cyBhcmUgbWFza2VkLg0KPiA+IC0gVGhlIFZMRCBiaXQgKGJpdCAzMSkgaXMgdXBk
YXRlZCBieSB0aGUgbW9kZWwgdG8gcmVmbGVjdCB0aGUgUk5HDQo+ID4gICAgZW5hYmxlIHN0YXRl
LCBhbmQgaXMgbm90IHdyaXRhYmxlIGJ5IHRoZSBndWVzdC4NCj4gPiAtIFdoZW4gUk5HIGlzIGVu
YWJsZWQsIHJlYWRzIGZyb20gUk5HX0RBVEEgcmV0dXJuIGEgbmV3bHkgZ2VuZXJhdGVkDQo+ID4g
ICAgcmFuZG9tIHZhbHVlLg0KPiA+IC0gV2hlbiBSTkcgaXMgZGlzYWJsZWQsIFJOR19EQVRBIHJl
dHVybiAwLg0KPiA+DQo+ID4gVGhpcyBwcm92aWRlcyBhIG1pbmltYWwgZnVuY3Rpb25hbCBtb2Rl
bCBvZiB0aGUgUk5HIHN1ZmZpY2llbnQgZm9yDQo+ID4gc29mdHdhcmUgdGhhdCBleHBlY3RzIHJl
YWRhYmxlIHJhbmRvbSBkYXRhIHdpdGhvdXQgbW9kZWxpbmcgZnVsbA0KPiA+IGhhcmR3YXJlIGJl
aGF2aW9yLg0KPiANCj4gcGxlYXNlIHNlbmQgZmlyc3QuDQo+IA0KU29ycnkgcmVwbHkgeW91IGxh
dGUuDQpJIHdpbGwgc2VuZCB0aGlzIHBhdGNoIGluIHRoZSBuZXcgcGF0Y2ggc2VyaWVzLg0KDQpU
aGFua3MsDQpKYW1pbg0KDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KPiANCj4gPiBTaWduZWQt
b2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4g
PiAgIGh3L21pc2MvYXNwZWVkX3NjdS5jIHwgMjUgKysrKysrKysrKysrKysrKysrKysrKysrKw0K
PiA+ICAgMSBmaWxlIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9ody9taXNjL2FzcGVlZF9zY3UuYyBiL2h3L21pc2MvYXNwZWVkX3NjdS5jIGluZGV4DQo+
ID4gMzYyNzMzYmExMS4uZjlhZTY1ZDgzYyAxMDA2NDQNCj4gPiAtLS0gYS9ody9taXNjL2FzcGVl
ZF9zY3UuYw0KPiA+ICsrKyBiL2h3L21pc2MvYXNwZWVkX3NjdS5jDQo+ID4gQEAgLTE4Nyw2ICsx
ODcsMTEgQEANCj4gPiAgICNkZWZpbmUgQVNUMjcwMF9TQ1VfQ1BVX1NDUkFUQ0hfMSAgIFRPX1JF
RygweDc4NCkNCj4gPiAgICNkZWZpbmUgQVNUMjcwMF9TQ1VfVkdBX1NDUkFUQ0hfMCAgIFRPX1JF
RygweDkwMCkNCj4gPg0KPiA+ICsjZGVmaW5lIEFTVDI3MDBfU0NVSU9fUk5HX0NUUkwgICAgICAg
ICAgVE9fUkVHKDB4RjApDQo+ID4gKyNkZWZpbmUgQVNUMjcwMF9TQ1VJT19STkdfQ1RSTF9NQVNL
ICAgICAweDJGDQo+ID4gKyNkZWZpbmUgQVNUMjcwMF9TQ1VJT19STkdfQ1RSTF9ESVMgICAgICBC
SVQoMCkNCj4gPiArI2RlZmluZSBBU1QyNzAwX1NDVUlPX1JOR19DVFJMX1ZMRCAgICAgIEJJVCgz
MSkNCj4gPiArI2RlZmluZSBBU1QyNzAwX1NDVUlPX1JOR19EQVRBICAgICAgICAgIFRPX1JFRygw
eEY0KQ0KPiA+ICAgI2RlZmluZSBBU1QyNzAwX1NDVUlPX0NMS19TVE9QX0NUTF8xICAgIFRPX1JF
RygweDI0MCkNCj4gPiAgICNkZWZpbmUgQVNUMjcwMF9TQ1VJT19DTEtfU1RPUF9DTFJfMSAgICBU
T19SRUcoMHgyNDQpDQo+ID4gICAjZGVmaW5lIEFTVDI3MDBfU0NVSU9fQ0xLX1NUT1BfQ1RMXzIg
ICAgVE9fUkVHKDB4MjYwKQ0KPiA+IEBAIC0xMjU3LDYgKzEyNjIsMTQgQEAgc3RhdGljIHVpbnQ2
NF90IGFzcGVlZF9hc3QyNzAwX3NjdWlvX3JlYWQodm9pZA0KPiAqb3BhcXVlLCBod2FkZHIgb2Zm
c2V0LA0KPiA+ICAgICAgICAgICByZXR1cm4gMDsNCj4gPiAgICAgICB9DQo+ID4NCj4gPiArICAg
IHN3aXRjaCAocmVnKSB7DQo+ID4gKyAgICBjYXNlIEFTVDI3MDBfU0NVSU9fUk5HX0RBVEE6DQo+
ID4gKyAgICAgICAgaWYgKCEocy0+cmVnc1tBU1QyNzAwX1NDVUlPX1JOR19DVFJMXSAmDQo+IEFT
VDI3MDBfU0NVSU9fUk5HX0NUUkxfRElTKSkgew0KPiA+ICsgICAgICAgICAgICBzLT5yZWdzW0FT
VDI3MDBfU0NVSU9fUk5HX0RBVEFdID0NCj4gYXNwZWVkX3NjdV9nZXRfcmFuZG9tKCk7DQo+ID4g
KyAgICAgICAgfQ0KPiA+ICsgICAgICAgIGJyZWFrOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiAg
ICAgICB0cmFjZV9hc3BlZWRfYXN0MjcwMF9zY3Vpb19yZWFkKG9mZnNldCwgc2l6ZSwgcy0+cmVn
c1tyZWddKTsNCj4gPiAgICAgICByZXR1cm4gcy0+cmVnc1tyZWddOw0KPiA+ICAgfQ0KPiA+IEBA
IC0xMjgwLDYgKzEyOTMsMTggQEAgc3RhdGljIHZvaWQgYXNwZWVkX2FzdDI3MDBfc2N1aW9fd3Jp
dGUodm9pZA0KPiAqb3BhcXVlLCBod2FkZHIgb2Zmc2V0LA0KPiA+ICAgICAgIHRyYWNlX2FzcGVl
ZF9hc3QyNzAwX3NjdWlvX3dyaXRlKG9mZnNldCwgc2l6ZSwgZGF0YSk7DQo+ID4NCj4gPiAgICAg
ICBzd2l0Y2ggKHJlZykgew0KPiA+ICsgICAgY2FzZSBBU1QyNzAwX1NDVUlPX1JOR19DVFJMOg0K
PiA+ICsgICAgICAgIGRhdGEgJj0gQVNUMjcwMF9TQ1VJT19STkdfQ1RSTF9NQVNLOw0KPiA+ICsg
ICAgICAgIGlmIChkYXRhICYgQVNUMjcwMF9TQ1VJT19STkdfQ1RSTF9ESVMpIHsNCj4gPiArICAg
ICAgICAgICAgZGF0YSAmPSB+QVNUMjcwMF9TQ1VJT19STkdfQ1RSTF9WTEQ7DQo+ID4gKyAgICAg
ICAgICAgIHMtPnJlZ3NbQVNUMjcwMF9TQ1VJT19STkdfREFUQV0gPSAwOw0KPiA+ICsgICAgICAg
IH0gZWxzZSB7DQo+ID4gKyAgICAgICAgICAgIHMtPnJlZ3NbQVNUMjcwMF9TQ1VJT19STkdfREFU
QV0gPQ0KPiBhc3BlZWRfc2N1X2dldF9yYW5kb20oKTsNCj4gPiArICAgICAgICAgICAgZGF0YSB8
PSBBU1QyNzAwX1NDVUlPX1JOR19DVFJMX1ZMRDsNCj4gPiArICAgICAgICB9DQo+ID4gKyAgICAg
ICAgcy0+cmVnc1tyZWddID0gZGF0YTsNCj4gPiArICAgICAgICB1cGRhdGVkID0gdHJ1ZTsNCj4g
PiArICAgICAgICBicmVhazsNCj4gPiAgICAgICBjYXNlIEFTVDI3MDBfU0NVSU9fQ0xLX1NUT1Bf
Q1RMXzE6DQo+ID4gICAgICAgY2FzZSBBU1QyNzAwX1NDVUlPX0NMS19TVE9QX0NUTF8yOg0KPiA+
ICAgICAgICAgICBzLT5yZWdzW3JlZ10gfD0gZGF0YTsNCg0K

