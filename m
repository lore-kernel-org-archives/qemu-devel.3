Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C24FED2FA
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 09:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0cMT-0002dT-5K; Thu, 12 Mar 2026 05:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w0cMS-0002d9-BP; Thu, 12 Mar 2026 05:29:44 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w0cMQ-0003qI-1o; Thu, 12 Mar 2026 05:29:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dGMyIPxqU2EpOstJeKEcwAMveY/Pim79+l40V55O/2d0qykohyuti96ahs5qQGjhIrKpKIwjo5HHEbyfUNtCCJYv7Ovb6XDL7aGqLf1vhOKM1lu+vdT+LKOFREBYl4tbBWT6lpLfDLwGCeVe5aWC5kAdlIri38xm+RmdsnEVF2YKFawD1yQ0PMOUsYQZRe0DRKSqvLsn3JG4NS7sdUk8saY8RyMnR95k6Cwf4VBr77qNw+opQBEqdwDPgGonW0Su81SY0H39ynbWA/zi3TyVg5WeFwXC3sAy9BWULb1ABmj19XH7cI00QSPUmoAqD0MbJ2FL159+sCtlPhZWRx9u2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8uU6yZHT+l1wqPjfTS1DVVHHpHLVS+aY3WpJUltkzY=;
 b=Of6oKcU5azBkjaq6HwnBXSeVAyBFZYU2UM+Dm41Dz8WO5rEUFP+y5NhaR1qe6zcW1ABJ6KLuz7IeP6gCxPaoFi5Zzysvbv3YDEM0bwyyjRmR+Z0bDjSlw2YXzg8bu/YqfgxJBZ2+pCKcvAU9mleMlMqT6tdCfudJqOeXtzfjdwarMeHI1Pob8MXfcKCZkxRnWLmFJziqDJtV9VGN6mxSj+7hjOGkfi4Z+laMHlOfRldMbMOLeoS5mj8kn7C4/FUt3v71HE+rSYC6kaCGa2OWWD9aIham4pLuiZIYxzwUpnTBTSSpt9D0wyNF7tYh/5DCg8n2KqGFlvRUBALjCZDNtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8uU6yZHT+l1wqPjfTS1DVVHHpHLVS+aY3WpJUltkzY=;
 b=V+BFKD0nOHkzMP5gjJKrswUguXrf12z4O92tnBpWer5wVpB0Ln0UNyqy8Wz/3G80YAMkbK1sX5TQQcGY9qYlPEZrfnrg3zEu5ovAKJuHarTPcWJXrz2WPMf9S0mI9NpoqxaYjeouP4UROcoUePMSYRC5q1Shd/0dUBQ3lua5i7jDakyEDIPizQ8MHqb9n0aCoyG5PevSd80XjjoHcpX5W+CIygy7L0rntRZoviUqL8kpMQMVufkikium/86q3e9B7mlqaWz9TrxXd+rD9PGVZ99qAK1EHr1QEMMH1g8gO/IHteVH3J7h7V8FZHnOuH3Jme0X6N09H75347il0uVK3Q==
Received: from IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5)
 by BN7PPF7B4E3DFF8.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 12 Mar
 2026 09:29:34 +0000
Received: from IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::5a27:a8d9:43b7:3b8d]) by IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::5a27:a8d9:43b7:3b8d%6]) with mapi id 15.20.9723.004; Thu, 12 Mar 2026
 09:29:34 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
CC: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>, Zhenzhong
 Duan <zhenzhong.duan@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?B?RGFuaWVsIFAgLiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Alex
 Williamson <alex@shazbot.org>, Eric Blake <eblake@redhat.com>, Markus
 Armbruster <armbru@redhat.com>
Subject: RE: [RFC PATCH 1/8] hw/arm/smmuv3-accel: Add helper for resolving
 auto parameters
Thread-Topic: [RFC PATCH 1/8] hw/arm/smmuv3-accel: Add helper for resolving
 auto parameters
Thread-Index: AQHcr/oMB52/+UCqJ0eb9yphs6lsLbWnYtGAgAAHFYCAAy0NgIAADLpg
Date: Thu, 12 Mar 2026 09:29:34 +0000
Message-ID: <IA0PR12MB7555329AC71A1756488EDC4AAB44A@IA0PR12MB7555.namprd12.prod.outlook.com>
References: <20260309192119.870186-1-nathanc@nvidia.com>
 <20260309192119.870186-2-nathanc@nvidia.com>
 <b76df308-6731-4d30-9665-34d4cb71159d@redhat.com>
 <CH3PR12MB7548A32AA54FF73AC285426AAB46A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <6c8e31fd-e67f-4cfc-a6de-9268c668f061@redhat.com>
In-Reply-To: <6c8e31fd-e67f-4cfc-a6de-9268c668f061@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7555:EE_|BN7PPF7B4E3DFF8:EE_
x-ms-office365-filtering-correlation-id: 98d70f32-d605-4d3b-59f8-08de8019df80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: pHd6RfuERn6DgE0gGF9vfuFESgL+oaNcDk09A8UsgCTsQ9CH6K1+QWVZMTrE0p0ymXSA5C2gEB/DTSXIEZ7zrwIGn0T8XMtWfeUeFz1jOeauWR9dOHgv8S4eeoPZEAMnGfasTXDMrrv6N61LNuAGhHkcsZ88QFg3ELOGFtkytQ9PZ0gmDIfpWigwpee7ExQpsXkoSjY2UsRB8tE863lXGBfH4eAzHZa7cCdaiSHCpAiW3n4f4V8L/CBAqsBWTeSoD6xyZ4005qHiQWc7jqoTs0CfNAqoIjGGS2patlUj8Fo0vi1cZlVtgQNSi1Aa8EFHqT6X3laFZsaka3XRnU2sdGhXGqpLWA7E1nx7vQ+PwDU4eSKIdasFMY8gZ0CZjNmsv8FrcBPpreH83YCuW1xvaUXWttewRqzdUbEC2KM5nGByueWbPBvpykcJSGgAUAClCJaIMfRv/TExwEsos6ZdYNS3Ay70Ci8g4dGWHiFwZ3e37RqfYr+da7tvf/cGG++gdCbuhB5qRLp+HA3axG+Fb7AKNN70SgzFPptEAoejID4liOuu4AcwXl9duxIhutxRqllJs0F+/7ep5eSPbfH9CbayFkYvvmcY/TBzVy+CqoB1kE+5QSRdKHWa0hwH9I5b5qPVsfSf8i0FzWvMbdznaGTBykdgvQGjkNV0Wyb9BgeuivfwILzU0358QEbwXMB2P4FNA9CvK+BY4/7Vot7QtNsHHFr4Mr7VKp8rumoFO4edIK1DVkU+tG4f6jRnXkCbWA3bAoEyZmCfoGXZg41pJ65mKIwZFfb7guKOmZIbHCo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB7555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFZaSjdYdmwyRW5nWU9mWjFWOFNjSGFYT0VBZG83b2wwSXlRRmp1d25hUXd6?=
 =?utf-8?B?eU1lTUUxa0pFL08xSzd2bmFrdVoyS2NlbnZWRlFtWVhKYVF3RkdUMlZHZEh3?=
 =?utf-8?B?TUpmQVFST3huTDNXSDNDSFpZajlKRUdaOUNMa2NqU1VQWTU4T3htK2FFMTBX?=
 =?utf-8?B?elB5SWs2ZWNBNlhwbTZLNkh0c0VQZVVmZDlJQ3ZMd3drRVBNU3NpQXVqeWY3?=
 =?utf-8?B?SzZTL2Y3MG5uZWNyRWRUa2NZZDVxL2NaMFNtekc4TFlDbEd1WkVPQ0NWaHBz?=
 =?utf-8?B?aG54SlcyaExuYWRXdXg5MUpzT05ZeEdpVDZBem80blRCMnlwamZxa0JOZXBx?=
 =?utf-8?B?TnhubzFXZWFnakZWWlhGZFZ3VHR0SDBTM1UwelFFRE1zQkV1MGhoakUrUUhS?=
 =?utf-8?B?LythQVFicHord2ZmRDFLSHV2RkVEQ1MyYUNrWnRmdUJoSkN1ejY3cVIxUTF1?=
 =?utf-8?B?K293Z1VOUDVtazJScXNveGdNZDh0dEh6S21KWmo5eDVtVTNQS2J2K1FNM09J?=
 =?utf-8?B?eFljdklQVll0Nmd5UEFEQU5SMnEwVFQ5aEMvcCsrMUltUi9jZm1IeHI4bmRM?=
 =?utf-8?B?dVlZY2dnc2k1bnJTZ3FSdFRwSW1zdGt3RGduS3I1aExMamdUdXFWa0dvU0xM?=
 =?utf-8?B?KzZ1TTJxMWpvS1MyYk9Vb29Ia0FDcmFXRUFZNkF3TEpLTno0N2JLNVdDdVVo?=
 =?utf-8?B?WGx0SStKZWhzMVRrN0VIcGVLaDRsSVlMZ0JpS1JGYXVxeW9xSTVsWE4raUgw?=
 =?utf-8?B?dVNkUEc5bTBya04wMDdjTTFtYVRVME1kWWE0c0k5ZzE4eXZFbnoxa1JuMDl5?=
 =?utf-8?B?bUhTd2VRSzJ1TGx0K2RSb2kvd2F1bUU0R2R3TDRrQ0lPUWYrVW5zK3o4Z2NV?=
 =?utf-8?B?RVo1b2QyREwybGY1VjJXVWRoY0d2aUZaOWd0T3RZMzMyZ1RGbERmRlE3OEs2?=
 =?utf-8?B?YW5OdW04K3VhS2hKT1ZlakgwSTZERzBYUzBNMWprVTUxVzUzdUpRN2VqMlRY?=
 =?utf-8?B?Vnh6OVhmbUVEb3BZeklLazNOQVVuU2FHeEtqdzQxcUYzNENIcG1zc3I4SnpI?=
 =?utf-8?B?WlZJeEpIQUo1dDRqaEpHOFRxb2k2R3E5S0g1NHJPUlhmYUdoY2NFY3FrQVVQ?=
 =?utf-8?B?U1dZM0pEdG5Mb2lUc2pqTFVKM3RnYTVocTNaY2FReWxaaHZ2Z3hMNklFQStn?=
 =?utf-8?B?am85Q3hJZUhVaUpnUnJBLzQzRlY0RFhXOHhGQmo3VmhtNG1URXAvTlhiUnZa?=
 =?utf-8?B?L2Y3Zi9aK0xrSnZaZTR1Q1loSGM4aWdSVkYxd0dFdGtNaFNFdFMzeWVQZDls?=
 =?utf-8?B?cVArK25hOVY1L0VaN1VNazVHalAwV2FuVTBTbGNNTzdob3ZraE1CSkUxK1hT?=
 =?utf-8?B?Y2I4cUhMOHdSNWdRRWM4eUhiSE00ZFU0NXpoMzJVd0tZcEN3aGREZ25kc1lO?=
 =?utf-8?B?M08vUVVHSzl1ZjJ4ZFJyend5QmgrZ3pQL2gzOFFibXR3enQ0a0dheUNvUURB?=
 =?utf-8?B?dkw1Wi84SnlqV0ZuUU9DcTVKRW15UWFQODVMbTE2ZytkSC8reTlkT1dPV0Jr?=
 =?utf-8?B?YWJsSFVOMUFWYUx2VnZ4V2d5VXgwRXNUSFhvSWNaUEs1MlFnRTl3YURZMEZn?=
 =?utf-8?B?R3JXRHVBZyszd0pZa3RqR3VKZUpaR1BZaVpaOEFZWVV1aTF6ZytXQmZLMS93?=
 =?utf-8?B?MTkwNkF0NnpJdUg5bjg3ZUJTYmhwQUYzdnV2VDI5UXlqeDZjeTYvVXR3cHJu?=
 =?utf-8?B?T3B6ZUFvRkFEdEl2SDhSTUVvczZ6c0NkMTNaNzk1QjlYVlBETWh5R05Sc0Rk?=
 =?utf-8?B?M1RPYXJEbHMxZlRpVEJmMU1qRjFyUzVENmQwTmZYNWs5UjRhT2lQWWliMHQ0?=
 =?utf-8?B?OXluM2ZKaVV0eC9PZGVmTFdFQ0s4UlhQS2Z3U2VvR3JyUHY5TGh6emdWeWE1?=
 =?utf-8?B?NVRkSXEzT3NWdjBGUmRUNEIwM25SVTUvSmprL3lSemZhMlVUOFEyUGNZVWJ6?=
 =?utf-8?B?dmpuMEE4b0VSU2liUjVNT0Q3eUM4ZVZVVTZzVWxSejRJMWxlOVFtb3Bva1R5?=
 =?utf-8?B?cjRPV1F2QWNkMmtSUUYramhxK3EvYUJTQXFaS0ZXcU11MjZvZzhTV1QrRy8v?=
 =?utf-8?B?dGdleGV5VnpHUXc1bU9iRWJxSVdNUWV4Vk8xOHZXVnVabWg2eGdxSmJDL25u?=
 =?utf-8?B?V3JKMzB2Q2xFM1JDYkJoUUI3V2g0b0RsV0U5bTUxY1lCMDNzWFVGVGpUTGww?=
 =?utf-8?B?OVcrQWM1cEFvK05nTW5yOFJ1LzB5UzFhQmMwVnVoMXRJS0l2aHlWYmZLNHQx?=
 =?utf-8?B?bHB1OUJnMkNpbVUyWkhIVEpDcTBYcHRnY0VZdXdqU0dtSm91R1pKUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d70f32-d605-4d3b-59f8-08de8019df80
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 09:29:34.5415 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ib17ieNy6Y9q0DrNznHvifaxS0E4sdGkVrfiOsUBI5NWdUaZYHt1pWkhYbgHuQQQqXNPRBs/JzOBywwZiCeytg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF7B4E3DFF8
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ8OpZHJpYyBMZSBHb2F0
ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPiBTZW50OiAxMiBNYXJjaCAyMDI2IDA4OjM3DQo+IFRvOiBT
aGFtZWVyIEtvbG90aHVtIFRob2RpIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IE5hdGhhbiBD
aGVuDQo+IDxuYXRoYW5jQG52aWRpYS5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmc7IHFlbXUt
YXJtQG5vbmdudS5vcmcNCj4gQ2M6IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPjsgRXJpYyBB
dWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPjsNCj4gWmhlbnpob25nIER1YW4gPHpoZW56aG9u
Zy5kdWFuQGludGVsLmNvbT47IFBldGVyIE1heWRlbGwNCj4gPHBldGVyLm1heWRlbGxAbGluYXJv
Lm9yZz47IFNoYW5ub24gWmhhbyA8c2hhbm5vbi56aGFvc2xAZ21haWwuY29tPjsNCj4gTWljaGFl
bCBTIC4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+OyBJZ29yIE1hbW1lZG92DQo+IDxpbWFtbWVk
b0ByZWRoYXQuY29tPjsgQW5pIFNpbmhhIDxhbmlzaW5oYUByZWRoYXQuY29tPjsgUGFvbG8NCj4g
Qm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT47IERhbmllbCBQIC4gQmVycmFuZ8OpDQo+IDxi
ZXJyYW5nZUByZWRoYXQuY29tPjsgQWxleCBXaWxsaWFtc29uIDxhbGV4QHNoYXpib3Qub3JnPjsg
RXJpYyBCbGFrZQ0KPiA8ZWJsYWtlQHJlZGhhdC5jb20+OyBNYXJrdXMgQXJtYnJ1c3RlciA8YXJt
YnJ1QHJlZGhhdC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIDEvOF0gaHcvYXJtL3Nt
bXV2My1hY2NlbDogQWRkIGhlbHBlciBmb3IgcmVzb2x2aW5nDQo+IGF1dG8gcGFyYW1ldGVycw0K
PiANCj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNo
bWVudHMNCj4gDQo+IA0KPiBIZWxsbyBTaGFtZWVyDQo+IA0KPiBPbiAzLzEwLzI2IDA5OjQwLCBT
aGFtZWVyIEtvbG90aHVtIFRob2RpIHdyb3RlOg0KPiA+DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQu
Y29tPg0KPiA+PiBTZW50OiAxMCBNYXJjaCAyMDI2IDA3OjQyDQo+ID4+IFRvOiBOYXRoYW4gQ2hl
biA8bmF0aGFuY0BudmlkaWEuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnOw0KPiBxZW11LQ0K
PiA+PiBhcm1Abm9uZ251Lm9yZw0KPiA+PiBDYzogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+
OyBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+Ow0KPiA+PiBaaGVuemhvbmcgRHVh
biA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPjsgUGV0ZXIgTWF5ZGVsbA0KPiA+PiA8cGV0ZXIu
bWF5ZGVsbEBsaW5hcm8ub3JnPjsgU2hhbm5vbiBaaGFvDQo+IDxzaGFubm9uLnpoYW9zbEBnbWFp
bC5jb20+Ow0KPiA+PiBNaWNoYWVsIFMgLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT47IElnb3Ig
TWFtbWVkb3YNCj4gPj4gPGltYW1tZWRvQHJlZGhhdC5jb20+OyBBbmkgU2luaGEgPGFuaXNpbmhh
QHJlZGhhdC5jb20+OyBQYW9sbw0KPiA+PiBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPjsg
RGFuaWVsIFAgLiBCZXJyYW5nw6kNCj4gPj4gPGJlcnJhbmdlQHJlZGhhdC5jb20+OyBBbGV4IFdp
bGxpYW1zb24gPGFsZXhAc2hhemJvdC5vcmc+OyBFcmljIEJsYWtlDQo+ID4+IDxlYmxha2VAcmVk
aGF0LmNvbT47IE1hcmt1cyBBcm1icnVzdGVyIDxhcm1icnVAcmVkaGF0LmNvbT47DQo+ID4+IFNo
YW1lZXIgS29sb3RodW0gVGhvZGkgPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPg0KPiA+PiBTdWJq
ZWN0OiBSZTogW1JGQyBQQVRDSCAxLzhdIGh3L2FybS9zbW11djMtYWNjZWw6IEFkZCBoZWxwZXIg
Zm9yDQo+IHJlc29sdmluZw0KPiA+PiBhdXRvIHBhcmFtZXRlcnMNCj4gPj4NCj4gPj4gRXh0ZXJu
YWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gPj4N
Cj4gPj4NCj4gPj4gT24gMy85LzI2IDIwOjIxLCBOYXRoYW4gQ2hlbiB3cm90ZToNCj4gPj4+IEZy
b206IE5hdGhhbiBDaGVuIDxuYXRoYW5jQG52aWRpYS5jb20+DQo+ID4+Pg0KPiA+Pj4gSW50cm9k
dWNlIHNtbXV2M19hY2NlbF9hdXRvX2ZpbmFsaXNlKCkgdG8gcmVzb2x2ZSBwcm9wZXJ0aWVzDQo+
ID4+PiB0aGF0IGFyZSBzZXQgdG8gJ2F1dG8nIGZvciBhY2NlbGVyYXRlZCBTTU1VdjMuIFRoaXMg
aGVscGVyDQo+ID4+PiBmdW5jdGlvbiBhbGxvd3MgcHJvcGVydGllcyBzdWNoIGFzIEFUUywgUklM
LCBTU0lEU0laRSwgYW5kIE9BUw0KPiA+Pj4gc3VwcG9ydCB0byBiZSByZXNvbHZlZCBmcm9tIGhv
c3QgSU9NTVUgdmFsdWVzLCB3aGlsZSBhdm9pZGluZw0KPiA+Pj4gdHJpZ2dlcmluZyBhdXRvLXJl
c29sdmVkIHZhbHVlcyBmb3IgaG90LXBsdWdnZWQgZGV2aWNlcy4NCj4gPj4+DQo+ID4+PiBBdXRv
IG1vZGUgcmVxdWlyZXMgYXQgbGVhc3Qgb25lIGNvbGQtcGx1Z2dlZCBkZXZpY2UgdG8gcmV0cmll
dmUNCj4gPj4+IGFuZCBmaW5hbGlzZSB0aGVzZSBwcm9wZXJ0aWVzLCBhbmQgd2UgZmFpbCBib290
IGlmIHRoYXQgaXMgbm90DQo+ID4+PiB0aGUgY2FzZS4NCj4gPj4NCj4gPj4gSUlVQywgUUVNVSB3
aWxsIHJlcXVpcmUgYSBtaW5pbXVtIG9mIG9uZSBQQ0kgZGV2aWNlIGlmDQo+ID4+IGFybS1zbW11
djMsYWNjZWw9b24gaXMgcGFzc2VkIG9uIHRoZSBjb21tYW5kIGxpbmUgYW5kIGlmIHRoZQ0KPiA+
PiBzbW11IHByb3BlcnRpZXMgYXJlIHNldCB0byAnYXV0bycuDQo+ID4NCj4gPiBZZXMsIHRoYXTi
gJlzIGNvcnJlY3QuDQo+ID4NCj4gPj4gSSB3b3VsZCB0cnkgdG8gZW5mb3JjZSB0aGlzIHJlcXVp
cmVtZW50IGluIHRoZSByZWFsaXplIHJvdXRpbmUuDQo+ID4+IENhbid0IHdlIGxldmVyYWdlIHRo
ZSBzdXBwb3J0c19hZGRyZXNzX3NwYWNlKCkgaGFuZGxlciA/IFNlZSA6DQo+ID4+DQo+ID4+DQo+
ID4+ICAgICAgIHN0YXRpYyBib29sIHNtbXV2M19hY2NlbF9zdXBwb3J0c19hcyhQQ0lCdXMgKmJ1
cywgdm9pZCAqb3BhcXVlLCBpbnQNCj4gPj4gZGV2Zm4sDQo+ID4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApDQo+ID4+ICAgICAgIHsNCj4g
Pj4gICAgICAgICAgIFBDSURldmljZSAqcGRldiA9IHBjaV9maW5kX2RldmljZShidXMsIHBjaV9i
dXNfbnVtKGJ1cyksIGRldmZuKTsNCj4gPj4gICAgICAgICAgIGJvb2wgdmZpb19wY2kgPSBmYWxz
ZTsNCj4gPj4NCj4gPj4gICAgICAgICAgIGlmIChwZGV2ICYmICFzbW11djNfYWNjZWxfcGRldl9h
bGxvd2VkKHBkZXYsICZ2ZmlvX3BjaSkpIHsNCj4gPj4gICAgICAgICAgICAgICBpZiAodmZpb19w
Y2kpIHsNCj4gPj4gICAgICAgICAgICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAidmZpby1wY2kg
ZW5kcG9pbnQgZGV2aWNlcyB3aXRob3V0IGFuIGlvbW11ZmQNCj4gIg0KPiA+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICJiYWNrZW5kIG5vdCBhbGxvd2VkIHdoZW4gdXNpbmcgYXJtLQ0K
PiBzbW11djMsYWNjZWw9b24iKTsNCj4gPj4gICAgICAgLi4uDQo+ID4gSG1tLi5pIGRvdWJ0IHdl
IGNhbiBkbyBpdCBoZXJlIGFzIHdlIG5lZWQgSG9zdElPTU1VRGV2aWNlSU9NTVVGRA0KPiAqaWRl
dg0KPiA+IGZvciByZXRyaWV2aW5nIHRoZSBJT01NVV9HRVRfSFdfSU5GTy4NCj4gPg0KPiA+IHN1
cHBvcnRzX2FkZHJlc3Nfc3BhY2UoKSBpcyBpbnZva2VkIHZlcnkgZWFybHkgZHVyaW5nDQo+IGRv
X3BjaV9yZWdpc3Rlcl9kZXZpY2UoKQ0KPiA+IGFuZCB0aGVyZSBhcmUgbm8gYXNzb2NpYXRlZCBp
ZGV2IGF2YWlsYWJsZSBhdCB0aGF0IHRpbWUuDQo+IA0KPiANCj4geWVzLiBIYXZlIHlvdXIgY29u
c2lkZXJlZCBhZGRpbmcgYW4gJ2lvbW11ZmQnIHByb3BlcnR5IHRvIHNtbXV2Mw0KPiBpbnN0ZWFk
ID8gSSB0aGluayB0aGlzIHNob3VsZCBzb2x2ZSBhIGxvdCBvZiBwb3RlbnRpYWwgaXNzdWVzDQo+
IGFuZCB3b3VsZCBiZSBtb3JlIG1vZGVsIGZyaWVuZGx5Lg0KPiANCj4gU29ycnkgaWYgdGhhdCB3
YXMgcHJvcG9zZWQgYWxyZWFkeS4gSSBoYXZlIGJlZW4gdGhyb3VnaCBhbGwgdGhlDQo+IGVtYWls
cy4NCg0KQXMgSSByZXBsaWVkIGluIHRoZSBvdGhlciB0aHJlYWQsIHdlIG5lZWQgYW4gaWRldiBm
b3IgcmV0cmlldmluZyBodyBpbmZvLg0KDQpbLi4uXSANCj4gPj4NCj4gPj4+ICsgICAgICAgIGV4
aXQoMSk7DQo+ID4+DQo+ID4+IFFFTVUgc2hvdWxkIG5vdCBleGl0IGluIHRoZSByZXNldCBwaGFz
ZS4gQ2FuIHRoaXMgY2hlY2sgYmUgZG9uZSBkdXJpbmcNCj4gPj4gdGhlIHJlYWxpemUgc3RhZ2Ug
Pw0KPiA+DQo+ID4gU01NVXYzIHJlYWxpemUgc3RhZ2UgaGFwcGVucyBiZWZvcmUgdGhlIGNvbGQt
cGx1Z2dlZCBkZXZpY2UNCj4gPiBzZXRfaW9tbXVfZGV2aWNlKCksIGFuZCB0aGVyZWZvcmUgd2Ug
Y2FuJ3QgY2hlY2sgd2hldGhlciB0aGUgU01NVXYzDQo+ID4gcHJvcGVydGllcyBoYXZlIGJlZW4g
cmV0cmlldmVkIGFuZCBmaW5hbGlzZWQgYXQgdGhhdCBwb2ludC4NCj4gPg0KPiA+IE5vdCBzdXJl
IHRoZXJlIGlzIGFueSBvdGhlciBwbGFjZSB3ZSBjYW4gZG8gdGhpcyBvdGhlciB0aGFuIGluIHRo
ZSByZXNldA0KPiA+IHBhdGguDQo+ID4NCj4gPiBJcyBhdm9pZGluZyBleGl0KDEpIGluIHRoZSBy
ZXNldCBwaGFzZSBhIHN0cmljdCByZXF1aXJlbWVudCBvciBhIG5pY2UgdG8NCj4gPiBoYXZlIG9u
ZT8NCj4gDQo+IHJlc2V0IGlzIGEgcnVudGltZSBoYW5kbGVyIGNhbGxlZCBhdCBlYWNoIHJlYm9v
dC4gT25lIHNob3VsZCBub3QNCj4gZXhpdC4NCj4gDQo+IFdlIHNob3VsZCB0cnkgdG8gdmVyaWZ5
IHRoYXQgdGhlIGNvbmRpdGlvbnMgdG8gcnVuIHRoZSBtYWNoaW5lDQo+IGFyZSBjb3JyZWN0IGJl
Zm9yZSByZWFjaGluZyB0aGUgcmVzZXQgcGhhc2UuDQo+IA0KDQpPay4gSW4gdGhhdCBjYXNlLCBj
b3VsZCB3ZSByZWdpc3RlciBhIHFlbXVfYWRkX21hY2hpbmVfaW5pdF9kb25lX25vdGlmaWVyKCkN
CmZvciBTTU1VdjMgYW5kIG1vdmUgdGhpcyB2ZXJpZmljYXRpb24gdGhlcmU/DQoNClRoYW5rcywN
ClNoYW1lZXINCg==

