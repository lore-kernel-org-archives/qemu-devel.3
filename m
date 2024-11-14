Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27582D65C57
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 08:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBVYM-0002Cr-AF; Thu, 14 Nov 2024 03:50:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tBVYJ-0002Bi-DX; Thu, 14 Nov 2024 03:50:11 -0500
Received: from mail-sg2apc01on20715.outbound.protection.outlook.com
 ([2a01:111:f403:200f::715]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tBVYH-0007q2-LL; Thu, 14 Nov 2024 03:50:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2vZczmnx73MkIFIP3gCdb48l+iWnt+HC6IPLkhOGVPT1rsyIy4lkvNj8FFyNDHiUi9YFC//kP1gA0Td3H0ugOL6RHql7kJDB/zAaiyUN3GD6zg0hYQ3NgFlNqyRka03jmhEzg9MP8baGUTM5xT6NWNvTZxIZiYJ98Why49TWC5XSe71RJUA/tWUcbMUuKso9cETFvYxGyFFq2TE2PSrcYqHHkqaFVjd5+weLulqWXOjlZsrnTAjj2w0R5S+oQmpW8+e72q+S8mmwQqKdhMCqOxJWigXAy8Kib1gZMUeMrpuSdKWIaoLH4o2eSeBTZAWwywmrasj0Qo4xWEULy6iGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcN8URO+gN2QNdvfxTwFHs9Cyb5PkMyPNQCFJXbK1/U=;
 b=QKwJjKPpND2mBusdccqG5iaDbflhIyO4DvYChLxzjqz62j6hZLNGnKYRInS+icY64Z1r32Mx7EyLgWIT5SFfXRQlZ6TgJFj6/H2TGebFH4qHytFpYG28NWdyI+fyUpSn96aHqYEA5gJlPdDijHRaAwnfQFlxyay1sT8I2Ye9uVlDhdir3PSegbRmQiGfwt5KhC1fZgyTxLTpZm98wPQRajNxWVWB5uhhkeLagtg5+8UaWK6yRswZ07QvBu1MXRTMfZdLxusFpW7zwuuEuylVmJpRrJjtISxc5J558u/Q8k8d5f5x48V0XGQIm6gKRBjryxdwemzfBSLTagUOCvpL2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcN8URO+gN2QNdvfxTwFHs9Cyb5PkMyPNQCFJXbK1/U=;
 b=eFxQzOyl8XJM6NLvXtTH+UgRQydAGdRfrpVof+tVxif0YAmaQaNvAJDLAippjqTMS1tkKQ7zlBu+RG7nF81yW6NdKJ0GwzBd/kwtaK6cTqJQevG6l+d3y7w+SOIxzY7biVSu35s9It1O1zpm3J0BabhjzvKxp4uqk8laWeSThpAPmoASJ4ZEK3mmTjgVlMIUpYbgyoOcGMiLzvjQVeowCgceC3JM1eqGl9RWD4QhNGw60nw5LtXX74hVhxMFGZv+yVB3egHWObhZ0n7GGi/z4delYBbgWL0lX3oSYKmv3Nw/cIpOKWpFiznuxw/0dEmvQM8GSzdxQUyXQAHTSA9IKg==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 KL1PR06MB6623.apcprd06.prod.outlook.com (2603:1096:820:f9::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.16; Thu, 14 Nov 2024 08:50:02 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 08:50:02 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, Kevin
 Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:Block layer
 core" <qemu-block@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v2 00/18] Fix write incorrect data into flash in user mode
Thread-Topic: [PATCH v2 00/18] Fix write incorrect data into flash in user mode
Thread-Index: AQHbJGaQVsUKUjWOB0e3PeDsyHwdArKVbkWAgAAArRCAIPRlMIAAJEkAgAATyQA=
Date: Thu, 14 Nov 2024 08:50:02 +0000
Message-ID: <SI2PR06MB5041D551D39BF39D2F6284F1FC5B2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20241022094110.1574011-1-jamin_lin@aspeedtech.com>
 <9fe3e1cd-6aed-473f-9193-8541a202b7a0@kaod.org>
 <SI2PR06MB50419A139B7233B352CD1E31FC4E2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <SI2PR06MB50413F4922CA4FD3F61E12CBFC5B2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <ed89cef1-96cc-49f1-8f22-655fe0677f2b@kaod.org>
In-Reply-To: <ed89cef1-96cc-49f1-8f22-655fe0677f2b@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|KL1PR06MB6623:EE_
x-ms-office365-filtering-correlation-id: fa3a7042-8c8a-4290-7f14-08dd04895401
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?NVBPTVhIN3pnT3RaSnpLRTRXNGNxUUdlMWEwc3VqN3ZQSzFOUVpTcjVEbXdv?=
 =?utf-8?B?aHRXSGRqWTVYM2RRY2tBQ0dnUlVENTdsam52d0gxN1U4OVZmb0k1SGpEeGx2?=
 =?utf-8?B?dTBmTHh5L0V3cXRoeEF5eGZQK2JkKzVtQjlveFYxUWVJWnRWaVpLcUplSnBS?=
 =?utf-8?B?N0lYa3BlREozMStQZnRoVlZNTkJYa21FN1BLWDVsTU03Vmhrd2Zqa0x3enhO?=
 =?utf-8?B?QjhqZVc0aTJtQkVhdkMramROZUEraTNJMGpPTFNLcmRiMnpzd3g4S1hkdlZR?=
 =?utf-8?B?RFArU0tNbFhtMmYxWlM1NFJnbFFEeEhxMHI3aVBMQjE0SlBVMkVjajRpRzhr?=
 =?utf-8?B?ZHExMTkvcWV4RDBzOS8xVWhhWGMyUVdGUzZpamFVSGMwU2puS09mRFBnVGd2?=
 =?utf-8?B?ZlhuN05wajVkU2lqSUxZNWpkdS8rOWZKN2NiZHpzUHFtcEhuMmUxV0VPWjNy?=
 =?utf-8?B?cEhhUTFlbjZVc2kwR01pd3IrVDdTRG5uMi9nRENadlBoMkh3c3owUHFRUStj?=
 =?utf-8?B?K2dlWTlPSmVVZy9Ba09QT1lEQnR5OTY0dzJ1Q25wK0ZiNXVuZ0h6YWUyV01l?=
 =?utf-8?B?OG9tZlE1UVpqRzlKdFBPUDN4bGsvOEkyMEdQbUpvWENjdzYyenZNSHYzalV5?=
 =?utf-8?B?ZlRHWng3L0dtQk9JWFE4RlJKd0FyeFhuVG80RlF4dDE3TzJ2R1orSmVtS1FC?=
 =?utf-8?B?SS9IZHkxZEtCTUFLWjNPVW0yMEVYYlFBTkxMM2VIQzQwTXdGWkZSVUljekZ0?=
 =?utf-8?B?ZmJ6WDFEMXBONkE2UitPT2lIMVQzNkVZd3NHWkFiam9lczFjdjlPQWVWdmln?=
 =?utf-8?B?NEFrSUcyZHZ3WCtVNE5qVUdLeWh4L3JBbmRIaWdvZVI2cWNxNmNMSURQNVJo?=
 =?utf-8?B?aFVjbTU0emhYTVpPZE5yUjJTaElVR2hlTk9LTTFmVUM3ZWNsb1lpbVZ5Mjdq?=
 =?utf-8?B?RzRoR3RuZDFkOGNhQVNmallZbWVpMnh2QlJYUG1SNGRabzlXaGdKRVc5RFNl?=
 =?utf-8?B?TVFJb2hTNFFkVmhjejBCQWpNMGp4aEIxMmMyUWNXS2czRy9UUHdPSHRlc2ZJ?=
 =?utf-8?B?Y0swYU51VXZDaUxNWEpRSVpvaUp6NmpxcktVTzJaMElqU1doYjhPUVVoeWFr?=
 =?utf-8?B?cmUxUVlMY2Jjd1ZEUys4UlRHVzQvRHVRU0dtL0tlTFk0N3pxMzdzNGI5ejNs?=
 =?utf-8?B?dEZsdk1vNGsvYUp1VGdKbUx0U0VCU3ArOUgvREZZSXRMaDhiNVdhTUpDUXZw?=
 =?utf-8?B?alV4cDRhRUR1QmczNDVCaUNOZytKNUNra2JSWEhsZktGRHh4YmpiQjU4Q1Vp?=
 =?utf-8?B?WjNvZWcwT0pWNGRUSUtpTVRTU1IzZStlY25QeGZpTWgrL01nZm5QQjJia3Q1?=
 =?utf-8?B?QU1hNDE0aXZLcGVnNGhSMllIOWIwMU1CRXI0UmsvT2MyNitlSU5kOGlPbnhY?=
 =?utf-8?B?QnVSWDN1WWgxMkJLK3RiMkFqWDlKZEtkT2NzbVVDOEVPN1VvR2RZZ01rN2tj?=
 =?utf-8?B?R0lhckZNbzFNZlFxL0ViZzJCdFg4RmxZOGJYRzZtSmp6cWxPQUs1K2psUm5F?=
 =?utf-8?B?VEl1SGxFZmxqeUNMOTlSUklCZWZMM2FZelFqNjZRWE8rWFpzNlBlN3R6S3Rn?=
 =?utf-8?B?K09SQkhsaFZlYkxPSFRzM0V4dzNpSiticnRQUmFaZFE3MVlNL2JRTFoxOWE5?=
 =?utf-8?B?dEpuVVhYZGNXQm8zTTM1UStwbGlKWGtGZ0tRVEdDT212MTBudi9rTDQ0bUxE?=
 =?utf-8?B?STZ4Q1pWT2E1SzRjbVYzSGM2K2JsdkVWQThidC9TNlkwMXNTRlJIWjVYTHli?=
 =?utf-8?B?VnpXRmk3dWZvS0tOYWdFa2JZTGw2dnd3T0YzTlVTYzFLQ1hsTWV0S2RzUW45?=
 =?utf-8?Q?pIH5Z6OO0ZS7C?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(921020)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUQ4Uk1sQUs3T08rZ3J4MDh1K2IvUURhS3B6Z09VT3F3bVEzU0hUUHcydHhy?=
 =?utf-8?B?L01BcVI4TGF5UEtTeW1yZWMwZVh6MkdhMGRqTnA1aG5RdW1GSTNnR2djWXpr?=
 =?utf-8?B?NG43ODJjNFVNN3VRTzAzU1k5TlN2UWlQWTFkREhybTZ3U2lCdjZLNkZZV1VJ?=
 =?utf-8?B?NmpIVVhvcnNWbmh1RTZ0YlROSmFCY0NFcG4ySjFVS1Nvd0FtbkdPajE3LzlF?=
 =?utf-8?B?a29PZmRUWEkwR05VZ056YjdFVlVlYktkcXY1TFc2NmJET0Zyc3pnbFh4dEZt?=
 =?utf-8?B?TnhldEoxK0ZWdS9PQXBZLytZSjZpZElYOUNJam4wekJRV2Y1NE0zUkF3czlu?=
 =?utf-8?B?R2RFRmltOG9wNlZEbmRncSsyRktaZDZXcGc1VHNyS2xFdnpRbXdMakRyZ0Z0?=
 =?utf-8?B?SFNuM2pleWU1MUZWLzN6ZlZUL3RLQnQ3QnVrNXY4VUZVTFdDTVExdy9vNXgx?=
 =?utf-8?B?UVY2NUNWSTdwaGtub0JUcXBRMmFIZHl0a00xYlNJRVpPTWdlTHBxME54bUdk?=
 =?utf-8?B?b3k2MzgwNlFBQjlmWWRiTGZucGFZRFREeDZBUCtRaHpMS0dyZ3ZRcEZmQlpS?=
 =?utf-8?B?MW1sSW8xVklOZlJPMlNlZ0MxWmFKd09GMkltVmlaZ1R1RWJYMHNmd0NOQ0lx?=
 =?utf-8?B?THgvUjdWVm50N011ZGg2MlJyZWUyWitLcHlKR1pDTVV6WWcxdVVvcjZNL3N3?=
 =?utf-8?B?N1Y5d2hwaTRpNHZTU0VhOWgwd1kzSmtnZjhWV0twMnI4ZDkyekJvRWdxOUJO?=
 =?utf-8?B?WWNJcUlmbDZOUlYyQnlLUFFCY3BMOXowdTFMRG1CRkYra2FRcUNiRTZnMG1r?=
 =?utf-8?B?WElvaFlKUG5wcGVEd3RkT2xZdGdEMEtMYmVZeklFUUZzZHBReklRSDhRcUQw?=
 =?utf-8?B?bkVxcWFWUVBaQTBnakF3OWVYMU1zTVRhb045UHRYMTFSY2VmaUxvdSs3RlVw?=
 =?utf-8?B?NEhKaE1Xd1FOeU1ubDVwZjhUSDhEK1ltSlhWRUFtTE1qZXRxbUQ4aHdTbThP?=
 =?utf-8?B?SEhvR1d1TENmMkFydVN0YndBZmQ0aCswdXNxZEtHRlVrSEhVNlNVaTN5QW5T?=
 =?utf-8?B?U2FlbHZnQVZySGlMQzUralNJblBadGtROTEwOWFvUTlmdm1xMFhrR1o0MENG?=
 =?utf-8?B?NUtXSUhRUW5kNTF5OXMva2VuOUlJcHdMdWNVQXhyY2NHb0lyUVRGQVdzdVRQ?=
 =?utf-8?B?bjkzTHlGOVZ5YVpYanVxelhmcllUd21BRVdtWXM5Z3dWaFFodzFEYlI3TEVX?=
 =?utf-8?B?Y014V0tyYStiOVlISW1uckpnN3pzOUVHb1RaZnJNdUw5WEpEOWdJUFJXNERO?=
 =?utf-8?B?TEljdDJodkNmNmV0UzV1b0tpVGRZVlp2cU96NFdjc3RwbWttMHkwRjVBcGhD?=
 =?utf-8?B?ek1hQkdPTk8vNDVWdkNGc3JQM0xDWFNMTUgxMU0xMlFFOEc4clh0QzZPdDRR?=
 =?utf-8?B?dnlGL3I5VVFnZW9YeklvMnBVL2FoakZxRnNMK3ZMZGw4YlkzVWVXcUh1RHNs?=
 =?utf-8?B?S3EvYmc4NjRSWlQ2T0V4Y3FPa3dobk5EWGRyMmMxUEJkcTI3RTNIeEdjVzds?=
 =?utf-8?B?dXJSOXZTQzd5ZXhNUjFpMjZiVWZZMU9ldldsRDRVdUxRK1FzbFY2dDJMTzRG?=
 =?utf-8?B?RHdjaHVXdUwzTXpObHpCOERyQzFoQVAvemtVa0dUZytzNHhLWXJWTFhBNmVE?=
 =?utf-8?B?MUoyY3pBU3VaV281eHdHUVRsaGtPRDFoZmNNY1NpUmNDdDRMZUY3UHZUc1ZJ?=
 =?utf-8?B?ZjZLTHVBdkxHSDlCM2VPbFhUcnNNK3B1c0loOG4yNC8yTkdlUmVxL3lDK3pr?=
 =?utf-8?B?RXRSNWFUM3Q1aUtzR3JQWnBIb1E0R3U1Wjd6RmJXZXpwWmNERWRqbmM3bWhL?=
 =?utf-8?B?M1g4a3J4dFZ5Q1ZJdG11WXVBbHhFL29TVGtBaTBuaDFKOW81dk5pMTJ4NDdB?=
 =?utf-8?B?Q01oNy9LV0NhZ0E1RTZOeVVwaklRK05DdzZhRmx4VTlTM1NZelRSSzVHN1Q2?=
 =?utf-8?B?ZngwU29xR05mY0c4cThOOVA3bXg1YkdVMWtwNzlWWk00TDVDZEdyTFZkczFV?=
 =?utf-8?B?TThrWjFIb0tpc2wxK1U1SmxjRFYzVG45WnpUanAvaGpsY0N1cnEwUEV0WDVX?=
 =?utf-8?Q?TCjSD2Fqp8NI/4YwkalAOST/F?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3a7042-8c8a-4290-7f14-08dd04895401
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 08:50:02.2825 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2h4IeTYtMq8DUztYl4M2Y6vmBBRatqS78EITnSbB7vgOuR/JC34VZWSsv1Sh8WzNqF/YUmFWolkw/eABg1eJ4jw1WHe0hEjn6N46PvaIKuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6623
Received-SPF: pass client-ip=2a01:111:f403:200f::715;
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

SGkgQ2VkcmljLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDAvMThdIEZpeCB3cml0ZSBp
bmNvcnJlY3QgZGF0YSBpbnRvIGZsYXNoIGluIHVzZXIgbW9kZQ0KPiANCj4gSGVsbG8gSmFtaW4s
DQo+IA0KPiBPbiAxMS8xNC8yNCAwNjozMCwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IEhpIENlZHJp
YywNCj4gPg0KPiA+PiBTdWJqZWN0OiBSRTogW1BBVENIIHYyIDAwLzE4XSBGaXggd3JpdGUgaW5j
b3JyZWN0IGRhdGEgaW50byBmbGFzaCBpbg0KPiA+PiB1c2VyIG1vZGUNCj4gPj4NCj4gPj4gSGkg
Q2VkcmljLA0KPiA+Pg0KPiA+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAwMC8xOF0gRml4IHdy
aXRlIGluY29ycmVjdCBkYXRhIGludG8gZmxhc2ggaW4NCj4gPj4+IHVzZXIgbW9kZQ0KPiA+Pj4N
Cj4gPj4+IEhlbGxvIEphbWluLA0KPiA+Pj4NCj4gPj4+IE9uIDEwLzIyLzI0IDExOjQwLCBKYW1p
biBMaW4gd3JvdGU6DQo+ID4+Pj4gY2hhbmdlIGZyb20gdjE6DQo+ID4+Pj4gICAgMS4gRml4IHdy
aXRlIGluY29ycmVjdCBkYXRhIGludG8gZmxhc2ggaW4gdXNlciBtb2RlLg0KPiA+Pj4+ICAgIDIu
IFJlZmFjdG9yIGFzcGVlZCBzbWMgcXRlc3QgdGVzdGNhc2VzIHRvIHN1cHBvcnQgQVNUMjYwMCwN
Cj4gPj4+PiBBU1QyNTAwIGFuZCBBU1QxMDMwLg0KPiA+Pj4+ICAgIDMuIEFkZCBhc3QyNzAwIHNt
YyBxdGVzdCB0ZXN0Y2FzZSB0byBzdXBwb3J0IEFTVDI3MDAuDQo+ID4+Pj4NCj4gPj4+PiBjaGFu
Z2UgZnJvbSB2MjoNCj4gPj4+PiAxLiBJbnRyb2R1Y2UgYSBuZXcgYXNwZWVkLXNtYy11dGlscy5j
IHRvIHBsYWNlIGNvbW1vbiB0ZXN0Y2FzZXMuDQo+ID4+Pj4gMi4gRml4IGhhcmRjb2RlIGF0dGFj
aCBmbGFzaCBtb2RlbCBvZiBzcGkgY29udHJvbGxlcnMgMy4gQWRkDQo+ID4+Pj4gcmV2aWV3ZXJz
IHN1Z2dlc3Rpb24gYW5kIGZpeCByZXZpZXcgaXNzdWUuDQo+ID4+PiBJIGhhdmUgYXBwbGllZCAx
LTYsOCB0byBhc3BlZWQtbmV4dCBhbmQgc2hvdWxkIHNlbmQgYSBQUiB3aXRoIHRoZW0uDQo+ID4+
PiBJIGtlcHQgdGhlIHRlc3QgZXh0ZW5zaW9ucyBmb3IgbGF0ZXIsIHRvIHRha2UgYSBjbG9zZXIg
YSBsb29rIGFuZA0KPiA+Pj4gYWxzbyBiZWNhdXNlIEkgd2lsbCBiZSBvbiBQVE8gbmV4dCB3ZWVr
LiBUZXN0cyBjYW4gYmUgbWVyZ2VkIGluIHRoZQ0KPiA+Pj4gbmV4dCBQUiBpZiB3ZSBoYXZlIHRp
bWUgaW4gdGhpcyBjeWNsZSBvciBpbiBRRU1VIDEwLjAuDQo+ID4+Pg0KPiA+PiBHb3QgaXQgYW5k
IHRoYW5rcyBmb3IgaGVscC4NCj4gPj4gSmFtaW4NCj4gPj4+IFRoYW5rcywNCj4gPg0KPiA+IENv
dWxkIHlvdSBwbGVhc2UgaGVscCB0byByZXZpZXcgcGF0Y2ggMTcgYW5kIDE4ID8NCj4gPiBEbyBJ
IG5lZWQgdG8gcmUtc2VuZCBwYXRjaCBmcm9tIDkgdG8gMTggb2YgdGhpcyBwYXRjaCBzZXJpZXM/
DQo+IA0KPiBOb3QgeWV0LiBJIGhhdmUgc29tZSBjb21tZW50cyB0byBzZW5kIGJ1dCBJIGFtIGJ1
c3kgb24gYW5vdGhlciB0b3BpYy4NCj4gDQpHb3QgaXQuDQpUaGFua3MgZm9yIHlvdXIga2luZGx5
IHN1cHBvcnQuDQpKYW1pbg0KPiBXZSBoYXZlIHNvbWUgdGltZSBiZWZvcmUgUUVNVSAxMC4wLiBU
aGV5IGFyZSBpbiBteSBhc3BlZWQtOS4yIGJyYW5jaCwgc28NCj4gdGhhdCBJIGRvbid0IGZvcmdl
dCBhYm91dCB0aGVtLg0KPiANCj4gVGhhbmtzLA0KPiANCj4gQy4NCj4gDQoNCg==

