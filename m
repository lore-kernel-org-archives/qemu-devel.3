Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CA9CD98F2
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 13:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc1XX-0002F7-Sn; Tue, 23 Jun 2026 09:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jos.craaijo@ou.nl>) id 1wc195-0006po-SM
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 09:26:31 -0400
Resent-Date: Tue, 23 Jun 2026 09:26:31 -0400
Resent-Message-Id: <E1wc195-0006po-SM@lists1p.gnu.org>
Received: from mail-westeuropeazon11011061.outbound.protection.outlook.com
 ([52.101.70.61] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jos.craaijo@ou.nl>) id 1wc193-0003ya-Eq
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 09:26:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7AkOfHbLoK6pX35TpIGGlrLkm+TM2/TAoG0cViKLyLmD1Jdujcd/uwQRzxLG5K4OUc/fIl7yYt9ffW+PFo5dN6tS5z47EShkPMMxC/rP2Y0+WTHdoaz0Pl0IFKi4CyQVs7r+nob+DMyWWoXx0gGgwePb7e+aUW/jYNUOcu2n4PlS/ux2gToJTi7m8/EhQ15eeV6FL5Ea+UQt5VruLV2FGyy9spySQf+TPOU7cfnv5ShzYlFL+zxAtvCxDWFSGNz2dXhIOOxkBIhIfJArW76+DVnZi19uqgY2EGQlj58GGQQImRCAa7vKwkp/R0X8oS/u2Ks/ETsAVUB6Pk0IAoCXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2X7IjQNLEm+5lxJf3NNJcKCmQtEBLvV80NNEs1pqdw=;
 b=sSAyE1H0QD5yv1ohFCZoCYY/r08L/bBFTrwKlFZfhL/eycSzIYj9q27Q66xBcctejs0DTXBpj1zUtb6gz9jsRaEuLOitX0yOdibHKIBEPO6iU58boA5S51kNTengB9I209JbqDRK7ZKM/I3AqOpzwEVaNNNjpW2DScFEEACQBYrN4HHqssLkA3sMXzaOlnMyeUE54+Hm6Cgw7ie14SFJh05FmkXHmJ1FhgiuL4YtcZB+kN55SI/nUhJSYnDrJjC8q2tbPP1h4R7QAepP0xAd/NjeskQTYJ1rQhUIC5mdOdLYV40w+twZ+/fO/ZspUDUplPuWKwxpfvVwOe5t+yPI8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ou.nl; dmarc=pass action=none header.from=ou.nl; dkim=pass
 header.d=ou.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ou.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2X7IjQNLEm+5lxJf3NNJcKCmQtEBLvV80NNEs1pqdw=;
 b=roIlfBu4/KgCrhrgsQTqzXzhLCyTlWfwJANAkR2g4HwsJ7AmMvqotxCpVk6Iy08H2EJUg8PYCShTHbZOkAgC+bxgxMFJhRFTptJl4sUjiDYZs6kAy5Rzu/h09tKi/gy+x4NG3x5Q6/7Qxaxxh/Khv3N18hMiN+/lAOwQaCCvwrmnnnJR5xVWQ6nZ78A0PLXDJyadM8SvlhzU57C2cG+fI/oMkZuR8b0GaBhnce1xL5Cj/j2OrnTJEIlSPYr/4TIxiJ1LWZXUaLo//TSCZs29Rm8a2KxxSAB1FHqNPNOg51AUWQai6YgYR7aYAcqzXjdSKMZo+m01X6sdlDReQ5FyEQ==
Received: from AM9P191MB1411.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:272::24)
 by GVXP191MB2634.EURP191.PROD.OUTLOOK.COM (2603:10a6:150:1e6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.7; Tue, 23 Jun
 2026 13:21:22 +0000
Received: from AM9P191MB1411.EURP191.PROD.OUTLOOK.COM
 ([fe80::d5ab:52fc:cebb:5530]) by AM9P191MB1411.EURP191.PROD.OUTLOOK.COM
 ([fe80::d5ab:52fc:cebb:5530%6]) with mapi id 15.21.0159.012; Tue, 23 Jun 2026
 13:21:22 +0000
From: "Craaijo, Jos" <jos.craaijo@ou.nl>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 "Craaijo, Jos" <jos.craaijo@ou.nl>
Subject: [PATCH] target/i386: fix long mode segment override prefix decoding
Thread-Topic: [PATCH] target/i386: fix long mode segment override prefix
 decoding
Thread-Index: AQHdAxMvqT5KDQYJFEO17tX6blFTTw==
Date: Tue, 23 Jun 2026 13:21:22 +0000
Message-ID: <20260623-fix-x86-long-mode-segment-override-decoding-v1-1-26d9d4b5804e@ou.nl>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Resent-From: Jos Craaijo <jos.craaijo@ou.nl>
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ou.nl;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9P191MB1411:EE_|GVXP191MB2634:EE_
x-ms-office365-filtering-correlation-id: 42ca7f4d-397f-4775-427a-08ded12a51fc
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|19092799006|786006|366016|23010399003|11063799006|13003099007|18002099003|38070700021|55112099003|3023799007|56012099006;
x-microsoft-antispam-message-info: /nG7ETbI+FxcH39Mpgbgi6hMFx+Kye8A/bamMmJX3Y3hZDIas2TALzIh2/taK09dpixY+km2PoIN2ol5RMcuOiMJ5UZtCpmrORQvGZRmLkCvA0sJZIlPzGeqw/qDYPJMa1+UF7ovAbCKvZxD3sFPvkZbVE6BE2J7k3O0qTa8L3t2Ff6j5wWjgTTZ9X5e/R8llhIuexMSez5KNUfeg52WMh3peBKd0lTlEQYemDBm011jApr1qUzUoT4V6ZhXjwZo5o3ICtwOxZR9YFZoT+ctiPoSUzayte0Fd+DZ8cBkKWSaEYZakigj1UJhZ5y5GSo2M85PPgnVg0jp0hxnsfq/aEG+NiQhi3heXF97YjyVUvuWJIrtq087qlsdXk+1n8FMNtspPV+pf2wMSXAxiUqdK+m24XNhEI5RUgMQ0F64lF0wtmpDV2dht04ll5E9CluHtN2xM6b9Aj3xavdBqx/rXzB6x+exlucUpianjuXgCtN5GT2rCuGUipc7NV//Gm8d9dy96yw432UzlwgvHbUBTKxuYHsFJ0Bb62qN6BZbtkWW9kPQYqiMucZr+uE9EkqMUGI24g78FkQyXgchQFipZ4utZoSxkw9fBeTzHQfohd5jLu4/pB2UlKMhFBF6PXFsyxsHNQXQYqACAt8R4A4pqvp42DShtdVQOruriK6ggsRkiCJ9buzTwX8ji2CPJg+VpuTcF6z3aPu3GdPlyigVaKm8PtXmf6SOLz5XTIh4oTQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9P191MB1411.EURP191.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(19092799006)(786006)(366016)(23010399003)(11063799006)(13003099007)(18002099003)(38070700021)(55112099003)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTZTWWlDNVJnM0dIcWJBZVBmMTFZVGdYZ1VZWDUwRVZ0S0E3Z1BNaGZhL1dC?=
 =?utf-8?B?WHVsN1ZualVlRGRKbGlNcjQzeE5HcmNSa3FKNlVVS2s2TXREL096NmpmY1Rl?=
 =?utf-8?B?NzE3dmNhQ3NWU3VYcU00UUsxY1Z1TlhzeW5qMU5jTStsOE9lUjQ0aFdYVG92?=
 =?utf-8?B?TmlLb3lzSEZZajJ2Y1FsaTJDc0NsdWVvTTlSSldGcU5CZnpTQm1wZDI3N2R2?=
 =?utf-8?B?TUVxU2JXRDRwaVQzYlFNZHRnSit3eERUaE4yNmg2b0sveHEwd0dyMHgvZGNo?=
 =?utf-8?B?a05ScWlXaGVkcDdpVmZLWDU3bmFjSHl0dW5JTTVZbjFSL09TNHBUUW1ZY0xj?=
 =?utf-8?B?MXM5NGs1T2RsUFdNK1JvZytPZW9rYXprOWRNQkpVYzNlbEtDS2E5WVRJQjAr?=
 =?utf-8?B?RExCZ3p5QzhJWE9QOWFXSFYxU3p2bXd6QzR5cFJLeHY2YzhaV2R6VjdLQzNK?=
 =?utf-8?B?dGlGZEpMS3ZCL3Y4VFErR0poKy8vMXB4QWVTNXdlenVEUFc2RWduVjVWZ2Zy?=
 =?utf-8?B?K3hRS3kyek9qdkVRQU9xWFlTMC9VTTk4WWZIa1V4UlErM0VNZXh1RHZsMFNp?=
 =?utf-8?B?cjRQK0N5VktDUlhPWkhsc3oySHJHanlEejhpRG01NHZuTkNEZ01KdnB2Wno2?=
 =?utf-8?B?emJQSTQ4dXlxbThUVWRHaWhQMG9NbHdiVndVRjdINEtkeEk5aEt4Kzd5aXZh?=
 =?utf-8?B?U1FldXBnQ0drcmtPekx5dkJHaWdBdHkrQysvMU5SZDMvZTFzWlFEaHFJNkli?=
 =?utf-8?B?L2o1blZzSVAvOWJOR1IzNGVyUDMyRU16UGlhUXBEem42RnpoWlNJSWMvS3dH?=
 =?utf-8?B?NmpUZVI0OEFNZEg2L3R6aXRUUHRXZWZLSUJsbE1nbWgwN0VZQVNPMFpidVNi?=
 =?utf-8?B?Mms5bVBTNzRJNkxuOS9yajVWWDBVSUtFWUM3ZlU5alFqckNNWlVmbitkOEhF?=
 =?utf-8?B?Zy9NWVdQTWwvK05tZ01BazQwdnhROHR1VFVRRFVTQWN3ZG8vd2RUWHExRElh?=
 =?utf-8?B?eHFFNVhBT1FrS3VUa0ZtWlVkNlFKeUpzZ2RjcG9Wc0V2dGhTL0kyY2VuMEVP?=
 =?utf-8?B?aU92aGZidWsrRnFOanFRZ0FSRzlXbmkwUG1adWxDb1dNMjRjNHZnLzRLNC9h?=
 =?utf-8?B?Ris2dHhINEMrRnZjdkRkUnZMWkxuOEhESnEwUFI0TDk2cDEvaUd6QXJiT2F0?=
 =?utf-8?B?cy9YeHNYSzVFdGoyQVlDVmlQdzR2emFrT3U2TG01a2grZ1RqM2lsbWphbDFy?=
 =?utf-8?B?a2ppQ0V5VER6UDg0cEU4OEEwZllHa2thTlhnTXBQMDZMK3V5bjkwQzFKanJ0?=
 =?utf-8?B?enExclZsYnJUV3JoZU9sZGVEZUlGbldYN01aS3Y3Y3ZxUXVseGUxWUtIR0ti?=
 =?utf-8?B?MmxqbW8ybzlHMzBiUmdvTllpcXNXMkM5bTZEL3FIQ3Jkc1luOGQrSWFxVStZ?=
 =?utf-8?B?K2RuSXlhM01NbVhiQ3ptcjhVVCt2ZXA2NnJPbTc4UEU1TkJ1cHZQUENzRWht?=
 =?utf-8?B?cHZEN3VIeUh5STVOWGZDd1h4OUc4by9Tdllzc29uTWlMU1Ayd25CVTRUT29X?=
 =?utf-8?B?enhBUEFxV09hYjN0VWkzb3VrZ0FzVDc4cjJmWUZ5aEVyWXV4RzhNR3ZiTTVh?=
 =?utf-8?B?MHNBK0hJeEd0Tyt2b1lHeHRUMWwwTVhGQm1hR0ZGY1VrQ1J3akczUGxtOHZy?=
 =?utf-8?B?YWZQaXVmZXVHWDI5d0gwaGpMQm1EWlM0OG9QS2lWSnZ4Mmc0UGxMeVJNZGxF?=
 =?utf-8?B?N0lucDJHbCtXTjB1emhwWEVPN1E4c09GbExrOEcxc0NKT215dURVNEU2Q3V4?=
 =?utf-8?B?VUZpcDNLNUZUeFRmZXQreDlXaVhqQUdIRnBSak9HWDF4aVR2ZnNQSFVSKzhX?=
 =?utf-8?B?MFpLM1dqSGRzZTF6YnQwcmpzRmF3SCtKZGRPN0RCYkptcXphSXRtTGVPd0VN?=
 =?utf-8?B?SDNVSk9ldk9RaUZua0w4eFhwMGUvMTNZYWdMM2k2djIrTG85amlYeDVyU004?=
 =?utf-8?B?ZEZsU2RpMUJmVkVWS2xMK1hCaCtEY0d1QUV6M2VRRXJWcVVkY2V4djVqYU9x?=
 =?utf-8?B?V3JnVUlBR0NOOGZkNUxMQjJrUGVZRktvNjlMWFBKNTN5amtHMitZT1U2TGxr?=
 =?utf-8?B?bnNxVU5NT3UxM0MzTFdreVNzMWV3cnduaDc3clE4R0NQRlVnaXNaelZjNHUx?=
 =?utf-8?B?bHJIODZnR2xXOHlHcWcyKzVBekhHTHBLRnpwTnRBaXRSUWlaa3kzWVJTYVgr?=
 =?utf-8?B?cXFabTJ3VmJwa0dVS2F5aElsRWdDWHU1d3ZPUld2Q2pEN3doZ01kMWQ5RXdN?=
 =?utf-8?Q?yQQHif6MPvQ/Wpo+x3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFCF0B57DC26304BA2B6F40309B41141@EURP191.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ou.nl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P191MB1411.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ca7f4d-397f-4775-427a-08ded12a51fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2026 13:21:22.7283 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ce1e7f7-b0dd-4fd9-af45-52f0be792ee8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RFtUIX5Pb34yIeyiLkjAmAXfiXOrzMjXsfzG8D90szNOD2akF8OEeaEKLu+XYwGw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP191MB2634
Received-SPF: pass client-ip=52.101.70.61; envelope-from=jos.craaijo@ou.nl;
 helo=AS8PR04CU009.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 23 Jun 2026 09:51:47 -0400
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

T24geDg2LCB0aGUgRVMvQ1MvU1MvRFMgc2VnbWVudCBvdmVycmlkZSBwcmVmaXhlcyBhcmUgbnVs
bCBwcmVmaXhlcyBpbgpsb25nIG1vZGUsIGFuZCBzaG91bGQgYmUgaWdub3JlZC4gKEFNRCBBUE0g
Vm9sdW1lIDMsIFNlY3Rpb24gMS4yLjQpCgpUaGlzIHBhdGNoIGZpeGVzIHRoZSBwcmVmaXggZGVj
b2RpbmcgdG8gY29ycmVjdGx5IGlnbm9yZSB0aGUgcHJlZml4ZXMgaW4KNjQtYml0IG1vZGUuCgpS
ZXNvbHZlczogaHR0cHM6Ly9naXRsYWIuY29tL3FlbXUtcHJvamVjdC9xZW11Ly0vd29ya19pdGVt
cy8zMzkxClNpZ25lZC1vZmYtYnk6IEpvcyBDcmFhaWpvIDxqb3MuY3JhYWlqb0BvdS5ubD4KLS0t
CiB0YXJnZXQvaTM4Ni9lbXVsYXRlL3g4Nl9kZWNvZGUuYyAgICB8ICA2ICsrKysrKwogdGFyZ2V0
L2kzODYvdGNnL2RlY29kZS1uZXcuYy5pbmMgICAgfCAxNiArKysrKysrKysrKystLS0tCiB0ZXN0
cy90Y2cveDg2XzY0L01ha2VmaWxlLnRhcmdldCAgICB8ICAxICsKIHRlc3RzL3RjZy94ODZfNjQv
c2VnbWVudC1wcmVmaXhlcy5jIHwgMjUgKysrKysrKysrKysrKysrKysrKysrKysrKwogNCBmaWxl
cyBjaGFuZ2VkLCA0NCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L3RhcmdldC9pMzg2L2VtdWxhdGUveDg2X2RlY29kZS5jIGIvdGFyZ2V0L2kzODYvZW11bGF0ZS94
ODZfZGVjb2RlLmMKaW5kZXggYmFlMWRkNGQ2Zi4uMzRkY2FjMTU1YSAxMDA2NDQKLS0tIGEvdGFy
Z2V0L2kzODYvZW11bGF0ZS94ODZfZGVjb2RlLmMKKysrIGIvdGFyZ2V0L2kzODYvZW11bGF0ZS94
ODZfZGVjb2RlLmMKQEAgLTE4NTEsNiArMTg1MSwxMiBAQCBzdGF0aWMgdm9pZCBkZWNvZGVfcHJl
Zml4KENQVVg4NlN0YXRlICplbnYsIHN0cnVjdCB4ODZfZGVjb2RlICpkZWNvZGUpCiAgICAgICAg
IGNhc2UgUFJFRklYX1NTX1NFR19PVkVSUklERToKICAgICAgICAgY2FzZSBQUkVGSVhfRFNfU0VH
X09WRVJSSURFOgogICAgICAgICBjYXNlIFBSRUZJWF9FU19TRUdfT1ZFUlJJREU6CisgICAgICAg
ICAgICBpZiAoeDg2X2lzX2xvbmdfbW9kZShlbnZfY3B1KGVudikpKSB7CisgICAgICAgICAgICAg
ICAgLyogRVMvQ1MvU1MvRFMgc2VnbWVudCBvdmVycmlkZXMgYXJlIGlnbm9yZWQgaW4gbG9uZyBt
b2RlICovCisgICAgICAgICAgICAgICAgZGVjb2RlLT5yZXgucmV4ID0gMDsKKyAgICAgICAgICAg
ICAgICBicmVhazsKKyAgICAgICAgICAgIH0KKyAgICAgICAgICAgIC8qIGZhbGwgdGhyb3VnaCB3
aGVuIG5vdCBpbiBsb25nIG1vZGUgKi8KICAgICAgICAgY2FzZSBQUkVGSVhfRlNfU0VHX09WRVJS
SURFOgogICAgICAgICBjYXNlIFBSRUZJWF9HU19TRUdfT1ZFUlJJREU6CiAgICAgICAgICAgICBk
ZWNvZGUtPnNlZ21lbnRfb3ZlcnJpZGUgPSBieXRlOwpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2kzODYv
dGNnL2RlY29kZS1uZXcuYy5pbmMgYi90YXJnZXQvaTM4Ni90Y2cvZGVjb2RlLW5ldy5jLmluYwpp
bmRleCBhYzE4MTMwOGNhLi42NGFhYjViNWQzIDEwMDY0NAotLS0gYS90YXJnZXQvaTM4Ni90Y2cv
ZGVjb2RlLW5ldy5jLmluYworKysgYi90YXJnZXQvaTM4Ni90Y2cvZGVjb2RlLW5ldy5jLmluYwpA
QCAtMjgwNiwxNiArMjgwNiwyNCBAQCBzdGF0aWMgdm9pZCBkaXNhc19pbnNuKERpc2FzQ29udGV4
dCAqcywgQ1BVU3RhdGUgKmNwdSkKICAgICAgICAgcy0+cHJlZml4IHw9IFBSRUZJWF9MT0NLOwog
ICAgICAgICBnb3RvIG5leHRfYnl0ZTsKICAgICBjYXNlIDB4MmU6Ci0gICAgICAgIHMtPm92ZXJy
aWRlID0gUl9DUzsKKyAgICAgICAgaWYgKCFDT0RFNjQocykpIHsKKyAgICAgICAgICAgIHMtPm92
ZXJyaWRlID0gUl9DUzsKKyAgICAgICAgfQogICAgICAgICBnb3RvIG5leHRfYnl0ZTsKICAgICBj
YXNlIDB4MzY6Ci0gICAgICAgIHMtPm92ZXJyaWRlID0gUl9TUzsKKyAgICAgICAgaWYgKCFDT0RF
NjQocykpIHsKKyAgICAgICAgICAgIHMtPm92ZXJyaWRlID0gUl9TUzsKKyAgICAgICAgfQogICAg
ICAgICBnb3RvIG5leHRfYnl0ZTsKICAgICBjYXNlIDB4M2U6Ci0gICAgICAgIHMtPm92ZXJyaWRl
ID0gUl9EUzsKKyAgICAgICAgaWYgKCFDT0RFNjQocykpIHsKKyAgICAgICAgICAgIHMtPm92ZXJy
aWRlID0gUl9EUzsKKyAgICAgICAgfQogICAgICAgICBnb3RvIG5leHRfYnl0ZTsKICAgICBjYXNl
IDB4MjY6Ci0gICAgICAgIHMtPm92ZXJyaWRlID0gUl9FUzsKKyAgICAgICAgaWYgKCFDT0RFNjQo
cykpIHsKKyAgICAgICAgICAgIHMtPm92ZXJyaWRlID0gUl9FUzsKKyAgICAgICAgfQogICAgICAg
ICBnb3RvIG5leHRfYnl0ZTsKICAgICBjYXNlIDB4NjQ6CiAgICAgICAgIHMtPm92ZXJyaWRlID0g
Ul9GUzsKZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy94ODZfNjQvTWFrZWZpbGUudGFyZ2V0IGIvdGVz
dHMvdGNnL3g4Nl82NC9NYWtlZmlsZS50YXJnZXQKaW5kZXggYmUyMGZjNjRlOC4uYzQ4NzY3ZmVm
OCAxMDA2NDQKLS0tIGEvdGVzdHMvdGNnL3g4Nl82NC9NYWtlZmlsZS50YXJnZXQKKysrIGIvdGVz
dHMvdGNnL3g4Nl82NC9NYWtlZmlsZS50YXJnZXQKQEAgLTE1LDYgKzE1LDcgQEAgWDg2XzY0X1RF
U1RTICs9IHZzeXNjYWxsCiBYODZfNjRfVEVTVFMgKz0gbm9leGVjCiBYODZfNjRfVEVTVFMgKz0g
Y21weGNoZwogWDg2XzY0X1RFU1RTICs9IGFkb3gKK1g4Nl82NF9URVNUUyArPSBzZWdtZW50LXBy
ZWZpeGVzCiBYODZfNjRfVEVTVFMgKz0gdGVzdC0xNjQ4CiBYODZfNjRfVEVTVFMgKz0gdGVzdC0y
MTc1CiBYODZfNjRfVEVTVFMgKz0gY3Jvc3MtbW9kaWZ5aW5nLWNvZGUKZGlmZiAtLWdpdCBhL3Rl
c3RzL3RjZy94ODZfNjQvc2VnbWVudC1wcmVmaXhlcy5jIGIvdGVzdHMvdGNnL3g4Nl82NC9zZWdt
ZW50LXByZWZpeGVzLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMC4uYTdl
NmUyODViMgotLS0gL2Rldi9udWxsCisrKyBiL3Rlc3RzL3RjZy94ODZfNjQvc2VnbWVudC1wcmVm
aXhlcy5jCkBAIC0wLDAgKzEsMjUgQEAKKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwt
Mi4wLW9yLWxhdGVyICovCisvKiBTZWUgaHR0cHM6Ly9naXRsYWIuY29tL3FlbXUtcHJvamVjdC9x
ZW11Ly0vd29ya19pdGVtcy8zMzkxICovCisKK2ludCBtYWluKCkKK3sKKyAgICBpbnQgZGF0YSA9
IDA7CisKKyAgICAvKiBFbnN1cmUgdGhhdCBpZ25vcmVkIHNlZ21lbnQgb3ZlcnJpZGUgcHJlZml4
ZXMgYXJlIGFjdHVhbGx5IGlnbm9yZWQgKi8KKyAgICBhc20gdm9sYXRpbGUgKAorICAgICAgICAi
d3Jnc2Jhc2UgJTBcblx0IgorICAgICAgICAiLmJ5dGUgMHg2NSwgMHgyNlxuXHQiIC8qIHByZWZp
eGVzOiBHUyArIEVTICovCisgICAgICAgICJtb3ZiICQwLCAwXG5cdCIKKyAgICAgICAgIi5ieXRl
IDB4NjUsIDB4MkVcblx0IiAvKiBwcmVmaXhlczogR1MgKyBDUyAqLworICAgICAgICAibW92YiAk
MCwgMFxuXHQiCisgICAgICAgICIuYnl0ZSAweDY1LCAweDM2XG5cdCIgLyogcHJlZml4ZXM6IEdT
ICsgU1MgKi8KKyAgICAgICAgIm1vdmIgJDAsIDBcblx0IgorICAgICAgICAiLmJ5dGUgMHg2NSwg
MHgzRVxuXHQiIC8qIHByZWZpeGVzOiBHUyArIERTICovCisgICAgICAgICJtb3ZiICQwLCAwXG5c
dCIKKyAgICAgICAgOgorICAgICAgICA6ICJyIiAoJmRhdGEpCisgICAgICAgIDogIm1lbW9yeSIK
KyAgICApOworCisgICAgcmV0dXJuIDA7Cit9CgotLS0KYmFzZS1jb21taXQ6IGI4MzM3MTY2ODE5
MmE3MDViODc4ZTkwOWM1YWU5YzEyMzNjYmQ1ZmIKY2hhbmdlLWlkOiAyMDI2MDYyMy1maXgteDg2
LWxvbmctbW9kZS1zZWdtZW50LW92ZXJyaWRlLWRlY29kaW5nLWU4YjI1MDQ0M2Y5ZAoKQmVzdCBy
ZWdhcmRzLAotLSAKSm9zIENyYWFpam8gPGpvcy5jcmFhaWpvQG91Lm5sPgoK

