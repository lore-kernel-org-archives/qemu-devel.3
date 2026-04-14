Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1D8F9D0DA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 15:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCfcI-0004lw-9i; Tue, 14 Apr 2026 11:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1wCfcB-0004li-Mc
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 11:23:48 -0400
Received: from mail-northeuropeazon11010032.outbound.protection.outlook.com
 ([52.101.84.32] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1wCfc2-0006wM-HT
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 11:23:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CgiltKKLpcOwV15bMxIDOCNAz7xCw33Lt1OIR0RFYhifDGNsCsW/xMTmLLCAsk1bYmYfH6fymRmQHa8L1wQw/XNpsuJmk/jdycQkxqgG+VL6ekWVFCqjD20D/UDH/tICOSlaICCMBXm2e8FVK3hMsOp4SYaC3PsavWTEfG+u7+jBvb6Od77vw4KM9HDfiVPhHoWbxeQ5AJbWs+R9dY9Mu5juHmgSxhzJOS7cxOSSIOBCMxUzhO/SkCd+u0vHF4lG1exlFgGs89oWi1eB4lBtJoHokJj48tmo3SILZuiFuAqh9P7b019gkyYuZKbuUfnUg717DHJ+8ir4Z3u+qj96eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJ4o3pzrRYHn3UQJlIiyWGfQo+HT6/5ZYTpjTyt0Q5o=;
 b=qpHT9i6O38OG9p1qM31TY31ekTQl92E+y3LCdiS++4nekBPfFxQ8HDVYbUdRPfb46kBFGiTLA0S7SldE3XCyGz/wx536ud2KFZGOM2X8cLijIOufpPxax0qPwg2dO2Zh4dlqDJbcJeUBuu/yjlnhV5Dz0Uni8tRn7W3tOh+W6BtHFOMhYZUojbcSuAhtMmcpaO9GJ8lMmW0zsslyt4NDgN6xcHozm7kWV5C0ZePTreOqHuoBIKh+Eip92GCvJx//wz8U3ksWpl01q3P6RHd5zueBEPohzZGbQbGeNAoXyYo2y12xvY8z0bi4uGxya7O0siznaH0z9mN46YYuuxkx+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJ4o3pzrRYHn3UQJlIiyWGfQo+HT6/5ZYTpjTyt0Q5o=;
 b=FDlwzykwWiB7mC/e3vTMMUjyQ3LNf+kj6fdSAhrITyvjmcOJ/+9fTQ2pZEE+WJ36EttyzbT28VuIgFn9HTjy2kDazi0ygusILANwLHHfWWoJs0Y0DMir0TrCbJjUf2d4ZtzD0JvEODgpFNBZt9UWMHruAXORaPHRd/8SDWeyTYcTwydmW0L2S4vjcAphDdjPuKR36jGA0qvYr9y7a0mn2Rl6FZYhD3RGap78z/3sxMmKWiFab+g3FlT5AY9yiP7TGeGTedearoI01iJ6B5Th04T8qiaDjdruuRZ/pwUn2upiGJRmTJAT4qrYali6lNccNLefHHYlKKsA7nwnsyo6dA==
Received: from AM0PR04MB4370.eurprd04.prod.outlook.com (2603:10a6:208:6e::32)
 by AS8PR04MB8689.eurprd04.prod.outlook.com (2603:10a6:20b:428::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 15:18:31 +0000
Received: from AM0PR04MB4370.eurprd04.prod.outlook.com
 ([fe80::fe3b:fb2c:9dfc:9b]) by AM0PR04MB4370.eurprd04.prod.outlook.com
 ([fe80::fe3b:fb2c:9dfc:9b%6]) with mapi id 15.20.9745.035; Tue, 14 Apr 2026
 15:18:31 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: Bernhard Beschow <shentey@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
Subject: RE: [EXT] Re: [PATCHv5 00/15] Adding comprehensive support for
 i.MX8MM EVK board
Thread-Topic: [EXT] Re: [PATCHv5 00/15] Adding comprehensive support for
 i.MX8MM EVK board
Thread-Index: AQHcy9DECnqlUULt7Eqeq4Yd2OeY07XehHqAgAAnPhA=
Date: Tue, 14 Apr 2026 15:18:31 +0000
Message-ID: <AM0PR04MB4370EB0B894B793A65E4E76C87252@AM0PR04MB4370.eurprd04.prod.outlook.com>
References: <20260414053715.1378021-1-gaurav.sharma_7@nxp.com>
 <D3770294-A42E-4D24-8BF6-1E2B554DCF04@gmail.com>
In-Reply-To: <D3770294-A42E-4D24-8BF6-1E2B554DCF04@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4370:EE_|AS8PR04MB8689:EE_
x-ms-office365-filtering-correlation-id: adafcdfb-b3ee-4fd8-da98-08de9a3916c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|19092799006|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info: JlJPEOz9BAckbDGTM+jsTx1HX4nRb9Qfk1rhPmVjKsRy0x7VLoD1eSkL17dUKJ+J3Y1iXX0Y4v8TQXpH6w4qIy0om7Iz2x1NXyLZ3fm7TIUJ9XqZq4TclqriPoHCmSdjdxKhKo0uHE5R1HOAtwB2LVkXqNlfKHsMxPg09YtxgJtucpmhFGTPx+vnUHHLe7s9r+SpG6XgjX36FEg0dZKxV3E+AFCCqQBbpEdGTgx2RHNaxdWQpzXKbO8bhZrKeByUSdIc/lAxID/0c14v2I8feEYoawrQUYjFXVICjMHyJFaHdGvOg5qOMywbUggKYpXunAiBybh694eMs1vkedBcZjOou08OdS45hQpcXll6Og2socqp8bG98036acQFYH5YWnIW03RxVPq6pRXa+6W7THgl/nj6+F4+YgQ+YtQpu2DTzuUww97UKSt2xYJO7iIYxyMyfhH148sD4VUByrsBXQif2ZLRqybl9CVz/cYhCkCbY5Q5S3TEgJh1YzaapfbVD3r/9ZVWoou7oTVvSCSfZ2vzLovSd5p18EfOANhVBqI0aju6x+lXYKckvvFkEA34f+LoTHnyBtdRkhMUyXWX0MwTik9jtJMgGDY3dn4W4gmuXGPfuQ96YuAMm94MppRXY66qQiZwIJY5wyoVSwUToWRIeBi1s9wtrc9R/SMjV0rEiG3/EW1eALqVvRWsGuZ+QuKQTSS7jOeydg7srLsO61rUIaFrfASa/E5Cd4+mOlEibX8dw1XWcErrPc6zGxGuK6BYvGy9283rfNRI644KknaJtwFuXYiivObkcVqpST4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4370.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(18002099003)(56012099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXVMMG4xL1lJZElQcTZWZG1JMlp0UDFnaXhrMXN5U3MyS05lQWNPWkR4eFBt?=
 =?utf-8?B?dHNyYWRabWdwano1YXJ1SUVTRDhLaE8wVVdyd21LWndTcHB1U0NhTVdOUmls?=
 =?utf-8?B?NVlNQUdtNHZiN3NhQTk4SlQxYjY3eTQ0VmJ5WDUxWFVDUlp3WlNrSEFDM2kr?=
 =?utf-8?B?M2F3RVNrNllldW1MMnMxVzZiaStRY2p5ajM1V2tOdE9LZkVRbW9tUTJVcFhP?=
 =?utf-8?B?dFRPb0lvQU5pWHVNMXdKRGJZd3N0QmdTZnJ5aUgzZEkxOUF1d2d0c1JNbWYy?=
 =?utf-8?B?d2cxZGVkZDZtTmdjU2UxTGtaUU5WYjlBdkU0bis2TXQ4VmpCTlVFdlQwY01J?=
 =?utf-8?B?dXNZb0QvVlZRbzRZMXVKUEV3ZDBJR0hyaUJ2QWFPMGIrcEloOFFsV3cyc3ZJ?=
 =?utf-8?B?ZXliN2tiYmZEVkdYUFZOUVpWQ0dMcDhvYVl2V2g4UWFtQlVDQWdpV0RYOGIr?=
 =?utf-8?B?MWVlQk03M0RTQUNpbkhCWExTREVZQUFmY0tBYytDRUNvUDhDQ04xdXMrcnVp?=
 =?utf-8?B?ZkVmTDRwaXhYRXJZR0dOSmpiS29mU3ROcEY2OEVVenBPNng5dS9DWHhVUi8r?=
 =?utf-8?B?YXZYVEhPb0l4LzVkd0xSRmhYdnNMTjJFckpmajlqK0cxMTVGSzZGVWVoSzYw?=
 =?utf-8?B?b0huL3ZlcitJSDJ6dk9YMitQU2hrVEk1MnpsbGl0MFpwZU9nTEVCWE92SGVi?=
 =?utf-8?B?Zll3bjVmbUFTYzMweEVXVU14OC8vVTc0WEZSWVFDeThLTjFMRG1zeTFOYnJG?=
 =?utf-8?B?bXkxNjZxU0poQjhxMjk2K2xSelR1WXdGV2d1YVdLNFRTdTZuYTlGdWp6b2gx?=
 =?utf-8?B?aUUyajA3cjByenFCanFGK0dZN0ozam00R1BPWjRTVXIzRzhBdThNSE4wZXo3?=
 =?utf-8?B?emw3VjdMdVRLVXFnVC9yNUJNTCt0NXh3dXQ0WFYwZnFlTWp1ajRaV2V4T0pY?=
 =?utf-8?B?RHR2YzIvbEsxaXdWMzZ0cXh4M0dVb3JwcmhJUVdRRERwcDRoK0ZoZ1MydWlv?=
 =?utf-8?B?NG5DNEo2TjVZbkI4OWNRWVc4Q2czWkxLTDFZQXZnLzFrdGdvQTdWR25aejRM?=
 =?utf-8?B?UWtIYVZpdjBjaWFsdWdyWkY1UU4zTngybVVvTTFBc2kxa1g4SXh1UFd5SnF5?=
 =?utf-8?B?R1FxTEQxQzNvRW5PaGhaMUxwamczUjl5ZjFOWDhYSFJDVUppb3IrdlhBc3N2?=
 =?utf-8?B?TWRaZC9DMzJDeWlnbTRyNmJhOFc0UUVzVGM2YXNzblhEcjdsNlZBV2QvanQv?=
 =?utf-8?B?WXFFbExTYktESGxzVFBWM05xaWpYR1VmcG1KU1hobVJTRUJDRHlsd0pDT1Fh?=
 =?utf-8?B?cy9kM0xjR2tMWHloeGxPUVEvLzRiRFo5amM3V3hSMjdoRDRHd1YzK2pxOXRQ?=
 =?utf-8?B?VFcxTk9zeG9RczlZME1NOUhZRmxHa3dSR00zVVNuUm1WSGo0SlZsMlQ1dko0?=
 =?utf-8?B?cXIvVk1TMVQzcmV2STA2TjBYSVNwRmlXbWZwNEUxdGJGT2QwcnhBY2d1WUM3?=
 =?utf-8?B?MWl3VWlWODZyUHNEYkhXS3ZIWlBsUDF4NDBqMUFIWEhKcXpQUTBhUURKeTdy?=
 =?utf-8?B?T0Nvdi8wcTBSYWdDcy8zbFdUS3JYTFZoMnhIcEkzdUFJaXRMTkJwdDBBTDFR?=
 =?utf-8?B?bFhyR2xaQ21VSkZ3T1gwTmhzVmxsN3ZCZXBwZ1Z6NFNTYTgyanRFd0ZpdTVQ?=
 =?utf-8?B?VkdQTHJoYjdsQmRIcHJ4azV0WnhKRk0wRnFLU3grazVxN0l5b2UxeHN2UjlN?=
 =?utf-8?B?YUcwVS94Z2NseVBnZlhHYlVzWHdMVmt6ckhBc2dIbUovbU92NlhTaFdiZS9p?=
 =?utf-8?B?TWk0Q1huUGlORnVQTS80djJSUDk4OW1Pbnk3N21FNjVOQVYwMmlzeE1YcTRI?=
 =?utf-8?B?RjJjRGt4OFh3cFZKalYwblBvUk03Q3Q5RGxxZE9IZVdTT3ZPUWZYWDNNaWQ3?=
 =?utf-8?B?ZzVVWVZZdkhrZDhJdkRGemYrNURjYTRSOUc2N1YyKy9ZWDFSdmhYajUwQXZn?=
 =?utf-8?B?VlFwaVIrclJIWW02bjVZcDdOM2o5M1VsVlJkeUF5eWpmZS9rR09rWEJXL0lp?=
 =?utf-8?B?WEU2cFdhOFBoRCtjbkMydkJNbE94WkdEMmh2RWFvZlVBR0Z6Q3ptS0JFY01E?=
 =?utf-8?B?blVmSitiUkRGaEVFa1lOMnVIT1QzUjJDeW9qVEIzWWZMRVVmWUxvaFVEQmpr?=
 =?utf-8?B?Qk42SERXNlNQL2xxSktRSDVZMFFPSGw3aE9idnd3bnFmbEFOR0hBbkdaU0Yx?=
 =?utf-8?B?ci9kT3h5bnVyN1ZsalFIcDFJSkIvK0Vla0todmtVMGh6QmY5Rm5GZ1lSTkNE?=
 =?utf-8?B?MEFSM3pVYW9kZnNvdkg1bkdSbkw1ckt5eFlDN1F2b2lGL1BTVTNxZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4370.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adafcdfb-b3ee-4fd8-da98-08de9a3916c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 15:18:31.8610 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t1zEIB1t5ttKLNy6Pu3GkuIiLU62xI60vEMJRYcGDHHpV/SbAxTMHtFtQXgxLzNCAUno6FJZ7FHw9C1vRf/A7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8689
Received-SPF: pass client-ip=52.101.84.32;
 envelope-from=gaurav.sharma_7@nxp.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmVybmhhcmQgQmVzY2hv
dyA8c2hlbnRleUBnbWFpbC5jb20+DQo+IFNlbnQ6IDE0IEFwcmlsIDIwMjYgMTg6MjYNCj4gVG86
IEdhdXJhdiBTaGFybWEgPGdhdXJhdi5zaGFybWFfN0BueHAuY29tPjsgcWVtdS1kZXZlbEBub25n
bnUub3JnDQo+IENjOiBwYm9uemluaUByZWRoYXQuY29tOyBwZXRlci5tYXlkZWxsQGxpbmFyby5v
cmcNCj4gU3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSHY1IDAwLzE1XSBBZGRpbmcgY29tcHJlaGVu
c2l2ZSBzdXBwb3J0IGZvcg0KPiBpLk1YOE1NIEVWSyBib2FyZA0KPiANCj4gQ2F1dGlvbjogVGhp
cyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIHRha2UgY2FyZSB3aGVuIGNsaWNraW5nIGxp
bmtzIG9yDQo+IG9wZW5pbmcgYXR0YWNobWVudHMuIFdoZW4gaW4gZG91YnQsIHJlcG9ydCB0aGUg
bWVzc2FnZSB1c2luZyB0aGUgJ1JlcG9ydA0KPiB0aGlzIGVtYWlsJyBidXR0b24NCj4gDQo+IA0K
PiBBbSAxNC4gQXByaWwgMjAyNiAwNTozNzowMCBVVEMgc2NocmllYiBHYXVyYXYgU2hhcm1hDQo+
IDxnYXVyYXYuc2hhcm1hXzdAbnhwLmNvbT46DQo+ID5DaGFuZ2VzIGluIHY1Og0KPiA+LSBGaXhl
ZCBTb0Mgb2JqZWN0IHJlZmVyZW5jZSBjb3VudGluZyBieSB1c2luZyBvYmplY3RfbmV3X3dpdGhf
cHJvcHMoKQ0KPiA+ICBpbnN0ZWFkIG9mIG9iamVjdF9uZXcoKSArIG9iamVjdF9wcm9wZXJ0eV9h
ZGRfY2hpbGQoKQ0KPiA+LSBNZXJnZWQgaW14OG1tLWV2ay5yc3QgZG9jdW1lbnRhdGlvbiBpbnRv
IGlteDhtcC1ldmsucnN0IHRvIGF2b2lkDQo+ID4gIGR1cGxpY2F0aW9uIGFuZCB1cGRhdGVkIHRo
ZSB0aXRsZSBhY2NvcmRpbmdseQ0KPiA+LSBBZGRlZCBvbi1jaGlwIFJBTSAoT0NSQU0pIHN1cHBv
cnQgdG8gbWF0Y2ggaU1YOE1QIGRldg0KPiANCj4gQ2hlY2twYXRjaCByYWlzZXMgc2V2ZXJhbCBl
cnJvcnMgKHlvdSBtYXkgaWdub3JlIGl0cyB3YXJuaW5ncykuIFJlcHJvZHVjZSBpbg0KPiB0aGUg
UUVNVSByb290IHNyYyBkaXIgd2l0aCB0aGUgZm9sbG93aW5nIGNvbW1hbmQ6DQo+IA0KPiAgIC4v
c2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tYnJhbmNoIG9yaWdpbi9tYXN0ZXIuLg0KPiANCj4gQmVz
dCByZWdhcmRzLA0KPiBCZXJuaGFyZA0KPiANCg0KR290IGl0LiB3aWxsIHNlbmQgYW4gdXBkYXRl
ZCBzZXJpZXMgYWZ0ZXIgZml4aW5nIHRoZXNlLg0KDQo+ID4NCj4gPkNoYW5nZXMgaW4gdjQ6DQo+
ID4tIFVwZGF0ZSBNYWludGFpbmVycyBmaWxlDQo+ID4tIFJlLXVzZWQgaU1YOE1QIENDTSBhbmQg
QW5hbG9nIElQIGZvciBpTVg4TU0gYnkgaW50cm9kdWNpbmcgYSB2YXJpYW50DQo+ID4gIHNwZWNp
ZmljIHByb3BlcnR5DQo+ID4tIFNwbGl0IHVwIHRoZSBwYXRjaCB0aGF0IGVuYWJsZWQgQ0NNIGFu
ZCBBbmFsb2cgaW4gdGhlIHByZXZpb3VzDQo+ID4gIHJldmlzaW9uLiBOb3cgd2UgaGF2ZSAzIHBh
dGNoZXMgdG8gZW5hYmxlIENDTSBhbmQgQW5hbG9nIGluIGlNWDhNTQ0KPiA+LSBVcGRhdGVkIGNv
cHlyaWdodHMNCj4gPi0gUmVtb3ZlZCAnfHwgS1ZNJyBmcm9tIGh3L2FybS9LY29uZmlnIHRvIHBy
ZXZlbnQgJ21ha2UgY2hlY2snIGZhaWx1cmVzDQo+ID4NCj4gPkNoYW5nZXMgaW4gdjM6DQo+ID4t
IE1pbm9yIGRvY3VtZW50YXRpb24gY2hhbmdlIC0gQWRkZWQgS1ZNIEFjY2VsZXJhdGlvbiBzZWN0
aW9uIGluDQo+ID5kb2NzL3N5c3RlbS9hcm0vaW14OG1tLWV2ay5yc3QNCj4gPg0KPiA+Q2hhbmdl
cyBpbiB2MjoNCj4gPi0gRml4ZWQgdGhlIERUQiBvZmZzZXQgaW4gZnVuY3Rpb25hbCB0ZXN0aW5n
IHNjcmlwdCB0ZXN0X2lteDhtbV9ldmsucHkNCj4gPiAgYW5kIHByZXNlcnZlZCBhbHBoYWJldGlj
YWwgb3JkZXIgb2YgbWFjaGluZSBuYW1lcyBpbg0KPiA+dGVzdHMvZnVuY3Rpb25hbC9hYXJjaDY0
L21lc29uLmJ1aWxkDQo+ID4tIEZpeGVkIGEgdHlwbyBhbmQgdXBkYXRlZCB0aGUgZG9jdW1lbnRh
dGlvbg0KPiA+LSBNb2RpZmllZCBzdHJ1Y3R1cmVzIHR5cGUgdG8gc3RhdGljIGNvbnN0IGluIGZz
bC1pbXg4bW0uYyB3aGVyZXZlcg0KPiA+ICBhcHBsaWNhYmxlLg0KPiA+LSBBZGRlZCBDU0kgYW5k
IERTSSBub2RlcyB0byB0aGUgbm9kZXNfdG9fcmVtb3ZlIGxpc3QgaW4gaW14OG1tLWV2ay5jLg0K
PiA+VGhpcw0KPiA+ICBpcyBuZWVkZWQgYmVjYXVzZSB0aGUgZGVmYXVsdCBEVEIgaW4gdGhlIGlN
WCBMRiBCU1AgaW1hZ2VzIGhhdmUgQ1NJDQo+ID4gIGFuZCBEU0kgZW5hYmxlZC4gRGV2ZWxvcGVy
cy9Ib2JieWlzdHMgdXNpbmcgdGhlc2UgQlNQIGltYWdlcyB3aWxsDQo+ID4gIG9ic2VydmUgQ1NJ
IGFuZCBEU0kgY3Jhc2ggbG9ncyBvbiB0aGUgY29uc29sZSBzaW5jZSB0aGVzZSBhcmUNCj4gdW5p
bXBsZW1lbnRlZC4NCj4gPiAgV2l0aCB0aGlzIGNoYW5nZSwgYm90aCBkZWJpYW4gYW5kIGlNWCBM
RiBpbWFnZXMgd2lsbCBib290IHVwIHdpdGhvdXQgYW55DQo+IGlzc3Vlcy4NCj4gPg0KPiA+Q2hh
bmdlcyBpbiB2MToNCj4gPg0KPiA+VGhpcyBwYXRjaCBzZXJpZXMgYWRkcyBzdXBwb3J0IGZvciB0
aGUgTlhQIGkuTVg4TU0gRVZLIChFdmFsdWF0aW9uIEtpdCkNCj4gPmJvYXJkIHRvIFFFTVUsIGVu
YWJsaW5nIGVtdWxhdGlvbiBvZiB0aGlzIEFSTSBDb3J0ZXgtQTUzIGJhc2VkDQo+ID5kZXZlbG9w
bWVudCBwbGF0Zm9ybS4NCj4gPg0KPiA+VGhlIHNlcmllcyBpbmNsdWRlczoNCj4gPg0KPiA+MS4g
Q29yZSBwZXJpcGhlcmFsIHN1cHBvcnQgKENDTSBjbG9jayBjb250cm9sbGVyLCBBbmFsb2cgbW9k
dWxlKSAyLg0KPiA+R1BUKEdlbmVyYWwgUHVycG9zZSBUaW1lcikgYW5kIFdEVChXYXRjaGRvZyBU
aW1lcikgRW11bGF0aW9uIHN1cHBvcnQNCj4gMy4NCj4gPkdQSU8sSTJDLFNQSSxVU0RIQyBhbmQg
VVNCIEVtdWxhdGlvbiBzdXBwb3J0IDQuIFBDSWUgYW5kIEVORVQNCj4gPkNvbnRyb2xsZXIgRW11
bGF0aW9uIHN1cHBvcnQgNS4gRG9jdW1lbnRhdGlvbiBhbmQgZnVuY3Rpb25hbCB0ZXN0DQo+ID5p
bmNsdWRlZA0KPiA+DQo+ID5LZXkgZmVhdHVyZXMgcG9ydGVkOg0KPiA+LSBCYXNpYyBib290IHN1
cHBvcnQgd2l0aCBMaW51eA0KPiA+LSBVQVJUIGNvbnNvbGUgZm9yIHNlcmlhbCBjb21tdW5pY2F0
aW9uDQo+ID4tIEludGVycnVwdCBoYW5kbGluZw0KPiA+LSBDbG9jayBhbmQgcG93ZXIgbWFuYWdl
bWVudCBpbmZyYXN0cnVjdHVyZQ0KPiA+DQo+ID5UZXN0aW5nOg0KPiA+LSBMaW51eCBrZXJuZWwg
Ym9vdHMgdG8gY29uc29sZQ0KPiA+DQo+ID5SZXZpZXdlZC1ieTogQmVybmhhcmQgQmVzY2hvdyA8
c2hlbnRleUBnbWFpbC5jb20+DQo+ID5TaWduZWQtb2ZmLWJ5OiBHYXVyYXYgU2hhcm1hIDxnYXVy
YXYuc2hhcm1hXzdAbnhwLmNvbT4NCj4gPg0KPiA+DQo+ID5HYXVyYXYgU2hhcm1hICgxNSk6DQo+
ID4gIGh3L2FybTogQWRkIHRoZSBpLk1YIDhNTSBFVksoRXZhbHVhdGlvbiBLaXQpIGJvYXJkDQo+
ID4gIGh3L21pc2MvaW14OG1wX2FuYWxvZzogQWRkIHByb3BlcnR5IHRvIGFuYWxvZyBkZXZpY2UN
Cj4gPiAgaHcvYXJtL2ZzbC1pbXg4bW06IEFkZCBBbmFsb2cgZGV2aWNlIElQIHRvIGlNWDhNTSBT
T0MNCj4gPiAgaHcvYXJtL2ZzbC1pbXg4bW06IEFkZCBDbG9jayBDb250cm9sIE1vZHVsZSBJUCB0
byBpTVg4TU0NCj4gPiAgaHcvYXJtL2ZzbC1pbXg4bW06IEltcGxlbWVudGVkIHN1cHBvcnQgZm9y
IFNOVlMNCj4gPiAgaHcvYXJtL2ZzbC1pbXg4bW06IEFkZGluZyBzdXBwb3J0IGZvciBVU0RIQyBz
dG9yYWdlIGNvbnRyb2xsZXJzDQo+ID4gIGh3L2FybS9mc2wtaW14OG1tOiBBZGQgUENJZSBzdXBw
b3J0DQo+ID4gIGh3L2FybS9mc2wtaW14OG1tOiBBZGQgR1BJTyBjb250cm9sbGVycw0KPiA+ICBo
dy9hcm0vZnNsLWlteDhtbTogQWRkaW5nIHN1cHBvcnQgZm9yIEkyQyBlbXVsYXRpb24NCj4gPiAg
aHcvYXJtL2ZzbC1pbXg4bW06IEFkZGluZyBzdXBwb3J0IGZvciBTUEkgY29udHJvbGxlcg0KPiA+
ICBody9hcm0vZnNsLWlteDhtbTogQWRkaW5nIHN1cHBvcnQgZm9yIFdhdGNoZG9nIFRpbWVycw0K
PiA+ICBody9hcm0vZnNsLWlteDhtbTogQWRkaW5nIHN1cHBvcnQgZm9yIEdlbmVyYWwgUHVycG9z
ZSBUaW1lcnMNCj4gPiAgaHcvYXJtL2ZzbC1pbXg4bW06IEFkZGluZyBzdXBwb3J0IGZvciBFTkVU
IGV0aGVybmV0IGNvbnRyb2xsZXINCj4gPiAgaHcvYXJtL2ZzbC1pbXg4bW06IEFkZGluZyBzdXBw
b3J0IGZvciBVU0IgY29udHJvbGxlcg0KPiA+ICBody9hcm0vZnNsLWlteDhtbTogQWRkaW5nIGZ1
bmN0aW9uYWwgdGVzdGluZyBvZiBpTVg4TU0gZW11bGF0aW9uDQo+ID4NCj4gPiBNQUlOVEFJTkVS
UyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEwICsNCj4gPiBkb2NzL3N5c3Rl
bS9hcm0vaW14OG1wLWV2ay5yc3QgICAgICAgICAgICAgIHwgIDMzICstDQo+ID4gZG9jcy9zeXN0
ZW0vdGFyZ2V0LWFybS5yc3QgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ID4gaHcvYXJtL0tj
b25maWcgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyNCArDQo+ID4gaHcvYXJtL2Zz
bC1pbXg4bW0uYyAgICAgICAgICAgICAgICAgICAgICAgICB8IDcwNCArKysrKysrKysrKysrKysr
KysrKw0KPiA+IGh3L2FybS9pbXg4bW0tZXZrLmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAx
MzAgKysrKw0KPiA+IGh3L2FybS9tZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAgIDIgKw0KPiA+IGh3L21pc2MvaW14OG1wX2FuYWxvZy5jICAgICAgICAgICAgICAgICAgICAg
fCAgMTIgKy0NCj4gPiBody90aW1lci9pbXhfZ3B0LmMgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgIDI2ICsNCj4gPiBpbmNsdWRlL2h3L2FybS9mc2wtaW14OG1tLmggICAgICAgICAgICAgICAg
IHwgMjQyICsrKysrKysNCj4gPiBpbmNsdWRlL2h3L21pc2MvaW14OG1wX2FuYWxvZy5oICAgICAg
ICAgICAgIHwgICAzICsNCj4gPiBpbmNsdWRlL2h3L3RpbWVyL2lteF9ncHQuaCAgICAgICAgICAg
ICAgICAgIHwgICAyICsNCj4gPiB0ZXN0cy9mdW5jdGlvbmFsL2FhcmNoNjQvbWVzb24uYnVpbGQg
ICAgICAgIHwgICAyICsNCj4gPiB0ZXN0cy9mdW5jdGlvbmFsL2FhcmNoNjQvdGVzdF9pbXg4bW1f
ZXZrLnB5IHwgIDY3ICsrDQo+ID4gMTQgZmlsZXMgY2hhbmdlZCwgMTI1MSBpbnNlcnRpb25zKCsp
LCA3IGRlbGV0aW9ucygtKSBjcmVhdGUgbW9kZQ0KPiA+IDEwMDY0NCBody9hcm0vZnNsLWlteDht
bS5jIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9hcm0vaW14OG1tLQ0KPiBldmsuYw0KPiA+IGNyZWF0
ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2h3L2FybS9mc2wtaW14OG1tLmggY3JlYXRlIG1vZGUgMTAw
NzU1DQo+ID4gdGVzdHMvZnVuY3Rpb25hbC9hYXJjaDY0L3Rlc3RfaW14OG1tX2V2ay5weQ0KPiA+
DQo=

