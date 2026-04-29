Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC18FF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 10:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI2JV-0002Qw-Fe; Wed, 29 Apr 2026 06:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1wI2JO-0002QX-KU; Wed, 29 Apr 2026 06:38:34 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1wI2JM-0001B0-0B; Wed, 29 Apr 2026 06:38:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oI0KB/yDZKmY1/NsAKtJ7Zdum4+aDaoE950/ZcH/wj/cZxHi4h1jfvU9ldFz0xHfjre7lMtrkv/HjJIJXnnkoQICZkre2CNh1IrSEHx4ueac/6yUUlF91OGudE5i10ts8oEjH5ClUl6ORA0Fp2G1vikYbTKvGJbZ1BnTiQOOGKTwCpXOzPapdl3G/sZRajUo6FVXz1KTLDIGCpw2YxGCmvCea0uKGZCOF50fVtDyoWHPNjrKS7GcnbJXMOzOou4hqHYg3uAWQ1M2J9zmwHqpmJxjsL0049PGtmywYAzEi8iuSjRatxJ73XFkMcKFC0+rg9bFus/IKjNRqkzWpRIXSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZdyhZRGjo3pfrhzka/fGQ22a0kCRKnxWN822b3PO6Y=;
 b=VI7YnfjXRhxv+dDQdnIXjvVGh4cJBYB1BWGg0dBHFv29EIzOhRemmRNwS4hH8ne/OCA55gTtwS2S3vfbnEMhp8itfL6e4FrG8ycolgFVH0QTfyy8eqGAW5cOZiEKXAS+e5e+AyMirsWf84BCNw+BRMWbusL9IdZgJHfWm2jGGD5kTjis7rfUdZvC2o+vwIwRp/4E1nrbwhCnVigUfeZ48JH4R2ljFvlNebdyi/HwkE1ojVanRnwY4VmBWdemmxHPuRs3x1gWsGLwS4UWckMmXIKtcv4qD7zpADvNYboqQkof6wIK20JXozFJfGxOopjjYovggPXWIeLH90IvyZTkMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZdyhZRGjo3pfrhzka/fGQ22a0kCRKnxWN822b3PO6Y=;
 b=qng+vFMiwtfVRiiiDOemonEWjqy9YGs8DN+o+Pnqc3/zCZRmRWUWIoOUf5cwydmRF4iB/R8pmeBeK4IsHRtKoLUqvNEzubcnYm90TSnoTo70SWly3zg3vlOUPRnjqlXXtP0BS4n5jixppbui5EsRfjzJoBYFFhs0br5+hTu86I4ZIk1e6LJckiTF/rJeCcRc1i9rsmLu6Z/5q0MglaqBjgQHkjS/nWLXDV3HSFnDwVlkJ8zAlxAOvq0cYTIqFJTTSMXM3+pfdKm4UhsOabBSxjyJda6wbZ9QqGAfhT9lRupgtA+CPgr1w5ZmPGfcqKUoBygfKbax20l7rsETLyv8EQ==
Received: from TYZPR06MB5148.apcprd06.prod.outlook.com (2603:1096:400:1c0::9)
 by PS1PPF8B633BB92.apcprd06.prod.outlook.com (2603:1096:308::25b)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Wed, 29 Apr
 2026 10:38:18 +0000
Received: from TYZPR06MB5148.apcprd06.prod.outlook.com
 ([fe80::ac4b:d682:14ba:f295]) by TYZPR06MB5148.apcprd06.prod.outlook.com
 ([fe80::ac4b:d682:14ba:f295%4]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 10:38:18 +0000
From: Steven Lee <steven_lee@aspeedtech.com>
To: Alistair Francis <alistair23@gmail.com>
CC: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew
 Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 Troy Lee <troy_lee@aspeedtech.com>, "longzl2@lenovo.com"
 <longzl2@lenovo.com>, Yunlin Tang <yunlin.tang@aspeedtech.com>
Subject: RE: [RFC PATCH v1 1/1] hw/arm: aspeed: Add PoC integration for
 Caliptra Root of Trust
Thread-Topic: [RFC PATCH v1 1/1] hw/arm: aspeed: Add PoC integration for
 Caliptra Root of Trust
Thread-Index: AQHc1iGSt5W6aR0zQkuwAr6xMSbzn7X1b9qAgABpFYA=
Date: Wed, 29 Apr 2026 10:38:18 +0000
Message-ID: <TYZPR06MB51486DE3D724FC0467DA453D85342@TYZPR06MB5148.apcprd06.prod.outlook.com>
References: <20260427084055.2246089-1-steven_lee@aspeedtech.com>
 <20260427084055.2246089-2-steven_lee@aspeedtech.com>
 <CAKmqyKMs+HFxkQ=sjWL+T_f29X_1zMLuEsyqbnd0Pp=31ZfR3w@mail.gmail.com>
In-Reply-To: <CAKmqyKMs+HFxkQ=sjWL+T_f29X_1zMLuEsyqbnd0Pp=31ZfR3w@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB5148:EE_|PS1PPF8B633BB92:EE_
x-ms-office365-filtering-correlation-id: 7981d869-706d-447c-4e2c-08dea5db6d76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: ds2+plHJ1Yer9IcmyiTDQVX/72ehot2fA5WEAwxIHvDqVmjeqea/KhWwgCficIP8rV7hI2pz8p3J7KIUFYvHCLxLlJ6itecXfyyaE6mZiscS+LQyMo9hviTg9NdMbSATyk5Ylqi0+GaDhHyFGzUCIMTzLdL/sUPsbsrS5N43Rn6vPRO6lLLXGP9x71yNVYljZLJcgkYKQWQ8cK5BJakmkdoBge9ATh8ullFuRW9dTGP5ge4Pz6mQ0JjCeLXij2c+DLzzBHwqsf4HBchqa8D1iPBD7PMzr/s9Gm9grTbAUCuLeXNk+n++/JTkjk9VOG9ioKpJSi8NKi3PDBKWG8Knmgp7OKqf3zLiyTW0m1DjRojorjooLbV4rIWw91i6+vY+fXgsI2jW3vghvl4vs85aSDLnCh4t/c3Epg09RPwW0bih4jztlkkRGqbiFehctdmHU9CTmO/yneZR+fHxuTXqNHZ2eCDbw8fdofPRGJw+fsuFLttNNNheK/XXJnPooYFl4giMxdYj/BvEZHpsHic63/VS5P3wHlkC4IOlkdltH21eBSvnZm8/wy5EQlAPXylRf2LbsYRjLSgZIQbIc6Mfx/oUYqeyRuzg9YYnSrFndZGDjmBddrUQmM0rYDFBaUH5TJaS6CW5XCcv0RQ9MRlhveiPzt4UASeo/aV6NFnmBigYGoC+hV24/y5cYxz5lw77BqLtpKAigd4DSVP/20QcBKI50AIRofRUQxVR/SIhBkb/AkA4317eT+iPFSD+0DxMaDkRTJbN0PM0v9qddKEG8E/kxTCeW4tetdoqzPypHi0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB5148.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHhvNXdYanZkc2tpUzRVSWY5anRjbFlPN1U0YzlJbWlPY1ZuMHZrQ29rTFVl?=
 =?utf-8?B?UlB6Y2lzWmtuQnFBV3hXK0psRGZWMUJmMWFKMHlXeHJObnlZRTJReW9MbWNp?=
 =?utf-8?B?SFRtbnVzT2d1UmVPcGVuWkcwNlkwSTFwTUhqUXg3N1dzcWhlNXNwSnFnWGgr?=
 =?utf-8?B?MzIvV3V1VUpqTHhEZjZOZUJkVzVheklaNnNFSkl3aVZGTURoY1p0QmZZdWRD?=
 =?utf-8?B?VXQ3S0xEZEwvR3pqM3VXV0lTU040emJ0dEI2ck9LWHF1TWVHTTVQTm9ROVQv?=
 =?utf-8?B?QlNZV0hCdjhUcm56QWE1L0p3MDJoUTQ0WDdXTUpjRkZaTFZtalRXVW1mb0lv?=
 =?utf-8?B?aGtHdjI5N2dxSFVzcFlVcm5VdGoreXl0RnFEWUFZMnF2WFVtNlI5NmVYaTln?=
 =?utf-8?B?ODJkczVTU0VpVFExSlZvWjRvNEJtTHpyQlkzRnFWemRyU1M2cWpWeFFUekY5?=
 =?utf-8?B?VGRIY0ZyR202K0MxbHNSV2hqOFAxL3ZLc2V5dElRM2k5OFRwcGppNUE3WkRO?=
 =?utf-8?B?M2lYRWdxQldTdnRXdTdyRzgzbUlOVjdzZ0gyckJOQmNLOGhLSHB3UWZ6WHRn?=
 =?utf-8?B?SU9WYy9nUHMxR28xaUhaUnVLRVc5Y3FzOFRzNGJOQ3lRM0dqbTk3MExTSmNh?=
 =?utf-8?B?dUpvcktCMzA4dFZTUDRXMW1FK3FkVk5UbDFPNGNPdWtEcjR2VWdjQXlvV1I4?=
 =?utf-8?B?cDgxOVFTR1lYdSt5VEo5cU41VHJsT0hrdGxQakpwS0xzanlneWNHeHVGcjJH?=
 =?utf-8?B?eVpTT05iNnJoOGNWeVptaEJKclJMM0VoR1VobVQ2WmdFRXdFOG1hNGpZT3Zj?=
 =?utf-8?B?SVFpbEtqaTJZbGZCMFB5cmhQOVNmcnZYbGhvbGsvNHZGaGlnL0NHSWhXV05i?=
 =?utf-8?B?Z0FJTlgwd2c0NG95SnhXeWkwcGp3S2xJejNRMHBSM3NRSEUyTTUzeUN1NjJN?=
 =?utf-8?B?L3RKR1VXcjJCTUdiQk9EbVBIRDdwUjlMeURtNUFSOGZqdVNzRGpnYm1lbjZN?=
 =?utf-8?B?WS9HS2hNWXFyMnJVY28wSjUwRzRtekEwQmRFSURtZmpYUmNLUGRoVUJvejAx?=
 =?utf-8?B?YmFITzIrRHJELzIyQzE3Q2k2elZKZFBvbmdrTFRjckgvdktDeUoydVpaM081?=
 =?utf-8?B?ODY1c241bWdCZWxvZ2g5YUpGQ2x3VXg5MXY4VzZiRVN6SWJoT0d3U1diR2lT?=
 =?utf-8?B?VExZbnBLWE85VVZZbGRiek1MVGViYmpJY1ZYMlRpTFU1UzBsZ3A4c2RpVmxQ?=
 =?utf-8?B?ZTZxRHpjYU5DMHJOQ3NIWE11SDZQYWlWUUx5cXNMdHZxVjMvamhJUEVZak12?=
 =?utf-8?B?cER0Sk9VWlRDcE1JMUZyb3NDNFZXNTJuK0ZpQXhXSm95Ry9iY3NsVFhmZVlm?=
 =?utf-8?B?K1dYenplZ21jWi9OUEpKVm5GSnBzKzBGYnBwL1N5YmwxVlZMZlh0NnlJRkk2?=
 =?utf-8?B?RDdvRE4rekg4ZGRzMmxKSDZUUjQ2QnZtSjlZeXBaNERNeU9BUGwrWW9uTDFF?=
 =?utf-8?B?YTVwNWRDOERTYThTMi9YMUdqSk5yRnlKSEZnZlRWTXh5V0RiVXVtL0tZYllG?=
 =?utf-8?B?Ri81N2tsSksvUnNneG1UYmVUaEtoQUlPTmFraEZZWkNVQXJlL2ZYUlN5bExn?=
 =?utf-8?B?RFRsVG04Lzl0cVlFZWwxY1dpL1RrNS9oTFo0Y3NWMmlueTAwaHlOUkRJMWNr?=
 =?utf-8?B?VWQ0eFBIYXRMTTBQeW5kTjVnSUdUbTBQWENYZVBqSHErNWY0MUVZaUI3VWVl?=
 =?utf-8?B?UzV5aTRQc2RIUnNselN1VEpxbjlOMGFnYk5lQUc1aHBJQVhiVkZ2SEJKWWMx?=
 =?utf-8?B?dkFqSmYrVnU3RDFyN29qZmI3S0Z5czlkeXhsRTZ2YjhrQ24ySFpld3UyYUhl?=
 =?utf-8?B?OWUrczFxaHpHUXNSaXhHVWk3SmFWbTNGWHltS1dlbHZ1dWxEbGRaSWp4SmZX?=
 =?utf-8?B?cWxCRG4wcTFOclRZTmVCZ1NxVURzR0MyUno1b2JFdndUbUpraXIrUkwwSVlv?=
 =?utf-8?B?S0JUZTBaVzc3N0JTN2IyVHBwUVFaaHlPOHhVaTlsLzJIcExmbWhBZ1pmYTla?=
 =?utf-8?B?dkhXbllJR0J1WWV2RWI3Z2o0Z2NHNE51UFluV3JaNnNEaCsvVnVoNjBsVHFW?=
 =?utf-8?B?cTRJMlZyK09UUE9YWitDczFUQ3pwOUZ6SWtrZUo1R1JoSnRJWjQwTXI1bmJK?=
 =?utf-8?B?VlUzQ05tdlNRN1IrNzRxVVUzeVF3dGFuZ1c4bmovTWw1czNVS0g3VHY3a0Iz?=
 =?utf-8?B?cGg5bXZ5TVRxbWNyWlN6VHJBT2pSNHpKU3hCS3NlemVUSElnY2hNY3Z3VC8w?=
 =?utf-8?B?R05PY1VBZ1Rlb0U2amxRK0FzeFhVWjlGQmxYck5YZ2VZSS9EelQ3UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: samkE4vG3GDsWNy5b+rZm3Ye9bGd8kkTj/rvS4aSnPee+qgDwz3La9dc09rWwoH+hgkUicYINFZwJNNfQ+VkrnIEiTSafLcYYbHZ/FfpJcvnKUTfxzKaSUrFjGqxGzkWAe4h1/chprcLmSyd8Fhbz+lh5nKj1lZdO4/7My3w881z6BUX/GSuQVW8WjLPAHXkU8GfaOczlqTs4/SDrJFKVSU7JX50UajTYrWdL9g9iJb/SFUVrnObpnK9PH1cNCXs+7hxit9H14imbOuetrzjZabWrH+yNXwXrNp9NJZ4A3jWeFUSqM3Ux4p73skhEDHOH5tWd8y0tayGIg804XrwGw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5148.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7981d869-706d-447c-4e2c-08dea5db6d76
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2026 10:38:18.6007 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: is3gZxm5QQO5dn9hEqApGo2+R+V+68F9+IYzRekOcfpi0OBwdQoxfImb/mOwNtFZPfwI6UaaSRLIXnBhTNZDIlWOVdEZTmOA2ZV64h8nyMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPF8B633BB92
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=steven_lee@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

SGkgQWxpc3RhaXIsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxp
c3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIyM0BnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwg
QXByaWwgMjksIDIwMjYgMTI6MTAgUE0NCj4gVG86IFN0ZXZlbiBMZWUgPHN0ZXZlbl9sZWVAYXNw
ZWVkdGVjaC5jb20+DQo+IENjOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPjsgUGV0
ZXIgTWF5ZGVsbA0KPiA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgVHJveSBMZWUgPGxlZXRy
b3lAZ21haWwuY29tPjsgSmFtaW4gTGluDQo+IDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBL
YW5lIENoZW4gPGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNvbT47DQo+IEFuZHJldyBKZWZmZXJ5IDxh
bmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+OyBKb2VsIFN0YW5sZXkNCj4gPGpvZWxAam1zLmlk
LmF1PjsgUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPjsgb3Bl
bg0KPiBsaXN0OkFsbCBwYXRjaGVzIENDIGhlcmUgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz47IG9w
ZW4gbGlzdDpBU1BFRUQgQk1Dcw0KPiA8cWVtdS1hcm1Abm9uZ251Lm9yZz47IFRyb3kgTGVlIDx0
cm95X2xlZUBhc3BlZWR0ZWNoLmNvbT47DQo+IGxvbmd6bDJAbGVub3ZvLmNvbTsgWXVubGluIFRh
bmcgPHl1bmxpbi50YW5nQGFzcGVlZHRlY2guY29tPg0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRD
SCB2MSAxLzFdIGh3L2FybTogYXNwZWVkOiBBZGQgUG9DIGludGVncmF0aW9uIGZvcg0KPiBDYWxp
cHRyYSBSb290IG9mIFRydXN0DQo+IA0KPiBPbiBNb24sIEFwciAyNywgMjAyNiBhdCA2OjQ44oCv
UE0gU3RldmVuIExlZSB2aWEgcWVtdSBkZXZlbG9wbWVudA0KPiA8cWVtdS1kZXZlbEBub25nbnUu
b3JnPiB3cm90ZToNCj4gPg0KPiA+IFRoZSBBU1BFRUQgQVNUMjcwMGZjIFNvQyBpbnRlZ3JhdGVz
IHRoZSBDYWxpcHRyYSBSb290IG9mIFRydXN0DQo+ID4gKENhbGlwdHJhIDEuMiBjb3JlKS4gTW92
aW5nIGZvcndhcmQsIHdlIGV4cGVjdCBtb3JlIFNvQ3MgdG8gYWRvcHQNCj4gPiBDYWxpcHRyYSBj
b3JlcyAoZS5nLiwgQ2FsaXB0cmEgMi54KS4gQ3VycmVudGx5LCBRRU1VIGRvZXMgbm90IGhhdmUg
YQ0KPiA+IG5hdGl2ZSBDYWxpcHRyYSBlbXVsYXRvci4NCj4gPg0KPiA+IFRoZSBvZmZpY2lhbCBg
Y2FsaXB0cmEtc3dgIHByb2plY3QgcHJvdmlkZXMgYSBmdWxseSBmdW5jdGlvbmFsDQo+ID4gZW11
bGF0b3Igd2l0aCBDLWJpbmRpbmdzLiBBcyBhIFByb29mIG9mIENvbmNlcHQsIHRoaXMgUkZDIGlu
dGVncmF0ZXMNCj4gPiB0aGUgZXh0ZXJuYWwgYGNhbGlwdHJhLXN3YCBDLWJpbmRpbmcgbW9kZWwg
aW50byBRRU1VIHRvIGVuYWJsZSBib290aW5nDQo+ID4gdGhlIEFTVDI3MDBmYyBtYWNoaW5lLg0K
PiA+DQo+ID4gVGhpcyBSRkMgZG9lcyBub3QgcHJvcG9zZSBtZXJnaW5nIHRoZSBjdXJyZW50IFBv
QyBkZXNpZ24gYXMtaXMuDQo+ID4gSW5zdGVhZCwgaXQgaXMgaW50ZW5kZWQgdG8gZXhwbG9yZSBw
b3NzaWJsZSBhcHByb2FjaGVzIGZvciBhZGRpbmcNCj4gPiBDYWxpcHRyYSBzdXBwb3J0IGluIFFF
TVUgYW5kIHRvIGdhdGhlciBlYXJseSBmZWVkYmFjayBmcm9tIHRoZQ0KPiA+IGNvbW11bml0eSBv
biBhcmNoaXRlY3R1cmUgYW5kIGludGVncmF0aW9uIHN0cmF0ZWd5Lg0KPiANCj4gV2hhdCBhYm91
dCBhIHNvY2tldCBhcHByb2FjaCBpbnN0ZWFkPyBUaGF0J3Mgd2hhdCBRRU1VIGN1cnJlbnRseSB1
c2VzIGZvcg0KPiBUUE0gYW5kIFNQRE0gc3VwcG9ydC4gSXQgbWVhbnMgdGhlcmUgYXJlIG5vIGJ1
aWxkIHRpbWUgZGVwZW5kZW5jaWVzLA0KPiB5b3UgY2FuIGp1c3QgbGF1bmNoIHRoZSBDYWxpcHRy
YSAic2VydmVyIiBhbmQgaGF2ZSBRRU1VIGNvbm5lY3QgdG8gaXQuDQo+IA0KPiBUaGVuIHRoZSAi
c2VydmVyIiB3aWxsIGJlIGEgc2ltcGxlIHRyYW5zbGF0aW9uIGxheWVyIGJldHdlZW4gcmVxdWVz
dHMgb24gdGhlDQo+IHNvY2tldCBhbmQgdGhlIEMtYmluZGluZ3MgeW91IHRhbGsgYWJvdXQgYWJv
dmUuDQo+IA0KDQpUaGFuayB5b3UgZm9yIHRoZSBzdWdnZXN0aW9uOyB0aGlzIGlzIGEgdmVyeSBj
bGVhbiBhcHByb2FjaC4NCg0KSW4gbXkgaW5pdGlhbCBQb0MsIEkgZm9jdXNlZCBvbiB0aGUgQy1i
aW5kaW5nIGludGVyZmFjZSBwcm92aWRlZCBieSB0aGUgQ2FsaXB0cmENCnByb2plY3QgYW5kIGJ1
aWx0IHRoZSBpbnRlZ3JhdGlvbiBhcm91bmQgaXQsIHNvIEkgZGlkbuKAmXQgcmVhbGx5IGNvbnNp
ZGVyIG1vdmluZw0KdGhlIG1vZGVsIG91dC1vZi1wcm9jZXNzLg0KDQpCYXNlZCBvbiB5b3VyIGZl
ZWRiYWNrLCBJ4oCZbGwgdHJ5IGEgZGlmZmVyZW50IGRpcmVjdGlvbjogaW1wbGVtZW50aW5nIGEg
Q2FsaXB0cmENCnNlcnZlciBwcm90b3R5cGUgdGhhdCB1c2VzIHRoZSBDYWxpcHRyYSBody1tb2Rl
bCBjcmF0ZSBkaXJlY3RseSB0byBpbnN0YW50aWF0ZQ0KdGhlIGVtdWxhdG9yLCBhbmQgY29tbXVu
aWNhdGVzIHdpdGggUUVNVSBvdmVyIGEgc29ja2V0IGludGVyZmFjZS4NCg0KVGhpcyBzaG91bGQg
YXZvaWQgdGhlIEMtYmluZGluZyBkZXBlbmRlbmN5IGFuZCBiZXR0ZXIgYWxpZ24gd2l0aCBleGlz
dGluZw0KUUVNVSBwYXR0ZXJucy4NCg0KVGhhbmtzIGFnYWluIGZvciB5b3VyIGd1aWRhbmNlLg0K
DQpCZXN0IHJlZ2FyZHMsDQpTdGV2ZW4NCg0KDQo+ID4NCj4gPiBJbiB0aGlzIFBvQywgdGhlIGBj
YWxpcHRyYS1zd2AgZW11bGF0b3IgaXMgdXNlZCBhcyBhIHJlZmVyZW5jZSBtb2RlbA0KPiA+IHRv
IGVuYWJsZSBlYXJseSBicmluZy11cCBhbmQgdmFsaWRhdGlvbiBvZiB0aGUgQVNUMjcwMGZjIHNl
Y3VyZSBib290DQo+ID4gZmxvdywgcmF0aGVyIHRoYW4gYXMgYSBmaW5hbCBpbXBsZW1lbnRhdGlv
biBjaG9pY2UuIFRoZSBpbnRlZ3JhdGlvbiBpcw0KPiA+IGJhc2VkIG9uIHRoZSBgY2FsaXB0cmEt
MS4yYCBicmFuY2ggb2YgdGhlIG9mZmljaWFsIHJlcG9zaXRvcnk6DQo+ID4gaHR0cHM6Ly9naXRo
dWIuY29tL2NoaXBzYWxsaWFuY2UvY2FsaXB0cmEtc3cvdHJlZS9jYWxpcHRyYS0xLjINCj4gPg0K
PiA+IFRvIGF2b2lkIG1ha2luZyBub3JtYWwgQVNQRUVEL0FBcmNoNjQgYnVpbGRzIGRlcGVuZCBv
biBhIGxvY2FsDQo+ID4gZXh0ZXJuYWwgY2hlY2tvdXQsIHRoZSBjLWJpbmRpbmcgYmFja2VuZCBp
cyBjb21waWxlZCBvbmx5IHdoZW4gdGhlIFBvQw0KPiA+IGRldGVjdHMgdGhlIGdlbmVyYXRlZCBg
Y2FsaXB0cmEtc3dgIGMtYmluZGluZyBoZWFkZXIgYW5kIHN0YXRpYw0KPiA+IGxpYnJhcnkgaW4g
dGhlIGV4cGVjdGVkIHNpYmxpbmcgc291cmNlIHRyZWUuICBBIG1lcmdlYWJsZSB2ZXJzaW9uDQo+
ID4gd291bGQgbmVlZCBhbiBleHBsaWNpdCBjb25maWd1cmUgb3B0aW9uIGFuZCBhIHByb3BlciBk
ZXBlbmRlbmN5DQo+IGludGVncmF0aW9uLg0KPiANCj4gVGhpcyBzb3VuZHMgdHJpY2t5IHRvIGdl
dCBkaXN0cm9zIHRvIHBpY2sgdXAgdGhpcyBkZXBlbmRlbmN5Lg0KPiANCj4gPg0KPiA+IEZvciBj
b250ZXh0LCB0aGUgYWN0dWFsIGhhcmR3YXJlIGJvb3QgZmxvdyBvbiB0aGUgQVNUMjcwMGZjIHJl
bGllcyBvbg0KPiA+IGEgZGVkaWNhdGVkIFJJU0MtViBjb3JlIChib290bWN1KSB0byBvcmNoZXN0
cmF0ZSB0aGUgc2VjdXJlIGJvb3Q6DQo+ID4NCj4gPiAgIDEuIGJvb3RtY3UgZXhlY3V0ZXMgaXRz
IFJPTSBjb2RlLg0KPiA+ICAgMi4gYm9vdG1jdSByZWxlYXNlcyB0aGUgQ2FsaXB0cmEgY29yZSBm
cm9tIHJlc2V0Lg0KPiA+ICAgMy4gQ2FsaXB0cmEgcmVxdWVzdHMgaXRzIEZNQyBhbmQgUnVudGlt
ZSAoUlQpIGZpcm13YXJlLg0KPiA+ICAgNC4gYm9vdG1jdSBsb2FkcyB0aGUgQ2FsaXB0cmEgRk1D
L1JUIGltYWdlcyBpbnRvIENhbGlwdHJhJ3MgbWFpbGJveC4NCj4gPiAgIDUuIENhbGlwdHJhIFJP
TSB2ZXJpZmllcyB0aGUgc2lnbmF0dXJlIG9mIHRoZSBDYWxpcHRyYSBGTUMvUlQgaW1hZ2VzLg0K
PiA+ICAgNi4gQ2FsaXB0cmEgYm9vdHMgaW50byBpdHMgRk1DIGFuZCBSVCBlbnZpcm9ubWVudHMu
DQo+ID4gICA3LiBib290bWN1IHJlcXVlc3RzIENhbGlwdHJhIFJUIHRvIHZlcmlmeSB0aGUgYm9v
dG1jdSdzIG93biBGTUMuDQo+ID4gICA4LiBib290bWN1IGV4ZWN1dGVzIGl0cyBGTUMuDQo+ID4g
ICA5LiBib290bWN1IHJlcXVlc3RzIENhbGlwdHJhIHRvIHZlcmlmeSB0aGUgQk1DIChDb3J0ZXgt
QTM1KSBmaXJtd2FyZS4NCj4gDQo+IEluIHRoZSBzZXJ2ZXIgbW9kZWwgdGhpcyB3b3VsZCBhbGwg
aGFwcGVuIG91dHNpZGUgUUVNVSwgUUVNVSB3b3VsZCBqdXN0DQo+IHdhaXQgZm9yIHJlc2V0IHRv
IGJlIHJlbGVhc2VkDQo+IA0KPiBBbGlzdGFpcg0KPiANCg==

