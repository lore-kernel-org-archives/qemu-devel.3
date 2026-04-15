Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC496F9D0FD
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 00:54:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCoWI-0008DB-A5; Tue, 14 Apr 2026 20:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wCoWG-0008CR-DI; Tue, 14 Apr 2026 20:54:16 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wCoWE-0007oK-Vf; Tue, 14 Apr 2026 20:54:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sMrgxx3Sou4hYSKHWPBxvr1PJbgbEP6RrhfH2HYqTVt8mCL/ltq/w53l7NRd55QG1pkt6ZYeeGc91utCk4OjNLILoWXQFZJMK3/bNnlpDf26Q9fI7zJJhkCR72O/Mu9MU4UWZpqEFZXeh9D1GluVCFpy/5oRX2jeZxdrKQeGYrIGGEGoK7KQus7ZRCoBMTuFptqoQbhhfiFkONPW8EPIcDbHVz+KiDEqBEl3eTfawhVgkUNGM79pUHyWKkWcqQZ+rgUGqdOZwXgpS0j4o+I8+NfDGKlZ8o3pLifvgAS3VNpP6GlivP+i3ociGhtO+vINUvQgtyy2lN/lSczx9HKhCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eT6iXaQc3RMthVr2sw0305P3eeirgYve/gKbMKpQ+Ko=;
 b=lxj3PTB0eKI4f+nXu82A0MOf3G+2wj8n0qdN0vpcqBmWHQHjcpHmQpdkXKPqfYXIN/Xmhbkpdm3A1kGoJGt0a2BimKme+DqerNMeO1SK9UAzXLIB2wKzcKmx4X4G0OLWEuL/P4ZhDjmHilHlGqNc5oTZZoGznQbzMmNnKT5xFZ/N84fwQ8dP9NR1GAWl9dpB989zGHwQznpIXIkvwSIcoBuLTKIP5aDMkfiSPbMCgtOXvLVRVlK3pRwx6+IoSnUIAzVBJBSiB/r9OS5rrwqGY/TfU3d0o2Z+yIvAITsbHxu4iaBeTUPrA1La3KROx+M/1zsjt8qzgQMVzPdYxA+sUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eT6iXaQc3RMthVr2sw0305P3eeirgYve/gKbMKpQ+Ko=;
 b=OvQqnA4Pk/SL3Nh8y3tFAB7ia1zSJn8IkrXUpDs0Ir71AI/QKXZE0iPysE3GX6oLUBMLtvu1ABxcv7KJqhXvsmA2MEnLN3TdPBZt78+SMWbbfinJ3qr6mbhMnOkMYD3mou3TegNErzQfmn578mo8vuSM9/9nerp7lfMKwJDg4120fvRXJ1xLvsCjjUpYJzND0cfkaj+xMoPBoq6i671qcSRvc8LDVDbLuqtPaH36O5T3m2NWXiIoheR+Y/7bopr8NplsIuSNHYz6o2daTHLUzbHNYs6ZgisgIjYOXlZ8MKkO7A4e7zHHub3i0S+8SGl6DNKj5JXlW1xaGdFyOlz60g==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TY0PR06MB5578.apcprd06.prod.outlook.com (2603:1096:400:328::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 00:54:08 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 00:54:08 +0000
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
Subject: RE: [PATCH v2 06/17] hw/usb/hcd-ehci: Change descriptor addresses to
 64-bit
Thread-Topic: [PATCH v2 06/17] hw/usb/hcd-ehci: Change descriptor addresses to
 64-bit
Thread-Index: AQHcy+TF38PfbBLNdk+9bahbf3ZsMbXeSLYAgAEDmxA=
Date: Wed, 15 Apr 2026 00:54:08 +0000
Message-ID: <TYPPR06MB820645B6F63582C2FC44F7BEFC222@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260414080025.3005916-1-jamin_lin@aspeedtech.com>
 <20260414080025.3005916-7-jamin_lin@aspeedtech.com>
 <7eb32749-dd83-48ea-94a4-41935cc90aca@linaro.org>
In-Reply-To: <7eb32749-dd83-48ea-94a4-41935cc90aca@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TY0PR06MB5578:EE_
x-ms-office365-filtering-correlation-id: 03025f96-9133-4185-c7b0-08de9a898006
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|921020|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: H0XIlrdM3uVn7e/+qSpE9PuE4osbcLeCn+JABvijSfxJbkNG1O7yV+zxii1cdazeA0wVUpC8bAXWe/8ZqazrUS96NmHEi1JYz4+rUliiY7NvU4LFGP2UcxiIFsWahrxpj7QfpvoJCZ78TchKy4gYR3Y1YxI7vNDroIc52M9eP1olV4hE5K+Sm6qX5GKwQwmo9UpFiPeRvcBb/LWRQaOzw9aH7oEy9iMLRQ3z5O9gCU/n64I4I6gBUIct40CV7KRwcqo31Pj6jIJ0qzwgymHAbpskHc8HIFaFNE7OIIOYiyl/wRQ955VvOB0KzxIsWrTe2hQkzvw2jF8O+twJ9sJY0c526eyiefOC2pkZ46mBdID4w1Tgb4XNz4kKCXNeA/rskiFZhtzvTjCck0OEQffzjbAMBCHn2SnPxEx0/se/bgyMTsYUH1MM8Ji5IJAoA1A60udF1JMHIKhXnuEoBW1+B2skTcYTbeEohod5m+RcKW1AuuSxLFK23dZED4OEPRth9nDpS/VyuhxYNiBodEVNiHwvXF0T5zX47eG5vb+oFK8vmYqGgw781QFpnx+KmKyZh4T2u7EGrROiKJtaU/4yJ5R3dq1mKQ2sBuHyI82vK3m7W1c6z4DgJWv9bC+O34KEyYKjszCSCg+KwqCgswPO9PmoAeSgrWtnbIwtpOYlfPDX4RyBFGTZmDjQF98BQAcCNe2F1TPko4LeZknDposyJ396pdHjlZjIYZKgODCzGkb2YYdZIUc/clpYk9iSOp9ieC91pHn6BTZ90P9/3s9EeNr9F/aJ2bR37eA7mXPkkk7oWLYQ3WNWlO2wKsjHzeV8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUo2OGg1WnQxSGRQdUQ3R0RRUVlUa2VEQnNzSnhjclNjdHN3QmFXbTh4RStm?=
 =?utf-8?B?eTVRblk0bGRYc3phT2FQUllHeHE2bWk4Qm52ZkFUOEx5dGNLSDkzcG9JM0I2?=
 =?utf-8?B?SWswTmo5UEJTMjI1WWtIWWxlUC9kRUU4dzNMTzIrZmJ4QmVFSVBSZzNtb2cv?=
 =?utf-8?B?UFBDUnQ0K1IyQW5KNUxPY0FVWlU1ZFJNaWltZjZjMktKdGx4dzZya3JPRDBn?=
 =?utf-8?B?QU5hTFZQNTFVRFNLRVdoNk5BNStndVZ1KzVFeU9hc041Tis4bk9WbDEyYUhI?=
 =?utf-8?B?NDNEYU1xbFlJdit2bkY2Tll6YWVnV3Ztd0s0dE5RM0s1c2RjZDFsa3RKazNn?=
 =?utf-8?B?eDU0ZkhUSDVhUUNtMXRFSDlycE1Rak1aQlRuTFdxN0puQ0xGUEdvTGwvRml2?=
 =?utf-8?B?TjNQdnBJRlQ5c3FXM0kwRHptaVR5ektGaHJTblg3YnZwZjcvRGM5OVJrbFBX?=
 =?utf-8?B?RHkrQVViTlFGY1Y0aGRIWmh1THh4WVZlZStuZHFobGwvQk1XVGFlZkJYTmMw?=
 =?utf-8?B?b0pSYWprZzJDbXhaVThFN1VTK1A5NWxCWDZjTDdxSTNHMVZXKzJDR0kxSGoy?=
 =?utf-8?B?TnpGZXVaNE0yZ3g3dWdLanFHcUR6dkZxbzV4ZTZTSi9RUVRMRUNsaUozUnB2?=
 =?utf-8?B?cGVnaGs3MGVLUzFBYVhLTGp5YjVlWXc5WWxoREVDUkZDdjd1UGZlNGY0Z3B1?=
 =?utf-8?B?NkxMdldUNFk4MVpDaVp4Rm4wQ0h2TDFZMWhSZDgwRzNwSlBweEpTYys1RE9D?=
 =?utf-8?B?Z29xamVxL2tQVUlWVjNLS08zenNRMEM3MkR6Ty9xRTE0QUFheTM4SjlYQ3R0?=
 =?utf-8?B?WkYzSzlEcUhJNHczZ29yVzZ4Vk9iS0RVMnd0TUNteG5kWkVKRHdrVFFJK0JK?=
 =?utf-8?B?L2kweGlCblRqakEyVWZXZUNHdk1qclJleEhHVWhyOHBZekZ0OUdudXUwMHZC?=
 =?utf-8?B?cU14V3lRa2U4WUhLTzJSNVd0RmJvSjNwbWFLdEgwRE9acTNMa3k4Q2VDQ0Uy?=
 =?utf-8?B?bmJSWVpESC9HVkxwUStzejNMZnllSk1oVncxUnFRQWlyTGdvdnRSREtBeWw3?=
 =?utf-8?B?ZzhzTEJzSCtZWjFuY2xVMFZMZGxQQkYrczJrNkNNUFdhMVNmSHpIeTFsV2Nw?=
 =?utf-8?B?dXJ6Z0R4YnpvOUxmUkpWQytVWFpRbGUrd3VtWFdsYXNmQmplV2QxTFVnaHgr?=
 =?utf-8?B?dTVveTliOExKV0p3ZWdUV3hFa2cxbTZpV1MrWGpmVzc5QVRzR2piRm9TMlZJ?=
 =?utf-8?B?RVJKL0VqK2taZHpjcmVsY3hGTUlzZUR1QVZqU2RKN08wSHQxZkt1Z29HamYr?=
 =?utf-8?B?bE9obEFTbkV3WjVMWDVub2xxa3I1QnoxRGJaanhQOG5LZllZVzE2MzY4Vlpv?=
 =?utf-8?B?MWVOUkRrVHhlNFNVY3ZmcWVGU1BCYUdlcXB1aklTSzhTeGdRbFF4bmVxNHhB?=
 =?utf-8?B?WUdESTNqSlpYY3lpUStoRmZSYlEwSWorVFQ1V090cXNyNFlBbEdSNk9DbjBi?=
 =?utf-8?B?QkNZUkRHQitpbEtPdHZtUGpFanZER1Vudm40T29QUDdlRE5jYjhKUWdXdFpx?=
 =?utf-8?B?SVdtRWdqRVo3S01lT1N2RGd2ZDFuTFIySVdwSzhacTlWVmZ5ci8rbEx1UUlo?=
 =?utf-8?B?NnE2NlNCeEZQbk9qM3BpUW9sTUVQdW5PNTJYYXlzd21PM3lHSElzanZtMlJR?=
 =?utf-8?B?bFVyRWRHQ1d6V0VOL0lSRmFyNnpPelVYd0FWeHFoWUdoT3pEZUZCVFFqd2Nu?=
 =?utf-8?B?b1RxdFc3NlhuMEdnakxvT25OQmRMZVl6Tm9EQWd1ZTlqRHphS0Q5b3NUYXlB?=
 =?utf-8?B?ZnRLK0VEWmFzUFlWTmpNeUVSNEtDblErSkZpL2JiSGhaRjZjQmgrZCtQSGh6?=
 =?utf-8?B?RlM5UmFqU3Z1aEZZMFJ3cjA4Mjl6bFEvdnZUS1JlYm5lcEQxUVluUjgwdk83?=
 =?utf-8?B?QVFzcXhoRVVuMVpRYnRNNk8wMllPbzFDMS94Sm0yTXJnYXFwVDZ6WlhmRFdF?=
 =?utf-8?B?QVNXMjBCQTJKbGxtdEhIeHYrSFIwdlNETGJFbHlIcGtUclBUUnViWGZGajBQ?=
 =?utf-8?B?NzFQN1J2a1VDaGx5RUdtOGxwd3NwR3RkbVlFN2MvSUwzaThVaXdlTUVFckdv?=
 =?utf-8?B?RDJHUGlLdFQyUU9nU3dvdmNtK0I1Tjk1am0xSWdNRGNBWGhKTHh5aXdCZTdP?=
 =?utf-8?B?WVJzOTlMVldteDRHT09PRFFzc2RQVHVjU0dnSVhHQTNaUDJRNnhZQ3ZFOWhZ?=
 =?utf-8?B?R1ZpMkxCejZtdDNxQ3NudGRVaURtOVE0Y3VsNmEyT01MUGdRbjIxdHV5RytF?=
 =?utf-8?B?TkZtWFJoS00zekora2lpV2Vrb2Q4UGYrc2V2QTFtUHFJeVBqYUd3Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CykWAbyQV3LnshDy2+hWIVhOAgGFcqz/RjJX6xnWK5Au4B6nrkEnJYus3o0v4QNXc7g6dxdmoxqg5LMqN/dcqPaozAbkXz6mBRXX50mWOJ/KTVajFGtzBQJgllFqTmpT9bmWRNdqiiyPKlcLxuGmuxXO1/sxUAsqQOWMEvdYv8vTYwazyHI5q6p6/UXt3VMe3Zpqo+NoZhlmuaeo/ELCxVcQo4V4+rcKMVVSA89kYsk2vbZjHhQ7pVJO1wKgldci9AqF02Ms5cVj68LHNxTdRwqwRfJj3LFY1JSN1E9PjLuBz/kCvsDZHix9NmpJkEyEixXShhbCVj7TakgQdvPK7Q==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03025f96-9133-4185-c7b0-08de9a898006
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2026 00:54:08.1817 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oMbHhz9LZh8e6k7jRjPXpL5ajWGKbJqbVujjKNjXqgJ2XuTlgM5fMFI1jZbw47Ikix2IyF1kBQMOr6BaLF6Jd2cB5l1To+OVtYjXByz82d4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5578
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

SGkgUGhpbGlwcGUNCg0KPiA+ICAgY29uc3QgVk1TdGF0ZURlc2NyaXB0aW9uIHZtc3RhdGVfZWhj
aSA9IHsNCj4gPiAgICAgICAubmFtZSAgICAgICAgPSAiZWhjaS1jb3JlIiwNCj4gPiAtICAgIC52
ZXJzaW9uX2lkICA9IDIsDQo+ID4gKyAgICAudmVyc2lvbl9pZCAgPSAzLA0KPiA+ICAgICAgIC5t
aW5pbXVtX3ZlcnNpb25faWQgID0gMSwNCj4gPiAgICAgICAucHJlX3NhdmUgICAgPSB1c2JfZWhj
aV9wcmVfc2F2ZSwNCj4gPiAgICAgICAucG9zdF9sb2FkICAgPSB1c2JfZWhjaV9wb3N0X2xvYWQs
DQo+ID4gQEAgLTI1MDEsOCArMjUxMCwxMCBAQCBjb25zdCBWTVN0YXRlRGVzY3JpcHRpb24gdm1z
dGF0ZV9laGNpID0gew0KPiA+ICAgICAgICAgICAvKiBzY2hlZHVsZSBzdGF0ZSAqLw0KPiA+ICAg
ICAgICAgICBWTVNUQVRFX1VJTlQzMihhc3RhdGUsIEVIQ0lTdGF0ZSksDQo+ID4gICAgICAgICAg
IFZNU1RBVEVfVUlOVDMyKHBzdGF0ZSwgRUhDSVN0YXRlKSwNCj4gPiAtICAgICAgICBWTVNUQVRF
X1VJTlQzMihhX2ZldGNoX2FkZHIsIEVIQ0lTdGF0ZSksDQo+ID4gLSAgICAgICAgVk1TVEFURV9V
SU5UMzIocF9mZXRjaF9hZGRyLCBFSENJU3RhdGUpLA0KPiA+ICsgICAgICAgIFZNU1RBVEVfVUlO
VDMyX1YoYV9mZXRjaF9hZGRyX3ByZV92MywgRUhDSVN0YXRlLCAyKSwNCj4gPiArICAgICAgICBW
TVNUQVRFX1VJTlQzMl9WKHBfZmV0Y2hfYWRkcl9wcmVfdjMsIEVIQ0lTdGF0ZSwgMiksDQo+IA0K
PiBJSVVDIHdlIHdhbnQgVk1TVEFURV9VSU5UMzJfVEVTVCguLi4sIDMpIGhlcmUsIGZvciAiPDMi
Lg0KPiANCj4gPiArICAgICAgICBWTVNUQVRFX1VJTlQ2NF9WKGFfZmV0Y2hfYWRkciwgRUhDSVN0
YXRlLCAzKSwNCj4gPiArICAgICAgICBWTVNUQVRFX1VJTlQ2NF9WKHBfZmV0Y2hfYWRkciwgRUhD
SVN0YXRlLCAzKSwNCj4gDQo+IFRoZXNlIG9uZXMgYXJlIGNvcnJlY3QgKCI+PTMiKS4NCj4gDQo+
ID4gICAgICAgICAgIFZNU1RBVEVfRU5EX09GX0xJU1QoKQ0KPiA+ICAgICAgIH0NCj4gPiAgIH07
DQoNClRoYW5rcyBmb3IgdGhlIHJldmlldyBhbmQgc3VnZ2VzdGlvbi4NCkhvdyBhYm91dCB0aGUg
Zm9sbG93aW5nIGNoYW5nZXM/DQpUaGFua3MtSmFtaW4NCg0KK3N0YXRpYyBib29sIGVoY2lfY29y
ZV9pc19iZWZvcmVfdmVyc2lvbl8zKHZvaWQgKm9wYXF1ZSwgaW50IHZlcnNpb25faWQpDQorew0K
KyAgICByZXR1cm4gdmVyc2lvbl9pZCA8IDM7DQorfQ0KKw0KIGNvbnN0IFZNU3RhdGVEZXNjcmlw
dGlvbiB2bXN0YXRlX2VoY2kgPSB7DQogICAgIC5uYW1lICAgICAgICA9ICJlaGNpLWNvcmUiLA0K
ICAgICAudmVyc2lvbl9pZCAgPSAzLA0KQEAgLTI1MTAsOCArMjUxNSwxMCBAQCBjb25zdCBWTVN0
YXRlRGVzY3JpcHRpb24gdm1zdGF0ZV9laGNpID0gew0KICAgICAgICAgLyogc2NoZWR1bGUgc3Rh
dGUgKi8NCiAgICAgICAgIFZNU1RBVEVfVUlOVDMyKGFzdGF0ZSwgRUhDSVN0YXRlKSwNCiAgICAg
ICAgIFZNU1RBVEVfVUlOVDMyKHBzdGF0ZSwgRUhDSVN0YXRlKSwNCi0gICAgICAgIFZNU1RBVEVf
VUlOVDMyX1YoYV9mZXRjaF9hZGRyX3ByZV92MywgRUhDSVN0YXRlLCAyKSwNCi0gICAgICAgIFZN
U1RBVEVfVUlOVDMyX1YocF9mZXRjaF9hZGRyX3ByZV92MywgRUhDSVN0YXRlLCAyKSwNCisgICAg
ICAgIFZNU1RBVEVfVUlOVDMyX1RFU1QoYV9mZXRjaF9hZGRyX3ByZV92MywgRUhDSVN0YXRlLA0K
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICBlaGNpX2NvcmVfaXNfYmVmb3JlX3ZlcnNpb25f
MyksDQorICAgICAgICBWTVNUQVRFX1VJTlQzMl9URVNUKHBfZmV0Y2hfYWRkcl9wcmVfdjMsIEVI
Q0lTdGF0ZSwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgZWhjaV9jb3JlX2lzX2JlZm9y
ZV92ZXJzaW9uXzMpLA0KICAgICAgICAgVk1TVEFURV9VSU5UNjRfVihhX2ZldGNoX2FkZHIsIEVI
Q0lTdGF0ZSwgMyksDQogICAgICAgICBWTVNUQVRFX1VJTlQ2NF9WKHBfZmV0Y2hfYWRkciwgRUhD
SVN0YXRlLCAzKSwNCiAgICAgICAgIFZNU1RBVEVfRU5EX09GX0xJU1QoKQ0K

