Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C3EE77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 09:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTeRU-0001bw-14; Fri, 03 Jan 2025 04:58:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1tTeRC-0001Zv-NW; Fri, 03 Jan 2025 04:57:52 -0500
Received: from mail-eastasiaazlp170100000.outbound.protection.outlook.com
 ([2a01:111:f403:c400::] helo=HK2PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1tTeRA-0003TH-3X; Fri, 03 Jan 2025 04:57:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TiR44lwt0Lu9Ng0m7zv297bYN8t+HZJYYplkhjcXxWBqroa8J/X0yAl9a7fDzjuKPePZ96mpc4oSJMKduexDS2KJ0LZjZVcUoHkdYCXprIT8OQoXD1YRcF7O1aDUnA/zqJTPFX2Fu3SGLryn87H1N3Kkmt1oaimRCY9seMN+u6Sb1hEpXqj7wTCp4niGGVF1XCpiwjEjHrE2Jso7SJUMZ7yLE/dK/7xMe8EdgGrvLZfSttQpid7pR732Ix0TiyVKpc3kyblFykRK5OY9KPHS3pDq52tZQrJT25jjGJejCd3igIE7TZJt7l1g1/DfU9GWgXknVEer0lb/4buMZsL/UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yhbzaKAeV0jKDyISgxbYK40h95AgvgJuSW804/JiMc=;
 b=F0snmu6cUI3dGfDlxKW42pkYd9eL06SKTtPmPnPmc8wYzp7jIobJiTnhRHcJ6aDJb4lNG4HXBJEu1gMpfyUZ4rVAd0ndUo7H0FAyni7Vf5MTPDweTHk+mR5kncIV1HRUikhlVIB4PSzHEBSjXpqvnWAs5RD0D7rFCI6K4a+q1EfOhuaAZQk2mT2pcxPiNPk+4/YlejsMyJUj+eegx2xdX04XbMxM55ZUqgEla5gZ0w6FwJ8iEKNnkk9nmPAM676YKQC9wubAkNcQC0hkvioLweLdh+WqiGqXf8kubo4hLm0sr4eFwqrfPpGVwfrqi+XjNIOaG8F+k6bOL40sJNymDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yhbzaKAeV0jKDyISgxbYK40h95AgvgJuSW804/JiMc=;
 b=ir1S37jghaLuTOUbxUbnpH/3uEvjttI9oIsQczIOIJElI+wiVQfAZU4j3Em7cCzSpbPvOXgJZHRBOpexAZh+3gJDWvGG52JD+flrJpbA0mcsAp7feLEoeoXzl6RvZ2fpbtkeVj+nTUEAJ/gEvSzAbxqcMsg0IJ7KP5iXsG1hbbd4DrpByyQm00YfUpD25Ft1IM6yOwzSQNcQAyH+8nHLD333o2FoXGe5SbH/3nrSZWLVX/+snH9ZJsQleA0cc8oTPvlntbgOC3nPsM9PZL90PRkL2dUgFenKABYy7qqS4Q0SiM2E4u+Mjr9crSxw8Lvj9cp1KOXSvsXyKXEPBvWisg==
Received: from KL1PR0601MB4180.apcprd06.prod.outlook.com
 (2603:1096:820:29::12) by SEZPR06MB5200.apcprd06.prod.outlook.com
 (2603:1096:101:74::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Fri, 3 Jan
 2025 09:57:35 +0000
Received: from KL1PR0601MB4180.apcprd06.prod.outlook.com
 ([fe80::6fe5:1995:96a2:552a]) by KL1PR0601MB4180.apcprd06.prod.outlook.com
 ([fe80::6fe5:1995:96a2:552a%5]) with mapi id 15.20.8335.003; Fri, 3 Jan 2025
 09:57:35 +0000
From: Steven Lee <steven_lee@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH 2/5] aspeed: ast27x0: Map unimplemented devices in SoC
 memory
Thread-Topic: [PATCH 2/5] aspeed: ast27x0: Map unimplemented devices in SoC
 memory
Thread-Index: AQHbVnErB499n6uXaUmGfhRv4qg92LL53XOAgAlhsYCAAZwOgIAAAEHQ
Date: Fri, 3 Jan 2025 09:57:35 +0000
Message-ID: <KL1PR0601MB4180BBD75C70B77F1476759385152@KL1PR0601MB4180.apcprd06.prod.outlook.com>
References: <20241225020311.3718080-1-steven_lee@aspeedtech.com>
 <20241225020311.3718080-3-steven_lee@aspeedtech.com>
 <94c71f3b-4c3a-4989-af08-2cf07c8aca2c@kaod.org>
 <KL1PR0601MB418046C74568BBE39A6ECB1B85152@KL1PR0601MB4180.apcprd06.prod.outlook.com>
 <09cccc1d-e678-4f79-af5d-673d5f9c5588@kaod.org>
In-Reply-To: <09cccc1d-e678-4f79-af5d-673d5f9c5588@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4180:EE_|SEZPR06MB5200:EE_
x-ms-office365-filtering-correlation-id: ae7a4d15-f9c0-4333-66a9-08dd2bdd0c57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aVB3MHJPTTN6WDZ0aXIrVytrLy9oOFFXUFRKcDZVQ3lNU3VaZ3NFR1J6K0xW?=
 =?utf-8?B?UGxoMkxoQVNjNlFkclVpMy9JaDh5ZStqNWZkazVVemFMK0hvYlVEK0RVVzha?=
 =?utf-8?B?dmg3YTJHSThsR0JsVlc3Ry9kSitLSTN5NVUvcHpEd2R4N1N2SitNTy9lMDYy?=
 =?utf-8?B?WWcyNnlwTkxUN1A2dEhvVVZTcFdZWG9ZbHVtKzNORHF1L2FWR2x4cWxKd2ts?=
 =?utf-8?B?aHZncUxKSHNybjREN2dDaWtSaTBKOW9BSWhFUVF5U0tmYjE1djFLRkk1bTg1?=
 =?utf-8?B?Y004cDdaTVVPQ3hwNTlRNnhRWmwxRThCc0VIWTlvY2NoR3g2enlpa2pPMC80?=
 =?utf-8?B?QnROM0hVa1FwalVyN2JYTk1TL3VENXVjNUJ1c0VKL3ltMXljcHJ4WGJia0Qx?=
 =?utf-8?B?eVBjblBONVFBckJ3TEtFMHhwU2F5QkNPVGpkTjIzUFkrK1VmbG0xSTFWVWJq?=
 =?utf-8?B?SU8xejFQT2Fad0lUOGhlRWdScU5MSzIxdWEwak1scjhwNVBSWjJyOGRUOFZO?=
 =?utf-8?B?VXpnTFRPTXFpVjNZeFYzbzhHazEyY3cwblMwdFUwOWdsckFjM1Fzc1k3Tk9o?=
 =?utf-8?B?S0lUeDRuR2lzajQvK3hueHE2YjJhbi9Ba0M5TWNiZkh0b1EwUzdzQ3RHM2t5?=
 =?utf-8?B?elh1NGJGK2ppdFJMRXZYcC9SaEUvWVk5N0JYMU85a21Hd1A4djV4ZWpDaHV1?=
 =?utf-8?B?NFBLM0tOeVVlVGNjYWJwYVF4cnd4cjJmZnBiUFdyQTl2YWhLVkYvTThkNnpH?=
 =?utf-8?B?ZHVTMzFSNGxlaFFHMVRRZXJscGgzYVllK2NKcllpelYrbFNmUlJGOWJvakhh?=
 =?utf-8?B?dW16SkswQitqZmtlekJYWk5uUWxBVlkySWwyYkpWOFBHUXluNTdsMG5icFhR?=
 =?utf-8?B?TGZQR21ZTjZ2TGp3TE51S3FJYnh5anV5NndidnBFTzhkeHZvTm5meU1xK1F1?=
 =?utf-8?B?L1YwT1JaOXhuc2VseENadFppcHg5UzdUQ1JvdHA1WEdOQmtodS92Mi85RGlj?=
 =?utf-8?B?R0FyaFRuZzBnU09jV1YwQnFjWThMdnhiZnh5VE54bGo4bHJxdUlJd2cvSTFy?=
 =?utf-8?B?anQ4Q0IxUTI3YUZIdklXMHRRdjdXQ1lOK3RMQnptdHp5cjNIVzZDSnU2djNO?=
 =?utf-8?B?VThxNUtRUWl0UHFtcU9yKzNaemR2MzlQbUk0WFYwcW9IUU02dzVzYkZJVlhk?=
 =?utf-8?B?M0pUa2tOYi9tbjQyTG1SMS9ZeFh4bHNpQ3BOanNpbUJTREI2SDR3TGU4bDlT?=
 =?utf-8?B?cWpiYXBvZVlBZmJtMVFhZ1h4TzBYWFQ0QUVYTWxUcjJLOWUwTXhWdHhHVVZO?=
 =?utf-8?B?b1B5ZjlxN3FkTlV5K2FZajVESXkyY1lQVW4vd0FZQ3hITWs3QXd6bXhvNmVK?=
 =?utf-8?B?Q1VZWW5HSzUzVmczVjY1ZE8yOXlBeW1pVGNiZjBmRHRNMDFUK0F6cGs2cU90?=
 =?utf-8?B?VDFGeXo2NzkrSTFQZHp3bmdmNnQzWDFBL2hjSlYvWFp2QUNhMnd1MUZtS080?=
 =?utf-8?B?Wjk2M3E3L3JYOVVuZ1hiNkoyUnhMcWNFWEJFSDRhK0x4WFRkMEtyUWFtNHgv?=
 =?utf-8?B?c3RlUzlraWo5Q0p0WkFiUG41ZHQ0TndPenhkL3JVRzZsSjQ1SmtMK2tYT1JN?=
 =?utf-8?B?cmhWbzNVZ2gzMFBpblpTdGxCWTV0azQzWC9jVmxnV1k0bVIxamJubDBobUxD?=
 =?utf-8?B?VE9tbm85VDFXRCt3VklPdjRJNGNoVTExMDNUTjBkZ1JEVnp2dnE5ZFY1SmdS?=
 =?utf-8?B?Wm5sQ2hOa2pvZVF2RGY4S2lQc0ozYStYeUFJdzZUaytlTlJMSGxweEJFRHA4?=
 =?utf-8?B?Q3Q4ZUZFNk80aTFldTIzb2NtMk5tZi9ualh0RHh2L2N2M2lITFQycitiSEp1?=
 =?utf-8?B?L0Z3SDAxd2hDL09hYk4wQ2p5NE5UM1VwcHl3OCs2V2hYUnd5dWJjVmpYYjNa?=
 =?utf-8?Q?hzUGpbQq33bXH3LIeOBlE7ztUFaPUmJM?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR0601MB4180.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3BtU1RLRFJmUlJrQlVlTDN6ak9rM0JOSnNQcUtyRDdZT2hPK2hNL2pjU1hT?=
 =?utf-8?B?MFlNN0dpSVU1NU1xWWt2Sys2elBxQmYwSWhsaGh5Y2FpSGhtV1hxcGswNG1i?=
 =?utf-8?B?RWRBZElRNnZxMjY4eDVFcE9NOWg2WVBIZmc3cElSaFBwM0xoUUxYK1FtakU1?=
 =?utf-8?B?cGwrc1p5R0NNR0VGcTZCSkl0bXM1Q3RpVVFtampWVHdjMWp2WDBCRUJnVkdt?=
 =?utf-8?B?OFY1b1BDVzFGYytDTzJDWnJsdGxRMUZTdmVZb1ZlSTZseTRSZ2hnYTVFOElr?=
 =?utf-8?B?Z2U4b05GQWtmQ29HWUFtR1pZYkJFSFo4cCsxNGNOL0p0YjV0K3ppOUZtSkda?=
 =?utf-8?B?U2RSTHJvZGZocjNoZWZJWm1WQ1VhZ0x6eDlGQ2Q1UkdkM3BpdDdHVjU1U0l2?=
 =?utf-8?B?TUZCbExTZDErb3M5WGo5M0JrRklSd1lnOGtML2pFNkpZNm4wMU9vb2UwUkVU?=
 =?utf-8?B?TlNJSTF6VjF2Z2pPR0UvaEI1c3YybHVpS09SWEF5K2QxK2wzNCtmbGNzazJk?=
 =?utf-8?B?Y3drd1lBUnBXQndxK0N4RVNLY2pFR1Z0amtrcFpkVzBtNVRBWWlUd3luTTdC?=
 =?utf-8?B?UWtJOEExanF6bDRWZkhLZEhsSW4vRVd4VHIwWEtmT2U0K3lxSGVZVjdSU2ZS?=
 =?utf-8?B?TTFIWTc3SHFqNGtWVTJTSldsOVhQTEY2QS9saThpMWtoNDRoa1loc0IwQzZy?=
 =?utf-8?B?K0VpM2J1Vys0S3kwd0FOemQrYUc2TjZ1Y2tjRVhVMm5uQWYzZFhOOW85eXY5?=
 =?utf-8?B?dG5qNkRGRTB2YTdROWRYUHdMSk8waEhCNHRSZFp5ZGx1Z3c1TlhmVTZzMVln?=
 =?utf-8?B?RHR5RDZjRmFnVmhIYlVjU1d6UCtySG4yR0lOYTZsYjlXWjlXaFVWQmZsa0hM?=
 =?utf-8?B?amhad1B6VjVDMS9FdFF4QnlpakxwT2NDV1pwdlZJS3dtaGg5L2FCQ1k4bHBI?=
 =?utf-8?B?dTZ1Ky92SlFJQnJvd1pCajRYRkw0c25Da0lSOUlHNzkzOVhUR1pMUVRQZWhY?=
 =?utf-8?B?aWtBTXk2dFNLb2poNUhjNXcxeU01L0M1TWNuZ1c5aFl4ODVhTTlKcGdMZmgw?=
 =?utf-8?B?bDJkQStqOHJ4VG9tNnRYc2V0WWlDaXA3b3NnSldxZjlrODNUTEdpOUk4bFB6?=
 =?utf-8?B?elFuUG42K2xNUTFxUE5OZ3JIVU9OOUVRTitwSmltZ1duMVpSNWF2V1BsaDJn?=
 =?utf-8?B?ZllYdGpmTWZDYTBkckFCbkc1OHpqVVRCblJ2QUZCZUFQb2Q3em5XK3Q4b09m?=
 =?utf-8?B?WVRLN1FsemcyRTdxMlYwT3FVQ0ZBQ3lDaGtiZCsvTjFuNVR3Y0hIM1VDTS9X?=
 =?utf-8?B?emV2VHRoVkJQazArdlRHa2RLWi9QOUZ0dUZPYTJnYmVWcXFlUkxFTDQzdGJx?=
 =?utf-8?B?dk0xRzgwdkMvclAvQzZHOWpBd2N6a0RKVzJXWWF2cGtmcXRZWFdYc29FZnI3?=
 =?utf-8?B?SXhmMUhRS2ZXWTQwdWhSSzhuTHZxdmFKRWJ4RmI0N295MEJ2ajZnTERHSHF2?=
 =?utf-8?B?VG9rWmNVeDZwdFlPNDNnMnhyTXprWTJzZ3BremxwVDBvSTZWN0V6YkpLWmlB?=
 =?utf-8?B?UGJQZmNLR2Zka0EyYlNzbjZyQ0pkcjlTY0tKbFdiU3prTXlCelc2RDlUbFpT?=
 =?utf-8?B?UGtHVHlxWTE3bHNIL1FyR05pMEVOWFNYWkVJY2NzZjlNZWpUcnhXSVlKZVAz?=
 =?utf-8?B?MzhQK2F2YUprYUlUdnhhbzhIemhFa2QvMHlaWFpkSEFnOForb2JGU0VIb2Fl?=
 =?utf-8?B?TklUVWpFSEV3ZDZUT2J0N1JjN015RjQ2U1huMlI5MGZMOWxYTVdjZmRpUFYz?=
 =?utf-8?B?VldGNEVXbU5kS2RoaUUyd3lFcHdSL1pVTnlRbDNLUVNBVFFoOW83alJxQ2NY?=
 =?utf-8?B?N3NFUE16SXU0VEhjT0h6QS9NYjRQR0lXTU8reGdycXNMWk5yeUJxZHBERVVE?=
 =?utf-8?B?eTVUOGQ1YjY5Y01nYnlYcHJpL3BEYW9Ybit2K1FDbmx2OGpGTFhaMzlxbnpQ?=
 =?utf-8?B?WW4zckgzenJWRHZWOExSREVRdlVLVGRzZitxUndOL2ZZT0NUOG1OWjVqOGR6?=
 =?utf-8?B?SzlycXFLQS9vR2xNWkh6RTJFVWt1NDJ2L3VBbE10VnUxTzNxek5YTktNRFpi?=
 =?utf-8?B?QXhpcjB6QVNaTG1mckZKNDVMeVNlNzQwU1ByVHFCa2kwR0lxeXQ0MTlWUVEz?=
 =?utf-8?B?Z0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4180.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7a4d15-f9c0-4333-66a9-08dd2bdd0c57
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2025 09:57:35.0706 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uq4s2oXYhXgKDtnJT1vTFDhIvwXQy1muhUmrGWQhCOP9deI93ON2hDO9djZ1yNSl5P7jb1iOluR7Aiknk60+zrA6AZNFaj2QhIsMyVQJneg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5200
Received-SPF: pass client-ip=2a01:111:f403:c400::;
 envelope-from=steven_lee@aspeedtech.com;
 helo=HK2PR02CU002.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lk
cmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBGcmlkYXksIEphbnVhcnkgMywg
MjAyNSA1OjQ0IFBNDQo+IFRvOiBTdGV2ZW4gTGVlIDxzdGV2ZW5fbGVlQGFzcGVlZHRlY2guY29t
PjsgUGV0ZXIgTWF5ZGVsbA0KPiA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgVHJveSBMZWUg
PGxlZXRyb3lAZ21haWwuY29tPjsgSmFtaW4gTGluDQo+IDxqYW1pbl9saW5AYXNwZWVkdGVjaC5j
b20+OyBBbmRyZXcgSmVmZmVyeQ0KPiA8YW5kcmV3QGNvZGVjb25zdHJ1Y3QuY29tLmF1PjsgSm9l
bCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47IG9wZW4NCj4gbGlzdDpBU1BFRUQgQk1DcyA8cWVt
dS1hcm1Abm9uZ251Lm9yZz47IG9wZW4gbGlzdDpBbGwgcGF0Y2hlcyBDQyBoZXJlDQo+IDxxZW11
LWRldmVsQG5vbmdudS5vcmc+DQo+IENjOiBUcm95IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5j
b20+OyBZdW5saW4gVGFuZw0KPiA8eXVubGluLnRhbmdAYXNwZWVkdGVjaC5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggMi81XSBhc3BlZWQ6IGFzdDI3eDA6IE1hcCB1bmltcGxlbWVudGVkIGRl
dmljZXMgaW4gU29DDQo+IG1lbW9yeQ0KPiANCj4gT24gMS8zLzI1IDA5OjE0LCBTdGV2ZW4gTGVl
IHdyb3RlOg0KPiA+IEhpIEPDqWRyaWMsDQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gPj4gRnJvbTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0BrYW9kLm9yZz4NCj4gPj4g
U2VudDogRnJpZGF5LCBEZWNlbWJlciAyNywgMjAyNCA1OjUzIFBNDQo+ID4+IFRvOiBTdGV2ZW4g
TGVlIDxzdGV2ZW5fbGVlQGFzcGVlZHRlY2guY29tPjsgUGV0ZXIgTWF5ZGVsbA0KPiA+PiA8cGV0
ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgVHJveSBMZWUgPGxlZXRyb3lAZ21haWwuY29tPjsgSmFt
aW4gTGluDQo+ID4+IDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBBbmRyZXcgSmVmZmVyeQ0K
PiA+PiA8YW5kcmV3QGNvZGVjb25zdHJ1Y3QuY29tLmF1PjsgSm9lbCBTdGFubGV5IDxqb2VsQGpt
cy5pZC5hdT47IG9wZW4NCj4gPj4gbGlzdDpBU1BFRUQgQk1DcyA8cWVtdS1hcm1Abm9uZ251Lm9y
Zz47IG9wZW4gbGlzdDpBbGwgcGF0Y2hlcyBDQyBoZXJlDQo+ID4+IDxxZW11LWRldmVsQG5vbmdu
dS5vcmc+DQo+ID4+IENjOiBUcm95IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+OyBZdW5s
aW4gVGFuZw0KPiA+PiA8eXVubGluLnRhbmdAYXNwZWVkdGVjaC5jb20+DQo+ID4+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggMi81XSBhc3BlZWQ6IGFzdDI3eDA6IE1hcCB1bmltcGxlbWVudGVkIGRldmlj
ZXMNCj4gPj4gaW4gU29DIG1lbW9yeQ0KPiA+Pg0KPiA+PiBIZWxsbywNCj4gPj4NCj4gPj4gT24g
MTIvMjUvMjQgMDM6MDMsIFN0ZXZlbiBMZWUgd3JvdGU6DQo+ID4+PiBNYXBzIGZvbGxvd2luZyB1
bmltcGxlbWVudGVkIGRldmljZXMgaW4gU29DIG1lbW9yeQ0KPiA+Pj4gLSBkcG1jdQ0KPiA+Pj4g
LSBpb21lbTANCj4gPj4+IC0gaW9tZW0xDQo+ID4+PiAtIGx0cGkNCj4gPj4+IC0gaW8NCj4gPj4N
Cj4gPj4gQ291bGQgeW91IHBsZWFzZSBhZGQgYSBzZW50ZW5jZSBhYm91dCB3aGF0IHRoZXNlIGRl
dmljZXMgYXJlID8NCj4gPj4NCj4gPj4gVGhhbmtzLA0KPiA+Pg0KPiA+PiBDLg0KPiA+Pg0KPiA+
DQo+ID4gRFBNQ1Ugc3RhbmRzIGZvciBEaXNwbGF5IFBvcnQgTUNVIGNvbnRyb2xsZXIuDQo+ID4g
UmVnYXJkaW5nIExUUEksIHdoZW4gdGhlIEFTVDE3MDAgaXMgY29ubmVjdGVkIHRvIHRoZSBBU1Qy
NzAwLCBBU1QxMDcwDQo+IExUUEkgY29udHJvbGxlcidzIHJlZ2lzdGVycyBhcmUgbWFwcGVkIHRv
IDB4MzAwMDAwMDAuDQo+IA0KPiBJcyB0aGUgTFRQSSBJUCBhIGRldmljZSBmb3IgY29tbXVuaWNh
dGlvbiBiZXR3ZWVuIFNvQ3MgPw0KDQpZZXMsIGl0IGNhbiBiZSB1c2VkIHRvIGNvbm5lY3QgdG8g
QVNUMTcwMC4gQVNUMTcwMCBpcyBhbiBJL08gZXhwYW5kZXIgdGhhdCBzdXBwb3J0cyB0aGUgREMt
U0NNIDIuMSBMVFBJIHByb3RvY29sLiAgDQpJdCBwcm92aWRlcyBBU1QyNzAwIHdpdGggYWRkaXRp
b25hbCBHUElPLCBVQVJULCBJM0MsIGFuZCBvdGhlciBpbnRlcmZhY2VzLg0KDQpUaGFua3MsDQpT
dGV2ZW4NCg0KPiANCj4gPiBJbywgSW9tZW0wIGFuZCBJb21lbTEgaW5jbHVkZSB1bmltcGxlbWVu
dGVkIGNvbnRyb2xsZXJzIGluIHRoZSBtZW1vcnkNCj4gcmFuZ2VzIDB4MTIwMDAwMDAwIC0gMHgx
MjEwMDAwMDAgYW5kIDB4MTQwMDAwMDAgLSAweDE0MTAwMDAwMC4NCj4gPiBGb3IgaW5zdGFuY2U6
DQo+ID4gLSBVU0IgaHViIGF0IDB4MTIwMTAwMDANCj4gPiAtIGVTUEkgYXQgMHgxNEM1MDAwDQo+
ID4gLSBQV00gYXQgMHgxNDBDMDAwMA0KPiA+DQo+ID4gSSB3aWxsIGluY2x1ZGUgdGhlIGRlc2Ny
aXB0aW9uIGluIHRoZSBjb21taXQgbWVzc2FnZS4NCj4gDQo+IHllcyBwbGVhc2UuDQo+IA0KPiBU
aGFua3MsDQo+IA0KPiBDLg0KPiANCj4gDQoNCg==

