Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC7AFF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 02:20:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJiu7-0004pF-PI; Sun, 03 May 2026 22:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wJiu5-0004ol-PK; Sun, 03 May 2026 22:19:25 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wJiu3-0005hY-C3; Sun, 03 May 2026 22:19:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FAmYyKOu6fHwoQEE8UF+bmC2vzd1bInHCsxQHmp//zAsAc7nGdGDJWPuzokzfYFylgryA1vLW5VChehbHK5c8sUZ+gm+855qV2POdreXv3DlVi6Fyz6ZZf95HojwrxWNbB1VzcNmgpzlGsu9LbJQ/foSB8kAWx2C7JJQZ9TXjs8yRi5SwVOoOzWuzrftpqGMR61Zpnz7gRJ8kV3qs59k7bHJZDmqKoGRkUz57+kGIkmfJiey0dGzLSDPUcbnZl9HyTlJSFAJzCqeLUOaNLSyvUIyaTcZLt7QspbcqkIlR2HTvAF7h5P7ahuUU58b0HGvQqLZHaP3H/RT5nzmVaYgSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=297hBnd4wSmLIUAc4o36yQtmfHrUEiojEe5a1AqFI/U=;
 b=jMsw0b8Y7ode75nKOM/XcuLLN2JsecWKh/X+ilfUqw1ZX6WfwVqVHQIr0bXVzzHKDowcDmRSp5uxTszEU7bTlNBGR30Hg8w2u9/Yw7fnOSebA4etAUssIQIqBrBnBwjoUwELnDy6CnfeYESwtWaRbMOvB4tBkHwCvZLXaCBCNTA9aejaoqgI5o/TO+7Ltl/bILpdJ8ZyYAqmWhVYFxSv82DAbNinKLT4Aoa8MULqR0OiTpBvmw7ZjHxXsd9XhJZyxzDOk8KDE2U4Vrw3SnkvB7/mLohwRB/iwulP76bUgGYWZo59iVksvJNF9yR9GJDu26qB/Vb01WYn5LoKqnATMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=297hBnd4wSmLIUAc4o36yQtmfHrUEiojEe5a1AqFI/U=;
 b=ElJwkbL4S6DaEY/ZBgq15s5FSA+zeFaipZe5vSRJmGUzeDdhwHdOuRAGXrTROrcdIDkXaqI94hfoC4pbZpdBQ52nXkysuEW2956ktuhCEmhZCHoCKvJvX/5NnkUZIMwknrwmaylEtKovWLmsQsxuTYKzrbdO8ByrW+RA5Su8NY279Q2I3Y0UUjn8VBnko0CHF1kGPiooNN8eLcvCz1UpWKtB0w1qeeLXxJbmNBOV9qU8YSHKxwwRcd0DjTx8mbN5utiPXhlUWRkANrzlpU96UamsuMrHtihfREoHu/vJzaLQNJ5vFIRtUOLp4krRt4/iJ0UmFcSFj36yTOviaWRKnQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB6156.apcprd06.prod.outlook.com (2603:1096:101:de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 02:19:15 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 02:19:15 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, "peterx@redhat.com"
 <peterx@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Nicholas
 Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Ilya
 Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:sPAPR pseries" <qemu-ppc@nongnu.org>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "farosas@suse.de" <farosas@suse.de>,
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@redhat.com>
Subject: RE: [PATCH v5 16/18] hw/arm/aspeed_ast27x0: Set EHCI
 ctrldssegment-default
Thread-Topic: [PATCH v5 16/18] hw/arm/aspeed_ast27x0: Set EHCI
 ctrldssegment-default
Thread-Index: AQHc08Ee1FwzCW5lQ0ucM0evTZPrerX8zJQAgABkipA=
Date: Mon, 4 May 2026 02:19:15 +0000
Message-ID: <TYPPR06MB82065384D95E8E1BC0DFD3A1FC312@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260424080508.53992-1-jamin_lin@aspeedtech.com>
 <20260424080508.53992-17-jamin_lin@aspeedtech.com>
 <bd53e2ce-ba25-4fb2-8b30-2ffaeed17876@kaod.org>
In-Reply-To: <bd53e2ce-ba25-4fb2-8b30-2ffaeed17876@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB6156:EE_
x-ms-office365-filtering-correlation-id: d39b00fd-a280-4c40-e2eb-08dea98389d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|18002099003|22082099003|56012099003|921020|38070700021;
x-microsoft-antispam-message-info: YAhe47dlTcXcCObtcjFPmIaqnrDr802gZti0HJjk5QXazzkHswAMCKTkZuxjEQpmc3P30L8IQ4AFtsczl1HhN5KLNylR9ugvaYCiQSTCdr2YEQ4fwsVbb5fjeEmbCyoehee/Dt984xqnU7+Wfsyf49MVx6NIp04LAPMB6ju+d8+CkLJigU3ZyE6rzK4FelCUwqciLmQkTTGyk+e3MZhAwNmX824xkc0P4f+t/lPAB2I/fC30AahiluXeBh+Y4UWtE94ktBGWoCm2QYJOjPnF3CJ/oF3+stpAjveoJgWL8IjPyAYfrwlvovtEY+fkD2n0ZUc94WI1UAnXiVmwPHutahJXGaVasLpgj3wQeEr6ZpgCO50FBCObjDLVeYqyRULthhyNMo9T9NgMuh2VQduTi9BVaS1dalj3xZXpdjO/7ri0knWSxqkBmYkCEDcGFf1eIuuJaIqJ7rNOlfFMkUCK3QSswexAkXIrXZkLI1Ex7hww57a9KmlfuMEgeJXW71JIRuyu0J1oWkdLSb/8LJeqM89mXt8PJZde32yUfZZjhAvDO48pVFONzU4/On+DnTFLqkL3G5FIBfMRQCPebm0armSKvk8Tupf71szDJeZa6mrKnkgV532o+n1Tr4AR4g37CgWBchQR4WdnhuHwboqTeK8sAaScAjHJb5tNFnPuPQqjDDOpKykHIcKrg64JDJfp5YRm5Bw/O4zzxlqATV2c/OG7PtoChZm+G0ijSniTE5yH9kdqy/+34aM4wRG1vRr8JlvOs9IzwmQBHVYAzEhNyQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(22082099003)(56012099003)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1ZmcHdjU2xQNW5NQXczSEtqY1J1MERPTGlLVGZhblNkaXVkQnNvS2haZTM5?=
 =?utf-8?B?MzlXQmw5anh4UWgwVE0zS0NhZ240dTJNdCtTM2hIMnhvZDNCYVVYUEV3T2J6?=
 =?utf-8?B?NzRmbEluMzlZTXozeGZib2xQRm16a0FUblViR2pTQjhGYVliSy9TWkY3dTNx?=
 =?utf-8?B?L0N5MTM2bmxoK00zYjZ4c3pSU1owcGJNRkw1dCtYbTgyUTNHZUdaSkJtR0c2?=
 =?utf-8?B?RFZ6NnlQNXQ1MXorQ3Y2dEpjMFJyWWdDbWcxbjAweTBFVjJ2S0IwTytvaEEv?=
 =?utf-8?B?bHgrazdmcm1NNWxrS3dvMThCa2J0Q0RzcWJmMWZSbGl4RmxXYTVQM3Y2WW52?=
 =?utf-8?B?bHZ5SlVPMVc0UWFRVW42MGlWck95Mm04YUtVdGtINXZlNy9NY0xMTXhPNlJN?=
 =?utf-8?B?aTkrWnZIei83cjZENkZ2ay9vOTM0Rm5icWJaS1hqMktUV1FzWUM0ZjNhSFBn?=
 =?utf-8?B?SCs0RHNDY3BaM1k1WVZKOC96eERocW9FRU5ha2pNdXNTSUxrTVhjcTI0N1lj?=
 =?utf-8?B?NThWSnp1S1lDNmUrMnpQRVJyK0prSkpFRll5RFBFZ1h3Rm01QkMyOWFENTNJ?=
 =?utf-8?B?SEFLNHM1Wm1ud0RJbWpEcU5zYWdDazA2UGJqYnFUenVkc2kyTzR6b29Yc25j?=
 =?utf-8?B?YVZXNys3RWQvc0tWaXpvdXJPOXAyN3VPY0FmaTM4VEdDdFhkb0p0WlRJKy9s?=
 =?utf-8?B?RGUwU1NxNTN1bjZuWjdZbE44eXBwUFlaOTlOYVkzR1JqcUYwYWR1dFBCc0V6?=
 =?utf-8?B?QTVmU1gxeHNUQW85UWc3OWNhL1dhSVRBb25jMTYveXNWM0JwT1MxWDZZQWZ1?=
 =?utf-8?B?R1lpSVErajViWlBLWHc1dytyaWpPeXRScjVpU2JuWFU0ODVITUFIcVZqTVY1?=
 =?utf-8?B?UjUwVUZOemJtSWdoQWRJVkJ5bm9hbFZyWUNjaGhkSXZLVTFMZ2JjL1BkSG9T?=
 =?utf-8?B?SlZwT094TUh2eENpU29QOFBZMWdRNEI0MXJsb3FReFV4ZlFmZDk4UWxCdmdN?=
 =?utf-8?B?cHNaTWZNcm1YMUVQOVdzVlhnQ2JKL2oycTB1dFAzYWRSUGZBeXhnUzh6UHEy?=
 =?utf-8?B?M0d4WkhYMzhQbXdBc3k2TXhyaE9ieUJERFNHamRMMXBTRkdPUWg2Um1sa2NG?=
 =?utf-8?B?SDJ4RHN2ZjFuR2dpTXY0Y0JmQUhUNTc5aHN2YU5EZDRhN1B3aHZmbkV5SjFi?=
 =?utf-8?B?VXVQNmw2dW9wRmJGYWJMS1dkaXlBYjgraklvZ1FGWkNOa0RqY1Z3ckhSQjFy?=
 =?utf-8?B?aFd5b201K0ZxMzRxZUYrclRYdmN5ZmNrY1dtR2wwOEcvMk4zM1hGOU5zRXBy?=
 =?utf-8?B?Vmd0YnY2VzBEVzI2dVF3SmtnUkRmTWZkNWhjK0FrbmNKSXljODh6c2VmSFV3?=
 =?utf-8?B?d0dsTkZhRTludEp3cVBpazBqVHY0d0JHa1R2L0p5YkQxdENtTWRQZG5ZTzUr?=
 =?utf-8?B?YjVJZmgzODBGbDJIeC8yTUdhQ0htVzMvZzMzTi9hUjZ2RStDVHFNejAyQjgy?=
 =?utf-8?B?MlU0ZmhQc05oY2kzNEpNS1ZVZ2hSRFRjZE92SUl5MDFFZDV5Q3NSOUw0eFBO?=
 =?utf-8?B?OVdwbkFKcHVFQnkrNXlLQ1F2MWlJa0k0b0NIbTJtWUlUdnVzSGJUT0JRLzh3?=
 =?utf-8?B?Qlc2enV1SkpqdkVwRVIzQ0s1c3k4S2ZxNCtKMzRHQWtrS2tLNmIzYXdZb3ls?=
 =?utf-8?B?QmJzcGM5bVJOUnRZajcwSWViR0R5V0JtVDM1VGRlME15K1U3eGhFWXo0K1F5?=
 =?utf-8?B?ejhCa25OcWUrSjhvOFRqTzJTYmx5alVMOExja05GWFp5Wk15VWVGVG4wTXZB?=
 =?utf-8?B?alR2MHBFWW1LWEZ2R2RBTS9OK200eXFlZTc1NFdTY0FZQUFUUy9JalB6TWt2?=
 =?utf-8?B?MWR2QUxNWEF1eGhjQm9hM0ZOZTFVSlJWSnU1ODhhems0djNIaFZ4WjBYTmdy?=
 =?utf-8?B?anZGK1FUUDhVNWFPOTBtTjVib3pzTlkvOHVGLzZyelFFcVdMRDAwbUpMVExj?=
 =?utf-8?B?RlE1S0ZUQjVOQTV1Q0R2YVVidXRXeXNMYmF5TVNGZFh3WmYrQ3Exb0ZMVlpq?=
 =?utf-8?B?VE4xWUkrQ3psK2ZsOUR1YkFzY2trK0dhcllaNko5R2ZLbUlUU2dQcHhXa0Ex?=
 =?utf-8?B?VTl1dXBCUXBONnZXMDV6by91MXNocDVucWV1aWFCQUlUblpkdWZrRVhvLzZJ?=
 =?utf-8?B?ajVVV0FZeXpSTzFhcnpadGRhUTRZS1hXY2RNb1FUUXpudktTZGsyS28vUUNL?=
 =?utf-8?B?SWMzblBKa0xOQjJXR0RFN3I4b2QvWFdKSWlKZ3ZudUVUa2RoWmZhazNGdVR3?=
 =?utf-8?B?UTFKaFdDaC9xQStRTS9RVFVXYjhQemJuYy9DL3dzQVpUL0FpN0NvQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WD1p1SfgGuOR2jqPsavxg7nGxpbf5Xp01Dp+V6fuYPklANaLyasKcdLKqGV+vARLfMQ0jCrOUQe5wDKCfzm8kImBoBBkfPOPZ0wn2tSWUrFWMyoobUt42JLgHf7BMpOCvpHtZXIkZyNppZMs+mfppD2BsCnno6UHoTZeFoEjTHGAwF2AVfD3yBRquUxB9YFf9NmsSbPpSa8wV0dlmBh+KWmiZSXomFpQwxpEhHuEmwaEGQ0bA6YB0IlU6FAu7qNytCUbylTOyB6hUEzroxjWQ/2X8g9jQ/OjYi8RCe82pRJRpsFZ7omeztBKJvUf0m3lsexiEBzwghyREQYFP8djOQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d39b00fd-a280-4c40-e2eb-08dea98389d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 02:19:15.1097 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 17qt57NSaRPJjQhaGTsntGQE8dWbDXU5PCJ5iizv7GsC9VW73r05zkIiNfi5XSWuTw7kiNtDU7qH0TDKaznB+TWtkvERncIPu+1Jap+eFqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6156
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMTYvMThdIGh3L2FybS9hc3Bl
ZWRfYXN0Mjd4MDogU2V0IEVIQ0kNCj4gY3RybGRzc2VnbWVudC1kZWZhdWx0DQo+IA0KPiBPbiA0
LzI0LzI2IDEwOjA1LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gT24gQVNUMjcwMCBwbGF0Zm9ybXMs
IHN5c3RlbSBEUkFNIGlzIG1hcHBlZCBhYm92ZSA0R0Igd2l0aCBhIGJhc2UNCj4gPiBhZGRyZXNz
IGF0IDB4NDAwMDAwMDAwLg0KPiA+DQo+ID4gVGhlIExpbnV4IEVIQ0kgZHJpdmVyIHByb2dyYW1z
IHRoZSBzZWdtZW50IHJlZ2lzdGVyIHRvIHplcm8gd2hlbg0KPiA+IDY0LWJpdCBhZGRyZXNzaW5n
IGlzIHN1cHBvcnRlZC4gQXMgYSByZXN1bHQsIGRlc2NyaXB0b3IgYWRkcmVzc2VzDQo+ID4gZGVy
aXZlZCBmcm9tIHRoZSBFSENJIHJlZ2lzdGVycyBkbyBub3QgaW5jbHVkZSB0aGUgRFJBTSBiYXNl
IGFkZHJlc3MuDQo+ID4NCj4gPiBEZXNjcmlwdG9yIG1lbW9yeSBpcyBhbGxvY2F0ZWQgdGhyb3Vn
aCB0aGUgRE1BIEFQSSB3aXRoIGEgNjQtYml0IERNQQ0KPiA+IG1hc2ssIGFsbG93aW5nIGRlc2Ny
aXB0b3JzIHRvIHJlc2lkZSBpbiBEUkFNIGFib3ZlIDRHQi4gT24gQVNUMjcwMCwNCj4gPiBFSENJ
IHF1ZXVlIGhlYWRzIChRSCkgYW5kIHF1ZXVlIGVsZW1lbnQgdHJhbnNmZXIgZGVzY3JpcHRvcnMg
KHFURCkgYXJlDQo+ID4gdGhlcmVmb3JlIHBsYWNlZCBhdCBhZGRyZXNzZXMgc3RhcnRpbmcgZnJv
bSAweDQwMDAwMDAwMC4NCj4gPg0KPiA+IFNldCB0aGUgY3RybGRzc2VnbWVudC1kZWZhdWx0IHBy
b3BlcnR5IHRvIDB4NCBzbyB0aGUgdXBwZXINCj4gPiAzMiBiaXRzIG9mIGRlc2NyaXB0b3IgYWRk
cmVzc2VzIGFyZSBhZGp1c3RlZCBhY2NvcmRpbmdseS4gVGhpcyBhbGxvd3MNCj4gPiB0aGUgZW11
bGF0ZWQgRUhDSSBjb250cm9sbGVyIHRvIGNvbnN0cnVjdCBjb3JyZWN0IHN5c3RlbSBhZGRyZXNz
ZXMNCj4gPiB3aGVuIGFjY2Vzc2luZyBkZXNjcmlwdG9ycyBpbiBEUkFNIGFib3ZlIDRHQi4NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29t
Pg0KPiA+IFJldmlld2VkLWJ5OiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+
ID4gLS0tDQo+ID4gICBody9hcm0vYXNwZWVkX2FzdDI3eDAuYyB8IDIgKysNCj4gPiAgIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9hcm0v
YXNwZWVkX2FzdDI3eDAuYyBiL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC5jIGluZGV4DQo+ID4gODdk
Y2I4MmUxYi4uMGNiMzlkYzE5MSAxMDA2NDQNCj4gPiAtLS0gYS9ody9hcm0vYXNwZWVkX2FzdDI3
eDAuYw0KPiA+ICsrKyBiL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC5jDQo+ID4gQEAgLTg1Niw2ICs4
NTYsOCBAQCBzdGF0aWMgdm9pZCBhc3BlZWRfc29jX2FzdDI3MDBfcmVhbGl6ZShEZXZpY2VTdGF0
ZQ0KPiA+ICpkZXYsIEVycm9yICoqZXJycCkNCj4gPg0KPiA+ICAgICAgIC8qIEVIQ0kgKi8NCj4g
PiAgICAgICBmb3IgKGkgPSAwOyBpIDwgc2MtPmVoY2lzX251bTsgaSsrKSB7DQo+ID4gKyAgICAg
ICAgb2JqZWN0X3Byb3BlcnR5X3NldF9pbnQoT0JKRUNUKCZzLT5laGNpW2ldKSwNCj4gImN0cmxk
c3NlZ21lbnQtZGVmYXVsdCIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
MHg0LCAmZXJyb3JfYWJvcnQpOw0KPiANCj4gUGxlYXNlIHJlcGxhY2UgIjB4NCIgd2l0aCAic2Mt
Pm1lbW1hcFtBU1BFRURfREVWX1NEUkFNXSA+PiAzMiINCj4gDQpUaGFua3MgZm9yIHRoZSByZXZp
ZXcgYW5kIHN1Z2dlc3Rpb24uDQpXaWxsIGRvLg0KSmFtaW4NCj4gVGhhbmtzLA0KPiANCj4gQy4N
Cj4gDQo+IA0KPiANCj4gPiAgICAgICAgICAgaWYgKCFzeXNidXNfcmVhbGl6ZShTWVNfQlVTX0RF
VklDRSgmcy0+ZWhjaVtpXSksIGVycnApKSB7DQo+ID4gICAgICAgICAgICAgICByZXR1cm47DQo+
ID4gICAgICAgICAgIH0NCg0K

