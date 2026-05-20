Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229F0CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 14:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPham-0001Ni-AT; Wed, 20 May 2026 10:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wPhak-0001N7-At; Wed, 20 May 2026 10:08:10 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wPhai-0001TN-LB; Wed, 20 May 2026 10:08:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FOVC4aKaOII4/UwISMdfUbzzXFxu0Z0rdCkXdlTer1uXw9dH3ARyWdtx7c80HrxQPrIxmeYwmFsPrFcexwnYr4VU1UzxKNGsNofVU8hUk6qlgGS0QmYVH+e7T3H9nIEc0A5RvJgz201BlUDXpfdYZIA+k0+kwx2oR34x1OxrZBexuVdLkJq3c/k0TohLLKNf6rF27IFkbduBiMVllBd3gTj3KyP7C/7Dq73sao8CGmXUYKngyG4mmZ6GRTuvmJLmh5bHGj9qzcCAcnQ2De5zyzrbhvY73AnW5Z+tTpwJ5aJB+TFMSC//6d0CDcPlwnlQQyCJG9ivcyxi03KGVh8Q+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRr4Hv6YbbqNPy2Mh2oQ0r9EdtpgiJdypXYDljnXJw0=;
 b=Z06kXcise9OphSDBYcb/hnHCWEWS+mLJCpzRrDIpmbCzLoTJ5bEcNwTKy3glw/2ii+H3QEC3/CVjdSc9pXEmlzXsVsdm+8zHwPKMev5SgUD8HmHGXpzqb0pL/9iUu8aJRPcIA52Jm1PMIvx+55jXppArsVoTauHsH2w+G5lvxVC2hexsIVVQ7EWRRs9D5FFdbckAgmZVR1QDG7EvcL9pLMQsfYW9q1fDRLO6rJWFPN4W3oc/JxxkWX4oW2xuzF7nMGu1EknYBsKlnzEUrAcsJ2ul2FhGmspK8LFdov+qZ2eHjl2Tj7+cPY63kppJJmstYmVkAgtQRB55EzxJ1k/p1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRr4Hv6YbbqNPy2Mh2oQ0r9EdtpgiJdypXYDljnXJw0=;
 b=ay5+Jgn6MBv+CKaQLW/7ElWAC5LdrNwHdyHbKmLMFx5dm2317REzOnrUxgF3qfghGFljm9AfuVVeg4sqj3vOOlJ3aaHz0OcjzNZq6Kwt3lT7tgGtPJMDWf/FdPFBhQvr7CLckFV8D5dH05lgWVkD+/hWIO5gBOl/6pzM7haJ05LzhDxEuDX2jMdBBdg9/ZGRRUjO/ibf7zZy6tzqtmpNTATkCTjWS6Zt6bOe3Q9yE0BeAifI6Vvpns5BzA/T3zq2LY9FnnB5xMy4+zPc0FWuNXXsLNqrBnVpYD/kEHm3GhzggwH8bt/kmf7ed6cgSwg7JXXTX0ScHdTMATgroHuyjw==
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com (2603:10a6:102:412::6)
 by GVXPR09MB7858.eurprd09.prod.outlook.com (2603:10a6:150:1db::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 14:08:01 +0000
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442]) by PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442%3]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 14:08:01 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>
Subject: Re: [PATCH v9 0/7] Add RISC-V big-endian target support
Thread-Topic: [PATCH v9 0/7] Add RISC-V big-endian target support
Thread-Index: AQHc4SGJJFFTewwpskSfCNpEFr+omrYXAcYA
Date: Wed, 20 May 2026 14:08:01 +0000
Message-ID: <5d2b27bb-f8d0-4992-b8dd-719b7a17b516@htecgroup.com>
References: <20260511083819.206216-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260511083819.206216-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA2PR09MB7634:EE_|GVXPR09MB7858:EE_
x-ms-office365-filtering-correlation-id: 65a0bd24-f3be-4a7c-832f-08deb67933e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|11063799006|22082099003|18002099003|38070700021|56012099003;
x-microsoft-antispam-message-info: x9x5ThdTeHDQqYJljID8CgJ0VpkWY4bUBO2MdXmE3oY41Otc8gqf9hi9v0F54cnw4tjFP1rW+9AsZdWh2nS/QNbQhI17104Ys7SETy7W1m2OV1gWYFOjx75HBuOJM2Ek7XUWdRz6KDl6X4o+jc3tilm/gTc5JrpJVD74VPqKF6XWbldo7Rz/c9M+gzkakUcmvH/CpIvWnOwNnXNCcsmD3adXUCixpTeLvRkP+v7wVsc7BWT5RNtLLuP/dzU+eTL3TLQlzoaz0G2yaf02ERvP6q6cK0gKB0CD9zMaohzylAk7XIumhQ3XLMEhBpakAIhGC9SbeAU/I+1CCwZQB2JKMmEY1he0bV7jPkd3zGYpMkPeLEbo643urI+ErJUqhcWVxgb+0Ls3n/8EhgDHGmS3b9shnyH4jJiLOGqlehq0lVSacCfeoNwXJq+yiH5VycOSmw6TU0SUjN7OSXsR1XeEhbGYMo8TxQxqZX8Zz99lffpBBfAQepG8fxSNZplmD6c0Brognz5KPVcEpm7p1gc0AjDQmbMrP2mkM0EIDZWomVRa3fWmrlEaeCkAh56geSTa9/+gZKGiWsmUSxi2MOiqa0RQB8nCCaP3myZ2/98I1Rfd2oTDrRNdif5fkv4R7MZYJBmpr4fg0o7UCZpriIjn2CSeRZgI8gtljYJ3VeKJZvnr0I94geIK/9tRLup2AVuungxHz5IDd6sjcY5lTiRXd7GKAIr74pz3SM1KmQM4SGAqcSFJtRDz0p0j+u1TlTA5
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA2PR09MB7634.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(11063799006)(22082099003)(18002099003)(38070700021)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nm9ud1NzcmJSVkJ6ZHYrVTBVVUxWTHV3T1Y0K1ZqTDUycWEreHkvVW53TGxF?=
 =?utf-8?B?M3JJT3dRby9uVHpGOThBRzRydWtBR0JYWnVESzhGNmFtQWFyN0ROZVRraitW?=
 =?utf-8?B?WEpoeE9kRG02V1U4ZHUxV2Npam5tZlBabjZCUkxIRmJwalA5ZzJieHc3T2ln?=
 =?utf-8?B?SUNqQ2tmeW1pSHBNNW1rWGd4ZXpIY1ZhcTFvRUJFajlJMEp2NW1meUJuVE1l?=
 =?utf-8?B?UDVXelB4QnZ0R0pHWVpwaGJzUmZybkdSQUVTcTJXZ1FaVzNtcmtSNklRSGxq?=
 =?utf-8?B?M1JmR0pmV1RqZUNrRHIwMVFqV2ZNZnl2Rjl1Nkpab0d3NW1sVWVGMGx5SS9T?=
 =?utf-8?B?ZFJROE5qZXRuWXRhZ1ArcWoxYkFGWGN1ZzV0aytycmRzUGFGU2F3cDhpT1FT?=
 =?utf-8?B?LzBXRngyanB3ZFRNbThwRFZWVHJQVzZiUEE5cUNCQ21XY0lYRGlERTVPWWR6?=
 =?utf-8?B?VUoxelJuV1VEUXg1SU9SYjZIejFnR0xoU2pmakRZdTJhYjMrTHlTYmxQZ0dL?=
 =?utf-8?B?eml2MklOZW1TMlE5TTVpclZOR21FekkzZGczWlhSb0tKSmN0QzVCM3JmOGdN?=
 =?utf-8?B?c1JnREpaRHhCd2VXQ2pNNVVtL0VobVdXYWh6VXR3bUdJNTdQV3VCS0xPaXZp?=
 =?utf-8?B?dEVSMGdST1JoQmtWM0sxTW1PWUZyMDFaamdTZ09MaVpWMmNlMUsvSDJGanlK?=
 =?utf-8?B?aitybjd3VDJMVXFqc1RQQ01XVUhmdC95UU0wMWo4OURNOGM2WCtML1N5NDRk?=
 =?utf-8?B?VDQ2SzhjWkJKVFRVQW1IRUcxeGRYVlJUQ3krS093dkpSREVDUHNwM0doVUNv?=
 =?utf-8?B?UlQ2ejNiUDRtWHdkbitLL1dSb1VtMVBzUGxoNm95VHhnU3NnRC95YnRkV2VE?=
 =?utf-8?B?MlRBaFNEZ2NGMkRwc1dha0p0dXFxcHEva2pWenhySTZvSkZNOHYxMy8rVlZ3?=
 =?utf-8?B?bEFaVGFnc2ZNdTFycGd6ZGV1aXIvcU1iUXlWMUZqaFFISzdIQ2IzRy9pdk9M?=
 =?utf-8?B?cWxZaElrdGhJYkE2bDRCVTN0eEw5and1bjhvbFZXaTdqbS8zZVdJV2Mxb2du?=
 =?utf-8?B?eU9FS2JJbWFnRy8rVitVdVpBYjhORG1mM3pmM3VFTXVodlF3WjNueDlhRkZY?=
 =?utf-8?B?M2xSVE9Qdkg1bVpzSFNpTkhmTnpkOGltczZTYnV1WGltNVIvZFJZcXNvM2w2?=
 =?utf-8?B?RzZISnlCRFZBNE0xZ1NXc1g1cUJkeFN0eWI5RzlEN1RpTktUZ3FURUdKeDFR?=
 =?utf-8?B?NG8yWXJlanlJYXFwM3ROOEd4UC9QL3N0K1ZyazV2OXkzZ2JkSVZiMmJaZ2dD?=
 =?utf-8?B?QTJEZi90cERhQjgyVm9UNUNLMTRxbmtPaWhpWDhJbWN3VGxhMVhmYU9CM0tk?=
 =?utf-8?B?Tno4WDdhS1J1RU1qdGdha3R4TWdXSUJSUk5PTDhpQUd3dVNpVWlZQmtkcWE1?=
 =?utf-8?B?UFlHUXphTkxvbTNxdGcvcU4rNnNFeUdXYUNTd1diMXA4VC9ValFKb1gvVGpW?=
 =?utf-8?B?eFc5ZlVRU285QnBRL1pmWHNoU2FLaGsxeXlLQVIxTDV0eUZseFFRVDZkRG5u?=
 =?utf-8?B?aXVIQ3VsTXVTYlg0ZnYvdmpYSFBTd0dOaWVmZ2VWZzEzWWgySkpuVEo3SzlB?=
 =?utf-8?B?Wi9SYjhkbnBYSDc1S29QNGl6MVd1czVFeTg4YnZiM09CdGlRVng5amE5MENE?=
 =?utf-8?B?OEFSN0dtbzNkczdpUWJrVngzQ0VDVG94K2IvdmtYNEtiMkVOZGVHelF3MGZr?=
 =?utf-8?B?S2FBMGVyekNDeE84SWE2UzFXZko0SmFUL1grQjRXVVd3UkYxNzFoM2FZUklT?=
 =?utf-8?B?TzZNYXBzZ1pqeWJZZDNiZnRONkZtY3FJRDkrYmVWaXc3bzY4ckh5K1Rkam90?=
 =?utf-8?B?TlU1SXpxeWNvVXQrN1RTdXkxckxtVlRVU3llbS81VUk3VWkyaEhzcG55T2d4?=
 =?utf-8?B?aERuMjh0UWxCQ3RBeGdYZFd5WU1kaGtQWWtJcXRkMXpHM1hsNWlMN2Z0Ly9y?=
 =?utf-8?B?NXVhbEg1T2ZCSzhzZ05reHNzUjJLRWovR2o5emliNnU5YjZsdllta0kvQlNI?=
 =?utf-8?B?Q1ZzcUg0VkdYa0lnQWhWbHAyQzRhckY2UHh3TmJHT3FFRGZxWGtRVjZnTG5l?=
 =?utf-8?B?U1VhWi9iODNYb21vaUl0MnE4cEUvRjlQODdNWHJxUU9rSnVzZGQ5djIzbHFh?=
 =?utf-8?B?Z2hzaVFKbSttYmRZWjRpM0ZCR0xCeUdhMnQ1d1RubXc1NzhDVGREbitGekRk?=
 =?utf-8?B?L3NRVWowcnJHOElJdUw2WlYyT2RxUFZKWW91SWo4bG8rT254Zy92L0RkYnF3?=
 =?utf-8?B?RisySGcrYTk1eU9tWlNiUm1WMFYvQ0ptdHVTN2x0eDZaQTNnQmw5QTlJZTgv?=
 =?utf-8?Q?wZvyAYLxIBJLQ1NvpSyxx8yNdy/TKMyNDifDY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <75F89ACFF671614A9075CA42D4B91883@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA2PR09MB7634.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a0bd24-f3be-4a7c-832f-08deb67933e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 14:08:01.0597 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W1D7K2c4bdos3AvhjGgt7di+N5s0qEI6e1QowdTKqNPZfCHKrmgcaI8h3EQmNLIL+W6wVNR2iYYvp31EBGTVZAtWU1Iz7YvBiyXZAdv81bQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR09MB7858
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
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

SGkgYWxsLA0KDQpJIGFtIHdvbmRlcmluZywgaWYgdGhlcmUgaXMgYW55IGNvbW1lbnQgb24gdjku
IDopDQoNClRoYW5rcyBhIGxvdCENCkRqb3JkamUNCg0KDQpPbiA1LzExLzI2IDEwOjM4LCBEam9y
ZGplIFRvZG9yb3ZpYyB3cm90ZToNCj4gUmViYXNlIG9uIHRvcCBvZiBtYXN0ZXIuDQo+DQo+IERq
b3JkamUgVG9kb3JvdmljICg3KToNCj4gICAgdGFyZ2V0L3Jpc2N2OiBEZWZpbmUgTVNUQVRVU19T
QkUgYW5kIE1TVEFUVVNfTUJFIGJpdCBtYXNrcw0KPiAgICB0YXJnZXQvcmlzY3Y6IEFkZCBiaWct
ZW5kaWFuIENQVSBjb25maWd1cmF0aW9uIGZpZWxkIGFuZCByZXNldCBsb2dpYw0KPiAgICB0YXJn
ZXQvcmlzY3Y6IEltcGxlbWVudCBydW50aW1lIGRhdGEgZW5kaWFubmVzcyB2aWEgTVNUQVRVUyBi
aXRzDQo+ICAgIGh3L3Jpc2N2OiBNYWtlIGJvb3QgY29kZSBlbmRpYW5uZXNzLWF3YXJlIGF0IHJ1
bnRpbWUNCj4gICAgdGFyZ2V0L3Jpc2N2OiBGaXggcGFnZSB0YWJsZSB3YWxrIGVuZGlhbm5lc3Mg
Zm9yIGJpZy1lbmRpYW4gaGFydHMNCj4gICAgdGFyZ2V0L3Jpc2N2OiBFeHBvc2UgYmlnLWVuZGlh
biBDUFUgcHJvcGVydHkgYW5kIGFkZCBkb2N1bWVudGF0aW9uDQo+ICAgIHRhcmdldC9yaXNjdjog
QWRkIGVuZGlhbm5lc3MgdGVzdCBmb3IgUklTQy1WIEJFDQo+DQo+ICAgZG9jcy9zeXN0ZW0vdGFy
Z2V0LXJpc2N2LnJzdCAgICAgICAgICAgICAgICAgIHwgMjQgKysrKysrDQo+ICAgaHcvcmlzY3Yv
Ym9vdC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgODEgKysrKysrKysrKysrKysr
Ky0tLQ0KPiAgIGluY2x1ZGUvaHcvcmlzY3YvYm9vdC5oICAgICAgICAgICAgICAgICAgICAgICB8
ICAxICsNCj4gICB0YXJnZXQvcmlzY3YvY3B1LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAxMSArLS0NCj4gICB0YXJnZXQvcmlzY3YvY3B1LmggICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAyMyArKysrKysNCj4gICB0YXJnZXQvcmlzY3YvY3B1X2JpdHMuaCAgICAgICAgICAgICAg
ICAgICAgICAgfCAgMiArDQo+ICAgdGFyZ2V0L3Jpc2N2L2NwdV9jZmdfZmllbGRzLmguaW5jICAg
ICAgICAgICAgIHwgIDEgKw0KPiAgIHRhcmdldC9yaXNjdi9jcHVfaGVscGVyLmMgICAgICAgICAg
ICAgICAgICAgICB8IDI4ICsrKysrLS0NCj4gICB0YXJnZXQvcmlzY3YvaW5zbl90cmFucy90cmFu
c19ydmEuYy5pbmMgICAgICAgfCAgNCArLQ0KPiAgIHRhcmdldC9yaXNjdi9pbnNuX3RyYW5zL3Ry
YW5zX3J2ZC5jLmluYyAgICAgICB8ICA0ICstDQo+ICAgdGFyZ2V0L3Jpc2N2L2luc25fdHJhbnMv
dHJhbnNfcnZmLmMuaW5jICAgICAgIHwgIDQgKy0NCj4gICB0YXJnZXQvcmlzY3YvaW5zbl90cmFu
cy90cmFuc19ydmkuYy5pbmMgICAgICAgfCAgOCArLQ0KPiAgIHRhcmdldC9yaXNjdi9pbnNuX3Ry
YW5zL3RyYW5zX3J2emFjYXMuYy5pbmMgICB8ICA0ICstDQo+ICAgdGFyZ2V0L3Jpc2N2L2luc25f
dHJhbnMvdHJhbnNfcnZ6YWxhc3IuYy5pbmMgIHwgIDQgKy0NCj4gICB0YXJnZXQvcmlzY3YvaW5z
bl90cmFucy90cmFuc19ydnpjZS5jLmluYyAgICAgfCAgNCArLQ0KPiAgIHRhcmdldC9yaXNjdi9p
bnNuX3RyYW5zL3RyYW5zX3J2emZoLmMuaW5jICAgICB8ICA0ICstDQo+ICAgdGFyZ2V0L3Jpc2N2
L2luc25fdHJhbnMvdHJhbnNfcnZ6aWNmaXNzLmMuaW5jIHwgIDQgKy0NCj4gICB0YXJnZXQvcmlz
Y3YvaW5zbl90cmFucy90cmFuc194bWlwcy5jLmluYyAgICAgfCAgOCArLQ0KPiAgIHRhcmdldC9y
aXNjdi9pbnNuX3RyYW5zL3RyYW5zX3h0aGVhZC5jLmluYyAgICB8IDE2ICsrLS0NCj4gICB0YXJn
ZXQvcmlzY3YvaW5zbl90cmFucy90cmFuc196aWxzZC5jLmluYyAgICAgfCAgNCArLQ0KPiAgIHRh
cmdldC9yaXNjdi9pbnRlcm5hbHMuaCAgICAgICAgICAgICAgICAgICAgICB8ICA5ICstLQ0KPiAg
IHRhcmdldC9yaXNjdi90Y2cvdGNnLWNwdS5jICAgICAgICAgICAgICAgICAgICB8ICAzICsNCj4g
ICB0YXJnZXQvcmlzY3YvdHJhbnNsYXRlLmMgICAgICAgICAgICAgICAgICAgICAgfCAyMiArKy0t
LQ0KPiAgIHRlc3RzL2Z1bmN0aW9uYWwvcmlzY3Y2NC9tZXNvbi5idWlsZCAgICAgICAgICB8ICAx
ICsNCj4gICB0ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2NjQvdGVzdF9lbmRpYW5uZXNzLnB5ICAgfCA1
NyArKysrKysrKysrKysrDQo+ICAgMjUgZmlsZXMgY2hhbmdlZCwgMjUxIGluc2VydGlvbnMoKyks
IDgwIGRlbGV0aW9ucygtKQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9mdW5jdGlvbmFs
L3Jpc2N2NjQvdGVzdF9lbmRpYW5uZXNzLnB5DQo+

