Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6248A1125842
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LjF-0007jJ-A5; Wed, 11 Mar 2026 11:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w0Lj1-0007gh-U3; Wed, 11 Mar 2026 11:43:56 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w0Liy-0008VH-Pk; Wed, 11 Mar 2026 11:43:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jkHDdFB0Wzd9A6EJosVoxkFfAc31KjkPDg/rA0gVblSUMovm/QS2zFmKLlDLTsSClG1hTTGJX88bvqDUMd59f9hSQ3iO5rljGquWfxKlgv4M8xUau3laPFZhdH59ZBUmBQbGL+FV4ANTOuczVLyoGzDpyaZi+R6lc5B2vGgAEuxsSFXJkrRZzcO58F+pGBzKQvsZeYS//GuDEFZ/oE8Wz0vEGcpqPfp0KhOIUHu8kWwySdau5gXaJTp/4TVER6F2oh6OSoGNeT9TKDjo42LjeGOP+O0qsZuGDNbvF7pTFwtCvvTuKUofEqW2Ao1D99GMS8uzfVF+IU4rTaWECG9wwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrPkBKtH8iPoHHR5nU+HYG7J8LT7+kL4Nk9M17NbYeg=;
 b=d1vzppYzNWHwe9aQpkcblTwujUlta99oe1dp9jpp75gQ/puLPAQbJ36OvnGG7BV06rrUm2/MXJDfxApJbArdhcmqnGwaMNSE3BsGzPToXO+wZdcHWooEbBio9D807qSQwXO7fNU3Pc5f7NnIfc0BZXTMQc/f/HPEAFgmh7CW2QOlU3Z8aNisENqO3JSqb9kJ42/U+3TAowGy2pf4PfWXBddDzxFuZqMPtkqQRpusxfLdm7++zyFj8vwymsoW/vCs3RPd6JRuyfIDXzP2lotmdpcRk3clL7RCtxIryHamzsY7DeLQtmQri2lSYDSe/1ziL53Z4Hqu+bREWLeZyCmd6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrPkBKtH8iPoHHR5nU+HYG7J8LT7+kL4Nk9M17NbYeg=;
 b=FW2o6goW7kjxm46U/3aRVXjianyNHCGYNg6xTRuTohWQb6in3xZqabzpYcy/cUcPBVJpzaBlKOn6xxfslqDCo/3xYjnR48wfIYYBEcjR5elCwTxDxbf23d3eBC72w1K1Os6dTIyxxFP6i0E9wLZl3BUzrtctRD5MXGH7oQB8m5q3svsa1j2+AOYjnuWCNTv+Wd9L5DAyBBJVQH2/bFDdMAOEr2TfCNjLx9TOIQTtYHQLM7RHq78CCxoLpdGCedrSRF/fePy+afGxdtQ1cPh6PtxXy1j58K4rjf0tcLZ8pL35BMx5U1BCXN+h8VP4Ga2eN8MT1IV06q+Pvk3Rw9j9dw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CH2PR12MB4119.namprd12.prod.outlook.com (2603:10b6:610:aa::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 15:43:44 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 15:43:44 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>,
 "phrdina@redhat.com" <phrdina@redhat.com>
Subject: RE: [PATCH v3 20/32] hw/arm/tegra241-cmdqv: Use mmap'ed VINTF page0
 as VCMDQ backing
Thread-Topic: [PATCH v3 20/32] hw/arm/tegra241-cmdqv: Use mmap'ed VINTF page0
 as VCMDQ backing
Thread-Index: AQHcpw4b2rZE8IjCjEq5Rs6l3XhHkrWpf2KAgAAEmIA=
Date: Wed, 11 Mar 2026 15:43:44 +0000
Message-ID: <CH3PR12MB75480FCD6AEC642953678EF8AB47A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
 <20260226105056.897-21-skolothumtho@nvidia.com>
 <f4267f2a-4fe7-4c87-ad11-9632a33a5d3b@redhat.com>
In-Reply-To: <f4267f2a-4fe7-4c87-ad11-9632a33a5d3b@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CH2PR12MB4119:EE_
x-ms-office365-filtering-correlation-id: 5e9de52e-ab5e-4621-b285-08de7f84fa28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 5XtR4pgjQhiPIL3d5qS6qWR8mZEcx3s2CxVYgcKPDiP4qzvh5TnzX6iPsHqYFU3EICygG+X8odJM2zrCdPUAa68RQx5hVyndsVBKlcMo+hLAl79khmK+yUEz/GXWHJhUvmGuSZoMJl/rPWvuymGgRGf2eZhUhR2uMrdKqagmJUhqIdzGWRH7hm5HmQQuXrL5BgQWtFyDfUHlLpYpnarZcC1GEPxtCZHcILBMolOiswP35Cdlsn9l9f4kQveglpfZznwqttlczWDH9DaAJczpx6ZG+Arcx6Jsd6FwBw/M025B9DQxJEKhPsd1WqA6P8FHmLpf1v7elCsuwRB1lrcckWBETCF/5snRpbiiGllloJjrXVarXu5ga74/wv67Kz5POSj0SCeNtmy45YsWwo+92xwHlPNWZ0FKTjGPwliK7fHgJKTIlLT8t7ew+k5YBbQP4XoIY/+Gq43zjzs1VifVB/o7Fe1f+/W3Fxv0q5Oq+oVoSXuqfOnqfR93MGbYmyKDRuBlRAlJcD9wCTvawHXDVWbLTZ4fNuF9atX3qJB3NWo7TzGywmTHJqaM+oP8RnO2tM7TAXJ2fE1NNaR73qylFzAHyJ/wRM93+ThN3oBSplj46iPxy5JQQ1MDuT7gBbO615hVM4EXx05CRcGw25V+qz8EZkGwy/xuTEDdtBoFwfWoRnhjrQmywZmKkCnNsvYDJ66uK8cBWpSCmoeusjXGJeh+z0W4W5dOMwMATDNJdeLjacTqVcUOAHVVezb2EpSPWqLy12CXwhJhWyvFLPBUHMFGK3ygPGEQCHozX7Dtons=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkF0TE44V3BQVUFIUjd1ZkdhUy84NGFCTmhlZjN2NHZ1SEZMeEZTT3k0RWIz?=
 =?utf-8?B?QmhFS0xGclFpdlRUUmUyVXpJeGpUR0drd2xFNFJtNGtacWtuU2pOQ1YwRnhl?=
 =?utf-8?B?TkV0dVVjd2QwYVFMYjlEUTRSQ1VuY2pUOGJPd1NVT0cxQUdLZjFCNnFmNjFR?=
 =?utf-8?B?VWJ1VVJETHdtOVdKb1lZVktVeTFaVE04bDJTeHkzVlVESWwvdU0xZkhhNlpp?=
 =?utf-8?B?QXUwM2NzV0lKRGJ2L2ZESWlONFFCWnY4UkFKUFM0ZVBteXRibERXWjNiSVZK?=
 =?utf-8?B?NVhkdFhMVjBySVhJWFNnUjVFcExmeHExU00yUkFuY1hLakZvV2s1RDRhTjdC?=
 =?utf-8?B?WTF1dFpkeitGNFVhZGdZK0U5dWtXcFdJLzhmcUk2RzRmWVBNdy8wYWE0N3NT?=
 =?utf-8?B?MHhEbTNROE1TSzdkTDYvOEVnajV3NURwSWR4Z2xRakZzM0g3K3R1YWs4MVQz?=
 =?utf-8?B?SnY1NTF1VEVEZ3R6UnJmWlMyNXN6VnBsay93a3RJczZCUXZXWmdMQmgxbUNt?=
 =?utf-8?B?b2hyZFVKNUtaL0IrVmZIZTdxOGEvanVDemtXbXdsbVVLTVJzYjU5Z2xXWWpF?=
 =?utf-8?B?Q0NhQWNiSXNxdUUzTk1weW9JTGpyY2Z5eFlOMnRoK05lZytSSTdWTjVuRVhK?=
 =?utf-8?B?UlJWOGVQWm5FUXBuSW13OHZwd1lrWTRaanFEV3kxUlk3OFZBeWhUbk5IcWNj?=
 =?utf-8?B?TmxtOFkvQkoyVlUyc3Z2TGhiZ1BlZldhbXR3OWN4aHMzVUh0MEZlTUtZckxs?=
 =?utf-8?B?UHFNV3BQNkNuazVUUEw3ZTVETUk0TDMzbi9HbmZkZ0NXWlBqRlVjalhBck5M?=
 =?utf-8?B?eHpncXlQODZRT1hXamhZQXdBMEFvNGlQeEdSTC9LZ1M3Ulk4UG51RHJ3dTdm?=
 =?utf-8?B?ZWFBd3YzOS9DZTltREVIZU8rYmw3TjFBYm9HK3dtZ1ZLbDZmV2t4VlM2dWFY?=
 =?utf-8?B?N211RWhXVlVabEVhRU53b0k3YlJnNlNKKzhaUG1sbVlGd1dSU1FhRlB2aUN6?=
 =?utf-8?B?dTJQQzNud2xPMlB4bytJV2V2ZWJXbmROWjRLNFE3ckJpUnBmK3poYkZnalM3?=
 =?utf-8?B?Ulc0dFUxVzBCempFQzJXRS9ZWm5sajdsKy9Jc01OMUo3UDFCN1Y0NjFEVmlm?=
 =?utf-8?B?SnNCNEVlUTB4UTA1SDJqNmhxNk9hdVliREdkVnFWNTkxWXRRVUczcUpTbDZn?=
 =?utf-8?B?emhkV3hEVmhDa3A2SHN3TXhYNVArV2Ivbk5sbkZ5akpCMjB1ckRKYnZIWEI4?=
 =?utf-8?B?SzYwaHBFV0pVODN6Q29adXVUR1M2dU42YXlFVkp3V0NwdE1KdFB4dGdmekNK?=
 =?utf-8?B?RGN5N21uMlRCQTAyeGhSVGx0QXQ0M2N3aHk2d1FhNUVzT1ZTVysvc1dUQzZX?=
 =?utf-8?B?a3RMVXMwM2xYWXlEYllYb0E2QmNqMXlUTUZXRU96M3VldkIxSDlpUjJOVUNW?=
 =?utf-8?B?RXFucGQ2bzRRdEFzdTdTaERiYkNVbVVmK0g5ZGtqbUhBczByS2p0RS9qbW5M?=
 =?utf-8?B?cU4yejdPbDlQaUZLOHNsMTJwd2JrRm5CdlVHNWxKOVA5b1YzOW5aeno1YWky?=
 =?utf-8?B?S2RpZGdwVTkvbnRodGZKdXFVTTYzVnk0TDVGNnEyV2JxODZsMkhsN1NXb052?=
 =?utf-8?B?dHZ5SUFSZ1lxbTBVUWd6a05UdjhTa2FiWXU4d1UvcTVFeXdVdUVJY3pCT0RR?=
 =?utf-8?B?VzZZUzB1dzMrV2FIZktXdUMwMDlBZWQrM29Lb3hoNGx2MlgyRER5TmV0NTNh?=
 =?utf-8?B?ei9PUVZZQUxtaFUzTDhKcHBnYWlpT1lycEFxTnA4b2pvS0JwOEk0SUd2SHox?=
 =?utf-8?B?dzZpS0ZaY0dIbExuVk4rVi9HcU81M0o2Vyt5SlRwaDVPRzd3MW5IVCtSM3dW?=
 =?utf-8?B?VXpOek05Z2Y1V2VtMzF2T1prc2FMUmlWb292amxJY2FkeHQ3K01VZUE1V0Nr?=
 =?utf-8?B?UEJtVjM3WElOQms2RUVHTk1RalpyMlExZ1lwVkxLMkxvRDFKTU5CbExWVVli?=
 =?utf-8?B?bFFZWitoUERpbTU3UGxOS3JTZ2hnT01id3ZvbUlmR202WjBHMWZPbzFrc0dj?=
 =?utf-8?B?aHRnQ1I0bWtORXRtMW1CbTNrTTBOeUMxK2VMN2ZOWUtuOHhxQWJiVU1NNjRT?=
 =?utf-8?B?RlRzOTc5SCttOTcxdUFIejlRY0trQTdOUlBFTnorUVQyNmpyZ1YyclRzamRa?=
 =?utf-8?B?TytRZjNpWlgxKzhkelczRXZUN3FEZEtvam00TC9wWDdkUHlqVHNTMmhjTE1n?=
 =?utf-8?B?TEhaOHRDL0FWME1rTWpnMTdQRmZNWnFKalNEUitNUzJiWE1DVG1QWldCbmtC?=
 =?utf-8?B?Z2loWGhkQ0Vhd3NQU0NWbUFhWUJWYTBUYkl3c0VzZEFUYmRqSElKUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e9de52e-ab5e-4621-b285-08de7f84fa28
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 15:43:44.1372 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IK6NarfaIkC3A+WKXyFVck+Vvq+eGPMcVvgw0c40KT5jFAJg0iKAsWXzfShTL6mHsONCL6Wxch67Z1do29c4LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4119
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAxMSBNYXJjaCAyMDI2IDE0OjUzDQo+IFRvOiBT
aGFtZWVyIEtvbG90aHVtIFRob2RpIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IHFlbXUtDQo+
IGFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IHBldGVyLm1heWRl
bGxAbGluYXJvLm9yZzsgY2xnQHJlZGhhdC5jb207IGFsZXhAc2hhemJvdC5vcmc7IE5pY29saW4N
Cj4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT47IE5hdGhhbiBDaGVuIDxuYXRoYW5jQG52aWRp
YS5jb20+OyBNYXR0DQo+IE9jaHMgPG1vY2hzQG52aWRpYS5jb20+OyBKaWFuZGkgQW4gPGphbkBu
dmlkaWEuY29tPjsgSmFzb24gR3VudGhvcnBlDQo+IDxqZ2dAbnZpZGlhLmNvbT47IGpvbmF0aGFu
LmNhbWVyb25AaHVhd2VpLmNvbTsNCj4gemhhbmdmZWkuZ2FvQGxpbmFyby5vcmc7IHpoZW56aG9u
Zy5kdWFuQGludGVsLmNvbTsgS3Jpc2huYWthbnQgSmFqdQ0KPiA8a2phanVAbnZpZGlhLmNvbT47
IHBocmRpbmFAcmVkaGF0LmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDIwLzMyXSBody9h
cm0vdGVncmEyNDEtY21kcXY6IFVzZSBtbWFwJ2VkDQo+IFZJTlRGIHBhZ2UwIGFzIFZDTURRIGJh
Y2tpbmcNCj4gDQo+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9y
IGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gT24gMi8yNi8yNiAxMTo1MCBBTSwgU2hhbWVlciBLb2xv
dGh1bSB3cm90ZToNCj4gPiBXaGVuIGEgVkNNRFEgaXMgYWxsb2NhdGVkIGFuZCBWSU5URiBwYWdl
MCBoYXMgYmVlbiBtbWFwJ2VkIGZyb20gdGhlDQo+ID4ga2VybmVsLCBhY2Nlc3MgdGhlIFZDTURR
IHJlZ2lzdGVycyBkaXJlY3RseSB0aHJvdWdoIHRoZSBWSU5URiBwYWdlMA0KPiA+IGJhY2tpbmcg
aW5zdGVhZCBvZiB1c2luZyBRRU1VJ3MgY2FjaGVkIHJlZ2lzdGVyIHN0YXRlLg0KPiA+DQo+ID4g
VklOVEYgcGFnZTAgcHJvdmlkZXMgdGhlIGJhY2tpbmcgbWVtb3J5IHJlZ2lvbiBmb3IgVkNNRFEg
cmVnaXN0ZXJzDQo+ID4gb25jZSBhIGhhcmR3YXJlIHF1ZXVlIGlzIGNyZWF0ZWQuIEluIHRoYXQg
Y2FzZSwgcmVhZHMgYW5kIHdyaXRlcw0KPiA+IHNob3VsZCByZWZsZWN0IHRoZSBsaXZlIGJhY2tp
bmcgc3RhdGUuDQo+ID4NCj4gPiBJZiBhIFZDTURRIGlzIG5vdCBhbGxvY2F0ZWQsIG9yIGlmIFZJ
TlRGIHBhZ2UwIGlzIG5vdCBhdmFpbGFibGUsDQo+ID4gY29udGludWUgdG8gdXNlIHRoZSBjYWNo
ZWQgcmVnaXN0ZXIgdmFsdWVzIG1haW50YWluZWQgYnkgUUVNVS4NCj4gQnV0IGlmIGJvdGggY29l
eGlzdCBzaG91bGRuJ3QgeW91IGFsc28gc3luYyBlbXVsYXRlZC9tbWFwZWQgVklOVEYgQ01EUVYu
DQo+IFNvbWVob3cgdGhpcyBtZWFucyB0aGF0IHlvdSBoYXZlIDMgc3RhdGVzIG9mIHRoZSBzYW1l
IENNRFFWOiB0aGUNCj4gZ2xvYmFsL2RpcmVjdCBvbmUsIHRoZSBlbXVsYXRlZCBWSSBDTURRViBh
bmQgdGhlIG1tYXBwZWQgVkkgQ01EUVYNCj4gKGhvc3QNCj4gYmFja2VkKS4NCj4gSXMgdGhpcyB1
bmRlcnN0YW5kaW5nIGNvcnJlY3Q/DQoNClllcy4gSG93ZXZlciwgaW4gdGhlIGN1cnJlbnQgaW1w
bGVtZW50YXRpb24gdGhlIFZDTURRIGlzIGZ1bmN0aW9uYWxseQ0KdmFsaWQgb25seSBpZiBRRU1V
IHN1Y2Nlc3NmdWxseSBzZXRzIHVwIHRoZSBWSU5URiBwYWdlMCBtbWFwIGFuZCBjcmVhdGVzDQph
IGJhY2tpbmcgVkNNRFEgdGhyb3VnaCB0aGUgSFdfUVVFVUUgaW9jdGwuDQoNCkFsbCBvdGhlciBj
YXNlcyBpdCBqdXN0IHVzZXMgdGhlIGNhY2hlZCByZWdpc3RlcnMgZm9yIE1NSU8gcmVhZC93cml0
ZS4NCg0KTWF5YmUgd2Ugc2hvdWxkIGV4cG9zZSBzdWNoIGZhaWx1cmVzIHRvIHRoZSBndWVzdCwg
YnkgaW5qZWN0aW5nIGFuIGVycm9yDQpvciBieSBzZXR0aW5nIFNUQVRVUy9DT05GSUcgdG8gaW5k
aWNhdGUgdGhhdCB0aGUgVkNNRFEgaXMgbm90IGZ1bmN0aW9uYWwuDQoNClJlZ2FyZGluZyBrZWVw
aW5nIHRoZSBHbG9iYWwgVkNNRFEgYW5kIHRoZSBWSSBDTURRIGluIHN5bmMgYWx3YXlzLCB0aGlz
DQp3b3VsZCBvbmx5IGJlIHBvc3NpYmxlIGlmIHdlIGRvIG5vdCBtYXAgKHRlZ3JhMjQxX2NtZHF2
X2d1ZXN0X21hcF92aW50Zl9wYWdlMCkNCnRoZSBWSU5URiBQYWdlMCBpbnRvIGd1ZXN0IG1lbW9y
eS4gT25jZSBpdCBpcyBtYXBwZWQsIGFjY2Vzc2VzIHRvIHRoZSANClZJIENNRFEgKGNvbnRyb2wv
c3RhdHVzIHJlZ2lzdGVycykgbm8gbG9uZ2VyIHRyYXAgdG8gUUVNVS4NCg0KSG93ZXZlciwgbm90
IG1hcHBpbmcgaXQgaXMgbm90IGFkdmlzYWJsZSBhcyBpdCB3b3VsZCBodXJ0IHBlcmZvcm1hbmNl
LA0Kc2luY2UgZXZlcnkgQ09OUy9QUk9EIGluZGV4IHVwZGF0ZSB3b3VsZCB0cmFwIHRvIFFFTVUu
DQoNClRoYW5rcywNClNoYW1lZXINCg0KPiBUaGFua3MNCj4gDQo+IEVyaWMNCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPg0K
PiA+IC0tLQ0KPiA+ICBody9hcm0vdGVncmEyNDEtY21kcXYuYyB8IDQ3DQo+ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0NiBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvYXJt
L3RlZ3JhMjQxLWNtZHF2LmMgYi9ody9hcm0vdGVncmEyNDEtY21kcXYuYw0KPiA+IGluZGV4IDAw
MmRkZTUwZmMuLjE3Yjk1NTI5MDYgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJtL3RlZ3JhMjQxLWNt
ZHF2LmMNCj4gPiArKysgYi9ody9hcm0vdGVncmEyNDEtY21kcXYuYw0KPiA+IEBAIC0xNCwxNyAr
MTQsNDQgQEANCj4gPiAgI2luY2x1ZGUgInNtbXV2My1hY2NlbC5oIg0KPiA+ICAjaW5jbHVkZSAi
dGVncmEyNDEtY21kcXYuaCINCj4gPg0KPiA+ICtzdGF0aWMgaW5saW5lIHVpbnQzMl90ICp0ZWdy
YTI0MV9jbWRxdl92aW50Zl9wdHIoVGVncmEyNDFDTURRVg0KPiAqY21kcXYsDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgaW5kZXgsIGh3
YWRkciBvZmZzZXQwKQ0KPiA+ICt7DQo+ID4gKyAgICBpZiAoIWNtZHF2LT52Y21kcVtpbmRleF0g
fHwgIWNtZHF2LT52aW50Zl9wYWdlMCkgew0KPiA+ICsgICAgICAgIHJldHVybiBOVUxMOw0KPiA+
ICsgICAgfQ0KPiA+ICsNCj4gPiArICAgIHJldHVybiAodWludDMyX3QgKikoY21kcXYtPnZpbnRm
X3BhZ2UwICsgKGluZGV4ICogMHg4MCkgKw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAo
b2Zmc2V0MCAtIDB4MTAwMDApKTsNCj4gPiArfQ0KPiA+ICAvKg0KPiA+ICAgKiBSZWFkIGEgVkNN
RFEgcmVnaXN0ZXIgdXNpbmcgVkNNRFEwXyogb2Zmc2V0cy4NCj4gPiAgICoNCj4gPiAgICogVGhl
IGNhbGxlciBub3JtYWxpemVzIHRoZSBNTUlPIG9mZnNldCBzdWNoIHRoYXQgQG9mZnNldDAgYWx3
YXlzIHJlZmVycw0KPiA+ICAgKiB0byBhIFZDTURRMF8qIHJlZ2lzdGVyLCB3aGlsZSBAaW5kZXgg
c2VsZWN0cyB0aGUgVkNNRFEgaW5zdGFuY2UuDQo+ID4gICAqDQo+ID4gLSAqIEFsbCBWQ01EUSBh
Y2Nlc3NlcyByZXR1cm4gY2FjaGVkIHJlZ2lzdGVycy4NCj4gPiArICogSWYgdGhlIFZDTURRIGlz
IGFsbG9jYXRlZCBhbmQgVklOVEYgcGFnZTAgaXMgbW1hcCdlZCwgcmVhZCBkaXJlY3RseQ0KPiA+
ICsgKiBmcm9tIHRoZSBWSU5URiBwYWdlMCBiYWNraW5nLiBPdGhlcndpc2UsIGZhbGwgYmFjayB0
byBjYWNoZWQgc3RhdGUuDQo+ID4gICAqLw0KPiA+ICBzdGF0aWMgdWludDY0X3QgdGVncmEyNDFf
Y21kcXZfcmVhZF92Y21kcShUZWdyYTI0MUNNRFFWICpjbWRxdiwNCj4gaHdhZGRyIG9mZnNldDAs
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCBpbmRl
eCkNCj4gPiAgew0KPiA+ICsgICAgdWludDMyX3QgKnB0ciA9IHRlZ3JhMjQxX2NtZHF2X3ZpbnRm
X3B0cihjbWRxdiwgaW5kZXgsIG9mZnNldDApOw0KPiA+ICsNCj4gPiArICAgIGlmIChwdHIpIHsN
Cj4gPiArICAgICAgICBzd2l0Y2ggKG9mZnNldDApIHsNCj4gPiArICAgICAgICBjYXNlIEFfVkNN
RFEwX0NPTlNfSU5EWDoNCj4gPiArICAgICAgICBjYXNlIEFfVkNNRFEwX1BST0RfSU5EWDoNCj4g
PiArICAgICAgICBjYXNlIEFfVkNNRFEwX0NPTkZJRzoNCj4gPiArICAgICAgICBjYXNlIEFfVkNN
RFEwX1NUQVRVUzoNCj4gPiArICAgICAgICBjYXNlIEFfVkNNRFEwX0dFUlJPUjoNCj4gPiArICAg
ICAgICBjYXNlIEFfVkNNRFEwX0dFUlJPUk46DQo+ID4gKyAgICAgICAgICAgIHJldHVybiAqcHRy
Ow0KPiA+ICsgICAgICAgIGRlZmF1bHQ6DQo+ID4gKyAgICAgICAgICAgIGJyZWFrOw0KPiA+ICsg
ICAgICAgIH0NCj4gPiArICAgIH0NCj4gPiArDQo+ID4gICAgICBzd2l0Y2ggKG9mZnNldDApIHsN
Cj4gPiAgICAgIGNhc2UgQV9WQ01EUTBfQ09OU19JTkRYOg0KPiA+ICAgICAgICAgIHJldHVybiBj
bWRxdi0+dmNtZHFfY29uc19pbmR4W2luZGV4XTsNCj4gPiBAQCAtMjUwLDExICsyNzcsMjkgQEAg
c3RhdGljIGJvb2wNCj4gdGVncmEyNDFfY21kcXZfbW1hcF92aW50Zl9wYWdlMChUZWdyYTI0MUNN
RFFWICpjbWRxdiwgRXJyb3INCj4gKiplcnJwKQ0KPiA+ICAgKg0KPiA+ICAgKiBUaGUgY2FsbGVy
IG5vcm1hbGl6ZXMgdGhlIE1NSU8gb2Zmc2V0IHN1Y2ggdGhhdCBAb2Zmc2V0MCBhbHdheXMgcmVm
ZXJzDQo+ID4gICAqIHRvIGEgVkNNRFEwXyogcmVnaXN0ZXIsIHdoaWxlIEBpbmRleCBzZWxlY3Rz
IHRoZSBWQ01EUSBpbnN0YW5jZS4NCj4gPiArICoNCj4gPiArICogSWYgdGhlIFZDTURRIGlzIGFs
bG9jYXRlZCBhbmQgVklOVEYgcGFnZTAgaXMgbW1hcCdlZCwgd3JpdGUgZGlyZWN0bHkNCj4gPiAr
ICogdG8gdGhlIFZJTlRGIHBhZ2UwIGJhY2tpbmcuIE90aGVyd2lzZSwgdXBkYXRlIGNhY2hlZCBz
dGF0ZS4NCj4gPiAgICovDQo+ID4gIHN0YXRpYyB2b2lkDQo+ID4gIHRlZ3JhMjQxX2NtZHF2X3dy
aXRlX3ZjbWRxKFRlZ3JhMjQxQ01EUVYgKmNtZHF2LCBod2FkZHIgb2Zmc2V0MCwNCj4gaW50IGlu
ZGV4LA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50NjRfdCB2YWx1ZSwgdW5z
aWduZWQgc2l6ZSwgRXJyb3IgKiplcnJwKQ0KPiA+ICB7DQo+ID4gKyAgICB1aW50MzJfdCAqcHRy
ID0gdGVncmEyNDFfY21kcXZfdmludGZfcHRyKGNtZHF2LCBpbmRleCwgb2Zmc2V0MCk7DQo+ID4g
Kw0KPiA+ICsgICAgaWYgKHB0cikgew0KPiA+ICsgICAgICAgIHN3aXRjaCAob2Zmc2V0MCkgew0K
PiA+ICsgICAgICAgIGNhc2UgQV9WQ01EUTBfQ09OU19JTkRYOg0KPiA+ICsgICAgICAgIGNhc2Ug
QV9WQ01EUTBfUFJPRF9JTkRYOg0KPiA+ICsgICAgICAgIGNhc2UgQV9WQ01EUTBfQ09ORklHOg0K
PiA+ICsgICAgICAgIGNhc2UgQV9WQ01EUTBfR0VSUk9STjoNCj4gPiArICAgICAgICAgICAgKnB0
ciA9ICh1aW50MzJfdCl2YWx1ZTsNCj4gPiArICAgICAgICAgICAgcmV0dXJuOw0KPiA+ICsgICAg
ICAgIGRlZmF1bHQ6DQo+ID4gKyAgICAgICAgICAgIGJyZWFrOw0KPiA+ICsgICAgICAgIH0NCj4g
PiArICAgIH0NCj4gPiArDQo+ID4gICAgICBzd2l0Y2ggKG9mZnNldDApIHsNCj4gPiAgICAgIGNh
c2UgQV9WQ01EUTBfQ09OU19JTkRYOg0KPiA+ICAgICAgICAgIGNtZHF2LT52Y21kcV9jb25zX2lu
ZHhbaW5kZXhdID0gdmFsdWU7DQoNCg==

