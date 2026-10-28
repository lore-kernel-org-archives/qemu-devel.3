Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2150A606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bull.com header.i=@bull.com header.a=rsa-sha256 header.s=mail header.b=K2ATwpDD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM3tt-00019f-1p; Wed, 28 Oct 2026 09:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1xM3tL-00017G-GW
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 09:40:38 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1xM3tJ-00089Y-A0
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 09:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1793194833; x=1824730833;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=9gOe1+UZ4SQG+cb8DbL98nlG2ZEQkqNoCODs5fWmd90=;
 b=K2ATwpDDagl+Dvzq3weREM8+lAHwt9ob8OiOmmikYvd31a00sUzZi1CP
 WFenlyCaR1rohQucEP+Lclz2VOaV0PVEJgMfrqt2CnvBDvqJTqLhuxXK1
 qvyA5fQ87ftw49S9izyDEKtfZncvcAd+abLJlCKV6N5e8PAh+SUgKTO3M
 B1C9D7q2vhZgD//CHLh/dMgxfeXXdrJvBFiJklizA/X2cmZcK9YzFF1cj
 4NxKiSk7RrAEpb55ryNU/64n7UtWqqZzc6tUcHljbcWpb2A3BtMy/PVRQ
 HDc8DjebxJd+4NW4Ljq/ucgvTFY8fbyHgXHmfpMHq4tKpjzudLsXeSfJb A==;
X-CSE-ConnectionGUID: C0ienXogQAao8QBtd9zARg==
X-CSE-MsgGUID: oatxsyDQTRa+qJmNwTZARw==
IronPort-SDR: 6ae1fb4a_8vlMQ9cfPOGA7CtbSKpmXEEFz5QCzsElVa/lImYgBbWNt2Z
 u3yRoDQuwmkSSNfj7EY+yvb6IzSnLhezsfIF8BQ==
X-IronPort-AV: E=Sophos;i="6.27,182,1787004000"; d="scan'208";a="49042948"
X-MGA-submission: =?us-ascii?q?MDEAvzrTaq3wO2UEdP60yky/gYjotvRf6QA7rY?=
 =?us-ascii?q?FD+dStMDnmh54kP4HYwLs8b7F5d9GebvpFpVROn+9qX139T+x7SnwWI3?=
 =?us-ascii?q?dpaKufwb7W5sicccOhWyMRw4uzHGqS37bZq7Oh9+kJmvttIpo5FE1ld4?=
 =?us-ascii?q?9l+mZVfqwp9U+0VPMvQjeNuQ=3D=3D?=
Received: from mail-westeuropeazon11013004.outbound.protection.outlook.com
 (HELO AM0PR02CU008.outbound.protection.outlook.com) ([52.101.72.4])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 28 Oct 2026 14:40:26 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYQPIZ9AkkQ3/massmguuvRolRuGPz5ZgRaymfbDFwd1FZqW2PTObg68q8BpoVtxZsHG24FfXNZ6tR9sL4cAhdZkKTlEPfHgoO9ACJwQQBWv43wkZAhuDMK/Bk8MxVnIDmCm4foeMiyERg07rIjQIrOGC5lF48c6FoYy+OGqL4L9VQ/I6FELKH4OSKkGKstYvrVmvZ6j/BEVzsmwe9eWmpugesfMAV8t4MxPHdWV+wOFH0MFIwW6jLPzf2gljYI1bGQG/93K96cbwkwYFqZJ5gZ63WCLilcc1dPoQXThUIQGg1VxlsZUH6xJYV3wLtMOzl6G+vyyP4eOxTrfkCzZiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gOe1+UZ4SQG+cb8DbL98nlG2ZEQkqNoCODs5fWmd90=;
 b=nnz8p9B/nYWQUqoKMVyXh6JOxi3Cuu/yo8oGRvaVHVuVVVKfE8V4zpu+cE6xYWYxk9Lp/Gx9nnQ1RluuMhIyw58ES/tyDKqQMXqGlPDrhnulIg07mJSjg60IZcb99BEtoCj8VA3RWzX8GMxVaUJ44aYkTODaxHKc3/STZFXzvkofZGysuIROaMmZfyxOUOMWVKqw0cPgxZcIHa3CSNqVaQcFVcYoeB0kfMiK72Z8s59TonjAdNOdXcchOi5Uydmj4uAR9bWaN2wRZBUa5JxQyAOQGETRtn782pIGol/C3qryRUtIIbJ2ejLW7MmTuzVfmrZAd55gWpa2W3PGEZt39w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by GV4PR07MB11313.eurprd07.prod.outlook.com (2603:10a6:150:2da::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 13:40:24 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 13:40:24 +0000
From: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "odaki@rsg.ci.i.u-tokyo.ac.jp" <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH] pcie_sriov: Avoid capability structure overflow in PF
 reset
Thread-Topic: [PATCH] pcie_sriov: Avoid capability structure overflow in PF
 reset
Thread-Index: AQHdSY5ZcmZDGZMVw0GjF8dGChIOELcTKWYAgAAHQIA=
Date: Wed, 28 Oct 2026 13:40:24 +0000
Message-ID: <c86e267518a07ddf993127c0427dce1543410b4f.camel@bull.com>
References: <20260921055917.715685-1-clement.mathieu--drif@bull.com>
 <20261028091349-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261028091349-mutt-send-email-mst@kernel.org>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bull.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|GV4PR07MB11313:EE_
x-ms-office365-filtering-correlation-id: d8cffa77-168c-4dca-624c-08df34f904cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|261026140227099003|38070700021|11063799006|4143699003|56012099006|261026121527099003|261022075727099003|261009223027099003|261022105027099003|10067099003|261021121427099003|261021123027099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: 8uz4ddBlkIbKQvkkmwka5a5v3Z1YsjVtvnKvaMNrLwt6FS+tXDDsIqnD/u3TyEv3LcCx6flNmkU/oqKUy1vUabaHtC0Gazf2iXLuXDUK+GpDpeWLAivLIZKHYkGAzbXx/TqHklC3eYeiK83Nscr7osY03OsGESm9/x1PwSygEv76MCVpBLkJoHC4EfAzF1Cr3SHUAPRR3yHzsW5/fNOc6YIuFHRAlGDFmUfWymtHgUj6GILKUfF/yiMFAsJW2M1+ozA/5B2Uz/+Axwu4BAdntW0Dh0Lmyi0nY+ARNFDSaKcp1ME4dK6wjNUabYOOe08o62u2ThR3NNbEKaGAHHWKO96sLI/igS0GqDpcpePSW4nmCvVw9WUf2aAC+bPhpYI4zeXFHeft4wLDp6HN2mDYrzqRC4YZ0WPnLTbcvio/uNd2SjPMXh48CxYqB/kwnbeTnnkjghve3/XZIFUw0OV0kKrJO8XTJJmwmrdrxT3wQgBfR/JDF0ulojUEU4uf5kKw0s9XNgZugpIUpLyFicnhwSjnSPsyu36X8qxyrdVqZxkitxBKyipLbHCQd7eqrsXh7wV5sZQFZBf82Hdgad1CzGQhmoS24gruuq3sZaH95Vso1Rr2omCR/oG0fsnGXK6ghm0u986j7XWUY6f7CKBXHyST0VU7aQISU+GG++W9ZnLMZ2DVLUKzEqjcddVTtIyPSZnTSwCr+Mze4P0BPj3EdRfljMsD7C+x3j1vEvQB2k8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(261026140227099003)(38070700021)(11063799006)(4143699003)(56012099006)(261026121527099003)(261022075727099003)(261009223027099003)(261022105027099003)(10067099003)(261021121427099003)(261021123027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MzlWZ1l3VnovYW45bnNMd25KMW5tYUpSMkUvZzJDYjJIY29vWFNzdDB3TVdw?=
 =?utf-8?B?aUVmcVhzTnpWZVYvbTZVMm5IVWVZWXR6dnhNdzRBSVBtWTdPWStwK0pKVVFv?=
 =?utf-8?B?UXdDWURlanNGRXd4SW56UEsvSUJGbmZzbEMzVlU4NjN0UVBiTGZmYzV2TVdn?=
 =?utf-8?B?V21PNVNjSVNrZDRtNXY0cVdqYzNHNytNTUpHUUZCUlFFZm9LQllBWG1rUUVP?=
 =?utf-8?B?ZDlHMXdqYmNSN1NaY3BtMmd2cWlxMlVINmFYYVo2VzZVSnRNMmlTR1FnSXpq?=
 =?utf-8?B?dkNycWk3bzVSS0VrcEI4SnZzY25vRDREVFlhNkhrNHZKY25RMzhHZ0ZVdlBU?=
 =?utf-8?B?TUsvUVpkQmxmSTdvVENoMTdwaW9Ic2pvT1ZQT3BHbVdtbGY4TnVmMFdwWHo2?=
 =?utf-8?B?akYzbEV0elIwc3NnQTlwemgwbDN1YmxILzNPVG85R0lwS2ZETDZpalBHWWwy?=
 =?utf-8?B?SkhORjhtQk9IYkYzVlRrcTg4SzdJTFdEcDFTZUc2M29NM0JiZmtsbkEwU09Q?=
 =?utf-8?B?RDY1MXZhZ1RwSG9MbFdBNlpHbGlRcGh1R0x5N0VZZ3VIZlFyL0J5M29sRmFk?=
 =?utf-8?B?aHNzWDFkQ1g4RFhsalk0M1NFMkJ1V0RBYXl4aG4yRy9jNklrQmk1Znlqbzl1?=
 =?utf-8?B?S2p4Rmk5cXE3eHNjTW4xblNLczdiQTN5SzA5Ny9PQ2l3bmZna2xQMklyUkUw?=
 =?utf-8?B?MkZhKzBmZnZ6WnptNW5hb0VnYmxvcjFiSU5ZUkgxZUpmL2tKWkJ6TVlIVHJT?=
 =?utf-8?B?NDlod2dycmducWdaMUVqSzhlbHA4TUtnM3ByNzArWEIydW5Tc3hQWkN1cTgw?=
 =?utf-8?B?eTJ2MDM4emhEOFNZVUE1OTFYcG9kMmVxQ2xrWlB4anN5UXpvWE01bjRCOSt1?=
 =?utf-8?B?QmhtSTlmR3MrTnJWSXBiTkJ6NUdIR2drUXFpYWZHSXNEZGF1cWdwNVgrS1pB?=
 =?utf-8?B?dFRSQXVIVUxFeGYrTjQvbUp3SkVoc2VPQnFoU01RRjN0Qmp1bE9Rd3hFZ1Js?=
 =?utf-8?B?TEMvbGN0T3hGRUdZYnJnakYxWkttOEhoazlrOEJyZXpnOFd5ck11M1ZTUUVC?=
 =?utf-8?B?NENiQS9WTWZxWVltcTdaMWpVVEk5MG0wUkFxQ0JjeU5QakFwSFowS3VlNHhQ?=
 =?utf-8?B?MllPN1lBUk1ONWJwOTg5VDFKM2FEelVCK2Y0Rk8xOHg1cFNuMnE3bGdLZFJV?=
 =?utf-8?B?ZE1jai9lSytHWFIyYWNPekdMN3VVOTZUb3VxZzRyR29aZHllSmRaTjBrNVZM?=
 =?utf-8?B?N2lhNXBtc2JoSkJJbmJBUFZLZHZTZ1Q0WGhwd2t3Yi9JQjZaV0xYSHZWNy9O?=
 =?utf-8?B?c3hQUWxkS21SUUFGR2kxWWRMaDZrbml5N2N1UDdYVjJ5d1FnMk1LOFEwQzB0?=
 =?utf-8?B?QWJ3QnRJc1pvb28xVnVMbld6NUdHSTE4VldlT0dvVnI4aklESjJVMVdDUm1z?=
 =?utf-8?B?VFV4V2FYUUJ0clI5elEwTllIS1NXcjBtREFYaEJtV3ZhV2ZPK1RWeUt3dld3?=
 =?utf-8?B?b0MrZk05WHNvbU9oWHRiMVA1YnlvQVd0MUFiNzNjeXNpbjRXS2Vod3M2dTYz?=
 =?utf-8?B?ekplVFZOTy9GOFM5dzZLd2xHTVNkWEJtdHpKYWN1dUVEQktuT3NhSnVhTkVx?=
 =?utf-8?B?OGhhcjFPYTJqc01OTEZxelNCRTc3Z21MWWl1QUFGb0FlczVJMEg0OU56RnRi?=
 =?utf-8?B?SVdBMTM1VXMrZjBqY0tMM1puRzFzeXR4WnhEZUJDcTJkWTVtS2FyL21zemJw?=
 =?utf-8?B?SXZYUlppQnl4Rzh4dEtIVXBSQ3RYZFVxUFJFM0FWYkNFaUg0RzFOMWlaYUFJ?=
 =?utf-8?B?MlNvNkhXL1ZjUDhJM1VWcHJ3ZjlzaDRRaDJaVEUwR0xOWTNlcWp0SEdxWjdk?=
 =?utf-8?B?WGwvYXJJTnh4YS9RaGNjdklBamlEOWMrNzBBQ0t3ajd0NnlLYnN3c1JaUkdG?=
 =?utf-8?B?b2hBTXZHUUFVb3BHMUp3VVVJZkM5bFM3WHIrN1c1aU0xU1VuVnRQaEtPdTdj?=
 =?utf-8?B?dmlWWHdqZVdOZ1A3UFczZEcwZUREQWdrelZIYnpKY2Nud2hHVDZuNlVCcUFB?=
 =?utf-8?B?V0NVbjhWQUxnQVdPL0FtSm1hQXJpTWJWakRFaitPQm1JZ3EyUEJPSEFBOXcz?=
 =?utf-8?B?WVJyaU43dmxOT09Ga0R1enpvS3FHRS9LdStpcXEvS3QwM3oyV3A0SkNQREJP?=
 =?utf-8?B?VXh0YnVzc3F2V24wUklWWlVHdFNSZWtMaXpCS0x5YmNaTjdGcEFMVE9ZakJj?=
 =?utf-8?B?eWsxendMR2htbkNWenFJaWNrWThYQ0oxUjdFNlVGMXJlejhMMVRlT3ZSMk9L?=
 =?utf-8?B?dlV3eTMyWHM5L1RsU1F1R24raU53SWlnZkI5TWR2d1lodG1mZWRFenJXeGN1?=
 =?utf-8?Q?CahcEEYJ6jZSz5zU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <049C3A99461CF54FBEFEC4EF95A91293@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DWNRj/fdW9XRBni2/Af5bGXF5msyhrVlDFl+yHyq/vAzSIgP1ogmMqjypN+W3ppryERSvBvy3FjhylerkRnP6fnZ1OStkq/T9IW/jfFWxWWDeM18EF8Q5KQTjX0OQtZ3P2/Ejt2DDw9NdzJBZ9v8xpESE+MQkYaoMjlsRmNHMiVWuomdj3jGUpzqe3W5eAdfZ84ZBCFufjMOYY8hoqVk4JfeSW3PQFYS+uMkXaDIM2t0MMphvpimd+kC/MCxGDOOAOTQCX2ERbygqJ3eZPU9HbL+Lsw4Q56DjLYY8TbEbW1xT4PSZAuP38wNo0KShNnKj+t8IMaVXK3WaonspFQIGA==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8cffa77-168c-4dca-624c-08df34f904cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 13:40:24.0896 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KWLQDf2WWtw7rfUSoEB/dqbP1znrbYe9aRPgSymHAL1jTjYwBkSYkKueFjc81HQhVZgg8ddqTxLvri0suSCX9X7PBgSpodTS1kKJpjlEIPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR07MB11313
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost2.eviden.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DQpPbiBXZWQsIDIwMjYtMTAtMjggYXQgMDk6MTQgLTA0MDAsIE1pY2hhZWwgUy4gVHNpcmtpbiB3
cm90ZToNCj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRz
IG9yIGNsaWNrIGxpbmtzLCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2Vu
ZGVyIGFuZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gDQo+IE9uIE1vbiwg
U2VwIDIxLCAyMDI2IGF0IDA1OjU5OjIzQU0gKzAwMDAsIENsw6ltZW50IE1BVEhJRVUtLURSSUYg
d3JvdGU6DQo+IA0KPiA+IFRoZSBTUi1JT1YgUENJZSBjYXBhYmlsaXR5IGV4cG9zZXMgNiByZWdp
b25zIChubyBST00pLCBlYWNoIHdpdGggYQ0KPiA+IGRlZGljYXRlZCAzMi1iaXQgY29uZmlndXJh
dGlvbiBmaWVsZC4gRml4IHRoZSByZXNldCBsb29wIHRvIHdyaXRlDQo+ID4gMzIgYml0cyBpbnN0
ZWFkIG9mIDY0IGJpdHMgYW5kIHN0b3AgYWZ0ZXIgUENJX1NSSU9WX05VTV9CQVJTIGl0ZXJhdGlv
bnMuDQo+ID4gDQo+ID4gQXMgYSBzaWRlIGVmZmVjdCBvZiB0aGlzIGNoYW5nZSwgdXBkYXRlIFBD
SUVTcmlvdlBGOjp2Zl9iYXJfdHlwZQ0KPiA+IHRvIG1hdGNoIHRoZSBudW1iZXIgb2YgcmVnaW9u
cyBleHBvc2VkIGJ5IFNSLUlPViBhbmQgcmV3b3JrIHRoZQ0KPiA+IGFzc29jaWF0ZWQgYXNzZXJ0
IHN0YXRlbWVudHMuDQo+ID4gDQo+ID4gRml4ZXM6IGM4YmM0ZGI0MDNlMSAoInBjaWVfc3Jpb3Y6
IFJlc2V0IFNSLUlPViBleHRlbmRlZCBjYXBhYmlsaXR5IikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBD
bGVtZW50IE1hdGhpZXUtLURyaWYgPFtjbGVtZW50Lm1hdGhpZXUtLWRyaWZAYnVsbC5jb21dKG1h
aWx0bzpjbGVtZW50Lm1hdGhpZXUtLWRyaWZAYnVsbC5jb20pPg0KPiANCj4gDQo+IEkgcXVldWVk
IGFub3RoZXIgcGF0Y2ggZml4aW5nIHRoaXMsIHlvdXJzIHdpbGwgYmVjb21lIGEgY2xlYW51cC4g
IA0KPiBPbmNlIG15IHB1bGwgaXMgbWVyZ2VkLCBwbHMgcmViYXNlIGFuZCByZXBvcnQuDQo+IA0K
PiBUaGFua3MhDQoNCkhpIE1pY2hhZWwsDQoNCkRvIHlvdSB3YW50IHZlcnNpb24gcmViYXNlZCBv
biBtYXN0ZXIgb3IgYW5vdGhlciByZWY/DQoNCmNtZA0KDQo+IA0KPiANCj4gPiAtLS0NCj4gPiDC
oGh3L3BjaS9wY2llX3NyaW92LmPCoMKgwqDCoMKgwqDCoMKgIHwgOSArKysrKy0tLS0NCj4gPiDC
oGluY2x1ZGUvaHcvcGNpL3BjaWVfc3Jpb3YuaCB8IDIgKy0NCj4gPiDCoDIgZmlsZXMgY2hhbmdl
ZCwgNiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQg
YS9ody9wY2kvcGNpZV9zcmlvdi5jIGIvaHcvcGNpL3BjaWVfc3Jpb3YuYw0KPiA+IGluZGV4IGM0
MWFjOTViZWUuLmRmNjFmMjgxZWEgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvcGNpL3BjaWVfc3Jpb3Yu
Yw0KPiA+ICsrKyBiL2h3L3BjaS9wY2llX3NyaW92LmMNCj4gPiBAQCAtMjI5LDggKzIyOSw3IEBA
IHZvaWQgcGNpZV9zcmlvdl9wZl9pbml0X3ZmX2JhcihQQ0lEZXZpY2UgKmRldiwgaW50IHJlZ2lv
bl9udW0sDQo+ID4gDQo+ID4gwqDCoMKgwqAgYXNzZXJ0KHNyaW92X2NhcCA+IDApOw0KPiA+IMKg
wqDCoMKgIGFzc2VydChyZWdpb25fbnVtID49IDApOw0KPiA+IC3CoMKgwqAgYXNzZXJ0KHJlZ2lv
bl9udW0gPCBQQ0lfTlVNX1JFR0lPTlMpOw0KPiA+IC3CoMKgwqAgYXNzZXJ0KHJlZ2lvbl9udW0g
IT0gUENJX1JPTV9TTE9UKTsNCj4gPiArwqDCoMKgIGFzc2VydChyZWdpb25fbnVtIDwgUENJX1NS
SU9WX05VTV9CQVJTKTsNCj4gPiANCj4gPiDCoMKgwqDCoCB3bWFzayA9IH4oc2l6ZSAtIDEpOw0K
PiA+IMKgwqDCoMKgIGFkZHIgPSBzcmlvdl9jYXAgKyBQQ0lfU1JJT1ZfQkFSICsgcmVnaW9uX251
bSAqIDQ7DQo+ID4gQEAgLTM0NCw2ICszNDMsOCBAQCBpbnQxNl90IHBjaWVfc3Jpb3ZfcGZfaW5p
dF9mcm9tX3VzZXJfY3JlYXRlZF92ZnMoUENJRGV2aWNlICpkZXYsDQo+ID4gwqDCoMKgwqAgZGV2
LT5leHAuc3Jpb3ZfcGYudmYgPSB2ZnM7DQo+ID4gwqDCoMKgwqAgZGV2LT5leHAuc3Jpb3ZfcGYu
dmZfdXNlcl9jcmVhdGVkID0gdHJ1ZTsNCj4gPiANCj4gPiArwqDCoMKgIGFzc2VydCh2ZnNbMF0t
PmlvX3JlZ2lvbnNbUENJX1JPTV9TTE9UXS5zaXplID09IDApOw0KPiA+ICsNCj4gPiDCoMKgwqDC
oCBmb3IgKGkgPSAwOyBpIDwgUENJX05VTV9SRUdJT05TOyBpKyspIHsNCj4gPiDCoMKgwqDCoMKg
wqDCoMKgIFBDSUlPUmVnaW9uICpyZWdpb24gPSAmdmZzWzBdLT5pb19yZWdpb25zW2ldOw0KPiA+
IA0KPiA+IEBAIC00NjMsOCArNDY0LDggQEAgdm9pZCBwY2llX3NyaW92X3BmX3Jlc2V0KFBDSURl
dmljZSAqZGV2KQ0KPiA+IMKgwqDCoMKgwqAgKi8NCj4gPiDCoMKgwqDCoCBwY2lfc2V0X3dvcmQo
ZGV2LT5jb25maWcgKyBzcmlvdl9jYXAgKyBQQ0lfU1JJT1ZfU1lTX1BHU0laRSwgMHgxKTsNCj4g
PiANCj4gPiAtwqDCoMKgIGZvciAodWludDE2X3QgaSA9IDA7IGkgPCBQQ0lfTlVNX1JFR0lPTlM7
IGkrKykgew0KPiA+IC3CoMKgwqDCoMKgwqDCoCBwY2lfc2V0X3F1YWQoZGV2LT5jb25maWcgKyBz
cmlvdl9jYXAgKyBQQ0lfU1JJT1ZfQkFSICsgaSAqIDQsDQo+ID4gK8KgwqDCoCBmb3IgKHVpbnQx
Nl90IGkgPSAwOyBpIDwgUENJX1NSSU9WX05VTV9CQVJTOyBpKyspIHsNCj4gPiArwqDCoMKgwqDC
oMKgwqAgcGNpX3NldF9sb25nKGRldi0+Y29uZmlnICsgc3Jpb3ZfY2FwICsgUENJX1NSSU9WX0JB
UiArIGkgKiA0LA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBkZXYtPmV4cC5zcmlvdl9wZi52Zl9iYXJfdHlwZVtpXSk7DQo+ID4gwqDCoMKgwqAgfQ0KPiA+
IMKgfQ0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3BjaS9wY2llX3NyaW92LmggYi9pbmNs
dWRlL2h3L3BjaS9wY2llX3NyaW92LmgNCj4gPiBpbmRleCBiMGVhNmE2MmM3Li41ZjgxZTNiMWJi
IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvaHcvcGNpL3BjaWVfc3Jpb3YuaA0KPiA+ICsrKyBi
L2luY2x1ZGUvaHcvcGNpL3BjaWVfc3Jpb3YuaA0KPiA+IEBAIC0xNiw3ICsxNiw3IEBADQo+ID4g
wqAjaW5jbHVkZSAiaHcvcGNpL3BjaS5oIg0KPiA+IA0KPiA+IMKgdHlwZWRlZiBzdHJ1Y3QgUENJ
RVNyaW92UEYgew0KPiA+IC3CoMKgwqAgdWludDhfdCB2Zl9iYXJfdHlwZVtQQ0lfTlVNX1JFR0lP
TlNdO8KgwqAgLyogU3RvcmUgdHlwZSBmb3IgZWFjaCBWRiBiYXIgKi8NCj4gPiArwqDCoMKgIHVp
bnQ4X3QgdmZfYmFyX3R5cGVbUENJX1NSSU9WX05VTV9CQVJTXTvCoMKgIC8qIFN0b3JlIHR5cGUg
Zm9yIGVhY2ggVkYgYmFyICovDQo+ID4gwqDCoMKgwqAgUENJRGV2aWNlICoqdmY7wqDCoMKgwqAg
LyogUG9pbnRlciB0byBhbiBhcnJheSBvZiBudW1fdmZzIFZGIGRldmljZXMgKi8NCj4gPiDCoMKg
wqDCoCBib29sIHZmX3VzZXJfY3JlYXRlZDsgLyogSWYgVkZzIGFyZSBjcmVhdGVkIGJ5IHVzZXIg
Ki8NCj4gPiDCoH0gUENJRVNyaW92UEY7DQo+ID4gLS0NCj4gPiAyLjU1LjANCj4gDQo+IA==

