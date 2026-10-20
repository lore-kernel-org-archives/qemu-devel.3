Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7DA606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 03:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=nuYLJ+vw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ0pr-0005ZA-E7; Mon, 19 Oct 2026 23:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xJ0pp-0005YR-3N; Mon, 19 Oct 2026 23:48:21 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xJ0pn-0003Uf-85; Mon, 19 Oct 2026 23:48:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nffod99Za4TljSH1uP90EGiBwX54dGlwMPDdShTAmp++hMRmMEgnTJhiHpSCdTnEOSf8EzS0voWv1B+h1oW+IUzjBqtl7EJQHAInUS/kPyBbH9QD95flIyQTn6vHId4gcGprJ7v3rc2tFiWRb7iLuX4atVvyc5mm7sC4DEQzxtsrk6hJ9Jb5QChtTOJdzmE4oULcjhSbt1v6xI3tP02c88PjsjD4O+kh6JqvGucWVNyk/mAl3UMs6I7KNIBZFJ8+KDvs1RhNLOAxBZMGjKRmyW8RlfoLK8ntudWplDgUuAhXXvLTkqdDcATNIj6VSMkThf5MxBSSXS/yLE6nZOCzng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQLO6MjcS1OU2V9UVlQVL0s7N6otLQcxINE7q4TpeI8=;
 b=Q29RlhI0uNPlVLREDTObYpLfsBXQHwhrD7+b+/PKeRtWkIgXfeZUWvLU0UnxsknNJE1e2QGcQzu8Yxc9Xm0Qwg/cgKU/+BjMxcBjNR5/5yroVfkoEn2S+j1gTedqIgOWae6dV6mt9S78Nj5BXeVN7BmiIUj4aRBQ4CBtCtzIW+lJ1wbrIJRwarxZbEgpAghcoOl0sN1u6K4dFAFkHi0FguWK6yKl5I4JGGqcVfOdYW2uuelRj1VP/9DsDT0MYBNKWdz5PHcjXvmnpV0FsYb9KGV6iLlS439JcRiUZOiL6zPnCLC/qiDLbourrdMQBWg0tb5RM0Wbwa+dpDByvULWhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQLO6MjcS1OU2V9UVlQVL0s7N6otLQcxINE7q4TpeI8=;
 b=nuYLJ+vwnej1jTfZrnI0kKSrGNjLwdC0JHLvVXFmR4VTMw33XU6RQpylp3fnLuW4mw3bgIt4cSQhwgWt+IlBSOKm9gUsEka2tIvIZMqeaeZYSPXePRvWeFbCDwrAAv9Q8DHTyagBI8/L+hSq+c23u8yLG7GEuAJs8K76IfdCqdCrJgEd6Wvt5HFSulpCi1TQOegKssVwnd/bNv2d6i2iQQIGtRZ8sTV+pzME3FWIWma/7miLyNVV+JWN91LcAWnbWyJ9E7Y3Ugu/IfYOWXhAbUFkxKP42jS2WBb3CVE8bwatjRr9N7ThqYMm2AlQg498/HImS43kbou0+4I6gxzpZQ==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEYPR06MB5424.apcprd06.prod.outlook.com (2603:1096:101:8d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Tue, 20 Oct
 2026 03:48:14 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 03:48:13 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: "marcelomanzo@gmail.com" <marcelomanzo@gmail.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Kane Chen
 <kane_chen@aspeedtech.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>, Troy Lee
 <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1] hw/pci-host/aspeed_pcie: Fix global MSI setting during
 class initialization
Thread-Topic: [PATCH v1] hw/pci-host/aspeed_pcie: Fix global MSI setting
 during class initialization
Thread-Index: AQHdX3PLSL9rksVckUu01uZZcMa9v7cEmMoAgAEzlOA=
Date: Tue, 20 Oct 2026 03:48:13 +0000
Message-ID: <SEZPR06MB7362A8E995720BC546A57CC2FC672@SEZPR06MB7362.apcprd06.prod.outlook.com>
References: <20261019024441.3554329-1-jamin_lin@aspeedtech.com>
 <CAFEAcA8fpUjzHCW=36_P_t=P7RLa7XN1xKJwJgaTdPywcK3rtw@mail.gmail.com>
In-Reply-To: <CAFEAcA8fpUjzHCW=36_P_t=P7RLa7XN1xKJwJgaTdPywcK3rtw@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SEYPR06MB5424:EE_
x-ms-office365-filtering-correlation-id: abf9f9f6-ca66-4e19-1f5d-08df2e5cf7cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|6133799003|22082099003|18002099003|10067099003|4143699003|261009223027099003|56012099006|38070700021;
x-microsoft-antispam-message-info: IFIIR3ePYW/lABbF0hOSUtJpStUcBCvs58A3X1boTopezCtFSwg6GDG0aLDs4w3nKZhYFg08I26VjjT7smMdKC3flGsIaV1BnXPyFGCxGeLrjLFrufpp0SjXr3Vvp2YCLZJJigWl/bfnqW9kKHsaya1BpDagxvQLjHC0ah5TyGI/tvbJ+W/QewnpaOIRsLcrB6lW7IhQ88TAj2vwmQwkQYvzgxH7rTDPpK1U/CKF3fn2e/mU8NLaTKXEojah81PkEEE7L1ShUHM5zRygVl09R5obaEdjvj7jhIT315RVFL3+3A2YiQ+O1RJzIutvOtdu7TkMcETpOKqlMIDYLNHqfwWwsk+OFYiSgcsagAazdZAAg6pfDvGWb3vk6Hu4PsDFLDWS7FZAOnZAH5FFc3yAYPHWkoBZXhvkxzqLRfd0sHJ16IAzg9DsBnE1b3UXI4p3lJM32mhxSbGvgxtMtwdrm0vNkzs3hnWKFiO3ny2wQanwvM4gl4d5X1qYWJrRy15raK/jXy9RjineamdLjebMC8IHsIMlAu0EmQWlC2H2CijGXEDaliZP59X9+SeSmBeen6dPiJA/50K2i90APd/u0S8VxYcpnAwuJTEPXHQj1OepfTwPXzJrevNQDNBk414VgMRdaAPwKGbRi7Idl9rYgj+E9BvLsj8T7L8EPfx7PhM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(6133799003)(22082099003)(18002099003)(10067099003)(4143699003)(261009223027099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlRaWUxlZkdKZ2ttVlJkR1pOVVlmOWxvQk56V1NIV1pvMmVFV3VjTXRra0E2?=
 =?utf-8?B?L2NlTENvWkRKRzVydXNtUzVHd0ZDNEs1cFE5ODBpaExKZG9aYkMzZVNYTjYy?=
 =?utf-8?B?R1E3cFhNVm05NXNVR2NOLzhwMXhGMHdVcWZjZUw1dzJyRXZrd3E4SFc2Ni80?=
 =?utf-8?B?Nm1IVGcvMmpnWFZYN1dObjN1ZmxWWGRmWEJZV283STNhTXdhK2l5N0VIem52?=
 =?utf-8?B?MU5FUDJ3ekRoaVlyMWhpWnllcTNmemIwUm96QlJSZmZQM2FKdkVBRDEvTVoy?=
 =?utf-8?B?NkxLZWVGbVlnMEErRkZkRXc4Z2NVVUZueFB2YWhRcmFKVldsT2ZBT05mT2Ft?=
 =?utf-8?B?VlQzeTdFRjZySjFLWldRcnpqRTlIZldPK2tpYnoxdlJMNGpkQk5CcXB6L25J?=
 =?utf-8?B?UnFMdUR0QjZwZWVJdDkwckg5ZUF6RnpHMFFlaDI1YmNBLzNvbjhldExyemxp?=
 =?utf-8?B?cnhkWlluYVZ1QmhiT0JoUXV1L0dtVlgzbmlsazZaK1pSNWFqSUNOWUU2dGp0?=
 =?utf-8?B?Z1B6TnFqa3hGY3ZQcDdoazdOcWFyOGtvQ004MHczS0lKdHRialhPVzNTM3dU?=
 =?utf-8?B?ZDNnUnJuOHFmNUFVcmhkWFR5OC9BTnBaYXlCTG5EbUNaYjlKaUNGYnhCR2Jn?=
 =?utf-8?B?Zy93TnlHSW91VGdDL1doM0JPcVRoNG50L3ZCTDRVTzVHd3haRUttVFlzWHNR?=
 =?utf-8?B?bWcxeEU0WkxoTjlNK2gwN0Z5bjlNd2pJN2t1QWUrTjNsc0VVVzVBcUxwQis5?=
 =?utf-8?B?Mm9WU0NBeXoxRU0rMFVnTk1HWFpKQmlpa0VzUDFRbnFmeDd0SmNUcHRRelBR?=
 =?utf-8?B?a1h1WlA0eDRpZGpqekJTcDM1TlB5dlRCRWx2UkNSVnUyRHdkQmcxc0FQbC96?=
 =?utf-8?B?SmowVjArcDlHaU5UZGplTlNSV1RLN2ZzTlk0L2k2Vkw4dEZ3WDdHOTdxUFZ6?=
 =?utf-8?B?N3RFK2tQN2ozZG5nQyswNUFmQXpUbE1ZQkthTzB4bXA0bGRQSUl3N1pzTDM5?=
 =?utf-8?B?M2ZwbDFMSXhWcVNrdDNBWXVjYU90RzBoeEdNZjYxY3BPQWw5dmtEQVZFaHZG?=
 =?utf-8?B?azlXNElWT28zU09sOUVrbnh5bmVZSXhmQUJHSEdaazdXalFMQWprTStBUFpn?=
 =?utf-8?B?TDZjSWtoWHlHdVAzcGhVSDI0MU1DQlJKdVdOS283R3lXZkJscUdhK2xZWi9U?=
 =?utf-8?B?LzZPeWZmZWxHUzh5UWJNcmtyNGR1N2dGVUpxTzd2NVJMQ2ZLa1F0ZmxReERS?=
 =?utf-8?B?a1Z0MGdUOE5ld05MdHl5dmw3UEcvaWFURm9vRjVQUExoaUlhM3ZMSG1tY0JF?=
 =?utf-8?B?T01BMTRaNkdDajQzRE1ZMzZYS2JwemVBSGhFSExLdWZDYnNFVXZJOE0vb3pW?=
 =?utf-8?B?dlBidHRwUi84MGNnSnBISWZHeWVYNSt0S2ZxVVFkVjNpMXZoaEF0VlJWN3o5?=
 =?utf-8?B?RDRUYzIxRlloRGpHd1pmWk1BMno3MEJOdERvaGsvT2FxMEFnT3I3bURXcS8w?=
 =?utf-8?B?SStWakxOZnQrMWtpWjdIY3ZtQk15dzBSVGV3R1hDMUJldGt1TUFZN1pXQnU2?=
 =?utf-8?B?c3ZJR21MTnhwdStIWDM1eXk1QmxLcGNrczJUUk9SczdYN2taS3N4V0lWYjhF?=
 =?utf-8?B?bmw2RlZqMW5PSitzck1ic1MvR08ycFJsTmozMTFXVkZOdTd0YUVVTkpIbGhu?=
 =?utf-8?B?aENaV1pMbmxIU3JLb1RhZVVabVVCczhzdFdPMm5hRmtmTy9NeTZ3Tk1vcXow?=
 =?utf-8?B?VnN5OXFMeUVLakhUVmh3bHRNTVU0UEJudjV6enl0R3dCYTRXTlFiUCthTVB1?=
 =?utf-8?B?QUFPT2pEYmRKYnBoRnNVMG5SRjlRaDg1UkxKRzdHajc2dzhldU5RWHJ2Lzky?=
 =?utf-8?B?Qk93L2RIMG5oVW1oTkpQM3M3Ui9vajVvcTdud3dTSHhZN3dLNWJUalJTc1B0?=
 =?utf-8?B?VWNDbXE0N0NKWThxdVJXYkpIL1E2dkwzR3lpWkU1MXErQk1NVWZNejlrZEEz?=
 =?utf-8?B?Q01rU3l5c2p6VzgwTDFFUENTOTNXZXhYSEtCYjZCTFlXRUZqaHZxdWw1SFhL?=
 =?utf-8?B?MEsxK3hsZmNlTkQ0YWtrWHd5ZkhkaDVhUEhUVE1JZW9Xd2NOM3NjUjhQdjdk?=
 =?utf-8?B?YUtZT1p4V2NuclR3SWZqU1RGZmJrNFgxZkUxUTRNM0FVT1puYVEzMnk3ZUxv?=
 =?utf-8?B?SUM4eXBKQlNiR25nbWZKR1hheGZ1M3JOaDVpUzNvMVpCTGxESWIvNW4wTmls?=
 =?utf-8?B?ZUhBQU5YNERDazhaak5oaDhtTEIrbFM4VkNneEh2VzM4bVNPOFJTNWJHaXVy?=
 =?utf-8?B?dVdPWXl4K01Sc3RSYjJwQ2svQUVGTUxyakptM2orN1JtNEdrc1g1UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: r+E+boZgc2MwugTRYk3u3C6TMPm19F139sxlUjhmRRcJvSEUcZIeRkISZEz7hyfuKSOBAjKjtwFBQgQhAKZOr7vddNHPKaPBtMGx7bFPH1ouIWTvNtLw+WUmcn32Hsm2uN7IqzNZio6QHGOR0Pe9+vNB/dB0EShCOjbDDGTe+AnjefeqyCwUaVGOSVTTzLVopzEMaeRwp0Bl4VwftFUvhAqsEDU8VRvNDk/lNF65w01v2dlFqOhfN1D4U1CScR75X2tDj+8iNPWkiaW+zYE8codkI2YTztcbzy5BwbBeFoxMmJGblus3VHgv4WiYU0FAK1W/HeEKwS4VcGb2NP5bag==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abf9f9f6-ca66-4e19-1f5d-08df2e5cf7cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 03:48:13.8578 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xhiSWcQxVZ3wcJsVp9GxCFNLlapoeG7eay8CO+tinl+bAksQkeDyg+YM7bEHEH12WV2ikr5Mt6fQGS6QeH2gwcvp2HoI9r9BDBLSPmGXF9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5424
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxXSBody9wY2ktaG9zdC9hc3BlZWRfcGNpZTogRml4IGds
b2JhbCBNU0kgc2V0dGluZyBkdXJpbmcNCj4gY2xhc3MgaW5pdGlhbGl6YXRpb24NCj4gDQo+IE9u
IE1vbiwgMTkgT2N0IDIwMjYgYXQgMDM6NDQsIEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRl
Y2guY29tPiB3cm90ZToNCj4gPg0KPiA+IFNldHRpbmcgbXNpX25vbmJyb2tlbiBpbiBjbGFzc19p
bml0KCkgYWZmZWN0cyBhbGwgbWFjaGluZSB0eXBlcywgZXZlbg0KPiA+IHdoZW4gdGhlIEFTUEVF
RCBQQ0llIGNvbnRyb2xsZXIgaXMgbm90IHVzZWQuDQo+ID4NCj4gPiBNb3ZlIG1zaV9ub25icm9r
ZW4gdG8gcmVhbGl6ZSgpIHRvIGVuc3VyZSBpdCBpcyBvbmx5IHNldCB3aGVuIHRoZQ0KPiA+IEFT
UEVFRCBQQ0llIGNvbnRyb2xsZXIgaXMgcmVhbGl6ZWQuDQo+ID4NCj4gPiBSZXBvcnRlZC1ieTog
TWFyY2VsbyBNYW56byA8bWFyY2Vsb21hbnpvQGdtYWlsLmNvbT4NCj4gPiBGaXhlczogZjAwMmFh
MzVmMzIwNWQ1NWJiZTRhNjg2NzBiYTE5YTZkY2YxZDZhOCAoImh3L3BjaS1ob3N0L2FzcGVlZDoN
Cj4gPiBBZGQgQVNUMjYwMCBQQ0llIGNvbmZpZyBzcGFjZSBhbmQgaG9zdCBicmlkZ2UiKQ0KPiA+
IFNpZ25lZC1vZmYtYnk6IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiAN
Cj4gVGhpcyBzaG91bGQgYWxzbyBiZQ0KPiANCj4gQ2M6IHFlbXUtc3RhYmxlQG5vbmdudS5vcmcN
Cj4gDQpTb3JyeSwgSSBmb3Jnb3QgdG8gYWRkIHRoZSBDYzogcWVtdS1zdGFibGVAbm9uZ251Lm9y
ZyB0YWcgdG8gdGhlIGNvbW1pdCBtZXNzYWdlIGluIHYyLCBidXQgSSBkaWQgQ0MgdGhlIG1haWxp
bmcgbGlzdCB3aGVuIHNlbmRpbmcgdGhlIHBhdGNoLg0KSWYgbmVlZGVkLCBJIGNhbiByZXNlbmQg
djIgd2l0aCB0aGUgdGFnIGFkZGVkLg0KDQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3By
b2plY3QvcWVtdS1kZXZlbC9wYXRjaC8yMDI2MTAyMDAzMzc1NS4yNjE4NjQwLTEtamFtaW5fbGlu
QGFzcGVlZHRlY2guY29tLw0KDQpKYW1pbg0KPiA+IC0tLQ0KPiA+ICBody9wY2ktaG9zdC9hc3Bl
ZWRfcGNpZS5jIHwgNCArKy0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvcGNpLWhvc3QvYXNwZWVk
X3BjaWUuYyBiL2h3L3BjaS1ob3N0L2FzcGVlZF9wY2llLmMNCj4gPiBpbmRleCBiNDZlYjc0MjM0
Li5jZWIwMTBmMjEzIDEwMDY0NA0KPiA+IC0tLSBhL2h3L3BjaS1ob3N0L2FzcGVlZF9wY2llLmMN
Cj4gPiArKysgYi9ody9wY2ktaG9zdC9hc3BlZWRfcGNpZS5jDQo+ID4gQEAgLTE4MSw2ICsxODEs
OCBAQCBzdGF0aWMgdm9pZCBhc3BlZWRfcGNpZV9yY19yZWFsaXplKERldmljZVN0YXRlICpkZXYs
DQo+IEVycm9yICoqZXJycCkNCj4gPiAgICAgIGdfYXV0b2ZyZWUgY2hhciAqZHJhbV9hbGlhc19u
YW1lID0gTlVMTDsNCj4gPiAgICAgIGdfYXV0b2ZyZWUgY2hhciAqcm9vdF9idXNfbmFtZSA9IE5V
TEw7DQo+ID4NCj4gPiArICAgIG1zaV9ub25icm9rZW4gPSB0cnVlOw0KPiA+ICsNCj4gPiAgICAg
IC8qIFBDSSBjb25maWd1cmF0aW9uIHNwYWNlICovDQo+ID4gICAgICBwY2llX2hvc3RfbW1jZmdf
aW5pdChwZXgsIFBDSUVfTU1DRkdfU0laRV9NQVgpOw0KPiA+ICAgICAgc3lzYnVzX2luaXRfbW1p
byhzYmQsICZwZXgtPm1taW8pOyBAQCAtMjk0LDggKzI5Niw2IEBAIHN0YXRpYw0KPiA+IHZvaWQg
YXNwZWVkX3BjaWVfcmNfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqa2xhc3MsIGNvbnN0IHZvaWQg
KmRhdGEpDQo+ID4NCj4gPiAgICAgIGhjLT5yb290X2J1c19wYXRoID0gYXNwZWVkX3BjaWVfcmNf
cm9vdF9idXNfcGF0aDsNCj4gPiAgICAgIGRldmljZV9jbGFzc19zZXRfcHJvcHMoZGMsIGFzcGVl
ZF9wY2llX3JjX3Byb3BzKTsNCj4gPiAtDQo+ID4gLSAgICBtc2lfbm9uYnJva2VuID0gdHJ1ZTsN
Cj4gPiAgfQ0KPiANCj4gUmV2aWV3ZWQtYnk6IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxA
bGluYXJvLm9yZz4NCj4gDQo+IHRoYW5rcw0KPiAtLSBQTU0NCg==

