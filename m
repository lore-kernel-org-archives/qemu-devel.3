Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F70CD342C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 06:37:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slN9M-0001qK-0b; Tue, 03 Sep 2024 02:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1slN97-0001ny-A5; Tue, 03 Sep 2024 02:36:11 -0400
Received: from mail-sgaapc01on20707.outbound.protection.outlook.com
 ([2a01:111:f400:feab::707]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1slN90-0004JM-7a; Tue, 03 Sep 2024 02:36:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T6pPbAHbhY842iCqHFr2p6Xwt7CwDmFJzGGPygxkwwBbaBNInQPtVV4kxblzt1b6Ao+1uLVdi93970TlWalpzBmzkHUxdCdwGf0wjift02BkAVLMtR5cFC2+ELNsfg7W6zGmpgh2gmZwoHpJrhq8MybNCheUeaF6GXerzl0eQeEEaGyD5C3JcX6VEnezsxd0Yt88wi9LuVoT8Zz3phJY6xXmsJhEvjBvB9QDQW/6w4uSOKztoKaOd81Aj3iFeYm2pM+pMxJ0vlR7y3HOVGog/IMXOi43j1+IUCx6pvj2KZ62RonQKTF+BvVRgBk37ZrUTlaNzm691u5un53DwMYTyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLFM0qJBPsTECmIWJdpiDzJ2LkJ2t/mfLDL5VwA5pIw=;
 b=MO4YsYibLeWU2mezKfAUpDE7nT8dck8i/xNM0RKcHhNX7msJhY6ti3Pg72adzqcAFUC/3Wi3UNPUejyG3cR0zg/BGkZU30vuAq/BelqZ73DkRzsOkqlLFS233nZ+kavGpHacQYx/wQ4lbdtxfANScH0AQCj4iVTBYd+NL5wIPU480kGEL8hn/icocctg5umbjygK141BkxExk+FT3nXRzkowwB2C1S8/poB9xEmtb77tdAxOMgl5r1gzMGDbf2IK/GgWqaUzXuD+aLKsXZWE5hcOGJnVjSKEIW+D3bRoQV+MmQmtnFsiGdUgpnwv1bsg/uzMOO41WRpqeEY4hYy0iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLFM0qJBPsTECmIWJdpiDzJ2LkJ2t/mfLDL5VwA5pIw=;
 b=Kj1CczNXVuhdjSTIHm6Qiua3MeyJ+WJwlgo6LSreuSzGUMVjBGfvWsshNOHsITD76m2CfKeWrIz3B8ODeM7SdmqrzPhSQyqJGMjLS1dj04JYSjRs9FfXxzkkQ2oeBA4dQo8ofg78nVVSDLpA7BihB4YkNfF/uMNbICOQfygfCbZIZDszuSNt1BTCuyKWEwpUHKbU29zSmzj+zUQgSfMfAjIK0QPqHHRkrwwh0Bv5YFUDF/jyt4EdgSohCVb4p4R6p3YdYpJBX5yb0VZADlx/YiS/dTXTyKbZlXPVZH26TLJKcqk40zHu/nnG1w5u/TzTFahui1nSGg+yO4U7AVXk5g==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEZPR06MB6600.apcprd06.prod.outlook.com (2603:1096:101:179::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.25; Tue, 3 Sep 2024 06:35:52 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.7918.020; Tue, 3 Sep 2024
 06:35:52 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Cleber Rosa <crosa@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Wainer dos
 Santos Moschetta <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v2 08/11] aspeed/soc: introduce a new API to get the INTC
 orgate information
Thread-Topic: [PATCH v2 08/11] aspeed/soc: introduce a new API to get the INTC
 orgate information
Thread-Index: AQHa6T2YSKjgZQWco0ud/4IGpv9xvbJEvTYAgAEGKlA=
Date: Tue, 3 Sep 2024 06:35:52 +0000
Message-ID: <SI2PR06MB50418EFB6457EC3AAE90201FFC932@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240808024916.1262715-1-jamin_lin@aspeedtech.com>
 <20240808024916.1262715-9-jamin_lin@aspeedtech.com>
 <935912ca-d664-4543-8d82-e8a32ebf78c5@kaod.org>
In-Reply-To: <935912ca-d664-4543-8d82-e8a32ebf78c5@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEZPR06MB6600:EE_
x-ms-office365-filtering-correlation-id: 832da1e5-e713-424c-dd20-08dccbe2a844
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7416014|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?KzN6VVNwR2R6MTFaNVIwOEtwc2ZqckgrbWsxSzZ4TDJQeGJRNjhjV253MVdm?=
 =?utf-8?B?MFNyeGZyNm5mR0JnS1k1VFcxQ01WYkdqK04va2FqQ2JueVdjeTdUcTBKZXpH?=
 =?utf-8?B?WXVPNERKODZkOXNTVGtVMlExNzRxcHBuQStmWkRHWnBiQjFCUFk3RnJ4UUJN?=
 =?utf-8?B?ZWhTT2xjOTBTZEtUaXNENk1ZeEZUUmEyNW1nck1RZFRrRjhwMGdVbVZZbzNo?=
 =?utf-8?B?RUxFcDNMSEw4RExNVCtVNWozTXVoVlFZTStPRkg2R1BVSE41cjdNdU5mc1Bn?=
 =?utf-8?B?U05Ea1BERGhCcVlVT0dTYkpnSHM0Y1kwUy84QU9lbGZNcGJWbFJMUEZFWFVM?=
 =?utf-8?B?cC8yMHAzRzRCRElDamVQb0ZWc0QzWldkMmpnM1NBZlJHWkRrYUlNa2NuSGFj?=
 =?utf-8?B?aFROYSthTU1YOWVVRkpOR3VBaWVkQUE0N2o3V256cmhGK2pXTzB4UklkKys2?=
 =?utf-8?B?Q3dsZTlPZnNhWTFpRnNXOWU3REtZSVZxcGJ2T2VHWDg5ZnUwUitHMnl4Zlo5?=
 =?utf-8?B?RDVydHE4dDdUR3llSkVXY051M3RlLzZKZUFuQ2hmN2pyZ3lRVjJITGMwK0E3?=
 =?utf-8?B?STU1UWVMQUpINnYwc1I2ZjFudVNWM1RHNnJkN3ZFSW9YRFhRY1pVQ1ExdGEv?=
 =?utf-8?B?NDlmYWpuK2tDdjIyN0ExdlhpZ1VxNDlMS3ZXRmQvaDJjalljemljNm0vOEpp?=
 =?utf-8?B?WkRyYnA2Q1QrNjlxbFVQbVZVNDBsaTEwZmVLYWxXdm9aT0VrdSswUGVNcElz?=
 =?utf-8?B?dnhTK2ZFSnRCZXgxV0ZjMmM5a0sxRXFxTUxLUEhuZStrUXhFb3Fsb0FiTUVz?=
 =?utf-8?B?TVRtbllXZEJZME9zWnJ6aTdLRU0xb0FJVHU0ODRuZDIwN2hKNVplT1NPMFZV?=
 =?utf-8?B?UFFZVXB3VE1EdU1XMkY3ak4wVGlRNHBXUXgzQm9NR3J3ZEt4ZVA4L0hOV3V5?=
 =?utf-8?B?Z0RRUEFKcUJzQkgzTUdGbEZQOWtxWlJXN2dWMWd5YnBiVFErdUc5K1NKVlVH?=
 =?utf-8?B?RFBTN2JZcmIycnNoY2E5SGRFeU15dnl4ZXZCNVJLdUQ3a3Qxd1JEQXZ1eVY0?=
 =?utf-8?B?UUtjVU5IZGxyMjFYUUMrcnN6dXdhR2JwVlozeXlWanllYjJZTGVoYTdYR1NS?=
 =?utf-8?B?Y1VVN0g2WFdmZXlUck9pNkJZeDhXQi8yUmE3YXdBVzkycWIzOVI1a0toM3lI?=
 =?utf-8?B?c0YyanJKZ01lOGxVcDZSeHIzcWtGc0MwUGRwSzdTS3RVK1NSR2NqMEgrbG12?=
 =?utf-8?B?QmFJSTc5OHlrOFdPSUpYQU5seDgzUkt6dDY2NjlMVzFCWVU3ZUpwRkVvNkJF?=
 =?utf-8?B?eEJDQ2o5SkEwNEFJUW8vS0hxSlBCQmlIaWlkeEtHOU93K2JiVVZ3eGNza2ZZ?=
 =?utf-8?B?MFMxNDZscEVRSy90VEc0U3FrUUdtQ21xV0tVdUo0Y3BpRXdFWGhsNVJTQ2l2?=
 =?utf-8?B?UnMvUUp4OHhQZzUxNkdnQmJ1dGZ0WjhCU2ZiWlQyTXlaM0JrWWZlLzBnSVdG?=
 =?utf-8?B?T1g2aXV6NkROZ2VhZnVYeWZEYnhKblZteTErYlZjWjIxR210RlFLMDRVYW02?=
 =?utf-8?B?ejI0VnZwNEJ0aUtVRmo2Q3BiU2xxMk1xZjkwV2hJY0NCU2gvcXdKc0RZUUx6?=
 =?utf-8?B?RXRqUmhCNzJPSXRXTEtGZ0c3bVc0WkhyZTZaY0c4MXN6bU53cWhzS1h5d3Q3?=
 =?utf-8?B?R3kwY3FzMWNSQVVFZUhtRGtBOUZ1THZwWndNT2tqbG9pVVliS3Y5RVNibEw3?=
 =?utf-8?B?c1ZtMkhWWDNzZnduNHdGcmJ5K1NqMW9NMWp2Nm5yWTVaaGxhWnoxRlBjbGk0?=
 =?utf-8?B?OVF1WEJsdXJZbG1pbVpsV1ZGUWpSejZab0xRdzA3QW5wNnk3SmFrbmNEdWhq?=
 =?utf-8?B?czFYMjlDeGV4OHFyU1UyTnhGL3ZDb25XSlB5eGRHTkJqVzZnYzJBMm1tdGN5?=
 =?utf-8?Q?/LagO+h/j6U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7416014)(921020)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VERIVWkwM2JXQ1c5OXVObko0Mm0zaVVxRXFxWnN6VWFPanNlVVVZK0VmY0FE?=
 =?utf-8?B?VG9EbkxZdWNod0gxNllYZCszaGtDbi9XeHhPby82bU9pRHFyeWZhZ3lCTWVR?=
 =?utf-8?B?VzlOUGJ6N0xlZEJGb1IyNm9UWkNlS0FtUmxyRkNCK1ErWkxWVWo2c05PbGZ3?=
 =?utf-8?B?NklXZWJqdEMxRUY1VlV1NG1CUmVLYWJLRzJiUlBic1FlVDIyVkpIK3lJUFNY?=
 =?utf-8?B?RjNHSFIzN1NiMHUwbWNLOW42VVozZEJ1bHp0NkJ4MEQ0c0ZhKy8xRk5RQi9Y?=
 =?utf-8?B?QTJROHhRR29NYjM5THBXeitUL1hrS2YvWGlPQjdqd0lhR0hiS3lzZUtoSEJH?=
 =?utf-8?B?aXpOejEyKzBQa3BEejhqdm9mVjhGelBJc1ljV25xM1pmQkozNm94NXpqeW8r?=
 =?utf-8?B?ZzhQcGxmWk14UjI5UnB5UnpkTXdBcDNXeHFxSDE4V0swRko5dDV5ZmwrRGpR?=
 =?utf-8?B?WHR2eklueVB0RFUwWm0vY0c2YzdDNC9veFBwS0QwcUo2MjhOdis4OUhneGlw?=
 =?utf-8?B?dmZVWHgzYjIwWVBDOElHUmFubEFUWTczSzh1eVZ3RnhFRFM1bXJST0ltdWQx?=
 =?utf-8?B?dU9EVHlneEJDeXMza21hWUpBY2dLYVJhR3l3S0MyUVNXc2YyVlBnV2NWbFAr?=
 =?utf-8?B?WGxNeFZpeldSUTJTMEdXajQzKzRtV2Q5R0k1TUNsN3M0RmNFY0RaZU5VN0FZ?=
 =?utf-8?B?dkxIcU4wR1daQnV6K2kwWlhTbXVzTTIxdmxYRDdJNTRHa052TjdnVHBDbW9L?=
 =?utf-8?B?OXl4MkUwZW03TDlhbmN2TmdrWHVxdEVEK1dGUFJqWkVyMHgxazFjUjlQdnFa?=
 =?utf-8?B?dlhaSjZHNkNMZm51ZkJBemJ6dmJXcGZ0SXJIUmEvWE1RS25VK3VUbm96RUJv?=
 =?utf-8?B?eTRxcnUzcllrMWd3L0lXclA1a3JScER6Y2lIbGlGVUNGOWVyc09LNC90Zk15?=
 =?utf-8?B?WENIMDhsT1BzQ250RExEQjlBNkdJM29VNlpVWDMxK1dmdWFJNXRJQVZZaHNQ?=
 =?utf-8?B?Z3BHVC8rVHQwK0FJVHBId0l3eVczZWNROTExRVB4d1BUSTJqMVJFK2RSZ3Fk?=
 =?utf-8?B?YnpYQ3lZbktUWWlaRUNjOG1vbGI1TWlYL0RRK1VHY2NqanFDV3RmSlhBR1Rq?=
 =?utf-8?B?RG5TYkNrVzFKNFlxbXhZUitGS2k3UVlVdFViTExVZUNpSyt0c1VjN05wNEpL?=
 =?utf-8?B?S0ZBY2pWUUJjSUVkZTdTeXAvTHBXenVFSWtWSEFwUFhzZDZkQ2NsTDhsUlF6?=
 =?utf-8?B?MGM0bWhiRDkrcUVDaERoc2RKWWhoTXFQTHY3MEgzQ2l0eUtYMFBTd3BuVlNS?=
 =?utf-8?B?cW5qWlpRRTRuZThPTE1FMlZza29JNnVOc013blRyNzF5TTVOdGxlb2J4N29J?=
 =?utf-8?B?clI4TG5sb2x6Q2VsdWU2dGhmWnMrSDQzS2lqM1I4ZkhRYTNuMVNMU0NIQTk5?=
 =?utf-8?B?R1kzeTVadXlFdzNodS94UW1nNWxwamdmNTIraE91cTY5SDllUkw5alovZHNq?=
 =?utf-8?B?SzlQYmZYSVRFQkdUbXFXNFB3N2pHOHRIenVXTkNWa0kzTHV5Q1RDWE8vTmE1?=
 =?utf-8?B?QW9iMVJCTXpKaTRGdStFK0VOcm1XUnZWUmxTSmQzNnNhUVR6MVhsT0txSzdM?=
 =?utf-8?B?ODlvei8rL0RzK2c1YlFXbU9aWENsaC9ZTGV6M0JQSzdqWmEwak9ZT0lrYlJV?=
 =?utf-8?B?VnZrT3RPVGpBaDNFSUFtSUNMUnl4VXdwejNOeXRDRzBFSXk1d1lSekZteERF?=
 =?utf-8?B?MU9zK2pySDUvbE1zWE9CNU94b3I2NU5OZU9QcEpnSFRGdk81UkpoYkwvQlNT?=
 =?utf-8?B?bDIvaDU3enJINkx5V00xQndHVjNUblI5cnN1d0dZSk42SzZzUHM1ZGlreWdz?=
 =?utf-8?B?R2hkZ1UxczNhekZnLzBqMTl6NmszZS9uVjVhNkZ2b3oxVEtqTTlPdTN6WHhH?=
 =?utf-8?B?TDk1SXR6ZUI5RGRNRklhY2puelFOZ3NkVHFaSUdZMUFwUlNvc2NkNXVOOUxZ?=
 =?utf-8?B?NnhGa2lnbTVrK3BNUzhQcHpDZ1FybzR4Ym02UDVhTDducTgrVzdjT0J4aTBp?=
 =?utf-8?B?YmpVdnlydllHckZiU0toTXVYb2pZRWZJc0U5RkcwYmp6Mmc2NXZsODB3S0d0?=
 =?utf-8?Q?9bsL6xanBfic7qXK1M3w20d61?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 832da1e5-e713-424c-dd20-08dccbe2a844
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 06:35:52.5412 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LhCuCJ/kVP/nZqSrSpVpkCVDF+VrlWqpwDiCkRpK8zUGs5RJqcE11evbPZtCQ6M5fFrPQYSuETZGz87rgwACUSZTlPaxE8hc6ejPbPZSQNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6600
Received-SPF: pass client-ip=2a01:111:f400:feab::707;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

SGkgQ2VkcmljLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDgvMTFdIGFzcGVlZC9zb2M6
IGludHJvZHVjZSBhIG5ldyBBUEkgdG8gZ2V0IHRoZSBJTlRDDQo+IG9yZ2F0ZSBpbmZvcm1hdGlv
bg0KPiANCj4gSmFtaW4sDQo+IA0KPiBPbiA4LzgvMjQgMDQ6NDksIEphbWluIExpbiB3cm90ZToN
Cj4gPiBDdXJyZW50bHksIHVzZXJzIGNhbiBzZXQgdGhlIGludGMgbWFwcGluZyB0YWJsZSB3aXRo
IGVudW1lcmF0ZWQgZGV2aWNlDQo+ID4gaWQgYW5kIGRldmljZSBpcnEgdG8gZ2V0IHRoZSBJTlRD
IG9yZ2F0ZSBpbnB1dCBwaW5zLiBIb3dldmVyLCBzb21lDQo+ID4gZGV2aWNlcyB1c2UgdGhlIGNv
bnRpbnVvdXMgYml0cyBudW1iZXIgaW4gdGhlIHNhbWUgb3JnYXRlLiBUbyByZWR1Y2UNCj4gPiB0
aGUgZW51bWVyYXRlZCBkZXZpY2UgaWQgZGVmaW5pdGlvbiwgY3JlYXRlIGEgbmV3IEFQSSB0byBn
ZXQgdGhlIElOVEMNCj4gPiBvcmdhdGUgaW5kZXggYW5kIHNvdXJjZSBiaXQgbnVtYmVyIGlmIHVz
ZXJzIG9ubHkgcHJvdmlkZSB0aGUgc3RhcnQgYnVzDQo+ID4gbnVtYmVyIG9mIGRldmljZS4NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29t
Pg0KPiA+IC0tLQ0KPiA+ICAgaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMgfCAyNiArKysrKysrKysr
KysrKysrKysrKysrKysrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKykN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9hcm0vYXNwZWVkX2FzdDI3eDAuYyBiL2h3L2FybS9h
c3BlZWRfYXN0Mjd4MC5jIGluZGV4DQo+ID4gNDI1N2I1ZThhZi4uMGJiZDY2MTEwYiAxMDA2NDQN
Cj4gPiAtLS0gYS9ody9hcm0vYXNwZWVkX2FzdDI3eDAuYw0KPiA+ICsrKyBiL2h3L2FybS9hc3Bl
ZWRfYXN0Mjd4MC5jDQo+ID4gQEAgLTE2NCw2ICsxNjQsMTEgQEAgc3RydWN0IGdpY19pbnRjX2ly
cV9pbmZvIHsNCj4gPiAgICAgICBjb25zdCBpbnQgKnB0cjsNCj4gPiAgIH07DQo+ID4NCj4gPiAr
c3RydWN0IGdpY19pbnRjX29yZ2F0ZV9pbmZvIHsNCj4gPiArICAgIGludCBpbmRleDsNCj4gPiAr
ICAgIGludCBpbnRfbnVtOw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAgIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgZ2ljX2ludGNfaXJxX2luZm8gYXNwZWVkX3NvY19hc3QyNzAwX2dpY19pbnRjbWFwW10gPQ0K
PiB7DQo+ID4gICAgICAgezEyOCwgIGFzcGVlZF9zb2NfYXN0MjcwMF9naWMxMjhfaW50Y21hcH0s
DQo+ID4gICAgICAgezEyOSwgIE5VTEx9LA0KPiA+IEBAIC0xOTMsNiArMTk4LDI3IEBAIHN0YXRp
YyBxZW11X2lycQ0KPiBhc3BlZWRfc29jX2FzdDI3MDBfZ2V0X2lycShBc3BlZWRTb0NTdGF0ZSAq
cywgaW50IGRldikNCj4gPiAgICAgICByZXR1cm4gcWRldl9nZXRfZ3Bpb19pbihERVZJQ0UoJmEt
PmdpYyksIHNjLT5pcnFtYXBbZGV2XSk7DQo+ID4gICB9DQo+ID4NCj4gPiArc3RhdGljIHZvaWQg
YXNwZWVkX3NvY19hc3QyNzAwX2dldF9pbnRjX29yZ2F0ZShBc3BlZWRTb0NTdGF0ZSAqcywgaW50
DQo+IGRldiwNCj4gPiArICAgIHN0cnVjdCBnaWNfaW50Y19vcmdhdGVfaW5mbyAqb3JnYXRlX2lu
Zm8pIHsNCj4gPiArICAgIEFzcGVlZFNvQ0NsYXNzICpzYyA9IEFTUEVFRF9TT0NfR0VUX0NMQVNT
KHMpOw0KPiA+ICsgICAgaW50IGk7DQo+ID4gKw0KPiA+ICsgICAgZm9yIChpID0gMDsgaSA8IEFS
UkFZX1NJWkUoYXNwZWVkX3NvY19hc3QyNzAwX2dpY19pbnRjbWFwKTsgaSsrKSB7DQo+ID4gKyAg
ICAgICAgaWYgKHNjLT5pcnFtYXBbZGV2XSA9PSBhc3BlZWRfc29jX2FzdDI3MDBfZ2ljX2ludGNt
YXBbaV0uaXJxKSB7DQo+ID4gKyAgICAgICAgICAgIGFzc2VydChhc3BlZWRfc29jX2FzdDI3MDBf
Z2ljX2ludGNtYXBbaV0ucHRyKTsNCj4gPiArICAgICAgICAgICAgb3JnYXRlX2luZm8tPmluZGV4
ID0gaTsNCj4gPiArICAgICAgICAgICAgb3JnYXRlX2luZm8tPmludF9udW0gPQ0KPiBhc3BlZWRf
c29jX2FzdDI3MDBfZ2ljX2ludGNtYXBbaV0ucHRyW2Rldl07DQo+ID4gKyAgICAgICAgICAgIHJl
dHVybjsNCj4gPiArICAgICAgICB9DQo+ID4gKyAgICB9DQo+ID4gKw0KPiA+ICsgICAgLyoNCj4g
PiArICAgICAqIEludmFsaWQgb3JnYXRlIGluZGV4LCBkZXZpY2UgaXJxIHNob3VsZCBiZSAxMjgg
dG8gMTM2Lg0KPiA+ICsgICAgICovDQo+ID4gKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOw0K
PiA+ICt9DQo+ID4gKw0KPiA+ICAgc3RhdGljIHVpbnQ2NF90IGFzcGVlZF9yYW1fY2FwYWNpdHlf
cmVhZCh2b2lkICpvcGFxdWUsIGh3YWRkciBhZGRyLA0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkDQo+IGludCBzaXplKQ0K
PiA+ICAgew0KPiANCj4gSGVyZSBpcyBhIHByb3Bvc2FsLCBpbnN0ZWFkIHBsZWFzZSBpbnRyb2R1
Y2UgYSByb3V0aW5lIHJldHVybmluZyBhIHFlbXVfaXJxIGxpa2UNCj4gc2MtPmdldF9pcnEoKSBk
b2VzIDoNCj4gDQo+ICAgIHN0YXRpYyBxZW11X2lycSBhc3BlZWRfc29jX2FzdDI3MDBfZ2V0X2ly
cV9pbmRleChBc3BlZWRTb0NTdGF0ZSAqcywgaW50DQo+IGRldiwNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCBpbmRleCkNCj4gICAgew0K
PiAgICAgICAgQXNwZWVkMjd4MFNvQ1N0YXRlICphID0gQVNQRUVEMjdYMF9TT0Mocyk7DQo+ICAg
ICAgICBBc3BlZWRTb0NDbGFzcyAqc2MgPSBBU1BFRURfU09DX0dFVF9DTEFTUyhzKTsNCj4gICAg
ICAgIGludCBpOw0KPiANCj4gICAgICAgIGZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKGFzcGVl
ZF9zb2NfYXN0MjcwMF9naWNfaW50Y21hcCk7IGkrKykgew0KPiAgICAgICAgICAgIGlmIChzYy0+
aXJxbWFwW2Rldl0gPT0gYXNwZWVkX3NvY19hc3QyNzAwX2dpY19pbnRjbWFwW2ldLmlycSkgew0K
PiAgICAgICAgICAgICAgICBhc3NlcnQoYXNwZWVkX3NvY19hc3QyNzAwX2dpY19pbnRjbWFwW2ld
LnB0cik7DQo+ICAgICAgICAgICAgICAgIHJldHVybiBxZGV2X2dldF9ncGlvX2luKERFVklDRSgm
YS0+aW50Yy5vcmdhdGVzW2ldKSwNCj4gICAgICAgICAgICAgICAgICAgICBhc3BlZWRfc29jX2Fz
dDI3MDBfZ2ljX2ludGNtYXBbaV0ucHRyW2Rldl0gKyBpbmRleCk7DQo+ICAgICAgICAgICAgfQ0K
PiAgICAgICAgfQ0KPiANCj4gICAgICAgIC8qDQo+ICAgICAgICAgKiBJbnZhbGlkIG9yZ2F0ZSBp
bmRleCwgZGV2aWNlIGlycSBzaG91bGQgYmUgMTI4IHRvIDEzNi4NCj4gICAgICAgICAqLw0KPiAg
ICAgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsNCj4gICAgfQ0KPiANCj4gYW5kIGluIHRoZSBu
ZXh0IHBhdGNoLCByZXBsYWNlDQo+IA0KDQpUaGFua3MgZm9yIHN1Z2dlc3Rpb24gYW5kIHJldmll
dy4NCkkgYXBwcmVjaWF0ZSB5b3VyIHZlcnkgdmVyeSBnb29kIGFkdmljZSBhbmQgcHJvcG9zYWwu
DQpXaWxsIHNlbmQgdjMgcGF0Y2gsIHRvZGF5Lg0KDQpKYW1pbg0KPiAgICAgICAgICBpcnEgPQ0K
PiBxZGV2X2dldF9ncGlvX2luKERFVklDRSgmYS0+aW50Yy5vcmdhdGVzW29yZ2F0ZV9pbmZvLmlu
ZGV4XSksDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgb3JnYXRlX2luZm8uaW50
X251bSArIGkpOyB3aXRoDQo+IA0KPiAgICAgICAgICBpcnEgPSBhc3BlZWRfc29jX2FzdDI3MDBf
Z2V0X2lycV9pbmRleChzLCBBU1BFRURfREVWX0kyQywgaSk7DQo+IA0KPiBJIHRoaW5rIHRoaXMg
c2hvdWxkIGJlIGNsZWFuZXIuDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCg0K

