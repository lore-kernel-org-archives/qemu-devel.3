Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E88C021B2
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 01:32:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlHtN-0003HV-Ec; Thu, 20 Feb 2025 20:31:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tlHtL-0003HJ-VO; Thu, 20 Feb 2025 20:31:47 -0500
Received: from mail-sg2apc01on20721.outbound.protection.outlook.com
 ([2a01:111:f403:200f::721]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tlHtJ-0001qG-54; Thu, 20 Feb 2025 20:31:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jNOz8LL9g399Fvy7d1MkKH1W163PCunk6WPc6tTpHubufRD8x9VsVF4DjH2oaLnFpJ8alOaUXYXEnvEbWy9VkLWclI2a+yO0/8A8IMNqojkuMQbZUHMzgBD5MMNd7klpRIMSERxoFS120kp8jwzyAO+/BsfOXMCqQescl9mhx2KYS+CehPR9Y5yW4i95qzvmjv3vGkR7C5aCIGbe9f9kf5joUQ4EL1idMs8fPfwSkMSQme5Icr1kPazPRio6ycrKOxZlJUDlnPJs6BHWsdIi/hVCV5KItBFUSTgvX28spnXKi1DXSTcJCqvKP0agWOmY6C2qKJyBqymZgfqxQSz5jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zwsskj9jUBQyFAH7UXfPBfJFYWOinEjS5Rq7DQb2ur4=;
 b=sygVtiTfnFomLxyXgBlWmg64YpGkO4Jv8SNAFsjBQ0J7nJwJGk1nkFW9LLTQ2paj2bog0xToHQyt2SZcMsFX6Rf8u4F1H473fbkr83U13rC6nwJgCowpfZdRxs9tlXC0be08uEXzS3FDDtU1S1ry8ck4KJRAYs06ICVO83xnWIKkI2qte9U5NfA8fCLd79L3ySButMaDgZ84+NfoDx/WMoLja4k6P5/5rxmIdj01+s9xjYuXaWOjY8eJAR/CwUOG+S5enYv4baUK6yJHdTupwCWkZ2Csgid/LroLz38HnkmkB22Bth7/pYVmt2OakF4XhZy81fCzGX8FqDVziLqGJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zwsskj9jUBQyFAH7UXfPBfJFYWOinEjS5Rq7DQb2ur4=;
 b=cBT3gov2ShK8AJ6xR6uAo24YcyyP/4xLktUahmyGN2IGP3pcnDXbGXd2d4dPMORLzFW/qk7JX7qA6O6wfUPns1OsYJ2XPsAES6hcoFUmInoWmd8EbL5Z203muqIiOZ2C1I0zkTfy6L6qQ+WKxFYIWrgk6ylUS5M0CG4aMLKLc0PVfO+irTWEIxrWItnTcj/h5v7tSlcJjP1ZE5arfbHw96TnvZGRJ6gdGc0RBQFPUcl3ulFovPTSVy8PJqEahuo5JvuCKA9RmoURFcqys9t8tlI54U3AFdVn0yjOMhvuox/GAWnIwOZ5Fv36mT/Ge2fk/FpRIiSj0atj0kuH/nl03g==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SG2PR06MB5034.apcprd06.prod.outlook.com (2603:1096:4:1c5::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.16; Fri, 21 Feb 2025 01:31:31 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 01:31:31 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v3 08/28] hw/intc/aspeed: Add support for multiple output
 pins in INTC
Thread-Topic: [PATCH v3 08/28] hw/intc/aspeed: Add support for multiple output
 pins in INTC
Thread-Index: AQHbfchgk+KyJzWDA0CUYbiG024hj7NMl20AgARs3BA=
Date: Fri, 21 Feb 2025 01:31:30 +0000
Message-ID: <SI2PR06MB5041A8E63EABB1DED675BDACFCC72@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250213033531.3367697-1-jamin_lin@aspeedtech.com>
 <20250213033531.3367697-9-jamin_lin@aspeedtech.com>
 <113e2f4e-ee25-4cd3-bbd3-1f575cf123ff@kaod.org>
In-Reply-To: <113e2f4e-ee25-4cd3-bbd3-1f575cf123ff@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SG2PR06MB5034:EE_
x-ms-office365-filtering-correlation-id: e3c30062-d823-490b-6eb0-08dd52177810
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RUhzMUUzd2VLaU5JbUJBMmxVOStndW04VEJzZHVZRkY0Z040VHdISWVROEU1?=
 =?utf-8?B?VWFjTDZDaG1TQmpUbGRNK0pjNTlLdVN0S1Y0QmpTSHUrUkdiZGVNaHVHVzhq?=
 =?utf-8?B?VFY0eFZSVUlRMnVhaXUrdGQ4bkdXWXA0RnoyNWxjSlZtUlNSTWt5SGZFbDVL?=
 =?utf-8?B?Q2ZmdkN0WHNGbnNzQ2ZwTktlRjRINCtCOWU2RXFWSm1MZlJ6eU0yMHZWazdp?=
 =?utf-8?B?R2p1ckhyZlNId1VkQjVobE5rbmdSQU9xc1VCejRseERBZm5kbXpZVXBYY3Vv?=
 =?utf-8?B?MU93Vm5vMUxFRjB3enJhVEJQNUo5dHVBc2F3UUp5S20xUGVlRGoyS1FXdnVQ?=
 =?utf-8?B?ZUpaWmJaRkV0bEVSQUdzWDRjdDVTSWwyVWdFcCtnQUdiSFJFTktDM1FGaDFh?=
 =?utf-8?B?OGJPSmU1b2hjZ05UbkFqVkhEcWNDZGliVWhyMGNZK3ByTGZMNVl1c1lSNkMz?=
 =?utf-8?B?S0RCZC9JdG9XVHNCSWpqZ0xCenR1RXVycUZmWm1mYkVZQ0gxMzlRSy9QVm50?=
 =?utf-8?B?U1hIYkRMMHBXOFNseHVMeDF5elJUeHZvN1lTc2k0NEVpTTg2UmxPYTY4VlpS?=
 =?utf-8?B?MktVSzNnUjQ5ODhYSGliMnBLcUtabk9mTnhMYTdvRk5sVXVoZVV1cjhRdGJj?=
 =?utf-8?B?a1BiVExrSHMrazdvaC9nSlBQVkJhV1M0RTB1eThaUFpoR2k1Vk5mRDM4OE9W?=
 =?utf-8?B?K2hMcmpWYytWNTkzWHdvdXozUENiY2VXS1Z6anZIRzBoUDFCZW4ramkrRVNI?=
 =?utf-8?B?emJSYW5XRDBCUFdFaTQwVnhLckQ0RVoxV2RjRnM3SFA5dXRxZ0VsVTFZY2dE?=
 =?utf-8?B?bHZORDRtQnZiOEhlL1MvOCs1NUpBeU9HUXFHMFNGOWdtSWQwZ05DVTRtaXZq?=
 =?utf-8?B?NlBac1ovTHNCMDdHd0FINmxBdTZzYlprWUtXQ0Fpa3RZU3hTUC9yN0swUGlX?=
 =?utf-8?B?bkVVUEZsakg0Y2tXK09ibFkwOWRCbVdMOWpsMmFaK3lCVEM1M3FPVG9TY0pN?=
 =?utf-8?B?dUpSamZmUmx2RWpIMzJzYkJmQmw3THgzTzRLOFJ5eVJEVUdGMi9WZGNPclQ1?=
 =?utf-8?B?SHRlVithellkNkM0dWNlUG5IaE5jWjJTNnFkZGxWVXFPM3BhQkI0cDhWTmFi?=
 =?utf-8?B?d2FCUzViM1FLSDFBUlh6QUtPQmpWZjhmN3RHd1hxdFppcWNLUkFMN21tTEJq?=
 =?utf-8?B?TmlqaFRVM1ArMm5TaUxQTHAyb1lYa2JrWjlxOUZ2WGRDdndFQkpBOTZwT3Bk?=
 =?utf-8?B?Qno4VVJodzFHeHNEUllOTGNOOHhQUXNhQ0xEK3dQRlg2bW4za1BpazN3UW1J?=
 =?utf-8?B?aXBjaHByNnhpdk5yNVhNMFVYUmlzVFBpWkhJM2VSM3dRczBWTnpsL0JXanc1?=
 =?utf-8?B?Y3FmRVVIY0g3Rkt0aWZMREp3TU85SkNMYm9XQko0YTB0THAvT3ViSnZkcVNz?=
 =?utf-8?B?bkZQbE1VSndKNWxvbnhlZDJaOGlQam5zU0NWay9LVXhJbGV6SVpqRGZGOUlK?=
 =?utf-8?B?eWNVank0UDVsWVJDSHZ1alJyMk1JWUJrUmJzblpna3JmUjJNU2RpYlpUOVlJ?=
 =?utf-8?B?S2tmVklCcEtQZXI2dllKNGVTT0V6eDlVaGw3TFc4MFVLalA5cnBYZmU2R0FP?=
 =?utf-8?B?VjV1enBpeFEwblhSQkZOckx0cUg3eVZwWFYrRjdvc3NBM29CdWxqb1J1SlJr?=
 =?utf-8?B?U3BkSUFFMDRsOUh5ZTc5OW9HcTV1c01weE9LdHJ2eDdGL0dxWmpZclFyYTBR?=
 =?utf-8?B?a1N6Q1NHaUg1ZlowR3dENEZ2TFpJZ2FpVHA5blI5RjZYYVozZXNtRXJJY1VL?=
 =?utf-8?B?WVRSL0ZvQkJncnBjN3UxN0szU1Y5bXk1QTl0QnZ3OUxEbUVaR0gycUluTHhV?=
 =?utf-8?B?TnEvVFB1ajNFNjJqZmF4YUtPcGNVWjRUMTZabUlxUkwxS3JxUkZQU0c5WTdh?=
 =?utf-8?Q?oo2hJEQnj3TtRyS8MluJQqlh9tjoWC4C?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3ErUWtJZm5rajF0ZjRPdUVtbzMrN2p3RFJtZGxhbGwyNU1INm9IaGwxOHJ5?=
 =?utf-8?B?djFNKzRJZG1oaWI0YTU3TEptSldUK2NlVVh2VnR3RzYwTFE3eHFjZm9oOVh2?=
 =?utf-8?B?MS92ZWlkcHlhV0tacXJIcTZFZVo3WTlZV0drbkFqR3VpRGEySWtxYnozdlhX?=
 =?utf-8?B?VHQxb3BjNkR2SEpTQUxNVmliOTJwdlhqQitqSXpWWG5MYXZaVTgvenJObW55?=
 =?utf-8?B?SXcwRnA2WUdWS1BQaG5vYWhmU3JubVNrdFZJdDYzMFM3bUc4VEpwSy9ScDdx?=
 =?utf-8?B?RGJDeCtDMC9ZSUkyU2owalBpM3FoeGU2OVg3N01wbGIyTUN6VXUyb2ZhOEh1?=
 =?utf-8?B?SEYwZlo2M3RBSEhyWTRJZkVFQldXMmVFVzVSWXZQcVROMCt1UTN3RlRCcDZO?=
 =?utf-8?B?aUphdTZETklnSVpWbmVSdUxZbkxSY0RWeUxZMEJTZ0dsZmwwd2U0Nkd0WjI5?=
 =?utf-8?B?TlhOSmFrY2NUNUhNemwrU0FCWFJMRWI4Mm1mWnMvZ2ZUenpJdytYdElNaWdT?=
 =?utf-8?B?VE9XWkJ2RWxFaGZKYU1Odnozc2YrTHorODZNUkxuR3ExdlhEK0NHa0xzbnFm?=
 =?utf-8?B?LzdTMXo5TVF0RDRCNk5SR2Z1ekZqNlFMMENlSWlxTnpZSjZRRHphNkg0Sk9W?=
 =?utf-8?B?WWhTQTQvemNyUVh0LzU4MG82RkNua2Y5MzVMSUV6UkhIY0tBc1ZFejlZckJ5?=
 =?utf-8?B?RjFYdU4xcEIxems5UTk4dk5RY0JDSXU0YVRyRGVQWVJCbHh4TThUTjJ0aUUy?=
 =?utf-8?B?cG9IRElXSHNkRUJjWnZzKzQraXBUa2hjSlZJay9ZWjJMOGNEeGw1SkEzNk9C?=
 =?utf-8?B?MHkrWWFMMHNIOC9LcGU4bG8vczlwSWFjWG1SM091QkNmUmxSMzZGS0g2bW5w?=
 =?utf-8?B?WjdBZm1IaUM1RlVXVm1IZUZTZCtVVzZzSU9wSGNNNUY2MmpJcVhldTdZclRU?=
 =?utf-8?B?eVhTcSt4V3EvVEhvSXNvV0tyNmF6RllKeVZnOFdGWUc1VXZXUG5zOHUzTlpT?=
 =?utf-8?B?RytJWFBHT3huSEdvQkZVNk9NZWVVY2lQb3NXbFU4Q1N0LzBrZ3lnYlU2OWp3?=
 =?utf-8?B?Q1l2UHg2T3hqRnpKanZxSm1GUlhWZ0Q4S3NES2RVVkk0VXl1VUx3RHlHN0tw?=
 =?utf-8?B?WlZmdXBIQzVxTVN2S2NSU1hUbFg1Z3U3Q3JQMzBSMG1iQ0dJU3Z0V2pLeGZz?=
 =?utf-8?B?RzJBemF2Tm4yM2hiSm1aS1lyWVZLRjZEM0R2aHBVelRhNkxtaUNYM1Yzb0Iz?=
 =?utf-8?B?dEY3NnAzQjR4TTI3dDRZVk9SYTFWZVlpMlZhVFBCWFFLTWdBTWpxYmg4ZWpS?=
 =?utf-8?B?RXcwcDNBU3dNRFdjYTlMZHVNV0JGTDZUY2pkWXNDRExGKy9XVy91ZEN2aitz?=
 =?utf-8?B?RUQ2UE1xZGkzWWNuSHdYMTJzN1l5TXU4NGNYTzBJeGRGRkVQbmhKOHRVbWlS?=
 =?utf-8?B?L0VFVDZNREdzbm9Wd3NDOE5OMUJVdTNXRDJlRGEwTzUyK2Y5R2duN2ZLaVF6?=
 =?utf-8?B?bTRPM1V6SjNkZHhpNlRZUDRmeTJ4ZFhpSks5d2ZydWduMlNWSHJLMEdHbHNH?=
 =?utf-8?B?a0NncGVBbUx5THpVNktRTVR0cGZlNjhiN0JvVlpMOHpWSnpaRC9UNHJGdndv?=
 =?utf-8?B?OWY0a3BlaEY5THpDRXJxcWVSTXJTdm5CbitaanRTS0gyZ0xJcUdHb1h3OVdR?=
 =?utf-8?B?azJ0aUMxMHFIMmV4Vzgwb1VKZWV4eDg0bE9IUFZVNFFiRWd5RmhtS2VYOVZi?=
 =?utf-8?B?WEx0N0FicVJGVUIvWXF4TUowZ3ZGVVBoOHpVSXhJenoxbDNhZFR6SDFXL1Jp?=
 =?utf-8?B?SHB5UlhTRGs1eVpmbUU5clIxdG5NNmZNcUZGSWtqTUpNMEFXbC9JaDNUdEww?=
 =?utf-8?B?bFNMcUpNM0V4YnQ4TnRBak5OODZqNzBrdmQ3VFB6bmdvenY3MkRZaVQzbnlv?=
 =?utf-8?B?bittSWZSaXhhTGlJWEJsL1FlYUhNeGNuQ3NHZllUT28wTWxjK3g0WktHSlQ4?=
 =?utf-8?B?bWVZSTIwOUVkZkszZnV5ZEZwdXlkcTZxbEJEa21TdTEwSERVVkVOVVEwYndH?=
 =?utf-8?B?OVpRTVlOTVJjbnV4RktKaklRYTBUem4vTkNBeitGWFNvTXhreGVOQUZteGxI?=
 =?utf-8?Q?FczqQG5b2fgdrts5Gr+b8pqog?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c30062-d823-490b-6eb0-08dd52177810
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 01:31:30.8015 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yg/ieOokFGaDG0bU5EDgARE4wBhJGk5jyHDyMp0jX5AEgbYKZQxPegWNKV/7h4hgWCVFXI+wt5Fz+7jBJ7+ZxCjallGNUi3sHao5YR7RRQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5034
Received-SPF: pass client-ip=2a01:111:f403:200f::721;
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

SGkgQ2VkcmljLCANCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDA4LzI4XSBody9pbnRjL2Fz
cGVlZDogQWRkIHN1cHBvcnQgZm9yIG11bHRpcGxlIG91dHB1dA0KPiBwaW5zIGluIElOVEMNCj4g
DQo+IE9uIDIvMTMvMjUgMDQ6MzUsIEphbWluIExpbiB3cm90ZToNCj4gPiBBZGRlZCBzdXBwb3J0
IGZvciBtdWx0aXBsZSBvdXRwdXQgcGlucyBpbiB0aGUgSU5UQyBjb250cm9sbGVyIHRvDQo+ID4g
YWNjb21tb2RhdGUgdGhlIEFTVDI3MDAgQTEuDQo+ID4NCj4gPiBJbnRyb2R1Y2VkICJudW1fb3V0
cGlucyIgdG8gcmVwcmVzZW50IHRoZSBudW1iZXIgb2Ygb3V0cHV0IHBpbnMuDQo+ID4gVXBkYXRl
ZCB0aGUgSVJRIGhhbmRsaW5nIGxvZ2ljIHRvIGluaXRpYWxpemUgYW5kIGNvbm5lY3Qgb3V0cHV0
IHBpbnMNCj4gPiBzZXBhcmF0ZWx5IGZyb20gaW5wdXQgcGlucy4gTW9kaWZpZWQgdGhlICJhc3Bl
ZWRfc29jX2FzdDI3MDBfcmVhbGl6ZSINCj4gPiBmdW5jdGlvbiB0byBjb25uZWN0IHNvdXJjZSBv
cmdhdGVzIHRvIElOVEMgYW5kIElOVEMgdG8gR0lDMTI4IC0gR0lDMTM2Lg0KPiBVcGRhdGVkIHRo
ZSAiYXNwZWVkX2ludGNfcmVhbGl6ZSINCj4gPiBmdW5jdGlvbiB0byBpbml0aWFsaXplIG91dHB1
dCBwaW5zLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNw
ZWVkdGVjaC5jb20+DQo+IA0KPiBjb3VsZCB5b3UgcGxlYXNlIGFkZCB0byB0aGUgLmdpdC9jb25m
aWcgZmlsZSA6DQo+IA0KVGhhbmsgeW91IGZvciBsZXR0aW5nIG1lIGtub3cgdGhpcyBpbmZvcm1h
dGlvbiBhbmQgZm9yIHlvdXIgc3VnZ2VzdGlvbi4NCkkgd2lsbCBhZGQgaXQgdG8gbXkgbG9jYWwg
R2l0IGNvbmZpZ3VyYXRpb24uDQpKYW1pbg0KDQo+ICAgICAgW2RpZmZdDQo+ICAgICAgICAgIG9y
ZGVyRmlsZSA9IC9wYXRoL3RvL3FlbXUvc2NyaXB0cy9naXQub3JkZXJmaWxlDQo+IA0KPiBUaGlz
IHdpbGwgcHV0IC5oIGZpbGVzIGJlZm9yZSB0aGUgLmMgZmlsZXMgaW4gdGhlIHBhdGNoLg0KPiAN
Cj4gDQo+IFJldmlld2VkLWJ5OiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+
IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCj4gDQo+ID4gLS0tDQo+ID4gICBody9hcm0vYXNw
ZWVkX2FzdDI3eDAuYyAgICAgICB8IDYgKysrKystDQo+ID4gICBody9pbnRjL2FzcGVlZF9pbnRj
LmMgICAgICAgICB8IDQgKysrKw0KPiA+ICAgaW5jbHVkZS9ody9pbnRjL2FzcGVlZF9pbnRjLmgg
fCA1ICsrKy0tDQo+ID4gICAzIGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMg
Yi9ody9hcm0vYXNwZWVkX2FzdDI3eDAuYyBpbmRleA0KPiA+IDE4ZTE0YTc5MTQuLjc3NWU5NTNh
ZmQgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMNCj4gPiArKysgYi9o
dy9hcm0vYXNwZWVkX2FzdDI3eDAuYw0KPiA+IEBAIC01MTksMTAgKzUxOSwxNCBAQCBzdGF0aWMg
dm9pZA0KPiBhc3BlZWRfc29jX2FzdDI3MDBfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJv
ciAqKmVycnApDQo+ID4gICAgICAgYXNwZWVkX21taW9fbWFwKHMsIFNZU19CVVNfREVWSUNFKCZh
LT5pbnRjKSwgMCwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgc2MtPm1lbW1hcFtBU1BFRURf
REVWX0lOVENdKTsNCj4gPg0KPiA+IC0gICAgLyogR0lDSU5UIG9yZ2F0ZXMgLT4gSU5UQyAtPiBH
SUMgKi8NCj4gPiArICAgIC8qIHNvdXJjZSBvcmdhdGVzIC0+IElOVEMgKi8NCj4gPiAgICAgICBm
b3IgKGkgPSAwOyBpIDwgaWMtPm51bV9pbnBpbnM7IGkrKykgew0KPiA+ICAgICAgICAgICBxZGV2
X2Nvbm5lY3RfZ3Bpb19vdXQoREVWSUNFKCZhLT5pbnRjLm9yZ2F0ZXNbaV0pLCAwLA0KPiA+DQo+
IHFkZXZfZ2V0X2dwaW9faW4oREVWSUNFKCZhLT5pbnRjKSwNCj4gPiBpKSk7DQo+ID4gKyAgICB9
DQo+ID4gKw0KPiA+ICsgICAgLyogSU5UQyAtPiBHSUMxMjggLSBHSUMxMzYgKi8NCj4gPiArICAg
IGZvciAoaSA9IDA7IGkgPCBpYy0+bnVtX291dHBpbnM7IGkrKykgew0KPiA+ICAgICAgICAgICBz
eXNidXNfY29ubmVjdF9pcnEoU1lTX0JVU19ERVZJQ0UoJmEtPmludGMpLCBpLA0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgcWRldl9nZXRfZ3Bpb19pbihERVZJQ0UoJmEtPmdpYyks
DQo+ID4NCj4gPiBhc3BlZWRfc29jX2FzdDI3MDBfZ2ljX2ludGNtYXBbaV0uaXJxKSk7DQo+ID4g
ZGlmZiAtLWdpdCBhL2h3L2ludGMvYXNwZWVkX2ludGMuYyBiL2h3L2ludGMvYXNwZWVkX2ludGMu
YyBpbmRleA0KPiA+IDk1YjQwZTE5MzUuLjMyYzRhM2JiNDQgMTAwNjQ0DQo+ID4gLS0tIGEvaHcv
aW50Yy9hc3BlZWRfaW50Yy5jDQo+ID4gKysrIGIvaHcvaW50Yy9hc3BlZWRfaW50Yy5jDQo+ID4g
QEAgLTM1NCw2ICszNTQsOSBAQCBzdGF0aWMgdm9pZCBhc3BlZWRfaW50Y19yZWFsaXplKERldmlj
ZVN0YXRlICpkZXYsDQo+IEVycm9yICoqZXJycCkNCj4gPiAgICAgICAgICAgaWYgKCFxZGV2X3Jl
YWxpemUoREVWSUNFKCZzLT5vcmdhdGVzW2ldKSwgTlVMTCwgZXJycCkpIHsNCj4gPiAgICAgICAg
ICAgICAgIHJldHVybjsNCj4gPiAgICAgICAgICAgfQ0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiAr
ICAgIGZvciAoaSA9IDA7IGkgPCBhaWMtPm51bV9vdXRwaW5zOyBpKyspIHsNCj4gPiAgICAgICAg
ICAgc3lzYnVzX2luaXRfaXJxKHNiZCwgJnMtPm91dHB1dF9waW5zW2ldKTsNCj4gPiAgICAgICB9
DQo+ID4gICB9DQo+ID4gQEAgLTM4OSw2ICszOTIsNyBAQCBzdGF0aWMgdm9pZCBhc3BlZWRfMjcw
MF9pbnRjX2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MNCj4gKmtsYXNzLCB2b2lkICpkYXRhKQ0KPiA+
ICAgICAgIGRjLT5kZXNjID0gIkFTUEVFRCAyNzAwIElOVEMgQ29udHJvbGxlciI7DQo+ID4gICAg
ICAgYWljLT5udW1fbGluZXMgPSAzMjsNCj4gPiAgICAgICBhaWMtPm51bV9pbnBpbnMgPSA5Ow0K
PiA+ICsgICAgYWljLT5udW1fb3V0cGlucyA9IDk7DQo+ID4gICAgICAgYWljLT5tZW1fc2l6ZSA9
IDB4NDAwMDsNCj4gPiAgICAgICBhaWMtPnJlZ19zaXplID0gMHgyMDAwOw0KPiA+ICAgfQ0KPiA+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2ludGMvYXNwZWVkX2ludGMuaA0KPiA+IGIvaW5jbHVk
ZS9ody9pbnRjL2FzcGVlZF9pbnRjLmggaW5kZXggNWYwNDI5YzdmOS4uMGJmOTZhODFiYiAxMDA2
NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2h3L2ludGMvYXNwZWVkX2ludGMuaA0KPiA+ICsrKyBiL2lu
Y2x1ZGUvaHcvaW50Yy9hc3BlZWRfaW50Yy5oDQo+ID4gQEAgLTE3LDggKzE3LDggQEANCj4gPiAg
IE9CSkVDVF9ERUNMQVJFX1RZUEUoQXNwZWVkSU5UQ1N0YXRlLCBBc3BlZWRJTlRDQ2xhc3MsDQo+
IEFTUEVFRF9JTlRDKQ0KPiA+DQo+ID4gICAjZGVmaW5lIEFTUEVFRF9JTlRDX05SX1JFR1MgKDB4
MjAwMCA+PiAyKSAtI2RlZmluZQ0KPiA+IEFTUEVFRF9JTlRDX05SX0lOVFMgOQ0KPiA+ICAgI2Rl
ZmluZSBBU1BFRURfSU5UQ19NQVhfSU5QSU5TIDkNCj4gPiArI2RlZmluZSBBU1BFRURfSU5UQ19N
QVhfT1VUUElOUyA5DQo+ID4NCj4gPiAgIHN0cnVjdCBBc3BlZWRJTlRDU3RhdGUgew0KPiA+ICAg
ICAgIC8qPCBwcml2YXRlID4qLw0KPiA+IEBAIC0zMCw3ICszMCw3IEBAIHN0cnVjdCBBc3BlZWRJ
TlRDU3RhdGUgew0KPiA+DQo+ID4gICAgICAgdWludDMyX3QgcmVnc1tBU1BFRURfSU5UQ19OUl9S
RUdTXTsNCj4gPiAgICAgICBPcklSUVN0YXRlIG9yZ2F0ZXNbQVNQRUVEX0lOVENfTUFYX0lOUElO
U107DQo+ID4gLSAgICBxZW11X2lycSBvdXRwdXRfcGluc1tBU1BFRURfSU5UQ19OUl9JTlRTXTsN
Cj4gPiArICAgIHFlbXVfaXJxIG91dHB1dF9waW5zW0FTUEVFRF9JTlRDX01BWF9PVVRQSU5TXTsN
Cj4gPg0KPiA+ICAgICAgIHVpbnQzMl90IGVuYWJsZVtBU1BFRURfSU5UQ19NQVhfSU5QSU5TXTsN
Cj4gPiAgICAgICB1aW50MzJfdCBtYXNrW0FTUEVFRF9JTlRDX01BWF9JTlBJTlNdOyBAQCAtNDIs
NiArNDIsNyBAQA0KPiBzdHJ1Y3QNCj4gPiBBc3BlZWRJTlRDQ2xhc3Mgew0KPiA+DQo+ID4gICAg
ICAgdWludDMyX3QgbnVtX2xpbmVzOw0KPiA+ICAgICAgIHVpbnQzMl90IG51bV9pbnBpbnM7DQo+
ID4gKyAgICB1aW50MzJfdCBudW1fb3V0cGluczsNCj4gPiAgICAgICB1aW50NjRfdCBtZW1fc2l6
ZTsNCj4gPiAgICAgICB1aW50NjRfdCByZWdfc2l6ZTsNCj4gPiAgICAgICBjb25zdCBNZW1vcnlS
ZWdpb25PcHMgKnJlZ19vcHM7DQoNCg==

