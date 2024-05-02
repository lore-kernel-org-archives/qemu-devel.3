Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED16C04FFE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2YO4-00048h-Kz; Thu, 02 May 2024 11:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YNm-0003yB-6R
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:30:05 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YNk-0005yW-1E
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:30:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1714663800; x=1746199800;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=SJ1YCWl5qPAPbgtTpbIIOYagtuq+mMLnpiag2CWvi3Q=;
 b=mg0A+T+IylR9fP4vGforNWMFYqe5oXywmaND8ek53NPjsUpsVhCyM4ZE
 YWthMD/Om3CWsgBav3wAH1YLx2G52uvNDOTANk1+ckRM5Uve/H90XUYAa
 yXDkLidPcdnvWpYxfSVZZg8BxjNUsuc3g7EEtviWjMRS+KFqryus61B/4
 yXlGkTlM3YbphzaC7pWJPnp3iRtwvrHUl3hPEwQHLbZehiyi1NaKKBp9R
 QE4H2lU9GA86F2eCescSRweNxMQUS455tuTvVdix7ep6jdf6VKBbXfAMJ
 ExDvOufITPTNHIW1QlVeOJswb2mduRW5HOAGy/2a9ScNlLuccMh5bHYWN Q==;
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; d="scan'208";a="11785887"
X-MGA-submission: =?us-ascii?q?MDHDnbPocZIM7UPS0lgJkGyCQRsFEKCgvg/s5K?=
 =?us-ascii?q?gyg3DTBaKXws0NoDkg0XGZhQWWGIOeXVaOlGIPSerfOVfdkIaDIu0CZN?=
 =?us-ascii?q?5u2QslsTj3BcFtpYqjfwn5cosmXCkxwh4YtI9MCtabNwBvFMMU3fbAYv?=
 =?us-ascii?q?HJPDj8cz9Ko45StpLae2H85w=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2024 17:29:23 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RmgFPK8HSfMHIZyqGGZCuDVb1J86o2ADPyV5MUkdSSDf5qgSL591p6xnb33OEkq4tGl8K393IUHtOemxXel/86N3Z3ykr8UTclr/iujdQz+R+WdfI1adJleFoHh9jaIxaKsotnhedXzp57+mZOGor9THsahvGOSu3BvDplUYPq1ax7z6lUFdALqW0dbAhphaNjvyH4+Tqr4AiXgn0jl9jCoSBJx79Czg7vFVfTiarOMkm71vZp1mPbEIlBCwW3bIAw77o/kSg9Alui1rw/SGGHfNHr99J3tYSh36+YUoMu4HD3Yz8w9QHl1ri2UomkH0YIWNTYxKHMGGPTwe7KNYwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJ1YCWl5qPAPbgtTpbIIOYagtuq+mMLnpiag2CWvi3Q=;
 b=irSt+PMEULVP7PKdxA+lLFH5qfZYT5wDcw/f+gdbrdkvPgdGJ5nMdA8pR9IgnWqNJH3RR0XKVcaSFM2k5in9ce2FHrbo8fJ7gciPBiN5zt1njYmGrKRLVlIcRwYL1oxnW8uUTbNSjf+jzexeeYJXJd0wSzjVmUuG2mgbzLEdUryQ5lNrgsv5OjOIlccdhPsivQxNAI0dmqn9rOdErGbdy1BcFEzZ+l34LchzMv2ewjZnMX1Lip2UoJsGBXr5lI0/JNSbHSKjEJyvGpsd8TuC1o9yICODh7ijlO6aSD1bwzjJVov7VJvLR7g3j1vVZdkk48JyquD9guw1r0kvRm/BSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PAWPR07MB9661.eurprd07.prod.outlook.com (2603:10a6:102:389::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 15:29:19 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7519.035; Thu, 2 May 2024
 15:29:19 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v1 13/24] pci: cache the bus mastering status in the
 device
Thread-Topic: [PATCH ats_vtd v1 13/24] pci: cache the bus mastering status in
 the device
Thread-Index: AQHanKWAPapiaRw7i0K7512F3ib09w==
Date: Thu, 2 May 2024 15:29:19 +0000
Message-ID: <20240502152810.187492-14-clement.mathieu--drif@eviden.com>
References: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PAWPR07MB9661:EE_
x-ms-office365-filtering-correlation-id: 16b1bb00-7e21-4991-9e73-08dc6abca2c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?aENhRjN2N1RyUmVMUS9HbWJWSUtjeW1JRWUwR2RiUkoxY21jYW1RNGpFZ2NT?=
 =?utf-8?B?cVVpRG9iVTNreTJ4SXlGcVZXeVNOWUU3NEp1WWZhVzlla1crMVJNNlBkQzBa?=
 =?utf-8?B?ZVllR2RRWkk0ZGRDOGJIUUV0Y0RHcnE0WEtLY0NOdklHdEJXc2VPcUpvMzRR?=
 =?utf-8?B?aE5sQzhCQlQ2emVqWXNxWmNESVdTYk5QcTQzRys5c3NGdkpDa0YwL1pxWTBN?=
 =?utf-8?B?MnJWbEVGVVUrcEQ2N0lsK3ZBcVFndWNWdDJSMG5NMHlMVytkRDM0Ky9pb2J3?=
 =?utf-8?B?N3BXSHBML3kwbUZ4TzhvUDBKa3MzbG9XVWptSG5TQVh3SldYWjJ4NHNVL1pJ?=
 =?utf-8?B?d0hpVTYwYTZpSGwyaTAra2xMWnhXalV1SXJLZTd0QmdUWDRockFDa2E5M2c0?=
 =?utf-8?B?aWhXbUNNL2JIbHovbTFGZ1RTQ1N0UkxWZmZta3JhaGRBVENLeS9jWkRmc2VB?=
 =?utf-8?B?N2wwYW5NOUZQM2dFY3FsUXNRaFVCUjg5eElpZGJUUkJoSmd2OTQyZzQ0ZDRj?=
 =?utf-8?B?U1Z0L01WOUlpYjU2d3hDT1FhbitwTnZxaWdLNVByV2kxdmUweXVCNFlCMWNH?=
 =?utf-8?B?ZlN4L3JreXcvTE5pS2Y0L0tpQldqVDc0b01tQUxZYjBZMVJRUGJxSEEweEhw?=
 =?utf-8?B?UVdZTjRSTXFaemhPcHV0QmY2V0hFcDE1L1JoeWp5ZTdOemFiV0JLeWFlWU0z?=
 =?utf-8?B?WWs4VGczeFpwejhnMDV2aTJha3lhdEdtenhNU2krS2dhWC82QzhJWitqeTha?=
 =?utf-8?B?Y0c1WVV3SkNuTFkycFhYZGlnV1dlckNZNjJCcGQ5eW9TRWVSb0U5RnRKUUhE?=
 =?utf-8?B?SHBWem1qbHpVS2ppS3VUTDdUVjBEL3VQNXdZU3lPQy9aMnNsMFh3Q0pDdjgw?=
 =?utf-8?B?NDJ3UmhRbmdma0x2bnJ4ejJIZ0VwZmQyMzQvM3R0NHBtcE94NGExQ3g3endY?=
 =?utf-8?B?cmVVSmJobVBSRlltb2Y3WjhKejBaS2xSRjUxWm1kRS95QUhDeVp2RFlvZjIv?=
 =?utf-8?B?MjZBS0xHUUZ3b25hYWJKYmEwSXpzaUNVVWs5c0lVcCswdGJ0SVU1WVo1aFBh?=
 =?utf-8?B?Yk5ZYVJWWGFlSWUwZ200R1oxOFlSejhFK2t4R0JoRUkxKzUrTmdjVmRtdWVB?=
 =?utf-8?B?NEJKZjN2L0YxcVpYdjEyOHYyb1dtalRBeElRbmpvQWhXeEZhUHNzZHI4Nkg0?=
 =?utf-8?B?WmVSdDRUS1BCeExOaWlkMFQraDh6N0VsNnovMGdDYUdXaFN4dkJFNytQbUta?=
 =?utf-8?B?Q1lDZ3lDQUFkQ0l3elg1OEF0cFk0YTVCR3lKSmt6Z09wZlBLM3p3OFhZamY5?=
 =?utf-8?B?R2MyUnJVdWpON21mc1IyUjEzS3FWK0NyNEtwdkNORVkralg5OTBaVEJZa3BM?=
 =?utf-8?B?VjNyeDRWekFseXJNTlFsZnpxVlBFeUJKZWoyaVAzMUM4MFo4c0EvSHBNcWhC?=
 =?utf-8?B?SXkxYXRYL09NeG1CZmloRE1CdXRXY2xiYitwU0lYa3VOVVhGZEZKSTh3ZmFO?=
 =?utf-8?B?RFNsbWd2WlIrYmdyK1AzNlpRanN3QVRWeklSY2NwU0Z6YWUyTmtCUHZVN2Ew?=
 =?utf-8?B?Qi8yZldoN3BuYmo0K1JhcE9iY2QyK1U4SmFTdlhlMThUM3Q3bVJKNDRlTEoy?=
 =?utf-8?B?MEluczVXVlJ6ek1jN0dkZllVNExSanU4SWdhekxmcmpablVlTUYvRWljODF6?=
 =?utf-8?B?L1p5VmROemNSMEREWUVJeGlWc2NrOE92cjlPZTZEczlSVWswOG1JR1JWTkNL?=
 =?utf-8?B?MGxiUjFRY01zaXN4YnFBWUFtV3RkVFhmb204QVRtc043cEl2TmJZci83YVBF?=
 =?utf-8?B?cFltZVFyS0k3bEFBa0x1dz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1V6cDFqK21Cci9iWEVjME8rMUtLNWJoSHBUcVMxK0tmMGsra2JIZ0ZIN0Ja?=
 =?utf-8?B?QkhiMUVTTGZDQWEyUkppZTk3NzNEL1dOVHhUUml6YXpTMGdpYlBYWTJvS0hr?=
 =?utf-8?B?OUZkWVZkM2lGWXZyZHg2ZGw1dERSSmo3dEtpNGZkSWh1RjUzMmh2VXpFT0VO?=
 =?utf-8?B?ZWFETm9JaGYwRS9TOGc5ZFRkSURYY05HZTh5TnFPcnpib2NMZjJKSUdxeDlL?=
 =?utf-8?B?Uy93L3B1cXFwOGgxR2xzQXluUXJxWk0xMlArekNJTnVyZ2p0TGlnenZPR3Vx?=
 =?utf-8?B?M3NpTVQwNklOSG1vbTRHTUlxeDRlREhQREpDSlQ0eEc4N0VwS0REZDhaY0ZD?=
 =?utf-8?B?QWVncmtDeTZvV0VkU1ltV05wWjBxR2JtbmpDcVdMbW5tTVR0eW8vcnpVRlgx?=
 =?utf-8?B?clVuaUtVdGluSXlsbGh0eklKaENXUXhpRk5vSHNwelZMdUZ6di9wSzZYU1BL?=
 =?utf-8?B?OVp4QkdFU2dGSDFWaDZoVm1KUDdneGtCVGxydHBDRVkzNDRhanRZdm1RYUd1?=
 =?utf-8?B?empzQkRpa3lzaFZQK09jYm9qOFp0TUIweENWT3ljbDFDbDJoaGZScWMzRXhy?=
 =?utf-8?B?QlNDMDM0dkpqbWVTdjRKamhpLzFuR0VmSWhibURFTlRQOG1aUjJBMDlpaDVx?=
 =?utf-8?B?RnBTeDZWRVN5NE95UDkzR2R5M3ZNd3hlR0lsdldlV1hzcTRHUzhIaG9ld3VH?=
 =?utf-8?B?SU92NWRiZHdaSUhnN3BhckFZTUx2alIzbVUzZnl5YStvRWFmNjJHL1gwZVRL?=
 =?utf-8?B?eUlZbVl2ZTdSK1dUMUI3MXV4U2U2WnIzQ2ZsczZpb091ME1IZzFlVkN6STI2?=
 =?utf-8?B?ZlR6a29KM01MaGFxMm5uT2xvVGNqSGdEM0JaamRFTnlGN1ZGVzlhNy9XdE1v?=
 =?utf-8?B?YXNiUlNJNlg2V3RQUEtIakFTZXcwd0U2bjJoYWo0M00zdDRuZGJwemxYNitn?=
 =?utf-8?B?MEJUeTVWT0psRjVGRzhDdU5zK1hMOCtIbWdybGhxN0xiYWVDMnFRaVFpUzE4?=
 =?utf-8?B?ZVRsdGdCRkJtUThuUSswYndkMEw2QnI5MFphVzlmdHVPbGhBMFV1TFR4QWJW?=
 =?utf-8?B?ZktkZXM2TDdycEJ2dEthazI0SVlOUHp5QWQrbkZJUG1kSDMxS3J6UzRoQVZI?=
 =?utf-8?B?QjFTeU94QzFaS0N0TW9CY1p6QzNPaE42QlZaYlNLSENpeGlvWVJ5WGJWMEx1?=
 =?utf-8?B?WjNjcFdjdFBuMGdBcE8xcklTelEvN3N1Kzd3bGVvWHFEUi85QU1Sb3pRbVFT?=
 =?utf-8?B?dzlxMkVLK1hDWitIYjlBY1psSmhhOVNOWmhUV04vZlJiYm5LRjRRU05PbGh5?=
 =?utf-8?B?YWJaYy8vNElGTTZpZDdMaU9sM2p3WGZlZ3FUUlFPdms5NjJEUVZiNzZqTFB4?=
 =?utf-8?B?T0lMZm16UElOUTkrdWpWaU4rMGo0NGJHcEx2MWZMelVBSHNsb2Z1L0xKMHV5?=
 =?utf-8?B?WGhPVGsvZG15K3FtdGh0N3k3M2pQSlR2UXFoQlpLK3NvZXYrZHVna2NOeitt?=
 =?utf-8?B?NS9ncVAwbU5nSU8vbHlPaDZhTjlGUGRONkZhaFlTK0JsOWVPMzNmdlI2Q1JG?=
 =?utf-8?B?dG1sV2dpUzRjTjFlTDlzM2gwbFdJSms0ZlJOaVlxYktra2ZjWmowMzVvTW13?=
 =?utf-8?B?N2g4My9IcEZhRkk2N3hUK3dydzRFTEdCOGFLUnZBTE9BdCtDdjVmdy9WVVJB?=
 =?utf-8?B?ODlZQko5aHc4aTFMeDJKVkhXK3IraVIxdmFyRDBWYjMzdUpWN1RsSDBubVVo?=
 =?utf-8?B?Q0JBTVhSVmZYdXlFVzdLb2VKQU1VMEdDUGpYZ1Btalh6YnRzRGo0YldrUU0y?=
 =?utf-8?B?WTBEcmMzZVlKaWNLa1R6WE42K1NITUFXTC9PdlZPSyt3WjYrWGVxWnVXaVdy?=
 =?utf-8?B?eTh1QnFvUDNqVDIvRmNsYVVUYWJoNlVWWnI1M00yZ3pmZkM0Q3FKNEtDUlNE?=
 =?utf-8?B?TU5taHg0VS9aRTd5aVFoUFRyZllPZnNtQ3FnLy80SDJnRUd4UFFvU1pCVTZO?=
 =?utf-8?B?K3IxNkoyMTlnSHhlWnN2dmMwOFNMU3htaEwxTDdQbHhWQVpWNmZIL1U5UGhw?=
 =?utf-8?B?YjN4T2tsdkw2eWlyMmpBaEQ3OTRjMkxVNWRFWkIzWnJxNnRWaE1mSVJNZFE0?=
 =?utf-8?B?a0d5czRqU1RZWEJZTHB2VjVMd2NvU3g1WmVWaFZrM1c0c29nVitXbXpidFgy?=
 =?utf-8?Q?qM2YOPa3V92tTAf6plNIr4g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C96FF1490C8E6B47A766A2D5BA0C0313@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16b1bb00-7e21-4991-9e73-08dc6abca2c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 15:29:19.6633 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vnKB2hV7eB8qE4c5gJJDGGAFHUdErkL7kwW2E0AICYf/g8MPUYcwBmk66FVfIkdqMytTCHsePIYqV1+H2RQL4bpWkbUxCr2FTX0Ol/VTzRQef7LJ138CQbiipaeBSyBu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9661
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
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
cmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9wY2kvcGNpLmMgICAgICAgICAgICAgICAgfCAyNCAr
KysrKysrKysrKysrKy0tLS0tLS0tLS0NCiBpbmNsdWRlL2h3L3BjaS9wY2lfZGV2aWNlLmggfCAg
MSArDQogMiBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkN
Cg0KZGlmZiAtLWdpdCBhL2h3L3BjaS9wY2kuYyBiL2h3L3BjaS9wY2kuYw0KaW5kZXggMDQ1ZDY5
ZjRjMS4uZTVmNzJmOWYxZCAxMDA2NDQNCi0tLSBhL2h3L3BjaS9wY2kuYw0KKysrIGIvaHcvcGNp
L3BjaS5jDQpAQCAtMTE2LDYgKzExNiwxMiBAQCBzdGF0aWMgR1NlcXVlbmNlICpwY2lfYWNwaV9p
bmRleF9saXN0KHZvaWQpDQogICAgIHJldHVybiB1c2VkX2FjcGlfaW5kZXhfbGlzdDsNCiB9DQog
DQorc3RhdGljIHZvaWQgcGNpX3NldF9tYXN0ZXIoUENJRGV2aWNlICpkLCBib29sIGVuYWJsZSkN
Cit7DQorICAgIG1lbW9yeV9yZWdpb25fc2V0X2VuYWJsZWQoJmQtPmJ1c19tYXN0ZXJfZW5hYmxl
X3JlZ2lvbiwgZW5hYmxlKTsNCisgICAgZC0+aXNfbWFzdGVyID0gZW5hYmxlOyAvKiBjYWNoZSB0
aGUgc3RhdHVzICovDQorfQ0KKw0KIHN0YXRpYyB2b2lkIHBjaV9pbml0X2J1c19tYXN0ZXIoUENJ
RGV2aWNlICpwY2lfZGV2KQ0KIHsNCiAgICAgQWRkcmVzc1NwYWNlICpkbWFfYXMgPSBwY2lfZGV2
aWNlX2lvbW11X2FkZHJlc3Nfc3BhY2UocGNpX2Rldik7DQpAQCAtMTIzLDcgKzEyOSw3IEBAIHN0
YXRpYyB2b2lkIHBjaV9pbml0X2J1c19tYXN0ZXIoUENJRGV2aWNlICpwY2lfZGV2KQ0KICAgICBt
ZW1vcnlfcmVnaW9uX2luaXRfYWxpYXMoJnBjaV9kZXYtPmJ1c19tYXN0ZXJfZW5hYmxlX3JlZ2lv
biwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE9CSkVDVChwY2lfZGV2KSwgImJ1cyBt
YXN0ZXIiLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZG1hX2FzLT5yb290LCAwLCBt
ZW1vcnlfcmVnaW9uX3NpemUoZG1hX2FzLT5yb290KSk7DQotICAgIG1lbW9yeV9yZWdpb25fc2V0
X2VuYWJsZWQoJnBjaV9kZXYtPmJ1c19tYXN0ZXJfZW5hYmxlX3JlZ2lvbiwgZmFsc2UpOw0KKyAg
ICBwY2lfc2V0X21hc3RlcihwY2lfZGV2LCBmYWxzZSk7DQogICAgIG1lbW9yeV9yZWdpb25fYWRk
X3N1YnJlZ2lvbigmcGNpX2Rldi0+YnVzX21hc3Rlcl9jb250YWluZXJfcmVnaW9uLCAwLA0KICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnBjaV9kZXYtPmJ1c19tYXN0ZXJfZW5hYmxl
X3JlZ2lvbik7DQogfQ0KQEAgLTY1Nyw5ICs2NjMsOCBAQCBzdGF0aWMgaW50IGdldF9wY2lfY29u
ZmlnX2RldmljZShRRU1VRmlsZSAqZiwgdm9pZCAqcHYsIHNpemVfdCBzaXplLA0KICAgICAgICAg
cGNpX2JyaWRnZV91cGRhdGVfbWFwcGluZ3MoUENJX0JSSURHRShzKSk7DQogICAgIH0NCiANCi0g
ICAgbWVtb3J5X3JlZ2lvbl9zZXRfZW5hYmxlZCgmcy0+YnVzX21hc3Rlcl9lbmFibGVfcmVnaW9u
LA0KLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBjaV9nZXRfd29yZChzLT5jb25maWcg
KyBQQ0lfQ09NTUFORCkNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmIFBDSV9DT01N
QU5EX01BU1RFUik7DQorICAgIHBjaV9zZXRfbWFzdGVyKHMsDQorICAgICAgICAgICAgICAgICAg
IHBjaV9nZXRfd29yZChzLT5jb25maWcgKyBQQ0lfQ09NTUFORCkgJiBQQ0lfQ09NTUFORF9NQVNU
RVIpOw0KIA0KICAgICBnX2ZyZWUoY29uZmlnKTsNCiAgICAgcmV0dXJuIDA7DQpAQCAtMTYxMSw5
ICsxNjE2LDkgQEAgdm9pZCBwY2lfZGVmYXVsdF93cml0ZV9jb25maWcoUENJRGV2aWNlICpkLCB1
aW50MzJfdCBhZGRyLCB1aW50MzJfdCB2YWxfaW4sIGludA0KIA0KICAgICBpZiAocmFuZ2VzX292
ZXJsYXAoYWRkciwgbCwgUENJX0NPTU1BTkQsIDIpKSB7DQogICAgICAgICBwY2lfdXBkYXRlX2ly
cV9kaXNhYmxlZChkLCB3YXNfaXJxX2Rpc2FibGVkKTsNCi0gICAgICAgIG1lbW9yeV9yZWdpb25f
c2V0X2VuYWJsZWQoJmQtPmJ1c19tYXN0ZXJfZW5hYmxlX3JlZ2lvbiwNCi0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKHBjaV9nZXRfd29yZChkLT5jb25maWcgKyBQQ0lfQ09NTUFO
RCkNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICYgUENJX0NPTU1BTkRfTUFT
VEVSKSAmJiBkLT5oYXNfcG93ZXIpOw0KKyAgICAgICAgcGNpX3NldF9tYXN0ZXIoZCwNCisgICAg
ICAgICAgICAgICAgICAgICAgKHBjaV9nZXRfd29yZChkLT5jb25maWcgKyBQQ0lfQ09NTUFORCkg
Jg0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBQQ0lfQ09NTUFORF9NQVNURVIpICYmIGQt
Pmhhc19wb3dlcik7DQogICAgIH0NCiANCiAgICAgbXNpX3dyaXRlX2NvbmZpZyhkLCBhZGRyLCB2
YWxfaW4sIGwpOw0KQEAgLTI4ODgsOSArMjg5Myw4IEBAIHZvaWQgcGNpX3NldF9wb3dlcihQQ0lE
ZXZpY2UgKmQsIGJvb2wgc3RhdGUpDQogDQogICAgIGQtPmhhc19wb3dlciA9IHN0YXRlOw0KICAg
ICBwY2lfdXBkYXRlX21hcHBpbmdzKGQpOw0KLSAgICBtZW1vcnlfcmVnaW9uX3NldF9lbmFibGVk
KCZkLT5idXNfbWFzdGVyX2VuYWJsZV9yZWdpb24sDQotICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgKHBjaV9nZXRfd29yZChkLT5jb25maWcgKyBQQ0lfQ09NTUFORCkNCi0gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgJiBQQ0lfQ09NTUFORF9NQVNURVIpICYmIGQtPmhhc19wb3dl
cik7DQorICAgIHBjaV9zZXRfbWFzdGVyKGQsIChwY2lfZ2V0X3dvcmQoZC0+Y29uZmlnICsgUENJ
X0NPTU1BTkQpDQorICAgICAgICAgICAgICAgICAgICAgICAgJiBQQ0lfQ09NTUFORF9NQVNURVIp
ICYmIGQtPmhhc19wb3dlcik7DQogICAgIGlmICghZC0+aGFzX3Bvd2VyKSB7DQogICAgICAgICBw
Y2lfZGV2aWNlX3Jlc2V0KGQpOw0KICAgICB9DQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9wY2kv
cGNpX2RldmljZS5oIGIvaW5jbHVkZS9ody9wY2kvcGNpX2RldmljZS5oDQppbmRleCBkM2RkMGY2
NGIyLi43ZmE1MDE1NjlhIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9ody9wY2kvcGNpX2RldmljZS5o
DQorKysgYi9pbmNsdWRlL2h3L3BjaS9wY2lfZGV2aWNlLmgNCkBAIC04Nyw2ICs4Nyw3IEBAIHN0
cnVjdCBQQ0lEZXZpY2Ugew0KICAgICBjaGFyIG5hbWVbNjRdOw0KICAgICBQQ0lJT1JlZ2lvbiBp
b19yZWdpb25zW1BDSV9OVU1fUkVHSU9OU107DQogICAgIEFkZHJlc3NTcGFjZSBidXNfbWFzdGVy
X2FzOw0KKyAgICBib29sIGlzX21hc3RlcjsNCiAgICAgTWVtb3J5UmVnaW9uIGJ1c19tYXN0ZXJf
Y29udGFpbmVyX3JlZ2lvbjsNCiAgICAgTWVtb3J5UmVnaW9uIGJ1c19tYXN0ZXJfZW5hYmxlX3Jl
Z2lvbjsNCiANCi0tIA0KMi40NC4wDQo=

