Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F56D3CCB6
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 07:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgHdX-0003da-B0; Thu, 15 Jan 2026 02:19:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vgHdV-0003cy-7N; Thu, 15 Jan 2026 02:19:17 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vgHdR-0000YG-Ub; Thu, 15 Jan 2026 02:19:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QClch7SP/bKwWAFjwGWPCD/8Ulv35uZIgPFrE6uf3hhkveehe6ieg3fj5S5coGU5M9GqKxRDu7A46yw9S7TNxNTZEkrbBPwIgKk1nvQ3grP/djDZRXy94TE3XvbGvsrkqOFrhvJ7MfhZOXCaL1CBkbt0+zTwQg1Hl1D8nWPop2WUyHXuLfdATYIZ5bADP4w1z3qfawcL1jjFRErCphBlNqOrQQLI0TwWj0AzVnVKiOqYewoC/dEzwuTrx5MiM0KtKV68oCJ2GJoj7TLX6cAxOmwuVNBdsazirpTt+Ht8q26ByNTrBHAraM83DfMd5ynn67wYgQ/kHevYETNzeo/Skw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZKbvJY8IVFLz/vuVLhO8R3rWeS0Aru75FOBNlGUd2U=;
 b=lWYXsBdlwAG+Zzfj8mw9KREobOCVYi2Cmpj+mfgFF5SuUQHb9Et6MsZ4u99apusoX7i0uDr8hFTJdiOKDWUVa7A/RCuNoQYFUKV9wmVuhHv9vHDWd7+MToaBwoBnuYzYN1cNQ8mKCChD5NnGx6zw4A8QwMuevqzIo1sbzVmeqQ69qP40WYF4gu70UxHdHILE0l8iTL+bYpgOjSkfoINmfAfdRu+RNY/i5sIhdbKYpsgbaJ3KzZiYPcYH4bHKMstMwYx4GyI2w94GNXO9X0+R6fcqATn8nZrkX9VYHGbUV93Ih/ie+jReHOZDiM2DpoIK2BfVhivYhJg35Yp57ngthA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZKbvJY8IVFLz/vuVLhO8R3rWeS0Aru75FOBNlGUd2U=;
 b=j2pjpQST/KiVAcaY/4D8iLc63ngMGYg+lIOLuH+ecDFyYm3EQB8XLfj/PobGm/oFX14fbEdE2FZWXvMUmV6AlQnA4GtMajoCQ7NNWMKwdMKpQGLxT/z3DeutHyoOBW3PPH3jlxCvW8ScjTo2WehYUI9Z8vxh4FBAQ33Kh6/F/dCNoy2LWogINi6MRjK9WHIsevxTlOmnTP7clIICTOAl+Y4JmJr9c+Yu6e3xYqjGVsxHOhhi1Swl+ED9FF053VnEpVaqBLlKIM1PnXKyRQk/g79P0kbU8fnffYbaGCvJ+gACN9yRaPsdnJJ/03dOtFstair+lluCddgbt10Zo2sdZw==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by OSQPR06MB7974.apcprd06.prod.outlook.com (2603:1096:604:429::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Thu, 15 Jan
 2026 07:19:07 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 07:19:07 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 1/1] hw/i2c/aspeed: Introduce 'bus-label' to customize
 bus naming
Thread-Topic: [PATCH v1 1/1] hw/i2c/aspeed: Introduce 'bus-label' to customize
 bus naming
Thread-Index: AQHcg53HErTDWlIB9UOtfzo9nCKDrLVS1jKAgAAAfgA=
Date: Thu, 15 Jan 2026 07:19:07 +0000
Message-ID: <SI6PR06MB7631282EF8FFF2DDEDE798F5F78CA@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20260112083054.4151945-1-kane_chen@aspeedtech.com>
 <20260112083054.4151945-2-kane_chen@aspeedtech.com>
 <cd9a0f11-7d36-4e58-afc8-96113ceb3613@kaod.org>
In-Reply-To: <cd9a0f11-7d36-4e58-afc8-96113ceb3613@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|OSQPR06MB7974:EE_
x-ms-office365-filtering-correlation-id: e619d1c3-c547-4a5e-d69a-08de54065ede
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ODNJUm03NVFrQTBSRWRBVFYrUXJqakR6SFY1OHV1RWp1MXhBNm9IZzBJQmlS?=
 =?utf-8?B?Um9pNDBkTENNalkxblB5SjI1QjNOUnpHTWtwNkdlT1N0aUc1dHRmOCtzTE9D?=
 =?utf-8?B?bkRuWTlaYXN2c0sxckJzVGR4ZDdwNFBqQ0Uyd0s1Y1h5ZVNBWjlPQThxM2dW?=
 =?utf-8?B?MHNKMVJ2SUh3Ynl5RHVIMVp0L2p6Y0VlaEpHVnlWNWFkZG9sLzRYOE9NM3dn?=
 =?utf-8?B?UGVlaU9HOThDRDZPRjJwczlmSXk0bTJaN1ZKYllkRkh5N2NxeWFITlMwT09C?=
 =?utf-8?B?M2hFY3duelhISGYrMXdyL2xoNXgvMUlhMG9DNVdhaUcrQUQ2TE81VDFEVldh?=
 =?utf-8?B?Qk5NSzd3aHBldUZwYW9OYVhTM2gyNi9ReWdLUGNCaTFIWTBSQ1BlaXI0MWUr?=
 =?utf-8?B?UVNINTZwSHZtYWk2aDBnYzZNcmNDaVM1MnJ2Wkk1TVRYVDF3Yk8wYUdNbkJl?=
 =?utf-8?B?ZzBmbWVMem1YZHhqN05HWklWdWtPU2U4aFdSQnpPeWtEWk9vNTBtc0l6QWRn?=
 =?utf-8?B?TzVpbW0xUU1ZSDRGeXFPbEQvL1FHVmtiVVNadGU3WjZ4dVUzUE04YmVQeTN4?=
 =?utf-8?B?Rmk4UUhVTlhRMVhSRWtmZW9LSU9jN0NoTmhGdVNEWUJvTWJ4OVNpeVo0RWpR?=
 =?utf-8?B?TDE3NUY2aVBIUlRZelQxc0p2QTAvekIzM3F0OGZIZjJKcW1yaGQybndXUUVS?=
 =?utf-8?B?K3RwK2wwekEyZzllRWw0eWdwNXQzRTZla2tDaXZldktJUXVDcitsZ3VTVy9z?=
 =?utf-8?B?YkxBTUpoVG0rakJxYVVsUUxqcDdBd1JnOEtVcUpPMSt5UHI3dWl3NE9MY1JL?=
 =?utf-8?B?SWpjQk5LdVRjZy9qRFE2cmVsd2s2c01xbUY2Nm9temEvbmNvZnU0YklIVU9M?=
 =?utf-8?B?MXgzSFNueVdRL2FPS29oNHRibytQVU1YOXloTy9LN3VIaG5vaEgwUVNWRElB?=
 =?utf-8?B?VHIvdlJ3cWtoUWFsZUFBK1hTSC9sU0xocldhWmUzQmhpQnExUVI1TVpoY0xy?=
 =?utf-8?B?WHZJRmlvVlJCOGh5SDNxZnl6V05qOGNPd0d0OW1LSnVRaitBTGVGL01UbEpv?=
 =?utf-8?B?clByQnIxWXlrMkhxOFhBRURHYXhhMVR3cHFhUjdDV0RYcU01MEJNSnZYNTRF?=
 =?utf-8?B?djVDMlNaR3JwQU9jNVNyWjBGa0I5Y1JjQW5NRWsxaDExUUtaQUl0Z1d1b29p?=
 =?utf-8?B?Q3VKK1U5U3k2OVRMVHpyelZEbS9FV01vOHFEbEZvRzVQdFdiRkgwamhFeERY?=
 =?utf-8?B?Q1pZUThQd3JHSkw4d1RmMGFPNTlYWTAveWhDSEpvamZ3eitCOGpXQ1A5emRp?=
 =?utf-8?B?RjBKL0RsR3JNblhzRDBORHRVdHBVNE5pUEZ5dGk4RlIwd1RyZzNnNU14dDl5?=
 =?utf-8?B?R0k1cjE3Q1IwRVppYWJZc0VNZXlGRkdTdnJOWWxPVXB5RDZXbWxoSDBDUWNx?=
 =?utf-8?B?VGx6c0c1Q1MzOVA2QitRM3d3Z2NlT1hPZ1UwSUxMOUsvZkpvcDc5bDRvOGZE?=
 =?utf-8?B?WU0zVE1vaXBtbmRzK0VleGl3aythcko1YmI3MDZkNGFtWDZTc2tXY29ZQzVU?=
 =?utf-8?B?eSt6blprR3dxd05DSHJoNEczeFdBSnJOeDREQVNidHNmUk5idVZxVno0eFE0?=
 =?utf-8?B?czJnLzZmNVBHb0l1NHRBaXgvTDNIU0FZczFvOURFRENreThNK2pZcWlzMHEw?=
 =?utf-8?B?cU9BRzBZZjF4T0Y1S0gvT1BRM01oUlFkYzNvTnVHNHkzWkh0V1RGUm8weExQ?=
 =?utf-8?B?dnk2VDQyUWUvaFhKWE5Cc2J3M2dTNjZ6ZVZHQkg0U2RGNUk0U1NzbWF0cXNK?=
 =?utf-8?B?V1dBRVVuOE8rM0F0eWFkNms3RkhEVm5JdEl5Z1JzRS9kd1U4S3AwUXkzZHNP?=
 =?utf-8?B?cFROVUlWT05mQmM0U2JNN3NQQjBUMDZWZURsSUJnY1JxV2ZuUEVHQkhEYmM3?=
 =?utf-8?B?MlRFRldIK0p0VTllWnlFc0MxMXhZUGZZUUtXWEdiMXJYRmUySXVrVTNCb0F5?=
 =?utf-8?B?UjN0UHdrcVZDcXF2NHBLL2FYeTRNK2NvMHc3eTJSak1kWjVQUitmSEw0MkE5?=
 =?utf-8?B?MUg3TFdqVDN3TDQ3dUgvVnBLOUZnSVoyWVl1NWZIZHROTTcyM3NKbmVhbU1G?=
 =?utf-8?B?Q3hoeUhUVWZPNUYvNDRtY1MwV1ptaHh1bjJuQkJqWjd1SGhIZHhLdlV1SEV6?=
 =?utf-8?Q?pbXQE84FoYP5CjEHlQf1ziI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUJ1QWhjalVRNGNIL0FnYWxCU3U3RE84S3ZNZXFBbmhQby9ZbW5OWi9hcDcx?=
 =?utf-8?B?YUppZnBhdFowdWFqMmJTR29SNWRURWE2ckJUTytsWlVsWkZHSHBSMWxKYVNh?=
 =?utf-8?B?Y25FQ0YxczBVRjVVT29CRUZXVzJPNWZOanJnQ3lZTnUzaHZ4Y00xV2EwNUJm?=
 =?utf-8?B?YTV6UlFYWWF1SWtHRFovS1ZmWWpINiswOG00NURPRk5nUndFdGRuVGVmREtz?=
 =?utf-8?B?Y1dVMU1VeUo0Wk9CQjc5cmhRMytjcVFrNVVaaVJkWEdTYWR5N0V0UGR3UE05?=
 =?utf-8?B?Uk9Nci9PM3VhQk5HejlSdFd0UnlxaWs1RjR2Y3dGTGQ4ZGxTSVZFQytDbHhR?=
 =?utf-8?B?MzNIRjV1UFRzUnEwQ0c5VERxY0NyOHEyYVRqU2ZtZktkNjRKd0NwUE04LzlE?=
 =?utf-8?B?SkFUY1NnbXZDZG5iMTBRNE5OQkxaTURWUTRkWkJUdnduZ1FiN0hRaUxVV1Mx?=
 =?utf-8?B?bDRiQzQ5bzZENFVOZE9nQXB1bnA0K1RrTHlDQlpKaytialNNL1BNeFF4d3hp?=
 =?utf-8?B?WC9qNlhGalpUMGk2U2ZtNlQ2RGwxVDhTeU5FQlJITXhQaHM1SEd6WU9yTzA5?=
 =?utf-8?B?M1kxWG1tcHplZ1h3YUh0SkNCSlZzRXdGb2I5Z0lyMkZ6K3llWjg4UnJmdjBH?=
 =?utf-8?B?QTR0SEVBL3lTYngwdEYxYUQvUDY2WkhLV0JhVEdJWXRNNkRRT1ZDYzA0aTFM?=
 =?utf-8?B?ZElmalptNHpLZHFOd3dXVjhOMmlrQmVSVHp1eVliYzlNMlQ5OTlrZDA2T3c4?=
 =?utf-8?B?MHJMeVg2blJYNUk2SjBVQ1k0NW9CTDZUalZMbEpkSlY4VDlCaTljYlh4VUFF?=
 =?utf-8?B?V2M4QnJYRm51QXI2RHFpc2ppK005SDZVRERUZWMzZnVRRVhSUXgyWHBRSWMw?=
 =?utf-8?B?anZTTmhpbW8zSlQrKzhESWpmQVRreEhJWGZiY3NwT0hOcEpPUjBSeURUZzh4?=
 =?utf-8?B?ckdyNzF3TkY0L0RJVWZCNjdZK1FCVGZVb3lMSEJubm16U3luK21CeG9RcElC?=
 =?utf-8?B?M0lpZnYrNmdNMmQ1ZXdIdEh6aUdIUDRxVHpoVG1GOFdJKy9sUE03a2FjVDln?=
 =?utf-8?B?QzhhUkIxbGpMQ05DcEY5a01TZSsrTkVpcHB4SGVMRGNGQWt6N2tMaWthRkI3?=
 =?utf-8?B?QjlNUXgxc0JDNWxyS2N6OGY5MlRoL1dSVW1xSVJsZFUyUFV0MGJ2M0J2YTRE?=
 =?utf-8?B?ZUV3b2c2UzRPd2hsU2h5TkY2clVQZ3Ztcm9GNjMzU0tXYTFHcTBxNFV2L2k4?=
 =?utf-8?B?WkFOQ0ZhSnpHMnYrZHJGQy9EUFNQL1BGRkxndiszYVJ6WEZzTnVpczhMNEls?=
 =?utf-8?B?UVFob25vV3RjODk4Vi9pRFdyUVRXa1V4R3FmMGtHY3RUcmx2VHNHUm4vVG5T?=
 =?utf-8?B?QVUzVWM3V21Nd1k1dG9Kcm1xMnBOdUlhb1UzallYbVFUUjB2Vm1OY0IvaTJk?=
 =?utf-8?B?RzZOOGlacWthd1pDV2xjL3JBSHNyQ0VJdUt0Y28zYnFBYmhQLzV0R0NjWWRy?=
 =?utf-8?B?TCszYkhKUjJQaURpRFJ4YTRJUlNxUFI5SU1OVzVYcHg1a0t4c0prU2Z2MFI5?=
 =?utf-8?B?cjg5ajUzME9zS3dmYWZHV2xQVW1tNWo2cUlKay9obXZ6MnpRdDVwYWUzcjlx?=
 =?utf-8?B?Sjd6Q2lHTm9US21QS1VyNUM1ZmpBT0RFYzE4TmJIb3c1KzJtR0Rwdzl2N3ZQ?=
 =?utf-8?B?MzFiRDMzSjdMS1QrMjBpbWErK1hFNlJ0NWFDYWs2TVJXVWNMaG95WnNDMDdx?=
 =?utf-8?B?eCtUMjRzNHBsZm1YNkRZak8zVGZyUnpSREpoTnN5QjhBWk5iVVJ1RkRNV1Yy?=
 =?utf-8?B?bmlUMUcvWjVzUHlLSFgzTTBzWG5FSzFLZXlaSm81anZ4R1FhYnIyL0tsZGxy?=
 =?utf-8?B?bVBLdDl4cTFlYjRmK3lNSm1PcDI2RisrbzZGbzh0SGVHeDBkMkk3Qm8yczVt?=
 =?utf-8?B?RTZ5TERFRHpGYWxLY1NMeG81WTV1VVNrYUpkbEdLemorZUVBZEgvTzRwZDVQ?=
 =?utf-8?B?N0hXZHhRMU1CTlhWSnRZeTRFdWdnOWhBdEV1L1VUbTZnVElLZTlDWWZYSVNz?=
 =?utf-8?B?QTRhYWcrYzNuVXB6SU1yV0lrOXNpanUzVy9xUXpFMXZKWEhUSGtZWXBsT0sw?=
 =?utf-8?B?YUpjUUN6QjRrK2w5bU9tWm1NNUluM1lkbUJsUURHREV0OUU4Ulh1bmpsdFRx?=
 =?utf-8?B?YkZJdmFXdFRqVlhENW0weUl1cVpNNm4xdEVzRjRZMGNTK1A2UjFhYWpCYnlY?=
 =?utf-8?B?ZUhqL3JUb0FZdUU0NitUN1E4K01SeC9mQitlazMvdWRMSG1vV3IvR2ZHaDM2?=
 =?utf-8?B?ejBXMTQ3TDlxbXFyOTc5WGF4QlJGME5EWGZWTklDeURtOEFSeGQ5UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e619d1c3-c547-4a5e-d69a-08de54065ede
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2026 07:19:07.0973 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4j0BKD70CjzGRNdrp1hTD9so+p0kKGutOuw7RBJWXIR8A/YzjNoIPjUNU/jLkaH2SbYvW1FcgUOyzswVamTsCeZsBnHNBYaUrWjls5m7qcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7974
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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
Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgSmFudWFyeSAxNSwgMjAyNiAzOjE1IFBN
DQo+IFRvOiBLYW5lIENoZW4gPGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNvbT47IFBldGVyIE1heWRl
bGwNCj4gPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz47IFN0ZXZlbiBMZWUgPHN0ZXZlbl9sZWVA
YXNwZWVkdGVjaC5jb20+OyBUcm95DQo+IExlZSA8bGVldHJveUBnbWFpbC5jb20+OyBKYW1pbiBM
aW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT47IEFuZHJldw0KPiBKZWZmZXJ5IDxhbmRyZXdA
Y29kZWNvbnN0cnVjdC5jb20uYXU+OyBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1PjsNCj4g
b3BlbiBsaXN0OkFTUEVFRCBCTUNzIDxxZW11LWFybUBub25nbnUub3JnPjsgb3BlbiBsaXN0OkFs
bCBwYXRjaGVzIENDDQo+IGhlcmUgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gQ2M6IFRyb3kg
TGVlIDx0cm95X2xlZUBhc3BlZWR0ZWNoLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAx
LzFdIGh3L2kyYy9hc3BlZWQ6IEludHJvZHVjZSAnYnVzLWxhYmVsJyB0byBjdXN0b21pemUNCj4g
YnVzIG5hbWluZw0KPiANCj4gT24gMS8xMi8yNiAwOTozMCwgS2FuZSBDaGVuIHZpYSB3cm90ZToN
Cj4gPiBGcm9tOiBLYW5lLUNoZW4tQVMgPGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPg0K
PiA+IE9uIHNvbWUgQXNwZWVkLWJhc2VkIG1hY2hpbmVzLCBtdWx0aXBsZSBJMkMgY29udHJvbGxl
cnMgbWF5IGV4aXN0DQo+ID4gYWNyb3NzIGRpZmZlcmVudCBjb21wb25lbnRzLCBzdWNoIGFzIHRo
ZSBwcmltYXJ5IFNvQyBhbmQgYW4gZXh0ZXJuYWwNCj4gPiBJTyBleHBhbmRlciBvciBjby1wcm9j
ZXNzb3IgKGUuZy4sIEFTVDE3MDApLiBVc2luZyB0aGUgY3VycmVudCBzdGF0aWMNCj4gPiBuYW1p
bmcgY29udmVudGlvbiByZXN1bHRzIGluIG9iamVjdCBuYW1lIGNvbmZsaWN0cyB3aGVuIG11bHRp
cGxlDQo+ID4gY29udHJvbGxlcnMgYXR0ZW1wdCB0byBpbnN0YW50aWF0ZSBidXNlcyB3aXRoIHRo
ZSBzYW1lIElELg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBpbnRyb2R1Y2VzIGEgJ2J1cy1sYWJlbCcg
cHJvcGVydHkgZm9yIHRoZSBBc3BlZWQgSTJDDQo+ID4gY29udHJvbGxlci4gVGhpcyBhbGxvd3Mg
aGlnaGVyLWxldmVsIGxheWVycywgc3VjaCBhcyB0aGUgU29DIHJlYWxpemUNCj4gPiBmdW5jdGlv
biwgdG8gcHJvdmlkZSBhIHVuaXF1ZSBpZGVudGlmaWVyIGZvciB0aGUgYnVzZXMuIFRoZSBJMkMg
YnVzDQo+ID4gb2JqZWN0IG5hbWUgaXMgdGhlbiBjb25zdHJ1Y3RlZCB1c2luZyB0aGlzIGxhYmVs
IChlLmcuLCAiaW9leHAwLjAiDQo+ID4gaW5zdGVhZCBvZiB0aGUgZGVmYXVsdCAiYXNwZWVkLmky
Yy5idXMuMCIpLg0KPiA+DQo+ID4gVGhpcyBlbmhhbmNlbWVudCBlbnN1cmVzIHVuaXF1ZSBidXMg
aWRlbnRpZmllcnMgYWNyb3NzIHRoZSBzeXN0ZW0gYW5kDQo+ID4gcmVzb2x2ZXMgbmFtaW5nIGNv
bmZsaWN0cyBpbiBtdWx0aS1jb250cm9sbGVyIGNvbmZpZ3VyYXRpb25zLg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogS2FuZS1DaGVuLUFTIDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+DQo+IA0K
PiBSZXZpZXdlZC1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPiANCj4g
VGhhbmtzLA0KPiANCj4gQy4NCkhpIEPDqWRyaWMsDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcu
DQoNCkJlc3QgUmVnYXJkcywNCkthbmUNCj4gDQo+ID4gLS0tDQo+ID4gICBpbmNsdWRlL2h3L2ky
Yy9hc3BlZWRfaTJjLmggfCAgMiArKw0KPiA+ICAgaHcvaTJjL2FzcGVlZF9pMmMuYyAgICAgICAg
IHwgMjcgKysrKysrKysrKysrKysrKysrKysrLS0tLS0tDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQs
IDIzIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9ody9pMmMvYXNwZWVkX2kyYy5oIGIvaW5jbHVkZS9ody9pMmMvYXNwZWVkX2kyYy5o
DQo+ID4gaW5kZXggZmZjZmYyNTgwZi4uNjhiZDEzODAyNiAxMDA2NDQNCj4gPiAtLS0gYS9pbmNs
dWRlL2h3L2kyYy9hc3BlZWRfaTJjLmgNCj4gPiArKysgYi9pbmNsdWRlL2h3L2kyYy9hc3BlZWRf
aTJjLmgNCj4gPiBAQCAtMjUyLDYgKzI1Miw3IEBAIHN0cnVjdCBBc3BlZWRJMkNCdXMgew0KPiA+
ICAgICAgIE1lbW9yeVJlZ2lvbiBtcl9wb29sOw0KPiA+DQo+ID4gICAgICAgSTJDQnVzICpidXM7
DQo+ID4gKyAgICBjaGFyICpuYW1lOw0KPiA+ICAgICAgIHVpbnQ4X3QgaWQ7DQo+ID4gICAgICAg
cWVtdV9pcnEgaXJxOw0KPiA+DQo+ID4gQEAgLTI2OSw2ICsyNzAsNyBAQCBzdHJ1Y3QgQXNwZWVk
STJDU3RhdGUgew0KPiA+ICAgICAgIHVpbnQzMl90IGludHJfc3RhdHVzOw0KPiA+ICAgICAgIHVp
bnQzMl90IGN0cmxfZ2xvYmFsOw0KPiA+ICAgICAgIHVpbnQzMl90IG5ld19jbGtfZGl2aWRlcjsN
Cj4gPiArICAgIGNoYXIgKmJ1c19sYWJlbDsNCj4gPiAgICAgICBNZW1vcnlSZWdpb24gcG9vbF9p
b21lbTsNCj4gPiAgICAgICB1aW50OF90IHNoYXJlX3Bvb2xbQVNQRUVEX0kyQ19TSEFSRV9QT09M
X1NJWkVdOw0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L2kyYy9hc3BlZWRfaTJjLmMgYi9ody9p
MmMvYXNwZWVkX2kyYy5jIGluZGV4DQo+ID4gMWI4YWM1NjFjMy4uN2NmOTI0MjNjNyAxMDA2NDQN
Cj4gPiAtLS0gYS9ody9pMmMvYXNwZWVkX2kyYy5jDQo+ID4gKysrIGIvaHcvaTJjL2FzcGVlZF9p
MmMuYw0KPiA+IEBAIC0xMjE1LDkgKzEyMTUsMTYgQEAgc3RhdGljIHZvaWQgYXNwZWVkX2kyY19y
ZWFsaXplKERldmljZVN0YXRlICpkZXYsDQo+IEVycm9yICoqZXJycCkNCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgImFzcGVlZC5pMmMiLCBhaWMtPm1lbV9zaXplKTsNCj4gPiAgICAg
ICBzeXNidXNfaW5pdF9tbWlvKHNiZCwgJnMtPmlvbWVtKTsNCj4gPg0KPiA+ICsgICAgLyogZGVm
YXVsdCB2YWx1ZSAqLw0KPiA+ICsgICAgaWYgKCFzLT5idXNfbGFiZWwpIHsNCj4gPiArICAgICAg
ICBzLT5idXNfbGFiZWwgPSBnX3N0cmR1cChUWVBFX0FTUEVFRF9JMkNfQlVTKTsNCj4gPiArICAg
IH0NCj4gPiArDQo+ID4gICAgICAgZm9yIChpID0gMDsgaSA8IGFpYy0+bnVtX2J1c3NlczsgaSsr
KSB7DQo+ID4gICAgICAgICAgIE9iamVjdCAqYnVzID0gT0JKRUNUKCZzLT5idXNzZXNbaV0pOw0K
PiA+ICAgICAgICAgICBpbnQgb2Zmc2V0ID0gaSA8IGFpYy0+Z2FwID8gMSA6IDU7DQo+ID4gKyAg
ICAgICAgZ19hdXRvZnJlZSBjaGFyICpuYW1lID0gZ19zdHJkdXBfcHJpbnRmKCIlcy4lZCIsDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHMtPmJ1
c19sYWJlbCwNCj4gaSk7DQo+ID4NCj4gPiAgICAgICAgICAgaWYgKCFvYmplY3RfcHJvcGVydHlf
c2V0X2xpbmsoYnVzLCAiY29udHJvbGxlciIsIE9CSkVDVChzKSwgZXJycCkpDQo+IHsNCj4gPiAg
ICAgICAgICAgICAgIHJldHVybjsNCj4gPiBAQCAtMTIyNyw2ICsxMjM0LDEwIEBAIHN0YXRpYyB2
b2lkIGFzcGVlZF9pMmNfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LA0KPiBFcnJvciAqKmVycnAp
DQo+ID4gICAgICAgICAgICAgICByZXR1cm47DQo+ID4gICAgICAgICAgIH0NCj4gPg0KPiA+ICsg
ICAgICAgIGlmICghb2JqZWN0X3Byb3BlcnR5X3NldF9zdHIoYnVzLCAiYnVzLW5hbWUiLCBuYW1l
LCBlcnJwKSkgew0KPiA+ICsgICAgICAgICAgICByZXR1cm47DQo+ID4gKyAgICAgICAgfQ0KPiA+
ICsNCj4gPiAgICAgICAgICAgaWYgKCFzeXNidXNfcmVhbGl6ZShTWVNfQlVTX0RFVklDRShidXMp
LCBlcnJwKSkgew0KPiA+ICAgICAgICAgICAgICAgcmV0dXJuOw0KPiA+ICAgICAgICAgICB9DQo+
ID4gQEAgLTEyNjMsNiArMTI3NCw3IEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9pMmNfcmVhbGl6ZShE
ZXZpY2VTdGF0ZSAqZGV2LA0KPiBFcnJvciAqKmVycnApDQo+ID4gICBzdGF0aWMgY29uc3QgUHJv
cGVydHkgYXNwZWVkX2kyY19wcm9wZXJ0aWVzW10gPSB7DQo+ID4gICAgICAgREVGSU5FX1BST1Bf
TElOSygiZHJhbSIsIEFzcGVlZEkyQ1N0YXRlLCBkcmFtX21yLA0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgVFlQRV9NRU1PUllfUkVHSU9OLCBNZW1vcnlSZWdpb24gKiksDQo+ID4gKyAgICBE
RUZJTkVfUFJPUF9TVFJJTkcoImJ1cy1sYWJlbCIsIEFzcGVlZEkyQ1N0YXRlLCBidXNfbGFiZWwp
LA0KPiA+ICAgfTsNCj4gPg0KPiA+ICAgc3RhdGljIHZvaWQgYXNwZWVkX2kyY19jbGFzc19pbml0
KE9iamVjdENsYXNzICprbGFzcywgY29uc3Qgdm9pZA0KPiA+ICpkYXRhKSBAQCAtMTQyMywyNCAr
MTQzNSwyNiBAQCBzdGF0aWMgdm9pZA0KPiBhc3BlZWRfaTJjX2J1c19yZWFsaXplKERldmljZVN0
YXRlICpkZXYsIEVycm9yICoqZXJycCkNCj4gPiAgIHsNCj4gPiAgICAgICBBc3BlZWRJMkNCdXMg
KnMgPSBBU1BFRURfSTJDX0JVUyhkZXYpOw0KPiA+ICAgICAgIEFzcGVlZEkyQ0NsYXNzICphaWM7
DQo+ID4gLSAgICBnX2F1dG9mcmVlIGNoYXIgKm5hbWUgPSBnX3N0cmR1cF9wcmludGYoVFlQRV9B
U1BFRURfSTJDX0JVUw0KPiAiLiVkIiwgcy0+aWQpOw0KPiA+IC0gICAgZ19hdXRvZnJlZSBjaGFy
ICpwb29sX25hbWUgPSBnX3N0cmR1cF9wcmludGYoIiVzLnBvb2wiLCBuYW1lKTsNCj4gPiArICAg
IGdfYXV0b2ZyZWUgY2hhciAqcG9vbF9uYW1lID0gTlVMTDsNCj4gPg0KPiA+IC0gICAgaWYgKCFz
LT5jb250cm9sbGVyKSB7DQo+ID4gLSAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCBUWVBFX0FTUEVF
RF9JMkNfQlVTICI6ICdjb250cm9sbGVyJyBsaW5rIG5vdA0KPiBzZXQiKTsNCj4gPiArICAgIGlm
ICghcy0+Y29udHJvbGxlciB8fCAhcy0+bmFtZSkgew0KPiA+ICsgICAgICAgIGVycm9yX3NldGco
ZXJycCwgVFlQRV9BU1BFRURfSTJDX0JVUw0KPiA+ICsgICAgICAgICAgICAgICAgICAgIjogJ2Nv
bnRyb2xsZXInIG9yICdidXMtbmFtZScgbm90IHNldCIpOw0KPiA+ICAgICAgICAgICByZXR1cm47
DQo+ID4gICAgICAgfQ0KPiA+DQo+ID4gKyAgICBwb29sX25hbWUgPSBnX3N0cmR1cF9wcmludGYo
IiVzLnBvb2wiLCBzLT5uYW1lKTsNCj4gPiArDQo+ID4gICAgICAgYWljID0gQVNQRUVEX0kyQ19H
RVRfQ0xBU1Mocy0+Y29udHJvbGxlcik7DQo+ID4NCj4gPiAgICAgICBzeXNidXNfaW5pdF9pcnEo
U1lTX0JVU19ERVZJQ0UoZGV2KSwgJnMtPmlycSk7DQo+ID4NCj4gPiAtICAgIHMtPmJ1cyA9IGky
Y19pbml0X2J1cyhkZXYsIG5hbWUpOw0KPiA+ICsgICAgcy0+YnVzID0gaTJjX2luaXRfYnVzKGRl
diwgcy0+bmFtZSk7DQo+ID4gICAgICAgcy0+c2xhdmUgPSBpMmNfc2xhdmVfY3JlYXRlX3NpbXBs
ZShzLT5idXMsDQo+IFRZUEVfQVNQRUVEX0kyQ19CVVNfU0xBVkUsDQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAweGZmKTsNCj4gPg0KPiA+ICAgICAgIG1lbW9y
eV9yZWdpb25faW5pdF9pbygmcy0+bXIsIE9CSkVDVChzKSwgJmFzcGVlZF9pMmNfYnVzX29wcywN
Cj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICBzLCBuYW1lLCBhaWMtPnJlZ19zaXplKTsN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICBzLCBzLT5uYW1lLCBhaWMtPnJlZ19zaXpl
KTsNCj4gPiAgICAgICBzeXNidXNfaW5pdF9tbWlvKFNZU19CVVNfREVWSUNFKGRldiksICZzLT5t
cik7DQo+ID4NCj4gPiAgICAgICBtZW1vcnlfcmVnaW9uX2luaXRfaW8oJnMtPm1yX3Bvb2wsIE9C
SkVDVChzKSwNCj4gPiAmYXNwZWVkX2kyY19idXNfcG9vbF9vcHMsIEBAIC0xNDUyLDYgKzE0NjYs
NyBAQCBzdGF0aWMgY29uc3QgUHJvcGVydHkNCj4gYXNwZWVkX2kyY19idXNfcHJvcGVydGllc1td
ID0gew0KPiA+ICAgICAgIERFRklORV9QUk9QX1VJTlQ4KCJidXMtaWQiLCBBc3BlZWRJMkNCdXMs
IGlkLCAwKSwNCj4gPiAgICAgICBERUZJTkVfUFJPUF9MSU5LKCJjb250cm9sbGVyIiwgQXNwZWVk
STJDQnVzLCBjb250cm9sbGVyLA0KPiBUWVBFX0FTUEVFRF9JMkMsDQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICBBc3BlZWRJMkNTdGF0ZSAqKSwNCj4gPiArICAgIERFRklORV9QUk9QX1NUUklO
RygiYnVzLW5hbWUiLCBBc3BlZWRJMkNCdXMsIG5hbWUpLA0KPiA+ICAgfTsNCj4gPg0KPiA+ICAg
c3RhdGljIHZvaWQgYXNwZWVkX2kyY19idXNfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqa2xhc3Ms
IGNvbnN0IHZvaWQNCj4gPiAqZGF0YSkNCg0KDQo=

