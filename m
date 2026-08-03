Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B02C5516F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 05:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqlPU-0003FX-Rt; Mon, 03 Aug 2026 01:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wqlPN-0003Bk-P8
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 01:40:19 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wqlPL-0004IR-K7
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 01:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1785735616; x=1817271616;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=PeDH6a1qZ+rmTJmsHXLC4R8mma6I95G3Wnakm7AW7dk=;
 b=H0v8pfvKLdhklorNUddKQEQY+ybEcZOFIcsFYEYa4l2GY4Zc+YM2qha8
 xszQtazn8jrqTKXDgcdZwGZFgzvcPVm/y2/IFkZOvTQz6hpH/T3E0MQBK
 GabiIaAyq5j/YjyEQdYRNvv2NLc5Bjar0wKcOQ1+Z/rE/Yd4JiRA1My0y
 Kw4autPGWmu04qG7cf8Sr+d4FQiKWgA1I9//Icv2fRiZeCWY42QZjh3K7
 EEO8sF+vCghxOSwZHYKPr22yOfr/wl/8zovYBlkfvF21nUA3VI/qy2w0C
 pa0XJ9myrUL2LFLIKyur/ktgHDOtNl/ILdjFXXBjNCeVSE4tOpxNBpmIJ Q==;
X-CSE-ConnectionGUID: 3BbiEeuqRAKG+k585TtRLQ==
X-CSE-MsgGUID: +mP4n1jdQb6UDAt96KPHPg==
IronPort-SDR: 6a7029b9_baBW0FVFZDWzQtDFgI9YXIRu7pQX4Cv7YU7JpK5Ijw6VNSf
 vLCawv2y/gk25K+BznRwk5l0i69RAl0A0cX82sA==
X-IronPort-AV: E=Sophos;i="6.25,201,1779141600"; d="scan'208";a="48540239"
X-MGA-submission: =?us-ascii?q?MDGyCMZ8l4zXYVPHN1ZakCaspD1Y9TCzUGf3rK?=
 =?us-ascii?q?5QUYi6F39fw4febIkYfrwR/wyBUrp7c+OptExuMFDZrzUyPAD1s1It39?=
 =?us-ascii?q?EnKdMZXUlHAiSB4b/cYkLOn9Xp+/0KXMnzIe2wRRrVaWEcgR0/VoPXfH?=
 =?us-ascii?q?rDWtJi28nby57H+ioDg5Jsdg=3D=3D?=
Received: from mail-northeuropeazon11011058.outbound.protection.outlook.com
 (HELO DU2PR03CU002.outbound.protection.outlook.com) ([52.101.65.58])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 03 Aug 2026 07:40:09 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UVEab5duz9Z3Tw+bQL2ZlYBDYSVqvfSu3bAi6iOl2KkcCRiSOijeM5CoikG0DOwddVLn6AP0IAjJbfHU3hK56eEExSG0Usxp2Nn56UHDx07rzf1B9cdhzV7M/rE0a/GZI196oJZhf1z2GjvNBJdPZLliGmKPIjcUJfZBV3Lz6qpM2gTtML9RSJWr+229wa3F5sxk96+GG/l8VFmvlUo6uEbF+eejN2P7UMGRbtfzRbIPE30gwaO/isL4ZtkiJd+XDtmVutzieAZFlXum3q1GRqKIeSqcyOldniE7wZyIqLqIduWbqFxvMKsScNW6aH0w8d8bE9ZaKJMmWkrFHlkBZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PeDH6a1qZ+rmTJmsHXLC4R8mma6I95G3Wnakm7AW7dk=;
 b=gk+UGSnR8OdI6e43gJNEJfblSfGhGNXgOZg1vweYP5IfZY++yBUh13auaR8CKq4Nl4EijP5RvRKtIWh7Pp1BxTigOp7DzXVQ4wUIeCRW68zd4bfnI9C7H9eU3V+AfCHum3dk3s6axnOiDRm/2xZkYsQe2sbwtwY9B/ImJ23DxRDv9u/ugJcv/05OjqvJCDeeCq81m5VrWgQJK+HT38lQ6G5S3IcqbUqG2eD5yqxt4D7LeWhW0X50+CXAYnFP6vKvrYsP4VswK/mlTRTAAukMogeYMQBrRz2hjcjdYuNsUClvOi9K7VBC6qn7co6NH1yc3p2Gx8e1W9p4rghHDIsTUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PR3PR07MB6987.eurprd07.prod.outlook.com (2603:10a6:102:71::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.14; Mon, 3 Aug
 2026 05:40:06 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%4]) with mapi id 15.21.0292.013; Mon, 3 Aug 2026
 05:40:06 +0000
From: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowangio@gmail.com" <jasowangio@gmail.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v1] intel_iommu: Expose SMPWC when SVM is enabled
Thread-Topic: [PATCH v1] intel_iommu: Expose SMPWC when SVM is enabled
Thread-Index: AQHdIpiwj2+asGS6SESECAGeCbz3Y7aLGzAAgAC0sYA=
Date: Mon, 3 Aug 2026 05:40:06 +0000
Message-ID: <36e03eda2384213c5766e5940e2376aa6c50e6e5.camel@bull.com>
References: <20260802160408.645484-1-clement.mathieu--drif@bull.com>
 <20260802145308-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260802145308-mutt-send-email-mst@kernel.org>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PR3PR07MB6987:EE_
x-ms-office365-filtering-correlation-id: 1ac77ca3-cbfb-445e-968c-08def121ac61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|38070700021|56012099006|11063799006|10067099003|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: SJDsg/Rawf1sGsgZK/dOalVEmE3K0p/uoNASY+mfdgXaQpD5OcDqPykOmWBxrW1lwz/i/DV3j9z/EEkI/0jUmL0rXC9nQdEckoEr3ECbtPhiB+AJiPGDxB4aq9XZUYnNlmfDhkPFTsYHhwdmCSZOVp6mKem5K8kULTNmaFp9JHgxKsgl2omOdphtJRhvo8bd2pYISCA1GEsuTW6GrhDMPgJoo2TSEcKiBcuTWCftvl1G/6N/3E+BmBDKeshSHRJRJV/7XR37C7mjQKvsWg3mBhcK6PE0Lz0vPAPhy9lC7tdVK2xR8///SuOSdxwTkOFiTovMMBPmxFOd/hlmAb/Tdx6O2Kgo0svn/cOrJQu4vbq7+uOuITw9OCmkmxG3Ro9EZ7MDJkiL651pTaHxP/i7aknEsRvFiGs0na+JN+D6bQsck2Enof3TuL2gevB08WHTsl9agAI15MGfq/j1iDFER5MuqG76ca+3UiFoDuNn0djfIz1CE+I/QylGPNR+CQCj0x/gHFX++yGbTimRXL1H/dU6loSzATmSAK3S54r7MNPLydiifqtQj1LE/t9LcvTkYdLwZpuRxlZXkTnd19on6CBgHY2q9s5EiYUubABTGm08w3UJ7yBI4JS9o7e9AIWsCMDGsWGgiDVxSGW0fxZUtWqCGAigYyod8xvm/QWaEuw2L2EyAqkh4AizsY1aQ1EUzLaxqhbit+p5pt5DCEOY66UpDtP7mioV/7vsxwkmMXk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(56012099006)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0JxNE5zakVqZUxyc05PdUc0QkF4a1hLdHc3ZkRmODA5SGEySzRTT0hJMkVP?=
 =?utf-8?B?TDUzR3UwalhORTdOSDNFWGxncHFBVUlxMytveG5WWGw5eE5BYjVLOVN5MWdy?=
 =?utf-8?B?WktRek5LVGJWQ2Y4UW9MZGZPbW5PRTdWV2FtUHVlNldqZ2pCQndaOENoRUVq?=
 =?utf-8?B?YWlzOVFaMGcxQm1OL3NBK2NLZ2l1Y0FHN3dpb1B0MjVRNFNLazc0QVMyRjZQ?=
 =?utf-8?B?R3hkODJvSU05Uk9EUHNoMXY2eSs1bXFKczlVUFZUZUlGOUxTN2lxVGtDT01F?=
 =?utf-8?B?QzRycGY5YjBBZjVwWWswN3hoZ3FBT1ROZUV5bVM4dWJRY1dOS3NQbXFmQmV0?=
 =?utf-8?B?SVk3ZThNSHJzTDYrV016a3FvY1hCbjhXalZ3ZWg1aGZQQjEyZ0RROUhjSGtI?=
 =?utf-8?B?cVNreGhMYlhhMHRic2k2Q012aFU2N3QrNjhlRURaQU5GZUxPcjI1Q2xFK040?=
 =?utf-8?B?WnN0WngxWmwwL0ZTUHpIT1ZHOG93ZWZHbm9RQWdUT0RJbDZRUG1tTEhuUnVv?=
 =?utf-8?B?d2hwTDkxSWcyOUJCb3E2dG1IT3pNcGNkdVZnMnpjUElWZ3JndmtJSVYxMlBl?=
 =?utf-8?B?Uk9SMFhEZytibkdXZTN5L2tHdGoxemhPYVJKWnhBYlloSU8rVFNMdXRxQ2N1?=
 =?utf-8?B?SExpT05QaE1oR1F5UE1VbkJ4anljTmFHV1ZIQ29RazVxZldoRnVFTC9nS0I2?=
 =?utf-8?B?VWtKMWtVbXVLbE12bFJkWU9BOWRFS3BDYkFUTWI0ZlVPUHdYKzJwcklwZVg5?=
 =?utf-8?B?ZHVqTGtCZFBYQWJYRUlnajhXMmNuNHJ5aXdhQmxGK3hlVzV2L0hBWHFTMWFP?=
 =?utf-8?B?alJpSzREekx1dHRrUVNWeWZtME90ZmZoRXNaYmV2OUQwVkF5d3FhbFNDQy8w?=
 =?utf-8?B?Q1R3SG5ydVNTcXM5UENyNFFwUk0zajFXZXZtRGRFYmlUWnZqTFFKbU1OaWhv?=
 =?utf-8?B?N2ozVERxUUl3Y25ubFNyeEk2TmQ0M0M2MWwyWnRpcS9vSFBFdVZyeGhRdzVV?=
 =?utf-8?B?VVhsdEhxU1FlVDAyVFNFL3VWMDB3a0FPcXQwVFV6RmFjaDVxbmdVeHp0Y3Qy?=
 =?utf-8?B?TTJDdWl4bjJPODdDakdzQnRnYU10MTVxaXNzdERnbDNHVkE0R1pxdkVzTTcy?=
 =?utf-8?B?d3FJem1Hb0loSHQxMXNGeEJyT2tyYUZtdGZvNUVkRFdiRGdIRGFhSmJZRlRN?=
 =?utf-8?B?Y0Y5K2xBSVFtZjVNTzZabXVQSzFiWktlekdwU29zKzA0aWpoVlV0R01OVXJt?=
 =?utf-8?B?akxCWVd0S0ZBYXA3QXh4MTFIbnoyMmRXM3JhdDZDWTdlMjh5cmhMcm5MaGpR?=
 =?utf-8?B?SVYwTUpHNmFpMHpSQnIvUjdieTV0ekN1dGlRcjhWODg4Y3J3YmFUNm5Ed0ND?=
 =?utf-8?B?eEd4dE0yd3B0ZWJrblRKMi9ha3VGeFMvY3JTQ2x1N3RoeUxqQ2hWVmJMMUdl?=
 =?utf-8?B?Q0ZveEtsOGM2NDZyeGVhVEtycHlhdEZxQ25pTjlabDJLZ1k4M05sQzRwTTJI?=
 =?utf-8?B?VTMzb0ZyZ25QRGlMRG55Y3ErZzNia1VuaFhWNEpZRlYrOVBUZW9sejI1K2VF?=
 =?utf-8?B?eHhCOEdjTjVyVEx3TVVGZk1LeThEVWhSNm1SV21rS2xrTUhvM1kwdjFFazFo?=
 =?utf-8?B?QllsNkEraThMSDE2bThnclN4VVFIMTI0T2VRMCtVL3hQZ3hNVHJqRzdKL3Js?=
 =?utf-8?B?REtKblk2d09zc3h2RkhNd1JlZ2xtRVVDRk9GSlpXUnNCbmNXODZZYkJXQVo5?=
 =?utf-8?B?bDZGbFJlcktjaTVDTktRMjhwT0NOUHFSOWM5WmdLWnZ3Q3ZwRnVSZEZLTk1v?=
 =?utf-8?B?Z0EwY2JJeWx1UmQ1bFAzVjFvRHRGS1pwVjNxUk9hd3RMVUNiSldpeDV5Qk42?=
 =?utf-8?B?MnBnbUhXMXFsRXdyamw2ZWhHZVdNVkdvaEtLNVZoL2RtaHgvbXdQRmd6d0xs?=
 =?utf-8?B?Y2JKVlN1bDNzbVN3OEhzZzIrODNlSi9ITUowZTRSeUNPcWJkb3F1ZU54Undi?=
 =?utf-8?B?aXlBeHM4WGUya1ZORk9sd2hONE1DcTdBMXN1Umd5aGx6VnpuSTNKMVFqUnFO?=
 =?utf-8?B?NTFXUlFiUG1weDFmbW9kTkhGWEVXd3M2V05DY0t0em9oaGU2MjZwN3VCQklD?=
 =?utf-8?B?b0R1MDMwTnF4a1VHOHpiUTVBMUxJRW9oNXN4eSt4dkJMZjIxNFVwbmZmRll4?=
 =?utf-8?B?Z2x1MWZwSGo2T3pmNDhzSmVTNTNpY2paU3B5NXptZ3VDVVltdnFjcUtiMUxP?=
 =?utf-8?B?MWRPZEJjeHl6Wk5NME93U01ZeVhpb3RsNUowdWF5dm9BMDRJeUpQTzRoL3Bq?=
 =?utf-8?B?VWx4QlhleVo0ZXFVbjQzL21xVnBTdm9mR09aS1JncWtaaGZKWVNBcWZpTWI4?=
 =?utf-8?Q?nAujYA7yr8mjAm36ek1v3u2SEXArZnjCU4oqm?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C848E71164373F4BB78098895415540D@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aZ7zXTIRfKAnT+Db6it5DhIaNXx0IG9pNqihTmLUAbfUY9qCR+RyvPKNqjQcSpnKy6eoWhGxFegD9z0qKUsWjPgEI4+IplDapYsHcbmhySO5HoqAGeL/H7xplmg7pxrbh1Tr+sC53JsbluoMbNa1FGQQ6wjyyvqXNVoyisTKJ449MCF2+235u9P2L6ba62xUz5yu/o6+KUvuPa7yHkD7TJYdplJQS4KXMeID3ZDeiuJDWSF5LCwsdCKgyQzhjc/s4lF783WAXQGdE8lSEuLrwhJ46w3R763wMRRVK3S2FSsL3M7QDJEnDDiOsLAK+sqWuvt5Ivv1F8SZrNCU5w9FHQ==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac77ca3-cbfb-445e-968c-08def121ac61
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2026 05:40:06.1169 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pndt1MQ8+cyhtrkjzkpcpY/1KUFSwnuMT5r7wVY9InDrO5BalImLgEaHEr0xzKI+WCM9dAwP0eHJ8ERt/F1WklC6ymw28DhW4JEaM4kgpJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6987
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCk9uIFN1biwgMjAyNi0wOC0wMiBhdCAxNDo1MyAtMDQwMCwgTWljaGFlbCBTLiBUc2lya2lu
IHdyb3RlOg0KPiBDYXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVu
dHMgb3IgY2xpY2sgbGlua3MsIHVubGVzcyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBz
ZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+IA0KPiANCj4gT24gU3Vu
LCBBdWcgMDIsIDIwMjYgYXQgMDQ6MDU6MDhQTSArMDAwMCwgQ2zDqW1lbnQgTUFUSElFVS0tRFJJ
RiB3cm90ZToNCj4gDQo+ID4gU1ZNIGluIExpbnV4IHJlcXVpcmVzIFNNUFdDIGFzIG9mIDc4MGRm
ZWQ2ODg2Mi4NCj4gDQo+IA0KPiBBbmQgd2hhdCBpcyA3ODBkZmVkNjg4NjI/DQoNCkEgY29tbWl0
IGluIHRoZSBsaW51eCB0cmVlLCBpcyB0aGVyZSBhIGRlZGljYXRlZCB0YWcgZm9yIHRoYXQ/DQoN
Ck1heWJlICJMaW5rOiBsaW5rX3RvX2dpdGh1YiI/DQoNCj4gDQo+IA0KPiA+IFRoaXMgaXMgZnJl
ZSBpbiB0aGUNCj4gPiBjdXJyZW50IGltcGxlbWVudGF0aW9uIGFzIGl0IGlzIGFscmVhZHkgaW4g
bGluZSB3aXRoIHRoZSBleHBlY3RlZA0KPiA+IGJlaGF2aW91ci4NCj4gPiANCj4gPiBTaWduZWQt
b2ZmLWJ5OiBDbGVtZW50IE1hdGhpZXUtLURyaWYgPFtjbGVtZW50Lm1hdGhpZXUtLWRyaWZAYnVs
bC5jb21dKG1haWx0bzpjbGVtZW50Lm1hdGhpZXUtLWRyaWZAYnVsbC5jb20pPg0KPiA+IC0tLQ0K
PiA+IMKgaHcvaTM4Ni9pbnRlbF9pb21tdS5jwqDCoMKgwqDCoMKgwqDCoMKgIHwgMyArKy0NCj4g
PiDCoGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8IDEgKw0KPiA+IMKgMiBmaWxlcyBj
aGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0t
Z2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+ID4g
aW5kZXggODI0NTQ1MmQ4OS4uOWYyMTYyMmE0ZiAxMDA2NDQNCj4gPiAtLS0gYS9ody9pMzg2L2lu
dGVsX2lvbW11LmMNCj4gPiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4gPiBAQCAtNTEw
OCw3ICs1MTA4LDggQEAgc3RhdGljIHZvaWQgdnRkX2luaXQoSW50ZWxJT01NVVN0YXRlICpzKQ0K
PiA+IMKgwqDCoMKgIH0NCj4gPiANCj4gPiDCoMKgwqDCoCBpZiAocy0+c3ZtKSB7DQo+ID4gLcKg
wqDCoMKgwqDCoMKgIHMtPmVjYXAgfD0gVlREX0VDQVBfUFJTIHwgVlREX0VDQVBfUERTIHwgVlRE
X0VDQVBfTldGUzsNCj4gPiArwqDCoMKgwqDCoMKgwqAgcy0+ZWNhcCB8PSBWVERfRUNBUF9QUlMg
fCBWVERfRUNBUF9QRFMgfCBWVERfRUNBUF9OV0ZTIHwNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIFZURF9FQ0FQX1NNUFdDUzsNCj4gPiDCoMKgwqDCoCB9DQo+ID4g
DQo+ID4gwqDCoMKgwqAgdnRkX3Jlc2V0X2NhY2hlcyhzKTsNCj4gPiBkaWZmIC0tZ2l0IGEvaHcv
aTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5h
bC5oDQo+ID4gaW5kZXggOTI0ZTkxY2I4YS4uZGY3YTBlZmE2ZSAxMDA2NDQNCj4gPiAtLS0gYS9o
dy9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4gPiArKysgYi9ody9pMzg2L2ludGVsX2lv
bW11X2ludGVybmFsLmgNCj4gPiBAQCAtMjAyLDYgKzIwMiw3IEBADQo+ID4gwqAjZGVmaW5lIFZU
RF9FQ0FQX1NNVFPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICgxVUxMIDw8IDQzKQ0KPiA+
IMKgI2RlZmluZSBWVERfRUNBUF9TU1RTwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoMVVM
TCA8PCA0NikNCj4gPiDCoCNkZWZpbmUgVlREX0VDQVBfRlNUU8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgKDFVTEwgPDwgNDcpDQo+ID4gKyNkZWZpbmUgVlREX0VDQVBfU01QV0NTwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICgxVUxMIDw8IDQ4KQ0KPiA+IA0KPiA+IMKgLyogQ0FQX1JFRyAq
Lw0KPiA+IMKgLyogKG9mZnNldCA+PiA0KSA8PCAyNCAqLw0KPiA+IC0tDQo+ID4gMi41NC4wDQo+
IA0KPiA=

