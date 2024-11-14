Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB904D637D0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 05:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBSTX-0007cR-9n; Thu, 14 Nov 2024 00:33:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tBSTU-0007by-Jj; Thu, 14 Nov 2024 00:33:00 -0500
Received: from mail-eastasiaazlp170100000.outbound.protection.outlook.com
 ([2a01:111:f403:c400::] helo=HK2PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tBSTT-00053W-1W; Thu, 14 Nov 2024 00:33:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVCOK6SIZKN0E8vf+Uvqwo2Z9XpB4okz4KxRfHw6MlI3fzQDnBgvMslNDzXvNiBtRrv2iSoS1FnhGNGNF6weVdjhlKkhczazZlO8/xpJhWN9+XtmysgIYtC9z1F3fr0BRXsh8NcSV8+t2oKYXhzGoGHImW6VmmxysPByyA5isEgSoy5fXVETf7vw9wddjBLQEvpZM8gd4qhDWwb2wP3Aben1MVBejMcsB4GT22xi2Ao3cCRcMCzpFhAMcqDb1Fj3g+Z3/NbR7jXOY+YqXDGBQaCVXLlfp15AdAXRPXW/M7Fm7uvrLsSbxmfm8Ked2MItTM9IxwVRbGd1oe/0Q7/hbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DfomJOL4zovEYryKNrC3n0GYL98xuO+J3+vUuh5QD10=;
 b=vadCfUZSwEPKEJta+nO3VbEJ7hRBiInlRhZkoxxwx6w44oWlwHvJsaT9XjsSH7+ZxJJq/H6eoR9Jla6uAM6oUz331glmUR0Qo5F03EDRt9hpbRIkrejkMMXPtS4I5jKWjvc+QwmbJ/cca9AxUl6E9mPrxSEONOiGudI5IPvUT9V5jpcNDU5JBwIXx35K/OWc9sq4wFK+xlwnxE+87x411on7p8ffNUwMNl67//JqcDs7YAgDhh1lX0ZCtgmU36JDSlSj3IAbnWFeEBe0ZkDKQZefTfEF9+xVdZ9Tah4vyy6qAyKxwnYuQdhZV//fHhhFmY9Cn7aRe036OpRp6r0qqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfomJOL4zovEYryKNrC3n0GYL98xuO+J3+vUuh5QD10=;
 b=gXY+rUp0Buq/414bF1OXeN/q6/KHQTdY1SYHF+6OwRhI3e+JwCPwrZoDSFcopeVboJxIjzeWFzPbuVS7jG/ADDIckIevgOf7/JnN8KFItxbTtXjPrv8kB5NhdydW3CQb2oHPMTlc6X8FzyUWxpEhghBtKurG5YJOSgVsmOWsfZBHwQdbQLFrqR7LS3Fp0S+DwnqzPp9IzVPM+0GDwLKzFxnH9KDoMgz07ZPwIFMx25V8hDya3gjirOYWMnd5oNw2/X9f6YSRhefLnDfEmynpYhYqa6//5GqL3Awk5IGRbQqKOYwARwn65/5Raebh7khKHVbhEHPIzLSWKywQyLsjCA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 JH0PR06MB6704.apcprd06.prod.outlook.com (2603:1096:990:37::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.17; Thu, 14 Nov 2024 05:32:50 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 05:32:50 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Bin Meng
 <bmeng.cn@gmail.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:SD (Secure
 Card)" <qemu-block@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v2 0/3] Introduce a new Write Protected pin inverted
 property
Thread-Topic: [PATCH v2 0/3] Introduce a new Write Protected pin inverted
 property
Thread-Index: AQHbLmiZMT2YxHXqk0eeoArAYt5rn7K2UB+A
Date: Thu, 14 Nov 2024 05:32:50 +0000
Message-ID: <SI2PR06MB504180AF88657AD3846E0A4AFC5B2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20241104032104.2784183-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20241104032104.2784183-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|JH0PR06MB6704:EE_
x-ms-office365-filtering-correlation-id: d3a5e21b-0a4f-48a8-b3d2-08dd046dc785
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?SDYzODFTbm1telJOUkZZcmlBQlV5TDFqemdLbGg3MGxOVU44MkRTUm1yNWUr?=
 =?utf-8?B?NG01N01BSHBzWDBsUldTeHlyTmVpNmFDL2RCRU9hQ2IvTXFVdWNMNFkyazV6?=
 =?utf-8?B?WUdLTUsvSUw0bG04d3o2L3I1ZVN6VWdlQzF6U1hEODFBcG5QbjJaV2JIeVBq?=
 =?utf-8?B?ckNxZFRYNWE1UjVZRU1sSHVnc3RxQ2VKWUVZc2NiQWluNU9JZjVkQllDOWk4?=
 =?utf-8?B?RVBRQXNoZDE5WmlCam85YnNZWklhbU9wckZlVCsrd1U5V0IySEUyYUhRcXJy?=
 =?utf-8?B?L3pjVGl6NUJ6dGRhcUtXRGIxTEl4b1FOZU9xWkZ3QnNQWTMrbFQ2OURBWkNC?=
 =?utf-8?B?M3JvOXMrSGpWTzIvRE9XeWRKSWtZNlhRbFZMVUQ4YjBIWXZudFVtanlVRnVV?=
 =?utf-8?B?bUdtckk4NnRWMzN6L2p2WmcvL3BRaVJXdGJmcXdoVjUyTDNaS3dLRFdOSC9N?=
 =?utf-8?B?MitDVE5TRk5wcElyRWF1ajljaUtzelVFQWwrcE5Ed080cC92NG04bG8xWVg2?=
 =?utf-8?B?blVibUdoVTI4b0kzUGpJZTlSMThVTUdVaVRTSmw4UXNma1JvTmVWMGJSRG5a?=
 =?utf-8?B?T1RDUlVYT21Ud2xUOWdHNXFQMGRuRlFseTU0TXBsc0gwbisxcUV4aGxXbUE2?=
 =?utf-8?B?U1dFQTJMRDlxbFIxVWlyaGl4dUZIWWtHU2RSTE5ISVJUSjQ5NHJkOXlZMjVx?=
 =?utf-8?B?MXFiMUhyNDdGOVpBLy9KelZFYm9rdlg1aHNXNmoydjNQSzhLaGsvVk13K3hP?=
 =?utf-8?B?SE1mTExLUFFaT2I1QkNILzlKZzJvL0FHSHJHc0Q0S3ViZ2xQd09wcEtUa3lE?=
 =?utf-8?B?REN3YzJ0K1VFRlJmTldOaEZITDlRQVJSSW1hOGZEd1RERWo4ZHJFYUc2SkRH?=
 =?utf-8?B?Vm8vMjlnZEM0K2tEejZFTUl0dmx5ajNLbldtYjNrcDUzZFBValRBSDVxODJk?=
 =?utf-8?B?aytEQkdNSS9jaWNWVklBR1MyZmppTldNYnh4b2xjVEhHcXpmajR5eEtYbkYy?=
 =?utf-8?B?Yi9VN08wWEVPQlRaTllVVjNhM1N0bFM3UmFOa1lwTXFMZFFyME1GNlIwcG1E?=
 =?utf-8?B?M0V5Zyt0bUl3VGxiVHVsejJHdmJ6VlJCMWowZStDTUlsNXRwdTFEU0JrSWcy?=
 =?utf-8?B?NGh6TjFkUGN6L2JadExUUTg4ai8yeXFWNUJWYjdPWGZpYVBCU3NRV1FlN3JR?=
 =?utf-8?B?U29uVy96MnFnZHlwNkZuUGlyWXhPdUNRUEV6T1dBVGR6TUtMYnBEMS9idDFM?=
 =?utf-8?B?b09QRGNGMzdIVlRoZWlzNmp5ODNqeThxK0pJS1lNa2RGWDVXRkp6bzUvVGpx?=
 =?utf-8?B?RVluTTBHTDBSMlpGVUxJZTJGZWdaSEhtUm02VXBJVDRrUDZHaVMvendUMUVn?=
 =?utf-8?B?ZzhKbHcvYkY4bHBCSE9kRENJL1VZSmFrTkE4a2p6M0NBV3lHSDRhcW5BQXZC?=
 =?utf-8?B?Q0I0eVJ0bVZaVis4a0FrQXpJYXl0WXFYR3VNUkh5OVlQbXVJczkyOU9idTNQ?=
 =?utf-8?B?eElTNEJvVFRDbXVEVWw4NzMwdDZoRmxBRHRtT0tIY2RHSHo4YlJoUmpTSUhw?=
 =?utf-8?B?NlRJZ01ieVBHN3c0SkV0aTBtRnUvOVFhQmxXelQ5QWNjZnRIc3BVWVViL0RT?=
 =?utf-8?B?dVdEaW8zODV1azh2U2pEYytlMFBWTGp2bCtWNG9QTVNyL1VuTm9tSWM4bDdm?=
 =?utf-8?B?NFJRVGlTUnNUVm5ZOGNwREF3dDdiMjBGR0JxNnpvZlJxL2V1Um1hQjA0Ry9G?=
 =?utf-8?B?L2dvemc4TWsybzZjR05xbEZ2L1FSQUtYSTJmRE03SUQrc20xZGI0WVhscFVZ?=
 =?utf-8?B?UmM0bHZZUWQrVnExUFVyN1lHdks2R0puWmRtUDMvSXl0MERhcUpSMy8vMmFq?=
 =?utf-8?Q?GnL/q4zSeRSKs?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NE9nelY4cVhhZXBWQTZEZi82a3ptRE00aVRDOGhpZERhSTBIdDBERjR3MjZt?=
 =?utf-8?B?OWR6NTFhdElheDVpbWJYQXpIMXJua3VVazNzcDJ4Smo1dFMwMjQ4TU1uMUtj?=
 =?utf-8?B?NnBoTjQ0endxUXd2L2MxYUFzaHV5cHRNWUI3WkhKNTFsdGhsdm55NjJ1dVRI?=
 =?utf-8?B?d3VoeFZGb05oTWhGb2N4eStWMm1RVlBESkNYNHh4WEZqVmcxajdhT2Y5SXhM?=
 =?utf-8?B?U0NPRm54YmY0c3FBVGlKZVRMTTd6MmV3c1UxWlBPdEZnZ1VpYTVUdVB2YmZo?=
 =?utf-8?B?UGhYcGZhZ3N0UFN4RFcrSmpJRUdNdXJSSnM0ZjZBMitpNzFYSm1sYVhrYitR?=
 =?utf-8?B?OWg2bFI3MXYxcVpSWUNmbFdTTXovbHlsbWk5WHNISS9UeE5qbGFrR3lraDZ5?=
 =?utf-8?B?bVZxRVZSYm1oKzBvMXFDSEsxZHFQcTc3ZFV0UlBtOVEwVnFRWnJwdjBuTS9U?=
 =?utf-8?B?M01mZENkVHVvS1YyUWxMWjhrUkFDeGJoUHNRbmNBUXJCbHhQak1jeXU1WVJN?=
 =?utf-8?B?ZElJcU9hbTIzWTdOSmMxbEFkVWRmQ2xPRWZVejAzQ3QzcTVNR0ZzZ25wZ09m?=
 =?utf-8?B?ejFhYlBLd1VqSDZsa0ZDT3gremIwTFNUU21Va1FtcFdiRDNFeUczSW1vb1Fx?=
 =?utf-8?B?WmVOeE4vUnB2a0NDbWx4RDBXVFN6UWVoVUxRdnh5eWx6ZC9PWnJ5Zi9WYmlu?=
 =?utf-8?B?cStJZFc3MEdPV0J0VWhqQzRzbWRmcWhvZWxQQVplcUpDaVpJbzZkU1Mvc3NU?=
 =?utf-8?B?a2djMnlqTm5TQWh1Sjl6cTRYV083K0p2d1ZycVB0NnpQQm14SXBnUVFDK215?=
 =?utf-8?B?dlpDbGxZVENBT3BYcVJhY3VYVWdQWHh0THQwcHg2RlhGNzFKVGczb2l5aUlG?=
 =?utf-8?B?S2VPM1pjSHZBcVNOVFNQSExhSW03VTV6UWFRaVptbkhWc1FXOGNkNTNYWkJ1?=
 =?utf-8?B?b1RnOWE5T200TmVoNmRwYWYvVUxIQ1MzRkZWZ3JoUURiQ1k5Z2w4azFtS3pr?=
 =?utf-8?B?dWI0NnA1T0VBanpPYVNIMitBVnYrTzZxZFRyUVBRTURNdUo1ajhoVDVOSjRq?=
 =?utf-8?B?TGxtbWxaVkxJL0Y1N2RNNUFTcVhacUw1RDRjaFFiZ3hxMHg3MmRRd1UwVDlK?=
 =?utf-8?B?dmVFS3hMV0JoMDhFM3BzU2JkcUtyVEdFT0F5VzM0bG16RWJ1d1h0c3BFRWVC?=
 =?utf-8?B?NTc1UkNCcml0OGxZdVZ2NG5jZnRLbWhFa3RWNXlZcjN0NWVyNWc0ejM0UEpM?=
 =?utf-8?B?VDFJOSt2UEZHRkZPVFF2ZCtlUUI2b3dBWS9COXMzS2k0a2p4V04rN2VKVlp1?=
 =?utf-8?B?c0FhZk9Qa1RmUmRMem9XWitXam41RlpyNitsOFhteExrSkxUazNKWU9Bb0VU?=
 =?utf-8?B?ZUtZYnlXZ3NHNjYvcWdjL3IxaVY3c1M1R29GTmpweFhiTFB4a1ZRVkUzM2Zh?=
 =?utf-8?B?V0JwTWNHKzc5SnphVWVXUi9BOVdnRTcxVFdOblRoT01yTzFFaGxRck5GSFZR?=
 =?utf-8?B?TkhmNERYdGJrVWt4cHEzc0ZuZ2F2YzEzTFhTZlcxREV5WVlaNHkzNWFyWW5D?=
 =?utf-8?B?U29IaDQ4VEowMU9zWU9MMTBRNzZjdFFkZDRWYmRJa0UrS3JJNWRTOGZTelRx?=
 =?utf-8?B?Q0pia3h3L1ZzUWxOWFg2cTdGS3k4aEwzRTZTY3BDK21NQUw0azM3VVB2TFAy?=
 =?utf-8?B?bzdENEw1RnFzd1RrbmVqcVRVTGRLaTNwM05ub0IrWG80WkV3ZllDb2Y4NnR0?=
 =?utf-8?B?cGR5dGtEMU0xc2w4c0hPUnlIRHlBeUsvaG1HKzMvQUJrTU1lSWhzSER6V3N5?=
 =?utf-8?B?eGNEN2k4Sll0VWh5L1lYeURSeDhwZU5tcjh2MHNIQTYxY3BhelA4V3JxNUZO?=
 =?utf-8?B?TUJNQm52bkpCMWNCVUZXRjBqNy91OXNXMEYyS25Takt6NGkrTDJjNEZzS29o?=
 =?utf-8?B?aUZXYk0wSjhyd0xlMi9WV09PeEFoUmFKNWIwNFJlV3NzZFFaVTlEMjV5RmtU?=
 =?utf-8?B?UHhTd3dwMU8zdW1nakhXMHB4NlczQXRkSytQQUlyeFdlTmo4dGFobnlHK09I?=
 =?utf-8?B?a3VjNEpmRndUejBzREc0cktpRVJvNkQ3YVE4Rm5XTFRWb2tjbmRSVEpFaTRr?=
 =?utf-8?Q?ml2W72aYwYtM6mOiioCdh3oma?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a5e21b-0a4f-48a8-b3d2-08dd046dc785
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 05:32:50.1645 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lFWvZaCzgIFF+ts0YiKYk5wi6enJ/A20cBeSRMxc5zosyelMmMPtfeMsgGMA4JnVzoCX9lbT8IUR8x1GWiorSnJF+LvehoLwRKp1FDU4Usw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6704
Received-SPF: pass client-ip=2a01:111:f403:c400::;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=HK2PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

SGkgQ2VkcmljLCBBbmRyZXcNCg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjIgMC8zXSBJbnRyb2R1Y2Ug
YSBuZXcgV3JpdGUgUHJvdGVjdGVkIHBpbiBpbnZlcnRlZCBwcm9wZXJ0eQ0KPiANCj4gY2hhbmdl
IGZyb20gdjE6DQo+IDEuIFN1cHBvcnQgUlRDIGZvciBBU1QyNzAwLg0KPiAyLiBTdXBwb3J0IFNE
SENJIHdyaXRlIHByb3RlY3RlZCBwaW4gaW52ZXJ0ZWQgZm9yIEFTVDI1MDAgYW5kIEFTVDI2MDAu
DQo+IDMuIEludHJvZHVjZSBDYXBhYmlsaXRpZXMgUmVnaXN0ZXIgMiBmb3IgU0Qgc2xvdCAwIGFu
ZCAxLg0KPiA0LiBTdXBwb3J0IGNyZWF0ZSBmbGFzaCBkZXZpY2VzIHZpYSBjb21tYW5kIGxpbmUg
Zm9yIEFTVDEwMzAuDQo+IA0KPiBjaGFuZ2UgZnJvbSB2MjoNCj4gcmVwbGFjZSB3cC1pbnZlcnQg
d2l0aCB3cC1pbnZlcnRlZCBhbmQgZml4IHJldmlldyBpc3N1ZXMuDQo+IA0KPiBKYW1pbiBMaW4g
KDMpOg0KPiAgIGh3L3NkL3NkaGNpOiBGaXggY29kaW5nIHN0eWxlDQo+ICAgaHcvc2Qvc2RoY2k6
IEludHJvZHVjZSBhIG5ldyBXcml0ZSBQcm90ZWN0ZWQgcGluIGludmVydGVkIHByb3BlcnR5DQo+
ICAgaHcvYXJtL2FzcGVlZDogSW52ZXJ0IHNkaGNpIHdyaXRlIHByb3RlY3RlZCBwaW4gZm9yIEFT
VDI2MDAgYW5kDQo+ICAgICBBU1QyNTAwIEVWQnMNCj4gDQo+ICBody9hcm0vYXNwZWVkLmMgICAg
ICAgICB8ICA4ICsrKysrDQo+ICBody9zZC9zZGhjaS5jICAgICAgICAgICB8IDcwICsrKysrKysr
KysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tDQo+ICBpbmNsdWRlL2h3L2FybS9hc3Bl
ZWQuaCB8ICAxICsNCj4gIGluY2x1ZGUvaHcvc2Qvc2RoY2kuaCAgIHwgIDUgKysrDQo+ICA0IGZp
bGVzIGNoYW5nZWQsIDYyIGluc2VydGlvbnMoKyksIDIyIGRlbGV0aW9ucygtKQ0KPiANCg0KQ291
bGQgeW91IHBsZWFzZSBoZWxwIHRvIHJldmlldyB0aGlzIHBhdGNoIHNlcmllcz8NClRoYW5rcy1K
YW1pbg0KDQo+IC0tDQo+IDIuMzQuMQ0KDQo=

