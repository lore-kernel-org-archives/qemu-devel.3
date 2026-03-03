Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3EFEB3641
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 01:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxEDN-0007gb-UB; Mon, 02 Mar 2026 20:06:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vxEDK-0007gC-Mf
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:06:18 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vxEDI-0006md-8v
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:06:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SyfOAdRuDzyYIsFhRcbpU1jfho8quzJzTOlNUUI5bqHSE0xlDmtPA0HoPxszxWlNBuSZA8eEFZ8rm6UFipghkuGGAb1n898Q0vMR33F/WstCXKXmBjgWaB2ZJ8AHAhUz2rS9secJeTOPdQhFUfI7g4tUoUyNlN7ut8LHuahmiEKgZNEp/GrWO+zwDb1VfoS2VsvbeNtTr/En/+4avAuXO+bwaUSib2r9rSV+9HzEI52stpaAvJqojvuUkRjm02iJ0l2ssz+ePFdfmsXuCOc9Gn6+JcPU/iKh0KE8q2Je3ubI/d6fE841irWC6ei1vao8wwh3ZvVN2ocA7I5w/kKWiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNifHmD/EZxGjN0mZR+goAlkaDliPSbG471TOPR8i0w=;
 b=sdu5wD/4KH+YNceeAhHAgX6QFFOGrQbehWHiFfGTsN8XjrJNdA/v6z+AkKJPE1sK6fZuv8kFmO3ox9WIvYyeQ6Z+PL4Ap+Jk++n86R38vexsm4fkaoSyaVDhwdAM/6Jg/Cg3/mrIWf7YZ5R909RrNql/4Zt94gUtA5MypEVUaFT1gpU6XrFEZ6EYBoehefIvjCBDwkxDm8uKqFluu6oS+NfRQ4jVPzW0vc0q38DtNanaKC9DjU1SpPQ6nUj3LnNZ2H5IwgmSUoRtqKmT8qm/cD/zLLDXSdHLuIiPnnxftgSX+slUUYVsEhifo2Q0azXHzea35XiFl6qS5Pnb8l//wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNifHmD/EZxGjN0mZR+goAlkaDliPSbG471TOPR8i0w=;
 b=MljcIBN8nV0UH098fSqCxvpzFQgJW50rjPyAvbsdfud5N5JiFX6H6xzlwMmL9pJRPCsTTeVOnv7eOB5DTMlPfGZzH6L3DU6HwRVFKA/vWrXBw41OFVWjTKhDSc4nUuvFJLQCnG1duAQ817tKT5ymeOC/XlC5xUJ4I8G9l/zD8rrvXnWoylBFtGwJmwzkvqgMNoyN0JBZWQMgQQaywyppX6C1Gg6voTBp8OLdnKAmB9GTQcNxYlXM1uPi4Zs/r3GZy7rpU/D8sZAKXxGm4+mCwAYEas2f9mG6LVCjqcQfpLQ2jzBAnByES8bDEYh+qS/jXY7TwzeyNApFiuHyKqYm1w==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SI2PR06MB5196.apcprd06.prod.outlook.com (2603:1096:4:1e0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Tue, 3 Mar
 2026 01:06:08 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9654.020; Tue, 3 Mar 2026
 01:06:08 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Joe Komlodi <komlodi@google.com>, Nabih Estefan <nabihestefan@google.com>
Subject: RE: [PATCH] hw/i3c: Fix array bounds and storage in i3c_addr_is_rsvd()
Thread-Topic: [PATCH] hw/i3c: Fix array bounds and storage in
 i3c_addr_is_rsvd()
Thread-Index: AQHcqnxTS4yrE6rxnUaUJsTDeVrjlrWb/oSw
Date: Tue, 3 Mar 2026 01:06:07 +0000
Message-ID: <TYPPR06MB8206182F2462EF6EB43906B3FC7FA@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260302193931.382228-1-clg@redhat.com>
In-Reply-To: <20260302193931.382228-1-clg@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SI2PR06MB5196:EE_
x-ms-office365-filtering-correlation-id: 1aa85df7-7161-40b9-73e6-08de78c10d4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: fENpN9UpmXcK9Ow6MjZHg+8wGPz4jIYrba9+MUM0x9nwaaPEY3CRPD4dPKcU4dN0umxJ6giFop12Mx9ZUbtpf0t0YR3AmTrkFCNyCwb+MSgPC2tD6paBO2FYhb6dpxBR5lq3agjoCTun8EA8DF/2zj5hKReAuVTT4c+sRL8fsIuYgFT49WLn/mkPUIx2Wh6Th2g2exn1m0IJ7YgvJdZBLk5aqXB8OFgeh37TQa2tC/mDWX1w13O8mBJiQ27MFfi4SudFlO6AaSLOgBf1Z9PUHvFfzptZp7FOBPpoF2iPJegkpkJ6+qGVcRrCF0WXhJ8neJk6070NCNLpQZM8+JG+OmvVjCTQ8UQyrt1JRZdJVDQM/f3tRThanMX3aUvH7wzeWNpkShJ87GD2IB8vwAncdFJpzwElom58UbzFTrILJvaw2icS6owi8lD3DlM01uk2Kn7MYDsdIJBWD3IYzFSq8pcEVyhVMPIjlaJtCzvFuH4pNuK1lsFw0k7XWSz8PnXYDYAL+JdqIHtGGzwt2Mg0EY/V46my/LBzaPKtiDrjpjGw3K/HD1pS8atw1R783qBXdFG3NGiVVAKvdkxis2UveWRqcAy2UCNC/kb/r+mXpeDc1JRqkJvJBGNL3ltHRCIiAh6Cgv4uffskWLjv4DGVW0svLEbE1ZicdpqvVDXd5M1F8JEHMsWbs4rXmIcFFZqhlfPUFDrHLoy33KDFu9udb6j8eAzoP6Tt6FcSQD1mB/g/+lM4zre/W9PukOTHAXPEKsJT7Kb92GZX6qFa8nfSZkWRG91fj722ufW335gFMfE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnNBcFdpRktPMEZ0YWppZFBqWTM3aEVDSmlWTVBjNjJJVTV6cEJYUXlFdUtq?=
 =?utf-8?B?NmEySjJMaFdMYnBtNTB0UC9SQWxyU2RyRG5iNDlvR0ZHSEM2d2NLVXpJeGRu?=
 =?utf-8?B?aUVxTWE3aS9pbnJSdC91eHByTmwyd1pmQ0hObDhNSzNtMkoxcnhTa0xGcFUz?=
 =?utf-8?B?bTRvWU12U1I2SkppVGtIdFFGaUVhblBobE5CdklYNVdJWFBsNld2ZkdwWDZ5?=
 =?utf-8?B?c2taa2p0OVlpMkNGeTJuQmFsZWxCTmtGcVVGbk1raXcwdktWS2tqOThhT0JQ?=
 =?utf-8?B?MGtvSUk4emVNeVlmMm85S0JoZDE3Nkl5dHZJMzlHelltTnVWNE02MEREUVkz?=
 =?utf-8?B?Q2FpVyt0dlkxM1NPc3k3c0lraWlnRUg5SzlzeGN3djNjQzFVaU1HVmQzS2ZW?=
 =?utf-8?B?YmFOZTFDbmE0eUFTUkVjSFNPVkthMXRSNzFTMHlWY2FuWWpJTmx2cXIyVGV1?=
 =?utf-8?B?RHlIUm1wekdZb1NXMnFuTTg5WGRGWklFM2pnOUhiYjBCSk9SZlBuV0RiU044?=
 =?utf-8?B?aHg5ZHFkNTBNN1laeFl2UW15U2tMVEdibGFia1BYS3FaTDhOdEdIeWtZZWhT?=
 =?utf-8?B?VVZWR1hFWUlYUkljcXgwdzBGRFRPSy9mY21MRFFMY0lTSVdKK2k2clNFdjB4?=
 =?utf-8?B?bUUwSU1RNURVTVIxZitodE5MeC9zQzlib05ad2lYd0t5Z2dmWktISEl6VXpp?=
 =?utf-8?B?ak14S1lGU2JDaWg4bGtPand5QlNGTnRNZXFxWXQ3akJpVzRieGpNbjVwdlpS?=
 =?utf-8?B?QnJLK3dHTFNxNXZSZlRadm9GZk93Tk1NNWw1aXIrbmNmd0E1cE1IQjZIbW9E?=
 =?utf-8?B?S2NIRVR4Z3pVZnk4YUxzTDFOTVduUy9tMWdpckRWRnMvWHcvUFFETGU1Yll0?=
 =?utf-8?B?UkkvTFM4S3dFM29KaDdHTm5TVUtjV2ZSMS85TlBWMUVKYlVNZXNHQ3d0Mm1W?=
 =?utf-8?B?eVRTSmNaZUFLZ0FrSHJvclErckRwdGdnbEVNQzNSWlVudHpZOVhJZ2J0VXhv?=
 =?utf-8?B?OEc2a2NHUXhmRlU2OVZGSFNrUDMxeXFlVmJ0WGJXZHNMZ1NYUFNDeFJBMEtD?=
 =?utf-8?B?T2tSd0dkSUFFSlF3S2VGZzFYMER3dUFRQnVZcnIyRkRlVHVoczhoVk1KdWhq?=
 =?utf-8?B?MkkzQ2c3RVRIbGdKOEZDaEdWdk9FRDNuVEdvMUY3RGFDdGVmOWNOWnhLQ2Rx?=
 =?utf-8?B?eHNqUmhDa2NpbXZwUWJyQWhqYlY3WWU0cExVYlhEUlk3OEpFWlU0QUZoeGhu?=
 =?utf-8?B?R09iTDZqYVBkUXViSU1EZVE1aUNObHJsNXlLM0krdE03dURFZk9mNGRQeVBi?=
 =?utf-8?B?MEJHMWRabmhHUVdxU0VzRyt5REtzU3VoUHptWnl6NDdYamZhOU93TU45LzRq?=
 =?utf-8?B?Q2tlU1FBUXNadFJmKy9mRHdVWGRwT0VCN1BoVDdJTlpQNElmdWxLMzBpVURp?=
 =?utf-8?B?RitONzdHbmdOa2VQdVJ2bzExT3RheGZ3ZkwxVzBqS2dqVmN2NVA4U0ZJNFg1?=
 =?utf-8?B?RGI5R2tOZ1dLaVNFVUhGZXFIL0xzZytkQ2tBaVBjRUwwY2NhVWtmeUVxSlgr?=
 =?utf-8?B?TStSNmRSRFc4S0VvSzFGcnY0RTJSaVpsNXUwZmNJQW5NNUFqNkhTYjZFU0ha?=
 =?utf-8?B?SisxRzZzVEhsQkxYdm1UeUdEbUtseWVJa2NFWG40NmFWbjdYemlPSE95ajlj?=
 =?utf-8?B?UDNLN2EyY2NzNHJoOWdKZStXZFNNVmZmbUVUVnk1RDRSb3hmU2tYcGZzVW56?=
 =?utf-8?B?THk1SzdNZktjYTk4UVpVZWhzWkxDYjdjeXFMTk9jUVBtcnN0R1YzT0RWUzY0?=
 =?utf-8?B?MnVYNzY3ZElKb3l3NWtONE5UOGl6UFFHM25GeElQL0JpeTM5NTA5NGRBWVFz?=
 =?utf-8?B?eTk3cGp2c1VXTE4zK3V5MDVPVTM0TitXN0hTRkJJaUNLSnJDMWlFUTYxenB5?=
 =?utf-8?B?MDJBYnhnN3gvcGxDRVNiZCtnN2huM3RISWxOTURmOURhSy9LZGtHKzhjMXBa?=
 =?utf-8?B?TXhKMktDM1ZkQUI1MHd1WU4zaTlPcmRFbFdpZm1SRE5RNUtDRVVYM2lHWFd6?=
 =?utf-8?B?SjBXY25mK0RwMEZMT0hJdklFQk12c0VRcGJYNlZqc1RjU2lPQ3RScVZNYXVO?=
 =?utf-8?B?bllCTzVpMjFZb01RVXMvOS83RmVuTXErSUZFeGgrYkJSd1hZYW5yUXArR3Q2?=
 =?utf-8?B?M1p6eDUvYzJwTEpoVWtOZCs2WTFHcXVoK0ZXRXJtS1VFS25tNmJuK250U1Vt?=
 =?utf-8?B?eXgxcjlhL0VJWjg4M3lIeXZSVS8xZG5ZNk1vRy9PSTFBQ1FZaC9WM0ZPeW9U?=
 =?utf-8?B?QUtVVjJ5c2xxV2J1bUxsVmtRYjBQSDNDaUxYQ2tnbkRWSUkyY3UxQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa85df7-7161-40b9-73e6-08de78c10d4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 01:06:08.0138 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wY8M9+E0imqSyHhCoMdClzyD9y0cKt2/94gclNFhqb+AWr6DykHQ3lhKyQmZtFnC6N6NTlGmOGjEj1XalxaTPZuU2luLzVGRe9H3uyG0vtA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5196
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

PiBTdWJqZWN0OiBbUEFUQ0hdIGh3L2kzYzogRml4IGFycmF5IGJvdW5kcyBhbmQgc3RvcmFnZSBp
biBpM2NfYWRkcl9pc19yc3ZkKCkNCj4gDQo+IFRoZSBzaXplIG9mIHRoZSBpc19yc3ZkIGxvb2t1
cCB0YWJsZSBpbiBpM2NfYWRkcl9pc19yc3ZkKCkgaXMgMjU1IGJ1dCBzaG91bGQgYmUNCj4gMjU2
IHRvIGNvdmVyIGFsbCBwb3NzaWJsZSB1aW50OF90IGFkZHJlc3MgdmFsdWVzIGFuZCBhdm9pZCBw
b3RlbnRpYWwNCj4gb3V0LW9mLWJvdW5kcyBhY2Nlc3MuDQo+IA0KPiBUaGUgYXJyYXkgc2hvdWxk
IGJlIHN0YXRpYyB0b28gYXMgaXQncyBhIGNvbnN0YW50IGxvb2t1cCB0YWJsZS4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4gLS0tDQo+
ICBody9pM2MvY29yZS5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcvaTNjL2NvcmUuYyBiL2h3L2kz
Yy9jb3JlLmMgaW5kZXggOGEzNzA5OWNlM2ZmLi4wYTI2NmUwMGEyNzkNCj4gMTAwNjQ0DQo+IC0t
LSBhL2h3L2kzYy9jb3JlLmMNCj4gKysrIGIvaHcvaTNjL2NvcmUuYw0KPiBAQCAtNTI1LDcgKzUy
NSw3IEBAIGludCBpM2NfdGFyZ2V0X2liaV9maW5pc2goSTNDVGFyZ2V0ICp0LCB1aW50OF90IGRh
dGEpDQo+IA0KPiAgc3RhdGljIGJvb2wgaTNjX2FkZHJfaXNfcnN2ZCh1aW50OF90IGFkZHIpICB7
DQo+IC0gICAgY29uc3QgYm9vbCBpc19yc3ZkWzI1NV0gPSB7DQo+ICsgICAgc3RhdGljIGNvbnN0
IGJvb2wgaXNfcnN2ZFsyNTZdID0gew0KPiAgICAgICAgICBbMHgwMF0gPSB0cnVlLA0KPiAgICAg
ICAgICBbMHgwMV0gPSB0cnVlLA0KPiAgICAgICAgICBbMHgwMl0gPSB0cnVlLA0KPiAtLQ0KPiAy
LjUzLjANCg0KUmV2aWV3ZWQtYnk6IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29t
Pg0KDQpUaGFua3MsDQpKYW1pbg0K

