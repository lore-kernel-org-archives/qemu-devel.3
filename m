Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE81E606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 01:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=FlTb6Y0i
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO2zY-0002hN-9d; Mon, 02 Nov 2026 20:07:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xO2zR-0002gO-5n; Mon, 02 Nov 2026 20:07:05 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xO2zP-00016m-3Y; Mon, 02 Nov 2026 20:07:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=miXhJckf4ljoUpYxJ0hZ87M3R/Rn41i3Yg9koxG8HPatueTDIPDcvE3nmWZ2MRPurtJFXT6bIqLVPCVRUYui9ekHJ5ZxKOCBp/6i8zMeEQpde3TS+4ijTLj3zwsM4XfV9sY8zw2nwNUR0fmNR7y89Shb+tdZer8mWSNIJP/EEP4VgeH2jWkTYDbm0AWOMCqBHscSsDqortANBcomA4pks53mrZHp40Ex2/SsMXvD8/98KhwgsiOuaQCOhzQL1Bc707u3KaFzoMmHvLoyhSVuZfKZkUfUZksLomov8MTvD+V5KcnnQGSWhnYeigR1/Zkqi0FDZ+6iRTZzlWGV8JAp7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=go34MtIrDoIAJ7bOKMgEXOwQawXkJ/fBGsvKPKakHw4=;
 b=fzCkmGV5h7yFm1z5zznBdECu0EN324uqlCVrSfbRF9dkkCyxjw3U8cpSDU7gkCiYgeb3gzTEyxMCsvSEB5KL/ldiiduyBTxMtAwI96v5t8ym/J8f3b3waC+ZGCUtVzY4PfgfY5oA9J/iLCSCat7oMwr2R1//DAKlEWmZ+97LOpotTcQenjmc28wuvyc2mRIZT675lvYdufKZdXvTU2YTMj4i4wxqpjthfv1nHVkmktOkjzTuQG044c5RQIEr2FwKp4tkSmovRFsyO5nU1x6j+pz1KUEsSo22v6555C2HgfIeoercEZH0xpAj44wQch2QPUeMuCWzNfQfgbRlJrjLtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=go34MtIrDoIAJ7bOKMgEXOwQawXkJ/fBGsvKPKakHw4=;
 b=FlTb6Y0i0HKJ7Qdk4ROpN9iBp4JyR9eBWRA/MVi6dsFpudmQoz9gRItqBzpIP5pJZ9Uj0psZ8qDGtUEgidnmWGA7pAiQ658eneElSAq1R4tt9dBLWldNA0f6dx4dRkfplSV7+E9YDMFWzUxCQiYxhRVlBHXVCB86eKE1gDYEXwnqjJnt91mQ9FjzAVKr4zFCR9WITaJkM5iNRk/+tdnGACLQ25UV467IkkfQ+nZSwINOYXaUJNwpNqmFIDlk863gigaiIbp50jzAZyuMD9sLgBRTALUdFuWzTaByaaYCwJ4fpLTpUD3DeuBoPlYh1pQK66rAV4g/9AAUV05ZjIspvg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEZPR06MB5542.apcprd06.prod.outlook.com (2603:1096:101:cc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 01:06:54 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 01:06:53 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>
CC: "kraxel@redhat.com" <kraxel@redhat.com>, "junjie.cao@intel.com"
 <junjie.cao@intel.com>, "junjie.cao@linux.dev" <junjie.cao@linux.dev>,
 "clg@kaod.org" <clg@kaod.org>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@oss.qualcomm.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>, Zhao Liu
 <zhao1.liu@intel.com>, Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>, Troy Lee
 <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v8 09/18] hw/arm/npcm7xx: Keep the automatic hub
Thread-Topic: [PATCH v8 09/18] hw/arm/npcm7xx: Keep the automatic hub
Thread-Index: AQHdaqumID06mim1t02tHdx0pgsQm7ca0acAgAC38kA=
Date: Tue, 3 Nov 2026 01:06:53 +0000
Message-ID: <SEZPR06MB73621195AB1AF1C2EDDC20C7FC692@SEZPR06MB7362.apcprd06.prod.outlook.com>
References: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
 <20261102092201.1729245-10-jamin_lin@aspeedtech.com>
 <179362845015.3960472.7956229698285370567.b4-review@b4>
In-Reply-To: <179362845015.3960472.7956229698285370567.b4-review@b4>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SEZPR06MB5542:EE_
x-ms-office365-filtering-correlation-id: cde99ac5-7aab-462a-24bc-08df3946bfcc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|23010399003|10067099003|22082099003|18002099003|38070700021|56012099006|4143699003|261026121527099003;
x-microsoft-antispam-message-info: F3TYOkyFg9f7k0D5q6DRVBgzKm4YdEiM9YskMm+eDt3PgBzzIbsTjQo85g0+7OjsyyOtzoz0gOP4Vnd7aSgU1/jU5CmjfzrqWhKXsHznAO/9Xy2XzdpcYOWbNdlIdtCzQKhLook/QRqechBwP8o3FNWml9PlyaG3VEWKd6pSzI51Mn3BfOH2Qa6/nRUSBFK0MGPvVivzruTXEnG/nrD+Nx0smlJyle5ha8O1pFIsBAAZOM0UMurG3k1dEvbTNTDat/aXfv4KdLNL1V4h/TO+GdCZu3v42IIj3Bn2/uAxQGRmmqLN0eLjBdlagrl1rnr0FIMYj4hlRv/xFlj8/ekj4C83PciHy1NHoFFEQRsPlKOazbvRcCSMgdOgru0rnqNLfvGiLMf47oTUvyfmNkQlYDb+fpsoNRkpkNvshZqjmSqxFaCO7s6X+6wenBKWMHzkYRvpcD35rKZfS4fGdskGGZ1qj0fLclyK3eEm93+eqtPSItMjqwpjGD+F2eD0FGC4XUBV1ASEWvQ88n1WUmdhupbCTWLYNX6W7hK63xA/8Rvf0dT+wAmy43PsnvQ2pPUb9fTOHhYfKZg+2Dof4T0MvvWD3PyLgN5uciHx5ebXfijJlOljp1k2uieUgQVJVPMPDJ7nGPELtBnXTcDfUVrlhUhmZrfbUhggryPhTKAjU521NGxyHe4UA5Xn2IgfO3gtTKrfa/82tcm1qhjZPE9kovX7+6574OT2DCypuOlOYBU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(10067099003)(22082099003)(18002099003)(38070700021)(56012099006)(4143699003)(261026121527099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFlVZnUvUkVOWXJyL1ZINk16T0ZrSE1pVWYwYk5tTVd4YVFseHU2QW9rSmo5?=
 =?utf-8?B?aXdFNlYzVlRXQ3l3Z0daM2MxeFJJUTloOE93QUhpZFlnaitOei9vNDFTd2wx?=
 =?utf-8?B?a3dFQm5kc2RJVW1OVnBJZmFCZlZpR2Z3R0N1YmpLM0VuMVduS0hNVHhUd0ZT?=
 =?utf-8?B?MmVWSkl4QmtPcmM5WWtQZ0tYcFFGZTlhTHdKZkpaZHhpT21KdHRkNFliMi94?=
 =?utf-8?B?ZDlVT0dUUndFMGxjQWFWQ3J1SlEvd29hQmZxS0JDOTloV0Vaa2FMTGl4SlNW?=
 =?utf-8?B?KzVvb1RLYnBzSGZsb0JuK2V0MVh2V0ZMMVo5NEpKVU13QlV6NC9TRFExQlJW?=
 =?utf-8?B?VXRram4vcTgzQkhiTnNkWUdDNlJiaXA4ZVpFMURMNktXMUp2d29TYnJPQU81?=
 =?utf-8?B?Nm5mcHBTNUpzVDRGb2pjckwxTnEvMSt1MTRpMXlodGRvVUhMNFk2VExjZFRo?=
 =?utf-8?B?M1FraVh2S3AvVlI5ZklUNm9QL3BVcGc5Rlk2RndpYktGWnhVcFNJNSt2SWxv?=
 =?utf-8?B?cFdXM0NPVnFiZHBWQXpLZHdiR2xreDNJYW5HTWJLeVFsd2NSU01CUUF5TDV3?=
 =?utf-8?B?Wld0ZnZoNUVLdm9STUlvMUtoTWZMWXd2aHRqRCs2eFN1VmYzb1NiVWd4aHNC?=
 =?utf-8?B?NVYveFM5aUVzbENGd21qRjRUUWt0aHFETE94SDE0dDl5cFVYM3UxMjBmSjBP?=
 =?utf-8?B?QUFhOG5uZy9XZ2FSOS9QVjRlWEJRYWpBblpFVkJsT0RmbTdMUTFHM0ViZm9E?=
 =?utf-8?B?alRIbXNuQ212MC9GcUxMMUlYcWRyTmdSTXRhM2lrZTlUVFgydEMrTjk2YTFP?=
 =?utf-8?B?bVlCTkQyRzZveXg1VXRWSDE4cDY4UzlQSk15M2JQazJpVVFEdXhHbzBFUDdZ?=
 =?utf-8?B?dm9MMjBnNjVoREZtdk9WZGVlSmp4MGlzT1JHaUoyZzlRNmM1WjIrdTNRdmpL?=
 =?utf-8?B?VStjY3hSVWtXdDN0ZUhxTk5oa01wRnJmc0RqWm9RYzgyb2dkSHhuYWFTdHky?=
 =?utf-8?B?Qk9pc1hMZjdZRXpRZUFiZHd2ZHNjQWpsdk55ODd2ZHkwaTBqa2h3QWptV3Rp?=
 =?utf-8?B?RC9qb2E1ZEV1Q3hYeDBLcUpkcXV6dXBPVURBS2hsU0daclZPVGJyM1duOTVy?=
 =?utf-8?B?ak9jcytBZTFYWXY3OUpUV0NtWTF0Vm45UDIyajNQRTdCYkhrY0phRjQyNmM0?=
 =?utf-8?B?TVYweHIzeUhWSHZiSjlDNjZRYTZBSFUrUXpLckUwRFNFTm5qR0orTG5qd2JX?=
 =?utf-8?B?STNxLzBsS2FhZ3ZiTGcrVnZLOUJrMjZERFBZdlZsb2h5RmNvQmtYVnRCMEd4?=
 =?utf-8?B?L2JoOVZPT21tT2laOCs0MzgremU4U3c3b2d3MlJlSkU2Q1Z4VHdENEEyLyta?=
 =?utf-8?B?VURBU0VDZmJxYkFWdjlLbGo2eWV4azRQUHlqemd3SFR4a3ZTMEpZNGI3Z1E5?=
 =?utf-8?B?T2RSZ2xUNEFHbFBaTFRzTFYxOUg1MXVLdTg0R2lET0V2dHdvZUtyOHFMMVpU?=
 =?utf-8?B?dkU5K0plNW9KSzZCaEJ5bUlLZHBoRFIreVVlQkkrVFdRbFhQb05WYTVid3JI?=
 =?utf-8?B?bmplcXd3Tmw4RXZlNWZjYjU1ajNtYVgzei9yYzhqRFJBaG9LZWE5Y3gxeWdZ?=
 =?utf-8?B?cjVYaEpweEs4dEZMMXVIaTVxTGM4Z251Vk1YWm1ZZDd0aGVDTlZmUTN3S2l3?=
 =?utf-8?B?UjJzRmxpTWhtRlhBcVhLWng2SUhWbnNxdTdFL3NhekJvaFhuaVdjOHBkRjJR?=
 =?utf-8?B?amZUTXlBT3pvblVrY2dKMnF1eCtYajFMY3NYZkoyQWhHWHRXQjU0WFNNUi9C?=
 =?utf-8?B?QVF1VlkrOUpraXp3eU9JNEJiVGw3M1IrelI1eDZRc2EzT2JmSWVxV1V4ZW15?=
 =?utf-8?B?UWxxZElJWFZ2QndQdi9iQk5iNUxSZ1V4ck5ha2dUQTJXS2EwWVgxMlpRSU4r?=
 =?utf-8?B?b0xldnJqY3k2TVhweG11Ukcyek1RR3ZJVmdBeDl5MVVUZTVQZ2lWc0puckUw?=
 =?utf-8?B?RUZyeVpiZFVLU2ZoTERpdTJMc2R3R21SQjU5YkpYUGxFckRYSlJCMjUvWEd6?=
 =?utf-8?B?S1dQRkQwTWJDbmJDbzBRLytUM3gza3VGVmpXcHhIWGxlZDFNRjJpL09QUldK?=
 =?utf-8?B?RnVqUUtvMnpIMEZ5MUZIS2g0NGdMbklVYS85ZWlaTVRRWHpzNzBpSXhBb2hZ?=
 =?utf-8?B?U284Mkc5cHk3YXB4K2ErRUVFdm95MmZjM01GNkhwN3laSzU3d1EwNERjV3M2?=
 =?utf-8?B?Qjl1R1FOQVBCUlc0b2VRdldKVEJ3NjlKdXRMWXB2bXphMzR2djIvU2oxZXNv?=
 =?utf-8?B?cUpWd2RXejdTLzJVdkoxVDV3dVF3NGhyVmd1b2d2eTVkeUl6SFhGUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cr+w5zswS/xONf2iYhN0zgzG1W9E7B8q9grTNTO4BTMqyM0BHEwp5H++wV/wjZxWUHeKDtG6LEEWr65eMIGgVF7kLy8rqMsuZHxOPpSAroITfRVQb5YDxSiQdLP6lml/dTPJf/YMzHAWxMxTgS70TP6OKitWlIde6y1rsfAOMPEXYtWIc9gVG7HIXRoL56duswsD/G9PfzGwldm3RTlGQiXLgvYIpEmVUFQ87OvHzlfeUIMZFSUT4Gc2/izzc3z9wKJUYjPb76GmGF5BMQRmbZ27lT8svzuURBmOC2AQP0EJ1m4V0KV/PamZb5YFSQycWizv5yS5tIb2z1cUAmwTKw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cde99ac5-7aab-462a-24bc-08df3946bfcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 01:06:53.7663 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ys712lVqTBf37v7IXyPJf6ZHjJZy+O+Njkyvayiy7pSl5RV4z4a4ZiCws45sS2K2tPSpKvim8M2FBmxvm4Ir7V9YXUF6q9s+zoQGL9Xd5TQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5542
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjggMDkvMThdIGh3L2FybS9ucGNtN3h4OiBLZWVwIHRo
ZSBhdXRvbWF0aWMgaHViDQo+IA0KPiA+IFRoZSBPSENJIGNvbXBhbmlvbiBoYXMgb25lIHBvcnQs
IHNvIGEgc2Vjb25kIGRldmljZSBvbmx5IGZpdHMgYmVoaW5kDQo+ID4gdGhlIGh1Yi4NCj4gPg0K
PiA+IG5wY203eHggaGFzIG5vIHZlcnNpb25lZCBtYWNoaW5lIHR5cGUsIHNvIGNvbXBhdCBjYW5u
b3QgcmVhY2ggaXQuIFR1cm4NCj4gPiB0aGUgcHJvcGVydHkgb24gaGVyZSBpbnN0ZWFkLiBUaGUg
Y29tcGFuaW9uIHNoYXJlcyB0aGUgRUhDSSBidXMsIHNvDQo+ID4gdGhlIEVIQ0kgY2FycmllcyB0
aGUgcHJvcGVydHkuDQo+ID4NCj4gPiBTdWdnZXN0ZWQtYnk6IEdlcmQgSG9mZm1hbm4gPGtyYXhl
bEByZWRoYXQuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEphbWluIExpbiA8amFtaW5fbGluQGFz
cGVlZHRlY2guY29tPg0KPiA+IE1lc3NhZ2UtSUQ6IDwyMDI2MTEwMjA5MjIwMS4xNzI5MjQ1LTEw
LWphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gDQo+IFBsYWNlIHRoaXMgcGF0Y2ggYmVmb3Jl
IHRoZSBwcmV2aW91cyBvbmUsIHR1cm5pbmcgdGhlIGRlZmF1bHQgdG8gZmFsc2UuDQo+IG90aGVy
d2lzZQ0KPiBSZXZpZXdlZC1ieTogTWFyYy1BbmRyw6kgTHVyZWF1IDxtYXJjYW5kcmUubHVyZWF1
QHJlZGhhdC5jb20+DQo+IA0KVGhhbmtzIGZvciB0aGUgcmV2aWV3IGFuZCBzdWdnZXN0aW9uLg0K
V2lsbCBkby4NCkphbWluDQo+IC0tDQo+IE1hcmMtQW5kcsOpIEx1cmVhdSA8bWFyY2FuZHJlLmx1
cmVhdUByZWRoYXQuY29tPg0KDQo=

