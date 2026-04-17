Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9BDBF8DFEA
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 08:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDem2-0000HG-4n; Fri, 17 Apr 2026 04:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDem0-0000Gt-9f; Fri, 17 Apr 2026 04:42:00 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDelx-0000fs-Ms; Fri, 17 Apr 2026 04:42:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5uZq4g6myUUiZ/kYQDsI7eGHc6SkBlK5nn8tp3xUGK6BywzPL7vnxNy3k2flFKjERpKgw1jCTpSswdzFuqhrj15/75JnXEBSYrCYqm5pvVRKyN4QapvpZilzijYadMCLj66vIhzzHjDXc7FngPXudJlCkT8qKf7KvBLx06viXwFdA9ykFzvXQg3lZBSbzjhdHdu+XGlts5N3+gWuHI7GWo8D4bqHE7KQlA6EkVG/HQeymeq7DCohNIcCGoMHplXqKLeSAezodzP1vg1k6INK3LQtz+rMOh3fpifF5+LdptZzq0DtubyPuq2B+8Zkh5gWTbNu1nXM1UUINcdy3nR/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gco+yE/eMUNEAQA4WOi/H2Hhlm9vg0abhXak9qjjSj4=;
 b=EgMTZM1eqk9VopXT94cwjAJlF99cS9lg+9GTAXfcbvR2x1Wihsyl1mDVEujUuLyutVm0b83KWrTj0fOeQ7E6dtXCZvrRx4RUF1MvhJCPEcd3HO8Z/NIjCwaRwzKre10vFdWeLu41vhfRaR/XYpzRE1YqWFz1sGFSFiZUlkdJDUWdDpwAgL4HA+L75Oaov7hT1rjfZcj7W4T8A/afkpQWtJz59Xp3g32F5GEqvYgOjtTgL+1rUMh9zbr6TZ68ab+kVrk2l4qDl1leA1jK1GCTSA2v/VdccV9aKsZ9DICXSVqEH7v0GxC7WAsp3+hMPS2IKeqEcHd4oZgkI0Q6a+OFHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gco+yE/eMUNEAQA4WOi/H2Hhlm9vg0abhXak9qjjSj4=;
 b=jmh/X5HQyCoCLJXwexCwSrgtodN/8gMenknSKxF+JDZtEwOe0JG9uLT/V5pZ5AlWoWRsDjdccuV0wMf82bS53U3LwIhxsapTAId6RP4FDIDxYaqq91KYAFFUdbYPyVJHlANdvMhehxJYuDAFiDfgLkzLPFn/xCJWJ/SpN7qd1xhouiOBrv1NPjvO0rTzeHtev3oe4a7sGyoft9W0984jQW4IJDTvHFqGxkYUXPZ89qQjn7tl0+ZzIcK2Plkv9I6HTm7B4DN6I1MQ4URibOoe3PLlvuCzDdpwnBalrjZmG4i4P0KQ5xEkeEv8AxO3biHEDS7Gnwc21ZIPPBWPGeSU+w==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TY0PR06MB5150.apcprd06.prod.outlook.com (2603:1096:400:1b1::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 08:41:49 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 08:41:49 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: RE: [PATCH v3 04/17] hw/usb/hcd-ehci.c: Replace fprintf(stderr, ...)
 with qemu_log_mask(LOG_GUEST_ERROR)
Thread-Topic: [PATCH v3 04/17] hw/usb/hcd-ehci.c: Replace fprintf(stderr, ...)
 with qemu_log_mask(LOG_GUEST_ERROR)
Thread-Index: AQHczUNIl3qnO/08SECSdkVJPlcLgLXizScAgAAj9sA=
Date: Fri, 17 Apr 2026 08:41:49 +0000
Message-ID: <TYPPR06MB82068BB67441B62563D00D47FC202@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
 <20260416014928.1279360-5-jamin_lin@aspeedtech.com>
 <3f586dbd-9695-452e-9afb-e4cb49a40b77@linaro.org>
In-Reply-To: <3f586dbd-9695-452e-9afb-e4cb49a40b77@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TY0PR06MB5150:EE_
x-ms-office365-filtering-correlation-id: ba9ff1d8-94a7-4688-fa0d-08de9c5d2ab8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: khOJTTJ7ITleLtvSWNhTgKa42+ZAKxIsnSlGxBrEZwrqz9so7QZ9AQXGg/ZtcCpJ7tHnZNJF8ehw9HNooxLwJMnQ0obOfaKWYB+iNKyYQsyJXFZvTWnMJtcnFPjjnu6M46rtZFbl5oEE4pfa0EtsGT08+UTsukYv1U/FiswigPemvi4QOfHC68/zQ0aLuAXCx/U6+0m550WvWA5HePzhZYHDU4wxTY5hKjUBx/ezB7vg8e7wPek2ExKqopDRqP0OrSOH5w/vy7pWpqTTVH0UktBIExN2+t/Z9q2bmZ21TuGmANNTSoT7ctjdG7piUvOQzGMExWseIdkwPdpV5vagQNHghdT9SHDxeYpDb5ul9OqTSWPPB3mxRwJmazt/H/SL9pSeL3dvxj6m/s6EA2j8q5/BoKP4PmlpSeNlbhvrclZKu98kvToiABN+jYLvd3u5DUR0iX6vdpDMoagaVS1emdHA8Mt/uT5Ty75WTvmO6NR8BeFAMT0PCQ0IAuV638lJpqIAS+RlE+dLs3BmxsMZQlVCeolj01x/Ud+dlF9zpuGvEosULjEKtVbn7DzRGdhc9RgWkOUfG2+9+VKPFMpOn8i5Fb2V+wqnS7pye+0xSFLEK4HzFzwmq/OfBToTfc7FgnDv8SRu0iYyQVGQo3WDgA4UsUQdJn6IMsojFFVzKVDKhkUAgYfAR+QOcnFylgdMnAM94vT0Zn5mSePOnZc9T1OXDq6Sltc4GyubQZIQJ4slyuv43+4Q4EdZscr5sYtlPdvToNs5w07JGDGYeV56lU5u9aF/HFVivSopR1BOKHCqoPQXjnsYWfQIZFCUM/t7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3ZNb3NENnVncXphZW92NmxrcWJKYTdRMmlVaXdxcnJZRjRzUWZKSVoyY0dY?=
 =?utf-8?B?ZU9TM3V0c2NiRlR3YUJMbEErRDA4L0VCMVdvMXFic2puZkdHdUtIWkVwcS9q?=
 =?utf-8?B?dCsxTFgwNW5Fd1FvcDVZcndmUWY3U3JZNlhmczEyL0xrLzJKN2JGZ2plUGJP?=
 =?utf-8?B?dnY3eFgzeHBDd0FnZ1NsOHRmSGx3TXZhdVQ2Y0taZnRtQktLcnhZSmVxeVRT?=
 =?utf-8?B?MlV6N3Y3THRGYWM1cWIvUXhNUHF3dUlQbEFaamthc2oza0gzUktuMjdzVmY3?=
 =?utf-8?B?VDZSTDM4Z0dlODBzVkVYT0ROcWsyQ2tSdm1tYWt0YTcxZ1ROTkRtZFJwMENm?=
 =?utf-8?B?Rk51VEpuTGdCczJLK05vSHdPRS9sTzFNZCs2T1VFeEg5bVlma05aeUY4dC9z?=
 =?utf-8?B?WkN2ZDlleXZ1YnFhL2ozR1p0L1JIRHBXcXlmZ1lZUEdzc3ltQ0x0cE5iSXlV?=
 =?utf-8?B?c0FjS0tFUURpV3JpV3Z1NldIMk0zYWRkY0E1YTExWEhuOWJtZ1JER1pwazBQ?=
 =?utf-8?B?Y3dRcHViZW14Wkc0OCs3TkR2YUlveWtWWFhkcGRSWVZWb3VOSTdZK2o4QklZ?=
 =?utf-8?B?bTZrRWY5c01kS0FRc243dm5XRWNNejYzR1JUOTRmQ2U4cHh1TlkwdTBtbjlp?=
 =?utf-8?B?ck8wYnpnRUFWM2s2ZytpeXVwYjhBVUhuQXRXOFZDTENLdlZNVU9ic20wTTR5?=
 =?utf-8?B?bkdtZ3A4QlpIRVBacXFIYVF1S09teHdLdld4NFFSMklQdWRHbTgvWFZwcGNV?=
 =?utf-8?B?SjFLY0VrWE45SjhZQVNtamhRU29Ebi9qYkMzTklqVGZHblNEbktSQWVsbmYx?=
 =?utf-8?B?S2NNTHgvUFhsTzNTYjlrZGR3VU9yWjhWWHo2eG5Sc2lUMmE0bERQMUhPSHZ5?=
 =?utf-8?B?cHdDY0E0b2xJM2pxRytPcGZQcDdHTHBzUHA0OHFRNHYyQ0RZR00ySUdqbUVJ?=
 =?utf-8?B?emlLeENCWTQyNDhVWVNyZTJYZzRvTTJPM2lGZnJOTXFlV2tDSkpnaGgxdW1G?=
 =?utf-8?B?OGFkSmZtS1lQdit1Kyt6bXl2bnFqOGJEMkJoR0NBeTRwVHZaVnlYQytnTmls?=
 =?utf-8?B?WVM2cjROejk3V0RpK2VZRVkyZUc2ME1JaTlGOWc5U05ZZEF3K0dVKzVUc2Ft?=
 =?utf-8?B?a0pETDd2bDNRdFJFUGtCWjRjK1ZXSStHTUxzZmJPdmFuQWZ0UnlGZHVFM0Fn?=
 =?utf-8?B?WW1lZks4WERGa1VXeGUwTkdKMzZocDNFQlNOai91dGJ6M3dNaGM1KzF2TklE?=
 =?utf-8?B?QlVRUGREekRSRG1OeXdPaTJ6c1lLSnNpazhSMHBEWlhoR1QzM3BTQlpMVFV5?=
 =?utf-8?B?dDNDM0lmY0xhcnRTa0dxRC9UUlJsREZtMmprQ1hkeGh1WnN2eHRSZnNHbWc1?=
 =?utf-8?B?Mm0zUHhocERZMmVtcHk5TTBEb0p1QytHQXkxWDhNbEV1RVROcjZBN1pWODlI?=
 =?utf-8?B?K0tqR29oSGU2ZFZPOU9WdXRyWTZDTTMxLzJUWHlYQ2d0Zml2OGc4eXh5T2VX?=
 =?utf-8?B?Ni9Ob3Q2WXV5SEl0NG0vUnNlVDBrakZWWVhwVnB5V3E5eUJZblBYeXpsVDRL?=
 =?utf-8?B?STBWL01idWdkU2MzNVpDRGJLS2toM2lyN3ZEcGNmR3FGcGt1Ri9udXpLMWdq?=
 =?utf-8?B?aG5SMHBkaDVyZGtsNVB6dktEcVMxbVppNG94QnVqMUVyZzJJWmJMSjN1Z3Aw?=
 =?utf-8?B?OW9JaUl6ODltN3RjaUtnbU1WRWJCU3NGRmlWRW1KM0Vob2EzTEFaSHNkd1Ja?=
 =?utf-8?B?WVQxNXBIN0hTR3ljWWhJVlNlRXljNHovMWNXcUR3WmJsQm9iSU9xbm1TZHZ4?=
 =?utf-8?B?dE5MdGN6b2NQSzdITkI5Q1JlbXl0REdtdlFlRTJ1cTZyT2FuRkdWOTdtRHlB?=
 =?utf-8?B?bldmTS94OVovZ2FsWEErMll1UDRkWnVZN2FidUlZY2xEbklYR3N1RmpHOWph?=
 =?utf-8?B?a2tHZFVwSGlKREpmTUNWUklIWHp1SVo2ZDdaMlVSRWhWRWJONkNUMVlhejl6?=
 =?utf-8?B?V0dXVmFtTjdSTUQ3NGJnSzluS0p3OXlmUGlJUTRaYmllWVpseVRFSzlra1Zh?=
 =?utf-8?B?dGJBVm4zMVRNV0VwbERML2hNbFF6VEpCU0s4TEdVMVcrTWk3SGVPM091MFFt?=
 =?utf-8?B?NHFJU2pZM0pGeUJoVzlJcElTeklMZVNheVI1TFJnQzAxQVcvMTErTjlOWnpu?=
 =?utf-8?B?YWwrc21ScEN6ZG9oODh0b2lUMzVZZ3lwQ2d6YTcyR2tIbDMyR2s5eHJUcVRL?=
 =?utf-8?B?TjQ2VjBNckIyK21CQk9UcUorS1FJUFQrQzRMd1hyb3RZSnhjNWJKTkFqUEF5?=
 =?utf-8?B?R3JmUW9OQVc2dEpKRUJNekp5ZWVVamRYRGVqV3U0b0d6QTFCNXpCZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iyHK7RM+RhTVzMoT6ohk1vZuLw2GFRE94g8hYMhpsWOJzfl4c2rbuPpoqb8R/LMtobdOocKwaJm3GbNvTg/i74uu4UkfAal4LAz/lzEauOTAg131F2LmOvd+u/1H+N15CLdjdKGBSrUbF5qqGGVq6H6Md137afAeg6N6HJ2WMjH1+nYNAf+dnaeI/SBrQS/mz17DRW9e1PV222Lj4x7NqmShhyyUM+VJpvat4n3kpvXQb67BNSygX2xTiHJ9e0lZ9Ku/Jzscsa4agEkRxeHnxtUQ3eTv7wjb3AIx5RtlAVll3kBwiMqXS/fRhKP6KaSqbS4WB2HkDCdevaf0U0eLhw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba9ff1d8-94a7-4688-fa0d-08de9c5d2ab8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 08:41:49.5471 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aeKEQ3G6tg+/LzN1fBpStTCRi9noHYTj4BXjYHU/awsbM+jJ93DN8yEoPcvNTbY0ERGHMO59Uu/bNjJM9ymeOgS5NDXV/bGsQ2UIr8/gDd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5150
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
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

SGkgUGhpbGlwcGUsDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAwNC8xN10gaHcvdXNiL2hj
ZC1laGNpLmM6IFJlcGxhY2UgZnByaW50ZihzdGRlcnIsIC4uLikNCj4gd2l0aCBxZW11X2xvZ19t
YXNrKExPR19HVUVTVF9FUlJPUikNCj4gDQo+IE9uIDE2LzQvMjYgMDM6NDksIEphbWluIExpbiB3
cm90ZToNCj4gPiBSZXBsYWNlIGRpcmVjdCBmcHJpbnRmKHN0ZGVyciwgLi4uKSBjYWxscyB3aXRo
IHFlbXVfbG9nX21hc2soKSB1c2luZw0KPiA+IExPR19HVUVTVF9FUlJPUiBpbiB0aGUgRUhDSSBj
b250cm9sbGVyIGltcGxlbWVudGF0aW9uLg0KPiA+DQo+ID4gRGlyZWN0IHdyaXRlcyB0byBzdGRl
cnIgYXJlIGRpc2NvdXJhZ2VkIGluIFFFTVUgYXMgdGhleSBieXBhc3MgdGhlDQo+ID4gbG9nZ2lu
ZyBmcmFtZXdvcmsgYW5kIGNhbm5vdCBiZSBmaWx0ZXJlZCBvciBjb250cm9sbGVkIGF0IHJ1bnRp
bWUuDQo+ID4gVXNpbmcgcWVtdV9sb2dfbWFzaygpIGVuc3VyZXMgdGhhdCBndWVzdC12aXNpYmxl
IGVycm9ycyBhcmUgcHJvcGVybHkNCj4gPiBjYXRlZ29yaXplZCBhbmQgY2FuIGJlIG1hbmFnZWQg
dmlhIFFFTVUgbG9nZ2luZyBvcHRpb25zLg0KPiA+DQo+ID4gQWxsIGFmZmVjdGVkIG1lc3NhZ2Vz
IGNvcnJlc3BvbmQgdG8gZ3Vlc3QtdHJpZ2dlcmFibGUgZXJyb3INCj4gPiBjb25kaXRpb25zLCBz
byBMT0dfR1VFU1RfRVJST1IgaXMgdXNlZCBjb25zaXN0ZW50bHkuDQo+ID4NCj4gPiBUaGlzIGNo
YW5nZSBpbXByb3ZlcyBpbnRlZ3JhdGlvbiB3aXRoIFFFTVUncyBsb2dnaW5nIGluZnJhc3RydWN0
dXJlDQo+ID4gYW5kIGFsaWducyB3aXRoIHVwc3RyZWFtIGNvZGluZyBndWlkZWxpbmVzLg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+
DQo+ID4gLS0tDQo+ID4gICBody91c2IvaGNkLWVoY2kuYyB8IDQzICsrKysrKysrKysrKysrKysr
KysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNl
cnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkNCj4gDQo+IA0KPiA+IEBAIC01MzIsNyArNTMzLDcg
QEAgc3RhdGljIHZvaWQgZWhjaV9mcmVlX3BhY2tldChFSENJUGFja2V0ICpwKQ0KPiA+ICAgICAg
IH0NCj4gPiAgICAgICBpZiAocC0+YXN5bmMgPT0gRUhDSV9BU1lOQ19GSU5JU0hFRCAmJg0KPiA+
ICAgICAgICAgICAgICAgcC0+cGFja2V0LnN0YXR1cyA9PSBVU0JfUkVUX1NVQ0NFU1MpIHsNCj4g
PiAtICAgICAgICBmcHJpbnRmKHN0ZGVyciwNCj4gPiArICAgICAgICBxZW11X2xvZ19tYXNrKExP
R19HVUVTVF9FUlJPUiwNCj4gPiAgICAgICAgICAgICAgICAgICAiRUhDSTogRHJvcHBpbmcgY29t
cGxldGVkIHBhY2tldCBmcm9tIGhhbHRlZCAlcyBlcA0KPiAlMDJYXG4iLA0KPiA+ICAgICAgICAg
ICAgICAgICAgIChwLT5waWQgPT0gVVNCX1RPS0VOX0lOKSA/ICJpbiIgOiAib3V0IiwNCj4gPiAg
ICAgICAgICAgICAgICAgICBnZXRfZmllbGQocC0+cXVldWUtPnFoLmVwY2hhciwgUUhfRVBDSEFS
X0VQKSk7DQo+IEBADQo+ID4gLTEwNDIsOCArMTA0Myw5IEBAIHN0YXRpYyB2b2lkIGVoY2lfb3By
ZWdfd3JpdGUodm9pZCAqcHRyLCBod2FkZHINCj4gPiBhZGRyLA0KPiA+DQo+ID4gICAgICAgICAg
IC8qIG5vdCBzdXBwb3J0aW5nIGR5bmFtaWMgZnJhbWUgbGlzdCBzaXplIGF0IHRoZSBtb21lbnQg
Ki8NCj4gPiAgICAgICAgICAgaWYgKCh2YWwgJiBVU0JDTURfRkxTKSAmJiAhKHMtPnVzYmNtZCAm
IFVTQkNNRF9GTFMpKSB7DQo+ID4gLSAgICAgICAgICAgIGZwcmludGYoc3RkZXJyLCAiYXR0ZW1w
dCB0byBzZXQgZnJhbWUgbGlzdCBzaXplIC0tIHZhbHVlICVkXG4iLA0KPiA+IC0gICAgICAgICAg
ICAgICAgICAgIChpbnQpdmFsICYgVVNCQ01EX0ZMUyk7DQo+ID4gKyAgICAgICAgICAgIHFlbXVf
bG9nX21hc2soTE9HX0dVRVNUX0VSUk9SLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICJhdHRlbXB0IHRvIHNldCBmcmFtZSBsaXN0IHNpemUgLS0gdmFsdWUNCj4gPiArICVkXG4iLA0K
PiANCj4gUFJJZDY0DQoNCldpbGwgdXBkYXRlDQo+IA0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgIChpbnQpdmFsICYgVVNCQ01EX0ZMUyk7DQo+ID4gICAgICAgICAgICAgICB2YWwgJj0g
flVTQkNNRF9GTFM7DQo+ID4gICAgICAgICAgIH0NCj4gDQo+ID4gQEAgLTE1ODQsNyArMTU4OSw4
IEBAIHN0YXRpYyBpbnQgZWhjaV9zdGF0ZV9mZXRjaGVudHJ5KEVIQ0lTdGF0ZQ0KPiA+ICplaGNp
LCBpbnQgYXN5bmMpDQo+ID4NCj4gPiAgICAgICAvKiBzZWN0aW9uIDQuOCwgb25seSBRSCBpbiBh
c3luYyBzY2hlZHVsZSAqLw0KPiA+ICAgICAgIGlmIChhc3luYyAmJiAoTkxQVFJfVFlQRV9HRVQo
ZW50cnkpICE9IE5MUFRSX1RZUEVfUUgpKSB7DQo+ID4gLSAgICAgICAgZnByaW50ZihzdGRlcnIs
ICJub24gcXVldWUgaGVhZCByZXF1ZXN0IGluIGFzeW5jIHNjaGVkdWxlXG4iKTsNCj4gPiArICAg
ICAgICBxZW11X2xvZ19tYXNrKExPR19HVUVTVF9FUlJPUiwNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICJub24gcXVldWUgaGVhZCByZXF1ZXN0IGluIGFzeW5jIHNjaGVkdWxlXG4iKTsNCj4g
PiAgICAgICAgICAgcmV0dXJuIC0xOw0KPiA+ICAgICAgIH0NCj4gPg0KPiA+IEBAIC0xNjA2LDcg
KzE2MTIsNyBAQCBzdGF0aWMgaW50IGVoY2lfc3RhdGVfZmV0Y2hlbnRyeShFSENJU3RhdGUNCj4g
PiAqZWhjaSwgaW50IGFzeW5jKQ0KPiA+DQo+ID4gICAgICAgZGVmYXVsdDoNCj4gPiAgICAgICAg
ICAgLyogVE9ETzogaGFuZGxlIEZTVE4gdHlwZSAqLw0KPiA+IC0gICAgICAgIGZwcmludGYoc3Rk
ZXJyLCAiRkVUQ0hFTlRSWTogZW50cnkgYXQgJVggaXMgb2YgdHlwZSAldSAiDQo+ID4gKyAgICAg
ICAgcWVtdV9sb2dfbWFzayhMT0dfR1VFU1RfRVJST1IsICJGRVRDSEVOVFJZOiBlbnRyeSBhdCAl
WA0KPiBpcyBvZiB0eXBlICV1ICINCj4gDQo+ICIweCV4Ig0KV2lsbCB1cGRhdGUNCj4gDQo+ID4g
ICAgICAgICAgICAgICAgICAgIndoaWNoIGlzIG5vdCBzdXBwb3J0ZWQgeWV0XG4iLCBlbnRyeSwN
Cj4gTkxQVFJfVFlQRV9HRVQoZW50cnkpKTsNCj4gPiAgICAgICAgICAgcmV0dXJuIC0xOw0KPiA+
ICAgICAgIH0NCj4gPiBAQCAtMjExMiwxMyArMjExOCwxNCBAQCBzdGF0aWMgdm9pZCBlaGNpX2Fk
dmFuY2Vfc3RhdGUoRUhDSVN0YXRlICplaGNpLA0KPiBpbnQgYXN5bmMpDQo+ID4gICAgICAgICAg
ICAgICBicmVhazsNCj4gPg0KPiA+ICAgICAgICAgICBkZWZhdWx0Og0KPiA+IC0gICAgICAgICAg
ICBmcHJpbnRmKHN0ZGVyciwgIkJhZCBzdGF0ZSFcbiIpOw0KPiA+ICsgICAgICAgICAgICBxZW11
X2xvZ19tYXNrKExPR19HVUVTVF9FUlJPUiwgIkJhZCBzdGF0ZSFcbiIpOw0KPiANCj4gSnVzdCBy
ZW1vdmUgZm9yICJiYWQgc3RhdGUiIGVudHJpZXM/DQo+IA0KV2lsbCByZW1vdmUgaXQuDQo+ID4g
ICAgICAgICAgICAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOw0KPiA+ICAgICAgICAgICB9DQo+
ID4NCj4gPiAgICAgICAgICAgaWYgKGFnYWluIDwgMCB8fCBpdGRfY291bnQgPiAxNikgew0KPiA+
ICAgICAgICAgICAgICAgLyogVE9ETzogbm90aWZ5IGd1ZXN0IChyYWlzZSBIU0UgaXJxPykgKi8N
Cj4gPiAtICAgICAgICAgICAgZnByaW50ZihzdGRlcnIsICJwcm9jZXNzaW5nIGVycm9yIC0gcmVz
ZXR0aW5nIGVoY2kgSENcbiIpOw0KPiA+ICsgICAgICAgICAgICBxZW11X2xvZ19tYXNrKExPR19H
VUVTVF9FUlJPUiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAicHJvY2Vzc2luZyBl
cnJvciAtIHJlc2V0dGluZyBlaGNpIEhDXG4iKTsNCj4gPiAgICAgICAgICAgICAgIGVoY2lfcmVz
ZXQoZWhjaSk7DQo+ID4gICAgICAgICAgICAgICBhZ2FpbiA9IDA7DQo+ID4gICAgICAgICAgIH0N
Cj4gPiBAQCAtMjE3NSw3ICsyMTgyLDcgQEAgc3RhdGljIHZvaWQgZWhjaV9hZHZhbmNlX2FzeW5j
X3N0YXRlKEVIQ0lTdGF0ZQ0KPiA+ICplaGNpKQ0KPiA+DQo+ID4gICAgICAgZGVmYXVsdDoNCj4g
PiAgICAgICAgICAgLyogdGhpcyBzaG91bGQgb25seSBiZSBkdWUgdG8gYSBkZXZlbG9wZXIgbWlz
dGFrZSAqLw0KPiA+IC0gICAgICAgIGZwcmludGYoc3RkZXJyLCAiZWhjaTogQmFkIGFzeW5jaHJv
bm91cyBzdGF0ZSAlZC4gIg0KPiA+ICsgICAgICAgIHFlbXVfbG9nX21hc2soTE9HX0dVRVNUX0VS
Uk9SLCAiZWhjaTogQmFkIGFzeW5jaHJvbm91cw0KPiBzdGF0ZSAlZC4gIg0KPiA+ICAgICAgICAg
ICAgICAgICAgICJSZXNldHRpbmcgdG8gYWN0aXZlXG4iLCBlaGNpLT5hc3RhdGUpOw0KPiANCj4g
RGl0dG8uDQo+IA0KV2lsbCByZW1vdmUgaXQuDQoNCj4gPiAgICAgICAgICAgZ19hc3NlcnRfbm90
X3JlYWNoZWQoKTsNCj4gPiAgICAgICB9DQo+ID4gQEAgLTIyMjUsNyArMjIzMiw3IEBAIHN0YXRp
YyB2b2lkDQo+ID4gZWhjaV9hZHZhbmNlX3BlcmlvZGljX3N0YXRlKEVIQ0lTdGF0ZSAqZWhjaSkN
Cj4gPg0KPiA+ICAgICAgIGRlZmF1bHQ6DQo+ID4gICAgICAgICAgIC8qIHRoaXMgc2hvdWxkIG9u
bHkgYmUgZHVlIHRvIGEgZGV2ZWxvcGVyIG1pc3Rha2UgKi8NCj4gPiAtICAgICAgICBmcHJpbnRm
KHN0ZGVyciwgImVoY2k6IEJhZCBwZXJpb2RpYyBzdGF0ZSAlZC4gIg0KPiA+ICsgICAgICAgIHFl
bXVfbG9nX21hc2soTE9HX0dVRVNUX0VSUk9SLCAiZWhjaTogQmFkIHBlcmlvZGljIHN0YXRlDQo+
ICVkLiAiDQo+ID4gICAgICAgICAgICAgICAgICAgIlJlc2V0dGluZyB0byBhY3RpdmVcbiIsIGVo
Y2ktPnBzdGF0ZSk7DQo+ID4gICAgICAgICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7DQo+IA0K
PiBEaXR0by4NCj4gDQpXaWxsIHJlbW92ZSBpdC4NCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3IGFu
ZCBzdWdnZXN0aW9uDQpKYW1pbg0KPiA+ICAgICAgIH0NCg0K

