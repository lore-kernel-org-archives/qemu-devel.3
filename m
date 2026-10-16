Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBEC3CCA46B
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHeTP-0000qE-18; Fri, 16 Oct 2026 05:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHeTN-0000pT-0F; Fri, 16 Oct 2026 05:43:33 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHeTK-0007Hq-Br; Fri, 16 Oct 2026 05:43:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dfOEQCI8fEsRPYA6N8Z6kpICuGClFjChex2vnJWFaMBSuUJh1Q41IJME1UASqgj9SpKhvnoHjd7XB849zsu+8J1KK3tzzontDtTX2RayV+Ool7jS4dtstr7JoCmikzuXVuLEfOfofFAwq/AV9wcQvF+UcKXOzqd6iHaf2gYLHH1USS+j+1iEtillVEBOW5b6oD13aamyFPavdzQaXpdNaa7OU565+mqqxdKKs4tbaQzMYwD1MAts/lox/7QrXwmGOzVN0rT94JtI3Z56JngCusD8Vw49s9dMchgTSVhpV0mMb0jcfh0fWEMUHat+dugmRXzE7J+3WDkcZZX/eXpi7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stpMrkOUCQawQ7vwvpGByilVQvYKiUrQjoX0tLC7tJ0=;
 b=rd32cRFlsYA29IGdm8gQGT2G6QeZ6d5XX5l0NlmslW4G9IqrVV+5O7Vk3oI4J7f6bcybvmnXTnPtWkIjx8lxhwZpa1t99ez2ks76leXf5G+mkdzDmtJpZ8d8JZMG1TV0dz8hjlXfl+kbS3Hih/CtCcZuL/f8+5XnS/p+E7bWiBWhd/JfXQ5EIUPtrw6So3/R1MahTKGDlvav1ZB5eq576ZvrGJKHSa4ZH/vT3lQJ4+Ks0549STZnZZIsCTH8vl5NGLsCiGhq+HFsZ+xvepctMHHDsQWj3mZdBjl3qml19z7JvlEaV7bsacuRrSI+2dCp+N9BKFHyLZgiH4BAg8oTyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stpMrkOUCQawQ7vwvpGByilVQvYKiUrQjoX0tLC7tJ0=;
 b=WQIsS9hgPoARc+eX7Ny2swpiiq1eIbOgIxr3zW1x60l18x2S+TyQTYtaL1500ffaicDufitxjXfs72+MhSHxxRIUF7DVJV1eIUPNCVYizkfPiz/7vEt15sxFslvCnQCqHiKey+SeayNhWqye1Y6CHA6upKJ92lqYxDaQHdEDXIjhgfgAwkoc52KXhna5qyCqm1wgwFRDu7a/ZdnKmIw3ngeTAIR2ZhpNX/gw0uU2s4jPgmtjohj9KUyo36btU6ePlUqEHIQuojgDFB3SIE7CCWGoJ1dgXRFiWOPNBYpFyklwtF7X6tGK2fWXm1DspP1ZK743iBrRzXR+Ssq89gM+4g==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEYPR06MB6664.apcprd06.prod.outlook.com (2603:1096:101:176::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 09:43:21 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 09:43:20 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Emmanuel Blot
 <emmanuel.blot@free.fr>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, Patrick Leis <venture@google.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@oss.qualcomm.com>, Glenn
 Miles <milesg@linux.ibm.com>
Subject: RE: [PATCH v2 00/50] Aspeed: I2C device models and the Minerva BMC
 machine
Thread-Topic: [PATCH v2 00/50] Aspeed: I2C device models and the Minerva BMC
 machine
Thread-Index: AQHdWttneyMnc1G7/EmpD7Pf4OOALLb7AcpQgAAD7QCABOk8wA==
Date: Fri, 16 Oct 2026 09:43:20 +0000
Message-ID: <SEZPR06MB73628B7F0581B8DBF62DC72DFC9B2@SEZPR06MB7362.apcprd06.prod.outlook.com>
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
 <d7da10db-04a0-4699-8a96-44e98170f863@kaod.org>
 <TYZPR06MB73731318F235CD2797C03D2FFC9E2@TYZPR06MB7373.apcprd06.prod.outlook.com>
 <fbead52a-4ac2-48d2-8cac-fe1f24005caf@kaod.org>
In-Reply-To: <fbead52a-4ac2-48d2-8cac-fe1f24005caf@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SEYPR06MB6664:EE_
x-ms-office365-filtering-correlation-id: d1412bfa-ab95-4e6c-49a4-08df2b69ea15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7416014|23010399003|10067099003|22082099003|18002099003|261009223027099003|4143699003|38070700021|56012099006|41080700001;
x-microsoft-antispam-message-info: ucjvZAz+Uvnmc7L+ICrwRsycfO0pqOefTT6Z0iJWECTUOPha+QK4JdZ/Lt0CWTKNPovx98CvhXI1MFnJXSD9XS9gvBz9utyt3bemsebQWGskylD+Hrm1lGx6hS1ULWQD9wO3KH2LFqc1k89QiOLZ7f4ketrEgtWU8WX/ileEvyfHFEBSL+3FcbWPv+I0qD8Grb/4SX7HqjZZevIJXJ1D1f5BlkpPEVYcC5j05wHHw/1ljv9dBkfxxq5bfcFalKYxepwHOtRSauSKAan5XZsKjrrDiv5BZ37u488RWvIYiR5QZ4NUq1PCZmlWSdWPdJE9u7DfO6GR8qrzU3gM+pSL5FURkJtFbV5Sglp4vQa34Okc0E0i/Z2vHIApNI+usaetqPHdnv7XvmVrAscUtXqA0yJJGdR/VBLssSjrNGF0ByPTrTnCh9s7VmksCQ7ZqW8fZJzI+EFeltkuu7gvOFmuxBxSdEoCGmd7J1mE1zbMh6vVdGm5o9hodcUe5eGevmBisTkOiawLygofzk5M8lXEC926Yyz9lXau8JZKxZBPuKNh7fQVWnTas/XbWL/n27l8npdzOSy6kop0LP7rpdJOA5s89vCwfW7ZQTnr4LZPmybjjspZjfsy+41eZXYedXaSFiwQICtC1/3qgbu43+SYcOIXyvozz0LMXpdsV3k9ZzvF6AgQzoUdZjNjhgqh7MCfsFkd5JWLwc4kUfOBvALpiw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014)(23010399003)(10067099003)(22082099003)(18002099003)(261009223027099003)(4143699003)(38070700021)(56012099006)(41080700001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGxwdmdLRGVyRlhPUHl2ZmhzRTVTdUtPN0xkenlhQVFpaWZCTjh2bGwwLzI4?=
 =?utf-8?B?QU5jaEhMUWwwMGk1TlVFMDhkQTlkZzN0ZEY1clRnZkI3VFB3NGJQTnR6U3FE?=
 =?utf-8?B?Tm1ybUlRbnU1SWZYTVlnR2pIMjhZdTdlbndORXhMZHlTVXFybHFjekNjQUhP?=
 =?utf-8?B?cVF4OEVsK05CMEZma29GdGRjTld6ajl1U1lxaHAxT3pPNFBzWEptWUxXbHJz?=
 =?utf-8?B?Y1h1Q0o5T0ZucnR1eGZUUzB1Ym5jQXZnS0RJakZONDlTd0hWMkZ2bXIxRlhG?=
 =?utf-8?B?L1p3WDB6QmpUTDZ4NUU2UERoTDZidjFGSHc4MVlSTkxYNUI2dGNmeGxkbngv?=
 =?utf-8?B?YXhUNkFPSXkyMVVxR0I3cXZBMHF0ZnNSVlZ0ZmNnZi9TTVREbTQ5dWpnbUxD?=
 =?utf-8?B?SFB5UDdjR0ZkRnV5TGlMVElVNTBsTjRzSTNzTHF3SjJZQWdIcVZ4K0k3aGZy?=
 =?utf-8?B?N3ErUjR0bS9aVWJaZG9IcXlMelEvTk5NNDE4TGd1L1dEYXM2STJqVVZvcmQw?=
 =?utf-8?B?cENWSmYxTENDZWNKaE5IVlpPYngyZ2p0SGFmVjhUd1d0YlNRK20vQ0YvZ0xR?=
 =?utf-8?B?dWZpWTNCUTNnL1NOOXY0eU1obU9HVlhQaFhJMVBQSThPWjZScXlBK3lQeDEz?=
 =?utf-8?B?YTdBdUkySkxwcldISXhDZk5nY1piZ1RsZnFEZnJmMEFVZ0kvclNSd2hvbmV4?=
 =?utf-8?B?RkxRTWNSVmozWG9YOTFvZzlLQkwwdFBvYUQ1ZjV4MmpyUXN6a1kxdkdWM2hP?=
 =?utf-8?B?emFmN0ZpWDFCd0ZSSUYyVGdTNGtjamtJS0ErbVl5R2pwbDJEeG94ZUg2b2dU?=
 =?utf-8?B?bWpyRGlqeFJmSko0TkVmWVE1THh0QVRqUWRRUHdvV0lnRjJMUmswMVpwbVJi?=
 =?utf-8?B?RVlPSHNPVGZyTkk0blJucTRkZC9XT2tESjVPb3Jpb042MFJiNUZvL2RkQ2tB?=
 =?utf-8?B?eWdUdUZqUEtsQXhPTTBLRnBUN3p0SXhvb01sUUNiQk5nWURiZUxGOUxvZTZV?=
 =?utf-8?B?MndLemlNOUhGKzJEMzVTdEN6dWhicjVZdTBFSTJxZk05SThGWkwxN0dBeXhr?=
 =?utf-8?B?b2ZtNE8xeXdaOHBLdkt3MW81TFhFaTV1dTlBWnBOelJRdm9yNnZDU2pFMVh4?=
 =?utf-8?B?S21wME4vbnJkVGhvc292UzdYMncvcUUyZ0o0d1drOGNsT3V5TkxlWmRiTDky?=
 =?utf-8?B?emhUSnBta2N0b3EzMGdlbWlwU2tXRUhwNHRwUld3WUZFa3dSbGZtME5ranFy?=
 =?utf-8?B?b0QxS1RaR05OcDJoeDJuUGtTQlpXd244Y3kyVzNXM0o1ckkzZHFSMmw5ZnND?=
 =?utf-8?B?TFVxUjZDZ1hUMjNDb3cwNGJiOWIyYjhEWHRHY1g1S3lUOWo2Unh1ZGx4QWFn?=
 =?utf-8?B?c0xyNW0yMmFtY0dyOVo3SHVTbllPa0xwbHFMbm1pTXZ1UFJ1aVVLT1IwVVFH?=
 =?utf-8?B?SVF6dkZSOTdzdFJNUVRzL2poeCtDelFHZkdYd1RZK01QODhPMXNVNENmQzFs?=
 =?utf-8?B?VGpoQUFGM0o4VUxQMndHU1BuaE9ZaUwrTlV2T2poa1R4V2trNHR1OEkyeGZ4?=
 =?utf-8?B?WmtPWHNsY3hkejd4aXdORnE0Q3ZWdE5IUnVhSUJHZEgxdFpGK1JURVdXOUZt?=
 =?utf-8?B?bDQ0dVgzMXliWlVacmp6alhVc0FOeGJ0SUgrYmMrc2k0SjRKNjNmK1J4MllE?=
 =?utf-8?B?Z1RCMFg5eVMwVUJXeWMyeTVwQVNrSFJPWitkc2NmYTJNSllQRlZuV0xjTkpu?=
 =?utf-8?B?S3pudUhCVGFDVGFhVkRWTThWYTl1eGVlc05UcHRvTTJYMTMrSk1GVmZTVENp?=
 =?utf-8?B?YWVNYllqZ1hjRERKTjUrbkNNK21SQ2hBcjVaQXhPRE9IcHVONExWbUpjYUlR?=
 =?utf-8?B?YzBRT0sxTmxyaXE1ZVFHcUJiWFVPbHk3RERHMzhiZ1N4eFBvdlVxZU94d3BQ?=
 =?utf-8?B?akZ5OU9BQjZBVTlLRGd6R2Vhb3hpYWtaRklXRHd1MmdSR0F6YnpKaCtEcmRK?=
 =?utf-8?B?SExkNzZVbDFDNHVaVG1BWjh3VURRZXNOL2JLYXFjTDFBaHNxcElhOUpaSW1z?=
 =?utf-8?B?ZXZQNmo5bS9jclBETUZaY3N1K3ZNT0ZiMWR1QjBvbkVIRkVRU0pzNXdYNmI4?=
 =?utf-8?B?d1BkS3AzZ1cxOUdkM0hEdDNjaW5KWmJLdytvRDh4Mld1WExMNS8veGQ1TmRU?=
 =?utf-8?B?a3lnUE56cWRmendQTEZhZ2ZjNjJ0NkowVVJheVdOZTl3YmttRCtyeXhoUnQ3?=
 =?utf-8?B?d0NrUHhyd29OazJha0ZNc3VSZ3pseVZPblIrZVh0VFFpcEQwMWY3RkZJS1Ja?=
 =?utf-8?B?S1Y1ZVZhek41b0hvaVBrdjRZejBRaFZCTmdVR3lkY2xnc3JIVmRIZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: e8XtIHQf5dzShx4Zdz54GNIfjQ96oWwlsgII7g8ebfNVdGPofNWBK4mHoA9aDGr41ITN9ffjlrERzZhUFbR6L08YZmSf7mzKyYDfOwkMeDLqFJ7WoOFAhWf3t8izbo3eSh8VH6q6IZuAPLHLjGDt740CYUrVuHq5p7bsJZL+9gRoJI4lDvo0XshR95ppXNmgZ901uxL4KaxQcpGCz44EzIpeIRPcdFRsxFDQQuFHjXFfilscJ++oMgukbXGzASp1geFp2Cr0XUK4QfXFIXf3cAdg6SdLuzvmk9Sa8EH+cKFnlqYcaMuOvXn7gXLgXdaD8JYKYhq25IoeWWEIB0/PNg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1412bfa-ab95-4e6c-49a4-08df2b69ea15
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 09:43:20.8387 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Weyu+wxiNahdbDDW+sZzxk3SbJizHnuZuTTtUd9zSO+KTP2hWak8eeTQDheqTkXlHtROh0eG8/SY7WmcNsEGxYG3aGEi/mPcKbdr0BAu0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6664
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDAvNTBdIEFzcGVlZDogSTJD
IGRldmljZSBtb2RlbHMgYW5kIHRoZSBNaW5lcnZhDQo+IEJNQyBtYWNoaW5lDQo+IA0KPiBPbiAx
MC8xMy8yNiAwODozMiwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IEhpIEPDqWRyaWMsIEVtbWFudWVs
DQo+ID4NCj4gPiBEdWUgdG8gYW4gaXNzdWUgd2l0aCB0aGUgQVNQRUVEIG1haWwgc2VydmVyLCB3
ZSBjYW5ub3QgcmVjZWl2ZSBwYXRjaGVzDQo+IGRpc3RyaWJ1dGVkIHRocm91Z2ggdGhlIFFFTVUg
bWFpbGluZyBsaXN0LiBXZSBjYW4gb25seSByZWNlaXZlIGVtYWlscyBzZW50DQo+IGRpcmVjdGx5
IHRvIG91ciBBU1BFRUQgYWRkcmVzc2VzLA0KPiANCj4gVGFrZSBhIGxvb2sgYXQgbGVpIDoNCj4g
DQo+ICAgIGh0dHBzOi8vcGVvcGxlLmtlcm5lbC5vcmcvbW9uc2lldXJpY29uL2xvcmUtbGVpLXBh
cnQtMS1nZXR0aW5nLXN0YXJ0ZWQNCj4gDQo+IEl0J3MgYSB2ZXJ5IHVzZWZ1bCB0b29sIHRvIGNv
bGxlY3QgbWFpbGluZyBsaXN0IGRpc2N1c3Npb25zLg0KPiANClRoYW5rcyBmb3IgeW91ciBzdWdn
ZXN0aW9ucyBhbmQgaGVscC4NCg0KSSBub3RpY2VkIHRoYXQgbXkgcGVyc29uYWwgR21haWwgYWNj
b3VudCBzb21ldGltZXMgbWlzc2VzIGVtYWlscyBmcm9tIHRoZSBRRU1VIG1haWxpbmcgbGlzdC4N
CkkgY2FuIG5vdyB1c2UgbGVpIHRvIHJldHJpZXZlIFFFTVUgcGF0Y2hlcyByZWxhdGVkIHRvIEFT
UEVFRCBpbiBteSBsb2NhbCBWTSBhbmQgbXV0dCB3aXRoIG15IHBlcnNvbmFsIEdtYWlsIGFjY291
bnQgdG8gcmVwbHkgdG8gcGF0Y2ggcmV2aWV3cy4NCg0KVGhhbmtzIGFnYWluLCBKYW1pbg0KDQo+
ID4gZm9yIGV4YW1wbGUsIGJ5IGluY2x1ZGluZyAtLXRvIGphbWluX2xpbkBhc3BlZWR0ZWNoLmNv
bSwgLS1jYw0KPiBqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20gb3IgLS10by1jbWQgIi4vc2NyaXB0
cy9nZXRfbWFpbnRhaW5lci5wbCAqLnBhdGNoIg0KPiBpbiB0aGUgZ2l0IHNlbmQtZW1haWwgY29t
bWFuZC4NCj4gPiBJIHdpbGwgdXNlIG15IHBlcnNvbmFsIEdNQUlMIHRvIHJlcGx5IHRoaXMgcGF0
Y2ggc2VyaWVzLg0KPiA+IGphbWlubGluMTIwN0BnbWFpbC5jb20NCj4gDQo+IFRoYW5rcyBhIGxv
dCwNCj4gDQo+IEMuDQo=

