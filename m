Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09254FF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 09:56:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHIhG-0006Th-M0; Mon, 27 Apr 2026 05:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wHIgL-0006Ak-1c; Mon, 27 Apr 2026 05:55:18 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wHIg7-0007Hm-M3; Mon, 27 Apr 2026 05:55:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NmBo/sBY4nIc/vVn/PcPbbgmBkjAf4vCnyepurxcNhftWA5xV/kOHonz91D5RH7uJky3d+e0SuvFNEWKI/i6+fGkzy2A5kYaSCZuB8LwoZdJB7B5QkzVDF1peIq4N7yeZc3XQ2glV8KVc2WYqBHMXTPDwlKSriYTI3Dz6zvscQx/mmYmC+k9OIF9ImwAvHZw5IMjcbMXuoByz1kc5PD2evRtd8K5Ghx6rfsf5FZAVyRtBIiz32ZZ/3AZ/McYmn7pRlbJ5bjDmtaLy3pAjML4/KQ9a/TpZ0VSfaHcxIVono0h1NfUnv+kgJWoJX1opluFRKbtJpZyJMAxb2Re1Zfjug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrM5RisHraPGqmiKAvcSvDEEhyyvrFo4L4lLViaDXrQ=;
 b=vpJhCPp3e8KBHKE3TTHdIxkR2i2yR0CCwlRAgmK/BQ11GzsRGeN0pYYUyns5nmyCzz2LUpsCqXHlk5b3JGboyQWAyvyXNGF243+Qcs07OvAPH4JRhqWBpTsB9giYgO8RBm3MQ/fTfEbYOaB1285gcxkBBnxeGj9S3VqPd9+iDtYHAOSTCGRCt5toojaWVmHtPwOVq4HsWMlzbJ0OfMSjnplHtqsQpDEhcDXEZtt9MRO/47IlrGJvgT/n+WaHj6UAinVB29BMe0FYaTNeKiI8qcmE0NQvqppjmIWHAZNPjJGCqBKG8zt9Tm6I38xUVhNUqyGgKbeEWkss46PNOeXE7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrM5RisHraPGqmiKAvcSvDEEhyyvrFo4L4lLViaDXrQ=;
 b=c6PBRZdECzBSbfW3rQYA+C9L9E2rUgujbn3E9nHwqxLltjQv44mYPQoOATLOfExGtz00py0K/mD0Nmastd2dohZg9BoOMM8ogr3A6KtU4IDDG7nSOh8zVg3eMGyoS+bUSKUcF14IOv5fwc+vXwQ2EmQW4A/vPPmhIbkTcgsgsj0lNJqZORv3E2ialMJjW5i023iAa5m5vnbQarGWQdSUKZYKOinpv0Guy8tpXv2SXpK6fLVjXMtfr4b1i1bVs77aFGEce6AWdcpsjwU8JmbCiMD2SbOFQ6Or0pDkCqaURopQ2hjaQl/eSC+st6+wAZhe7CAsZD8et0Nib5KVzsWObQ==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TYZPR06MB6516.apcprd06.prod.outlook.com (2603:1096:400:45f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 09:54:49 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 09:54:49 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Troy Lee <troy_lee@aspeedtech.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>
Subject: RE: [PULL 02/32] hw/misc/aspeed_sbc: Connect ASPEED OTP memory device
 to SBC
Thread-Topic: [PULL 02/32] hw/misc/aspeed_sbc: Connect ASPEED OTP memory
 device to SBC
Thread-Index: AQHcMWF+L2UGo6OJWUyqQMwE3TR2a7XvoCOAgAADVwCAA+D1EIAAYRUAgAAHEQCAAAZeEA==
Date: Mon, 27 Apr 2026 09:54:49 +0000
Message-ID: <SI6PR06MB763139AAA2BDD4AB53767B56F7362@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20250929165230.797471-1-clg@redhat.com>
 <20250929165230.797471-3-clg@redhat.com>
 <CAFEAcA8Dja4yqnaHsXc9pg6EzEAVZFR3=E0sGa9Bz4bvuf+_bA@mail.gmail.com>
 <CAFEAcA8nyngyeWi4Vb=ZWJfxNsyFfSqFJMnWnYG2ce95xaCfPA@mail.gmail.com>
 <SI6PR06MB76313BC0842AFB0A8C204E42F7362@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <94332917-c953-4ccf-9e9e-ccb0f2c784b8@redhat.com>
 <c6b6f903-2afe-4753-a522-64ffdbe427c8@redhat.com>
In-Reply-To: <c6b6f903-2afe-4753-a522-64ffdbe427c8@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TYZPR06MB6516:EE_
x-ms-office365-filtering-correlation-id: 0cc41f3a-8d7b-4100-d708-08dea4430555
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003|38070700021|13003099007;
x-microsoft-antispam-message-info: vOvxuTmq34WTUp66OPabm75NEcalBdS9DrgiMk8kW+QzZTnwWC+JKGQN3Tiecqsvmo9QrUllIFTZp8ENw17qrahNXp90hIXnwZTI4TeinMqcwh7CccA8EB9XoFk8SfE+FA+ImKelbjXTSxmSBdiFb7SrAGSoBPGx1RAO32AcgNux9BBRhRTdHo48LF+7Yae9KLYPwgCEeGkqcMNP9QKvZd9FK02k0QobSktVS+jHe21fCAhc1/ycEggC+JU2X7SP8oykpScHLjWly4hLVSVa2G7JnHwYtO7JqNrRGdXg6TZpb0/GsROGOfvauQbOmc/3pY8tXOi0TK9jVWQNHsEn5g88fnaPTY9Trz9kxt1iA+ydr0yoWYJHH61V5/WXKwi+AgZPT0R5bOjfP4UsxB2CX6sAFIGyzX+PybLO+anUzesVipRcRwJE2GbRXweo7gu1vckGfdepT6CoJGdB6bqYZoTT/GUkhSIhYxWVGybmKjrl0xTt4IJlFknW9sDGHy1FTUofz231P/GAA0usA9kDHkg2Ugx5E7U9lyr0cdG9TPixvu2WJWDfgZGgrCOrHXJgI8+Yvtv+V78CQRo83nX8RE+YXdDKge1sM51ZANRwVfDkINHeU61RM3oOBAc7j/jHIlOEikykqKj9V9Z8s6y8JPvszx5bEUu9D3iAxki9I1jzS9+C6J//d6lQC1LQVCcEIpgluMN1r6BVtXggC7D9PWD/JNhdri/x+QqCXhOQOsaqJ2188sesS04hcGM4QM3Db1xzdX9StZwKnUsw1up3ZYaRvRSSfFsjeg1Oj/zBJvY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003)(38070700021)(13003099007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTBMeFkveU5ua3dEVUxEVE1yTndOUmdsOVFvTWlwM1lDNFcxemJqZDlnR1ZY?=
 =?utf-8?B?MGFMaHVwekpGeFIzYlhaN2ppUWgwdlJiNmdrZVNoNnZ2RVRwVXFEVkZrT1gw?=
 =?utf-8?B?MUFBVkF5OHJnQ2owc3dGUDdkNkkweHFtRzBGODhmRXhhdHZxTkdoU2V6dDNG?=
 =?utf-8?B?bzB5T0R1cFBkQW1NOUIvVWtqZEVPaXBnN0ExYW5Xbk8ybVdSRVVISDhUTmJH?=
 =?utf-8?B?c2hPcWpNMGdERzkwUStBWEs4cXBjOGFnMXdHdHBCcUdIeS8ydUhsb05yLzVt?=
 =?utf-8?B?Yngzbmh3T3Bha1BBTVVSRGg4UDJSelNjbDE4M2NncmpjZ1FZUUZzNDdhYjIy?=
 =?utf-8?B?TDRQc1VXcnFVUmZPVEZzSVlNU3Q0b0lFbXo1WHNIT0kzcFFpT3RlTk9PNHVh?=
 =?utf-8?B?dGxGQXBlWUJFUVQzbG9PUmhCUjVJcXg2ZXZ2WlpNa3JneEd4c0xwTHk0MUhX?=
 =?utf-8?B?QkVzaG9TQXdFL0JzUENtMHR1cXdPRVhqam0yZk1OWGduMkdhSHJQQTRyb1BT?=
 =?utf-8?B?WjV2czNOS2luYUJOTldjdlY0ZWcrZ1dXNTdRQmxkM0RBbXBBRzRvb25zS0kx?=
 =?utf-8?B?c3RhUnR4bTRPUitGNi9IQ2pFVWdjcFVXUklrV0FXZ1NsQnlZTlBuMm5tZmZq?=
 =?utf-8?B?QlJ6dWJtZFYzYy9SeFpabU1xendRNmw1eGowTHRiNE5vOTI2VnJmRzUvVHBX?=
 =?utf-8?B?VUVZSFg0OVh5N0RXWHI2RHowT1RkenZGa1hlUC80MFIxU2k2L2VLb0NqaEZD?=
 =?utf-8?B?cnBoakgvdjNvTXpTR1poU29IeFJHZmpzelhIOHdVbTg1akUyY0JwWW8rRFNj?=
 =?utf-8?B?bk13ME5uNDhhWVQ0dDdrMTVZbURtRlBkZGRYZWRyMXFBNzRFUFRUWlpxVXBM?=
 =?utf-8?B?MkRSRWhiZkNPYUR6MUNmTzNIbFZWTkNrNzltL1BYY2xHYmZuTVZqK3UvVTNt?=
 =?utf-8?B?WVdQUEJwRnB4YVlvZjVMZ3BGQS9NeCtqYWRXNFlITVFRU2I4eGdyN0ZUYzVD?=
 =?utf-8?B?OXlSS3dHalJTVXQraTdnU1RJK0dLak44SjBzdWhYOWNtZ0xPNzNCSlN6Rk5M?=
 =?utf-8?B?QUZLaHFHZlhBSVlFRWRZNlRsclMxMklUK29jd1VWK29CTHZGTWoxMWEzTktB?=
 =?utf-8?B?cFBMSUNhVWJXYmc3S1lIc1NtN3dXUXd2Tm8wT2hqbk95WmVCYlA2NndyVlFq?=
 =?utf-8?B?eVFJb1dUL1h6Mk5XR3VSZkVpK0JmenlGM3diMTN2c1FjenBDYWpXdlMvaGtz?=
 =?utf-8?B?SEdoVkVza1ZhS2VYeThmSU11dldVRjUzMzZlL1dNbGVocEorb2J5TjlqY3hV?=
 =?utf-8?B?MzQ0VGhiWDM4dERvSEdRMElaL083WXc3d245Tklxc0lzZllJK1JBRENMUjMz?=
 =?utf-8?B?WE9qcVlXWGN0QzNoU01HWFJKZ3BPSWJ4RWJiaVZValNiNmhLOWduMjhLS0lG?=
 =?utf-8?B?YnRnM2J0Rmgwb3NGcWRodFhpdjQzdDh1RG5DMVh6TVczNG1lM2ZwUW56bVg1?=
 =?utf-8?B?TjdlVTZsdS81cXEzTnJqZk4yL0NXTlJmdW93U2NoUUpRZWJ0NTcvWTZNMzFU?=
 =?utf-8?B?bmJOQjdqZ2tRSXBVNERXQnJHQTlTRFhlTDE1aXpOdGlPVm52V2MvZWttUU5o?=
 =?utf-8?B?QnE5TjdFZVdmbkx5R1FSMEtpMmRRQUVEenR1NnRZYUp0WXZtbExpRU1iZkJQ?=
 =?utf-8?B?WFRqa3BXRjBWNHpwS3NGVG01K0EwcUt6RXg1Ry9HY01RMHcyWU11UzBrbzB5?=
 =?utf-8?B?S3VyRUFSZ2JNQ0lSU2J6TkJ0ZlB0alpOSWl2a0d4M1ZscFJQUmVxcmtoSFYr?=
 =?utf-8?B?WklHamVMc2RUNTZSdk5BVHpKWDZIM2xvQ0xnUnhpL25Oa1RRVitJL2xZRkI0?=
 =?utf-8?B?ZXY0djFkdWRVUlZXVElVMlU4bFM5dGErOEVKc3FDaXAvLzFGakw2dy9vY2Ux?=
 =?utf-8?B?b2hMaE5MS2w0VUU5SXBSRm5yeVo4akRIVVp3d1VrektibWd3ODBtSWR3VXdN?=
 =?utf-8?B?SjBEUk9OSUlxMGVERi9vOTN5dXFGTFNIaWFaTHEzMnNZYmxkblRZcUsrWm42?=
 =?utf-8?B?TWNweFByUGhjMlQ3T0NyYkhkclhxWnB6ME1JL3dOYkRhNnZ4aHR3N1E1eVFi?=
 =?utf-8?B?L1BRQWthWVRadWRrVDkyTkpsYThiNHM5UkdpSXNTc3FrYVhXVnlhVGhoektn?=
 =?utf-8?B?MkRLRmNJM0l3c3E1azNqcTRpend2QVROaC9ZSkNwUmplREw2NTIxYjkwUnh3?=
 =?utf-8?B?TXovcnU1WkVNWFhuTnNZY1ZXczJTaUM5d1VvR0NmaE9NRWRyOXR3RHdPaDNQ?=
 =?utf-8?B?UnhiYlh1MXZxN3Z4MXBSM3dLczBLNGtCOUR0cVdSWFphNjBLUmM0QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc41f3a-8d7b-4100-d708-08dea4430555
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 09:54:49.2027 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8w0NUFYcR9uniAkBs03ZyHkqFHdZAD+S1le99pLRw7Bgn+j3e6ctRkp3RHmFgriPJSWI3zjWQHiDQozK1rNNXn8t/o2+lwScBtZza//f5Us=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6516
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=kane_chen@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8
Y2xnQHJlZGhhdC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgQXByaWwgMjcsIDIwMjYgNToyNSBQTQ0K
PiBUbzogS2FuZSBDaGVuIDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+OyBQZXRlciBNYXlkZWxs
DQo+IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+DQo+IENjOiBxZW11LWFybUBub25nbnUub3Jn
OyBxZW11LWRldmVsQG5vbmdudS5vcmc7IFRyb3kgTGVlDQo+IDx0cm95X2xlZUBhc3BlZWR0ZWNo
LmNvbT47IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BVTEwgMDIvMzJdIGh3L21pc2MvYXNwZWVkX3NiYzogQ29ubmVjdCBBU1BFRUQgT1RQIG1l
bW9yeQ0KPiBkZXZpY2UgdG8gU0JDDQo+IA0KPiBPbiA0LzI3LzI2IDEwOjU5LCBDw6lkcmljIExl
IEdvYXRlciB3cm90ZToNCj4gPiBPbiA0LzI3LzI2IDA1OjE2LCBLYW5lIENoZW4gd3JvdGU6DQo+
ID4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+Pj4gRnJvbTogUGV0ZXIgTWF5ZGVs
bCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KPiA+Pj4gU2VudDogRnJpZGF5LCBBcHJpbCAy
NCwgMjAyNiAxMTo1OCBQTQ0KPiA+Pj4gVG86IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0
LmNvbT4NCj4gPj4+IENjOiBxZW11LWFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5v
cmc7IEthbmUgQ2hlbg0KPiA+Pj4gPGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPj4+IFN1
YmplY3Q6IFJlOiBbUFVMTCAwMi8zMl0gaHcvbWlzYy9hc3BlZWRfc2JjOiBDb25uZWN0IEFTUEVF
RCBPVFANCj4gPj4+IG1lbW9yeSBkZXZpY2UgdG8gU0JDDQo+ID4+Pg0KPiA+Pj4gT24gRnJpLCAy
NCBBcHIgMjAyNiBhdCAxNjo0NiwgUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8u
b3JnPg0KPiB3cm90ZToNCj4gPj4+PiBCdXQgaGVyZSBpbiB0aGUgcHJvZyBwYXRoLCB3ZSB1c2Ug
dGhlIGFkZHJlc3MgZnJvbSB0aGUgZ3Vlc3QNCj4gPj4+PiBkaXJlY3RseSBpbiB0aGUgY2FsbCB0
byBhZGRyZXNzX3NwYWNlX3dyaXRlLiBUaGlzIG1lYW5zIHRoYXQgdGhlDQo+ID4+Pj4gYWRkcmVz
cyB0aGUgTWVtb3J5UmVnaW9uIGluIHRoZSBPVFAgZGV2aWNlIHNlZXMgaXMgbm90IG5lY2Vzc2Fy
aWx5DQo+ID4+Pj4gNCBhbGlnbmVkLCBhbmQgdGhhdCBpdCBjYW4gaGF2ZSB2YWx1ZXMgdGhhdCBl
eGNlZWQgdGhlIHZhbGlkIHNpemUNCj4gPj4+PiBvZiB0aGUgT1RQLg0KPiA+Pj4+DQo+ID4+Pj4g
VGhlIE9UUCBkZXZpY2Ugb24gdGhlIG90aGVyIGVuZCBzZWVtcyB0byB0cnkgdG8gYWNjb3VudCBm
b3IgdGhpcw0KPiA+Pj4+IGRpZmZlcmVuY2U6IGl0cyByZWFkIGZ1bmN0aW9uIHVzZXMgdGhlIG9m
ZnNldCBpdCBpcyBwYXNzZWQgYXMtaXMsDQo+ID4+Pj4gd2hlcmVhcyBpdHMgd3JpdGUgZnVuY3Rp
b24gdXNlcyAib3RwX29mZnNldCA9IG90cF9hZGRyIDw8IDIiIHRvDQo+ID4+Pj4gY29udmVydCB0
aGUgb2Zmc2V0IGludG8gYSBieXRlIG9mZnNldCBiZWZvcmUgdXNpbmcgaXQgYXMgYW4gYXJyYXkN
Cj4gPj4+PiBpbmRleCBldGMuIEJ1dCB0aGUgd3JpdGUgZnVuY3Rpb24gZG9lc24ndCBjaGVjayB3
aGV0aGVyIGl0J3MgZ290IGFuDQo+ID4+Pj4gb3ZlcmxhcmdlIHZhbHVlLCBzbyBJIHRoaW5rIGl0
IGNhbiB3cml0ZSBvZmYgdGhlIGVuZCBvZiB0aGUgc3RvcmFnZS4NCj4gPj4+DQo+ID4+PiBJIGZv
dW5kIGEgcmVwcm8gd2hpY2ggdHJpZ2dlcnMgYSBjbGFuZyBhc2FuIGZhaWx1cmUsIHNvIEkgZmls
ZWQgYSBidWc6DQo+ID4+Pg0KPiA+Pj4gaHR0cHM6Ly9naXRsYWIuY29tL3FlbXUtcHJvamVjdC9x
ZW11Ly0vd29ya19pdGVtcy8zNDM2DQo+ID4+Pg0KPiA+Pj4gV291bGQgeW91IG1pbmQgaGF2aW5n
IGEgbG9vayBhdCBpdD8NCj4gPg0KPiA+IFRoYW5rcyBQZXRlci4gSSByZWFsbHkgYXBwcmVjaWF0
ZSB0aGUgc2ltcGxpY2l0eSBvZiB0aGUgdGVzdCBjYXNlLg0KPiA+DQo+ID4+Pg0KPiA+Pg0KPiA+
PiBIaSBQZXRlciwNCj4gPj4NCj4gPj4gU29ycnkgZm9yIHRoZSBjb25mdXNpb24uIEkgcGxhbiB0
byBtb3ZlIHRoZSBhZGRyZXNzIGNvbnZlcnNpb24NCj4gPj4NCj4gPj4gb3RwX29mZnNldCA9IG90
cF9hZGRyIDw8IDI7DQo+ID4+DQo+ID4+IGZyb20gYXNwZWVkX290cF93cml0ZSB0byB0aGUgdXBw
ZXIgbGF5ZXIgKGFzcGVlZF9zYmNfb3RwX3Byb2cpIHRvDQo+ID4+IGVuc3VyZSBjb25zaXN0ZW50
IGJlaGF2aW9yIGJldHdlZW4gdGhlIHJlYWQgYW5kIHdyaXRlIHBhdGhzLiBUaGlzDQo+ID4+IHNo
b3VsZCBoZWxwIHJlZHVjZSBjb25mdXNpb24gYW5kIGFsaWduIHRoZSBpbXBsZW1lbnRhdGlvbiBt
b3JlIGNsZWFybHkuDQo+ID4+DQo+ID4+IElmIHRoZXJlIGFyZSBubyBjb25jZXJucyB3aXRoIHRo
aXMgY2hhbmdlLCBJIHdpbGwgcHJvY2VlZCB3aXRoDQo+ID4+IHN1Ym1pdHRpbmcgYSBwYXRjaCBz
aG9ydGx5Lg0KPiA+DQo+ID4gSGVsbG8gS2FuZSwNCj4gPg0KPiA+IFNlZSBiZWxvdy4NCj4gPg0K
PiA+DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9sZWdvYXRlci9xZW11L2NvbW1pdC9mMjk2N2M1YmI2
MDg0OTAzZGIxNzhjMDhhZmUyYg0KPiA0DQo+ID4gMTBkZDk4ZDNmZg0KPiANCj4gVGhlcmUgaXMg
bW9yZSB0byBpdC4gVGhlIGFkZGl0aW9uYWwgc2hpZnQgaW4gQXNwZWVkIE9UUCBtb2RlbCBzaG91
bGQgYmUNCj4gcmVtb3ZlZCB0b28uIFdpdGggdGhhdCwgdGhlIG1lbW9yeSB0cmFuc2FjdGlvbnMg
b24gdGhlIE9UUCBzdG9yYWdlIHNob3VsZCBiZQ0KPiBzYWZlLiBJIHRoaW5rLg0KPiANCj4gSSBw
dXNoZWQgYSBuZXcgdmVyc2lvbiBvbiBicmFuY2ggYXNwZWVkLTExLjENCj4gDQo+IFRoYW5rcywN
Cj4gDQo+IEMuDQo+IA0KSGkgQ8OpZHJpYywNCg0KSSBoYXZlIG1vZGlmaWVkIHRoZSBjb2RlIGFu
ZCBhbSBjdXJyZW50bHkgcnVubmluZyBmdW5jdGlvbmFsIHRlc3RzLiBPbmNlIHRoZSB0ZXN0cyBh
cmUNCmNvbXBsZXRlZCB3aXRob3V0IGFueSBlcnJvcnMsIEknbGwgZ28gYWhlYWQgYW5kIHNlbmQg
b3V0IHRoZSBwYXRjaC4NCg0KQmVzdCBSZWdhcmRzLA0KS2FuZQ0KDQo+ID4gSG93ZXZlciwgdGhl
IGZ1bmN0aW9uYWwgdGVzdHMgYXJlIGJyb2tlbi4gVGhlc2UgdGVzdHMgc2hvdWxkIGJlIHVzaW5n
DQo+ID4gcmVhbCBIVyB2YWx1ZXMgcHJlZmVyYWJseSBhbmQgbm90IHZhbHVlcyBleHBlY3RlZCBi
eSBRRU1VLg0KPiA+IENhbiB5b3UgcGxlYXNlIGZpeCB0aGUgdGVzdHMgYW5kIHNlbmQgdGhlIHBh
dGNoIGJlbG93ID8NCj4gPg0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+DQo+ID4gQy4NCj4gPg0KPiA+
ICBGcm9tIGYyOTY3YzViYjYwODQ5MDNkYjE3OGMwOGFmZTJiNDEwZGQ5OGQzZmYgTW9uIFNlcCAx
NyAwMDowMDowMA0KPiA+IDIwMDENCj4gPiBGcm9tOiA9P1VURi04P3E/Qz1DMz1BOWRyaWM9MjBM
ZT0yMEdvYXRlcj89IDxjbGdAcmVkaGF0LmNvbT4NCj4gPiBEYXRlOiBNb24sIDI3IEFwciAyMDI2
IDEwOjUwOjIxICswMjAwDQo+ID4gU3ViamVjdDogW1BBVENIXSBody9taXNjL2FzcGVlZF9zYmM6
IEFkZCBib3VuZHMgY2hlY2tpbmcgZm9yIE9UUCB3cml0ZQ0KPiA+ICDCoG9wZXJhdGlvbnMNCj4g
PiBNSU1FLVZlcnNpb246IDEuMA0KPiA+IENvbnRlbnQtVHlwZTogdGV4dC9wbGFpbjsgY2hhcnNl
dD1VVEYtOA0KPiA+IENvbnRlbnQtVHJhbnNmZXItRW5jb2Rpbmc6IDhiaXQNCj4gPg0KPiA+IFRo
ZXJlIGlzIGEgbWlzbWF0Y2ggYmV0d2VlbiB0aGUgQXNwZWVkIE9UUCBtb2RlbCBhbmQgdGhlIEFz
cGVlZCBTQkMNCj4gPiBtb2RlbCBpbiBob3cgdGhlIGd1ZXN0LXByb3ZpZGVkIGFkZHJlc3MgaXMg
aGFuZGxlZC4NCj4gPiBhc3BlZWRfc2JjX290cF9wcm9nKCkgcGFzc2VzIGEgd29yZC1pbmRleGVk
IGFkZHJlc3MgZGlyZWN0bHkgdG8NCj4gPiBhZGRyZXNzX3NwYWNlX3dyaXRlKCkgd2l0aG91dCBj
b252ZXJ0aW5nIGl0IHRvIGEgYnl0ZSBvZmZzZXQsIHdoZXJlYXMNCj4gPiBhc3BlZWRfb3RwX3dy
aXRlKCkgZXhwZWN0cyBhIGJ5dGUgb2Zmc2V0IGFuZCBhcHBsaWVzIGFuIGFkZGl0aW9uYWwNCj4g
PiBzaGlmdCAob3RwX2FkZHIgPDwgMikuIFRoaXMgZG91YmxlLXNoaWZ0IGNvbmZ1c2lvbiBtZWFu
cyB0aGF0IGFuDQo+ID4gb3V0LW9mLXJhbmdlIHdvcmQgYWRkcmVzcyBjYW4gbGVhZCB0byBhIHdy
aXRlIGJleW9uZCB0aGUgYWxsb2NhdGVkDQo+ID4gc3RvcmFnZS4NCj4gPg0KPiA+IEZpeCB0aGlz
IGJ5IGFkZGluZyBib3VuZHMgY2hlY2tpbmcgb24gdGhlIHdvcmQgb2Zmc2V0IGJlZm9yZQ0KPiA+
IGNvbnZlcnRpbmcgdG8gYnl0ZSBvZmZzZXQgYW5kIHBhc3NpbmcgdG8gYWRkcmVzc19zcGFjZV93
cml0ZSgpLg0KPiA+IFRoaXMgbWF0Y2hlcyB0aGUgZXhpc3RpbmcgYm91bmRzIGNoZWNrIGluIGFz
cGVlZF9zYmNfb3RwX3JlYWQoKS4NCj4gPg0KPiA+IENjOiBLYW5lLUNoZW4tQVMgPGthbmVfY2hl
bkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiBDYzogcWVtdS1zdGFibGVAbm9uZ251Lm9yZw0KPiA+IEZp
eGVzOiAxYTAwNzU0Y2NmMTUgKCJody9taXNjOiBBZGQgQXNwZWVkIFNlY3VyZSBCb290IENvbnRy
b2xsZXINCj4gPiBtb2RlbCIpDQo+ID4gUmVzb2x2ZXM6IGh0dHBzOi8vZ2l0bGFiLmNvbS9xZW11
LXByb2plY3QvcWVtdS8tL3dvcmtfaXRlbXMvMzQzNg0KPiA+IFJlcG9ydGVkLWJ5OiBQZXRlciBN
YXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+DQo+ID4gU2lnbmVkLW9mZi1ieTogQ8Op
ZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPiA+IC0tLQ0KPiA+ICDCoGh3L21pc2Mv
YXNwZWVkX3NiYy5jIHwgMTEgKysrKysrKysrLS0NCj4gPiAgwqAxIGZpbGUgY2hhbmdlZCwgOSBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L21p
c2MvYXNwZWVkX3NiYy5jIGIvaHcvbWlzYy9hc3BlZWRfc2JjLmMgaW5kZXgNCj4gPiAwNjVlODIy
ZTcwZDkuLjUwZDQ5OWY5MjRkYyAxMDA2NDQNCj4gPiAtLS0gYS9ody9taXNjL2FzcGVlZF9zYmMu
Yw0KPiA+ICsrKyBiL2h3L21pc2MvYXNwZWVkX3NiYy5jDQo+ID4gQEAgLTE1OSw5ICsxNTksMTYg
QEAgc3RhdGljIGJvb2wgYXNwZWVkX3NiY19vdHBfcHJvZyhBc3BlZWRTQkNTdGF0ZQ0KPiA+ICpz
LA0KPiA+ICDCoMKgwqDCoCBNZW1UeFJlc3VsdCByZXQ7DQo+ID4gIMKgwqDCoMKgIEFzcGVlZE9U
UFN0YXRlICpvdHAgPSAmcy0+b3RwOw0KPiA+ICDCoMKgwqDCoCB1aW50MzJfdCB2YWx1ZSA9IHMt
PnJlZ3NbUl9DQU1QMV07DQo+ID4gK8KgwqDCoCB1aW50MzJfdCBvdHBfb2Zmc2V0Ow0KPiA+DQo+
ID4gLcKgwqDCoCByZXQgPSBhZGRyZXNzX3NwYWNlX3dyaXRlKCZvdHAtPmFzLCBvdHBfYWRkciwN
Cj4gPiBNRU1UWEFUVFJTX1VOU1BFQ0lGSUVELA0KPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZ2YWx1ZSwgc2l6ZW9mKHZhbHVlKSk7DQo+ID4gK8Kg
wqDCoCBpZiAob3RwX2FkZHIgPj0gT1RQX1RPVEFMX0RXT1JEX0NPVU5UKSB7DQo+ID4gK8KgwqDC
oMKgwqDCoMKgIHFlbXVfbG9nX21hc2soTE9HX0dVRVNUX0VSUk9SLCAiSW52YWxpZCBPVFAgYWRk
cg0KPiAweCV4XG4iLA0KPiA+ICtvdHBfYWRkcik7DQo+ID4gK8KgwqDCoMKgwqDCoMKgIHJldHVy
biBmYWxzZTsNCj4gPiArwqDCoMKgIH0NCj4gPiArDQo+ID4gK8KgwqDCoCBvdHBfb2Zmc2V0ID0g
b3RwX2FkZHIgPDwgMjsNCj4gPiArwqDCoMKgIHJldCA9IGFkZHJlc3Nfc3BhY2Vfd3JpdGUoJm90
cC0+YXMsIG90cF9vZmZzZXQsDQo+ID4gK01FTVRYQVRUUlNfVU5TUEVDSUZJRUQsDQo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
JnZhbHVlLCBzaXplb2YodmFsdWUpKTsNCj4gPiAgwqDCoMKgwqAgaWYgKHJldCAhPSBNRU1UWF9P
Sykgew0KPiA+ICDCoMKgwqDCoMKgwqDCoMKgIHFlbXVfbG9nX21hc2soTE9HX0dVRVNUX0VSUk9S
LA0KPiA+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiRmFp
bGVkIHRvIHdyaXRlIE9UUCBtZW1vcnksIGFkZHIgPQ0KPiAleFxuIiwNCg0K

