Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6903BC52D6F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 01:13:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbri8-00041b-UA; Wed, 07 Aug 2024 21:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1sbrhy-0003x8-BY; Wed, 07 Aug 2024 21:12:51 -0400
Received: from mail-eastasiaazlp170100000.outbound.protection.outlook.com
 ([2a01:111:f403:c400::] helo=HK2PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1sbrhv-0004NR-Ba; Wed, 07 Aug 2024 21:12:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cBg7adBT6QdbfMk1F4gx9UY6VtXmNkYbLmC6RSRkXgJURYK2LjiLAvuijUwMUMFhD4J3gtgEK8hjGbbOBi5toQI0kWsmDdNktimxNB6Z/n70mKL2A+xoTHgXpuLkSjNZdFLdnL3HmYIiswMyXUEalWJKyQU+m7AnbdMkHS5v6gQ0p7GfJhya2NM4NdE/MGMmPfMneuiuNS7B0jmh5927EYMEIP803h7IvCqwP4m8Uxj+hV9QleRExOJKcTc08TcIxcseIurZg2IlXStkUoBKkexAONeOICnFwHNg/r7l6P9hJMOzyR5TMDPowTPd30c7oofux+BWpXP2q6QT1UtBpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/unKmM+1Klxaj3c5S/30Lyme4kjxwIc1JwJWohCBBvM=;
 b=maidNnKu6CNHKaOaeaItBl/aN/3OG60dRGmIPJvw+2LsscJYrmBQetuyVmPgRspP5ZDmSMaT8ipXvoC5i81HIgYUm+6LQbH/QDZvLCz1eJF3qDYRBVMNUFgdw+AS9rXCUWn5QrnG9KmdSwMwi+5yU6vrbu++Buj1vxOuqP03MCEDyvJeKREL0RErfdJ6iqohW9Tz9uXjdzIxbAf8OBcSroyRF3c7WsGwYQikc9rYTjCzcF4TFuA8oDTWDTALNdpuDRxwPEFV612QWONzoTDO3D3ApHWUam/wm8UYHMk5Z20+JT9R8QVx9aoTTUdZ4QEovvwYW7kMqxH7k48ue+84Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=andestech.com; dmarc=pass action=none
 header.from=andestech.com; dkim=pass header.d=andestech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=andestech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/unKmM+1Klxaj3c5S/30Lyme4kjxwIc1JwJWohCBBvM=;
 b=oBN2NC9BMHdjqrfO4MhFUNx4jaX55wdnG5Np12i+qM4ZNCcPbfP1Ke40v1dvvPDZTeQUFoUY8hsu3l9X8kzzDP3YmjjYijBvgc/MVRyJBDLOnvEiMQVHNV74ng060DzhVdzKLGy36KEDR8WCBFinvLFFT4LhJ2C2JeiMXEEpCYUQosgjBpkXHzLgVjhX8L5U2XAe6uIG1tcCsjSNc2xIZbNFsL1e6TKQYeIxPn/4KhqZlxgXRFkb76fLaUJQHdb4wiq6gXkgmrW2F8L+do9XjgFBLP7lBkHxSdwXxpZYlL3qzEM1fDnlKSdAWuuGErUWjNo+gXTa1cBEwDSoOySm9A==
Received: from SEYPR03MB6700.apcprd03.prod.outlook.com (2603:1096:101:69::14)
 by PUZPR03MB6965.apcprd03.prod.outlook.com (2603:1096:301:fa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Thu, 8 Aug
 2024 01:12:36 +0000
Received: from SEYPR03MB6700.apcprd03.prod.outlook.com
 ([fe80::292f:e1ce:7df8:115e]) by SEYPR03MB6700.apcprd03.prod.outlook.com
 ([fe80::292f:e1ce:7df8:115e%6]) with mapi id 15.20.7849.008; Thu, 8 Aug 2024
 01:12:35 +0000
From: =?utf-8?B?QWx2aW4gQ2hlLUNoaWEgQ2hhbmco5by15ZOy5ZiJKQ==?=
 <alvinga@andestech.com>
To: Alistair Francis <alistair23@gmail.com>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alistair.francis@wdc.com"
 <alistair.francis@wdc.com>
Subject: RE: [PATCH v3 0/2] RISC-V: Add preliminary textra trigger CSR
 functions
Thread-Topic: [PATCH v3 0/2] RISC-V: Add preliminary textra trigger CSR
 functions
Thread-Index: AQHa2z8N65m+CRbsW0exZ+hITwnfAbIFLxwAgBYrZCCAAGCSgIAA7knw
Date: Thu, 8 Aug 2024 01:12:34 +0000
Message-ID: <SEYPR03MB6700D80F43A4D630578B7F06A8B92@SEYPR03MB6700.apcprd03.prod.outlook.com>
References: <20240721072422.1377506-1-alvinga@andestech.com>
 <CAKmqyKN2hnN+wQzx3bdcFjEpo1R_rW23mR9OiCE8goJJ198-xw@mail.gmail.com>
 <SEYPR03MB6700421A6AAA65C5F310ED99A8B82@SEYPR03MB6700.apcprd03.prod.outlook.com>
 <CAKmqyKM2uxubXW4YAdeJ_WwOQ5jC4KLYwEXin1Vt=89353nT7g@mail.gmail.com>
In-Reply-To: <CAKmqyKM2uxubXW4YAdeJ_WwOQ5jC4KLYwEXin1Vt=89353nT7g@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=andestech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6700:EE_|PUZPR03MB6965:EE_
x-ms-office365-filtering-correlation-id: 3c92b882-65c1-4463-6893-08dcb7472fa9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WkFYY1ZTQlhYMmp5UUgyT0htaXNOemdQZ3dLOEMwQ3VSTlo4M0JHcUZnZVhK?=
 =?utf-8?B?MnZZUmg5UU9aTk5odlI5a1IveDVEcVlVeXBHdzJ5czNFU1ZpWllZM3BuZVNu?=
 =?utf-8?B?TkwzR0N6b0VOelBrMENuYk90QUpBeklkSE9TYnpPYkZIRVRLam5WeHhWcUl1?=
 =?utf-8?B?dThVNDdLL2ZPbjk5dnlXekw4MkNaTVZDSEdTZUdTRjl1aWJscTZVd3dyQm91?=
 =?utf-8?B?S0psRWE0TFVrZTlMZG95UUcxa2FGbDJGTUhwZXcxY3NGTHMyZXp4anhJTnRX?=
 =?utf-8?B?RW1vMkRraU1LUjNUanZOZFdoYjJqM1hVWi9XVnR2cFI3WUQ0dnZuRmttSzNw?=
 =?utf-8?B?RytiSnFxZ3hpMDZoN0pPdmV4eU1TVW5CVlJmR1ZyVytmOHdsRXVPVmc1OEhE?=
 =?utf-8?B?bk5pWEI5b0VjQ3lLZWl6aytYWGJZVHVNdk04MmRtTG83MjA5RTNqT25Bc1hr?=
 =?utf-8?B?NXhscGMzbTZXZ3dNd3B2OVlhQVBtY2c4YmowSURWTG9QeElRdStjME8yaEhF?=
 =?utf-8?B?WFZkZnF0R0xpK2hORVZTQVlBSXJsclNnK1BmMVNzcjA3NmRLaWMvdVZaYkRM?=
 =?utf-8?B?eCtJRVhiclQzdlFITzlIMjk1WW5Qa2lEVnZweXhSc2NJRE0zVTgyc1RKMC9I?=
 =?utf-8?B?NG0zNmlCTE93bTBCa0RrYjFFNU9uT0tnOG83aHpORzRjRFZRSkp4WjNlR0Y1?=
 =?utf-8?B?bzhjQmRjTmVBRTJBWU9jQkNyNlo3emhpLzhXNGlDVzViUmdtNnY5c2hsbTMr?=
 =?utf-8?B?a01XaEVIWk40UE4rakhJV0swV0cyWkw1SGd2ZkZ0MlpXZFBRWmhSLzRlazlP?=
 =?utf-8?B?enlNZmVUMGYrRzBtVGtvR2R3SzNaeEV3THJ6WlhSSkhEU0hCZVZPR3NUWDlS?=
 =?utf-8?B?WnlQaDY5ZU81ZCtOekNONmtkNm1FZjN2LzVwV0RHMXhyMTVkbkVFem92bDBE?=
 =?utf-8?B?QWlvaVBMR1hNTUQ0TXkvakRIQS9VdmpnZEliNVNKejJEeXFOYTR5OUN2SGR6?=
 =?utf-8?B?VkdOckdSSHRhdzBDS0pVMEw2aVZ6VHVJUHRwcDNjUkhYRUFUMVhaWTRsbVly?=
 =?utf-8?B?MGZpSU9PeHE0RGo3QUoyQVUrQk53L3VpcXdReW9EQkJZV2szak5uSjNtNG95?=
 =?utf-8?B?SW5ZNkZLUGcwS25sSGtRNEs5bU1DMjJGdzlMeDZnU0YvUVFRZkJzWXpJRVpE?=
 =?utf-8?B?ODVyYnFrU3JwbGZ1K041ZFRkRlJSNFh1bUwwT1lRWmJWTFJYSlkyRW1FYVZ1?=
 =?utf-8?B?SzZpSXZOWGlQU0RDa1pPeEMzTFpKTHhLcXkvcWJVdUZNRmRnM09oMS9QMElr?=
 =?utf-8?B?cmdGd21abGkzN0pGYkVzSmRmcWY1MUpMK2FQS3J6VkRrRlcwMWxQL0RwMWxQ?=
 =?utf-8?B?N3VBdThiL3pSU0svaDlsaWFWdnBIbXBjTzFyb2dIS0k0RjhIcTlCWkY1cTli?=
 =?utf-8?B?YWNiby9HMWlNamZDOWthKy9CODZrQUZUUTI5RTNJUTlJNTVkUFRJK0hZZ2ZP?=
 =?utf-8?B?OU9IeXFocm5BYlpUZnVWQmZJT1pZQ01laHhlTHVYbTNaRTd0N3J0ME82QXQ3?=
 =?utf-8?B?emJra3d6YWZEa2ovTG9PLytndjRlRzkvTnFWRGRBaldLN09xZGp2NmNxa3FT?=
 =?utf-8?B?QVdLcVFqaEpVOE00aHg2NzNjVVlyWHdwc29nYzYzcXM3MVQyRGRJVUhuVEJn?=
 =?utf-8?B?WFdocHlUbkxRZklXaUZEby9BbENWaFZyYUE0UDh3bjdWSmlIUDZQTWVwWHh6?=
 =?utf-8?B?YTFjbkFnbEtZczRLSFpTK1RWQjZVdEd0NGNkQWRGQlZ6K0hLcmxNQ3Y3YS9S?=
 =?utf-8?Q?RGeMB/OB+K2igYbA3fyfoC7wcDSRTa0jzQOQI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEYPR03MB6700.apcprd03.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3lxTDVsNHlJWSsweFVqSVp3VE9HQTB6UmJ2MlBOaG8xbG0xT24xcmlqNnRV?=
 =?utf-8?B?UUoydE5WcWRGOW9KY2RxWmN3bno4aS96VWtlb2Rxck1vbHlJM21mNGZkMzJ3?=
 =?utf-8?B?QnA4MHN4SFpLNXU5aHQ3TERWYURsR3doblU2WW1YdUZldWpPTHMxV1g4QXli?=
 =?utf-8?B?K3hjQXBiN3hLb2RGcWJpSjV2RWlURzRVaStDSFBYbTBiVTJiN1N0blFHanFn?=
 =?utf-8?B?eWZNcXhTNWJxNXVFRVJaYS93bWVpTXNaM3NFcXBSNVBkaWljZkpwZmNFMU1J?=
 =?utf-8?B?dlNMQWxuR0NBcmNmWVpGSzJNRkFrdlU3QWt2YjBWMTNOemxJVXpxYXN2OWZF?=
 =?utf-8?B?ODNRYklpL0JOR3Z3RHo0cGh1cmJhNTlHTC8yTzQ4MndtL2NaU0plNlVXc2dS?=
 =?utf-8?B?YmlZUktTaEtmR1pESTlDU25HVGhwSFJxZmkzNFBBcUtTSERlYlFtbjM2MFZT?=
 =?utf-8?B?VFlHckpXUEpFcHAxWE90SjJvVnFnRlJvLzlUMmU1MVNCSlBBekp4eDMxblFj?=
 =?utf-8?B?RkFPYXdUMFF1RmFPV2hXZHNOVXlvV2NJdE5NdnljQUxxclNCWkRwWXQzbFNk?=
 =?utf-8?B?S3luVEpFdDB3dXFxZU9RU2VlN2NFazN3UElLREwzZUpwQmhac0UwT1M1aUky?=
 =?utf-8?B?QXlKVlpZN3pYbzBCSmlvWWY3MStBeGtQMVA1N3NXTU1waUtMd20vUWZmTms1?=
 =?utf-8?B?ZEphSGxJTzlMRTdNbFJ5bE9mQk5GWkR0Vlpjb2Y4djJUN3BtRVNZWk5xWVph?=
 =?utf-8?B?WmcrOXd4TXhYeFMxRjhWaW16ZEZpbG80azRHV01jTlZBZGtWMUlTdDlZRm9o?=
 =?utf-8?B?eWtWNVNmb3UrbTdWYmJ2Nm51RnNCZEwwZGYyYnNxZjRDZmFRSGc3eE9yR3Fx?=
 =?utf-8?B?WjFENUlBRnVKZzlvand0SjRnd3dQZm51UzZEUmR5SjFZdk01Q1ZOSTNoUm9k?=
 =?utf-8?B?dGVOZForWk92YXJiOU1BRFZldThISlFMQm45aEtmODI4d2JOZjBQeHdyZllL?=
 =?utf-8?B?Y205OGlmQWxVNHZLM3N2Q090bThyZUdseUo4bnpkdnFDYW85bzk3M29WM0pl?=
 =?utf-8?B?N2VMOEpFSlNzMENCZDNTbGUrSGNGbXJGRjZuZHcyOFM1RXJvblBab0tTVS84?=
 =?utf-8?B?YlZNYkxvZWlTTllsVVhNUzBQUDhIR0JIRnk1alRQc1FicEZ0cENVcTNGVzVH?=
 =?utf-8?B?ZUFOcmNweXE4R2RZRE0rTjE1V1lQd0k5VUZ2bno0NW1JTTFhVDhrZCt4cVRk?=
 =?utf-8?B?ajRhbkFOb1JOUTA2TEo5LzZ6RThXSEJmZlRLODJkR1FEUTNWMWNXRjRCL2VT?=
 =?utf-8?B?TFVFMEQzMUZhRWpTMzF0dThJVjN2YlhabGZaci82aFdBcm5QdCtzRjBSZHZB?=
 =?utf-8?B?RHJqSGErWmJtd2RxWkhIMkU3SXRBMWh5QWxCeFlYQ1kvTDl3UTEwcmxicXhN?=
 =?utf-8?B?TnlwWGF0b2hRUzJWVnN6OGpGTC9RN3pYemxoaDJTM1Y3UFIydExoLzBJYXAr?=
 =?utf-8?B?eWdOVmZ6QUJVV3lIWU9QSFNuSjdjcDhUQ0U0ZGZSNUJkajZsNFU0RmVvL0Jv?=
 =?utf-8?B?T3Z0TWJrOUFjbUhUYlcvM2s4WlJhVGZaakRrY283bEFWTGtyVTRMNFNieUNh?=
 =?utf-8?B?NHNFZjJGSXgrb2JmVytSY3NEME5adkNyL1QzdXpJWHZlTG9tR0ZhMUgrV0pD?=
 =?utf-8?B?dDBGd2QzMU1ObytEc2xxRkZwMTB2cXhFWFozalRtOFFHOVlqSXRocncwcmZj?=
 =?utf-8?B?ZjhUK3VDbEFHSXY4dVBOK0tyVkZkcEF0TENrNGR3U2tQc2ZhcHEwTzZneDhY?=
 =?utf-8?B?TVdOcVppVEdEM3g5bXgrUXBkdnpNVTlreUxkQmI5MVNqL2lpWUpiUlo2RWtQ?=
 =?utf-8?B?N0NQR0JnaW5aMTBCUllxU29pNUVObFBjdW9meXoySkt3aXJIdjFkc1F1V0gx?=
 =?utf-8?B?RGhEZGkxT1lIWExqdFg2dmJtK1RPK1ZzYmpaUG4yVmpDU2UwNDdmK0l1ZGdy?=
 =?utf-8?B?ODJoUEZkTFNoQW5Oby91cG9JY3QxRFBOK0pJZFo0cjNnZnh2TmNnVUxqSzdW?=
 =?utf-8?B?RHhQMmtLb1BQNXJYY1dUZFB5a0hBbHNJU25TQ2MyOE8vYmdkVlNBK0VkQnhk?=
 =?utf-8?Q?jEWZz0sGU0AgBdnoA+VPcXtiK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: andestech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6700.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c92b882-65c1-4463-6893-08dcb7472fa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 01:12:34.9465 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e3ec21b7-ec6c-4041-9add-61aea8171458
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3gWILEjm3Xg0fd2ald7BhTKihHU1ZDYPeLzbtlx6TFW3+sf3qAc1F888dwPt/dac4ilT3zBu6BmFuaslMPOoxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6965
Received-SPF: pass client-ip=2a01:111:f403:c400::;
 envelope-from=alvinga@andestech.com;
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGlzdGFpciBGcmFuY2lzIDxh
bGlzdGFpcjIzQGdtYWlsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgNywgMjAyNCA2
OjU5IFBNDQo+IFRvOiBBbHZpbiBDaGUtQ2hpYSBDaGFuZyjlvLXlk7LlmIkpIDxhbHZpbmdhQGFu
ZGVzdGVjaC5jb20+DQo+IENjOiBxZW11LXJpc2N2QG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9u
Z251Lm9yZzsNCj4gYWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjMgMC8yXSBSSVNDLVY6IEFkZCBwcmVsaW1pbmFyeSB0ZXh0cmEgdHJpZ2dlciBDU1INCj4g
ZnVuY3Rpb25zDQo+DQo+IFtFWFRFUk5BTCBNQUlMXQ0KPg0KPiBPbiBXZWQsIEF1ZyA3LCAyMDI0
IGF0IDM6MjTigK9QTSBBbHZpbiBDaGUtQ2hpYSBDaGFuZyjlvLXlk7LlmIkpDQo+IDxhbHZpbmdh
QGFuZGVzdGVjaC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSGVsbG8gQWxpc3RhaXIsDQo+ID4NCj4g
PiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBBbGlzdGFpciBGcmFu
Y2lzIDxhbGlzdGFpcjIzQGdtYWlsLmNvbT4NCj4gPiA+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSAy
NCwgMjAyNCAxMDo0MCBBTQ0KPiA+ID4gVG86IEFsdmluIENoZS1DaGlhIENoYW5nKOW8teWTsuWY
iSkgPGFsdmluZ2FAYW5kZXN0ZWNoLmNvbT4NCj4gPiA+IENjOiBxZW11LXJpc2N2QG5vbmdudS5v
cmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsNCj4gPiA+IGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNv
bTsgYmluLm1lbmdAd2luZHJpdmVyLmNvbTsNCj4gPiA+IGxpd2VpMTUxOEBnbWFpbC5jb207IGRi
YXJib3phQHZlbnRhbmFtaWNyby5jb207DQo+ID4gPiB6aGl3ZWlfbGl1QGxpbnV4LmFsaWJhYmEu
Y29tDQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDAvMl0gUklTQy1WOiBBZGQgcHJlbGlt
aW5hcnkgdGV4dHJhIHRyaWdnZXINCj4gPiA+IENTUiBmdW5jdGlvbnMNCj4gPiA+DQo+ID4gPiBb
RVhURVJOQUwgTUFJTF0NCj4gPiA+DQo+ID4gPiBPbiBTdW4sIEp1bCAyMSwgMjAyNCBhdCA1OjI2
4oCvUE0gQWx2aW4gQ2hhbmcgdmlhDQo+ID4gPiA8cWVtdS1kZXZlbEBub25nbnUub3JnPg0KPiA+
ID4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+IEFjY29yZGluZyB0byBSSVNDLVYgRGVidWcgc3Bl
Y2lmaWNhdGlvbiwgdGhlIG9wdGlvbmFsIHRleHRyYTMyIGFuZA0KPiA+ID4gPiB0ZXh0cmE2NCB0
cmlnZ2VyIENTUnMgY2FuIGJlIHVzZWQgdG8gY29uZmlndXJlIGFkZGl0aW9uYWwgbWF0Y2hpbmcN
Cj4gPiA+ID4gY29uZGl0aW9ucyBmb3IgdGhlIHRyaWdnZXJzLg0KPiA+ID4gPg0KPiA+ID4gPiBU
aGlzIHNlcmllcyBzdXBwb3J0IHRvIHdyaXRlIE1IVkFMVUUgYW5kIE1IU0VMRUNUIGZpZWxkcyBp
bnRvDQo+ID4gPiA+IHRleHRyYTMyIGFuZA0KPiA+ID4gPiB0ZXh0cmE2NCB0cmlnZ2VyIENTUnMu
IEJlc2lkZXMsIHRoZSBhZGRpdGlvbmFsIG1hdGNoaW5nIGNvbmRpdGlvbg0KPiA+ID4gPiBiZXR3
ZWVuIHRleHRyYS5NSFZBTFVFIGFuZCBtY29udGV4dCBDU1IgaXMgYWxzbyBpbXBsZW1lbnRlZC4N
Cj4gPiA+ID4NCj4gPiA+ID4gQ2hhbmdlcyBmcm9tIHYyOg0KPiA+ID4gPiAtIFJlbW92ZSByZWR1
bmRhbnQgbG9nDQo+ID4gPiA+DQo+ID4gPiA+IENoYW5nZXMgZnJvbSB2MToNCj4gPiA+ID4gLSBM
b2cgdGhhdCBtaHNlbGVjdCBvbmx5IHN1cHBvcnRzIDAgb3IgNCBmb3Igbm93DQo+ID4gPiA+IC0g
U2ltcGxpZnkgd3JpdGluZyBvZiB0ZGF0YTMNCj4gPiA+ID4NCj4gPiA+ID4gQWx2aW4gQ2hhbmcg
KDIpOg0KPiA+ID4gPiAgIHRhcmdldC9yaXNjdjogUHJlbGltaW5hcnkgdGV4dHJhIHRyaWdnZXIg
Q1NSIHdyaXR0aW5nIHN1cHBvcnQNCj4gPiA+ID4gICB0YXJnZXQvcmlzY3Y6IEFkZCB0ZXh0cmEg
bWF0Y2hpbmcgY29uZGl0aW9uIGZvciB0aGUgdHJpZ2dlcnMNCj4gPiA+DQo+ID4gPiBUaGFua3Mh
DQo+ID4gPg0KPiA+ID4gQXBwbGllZCB0byByaXNjdi10by1hcHBseS5uZXh0DQo+ID4NCj4gPiBJ
IHNhdyBsYXRlc3QgcmlzY3YtdG8tYXBwbHkgcXVldWUgd2FzIHN1Ym1pdHRlZCB0byBxZW11LWRl
dmVsIHllc3RlcmRheS4gQnV0DQo+IHRoaXMgc2VyaWVzIHdhcyBub3QgaW5jbHVkZWQuDQo+ID4g
UGxlYXNlIGFsbG93IG1lIHRvIGluZm9ybSB0aGlzLiBUaGFua3MhDQo+DQo+IEdvb2QgY2F0Y2gh
DQo+DQo+IFRoZSBQUiB5ZXN0ZXJkYXkgd2FzIGp1c3QgZml4aW5nIGJ1Z3MgZm9yIHRoZSB1cGNv
bWluZyByZWxlYXNlIFsxXS4NCj4NCj4gQXMgdGhpcyBzZXJpZXMgaXNuJ3QgYSBidWcgZml4IEkg
ZHJvcHBlZCBpdCBmcm9tIHRoZSBQUi4gSXQgd2lsbCBiZSBpbiB0aGUgZmlyc3QgUFIgZm9yDQo+
IDkuMiB0aG91Z2gNCg0KR290IGl0ISBUaGFua3MhDQoNCkFsdmluIENoYW5nDQoNCj4NCj4gMTog
aHR0cHM6Ly93aWtpLnFlbXUub3JnL1BsYW5uaW5nLzkuMQ0KPg0KPiBBbGlzdGFpcg0KQ09ORklE
RU5USUFMSVRZIE5PVElDRToNCg0KVGhpcyBlLW1haWwgKGFuZCBpdHMgYXR0YWNobWVudHMpIG1h
eSBjb250YWluIGNvbmZpZGVudGlhbCBhbmQgbGVnYWxseSBwcml2aWxlZ2VkIGluZm9ybWF0aW9u
IG9yIGluZm9ybWF0aW9uIHByb3RlY3RlZCBmcm9tIGRpc2Nsb3N1cmUuIElmIHlvdSBhcmUgbm90
IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHlvdSBhcmUgaGVyZWJ5IG5vdGlmaWVkIHRoYXQgYW55
IGRpc2Nsb3N1cmUsIGNvcHlpbmcsIGRpc3RyaWJ1dGlvbiwgb3IgdXNlIG9mIHRoZSBpbmZvcm1h
dGlvbiBjb250YWluZWQgaGVyZWluIGlzIHN0cmljdGx5IHByb2hpYml0ZWQuIEluIHRoaXMgY2Fz
ZSwgcGxlYXNlIGltbWVkaWF0ZWx5IG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHJldHVybiBlLW1haWws
IGRlbGV0ZSB0aGUgbWVzc2FnZSAoYW5kIGFueSBhY2NvbXBhbnlpbmcgZG9jdW1lbnRzKSBhbmQg
ZGVzdHJveSBhbGwgcHJpbnRlZCBoYXJkIGNvcGllcy4gVGhhbmsgeW91IGZvciB5b3VyIGNvb3Bl
cmF0aW9uLg0KDQpDb3B5cmlnaHQgQU5ERVMgVEVDSE5PTE9HWSBDT1JQT1JBVElPTiAtIEFsbCBS
aWdodHMgUmVzZXJ2ZWQuDQo=

