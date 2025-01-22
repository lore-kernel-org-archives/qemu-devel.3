Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0DDC02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 07:40:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taVL6-00069N-VA; Wed, 22 Jan 2025 02:39:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1taVL1-00064J-Or; Wed, 22 Jan 2025 02:39:47 -0500
Received: from mail-psaapc01on20720.outbound.protection.outlook.com
 ([2a01:111:f403:200e::720]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1taVKr-0007pt-MQ; Wed, 22 Jan 2025 02:39:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mqs4kun8whJwwgKqGr0o6YZqnYgkLvezK8rmXVaoQLjQIa02IoK+j7Th0wIbMNCPmcL9hK8acSSXDK5Up1sz24eXQOa/g9Fzjn9tDDwnlnDIIE73QXuYdjpAphgm9pSg/afSfxtLePQ5/kCZQu3kmzAgfRHuEL9b6p9R+FgbgtkE5y+2vP+p84+nP5hXQVF8v+o17wrSRHDB7JopSuIWFh+9o3h1WgyJLJn4bVj30M0vfZUWDymxr4zBaIRQNhUb4/IWxbpzwXrdE4RyN2i5yVsF9N/D8IcF8vfZ19hE0YgZsjpNLc+A+Bxab1T6KMDvDJszuW+ey544Y89ophRYRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g459yUDcXuMPghFcxEzIx7d/1HsRziFOzp31uvdseeA=;
 b=lSLf+DYZOQqWKRJDUqbDJBx/dxCrDuKYsPxHbz7O8zKjeHnvaJB5spFZvvIpTywAtLmIBnEJ9rDMUzB57yX12+QfJVQpIDAvyeKCXrt5uby+d0kAihyRxECv4dgRbcV2FbtbItlGW3JgdJjQ56zCKmnkVDBHt55JXom3Zom/kUhkdKhcmiSprh0gV+zvgvCyN6Tgm0CUzjMAw6B0+UCpanyDY89XItCFsDwUXcEYwLsvG3jauYraHHHWJdwt97shaUN9j3LAptjffXx+Xzlo9N1y2/N9336L46RrWYbkHft3TFo17HLj82KWt2tDnxPrJPgVQFdi/U6ANMiGvtmh4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g459yUDcXuMPghFcxEzIx7d/1HsRziFOzp31uvdseeA=;
 b=Par7K3woxdTrlrCyDgUc7YfUYVopUWoYbMW6eCspDdPGjB0YQIK0JbFWMwlqyvSAu/Y8NBhHypaWruNXLVq7E5i6FKSEXzfRgkc0BCUX6XfRnXc1xTcaGs4bnfrG9+660nz20F6BdjPBlxRsDYgQj2ummhqpl10wRhzNXLgUrIjTsdUP9qOCZVwBrQPYj51O10X72XcLSR7Oz510xvl5C1r8wYFuBPj4qqrm5jGnMzvPu+h054DsxK+oFkj1V2nG5h0nnZ8KVhFz978iM2HMtVbYpBtIMhqKSGylFkm9DUz0j7dR+lUtZhvlWS97j2J7sYbaKVso2VN9dxv33R2fFg==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 KL1PR06MB6848.apcprd06.prod.outlook.com (2603:1096:820:106::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.12; Wed, 22 Jan 2025 07:39:28 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 07:39:28 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Troy Lee <troy_lee@aspeedtech.com>, Steven Lee
 <steven_lee@aspeedtech.com>
Subject: RE: [PATCH 0/9] aspeed: pre-PR for QEMU 10.0
Thread-Topic: [PATCH 0/9] aspeed: pre-PR for QEMU 10.0
Thread-Index: AQHbayHj1bnQNSChw0S0GHLE5YpBB7MiJMtwgAA9soCAAAQYAIAABIgQ
Date: Wed, 22 Jan 2025 07:39:28 +0000
Message-ID: <SI2PR06MB50418AEE3FFB73303DC96AEBFCE12@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250120095820.516511-1-clg@redhat.com>
 <SI2PR06MB5041DEDC7F75EA997D4ECCFDFCE12@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <3bf8a71a-f2a8-41a8-bddc-45d220a953eb@redhat.com>
 <cc49ba5a-9fd0-446e-9774-f1ee1fb8a850@redhat.com>
In-Reply-To: <cc49ba5a-9fd0-446e-9774-f1ee1fb8a850@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|KL1PR06MB6848:EE_
x-ms-office365-filtering-correlation-id: 81e2729a-264f-4dd6-6989-08dd3ab7e6ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?L2g4Sis2UEVzTWJvTmcrV08yWW1mK0UvTTFqL3l6RXB6Q1ZLanhPM2dEdmhX?=
 =?utf-8?B?elIwbnZubFdYbCtVMVdpNVNDcnNUVHNyNC9raWo2NTlzVnpyNlN3WFowWnZs?=
 =?utf-8?B?Q0N0cnplWitHaVRZZDcyNkVLQTZ5ZmdqdVVOV3BLODJ0WjYrWmNDUktoRkpz?=
 =?utf-8?B?K2p0NDNoOStCcy8rUjhtZ2d1QnJMRGpwY0pHMVVrYTVoc2YzeUhVV3hGdmxB?=
 =?utf-8?B?N3YxZ3NTZzBPN3VFbUduS1hiZjcvV1hybndCeGhXaUpkdjh4dDdNaCtnNTEy?=
 =?utf-8?B?K0Q1SklCUXd4NTZGWEV2ODFHanZTeVdZMW9RTk5LZjhwMkpZeXNwY0JrditD?=
 =?utf-8?B?V00zTEZTUWsrTEVFTWpKYXJjR3hKQm9CT1dVdTJPUHVMUnE4VkttTlo0a2lX?=
 =?utf-8?B?Z1Z6V3NrZjVjMmlFRjZ4Mm5HZFVJRGtudnhRak40M3ZBVGJ5M2o1WkExRFNF?=
 =?utf-8?B?RmpqY0J4Z1ZGZU9rTmdyMVNrMGVnN3JiK2RnVjZIMTc2cWJDOFpSUzJYVEcr?=
 =?utf-8?B?RUtJZVR3UWVwUzRZR212K09CTHBGVVFGc3pucTRUeVZ1ZVhlaVc5SXBmOElY?=
 =?utf-8?B?Q0hCSE5hTkZzTk9IbGJSY0prL29xK3ZWcTRSMGVUSm5MK3Z6TjRaMjdrUS9B?=
 =?utf-8?B?ZGM3dEt4d1JKZ3FsbzVQdlNkNUg4dnZqYXc0TDcvZGVvNG8wVWpvVHVjUFFM?=
 =?utf-8?B?OUY4VGVMYW13b28yaU1Ia0NZeWtycWJhZU0vRm9BLzk1ZjNMWTV6TEhLd3Fu?=
 =?utf-8?B?RHc2c3U2a3dkQ3hNYko4Y0k3cmYwR0Q0VkRFWkpReGw3TDE4TFFTVElYQlcw?=
 =?utf-8?B?bWY1aWlwKzRFQjRjR2FVMXdZRFU5enphM2JwdDh4Qkk0Sm56KzQ4KytETEZ0?=
 =?utf-8?B?SW96Z1I5cTdTc21JVkJBdkZGb05mYnhaRnEra2hSUW4weUVTeC9YRDNqa3NP?=
 =?utf-8?B?TTlWSlNDTnZ5aUdNMFIyUjZPRG0va3F4dHNUM1RaakN2OVlDZ0J4TWhPL2Vm?=
 =?utf-8?B?eDU4RGs2U0Y2VlRFdzF5RVlxRk1nOHM3Qjl3bHdFb0hpMHBpNWRPTWhZVjNL?=
 =?utf-8?B?SWVlekJ5Qlhod2g4MDd4bmFCRmRGcUNPMXpGVWpIVmpvTVl5Mm9iempLbG5R?=
 =?utf-8?B?VjlyR2ZXNHM0V0JVc05mWitWb25rZENCN2ZOUkJpY0FNTWxTbzdJWk9WNjh6?=
 =?utf-8?B?UHNTSGpveGFaSThxSFVvQVJpSDJwMDByS2hjZDhFWGtKODN4VlNSM1lRVE0x?=
 =?utf-8?B?Q053SW9UNmlQQVJUVmRUZm5YMDEwRFl3Z3lYNWg2RlJYOFpzM3ljekdIck5S?=
 =?utf-8?B?WlpmNWlzZmJSZEY0V21DQ0RCNyttanpEcFc0YzZBa0pLRVMzdEYySzYvWWRB?=
 =?utf-8?B?L1grck9hbDhNK0IrZjA0dW5Hc1hoUVZUWTM0S0d2di9oeXo0MFlUWExUNkRt?=
 =?utf-8?B?UkE3eVJ1Qm9XMkxNSkR2cWhsYlI2QlRRVzk4UnZab0wvUXNJTVUvQ3FuM1RP?=
 =?utf-8?B?THczZW5rYUppaVdrdm1Ta0xxUXViQ2FMMTkxZUtLTllZUVAraDRpSEZwQ1RO?=
 =?utf-8?B?TGtXSHZVQk1qUzJGMkxOZWVUclZlenduU2QxVmVHWFZRZE5UZ0NIVHk0Wmsv?=
 =?utf-8?B?bWwxKzBRZktjZ1AxekFLUm4ybm9BKzVYWGFSQ1JHaU80YmRaZ050eEtIQ3RG?=
 =?utf-8?B?WCsrYU1LY2pYZktIL0drYzRjeDRITEtkckNWcGlheWxkYThDc3lOcjdud0Fy?=
 =?utf-8?B?bUQySjNCZnVLR05HeWxCa2c0Rm5NVWRnL2NXRVFxMWU3Yytsa1VNZmc1WjdX?=
 =?utf-8?B?akdmRWYwWElDN0lSR3l4anU4Rm9hZUxVZ0pQOW5WQVpFTGpPZWdJNER5MCtT?=
 =?utf-8?B?WFFmRkRoWUpESWRiZTJwRnUrS1lpa3Zhc1VSZGFJUHFFQ2VnRmhVY1pPby9B?=
 =?utf-8?Q?GvE6sJPI6PwRUaS3OTQwckFMIVkqfXxS?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmNCUGw4MTFwRnk4MU1OaHB1QU9GS216Q3FWcXVYV21LLy9qQ1Z0cjRJTXRp?=
 =?utf-8?B?WS9qYjRCM1RyWWNyd25FbFkreTZVRVRoMWNuWHNTRmRJU3RQaGdqNkJ5SkE3?=
 =?utf-8?B?dE1UMUZPVmR1d2FqdGN3eWhGeUNPMHFSbFFCbGN6SEJvM2d3N3JMVFlVWHVJ?=
 =?utf-8?B?UWZ5QmF4eGtjZ0RQVVRmYjRPWEV0ZDRvKytld2dCcFh1ZDdSUXh6WVNPNG40?=
 =?utf-8?B?NDVpZ0k2aCtQVEZxd0I0dCtXSnpCbzIrL2ZTUm00SElFNk1BL21rYkZPb0VT?=
 =?utf-8?B?SG9OZjVIdmNnSTgrUTR3RUwvcVA0R2lYQytoVDl3a2ZnN3crQ0IrRm1oTWdK?=
 =?utf-8?B?TDE1TXR0c0k1VTFtRWJ6ZmdtUHFrczgzMS9QSE96c1NHV3B4aVdXemJOM2VG?=
 =?utf-8?B?cVhMSGhEUmhOaWxSbmttM01Pa2xpWmVSYXN2TUl0VXZjR0pKOWRMUCs3bW9s?=
 =?utf-8?B?QndLcmNZaEtxZTJadnpOY1FrUDVSVU1ZR3hudUhLTzFBOEhFd2p6L3pLQjN0?=
 =?utf-8?B?U0FVV2hzVjkzMU1FaXA5a3F3ZmozUWMreE5TT3l5Y1NJVVBvMGVHOHJPTzZF?=
 =?utf-8?B?cTZoSzMwSG9KRFNCenhnWVhPNGhxVno4VWFqSFBKdG41bHlrREV1ZTRaMmxq?=
 =?utf-8?B?eldPMFVPU1NQRVJoL3p4Q0d2S1VtWXpqS084WHFqVitmOTlrbG1KNnNneXln?=
 =?utf-8?B?QndlZDE4cEM4NUtMYTRkdnN1L2o0VnRoV285Rmd3YUhwSjlGWCt6bjU4WGVX?=
 =?utf-8?B?ZXcrMk51a3JIaVdiY0tndUhIditoV0YwVmx5UmsvdGVna29scytnZithZTRL?=
 =?utf-8?B?Rm9nOVVFMDBVVXErL25vSzVqTFhYdjBvK2o1Rzh4Q240cTlCSTkwdWVQWDc5?=
 =?utf-8?B?K3AxZnRYdmJXSGJUNExQdkZCTG94QzJ3b3dhUjI3OE1nYUpRUXhlWXVJdWdJ?=
 =?utf-8?B?YTN5SVNiWmN0SkV0YU1Zb2dEa1dtc0wwMVNSdzdBM2Z3ZVBScTBwOUdZelJM?=
 =?utf-8?B?SGlkclZQVjlBeHV2ekd3eU1VVktmVHByY1JSMitldFdubjhGS0hMN1VYTnl2?=
 =?utf-8?B?Ry9kUlR5SHRadnBiNlVDdEZqL2x0Qy9ZWDFRRHpzZytMbDU5SWh2SlhBS0lD?=
 =?utf-8?B?MERPZm93MWpBYUJnSDZkQi9VdS8rdDJxd3NCSEV4S1NQQ1NwVy93KzllRDlH?=
 =?utf-8?B?OG9sNE5iYWM4cFl1WnVGVFVmWk5VMTNvU0JVbFdKWTBXaFBNMlVJaTFwT293?=
 =?utf-8?B?VDU2MGVMdE9BazlINEpMbUo5aEE2elB4bFY1R1REZUpKMGRjSldnOFJJelhs?=
 =?utf-8?B?dWt6L0EvSU1td2txYmdlTkV0TjZBbXVyVG5jTXFmSVF0Rm04VTBnMklQbmRv?=
 =?utf-8?B?N0w1WnM3UWt3ZzVsOTZBWVp3cTBMS01maU54U3FHNTRyNVpGUXhjYXhPZGlS?=
 =?utf-8?B?N2hvUmNxRVE4UmwvRSthbjdQYmZKM2dHeW5ILzJpTzk5SElRU0U3cjJkWEN6?=
 =?utf-8?B?TU5TRW1Pd3JrODQwdmpibTh4d2pzdU5BMlZFZktUL2dIM3lhWk5uUkI2VVNO?=
 =?utf-8?B?MFIwV0hOelFwejZiYVZvZElqblloT3F6Mllld2hFV3B1UmVvZzB5R2ZZTEVq?=
 =?utf-8?B?VWJpV3ZXMXBPM3VmT3o0VEc2MEkyOTJXd205a1VheEkwTDc5QzF0VFhkbTVw?=
 =?utf-8?B?M0NKcDlOUnZ5blFjUy8zenZQb3dlcHVaTnIrMjlqNmIxdHIvOXYycXVEd04w?=
 =?utf-8?B?VjdZOVRrcW8vaGltVWozdTFCNVlsazNBUGdVbml5dGdZY1JBclNFNHgvamhP?=
 =?utf-8?B?eEsrNm9XT1llbWx6aEE3U25xMVZrRzEzSjByd2F5WmIyck9qcUJJaHlyb0RZ?=
 =?utf-8?B?UzdoaDJ3Qy9rQXc1ZTlMSWxxSWZoeHpxN3FySmU5QmhCWnQ4SFBCbGl4a01q?=
 =?utf-8?B?L25wcVVwYnc1YzJNcXRReUtKYWM5QzJqQkc1Vk9UeWpaSGRjRndEdW1RYVha?=
 =?utf-8?B?VXo4aHJnaXhyVklNQ1FlaFloL0lLYlpxaXZ0cnNYZnE3Zk1wMTVMa2xxQkFB?=
 =?utf-8?B?dldxclh5R3JYQS9NZ21sR0ZyY2IydjVSUUkyWDcrVUZhZ1NCUEdoaTl5dTYz?=
 =?utf-8?Q?tN9MfiFwuK7lkgSxnua+VssFp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e2729a-264f-4dd6-6989-08dd3ab7e6ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 07:39:28.3933 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: njhaLOjYwTaAZZ/dbRACBXKLBe5o9RrIpH8pEPZ+vZle5yS8N+X98R7+L2tlpDBCgLYNFmIJv/u4CMxUOMuqbxG8NuFovIl41unGgcBv5nY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6848
Received-SPF: pass client-ip=2a01:111:f403:200e::720;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
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

SGkgQ2VkcmljLCANCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lk
cmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSmFudWFy
eSAyMiwgMjAyNSAzOjIzIFBNDQo+IFRvOiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNo
LmNvbT47IHFlbXUtYXJtQG5vbmdudS5vcmc7DQo+IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBD
YzogSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47IEFuZHJldyBKZWZmZXJ5DQo+IDxhbmRy
ZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+OyBUcm95IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5j
b20+Ow0KPiBTdGV2ZW4gTGVlIDxzdGV2ZW5fbGVlQGFzcGVlZHRlY2guY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIDAvOV0gYXNwZWVkOiBwcmUtUFIgZm9yIFFFTVUgMTAuMA0KPiANCj4gT24g
MS8yMi8yNSAwODowOCwgQ8OpZHJpYyBMZSBHb2F0ZXIgd3JvdGU6DQo+ID4gT24gMS8yMi8yNSAw
NDozNSwgSmFtaW4gTGluIHdyb3RlOg0KPiA+PiBIaSBDZWRyaWMsDQo+ID4+DQo+ID4+PiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+Pj4gRnJvbTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNs
Z0ByZWRoYXQuY29tPg0KPiA+Pj4gU2VudDogTW9uZGF5LCBKYW51YXJ5IDIwLCAyMDI1IDU6NTgg
UE0NCj4gPj4+IFRvOiBxZW11LWFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcN
Cj4gPj4+IENjOiBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1PjsgQW5kcmV3IEplZmZlcnkN
Cj4gPj4+IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+OyBUcm95IExlZSA8dHJveV9sZWVA
YXNwZWVkdGVjaC5jb20+Ow0KPiA+Pj4gSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5j
b20+OyBTdGV2ZW4gTGVlDQo+ID4+PiA8c3RldmVuX2xlZUBhc3BlZWR0ZWNoLmNvbT47IEPDqWRy
aWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4gPj4+IFN1YmplY3Q6IFtQQVRDSCAwLzld
IGFzcGVlZDogcHJlLVBSIGZvciBRRU1VIDEwLjANCj4gPj4+DQo+ID4+IFNvcnJ5LCBJIGRvIG5v
dCBzZWUgdGhpcyBwYXRjaCBzZXJpZXMgaW4gdGhlIGZvbGxvd2luZyBsaW5rcy4NCj4gPiBJIGd1
ZXNzIHRoZSBtYWlsaW5nIGxpc3QgaGFkIGlzc3VlcyB3aGVuIEkgc2VudCBpdC4gV2lsbCByZXNl
bmQuDQo+IA0KPiBUaGVyZSB5b3UgYXJlIDoNCj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L3FlbXUtZGV2ZWwvMjAyNTAxMjIwNzA5MDkuMTEzODU5OC0xLWNsZ0ByZWRoYXQuYw0KPiBvbS8N
Cj4gDQo+IENvdWxkIHlvdSBwbGVhc2UgdGFrZSBhIGxvb2sgYXQgdGhlIGxhc3QgMyBwYXRjaGVz
ID8gVGhhbmtzLA0KPiANCg0KUmV2aWV3IGRvbmUuDQpUaGFua3MtSmFtaW4NCg0KPiBDLg0KPiAN
Cg0K

