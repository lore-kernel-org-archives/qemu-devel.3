Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17AA5C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 07:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqSGt-0002lj-T8; Fri, 07 Mar 2025 02:37:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tqSGc-0002ky-Oz; Fri, 07 Mar 2025 02:37:12 -0500
Received: from mail-sg2apc01on20713.outbound.protection.outlook.com
 ([2a01:111:f403:200f::713]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tqSGZ-0006Gv-CJ; Fri, 07 Mar 2025 02:37:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jUCnlPz9C7pjZqiQV6VrmE5MxkjkgJvOWaiCbF+n5jTydvUAQQ9uIIVM/y/7wB9WOzwHdodV3J6CxyGtGwJPobJMLcij+F2ifdOjXnelONnmnZyvvfOdOfOunbnlFn4yfLeQlE9hSlDBdR1dlSyzcRwy5xxCop/3guZK//VWum9EesZ5ttaf0pGG6rFX2ldvKLTs19H6pjX9YybkTt/RpUR6ILfap28jRVpI9xY3blcIt2S9kCm+stFaXy5JSv0vFPx/BtakJ/HakzaNAQAWC5GdhBQy6Ay8P5SzVH2mT5/8Fk3QjB9bcStKQGc5uVd7IA9jZpIK6w7/9N2mMpZlEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZj4EY9JE2VftDr8GC64FWGWq3TtE2MdYvw4OeVa/qY=;
 b=hkvjpVdRmp0OROpLG2PoGyHOxfHwNdY9unZX24YxtvFsz+buKpypsgsMlPQgkEtlrI3aXswLFrbmQkwsB8ksE6nXOsIpNbgyOkgrhpikE04GbAV+z6nAJJZPWOnrsyGC9fN5gI8O/7wb/sXPULpy/QMvDqYycYhYR6YoxgU1PhrMq7/iBKlj2R6JBU3Z7x6sVPSphGLnNCGbDeI8yNTt6JbGHtbI1Nh8Iw4KSYM/YxNZvds6wz76i1Fn/5eM+W1A01CJKnae2D3YTEPIxBBUHbw71OfoFYJNcDxdcLBqjwIv+JO/6yVS8oBuAm99lS94rksSKGTabJzri2hTHZITCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZj4EY9JE2VftDr8GC64FWGWq3TtE2MdYvw4OeVa/qY=;
 b=k7tSy8FafbGIMk++7GRjtocki4HnLdBVV1IxCsRtjjIPYWr2zg7J5H0L5VCRZ2tXN07S4J62j95087p+bwUcO1Pe58IfNZPk3/TgPKR1aks0oXD9sR0FTOinKngVPf+oW3DxXaLYbIiUYzhdTlzwUoFISetgb0bfU0/SJx2EzM8UuIfkEJ95MAsR/wyWLyZfT3zg3Oj8KM17KTnX0Z1xPOvIaR7lMOFNVSN5xAFx43SlPqw4Z0liV+kgQNWm30meYN5cZVO3rXPEcKnbZI+5XzIeSph1Tlxy7G2bu//ooJ20Ei5mqB0eRfEZGVZUwRJKqWT8bfn4YaDnuTPo8CtEMw==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYSPR06MB6647.apcprd06.prod.outlook.com (2603:1096:400:483::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 07:36:52 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 07:36:52 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v6 00/29] Support AST2700 A1
Thread-Topic: [PATCH v6 00/29] Support AST2700 A1
Thread-Index: AQHbjxVhokK9+Rryr0aEF5QbRevTYbNnSEIAgAAASqA=
Date: Fri, 7 Mar 2025 07:36:51 +0000
Message-ID: <SI2PR06MB5041DD86414B93AB1C77C759FCD52@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250307035945.3698802-1-jamin_lin@aspeedtech.com>
 <3485cd84-2aab-45e7-a72c-ca1d85e007ec@kaod.org>
In-Reply-To: <3485cd84-2aab-45e7-a72c-ca1d85e007ec@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYSPR06MB6647:EE_
x-ms-office365-filtering-correlation-id: 5d396415-724d-4919-e079-08dd5d4ad3d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?RW5HNm1CekdoUHpzRmdyZEVxUjVzUTM5SGw1ZVZVd2c5dE5WN3RaWmR4alJE?=
 =?utf-8?B?ZkJ1aERLaCszVUQxZlcxNGtHTGpIOXVGQlJKV3VJQ3Rxcy9ZcE9LRElzU24v?=
 =?utf-8?B?ZWlwUlRmYndsbFpTNG4xUDc3Z3QwKzNjZjU2Vk9LV25HdzQwSjJvSUxjY0Ni?=
 =?utf-8?B?a3U0Sm9tOE01dVdvYzdpcGVuYVdEZjR4SHJaTUxCcHpUMWNLQzRPWktsV043?=
 =?utf-8?B?bkxNeTExdS84QllnOXFBVSt3MTVGWlZUODJsUlkwY08zdGJzdEJCSjZOQnoz?=
 =?utf-8?B?L0xMSmpEdEFQMkl6VFVEZ3BKSkVtMzVjL2hxZWFYMlRvV1Ywa0xzaWdQeTFZ?=
 =?utf-8?B?OXV4Y3lGZ2FrT2NGMDVMQ0hDeGQvZmw0R2NJYWJmdHhjb2Y3eFZBeHEza1dM?=
 =?utf-8?B?dWRiUW5XSjBUSmVYVVZvNU5na2NkMlpsWHV2RnVEckdHcm1ZWFN1OGYzNUYv?=
 =?utf-8?B?bSt6NnhLUkJZYmRJQnAzcnBnRC9lRFpGTS90MGE4cjRVYWZuR29Ba3NUZUdX?=
 =?utf-8?B?N0MwalBXbEZqZWMwbXJiaXFHQWpHNVM3M080dHlPSEZ3WSsyd05MZ3hwbEtz?=
 =?utf-8?B?MzdXSjhhZXlkNWsreEdMYkFWYVNGaHlqdElvV3NOVmN6K1pmeVQ0M1d3d2tw?=
 =?utf-8?B?dG0yUTc1NFpSSDl2SHh0TWx6KzhIVmFPYjJSZU1yRDlJLzNwZTRaQTdidEEy?=
 =?utf-8?B?bjhYSUxsRUMrOTNFYTdkb1BPeENkUUx1Q0Y4QWx6YlhIRGxvT3NMaTVwd3hH?=
 =?utf-8?B?by9FQVFxSWpDTGdjdlBYUlhnWi83N25jOWFBdC9kUllPdnFkMmhCTVRrTUJI?=
 =?utf-8?B?WS9PM1c2STd3SFhVSHJXOW9ueTVzaVFjNFY2ZkI4RlIvbGx1K1BEZ1A1THB6?=
 =?utf-8?B?dXVTakQ5cGVQTm03aU5HbUhpdzhZQXpsWGFjNC9zQUhsWnp0MjkybGJMQ1h3?=
 =?utf-8?B?bzE2c2IzWkV5MlhDbXdGVFBPcUM1elhVYmxUSnhnZnRaVWgvLzJjSjlWem4v?=
 =?utf-8?B?b0RDWXpMK0JvSWptbWpQTzYvY3IxcW5mQW5YTng3Tmg0c01za0d1c3BCVzA3?=
 =?utf-8?B?bWxiSldKcXBZQnQ5N0U4OXF6UmNxWWlOUXV1V3F0R2Njanl1Vk5rRE1xWVJ2?=
 =?utf-8?B?ZkVKYXVDUzcrTC9lR1NTUFhPUGNmTi96aVlvSXJLa0FmcEd4cHVMV1N4eDB3?=
 =?utf-8?B?WmZyMTd5ejNLL05wZlNnMVJpRnFrMW16dWt0azd2QlYwSWJDcEtWZnV4MFAy?=
 =?utf-8?B?bDJ3TkU1S0hTMEdKNlB0c2pEYUg3d1pjQ2JwRmt1NHpvUm1wRG5vZ2NTa0JE?=
 =?utf-8?B?Qmx1QXBFVW40T0hZeVd3UGoweXg0dGFWWFp1SFZVOTlJNllFRVNrVGdkbi9h?=
 =?utf-8?B?alBxK3o2SEovM1hoT3ExOHQ5UWRUTjdZQWdYdlNqMHZnb3Vhck5nK0VRU3Vv?=
 =?utf-8?B?TWZrdTNDZklNOHBIWVNRb1ZJR2xBaklKV0dCY2tDZ25yQk9JMFhqQmhXVllr?=
 =?utf-8?B?K0N5RElQVXV3SXdlb01HN0N2NnJjUGZ3dFRRNkVrQmpaaURuYnpNV29nelA1?=
 =?utf-8?B?TFYzQThQelBET2R2WTgxNStLZHpqRXloZWVjZVduUXl3bEVwQVZhOEhBWExP?=
 =?utf-8?B?MHBJL2VZVTNNOGRZWWx2bk93cnFWaG1ab2IyVlNJT2h4NDZxMmRaRmcxUnQ3?=
 =?utf-8?B?NWZwSUFYWVo0K3dlNFM0V01laG5hUXA4ZWZCRUd2SEM4WnorQXhQcFdNZ1J1?=
 =?utf-8?B?TXFIMHlkNWc0SzJaWWo4cUs0U1BRM1Z2bTNIRE5TZTlnc3IzK0xUOTE5TGI0?=
 =?utf-8?B?eVB1aW4ybVN6emQwRDVxRWhMZnE3SzNvMEhCM0l0T0pKd1UrRzZJd0dwV1NU?=
 =?utf-8?B?OEsyYzBCSFF5OVFXazNZd3pkRGxuOHg3RGV3WHB5d2RQRkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(13003099007)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3F2T29Sc3l5MkM4TGJ0M1IwaGdqU1VlY1Z4TjNHL0dUUmUyc2VLSGdyMFk2?=
 =?utf-8?B?N2h6dGhLMk5Hb0I3TEUveFdaYWN2cFJHblVURVF5TkZWc3RqTHB0dWhOVEpJ?=
 =?utf-8?B?dnNNS3R3ckZqNEdtQm1qVzZQc3J0RzRzclJFcjNmSHVyV1VvcTJIZ0t1MHhn?=
 =?utf-8?B?TkJtOXVaWnhNekRnOTM4UXgzcktoRG0zdTYvUHlheXBSWnVUR1hWT084ZURF?=
 =?utf-8?B?OTlXOWxsVlFQVG5DNGhLaThaNTErK25TU2lpUFdNSldYYjJFV21sS0o1Ykgz?=
 =?utf-8?B?ODFJNnc0a1ZyblN1aVd6ZCtpTWxKaTZjdGVYdjFVTjhpczc2Yk5ZbjFWNnBY?=
 =?utf-8?B?MkgxcEFlZjc0bCtUaUMrZ1I3V0twM3Y2NG1uVUEvWUh6NnVXRmpBYjZ6QUln?=
 =?utf-8?B?TzZmc2RvWnVaZTE5dXRSbkZNRXZIekhFZnNVenhNcVpiQ2x3NUg3VHEzMHlT?=
 =?utf-8?B?Qi83UDk5QU9QRHdrMGRveEFFQVZCVXVTZXlFRWFtWFJIcEQzalFyeWVPNWk3?=
 =?utf-8?B?UlhRd1R3allZQTdpY1p3MUNhcEtRdFJWRTJwSXhkSHF3LzduaHhDSnRZbk9i?=
 =?utf-8?B?WEp5L0psc3FLTzJUTFQ4VmdTN0RiZUVsRkhtOTJ2dm9hQU1WWEVpaFRwQ29R?=
 =?utf-8?B?UU9zaGRlVDdzSzNoQmc5Ymc4Y3duM0h2TUxrY0R4bzdCLzRwR0g0Z3k5ak53?=
 =?utf-8?B?OE9aVUdDNmlZMExSeGgzc2gyTXd2VnZrUUtTUUhWR0I2eGZlTG1LS0hJU0E1?=
 =?utf-8?B?bWJVSXdhb0F2UFE4NU9zNUUvQm0xQUgwWlV2VEplVDhrZlJybUR2a2JKNmFT?=
 =?utf-8?B?NlpyNDgwci82VkhMMjdIdWlzUTkwOE9DbmlZYTl2dWt5QnRtczd2WEFUSnZS?=
 =?utf-8?B?dEI4MmFRUDN0dEpkcDZ5dXAyRjZlazBVRkl6RmFEeHViUVhvWlRZS0RxRnlE?=
 =?utf-8?B?Ulh5a0lsZ2VnL1dxVVdBRnNqOEZIZUhENnZ2d2FzRFlWRDdwTml0ZTRiaG5U?=
 =?utf-8?B?MXloTHhiVCt4TytKZEpLd05kYzIvdUZsOHJsK0VlTG4xUVphWmNUeVh1c1Z2?=
 =?utf-8?B?OHgzQmFRTS9VZlplcTN5b3pvd1ZGYk1SQnJhU1RwbHkwQnJRZ3JrcU5IeCs2?=
 =?utf-8?B?QWZxSGJnditEOVBqaHlOZHdpZ0FuS2xFczVxcDdKdVFDV1B0NE9FaVZqQUk4?=
 =?utf-8?B?Nnp1K2ZLOHlZbUg4dDRXa0F2R3BxUlc1ejA2bVZNaFZvZWdjSHZKejJtQWVK?=
 =?utf-8?B?NElEMzByUHNXejBabG9TWkxLZDhDajRBL1cvYUlVR0prWXpQNi9DRFFZdUh4?=
 =?utf-8?B?dHlad0NxZ1NCVDVmcmx1N2FFcTljaWZRbFl0Ukp6V2JjVWFXdElKa3JZSDNL?=
 =?utf-8?B?czRmSnpaM29MMktqbk9tOHlWTmRmLzJiMkxBOXdrOHpZQk5ETi9NMmtKTDZr?=
 =?utf-8?B?dXkzNmxyc1RQZVh1OWZ4MG1VZEUybDJRUDdMSzROOCswZC9QUEQvN3hmUVhY?=
 =?utf-8?B?dllpS1pGRjZMa0k2WUNreDIzU2ttWURBL0gyME5HMDdOdWNlTXV4RFNXU1gw?=
 =?utf-8?B?bmJHbCtVQkMxNFg5YjFHVFNFdFMwTDgweUNreXdjL0F4MFBqclJZb2Q0K2k5?=
 =?utf-8?B?YzFsZHIwQjNseHNEK0NpVFdhRTZKbTNyNU40aDBPcmlIUklkemRwb0t0djhG?=
 =?utf-8?B?Mm5Bd0JtSDVNOXNPM2NHczRMWnBhcjVKa3JsS0ZuN3RnNDJHUC92Ymk1WXdC?=
 =?utf-8?B?bjRhWmQ1WGozWnNjUE8vc3BUVTBwazFUcnVlZzA3OFRtaVlCeVZBK1VRTmxF?=
 =?utf-8?B?ZjZnV0p5WmdrblI4TzJmakZWVW9wWDVuSkN5N0JMd24valdLbTEvaU5IQWFV?=
 =?utf-8?B?WFN4TjU2OGJwS2RFV084OUNqWml4S29PQUZtWlpiYnVyTEV1ejRpeFBhV1BL?=
 =?utf-8?B?Rm94NjZoVTdiYzdDWFl4Y2ZOdldMNjVhTUQxbjBieGUzRVJNOXNXbUhVRFlo?=
 =?utf-8?B?TEhhaUMvaXVCRnFCU2Y2MkQ1dHQxVlRvUGpNR0ZyVnA5cy9xZXRudy8rcU04?=
 =?utf-8?B?SlQ3c21KM0RTTzM5YVMyOUdqQ2Z4RXI1OHJ2WURNQis0VXNhWWd1TG15K0FE?=
 =?utf-8?Q?DG9BGR0Zrn6Dmr8HjpzMtRsMU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d396415-724d-4919-e079-08dd5d4ad3d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 07:36:51.9328 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CQmzpV9HRCYIhAsQswoffUeUTtyFV19s0ZMymh4zCYM1G1t5yRS1mKTZTo6rPbPwS5un6EGvZ4PMCtIdIECWcnnnef9JnW/RICWKVIVaXiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6647
Received-SPF: pass client-ip=2a01:111:f403:200f::713;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
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

SGkgQ2VkcmljLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMDAvMjldIFN1cHBvcnQgQVNU
MjcwMCBBMQ0KPiANCj4gT24gMy83LzI1IDA0OjU5LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gdjE6
DQo+ID4gICAxLiBSZWZhY3RvciBJTlRDIG1vZGVsIHRvIHN1cHBvcnQgYm90aCBJTlRDMCBhbmQg
SU5UQzEuDQo+ID4gICAyLiBTdXBwb3J0IEFTVDI3MDAgQTEuDQo+ID4gICAzLiBDcmVhdGUgYXN0
MjcwMGEwLWV2YiBtYWNoaW5lLg0KPiA+DQo+ID4gdjI6DQo+ID4gICAgVG8gc3RyZWFtbGluZSB0
aGUgcmV2aWV3IHByb2Nlc3MsIHNwbGl0IHRoZSBmb2xsb3dpbmcgcGF0Y2ggc2VyaWVzIGludG8N
Cj4gPiAgICB0aHJlZSBwYXJ0cy4NCj4gPg0KPiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3Jn
L3Byb2plY3QvcWVtdS1kZXZlbC9jb3Zlci8yMDI1MDEyMTA3MDQyNC4yNDYNCj4gNTk0Mi0xLWph
bWluX2xpbkBhc3BlZWR0ZWNoLmNvbS8NCj4gPiAgICBUaGlzIHBhdGNoIHNlcmllcyBmb2N1c2Vz
IG9uIGNsZWFuaW5nIHVwIHRoZSBJTlRDIG1vZGVsIHRvDQo+ID4gICAgZmFjaWxpdGF0ZSBmdXR1
cmUgc3VwcG9ydCBmb3IgdGhlIElOVENfSU8gbW9kZWwuDQo+ID4NCj4gPiB2MzoNCj4gPiAgIDEu
IFVwZGF0ZSBhbmQgYWRkIGZ1bmN0aW9uYWwgdGVzdCBmb3IgQVNUMjcwMA0KPiA+ICAgMi4gQWRk
IEFTVDI3MDAgSU5UQyBkZXNpZ24gZ3VpZGFuY2UgYW5kIGl0cyBibG9jayBkaWFncmFtLg0KPiA+
ICAgMy4gUmV0YWluaW5nIHRoZSBJTlRDIG5hbWluZyBhbmQgaW50cm9kdWNpbmcgYSBuZXcgSU5U
Q0lPIG1vZGVsIHRvDQo+IHN1cHBvcnQgdGhlIEFTVDI3MDAgQTEuDQo+ID4gICA0LiBDcmVhdGUg
YXN0MjcwMGExLWV2YiBtYWNoaW5lIGFuZCByZW5hbWUgYXN0MjcwMGEwLWV2YiBtYWNoaW5lDQo+
ID4gICA1LiBGaXggc2lsaWNvbiByZXZpc2lvbiBpc3N1ZSBhbmQgc3VwcG9ydCBBU1QyNzAwIEEx
Lg0KPiA+DQo+ID4gdjQ6DQo+ID4gICAxLiByZXdvcmsgZnVuY3Rpb25hbCB0ZXN0IGZvciBBU1Qy
NzAwDQo+ID4gICAyLiB0aGUgaW5pdGlhbCBtYWNoaW5lICJhc3QyNzAwLWV2YiIgaXMgYWxpYXNl
ZCB0byAiYXN0MjcwMGEwLWV2Yi4NCj4gPiAgIDMuIGludGM6IFJlZHVjZSByZWdzIGFycmF5IHNp
emUgYnkgYWRkaW5nIGEgcmVnaXN0ZXIgc3ViLXJlZ2lvbg0KPiA+ICAgNC4gaW50Yzogc3BsaXQg
cGF0Y2ggZm9yIFN1cHBvcnQgc2V0dGluZyBkaWZmZXJlbnQgcmVnaXN0ZXIgc2l6ZXMNCj4gPiAg
IDUuIHVwZGF0ZSBhc3QyNzAwYTEtZXZiIG1hY2hpbmUgcGFyZW50IHRvIFRZUEVfQVNQRUVEX01B
Q0hJTkUNCj4gPg0KPiA+IHY1Og0KPiA+ICAgMS4gUmVuYW1lIHN0YXR1c19hZGRyIGFuZCBhZGRy
IHRvIHN0YXR1c19yZWcgYW5kIHJlZyBmb3IgY2xhcml0eQ0KPiA+ICAgMi4gSW50cm9kdWNlIGR5
bmFtaWMgYWxsb2NhdGlvbiBmb3IgcmVncyBhcnJheQ0KPiA+ICAgMy4gU29ydCB0aGUgbWVtbWFw
IHRhYmxlIGJ5IG1hcHBpbmcgYWRkcmVzcw0KPiA+ICAgNC4gYXN0Mjd4MC5jIHNwbGl0IHBhdGNo
IGZvciBTdXBwb3J0IHR3byBsZXZlbHMgb2YgSU5UQyBjb250cm9sbGVycyBmb3INCj4gQVNUMjcw
MCBBMQ0KPiA+ICAgNS4gdGVzdHMvZnVuY3Rpb25hbC9hc3BwZWQgc3BsaXQgcGF0Y2ggZm9yIElu
dHJvZHVjZSBzdGFydF9hc3QyNzAwX3Rlc3QgQVBJDQo+ID4gICA2LiBrZWVwIHZhcmlhYmxlIG5h
bWluZyBmb3IgcmV2aWV3ZXIgc3VnZ2VzdGlvbi4NCj4gPiAgIDcuIEFkZCByZXZpZXdlciBzdWdn
ZXN0aW9uIGFuZCBzcGxpdCBwYXRjaCB0byBtYWtlIG1vcmUgcmVhZGFibGUuDQo+ID4NCj4gPiB2
NjoNCj4gPiAgICAxLiByZW5hbWUgcmVnX3NpemUgdG8gbnJfcmVncw0KPiA+ICAgIDIuIEZpeCBj
bGVhbiByZWdzIHNpemUNCj4gPiAgICAzLiByZXBsYWNlIGdfbWFsbG9jIHdpdGggZ19uZXcNCj4g
Pg0KPiA+IFdpdGggdGhlIHBhdGNoIGFwcGxpZWQsIFFFTVUgbm93IHN1cHBvcnRzIHR3byBtYWNo
aW5lcyBmb3IgcnVubmluZw0KPiBBU1QyNzAwIFNvQ3M6DQo+ID4gYXN0MjcwMGEwLWV2YjogRGVz
aWduZWQgZm9yIEFTVDI3MDAgQTANCj4gPiBhc3QyNzAwYTEtZXZiOiBEZXNpZ25lZCBmb3IgQVNU
MjcwMCBBMQ0KPiA+DQo+ID4gVGVzdCBpbmZvcm1hdGlvbg0KPiA+IDEuIFFFTVUgdmVyc2lvbjoN
Cj4gaHR0cHM6Ly9naXRodWIuY29tL3FlbXUvcWVtdS9jb21taXQvNTBkMzhiODkyMTgzNzgyN2Vh
Mzk3ZDRiMjBjOGJjDQo+IDVlZmUxODZlNTMNCj4gPiAyLiBBU1BFRUQgU0RLIHYwOS4wNSBwcmUt
YnVpbHQgaW1hZ2UNCj4gPiAgICAgaHR0cHM6Ly9naXRodWIuY29tL0FzcGVlZFRlY2gtQk1DL29w
ZW5ibWMvcmVsZWFzZXMvdGFnL3YwOS4wNQ0KPiA+ICAgICBhc3QyNzAwLWRlZmF1bHQtb2JtYy50
YXIuZ3ogKEFTVDI3MDAgQTEpDQo+ID4NCj4gaHR0cHM6Ly9naXRodWIuY29tL0FzcGVlZFRlY2gt
Qk1DL29wZW5ibWMvcmVsZWFzZXMvZG93bmxvYWQvdjA5LjA1L2FzdA0KPiAyNzAwLWRlZmF1bHQt
b2JtYy50YXIuZ3oNCj4gPiAgICAgYXN0MjcwMC1hMC1kZWZhdWx0LW9ibWMudGFyLmd6IChBU1Qy
NzAwIEEwKQ0KPiA+DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9Bc3BlZWRUZWNoLUJNQy9vcGVuYm1j
L3JlbGVhc2VzL2Rvd25sb2FkL3YwOS4wNS9hc3QNCj4gMjcwMC1hMC1kZWZhdWx0LW9ibWMudGFy
Lmd6DQo+ID4NCj4gPiBUaGlzIHBhdGNoIHNlcmllcyBkZXBlbmRzIG9uIHRoZSBmb2xsb3dpbmcg
cGF0Y2ggc2VyaWVzOg0KPiA+DQo+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVj
dC9xZW11LWRldmVsL2NvdmVyLzIwMjUwMzA0MDY0NzEwLjIxMg0KPiA4OTkzLTEtamFtaW5fbGlu
QGFzcGVlZHRlY2guY29tLw0KPiA+DQo+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJv
amVjdC9xZW11LWRldmVsL2NvdmVyLzIwMjUwMjI1MDc1NjIyLjMwNQ0KPiA1MTUtMS1qYW1pbl9s
aW5AYXNwZWVkdGVjaC5jb20vDQo+ID4NCj4gPiBKYW1pbiBMaW4gKDI5KToNCj4gPiAgICBody9p
bnRjL2FzcGVlZDogU3VwcG9ydCBzZXR0aW5nIGRpZmZlcmVudCBtZW1vcnkgc2l6ZQ0KPiA+ICAg
IGh3L2ludGMvYXNwZWVkOiBSZW5hbWUgc3RhdHVzX2FkZHIgYW5kIGFkZHIgdG8gc3RhdHVzX3Jl
ZyBhbmQgcmVnIGZvcg0KPiA+ICAgICAgY2xhcml0eQ0KPiA+ICAgIGh3L2ludGMvYXNwZWVkOiBJ
bnRyb2R1Y2UgZHluYW1pYyBhbGxvY2F0aW9uIGZvciByZWdzIGFycmF5DQo+ID4gICAgaHcvaW50
Yy9hc3BlZWQ6IFN1cHBvcnQgc2V0dGluZyBkaWZmZXJlbnQgcmVnaXN0ZXIgc2l6ZQ0KPiA+ICAg
IGh3L2ludGMvYXNwZWVkOiBSZWR1Y2UgcmVncyBhcnJheSBzaXplIGJ5IGFkZGluZyBhIHJlZ2lz
dGVyIHN1Yi1yZWdpb24NCj4gPiAgICBody9pbnRjL2FzcGVlZDogSW50cm9kdWNlIGhlbHBlciBm
dW5jdGlvbnMgZm9yIGVuYWJsZSBhbmQgc3RhdHVzDQo+ID4gICAgICByZWdpc3RlcnMNCj4gPiAg
ICBody9pbnRjL2FzcGVlZDogQWRkIG9iamVjdCB0eXBlIG5hbWUgdG8gdHJhY2UgZXZlbnRzIGZv
ciBiZXR0ZXINCj4gPiAgICAgIGRlYnVnZ2luZw0KPiA+ICAgIGh3L2FybS9hc3BlZWQ6IFJlbmFt
ZSBJUlEgdGFibGUgYW5kIG1hY2hpbmUgbmFtZSBmb3IgQVNUMjcwMCBBMA0KPiA+ICAgIGh3L2Fy
bS9hc3BlZWRfYXN0Mjd4MDogU29ydCB0aGUgSVJRIHRhYmxlIGJ5IElSUSBudW1iZXINCj4gPiAg
ICBody9pbnRjL2FzcGVlZDogU3VwcG9ydCBkaWZmZXJlbnQgbWVtb3J5IHJlZ2lvbiBvcHMNCj4g
PiAgICBody9pbnRjL2FzcGVlZDogUmVuYW1lIG51bV9pbnRzIHRvIG51bV9pbnBpbnMgZm9yIGNs
YXJpdHkNCj4gPiAgICBody9pbnRjL2FzcGVlZDogQWRkIHN1cHBvcnQgZm9yIG11bHRpcGxlIG91
dHB1dCBwaW5zIGluIElOVEMNCj4gPiAgICBody9pbnRjL2FzcGVlZDogUmVmYWN0b3IgSU5UQyB0
byBzdXBwb3J0IHNlcGFyYXRlIGlucHV0IGFuZCBvdXRwdXQgcGluDQo+ID4gICAgICBpbmRpY2Vz
DQo+ID4gICAgaHcvaW50Yy9hc3BlZWQ6IEludHJvZHVjZSBBc3BlZWRJTlRDSVJRIHN0cnVjdHVy
ZSB0byBzYXZlIHRoZSBpcnENCj4gPiAgICAgIGluZGV4IGFuZCByZWdpc3RlciBhZGRyZXNzDQo+
ID4gICAgaHcvaW50Yy9hc3BlZWQ6IEludHJvZHVjZSBJUlEgaGFuZGxlciBmdW5jdGlvbiB0byBy
ZWR1Y2UgY29kZQ0KPiA+ICAgICAgZHVwbGljYXRpb24NCj4gPiAgICBody9pbnRjL2FzcGVlZDog
QWRkIFN1cHBvcnQgZm9yIE11bHRpLU91dHB1dCBJUlEgSGFuZGxpbmcNCj4gPiAgICBody9pbnRj
L2FzcGVlZDogQWRkIFN1cHBvcnQgZm9yIEFTVDI3MDAgSU5UQ0lPIENvbnRyb2xsZXINCj4gPiAg
ICBody9taXNjL2FzcGVlZF9zY3U6IEFkZCBTdXBwb3J0IGZvciBBU1QyNzAwL0FTVDI3NTAgQTEg
U2lsaWNvbg0KPiA+ICAgICAgUmV2aXNpb25zDQo+ID4gICAgaHcvYXJtL2FzcGVlZF9hc3QyN3gw
LmMgU3VwcG9ydCBBU1QyNzAwIEExIEdJQyBJbnRlcnJ1cHQgTWFwcGluZw0KPiA+ICAgIGh3L2Fy
bS9hc3BlZWRfYXN0Mjd4MDogRGVmaW5lIGFuIEFycmF5IG9mIEFzcGVlZElOVENTdGF0ZSB3aXRo
IFR3bw0KPiA+ICAgICAgSW5zdGFuY2VzDQo+ID4gICAgaHcvYXJtL2FzcGVlZF9hc3QyN3gwOiBT
dXBwb3J0IHR3byBsZXZlbHMgb2YgSU5UQyBjb250cm9sbGVycyBmb3INCj4gPiAgICAgIEFTVDI3
MDAgQTENCj4gPiAgICBody9hcm0vYXNwZWVkX2FzdDI3eDA6IEFkZCBTb0MgU3VwcG9ydCBmb3Ig
QVNUMjcwMCBBMQ0KPiA+ICAgIGh3L2FybS9hc3BlZWQ6IEFkZCBNYWNoaW5lIFN1cHBvcnQgZm9y
IEFTVDI3MDAgQTENCj4gPiAgICBody9hcm0vYXNwZWVkX2FzdDI3eDA6IFNvcnQgdGhlIG1lbW1h
cCB0YWJsZSBieSBtYXBwaW5nIGFkZHJlc3MNCj4gPiAgICB0ZXN0cy9mdW5jdGlvbmFsL2FzcGVl
ZDogSW50cm9kdWNlIHN0YXJ0X2FzdDI3MDBfdGVzdCBBUEkNCj4gPiAgICB0ZXN0cy9mdW5jdGlv
bmFsL2FzcGVlZDogVXBkYXRlIHRlbXBlcmF0dXJlIGh3bW9uIHBhdGgNCj4gPiAgICB0ZXN0cy9m
dW5jdGlvbmFsL2FzcGVlZDogVXBkYXRlIHRlc3QgQVNQRUVEIFNESyB2MDkuMDUNCj4gPiAgICB0
ZXN0cy9mdW5jdGlvbmFsL2FzcGVlZDogQWRkIHRlc3QgY2FzZSBmb3IgQVNUMjcwMCBBMQ0KPiA+
ICAgIGRvY3Mvc3BlY3M6IEFkZCBhc3BlZWQtaW50Yw0KPiA+DQo+ID4gICBkb2NzL3NwZWNzL2Fz
cGVlZC1pbnRjLnJzdCAgICAgICAgICAgICAgfCAxMzYgKysrKysNCj4gPiAgIGRvY3Mvc3BlY3Mv
aW5kZXgucnN0ICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ID4gICBpbmNsdWRlL2h3L2Fy
bS9hc3BlZWRfc29jLmggICAgICAgICAgICAgfCAgIDMgKy0NCj4gPiAgIGluY2x1ZGUvaHcvaW50
Yy9hc3BlZWRfaW50Yy5oICAgICAgICAgICB8ICAzNiArLQ0KPiA+ICAgaW5jbHVkZS9ody9taXNj
L2FzcGVlZF9zY3UuaCAgICAgICAgICAgIHwgICAyICsNCj4gPiAgIGh3L2FybS9hc3BlZWQuYyAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAzMyArLQ0KPiA+ICAgaHcvYXJtL2FzcGVlZF9hc3Qy
N3gwLmMgICAgICAgICAgICAgICAgIHwgMzI5ICsrKysrKysrLS0tLQ0KPiA+ICAgaHcvaW50Yy9h
c3BlZWRfaW50Yy5jICAgICAgICAgICAgICAgICAgIHwgNjY3DQo+ICsrKysrKysrKysrKysrKysr
Ky0tLS0tLQ0KPiA+ICAgaHcvbWlzYy9hc3BlZWRfc2N1LmMgICAgICAgICAgICAgICAgICAgIHwg
ICAyICsNCj4gPiAgIGh3L2ludGMvdHJhY2UtZXZlbnRzICAgICAgICAgICAgICAgICAgICB8ICAy
NSArLQ0KPiA+ICAgdGVzdHMvZnVuY3Rpb25hbC90ZXN0X2FhcmNoNjRfYXNwZWVkLnB5IHwgIDQ3
ICstDQo+ID4gICAxMSBmaWxlcyBjaGFuZ2VkLCA5NzggaW5zZXJ0aW9ucygrKSwgMzAzIGRlbGV0
aW9ucygtKQ0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRvY3Mvc3BlY3MvYXNwZWVkLWludGMu
cnN0DQo+ID4NCj4gDQo+IEFwcGxpZWQgdG8gYXNwZWVkLW5leHQuDQo+IA0KDQpJIHJlYWxseSBh
cHByZWNpYXRlIHlvdXIgZ3JlYXQgaGVscCBhbmQgc3VwcG9ydCByZWNlbnRseS4gU3VwcG9ydGlu
ZyBBU1QyNzAwIEExIGlzIGEgc2lnbmlmaWNhbnQgbWlsZXN0b25lLg0KVGhhbmtzIGFnYWluLCBK
YW1pbg0KDQo+IA0KPiBDLg0KPiANCg0K

