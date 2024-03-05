Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8422C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 05:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhN2y-0003qq-1x; Tue, 05 Mar 2024 00:09:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rhN2t-0003qM-GQ; Tue, 05 Mar 2024 00:08:55 -0500
Received: from mail-southeastasiaazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c401::3] helo=SINPR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rhN2q-0005Jd-O5; Tue, 05 Mar 2024 00:08:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGkru/GhMPCNDtVfpFh892Feu//87m5IOzTi2YKR1MEzkiiptXBGe6jHGJAQRllhdinor3EK0QmMtuLf5TlBeYMuRHfZIeUrMKvQjeOmk+5DFXVCVl863tvYou9Iyc994FCfP1dEGhkkHSaQfT1v0kOH+gjBt4NFsjuNWFV5/y2NE634dkWh5yaSZEFZ8Lv6+1A2itC4O+FLFI2eDL/2cYp8LSwaHsK+iw6i/BDxqIzY4wOVczyzgDondmde16fNz/CUQ2OJUYF4FsZU1rxdj29U99kbp5maRmY6MjYbmLMiXJFrDgkC911YWW9W7AvGmLkeufOa/ewGVQRJF/d6/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anSxWDhK9fJIwZFAnsuXaCbAItF0ua+oM0KcmzdDmgU=;
 b=ky2t0kH8N+iVfbiZkW9vlDEOjpHqHaTuie2c60v6pWdqjUjuKMhIfST36+AZ9R71ZyHQVN4Jas/QrCwxAxBBzSSXfcMIp1AVdKfjjCn9gQst2MJn6RrrDIRXQVZivWWWhed/HQwsgicwgjG8PieIf1z2vFAYQVhz6WrX9Uuxw5NJpgw3/eCbc5BfWLA43vaJ50e4mwmoJ1Mu6yiUZaWLhOaZIWQ4FSUAkppYvsolDKLoPzhpw44K9b+BVWYenlQGdiudZHtMzGW9gfeHRy+fdGxI8aB1m/gi0DtCZFE8U7uL0Ip71sANeK5y8pslAmNx7XXQYqZeTKw+8cP/qFLnIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anSxWDhK9fJIwZFAnsuXaCbAItF0ua+oM0KcmzdDmgU=;
 b=ojEhF43vor1UB3I/PTgdlJeyZhI4Z9NkDFJDPN/R6jtwahUv4SysH0nO9ktza2ZB6xQ1larIUSuJa2GrZnkWfsf23u+l7cQNjOXct3rRrgEia5D8z2N55qwcKfmJXjkiOJg8AmcgJEGePki+KIQeuCN0Uvk3OJW3mi7bBQf6++ottO3eN6AaN3Fri+VctTaLELTHNdIy8xi9PjQ0AItjLuumMrRsA08esMD9j17FgZk/P8J/6mf5wAwVelNPmiqIzhcK6CbaebNDsX9m0Azy5EKzDEfO/JxuJH1KmjRONVphC+gXjQBD/A/NJhtKJ9trX1aZV11C9Mna2QzbIAcRMw==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYUPR06MB6122.apcprd06.prod.outlook.com (2603:1096:400:346::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 05:08:43 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::14c9:526b:24b5:109d]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::14c9:526b:24b5:109d%4]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 05:08:43 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v2 8/9] aspeed: Add an AST2700 eval board
Thread-Topic: [PATCH v2 8/9] aspeed: Add an AST2700 eval board
Thread-Index: AQHabhZ/pSua/361tEamcrzQCbSN37EnuCcAgADhdsA=
Date: Tue, 5 Mar 2024 05:08:43 +0000
Message-ID: <SI2PR06MB504151FBC4926BD0BAF82A4CFC222@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240304092934.1953198-1-jamin_lin@aspeedtech.com>
 <20240304092934.1953198-9-jamin_lin@aspeedtech.com>
 <eeda8073-a8bb-4f33-b69d-20dec408e8ed@kaod.org>
In-Reply-To: <eeda8073-a8bb-4f33-b69d-20dec408e8ed@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYUPR06MB6122:EE_
x-ms-office365-filtering-correlation-id: c73cf7a3-601c-47bf-8e6a-08dc3cd25430
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xTKFEqwcuq+ZpmNFs3+7pJCNRbzkHgHI/VoaLIsbcqcS5sft6IoJHLYbBcIBKvn4U7umXirHVxGHclp0JZhqcbVs7BNOkPAgAQEM9yKf+Ncbo5PtkakXxtLiDZYtX/DbMQ+AhiXhs1sL/SbVltjJi+1sAjNKQRpbCNB97QpKElEZhbgqCJjasebA9UlhNIqQadHJQSXbc6TuPt8upypvL1dF4K/7hxhZLKR+dB2Kr+GrMckuBatOfTayjLcvI9EabS29y2/Z6UjwaJ0Hkw91+8W0V1sAs9yRish2tixUdjtK+bLunCG62tyDMzlglxWiNhUbl64wUzgj2oWEtaYPzmGo3+CtvIGP3miXLffmPTd5NBEJPflPCccKCZOa67lAWZqkOlExR/TIVAnWzmN63r2kHmqS+9dbYSimHryq1p6H/hR+zJKDuCQv+aDI80MmPOOHXPoEB6pjZd6/7OOdfiymyXkdaUJTGgkTCCLBz0ckq2G2tFbyvG8CnQGunH1vkRBHNwQYPnYDxqnYlmUwt8Po8sMatjchjGzpfYRU2nIBDRg87nf5lPkCRfPAprk4cZMftHPBtjaL2i1KFDpL+HBUNgo9zaTBKfmaIrWs/j3cecLFuqb7z/AS0kIEj92qrKSd6Fh8dR1fktawHLwDkyJ+aOY+mDBZi4djuX71FQBuBtIADQHwHhBg7uygjGcNFddubbK6agxkt5KruF+hy0qmQpYlbW/DeM2X+ibTMp8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1QvUGQzS0xha0k5ZDhrUjZ1OHVvdzlsUzl5NWpELzcwc3FncTg2Zk9yajJs?=
 =?utf-8?B?M29Yb1VmdU55dm1mbmt6UFRVdFNVM0EydDhyOE9WSWw0M3dVVVNwNVZ6eWI3?=
 =?utf-8?B?RitzOHZ6dERBV2MvWE5nMHArTG1Mc2RPdVpsdmRkMFhmMzJYdFBsOExXSllj?=
 =?utf-8?B?WjE5ZVgya3hLaWljdCtRYWFvL1hGckd0emlRUFMvdzNDbWdZMmE2ZVUyK3pS?=
 =?utf-8?B?RTNZN3BhdFh0eDZvWUFQRFR0STRRcE5ydkNZWHkxbkl2dlVuQVZwRk40a1Ur?=
 =?utf-8?B?V1lPaFlEdTJKN1Q1cXhCR2JDZTRaYTZndmxDMnhFREw5R1FYbGJIRXFGNkRN?=
 =?utf-8?B?d0JEdzNhZnlKWkJsTkwyRmhxdFN6VHpydzAwbkYyWnVSeGtRazh3bWFnYnB4?=
 =?utf-8?B?azhHcEt4MDRNSHN0VlQ5ck5yUFFvWERCWGgyY08vV2Y1SkQ2K2dLd0VIeDNt?=
 =?utf-8?B?eDlMSG45blBiOTVUc0l3ZUNwOHZPMWNpUUN5TnY0TzZZczFTVzRpRXozRlVj?=
 =?utf-8?B?RWNyMGdlRVJEKzViamFHSk1xcThQRE96QVVydDl5azBCZXIrSzhoTmFBR1Jn?=
 =?utf-8?B?QjRjVk4zWnVuNVE0K0Njc1Zvc1puU3dYeHFrZ1dUbmF0V0FLRTYvNzFIOXQx?=
 =?utf-8?B?Qzl6Wkh6QXc5aTY2WmZ2SnpWZzZRTG9TM0FiMjRxNmZ2cHpCTlNEZ2dIdXVq?=
 =?utf-8?B?dWYveGUzTU9mQ1F2dEdTWGhpNnVhM0ZXcXlVdGxsUGVyMjEwSGNNYzNhZ0FN?=
 =?utf-8?B?cTVRa1hQQmtudzZnWVAwNDlJb3N1UFE4VjEwYlkrVVlaeHJyeTluM2pYZWZH?=
 =?utf-8?B?K1lWeEs2SFQ2K01NZlhiM095Zm5WRWczdGRJam54MUU3bklvMENxekdlaFJv?=
 =?utf-8?B?cTkraFhKaGhTYjhLRkFROEMyN2VjcnhTK3ZYZkExSVlqRm9vSlpKNGRQckZt?=
 =?utf-8?B?NzFXd1lmVERhbTFKMFAvK0xsYUk3NS9nWHU5M2dDWHhvR2lEOG10cm9pTEE2?=
 =?utf-8?B?eTQ0NEpLaVYwSHJ3K295WlpLYkZXcE5TRFhDaHRHYXVFVWdZN2RseDNucnBH?=
 =?utf-8?B?RHRxcjMrNHIxVlVjYWVnQVozK0ZRL2FMWnZ4Zk5zaHozdHY5NGc0TXBoRDUy?=
 =?utf-8?B?MitBZi9rZ05RU3h4Y2Vxd2FuOUVMQjk1aWhHQmtmZ1lTTEdmMTVHNkFvQ2ZV?=
 =?utf-8?B?OXFxQytiTE9iL0QwM0FrcWhDL3NDajhWaDB5ZmV3NEJZNlIwVkIrWmZUaTd2?=
 =?utf-8?B?cVgzbGZJcTBHaWRGcnRnUitMVkRYSEN6dHF2d0dQVHVDdEV4WkZMZzNVbHRr?=
 =?utf-8?B?Y3QxWUcxMWZWc2dEQzFJZGFFNFNkYnk0bHZIaW9EdjllRkVKTDJqUFRNbkRw?=
 =?utf-8?B?cDhvcW5kVXVEdVVxL2ZDRDAxWlBZa2pCa21DcFBjTE9aQjlYeENiQjNWUEhV?=
 =?utf-8?B?N0k1c1NKSGpUSzFGUEt3NWRaM1dqQmtPcE9pVmZtcHQxaWovVm43bElaSkRV?=
 =?utf-8?B?YmM1cldzWlF5Q2NkYytDQ1NOeUlLMWtJeVUxV05QVmZDL1JQOWU0VnJmNEJi?=
 =?utf-8?B?WGc2aTVnRDJ5bnFmMTNqU0lHYXE0bERoRXJsa3YwNTFjdlJHejlRcW0vdTIz?=
 =?utf-8?B?eFdJYUt6K3dLc1gyc0s5Qnh1cERKRVIzSEQ4MlNkYnJieU1zcEpiTVJ4ZnV3?=
 =?utf-8?B?TVVwYk9Xd01vYzI1OUdtYW56SEd6Y3NJaitzaWlFdzR1YjVIWHFWYkZTcGxZ?=
 =?utf-8?B?Z3BTTFFEWDZnZkJUZzBRbzZ4N1p6NXFtV2U3RHI0Vit0U0NTVTJFVG5Jai9m?=
 =?utf-8?B?a3N1YldTTzc0R283bkRlcFhpcUZKdEhkUkUzS3dxUkdvc2NTRkc0ZmNpY0Zi?=
 =?utf-8?B?eitHc2ZQK3NaV1Vldm9XdXd5bGUvcEFYY3UyaVEvTG93c1lreWgwQXFCY0dn?=
 =?utf-8?B?bzBLVTEzdEdCRzRsNHlIcTNjcU4zM05lc0FkMGNjd0ZIbTNaWCsrK2hiNGFI?=
 =?utf-8?B?d290RU1Bdml6d2dZckl4Vmx4UFpzM3czcHBBVjVIdlRQL0ZBdVFnUlZaeEdu?=
 =?utf-8?B?QVB3WE5HQXBxcEwyMGE3Z0VqQmdRWmtoYUpka3dXMDhjT2tQTVUzWEZtMnYx?=
 =?utf-8?Q?IDOdQbXjApQoEXIVy+V/QWmSc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c73cf7a3-601c-47bf-8e6a-08dc3cd25430
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 05:08:43.2681 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ScOmXdypz4SQ0NV4yQnTM9vhNztm6VN7AFjtQ8hJNhn1gXty53eNZbjPQYkXasKx/lRZCkeB8s/YfPTD02uXHH+UmhFNh1WgMv9z0lhTLr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6122
Received-SPF: pass client-ip=2a01:111:f403:c401::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SINPR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8
Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBNb25kYXksIE1hcmNoIDQsIDIwMjQgMTE6NDAgUE0NCj4g
VG86IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPjsgUGV0ZXIgTWF5ZGVsbA0K
PiA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgQW5kcmV3IEplZmZlcnkgPGFuZHJld0Bjb2Rl
Y29uc3RydWN0LmNvbS5hdT47DQo+IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+OyBBbGlz
dGFpciBGcmFuY2lzIDxhbGlzdGFpckBhbGlzdGFpcjIzLm1lPjsgb3Blbg0KPiBsaXN0OkFTUEVF
RCBCTUNzIDxxZW11LWFybUBub25nbnUub3JnPjsgb3BlbiBsaXN0OkFsbCBwYXRjaGVzIENDIGhl
cmUNCj4gPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gQ2M6IFRyb3kgTGVlIDx0cm95X2xlZUBh
c3BlZWR0ZWNoLmNvbT47IFl1bmxpbiBUYW5nDQo+IDx5dW5saW4udGFuZ0Bhc3BlZWR0ZWNoLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiA4LzldIGFzcGVlZDogQWRkIGFuIEFTVDI3MDAg
ZXZhbCBib2FyZA0KPiANCj4gT24gMy80LzI0IDEwOjI5LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4g
QVNUMjcwMCBDUFUgaXMgQVJNIENvcnRleC1BMzUgd2hpY2ggaXMgNjQgYml0cy4NCj4gPiBBZGQg
VEFSR0VUX0FBUkNINjQgdG8gYnVpbGQgdGhpcyBtYWNoaW5lLg0KPiA+DQo+ID4gQWNjb3JkaW5n
IHRvIHRoZSBkZXNpZ24gb2YgYXN0MjcwMCwgaXQgaGFzIGEgYm9vdG1jdShyaXNjdi0zMikgd2hp
Y2gNCj4gPiBpcyB1c2VkIGZvciBleGVjdXRpbmcgU1BMLg0KPiA+IFRoZW4sIENQVXMoY29ydGV4
LWEzNSkgZXhlY3V0ZSB1LWJvb3QsIGtlcm5lbCBhbmQgcm9mcy4NCj4gPg0KPiA+IEN1cnJlbnRs
eSwgcWVtdSBub3Qgc3VwcG9ydCBlbXVsYXRlIHR3byBDUFUgYXJjaGl0ZWN0dXJlcyBhdCB0aGUg
c2FtZQ0KPiA+IG1hY2hpbmUuIFRoZXJlZm9yZSwgcWVtdSB3aWxsIG9ubHkgc3VwcG9ydCB0byBl
bXVsYXRlIENQVShjb3J0ZXgtYTM1KQ0KPiA+IHNpZGUgZm9yIGFzdDI3MDANCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFRyb3kgTGVlIDx0cm95X2xlZUBhc3BlZWR0ZWNoLmNvbT4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgIGh3L2FybS9hc3BlZWQuYyB8IDMyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2h3L2FybS9hc3BlZWQuYyBiL2h3L2FybS9hc3BlZWQuYyBpbmRleA0KPiA+IDg4
NTQ1ODFjYTguLjQ1NDQwMjZkMTQgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJtL2FzcGVlZC5jDQo+
ID4gKysrIGIvaHcvYXJtL2FzcGVlZC5jDQo+ID4gQEAgLTE3OCw2ICsxNzgsMTIgQEAgc3RydWN0
IEFzcGVlZE1hY2hpbmVTdGF0ZSB7DQo+ID4gICAjZGVmaW5lIEFTVDI2MDBfRVZCX0hXX1NUUkFQ
MSAweDAwMDAwMEMwDQo+ID4gICAjZGVmaW5lIEFTVDI2MDBfRVZCX0hXX1NUUkFQMiAweDAwMDAw
MDAzDQo+ID4NCj4gPiArI2lmZGVmIFRBUkdFVF9BQVJDSDY0DQo+ID4gKy8qIEFTVDI3MDAgZXZi
IGhhcmR3YXJlIHZhbHVlICovDQo+ID4gKyNkZWZpbmUgQVNUMjcwMF9FVkJfSFdfU1RSQVAxIDB4
MDAwMDAwQzAgI2RlZmluZQ0KPiA+ICtBU1QyNzAwX0VWQl9IV19TVFJBUDIgMHgwMDAwMDAwMyAj
ZW5kaWYNCj4gPiArDQo+ID4gICAvKiBUYWNvbWEgaGFyZHdhcmUgdmFsdWUgKi8NCj4gPiAgICNk
ZWZpbmUgVEFDT01BX0JNQ19IV19TVFJBUDEgIDB4MDAwMDAwMDANCj4gPiAgICNkZWZpbmUgVEFD
T01BX0JNQ19IV19TVFJBUDIgIDB4MDAwMDAwNDAgQEAgLTE1ODgsNg0KPiArMTU5NCwyNiBAQA0K
PiA+IHN0YXRpYyB2b2lkIGFzcGVlZF9taW5pYm1jX21hY2hpbmVfYXN0MTAzMF9ldmJfY2xhc3Nf
aW5pdChPYmplY3RDbGFzcw0KPiAqb2MsDQo+ID4gICAgICAgYXNwZWVkX21hY2hpbmVfY2xhc3Nf
aW5pdF9jcHVzX2RlZmF1bHRzKG1jKTsNCj4gPiAgIH0NCj4gPg0KPiA+ICsjaWZkZWYgVEFSR0VU
X0FBUkNINjQNCj4gPiArc3RhdGljIHZvaWQgYXNwZWVkX21hY2hpbmVfYXN0MjcwMF9ldmJfY2xh
c3NfaW5pdChPYmplY3RDbGFzcyAqb2MsDQo+ID4gK3ZvaWQgKmRhdGEpIHsNCj4gPiArICAgIE1h
Y2hpbmVDbGFzcyAqbWMgPSBNQUNISU5FX0NMQVNTKG9jKTsNCj4gPiArICAgIEFzcGVlZE1hY2hp
bmVDbGFzcyAqYW1jID0gQVNQRUVEX01BQ0hJTkVfQ0xBU1Mob2MpOw0KPiA+ICsNCj4gPiArICAg
IG1jLT5kZXNjID0gIkFzcGVlZCBBU1QyNzAwIEVWQiAoQ29ydGV4LUEzNSkiOw0KPiA+ICsgICAg
YW1jLT5zb2NfbmFtZSAgPSAiYXN0MjcwMC1hMCI7DQo+ID4gKyAgICBhbWMtPmh3X3N0cmFwMSA9
IEFTVDI3MDBfRVZCX0hXX1NUUkFQMTsNCj4gPiArICAgIGFtYy0+aHdfc3RyYXAyID0gQVNUMjcw
MF9FVkJfSFdfU1RSQVAyOw0KPiA+ICsgICAgYW1jLT5mbWNfbW9kZWwgPSAidzI1cTAxanZxIjsN
Cj4gPiArICAgIGFtYy0+c3BpX21vZGVsID0gIncyNXE1MTJqdiI7DQo+ID4gKyAgICBhbWMtPm51
bV9jcyAgICA9IDI7DQo+ID4gKyAgICBhbWMtPm1hY3NfbWFzayA9IEFTUEVFRF9NQUMwX09OIHwg
QVNQRUVEX01BQzFfT04gfA0KPiBBU1BFRURfTUFDMl9PTjsNCj4gPiArICAgIGFtYy0+dWFydF9k
ZWZhdWx0ID0gQVNQRUVEX0RFVl9VQVJUMTI7DQo+ID4gKyAgICBtYy0+ZGVmYXVsdF9yYW1fc2l6
ZSA9IDEgKiBHaUI7DQo+IA0KPiBUaGlzIHNlZW1zIGxvdy4gV2hhdCdzIHRoZSBzaXplIG9uIHJl
YWwgSFcgID8NCj4gDQpIaSBDZWRyaWMsDQpUaGFua3MgZm9yIHJldmlldy4NClRoZSBkZWZhdWx0
IHJhbSBzaXplIGlzIDEgR2lCIG9uIEFTVDI3MDAgRVZCIGFuZCBBU1QyNzAwIHN1cHBvcnQgdGhl
IG1heGltdW0gZHJhbSBzaXplIGlzIDhHaUIuDQo+IEFueWhvdywNCj4gDQo+IA0KPiBSZXZpZXdl
ZC1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0BrYW9kLm9yZz4NCj4gDQo+IFRoYW5rcywNCj4g
DQo+IEMuDQo+IA0KPiANCj4gPiArICAgIGFzcGVlZF9tYWNoaW5lX2NsYXNzX2luaXRfY3B1c19k
ZWZhdWx0cyhtYyk7DQo+ID4gK30NCj4gPiArI2VuZGlmDQo+ID4gKw0KPiA+ICAgc3RhdGljIHZv
aWQgYXNwZWVkX21hY2hpbmVfcWNvbV9kY19zY21fdjFfY2xhc3NfaW5pdChPYmplY3RDbGFzcw0K
PiAqb2MsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHZvaWQNCj4gKmRhdGEpDQo+ID4gICB7DQo+ID4gQEAgLTE3MTEsNiArMTczNywx
MiBAQCBzdGF0aWMgY29uc3QgVHlwZUluZm8gYXNwZWVkX21hY2hpbmVfdHlwZXNbXSA9IHsNCj4g
PiAgICAgICAgICAgLm5hbWUgICAgICAgICAgID0gTUFDSElORV9UWVBFX05BTUUoImFzdDEwMzAt
ZXZiIiksDQo+ID4gICAgICAgICAgIC5wYXJlbnQgICAgICAgICA9IFRZUEVfQVNQRUVEX01BQ0hJ
TkUsDQo+ID4gICAgICAgICAgIC5jbGFzc19pbml0ICAgICA9DQo+IGFzcGVlZF9taW5pYm1jX21h
Y2hpbmVfYXN0MTAzMF9ldmJfY2xhc3NfaW5pdCwNCj4gPiArI2lmZGVmIFRBUkdFVF9BQVJDSDY0
DQo+ID4gKyAgICB9LCB7DQo+ID4gKyAgICAgICAgLm5hbWUgICAgICAgICAgPSBNQUNISU5FX1RZ
UEVfTkFNRSgiYXN0MjcwMC1ldmIiKSwNCj4gPiArICAgICAgICAucGFyZW50ICAgICAgICA9IFRZ
UEVfQVNQRUVEX01BQ0hJTkUsDQo+ID4gKyAgICAgICAgLmNsYXNzX2luaXQgICAgPSBhc3BlZWRf
bWFjaGluZV9hc3QyNzAwX2V2Yl9jbGFzc19pbml0LA0KPiA+ICsjZW5kaWYNCj4gPiAgICAgICB9
LCB7DQo+ID4gICAgICAgICAgIC5uYW1lICAgICAgICAgID0gVFlQRV9BU1BFRURfTUFDSElORSwN
Cj4gPiAgICAgICAgICAgLnBhcmVudCAgICAgICAgPSBUWVBFX01BQ0hJTkUsDQoNCg==

