Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C36EF0702
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 03:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpHmP-0007j5-NT; Sun, 08 Feb 2026 22:17:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpHmN-0007iX-Eu; Sun, 08 Feb 2026 22:17:39 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpHmK-00013J-Fb; Sun, 08 Feb 2026 22:17:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqjWEoOnBfL0i8HRFBeH7LWNKqgRofS6MDW9AXd2Ri6UyMKoAfFXt5gj9eVKAK2qJa5t8XfMxXcTPfr2V+aJmT2ztszSQdujj7deR6CXtcXGR7nZ3Z1Z3vRiQTSanFcPD74CUOG0p4nnSzKgrKP9iCGlBrDR8fOwAG6hYib7tdpl5SyGzenp/pHdJ7RQlAEBFmOy5UI1yTzIFPvYIusCbJOyFrGDK3++UAs2cjPQSWZagfVkwfneD9iGRSJ3FllkEhvJ/6I1VdK3LhTMpjCX/cdZz49zazlPxiLsJzOii2i1gZoqmHEIRU6jUOlUgIAYEMk93oyQRzFE1QZO/iWR9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muB954ozODDNa2ovRRlebWy3R2GwEPoIblBp0tHvDDg=;
 b=dt/x2ScjkbvRaFceLMDjJxkLYS9FxAvtw97rSp9vV9STBse5pb81nlA24pnZbGKWk0NGnO1tC8i2aj1SwHGivOiFKMG87+ptl2a2dUv7twiWgxq/Pu0HgzBDN27QVrWvz4j0gWhFpHJHI5eAmoq4aM8vp360vsbvxsdxl+/HugkHHsYURLhxknqC5BiC8H1LSyfzfiDcWWSI3Vwd+hPbn5V3dNhrzIhFg9Rf4Tt4w1NpPNUG4Qug0bb1MvPmmM05q2kyZKJNVNoBYdyQt0munuTZJXbresb1L83BlioHFoSOzMk9iPOQ8BT8XcGv+Vb16YGjnVQez13O3rjNCepVAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muB954ozODDNa2ovRRlebWy3R2GwEPoIblBp0tHvDDg=;
 b=FqK8rCyNhY9KFgzH7g8n0ibl44lOkiMNdOUPkxXKSfHeF1UqgN4qPvC0zXip1En/YLnoN6J+yzGtCSvN3yx0pJ/6lT7FVjT5eg8aHZ9EfqyT81J589Q2EihvISobY/YRABESw6O8zKDp/yDW6DMnvBKCMV9C60U6E+zm/QmqemeL2Y4tarJRNqb2Z3ZxwY9gN7c7X1D1oV7Jn35p+BWXZtUTqyennKXH7+l1WAkDu/02t0GI2quMSpZ1IGJc2XFm04O1sTIe6lJC70iKF8qG5Tm0CRX3C0/Pz/9WACqiO9maAjS0FjKjEdaRCLWOTMStwc1HtYiBONtnyf1TkQnyNg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB7119.apcprd06.prod.outlook.com (2603:1096:405:ac::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Mon, 9 Feb
 2026 03:17:26 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 03:17:24 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:ARM TCG CPUs"
 <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: RE: [PATCH v3 00/20] i3c: aspeed: Add I3C support
Thread-Topic: [PATCH v3 00/20] i3c: aspeed: Add I3C support
Thread-Index: AQHclxdmYyJyqQdIoUC/kDEZE0v29bV1eaAAgAQ7zPA=
Date: Mon, 9 Feb 2026 03:17:24 +0000
Message-ID: <TYPPR06MB8206F2D0EAF733D287BB87D7FC65A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
 <53224b36-db6a-4790-8abc-d6aa79b95358@kaod.org>
In-Reply-To: <53224b36-db6a-4790-8abc-d6aa79b95358@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB7119:EE_
x-ms-office365-filtering-correlation-id: bad58aa1-f4d9-4b56-108c-08de6789bf11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|921020|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?QmQyRTJkM09aMkdmVXFiSHRpbWk2OTRUR3NueS9UVFN0SVBNc0I2WFp3MjBO?=
 =?utf-8?B?MmpTT0ZTeHQ4a0xRS0hYbitSemxMWEJsVFBSVTcwZHdZTUJHWkt0dmxCU1Bp?=
 =?utf-8?B?YUwxT2FkOXUvdVVTMTQ4R2xtQi9sTS85SU11N0dnN2VINHZld2lTNWl4dG1j?=
 =?utf-8?B?bE9Sem5pTWJKY05LUXZiOHNqSHY2elArRDdwVWd1MTRCdFhQOFNxdzRTVjhO?=
 =?utf-8?B?dExZcUtLY3hSOUxSMW51K1NCbkcySWJYZUY4MWpCYmxyeFN2bVo1a2ZsTWJD?=
 =?utf-8?B?KzZ4UnRCZWlmWnYySWJqV3dyM1VQMVQycmtnNzQyMmUvZ0JZaGVoV2hUSEdF?=
 =?utf-8?B?a0tiR0VKY01qS1N3L1RPOWxsTTJtejNaNWFINVZiSjJEMFM0RFVEUXl2YWRQ?=
 =?utf-8?B?K3BjYm43amlLdXQ2SmxNa0l0cVkxUGRwVmlyU3pxSnVycW1KZzFrazM5OFlj?=
 =?utf-8?B?eTdtZXFTdFVxbXIweWd4RWNwRDY3ZjkxZ2U2NnB2K2VJc00wOTJMVkdyTWov?=
 =?utf-8?B?cjFPWDJpeHcxZXFVelBFbWVoQUtTU3pHRGlEcWNqa1RNR2JHTHZmQ2JNUktZ?=
 =?utf-8?B?cW81a2hNRmhaR2dsK1daQldram9KL3V2aWMwMU43bmJjNVdGNXBQZ01GT3RQ?=
 =?utf-8?B?S1VHUStKTnhaWUJSa1ZPZVFhcUdra1dxTktWTm8xV01vUFRQbkQrbnd6TGpF?=
 =?utf-8?B?SFdWcG9VUlVobFMxRVNEMTdQTGVyeG5ONEw5TXVpc1N2RGlJamtQRFp2Z2cz?=
 =?utf-8?B?NXJ3R01Ua3lMc2oraFpXcncwZ1NPLzgyQjBCQ3ZaVVlhZkU5VkxyT0RONDZv?=
 =?utf-8?B?a3N3YVBTMVVsaFpkbFJNTjhhN3VEQzNWTEVkWEIyRU4zTUM0bDBZa25YakhY?=
 =?utf-8?B?S3huZEtDSUtvY2x6UnFWOHBzbFJ4dFF3WlJDVUdxSEE5T2QrUVFJc2IzUm94?=
 =?utf-8?B?U1N2czJ1Sit2bHVDVnN6NkoyUWtjMm0yUlNVZGJ1RnJJWVlqSUNsT0syVGRJ?=
 =?utf-8?B?ZEx3cTlFTmFaT096Z0RXV3NIa1RibVkxcDdpMVYzMW9TbjhSYlpxaFNnT0hX?=
 =?utf-8?B?SWt3MTZXaVkwcGVVdnRkTHR6QU5ZZ3NqdlNySGp0TDlFc20xeVN0ejlNa2wv?=
 =?utf-8?B?c1hnSHgyYmZ6R1pRMzNpQTBNUDgwQTZaSjFiSWF3UW8vQ0pmdXdTNk0rZW0v?=
 =?utf-8?B?azJsakZDSittOU1xM2pzNUJ3Nm1Dc1EvTTBtbVUxNXc2clM2a1VtVVJQRHNW?=
 =?utf-8?B?amt4ZlRqR0ZPNnA0VTQ3MDROUEtLZjhpMjhyUXErVTM5U3ZsS0VWVk96bFlR?=
 =?utf-8?B?N25YZ2hNc3pZd0drRjJNMWw5UkQrTEJyMVFXbnhiS1N0b3JCRElKVjFqU3h4?=
 =?utf-8?B?aHJiOGVnVnQwMkY0TG1CaEhoOEM3UFUwZFA1dnNCSG1xYTVVWU1OOTJhWFZS?=
 =?utf-8?B?KzMzY1p2UjdjTWhYU2JDUmxHeE41STFUdTBWMEJyWDV1RUlBb2J6S0FYZlhz?=
 =?utf-8?B?bldjQlVyQmNiTmF6cjRuRmFUZy85V2tCOFNtRUFyRHgzSEE5TTNZZE1LZk1N?=
 =?utf-8?B?OUlyL2ZwVVp4U3VrblJPeU9aVkpFRVRoZ0ltL1JoeUhqVkF2Nk43S1hqRHZq?=
 =?utf-8?B?UmVZYndCN3lqNEw3eWdmSXFCWlV1SWlqVTRsSXJOUkpoUlFSVzMwRkEzR2J2?=
 =?utf-8?B?cWNYYkZSYkhwLzlpeVpYTEt5TVI2WXVFTmwvSnFucENrQTNnK3ZaaS9TVzBv?=
 =?utf-8?B?WGpQUWtJVjd0WE1QN2wyczhqRmEzTFlaU2JFcDB2MFluYVJ6RUhkTUNneTdp?=
 =?utf-8?B?eDZubklXWDltOGpWQnZKNzc2RWIwWGYremQ5UHB1aGtOa1JqS21Nazhqczhk?=
 =?utf-8?B?ZDR0MHpHb2NKV3l3TE1kYzV4YkYwaUdreUtCcDQvSmZ5MWtWTlZyaGJYZ21X?=
 =?utf-8?B?MlMyd0laUGVmc3pQS1FPd0JXQzJUWk40bTZGTGVsMEV1RHNJakNhWHlYc1gx?=
 =?utf-8?B?K1lhQ0NMVjBGOENmSGhJS2xaTGU0c2dKVlQ2MFlMSElCQ0dBSyt2RjdwU3FC?=
 =?utf-8?B?aVpNSmJXU3RiQ24wTmdOUXdlaDBLZGJGWWpYQXJOK3JwOElxaU5MdkhkSUti?=
 =?utf-8?B?eG1rOVliSjBCb3l4N09WeUZCaldEV0U5RWU4QnJGeWlCQ1F0bDdTVGg2dG5F?=
 =?utf-8?Q?3l/2VfHARXAVLqICzYZIqs70XzRki3BUfB9qeYUxzcIQ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEwzaExLR2FkN3J5N3ZWTjkyZGcrKzZTQmxEQzRyc21TOEdyTHFDNWRoSlBt?=
 =?utf-8?B?Ti9zcWR1V2xYVUV2OTZDUXMwNFM5Ri9BbDNoQlBycWpLdDM4aVJhejViUkgr?=
 =?utf-8?B?bWJEaEQyMlV2VHJHYjRjbFVhNE9IeWQwT2dETkUySGdZRXJ3Rk9kYmNyd0o3?=
 =?utf-8?B?Um9NTUIvenE5Zk5sL3BUQU1Sa0w4VnMzQzNuL2U1ZWQ4aFlJNE1CT3N4ZmFR?=
 =?utf-8?B?SkNoaUcvb3VGak8yMTNyN2VBVVdDTXdhSEZBdGZrb2JMYW1GUzdqWDQxeXNM?=
 =?utf-8?B?RGJFaDdFc0FVV093VzZIUEM5bnBBdG9ndjZ4RE9ra2xVU21rK1g2NTFQbWdF?=
 =?utf-8?B?T2FsK1JCelFEV0xweG5adTdtRHlwY3hPWmJJUkVRNmRYVHhJUTlFcENZN1RB?=
 =?utf-8?B?R2lPMk5nbkRKYWtjYUlWV21LVWM5MVpuSTNBL1RBNnplZWxEckR1a0wwblJO?=
 =?utf-8?B?cXpsK2x6MlljU3ZxUWZ3YVJSWDAvcFg0STEvK2s2UHNDb2Fybmt5b1FHYzhI?=
 =?utf-8?B?Mzd6aitiMVEzK0RXUGVjc3d0aitjcURtZkNwUnRNQmlPNW1GMlpKZzRpajFV?=
 =?utf-8?B?VXFGSTJqb2MzeGhKdUQrMTBEa2o3RkFjUVpjNEJibG9GYTIvUlhxUnBlUnB2?=
 =?utf-8?B?YWZuSW9JVVQwb1orME14dWtMQjVWNStxQis1WlQ2N3ZncWN6bkVKd29pZThz?=
 =?utf-8?B?bTN4OW1OTXdudDhLS2hJdkI4TzdWR0c5N2I5MGRHMGQreTNpZzNNT2dxVlNR?=
 =?utf-8?B?R2pCOStUZllxWUVzVnYzQWhXNVlXSkRBN2VsS0JHNnh6azgwaGVacVgzd1Y1?=
 =?utf-8?B?cWNicEZyMkg0dVhVeHdrWUVJcGRCWlZSb1E4cHI2L1VhZXlSZDhualR6OEtl?=
 =?utf-8?B?Tk9KaU91eGNEQ08zN3ozUTg3c01wZTNvMGZQL283Wkp1U2NvczJPMmVtbU5W?=
 =?utf-8?B?N2p1UWFIZFQ2YVZvb1M2WEpteXV0d1dRMlVwSVpGSEJQL2dmOTF4UC9TRTZv?=
 =?utf-8?B?bXhJOXZWUmdWMnB2SUxUNWpmOXB0ZW45dnZCanZtcXdtSlZ1VDBCRzl0M1Rr?=
 =?utf-8?B?NkpoWTluUDBIWGRud1FSWmM0bmFSTHdKOHNWc2ovYUVNVTZpajAzbmlrZ3la?=
 =?utf-8?B?WXdsNmRxNlQxZGh5R1JYVWtoNTdrMTViNlRicFQ5MHNGekRsRmlyUThiZy9W?=
 =?utf-8?B?ZmtuNUNJWkJWQlUrZW4rcGpzaFBMeUZ4Z1UvQVU4dUp6K3JkUHQ5YkI3M0Qw?=
 =?utf-8?B?WjJ0ZUFHelZjQ0V1ZTN1dmRWa0JyREk2NHZsMk0xVDVYNG11YWptSjNuNnR0?=
 =?utf-8?B?ck1SdkdTeGM5KzdjaTdyaUNNeHZJZytzWlNDOUtWZlphN3kvTVdmT0N3aXFQ?=
 =?utf-8?B?UnlTVTZTQTJoaXNsb3NENUdHN3NaTlJFWkxqODZUaEIvSFk2cU1MYjR4TVZJ?=
 =?utf-8?B?M3d4MkZSSHRSOXFjRm9yWm82S1BmdEk4ank1WG9qQ29STzZiRXVKREorRlpG?=
 =?utf-8?B?RktjdVNuV2dxUkNjVnBZbFl6SU8rNmZZeHhDVkRIUHhGQnRpZFZHMjZjVTFK?=
 =?utf-8?B?RERQUENsRUZKcU5lQlNzS0dtbDVnWHpUNnNscVJKSzMrNWFoZ3lXSWhETU5C?=
 =?utf-8?B?czE0Njh2c3pjTkY2em9EWENoWWpKWk1aQ1BYVkpudmNtekRzc0g1YUg0cFFk?=
 =?utf-8?B?STVsQXJJMFkwL0RKZ2w0bGZQUjcyNnArTC8vZnN5VkkxRmJzMUh5Um5EcTFV?=
 =?utf-8?B?RFg3T0s2cFNuSTJFWU90R2x1NTAxa3lHMVdDdGtsRFdIQ2RJeTZtRWU0bGFh?=
 =?utf-8?B?eFlwWXVBeDFLM3FLa0dmWm5GK2RYTERHSkI0QzdXbjRzQW55NVJHZDZzU0ZO?=
 =?utf-8?B?Qzkxc3JKYTVaUDhra1diV2Y5d0ExSlMwenJPZTZpZVEzQ0E5YmZRNWVmYld6?=
 =?utf-8?B?T0h0TmVsa1FFUU5EanN6Z1FwMzJOb3MvZnVkMi80ekIrcHFrZk5meXNGT0Za?=
 =?utf-8?B?STJheXZIM2N3WkVpbSs0Q2pwcWV4WXl4bEozLzBHdmhxTGlHTjBDNGlnVkIx?=
 =?utf-8?B?Vk9IdUxpQ3lrSW03Mm5zMi9KaTdUZ21xV0JDYXpyTm1vUkdaWnF5MzExYk9D?=
 =?utf-8?B?S3BRUmliOW9JcHNWZUVZakF4RVF0UE11MkxHSXdzcTF5dFhSd1RKZWNyUmhC?=
 =?utf-8?B?c0pndGdtMXJSemozMFgzaTlaa3pNL3llbEZqMEZTR0UvZDJpR0Q5QWJITlg5?=
 =?utf-8?B?TTBrYzE4b2R4bkx4ZHZtcnlSdkJIZ0ljYnJtaXpUbllhYVhSVUYyNmx6ZnBL?=
 =?utf-8?B?QTNJaEJvN0x2d2RMMThoRmVxcVRPTGE0djk4U0dHM3RQd1Vzd0pEZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad58aa1-f4d9-4b56-108c-08de6789bf11
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 03:17:24.6640 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fTCpYNTUV8zN5jI8g8gVMkoAZDsn8Dh9TzyELcw39cPtdLZNDmahCbx2mv8nLz/bdH0JKOEBWGCy+er23/Nf8G4VavD+FxrfbO8C0yl+HYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7119
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

SGkgQ8OpZHJpYywNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDAwLzIwXSBpM2M6IGFzcGVl
ZDogQWRkIEkzQyBzdXBwb3J0DQo+IA0KPiBPbiAyLzYvMjYgMDQ6MTksIEphbWluIExpbiB3cm90
ZToNCj4gPiB2MToNCj4gPiAgICBUaGUgaW5pdGlhbCBwYXRjaCBzZXJpZXMgd2FzIGJhc2VkIG9u
IHdvcmsgYnkgSm9lIEtvbWxvZGkNCj4gPGtvbWxvZGlAZ29vZ2xlLmNvbT4uDQo+ID4NCj4gPiAg
ICBUaGlzIHNlcmllcyBhZGRzIEkzQyBidXMgc3VwcG9ydCB0byBRRU1VIGFuZCBhZGRzIG1vcmUg
ZnVuY3Rpb25hbGl0eSB0bw0KPiB0aGUNCj4gPiAgICBBc3BlZWQgSTNDIGNvbnRyb2xsZXIuDQo+
ID4NCj4gPiAgICBUaGlzIGltcGxlbWVudGF0aW9uIGlzIGEgYmFzaWMgaW1wbGVtZW50YXRpb24g
dGhhdCBpbnRyb2R1Y2VzIElCSXMNCj4gPiAgICAoaW5jbHVkaW5nIGhvdC1qb2luKSwgQ0NDcywg
YW5kIFNEUiBkYXRhIHRyYW5zZmVyLiBBcy1pcywgaXQgZG9lc24ndCBzdXBwb3J0DQo+ID4gICAg
bXVsdGktY29udHJvbGxlciBidXNlcyBvciBIRFIgdHJhbnNmZXJzLg0KPiA+DQo+ID4gICAgRmly
c3Qgd2UgYWRkIHRoZSBJM0MgYnVzIGFuZCBjb250cm9sbGVyIG1vZGVsLiBXaXRoIHRoYXQgYWRk
ZWQgd2UNCj4gZXh0ZW5kDQo+ID4gICAgdGhlIGZ1bmN0aW9uYWxpdHkgb2YgdGhlIEFzcGVlZCBJ
M0MgY29udHJvbGxlciBzbyBpdCBjYW4gZG8gdHJhbnNmZXJzDQo+ID4gICAgYW5kIGhhbmRsZSBJ
QklzLg0KPiA+DQo+ID4gICAgTmV4dCwgd2UgYWRkIGEgbW9jayBJM0MgdGFyZ2V0LiBJdCdzIGlu
dGVuZGVkIHRvIGJlIGEgdmVyeSBzaW1wbGUgdGFyZ2V0DQo+ID4gICAganVzdCB0byB2ZXJpZnkg
dGhhdCBJM0MgaXMgd29ya2luZyBvbiB0aGUgZ3Vlc3QuIEludGVybmFsbHksIHdlJ3ZlIHVzZWQg
aXQNCj4gPiAgICBvbiBMaW51eCB0byB2ZXJpZnkgdGhhdCBpM0MgZGV2aWNlcyBjYW4gYmUgcHJv
YmVkIGFuZCBjYW4gc2VuZC9yZWNlaXZlDQo+IGRhdGENCj4gPiAgICBhbmQgSUJJcy4NCj4gPiAg
ICBUaGlzIHRhcmdldCBpcyBzb3J0IG9mIGxpa2UgYW4gRUVQUk9NLCBhbmQgaXQgY2FuIGFsc28g
c2VuZCBJQklzIHVwb24NCj4gPiAgICByZWNlcHRpb24gb2YgYSB1c2VyLWRlZmluZWQgbWFnaWMg
bnVtYmVyLg0KPiA+DQo+ID4gICAgTGFzdGx5IHdlIGFkZCAgaG90cGx1Z2dpbmcgc3VwcG9ydC4g
VGhlIGhvdHBsdWdnaW5nIGRvZXNuJ3QgZG8NCj4gYW55dGhpbmcgdG9vDQo+ID4gICAgY29tcGxp
Y2F0ZWQsIGl0IGp1c3QgYWRkcyB0aGUgZGV2aWNlIGF0dGVtcHRpbmcgdG8gaG90cGx1ZyB0byB0
aGUgYnVzLiBJdA0KPiA+ICAgIGlzIHRoZSBkZXZpY2UncyByZXNwb25zaWJpbGl0eSB0byBob3Qt
am9pbiBhbmQgZ28gdGhyb3VnaCB0aGUgREFBIHByb2Nlc3MNCj4gPiAgICB0byBwYXJ0aWNpcGF0
ZSBvbiB0aGUgYnVzLg0KPiA+DQo+ID4gdjI6DQo+ID4gICAgSmFtaW4gTGluIDxqYW1pbl9saW5A
YXNwZWVkdGVjaC5jb20+IGhhcyB0YWtlbiBvd25lcnNoaXAgb2YgdGhlIEkzQw0KPiBwYXRjaA0K
PiA+ICAgIHNlcmllcyBmb3IgdXBzdHJlYW0gc3VibWlzc2lvbi4NCj4gPg0KPiA+ICAgIENoYW5n
ZXMgaW4gdGhpcyB2ZXJzaW9uIGluY2x1ZGU6DQo+ID4NCj4gPiAgICAxLiBBZGRlZCBJM0MgZnVu
Y3Rpb25hbCB0ZXN0cy4NCj4gPiAgICAyLiBVcGRhdGVkIHBhdGNoIDQgdG8gcmVmaW5lIHJlZ2lz
dGVyIGZpZWxkIGRlZmluaXRpb25zLg0KPiA+ICAgIDMuIFVwZGF0ZWQgcGF0Y2ggNyB0byBjb3Jy
ZWN0IHJlYWQtb25seSByZWdpc3RlciBmaWVsZCBtYXNrcy4NCj4gPg0KPiA+IHYzOg0KPiA+ICAg
IDEuIEFkZCBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNv
bT4NCj4gDQo+IFNvYiBpcyBzdGlsbCBtaXNzaW5nLg0KDQpUaGFua3MgZm9yIHBvaW50aW5nIHRo
aXMgb3V0Lg0KSSBjaGVja2VkIHBhdGNoZXMgMSAtIDIwIG9mIHRoaXMgcGF0Y2ggc2VyaWVzLCBh
bmQgdGhleSBhbGwgaW5jbHVkZToNClNpZ25lZC1vZmYtYnk6IEphbWluIExpbiA8amFtaW5fbGlu
QGFzcGVlZHRlY2guY29tPg0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L3Fl
bXUtZGV2ZWwvbGlzdC8/c2VyaWVzPTEwNTE0MDgNCg0KRG8geW91IG1lYW4gdGhhdCB0aGUgU2ln
bmVkLW9mZi1ieSBpcyBtaXNzaW5nIGZyb20gdGhlIGNvdmVyIGxldHRlcj8NCkNvdWxkIHlvdSBw
bGVhc2UgbGV0IG1lIGtub3cgd2hlcmUgdGhlIFNpZ25lZC1vZmYtYnkgc2hvdWxkIGJlIGFkZGVk
Pw0KDQpUaGFua3MsDQpKYW1pbg0KDQo+IA0KPiBDLg0KPiANCj4gDQo+IA0KPiA+ICAgIDIuIEZp
eCBhIHR5cG8NCj4gPiAgICAzLiBGaXggQVNQRUVEIG1haWwgc2VydmVyIGlzc3VlDQo+ID4NCj4g
PiBKYW1pbiBMaW4gKDEpOg0KPiA+ICAgIHRlc3RzL2Z1bmN0aW9uYWwvYXJtL3Rlc3RfYXNwZWVk
X2FzdDI2MDBfc2RrOiBBZGQgaTNjIGZ1bmN0aW9uYWwgdGVzdA0KPiA+DQo+ID4gSm9lIEtvbWxv
ZGkgKDE5KToNCj4gPiAgICBody9taXNjL2FzcGVlZF9pM2M6IE1vdmUgdG8gaTNjIGRpcmVjdG9y
eQ0KPiA+ICAgIGh3L2kzYzogQWRkIGJ1cyBzdXBwb3J0DQo+ID4gICAgaHcvaTNjOiBTcGxpdCBE
ZXNpZ25XYXJlIEkzQyBvdXQgb2YgQXNwZWVkIEkzQw0KPiA+ICAgIGh3L2kzYy9kdy1pM2M6IEFk
ZCBtb3JlIHJlZ2lzdGVyIGZpZWxkcw0KPiA+ICAgIGh3L2kzYy9hc3BlZWRfaTNjOiBBZGQgbW9y
ZSByZWdpc3RlciBmaWVsZHMNCj4gPiAgICBody9pM2MvZHctaTNjOiBBZGQgbW9yZSByZXNldCB2
YWx1ZXMNCj4gPiAgICBody9pM2MvYXNwZWVkX2kzYzogQWRkIHJlZ2lzdGVyIFJPIGZpZWxkIG1h
c2tzDQo+ID4gICAgaHcvaTNjL2R3LWkzYzogQWRkIHJlZ2lzdGVyIFJPIGZpZWxkIG1hc2tzDQo+
ID4gICAgaHcvaTNjL2R3LWkzYzogVHJlYXQgbW9yZSByZWdpc3RlcnMgYXMgcmVhZC1hcy16ZXJv
DQo+ID4gICAgaHcvaTNjL2R3LWkzYzogVXNlIDMyIGJpdHMgb24gTU1JTyB3cml0ZXMNCj4gPiAg
ICBody9pM2MvZHctaTNjOiBBZGQgSVJRIE1NSU8gYmVoYXZpb3INCj4gPiAgICBody9pM2MvZHct
aTNjOiBBZGQgZGF0YSBUWCBhbmQgUlgNCj4gPiAgICBody9pM2MvZHctaTNjOiBBZGQgSUJJIGhh
bmRsaW5nDQo+ID4gICAgaHcvaTNjL2R3LWkzYzogQWRkIGN0cmwgTU1JTyBoYW5kbGluZw0KPiA+
ICAgIGh3L2kzYy9kdy1pM2M6IEFkZCBjb250cm9sbGVyIHJlc2V0cw0KPiA+ICAgIGh3L2kzYy9h
c3BlZWQ6IEFkZCBJM0MgYnVzIGdldCBmdW5jdGlvbg0KPiA+ICAgIGh3L2kzYzogQWRkIE1vY2sg
dGFyZ2V0DQo+ID4gICAgaHcvYXJtL2FzcGVlZDogQnVpbGQgd2l0aCBJM0NfREVWSUNFUw0KPiA+
ICAgIGh3L2kzYzogQWRkIGhvdHBsdWcgc3VwcG9ydA0KPiA+DQo+ID4gICBtZXNvbi5idWlsZCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAxICsNCj4gPiAgIGh3L2kzYy90
cmFjZS5oICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDIgKw0KPiA+ICAgaW5j
bHVkZS9ody9hcm0vYXNwZWVkX3NvYy5oICAgICAgICAgICAgICAgICAgIHwgICAgMiArLQ0KPiA+
ICAgaW5jbHVkZS9ody97bWlzYyA9PiBpM2N9L2FzcGVlZF9pM2MuaCAgICAgICAgIHwgICAyMiAr
LQ0KPiA+ICAgaW5jbHVkZS9ody9pM2MvZHctaTNjLmggICAgICAgICAgICAgICAgICAgICAgIHwg
IDIwMSArKw0KPiA+ICAgaW5jbHVkZS9ody9pM2MvaTNjLmggICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgIDI3NyArKysNCj4gPiAgIGluY2x1ZGUvaHcvaTNjL21vY2staTNjLXRhcmdldC5oICAg
ICAgICAgICAgICB8ICAgNTIgKw0KPiA+ICAgaHcvaTNjL2FzcGVlZF9pM2MuYyAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgIDI2MSArKysNCj4gPiAgIGh3L2kzYy9jb3JlLmMgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICA2NjkgKysrKysrDQo+ID4gICBody9pM2MvZHctaTNj
LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxODY0DQo+ICsrKysrKysrKysrKysr
KysrDQo+ID4gICBody9pM2MvbW9jay1pM2MtdGFyZ2V0LmMgICAgICAgICAgICAgICAgICAgICAg
fCAgMzExICsrKw0KPiA+ICAgaHcvbWlzYy9hc3BlZWRfaTNjLmMgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgIDM4MyAtLS0tDQo+ID4gICBody9LY29uZmlnICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgICAxICsNCj4gPiAgIGh3L2FybS9LY29uZmlnICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgIDMgKw0KPiA+ICAgaHcvaTNjL0tjb25maWcgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxNSArDQo+ID4gICBody9pM2MvbWVzb24uYnVp
bGQgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICA2ICsNCj4gPiAgIGh3L2kzYy90cmFj
ZS1ldmVudHMgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgNDcgKw0KPiA+ICAgaHcvbWVz
b24uYnVpbGQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgMSArDQo+ID4gICBo
dy9taXNjL21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAxIC0NCj4g
PiAgIGh3L21pc2MvdHJhY2UtZXZlbnRzICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDYg
LQ0KPiA+ICAgLi4uL2Z1bmN0aW9uYWwvYXJtL3Rlc3RfYXNwZWVkX2FzdDI2MDBfc2RrLnB5IHwg
ICAxMiArDQo+ID4gICAyMSBmaWxlcyBjaGFuZ2VkLCAzNzMwIGluc2VydGlvbnMoKyksIDQwNyBk
ZWxldGlvbnMoLSkNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9pM2MvdHJhY2UuaA0KPiA+
ICAgcmVuYW1lIGluY2x1ZGUvaHcve21pc2MgPT4gaTNjfS9hc3BlZWRfaTNjLmggKDYzJSkNCj4g
PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2h3L2kzYy9kdy1pM2MuaA0KPiA+ICAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvaHcvaTNjL2kzYy5oDQo+ID4gICBjcmVhdGUgbW9kZSAx
MDA2NDQgaW5jbHVkZS9ody9pM2MvbW9jay1pM2MtdGFyZ2V0LmgNCj4gPiAgIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBody9pM2MvYXNwZWVkX2kzYy5jDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaHcv
aTNjL2NvcmUuYw0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2kzYy9kdy1pM2MuYw0KPiA+
ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2kzYy9tb2NrLWkzYy10YXJnZXQuYw0KPiA+ICAgZGVs
ZXRlIG1vZGUgMTAwNjQ0IGh3L21pc2MvYXNwZWVkX2kzYy5jDQo+ID4gICBjcmVhdGUgbW9kZSAx
MDA2NDQgaHcvaTNjL0tjb25maWcNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9pM2MvbWVz
b24uYnVpbGQNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9pM2MvdHJhY2UtZXZlbnRzDQo+
ID4NCg0K

