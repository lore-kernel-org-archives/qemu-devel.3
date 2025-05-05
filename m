Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF3CC369C2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 03:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBmks-000572-Ct; Sun, 04 May 2025 23:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uBmkp-00056o-NZ; Sun, 04 May 2025 23:44:31 -0400
Received: from mail-eastasiaazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c400::3] helo=HK3PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uBmkn-0006wF-7i; Sun, 04 May 2025 23:44:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4BLiHiX0py4UV24bIDmOPC7gYA+lxKPEeXXy56XMvAbk90xOivMuMBoeP3bNTRIir/skUh2zNqhufMZcPYVmXuk+fp59sY2Opir1DdZJ5Esivkdu8WiXGjI/izbFRnBncvW6nKqA6Y4sidaDny8AjDd4QxElkhL4H6a2S9lQkpcTqEjg52ZUIqkiOY4scR6hqdfEHGQ4GrtLwAjnk6aphieM8qe/SH0T0/2K0cvdfD/SZek2xtmC2STmwOtT/BpVvrBTzC/MqPuuuOLech6O1clG1C0DmAGVT3zHhaZAnCENlSLAVdCYVpb31Fzfut7NOHj9D08v/yNsmgEfiRnhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUq16+DNannYBdkxLBqcwmtI+fbgC5Yk36KdMKXViGI=;
 b=lUmSyTuOEbUvnQgHoHybonqHdZvwZC/wMo/R3mXUsypxwK/lBOg7E+YHvMZZxEXsHPnQRcN6binINAPKW9vRLkMlIo1JoSygy2bNU7olwxWIuji9QAgI5O7TBIKsFse4BNsVccNlCNJJEtSRK3B7daLnqSruUQJsSY57BIN/QPhXLlO2gi39M545XvRGWcyuB3+CFNC+GcRoGrKOJpQfwzaeNdiPw6qhccoXtF2FNKh25YjwMz0xfCz9JgSQNLN0A1diBw56fw/8tDK+QUgx0y0JhAvo5bqUYZXxnPKYVsMna1pMomFSIkhKVqhBIel0zqEYAup74k1QFALyCpAndw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUq16+DNannYBdkxLBqcwmtI+fbgC5Yk36KdMKXViGI=;
 b=RZnMiejHsqfyOybo59a6OuamY24iOM1GhbczObu6yR6EdZAkjTVGSnLFjv8l5yMESWUP88xNA4QzKAMVq8/ogi658//1D+Limy+KQwBu6nF1Od9NOjgxzCY2+HfSrahlOholXVfdcgxTGKMQ6PgOTOSRippGlIDmXiY6d1aL65/w8q1mrmEt4rdhlQ2ioiMzJHxb2gnWAO5zhAuCkd6tgPAk6r8L3EBNP7AjLsUlDTvxQugkFR5ULuA0Olj2d2k8/aCSBhHOAZB5b2JFBUHUfD36KFdyCUeKQLuzH1h8STWNBe0GKBdyIB0ho/AcQMISMuV5jtV5obOgHY5SE5t6dA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SI2PR06MB5089.apcprd06.prod.outlook.com (2603:1096:4:1a8::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.25; Mon, 5 May 2025 03:44:18 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8699.021; Mon, 5 May 2025
 03:44:18 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 14/22] test/qtest/hace: Adjust test address range for
 AST1030 due to SRAM limitations
Thread-Topic: [PATCH v1 14/22] test/qtest/hace: Adjust test address range for
 AST1030 due to SRAM limitations
Thread-Index: AQHbmkNZHb2nNEs/tkilgKGA5ulJRLOQMvGAgDN39OA=
Date: Mon, 5 May 2025 03:44:18 +0000
Message-ID: <SI2PR06MB5041A0E4DA3AC56B50BD6917FC8E2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250321092623.2097234-1-jamin_lin@aspeedtech.com>
 <20250321092623.2097234-15-jamin_lin@aspeedtech.com>
 <43581924-e627-427c-b290-05f473877c41@kaod.org>
In-Reply-To: <43581924-e627-427c-b290-05f473877c41@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SI2PR06MB5089:EE_
x-ms-office365-filtering-correlation-id: 8e6a178c-9da5-48bd-bb57-08dd8b871d4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|38070700018|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?ZGZIRldHSDV1d1dnQ1F2TmZSczRNZ0ZSck1qNmJQeFZLczRsWjl0Q0tTQ0RH?=
 =?utf-8?B?MHpDd1ZqeWs3ZjFibWVsK3RRRndJdVVRV3k3R3VBdkJtcUxqNzdnQklSdW03?=
 =?utf-8?B?ZmN0YnBRQWd5N2ZFSlhwMUdhWTdwUnRQQkRWTHJGblkzVGxVWTlZOTRSM1hn?=
 =?utf-8?B?WlNxSFpDSE1Fd0MweUtCMmJMTHBXbkVtS1FkeEtMSkRSSi8yVnNlelRqQnBX?=
 =?utf-8?B?b1gwcWVpelZXNWUrV2NOdHZmVHpEbGRHcEpxUUFSRGhmSlFXa2YxWnRnRVJy?=
 =?utf-8?B?VVQ4eUpVTTB5WWJaazRxcmxkTExmM00yWGQwdk1xZ1FaYVA5amlBTlBJYSt5?=
 =?utf-8?B?N1FKSU9HdXZPaWhmeFN5Q0k3L1ZEZHR0RmpZMnFrM2hMMndoTmpzbkJpSk5H?=
 =?utf-8?B?LzEzYUZleUlUeXA5NG1KTTYwVnV1VXc3ZHVseTRuMWdNUTRySzhpUFFFRklR?=
 =?utf-8?B?YUVTZlJBNzAzNW5FYkwrNTZ4VGlZMzl6a2R6K0FseWpkckpFRnZUTWxxMkNF?=
 =?utf-8?B?Sjh6OEt6aTJHWS9CaENDTy90ZHZGeGV6OFNXRnZCR0VZeDVZdDc3cGQyTVdU?=
 =?utf-8?B?TFE0NjhrUkY0eUU4cXdZNWhoVS9RU0tVeGk3V2IrZ0VmUmdRRTFsWXRuUWlN?=
 =?utf-8?B?eVBCOSt3cjlTdVpmTXl2NDd3RmFsaWZrenVBOGYybHo4YVBIV3FLREJMbUdC?=
 =?utf-8?B?NEN4QVg4RStDeEU5aThiNk9CWXY5K2NLTS9rZnVaeXpwVHJ5YTVsUTdJZ0dP?=
 =?utf-8?B?WTBKc2xRRU9EM2xKbTNITll0SGw0QmtrM0IrNHpGUTkrRCtBSkNHanNCUnBv?=
 =?utf-8?B?WTZRWmZMaFNkN2Z0TTV0ME9pZ2Q3YXJ3bTcvMTh6WENzU2R0SjRwbWY2bGZx?=
 =?utf-8?B?emhSWVBnRFlXYkRyOS9PK0lvT1Z2ZDd6UVVTUTE0TTY2TXJPODdnRG44bisv?=
 =?utf-8?B?R2srRjkwOXN3aWhqa1NBNE1TZHNCZkpiSXdTc0tTeUVES3FuRlkvemY5aGJQ?=
 =?utf-8?B?V1FTRWVheXF0WnFGRkQ4S0R4U3RBODVXRmovMUFFdFFYNTJqYUdpa2w0clB1?=
 =?utf-8?B?Y21rNzNVZXRxWk5PaUlBZlJmVnV5K3ArSDhDM093UXQzNGthd2k0S3VrbXBY?=
 =?utf-8?B?dE4ycSsxQ0NlVUU5M1pqMVNybWtmUllIcWtDQXBhVjA5UW1FaDgyeVdYeWNu?=
 =?utf-8?B?MDk2YW4zZVVuOFprTVl5ZnpSLy9WbkRTWVVhaVJLeVAyL0R2eUxBcTJmRUxy?=
 =?utf-8?B?alBvbHd1RThITTA2SWxjYWpBU1o1bXFHZEpzaStZYlBFUHNCaCtGU24wZHkz?=
 =?utf-8?B?RDZSSmdHa3ZCTzJaY2pQZkxOdXpPMWE4NU4yZTVQY2FlTHozYzR2azZ3c3kw?=
 =?utf-8?B?S081OElOTFZjQm9HckcrVmpCcjlqdGdBQmxFNExYcFVzY3lkb1FMNU1pODdO?=
 =?utf-8?B?MTNpbFhHeXdlb2lRQUZML0pOY28wbEE4ZTVFdzJxblZ3MDkrTThyUnQ3T1JM?=
 =?utf-8?B?aWdnclhrWkNyM2d1T3FNYjVjcktBQUJ1UlpWZlUwWXZ5ZjJ3VS81S0xBbDJG?=
 =?utf-8?B?SUFNY3MrekFUVGt4ZVl1V25XOFR4TXZuTnRkWE42MGVYdk91T0NiVVBZTlZ5?=
 =?utf-8?B?bGV6blduWGtLaTFMMzlmRWo3MUhKR3JKV0hES0Vld3lXb3lVL0loSXV0eWFV?=
 =?utf-8?B?dGVDSUdJUGNlT3RmdnhsNUdCdlVqZjdNSzF4ZUpZcFU1N2lhdWxlcWdZK3Iw?=
 =?utf-8?B?R1dNNmF0WTFqdzFwUE9EUnNnaE9KY3dtcWtrcEt1ZUw4U0dEY204dnA4QWVa?=
 =?utf-8?B?WEhxbWw3eXliaytHa2dNanViczIvTEIvVTJBdE00NE9BSUpvd29EeTU3TDdF?=
 =?utf-8?B?MEhoL3hBbXpxa3dzMDU2aW1BbFdMTENJeW0rNlA2OXNYOUo3aVFKM3RjanVB?=
 =?utf-8?B?cG02VVBJNkdQUzBleFE1eGtaVEdTUlhZS01DQWczZ2tHZjR6TElIdm94ZGlU?=
 =?utf-8?Q?Ssu81VOB4W4dOC2KOZqDbTlmuRfpGQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eElKYzgwZ0lOR3JGQTZqZkt4NG45K1RmeXk1ZHh6SURadUhVWHk4dWNSa25h?=
 =?utf-8?B?akh2bitmTGZRVEpYQzdpT2p2WjU4YVNnNXpOeWwrMFFFR0ttVkpxbzNYL3Rp?=
 =?utf-8?B?YUlZSHNUNnYweUNOcmQ0WkVUWVRwNldVVVE5SGNicVlDRHN4SzlZcUp3SUQ2?=
 =?utf-8?B?R2dkdWo4Vkp0clExSit1MC9TRXJWK0dPNWgrMjVUR1JmQndKK011Ukx4Skhy?=
 =?utf-8?B?T2VKb1Y3ellXaXhhQjJMK0tzUXEvWTJJTmNLaStsNG5WTERiZE0rTWlwcmhS?=
 =?utf-8?B?RDRtcW1COXNxZGlUeWw5eWY3RmhqYlluNVRVSSs1VzFkNERzK2R4WDlnSHBU?=
 =?utf-8?B?ZnZyZzk2UXUyT1VSRys3QW9ZbHpuSklLZFEvWStKZkNTTHBHNWc4eExSeUNS?=
 =?utf-8?B?ZVhmTC9Nc1k3SkdHWVNWaGtmd1poWklZMkhlMCtReW5QNkFiT295T0hSRFVt?=
 =?utf-8?B?WjhZNEhwdUJpaEtGc2NZVjhZem83Ykw0K1RSQ1ZiUktlK01qenYrR29GWGxD?=
 =?utf-8?B?S1NaQTlkOVBCU3llQUM0TWVXZnBGcDFXd0F3WmxIeGdVMWdyRDhQRk5DUFky?=
 =?utf-8?B?aGc5OFFsL1BnenJpMkpQSHIzS09PbU5aUnlHcXhiK2NGcDhOQW1wN0QvSy9k?=
 =?utf-8?B?ak1OU2VDaWJHbERXL1MrL2Z6Sm9pLzBLQlUyVjdPeUVpdk1aWDFoczdmMVdF?=
 =?utf-8?B?Z3NzL3krcEsvclVqOXJRMFhETlQvbnQyZW9Gcjd2UFo1b2RrRHdqMjJhU3o0?=
 =?utf-8?B?WkdCak53MHNCNWpWaTc2UjJPdHdHc0FialdVME5oa1RHN0RSbWVFa0QzcTU2?=
 =?utf-8?B?d25pTmhqR0xyKzBYaUl4bkw3TTJXZStkbUdlaWFoNzJvVjVvVm0wV2s4NFNV?=
 =?utf-8?B?bXZnc1c2RVFBYnp6Y2NkbTduWkJyU2RYUXNhdi9VOHhWWTd3c0x6RGNtVmFp?=
 =?utf-8?B?S0dIQlRaRVpqOEV4M3JLS2pLMGRhVEw3WUtsT0d3M0h5aTY3Vjg4MDliMitn?=
 =?utf-8?B?eFVOeThFUkh3WkZJektzTlFJbWJCWjZBWEpDVXdnUnhBUW5XL3gxYjdkNGY2?=
 =?utf-8?B?NldlYkxXOFFXWVlNM1ZqYjYxQ1FHNGhzTS9YbkNIcGVVN1Zsb05vY3ZLRVJl?=
 =?utf-8?B?OWtCc3dQbXo1ZG1oM3V4ZWpWOG4xMi9kSWc0QVkyS3pxM25qYlNPZ2k0aktC?=
 =?utf-8?B?c0JVUnFvbmNqUjVpeW5FMVBuNDBNaDNDdzlyaitUeU9uc052Q3RucDdIQ0d3?=
 =?utf-8?B?WVVha1dkU1RIZjRpRFF2M3k0QTkyWFFMeklkUmdzY25CZzhCaG9RN09wUDd3?=
 =?utf-8?B?MXBLOEFSM2laWEgxbjUxNFFKbWY1VGpEY2lYYjQzamQrM1BrUTNoUHBhUldK?=
 =?utf-8?B?aDdCYXM0NVB1TDAva3FRMXZvODBuZUpMK1VITXJPTGdDRCtITEh5SzR4MVZq?=
 =?utf-8?B?OGltbnRrN2ltbkp2K2RzcExJN3dCTzdPYkZ0SncwMmVEWUp1VVd5Z2IxZzU2?=
 =?utf-8?B?cUJjbUtWQzl2NUVWZUpLbFdwMUVGQjZVL01OM0o2YVMxYVpBN3FhSjM4enNq?=
 =?utf-8?B?Y3FXMENjTG1vak5DVkl5eU5sK1puSkpCeVN0cVVMeG9xcFBtQW9QZkp3ODFW?=
 =?utf-8?B?REV0YVVHZ3V2WmlsY1B4SjFjb0loYVd1TDZCMEF5b0ZyajFRelpDOFlmSWJh?=
 =?utf-8?B?aFU5Mms1Tk96eXp6MENsQjd4UFBpMUxyRUJYWk5qTDFSRk1CRnBvY3lYSEFr?=
 =?utf-8?B?dEVkQWkrNE53N2ZzTzNadE5rNUxDMzRFcXlQbDBoZlJhVlZvcU94bU5kREV3?=
 =?utf-8?B?aFk3RGlRUTBVekVpRDVMOFg5cEFJOHRqbGhvTVpGWWNaL3FkYm5lRmZuU1Ju?=
 =?utf-8?B?OTFVTTA4c1hYTUx5cEd0SnpZdlNwZWVhOVBseTJTc2l6Q2FPRmxEOW54U1pK?=
 =?utf-8?B?Vm1zMUJhbzJXNXZmZHdMcllSMnh0UU9BbUVvUkFCYldtSDg2bFN6alBpdmFJ?=
 =?utf-8?B?QW56UDkwNUJtSURtMEpoTW5Tc1RwSzgrVmJ2VXk3RkhKekhZaGZWZG5yWjNw?=
 =?utf-8?B?bXI2c0tFMmVCVEFLajRabEJqS1ZsVUppMWhzTWNrVmRNblVNZmpMOUdhOXZM?=
 =?utf-8?Q?FOi/CDV4vBXr/STFXDnfaUM/w?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6a178c-9da5-48bd-bb57-08dd8b871d4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2025 03:44:18.4745 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rjf3thoSQvzj8V39u3uEB9vx6C17gObv85ls1UHLfn827E+rQM1sUUhGYZoSIV38SOTHbKpH3Mv7zQWhwcq0Y7Smg/7a2637CNcEvhSSgXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5089
Received-SPF: pass client-ip=2a01:111:f403:c400::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=HK3PR03CU002.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDE0LzIyXSB0ZXN0L3F0ZXN0L2hh
Y2U6IEFkanVzdCB0ZXN0IGFkZHJlc3MgcmFuZ2UgZm9yDQo+IEFTVDEwMzAgZHVlIHRvIFNSQU0g
bGltaXRhdGlvbnMNCj4gDQo+IE9uIDMvMjEvMjUgMTA6MjYsIEphbWluIExpbiB3cm90ZToNCj4g
PiBUaGUgZGlnZXN0X2FkZHIgaXMgc2V0IHRvICJzcmNfYWRkciArIDB4MTAwMDAwMCIsIHdoZXJl
IHNyY19hZGRyIGlzDQo+ID4gdGhlIERSQU0gYmFzZSBhZGRyZXNzLiBIb3dldmVyLCB0aGUgdmFs
dWUgMHgxMDAwMDAwICgxNk1CKSBpcyB0b28NCj4gPiBsYXJnZSBiZWNhdXNlIHRoZQ0KPiA+IEFT
VDEwMzAgZG9lcyBub3Qgc3VwcG9ydCBEUkFNLCBhbmQgaXRzIFNSQU0gc2l6ZSBpcyBvbmx5IDc2
OEtCLg0KPiA+DQo+ID4gQSByYW5nZSBzaXplIG9mIDB4MTAwMCAoNjRLQikgaXMgc3VmZmljaWVu
dCBmb3IgSEFDRSB0ZXN0IGNhc2VzLCBhcw0KPiA+IHRoZSB0ZXN0IHZlY3RvciBzaXplIGRvZXMg
bm90IGV4Y2VlZCA2NEtCLg0KPiA+DQo+ID4gVXBkYXRlczoNCj4gPiAxLiBEaXJlY3QgQWNjZXNz
IE1vZGUNCj4gPiBVcGRhdGUgZGlnZXN0X2FkZHIgdG8gInNyY19hZGRyICsgMHgxMDAwIiBpbiB0
aGUgZm9sbG93aW5nIGZ1bmN0aW9uczoNCj4gDQo+IFRoZSBjaGFuZ2UgZG9lcyBzcmNfYWRkciAr
IDB4MTAwMDAuIENhbiB5b3UgcGxlYXNlIGFkanVzdCB0aGUgY29tbWl0IGxvZyBvcg0KPiB0aGUg
Y29kZSA/DQo+IA0KVGhhbmtzIGZvciByZXZpZXcuIEl0IHNob3VsZCBiZSAweDEwMDAwKDY0S0Ip
Lg0KSSB3aWxsIGFkanVzdCB0aGUgY29tbWl0IGxvZy4NClRoYW5rcy1KYW1pbg0KPiANCj4gVGhh
bmtzLA0KPiANCj4gQy4NCj4gDQo+IA0KPiANCj4gPiBhc3BlZWRfdGVzdF9tZDUNCj4gPiBhc3Bl
ZWRfdGVzdF9zaGEyNTYNCj4gPiBhc3BlZWRfdGVzdF9zaGE1MTINCj4gPg0KPiA+IDIuIFNjYXR0
ZXItR2F0aGVyIChTRykgTW9kZQ0KPiA+IFVwZGF0ZSBzb3VyY2UgYWRkcmVzcyBmb3IgZGlmZmVy
ZW50IFNHIGJ1ZmZlciBhZGRyZXNzZXMgaW4gdGhlDQo+ID4gZm9sbG93aW5nDQo+ID4gZnVuY3Rp
b25zOg0KPiA+IHNyY19hZGRyMSA9IHNyY19hZGRyICsgMHgxMDAwDQo+ID4gc3JjX2FkZHIyID0g
c3JjX2FkZHIgKyAweDIwMDANCj4gPiBzcmNfYWRkcjMgPSBzcmNfYWRkciArIDB4MzAwMA0KPiA+
IGRpZ2VzdF9hZGRyID0gc3JjX2FkZHIgKyAweDQwMDANCj4gPg0KPiA+IGFzcGVlZF90ZXN0X3No
YTI1Nl9zZw0KPiA+IGFzcGVlZF90ZXN0X3NoYTUxMl9zZw0KPiA+DQo+ID4gMy4gQUNDIE1vZGUg
VXBkYXRlDQo+ID4gVXBkYXRlIHRoZSBTRyBMaXN0IHN0YXJ0IGFkZHJlc3M6IHNyY19hZGRyICsg
MHgxMDAwMCBVcGRhdGUgdGhlIFNHDQo+ID4gTGlzdCBidWZmZXIgc2l6ZSB0byAweDMwMDAgKDE5
MktCKS4NCj4gPg0KPiA+IGJ1ZmZlcl9hZGRyID0gc3JjX2FkZHIgKyAweDEwMDAwDQo+ID4gZGln
ZXN0X2FkZHIgPSBzcmNfYWRkciArIDB4NDAwMDANCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEph
bWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiA+IC0tLQ0KPiA+ICAgdGVzdHMv
cXRlc3QvYXNwZWVkLWhhY2UtdXRpbHMuYyB8IDMwICsrKysrKysrKysrKysrKy0tLS0tLS0tLS0t
LS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9u
cygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL3Rlc3RzL3F0ZXN0L2FzcGVlZC1oYWNlLXV0aWxz
LmMNCj4gPiBiL3Rlc3RzL3F0ZXN0L2FzcGVlZC1oYWNlLXV0aWxzLmMgaW5kZXggODU4Mjg0Nzk0
NS4uOGZiYmJhNDljMSAxMDA2NDQNCj4gPiAtLS0gYS90ZXN0cy9xdGVzdC9hc3BlZWQtaGFjZS11
dGlscy5jDQo+ID4gKysrIGIvdGVzdHMvcXRlc3QvYXNwZWVkLWhhY2UtdXRpbHMuYw0KPiA+IEBA
IC0xMzIsNyArMTMyLDcgQEAgdm9pZCBhc3BlZWRfdGVzdF9tZDUoY29uc3QgY2hhciAqbWFjaGlu
ZSwgY29uc3QNCj4gdWludDMyX3QgYmFzZSwNCj4gPiAgIHsNCj4gPiAgICAgICBRVGVzdFN0YXRl
ICpzID0gcXRlc3RfaW5pdChtYWNoaW5lKTsNCj4gPg0KPiA+IC0gICAgdWludDMyX3QgZGlnZXN0
X2FkZHIgPSBzcmNfYWRkciArIDB4MDEwMDAwMDA7DQo+ID4gKyAgICB1aW50MzJfdCBkaWdlc3Rf
YWRkciA9IHNyY19hZGRyICsgMHgwMTAwMDA7DQo+ID4gICAgICAgdWludDhfdCBkaWdlc3RbMTZd
ID0gezB9Ow0KPiA+DQo+ID4gICAgICAgLyogQ2hlY2sgZW5naW5lIGlzIGlkbGUsIG5vIGJ1c3kg
b3IgaXJxIGJpdHMgc2V0ICovIEBAIC0xNjYsNw0KPiA+ICsxNjYsNyBAQCB2b2lkIGFzcGVlZF90
ZXN0X3NoYTI1Nihjb25zdCBjaGFyICptYWNoaW5lLCBjb25zdCB1aW50MzJfdA0KPiBiYXNlLA0K
PiA+ICAgew0KPiA+ICAgICAgIFFUZXN0U3RhdGUgKnMgPSBxdGVzdF9pbml0KG1hY2hpbmUpOw0K
PiA+DQo+ID4gLSAgICBjb25zdCB1aW50MzJfdCBkaWdlc3RfYWRkciA9IHNyY19hZGRyICsgMHgx
MDAwMDAwOw0KPiA+ICsgICAgY29uc3QgdWludDMyX3QgZGlnZXN0X2FkZHIgPSBzcmNfYWRkciAr
IDB4MTAwMDA7DQo+ID4gICAgICAgdWludDhfdCBkaWdlc3RbMzJdID0gezB9Ow0KPiA+DQo+ID4g
ICAgICAgLyogQ2hlY2sgZW5naW5lIGlzIGlkbGUsIG5vIGJ1c3kgb3IgaXJxIGJpdHMgc2V0ICov
IEBAIC0yMDAsNw0KPiA+ICsyMDAsNyBAQCB2b2lkIGFzcGVlZF90ZXN0X3NoYTUxMihjb25zdCBj
aGFyICptYWNoaW5lLCBjb25zdCB1aW50MzJfdA0KPiBiYXNlLA0KPiA+ICAgew0KPiA+ICAgICAg
IFFUZXN0U3RhdGUgKnMgPSBxdGVzdF9pbml0KG1hY2hpbmUpOw0KPiA+DQo+ID4gLSAgICBjb25z
dCB1aW50MzJfdCBkaWdlc3RfYWRkciA9IHNyY19hZGRyICsgMHgxMDAwMDAwOw0KPiA+ICsgICAg
Y29uc3QgdWludDMyX3QgZGlnZXN0X2FkZHIgPSBzcmNfYWRkciArIDB4MTAwMDA7DQo+ID4gICAg
ICAgdWludDhfdCBkaWdlc3RbNjRdID0gezB9Ow0KPiA+DQo+ID4gICAgICAgLyogQ2hlY2sgZW5n
aW5lIGlzIGlkbGUsIG5vIGJ1c3kgb3IgaXJxIGJpdHMgc2V0ICovIEBAIC0yMzQsMTANCj4gPiAr
MjM0LDEwIEBAIHZvaWQgYXNwZWVkX3Rlc3Rfc2hhMjU2X3NnKGNvbnN0IGNoYXIgKm1hY2hpbmUs
IGNvbnN0DQo+IHVpbnQzMl90IGJhc2UsDQo+ID4gICB7DQo+ID4gICAgICAgUVRlc3RTdGF0ZSAq
cyA9IHF0ZXN0X2luaXQobWFjaGluZSk7DQo+ID4NCj4gPiAtICAgIGNvbnN0IHVpbnQzMl90IHNy
Y19hZGRyXzEgPSBzcmNfYWRkciArIDB4MTAwMDAwMDsNCj4gPiAtICAgIGNvbnN0IHVpbnQzMl90
IHNyY19hZGRyXzIgPSBzcmNfYWRkciArIDB4MjAwMDAwMDsNCj4gPiAtICAgIGNvbnN0IHVpbnQz
Ml90IHNyY19hZGRyXzMgPSBzcmNfYWRkciArIDB4MzAwMDAwMDsNCj4gPiAtICAgIGNvbnN0IHVp
bnQzMl90IGRpZ2VzdF9hZGRyID0gc3JjX2FkZHIgKyAweDQwMDAwMDA7DQo+ID4gKyAgICBjb25z
dCB1aW50MzJfdCBzcmNfYWRkcl8xID0gc3JjX2FkZHIgKyAweDEwMDAwOw0KPiA+ICsgICAgY29u
c3QgdWludDMyX3Qgc3JjX2FkZHJfMiA9IHNyY19hZGRyICsgMHgyMDAwMDsNCj4gPiArICAgIGNv
bnN0IHVpbnQzMl90IHNyY19hZGRyXzMgPSBzcmNfYWRkciArIDB4MzAwMDA7DQo+ID4gKyAgICBj
b25zdCB1aW50MzJfdCBkaWdlc3RfYWRkciA9IHNyY19hZGRyICsgMHg0MDAwMDsNCj4gPiAgICAg
ICB1aW50OF90IGRpZ2VzdFszMl0gPSB7MH07DQo+ID4gICAgICAgc3RydWN0IEFzcGVlZFNnTGlz
dCBhcnJheVtdID0gew0KPiA+ICAgICAgICAgICB7ICBjcHVfdG9fbGUzMihzaXplb2YodGVzdF92
ZWN0b3Jfc2cxKSksDQo+ID4gQEAgLTI4NSwxMCArMjg1LDEwIEBAIHZvaWQgYXNwZWVkX3Rlc3Rf
c2hhNTEyX3NnKGNvbnN0IGNoYXIgKm1hY2hpbmUsDQo+IGNvbnN0IHVpbnQzMl90IGJhc2UsDQo+
ID4gICB7DQo+ID4gICAgICAgUVRlc3RTdGF0ZSAqcyA9IHF0ZXN0X2luaXQobWFjaGluZSk7DQo+
ID4NCj4gPiAtICAgIGNvbnN0IHVpbnQzMl90IHNyY19hZGRyXzEgPSBzcmNfYWRkciArIDB4MTAw
MDAwMDsNCj4gPiAtICAgIGNvbnN0IHVpbnQzMl90IHNyY19hZGRyXzIgPSBzcmNfYWRkciArIDB4
MjAwMDAwMDsNCj4gPiAtICAgIGNvbnN0IHVpbnQzMl90IHNyY19hZGRyXzMgPSBzcmNfYWRkciAr
IDB4MzAwMDAwMDsNCj4gPiAtICAgIGNvbnN0IHVpbnQzMl90IGRpZ2VzdF9hZGRyID0gc3JjX2Fk
ZHIgKyAweDQwMDAwMDA7DQo+ID4gKyAgICBjb25zdCB1aW50MzJfdCBzcmNfYWRkcl8xID0gc3Jj
X2FkZHIgKyAweDEwMDAwOw0KPiA+ICsgICAgY29uc3QgdWludDMyX3Qgc3JjX2FkZHJfMiA9IHNy
Y19hZGRyICsgMHgyMDAwMDsNCj4gPiArICAgIGNvbnN0IHVpbnQzMl90IHNyY19hZGRyXzMgPSBz
cmNfYWRkciArIDB4MzAwMDA7DQo+ID4gKyAgICBjb25zdCB1aW50MzJfdCBkaWdlc3RfYWRkciA9
IHNyY19hZGRyICsgMHg0MDAwMDsNCj4gPiAgICAgICB1aW50OF90IGRpZ2VzdFs2NF0gPSB7MH07
DQo+ID4gICAgICAgc3RydWN0IEFzcGVlZFNnTGlzdCBhcnJheVtdID0gew0KPiA+ICAgICAgICAg
ICB7ICBjcHVfdG9fbGUzMihzaXplb2YodGVzdF92ZWN0b3Jfc2cxKSksDQo+ID4gQEAgLTMzNiw4
ICszMzYsOCBAQCB2b2lkIGFzcGVlZF90ZXN0X3NoYTI1Nl9hY2N1bShjb25zdCBjaGFyDQo+ICpt
YWNoaW5lLCBjb25zdCB1aW50MzJfdCBiYXNlLA0KPiA+ICAgew0KPiA+ICAgICAgIFFUZXN0U3Rh
dGUgKnMgPSBxdGVzdF9pbml0KG1hY2hpbmUpOw0KPiA+DQo+ID4gLSAgICBjb25zdCB1aW50MzJf
dCBidWZmZXJfYWRkciA9IHNyY19hZGRyICsgMHgxMDAwMDAwOw0KPiA+IC0gICAgY29uc3QgdWlu
dDMyX3QgZGlnZXN0X2FkZHIgPSBzcmNfYWRkciArIDB4NDAwMDAwMDsNCj4gPiArICAgIGNvbnN0
IHVpbnQzMl90IGJ1ZmZlcl9hZGRyID0gc3JjX2FkZHIgKyAweDEwMDAwOw0KPiA+ICsgICAgY29u
c3QgdWludDMyX3QgZGlnZXN0X2FkZHIgPSBzcmNfYWRkciArIDB4NDAwMDA7DQo+ID4gICAgICAg
dWludDhfdCBkaWdlc3RbMzJdID0gezB9Ow0KPiA+ICAgICAgIHN0cnVjdCBBc3BlZWRTZ0xpc3Qg
YXJyYXlbXSA9IHsNCj4gPiAgICAgICAgICAgeyAgY3B1X3RvX2xlMzIoc2l6ZW9mKHRlc3RfdmVj
dG9yX2FjY3VtXzI1NikgfA0KPiA+IFNHX0xJU1RfTEVOX0xBU1QpLCBAQCAtMzc3LDggKzM3Nyw4
IEBAIHZvaWQNCj4gYXNwZWVkX3Rlc3Rfc2hhNTEyX2FjY3VtKGNvbnN0IGNoYXIgKm1hY2hpbmUs
IGNvbnN0IHVpbnQzMl90IGJhc2UsDQo+ID4gICB7DQo+ID4gICAgICAgUVRlc3RTdGF0ZSAqcyA9
IHF0ZXN0X2luaXQobWFjaGluZSk7DQo+ID4NCj4gPiAtICAgIGNvbnN0IHVpbnQzMl90IGJ1ZmZl
cl9hZGRyID0gc3JjX2FkZHIgKyAweDEwMDAwMDA7DQo+ID4gLSAgICBjb25zdCB1aW50MzJfdCBk
aWdlc3RfYWRkciA9IHNyY19hZGRyICsgMHg0MDAwMDAwOw0KPiA+ICsgICAgY29uc3QgdWludDMy
X3QgYnVmZmVyX2FkZHIgPSBzcmNfYWRkciArIDB4MTAwMDA7DQo+ID4gKyAgICBjb25zdCB1aW50
MzJfdCBkaWdlc3RfYWRkciA9IHNyY19hZGRyICsgMHg0MDAwMDsNCj4gPiAgICAgICB1aW50OF90
IGRpZ2VzdFs2NF0gPSB7MH07DQo+ID4gICAgICAgc3RydWN0IEFzcGVlZFNnTGlzdCBhcnJheVtd
ID0gew0KPiA+ICAgICAgICAgICB7ICBjcHVfdG9fbGUzMihzaXplb2YodGVzdF92ZWN0b3JfYWNj
dW1fNTEyKSB8DQo+ID4gU0dfTElTVF9MRU5fTEFTVCksDQoNCg==

