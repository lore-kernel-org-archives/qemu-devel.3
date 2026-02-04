Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D65E83EE8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 07:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnXWt-0005hr-Ti; Wed, 04 Feb 2026 02:42:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnXWq-0005h3-Fn; Wed, 04 Feb 2026 02:42:24 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnXWo-0002i2-0U; Wed, 04 Feb 2026 02:42:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=clv1Fe4tCjqBvVUjfLrFopTk8aHu3MZwhwE+yt8D6ZPtZ/4n5nbAsTqr2GaOLWq0fMIezqPa7Ya8K2zvQgGsV3O6+CI8qHJlsqidkvu1902vsbGfPZHBCe0u0nWHVrO9qawFLJbDSEfKVLkq9ACsFBl8tjS93dJgFBQ+BzzF+OqH4D/rHLp9NakmIZiR+ybwfJW/2x0LkZ3MWKdKfs7G3ggxGGt4oSRuUCW7WSvDMl7cxZle12DwT3LQa8GWL58qXsWZPt97+d74fd+IRLAeaNNIn/VtG0Iia0clcamzJSoPl3s6htyYBmQ64y+y2rPdUgemT5YvF5vfd86dE7/6sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcb+xNgdclyiH0eZbt9fyoo7XX2HJ0IokB3VnaQaP3o=;
 b=Ha1wjLzNE2K/qCpZNc9rvw5I7psbLOWK/OO2ZJsAHDclgC0ir2ILC43pB2P33+9T00nwaNl9ILKUp/ltI/qp7H83VCMXuKaXvDU/2j0+0qRZpbw6AqTZqQ2kjuyCCJEmMRurViWaMKz3TvwMY/UA5aspxiAinHWNx6HyHtp3KH7mWBxu2PJIE/obp6/l1dPDYxKDDEsB2Fi49wjs+PJCyo1jUWHYM3Jp2ulde++2QRV4rdfDvgnrQbdA73AsTjyuWBvtc/LKAWGQtvqR6/HXAEfqRkpAbz23OtPuCNuPw9Xmgb6HbVdP76AlUIMWxs5CSlfReA9HACeONCRci3IXQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcb+xNgdclyiH0eZbt9fyoo7XX2HJ0IokB3VnaQaP3o=;
 b=PyIA6ndFJ9Ssj0gsqkDYu8tgzRR64TENkOAVGqGX254CclJnbrY4u2aiKqkPx4Zb/uwH3cwCWw/sPlT516AmctE7bNpPUihz8Er2rI1OQizX/LM1ONCXnUmQCeG0jBKb90CnVIBEykFtYCh3J2PDomsUGbqqBfSB9azkE0Gj4IiCA+weGNMFvIlcCQYzJiWxLIPavmfY+WKQmyma2P3RvujYJLbeKGw+wiyZwSR03S+moVgZXRDk1yd7Co2nxDJiCyO2s3VZXn2XyU9NTVrSu+4UWn5eu38uHKcooxhnH6D5Mmn8VZaiVbVieXyEftz7mKZgEd4+iYxK7lKtdTPOgg==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TYZPR06MB6771.apcprd06.prod.outlook.com (2603:1096:400:459::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 07:42:12 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 07:42:11 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Peter Maydell <peter.maydell@linaro.org>, Steven
 Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 04/11] hw/arm/ast27x0: Add DRAM alias for SSP SDRAM
 remap
Thread-Topic: [PATCH v1 04/11] hw/arm/ast27x0: Add DRAM alias for SSP SDRAM
 remap
Thread-Index: AQHcie9SKTdPnCSFkUWsdzq93BR4GrVkMO6AgAFQ/ACAABFPgIAAPRoAgAk8RICAAC2PAIAAAIaggAAUegCAAYlqsIAALKcAgAE111A=
Date: Wed, 4 Feb 2026 07:42:11 +0000
Message-ID: <SI6PR06MB763110F8D44799BAE801EC81F798A@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20260120092939.2708302-1-jamin_lin@aspeedtech.com>
 <20260120092939.2708302-5-jamin_lin@aspeedtech.com>
 <588fa41c-a5ff-455d-b64d-b36b986ee781@kaod.org>
 <TYPPR06MB8206FD6566DFDE3BA513FBFDFC90A@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <TYPPR06MB8206F928E28C7FE78BA9E3BEFC90A@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <TYPPR06MB8206F3CB33A135C5AC246E2CFC90A@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <SI6PR06MB763182A3E4BC0C6ADC0555CEF79AA@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <05782501-e775-4065-820e-1b599674f478@kaod.org>
 <SI6PR06MB763184DBA59EA9E61B97C3A5F79AA@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <57fcf2ba-fd8c-4978-af29-18c5dcc7a152@kaod.org>
 <SI6PR06MB76316284692DF29B079A22FDF79BA@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <41ca3be6-d33a-4eb9-96b1-d3e5a3fa1c5d@kaod.org>
In-Reply-To: <41ca3be6-d33a-4eb9-96b1-d3e5a3fa1c5d@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TYZPR06MB6771:EE_
x-ms-office365-filtering-correlation-id: c0f09691-f54a-4fd4-f854-08de63c0e86a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?NjdRZENWZmJMeGk4MzdQY1ZvSGdtQytGT3JmYzVleTZjbnUvTlh1Z3hRV1Ir?=
 =?utf-8?B?TFdvSTgzZzJwczFVYkU2SU5PckxzM21vN0IvSmNXb096WmpsUDV4dVVKeDNy?=
 =?utf-8?B?ek5pRk0veTZxYkZhYkFZcHJxeDJzdGVwWFk4cDJERjdZT2pMNTBFbVJVd29L?=
 =?utf-8?B?blRRaUphbTNiMllIdVdENktHSkV0THZKSmlrVW5VS0tZY2pIUnZwTkVITzE2?=
 =?utf-8?B?Uk9sd3Y4TmNMcDY5eGdGRDJNbm1xN0lIV3J5d3VMTWh3b0pHQm5hUERGZUwx?=
 =?utf-8?B?UWVURFFVV0hQcWVuekw5U1hwaDRDeGphNEEzWmJzbEtucEJIbWFKbXdobXN1?=
 =?utf-8?B?a1FHRnZMRlMzVjNjREdBTWRmZHJtNElqbUQxWlNpKzREK3Z5ODVkeitrNmhF?=
 =?utf-8?B?cW10c0lvYnJSMEhLeWZoUEVGQUlEMmw4ZU1rVkZuemJoK3RjYmY1NXlJVE1E?=
 =?utf-8?B?dVdsK01lVloyTzl3YWxZQXI5bS9CbnQvWWNrYS9rVmdJV0YvRmlFRkJ1K0hl?=
 =?utf-8?B?MVQyK1I5cVN5ZURhai9mM3NEOTRMdHpncTVHZHk5UUdEK2taYldqcG8xN05r?=
 =?utf-8?B?SEFER3krcE1WTzU3Y2Z4OS95ajRZaGIva3p0Qkx4YnF1elRnK2VzalZUOWhO?=
 =?utf-8?B?VG1EekhJNmtnYWFqeTlPNmtBR3hNQUkvRTUzVnQ4QkYvbjF4Qm5lSFpIdTJW?=
 =?utf-8?B?RnljbVg5TVJhcmVQQnJadG94UHVIZXlUUUxOQzVXYmFYV3kza1ZhS0E2dDF3?=
 =?utf-8?B?ZkZIQVZVako0VUppbTJvYXFyMlI5YWNXc25kb09CUHBpcXVNWlh0ZTRBZTNs?=
 =?utf-8?B?ZkJhSyt3Y3RRVU1Xb0paZUU4SGQ5YnFBTVJ6N3NqN2piQWhOOENuN1ZkOXlE?=
 =?utf-8?B?Q2xnWndRL1J2TmJCM0dJNUs2SkxERjdVdFdTU2tXazdGdDl4eGcxeXBMblZP?=
 =?utf-8?B?T3VHeEdnbDA2VFRzcW9rNkgrZDFEVmtadTlPNzd5OUMrTzNqVUlDSkFvckxh?=
 =?utf-8?B?YTFJNUNtU3V3QkpacGpFK0lSSHRuWVNXNGprUkxOSHppTmtCeW9oaVRiYUhT?=
 =?utf-8?B?bkt5RWJmczZ2MmlLTGhUSnpuNVJtc0dvOU9qbTVnd3V1Q2h1QzFsSzJXeDl2?=
 =?utf-8?B?em9rNFp4ZTBaZndlRFh3RXc2SEF5Yi9YN296M2toLzhjQ1JEa0VQcHUxZFFM?=
 =?utf-8?B?UXlYNWg1a3IxNTNXMnFEOFVzOHJxcy9UQ21GV015RWxQUWNKZmVuK2U2RkRs?=
 =?utf-8?B?dkFTT2hLUGNjVGpqNGdSd3Q5dVMxYVVCM0xudUIrVWFGT1I4eEJpOXJOdGtY?=
 =?utf-8?B?djNOUzAwQUNrUlBlQ0l2dm04NFVuRktjank5VTZvRi8xMnY1WTZwNXVGM3FD?=
 =?utf-8?B?ZFpvbU9sN0JUQ0FFS3NhWC9vSVFmOWVkWU5Wa1pFNk9ISUcrNDN1SU15YlZ5?=
 =?utf-8?B?czAzREREWEEwTUdmd2hHaWtwdU9sMEUyZVBpdXBmdnIxOXAraS9xSjdnZ0Mz?=
 =?utf-8?B?RGZ2M2RvTm5TNlRYckVtMzAwT3Z3ZUhCcnBVMkp1bkdtSU5LMkpyOERVSkJ1?=
 =?utf-8?B?dWwweTdtOFFWN0Z2UDNPWW1peHJ1ZUNLM2dpQmdvTlRnd05qTWRteFRXUDJR?=
 =?utf-8?B?QmpsWUR2YTdLYjFkeWIxeHpqRy9qL0M1SmU2RTNVeURFUldqb0hHajlILzh3?=
 =?utf-8?B?MFpUN0tNZFd1NFk2ejRCV0NpSkErWTVxdjl6TVRLSFBmNWtJRUd1aitQbTJa?=
 =?utf-8?B?azI3TkFkVzlCUVZFaFpoVWxoRmhOa3lSRldkOTk2bTl2VmxYZGhTQTlHQXh2?=
 =?utf-8?B?RXBOZjk2TWN1YitHNXFDN0hmeGQ4Rld2UGlDOEpXd01oejAvRHpIRThaSWw1?=
 =?utf-8?B?RnRCYlNwY1B3cmRLZ3NjK1ZxUWk5VDNLUUZRRUtuZUlkcWJvalhwL2RPM3Bj?=
 =?utf-8?B?VlhOSk4vK3hHSnhWVGVCQTVXVTNlalRGUHRnOFJwbTNSZWVpcG9RN3lUVnp5?=
 =?utf-8?B?SXlzTXJvaVpsYXpUWStXRGZhWnQ2NG44UEF2YjZtd3JwS29TRWR3a1hnL2dE?=
 =?utf-8?B?RGNzSkRXZi90MVl2azV4UG9rcU5VOXpwbzFLNHAwc3FpTCsvQi8yMlBQZ0VX?=
 =?utf-8?Q?ktLqos/9EnexmyRsmeO78+48t?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmpHMTNxTnY4eGRmLzNqS0RRZ2lxWEFoY2NlNnltU3lMeFRycmJHM3FSTWlJ?=
 =?utf-8?B?aityZmM4ZXN1SUIyakk4WTZqQ2lFWDV4clh3MEFuV3l1VGtaWEhaazhzV3lG?=
 =?utf-8?B?b3V2cmlMZzFaSUkvN2JDM3p2NDlDRXpmNGtYb293bjhpczFIdTBDdkpyNkE5?=
 =?utf-8?B?Tkt3aWMzQUdTMm90a2dBcFo1KzhxTWtKVmhJM014aG9qa1BHYTE5Y2s0OFpO?=
 =?utf-8?B?a1EybFl5eWVVL2R2emtUMDNkTGdSTzM5S1I4RVJ3SE1BeDJyVjBXeU1yb1Bt?=
 =?utf-8?B?cklKNU5ad0VIWjFxRGpqSUhiVnlpdnpCMGV1TDVNb25pbFQ1WXY4cDB6aEtw?=
 =?utf-8?B?c2VhVTJ5dFJQcklMc2xua1dsd1VwMU54eUp1RHkwWXFwRE1oaHhEaXVROThh?=
 =?utf-8?B?Z0VDVFUzYnNScUJDM3MzTEdmVFVEWi9oTUtqRUlwTDdNemJSK2lNUXQ0bzBn?=
 =?utf-8?B?TWpxTUFibUJmeUxXS25CTDBFVnlTVjlwc1kzNFJJb09rT2kzc1NGNUo4UEh2?=
 =?utf-8?B?bUk1dDVEWTFSSEJIb1Q2V0lxTUM1MWJTTndVcE5udkxBWElMdFJQZmhmQUlW?=
 =?utf-8?B?SjVaZEpjajIvcjlCVzBqRnVWQzVXUDNqV3Nxbk94Sk5GcGFsRUk3d2ljTCs5?=
 =?utf-8?B?WUhsd3BoMlhxY2UwM2MxZFVQUlJrMGpiZFBWT1BKVVZGTGJVVTdvMGNVY1R0?=
 =?utf-8?B?N0xCNUxpVzU3SnE3bDgwODZ2b3VjTHhhY3RRSkIwRmh5Vk82cE5MR25RcWZt?=
 =?utf-8?B?eFZ0ZlRaWC9hUUs2ejFwU1M3aHJYdVVETlJzc0ZIQko5aWRTK3dHSkt3NVZJ?=
 =?utf-8?B?ZldhS2MzaFZJTW90akVlUURsTXFOY2pvUU9jdUlLTDRsTVlpRDZoa3M2NW9z?=
 =?utf-8?B?UDA4YS9nalZzbkgrTk01dEQ4UzdXZjBCbEY4SGRDRDhsay9Hdzh1WEFQTjd5?=
 =?utf-8?B?ZzB6Q3lHWm43bDd3NzhJS2czOFhpTklEZ3UwQ1ZQVElLNkVHcXVwNFgrbXRC?=
 =?utf-8?B?ZUxMSGlyY1RSRDg2aXJrZVp4dktSbzdTeEhlQVU1ZXZ6Q01hSC9pTCt5Z0Nk?=
 =?utf-8?B?MmVMdlhYQzg4VDNVbE5uUkVhNlIyVlRYT050TW81cVdJN3Yrb1hPdS9nOUJR?=
 =?utf-8?B?amlPdlRxY1hIcUtaZGFTNStLOXZwOGs3VXNxdTBvQ0tzaitGYnZTTlFNZm5s?=
 =?utf-8?B?L3A1YVl4Z1RUK3JqdDdTK3NKUlFCL0VDVGNaaXFzdUhnM1ExMDNqM3FUYlhq?=
 =?utf-8?B?V0tIUEl5U0xDN0FzcWJGUXFtc21DdDAyOURnZE93dWw4Z1pOSDFxZk9BaTl0?=
 =?utf-8?B?L2kvcUljOStYZUx5MjE3cFJ3Q3RWRU9MQlNMRDVuU0lPZGxUd0FIMUFvL2JH?=
 =?utf-8?B?UzlBakhqK3RpS09MQXBtYjFRUHdEQXdPVXplMENYRjRxNTNLNzZuOUFxUUk4?=
 =?utf-8?B?Qzh1eDZoYXdER0RCSHErbjdUQUJoM0txYkZwa0I4aVcxcTIrUG1uM1RKQko3?=
 =?utf-8?B?TmhaWWx1ZjU5QWwxY2VGZElwR3Iyd3JrT295czBLK1pSa2tPY2lSRTAvbGts?=
 =?utf-8?B?YzJOMEtINTQ4WmtXMHdsSjQ2VHpLeVZnQVoxVENBTjJtYUpsVW94QXdqRnVx?=
 =?utf-8?B?SUlDcTJHK2dPZkNvU2tyeTFRWFJrWUtHRUVvb3E5Ym1PMlhXQm80RHJzVnd4?=
 =?utf-8?B?UzlmaDcvclREUDEwZk1oR25vSVFhTEtLRVJia0cwMFpJVzJ6UTdMQzR2bVI2?=
 =?utf-8?B?UUsyeGQ5eUNocHFPWHJQdDE1OXdpS3A4elZIU2d6eG9OamlvbEFxTi9hMVA0?=
 =?utf-8?B?RUE5alpSaWUyNTlqVm44M0NiZUw5WkcrNk1HUzlqRXl4ZDNINlNSeGJHOENq?=
 =?utf-8?B?NHBISEcrcnAzTkJnN1p0bjh0eE5vbTBGVkc2TTJmSU9LMzk5a29mYU1rTytx?=
 =?utf-8?B?aTZoKzRydXlLRURsQkhFWmN1bDd6TDhOYUVjQ0FGSU45cHlWR0M3K2hVdTNs?=
 =?utf-8?B?RXg3QVNseVRjTXV0R2N6SmZsTUtXT3lOZytHRUhUekNJakFzeUI2SUljSkhR?=
 =?utf-8?B?SXgvU0dZQ0VBK3JzNE5mWm1GcjJHM3dLbEh5RTV4ZjVRdkdsTm9zR0Zqd3ZC?=
 =?utf-8?B?bUgxVjYrekw3QWxTYTJFQjFDUS9mVHZsZHY1NTlnTW0rc1pDRm9VUWNzUyta?=
 =?utf-8?B?QWFqVXBINDJTdFhIajdzOUJBTVhmOU5GaExlejVIRlVlRU5ucG9GcGJ3QThE?=
 =?utf-8?B?NzBTSVhLWGhXeEIwZlJJSDhOeTZKc3ZrUEhLRGtPdWh5V0hXS241SjhhMHli?=
 =?utf-8?B?TVZHYmVuNWtFMDhyeDVzVTdjZzFYOWtWcWIwRnNVaHZoa3BMRFVIQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f09691-f54a-4fd4-f854-08de63c0e86a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 07:42:11.7304 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P9bIj0IUjf4wkruOHY0O4TN47rth60jB3mtq2wg0LVwy/l03eB+D38qfZg+YXkdLSk88dtV0zDhiq7gLK+9lowv1z5Rx74XjZPrjQIy4nL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6771
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=kane_chen@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8
Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBGZWJydWFyeSAzLCAyMDI2IDg6NTcgUE0N
Cj4gVG86IEthbmUgQ2hlbiA8a2FuZV9jaGVuQGFzcGVlZHRlY2guY29tPjsgSmFtaW4gTGluDQo+
IDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxs
QGxpbmFyby5vcmc+Ow0KPiBTdGV2ZW4gTGVlIDxzdGV2ZW5fbGVlQGFzcGVlZHRlY2guY29tPjsg
VHJveSBMZWUgPGxlZXRyb3lAZ21haWwuY29tPjsNCj4gQW5kcmV3IEplZmZlcnkgPGFuZHJld0Bj
b2RlY29uc3RydWN0LmNvbS5hdT47IEpvZWwgU3RhbmxleQ0KPiA8am9lbEBqbXMuaWQuYXU+OyBv
cGVuIGxpc3Q6QVNQRUVEIEJNQ3MgPHFlbXUtYXJtQG5vbmdudS5vcmc+OyBvcGVuDQo+IGxpc3Q6
QWxsIHBhdGNoZXMgQ0MgaGVyZSA8cWVtdS1kZXZlbEBub25nbnUub3JnPg0KPiBDYzogVHJveSBM
ZWUgPHRyb3lfbGVlQGFzcGVlZHRlY2guY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDA0
LzExXSBody9hcm0vYXN0Mjd4MDogQWRkIERSQU0gYWxpYXMgZm9yIFNTUA0KPiBTRFJBTSByZW1h
cA0KPiANCj4gT24gMi8zLzI2IDExOjIzLCBLYW5lIENoZW4gd3JvdGU6DQo+ID4+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAa2Fv
ZC5vcmc+DQo+ID4+IFNlbnQ6IE1vbmRheSwgRmVicnVhcnkgMiwgMjAyNiA2OjQ5IFBNDQo+ID4+
IFRvOiBLYW5lIENoZW4gPGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNvbT47IEphbWluIExpbg0KPiA+
PiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPjsgUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVs
bEBsaW5hcm8ub3JnPjsNCj4gPj4gU3RldmVuIExlZSA8c3RldmVuX2xlZUBhc3BlZWR0ZWNoLmNv
bT47IFRyb3kgTGVlDQo+IDxsZWV0cm95QGdtYWlsLmNvbT47DQo+ID4+IEFuZHJldyBKZWZmZXJ5
IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+OyBKb2VsIFN0YW5sZXkNCj4gPj4gPGpvZWxA
am1zLmlkLmF1Pjsgb3BlbiBsaXN0OkFTUEVFRCBCTUNzIDxxZW11LWFybUBub25nbnUub3JnPjsg
b3Blbg0KPiA+PiBsaXN0OkFsbCBwYXRjaGVzIENDIGhlcmUgPHFlbXUtZGV2ZWxAbm9uZ251Lm9y
Zz4NCj4gPj4gQ2M6IFRyb3kgTGVlIDx0cm95X2xlZUBhc3BlZWR0ZWNoLmNvbT4NCj4gPj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2MSAwNC8xMV0gaHcvYXJtL2FzdDI3eDA6IEFkZCBEUkFNIGFsaWFz
IGZvciBTU1ANCj4gPj4gU0RSQU0gcmVtYXANCj4gPj4NCj4gPj4gT24gMi8yLzI2IDEwOjQ2LCBL
YW5lIENoZW4gd3JvdGU6DQo+ID4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4+
PiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0KPiA+Pj4+IFNlbnQ6IE1v
bmRheSwgRmVicnVhcnkgMiwgMjAyNiA1OjM0IFBNDQo+ID4+Pj4gVG86IEthbmUgQ2hlbiA8a2Fu
ZV9jaGVuQGFzcGVlZHRlY2guY29tPjsgSmFtaW4gTGluDQo+ID4+Pj4gPGphbWluX2xpbkBhc3Bl
ZWR0ZWNoLmNvbT47IFBldGVyIE1heWRlbGwNCj4gPj4+PiA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8u
b3JnPjsgU3RldmVuIExlZQ0KPiA8c3RldmVuX2xlZUBhc3BlZWR0ZWNoLmNvbT47DQo+ID4+Pj4g
VHJveSBMZWUNCj4gPj4gPGxlZXRyb3lAZ21haWwuY29tPjsNCj4gPj4+PiBBbmRyZXcgSmVmZmVy
eSA8YW5kcmV3QGNvZGVjb25zdHJ1Y3QuY29tLmF1PjsgSm9lbCBTdGFubGV5DQo+ID4+Pj4gPGpv
ZWxAam1zLmlkLmF1Pjsgb3BlbiBsaXN0OkFTUEVFRCBCTUNzIDxxZW11LWFybUBub25nbnUub3Jn
PjsNCj4gb3Blbg0KPiA+Pj4+IGxpc3Q6QWxsIHBhdGNoZXMgQ0MgaGVyZSA8cWVtdS1kZXZlbEBu
b25nbnUub3JnPg0KPiA+Pj4+IENjOiBUcm95IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+
DQo+ID4+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAwNC8xMV0gaHcvYXJtL2FzdDI3eDA6IEFk
ZCBEUkFNIGFsaWFzIGZvcg0KPiA+Pj4+IFNTUCBTRFJBTSByZW1hcA0KPiA+Pj4+DQo+ID4+Pj4g
SGksDQo+ID4+Pj4NCj4gPj4+Pj4gV29ya2luZyB3aXRoIG91ciBJVCB0ZWFtLCB3ZSd2ZSB0cmFu
c2l0aW9uZWQgdG8gYSBNaWNyb3NvZnQgbWFpbA0KPiA+Pj4+PiBzZXJ2ZXIgdG8gZW5zdXJlIERL
SU0gaXMgY29ycmVjdGx5IGluY2x1ZGVkLiBDb3VsZCB5b3UgcGxlYXNlDQo+ID4+Pj4+IGNvbmZp
cm0gaWYgeW91J3ZlIHJlY2VpdmVkIHRoZSBiZWxvdyBwYXRjaCBzZXJpZXM/DQo+ID4+Pj4+DQo+
ID4+Pj4+DQo+ID4+Pj4NCj4gPj4NCj4gaHR0cHM6Ly9wYXRjaGV3Lm9yZy9RRU1VL1NFM1BSMDZN
QjgxOTlGNEIwMDY5RjkzMjYwMzQ1ODVENkZDOUFBDQo+ID4+Pj4gQFNFM1BSMA0KPiA+Pj4+PiA2
TUI4MTk5LmFwY3ByZDA2LnByb2Qub3V0bG9vay5jb20vDQo+ID4+Pj4NCj4gPj4+PiBJIGRpZC4g
QWx0aG91Z2gsIHRoZSBzZXJpZXMgaXMgbm90IHRocmVhZGVkLiBQcm9iYWJseSBkdWUgdG8gdGhl
DQo+ID4+Pj4gd2F5IGl0IHdhcw0KPiA+PiBzZW50Lg0KPiA+Pj4+DQo+ID4+Pj4gVGhhbmtzLA0K
PiA+Pj4+DQo+ID4+Pj4gQy4NCj4gPj4+DQo+ID4+PiBIaSBDw6lkcmljLA0KPiA+Pj4NCj4gPj4+
IFRoYW5rcyBmb3IgdGhlIGNvbmZpcm1hdGlvbi4NCj4gPj4+DQo+ID4+PiBJdCdzIHBvc3NpYmxl
IHRoYXQgdGhlIHRocmVhZGluZyBpc3N1ZSB3YXMgcmVsYXRlZCB0byBzb21lIGV4dHJhDQo+ID4+
PiAnRnJvbScgaW5mbyBpbiB0aGUgbWFpbCBib2R5LiBJJ3ZlIHVwZGF0ZWQgdGhlIHNjcmlwdCB0
byByZW1vdmUgaXQsDQo+ID4+PiBzbyB3ZSdsbCBzZWUgaWYgdGhhdCBmaXhlcyB0aGUgaXNzdWUg
aW4gdGhlIG5leHQgdmVyc2lvbi4NCj4gPj4NCj4gPj4gT0suIEkgY2FuIG5vdCBmZXRjaCB0aGUg
c2VyaWVzIHdpdGggYjQuIFNvIHlvdSB3aWxsIGhhdmUgdG8gcmVzZW5kLg0KPiA+Pg0KPiA+Pg0K
PiA+PiBXaGF0IGFib3V0IHRoZSB2NiBvZiAiaHcvYXJtL2FzcGVlZDogQVNUMTcwMCBMVFBJIHN1
cHBvcnQgYW5kIGRldmljZQ0KPiA+PiBob29rdXBzIi4gRG8geW91IHBsYW4gdG8gcmVzZW5kIHNv
b24gPw0KPiA+Pg0KPiA+PiBUaGFua3MsDQo+ID4+DQo+ID4+IEMuDQo+ID4+DQo+ID4gSGkgQ8Op
ZHJpYywNCj4gPg0KPiA+IERvIHdlIG5lZWQgdG8gbWFrZSBhbnkgY29kZSBjaGFuZ2VzIHJlZ2Fy
ZGluZyB0aGUgImkyYy1idXMtbGFiZWwiPw0KPiANCj4gSSBkb24ndCByZW1lbWJlciBhbnkgY29t
bWVudHMgb24gdjUgcmVnYXJkaW5nIHRoZSBidXMgbmFtaW5nLg0KPiANCj4gUGxlYXNlIHJlYmFz
ZSBvbiB0b3Agb2YgOg0KPiANCj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2
ZWwvMjAyNjAyMDMwMjA4NTUuMTY0Mjg4NC0xLWphbWluX2xpbkANCj4gYXNwZWVkdGVjaC5jb20v
DQo+IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCj4gPiBJZiBub3QsIEkgd2lsbCBzZW5kIG91
dCB0aGUgcGF0Y2ggc2VyaWVzIHRvbW9ycm93Lg0KPiA+DQo+ID4gQmVzdCBSZWdhcmRzLA0KPiA+
IEthbmUNCg0KSGkgQ8OpZHJpYywNCg0KSSBoYXZlIHN1Ym1pdHRlZCB0aGUgdjYgcGF0Y2ggc2Vy
aWVzIGFuZCB3b3VsZCBhcHByZWNpYXRlIHlvdXIgcmV2aWV3Lg0KDQpJbiB0aGlzIHZlcnNpb24s
IEkgaGF2ZSB1cGRhdGVkIG15IG1haWwgc3VibWlzc2lvbiBzY3JpcHQgdG8gZW5zdXJlIHByb3Bl
cg0KcGF0Y2ggZ3JvdXBpbmcgKHRocmVhZGluZykuIEJhc2VkIG9uIHRoZSBQYXRjaGV3IGxpbmsg
YmVsb3csIHRoZSBwYXRjaGVzDQphcHBlYXIgdG8gYmUgY29ycmVjdGx5IGdyb3VwZWQgYXMgZXhw
ZWN0ZWQ6DQpodHRwczovL3BhdGNoZXcub3JnL1FFTVUvMjAyNjAyMDQwNjQwMTYuMzUxNTYzOS0x
LWthbmUuXzVGY2hlbkBhc3BlZWR0ZWNoLmNvbS8NCg0KSSBhbHNvIHdhbnQgdG8gYXBvbG9naXpl
IGZvciB0aGUgZHVwbGljYXRlIG5vdGlmaWNhdGlvbnMuIEkgaW5pdGlhbGx5IGRpZCBub3Qgc2Vl
DQp0aGUgdjYgc2VyaWVzIGFwcGVhcmluZyBpbiB0aGUgW3FlbXUtZGV2ZWxdIGFyY2hpdmVzLCBz
byBJIGF0dGVtcHRlZCBhDQpyZS1zZW5kIHRvIG15IHBlcnNvbmFsIGFkZHJlc3MgZm9yIHRlc3Rp
bmcuIFVuZm9ydHVuYXRlbHksIG15IGdpdCBjb25maWd1cmF0aW9uDQphdXRvbWF0aWNhbGx5IEND
J2QgeW91IGFuZCBOYWJpaCBhZ2Fpbi4NCg0KU29ycnkgZm9yIHRoZSBub2lzZSBhbmQgdGhlIHJl
ZHVuZGFudCBlbWFpbHMuDQoNCkJlc3QgUmVnYXJkcywNCkthbmUNCg==

