Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10EBC108B8F7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 11:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Y0s-0002wi-52; Fri, 20 Mar 2026 07:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w3Y0o-0002wQ-K4; Fri, 20 Mar 2026 07:27:30 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w3Y0m-0002yL-7o; Fri, 20 Mar 2026 07:27:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xm4VBIWdV0MPWeQTbcR2FfKjxZKpBPZvLJ7QHGAl9XcS5VtZjHIyk41UHsYHwex3/PYglfQbPXLJcL9RcBgON/NK8ecLkdqPgQrQV/8HV3dEbBT8vEoU4h8uYNUOfCOJ8wFZ5B1jzSise1Z69q8LRUdZkQs//oRJwugVkhDyhiivpDDV639r1Ia77d4Y+Me8aLqqtcZ0QE4TSW5ULnUA6vMaRfzf/EWAXJI6zr1z7aFCULCUCXzURkkQpd1LG2wQqvwMZwAr+Quk1g0R17Y7F5uH9geY90H2mQN/zAvkRONa9ElPHMBmMg8myQRKDdY6FBt18SLZ45V5wfjEjvTYlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=imrBtFBtaqyPqWm8PZlsqkuywq29sHGm8/L9gANiuLM=;
 b=HnszY3HASSqNBRTzO4uL+GTUV+3W4LTT3MtaCKxVVVomRMbYDGTXyR/d1pG9Kny1G+o9xpI1NXY66niLcyczvK1cEiU7UYFo7wr69vRpK/GWU12moYk3gjqXFLbfnDekiKLxXeTbXQNAEAb4ZE+33JH0Hs/XfYlzOoxGLBBC/XF5+uEFNQ2F5fGhhSwizCBZ/2HTAH3gYNmO9HuRzxo/ynEOuiBjPy+7he2GCBsJN30pLpx6sdiqziTV+lKZIbZ0Z/DpUixVXg8Hp6okfPtHk+j0dIFhR8peUFUoiaOCxYfp9GxX7ePdVLSCOlmSveWuECgyBc08XyPWNmaTlydjIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imrBtFBtaqyPqWm8PZlsqkuywq29sHGm8/L9gANiuLM=;
 b=BZ9cQLSt9Fz4a/VAfltyX8ZM0jAb+B10L2JMbChAOcIa/6uBo+L7xf8cKZ7i59TQkxoTlkJf6pj2A47xWNwIUto9TfQy8wYWVZFQ95fKTRh9XwtZU7Hd10yWFqpw0FIclKgV/IirjuGVaOIqPrXO9r+kRMWaY51G/moTooLm06t8qt5vc5iA9ZQLjbijIhPzSIjPA2JWKomZqR065Kpke54uwyepdOmFTRH+3xttdW12GF8cry12fDYPnBmoNzh4zFfZmDqTNvoHTNMkG5mzOB6GmA9ISoLS/a65IvgFZqatCwlAfycR5NfNJ98XF8q1jLusPBe1/NC98aTb7Xy56A==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by AM0PR09MB3921.eurprd09.prod.outlook.com (2603:10a6:208:1a1::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 11:27:18 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9723.018; Fri, 20 Mar 2026
 11:27:18 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Weiwei Li <liwei1518@gmail.com>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Warner Losh <imp@bsdimp.com>,
 =?utf-8?B?RnLDqWTDqXJpYyBQw6l0cm90?=
 <frederic.petrot@univ-grenoble-alpes.fr>, Vijai Kumar K
 <vijai@behindbytes.com>, Anton Johansson <anjo@rev.ng>, Daniel Henrique
 Barboza <dbarboza@ventanamicro.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, Alistair Francis <Alistair.Francis@wdc.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Peter
 Maydell <peter.maydell@linaro.org>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH-for-11.1 15/16] target/riscv: Use MO_LE for instruction
 fetch
Thread-Topic: [PATCH-for-11.1 15/16] target/riscv: Use MO_LE for instruction
 fetch
Thread-Index: AQHctsKigb6D7H5uKk2VPuXKtWPTubW3S36A
Date: Fri, 20 Mar 2026 11:27:18 +0000
Message-ID: <a725d39e-6b8a-406f-a8dd-82f02a8fe3d8@htecgroup.com>
References: <20260318103122.97244-1-philmd@linaro.org>
 <20260318103122.97244-16-philmd@linaro.org>
In-Reply-To: <20260318103122.97244-16-philmd@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|AM0PR09MB3921:EE_
x-ms-office365-filtering-correlation-id: 15d90890-9911-431b-0875-08de8673a54b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|1800799024|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: Mx6pjIHcgkKXLnzA0y8VnxJtPozCVsAdydQb/xvZ3QPJ6vRYZwz6StFO0cZGdWCy/E3rCc+5XBWgSJ3J6uOk4yx+hZda6jTJ9YlawMyBVi3w6Y/hmfh2OfyAvRf4+PnUqYc2aCe3UFgMIwUS3mGs54z91qw+3EfnbSBj2bEkycwWBK386BAjqxKfxw8ceqsb05Q4WFHEhtmOhEl2NpLtrSWhkHwC48bnFrIB5GVFkSiHbBhpaK/ysyMRCLxKNYRZLkMsiMPhQxeH5ang5Y9/Eu9tPDp+rqqSooRYF8FPfdAoXKi3c/7UzTN8GfEN1AuUMRjdOZXOkZVuj3b6kTLQ+c7Oiwcb+UIQLrzLvH+Z7xLpo467VwXaUOzZlwBBxMhcdrIayiz0LT1k1ZBfOt7mHbMacihWnzV6lC4WhQ1JZMUmyUJsr8DoprqszhGBgnhhkG6gRcBRlDmvdwBP3m6SEofB9qBqPFDOw6QR7DgROizbgz6cFYTBFQLwvXurte3y8td6Lo170YuwQOXWPKlMx459mWsuglv3/rMJnkKRFVyUYvcINHPDmuit9KBCq2FatKBvqqh9bYN4xuggX9THBcstuvKtAhXk39duPkHHD6LTwH/TG0cqQDvrU3FGPX5cNY9oXA4TwuwLPYsbGeLmdbw7zg3exSw9i/l6DKod6vNQyo5GStDSXeJph3m9U6rtu1DLR/iZAUZ9lD+fYWXiaMs4IitTngzRIz3gBZFNEMBHJJU+uK1CdpLqOxyR255d9RQnIu3McoyIwJ9jIewo01+8BQ6kcVYMqwWuVFgF3wE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWZqMXF1Yk1oSUpxc0xsVGs4VnRHME5oYzVMczBoLzFobythRmRPRThmZm1l?=
 =?utf-8?B?NGpyWGFub3JZb1o1MlJ2VDgvQXdaM2hQZGNybkJrZUpqNXU4NHJQKzdQbkpl?=
 =?utf-8?B?Qlc5MzVVNjNQbmxadzJ1VFhlQVUzclB2elM0S2h0Q2lDVUJPN05WSHdrajdW?=
 =?utf-8?B?M3prZGZQMWYxQ0YxVDgzdnI0eEh3a29hU01ERzN2a3Qvb3F0VFNyWGFRdWE4?=
 =?utf-8?B?VnJISEloRmtKQTdlTXNueEd6UllJMk5TQjk0Z3hVNm5OMjdPMGdSblVQZW92?=
 =?utf-8?B?akhEMmVqNzdKdXN3cm9uVFVrS1lZZXN0Mk5UUU5ZaU5uaDNoK3doMzZjQ0d6?=
 =?utf-8?B?R2U3SytmSVNyTVM3YS9KbzVOSFA5ZlMvcUhhL0tzRHF2UURDcmJKeTNYMWRS?=
 =?utf-8?B?dzFRNmIvNEh5U0VxYkFZc3pYU1M2dWdLd05NMFhiWnFqN044TVphekVRWG9t?=
 =?utf-8?B?MElHdThYdzhhSkRteW1uWFIvbXVyRjFNc0tBZnVtOTZCSWgrSmZiVWVKY3JN?=
 =?utf-8?B?YlBqL3VuRmdQTEZZdGQwdHdZdERXdmJSTGdFb2hQU1M4UTJnV2xxbzNsWXc2?=
 =?utf-8?B?d2t0SWtpMDdubitFakVjbjEyclQvSW9UbndLQkhDUlltMm1kUEJMdER0OFhW?=
 =?utf-8?B?MjZlYk40cnEyRmxEYzVTZ2IzMEFOV1ZGVmp6bWxpZUxTK1hqWVRXcVdiVDk4?=
 =?utf-8?B?TW1QaWFJWEtPdDlKbHZpUkZiR1RFZ2JkYW5TSlFscnF1ZEdkMDRQdGhISEp3?=
 =?utf-8?B?eGR5S2FGOVZ6K29GQW16YkdYeXQ3WnVSdlFuVFIwL1JWZTZaMU5aWm8xNE1m?=
 =?utf-8?B?Y29FS1FVU2Y2M2xtQnpIVGtqRWpwVVZVUEFYbFpyeHpSYUh0RGtaaWRkZUF0?=
 =?utf-8?B?MnBwZ0tLbnFiWVJNQXB3cmRJNUFObC93bGJtZWhZNkFtenRCWGNqdmh5eEdk?=
 =?utf-8?B?SHI4bGVkNGNEUXBUcUtkN01kdlh6aTB6c1lDbk1CMGVsWjZmYTVTMXEvQTZU?=
 =?utf-8?B?NHpGK1Q2V0hlTi9hR2U0NlRnekNHMm5Jd01kelpvUEJQQ0Q2ZmRkVG93OTFW?=
 =?utf-8?B?OXpJZHBMRHhlaUZkdTR4WVRKTzdDN21pYVpCdEVPNkdVZkVFbTVTN3BiNklw?=
 =?utf-8?B?TmF3T3BLZ1BMbUxMWTFGUmJCY2dPeEo1K2lPbHBTb3dYTEROY0Y0SzA1L2xR?=
 =?utf-8?B?Q0NrdnQ5TzhkY1JsWWpKK2NzNW5NYlRibU1sY0hnZTJmWkNTOHJjN01BQWkz?=
 =?utf-8?B?YXhlaVJ6M3VCcmprR1NKd2J3VUxETlFSMi90VEJHVXJSOTZQYUxtbHFoUTVP?=
 =?utf-8?B?NDZsQUdaOVpkTzV1c1p4dy9GbjRzZW5hY2xTemVORGxxY2J4UHB1OTUzY1pE?=
 =?utf-8?B?dGVGR1hVNTcwLzVQcUs4UE9pNS9MZmJlaWRlNkFLb1JWaDVTQjloaHVIOXhD?=
 =?utf-8?B?N1RnRzV5dzQrZW1vUUlNV2ZYcXJJTFpKZWlpdTMzNTFTNzN0UnpOVDcrclV3?=
 =?utf-8?B?TkNLSDF2Rkt2eDBTRGFUQXBtY3pBbTNVSmhvS0g4ZjNvMnVxZFN6TEFucnk4?=
 =?utf-8?B?dDR2U0xYeEdXWkpyVFpTZExOMm5yaEdPK1FFTGloSDRmcmM4RjNkekFRUmFC?=
 =?utf-8?B?VWlDNFJxUnJUNldxSittcUtzWk9VbnhiZEdscHU5UGVDeGMxWEJGMVdiOEha?=
 =?utf-8?B?QjdEWEhMRndCa1ZQaGFnY3VDbkZSalY4WDd4YWFlVHJFVjhua0J2a3RjcWZn?=
 =?utf-8?B?ZHU4L1lmeDlEYzBKQWxKR2hxZjFrQkFTRWh1Rk1pNEdrUjFUazU5MG9XNDRM?=
 =?utf-8?B?R2xsZVMyMkdwM0hiUm5pc3lVYlA4Z2NYWi91QktOUnhqRkVFQWE3bER6WG5q?=
 =?utf-8?B?WXpuN3F5YXZidnJRaGIvTzBiaUlYNzY3eGhuVUsxZzEzbVcyNUZXNkJueGV0?=
 =?utf-8?B?L3JIZ1FaNGJHNXBhZktSZWZ3czB0a0lOZVM1Q216b0pTRlJVNzFhOXUyQnVT?=
 =?utf-8?B?dXRlZ0xBaHZXZmZ1cStmZERmc2E5OER2VkxlMkV0K2paZlN0R2NYbjR0aWJT?=
 =?utf-8?B?WStKbjlLZk4wdkVNWVZHMzBRaW5yWmdBdWR1M3RLV0ZVSTBQanFJOEJ0eHV6?=
 =?utf-8?B?S1A3YmJaQUt5MnEzNzdmekRIWUZCSzY4R3Jpei8vSzg3SEpta0N1bDdZUWV3?=
 =?utf-8?B?NWpJc1RXYis2b3dCbmFycmJXZHpONFlLdVRveWpVRnBBYzhZdHFVaEVKR2ZL?=
 =?utf-8?B?dW9SOFFRcmtNR2hzbU9nWWc4ZWRqbFI4QkVjZG5mM21iWnYrdVdOY3BHSWNx?=
 =?utf-8?B?NFZtNnZZZVpxbGRiZVgwUGJRUGV5VEYwV0QxdzlmNmlUMmUwRW5rUnM0emlJ?=
 =?utf-8?Q?EsWTlf00ipmpLMRJL8ObbdBo6qqEl8IKLp0QP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DBE9A0A1266EF43ACCAAAF08B2ECCB5@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15d90890-9911-431b-0875-08de8673a54b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 11:27:18.5438 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: canM9H/pjyuySRwZQo4wwcLN6t5s2Yhb/r3y0MUVnZxjTG88TFk7zx6v+wsryLmr14ZWMI46RM+aHKJpL8jCckjCzH/ln/jNPF3isyLxRQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3921
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQpPbiAzLzE4LzI2IDExOjMxLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gQ0FV
VElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3JnYW5pemF0
aW9uLiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IHJl
Y29nbml6ZSB0aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+DQo+DQo+
IEZyb206IERqb3JkamUgVG9kb3JvdmljIDxEam9yZGplLlRvZG9yb3ZpY0BodGVjZ3JvdXAuY29t
Pg0KPg0KPiBSSVNDLVYgaW5zdHJ1Y3Rpb25zIGFyZSBhbHdheXMgbGl0dGxlLWVuZGlhbiByZWdh
cmRsZXNzIG9mIHRoZSBkYXRhDQo+IGVuZGlhbm5lc3MgbW9kZSBjb25maWd1cmVkIHZpYSBtc3Rh
dHVzIFNCRS9NQkUvVUJFIGJpdHMuDQo+DQo+IEN1cnJlbnRseSwgaW5zdHJ1Y3Rpb24gZmV0Y2hl
cyBpbiBkZWNvZGVfb3BjKCkgYW5kIHRoZSBwYWdlIGJvdW5kYXJ5DQo+IGNoZWNrIHVzZSBtb19l
bmRpYW4oY3R4KSwgd2hpY2ggcmV0dXJucyBNT19URS4gVGhpcyBoYXBwZW5zIHRvIHdvcmsNCj4g
dG9kYXkgYmVjYXVzZSBSSVNDLVYgdGFyZ2V0cyBhcmUgbGl0dGxlLWVuZGlhbiBvbmx5LCBidXQg
aXMNCj4gc2VtYW50aWNhbGx5IGluY29ycmVjdCBhbmQgd2lsbCBicmVhayBvbmNlIG1vX2VuZGlh
bigpIGlzIHVwZGF0ZWQgdG8NCj4gcmVzcGVjdCBydW50aW1lIGRhdGEgZW5kaWFubmVzcyBmb3Ig
YmlnLWVuZGlhbiBzdXBwb3J0Lg0KPg0KPiBVc2UgTU9fTEUgZXhwbGljaXRseSBmb3IgYWxsIGlu
c3RydWN0aW9uIGZldGNoIHBhdGhzLiBEYXRhIG1lbW9yeQ0KPiBvcGVyYXRpb25zIChBTU9zLCBs
b2Fkcy9zdG9yZXMgdmlhIG14bF9tZW1vcCkgY29udGludWUgdG8gdXNlDQo+IG1vX2VuZGlhbihj
dHgpIGFzIHRoZXkgc2hvdWxkIHJlc3BlY3QgdGhlIGNvbmZpZ3VyZWQgZGF0YSBlbmRpYW5uZXNz
Lg0KPg0KPiBOb3QtU2lnbmVkLW9mZi1ieTogRGpvcmRqZSBUb2Rvcm92aWMgPERqb3JkamUuVG9k
b3JvdmljQGh0ZWNncm91cC5jb20+DQo+IFJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxh
bGlzdGFpci5mcmFuY2lzQHdkYy5jb20+DQo+IE1lc3NhZ2UtSUQ6IDwyMDI2MDMxMTExNTkxMC41
NjQ0ODEtMy1kam9yZGplLnRvZG9yb3ZpY0BodGVjZ3JvdXAuY29tPg0KPiBTaWduZWQtb2ZmLWJ5
OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAg
IHRhcmdldC9yaXNjdi90cmFuc2xhdGUuYyB8IDggKysrKy0tLS0NCj4gICAxIGZpbGUgY2hhbmdl
ZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvdGFy
Z2V0L3Jpc2N2L3RyYW5zbGF0ZS5jIGIvdGFyZ2V0L3Jpc2N2L3RyYW5zbGF0ZS5jDQo+IGluZGV4
IDZmOGI4ZTlkMTlhLi41ZGY1YjczODQ5NSAxMDA2NDQNCj4gLS0tIGEvdGFyZ2V0L3Jpc2N2L3Ry
YW5zbGF0ZS5jDQo+ICsrKyBiL3RhcmdldC9yaXNjdi90cmFuc2xhdGUuYw0KPiBAQCAtMTI1NSw3
ICsxMjU1LDcgQEAgc3RhdGljIHZvaWQgZGVjb2RlX29wYyhDUFVSSVNDVlN0YXRlICplbnYsIERp
c2FzQ29udGV4dCAqY3R4KQ0KPiAgICAgICAgICAgICogYWRkaXRpb25hbCBwYWdlIGZhdWx0Lg0K
PiAgICAgICAgICAgICovDQo+ICAgICAgICAgICBvcGNvZGUgPSB0cmFuc2xhdG9yX2xkbF9lbmQo
ZW52LCAmY3R4LT5iYXNlLCBjdHgtPmJhc2UucGNfbmV4dCwNCj4gLSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIG1vX2VuZGlhbihjdHgpKTsNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIE1PX0xFKTsNCj4gICAgICAgfSBlbHNlIHsNCj4gICAgICAgICAg
IC8qDQo+ICAgICAgICAgICAgKiBGb3IgdW5hbGlnbmVkIHBjLCBpbnN0cnVjdGlvbiBwcmVsb2Fk
IG1heSB0cmlnZ2VyIGFkZGl0aW9uYWwNCj4gQEAgLTEyNjMsNyArMTI2Myw3IEBAIHN0YXRpYyB2
b2lkIGRlY29kZV9vcGMoQ1BVUklTQ1ZTdGF0ZSAqZW52LCBEaXNhc0NvbnRleHQgKmN0eCkNCj4g
ICAgICAgICAgICAqLw0KPiAgICAgICAgICAgb3Bjb2RlID0gKHVpbnQzMl90KSB0cmFuc2xhdG9y
X2xkdXdfZW5kKGVudiwgJmN0eC0+YmFzZSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBjdHgtPmJhc2UucGNfbmV4dCwNCj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1vX2VuZGlhbihjdHgpKTsNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1PX0xFKTsN
Cj4gICAgICAgfQ0KPiAgICAgICBjdHgtPm9sID0gY3R4LT54bDsNCj4NCj4gQEAgLTEyODUsNyAr
MTI4NSw3IEBAIHN0YXRpYyB2b2lkIGRlY29kZV9vcGMoQ1BVUklTQ1ZTdGF0ZSAqZW52LCBEaXNh
c0NvbnRleHQgKmN0eCkNCj4gICAgICAgICAgICAgICBvcGNvZGUgPSBkZXBvc2l0MzIob3Bjb2Rl
LCAxNiwgMTYsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRyYW5zbGF0b3Jf
bGR1d19lbmQoZW52LCAmY3R4LT5iYXNlLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGN0eC0+YmFzZS5wY19uZXh0ICsgMiwNCj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1vX2VuZGlhbihj
dHgpKSk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBNT19MRSkpOw0KPiAgICAgICAgICAgfQ0KPiAgICAgICAgICAgY3R4LT5vcGNvZGUgPSBv
cGNvZGU7DQo+DQo+IEBAIC0xNDAxLDcgKzE0MDEsNyBAQCBzdGF0aWMgdm9pZCByaXNjdl90cl90
cmFuc2xhdGVfaW5zbihEaXNhc0NvbnRleHRCYXNlICpkY2Jhc2UsIENQVVN0YXRlICpjcHUpDQo+
ICAgICAgICAgICAgICAgaWYgKHBhZ2Vfb2ZzID4gVEFSR0VUX1BBR0VfU0laRSAtIE1BWF9JTlNO
X0xFTikgew0KPiAgICAgICAgICAgICAgICAgICB1aW50MTZfdCBuZXh0X2luc24gPQ0KPiAgICAg
ICAgICAgICAgICAgICAgICAgdHJhbnNsYXRvcl9sZHV3X2VuZChlbnYsICZjdHgtPmJhc2UsIGN0
eC0+YmFzZS5wY19uZXh0LA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIG1vX2VuZGlhbihjdHgpKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBNT19MRSk7DQo+ICAgICAgICAgICAgICAgICAgIGludCBsZW4gPSBpbnNuX2xlbihu
ZXh0X2luc24pOw0KPg0KPiAgICAgICAgICAgICAgICAgICBpZiAoIXRyYW5zbGF0b3JfaXNfc2Ft
ZV9wYWdlKCZjdHgtPmJhc2UsIGN0eC0+YmFzZS5wY19uZXh0ICsgbGVuIC0gMSkpIHsNCj4gLS0N
Cj4gMi41My4wDQo+DQpTaWduZWQtb2ZmLWJ5OiBEam9yZGplIFRvZG9yb3ZpYzxEam9yZGplLlRv
ZG9yb3ZpY0BodGVjZ3JvdXAuY29tPg0KDQpUaGFuayB5b3UhDQoNCkkgd2lsbCByZWJhc2UgdGhl
IEJpZy1FbmRpYW4gY2hhbmdlcyBvbiB0b3Agb2YgdGhpcyBwYXRjaC1zZXQuDQoNCg0KQmVzdCwN
CkRqb3JkamUNCg0K

