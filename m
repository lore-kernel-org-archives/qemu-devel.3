Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFECEB3648
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 01:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxEU1-0001EZ-Ri; Mon, 02 Mar 2026 20:23:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vxETf-0001Bq-6F
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:23:14 -0500
Received: from mail-japanwestazon11022140.outbound.protection.outlook.com
 ([40.107.75.140] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vxETd-0000pa-3b
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:23:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cl7wSJ+HR2oq4cLacOExy5q24F0DDaqQ4wNtuyW/Sih26sp+Ui8IJ64yu+Y7NiOfmBGaJb+yIUuIVkL7djI/XWdoWoJzkMA2AtbkJiRsBPK4il45u6hO6LglKCFBq5c1wgpHkRbfu7O/sHkg2QkY2JFNfGqlCIayfKnEMowdyaOKIfwdudFamVzVfnIHWJR66whB8AdcunP5dK04dhm0hhjYolizXMlzKv9v5m9ZtN1Fa+kAQItVUt2EPAFN8soRy9A73NDoWgEceWrH7lPiiL3Ka1Qn8pr9SZ2LJJd284Rmy94lp1XWBA7HRZ4X52M6zHtUS1Kqdt2LbZfYi7D55A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIyo6ED+JDe52x4hcu2Uu3OM7U7GG6UsZJLUS9j6nQ4=;
 b=Ej0HRgOhzipgqcHWEjnYyCe9pK5+pCpzq1EM7loo+WMNQpjzLDAkLGQ0US8kwHWILmL2SRdCyGdMy9Adk+dPTI4BUsIt7MAygfHZDE2XxcGL2oF76FM/hrTHWXz7koRi8lNXHr8xmEkn0REF5Xr6YVshJ4iL7BFyxTqhTilRrxbr9I3DNMQCquBHAjf4bYfbgO8PcCdaKGuUNrUmU645BPYVkAfQ+vjrcZG4er1LvDrgZfE68JR5QyL8ZQhSBmYey/i+1R9xeFIF832KHvz7KFolqpmD+fmd8pzZdCYWKnix3Zrs7saSFNwzxpEJKF+EJ9nvqtwiMlyoFicCrsiG3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIyo6ED+JDe52x4hcu2Uu3OM7U7GG6UsZJLUS9j6nQ4=;
 b=Vd8hPjNaBFBo201eYhrcGGaUNPGLcv6owgU/ZB9VCuuMed7BkkUYC5l+6uUgCCA5xrIwvh2Q101S5AI9qEdVCC8ZThl7UGywqJZSkcW4DX/hLxblNrF+SZDGZfOosIqXpZGk4CCENeWNI6Jdn6zxKSAfIknN/Gke30GC+n5r9hBThzVAH5VKoCFc7B3HwxkRDnw/+mfixwTaxUUGgru3391Fkaujsw+HhjjXaPPt4hMTZGwGn3CmwFwTNrYfcrTmDwNWTqAog+WA7XJuwf7WsIPt/Jb1UPjvMlGgZ1ssY0D3Vg5Jm3ahtjBbzLEKm12kZ1fmIpCZGrLuQvsFrY+cCg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYSPR06MB6647.apcprd06.prod.outlook.com (2603:1096:400:483::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Tue, 3 Mar
 2026 01:17:59 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9654.020; Tue, 3 Mar 2026
 01:17:59 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Jithu Joseph <jithu.joseph@oss.qualcomm.com>, "clg@kaod.org"
 <clg@kaod.org>, "nabihestefan@google.com" <nabihestefan@google.com>,
 "komlodi@google.com" <komlodi@google.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: RE: [PATCH v1 2/4] hw/i3c/mock-i3c-target: Set num_sent in TX
 callback to fix trace reporting
Thread-Topic: [PATCH v1 2/4] hw/i3c/mock-i3c-target: Set num_sent in TX
 callback to fix trace reporting
Thread-Index: AQHcqfRda5+Mn5Kj5UOjIHS9/+O4zLWbxgYAgAA8+BA=
Date: Tue, 3 Mar 2026 01:17:59 +0000
Message-ID: <TYPPR06MB8206E5DB3AA6E0B8BC61AB6DFC7FA@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260302032626.1974743-1-jamin_lin@aspeedtech.com>
 <20260302032626.1974743-3-jamin_lin@aspeedtech.com>
 <908abf8b-e5d6-40f3-8869-75ce42e632d0@oss.qualcomm.com>
In-Reply-To: <908abf8b-e5d6-40f3-8869-75ce42e632d0@oss.qualcomm.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYSPR06MB6647:EE_
x-ms-office365-filtering-correlation-id: bf7a0714-c97d-4d10-bf63-08de78c2b530
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: 0YwTAVNwRM+YloHWM23PVgejn3RbKBp7BbY7ycIh2/qIOFejb0i5NyUdgQ02gX+J26GGp+fno9mAaIbdnk+utPdhgciRp/DrD/emG6evTOTfprZMpoOs1BuNPW0IBB277yRGYEYyIjFLC3SIZ46aJspUm9i0lliUbOX+evNJ/gZm98N1AcQANPf92fHE2iAG3/iiZan32qTIJfpy7CMc6ysNvZtWK4Na1FUNoXekQ68VllNRocEWm5st/00EpmtH11+N6oEDXnLVLIPS9yz9+foy0E0Y3PZYoZOqQQEmg14jPKRC4ZgriJ7g0VeTNqN5ERrTaDbcBC+nCQOpyNgn+JG5MnX2fR6UbWYEryVZkiWWuH7chEJcuvOiELNizacUag6SaS73JLWTKuaOQOFZhici7U9Z1NVVQb27YNQm9xd+saOJsrn+iQrwmb24bln+6K93vjFLnBJTlRYrEJSPv5JjUVMlJRB/t/DGgeQZbTzU+HyRath9K9RY/LKOL6WL7B5QTbsHmd98KgiJwDjHABqw0YrMsS2R5hoKDnX5c0HkwO9fesk7oxnYlVo39yvDtYop5Cfhl1WrQlAQoBsumBeK79DnzcnUiT112H5fZZCuoPRo0yaCxyU2wT6+YNAUoEqHRTZy8lOKrFopu2rkKP6wOwanZJdVt/V0w5h5ClCl8dfe2R9tBlRwWVV6nTPO1OI6Xu8sya8Ef6YnEEldjSeaMAaLAP1s9/8PArGNOsc8kgXYOozaUVEw2Pr8LsawjibqfYo3rlO2YGS+631m5D04f97UVIgli7HEcVJAWLM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTdmQkdCU1pQSzRWSFZ2TXQ4ck0xRGdwZVYvK3VNMUtoZWRqUXlmZGo5eEVu?=
 =?utf-8?B?TzR4QXZ2Wk1sUWVLTGxLckRhT1JrTWpNRXRxeWJpWERpQ0J0REtMUjBBVVAv?=
 =?utf-8?B?YWxOUjJYdzdtc0FYU1BPdTVhYjVBZzlEdm5zRU9OOGI2eHpPUVZIamdJa0dx?=
 =?utf-8?B?Vy8wNXo5Q0lIYTlMWEpZNk92dDU1OXZHVGk0REdVQVB6aWtKUkhMaGM1NFg1?=
 =?utf-8?B?RFN1TFhteDlYYklkcFZVT1FYWUpHR2tkelpHU0I3K00vL1ZMQ2M2aGJBUUJF?=
 =?utf-8?B?bnlhS1ZWb1JwbnNBVkdtaVA4di9wdm5BdCtvSUZMazVtYlFqTmptcWJtbjR4?=
 =?utf-8?B?dWVOWkZ0TnlkR0VvUVFoL2ZocjJtTDl3akgyTVhGNWM2R0lkYnp4czhxYld0?=
 =?utf-8?B?aHdkZjI2U0lsTHJNUmVjeFpSNEhxWXVxNkxKc01qd0pYSjRXY0J3dU54Q3Np?=
 =?utf-8?B?djl0MUhqNVBUc3ZhN3dHYjlhcTdBbnJtNndtN1kzM3FBenYyWW9qVTQwWWlq?=
 =?utf-8?B?NUtjdGdQZkE4WmZ3UUFESHZXMklnVDlRbldZZzlTVnlQY2JwdUVEMi8rU25k?=
 =?utf-8?B?bDZWbzZML2dVV0dKRXMxalFsT0lQNkJDNHNqMmRTaVBvM2l6NjBGM0FaT0pr?=
 =?utf-8?B?cVkvRWVLemRKZEFrNTJ5dnMzU2tkSCtremdMaFI4bVBGTThJWE1XSEJHeURs?=
 =?utf-8?B?UTVCcWpkYWRHWFpXS1gyMDZ0amNKcXFUUFROaC9Wd0lvOE9BaDhlc0VYc0RD?=
 =?utf-8?B?L0VnSHNGYWtPcTE1bE1LNEVrd3cyTDVNdHVYUW1jN0ZXQTZ4dnNZQnJQRnJ1?=
 =?utf-8?B?R2NjNHB4a0V0WDlKaHZwVG5QWnhobWMxUlRNN29hUFVYZTBWMHhEY1NYbkYw?=
 =?utf-8?B?WFh2eGRPTmhCTkpXNEhDUzJNNWhyVGlHbzJhKytySlJyYW1sbnpzaW9pRGt4?=
 =?utf-8?B?bHI0TkViOU5YZTEzVTNtQzkvZXFqeWpBQlFSNkI2cDRQS0taNXFNcHhpMHBj?=
 =?utf-8?B?eE8zeEtoRVp2NzdFWHF4cWVId3k2MG1vc2NQelZ6OXFwSlByU1N4c0I3cFV5?=
 =?utf-8?B?QWVWVXFKa1FBdTZIbTlHRnU3ZXY2VjBjWjdLSTdYaUtaM0hTa0lQNGVSMU8v?=
 =?utf-8?B?RlJpTmU1ZXhKbVFUK0FHM1lEUTM3S2Z4azBGSmJHWE04MlVFYVgvZTBza1F0?=
 =?utf-8?B?WEgrUWFza2RvZ1NheEpmcGtNMnNXZEhlYjFlV1BLSGNoZE9rQlYzeC9iLzZJ?=
 =?utf-8?B?cXYrRU9ndTRMVDVHQ3hHUXQxYVRycFVjWGliVTcxaFpMd2NpOWxLYk52NDlm?=
 =?utf-8?B?Sm9Ua2hzYkt5eERUTk5DZW9pZnZPNXZzYzI3QVFWS3pkVm5ndmxjZ0pLQjM2?=
 =?utf-8?B?T2x3dFdqa2YweUJrM3BsUXFITm9PeHI4UzZLRWY3Q2RjbUhPdlIvSGx0SFkw?=
 =?utf-8?B?OXZVeXBUaytYbU5nWTNzUGIwOEpYTkU5ekZva092ZWFTeUl3akFra283ZGhq?=
 =?utf-8?B?ZnM2Y1F6TUxqckVndTkreUFrTjBMQkNhelJTRTZ6ZGsrRUJMMUR5U200Wllv?=
 =?utf-8?B?RHl5Z1FlNnVkaUlzT0lGdmljMGV0b1ZCNURvZEJzY0pmRUQ5S254MEthVVJa?=
 =?utf-8?B?WlpxdGUzYlpjNUdvcWtvdFh6SWs4VDdLZlUwbW5uZ3Jnd2dlYlR2aUp3SW5R?=
 =?utf-8?B?amw3WUwyN29EcVBYaFM3WkowbWhBclplQXBabHluNnc5NnZ0dlJFT0RvUVR3?=
 =?utf-8?B?L2dreVJUMVNNZnRHYXFLalFyRkh6bkhUaVNldm9rbERMSVpzY1pzZ0Z1WEpr?=
 =?utf-8?B?SVV5OEk3cWNybEZwenJjOXZELzM1Ui9xeGV0d1FWbGhDYTFqVmVkY0psTnhC?=
 =?utf-8?B?K3BMV2VHenVuOTBUT0dORXZ0OHBvU2dLby9EMFNyc3dFTktZSG9ac3lVTHRO?=
 =?utf-8?B?TVVhTE1COHRnM0RNUzY1ZWVyMmFmT3l1eWsxc0xVM2V1ZDJjVm9lUHVvanZL?=
 =?utf-8?B?amVGa1FOcUlQdllTblBPOGhQazIvaktsUHNLRXdxUDkwRk00UkExMk5HeHBE?=
 =?utf-8?B?V0ZOcmtjdmNGdERLajhBUm15QytqbWRpNTNscTcreUVnMDdXaC9FMm9jaVZZ?=
 =?utf-8?B?YzlHMHpvaW8vRTRpYjdzWlBKbmNLZ1JBeVNzT1hGb0FTUmdKd1N4WFpNRWFv?=
 =?utf-8?B?TXU4cVdNU2NjUzEwSndhYlh5QThFV2c5NkxCalRKZmM2YmRPalU1bDVzcFNC?=
 =?utf-8?B?UWozU0NneVF2dCtoUjdHUU5lVm1LeVErSVVpQW01MXAyd3lod0dVRXVaWXlB?=
 =?utf-8?B?RVpBMzNPRzdlNGUxNUIwRjhBZHVRRFpEdHZtMWcvNjNjSjVxRUpBZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7a0714-c97d-4d10-bf63-08de78c2b530
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 01:17:59.1490 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6j5Esyup148aTWef4ESCZXa7enEO3kxfhTgCme7d7KC7k1cKoWO2gH+yHFs7f5g7LA8giI+1zd95V4Ct4DTxa0XIu3H4S8PCwcNBwLdDxvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6647
Received-SPF: pass client-ip=40.107.75.140;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

SGkgSml0aHUgSm9zZXBoDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAyLzRdIGh3L2kzYy9t
b2NrLWkzYy10YXJnZXQ6IFNldCBudW1fc2VudCBpbiBUWA0KPiBjYWxsYmFjayB0byBmaXggdHJh
Y2UgcmVwb3J0aW5nDQo+IA0KPiBPbiAzLzEvMjAyNiA3OjI2IFBNLCBKYW1pbiBMaW4gd3JvdGU6
DQo+ID4gbW9ja19pM2NfdGFyZ2V0X3R4KCkgZGlkIG5vdCB1cGRhdGUgKm51bV9zZW50IGJlZm9y
ZSByZXR1cm5pbmcuDQo+ID4NCj4gPiBBbHRob3VnaCBzb21lIGNhbGxlcnMgbWF5IG5vdCBkaXJl
Y3RseSB1c2UgdGhpcyB2YWx1ZSwgaTNjX3NlbmQoKQ0KPiA+IHBhc3NlcyBudW1fc2VudCB0byB0
cmFjZV9pM2Nfc2VuZCgpLiBJZiB0aGUgdGFyZ2V0IFRYIGNhbGxiYWNrIGRvZXMNCj4gPiBub3Qg
aW5pdGlhbGl6ZSAqbnVtX3NlbnQsIHRoZSB0cmFjZSBvdXRwdXQgbWF5IHJlcG9ydCBhbiBpbmNv
cnJlY3Qgb3INCj4gPiB1bmluaXRpYWxpemVkIHZhbHVlLCBsZWFkaW5nIHRvIGNvbmZ1c2luZyBk
ZWJ1Z2dpbmcgaW5mb3JtYXRpb24uDQo+ID4NCj4gPiBGb3IgZXhhbXBsZSwgdGhlIGZvbGxvd2lu
ZyB0cmFjZSB3YXMgb2JzZXJ2ZWQ6DQo+ID4NCj4gPiAgIG1vY2tfaTNjX3RhcmdldF90eCBJM0Mg
bW9jayB0YXJnZXQgd3JpdGUgMHgxMg0KPiA+ICAgaTNjX3NlbmQgSTNDIHNlbmQgMC8xIGJ5dGVz
LCBhY2s9MSAgICAoZXhwZWN0ZWQgMS8xIGJ5dGVzKQ0KPiA+DQo+ID4gVGhpcyBoYXBwZW5zIGJl
Y2F1c2UgKm51bV9zZW50IHdhcyBuZXZlciBzZXQgYnkgdGhlIFRYIGNhbGxiYWNrLg0KPiA+DQo+
ID4gRml4IHRoaXMgYnkgc2V0dGluZzoNCj4gPg0KPiA+ICAgKm51bV9zZW50ID0gdG9fd3JpdGU7
DQo+ID4NCj4gPiBzbyB0aGF0IHRoZSBhY3R1YWwgbnVtYmVyIG9mIHRyYW5zbWl0dGVkIGJ5dGVz
IGlzIGNvcnJlY3RseSBwcm9wYWdhdGVkDQo+ID4gYmFjayB0byBpM2Nfc2VuZCgpIGFuZCByZWZs
ZWN0ZWQgaW4gdHJhY2Ugb3V0cHV0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGlu
IDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gIGh3L2kzYy9tb2NrLWkz
Yy10YXJnZXQuYyB8IDEgKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9ody9pM2MvbW9jay1pM2MtdGFyZ2V0LmMgYi9ody9pM2MvbW9j
ay1pM2MtdGFyZ2V0LmMgaW5kZXgNCj4gPiA4NzVjZDdjN2QwLi41YzkxM2VlNDliIDEwMDY0NA0K
PiA+IC0tLSBhL2h3L2kzYy9tb2NrLWkzYy10YXJnZXQuYw0KPiA+ICsrKyBiL2h3L2kzYy9tb2Nr
LWkzYy10YXJnZXQuYw0KPiA+IEBAIC04Niw2ICs4Niw3IEBAIHN0YXRpYyBpbnQgbW9ja19pM2Nf
dGFyZ2V0X3R4KEkzQ1RhcmdldCAqaTNjLCBjb25zdA0KPiB1aW50OF90ICpkYXRhLA0KPiA+ICAg
ICAgICAgIHMtPmJ1ZltzLT5wX2J1Zl0gPSBkYXRhW2ldOw0KPiA+ICAgICAgICAgIHMtPnBfYnVm
Kys7DQo+ID4gICAgICB9DQo+ID4gKyAgICAqbnVtX3NlbnQgPSB0b193cml0ZTsNCj4gDQo+IFRo
YW5rcyBmb3IgZml4aW5nIHRoaXMuLi4gY291bGQgeW91IGFsc28gc2V0ICpudW1fc2VudCB0byAx
IGluIHRoZSBpYmkgcmV0dXJuIHBhdGgNCj4gZWFybGllciBpbiB0aGUgZnVuY3Rpb24gKHNuaXBw
ZXQgYmVsb3cpLCB3aGVyZSBpdCBzZWVtcyB0byBjb25zdW1lIGV4YWN0bHkgMQ0KPiBieXRlIG9m
IGRhdGEgLi4uDQo+IA0KPiA8c25pcD4NCj4gICAgIGlmIChzLT5jZmcuaWJpX21hZ2ljICYmIG51
bV90b19zZW5kID09IDEgJiYgcy0+Y2ZnLmliaV9tYWdpYyA9PSAqZGF0YSkNCj4gew0KPiAgICAg
ICAgIG1vY2tfaTNjX3RhcmdldF9pYmlfdGltZXJfc3RhcnQocyk7DQo+ICsJKm51bV9zZW50ID0g
MTsNCj4gICAgICAgICByZXR1cm4gMDsNCj4gICAgIH0NCj4gDQo+IA0KPiA8L3NuaXA+DQo+DQoN
ClRoYW5rcyBmb3IgdGhlIHJldmlldyBhbmQgc3VnZ2VzdGlvbi4NCldpbGwgcmVzZW5kIGluIHYy
Lg0KDQpUaGFua3MsDQpKYW1pbg0KDQo+ID4gICAgICByZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4N
Cj4gDQo+IEppdGh1DQoNCg==

