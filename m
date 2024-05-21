Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B9AC25B7A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 13:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9PI7-0008MC-TY; Tue, 21 May 2024 09:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9PHk-00080I-Rh
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:12:09 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9PHX-0001aP-Jn
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:12:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1716297115; x=1747833115;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=DCiJkhq21aLilYfmazBpuY1RUfcOG8K07TIGqnYLIIA=;
 b=xO/veNJoRZ7S6utpdlVBTLEGHsnWnPAZiiJeVv40Xghcb95Cq/wf3m0P
 AUT4o8zfv7jemswo8pMhGbTSRvGJyKDLDm8WURxoFbW1BR55qcx7RHnQw
 nc+7UFBe3QzEihKxc5mRtPn08ivj04fNbr4LEaWoR1ZnTa38TqgJSxlo/
 I/1qt13yZHR5ZWB80VjcFvmvM7LAnUYWZBZgoDhpsyo1tLrCG5xhC2Eqj
 tTAJUOku4FZG9L4L4ioRPd/KW/bC0iMF5JjvUPArBn1kie5MWPPWaAHav
 7rz/4ZMNsZ8Eeo/+RESJqZGcWpRCyOuVGYRiSgrd9tApt3UTaT5L0hNdG A==;
X-IronPort-AV: E=Sophos;i="6.08,177,1712613600"; d="scan'208";a="13008007"
X-MGA-submission: =?us-ascii?q?MDHmFhhalvjWrzQ0fRygSkGcqSE7GLc4sCcutQ?=
 =?us-ascii?q?k7xsrOgK8IdFXakGlcISYnQoECxYBVQ+UAbsWCKiy4I9G9BddpY+Jtay?=
 =?us-ascii?q?A0odMub8+ii9bIIp3wSJb+0mBUHT808JcQEypRk8YQtExHPyMwqVWTEI?=
 =?us-ascii?q?MQTkHo531AGoHheBWssESfmQ=3D=3D?=
Received: from mail-dbaeur03lp2169.outbound.protection.outlook.com (HELO
 EUR03-DBA-obe.outbound.protection.outlook.com) ([104.47.51.169])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 15:11:49 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSurGjSpYJECA4rF5phkaFv9S5/FehR9YSEOqmG5dvKKHbD9BAS/mABy+m6fcEOm1BPA4tndT/dvdjQQtwd3Da2L48oWAoJORhzA9i3NTIZBxR2yHOWQiVE/IGPbgTy3Bl5spj//EoxwS8zFGN3mve6DVuf16TBIJbngxVkd2xPuyWSmCJqlr8mMziuDiVx6IF9cyYnoLWahQpep20ymEk0ze05pQHwuOXR58DILg/ZfXRLpao+QQtU0l6VemYpqaAGwX9mut4brCuebMGvSH/Pq0IZEU+Drto6f3OhwiVySW7uSk3DcyzwmAyhgeDIlSnCQVe95gz4ip5VQtfUaUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCiJkhq21aLilYfmazBpuY1RUfcOG8K07TIGqnYLIIA=;
 b=Zi8MhFCYW6HjQO4INFy51gKSThX8dMshjGCDe10c1qD8awmJ6phoHvOi1BnCuhhQ6ySPSO9i8aMs+fNff4pQvarjiSFzb5jQUKkkDD7zz9v1eR9DOhQcIG9unbijMgck/HoOd4vKESn6biAQcXgfuaFezVJTmFCwqb83n3vAqwKS2zfK/xNU5tsX6RKvPlyHJMbF5OeutvKflFIn03gpOgoCHtiPyeMmTy1DDtsQrlTDJgvBJNtV4h9lWErh63TaWS4zAg2EfzYPBD588RY+SRQDMVTjVzM8BA5JqMVNhAcpK3TxEn9ZkM3abTu3wt8C6d9bdeMnWJbQPEjBMmPsvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB8PR07MB6249.eurprd07.prod.outlook.com (2603:10a6:10:140::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Tue, 21 May
 2024 13:11:48 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 13:11:48 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd 14/22] intel_iommu: implement the
 get_memory_region_pasid iommu operation
Thread-Topic: [PATCH ats_vtd 14/22] intel_iommu: implement the
 get_memory_region_pasid iommu operation
Thread-Index: AQHaq4BvLD9RdICWlkC5j/mZ2ctG3w==
Date: Tue, 21 May 2024 13:11:48 +0000
Message-ID: <20240521130946.117849-15-clement.mathieu--drif@eviden.com>
References: <20240521130946.117849-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240521130946.117849-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB8PR07MB6249:EE_
x-ms-office365-filtering-correlation-id: b29a5b42-be93-4a89-b206-08dc79979241
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?L2dnYTNRSkRWQjF6OVZCOGRtZlBhMTN3TlBWMHFNbFVwbU5kNUxTMmRtem0y?=
 =?utf-8?B?ZHpyampIVjVaTzRiNldrN0pveXBHOStRNXVEOGVSK3dRK2Q1Vk01a25WQith?=
 =?utf-8?B?OUNqVmx3bnpBcks2OWxtSmhhS0NQK25MWGgyTkJrVkpoeXM0eXc1KzFzbENF?=
 =?utf-8?B?ZGgreStyS0ZjY0lMSFpEQXhkRS9VRkFBVnpmSk54djh4RXNNa2pBaXZEc0J2?=
 =?utf-8?B?RThmemlPZmh1MVRMa1hBK0lndDVuRWM0SXpNSFJpTWdzWVhKenRnWWxQcEtr?=
 =?utf-8?B?U1RnRE4wVTRmMzBabVJvYkkxK2RhUllWd3Rpa0ZZVGpuZGN2TXl0V3A1QU9s?=
 =?utf-8?B?VlpvaG5rR05JV1prNTVxWHB4VUZGTUtIWUY5Y25tUzhBYWx3SjkwNzVGdmJr?=
 =?utf-8?B?c0tIZE1lcHdjYmJJclRiZnI3L04zdXZsRHFQNzhoa2FzOVR3bndJd2lnVW5w?=
 =?utf-8?B?RlhYbkgrZjMyek1zNlRoZmxON2VXTHQ1ekxmTERwY0Vod2tuWW9nazRYZytu?=
 =?utf-8?B?bXF4NTNKeHNNRXM2T20vWlVoQ2wvRlVlRStySWJ0Mkl3STNWZzdlUDUvUEtN?=
 =?utf-8?B?RzhRbGhZSkZza1VlZC94ZDZPTnROTkxDbXJZdERkTDJIdGJvNUVMcjJ0bm51?=
 =?utf-8?B?RmNNNFJwMmNNa0Uzaml3akNaVzVPV1R1a3owSlRiY0V1c2U0M0toRlE2RlJX?=
 =?utf-8?B?MDJHNm1oNnMzcWN4VmFxTTJLKzMyb0NVcGtNeUsxNVV1OGkydnBnRXhGQ1ZO?=
 =?utf-8?B?MXFmcEg4RVkySDdGS2grcEhkc2dVaFM3THBBa2FnM1F3bmVWT0p4YmgzL2l3?=
 =?utf-8?B?UUtycnp6RE5FUVIwSXUwdmJnY3hneTZPc3k1ei9rY1paWTY1M0lGbERoY1ZJ?=
 =?utf-8?B?aEtQZmFuaHoyN3owS0s3SUJNOGNaeDhkNjdNV21Oczk0QjdzWklYbk9LRDM0?=
 =?utf-8?B?RUNDb2xqa0gvMmE0djA3cUp4TzVvQk5kckVxRnJyaXNMT0RxV1g5dnRJZ1pP?=
 =?utf-8?B?TS85aDErNFF2WThPQmVuODBVUnY2ajFpRUV5eFVwWTlmTDh1WEVKcTdON0Qy?=
 =?utf-8?B?M09GMHRQby9CeEgrYVo0YmxMZ1l2UFBYeHRQREoxaDBiQ3QvVmd0RHlOS3Jh?=
 =?utf-8?B?VXh0TFBlaFV4amw4bkFtSGc1Y3RHeUVsTUJPL0hSN2hueFIxaWk0eWh6R0NE?=
 =?utf-8?B?SHR4STZZMUQ0RkRkbXRqT0lTVHBUN1BYQndzSVZwRk1BZEJHTEdCenovQ2N4?=
 =?utf-8?B?Vno5QXZPTjBCRGtja1YzUTBYVUJkRG5HVHFqSW1zVkhPbDhSU0J2KzhvNDhk?=
 =?utf-8?B?azFrWWFhNjJnUGNyVGpsc3QzR2o0b2puaEd0VE9sZ2prZi84VDNzRXRCWHRR?=
 =?utf-8?B?Y0RrS3VadmNJejRXZDZ4enc2MWRYaHk3Y3NSNVlIb3pBWDcrNXRFWStDSTdZ?=
 =?utf-8?B?L3NxMExDR1ZFTnV3Q2U5UzE5NWEyMlYwTFhnRmI1VnlxUFBObk03c21WWGFR?=
 =?utf-8?B?bmJxOVorUXo3Ym1TRjF0L0h5YlV5NW12bFBGaDg3RVY4dGFrM2hmUmFIcFd1?=
 =?utf-8?B?dzJpaW82bldCcWMxcVhnMXRvenhVd3FjLzlhOW1DWWFwWVhuWFBya09zLzRa?=
 =?utf-8?B?c0tQNDlTK2pMRWRDbTV5VkF1UngzdHZheXZ0c09wdjgwN0phVExZN3ZyU0o3?=
 =?utf-8?B?NHFQMDFKVHJydE81TjBzTzlaZ3Z4TnQyMUoyclFySGFMWDkyblJPb2Y4MGJs?=
 =?utf-8?B?RlgvVXZZVVlXLzBhYkRaQkl4aTk2YmovV2l0cDlkTFVOc3NhTkx3M0VuVGk2?=
 =?utf-8?B?K3k3Q2NhZHpoTmdNU2c0dz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzJpR3p6bXZ6QzJydmg0NjZJOStySklFSm9GMnRRZDlMcVJkU1hWV1I4MWQr?=
 =?utf-8?B?N1ZQTmhMRHNwN1BKZGlQYnZCWEVuTTVuWnkwaUlNQzdVMlIzam1jTjRXSk15?=
 =?utf-8?B?TlVSSlp3c2dWK0x4a0ZGQnQwYWp2aUNCalpTWXk2R2FJVUJXc0RuT0grK3Jy?=
 =?utf-8?B?VFpKZEZrd1NCS01RNXNLVU5PT1ovMzhJT3NGQXRoYzEwWEV1ck1FREFjM1Er?=
 =?utf-8?B?VFF2eDR2dS9TYk5NVkpFZ1psenZ4YmhCa3l5dVFyazcvMVkrMWdhV0JDenFL?=
 =?utf-8?B?bXAvR1locUk4UVRyMlc0UVNadHltU3BZdjZNeFJaWHRIUHM2Y3ZKNVlXTTNH?=
 =?utf-8?B?c2R4YkJuNlplSFFIYmFUMGJMMWJPQjlHTlpGeldid2RLNDlkVlNRTUptbXJP?=
 =?utf-8?B?NmdLZWJwMkJOdjlxb2tjL0JJVVNwYll1L3RnQ3RtTDFIdGE5dFZaSFkvUHpV?=
 =?utf-8?B?SnhYOWNPT2JEeER4QW82bk1GUVJ4RzJXVkJsbEV6SlRieGJTNTlSSExmTTZK?=
 =?utf-8?B?QkNieDZKMkQzdDNvVUVZWjdvWkR4M0JxQWNiM1V0NlZxN1BuRzRoNkpLNStt?=
 =?utf-8?B?NVpkRzBDd2J3SUZ5YzJXRzhJYTBuWURNbUZYRE1kaDlkN1dNSnlUZU12THdB?=
 =?utf-8?B?dGJ1VHZsUkpGWU54YVlwQzJaY1NpVkQ0RWkrSmE5VDhxSzRxVy9CZzJ5YkM1?=
 =?utf-8?B?eE05b1dlVmMzakVkY1hkcDh2YUNQY1FXZGo3MHJqdHlSS1Vxam1UTjh0MlBE?=
 =?utf-8?B?OEZwOWZhc0hGWjlLODZPTHNaQnF0L3h2UnNOb3FnWHllN3JlUkMvY2lDKzBl?=
 =?utf-8?B?SnZ3UG5NaDNxOTNkTmNlM2pJcDJZTUdDSzRsa3Zkam1pbkRDWDUzTFhZQXIw?=
 =?utf-8?B?em9zeG0yMEVMYkRrcm42RWZPUWM4bkIwVDlZdmsrVFgwdWlmYWpSUGc5czRF?=
 =?utf-8?B?bExHNTlXNW5VVmtrM3Y3enFhUWFmQXdFRWFaQnVUVmpqbS9aM2k1OExHK2V1?=
 =?utf-8?B?SGxCVjZtWWxKb3gyVHY0UWNyajZZQmNPQkFCc0lMVkVlY3NoMVRoTER3QUN2?=
 =?utf-8?B?b1QvdC91bEZKWjdEZFpZbzVMYWpOK0ZFOUN3VWR5UGFSODFxei9qcnVaUmt5?=
 =?utf-8?B?dW8vREl2WjVvM2R3L1NyZlBtTnJvN3g3bXN4ZUYzN3dnR3lXM2lnc0JYdUhy?=
 =?utf-8?B?MDF2aUxzV2FmWjBTcG45eE9JZnRZbG5BTEFxSmNINXdCK2JBeURUdlhvSFNy?=
 =?utf-8?B?NGp6OWtZQzA3bjY1aGdDeUlZWEtZSE1pUElvUHhPb2tLaExsdkZheEcvWGQ5?=
 =?utf-8?B?OUE1K3F0ZmNVRzQxTE55bk9KZlFDVEIwdjd1RERuL3BLUFRlaU43MkF5YVd2?=
 =?utf-8?B?ajc5YXNLOGtUalFIb3FpMHdqRzJMaEkrTDF1cDVpZVFzb2daNnZDc00zNlNk?=
 =?utf-8?B?OElZeXRtNE5HTzAwZm42Nk5pNjFYNUdTTDM0UkdpN0VTUHRuQ3l0bG55eDdG?=
 =?utf-8?B?ekppMU1XRHkxN3JwNVZDa2pJT3ZVSlNZZ1JDbUc1T3pUYUY0aUdTV3kwVzhL?=
 =?utf-8?B?dlNZVTY4Ukh5b3kxZHpwTHVaeCtMOEUrWHhZdXNXQUVxUXZDRThDalJsSFRt?=
 =?utf-8?B?N2ljV0tyOU0wMEhlbE5vUDJnN3d6Tk1JbUJRSCtyWmdIT2JSRjdmYzRwRUhS?=
 =?utf-8?B?YWFTTEROOHloOGhSaWdZK3JJTm9ValV6clFpblYrOGVtT0FlSzVRRGh6czhO?=
 =?utf-8?B?UnhySDBGR01NSFBLazBVL1JCUWhMYzRnYmRsRkZQQVVMYnZxM1VQQ2ZMMmNX?=
 =?utf-8?B?ZXh5NzkwaDlhWHpoUWJXeFF5bldKNjcxS2VyODlRY3FPTmhRWEN5V1I0azg1?=
 =?utf-8?B?M01sTFF5YTV2dzRnaFJYVUZjVzRBYm85ZVhSZ3FSMkxpZzdZemkxZEM0bit0?=
 =?utf-8?B?VVNUQWJhamw5OEJDK2pyNUtuNERxK251S2ZHRW1XTXlHZCttTFp6ZGQ1YlV2?=
 =?utf-8?B?ZVJLMXZIMTBOb3FUS2xmaGtZSkpVSWtiQkZMaUlveFNMQXBadTNGODdUTTI1?=
 =?utf-8?B?S0pkYzNlZmpDalFPUm1XTHpBUFdvYVpMMHJDRU9QN296OThVTEpFSG9XTkZ5?=
 =?utf-8?B?cjU5OWxtS1Q1dUFHVlBFblFCbXllWXBNMmhQSngwSmN6NEZ5WmlCejZlMTJH?=
 =?utf-8?Q?wfY/2Wvqm7R3CD4cws6ttIQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6DFD8BD61FA9454FA18183404D15A7F7@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b29a5b42-be93-4a89-b206-08dc79979241
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 13:11:48.0177 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zdTMM+A4ni+KszHu0fn/fP/DiRR2EJ9Avw+YVmdIZfn6n82KWjyfrk2hwc496CoFaucBcJSCFsIJhXE3ZGLqYaloTlgevq7JRl+OOnChKB2AEI7aYMZKq4VzsVTg+xpS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR07MB6249
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

U2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1k
cmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9pMzg2L2ludGVsX2lvbW11LmMgfCAxNSArKysrKysr
KysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0
IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQppbmRleCBl
ODM5ODVmMmY3Li5hNDI5MzhhYWNkIDEwMDY0NA0KLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5j
DQorKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCkBAIC01OTc1LDkgKzU5NzUsMjQgQEAgc3Rh
dGljIEFkZHJlc3NTcGFjZSAqdnRkX2hvc3RfZG1hX2lvbW11KFBDSUJ1cyAqYnVzLCB2b2lkICpv
cGFxdWUsIGludCBkZXZmbikNCiAgICAgcmV0dXJuIHZ0ZF9ob3N0X2RtYV9pb21tdV9wYXNpZChi
dXMsIG9wYXF1ZSwgZGV2Zm4sIFBDSV9OT19QQVNJRCk7DQogfQ0KIA0KK3N0YXRpYyBJT01NVU1l
bW9yeVJlZ2lvbiAqdnRkX2dldF9tZW1vcnlfcmVnaW9uX3Bhc2lkKFBDSUJ1cyAqYnVzLA0KKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZvaWQg
Km9wYXF1ZSwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBpbnQgZGV2Zm4sDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdWludDMyX3QgcGFzaWQpDQorew0KKyAgICBJbnRlbElPTU1VU3Rh
dGUgKnMgPSBvcGFxdWU7DQorICAgIFZUREFkZHJlc3NTcGFjZSAqdnRkX2FzOw0KKw0KKyAgICBh
c3NlcnQoMCA8PSBkZXZmbiAmJiBkZXZmbiA8IFBDSV9ERVZGTl9NQVgpOw0KKw0KKyAgICB2dGRf
YXMgPSB2dGRfZmluZF9hZGRfYXMocywgYnVzLCBkZXZmbiwgcGFzaWQpOw0KKyAgICByZXR1cm4g
JnZ0ZF9hcy0+aW9tbXU7DQorfQ0KKw0KIHN0YXRpYyBQQ0lJT01NVU9wcyB2dGRfaW9tbXVfb3Bz
ID0gew0KICAgICAuZ2V0X2FkZHJlc3Nfc3BhY2UgPSB2dGRfaG9zdF9kbWFfaW9tbXUsDQogICAg
IC5nZXRfYWRkcmVzc19zcGFjZV9wYXNpZCA9IHZ0ZF9ob3N0X2RtYV9pb21tdV9wYXNpZCwNCisg
ICAgLmdldF9tZW1vcnlfcmVnaW9uX3Bhc2lkID0gdnRkX2dldF9tZW1vcnlfcmVnaW9uX3Bhc2lk
LA0KICAgICAuc2V0X2lvbW11X2RldmljZSA9IHZ0ZF9kZXZfc2V0X2lvbW11X2RldmljZSwNCiAg
ICAgLnVuc2V0X2lvbW11X2RldmljZSA9IHZ0ZF9kZXZfdW5zZXRfaW9tbXVfZGV2aWNlLA0KIH07
DQotLSANCjIuNDQuMA0K

