Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC88606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 01:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=gxABjPsA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLsDN-0002hY-OC; Tue, 27 Oct 2026 21:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLsDJ-0002h8-VM; Tue, 27 Oct 2026 21:12:27 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLsDH-0000cX-8l; Tue, 27 Oct 2026 21:12:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDD2s/dLFwhYSBlCJgqPeiOU0u8OwmMeJZLpFZhoecGj24OtX5j9pBWCeNhI/PHhu4tbQwgpBhFdOWDIXbrrU8wrkogmodH8AxPQlsKYOqvBdRaT8uX8NtZzYbuYPN66zjyfct4IQz/39aoSTyOTtLUSixQCR6hYnPsd+KppACA2nV4/Co6kAkgYLkbcTotpNJU3PQOS2ZekQIxLLKWXpGV2vjvpl1ztUQasQN60TrIyhuWB96vm0uWq1VIkdrk04/XdHRRDr+r6IlE9MhnB0saypp0+Z8GSroCwAuDq5s31DLIYTUrRPCdYp/EKklWBNBieT1piZYKZ69WuQ/+/ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m65MrweeKyvWquYsDSGolsKH/8lv+TpBT550uMsb5x8=;
 b=o9Lbg94vTj0EPX0Nh25imFgnSeX3HhDSH2ahx1qvYLSSsLHq1hw8CN/kbwdOPWiAbaotTaPt7VleHYqA3twcfbva0jgObjPfY0f/RD25OO3jfB2t8+Lz57hsGER/aaUTiQhEJxErpQ5lMN8xnw83krhbxV5nhN+DGVoYYut9Es/98JzMvdJ0hq9fDfeG46ObnntMLn2l8v/LZhDq/t1Oe4dlZENstDxfaodqrY968Zx1UW+mk+qOs0C2S5z1rsroKXCjLtCnKQi6Z3e2l6V17PFJ5q1F8b5jitC8qkytkPTxScz8qODgLxEif1tobDIEObFpfLwTUO02a42MV778Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m65MrweeKyvWquYsDSGolsKH/8lv+TpBT550uMsb5x8=;
 b=gxABjPsAgzWjcN4hdgXkKo927ez+NjoS5UFhVWbyFOA2WVzrdsNDQcR58wkOSEIKzj/rSZrVokkkY8MIGrjbCEbVP0MSMjEoKbYoHxu5UPlwEYX21+pwseDln4/FyzxDuHc3VOZxBqZzfP749Eg7E+6D5zvzsvP12Ng5o1e1pe2Gpcr6yYwYgqZ6Vids538BGNem/H+DAVDrLBfthSLeyBW6WDD8kJwtuNKYdYZerAiQiE80009PPvHSjBQ0TSgxDzgAzPRa4PXxdtPWounH/JexXflPvNR3QD8b9m6tRbFXbA/pDky7RVNU0VcSqNEAT2XtVBm6P/GWAUVA9Z3pfg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYZPR06MB6282.apcprd06.prod.outlook.com (2603:1096:400:429::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.7; Wed, 28 Oct
 2026 01:12:14 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0569.006; Wed, 28 Oct 2026
 01:12:14 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 06/14] hw/ssi/aspeed_smc: Add AST1040 FMC and SPI
 controllers
Thread-Topic: [PATCH v1 06/14] hw/ssi/aspeed_smc: Add AST1040 FMC and SPI
 controllers
Thread-Index: AQHdXGn4FHLiH0JF30Si7K74PeClw7cQH80AgAIZ6kA=
Date: Wed, 28 Oct 2026 01:12:14 +0000
Message-ID: <SEZPR06MB736292F7364347D37742716CFC6F2@SEZPR06MB7362.apcprd06.prod.outlook.com>
References: <20261015055642.106204-1-jamin_lin@aspeedtech.com>
 <20261015055642.106204-7-jamin_lin@aspeedtech.com>
 <22545073-204b-4975-8f2a-970d6ed88f80@kaod.org>
In-Reply-To: <22545073-204b-4975-8f2a-970d6ed88f80@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TYZPR06MB6282:EE_
x-ms-office365-filtering-correlation-id: f3ef1af8-a3a0-40da-2126-08df34908090
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|921020|38070700021|4143699003|56012099006|261009223027099003|261026121527099003|261021121427099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: GbLr7bWQcdsxZvabwE+39REzjt91M++hBQyYXg74HL6/vLEZarlmCNKTQxOi8TPL9glQXV7x0UfEpWCLrc5AX4lGj8w67z1sE6Tc1cR+GovJbxRVJEHnA+0sO9b2jP9lq/p22N6B485gCNb9197DWAD5miryG7ZEtujC3PMVFImTO+rnmoUBdHTZW8Yv5mGhdHCalyghzmyA0oOeZWFdoksgGhU9JqowzT9PyKENrF5KgOvijMJO/5gvFQRlJ1/P16BJOWb0M5e6qQiwmg+kXsKWToDd7/sHTohyJ3ZS0Wn7bV2cMzwP3VFgDftnOODgYJjce53WG4o4sy69yEQklda4I8vy3NLkMqlbDsULocdEFgRYLjjPIY1tTm9ByFkJSUxozR1ux+GtSqPZq4evlIkP9r5+DO8xhioXi4UasSxc2E7Bywz7YPw8h7i9WcGupZoPT19UvspFsRrhJsOUmsSTRrjvdifIFKwXXsvLBXh7aKENjweBpil4eKahK3NQggnU7rBUGhYOUZb8uuYHOa57UmE+MohBAKMgdvXPqAxbrB1OTwnyPd0y5dhpOLs2Dc/7L+KKqkx3h/jf04Pc+ZYFYGlMqXJ9fvCBhY14RfHJO9LzEAYYyx79r+crYi85FciuruB2BE+Rc6040TFTxxrwAn96qKp4eJi33kUADWxKGsrJ/HhIRMTVQBkRLmKa6gU0+f7cJ2xQjgzjM0ToRhVI5Uc8VobBi1ly5mJ8Nmgz/vi7tUAip/kPFLRlIu+O
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(921020)(38070700021)(4143699003)(56012099006)(261009223027099003)(261026121527099003)(261021121427099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEdRUWFjckcrRUxFcmh6a2hSTHNqY0l2elZkaEVLVWhWN0RSUElSbWVKSmNa?=
 =?utf-8?B?YzdXMjFjNjZEOCtpSW9vbWpNcWxWMk1STkxCTGNqNkhFaGdYejVicndKN3ht?=
 =?utf-8?B?N2hrNG5yVWNwTWExREhGck9mRkRIaW5KZTVrb2tmSzlqVWJ2TmNXNUpIc0k3?=
 =?utf-8?B?b1cydEY5Y3dCVnY5Vm56WVBnUnBQMTRMVmlIREZwRm9ITHhFcXdlZDJqNURh?=
 =?utf-8?B?cGllRWl5VDVEVStMbnVQVkYwcmNvWDVicVBLL0hHdUZWTjRzaSsxVXdKMnY4?=
 =?utf-8?B?UWVoVnA1cFhTM0xmYWhOMzRyVzh0SURoNzdDVjl2WFVaUHFQY2ljb3hGN3NZ?=
 =?utf-8?B?RDRPUmsvZTZtc1V2ZmVJbUlIWEtBUTRPYmZEcTFmYUtjL2lEZlNRcmp3UWhs?=
 =?utf-8?B?SHpYalJlMyt5eDJHdFVuZjJBUnBqSHRsdFcyc0c4TGVETHJBYkduK1RCYUV1?=
 =?utf-8?B?aDgrclVySjVjLzRveDQzM2wyN3RVK2VNczVFTGM3MEtlU2FhTmVvS2ttQWNH?=
 =?utf-8?B?UGVqejJtUXZTdnRBcnMxQUZpd2thSmk1R0NtWTg4VTRUUGtiR0pUVWJXeDJM?=
 =?utf-8?B?OFlIYlQxZm5EVjNnMVcyRUxERGFaTzI4b290d1NOLzJ5MWl0ZlhVOFYwNitK?=
 =?utf-8?B?cXVPU3JBU05RZlNrcWRFTEFCSFFYb2x6N0lFSmlVeTJIeDlLUlg4RHcwclI0?=
 =?utf-8?B?N2N4c1NVUUZialh1cTZCUlJXWFFPRkoyUGU3dCtyc1RSa3M2eUtOY0YxNXlz?=
 =?utf-8?B?bHBSWCtqL21qMHJvdHdXeE1vUldqWUZ6c1Z2MjI4S3ZVaGhXYW5TeGtwZUI5?=
 =?utf-8?B?dDVLUys5Z2hOY1M0by9uR0xLRkdBRU4wVS9nL3hWcDh6QkM4bUtzSHRZcmtp?=
 =?utf-8?B?eXZLaktjRUFxRUp0aVRSbzlLbU1jMTZvU2NGbEVoY2tmZzYyenVXK2JPUTFq?=
 =?utf-8?B?NG5LbUFFZ0k4b0k2SkJXbGphUmw5T0tJRGpxcWF2ck5kTEgra0dmTUU0a0R4?=
 =?utf-8?B?SS9xN3l2SldxVDV4RFYwQVhzUHU4OVc2d3QrRWFVd0J1UHpTVFIwS2EvWVND?=
 =?utf-8?B?RlhySk1DbGRNOTZCWExYUXpqVkZSOXFCSkt6cXJOVDRIL0ZoVEJwZHFVUUg3?=
 =?utf-8?B?bnc4L1FuK0dFNmgzS243RHppZnBXVzZ1a01mNzBmSVhrWlJsa25rNmt4MXYr?=
 =?utf-8?B?MEcvOEpuYnVOQmJ6b0ZHdVdqR2JneDhaWFBJVGZNTCt1dGNXczkwSldkVE1U?=
 =?utf-8?B?RWNpSldzSHFkU3RiN2RaVWF4NjJpc2s1TWVkMFUyaklYR2EwbWgvblpWY0sy?=
 =?utf-8?B?cEw4WDRGZzRlcGQrRVN2eWh1WE05YmYxUisycWVmcExOZDdxNnpic1RhNGRP?=
 =?utf-8?B?WTVDNXRaMkgydU4wWnBTU1dHVVdmQmdQUmZKN1MzYkw2VmVGalBLd0htUzJL?=
 =?utf-8?B?elNIbUdlYXYvak5vdVlodHRRRTZxdHZYanI3UW9MNXYvck55ZkIzNGlBTFpH?=
 =?utf-8?B?dFg3ZDFQMS8xQnd1VGFsUlhLVmxVT01sbC9SRlNKc2xLOGVndjZSL0NjYjRz?=
 =?utf-8?B?QWNHb0hWQzNZckJkL0dhMWRhbjNLNGY3L1hoYU9uaXZUU29zeEFzT2VzbVlp?=
 =?utf-8?B?bEVKdHZGWU1LVnFHa2hyd21YTCsxaDRpWmkzVko4SmtUNEE1eUlEQVdxY0N2?=
 =?utf-8?B?cmViRm1RYittTEVubVI1WmgvRjZtaUtyVURWRUErQ1RVaXNKM09vMFRzVFZF?=
 =?utf-8?B?Y1pTbVJNTVB6TXhweEF3cUtrd3Z5WC9GY1dab3N2eSsycWhxaHorQkxUQUl6?=
 =?utf-8?B?ck5abzBubVVyd29KaHM1VnV2ekM4Mkw3WDM4SW4rQlNCNEhJTzRYb1VwUXB4?=
 =?utf-8?B?VzBwNmdDWXBkUTRzQldsMmJUeFlPTWNXRzV0ZHh6K1l2Z0ZEM29Gb0R3ZHJS?=
 =?utf-8?B?cDZFKzcvZ2lwZUtvMURBMFhTVVNrRXJPQnV2YkJvbkMzWDhPcDgrSndJdUdz?=
 =?utf-8?B?YXRkSEdGL0FyYnFReDZKby82L0xUcTlXOU81aDEvRlVwalZXeFpxd0VmcU1z?=
 =?utf-8?B?TlJRMWRpOCtjeWlaYU9hTGNLUG52MGh1YzVUaHVuME9tMEdIQjZ1VmRkc0gr?=
 =?utf-8?B?cGVxL0ZMeW4wWTh1ZEtQWWpkRDlTSnBMTFh1SFQxTHJtLzd4cXNSYlpGQlJW?=
 =?utf-8?B?by9NVlBScnZYRUZEb1U2cTB2U21YSDl5WWhYNEwzTm41N3BwVkhyUlc0Y3Ay?=
 =?utf-8?B?L1RxRFd6VHRqKzIzY3Uzc3g1Wmo3cko3MnlYNGZkT0ltUThNdk5NUHVDUStX?=
 =?utf-8?B?Yk42MnYyd0VyNVpKOVlJM3BLb0dndG5iNnM5Y2NoN1hjQkx6Z0NuQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VQc/WOUVIXO/0Ws69v8EZxtDR1VIuDsRUfwu/X+HKs1Il0YcyJZVX0tN+lHtf20VXt2ZfxCUQkRl3kX2iETnrSzUKadbfEzCQ0C6LFbh2I4DfCGPWL8muJGxMbQwc5tSXy/R4Pu8MO5kwAJqHMfiEJGvUQkxUZB7wMbfZiIfbYtXBjS/HxIjA6qFH5RnprFR6M7BfTqKjW4OCni81ZqE1IROwK4XNIJXBTn2WcrQktREQKUtNxucN0mCWCuwc8LygVV9JlyQTdpIo81KKTDhp/Aj8RfUvKOhd3d3mKAsYM2hYGw5MmWHaw1exnHRW4tzeHWBZxt6IuBmHUOGoxC0Bg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ef1af8-a3a0-40da-2126-08df34908090
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 01:12:14.5942 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oEzPl6/dwGsZcCmKad/FpPXj5urRXoKhjgUsi5YkilH335F5rDzmQsuMV12KGqSL4f4MuLszZKx09k1LMc+pj7rUMiDZ4RQ33u/Mjv4ICaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6282
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDYvMTRdIGh3L3NzaS9hc3Bl
ZWRfc21jOiBBZGQgQVNUMTA0MCBGTUMgYW5kIFNQSQ0KPiBjb250cm9sbGVycw0KPiANCj4gT24g
MTAvMTUvMjYgMDc6NTYsIEphbWluIExpbiB3cm90ZToNCj4gPiBUaGUgQVNUMTA0MCBGTUMgYW5k
IFNQSSBjb250cm9sbGVycyBhcmUgY29tcGF0aWJsZSB3aXRoIHRoZSBBU1QyNzAwDQo+ID4gY29u
dHJvbGxlcnMsIGJ1dCB1c2UgZGlmZmVyZW50IGZsYXNoIHdpbmRvdy4gVGhlcmVmb3JlLCB0aGUg
QVNUMjcwMA0KPiA+IGNvbnRyb2xsZXIgdHlwZXMgY2Fubm90IGJlIHJldXNlZCBkaXJlY3RseSBm
b3IgQVNUMTA0MC4NCj4gPg0KPiA+IEFkZCBkZWRpY2F0ZWQgQVNUMTA0MCBGTUMsIFNQSTAgYW5k
IFNQSTEgY29udHJvbGxlciB0eXBlcyB3aXRoIHRoZQ0KPiA+IGFwcHJvcHJpYXRlIHBhcmFtZXRl
ciBzZXR0aW5ncy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEphbWluIExpbiA8amFtaW5fbGlu
QGFzcGVlZHRlY2guY29tPg0KPiA+IC0tLQ0KPiA+ICAgaHcvc3NpL2FzcGVlZF9zbWMuYyB8IDEw
OQ0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAg
MSBmaWxlIGNoYW5nZWQsIDEwOSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
aHcvc3NpL2FzcGVlZF9zbWMuYyBiL2h3L3NzaS9hc3BlZWRfc21jLmMgaW5kZXgNCj4gPiBjMGMz
NjY2ZGJjLi44OWE3ZGMxMTA1IDEwMDY0NA0KPiA+IC0tLSBhL2h3L3NzaS9hc3BlZWRfc21jLmMN
Cj4gPiArKysgYi9ody9zc2kvYXNwZWVkX3NtYy5jDQo+ID4gQEAgLTIwNzIsNiArMjA3MiwxMDAg
QEAgc3RhdGljIHZvaWQNCj4gYXNwZWVkXzI3MDBfc3BpMl9jbGFzc19pbml0KE9iamVjdENsYXNz
ICprbGFzcywgY29uc3Qgdm9pZCAqZGF0YSkNCj4gPiAgICAgICBhc2MtPnJlZ19vcHMgICAgICAg
ICAgID0gJmFzcGVlZF8yNzAwX3NtY19mbGFzaF9vcHM7DQo+ID4gICB9DQo+ID4NCj4gPiArc3Rh
dGljIHZvaWQgYXNwZWVkXzEwNDBfZm1jX2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKmtsYXNzLCBj
b25zdCB2b2lkDQo+ID4gKypkYXRhKSB7DQo+ID4gKyAgICBEZXZpY2VDbGFzcyAqZGMgPSBERVZJ
Q0VfQ0xBU1Moa2xhc3MpOw0KPiA+ICsgICAgQXNwZWVkU01DQ2xhc3MgKmFzYyA9IEFTUEVFRF9T
TUNfQ0xBU1Moa2xhc3MpOw0KPiA+ICsNCj4gPiArICAgIGRjLT5kZXNjICAgICAgICAgICAgICAg
PSAiQXNwZWVkIDEwNDAgRk1DIENvbnRyb2xsZXIiOw0KPiA+ICsgICAgYXNjLT5yX2NvbmYgICAg
ICAgICAgICA9IFJfQ09ORjsNCj4gPiArICAgIGFzYy0+cl9jZV9jdHJsICAgICAgICAgPSBSX0NF
X0NUUkw7DQo+ID4gKyAgICBhc2MtPnJfY3RybDAgICAgICAgICAgID0gUl9DVFJMMDsNCj4gPiAr
ICAgIGFzYy0+cl90aW1pbmdzICAgICAgICAgPSBSX1RJTUlOR1M7DQo+ID4gKyAgICBhc2MtPm5y
ZWdzX3RpbWluZ3MgICAgID0gMjsNCj4gPiArICAgIGFzYy0+Y29uZl9lbmFibGVfdzAgICAgPSBD
T05GX0VOQUJMRV9XMDsNCj4gPiArICAgIGFzYy0+Y3NfbnVtX21heCAgICAgICAgPSAyOw0KPiA+
ICsgICAgYXNjLT5zZWdtZW50cyAgICAgICAgICA9IGFzcGVlZF8yNzAwX3NwaTBfc2VnbWVudHM7
DQo+ID4gKyAgICBhc2MtPnNlZ21lbnRfYWRkcl9tYXNrID0gMHhmZmZmZmZmZjsNCj4gPiArICAg
IGFzYy0+Zmxhc2hfd2luZG93X2Jhc2UgPSAweDgwMDAwMDAwOw0KPiA+ICsgICAgYXNjLT5mbGFz
aF93aW5kb3dfc2l6ZSA9IDUxMiAqIE1pQjsNCj4gPiArICAgIGFzYy0+ZmVhdHVyZXMgICAgICAg
ICAgPSBBU1BFRURfU01DX0ZFQVRVUkVfRE1BIHwNCj4gPiArDQo+IEFTUEVFRF9TTUNfRkVBVFVS
RV9ETUFfRFJBTV9BRERSX0hJR0g7DQo+ID4gKyAgICBhc2MtPmRtYV9mbGFzaF9tYXNrICAgID0g
MHgxRkZGRkZGQzsNCj4gPiArICAgIGFzYy0+ZG1hX2RyYW1fbWFzayAgICAgPSAweDAwRkZGRkZD
Ow0KPiA+ICsgICAgYXNjLT5kbWFfc3RhcnRfbGVuZ3RoICA9IDE7DQo+ID4gKyAgICBhc2MtPm5y
ZWdzICAgICAgICAgICAgID0gQVNQRUVEX1NNQ19SX01BWDsNCj4gPiArICAgIGFzYy0+c2VnbWVu
dF90b19yZWcgICAgPSBhc3BlZWRfMjcwMF9zbWNfc2VnbWVudF90b19yZWc7DQo+ID4gKyAgICBh
c2MtPnJlZ190b19zZWdtZW50ICAgID0gYXNwZWVkXzI3MDBfc21jX3JlZ190b19zZWdtZW50Ow0K
PiA+ICsgICAgYXNjLT5kbWFfY3RybCAgICAgICAgICA9IGFzcGVlZF8yNjAwX3NtY19kbWFfY3Ry
bDsNCj4gPiArICAgIGFzYy0+cmVnX29wcyAgICAgICAgICAgPSAmYXNwZWVkXzI3MDBfc21jX2Zs
YXNoX29wczsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IEFzcGVlZFNlZ21lbnRz
IGFzcGVlZF8xMDQwX3NwaTBfc2VnbWVudHNbXSA9IHsNCj4gPiArICAgIHsgMHgwLCAxMjggKiBN
aUIgfSwNCj4gPiArICAgIHsgMTI4ICogTWlCLCAxMjggKiBNaUIgfSwNCj4gPiArICAgIHsgMjU2
ICogTWlCLCAxMjggKiBNaUIgfSwNCj4gPiArICAgIHsgMzg0ICogTWlCLCAxMjggKiBNaUIgfSwN
Cj4gPiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyB2b2lkIGFzcGVlZF8xMDQwX3NwaTBfY2xhc3Nf
aW5pdChPYmplY3RDbGFzcyAqa2xhc3MsIGNvbnN0DQo+ID4gK3ZvaWQgKmRhdGEpIHsNCj4gPiAr
ICAgIERldmljZUNsYXNzICpkYyA9IERFVklDRV9DTEFTUyhrbGFzcyk7DQo+ID4gKyAgICBBc3Bl
ZWRTTUNDbGFzcyAqYXNjID0gQVNQRUVEX1NNQ19DTEFTUyhrbGFzcyk7DQo+ID4gKw0KPiA+ICsg
ICAgZGMtPmRlc2MgICAgICAgICAgICAgICA9ICJBc3BlZWQgMTA0MCBTUEkwIENvbnRyb2xsZXIi
Ow0KPiA+ICsgICAgYXNjLT5yX2NvbmYgICAgICAgICAgICA9IFJfQ09ORjsNCj4gPiArICAgIGFz
Yy0+cl9jZV9jdHJsICAgICAgICAgPSBSX0NFX0NUUkw7DQo+ID4gKyAgICBhc2MtPnJfY3RybDAg
ICAgICAgICAgID0gUl9DVFJMMDsNCj4gPiArICAgIGFzYy0+cl90aW1pbmdzICAgICAgICAgPSBS
X1RJTUlOR1M7DQo+ID4gKyAgICBhc2MtPm5yZWdzX3RpbWluZ3MgICAgID0gNDsNCj4gPiArICAg
IGFzYy0+Y29uZl9lbmFibGVfdzAgICAgPSBDT05GX0VOQUJMRV9XMDsNCj4gPiArICAgIGFzYy0+
Y3NfbnVtX21heCAgICAgICAgPSA0Ow0KPiA+ICsgICAgYXNjLT5zZWdtZW50cyAgICAgICAgICA9
IGFzcGVlZF8xMDQwX3NwaTBfc2VnbWVudHM7DQo+ID4gKyAgICBhc2MtPnNlZ21lbnRfYWRkcl9t
YXNrID0gMHhmZmZmZmZmZjsNCj4gPiArICAgIGFzYy0+Zmxhc2hfd2luZG93X2Jhc2UgPSAweEEw
MDAwMDAwOw0KPiA+ICsgICAgYXNjLT5mbGFzaF93aW5kb3dfc2l6ZSA9IDUxMiAqIE1pQjsNCj4g
PiArICAgIGFzYy0+ZmVhdHVyZXMgICAgICAgICAgPSBBU1BFRURfU01DX0ZFQVRVUkVfRE1BIHwN
Cj4gPiArDQo+IEFTUEVFRF9TTUNfRkVBVFVSRV9ETUFfRFJBTV9BRERSX0hJR0g7DQo+ID4gKyAg
ICBhc2MtPmRtYV9mbGFzaF9tYXNrICAgID0gMHgxRkZGRkZGQzsNCj4gPiArICAgIGFzYy0+ZG1h
X2RyYW1fbWFzayAgICAgPSAweDAwRkZGRkZDOw0KPiA+ICsgICAgYXNjLT5kbWFfc3RhcnRfbGVu
Z3RoICA9IDE7DQo+ID4gKyAgICBhc2MtPm5yZWdzICAgICAgICAgICAgID0gQVNQRUVEX1NNQ19S
X01BWDsNCj4gPiArICAgIGFzYy0+c2VnbWVudF90b19yZWcgICAgPSBhc3BlZWRfMjcwMF9zbWNf
c2VnbWVudF90b19yZWc7DQo+ID4gKyAgICBhc2MtPnJlZ190b19zZWdtZW50ICAgID0gYXNwZWVk
XzI3MDBfc21jX3JlZ190b19zZWdtZW50Ow0KPiA+ICsgICAgYXNjLT5kbWFfY3RybCAgICAgICAg
ICA9IGFzcGVlZF8yNjAwX3NtY19kbWFfY3RybDsNCj4gPiArICAgIGFzYy0+cmVnX29wcyAgICAg
ICAgICAgPSAmYXNwZWVkXzI3MDBfc21jX2ZsYXNoX29wczsNCj4gPiArfQ0KPiA+ICsNCj4gPiAr
c3RhdGljIHZvaWQgYXNwZWVkXzEwNDBfc3BpMV9jbGFzc19pbml0KE9iamVjdENsYXNzICprbGFz
cywgY29uc3QNCj4gPiArdm9pZCAqZGF0YSkgew0KPiA+ICsgICAgRGV2aWNlQ2xhc3MgKmRjID0g
REVWSUNFX0NMQVNTKGtsYXNzKTsNCj4gPiArICAgIEFzcGVlZFNNQ0NsYXNzICphc2MgPSBBU1BF
RURfU01DX0NMQVNTKGtsYXNzKTsNCj4gPiArDQo+ID4gKyAgICBkYy0+ZGVzYyAgICAgICAgICAg
ICAgID0gIkFzcGVlZCAxMDQwIFNQSTEgQ29udHJvbGxlciI7DQo+ID4gKyAgICBhc2MtPnJfY29u
ZiAgICAgICAgICAgID0gUl9DT05GOw0KPiA+ICsgICAgYXNjLT5yX2NlX2N0cmwgICAgICAgICA9
IFJfQ0VfQ1RSTDsNCj4gPiArICAgIGFzYy0+cl9jdHJsMCAgICAgICAgICAgPSBSX0NUUkwwOw0K
PiA+ICsgICAgYXNjLT5yX3RpbWluZ3MgICAgICAgICA9IFJfVElNSU5HUzsNCj4gPiArICAgIGFz
Yy0+bnJlZ3NfdGltaW5ncyAgICAgPSAyOw0KPiA+ICsgICAgYXNjLT5jb25mX2VuYWJsZV93MCAg
ICA9IENPTkZfRU5BQkxFX1cwOw0KPiA+ICsgICAgYXNjLT5jc19udW1fbWF4ICAgICAgICA9IDI7
DQo+ID4gKyAgICBhc2MtPnNlZ21lbnRzICAgICAgICAgID0gYXNwZWVkXzI3MDBfc3BpMF9zZWdt
ZW50czsNCj4gPiArICAgIGFzYy0+c2VnbWVudF9hZGRyX21hc2sgPSAweGZmZmZmZmZmOw0KPiA+
ICsgICAgYXNjLT5mbGFzaF93aW5kb3dfYmFzZSA9IDB4QzAwMDAwMDA7DQo+ID4gKyAgICBhc2Mt
PmZsYXNoX3dpbmRvd19zaXplID0gNTEyICogTWlCOw0KPiA+ICsgICAgYXNjLT5mZWF0dXJlcyAg
ICAgICAgICA9IEFTUEVFRF9TTUNfRkVBVFVSRV9ETUEgfA0KPiA+ICsNCj4gQVNQRUVEX1NNQ19G
RUFUVVJFX0RNQV9EUkFNX0FERFJfSElHSDsNCj4gPiArICAgIGFzYy0+ZG1hX2ZsYXNoX21hc2sg
ICAgPSAweDFGRkZGRkZDOw0KPiA+ICsgICAgYXNjLT5kbWFfZHJhbV9tYXNrICAgICA9IDB4MDBG
RkZGRkM7DQo+ID4gKyAgICBhc2MtPmRtYV9zdGFydF9sZW5ndGggID0gMTsNCj4gPiArICAgIGFz
Yy0+bnJlZ3MgICAgICAgICAgICAgPSBBU1BFRURfU01DX1JfTUFYOw0KPiA+ICsgICAgYXNjLT5z
ZWdtZW50X3RvX3JlZyAgICA9IGFzcGVlZF8yNzAwX3NtY19zZWdtZW50X3RvX3JlZzsNCj4gPiAr
ICAgIGFzYy0+cmVnX3RvX3NlZ21lbnQgICAgPSBhc3BlZWRfMjcwMF9zbWNfcmVnX3RvX3NlZ21l
bnQ7DQo+ID4gKyAgICBhc2MtPmRtYV9jdHJsICAgICAgICAgID0gYXNwZWVkXzI2MDBfc21jX2Rt
YV9jdHJsOw0KPiA+ICsgICAgYXNjLT5yZWdfb3BzICAgICAgICAgICA9ICZhc3BlZWRfMjcwMF9z
bWNfZmxhc2hfb3BzOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICAgc3RhdGljIGNvbnN0IFR5cGVJbmZv
IGFzcGVlZF9zbWNfdHlwZXNbXSA9IHsNCj4gPiAgICAgICB7DQo+ID4gICAgICAgICAgIC5uYW1l
ICAgICAgICAgICA9IFRZUEVfQVNQRUVEX1NNQ19GTEFTSCwNCj4gPiBAQCAtMjEwMyw2ICsyMTk3
LDIxIEBAIHN0YXRpYyBjb25zdCBUeXBlSW5mbyBhc3BlZWRfc21jX3R5cGVzW10gPSB7DQo+ID4g
ICAgICAgICAgIC5wYXJlbnQgICAgID0gVFlQRV9BU1BFRURfU01DLA0KPiA+ICAgICAgICAgICAu
Y2xhc3NfaW5pdCA9IGFzcGVlZF8xMDMwX3NwaTJfY2xhc3NfaW5pdCwNCj4gPiAgICAgICB9LA0K
PiA+ICsgICAgew0KPiA+ICsgICAgICAgIC5uYW1lICAgICAgID0gImFzcGVlZC5mbWMtYXN0MTA0
MCIsDQo+ID4gKyAgICAgICAgLnBhcmVudCAgICAgPSBUWVBFX0FTUEVFRF9TTUMsDQo+ID4gKyAg
ICAgICAgLmNsYXNzX2luaXQgPSBhc3BlZWRfMTA0MF9mbWNfY2xhc3NfaW5pdCwNCj4gPiArICAg
IH0sDQo+ID4gKyAgICB7DQo+ID4gKyAgICAgICAgLm5hbWUgICAgICAgPSAiYXNwZWVkLnNwaTAt
YXN0MTA0MCIsDQo+ID4gKyAgICAgICAgLnBhcmVudCAgICAgPSBUWVBFX0FTUEVFRF9TTUMsDQo+
ID4gKyAgICAgICAgLmNsYXNzX2luaXQgPSBhc3BlZWRfMTA0MF9zcGkwX2NsYXNzX2luaXQsDQo+
ID4gKyAgICB9LA0KPiA+ICsgICAgew0KPiA+ICsgICAgICAgIC5uYW1lICAgICAgID0gImFzcGVl
ZC5zcGkxLWFzdDEwNDAiLA0KPiA+ICsgICAgICAgIC5wYXJlbnQgICAgID0gVFlQRV9BU1BFRURf
U01DLA0KPiA+ICsgICAgICAgIC5jbGFzc19pbml0ID0gYXNwZWVkXzEwNDBfc3BpMV9jbGFzc19p
bml0LA0KPiA+ICsgICAgfSwNCj4gPiAgICAgICB7DQo+ID4gICAgICAgICAgIC5uYW1lICAgICAg
ID0gImFzcGVlZC5zbWMtYXN0MjQwMCIsDQo+ID4gICAgICAgICAgIC5wYXJlbnQgICAgID0gVFlQ
RV9BU1BFRURfU01DLA0KPiANCj4gDQo+IG5vIG5lZWQgZm9yIGFzdDEwNDAgc3BlY2lmaWMgYXNj
LT5yZXNldHMgPw0KPiANClRoYW5rcyBmb3IgdGhlIHJldmlldyBhbmQgc3VnZ2VzdGlvbi4NCldp
bGwgYWRkLg0KDQpKYW1pbg0KDQo+IEMuDQo=

